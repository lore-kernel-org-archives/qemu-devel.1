Received: from eggs.gnu.org ([2001:4830:134:3::10]:45095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO8G-0004Um-C1
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO8D-0001BK-KK
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:00 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:32867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cdO8D-0001B9-Gf
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:25:57 -0500
Received: by mail-qt0-x244.google.com with SMTP id n13so15080555qtc.0
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 13:25:57 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 14 Feb 2017 08:25:13 +1100
Message-Id: <20170213212536.31871-2-rth@twiddle.net>
In-Reply-To: <20170213212536.31871-1-rth@twiddle.net>
References: <20170213212536.31871-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 01/24] target/openrisc: Rename the cpu from or32
 to or1k
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

This is in keeping with the toolchain and or1ksim.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 configure                           | 6 +++---
 default-configs/or1k-linux-user.mak | 1 +
 default-configs/or1k-softmmu.mak    | 4 ++++
 default-configs/or32-linux-user.mak | 1 -
 default-configs/or32-softmmu.mak    | 4 ----
 hw/openrisc/openrisc_sim.c          | 4 ++--
 target/openrisc/cpu.h               | 2 +-
 tests/tcg/openrisc/Makefile         | 4 ++--
 8 files changed, 13 insertions(+), 13 deletions(-)
 create mode 100644 default-configs/or1k-linux-user.mak
 create mode 100644 default-configs/or1k-softmmu.mak
 delete mode 100644 default-configs/or32-linux-user.mak
 delete mode 100644 default-configs/or32-softmmu.mak

diff --git a/configure b/configure
index 6325339..1c9655e 100755
--- a/configure
+++ b/configure
@@ -5843,7 +5843,7 @@ target_name=$(echo $target | cut -d '-' -f 1)
 target_bigendian="no"
 
 case "$target_name" in
-  armeb|hppa|lm32|m68k|microblaze|mips|mipsn32|mips64|moxie|or32|ppc|ppcemb|ppc64|ppc64abi32|s390x|sh4eb|sparc|sparc64|sparc32plus|xtensaeb)
+  armeb|hppa|lm32|m68k|microblaze|mips|mipsn32|mips64|moxie|or1k|ppc|ppcemb|ppc64|ppc64abi32|s390x|sh4eb|sparc|sparc64|sparc32plus|xtensaeb)
   target_bigendian=yes
   ;;
 esac
@@ -5937,7 +5937,7 @@ case "$target_name" in
   ;;
   nios2)
   ;;
-  or32)
+  or1k)
     TARGET_ARCH=openrisc
     TARGET_BASE_ARCH=openrisc
   ;;
@@ -6145,7 +6145,7 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
   nios2)
     disas_config "NIOS2"
   ;;
-  or32)
+  or1k)
     disas_config "OPENRISC"
   ;;
   ppc*)
diff --git a/default-configs/or1k-linux-user.mak b/default-configs/or1k-linux-user.mak
new file mode 100644
index 0000000..20e03c1
--- /dev/null
+++ b/default-configs/or1k-linux-user.mak
@@ -0,0 +1 @@
+# Default configuration for or1k-linux-user
diff --git a/default-configs/or1k-softmmu.mak b/default-configs/or1k-softmmu.mak
new file mode 100644
index 0000000..10bfa7a
--- /dev/null
+++ b/default-configs/or1k-softmmu.mak
@@ -0,0 +1,4 @@
+# Default configuration for or1k-softmmu
+
+CONFIG_SERIAL=y
+CONFIG_OPENCORES_ETH=y
diff --git a/default-configs/or32-linux-user.mak b/default-configs/or32-linux-user.mak
deleted file mode 100644
index 808c1f9..0000000
--- a/default-configs/or32-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for or32-linux-user
diff --git a/default-configs/or32-softmmu.mak b/default-configs/or32-softmmu.mak
deleted file mode 100644
index cce4746..0000000
--- a/default-configs/or32-softmmu.mak
+++ /dev/null
@@ -1,4 +0,0 @@
-# Default configuration for or32-softmmu
-
-CONFIG_SERIAL=y
-CONFIG_OPENCORES_ETH=y
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 6d06d5b..fc0d096 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -139,10 +139,10 @@ static void openrisc_sim_init(MachineState *machine)
 
 static void openrisc_sim_machine_init(MachineClass *mc)
 {
-    mc->desc = "or32 simulation";
+    mc->desc = "or1k simulation";
     mc->init = openrisc_sim_init;
     mc->max_cpus = 1;
     mc->is_default = 1;
 }
 
-DEFINE_MACHINE("or32-sim", openrisc_sim_machine_init)
+DEFINE_MACHINE("or1k-sim", openrisc_sim_machine_init)
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 508ef56..231c163 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -32,7 +32,7 @@ struct OpenRISCCPU;
 #include "fpu/softfloat.h"
 #include "qom/cpu.h"
 
-#define TYPE_OPENRISC_CPU "or32-cpu"
+#define TYPE_OPENRISC_CPU "or1k-cpu"
 
 #define OPENRISC_CPU_CLASS(klass) \
     OBJECT_CLASS_CHECK(OpenRISCCPUClass, (klass), TYPE_OPENRISC_CPU)
diff --git a/tests/tcg/openrisc/Makefile b/tests/tcg/openrisc/Makefile
index 7e65888..fb5ceda 100644
--- a/tests/tcg/openrisc/Makefile
+++ b/tests/tcg/openrisc/Makefile
@@ -1,8 +1,8 @@
 -include ../../config-host.mak
 
-CROSS = or32-linux-
+CROSS = or1k-linux-
 
-SIM = qemu-or32
+SIM = qemu-or1k
 
 CC = $(CROSS)gcc
 
-- 
2.9.3
