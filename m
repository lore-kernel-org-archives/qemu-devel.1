Received: from eggs.gnu.org ([2001:4830:134:3::10]:41404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYh4m-000426-HT
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 20:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYh4l-0006gl-LO
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 20:15:48 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:39642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYh4l-0006gO-El
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 20:15:47 -0400
Received: by mail-pf0-x22a.google.com with SMTP id s21-v6so3344370pfm.6
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 17:15:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Jun 2018 17:15:36 -0700
Message-Id: <20180629001538.11415-5-richard.henderson@linaro.org>
In-Reply-To: <20180629001538.11415-1-richard.henderson@linaro.org>
References: <20180629001538.11415-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 4/6] target/arm: Prune a15 features from max
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

There is no need to re-set these 3 features already
implied by the call to aarch64_a15_initfn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index aa62315cea..878cc6c7e8 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1796,9 +1796,6 @@ static void arm_max_initfn(Object *obj)
          * since we don't correctly set the ID registers to advertise them,
          */
         set_feature(&cpu->env, ARM_FEATURE_V8);
-        set_feature(&cpu->env, ARM_FEATURE_VFP4);
-        set_feature(&cpu->env, ARM_FEATURE_NEON);
-        set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
         set_feature(&cpu->env, ARM_FEATURE_V8_AES);
         set_feature(&cpu->env, ARM_FEATURE_V8_SHA1);
         set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
-- 
2.17.1
