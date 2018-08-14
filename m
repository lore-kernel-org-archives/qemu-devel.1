Received: from eggs.gnu.org ([2001:4830:134:3::10]:43906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpYfL-0005ZR-1M
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpYfK-0002Ot-2g
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:43:14 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 13:42:47 +0100
Message-Id: <20180814124254.5229-4-peter.maydell@linaro.org>
In-Reply-To: <20180814124254.5229-1-peter.maydell@linaro.org>
References: <20180814124254.5229-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 03/10] target/arm: Implement RAZ/WI HACTLR2
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

The AArch32 HACTLR2 register maps to bits [63:32] of ACTLR_EL2.
We implement ACTLR_EL2 as RAZ/WI, so make HACTLR2 also RAZ/WI.
(We put the regdef next to ACTLR_EL2 as a reminder in case we
ever make ACTLR_EL2 something other than RAZ/WI).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 466c8ae492e..14fd78f587a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5436,6 +5436,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 0, .opc2 = 1,
               .access = PL2_RW, .type = ARM_CP_CONST,
               .resetvalue = 0 },
+            /* HACTLR2 maps to ACTLR_EL2[63:32] */
+            { .name = "HACTLR2", .state = ARM_CP_STATE_AA32,
+              .cp = 15, .opc1 = 4, .crn = 1, .crm = 0, .opc2 = 3,
+              .access = PL2_RW, .type = ARM_CP_CONST,
+              .resetvalue = 0 },
             { .name = "ACTLR_EL3", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 6, .crn = 1, .crm = 0, .opc2 = 1,
               .access = PL3_RW, .type = ARM_CP_CONST,
-- 
2.18.0
