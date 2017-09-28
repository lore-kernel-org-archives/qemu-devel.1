Received: from eggs.gnu.org ([2001:4830:134:3::10]:33960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxeFq-0006Qt-RK
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 15:13:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxeFn-0002SG-La
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 15:13:50 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 28 Sep 2017 14:13:25 -0500
Message-Id: <20170928191325.30253-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] block: Typo fix in copy_on_readv()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block I/O path" <qemu-block@nongnu.org>
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index c02c4c9c20..38c55d1c8a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -953,7 +953,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
     /* FIXME We cannot require callers to have write permissions when all they
      * are doing is a read request. If we did things right, write permissions
      * would be obtained anyway, but internally by the copy-on-read code. As
-     * long as it is implemented here rather than in a separat filter driver,
+     * long as it is implemented here rather than in a separate filter driver,
      * the copy-on-read code doesn't have its own BdrvChild, however, for which
      * it could request permissions. Therefore we have to bypass the permission
      * system for the moment. */
-- 
2.13.5
