Received: from eggs.gnu.org ([2001:4830:134:3::10]:43837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1eww1F-0005gq-8N
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1eww1E-00037e-Bh
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:32:05 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Date: Fri, 16 Mar 2018 16:31:01 -0400
Message-Id: <1521232280-13089-4-git-send-email-alindsay@codeaurora.org>
In-Reply-To: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
Subject: [Qemu-devel] [PATCH v3 03/22] target/arm: Check PMCNTEN for whether
 PMCCNTR is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 09893e3..5e48982 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -994,7 +994,7 @@ static inline bool arm_ccnt_enabled(CPUARMState *env)
 {
     /* This does not support checking PMCCFILTR_EL0 register */
 
-    if (!(env->cp15.c9_pmcr & PMCRE)) {
+    if (!(env->cp15.c9_pmcr & PMCRE) || !(env->cp15.c9_pmcnten & (1 << 31))) {
         return false;
     }
 
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
