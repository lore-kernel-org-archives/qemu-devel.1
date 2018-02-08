Received: from eggs.gnu.org ([2001:4830:134:3::10]:54083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejq3I-0003Ee-Km
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejq3G-0006QN-Gu
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:04 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ejq3G-0006OQ-BY
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:02 -0500
Received: by mail-wm0-x242.google.com with SMTP id 141so11403198wme.3
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 09:32:02 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  8 Feb 2018 17:31:27 +0000
Message-Id: <20180208173157.24705-3-alex.bennee@linaro.org>
In-Reply-To: <20180208173157.24705-1-alex.bennee@linaro.org>
References: <20180208173157.24705-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 02/32] target/arm/cpu64: introduce
 ARM_V8_FP16 feature bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h   | 1 +
 target/arm/cpu64.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c7c922d79b..c793250186 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1339,6 +1339,7 @@ enum arm_features {
     ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
     ARM_FEATURE_JAZELLE, /* has (trivial) Jazelle implementation */
     ARM_FEATURE_SVE, /* has Scalable Vector Extension */
+    ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 670c07ab6e..973614dfc6 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -226,6 +226,7 @@ static void aarch64_any_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
     set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
     set_feature(&cpu->env, ARM_FEATURE_CRC);
+    set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
     cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
     cpu->dcz_blocksize = 7; /*  512 bytes */
 }
-- 
2.15.1
