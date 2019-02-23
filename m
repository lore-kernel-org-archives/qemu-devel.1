Received: from eggs.gnu.org ([209.51.188.92]:55591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxNER-0002us-HR
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 21:40:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxNEQ-0002UM-OO
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 21:40:03 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gxNEQ-0002TJ-Gz
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 21:40:02 -0500
Received: by mail-pg1-x543.google.com with SMTP id r124so1939050pgr.3
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 18:40:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 22 Feb 2019 18:39:52 -0800
Message-Id: <20190223023957.18865-2-richard.henderson@linaro.org>
In-Reply-To: <20190223023957.18865-1-richard.henderson@linaro.org>
References: <20190223023957.18865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/6] target/arm: Implement ID_PFR2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

This was defined at some point before ARMv8.4, and will
shortly be used by new processor descriptions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    | 1 +
 target/arm/helper.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 84ae6849c2..c57f8e9ba8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -863,6 +863,7 @@ struct ARMCPU {
     uint32_t reset_sctlr;
     uint32_t id_pfr0;
     uint32_t id_pfr1;
+    uint32_t id_pfr2;
     uint32_t id_dfr0;
     uint64_t pmceid0;
     uint64_t pmceid1;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a018eb23fe..8903cc13d8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6092,10 +6092,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
               .resetvalue = 0 },
-            { .name = "MVFR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
+            { .name = "ID_PFR2", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .resetvalue = 0 },
+              .resetvalue = cpu->id_pfr2 },
             { .name = "MVFR5_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
-- 
2.17.2
