Received: from eggs.gnu.org ([2001:4830:134:3::10]:59521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ejP1L-0001Mz-3y
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:40:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ejP1I-0004gJ-Lc
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:40:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59710 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ejP1I-0004fU-GZ
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:40:12 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2127281AE8AD
	for <qemu-devel@nongnu.org>; Wed,  7 Feb 2018 12:40:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D45202166BB2
	for <qemu-devel@nongnu.org>; Wed,  7 Feb 2018 12:40:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  7 Feb 2018 13:39:55 +0100
Message-Id: <20180207124009.12376-7-armbru@redhat.com>
In-Reply-To: <20180207124009.12376-1-armbru@redhat.com>
References: <20180207124009.12376-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/20] Drop superfluous includes of
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

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180201111846.21846-6-armbru@redhat.com>
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
index d617ba7c52..a00438b904 100644
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
index e0f09824fd..3a5479bdad 100644
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
index 8622b0b35a..76e03fdb14 100644
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
index b1388f06a4..0f12799f38 100644
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
