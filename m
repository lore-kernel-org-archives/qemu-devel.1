Received: from eggs.gnu.org ([2001:4830:134:3::10]:43690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWs-0003Bo-Nm
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWr-00056L-RJ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:10 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eriWr-00055v-KS
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:09 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWq-0001S4-P3
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:07:08 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Mar 2018 11:06:40 +0000
Message-Id: <20180302110640.28004-40-peter.maydell@linaro.org>
In-Reply-To: <20180302110640.28004-1-peter.maydell@linaro.org>
References: <20180302110640.28004-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 39/39] target/arm: Enable ARM_FEATURE_V8_FCMA
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

Enable it for the "any" CPU used by *-linux-user.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180228193125.20577-17-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c   | 1 +
 target/arm/cpu64.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3ee2d32aef..6b77aaa445 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1698,6 +1698,7 @@ static void arm_any_initfn(Object *obj)
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
2.16.2
