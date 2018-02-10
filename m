Received: from eggs.gnu.org ([2001:4830:134:3::10]:58580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekeDF-0006WV-5X
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 18:05:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekeDD-000864-3r
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 18:05:41 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:42647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekeDC-00084d-TK
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 18:05:39 -0500
Received: by mail-pg0-x244.google.com with SMTP id m28so5476354pgc.9
	for <qemu-devel@nongnu.org>; Sat, 10 Feb 2018 15:05:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 10 Feb 2018 15:05:28 -0800
Message-Id: <20180210230530.8421-4-richard.henderson@linaro.org>
In-Reply-To: <20180210230530.8421-1-richard.henderson@linaro.org>
References: <20180210230530.8421-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/5] target/arm: Suppress TB end for FPCR/FPSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Nothing in either register affects the TB.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.14.3
