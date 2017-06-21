Received: from eggs.gnu.org ([2001:4830:134:3::10]:50423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dNheN-0007vk-HH
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:34:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dNheI-0008QO-GB
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:34:35 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:16055 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dNheI-0008Ov-49
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:34:30 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 21 Jun 2017 18:34:22 +0300
Message-Id: <20170621153424.16690-5-vsementsov@virtuozzo.com>
In-Reply-To: <20170621153424.16690-1-vsementsov@virtuozzo.com>
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 4/6] nbd/common: nbd_tls_handshake: remove
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
Cc: stefanha@redhat.com, eblake@redhat.com, pbonzini@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Error is propagated to the caller, TRACE is not needed.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/nbd/common.c b/nbd/common.c
index 6b5c1b7b02..4dab41e2c0 100644
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
2.11.1
