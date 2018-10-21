Received: from eggs.gnu.org ([2001:4830:134:3::10]:45735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFms-00020i-Sh
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:37:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFmo-0002xR-Bo
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:37:06 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:35045)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFmn-0002x3-Vv
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:37:02 -0400
Date: Sun, 21 Oct 2018 17:36:54 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <b30e57633f2dd2a10e1104f047945a114c8d7816.1540134918.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v8 14/38] target/mips: Placeholder for R5900
 MMI1 instruction subclass
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
 target/mips/translate.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index c8080844f1..28137cdaf4 100644
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
2.18.1
