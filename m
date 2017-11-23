Received: from eggs.gnu.org ([2001:4830:134:3::10]:33379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eHgwc-0004Xs-R4
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 21:08:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eHgwc-0001AU-0m
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 21:08:50 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 23 Nov 2017 03:08:16 +0100
Message-Id: <20171123020832.8165-2-mreitz@redhat.com>
In-Reply-To: <20171123020832.8165-1-mreitz@redhat.com>
References: <20171123020832.8165-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 01/17] block/vmdk: Fix , instead of ;
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>

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
