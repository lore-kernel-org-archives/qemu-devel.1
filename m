Received: from eggs.gnu.org ([2001:4830:134:3::10]:51016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egthA-00009t-Bs
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:49:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egth3-0003hh-Mn
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:49:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egth3-0003h9-DY
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:48:57 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 31 Jan 2018 15:48:45 +0100
Message-Id: <20180131144846.31697-19-armbru@redhat.com>
In-Reply-To: <20180131144846.31697-1-armbru@redhat.com>
References: <20180131144846.31697-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 18/19] Drop superfluous includes of
 qapi/qmp/qjson.h
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
 balloon.c                           | 1 -
 block/nbd.c                         | 1 -
 block/quorum.c                      | 1 -
 blockjob.c                          | 1 -
 hw/core/qdev.c                      | 1 -
 hw/net/virtio-net.c                 | 1 -
 hw/pci/pcie_aer.c                   | 1 -
 target/s390x/kvm.c                  | 1 -
 tests/test-qobject-output-visitor.c | 1 -
 ui/spice-core.c                     | 1 -
 vl.c                                | 1 -
 11 files changed, 11 deletions(-)

diff --git a/balloon.c b/balloon.c
index f8b5ca9870..d8dd6fe773 100644
--- a/balloon.c
+++ b/balloon.c
@@ -33,7 +33,6 @@
 #include "qmp-commands.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qjson.h"
=20
 static QEMUBalloonEvent *balloon_event_fn;
 static QEMUBalloonStatus *balloon_stat_fn;
diff --git a/block/nbd.c b/block/nbd.c
index 8b8ba56cdd..fbec4ae320 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -36,7 +36,6 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/cutils.h"
=20
diff --git a/block/quorum.c b/block/quorum.c
index 980403f63e..2dc79bf7e2 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -19,7 +19,6 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi-event.h"
diff --git a/blockjob.c b/blockjob.c
index 081f1d2b91..3f52f29f75 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -31,7 +31,6 @@
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qjson.h"
 #include "qemu/coroutine.h"
 #include "qemu/id.h"
 #include "qemu/timer.h"
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f93f7d9388..e1143ad542 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -31,7 +31,6 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/visitor.h"
-#include "qapi/qmp/qjson.h"
 #include "qemu/error-report.h"
 #include "hw/hotplug.h"
 #include "hw/boards.h"
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 0dd3cb8de4..369d40b378 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -23,7 +23,6 @@
 #include "net/vhost_net.h"
 #include "hw/virtio/virtio-bus.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qjson.h"
 #include "qapi-event.h"
 #include "hw/virtio/virtio-access.h"
 #include "migration/misc.h"
diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index 0b55392fe7..939da0b778 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
 #include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qjson.h"
 #include "monitor/monitor.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pcie.h"
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 63c531e028..8fbbf72e4b 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -38,7 +38,6 @@
 #include "sysemu/hw_accel.h"
 #include "hw/hw.h"
 #include "sysemu/device_tree.h"
-#include "qapi/qmp/qjson.h"
 #include "exec/gdbstub.h"
 #include "exec/address-spaces.h"
 #include "trace.h"
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-out=
put-visitor.c
index 1b8a9ee372..3cf942414c 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -22,7 +22,6 @@
 #include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qjson.h"
=20
 typedef struct TestOutputVisitorData {
     Visitor *ov;
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 03f9e83456..64ed759be5 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -31,7 +31,6 @@
 #include "qemu/sockets.h"
 #include "qmp-commands.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qjson.h"
 #include "qemu/notify.h"
 #include "migration/misc.h"
 #include "hw/hw.h"
diff --git a/vl.c b/vl.c
index 3400c7f06c..13da60d404 100644
--- a/vl.c
+++ b/vl.c
@@ -98,7 +98,6 @@ int main(int argc, char **argv)
 #include "sysemu/hax.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi-visit.h"
-#include "qapi/qmp/qjson.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qemu-options.h"
--=20
2.13.6
