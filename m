Received: from eggs.gnu.org ([2001:4830:134:3::10]:60585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gMFhr-00042F-26
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:08:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gMFhq-0000fN-AZ
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:08:59 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gMFhp-0008MG-UD
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:08:58 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gMFhO-0005st-6B
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 17:08:30 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Nov 2018 17:08:10 +0000
Message-Id: <20181112170816.500-11-peter.maydell@linaro.org>
In-Reply-To: <20181112170816.500-1-peter.maydell@linaro.org>
References: <20181112170816.500-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/16] arm: use symbolic MDCR_TDE in
 arm_debug_target_el
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

We already have this symbol defined so lets use it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181109152119.9242-7-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b5eff79f73b..1efff21a18d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2743,7 +2743,7 @@ static inline int arm_debug_target_el(CPUARMState *env)
 
     if (arm_feature(env, ARM_FEATURE_EL2) && !secure) {
         route_to_el2 = env->cp15.hcr_el2 & HCR_TGE ||
-                       env->cp15.mdcr_el2 & (1 << 8);
+                       env->cp15.mdcr_el2 & MDCR_TDE;
     }
 
     if (route_to_el2) {
-- 
2.19.1
