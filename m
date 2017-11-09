Received: from eggs.gnu.org ([2001:4830:134:3::10]:53820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <googuy@gmail.com>) id 1eClo2-00010m-8d
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 07:19:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <googuy@gmail.com>) id 1eClny-0005rv-AT
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 07:19:38 -0500
From: Vicente Jimenez Aguilar <googuy@gmail.com>
Date: Thu,  9 Nov 2017 13:19:03 +0100
Message-Id: <20171109121903.24510-1-googuy@gmail.com>
Subject: [Qemu-devel] [PATCH] Add missing parameters to mon option
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Vicente Jimenez Aguilar <googuy@gmail.com>

Documentation missed 'mon' option's 'pretty' and 'default' parameters

Signed-off-by: Vicente Jimenez Aguilar <googuy@gmail.com>
---
 qemu-options.hx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 3728e9b4dd..72cf48a8e5 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3477,9 +3477,9 @@ Like -qmp but uses pretty JSON formatting.
 ETEXI
 
 DEF("mon", HAS_ARG, QEMU_OPTION_mon, \
-    "-mon [chardev=]name[,mode=readline|control]\n", QEMU_ARCH_ALL)
+    "-mon [chardev=]name[,mode=readline|control][,pretty[=on|off]][,default[=on|off]]\n", QEMU_ARCH_ALL)
 STEXI
-@item -mon [chardev=]name[,mode=readline|control]
+@item -mon [chardev=]name[,mode=readline|control][,pretty[=on|off]][,default[=on|off]]
 @findex -mon
 Setup monitor on chardev @var{name}.
 ETEXI
-- 
2.14.1
