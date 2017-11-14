Received: from eggs.gnu.org ([2001:4830:134:3::10]:60203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <googuy@gmail.com>) id 1eEW6m-00007r-1X
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:58:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <googuy@gmail.com>) id 1eEW6h-0000c5-6Y
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:58:12 -0500
From: Vicente Jimenez Aguilar <googuy@gmail.com>
Date: Tue, 14 Nov 2017 08:57:41 +0100
Message-Id: <20171114075741.12372-1-googuy@gmail.com>
Subject: [Qemu-devel] [PATCH] Document pretty parameter for mon option
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

Documentation: document pretty parameter for mon option

Signed-off-by: Vicente Jimenez Aguilar <googuy@gmail.com>
---
 qemu-options.hx | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 3728e9b4dd..f06002689d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3477,11 +3477,12 @@ Like -qmp but uses pretty JSON formatting.
 ETEXI
 
 DEF("mon", HAS_ARG, QEMU_OPTION_mon, \
-    "-mon [chardev=]name[,mode=readline|control]\n", QEMU_ARCH_ALL)
+    "-mon [chardev=]name[,mode=readline|control][,pretty[=on|off]]\n", QEMU_ARCH_ALL)
 STEXI
-@item -mon [chardev=]name[,mode=readline|control]
+@item -mon [chardev=]name[,mode=readline|control][,pretty[=on|off]]
 @findex -mon
-Setup monitor on chardev @var{name}.
+Setup monitor on chardev @var{name}. @code{pretty} turn on JSON pretty printing
+easing human reading and debugging.
 ETEXI
 
 DEF("debugcon", HAS_ARG, QEMU_OPTION_debugcon, \
-- 
2.14.1
