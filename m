Received: from eggs.gnu.org ([2001:4830:134:3::10]:42502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gL8bC-0001Co-UE
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:21:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gL8bA-00031C-Mf
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:21:30 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:32811)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gL8bA-0002vb-Bz
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:21:28 -0500
Received: by mail-wr1-x442.google.com with SMTP id u9-v6so2313533wrr.0
	for <qemu-devel@nongnu.org>; Fri, 09 Nov 2018 07:21:26 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  9 Nov 2018 15:21:18 +0000
Message-Id: <20181109152119.9242-7-alex.bennee@linaro.org>
In-Reply-To: <20181109152119.9242-1-alex.bennee@linaro.org>
References: <20181109152119.9242-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 6/7] arm: use symbolic MDCR_TDE in
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
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

We already have this symbol defined so lets use it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b5eff79f73..1efff21a18 100644
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
2.17.1
