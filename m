Received: from eggs.gnu.org ([2001:4830:134:3::10]:42307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fZp3P-0001Jj-GZ
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 22:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fZp3M-0001iF-Pu
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 22:59:03 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon,  2 Jul 2018 10:58:35 +0800
Message-Id: <20180702025836.20957-4-famz@redhat.com>
In-Reply-To: <20180702025836.20957-1-famz@redhat.com>
References: <20180702025836.20957-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] qcow2: Drop unreachable break
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/qcow2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 3177c72de0..1a2e498a3c 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3292,7 +3292,6 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
         case QCOW2_CLUSTER_COMPRESSED:
             ret = -ENOTSUP;
             goto out;
-            break;
 
         case QCOW2_CLUSTER_NORMAL:
             child = bs->file;
-- 
2.17.1
