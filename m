Received: from eggs.gnu.org ([2001:4830:134:3::10]:55471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38aj-0007SG-CC
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38af-0005b4-FK
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d38af-0005Zn-3R
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 16FF561BB8
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:05:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:04:35 +0200
Message-Id: <20170425220451.6028-26-quintela@redhat.com>
In-Reply-To: <20170425220451.6028-1-quintela@redhat.com>
References: <20170425220451.6028-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 25/41] migration: Export rdma.c functions in
 its own file
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
---
 include/migration/migration.h |  4 ----
 migration/migration.c         |  1 +
 migration/rdma.c              |  1 +
 migration/rdma.h              | 22 ++++++++++++++++++++++
 4 files changed, 24 insertions(+), 4 deletions(-)
 create mode 100644 migration/rdma.h

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 38ba508..9063c32 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -180,10 +180,6 @@ void qemu_start_incoming_migration(const char *uri, Error **errp);
 
 uint64_t migrate_max_downtime(void);
 
-void rdma_start_outgoing_migration(void *opaque, const char *host_port, Error **errp);
-
-void rdma_start_incoming_migration(const char *host_port, Error **errp);
-
 void migrate_fd_error(MigrationState *s, const Error *error);
 
 void migrate_fd_connect(MigrationState *s);
diff --git a/migration/migration.c b/migration/migration.c
index ef966ca..394930d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -22,6 +22,7 @@
 #include "fd.h"
 #include "socket.h"
 #include "ram.h"
+#include "rdma.h"
 #include "migration/migration.h"
 #include "savevm.h"
 #include "qemu-file-channel.h"
diff --git a/migration/rdma.c b/migration/rdma.c
index 96a90dd..f8fea9b 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -17,6 +17,7 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/cutils.h"
+#include "rdma.h"
 #include "migration/migration.h"
 #include "qemu-file.h"
 #include "ram.h"
diff --git a/migration/rdma.h b/migration/rdma.h
new file mode 100644
index 0000000..d2cf481
--- /dev/null
+++ b/migration/rdma.h
@@ -0,0 +1,22 @@
+/*
+ * QEMU migration rdma functions
+ *
+ * Copyright IBM, Corp. 2008
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef QEMU_MIGRATION_RDMA_H
+#define QEMU_MIGRATION_RDMA_H
+
+void rdma_start_outgoing_migration(void *opaque, const char *host_port,
+                                   Error **errp);
+
+void rdma_start_incoming_migration(const char *host_port, Error **errp);
+
+#endif
-- 
2.9.3
