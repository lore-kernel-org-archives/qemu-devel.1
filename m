Received: from eggs.gnu.org ([2001:4830:134:3::10]:55387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38aa-0007JV-Dd
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38aW-0005RU-BR
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d38aW-0005QH-4y
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31AD170AAD
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:05:35 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:04:30 +0200
Message-Id: <20170425220451.6028-21-quintela@redhat.com>
In-Reply-To: <20170425220451.6028-1-quintela@redhat.com>
References: <20170425220451.6028-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 20/41] migration: Export exec.c functions in
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
 migration/exec.c              |  1 +
 migration/exec.h              | 20 ++++++++++++++++++++
 migration/migration.c         |  1 +
 4 files changed, 22 insertions(+), 4 deletions(-)
 create mode 100644 migration/exec.h

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 22578db..3786f05 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -190,10 +190,6 @@ void migration_tls_channel_connect(MigrationState *s,
 
 uint64_t migrate_max_downtime(void);
 
-void exec_start_incoming_migration(const char *host_port, Error **errp);
-
-void exec_start_outgoing_migration(MigrationState *s, const char *host_port, Error **errp);
-
 void tcp_start_incoming_migration(const char *host_port, Error **errp);
 
 void tcp_start_outgoing_migration(MigrationState *s, const char *host_port, Error **errp);
diff --git a/migration/exec.c b/migration/exec.c
index 405d0ab..c532c56 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -21,6 +21,7 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "channel.h"
+#include "exec.h"
 #include "migration/migration.h"
 #include "io/channel-command.h"
 #include "trace.h"
diff --git a/migration/exec.h b/migration/exec.h
new file mode 100644
index 0000000..c97a7e9
--- /dev/null
+++ b/migration/exec.h
@@ -0,0 +1,20 @@
+/*
+ * QEMU live migration exec functions
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
+#ifndef QEMU_MIGRATION_EXEC_H
+#define QEMU_MIGRATION_EXEC_H
+void exec_start_incoming_migration(const char *host_port, Error **errp);
+
+void exec_start_outgoing_migration(MigrationState *s, const char *host_port,
+                                   Error **errp);
+#endif
diff --git a/migration/migration.c b/migration/migration.c
index f300b5e..994f25f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -18,6 +18,7 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "migration/blocker.h"
+#include "exec.h"
 #include "migration/migration.h"
 #include "savevm.h"
 #include "qemu-file-channel.h"
-- 
2.9.3
