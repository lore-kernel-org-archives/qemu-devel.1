Received: from eggs.gnu.org ([2001:4830:134:3::10]:33421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4uF-0001Sc-Aj
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4uD-0005tP-Ji
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:23 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:41347)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gW4uD-00054a-7l
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:21 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Dec 2018 14:37:35 -0500
Message-Id: <20181209193749.12277-25-cota@braap.org>
In-Reply-To: <20181209193749.12277-1-cota@braap.org>
References: <20181209193749.12277-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v2 24/38] target/sh4: fetch code with
 translator_ld (WIP)
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

XXX: cleanly get the gUSA instructions

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/sh4/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index ab254b0e8d..1704ce8dae 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -2331,7 +2331,7 @@ static void sh4_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     }
 #endif
 
-    ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
+    ctx->opcode = translator_lduw(env, ctx->base.pc_next);
     decode_opc(ctx);
     ctx->base.pc_next += 2;
 }
-- 
2.17.1
