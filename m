Received: from eggs.gnu.org ([2001:4830:134:3::10]:45841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmc-0008Ng-9y
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmX-000837-UN
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:10 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33254 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEZmX-00082c-L3
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:05 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 22 Oct 2018 14:57:25 +0200
Message-Id: <1540213077-15211-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 02/34] disas/mips: Define R5900 disassembly
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

Amend definition for MIPS ISAs in disassembler with R5900.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/mips.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/disas/mips.c b/disas/mips.c
index 97f661a..ae72059 100644
--- a/disas/mips.c
+++ b/disas/mips.c
@@ -611,6 +611,9 @@ struct mips_opcode
 /* ST Microelectronics Loongson 2F.  */
 #define INSN_LOONGSON_2F          0x80000000
 
+/* Sony/Toshiba R5900 */
+#define INSN_5900                 0x100000000
+
 /* MIPS ISA defines, use instead of hardcoding ISA level.  */
 
 #define       ISA_UNKNOWN     0               /* Gas internal use.  */
@@ -646,6 +649,7 @@ struct mips_opcode
 #define CPU_R5000	5000
 #define CPU_VR5400	5400
 #define CPU_VR5500	5500
+#define CPU_R5900       5900
 #define CPU_R6000	6000
 #define CPU_RM7000	7000
 #define CPU_R8000	8000
@@ -1193,6 +1197,7 @@ extern const int bfd_mips16_num_opcodes;
 #define N5	(INSN_5400 | INSN_5500)
 #define N54	INSN_5400
 #define N55	INSN_5500
+#define EE      INSN_5900    /* Emotion Engine */
 
 #define G1      (T3             \
                  )
@@ -3861,6 +3866,7 @@ struct mips_arch_choice
 #define bfd_mach_mips5000              5000
 #define bfd_mach_mips5400              5400
 #define bfd_mach_mips5500              5500
+#define bfd_mach_mips5900              5900
 #define bfd_mach_mips6000              6000
 #define bfd_mach_mips7000              7000
 #define bfd_mach_mips8000              8000
@@ -3908,6 +3914,8 @@ static const struct mips_arch_choice mips_arch_choices[] =
     mips_cp0_names_numeric, NULL, 0, mips_hwr_names_numeric },
   { "vr5500",	1, bfd_mach_mips5500, CPU_VR5500, ISA_MIPS4,
     mips_cp0_names_numeric, NULL, 0, mips_hwr_names_numeric },
+  { "r5900",    1, bfd_mach_mips5900, CPU_R5900, ISA_MIPS3,
+    mips_cp0_names_numeric, NULL, 0, mips_hwr_names_numeric },
   { "r6000",	1, bfd_mach_mips6000, CPU_R6000, ISA_MIPS2,
     mips_cp0_names_numeric, NULL, 0, mips_hwr_names_numeric },
   { "rm7000",	1, bfd_mach_mips7000, CPU_RM7000, ISA_MIPS4,
-- 
2.7.4
