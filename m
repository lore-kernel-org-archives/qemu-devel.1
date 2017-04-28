Received: from eggs.gnu.org ([2001:4830:134:3::10]:55236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4CaT-0001PI-C6
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4CaS-00014f-Kx
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:33:57 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Apr 2017 22:33:11 +0200
Message-Id: <1493411622-5343-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 03/34] file-win32: Remove unnecessary include
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
