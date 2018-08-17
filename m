Received: from eggs.gnu.org ([2001:4830:134:3::10]:52936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqfMg-0004ph-83
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqfMZ-0007cf-6F
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:33 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45449 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fqfMY-0007ZS-AR
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:04:26 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 17 Aug 2018 16:03:49 +0200
Message-Id: <1534514633-13725-62-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534514633-13725-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534514633-13725-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v10 61/65] linux-user: Add nanoMIPS linux user
 mode configuration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Stefan Markovic <smarkovic@wavecomp.com>

Add new linux user mode configuration for nanoMIPS.

Signed-off-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 configure                               | 13 ++++++++++++-
 default-configs/nanomips-linux-user.mak |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 default-configs/nanomips-linux-user.mak

diff --git a/configure b/configure
index db97930..becec5a 100755
--- a/configure
+++ b/configure
@@ -742,6 +742,9 @@ case "$cpu" in
     supported_cpu="yes"
     cross_cc_mips=$host_cc
   ;;
+  nanomips*)
+    cpu="mips"
+  ;;
   sparc|sun4[cdmuv])
     cpu="sparc"
     supported_cpu="yes"
@@ -6883,7 +6886,7 @@ target_name=$(echo $target | cut -d '-' -f 1)
 target_bigendian="no"
 
 case "$target_name" in
-  armeb|aarch64_be|hppa|lm32|m68k|microblaze|mips|mipsn32|mips64|moxie|or1k|ppc|ppcemb|ppc64|ppc64abi32|s390x|sh4eb|sparc|sparc64|sparc32plus|xtensaeb)
+  armeb|aarch64_be|hppa|lm32|m68k|microblaze|mips|mipsn32|mips64|moxie|nanomipseb|or1k|ppc|ppcemb|ppc64|ppc64abi32|s390x|sh4eb|sparc|sparc64|sparc32plus|xtensaeb)
   target_bigendian=yes
   ;;
 esac
@@ -6999,6 +7002,11 @@ case "$target_name" in
   moxie)
     target_compiler=$cross_cc_moxie
   ;;
+  nanomips|nanomipseb)
+    TARGET_ARCH=nanomips
+    TARGET_BASE_ARCH=mips
+    echo "TARGET_ABI_MIPSP32=y" >> $config_target_mak
+  ;;
   nios2)
     target_compiler=$cross_cc_nios2
   ;;
@@ -7256,6 +7264,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
   moxie*)
     disas_config "MOXIE"
   ;;
+  nanomips*)
+    disas_config "MIPS"
+  ;;
   nios2)
     disas_config "NIOS2"
   ;;
diff --git a/default-configs/nanomips-linux-user.mak b/default-configs/nanomips-linux-user.mak
new file mode 100644
index 0000000..68fc1f7
--- /dev/null
+++ b/default-configs/nanomips-linux-user.mak
@@ -0,0 +1 @@
+# Default configuration for nanomips-linux-user
-- 
2.7.4
