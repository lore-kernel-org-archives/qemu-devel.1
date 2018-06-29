Received: from eggs.gnu.org ([2001:4830:134:3::10]:34392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYunE-0007z4-Fd
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYunD-000854-Et
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:36 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYunD-0007y9-7b
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:35 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYunB-0004sA-Um
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:54:33 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:53:47 +0100
Message-Id: <20180629145347.652-56-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 55/55] target/arm: Add ID_ISAR6
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

This register was added to aa32 state by ARMv8.2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180629001538.11415-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    | 1 +
 target/arm/cpu.c    | 4 ++++
 target/arm/cpu64.c  | 2 ++
 target/arm/helper.c | 5 ++---
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 7ac909448ea..e310ffc29d2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -813,6 +813,7 @@ struct ARMCPU {
     uint32_t id_isar3;
     uint32_t id_isar4;
     uint32_t id_isar5;
+    uint32_t id_isar6;
     uint64_t id_aa64pfr0;
     uint64_t id_aa64pfr1;
     uint64_t id_aa64dfr0;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 646b122e163..82ff450f9a7 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1273,6 +1273,7 @@ static void cortex_m3_initfn(Object *obj)
     cpu->id_isar3 = 0x01111110;
     cpu->id_isar4 = 0x01310102;
     cpu->id_isar5 = 0x00000000;
+    cpu->id_isar6 = 0x00000000;
 }
 
 static void cortex_m4_initfn(Object *obj)
@@ -1299,6 +1300,7 @@ static void cortex_m4_initfn(Object *obj)
     cpu->id_isar3 = 0x01111110;
     cpu->id_isar4 = 0x01310102;
     cpu->id_isar5 = 0x00000000;
+    cpu->id_isar6 = 0x00000000;
 }
 
 static void cortex_m33_initfn(Object *obj)
@@ -1327,6 +1329,7 @@ static void cortex_m33_initfn(Object *obj)
     cpu->id_isar3 = 0x01111131;
     cpu->id_isar4 = 0x01310132;
     cpu->id_isar5 = 0x00000000;
+    cpu->id_isar6 = 0x00000000;
     cpu->clidr = 0x00000000;
     cpu->ctr = 0x8000c000;
 }
@@ -1377,6 +1380,7 @@ static void cortex_r5_initfn(Object *obj)
     cpu->id_isar3 = 0x01112131;
     cpu->id_isar4 = 0x0010142;
     cpu->id_isar5 = 0x0;
+    cpu->id_isar6 = 0x0;
     cpu->mp_is_up = true;
     cpu->pmsav7_dregion = 16;
     define_arm_cp_regs(cpu, cortexr5_cp_reginfo);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 8040493d5cf..d0581d59d82 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -139,6 +139,7 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->id_isar3 = 0x01112131;
     cpu->id_isar4 = 0x00011142;
     cpu->id_isar5 = 0x00011121;
+    cpu->id_isar6 = 0;
     cpu->id_aa64pfr0 = 0x00002222;
     cpu->id_aa64dfr0 = 0x10305106;
     cpu->pmceid0 = 0x00000000;
@@ -199,6 +200,7 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->id_isar3 = 0x01112131;
     cpu->id_isar4 = 0x00011142;
     cpu->id_isar5 = 0x00011121;
+    cpu->id_isar6 = 0;
     cpu->id_aa64pfr0 = 0x00002222;
     cpu->id_aa64dfr0 = 0x10305106;
     cpu->id_aa64isar0 = 0x00011120;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index ae70b874c71..a2ac96084e7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4872,11 +4872,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
               .resetvalue = cpu->id_mmfr4 },
-            /* 7 is as yet unallocated and must RAZ */
-            { .name = "ID_ISAR7_RESERVED", .state = ARM_CP_STATE_BOTH,
+            { .name = "ID_ISAR6", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .resetvalue = 0 },
+              .resetvalue = cpu->id_isar6 },
             REGINFO_SENTINEL
         };
         define_arm_cp_regs(cpu, v6_idregs);
-- 
2.17.1
