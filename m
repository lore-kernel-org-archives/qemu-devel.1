Received: from eggs.gnu.org ([2001:4830:134:3::10]:45826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFnQ-0002lh-Fz
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:37:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFnN-0003Ck-Ae
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:37:40 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:40765)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFnM-00038K-TK
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:37:37 -0400
Date: Sun, 21 Oct 2018 17:37:18 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <56a752efb9b35adef303c8209e41bc1a6ce92d3c.1540134918.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v8 16/38] target/mips: Placeholder for R5900
 MMI3 instruction subclass
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
 target/mips/translate.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index e5ac9f17e0..6d837082a9 100644
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
2.18.1
