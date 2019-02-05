Received: from eggs.gnu.org ([209.51.188.92]:51100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqrrL-0000gS-AP
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 22:57:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqrrK-0002pa-2k
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 22:57:18 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon,  4 Feb 2019 21:57:02 -0600
Message-Id: <20190205035704.26014-7-eblake@redhat.com>
In-Reply-To: <20190205035704.26014-1-eblake@redhat.com>
References: <20190205035704.26014-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/8] block/nbd-client: fix
 nbd_reply_chunk_iter_receive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Use exported report, not the variable to be reused (should not really
matter).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190201130138.94525-5-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index d7d88297698..65e56000681 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -602,7 +602,7 @@ static bool nbd_reply_chunk_iter_receive(NBDClientSes=
sion *s,
     }

     /* Do not execute the body of NBD_FOREACH_REPLY_CHUNK for simple rep=
ly. */
-    if (nbd_reply_is_simple(&s->reply) || s->quit) {
+    if (nbd_reply_is_simple(reply) || s->quit) {
         goto break_loop;
     }

--=20
2.20.1
