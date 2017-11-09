Received: from eggs.gnu.org ([2001:4830:134:3::10]:36445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <googuy@gmail.com>) id 1eCkQt-0008HV-0b
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 05:51:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <googuy@gmail.com>) id 1eCkQs-0005bH-83
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 05:51:39 -0500
From: Vicente Jimenez Aguilar <googuy@gmail.com>
Date: Thu,  9 Nov 2017 11:50:24 +0100
Message-Id: <20171109105024.14991-2-googuy@gmail.com>
In-Reply-To: <20171109105024.14991-1-googuy@gmail.com>
References: <20171109105024.14991-1-googuy@gmail.com>
Subject: [Qemu-devel] [PATCH 2/2] Add mon default parameter to help
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

Spotted after reading mon_init_func from vl.c

Signed-off-by: Vicente Jimenez Aguilar <googuy@gmail.com>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 2692a48f63..12192a20e4 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3477,7 +3477,7 @@ Like -qmp but uses pretty JSON formatting.
 ETEXI
 
 DEF("mon", HAS_ARG, QEMU_OPTION_mon, \
-    "-mon [chardev=]name[,mode=readline|control][,pretty[=on|off]]\n", QEMU_ARCH_ALL)
+    "-mon [chardev=]name[,mode=readline|control][,pretty[=on|off]][,default[=on|off]]\n", QEMU_ARCH_ALL)
 STEXI
 @item -mon [chardev=]name[,mode=readline|control]
 @findex -mon
-- 
2.14.1
