Received: from eggs.gnu.org ([2001:4830:134:3::10]:50060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd8-0003a4-4z
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd7-0005P4-9E
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:34 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fWLd7-0005OZ-26
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:33 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd6-00040Y-1a
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:57:32 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 13:57:10 +0100
Message-Id: <20180622125713.15303-26-peter.maydell@linaro.org>
In-Reply-To: <20180622125713.15303-1-peter.maydell@linaro.org>
References: <20180622125713.15303-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 25/28] target/arm: Introduce ARM_FEATURE_M_MAIN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Julia Suvorova <jusual@mail.ru>

This feature is intended to distinguish ARMv8-M variants: Baseline and
Mainline. ARMv7-M compatibility requires the Main Extension. ARMv6-M
compatibility is provided by all ARMv8-M implementations.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
Message-id: 20180622080138.17702-2-jusual@mail.ru
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 1 +
 target/arm/cpu.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8488273c5bd..a4507a2d6f0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1482,6 +1482,7 @@ enum arm_features {
     ARM_FEATURE_V8_RDM, /* implements v8.1 simd round multiply */
     ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
     ARM_FEATURE_V8_FCMA, /* has complex number part of v8.3 extensions.  */
+    ARM_FEATURE_M_MAIN, /* M profile Main Extension */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 81c1d22b143..2ae4fffafb9 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1238,6 +1238,7 @@ static void cortex_m3_initfn(Object *obj)
     ARMCPU *cpu = ARM_CPU(obj);
     set_feature(&cpu->env, ARM_FEATURE_V7);
     set_feature(&cpu->env, ARM_FEATURE_M);
+    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
     cpu->midr = 0x410fc231;
     cpu->pmsav7_dregion = 8;
     cpu->id_pfr0 = 0x00000030;
@@ -1262,6 +1263,7 @@ static void cortex_m4_initfn(Object *obj)
 
     set_feature(&cpu->env, ARM_FEATURE_V7);
     set_feature(&cpu->env, ARM_FEATURE_M);
+    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
     cpu->midr = 0x410fc240; /* r0p0 */
     cpu->pmsav7_dregion = 8;
@@ -1287,6 +1289,7 @@ static void cortex_m33_initfn(Object *obj)
 
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_M);
+    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
     set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
     cpu->midr = 0x410fd213; /* r0p3 */
-- 
2.17.1
