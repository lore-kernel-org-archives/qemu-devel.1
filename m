Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C25FC74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:34:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C2B420872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2B420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlYH8-0000pT-NH
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 08:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53279)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hlYBm-0004zW-5c
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hlYBc-0001sX-0S
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:28:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54100)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hlYBb-0001pK-5M
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:28:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CCCC8308427C;
 Thu, 11 Jul 2019 12:28:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9F7419C70;
 Thu, 11 Jul 2019 12:28:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6C5991138660; Thu, 11 Jul 2019 14:28:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 14:28:25 +0200
Message-Id: <20190711122827.18970-2-armbru@redhat.com>
In-Reply-To: <20190711122827.18970-1-armbru@redhat.com>
References: <20190711122827.18970-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 11 Jul 2019 12:28:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH RFC v5 1/3] tests: New make target check-source
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
Cc: peter.maydell@linaro.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make target check-source is for checking the source code itself.  For
now, there's just one such check, make target check-headers.  It
checks basic header sanity: for each header "FOO.h", test whether

	#include "qemu/osdep.h"
	#include "FOO.h"
	#include "FOO.h"

compiles.

The test works only in a git tree, with git installed.  It is skipped
unless $(SRC_PATH)/.git exists.

Third-party headers we don't intend to clean up are excluded from this
test.  So are a few "funny" headers.  See make variable
excluded-headers.

Numerous headers don't pass this test, by design or by accident.  To
keep things more manageable, exclude all headers outside include/ for
now.

Headers known to fail the test are marked with

    /* FIXME Does not pass make check-headers, yet! */

Headers known to work only in certain configurations are marked like

    /* FIXME Does not pass make check-headers without CONFIG_WIN32, yet! =
*/

I tried to find and mark all of them by testing various
configurations.  Still, "make check" might fail for configurations I
didn't test.

Known issue: some of these don't actually need fixing; they're *meant*
to work only in certain configurations.  We'll want to invent a
suitable marker that doesn't claim FIXME.

Some headers may only be included into target-dependent code: they use
identifiers poisoned by exec/poison.h, or include cpu.h.  These
headers are marked with a comment

    /* NOTE: May only be included into target-dependent code */

The test treats them specially.

Known issue: some of these are intended for specific targets.  The
test should skip them for other targets, but doesn't.  They're marked
FIXME instead, which is wrong.

New make target check-bad-headers runs the test for headers expected
to fail it.  This helps with examining the failures.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 Makefile                                  |  4 +-
 Makefile.target                           | 20 +++++
 include/block/raw-aio.h                   |  3 +
 include/block/write-threshold.h           |  3 +
 include/chardev/char-win.h                |  3 +
 include/chardev/spice.h                   |  2 +
 include/disas/disas.h                     |  2 +
 include/exec/cpu-all.h                    |  4 +
 include/exec/cpu-defs.h                   |  3 +
 include/exec/cpu_ldst.h                   |  4 +
 include/exec/cpu_ldst_template.h          |  3 +
 include/exec/cpu_ldst_useronly_template.h |  3 +
 include/exec/cputlb.h                     |  3 +
 include/exec/exec-all.h                   |  3 +
 include/exec/gen-icount.h                 |  2 +
 include/exec/helper-gen.h                 |  2 +
 include/exec/helper-proto.h               |  2 +
 include/exec/helper-tcg.h                 |  2 +
 include/exec/ioport.h                     |  2 +
 include/exec/memory-internal.h            |  2 +
 include/exec/memory_ldst.inc.h            |  2 +
 include/exec/memory_ldst_cached.inc.h     |  2 +
 include/exec/memory_ldst_phys.inc.h       |  2 +
 include/exec/ram_addr.h                   |  3 +
 include/exec/softmmu-semi.h               |  3 +
 include/exec/tb-hash.h                    |  3 +
 include/exec/tb-lookup.h                  |  3 +
 include/exec/translator.h                 |  3 +
 include/exec/user/abitypes.h              |  2 +
 include/exec/user/thunk.h                 |  4 +
 include/fpu/softfloat-macros.h            |  2 +
 include/fpu/softfloat.h                   |  2 +
 include/hw/acpi/pci.h                     |  3 +
 include/hw/acpi/tco.h                     |  3 +
 include/hw/adc/stm32f2xx_adc.h            |  2 +
 include/hw/arm/allwinner-a10.h            |  2 +
 include/hw/arm/armsse.h                   |  3 +
 include/hw/arm/armv7m.h                   |  3 +
 include/hw/arm/aspeed_soc.h               |  2 +
 include/hw/arm/bcm2835_peripherals.h      |  2 +
 include/hw/arm/bcm2836.h                  |  2 +
 include/hw/arm/digic.h                    |  3 +
 include/hw/arm/exynos4210.h               |  3 +-
 include/hw/arm/fsl-imx25.h                |  2 +
 include/hw/arm/fsl-imx31.h                |  2 +
 include/hw/arm/fsl-imx6.h                 |  3 +
 include/hw/arm/fsl-imx6ul.h               |  3 +
 include/hw/arm/fsl-imx7.h                 |  3 +
 include/hw/arm/msf2-soc.h                 |  3 +
 include/hw/arm/nrf51_soc.h                |  3 +
 include/hw/arm/omap.h                     |  2 +
 include/hw/arm/sharpsl.h                  |  3 +
 include/hw/arm/stm32f205_soc.h            |  3 +
 include/hw/arm/xlnx-zynqmp.h              |  2 +
 include/hw/block/fdc.h                    |  2 +
 include/hw/block/flash.h                  |  2 +
 include/hw/char/escc.h                    |  2 +
 include/hw/char/xilinx_uartlite.h         |  2 +
 include/hw/core/generic-loader.h          |  2 +
 include/hw/cris/etraxfs.h                 |  2 +
 include/hw/cris/etraxfs_dma.h             |  2 +
 include/hw/display/bcm2835_fb.h           |  2 +
 include/hw/display/i2c-ddc.h              |  2 +
 include/hw/display/xlnx_dp.h              |  2 +
 include/hw/dma/xlnx_dpdma.h               |  2 +
 include/hw/elf_ops.h                      |  2 +
 include/hw/empty_slot.h                   |  2 +
 include/hw/gpio/bcm2835_gpio.h            |  2 +
 include/hw/hyperv/hyperv.h                |  2 +
 include/hw/i2c/aspeed_i2c.h               |  3 +
 include/hw/i386/apic_internal.h           |  3 +
 include/hw/i386/ioapic_internal.h         |  2 +
 include/hw/input/hid.h                    |  2 +
 include/hw/input/tsc2xxx.h                |  2 +
 include/hw/intc/allwinner-a10-pic.h       |  2 +
 include/hw/intc/armv7m_nvic.h             |  3 +
 include/hw/intc/heathrow_pic.h            |  2 +
 include/hw/intc/mips_gic.h                |  3 +
 include/hw/isa/vt82c686.h                 |  2 +
 include/hw/kvm/clock.h                    |  2 +
 include/hw/mips/bios.h                    |  2 +
 include/hw/mips/cps.h                     |  3 +
 include/hw/mips/cpudevs.h                 |  2 +
 include/hw/misc/bcm2835_property.h        |  2 +
 include/hw/misc/macio/cuda.h              |  2 +
 include/hw/misc/macio/gpio.h              |  2 +
 include/hw/misc/macio/macio.h             |  2 +
 include/hw/misc/macio/pmu.h               |  2 +
 include/hw/misc/mips_cmgcr.h              |  2 +
 include/hw/misc/mips_cpc.h                |  2 +
 include/hw/misc/pvpanic.h                 |  3 +
 include/hw/net/allwinner_emac.h           |  2 +
 include/hw/net/lance.h                    |  2 +
 include/hw/nvram/chrp_nvram.h             |  2 +
 include/hw/pci-host/sabre.h               |  2 +
 include/hw/pci-host/spapr.h               |  3 +
 include/hw/pci-host/uninorth.h            |  2 +
 include/hw/pci/pcie_aer.h                 |  2 +
 include/hw/ppc/fdt.h                      |  2 +
 include/hw/ppc/pnv.h                      |  2 +
 include/hw/ppc/pnv_core.h                 |  2 +
 include/hw/ppc/pnv_xscom.h                |  2 +
 include/hw/ppc/ppc.h                      |  2 +
 include/hw/ppc/ppc4xx.h                   |  2 +
 include/hw/ppc/spapr.h                    |  3 +
 include/hw/ppc/spapr_cpu_core.h           |  4 +
 include/hw/ppc/spapr_irq.h                |  2 +
 include/hw/ppc/spapr_ovec.h               |  2 +
 include/hw/ppc/spapr_vio.h                |  2 +
 include/hw/ppc/spapr_xive.h               |  2 +
 include/hw/ppc/xics_spapr.h               |  3 +
 include/hw/ppc/xive_regs.h                |  2 +
 include/hw/riscv/boot.h                   |  2 +
 include/hw/riscv/riscv_hart.h             |  2 +
 include/hw/riscv/riscv_htif.h             |  3 +
 include/hw/riscv/sifive_clint.h           |  2 +
 include/hw/riscv/sifive_e.h               |  2 +
 include/hw/riscv/sifive_plic.h            |  2 +
 include/hw/riscv/sifive_prci.h            |  2 +
 include/hw/riscv/sifive_test.h            |  2 +
 include/hw/riscv/sifive_u.h               |  2 +
 include/hw/riscv/sifive_uart.h            |  2 +
 include/hw/riscv/spike.h                  |  2 +
 include/hw/riscv/virt.h                   |  2 +
 include/hw/s390x/3270-ccw.h               |  3 +
 include/hw/s390x/ap-device.h              |  3 +
 include/hw/s390x/css-bridge.h             |  2 +
 include/hw/s390x/css.h                    |  3 +
 include/hw/s390x/s390-ccw.h               |  3 +
 include/hw/s390x/storage-attributes.h     |  3 +
 include/hw/s390x/tod.h                    |  2 +
 include/hw/s390x/vfio-ccw.h               |  3 +
 include/hw/semihosting/console.h          |  3 +
 include/hw/sh4/sh.h                       |  2 +
 include/hw/sh4/sh_intc.h                  |  2 +
 include/hw/sparc/sparc64.h                |  2 +
 include/hw/ssi/aspeed_smc.h               |  2 +
 include/hw/ssi/xilinx_spips.h             |  2 +
 include/hw/timer/allwinner-a10-pit.h      |  2 +
 include/hw/timer/i8254_internal.h         |  2 +
 include/hw/timer/m48t59.h                 |  2 +
 include/hw/timer/mc146818rtc.h            |  2 +
 include/hw/timer/mc146818rtc_regs.h       |  2 +
 include/hw/timer/sun4v-rtc.h              |  2 +
 include/hw/timer/xlnx-zynqmp-rtc.h        |  2 +
 include/hw/vfio/vfio-amd-xgbe.h           |  2 +
 include/hw/vfio/vfio-calxeda-xgmac.h      |  2 +
 include/hw/vfio/vfio-common.h             |  2 +
 include/hw/vfio/vfio-platform.h           |  2 +
 include/hw/virtio/virtio-access.h         |  3 +
 include/hw/virtio/virtio-gpu-bswap.h      |  2 +
 include/hw/virtio/virtio-gpu-pci.h        |  2 +
 include/hw/virtio/virtio-gpu-pixman.h     |  2 +
 include/hw/virtio/virtio-gpu.h            |  2 +
 include/hw/virtio/virtio-input.h          |  2 +
 include/hw/virtio/virtio-rng.h            |  2 +
 include/hw/watchdog/wdt_aspeed.h          |  2 +
 include/hw/xen/xen-backend.h              |  3 +
 include/hw/xen/xen-block.h                |  3 +
 include/hw/xen/xen-bus-helper.h           |  3 +
 include/hw/xen/xen-bus.h                  |  3 +
 include/hw/xen/xen-legacy-backend.h       |  3 +
 include/hw/xen/xen_common.h               |  3 +
 include/hw/xen/xen_pvdev.h                |  3 +
 include/libdecnumber/decNumberLocal.h     |  2 +
 include/migration/cpu.h                   |  4 +
 include/monitor/hmp-target.h              |  3 +
 include/qemu/atomic128.h                  |  2 +
 include/qemu/cpuid.h                      |  2 +
 include/qemu/futex.h                      |  2 +
 include/qemu/ratelimit.h                  |  2 +
 include/qemu/thread-win32.h               |  2 +
 include/qemu/xattr.h                      |  3 +
 include/sysemu/balloon.h                  |  2 +
 include/sysemu/cryptodev-vhost-user.h     |  3 +
 include/sysemu/dump.h                     |  2 +
 include/sysemu/hvf.h                      |  3 +
 include/sysemu/iothread.h                 |  2 +
 include/sysemu/kvm_int.h                  |  2 +
 include/sysemu/memory_mapping.h           |  2 +
 include/sysemu/os-posix.h                 |  2 +
 include/sysemu/os-win32.h                 |  2 +
 include/sysemu/xen-mapcache.h             |  2 +
 include/trace-tcg.h                       |  2 +
 include/ui/console.h                      |  2 +
 include/ui/egl-context.h                  |  3 +
 include/ui/egl-helpers.h                  |  2 +
 include/ui/gtk.h                          |  2 +
 include/ui/input.h                        |  2 +
 include/ui/pixel_ops.h                    |  2 +
 include/ui/qemu-pixman.h                  |  2 +
 include/ui/sdl2.h                         |  2 +
 include/ui/shader.h                       |  2 +
 include/ui/spice-display.h                |  2 +
 tests/Makefile.include                    | 33 +++++++-
 tests/check-headers.mak                   | 92 +++++++++++++++++++++++
 tests/header-test-template.c              | 23 ++++++
 197 files changed, 618 insertions(+), 4 deletions(-)
 create mode 100644 tests/check-headers.mak
 create mode 100644 tests/header-test-template.c

diff --git a/Makefile b/Makefile
index c63de4e36c..f8e919bc1a 100644
--- a/Makefile
+++ b/Makefile
@@ -434,6 +434,8 @@ dummy :=3D $(call unnest-vars,, \
                 audio-obj-m \
                 trace-obj-y)
=20
+RECURSIVE_TARGETS :=3D all clean install
+
 include $(SRC_PATH)/tests/Makefile.include
=20
 all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurs=
e-all modules $(vhost-user-json-y)
@@ -454,7 +456,7 @@ config-host.h-timestamp: config-host.mak
 qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","=
$@")
=20
-TARGET_DIRS_RULES :=3D $(foreach t, all clean install, $(addsuffix /$(t)=
, $(TARGET_DIRS)))
+TARGET_DIRS_RULES:=3D$(foreach t, $(RECURSIVE_TARGETS), $(addsuffix /$(t=
), $(TARGET_DIRS)))
=20
 SOFTMMU_ALL_RULES=3D$(filter %-softmmu/all, $(TARGET_DIRS_RULES))
 $(SOFTMMU_ALL_RULES): $(authz-obj-y)
diff --git a/Makefile.target b/Makefile.target
index 85216cace8..25620d913d 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -41,6 +41,7 @@ STPFILES=3D
=20
 # Makefile Tests
 include $(SRC_PATH)/tests/tcg/Makefile.include
+include $(SRC_PATH)/tests/check-headers.mak
=20
 config-target.h: config-target.h-timestamp
 config-target.h-timestamp: config-target.mak
@@ -220,6 +221,23 @@ hmp-commands.h: $(SRC_PATH)/hmp-commands.hx $(SRC_PA=
TH)/scripts/hxtool
 hmp-commands-info.h: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/script=
s/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","=
$(TARGET_DIR)$@")
=20
+.PHONY: check-headers
+ifeq ($(wildcard $(SRC_PATH)/.git),)
+check-headers check-bad-headers:
+	@echo "  SKIP  $@ (requires a git tree)"
+else
+check-headers: CFLAGS +=3D -g0	# save disk space
+check-headers: $(check-target-header-tests:.c=3D.o)
+
+# Expected to fail:
+check-bad-headers: $(check-bad-target-header-tests:.c=3D.o)
+
+.SECONDARY: $(check-target-header-tests) $(check-bad-target-header-tests=
)
+$(check-target-header-tests) $(check-bad-target-header-tests): tests/hea=
der-test-template.c
+	@mkdir -p $(dir $@)
+	@sed 's,@header@,$(subst tests/headers-tgt/,,$(@:.c=3D.h)),' <$< >$@
+endif
+
 clean: clean-target
 	rm -f *.a *~ $(PROGS)
 	rm -f $(shell find . -name '*.[od]')
@@ -258,3 +276,5 @@ Makefile: $(generated-files-y)
=20
 .PHONY: coverage-report
 coverage-report: $(CURDIR)/reports/coverage/coverage-report.html
+
+-include $(check-target-header-tests:.c=3D.d) $(check-bad-target-header-=
tests:.c=3D.d)
diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
index 0cb7cc74a2..3e7692eb64 100644
--- a/include/block/raw-aio.h
+++ b/include/block/raw-aio.h
@@ -12,6 +12,9 @@
  * Contributions after 2012-01-13 are licensed under the terms of the
  * GNU GPL, version 2 or (at your option) any later version.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_RAW_AIO_H
 #define QEMU_RAW_AIO_H
=20
diff --git a/include/block/write-threshold.h b/include/block/write-thresh=
old.h
index 80d8aab5d0..7b5adb2e6e 100644
--- a/include/block/write-threshold.h
+++ b/include/block/write-threshold.h
@@ -9,6 +9,9 @@
  * This work is licensed under the terms of the GNU LGPL, version 2 or l=
ater.
  * See the COPYING.LIB file in the top-level directory.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef BLOCK_WRITE_THRESHOLD_H
 #define BLOCK_WRITE_THRESHOLD_H
=20
diff --git a/include/chardev/char-win.h b/include/chardev/char-win.h
index fa59e9e423..423fa8dcd2 100644
--- a/include/chardev/char-win.h
+++ b/include/chardev/char-win.h
@@ -21,6 +21,9 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
+/* FIXME Does not pass make check-headers without CONFIG_WIN32, yet! */
+
 #ifndef CHAR_WIN_H
 #define CHAR_WIN_H
=20
diff --git a/include/chardev/spice.h b/include/chardev/spice.h
index 1f7339b649..2bc2a992b5 100644
--- a/include/chardev/spice.h
+++ b/include/chardev/spice.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers without CONFIG_SPICE, yet! */
+
 #ifndef CHARDEV_SPICE_H
 #define CHARDEV_SPICE_H
=20
diff --git a/include/disas/disas.h b/include/disas/disas.h
index 15da511f49..f60bbc752c 100644
--- a/include/disas/disas.h
+++ b/include/disas/disas.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_DISAS_H
 #define QEMU_DISAS_H
=20
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 536ea58f81..f0f900b9e1 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -16,6 +16,10 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
+
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef CPU_ALL_H
 #define CPU_ALL_H
=20
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 9bc713a70b..4710900f6d 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
+
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef CPU_DEFS_H
 #define CPU_DEFS_H
=20
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index a08b11bd2c..83331b4a64 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -44,6 +44,10 @@
  * (for softmmu configs)  a target-specific MMU mode suffix as defined
  * in target cpu.h.
  */
+
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef CPU_LDST_H
 #define CPU_LDST_H
=20
diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_tem=
plate.h
index af7e0b49f2..6ab493f833 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -24,6 +24,9 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #if !defined(SOFTMMU_CODE_ACCESS)
 #include "trace-root.h"
 #endif
diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu=
_ldst_useronly_template.h
index bc45e2b8d4..0de722ab43 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -23,6 +23,9 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #if !defined(CODE_ACCESS)
 #include "trace-root.h"
 #endif
diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 5373188be3..361df6dee0 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef CPUTLB_H
 #define CPUTLB_H
=20
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 16034ee651..547f539acc 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef EXEC_ALL_H
 #define EXEC_ALL_H
=20
diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index f7669b6841..39b2a72551 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef GEN_ICOUNT_H
 #define GEN_ICOUNT_H
=20
diff --git a/include/exec/helper-gen.h b/include/exec/helper-gen.h
index 22381a1708..63e4856b43 100644
--- a/include/exec/helper-gen.h
+++ b/include/exec/helper-gen.h
@@ -1,6 +1,8 @@
 /* Helper file for declaring TCG helper functions.
    This one expands generation functions for tcg opcodes.  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HELPER_GEN_H
 #define HELPER_GEN_H
=20
diff --git a/include/exec/helper-proto.h b/include/exec/helper-proto.h
index 74943edb13..e5a1b9403d 100644
--- a/include/exec/helper-proto.h
+++ b/include/exec/helper-proto.h
@@ -1,6 +1,8 @@
 /* Helper file for declaring TCG helper functions.
    This one expands prototypes for the helper functions.  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HELPER_PROTO_H
 #define HELPER_PROTO_H
=20
diff --git a/include/exec/helper-tcg.h b/include/exec/helper-tcg.h
index 268e0f804b..51e4758082 100644
--- a/include/exec/helper-tcg.h
+++ b/include/exec/helper-tcg.h
@@ -1,6 +1,8 @@
 /* Helper file for declaring TCG helper functions.
    This one defines data structures private to tcg.c.  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HELPER_TCG_H
 #define HELPER_TCG_H
=20
diff --git a/include/exec/ioport.h b/include/exec/ioport.h
index a298b89ce1..96dc6f5662 100644
--- a/include/exec/ioport.h
+++ b/include/exec/ioport.h
@@ -21,6 +21,8 @@
  * IO ports API
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef IOPORT_H
 #define IOPORT_H
=20
diff --git a/include/exec/memory-internal.h b/include/exec/memory-interna=
l.h
index d1a9dd1ec8..d16ec2d36d 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -17,6 +17,8 @@
  * internals and the TCG TLB code. Do not include it from elsewhere.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MEMORY_INTERNAL_H
 #define MEMORY_INTERNAL_H
=20
diff --git a/include/exec/memory_ldst.inc.h b/include/exec/memory_ldst.in=
c.h
index 272c20f02e..7846e99b6d 100644
--- a/include/exec/memory_ldst.inc.h
+++ b/include/exec/memory_ldst.inc.h
@@ -19,6 +19,8 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifdef TARGET_ENDIANNESS
 extern uint32_t glue(address_space_lduw, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
diff --git a/include/exec/memory_ldst_cached.inc.h b/include/exec/memory_=
ldst_cached.inc.h
index fd4bbb40e7..9725005455 100644
--- a/include/exec/memory_ldst_cached.inc.h
+++ b/include/exec/memory_ldst_cached.inc.h
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #define ADDRESS_SPACE_LD_CACHED(size) \
     glue(glue(address_space_ld, size), glue(ENDIANNESS, _cached))
 #define ADDRESS_SPACE_LD_CACHED_SLOW(size) \
diff --git a/include/exec/memory_ldst_phys.inc.h b/include/exec/memory_ld=
st_phys.inc.h
index 91f72973cb..8cd1828f8c 100644
--- a/include/exec/memory_ldst_phys.inc.h
+++ b/include/exec/memory_ldst_phys.inc.h
@@ -19,6 +19,8 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifdef TARGET_ENDIANNESS
 static inline uint32_t glue(ldl_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
 {
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index f96777bb99..507050a2e7 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -16,6 +16,9 @@
  * The functions declared here will be removed soon.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef RAM_ADDR_H
 #define RAM_ADDR_H
=20
diff --git a/include/exec/softmmu-semi.h b/include/exec/softmmu-semi.h
index 970837992e..551c013652 100644
--- a/include/exec/softmmu-semi.h
+++ b/include/exec/softmmu-semi.h
@@ -7,6 +7,9 @@
  * This code is licensed under the GPL
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef SOFTMMU_SEMI_H
 #define SOFTMMU_SEMI_H
=20
diff --git a/include/exec/tb-hash.h b/include/exec/tb-hash.h
index 4f3a37d927..79e53fb73d 100644
--- a/include/exec/tb-hash.h
+++ b/include/exec/tb-hash.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef EXEC_TB_HASH_H
 #define EXEC_TB_HASH_H
=20
diff --git a/include/exec/tb-lookup.h b/include/exec/tb-lookup.h
index 26921b6daf..93d6ebd148 100644
--- a/include/exec/tb-lookup.h
+++ b/include/exec/tb-lookup.h
@@ -4,6 +4,9 @@
  * License: GNU GPL, version 2 or later.
  *   See the COPYING file in the top-level directory.
  */
+
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef EXEC_TB_LOOKUP_H
 #define EXEC_TB_LOOKUP_H
=20
diff --git a/include/exec/translator.h b/include/exec/translator.h
index 180c51d509..301c740c4e 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -7,6 +7,9 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef EXEC__TRANSLATOR_H
 #define EXEC__TRANSLATOR_H
=20
diff --git a/include/exec/user/abitypes.h b/include/exec/user/abitypes.h
index 743b8bb9ea..626840d9c2 100644
--- a/include/exec/user/abitypes.h
+++ b/include/exec/user/abitypes.h
@@ -1,3 +1,5 @@
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef EXEC_USER_ABITYPES_H
 #define EXEC_USER_ABITYPES_H
=20
diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
index 8d3af5a3be..933fd77436 100644
--- a/include/exec/user/thunk.h
+++ b/include/exec/user/thunk.h
@@ -16,6 +16,10 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
+
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef THUNK_H
 #define THUNK_H
=20
diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macro=
s.h
index c55aa6d174..df33e55c70 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -79,6 +79,8 @@ this code that are retained.
  * version 2 or later. See the COPYING file in the top-level directory.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef FPU_SOFTFLOAT_MACROS_H
 #define FPU_SOFTFLOAT_MACROS_H
=20
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 3ff3fa5224..303512c8a3 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -79,6 +79,8 @@ this code that are retained.
  * version 2 or later. See the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef SOFTFLOAT_H
 #define SOFTFLOAT_H
=20
diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
index 8bbd32cf45..45d8a38589 100644
--- a/include/hw/acpi/pci.h
+++ b/include/hw/acpi/pci.h
@@ -22,6 +22,9 @@
  * You should have received a copy of the GNU General Public License alo=
ng
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_ACPI_PCI_H
 #define HW_ACPI_PCI_H
=20
diff --git a/include/hw/acpi/tco.h b/include/hw/acpi/tco.h
index d19dd59353..1f3c2d17fb 100644
--- a/include/hw/acpi/tco.h
+++ b/include/hw/acpi/tco.h
@@ -6,6 +6,9 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_ACPI_TCO_H
 #define HW_ACPI_TCO_H
=20
diff --git a/include/hw/adc/stm32f2xx_adc.h b/include/hw/adc/stm32f2xx_ad=
c.h
index a72f734eb1..8e67c0f24d 100644
--- a/include/hw/adc/stm32f2xx_adc.h
+++ b/include/hw/adc/stm32f2xx_adc.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_STM32F2XX_ADC_H
 #define HW_STM32F2XX_ADC_H
=20
diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a1=
0.h
index e99fe2ea2e..e8b8cc2ceb 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_ARM_ALLWINNER_A10_H
 #define HW_ARM_ALLWINNER_A10_H
=20
diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index 84080c2299..201893ccf5 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -86,6 +86,9 @@
  *  + named GPIO outputs mscexp_ns[0..15]
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ARMSSE_H
 #define ARMSSE_H
=20
diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
index d2c74d3872..fdb777d875 100644
--- a/include/hw/arm/armv7m.h
+++ b/include/hw/arm/armv7m.h
@@ -7,6 +7,9 @@
  * This code is licensed under the GPL version 2 or later.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_ARM_ARMV7M_H
 #define HW_ARM_ARMV7M_H
=20
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index cef605ad6b..c502ef0e65 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -9,6 +9,8 @@
  * the COPYING file in the top-level directory.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ASPEED_SOC_H
 #define ASPEED_SOC_H
=20
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm283=
5_peripherals.h
index 6b17f6a382..79bb258467 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -8,6 +8,8 @@
  * This code is licensed under the GNU GPLv2 and later.
  */
=20
+/* FIXME Does not pass make check-headers without pixman, yet! */
+
 #ifndef BCM2835_PERIPHERALS_H
 #define BCM2835_PERIPHERALS_H
=20
diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index a2cb8454de..aaa12f5cdb 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -8,6 +8,8 @@
  * This code is licensed under the GNU GPLv2 and later.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef BCM2836_H
 #define BCM2836_H
=20
diff --git a/include/hw/arm/digic.h b/include/hw/arm/digic.h
index 63785baaa8..79f9278c64 100644
--- a/include/hw/arm/digic.h
+++ b/include/hw/arm/digic.h
@@ -15,6 +15,9 @@
  *
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_ARM_DIGIC_H
 #define HW_ARM_DIGIC_H
=20
diff --git a/include/hw/arm/exynos4210.h b/include/hw/arm/exynos4210.h
index aa137271c0..0d0898e613 100644
--- a/include/hw/arm/exynos4210.h
+++ b/include/hw/arm/exynos4210.h
@@ -19,9 +19,10 @@
  *
  *  You should have received a copy of the GNU General Public License al=
ong
  *  with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef EXYNOS4210_H
 #define EXYNOS4210_H
=20
diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
index 3280ab1fb0..61028eaa99 100644
--- a/include/hw/arm/fsl-imx25.h
+++ b/include/hw/arm/fsl-imx25.h
@@ -14,6 +14,8 @@
  * for more details.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef FSL_IMX25_H
 #define FSL_IMX25_H
=20
diff --git a/include/hw/arm/fsl-imx31.h b/include/hw/arm/fsl-imx31.h
index e68a81efd7..bff92e79c0 100644
--- a/include/hw/arm/fsl-imx31.h
+++ b/include/hw/arm/fsl-imx31.h
@@ -14,6 +14,8 @@
  * for more details.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef FSL_IMX31_H
 #define FSL_IMX31_H
=20
diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 1265a55c3b..230d44c793 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -14,6 +14,9 @@
  * for more details.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef FSL_IMX6_H
 #define FSL_IMX6_H
=20
diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 9e94e98f8e..25e8540908 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -14,6 +14,9 @@
  * GNU General Public License for more details.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef FSL_IMX6UL_H
 #define FSL_IMX6UL_H
=20
diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 8003d45d1e..e32873ca73 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -16,6 +16,9 @@
  * GNU General Public License for more details.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef FSL_IMX7_H
 #define FSL_IMX7_H
=20
diff --git a/include/hw/arm/msf2-soc.h b/include/hw/arm/msf2-soc.h
index 3cfe5c76ee..3a209e48b8 100644
--- a/include/hw/arm/msf2-soc.h
+++ b/include/hw/arm/msf2-soc.h
@@ -22,6 +22,9 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_ARM_MSF2_SOC_H
 #define HW_ARM_MSF2_SOC_H
=20
diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
index 0cb78aafea..b5a3da0bdc 100644
--- a/include/hw/arm/nrf51_soc.h
+++ b/include/hw/arm/nrf51_soc.h
@@ -7,6 +7,9 @@
  * the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef NRF51_SOC_H
 #define NRF51_SOC_H
=20
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index d21e418242..f28f803860 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -17,6 +17,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* FIXME Does not pass make check-headers without pixman, yet! */
+
 #ifndef HW_ARM_OMAP_H
 #define HW_ARM_OMAP_H
=20
diff --git a/include/hw/arm/sharpsl.h b/include/hw/arm/sharpsl.h
index 5bf6db1fa2..dc456653e1 100644
--- a/include/hw/arm/sharpsl.h
+++ b/include/hw/arm/sharpsl.h
@@ -3,6 +3,9 @@
  *
  * This file is licensed under the GNU GPL.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_SHARPSL_H
 #define QEMU_SHARPSL_H
=20
diff --git a/include/hw/arm/stm32f205_soc.h b/include/hw/arm/stm32f205_so=
c.h
index 922a733f88..4558c64823 100644
--- a/include/hw/arm/stm32f205_soc.h
+++ b/include/hw/arm/stm32f205_soc.h
@@ -22,6 +22,9 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_ARM_STM32F205_SOC_H
 #define HW_ARM_STM32F205_SOC_H
=20
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index 35804ea80a..8c4a3a2815 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -15,6 +15,8 @@
  * for more details.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef XLNX_ZYNQMP_H
 #define XLNX_ZYNQMP_H
=20
diff --git a/include/hw/block/fdc.h b/include/hw/block/fdc.h
index 8cece84326..d43a2fbd66 100644
--- a/include/hw/block/fdc.h
+++ b/include/hw/block/fdc.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_FDC_H
 #define HW_FDC_H
=20
diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
index 1acaf7de80..15ce2b3f14 100644
--- a/include/hw/block/flash.h
+++ b/include/hw/block/flash.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_FLASH_H
 #define HW_FLASH_H
=20
diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
index 42aca83611..71b95dd152 100644
--- a/include/hw/char/escc.h
+++ b/include/hw/char/escc.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_ESCC_H
 #define HW_ESCC_H
=20
diff --git a/include/hw/char/xilinx_uartlite.h b/include/hw/char/xilinx_u=
artlite.h
index 634086b657..a003b5977f 100644
--- a/include/hw/char/xilinx_uartlite.h
+++ b/include/hw/char/xilinx_uartlite.h
@@ -12,6 +12,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef XILINX_UARTLITE_H
 #define XILINX_UARTLITE_H
=20
diff --git a/include/hw/core/generic-loader.h b/include/hw/core/generic-l=
oader.h
index dd27c42ab0..3827144a5f 100644
--- a/include/hw/core/generic-loader.h
+++ b/include/hw/core/generic-loader.h
@@ -15,6 +15,8 @@
  * for more details.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef GENERIC_LOADER_H
 #define GENERIC_LOADER_H
=20
diff --git a/include/hw/cris/etraxfs.h b/include/hw/cris/etraxfs.h
index 8da965addb..108692bac3 100644
--- a/include/hw/cris/etraxfs.h
+++ b/include/hw/cris/etraxfs.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_ETRAXFS_H
 #define HW_ETRAXFS_H
=20
diff --git a/include/hw/cris/etraxfs_dma.h b/include/hw/cris/etraxfs_dma.=
h
index f6f33e0980..a1c6ce44ba 100644
--- a/include/hw/cris/etraxfs_dma.h
+++ b/include/hw/cris/etraxfs_dma.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_ETRAXFS_DMA_H
 #define HW_ETRAXFS_DMA_H
=20
diff --git a/include/hw/display/bcm2835_fb.h b/include/hw/display/bcm2835=
_fb.h
index 228988ba05..734d4d92ad 100644
--- a/include/hw/display/bcm2835_fb.h
+++ b/include/hw/display/bcm2835_fb.h
@@ -8,6 +8,8 @@
  * This code is licensed under the GNU GPLv2 and later.
  */
=20
+/* FIXME Does not pass make check-headers without pixman, yet! */
+
 #ifndef BCM2835_FB_H
 #define BCM2835_FB_H
=20
diff --git a/include/hw/display/i2c-ddc.h b/include/hw/display/i2c-ddc.h
index c29443c5af..814be09922 100644
--- a/include/hw/display/i2c-ddc.h
+++ b/include/hw/display/i2c-ddc.h
@@ -16,6 +16,8 @@
  *  with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef I2C_DDC_H
 #define I2C_DDC_H
=20
diff --git a/include/hw/display/xlnx_dp.h b/include/hw/display/xlnx_dp.h
index ab0dd250cc..9ee13d0160 100644
--- a/include/hw/display/xlnx_dp.h
+++ b/include/hw/display/xlnx_dp.h
@@ -21,6 +21,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* FIXME Does not pass make check-headers without pixman, yet! */
+
 #ifndef XLNX_DP_H
 #define XLNX_DP_H
=20
diff --git a/include/hw/dma/xlnx_dpdma.h b/include/hw/dma/xlnx_dpdma.h
index 7a304a5bb4..5fe621c650 100644
--- a/include/hw/dma/xlnx_dpdma.h
+++ b/include/hw/dma/xlnx_dpdma.h
@@ -22,6 +22,8 @@
  *
  */
=20
+/* FIXME Does not pass make check-headers without pixman, yet! */
+
 #ifndef XLNX_DPDMA_H
 #define XLNX_DPDMA_H
=20
diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index 690f9238c8..f873519cfd 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 static void glue(bswap_ehdr, SZ)(struct elfhdr *ehdr)
 {
     bswap16s(&ehdr->e_type);			/* Object file type */
diff --git a/include/hw/empty_slot.h b/include/hw/empty_slot.h
index 123a9f8989..249092a1cd 100644
--- a/include/hw/empty_slot.h
+++ b/include/hw/empty_slot.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_EMPTY_SLOT_H
 #define HW_EMPTY_SLOT_H
=20
diff --git a/include/hw/gpio/bcm2835_gpio.h b/include/hw/gpio/bcm2835_gpi=
o.h
index 9f8e0c720c..c24106aba5 100644
--- a/include/hw/gpio/bcm2835_gpio.h
+++ b/include/hw/gpio/bcm2835_gpio.h
@@ -11,6 +11,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef BCM2835_GPIO_H
 #define BCM2835_GPIO_H
=20
diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index 597381cb01..eab9724561 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -7,6 +7,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_HYPERV_HYPERV_H
 #define HW_HYPERV_HYPERV_H
=20
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index f9020acdef..ee215ff26e 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -17,6 +17,9 @@
  *  with this program; if not, write to the Free Software Foundation, In=
c.,
  *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ASPEED_I2C_H
 #define ASPEED_I2C_H
=20
diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_inter=
nal.h
index 1209eb483a..ec00577253 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -18,6 +18,9 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_APIC_INTERNAL_H
 #define QEMU_APIC_INTERNAL_H
=20
diff --git a/include/hw/i386/ioapic_internal.h b/include/hw/i386/ioapic_i=
nternal.h
index 07002f9662..9a9cd96788 100644
--- a/include/hw/i386/ioapic_internal.h
+++ b/include/hw/i386/ioapic_internal.h
@@ -19,6 +19,8 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_IOAPIC_INTERNAL_H
 #define QEMU_IOAPIC_INTERNAL_H
=20
diff --git a/include/hw/input/hid.h b/include/hw/input/hid.h
index 2127c7ce45..aec04352e0 100644
--- a/include/hw/input/hid.h
+++ b/include/hw/input/hid.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_HID_H
 #define QEMU_HID_H
=20
diff --git a/include/hw/input/tsc2xxx.h b/include/hw/input/tsc2xxx.h
index dbfe5c55c1..5d83270e00 100644
--- a/include/hw/input/tsc2xxx.h
+++ b/include/hw/input/tsc2xxx.h
@@ -8,6 +8,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* FIXME Does not pass make check-headers without pixman, yet! */
+
 #ifndef HW_INPUT_TSC2XXX_H
 #define HW_INPUT_TSC2XXX_H
=20
diff --git a/include/hw/intc/allwinner-a10-pic.h b/include/hw/intc/allwin=
ner-a10-pic.h
index 1d314a70d9..897d5ad6cc 100644
--- a/include/hw/intc/allwinner-a10-pic.h
+++ b/include/hw/intc/allwinner-a10-pic.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ALLWINNER_A10_PIC_H
 #define ALLWINNER_A10_PIC_H
=20
diff --git a/include/hw/intc/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.=
h
index a472c9b8f0..5bcb946035 100644
--- a/include/hw/intc/armv7m_nvic.h
+++ b/include/hw/intc/armv7m_nvic.h
@@ -7,6 +7,9 @@
  * This code is licensed under the GPL version 2 or later.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_ARM_ARMV7M_NVIC_H
 #define HW_ARM_ARMV7M_NVIC_H
=20
diff --git a/include/hw/intc/heathrow_pic.h b/include/hw/intc/heathrow_pi=
c.h
index 6c91ec91bb..9724912d59 100644
--- a/include/hw/intc/heathrow_pic.h
+++ b/include/hw/intc/heathrow_pic.h
@@ -23,6 +23,8 @@
  * THE SOFTWARE.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_INTC_HEATHROW_PIC_H
 #define HW_INTC_HEATHROW_PIC_H
=20
diff --git a/include/hw/intc/mips_gic.h b/include/hw/intc/mips_gic.h
index 902a12b178..870daa94c1 100644
--- a/include/hw/intc/mips_gic.h
+++ b/include/hw/intc/mips_gic.h
@@ -8,6 +8,9 @@
  *
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MIPS_GIC_H
 #define MIPS_GIC_H
=20
diff --git a/include/hw/isa/vt82c686.h b/include/hw/isa/vt82c686.h
index c3c2b6e786..49b3a96e4a 100644
--- a/include/hw/isa/vt82c686.h
+++ b/include/hw/isa/vt82c686.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_VT82C686_H
 #define HW_VT82C686_H
=20
diff --git a/include/hw/kvm/clock.h b/include/hw/kvm/clock.h
index 81c66b2302..f942b5fa9b 100644
--- a/include/hw/kvm/clock.h
+++ b/include/hw/kvm/clock.h
@@ -10,6 +10,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef HW_KVM_CLOCK_H
 #define HW_KVM_CLOCK_H
=20
diff --git a/include/hw/mips/bios.h b/include/hw/mips/bios.h
index c03007999a..6a43a397dc 100644
--- a/include/hw/mips/bios.h
+++ b/include/hw/mips/bios.h
@@ -1,3 +1,5 @@
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef HW_MIPS_BIOS_H
 #define HW_MIPS_BIOS_H
=20
diff --git a/include/hw/mips/cps.h b/include/hw/mips/cps.h
index aab1af926d..af8d25e142 100644
--- a/include/hw/mips/cps.h
+++ b/include/hw/mips/cps.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MIPS_CPS_H
 #define MIPS_CPS_H
=20
diff --git a/include/hw/mips/cpudevs.h b/include/hw/mips/cpudevs.h
index 291f59281a..fc80c53980 100644
--- a/include/hw/mips/cpudevs.h
+++ b/include/hw/mips/cpudevs.h
@@ -1,3 +1,5 @@
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef HW_MIPS_CPUDEVS_H
 #define HW_MIPS_CPUDEVS_H
=20
diff --git a/include/hw/misc/bcm2835_property.h b/include/hw/misc/bcm2835=
_property.h
index 11be0dbeac..41a668d54a 100644
--- a/include/hw/misc/bcm2835_property.h
+++ b/include/hw/misc/bcm2835_property.h
@@ -3,6 +3,8 @@
  * This code is licensed under the GNU GPLv2 and later.
  */
=20
+/* FIXME Does not pass make check-headers without pixman, yet! */
+
 #ifndef BCM2835_PROPERTY_H
 #define BCM2835_PROPERTY_H
=20
diff --git a/include/hw/misc/macio/cuda.h b/include/hw/misc/macio/cuda.h
index 7dad469142..562927e1da 100644
--- a/include/hw/misc/macio/cuda.h
+++ b/include/hw/misc/macio/cuda.h
@@ -23,6 +23,8 @@
  * THE SOFTWARE.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef CUDA_H
 #define CUDA_H
=20
diff --git a/include/hw/misc/macio/gpio.h b/include/hw/misc/macio/gpio.h
index 2838ae5fde..c5231896ce 100644
--- a/include/hw/misc/macio/gpio.h
+++ b/include/hw/misc/macio/gpio.h
@@ -23,6 +23,8 @@
  * THE SOFTWARE.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MACIO_GPIO_H
 #define MACIO_GPIO_H
=20
diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.=
h
index 970058b6ed..f19f756f38 100644
--- a/include/hw/misc/macio/macio.h
+++ b/include/hw/misc/macio/macio.h
@@ -23,6 +23,8 @@
  * THE SOFTWARE.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MACIO_H
 #define MACIO_H
=20
diff --git a/include/hw/misc/macio/pmu.h b/include/hw/misc/macio/pmu.h
index d10895ba5f..0ab3c06a7e 100644
--- a/include/hw/misc/macio/pmu.h
+++ b/include/hw/misc/macio/pmu.h
@@ -7,6 +7,8 @@
  * Copyright (C) 2016 Ben Herrenschmidt
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PMU_H
 #define PMU_H
=20
diff --git a/include/hw/misc/mips_cmgcr.h b/include/hw/misc/mips_cmgcr.h
index c9dfcb4b84..70b95ab163 100644
--- a/include/hw/misc/mips_cmgcr.h
+++ b/include/hw/misc/mips_cmgcr.h
@@ -7,6 +7,8 @@
  *
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MIPS_CMGCR_H
 #define MIPS_CMGCR_H
=20
diff --git a/include/hw/misc/mips_cpc.h b/include/hw/misc/mips_cpc.h
index 72c834e039..86d2705526 100644
--- a/include/hw/misc/mips_cpc.h
+++ b/include/hw/misc/mips_cpc.h
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MIPS_CPC_H
 #define MIPS_CPC_H
=20
diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index 1ee071a703..65c67e31f4 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -11,6 +11,9 @@
  * See the COPYING file in the top-level directory.
  *
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_MISC_PVPANIC_H
 #define HW_MISC_PVPANIC_H
=20
diff --git a/include/hw/net/allwinner_emac.h b/include/hw/net/allwinner_e=
mac.h
index 905a43deb4..9389cb82c6 100644
--- a/include/hw/net/allwinner_emac.h
+++ b/include/hw/net/allwinner_emac.h
@@ -20,6 +20,8 @@
  *
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ALLWINNER_EMAC_H
 #define ALLWINNER_EMAC_H
=20
diff --git a/include/hw/net/lance.h b/include/hw/net/lance.h
index ffdd35c4d7..2b99153bbc 100644
--- a/include/hw/net/lance.h
+++ b/include/hw/net/lance.h
@@ -26,6 +26,8 @@
  * THE SOFTWARE.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef LANCE_H
 #define LANCE_H
=20
diff --git a/include/hw/nvram/chrp_nvram.h b/include/hw/nvram/chrp_nvram.=
h
index b4f5b2b104..ae99396eab 100644
--- a/include/hw/nvram/chrp_nvram.h
+++ b/include/hw/nvram/chrp_nvram.h
@@ -15,6 +15,8 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef CHRP_NVRAM_H
 #define CHRP_NVRAM_H
=20
diff --git a/include/hw/pci-host/sabre.h b/include/hw/pci-host/sabre.h
index 9afa4938fd..003bd17842 100644
--- a/include/hw/pci-host/sabre.h
+++ b/include/hw/pci-host/sabre.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_PCI_HOST_SABRE_H
 #define HW_PCI_HOST_SABRE_H
=20
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 1b61162f91..9d2e3e313c 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PCI_HOST_SPAPR_H
 #define PCI_HOST_SPAPR_H
=20
diff --git a/include/hw/pci-host/uninorth.h b/include/hw/pci-host/uninort=
h.h
index 060324536a..b541fbc12d 100644
--- a/include/hw/pci-host/uninorth.h
+++ b/include/hw/pci-host/uninorth.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef UNINORTH_H
 #define UNINORTH_H
=20
diff --git a/include/hw/pci/pcie_aer.h b/include/hw/pci/pcie_aer.h
index 729a9439c8..a2e8bc77a7 100644
--- a/include/hw/pci/pcie_aer.h
+++ b/include/hw/pci/pcie_aer.h
@@ -18,6 +18,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_PCIE_AER_H
 #define QEMU_PCIE_AER_H
=20
diff --git a/include/hw/ppc/fdt.h b/include/hw/ppc/fdt.h
index a8cd85069f..39670f61a8 100644
--- a/include/hw/ppc/fdt.h
+++ b/include/hw/ppc/fdt.h
@@ -7,6 +7,8 @@
  * COPYING file in the top-level directory.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef PPC_FDT_H
 #define PPC_FDT_H
=20
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index fb123edc4e..3435ac4d13 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PPC_PNV_H
 #define PPC_PNV_H
=20
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index d0926454a9..403b9f1e49 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PPC_PNV_CORE_H
 #define PPC_PNV_CORE_H
=20
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 67641ed278..1ac2e1d948 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PPC_PNV_XSCOM_H
 #define PPC_PNV_XSCOM_H
=20
diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 4bdcb8bacd..d45cb675bf 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -1,3 +1,5 @@
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef HW_PPC_H
 #define HW_PPC_H
=20
diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index 39a7ba1ce6..2732200997 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PPC4XX_H
 #define PPC4XX_H
=20
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 60553d32c4..c7a31e43ea 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -1,3 +1,6 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_SPAPR_H
 #define HW_SPAPR_H
=20
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_c=
ore.h
index f9645a7290..980d9ded69 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -6,6 +6,10 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
  */
+
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_SPAPR_CPU_CORE_H
 #define HW_SPAPR_CPU_CORE_H
=20
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index f965a58f89..9d9ef40388 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -7,6 +7,8 @@
  * COPYING file in the top-level directory.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_SPAPR_IRQ_H
 #define HW_SPAPR_IRQ_H
=20
diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
index 5de5ecf5de..5d522b7526 100644
--- a/include/hw/ppc/spapr_ovec.h
+++ b/include/hw/ppc/spapr_ovec.h
@@ -34,6 +34,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef SPAPR_OVEC_H
 #define SPAPR_OVEC_H
=20
diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index 04609f214e..50cf292803 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_SPAPR_VIO_H
 #define HW_SPAPR_VIO_H
=20
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 7197144265..45a06cf4aa 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -7,6 +7,8 @@
  * COPYING file in the top-level directory.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PPC_SPAPR_XIVE_H
 #define PPC_SPAPR_XIVE_H
=20
diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
index 5dabc9a138..5372a160ab 100644
--- a/include/hw/ppc/xics_spapr.h
+++ b/include/hw/ppc/xics_spapr.h
@@ -24,6 +24,9 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef XICS_SPAPR_H
 #define XICS_SPAPR_H
=20
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 1a8c5b5e64..4a6ed49215 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -13,6 +13,8 @@
  * COPYING file in the top-level directory.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PPC_XIVE_REGS_H
 #define PPC_XIVE_REGS_H
=20
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index daa179b600..01c67335b1 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -17,6 +17,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef RISCV_BOOT_H
 #define RISCV_BOOT_H
=20
diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_hart.=
h
index 0671d88a44..846a22c17d 100644
--- a/include/hw/riscv/riscv_hart.h
+++ b/include/hw/riscv/riscv_hart.h
@@ -18,6 +18,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_RISCV_HART_H
 #define HW_RISCV_HART_H
=20
diff --git a/include/hw/riscv/riscv_htif.h b/include/hw/riscv/riscv_htif.=
h
index fb5f88129e..df385dacf4 100644
--- a/include/hw/riscv/riscv_htif.h
+++ b/include/hw/riscv/riscv_htif.h
@@ -17,6 +17,9 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_RISCV_HTIF_H
 #define HW_RISCV_HTIF_H
=20
diff --git a/include/hw/riscv/sifive_clint.h b/include/hw/riscv/sifive_cl=
int.h
index e2865be1d1..dd9999333f 100644
--- a/include/hw/riscv/sifive_clint.h
+++ b/include/hw/riscv/sifive_clint.h
@@ -17,6 +17,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_SIFIVE_CLINT_H
 #define HW_SIFIVE_CLINT_H
=20
diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
index d175b24cb2..a799718f2a 100644
--- a/include/hw/riscv/sifive_e.h
+++ b/include/hw/riscv/sifive_e.h
@@ -16,6 +16,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_SIFIVE_E_H
 #define HW_SIFIVE_E_H
=20
diff --git a/include/hw/riscv/sifive_plic.h b/include/hw/riscv/sifive_pli=
c.h
index ce8907f6aa..c292e578c6 100644
--- a/include/hw/riscv/sifive_plic.h
+++ b/include/hw/riscv/sifive_plic.h
@@ -18,6 +18,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_SIFIVE_PLIC_H
 #define HW_SIFIVE_PLIC_H
=20
diff --git a/include/hw/riscv/sifive_prci.h b/include/hw/riscv/sifive_prc=
i.h
index bd51c4af3c..1fc80724c2 100644
--- a/include/hw/riscv/sifive_prci.h
+++ b/include/hw/riscv/sifive_prci.h
@@ -16,6 +16,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_SIFIVE_PRCI_H
 #define HW_SIFIVE_PRCI_H
=20
diff --git a/include/hw/riscv/sifive_test.h b/include/hw/riscv/sifive_tes=
t.h
index 71d4c9fad7..ca775d8e68 100644
--- a/include/hw/riscv/sifive_test.h
+++ b/include/hw/riscv/sifive_test.h
@@ -16,6 +16,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_SIFIVE_TEST_H
 #define HW_SIFIVE_TEST_H
=20
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 892f0eee21..74d8fbbf57 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -16,6 +16,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_SIFIVE_U_H
 #define HW_SIFIVE_U_H
=20
diff --git a/include/hw/riscv/sifive_uart.h b/include/hw/riscv/sifive_uar=
t.h
index c8dc1c57fd..62f36ec2d1 100644
--- a/include/hw/riscv/sifive_uart.h
+++ b/include/hw/riscv/sifive_uart.h
@@ -17,6 +17,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_SIFIVE_UART_H
 #define HW_SIFIVE_UART_H
=20
diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
index 641b70da67..f259d2558b 100644
--- a/include/hw/riscv/spike.h
+++ b/include/hw/riscv/spike.h
@@ -16,6 +16,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_RISCV_SPIKE_H
 #define HW_RISCV_SPIKE_H
=20
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index d01a1a85c4..d6f34cd19f 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -16,6 +16,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_RISCV_VIRT_H
 #define HW_RISCV_VIRT_H
=20
diff --git a/include/hw/s390x/3270-ccw.h b/include/hw/s390x/3270-ccw.h
index 9d1d18e2bd..bc24e78ec6 100644
--- a/include/hw/s390x/3270-ccw.h
+++ b/include/hw/s390x/3270-ccw.h
@@ -10,6 +10,9 @@
  * directory.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_S390X_3270_CCW_H
 #define HW_S390X_3270_CCW_H
=20
diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device.h
index 765e9082a3..2f3488115e 100644
--- a/include/hw/s390x/ap-device.h
+++ b/include/hw/s390x/ap-device.h
@@ -7,6 +7,9 @@
  * your option) any later version. See the COPYING file in the top-level
  * directory.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_S390X_AP_DEVICE_H
 #define HW_S390X_AP_DEVICE_H
=20
diff --git a/include/hw/s390x/css-bridge.h b/include/hw/s390x/css-bridge.=
h
index 5a0203be5f..1f5efeb203 100644
--- a/include/hw/s390x/css-bridge.h
+++ b/include/hw/s390x/css-bridge.h
@@ -10,6 +10,8 @@
  * directory.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_S390X_CSS_BRIDGE_H
 #define HW_S390X_CSS_BRIDGE_H
 #include "qom/object.h"
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index d033387fba..3d55971ef5 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -9,6 +9,9 @@
  * directory.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef CSS_H
 #define CSS_H
=20
diff --git a/include/hw/s390x/s390-ccw.h b/include/hw/s390x/s390-ccw.h
index fffb54562f..91c1a8d21f 100644
--- a/include/hw/s390x/s390-ccw.h
+++ b/include/hw/s390x/s390-ccw.h
@@ -10,6 +10,9 @@
  * directory.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_S390_CCW_H
 #define HW_S390_CCW_H
=20
diff --git a/include/hw/s390x/storage-attributes.h b/include/hw/s390x/sto=
rage-attributes.h
index d6403a0a7e..5bc4715c6b 100644
--- a/include/hw/s390x/storage-attributes.h
+++ b/include/hw/s390x/storage-attributes.h
@@ -9,6 +9,9 @@
  * directory.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef S390_STORAGE_ATTRIBUTES_H
 #define S390_STORAGE_ATTRIBUTES_H
=20
diff --git a/include/hw/s390x/tod.h b/include/hw/s390x/tod.h
index 9c4a6000c3..0ad708998b 100644
--- a/include/hw/s390x/tod.h
+++ b/include/hw/s390x/tod.h
@@ -8,6 +8,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_S390_TOD_H
 #define HW_S390_TOD_H
=20
diff --git a/include/hw/s390x/vfio-ccw.h b/include/hw/s390x/vfio-ccw.h
index ee5250d0d7..c35e86f9e8 100644
--- a/include/hw/s390x/vfio-ccw.h
+++ b/include/hw/s390x/vfio-ccw.h
@@ -11,6 +11,9 @@
  * directory.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_VFIO_CCW_H
 #define HW_VFIO_CCW_H
=20
diff --git a/include/hw/semihosting/console.h b/include/hw/semihosting/co=
nsole.h
index cfab572c0c..03e6bdb985 100644
--- a/include/hw/semihosting/console.h
+++ b/include/hw/semihosting/console.h
@@ -6,6 +6,9 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef SEMIHOST_CONSOLE_H
 #define SEMIHOST_CONSOLE_H
=20
diff --git a/include/hw/sh4/sh.h b/include/hw/sh4/sh.h
index 767a2df7e2..1884271351 100644
--- a/include/hw/sh4/sh.h
+++ b/include/hw/sh4/sh.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_SH_H
 #define QEMU_SH_H
 /* Definitions for SH board emulation.  */
diff --git a/include/hw/sh4/sh_intc.h b/include/hw/sh4/sh_intc.h
index b7c2404334..ed56215736 100644
--- a/include/hw/sh4/sh_intc.h
+++ b/include/hw/sh4/sh_intc.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef SH_INTC_H
 #define SH_INTC_H
=20
diff --git a/include/hw/sparc/sparc64.h b/include/hw/sparc/sparc64.h
index 21ab79e343..81b9c8a675 100644
--- a/include/hw/sparc/sparc64.h
+++ b/include/hw/sparc/sparc64.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_SPARC_SPARC64_H
 #define HW_SPARC_SPARC64_H
=20
diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index 591279ba1f..06b50143c3 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ASPEED_SMC_H
 #define ASPEED_SMC_H
=20
diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.=
h
index a0a0ae7584..7929546ad7 100644
--- a/include/hw/ssi/xilinx_spips.h
+++ b/include/hw/ssi/xilinx_spips.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef XILINX_SPIPS_H
 #define XILINX_SPIPS_H
=20
diff --git a/include/hw/timer/allwinner-a10-pit.h b/include/hw/timer/allw=
inner-a10-pit.h
index c0cc3e2169..16cfc0d62d 100644
--- a/include/hw/timer/allwinner-a10-pit.h
+++ b/include/hw/timer/allwinner-a10-pit.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ALLWINNER_A10_PIT_H
 #define ALLWINNER_A10_PIT_H
=20
diff --git a/include/hw/timer/i8254_internal.h b/include/hw/timer/i8254_i=
nternal.h
index c37a438f82..8d0e0ed17f 100644
--- a/include/hw/timer/i8254_internal.h
+++ b/include/hw/timer/i8254_internal.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_I8254_INTERNAL_H
 #define QEMU_I8254_INTERNAL_H
=20
diff --git a/include/hw/timer/m48t59.h b/include/hw/timer/m48t59.h
index 43efc91f56..97c2471f2c 100644
--- a/include/hw/timer/m48t59.h
+++ b/include/hw/timer/m48t59.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_M48T59_H
 #define HW_M48T59_H
=20
diff --git a/include/hw/timer/mc146818rtc.h b/include/hw/timer/mc146818rt=
c.h
index fe6ed63f71..a781ff1fb3 100644
--- a/include/hw/timer/mc146818rtc.h
+++ b/include/hw/timer/mc146818rtc.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MC146818RTC_H
 #define MC146818RTC_H
=20
diff --git a/include/hw/timer/mc146818rtc_regs.h b/include/hw/timer/mc146=
818rtc_regs.h
index c62f17bf2d..0b38971417 100644
--- a/include/hw/timer/mc146818rtc_regs.h
+++ b/include/hw/timer/mc146818rtc_regs.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MC146818RTC_REGS_H
 #define MC146818RTC_REGS_H
=20
diff --git a/include/hw/timer/sun4v-rtc.h b/include/hw/timer/sun4v-rtc.h
index 407278f918..11ced390a3 100644
--- a/include/hw/timer/sun4v-rtc.h
+++ b/include/hw/timer/sun4v-rtc.h
@@ -1 +1,3 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 void sun4v_rtc_init(hwaddr addr);
diff --git a/include/hw/timer/xlnx-zynqmp-rtc.h b/include/hw/timer/xlnx-z=
ynqmp-rtc.h
index 6e9134edf6..23f37fe21a 100644
--- a/include/hw/timer/xlnx-zynqmp-rtc.h
+++ b/include/hw/timer/xlnx-zynqmp-rtc.h
@@ -24,6 +24,8 @@
  * THE SOFTWARE.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_TIMER_XLNX_ZYNQMP_RTC_H
 #define HW_TIMER_XLNX_ZYNQMP_RTC_H
=20
diff --git a/include/hw/vfio/vfio-amd-xgbe.h b/include/hw/vfio/vfio-amd-x=
gbe.h
index 9fff65e99d..936514fe64 100644
--- a/include/hw/vfio/vfio-amd-xgbe.h
+++ b/include/hw/vfio/vfio-amd-xgbe.h
@@ -11,6 +11,8 @@
  *
  */
=20
+/* FIXME Does not pass make check-headers without pixman, yet! */
+
 #ifndef HW_VFIO_VFIO_AMD_XGBE_H
 #define HW_VFIO_VFIO_AMD_XGBE_H
=20
diff --git a/include/hw/vfio/vfio-calxeda-xgmac.h b/include/hw/vfio/vfio-=
calxeda-xgmac.h
index f994775c09..498b399c48 100644
--- a/include/hw/vfio/vfio-calxeda-xgmac.h
+++ b/include/hw/vfio/vfio-calxeda-xgmac.h
@@ -11,6 +11,8 @@
  *
  */
=20
+/* FIXME Does not pass make check-headers without pixman, yet! */
+
 #ifndef HW_VFIO_VFIO_CALXEDA_XGMAC_H
 #define HW_VFIO_VFIO_CALXEDA_XGMAC_H
=20
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.=
h
index 9107bd41c0..4815e1c74b 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -18,6 +18,8 @@
  *  Copyright (C) 2008, IBM, Muli Ben-Yehuda (muli@il.ibm.com)
  */
=20
+/* FIXME Does not pass make check-headers without pixman, yet! */
+
 #ifndef HW_VFIO_VFIO_COMMON_H
 #define HW_VFIO_VFIO_COMMON_H
=20
diff --git a/include/hw/vfio/vfio-platform.h b/include/hw/vfio/vfio-platf=
orm.h
index 30d3c28d3b..064f4a421d 100644
--- a/include/hw/vfio/vfio-platform.h
+++ b/include/hw/vfio/vfio-platform.h
@@ -13,6 +13,8 @@
  *  Copyright Red Hat, Inc. 2012
  */
=20
+/* FIXME Does not pass make check-headers without pixman, yet! */
+
 #ifndef HW_VFIO_VFIO_PLATFORM_H
 #define HW_VFIO_VFIO_PLATFORM_H
=20
diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio=
-access.h
index bdf58f3119..9a155f4c69 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -13,6 +13,9 @@
  *
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_VIRTIO_ACCESS_H
 #define QEMU_VIRTIO_ACCESS_H
=20
diff --git a/include/hw/virtio/virtio-gpu-bswap.h b/include/hw/virtio/vir=
tio-gpu-bswap.h
index 38d12160f6..b3c749ebf2 100644
--- a/include/hw/virtio/virtio-gpu-bswap.h
+++ b/include/hw/virtio/virtio-gpu-bswap.h
@@ -11,6 +11,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_VIRTIO_GPU_BSWAP_H
 #define HW_VIRTIO_GPU_BSWAP_H
=20
diff --git a/include/hw/virtio/virtio-gpu-pci.h b/include/hw/virtio/virti=
o-gpu-pci.h
index 2f69b5a9cc..204e2b3a52 100644
--- a/include/hw/virtio/virtio-gpu-pci.h
+++ b/include/hw/virtio/virtio-gpu-pci.h
@@ -11,6 +11,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* FIXME Does not pass make check-headers without pixman, yet! */
+
 #ifndef HW_VIRTIO_GPU_PCI_H
 #define HW_VIRTIO_GPU_PCI_H
=20
diff --git a/include/hw/virtio/virtio-gpu-pixman.h b/include/hw/virtio/vi=
rtio-gpu-pixman.h
index 4dba782758..6e83be5f65 100644
--- a/include/hw/virtio/virtio-gpu-pixman.h
+++ b/include/hw/virtio/virtio-gpu-pixman.h
@@ -11,6 +11,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* FIXME Does not pass make check-headers without pixman, yet! */
+
 #ifndef HW_VIRTIO_GPU_PIXMAN_H
 #define HW_VIRTIO_GPU_PIXMAN_H
=20
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
index 6dd57f2025..27be0c6636 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -11,6 +11,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* FIXME Does not pass make check-headers without pixman, yet! */
+
 #ifndef HW_VIRTIO_GPU_H
 #define HW_VIRTIO_GPU_H
=20
diff --git a/include/hw/virtio/virtio-input.h b/include/hw/virtio/virtio-=
input.h
index 4fca03e796..0727d5449b 100644
--- a/include/hw/virtio/virtio-input.h
+++ b/include/hw/virtio/virtio-input.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_VIRTIO_INPUT_H
 #define QEMU_VIRTIO_INPUT_H
=20
diff --git a/include/hw/virtio/virtio-rng.h b/include/hw/virtio/virtio-rn=
g.h
index 922dce7cac..ee650297c2 100644
--- a/include/hw/virtio/virtio-rng.h
+++ b/include/hw/virtio/virtio-rng.h
@@ -9,6 +9,8 @@
  * top-level directory.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_VIRTIO_RNG_H
 #define QEMU_VIRTIO_RNG_H
=20
diff --git a/include/hw/watchdog/wdt_aspeed.h b/include/hw/watchdog/wdt_a=
speed.h
index daef0c0e23..39e5689165 100644
--- a/include/hw/watchdog/wdt_aspeed.h
+++ b/include/hw/watchdog/wdt_aspeed.h
@@ -7,6 +7,8 @@
  * COPYING file in the top-level directory.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef WDT_ASPEED_H
 #define WDT_ASPEED_H
=20
diff --git a/include/hw/xen/xen-backend.h b/include/hw/xen/xen-backend.h
index 010d712638..d4cb4475be 100644
--- a/include/hw/xen/xen-backend.h
+++ b/include/hw/xen/xen-backend.h
@@ -5,6 +5,9 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* FIXME Does not pass make check-headers without CONFIG_XEN, yet! */
+/* FIXME Does not pass make check-headers without system emulation, yet!=
 */
+
 #ifndef HW_XEN_BACKEND_H
 #define HW_XEN_BACKEND_H
=20
diff --git a/include/hw/xen/xen-block.h b/include/hw/xen/xen-block.h
index 11d351b4b3..9f8ddccd12 100644
--- a/include/hw/xen/xen-block.h
+++ b/include/hw/xen/xen-block.h
@@ -5,6 +5,9 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* FIXME Does not pass make check-headers without CONFIG_XEN, yet! */
+/* FIXME Does not pass make check-headers without system emulation, yet!=
 */
+
 #ifndef HW_XEN_BLOCK_H
 #define HW_XEN_BLOCK_H
=20
diff --git a/include/hw/xen/xen-bus-helper.h b/include/hw/xen/xen-bus-hel=
per.h
index 4c0f747445..00ec76b4a6 100644
--- a/include/hw/xen/xen-bus-helper.h
+++ b/include/hw/xen/xen-bus-helper.h
@@ -5,6 +5,9 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* FIXME Does not pass make check-headers without CONFIG_XEN, yet! */
+/* FIXME Does not pass make check-headers without system emulation, yet!=
 */
+
 #ifndef HW_XEN_BUS_HELPER_H
 #define HW_XEN_BUS_HELPER_H
=20
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index 1c2d9dfdb8..a74335809f 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -5,6 +5,9 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* FIXME Does not pass make check-headers without CONFIG_XEN, yet! */
+/* FIXME Does not pass make check-headers without system emulation, yet!=
 */
+
 #ifndef HW_XEN_BUS_H
 #define HW_XEN_BUS_H
=20
diff --git a/include/hw/xen/xen-legacy-backend.h b/include/hw/xen/xen-leg=
acy-backend.h
index 07d4176ac1..e3f068e68b 100644
--- a/include/hw/xen/xen-legacy-backend.h
+++ b/include/hw/xen/xen-legacy-backend.h
@@ -1,3 +1,6 @@
+/* FIXME Does not pass make check-headers without CONFIG_XEN, yet! */
+/* FIXME Does not pass make check-headers without system emulation, yet!=
 */
+
 #ifndef HW_XEN_LEGACY_BACKEND_H
 #define HW_XEN_LEGACY_BACKEND_H
=20
diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index 0504b43659..bed3e49acf 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -1,3 +1,6 @@
+/* FIXME Does not pass make check-headers without CONFIG_XEN, yet! */
+/* FIXME Does not pass make check-headers without system emulation, yet!=
 */
+
 #ifndef QEMU_HW_XEN_COMMON_H
 #define QEMU_HW_XEN_COMMON_H
=20
diff --git a/include/hw/xen/xen_pvdev.h b/include/hw/xen/xen_pvdev.h
index 83e5174d90..5089f14be8 100644
--- a/include/hw/xen/xen_pvdev.h
+++ b/include/hw/xen/xen_pvdev.h
@@ -1,3 +1,6 @@
+/* FIXME Does not pass make check-headers without CONFIG_XEN, yet! */
+/* FIXME Does not pass make check-headers without system emulation, yet!=
 */
+
 #ifndef QEMU_HW_XEN_PVDEV_H
 #define QEMU_HW_XEN_PVDEV_H
=20
diff --git a/include/libdecnumber/decNumberLocal.h b/include/libdecnumber=
/decNumberLocal.h
index 12cf1d8b6f..01ba6c7aea 100644
--- a/include/libdecnumber/decNumberLocal.h
+++ b/include/libdecnumber/decNumberLocal.h
@@ -37,6 +37,8 @@
 /* decNumber.h or one of decDouble (etc.) must be included first.     */
 /* ------------------------------------------------------------------ */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef DECNUMBERLOCAL_H
 #define DECNUMBERLOCAL_H
=20
diff --git a/include/migration/cpu.h b/include/migration/cpu.h
index a40bd3549f..4c8dde2e95 100644
--- a/include/migration/cpu.h
+++ b/include/migration/cpu.h
@@ -1,4 +1,8 @@
 /* Declarations for use for CPU state serialization.  */
+
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MIGRATION_CPU_H
 #define MIGRATION_CPU_H
=20
diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index 454e8ed155..c022fd3b39 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -22,6 +22,9 @@
  * THE SOFTWARE.
  */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MONITOR_HMP_TARGET_H
 #define MONITOR_HMP_TARGET_H
=20
diff --git a/include/qemu/atomic128.h b/include/qemu/atomic128.h
index ddd0d55d31..8dcf19482d 100644
--- a/include/qemu/atomic128.h
+++ b/include/qemu/atomic128.h
@@ -10,6 +10,8 @@
  * atomic primitive is meant to provide.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_ATOMIC128_H
 #define QEMU_ATOMIC128_H
=20
diff --git a/include/qemu/cpuid.h b/include/qemu/cpuid.h
index 69301700bd..69c3917445 100644
--- a/include/qemu/cpuid.h
+++ b/include/qemu/cpuid.h
@@ -4,6 +4,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* FIXME Does not pass make check-headers without CONFIG_CPUID_H, yet! *=
/
+
 #ifndef QEMU_CPUID_H
 #define QEMU_CPUID_H
=20
diff --git a/include/qemu/futex.h b/include/qemu/futex.h
index 91ae88966e..0fa19d30df 100644
--- a/include/qemu/futex.h
+++ b/include/qemu/futex.h
@@ -11,6 +11,8 @@
  *
  */
=20
+/* FIXME Does not pass make check-headers without CONFIG_LINUX, yet! */
+
 #ifndef QEMU_FUTEX_H
 #define QEMU_FUTEX_H
=20
diff --git a/include/qemu/ratelimit.h b/include/qemu/ratelimit.h
index 1b38291823..efd6074823 100644
--- a/include/qemu/ratelimit.h
+++ b/include/qemu/ratelimit.h
@@ -11,6 +11,8 @@
  *
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_RATELIMIT_H
 #define QEMU_RATELIMIT_H
=20
diff --git a/include/qemu/thread-win32.h b/include/qemu/thread-win32.h
index 50af5dd7ab..e09a7ba397 100644
--- a/include/qemu/thread-win32.h
+++ b/include/qemu/thread-win32.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_THREAD_WIN32_H
 #define QEMU_THREAD_WIN32_H
=20
diff --git a/include/qemu/xattr.h b/include/qemu/xattr.h
index a83fe8e749..8dae5620e4 100644
--- a/include/qemu/xattr.h
+++ b/include/qemu/xattr.h
@@ -10,6 +10,9 @@
  * later version.  See the COPYING file in the top-level directory.
  *
  */
+
+/* FIXME Does not pass make check-headers without CONFIG_LINUX, yet! */
+
 #ifndef QEMU_XATTR_H
 #define QEMU_XATTR_H
=20
diff --git a/include/sysemu/balloon.h b/include/sysemu/balloon.h
index c8f6145257..ec77a48925 100644
--- a/include/sysemu/balloon.h
+++ b/include/sysemu/balloon.h
@@ -11,6 +11,8 @@
  *
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_BALLOON_H
 #define QEMU_BALLOON_H
=20
diff --git a/include/sysemu/cryptodev-vhost-user.h b/include/sysemu/crypt=
odev-vhost-user.h
index 6debf53fc5..d2bbd854c4 100644
--- a/include/sysemu/cryptodev-vhost-user.h
+++ b/include/sysemu/cryptodev-vhost-user.h
@@ -20,6 +20,9 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  *
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef CRYPTODEV_VHOST_USER_H
 #define CRYPTODEV_VHOST_USER_H
=20
diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
index 250143cb5a..c5efa8b2f2 100644
--- a/include/sysemu/dump.h
+++ b/include/sysemu/dump.h
@@ -11,6 +11,8 @@
  *
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef DUMP_H
 #define DUMP_H
=20
diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index d275b5a843..2df17c4ed3 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -10,6 +10,9 @@
=20
 /* header to be included in non-HVF-specific code */
=20
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HVF_H
 #define HVF_H
=20
diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index 5f6240d5cb..8d8af53df8 100644
--- a/include/sysemu/iothread.h
+++ b/include/sysemu/iothread.h
@@ -11,6 +11,8 @@
  *
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef IOTHREAD_H
 #define IOTHREAD_H
=20
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index f838412491..18f48589c1 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -6,6 +6,8 @@
  *
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_KVM_INT_H
 #define QEMU_KVM_INT_H
=20
diff --git a/include/sysemu/memory_mapping.h b/include/sysemu/memory_mapp=
ing.h
index 58452457ce..6fb5b42cf1 100644
--- a/include/sysemu/memory_mapping.h
+++ b/include/sysemu/memory_mapping.h
@@ -11,6 +11,8 @@
  *
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MEMORY_MAPPING_H
 #define MEMORY_MAPPING_H
=20
diff --git a/include/sysemu/os-posix.h b/include/sysemu/os-posix.h
index 629c8c648b..5a7dabe22c 100644
--- a/include/sysemu/os-posix.h
+++ b/include/sysemu/os-posix.h
@@ -23,6 +23,8 @@
  * THE SOFTWARE.
  */
=20
+/* FIXME Does not pass make check-headers without CONFIG_POSIX, yet! */
+
 #ifndef QEMU_OS_POSIX_H
 #define QEMU_OS_POSIX_H
=20
diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
index ff18b23db1..b828117bb6 100644
--- a/include/sysemu/os-win32.h
+++ b/include/sysemu/os-win32.h
@@ -23,6 +23,8 @@
  * THE SOFTWARE.
  */
=20
+/* FIXME Does not pass make check-headers without CONFIG_WIN32, yet! */
+
 #ifndef QEMU_OS_WIN32_H
 #define QEMU_OS_WIN32_H
=20
diff --git a/include/sysemu/xen-mapcache.h b/include/sysemu/xen-mapcache.=
h
index a03e2f1878..e3acb95b42 100644
--- a/include/sysemu/xen-mapcache.h
+++ b/include/sysemu/xen-mapcache.h
@@ -6,6 +6,8 @@
  *
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef XEN_MAPCACHE_H
 #define XEN_MAPCACHE_H
=20
diff --git a/include/trace-tcg.h b/include/trace-tcg.h
index da68608c85..6084376731 100644
--- a/include/trace-tcg.h
+++ b/include/trace-tcg.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TRACE_TCG_H
 #define TRACE_TCG_H
=20
diff --git a/include/ui/console.h b/include/ui/console.h
index f981696848..4edb647178 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers without pixman, yet! */
+
 #ifndef CONSOLE_H
 #define CONSOLE_H
=20
diff --git a/include/ui/egl-context.h b/include/ui/egl-context.h
index f004ce11a7..fa777a9d7b 100644
--- a/include/ui/egl-context.h
+++ b/include/ui/egl-context.h
@@ -1,3 +1,6 @@
+/* FIXME Does not pass make check-headers without pixman, yet! */
+/* FIXME Does not pass make check-headers without CONFIG_OPENGL, yet! */
+
 #ifndef EGL_CONTEXT_H
 #define EGL_CONTEXT_H
=20
diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index d714127799..5ea65ddfa1 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef EGL_HELPERS_H
 #define EGL_HELPERS_H
=20
diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index d9eedad976..1bad122097 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef UI_GTK_H
 #define UI_GTK_H
=20
diff --git a/include/ui/input.h b/include/ui/input.h
index 8c8ccb999f..718f152f98 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef INPUT_H
 #define INPUT_H
=20
diff --git a/include/ui/pixel_ops.h b/include/ui/pixel_ops.h
index d390adfd1b..18d5e181a6 100644
--- a/include/ui/pixel_ops.h
+++ b/include/ui/pixel_ops.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 static inline unsigned int rgb_to_pixel8(unsigned int r, unsigned int g,
                                          unsigned int b)
 {
diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
index 0668109305..4f559c1941 100644
--- a/include/ui/qemu-pixman.h
+++ b/include/ui/qemu-pixman.h
@@ -3,6 +3,8 @@
  * See the COPYING file in the top-level directory.
  */
=20
+/* FIXME Does not pass make check-headers without pixman, yet! */
+
 #ifndef QEMU_PIXMAN_H
 #define QEMU_PIXMAN_H
=20
diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index 0875b8d56b..c57525755f 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef SDL2_H
 #define SDL2_H
=20
diff --git a/include/ui/shader.h b/include/ui/shader.h
index 4c5acb2ce8..c062cac55f 100644
--- a/include/ui/shader.h
+++ b/include/ui/shader.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers without CONFIG_OPENGL, yet! */
+
 #ifndef QEMU_SHADER_H
 #define QEMU_SHADER_H
=20
diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
index eed60e4fae..4bb30522a6 100644
--- a/include/ui/spice-display.h
+++ b/include/ui/spice-display.h
@@ -15,6 +15,8 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef UI_SPICE_DISPLAY_H
 #define UI_SPICE_DISPLAY_H
=20
diff --git a/tests/Makefile.include b/tests/Makefile.include
index a983dd32da..9eafc99df2 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -15,6 +15,7 @@ check-help:
 	@echo " $(MAKE) check-tcg            Run TCG tests"
 	@echo " $(MAKE) check-softfloat      Run FPU emulation tests"
 	@echo " $(MAKE) check-acceptance     Run all acceptance (functional) te=
sts"
+	@echo " $(MAKE) check-source         Run source code tests"
 	@echo
 	@echo " $(MAKE) check-report.html    Generates an HTML test report"
 	@echo " $(MAKE) check-venv           Creates a Python venv for tests"
@@ -493,6 +494,7 @@ generated-files-y +=3D tests/test-qapi-introspect.h
=20
 QEMU_CFLAGS +=3D -I$(SRC_PATH)/tests
=20
+include $(SRC_PATH)/tests/check-headers.mak
=20
 # Deps that are common to various different sets of tests below
 test-util-obj-y =3D libqemuutil.a
@@ -1159,13 +1161,39 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
             --failfast=3Don $(SRC_PATH)/tests/acceptance, \
             "AVOCADO", "tests/acceptance")
=20
+# Header sanity checking
+
+RECURSIVE_TARGETS +=3D check-headers check-bad-headers
+
+.PHONY: check-headers check-bad-headers
+ifeq ($(wildcard $(SRC_PATH)/.git),)
+check-headers check-bad-headers:
+	@echo "  SKIP  $@ (requires a git tree)"
+else
+check-headers: CFLAGS +=3D -g0	# save disk space
+check-headers: $(check-header-tests:.c=3D.o)
+check-headers: $(addsuffix /check-headers, $(TARGET_DIRS))
+
+# Expected to fail:
+check-bad-headers: $(check-bad-header-tests:.c=3D.o)
+check-bad-headers: $(addsuffix /check-bad-headers, $(TARGET_DIRS))
+
+.SECONDARY: $(check-header-tests) $(check-bad-header-tests)
+$(check-header-tests) $(check-bad-header-tests): tests/header-test-templ=
ate.c
+	@mkdir -p $(dir $@)
+	@sed 's,@header@,$(subst tests/headers/,,$(@:.c=3D.h)),' <$< >$@
+endif
+
 # Consolidated targets
=20
-.PHONY: check-block check-qapi-schema check-qtest check-unit check check=
-clean
+.PHONY: check-block check-qapi-schema check-qtest check-unit check-sourc=
e
+.PHONY: check check-clean
 check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y)) check-t=
ests/qapi-schema/doc-good.texi
 check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
 check-block: $(patsubst %,check-%, $(check-block-y))
-check: check-qapi-schema check-unit check-softfloat check-qtest check-de=
codetree
+check-source: check-headers
+check: check-qapi-schema check-unit check-softfloat check-qtest check-de=
codetree check-source
+
 check-clean:
 	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
 	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(t=
arget)-y)) $(check-qtest-generic-y))
@@ -1180,5 +1208,6 @@ all: $(QEMU_IOTESTS_HELPERS-y)
=20
 -include $(wildcard tests/*.d)
 -include $(wildcard tests/libqos/*.d)
+-include $(check-header-tests:.c=3D.d) $(check-bad-header-tests:.c=3D.d)
=20
 endif
diff --git a/tests/check-headers.mak b/tests/check-headers.mak
new file mode 100644
index 0000000000..367b9dfb9a
--- /dev/null
+++ b/tests/check-headers.mak
@@ -0,0 +1,92 @@
+# -*- Mode: makefile -*-
+
+ifneq ($(wildcard $(SRC_PATH)/.git),)
+
+# All headers:
+src-headers :=3D $(filter %.h, $(shell cd $(SRC_PATH) && git ls-files))
+
+# Headers we don't want to test
+# Third party headers we don't want to mess with
+excluded-headers :=3D $(filter disas/libvixl/vixl/% include/hw/xen/inter=
face/% include/standard-headers/% linux-headers/% pc-bios/% slirp/%, $(sr=
c-headers))
+# Funny stuff we don't want to mess with
+excluded-headers +=3D $(filter tests/multiboot/% tests/tcg/% tests/uefi-=
test-tools/%, $(src-headers))
+excluded-headers +=3D scripts/cocci-macro-file.h
+# Exclude all but include/ for now:
+excluded-headers +=3D $(filter-out include/%, $(src-headers))
+
+# Headers for target-dependent code only (require -DNEED_CPU_H etc.)
+target-header-regexp :=3D NOTE: May only be included into target-depende=
nt code
+target-headers :=3D $(shell cd $(SRC_PATH) && egrep -l '$(target-header-=
regexp)' $(src-headers))
+
+# Headers for target-independent code only
+untarget-headers :=3D include/exec/poison.h
+
+# Headers carrying a FIXME about this test
+# Extended regular expression matching the FIXME comment in headers
+# not expected to pass the test in this build's configuration:
+bad-header-regexp :=3D FIXME Does not pass make check-headers(
+# Require <cpuid.h>:
+ifneq ($(CONFIG_CPUID_H),y)
+bad-header-regexp +=3D without CONFIG_CPUID_H|
+endif
+# Require Linux:
+ifneq ($(CONFIG_LINUX),y)
+bad-header-regexp +=3D without CONFIG_LINUX|
+endif
+# Require OpenGL:
+ifneq ($(CONFIG_OPENGL),y)
+bad-header-regexp +=3D without CONFIG_OPENGL|
+endif
+# Require Pixman:
+# since there's no easy, precise way to detect "have pixman",
+# approximate with CONFIG_SOFTMMU
+ifneq ($(CONFIG_SOFTMMU),y)
+bad-header-regexp +=3D without pixman|
+endif
+# Require POSIX:
+ifneq ($(CONFIG_POSIX),y)
+bad-header-regexp +=3D without CONFIG_POSIX|
+endif
+# Require SPICE:
+ifneq ($(CONFIG_SPICE),y)
+bad-header-regexp +=3D without CONFIG_SPICE|
+endif
+# Require any system emulator being built
+# can't use CONFIG_SOFTMMU, it's off in TARGET_DIR=3D%-user; check
+# TARGET_DIRS instead
+ifeq ($(filter %-softmmu, $(TARGET_DIRS)),)
+bad-header-regexp +=3D without system emulation|
+endif
+# Require Windows:
+ifneq ($(CONFIG_WIN32),y)
+bad-header-regexp +=3D without CONFIG_WIN32|
+endif
+# Require Xen:
+ifneq ($(CONFIG_XEN),y)
+bad-header-regexp +=3D without CONFIG_XEN|
+endif
+bad-header-regexp +=3D D06F00D to avoid empty RE)?, yet!
+# The headers not expected to pass the test in this build's configuratio=
n:
+bad-headers :=3D $(shell cd $(SRC_PATH) && egrep -l '$(bad-header-regexp=
)' $(src-headers))
+
+# Checked headers (all less excluded and bad):
+# to be checked target-independently: all less excluded, bad, and target
+checked-headers :=3D $(filter-out $(excluded-headers) $(bad-headers) $(t=
arget-headers), $(src-headers))
+check-header-tests :=3D $(patsubst %.h, tests/headers/%.c, $(checked-hea=
ders))
+# to be checked for each target: all less excluded, bad, and untarget
+checked-target-headers :=3D $(filter-out $(excluded-headers) $(bad-heade=
rs) $(untarget-headers), $(src-headers))
+# Testing target-independent headers for each target is massive
+# overkill, limit to target-dependent headers for now.  This leaves
+# gaps in testing.  TODO accept the overkill or pick something in betwee=
n
+checked-target-headers :=3D $(filter $(target-headers), $(checked-target=
-headers))
+check-target-header-tests :=3D $(patsubst %.h, tests/headers-tgt/%.c, $(=
checked-target-headers))
+
+# Bad headers (all less excluded and checked):
+# to be checked target-independently: bad less excluded and target
+unchecked-headers :=3D $(filter-out $(excluded-headers) $(target-headers=
), $(bad-headers))
+check-bad-header-tests :=3D $(patsubst %.h, tests/headers/%.c, $(uncheck=
ed-headers))
+# to be checked for each target: bad less excluded and untarget
+unchecked-target-headers :=3D $(filter-out $(excluded-headers) $(untarge=
t-headers), $(bad-headers))
+check-bad-target-header-tests :=3D $(patsubst %.h, tests/headers-tgt/%.c=
, $(unchecked-target-headers))
+
+endif
diff --git a/tests/header-test-template.c b/tests/header-test-template.c
new file mode 100644
index 0000000000..469804e80c
--- /dev/null
+++ b/tests/header-test-template.c
@@ -0,0 +1,23 @@
+/*
+ * Template for make check-headers
+ *
+ * Copyright (C) 2016 Red Hat, Inc.
+ *
+ * Authors:
+ *  Markus Armbruster <armbru@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+/*
+ * Some headers define static functions that real includers all use,
+ * but this one of course doesn't.  Suppress the resulting warning:
+ */
+#pragma GCC diagnostic ignored "-Wunused-function"
+
+#include "@header@"
+/* Include a second time to catch missing header guard */
+#include "@header@"
--=20
2.21.0


