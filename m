Received: from eggs.gnu.org ([2001:4830:134:3::10]:39769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeR0-0002l9-IH
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQz-0001ZR-3S
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:30 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fBeQy-0001Vb-SU
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:29 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQq-00031X-R1
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:47:20 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 11:47:02 +0100
Message-Id: <20180426104715.21702-7-peter.maydell@linaro.org>
In-Reply-To: <20180426104715.21702-1-peter.maydell@linaro.org>
References: <20180426104715.21702-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 06/19] target/arm: Treat PMCCNTR as alias of
 PMCCNTR_EL0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Aaron Lindsay <alindsay@codeaurora.org>

They share the same underlying state

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1523997485-1905-3-git-send-email-alindsay@codeaurora.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1526724d64..7bf4afa719 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1318,7 +1318,7 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pmselr),
       .writefn = pmselr_write, .raw_writefn = raw_write, },
     { .name = "PMCCNTR", .cp = 15, .crn = 9, .crm = 13, .opc1 = 0, .opc2 = 0,
-      .access = PL0_RW, .resetvalue = 0, .type = ARM_CP_IO,
+      .access = PL0_RW, .resetvalue = 0, .type = ARM_CP_ALIAS | ARM_CP_IO,
       .readfn = pmccntr_read, .writefn = pmccntr_write32,
       .accessfn = pmreg_access_ccntr },
     { .name = "PMCCNTR_EL0", .state = ARM_CP_STATE_AA64,
-- 
2.17.0
