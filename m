Received: from eggs.gnu.org ([2001:4830:134:3::10]:39612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aclindsa@gmail.com>) id 1gALFb-0002rS-Ng
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 16:38:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aclindsa@gmail.com>) id 1gALFa-0002Ue-ET
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 16:38:35 -0400
From: Aaron Lindsay <aclindsa@gmail.com>
Date: Wed, 10 Oct 2018 16:37:23 -0400
Message-Id: <20181010203735.27918-3-aclindsa@gmail.com>
In-Reply-To: <20181010203735.27918-1-aclindsa@gmail.com>
References: <20181010203735.27918-1-aclindsa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 02/14] target/arm: Mask PMOVSR writes based
 on supported counters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aclindsa@gmail.com>, Aaron Lindsay <alindsay@codeaurora.org>

This is an amendment to my earlier patch:
    commit 7ece99b17e832065236c07a158dfac62619ef99b
    Author: Aaron Lindsay <alindsay@codeaurora.org>
    Date:   Thu Apr 26 11:04:39 2018 +0100

	target/arm: Mask PMU register writes based on PMCR_EL0.N

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
---
 target/arm/helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 52c76b7444..8ca4d30797 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1179,6 +1179,7 @@ static void pmcntenclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void pmovsr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                          uint64_t value)
 {
+    value &= pmu_counter_mask(env);
     env->cp15.c9_pmovsr &= ~value;
 }
 
-- 
2.19.1
