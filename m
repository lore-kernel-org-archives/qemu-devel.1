Received: from eggs.gnu.org ([2001:4830:134:3::10]:53490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD0T-0004Rn-E3
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD0R-0007qg-Ty
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:49 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:37299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYD0R-0007qH-LT
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:47 -0400
Received: by mail-wm0-x22e.google.com with SMTP id g127so29685145wmd.0
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:04:47 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 20 Jul 2017 16:04:12 +0100
Message-Id: <20170720150426.12393-10-alex.bennee@linaro.org>
In-Reply-To: <20170720150426.12393-1-alex.bennee@linaro.org>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
Subject: [Qemu-devel] [RFC PATCH for 2.11 09/23] arm: introduce ARM_V8_FP16
 feature bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: rth@twiddle.net, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

---
 target/arm/cpu.h   | 1 +
 target/arm/cpu64.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1f565fd503..adf2524fe0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1230,6 +1230,7 @@ enum arm_features {
     ARM_FEATURE_THUMB_DSP, /* DSP insns supported in the Thumb encodings */
     ARM_FEATURE_PMU, /* has PMU support */
     ARM_FEATURE_VBAR, /* has cp15 VBAR */
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
2.13.0
