Received: from eggs.gnu.org ([2001:4830:134:3::10]:41391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYh4l-00041X-2p
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 20:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYh4k-0006g2-82
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 20:15:47 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:33539)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYh4k-0006fU-2y
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 20:15:46 -0400
Received: by mail-pl0-x242.google.com with SMTP id 6-v6so3556100plb.0
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 17:15:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Jun 2018 17:15:35 -0700
Message-Id: <20180629001538.11415-4-richard.henderson@linaro.org>
In-Reply-To: <20180629001538.11415-1-richard.henderson@linaro.org>
References: <20180629001538.11415-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/6] target/arm: Prune a57 features from max
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

There is no need to re-set these 9 features already
implied by the call to aarch64_a57_initfn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu64.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 3b4bc73ffa..8040493d5c 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -235,19 +235,10 @@ static void aarch64_max_initfn(Object *obj)
          * whereas the architecture requires them to be present in both if
          * present in either.
          */
-        set_feature(&cpu->env, ARM_FEATURE_V8);
-        set_feature(&cpu->env, ARM_FEATURE_VFP4);
-        set_feature(&cpu->env, ARM_FEATURE_NEON);
-        set_feature(&cpu->env, ARM_FEATURE_AARCH64);
-        set_feature(&cpu->env, ARM_FEATURE_V8_AES);
-        set_feature(&cpu->env, ARM_FEATURE_V8_SHA1);
-        set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
         set_feature(&cpu->env, ARM_FEATURE_V8_SHA512);
         set_feature(&cpu->env, ARM_FEATURE_V8_SHA3);
         set_feature(&cpu->env, ARM_FEATURE_V8_SM3);
         set_feature(&cpu->env, ARM_FEATURE_V8_SM4);
-        set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
-        set_feature(&cpu->env, ARM_FEATURE_CRC);
         set_feature(&cpu->env, ARM_FEATURE_V8_ATOMICS);
         set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
         set_feature(&cpu->env, ARM_FEATURE_V8_DOTPROD);
-- 
2.17.1
