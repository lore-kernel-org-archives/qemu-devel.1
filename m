Received: from eggs.gnu.org ([2001:4830:134:3::10]:48181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fnst5-0004Kz-24
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:54:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fnst0-0006Xw-QI
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:54:31 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Fri, 10 Aug 2018 00:53:01 +0300
Message-Id: <20180809215307.18241-3-lbloch@janustech.com>
In-Reply-To: <20180809215307.18241-1-lbloch@janustech.com>
References: <20180809215307.18241-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 2/8] qcow2: Cosmetic changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, Leonid Bloch <lbloch@janustech.com>

Some refactoring for better readability is done here.

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
---
 block/qcow2.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index ec9e6238a0..3f4abc394e 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -790,8 +790,9 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
     *refcount_cache_size = qemu_opt_get_size(opts,
                                              QCOW2_OPT_REFCOUNT_CACHE_SIZE, 0);
 
-    *l2_cache_entry_size = qemu_opt_get_size(
-        opts, QCOW2_OPT_L2_CACHE_ENTRY_SIZE, s->cluster_size);
+    *l2_cache_entry_size = qemu_opt_get_size(opts,
+                                             QCOW2_OPT_L2_CACHE_ENTRY_SIZE,
+                                             s->cluster_size);
 
     if (combined_cache_size_set) {
         if (l2_cache_size_set && refcount_cache_size_set) {
@@ -823,8 +824,8 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
                 *l2_cache_size = max_l2_cache;
                 *refcount_cache_size = combined_cache_size - *l2_cache_size;
             } else {
-                *refcount_cache_size =
-                    MIN(combined_cache_size, min_refcount_cache);
+                *refcount_cache_size = MIN(combined_cache_size,
+                                           min_refcount_cache);
                 *l2_cache_size = combined_cache_size - *refcount_cache_size;
             }
         }
-- 
2.17.1
