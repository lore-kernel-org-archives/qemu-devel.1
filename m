Received: from eggs.gnu.org ([2001:4830:134:3::10]:54574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fxZaf-00085D-In
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 11:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fxZac-00078L-EY
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 11:19:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fxZac-00076M-7h
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 11:19:30 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed,  5 Sep 2018 12:19:27 -0300
Message-Id: <20180905151927.8884-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] configure: Support --enable-capstone=internal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Danilo C. L. de Paula" <ddepaula@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

Currently there's no way to make configure not try to use the
system-provided capstone library using pkgconfig.

Add support to --enable-capstone=internal option to make QEMU not
use the system-provided library automatically.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 configure | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configure b/configure
index 58862d2ae8..34ed00f6d9 100755
--- a/configure
+++ b/configure
@@ -1431,6 +1431,8 @@ for opt do
   ;;
   --enable-capstone=system) capstone="system"
   ;;
+  --enable-capstone=internal) capstone="internal"
+  ;;
   --with-git=*) git="$optarg"
   ;;
   --enable-git-update) git_update=yes
@@ -1635,6 +1637,9 @@ Advanced options (experts only):
                            xen pv domain builder
   --enable-debug-stack-usage
                            track the maximum stack usage of stacks created by qemu_alloc_stack
+  --enable-capstone[=LOCATION]
+                           Where to look for capstone library.
+                           Supported options: internal, git, system
 
 Optional features, enabled with --enable-FEATURE and
 disabled with --disable-FEATURE, default is enabled if available:
-- 
2.18.0.rc1.1.g3f1ff2140
