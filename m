Received: from eggs.gnu.org ([2001:4830:134:3::10]:60784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csXJj-0006lv-M4
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csXJi-0000we-NI
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:16:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1csXJi-0000vI-Hs
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:16:26 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A4F3461B8F
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 16:16:25 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 Mar 2017 18:16:13 +0200
Message-Id: <20170327161615.19637-8-pbonzini@redhat.com>
In-Reply-To: <20170327161615.19637-1-pbonzini@redhat.com>
References: <20170327161615.19637-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 7/9] nbd: drop unused NBDClientSession.is_unix
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>

From: Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20170327123223.1199-1-stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
