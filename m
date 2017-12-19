Received: from eggs.gnu.org ([2001:4830:134:3::10]:47303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@rivendell.weiser.dinsnail.net>)
	id 1eROMs-0002Q9-79
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 15:20:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@rivendell.weiser.dinsnail.net>)
	id 1eROMr-0000Mb-CK
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 15:20:02 -0500
Received: from heinz.dinsnail.net
	([2a01:238:43b4:3200:9392:5dcc:2f0e:a960]:47144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@rivendell.weiser.dinsnail.net>)
	id 1eROMr-0000LR-6Z
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 15:20:01 -0500
From: Michael Weiser <michael.weiser@gmx.de>
Date: Tue, 19 Dec 2017 21:16:12 +0100
Message-Id: <20171219201613.7399-5-michael.weiser@gmx.de>
In-Reply-To: <20171219201613.7399-1-michael.weiser@gmx.de>
References: <20171219201613.7399-1-michael.weiser@gmx.de>
Subject: [Qemu-devel] [PATCH v2 4/5] configure: Add aarch64_be-linux-user
 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Weiser <michael.weiser@gmx.de>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Add target aarch64_be-linux-user. This allows a qemu-aarch64_be binary
to be built that will run big-endian aarch64 binaries.

Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
---
 configure                                 | 9 +++++----
 default-configs/aarch64_be-linux-user.mak | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)
 create mode 100644 default-configs/aarch64_be-linux-user.mak

diff --git a/configure b/configure
index 9c8aa5a98b..03d95340d8 100755
--- a/configure
+++ b/configure
@@ -657,7 +657,7 @@ case "$cpu" in
     cpu="arm"
     supported_cpu="yes"
   ;;
-  aarch64)
+  aarch64|aarch64_be)
     cpu="aarch64"
     supported_cpu="yes"
   ;;
@@ -6345,7 +6345,7 @@ if test "$linux" = "yes" ; then
   s390x)
     linux_arch=s390
     ;;
-  aarch64)
+  aarch64|aarch64_be)
     linux_arch=arm64
     ;;
   mips64)
@@ -6369,7 +6369,7 @@ target_name=$(echo $target | cut -d '-' -f 1)
 target_bigendian="no"
 
 case "$target_name" in
-  armeb|hppa|lm32|m68k|microblaze|mips|mipsn32|mips64|moxie|or1k|ppc|ppcemb|ppc64|ppc64abi32|s390x|sh4eb|sparc|sparc64|sparc32plus|xtensaeb)
+  armeb|aarch64_be|hppa|lm32|m68k|microblaze|mips|mipsn32|mips64|moxie|or1k|ppc|ppcemb|ppc64|ppc64abi32|s390x|sh4eb|sparc|sparc64|sparc32plus|xtensaeb)
   target_bigendian=yes
   ;;
 esac
@@ -6424,7 +6424,8 @@ case "$target_name" in
     mttcg="yes"
     gdb_xml_files="arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml"
   ;;
-  aarch64)
+  aarch64|aarch64_be)
+    TARGET_ARCH=aarch64
     TARGET_BASE_ARCH=arm
     bflt="yes"
     mttcg="yes"
diff --git a/default-configs/aarch64_be-linux-user.mak b/default-configs/aarch64_be-linux-user.mak
new file mode 100644
index 0000000000..a69d9d2e41
--- /dev/null
+++ b/default-configs/aarch64_be-linux-user.mak
@@ -0,0 +1 @@
+# Default configuration for aarch64_be-linux-user
-- 
2.15.1
