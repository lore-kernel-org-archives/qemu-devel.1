Received: from eggs.gnu.org ([2001:4830:134:3::10]:54305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFiAp-0005QG-2i
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFiAm-0000Pi-7x
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:02 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:14177 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dFiAl-0000Nd-R1
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:00 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 30 May 2017 17:30:50 +0300
Message-Id: <20170530143052.165002-18-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-1-vsementsov@virtuozzo.com>
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 17/19] nbd/common: nbd_tls_handshake: use
 error_reportf_err instead of TRACE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Use error_reportf_err instead of TRACE in case of fail.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nbd/common.c b/nbd/common.c
index 88e0297fb2..574a551abe 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -102,7 +102,7 @@ void nbd_tls_handshake(QIOTask *task,
     struct NBDTLSHandshakeData *data = opaque;
 
     if (qio_task_propagate_error(task, &data->error)) {
-        TRACE("TLS failed %s", error_get_pretty(data->error));
+        error_reportf_err(data->error, "TLS failed");
     }
     data->complete = true;
     g_main_loop_quit(data->loop);
-- 
2.11.1
