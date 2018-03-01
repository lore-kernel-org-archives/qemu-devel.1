Received: from eggs.gnu.org ([2001:4830:134:3::10]:33652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJr-0003fn-89
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJq-00084t-Di
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:15 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1erMJq-00082m-6T
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:14 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJn-0000ZO-BN
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:24:11 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Mar 2018 11:23:31 +0000
Message-Id: <20180301112403.12487-11-peter.maydell@linaro.org>
In-Reply-To: <20180301112403.12487-1-peter.maydell@linaro.org>
References: <20180301112403.12487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/42] target/arm/cpu64: introduce ARM_V8_FP16
 feature bit
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180227143852.11175-3-alex.bennee@linaro.org
[PMM: postpone actually enabling feature until end of the
 patch series]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8c839faa8f..267a9d7e2f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1408,6 +1408,7 @@ enum arm_features {
     ARM_FEATURE_V8_SHA3, /* implements SHA3 part of v8 Crypto Extensions */
     ARM_FEATURE_V8_SM3, /* implements SM3 part of v8 Crypto Extensions */
     ARM_FEATURE_V8_SM4, /* implements SM4 part of v8 Crypto Extensions */
+    ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
-- 
2.16.2
