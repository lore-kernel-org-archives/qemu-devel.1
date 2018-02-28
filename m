Received: from eggs.gnu.org ([2001:4830:134:3::10]:35668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er7S4-0003Q7-1D
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er7S3-0006P5-D5
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:44 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:40672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1er7S3-0006OR-6j
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:43 -0500
Received: by mail-pl0-x242.google.com with SMTP id i6-v6so2117587plt.7
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 11:31:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 28 Feb 2018 11:31:19 -0800
Message-Id: <20180228193125.20577-11-richard.henderson@linaro.org>
In-Reply-To: <20180228193125.20577-1-richard.henderson@linaro.org>
References: <20180228193125.20577-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 10/16] target/arm: Add ARM_FEATURE_V8_FCMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

Not enabled anywhere yet.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h     | 1 +
 linux-user/elfload.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 7c8e87544a..f67f357724 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1429,6 +1429,7 @@ enum arm_features {
     ARM_FEATURE_V8_SM4, /* implements SM4 part of v8 Crypto Extensions */
     ARM_FEATURE_V8_RDM, /* implements v8.1 simd round multiply */
     ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
+    ARM_FEATURE_V8_FCMA, /* has complex number part of v8.3 extensions.  */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 63cadae1b4..3ead6ed807 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -552,6 +552,7 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE(ARM_FEATURE_V8_SM4, ARM_HWCAP_A64_SM4);
     GET_FEATURE(ARM_FEATURE_V8_SHA512, ARM_HWCAP_A64_SHA512);
     GET_FEATURE(ARM_FEATURE_V8_RDM, ARM_HWCAP_A64_ASIMDRDM);
+    GET_FEATURE(ARM_FEATURE_V8_FCMA, ARM_HWCAP_A64_FCMA);
 #undef GET_FEATURE
 
     return hwcaps;
-- 
2.14.3
