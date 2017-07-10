Received: from eggs.gnu.org ([2001:4830:134:3::10]:54758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUXab-0001hm-4J
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:14:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUXaa-0002fj-AJ
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:14:57 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 10 Jul 2017 07:14:31 -0500
Message-Id: <20170710121434.5047-9-eblake@redhat.com>
In-Reply-To: <20170710121434.5047-1-eblake@redhat.com>
References: <20170710121434.5047-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 08/11] nbd/server: fix TRACE in
 nbd_negotiate_send_rep_len
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Fix wrong order of TRACE arguments.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20170707152918.23086-8-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index e3fd0ca..1eeafcc 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -139,7 +139,7 @@ static int nbd_negotiate_send_rep_len(QIOChannel *ioc, uint32_t type,
     uint64_t magic;

     TRACE("Reply opt=%" PRIx32 " type=%" PRIx32 " len=%" PRIu32,
-          type, opt, len);
+          opt, type, len);

     magic = cpu_to_be64(NBD_REP_MAGIC);
     if (nbd_write(ioc, &magic, sizeof(magic), errp) < 0) {
-- 
2.9.4
