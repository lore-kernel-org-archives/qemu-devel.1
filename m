Received: from eggs.gnu.org ([2001:4830:134:3::10]:55698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eqgPF-0003ZH-L2
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:39:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eqgPB-0007uK-SU
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:39:01 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:39900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eqgPB-0007tq-LE
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:38:57 -0500
Received: by mail-wr0-x242.google.com with SMTP id w77so25076417wrc.6
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 06:38:57 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 27 Feb 2018 14:38:23 +0000
Message-Id: <20180227143852.11175-3-alex.bennee@linaro.org>
In-Reply-To: <20180227143852.11175-1-alex.bennee@linaro.org>
References: <20180227143852.11175-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 02/31] target/arm/cpu64: introduce
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
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h   | 1 +
 target/arm/cpu64.c | 1 +
 2 files changed, 2 insertions(+)

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
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 1c330adc28..9743bdc8c3 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -230,6 +230,7 @@ static void aarch64_any_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8_SM4);
     set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
     set_feature(&cpu->env, ARM_FEATURE_CRC);
+    set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
     cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
     cpu->dcz_blocksize = 7; /*  512 bytes */
 }
-- 
2.15.1
