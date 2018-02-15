Received: from eggs.gnu.org ([2001:4830:134:3::10]:36405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emOP5-00068Z-8y
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emOP4-0004Dg-EB
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:07 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1emOP4-0004Cg-6i
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:37:06 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1emOP2-00024y-VM
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 18:37:04 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 18:36:45 +0000
Message-Id: <20180215183700.26101-6-peter.maydell@linaro.org>
In-Reply-To: <20180215183700.26101-1-peter.maydell@linaro.org>
References: <20180215183700.26101-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 05/20] target/arm: Suppress TB end for FPCR/FPSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Nothing in either register affects the TB.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180211205848.4568-4-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d41fb8371f..e0184c7162 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3356,11 +3356,11 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .writefn = aa64_daif_write, .resetfn = arm_cp_reset_ignore },
     { .name = "FPCR", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .opc2 = 0, .crn = 4, .crm = 4,
-      .access = PL0_RW, .type = ARM_CP_FPU,
+      .access = PL0_RW, .type = ARM_CP_FPU | ARM_CP_SUPPRESS_TB_END,
       .readfn = aa64_fpcr_read, .writefn = aa64_fpcr_write },
     { .name = "FPSR", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .opc2 = 1, .crn = 4, .crm = 4,
-      .access = PL0_RW, .type = ARM_CP_FPU,
+      .access = PL0_RW, .type = ARM_CP_FPU | ARM_CP_SUPPRESS_TB_END,
       .readfn = aa64_fpsr_read, .writefn = aa64_fpsr_write },
     { .name = "DCZID_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .opc2 = 7, .crn = 0, .crm = 0,
-- 
2.16.1
