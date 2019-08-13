Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6032CC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:52:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C13820578
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C13820578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxZ6T-0006Fl-DR
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 11:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52402)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hxZ12-0004Er-Nf
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hxZ0y-0002Tj-16
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:47:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50958)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hxZ0w-0002Rk-1r
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:47:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9EC1E30083EE;
 Tue, 13 Aug 2019 15:47:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 430001001281;
 Tue, 13 Aug 2019 15:47:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ABE38113644F; Tue, 13 Aug 2019 17:46:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 13 Aug 2019 17:46:32 +0200
Message-Id: <20190813154653.20568-9-armbru@redhat.com>
In-Reply-To: <20190813154653.20568-1-armbru@redhat.com>
References: <20190813154653.20568-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 13 Aug 2019 15:47:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 08/29] Include sysemu/reset.h a lot less
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In my "build everything" tree, changing sysemu/reset.h triggers a
recompile of some 2600 out of 6600 objects (not counting tests and
objects that don't depend on qemu/osdep.h).

The main culprit is hw/hw.h, which supposedly includes it for
convenience.

Include sysemu/reset.h only where it's needed.  Touching it now
recompiles less than 200 objects.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190812052359.30071-9-armbru@redhat.com>
---
 include/hw/hw.h            | 1 -
 hw/acpi/ich9.c             | 2 ++
 hw/acpi/piix4.c            | 2 ++
 hw/acpi/vmgenid.c          | 1 +
 hw/arm/armv7m.c            | 1 +
 hw/arm/boot.c              | 1 +
 hw/arm/nseries.c           | 1 +
 hw/arm/omap1.c             | 1 +
 hw/arm/omap2.c             | 1 +
 hw/arm/virt-acpi-build.c   | 1 +
 hw/char/parallel.c         | 1 +
 hw/char/serial.c           | 1 +
 hw/core/generic-loader.c   | 1 +
 hw/core/loader.c           | 1 +
 hw/cris/boot.c             | 1 +
 hw/display/cirrus_vga.c    | 1 +
 hw/display/ramfb.c         | 2 ++
 hw/display/vga.c           | 2 ++
 hw/hppa/machine.c          | 1 +
 hw/i386/acpi-build.c       | 1 +
 hw/i386/pc.c               | 1 +
 hw/ide/cmd646.c            | 1 +
 hw/ide/piix.c              | 1 +
 hw/ide/sii3112.c           | 1 +
 hw/ide/via.c               | 1 +
 hw/input/lm832x.c          | 1 +
 hw/input/pckbd.c           | 2 ++
 hw/input/ps2.c             | 2 ++
 hw/input/tsc2005.c         | 1 +
 hw/input/tsc210x.c         | 1 +
 hw/intc/mips_gic.c         | 1 +
 hw/intc/pnv_xive.c         | 1 +
 hw/intc/spapr_xive.c       | 1 +
 hw/intc/xics.c             | 1 +
 hw/intc/xive.c             | 1 +
 hw/isa/piix4.c             | 1 +
 hw/isa/vt82c686.c          | 1 +
 hw/lm32/lm32_boards.c      | 1 +
 hw/lm32/milkymist.c        | 1 +
 hw/microblaze/boot.c       | 1 +
 hw/mips/cps.c              | 1 +
 hw/mips/mips_fulong2e.c    | 1 +
 hw/mips/mips_jazz.c        | 1 +
 hw/mips/mips_malta.c       | 1 +
 hw/mips/mips_mipssim.c     | 2 ++
 hw/mips/mips_r4k.c         | 2 ++
 hw/misc/vmcoreinfo.c       | 1 +
 hw/moxie/moxiesim.c        | 2 ++
 hw/net/eepro100.c          | 1 +
 hw/nios2/boot.c            | 1 +
 hw/nvram/fw_cfg.c          | 1 +
 hw/openrisc/openrisc_sim.c | 1 +
 hw/pci-host/bonito.c       | 1 +
 hw/pci-host/piix.c         | 1 +
 hw/ppc/e500.c              | 1 +
 hw/ppc/mac_newworld.c      | 1 +
 hw/ppc/mac_oldworld.c      | 1 +
 hw/ppc/pnv.c               | 1 +
 hw/ppc/pnv_core.c          | 1 +
 hw/ppc/pnv_psi.c           | 1 +
 hw/ppc/ppc405_boards.c     | 2 ++
 hw/ppc/ppc405_uc.c         | 2 ++
 hw/ppc/ppc440_bamboo.c     | 1 +
 hw/ppc/ppc440_uc.c         | 1 +
 hw/ppc/ppc4xx_devs.c       | 2 ++
 hw/ppc/ppc4xx_pci.c        | 1 +
 hw/ppc/ppc_booke.c         | 2 ++
 hw/ppc/prep.c              | 2 ++
 hw/ppc/sam460ex.c          | 1 +
 hw/ppc/spapr.c             | 1 +
 hw/ppc/spapr_cpu_core.c    | 2 ++
 hw/ppc/spapr_drc.c         | 1 +
 hw/ppc/virtex_ml507.c      | 1 +
 hw/riscv/riscv_hart.c      | 1 +
 hw/s390x/ipl.c             | 1 +
 hw/s390x/s390-virtio-ccw.c | 1 +
 hw/sh4/r2d.c               | 1 +
 hw/sparc/leon3.c           | 2 ++
 hw/sparc/sun4m.c           | 2 ++
 hw/sparc64/sparc64.c       | 1 +
 hw/timer/etraxfs_timer.c   | 1 +
 hw/timer/mc146818rtc.c     | 1 +
 hw/tpm/tpm_ppi.c           | 1 -
 hw/vfio/common.c           | 1 +
 hw/watchdog/wdt_diag288.c  | 1 +
 hw/xtensa/sim.c            | 1 +
 hw/xtensa/xtfpga.c         | 1 +
 target/i386/cpu.c          | 1 +
 target/i386/hax-all.c      | 1 +
 target/i386/kvm.c          | 1 +
 target/s390x/cpu.c         | 1 +
 vl.c                       | 1 +
 92 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/include/hw/hw.h b/include/hw/hw.h
index b1b79964b5..a4fb2390e8 100644
--- a/include/hw/hw.h
+++ b/include/hw/hw.h
@@ -12,7 +12,6 @@
 #include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "migration/qemu-file-types.h"
-#include "sysemu/reset.h"
=20
 void QEMU_NORETURN hw_error(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
=20
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index e53dfe1ee3..b4d987c811 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -23,6 +23,7 @@
  * Contributions after 2012-01-13 are licensed under the terms of the
  * GNU GPL, version 2 or (at your option) any later version.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "qapi/error.h"
@@ -30,6 +31,7 @@
 #include "hw/i386/pc.h"
 #include "hw/pci/pci.h"
 #include "qemu/timer.h"
+#include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/tco.h"
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index ec4e186cec..a59e58d937 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -18,6 +18,7 @@
  * Contributions after 2012-01-13 are licensed under the terms of the
  * GNU GPL, version 2 or (at your option) any later version.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
@@ -25,6 +26,7 @@
 #include "hw/i2c/pm_smbus.h"
 #include "hw/pci/pci.h"
 #include "hw/acpi/acpi.h"
+#include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "qemu/range.h"
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index b891df375f..ed92ccc4b8 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -18,6 +18,7 @@
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/vmgenid.h"
 #include "hw/nvram/fw_cfg.h"
+#include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
=20
 void vmgenid_build_acpi(VmGenIdState *vms, GArray *table_data, GArray *g=
uid,
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index b9efad6bac..4b2d8b6574 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -16,6 +16,7 @@
 #include "hw/loader.h"
 #include "elf.h"
 #include "sysemu/qtest.h"
+#include "sysemu/reset.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "exec/address-spaces.h"
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index c2b89b3bb9..d082daf6f2 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -18,6 +18,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/numa.h"
+#include "sysemu/reset.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "elf.h"
diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 4a79f5c88b..3f3eca52e2 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -23,6 +23,7 @@
 #include "cpu.h"
 #include "qemu/cutils.h"
 #include "qemu/bswap.h"
+#include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "hw/arm/omap.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 28fbe275a8..beaddaf11f 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -29,6 +29,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/arm/soc_dma.h"
 #include "sysemu/qtest.h"
+#include "sysemu/reset.h"
 #include "qemu/range.h"
 #include "hw/sysbus.h"
 #include "qemu/cutils.h"
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index 87ced7f3a2..7d4cac1f46 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -23,6 +23,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "sysemu/qtest.h"
+#include "sysemu/reset.h"
 #include "hw/boards.h"
 #include "hw/hw.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 0afb372769..ad54d65ea0 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -44,6 +44,7 @@
 #include "hw/pci/pci.h"
 #include "hw/arm/virt.h"
 #include "sysemu/numa.h"
+#include "sysemu/reset.h"
 #include "kvm_arm.h"
=20
 #define ARM_SPI_BASE 32
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 1cd4c54a02..fed15dc548 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -31,6 +31,7 @@
 #include "chardev/char-fe.h"
 #include "hw/isa/isa.h"
 #include "hw/char/parallel.h"
+#include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
=20
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 7c42a2abfc..a9e42f7d97 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -28,6 +28,7 @@
 #include "chardev/char-serial.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
+#include "sysemu/reset.h"
 #include "qemu/error-report.h"
 #include "trace.h"
=20
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index 79a493e577..579fe5ed32 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -34,6 +34,7 @@
 #include "qom/cpu.h"
 #include "hw/sysbus.h"
 #include "sysemu/dma.h"
+#include "sysemu/reset.h"
 #include "hw/loader.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 425bf69a99..830845dd73 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -48,6 +48,7 @@
 #include "hw/hw.h"
 #include "disas/disas.h"
 #include "monitor/monitor.h"
+#include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "uboot_image.h"
 #include "hw/loader.h"
diff --git a/hw/cris/boot.c b/hw/cris/boot.c
index 602f538ef6..d44fdec43f 100644
--- a/hw/cris/boot.c
+++ b/hw/cris/boot.c
@@ -29,6 +29,7 @@
 #include "elf.h"
 #include "boot.h"
 #include "qemu/cutils.h"
+#include "sysemu/reset.h"
=20
 static void main_cpu_reset(void *opaque)
 {
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 2e4911a1e3..4ccf5b4f18 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -35,6 +35,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
+#include "sysemu/reset.h"
 #include "qapi/error.h"
 #include "trace.h"
 #include "hw/hw.h"
diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index b4eb283ef8..6026a35b11 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -10,12 +10,14 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/option.h"
 #include "hw/loader.h"
 #include "hw/display/ramfb.h"
 #include "ui/console.h"
+#include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
=20
 struct QEMU_PACKED RAMFBCfg {
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 910a23c12e..4d3572891a 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -21,8 +21,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "sysemu/reset.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/display/vga.h"
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 662838d83b..bc74438496 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -11,6 +11,7 @@
 #include "hw/loader.h"
 #include "hw/boards.h"
 #include "qemu/error-report.h"
+#include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "hw/timer/mc146818rtc.h"
 #include "hw/ide.h"
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index f3fdfefcd5..74667a53be 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -48,6 +48,7 @@
 #include "hw/timer/mc146818rtc_regs.h"
 #include "hw/mem/memory-device.h"
 #include "sysemu/numa.h"
+#include "sysemu/reset.h"
=20
 /* Supported chipsets: */
 #include "hw/acpi/piix4.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 549c437050..73b55500b0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -54,6 +54,7 @@
 #include "sysemu/numa.h"
 #include "sysemu/kvm.h"
 #include "sysemu/qtest.h"
+#include "sysemu/reset.h"
 #include "kvm_i386.h"
 #include "hw/xen/xen.h"
 #include "hw/xen/start_info.h"
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index ed23aabf21..e5542c9811 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -30,6 +30,7 @@
 #include "hw/isa/isa.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/dma.h"
+#include "sysemu/reset.h"
=20
 #include "hw/ide/pci.h"
 #include "trace.h"
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index b97e555072..c4c6d4b760 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -31,6 +31,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/dma.h"
+#include "sysemu/reset.h"
=20
 #include "hw/ide/pci.h"
 #include "trace.h"
diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index d7590d4ba4..2181260531 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "hw/ide/pci.h"
 #include "qemu/module.h"
+#include "sysemu/reset.h"
 #include "trace.h"
=20
 #define TYPE_SII3112_PCI "sii3112"
diff --git a/hw/ide/via.c b/hw/ide/via.c
index c3bda909f9..6d54ac55f0 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -30,6 +30,7 @@
 #include "qemu/module.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/dma.h"
+#include "sysemu/reset.h"
=20
 #include "hw/ide/pci.h"
 #include "trace.h"
diff --git a/hw/input/lm832x.c b/hw/input/lm832x.c
index 5203da2bcf..ebb72c6590 100644
--- a/hw/input/lm832x.c
+++ b/hw/input/lm832x.c
@@ -23,6 +23,7 @@
 #include "hw/i2c/i2c.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
+#include "sysemu/reset.h"
 #include "ui/console.h"
=20
 #define TYPE_LM8323 "lm8323"
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index 47a606f5e3..5d06a53362 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -21,6 +21,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/hw.h"
@@ -28,6 +29,7 @@
 #include "hw/i386/pc.h"
 #include "hw/input/ps2.h"
 #include "hw/input/i8042.h"
+#include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
=20
 #include "trace.h"
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index d3161f1e7c..8d922b05c9 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -21,12 +21,14 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/hw.h"
 #include "hw/input/ps2.h"
 #include "ui/console.h"
 #include "ui/input.h"
+#include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
=20
 #include "trace.h"
diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index f82771e7a7..0a0431744c 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -22,6 +22,7 @@
 #include "qemu/log.h"
 #include "hw/hw.h"
 #include "qemu/timer.h"
+#include "sysemu/reset.h"
 #include "ui/console.h"
 #include "hw/input/tsc2xxx.h"
 #include "trace.h"
diff --git a/hw/input/tsc210x.c b/hw/input/tsc210x.c
index f94cb4683b..d2486f4b4e 100644
--- a/hw/input/tsc210x.c
+++ b/hw/input/tsc210x.c
@@ -23,6 +23,7 @@
 #include "hw/hw.h"
 #include "audio/audio.h"
 #include "qemu/timer.h"
+#include "sysemu/reset.h"
 #include "ui/console.h"
 #include "hw/arm/omap.h"            /* For I2SCodec */
 #include "hw/input/tsc2xxx.h"
diff --git a/hw/intc/mips_gic.c b/hw/intc/mips_gic.c
index 33ab51c5b8..e27e333766 100644
--- a/hw/intc/mips_gic.c
+++ b/hw/intc/mips_gic.c
@@ -18,6 +18,7 @@
 #include "exec/memory.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
+#include "sysemu/reset.h"
 #include "kvm_mips.h"
 #include "hw/intc/mips_gic.h"
=20
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 4dc92ef1e3..63b0f461ec 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -14,6 +14,7 @@
 #include "target/ppc/cpu.h"
 #include "sysemu/cpus.h"
 #include "sysemu/dma.h"
+#include "sysemu/reset.h"
 #include "monitor/monitor.h"
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/pnv.h"
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 3ae311d9ff..2e39cc1e47 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -14,6 +14,7 @@
 #include "qemu/error-report.h"
 #include "target/ppc/cpu.h"
 #include "sysemu/cpus.h"
+#include "sysemu/reset.h"
 #include "monitor/monitor.h"
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/spapr.h"
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index faa976e2f8..9ed224ce5f 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -38,6 +38,7 @@
 #include "monitor/monitor.h"
 #include "hw/intc/intc.h"
 #include "sysemu/kvm.h"
+#include "sysemu/reset.h"
=20
 void icp_pic_print_info(ICPState *icp, Monitor *mon)
 {
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index cf77bdb7d3..b27d6b8646 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -14,6 +14,7 @@
 #include "target/ppc/cpu.h"
 #include "sysemu/cpus.h"
 #include "sysemu/dma.h"
+#include "sysemu/reset.h"
 #include "hw/qdev-properties.h"
 #include "monitor/monitor.h"
 #include "hw/ppc/xive.h"
diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 6b8bc3faf0..3677976ef7 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -28,6 +28,7 @@
 #include "hw/pci/pci.h"
 #include "hw/isa/isa.h"
 #include "hw/sysbus.h"
+#include "sysemu/reset.h"
=20
 PCIDevice *piix4_dev;
=20
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 12c460590f..81bffb1fb9 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -22,6 +22,7 @@
 #include "hw/isa/apm.h"
 #include "hw/acpi/acpi.h"
 #include "hw/i2c/pm_smbus.h"
+#include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
index fb9d52d54f..e075ebc8a6 100644
--- a/hw/lm32/lm32_boards.c
+++ b/hw/lm32/lm32_boards.c
@@ -30,6 +30,7 @@
 #include "lm32_hwsetup.h"
 #include "lm32.h"
 #include "exec/address-spaces.h"
+#include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
=20
 typedef struct {
diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 689e633199..33669ee19b 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -27,6 +27,7 @@
 #include "hw/block/flash.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
+#include "sysemu/reset.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "elf.h"
diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index a7af4c0704..bade4d22c0 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -31,6 +31,7 @@
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "sysemu/device_tree.h"
+#include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "hw/loader.h"
 #include "elf.h"
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 0d459c4141..aea6bcd7fe 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -24,6 +24,7 @@
 #include "hw/mips/mips.h"
 #include "hw/mips/cpudevs.h"
 #include "sysemu/kvm.h"
+#include "sysemu/reset.h"
=20
 qemu_irq get_cps_irq(MIPSCPSState *s, int pin_number)
 {
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 5dbaa3bfcc..0a1bf5ef5c 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -44,6 +44,7 @@
 #include "hw/timer/i8254.h"
 #include "exec/address-spaces.h"
 #include "sysemu/qtest.h"
+#include "sysemu/reset.h"
 #include "qemu/error-report.h"
=20
 #define DEBUG_FULONG2E_INIT
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index fa8775d428..6ea25cd5f4 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -48,6 +48,7 @@
 #include "hw/sysbus.h"
 #include "exec/address-spaces.h"
 #include "sysemu/qtest.h"
+#include "sysemu/reset.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/help_option.h"
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 20e019bf66..29bc8de5cf 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -51,6 +51,7 @@
 #include "hw/sysbus.h"             /* SysBusDevice */
 #include "qemu/host-utils.h"
 #include "sysemu/qtest.h"
+#include "sysemu/reset.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/empty_slot.h"
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index 824abda657..280e76a482 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -24,6 +24,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
@@ -43,6 +44,7 @@
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
 #include "sysemu/qtest.h"
+#include "sysemu/reset.h"
=20
 static struct _loaderparams {
     int ram_size;
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 93dbf76bb4..191047826d 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -7,6 +7,7 @@
  * All peripherial devices are attached to this "bus" with
  * the standard PC ISA addresses.
 */
+
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
@@ -33,6 +34,7 @@
 #include "hw/timer/i8254.h"
 #include "exec/address-spaces.h"
 #include "sysemu/qtest.h"
+#include "sysemu/reset.h"
 #include "qemu/error-report.h"
=20
 #define MAX_IDE_BUS 2
diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
index 987d6f52af..49e87d462b 100644
--- a/hw/misc/vmcoreinfo.c
+++ b/hw/misc/vmcoreinfo.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "sysemu/reset.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/misc/vmcoreinfo.h"
=20
diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
index d771d393c2..16a7d58274 100644
--- a/hw/moxie/moxiesim.c
+++ b/hw/moxie/moxiesim.c
@@ -24,6 +24,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -31,6 +32,7 @@
 #include "hw/sysbus.h"
 #include "hw/hw.h"
 #include "net/net.h"
+#include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index 6607c9142d..e0cf0c46d7 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -49,6 +49,7 @@
 #include "hw/nvram/eeprom93xx.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/dma.h"
+#include "sysemu/reset.h"
 #include "qemu/bitops.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
index 276068c842..d78bc9ed0e 100644
--- a/hw/nios2/boot.c
+++ b/hw/nios2/boot.c
@@ -36,6 +36,7 @@
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "sysemu/device_tree.h"
+#include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "hw/loader.h"
 #include "elf.h"
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index dcfd6d2ed3..3032f1c65f 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -27,6 +27,7 @@
 #include "hw/hw.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/dma.h"
+#include "sysemu/reset.h"
 #include "hw/boards.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/sysbus.h"
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index b85f0df323..cb2fc5ba78 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -32,6 +32,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
 #include "sysemu/qtest.h"
+#include "sysemu/reset.h"
=20
 #define KERNEL_LOAD_ADDR 0x100
=20
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index dde4437595..36c7ca45ad 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -44,6 +44,7 @@
 #include "hw/i386/pc.h"
 #include "hw/mips/mips.h"
 #include "hw/pci/pci_host.h"
+#include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
=20
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index d9c70f7ce6..f3671d28b7 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -33,6 +33,7 @@
 #include "qemu/range.h"
 #include "hw/xen/xen.h"
 #include "hw/pci-host/pam.h"
+#include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "hw/i386/ioapic.h"
 #include "qapi/visitor.h"
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index a3eac7f057..566f179bb1 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -28,6 +28,7 @@
 #include "hw/boards.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
+#include "sysemu/reset.h"
 #include "kvm_ppc.h"
 #include "sysemu/device_tree.h"
 #include "hw/ppc/openpic.h"
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 09bc6068f3..0f9f351eb1 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -68,6 +68,7 @@
 #include "elf.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
+#include "sysemu/reset.h"
 #include "kvm_ppc.h"
 #include "hw/usb.h"
 #include "exec/address-spaces.h"
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 9ffde5b6f7..6640057473 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -47,6 +47,7 @@
 #include "elf.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
+#include "sysemu/reset.h"
 #include "kvm_ppc.h"
 #include "exec/address-spaces.h"
=20
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index bd4531c822..96608883aa 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -23,6 +23,7 @@
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/numa.h"
+#include "sysemu/reset.h"
 #include "sysemu/cpus.h"
 #include "sysemu/device_tree.h"
 #include "hw/hw.h"
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index c6411ecc1d..ff477ba6c9 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index d7b6f5d75b..6b26d0f6bc 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -22,6 +22,7 @@
 #include "target/ppc/cpu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "sysemu/reset.h"
 #include "qapi/error.h"
 #include "monitor/monitor.h"
=20
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 13318a9faf..5b278e7791 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -21,6 +21,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
@@ -33,6 +34,7 @@
 #include "hw/block/flash.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
+#include "sysemu/reset.h"
 #include "sysemu/block-backend.h"
 #include "hw/boards.h"
 #include "qemu/log.h"
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index edb6b2d190..f9d98fe71e 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -21,6 +21,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
@@ -32,6 +33,7 @@
 #include "ppc405.h"
 #include "hw/char/serial.h"
 #include "qemu/timer.h"
+#include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
 #include "exec/address-spaces.h"
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index b4da099e3e..1bd92aa749 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -31,6 +31,7 @@
 #include "ppc405.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
+#include "sysemu/reset.h"
 #include "hw/sysbus.h"
=20
 #define BINARY_DEVICE_TREE_FILE "bamboo.dtb"
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 5c1a53d6e7..7329cfe651 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -21,6 +21,7 @@
 #include "hw/ppc/ppc.h"
 #include "hw/pci/pci.h"
 #include "sysemu/block-backend.h"
+#include "sysemu/reset.h"
 #include "ppc440.h"
=20
 /***********************************************************************=
******/
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index fdfeb67e65..e62bef3b8d 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -21,8 +21,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "sysemu/reset.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/ppc/ppc.h"
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index e7cf8d50a5..b013319c60 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -24,6 +24,7 @@
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
 #include "qemu/module.h"
+#include "sysemu/reset.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "exec/address-spaces.h"
diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
index 18d1457581..ba5f513ca5 100644
--- a/hw/ppc/ppc_booke.c
+++ b/hw/ppc/ppc_booke.c
@@ -21,11 +21,13 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/ppc/ppc.h"
 #include "qemu/timer.h"
+#include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
 #include "hw/loader.h"
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index ab3c1df1fc..84e968e28c 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -22,6 +22,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "hw/hw.h"
@@ -45,6 +46,7 @@
 #include "sysemu/arch_init.h"
 #include "sysemu/kvm.h"
 #include "sysemu/qtest.h"
+#include "sysemu/reset.h"
 #include "exec/address-spaces.h"
 #include "trace.h"
 #include "elf.h"
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index fbcddc5b00..c1d6f74d5b 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -31,6 +31,7 @@
 #include "hw/block/flash.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
+#include "sysemu/reset.h"
 #include "hw/sysbus.h"
 #include "hw/char/serial.h"
 #include "hw/i2c/ppc4xx_i2c.h"
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 821f0d4a49..5cade1a374 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -31,6 +31,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/numa.h"
 #include "sysemu/qtest.h"
+#include "sysemu/reset.h"
 #include "hw/hw.h"
 #include "qemu/log.h"
 #include "hw/fw-path-provider.h"
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 5621fb9a3d..ccc8970c7c 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -6,6 +6,7 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
  */
+
 #include "qemu/osdep.h"
 #include "hw/cpu/core.h"
 #include "hw/ppc/spapr_cpu_core.h"
@@ -19,6 +20,7 @@
 #include "hw/ppc/ppc.h"
 #include "target/ppc/mmu-hash64.h"
 #include "sysemu/numa.h"
+#include "sysemu/reset.h"
 #include "sysemu/hw_accel.h"
 #include "qemu/error-report.h"
=20
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index bacadfcac5..678493a9c5 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -23,6 +23,7 @@
 #include "hw/ppc/spapr.h" /* for RTAS return codes */
 #include "hw/pci-host/spapr.h" /* spapr_phb_remove_pci_device_cb callbac=
k */
 #include "sysemu/device_tree.h"
+#include "sysemu/reset.h"
 #include "trace.h"
=20
 #define DRC_CONTAINER_PATH "/dr-connector"
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 834053a7d2..06f5a28601 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -32,6 +32,7 @@
 #include "hw/block/flash.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
+#include "sysemu/reset.h"
 #include "hw/boards.h"
 #include "sysemu/device_tree.h"
 #include "hw/loader.h"
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index ca69a1bcd8..61bd4d5170 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "sysemu/reset.h"
 #include "hw/sysbus.h"
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 60bd081d3e..2e5ce11a6b 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/error.h"
+#include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/tcg.h"
 #include "cpu.h"
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 5b6a9a4e55..4ffdd53a85 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -27,6 +27,7 @@
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "s390-pci-bus.h"
+#include "sysemu/reset.h"
 #include "hw/s390x/storage-keys.h"
 #include "hw/s390x/storage-attributes.h"
 #include "hw/s390x/event-facility.h"
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index f22c79c867..da79bf0337 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -30,6 +30,7 @@
 #include "hw/sysbus.h"
 #include "hw/hw.h"
 #include "hw/sh4/sh.h"
+#include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
 #include "hw/pci/pci.h"
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 19cedebd16..c7ddfa2cfe 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -21,6 +21,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/error-report.h"
@@ -32,6 +33,7 @@
 #include "hw/ptimer.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
+#include "sysemu/reset.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "elf.h"
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index b2342f2a89..93a69c12fb 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -21,6 +21,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
@@ -33,6 +34,7 @@
 #include "hw/timer/m48t59.h"
 #include "hw/sparc/sparc32_dma.h"
 #include "hw/block/fdc.h"
+#include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "net/net.h"
 #include "hw/boards.h"
diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index 689801f37d..100b2fab17 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -28,6 +28,7 @@
 #include "hw/char/serial.h"
 #include "hw/sparc/sparc64.h"
 #include "qemu/timer.h"
+#include "sysemu/reset.h"
 #include "trace.h"
=20
=20
diff --git a/hw/timer/etraxfs_timer.c b/hw/timer/etraxfs_timer.c
index 53834e197f..18887b2be2 100644
--- a/hw/timer/etraxfs_timer.c
+++ b/hw/timer/etraxfs_timer.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index ce4550b6f2..21fcba5e3a 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -31,6 +31,7 @@
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/replay.h"
+#include "sysemu/reset.h"
 #include "hw/timer/mc146818rtc.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc-target.h"
diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
index cd8205f212..ff314592b4 100644
--- a/hw/tpm/tpm_ppi.c
+++ b/hw/tpm/tpm_ppi.c
@@ -16,7 +16,6 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "sysemu/memory_mapping.h"
-#include "sysemu/reset.h"
 #include "migration/vmstate.h"
 #include "tpm_ppi.h"
 #include "trace.h"
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index a859298fda..a363b4495f 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -34,6 +34,7 @@
 #include "qemu/range.h"
 #include "sysemu/balloon.h"
 #include "sysemu/kvm.h"
+#include "sysemu/reset.h"
 #include "trace.h"
 #include "qapi/error.h"
=20
diff --git a/hw/watchdog/wdt_diag288.c b/hw/watchdog/wdt_diag288.c
index 29e5b5dcf6..fec046ef09 100644
--- a/hw/watchdog/wdt_diag288.c
+++ b/hw/watchdog/wdt_diag288.c
@@ -12,6 +12,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "sysemu/reset.h"
 #include "sysemu/watchdog.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 09165b6f4d..981dbb7bbe 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index f7f3e11e93..0a2cce3c64 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -41,6 +41,7 @@
 #include "hw/block/flash.h"
 #include "chardev/char.h"
 #include "sysemu/device_tree.h"
+#include "sysemu/reset.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "bootparam.h"
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 19751e37a7..80f1443110 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -26,6 +26,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "sysemu/kvm.h"
+#include "sysemu/reset.h"
 #include "sysemu/hvf.h"
 #include "sysemu/cpus.h"
 #include "kvm_i386.h"
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index 9e7b77965d..bcacdd1d8f 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -30,6 +30,7 @@
 #include "qemu-common.h"
 #include "hax-i386.h"
 #include "sysemu/accel.h"
+#include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "qemu/main-loop.h"
 #include "hw/boards.h"
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index dbbb13772a..30ed209e6b 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -24,6 +24,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm_int.h"
+#include "sysemu/reset.h"
 #include "kvm_i386.h"
 #include "hyperv.h"
 #include "hyperv-proto.h"
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 736a7903e2..3caba8d5e1 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -26,6 +26,7 @@
 #include "internal.h"
 #include "kvm_s390x.h"
 #include "sysemu/kvm.h"
+#include "sysemu/reset.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/vl.c b/vl.c
index b426b32134..1abfd306e3 100644
--- a/vl.c
+++ b/vl.c
@@ -30,6 +30,7 @@
 #include "qemu/cutils.h"
 #include "qemu/help_option.h"
 #include "qemu/uuid.h"
+#include "sysemu/reset.h"
 #include "sysemu/seccomp.h"
 #include "sysemu/tcg.h"
=20
--=20
2.21.0


