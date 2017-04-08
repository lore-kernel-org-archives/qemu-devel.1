Received: from eggs.gnu.org ([2001:4830:134:3::10]:51423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.guang55@zte.com.cn>) id 1cwPik-0005QK-Io
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 04:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.guang55@zte.com.cn>) id 1cwPij-0006CU-GU
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 04:58:18 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:41225)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.guang55@zte.com.cn>) id 1cwPij-00063v-2J
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 04:58:17 -0400
From: Wang guang <wang.guang55@zte.com.cn>
Date: Sat, 8 Apr 2017 09:16:22 +0800
Message-Id: <1491614183-4580-1-git-send-email-wang.guang55@zte.com.cn>
Subject: [Qemu-devel] [PATCH] Set QIO_CHANNEL_FEATURE_SHUTDOWN in
 colo_process_incoming_thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, Guang Wang <wang.guang55@zte.com.cn>

From: Guang Wang <wang.guang55@zte.com.cn>

Due to

Signed-off-by: Wang guang <wang.guang55@zte.com.cn>
---
 migration/socket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/socket.c b/migration/socket.c
index 13966f1..193ed22 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -149,6 +149,7 @@ static gboolean socket_accept_incoming_migration(QIOChannel *ioc,
     trace_migration_socket_incoming_accepted();
 
     qio_channel_set_name(QIO_CHANNEL(sioc), "migration-socket-incoming");
+    qio_channel_set_feature(QIO_CHANNEL(sioc), QIO_CHANNEL_FEATURE_SHUTDOWN);
     migration_channel_process_incoming(migrate_get_current(),
                                        QIO_CHANNEL(sioc));
     object_unref(OBJECT(sioc));
-- 
1.8.3.1
