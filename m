Received: from eggs.gnu.org ([2001:4830:134:3::10]:44111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fWH1a-0001r1-Kt
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:02:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fWH1X-0002Pz-I5
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:02:30 -0400
Received: from smtp58.i.mail.ru ([217.69.128.38]:46694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fWH1X-0002PN-AH
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:02:27 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Fri, 22 Jun 2018 11:01:37 +0300
Message-Id: <20180622080138.17702-2-jusual@mail.ru>
In-Reply-To: <20180622080138.17702-1-jusual@mail.ru>
References: <20180622080138.17702-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH v2 1/2] target/arm: Introduce ARM_FEATURE_M_MAIN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

This feature is intended to distinguish ARMv8-M variants: Baseline and
Mainline. ARMv7-M compatibility requires the Main Extension. ARMv6-M
compatibility is provided by all ARMv8-M implementations.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
 target/arm/cpu.c | 3 +++
 target/arm/cpu.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 788883073c..c8bba94b06 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1248,6 +1248,7 @@ static void cortex_m3_initfn(Object *obj)
     ARMCPU *cpu = ARM_CPU(obj);
     set_feature(&cpu->env, ARM_FEATURE_V7);
     set_feature(&cpu->env, ARM_FEATURE_M);
+    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
     cpu->midr = 0x410fc231;
     cpu->pmsav7_dregion = 8;
     cpu->id_pfr0 = 0x00000030;
@@ -1272,6 +1273,7 @@ static void cortex_m4_initfn(Object *obj)
 
     set_feature(&cpu->env, ARM_FEATURE_V7);
     set_feature(&cpu->env, ARM_FEATURE_M);
+    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
     cpu->midr = 0x410fc240; /* r0p0 */
     cpu->pmsav7_dregion = 8;
@@ -1297,6 +1299,7 @@ static void cortex_m33_initfn(Object *obj)
 
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_M);
+    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
     set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
     cpu->midr = 0x410fd213; /* r0p3 */
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8488273c5b..a4507a2d6f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1482,6 +1482,7 @@ enum arm_features {
     ARM_FEATURE_V8_RDM, /* implements v8.1 simd round multiply */
     ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
     ARM_FEATURE_V8_FCMA, /* has complex number part of v8.3 extensions.  */
+    ARM_FEATURE_M_MAIN, /* M profile Main Extension */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
-- 
2.17.0
