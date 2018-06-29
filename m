Received: from eggs.gnu.org ([2001:4830:134:3::10]:34286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun8-0007rB-DZ
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun7-0007ju-Nq
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:30 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYun7-0007hP-Gl
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:29 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYun6-0004pD-Fr
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:54:28 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:53:40 +0100
Message-Id: <20180629145347.652-49-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 48/55] target/arm: Mark PMINTENSET accesses as
 possibly doing IO
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

This makes it match its AArch64 equivalent, PMINTENSET_EL1

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Message-id: 1529699547-17044-13-git-send-email-alindsay@codeaurora.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d0786e0c210..60589b7eaf9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1404,7 +1404,7 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .writefn = pmuserenr_write, .raw_writefn = raw_write },
     { .name = "PMINTENSET", .cp = 15, .crn = 9, .crm = 14, .opc1 = 0, .opc2 = 1,
       .access = PL1_RW, .accessfn = access_tpm,
-      .type = ARM_CP_ALIAS,
+      .type = ARM_CP_ALIAS | ARM_CP_IO,
       .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pminten),
       .resetvalue = 0,
       .writefn = pmintenset_write, .raw_writefn = raw_write },
-- 
2.17.1
