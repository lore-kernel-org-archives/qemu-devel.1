Received: from eggs.gnu.org ([2001:4830:134:3::10]:37161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dknmP-0003PT-5M
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dknmM-0000ON-CD
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dknmM-0000NR-2q
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:18 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Aug 2017 10:46:07 +0200
Message-Id: <1503564371-26090-13-git-send-email-armbru@redhat.com>
In-Reply-To: <1503564371-26090-1-git-send-email-armbru@redhat.com>
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 12/16] qapi: Generate FOO_str() macro for QAPI
 enum FOO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

The next commit will put it to use.  May look pointless now, but we're
going to change the FOO_lookup's type, and then it'll help.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block.c                      | 1 -
 block/blkdebug.c             | 1 -
 block/file-posix.c           | 1 -
 block/file-win32.c           | 1 -
 block/gluster.c              | 1 -
 block/parallels.c            | 1 -
 block/qcow2.c                | 1 -
 block/quorum.c               | 1 -
 blockdev.c                   | 1 -
 crypto/block-luks.c          | 1 -
 docs/devel/qapi-code-gen.txt | 3 +++
 hmp.c                        | 1 -
 include/qapi/util.h          | 1 +
 migration/global_state.c     | 1 -
 migration/migration.c        | 1 -
 qapi/qapi-util.c             | 8 +++++++-
 qapi/qapi-visit-core.c       | 1 -
 qemu-img.c                   | 1 -
 qemu-nbd.c                   | 1 -
 scripts/qapi-event.py        | 1 +
 scripts/qapi-types.py        | 4 ++++
 scripts/qapi.py              | 3 +++
 tests/test-qapi-util.c       | 1 -
 tpm.c                        | 1 -
 util/keyval.c                | 1 -
 25 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/block.c b/block.c
index dd0efa2..2d12131 100644
--- a/block.c
+++ b/block.c
@@ -42,7 +42,6 @@
 #include "qapi-event.h"
 #include "qemu/cutils.h"
 #include "qemu/id.h"
-#include "qapi/util.h"
 
 #ifdef CONFIG_BSD
 #include <sys/ioctl.h>
diff --git a/block/blkdebug.c b/block/blkdebug.c
index f1bbee9..b370fce 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -32,7 +32,6 @@
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
-#include "qapi/util.h"
 #include "sysemu/qtest.h"
 
 typedef struct BDRVBlkdebugState {
diff --git a/block/file-posix.c b/block/file-posix.c
index 97e8a92..d81eccc 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -31,7 +31,6 @@
 #include "block/thread-pool.h"
 #include "qemu/iov.h"
 #include "block/raw-aio.h"
-#include "qapi/util.h"
 #include "qapi/qmp/qstring.h"
 
 #if defined(__APPLE__) && (__MACH__)
diff --git a/block/file-win32.c b/block/file-win32.c
index 978d805..192ea81 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -31,7 +31,6 @@
 #include "block/thread-pool.h"
 #include "qemu/iov.h"
 #include "qapi/qmp/qstring.h"
-#include "qapi/util.h"
 #include <windows.h>
 #include <winioctl.h>
 
diff --git a/block/gluster.c b/block/gluster.c
index 8367e80..0614e0c 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -12,7 +12,6 @@
 #include "block/block_int.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/util.h"
 #include "qemu/uri.h"
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
diff --git a/block/parallels.c b/block/parallels.c
index eb92366..d812210 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -35,7 +35,6 @@
 #include "qemu/module.h"
 #include "qemu/bswap.h"
 #include "qemu/bitmap.h"
-#include "qapi/util.h"
 
 /**************************************************************/
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 7aaf248..41e067e 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -30,7 +30,6 @@
 #include "qemu/error-report.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qbool.h"
-#include "qapi/util.h"
 #include "qapi/qmp/types.h"
 #include "qapi-event.h"
 #include "trace.h"
diff --git a/block/quorum.c b/block/quorum.c
index cb66177..8d1c9f6 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -22,7 +22,6 @@
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qstring.h"
-#include "qapi/util.h"
 #include "qapi-event.h"
 #include "crypto/hash.h"
 
diff --git a/blockdev.c b/blockdev.c
index 722a61e..f90bc93 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -44,7 +44,6 @@
 #include "qapi-visit.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qobject-output-visitor.h"
-#include "qapi/util.h"
 #include "sysemu/sysemu.h"
 #include "block/block_int.h"
 #include "qmp-commands.h"
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index c3cacdb..84d189a 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/util.h"
 #include "qemu/bswap.h"
 
 #include "crypto/block-luks.h"
diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index ae05327..f04c63f 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -1275,6 +1275,9 @@ Example:
         EXAMPLE_QAPI_EVENT__MAX = 1,
     } example_QAPIEvent;
 
+    #define example_QAPIEvent_str(val) \
+        qapi_enum_lookup(example_QAPIEvent_lookup, (val))
+
     extern const char *const example_QAPIEvent_lookup[];
 
     #endif
diff --git a/hmp.c b/hmp.c
index 2b6e919..5d980ac 100644
--- a/hmp.c
+++ b/hmp.c
@@ -31,7 +31,6 @@
 #include "qapi/qmp/qerror.h"
 #include "qapi/string-input-visitor.h"
 #include "qapi/string-output-visitor.h"
-#include "qapi/util.h"
 #include "qapi-visit.h"
 #include "qom/object_interfaces.h"
 #include "ui/console.h"
diff --git a/include/qapi/util.h b/include/qapi/util.h
index 4eb8a3f..5e50d0c 100644
--- a/include/qapi/util.h
+++ b/include/qapi/util.h
@@ -11,6 +11,7 @@
 #ifndef QAPI_UTIL_H
 #define QAPI_UTIL_H
 
+const char *qapi_enum_lookup(const char *const lookup[], int val);
 int qapi_enum_parse(const char * const lookup[], const char *buf,
                     int def, Error **errp);
 
diff --git a/migration/global_state.c b/migration/global_state.c
index 88c55f8..76cd3a1 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -14,7 +14,6 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "qapi/util.h"
 #include "migration.h"
 #include "migration/global_state.h"
 #include "migration/vmstate.h"
diff --git a/migration/migration.c b/migration/migration.c
index c3fe0ed..1a2b3eb 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -31,7 +31,6 @@
 #include "migration/vmstate.h"
 #include "block/block.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/util.h"
 #include "qemu/rcu.h"
 #include "block.h"
 #include "postcopy-ram.h"
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index ee7594f..7af2f04 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -13,7 +13,13 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
-#include "qapi/util.h"
+
+const char *qapi_enum_lookup(const char *const lookup[], int val)
+{
+    assert(val >= 0);
+
+    return lookup[val];
+}
 
 int qapi_enum_parse(const char * const lookup[], const char *buf,
                     int def, Error **errp)
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index ec83ff6..f285879 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -14,7 +14,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/util.h"
 #include "qemu-common.h"
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qerror.h"
diff --git a/qemu-img.c b/qemu-img.c
index 611ab7d..a72a2e3 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -26,7 +26,6 @@
 
 #include "qemu-version.h"
 #include "qapi/error.h"
-#include "qapi/util.h"
 #include "qapi-visit.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qmp/qerror.h"
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 96e10d6..a97f3f4 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -34,7 +34,6 @@
 #include "qemu/log.h"
 #include "qemu/systemd.h"
 #include "block/snapshot.h"
-#include "qapi/util.h"
 #include "qapi/qmp/qstring.h"
 #include "qom/object_interfaces.h"
 #include "io/channel-socket.h"
diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
index bcbef10..07b4b70 100644
--- a/scripts/qapi-event.py
+++ b/scripts/qapi-event.py
@@ -217,6 +217,7 @@ fdef.write(mcgen('''
 
 fdecl.write(mcgen('''
 #include "qapi/error.h"
+#include "qapi/util.h"
 #include "qapi/qmp/qdict.h"
 #include "%(prefix)sqapi-types.h"
 
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index b45e7b5..7e3051d 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -292,6 +292,10 @@ fdef.write(mcgen('''
 ''',
                  prefix=prefix))
 
+fdecl.write(mcgen('''
+#include "qapi/util.h"
+'''))
+
 schema = QAPISchema(input_file)
 gen = QAPISchemaGenTypeVisitor()
 schema.visit(gen)
diff --git a/scripts/qapi.py b/scripts/qapi.py
index 8aa2775..1cd713d 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1894,6 +1894,9 @@ typedef enum %(c_name)s {
 
     ret += mcgen('''
 
+#define %(c_name)s_str(val) \\
+    qapi_enum_lookup(%(c_name)s_lookup, (val))
+
 extern const char *const %(c_name)s_lookup[];
 ''',
                  c_name=c_name(name))
diff --git a/tests/test-qapi-util.c b/tests/test-qapi-util.c
index d72ee8c..7e1be1d 100644
--- a/tests/test-qapi-util.c
+++ b/tests/test-qapi-util.c
@@ -12,7 +12,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/util.h"
 #include "test-qapi-types.h"
 
 static void test_qapi_enum_parse(void)
diff --git a/tpm.c b/tpm.c
index 7635fc7..38f3eb8 100644
--- a/tpm.c
+++ b/tpm.c
@@ -14,7 +14,6 @@
 #include "qemu/osdep.h"
 
 #include "qapi/qmp/qerror.h"
-#include "qapi/util.h"
 #include "sysemu/tpm_backend.h"
 #include "sysemu/tpm.h"
 #include "qemu/config-file.h"
diff --git a/util/keyval.c b/util/keyval.c
index 7dbda62..7dfc75c 100644
--- a/util/keyval.c
+++ b/util/keyval.c
@@ -82,7 +82,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qstring.h"
-#include "qapi/util.h"
 #include "qemu/cutils.h"
 #include "qemu/option.h"
 
-- 
2.7.5
