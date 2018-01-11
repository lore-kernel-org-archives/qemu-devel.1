Received: from eggs.gnu.org ([2001:4830:134:3::10]:52181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd41-0007S0-PV
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd40-00006d-ME
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:37 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eZd40-0008UD-DK
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:36 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd3q-0005cc-P9
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:38:26 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 13:38:00 +0000
Message-Id: <1515677902-23436-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
References: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 04/26] configure: Add aarch64_be-linux-user
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

From: Michael Weiser <michael.weiser@gmx.de>

Add target aarch64_be-linux-user. This allows a qemu-aarch64_be binary
to be built that will run big-endian aarch64 binaries.

Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-id: 20171220212308.12614-5-michael.weiser@gmx.de
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure                                 | 5 +++--
 default-configs/aarch64_be-linux-user.mak | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)
 create mode 100644 default-configs/aarch64_be-linux-user.mak

diff --git a/configure b/configure
index 6a04082..89bd662 100755
--- a/configure
+++ b/configure
@@ -6439,7 +6439,7 @@ target_name=$(echo $target | cut -d '-' -f 1)
 target_bigendian="no"
 
 case "$target_name" in
-  armeb|hppa|lm32|m68k|microblaze|mips|mipsn32|mips64|moxie|or1k|ppc|ppcemb|ppc64|ppc64abi32|s390x|sh4eb|sparc|sparc64|sparc32plus|xtensaeb)
+  armeb|aarch64_be|hppa|lm32|m68k|microblaze|mips|mipsn32|mips64|moxie|or1k|ppc|ppcemb|ppc64|ppc64abi32|s390x|sh4eb|sparc|sparc64|sparc32plus|xtensaeb)
   target_bigendian=yes
   ;;
 esac
@@ -6494,7 +6494,8 @@ case "$target_name" in
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
index 0000000..a69d9d2
--- /dev/null
+++ b/default-configs/aarch64_be-linux-user.mak
@@ -0,0 +1 @@
+# Default configuration for aarch64_be-linux-user
-- 
2.7.4
