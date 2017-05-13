Received: from eggs.gnu.org ([2001:4830:134:3::10]:47697)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1d9Mol-0002by-Os
	for qemu-devel@nongnu.org; Fri, 12 May 2017 22:30:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1d9Moi-000150-Mb
	for qemu-devel@nongnu.org; Fri, 12 May 2017 22:30:03 -0400
Received: from mout.gmx.net ([212.227.15.15]:58381)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1d9Moi-00014P-CN
	for qemu-devel@nongnu.org; Fri, 12 May 2017 22:30:00 -0400
From: Kamil Rytarowski <n54@gmx.com>
Date: Sat, 13 May 2017 04:21:43 +0200
Message-Id: <20170513022143.2838-1-n54@gmx.com>
Subject: [Qemu-devel] [PATCH] maintainers: Add myself as a NetBSD reviewer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Kamil Rytarowski <n54@gmx.com>

I volunteer to review NetBSD patches.
Adding myself will help to not miss some of them.

Restore NetBSD as a maintained host.

All patches to make qemu/pkgsrc building have been emitted to review.

Signed-off-by: Kamil Rytarowski <n54@gmx.com>
---
 MAINTAINERS | 6 ++++++
 configure   | 1 +
 2 files changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e8d731ebf..c4eff13ce2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -354,6 +354,12 @@ L: qemu-devel@nongnu.org
 S: Maintained
 F: *posix*
 
+NETBSD
+L: qemu-devel@nongnu.org
+M: Kamil Rytarowski <kamil@netbsd.org>
+S: Maintained
+K: (?i)NetBSD
+
 W32, W64
 L: qemu-devel@nongnu.org
 M: Stefan Weil <sw@weilnetz.de>
diff --git a/configure b/configure
index 7c020c076b..0b3e014c93 100755
--- a/configure
+++ b/configure
@@ -611,6 +611,7 @@ NetBSD)
   audio_possible_drivers="oss sdl"
   oss_lib="-lossaudio"
   HOST_VARIANT_DIR="netbsd"
+  supported_os="yes"
 ;;
 OpenBSD)
   bsd="yes"
-- 
2.12.2
