Received: from eggs.gnu.org ([2001:4830:134:3::10]:34378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYunD-0007y6-G6
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fYunC-00081e-KA
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:35 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fYunC-0007y9-9c
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:54:34 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fYunB-0004rk-7R
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:54:33 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 15:53:46 +0100
Message-Id: <20180629145347.652-55-peter.maydell@linaro.org>
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 54/55] target/arm: Prune a15 features from max
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

There is no need to re-set these 3 features already
implied by the call to aarch64_a15_initfn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180629001538.11415-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 4584cd01bc1..646b122e163 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1803,9 +1803,6 @@ static void arm_max_initfn(Object *obj)
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
