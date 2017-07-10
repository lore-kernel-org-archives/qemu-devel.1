Received: from eggs.gnu.org ([2001:4830:134:3::10]:51617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1dUUAo-0004gp-5H
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 04:36:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1dUUAn-0005fI-Dw
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 04:36:06 -0400
From: "Denis V. Lunev" <den@openvz.org>
Date: Mon, 10 Jul 2017 11:35:53 +0300
Message-Id: <20170710083553.6167-1-den@openvz.org>
Subject: [Qemu-devel] [PATCH 1/1] block: fix possible return code clobbering
 in bdrv_co_pdiscard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Stefan Hajnoczi <stefanha@redhat.com> (supporter:Block I/O path)
CC: Fam Zheng <famz@redhat.com> (supporter:Block I/O path)
---
 block/io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index ed31810c0a..e5c6dc77d3 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2464,7 +2464,6 @@ int coroutine_fn bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
     assert(max_pdiscard >= bs->bl.request_alignment);
 
     while (count > 0) {
-        int ret;
         int num = count;
 
         if (head) {
-- 
2.11.0
