Received: from eggs.gnu.org ([2001:4830:134:3::10]:51079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dX88e-0006zN-R5
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dX88b-0007r5-Ml
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:40:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dX88b-0007pm-Ee
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:40:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 17 Jul 2017 16:40:26 +0100
Message-Id: <20170717154026.32697-3-stefanha@redhat.com>
In-Reply-To: <20170717154026.32697-1-stefanha@redhat.com>
References: <20170717154026.32697-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] block: fix shadowed variable in
 bdrv_co_pdiscard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Denis V. Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

From: "Denis V. Lunev" <den@openvz.org>

We've had a shadowed 'ret' variable, which risks returning the wrong
value, introduced in commit b9c64947.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20170710150559.30163-1-den@openvz.org
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Eric Blake <eblake@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index b413727..a73153d 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2335,7 +2335,6 @@ int coroutine_fn bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
     assert(max_pdiscard >= bs->bl.request_alignment);
 
     while (bytes > 0) {
-        int ret;
         int num = bytes;
 
         if (head) {
-- 
2.9.4
