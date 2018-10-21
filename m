Received: from eggs.gnu.org ([2001:4830:134:3::10]:44725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFhz-0006Pa-BG
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:32:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEFhw-0000jW-23
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:32:03 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:46961)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEFhv-0000iT-Qt
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:31:59 -0400
Date: Sun, 21 Oct 2018 17:31:57 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <bbf5f8c87395688f9679a28fa51fc3eca8284b8e.1540134918.git.noring@nocrew.org>
References: <cover.1540134918.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1540134918.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v8 02/38] disas/mips: Define R5900 disassembly
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
 disas/mips.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/disas/mips.c b/disas/mips.c
index 97f661a37e..ae72059c46 100644
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
2.18.1
