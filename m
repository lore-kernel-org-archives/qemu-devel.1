Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F785C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 07:02:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A0B3206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 07:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0B3206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvyul-0002XQ-81
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 03:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48390)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hvygC-0000vL-Qx
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hvyg4-0001mg-LP
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51810)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hvyg3-0001k9-8t
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7F1755945D
 for <qemu-devel@nongnu.org>; Fri,  9 Aug 2019 06:47:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C046719C70
 for <qemu-devel@nongnu.org>; Fri,  9 Aug 2019 06:47:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BA171113642C; Fri,  9 Aug 2019 08:46:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 08:46:36 +0200
Message-Id: <20190809064645.22656-21-armbru@redhat.com>
In-Reply-To: <20190809064645.22656-1-armbru@redhat.com>
References: <20190809064645.22656-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 09 Aug 2019 06:47:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 20/29] Include qemu/main-loop.h less
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

In my "build everything" tree, changing qemu/main-loop.h triggers a
recompile of some 5600 out of 6600 objects (not counting tests and
objects that don't depend on qemu/osdep.h).  It includes block/aio.h,
which in turn includes qemu/event_notifier.h, qemu/notify.h,
qemu/processor.h, qemu/qsp.h, qemu/queue.h, qemu/thread-posix.h,
qemu/thread.h, qemu/timer.h, and a few more.

Include qemu/main-loop.h only where it's needed.  Touching it now
recompiles only some 1700 objects.  For block/aio.h and
qemu/event_notifier.h, these numbers drop from 5600 to 2800.  For the
others, they shrink only slightly.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 accel/kvm/kvm-all.c             | 1 +
 block.c                         | 1 +
 block/block-backend.c           | 1 +
 block/create.c                  | 1 +
 block/io.c                      | 1 +
 block/nbd.c                     | 1 +
 block/nfs.c                     | 1 +
 block/nvme.c                    | 1 +
 block/qcow2.c                   | 1 +
 block/qed.c                     | 1 +
 block/sheepdog.c                | 1 +
 block/throttle-groups.c         | 1 +
 blockdev.c                      | 1 +
 blockjob.c                      | 1 +
 chardev/baum.c                  | 1 +
 chardev/char-pipe.c             | 1 +
 chardev/char-win-stdio.c        | 1 +
 chardev/char-win.c              | 1 +
 dump/dump.c                     | 1 +
 fsdev/qemu-fsdev-throttle.c     | 1 +
 fsdev/qemu-fsdev-throttle.h     | 1 -
 hw/9pfs/9p.c                    | 1 +
 hw/9pfs/codir.c                 | 1 +
 hw/9pfs/cofile.c                | 1 +
 hw/9pfs/cofs.c                  | 1 +
 hw/9pfs/coth.c                  | 1 +
 hw/9pfs/coth.h                  | 1 -
 hw/9pfs/coxattr.c               | 1 +
 hw/9pfs/xen-9p-backend.c        | 1 +
 hw/arm/omap1.c                  | 1 +
 hw/block/dataplane/virtio-blk.c | 1 +
 hw/block/dataplane/xen-block.c  | 1 +
 hw/block/fdc.c                  | 1 +
 hw/block/xen-block.c            | 1 +
 hw/char/virtio-serial-bus.c     | 1 +
 hw/core/machine-qmp-cmds.c      | 1 +
 hw/display/qxl.c                | 1 +
 hw/dma/etraxfs_dma.c            | 1 +
 hw/i386/intel_iommu.c           | 1 +
 hw/i386/xen/xen-hvm.c           | 1 +
 hw/ide/ahci.c                   | 1 +
 hw/ide/core.c                   | 1 +
 hw/ide/qdev.c                   | 1 +
 hw/intc/s390_flic.c             | 1 +
 hw/m68k/mcf5206.c               | 1 +
 hw/m68k/mcf5208.c               | 1 +
 hw/misc/imx6_src.c              | 1 +
 hw/net/fsl_etsec/etsec.c        | 1 +
 hw/net/lan9118.c                | 1 +
 hw/net/vhost_net.c              | 2 +-
 hw/net/virtio-net.c             | 1 +
 hw/ppc/ppc.c                    | 1 +
 hw/ppc/ppc440_uc.c              | 1 +
 hw/ppc/spapr_hcall.c            | 1 +
 hw/ppc/spapr_rng.c              | 1 +
 hw/scsi/mptsas.c                | 1 +
 hw/scsi/scsi-disk.c             | 1 +
 hw/scsi/vmw_pvscsi.c            | 1 +
 hw/timer/allwinner-a10-pit.c    | 1 +
 hw/timer/altera_timer.c         | 1 +
 hw/timer/etraxfs_timer.c        | 1 +
 hw/timer/exynos4210_rtc.c       | 1 +
 hw/timer/milkymist-sysctl.c     | 1 +
 hw/usb/dev-uas.c                | 1 +
 hw/usb/hcd-ehci.c               | 1 +
 hw/usb/host-libusb.c            | 1 +
 hw/usb/xen-usb.c                | 1 +
 hw/vfio/ccw.c                   | 1 +
 hw/vfio/common.c                | 1 +
 hw/vfio/pci.c                   | 1 +
 hw/vfio/platform.c              | 1 +
 hw/virtio/vhost-backend.c       | 1 +
 hw/virtio/vhost-user.c          | 1 +
 hw/virtio/virtio-crypto.c       | 1 +
 hw/virtio/virtio-pmem.c         | 1 +
 hw/virtio/virtio.c              | 1 +
 hw/xen/xen-legacy-backend.c     | 1 +
 hw/xen/xen_pvdev.c              | 1 +
 include/block/block_int.h       | 1 -
 include/chardev/char-fe.h       | 1 +
 include/chardev/char-io.h       | 1 +
 include/chardev/char.h          | 2 +-
 include/hw/scsi/scsi.h          | 1 +
 include/sysemu/sysemu.h         | 1 -
 memory.c                        | 1 +
 migration/block.c               | 1 +
 migration/colo.c                | 1 +
 migration/migration.c           | 1 +
 migration/savevm.c              | 1 +
 nbd/nbd-internal.h              | 1 -
 net/can/can_socketcan.c         | 1 +
 net/tap-win32.c                 | 1 +
 net/tap.c                       | 1 +
 qemu-img.c                      | 1 +
 qom/cpu.c                       | 1 +
 replay/replay-internal.c        | 1 +
 target/arm/helper-a64.c         | 1 +
 target/arm/helper.c             | 2 ++
 target/arm/kvm.c                | 1 +
 target/arm/kvm64.c              | 1 +
 target/arm/m_helper.c           | 2 ++
 target/arm/psci.c               | 2 ++
 target/i386/kvm.c               | 1 +
 target/lm32/op_helper.c         | 1 +
 target/mips/kvm.c               | 1 +
 target/ppc/int_helper.c         | 2 ++
 target/ppc/kvm.c                | 1 +
 target/ppc/machine.c            | 1 +
 target/ppc/mem_helper.c         | 2 ++
 target/ppc/misc_helper.c        | 2 ++
 target/ppc/mmu_helper.c         | 2 ++
 target/ppc/translate.c          | 1 +
 target/s390x/kvm.c              | 1 +
 tcg/tcg-op-gvec.c               | 1 +
 tests/test-bdrv-drain.c         | 1 +
 tests/test-bdrv-graph-mod.c     | 1 +
 tests/test-block-backend.c      | 1 +
 tests/test-block-iothread.c     | 1 +
 tests/test-image-locking.c      | 1 +
 tests/test-replication.c        | 1 +
 tests/test-throttle.c           | 1 +
 ui/cocoa.m                      | 1 +
 ui/input-linux.c                | 1 +
 ui/spice-core.c                 | 1 +
 ui/spice-display.c              | 1 +
 ui/vnc-auth-sasl.h              | 1 -
 ui/vnc.c                        | 1 +
 util/oslib-posix.c              | 1 +
 128 files changed, 129 insertions(+), 8 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d20da99c21..e1a44eccf5 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -34,6 +34,7 @@
 #include "exec/ram_addr.h"
 #include "exec/address-spaces.h"
 #include "qemu/event_notifier.h"
+#include "qemu/main-loop.h"
 #include "trace.h"
 #include "hw/irq.h"
 #include "sysemu/sev.h"
diff --git a/block.c b/block.c
index cbd8da5f3b..1b67b4960f 100644
--- a/block.c
+++ b/block.c
@@ -30,6 +30,7 @@
 #include "block/qdict.h"
 #include "qemu/error-report.h"
 #include "module_block.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
diff --git a/block/block-backend.c b/block/block-backend.c
index 6aed80bf0b..4991ab5574 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -21,6 +21,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-events-block.h"
 #include "qemu/id.h"
+#include "qemu/main-loop.h"
 #include "qemu/option.h"
 #include "trace.h"
 #include "migration/misc.h"
diff --git a/block/create.c b/block/create.c
index 95341219ef..1bd00ed5f8 100644
--- a/block/create.c
+++ b/block/create.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "block/block_int.h"
 #include "qemu/job.h"
+#include "qemu/main-loop.h"
 #include "qapi/qapi-commands-block-core.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "qapi/clone-visitor.h"
diff --git a/block/io.c b/block/io.c
index 06305c6ea6..17a243cde9 100644
--- a/block/io.c
+++ b/block/io.c
@@ -32,6 +32,7 @@
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
=20
 #define NOT_DONE 0x7fffffff /* used while emulated sync operation in pro=
gress */
=20
diff --git a/block/nbd.c b/block/nbd.c
index 57c1a20581..56b1c6ec74 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -33,6 +33,7 @@
 #include "qemu/uri.h"
 #include "qemu/option.h"
 #include "qemu/cutils.h"
+#include "qemu/main-loop.h"
=20
 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/qmp/qstring.h"
diff --git a/block/nfs.c b/block/nfs.c
index d93241b3bb..a1fe004c61 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -32,6 +32,7 @@
 #include "block/qdict.h"
 #include "trace.h"
 #include "qemu/iov.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/uri.h"
diff --git a/block/nvme.c b/block/nvme.c
index 2c85713519..5be3a39b63 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -17,6 +17,7 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/cutils.h"
 #include "qemu/option.h"
diff --git a/block/qcow2.c b/block/qcow2.c
index 039bdc2f7e..59cff1d4cb 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -26,6 +26,7 @@
=20
 #include "block/qdict.h"
 #include "sysemu/block-backend.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qcow2.h"
 #include "qemu/error-report.h"
diff --git a/block/qed.c b/block/qed.c
index 77c7cef175..d0dcc5f14d 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -17,6 +17,7 @@
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "qemu/bswap.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "trace.h"
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 6f402e5d4d..31b0a820c2 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -22,6 +22,7 @@
 #include "qapi/qobject-output-visitor.h"
 #include "qemu/uri.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/sockets.h"
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index a5a2037924..77014c741b 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -26,6 +26,7 @@
 #include "sysemu/block-backend.h"
 #include "block/throttle-groups.h"
 #include "qemu/throttle-options.h"
+#include "qemu/main-loop.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
 #include "sysemu/qtest.h"
diff --git a/blockdev.c b/blockdev.c
index 4d141e9a1f..64eab33ae9 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -60,6 +60,7 @@
 #include "sysemu/qtest.h"
 #include "qemu/cutils.h"
 #include "qemu/help_option.h"
+#include "qemu/main-loop.h"
 #include "qemu/throttle-options.h"
=20
 static QTAILQ_HEAD(, BlockDriverState) monitor_bdrv_states =3D
diff --git a/blockjob.c b/blockjob.c
index 20b7f557da..45877c8bdd 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -33,6 +33,7 @@
 #include "qapi/qapi-events-block-core.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/coroutine.h"
+#include "qemu/main-loop.h"
 #include "qemu/timer.h"
=20
 /*
diff --git a/chardev/baum.c b/chardev/baum.c
index 3dc81d5c6c..9c95e7bc79 100644
--- a/chardev/baum.c
+++ b/chardev/baum.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "chardev/char.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/usb.h"
diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
index b200f9365c..94d714ffcd 100644
--- a/chardev/char-pipe.c
+++ b/chardev/char-pipe.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/error.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "chardev/char.h"
diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
index 92d34e85aa..99afda353c 100644
--- a/chardev/char-win-stdio.c
+++ b/chardev/char-win-stdio.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "chardev/char-win.h"
 #include "chardev/char-win-stdio.h"
diff --git a/chardev/char-win.c b/chardev/char-win.c
index 0b8181339d..34825f683d 100644
--- a/chardev/char-win.c
+++ b/chardev/char-win.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "chardev/char-win.h"
diff --git a/dump/dump.c b/dump/dump.c
index c7b2301652..d430f5e929 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -28,6 +28,7 @@
 #include "qapi/qapi-events-dump.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "hw/misc/vmcoreinfo.h"
=20
 #ifdef TARGET_X86_64
diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
index cfd86418ac..fe1d76dc76 100644
--- a/fsdev/qemu-fsdev-throttle.c
+++ b/fsdev/qemu-fsdev-throttle.c
@@ -16,6 +16,7 @@
 #include "qemu/error-report.h"
 #include "qemu-fsdev-throttle.h"
 #include "qemu/iov.h"
+#include "qemu/main-loop.h"
 #include "qemu/option.h"
=20
 static void fsdev_throttle_read_timer_cb(void *opaque)
diff --git a/fsdev/qemu-fsdev-throttle.h b/fsdev/qemu-fsdev-throttle.h
index 7d6211d499..c98e2feab5 100644
--- a/fsdev/qemu-fsdev-throttle.h
+++ b/fsdev/qemu-fsdev-throttle.h
@@ -16,7 +16,6 @@
 #define QEMU_FSDEV_THROTTLE_H
=20
 #include "block/aio.h"
-#include "qemu/main-loop.h"
 #include "qemu/coroutine.h"
 #include "qemu/throttle.h"
=20
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 55821343e5..cce2366219 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -17,6 +17,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/iov.h"
+#include "qemu/main-loop.h"
 #include "qemu/sockets.h"
 #include "virtio-9p.h"
 #include "fsdev/qemu-fsdev.h"
diff --git a/hw/9pfs/codir.c b/hw/9pfs/codir.c
index 7cd6fce1ad..73f9a751e1 100644
--- a/hw/9pfs/codir.c
+++ b/hw/9pfs/codir.c
@@ -15,6 +15,7 @@
 #include "fsdev/qemu-fsdev.h"
 #include "qemu/thread.h"
 #include "qemu/coroutine.h"
+#include "qemu/main-loop.h"
 #include "coth.h"
=20
 int coroutine_fn v9fs_co_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
diff --git a/hw/9pfs/cofile.c b/hw/9pfs/cofile.c
index 9c22837cda..83bb6c14e0 100644
--- a/hw/9pfs/cofile.c
+++ b/hw/9pfs/cofile.c
@@ -15,6 +15,7 @@
 #include "fsdev/qemu-fsdev.h"
 #include "qemu/thread.h"
 #include "qemu/coroutine.h"
+#include "qemu/main-loop.h"
 #include "coth.h"
=20
 int coroutine_fn v9fs_co_st_gen(V9fsPDU *pdu, V9fsPath *path, mode_t st_=
mode,
diff --git a/hw/9pfs/cofs.c b/hw/9pfs/cofs.c
index c62103221d..55991916ec 100644
--- a/hw/9pfs/cofs.c
+++ b/hw/9pfs/cofs.c
@@ -15,6 +15,7 @@
 #include "fsdev/qemu-fsdev.h"
 #include "qemu/thread.h"
 #include "qemu/coroutine.h"
+#include "qemu/main-loop.h"
 #include "coth.h"
=20
 static ssize_t __readlink(V9fsState *s, V9fsPath *path, V9fsString *buf)
diff --git a/hw/9pfs/coth.c b/hw/9pfs/coth.c
index c3b43368f8..9778f24b00 100644
--- a/hw/9pfs/coth.c
+++ b/hw/9pfs/coth.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "block/thread-pool.h"
 #include "qemu/coroutine.h"
+#include "qemu/main-loop.h"
 #include "coth.h"
=20
 /* Called from QEMU I/O thread.  */
diff --git a/hw/9pfs/coth.h b/hw/9pfs/coth.h
index 19e4d9287e..c2cdc7a9ea 100644
--- a/hw/9pfs/coth.h
+++ b/hw/9pfs/coth.h
@@ -17,7 +17,6 @@
=20
 #include "qemu/thread.h"
 #include "qemu/coroutine.h"
-#include "qemu/main-loop.h"
 #include "9p.h"
=20
 /*
diff --git a/hw/9pfs/coxattr.c b/hw/9pfs/coxattr.c
index 154392eade..0e00ffaa0d 100644
--- a/hw/9pfs/coxattr.c
+++ b/hw/9pfs/coxattr.c
@@ -15,6 +15,7 @@
 #include "fsdev/qemu-fsdev.h"
 #include "qemu/thread.h"
 #include "qemu/coroutine.h"
+#include "qemu/main-loop.h"
 #include "coth.h"
=20
 int coroutine_fn v9fs_co_llistxattr(V9fsPDU *pdu, V9fsPath *path, void *=
value,
diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index c50b1961d3..71eebe12dd 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -15,6 +15,7 @@
 #include "hw/9pfs/xen-9pfs.h"
 #include "qapi/error.h"
 #include "qemu/config-file.h"
+#include "qemu/main-loop.h"
 #include "qemu/option.h"
 #include "fsdev/qemu-fsdev.h"
=20
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index cce671014b..ce9247118e 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -19,6 +19,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-=
blk.c
index 158c78f852..9299a1a7c2 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -16,6 +16,7 @@
 #include "qapi/error.h"
 #include "trace.h"
 #include "qemu/iov.h"
+#include "qemu/main-loop.h"
 #include "qemu/thread.h"
 #include "qemu/error-report.h"
 #include "hw/virtio/virtio-access.h"
diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-bloc=
k.c
index 71c63330ac..3b9caeb2fa 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -20,6 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qapi/error.h"
 #include "hw/xen/xen_common.h"
 #include "hw/block/xen_blkif.h"
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 7542c8f273..e80439482c 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -41,6 +41,7 @@
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "trace.h"
=20
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 848a0ad0ea..aef39536ac 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -7,6 +7,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qapi/error.h"
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index b868e54d72..272cfb6049 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/iov.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "migration/qemu-file-types.h"
 #include "monitor/monitor.h"
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 5bd95b8ab0..d8284671f0 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -13,6 +13,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qmp/qerror.h"
+#include "qemu/main-loop.h"
 #include "sysemu/hostmem.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/numa.h"
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 4a44712fde..539ede12c0 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -26,6 +26,7 @@
 #include "qemu/timer.h"
 #include "qemu/queue.h"
 #include "qemu/atomic.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "sysemu/sysemu.h"
 #include "migration/blocker.h"
diff --git a/hw/dma/etraxfs_dma.c b/hw/dma/etraxfs_dma.c
index 4285443c81..36da22fa90 100644
--- a/hw/dma/etraxfs_dma.c
+++ b/hw/dma/etraxfs_dma.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
+#include "qemu/main-loop.h"
 #include "exec/address-spaces.h"
 #include "sysemu/sysemu.h"
=20
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 000de6b9ce..50fe5cc1a9 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -21,6 +21,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "exec/address-spaces.h"
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 63abace70a..3e15ffc828 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -23,6 +23,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/range.h"
 #include "sysemu/xen-mapcache.h"
 #include "trace.h"
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 1d5a54b29e..378c1f360f 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -28,6 +28,7 @@
=20
 #include "qemu/error-report.h"
 #include "qemu/log.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/dma.h"
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 005b4d5ef4..61cb3b26ab 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -27,6 +27,7 @@
 #include "hw/isa/isa.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/blockdev.h"
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index d85c31a0ee..d30bdd70ee 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -22,6 +22,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-types-block.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "hw/ide/internal.h"
 #include "sysemu/block-backend.h"
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 83c72ee18d..f97a6e9867 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -12,6 +12,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "hw/s390x/ioinst.h"
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index 5ee1498f48..a9c2c95b0d 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -8,6 +8,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 3a21c62809..012710d057 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
diff --git a/hw/misc/imx6_src.c b/hw/misc/imx6_src.c
index 0be683de06..b9d86fe530 100644
--- a/hw/misc/imx6_src.c
+++ b/hw/misc/imx6_src.c
@@ -14,6 +14,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "arm-powerctl.h"
 #include "qom/cpu.h"
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index e217238296..e5c902ada4 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -34,6 +34,7 @@
 #include "etsec.h"
 #include "registers.h"
 #include "qemu/log.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
=20
 /* #define HEX_DUMP */
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 1d32cb79e2..ea20a92cda 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -21,6 +21,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/ptimer.h"
 #include "qemu/log.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 /* For crc32 */
 #include <zlib.h>
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index a6b719035c..e975700f95 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -22,7 +22,7 @@
 #include "hw/virtio/virtio-net.h"
 #include "net/vhost_net.h"
 #include "qemu/error-report.h"
-
+#include "qemu/main-loop.h"
=20
 #include <sys/socket.h>
 #include <net/if.h>
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index b9e1cd71cf..cdf4d774da 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -13,6 +13,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/iov.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "hw/virtio/virtio.h"
 #include "net/net.h"
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index a1192d7889..a28aca453d 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -31,6 +31,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/cpus.h"
 #include "qemu/log.h"
+#include "qemu/main-loop.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
 #include "kvm_ppc.h"
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index e7f42d78a1..761d551967 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -13,6 +13,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "cpu.h"
 #include "hw/irq.h"
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 6808d4cda8..0f4e6b7120 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -3,6 +3,7 @@
 #include "sysemu/hw_accel.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "cpu.h"
diff --git a/hw/ppc/spapr_rng.c b/hw/ppc/spapr_rng.c
index 0e1c7ebcf8..cfe43eaae9 100644
--- a/hw/ppc/spapr_rng.c
+++ b/hw/ppc/spapr_rng.c
@@ -21,6 +21,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/device_tree.h"
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index b32f4c0ca9..efa54a30c5 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -27,6 +27,7 @@
 #include "sysemu/dma.h"
 #include "hw/pci/msi.h"
 #include "qemu/iov.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "hw/scsi/scsi.h"
 #include "scsi/constants.h"
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 5fbdecb434..aa34297a5d 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -23,6 +23,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "hw/scsi/scsi.h"
 #include "migration/qemu-file-types.h"
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 85af638bc7..7e27bce43e 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -27,6 +27,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "hw/scsi/scsi.h"
 #include "migration/vmstate.h"
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index b9d057df5d..904da4fc88 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -22,6 +22,7 @@
 #include "hw/timer/allwinner-a10-pit.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
=20
 static void a10_pit_update_irq(AwA10PITState *s)
diff --git a/hw/timer/altera_timer.c b/hw/timer/altera_timer.c
index 0dd4f321f7..51971e44ca 100644
--- a/hw/timer/altera_timer.c
+++ b/hw/timer/altera_timer.c
@@ -19,6 +19,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
=20
diff --git a/hw/timer/etraxfs_timer.c b/hw/timer/etraxfs_timer.c
index 2fd54ad4dc..739276ecb8 100644
--- a/hw/timer/etraxfs_timer.c
+++ b/hw/timer/etraxfs_timer.c
@@ -26,6 +26,7 @@
 #include "hw/sysbus.h"
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/irq.h"
diff --git a/hw/timer/exynos4210_rtc.c b/hw/timer/exynos4210_rtc.c
index f79b970c5e..5c954cfa01 100644
--- a/hw/timer/exynos4210_rtc.c
+++ b/hw/timer/exynos4210_rtc.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/log.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/timer/milkymist-sysctl.c b/hw/timer/milkymist-sysctl.c
index 900b0b62a9..4d75d73a93 100644
--- a/hw/timer/milkymist-sysctl.c
+++ b/hw/timer/milkymist-sysctl.c
@@ -30,6 +30,7 @@
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
=20
 enum {
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index 525bc1e590..c7d215d4ef 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -14,6 +14,7 @@
 #include "qemu/config-file.h"
 #include "trace.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
=20
 #include "hw/usb.h"
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 45ff4f4115..d7d1ecd45d 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -34,6 +34,7 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
=20
 #define FRAME_TIMER_FREQ 1000
 #define FRAME_TIMER_NS   (NANOSECONDS_PER_SECOND / FRAME_TIMER_FREQ)
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 6f5338832a..c043487298 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -43,6 +43,7 @@
 #include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
index dfbb418e77..1fc2f32ce9 100644
--- a/hw/usb/xen-usb.c
+++ b/hw/usb/xen-usb.c
@@ -24,6 +24,7 @@
 #include <sys/user.h>
=20
 #include "qemu/config-file.h"
+#include "qemu/main-loop.h"
 #include "qemu/option.h"
 #include "hw/sysbus.h"
 #include "hw/usb.h"
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 16f200e6fe..c78a85a864 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -28,6 +28,7 @@
 #include "hw/s390x/ccw-device.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
=20
 struct VFIOCCWDevice {
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index a363b4495f..3e03c495d8 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -31,6 +31,7 @@
 #include "exec/memory.h"
 #include "hw/hw.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/range.h"
 #include "sysemu/balloon.h"
 #include "sysemu/kvm.h"
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 48ac0f5a34..ab3ee2ca7a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -28,6 +28,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/range.h"
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 2ec9c9f49b..ff5f805d68 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -22,6 +22,7 @@
 #include "hw/vfio/vfio-platform.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/range.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 96b8d3c95d..48905383f8 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -12,6 +12,7 @@
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-backend.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "standard-headers/linux/vhost_types.h"
=20
 #ifdef CONFIG_VHOST_KERNEL
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 4ca5b2551e..02a9b25199 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -18,6 +18,7 @@
 #include "chardev/char-fe.h"
 #include "sysemu/kvm.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/sockets.h"
 #include "sysemu/cryptodev.h"
 #include "migration/migration.h"
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 45187d3344..dbfaee6d7c 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -13,6 +13,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/iov.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "hw/qdev.h"
 #include "qapi/error.h"
diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index 17c196d107..ca487f63d2 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -15,6 +15,7 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "hw/virtio/virtio-pmem.h"
 #include "hw/virtio/virtio-access.h"
 #include "standard-headers/linux/virtio_ids.h"
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 79c7a910cc..f4c8337930 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -17,6 +17,7 @@
 #include "trace.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "hw/virtio/virtio.h"
 #include "migration/qemu-file-types.h"
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 2831940ae7..47a7c9760a 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -28,6 +28,7 @@
 #include "hw/sysbus.h"
 #include "hw/boards.h"
 #include "qemu/log.h"
+#include "qemu/main-loop.h"
 #include "qapi/error.h"
 #include "hw/xen/xen-legacy-backend.h"
 #include "hw/xen/xen_pvdev.h"
diff --git a/hw/xen/xen_pvdev.c b/hw/xen/xen_pvdev.c
index 6ef09cbf9d..43a336aabf 100644
--- a/hw/xen/xen_pvdev.c
+++ b/hw/xen/xen_pvdev.c
@@ -19,6 +19,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/main-loop.h"
 #include "hw/qdev-core.h"
 #include "hw/xen/xen-legacy-backend.h"
 #include "hw/xen/xen_pvdev.h"
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 3aa1e832a8..6207a105ff 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -33,7 +33,6 @@
 #include "qemu/timer.h"
 #include "qemu/hbitmap.h"
 #include "block/snapshot.h"
-#include "qemu/main-loop.h"
 #include "qemu/throttle.h"
=20
 #define BLOCK_FLAG_LAZY_REFCOUNTS   8
diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index aa1b864ccd..67601dc9a4 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -2,6 +2,7 @@
 #define QEMU_CHAR_FE_H
=20
 #include "chardev/char.h"
+#include "qemu/main-loop.h"
=20
 typedef void IOEventHandler(void *opaque, int event);
 typedef int BackendChangeHandler(void *opaque);
diff --git a/include/chardev/char-io.h b/include/chardev/char-io.h
index 1709b59c9f..ac379ea70e 100644
--- a/include/chardev/char-io.h
+++ b/include/chardev/char-io.h
@@ -26,6 +26,7 @@
=20
 #include "io/channel.h"
 #include "chardev/char.h"
+#include "qemu/main-loop.h"
=20
 /* Can only be used for read */
 GSource *io_add_watch_poll(Chardev *chr,
diff --git a/include/chardev/char.h b/include/chardev/char.h
index c0b57f7685..087b202b62 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -2,8 +2,8 @@
 #define QEMU_CHAR_H
=20
 #include "qapi/qapi-types-char.h"
-#include "qemu/main-loop.h"
 #include "qemu/bitmap.h"
+#include "qemu/thread.h"
 #include "qom/object.h"
=20
 #define IAC_EOR 239
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 426566a5c6..15a763dc18 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -2,6 +2,7 @@
 #define QEMU_HW_SCSI_H
=20
 #include "hw/qdev.h"
+#include "block/aio.h"
 #include "hw/block/block.h"
 #include "sysemu/sysemu.h"
 #include "scsi/utils.h"
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 77f5df59b0..ac18a1184a 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -5,7 +5,6 @@
 #include "qapi/qapi-types-run-state.h"
 #include "qemu/timer.h"
 #include "qemu/notify.h"
-#include "qemu/main-loop.h"
 #include "qemu/bitmap.h"
 #include "qemu/uuid.h"
 #include "qom/object.h"
diff --git a/memory.c b/memory.c
index 09d9b254fd..cbf0e5a6cc 100644
--- a/memory.c
+++ b/memory.c
@@ -21,6 +21,7 @@
 #include "qapi/visitor.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/qemu-print.h"
 #include "qom/object.h"
 #include "trace-root.h"
diff --git a/migration/block.c b/migration/block.c
index 91f98ef44a..e81fd7e14f 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/cutils.h"
 #include "qemu/queue.h"
 #include "block.h"
diff --git a/migration/colo.c b/migration/colo.c
index 0b5b620391..0602e6bbe4 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -23,6 +23,7 @@
 #include "io/channel-buffer.h"
 #include "trace.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/rcu.h"
 #include "migration/failover.h"
 #ifdef CONFIG_REPLICATION
diff --git a/migration/migration.c b/migration/migration.c
index 8a607fe1e2..85e5d22e32 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "migration/blocker.h"
 #include "exec.h"
 #include "fd.h"
diff --git a/migration/savevm.c b/migration/savevm.c
index 89e8f4c180..b8f734537a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -51,6 +51,7 @@
 #include "exec/target_page.h"
 #include "trace.h"
 #include "qemu/iov.h"
+#include "qemu/main-loop.h"
 #include "block/snapshot.h"
 #include "qemu/cutils.h"
 #include "io/channel-buffer.h"
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index ec3d2e2ebc..60629ef160 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -28,7 +28,6 @@
 #endif
=20
 #include "qemu/bswap.h"
-#include "qemu/main-loop.h"
=20
 /* This is all part of the "official" NBD API.
  *
diff --git a/net/can/can_socketcan.c b/net/can/can_socketcan.c
index 3dec108684..8a6ffad40c 100644
--- a/net/can/can_socketcan.c
+++ b/net/can/can_socketcan.c
@@ -27,6 +27,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "chardev/char.h"
diff --git a/net/tap-win32.c b/net/tap-win32.c
index 662f9b63e1..9cdef47286 100644
--- a/net/tap-win32.c
+++ b/net/tap-win32.c
@@ -35,6 +35,7 @@
 #include "net/tap.h"            /* tap_has_ufo, ... */
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include <windows.h>
 #include <winioctl.h>
=20
diff --git a/net/tap.c b/net/tap.c
index fc38029f41..6207f61f84 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -40,6 +40,7 @@
 #include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/sockets.h"
=20
 #include "net/tap.h"
diff --git a/qemu-img.c b/qemu-img.c
index 79983772de..a398fd44d6 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -38,6 +38,7 @@
 #include "qemu/option.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "qom/object_interfaces.h"
diff --git a/qom/cpu.c b/qom/cpu.c
index fdc1af8f40..cdb8c71b6b 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -24,6 +24,7 @@
 #include "sysemu/hw_accel.h"
 #include "qemu/notify.h"
 #include "qemu/log.h"
+#include "qemu/main-loop.h"
 #include "exec/log.h"
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index 9e41ed1dcf..9f7a76ca32 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -13,6 +13,7 @@
 #include "sysemu/replay.h"
 #include "replay-internal.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "sysemu/sysemu.h"
=20
 /* Mutex to protect reading and writing events to the log.
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 060699b901..616d62c7fc 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -23,6 +23,7 @@
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 #include "qemu/log.h"
+#include "qemu/main-loop.h"
 #include "sysemu/sysemu.h"
 #include "qemu/bitops.h"
 #include "internals.h"
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 75b66bf844..210f5831e3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5,6 +5,7 @@
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
+
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "target/arm/idau.h"
@@ -14,6 +15,7 @@
 #include "exec/gdbstub.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
+#include "qemu/main-loop.h"
 #include "sysemu/sysemu.h"
 #include "qemu/bitops.h"
 #include "qemu/crc32c.h"
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 36a1e60bd4..b5713e3ffe 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -16,6 +16,7 @@
 #include "qemu-common.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "sysemu/kvm_int.h"
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 22d19c9aec..c76d3d799a 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -21,6 +21,7 @@
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
 #include "qemu/host-utils.h"
+#include "qemu/main-loop.h"
 #include "exec/gdbstub.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
diff --git a/target/arm/m_helper.c b/target/arm/m_helper.c
index 84609f446e..cde5195d28 100644
--- a/target/arm/m_helper.c
+++ b/target/arm/m_helper.c
@@ -5,6 +5,7 @@
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
+
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "target/arm/idau.h"
@@ -14,6 +15,7 @@
 #include "exec/gdbstub.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
+#include "qemu/main-loop.h"
 #include "sysemu/sysemu.h"
 #include "qemu/bitops.h"
 #include "qemu/crc32c.h"
diff --git a/target/arm/psci.c b/target/arm/psci.c
index a74d78802a..af1d5a551e 100644
--- a/target/arm/psci.c
+++ b/target/arm/psci.c
@@ -15,10 +15,12 @@
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "kvm-consts.h"
+#include "qemu/main-loop.h"
 #include "sysemu/sysemu.h"
 #include "internals.h"
 #include "arm-powerctl.h"
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 30ed209e6b..fd55fb55e9 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -31,6 +31,7 @@
=20
 #include "exec/gdbstub.h"
 #include "qemu/host-utils.h"
+#include "qemu/main-loop.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "hw/i386/pc.h"
diff --git a/target/lm32/op_helper.c b/target/lm32/op_helper.c
index d184550a7b..99ca76c04f 100644
--- a/target/lm32/op_helper.c
+++ b/target/lm32/op_helper.c
@@ -2,6 +2,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
+#include "qemu/main-loop.h"
=20
 #include "hw/lm32/lm32_pic.h"
 #include "hw/char/lm32_juart.h"
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 938f8f144b..83ee0026ac 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -18,6 +18,7 @@
 #include "cpu.h"
 #include "internal.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 5c07ef3e4d..8f037af956 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -16,10 +16,12 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
+
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "internal.h"
 #include "qemu/host-utils.h"
+#include "qemu/main-loop.h"
 #include "exec/helper-proto.h"
 #include "crypto/aes.h"
 #include "fpu/softfloat.h"
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 4b05014a64..6836a4afb3 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -47,6 +47,7 @@
 #include "exec/ram_addr.h"
 #include "sysemu/hostmem.h"
 #include "qemu/cutils.h"
+#include "qemu/main-loop.h"
 #include "qemu/mmap-alloc.h"
 #include "elf.h"
 #include "sysemu/kvm_int.h"
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 199f5cef8f..d6638ee60e 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -7,6 +7,7 @@
 #include "mmu-hash64.h"
 #include "migration/cpu.h"
 #include "qapi/error.h"
+#include "qemu/main-loop.h"
 #include "kvm_ppc.h"
 #include "exec/helper-proto.h"
=20
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 6f4ffa3661..1351b53f28 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -16,10 +16,12 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
+
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "qemu/host-utils.h"
+#include "qemu/main-loop.h"
 #include "exec/helper-proto.h"
 #include "helper_regs.h"
 #include "exec/cpu_ldst.h"
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 49a8a02363..2318f3ab45 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -16,11 +16,13 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
+
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
=20
 #include "helper_regs.h"
=20
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 261a8fe707..55f7a7f16a 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -16,6 +16,7 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "cpu.h"
@@ -29,6 +30,7 @@
 #include "exec/log.h"
 #include "helper_regs.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/qemu-print.h"
 #include "mmu-book3s-v3.h"
 #include "mmu-radix64.h"
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4a5de28036..9f9553afb4 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -26,6 +26,7 @@
 #include "tcg-op.h"
 #include "tcg-op-gvec.h"
 #include "qemu/host-utils.h"
+#include "qemu/main-loop.h"
 #include "exec/cpu_ldst.h"
=20
 #include "exec/helper-proto.h"
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index b465bb599e..55d1a14588 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -32,6 +32,7 @@
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "qemu/units.h"
+#include "qemu/main-loop.h"
 #include "qemu/mmap-alloc.h"
 #include "qemu/log.h"
 #include "sysemu/sysemu.h"
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 17679b6e2f..5c95ecd51c 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -21,6 +21,7 @@
 #include "tcg.h"
 #include "tcg-op.h"
 #include "tcg-op-gvec.h"
+#include "qemu/main-loop.h"
 #include "tcg-gvec-desc.h"
=20
 #define MAX_UNROLL  4
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 03fa1142a1..481b7508df 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -27,6 +27,7 @@
 #include "block/blockjob_int.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
+#include "qemu/main-loop.h"
 #include "iothread.h"
=20
 static QemuEvent done_event;
diff --git a/tests/test-bdrv-graph-mod.c b/tests/test-bdrv-graph-mod.c
index cfeec36566..a007754d9e 100644
--- a/tests/test-bdrv-graph-mod.c
+++ b/tests/test-bdrv-graph-mod.c
@@ -20,6 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/main-loop.h"
 #include "block/block_int.h"
 #include "sysemu/block-backend.h"
=20
diff --git a/tests/test-block-backend.c b/tests/test-block-backend.c
index 5b5d6845c0..2fb1a444bd 100644
--- a/tests/test-block-backend.c
+++ b/tests/test-block-backend.c
@@ -26,6 +26,7 @@
 #include "block/block.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
+#include "qemu/main-loop.h"
=20
 static void test_drain_aio_error_flush_cb(void *opaque, int ret)
 {
diff --git a/tests/test-block-iothread.c b/tests/test-block-iothread.c
index 1949d5e61a..e81b5b8dc4 100644
--- a/tests/test-block-iothread.c
+++ b/tests/test-block-iothread.c
@@ -28,6 +28,7 @@
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
+#include "qemu/main-loop.h"
 #include "iothread.h"
=20
 static int coroutine_fn bdrv_test_co_prwv(BlockDriverState *bs,
diff --git a/tests/test-image-locking.c b/tests/test-image-locking.c
index 7614cbf90c..ba057bd66c 100644
--- a/tests/test-image-locking.c
+++ b/tests/test-image-locking.c
@@ -29,6 +29,7 @@
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
+#include "qemu/main-loop.h"
=20
 static BlockBackend *open_image(const char *path,
                                 uint64_t perm, uint64_t shared_perm,
diff --git a/tests/test-replication.c b/tests/test-replication.c
index f085d1993a..4747d8a6be 100644
--- a/tests/test-replication.c
+++ b/tests/test-replication.c
@@ -13,6 +13,7 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/option.h"
+#include "qemu/main-loop.h"
 #include "replication.h"
 #include "block/block_int.h"
 #include "block/qdict.h"
diff --git a/tests/test-throttle.c b/tests/test-throttle.c
index a28812260e..083e1f9ba8 100644
--- a/tests/test-throttle.c
+++ b/tests/test-throttle.c
@@ -18,6 +18,7 @@
 #include "qapi/error.h"
 #include "qemu/throttle.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "block/throttle-groups.h"
 #include "sysemu/block-backend.h"
diff --git a/ui/cocoa.m b/ui/cocoa.m
index c2984028c5..c5a0d33c29 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -36,6 +36,7 @@
 #include "qapi/qapi-commands-misc.h"
 #include "sysemu/blockdev.h"
 #include "qemu-version.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include <Carbon/Carbon.h>
 #include "qom/cpu.h"
diff --git a/ui/input-linux.c b/ui/input-linux.c
index c8d22f99d9..e3fa799c34 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -7,6 +7,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/config-file.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/sockets.h"
 #include "sysemu/sysemu.h"
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 16478ecd45..a395d7ccd4 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -22,6 +22,7 @@
=20
 #include "ui/qemu-spice.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/thread.h"
 #include "qemu/timer.h"
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 104df23025..0c65ae2fe3 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "ui/qemu-spice.h"
 #include "qemu/timer.h"
+#include "qemu/main-loop.h"
 #include "qemu/option.h"
 #include "qemu/queue.h"
 #include "ui/console.h"
diff --git a/ui/vnc-auth-sasl.h b/ui/vnc-auth-sasl.h
index fb55fe04ca..1bfb86c6f5 100644
--- a/ui/vnc-auth-sasl.h
+++ b/ui/vnc-auth-sasl.h
@@ -30,7 +30,6 @@
 typedef struct VncStateSASL VncStateSASL;
 typedef struct VncDisplaySASL VncDisplaySASL;
=20
-#include "qemu/main-loop.h"
 #include "authz/base.h"
=20
 struct VncStateSASL {
diff --git a/ui/vnc.c b/ui/vnc.c
index f47f726681..4812ed29d0 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -31,6 +31,7 @@
 #include "hw/qdev-core.h"
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/sockets.h"
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index fe0309ce7a..5fda67dedf 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -36,6 +36,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "qemu/sockets.h"
+#include "qemu/thread.h"
 #include <libgen.h>
 #include <sys/signal.h>
 #include "qemu/cutils.h"
--=20
2.21.0


