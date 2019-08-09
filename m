Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83503C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 07:08:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17914208C4
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 07:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17914208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvz0h-0005CG-CV
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 03:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48707)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hvyge-00016O-2V
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hvygS-00024a-1f
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37218)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hvygR-00023h-74
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 72C8EC074111;
 Fri,  9 Aug 2019 06:47:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EFE1100194E;
 Fri,  9 Aug 2019 06:47:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A75191136427; Fri,  9 Aug 2019 08:46:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 08:46:31 +0200
Message-Id: <20190809064645.22656-16-armbru@redhat.com>
In-Reply-To: <20190809064645.22656-1-armbru@redhat.com>
References: <20190809064645.22656-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 09 Aug 2019 06:47:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 15/29] Include migration/vmstate.h less
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
Cc: Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In my "build everything" tree, changing migration/vmstate.h triggers a
recompile of some 2700 out of 6600 objects (not counting tests and
objects that don't depend on qemu/osdep.h).

hw/hw.h supposedly includes it for convenience.  Several other headers
include it just to get VMStateDescription.  The previous commit made
that unnecessary.

Include migration/vmstate.h only where it's still needed.  Touching it
now recompiles only some 1600 objects.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 audio/audio.c                      | 1 +
 cpus.c                             | 1 +
 hw/acpi/cpu.c                      | 1 +
 hw/acpi/ich9.c                     | 1 +
 hw/acpi/memory_hotplug.c           | 1 +
 hw/acpi/pcihp.c                    | 1 +
 hw/acpi/piix4.c                    | 1 +
 hw/acpi/tco.c                      | 2 ++
 hw/acpi/vmgenid.c                  | 1 +
 hw/adc/stm32f2xx_adc.c             | 1 +
 hw/arm/armsse.c                    | 1 +
 hw/arm/highbank.c                  | 1 +
 hw/arm/integratorcp.c              | 1 +
 hw/arm/musicpal.c                  | 1 +
 hw/arm/pxa2xx.c                    | 1 +
 hw/arm/pxa2xx_gpio.c               | 1 +
 hw/arm/pxa2xx_pic.c                | 1 +
 hw/arm/smmuv3.c                    | 1 +
 hw/arm/spitz.c                     | 1 +
 hw/arm/stellaris.c                 | 1 +
 hw/arm/strongarm.c                 | 1 +
 hw/arm/versatilepb.c               | 1 +
 hw/arm/virt-acpi-build.c           | 1 +
 hw/arm/z2.c                        | 1 +
 hw/audio/ac97.c                    | 1 +
 hw/audio/cs4231.c                  | 1 +
 hw/audio/cs4231a.c                 | 1 +
 hw/audio/es1370.c                  | 1 +
 hw/audio/gus.c                     | 1 +
 hw/audio/hda-codec.c               | 1 +
 hw/audio/intel-hda.c               | 1 +
 hw/audio/lm4549.c                  | 1 +
 hw/audio/marvell_88w8618.c         | 1 +
 hw/audio/milkymist-ac97.c          | 1 +
 hw/audio/pcspk.c                   | 1 +
 hw/audio/pl041.c                   | 1 +
 hw/audio/sb16.c                    | 1 +
 hw/audio/wm8750.c                  | 1 +
 hw/block/ecc.c                     | 1 +
 hw/block/fdc.c                     | 1 +
 hw/block/m25p80.c                  | 1 +
 hw/block/nand.c                    | 1 +
 hw/block/nvme.c                    | 1 +
 hw/block/onenand.c                 | 1 +
 hw/block/pflash_cfi01.c            | 1 +
 hw/block/pflash_cfi02.c            | 1 +
 hw/char/bcm2835_aux.c              | 1 +
 hw/char/cadence_uart.c             | 1 +
 hw/char/cmsdk-apb-uart.c           | 1 +
 hw/char/digic-uart.c               | 1 +
 hw/char/escc.c                     | 1 +
 hw/char/exynos4210_uart.c          | 1 +
 hw/char/imx_serial.c               | 1 +
 hw/char/ipoctal232.c               | 1 +
 hw/char/lm32_juart.c               | 1 +
 hw/char/lm32_uart.c                | 1 +
 hw/char/milkymist-uart.c           | 1 +
 hw/char/nrf51_uart.c               | 1 +
 hw/char/parallel.c                 | 1 +
 hw/char/pl011.c                    | 1 +
 hw/char/sclpconsole-lm.c           | 1 +
 hw/char/sclpconsole.c              | 1 +
 hw/char/serial-isa.c               | 1 +
 hw/char/serial-pci-multi.c         | 1 +
 hw/char/serial-pci.c               | 1 +
 hw/char/serial.c                   | 1 +
 hw/char/spapr_vty.c                | 1 +
 hw/core/loader.c                   | 1 +
 hw/core/numa.c                     | 1 +
 hw/core/or-irq.c                   | 1 +
 hw/core/ptimer.c                   | 2 ++
 hw/core/qdev.c                     | 1 +
 hw/display/ads7846.c               | 1 +
 hw/display/bcm2835_fb.c            | 1 +
 hw/display/bochs-display.c         | 1 +
 hw/display/cg3.c                   | 1 +
 hw/display/cirrus_vga.c            | 1 +
 hw/display/dpcd.c                  | 1 +
 hw/display/exynos4210_fimd.c       | 1 +
 hw/display/g364fb.c                | 1 +
 hw/display/i2c-ddc.c               | 1 +
 hw/display/jazz_led.c              | 1 +
 hw/display/milkymist-tmu2.c        | 1 +
 hw/display/milkymist-vgafb.c       | 1 +
 hw/display/pl110.c                 | 1 +
 hw/display/pxa2xx_lcd.c            | 1 +
 hw/display/qxl.c                   | 1 +
 hw/display/sii9022.c               | 1 +
 hw/display/sm501.c                 | 1 +
 hw/display/ssd0303.c               | 1 +
 hw/display/ssd0323.c               | 1 +
 hw/display/tcx.c                   | 1 +
 hw/display/vga-isa-mm.c            | 2 ++
 hw/display/vga-pci.c               | 1 +
 hw/display/vga.c                   | 1 +
 hw/display/vmware_vga.c            | 1 +
 hw/display/xlnx_dp.c               | 1 +
 hw/dma/bcm2835_dma.c               | 1 +
 hw/dma/i82374.c                    | 1 +
 hw/dma/i8257.c                     | 1 +
 hw/dma/pl080.c                     | 1 +
 hw/dma/pl330.c                     | 1 +
 hw/dma/pxa2xx_dma.c                | 1 +
 hw/dma/rc4030.c                    | 1 +
 hw/dma/sparc32_dma.c               | 1 +
 hw/dma/xlnx-zdma.c                 | 1 +
 hw/dma/xlnx-zynq-devcfg.c          | 1 +
 hw/dma/xlnx_dpdma.c                | 1 +
 hw/gpio/bcm2835_gpio.c             | 1 +
 hw/gpio/gpio_key.c                 | 1 +
 hw/gpio/imx_gpio.c                 | 1 +
 hw/gpio/max7310.c                  | 1 +
 hw/gpio/mpc8xxx.c                  | 1 +
 hw/gpio/nrf51_gpio.c               | 1 +
 hw/gpio/pl061.c                    | 1 +
 hw/gpio/zaurus.c                   | 1 +
 hw/hppa/dino.c                     | 1 +
 hw/i2c/aspeed_i2c.c                | 1 +
 hw/i2c/core.c                      | 1 +
 hw/i2c/exynos4210_i2c.c            | 1 +
 hw/i2c/imx_i2c.c                   | 1 +
 hw/i2c/microbit_i2c.c              | 1 +
 hw/i2c/mpc_i2c.c                   | 1 +
 hw/i2c/pm_smbus.c                  | 2 ++
 hw/i2c/smbus_eeprom.c              | 1 +
 hw/i2c/smbus_ich9.c                | 1 +
 hw/i2c/smbus_slave.c               | 1 +
 hw/i386/acpi-build.c               | 1 +
 hw/i386/amd_iommu.c                | 2 ++
 hw/i386/intel_iommu.c              | 1 +
 hw/i386/kvm/clock.c                | 1 +
 hw/i386/kvmvapic.c                 | 1 +
 hw/i386/pc.c                       | 1 +
 hw/i386/vmmouse.c                  | 2 ++
 hw/i386/xen/xen_platform.c         | 1 +
 hw/i386/xen/xen_pvdevice.c         | 1 +
 hw/ide/ahci-allwinner.c            | 1 +
 hw/ide/ahci.c                      | 1 +
 hw/ide/cmd646.c                    | 1 +
 hw/ide/core.c                      | 1 +
 hw/ide/ich.c                       | 1 +
 hw/ide/isa.c                       | 1 +
 hw/ide/macio.c                     | 1 +
 hw/ide/microdrive.c                | 1 +
 hw/ide/mmio.c                      | 1 +
 hw/ide/pci.c                       | 1 +
 hw/ide/piix.c                      | 1 +
 hw/ide/via.c                       | 1 +
 hw/input/adb-kbd.c                 | 1 +
 hw/input/adb-mouse.c               | 1 +
 hw/input/adb.c                     | 1 +
 hw/input/hid.c                     | 2 ++
 hw/input/lm832x.c                  | 1 +
 hw/input/milkymist-softusb.c       | 1 +
 hw/input/pckbd.c                   | 1 +
 hw/input/pl050.c                   | 1 +
 hw/input/ps2.c                     | 1 +
 hw/input/pxa2xx_keypad.c           | 1 +
 hw/input/stellaris_input.c         | 1 +
 hw/input/tsc2005.c                 | 1 +
 hw/input/tsc210x.c                 | 1 +
 hw/intc/allwinner-a10-pic.c        | 1 +
 hw/intc/apic_common.c              | 1 +
 hw/intc/arm_gic_common.c           | 1 +
 hw/intc/arm_gicv3_common.c         | 1 +
 hw/intc/arm_gicv3_its_common.c     | 1 +
 hw/intc/armv7m_nvic.c              | 1 +
 hw/intc/aspeed_vic.c               | 1 +
 hw/intc/bcm2835_ic.c               | 1 +
 hw/intc/bcm2836_control.c          | 1 +
 hw/intc/exynos4210_combiner.c      | 1 +
 hw/intc/exynos4210_gic.c           | 1 +
 hw/intc/heathrow_pic.c             | 1 +
 hw/intc/i8259_common.c             | 2 ++
 hw/intc/imx_avic.c                 | 1 +
 hw/intc/imx_gpcv2.c                | 1 +
 hw/intc/ioapic_common.c            | 1 +
 hw/intc/lm32_pic.c                 | 1 +
 hw/intc/ompic.c                    | 1 +
 hw/intc/openpic.c                  | 1 +
 hw/intc/pl190.c                    | 1 +
 hw/intc/slavio_intctl.c            | 1 +
 hw/intc/spapr_xive.c               | 1 +
 hw/intc/xics.c                     | 1 +
 hw/intc/xive.c                     | 1 +
 hw/intc/xlnx-pmu-iomod-intc.c      | 1 +
 hw/intc/xlnx-zynqmp-ipi.c          | 1 +
 hw/ipack/ipack.c                   | 1 +
 hw/ipack/tpci200.c                 | 1 +
 hw/ipmi/ipmi_bmc_extern.c          | 1 +
 hw/ipmi/ipmi_bmc_sim.c             | 1 +
 hw/ipmi/isa_ipmi_bt.c              | 1 +
 hw/ipmi/isa_ipmi_kcs.c             | 1 +
 hw/isa/apm.c                       | 1 +
 hw/isa/i82378.c                    | 1 +
 hw/isa/lpc_ich9.c                  | 1 +
 hw/isa/pc87312.c                   | 1 +
 hw/isa/piix4.c                     | 1 +
 hw/isa/vt82c686.c                  | 1 +
 hw/mem/pc-dimm.c                   | 1 +
 hw/mips/gt64xxx_pci.c              | 1 +
 hw/misc/a9scu.c                    | 1 +
 hw/misc/arm_l2x0.c                 | 1 +
 hw/misc/arm_sysctl.c               | 1 +
 hw/misc/armsse-mhu.c               | 1 +
 hw/misc/aspeed_scu.c               | 1 +
 hw/misc/aspeed_sdmc.c              | 1 +
 hw/misc/aspeed_xdma.c              | 1 +
 hw/misc/bcm2835_mbox.c             | 1 +
 hw/misc/bcm2835_property.c         | 1 +
 hw/misc/bcm2835_rng.c              | 1 +
 hw/misc/eccmemctl.c                | 1 +
 hw/misc/exynos4210_clk.c           | 1 +
 hw/misc/exynos4210_pmu.c           | 1 +
 hw/misc/exynos4210_rng.c           | 1 +
 hw/misc/imx25_ccm.c                | 1 +
 hw/misc/imx31_ccm.c                | 1 +
 hw/misc/imx6_ccm.c                 | 1 +
 hw/misc/imx6_src.c                 | 1 +
 hw/misc/imx6ul_ccm.c               | 1 +
 hw/misc/imx7_ccm.c                 | 1 +
 hw/misc/iotkit-secctl.c            | 1 +
 hw/misc/iotkit-sysctl.c            | 1 +
 hw/misc/ivshmem.c                  | 1 +
 hw/misc/macio/cuda.c               | 1 +
 hw/misc/macio/gpio.c               | 1 +
 hw/misc/macio/mac_dbdma.c          | 1 +
 hw/misc/macio/macio.c              | 1 +
 hw/misc/macio/pmu.c                | 1 +
 hw/misc/max111x.c                  | 1 +
 hw/misc/milkymist-hpdmc.c          | 1 +
 hw/misc/milkymist-pfpu.c           | 1 +
 hw/misc/mips_cmgcr.c               | 1 +
 hw/misc/mips_cpc.c                 | 1 +
 hw/misc/mos6522.c                  | 1 +
 hw/misc/mps2-fpgaio.c              | 1 +
 hw/misc/mps2-scc.c                 | 1 +
 hw/misc/msf2-sysreg.c              | 1 +
 hw/misc/mst_fpga.c                 | 1 +
 hw/misc/nrf51_rng.c                | 1 +
 hw/misc/pca9552.c                  | 1 +
 hw/misc/slavio_misc.c              | 1 +
 hw/misc/tmp105.c                   | 1 +
 hw/misc/tmp421.c                   | 1 +
 hw/misc/tz-mpc.c                   | 1 +
 hw/misc/tz-msc.c                   | 1 +
 hw/misc/tz-ppc.c                   | 1 +
 hw/misc/vmcoreinfo.c               | 1 +
 hw/misc/zynq-xadc.c                | 1 +
 hw/misc/zynq_slcr.c                | 1 +
 hw/net/allwinner_emac.c            | 1 +
 hw/net/cadence_gem.c               | 1 +
 hw/net/can/can_kvaser_pci.c        | 1 +
 hw/net/can/can_mioe3680_pci.c      | 1 +
 hw/net/can/can_pcm3680_pci.c       | 1 +
 hw/net/can/can_sja1000.c           | 1 +
 hw/net/dp8393x.c                   | 1 +
 hw/net/e1000.c                     | 1 +
 hw/net/e1000e.c                    | 1 +
 hw/net/eepro100.c                  | 1 +
 hw/net/ftgmac100.c                 | 1 +
 hw/net/imx_fec.c                   | 1 +
 hw/net/lan9118.c                   | 1 +
 hw/net/lance.c                     | 1 +
 hw/net/milkymist-minimac2.c        | 1 +
 hw/net/mipsnet.c                   | 1 +
 hw/net/ne2000-isa.c                | 1 +
 hw/net/ne2000-pci.c                | 1 +
 hw/net/ne2000.c                    | 1 +
 hw/net/pcnet-pci.c                 | 1 +
 hw/net/pcnet.c                     | 1 +
 hw/net/rocker/rocker.c             | 1 +
 hw/net/rtl8139.c                   | 1 +
 hw/net/smc91c111.c                 | 1 +
 hw/net/spapr_llan.c                | 1 +
 hw/net/stellaris_enet.c            | 1 +
 hw/net/sungem.c                    | 1 +
 hw/net/sunhme.c                    | 1 +
 hw/net/vmxnet3.c                   | 1 +
 hw/net/xgmac.c                     | 1 +
 hw/nvram/ds1225y.c                 | 1 +
 hw/nvram/eeprom93xx.c              | 1 +
 hw/nvram/fw_cfg.c                  | 1 +
 hw/nvram/mac_nvram.c               | 1 +
 hw/nvram/nrf51_nvm.c               | 1 +
 hw/nvram/spapr_nvram.c             | 1 +
 hw/openrisc/cputimer.c             | 1 +
 hw/pci-bridge/gen_pcie_root_port.c | 1 +
 hw/pci-bridge/i82801b11.c          | 1 +
 hw/pci-bridge/ioh3420.c            | 1 +
 hw/pci-bridge/xio3130_downstream.c | 1 +
 hw/pci-bridge/xio3130_upstream.c   | 1 +
 hw/pci-host/bonito.c               | 1 +
 hw/pci-host/designware.c           | 1 +
 hw/pci-host/gpex.c                 | 1 +
 hw/pci-host/piix.c                 | 1 +
 hw/pci-host/ppce500.c              | 1 +
 hw/pci-host/prep.c                 | 1 +
 hw/pci-host/q35.c                  | 1 +
 hw/pci-host/versatile.c            | 1 +
 hw/pci/msix.c                      | 1 +
 hw/pci/pci.c                       | 1 +
 hw/pci/pcie_aer.c                  | 1 +
 hw/ppc/ppc.c                       | 1 +
 hw/ppc/ppc4xx_pci.c                | 1 +
 hw/ppc/prep_systemio.c             | 1 +
 hw/ppc/rs6000_mc.c                 | 1 +
 hw/ppc/spapr_caps.c                | 1 +
 hw/ppc/spapr_cpu_core.c            | 1 +
 hw/ppc/spapr_drc.c                 | 1 +
 hw/ppc/spapr_iommu.c               | 1 +
 hw/ppc/spapr_ovec.c                | 1 +
 hw/ppc/spapr_pci.c                 | 1 +
 hw/ppc/spapr_rtc.c                 | 1 +
 hw/ppc/spapr_vio.c                 | 1 +
 hw/riscv/sifive_gpio.c             | 1 +
 hw/s390x/event-facility.c          | 1 +
 hw/s390x/sclpquiesce.c             | 1 +
 hw/scsi/esp-pci.c                  | 1 +
 hw/scsi/esp.c                      | 1 +
 hw/scsi/lsi53c895a.c               | 1 +
 hw/scsi/megasas.c                  | 1 +
 hw/scsi/mptsas.c                   | 1 +
 hw/scsi/scsi-bus.c                 | 1 +
 hw/scsi/scsi-disk.c                | 1 +
 hw/scsi/spapr_vscsi.c              | 1 +
 hw/scsi/vmw_pvscsi.c               | 1 +
 hw/sd/bcm2835_sdhost.c             | 1 +
 hw/sd/milkymist-memcard.c          | 1 +
 hw/sd/pl181.c                      | 1 +
 hw/sd/pxa2xx_mmci.c                | 1 +
 hw/sd/sd.c                         | 1 +
 hw/sd/sdhci.c                      | 1 +
 hw/sd/ssi-sd.c                     | 1 +
 hw/sparc/sun4m.c                   | 1 +
 hw/sparc/sun4m_iommu.c             | 1 +
 hw/sparc64/sun4u.c                 | 2 ++
 hw/ssi/aspeed_smc.c                | 1 +
 hw/ssi/imx_spi.c                   | 1 +
 hw/ssi/mss-spi.c                   | 1 +
 hw/ssi/pl022.c                     | 1 +
 hw/ssi/ssi.c                       | 1 +
 hw/ssi/stm32f2xx_spi.c             | 1 +
 hw/ssi/xilinx_spi.c                | 1 +
 hw/ssi/xilinx_spips.c              | 1 +
 hw/timer/a9gtimer.c                | 1 +
 hw/timer/allwinner-a10-pit.c       | 1 +
 hw/timer/arm_mptimer.c             | 1 +
 hw/timer/arm_timer.c               | 1 +
 hw/timer/armv7m_systick.c          | 1 +
 hw/timer/aspeed_rtc.c              | 1 +
 hw/timer/aspeed_timer.c            | 1 +
 hw/timer/cadence_ttc.c             | 1 +
 hw/timer/cmsdk-apb-dualtimer.c     | 1 +
 hw/timer/cmsdk-apb-timer.c         | 1 +
 hw/timer/digic-timer.c             | 1 +
 hw/timer/ds1338.c                  | 1 +
 hw/timer/exynos4210_mct.c          | 1 +
 hw/timer/exynos4210_pwm.c          | 1 +
 hw/timer/exynos4210_rtc.c          | 1 +
 hw/timer/hpet.c                    | 1 +
 hw/timer/i8254_common.c            | 1 +
 hw/timer/imx_epit.c                | 1 +
 hw/timer/imx_gpt.c                 | 1 +
 hw/timer/lm32_timer.c              | 1 +
 hw/timer/m48t59.c                  | 1 +
 hw/timer/mc146818rtc.c             | 1 +
 hw/timer/milkymist-sysctl.c        | 1 +
 hw/timer/mss-timer.c               | 1 +
 hw/timer/nrf51_timer.c             | 1 +
 hw/timer/pl031.c                   | 1 +
 hw/timer/pxa2xx_timer.c            | 1 +
 hw/timer/slavio_timer.c            | 1 +
 hw/timer/stm32f2xx_timer.c         | 1 +
 hw/timer/twl92230.c                | 1 +
 hw/timer/xlnx-zynqmp-rtc.c         | 1 +
 hw/tpm/tpm_emulator.c              | 1 +
 hw/tpm/tpm_tis.c                   | 1 +
 hw/usb/bus.c                       | 1 +
 hw/usb/ccid-card-passthru.c        | 1 +
 hw/usb/dev-audio.c                 | 1 +
 hw/usb/dev-bluetooth.c             | 1 +
 hw/usb/dev-hid.c                   | 1 +
 hw/usb/dev-hub.c                   | 1 +
 hw/usb/dev-mtp.c                   | 1 +
 hw/usb/dev-network.c               | 1 +
 hw/usb/dev-serial.c                | 1 +
 hw/usb/dev-smartcard-reader.c      | 1 +
 hw/usb/dev-storage.c               | 1 +
 hw/usb/dev-uas.c                   | 1 +
 hw/usb/dev-wacom.c                 | 1 +
 hw/usb/hcd-ehci-pci.c              | 1 +
 hw/usb/hcd-ehci-sysbus.c           | 1 +
 hw/usb/hcd-ehci.c                  | 1 +
 hw/usb/hcd-ohci-pci.c              | 1 +
 hw/usb/hcd-ohci.c                  | 1 +
 hw/usb/hcd-uhci.c                  | 1 +
 hw/usb/hcd-xhci.c                  | 1 +
 hw/usb/host-libusb.c               | 1 +
 hw/usb/redirect.c                  | 1 +
 hw/vfio/amd-xgbe.c                 | 1 +
 hw/vfio/ap.c                       | 1 +
 hw/vfio/calxeda-xgmac.c            | 1 +
 hw/vfio/pci.c                      | 1 +
 hw/vfio/platform.c                 | 1 +
 hw/watchdog/cmsdk-apb-watchdog.c   | 1 +
 hw/watchdog/wdt_aspeed.c           | 1 +
 hw/watchdog/wdt_diag288.c          | 1 +
 hw/watchdog/wdt_i6300esb.c         | 1 +
 hw/watchdog/wdt_ib700.c            | 1 +
 hw/xtensa/xtfpga.c                 | 1 +
 include/hw/acpi/tco.h              | 1 -
 include/hw/block/flash.h           | 1 -
 include/hw/hw.h                    | 1 -
 include/hw/input/hid.h             | 1 -
 include/hw/pci/shpc.h              | 1 +
 include/hw/ppc/spapr_ovec.h        | 1 -
 include/hw/ptimer.h                | 1 -
 include/hw/virtio/virtio.h         | 1 +
 include/migration/cpu.h            | 1 +
 include/net/net.h                  | 1 -
 include/qemu/fifo8.h               | 1 -
 migration/savevm.c                 | 1 +
 target/s390x/machine.c             | 1 +
 util/fifo8.c                       | 1 +
 425 files changed, 426 insertions(+), 8 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 05adf7ffeb..cf65ae49f4 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "audio.h"
+#include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "qemu/timer.h"
 #include "qapi/error.h"
diff --git a/cpus.c b/cpus.c
index 927a00aa90..4ebdacdd44 100644
--- a/cpus.c
+++ b/cpus.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/config-file.h"
+#include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 7a90c8f82d..87f30a31d7 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "hw/boards.h"
+#include "migration/vmstate.h"
 #include "hw/acpi/cpu.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-misc.h"
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index b4d987c811..88eb7dbab1 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -30,6 +30,7 @@
 #include "qapi/visitor.h"
 #include "hw/i386/pc.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 297812d5f7..9483d66e86 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -4,6 +4,7 @@
 #include "hw/mem/pc-dimm.h"
 #include "hw/boards.h"
 #include "hw/qdev-core.h"
+#include "migration/vmstate.h"
 #include "trace.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-misc.h"
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 613406d09b..912ff6dd5c 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -35,6 +35,7 @@
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
 #include "hw/pci/pci_bus.h"
+#include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qom/qom-qobject.h"
 #include "trace.h"
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 8f9a7ba2ab..1896dbbfb9 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -42,6 +42,7 @@
 #include "hw/acpi/acpi_dev_interface.h"
 #include "hw/xen/xen.h"
 #include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
 #include "qom/cpu.h"
 #include "trace.h"
=20
diff --git a/hw/acpi/tco.c b/hw/acpi/tco.c
index acfb65e8f2..fb9052dbca 100644
--- a/hw/acpi/tco.c
+++ b/hw/acpi/tco.c
@@ -6,9 +6,11 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
  */
+
 #include "qemu/osdep.h"
 #include "sysemu/watchdog.h"
 #include "hw/i386/ich9.h"
+#include "migration/vmstate.h"
=20
 #include "hw/acpi/tco.h"
 #include "trace.h"
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index ed92ccc4b8..1e38e21cb7 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -18,6 +18,7 @@
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/vmgenid.h"
 #include "hw/nvram/fw_cfg.h"
+#include "migration/vmstate.h"
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
=20
diff --git a/hw/adc/stm32f2xx_adc.c b/hw/adc/stm32f2xx_adc.c
index c93b60e22e..9684653e5e 100644
--- a/hw/adc/stm32f2xx_adc.c
+++ b/hw/adc/stm32f2xx_adc.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/hw.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 85cfa414eb..e5263aa33d 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -16,6 +16,7 @@
 #include "qapi/error.h"
 #include "trace.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/registerfields.h"
 #include "hw/arm/armsse.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index def0f1ce6a..ca4c71f8a2 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -21,6 +21,7 @@
 #include "qemu-common.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/arm/boot.h"
 #include "hw/loader.h"
 #include "net/net.h"
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index d6025684f4..f8fbe402db 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -11,6 +11,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/boards.h"
 #include "hw/arm/boot.h"
 #include "hw/misc/arm_integrator_debug.h"
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 848e49f459..72e522a629 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -13,6 +13,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/arm/boot.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index ab3fbd7b64..4e99c30e11 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/arm/pxa.h"
 #include "sysemu/sysemu.h"
 #include "hw/char/serial.h"
diff --git a/hw/arm/pxa2xx_gpio.c b/hw/arm/pxa2xx_gpio.c
index 1b1fc499dc..aa2c89dcf9 100644
--- a/hw/arm/pxa2xx_gpio.c
+++ b/hw/arm/pxa2xx_gpio.c
@@ -12,6 +12,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/arm/pxa.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/arm/pxa2xx_pic.c b/hw/arm/pxa2xx_pic.c
index 2f4b461562..c8bd497e99 100644
--- a/hw/arm/pxa2xx_pic.c
+++ b/hw/arm/pxa2xx_pic.c
@@ -14,6 +14,7 @@
 #include "hw/hw.h"
 #include "hw/arm/pxa.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
=20
 #define ICIP	0x00	/* Interrupt Controller IRQ Pending register */
 #define ICMR	0x04	/* Interrupt Controller Mask register */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ccca60720e..0634a398d2 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -21,6 +21,7 @@
 #include "hw/irq.h"
 #include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/qdev-core.h"
 #include "hw/pci/pci.h"
 #include "exec/address-spaces.h"
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index b90431ffea..003929b3e0 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -28,6 +28,7 @@
 #include "audio/audio.h"
 #include "hw/boards.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "exec/address-spaces.h"
 #include "cpu.h"
=20
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 088ae2dbd7..9feb403f1e 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -24,6 +24,7 @@
 #include "hw/input/gamepad.h"
 #include "hw/irq.h"
 #include "hw/watchdog/cmsdk-apb-watchdog.h"
+#include "migration/vmstate.h"
 #include "hw/misc/unimp.h"
 #include "cpu.h"
=20
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 2e016f4b77..ca377df9e3 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -33,6 +33,7 @@
 #include "hw/boards.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "strongarm.h"
 #include "qemu/error-report.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index bc922345a6..e25561705f 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -11,6 +11,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/arm/boot.h"
 #include "hw/net/smc91c111.h"
 #include "net/net.h"
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index ad54d65ea0..4f85eb575c 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -46,6 +46,7 @@
 #include "sysemu/numa.h"
 #include "sysemu/reset.h"
 #include "kvm_arm.h"
+#include "migration/vmstate.h"
=20
 #define ARM_SPI_BASE 32
 #define ACPI_POWER_BUTTON_DEVICE "PWRB"
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index 366d46ff5f..810922d74e 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -18,6 +18,7 @@
 #include "hw/i2c/i2c.h"
 #include "hw/irq.h"
 #include "hw/ssi/ssi.h"
+#include "migration/vmstate.h"
 #include "hw/boards.h"
 #include "sysemu/sysemu.h"
 #include "hw/block/flash.h"
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index fb98da2678..26ac84b388 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -22,6 +22,7 @@
 #include "hw/audio/soundhw.h"
 #include "audio/audio.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "sysemu/dma.h"
=20
diff --git a/hw/audio/cs4231.c b/hw/audio/cs4231.c
index 8372299ebb..b5d3e895ce 100644
--- a/hw/audio/cs4231.c
+++ b/hw/audio/cs4231.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "trace.h"
=20
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 9eeab137c7..f7a39c0af4 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -29,6 +29,7 @@
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "qapi/error.h"
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 260c142b70..0289f771c1 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -31,6 +31,7 @@
 #include "hw/audio/soundhw.h"
 #include "audio/audio.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "sysemu/dma.h"
=20
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index 61230147ce..1a78cc47cd 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -30,6 +30,7 @@
 #include "audio/audio.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
+#include "migration/vmstate.h"
 #include "gusemu.h"
 #include "gustate.h"
=20
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 84639b5424..4f6fbb8b13 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -21,6 +21,7 @@
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "intel-hda.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "intel-hda-defs.h"
 #include "audio/audio.h"
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index b78baac295..e6f150bb0d 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -27,6 +27,7 @@
 #include "qemu/module.h"
 #include "hw/audio/soundhw.h"
 #include "intel-hda.h"
+#include "migration/vmstate.h"
 #include "intel-hda-defs.h"
 #include "sysemu/dma.h"
 #include "qapi/error.h"
diff --git a/hw/audio/lm4549.c b/hw/audio/lm4549.c
index af8b22b541..32b1481b56 100644
--- a/hw/audio/lm4549.c
+++ b/hw/audio/lm4549.c
@@ -17,6 +17,7 @@
 #include "hw/hw.h"
 #include "audio/audio.h"
 #include "lm4549.h"
+#include "migration/vmstate.h"
=20
 #if 0
 #define LM4549_DEBUG  1
diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
index 167b478ec6..6345bc1d5c 100644
--- a/hw/audio/marvell_88w8618.c
+++ b/hw/audio/marvell_88w8618.c
@@ -12,6 +12,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/audio/wm8750.h"
diff --git a/hw/audio/milkymist-ac97.c b/hw/audio/milkymist-ac97.c
index 3ba382ee4d..890a5fe89e 100644
--- a/hw/audio/milkymist-ac97.c
+++ b/hw/audio/milkymist-ac97.c
@@ -25,6 +25,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "trace.h"
 #include "audio/audio.h"
 #include "qemu/error-report.h"
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index a7b3ab0c2b..9039c9786d 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -30,6 +30,7 @@
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/timer/i8254.h"
+#include "migration/vmstate.h"
 #include "hw/audio/pcspk.h"
 #include "qapi/error.h"
=20
diff --git a/hw/audio/pl041.c b/hw/audio/pl041.c
index 47f0dfff18..3c371397de 100644
--- a/hw/audio/pl041.c
+++ b/hw/audio/pl041.c
@@ -28,6 +28,7 @@
=20
 #include "pl041.h"
 #include "lm4549.h"
+#include "migration/vmstate.h"
=20
 #if 0
 #define PL041_DEBUG_LEVEL 1
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index ba5a5dd022..599194779d 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -29,6 +29,7 @@
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev.h"
+#include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "qemu/host-utils.h"
 #include "qemu/log.h"
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index 81f83eea88..9f6df5d59c 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -9,6 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "hw/audio/wm8750.h"
 #include "audio/audio.h"
diff --git a/hw/block/ecc.c b/hw/block/ecc.c
index 48311d2609..f846ab3e01 100644
--- a/hw/block/ecc.c
+++ b/hw/block/ecc.c
@@ -13,6 +13,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "migration/vmstate.h"
 #include "hw/block/flash.h"
=20
 /*
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 91d5f56cec..88feb0f451 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -36,6 +36,7 @@
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/block/block.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index dd87affcf5..9d395169b2 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -26,6 +26,7 @@
 #include "hw/hw.h"
 #include "sysemu/block-backend.h"
 #include "hw/ssi/ssi.h"
+#include "migration/vmstate.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/block/nand.c b/hw/block/nand.c
index 0a2736b50e..4a0d4677c3 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -23,6 +23,7 @@
 #include "hw/block/flash.h"
 #include "sysemu/block-backend.h"
 #include "hw/qdev.h"
+#include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 36d6a8bb3a..079a8ffe80 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -31,6 +31,7 @@
 #include "hw/hw.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index b3644f7e89..18123f0499 100644
--- a/hw/block/onenand.c
+++ b/hw/block/onenand.c
@@ -26,6 +26,7 @@
 #include "sysemu/block-backend.h"
 #include "exec/memory.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index a1ec1faae5..2d6f260491 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -50,6 +50,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 42886f6af5..b7070cd8ec 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -43,6 +43,7 @@
 #include "qemu/host-utils.h"
 #include "qemu/module.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "trace.h"
=20
 #define PFLASH_DEBUG false
diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 8395c79520..45fc34d92d 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -23,6 +23,7 @@
 #include "qemu/osdep.h"
 #include "hw/char/bcm2835_aux.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index 6b9eb140c7..0e315b2376 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -23,6 +23,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "chardev/char-fe.h"
 #include "chardev/char-serial.h"
 #include "qemu/timer.h"
diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
index dd96a3302e..9e1aa43bd3 100644
--- a/hw/char/cmsdk-apb-uart.c
+++ b/hw/char/cmsdk-apb-uart.c
@@ -21,6 +21,7 @@
 #include "qapi/error.h"
 #include "trace.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/registerfields.h"
 #include "chardev/char-fe.h"
 #include "chardev/char-serial.h"
diff --git a/hw/char/digic-uart.c b/hw/char/digic-uart.c
index e4ac8435c8..79ea92249c 100644
--- a/hw/char/digic-uart.c
+++ b/hw/char/digic-uart.c
@@ -29,6 +29,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "chardev/char-fe.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 678d494d39..404002b899 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -26,6 +26,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "hw/char/escc.h"
 #include "ui/console.h"
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index dabcd07415..9bd826b33d 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -21,6 +21,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index f79e47d4ee..bf3f07d760 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "hw/char/imx_serial.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index 7674e2d7b6..1171dc20cf 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "hw/ipack/ipack.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
 #include "qemu/bitops.h"
 #include "qemu/module.h"
 #include "chardev/char-fe.h"
diff --git a/hw/char/lm32_juart.c b/hw/char/lm32_juart.c
index 41a3ec81e3..f4488fa736 100644
--- a/hw/char/lm32_juart.c
+++ b/hw/char/lm32_juart.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "trace.h"
 #include "chardev/char-fe.h"
diff --git a/hw/char/lm32_uart.c b/hw/char/lm32_uart.c
index 377032567a..4b3215fe96 100644
--- a/hw/char/lm32_uart.c
+++ b/hw/char/lm32_uart.c
@@ -26,6 +26,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "trace.h"
 #include "chardev/char-fe.h"
 #include "qemu/error-report.h"
diff --git a/hw/char/milkymist-uart.c b/hw/char/milkymist-uart.c
index d4641b5f44..53c1ca789d 100644
--- a/hw/char/milkymist-uart.c
+++ b/hw/char/milkymist-uart.c
@@ -25,6 +25,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "trace.h"
 #include "chardev/char-fe.h"
 #include "qemu/error-report.h"
diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c
index bbe766d3c6..bb886f12aa 100644
--- a/hw/char/nrf51_uart.c
+++ b/hw/char/nrf51_uart.c
@@ -17,6 +17,7 @@
 #include "qemu/module.h"
 #include "hw/char/nrf51_uart.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
 #include "trace.h"
=20
 static void nrf51_uart_update_irq(NRF51UARTState *s)
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index ea8ab35e59..1798fd0c44 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -31,6 +31,7 @@
 #include "chardev/char-fe.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
+#include "migration/vmstate.h"
 #include "hw/char/parallel.h"
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index a2da375528..84ad8ff9fb 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -22,6 +22,7 @@
 #include "hw/char/pl011.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "chardev/char-fe.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index 691dc870ed..d904265cda 100644
--- a/hw/char/sclpconsole-lm.c
+++ b/hw/char/sclpconsole-lm.c
@@ -21,6 +21,7 @@
 #include "chardev/char-fe.h"
=20
 #include "hw/s390x/sclp.h"
+#include "migration/vmstate.h"
 #include "hw/s390x/event-facility.h"
 #include "hw/s390x/ebcdic.h"
=20
diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
index 09b1d45d7a..f3669766bf 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -19,6 +19,7 @@
 #include "qemu/module.h"
=20
 #include "hw/s390x/sclp.h"
+#include "migration/vmstate.h"
 #include "hw/s390x/event-facility.h"
 #include "chardev/char-fe.h"
=20
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index 610426111a..d3080b76e4 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -28,6 +28,7 @@
 #include "qemu/module.h"
 #include "hw/char/serial.h"
 #include "hw/isa/isa.h"
+#include "migration/vmstate.h"
=20
 #define ISA_SERIAL(obj) OBJECT_CHECK(ISASerialState, (obj), TYPE_ISA_SER=
IAL)
=20
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 65dbfbd205..867e7840b4 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -32,6 +32,7 @@
 #include "hw/char/serial.h"
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
=20
 #define PCI_SERIAL_MAX_PORTS 4
=20
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index 808d32b508..ee537890c2 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -31,6 +31,7 @@
 #include "hw/char/serial.h"
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
=20
 typedef struct PCISerialState {
     PCIDevice dev;
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 1d977287ea..4d54163a62 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/char/serial.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
 #include "chardev/char-serial.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index f360ab3612..b3995a9e0c 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -4,6 +4,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/qdev.h"
+#include "migration/vmstate.h"
 #include "chardev/char-fe.h"
 #include "hw/irq.h"
 #include "hw/ppc/spapr.h"
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 830845dd73..84e4f3efac 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -47,6 +47,7 @@
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "disas/disas.h"
+#include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/core/numa.c b/hw/core/numa.c
index a11431483c..67548064ee 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -33,6 +33,7 @@
 #include "qapi/qapi-visit-machine.h"
 #include "sysemu/qtest.h"
 #include "hw/mem/pc-dimm.h"
+#include "migration/vmstate.h"
 #include "hw/mem/memory-device.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
diff --git a/hw/core/or-irq.c b/hw/core/or-irq.c
index 6ed34d9238..02949dae1a 100644
--- a/hw/core/or-irq.c
+++ b/hw/core/or-irq.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/or-irq.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
=20
 static void or_irq_handler(void *opaque, int n, int level)
diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
index 170fd34d8b..49b60282cf 100644
--- a/hw/core/ptimer.c
+++ b/hw/core/ptimer.c
@@ -5,10 +5,12 @@
  *
  * This code is licensed under the GNU LGPL.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
+#include "migration/vmstate.h"
 #include "qemu/host-utils.h"
 #include "sysemu/replay.h"
 #include "sysemu/qtest.h"
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 5c4b67a408..b1fe40d20d 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -38,6 +38,7 @@
 #include "hw/irq.h"
 #include "hw/boards.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
=20
 bool qdev_hotplug =3D false;
 static bool qdev_hot_added =3D false;
diff --git a/hw/display/ads7846.c b/hw/display/ads7846.c
index 12d8272615..c12272ae72 100644
--- a/hw/display/ads7846.c
+++ b/hw/display/ads7846.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/ssi/ssi.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "ui/console.h"
=20
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index e446355f29..3d99d99e2b 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -30,6 +30,7 @@
 #include "framebuffer.h"
 #include "ui/pixel_ops.h"
 #include "hw/misc/bcm2835_mbox_defs.h"
+#include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index 582133dd71..ce40aea354 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -10,6 +10,7 @@
 #include "qemu/units.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
 #include "hw/display/bochs-vbe.h"
 #include "hw/display/edid.h"
=20
diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 7cf9ebd604..29a8735a38 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -29,6 +29,7 @@
 #include "qemu/error-report.h"
 #include "ui/console.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/irq.h"
 #include "hw/loader.h"
 #include "qemu/log.h"
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 4ccf5b4f18..3120b3cfaf 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -40,6 +40,7 @@
 #include "trace.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
 #include "ui/pixel_ops.h"
 #include "cirrus_vga_internal.h"
=20
diff --git a/hw/display/dpcd.c b/hw/display/dpcd.c
index 88cde54821..170545c605 100644
--- a/hw/display/dpcd.c
+++ b/hw/display/dpcd.c
@@ -30,6 +30,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/misc/auxbus.h"
+#include "migration/vmstate.h"
 #include "hw/display/dpcd.h"
=20
 #ifndef DEBUG_DPCD
diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 889622eefa..8e1508a3e6 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
 #include "qemu/bswap.h"
diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index 89248f87df..1757b777e2 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -27,6 +27,7 @@
 #include "ui/pixel_ops.h"
 #include "trace.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
=20
 typedef struct G364State {
     /* hardware */
diff --git a/hw/display/i2c-ddc.c b/hw/display/i2c-ddc.c
index 041fc4f408..3ac85216a5 100644
--- a/hw/display/i2c-ddc.c
+++ b/hw/display/i2c-ddc.c
@@ -20,6 +20,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/i2c/i2c.h"
+#include "migration/vmstate.h"
 #include "hw/display/i2c-ddc.h"
=20
 #ifndef DEBUG_I2CDDC
diff --git a/hw/display/jazz_led.c b/hw/display/jazz_led.c
index 783189ebcd..3e0112b1ca 100644
--- a/hw/display/jazz_led.c
+++ b/hw/display/jazz_led.c
@@ -28,6 +28,7 @@
 #include "ui/pixel_ops.h"
 #include "trace.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
=20
 typedef enum {
     REDRAW_NONE =3D 0, REDRAW_SEGMENTS =3D 1, REDRAW_BACKGROUND =3D 2,
diff --git a/hw/display/milkymist-tmu2.c b/hw/display/milkymist-tmu2.c
index 3f92378410..7bfffa52da 100644
--- a/hw/display/milkymist-tmu2.c
+++ b/hw/display/milkymist-tmu2.c
@@ -28,6 +28,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "trace.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/display/milkymist-vgafb.c b/hw/display/milkymist-vgafb.c
index dce1dd7ad6..9a9a481ebd 100644
--- a/hw/display/milkymist-vgafb.c
+++ b/hw/display/milkymist-vgafb.c
@@ -33,6 +33,7 @@
 #include "qemu/module.h"
=20
 #define BITS 8
+#include "migration/vmstate.h"
 #include "milkymist-vgafb_template.h"
 #define BITS 15
 #include "milkymist-vgafb_template.h"
diff --git a/hw/display/pl110.c b/hw/display/pl110.c
index 8fb510ee73..c2991a28d2 100644
--- a/hw/display/pl110.c
+++ b/hw/display/pl110.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "ui/console.h"
 #include "framebuffer.h"
 #include "ui/pixel_ops.h"
diff --git a/hw/display/pxa2xx_lcd.c b/hw/display/pxa2xx_lcd.c
index 7aca3912f5..05f5f84671 100644
--- a/hw/display/pxa2xx_lcd.c
+++ b/hw/display/pxa2xx_lcd.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
 #include "ui/console.h"
 #include "hw/arm/pxa.h"
 #include "ui/pixel_ops.h"
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 98c7410032..4a44712fde 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -29,6 +29,7 @@
 #include "qemu/module.h"
 #include "sysemu/sysemu.h"
 #include "migration/blocker.h"
+#include "migration/vmstate.h"
 #include "trace.h"
=20
 #include "qxl.h"
diff --git a/hw/display/sii9022.c b/hw/display/sii9022.c
index 0bebb85a58..0710ce9de5 100644
--- a/hw/display/sii9022.c
+++ b/hw/display/sii9022.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "hw/i2c/i2c.h"
+#include "migration/vmstate.h"
 #include "hw/display/i2c-ddc.h"
 #include "trace.h"
=20
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 5918f59b2b..6f88aaaa08 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -33,6 +33,7 @@
 #include "hw/char/serial.h"
 #include "ui/console.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/pci/pci.h"
 #include "hw/i2c/i2c.h"
 #include "hw/display/i2c-ddc.h"
diff --git a/hw/display/ssd0303.c b/hw/display/ssd0303.c
index f2a60c44c9..718378f6de 100644
--- a/hw/display/ssd0303.c
+++ b/hw/display/ssd0303.c
@@ -13,6 +13,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "ui/console.h"
=20
diff --git a/hw/display/ssd0323.c b/hw/display/ssd0323.c
index ac373f1e78..c3bdb18742 100644
--- a/hw/display/ssd0323.c
+++ b/hw/display/ssd0323.c
@@ -13,6 +13,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/ssi/ssi.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "ui/console.h"
=20
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index cdabcbc746..f9b1ae56ec 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -29,6 +29,7 @@
 #include "ui/pixel_ops.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
=20
diff --git a/hw/display/vga-isa-mm.c b/hw/display/vga-isa-mm.c
index a790f69b6d..1c4f43b52b 100644
--- a/hw/display/vga-isa-mm.c
+++ b/hw/display/vga-isa-mm.c
@@ -21,10 +21,12 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
 #include "qemu/units.h"
 #include "hw/hw.h"
+#include "migration/vmstate.h"
 #include "hw/display/vga.h"
 #include "vga_int.h"
 #include "ui/pixel_ops.h"
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index dedac5d128..cb956b4545 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -27,6 +27,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
 #include "vga_int.h"
 #include "ui/pixel_ops.h"
 #include "qemu/module.h"
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 4d3572891a..f8098f63e9 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -34,6 +34,7 @@
 #include "ui/pixel_ops.h"
 #include "qemu/timer.h"
 #include "hw/xen/xen.h"
+#include "migration/vmstate.h"
 #include "trace.h"
=20
 //#define DEBUG_VGA_MEM
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 249a179bf6..ebfcc46a2d 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -31,6 +31,7 @@
 #include "trace.h"
 #include "ui/vnc.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
=20
 #undef VERBOSE
 #define HW_RECT_ACCEL
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 4daac38070..fde3b21ea5 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -28,6 +28,7 @@
 #include "qemu/module.h"
 #include "hw/display/xlnx_dp.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
=20
 #ifndef DEBUG_DP
 #define DEBUG_DP 0
diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
index 090c73d951..192bd377a0 100644
--- a/hw/dma/bcm2835_dma.c
+++ b/hw/dma/bcm2835_dma.c
@@ -7,6 +7,7 @@
 #include "qapi/error.h"
 #include "hw/dma/bcm2835_dma.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
index 68fad2dd12..3f0db4a021 100644
--- a/hw/dma/i82374.c
+++ b/hw/dma/i82374.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/isa/isa.h"
+#include "migration/vmstate.h"
 #include "hw/dma/i8257.h"
=20
 #define TYPE_I82374 "i82374"
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 30a3442437..b7404cff60 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/isa/isa.h"
+#include "migration/vmstate.h"
 #include "hw/dma/i8257.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index be7f9c71a8..59bc929363 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -9,6 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "exec/address-spaces.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index 0d772de9f3..28830a42a3 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -18,6 +18,7 @@
 #include "qemu-common.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "sysemu/dma.h"
diff --git a/hw/dma/pxa2xx_dma.c b/hw/dma/pxa2xx_dma.c
index 1c273fb309..1124051730 100644
--- a/hw/dma/pxa2xx_dma.c
+++ b/hw/dma/pxa2xx_dma.c
@@ -13,6 +13,7 @@
 #include "hw/irq.h"
 #include "hw/arm/pxa.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
=20
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index f7650f617c..d35fb59eee 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -28,6 +28,7 @@
 #include "hw/irq.h"
 #include "hw/mips/mips.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index a05b6be95c..8955fe262e 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -31,6 +31,7 @@
 #include "hw/sparc/sparc32_dma.h"
 #include "hw/sparc/sun4m_iommu.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "sysemu/dma.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 5afd77a5b8..2dbdfc5739 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -29,6 +29,7 @@
 #include "qemu/osdep.h"
 #include "hw/dma/xlnx-zdma.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index 855c784758..89200ff15d 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -27,6 +27,7 @@
 #include "qemu/osdep.h"
 #include "hw/dma/xlnx-zynq-devcfg.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
 #include "qemu/bitops.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/dma.h"
diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
index 1bba7f2159..b40c897de2 100644
--- a/hw/dma/xlnx_dpdma.c
+++ b/hw/dma/xlnx_dpdma.c
@@ -28,6 +28,7 @@
 #include "qemu/module.h"
 #include "hw/dma/xlnx_dpdma.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
=20
 #ifndef DEBUG_DPDMA
 #define DEBUG_DPDMA 0
diff --git a/hw/gpio/bcm2835_gpio.c b/hw/gpio/bcm2835_gpio.c
index ea3f3f2bda..91ce3d10cc 100644
--- a/hw/gpio/bcm2835_gpio.c
+++ b/hw/gpio/bcm2835_gpio.c
@@ -17,6 +17,7 @@
 #include "qemu/timer.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/sd/sd.h"
 #include "hw/gpio/bcm2835_gpio.h"
 #include "hw/irq.h"
diff --git a/hw/gpio/gpio_key.c b/hw/gpio/gpio_key.c
index 66866fa87c..46bbd42772 100644
--- a/hw/gpio/gpio_key.c
+++ b/hw/gpio/gpio_key.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
=20
diff --git a/hw/gpio/imx_gpio.c b/hw/gpio/imx_gpio.c
index 3d3c9644db..8792fb5ad4 100644
--- a/hw/gpio/imx_gpio.c
+++ b/hw/gpio/imx_gpio.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "hw/gpio/imx_gpio.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/gpio/max7310.c b/hw/gpio/max7310.c
index b0925ab1a1..432f0b00fe 100644
--- a/hw/gpio/max7310.c
+++ b/hw/gpio/max7310.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
=20
 #define TYPE_MAX7310 "max7310"
diff --git a/hw/gpio/mpc8xxx.c b/hw/gpio/mpc8xxx.c
index f3b90b4b33..1d99667094 100644
--- a/hw/gpio/mpc8xxx.c
+++ b/hw/gpio/mpc8xxx.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
=20
 #define TYPE_MPC8XXX_GPIO "mpc8xxx_gpio"
diff --git a/hw/gpio/nrf51_gpio.c b/hw/gpio/nrf51_gpio.c
index 24a890911a..b47fddf4ed 100644
--- a/hw/gpio/nrf51_gpio.c
+++ b/hw/gpio/nrf51_gpio.c
@@ -15,6 +15,7 @@
 #include "qemu/module.h"
 #include "hw/gpio/nrf51_gpio.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
 #include "trace.h"
=20
 /*
diff --git a/hw/gpio/pl061.c b/hw/gpio/pl061.c
index c605d91c93..2a828260bd 100644
--- a/hw/gpio/pl061.c
+++ b/hw/gpio/pl061.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/gpio/zaurus.c b/hw/gpio/zaurus.c
index 98aa416931..a1ba09c6f2 100644
--- a/hw/gpio/zaurus.c
+++ b/hw/gpio/zaurus.c
@@ -21,6 +21,7 @@
 #include "hw/irq.h"
 #include "hw/arm/sharpsl.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
=20
 #undef REG_FMT
diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index 90da6bcbb9..dfb9d7a742 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -20,6 +20,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
+#include "migration/vmstate.h"
 #include "hppa_sys.h"
 #include "exec/address-spaces.h"
=20
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index bb7ef3cbf3..a956eb3849 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -20,6 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/i2c/aspeed_i2c.h"
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 20f36f1d55..25b792fdd0 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -9,6 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "trace.h"
=20
diff --git a/hw/i2c/exynos4210_i2c.c b/hw/i2c/exynos4210_i2c.c
index 07d83d5a63..a600f65560 100644
--- a/hw/i2c/exynos4210_i2c.c
+++ b/hw/i2c/exynos4210_i2c.c
@@ -24,6 +24,7 @@
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/i2c/i2c.h"
 #include "hw/irq.h"
=20
diff --git a/hw/i2c/imx_i2c.c b/hw/i2c/imx_i2c.c
index 1d6b695615..30b9aea247 100644
--- a/hw/i2c/imx_i2c.c
+++ b/hw/i2c/imx_i2c.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "hw/i2c/imx_i2c.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
 #include "hw/i2c/i2c.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/i2c/microbit_i2c.c b/hw/i2c/microbit_i2c.c
index 214be07c5a..4661f05253 100644
--- a/hw/i2c/microbit_i2c.c
+++ b/hw/i2c/microbit_i2c.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/i2c/microbit_i2c.h"
+#include "migration/vmstate.h"
=20
 static const uint32_t twi_read_sequence[] =3D {0x5A, 0x5A, 0x40};
=20
diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
index 0aa4cacb65..0aa1be3ce7 100644
--- a/hw/i2c/mpc_i2c.c
+++ b/hw/i2c/mpc_i2c.c
@@ -23,6 +23,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
=20
 /* #define DEBUG_I2C */
=20
diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index e48544f909..d9e3bad90d 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -17,11 +17,13 @@
  * License along with this library; if not, see
  * <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/boards.h"
 #include "hw/i2c/pm_smbus.h"
 #include "hw/i2c/smbus_master.h"
+#include "migration/vmstate.h"
=20
 #define SMBHSTSTS       0x00
 #define SMBHSTCNT       0x02
diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 37167e7244..e05bc8c39c 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -29,6 +29,7 @@
 #include "hw/boards.h"
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/smbus_slave.h"
+#include "migration/vmstate.h"
 #include "hw/i2c/smbus_eeprom.h"
=20
 //#define DEBUG
diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
index 51a03046a6..f7e626e95a 100644
--- a/hw/i2c/smbus_ich9.c
+++ b/hw/i2c/smbus_ich9.c
@@ -24,6 +24,7 @@
 #include "hw/hw.h"
 #include "hw/i2c/pm_smbus.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "sysemu/sysemu.h"
=20
diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index a9908c1a9b..7b145a384d 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -17,6 +17,7 @@
 #include "hw/hw.h"
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/smbus_slave.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
=20
 //#define DEBUG_SMBUS 1
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 74667a53be..5b0ec1b89e 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -46,6 +46,7 @@
 #include "hw/boards.h"
 #include "sysemu/tpm_backend.h"
 #include "hw/timer/mc146818rtc_regs.h"
+#include "migration/vmstate.h"
 #include "hw/mem/memory-device.h"
 #include "sysemu/numa.h"
 #include "sysemu/reset.h"
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 4a4e2c7fd4..08884523e2 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -19,10 +19,12 @@
  *
  * Cache implementation inspired by hw/i386/intel_iommu.c
  */
+
 #include "qemu/osdep.h"
 #include "hw/i386/pc.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/pci_bus.h"
+#include "migration/vmstate.h"
 #include "amd_iommu.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index de86f53b4e..000de6b9ce 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -35,6 +35,7 @@
 #include "sysemu/kvm.h"
 #include "hw/i386/apic_internal.h"
 #include "kvm_i386.h"
+#include "migration/vmstate.h"
 #include "trace.h"
=20
 /* context entry operations */
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index a5cda15b85..d98cf9d5d1 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -21,6 +21,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/hw_accel.h"
 #include "kvm_i386.h"
+#include "migration/vmstate.h"
 #include "hw/sysbus.h"
 #include "hw/kvm/clock.h"
 #include "qapi/error.h"
diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
index 9c2ab4aac5..44e40478c8 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/kvmvapic.c
@@ -19,6 +19,7 @@
 #include "hw/i386/apic_internal.h"
 #include "hw/sysbus.h"
 #include "hw/boards.h"
+#include "migration/vmstate.h"
 #include "tcg/tcg.h"
=20
 #define VAPIC_IO_PORT           0x7e
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 1453696975..1e8251d327 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -41,6 +41,7 @@
 #include "hw/firmware/smbios.h"
 #include "hw/loader.h"
 #include "elf.h"
+#include "migration/vmstate.h"
 #include "multiboot.h"
 #include "hw/timer/mc146818rtc.h"
 #include "hw/dma/i8257.h"
diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index 5d2d278be4..a50f5d5dd4 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -21,12 +21,14 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "ui/console.h"
 #include "hw/i386/pc.h"
 #include "hw/input/i8042.h"
 #include "hw/qdev.h"
+#include "migration/vmstate.h"
=20
 /* debug only vmmouse */
 //#define DEBUG_VMMOUSE
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index 7a972e46cf..800687a188 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -30,6 +30,7 @@
 #include "hw/pci/pci.h"
 #include "hw/irq.h"
 #include "hw/xen/xen_common.h"
+#include "migration/vmstate.h"
 #include "hw/xen/xen-legacy-backend.h"
 #include "trace.h"
 #include "exec/address-spaces.h"
diff --git a/hw/i386/xen/xen_pvdevice.c b/hw/i386/xen/xen_pvdevice.c
index 23748f36a2..700db81cbc 100644
--- a/hw/i386/xen/xen_pvdevice.c
+++ b/hw/i386/xen/xen_pvdevice.c
@@ -34,6 +34,7 @@
 #include "qemu/module.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
 #include "trace.h"
=20
 #define TYPE_XEN_PV_DEVICE  "xen-pvdevice"
diff --git a/hw/ide/ahci-allwinner.c b/hw/ide/ahci-allwinner.c
index de08d87790..8777122c9c 100644
--- a/hw/ide/ahci-allwinner.c
+++ b/hw/ide/ahci-allwinner.c
@@ -21,6 +21,7 @@
 #include "qemu/module.h"
 #include "sysemu/dma.h"
 #include "hw/ide/internal.h"
+#include "migration/vmstate.h"
 #include "ahci_internal.h"
=20
 #include "trace.h"
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 00ba422a48..e0b1a91fd9 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -25,6 +25,7 @@
 #include "hw/hw.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
=20
 #include "qemu/error-report.h"
 #include "qemu/log.h"
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index e5542c9811..a3763a1d3a 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "hw/isa/isa.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 6afadf894f..0453a925f9 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/isa/isa.h"
+#include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index c1ba927574..00fb43a127 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -64,6 +64,7 @@
 #include "hw/hw.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "hw/isa/isa.h"
 #include "sysemu/dma.h"
diff --git a/hw/ide/isa.c b/hw/ide/isa.c
index 4b5784e3fd..fda912f3ed 100644
--- a/hw/ide/isa.c
+++ b/hw/ide/isa.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/isa/isa.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "sysemu/dma.h"
=20
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index 54571fed12..aa447cd2b5 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -27,6 +27,7 @@
 #include "hw/hw.h"
 #include "hw/ppc/mac.h"
 #include "hw/ppc/mac_dbdma.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "hw/misc/macio/macio.h"
 #include "sysemu/block-backend.h"
diff --git a/hw/ide/microdrive.c b/hw/ide/microdrive.c
index 92ee6e0af8..be3cf8779a 100644
--- a/hw/ide/microdrive.c
+++ b/hw/ide/microdrive.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pcmcia.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "sysemu/dma.h"
=20
diff --git a/hw/ide/mmio.c b/hw/ide/mmio.c
index 70a58016d0..f3de6db33e 100644
--- a/hw/ide/mmio.c
+++ b/hw/ide/mmio.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "sysemu/dma.h"
=20
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index 4c6fb9a68e..c5b081a028 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
 #include "sysemu/dma.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index c4c6d4b760..407d3e3ce8 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/ide/via.c b/hw/ide/via.c
index 6d54ac55f0..8fa1972d92 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -27,6 +27,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/dma.h"
diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index da361f56df..b3c4aeded1 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/input/adb.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "ui/input.h"
 #include "hw/input/adb-keys.h"
diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
index 52526fddb7..aeba41bddd 100644
--- a/hw/input/adb-mouse.c
+++ b/hw/input/adb-mouse.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "ui/console.h"
 #include "hw/input/adb.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "adb-internal.h"
 #include "trace.h"
diff --git a/hw/input/adb.c b/hw/input/adb.c
index 1446f32521..80ba1259bf 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/input/adb.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "adb-internal.h"
=20
diff --git a/hw/input/hid.c b/hw/input/hid.c
index aa4fb826fd..c570ca25b1 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -22,11 +22,13 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "ui/console.h"
 #include "qemu/timer.h"
 #include "hw/input/hid.h"
+#include "migration/vmstate.h"
 #include "trace.h"
=20
 #define HID_USAGE_ERROR_ROLLOVER        0x01
diff --git a/hw/input/lm832x.c b/hw/input/lm832x.c
index 2ab6d3290b..de03913d7c 100644
--- a/hw/input/lm832x.c
+++ b/hw/input/lm832x.c
@@ -22,6 +22,7 @@
 #include "hw/hw.h"
 #include "hw/i2c/i2c.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "sysemu/reset.h"
diff --git a/hw/input/milkymist-softusb.c b/hw/input/milkymist-softusb.c
index 92e07fbd8c..e17666d56b 100644
--- a/hw/input/milkymist-softusb.c
+++ b/hw/input/milkymist-softusb.c
@@ -25,6 +25,7 @@
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "trace.h"
 #include "ui/console.h"
 #include "hw/input/hid.h"
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index 7e76ee7ad3..cf1690332d 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -26,6 +26,7 @@
 #include "qemu/log.h"
 #include "hw/hw.h"
 #include "hw/isa/isa.h"
+#include "migration/vmstate.h"
 #include "hw/i386/pc.h"
 #include "hw/input/ps2.h"
 #include "hw/irq.h"
diff --git a/hw/input/pl050.c b/hw/input/pl050.c
index 2318dbfeac..1123037b38 100644
--- a/hw/input/pl050.c
+++ b/hw/input/pl050.c
@@ -9,6 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/input/ps2.h"
 #include "hw/irq.h"
 #include "qemu/log.h"
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 8d922b05c9..07d07ee6bd 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -26,6 +26,7 @@
 #include "qemu/log.h"
 #include "hw/hw.h"
 #include "hw/input/ps2.h"
+#include "migration/vmstate.h"
 #include "ui/console.h"
 #include "ui/input.h"
 #include "sysemu/reset.h"
diff --git a/hw/input/pxa2xx_keypad.c b/hw/input/pxa2xx_keypad.c
index 4788c96d19..31862a7d16 100644
--- a/hw/input/pxa2xx_keypad.c
+++ b/hw/input/pxa2xx_keypad.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
 #include "hw/arm/pxa.h"
 #include "ui/console.h"
=20
diff --git a/hw/input/stellaris_input.c b/hw/input/stellaris_input.c
index ffea0542ba..7582117f0b 100644
--- a/hw/input/stellaris_input.c
+++ b/hw/input/stellaris_input.c
@@ -11,6 +11,7 @@
 #include "hw/hw.h"
 #include "hw/input/gamepad.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
 #include "ui/console.h"
=20
 typedef struct {
diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index e21356c18d..b92a034496 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -26,6 +26,7 @@
 #include "ui/console.h"
 #include "hw/input/tsc2xxx.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
 #include "trace.h"
=20
 #define TSC_CUT_RESOLUTION(value, p)	((value) >> (16 - (p ? 12 : 10)))
diff --git a/hw/input/tsc210x.c b/hw/input/tsc210x.c
index be7d948168..182d3725fc 100644
--- a/hw/input/tsc210x.c
+++ b/hw/input/tsc210x.c
@@ -28,6 +28,7 @@
 #include "hw/arm/omap.h"            /* For I2SCodec */
 #include "hw/input/tsc2xxx.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
=20
 #define TSC_DATA_REGISTERS_PAGE		0x0
 #define TSC_CONTROL_REGISTERS_PAGE	0x1
diff --git a/hw/intc/allwinner-a10-pic.c b/hw/intc/allwinner-a10-pic.c
index 9df3e18539..79959a4d23 100644
--- a/hw/intc/allwinner-a10-pic.c
+++ b/hw/intc/allwinner-a10-pic.c
@@ -17,6 +17,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "sysemu/sysemu.h"
 #include "hw/intc/allwinner-a10-pic.h"
 #include "hw/irq.h"
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 7045761281..fbb6e25cf4 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -32,6 +32,7 @@
 #include "hw/qdev.h"
 #include "hw/sysbus.h"
 #include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
=20
 static int apic_irq_delivered;
 bool apic_report_tpr_access;
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index ccc50d00b6..5d506bebb5 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -23,6 +23,7 @@
 #include "qemu/module.h"
 #include "gic_internal.h"
 #include "hw/arm/linux-boot-if.h"
+#include "migration/vmstate.h"
=20
 static int gic_pre_save(void *opaque)
 {
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 5edabb928f..12479f94a8 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -26,6 +26,7 @@
 #include "qemu/module.h"
 #include "qom/cpu.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "migration/vmstate.h"
 #include "gicv3_internal.h"
 #include "hw/arm/linux-boot-if.h"
 #include "sysemu/kvm.h"
diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_commo=
n.c
index efb3d51fb5..66c4c6a188 100644
--- a/hw/intc/arm_gicv3_its_common.c
+++ b/hw/intc/arm_gicv3_its_common.c
@@ -20,6 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/pci/msi.h"
+#include "migration/vmstate.h"
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 69670a2d97..0c7fc7078b 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "hw/intc/armv7m_nvic.h"
 #include "hw/irq.h"
diff --git a/hw/intc/aspeed_vic.c b/hw/intc/aspeed_vic.c
index e17343cd73..5ba06c5262 100644
--- a/hw/intc/aspeed_vic.c
+++ b/hw/intc/aspeed_vic.c
@@ -30,6 +30,7 @@
 #include "qemu/osdep.h"
 #include "hw/intc/aspeed_vic.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/intc/bcm2835_ic.c b/hw/intc/bcm2835_ic.c
index 20db52bd8e..05bd28e4f9 100644
--- a/hw/intc/bcm2835_ic.c
+++ b/hw/intc/bcm2835_ic.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "hw/intc/bcm2835_ic.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/intc/bcm2836_control.c b/hw/intc/bcm2836_control.c
index a983fe565f..04229b8a17 100644
--- a/hw/intc/bcm2836_control.c
+++ b/hw/intc/bcm2836_control.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "hw/intc/bcm2836_control.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.=
c
index ed558115f6..3b49ce4d27 100644
--- a/hw/intc/exynos4210_combiner.c
+++ b/hw/intc/exynos4210_combiner.c
@@ -29,6 +29,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
=20
 #include "hw/arm/exynos4210.h"
diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
index e37d457fcf..7fa4583b0f 100644
--- a/hw/intc/exynos4210_gic.c
+++ b/hw/intc/exynos4210_gic.c
@@ -22,6 +22,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "hw/irq.h"
 #include "hw/arm/exynos4210.h"
diff --git a/hw/intc/heathrow_pic.c b/hw/intc/heathrow_pic.c
index ac1f7c0c8f..572e9115aa 100644
--- a/hw/intc/heathrow_pic.c
+++ b/hw/intc/heathrow_pic.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/ppc/mac.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "hw/intc/heathrow_pic.h"
 #include "hw/irq.h"
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index c75c880157..c7ff2b3274 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -22,9 +22,11 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/i386/pc.h"
 #include "hw/isa/i8259_internal.h"
+#include "migration/vmstate.h"
 #include "monitor/monitor.h"
=20
 static int irq_level[16];
diff --git a/hw/intc/imx_avic.c b/hw/intc/imx_avic.c
index 022ed05b6f..63fc602a1a 100644
--- a/hw/intc/imx_avic.c
+++ b/hw/intc/imx_avic.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "hw/intc/imx_avic.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/intc/imx_gpcv2.c b/hw/intc/imx_gpcv2.c
index a83333bdea..17007a4078 100644
--- a/hw/intc/imx_gpcv2.c
+++ b/hw/intc/imx_gpcv2.c
@@ -11,6 +11,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/intc/imx_gpcv2.h"
+#include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
index fa50382d43..5538b5b86e 100644
--- a/hw/intc/ioapic_common.c
+++ b/hw/intc/ioapic_common.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "hw/i386/ioapic.h"
 #include "hw/i386/ioapic_internal.h"
diff --git a/hw/intc/lm32_pic.c b/hw/intc/lm32_pic.c
index c133d30cf2..4df4eef7df 100644
--- a/hw/intc/lm32_pic.c
+++ b/hw/intc/lm32_pic.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
=20
 #include "hw/hw.h"
+#include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "qemu/module.h"
 #include "hw/sysbus.h"
diff --git a/hw/intc/ompic.c b/hw/intc/ompic.c
index 31004ac613..77591f827d 100644
--- a/hw/intc/ompic.c
+++ b/hw/intc/ompic.c
@@ -13,6 +13,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "exec/memory.h"
=20
 #define TYPE_OR1K_OMPIC "or1k-ompic"
diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 49d64bccfe..bb869ca221 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -42,6 +42,7 @@
 #include "hw/ppc/openpic.h"
 #include "hw/ppc/ppc_e500.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/pci/msi.h"
 #include "qapi/error.h"
 #include "qemu/bitops.h"
diff --git a/hw/intc/pl190.c b/hw/intc/pl190.c
index 1a5e760f0f..e3bd3dd121 100644
--- a/hw/intc/pl190.c
+++ b/hw/intc/pl190.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/intc/slavio_intctl.c b/hw/intc/slavio_intctl.c
index e97afcadf6..c4cf9096eb 100644
--- a/hw/intc/slavio_intctl.c
+++ b/hw/intc/slavio_intctl.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "qemu/module.h"
 #include "hw/sysbus.h"
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 2e39cc1e47..2fdd68035a 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -15,6 +15,7 @@
 #include "target/ppc/cpu.h"
 #include "sysemu/cpus.h"
 #include "sysemu/reset.h"
+#include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/spapr.h"
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index beb37b1a2b..41da9b3091 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -35,6 +35,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qapi/visitor.h"
+#include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "hw/intc/intc.h"
 #include "hw/irq.h"
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index d977ed568f..b925ea9530 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -16,6 +16,7 @@
 #include "sysemu/dma.h"
 #include "sysemu/reset.h"
 #include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "hw/irq.h"
 #include "hw/ppc/xive.h"
diff --git a/hw/intc/xlnx-pmu-iomod-intc.c b/hw/intc/xlnx-pmu-iomod-intc.=
c
index 9fcd17c6fd..f2ba9b4ada 100644
--- a/hw/intc/xlnx-pmu-iomod-intc.c
+++ b/hw/intc/xlnx-pmu-iomod-intc.c
@@ -26,6 +26,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/register.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
diff --git a/hw/intc/xlnx-zynqmp-ipi.c b/hw/intc/xlnx-zynqmp-ipi.c
index 43a1b789b5..adc1179014 100644
--- a/hw/intc/xlnx-zynqmp-ipi.c
+++ b/hw/intc/xlnx-zynqmp-ipi.c
@@ -27,6 +27,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/register.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
diff --git a/hw/ipack/ipack.c b/hw/ipack/ipack.c
index b8ff979d72..9a520806d7 100644
--- a/hw/ipack/ipack.c
+++ b/hw/ipack/ipack.c
@@ -13,6 +13,7 @@
 #include "qemu/module.h"
 #include "hw/ipack/ipack.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
=20
 IPackDevice *ipack_device_find(IPackBus *bus, int32_t slot)
 {
diff --git a/hw/ipack/tpci200.c b/hw/ipack/tpci200.c
index 7ee9d01771..f931d4df62 100644
--- a/hw/ipack/tpci200.c
+++ b/hw/ipack/tpci200.c
@@ -13,6 +13,7 @@
 #include "hw/ipack/ipack.h"
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
 #include "qemu/bitops.h"
 #include "qemu/module.h"
=20
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index c0a8dac346..eb2eba891c 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -35,6 +35,7 @@
 #include "chardev/char-fe.h"
 #include "sysemu/sysemu.h"
 #include "hw/ipmi/ipmi.h"
+#include "migration/vmstate.h"
=20
 #define VM_MSG_CHAR        0xA0 /* Marks end of message */
 #define VM_CMD_CHAR        0xA1 /* Marks end of a command */
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 1980536517..91e1484103 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -29,6 +29,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/loader.h"
+#include "migration/vmstate.h"
=20
 #define IPMI_NETFN_CHASSIS            0x00
=20
diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index af07278c19..588dfbac34 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -30,6 +30,7 @@
 #include "hw/ipmi/ipmi.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
+#include "migration/vmstate.h"
=20
 /* Control register */
 #define IPMI_BT_CLR_WR_BIT         0
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index 583497685a..e63753f03e 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -30,6 +30,7 @@
 #include "hw/ipmi/ipmi.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
+#include "migration/vmstate.h"
=20
 #define IPMI_KCS_OBF_BIT        0
 #define IPMI_KCS_IBF_BIT        1
diff --git a/hw/isa/apm.c b/hw/isa/apm.c
index c3101ef52f..f22b2d78a4 100644
--- a/hw/isa/apm.c
+++ b/hw/isa/apm.c
@@ -24,6 +24,7 @@
 #include "hw/isa/apm.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
=20
 //#define DEBUG
=20
diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index 90ebba59b7..de276cdf10 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -22,6 +22,7 @@
 #include "hw/i386/pc.h"
 #include "hw/irq.h"
 #include "hw/timer/i8254.h"
+#include "migration/vmstate.h"
 #include "hw/audio/pcspk.h"
=20
 #define TYPE_I82378 "i82378"
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 42a1232787..79d44c1b41 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -35,6 +35,7 @@
 #include "qemu/range.h"
 #include "hw/isa/isa.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/i386/pc.h"
 #include "hw/irq.h"
 #include "hw/isa/apm.h"
diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index 85dbc94439..60845f3ff0 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -25,6 +25,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/isa/pc87312.h"
+#include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 3677976ef7..8abd5daaae 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -28,6 +28,7 @@
 #include "hw/pci/pci.h"
 #include "hw/isa/isa.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "sysemu/reset.h"
=20
 PCIDevice *piix4_dev;
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 81bffb1fb9..d98b94ab05 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -18,6 +18,7 @@
 #include "hw/isa/isa.h"
 #include "hw/isa/superio.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/mips/mips.h"
 #include "hw/isa/apm.h"
 #include "hw/acpi/acpi.h"
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 29c785799c..ff43150e7d 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -20,6 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/mem/pc-dimm.h"
+#include "migration/vmstate.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/mem/memory-device.h"
 #include "qapi/error.h"
diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index 15d4adb3cd..b4412c6c24 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -29,6 +29,7 @@
 #include "hw/mips/mips.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
+#include "migration/vmstate.h"
 #include "hw/i386/pc.h"
 #include "hw/irq.h"
 #include "exec/address-spaces.h"
diff --git a/hw/misc/a9scu.c b/hw/misc/a9scu.c
index 4307f0082b..62bc60b2ae 100644
--- a/hw/misc/a9scu.c
+++ b/hw/misc/a9scu.c
@@ -10,6 +10,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/misc/a9scu.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
=20
 static uint64_t a9_scu_read(void *opaque, hwaddr offset,
diff --git a/hw/misc/arm_l2x0.c b/hw/misc/arm_l2x0.c
index b88f40ae7e..454a942ce0 100644
--- a/hw/misc/arm_l2x0.c
+++ b/hw/misc/arm_l2x0.c
@@ -20,6 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index be8c9c0a7f..47051436f4 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -13,6 +13,7 @@
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/arm/primecell.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
diff --git a/hw/misc/armsse-mhu.c b/hw/misc/armsse-mhu.c
index f8d4187bb8..34b6205f11 100644
--- a/hw/misc/armsse-mhu.c
+++ b/hw/misc/armsse-mhu.c
@@ -22,6 +22,7 @@
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/registerfields.h"
 #include "hw/irq.h"
 #include "hw/misc/armsse-mhu.h"
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 71a0d4b7be..268cb24e56 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "hw/misc/aspeed_scu.h"
 #include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qemu/bitops.h"
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index b84676d36d..cb13c63ec8 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -14,6 +14,7 @@
 #include "hw/misc/aspeed_sdmc.h"
 #include "hw/misc/aspeed_scu.h"
 #include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "trace.h"
=20
diff --git a/hw/misc/aspeed_xdma.c b/hw/misc/aspeed_xdma.c
index 18a83bcc6c..dca5585a75 100644
--- a/hw/misc/aspeed_xdma.c
+++ b/hw/misc/aspeed_xdma.c
@@ -11,6 +11,7 @@
 #include "qemu/error-report.h"
 #include "hw/irq.h"
 #include "hw/misc/aspeed_xdma.h"
+#include "migration/vmstate.h"
 #include "qapi/error.h"
=20
 #include "trace.h"
diff --git a/hw/misc/bcm2835_mbox.c b/hw/misc/bcm2835_mbox.c
index e484d25c29..79bad11631 100644
--- a/hw/misc/bcm2835_mbox.c
+++ b/hw/misc/bcm2835_mbox.c
@@ -12,6 +12,7 @@
 #include "qapi/error.h"
 #include "hw/irq.h"
 #include "hw/misc/bcm2835_mbox.h"
+#include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 51cd93fc8b..0d078f15f9 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -6,6 +6,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/misc/bcm2835_property.h"
+#include "migration/vmstate.h"
 #include "hw/irq.h"
 #include "hw/misc/bcm2835_mbox_defs.h"
 #include "sysemu/dma.h"
diff --git a/hw/misc/bcm2835_rng.c b/hw/misc/bcm2835_rng.c
index e882c87568..d0c4e64e88 100644
--- a/hw/misc/bcm2835_rng.c
+++ b/hw/misc/bcm2835_rng.c
@@ -12,6 +12,7 @@
 #include "qemu/guest-random.h"
 #include "qemu/module.h"
 #include "hw/misc/bcm2835_rng.h"
+#include "migration/vmstate.h"
=20
 static uint32_t get_random_bytes(void)
 {
diff --git a/hw/misc/eccmemctl.c b/hw/misc/eccmemctl.c
index c16d56c8c7..3300a46bb3 100644
--- a/hw/misc/eccmemctl.c
+++ b/hw/misc/eccmemctl.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "trace.h"
=20
diff --git a/hw/misc/exynos4210_clk.c b/hw/misc/exynos4210_clk.c
index 821d9eab3f..bc1463ff89 100644
--- a/hw/misc/exynos4210_clk.c
+++ b/hw/misc/exynos4210_clk.c
@@ -19,6 +19,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/misc/exynos4210_pmu.c b/hw/misc/exynos4210_pmu.c
index 8712774768..4817165121 100644
--- a/hw/misc/exynos4210_pmu.c
+++ b/hw/misc/exynos4210_pmu.c
@@ -26,6 +26,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "sysemu/sysemu.h"
=20
diff --git a/hw/misc/exynos4210_rng.c b/hw/misc/exynos4210_rng.c
index b88fe3a26d..38cd61c7ea 100644
--- a/hw/misc/exynos4210_rng.c
+++ b/hw/misc/exynos4210_rng.c
@@ -19,6 +19,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/guest-random.h"
diff --git a/hw/misc/imx25_ccm.c b/hw/misc/imx25_ccm.c
index 693ea81040..d3107e5ca2 100644
--- a/hw/misc/imx25_ccm.c
+++ b/hw/misc/imx25_ccm.c
@@ -13,6 +13,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/misc/imx25_ccm.h"
+#include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/misc/imx31_ccm.c b/hw/misc/imx31_ccm.c
index 38a19aa0d0..6e246827ab 100644
--- a/hw/misc/imx31_ccm.c
+++ b/hw/misc/imx31_ccm.c
@@ -13,6 +13,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/misc/imx31_ccm.h"
+#include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/misc/imx6_ccm.c b/hw/misc/imx6_ccm.c
index 9478007f41..7fec8f0a47 100644
--- a/hw/misc/imx6_ccm.c
+++ b/hw/misc/imx6_ccm.c
@@ -12,6 +12,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/misc/imx6_ccm.h"
+#include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/misc/imx6_src.c b/hw/misc/imx6_src.c
index 878ffcdc71..0be683de06 100644
--- a/hw/misc/imx6_src.c
+++ b/hw/misc/imx6_src.c
@@ -10,6 +10,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/misc/imx6_src.h"
+#include "migration/vmstate.h"
 #include "sysemu/sysemu.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
diff --git a/hw/misc/imx6ul_ccm.c b/hw/misc/imx6ul_ccm.c
index 37b472d125..a2fc1d0364 100644
--- a/hw/misc/imx6ul_ccm.c
+++ b/hw/misc/imx6ul_ccm.c
@@ -12,6 +12,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/registerfields.h"
+#include "migration/vmstate.h"
 #include "hw/misc/imx6ul_ccm.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/misc/imx7_ccm.c b/hw/misc/imx7_ccm.c
index d9bdcf1027..02fc1ae8d0 100644
--- a/hw/misc/imx7_ccm.c
+++ b/hw/misc/imx7_ccm.c
@@ -14,6 +14,7 @@
 #include "qemu/module.h"
=20
 #include "hw/misc/imx7_ccm.h"
+#include "migration/vmstate.h"
=20
 static void imx7_analog_reset(DeviceState *dev)
 {
diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index 963fd6efd3..609869821a 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -15,6 +15,7 @@
 #include "qapi/error.h"
 #include "trace.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/registerfields.h"
 #include "hw/irq.h"
 #include "hw/misc/iotkit-secctl.h"
diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
index 00d4faa6db..31fe9a5997 100644
--- a/hw/misc/iotkit-sysctl.c
+++ b/hw/misc/iotkit-sysctl.c
@@ -24,6 +24,7 @@
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/registerfields.h"
 #include "hw/misc/iotkit-sysctl.h"
 #include "target/arm/arm-powerctl.h"
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index f9cc66aba8..d9b7ea145c 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -27,6 +27,7 @@
 #include "hw/pci/msix.h"
 #include "sysemu/kvm.h"
 #include "migration/blocker.h"
+#include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/event_notifier.h"
 #include "qemu/module.h"
diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 4f532efe34..feb80df0ff 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -27,6 +27,7 @@
 #include "qemu-common.h"
 #include "hw/hw.h"
 #include "hw/ppc/mac.h"
+#include "migration/vmstate.h"
 #include "hw/input/adb.h"
 #include "hw/misc/mos6522.h"
 #include "hw/misc/macio/cuda.h"
diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
index 31811ab513..6f90afefb7 100644
--- a/hw/misc/macio/gpio.c
+++ b/hw/misc/macio/gpio.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/ppc/mac.h"
+#include "migration/vmstate.h"
 #include "hw/misc/macio/macio.h"
 #include "hw/misc/macio/gpio.h"
 #include "hw/nmi.h"
diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
index 8a1de8c31d..beaf083578 100644
--- a/hw/misc/macio/mac_dbdma.c
+++ b/hw/misc/macio/mac_dbdma.c
@@ -41,6 +41,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/ppc/mac_dbdma.h"
+#include "migration/vmstate.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 82492096f8..c797bbd698 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -31,6 +31,7 @@
 #include "hw/misc/macio/cuda.h"
 #include "hw/pci/pci.h"
 #include "hw/ppc/mac_dbdma.h"
+#include "migration/vmstate.h"
 #include "hw/char/escc.h"
 #include "hw/misc/macio/macio.h"
 #include "hw/intc/heathrow_pic.h"
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index 6280bcbc61..507f62ba64 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -32,6 +32,7 @@
 #include "qemu-common.h"
 #include "hw/hw.h"
 #include "hw/ppc/mac.h"
+#include "migration/vmstate.h"
 #include "hw/input/adb.h"
 #include "hw/irq.h"
 #include "hw/misc/mos6522.h"
diff --git a/hw/misc/max111x.c b/hw/misc/max111x.c
index 6fd7210c67..a713149f16 100644
--- a/hw/misc/max111x.c
+++ b/hw/misc/max111x.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/ssi/ssi.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
=20
 typedef struct {
diff --git a/hw/misc/milkymist-hpdmc.c b/hw/misc/milkymist-hpdmc.c
index 701c79e81c..e9722d6c76 100644
--- a/hw/misc/milkymist-hpdmc.c
+++ b/hw/misc/milkymist-hpdmc.c
@@ -24,6 +24,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/misc/milkymist-pfpu.c b/hw/misc/milkymist-pfpu.c
index fb21b898d1..8c6baf5406 100644
--- a/hw/misc/milkymist-pfpu.c
+++ b/hw/misc/milkymist-pfpu.c
@@ -26,6 +26,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "trace.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/misc/mips_cmgcr.c b/hw/misc/mips_cmgcr.c
index edec164605..6dcdb4a225 100644
--- a/hw/misc/mips_cmgcr.c
+++ b/hw/misc/mips_cmgcr.c
@@ -14,6 +14,7 @@
 #include "qemu/module.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "sysemu/sysemu.h"
 #include "hw/misc/mips_cmgcr.h"
 #include "hw/misc/mips_cpc.h"
diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index 446b1ad397..caa618f582 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -23,6 +23,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
=20
 #include "hw/misc/mips_cpc.h"
=20
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 84c677c131..7e6dead089 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -29,6 +29,7 @@
 #include "hw/input/adb.h"
 #include "hw/irq.h"
 #include "hw/misc/mos6522.h"
+#include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
diff --git a/hw/misc/mps2-fpgaio.c b/hw/misc/mps2-fpgaio.c
index b97ad42d75..4824dc09b2 100644
--- a/hw/misc/mps2-fpgaio.c
+++ b/hw/misc/mps2-fpgaio.c
@@ -21,6 +21,7 @@
 #include "qapi/error.h"
 #include "trace.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/registerfields.h"
 #include "hw/misc/mps2-fpgaio.h"
 #include "qemu/timer.h"
diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 1fdf5d22bd..042ce130ba 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -22,6 +22,7 @@
 #include "qemu/module.h"
 #include "trace.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/registerfields.h"
 #include "hw/misc/mps2-scc.h"
=20
diff --git a/hw/misc/msf2-sysreg.c b/hw/misc/msf2-sysreg.c
index 21a2863821..da0f7c26e1 100644
--- a/hw/misc/msf2-sysreg.c
+++ b/hw/misc/msf2-sysreg.c
@@ -17,6 +17,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/misc/msf2-sysreg.h"
+#include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "trace.h"
=20
diff --git a/hw/misc/mst_fpga.c b/hw/misc/mst_fpga.c
index 256746ac15..d002870e56 100644
--- a/hw/misc/mst_fpga.c
+++ b/hw/misc/mst_fpga.c
@@ -15,6 +15,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
=20
 /* Mainstone FPGA for extern irqs */
diff --git a/hw/misc/nrf51_rng.c b/hw/misc/nrf51_rng.c
index cf1bec223e..8528c8880c 100644
--- a/hw/misc/nrf51_rng.c
+++ b/hw/misc/nrf51_rng.c
@@ -16,6 +16,7 @@
 #include "hw/arm/nrf51.h"
 #include "hw/irq.h"
 #include "hw/misc/nrf51_rng.h"
+#include "migration/vmstate.h"
 #include "qemu/guest-random.h"
=20
 static void update_irq(NRF51RNGState *s)
diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index 3422397f89..bb05811e1f 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -15,6 +15,7 @@
 #include "hw/hw.h"
 #include "hw/misc/pca9552.h"
 #include "hw/misc/pca9552_regs.h"
+#include "migration/vmstate.h"
=20
 #define PCA9552_LED_ON   0x0
 #define PCA9552_LED_OFF  0x1
diff --git a/hw/misc/slavio_misc.c b/hw/misc/slavio_misc.c
index 5f351950db..7ef73506ae 100644
--- a/hw/misc/slavio_misc.c
+++ b/hw/misc/slavio_misc.c
@@ -26,6 +26,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "trace.h"
=20
diff --git a/hw/misc/tmp105.c b/hw/misc/tmp105.c
index 2e304218f4..28996473cb 100644
--- a/hw/misc/tmp105.c
+++ b/hw/misc/tmp105.c
@@ -22,6 +22,7 @@
 #include "hw/hw.h"
 #include "hw/i2c/i2c.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
 #include "tmp105.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
diff --git a/hw/misc/tmp421.c b/hw/misc/tmp421.c
index 69ee5db4b7..6728aa7e10 100644
--- a/hw/misc/tmp421.c
+++ b/hw/misc/tmp421.c
@@ -27,6 +27,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/i2c/i2c.h"
+#include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
index 802aeb7377..deb7796ec2 100644
--- a/hw/misc/tz-mpc.c
+++ b/hw/misc/tz-mpc.c
@@ -15,6 +15,7 @@
 #include "qapi/error.h"
 #include "trace.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/registerfields.h"
 #include "hw/irq.h"
 #include "hw/misc/tz-mpc.h"
diff --git a/hw/misc/tz-msc.c b/hw/misc/tz-msc.c
index 7d1a536ce4..5b664d760f 100644
--- a/hw/misc/tz-msc.c
+++ b/hw/misc/tz-msc.c
@@ -15,6 +15,7 @@
 #include "qapi/error.h"
 #include "trace.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/registerfields.h"
 #include "hw/irq.h"
 #include "hw/misc/tz-msc.h"
diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
index 54db7fc152..ccc4468c11 100644
--- a/hw/misc/tz-ppc.c
+++ b/hw/misc/tz-ppc.c
@@ -15,6 +15,7 @@
 #include "qapi/error.h"
 #include "trace.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/registerfields.h"
 #include "hw/irq.h"
 #include "hw/misc/tz-ppc.h"
diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
index 49e87d462b..326a3ce8f4 100644
--- a/hw/misc/vmcoreinfo.c
+++ b/hw/misc/vmcoreinfo.c
@@ -15,6 +15,7 @@
 #include "qemu/module.h"
 #include "sysemu/reset.h"
 #include "hw/nvram/fw_cfg.h"
+#include "migration/vmstate.h"
 #include "hw/misc/vmcoreinfo.h"
=20
 static void fw_cfg_vmci_write(void *dev, off_t offset, size_t len)
diff --git a/hw/misc/zynq-xadc.c b/hw/misc/zynq-xadc.c
index c5cff5a8a9..edfe76ba20 100644
--- a/hw/misc/zynq-xadc.c
+++ b/hw/misc/zynq-xadc.c
@@ -17,6 +17,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/misc/zynq-xadc.h"
+#include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index 6b51ae5ff1..82430a146a 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -18,6 +18,7 @@
 #include "hw/hw.h"
 #include "qemu/timer.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/net/allwinner_emac.c b/hw/net/allwinner_emac.c
index dad25bd4e9..f4b8c4fa67 100644
--- a/hw/net/allwinner_emac.c
+++ b/hw/net/allwinner_emac.c
@@ -19,6 +19,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "net/net.h"
 #include "qemu/fifo8.h"
 #include "hw/irq.h"
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index f4e4a4dd87..ab6f7e8262 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -27,6 +27,7 @@
=20
 #include "hw/irq.h"
 #include "hw/net/cadence_gem.h"
+#include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/net/can/can_kvaser_pci.c b/hw/net/can/can_kvaser_pci.c
index 3b8e38eb83..10963ef58c 100644
--- a/hw/net/can/can_kvaser_pci.c
+++ b/hw/net/can/can_kvaser_pci.c
@@ -39,6 +39,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
 #include "net/can_emu.h"
=20
 #include "can_sja1000.h"
diff --git a/hw/net/can/can_mioe3680_pci.c b/hw/net/can/can_mioe3680_pci.=
c
index c09ae69261..9e060dff01 100644
--- a/hw/net/can/can_mioe3680_pci.c
+++ b/hw/net/can/can_mioe3680_pci.c
@@ -35,6 +35,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
 #include "net/can_emu.h"
=20
 #include "can_sja1000.h"
diff --git a/hw/net/can/can_pcm3680_pci.c b/hw/net/can/can_pcm3680_pci.c
index 843a76cf37..5d12f0c552 100644
--- a/hw/net/can/can_pcm3680_pci.c
+++ b/hw/net/can/can_pcm3680_pci.c
@@ -35,6 +35,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
 #include "net/can_emu.h"
=20
 #include "can_sja1000.h"
diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index ee079d355f..6c84be6d29 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -30,6 +30,7 @@
 #include "chardev/char.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
 #include "net/can_emu.h"
=20
 #include "can_sja1000.h"
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 70a78ad337..8d0cafc6ba 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "net/net.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index a023ceb27c..e4e91382f0 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
 #include "net/net.h"
 #include "net/checksum.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 581f7d03d5..22e3132581 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -42,6 +42,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
+#include "migration/vmstate.h"
=20
 #include "e1000_regs.h"
=20
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index e0cf0c46d7..3c1c534cbf 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -44,6 +44,7 @@
 #include "qemu/units.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
 #include "net/net.h"
 #include "net/eth.h"
 #include "hw/nvram/eeprom93xx.h"
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 2848bff3e5..4d0f56c123 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -20,6 +20,7 @@
 #include "net/checksum.h"
 #include "net/eth.h"
 #include "hw/net/mii.h"
+#include "migration/vmstate.h"
=20
 /* For crc32 */
 #include <zlib.h>
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index fe9d9028fa..5a22542aaf 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -24,6 +24,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/net/imx_fec.h"
+#include "migration/vmstate.h"
 #include "sysemu/dma.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index e2da54cbd8..937d5603e2 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -12,6 +12,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "net/net.h"
 #include "net/eth.h"
 #include "hw/irq.h"
diff --git a/hw/net/lance.c b/hw/net/lance.c
index 2978c01d58..0d094327cb 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -39,6 +39,7 @@
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/sparc/sparc32_dma.h"
+#include "migration/vmstate.h"
 #include "hw/net/lance.h"
 #include "trace.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/net/milkymist-minimac2.c b/hw/net/milkymist-minimac2.c
index bad1066781..a7d879f0ab 100644
--- a/hw/net/milkymist-minimac2.c
+++ b/hw/net/milkymist-minimac2.c
@@ -28,6 +28,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "trace.h"
 #include "net/net.h"
 #include "qemu/log.h"
diff --git a/hw/net/mipsnet.c b/hw/net/mipsnet.c
index 007c94aa30..3910beb9a6 100644
--- a/hw/net/mipsnet.c
+++ b/hw/net/mipsnet.c
@@ -5,6 +5,7 @@
 #include "qemu/module.h"
 #include "trace.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
=20
 /* MIPSnet register offsets */
=20
diff --git a/hw/net/ne2000-isa.c b/hw/net/ne2000-isa.c
index 3490e54c5a..5195c107d0 100644
--- a/hw/net/ne2000-isa.c
+++ b/hw/net/ne2000-isa.c
@@ -26,6 +26,7 @@
 #include "hw/isa/isa.h"
 #include "hw/net/ne2000-isa.h"
 #include "hw/qdev.h"
+#include "migration/vmstate.h"
 #include "ne2000.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
diff --git a/hw/net/ne2000-pci.c b/hw/net/ne2000-pci.c
index 4f28e31baa..084d92f955 100644
--- a/hw/net/ne2000-pci.c
+++ b/hw/net/ne2000-pci.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
 #include "ne2000.h"
 #include "sysemu/sysemu.h"
=20
diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
index 4b9231c495..7731b5acd1 100644
--- a/hw/net/ne2000.c
+++ b/hw/net/ne2000.c
@@ -26,6 +26,7 @@
 #include "net/eth.h"
 #include "qemu/module.h"
 #include "hw/irq.h"
+#include "migration/vmstate.h"
 #include "ne2000.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index df8cb6621f..a77d2c9368 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -30,6 +30,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
 #include "net/net.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index f73e3422f4..bfcfcf5be3 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -39,6 +39,7 @@
 #include "qemu/log.h"
 #include "hw/irq.h"
 #include "hw/qdev.h"
+#include "migration/vmstate.h"
 #include "net/net.h"
 #include "net/eth.h"
 #include "qemu/timer.h"
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index bd54612f2a..4ce8f62a2a 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
 #include "hw/pci/msix.h"
 #include "net/net.h"
 #include "net/eth.h"
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 09273171e5..9975af44dd 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -55,6 +55,7 @@
=20
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
 #include "sysemu/dma.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index f5149124e6..67e3f2408e 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -9,6 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "net/net.h"
 #include "hw/irq.h"
 #include "hw/net/smc91c111.h"
diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index 1867c355e3..0ce5e37a28 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -33,6 +33,7 @@
 #include "qemu/module.h"
 #include "net/net.h"
 #include "hw/qdev.h"
+#include "migration/vmstate.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index 756ac5600b..154214ca1d 100644
--- a/hw/net/stellaris_enet.c
+++ b/hw/net/stellaris_enet.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "net/net.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/net/sungem.c b/hw/net/sungem.c
index 89bcf749d1..f5e30725be 100644
--- a/hw/net/sungem.c
+++ b/hw/net/sungem.c
@@ -9,6 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "net/net.h"
diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index 8b8603e696..9d8fd70f51 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
 #include "hw/net/mii.h"
 #include "net/net.h"
 #include "qemu/module.h"
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 10d01d0058..88a7c13a96 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -26,6 +26,7 @@
 #include "hw/pci/msix.h"
 #include "hw/pci/msi.h"
 #include "migration/register.h"
+#include "migration/vmstate.h"
=20
 #include "vmxnet3.h"
 #include "vmxnet3_defs.h"
diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
index c2efc77452..ded8b9cf9d 100644
--- a/hw/net/xgmac.c
+++ b/hw/net/xgmac.c
@@ -27,6 +27,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "net/net.h"
diff --git a/hw/nvram/ds1225y.c b/hw/nvram/ds1225y.c
index fd49283f41..9cddb37925 100644
--- a/hw/nvram/ds1225y.c
+++ b/hw/nvram/ds1225y.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/nvram/eeprom93xx.c b/hw/nvram/eeprom93xx.c
index 5fc23df1d4..c2b012d583 100644
--- a/hw/nvram/eeprom93xx.c
+++ b/hw/nvram/eeprom93xx.c
@@ -39,6 +39,7 @@
 #include "hw/hw.h"
 #include "hw/nvram/eeprom93xx.h"
 #include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
=20
 /* Debug EEPROM emulation. */
 //~ #define DEBUG_EEPROM
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 8db0297d59..a5e614016a 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -32,6 +32,7 @@
 #include "hw/nvram/fw_cfg.h"
 #include "hw/sysbus.h"
 #include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
index a60426c469..4f0d2f6bd4 100644
--- a/hw/nvram/mac_nvram.c
+++ b/hw/nvram/mac_nvram.c
@@ -27,6 +27,7 @@
 #include "hw/hw.h"
 #include "hw/nvram/chrp_nvram.h"
 #include "hw/ppc/mac.h"
+#include "migration/vmstate.h"
 #include "qemu/cutils.h"
 #include "qemu/module.h"
 #include <zlib.h>
diff --git a/hw/nvram/nrf51_nvm.c b/hw/nvram/nrf51_nvm.c
index eca0cb35b5..e13ff4b2fe 100644
--- a/hw/nvram/nrf51_nvm.c
+++ b/hw/nvram/nrf51_nvm.c
@@ -24,6 +24,7 @@
 #include "exec/address-spaces.h"
 #include "hw/arm/nrf51.h"
 #include "hw/nvram/nrf51_nvm.h"
+#include "migration/vmstate.h"
=20
 /*
  * FICR Registers Assignments
diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index 09efd886bf..ef22962767 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -32,6 +32,7 @@
 #include "sysemu/block-backend.h"
 #include "sysemu/device_tree.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/nvram/chrp_nvram.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
diff --git a/hw/openrisc/cputimer.c b/hw/openrisc/cputimer.c
index fe95efc41c..e9f89333dc 100644
--- a/hw/openrisc/cputimer.c
+++ b/hw/openrisc/cputimer.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "hw/hw.h"
+#include "migration/vmstate.h"
 #include "qemu/timer.h"
=20
 #define TIMER_PERIOD 50 /* 50 ns period for 20 MHz timer */
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_=
root_port.c
index 44acda7cb9..fb78cf1905 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -15,6 +15,7 @@
 #include "qemu/module.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pcie_port.h"
+#include "migration/vmstate.h"
=20
 #define TYPE_GEN_PCIE_ROOT_PORT                "pcie-root-port"
 #define GEN_PCIE_ROOT_PORT(obj) \
diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
index db77a3541b..2b3907655b 100644
--- a/hw/pci-bridge/i82801b11.c
+++ b/hw/pci-bridge/i82801b11.c
@@ -43,6 +43,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "hw/i386/ich9.h"
=20
diff --git a/hw/pci-bridge/ioh3420.c b/hw/pci-bridge/ioh3420.c
index 310af04af9..f1e16135a3 100644
--- a/hw/pci-bridge/ioh3420.c
+++ b/hw/pci-bridge/ioh3420.c
@@ -25,6 +25,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
=20
 #define PCI_DEVICE_ID_IOH_EPORT         0x3420  /* D0:F0 express mode */
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_d=
ownstream.c
index 182e164f74..1d62e31272 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -24,6 +24,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
+#include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
=20
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_ups=
tream.c
index b8cb31355f..5cd3af4fbc 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -24,6 +24,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
=20
 #define PCI_DEVICE_ID_TI_XIO3130U       0x8232  /* upstream port */
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index ca526bd71b..58870e0d87 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -45,6 +45,7 @@
 #include "hw/irq.h"
 #include "hw/mips/mips.h"
 #include "hw/pci/pci_host.h"
+#include "migration/vmstate.h"
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index de4300d554..083f5bb1a6 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -25,6 +25,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pcie_port.h"
+#include "migration/vmstate.h"
 #include "hw/irq.h"
 #include "hw/pci-host/designware.h"
=20
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index 72c58a054b..1a45c30505 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -34,6 +34,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/pci-host/gpex.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
=20
 /***********************************************************************=
*****
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index ecf634a04d..9e8c8542d3 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -34,6 +34,7 @@
 #include "qemu/range.h"
 #include "hw/xen/xen.h"
 #include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
 #include "hw/pci-host/pam.h"
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 406ebf0438..840869f19c 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -18,6 +18,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/ppc/e500-ccsr.h"
+#include "migration/vmstate.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "qemu/bswap.h"
diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 2b68af9811..34a36812ea 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -31,6 +31,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
+#include "migration/vmstate.h"
 #include "hw/i386/pc.h"
 #include "hw/irq.h"
 #include "hw/loader.h"
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 0a010be4cf..25335a8b71 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -31,6 +31,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci-host/q35.h"
+#include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index 221cc40134..1cd832a393 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -9,6 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index ebe804b473..81a23accf3 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -21,6 +21,7 @@
 #include "hw/pci/pci.h"
 #include "hw/xen/xen.h"
 #include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
 #include "qemu/range.h"
 #include "qapi/error.h"
 #include "trace.h"
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index bc7ce92dcb..de3691eee4 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -31,6 +31,7 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
 #include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index 939da0b778..27f9cc56af 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
 #include "qapi/qmp/qdict.h"
+#include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pcie.h"
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 163a34ee4c..5cc321828e 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -35,6 +35,7 @@
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
 #include "kvm_ppc.h"
+#include "migration/vmstate.h"
 #include "trace.h"
=20
 //#define PPC_DEBUG_IRQ
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index 27f25f4e58..7334d75890 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -24,6 +24,7 @@
 #include "hw/irq.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "sysemu/reset.h"
 #include "hw/pci/pci.h"
diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
index 898ab1533f..d46792d366 100644
--- a/hw/ppc/prep_systemio.c
+++ b/hw/ppc/prep_systemio.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
+#include "migration/vmstate.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h" /* for error_report() */
 #include "qemu/module.h"
diff --git a/hw/ppc/rs6000_mc.c b/hw/ppc/rs6000_mc.c
index 45cb95e08a..daea13cdea 100644
--- a/hw/ppc/rs6000_mc.c
+++ b/hw/ppc/rs6000_mc.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "hw/isa/isa.h"
+#include "migration/vmstate.h"
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
 #include "qapi/error.h"
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index bbb001f84a..7830d66d77 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -32,6 +32,7 @@
 #include "target/ppc/mmu-hash64.h"
 #include "cpu-models.h"
 #include "kvm_ppc.h"
+#include "migration/vmstate.h"
 #include "sysemu/qtest.h"
 #include "sysemu/tcg.h"
=20
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index ccc8970c7c..f86f773d42 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "hw/cpu/core.h"
 #include "hw/ppc/spapr_cpu_core.h"
+#include "migration/vmstate.h"
 #include "target/ppc/cpu.h"
 #include "hw/ppc/spapr.h"
 #include "hw/boards.h"
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 678493a9c5..c09bbcc22d 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -18,6 +18,7 @@
 #include "hw/ppc/spapr_drc.h"
 #include "qom/object.h"
 #include "hw/qdev.h"
+#include "migration/vmstate.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
 #include "hw/ppc/spapr.h" /* for RTAS return codes */
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index bd3d0256a6..57834e6a39 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -25,6 +25,7 @@
 #include "sysemu/kvm.h"
 #include "hw/qdev.h"
 #include "kvm_ppc.h"
+#include "migration/vmstate.h"
 #include "sysemu/dma.h"
 #include "exec/address-spaces.h"
 #include "trace.h"
diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
index a65b7c7da9..811fadf143 100644
--- a/hw/ppc/spapr_ovec.c
+++ b/hw/ppc/spapr_ovec.c
@@ -13,6 +13,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/ppc/spapr_ovec.h"
+#include "migration/vmstate.h"
 #include "qemu/bitmap.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 54d0a32c17..e5f592322f 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -29,6 +29,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
diff --git a/hw/ppc/spapr_rtc.c b/hw/ppc/spapr_rtc.c
index 6cf0113b34..42ff72c269 100644
--- a/hw/ppc/spapr_rtc.c
+++ b/hw/ppc/spapr_rtc.c
@@ -31,6 +31,7 @@
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "hw/ppc/spapr.h"
+#include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-misc-target.h"
 #include "qemu/cutils.h"
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 0f4f4bedd3..1095aa5f00 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -34,6 +34,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/device_tree.h"
 #include "kvm_ppc.h"
+#include "migration/vmstate.h"
 #include "sysemu/qtest.h"
=20
 #include "hw/ppc/spapr.h"
diff --git a/hw/riscv/sifive_gpio.c b/hw/riscv/sifive_gpio.c
index da19daa880..5c7c596e6b 100644
--- a/hw/riscv/sifive_gpio.c
+++ b/hw/riscv/sifive_gpio.c
@@ -15,6 +15,7 @@
 #include "qemu/log.h"
 #include "hw/irq.h"
 #include "hw/riscv/sifive_gpio.h"
+#include "migration/vmstate.h"
 #include "trace.h"
=20
 static void update_output_irq(SIFIVEGPIOState *s)
diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 61f3b74714..056f0711fa 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -21,6 +21,7 @@
 #include "sysemu/sysemu.h"
=20
 #include "hw/s390x/sclp.h"
+#include "migration/vmstate.h"
 #include "hw/s390x/event-facility.h"
=20
 typedef struct SCLPEventsBus {
diff --git a/hw/s390x/sclpquiesce.c b/hw/s390x/sclpquiesce.c
index 4f73471537..6dfb087568 100644
--- a/hw/s390x/sclpquiesce.c
+++ b/hw/s390x/sclpquiesce.c
@@ -16,6 +16,7 @@
 #include "hw/qdev.h"
 #include "sysemu/sysemu.h"
 #include "hw/s390x/sclp.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "hw/s390x/event-facility.h"
=20
diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index f945502f3a..d5a1f9e017 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -28,6 +28,7 @@
 #include "hw/irq.h"
 #include "hw/nvram/eeprom93xx.h"
 #include "hw/scsi/esp.h"
+#include "migration/vmstate.h"
 #include "trace.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 3b717e9526..841d79b60e 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -25,6 +25,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/irq.h"
 #include "hw/scsi/esp.h"
 #include "trace.h"
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 1a042aa00b..175eb79260 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -19,6 +19,7 @@
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
 #include "hw/scsi/scsi.h"
+#include "migration/vmstate.h"
 #include "sysemu/dma.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 0c4399930a..970b10048f 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -33,6 +33,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "mfi.h"
+#include "migration/vmstate.h"
=20
 #define MEGASAS_VERSION_GEN1 "1.70"
 #define MEGASAS_VERSION_GEN2 "1.80"
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 6d2c15a2bc..79501777d4 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -35,6 +35,7 @@
 #include "qapi/error.h"
 #include "mptsas.h"
 #include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
 #include "mpi.h"
=20
 #define NAA_LOCALLY_ASSIGNED_ID 0x3ULL
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 81fe7c3301..42928a6aec 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -6,6 +6,7 @@
 #include "qemu/option.h"
 #include "hw/scsi/scsi.h"
 #include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
 #include "scsi/constants.h"
 #include "hw/qdev.h"
 #include "sysemu/block-backend.h"
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 558fa11511..5fbdecb434 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -26,6 +26,7 @@
 #include "qemu/module.h"
 #include "hw/scsi/scsi.h"
 #include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
 #include "hw/scsi/emulation.h"
 #include "scsi/constants.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 0e491c911d..5290f7569a 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -37,6 +37,7 @@
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/scsi/scsi.h"
+#include "migration/vmstate.h"
 #include "scsi/constants.h"
 #include "srp.h"
 #include "hw/qdev.h"
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 14641df1c8..85af638bc7 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -29,6 +29,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/scsi/scsi.h"
+#include "migration/vmstate.h"
 #include "scsi/constants.h"
 #include "hw/pci/msi.h"
 #include "vmw_pvscsi.h"
diff --git a/hw/sd/bcm2835_sdhost.c b/hw/sd/bcm2835_sdhost.c
index 4609cc031c..4a80fbcc86 100644
--- a/hw/sd/bcm2835_sdhost.c
+++ b/hw/sd/bcm2835_sdhost.c
@@ -17,6 +17,7 @@
 #include "sysemu/blockdev.h"
 #include "hw/irq.h"
 #include "hw/sd/bcm2835_sdhost.h"
+#include "migration/vmstate.h"
 #include "trace.h"
=20
 #define TYPE_BCM2835_SDHOST_BUS "bcm2835-sdhost-bus"
diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index b8d2347d46..dcb7169166 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -26,6 +26,7 @@
 #include "qemu/module.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
 #include "qapi/error.h"
diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 3c615f2b8f..8033fe455d 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/blockdev.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/irq.h"
 #include "hw/sd/sd.h"
 #include "qemu/log.h"
diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 1eb1248cad..020cd5464c 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -15,6 +15,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/arm/pxa.h"
 #include "hw/sd/sd.h"
 #include "hw/qdev.h"
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 21adf2be16..02924329bf 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -38,6 +38,7 @@
 #include "hw/registerfields.h"
 #include "sysemu/block-backend.h"
 #include "hw/sd/sd.h"
+#include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/bitmap.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 46c7fbd677..f9db39c834 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -32,6 +32,7 @@
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
 #include "hw/sd/sdhci.h"
+#include "migration/vmstate.h"
 #include "sdhci-internal.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 9bd6511ec8..571aabea5c 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/blockdev.h"
 #include "hw/ssi/ssi.h"
+#include "migration/vmstate.h"
 #include "hw/sd/sd.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 0f9cda19f3..99b8693a0c 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -32,6 +32,7 @@
 #include "qemu/timer.h"
 #include "hw/sparc/sun4m_iommu.h"
 #include "hw/timer/m48t59.h"
+#include "migration/vmstate.h"
 #include "hw/sparc/sparc32_dma.h"
 #include "hw/block/fdc.h"
 #include "sysemu/reset.h"
diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
index 36b5c0c133..a5681ded6a 100644
--- a/hw/sparc/sun4m_iommu.c
+++ b/hw/sparc/sun4m_iommu.c
@@ -26,6 +26,7 @@
 #include "hw/irq.h"
 #include "hw/sparc/sun4m_iommu.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "exec/address-spaces.h"
 #include "trace.h"
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 5d87be811d..c95ed94d2e 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -21,6 +21,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/error-report.h"
@@ -36,6 +37,7 @@
 #include "hw/char/serial.h"
 #include "hw/char/parallel.h"
 #include "hw/timer/m48t59.h"
+#include "migration/vmstate.h"
 #include "hw/input/i8042.h"
 #include "hw/block/fdc.h"
 #include "net/net.h"
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index eb6eee6586..7ace5780a3 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
index 79c8a6dae7..c918e8cac8 100644
--- a/hw/ssi/imx_spi.c
+++ b/hw/ssi/imx_spi.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/ssi/imx_spi.h"
+#include "migration/vmstate.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/ssi/mss-spi.c b/hw/ssi/mss-spi.c
index d000c91341..3050fabb69 100644
--- a/hw/ssi/mss-spi.c
+++ b/hw/ssi/mss-spi.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/ssi/mss-spi.h"
+#include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/ssi/pl022.c b/hw/ssi/pl022.c
index 286b08438d..cade2e92a8 100644
--- a/hw/ssi/pl022.c
+++ b/hw/ssi/pl022.c
@@ -9,6 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/irq.h"
 #include "hw/ssi/pl022.h"
 #include "hw/ssi/ssi.h"
diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
index cda7c96a64..c6415eb6e3 100644
--- a/hw/ssi/ssi.c
+++ b/hw/ssi/ssi.c
@@ -14,6 +14,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/ssi/ssi.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
=20
 struct SSIBus {
diff --git a/hw/ssi/stm32f2xx_spi.c b/hw/ssi/stm32f2xx_spi.c
index 4249101386..cd6e8443db 100644
--- a/hw/ssi/stm32f2xx_spi.c
+++ b/hw/ssi/stm32f2xx_spi.c
@@ -26,6 +26,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/ssi/stm32f2xx_spi.h"
+#include "migration/vmstate.h"
=20
 #ifndef STM_SPI_ERR_DEBUG
 #define STM_SPI_ERR_DEBUG 0
diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index 5495d3e3cb..081433c2f0 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -26,6 +26,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 451d5a0783..a28cd8f8f0 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -35,6 +35,7 @@
 #include "hw/register.h"
 #include "sysemu/dma.h"
 #include "migration/blocker.h"
+#include "migration/vmstate.h"
=20
 #ifndef XILINX_SPIPS_ERR_DEBUG
 #define XILINX_SPIPS_ERR_DEBUG 0
diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index 0d18497322..b310dfb1b3 100644
--- a/hw/timer/a9gtimer.c
+++ b/hw/timer/a9gtimer.c
@@ -23,6 +23,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/timer/a9gtimer.h"
+#include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index 490e584604..b9d057df5d 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -20,6 +20,7 @@
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
 #include "hw/timer/allwinner-a10-pit.h"
+#include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index 3092b85d91..a13255d308 100644
--- a/hw/timer/arm_mptimer.c
+++ b/hw/timer/arm_mptimer.c
@@ -23,6 +23,7 @@
 #include "hw/irq.h"
 #include "hw/ptimer.h"
 #include "hw/timer/arm_mptimer.h"
+#include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 30ad2245da..0b121252fd 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -9,6 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "hw/qdev.h"
 #include "hw/irq.h"
diff --git a/hw/timer/armv7m_systick.c b/hw/timer/armv7m_systick.c
index 8a91ba345b..85d122dbcb 100644
--- a/hw/timer/armv7m_systick.c
+++ b/hw/timer/armv7m_systick.c
@@ -11,6 +11,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/timer/armv7m_systick.h"
+#include "migration/vmstate.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
diff --git a/hw/timer/aspeed_rtc.c b/hw/timer/aspeed_rtc.c
index 19f061c846..5313017353 100644
--- a/hw/timer/aspeed_rtc.c
+++ b/hw/timer/aspeed_rtc.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "hw/timer/aspeed_rtc.h"
+#include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/timer.h"
=20
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index c8e4892989..ed81d5c44c 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -14,6 +14,7 @@
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "hw/timer/aspeed_timer.h"
+#include "migration/vmstate.h"
 #include "qemu/bitops.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
diff --git a/hw/timer/cadence_ttc.c b/hw/timer/cadence_ttc.c
index 810c08a0ae..5e3128c1e3 100644
--- a/hw/timer/cadence_ttc.c
+++ b/hw/timer/cadence_ttc.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
=20
diff --git a/hw/timer/cmsdk-apb-dualtimer.c b/hw/timer/cmsdk-apb-dualtime=
r.c
index 7328abb40b..6a084a91dd 100644
--- a/hw/timer/cmsdk-apb-dualtimer.c
+++ b/hw/timer/cmsdk-apb-dualtimer.c
@@ -26,6 +26,7 @@
 #include "hw/irq.h"
 #include "hw/registerfields.h"
 #include "hw/timer/cmsdk-apb-dualtimer.h"
+#include "migration/vmstate.h"
=20
 REG32(TIMER1LOAD, 0x0)
 REG32(TIMER1VALUE, 0x4)
diff --git a/hw/timer/cmsdk-apb-timer.c b/hw/timer/cmsdk-apb-timer.c
index 07f82e5fa1..c83e26566a 100644
--- a/hw/timer/cmsdk-apb-timer.c
+++ b/hw/timer/cmsdk-apb-timer.c
@@ -37,6 +37,7 @@
 #include "hw/irq.h"
 #include "hw/registerfields.h"
 #include "hw/timer/cmsdk-apb-timer.h"
+#include "migration/vmstate.h"
=20
 REG32(CTRL, 0)
     FIELD(CTRL, EN, 0, 1)
diff --git a/hw/timer/digic-timer.c b/hw/timer/digic-timer.c
index c818ed1d98..021c4ef714 100644
--- a/hw/timer/digic-timer.c
+++ b/hw/timer/digic-timer.c
@@ -34,6 +34,7 @@
 #include "qemu/log.h"
=20
 #include "hw/timer/digic-timer.h"
+#include "migration/vmstate.h"
=20
 static const VMStateDescription vmstate_digic_timer =3D {
     .name =3D "digic.timer",
diff --git a/hw/timer/ds1338.c b/hw/timer/ds1338.c
index 30d2d21408..588a9ba9be 100644
--- a/hw/timer/ds1338.c
+++ b/hw/timer/ds1338.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "hw/i2c/i2c.h"
+#include "migration/vmstate.h"
 #include "qemu/bcd.h"
 #include "qemu/module.h"
=20
diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index 25e2125af8..7f2af5287c 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -55,6 +55,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/hw/timer/exynos4210_pwm.c b/hw/timer/exynos4210_pwm.c
index 2af7b374cc..b7fad2ad44 100644
--- a/hw/timer/exynos4210_pwm.c
+++ b/hw/timer/exynos4210_pwm.c
@@ -23,6 +23,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/hw/timer/exynos4210_rtc.c b/hw/timer/exynos4210_rtc.c
index b9dfaf51f7..561451059e 100644
--- a/hw/timer/exynos4210_rtc.c
+++ b/hw/timer/exynos4210_rtc.c
@@ -30,6 +30,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "qemu/bcd.h"
 #include "hw/ptimer.h"
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 17838df783..305704a339 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -35,6 +35,7 @@
 #include "hw/timer/hpet.h"
 #include "hw/sysbus.h"
 #include "hw/timer/mc146818rtc.h"
+#include "migration/vmstate.h"
 #include "hw/timer/i8254.h"
=20
 //#define HPET_DEBUG
diff --git a/hw/timer/i8254_common.c b/hw/timer/i8254_common.c
index 3e980f2dee..062e8690c4 100644
--- a/hw/timer/i8254_common.c
+++ b/hw/timer/i8254_common.c
@@ -31,6 +31,7 @@
 #include "hw/timer/i8254.h"
 #include "hw/timer/i8254_internal.h"
 #include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
=20
 /* val must be 0 or 1 */
 void pit_set_gate(ISADevice *dev, int channel, int val)
diff --git a/hw/timer/imx_epit.c b/hw/timer/imx_epit.c
index afeb74339a..f54e059910 100644
--- a/hw/timer/imx_epit.c
+++ b/hw/timer/imx_epit.c
@@ -14,6 +14,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/timer/imx_epit.h"
+#include "migration/vmstate.h"
 #include "hw/irq.h"
 #include "hw/misc/imx_ccm.h"
 #include "qemu/main-loop.h"
diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index b4cfc52019..49a441f451 100644
--- a/hw/timer/imx_gpt.c
+++ b/hw/timer/imx_gpt.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/timer/imx_gpt.h"
+#include "migration/vmstate.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
diff --git a/hw/timer/lm32_timer.c b/hw/timer/lm32_timer.c
index 4beffc1396..bfa9de76ba 100644
--- a/hw/timer/lm32_timer.c
+++ b/hw/timer/lm32_timer.c
@@ -25,6 +25,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "trace.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
index e2479c504a..1240315206 100644
--- a/hw/timer/m48t59.c
+++ b/hw/timer/m48t59.c
@@ -36,6 +36,7 @@
 #include "qemu/module.h"
=20
 #include "m48t59-internal.h"
+#include "migration/vmstate.h"
=20
 #define TYPE_M48TXX_SYS_BUS "sysbus-m48txx"
 #define M48TXX_SYS_BUS_GET_CLASS(obj) \
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 0410cccafa..b432662bc4 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -34,6 +34,7 @@
 #include "sysemu/replay.h"
 #include "sysemu/reset.h"
 #include "hw/timer/mc146818rtc.h"
+#include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc-target.h"
 #include "qapi/qapi-events-misc-target.h"
diff --git a/hw/timer/milkymist-sysctl.c b/hw/timer/milkymist-sysctl.c
index 0f9c39715d..7c56224710 100644
--- a/hw/timer/milkymist-sysctl.c
+++ b/hw/timer/milkymist-sysctl.c
@@ -25,6 +25,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
 #include "qemu/timer.h"
diff --git a/hw/timer/mss-timer.c b/hw/timer/mss-timer.c
index 1be9baf9c0..084e02199d 100644
--- a/hw/timer/mss-timer.c
+++ b/hw/timer/mss-timer.c
@@ -29,6 +29,7 @@
 #include "qemu/log.h"
 #include "hw/irq.h"
 #include "hw/timer/mss-timer.h"
+#include "migration/vmstate.h"
=20
 #ifndef MSS_TIMER_ERR_DEBUG
 #define MSS_TIMER_ERR_DEBUG  0
diff --git a/hw/timer/nrf51_timer.c b/hw/timer/nrf51_timer.c
index 297403c4fd..e04046eb15 100644
--- a/hw/timer/nrf51_timer.c
+++ b/hw/timer/nrf51_timer.c
@@ -17,6 +17,7 @@
 #include "hw/arm/nrf51.h"
 #include "hw/irq.h"
 #include "hw/timer/nrf51_timer.h"
+#include "migration/vmstate.h"
 #include "trace.h"
=20
 #define TIMER_CLK_FREQ 16000000UL
diff --git a/hw/timer/pl031.c b/hw/timer/pl031.c
index 435c4a6c7e..39abd08643 100644
--- a/hw/timer/pl031.c
+++ b/hw/timer/pl031.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "hw/timer/pl031.h"
+#include "migration/vmstate.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index 9c3b2b80ab..f61053b3c6 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -14,6 +14,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/arm/pxa.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index 310a0a126a..931ffd483f 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -27,6 +27,7 @@
 #include "hw/irq.h"
 #include "hw/ptimer.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "trace.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index d7af928667..b41822f047 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/timer/stm32f2xx_timer.h"
+#include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/timer/twl92230.c b/hw/timer/twl92230.c
index 795f894a39..6b2a25b9c9 100644
--- a/hw/timer/twl92230.c
+++ b/hw/timer/twl92230.c
@@ -26,6 +26,7 @@
 #include "hw/i2c/i2c.h"
 #include "hw/irq.h"
 #include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
 #include "sysemu/sysemu.h"
 #include "ui/console.h"
 #include "qemu/bcd.h"
diff --git a/hw/timer/xlnx-zynqmp-rtc.c b/hw/timer/xlnx-zynqmp-rtc.c
index 48c3fba677..5692db98c2 100644
--- a/hw/timer/xlnx-zynqmp-rtc.c
+++ b/hw/timer/xlnx-zynqmp-rtc.c
@@ -37,6 +37,7 @@
 #include "sysemu/sysemu.h"
 #include "trace.h"
 #include "hw/timer/xlnx-zynqmp-rtc.h"
+#include "migration/vmstate.h"
=20
 #ifndef XLNX_ZYNQMP_RTC_ERR_DEBUG
 #define XLNX_ZYNQMP_RTC_ERR_DEBUG 0
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index fc0b512f4f..76c1e16fa1 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -37,6 +37,7 @@
 #include "tpm_util.h"
 #include "tpm_ioctl.h"
 #include "migration/blocker.h"
+#include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/qapi-visit-tpm.h"
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 747e943c42..774d12a5e1 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -30,6 +30,7 @@
=20
 #include "hw/acpi/tpm.h"
 #include "hw/pci/pci_ids.h"
+#include "migration/vmstate.h"
 #include "sysemu/tpm_backend.h"
 #include "tpm_int.h"
 #include "tpm_util.h"
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index a28e9e3b33..6aff15e504 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -6,6 +6,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "sysemu/sysemu.h"
+#include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "trace.h"
 #include "qemu/cutils.h"
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index d1dac6e012..9e42547fc8 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -13,6 +13,7 @@
 #include "qemu/units.h"
 #include <libcacard.h>
 #include "chardev/char-fe.h"
+#include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/sockets.h"
diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index 718ab53cbb..d4074edfc3 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -32,6 +32,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "hw/usb.h"
+#include "migration/vmstate.h"
 #include "desc.h"
 #include "hw/hw.h"
 #include "audio/audio.h"
diff --git a/hw/usb/dev-bluetooth.c b/hw/usb/dev-bluetooth.c
index 670ba32290..f6944fa74f 100644
--- a/hw/usb/dev-bluetooth.c
+++ b/hw/usb/dev-bluetooth.c
@@ -22,6 +22,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/usb.h"
+#include "migration/vmstate.h"
 #include "desc.h"
 #include "sysemu/bt.h"
 #include "hw/bt.h"
diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index 62793eaf26..c7c65a8782 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -27,6 +27,7 @@
 #include "hw/hw.h"
 #include "ui/console.h"
 #include "hw/usb.h"
+#include "migration/vmstate.h"
 #include "desc.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index 89f55dd25c..886423bdec 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -27,6 +27,7 @@
 #include "qemu/timer.h"
 #include "trace.h"
 #include "hw/usb.h"
+#include "migration/vmstate.h"
 #include "desc.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index fd1b3394a5..2e2a47ff7c 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -24,6 +24,7 @@
 #include "qemu/filemonitor.h"
 #include "trace.h"
 #include "hw/usb.h"
+#include "migration/vmstate.h"
 #include "desc.h"
 #include "qemu/units.h"
=20
diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index 889069dd5a..db928d7cdf 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/usb.h"
+#include "migration/vmstate.h"
 #include "desc.h"
 #include "net/net.h"
 #include "qemu/error-report.h"
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index b82f854103..039dc4889f 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -14,6 +14,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/usb.h"
+#include "migration/vmstate.h"
 #include "desc.h"
 #include "chardev/char-serial.h"
 #include "chardev/char-fe.h"
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.=
c
index 8d7e516fe7..57a0cbcae7 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -41,6 +41,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/usb.h"
+#include "migration/vmstate.h"
 #include "desc.h"
=20
 #include "ccid.h"
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 9ffb88ea5b..8bc5d8728a 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -17,6 +17,7 @@
 #include "desc.h"
 #include "hw/scsi/scsi.h"
 #include "ui/console.h"
+#include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/block-backend.h"
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index abd8070d0c..525bc1e590 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -17,6 +17,7 @@
 #include "qemu/module.h"
=20
 #include "hw/usb.h"
+#include "migration/vmstate.h"
 #include "desc.h"
 #include "hw/scsi/scsi.h"
 #include "scsi/constants.h"
diff --git a/hw/usb/dev-wacom.c b/hw/usb/dev-wacom.c
index 8c43db9335..9a8a2d3081 100644
--- a/hw/usb/dev-wacom.c
+++ b/hw/usb/dev-wacom.c
@@ -30,6 +30,7 @@
 #include "hw/hw.h"
 #include "ui/console.h"
 #include "hw/usb.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "desc.h"
=20
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index 03d3a39067..7232dee882 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -17,6 +17,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/usb/hcd-ehci.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "qemu/range.h"
=20
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index cd1f3c70a4..9a509f3b08 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -17,6 +17,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/usb/hcd-ehci.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
=20
 static const VMStateDescription vmstate_ehci_sysbus =3D {
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index d2189fc844..45ff4f4115 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -31,6 +31,7 @@
 #include "hw/irq.h"
 #include "hw/usb/ehci-regs.h"
 #include "hw/usb/hcd-ehci.h"
+#include "migration/vmstate.h"
 #include "trace.h"
 #include "qemu/error-report.h"
=20
diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c
index e8f372c6ad..67fcfc4d7c 100644
--- a/hw/usb/hcd-ohci-pci.c
+++ b/hw/usb/hcd-ohci-pci.c
@@ -23,6 +23,7 @@
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "hw/usb.h"
+#include "migration/vmstate.h"
 #include "hw/pci/pci.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-dma.h"
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 1ced5cd71a..438dfb4b83 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -32,6 +32,7 @@
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/usb.h"
+#include "migration/vmstate.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-dma.h"
 #include "trace.h"
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 98bd5cf49d..887885efa0 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -30,6 +30,7 @@
 #include "hw/hw.h"
 #include "hw/usb.h"
 #include "hw/usb/uhci-regs.h"
+#include "migration/vmstate.h"
 #include "hw/pci/pci.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 5894a18663..fc67476100 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -25,6 +25,7 @@
 #include "qemu/module.h"
 #include "qemu/queue.h"
 #include "hw/usb.h"
+#include "migration/vmstate.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 83ebc51620..6f5338832a 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -40,6 +40,7 @@
 #include <libusb.h>
=20
 #include "qapi/error.h"
+#include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 846e60f3bb..84ec3d5219 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -42,6 +42,7 @@
=20
 #include "hw/usb.h"
 #include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
=20
 /* ERROR is defined below. Remove any previous definition. */
 #undef ERROR
diff --git a/hw/vfio/amd-xgbe.c b/hw/vfio/amd-xgbe.c
index eedd48cfc1..96bd608b8d 100644
--- a/hw/vfio/amd-xgbe.c
+++ b/hw/vfio/amd-xgbe.c
@@ -13,6 +13,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/vfio/vfio-amd-xgbe.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
=20
 static void amd_xgbe_realize(DeviceState *dev, Error **errp)
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index a995b86cd4..d1c86abb76 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -25,6 +25,7 @@
 #include "qemu/config-file.h"
 #include "cpu.h"
 #include "kvm_s390x.h"
+#include "migration/vmstate.h"
 #include "sysemu/sysemu.h"
 #include "hw/s390x/ap-bridge.h"
 #include "exec/address-spaces.h"
diff --git a/hw/vfio/calxeda-xgmac.c b/hw/vfio/calxeda-xgmac.c
index 59233e8d7e..87c382e736 100644
--- a/hw/vfio/calxeda-xgmac.c
+++ b/hw/vfio/calxeda-xgmac.c
@@ -13,6 +13,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/vfio/vfio-calxeda-xgmac.h"
+#include "migration/vmstate.h"
 #include "qemu/module.h"
=20
 static void calxeda_xgmac_realize(DeviceState *dev, Error **errp)
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d7a4e1875c..8a58ad670c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -25,6 +25,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_bridge.h"
+#include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 708df2ec0d..2ec9c9f49b 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -20,6 +20,7 @@
 #include <linux/vfio.h>
=20
 #include "hw/vfio/vfio-platform.h"
+#include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/range.h"
diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-wat=
chdog.c
index a79da39dd5..3140e91959 100644
--- a/hw/watchdog/cmsdk-apb-watchdog.c
+++ b/hw/watchdog/cmsdk-apb-watchdog.c
@@ -31,6 +31,7 @@
 #include "hw/irq.h"
 #include "hw/registerfields.h"
 #include "hw/watchdog/cmsdk-apb-watchdog.h"
+#include "migration/vmstate.h"
=20
 REG32(WDOGLOAD, 0x0)
 REG32(WDOGVALUE, 0x4)
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 57fe24ae6b..49415f132d 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -17,6 +17,7 @@
 #include "hw/misc/aspeed_scu.h"
 #include "hw/sysbus.h"
 #include "hw/watchdog/wdt_aspeed.h"
+#include "migration/vmstate.h"
=20
 #define WDT_STATUS                      (0x00 / 4)
 #define WDT_RELOAD_VALUE                (0x04 / 4)
diff --git a/hw/watchdog/wdt_diag288.c b/hw/watchdog/wdt_diag288.c
index fec046ef09..5b6eb2b09f 100644
--- a/hw/watchdog/wdt_diag288.c
+++ b/hw/watchdog/wdt_diag288.c
@@ -17,6 +17,7 @@
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "hw/watchdog/wdt_diag288.h"
+#include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
index 6780f01add..288be8f73c 100644
--- a/hw/watchdog/wdt_i6300esb.c
+++ b/hw/watchdog/wdt_i6300esb.c
@@ -26,6 +26,7 @@
 #include "sysemu/watchdog.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
=20
 /*#define I6300ESB_DEBUG 1*/
=20
diff --git a/hw/watchdog/wdt_ib700.c b/hw/watchdog/wdt_ib700.c
index e0e5beb99d..e233945c2e 100644
--- a/hw/watchdog/wdt_ib700.c
+++ b/hw/watchdog/wdt_ib700.c
@@ -25,6 +25,7 @@
 #include "sysemu/watchdog.h"
 #include "hw/hw.h"
 #include "hw/isa/isa.h"
+#include "migration/vmstate.h"
=20
 /*#define IB700_DEBUG 1*/
=20
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 0a2cce3c64..83103974ab 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -47,6 +47,7 @@
 #include "bootparam.h"
 #include "xtensa_memory.h"
 #include "hw/xtensa/mx_pic.h"
+#include "migration/vmstate.h"
=20
 typedef struct XtfpgaFlashDesc {
     hwaddr base;
diff --git a/include/hw/acpi/tco.h b/include/hw/acpi/tco.h
index 726f840cce..a1e0da8213 100644
--- a/include/hw/acpi/tco.h
+++ b/include/hw/acpi/tco.h
@@ -11,7 +11,6 @@
 #define HW_ACPI_TCO_H
=20
 #include "exec/memory.h"
-#include "migration/vmstate.h"
=20
 /* As per ICH9 spec, the internal timer has an error of ~0.6s on every t=
ick */
 #define TCO_TICK_NSEC 600000000LL
diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
index 83a75f3170..1acaf7de80 100644
--- a/include/hw/block/flash.h
+++ b/include/hw/block/flash.h
@@ -4,7 +4,6 @@
 /* NOR flash devices */
=20
 #include "exec/memory.h"
-#include "migration/vmstate.h"
=20
 /* pflash_cfi01.c */
=20
diff --git a/include/hw/hw.h b/include/hw/hw.h
index 86ff26b712..e547008b17 100644
--- a/include/hw/hw.h
+++ b/include/hw/hw.h
@@ -8,7 +8,6 @@
=20
 #include "qom/object.h"
 #include "exec/memory.h"
-#include "migration/vmstate.h"
=20
 void QEMU_NORETURN hw_error(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
=20
diff --git a/include/hw/input/hid.h b/include/hw/input/hid.h
index 2127c7ce45..6a9d7bf466 100644
--- a/include/hw/input/hid.h
+++ b/include/hw/input/hid.h
@@ -1,7 +1,6 @@
 #ifndef QEMU_HID_H
 #define QEMU_HID_H
=20
-#include "migration/vmstate.h"
 #include "ui/input.h"
=20
 #define HID_MOUSE     1
diff --git a/include/hw/pci/shpc.h b/include/hw/pci/shpc.h
index bd8204f64e..d5683b7399 100644
--- a/include/hw/pci/shpc.h
+++ b/include/hw/pci/shpc.h
@@ -4,6 +4,7 @@
 #include "exec/memory.h"
 #include "hw/hotplug.h"
 #include "hw/pci/pci.h"
+#include "migration/vmstate.h"
=20
 struct SHPCDevice {
     /* Capability offset in device's config space */
diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
index 5de5ecf5de..7891e9caac 100644
--- a/include/hw/ppc/spapr_ovec.h
+++ b/include/hw/ppc/spapr_ovec.h
@@ -38,7 +38,6 @@
 #define SPAPR_OVEC_H
=20
 #include "cpu.h"
-#include "migration/vmstate.h"
=20
 typedef struct SpaprOptionVector SpaprOptionVector;
=20
diff --git a/include/hw/ptimer.h b/include/hw/ptimer.h
index 2b866902aa..9c77055229 100644
--- a/include/hw/ptimer.h
+++ b/include/hw/ptimer.h
@@ -9,7 +9,6 @@
 #define PTIMER_H
=20
 #include "qemu/timer.h"
-#include "migration/vmstate.h"
=20
 /* The ptimer API implements a simple periodic countdown timer.
  * The countdown timer has a value (which can be read and written via
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index b189788cb2..5da749e2b0 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -18,6 +18,7 @@
 #include "net/net.h"
 #include "hw/qdev.h"
 #include "sysemu/sysemu.h"
+#include "migration/vmstate.h"
 #include "qemu/event_notifier.h"
 #include "standard-headers/linux/virtio_config.h"
 #include "standard-headers/linux/virtio_ring.h"
diff --git a/include/migration/cpu.h b/include/migration/cpu.h
index 2a22470d0d..65abe3c8cc 100644
--- a/include/migration/cpu.h
+++ b/include/migration/cpu.h
@@ -5,6 +5,7 @@
=20
 #include "exec/cpu-defs.h"
 #include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
=20
 #if TARGET_LONG_BITS =3D=3D 64
 #define qemu_put_betl qemu_put_be64
diff --git a/include/net/net.h b/include/net/net.h
index acf0451fc4..e175ba9677 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -4,7 +4,6 @@
 #include "qemu/queue.h"
 #include "qapi/qapi-types-net.h"
 #include "net/queue.h"
-#include "migration/vmstate.h"
=20
 #define MAC_FMT "%02X:%02X:%02X:%02X:%02X:%02X"
 #define MAC_ARG(x) ((uint8_t *)(x))[0], ((uint8_t *)(x))[1], \
diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
index 24b364462d..489c354291 100644
--- a/include/qemu/fifo8.h
+++ b/include/qemu/fifo8.h
@@ -1,7 +1,6 @@
 #ifndef QEMU_FIFO8_H
 #define QEMU_FIFO8_H
=20
-#include "migration/vmstate.h"
=20
 typedef struct {
     /* All fields are private */
diff --git a/migration/savevm.c b/migration/savevm.c
index 79ed44d475..89e8f4c180 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -32,6 +32,7 @@
 #include "net/net.h"
 #include "migration.h"
 #include "migration/snapshot.h"
+#include "migration/vmstate.h"
 #include "migration/misc.h"
 #include "migration/register.h"
 #include "migration/global_state.h"
diff --git a/target/s390x/machine.c b/target/s390x/machine.c
index 1e9526e937..12a2cd65b0 100644
--- a/target/s390x/machine.c
+++ b/target/s390x/machine.c
@@ -19,6 +19,7 @@
 #include "cpu.h"
 #include "internal.h"
 #include "kvm_s390x.h"
+#include "migration/vmstate.h"
 #include "tcg_s390x.h"
 #include "sysemu/kvm.h"
 #include "sysemu/tcg.h"
diff --git a/util/fifo8.c b/util/fifo8.c
index a9aa20a9f7..a5dd789ce5 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -13,6 +13,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "migration/vmstate.h"
 #include "qemu/fifo8.h"
=20
 void fifo8_create(Fifo8 *fifo, uint32_t capacity)
--=20
2.21.0


