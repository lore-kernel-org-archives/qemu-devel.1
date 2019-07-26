Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75E5C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 12:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3D81229F9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 12:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D81229F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqz44-0001jk-RQ
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 08:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59154)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hqyz9-00067q-TN
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hqyyv-0008Kc-Sd
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:06:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56452)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hqyyv-00081T-DQ
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:05:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 61196C049598
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 12:05:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-30.ams2.redhat.com
 [10.36.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A73B55DE6F;
 Fri, 26 Jul 2019 12:05:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5959F114643C; Fri, 26 Jul 2019 14:05:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 14:05:42 +0200
Message-Id: <20190726120542.9894-29-armbru@redhat.com>
In-Reply-To: <20190726120542.9894-1-armbru@redhat.com>
References: <20190726120542.9894-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 26 Jul 2019 12:05:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 28/28] Include sysemu/sysemu.h a lot less
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In my "build everything" tree, changing sysemu/sysemu.h triggers a
recompile of some 5400 out of 6600 objects (not counting tests and
objects that don't depend on qemu/osdep.h).

hw/qdev-core.h includes sysemu/sysemu.h since recent commit e965ffa70a
"qdev: add qdev_add_vm_change_state_handler()".  This is a bad idea:
hw/qdev-core.h is widely included, and sysemu/sysemu.h pulls in some
100 headers.

Collect everything related to vm_state_notify() in new
sysemu/vmstate-notify.h, and drop the problematic include from
hw/qdev-core.h.

Touching sysemu/sysemu.h now recompiles some 1100 objects.
qemu/uuid.h also drops from 5400 to 1100.  A few more headers show
smaller improvement: qemu/notify.h drops from 5600 to 5200,
qemu/timer.h from 5600 to 4400, and qapi/qapi-types-run-state.h from
5500 to 4400.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 accel/kvm/kvm-all.c               |  1 +
 audio/audio.c                     |  2 +-
 backends/hostmem.c                |  1 +
 block/block-backend.c             |  1 +
 cpus.c                            |  2 ++
 gdbstub.c                         |  1 +
 hw/arm/allwinner-a10.c            |  1 +
 hw/arm/aspeed_soc.c               |  1 +
 hw/arm/kzm.c                      |  1 +
 hw/arm/msf2-soc.c                 |  1 +
 hw/arm/stm32f205_soc.c            |  1 +
 hw/block/pflash_cfi01.c           |  2 +-
 hw/block/vhost-user-blk.c         |  2 ++
 hw/block/virtio-blk.c             |  2 ++
 hw/char/serial-isa.c              |  1 +
 hw/char/xen_console.c             |  1 +
 hw/core/numa.c                    |  1 +
 hw/core/vm-change-state-handler.c |  1 +
 hw/display/qxl-render.c           |  1 +
 hw/display/qxl.c                  |  1 +
 hw/display/virtio-gpu.c           |  1 +
 hw/i386/kvm/clock.c               |  1 +
 hw/i386/kvm/i8254.c               |  1 +
 hw/i386/kvmvapic.c                |  1 +
 hw/i386/xen/xen-hvm.c             |  2 ++
 hw/i386/xen/xen-mapcache.c        |  1 +
 hw/ide/core.c                     |  2 +-
 hw/ide/qdev.c                     |  1 +
 hw/intc/ioapic.c                  |  1 +
 hw/misc/macio/macio.c             |  1 +
 hw/net/e1000e_core.c              |  2 +-
 hw/net/virtio-net.c               |  1 +
 hw/nvram/spapr_nvram.c            |  1 +
 hw/pci/pci.c                      |  1 +
 hw/ppc/ppc_booke.c                |  1 +
 hw/ppc/spapr.c                    |  1 +
 hw/riscv/sifive_e.c               |  1 +
 hw/riscv/sifive_u.c               |  1 +
 hw/riscv/spike.c                  |  1 +
 hw/riscv/virt.c                   |  1 +
 hw/s390x/s390-ccw.c               |  1 +
 hw/s390x/s390-virtio-ccw.c        |  1 +
 hw/scsi/scsi-bus.c                |  2 ++
 hw/scsi/vhost-scsi.c              |  1 +
 hw/scsi/vhost-user-scsi.c         |  1 +
 hw/sparc64/niagara.c              |  2 +-
 hw/usb/hcd-ehci.c                 |  1 +
 hw/usb/host-libusb.c              |  1 +
 hw/usb/redirect.c                 |  1 +
 hw/virtio/virtio-rng.c            |  2 ++
 hw/virtio/virtio.c                |  2 ++
 hw/xen/xen-common.c               |  1 +
 hw/xen/xen_devconfig.c            |  1 +
 hw/xenpv/xen_machine_pv.c         |  1 +
 include/hw/qdev-core.h            |  5 -----
 include/sysemu/sysemu.h           |  8 --------
 include/sysemu/vmstate-notify.h   | 18 ++++++++++++++++++
 memory.c                          |  1 +
 migration/global_state.c          |  1 +
 migration/migration.c             |  1 +
 migration/savevm.c                |  1 +
 net/net.c                         |  2 ++
 stubs/change-state-handler.c      |  2 +-
 target/i386/kvm.c                 |  1 +
 target/i386/sev.c                 |  1 +
 ui/gtk.c                          |  1 +
 ui/spice-core.c                   |  2 +-
 vl.c                              |  1 +
 68 files changed, 91 insertions(+), 20 deletions(-)
 create mode 100644 include/sysemu/vmstate-notify.h

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index db4d215e0c..423a215266 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -29,6 +29,7 @@
 #include "exec/gdbstub.h"
 #include "sysemu/kvm_int.h"
 #include "sysemu/cpus.h"
+#include "sysemu/sysemu.h"
 #include "qemu/bswap.h"
 #include "exec/memory.h"
 #include "exec/ram_addr.h"
diff --git a/audio/audio.c b/audio/audio.c
index b9b2d07e54..e8b752dafe 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -30,10 +30,10 @@
 #include "qapi/error.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-audio.h"
-#include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
 #include "qemu/module.h"
 #include "sysemu/replay.h"
+#include "sysemu/vmstate-notify.h"
 #include "trace.h"
=20
 #define AUDIO_CAP "audio"
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 463102aa15..6d333dc23c 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -12,6 +12,7 @@
=20
 #include "qemu/osdep.h"
 #include "sysemu/hostmem.h"
+#include "sysemu/sysemu.h"
 #include "hw/boards.h"
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-visit.h"
diff --git a/block/block-backend.c b/block/block-backend.c
index 4991ab5574..e4f43a0293 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -17,6 +17,7 @@
 #include "block/throttle-groups.h"
 #include "hw/qdev-core.h"
 #include "sysemu/blockdev.h"
+#include "sysemu/vmstate-notify.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-block.h"
diff --git a/cpus.c b/cpus.c
index e70cc58e31..cd98d1c166 100644
--- a/cpus.c
+++ b/cpus.c
@@ -41,6 +41,8 @@
 #include "sysemu/kvm.h"
 #include "sysemu/hax.h"
 #include "sysemu/hvf.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/vmstate-notify.h"
 #include "sysemu/whpx.h"
 #include "exec/exec-all.h"
=20
diff --git a/gdbstub.c b/gdbstub.c
index b470aec8ea..66d80a1b22 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -38,6 +38,7 @@
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/vmstate-notify.h"
 #include "exec/gdbstub.h"
 #include "hw/cpu/cluster.h"
 #include "hw/boards.h"
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 3b0d3eccdd..73810a4440 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -23,6 +23,7 @@
 #include "hw/sysbus.h"
 #include "hw/arm/allwinner-a10.h"
 #include "hw/misc/unimp.h"
+#include "sysemu/sysemu.h"
=20
 static void aw_a10_init(Object *obj)
 {
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index c6fb3700f2..9ee8104832 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -22,6 +22,7 @@
 #include "qemu/error-report.h"
 #include "hw/i2c/aspeed_i2c.h"
 #include "net/net.h"
+#include "sysemu/sysemu.h"
=20
 #define ASPEED_SOC_IOMEM_SIZE       0x00200000
=20
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 59d2102dc5..2f052e1f8c 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -24,6 +24,7 @@
 #include "hw/net/lan9118.h"
 #include "hw/char/serial.h"
 #include "sysemu/qtest.h"
+#include "sysemu/sysemu.h"
=20
 /* Memory map for Kzm Emulation Baseboard:
  * 0x00000000-0x7fffffff See i.MX31 SOC for support
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 8ae763f99f..76cc3e09b0 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -30,6 +30,7 @@
 #include "hw/irq.h"
 #include "hw/arm/msf2-soc.h"
 #include "hw/misc/unimp.h"
+#include "sysemu/sysemu.h"
=20
 #define MSF2_TIMER_BASE       0x40004000
 #define MSF2_SYSREG_BASE      0x40038000
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index be8b7df679..f5a5c2d80c 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -29,6 +29,7 @@
 #include "exec/address-spaces.h"
 #include "hw/arm/stm32f205_soc.h"
 #include "hw/qdev-properties.h"
+#include "sysemu/sysemu.h"
=20
 /* At the moment only Timer 2 to 5 are modelled */
 static const uint32_t timer_addr[STM_NUM_TIMERS] =3D { 0x40000000, 0x400=
00400,
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index a406e75242..6da00c5bfc 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -52,7 +52,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "sysemu/blockdev.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/vmstate-notify.h"
 #include "trace.h"
=20
 /* #define PFLASH_DEBUG */
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 7b44cca6d9..ce64b05abd 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -28,6 +28,8 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/vmstate-notify.h"
=20
 static const int user_feature_bits[] =3D {
     VIRTIO_BLK_F_SIZE_MAX,
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 8cc2a232e0..8fe7540675 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -20,6 +20,8 @@
 #include "hw/block/block.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/blockdev.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/vmstate-notify.h"
 #include "hw/virtio/virtio-blk.h"
 #include "dataplane/virtio-blk.h"
 #include "scsi/constants.h"
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index 5a0ae02ee7..9e31c51bb6 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "sysemu/sysemu.h"
 #include "hw/char/serial.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index 8cc9328b3f..63153dfde4 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -24,6 +24,7 @@
 #include <termios.h>
=20
 #include "qapi/error.h"
+#include "sysemu/sysemu.h"
 #include "chardev/char-fe.h"
 #include "hw/xen/xen-legacy-backend.h"
=20
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 450c522dd8..7a63ddc4c6 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/hostmem.h"
 #include "sysemu/numa.h"
+#include "sysemu/sysemu.h"
 #include "exec/cpu-common.h"
 #include "exec/ramlist.h"
 #include "qemu/bitmap.h"
diff --git a/hw/core/vm-change-state-handler.c b/hw/core/vm-change-state-=
handler.c
index e27ea45977..e184ec5e0e 100644
--- a/hw/core/vm-change-state-handler.c
+++ b/hw/core/vm-change-state-handler.c
@@ -17,6 +17,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/qdev-core.h"
+#include "sysemu/vmstate-notify.h"
=20
 static int qdev_get_dev_tree_depth(DeviceState *dev)
 {
diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index 14ad2b352d..473e333475 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -21,6 +21,7 @@
=20
 #include "qemu/osdep.h"
 #include "qxl.h"
+#include "sysemu/sysemu.h"
 #include "trace.h"
=20
 static void qxl_blit(PCIQXLDevice *qxl, QXLRect *rect)
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 971c2d0568..3a1d2bb6a7 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -30,6 +30,7 @@
 #include "qemu/module.h"
 #include "sysemu/sysemu.h"
 #include "hw/qdev-properties.h"
+#include "sysemu/vmstate-notify.h"
 #include "migration/blocker.h"
 #include "migration/vmstate.h"
 #include "trace.h"
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
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index d6a5325f0b..f6dd14f0ee 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -20,6 +20,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "sysemu/hw_accel.h"
+#include "sysemu/vmstate-notify.h"
 #include "kvm_i386.h"
 #include "migration/vmstate.h"
 #include "hw/sysbus.h"
diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index 27e36a2abf..456bdb4966 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -30,6 +30,7 @@
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/vmstate-notify.h"
 #include "hw/timer/i8254.h"
 #include "hw/timer/i8254_internal.h"
 #include "sysemu/kvm.h"
diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
index 44e40478c8..5602aa41c4 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/kvmvapic.c
@@ -16,6 +16,7 @@
 #include "sysemu/cpus.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
+#include "sysemu/vmstate-notify.h"
 #include "hw/i386/apic_internal.h"
 #include "hw/sysbus.h"
 #include "hw/boards.h"
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 3e15ffc828..b25da4cf9d 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -25,6 +25,8 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/range.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/vmstate-notify.h"
 #include "sysemu/xen-mapcache.h"
 #include "trace.h"
 #include "exec/address-spaces.h"
diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
index dc73c86c61..09656f9f11 100644
--- a/hw/i386/xen/xen-mapcache.c
+++ b/hw/i386/xen/xen-mapcache.c
@@ -17,6 +17,7 @@
 #include "hw/xen/xen-legacy-backend.h"
 #include "qemu/bitmap.h"
=20
+#include "sysemu/sysemu.h"
 #include "sysemu/xen-mapcache.h"
 #include "trace.h"
=20
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 61cb3b26ab..b12118d268 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -37,7 +37,7 @@
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "sysemu/replay.h"
-
+#include "sysemu/vmstate-notify.h"
 #include "hw/ide/internal.h"
 #include "trace.h"
=20
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 39957dd39f..d08a7c5de0 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -30,6 +30,7 @@
 #include "sysemu/blockdev.h"
 #include "hw/block/block.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/vmstate-notify.h"
 #include "qapi/visitor.h"
=20
 /* --------------------------------- */
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index f89677174a..8f2165801a 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -30,6 +30,7 @@
 #include "hw/pci/msi.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/kvm.h"
+#include "sysemu/sysemu.h"
 #include "hw/i386/apic-msidef.h"
 #include "hw/i386/x86-iommu.h"
 #include "trace.h"
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
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 40e41fdd92..cb3f2e4c59 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -34,12 +34,12 @@
 */
=20
 #include "qemu/osdep.h"
-#include "sysemu/sysemu.h"
 #include "net/net.h"
 #include "net/tap.h"
 #include "hw/hw.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
+#include "sysemu/vmstate-notify.h"
=20
 #include "net_tx_pkt.h"
 #include "net_rx_pkt.h"
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
diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index c7bcd29e15..fe685a42b3 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -31,6 +31,7 @@
=20
 #include "sysemu/block-backend.h"
 #include "sysemu/device_tree.h"
+#include "sysemu/vmstate-notify.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/nvram/chrp_nvram.h"
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 4b6ffab13d..aa05c2b9b2 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -35,6 +35,7 @@
 #include "monitor/monitor.h"
 #include "net/net.h"
 #include "sysemu/numa.h"
+#include "sysemu/sysemu.h"
 #include "hw/loader.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
index ce0e1406e1..344267019c 100644
--- a/hw/ppc/ppc_booke.c
+++ b/hw/ppc/ppc_booke.c
@@ -28,6 +28,7 @@
 #include "qemu/timer.h"
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/vmstate-notify.h"
 #include "qemu/log.h"
 #include "hw/loader.h"
 #include "kvm_ppc.h"
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4044e61a0c..f32bdcbb65 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -33,6 +33,7 @@
 #include "sysemu/numa.h"
 #include "sysemu/qtest.h"
 #include "sysemu/reset.h"
+#include "sysemu/vmstate-notify.h"
 #include "qemu/log.h"
 #include "hw/fw-path-provider.h"
 #include "elf.h"
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 862903d6b5..792d75a1a3 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -46,6 +46,7 @@
 #include "hw/riscv/boot.h"
 #include "chardev/char.h"
 #include "sysemu/arch_init.h"
+#include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
=20
 static const struct MemmapEntry {
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 0b3c5dff97..9910fa6708 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -44,6 +44,7 @@
 #include "chardev/char.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/device_tree.h"
+#include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
=20
 #include <libfdt.h>
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 9cc786b6b6..7c04bd554f 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -40,6 +40,7 @@
 #include "sysemu/arch_init.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/qtest.h"
+#include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
=20
 #include <libfdt.h>
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index c72198b720..9bced28486 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -37,6 +37,7 @@
 #include "chardev/char.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/device_tree.h"
+#include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
 #include "hw/pci/pci.h"
 #include "hw/pci-host/gpex.h"
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
index db785e6001..034f2ba9ba 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -10,6 +10,8 @@
 #include "scsi/constants.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/vmstate-notify.h"
 #include "trace.h"
 #include "sysemu/dma.h"
 #include "qemu/cutils.h"
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index fc25fb87a2..eaf6866490 100644
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
index 0bb8e0dfdd..8f18c1475a 100644
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
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 1efcff628a..167143bffe 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -35,7 +35,7 @@
 #include "sysemu/block-backend.h"
 #include "qemu/error-report.h"
 #include "sysemu/qtest.h"
-
+#include "sysemu/sysemu.h"
=20
 typedef struct NiagaraBoardState {
     MemoryRegion hv_ram;
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index d7d1ecd45d..75c0de9120 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -35,6 +35,7 @@
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "sysemu/vmstate-notify.h"
=20
 #define FRAME_TIMER_FREQ 1000
 #define FRAME_TIMER_NS   (NANOSECONDS_PER_SECOND / FRAME_TIMER_FREQ)
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 80fd1e9a80..ca12d308ca 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -46,6 +46,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/vmstate-notify.h"
 #include "trace.h"
=20
 #include "hw/qdev-properties.h"
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 8db2c68a1e..ecaf53d19e 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -31,6 +31,7 @@
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/vmstate-notify.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/iov.h"
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 34b4619fd3..b4bb28d8ba 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -17,6 +17,8 @@
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-rng.h"
 #include "sysemu/rng.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/vmstate-notify.h"
 #include "qom/object_interfaces.h"
 #include "trace.h"
=20
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 721dcccc96..fb7a184d2e 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -26,6 +26,8 @@
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-access.h"
 #include "sysemu/dma.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/vmstate-notify.h"
=20
 /*
  * The alignment to use between consumer and producer parts of vring.
diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index 32503cfc1c..9d407ed2da 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -14,6 +14,7 @@
 #include "hw/xen/xen-legacy-backend.h"
 #include "chardev/char.h"
 #include "sysemu/accel.h"
+#include "sysemu/vmstate-notify.h"
 #include "migration/misc.h"
 #include "migration/global_state.h"
=20
diff --git a/hw/xen/xen_devconfig.c b/hw/xen/xen_devconfig.c
index 315dbc9c51..46ee4a7f02 100644
--- a/hw/xen/xen_devconfig.c
+++ b/hw/xen/xen_devconfig.c
@@ -2,6 +2,7 @@
 #include "hw/xen/xen-legacy-backend.h"
 #include "qemu/option.h"
 #include "sysemu/blockdev.h"
+#include "sysemu/sysemu.h"
=20
 /* ------------------------------------------------------------- */
=20
diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index 524d608eab..3a8af1a1e0 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -28,6 +28,7 @@
 #include "hw/xen/xen-legacy-backend.h"
 #include "hw/xen/xen-bus.h"
 #include "sysemu/block-backend.h"
+#include "sysemu/sysemu.h"
=20
 static void xen_init_pv(MachineState *machine)
 {
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 80fdb38d94..7f6a6ed2d9 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -5,7 +5,6 @@
 #include "qemu/bitmap.h"
 #include "qom/object.h"
 #include "hw/hotplug.h"
-#include "sysemu/sysemu.h"
=20
 enum {
     DEV_NVECTORS_UNSPECIFIED =3D -1,
@@ -448,8 +447,4 @@ static inline bool qbus_is_hotpluggable(BusState *bus=
)
 void device_listener_register(DeviceListener *listener);
 void device_listener_unregister(DeviceListener *listener);
=20
-VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
-                                                     VMChangeStateHandle=
r *cb,
-                                                     void *opaque);
-
 #endif
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 7e445e0683..ceeef1ff8a 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -22,14 +22,6 @@ void runstate_set(RunState new_state);
 int runstate_is_running(void);
 bool runstate_needs_reset(void);
 bool runstate_store(char *str, size_t size);
-typedef void VMChangeStateHandler(void *opaque, int running, RunState st=
ate);
-
-VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandle=
r *cb,
-                                                     void *opaque);
-VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
-        VMChangeStateHandler *cb, void *opaque, int priority);
-void qemu_del_vm_change_state_handler(VMChangeStateEntry *e);
-void vm_state_notify(int running, RunState state);
=20
 static inline bool shutdown_caused_by_guest(ShutdownCause cause)
 {
diff --git a/include/sysemu/vmstate-notify.h b/include/sysemu/vmstate-not=
ify.h
new file mode 100644
index 0000000000..09f9d4194b
--- /dev/null
+++ b/include/sysemu/vmstate-notify.h
@@ -0,0 +1,18 @@
+#ifndef SYSEMU_VMSTATE_NOTIFY_H
+#define SYSEMU_VMSTATE_NOTIFY_H
+
+#include "qapi/qapi-types-run-state.h"
+
+typedef void VMChangeStateHandler(void *opaque, int running, RunState st=
ate);
+
+VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandle=
r *cb,
+                                                     void *opaque);
+VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
+        VMChangeStateHandler *cb, void *opaque, int priority);
+VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
+                                                     VMChangeStateHandle=
r *cb,
+                                                     void *opaque);
+void qemu_del_vm_change_state_handler(VMChangeStateEntry *e);
+void vm_state_notify(int running, RunState state);
+
+#endif
diff --git a/memory.c b/memory.c
index e5683eed91..8b4e42c54d 100644
--- a/memory.c
+++ b/memory.c
@@ -30,6 +30,7 @@
 #include "exec/ram_addr.h"
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/vmstate-notify.h"
 #include "sysemu/tcg.h"
 #include "migration/vmstate.h"
=20
diff --git a/migration/global_state.c b/migration/global_state.c
index 2c8c447239..7cba868979 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
+#include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "migration.h"
 #include "migration/global_state.h"
diff --git a/migration/migration.c b/migration/migration.c
index 3a6340f602..2986b8b164 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -21,6 +21,7 @@
 #include "exec.h"
 #include "fd.h"
 #include "socket.h"
+#include "sysemu/sysemu.h"
 #include "rdma.h"
 #include "ram.h"
 #include "migration/global_state.h"
diff --git a/migration/savevm.c b/migration/savevm.c
index b8f734537a..33da39f0ea 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -57,6 +57,7 @@
 #include "io/channel-buffer.h"
 #include "io/channel-file.h"
 #include "sysemu/replay.h"
+#include "sysemu/sysemu.h"
 #include "qjson.h"
 #include "migration/colo.h"
 #include "qemu/bitmap.h"
diff --git a/net/net.c b/net/net.c
index 11b505a6fd..44bdf4d079 100644
--- a/net/net.c
+++ b/net/net.c
@@ -50,6 +50,8 @@
 #include "qapi/opts-visitor.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/vmstate-notify.h"
 #include "net/filter.h"
 #include "qapi/string-output-visitor.h"
=20
diff --git a/stubs/change-state-handler.c b/stubs/change-state-handler.c
index d14194b36b..655ffefe01 100644
--- a/stubs/change-state-handler.c
+++ b/stubs/change-state-handler.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/vmstate-notify.h"
=20
 VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandle=
r *cb,
                                                      void *opaque)
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index e568ff6671..e23a050949 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -25,6 +25,7 @@
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm_int.h"
 #include "sysemu/reset.h"
+#include "sysemu/vmstate-notify.h"
 #include "kvm_i386.h"
 #include "hyperv.h"
 #include "hyperv-proto.h"
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 5ba1384ea1..3c4d824e16 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -25,6 +25,7 @@
 #include "sysemu/kvm.h"
 #include "sev_i386.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/vmstate-notify.h"
 #include "trace.h"
 #include "migration/blocker.h"
=20
diff --git a/ui/gtk.c b/ui/gtk.c
index ad6963d4f5..73d0dd147e 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -48,6 +48,7 @@
 #include "trace.h"
 #include "ui/input.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/vmstate-notify.h"
 #include "keymaps.h"
 #include "chardev/char.h"
 #include "qom/object.h"
diff --git a/ui/spice-core.c b/ui/spice-core.c
index a395d7ccd4..83d18b4150 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -19,7 +19,7 @@
 #include <spice.h>
=20
 #include "sysemu/sysemu.h"
-
+#include "sysemu/vmstate-notify.h"
 #include "ui/qemu-spice.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
diff --git a/vl.c b/vl.c
index 91255acf71..a70f6221aa 100644
--- a/vl.c
+++ b/vl.c
@@ -76,6 +76,7 @@ int main(int argc, char **argv)
 #include "ui/input.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/numa.h"
+#include "sysemu/vmstate-notify.h"
 #include "exec/gdbstub.h"
 #include "qemu/timer.h"
 #include "chardev/char.h"
--=20
2.21.0


