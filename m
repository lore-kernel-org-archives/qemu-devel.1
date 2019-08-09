Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C25CC31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 06:53:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52FA2208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 06:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FA2208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvymY-0002Pe-K0
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 02:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48395)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hvygC-0000vO-RW
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hvyg8-0001pm-EK
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53732)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hvyg8-0001mz-4D
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 04441309BF13
 for <qemu-devel@nongnu.org>; Fri,  9 Aug 2019 06:47:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E0705C226
 for <qemu-devel@nongnu.org>; Fri,  9 Aug 2019 06:47:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D9AE31136437; Fri,  9 Aug 2019 08:46:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 08:46:44 +0200
Message-Id: <20190809064645.22656-29-armbru@redhat.com>
In-Reply-To: <20190809064645.22656-1-armbru@redhat.com>
References: <20190809064645.22656-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 09 Aug 2019 06:47:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 28/29] sysemu: Move the VMChangeStateEntry
 typedef to qemu/typedefs.h
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In my "build everything" tree, changing sysemu/sysemu.h triggers a
recompile of some 1800 out of 6600 objects (not counting tests and
objects that don't depend on qemu/osdep.h, down from 5400 due to the
previous commit).

Several headers include sysemu/sysemu.h just to get typedef
VMChangeStateEntry.  Move it from sysemu/sysemu.h to qemu/typedefs.h.
Spell its structure tag the same while there.  Drop the now
superfluous includes of sysemu/sysemu.h from headers.

Touching sysemu/sysemu.h now recompiles some 1100 objects.
qemu/uuid.h also drops from 1800 to 1100, and
qapi/qapi-types-run-state.h from 5000 to 4400.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/block/vhost-user-blk.c   | 1 +
 hw/block/virtio-blk.c       | 1 +
 hw/display/virtio-gpu.c     | 1 +
 hw/misc/macio/macio.c       | 1 +
 hw/net/virtio-net.c         | 1 +
 hw/s390x/s390-ccw.c         | 1 +
 hw/s390x/s390-virtio-ccw.c  | 1 +
 hw/scsi/scsi-bus.c          | 1 +
 hw/scsi/vhost-scsi.c        | 1 +
 hw/scsi/vhost-user-scsi.c   | 1 +
 hw/usb/hcd-ehci.c           | 1 +
 hw/usb/hcd-ehci.h           | 1 -
 hw/virtio/virtio-rng.c      | 1 +
 hw/virtio/virtio.c          | 1 +
 include/hw/ide/internal.h   | 3 ++-
 include/hw/ppc/spapr_xive.h | 1 -
 include/hw/scsi/scsi.h      | 1 -
 include/hw/virtio/virtio.h  | 1 -
 include/qemu/typedefs.h     | 1 +
 include/sysemu/sysemu.h     | 1 -
 vl.c                        | 6 +++---
 21 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 7b44cca6d9..6b6cd07362 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -28,6 +28,7 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
+#include "sysemu/sysemu.h"
=20
 static const int user_feature_bits[] =3D {
     VIRTIO_BLK_F_SIZE_MAX,
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 8cc2a232e0..78ac371eba 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -20,6 +20,7 @@
 #include "hw/block/block.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/blockdev.h"
+#include "sysemu/sysemu.h"
 #include "hw/virtio/virtio-blk.h"
 #include "dataplane/virtio-blk.h"
 #include "scsi/constants.h"
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 6de9689a30..28e868c021 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -17,6 +17,7 @@
 #include "ui/console.h"
 #include "trace.h"
 #include "sysemu/dma.h"
+#include "sysemu/sysemu.h"
 #include "hw/virtio/virtio.h"
 #include "migration/qemu-file-types.h"
 #include "hw/virtio/virtio-gpu.h"
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index b59df4e3b8..50f20d8206 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -35,6 +35,7 @@
 #include "hw/char/escc.h"
 #include "hw/misc/macio/macio.h"
 #include "hw/intc/heathrow_pic.h"
+#include "sysemu/sysemu.h"
 #include "trace.h"
=20
 /* Note: this code is strongly inspirated from the corresponding code
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 4113729fcf..9f11422337 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -31,6 +31,7 @@
 #include "hw/virtio/virtio-access.h"
 #include "migration/misc.h"
 #include "standard-headers/linux/ethtool.h"
+#include "sysemu/sysemu.h"
 #include "trace.h"
=20
 #define VIRTIO_NET_VM_VERSION    11
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index 22c6878b84..0c5a5b60bd 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -19,6 +19,7 @@
 #include "hw/s390x/css.h"
 #include "hw/s390x/css-bridge.h"
 #include "hw/s390x/s390-ccw.h"
+#include "sysemu/sysemu.h"
=20
 IOInstEnding s390_ccw_cmd_request(SubchDev *sch)
 {
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index a543b64e56..434d933ec9 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -40,6 +40,7 @@
 #include "hw/nmi.h"
 #include "hw/qdev-properties.h"
 #include "hw/s390x/tod.h"
+#include "sysemu/sysemu.h"
=20
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
 {
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index db785e6001..cb8e8d1f36 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -10,6 +10,7 @@
 #include "scsi/constants.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
+#include "sysemu/sysemu.h"
 #include "trace.h"
 #include "sysemu/dma.h"
 #include "qemu/cutils.h"
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index cd5cf1679d..c693fc748a 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -30,6 +30,7 @@
 #include "hw/fw-path-provider.h"
 #include "hw/qdev-properties.h"
 #include "qemu/cutils.h"
+#include "sysemu/sysemu.h"
=20
 /* Features supported by host kernel. */
 static const int kernel_feature_bits[] =3D {
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index a5be128b54..31c9d34637 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -28,6 +28,7 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-access.h"
 #include "chardev/char-fe.h"
+#include "sysemu/sysemu.h"
=20
 /* Features supported by the host application */
 static const int user_feature_bits[] =3D {
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index d7d1ecd45d..e76c939751 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -35,6 +35,7 @@
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "sysemu/sysemu.h"
=20
 #define FRAME_TIMER_FREQ 1000
 #define FRAME_TIMER_NS   (NANOSECONDS_PER_SECOND / FRAME_TIMER_FREQ)
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index fdbcfdcbeb..0298238f0b 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -21,7 +21,6 @@
 #include "qemu/timer.h"
 #include "hw/usb.h"
 #include "sysemu/dma.h"
-#include "sysemu/sysemu.h"
 #include "hw/pci/pci.h"
 #include "hw/sysbus.h"
=20
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 34b4619fd3..c9c2414b7b 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -17,6 +17,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-rng.h"
 #include "sysemu/rng.h"
+#include "sysemu/sysemu.h"
 #include "qom/object_interfaces.h"
 #include "trace.h"
=20
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 721dcccc96..0ce142bc04 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -26,6 +26,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-access.h"
 #include "sysemu/dma.h"
+#include "sysemu/sysemu.h"
=20
 /*
  * The alignment to use between consumer and producer parts of vring.
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index c6954c1d56..52ec197da0 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -6,11 +6,12 @@
  * only files in hw/ide/ are supposed to include this file.
  * non-internal declarations are in hw/ide.h
  */
+
+#include "qapi/qapi-types-run-state.h"
 #include "hw/ide.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
 #include "sysemu/dma.h"
-#include "sysemu/sysemu.h"
 #include "hw/block/block.h"
 #include "scsi/constants.h"
=20
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index a39e672f27..bfd40f01d8 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -12,7 +12,6 @@
=20
 #include "hw/ppc/spapr_irq.h"
 #include "hw/ppc/xive.h"
-#include "sysemu/sysemu.h"
=20
 #define TYPE_SPAPR_XIVE "spapr-xive"
 #define SPAPR_XIVE(obj) OBJECT_CHECK(SpaprXive, (obj), TYPE_SPAPR_XIVE)
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 2bfaad0fe9..d77a92361b 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -4,7 +4,6 @@
 #include "block/aio.h"
 #include "hw/block/block.h"
 #include "hw/qdev-core.h"
-#include "sysemu/sysemu.h"
 #include "scsi/utils.h"
 #include "qemu/notify.h"
=20
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index df40a46d60..48e8d04ff6 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -17,7 +17,6 @@
 #include "exec/memory.h"
 #include "hw/qdev-core.h"
 #include "net/net.h"
-#include "sysemu/sysemu.h"
 #include "migration/vmstate.h"
 #include "qemu/event_notifier.h"
 #include "standard-headers/linux/virtio_config.h"
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index f569f5f270..3fcdde8bfc 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -102,6 +102,7 @@ typedef struct SHPCDevice SHPCDevice;
 typedef struct SSIBus SSIBus;
 typedef struct VirtIODevice VirtIODevice;
 typedef struct Visitor Visitor;
+typedef struct VMChangeStateEntry VMChangeStateEntry;
 typedef struct VMStateDescription VMStateDescription;
=20
 /*
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 908f158677..7606eaaf2a 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -22,7 +22,6 @@ void runstate_set(RunState new_state);
 int runstate_is_running(void);
 bool runstate_needs_reset(void);
 bool runstate_store(char *str, size_t size);
-typedef struct vm_change_state_entry VMChangeStateEntry;
 typedef void VMChangeStateHandler(void *opaque, int running, RunState st=
ate);
=20
 VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandle=
r *cb,
diff --git a/vl.c b/vl.c
index 08ef28f100..9dbbce4ce3 100644
--- a/vl.c
+++ b/vl.c
@@ -1362,14 +1362,14 @@ static int machine_help_func(QemuOpts *opts, Mach=
ineState *machine)
     return 1;
 }
=20
-struct vm_change_state_entry {
+struct VMChangeStateEntry {
     VMChangeStateHandler *cb;
     void *opaque;
-    QTAILQ_ENTRY(vm_change_state_entry) entries;
+    QTAILQ_ENTRY(VMChangeStateEntry) entries;
     int priority;
 };
=20
-static QTAILQ_HEAD(, vm_change_state_entry) vm_change_state_head;
+static QTAILQ_HEAD(, VMChangeStateEntry) vm_change_state_head;
=20
 /**
  * qemu_add_vm_change_state_handler_prio:
--=20
2.21.0


