Received: from eggs.gnu.org ([2001:4830:134:3::10]:45591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFmO-0001bE-0F
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFmN-0002iO-3U
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:36:35 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:40709)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFmL-0002gG-0s
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:36:34 -0400
Date: Sun, 21 Oct 2018 17:36:23 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <7e6219b052ef0539b223bc1b41d2f97f0a8f19fd.1540134918.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v8 12/38] target/mips: Placeholder for R5900
 MMI instruction class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 target/mips/translate.c | 45 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 2318116d31..3b100f2d17 100644
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
+        if (ctx->insn_flags & INSN_R5900) {
+            decode_tx79_mmi(env, ctx);
+        } else {
+            decode_opc_special2_legacy(env, ctx);
+        }
         break;
     case OPC_SPECIAL3:
         if (ctx->insn_flags & INSN_R5900) {
-- 
2.18.1
