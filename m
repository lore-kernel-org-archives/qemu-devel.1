Received: from eggs.gnu.org ([2001:4830:134:3::10]:55654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38aw-0007e8-87
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d38at-0005xh-QN
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:06:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37067)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d38at-0005wi-HO
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:05:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 89A1D3DBC6
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 22:05:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 26 Apr 2017 00:04:42 +0200
Message-Id: <20170425220451.6028-33-quintela@redhat.com>
In-Reply-To: <20170425220451.6028-1-quintela@redhat.com>
References: <20170425220451.6028-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 32/41] migration: Move constants to savevm.h
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
 include/migration/migration.h | 15 ---------------
 migration/savevm.h            | 15 +++++++++++++++
 migration/vmstate.c           |  1 +
 tests/test-vmstate.c          |  1 +
 4 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 5c27fe7..ac6e545 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -22,21 +22,6 @@
 #include "exec/cpu-common.h"
 #include "qemu/coroutine_int.h"
 
-#define QEMU_VM_FILE_MAGIC           0x5145564d
-#define QEMU_VM_FILE_VERSION_COMPAT  0x00000002
-#define QEMU_VM_FILE_VERSION         0x00000003
-
-#define QEMU_VM_EOF                  0x00
-#define QEMU_VM_SECTION_START        0x01
-#define QEMU_VM_SECTION_PART         0x02
-#define QEMU_VM_SECTION_END          0x03
-#define QEMU_VM_SECTION_FULL         0x04
-#define QEMU_VM_SUBSECTION           0x05
-#define QEMU_VM_VMDESCRIPTION        0x06
-#define QEMU_VM_CONFIGURATION        0x07
-#define QEMU_VM_COMMAND              0x08
-#define QEMU_VM_SECTION_FOOTER       0x7e
-
 /* for vl.c */
 extern int only_migratable;
 
diff --git a/migration/savevm.h b/migration/savevm.h
index 75b2b8c..b4c1f3c 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -14,6 +14,21 @@
 #ifndef MIGRATION_SAVEVM_H
 #define MIGRATION_SAVEVM_H
 
+#define QEMU_VM_FILE_MAGIC           0x5145564d
+#define QEMU_VM_FILE_VERSION_COMPAT  0x00000002
+#define QEMU_VM_FILE_VERSION         0x00000003
+
+#define QEMU_VM_EOF                  0x00
+#define QEMU_VM_SECTION_START        0x01
+#define QEMU_VM_SECTION_PART         0x02
+#define QEMU_VM_SECTION_END          0x03
+#define QEMU_VM_SECTION_FULL         0x04
+#define QEMU_VM_SUBSECTION           0x05
+#define QEMU_VM_VMDESCRIPTION        0x06
+#define QEMU_VM_CONFIGURATION        0x07
+#define QEMU_VM_COMMAND              0x08
+#define QEMU_VM_SECTION_FOOTER       0x7e
+
 bool qemu_savevm_state_blocked(Error **errp);
 void qemu_savevm_state_begin(QEMUFile *f);
 void qemu_savevm_state_header(QEMUFile *f);
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 57dc34f..4b0cb2f 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -29,6 +29,7 @@
 #include "qemu-common.h"
 #include "migration/migration.h"
 #include "migration/vmstate.h"
+#include "migration/savevm.h"
 #include "qemu-file.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index c52aff9..f30433a 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -30,6 +30,7 @@
 #include "migration/qemu-file-types.h"
 #include "../migration/qemu-file.h"
 #include "../migration/qemu-file-channel.h"
+#include "../migration/savevm.h"
 #include "qemu/coroutine.h"
 #include "io/channel-file.h"
 
-- 
2.9.3
