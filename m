Received: from eggs.gnu.org ([2001:4830:134:3::10]:59936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFJQL-0004tL-ML
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFJQK-0001ri-B4
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:13 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:49890 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gFJQK-0001mK-0W
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:12 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 24 Oct 2018 15:40:22 +0200
Message-Id: <1540388447-27062-9-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540388447-27062-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540388447-27062-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 08/33] target/mips: Define R5900 MMI3 opcode
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
 target/mips/translate.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index bd51443..3c6a2c9 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2323,6 +2323,45 @@ enum {
     TX79_MMI2_PROT3W = (0x1F << 6) | TX79_MMI_CLASS_MMI2,
 };
 
+/*
+ * TX79 Multimedia Instructions with opcode field = MMI and bits 5..0 = MMI3:
+ *
+ *  31    26                        10     6 5      0
+ * +--------+----------------------+--------+--------+
+ * |   MMI  |                      |function|  MMI3  |
+ * +--------+----------------------+--------+--------+
+ *
+ * function  bits 7..6
+ *     bits |   0   |   1   |   2   |   3
+ *    10..8 |   00  |   01  |   10  |   11
+ *   -------+-------+-------+-------+-------
+ *    0 000 |PMADDUW|   *   |   *   | PSRAVW
+ *    1 001 |   *   |   *   |   *   |   *
+ *    2 010 | PMTHI | PMTLO | PINTEH|   *
+ *    3 011 |PMULTUW| PDIVUW| PCPYUD|   *
+ *    4 100 |   *   |   *   |  POR  |  PNOR
+ *    5 101 |   *   |   *   |   *   |   *
+ *    6 110 |   *   |   *   | PEXCH | PCPYH
+ *    7 111 |   *   |   *   | PEXCW |   *
+ */
+
+#define MASK_TX79_MMI3(op) (MASK_OP_MAJOR(op) | ((op) & 0x7FF))
+enum {
+    TX79_MMI3_PMADDUW = (0x00 << 6) | TX79_MMI_CLASS_MMI3,
+    TX79_MMI3_PSRAVW  = (0x03 << 6) | TX79_MMI_CLASS_MMI3,
+    TX79_MMI3_PMTHI   = (0x08 << 6) | TX79_MMI_CLASS_MMI3,
+    TX79_MMI3_PMTLO   = (0x09 << 6) | TX79_MMI_CLASS_MMI3,
+    TX79_MMI3_PINTEH  = (0x0A << 6) | TX79_MMI_CLASS_MMI3,
+    TX79_MMI3_PMULTUW = (0x0C << 6) | TX79_MMI_CLASS_MMI3,
+    TX79_MMI3_PDIVUW  = (0x0D << 6) | TX79_MMI_CLASS_MMI3,
+    TX79_MMI3_PCPYUD  = (0x0E << 6) | TX79_MMI_CLASS_MMI3,
+    TX79_MMI3_POR     = (0x12 << 6) | TX79_MMI_CLASS_MMI3,
+    TX79_MMI3_PNOR    = (0x13 << 6) | TX79_MMI_CLASS_MMI3,
+    TX79_MMI3_PEXCH   = (0x1A << 6) | TX79_MMI_CLASS_MMI3,
+    TX79_MMI3_PCPYH   = (0x1B << 6) | TX79_MMI_CLASS_MMI3,
+    TX79_MMI3_PEXCW   = (0x1E << 6) | TX79_MMI_CLASS_MMI3,
+};
+
 /* global register indices */
 static TCGv cpu_gpr[32], cpu_PC;
 static TCGv cpu_HI[MIPS_DSP_ACC], cpu_LO[MIPS_DSP_ACC];
-- 
2.7.4
