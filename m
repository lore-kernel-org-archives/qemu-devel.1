Received: from eggs.gnu.org ([2001:4830:134:3::10]:38383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRfqq-0002oI-Tx
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 11:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRfqn-0002XX-Ss
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 11:32:24 -0400
Received: from relay.sw.ru ([195.214.232.25]:52410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1fRfqn-0002WD-Go
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 11:32:21 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Sat,  9 Jun 2018 18:32:10 +0300
Message-Id: <20180609153217.19683-5-vsementsov@virtuozzo.com>
In-Reply-To: <20180609153217.19683-1-vsementsov@virtuozzo.com>
References: <20180609153217.19683-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 04/11] block/nbd-client: fix
 nbd_reply_chunk_iter_receive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Use exported report, not the variable to be reused (should not really
matter).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 14b42f31df..dd712c59b3 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -599,7 +599,7 @@ static bool nbd_reply_chunk_iter_receive(NBDClientSession *s,
     }
 
     /* Do not execute the body of NBD_FOREACH_REPLY_CHUNK for simple reply. */
-    if (nbd_reply_is_simple(&s->reply) || s->quit) {
+    if (nbd_reply_is_simple(reply) || s->quit) {
         goto break_loop;
     }
 
-- 
2.11.1
