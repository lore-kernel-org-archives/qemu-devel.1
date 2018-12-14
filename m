Received: from eggs.gnu.org ([2001:4830:134:3::10]:58650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe0i-0005pW-03
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe0e-0006AB-Oe
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:31 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:32808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe0e-00067L-6D
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:28 -0500
Received: by mail-oi1-x242.google.com with SMTP id c206so3494892oib.0
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:19:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 21:18:51 -0600
Message-Id: <20181214031923.29527-2-richard.henderson@linaro.org>
In-Reply-To: <20181214031923.29527-1-richard.henderson@linaro.org>
References: <20181214031923.29527-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] fixup! target/arm: Move id_aa64mmfr* to
 ARMISARegisters
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

I didn't get this fix pushed back into the patch set that I actually
sent last week.  The patch is in target-arm.next, and I'm sure you
would have eventually seen the error in testing.


r~
---
 target/arm/kvm64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index ad83e1479c..089af9c5f0 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -538,9 +538,9 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                               ARM64_SYS_REG(3, 0, 0, 6, 0));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64isar1,
                               ARM64_SYS_REG(3, 0, 0, 6, 1));
-        err |= read_sys_reg64(fdarray[2], &achf->isar.id_aa64mmfr0,
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr0,
                               ARM64_SYS_REG(3, 0, 0, 7, 0));
-        err |= read_sys_reg64(fdarray[2], &achf->isar.id_aa64mmfr1,
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr1,
                               ARM64_SYS_REG(3, 0, 0, 7, 1));
 
         /*
-- 
2.17.2
