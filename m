Received: from eggs.gnu.org ([2001:4830:134:3::10]:43662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWr-0003BF-Ij
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWn-00054e-Nt
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:09 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eriWn-00053X-GP
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:05 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWm-0001QX-KJ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:07:04 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Mar 2018 11:06:34 +0000
Message-Id: <20180302110640.28004-34-peter.maydell@linaro.org>
In-Reply-To: <20180302110640.28004-1-peter.maydell@linaro.org>
References: <20180302110640.28004-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 33/39] target/arm: Add ARM_FEATURE_V8_FCMA
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

Not enabled anywhere yet.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180228193125.20577-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h     | 1 +
 linux-user/elfload.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c4d6992f1d..8dd6b788df 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1435,6 +1435,7 @@ enum arm_features {
     ARM_FEATURE_V8_SM4, /* implements SM4 part of v8 Crypto Extensions */
     ARM_FEATURE_V8_RDM, /* implements v8.1 simd round multiply */
     ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
+    ARM_FEATURE_V8_FCMA, /* has complex number part of v8.3 extensions.  */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 3a55fb33a8..e3689c658a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -554,6 +554,7 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE(ARM_FEATURE_V8_FP16,
                 ARM_HWCAP_A64_FPHP | ARM_HWCAP_A64_ASIMDHP);
     GET_FEATURE(ARM_FEATURE_V8_RDM, ARM_HWCAP_A64_ASIMDRDM);
+    GET_FEATURE(ARM_FEATURE_V8_FCMA, ARM_HWCAP_A64_FCMA);
 #undef GET_FEATURE
 
     return hwcaps;
-- 
2.16.2
