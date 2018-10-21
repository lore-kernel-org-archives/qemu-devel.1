Received: from eggs.gnu.org ([2001:4830:134:3::10]:45199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFkR-00007w-MP
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:34:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFkP-0001no-Iv
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:34:35 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:47067)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFkL-0001lW-Kc
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:34:31 -0400
Date: Sun, 21 Oct 2018 17:34:11 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <deb6388d70631f0615b7e56535d495839e4ea817.1540134918.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v8 07/38] target/mips: Define R5900 MMI1 opcode
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
 target/mips/translate.c | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 242f2df2e2..e233b87324 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2231,6 +2231,50 @@ enum {
     TX79_MMI0_PPAC5  = (0x1F << 6) | TX79_MMI_CLASS_MMI0,
 };
 
+/*
+ * TX79 Multimedia Instructions with opcode field = MMI and bits 5..0 = MMI1:
+ *
+ *  31    26                        10     6 5      0
+ * +--------+----------------------+--------+--------+
+ * |   MMI  |                      |function|  MMI1  |
+ * +--------+----------------------+--------+--------+
+ *
+ * function  bits 7..6
+ *     bits |   0   |   1   |   2   |   3
+ *    10..8 |   00  |   01  |   10  |   11
+ *   -------+-------+-------+-------+-------
+ *    0 000 |   *   | PABSW | PCEQW | PMINW
+ *    1 001 | PADSBH| PABSH | PCEQH | PMINH
+ *    2 010 |   *   |   *   | PCEQB |   *
+ *    3 011 |   *   |   *   |   *   |   *
+ *    4 100 | PADDUW| PSUBUW| PEXTUW|   *
+ *    5 101 | PADDUH| PSUBUH| PEXTUH|   *
+ *    6 110 | PADDUB| PSUBUB| PEXTUB| QFSRV
+ *    7 111 |   *   |   *   |   *   |   *
+ */
+
+#define MASK_TX79_MMI1(op) (MASK_OP_MAJOR(op) | ((op) & 0x7FF))
+enum {
+    TX79_MMI1_PABSW  = (0x01 << 6) | TX79_MMI_CLASS_MMI1,
+    TX79_MMI1_PCEQW  = (0x02 << 6) | TX79_MMI_CLASS_MMI1,
+    TX79_MMI1_PMINW  = (0x03 << 6) | TX79_MMI_CLASS_MMI1,
+    TX79_MMI1_PADSBH = (0x04 << 6) | TX79_MMI_CLASS_MMI1,
+    TX79_MMI1_PABSH  = (0x05 << 6) | TX79_MMI_CLASS_MMI1,
+    TX79_MMI1_PCEQH  = (0x06 << 6) | TX79_MMI_CLASS_MMI1,
+    TX79_MMI1_PMINH  = (0x07 << 6) | TX79_MMI_CLASS_MMI1,
+    TX79_MMI1_PCEQB  = (0x0A << 6) | TX79_MMI_CLASS_MMI1,
+    TX79_MMI1_PADDUW = (0x10 << 6) | TX79_MMI_CLASS_MMI1,
+    TX79_MMI1_PSUBUW = (0x11 << 6) | TX79_MMI_CLASS_MMI1,
+    TX79_MMI1_PEXTUW = (0x12 << 6) | TX79_MMI_CLASS_MMI1,
+    TX79_MMI1_PADDUH = (0x14 << 6) | TX79_MMI_CLASS_MMI1,
+    TX79_MMI1_PSUBUH = (0x15 << 6) | TX79_MMI_CLASS_MMI1,
+    TX79_MMI1_PEXTUH = (0x16 << 6) | TX79_MMI_CLASS_MMI1,
+    TX79_MMI1_PADDUB = (0x18 << 6) | TX79_MMI_CLASS_MMI1,
+    TX79_MMI1_PSUBUB = (0x19 << 6) | TX79_MMI_CLASS_MMI1,
+    TX79_MMI1_PEXTUB = (0x1A << 6) | TX79_MMI_CLASS_MMI1,
+    TX79_MMI1_QFSRV  = (0x1B << 6) | TX79_MMI_CLASS_MMI1,
+};
+
 /* global register indices */
 static TCGv cpu_gpr[32], cpu_PC;
 static TCGv cpu_HI[MIPS_DSP_ACC], cpu_LO[MIPS_DSP_ACC];
-- 
2.18.1
