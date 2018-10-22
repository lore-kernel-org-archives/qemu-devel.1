Received: from eggs.gnu.org ([2001:4830:134:3::10]:45846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmc-0008Nt-Ii
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmZ-000842-3o
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:10 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33312 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEZmY-000832-MD
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:06 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 22 Oct 2018 14:57:29 +0200
Message-Id: <1540213077-15211-7-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 06/34] target/mips: Define R5900 MMI0 opcode
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

Add definition of MI0 opcodes.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index ae98817..242f2df 100644
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
2.7.4
