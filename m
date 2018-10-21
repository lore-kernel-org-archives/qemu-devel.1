Received: from eggs.gnu.org ([2001:4830:134:3::10]:45666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFmc-0001oL-9S
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFmb-0002po-DK
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:36:50 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:40739)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFmb-0002pR-2G
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:36:49 -0400
Date: Sun, 21 Oct 2018 17:36:41 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <3bf7731bbcef6a0ea3c034fae15d4882fe1e78db.1540134918.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v8 13/38] target/mips: Placeholder for R5900
 MMI0 instruction subclass
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
 target/mips/translate.c | 43 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3b100f2d17..c8080844f1 100644
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
2.18.1
