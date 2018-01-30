Received: from eggs.gnu.org ([2001:4830:134:3::10]:59434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egT3M-00047K-1z
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:22:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egT3J-0000b4-9o
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:22:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egT3J-0000ae-1K
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:22:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5FBD35BEB6
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 10:22:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E29CA60C9C
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 10:22:07 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 30 Jan 2018 11:22:01 +0100
Message-Id: <20180130102202.28519-18-armbru@redhat.com>
In-Reply-To: <20180130102202.28519-1-armbru@redhat.com>
References: <20180130102202.28519-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 17/18] Drop superfluous includes of
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
index 8736001156..bfff1fc88a 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -37,7 +37,6 @@
 #include "sysemu/hw_accel.h"
 #include "hw/hw.h"
 #include "sysemu/device_tree.h"
-#include "qapi/qmp/qjson.h"
 #include "exec/gdbstub.h"
 #include "exec/address-spaces.h"
 #include "trace.h"
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-output-visitor.c
index 1b8a9ee372..3cf942414c 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -22,7 +22,6 @@
 #include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qjson.h"
 
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
index 717625122f..581a54c323 100644
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
-- 
2.13.6
