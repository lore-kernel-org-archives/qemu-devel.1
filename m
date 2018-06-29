Received: from eggs.gnu.org ([2001:4830:134:3::10]:34364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYunC-0007x3-OM
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYunB-0007yQ-P0
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:34 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYunB-0007rD-Ez
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:33 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYunA-0004rQ-63
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:54:32 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:53:45 +0100
Message-Id: <20180629145347.652-54-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 53/55] target/arm: Prune a57 features from max
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

There is no need to re-set these 9 features already
implied by the call to aarch64_a57_initfn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180629001538.11415-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu64.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 3b4bc73ffa6..8040493d5cf 100644
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
