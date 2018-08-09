Received: from eggs.gnu.org ([2001:4830:134:3::10]:53964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncSk-0000iA-T5
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fncSk-00078h-5S
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:14 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fncSj-00077r-Vo
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 00:22:14 -0400
Received: by mail-pf1-x444.google.com with SMTP id p12-v6so2206894pfh.2
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 21:22:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  8 Aug 2018 21:21:49 -0700
Message-Id: <20180809042206.15726-4-richard.henderson@linaro.org>
In-Reply-To: <20180809042206.15726-1-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 03/20] target/arm: Define ID_AA64ZFR0_EL1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org

Given that the only field defined for this new register may only
be 0, we don't actually need to change anything except the name.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c24c66d43e..61a79e4c44 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4956,9 +4956,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
