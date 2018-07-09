Received: from eggs.gnu.org ([2001:4830:134:3::10]:60139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fcbMy-0007Of-0e
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:58:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fcbMw-0002xl-Mx
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:58:44 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  9 Jul 2018 20:58:24 +0200
Message-Id: <20180709185828.4248-4-mreitz@redhat.com>
In-Reply-To: <20180709185828.4248-1-mreitz@redhat.com>
References: <20180709185828.4248-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 3/7] qcow2: Drop unreachable break
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Fam Zheng <famz@redhat.com>

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Message-id: 20180702025836.20957-4-famz@redhat.com
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index d4ba0f781a..f327116e52 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3299,7 +3299,6 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
         case QCOW2_CLUSTER_COMPRESSED:
             ret = -ENOTSUP;
             goto out;
-            break;
 
         case QCOW2_CLUSTER_NORMAL:
             child = bs->file;
-- 
2.17.1
