Received: from eggs.gnu.org ([2001:4830:134:3::10]:43222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRCk-0001Cu-QY
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:24:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRCh-0000SY-RK
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:24:17 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gCRCh-000803-ER
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:24:15 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRCE-0003q3-6E
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 16:23:46 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 16:23:22 +0100
Message-Id: <20181016152325.31367-17-peter.maydell@linaro.org>
In-Reply-To: <20181016152325.31367-1-peter.maydell@linaro.org>
References: <20181016152325.31367-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/19] target/arm: Mark PMINTENCLR and
 PMINTENCLR_EL1 accesses as possibly doing IO
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

I previously fixed this for PMINTENSET_EL1, but missed these.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Signed-off-by: Aaron Lindsay <aclindsa@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181010203735.27918-2-aclindsa@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0efbb5c76ce..138a1f15405 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1423,12 +1423,14 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .writefn = pmintenset_write, .raw_writefn = raw_write,
       .resetvalue = 0x0 },
     { .name = "PMINTENCLR", .cp = 15, .crn = 9, .crm = 14, .opc1 = 0, .opc2 = 2,
-      .access = PL1_RW, .accessfn = access_tpm, .type = ARM_CP_ALIAS,
+      .access = PL1_RW, .accessfn = access_tpm,
+      .type = ARM_CP_ALIAS | ARM_CP_IO,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
       .writefn = pmintenclr_write, },
     { .name = "PMINTENCLR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 2,
-      .access = PL1_RW, .accessfn = access_tpm, .type = ARM_CP_ALIAS,
+      .access = PL1_RW, .accessfn = access_tpm,
+      .type = ARM_CP_ALIAS | ARM_CP_IO,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
       .writefn = pmintenclr_write },
     { .name = "CCSIDR", .state = ARM_CP_STATE_BOTH,
-- 
2.19.0
