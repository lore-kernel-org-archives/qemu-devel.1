Received: from eggs.gnu.org ([2001:4830:134:3::10]:34132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMKB-00042T-LR
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMKA-0008Gr-Sb
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:35 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1erMKA-0008G3-MM
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:34 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1erMK9-0000hp-JC
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:24:33 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Mar 2018 11:24:02 +0000
Message-Id: <20180301112403.12487-42-peter.maydell@linaro.org>
In-Reply-To: <20180301112403.12487-1-peter.maydell@linaro.org>
References: <20180301112403.12487-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 41/42] linux-user: Report AArch64 FP16 support
 via hwcap bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Set the appropriate Linux hwcap bits to tell the guest binary if we
have implemented half-precision floating point support.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0208022445..6689089cd2 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -551,6 +551,8 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE(ARM_FEATURE_V8_SM3, ARM_HWCAP_A64_SM3);
     GET_FEATURE(ARM_FEATURE_V8_SM4, ARM_HWCAP_A64_SM4);
     GET_FEATURE(ARM_FEATURE_V8_SHA512, ARM_HWCAP_A64_SHA512);
+    GET_FEATURE(ARM_FEATURE_V8_FP16,
+                ARM_HWCAP_A64_FPHP | ARM_HWCAP_A64_ASIMDHP);
 #undef GET_FEATURE
 
     return hwcaps;
-- 
2.16.2
