Received: from eggs.gnu.org ([2001:4830:134:3::10]:44162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1d0tcC-0008Mh-1C
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 13:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1d0tcB-0004TQ-6x
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 13:42:04 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Wed, 19 Apr 2017 13:41:23 -0400
Message-Id: <1492623684-25799-13-git-send-email-alindsay@codeaurora.org>
In-Reply-To: <1492623684-25799-1-git-send-email-alindsay@codeaurora.org>
References: <1492623684-25799-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH 12/13] target/arm: PMU: Set PMCR.N to 4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, mspradli@codeaurora.org, Aaron Lindsay <alindsay@codeaurora.org>

This both advertises that we support four counters and adds them to the
implementation because the PMU_NUM_COUNTERS macro reads this value from
the PMCR.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
---
 target/arm/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5972984..a15b932 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4936,7 +4936,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             .access = PL0_RW, .accessfn = pmreg_access,
             .type = ARM_CP_IO,
             .fieldoffset = offsetof(CPUARMState, cp15.c9_pmcr),
-            .resetvalue = cpu->midr & 0xff000000,
+            /* 4 counters enabled */
+            .resetvalue = (cpu->midr & 0xff000000) | (0x4 << PMCRN_SHIFT),
             .writefn = pmcr_write, .raw_writefn = raw_write,
         };
         define_one_arm_cp_reg(cpu, &pmcr);
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
