Received: from eggs.gnu.org ([2001:4830:134:3::10]:55187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4CaR-0001Mr-57
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4CaQ-00012e-IJ
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:33:55 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Apr 2017 22:33:10 +0200
Message-Id: <1493411622-5343-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 02/34] file-posix: Remove unnecessary includes
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
 block/file-posix.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 0c48968..ade71db 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -25,8 +25,6 @@
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
-#include "qemu/timer.h"
-#include "qemu/log.h"
 #include "block/block_int.h"
 #include "qemu/module.h"
 #include "trace.h"
-- 
1.8.3.1
