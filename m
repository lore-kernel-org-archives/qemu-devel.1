Received: from eggs.gnu.org ([2001:4830:134:3::10]:35378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8UIb-00011g-3c
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 13:54:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8UIY-0003AI-Ji
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 13:54:00 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:44189)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g8UIY-00039t-ES
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 13:53:58 -0400
Received: by mail-oi1-x231.google.com with SMTP id u74-v6so11054165oia.11
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 10:53:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  5 Oct 2018 12:53:36 -0500
Message-Id: <20181005175350.30752-2-richard.henderson@linaro.org>
In-Reply-To: <20181005175350.30752-1-richard.henderson@linaro.org>
References: <20181005175350.30752-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 01/15] target/arm: Define ID_AA64ZFR0_EL1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Given that the only field defined for this new register may only
be 0, we don't actually need to change anything except the name.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 64b1564594..ef85ef230a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5018,9 +5018,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
               .resetvalue = 0 },
-            { .name = "ID_AA64PFR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
+            { .name = "ID_AA64ZFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
+              /* At present, only SVEver == 0 is defined anyway.  */
               .resetvalue = 0 },
             { .name = "ID_AA64PFR5_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 5,
-- 
2.17.1
