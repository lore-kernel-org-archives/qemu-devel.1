Received: from eggs.gnu.org ([2001:4830:134:3::10]:59931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFJQL-0004tI-KP
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFJQK-0001rL-2P
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:13 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:49897 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gFJQI-0001m8-80
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:11 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 24 Oct 2018 15:40:27 +0200
Message-Id: <1540388447-27062-14-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540388447-27062-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540388447-27062-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 13/33] target/mips: Add a placeholder for
 R5900 MMI1 instruction subclass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Fredrik Noring <noring@nocrew.org>

Add a placeholder for MM1 subclass.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 1a9e43b..07e33e0 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24459,6 +24459,38 @@ static void decode_tx79_mmi0(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+static void decode_tx79_mmi1(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint32_t opc = MASK_TX79_MMI1(ctx->opcode);
+
+    switch (opc) {
+    case TX79_MMI1_PABSW:     /* TODO: TX79_MMI1_PABSW */
+    case TX79_MMI1_PCEQW:     /* TODO: TX79_MMI1_PCEQW */
+    case TX79_MMI1_PMINW:     /* TODO: TX79_MMI1_PMINW */
+    case TX79_MMI1_PADSBH:    /* TODO: TX79_MMI1_PADSBH */
+    case TX79_MMI1_PABSH:     /* TODO: TX79_MMI1_PABSH */
+    case TX79_MMI1_PCEQH:     /* TODO: TX79_MMI1_PCEQH */
+    case TX79_MMI1_PMINH:     /* TODO: TX79_MMI1_PMINH */
+    case TX79_MMI1_PCEQB:     /* TODO: TX79_MMI1_PCEQB */
+    case TX79_MMI1_PADDUW:    /* TODO: TX79_MMI1_PADDUW */
+    case TX79_MMI1_PSUBUW:    /* TODO: TX79_MMI1_PSUBUW */
+    case TX79_MMI1_PEXTUW:    /* TODO: TX79_MMI1_PEXTUW */
+    case TX79_MMI1_PADDUH:    /* TODO: TX79_MMI1_PADDUH */
+    case TX79_MMI1_PSUBUH:    /* TODO: TX79_MMI1_PSUBUH */
+    case TX79_MMI1_PEXTUH:    /* TODO: TX79_MMI1_PEXTUH */
+    case TX79_MMI1_PADDUB:    /* TODO: TX79_MMI1_PADDUB */
+    case TX79_MMI1_PSUBUB:    /* TODO: TX79_MMI1_PSUBUB */
+    case TX79_MMI1_PEXTUB:    /* TODO: TX79_MMI1_PEXTUB */
+    case TX79_MMI1_QFSRV:     /* TODO: TX79_MMI1_QFSRV */
+        generate_exception_end(ctx, EXCP_RI); /* TODO: TX79_MMI_CLASS_MMI1 */
+        break;
+    default:
+        MIPS_INVAL("TX79 MMI class MMI1");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
 static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t opc = MASK_TX79_MMI(ctx->opcode);
@@ -24467,6 +24499,9 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
     case TX79_MMI_CLASS_MMI0:
         decode_tx79_mmi0(env, ctx);
         break;
+    case TX79_MMI_CLASS_MMI1:
+        decode_tx79_mmi1(env, ctx);
+        break;
     case TX79_MMI_MADD:          /* TODO: TX79_MMI_MADD */
     case TX79_MMI_MADDU:         /* TODO: TX79_MMI_MADDU */
     case TX79_MMI_PLZCW:         /* TODO: TX79_MMI_PLZCW */
@@ -24481,7 +24516,6 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
     case TX79_MMI_DIVU1:         /* TODO: TX79_MMI_DIVU1 */
     case TX79_MMI_MADD1:         /* TODO: TX79_MMI_MADD1 */
     case TX79_MMI_MADDU1:        /* TODO: TX79_MMI_MADDU1 */
-    case TX79_MMI_CLASS_MMI1:    /* TODO: TX79_MMI_CLASS_MMI1 */
     case TX79_MMI_CLASS_MMI3:    /* TODO: TX79_MMI_CLASS_MMI3 */
     case TX79_MMI_PMFHL:         /* TODO: TX79_MMI_PMFHL */
     case TX79_MMI_PMTHL:         /* TODO: TX79_MMI_PMTHL */
-- 
2.7.4
