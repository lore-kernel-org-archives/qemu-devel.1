Received: from eggs.gnu.org ([2001:4830:134:3::10]:49558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eqkAc-0004QA-CP
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 13:40:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eqkAb-0008Bu-JC
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 13:40:10 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 18:39:58 +0000
Message-Id: <20180227183958.15167-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] linux-user: Report AArch64 FP16 support via
 hwcap bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Set the appropriate Linux hwcap bits to tell the guest binary if we
have implemented half-precision floating point support.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is intended to go after Alex's FP16 stuff since it
uses the ARM_FEATURE_V8_FP16 bit that defines.
There is as yet no kernel definition of an AArch32 hwcap
bit to report FP16.

Based-on: <20180227143852.11175-1-alex.bennee@linaro.org>

 linux-user/elfload.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8bb9a2c3e8..80f1b32fbe 100644
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
