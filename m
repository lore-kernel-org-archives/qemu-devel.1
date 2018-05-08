Received: from eggs.gnu.org ([2001:4830:134:3::10]:59634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fG4KN-0006iY-Qf
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fG4KM-0008IS-MT
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:14:55 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:39934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fG4KM-0008Hr-GX
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:14:54 -0400
Received: by mail-pl0-x241.google.com with SMTP id q18-v6so2421291plr.6
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 08:14:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue,  8 May 2018 08:14:37 -0700
Message-Id: <20180508151437.4232-11-richard.henderson@linaro.org>
In-Reply-To: <20180508151437.4232-1-richard.henderson@linaro.org>
References: <20180508151437.4232-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 10/10] target/arm: Enable
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
Cc: peter.maydell@linaro.org

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
2.17.0
