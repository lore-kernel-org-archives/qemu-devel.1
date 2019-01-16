Received: from eggs.gnu.org ([209.51.188.92]:40010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1gjdLQ-0006xJ-JB
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:02:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1gjdLM-0005CP-No
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:02:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:4442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1gjdLI-00056g-V7
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:02:21 -0500
From: Changpeng Liu <changpeng.liu@intel.com>
Date: Wed, 16 Jan 2019 13:19:28 +0800
Message-Id: <1547615970-23545-1-git-send-email-changpeng.liu@intel.com>
Subject: [Qemu-devel] [PATCH v2 1/3] contrib: compile vhost-user-blk tool by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, stefanha@redhat.com, sgazare@redhat.com, changpeng.liu@intel.com

Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
---
 configure | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure b/configure
index 3eee3fc..3d5af97 100755
--- a/configure
+++ b/configure
@@ -5763,6 +5763,9 @@ if test "$want_tools" = "yes" ; then
   if [ "$posix" = "yes" ] && [ "$curl" = "yes" ]; then
     tools="elf2dmp $tools"
   fi
+  if [ "$linux" = "yes" ]; then
+    tools="vhost-user-blk\$(EXESUF) $tools"
+  fi
 fi
 if test "$softmmu" = yes ; then
   if test "$linux" = yes; then
-- 
1.9.3
