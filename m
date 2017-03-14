Received: from eggs.gnu.org ([2001:4830:134:3::10]:59270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnovs-0001yX-So
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnovp-00085L-Bg
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:04:20 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 14 Mar 2017 17:04:11 +0100
Message-Id: <1489507451-32356-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH] file-win32: Remove unnecessary include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-win32.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/file-win32.c b/block/file-win32.c
index 800fabd..e132ba1 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
-#include "qemu/timer.h"
 #include "block/block_int.h"
 #include "qemu/module.h"
 #include "block/raw-aio.h"
-- 
1.8.3.1
