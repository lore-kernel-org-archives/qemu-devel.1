Received: from eggs.gnu.org ([2001:4830:134:3::10]:54292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fMFfF-0000os-1f
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fMFfE-0002lx-Cs
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:34:01 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 25 May 2018 18:33:15 +0200
Message-Id: <20180525163327.23097-3-kwolf@redhat.com>
In-Reply-To: <20180525163327.23097-1-kwolf@redhat.com>
References: <20180525163327.23097-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 02/14] vhdx: Fix vhdx_co_create() return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

.bdrv_co_create() is supposed to return 0 on success, but vhdx could
return a positive value instead. Fix this.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vhdx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/vhdx.c b/block/vhdx.c
index 0b1e21c750..b1ba121bb6 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1951,7 +1951,7 @@ static int coroutine_fn vhdx_co_create(BlockdevCreateOptions *opts,
         goto delete_and_exit;
     }
 
-
+    ret = 0;
 delete_and_exit:
     blk_unref(blk);
     bdrv_unref(bs);
-- 
2.13.6
