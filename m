Received: from eggs.gnu.org ([2001:4830:134:3::10]:57810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edz9r-0003ZW-A4
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1edz9q-0005vw-4y
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:02:39 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 23 Jan 2018 15:01:43 +0100
Message-Id: <20180123140201.31163-12-kwolf@redhat.com>
In-Reply-To: <20180123140201.31163-1-kwolf@redhat.com>
References: <20180123140201.31163-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 11/29] block/vmdk: Fix , instead of ;
 at end of line
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

From: Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20171123020832.8165-2-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/vmdk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index c665bcc977..1ae47b1c2e 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1398,7 +1398,7 @@ static int vmdk_write_extent(VmdkExtent *extent, int64_t cluster_offset,
         qemu_iovec_concat(&local_qiov, qiov, qiov_offset, n_bytes);
     }
 
-    write_offset = cluster_offset + offset_in_cluster,
+    write_offset = cluster_offset + offset_in_cluster;
     ret = bdrv_co_pwritev(extent->file, write_offset, n_bytes,
                           &local_qiov, 0);
 
-- 
2.13.6
