Received: from eggs.gnu.org ([2001:4830:134:3::10]:35407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er7Rs-0003FE-MK
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er7Rq-0006EV-Hn
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:32 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:43932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1er7Rq-0006E3-Bt
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:31:30 -0500
Received: by mail-pf0-x241.google.com with SMTP id z14so1408329pfe.10
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 11:31:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 28 Feb 2018 11:31:10 -0800
Message-Id: <20180228193125.20577-2-richard.henderson@linaro.org>
In-Reply-To: <20180228193125.20577-1-richard.henderson@linaro.org>
References: <20180228193125.20577-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 01/16] target/arm: Add ARM_FEATURE_V8_RDM
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h     | 1 +
 linux-user/elfload.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2b9740878b..7c8e87544a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1427,6 +1427,7 @@ enum arm_features {
     ARM_FEATURE_V8_SHA3, /* implements SHA3 part of v8 Crypto Extensions */
     ARM_FEATURE_V8_SM3, /* implements SM3 part of v8 Crypto Extensions */
     ARM_FEATURE_V8_SM4, /* implements SM4 part of v8 Crypto Extensions */
+    ARM_FEATURE_V8_RDM, /* implements v8.1 simd round multiply */
     ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
 };
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8bb9a2c3e8..63cadae1b4 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -551,6 +551,7 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE(ARM_FEATURE_V8_SM3, ARM_HWCAP_A64_SM3);
     GET_FEATURE(ARM_FEATURE_V8_SM4, ARM_HWCAP_A64_SM4);
     GET_FEATURE(ARM_FEATURE_V8_SHA512, ARM_HWCAP_A64_SHA512);
+    GET_FEATURE(ARM_FEATURE_V8_RDM, ARM_HWCAP_A64_ASIMDRDM);
 #undef GET_FEATURE
 
     return hwcaps;
-- 
2.14.3
