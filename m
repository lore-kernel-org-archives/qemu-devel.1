Received: from eggs.gnu.org ([2001:4830:134:3::10]:35865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er7SD-0003am-DH
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er7SC-0006Wa-Io
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:53 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:35866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1er7SC-0006W3-Ch
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:52 -0500
Received: by mail-pf0-x241.google.com with SMTP id 68so1415700pfx.3
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 11:31:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 28 Feb 2018 11:31:25 -0800
Message-Id: <20180228193125.20577-17-richard.henderson@linaro.org>
In-Reply-To: <20180228193125.20577-1-richard.henderson@linaro.org>
References: <20180228193125.20577-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 16/16] target/arm: Enable ARM_FEATURE_V8_FCMA
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

Enable it for the "any" CPU used by *-linux-user.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c   | 1 +
 target/arm/cpu64.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ca5fb1162a..452bc32f10 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1651,6 +1651,7 @@ static void arm_any_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
     set_feature(&cpu->env, ARM_FEATURE_CRC);
     set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
+    set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
     cpu->midr = 0xffffffff;
 }
 #endif
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 7246866e7d..4228713b19 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -232,6 +232,7 @@ static void aarch64_any_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_CRC);
     set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
     set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
+    set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
     cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
     cpu->dcz_blocksize = 7; /*  512 bytes */
 }
-- 
2.14.3
