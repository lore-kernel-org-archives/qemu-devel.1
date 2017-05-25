Received: from eggs.gnu.org ([2001:4830:134:3::10]:33062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dDufA-0004qH-KA
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:26:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dDuf5-0002g6-M7
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:26:56 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:32655 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dDuf5-0002fB-BO
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:26:51 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 25 May 2017 18:26:22 +0300
Message-Id: <20170525152628.37628-2-vsementsov@virtuozzo.com>
In-Reply-To: <20170525152628.37628-1-vsementsov@virtuozzo.com>
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/7] block: fix comment for
 bdrv_get_allocated_file_size()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Current comment is not clear enough: which sparseness is meant, coming
from sparse image format or from sparse file system?

For example, if we have qcow2 above raw file on non-sparse file system,
this function will say nothing about unallocated (by qcow2 layer)
clusters.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 50ba264143..ba22fc0dfb 100644
--- a/block.c
+++ b/block.c
@@ -3388,8 +3388,8 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, Error **errp)
 }
 
 /**
- * Length of a allocated file in bytes. Sparse files are counted by actual
- * allocated space. Return < 0 if error or unknown.
+ * Size of allocated in underlying file system area. Sparseness is taken into
+ * account for sparse file systems. Return < 0 if error or unknown.
  */
 int64_t bdrv_get_allocated_file_size(BlockDriverState *bs)
 {
-- 
2.11.1
