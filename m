Received: from eggs.gnu.org ([2001:4830:134:3::10]:52599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dKtB0-0003OI-OX
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 17:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dKtAx-00034r-HB
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 17:16:38 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed, 14 Jun 2017 00:16:12 +0300
Message-Id: <20170613211612.9368-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] throttle: Update throttle-groups.c
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>, Alberto Garcia <berto@igalia.com>

There used to be throttle_timers_{detach,attach}_aio_context() calls
in bdrv_set_aio_context(), but since 7ca7f0f6db1fedd28d490795d778cf239
they are now in blk_set_aio_context().

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/throttle-groups.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index b73e7a800b..b28ffaccb5 100644
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
2.11.0
