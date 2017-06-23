Received: from eggs.gnu.org ([2001:4830:134:3::10]:59254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLg-0000Zr-4j
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLf-0007VZ-7q
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:20 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:08 +0200
Message-Id: <1498234919-27316-11-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 10/61] throttle: Update throttle-groups.c
 documentation
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

From: Alberto Garcia <berto@igalia.com>

There used to be throttle_timers_{detach,attach}_aio_context() calls
in bdrv_set_aio_context(), but since 7ca7f0f6db1fedd28d490795d778cf239
they are now in blk_set_aio_context().

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/throttle-groups.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index a181cb1..da2b490 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -49,7 +49,7 @@
  * Again, all this is handled internally and is mostly transparent to
  * the outside. The 'throttle_timers' field however has an additional
  * constraint because it may be temporarily invalid (see for example
- * bdrv_set_aio_context()). Therefore in this file a thread will
+ * blk_set_aio_context()). Therefore in this file a thread will
  * access some other BlockBackend's timers only after verifying that
  * that BlockBackend has throttled requests in the queue.
  */
-- 
1.8.3.1
