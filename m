Received: from eggs.gnu.org ([2001:4830:134:3::10]:50985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egth7-00006V-94
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:49:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egth0-0003fI-QW
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:49:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egth0-0003ec-IU
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:48:54 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 31 Jan 2018 15:48:41 +0100
Message-Id: <20180131144846.31697-15-armbru@redhat.com>
In-Reply-To: <20180131144846.31697-1-armbru@redhat.com>
References: <20180131144846.31697-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 14/19] Include qapi/qmp/qbool.h exactly
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
 block.c                        | 1 -
 block/blkdebug.c               | 1 -
 block/curl.c                   | 1 -
 block/qcow2.c                  | 1 -
 block/quorum.c                 | 1 -
 block/vvfat.c                  | 1 -
 hw/usb/xen-usb.c               | 1 -
 monitor.c                      | 1 -
 qemu-img.c                     | 1 -
 qemu-io.c                      | 1 -
 target/s390x/cpu_models.c      | 1 -
 tests/check-qlit.c             | 1 -
 tests/device-introspect-test.c | 1 -
 ui/spice-core.c                | 1 -
 14 files changed, 14 deletions(-)

diff --git a/block.c b/block.c
index 71d2dfb55e..924b084436 100644
--- a/block.c
+++ b/block.c
@@ -32,7 +32,6 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qstring.h"
 #include "sysemu/block-backend.h"
diff --git a/block/blkdebug.c b/block/blkdebug.c
index e21669979d..356538482d 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -29,7 +29,6 @@
 #include "qemu/config-file.h"
 #include "block/block_int.h"
 #include "qemu/module.h"
-#include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "sysemu/qtest.h"
diff --git a/block/curl.c b/block/curl.c
index e0eb8ebb78..fbd62b3864 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -27,7 +27,6 @@
 #include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "block/block_int.h"
-#include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "crypto/secret.h"
diff --git a/block/qcow2.c b/block/qcow2.c
index 700c06245b..a64a572785 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -31,7 +31,6 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi-event.h"
diff --git a/block/quorum.c b/block/quorum.c
index ec427c39e7..980403f63e 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -17,7 +17,6 @@
 #include "qemu/cutils.h"
 #include "block/block_int.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qjson.h"
diff --git a/block/vvfat.c b/block/vvfat.c
index 93e76580b0..5dca227311 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -30,7 +30,6 @@
 #include "qemu/module.h"
 #include "qemu/bswap.h"
 #include "migration/blocker.h"
-#include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/cutils.h"
diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
index 3b678685e1..e9eb1e902f 100644
--- a/hw/usb/xen-usb.c
+++ b/hw/usb/xen-usb.c
@@ -29,7 +29,6 @@
 #include "hw/usb.h"
 #include "hw/xen/xen_backend.h"
 #include "monitor/qdev.h"
-#include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
=20
diff --git a/monitor.c b/monitor.c
index 69737f2d9a..02d9dd8708 100644
--- a/monitor.c
+++ b/monitor.c
@@ -53,7 +53,6 @@
 #include "qemu/acl.h"
 #include "sysemu/tpm.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qjson.h"
diff --git a/qemu-img.c b/qemu-img.c
index 6ead3b7c3d..778fab9979 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -30,7 +30,6 @@
 #include "qapi-visit.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/cutils.h"
diff --git a/qemu-io.c b/qemu-io.c
index 2e5737ce9c..f554ab614b 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -21,7 +21,6 @@
 #include "qemu/readline.h"
 #include "qemu/log.h"
 #include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qom/object_interfaces.h"
 #include "sysemu/block-backend.h"
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 27201c4f91..584c409a19 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -20,7 +20,6 @@
 #include "qemu/error-report.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qobject-input-visitor.h"
-#include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/arch_init.h"
diff --git a/tests/check-qlit.c b/tests/check-qlit.c
index b8b5016af7..f012885534 100644
--- a/tests/check-qlit.c
+++ b/tests/check-qlit.c
@@ -9,7 +9,6 @@
=20
 #include "qemu/osdep.h"
=20
-#include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qlit.h"
diff --git a/tests/device-introspect-test.c b/tests/device-introspect-tes=
t.c
index 2b3d01174d..b80058fe98 100644
--- a/tests/device-introspect-test.c
+++ b/tests/device-introspect-test.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "libqtest.h"
diff --git a/ui/spice-core.c b/ui/spice-core.c
index c4d67e678c..03f9e83456 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -31,7 +31,6 @@
 #include "qemu/sockets.h"
 #include "qmp-commands.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qjson.h"
 #include "qemu/notify.h"
 #include "migration/misc.h"
--=20
2.13.6
