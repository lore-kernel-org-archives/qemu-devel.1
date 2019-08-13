Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5C3C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:55:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6BF120578
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BF120578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxZ8X-0002vc-W2
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 11:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52494)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hxZ1A-0004So-2T
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hxZ14-0002Yn-MV
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:47:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56666)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hxZ14-0002YI-Bm
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:47:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A7E2E308449A;
 Tue, 13 Aug 2019 15:47:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 97DF2347FC;
 Tue, 13 Aug 2019 15:47:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F3B31113306B; Tue, 13 Aug 2019 17:46:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 13 Aug 2019 17:46:50 +0200
Message-Id: <20190813154653.20568-27-armbru@redhat.com>
In-Reply-To: <20190813154653.20568-1-armbru@redhat.com>
References: <20190813154653.20568-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 13 Aug 2019 15:47:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 26/29] Clean up inclusion of sysemu/sysemu.h
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In my "build everything" tree, changing sysemu/sysemu.h triggers a
recompile of some 5400 out of 6600 objects (not counting tests and
objects that don't depend on qemu/osdep.h).

Almost a third of its inclusions are actually superfluous.  Delete
them.  Downgrade two more to qapi/qapi-types-run-state.h, and move one
from char/serial.h to char/serial.c.

hw/semihosting/config.c, monitor/monitor.c, qdev-monitor.c, and
stubs/semihost.c define variables declared in sysemu/sysemu.h without
including it.  The compiler is cool with that, but include it anyway.

This doesn't reduce actual use much, as it's still included into
widely included headers.  The next commit will tackle that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20190812052359.30071-27-armbru@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 hw/usb/hcd-ehci.h                   | 1 -
 include/hw/arm/allwinner-a10.h      | 1 -
 include/hw/char/serial.h            | 1 -
 include/hw/i386/pc.h                | 1 -
 include/hw/riscv/riscv_htif.h       | 1 -
 include/hw/timer/stm32f2xx_timer.h  | 1 -
 include/hw/virtio/virtio-bus.h      | 1 -
 include/hw/xen/xen-legacy-backend.h | 1 -
 include/migration/global_state.h    | 2 +-
 include/sysemu/kvm_int.h            | 1 -
 include/sysemu/replay.h             | 2 +-
 include/ui/spice-display.h          | 1 -
 accel/tcg/tcg-all.c                 | 1 -
 block/nfs.c                         | 1 -
 blockdev-nbd.c                      | 1 -
 dump/win_dump.c                     | 1 -
 hw/acpi/pcihp.c                     | 1 -
 hw/acpi/vmgenid.c                   | 1 -
 hw/alpha/pci.c                      | 1 -
 hw/alpha/typhoon.c                  | 1 -
 hw/arm/nrf51_soc.c                  | 1 -
 hw/arm/smmu-common.c                | 1 -
 hw/arm/smmuv3.c                     | 1 -
 hw/arm/sysbus-fdt.c                 | 1 -
 hw/arm/z2.c                         | 1 -
 hw/char/exynos4210_uart.c           | 1 -
 hw/char/imx_serial.c                | 1 -
 hw/char/serial.c                    | 1 +
 hw/core/loader-fit.c                | 1 -
 hw/core/platform-bus.c              | 1 -
 hw/core/qdev.c                      | 1 -
 hw/display/ramfb-standalone.c       | 1 -
 hw/display/ramfb.c                  | 1 -
 hw/dma/xlnx-zynq-devcfg.c           | 1 -
 hw/hppa/dino.c                      | 1 -
 hw/hppa/pci.c                       | 1 -
 hw/i2c/smbus_ich9.c                 | 1 -
 hw/ide/cmd646.c                     | 1 -
 hw/ide/ioport.c                     | 1 -
 hw/ide/piix.c                       | 1 -
 hw/ide/via.c                        | 1 -
 hw/input/adb-kbd.c                  | 1 -
 hw/intc/allwinner-a10-pic.c         | 1 -
 hw/intc/mips_gic.c                  | 1 -
 hw/intc/xics_pnv.c                  | 1 -
 hw/ipmi/ipmi_bmc_extern.c           | 1 -
 hw/isa/vt82c686.c                   | 1 -
 hw/misc/armsse-cpuid.c              | 1 -
 hw/misc/armsse-mhu.c                | 1 -
 hw/misc/imx6_src.c                  | 1 -
 hw/misc/imx7_gpr.c                  | 1 -
 hw/misc/iotkit-sysinfo.c            | 1 -
 hw/misc/mips_cmgcr.c                | 1 -
 hw/misc/mos6522.c                   | 1 -
 hw/misc/sga.c                       | 1 -
 hw/misc/zynq-xadc.c                 | 1 -
 hw/net/fsl_etsec/etsec.c            | 1 -
 hw/net/lan9118.c                    | 1 -
 hw/net/ne2000.c                     | 1 -
 hw/net/opencores_eth.c              | 1 -
 hw/net/pcnet.c                      | 1 -
 hw/nios2/generic_nommu.c            | 1 -
 hw/pci-host/pam.c                   | 1 -
 hw/ppc/pnv_bmc.c                    | 1 -
 hw/ppc/pnv_core.c                   | 1 -
 hw/ppc/pnv_lpc.c                    | 1 -
 hw/ppc/pnv_occ.c                    | 1 -
 hw/ppc/ppce500_spin.c               | 1 -
 hw/ppc/spapr_rng.c                  | 1 -
 hw/ppc/spapr_vio.c                  | 1 -
 hw/s390x/event-facility.c           | 1 -
 hw/s390x/sclpcpu.c                  | 1 -
 hw/s390x/virtio-ccw.c               | 1 -
 hw/scsi/scsi-disk.c                 | 1 -
 hw/sd/milkymist-memcard.c           | 1 -
 hw/semihosting/config.c             | 1 +
 hw/ssi/aspeed_smc.c                 | 1 -
 hw/ssi/imx_spi.c                    | 1 -
 hw/ssi/xilinx_spi.c                 | 1 -
 hw/ssi/xilinx_spips.c               | 1 -
 hw/timer/allwinner-a10-pit.c        | 1 -
 hw/timer/altera_timer.c             | 1 -
 hw/timer/exynos4210_rtc.c           | 1 -
 hw/tricore/tricore_testboard.c      | 1 -
 hw/vfio/ap.c                        | 1 -
 hw/vfio/platform.c                  | 1 -
 hw/xen/xen_pt_load_rom.c            | 1 -
 hw/xtensa/xtensa_memory.c           | 1 -
 monitor/monitor.c                   | 1 +
 net/tap-bsd.c                       | 1 -
 net/tap-linux.c                     | 1 -
 net/tap-solaris.c                   | 1 -
 net/tap-win32.c                     | 1 -
 qdev-monitor.c                      | 1 +
 qemu-img.c                          | 1 -
 qom/cpu.c                           | 1 -
 replay/replay-audio.c               | 1 -
 replay/replay-char.c                | 1 -
 replay/replay-net.c                 | 1 -
 replay/replay-snapshot.c            | 1 -
 stubs/replay.c                      | 1 -
 stubs/semihost.c                    | 1 +
 target/arm/cpu64.c                  | 1 -
 target/arm/helper-a64.c             | 1 -
 target/arm/helper.c                 | 1 -
 target/arm/kvm32.c                  | 1 -
 target/arm/kvm64.c                  | 1 -
 target/arm/m_helper.c               | 1 -
 target/i386/hvf/x86_task.c          | 1 -
 target/lm32/helper.c                | 1 -
 target/m68k/m68k-semi.c             | 1 -
 target/nios2/nios2-semi.c           | 1 -
 target/ppc/kvm.c                    | 1 -
 target/sparc/helper.c               | 1 -
 target/xtensa/translate.c           | 1 -
 target/xtensa/xtensa-semi.c         | 1 -
 tests/migration-test.c              | 1 -
 ui/input-keymap.c                   | 1 -
 ui/input-legacy.c                   | 1 -
 ui/input-linux.c                    | 1 -
 ui/keymaps.c                        | 1 -
 ui/sdl2-2d.c                        | 1 -
 ui/sdl2-gl.c                        | 1 -
 ui/sdl2-input.c                     | 1 -
 ui/spice-display.c                  | 1 -
 util/qemu-timer.c                   | 1 -
 126 files changed, 7 insertions(+), 121 deletions(-)

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
diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a1=
0.h
index 101b72a71d..7d2d215630 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -9,7 +9,6 @@
 #include "hw/net/allwinner_emac.h"
 #include "hw/ide/ahci.h"
=20
-#include "sysemu/sysemu.h"
 #include "target/arm/cpu.h"
=20
=20
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index bfcbbb6e19..8be3d8a4f9 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -26,7 +26,6 @@
 #ifndef HW_SERIAL_H
 #define HW_SERIAL_H
=20
-#include "sysemu/sysemu.h"
 #include "chardev/char-fe.h"
 #include "exec/memory.h"
 #include "qemu/fifo8.h"
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 859b64c51d..4bb9e29114 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -12,7 +12,6 @@
 #include "qemu/range.h"
 #include "qemu/bitmap.h"
 #include "qemu/module.h"
-#include "sysemu/sysemu.h"
 #include "hw/pci/pci.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
diff --git a/include/hw/riscv/riscv_htif.h b/include/hw/riscv/riscv_htif.=
h
index aabc059f32..fb9452cf51 100644
--- a/include/hw/riscv/riscv_htif.h
+++ b/include/hw/riscv/riscv_htif.h
@@ -22,7 +22,6 @@
=20
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
-#include "sysemu/sysemu.h"
 #include "exec/memory.h"
 #include "target/riscv/cpu.h"
=20
diff --git a/include/hw/timer/stm32f2xx_timer.h b/include/hw/timer/stm32f=
2xx_timer.h
index e6a83237a5..a96bc08b1b 100644
--- a/include/hw/timer/stm32f2xx_timer.h
+++ b/include/hw/timer/stm32f2xx_timer.h
@@ -27,7 +27,6 @@
=20
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
-#include "sysemu/sysemu.h"
=20
 #define TIM_CR1      0x00
 #define TIM_CR2      0x04
diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bu=
s.h
index 8c9cc25b16..38c9399cd4 100644
--- a/include/hw/virtio/virtio-bus.h
+++ b/include/hw/virtio/virtio-bus.h
@@ -25,7 +25,6 @@
 #ifndef VIRTIO_BUS_H
 #define VIRTIO_BUS_H
=20
-#include "sysemu/sysemu.h"
 #include "hw/qdev-core.h"
 #include "hw/virtio/virtio.h"
=20
diff --git a/include/hw/xen/xen-legacy-backend.h b/include/hw/xen/xen-leg=
acy-backend.h
index 07d4176ac1..5e6c56c4d6 100644
--- a/include/hw/xen/xen-legacy-backend.h
+++ b/include/hw/xen/xen-legacy-backend.h
@@ -3,7 +3,6 @@
=20
 #include "hw/xen/xen_common.h"
 #include "hw/xen/xen_pvdev.h"
-#include "sysemu/sysemu.h"
 #include "net/net.h"
=20
 #define TYPE_XENSYSDEV "xen-sysdev"
diff --git a/include/migration/global_state.h b/include/migration/global_=
state.h
index d307de8350..945eb35d5b 100644
--- a/include/migration/global_state.h
+++ b/include/migration/global_state.h
@@ -13,7 +13,7 @@
 #ifndef QEMU_MIGRATION_GLOBAL_STATE_H
 #define QEMU_MIGRATION_GLOBAL_STATE_H
=20
-#include "sysemu/sysemu.h"
+#include "qapi/qapi-types-run-state.h"
=20
 void register_global_state(void);
 int global_state_store(void);
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 5d341cc29b..72b2d1b3ae 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -10,7 +10,6 @@
 #define QEMU_KVM_INT_H
=20
 #include "exec/memory.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/accel.h"
 #include "sysemu/kvm.h"
=20
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 3a7c58e423..2f2ccdbc98 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -12,8 +12,8 @@
  *
  */
=20
-#include "sysemu.h"
 #include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-types-run-state.h"
 #include "qapi/qapi-types-ui.h"
=20
 /* replay clock kinds */
diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
index 58bb5b4c53..4a47ffdd4c 100644
--- a/include/ui/spice-display.h
+++ b/include/ui/spice-display.h
@@ -26,7 +26,6 @@
 #include "qemu/thread.h"
 #include "ui/qemu-pixman.h"
 #include "ui/console.h"
-#include "sysemu/sysemu.h"
=20
 #if defined(CONFIG_OPENGL_DMABUF)
 # if SPICE_SERVER_VERSION >=3D 0x000d01 /* release 0.13.1 */
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index c92d4c82ed..c59d5b0024 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -25,7 +25,6 @@
=20
 #include "qemu/osdep.h"
 #include "sysemu/accel.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/tcg.h"
 #include "qom/object.h"
 #include "cpu.h"
diff --git a/block/nfs.c b/block/nfs.c
index a1fe004c61..ed0cce63bb 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -37,7 +37,6 @@
 #include "qemu/option.h"
 #include "qemu/uri.h"
 #include "qemu/cutils.h"
-#include "sysemu/sysemu.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 66eebab318..7a71da447f 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -15,7 +15,6 @@
 #include "hw/block/block.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-block.h"
-#include "sysemu/sysemu.h"
 #include "block/nbd.h"
 #include "io/channel-socket.h"
 #include "io/net-listener.h"
diff --git a/dump/win_dump.c b/dump/win_dump.c
index 0142655d3d..eda2a48974 100644
--- a/dump/win_dump.c
+++ b/dump/win_dump.c
@@ -17,7 +17,6 @@
 #include "monitor/monitor.h"
 #include "sysemu/kvm.h"
 #include "sysemu/dump.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/memory_mapping.h"
 #include "sysemu/cpus.h"
 #include "qapi/error.h"
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index ac49a5a77b..82d295b6e8 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -31,7 +31,6 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/acpi/acpi.h"
-#include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
 #include "hw/pci/pci_bus.h"
 #include "migration/vmstate.h"
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index 4eae426969..6e11b0fa9b 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -21,7 +21,6 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "sysemu/reset.h"
-#include "sysemu/sysemu.h"
=20
 void vmgenid_build_acpi(VmGenIdState *vms, GArray *table_data, GArray *g=
uid,
                         BIOSLinker *linker)
diff --git a/hw/alpha/pci.c b/hw/alpha/pci.c
index fb902bb92d..72251fcdf0 100644
--- a/hw/alpha/pci.c
+++ b/hw/alpha/pci.c
@@ -9,7 +9,6 @@
 #include "qemu/osdep.h"
 #include "alpha_sys.h"
 #include "qemu/log.h"
-#include "sysemu/sysemu.h"
 #include "trace.h"
=20
=20
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 1c0565acc1..179e1f7658 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -13,7 +13,6 @@
 #include "cpu.h"
 #include "hw/boards.h"
 #include "hw/irq.h"
-#include "sysemu/sysemu.h"
 #include "alpha_sys.h"
 #include "exec/address-spaces.h"
=20
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index d9e54fefbb..74029169d0 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -14,7 +14,6 @@
 #include "hw/sysbus.h"
 #include "hw/misc/unimp.h"
 #include "exec/address-spaces.h"
-#include "sysemu/sysemu.h"
 #include "qemu/log.h"
 #include "cpu.h"
=20
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 717d22bcbe..956ebe32c8 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -17,7 +17,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
 #include "trace.h"
 #include "exec/target_page.h"
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 0ccc772390..2eaf07fb5f 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -18,7 +18,6 @@
=20
 #include "qemu/osdep.h"
 #include "hw/irq.h"
-#include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/qdev-core.h"
diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
index 57f94e6581..022fc97ecd 100644
--- a/hw/arm/sysbus-fdt.c
+++ b/hw/arm/sysbus-fdt.c
@@ -31,7 +31,6 @@
 #include "qemu/error-report.h"
 #include "sysemu/device_tree.h"
 #include "hw/platform-bus.h"
-#include "sysemu/sysemu.h"
 #include "hw/vfio/vfio-platform.h"
 #include "hw/vfio/vfio-calxeda-xgmac.h"
 #include "hw/vfio/vfio-amd-xgbe.h"
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index 1e3db425ef..3923b87e4c 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -19,7 +19,6 @@
 #include "hw/ssi/ssi.h"
 #include "migration/vmstate.h"
 #include "hw/boards.h"
-#include "sysemu/sysemu.h"
 #include "hw/block/flash.h"
 #include "ui/console.h"
 #include "hw/audio/wm8750.h"
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 49e279d5df..d6b6b62366 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -24,7 +24,6 @@
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
-#include "sysemu/sysemu.h"
 #include "chardev/char-fe.h"
 #include "chardev/char-serial.h"
=20
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index e49baa994c..fddde9b43d 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -23,7 +23,6 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
-#include "sysemu/sysemu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 4d54163a62..72580f19d0 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -31,6 +31,7 @@
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "sysemu/reset.h"
+#include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
 #include "trace.h"
=20
diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
index f27b6af942..953b16bc82 100644
--- a/hw/core/loader-fit.c
+++ b/hw/core/loader-fit.c
@@ -26,7 +26,6 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "sysemu/device_tree.h"
-#include "sysemu/sysemu.h"
=20
 #include <libfdt.h>
 #include <zlib.h>
diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index 9c9a9c271f..edb0da1de8 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -24,7 +24,6 @@
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
-#include "sysemu/sysemu.h"
=20
=20
 /*
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 8c055df1cb..60d66c2f39 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -26,7 +26,6 @@
    this API directly.  */
=20
 #include "qemu/osdep.h"
-#include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-qdev.h"
 #include "qapi/qmp/qerror.h"
diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.=
c
index ebd623a669..1f72450303 100644
--- a/hw/display/ramfb-standalone.c
+++ b/hw/display/ramfb-standalone.c
@@ -6,7 +6,6 @@
 #include "hw/isa/isa.h"
 #include "hw/display/ramfb.h"
 #include "ui/console.h"
-#include "sysemu/sysemu.h"
=20
 #define RAMFB(obj) OBJECT_CHECK(RAMFBStandaloneState, (obj), TYPE_RAMFB_=
DEVICE)
=20
diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index 6026a35b11..cd94940223 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -18,7 +18,6 @@
 #include "hw/display/ramfb.h"
 #include "ui/console.h"
 #include "sysemu/reset.h"
-#include "sysemu/sysemu.h"
=20
 struct QEMU_PACKED RAMFBCfg {
     uint64_t addr;
diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index 89200ff15d..e33112b6f0 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -29,7 +29,6 @@
 #include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "qemu/bitops.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/dma.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index bb9d0e033c..e0466ee055 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -16,7 +16,6 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/irq.h"
-#include "sysemu/sysemu.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
 #include "migration/vmstate.h"
diff --git a/hw/hppa/pci.c b/hw/hppa/pci.c
index b6606d9719..32609aba63 100644
--- a/hw/hppa/pci.c
+++ b/hw/hppa/pci.c
@@ -6,7 +6,6 @@
 #include "qemu/osdep.h"
 #include "hppa_sys.h"
 #include "qemu/log.h"
-#include "sysemu/sysemu.h"
 #include "trace.h"
=20
=20
diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
index 564198dae9..fd50fb851a 100644
--- a/hw/i2c/smbus_ich9.c
+++ b/hw/i2c/smbus_ich9.c
@@ -25,7 +25,6 @@
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
-#include "sysemu/sysemu.h"
=20
 #include "hw/i386/ich9.h"
=20
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 3fbfc5ea45..f3ccd11c79 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -29,7 +29,6 @@
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "hw/isa/isa.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/dma.h"
 #include "sysemu/reset.h"
=20
diff --git a/hw/ide/ioport.c b/hw/ide/ioport.c
index e6085612d4..ab1f4e5d9c 100644
--- a/hw/ide/ioport.c
+++ b/hw/ide/ioport.c
@@ -27,7 +27,6 @@
 #include "hw/isa/isa.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/dma.h"
 #include "hw/block/block.h"
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index bcfd119a8e..fba6bc8bff 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -28,7 +28,6 @@
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "sysemu/block-backend.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/dma.h"
 #include "sysemu/reset.h"
diff --git a/hw/ide/via.c b/hw/ide/via.c
index 45f929395f..7087dc676e 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -28,7 +28,6 @@
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/dma.h"
 #include "sysemu/reset.h"
=20
diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index b3c4aeded1..0ba8207589 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -28,7 +28,6 @@
 #include "qemu/module.h"
 #include "ui/input.h"
 #include "hw/input/adb-keys.h"
-#include "sysemu/sysemu.h"
 #include "adb-internal.h"
 #include "trace.h"
=20
diff --git a/hw/intc/allwinner-a10-pic.c b/hw/intc/allwinner-a10-pic.c
index 79959a4d23..8cca124807 100644
--- a/hw/intc/allwinner-a10-pic.c
+++ b/hw/intc/allwinner-a10-pic.c
@@ -18,7 +18,6 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "sysemu/sysemu.h"
 #include "hw/intc/allwinner-a10-pic.h"
 #include "hw/irq.h"
 #include "qemu/log.h"
diff --git a/hw/intc/mips_gic.c b/hw/intc/mips_gic.c
index 524cc3ca45..54b3059f3f 100644
--- a/hw/intc/mips_gic.c
+++ b/hw/intc/mips_gic.c
@@ -15,7 +15,6 @@
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "exec/memory.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "sysemu/reset.h"
 #include "kvm_mips.h"
diff --git a/hw/intc/xics_pnv.c b/hw/intc/xics_pnv.c
index 67f2702e52..35f3811264 100644
--- a/hw/intc/xics_pnv.c
+++ b/hw/intc/xics_pnv.c
@@ -19,7 +19,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "sysemu/sysemu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/ppc/xics.h"
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index 4405aa634e..573428eca1 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -33,7 +33,6 @@
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "chardev/char-fe.h"
-#include "sysemu/sysemu.h"
 #include "hw/ipmi/ipmi.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 1bc915405b..50bd28fa82 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -24,7 +24,6 @@
 #include "hw/acpi/acpi.h"
 #include "hw/i2c/pm_smbus.h"
 #include "sysemu/reset.h"
-#include "sysemu/sysemu.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "exec/address-spaces.h"
diff --git a/hw/misc/armsse-cpuid.c b/hw/misc/armsse-cpuid.c
index 5f225096f6..8ab15fea81 100644
--- a/hw/misc/armsse-cpuid.c
+++ b/hw/misc/armsse-cpuid.c
@@ -23,7 +23,6 @@
 #include "qemu/module.h"
 #include "trace.h"
 #include "qapi/error.h"
-#include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
 #include "hw/misc/armsse-cpuid.h"
diff --git a/hw/misc/armsse-mhu.c b/hw/misc/armsse-mhu.c
index 34b6205f11..a45d97fada 100644
--- a/hw/misc/armsse-mhu.c
+++ b/hw/misc/armsse-mhu.c
@@ -20,7 +20,6 @@
 #include "qemu/module.h"
 #include "trace.h"
 #include "qapi/error.h"
-#include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/registerfields.h"
diff --git a/hw/misc/imx6_src.c b/hw/misc/imx6_src.c
index b9d86fe530..8ab18967b5 100644
--- a/hw/misc/imx6_src.c
+++ b/hw/misc/imx6_src.c
@@ -11,7 +11,6 @@
 #include "qemu/osdep.h"
 #include "hw/misc/imx6_src.h"
 #include "migration/vmstate.h"
-#include "sysemu/sysemu.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
diff --git a/hw/misc/imx7_gpr.c b/hw/misc/imx7_gpr.c
index 09d57d4710..b03341a2eb 100644
--- a/hw/misc/imx7_gpr.c
+++ b/hw/misc/imx7_gpr.c
@@ -16,7 +16,6 @@
 #include "hw/misc/imx7_gpr.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "sysemu/sysemu.h"
=20
 #include "trace.h"
=20
diff --git a/hw/misc/iotkit-sysinfo.c b/hw/misc/iotkit-sysinfo.c
index 0106fa48d3..783e613959 100644
--- a/hw/misc/iotkit-sysinfo.c
+++ b/hw/misc/iotkit-sysinfo.c
@@ -22,7 +22,6 @@
 #include "qemu/module.h"
 #include "trace.h"
 #include "qapi/error.h"
-#include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
 #include "hw/misc/iotkit-sysinfo.h"
diff --git a/hw/misc/mips_cmgcr.c b/hw/misc/mips_cmgcr.c
index 0feab092f1..8176d91c0c 100644
--- a/hw/misc/mips_cmgcr.c
+++ b/hw/misc/mips_cmgcr.c
@@ -14,7 +14,6 @@
 #include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "sysemu/sysemu.h"
 #include "hw/misc/mips_cmgcr.h"
 #include "hw/misc/mips_cpc.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 4d99350e22..57f13db266 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -31,7 +31,6 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
-#include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/misc/sga.c b/hw/misc/sga.c
index da04924f5f..6866bf72cb 100644
--- a/hw/misc/sga.c
+++ b/hw/misc/sga.c
@@ -29,7 +29,6 @@
 #include "hw/isa/isa.h"
 #include "hw/loader.h"
 #include "qemu/module.h"
-#include "sysemu/sysemu.h"
=20
 #define SGABIOS_FILENAME "sgabios.bin"
=20
diff --git a/hw/misc/zynq-xadc.c b/hw/misc/zynq-xadc.c
index 7745df4c85..7b1972ce06 100644
--- a/hw/misc/zynq-xadc.c
+++ b/hw/misc/zynq-xadc.c
@@ -18,7 +18,6 @@
 #include "hw/misc/zynq-xadc.h"
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
-#include "sysemu/sysemu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index e1556236b0..8451c17fb8 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -27,7 +27,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
 #include "hw/irq.h"
 #include "hw/ptimer.h"
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index e7662f0575..8bba2a8056 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -18,7 +18,6 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/net/lan9118.h"
-#include "sysemu/sysemu.h"
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "qemu/log.h"
diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
index a1a1046494..6c17ee1ae2 100644
--- a/hw/net/ne2000.c
+++ b/hw/net/ne2000.c
@@ -29,7 +29,6 @@
 #include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "ne2000.h"
-#include "sysemu/sysemu.h"
 #include "trace.h"
=20
 /* debug NE2000 card */
diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index aa13159464..84a95da1d5 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -39,7 +39,6 @@
 #include "net/net.h"
 #include "qemu/module.h"
 #include "net/eth.h"
-#include "sysemu/sysemu.h"
 #include "trace.h"
=20
 /* RECSMALL is not used because it breaks tap networking in linux:
diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index 107ac680b2..f3f18d8598 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -43,7 +43,6 @@
 #include "net/net.h"
 #include "net/eth.h"
 #include "qemu/timer.h"
-#include "sysemu/sysemu.h"
 #include "trace.h"
=20
 #include "pcnet.h"
diff --git a/hw/nios2/generic_nommu.c b/hw/nios2/generic_nommu.c
index 2ec91e899b..19899e2c1e 100644
--- a/hw/nios2/generic_nommu.c
+++ b/hw/nios2/generic_nommu.c
@@ -33,7 +33,6 @@
=20
 #include "hw/sysbus.h"
 #include "hw/char/serial.h"
-#include "sysemu/sysemu.h"
 #include "hw/boards.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
diff --git a/hw/pci-host/pam.c b/hw/pci-host/pam.c
index aa5ecfd0c2..45c4333cd3 100644
--- a/hw/pci-host/pam.c
+++ b/hw/pci-host/pam.c
@@ -29,7 +29,6 @@
=20
 #include "qemu/osdep.h"
 #include "qom/object.h"
-#include "sysemu/sysemu.h"
 #include "hw/pci-host/pam.h"
=20
 void init_pam(DeviceState *dev, MemoryRegion *ram_memory,
diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
index a27776aa99..e5eb6e5a70 100644
--- a/hw/ppc/pnv_bmc.c
+++ b/hw/ppc/pnv_bmc.c
@@ -17,7 +17,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "sysemu/sysemu.h"
 #include "target/ppc/cpu.h"
 #include "qemu/log.h"
 #include "hw/ipmi/ipmi.h"
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index c6b0fee56f..b1a7489e7a 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -19,7 +19,6 @@
=20
 #include "qemu/osdep.h"
 #include "sysemu/reset.h"
-#include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index d4433d73e1..9466d4a1be 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -18,7 +18,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "sysemu/sysemu.h"
 #include "target/ppc/cpu.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index 6120405379..8bead2c930 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -17,7 +17,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "sysemu/sysemu.h"
 #include "target/ppc/cpu.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
index 0060fcb43f..66c1065db2 100644
--- a/hw/ppc/ppce500_spin.c
+++ b/hw/ppc/ppce500_spin.c
@@ -33,7 +33,6 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "sysemu/hw_accel.h"
-#include "sysemu/sysemu.h"
 #include "e500.h"
=20
 #define MAX_CPUS 32
diff --git a/hw/ppc/spapr_rng.c b/hw/ppc/spapr_rng.c
index 27198e0ced..954e4aec4b 100644
--- a/hw/ppc/spapr_rng.c
+++ b/hw/ppc/spapr_rng.c
@@ -23,7 +23,6 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/rng.h"
 #include "hw/ppc/spapr.h"
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 910c57fce5..0803649658 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -25,7 +25,6 @@
 #include "qapi/visitor.h"
 #include "hw/irq.h"
 #include "qemu/log.h"
-#include "sysemu/sysemu.h"
 #include "hw/loader.h"
 #include "elf.h"
 #include "hw/sysbus.h"
diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 056f0711fa..797ecbb7a9 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -18,7 +18,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "sysemu/sysemu.h"
=20
 #include "hw/s390x/sclp.h"
 #include "migration/vmstate.h"
diff --git a/hw/s390x/sclpcpu.c b/hw/s390x/sclpcpu.c
index a4aab7df51..62806d3273 100644
--- a/hw/s390x/sclpcpu.c
+++ b/hw/s390x/sclpcpu.c
@@ -14,7 +14,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "sysemu/sysemu.h"
 #include "hw/s390x/sclp.h"
 #include "qemu/module.h"
 #include "hw/s390x/event-facility.h"
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index a371370221..6580ce5907 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -12,7 +12,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "net/net.h"
 #include "hw/virtio/virtio.h"
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 6370cfe190..915641a0f1 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -30,7 +30,6 @@
 #include "migration/vmstate.h"
 #include "hw/scsi/emulation.h"
 #include "scsi/constants.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "hw/block/block.h"
diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 79a9a5c52c..926e1af475 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -26,7 +26,6 @@
 #include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "sysemu/sysemu.h"
 #include "trace.h"
 #include "qapi/error.h"
 #include "sysemu/block-backend.h"
diff --git a/hw/semihosting/config.c b/hw/semihosting/config.c
index 2a8e7e1045..9807f10cb0 100644
--- a/hw/semihosting/config.c
+++ b/hw/semihosting/config.c
@@ -24,6 +24,7 @@
 #include "qemu/error-report.h"
 #include "hw/semihosting/semihost.h"
 #include "chardev/char.h"
+#include "sysemu/sysemu.h"
=20
 QemuOptsList qemu_semihosting_config_opts =3D {
     .name =3D "semihosting-config",
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index b8332150f1..9f3cff5fb6 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "sysemu/sysemu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
index c918e8cac8..2dd9a631e1 100644
--- a/hw/ssi/imx_spi.c
+++ b/hw/ssi/imx_spi.c
@@ -12,7 +12,6 @@
 #include "hw/irq.h"
 #include "hw/ssi/imx_spi.h"
 #include "migration/vmstate.h"
-#include "sysemu/sysemu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index 24280dfeab..a1be0de039 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -27,7 +27,6 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "sysemu/sysemu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/fifo8.h"
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 1605fa102b..a309c712ca 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -24,7 +24,6 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "sysemu/sysemu.h"
 #include "hw/irq.h"
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index 1e1f74f1a1..ca5a905059 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -19,7 +19,6 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
-#include "sysemu/sysemu.h"
 #include "hw/timer/allwinner-a10-pit.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
diff --git a/hw/timer/altera_timer.c b/hw/timer/altera_timer.c
index c9988f67ac..936b31311d 100644
--- a/hw/timer/altera_timer.c
+++ b/hw/timer/altera_timer.c
@@ -24,7 +24,6 @@
 #include "qapi/error.h"
=20
 #include "hw/sysbus.h"
-#include "sysemu/sysemu.h"
 #include "hw/irq.h"
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/timer/exynos4210_rtc.c b/hw/timer/exynos4210_rtc.c
index 5c954cfa01..ea68904229 100644
--- a/hw/timer/exynos4210_rtc.c
+++ b/hw/timer/exynos4210_rtc.c
@@ -37,7 +37,6 @@
 #include "hw/ptimer.h"
=20
 #include "hw/irq.h"
-#include "sysemu/sysemu.h"
=20
 #include "hw/arm/exynos4210.h"
=20
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboar=
d.c
index c6305dcdf1..aef3289f8c 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -23,7 +23,6 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "net/net.h"
-#include "sysemu/sysemu.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "exec/address-spaces.h"
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index d53453aad6..da6a20669d 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -25,7 +25,6 @@
 #include "cpu.h"
 #include "kvm_s390x.h"
 #include "migration/vmstate.h"
-#include "sysemu/sysemu.h"
 #include "hw/qdev-properties.h"
 #include "hw/s390x/ap-bridge.h"
 #include "exec/address-spaces.h"
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index d14f6b4a7a..d7598c6152 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -25,7 +25,6 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/range.h"
-#include "sysemu/sysemu.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
 #include "qemu/queue.h"
diff --git a/hw/xen/xen_pt_load_rom.c b/hw/xen/xen_pt_load_rom.c
index d111ecaf7e..307a5c93e2 100644
--- a/hw/xen/xen_pt_load_rom.c
+++ b/hw/xen/xen_pt_load_rom.c
@@ -9,7 +9,6 @@
 #include "hw/loader.h"
 #include "monitor/monitor.h"
 #include "qemu/range.h"
-#include "sysemu/sysemu.h"
 #include "hw/pci/pci.h"
 #include "xen_pt.h"
=20
diff --git a/hw/xtensa/xtensa_memory.c b/hw/xtensa/xtensa_memory.c
index 40334db441..1c5f62b014 100644
--- a/hw/xtensa/xtensa_memory.c
+++ b/hw/xtensa/xtensa_memory.c
@@ -28,7 +28,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "sysemu/sysemu.h"
 #include "exec/memory.h"
 #include "qemu/error-report.h"
 #include "xtensa_memory.h"
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 3ef28171c0..12898b6448 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -31,6 +31,7 @@
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "sysemu/qtest.h"
+#include "sysemu/sysemu.h"
 #include "trace.h"
=20
 /*
diff --git a/net/tap-bsd.c b/net/tap-bsd.c
index 5695e3dd1f..a5c3707f80 100644
--- a/net/tap-bsd.c
+++ b/net/tap-bsd.c
@@ -27,7 +27,6 @@
 #include "qapi/error.h"
 #include "tap_int.h"
 #include "qemu/cutils.h"
-#include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
=20
 #if defined(__NetBSD__) || defined(__FreeBSD__)
diff --git a/net/tap-linux.c b/net/tap-linux.c
index 941a45d7c3..e0dd442ee3 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -32,7 +32,6 @@
 #include <net/if.h>
 #include <sys/ioctl.h>
=20
-#include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index 0e3f3e0a9b..4725d2314e 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "tap_int.h"
-#include "sysemu/sysemu.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
=20
diff --git a/net/tap-win32.c b/net/tap-win32.c
index 9cdef47286..2b5dcda36e 100644
--- a/net/tap-win32.c
+++ b/net/tap-win32.c
@@ -33,7 +33,6 @@
 #include "clients.h"            /* net_init_tap */
 #include "net/net.h"
 #include "net/tap.h"            /* tap_has_ufo, ... */
-#include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include <windows.h>
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 21c1c301d0..a0003bf2a9 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -32,6 +32,7 @@
 #include "qemu/option.h"
 #include "qemu/qemu-print.h"
 #include "sysemu/block-backend.h"
+#include "sysemu/sysemu.h"
 #include "migration/misc.h"
=20
 /*
diff --git a/qemu-img.c b/qemu-img.c
index a398fd44d6..31c72dc746 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -42,7 +42,6 @@
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "qom/object_interfaces.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/block-backend.h"
 #include "block/block_int.h"
 #include "block/blockjob.h"
diff --git a/qom/cpu.c b/qom/cpu.c
index cdb8c71b6b..aeb34f8c67 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -28,7 +28,6 @@
 #include "exec/log.h"
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/tcg.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
diff --git a/replay/replay-audio.c b/replay/replay-audio.c
index b113836de4..178094e601 100644
--- a/replay/replay-audio.c
+++ b/replay/replay-audio.c
@@ -13,7 +13,6 @@
 #include "qemu/error-report.h"
 #include "sysemu/replay.h"
 #include "replay-internal.h"
-#include "sysemu/sysemu.h"
 #include "audio/audio.h"
=20
 void replay_audio_out(int *played)
diff --git a/replay/replay-char.c b/replay/replay-char.c
index 736cc8c2e6..dc0002367e 100644
--- a/replay/replay-char.c
+++ b/replay/replay-char.c
@@ -13,7 +13,6 @@
 #include "qemu/error-report.h"
 #include "sysemu/replay.h"
 #include "replay-internal.h"
-#include "sysemu/sysemu.h"
 #include "chardev/char.h"
=20
 /* Char drivers that generate qemu_chr_be_write events
diff --git a/replay/replay-net.c b/replay/replay-net.c
index 80b7054156..3b70f71cf1 100644
--- a/replay/replay-net.c
+++ b/replay/replay-net.c
@@ -13,7 +13,6 @@
 #include "qemu/error-report.h"
 #include "sysemu/replay.h"
 #include "replay-internal.h"
-#include "sysemu/sysemu.h"
 #include "net/net.h"
 #include "net/filter.h"
 #include "qemu/iov.h"
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index 756f48bc02..5dd8680480 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -13,7 +13,6 @@
 #include "qapi/error.h"
 #include "sysemu/replay.h"
 #include "replay-internal.h"
-#include "sysemu/sysemu.h"
 #include "monitor/monitor.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/error-report.h"
diff --git a/stubs/replay.c b/stubs/replay.c
index 4ac607895d..10b3925e2f 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -1,6 +1,5 @@
 #include "qemu/osdep.h"
 #include "sysemu/replay.h"
-#include "sysemu/sysemu.h"
=20
 ReplayMode replay_mode;
=20
diff --git a/stubs/semihost.c b/stubs/semihost.c
index 4d5b3c0653..f90589259c 100644
--- a/stubs/semihost.c
+++ b/stubs/semihost.c
@@ -12,6 +12,7 @@
 #include "qemu/option.h"
 #include "qemu/error-report.h"
 #include "hw/semihosting/semihost.h"
+#include "sysemu/sysemu.h"
=20
 /* Empty config */
 QemuOptsList qemu_semihosting_config_opts =3D {
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 1901997a06..e4edff548e 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -25,7 +25,6 @@
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/loader.h"
 #endif
-#include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
 #include "qapi/visitor.h"
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 616d62c7fc..bca80bdc38 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -24,7 +24,6 @@
 #include "qemu/host-utils.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
-#include "sysemu/sysemu.h"
 #include "qemu/bitops.h"
 #include "internals.h"
 #include "qemu/crc32c.h"
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 210f5831e3..edee110ae1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -16,7 +16,6 @@
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 #include "qemu/main-loop.h"
-#include "sysemu/sysemu.h"
 #include "qemu/bitops.h"
 #include "qemu/crc32c.h"
 #include "qemu/qemu-print.h"
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 51f78f722b..2451a2d4bb 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -16,7 +16,6 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "qemu/timer.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
 #include "internals.h"
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index c76d3d799a..59ed579d02 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -23,7 +23,6 @@
 #include "qemu/host-utils.h"
 #include "qemu/main-loop.h"
 #include "exec/gdbstub.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
 #include "internals.h"
diff --git a/target/arm/m_helper.c b/target/arm/m_helper.c
index cde5195d28..884d35d2b0 100644
--- a/target/arm/m_helper.c
+++ b/target/arm/m_helper.c
@@ -16,7 +16,6 @@
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
 #include "qemu/main-loop.h"
-#include "sysemu/sysemu.h"
 #include "qemu/bitops.h"
 #include "qemu/crc32c.h"
 #include "qemu/qemu-print.h"
diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
index 73cd5d2817..1daac6cc2b 100644
--- a/target/i386/hvf/x86_task.c
+++ b/target/i386/hvf/x86_task.c
@@ -29,7 +29,6 @@
 #include "hw/i386/apic_internal.h"
 #include "qemu/main-loop.h"
 #include "sysemu/accel.h"
-#include "sysemu/sysemu.h"
 #include "target/i386/cpu.h"
=20
 // TODO: taskswitch handling
diff --git a/target/lm32/helper.c b/target/lm32/helper.c
index 9f3b107474..1130fc8884 100644
--- a/target/lm32/helper.c
+++ b/target/lm32/helper.c
@@ -21,7 +21,6 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "qemu/host-utils.h"
-#include "sysemu/sysemu.h"
 #include "hw/semihosting/semihost.h"
 #include "exec/log.h"
=20
diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
index 01627b42c9..8e5fbfc8fa 100644
--- a/target/m68k/m68k-semi.c
+++ b/target/m68k/m68k-semi.c
@@ -28,7 +28,6 @@
 #include "exec/softmmu-semi.h"
 #endif
 #include "qemu/log.h"
-#include "sysemu/sysemu.h"
=20
 #define HOSTED_EXIT  0
 #define HOSTED_INIT_SIM 1
diff --git a/target/nios2/nios2-semi.c b/target/nios2/nios2-semi.c
index cc2777d2f8..d7a80dd303 100644
--- a/target/nios2/nios2-semi.c
+++ b/target/nios2/nios2-semi.c
@@ -32,7 +32,6 @@
 #include "exec/softmmu-semi.h"
 #endif
 #include "qemu/log.h"
-#include "sysemu/sysemu.h"
=20
 #define HOSTED_EXIT  0
 #define HOSTED_INIT_SIM 1
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 6836a4afb3..6162a903fa 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -27,7 +27,6 @@
 #include "cpu.h"
 #include "cpu-models.h"
 #include "qemu/timer.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/hw_accel.h"
 #include "kvm_ppc.h"
 #include "sysemu/cpus.h"
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index 1a52061fbf..07d87efa4e 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -22,7 +22,6 @@
 #include "exec/exec-all.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
-#include "sysemu/sysemu.h"
=20
 void cpu_raise_exception_ra(CPUSPARCState *env, int tt, uintptr_t ra)
 {
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 6f1da87875..fa12a576b2 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -36,7 +36,6 @@
 #include "tcg-op.h"
 #include "qemu/log.h"
 #include "qemu/qemu-print.h"
-#include "sysemu/sysemu.h"
 #include "exec/cpu_ldst.h"
 #include "hw/semihosting/semihost.h"
 #include "exec/translator.h"
diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
index 8862985e56..25f57a6500 100644
--- a/target/xtensa/xtensa-semi.c
+++ b/target/xtensa/xtensa-semi.c
@@ -32,7 +32,6 @@
 #include "hw/semihosting/semihost.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
-#include "sysemu/sysemu.h"
=20
 enum {
     TARGET_SYS_exit =3D 1,
diff --git a/tests/migration-test.c b/tests/migration-test.c
index c1968740ab..b87ba99a9e 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -20,7 +20,6 @@
 #include "qemu/range.h"
 #include "qemu/sockets.h"
 #include "chardev/char.h"
-#include "sysemu/sysemu.h"
 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index db5ccff5ad..c4301851bd 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "sysemu/sysemu.h"
 #include "keymaps.h"
 #include "ui/input.h"
=20
diff --git a/ui/input-legacy.c b/ui/input-legacy.c
index 549654e26a..9fc78a639b 100644
--- a/ui/input-legacy.c
+++ b/ui/input-legacy.c
@@ -24,7 +24,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/qapi-commands-ui.h"
-#include "sysemu/sysemu.h"
 #include "ui/console.h"
 #include "keymaps.h"
 #include "ui/input.h"
diff --git a/ui/input-linux.c b/ui/input-linux.c
index e3fa799c34..59456fe765 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -10,7 +10,6 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/sockets.h"
-#include "sysemu/sysemu.h"
 #include "ui/input.h"
 #include "qom/object_interfaces.h"
 #include "sysemu/iothread.h"
diff --git a/ui/keymaps.c b/ui/keymaps.c
index 6e8a321971..4e5fca57a8 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "keymaps.h"
-#include "sysemu/sysemu.h"
 #include "trace.h"
 #include "qemu/ctype.h"
 #include "qemu/error-report.h"
diff --git a/ui/sdl2-2d.c b/ui/sdl2-2d.c
index db191aaa79..a2ea85127d 100644
--- a/ui/sdl2-2d.c
+++ b/ui/sdl2-2d.c
@@ -27,7 +27,6 @@
 #include "ui/console.h"
 #include "ui/input.h"
 #include "ui/sdl2.h"
-#include "sysemu/sysemu.h"
=20
 void sdl2_2d_update(DisplayChangeListener *dcl,
                     int x, int y, int w, int h)
diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index 7a37e7c995..c73d273bf8 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -29,7 +29,6 @@
 #include "ui/console.h"
 #include "ui/input.h"
 #include "ui/sdl2.h"
-#include "sysemu/sysemu.h"
=20
 static void sdl2_set_scanout_mode(struct sdl2_console *scon, bool scanou=
t)
 {
diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
index b1daae4111..1f9fe831b3 100644
--- a/ui/sdl2-input.c
+++ b/ui/sdl2-input.c
@@ -27,7 +27,6 @@
 #include "ui/console.h"
 #include "ui/input.h"
 #include "ui/sdl2.h"
-#include "sysemu/sysemu.h"
=20
 void sdl2_process_key(struct sdl2_console *scon,
                       SDL_KeyboardEvent *ev)
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 0c65ae2fe3..6babe24909 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -22,7 +22,6 @@
 #include "qemu/option.h"
 #include "qemu/queue.h"
 #include "ui/console.h"
-#include "sysemu/sysemu.h"
 #include "trace.h"
=20
 #include "ui/spice-display.h"
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 1cc1b2f2c3..b0e40a9087 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -26,7 +26,6 @@
 #include "qemu/main-loop.h"
 #include "qemu/timer.h"
 #include "sysemu/replay.h"
-#include "sysemu/sysemu.h"
 #include "sysemu/cpus.h"
=20
 #ifdef CONFIG_POSIX
--=20
2.21.0


