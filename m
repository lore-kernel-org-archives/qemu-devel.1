Received: from eggs.gnu.org ([2001:4830:134:3::10]:37029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcDO-0001dL-5V
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcDK-00046n-HJ
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:54 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:51245)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fNcDK-00046D-AY
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:50 -0400
Received: by mail-wm0-x230.google.com with SMTP id r15-v6so11622058wmc.1
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 03:50:50 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 29 May 2018 12:49:54 +0200
Message-Id: <20180529105011.1914-22-edgar.iglesias@gmail.com>
In-Reply-To: <20180529105011.1914-1-edgar.iglesias@gmail.com>
References: <20180529105011.1914-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 21/38] target-microblaze: Setup for 64bit
 addressing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Setup MicroBlaze builds for 64bit addressing.
No functional change since the translator does not yet
emit 64bit addresses.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 configure               | 1 +
 target/microblaze/cpu.h | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index a8498ab393..a6a4616c3e 100755
--- a/configure
+++ b/configure
@@ -6844,6 +6844,7 @@ case "$target_name" in
   microblaze|microblazeel)
     TARGET_ARCH=microblaze
     bflt="yes"
+    echo "TARGET_ABI32=y" >> $config_target_mak
   ;;
   mips|mipsel)
     TARGET_ARCH=mips
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 215f42b384..b631b7dc4c 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -23,7 +23,7 @@
 #include "qemu-common.h"
 #include "cpu-qom.h"
 
-#define TARGET_LONG_BITS 32
+#define TARGET_LONG_BITS 64
 
 #define CPUArchState struct CPUMBState
 
@@ -340,8 +340,8 @@ int cpu_mb_signal_handler(int host_signum, void *pinfo,
 /* FIXME: MB uses variable pages down to 1K but linux only uses 4k.  */
 #define TARGET_PAGE_BITS 12
 
-#define TARGET_PHYS_ADDR_SPACE_BITS 32
-#define TARGET_VIRT_ADDR_SPACE_BITS 32
+#define TARGET_PHYS_ADDR_SPACE_BITS 64
+#define TARGET_VIRT_ADDR_SPACE_BITS 64
 
 #define CPU_RESOLVING_TYPE TYPE_MICROBLAZE_CPU
 
-- 
2.14.1
