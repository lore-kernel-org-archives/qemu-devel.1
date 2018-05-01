Received: from eggs.gnu.org ([2001:4830:134:3::10]:41200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mathew1800@gmail.com>) id 1fDaLb-0003xZ-8T
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mathew1800@gmail.com>) id 1fDaLY-0006zn-RO
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:49:55 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:35811)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mathew1800@gmail.com>)
	id 1fDaLY-0006ze-Lz
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:49:52 -0400
Received: by mail-it0-x242.google.com with SMTP id 186-v6so14152725itu.0
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 11:49:52 -0700 (PDT)
From: Mathew Maidment <mathew1800@gmail.com>
Date: Tue,  1 May 2018 14:49:33 -0400
Message-Id: <20180501184933.37609-2-mathew1800@gmail.com>
In-Reply-To: <20180501184933.37609-1-mathew1800@gmail.com>
References: <20180501184933.37609-1-mathew1800@gmail.com>
Subject: [Qemu-devel] [PATCH 1/1] target/arm: Correct MPUIR privilege level
 in register_cp_regs_for_features() conditional case
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

The duplication of id_tlbtr_reginfo was unintentionally added within
3281af8114c6b8ead02f08b58e3c36895c1ea047 which should have been id_mpuir_reginfo.

Signed-off-by: Mathew Maidment <mathew1800@gmail.com>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 52a88e0297..0fef5d4d06 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5347,7 +5347,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             for (r = id_cp_reginfo; r->type != ARM_CP_SENTINEL; r++) {
                 r->access = PL1_RW;
             }
-            id_tlbtr_reginfo.access = PL1_RW;
+            id_mpuir_reginfo.access = PL1_RW;
             id_tlbtr_reginfo.access = PL1_RW;
         }
         if (arm_feature(env, ARM_FEATURE_V8)) {
-- 
2.15.1 (Apple Git-101)
