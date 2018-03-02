Received: from eggs.gnu.org ([2001:4830:134:3::10]:43611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWo-000381-2I
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWn-00054F-9m
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:06 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eriWn-00051l-35
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:05 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWl-0001QJ-UH
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:07:03 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Mar 2018 11:06:33 +0000
Message-Id: <20180302110640.28004-33-peter.maydell@linaro.org>
In-Reply-To: <20180302110640.28004-1-peter.maydell@linaro.org>
References: <20180302110640.28004-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 32/39] target/arm: Enable ARM_FEATURE_V8_RDM
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
Message-id: 20180228193125.20577-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c   | 1 +
 target/arm/cpu64.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e08b1e7943..3ee2d32aef 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1697,6 +1697,7 @@ static void arm_any_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
     set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
     set_feature(&cpu->env, ARM_FEATURE_CRC);
+    set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
     cpu->midr = 0xffffffff;
 }
 #endif
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 9743bdc8c3..7246866e7d 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -230,6 +230,7 @@ static void aarch64_any_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V8_SM4);
     set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
     set_feature(&cpu->env, ARM_FEATURE_CRC);
+    set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
     set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
     cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
     cpu->dcz_blocksize = 7; /*  512 bytes */
-- 
2.16.2
