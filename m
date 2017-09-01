Received: from eggs.gnu.org ([2001:4830:134:3::10]:54168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUu-0000V9-Eu
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUl-0007PL-4y
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnlUk-0007O9-Qj
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C5CB77F3F9
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:56:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-75.ams2.redhat.com
	[10.36.116.75])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DCF87B0CC
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:56:21 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 14:56:07 +0200
Message-Id: <20170901125611.29295-44-armbru@redhat.com>
In-Reply-To: <20170901125611.29295-1-armbru@redhat.com>
References: <20170901125611.29295-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 43/47] qapi: Generate FOO_str() macro for QAPI
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

The next commit will put it to use.  May look pointless now, but we're
going to change the FOO_lookup's type, and then it'll help.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1503564371-26090-13-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
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
index af48b0d26b..845eff8177 100644
--- a/block.c
+++ b/block.c
@@ -42,7 +42,6 @@
 #include "qapi-event.h"
 #include "qemu/cutils.h"
 #include "qemu/id.h"
-#include "qapi/util.h"
=20
 #ifdef CONFIG_BSD
 #include <sys/ioctl.h>
diff --git a/block/blkdebug.c b/block/blkdebug.c
index f1bbee9497..b370fcedfb 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -32,7 +32,6 @@
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
-#include "qapi/util.h"
 #include "sysemu/qtest.h"
=20
 typedef struct BDRVBlkdebugState {
diff --git a/block/file-posix.c b/block/file-posix.c
index 97e8a92e23..d81eccc191 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -31,7 +31,6 @@
 #include "block/thread-pool.h"
 #include "qemu/iov.h"
 #include "block/raw-aio.h"
-#include "qapi/util.h"
 #include "qapi/qmp/qstring.h"
=20
 #if defined(__APPLE__) && (__MACH__)
diff --git a/block/file-win32.c b/block/file-win32.c
index 978d8058fe..192ea819d9 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -31,7 +31,6 @@
 #include "block/thread-pool.h"
 #include "qemu/iov.h"
 #include "qapi/qmp/qstring.h"
-#include "qapi/util.h"
 #include <windows.h>
 #include <winioctl.h>
=20
diff --git a/block/gluster.c b/block/gluster.c
index 8367e806d0..0614e0c8aa 100644
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
index eb92366e51..d812210b4f 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -35,7 +35,6 @@
 #include "qemu/module.h"
 #include "qemu/bswap.h"
 #include "qemu/bitmap.h"
-#include "qapi/util.h"
=20
 /**************************************************************/
=20
diff --git a/block/qcow2.c b/block/qcow2.c
index 470a0dedaa..3a93983e3f 100644
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
index cb6617703c..8d1c9f6306 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -22,7 +22,6 @@
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qstring.h"
-#include "qapi/util.h"
 #include "qapi-event.h"
 #include "crypto/hash.h"
=20
diff --git a/blockdev.c b/blockdev.c
index 722a61e3fb..f90bc9399a 100644
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
index c3cacdb1ed..84d189a426 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -20,7 +20,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/util.h"
 #include "qemu/bswap.h"
=20
 #include "crypto/block-luks.h"
diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index ae05327869..f04c63fe82 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -1275,6 +1275,9 @@ Example:
         EXAMPLE_QAPI_EVENT__MAX =3D 1,
     } example_QAPIEvent;
=20
+    #define example_QAPIEvent_str(val) \
+        qapi_enum_lookup(example_QAPIEvent_lookup, (val))
+
     extern const char *const example_QAPIEvent_lookup[];
=20
     #endif
diff --git a/hmp.c b/hmp.c
index 2b6e919501..5d980acb1e 100644
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
index 4eb8a3fe2f..5e50d0c1ce 100644
--- a/include/qapi/util.h
+++ b/include/qapi/util.h
@@ -11,6 +11,7 @@
 #ifndef QAPI_UTIL_H
 #define QAPI_UTIL_H
=20
+const char *qapi_enum_lookup(const char *const lookup[], int val);
 int qapi_enum_parse(const char * const lookup[], const char *buf,
                     int def, Error **errp);
=20
diff --git a/migration/global_state.c b/migration/global_state.c
index 88c55f8cdb..76cd3a13d4 100644
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
index c3fe0ed9ca..1a2b3ebd1a 100644
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
index ee7594ff19..7af2f04d36 100644
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
+    assert(val >=3D 0);
+
+    return lookup[val];
+}
=20
 int qapi_enum_parse(const char * const lookup[], const char *buf,
                     int def, Error **errp)
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index ec83ff68f9..f285879d72 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -14,7 +14,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/util.h"
 #include "qemu-common.h"
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qerror.h"
diff --git a/qemu-img.c b/qemu-img.c
index 611ab7ddf3..a72a2e3133 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -26,7 +26,6 @@
=20
 #include "qemu-version.h"
 #include "qapi/error.h"
-#include "qapi/util.h"
 #include "qapi-visit.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qmp/qerror.h"
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 96e10d62dc..a97f3f4540 100644
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
index bcbef1035f..07b4b70199 100644
--- a/scripts/qapi-event.py
+++ b/scripts/qapi-event.py
@@ -217,6 +217,7 @@ fdef.write(mcgen('''
=20
 fdecl.write(mcgen('''
 #include "qapi/error.h"
+#include "qapi/util.h"
 #include "qapi/qmp/qdict.h"
 #include "%(prefix)sqapi-types.h"
=20
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index b45e7b5634..7e3051dbb9 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -292,6 +292,10 @@ fdef.write(mcgen('''
 ''',
                  prefix=3Dprefix))
=20
+fdecl.write(mcgen('''
+#include "qapi/util.h"
+'''))
+
 schema =3D QAPISchema(input_file)
 gen =3D QAPISchemaGenTypeVisitor()
 schema.visit(gen)
diff --git a/scripts/qapi.py b/scripts/qapi.py
index 3693b520da..8736b9c786 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1894,6 +1894,9 @@ typedef enum %(c_name)s {
=20
     ret +=3D mcgen('''
=20
+#define %(c_name)s_str(val) \\
+    qapi_enum_lookup(%(c_name)s_lookup, (val))
+
 extern const char *const %(c_name)s_lookup[];
 ''',
                  c_name=3Dc_name(name))
diff --git a/tests/test-qapi-util.c b/tests/test-qapi-util.c
index d72ee8c4e7..7e1be1d851 100644
--- a/tests/test-qapi-util.c
+++ b/tests/test-qapi-util.c
@@ -12,7 +12,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/util.h"
 #include "test-qapi-types.h"
=20
 static void test_qapi_enum_parse(void)
diff --git a/tpm.c b/tpm.c
index 7635fc779b..38f3eb827f 100644
--- a/tpm.c
+++ b/tpm.c
@@ -14,7 +14,6 @@
 #include "qemu/osdep.h"
=20
 #include "qapi/qmp/qerror.h"
-#include "qapi/util.h"
 #include "sysemu/tpm_backend.h"
 #include "sysemu/tpm.h"
 #include "qemu/config-file.h"
diff --git a/util/keyval.c b/util/keyval.c
index 7dbda62305..7dfc75cf01 100644
--- a/util/keyval.c
+++ b/util/keyval.c
@@ -82,7 +82,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qstring.h"
-#include "qapi/util.h"
 #include "qemu/cutils.h"
 #include "qemu/option.h"
=20
--=20
2.13.5
