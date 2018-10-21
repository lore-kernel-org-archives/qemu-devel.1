Received: from eggs.gnu.org ([2001:4830:134:3::10]:45109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFk6-0008J0-10
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFk2-0001ft-JJ
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:34:13 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:47032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFk2-0001fX-8S
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:34:10 -0400
Date: Sun, 21 Oct 2018 17:34:04 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <d63d5b7d59d73f2f197e64d2a0f96da263eff609.1540134918.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v8 06/38] target/mips: Define R5900 MMI0 opcode
 constants
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
 target/mips/translate.c | 51 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index ae988177a1..242f2df2e2 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2180,6 +2180,57 @@ enum {
     TX79_MMI_PSRAW      = 0x3F | TX79_CLASS_MMI,
 };
 
+/*
+ * TX79 Multimedia Instructions with opcode field = MMI and bits 5..0 = MMI0:
+ *
+ *  31    26                        10     6 5      0
+ * +--------+----------------------+--------+--------+
+ * |   MMI  |                      |function|  MMI0  |
+ * +--------+----------------------+--------+--------+
+ *
+ * function  bits 7..6
+ *     bits |   0   |   1   |   2   |   3
+ *    10..8 |   00  |   01  |   10  |   11
+ *   -------+-------+-------+-------+-------
+ *    0 000 | PADDW | PSUBW | PCGTW | PMAXW
+ *    1 001 | PADDH | PSUBH | PCGTH | PMAXH
+ *    2 010 | PADDB | PSUBB | PCGTB |   *
+ *    3 011 |   *   |   *   |   *   |   *
+ *    4 100 | PADDSW| PSUBSW| PEXTLW| PPACW
+ *    5 101 | PADDSH| PSUBSH| PEXTLH| PPACH
+ *    6 110 | PADDSB| PSUBSB| PEXTLB| PPACB
+ *    7 111 |   *   |   *   | PEXT5 | PPAC5
+ */
+
+#define MASK_TX79_MMI0(op) (MASK_OP_MAJOR(op) | ((op) & 0x7FF))
+enum {
+    TX79_MMI0_PADDW  = (0x00 << 6) | TX79_MMI_CLASS_MMI0,
+    TX79_MMI0_PSUBW  = (0x01 << 6) | TX79_MMI_CLASS_MMI0,
+    TX79_MMI0_PCGTW  = (0x02 << 6) | TX79_MMI_CLASS_MMI0,
+    TX79_MMI0_PMAXW  = (0x03 << 6) | TX79_MMI_CLASS_MMI0,
+    TX79_MMI0_PADDH  = (0x04 << 6) | TX79_MMI_CLASS_MMI0,
+    TX79_MMI0_PSUBH  = (0x05 << 6) | TX79_MMI_CLASS_MMI0,
+    TX79_MMI0_PCGTH  = (0x06 << 6) | TX79_MMI_CLASS_MMI0,
+    TX79_MMI0_PMAXH  = (0x07 << 6) | TX79_MMI_CLASS_MMI0,
+    TX79_MMI0_PADDB  = (0x08 << 6) | TX79_MMI_CLASS_MMI0,
+    TX79_MMI0_PSUBB  = (0x09 << 6) | TX79_MMI_CLASS_MMI0,
+    TX79_MMI0_PCGTB  = (0x0A << 6) | TX79_MMI_CLASS_MMI0,
+    TX79_MMI0_PADDSW = (0x10 << 6) | TX79_MMI_CLASS_MMI0,
+    TX79_MMI0_PSUBSW = (0x11 << 6) | TX79_MMI_CLASS_MMI0,
+    TX79_MMI0_PEXTLW = (0x12 << 6) | TX79_MMI_CLASS_MMI0,
+    TX79_MMI0_PPACW  = (0x13 << 6) | TX79_MMI_CLASS_MMI0,
+    TX79_MMI0_PADDSH = (0x14 << 6) | TX79_MMI_CLASS_MMI0,
+    TX79_MMI0_PSUBSH = (0x15 << 6) | TX79_MMI_CLASS_MMI0,
+    TX79_MMI0_PEXTLH = (0x16 << 6) | TX79_MMI_CLASS_MMI0,
+    TX79_MMI0_PPACH  = (0x17 << 6) | TX79_MMI_CLASS_MMI0,
+    TX79_MMI0_PADDSB = (0x18 << 6) | TX79_MMI_CLASS_MMI0,
+    TX79_MMI0_PSUBSB = (0x19 << 6) | TX79_MMI_CLASS_MMI0,
+    TX79_MMI0_PEXTLB = (0x1A << 6) | TX79_MMI_CLASS_MMI0,
+    TX79_MMI0_PPACB  = (0x1B << 6) | TX79_MMI_CLASS_MMI0,
+    TX79_MMI0_PEXT5  = (0x1E << 6) | TX79_MMI_CLASS_MMI0,
+    TX79_MMI0_PPAC5  = (0x1F << 6) | TX79_MMI_CLASS_MMI0,
+};
+
 /* global register indices */
 static TCGv cpu_gpr[32], cpu_PC;
 static TCGv cpu_HI[MIPS_DSP_ACC], cpu_LO[MIPS_DSP_ACC];
-- 
2.18.1
