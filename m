Received: from eggs.gnu.org ([2001:4830:134:3::10]:58486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekeDC-0006Tf-Fb
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 18:05:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekeDA-00081t-F9
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 18:05:38 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:34950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekeDA-00080z-4o
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 18:05:36 -0500
Received: by mail-pg0-x243.google.com with SMTP id o13so5479854pgs.2
	for <qemu-devel@nongnu.org>; Sat, 10 Feb 2018 15:05:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 10 Feb 2018 15:05:26 -0800
Message-Id: <20180210230530.8421-2-richard.henderson@linaro.org>
In-Reply-To: <20180210230530.8421-1-richard.henderson@linaro.org>
References: <20180210230530.8421-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/5] target/arm: Remove ARM_CP_64BIT from
 ZCR_EL registers
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

Because they are ARM_CP_STATE_AA64, ARM_CP_64BIT is implied.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 180ab75458..4b102ec356 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4357,7 +4357,7 @@ static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static const ARMCPRegInfo zcr_el1_reginfo = {
     .name = "ZCR_EL1", .state = ARM_CP_STATE_AA64,
     .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 2, .opc2 = 0,
-    .access = PL1_RW, .accessfn = zcr_access, .type = ARM_CP_64BIT,
+    .access = PL1_RW, .accessfn = zcr_access,
     .fieldoffset = offsetof(CPUARMState, vfp.zcr_el[1]),
     .writefn = zcr_write, .raw_writefn = raw_write
 };
@@ -4365,7 +4365,7 @@ static const ARMCPRegInfo zcr_el1_reginfo = {
 static const ARMCPRegInfo zcr_el2_reginfo = {
     .name = "ZCR_EL2", .state = ARM_CP_STATE_AA64,
     .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 2, .opc2 = 0,
-    .access = PL2_RW, .accessfn = zcr_access, .type = ARM_CP_64BIT,
+    .access = PL2_RW, .accessfn = zcr_access,
     .fieldoffset = offsetof(CPUARMState, vfp.zcr_el[2]),
     .writefn = zcr_write, .raw_writefn = raw_write
 };
@@ -4373,14 +4373,14 @@ static const ARMCPRegInfo zcr_el2_reginfo = {
 static const ARMCPRegInfo zcr_no_el2_reginfo = {
     .name = "ZCR_EL2", .state = ARM_CP_STATE_AA64,
     .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 2, .opc2 = 0,
-    .access = PL2_RW, .type = ARM_CP_64BIT,
+    .access = PL2_RW,
     .readfn = arm_cp_read_zero, .writefn = arm_cp_write_ignore
 };
 
 static const ARMCPRegInfo zcr_el3_reginfo = {
     .name = "ZCR_EL3", .state = ARM_CP_STATE_AA64,
     .opc0 = 3, .opc1 = 6, .crn = 1, .crm = 2, .opc2 = 0,
-    .access = PL3_RW, .accessfn = zcr_access, .type = ARM_CP_64BIT,
+    .access = PL3_RW, .accessfn = zcr_access,
     .fieldoffset = offsetof(CPUARMState, vfp.zcr_el[3]),
     .writefn = zcr_write, .raw_writefn = raw_write
 };
-- 
2.14.3
