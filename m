Received: from eggs.gnu.org ([2001:4830:134:3::10]:44470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzFR-0002is-AM
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzFQ-0004nO-3z
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:41 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:45035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQzFP-0004mK-U6
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:40 -0500
Received: by mail-pl0-x244.google.com with SMTP id n13so5214239plp.11
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:30:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:30:22 -0800
Message-Id: <20171218173022.18418-10-richard.henderson@linaro.org>
In-Reply-To: <20171218173022.18418-1-richard.henderson@linaro.org>
References: <20171218173022.18418-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 9/9] target/arm: Add ARM_FEATURE_SVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Enable it for the "any" CPU used by aarch64-linux-user.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h   | 1 +
 target/arm/cpu64.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 37b8cef2e2..652e00d957 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1386,6 +1386,7 @@ enum arm_features {
     ARM_FEATURE_V8_1_SIMD, /* has ARMv8.1-SIMD */
     ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
     ARM_FEATURE_V8_FCMA, /* has complex number part of v8.3 extensions.  */
+    ARM_FEATURE_SVE, /* has SVE extension */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 43b42f95fd..366ab2eeee 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -229,6 +229,7 @@ static void aarch64_any_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8_1_SIMD);
     set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
     set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
+    set_feature(&cpu->env, ARM_FEATURE_SVE);
     cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
     cpu->dcz_blocksize = 7; /*  512 bytes */
 }
-- 
2.14.3
