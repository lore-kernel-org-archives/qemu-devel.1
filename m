Received: from eggs.gnu.org ([2001:4830:134:3::10]:40075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ePHsp-0001Vv-MA
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 20:00:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ePHsm-00030x-Ke
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 20:00:19 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 13 Dec 2017 19:59:48 -0500
Message-Id: <20171214005953.8898-3-jsnow@redhat.com>
In-Reply-To: <20171214005953.8898-1-jsnow@redhat.com>
References: <20171214005953.8898-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 2/7] blockjob: consolidate SLICE_TIME definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com, John Snow <jsnow@redhat.com>

They're all the same. If it actually becomes important to configure it,
it can become a job or driver property.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/backup.c               | 1 -
 block/commit.c               | 2 --
 block/mirror.c               | 1 -
 block/stream.c               | 2 --
 include/block/blockjob_int.h | 2 ++
 5 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 99e6bcc748..d71b25c017 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -27,7 +27,6 @@
 #include "qemu/error-report.h"
 
 #define BACKUP_CLUSTER_SIZE_DEFAULT (1 << 16)
-#define SLICE_TIME 100000000ULL /* ns */
 
 typedef struct BackupBlockJob {
     BlockJob common;
diff --git a/block/commit.c b/block/commit.c
index c5327551ce..873e749d50 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -31,8 +31,6 @@ enum {
     COMMIT_BUFFER_SIZE = 512 * 1024, /* in bytes */
 };
 
-#define SLICE_TIME 100000000ULL /* ns */
-
 typedef struct CommitBlockJob {
     BlockJob common;
     RateLimit limit;
diff --git a/block/mirror.c b/block/mirror.c
index d35c688faa..eef5b598f5 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -22,7 +22,6 @@
 #include "qemu/ratelimit.h"
 #include "qemu/bitmap.h"
 
-#define SLICE_TIME    100000000ULL /* ns */
 #define MAX_IN_FLIGHT 16
 #define MAX_IO_BYTES (1 << 20) /* 1 Mb */
 #define DEFAULT_MIRROR_BUF_SIZE (MAX_IN_FLIGHT * MAX_IO_BYTES)
diff --git a/block/stream.c b/block/stream.c
index 499cdacdb0..e85af18c54 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -29,8 +29,6 @@ enum {
     STREAM_BUFFER_SIZE = 512 * 1024, /* in bytes */
 };
 
-#define SLICE_TIME 100000000ULL /* ns */
-
 typedef struct StreamBlockJob {
     BlockJob common;
     RateLimit limit;
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index c9b23b0cc9..209fa1bb3e 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -29,6 +29,8 @@
 #include "block/blockjob.h"
 #include "block/block.h"
 
+#define SLICE_TIME 100000000ULL /* ns */
+
 /**
  * BlockJobDriver:
  *
-- 
2.14.3
