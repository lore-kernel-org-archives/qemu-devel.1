Received: from eggs.gnu.org ([2001:4830:134:3::10]:45851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmc-0008O0-Ju
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmZ-00084F-8K
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:10 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33334 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEZmY-00083D-Sa
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:07 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 22 Oct 2018 14:57:30 +0200
Message-Id: <1540213077-15211-8-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 07/34] target/mips: Define R5900 MMI1 opcode
 constants
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

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 242f2df..e233b87 100644
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
2.7.4
