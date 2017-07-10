Received: from eggs.gnu.org ([2001:4830:134:3::10]:54732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUXaa-0001gp-43
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUXaZ-0002e1-AF
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:14:56 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 10 Jul 2017 07:14:29 -0500
Message-Id: <20170710121434.5047-7-eblake@redhat.com>
In-Reply-To: <20170710121434.5047-1-eblake@redhat.com>
References: <20170710121434.5047-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 06/11] nbd/common: nbd_tls_handshake: remove
 extra TRACE
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

Error is propagated to the caller, TRACE is not needed.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170707152918.23086-6-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/nbd/common.c b/nbd/common.c
index 6b5c1b7..4dab41e 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -97,9 +97,7 @@ void nbd_tls_handshake(QIOTask *task,
 {
     struct NBDTLSHandshakeData *data = opaque;

-    if (qio_task_propagate_error(task, &data->error)) {
-        TRACE("TLS failed %s", error_get_pretty(data->error));
-    }
+    qio_task_propagate_error(task, &data->error);
     data->complete = true;
     g_main_loop_quit(data->loop);
 }
-- 
2.9.4
