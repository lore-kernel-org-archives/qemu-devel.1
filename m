Received: from eggs.gnu.org ([2001:4830:134:3::10]:38620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZdvw-0003fc-HO
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:02:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZdvu-0006lN-0m
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:02:04 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 24 Jul 2017 09:01:49 -0500
Message-Id: <20170724140149.1933-3-eblake@redhat.com>
In-Reply-To: <20170724140149.1933-1-eblake@redhat.com>
References: <20170724140149.1933-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] maint: Reorder include directives for
 qemu-{nbd, io}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

HACKING recommends listing system includes right after osdep.h,
and before any other in-project headers.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170721135047.25005-3-eblake@redhat.com>
---
 qemu-img.c | 3 ++-
 qemu-nbd.c | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index eb32b93e90..f4d5f0d77d 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include <getopt.h>
+
 #include "qemu-version.h"
 #include "qapi/error.h"
 #include "qapi/util.h"
@@ -43,7 +45,6 @@
 #include "block/qapi.h"
 #include "crypto/init.h"
 #include "trace/control.h"
-#include <getopt.h>

 #define QEMU_IMG_VERSION "qemu-img version " QEMU_VERSION QEMU_PKGVERSION \
                           "\n" QEMU_COPYRIGHT "\n"
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 1086934a95..b8666bb575 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -17,6 +17,10 @@
  */

 #include "qemu/osdep.h"
+#include <getopt.h>
+#include <libgen.h>
+#include <pthread.h>
+
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/cutils.h"
@@ -38,10 +42,6 @@
 #include "trace/control.h"
 #include "qemu-version.h"

-#include <getopt.h>
-#include <libgen.h>
-#include <pthread.h>
-
 #define SOCKET_PATH                "/var/lock/qemu-nbd-%s"
 #define QEMU_NBD_OPT_CACHE         256
 #define QEMU_NBD_OPT_AIO           257
-- 
2.13.3
