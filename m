Received: from eggs.gnu.org ([2001:4830:134:3::10]:60193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fntSp-0007tA-2q
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fntSo-0002XJ-7G
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:31:27 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 10 Aug 2018 00:31:07 +0200
Message-Id: <20180809223117.7846-2-mreitz@redhat.com>
In-Reply-To: <20180809223117.7846-1-mreitz@redhat.com>
References: <20180809223117.7846-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 01/11] block: Mark commit and mirror as
 filter drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

The commit and mirror block nodes are filters, so they should be marked
as such.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/commit.c | 2 ++
 block/mirror.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/block/commit.c b/block/commit.c
index 14788b0708..a95b87bb3a 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -261,6 +261,8 @@ static BlockDriver bdrv_commit_top = {
     .bdrv_refresh_filename      = bdrv_commit_top_refresh_filename,
     .bdrv_close                 = bdrv_commit_top_close,
     .bdrv_child_perm            = bdrv_commit_top_child_perm,
+
+    .is_filter                  = true,
 };
 
 void commit_start(const char *job_id, BlockDriverState *bs,
diff --git a/block/mirror.c b/block/mirror.c
index b4287a1e2b..5c561c6241 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1457,6 +1457,8 @@ static BlockDriver bdrv_mirror_top = {
     .bdrv_refresh_filename      = bdrv_mirror_top_refresh_filename,
     .bdrv_close                 = bdrv_mirror_top_close,
     .bdrv_child_perm            = bdrv_mirror_top_child_perm,
+
+    .is_filter                  = true,
 };
 
 static void mirror_start_job(const char *job_id, BlockDriverState *bs,
-- 
2.17.1
