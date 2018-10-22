Received: from eggs.gnu.org ([2001:4830:134:3::10]:46021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmp-0000Bc-Id
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmn-0008B5-Ao
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:23 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33421 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEZmk-00084R-Gi
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:18 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 22 Oct 2018 14:57:39 +0200
Message-Id: <1540213077-15211-17-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 16/34] target/mips: Placeholder for R5900 MMI3
 instruction subclass
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

Add a placeholder for MMI3 subclass.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index cc00429..1c0400c 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24527,6 +24527,33 @@ static void decode_tx79_mmi2(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+static void decode_tx79_mmi3(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint32_t opc = MASK_TX79_MMI3(ctx->opcode);
+
+    switch (opc) {
+    case TX79_MMI3_PMADDUW:    /* TODO: TX79_MMI3_PMADDUW */
+    case TX79_MMI3_PSRAVW:     /* TODO: TX79_MMI3_PSRAVW */
+    case TX79_MMI3_PMTHI:      /* TODO: TX79_MMI3_PMTHI */
+    case TX79_MMI3_PMTLO:      /* TODO: TX79_MMI3_PMTLO */
+    case TX79_MMI3_PINTEH:     /* TODO: TX79_MMI3_PINTEH */
+    case TX79_MMI3_PMULTUW:    /* TODO: TX79_MMI3_PMULTUW */
+    case TX79_MMI3_PDIVUW:     /* TODO: TX79_MMI3_PDIVUW */
+    case TX79_MMI3_PCPYUD:     /* TODO: TX79_MMI3_PCPYUD */
+    case TX79_MMI3_POR:        /* TODO: TX79_MMI3_POR */
+    case TX79_MMI3_PNOR:       /* TODO: TX79_MMI3_PNOR */
+    case TX79_MMI3_PEXCH:      /* TODO: TX79_MMI3_PEXCH */
+    case TX79_MMI3_PCPYH:      /* TODO: TX79_MMI3_PCPYH */
+    case TX79_MMI3_PEXCW:      /* TODO: TX79_MMI3_PEXCW */
+        generate_exception_end(ctx, EXCP_RI); /* TODO: TX79_MMI_CLASS_MMI3 */
+        break;
+    default:
+        MIPS_INVAL("TX79 MMI class MMI3");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
 static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t opc = MASK_TX79_MMI(ctx->opcode);
@@ -24541,6 +24568,9 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
     case TX79_MMI_CLASS_MMI2:
         decode_tx79_mmi2(env, ctx);
         break;
+    case TX79_MMI_CLASS_MMI3:
+        decode_tx79_mmi3(env, ctx);
+        break;
     case TX79_MMI_MADD:          /* TODO: TX79_MMI_MADD */
     case TX79_MMI_MADDU:         /* TODO: TX79_MMI_MADDU */
     case TX79_MMI_PLZCW:         /* TODO: TX79_MMI_PLZCW */
@@ -24554,7 +24584,6 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
     case TX79_MMI_DIVU1:         /* TODO: TX79_MMI_DIVU1 */
     case TX79_MMI_MADD1:         /* TODO: TX79_MMI_MADD1 */
     case TX79_MMI_MADDU1:        /* TODO: TX79_MMI_MADDU1 */
-    case TX79_MMI_CLASS_MMI3:    /* TODO: TX79_MMI_CLASS_MMI3 */
     case TX79_MMI_PMFHL:         /* TODO: TX79_MMI_PMFHL */
     case TX79_MMI_PMTHL:         /* TODO: TX79_MMI_PMTHL */
     case TX79_MMI_PSLLH:         /* TODO: TX79_MMI_PSLLH */
-- 
2.7.4
