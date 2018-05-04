Received: from eggs.gnu.org ([2001:4830:134:3::10]:45680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEfTb-0007cB-8n
	for qemu-devel@nongnu.org; Fri, 04 May 2018 14:30:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEfTa-0001Go-Fa
	for qemu-devel@nongnu.org; Fri, 04 May 2018 14:30:39 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:40584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fEfTa-0001G0-AB
	for qemu-devel@nongnu.org; Fri, 04 May 2018 14:30:38 -0400
Received: by mail-pg0-x243.google.com with SMTP id l2-v6so15967999pgc.7
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 11:30:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  4 May 2018 11:30:21 -0700
Message-Id: <20180504183021.19318-11-richard.henderson@linaro.org>
In-Reply-To: <20180504183021.19318-1-richard.henderson@linaro.org>
References: <20180504183021.19318-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 10/10] target/arm: Enable
 ARM_FEATURE_V8_ATOMICS for user-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 991d764674..c50dcd4077 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -248,6 +248,7 @@ static void aarch64_max_initfn(Object *obj)
         set_feature(&cpu->env, ARM_FEATURE_V8_SM4);
         set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
         set_feature(&cpu->env, ARM_FEATURE_CRC);
+        set_feature(&cpu->env, ARM_FEATURE_V8_ATOMICS);
         set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
         set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
         set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
-- 
2.14.3
