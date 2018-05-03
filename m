Received: from eggs.gnu.org ([2001:4830:134:3::10]:56599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFo-0002UD-GO
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFn-0002Ry-Hw
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:00 -0400
Date: Thu, 3 May 2018 22:50:51 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-17-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 16/67] migration: use local path for local
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org

When pulling in headers that are in the same directory as C file (as
opposed to one in include/), we should use its relative path, without a
directory. Directory based path works more or less by accident.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 migration/block-dirty-bitmap.c | 2 +-
 migration/page_cache.c         | 2 +-
 migration/ram.c                | 4 ++--
 migration/vmstate.c            | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index dd04f10..09c086d 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -66,7 +66,7 @@
 #include "qemu/error-report.h"
 #include "migration/misc.h"
 #include "migration/migration.h"
-#include "migration/qemu-file.h"
+#include "qemu-file.h"
 #include "migration/vmstate.h"
 #include "migration/register.h"
 #include "qemu/hbitmap.h"
diff --git a/migration/page_cache.c b/migration/page_cache.c
index 96268c3..acc252b 100644
--- a/migration/page_cache.c
+++ b/migration/page_cache.c
@@ -18,7 +18,7 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/host-utils.h"
-#include "migration/page_cache.h"
+#include "page_cache.h"
 
 #ifdef DEBUG_CACHE
 #define DPRINTF(fmt, ...) \
diff --git a/migration/ram.c b/migration/ram.c
index 0e90efa..34a34d9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -40,7 +40,7 @@
 #include "migration/misc.h"
 #include "qemu-file.h"
 #include "postcopy-ram.h"
-#include "migration/page_cache.h"
+#include "page_cache.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-migration.h"
@@ -50,7 +50,7 @@
 #include "exec/target_page.h"
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
-#include "migration/block.h"
+#include "block.h"
 
 /***********************************************************/
 /* ram save/restore */
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 0b3282c..0a09636 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -14,7 +14,7 @@
 #include "qemu-common.h"
 #include "migration.h"
 #include "migration/vmstate.h"
-#include "migration/savevm.h"
+#include "savevm.h"
 #include "qemu-file.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
-- 
MST
