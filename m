Received: from eggs.gnu.org ([2001:4830:134:3::10]:43927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpYfL-0005aF-J3
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:43:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpYfK-0002Q6-Q3
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:43:15 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 13:42:45 +0100
Message-Id: <20180814124254.5229-2-peter.maydell@linaro.org>
In-Reply-To: <20180814124254.5229-1-peter.maydell@linaro.org>
References: <20180814124254.5229-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 01/10] target/arm: Correct typo in HAMAIR1
 regdef name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Luc Michel <luc.michel@greensocs.com>, edgari@xilinx.com

We implement the HAMAIR1 register as RAZ/WI; we had a typo in the
regdef, though, and were incorrectly naming it HMAIR1 (which is
a different register which we also implement as RAZ/WI).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8b07bf214ec..2c5e02c0b1a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3773,7 +3773,7 @@ static const ARMCPRegInfo el3_no_el2_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 4, .crn = 10, .crm = 3, .opc2 = 0,
       .access = PL2_RW, .type = ARM_CP_CONST,
       .resetvalue = 0 },
-    { .name = "HMAIR1", .state = ARM_CP_STATE_AA32,
+    { .name = "HAMAIR1", .state = ARM_CP_STATE_AA32,
       .opc1 = 4, .crn = 10, .crm = 3, .opc2 = 1,
       .access = PL2_RW, .type = ARM_CP_CONST,
       .resetvalue = 0 },
@@ -3925,7 +3925,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .access = PL2_RW, .type = ARM_CP_CONST,
       .resetvalue = 0 },
     /* HAMAIR1 is mapped to AMAIR_EL2[63:32] */
-    { .name = "HMAIR1", .state = ARM_CP_STATE_AA32,
+    { .name = "HAMAIR1", .state = ARM_CP_STATE_AA32,
       .opc1 = 4, .crn = 10, .crm = 3, .opc2 = 1,
       .access = PL2_RW, .type = ARM_CP_CONST,
       .resetvalue = 0 },
-- 
2.18.0
