Received: from eggs.gnu.org ([2001:4830:134:3::10]:59512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9v9k-0006Fr-HL
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9v9f-0004oi-TR
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:42:16 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed,  1 Nov 2017 18:42:03 +0300
Message-Id: <20171101154204.27146-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/2] nbd/server: fix nbd_negotiate_handle_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

namelen should be here, lenght is unrelated.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index 70b40ed27e..7fcec0af7e 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -433,7 +433,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
 
     /* Don't bother sending NBD_INFO_NAME unless client requested it */
     if (sendname) {
-        rc = nbd_negotiate_send_info(client, opt, NBD_INFO_NAME, length, name,
+        rc = nbd_negotiate_send_info(client, opt, NBD_INFO_NAME, namelen, name,
                                      errp);
         if (rc < 0) {
             return rc;
-- 
2.11.1
