Received: from eggs.gnu.org ([2001:4830:134:3::10]:49683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1dN3mU-0000S9-8u
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 17:00:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1dN3mP-00037A-ES
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 17:00:18 -0400
From: Bruce Rogers <brogers@suse.com>
Date: Mon, 19 Jun 2017 14:59:52 -0600
Message-Id: <20170619205952.8601-1-brogers@suse.com>
Subject: [Qemu-devel] [PATCH] 9pfs: local: remove: use correct path component
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: groug@kaod.org, qemu-stable@nongnu.org, Bruce Rogers <brogers@suse.com>

Commit a0e640a8 introduced a path processing error.
Pass fstatat the dirpath based path component instead
of the entire path.

Signed-off-by: Bruce Rogers <brogers@suse.com>
---
 hw/9pfs/9p-local.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 1e78b7c9e9..83952eff0a 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1100,7 +1100,7 @@ static int local_remove(FsContext *ctx, const char *path)
         goto out;
     }
 
-    if (fstatat(dirfd, path, &stbuf, AT_SYMLINK_NOFOLLOW) < 0) {
+    if (fstatat(dirfd, name, &stbuf, AT_SYMLINK_NOFOLLOW) < 0) {
         goto err_out;
     }
 
-- 
2.12.2
