Received: from eggs.gnu.org ([2001:4830:134:3::10]:59959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFJQM-0004tr-8n
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFJQK-0001s2-KF
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:13 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:49895 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gFJQK-0001m6-16
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:12 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 24 Oct 2018 15:40:28 +0200
Message-Id: <1540388447-27062-15-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540388447-27062-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540388447-27062-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 14/33] target/mips: Add a placeholder for
 R5900 MMI2 instruction subclass
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

Add a placeholder for MMI2 subclass.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 07e33e0..cc00429 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24491,6 +24491,42 @@ static void decode_tx79_mmi1(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+static void decode_tx79_mmi2(CPUMIPSState *env, DisasContext *ctx)
+{
+    uint32_t opc = MASK_TX79_MMI2(ctx->opcode);
+
+    switch (opc) {
+    case TX79_MMI2_PMADDW:    /* TODO: TX79_MMI2_PMADDW */
+    case TX79_MMI2_PSLLVW:    /* TODO: TX79_MMI2_PSLLVW */
+    case TX79_MMI2_PSRLVW:    /* TODO: TX79_MMI2_PSRLVW */
+    case TX79_MMI2_PMSUBW:    /* TODO: TX79_MMI2_PMSUBW */
+    case TX79_MMI2_PMFHI:     /* TODO: TX79_MMI2_PMFHI */
+    case TX79_MMI2_PMFLO:     /* TODO: TX79_MMI2_PMFLO */
+    case TX79_MMI2_PINTH:     /* TODO: TX79_MMI2_PINTH */
+    case TX79_MMI2_PMULTW:    /* TODO: TX79_MMI2_PMULTW */
+    case TX79_MMI2_PDIVW:     /* TODO: TX79_MMI2_PDIVW */
+    case TX79_MMI2_PCPYLD:    /* TODO: TX79_MMI2_PCPYLD */
+    case TX79_MMI2_PMADDH:    /* TODO: TX79_MMI2_PMADDH */
+    case TX79_MMI2_PHMADH:    /* TODO: TX79_MMI2_PHMADH */
+    case TX79_MMI2_PAND:      /* TODO: TX79_MMI2_PAND */
+    case TX79_MMI2_PXOR:      /* TODO: TX79_MMI2_PXOR */
+    case TX79_MMI2_PMSUBH:    /* TODO: TX79_MMI2_PMSUBH */
+    case TX79_MMI2_PHMSBH:    /* TODO: TX79_MMI2_PHMSBH */
+    case TX79_MMI2_PEXEH:     /* TODO: TX79_MMI2_PEXEH */
+    case TX79_MMI2_PREVH:     /* TODO: TX79_MMI2_PREVH */
+    case TX79_MMI2_PMULTH:    /* TODO: TX79_MMI2_PMULTH */
+    case TX79_MMI2_PDIVBW:    /* TODO: TX79_MMI2_PDIVBW */
+    case TX79_MMI2_PEXEW:     /* TODO: TX79_MMI2_PEXEW */
+    case TX79_MMI2_PROT3W:    /* TODO: TX79_MMI2_PROT3W */
+        generate_exception_end(ctx, EXCP_RI); /* TODO: TX79_MMI_CLASS_MMI2 */
+        break;
+    default:
+        MIPS_INVAL("TX79 MMI class MMI2");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+}
+
 static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t opc = MASK_TX79_MMI(ctx->opcode);
@@ -24502,10 +24538,12 @@ static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
     case TX79_MMI_CLASS_MMI1:
         decode_tx79_mmi1(env, ctx);
         break;
+    case TX79_MMI_CLASS_MMI2:
+        decode_tx79_mmi2(env, ctx);
+        break;
     case TX79_MMI_MADD:          /* TODO: TX79_MMI_MADD */
     case TX79_MMI_MADDU:         /* TODO: TX79_MMI_MADDU */
     case TX79_MMI_PLZCW:         /* TODO: TX79_MMI_PLZCW */
-    case TX79_MMI_CLASS_MMI2:    /* TODO: TX79_MMI_CLASS_MMI2 */
     case TX79_MMI_MFHI1:         /* TODO: TX79_MMI_MFHI1 */
     case TX79_MMI_MTHI1:         /* TODO: TX79_MMI_MTHI1 */
     case TX79_MMI_MFLO1:         /* TODO: TX79_MMI_MFLO1 */
-- 
2.7.4
