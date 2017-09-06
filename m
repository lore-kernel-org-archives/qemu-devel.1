Received: from eggs.gnu.org ([2001:4830:134:3::10]:60160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dpYsD-0007Gk-7H
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:52:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dpYsC-0007w0-Da
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:52:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dpYsC-0007vn-7V
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:52:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3FC4A356C9
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 11:51:59 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  6 Sep 2017 13:51:25 +0200
Message-Id: <20170906115143.27451-5-quintela@redhat.com>
In-Reply-To: <20170906115143.27451-1-quintela@redhat.com>
References: <20170906115143.27451-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v7 04/22] migration: Add comments to channel
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
