Received: from eggs.gnu.org ([2001:4830:134:3::10]:47722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQh3R-0002xj-Ai
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 17:05:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQh3O-00066u-5Z
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 17:05:05 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:27:15 +0300
Message-Id: <2b5490ad0f8bbe152d2356ec322c93941a73b777.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 10/61] Document pretty parameter for mon option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vicente Jimenez Aguilar <googuy@gmail.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Vicente Jimenez Aguilar <googuy@gmail.com>

Documentation: document pretty parameter for mon option
that turns on JSON pretty printing

Signed-off-by: Vicente Jimenez Aguilar <googuy@gmail.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-options.hx | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index fe0c29271f..32d9378172 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3487,11 +3487,12 @@ Like -qmp but uses pretty JSON formatting.
 ETEXI
 
 DEF("mon", HAS_ARG, QEMU_OPTION_mon, \
-    "-mon [chardev=]name[,mode=readline|control]\n", QEMU_ARCH_ALL)
+    "-mon [chardev=]name[,mode=readline|control][,pretty[=on|off]]\n", QEMU_ARCH_ALL)
 STEXI
-@item -mon [chardev=]name[,mode=readline|control]
+@item -mon [chardev=]name[,mode=readline|control][,pretty[=on|off]]
 @findex -mon
-Setup monitor on chardev @var{name}.
+Setup monitor on chardev @var{name}. @code{pretty} turns on JSON pretty printing
+easing human reading and debugging.
 ETEXI
 
 DEF("debugcon", HAS_ARG, QEMU_OPTION_debugcon, \
-- 
2.11.0
