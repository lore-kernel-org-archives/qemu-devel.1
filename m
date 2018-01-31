Received: from eggs.gnu.org ([2001:4830:134:3::10]:50940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egth5-00005Y-31
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:49:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egth2-0003gz-Sm
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:48:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egth2-0003g9-Kl
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:48:56 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 31 Jan 2018 15:48:40 +0100
Message-Id: <20180131144846.31697-14-armbru@redhat.com>
In-Reply-To: <20180131144846.31697-1-armbru@redhat.com>
References: <20180131144846.31697-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 13/19] Include qapi/qmp/qstring.h exactly
 where needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, eblake@redhat.com, f4bug@amsat.org

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block.c                             | 1 +
 include/qapi/qmp/qjson.h            | 2 --
 monitor.c                           | 1 +
 qapi/qobject-input-visitor.c        | 1 +
 qemu-img.c                          | 1 +
 qga/main.c                          | 1 +
 qobject/qjson.c                     | 1 +
 tests/check-qjson.c                 | 1 +
 tests/libqtest.c                    | 1 +
 tests/test-qobject-input-visitor.c  | 1 +
 tests/test-qobject-output-visitor.c | 1 +
 tests/test-visitor-serialization.c  | 1 +
 ui/spice-core.c                     | 1 -
 13 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index a97f709252..71d2dfb55e 100644
--- a/block.c
+++ b/block.c
@@ -34,6 +34,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qstring.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/sysemu.h"
 #include "qemu/notify.h"
diff --git a/include/qapi/qmp/qjson.h b/include/qapi/qmp/qjson.h
index 6b38b0f074..b274ac3a86 100644
--- a/include/qapi/qmp/qjson.h
+++ b/include/qapi/qmp/qjson.h
@@ -14,8 +14,6 @@
 #ifndef QJSON_H
 #define QJSON_H
=20
-#include "qapi/qmp/qstring.h"
-
 QObject *qobject_from_json(const char *string, Error **errp);
 QObject *qobject_from_jsonf(const char *string, ...) GCC_FMT_ATTR(1, 2);
 QObject *qobject_from_jsonv(const char *string, va_list *ap, Error **err=
p)
diff --git a/monitor.c b/monitor.c
index 20f7b159b3..69737f2d9a 100644
--- a/monitor.c
+++ b/monitor.c
@@ -55,6 +55,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qnum.h"
+#include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/json-streamer.h"
 #include "qapi/qmp/json-parser.h"
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 3566eed365..023317b05f 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -26,6 +26,7 @@
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qnum.h"
+#include "qapi/qmp/qstring.h"
 #include "qemu/cutils.h"
 #include "qemu/option.h"
=20
diff --git a/qemu-img.c b/qemu-img.c
index fc6b4ffc00..6ead3b7c3d 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -32,6 +32,7 @@
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qstring.h"
 #include "qemu/cutils.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
diff --git a/qga/main.c b/qga/main.c
index 804cc4c1a0..64e0776bf2 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -21,6 +21,7 @@
 #include "qapi/qmp/json-streamer.h"
 #include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qstring.h"
 #include "qga/guest-agent-core.h"
 #include "qemu/module.h"
 #include "qga-qmp-commands.h"
diff --git a/qobject/qjson.c b/qobject/qjson.c
index 77f796bbee..e1ce75651c 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -21,6 +21,7 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnum.h"
+#include "qapi/qmp/qstring.h"
 #include "qemu/unicode.h"
=20
 typedef struct JSONParsingState
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 26f5d4401e..a18ea47cb7 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -19,6 +19,7 @@
 #include "qapi/qmp/qlit.h"
 #include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qnum.h"
+#include "qapi/qmp/qstring.h"
 #include "qemu-common.h"
=20
 static void escaped_string(void)
diff --git a/tests/libqtest.c b/tests/libqtest.c
index b65374c634..f2c285374b 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -27,6 +27,7 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qlist.h"
+#include "qapi/qmp/qstring.h"
=20
 #define MAX_IRQ 256
 #define SOCKET_TIMEOUT 50
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
index 2e6f7f422f..3900be2610 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -21,6 +21,7 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qnum.h"
+#include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qjson.h"
 #include "test-qmp-introspect.h"
 #include "qmp-introspect.h"
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-out=
put-visitor.c
index 09a56d2d06..1b8a9ee372 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -21,6 +21,7 @@
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qnum.h"
+#include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qjson.h"
=20
 typedef struct TestOutputVisitorData {
diff --git a/tests/test-visitor-serialization.c b/tests/test-visitor-seri=
alization.c
index 928a82b2e6..dd7e51d4f5 100644
--- a/tests/test-visitor-serialization.c
+++ b/tests/test-visitor-serialization.c
@@ -18,6 +18,7 @@
 #include "test-qapi-visit.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/string-input-visitor.h"
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 7a53db070c..c4d67e678c 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -32,7 +32,6 @@
 #include "qmp-commands.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qjson.h"
 #include "qemu/notify.h"
 #include "migration/misc.h"
--=20
2.13.6
