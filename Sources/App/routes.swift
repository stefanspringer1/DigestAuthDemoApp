import Vapor
import DigestAuth

func routes(_ app: Application) throws {
    app.get("demoAuthClient") { req async -> String in
        let user = "UltimateQuestionOfLifeTheUniverseAndEverything"
        let pw = "42"
        let uri = URI("https://httpbin.org/digest-auth/auth/\(user)/\(pw)")
        let result = await makeDigestQuery(app: app,
                                           request: req,
                                           uri: uri,
                                           user: user,
                                           pw: pw)
        return result
    }
    
    app.get("demoAuthServer") { req  async throws -> Response in
        try await   (req: req, userPassword: {user in
            if user == "UltimateQuestionOfLifeTheUniverseAndEverything"{
                return "42"
            } else {
                return nil
            }
        }, responder: {req  async throws -> Response in
            return try await "valid authentification".encodeResponse(for: req)}
        )
    }
}
