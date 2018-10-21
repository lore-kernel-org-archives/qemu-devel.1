Received: from eggs.gnu.org ([2001:4830:134:3::10]:45786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFnF-0002Fo-AV
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:37:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFn7-00036p-Ce
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:37:27 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:40751)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFn7-00031B-02
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:37:21 -0400
Date: Sun, 21 Oct 2018 17:37:06 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <6a5d1538f90e12c97feac0708fac75e377685f00.1540134918.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v8 15/38] target/mips: Placeholder for R5900
 MMI2 instruction subclass
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
 target/mips/translate.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 28137cdaf4..e5ac9f17e0 100644
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
2.18.1
