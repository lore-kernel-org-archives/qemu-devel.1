Received: from eggs.gnu.org ([2001:4830:134:3::10]:52505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dN0oh-0000Yt-Ln
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 13:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dN0of-0001l7-7E
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 13:50:23 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 19 Jun 2017 19:50:17 +0200
Message-Id: <1497894617-12143-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] ui: Remove inclusion of "hw/qdev.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-trivial@nongnu.org

Looks like #include "hw/qdev.h" is not needed here, so remove it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 ui/input.c | 1 -
 ui/vnc.c   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/ui/input.c b/ui/input.c
index 290ca9f..2abd46d 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "hw/qdev.h"
 #include "sysemu/sysemu.h"
 #include "qapi-types.h"
 #include "qemu/error-report.h"
diff --git a/ui/vnc.c b/ui/vnc.c
index 47b49c7..26136f5 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -28,7 +28,6 @@
 #include "vnc.h"
 #include "vnc-jobs.h"
 #include "trace.h"
-#include "hw/qdev.h"
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
-- 
1.8.3.1
