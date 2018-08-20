Received: from eggs.gnu.org ([2001:4830:134:3::10]:44784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1froxw-0000mL-Ce
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1frol4-0001md-MS
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:18:32 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:51317 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1frol2-0001hV-Rl
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:18:30 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 20 Aug 2018 20:16:54 +0200
Message-Id: <1534789014-8310-47-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534789014-8310-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534789014-8310-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v11 46/46] target/mips: Add definition of
 nanoMIPS I7200 CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, dnikolic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Stefan Markovic <smarkovic@wavecomp.com>

Add definition of the first nanoMIPS processor in QEMU.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate_init.inc.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
index c7ba6ee..b3320b9 100644
--- a/target/mips/translate_init.inc.c
+++ b/target/mips/translate_init.inc.c
@@ -449,6 +449,45 @@ const mips_def_t mips_defs[] =
         .insn_flags = CPU_MIPS32R6 | ASE_MICROMIPS,
         .mmu_type = MMU_TYPE_R4000,
     },
+    {
+        .name = "I7200",
+        .CP0_PRid = 0x00010000,
+        .CP0_Config0 = MIPS_CONFIG0 | (1 << CP0C0_MM) | (0x2 << CP0C0_AR) |
+                        (MMU_TYPE_R4000 << CP0C0_MT),
+        .CP0_Config1 = (1U << CP0C1_M) | (15 << CP0C1_MMU) | (2 << CP0C1_IS) |
+                       (4 << CP0C1_IL) | (3 << CP0C1_IA) | (2 << CP0C1_DS) |
+                       (4 << CP0C1_DL) | (3 << CP0C1_DA) | (1 << CP0C1_PC) |
+                       (1 << CP0C1_EP),
+        .CP0_Config2 = MIPS_CONFIG2,
+        .CP0_Config3 = MIPS_CONFIG3 | (1U << CP0C3_M) | (1 << CP0C3_CMGCR) |
+                       (1 << CP0C3_BI) | (1 << CP0C3_SC) | (3 << CP0C3_MMAR) |
+                       (1 << CP0C3_ISA_ON_EXC) | (1 << CP0C3_ISA) |
+                       (1 << CP0C3_ULRI) | (1 << CP0C3_RXI) |
+                       (1 << CP0C3_DSP2P) | (1 << CP0C3_DSPP) |
+                       (1 << CP0C3_CTXTC) | (1 << CP0C3_VInt) |
+                       (1 << CP0C3_CDMM) | (1 << CP0C3_MT) | (1 << CP0C3_TL),
+        .CP0_Config4 = MIPS_CONFIG4 | (0xfc << CP0C4_KScrExist) |
+                       (2 << CP0C4_IE) | (1U << CP0C4_M),
+        .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_MVH) | (1 << CP0C5_LLB),
+        .CP0_Config5_rw_bitmask = (1 << CP0C5_SBRI) | (1 << CP0C5_FRE) |
+                                  (1 << CP0C5_UFE),
+        .CP0_LLAddr_rw_bitmask = 0,
+        .CP0_LLAddr_shift = 0,
+        .SYNCI_Step = 32,
+        .CCRes = 2,
+        .CP0_Status_rw_bitmask = 0x3158FF1F,
+        .CP0_PageGrain = (1 << CP0PG_IEC) | (1 << CP0PG_XIE) |
+                         (1U << CP0PG_RIE),
+        .CP0_PageGrain_rw_bitmask = 0,
+        .CP1_fcr0 = (1 << FCR0_FREP) | (1 << FCR0_HAS2008) | (1 << FCR0_F64) |
+                    (1 << FCR0_L) | (1 << FCR0_W) | (1 << FCR0_D) |
+                    (1 << FCR0_S) | (0x02 << FCR0_PRID) | (0x0 << FCR0_REV),
+        .CP1_fcr31 = (1 << FCR31_ABS2008) | (1 << FCR31_NAN2008),
+        .SEGBITS = 32,
+        .PABITS = 32,
+        .insn_flags = CPU_NANOMIPS32 | ASE_DSP | ASE_DSPR2 | ASE_MT,
+        .mmu_type = MMU_TYPE_R4000,
+    },
 #if defined(TARGET_MIPS64)
     {
         .name = "R4000",
-- 
2.7.4
