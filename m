Received: from eggs.gnu.org ([2001:4830:134:3::10]:58606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMFt0-00043n-Ep
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMFsz-0002uh-Kd
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:48:14 -0400
Date: Fri, 25 May 2018 19:48:04 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527266793-301361-16-git-send-email-mst@redhat.com>
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527266793-301361-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH v2 15/20] migration: use local path for local
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
Cc: eblake@redhat.com, peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org

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
index 8819aab..eeccaff 100644
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
index 5bcbf7a..e7d6cf6 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -41,7 +41,7 @@
 #include "migration/misc.h"
 #include "qemu-file.h"
 #include "postcopy-ram.h"
-#include "migration/page_cache.h"
+#include "page_cache.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-migration.h"
@@ -51,7 +51,7 @@
 #include "exec/target_page.h"
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
-#include "migration/block.h"
+#include "block.h"
 #include "sysemu/sysemu.h"
 #include "qemu/uuid.h"
 #include "savevm.h"
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
