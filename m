Received: from eggs.gnu.org ([2001:4830:134:3::10]:41884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ds5Ov-00067n-Mk
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:00:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ds5Oq-0006Dy-5e
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:00:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ds5Oq-0006Bf-0o
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:00:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0629CC058EAF
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 11:00:07 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 13 Sep 2017 12:59:36 +0200
Message-Id: <20170913105953.13760-4-quintela@redhat.com>
In-Reply-To: <20170913105953.13760-1-quintela@redhat.com>
References: <20170913105953.13760-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v8 03/20] migration: Add comments to channel
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
---
 migration/channel.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/migration/channel.c b/migration/channel.c
index edceebdb7b..70ec7ea3b7 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -19,6 +19,14 @@
 #include "qapi/error.h"
 #include "io/channel-tls.h"
 
+/**
+ * @migration_channel_process_incoming - Create new incoming migration channel
+ *
+ * Notice that TLS is special.  For it we listen in a listener socket,
+ * and then create a new client socket from the TLS library.
+ *
+ * @ioc: Channel to which we are connecting
+ */
 void migration_channel_process_incoming(QIOChannel *ioc)
 {
     MigrationState *s = migrate_get_current();
@@ -41,6 +49,13 @@ void migration_channel_process_incoming(QIOChannel *ioc)
 }
 
 
+/**
+ * @migration_channel_connect - Create new outgoing migration channel
+ *
+ * @s: Current migration state
+ * @ioc: Channel to which we are connecting
+ * @hostname: Where we want to connect
+ */
 void migration_channel_connect(MigrationState *s,
                                QIOChannel *ioc,
                                const char *hostname)
-- 
2.13.5
