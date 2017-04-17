Received: from eggs.gnu.org ([2001:4830:134:3::10]:52118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0CpQ-0005zG-NH
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0CpP-0004NR-TC
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:00:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0CpP-0004Mx-O2
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 16:00:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 94FB0C05005F
	for <qemu-devel@nongnu.org>; Mon, 17 Apr 2017 20:00:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 17 Apr 2017 22:00:27 +0200
Message-Id: <20170417200041.2451-6-quintela@redhat.com>
In-Reply-To: <20170417200041.2451-1-quintela@redhat.com>
References: <20170417200041.2451-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 05/19] migration: Export exec.c functions in
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
Cc: dgilbert@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/exec.h      | 20 ++++++++++++++++++++
 include/migration/migration.h |  4 ----
 migration/exec.c              |  2 +-
 migration/migration.c         |  1 +
 4 files changed, 22 insertions(+), 5 deletions(-)
 create mode 100644 include/migration/exec.h

diff --git a/include/migration/exec.h b/include/migration/exec.h
new file mode 100644
index 0000000..c97a7e9
--- /dev/null
+++ b/include/migration/exec.h
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
diff --git a/include/migration/migration.h b/include/migration/migration.h
index 3f54a7c..eb0150b 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -194,10 +194,6 @@ void migration_tls_channel_connect(MigrationState *s,
 
 uint64_t migrate_max_downtime(void);
 
-void exec_start_incoming_migration(const char *host_port, Error **errp);
-
-void exec_start_outgoing_migration(MigrationState *s, const char *host_port, Error **errp);
-
 void tcp_start_incoming_migration(const char *host_port, Error **errp);
 
 void tcp_start_outgoing_migration(MigrationState *s, const char *host_port, Error **errp);
diff --git a/migration/exec.c b/migration/exec.c
index 2779c9c..1a2d5c2 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -21,7 +21,7 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "migration/channel.h"
-#include "migration/migration.h"
+#include "migration/exec.h"
 #include "io/channel-command.h"
 #include "trace.h"
 
diff --git a/migration/migration.c b/migration/migration.c
index 17d22eb..076c42a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -21,6 +21,7 @@
 #include "migration/machine.h"
 #include "migration/state.h"
 #include "migration/init.h"
+#include "migration/exec.h"
 #include "migration/migration.h"
 #include "migration/qemu-file.h"
 #include "sysemu/sysemu.h"
-- 
2.9.3
