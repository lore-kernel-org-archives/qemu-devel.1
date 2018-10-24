Received: from eggs.gnu.org ([2001:4830:134:3::10]:60005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFJQO-0004wZ-WA
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFJQJ-0001qv-Tn
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:16 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:49894 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gFJQI-0001m1-0F
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:10 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 24 Oct 2018 15:40:25 +0200
Message-Id: <1540388447-27062-12-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540388447-27062-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540388447-27062-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 11/33] target/mips: Add a placeholder for
 R5900 MMI instruction class
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

Add a placeholder for MMI class. This is the main palceholder for
MMI ASE.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 2318116..6cb6966 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24420,6 +24420,45 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint32_t opc = MASK_TX79_MMI(ctx->opcode);
+
+    switch (opc) {
+    case TX79_MMI_MADD:          /* TODO: TX79_MMI_MADD */
+    case TX79_MMI_MADDU:         /* TODO: TX79_MMI_MADDU */
+    case TX79_MMI_PLZCW:         /* TODO: TX79_MMI_PLZCW */
+    case TX79_MMI_CLASS_MMI0:    /* TODO: TX79_MMI_CLASS_MMI0 */
+    case TX79_MMI_CLASS_MMI2:    /* TODO: TX79_MMI_CLASS_MMI2 */
+    case TX79_MMI_MFHI1:         /* TODO: TX79_MMI_MFHI1 */
+    case TX79_MMI_MTHI1:         /* TODO: TX79_MMI_MTHI1 */
+    case TX79_MMI_MFLO1:         /* TODO: TX79_MMI_MFLO1 */
+    case TX79_MMI_MTLO1:         /* TODO: TX79_MMI_MTLO1 */
+    case TX79_MMI_MULT1:         /* TODO: TX79_MMI_MULT1 */
+    case TX79_MMI_MULTU1:        /* TODO: TX79_MMI_MULTU1 */
+    case TX79_MMI_DIV1:          /* TODO: TX79_MMI_DIV1 */
+    case TX79_MMI_DIVU1:         /* TODO: TX79_MMI_DIVU1 */
+    case TX79_MMI_MADD1:         /* TODO: TX79_MMI_MADD1 */
+    case TX79_MMI_MADDU1:        /* TODO: TX79_MMI_MADDU1 */
+    case TX79_MMI_CLASS_MMI1:    /* TODO: TX79_MMI_CLASS_MMI1 */
+    case TX79_MMI_CLASS_MMI3:    /* TODO: TX79_MMI_CLASS_MMI3 */
+    case TX79_MMI_PMFHL:         /* TODO: TX79_MMI_PMFHL */
+    case TX79_MMI_PMTHL:         /* TODO: TX79_MMI_PMTHL */
+    case TX79_MMI_PSLLH:         /* TODO: TX79_MMI_PSLLH */
+    case TX79_MMI_PSRLH:         /* TODO: TX79_MMI_PSRLH */
+    case TX79_MMI_PSRAH:         /* TODO: TX79_MMI_PSRAH */
+    case TX79_MMI_PSLLW:         /* TODO: TX79_MMI_PSLLW */
+    case TX79_MMI_PSRLW:         /* TODO: TX79_MMI_PSRLW */
+    case TX79_MMI_PSRAW:         /* TODO: TX79_MMI_PSRAW */
+        generate_exception_end(ctx, EXCP_RI);    /* TODO: TX79_CLASS_MMI */
+        break;
+    default:
+        MIPS_INVAL("TX79 MMI class");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
 static void decode_tx79_lq(CPUMIPSState *env, DisasContext *ctx)
 {
     generate_exception_end(ctx, EXCP_RI);    /* TODO: TX79_LQ */
@@ -25769,7 +25808,11 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         decode_opc_special(env, ctx);
         break;
     case OPC_SPECIAL2:
-        decode_opc_special2_legacy(env, ctx);
+        if ((ctx->insn_flags & INSN_R5900) && (ctx->insn_flags & ASE_MMI)) {
+            decode_tx79_mmi(env, ctx);
+        } else {
+            decode_opc_special2_legacy(env, ctx);
+        }
         break;
     case OPC_SPECIAL3:
         if (ctx->insn_flags & INSN_R5900) {
-- 
2.7.4
