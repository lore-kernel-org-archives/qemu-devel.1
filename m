Received: from eggs.gnu.org ([2001:4830:134:3::10]:50962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egth6-000064-2v
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:49:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egtgz-0003eK-QU
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:49:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egtgz-0003dF-G1
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:48:53 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 31 Jan 2018 15:48:32 +0100
Message-Id: <20180131144846.31697-6-armbru@redhat.com>
In-Reply-To: <20180131144846.31697-1-armbru@redhat.com>
References: <20180131144846.31697-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 05/19] Drop superfluous includes of
 qapi/qmp/qerror.h
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
 backends/tpm.c             | 1 -
 block/qcow.c               | 1 -
 block/qed.c                | 1 -
 blockdev-nbd.c             | 1 -
 hw/s390x/s390-virtio-ccw.c | 1 -
 net/colo-compare.c         | 1 -
 net/filter-mirror.c        | 1 -
 net/filter-rewriter.c      | 1 -
 qapi/qmp-dispatch.c        | 1 -
 qemu-img.c                 | 1 -
 ui/vnc.c                   | 1 -
 11 files changed, 11 deletions(-)

diff --git a/backends/tpm.c b/backends/tpm.c
index 91222c5164..0d129ee9e3 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -15,7 +15,6 @@
 #include "qemu/osdep.h"
 #include "sysemu/tpm_backend.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "sysemu/tpm.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
diff --git a/block/qcow.c b/block/qcow.c
index d552a6eba8..369241aae8 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -30,7 +30,6 @@
 #include "qemu/module.h"
 #include "qemu/bswap.h"
 #include <zlib.h>
-#include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qstring.h"
 #include "crypto/block.h"
 #include "migration/blocker.h"
diff --git a/block/qed.c b/block/qed.c
index 821dcaa055..7e2b34c3a7 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -18,7 +18,6 @@
 #include "qemu/bswap.h"
 #include "trace.h"
 #include "qed.h"
-#include "qapi/qmp/qerror.h"
 #include "sysemu/block-backend.h"
=20
 static int bdrv_qed_probe(const uint8_t *buf, int buf_size,
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index f3c3400e52..a3dabf2dd2 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -14,7 +14,6 @@
 #include "sysemu/block-backend.h"
 #include "hw/block/block.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "sysemu/sysemu.h"
 #include "qmp-commands.h"
 #include "block/nbd.h"
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3807dcb097..7d922ad732 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -33,7 +33,6 @@
 #include "hw/s390x/css-bridge.h"
 #include "migration/register.h"
 #include "cpu_models.h"
-#include "qapi/qmp/qerror.h"
 #include "hw/nmi.h"
=20
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 0ebdec936c..3b955f3ec5 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -16,7 +16,6 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "qemu-common.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/error.h"
 #include "net/net.h"
 #include "net/eth.h"
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index ce0dc23c2a..bd78e25d12 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -14,7 +14,6 @@
 #include "net/net.h"
 #include "qemu-common.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi-visit.h"
 #include "qom/object.h"
 #include "qemu/main-loop.h"
diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index 3ea3798276..6201494ceb 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -15,7 +15,6 @@
 #include "net/filter.h"
 #include "net/net.h"
 #include "qemu-common.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "qapi-visit.h"
 #include "qom/object.h"
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 7d18524f3c..8829c4a45a 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -17,7 +17,6 @@
 #include "qapi/qmp/dispatch.h"
 #include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qerror.h"
=20
 static QDict *qmp_dispatch_check_obj(const QObject *request, Error **err=
p)
 {
diff --git a/qemu-img.c b/qemu-img.c
index 68b375f998..cf8db3d7b7 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -28,7 +28,6 @@
 #include "qapi/error.h"
 #include "qapi-visit.h"
 #include "qapi/qobject-output-visitor.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qbool.h"
 #include "qemu/cutils.h"
diff --git a/ui/vnc.c b/ui/vnc.c
index 8768691db8..9bcc2c0db9 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -35,7 +35,6 @@
 #include "qemu/acl.h"
 #include "qemu/config-file.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/qmp/types.h"
 #include "qmp-commands.h"
 #include "ui/input.h"
--=20
2.13.6
