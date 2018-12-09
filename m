Received: from eggs.gnu.org ([2001:4830:134:3::10]:33593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4uS-0001bu-2f
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4uN-0006gf-O9
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:35 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:41631)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gW4uN-0005pi-Fw
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:31 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Dec 2018 14:37:39 -0500
Message-Id: <20181209193749.12277-29-cota@braap.org>
In-Reply-To: <20181209193749.12277-1-cota@braap.org>
References: <20181209193749.12277-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v2 28/38] target/alpha: fetch code with
 translator_ld
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/alpha/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 25cd95931d..f8d194994a 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2987,7 +2987,7 @@ static void alpha_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPUAlphaState *env = cpu->env_ptr;
-    uint32_t insn = cpu_ldl_code(env, ctx->base.pc_next);
+    uint32_t insn = translator_ldl(env, ctx->base.pc_next);
 
     ctx->base.pc_next += 4;
     ctx->base.is_jmp = translate_one(ctx, insn);
-- 
2.17.1
