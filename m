Received: from eggs.gnu.org ([2001:4830:134:3::10]:59400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egT3K-00046X-Fp
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:22:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egT3H-0000Zu-FA
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:22:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egT3H-0000Yy-78
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:22:07 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6569AC0587E1
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 10:22:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 042905C3FD
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 10:22:06 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 30 Jan 2018 11:21:54 +0100
Message-Id: <20180130102202.28519-11-armbru@redhat.com>
In-Reply-To: <20180130102202.28519-1-armbru@redhat.com>
References: <20180130102202.28519-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 10/18] Include qapi/qmp/qlist.h exactly where
 needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This cleanup makes the number of objects depending on qapi/qmp/qlist.h
drop from 4548 (out of 4739) to 16 in my "build everything" tree.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/qapi.c                        | 1 +
 block/rbd.c                         | 1 +
 blockdev.c                          | 1 +
 include/qapi/qmp/json-parser.h      | 1 -
 include/qapi/qmp/qdict.h            | 1 -
 qapi/qobject-input-visitor.c        | 1 +
 qapi/qobject-output-visitor.c       | 1 +
 qobject/json-parser.c               | 1 +
 qobject/qdict.c                     | 1 +
 qobject/qjson.c                     | 1 +
 qobject/qlit.c                      | 1 +
 qobject/qobject.c                   | 1 +
 tests/check-qdict.c                 | 2 ++
 tests/check-qlit.c                  | 1 +
 tests/check-qobject.c               | 2 ++
 tests/device-introspect-test.c      | 1 +
 tests/libqtest.c                    | 2 ++
 tests/numa-test.c                   | 1 +
 tests/qmp-test.c                    | 1 +
 tests/qom-test.c                    | 1 +
 tests/test-keyval.c                 | 1 +
 tests/test-qga.c                    | 1 +
 tests/test-qobject-output-visitor.c | 1 +
 tests/test-x86-cpuid-compat.c       | 1 +
 ui/vnc-palette.h                    | 1 -
 util/keyval.c                       | 1 +
 util/qemu-config.c                  | 1 +
 27 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 1e0cb2743d..12a8cb5a82 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -32,6 +32,7 @@
 #include "qapi/error.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "sysemu/block-backend.h"
diff --git a/block/rbd.c b/block/rbd.c
index a76a5e8755..76b9e83cea 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -21,6 +21,7 @@
 #include "qemu/cutils.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qlist.h"
 
 /*
  * When specifying the image filename use:
diff --git a/blockdev.c b/blockdev.c
index c487cf0e4b..90ef3166de 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -45,6 +45,7 @@
 #include "qapi-visit.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
+#include "qapi/qmp/qlist.h"
 #include "qapi/qobject-output-visitor.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/iothread.h"
diff --git a/include/qapi/qmp/json-parser.h b/include/qapi/qmp/json-parser.h
index 9987f8ca85..102f5c0068 100644
--- a/include/qapi/qmp/json-parser.h
+++ b/include/qapi/qmp/json-parser.h
@@ -15,7 +15,6 @@
 #define QEMU_JSON_PARSER_H
 
 #include "qemu-common.h"
-#include "qapi/qmp/qlist.h"
 
 QObject *json_parser_parse(GQueue *tokens, va_list *ap);
 QObject *json_parser_parse_err(GQueue *tokens, va_list *ap, Error **errp);
diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
index 3c1def00f7..ff6f7842c3 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qapi/qmp/qdict.h
@@ -14,7 +14,6 @@
 #define QDICT_H
 
 #include "qapi/qmp/qobject.h"
-#include "qapi/qmp/qlist.h"
 #include "qemu/queue.h"
 
 #define QDICT_BUCKET_MAX 512
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 31183dcb62..3e235a1eee 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -22,6 +22,7 @@
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qerror.h"
+#include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qnum.h"
 #include "qemu/cutils.h"
diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.c
index f0cc46b3cf..52634b9725 100644
--- a/qapi/qobject-output-visitor.c
+++ b/qapi/qobject-output-visitor.c
@@ -18,6 +18,7 @@
 #include "qemu/queue.h"
 #include "qemu-common.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 8f4badc6d9..ee0cbba6a5 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -16,6 +16,7 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
diff --git a/qobject/qdict.c b/qobject/qdict.c
index 88f87d2527..23df84f9cd 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -14,6 +14,7 @@
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/error.h"
diff --git a/qobject/qjson.c b/qobject/qjson.c
index 7fbb68b6ba..527b5bb571 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -18,6 +18,7 @@
 #include "qapi/qmp/json-streamer.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnum.h"
 #include "qemu/unicode.h"
 
diff --git a/qobject/qlit.c b/qobject/qlit.c
index c2d0303425..948e0b860c 100644
--- a/qobject/qlit.c
+++ b/qobject/qlit.c
@@ -17,6 +17,7 @@
 
 #include "qapi/qmp/qlit.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
diff --git a/qobject/qobject.c b/qobject/qobject.c
index 5bbcd04812..23600aa1c1 100644
--- a/qobject/qobject.c
+++ b/qobject/qobject.c
@@ -13,6 +13,7 @@
 #include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qstring.h"
 
 static void (*qdestroy[QTYPE__MAX])(QObject *) = {
diff --git a/tests/check-qdict.c b/tests/check-qdict.c
index 1b1173634f..d11904ea0c 100644
--- a/tests/check-qdict.c
+++ b/tests/check-qdict.c
@@ -9,9 +9,11 @@
  * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  */
+
 #include "qemu/osdep.h"
 
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/error.h"
diff --git a/tests/check-qlit.c b/tests/check-qlit.c
index c59ec1ab88..b8b5016af7 100644
--- a/tests/check-qlit.c
+++ b/tests/check-qlit.c
@@ -11,6 +11,7 @@
 
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qlit.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
diff --git a/tests/check-qobject.c b/tests/check-qobject.c
index 9e1e82045f..927966093a 100644
--- a/tests/check-qobject.c
+++ b/tests/check-qobject.c
@@ -6,9 +6,11 @@
  * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
  * See the COPYING.LIB file in the top-level directory.
  */
+
 #include "qemu/osdep.h"
 
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
diff --git a/tests/device-introspect-test.c b/tests/device-introspect-test.c
index f7162c023f..2b3d01174d 100644
--- a/tests/device-introspect-test.c
+++ b/tests/device-introspect-test.c
@@ -22,6 +22,7 @@
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qlist.h"
 #include "libqtest.h"
 
 const char common_args[] = "-nodefaults -machine none";
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 0ec8af2923..cd0cc57e80 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -14,6 +14,7 @@
  * See the COPYING file in the top-level directory.
  *
  */
+
 #include "qemu/osdep.h"
 #include "libqtest.h"
 
@@ -25,6 +26,7 @@
 #include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/json-streamer.h"
 #include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qlist.h"
 
 #define MAX_IRQ 256
 #define SOCKET_TIMEOUT 50
diff --git a/tests/numa-test.c b/tests/numa-test.c
index e1b6152244..8158854e17 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qapi/qmp/qlist.h"
 
 static char *make_cli(const char *generic_cli, const char *test_cli)
 {
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 36feb2204b..cc9661af47 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -14,6 +14,7 @@
 #include "libqtest.h"
 #include "qapi-visit.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qlist.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/util.h"
 #include "qapi/visitor.h"
diff --git a/tests/qom-test.c b/tests/qom-test.c
index 0ee990710c..847703cb14 100644
--- a/tests/qom-test.c
+++ b/tests/qom-test.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 
 #include "qemu-common.h"
+#include "qapi/qmp/qlist.h"
 #include "qemu/cutils.h"
 #include "libqtest.h"
 
diff --git a/tests/test-keyval.c b/tests/test-keyval.c
index baf7e339ab..d0c4bf2b9d 100644
--- a/tests/test-keyval.c
+++ b/tests/test-keyval.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 #include "test-qapi-visit.h"
diff --git a/tests/test-qga.c b/tests/test-qga.c
index fd6bc7690f..e67c7289eb 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -5,6 +5,7 @@
 #include <sys/un.h>
 
 #include "libqtest.h"
+#include "qapi/qmp/qlist.h"
 
 typedef struct {
     char *test_dir;
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-output-visitor.c
index 4a24e12121..7cf86707ec 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -17,6 +17,7 @@
 #include "qapi/qobject-output-visitor.h"
 #include "test-qapi-visit.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qjson.h"
diff --git a/tests/test-x86-cpuid-compat.c b/tests/test-x86-cpuid-compat.c
index c594b5bd97..495dd1e7ef 100644
--- a/tests/test-x86-cpuid-compat.c
+++ b/tests/test-x86-cpuid-compat.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qbool.h"
 #include "libqtest.h"
diff --git a/ui/vnc-palette.h b/ui/vnc-palette.h
index 1bd4318f53..e9f0eaf73b 100644
--- a/ui/vnc-palette.h
+++ b/ui/vnc-palette.h
@@ -29,7 +29,6 @@
 #ifndef VNC_PALETTE_H
 #define VNC_PALETTE_H
 
-#include "qapi/qmp/qlist.h"
 #include "qemu/queue.h"
 
 #define VNC_PALETTE_HASH_SIZE 256
diff --git a/util/keyval.c b/util/keyval.c
index 7dfc75cf01..4085282a7a 100644
--- a/util/keyval.c
+++ b/util/keyval.c
@@ -81,6 +81,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/cutils.h"
 #include "qemu/option.h"
diff --git a/util/qemu-config.c b/util/qemu-config.c
index 26ea248062..230c699a51 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qlist.h"
 #include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
-- 
2.13.6
