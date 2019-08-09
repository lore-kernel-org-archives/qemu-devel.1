Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86907C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 07:05:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BFAB206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 07:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BFAB206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvyxe-0007e2-IX
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 03:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48544)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hvygM-00010E-LD
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hvygC-0001tO-Rs
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53644)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hvygA-0001q0-IH
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5B7B730BD1C4
 for <qemu-devel@nongnu.org>; Fri,  9 Aug 2019 06:47:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 77E0860BF3;
 Fri,  9 Aug 2019 06:47:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DE1C01136438; Fri,  9 Aug 2019 08:46:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 08:46:45 +0200
Message-Id: <20190809064645.22656-30-armbru@redhat.com>
In-Reply-To: <20190809064645.22656-1-armbru@redhat.com>
References: <20190809064645.22656-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 09 Aug 2019 06:47:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 29/29] sysemu: Split sysemu/runstate.h off
 sysemu/sysemu.h
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

sysemu/sysemu.h is a rather unfocused dumping ground for stuff related
to the system-emulator.  Evidence:

* It's included widely: in my "build everything" tree, changing
  sysemu/sysemu.h still triggers a recompile of some 1100 out of 6600
  objects (not counting tests and objects that don't depend on
  qemu/osdep.h, down from 5400 due to the previous two commits).

* It pulls in more than a dozen additional headers.

Split stuff related to run state management into its own header
sysemu/runstate.h.

Touching sysemu/sysemu.h now recompiles some 850 objects.  qemu/uuid.h
also drops from 1100 to 850, and qapi/qapi-types-run-state.h from 4400
to 4200.  Touching new sysemu/runstate.h recompiles some 500 objects.

Since I'm touching MAINTAINERS to add sysemu/runstate.h anyway, also
add qemu/main-loop.h.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS                       |  2 +
 accel/kvm/kvm-all.c               |  1 +
 audio/audio.c                     |  2 +-
 block/block-backend.c             |  2 +-
 blockdev.c                        |  1 +
 cpus.c                            |  2 +-
 dump/dump.c                       |  2 +-
 gdbstub.c                         |  1 +
 hw/acpi/core.c                    |  2 +-
 hw/acpi/ich9.c                    |  2 +-
 hw/acpi/piix4.c                   |  1 +
 hw/arm/highbank.c                 |  1 +
 hw/arm/integratorcp.c             |  1 +
 hw/arm/msf2-soc.c                 |  1 +
 hw/arm/musicpal.c                 |  1 +
 hw/arm/nseries.c                  |  1 +
 hw/arm/omap1.c                    |  1 +
 hw/arm/omap2.c                    |  1 +
 hw/arm/sbsa-ref.c                 |  1 +
 hw/arm/spitz.c                    |  1 +
 hw/arm/stellaris.c                |  1 +
 hw/arm/tosa.c                     |  2 +-
 hw/arm/virt.c                     |  1 +
 hw/block/pflash_cfi01.c           |  2 +-
 hw/block/vhost-user-blk.c         |  1 +
 hw/block/virtio-blk.c             |  1 +
 hw/char/serial.c                  |  2 +-
 hw/core/machine-qmp-cmds.c        |  1 +
 hw/core/vm-change-state-handler.c |  2 +-
 hw/display/qxl-render.c           |  2 +-
 hw/display/qxl.c                  |  2 +-
 hw/dma/etraxfs_dma.c              |  2 +-
 hw/i386/kvm/clock.c               |  2 +-
 hw/i386/kvm/i8254.c               |  2 +-
 hw/i386/kvmvapic.c                |  1 +
 hw/i386/pc.c                      |  1 +
 hw/i386/xen/xen-hvm.c             |  1 +
 hw/i386/xen/xen-mapcache.c        |  2 +-
 hw/ide/core.c                     |  2 +-
 hw/ide/qdev.c                     |  1 +
 hw/input/pckbd.c                  |  2 +-
 hw/input/ps2.c                    |  2 +-
 hw/intc/arm_gicv3_its_kvm.c       |  2 +-
 hw/intc/arm_gicv3_kvm.c           |  2 +-
 hw/intc/spapr_xive_kvm.c          |  1 +
 hw/ipmi/ipmi.c                    |  2 +-
 hw/isa/lpc_ich9.c                 |  1 +
 hw/mips/boston.c                  |  1 +
 hw/mips/mips_malta.c              |  1 +
 hw/mips/mips_r4k.c                |  1 +
 hw/misc/arm_sysctl.c              |  2 +-
 hw/misc/cbus.c                    |  2 +-
 hw/misc/exynos4210_pmu.c          |  2 +-
 hw/misc/imx7_snvs.c               |  2 +-
 hw/misc/iotkit-sysctl.c           |  2 +-
 hw/misc/macio/cuda.c              |  2 +-
 hw/misc/macio/pmu.c               |  2 +-
 hw/misc/pvpanic.c                 |  2 +-
 hw/misc/slavio_misc.c             |  2 +-
 hw/misc/zynq_slcr.c               |  2 +-
 hw/net/e1000e_core.c              |  2 +-
 hw/nvram/spapr_nvram.c            |  2 +
 hw/pci-host/bonito.c              |  2 +-
 hw/pci-host/piix.c                |  2 +-
 hw/pci-host/sabre.c               |  2 +-
 hw/ppc/e500.c                     |  1 +
 hw/ppc/mpc8544_guts.c             |  2 +-
 hw/ppc/pnv.c                      |  1 +
 hw/ppc/ppc.c                      |  2 +-
 hw/ppc/ppc_booke.c                |  2 +-
 hw/ppc/prep_systemio.c            |  2 +-
 hw/ppc/spapr.c                    |  1 +
 hw/ppc/spapr_events.c             |  2 +-
 hw/ppc/spapr_hcall.c              |  2 +-
 hw/ppc/spapr_rtas.c               |  2 +
 hw/rdma/vmw/pvrdma_main.c         |  2 +-
 hw/s390x/ipl.c                    |  1 +
 hw/s390x/sclpquiesce.c            |  2 +-
 hw/s390x/tod-kvm.c                |  2 +-
 hw/scsi/scsi-bus.c                |  1 +
 hw/sh4/r2d.c                      |  1 +
 hw/sparc/sun4m.c                  |  1 +
 hw/sparc64/sun4u.c                |  1 +
 hw/timer/etraxfs_timer.c          |  2 +-
 hw/timer/m48t59.c                 |  1 +
 hw/timer/mc146818rtc.c            |  1 +
 hw/timer/milkymist-sysctl.c       |  2 +-
 hw/timer/pxa2xx_timer.c           |  2 +-
 hw/usb/hcd-ehci.c                 |  2 +-
 hw/usb/host-libusb.c              |  1 +
 hw/usb/redirect.c                 |  1 +
 hw/vfio/pci.c                     |  1 +
 hw/virtio/virtio-rng.c            |  3 +-
 hw/virtio/virtio.c                |  2 +-
 hw/watchdog/watchdog.c            |  2 +-
 hw/xen/xen-common.c               |  2 +-
 hw/xtensa/xtfpga.c                |  1 +
 include/hw/ppc/spapr_drc.h        |  2 +-
 include/sysemu/runstate.h         | 68 +++++++++++++++++++++++++++++++
 include/sysemu/sysemu.h           | 61 ---------------------------
 memory.c                          |  2 +-
 migration/block-dirty-bitmap.c    |  2 +-
 migration/colo.c                  |  1 +
 migration/global_state.c          |  2 +-
 migration/migration.c             |  1 +
 migration/savevm.c                |  1 +
 monitor/hmp-cmds.c                |  2 +-
 monitor/hmp.c                     |  2 +-
 monitor/misc.c                    |  1 +
 monitor/qmp-cmds.c                |  1 +
 net/net.c                         |  2 +
 os-posix.c                        |  2 +-
 os-win32.c                        |  2 +-
 qapi/qmp-dispatch.c               |  2 +-
 qtest.c                           |  2 +-
 replay/replay-internal.c          |  2 +-
 replay/replay.c                   |  2 +-
 stubs/change-state-handler.c      |  2 +-
 stubs/runstate-check.c            |  2 +-
 stubs/vm-stop.c                   |  2 +-
 target/alpha/sys_helper.c         |  1 +
 target/arm/psci.c                 |  2 +-
 target/hppa/op_helper.c           |  2 +-
 target/i386/excp_helper.c         |  2 +-
 target/i386/hax-all.c             |  2 +-
 target/i386/helper.c              |  2 +-
 target/i386/hvf/hvf.c             |  3 +-
 target/i386/kvm.c                 |  1 +
 target/i386/sev.c                 |  1 +
 target/i386/whpx-all.c            |  2 +-
 target/lm32/op_helper.c           |  2 +-
 target/mips/kvm.c                 |  2 +-
 target/s390x/helper.c             |  2 +-
 target/s390x/kvm.c                |  1 +
 target/s390x/sigp.c               |  2 +-
 target/sh4/helper.c               |  3 +-
 target/sparc/int32_helper.c       |  2 +-
 ui/gtk.c                          |  1 +
 ui/input.c                        |  1 +
 ui/sdl2.c                         |  1 +
 ui/spice-core.c                   |  2 +-
 vl.c                              |  1 +
 142 files changed, 215 insertions(+), 143 deletions(-)
 create mode 100644 include/sysemu/runstate.h

diff --git a/MAINTAINERS b/MAINTAINERS
index adc64cfe33..743a92666a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1924,6 +1924,8 @@ Main loop
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: cpus.c
+F: include/qemu/main-loop.h
+F: include/sysemu/runstate.h
 F: util/main-loop.c
 F: util/qemu-timer.c
 F: vl.c
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index fc38d0b9e3..b09bad0804 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -28,6 +28,7 @@
 #include "hw/s390x/adapter.h"
 #include "exec/gdbstub.h"
 #include "sysemu/kvm_int.h"
+#include "sysemu/runstate.h"
 #include "sysemu/cpus.h"
 #include "sysemu/sysemu.h"
 #include "qemu/bswap.h"
diff --git a/audio/audio.c b/audio/audio.c
index b9b2d07e54..c8b88d892d 100644
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
+#include "sysemu/runstate.h"
 #include "trace.h"
=20
 #define AUDIO_CAP "audio"
diff --git a/block/block-backend.c b/block/block-backend.c
index 4991ab5574..84e76bf06c 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -17,7 +17,7 @@
 #include "block/throttle-groups.h"
 #include "hw/qdev-core.h"
 #include "sysemu/blockdev.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-block.h"
 #include "qemu/id.h"
diff --git a/blockdev.c b/blockdev.c
index 64eab33ae9..95cdd5a5cb 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -58,6 +58,7 @@
 #include "block/trace.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/qtest.h"
+#include "sysemu/runstate.h"
 #include "qemu/cutils.h"
 #include "qemu/help_option.h"
 #include "qemu/main-loop.h"
diff --git a/cpus.c b/cpus.c
index a20a9a29c1..f4ad855b77 100644
--- a/cpus.c
+++ b/cpus.c
@@ -41,7 +41,6 @@
 #include "sysemu/kvm.h"
 #include "sysemu/hax.h"
 #include "sysemu/hvf.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/whpx.h"
 #include "exec/exec-all.h"
=20
@@ -56,6 +55,7 @@
 #include "tcg.h"
 #include "hw/nmi.h"
 #include "sysemu/replay.h"
+#include "sysemu/runstate.h"
 #include "hw/boards.h"
 #include "hw/hw.h"
=20
diff --git a/dump/dump.c b/dump/dump.c
index d430f5e929..6fb6e1245a 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -20,8 +20,8 @@
 #include "monitor/monitor.h"
 #include "sysemu/kvm.h"
 #include "sysemu/dump.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/memory_mapping.h"
+#include "sysemu/runstate.h"
 #include "sysemu/cpus.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-dump.h"
diff --git a/gdbstub.c b/gdbstub.c
index b470aec8ea..b92ba59e4d 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -48,6 +48,7 @@
 #include "qemu/sockets.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
+#include "sysemu/runstate.h"
 #include "hw/semihosting/semihost.h"
 #include "exec/exec-all.h"
=20
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index f36d60f619..45cbed49ab 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -20,7 +20,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "sysemu/sysemu.h"
 #include "hw/irq.h"
 #include "hw/acpi/acpi.h"
 #include "hw/nvram/fw_cfg.h"
@@ -32,6 +31,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
+#include "sysemu/runstate.h"
=20
 struct acpi_table_header {
     uint16_t _length;         /* our length, not actual part of the hdr =
*/
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index c1aaa07d43..2ca52bf045 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -33,7 +33,7 @@
 #include "qemu/timer.h"
 #include "qom/cpu.h"
 #include "sysemu/reset.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/tco.h"
 #include "exec/address-spaces.h"
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 3ff35a49e4..1c907d2a7d 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -28,6 +28,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/acpi/acpi.h"
 #include "sysemu/reset.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "qemu/range.h"
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index ca4c71f8a2..362e5ba044 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -26,6 +26,7 @@
 #include "hw/loader.h"
 #include "net/net.h"
 #include "sysemu/kvm.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
 #include "exec/address-spaces.h"
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index ecccb4125a..200568b42a 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -18,6 +18,7 @@
 #include "hw/net/smc91c111.h"
 #include "net/net.h"
 #include "exec/address-spaces.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
 #include "hw/char/pl011.h"
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 76cc3e09b0..008fd9327a 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -30,6 +30,7 @@
 #include "hw/irq.h"
 #include "hw/arm/msf2-soc.h"
 #include "hw/misc/unimp.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
=20
 #define MSF2_TIMER_BASE       0x40004000
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 92fbe74d74..8ae4751d75 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -29,6 +29,7 @@
 #include "hw/irq.h"
 #include "hw/audio/wm8750.h"
 #include "sysemu/block-backend.h"
+#include "sysemu/runstate.h"
 #include "exec/address-spaces.h"
 #include "ui/pixel_ops.h"
=20
diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index af99ff4522..a6c4085337 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -24,6 +24,7 @@
 #include "qemu/cutils.h"
 #include "qemu/bswap.h"
 #include "sysemu/reset.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "hw/arm/omap.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index d28ad2b9ff..0400593805 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -34,6 +34,7 @@
 #include "hw/arm/soc_dma.h"
 #include "sysemu/qtest.h"
 #include "sysemu/reset.h"
+#include "sysemu/runstate.h"
 #include "qemu/range.h"
 #include "hw/sysbus.h"
 #include "qemu/cutils.h"
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index e0a9c2da83..bd7ddff983 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -25,6 +25,7 @@
 #include "sysemu/blockdev.h"
 #include "sysemu/qtest.h"
 #include "sysemu/reset.h"
+#include "sysemu/runstate.h"
 #include "hw/boards.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 2a0e2ed1d0..e98e9a5170 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -24,6 +24,7 @@
 #include "qemu/units.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/numa.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
 #include "exec/hwaddr.h"
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index ee010c48b2..59348123b5 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "hw/arm/pxa.h"
 #include "hw/arm/boot.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "hw/pcmcia.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 9feb403f1e..b198066b54 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -18,6 +18,7 @@
 #include "hw/boards.h"
 #include "qemu/log.h"
 #include "exec/address-spaces.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "hw/arm/armv7m.h"
 #include "hw/char/pl011.h"
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index 7f136bf187..e9627e356e 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -13,6 +13,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "sysemu/runstate.h"
 #include "hw/arm/pxa.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/sharpsl.h"
@@ -24,7 +25,6 @@
 #include "hw/ssi/ssi.h"
 #include "hw/sysbus.h"
 #include "exec/address-spaces.h"
-#include "sysemu/sysemu.h"
=20
 #define TOSA_RAM    0x04000000
 #define TOSA_ROM	0x00800000
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 226e810d06..02510acb81 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -45,6 +45,7 @@
 #include "net/net.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/numa.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "hw/loader.h"
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index de6efe1893..566c0acb77 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -52,7 +52,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "sysemu/blockdev.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "trace.h"
=20
 /* #define PFLASH_DEBUG */
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 6b6cd07362..0b8c5dfeab 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -29,6 +29,7 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
=20
 static const int user_feature_bits[] =3D {
     VIRTIO_BLK_F_SIZE_MAX,
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 78ac371eba..18851601cb 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -21,6 +21,7 @@
 #include "hw/qdev-properties.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "hw/virtio/virtio-blk.h"
 #include "dataplane/virtio-blk.h"
 #include "scsi/constants.h"
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 72580f19d0..b4aa250950 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -31,7 +31,7 @@
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "sysemu/reset.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "qemu/error-report.h"
 #include "trace.h"
=20
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index d8284671f0..526fbd5ced 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -17,6 +17,7 @@
 #include "sysemu/hostmem.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/numa.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
=20
 CpuInfoList *qmp_query_cpus(Error **errp)
diff --git a/hw/core/vm-change-state-handler.c b/hw/core/vm-change-state-=
handler.c
index 9068d51c9a..1f3630986d 100644
--- a/hw/core/vm-change-state-handler.c
+++ b/hw/core/vm-change-state-handler.c
@@ -17,7 +17,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/qdev-core.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
=20
 static int qdev_get_dev_tree_depth(DeviceState *dev)
 {
diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index 473e333475..f7fdc4901e 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -21,7 +21,7 @@
=20
 #include "qemu/osdep.h"
 #include "qxl.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "trace.h"
=20
 static void qxl_blit(PCIQXLDevice *qxl, QXLRect *rect)
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 971c2d0568..cd7eb39d20 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -28,8 +28,8 @@
 #include "qemu/atomic.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
-#include "sysemu/sysemu.h"
 #include "hw/qdev-properties.h"
+#include "sysemu/runstate.h"
 #include "migration/blocker.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/hw/dma/etraxfs_dma.c b/hw/dma/etraxfs_dma.c
index 36da22fa90..47e1c6df12 100644
--- a/hw/dma/etraxfs_dma.c
+++ b/hw/dma/etraxfs_dma.c
@@ -26,8 +26,8 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "qemu/main-loop.h"
+#include "sysemu/runstate.h"
 #include "exec/address-spaces.h"
-#include "sysemu/sysemu.h"
=20
 #include "hw/cris/etraxfs_dma.h"
=20
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index d6a5325f0b..80c133a724 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -17,8 +17,8 @@
 #include "cpu.h"
 #include "qemu/host-utils.h"
 #include "qemu/module.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
+#include "sysemu/runstate.h"
 #include "sysemu/hw_accel.h"
 #include "kvm_i386.h"
 #include "migration/vmstate.h"
diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index 27e36a2abf..6a911e23f9 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -29,7 +29,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "hw/timer/i8254.h"
 #include "hw/timer/i8254_internal.h"
 #include "sysemu/kvm.h"
diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
index 44e40478c8..51639202c2 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/kvmvapic.c
@@ -16,6 +16,7 @@
 #include "sysemu/cpus.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
+#include "sysemu/runstate.h"
 #include "hw/i386/apic_internal.h"
 #include "hw/sysbus.h"
 #include "hw/boards.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 14fe8233ae..3ab4bcb3ca 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -56,6 +56,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/qtest.h"
 #include "sysemu/reset.h"
+#include "sysemu/runstate.h"
 #include "kvm_i386.h"
 #include "hw/xen/xen.h"
 #include "hw/xen/start_info.h"
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index ca4659b20f..5d3e4750e6 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -25,6 +25,7 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/range.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/xen-mapcache.h"
 #include "trace.h"
diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
index 09656f9f11..5b120ed44b 100644
--- a/hw/i386/xen/xen-mapcache.c
+++ b/hw/i386/xen/xen-mapcache.c
@@ -17,7 +17,7 @@
 #include "hw/xen/xen-legacy-backend.h"
 #include "qemu/bitmap.h"
=20
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "sysemu/xen-mapcache.h"
 #include "trace.h"
=20
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 61cb3b26ab..38b6cdac87 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -37,7 +37,7 @@
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "sysemu/replay.h"
-
+#include "sysemu/runstate.h"
 #include "hw/ide/internal.h"
 #include "trace.h"
=20
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 39957dd39f..6fba6b62b8 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -30,6 +30,7 @@
 #include "sysemu/blockdev.h"
 #include "hw/block/block.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "qapi/visitor.h"
=20
 /* --------------------------------- */
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index f2e32a1ed5..f0acfd86f7 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -31,7 +31,7 @@
 #include "hw/irq.h"
 #include "hw/input/i8042.h"
 #include "sysemu/reset.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
=20
 #include "trace.h"
=20
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 68b30229f4..67f92f6112 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -29,7 +29,7 @@
 #include "ui/console.h"
 #include "ui/input.h"
 #include "sysemu/reset.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
=20
 #include "trace.h"
=20
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index d0bd4f1d81..d66f2431ee 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -23,7 +23,7 @@
 #include "qemu/module.h"
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
 #include "migration/blocker.h"
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index d9c72f85be..9c7f4ab871 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -26,7 +26,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "sysemu/kvm.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "kvm_arm.h"
 #include "gicv3_internal.h"
 #include "vgic_common.h"
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 3bf8e7a20e..57aaed3ddc 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -14,6 +14,7 @@
 #include "target/ppc/cpu.h"
 #include "sysemu/cpus.h"
 #include "sysemu/kvm.h"
+#include "sysemu/runstate.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/spapr_xive.h"
diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index ff05a889ec..136c86b7a7 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -25,8 +25,8 @@
 #include "qemu/osdep.h"
 #include "hw/ipmi/ipmi.h"
 #include "hw/qdev-properties.h"
-#include "sysemu/sysemu.h"
 #include "qom/object_interfaces.h"
+#include "sysemu/runstate.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/visitor.h"
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 41452f36b8..eec9eb31c1 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -47,6 +47,7 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/qdev-properties.h"
 #include "exec/address-spaces.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "qom/cpu.h"
 #include "hw/nvram/fw_cfg.h"
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index aa8016f986..ca7d813a52 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -38,6 +38,7 @@
 #include "sysemu/device_tree.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
+#include "sysemu/runstate.h"
=20
 #include <libfdt.h>
=20
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index bdba712329..9fec2b08e4 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -52,6 +52,7 @@
 #include "qemu/host-utils.h"
 #include "sysemu/qtest.h"
 #include "sysemu/reset.h"
+#include "sysemu/runstate.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/empty_slot.h"
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index a41b0b0524..bc0be26544 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -34,6 +34,7 @@
 #include "exec/address-spaces.h"
 #include "sysemu/qtest.h"
 #include "sysemu/reset.h"
+#include "sysemu/runstate.h"
 #include "qemu/error-report.h"
=20
 #define MAX_IDE_BUS 2
diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index e0b299c235..fc79522ece 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -11,11 +11,11 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "qemu/timer.h"
+#include "sysemu/runstate.h"
 #include "qemu/bitops.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/arm/primecell.h"
-#include "sysemu/sysemu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/misc/cbus.c b/hw/misc/cbus.c
index 16ee704bca..3c3721ad2d 100644
--- a/hw/misc/cbus.c
+++ b/hw/misc/cbus.c
@@ -24,7 +24,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/misc/cbus.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
=20
 //#define DEBUG
=20
diff --git a/hw/misc/exynos4210_pmu.c b/hw/misc/exynos4210_pmu.c
index 4817165121..500f28343f 100644
--- a/hw/misc/exynos4210_pmu.c
+++ b/hw/misc/exynos4210_pmu.c
@@ -28,7 +28,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
=20
 #ifndef DEBUG_PMU
 #define DEBUG_PMU           0
diff --git a/hw/misc/imx7_snvs.c b/hw/misc/imx7_snvs.c
index 55b962a453..45972a5920 100644
--- a/hw/misc/imx7_snvs.c
+++ b/hw/misc/imx7_snvs.c
@@ -16,7 +16,7 @@
 #include "hw/misc/imx7_snvs.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
=20
 static uint64_t imx7_snvs_read(void *opaque, hwaddr offset, unsigned siz=
e)
 {
diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
index dba91f94a7..9aa8109463 100644
--- a/hw/misc/iotkit-sysctl.c
+++ b/hw/misc/iotkit-sysctl.c
@@ -20,9 +20,9 @@
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "sysemu/runstate.h"
 #include "trace.h"
 #include "qapi/error.h"
-#include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/registerfields.h"
diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 9011f93086..e38becba6a 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -32,7 +32,7 @@
 #include "hw/misc/mos6522.h"
 #include "hw/misc/macio/cuda.h"
 #include "qemu/timer.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index a289340036..769aed8052 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -39,7 +39,7 @@
 #include "hw/misc/macio/gpio.h"
 #include "hw/misc/macio/pmu.h"
 #include "qemu/timer.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 653393ef02..d65ac86478 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -13,9 +13,9 @@
  */
=20
 #include "qemu/osdep.h"
-#include "sysemu/sysemu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "sysemu/runstate.h"
=20
 #include "hw/nvram/fw_cfg.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/misc/slavio_misc.c b/hw/misc/slavio_misc.c
index 7ef73506ae..279b38dfc7 100644
--- a/hw/misc/slavio_misc.c
+++ b/hw/misc/slavio_misc.c
@@ -23,11 +23,11 @@
  */
=20
 #include "qemu/osdep.h"
-#include "sysemu/sysemu.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
+#include "sysemu/runstate.h"
 #include "trace.h"
=20
 /*
diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index d4fdd2c26d..04adf618e5 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -16,9 +16,9 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/timer.h"
+#include "sysemu/runstate.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "sysemu/sysemu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 40e41fdd92..9b76f82db5 100644
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
+#include "sysemu/runstate.h"
=20
 #include "net_tx_pkt.h"
 #include "net_rx_pkt.h"
diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index c7bcd29e15..838082b451 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -31,6 +31,8 @@
=20
 #include "sysemu/block-backend.h"
 #include "sysemu/device_tree.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/nvram/chrp_nvram.h"
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 30e078763f..ceee463a11 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -46,7 +46,7 @@
 #include "hw/pci/pci_host.h"
 #include "migration/vmstate.h"
 #include "sysemu/reset.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "exec/address-spaces.h"
=20
 //#define DEBUG_BONITO
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 2e97bc0bdb..135c645535 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -37,7 +37,7 @@
 #include "migration/vmstate.h"
 #include "hw/pci-host/pam.h"
 #include "sysemu/reset.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "hw/i386/ioapic.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index a6520511b4..fae20ee97c 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -34,10 +34,10 @@
 #include "hw/irq.h"
 #include "hw/pci-bridge/simba.h"
 #include "hw/pci-host/sabre.h"
-#include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "sysemu/runstate.h"
 #include "trace.h"
=20
 /*
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 3b04484654..91cd4c26f9 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -28,6 +28,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "sysemu/reset.h"
+#include "sysemu/runstate.h"
 #include "kvm_ppc.h"
 #include "sysemu/device_tree.h"
 #include "hw/ppc/openpic.h"
diff --git a/hw/ppc/mpc8544_guts.c b/hw/ppc/mpc8544_guts.c
index ad9c219a8f..b96ea36f98 100644
--- a/hw/ppc/mpc8544_guts.c
+++ b/hw/ppc/mpc8544_guts.c
@@ -19,8 +19,8 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/module.h"
+#include "sysemu/runstate.h"
 #include "cpu.h"
-#include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
=20
 #define MPC8544_GUTS_MMIO_SIZE        0x1000
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index fc7d24830a..d95086fbbd 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -24,6 +24,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/numa.h"
 #include "sysemu/reset.h"
+#include "sysemu/runstate.h"
 #include "sysemu/cpus.h"
 #include "sysemu/device_tree.h"
 #include "target/ppc/cpu.h"
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index a28aca453d..7963feeab4 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -28,12 +28,12 @@
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc_e500.h"
 #include "qemu/timer.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/cpus.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
+#include "sysemu/runstate.h"
 #include "kvm_ppc.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
index ce0e1406e1..652a21b806 100644
--- a/hw/ppc/ppc_booke.c
+++ b/hw/ppc/ppc_booke.c
@@ -27,7 +27,7 @@
 #include "hw/ppc/ppc.h"
 #include "qemu/timer.h"
 #include "sysemu/reset.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "qemu/log.h"
 #include "hw/loader.h"
 #include "kvm_ppc.h"
diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
index 10f9725f41..86e83e278f 100644
--- a/hw/ppc/prep_systemio.c
+++ b/hw/ppc/prep_systemio.c
@@ -30,7 +30,7 @@
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h" /* for error_report() */
 #include "qemu/module.h"
-#include "sysemu/sysemu.h" /* for vm_stop() */
+#include "sysemu/runstate.h"
 #include "cpu.h"
 #include "trace.h"
=20
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4044e61a0c..4509df457d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -33,6 +33,7 @@
 #include "sysemu/numa.h"
 #include "sysemu/qtest.h"
 #include "sysemu/reset.h"
+#include "sysemu/runstate.h"
 #include "qemu/log.h"
 #include "hw/fw-path-provider.h"
 #include "elf.h"
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 53c973bdd1..163a6cd25b 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -28,8 +28,8 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/device_tree.h"
+#include "sysemu/runstate.h"
=20
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/spapr.h"
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 0f4e6b7120..225c60a9fc 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1,7 +1,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "sysemu/hw_accel.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 558d702833..d3f9a69a51 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -24,6 +24,7 @@
  * THE SOFTWARE.
  *
  */
+
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "qemu/log.h"
@@ -32,6 +33,7 @@
 #include "sysemu/device_tree.h"
 #include "sysemu/cpus.h"
 #include "sysemu/hw_accel.h"
+#include "sysemu/runstate.h"
 #include "kvm_ppc.h"
=20
 #include "hw/ppc/spapr.h"
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index e3a12173e3..3e36e13013 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -23,7 +23,6 @@
 #include "hw/qdev-properties.h"
 #include "cpu.h"
 #include "trace.h"
-#include "sysemu/sysemu.h"
 #include "monitor/monitor.h"
 #include "hw/rdma/rdma.h"
=20
@@ -34,6 +33,7 @@
 #include <infiniband/verbs.h>
 #include "pvrdma.h"
 #include "standard-headers/rdma/vmw_pvrdma-abi.h"
+#include "sysemu/runstate.h"
 #include "standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_a=
pi.h"
 #include "pvrdma_qp_ops.h"
=20
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 304063cbe0..ca544d64c5 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -15,6 +15,7 @@
 #include "qemu-common.h"
 #include "qapi/error.h"
 #include "sysemu/reset.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/tcg.h"
 #include "cpu.h"
diff --git a/hw/s390x/sclpquiesce.c b/hw/s390x/sclpquiesce.c
index f56273ca4b..ce07b16884 100644
--- a/hw/s390x/sclpquiesce.c
+++ b/hw/s390x/sclpquiesce.c
@@ -13,10 +13,10 @@
  */
=20
 #include "qemu/osdep.h"
-#include "sysemu/sysemu.h"
 #include "hw/s390x/sclp.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
+#include "sysemu/runstate.h"
 #include "hw/s390x/event-facility.h"
=20
 typedef struct SignalQuiesce {
diff --git a/hw/s390x/tod-kvm.c b/hw/s390x/tod-kvm.c
index bebe4744af..6e21d83181 100644
--- a/hw/s390x/tod-kvm.c
+++ b/hw/s390x/tod-kvm.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "hw/s390x/tod.h"
 #include "kvm_s390x.h"
=20
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index cb8e8d1f36..bccb7cc4c6 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -11,6 +11,7 @@
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "trace.h"
 #include "sysemu/dma.h"
 #include "qemu/cutils.h"
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index b421b3bc83..ee0840f380 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -30,6 +30,7 @@
 #include "hw/sysbus.h"
 #include "hw/sh4/sh.h"
 #include "sysemu/reset.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
 #include "hw/pci/pci.h"
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 267895b93e..6c5a17a020 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -36,6 +36,7 @@
 #include "hw/sparc/sparc32_dma.h"
 #include "hw/block/fdc.h"
 #include "sysemu/reset.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "net/net.h"
 #include "hw/boards.h"
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 08e12aa88b..1ded2a4c9a 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -42,6 +42,7 @@
 #include "hw/block/fdc.h"
 #include "net/net.h"
 #include "qemu/timer.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
 #include "hw/nvram/sun_nvram.h"
diff --git a/hw/timer/etraxfs_timer.c b/hw/timer/etraxfs_timer.c
index 739276ecb8..d62025b879 100644
--- a/hw/timer/etraxfs_timer.c
+++ b/hw/timer/etraxfs_timer.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "sysemu/reset.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
index 56f9dfa8dd..a9fc2f981a 100644
--- a/hw/timer/m48t59.c
+++ b/hw/timer/m48t59.c
@@ -29,6 +29,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/timer/m48t59.h"
 #include "qemu/timer.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
 #include "exec/address-spaces.h"
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 5aa584c080..26618842c9 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -33,6 +33,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/replay.h"
 #include "sysemu/reset.h"
+#include "sysemu/runstate.h"
 #include "hw/timer/mc146818rtc.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
diff --git a/hw/timer/milkymist-sysctl.c b/hw/timer/milkymist-sysctl.c
index a65c174c04..958350767a 100644
--- a/hw/timer/milkymist-sysctl.c
+++ b/hw/timer/milkymist-sysctl.c
@@ -25,9 +25,9 @@
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "sysemu/sysemu.h"
 #include "trace.h"
 #include "qemu/timer.h"
+#include "sysemu/runstate.h"
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index af7e4dbcbd..311cd38aac 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -11,7 +11,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "qemu/timer.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "hw/arm/pxa.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index e76c939751..9ca7b87a80 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -35,7 +35,7 @@
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
=20
 #define FRAME_TIMER_FREQ 1000
 #define FRAME_TIMER_NS   (NANOSECONDS_PER_SECOND / FRAME_TIMER_FREQ)
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 80fd1e9a80..472cc26fc4 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -45,6 +45,7 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
=20
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 8db2c68a1e..fc9fe0c00f 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -30,6 +30,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 8337af8434..dc3479c374 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -35,6 +35,7 @@
 #include "qemu/range.h"
 #include "qemu/units.h"
 #include "sysemu/kvm.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "pci.h"
 #include "trace.h"
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index c9c2414b7b..d1650e1dee 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -13,11 +13,12 @@
 #include "qapi/error.h"
 #include "qemu/iov.h"
 #include "qemu/module.h"
+#include "qemu/timer.h"
 #include "hw/virtio/virtio.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-rng.h"
 #include "sysemu/rng.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "qom/object_interfaces.h"
 #include "trace.h"
=20
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 0ce142bc04..527df03bfd 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -26,7 +26,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-access.h"
 #include "sysemu/dma.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
=20
 /*
  * The alignment to use between consumer and producer parts of vring.
diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
index dce7c1db14..0e98ffb73f 100644
--- a/hw/watchdog/watchdog.c
+++ b/hw/watchdog/watchdog.c
@@ -26,7 +26,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-run-state.h"
 #include "qapi/qapi-events-run-state.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "sysemu/watchdog.h"
 #include "hw/nmi.h"
 #include "qemu/help_option.h"
diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index 76621da2f5..5284b0dec1 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -14,7 +14,7 @@
 #include "hw/xen/xen-legacy-backend.h"
 #include "chardev/char.h"
 #include "sysemu/accel.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "migration/misc.h"
 #include "migration/global_state.h"
=20
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 62119d2555..8220c7a379 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -43,6 +43,7 @@
 #include "chardev/char.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/reset.h"
+#include "sysemu/runstate.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "bootparam.h"
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 721213d5b0..83f03cc577 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -15,7 +15,7 @@
=20
 #include <libfdt.h>
 #include "qom/object.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "hw/qdev-core.h"
 #include "qapi/error.h"
=20
diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
new file mode 100644
index 0000000000..0b41555609
--- /dev/null
+++ b/include/sysemu/runstate.h
@@ -0,0 +1,68 @@
+#ifndef SYSEMU_RUNSTATE_H
+#define SYSEMU_RUNSTATE_H
+
+#include "qapi/qapi-types-run-state.h"
+#include "qemu/notify.h"
+
+bool runstate_check(RunState state);
+void runstate_set(RunState new_state);
+int runstate_is_running(void);
+bool runstate_needs_reset(void);
+bool runstate_store(char *str, size_t size);
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
+static inline bool shutdown_caused_by_guest(ShutdownCause cause)
+{
+    return cause >=3D SHUTDOWN_CAUSE_GUEST_SHUTDOWN;
+}
+
+void vm_start(void);
+int vm_prepare_start(void);
+int vm_stop(RunState state);
+int vm_stop_force_state(RunState state);
+int vm_shutdown(void);
+
+typedef enum WakeupReason {
+    /* Always keep QEMU_WAKEUP_REASON_NONE =3D 0 */
+    QEMU_WAKEUP_REASON_NONE =3D 0,
+    QEMU_WAKEUP_REASON_RTC,
+    QEMU_WAKEUP_REASON_PMTIMER,
+    QEMU_WAKEUP_REASON_OTHER,
+} WakeupReason;
+
+void qemu_exit_preconfig_request(void);
+void qemu_system_reset_request(ShutdownCause reason);
+void qemu_system_suspend_request(void);
+void qemu_register_suspend_notifier(Notifier *notifier);
+bool qemu_wakeup_suspend_enabled(void);
+void qemu_system_wakeup_request(WakeupReason reason, Error **errp);
+void qemu_system_wakeup_enable(WakeupReason reason, bool enabled);
+void qemu_register_wakeup_notifier(Notifier *notifier);
+void qemu_register_wakeup_support(void);
+void qemu_system_shutdown_request(ShutdownCause reason);
+void qemu_system_powerdown_request(void);
+void qemu_register_powerdown_notifier(Notifier *notifier);
+void qemu_register_shutdown_notifier(Notifier *notifier);
+void qemu_system_debug_request(void);
+void qemu_system_vmstop_request(RunState reason);
+void qemu_system_vmstop_request_prepare(void);
+bool qemu_vmstop_requested(RunState *r);
+ShutdownCause qemu_shutdown_requested_get(void);
+ShutdownCause qemu_reset_requested_get(void);
+void qemu_system_killed(int signal, pid_t pid);
+void qemu_system_reset(ShutdownCause reason);
+void qemu_system_guest_panicked(GuestPanicInformation *info);
+
+#endif
+
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 7606eaaf2a..d2c38f611a 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -2,10 +2,8 @@
 #define SYSEMU_H
 /* Misc. things related to the system emulator.  */
=20
-#include "qapi/qapi-types-run-state.h"
 #include "qemu/timer.h"
 #include "qemu/notify.h"
-#include "qemu/bitmap.h"
 #include "qemu/uuid.h"
 #include "qom/object.h"
=20
@@ -17,65 +15,6 @@ extern const char *qemu_name;
 extern QemuUUID qemu_uuid;
 extern bool qemu_uuid_set;
=20
-bool runstate_check(RunState state);
-void runstate_set(RunState new_state);
-int runstate_is_running(void);
-bool runstate_needs_reset(void);
-bool runstate_store(char *str, size_t size);
-typedef void VMChangeStateHandler(void *opaque, int running, RunState st=
ate);
-
-VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandle=
r *cb,
-                                                     void *opaque);
-VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
-        VMChangeStateHandler *cb, void *opaque, int priority);
-VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
-                                                     VMChangeStateHandle=
r *cb,
-                                                     void *opaque);
-void qemu_del_vm_change_state_handler(VMChangeStateEntry *e);
-void vm_state_notify(int running, RunState state);
-
-static inline bool shutdown_caused_by_guest(ShutdownCause cause)
-{
-    return cause >=3D SHUTDOWN_CAUSE_GUEST_SHUTDOWN;
-}
-
-void vm_start(void);
-int vm_prepare_start(void);
-int vm_stop(RunState state);
-int vm_stop_force_state(RunState state);
-int vm_shutdown(void);
-
-typedef enum WakeupReason {
-    /* Always keep QEMU_WAKEUP_REASON_NONE =3D 0 */
-    QEMU_WAKEUP_REASON_NONE =3D 0,
-    QEMU_WAKEUP_REASON_RTC,
-    QEMU_WAKEUP_REASON_PMTIMER,
-    QEMU_WAKEUP_REASON_OTHER,
-} WakeupReason;
-
-void qemu_exit_preconfig_request(void);
-void qemu_system_reset_request(ShutdownCause reason);
-void qemu_system_suspend_request(void);
-void qemu_register_suspend_notifier(Notifier *notifier);
-bool qemu_wakeup_suspend_enabled(void);
-void qemu_system_wakeup_request(WakeupReason reason, Error **errp);
-void qemu_system_wakeup_enable(WakeupReason reason, bool enabled);
-void qemu_register_wakeup_notifier(Notifier *notifier);
-void qemu_register_wakeup_support(void);
-void qemu_system_shutdown_request(ShutdownCause reason);
-void qemu_system_powerdown_request(void);
-void qemu_register_powerdown_notifier(Notifier *notifier);
-void qemu_register_shutdown_notifier(Notifier *notifier);
-void qemu_system_debug_request(void);
-void qemu_system_vmstop_request(RunState reason);
-void qemu_system_vmstop_request_prepare(void);
-bool qemu_vmstop_requested(RunState *r);
-ShutdownCause qemu_shutdown_requested_get(void);
-ShutdownCause qemu_reset_requested_get(void);
-void qemu_system_killed(int signal, pid_t pid);
-void qemu_system_reset(ShutdownCause reason);
-void qemu_system_guest_panicked(GuestPanicInformation *info);
-
 void qemu_add_exit_notifier(Notifier *notify);
 void qemu_remove_exit_notifier(Notifier *notify);
=20
diff --git a/memory.c b/memory.c
index c3486b0f28..8141486832 100644
--- a/memory.c
+++ b/memory.c
@@ -29,7 +29,7 @@
 #include "exec/memory-internal.h"
 #include "exec/ram_addr.h"
 #include "sysemu/kvm.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "sysemu/tcg.h"
 #include "sysemu/accel.h"
 #include "hw/boards.h"
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitma=
p.c
index 4a896a09eb..a09a893c02 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -62,6 +62,7 @@
 #include "block/block.h"
 #include "block/block_int.h"
 #include "sysemu/block-backend.h"
+#include "sysemu/runstate.h"
 #include "qemu/main-loop.h"
 #include "qemu/error-report.h"
 #include "migration/misc.h"
@@ -70,7 +71,6 @@
 #include "migration/vmstate.h"
 #include "migration/register.h"
 #include "qemu/hbitmap.h"
-#include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "trace.h"
diff --git a/migration/colo.c b/migration/colo.c
index 0602e6bbe4..2c88aa57a2 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -35,6 +35,7 @@
 #include "qapi/qapi-events-migration.h"
 #include "qapi/qmp/qerror.h"
 #include "sysemu/cpus.h"
+#include "sysemu/runstate.h"
 #include "net/filter.h"
=20
 static bool vmstate_loading;
diff --git a/migration/global_state.c b/migration/global_state.c
index 7cba868979..25311479a4 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "qapi/error.h"
 #include "migration.h"
 #include "migration/global_state.h"
diff --git a/migration/migration.c b/migration/migration.c
index 2986b8b164..c1600c395f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -21,6 +21,7 @@
 #include "exec.h"
 #include "fd.h"
 #include "socket.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "rdma.h"
 #include "ram.h"
diff --git a/migration/savevm.c b/migration/savevm.c
index 33da39f0ea..fd3c39dc39 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -57,6 +57,7 @@
 #include "io/channel-buffer.h"
 #include "io/channel-file.h"
 #include "sysemu/replay.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "qjson.h"
 #include "migration/colo.h"
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 5ca3ebe942..5ed82387ea 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -19,7 +19,7 @@
 #include "net/eth.h"
 #include "chardev/char.h"
 #include "sysemu/block-backend.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "qemu/timer.h"
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 5223661e82..8942e28933 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -35,7 +35,7 @@
 #include "qemu/option.h"
 #include "qemu/units.h"
 #include "sysemu/block-backend.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "trace.h"
=20
 static void monitor_command_cb(void *opaque, const char *cmdline,
diff --git a/monitor/misc.c b/monitor/misc.c
index 117a172928..d229e65450 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -44,6 +44,7 @@
 #include "sysemu/balloon.h"
 #include "qemu/timer.h"
 #include "sysemu/hw_accel.h"
+#include "sysemu/runstate.h"
 #include "authz/list.h"
 #include "qapi/util.h"
 #include "sysemu/blockdev.h"
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 330558f332..0880341a2d 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -26,6 +26,7 @@
 #include "ui/qemu-spice.h"
 #include "ui/vnc.h"
 #include "sysemu/kvm.h"
+#include "sysemu/runstate.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/block-backend.h"
diff --git a/net/net.c b/net/net.c
index 11b505a6fd..84aa6d8d00 100644
--- a/net/net.c
+++ b/net/net.c
@@ -50,6 +50,8 @@
 #include "qapi/opts-visitor.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
+#include "sysemu/runstate.h"
+#include "sysemu/sysemu.h"
 #include "net/filter.h"
 #include "qapi/string-output-visitor.h"
=20
diff --git a/os-posix.c b/os-posix.c
index 3ba7df8d75..86cffd2c7d 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -31,11 +31,11 @@
=20
 #include "qemu-common.h"
 /* Needed early for CONFIG_BSD etc. */
-#include "sysemu/sysemu.h"
 #include "net/slirp.h"
 #include "qemu-options.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
+#include "sysemu/runstate.h"
 #include "qemu/cutils.h"
=20
 #ifdef CONFIG_LINUX
diff --git a/os-win32.c b/os-win32.c
index 6d92189810..1336cd34f0 100644
--- a/os-win32.c
+++ b/os-win32.c
@@ -27,8 +27,8 @@
 #include <windows.h>
 #include <mmsystem.h>
 #include "qemu-common.h"
-#include "sysemu/sysemu.h"
 #include "qemu-options.h"
+#include "sysemu/runstate.h"
=20
 /***********************************************************/
 /* Functions missing in mingw */
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index e2c366e09e..3037d353a4 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -16,8 +16,8 @@
 #include "qapi/qmp/dispatch.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
+#include "sysemu/runstate.h"
 #include "qapi/qmp/qbool.h"
-#include "sysemu/sysemu.h"
=20
 static QDict *qmp_dispatch_check_obj(const QObject *request, bool allow_=
oob,
                                      Error **errp)
diff --git a/qtest.c b/qtest.c
index 313821faed..9d0c864d6b 100644
--- a/qtest.c
+++ b/qtest.c
@@ -15,12 +15,12 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "sysemu/qtest.h"
+#include "sysemu/runstate.h"
 #include "chardev/char-fe.h"
 #include "exec/ioport.h"
 #include "exec/memory.h"
 #include "hw/irq.h"
 #include "sysemu/accel.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/cpus.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index 9f7a76ca32..c013b23820 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -11,10 +11,10 @@
=20
 #include "qemu/osdep.h"
 #include "sysemu/replay.h"
+#include "sysemu/runstate.h"
 #include "replay-internal.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
-#include "sysemu/sysemu.h"
=20
 /* Mutex to protect reading and writing events to the log.
    data_kind and has_unread_data are also protected
diff --git a/replay/replay.c b/replay/replay.c
index 8b172b2d1b..0c4e9c1318 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -12,12 +12,12 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "sysemu/replay.h"
+#include "sysemu/runstate.h"
 #include "replay-internal.h"
 #include "qemu/timer.h"
 #include "qemu/main-loop.h"
 #include "qemu/option.h"
 #include "sysemu/cpus.h"
-#include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
=20
 /* Current version of the replay mechanism.
diff --git a/stubs/change-state-handler.c b/stubs/change-state-handler.c
index d14194b36b..d1ed46bfb0 100644
--- a/stubs/change-state-handler.c
+++ b/stubs/change-state-handler.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
=20
 VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandle=
r *cb,
                                                      void *opaque)
diff --git a/stubs/runstate-check.c b/stubs/runstate-check.c
index 7c5227e848..2ccda2b70f 100644
--- a/stubs/runstate-check.c
+++ b/stubs/runstate-check.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
-#include "sysemu/sysemu.h"
=20
+#include "sysemu/runstate.h"
 bool runstate_check(RunState state)
 {
     return state =3D=3D RUN_STATE_PRELAUNCH;
diff --git a/stubs/vm-stop.c b/stubs/vm-stop.c
index 68e5f20eaf..7f8a9da8a5 100644
--- a/stubs/vm-stop.c
+++ b/stubs/vm-stop.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
-#include "sysemu/sysemu.h"
=20
+#include "sysemu/runstate.h"
 void qemu_system_vmstop_request_prepare(void)
 {
     abort();
diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
index f9c34b1144..39229236e1 100644
--- a/target/alpha/sys_helper.c
+++ b/target/alpha/sys_helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "qemu/timer.h"
=20
diff --git a/target/arm/psci.c b/target/arm/psci.c
index af1d5a551e..6709e28013 100644
--- a/target/arm/psci.c
+++ b/target/arm/psci.c
@@ -21,7 +21,7 @@
 #include "exec/helper-proto.h"
 #include "kvm-consts.h"
 #include "qemu/main-loop.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "internals.h"
 #include "arm-powerctl.h"
=20
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 04d23c1b22..df0f1361ef 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -22,8 +22,8 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
-#include "sysemu/sysemu.h"
 #include "qemu/timer.h"
+#include "sysemu/runstate.h"
 #include "fpu/softfloat.h"
 #include "trace.h"
=20
diff --git a/target/i386/excp_helper.c b/target/i386/excp_helper.c
index a9bca7c28b..1447bda7a9 100644
--- a/target/i386/excp_helper.c
+++ b/target/i386/excp_helper.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "qemu/log.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "exec/helper-proto.h"
=20
 void helper_raise_interrupt(CPUX86State *env, int intno, int next_eip_ad=
dend)
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index bcacdd1d8f..a8b6e5aeb8 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -31,7 +31,7 @@
 #include "hax-i386.h"
 #include "sysemu/accel.h"
 #include "sysemu/reset.h"
-#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "qemu/main-loop.h"
 #include "hw/boards.h"
=20
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 23024926ac..0fa51be646 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -22,9 +22,9 @@
 #include "exec/exec-all.h"
 #include "qemu/qemu-print.h"
 #include "sysemu/kvm.h"
+#include "sysemu/runstate.h"
 #include "kvm_i386.h"
 #ifndef CONFIG_USER_ONLY
-#include "sysemu/sysemu.h"
 #include "sysemu/tcg.h"
 #include "sysemu/hw_accel.h"
 #include "monitor/monitor.h"
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 6863cf2de4..231732aaf7 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -45,11 +45,13 @@
  * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY O=
F
  * SUCH DAMAGE.
  */
+
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/error-report.h"
=20
 #include "sysemu/hvf.h"
+#include "sysemu/runstate.h"
 #include "hvf-i386.h"
 #include "vmcs.h"
 #include "vmx.h"
@@ -68,7 +70,6 @@
 #include "hw/i386/apic_internal.h"
 #include "qemu/main-loop.h"
 #include "sysemu/accel.h"
-#include "sysemu/sysemu.h"
 #include "target/i386/cpu.h"
=20
 HVFState *hvf_state;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index fd55fb55e9..2abc881324 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -25,6 +25,7 @@
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm_int.h"
 #include "sysemu/reset.h"
+#include "sysemu/runstate.h"
 #include "kvm_i386.h"
 #include "hyperv.h"
 #include "hyperv-proto.h"
diff --git a/target/i386/sev.c b/target/i386/sev.c
index f1423cb0c0..024bb24e51 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -25,6 +25,7 @@
 #include "sysemu/kvm.h"
 #include "sev_i386.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "trace.h"
 #include "migration/blocker.h"
=20
diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index b57d1c6683..0c15241ae4 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -15,8 +15,8 @@
 #include "qemu-common.h"
 #include "sysemu/accel.h"
 #include "sysemu/whpx.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/cpus.h"
+#include "sysemu/runstate.h"
 #include "qemu/main-loop.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
diff --git a/target/lm32/op_helper.c b/target/lm32/op_helper.c
index 99ca76c04f..e39fcd5647 100644
--- a/target/lm32/op_helper.c
+++ b/target/lm32/op_helper.c
@@ -3,6 +3,7 @@
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 #include "qemu/main-loop.h"
+#include "sysemu/runstate.h"
=20
 #include "hw/lm32/lm32_pic.h"
 #include "hw/char/lm32_juart.h"
@@ -11,7 +12,6 @@
 #include "exec/cpu_ldst.h"
=20
 #ifndef CONFIG_USER_ONLY
-#include "sysemu/sysemu.h"
 #endif
=20
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 83ee0026ac..578bc14625 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -20,8 +20,8 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/timer.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
+#include "sysemu/runstate.h"
 #include "sysemu/cpus.h"
 #include "kvm_mips.h"
 #include "exec/memattrs.h"
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 13ae9909ad..1350ad319a 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -26,8 +26,8 @@
 #include "qemu/qemu-print.h"
 #include "hw/s390x/ioinst.h"
 #include "sysemu/hw_accel.h"
+#include "sysemu/runstate.h"
 #ifndef CONFIG_USER_ONLY
-#include "sysemu/sysemu.h"
 #include "sysemu/tcg.h"
 #endif
=20
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 55d1a14588..cea71ac7c3 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -37,6 +37,7 @@
 #include "qemu/log.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/hw_accel.h"
+#include "sysemu/runstate.h"
 #include "sysemu/device_tree.h"
 #include "exec/gdbstub.h"
 #include "exec/ram_addr.h"
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index 8348b7035e..2ce22d4dc1 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -12,9 +12,9 @@
 #include "cpu.h"
 #include "internal.h"
 #include "sysemu/hw_accel.h"
+#include "sysemu/runstate.h"
 #include "exec/address-spaces.h"
 #include "exec/exec-all.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/tcg.h"
 #include "trace.h"
 #include "qapi/qapi-types-machine.h"
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 2afc1770d8..408478ce5d 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -16,15 +16,16 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
+
 #include "qemu/osdep.h"
=20
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/log.h"
-#include "sysemu/sysemu.h"
=20
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/sh4/sh_intc.h"
+#include "sysemu/runstate.h"
 #endif
=20
 #define MMU_OK                   0
diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index c7724928c0..813b47dbb2 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -20,8 +20,8 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "trace.h"
-#include "sysemu/sysemu.h"
 #include "exec/log.h"
+#include "sysemu/runstate.h"
=20
 #define DEBUG_PCALL
=20
diff --git a/ui/gtk.c b/ui/gtk.c
index ad6963d4f5..2f23922afc 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -47,6 +47,7 @@
=20
 #include "trace.h"
 #include "ui/input.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "keymaps.h"
 #include "chardev/char.h"
diff --git a/ui/input.c b/ui/input.c
index 9494688295..4791b089c7 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -8,6 +8,7 @@
 #include "ui/input.h"
 #include "ui/console.h"
 #include "sysemu/replay.h"
+#include "sysemu/runstate.h"
=20
 struct QemuInputHandlerState {
     DeviceState       *dev;
diff --git a/ui/sdl2.c b/ui/sdl2.c
index b8a31197e8..bd4e73661d 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -28,6 +28,7 @@
 #include "ui/console.h"
 #include "ui/input.h"
 #include "ui/sdl2.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
=20
 static int sdl2_num_outputs;
diff --git a/ui/spice-core.c b/ui/spice-core.c
index a395d7ccd4..ecc2ec2c55 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -19,7 +19,7 @@
 #include <spice.h>
=20
 #include "sysemu/sysemu.h"
-
+#include "sysemu/runstate.h"
 #include "ui/qemu-spice.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
diff --git a/vl.c b/vl.c
index 9dbbce4ce3..7617455ce4 100644
--- a/vl.c
+++ b/vl.c
@@ -32,6 +32,7 @@
 #include "qemu/help_option.h"
 #include "qemu/uuid.h"
 #include "sysemu/reset.h"
+#include "sysemu/runstate.h"
 #include "sysemu/seccomp.h"
 #include "sysemu/tcg.h"
=20
--=20
2.21.0


