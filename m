Received: from eggs.gnu.org ([209.51.188.92]:49585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1gzy4I-0002xb-Pu
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 01:24:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1gzy2A-00030u-Ts
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 01:22:07 -0500
Received: from mail02.asahi-net.or.jp ([202.224.55.14]:36031)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1gzy28-0002tq-Vd
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 01:22:05 -0500
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sat,  2 Mar 2019 15:21:37 +0900
Message-Id: <20190302062138.10713-11-ysato@users.sourceforge.jp>
In-Reply-To: <20190302062138.10713-1-ysato@users.sourceforge.jp>
References: <20190122121413.31437-1-ysato@users.sourceforge.jp>
	<20190302062138.10713-1-ysato@users.sourceforge.jp>
Subject: [Qemu-devel] [PATCH RFC v3 10/11] Add rx-softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, peter.maydell@linaro.org, richard.henderson@linaro.org

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch_init.c                    | 2 ++
 configure                      | 8 ++++++++
 default-configs/rx-softmmu.mak | 7 +++++++
 include/sysemu/arch_init.h     | 1 +
 4 files changed, 18 insertions(+)
 create mode 100644 default-configs/rx-softmmu.mak

diff --git a/arch_init.c b/arch_init.c
index f4f3f610c8..cc25ddd7ca 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -74,6 +74,8 @@ int graphic_depth = 32;
 #define QEMU_ARCH QEMU_ARCH_PPC
 #elif defined(TARGET_RISCV)
 #define QEMU_ARCH QEMU_ARCH_RISCV
+#elif defined(TARGET_RX)
+#define QEMU_ARCH QEMU_ARCH_RX
 #elif defined(TARGET_S390X)
 #define QEMU_ARCH QEMU_ARCH_S390X
 #elif defined(TARGET_SH4)
diff --git a/configure b/configure
index 540bee19ba..6bae0d4e97 100755
--- a/configure
+++ b/configure
@@ -7306,6 +7306,11 @@ case "$target_name" in
     mttcg=yes
     target_compiler=$cross_cc_riscv64
   ;;
+  rx)
+    TARGET_ARCH=rx
+    bflt="yes"
+    target_compiler=$cross_cc_rx
+  ;;
   sh4|sh4eb)
     TARGET_ARCH=sh4
     bflt="yes"
@@ -7526,6 +7531,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
   riscv*)
     disas_config "RISCV"
   ;;
+  rx)
+    disas_config "RX"
+  ;;
   s390*)
     disas_config "S390"
   ;;
diff --git a/default-configs/rx-softmmu.mak b/default-configs/rx-softmmu.mak
new file mode 100644
index 0000000000..0aaa8d4332
--- /dev/null
+++ b/default-configs/rx-softmmu.mak
@@ -0,0 +1,7 @@
+# Default configuration for rx-softmmu
+
+CONFIG_SERIAL=y
+CONFIG_PTIMER=y
+CONFIG_RX=y
+CONFIG_RENESAS_SCI=y
+CONFIG_RX_DIS=y
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 10cbafe970..3f4f844f7b 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -25,6 +25,7 @@ enum {
     QEMU_ARCH_NIOS2 = (1 << 17),
     QEMU_ARCH_HPPA = (1 << 18),
     QEMU_ARCH_RISCV = (1 << 19),
+    QEMU_ARCH_RX = (1 << 20),
 };
 
 extern const uint32_t arch_type;
-- 
2.11.0
