Received: from eggs.gnu.org ([2001:4830:134:3::10]:59223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnovo-0001vH-T3
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnovk-00081q-CC
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:04:16 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 14 Mar 2017 17:03:57 +0100
Message-Id: <1489507437-32301-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH] file-posix: Remove unnecessary includes
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
index 2cb2f64..a03a3e1 100644
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
