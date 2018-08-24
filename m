Received: from eggs.gnu.org ([2001:4830:134:3::10]:35757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8UI-0007eq-Tc
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8UG-0004mA-S6
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:38 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ft8UG-0004PP-C7
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:36 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8UE-0006dx-AQ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:34:34 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:33:34 +0100
Message-Id: <20180824093343.11346-44-peter.maydell@linaro.org>
In-Reply-To: <20180824093343.11346-1-peter.maydell@linaro.org>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 43/52] target/arm: Remove a handful of stray tabs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Following the bulk conversion of the iwMMXt code, there are
just a handful of hard coded tabs in target/arm; fix them.
This is a whitespace-only patch.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180821165215.29069-4-peter.maydell@linaro.org
---
 target/arm/cpu.h      | 16 ++++++++--------
 target/arm/arm-semi.c |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 62c36b41507..65c0fa0a659 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1320,14 +1320,14 @@ enum arm_cpu_mode {
 #define ARM_VFP_FPINST2 10
 
 /* iwMMXt coprocessor control registers.  */
-#define ARM_IWMMXT_wCID		0
-#define ARM_IWMMXT_wCon		1
-#define ARM_IWMMXT_wCSSF	2
-#define ARM_IWMMXT_wCASF	3
-#define ARM_IWMMXT_wCGR0	8
-#define ARM_IWMMXT_wCGR1	9
-#define ARM_IWMMXT_wCGR2	10
-#define ARM_IWMMXT_wCGR3	11
+#define ARM_IWMMXT_wCID  0
+#define ARM_IWMMXT_wCon  1
+#define ARM_IWMMXT_wCSSF 2
+#define ARM_IWMMXT_wCASF 3
+#define ARM_IWMMXT_wCGR0 8
+#define ARM_IWMMXT_wCGR1 9
+#define ARM_IWMMXT_wCGR2 10
+#define ARM_IWMMXT_wCGR3 11
 
 /* V7M CCR bits */
 FIELD(V7M_CCR, NONBASETHRDENA, 0, 1)
diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 7cac8734c70..b2b22d231e3 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -136,7 +136,7 @@ static void arm_semi_cb(CPUState *cs, target_ulong ret, target_ulong err)
 #ifdef CONFIG_USER_ONLY
         ts->swi_errno = err;
 #else
-	syscall_err = err;
+        syscall_err = err;
 #endif
         reg0 = ret;
     } else {
-- 
2.18.0
