Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8F6C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 16:03:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE35120651
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 16:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE35120651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxZGZ-0003Tg-RW
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 12:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52635)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hxZ1k-0005av-4H
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hxZ1Z-0002qN-CV
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:48:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43498)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hxZ1Y-0002q5-T3
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:47:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3DBDB285AE;
 Tue, 13 Aug 2019 15:47:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 29B594AD;
 Tue, 13 Aug 2019 15:47:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BACB61136453; Tue, 13 Aug 2019 17:46:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 13 Aug 2019 17:46:36 +0200
Message-Id: <20190813154653.20568-13-armbru@redhat.com>
In-Reply-To: <20190813154653.20568-1-armbru@redhat.com>
References: <20190813154653.20568-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 13 Aug 2019 15:47:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 12/29] Include hw/irq.h a lot less
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In my "build everything" tree, changing hw/irq.h triggers a recompile
of some 5400 out of 6600 objects (not counting tests and objects that
don't depend on qemu/osdep.h).

hw/hw.h supposedly includes it for convenience.  Several other headers
include it just to get qemu_irq and.or qemu_irq_handler.

Move the qemu_irq and qemu_irq_handler typedefs from hw/irq.h to
qemu/typedefs.h, and then include hw/irq.h only where it's still
needed.  Touching it now recompiles only some 500 objects.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190812052359.30071-13-armbru@redhat.com>
---
 hw/alpha/alpha_sys.h             | 1 -
 hw/hppa/hppa_sys.h               | 1 -
 include/hw/acpi/acpi.h           | 1 -
 include/hw/arm/boot.h            | 1 -
 include/hw/arm/omap.h            | 1 -
 include/hw/arm/soc_dma.h         | 1 -
 include/hw/block/fdc.h           | 1 -
 include/hw/bt.h                  | 1 -
 include/hw/core/split-irq.h      | 1 -
 include/hw/cris/etraxfs_dma.h    | 1 -
 include/hw/display/blizzard.h    | 1 -
 include/hw/display/tc6393xb.h    | 1 -
 include/hw/hw.h                  | 1 -
 include/hw/ide/internal.h        | 1 +
 include/hw/input/gamepad.h       | 1 -
 include/hw/input/tsc2xxx.h       | 1 -
 include/hw/irq.h                 | 4 ----
 include/hw/isa/vt82c686.h        | 1 -
 include/hw/mips/mips.h           | 1 -
 include/hw/misc/cbus.h           | 1 -
 include/hw/net/lan9118.h         | 1 -
 include/hw/net/smc91c111.h       | 1 -
 include/hw/or-irq.h              | 1 -
 include/hw/ppc/spapr_irq.h       | 1 -
 include/hw/qdev-core.h           | 1 -
 include/hw/sh4/sh_intc.h         | 1 -
 include/hw/timer/m48t59.h        | 1 -
 include/hw/tricore/tricore.h     | 1 -
 include/hw/vfio/vfio-platform.h  | 1 -
 include/hw/xen/xen.h             | 1 -
 include/hw/xtensa/mx_pic.h       | 1 -
 include/qemu/typedefs.h          | 9 +++++++++
 include/sysemu/kvm.h             | 1 -
 hw/acpi/core.c                   | 1 +
 hw/acpi/piix4.c                  | 1 +
 hw/alpha/typhoon.c               | 1 +
 hw/arm/armsse.c                  | 1 +
 hw/arm/exynos4210.c              | 1 +
 hw/arm/exynos4_boards.c          | 1 +
 hw/arm/integratorcp.c            | 1 +
 hw/arm/msf2-soc.c                | 1 +
 hw/arm/musicpal.c                | 1 +
 hw/arm/omap1.c                   | 1 +
 hw/arm/omap2.c                   | 1 +
 hw/arm/palm.c                    | 2 ++
 hw/arm/pxa2xx.c                  | 1 +
 hw/arm/pxa2xx_gpio.c             | 1 +
 hw/arm/realview.c                | 1 +
 hw/arm/smmuv3.c                  | 1 +
 hw/arm/spitz.c                   | 1 +
 hw/arm/stellaris.c               | 1 +
 hw/arm/strongarm.c               | 1 +
 hw/arm/tosa.c                    | 1 +
 hw/arm/versatilepb.c             | 1 +
 hw/arm/virt.c                    | 1 +
 hw/arm/z2.c                      | 1 +
 hw/audio/cs4231a.c               | 1 +
 hw/audio/gus.c                   | 1 +
 hw/audio/marvell_88w8618.c       | 1 +
 hw/audio/milkymist-ac97.c        | 1 +
 hw/audio/pl041.c                 | 1 +
 hw/audio/sb16.c                  | 1 +
 hw/block/fdc.c                   | 1 +
 hw/char/bcm2835_aux.c            | 1 +
 hw/char/cadence_uart.c           | 1 +
 hw/char/cmsdk-apb-uart.c         | 1 +
 hw/char/escc.c                   | 1 +
 hw/char/etraxfs_ser.c            | 1 +
 hw/char/exynos4210_uart.c        | 1 +
 hw/char/grlib_apbuart.c          | 1 +
 hw/char/imx_serial.c             | 1 +
 hw/char/ipoctal232.c             | 1 +
 hw/char/lm32_uart.c              | 1 +
 hw/char/mcf_uart.c               | 1 +
 hw/char/milkymist-uart.c         | 1 +
 hw/char/nrf51_uart.c             | 1 +
 hw/char/parallel.c               | 1 +
 hw/char/pl011.c                  | 1 +
 hw/char/serial-pci-multi.c       | 1 +
 hw/char/serial-pci.c             | 1 +
 hw/char/serial.c                 | 1 +
 hw/char/sh_serial.c              | 2 ++
 hw/char/spapr_vty.c              | 1 +
 hw/char/stm32f2xx_usart.c        | 1 +
 hw/char/xilinx_uartlite.c        | 1 +
 hw/core/or-irq.c                 | 1 +
 hw/core/qdev.c                   | 1 +
 hw/core/split-irq.c              | 1 +
 hw/cpu/a15mpcore.c               | 1 +
 hw/cpu/a9mpcore.c                | 1 +
 hw/cpu/arm11mpcore.c             | 1 +
 hw/cpu/realview_mpcore.c         | 1 +
 hw/display/ads7846.c             | 1 +
 hw/display/bcm2835_fb.c          | 1 +
 hw/display/cg3.c                 | 1 +
 hw/display/exynos4210_fimd.c     | 1 +
 hw/display/g364fb.c              | 1 +
 hw/display/milkymist-tmu2.c      | 1 +
 hw/display/omap_dss.c            | 2 ++
 hw/display/omap_lcdc.c           | 2 ++
 hw/display/pl110.c               | 1 +
 hw/display/pxa2xx_lcd.c          | 1 +
 hw/display/tc6393xb.c            | 2 ++
 hw/display/xlnx_dp.c             | 1 +
 hw/dma/bcm2835_dma.c             | 1 +
 hw/dma/etraxfs_dma.c             | 2 ++
 hw/dma/pl080.c                   | 1 +
 hw/dma/pl330.c                   | 1 +
 hw/dma/pxa2xx_dma.c              | 1 +
 hw/dma/rc4030.c                  | 1 +
 hw/dma/sparc32_dma.c             | 1 +
 hw/dma/xilinx_axidma.c           | 1 +
 hw/dma/xlnx-zdma.c               | 1 +
 hw/dma/xlnx-zynq-devcfg.c        | 1 +
 hw/dma/xlnx_dpdma.c              | 1 +
 hw/gpio/bcm2835_gpio.c           | 1 +
 hw/gpio/gpio_key.c               | 1 +
 hw/gpio/imx_gpio.c               | 1 +
 hw/gpio/max7310.c                | 1 +
 hw/gpio/mpc8xxx.c                | 1 +
 hw/gpio/nrf51_gpio.c             | 1 +
 hw/gpio/omap_gpio.c              | 1 +
 hw/gpio/pl061.c                  | 1 +
 hw/gpio/zaurus.c                 | 1 +
 hw/hppa/dino.c                   | 1 +
 hw/i2c/aspeed_i2c.c              | 1 +
 hw/i2c/bitbang_i2c.c             | 1 +
 hw/i2c/exynos4210_i2c.c          | 1 +
 hw/i2c/imx_i2c.c                 | 1 +
 hw/i2c/mpc_i2c.c                 | 1 +
 hw/i2c/omap_i2c.c                | 1 +
 hw/i2c/ppc4xx_i2c.c              | 1 +
 hw/i386/kvm/i8259.c              | 1 +
 hw/i386/kvm/ioapic.c             | 1 +
 hw/i386/pc.c                     | 1 +
 hw/i386/pc_piix.c                | 1 +
 hw/i386/xen/xen-hvm.c            | 1 +
 hw/input/lm832x.c                | 1 +
 hw/input/milkymist-softusb.c     | 1 +
 hw/input/pckbd.c                 | 1 +
 hw/input/pl050.c                 | 1 +
 hw/input/pxa2xx_keypad.c         | 1 +
 hw/input/stellaris_input.c       | 2 ++
 hw/input/tsc2005.c               | 1 +
 hw/input/tsc210x.c               | 1 +
 hw/intc/allwinner-a10-pic.c      | 1 +
 hw/intc/arm_gic.c                | 1 +
 hw/intc/arm_gicv2m.c             | 1 +
 hw/intc/arm_gicv3_cpuif.c        | 1 +
 hw/intc/armv7m_nvic.c            | 1 +
 hw/intc/aspeed_vic.c             | 1 +
 hw/intc/bcm2835_ic.c             | 1 +
 hw/intc/bcm2836_control.c        | 1 +
 hw/intc/etraxfs_pic.c            | 1 +
 hw/intc/exynos4210_combiner.c    | 1 +
 hw/intc/heathrow_pic.c           | 1 +
 hw/intc/i8259.c                  | 2 ++
 hw/intc/imx_avic.c               | 1 +
 hw/intc/lm32_pic.c               | 1 +
 hw/intc/mips_gic.c               | 1 +
 hw/intc/nios2_iic.c              | 1 +
 hw/intc/omap_intc.c              | 1 +
 hw/intc/ompic.c                  | 1 +
 hw/intc/openpic.c                | 1 +
 hw/intc/pl190.c                  | 1 +
 hw/intc/puv3_intc.c              | 1 +
 hw/intc/realview_gic.c           | 1 +
 hw/intc/sh_intc.c                | 1 +
 hw/intc/slavio_intctl.c          | 1 +
 hw/intc/xics.c                   | 1 +
 hw/intc/xilinx_intc.c            | 1 +
 hw/intc/xive.c                   | 1 +
 hw/intc/xlnx-pmu-iomod-intc.c    | 1 +
 hw/intc/xlnx-zynqmp-ipi.c        | 1 +
 hw/ipack/ipack.c                 | 1 +
 hw/ipack/tpci200.c               | 1 +
 hw/ipmi/isa_ipmi_bt.c            | 1 +
 hw/ipmi/isa_ipmi_kcs.c           | 1 +
 hw/isa/i82378.c                  | 1 +
 hw/isa/lpc_ich9.c                | 2 ++
 hw/lm32/lm32_boards.c            | 1 +
 hw/lm32/milkymist.c              | 1 +
 hw/m68k/mcf5206.c                | 2 ++
 hw/m68k/mcf5208.c                | 2 ++
 hw/m68k/mcf_intc.c               | 1 +
 hw/mips/gt64xxx_pci.c            | 1 +
 hw/mips/mips_int.c               | 1 +
 hw/mips/mips_malta.c             | 1 +
 hw/misc/arm_sysctl.c             | 1 +
 hw/misc/armsse-mhu.c             | 1 +
 hw/misc/aspeed_xdma.c            | 1 +
 hw/misc/bcm2835_mbox.c           | 1 +
 hw/misc/bcm2835_property.c       | 1 +
 hw/misc/eccmemctl.c              | 1 +
 hw/misc/iotkit-secctl.c          | 1 +
 hw/misc/macio/mac_dbdma.c        | 1 +
 hw/misc/macio/pmu.c              | 1 +
 hw/misc/max111x.c                | 1 +
 hw/misc/milkymist-pfpu.c         | 1 +
 hw/misc/mos6522.c                | 1 +
 hw/misc/mst_fpga.c               | 1 +
 hw/misc/nrf51_rng.c              | 1 +
 hw/misc/omap_clk.c               | 2 ++
 hw/misc/omap_gpmc.c              | 2 ++
 hw/misc/pc-testdev.c             | 1 +
 hw/misc/slavio_misc.c            | 1 +
 hw/misc/tmp105.c                 | 1 +
 hw/misc/tz-mpc.c                 | 1 +
 hw/misc/tz-msc.c                 | 1 +
 hw/misc/tz-ppc.c                 | 1 +
 hw/misc/zynq-xadc.c              | 1 +
 hw/net/allwinner_emac.c          | 1 +
 hw/net/cadence_gem.c             | 1 +
 hw/net/can/can_kvaser_pci.c      | 1 +
 hw/net/can/can_mioe3680_pci.c    | 1 +
 hw/net/can/can_pcm3680_pci.c     | 1 +
 hw/net/can/can_sja1000.c         | 2 ++
 hw/net/dp8393x.c                 | 1 +
 hw/net/fsl_etsec/etsec.c         | 1 +
 hw/net/ftgmac100.c               | 1 +
 hw/net/imx_fec.c                 | 1 +
 hw/net/lan9118.c                 | 1 +
 hw/net/mcf_fec.c                 | 1 +
 hw/net/milkymist-minimac2.c      | 1 +
 hw/net/mipsnet.c                 | 1 +
 hw/net/ne2000-pci.c              | 2 ++
 hw/net/ne2000.c                  | 1 +
 hw/net/opencores_eth.c           | 1 +
 hw/net/pcnet-pci.c               | 1 +
 hw/net/pcnet.c                   | 1 +
 hw/net/smc91c111.c               | 1 +
 hw/net/spapr_llan.c              | 1 +
 hw/net/stellaris_enet.c          | 1 +
 hw/net/xgmac.c                   | 1 +
 hw/net/xilinx_axienet.c          | 1 +
 hw/net/xilinx_ethlite.c          | 1 +
 hw/nios2/cpu_pic.c               | 1 +
 hw/openrisc/openrisc_sim.c       | 1 +
 hw/openrisc/pic_cpu.c            | 1 +
 hw/pci-host/bonito.c             | 1 +
 hw/pci-host/designware.c         | 1 +
 hw/pci-host/gpex.c               | 1 +
 hw/pci-host/grackle.c            | 1 +
 hw/pci-host/piix.c               | 1 +
 hw/pci-host/ppce500.c            | 1 +
 hw/pci-host/prep.c               | 1 +
 hw/pci-host/sabre.c              | 1 +
 hw/pci-host/uninorth.c           | 1 +
 hw/pci-host/versatile.c          | 1 +
 hw/pci-host/xilinx-pcie.c        | 1 +
 hw/pci/pci.c                     | 1 +
 hw/pcmcia/pxa2xx.c               | 1 +
 hw/ppc/e500.c                    | 1 +
 hw/ppc/pnv_lpc.c                 | 1 +
 hw/ppc/pnv_psi.c                 | 1 +
 hw/ppc/ppc.c                     | 2 ++
 hw/ppc/ppc405_uc.c               | 1 +
 hw/ppc/ppc440_pcix.c             | 1 +
 hw/ppc/ppc440_uc.c               | 1 +
 hw/ppc/ppc4xx_devs.c             | 1 +
 hw/ppc/ppc4xx_pci.c              | 1 +
 hw/ppc/prep.c                    | 1 +
 hw/ppc/prep_systemio.c           | 1 +
 hw/ppc/spapr_events.c            | 2 ++
 hw/ppc/spapr_irq.c               | 1 +
 hw/ppc/spapr_pci.c               | 1 +
 hw/ppc/spapr_vio.c               | 1 +
 hw/riscv/sifive_gpio.c           | 1 +
 hw/riscv/sifive_uart.c           | 1 +
 hw/scsi/esp-pci.c                | 1 +
 hw/scsi/esp.c                    | 1 +
 hw/scsi/lsi53c895a.c             | 1 +
 hw/sd/bcm2835_sdhost.c           | 1 +
 hw/sd/omap_mmc.c                 | 2 ++
 hw/sd/pl181.c                    | 1 +
 hw/sd/pxa2xx_mmci.c              | 1 +
 hw/sd/sd.c                       | 1 +
 hw/sd/sdhci.c                    | 1 +
 hw/sh4/r2d.c                     | 1 +
 hw/sh4/sh7750.c                  | 2 ++
 hw/sh4/sh_pci.c                  | 1 +
 hw/sparc/leon3.c                 | 1 +
 hw/sparc/sun4m.c                 | 1 +
 hw/sparc/sun4m_iommu.c           | 1 +
 hw/ssi/aspeed_smc.c              | 1 +
 hw/ssi/imx_spi.c                 | 1 +
 hw/ssi/mss-spi.c                 | 1 +
 hw/ssi/omap_spi.c                | 2 ++
 hw/ssi/pl022.c                   | 1 +
 hw/ssi/xilinx_spi.c              | 1 +
 hw/ssi/xilinx_spips.c            | 1 +
 hw/timer/a9gtimer.c              | 1 +
 hw/timer/allwinner-a10-pit.c     | 1 +
 hw/timer/altera_timer.c          | 1 +
 hw/timer/arm_mptimer.c           | 1 +
 hw/timer/arm_timer.c             | 1 +
 hw/timer/armv7m_systick.c        | 1 +
 hw/timer/aspeed_timer.c          | 1 +
 hw/timer/cadence_ttc.c           | 1 +
 hw/timer/cmsdk-apb-dualtimer.c   | 1 +
 hw/timer/cmsdk-apb-timer.c       | 1 +
 hw/timer/etraxfs_timer.c         | 1 +
 hw/timer/exynos4210_mct.c        | 1 +
 hw/timer/exynos4210_pwm.c        | 1 +
 hw/timer/exynos4210_rtc.c        | 1 +
 hw/timer/grlib_gptimer.c         | 1 +
 hw/timer/hpet.c                  | 1 +
 hw/timer/i8254.c                 | 1 +
 hw/timer/imx_epit.c              | 1 +
 hw/timer/imx_gpt.c               | 1 +
 hw/timer/lm32_timer.c            | 1 +
 hw/timer/m48t59.c                | 1 +
 hw/timer/mc146818rtc.c           | 1 +
 hw/timer/milkymist-sysctl.c      | 1 +
 hw/timer/mss-timer.c             | 1 +
 hw/timer/nrf51_timer.c           | 1 +
 hw/timer/omap_gptimer.c          | 2 ++
 hw/timer/pl031.c                 | 1 +
 hw/timer/puv3_ost.c              | 1 +
 hw/timer/pxa2xx_timer.c          | 1 +
 hw/timer/sh_timer.c              | 1 +
 hw/timer/slavio_timer.c          | 1 +
 hw/timer/stm32f2xx_timer.c       | 1 +
 hw/timer/twl92230.c              | 1 +
 hw/timer/xilinx_timer.c          | 1 +
 hw/timer/xlnx-zynqmp-rtc.c       | 1 +
 hw/tpm/tpm_tis.c                 | 1 +
 hw/unicore32/puv3.c              | 1 +
 hw/usb/hcd-ehci.c                | 1 +
 hw/usb/hcd-ohci.c                | 1 +
 hw/vfio/platform.c               | 1 +
 hw/virtio/virtio-mmio.c          | 1 +
 hw/watchdog/cmsdk-apb-watchdog.c | 1 +
 hw/xtensa/mx_pic.c               | 1 +
 hw/xtensa/pic_cpu.c              | 1 +
 target/arm/helper.c              | 1 +
 target/arm/kvm.c                 | 1 +
 target/mips/cp0_timer.c          | 1 +
 338 files changed, 336 insertions(+), 34 deletions(-)

diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
index b6d8369ed7..4e127a6de8 100644
--- a/hw/alpha/alpha_sys.h
+++ b/hw/alpha/alpha_sys.h
@@ -8,7 +8,6 @@
 #include "hw/pci/pci_host.h"
 #include "hw/ide.h"
 #include "hw/i386/pc.h"
-#include "hw/irq.h"
=20
=20
 PCIBus *typhoon_init(ram_addr_t, ISABus **, qemu_irq *, AlphaCPU *[4],
diff --git a/hw/hppa/hppa_sys.h b/hw/hppa/hppa_sys.h
index f5f983bf4c..43d25d21fc 100644
--- a/hw/hppa/hppa_sys.h
+++ b/hw/hppa/hppa_sys.h
@@ -7,7 +7,6 @@
 #include "hw/pci/pci_host.h"
 #include "hw/ide.h"
 #include "hw/i386/pc.h"
-#include "hw/irq.h"
=20
 #include "hppa_hardware.h"
=20
diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
index c91e2b9df2..1f2dafbd7d 100644
--- a/include/hw/acpi/acpi.h
+++ b/include/hw/acpi/acpi.h
@@ -22,7 +22,6 @@
=20
 #include "qemu/notify.h"
 #include "exec/memory.h"
-#include "hw/irq.h"
 #include "hw/acpi/acpi_dev_interface.h"
=20
 /*
diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
index c48cc4c2bc..350d4b0498 100644
--- a/include/hw/arm/boot.h
+++ b/include/hw/arm/boot.h
@@ -13,7 +13,6 @@
=20
 #include "exec/memory.h"
 #include "target/arm/cpu-qom.h"
-#include "hw/irq.h"
 #include "qemu/notify.h"
=20
 typedef enum {
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index d21e418242..2fda996648 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -21,7 +21,6 @@
 #define HW_ARM_OMAP_H
=20
 #include "exec/memory.h"
-#include "hw/irq.h"
 #include "hw/input/tsc2xxx.h"
 #include "target/arm/cpu-qom.h"
 #include "qemu/log.h"
diff --git a/include/hw/arm/soc_dma.h b/include/hw/arm/soc_dma.h
index fae322997e..7886291d54 100644
--- a/include/hw/arm/soc_dma.h
+++ b/include/hw/arm/soc_dma.h
@@ -22,7 +22,6 @@
 #define HW_SOC_DMA_H
=20
 #include "exec/memory.h"
-#include "hw/irq.h"
=20
 struct soc_dma_s;
 struct soc_dma_ch_s;
diff --git a/include/hw/block/fdc.h b/include/hw/block/fdc.h
index f4fe2f471b..c15ff4c623 100644
--- a/include/hw/block/fdc.h
+++ b/include/hw/block/fdc.h
@@ -2,7 +2,6 @@
 #define HW_FDC_H
=20
 #include "exec/hwaddr.h"
-#include "hw/irq.h"
 #include "qapi/qapi-types-block.h"
=20
 /* fdc.c */
diff --git a/include/hw/bt.h b/include/hw/bt.h
index b5e11d4d43..d9ee2fc29a 100644
--- a/include/hw/bt.h
+++ b/include/hw/bt.h
@@ -26,7 +26,6 @@
 #ifndef HW_BT_H
 #define HW_BT_H
=20
-#include "hw/irq.h"
=20
 /* BD Address */
 typedef struct {
diff --git a/include/hw/core/split-irq.h b/include/hw/core/split-irq.h
index bb87157c5a..872a39aa4f 100644
--- a/include/hw/core/split-irq.h
+++ b/include/hw/core/split-irq.h
@@ -35,7 +35,6 @@
 #ifndef HW_SPLIT_IRQ_H
 #define HW_SPLIT_IRQ_H
=20
-#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qom/object.h"
=20
diff --git a/include/hw/cris/etraxfs_dma.h b/include/hw/cris/etraxfs_dma.=
h
index 31ae360611..095d76b956 100644
--- a/include/hw/cris/etraxfs_dma.h
+++ b/include/hw/cris/etraxfs_dma.h
@@ -2,7 +2,6 @@
 #define HW_ETRAXFS_DMA_H
=20
 #include "exec/hwaddr.h"
-#include "hw/irq.h"
=20
 struct dma_context_metadata {
 	/* data descriptor md */
diff --git a/include/hw/display/blizzard.h b/include/hw/display/blizzard.=
h
index ef72bbc186..5b33018835 100644
--- a/include/hw/display/blizzard.h
+++ b/include/hw/display/blizzard.h
@@ -11,7 +11,6 @@
 #ifndef HW_DISPLAY_BLIZZARD_H
 #define HW_DISPLAY_BLIZZARD_H
=20
-#include "hw/irq.h"
=20
 void *s1d13745_init(qemu_irq gpio_int);
 void s1d13745_write(void *opaque, int dc, uint16_t value);
diff --git a/include/hw/display/tc6393xb.h b/include/hw/display/tc6393xb.=
h
index 5c4da91f80..c653ef717b 100644
--- a/include/hw/display/tc6393xb.h
+++ b/include/hw/display/tc6393xb.h
@@ -13,7 +13,6 @@
 #define HW_DISPLAY_TC6393XB_H
=20
 #include "exec/memory.h"
-#include "hw/irq.h"
=20
 typedef struct TC6393xbState TC6393xbState;
=20
diff --git a/include/hw/hw.h b/include/hw/hw.h
index b399627cbe..38d2fb1f40 100644
--- a/include/hw/hw.h
+++ b/include/hw/hw.h
@@ -9,7 +9,6 @@
 #include "exec/cpu-common.h"
 #include "qom/object.h"
 #include "exec/memory.h"
-#include "hw/irq.h"
 #include "migration/vmstate.h"
=20
 void QEMU_NORETURN hw_error(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 8efd03132b..c6954c1d56 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -7,6 +7,7 @@
  * non-internal declarations are in hw/ide.h
  */
 #include "hw/ide.h"
+#include "hw/irq.h"
 #include "hw/isa/isa.h"
 #include "sysemu/dma.h"
 #include "sysemu/sysemu.h"
diff --git a/include/hw/input/gamepad.h b/include/hw/input/gamepad.h
index e20211baef..6f6aa2406a 100644
--- a/include/hw/input/gamepad.h
+++ b/include/hw/input/gamepad.h
@@ -11,7 +11,6 @@
 #ifndef HW_INPUT_GAMEPAD_H
 #define HW_INPUT_GAMEPAD_H
=20
-#include "hw/irq.h"
=20
 /* stellaris_input.c */
 void stellaris_gamepad_init(int n, qemu_irq *irq, const int *keycode);
diff --git a/include/hw/input/tsc2xxx.h b/include/hw/input/tsc2xxx.h
index dbfe5c55c1..3cd8f1bf55 100644
--- a/include/hw/input/tsc2xxx.h
+++ b/include/hw/input/tsc2xxx.h
@@ -11,7 +11,6 @@
 #ifndef HW_INPUT_TSC2XXX_H
 #define HW_INPUT_TSC2XXX_H
=20
-#include "hw/irq.h"
 #include "ui/console.h"
=20
 typedef struct uWireSlave {
diff --git a/include/hw/irq.h b/include/hw/irq.h
index 7a40e3ed26..fe527f6f51 100644
--- a/include/hw/irq.h
+++ b/include/hw/irq.h
@@ -5,10 +5,6 @@
=20
 #define TYPE_IRQ "irq"
=20
-typedef struct IRQState *qemu_irq;
-
-typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
-
 void qemu_set_irq(qemu_irq irq, int level);
=20
 static inline void qemu_irq_raise(qemu_irq irq)
diff --git a/include/hw/isa/vt82c686.h b/include/hw/isa/vt82c686.h
index a54c3fe60a..f23f45dfb1 100644
--- a/include/hw/isa/vt82c686.h
+++ b/include/hw/isa/vt82c686.h
@@ -1,7 +1,6 @@
 #ifndef HW_VT82C686_H
 #define HW_VT82C686_H
=20
-#include "hw/irq.h"
=20
 #define TYPE_VT82C686B_SUPERIO "vt82c686b-superio"
=20
diff --git a/include/hw/mips/mips.h b/include/hw/mips/mips.h
index 2f6774d540..0af4c3d5d7 100644
--- a/include/hw/mips/mips.h
+++ b/include/hw/mips/mips.h
@@ -6,7 +6,6 @@
 #define INITRD_PAGE_MASK (~((1 << 16) - 1))
=20
 #include "exec/memory.h"
-#include "hw/irq.h"
=20
 /* gt64xxx.c */
 PCIBus *gt64120_register(qemu_irq *pic);
diff --git a/include/hw/misc/cbus.h b/include/hw/misc/cbus.h
index c899943e03..5334984020 100644
--- a/include/hw/misc/cbus.h
+++ b/include/hw/misc/cbus.h
@@ -13,7 +13,6 @@
 #ifndef HW_MISC_CBUS_H
 #define HW_MISC_CBUS_H
=20
-#include "hw/irq.h"
=20
 typedef struct {
     qemu_irq clk;
diff --git a/include/hw/net/lan9118.h b/include/hw/net/lan9118.h
index 500acb4c14..3d0c67f339 100644
--- a/include/hw/net/lan9118.h
+++ b/include/hw/net/lan9118.h
@@ -11,7 +11,6 @@
 #ifndef HW_NET_LAN9118_H
 #define HW_NET_LAN9118_H
=20
-#include "hw/irq.h"
 #include "net/net.h"
=20
 #define TYPE_LAN9118 "lan9118"
diff --git a/include/hw/net/smc91c111.h b/include/hw/net/smc91c111.h
index a66ba4112f..df5b11dcef 100644
--- a/include/hw/net/smc91c111.h
+++ b/include/hw/net/smc91c111.h
@@ -11,7 +11,6 @@
 #ifndef HW_NET_SMC91C111_H
 #define HW_NET_SMC91C111_H
=20
-#include "hw/irq.h"
 #include "net/net.h"
=20
 void smc91c111_init(NICInfo *, uint32_t, qemu_irq);
diff --git a/include/hw/or-irq.h b/include/hw/or-irq.h
index 5a31e5a188..3a3230dd84 100644
--- a/include/hw/or-irq.h
+++ b/include/hw/or-irq.h
@@ -25,7 +25,6 @@
 #ifndef HW_OR_IRQ_H
 #define HW_OR_IRQ_H
=20
-#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qom/object.h"
=20
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index cd6e18b05e..8132e00366 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -10,7 +10,6 @@
 #ifndef HW_SPAPR_IRQ_H
 #define HW_SPAPR_IRQ_H
=20
-#include "hw/irq.h"
 #include "target/ppc/cpu-qom.h"
=20
 /*
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 136df7774c..b870c8ceeb 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -4,7 +4,6 @@
 #include "qemu/queue.h"
 #include "qemu/bitmap.h"
 #include "qom/object.h"
-#include "hw/irq.h"
 #include "hw/hotplug.h"
 #include "sysemu/sysemu.h"
=20
diff --git a/include/hw/sh4/sh_intc.h b/include/hw/sh4/sh_intc.h
index 3d3efde059..65f3425057 100644
--- a/include/hw/sh4/sh_intc.h
+++ b/include/hw/sh4/sh_intc.h
@@ -2,7 +2,6 @@
 #define SH_INTC_H
=20
 #include "exec/memory.h"
-#include "hw/irq.h"
=20
 typedef unsigned char intc_enum;
=20
diff --git a/include/hw/timer/m48t59.h b/include/hw/timer/m48t59.h
index d3fb50e08c..f74854c026 100644
--- a/include/hw/timer/m48t59.h
+++ b/include/hw/timer/m48t59.h
@@ -2,7 +2,6 @@
 #define HW_M48T59_H
=20
 #include "exec/hwaddr.h"
-#include "hw/irq.h"
 #include "qom/object.h"
=20
 #define TYPE_NVRAM "nvram"
diff --git a/include/hw/tricore/tricore.h b/include/hw/tricore/tricore.h
index 89ef922c67..c19ed3f013 100644
--- a/include/hw/tricore/tricore.h
+++ b/include/hw/tricore/tricore.h
@@ -2,7 +2,6 @@
 #define HW_TRICORE_H
=20
 #include "exec/memory.h"
-#include "hw/irq.h"
=20
 struct tricore_boot_info {
     uint64_t ram_size;
diff --git a/include/hw/vfio/vfio-platform.h b/include/hw/vfio/vfio-platf=
orm.h
index 30d3c28d3b..4ec70c813a 100644
--- a/include/hw/vfio/vfio-platform.h
+++ b/include/hw/vfio/vfio-platform.h
@@ -20,7 +20,6 @@
 #include "hw/vfio/vfio-common.h"
 #include "qemu/event_notifier.h"
 #include "qemu/queue.h"
-#include "hw/irq.h"
=20
 #define TYPE_VFIO_PLATFORM "vfio-platform"
=20
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index 9c7b5f78dc..5ac1c6dc55 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -9,7 +9,6 @@
  */
=20
 #include "exec/cpu-common.h"
-#include "hw/irq.h"
=20
 /* xen-machine.c */
 enum xen_mode {
diff --git a/include/hw/xtensa/mx_pic.h b/include/hw/xtensa/mx_pic.h
index c9ea9e737c..500424c8d3 100644
--- a/include/hw/xtensa/mx_pic.h
+++ b/include/hw/xtensa/mx_pic.h
@@ -29,7 +29,6 @@
 #define XTENSA_MX_PIC_H
=20
 #include "exec/memory.h"
-#include "hw/irq.h"
=20
 struct XtensaMxPic;
 typedef struct XtensaMxPic XtensaMxPic;
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 29346648d4..c32efb5b18 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -102,10 +102,19 @@ typedef struct SSIBus SSIBus;
 typedef struct VirtIODevice VirtIODevice;
 typedef struct Visitor Visitor;
=20
+/*
+ * Pointer types
+ * Such typedefs should be limited to cases where the typedef's users
+ * are oblivious of its "pointer-ness".
+ * Please keep this list in case-insensitive alphabetical order.
+ */
+typedef struct IRQState *qemu_irq;
+
 /*
  * Function types
  */
 typedef void SaveStateHandler(QEMUFile *f, void *opaque);
 typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
+typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
=20
 #endif /* QEMU_TYPEDEFS_H */
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index acd90aebb6..c8ea412f62 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -17,7 +17,6 @@
 #include "qemu/queue.h"
 #include "qom/cpu.h"
 #include "exec/memattrs.h"
-#include "hw/irq.h"
=20
 #ifdef NEED_CPU_H
 # ifdef CONFIG_KVM
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 228828a494..39e9fb1a6c 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/acpi/acpi.h"
 #include "hw/nvram/fw_cfg.h"
 #include "qemu/config-file.h"
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 0d8c821f37..8f9a7ba2ab 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
+#include "hw/irq.h"
 #include "hw/isa/apm.h"
 #include "hw/i2c/pm_smbus.h"
 #include "hw/pci/pci.h"
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 3f34a5153f..6797eb0abe 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -12,6 +12,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "sysemu/sysemu.h"
 #include "alpha_sys.h"
 #include "exec/address-spaces.h"
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index b5c614cc3a..85cfa414eb 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -19,6 +19,7 @@
 #include "hw/registerfields.h"
 #include "hw/arm/armsse.h"
 #include "hw/arm/boot.h"
+#include "hw/irq.h"
=20
 /* Format of the System Information block SYS_CONFIG register */
 typedef enum SysConfigFormat {
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index becd864c19..9aa5ec3f5d 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -26,6 +26,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "hw/cpu/a9mpcore.h"
+#include "hw/irq.h"
 #include "hw/boards.h"
 #include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index ac0b0dc2a9..7624e16084 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -34,6 +34,7 @@
 #include "hw/arm/exynos4210.h"
 #include "hw/net/lan9118.h"
 #include "hw/boards.h"
+#include "hw/irq.h"
=20
 #define SMDK_LAN9118_BASE_ADDR      0x05000000
=20
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 200c0107f0..d6025684f4 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -20,6 +20,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
 #include "hw/char/pl011.h"
+#include "hw/irq.h"
=20
 #define TYPE_INTEGRATOR_CM "integrator_core"
 #define INTEGRATOR_CM(obj) \
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 1ccb644df7..4e5251c92e 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -27,6 +27,7 @@
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
 #include "hw/char/serial.h"
+#include "hw/irq.h"
 #include "hw/boards.h"
 #include "hw/arm/msf2-soc.h"
 #include "hw/misc/unimp.h"
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 95d56f3208..848e49f459 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -23,6 +23,7 @@
 #include "hw/block/flash.h"
 #include "ui/console.h"
 #include "hw/i2c/i2c.h"
+#include "hw/irq.h"
 #include "hw/audio/wm8750.h"
 #include "sysemu/block-backend.h"
 #include "exec/address-spaces.h"
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index beaddaf11f..cce671014b 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -24,6 +24,7 @@
 #include "cpu.h"
 #include "hw/boards.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/omap.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index 7d4cac1f46..397630e2f2 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -26,6 +26,7 @@
 #include "sysemu/reset.h"
 #include "hw/boards.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/omap.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index 9eb9612bce..a5eccb7290 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -16,6 +16,7 @@
  * You should have received a copy of the GNU General Public License alo=
ng
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
@@ -27,6 +28,7 @@
 #include "hw/boards.h"
 #include "hw/arm/boot.h"
 #include "hw/input/tsc2xxx.h"
+#include "hw/irq.h"
 #include "hw/loader.h"
 #include "exec/address-spaces.h"
 #include "cpu.h"
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index e2e43ae6e8..ab3fbd7b64 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -18,6 +18,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/char/serial.h"
 #include "hw/i2c/i2c.h"
+#include "hw/irq.h"
 #include "hw/ssi/ssi.h"
 #include "chardev/char-fe.h"
 #include "sysemu/blockdev.h"
diff --git a/hw/arm/pxa2xx_gpio.c b/hw/arm/pxa2xx_gpio.c
index d1fc9cba67..1b1fc499dc 100644
--- a/hw/arm/pxa2xx_gpio.c
+++ b/hw/arm/pxa2xx_gpio.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "hw/arm/pxa.h"
 #include "qemu/log.h"
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 7c56c8d2ed..b108a9ab26 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -25,6 +25,7 @@
 #include "hw/char/pl011.h"
 #include "hw/cpu/a9mpcore.h"
 #include "hw/intc/realview_gic.h"
+#include "hw/irq.h"
=20
 #define SMP_BOOT_ADDR 0xe0000000
 #define SMP_BOOTREG_ADDR 0x10000030
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index e96d5beb9a..ccca60720e 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -18,6 +18,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/boards.h"
+#include "hw/irq.h"
 #include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-core.h"
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index 723cf5d592..b90431ffea 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -18,6 +18,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/pcmcia.h"
 #include "hw/i2c/i2c.h"
+#include "hw/irq.h"
 #include "hw/ssi/ssi.h"
 #include "hw/block/flash.h"
 #include "qemu/timer.h"
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 499035f5c8..088ae2dbd7 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -22,6 +22,7 @@
 #include "hw/arm/armv7m.h"
 #include "hw/char/pl011.h"
 #include "hw/input/gamepad.h"
+#include "hw/irq.h"
 #include "hw/watchdog/cmsdk-apb-watchdog.h"
 #include "hw/misc/unimp.h"
 #include "cpu.h"
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index fed51a8183..2e016f4b77 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -31,6 +31,7 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/boards.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "strongarm.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index 7843d68d46..80c61aef16 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -21,6 +21,7 @@
 #include "hw/boards.h"
 #include "hw/display/tc6393xb.h"
 #include "hw/i2c/i2c.h"
+#include "hw/irq.h"
 #include "hw/ssi/ssi.h"
 #include "hw/sysbus.h"
 #include "exec/address-spaces.h"
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index e5857117ac..bc922345a6 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -17,6 +17,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/pci/pci.h"
 #include "hw/i2c/i2c.h"
+#include "hw/irq.h"
 #include "hw/boards.h"
 #include "exec/address-spaces.h"
 #include "hw/block/flash.h"
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d9496c9363..0e5152ed3b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -57,6 +57,7 @@
 #include "hw/arm/fdt.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "hw/irq.h"
 #include "kvm_arm.h"
 #include "hw/firmware/smbios.h"
 #include "qapi/visitor.h"
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index 44aa748d39..366d46ff5f 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -16,6 +16,7 @@
 #include "hw/arm/pxa.h"
 #include "hw/arm/boot.h"
 #include "hw/i2c/i2c.h"
+#include "hw/irq.h"
 #include "hw/ssi/ssi.h"
 #include "hw/boards.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 7216b41cc1..9eeab137c7 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -26,6 +26,7 @@
 #include "hw/hw.h"
 #include "hw/audio/soundhw.h"
 #include "audio/audio.h"
+#include "hw/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev.h"
 #include "qemu/module.h"
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index 9ab51631d9..61230147ce 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -28,6 +28,7 @@
 #include "hw/hw.h"
 #include "hw/audio/soundhw.h"
 #include "audio/audio.h"
+#include "hw/irq.h"
 #include "hw/isa/isa.h"
 #include "gusemu.h"
 #include "gustate.h"
diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
index ff1a0d0d8f..167b478ec6 100644
--- a/hw/audio/marvell_88w8618.c
+++ b/hw/audio/marvell_88w8618.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/audio/wm8750.h"
 #include "audio/audio.h"
 #include "qapi/error.h"
diff --git a/hw/audio/milkymist-ac97.c b/hw/audio/milkymist-ac97.c
index bf6a5a6b96..3ba382ee4d 100644
--- a/hw/audio/milkymist-ac97.c
+++ b/hw/audio/milkymist-ac97.c
@@ -23,6 +23,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "trace.h"
 #include "audio/audio.h"
diff --git a/hw/audio/pl041.c b/hw/audio/pl041.c
index 59c6ce1f2e..47f0dfff18 100644
--- a/hw/audio/pl041.c
+++ b/hw/audio/pl041.c
@@ -21,6 +21,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index a2db06a2bb..ba5a5dd022 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -26,6 +26,7 @@
 #include "hw/hw.h"
 #include "hw/audio/soundhw.h"
 #include "audio/audio.h"
+#include "hw/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev.h"
 #include "qemu/timer.h"
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 9b24cb9b85..91d5f56cec 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -33,6 +33,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
+#include "hw/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/sysbus.h"
 #include "hw/block/block.h"
diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 94679d276c..8395c79520 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -22,6 +22,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/char/bcm2835_aux.h"
+#include "hw/irq.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index fa25fe24da..6b9eb140c7 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -29,6 +29,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/char/cadence_uart.h"
+#include "hw/irq.h"
=20
 #ifdef CADENCE_UART_ERR_DEBUG
 #define DB_PRINT(...) do { \
diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
index 606c9cc7d6..dd96a3302e 100644
--- a/hw/char/cmsdk-apb-uart.c
+++ b/hw/char/cmsdk-apb-uart.c
@@ -25,6 +25,7 @@
 #include "chardev/char-fe.h"
 #include "chardev/char-serial.h"
 #include "hw/char/cmsdk-apb-uart.h"
+#include "hw/irq.h"
=20
 REG32(DATA, 0)
 REG32(STATE, 4)
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 8ddbb4be4f..678d494d39 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "hw/char/escc.h"
diff --git a/hw/char/etraxfs_ser.c b/hw/char/etraxfs_ser.c
index 9745bca86c..e93f31c76a 100644
--- a/hw/char/etraxfs_ser.c
+++ b/hw/char/etraxfs_ser.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qemu/log.h"
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index c5700eeaec..dabcd07415 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -28,6 +28,7 @@
 #include "chardev/char-serial.h"
=20
 #include "hw/arm/exynos4210.h"
+#include "hw/irq.h"
=20
 #undef DEBUG_UART
 #undef DEBUG_UART_EXTEND
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index c2bb3ac153..13013e8a1c 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/sparc/grlib.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 0655a9571b..f79e47d4ee 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -20,6 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/char/imx_serial.h"
+#include "hw/irq.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index 5ab731e408..7674e2d7b6 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -10,6 +10,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/ipack/ipack.h"
+#include "hw/irq.h"
 #include "qemu/bitops.h"
 #include "qemu/module.h"
 #include "chardev/char-fe.h"
diff --git a/hw/char/lm32_uart.c b/hw/char/lm32_uart.c
index d047a44e34..377032567a 100644
--- a/hw/char/lm32_uart.c
+++ b/hw/char/lm32_uart.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "trace.h"
 #include "chardev/char-fe.h"
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index 7b06110c4d..c403a1fdc6 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -8,6 +8,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "hw/m68k/mcf.h"
diff --git a/hw/char/milkymist-uart.c b/hw/char/milkymist-uart.c
index 8a78fcca8f..d4641b5f44 100644
--- a/hw/char/milkymist-uart.c
+++ b/hw/char/milkymist-uart.c
@@ -23,6 +23,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "trace.h"
 #include "chardev/char-fe.h"
diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c
index c90b491477..bbe766d3c6 100644
--- a/hw/char/nrf51_uart.c
+++ b/hw/char/nrf51_uart.c
@@ -16,6 +16,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/char/nrf51_uart.h"
+#include "hw/irq.h"
 #include "trace.h"
=20
 static void nrf51_uart_update_irq(NRF51UARTState *s)
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index fed15dc548..ea8ab35e59 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -29,6 +29,7 @@
 #include "hw/hw.h"
 #include "chardev/char-parallel.h"
 #include "chardev/char-fe.h"
+#include "hw/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/char/parallel.h"
 #include "sysemu/reset.h"
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index c1ae2f31f5..a2da375528 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -20,6 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/char/pl011.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qemu/log.h"
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 63dcbaa984..65dbfbd205 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -30,6 +30,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/char/serial.h"
+#include "hw/irq.h"
 #include "hw/pci/pci.h"
=20
 #define PCI_SERIAL_MAX_PORTS 4
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index 9028efbda8..808d32b508 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -29,6 +29,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/char/serial.h"
+#include "hw/irq.h"
 #include "hw/pci/pci.h"
=20
 typedef struct PCISerialState {
diff --git a/hw/char/serial.c b/hw/char/serial.c
index a9e42f7d97..1d977287ea 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -25,6 +25,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/char/serial.h"
+#include "hw/irq.h"
 #include "chardev/char-serial.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 67740b7ee6..7a40aa90af 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -24,8 +24,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/sh4/sh.h"
 #include "chardev/char-fe.h"
 #include "qapi/error.h"
diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index 871d2666f3..f360ab3612 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -5,6 +5,7 @@
 #include "cpu.h"
 #include "hw/qdev.h"
 #include "chardev/char-fe.h"
+#include "hw/irq.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
=20
diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index 40c365b908..f43eb74fb1 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/char/stm32f2xx_usart.h"
+#include "hw/irq.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index 880962a756..250eed945c 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "chardev/char-fe.h"
diff --git a/hw/core/or-irq.c b/hw/core/or-irq.c
index 123a8c644a..6ed34d9238 100644
--- a/hw/core/or-irq.c
+++ b/hw/core/or-irq.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/or-irq.h"
 #include "qemu/module.h"
=20
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 94ebc0a4a1..5c4b67a408 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -35,6 +35,7 @@
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "hw/hotplug.h"
+#include "hw/irq.h"
 #include "hw/boards.h"
 #include "hw/sysbus.h"
=20
diff --git a/hw/core/split-irq.c b/hw/core/split-irq.c
index c606f4a802..6808e812b5 100644
--- a/hw/core/split-irq.c
+++ b/hw/core/split-irq.c
@@ -25,6 +25,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/core/split-irq.h"
+#include "hw/irq.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
=20
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 980f230d75..fc19ed0214 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -22,6 +22,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/cpu/a15mpcore.h"
+#include "hw/irq.h"
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
=20
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 187e4d939e..9dda4d8888 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -12,6 +12,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/cpu/a9mpcore.h"
+#include "hw/irq.h"
 #include "qom/cpu.h"
=20
 static void a9mp_priv_set_irq(void *opaque, int irq, int level)
diff --git a/hw/cpu/arm11mpcore.c b/hw/cpu/arm11mpcore.c
index 2404f93a3e..c611a6ff32 100644
--- a/hw/cpu/arm11mpcore.c
+++ b/hw/cpu/arm11mpcore.c
@@ -12,6 +12,7 @@
 #include "qemu/module.h"
 #include "hw/cpu/arm11mpcore.h"
 #include "hw/intc/realview_gic.h"
+#include "hw/irq.h"
=20
=20
 static void mpcore_priv_set_irq(void *opaque, int irq, int level)
diff --git a/hw/cpu/realview_mpcore.c b/hw/cpu/realview_mpcore.c
index f06294bb5e..34da446d94 100644
--- a/hw/cpu/realview_mpcore.c
+++ b/hw/cpu/realview_mpcore.c
@@ -13,6 +13,7 @@
 #include "qemu/module.h"
 #include "hw/cpu/arm11mpcore.h"
 #include "hw/intc/realview_gic.h"
+#include "hw/irq.h"
=20
 #define TYPE_REALVIEW_MPCORE_RIRQ "realview_mpcore"
 #define REALVIEW_MPCORE_RIRQ(obj) \
diff --git a/hw/display/ads7846.c b/hw/display/ads7846.c
index 1a97e97638..12d8272615 100644
--- a/hw/display/ads7846.c
+++ b/hw/display/ads7846.c
@@ -11,6 +11,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/ssi/ssi.h"
 #include "qemu/module.h"
 #include "ui/console.h"
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index 2311ec75b8..e446355f29 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/display/bcm2835_fb.h"
+#include "hw/irq.h"
 #include "framebuffer.h"
 #include "ui/pixel_ops.h"
 #include "hw/misc/bcm2835_mbox_defs.h"
diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index a7340dc1c2..7cf9ebd604 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -29,6 +29,7 @@
 #include "qemu/error-report.h"
 #include "ui/console.h"
 #include "hw/sysbus.h"
+#include "hw/irq.h"
 #include "hw/loader.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 61f7408b1c..889622eefa 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index 1774b4452e..89248f87df 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "ui/console.h"
diff --git a/hw/display/milkymist-tmu2.c b/hw/display/milkymist-tmu2.c
index e1ed018b8f..3f92378410 100644
--- a/hw/display/milkymist-tmu2.c
+++ b/hw/display/milkymist-tmu2.c
@@ -26,6 +26,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "trace.h"
 #include "qapi/error.h"
diff --git a/hw/display/omap_dss.c b/hw/display/omap_dss.c
index 601f178fdd..637aae8d39 100644
--- a/hw/display/omap_dss.c
+++ b/hw/display/omap_dss.c
@@ -17,8 +17,10 @@
  * You should have received a copy of the GNU General Public License alo=
ng
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "ui/console.h"
 #include "hw/arm/omap.h"
=20
diff --git a/hw/display/omap_lcdc.c b/hw/display/omap_lcdc.c
index 07a5effe04..b00ce04b3b 100644
--- a/hw/display/omap_lcdc.c
+++ b/hw/display/omap_lcdc.c
@@ -16,8 +16,10 @@
  * You should have received a copy of the GNU General Public License alo=
ng
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "ui/console.h"
 #include "hw/arm/omap.h"
 #include "framebuffer.h"
diff --git a/hw/display/pl110.c b/hw/display/pl110.c
index 2bdfc3cc49..8fb510ee73 100644
--- a/hw/display/pl110.c
+++ b/hw/display/pl110.c
@@ -8,6 +8,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "ui/console.h"
 #include "framebuffer.h"
diff --git a/hw/display/pxa2xx_lcd.c b/hw/display/pxa2xx_lcd.c
index b83f80753a..7aca3912f5 100644
--- a/hw/display/pxa2xx_lcd.c
+++ b/hw/display/pxa2xx_lcd.c
@@ -12,6 +12,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "ui/console.h"
 #include "hw/arm/pxa.h"
 #include "ui/pixel_ops.h"
diff --git a/hw/display/tc6393xb.c b/hw/display/tc6393xb.c
index 0b7c59cde7..10e7f74c74 100644
--- a/hw/display/tc6393xb.c
+++ b/hw/display/tc6393xb.c
@@ -10,10 +10,12 @@
  * Contributions after 2012-01-13 are licensed under the terms of the
  * GNU GPL, version 2 or (at your option) any later version.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/host-utils.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/display/tc6393xb.h"
 #include "hw/block/flash.h"
 #include "ui/console.h"
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index cc5b650df0..4daac38070 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -27,6 +27,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/display/xlnx_dp.h"
+#include "hw/irq.h"
=20
 #ifndef DEBUG_DP
 #define DEBUG_DP 0
diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
index a39e8f4968..090c73d951 100644
--- a/hw/dma/bcm2835_dma.c
+++ b/hw/dma/bcm2835_dma.c
@@ -6,6 +6,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/dma/bcm2835_dma.h"
+#include "hw/irq.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/dma/etraxfs_dma.c b/hw/dma/etraxfs_dma.c
index 85783eb847..4285443c81 100644
--- a/hw/dma/etraxfs_dma.c
+++ b/hw/dma/etraxfs_dma.c
@@ -21,8 +21,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "exec/address-spaces.h"
 #include "sysemu/sysemu.h"
=20
diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 7e5762457b..be7f9c71a8 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -13,6 +13,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/dma/pl080.h"
+#include "hw/irq.h"
 #include "qapi/error.h"
=20
 #define PL080_CONF_E    0x1
diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index a56a3e7771..0d772de9f3 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -16,6 +16,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu-common.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
diff --git a/hw/dma/pxa2xx_dma.c b/hw/dma/pxa2xx_dma.c
index d6fb957417..1c273fb309 100644
--- a/hw/dma/pxa2xx_dma.c
+++ b/hw/dma/pxa2xx_dma.c
@@ -10,6 +10,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/arm/pxa.h"
 #include "hw/sysbus.h"
 #include "qapi/error.h"
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index 155af9b26a..f7650f617c 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/mips/mips.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 88765d0c25..a05b6be95c 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -27,6 +27,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/sparc/sparc32_dma.h"
 #include "hw/sparc/sun4m_iommu.h"
 #include "hw/sysbus.h"
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 921be178d9..83b52e4ac7 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -26,6 +26,7 @@
 #include "hw/sysbus.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
+#include "hw/irq.h"
 #include "hw/ptimer.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 51e1ead4fa..5afd77a5b8 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -28,6 +28,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/dma/xlnx-zdma.h"
+#include "hw/irq.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index 7a03ce1b02..855c784758 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -26,6 +26,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/dma/xlnx-zynq-devcfg.h"
+#include "hw/irq.h"
 #include "qemu/bitops.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/dma.h"
diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
index e834f81e17..1bba7f2159 100644
--- a/hw/dma/xlnx_dpdma.c
+++ b/hw/dma/xlnx_dpdma.c
@@ -27,6 +27,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/dma/xlnx_dpdma.h"
+#include "hw/irq.h"
=20
 #ifndef DEBUG_DPDMA
 #define DEBUG_DPDMA 0
diff --git a/hw/gpio/bcm2835_gpio.c b/hw/gpio/bcm2835_gpio.c
index ba8dd6c393..ea3f3f2bda 100644
--- a/hw/gpio/bcm2835_gpio.c
+++ b/hw/gpio/bcm2835_gpio.c
@@ -19,6 +19,7 @@
 #include "hw/sysbus.h"
 #include "hw/sd/sd.h"
 #include "hw/gpio/bcm2835_gpio.h"
+#include "hw/irq.h"
=20
 #define GPFSEL0   0x00
 #define GPFSEL1   0x04
diff --git a/hw/gpio/gpio_key.c b/hw/gpio/gpio_key.c
index 7d5510257e..66866fa87c 100644
--- a/hw/gpio/gpio_key.c
+++ b/hw/gpio/gpio_key.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
diff --git a/hw/gpio/imx_gpio.c b/hw/gpio/imx_gpio.c
index a51af72c1f..3d3c9644db 100644
--- a/hw/gpio/imx_gpio.c
+++ b/hw/gpio/imx_gpio.c
@@ -19,6 +19,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/gpio/imx_gpio.h"
+#include "hw/irq.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/gpio/max7310.c b/hw/gpio/max7310.c
index 273da622ca..b0925ab1a1 100644
--- a/hw/gpio/max7310.c
+++ b/hw/gpio/max7310.c
@@ -9,6 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
+#include "hw/irq.h"
 #include "qemu/module.h"
=20
 #define TYPE_MAX7310 "max7310"
diff --git a/hw/gpio/mpc8xxx.c b/hw/gpio/mpc8xxx.c
index 6ff56dc3f2..f3b90b4b33 100644
--- a/hw/gpio/mpc8xxx.c
+++ b/hw/gpio/mpc8xxx.c
@@ -20,6 +20,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
=20
diff --git a/hw/gpio/nrf51_gpio.c b/hw/gpio/nrf51_gpio.c
index dd6c16a841..24a890911a 100644
--- a/hw/gpio/nrf51_gpio.c
+++ b/hw/gpio/nrf51_gpio.c
@@ -14,6 +14,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/gpio/nrf51_gpio.h"
+#include "hw/irq.h"
 #include "trace.h"
=20
 /*
diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index e2785c5dc7..6ab51a9428 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -20,6 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/arm/omap.h"
 #include "hw/sysbus.h"
 #include "qemu/error-report.h"
diff --git a/hw/gpio/pl061.c b/hw/gpio/pl061.c
index 02c01fd521..c605d91c93 100644
--- a/hw/gpio/pl061.c
+++ b/hw/gpio/pl061.c
@@ -9,6 +9,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/gpio/zaurus.c b/hw/gpio/zaurus.c
index f2f1f67266..98aa416931 100644
--- a/hw/gpio/zaurus.c
+++ b/hw/gpio/zaurus.c
@@ -18,6 +18,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/arm/sharpsl.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index e94614abbd..90da6bcbb9 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -16,6 +16,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "sysemu/sysemu.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 219ad3806f..bb7ef3cbf3 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -23,6 +23,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/i2c/aspeed_i2c.h"
+#include "hw/irq.h"
=20
 /* I2C Global Register */
=20
diff --git a/hw/i2c/bitbang_i2c.c b/hw/i2c/bitbang_i2c.c
index 60c7a9be0b..2289128aaf 100644
--- a/hw/i2c/bitbang_i2c.c
+++ b/hw/i2c/bitbang_i2c.c
@@ -12,6 +12,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/i2c/bitbang_i2c.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
diff --git a/hw/i2c/exynos4210_i2c.c b/hw/i2c/exynos4210_i2c.c
index 70a97a3e2d..07d83d5a63 100644
--- a/hw/i2c/exynos4210_i2c.c
+++ b/hw/i2c/exynos4210_i2c.c
@@ -25,6 +25,7 @@
 #include "qemu/timer.h"
 #include "hw/sysbus.h"
 #include "hw/i2c/i2c.h"
+#include "hw/irq.h"
=20
 #ifndef EXYNOS4_I2C_DEBUG
 #define EXYNOS4_I2C_DEBUG                 0
diff --git a/hw/i2c/imx_i2c.c b/hw/i2c/imx_i2c.c
index ce7a94c282..1d6b695615 100644
--- a/hw/i2c/imx_i2c.c
+++ b/hw/i2c/imx_i2c.c
@@ -20,6 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/i2c/imx_i2c.h"
+#include "hw/irq.h"
 #include "hw/i2c/i2c.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
index e9a1127050..0aa4cacb65 100644
--- a/hw/i2c/mpc_i2c.c
+++ b/hw/i2c/mpc_i2c.c
@@ -19,6 +19,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
+#include "hw/irq.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/sysbus.h"
diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
index d7ebeae8e2..309a37b1fa 100644
--- a/hw/i2c/omap_i2c.c
+++ b/hw/i2c/omap_i2c.c
@@ -22,6 +22,7 @@
 #include "qemu/module.h"
 #include "hw/hw.h"
 #include "hw/i2c/i2c.h"
+#include "hw/irq.h"
 #include "hw/arm/omap.h"
 #include "hw/sysbus.h"
 #include "qemu/error-report.h"
diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
index 462729db4e..d110b417c6 100644
--- a/hw/i2c/ppc4xx_i2c.c
+++ b/hw/i2c/ppc4xx_i2c.c
@@ -30,6 +30,7 @@
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/i2c/ppc4xx_i2c.h"
+#include "hw/irq.h"
=20
 #define PPC4xx_I2C_MEM_SIZE 18
=20
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index bfdeab29be..d0c1b1deac 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -14,6 +14,7 @@
 #include "hw/isa/i8259_internal.h"
 #include "qemu/module.h"
 #include "hw/i386/apic_internal.h"
+#include "hw/irq.h"
 #include "sysemu/kvm.h"
=20
 #define TYPE_KVM_I8259 "kvm-i8259"
diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index e453692199..99ef530967 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
 #include "hw/i386/pc.h"
+#include "hw/irq.h"
 #include "hw/i386/ioapic_internal.h"
 #include "hw/i386/apic_internal.h"
 #include "sysemu/kvm.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 73b55500b0..1453696975 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -46,6 +46,7 @@
 #include "hw/dma/i8257.h"
 #include "hw/timer/i8254.h"
 #include "hw/input/i8042.h"
+#include "hw/irq.h"
 #include "hw/audio/pcspk.h"
 #include "hw/pci/msi.h"
 #include "hw/sysbus.h"
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c2280c72ef..129f47493b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -38,6 +38,7 @@
 #include "net/net.h"
 #include "hw/boards.h"
 #include "hw/ide.h"
+#include "hw/irq.h"
 #include "sysemu/kvm.h"
 #include "hw/kvm/clock.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index e8e79e0917..f769cd91f2 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -14,6 +14,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "hw/i386/pc.h"
+#include "hw/irq.h"
 #include "hw/i386/apic-msidef.h"
 #include "hw/xen/xen_common.h"
 #include "hw/xen/xen-legacy-backend.h"
diff --git a/hw/input/lm832x.c b/hw/input/lm832x.c
index ebb72c6590..2ab6d3290b 100644
--- a/hw/input/lm832x.c
+++ b/hw/input/lm832x.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/i2c/i2c.h"
+#include "hw/irq.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "sysemu/reset.h"
diff --git a/hw/input/milkymist-softusb.c b/hw/input/milkymist-softusb.c
index f779cd4370..92e07fbd8c 100644
--- a/hw/input/milkymist-softusb.c
+++ b/hw/input/milkymist-softusb.c
@@ -28,6 +28,7 @@
 #include "trace.h"
 #include "ui/console.h"
 #include "hw/input/hid.h"
+#include "hw/irq.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
=20
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index 5d06a53362..7e76ee7ad3 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -28,6 +28,7 @@
 #include "hw/isa/isa.h"
 #include "hw/i386/pc.h"
 #include "hw/input/ps2.h"
+#include "hw/irq.h"
 #include "hw/input/i8042.h"
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/input/pl050.c b/hw/input/pl050.c
index b79bf1647d..2318dbfeac 100644
--- a/hw/input/pl050.c
+++ b/hw/input/pl050.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/input/ps2.h"
+#include "hw/irq.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/input/pxa2xx_keypad.c b/hw/input/pxa2xx_keypad.c
index 93db9ed25b..4788c96d19 100644
--- a/hw/input/pxa2xx_keypad.c
+++ b/hw/input/pxa2xx_keypad.c
@@ -13,6 +13,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/arm/pxa.h"
 #include "ui/console.h"
=20
diff --git a/hw/input/stellaris_input.c b/hw/input/stellaris_input.c
index 3a666d61d4..ffea0542ba 100644
--- a/hw/input/stellaris_input.c
+++ b/hw/input/stellaris_input.c
@@ -6,9 +6,11 @@
  *
  * This code is licensed under the GPL.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/input/gamepad.h"
+#include "hw/irq.h"
 #include "ui/console.h"
=20
 typedef struct {
diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index 0a0431744c..e21356c18d 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -25,6 +25,7 @@
 #include "sysemu/reset.h"
 #include "ui/console.h"
 #include "hw/input/tsc2xxx.h"
+#include "hw/irq.h"
 #include "trace.h"
=20
 #define TSC_CUT_RESOLUTION(value, p)	((value) >> (16 - (p ? 12 : 10)))
diff --git a/hw/input/tsc210x.c b/hw/input/tsc210x.c
index d2486f4b4e..be7d948168 100644
--- a/hw/input/tsc210x.c
+++ b/hw/input/tsc210x.c
@@ -27,6 +27,7 @@
 #include "ui/console.h"
 #include "hw/arm/omap.h"            /* For I2SCodec */
 #include "hw/input/tsc2xxx.h"
+#include "hw/irq.h"
=20
 #define TSC_DATA_REGISTERS_PAGE		0x0
 #define TSC_CONTROL_REGISTERS_PAGE	0x1
diff --git a/hw/intc/allwinner-a10-pic.c b/hw/intc/allwinner-a10-pic.c
index 080bdd791f..9df3e18539 100644
--- a/hw/intc/allwinner-a10-pic.c
+++ b/hw/intc/allwinner-a10-pic.c
@@ -19,6 +19,7 @@
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
 #include "hw/intc/allwinner-a10-pic.h"
+#include "hw/irq.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 77427a4188..7af591daac 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -19,6 +19,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "gic_internal.h"
 #include "qapi/error.h"
diff --git a/hw/intc/arm_gicv2m.c b/hw/intc/arm_gicv2m.c
index 05f299fc7f..2c96d4fba0 100644
--- a/hw/intc/arm_gicv2m.c
+++ b/hw/intc/arm_gicv2m.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
+#include "hw/irq.h"
 #include "hw/pci/msi.h"
 #include "sysemu/kvm.h"
 #include "qemu/log.h"
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 3b212d91c8..a254b0ce87 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -17,6 +17,7 @@
 #include "qemu/main-loop.h"
 #include "trace.h"
 #include "gicv3_internal.h"
+#include "hw/irq.h"
 #include "cpu.h"
=20
 void gicv3_set_gicv3state(CPUState *cpu, GICv3CPUState *s)
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 9f8f0d3ff5..69670a2d97 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -16,6 +16,7 @@
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "hw/intc/armv7m_nvic.h"
+#include "hw/irq.h"
 #include "target/arm/cpu.h"
 #include "exec/exec-all.h"
 #include "qemu/log.h"
diff --git a/hw/intc/aspeed_vic.c b/hw/intc/aspeed_vic.c
index 266a309f3b..e17343cd73 100644
--- a/hw/intc/aspeed_vic.c
+++ b/hw/intc/aspeed_vic.c
@@ -29,6 +29,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/intc/aspeed_vic.h"
+#include "hw/irq.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/intc/bcm2835_ic.c b/hw/intc/bcm2835_ic.c
index 61d37643a1..20db52bd8e 100644
--- a/hw/intc/bcm2835_ic.c
+++ b/hw/intc/bcm2835_ic.c
@@ -14,6 +14,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/intc/bcm2835_ic.h"
+#include "hw/irq.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/intc/bcm2836_control.c b/hw/intc/bcm2836_control.c
index 66417c85e4..a983fe565f 100644
--- a/hw/intc/bcm2836_control.c
+++ b/hw/intc/bcm2836_control.c
@@ -17,6 +17,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/intc/bcm2836_control.h"
+#include "hw/irq.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/intc/etraxfs_pic.c b/hw/intc/etraxfs_pic.c
index 20e1391d64..dc72dd5412 100644
--- a/hw/intc/etraxfs_pic.c
+++ b/hw/intc/etraxfs_pic.c
@@ -26,6 +26,7 @@
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 //#include "pc.h"
 //#include "etraxfs.h"
=20
diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.=
c
index 6fed0e8d16..ed558115f6 100644
--- a/hw/intc/exynos4210_combiner.c
+++ b/hw/intc/exynos4210_combiner.c
@@ -32,6 +32,7 @@
 #include "qemu/module.h"
=20
 #include "hw/arm/exynos4210.h"
+#include "hw/irq.h"
=20
 //#define DEBUG_COMBINER
=20
diff --git a/hw/intc/heathrow_pic.c b/hw/intc/heathrow_pic.c
index c282ac4006..ac1f7c0c8f 100644
--- a/hw/intc/heathrow_pic.c
+++ b/hw/intc/heathrow_pic.c
@@ -28,6 +28,7 @@
 #include "hw/ppc/mac.h"
 #include "qemu/module.h"
 #include "hw/intc/heathrow_pic.h"
+#include "hw/irq.h"
 #include "trace.h"
=20
 static inline int heathrow_check_irq(HeathrowPICState *pic)
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 76f3d873b8..e581e6b0ab 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -21,9 +21,11 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
+#include "hw/irq.h"
 #include "hw/isa/isa.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
diff --git a/hw/intc/imx_avic.c b/hw/intc/imx_avic.c
index 83a4101528..022ed05b6f 100644
--- a/hw/intc/imx_avic.c
+++ b/hw/intc/imx_avic.c
@@ -17,6 +17,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/intc/imx_avic.h"
+#include "hw/irq.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/intc/lm32_pic.c b/hw/intc/lm32_pic.c
index 170fa7a1ac..c133d30cf2 100644
--- a/hw/intc/lm32_pic.c
+++ b/hw/intc/lm32_pic.c
@@ -26,6 +26,7 @@
 #include "trace.h"
 #include "hw/lm32/lm32_pic.h"
 #include "hw/intc/intc.h"
+#include "hw/irq.h"
=20
 #define TYPE_LM32_PIC "lm32-pic"
 #define LM32_PIC(obj) OBJECT_CHECK(LM32PicState, (obj), TYPE_LM32_PIC)
diff --git a/hw/intc/mips_gic.c b/hw/intc/mips_gic.c
index e27e333766..166eb6ecce 100644
--- a/hw/intc/mips_gic.c
+++ b/hw/intc/mips_gic.c
@@ -21,6 +21,7 @@
 #include "sysemu/reset.h"
 #include "kvm_mips.h"
 #include "hw/intc/mips_gic.h"
+#include "hw/irq.h"
=20
 static void mips_gic_set_vp_irq(MIPSGICState *gic, int vp, int pin)
 {
diff --git a/hw/intc/nios2_iic.c b/hw/intc/nios2_iic.c
index 7329434b91..3a5d86c2a4 100644
--- a/hw/intc/nios2_iic.c
+++ b/hw/intc/nios2_iic.c
@@ -22,6 +22,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
=20
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "cpu.h"
=20
diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
index 053e67c66b..4b3ddc0a67 100644
--- a/hw/intc/omap_intc.c
+++ b/hw/intc/omap_intc.c
@@ -20,6 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/arm/omap.h"
 #include "hw/sysbus.h"
 #include "qemu/error-report.h"
diff --git a/hw/intc/ompic.c b/hw/intc/ompic.c
index 9cb310a5dd..31004ac613 100644
--- a/hw/intc/ompic.c
+++ b/hw/intc/ompic.c
@@ -11,6 +11,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "exec/memory.h"
=20
diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 9b4fc6cf43..49d64bccfe 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -36,6 +36,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/ppc/mac.h"
 #include "hw/pci/pci.h"
 #include "hw/ppc/openpic.h"
diff --git a/hw/intc/pl190.c b/hw/intc/pl190.c
index b4f31efc45..1a5e760f0f 100644
--- a/hw/intc/pl190.c
+++ b/hw/intc/pl190.c
@@ -8,6 +8,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/intc/puv3_intc.c b/hw/intc/puv3_intc.c
index e2f6d9875a..e018955ce8 100644
--- a/hw/intc/puv3_intc.c
+++ b/hw/intc/puv3_intc.c
@@ -10,6 +10,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
=20
 #undef DEBUG_PUV3
diff --git a/hw/intc/realview_gic.c b/hw/intc/realview_gic.c
index 99557544db..ac22a2abde 100644
--- a/hw/intc/realview_gic.c
+++ b/hw/intc/realview_gic.c
@@ -11,6 +11,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/intc/realview_gic.h"
+#include "hw/irq.h"
=20
 static void realview_gic_set_irq(void *opaque, int irq, int level)
 {
diff --git a/hw/intc/sh_intc.c b/hw/intc/sh_intc.c
index bac7886f25..62521500f9 100644
--- a/hw/intc/sh_intc.c
+++ b/hw/intc/sh_intc.c
@@ -12,6 +12,7 @@
 #include "cpu.h"
 #include "hw/sh4/sh_intc.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/sh4/sh.h"
=20
 //#define DEBUG_INTC
diff --git a/hw/intc/slavio_intctl.c b/hw/intc/slavio_intctl.c
index ca528753bf..e97afcadf6 100644
--- a/hw/intc/slavio_intctl.c
+++ b/hw/intc/slavio_intctl.c
@@ -27,6 +27,7 @@
 #include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "hw/intc/intc.h"
+#include "hw/irq.h"
 #include "trace.h"
=20
 //#define DEBUG_IRQ_COUNT
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 9ed224ce5f..beb37b1a2b 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -37,6 +37,7 @@
 #include "qapi/visitor.h"
 #include "monitor/monitor.h"
 #include "hw/intc/intc.h"
+#include "hw/irq.h"
 #include "sysemu/kvm.h"
 #include "sysemu/reset.h"
=20
diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
index d5363e977f..baf5353cd1 100644
--- a/hw/intc/xilinx_intc.c
+++ b/hw/intc/xilinx_intc.c
@@ -26,6 +26,7 @@
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
=20
 #define D(x)
=20
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index b27d6b8646..d977ed568f 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -17,6 +17,7 @@
 #include "sysemu/reset.h"
 #include "hw/qdev-properties.h"
 #include "monitor/monitor.h"
+#include "hw/irq.h"
 #include "hw/ppc/xive.h"
 #include "hw/ppc/xive_regs.h"
=20
diff --git a/hw/intc/xlnx-pmu-iomod-intc.c b/hw/intc/xlnx-pmu-iomod-intc.=
c
index 0b8ff897dc..9fcd17c6fd 100644
--- a/hw/intc/xlnx-pmu-iomod-intc.c
+++ b/hw/intc/xlnx-pmu-iomod-intc.c
@@ -31,6 +31,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/intc/xlnx-pmu-iomod-intc.h"
+#include "hw/irq.h"
=20
 #ifndef XLNX_PMU_IO_INTC_ERR_DEBUG
 #define XLNX_PMU_IO_INTC_ERR_DEBUG 0
diff --git a/hw/intc/xlnx-zynqmp-ipi.c b/hw/intc/xlnx-zynqmp-ipi.c
index 0dad6c04f5..43a1b789b5 100644
--- a/hw/intc/xlnx-zynqmp-ipi.c
+++ b/hw/intc/xlnx-zynqmp-ipi.c
@@ -32,6 +32,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/intc/xlnx-zynqmp-ipi.h"
+#include "hw/irq.h"
=20
 #ifndef XLNX_ZYNQMP_IPI_ERR_DEBUG
 #define XLNX_ZYNQMP_IPI_ERR_DEBUG 0
diff --git a/hw/ipack/ipack.c b/hw/ipack/ipack.c
index 6b1b72f94d..b8ff979d72 100644
--- a/hw/ipack/ipack.c
+++ b/hw/ipack/ipack.c
@@ -12,6 +12,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/ipack/ipack.h"
+#include "hw/irq.h"
=20
 IPackDevice *ipack_device_find(IPackBus *bus, int32_t slot)
 {
diff --git a/hw/ipack/tpci200.c b/hw/ipack/tpci200.c
index d4d85107d0..7ee9d01771 100644
--- a/hw/ipack/tpci200.c
+++ b/hw/ipack/tpci200.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "hw/ipack/ipack.h"
+#include "hw/irq.h"
 #include "hw/pci/pci.h"
 #include "qemu/bitops.h"
 #include "qemu/module.h"
diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index 1846d5b9a4..af07278c19 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -28,6 +28,7 @@
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/ipmi/ipmi.h"
+#include "hw/irq.h"
 #include "hw/isa/isa.h"
=20
 /* Control register */
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index 068f341256..583497685a 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -28,6 +28,7 @@
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/ipmi/ipmi.h"
+#include "hw/irq.h"
 #include "hw/isa/isa.h"
=20
 #define IPMI_KCS_OBF_BIT        0
diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index c08970b24a..90ebba59b7 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
 #include "hw/i386/pc.h"
+#include "hw/irq.h"
 #include "hw/timer/i8254.h"
 #include "hw/audio/pcspk.h"
=20
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index a7081bd52d..42a1232787 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -27,6 +27,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "hw/hw.h"
@@ -35,6 +36,7 @@
 #include "hw/isa/isa.h"
 #include "hw/sysbus.h"
 #include "hw/i386/pc.h"
+#include "hw/irq.h"
 #include "hw/isa/apm.h"
 #include "hw/i386/ioapic.h"
 #include "hw/pci/pci.h"
diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
index e075ebc8a6..d710980045 100644
--- a/hw/lm32/lm32_boards.c
+++ b/hw/lm32/lm32_boards.c
@@ -23,6 +23,7 @@
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/block/flash.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 33669ee19b..864712d977 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -24,6 +24,7 @@
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/block/flash.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index 1c17f83eed..5ee1498f48 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -5,10 +5,12 @@
  *
  * This code is licensed under the GPL
  */
+
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "cpu.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/m68k/mcf.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 6f6efae9fc..3a21c62809 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -5,6 +5,7 @@
  *
  * This code is licensed under the GPL
  */
+
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/error-report.h"
@@ -12,6 +13,7 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/m68k/mcf.h"
 #include "hw/m68k/mcf_fec.h"
 #include "qemu/timer.h"
diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index a613aed820..d9e03a06ab 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -10,6 +10,7 @@
 #include "qemu/module.h"
 #include "cpu.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "hw/m68k/mcf.h"
=20
diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index 2fa313f498..15d4adb3cd 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -30,6 +30,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "hw/i386/pc.h"
+#include "hw/irq.h"
 #include "exec/address-spaces.h"
 #include "trace.h"
=20
diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
index f899f6ceb3..ae4244c32e 100644
--- a/hw/mips/mips_int.c
+++ b/hw/mips/mips_int.c
@@ -23,6 +23,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/mips/cpudevs.h"
 #include "cpu.h"
 #include "sysemu/kvm.h"
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 29bc8de5cf..02200ab7d4 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -43,6 +43,7 @@
 #include "qemu/log.h"
 #include "hw/mips/bios.h"
 #include "hw/ide.h"
+#include "hw/irq.h"
 #include "hw/loader.h"
 #include "elf.h"
 #include "hw/timer/mc146818rtc.h"
diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index 457dfadfab..be8c9c0a7f 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -9,6 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
 #include "hw/sysbus.h"
diff --git a/hw/misc/armsse-mhu.c b/hw/misc/armsse-mhu.c
index 514321a9ec..f8d4187bb8 100644
--- a/hw/misc/armsse-mhu.c
+++ b/hw/misc/armsse-mhu.c
@@ -23,6 +23,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
+#include "hw/irq.h"
 #include "hw/misc/armsse-mhu.h"
=20
 REG32(CPU0INTR_STAT, 0x0)
diff --git a/hw/misc/aspeed_xdma.c b/hw/misc/aspeed_xdma.c
index eebd4ad540..18a83bcc6c 100644
--- a/hw/misc/aspeed_xdma.c
+++ b/hw/misc/aspeed_xdma.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
+#include "hw/irq.h"
 #include "hw/misc/aspeed_xdma.h"
 #include "qapi/error.h"
=20
diff --git a/hw/misc/bcm2835_mbox.c b/hw/misc/bcm2835_mbox.c
index a87da5ee53..e484d25c29 100644
--- a/hw/misc/bcm2835_mbox.c
+++ b/hw/misc/bcm2835_mbox.c
@@ -10,6 +10,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "hw/irq.h"
 #include "hw/misc/bcm2835_mbox.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 0bf789cf60..51cd93fc8b 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -6,6 +6,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/misc/bcm2835_property.h"
+#include "hw/irq.h"
 #include "hw/misc/bcm2835_mbox_defs.h"
 #include "sysemu/dma.h"
 #include "qemu/log.h"
diff --git a/hw/misc/eccmemctl.c b/hw/misc/eccmemctl.c
index 8386db07df..c16d56c8c7 100644
--- a/hw/misc/eccmemctl.c
+++ b/hw/misc/eccmemctl.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "trace.h"
diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index 58fd94b14f..963fd6efd3 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -16,6 +16,7 @@
 #include "trace.h"
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
+#include "hw/irq.h"
 #include "hw/misc/iotkit-secctl.h"
=20
 /* Registers in the secure privilege control block */
diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
index 548625a5f0..8a1de8c31d 100644
--- a/hw/misc/macio/mac_dbdma.c
+++ b/hw/misc/macio/mac_dbdma.c
@@ -39,6 +39,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/ppc/mac_dbdma.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index 753561d3f1..6280bcbc61 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -33,6 +33,7 @@
 #include "hw/hw.h"
 #include "hw/ppc/mac.h"
 #include "hw/input/adb.h"
+#include "hw/irq.h"
 #include "hw/misc/mos6522.h"
 #include "hw/misc/macio/gpio.h"
 #include "hw/misc/macio/pmu.h"
diff --git a/hw/misc/max111x.c b/hw/misc/max111x.c
index d373ece0c9..6fd7210c67 100644
--- a/hw/misc/max111x.c
+++ b/hw/misc/max111x.c
@@ -11,6 +11,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/ssi/ssi.h"
 #include "qemu/module.h"
=20
diff --git a/hw/misc/milkymist-pfpu.c b/hw/misc/milkymist-pfpu.c
index 1c27f1a4bc..fb21b898d1 100644
--- a/hw/misc/milkymist-pfpu.c
+++ b/hw/misc/milkymist-pfpu.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "trace.h"
 #include "qemu/log.h"
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index e72ed69d51..84c677c131 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -27,6 +27,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/input/adb.h"
+#include "hw/irq.h"
 #include "hw/misc/mos6522.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/misc/mst_fpga.c b/hw/misc/mst_fpga.c
index fd18303724..256746ac15 100644
--- a/hw/misc/mst_fpga.c
+++ b/hw/misc/mst_fpga.c
@@ -13,6 +13,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
=20
diff --git a/hw/misc/nrf51_rng.c b/hw/misc/nrf51_rng.c
index 96ef4330eb..cf1bec223e 100644
--- a/hw/misc/nrf51_rng.c
+++ b/hw/misc/nrf51_rng.c
@@ -14,6 +14,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "hw/arm/nrf51.h"
+#include "hw/irq.h"
 #include "hw/misc/nrf51_rng.h"
 #include "qemu/guest-random.h"
=20
diff --git a/hw/misc/omap_clk.c b/hw/misc/omap_clk.c
index 9ea14186d4..c77ca2fc74 100644
--- a/hw/misc/omap_clk.c
+++ b/hw/misc/omap_clk.c
@@ -18,8 +18,10 @@
  * You should have received a copy of the GNU General Public License alo=
ng
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/arm/omap.h"
=20
 struct clk {
diff --git a/hw/misc/omap_gpmc.c b/hw/misc/omap_gpmc.c
index 84f9e4c612..6253b0b2d4 100644
--- a/hw/misc/omap_gpmc.c
+++ b/hw/misc/omap_gpmc.c
@@ -18,8 +18,10 @@
  * You should have received a copy of the GNU General Public License alo=
ng
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/block/flash.h"
 #include "hw/arm/omap.h"
 #include "exec/memory.h"
diff --git a/hw/misc/pc-testdev.c b/hw/misc/pc-testdev.c
index 1f9abd52b8..46adb6b5fc 100644
--- a/hw/misc/pc-testdev.c
+++ b/hw/misc/pc-testdev.c
@@ -39,6 +39,7 @@
 #include "hw/hw.h"
 #include "hw/qdev.h"
 #include "qemu/module.h"
+#include "hw/irq.h"
 #include "hw/isa/isa.h"
=20
 #define IOMEM_LEN    0x10000
diff --git a/hw/misc/slavio_misc.c b/hw/misc/slavio_misc.c
index 9c2cf04646..5f351950db 100644
--- a/hw/misc/slavio_misc.c
+++ b/hw/misc/slavio_misc.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "trace.h"
diff --git a/hw/misc/tmp105.c b/hw/misc/tmp105.c
index 19def5c20f..2e304218f4 100644
--- a/hw/misc/tmp105.c
+++ b/hw/misc/tmp105.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/i2c/i2c.h"
+#include "hw/irq.h"
 #include "tmp105.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
index 45a3e31c3d..802aeb7377 100644
--- a/hw/misc/tz-mpc.c
+++ b/hw/misc/tz-mpc.c
@@ -16,6 +16,7 @@
 #include "trace.h"
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
+#include "hw/irq.h"
 #include "hw/misc/tz-mpc.h"
=20
 /* Our IOMMU has two IOMMU indexes, one for secure transactions and one =
for
diff --git a/hw/misc/tz-msc.c b/hw/misc/tz-msc.c
index 52b96ba70d..7d1a536ce4 100644
--- a/hw/misc/tz-msc.c
+++ b/hw/misc/tz-msc.c
@@ -16,6 +16,7 @@
 #include "trace.h"
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
+#include "hw/irq.h"
 #include "hw/misc/tz-msc.h"
=20
 static void tz_msc_update_irq(TZMSC *s)
diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
index 2a14a26f29..54db7fc152 100644
--- a/hw/misc/tz-ppc.c
+++ b/hw/misc/tz-ppc.c
@@ -16,6 +16,7 @@
 #include "trace.h"
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
+#include "hw/irq.h"
 #include "hw/misc/tz-ppc.h"
=20
 static void tz_ppc_update_irq(TZPPC *s)
diff --git a/hw/misc/zynq-xadc.c b/hw/misc/zynq-xadc.c
index f1e48601dc..c5cff5a8a9 100644
--- a/hw/misc/zynq-xadc.c
+++ b/hw/misc/zynq-xadc.c
@@ -15,6 +15,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/misc/zynq-xadc.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/net/allwinner_emac.c b/hw/net/allwinner_emac.c
index eecda52800..dad25bd4e9 100644
--- a/hw/net/allwinner_emac.c
+++ b/hw/net/allwinner_emac.c
@@ -21,6 +21,7 @@
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "qemu/fifo8.h"
+#include "hw/irq.h"
 #include "hw/net/allwinner_emac.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index d412085884..f4e4a4dd87 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include <zlib.h> /* For crc32 */
=20
+#include "hw/irq.h"
 #include "hw/net/cadence_gem.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
diff --git a/hw/net/can/can_kvaser_pci.c b/hw/net/can/can_kvaser_pci.c
index df639f8fa0..3b8e38eb83 100644
--- a/hw/net/can/can_kvaser_pci.c
+++ b/hw/net/can/can_kvaser_pci.c
@@ -37,6 +37,7 @@
 #include "qapi/error.h"
 #include "chardev/char.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/pci/pci.h"
 #include "net/can_emu.h"
=20
diff --git a/hw/net/can/can_mioe3680_pci.c b/hw/net/can/can_mioe3680_pci.=
c
index 7af0993d7a..c09ae69261 100644
--- a/hw/net/can/can_mioe3680_pci.c
+++ b/hw/net/can/can_mioe3680_pci.c
@@ -33,6 +33,7 @@
 #include "qapi/error.h"
 #include "chardev/char.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/pci/pci.h"
 #include "net/can_emu.h"
=20
diff --git a/hw/net/can/can_pcm3680_pci.c b/hw/net/can/can_pcm3680_pci.c
index 3f7312af07..843a76cf37 100644
--- a/hw/net/can/can_pcm3680_pci.c
+++ b/hw/net/can/can_pcm3680_pci.c
@@ -33,6 +33,7 @@
 #include "qapi/error.h"
 #include "chardev/char.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/pci/pci.h"
 #include "net/can_emu.h"
=20
diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index 9a85038c8a..ee079d355f 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -24,10 +24,12 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "chardev/char.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "net/can_emu.h"
=20
 #include "can_sja1000.h"
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index bdb0b3b2c2..70a78ad337 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "qapi/error.h"
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index 2a8b99a2e4..e217238296 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -29,6 +29,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
+#include "hw/irq.h"
 #include "hw/ptimer.h"
 #include "etsec.h"
 #include "registers.h"
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index d2cded5e94..2848bff3e5 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -12,6 +12,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/net/ftgmac100.h"
 #include "sysemu/dma.h"
 #include "qemu/log.h"
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 404154ebbf..fe9d9028fa 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -22,6 +22,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/net/imx_fec.h"
 #include "sysemu/dma.h"
 #include "qemu/log.h"
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index f6120be219..e2da54cbd8 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -14,6 +14,7 @@
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "net/eth.h"
+#include "hw/irq.h"
 #include "hw/net/lan9118.h"
 #include "sysemu/sysemu.h"
 #include "hw/ptimer.h"
diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index 78468fad6b..e4a3b55eb6 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -8,6 +8,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "net/net.h"
 #include "qemu/module.h"
 #include "hw/m68k/mcf.h"
diff --git a/hw/net/milkymist-minimac2.c b/hw/net/milkymist-minimac2.c
index 41ef7a4456..bad1066781 100644
--- a/hw/net/milkymist-minimac2.c
+++ b/hw/net/milkymist-minimac2.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "cpu.h" /* FIXME: why does this use TARGET_PAGE_ALIGN? */
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "trace.h"
 #include "net/net.h"
diff --git a/hw/net/mipsnet.c b/hw/net/mipsnet.c
index c5fbd8431f..007c94aa30 100644
--- a/hw/net/mipsnet.c
+++ b/hw/net/mipsnet.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "net/net.h"
 #include "qemu/module.h"
 #include "trace.h"
diff --git a/hw/net/ne2000-pci.c b/hw/net/ne2000-pci.c
index cb05744f3c..4f28e31baa 100644
--- a/hw/net/ne2000-pci.c
+++ b/hw/net/ne2000-pci.c
@@ -21,7 +21,9 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/pci/pci.h"
 #include "ne2000.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
index 1cf4b57341..4b9231c495 100644
--- a/hw/net/ne2000.c
+++ b/hw/net/ne2000.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "net/eth.h"
 #include "qemu/module.h"
+#include "hw/irq.h"
 #include "ne2000.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index a5abb8df46..3e759d79d8 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -33,6 +33,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/net/mii.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index 600d09ce92..df8cb6621f 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -28,6 +28,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/pci/pci.h"
 #include "net/net.h"
 #include "qemu/module.h"
diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index 16683091c9..f73e3422f4 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -37,6 +37,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "hw/irq.h"
 #include "hw/qdev.h"
 #include "net/net.h"
 #include "net/eth.h"
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 4a612eebe9..f5149124e6 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
+#include "hw/irq.h"
 #include "hw/net/smc91c111.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index f162d49025..1867c355e3 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "net/net.h"
diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index 2f645bfb71..756ac5600b 100644
--- a/hw/net/stellaris_enet.c
+++ b/hw/net/stellaris_enet.c
@@ -8,6 +8,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "qemu/log.h"
diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
index f49df95b07..c2efc77452 100644
--- a/hw/net/xgmac.c
+++ b/hw/net/xgmac.c
@@ -25,6 +25,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index feeaca680e..b1247a1d9b 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -30,6 +30,7 @@
 #include "net/net.h"
 #include "net/checksum.h"
=20
+#include "hw/irq.h"
 #include "hw/stream.h"
=20
 #define DPHY(x)
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 8f3a8f8597..27a4fc8d87 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -27,6 +27,7 @@
 #include "cpu.h" /* FIXME should not use tswap* */
 #include "hw/sysbus.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "net/net.h"
=20
 #define D(x)
diff --git a/hw/nios2/cpu_pic.c b/hw/nios2/cpu_pic.c
index 5525e25ff0..1c1989d56a 100644
--- a/hw/nios2/cpu_pic.c
+++ b/hw/nios2/cpu_pic.c
@@ -20,6 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "hw/irq.h"
=20
 #include "qemu/config-file.h"
=20
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index cb2fc5ba78..965d5b44ee 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -23,6 +23,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/boards.h"
 #include "elf.h"
 #include "hw/char/serial.h"
diff --git a/hw/openrisc/pic_cpu.c b/hw/openrisc/pic_cpu.c
index 2f53cfc82e..d3f179ff8d 100644
--- a/hw/openrisc/pic_cpu.c
+++ b/hw/openrisc/pic_cpu.c
@@ -20,6 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "cpu.h"
=20
 /* OpenRISC pic handler */
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 36c7ca45ad..ca526bd71b 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -42,6 +42,7 @@
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "hw/i386/pc.h"
+#include "hw/irq.h"
 #include "hw/mips/mips.h"
 #include "hw/pci/pci_host.h"
 #include "sysemu/reset.h"
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 9ae8c0deb7..de4300d554 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -25,6 +25,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pcie_port.h"
+#include "hw/irq.h"
 #include "hw/pci-host/designware.h"
=20
 #define DESIGNWARE_PCIE_PORT_LINK_CONTROL          0x710
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index 629d1a4624..72c58a054b 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -32,6 +32,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/pci-host/gpex.h"
 #include "qemu/module.h"
=20
diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index ed3b3c361f..912f8bf13f 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -28,6 +28,7 @@
 #include "hw/ppc/mac.h"
 #include "hw/pci/pci.h"
 #include "hw/intc/heathrow_pic.h"
+#include "hw/irq.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "trace.h"
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index e5955457ab..ecf634a04d 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
+#include "hw/irq.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "hw/isa/isa.h"
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 21eaa30a20..406ebf0438 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -16,6 +16,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/ppc/e500-ccsr.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index c564f234af..2b68af9811 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -32,6 +32,7 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
 #include "hw/i386/pc.h"
+#include "hw/irq.h"
 #include "hw/loader.h"
 #include "hw/or-irq.h"
 #include "exec/address-spaces.h"
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index 2cec1116af..772ac1f725 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -30,6 +30,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
+#include "hw/irq.h"
 #include "hw/pci-bridge/simba.h"
 #include "hw/pci-host/sabre.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 680fefd066..4ffb2d0d03 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/ppc/mac.h"
 #include "qemu/module.h"
 #include "hw/pci/pci.h"
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index 791b321ea0..221cc40134 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -9,6 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "hw/irq.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 192b697453..f42fabbbe7 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -22,6 +22,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/pci/pci_bridge.h"
+#include "hw/irq.h"
 #include "hw/pci-host/xilinx-pcie.h"
=20
 enum root_cfg_reg {
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 43a3cac138..bc7ce92dcb 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
diff --git a/hw/pcmcia/pxa2xx.c b/hw/pcmcia/pxa2xx.c
index 8993b784bb..26ab2267de 100644
--- a/hw/pcmcia/pxa2xx.c
+++ b/hw/pcmcia/pxa2xx.c
@@ -12,6 +12,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "hw/pcmcia.h"
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 566f179bb1..0451a4e338 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -45,6 +45,7 @@
 #include "hw/platform-bus.h"
 #include "hw/net/fsl_etsec/etsec.h"
 #include "hw/i2c/i2c.h"
+#include "hw/irq.h"
=20
 #define EPAPR_MAGIC                (0x45504150)
 #define BINARY_DEVICE_TREE_FILE    "mpc8544ds.dtb"
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index a9f150c3ca..d4433d73e1 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -23,6 +23,7 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "hw/irq.h"
 #include "hw/isa/isa.h"
=20
 #include "hw/ppc/pnv.h"
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 6b26d0f6bc..e66aeec4aa 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -19,6 +19,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "target/ppc/cpu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index a9e508c496..163a34ee4c 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -21,9 +21,11 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc_e500.h"
 #include "qemu/timer.h"
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index f9d98fe71e..bb62714fd9 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -30,6 +30,7 @@
 #include "hw/ppc/ppc.h"
 #include "hw/boards.h"
 #include "hw/i2c/ppc4xx_i2c.h"
+#include "hw/irq.h"
 #include "ppc405.h"
 #include "hw/char/serial.h"
 #include "qemu/timer.h"
diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index ca54631f9d..77a78388c1 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -24,6 +24,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
 #include "hw/pci/pci.h"
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 7329cfe651..6570c2d120 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -16,6 +16,7 @@
 #include "qemu/module.h"
 #include "cpu.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
 #include "hw/ppc/ppc.h"
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index e62bef3b8d..49d714756f 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -27,6 +27,7 @@
 #include "sysemu/reset.h"
 #include "cpu.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
 #include "hw/boards.h"
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index b013319c60..27f25f4e58 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -21,6 +21,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
 #include "qemu/module.h"
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 84e968e28c..01dc7e111b 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -39,6 +39,7 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "hw/ide.h"
+#include "hw/irq.h"
 #include "hw/loader.h"
 #include "hw/timer/mc146818rtc.h"
 #include "hw/isa/pc87312.h"
diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
index df7603b986..898ab1533f 100644
--- a/hw/ppc/prep_systemio.c
+++ b/hw/ppc/prep_systemio.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/isa/isa.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h" /* for error_report() */
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index ae0f093f59..d75359c5f3 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -24,6 +24,7 @@
  * THE SOFTWARE.
  *
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
@@ -35,6 +36,7 @@
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
 #include "hw/pci/pci.h"
+#include "hw/irq.h"
 #include "hw/pci-host/spapr.h"
 #include "hw/ppc/spapr_drc.h"
 #include "qemu/help_option.h"
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index d07aed8ca9..66705962e7 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -11,6 +11,7 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "hw/irq.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/spapr_xive.h"
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 9003fe9010..54d0a32c17 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -27,6 +27,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 583c13deda..0f4f4bedd3 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -24,6 +24,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "qemu/log.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
diff --git a/hw/riscv/sifive_gpio.c b/hw/riscv/sifive_gpio.c
index 06bd8112d7..da19daa880 100644
--- a/hw/riscv/sifive_gpio.c
+++ b/hw/riscv/sifive_gpio.c
@@ -13,6 +13,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "hw/irq.h"
 #include "hw/riscv/sifive_gpio.h"
 #include "trace.h"
=20
diff --git a/hw/riscv/sifive_uart.c b/hw/riscv/sifive_uart.c
index 3b3f94f51d..d18613fb33 100644
--- a/hw/riscv/sifive_uart.c
+++ b/hw/riscv/sifive_uart.c
@@ -22,6 +22,7 @@
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
 #include "target/riscv/cpu.h"
+#include "hw/irq.h"
 #include "hw/riscv/sifive_uart.h"
=20
 /*
diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index 342f500f82..f945502f3a 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -25,6 +25,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
+#include "hw/irq.h"
 #include "hw/nvram/eeprom93xx.h"
 #include "hw/scsi/esp.h"
 #include "trace.h"
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 7508d035ca..3b717e9526 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -25,6 +25,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "hw/irq.h"
 #include "hw/scsi/esp.h"
 #include "trace.h"
 #include "qemu/log.h"
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 10468c1ec1..1a042aa00b 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
=20
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/pci/pci.h"
 #include "hw/scsi/scsi.h"
 #include "sysemu/dma.h"
diff --git a/hw/sd/bcm2835_sdhost.c b/hw/sd/bcm2835_sdhost.c
index 2778fb0de4..4609cc031c 100644
--- a/hw/sd/bcm2835_sdhost.c
+++ b/hw/sd/bcm2835_sdhost.c
@@ -15,6 +15,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "sysemu/blockdev.h"
+#include "hw/irq.h"
 #include "hw/sd/bcm2835_sdhost.h"
 #include "trace.h"
=20
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index d0c98ca021..15a0bbe87d 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -18,9 +18,11 @@
  * You should have received a copy of the GNU General Public License alo=
ng
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/arm/omap.h"
 #include "hw/sd/sd.h"
=20
diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 81b406dbf0..3c615f2b8f 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/blockdev.h"
 #include "hw/sysbus.h"
+#include "hw/irq.h"
 #include "hw/sd/sd.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 81ff5cea86..1eb1248cad 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "hw/arm/pxa.h"
 #include "hw/sd/sd.h"
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 917195a65b..21adf2be16 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -34,6 +34,7 @@
 #include "qemu/units.h"
 #include "hw/qdev.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/registerfields.h"
 #include "sysemu/block-backend.h"
 #include "hw/sd/sd.h"
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 7b80b1d93f..46c7fbd677 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -27,6 +27,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "sysemu/dma.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index da79bf0337..9838ea3323 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -37,6 +37,7 @@
 #include "net/net.h"
 #include "sh7750_regs.h"
 #include "hw/ide.h"
+#include "hw/irq.h"
 #include "hw/loader.h"
 #include "hw/usb.h"
 #include "hw/block/flash.h"
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index 2fb6e618d9..b35d07265d 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -22,8 +22,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/sh4/sh.h"
 #include "sysemu/sysemu.h"
 #include "sh7750_regs.h"
diff --git a/hw/sh4/sh_pci.c b/hw/sh4/sh_pci.c
index b15f264e99..71afd23b67 100644
--- a/hw/sh4/sh_pci.c
+++ b/hw/sh4/sh_pci.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/sh4/sh.h"
+#include "hw/irq.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "qemu/bswap.h"
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index c7ddfa2cfe..9c43806690 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -29,6 +29,7 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 93a69c12fb..0f9cda19f3 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -44,6 +44,7 @@
 #include "hw/nvram/fw_cfg.h"
 #include "hw/char/escc.h"
 #include "hw/empty_slot.h"
+#include "hw/irq.h"
 #include "hw/loader.h"
 #include "elf.h"
 #include "trace.h"
diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
index 45a61ecf87..36b5c0c133 100644
--- a/hw/sparc/sun4m_iommu.c
+++ b/hw/sparc/sun4m_iommu.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/sparc/sun4m_iommu.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 81f2fb7f70..eb6eee6586 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -29,6 +29,7 @@
 #include "qemu/module.h"
 #include "qemu/error-report.h"
=20
+#include "hw/irq.h"
 #include "hw/ssi/aspeed_smc.h"
=20
 /* CE Type Setting Register */
diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
index 5cec9b5d05..79c8a6dae7 100644
--- a/hw/ssi/imx_spi.c
+++ b/hw/ssi/imx_spi.c
@@ -9,6 +9,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/ssi/imx_spi.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
diff --git a/hw/ssi/mss-spi.c b/hw/ssi/mss-spi.c
index 4c9da5d2b2..d000c91341 100644
--- a/hw/ssi/mss-spi.c
+++ b/hw/ssi/mss-spi.c
@@ -24,6 +24,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/ssi/mss-spi.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/ssi/omap_spi.c b/hw/ssi/omap_spi.c
index f278a55160..7c7e689707 100644
--- a/hw/ssi/omap_spi.c
+++ b/hw/ssi/omap_spi.c
@@ -19,9 +19,11 @@
  * with this program; if not, write to the Free Software Foundation, Inc=
.,
  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/arm/omap.h"
=20
 /* Multichannel SPI */
diff --git a/hw/ssi/pl022.c b/hw/ssi/pl022.c
index fec73cae26..286b08438d 100644
--- a/hw/ssi/pl022.c
+++ b/hw/ssi/pl022.c
@@ -9,6 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "hw/irq.h"
 #include "hw/ssi/pl022.h"
 #include "hw/ssi/ssi.h"
 #include "qemu/log.h"
diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index 1379cb164b..5495d3e3cb 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -31,6 +31,7 @@
 #include "qemu/module.h"
 #include "qemu/fifo8.h"
=20
+#include "hw/irq.h"
 #include "hw/ssi/ssi.h"
=20
 #ifdef XILINX_SPI_ERR_DEBUG
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index b29e0a4a89..451d5a0783 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
+#include "hw/irq.h"
 #include "hw/ptimer.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index 09e2a7b7bf..0d18497322 100644
--- a/hw/timer/a9gtimer.c
+++ b/hw/timer/a9gtimer.c
@@ -21,6 +21,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/timer/a9gtimer.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index 763e1090ec..490e584604 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -16,6 +16,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
 #include "hw/timer/allwinner-a10-pit.h"
diff --git a/hw/timer/altera_timer.c b/hw/timer/altera_timer.c
index 5c1d9e4074..0dd4f321f7 100644
--- a/hw/timer/altera_timer.c
+++ b/hw/timer/altera_timer.c
@@ -24,6 +24,7 @@
=20
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
+#include "hw/irq.h"
 #include "hw/ptimer.h"
=20
 #define R_STATUS      0
diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index 93044aacfd..3092b85d91 100644
--- a/hw/timer/arm_mptimer.c
+++ b/hw/timer/arm_mptimer.c
@@ -20,6 +20,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/ptimer.h"
 #include "hw/timer/arm_mptimer.h"
 #include "qapi/error.h"
diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index f0a753404d..30ad2245da 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -11,6 +11,7 @@
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "hw/qdev.h"
+#include "hw/irq.h"
 #include "hw/ptimer.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/hw/timer/armv7m_systick.c b/hw/timer/armv7m_systick.c
index 94640743b5..8a91ba345b 100644
--- a/hw/timer/armv7m_systick.c
+++ b/hw/timer/armv7m_systick.c
@@ -11,6 +11,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/timer/armv7m_systick.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 29cc5e8070..c8e4892989 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -11,6 +11,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "hw/timer/aspeed_timer.h"
 #include "qemu/bitops.h"
diff --git a/hw/timer/cadence_ttc.c b/hw/timer/cadence_ttc.c
index 115d935f84..810c08a0ae 100644
--- a/hw/timer/cadence_ttc.c
+++ b/hw/timer/cadence_ttc.c
@@ -17,6 +17,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
diff --git a/hw/timer/cmsdk-apb-dualtimer.c b/hw/timer/cmsdk-apb-dualtime=
r.c
index 383f6e12b1..7328abb40b 100644
--- a/hw/timer/cmsdk-apb-dualtimer.c
+++ b/hw/timer/cmsdk-apb-dualtimer.c
@@ -23,6 +23,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "hw/sysbus.h"
+#include "hw/irq.h"
 #include "hw/registerfields.h"
 #include "hw/timer/cmsdk-apb-dualtimer.h"
=20
diff --git a/hw/timer/cmsdk-apb-timer.c b/hw/timer/cmsdk-apb-timer.c
index 2e7318b81f..07f82e5fa1 100644
--- a/hw/timer/cmsdk-apb-timer.c
+++ b/hw/timer/cmsdk-apb-timer.c
@@ -34,6 +34,7 @@
 #include "qapi/error.h"
 #include "trace.h"
 #include "hw/sysbus.h"
+#include "hw/irq.h"
 #include "hw/registerfields.h"
 #include "hw/timer/cmsdk-apb-timer.h"
=20
diff --git a/hw/timer/etraxfs_timer.c b/hw/timer/etraxfs_timer.c
index 18887b2be2..2fd54ad4dc 100644
--- a/hw/timer/etraxfs_timer.c
+++ b/hw/timer/etraxfs_timer.c
@@ -28,6 +28,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
+#include "hw/irq.h"
 #include "hw/ptimer.h"
=20
 #define D(x)
diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index 874c7b8522..25e2125af8 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -61,6 +61,7 @@
 #include "hw/ptimer.h"
=20
 #include "hw/arm/exynos4210.h"
+#include "hw/irq.h"
=20
 //#define DEBUG_MCT
=20
diff --git a/hw/timer/exynos4210_pwm.c b/hw/timer/exynos4210_pwm.c
index 9bc0327785..2af7b374cc 100644
--- a/hw/timer/exynos4210_pwm.c
+++ b/hw/timer/exynos4210_pwm.c
@@ -29,6 +29,7 @@
 #include "hw/ptimer.h"
=20
 #include "hw/arm/exynos4210.h"
+#include "hw/irq.h"
=20
 //#define DEBUG_PWM
=20
diff --git a/hw/timer/exynos4210_rtc.c b/hw/timer/exynos4210_rtc.c
index 0ecedf7394..b9dfaf51f7 100644
--- a/hw/timer/exynos4210_rtc.c
+++ b/hw/timer/exynos4210_rtc.c
@@ -35,6 +35,7 @@
 #include "hw/ptimer.h"
=20
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "sysemu/sysemu.h"
=20
 #include "hw/arm/exynos4210.h"
diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index e45a49075b..28ba1259d0 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -26,6 +26,7 @@
 #include "hw/sparc/grlib.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
+#include "hw/irq.h"
 #include "hw/ptimer.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 41024f39fb..17838df783 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -27,6 +27,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
+#include "hw/irq.h"
 #include "ui/console.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/timer/i8254.c b/hw/timer/i8254.c
index 0972c4724e..97258757b1 100644
--- a/hw/timer/i8254.c
+++ b/hw/timer/i8254.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/timer/i8254.h"
diff --git a/hw/timer/imx_epit.c b/hw/timer/imx_epit.c
index 7a883160f4..afeb74339a 100644
--- a/hw/timer/imx_epit.c
+++ b/hw/timer/imx_epit.c
@@ -14,6 +14,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/timer/imx_epit.h"
+#include "hw/irq.h"
 #include "hw/misc/imx_ccm.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index 3086c03774..b4cfc52019 100644
--- a/hw/timer/imx_gpt.c
+++ b/hw/timer/imx_gpt.c
@@ -13,6 +13,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/timer/imx_gpt.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/hw/timer/lm32_timer.c b/hw/timer/lm32_timer.c
index 6ce876c6ae..4beffc1396 100644
--- a/hw/timer/lm32_timer.c
+++ b/hw/timer/lm32_timer.c
@@ -23,6 +23,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "trace.h"
 #include "qemu/timer.h"
diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
index 030c8872a2..e2479c504a 100644
--- a/hw/timer/m48t59.c
+++ b/hw/timer/m48t59.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/timer/m48t59.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 21fcba5e3a..0410cccafa 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -28,6 +28,7 @@
 #include "qemu/module.h"
 #include "qemu/bcd.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/replay.h"
diff --git a/hw/timer/milkymist-sysctl.c b/hw/timer/milkymist-sysctl.c
index a9d250877c..0f9c39715d 100644
--- a/hw/timer/milkymist-sysctl.c
+++ b/hw/timer/milkymist-sysctl.c
@@ -23,6 +23,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
diff --git a/hw/timer/mss-timer.c b/hw/timer/mss-timer.c
index 6add47af99..1be9baf9c0 100644
--- a/hw/timer/mss-timer.c
+++ b/hw/timer/mss-timer.c
@@ -27,6 +27,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
+#include "hw/irq.h"
 #include "hw/timer/mss-timer.h"
=20
 #ifndef MSS_TIMER_ERR_DEBUG
diff --git a/hw/timer/nrf51_timer.c b/hw/timer/nrf51_timer.c
index 29fb81a744..297403c4fd 100644
--- a/hw/timer/nrf51_timer.c
+++ b/hw/timer/nrf51_timer.c
@@ -15,6 +15,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/arm/nrf51.h"
+#include "hw/irq.h"
 #include "hw/timer/nrf51_timer.h"
 #include "trace.h"
=20
diff --git a/hw/timer/omap_gptimer.c b/hw/timer/omap_gptimer.c
index ae2dc99832..c34f60b5d4 100644
--- a/hw/timer/omap_gptimer.c
+++ b/hw/timer/omap_gptimer.c
@@ -17,8 +17,10 @@
  * You should have received a copy of the GNU General Public License alo=
ng
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "qemu/timer.h"
 #include "hw/arm/omap.h"
=20
diff --git a/hw/timer/pl031.c b/hw/timer/pl031.c
index 1a7e2ee06b..435c4a6c7e 100644
--- a/hw/timer/pl031.c
+++ b/hw/timer/pl031.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "hw/timer/pl031.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/timer/puv3_ost.c b/hw/timer/puv3_ost.c
index 4a8ae37ffd..6fe370049b 100644
--- a/hw/timer/puv3_ost.c
+++ b/hw/timer/puv3_ost.c
@@ -11,6 +11,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "hw/irq.h"
 #include "hw/ptimer.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index 8c1ef43cd5..9c3b2b80ab 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -9,6 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "hw/arm/pxa.h"
diff --git a/hw/timer/sh_timer.c b/hw/timer/sh_timer.c
index 91b18ba312..adcc0c138e 100644
--- a/hw/timer/sh_timer.c
+++ b/hw/timer/sh_timer.c
@@ -10,6 +10,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/sh4/sh.h"
 #include "qemu/timer.h"
 #include "qemu/main-loop.h"
diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index 005fd599e8..310a0a126a 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/timer.h"
+#include "hw/irq.h"
 #include "hw/ptimer.h"
 #include "hw/sysbus.h"
 #include "trace.h"
diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index 4c49dc4995..d7af928667 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/timer/stm32f2xx_timer.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/timer/twl92230.c b/hw/timer/twl92230.c
index 91ae7bf203..795f894a39 100644
--- a/hw/timer/twl92230.c
+++ b/hw/timer/twl92230.c
@@ -24,6 +24,7 @@
 #include "hw/hw.h"
 #include "qemu/timer.h"
 #include "hw/i2c/i2c.h"
+#include "hw/irq.h"
 #include "migration/qemu-file-types.h"
 #include "sysemu/sysemu.h"
 #include "ui/console.h"
diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 16bcd0393b..c4a83af8b9 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "hw/irq.h"
 #include "hw/ptimer.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
diff --git a/hw/timer/xlnx-zynqmp-rtc.c b/hw/timer/xlnx-zynqmp-rtc.c
index 36daf0c7e7..48c3fba677 100644
--- a/hw/timer/xlnx-zynqmp-rtc.c
+++ b/hw/timer/xlnx-zynqmp-rtc.c
@@ -31,6 +31,7 @@
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "hw/irq.h"
 #include "hw/ptimer.h"
 #include "qemu/cutils.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index d6b3212890..747e943c42 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/isa/isa.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
index 132e6086ee..7e933de228 100644
--- a/hw/unicore32/puv3.c
+++ b/hw/unicore32/puv3.c
@@ -20,6 +20,7 @@
 #undef DEBUG_PUV3
 #include "hw/unicore32/puv3.h"
 #include "hw/input/i8042.h"
+#include "hw/irq.h"
=20
 #define KERNEL_LOAD_ADDR        0x03000000
 #define KERNEL_MAX_SIZE         0x00800000 /* Just a guess */
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 62dab0592f..d2189fc844 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -28,6 +28,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "hw/irq.h"
 #include "hw/usb/ehci-regs.h"
 #include "hw/usb/hcd-ehci.h"
 #include "trace.h"
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 4f6fdbc0a7..1ced5cd71a 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -27,6 +27,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 622e609fb4..708df2ec0d 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -29,6 +29,7 @@
 #include "qemu/queue.h"
 #include "hw/sysbus.h"
 #include "trace.h"
+#include "hw/irq.h"
 #include "hw/platform-bus.h"
 #include "sysemu/kvm.h"
=20
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index d4c0997074..3dc525dea4 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -21,6 +21,7 @@
=20
 #include "qemu/osdep.h"
 #include "standard-headers/linux/virtio_mmio.h"
+#include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "hw/virtio/virtio.h"
 #include "migration/qemu-file-types.h"
diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-wat=
chdog.c
index 54ac393020..a79da39dd5 100644
--- a/hw/watchdog/cmsdk-apb-watchdog.c
+++ b/hw/watchdog/cmsdk-apb-watchdog.c
@@ -28,6 +28,7 @@
 #include "qemu/module.h"
 #include "sysemu/watchdog.h"
 #include "hw/sysbus.h"
+#include "hw/irq.h"
 #include "hw/registerfields.h"
 #include "hw/watchdog/cmsdk-apb-watchdog.h"
=20
diff --git a/hw/xtensa/mx_pic.c b/hw/xtensa/mx_pic.c
index 7075db9d4b..912de66206 100644
--- a/hw/xtensa/mx_pic.c
+++ b/hw/xtensa/mx_pic.c
@@ -27,6 +27,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "hw/xtensa/mx_pic.h"
 #include "qemu/log.h"
=20
diff --git a/hw/xtensa/pic_cpu.c b/hw/xtensa/pic_cpu.c
index df3acbb541..b708290d7b 100644
--- a/hw/xtensa/pic_cpu.c
+++ b/hw/xtensa/pic_cpu.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "hw/hw.h"
+#include "hw/irq.h"
 #include "qemu/log.h"
 #include "qemu/timer.h"
=20
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b74c23a9bc..75b66bf844 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -20,6 +20,7 @@
 #include "qemu/qemu-print.h"
 #include "exec/exec-all.h"
 #include <zlib.h> /* For crc32 */
+#include "hw/irq.h"
 #include "hw/semihosting/semihost.h"
 #include "sysemu/cpus.h"
 #include "sysemu/kvm.h"
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index fe4f461d4e..36a1e60bd4 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -27,6 +27,7 @@
 #include "exec/memattrs.h"
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
+#include "hw/irq.h"
 #include "qemu/log.h"
=20
 const KVMCapabilityInfo kvm_arch_required_capabilities[] =3D {
diff --git a/target/mips/cp0_timer.c b/target/mips/cp0_timer.c
index f4716395df..48c18d7818 100644
--- a/target/mips/cp0_timer.c
+++ b/target/mips/cp0_timer.c
@@ -21,6 +21,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/irq.h"
 #include "hw/mips/cpudevs.h"
 #include "qemu/timer.h"
 #include "sysemu/kvm.h"
--=20
2.21.0


