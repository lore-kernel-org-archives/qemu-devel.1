Received: from eggs.gnu.org ([2001:4830:134:3::10]:46023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmp-0000Bf-Iw
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmk-00089g-4P
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:23 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33379 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEZmj-00083q-L1
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:17 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 22 Oct 2018 14:57:36 +0200
Message-Id: <1540213077-15211-14-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 13/34] target/mips: Placeholder for R5900 MMI0
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

Add a placeholder for MMI0 subclass.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 6cb6966..1a9e43b 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24420,15 +24420,56 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+static void decode_tx79_mmi0(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint32_t opc = MASK_TX79_MMI0(ctx->opcode);
+
+    switch (opc) {
+    case TX79_MMI0_PADDW:     /* TODO: TX79_MMI0_PADDW */
+    case TX79_MMI0_PSUBW:     /* TODO: TX79_MMI0_PSUBW */
+    case TX79_MMI0_PCGTW:     /* TODO: TX79_MMI0_PCGTW */
+    case TX79_MMI0_PMAXW:     /* TODO: TX79_MMI0_PMAXW */
+    case TX79_MMI0_PADDH:     /* TODO: TX79_MMI0_PADDH */
+    case TX79_MMI0_PSUBH:     /* TODO: TX79_MMI0_PSUBH */
+    case TX79_MMI0_PCGTH:     /* TODO: TX79_MMI0_PCGTH */
+    case TX79_MMI0_PMAXH:     /* TODO: TX79_MMI0_PMAXH */
+    case TX79_MMI0_PADDB:     /* TODO: TX79_MMI0_PADDB */
+    case TX79_MMI0_PSUBB:     /* TODO: TX79_MMI0_PSUBB */
+    case TX79_MMI0_PCGTB:     /* TODO: TX79_MMI0_PCGTB */
+    case TX79_MMI0_PADDSW:    /* TODO: TX79_MMI0_PADDSW */
+    case TX79_MMI0_PSUBSW:    /* TODO: TX79_MMI0_PSUBSW */
+    case TX79_MMI0_PEXTLW:    /* TODO: TX79_MMI0_PEXTLW */
+    case TX79_MMI0_PPACW:     /* TODO: TX79_MMI0_PPACW */
+    case TX79_MMI0_PADDSH:    /* TODO: TX79_MMI0_PADDSH */
+    case TX79_MMI0_PSUBSH:    /* TODO: TX79_MMI0_PSUBSH */
+    case TX79_MMI0_PEXTLH:    /* TODO: TX79_MMI0_PEXTLH */
+    case TX79_MMI0_PPACH:     /* TODO: TX79_MMI0_PPACH */
+    case TX79_MMI0_PADDSB:    /* TODO: TX79_MMI0_PADDSB */
+    case TX79_MMI0_PSUBSB:    /* TODO: TX79_MMI0_PSUBSB */
+    case TX79_MMI0_PEXTLB:    /* TODO: TX79_MMI0_PEXTLB */
+    case TX79_MMI0_PPACB:     /* TODO: TX79_MMI0_PPACB */
+    case TX79_MMI0_PEXT5:     /* TODO: TX79_MMI0_PEXT5 */
+    case TX79_MMI0_PPAC5:     /* TODO: TX79_MMI0_PPAC5 */
+        generate_exception_end(ctx, EXCP_RI); /* TODO: TX79_MMI_CLASS_MMI0 */
+        break;
+    default:
+        MIPS_INVAL("TX79 MMI class MMI0");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
 static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t opc = MASK_TX79_MMI(ctx->opcode);
 
     switch (opc) {
+    case TX79_MMI_CLASS_MMI0:
+        decode_tx79_mmi0(env, ctx);
+        break;
     case TX79_MMI_MADD:          /* TODO: TX79_MMI_MADD */
     case TX79_MMI_MADDU:         /* TODO: TX79_MMI_MADDU */
     case TX79_MMI_PLZCW:         /* TODO: TX79_MMI_PLZCW */
-    case TX79_MMI_CLASS_MMI0:    /* TODO: TX79_MMI_CLASS_MMI0 */
     case TX79_MMI_CLASS_MMI2:    /* TODO: TX79_MMI_CLASS_MMI2 */
     case TX79_MMI_MFHI1:         /* TODO: TX79_MMI_MFHI1 */
     case TX79_MMI_MTHI1:         /* TODO: TX79_MMI_MTHI1 */
-- 
2.7.4
