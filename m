Received: from eggs.gnu.org ([2001:4830:134:3::10]:43214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRCj-0001Bp-NN
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:24:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRCh-0000Rb-5I
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:24:16 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gCRCg-0007xg-UK
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:24:15 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRCF-0003qH-4g
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 16:23:47 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 16:23:23 +0100
Message-Id: <20181016152325.31367-18-peter.maydell@linaro.org>
In-Reply-To: <20181016152325.31367-1-peter.maydell@linaro.org>
References: <20181016152325.31367-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/19] target/arm: Mask PMOVSR writes based on
 supported counters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Aaron Lindsay <aclindsa@gmail.com>

This is an amendment to my earlier patch:
    commit 7ece99b17e832065236c07a158dfac62619ef99b
    Author: Aaron Lindsay <alindsay@codeaurora.org>
    Date:   Thu Apr 26 11:04:39 2018 +0100

	target/arm: Mask PMU register writes based on PMCR_EL0.N

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181010203735.27918-3-aclindsa@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 138a1f15405..7a53098888d 100644
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
2.19.0
