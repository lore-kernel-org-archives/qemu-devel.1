Received: from eggs.gnu.org ([2001:4830:134:3::10]:46609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1csTp4-0004ii-4T
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 08:32:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1csTp3-0003He-F0
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 08:32:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 27 Mar 2017 13:32:23 +0100
Message-Id: <20170327123223.1199-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] nbd: drop unused NBDClientSession.is_unix field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/nbd-client.h | 2 --
 block/nbd.c        | 2 --
 2 files changed, 4 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index 8cdfc92..891ba44 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -30,8 +30,6 @@ typedef struct NBDClientSession {
 
     Coroutine *recv_coroutine[MAX_NBD_REQUESTS];
     NBDReply reply;
-
-    bool is_unix;
 } NBDClientSession;
 
 NBDClientSession *nbd_get_client_session(BlockDriverState *bs);
diff --git a/block/nbd.c b/block/nbd.c
index f478f80..1b832c2 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -285,8 +285,6 @@ static SocketAddress *nbd_config(BDRVNBDState *s, QDict *options, Error **errp)
         goto done;
     }
 
-    s->client.is_unix = saddr->type == SOCKET_ADDRESS_KIND_UNIX;
-
 done:
     QDECREF(addr);
     qobject_decref(crumpled_addr);
-- 
2.9.3
