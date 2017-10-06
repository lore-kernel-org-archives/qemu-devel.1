Received: from eggs.gnu.org ([2001:4830:134:3::10]:55262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0UxQ-0008Tp-9V
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:54:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0UxP-0002NK-HU
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:54:36 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  6 Oct 2017 17:53:29 +0200
Message-Id: <20171006155422.10135-2-kwolf@redhat.com>
In-Reply-To: <20171006155422.10135-1-kwolf@redhat.com>
References: <20171006155422.10135-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 01/54] block: Typo fix in copy_on_readv()
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

From: Eric Blake <eblake@redhat.com>

Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index 4378ae4c7d..d633b0f851 100644
--- a/block/io.c
+++ b/block/io.c
@@ -954,7 +954,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
     /* FIXME We cannot require callers to have write permissions when all they
      * are doing is a read request. If we did things right, write permissions
      * would be obtained anyway, but internally by the copy-on-read code. As
-     * long as it is implemented here rather than in a separat filter driver,
+     * long as it is implemented here rather than in a separate filter driver,
      * the copy-on-read code doesn't have its own BdrvChild, however, for which
      * it could request permissions. Therefore we have to bypass the permission
      * system for the moment. */
-- 
2.13.6
