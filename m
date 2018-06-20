Received: from eggs.gnu.org ([2001:4830:134:3::10]:37493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVc2W-0002KJ-MI
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVc2T-000152-FG
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:16:44 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:48424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1fVc2T-00012I-9v
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:16:41 -0400
From: Yongbok Kim <yongbok.kim@mips.com>
Date: Wed, 20 Jun 2018 13:06:20 +0100
Message-ID: <20180620120620.12806-36-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-1-yongbok.kim@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 35/35] target/mips: Add I7200 CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, Aleksandar.Markovic@mips.com, James.Hogan@mips.com, Paul.Burton@mips.com, Matthew.Fortune@mips.com, Stefan.Markovic@mips.com

From: Stefan Markovic <stefan.markovic@mips.com>

Add I7200 CPU

Reference:
https://www.mips.com/products/warrior/i-class-i7200-multiprocessor-core/
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
---
 target/mips/translate_init.inc.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
index c7ba6ee..262ff29 100644
--- a/target/mips/translate_init.inc.c
+++ b/target/mips/translate_init.inc.c
@@ -449,6 +449,43 @@ const mips_def_t mips_defs[] =
         .insn_flags = CPU_MIPS32R6 | ASE_MICROMIPS,
         .mmu_type = MMU_TYPE_R4000,
     },
+    {
+        .name = "I7200",
+        .CP0_PRid = 0x00010000,
+        .CP0_Config0 = MIPS_CONFIG0 | (1 << CP0C0_MM) | (0x2 << CP0C0_AR) |
+                        (MMU_TYPE_R4000 << CP0C0_MT),
+        .CP0_Config1 = MIPS_CONFIG1 | (15 << CP0C1_MMU) | (2 << CP0C1_IS) |
+                       (4 << CP0C1_IL) | (3 << CP0C1_IA) | (2 << CP0C1_DS) |
+                       (4 << CP0C1_DL) | (3 << CP0C1_DA) | (1 << CP0C1_PC) |
+                       (1 << CP0C1_WR) | (1 << CP0C1_EP),
+        .CP0_Config2 = MIPS_CONFIG2,
+        .CP0_Config3 = MIPS_CONFIG3 | (1 << CP0C3_CMGCR) | (1 << CP0C3_BI) |
+                       (3 << CP0C3_MMAR) | (1 << CP0C3_ISA_ON_EXC) |
+                       (1 << CP0C3_ISA) | (1 << CP0C3_ULRI) |
+                       (1 << CP0C3_RXI) |
+                       (1 << CP0C3_VInt) | (1U << CP0C3_M) | (1 << CP0C3_MT),
+        .CP0_Config4 = MIPS_CONFIG4 | (0xfc << CP0C4_KScrExist) |
+                       (2 << CP0C4_IE) | (1U << CP0C4_M),
+        .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_MVH) | (1 << CP0C5_LLB),
+        .CP0_Config5_rw_bitmask = (1 << CP0C5_SBRI) | (1 << CP0C5_FRE) |
+                                  (1 << CP0C5_UFE),
+        .CP0_LLAddr_rw_bitmask = 0,
+        .CP0_LLAddr_shift = 0,
+        .SYNCI_Step = 32,
+        .CCRes = 2,
+        .CP0_Status_rw_bitmask = 0x3058FF1F,
+        .CP0_PageGrain = (1 << CP0PG_IEC) | (1 << CP0PG_XIE) |
+                         (1U << CP0PG_RIE),
+        .CP0_PageGrain_rw_bitmask = 0,
+        .CP1_fcr0 = (1 << FCR0_FREP) | (1 << FCR0_HAS2008) | (1 << FCR0_F64) |
+                    (1 << FCR0_L) | (1 << FCR0_W) | (1 << FCR0_D) |
+                    (1 << FCR0_S) | (0x02 << FCR0_PRID) | (0x0 << FCR0_REV),
+        .CP1_fcr31 = (1 << FCR31_ABS2008) | (1 << FCR31_NAN2008),
+        .SEGBITS = 32,
+        .PABITS = 32,
+        .insn_flags = CPU_NANOMIPS32 | ASE_MICROMIPS,
+        .mmu_type = MMU_TYPE_R4000,
+    },
 #if defined(TARGET_MIPS64)
     {
         .name = "R4000",
-- 
1.9.1
