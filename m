Received: from eggs.gnu.org ([2001:4830:134:3::10]:51649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNlOt-0003DG-GY
	for qemu-devel@nongnu.org; Tue, 29 May 2018 16:39:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNlOs-0007q7-P7
	for qemu-devel@nongnu.org; Tue, 29 May 2018 16:39:23 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 29 May 2018 22:38:55 +0200
Message-Id: <20180529203910.7615-2-kwolf@redhat.com>
In-Reply-To: <20180529203910.7615-1-kwolf@redhat.com>
References: <20180529203910.7615-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 01/16] vdi: Fix vdi_co_do_create() return
 value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

.bdrv_co_create() is supposed to return 0 on success, but vdi could
return a positive value instead. Fix this.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
---
 block/vdi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/vdi.c b/block/vdi.c
index 96a22b8e83..668af0a828 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -865,6 +865,7 @@ static int coroutine_fn vdi_co_do_create(BlockdevCreateOptions *create_options,
         }
     }
 
+    ret = 0;
 exit:
     blk_unref(blk);
     bdrv_unref(bs_file);
-- 
2.13.6
