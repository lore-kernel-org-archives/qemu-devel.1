Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30C6C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B710721848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B710721848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1FPl-0007Sx-Ov
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 15:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i1FOx-0006dW-BV
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i1FOv-00020a-8p
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:39:11 -0400
Received: from nsstlmta08p.bpe.bigpond.com ([203.38.21.8]:38132)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1i1FOu-0001vN-D2
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:39:09 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep08p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190823193902.LKCU13678.nsstlfep08p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Sat, 24 Aug 2019 05:39:02 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrudegkedgudefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfupfevtfgpvffgnffuvffttedpqfgfvfenuceurghilhhouhhtmecugedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepvfhonhihucfpghhuhigvnhcuoehtohhnhidrnhhguhihvghnsegsthdrtghomheqnecukfhppeehkedrudejfedrleekrdeikeenucfrrghrrghmpehhvghlohepuggsiidrthgvlhhsthhrrgdrtghomhdrrghupdhinhgvthepheekrddujeefrdelkedrieekpdhmrghilhhfrhhomhepoehtohhnhidrnhhguhihvghnsegsthdrtghomheqpdhrtghpthhtohepoehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgqedprhgtphhtthhopeeothhonhihrdhnghhuhigvnhessghtrdgtohhmqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from dbz.telstra.com.au (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D3692920C8EB67D; Sat, 24 Aug 2019 05:39:02 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: qemu-devel@nongnu.org
Date: Sat, 24 Aug 2019 05:42:39 +1000
Message-Id: <cover.1566588033.git.tony.nguyen@bt.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.8
Subject: [Qemu-devel]  [PATCH 0/9] Delete enum device_endian
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
Cc: Tony Nguyen <tony.nguyen@bt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series deletes endian related enum, converter, and macro which have been
made redundant by MemOp being pushed down from TCG into the memory API.

This clean up was split out from an earlier series which collapsed byte swaps
along the I/O path.

Based-on: <cover.1566466906.git.tony.nguyen@bt.com>
    [PATCH v9 00/20] Invert Endian bit in SPARCv9 MMU TTE
Based-on: <cover.1566467963.git.tony.nguyen@bt.com>
    [RFC PATCH 00/17] Declare device little or big endian

Tony Nguyen (9):
  exec: Map device_endian onto MemOp
  exec: Replace DEVICE_NATIVE_ENDIAN with MO_TE
  exec: Replace DEVICE_LITTLE_ENDIAN with MO_LE
  exec: Replace DEVICE_BIG_ENDIAN with MO_BE
  exec: Replace enum device_endian with MemOp
  memory: Delete devend_memop
  exec: Delete device_endian
  exec: Delete DEVICE_HOST_ENDIAN
  memory: Delete memory_region_big_endian

 exec.c				     |	8 +--
 hw/acpi/core.c			     |	6 +-
 hw/acpi/cpu.c			     |	2 +-
 hw/acpi/cpu_hotplug.c		     |	2 +-
 hw/acpi/ich9.c			     |	4 +-
 hw/acpi/memory_hotplug.c	     |	2 +-
 hw/acpi/nvdimm.c		     |	2 +-
 hw/acpi/pcihp.c		     |	2 +-
 hw/acpi/piix4.c		     |	2 +-
 hw/acpi/tco.c			     |	2 +-
 hw/adc/stm32f2xx_adc.c		     |	2 +-
 hw/alpha/pci.c			     |	6 +-
 hw/alpha/typhoon.c		     |	6 +-
 hw/arm/allwinner-a10.c		     |	2 +-
 hw/arm/armv7m.c		     |	2 +-
 hw/arm/aspeed.c		     |	2 +-
 hw/arm/aspeed_soc.c		     |	2 +-
 hw/arm/exynos4210.c		     |	2 +-
 hw/arm/highbank.c		     |	2 +-
 hw/arm/integratorcp.c		     |	6 +-
 hw/arm/kzm.c			     |	2 +-
 hw/arm/msf2-soc.c		     |	2 +-
 hw/arm/musicpal.c		     | 20 +++----
 hw/arm/omap1.c			     | 40 ++++++-------
 hw/arm/omap2.c			     | 10 ++--
 hw/arm/omap_sx1.c		     |	2 +-
 hw/arm/palm.c			     |	2 +-
 hw/arm/pxa2xx.c		     | 20 +++----
 hw/arm/pxa2xx_gpio.c		     |	2 +-
 hw/arm/pxa2xx_pic.c		     |	2 +-
 hw/arm/smmuv3.c		     |	2 +-
 hw/arm/spitz.c			     |	2 +-
 hw/arm/stellaris.c		     |	8 +--
 hw/arm/strongarm.c		     | 12 ++--
 hw/arm/versatilepb.c		     |	2 +-
 hw/audio/ac97.c		     |	4 +-
 hw/audio/cs4231.c		     |	2 +-
 hw/audio/es1370.c		     |	2 +-
 hw/audio/intel-hda.c		     |	2 +-
 hw/audio/marvell_88w8618.c	     |	2 +-
 hw/audio/milkymist-ac97.c	     |	2 +-
 hw/audio/pl041.c		     |	2 +-
 hw/block/fdc.c			     |	4 +-
 hw/block/nvme.c		     |	4 +-
 hw/block/onenand.c		     |	2 +-
 hw/block/pflash_cfi01.c	     |	2 +-
 hw/block/pflash_cfi02.c	     |	2 +-
 hw/char/bcm2835_aux.c		     |	2 +-
 hw/char/cadence_uart.c		     |	2 +-
 hw/char/cmsdk-apb-uart.c	     |	2 +-
 hw/char/debugcon.c		     |	2 +-
 hw/char/digic-uart.c		     |	2 +-
 hw/char/escc.c			     |	2 +-
 hw/char/etraxfs_ser.c		     |	2 +-
 hw/char/exynos4210_uart.c	     |	2 +-
 hw/char/grlib_apbuart.c	     |	2 +-
 hw/char/imx_serial.c		     |	2 +-
 hw/char/lm32_uart.c		     |	2 +-
 hw/char/mcf_uart.c		     |	2 +-
 hw/char/milkymist-uart.c	     |	2 +-
 hw/char/nrf51_uart.c		     |	2 +-
 hw/char/omap_uart.c		     |	6 +-
 hw/char/parallel.c		     |	2 +-
 hw/char/pl011.c		     |	2 +-
 hw/char/serial.c		     | 26 ++++----
 hw/char/sh_serial.c		     |	2 +-
 hw/char/stm32f2xx_usart.c	     |	2 +-
 hw/char/xilinx_uartlite.c	     |	2 +-
 hw/core/empty_slot.c		     |	2 +-
 hw/cris/axis_dev88.c		     |	4 +-
 hw/display/ati.c		     |	2 +-
 hw/display/bcm2835_fb.c	     |	2 +-
 hw/display/bochs-display.c	     |	4 +-
 hw/display/cg3.c		     |	2 +-
 hw/display/cirrus_vga.c	     | 10 ++--
 hw/display/edid-region.c	     |	2 +-
 hw/display/exynos4210_fimd.c	     |	2 +-
 hw/display/g364fb.c		     |	2 +-
 hw/display/jazz_led.c		     |	2 +-
 hw/display/milkymist-tmu2.c	     |	2 +-
 hw/display/milkymist-vgafb.c	     |	2 +-
 hw/display/omap_dss.c		     | 10 ++--
 hw/display/omap_lcdc.c		     |	2 +-
 hw/display/pl110.c		     |	2 +-
 hw/display/pxa2xx_lcd.c	     |	2 +-
 hw/display/sm501.c		     | 10 ++--
 hw/display/tc6393xb.c		     |	2 +-
 hw/display/tcx.c		     | 14 ++---
 hw/display/vga-isa-mm.c	     |	2 +-
 hw/display/vga-pci.c		     |	6 +-
 hw/display/vga.c		     |	2 +-
 hw/display/vmware_vga.c	     |	2 +-
 hw/display/xlnx_dp.c		     |	8 +--
 hw/dma/bcm2835_dma.c		     |	4 +-
 hw/dma/etraxfs_dma.c		     |	2 +-
 hw/dma/i8257.c			     |	4 +-
 hw/dma/omap_dma.c		     |	4 +-
 hw/dma/pl080.c			     |	2 +-
 hw/dma/pl330.c			     |	2 +-
 hw/dma/puv3_dma.c		     |	2 +-
 hw/dma/pxa2xx_dma.c		     |	2 +-
 hw/dma/rc4030.c		     |	4 +-
 hw/dma/sparc32_dma.c		     |	2 +-
 hw/dma/xilinx_axidma.c		     |	2 +-
 hw/dma/xlnx-zdma.c		     |	2 +-
 hw/dma/xlnx-zynq-devcfg.c	     |	2 +-
 hw/dma/xlnx_dpdma.c		     |	2 +-
 hw/gpio/bcm2835_gpio.c		     |	2 +-
 hw/gpio/imx_gpio.c		     |	2 +-
 hw/gpio/mpc8xxx.c		     |	2 +-
 hw/gpio/nrf51_gpio.c		     |	2 +-
 hw/gpio/omap_gpio.c		     |	6 +-
 hw/gpio/pl061.c		     |	2 +-
 hw/gpio/puv3_gpio.c		     |	2 +-
 hw/gpio/zaurus.c		     |	2 +-
 hw/hppa/dino.c			     |	6 +-
 hw/hppa/machine.c		     |	2 +-
 hw/hppa/pci.c			     |	6 +-
 hw/hyperv/hyperv_testdev.c	     |	2 +-
 hw/i2c/aspeed_i2c.c		     |	4 +-
 hw/i2c/exynos4210_i2c.c	     |	2 +-
 hw/i2c/imx_i2c.c		     |	2 +-
 hw/i2c/microbit_i2c.c		     |	2 +-
 hw/i2c/mpc_i2c.c		     |	2 +-
 hw/i2c/omap_i2c.c		     |	2 +-
 hw/i2c/pm_smbus.c		     |	2 +-
 hw/i2c/ppc4xx_i2c.c		     |	2 +-
 hw/i2c/versatile_i2c.c		     |	2 +-
 hw/i386/amd_iommu.c		     |	4 +-
 hw/i386/intel_iommu.c		     |	4 +-
 hw/i386/kvm/apic.c		     |	2 +-
 hw/i386/kvmvapic.c		     |	2 +-
 hw/i386/pc.c			     |	6 +-
 hw/i386/vmport.c		     |	2 +-
 hw/i386/xen/xen_apic.c		     |	2 +-
 hw/i386/xen/xen_platform.c	     |	4 +-
 hw/i386/xen/xen_pvdevice.c	     |	2 +-
 hw/ide/ahci-allwinner.c	     |	2 +-
 hw/ide/ahci.c			     |	4 +-
 hw/ide/macio.c			     |	2 +-
 hw/ide/mmio.c			     |	4 +-
 hw/ide/pci.c			     |	6 +-
 hw/ide/sii3112.c		     |	2 +-
 hw/input/milkymist-softusb.c	     |	2 +-
 hw/input/pckbd.c		     |	6 +-
 hw/input/pl050.c		     |	2 +-
 hw/input/pxa2xx_keypad.c	     |	2 +-
 hw/intc/allwinner-a10-pic.c	     |	2 +-
 hw/intc/apic.c			     |	2 +-
 hw/intc/arm_gic.c		     | 12 ++--
 hw/intc/arm_gicv2m.c		     |	2 +-
 hw/intc/arm_gicv3.c		     |	4 +-
 hw/intc/arm_gicv3_its_common.c      |	2 +-
 hw/intc/armv7m_nvic.c		     |	6 +-
 hw/intc/aspeed_vic.c		     |	2 +-
 hw/intc/bcm2835_ic.c		     |	2 +-
 hw/intc/bcm2836_control.c	     |	2 +-
 hw/intc/etraxfs_pic.c		     |	2 +-
 hw/intc/exynos4210_combiner.c	     |	2 +-
 hw/intc/grlib_irqmp.c		     |	2 +-
 hw/intc/heathrow_pic.c		     |	2 +-
 hw/intc/imx_avic.c		     |	2 +-
 hw/intc/imx_gpcv2.c		     |	2 +-
 hw/intc/ioapic.c		     |	2 +-
 hw/intc/mips_gic.c		     |	2 +-
 hw/intc/omap_intc.c		     |	4 +-
 hw/intc/ompic.c		     |	2 +-
 hw/intc/openpic.c		     | 20 +++----
 hw/intc/openpic_kvm.c		     |	2 +-
 hw/intc/pl190.c		     |	2 +-
 hw/intc/pnv_xive.c		     | 14 ++---
 hw/intc/puv3_intc.c		     |	2 +-
 hw/intc/sh_intc.c		     |	2 +-
 hw/intc/slavio_intctl.c	     |	4 +-
 hw/intc/xics_pnv.c		     |	2 +-
 hw/intc/xilinx_intc.c		     |	2 +-
 hw/intc/xive.c			     |	6 +-
 hw/intc/xlnx-pmu-iomod-intc.c	     |	2 +-
 hw/intc/xlnx-zynqmp-ipi.c	     |	2 +-
 hw/ipack/tpci200.c		     | 10 ++--
 hw/ipmi/isa_ipmi_bt.c		     |	2 +-
 hw/ipmi/isa_ipmi_kcs.c		     |	2 +-
 hw/isa/lpc_ich9.c		     |	4 +-
 hw/isa/pc87312.c		     |	2 +-
 hw/isa/vt82c686.c		     |	2 +-
 hw/m68k/mcf5206.c		     |	2 +-
 hw/m68k/mcf5208.c		     |	4 +-
 hw/m68k/mcf_intc.c		     |	2 +-
 hw/microblaze/petalogix_ml605_mmu.c |	2 +-
 hw/mips/boston.c		     |	6 +-
 hw/mips/gt64xxx_pci.c		     |	2 +-
 hw/mips/mips_jazz.c		     |	8 +--
 hw/mips/mips_malta.c		     |	4 +-
 hw/mips/mips_r4k.c		     |	2 +-
 hw/misc/a9scu.c		     |	2 +-
 hw/misc/applesmc.c		     |	6 +-
 hw/misc/arm11scu.c		     |	2 +-
 hw/misc/arm_integrator_debug.c      |	2 +-
 hw/misc/arm_l2x0.c		     |	2 +-
 hw/misc/arm_sysctl.c		     |	2 +-
 hw/misc/armsse-cpuid.c		     |	2 +-
 hw/misc/armsse-mhu.c		     |	2 +-
 hw/misc/aspeed_scu.c		     |	2 +-
 hw/misc/aspeed_sdmc.c		     |	2 +-
 hw/misc/aspeed_xdma.c		     |	2 +-
 hw/misc/bcm2835_mbox.c		     |	2 +-
 hw/misc/bcm2835_property.c	     |	2 +-
 hw/misc/bcm2835_rng.c		     |	2 +-
 hw/misc/debugexit.c		     |	2 +-
 hw/misc/eccmemctl.c		     |	4 +-
 hw/misc/edu.c			     |	2 +-
 hw/misc/exynos4210_clk.c	     |	2 +-
 hw/misc/exynos4210_pmu.c	     |	2 +-
 hw/misc/exynos4210_rng.c	     |	2 +-
 hw/misc/grlib_ahb_apb_pnp.c	     |	4 +-
 hw/misc/imx25_ccm.c		     |	2 +-
 hw/misc/imx2_wdt.c		     |	2 +-
 hw/misc/imx31_ccm.c		     |	2 +-
 hw/misc/imx6_ccm.c		     |	4 +-
 hw/misc/imx6_src.c		     |	2 +-
 hw/misc/imx6ul_ccm.c		     |	4 +-
 hw/misc/imx7_ccm.c		     |	4 +-
 hw/misc/imx7_gpr.c		     |	2 +-
 hw/misc/imx7_snvs.c		     |	2 +-
 hw/misc/iotkit-secctl.c	     |	4 +-
 hw/misc/iotkit-sysctl.c	     |	2 +-
 hw/misc/iotkit-sysinfo.c	     |	2 +-
 hw/misc/ivshmem.c		     |	2 +-
 hw/misc/macio/cuda.c		     |	2 +-
 hw/misc/macio/gpio.c		     |	2 +-
 hw/misc/macio/mac_dbdma.c	     |	2 +-
 hw/misc/macio/macio.c		     |	2 +-
 hw/misc/macio/pmu.c		     |	2 +-
 hw/misc/milkymist-hpdmc.c	     |	2 +-
 hw/misc/milkymist-pfpu.c	     |	2 +-
 hw/misc/mips_cmgcr.c		     |	2 +-
 hw/misc/mips_cpc.c		     |	2 +-
 hw/misc/mips_itu.c		     |	4 +-
 hw/misc/mos6522.c		     |	2 +-
 hw/misc/mps2-fpgaio.c		     |	2 +-
 hw/misc/mps2-scc.c		     |	2 +-
 hw/misc/msf2-sysreg.c		     |	2 +-
 hw/misc/mst_fpga.c		     |	2 +-
 hw/misc/nrf51_rng.c		     |	2 +-
 hw/misc/omap_gpmc.c		     |	6 +-
 hw/misc/omap_l4.c		     |	2 +-
 hw/misc/omap_sdrc.c		     |	2 +-
 hw/misc/omap_tap.c		     |	2 +-
 hw/misc/pc-testdev.c		     | 10 ++--
 hw/misc/pci-testdev.c		     |	4 +-
 hw/misc/puv3_pm.c		     |	2 +-
 hw/misc/slavio_misc.c		     | 16 ++---
 hw/misc/stm32f2xx_syscfg.c	     |	2 +-
 hw/misc/tz-mpc.c		     |	4 +-
 hw/misc/tz-msc.c		     |	2 +-
 hw/misc/tz-ppc.c		     |	2 +-
 hw/misc/unimp.c		     |	2 +-
 hw/misc/zynq-xadc.c		     |	2 +-
 hw/misc/zynq_slcr.c		     |	2 +-
 hw/moxie/moxiesim.c		     |	2 +-
 hw/net/allwinner_emac.c	     |	2 +-
 hw/net/cadence_gem.c		     |	2 +-
 hw/net/can/can_kvaser_pci.c	     |	6 +-
 hw/net/can/can_mioe3680_pci.c	     |	4 +-
 hw/net/can/can_pcm3680_pci.c	     |	4 +-
 hw/net/dp8393x.c		     |	2 +-
 hw/net/e1000.c			     |	4 +-
 hw/net/e1000e.c		     |	4 +-
 hw/net/eepro100.c		     |	2 +-
 hw/net/etraxfs_eth.c		     |	2 +-
 hw/net/fsl_etsec/etsec.c	     |	2 +-
 hw/net/ftgmac100.c		     |	2 +-
 hw/net/imx_fec.c		     |	2 +-
 hw/net/lan9118.c		     |	4 +-
 hw/net/lance.c			     |	2 +-
 hw/net/mcf_fec.c		     |	2 +-
 hw/net/milkymist-minimac2.c	     |	2 +-
 hw/net/ne2000.c		     |	2 +-
 hw/net/pcnet-pci.c		     |	4 +-
 hw/net/rocker/rocker.c		     |	2 +-
 hw/net/rtl8139.c		     |	2 +-
 hw/net/smc91c111.c		     |	2 +-
 hw/net/stellaris_enet.c	     |	2 +-
 hw/net/sungem.c		     | 12 ++--
 hw/net/sunhme.c		     | 10 ++--
 hw/net/vmxnet3.c		     |	4 +-
 hw/net/xgmac.c			     |	2 +-
 hw/net/xilinx_axienet.c	     |	2 +-
 hw/net/xilinx_ethlite.c	     |	2 +-
 hw/nios2/10m50_devboard.c	     |	2 +-
 hw/nvram/ds1225y.c		     |	2 +-
 hw/nvram/fw_cfg.c		     |	8 +--
 hw/nvram/mac_nvram.c		     |	2 +-
 hw/nvram/nrf51_nvm.c		     |	8 +--
 hw/openrisc/openrisc_sim.c	     |	2 +-
 hw/pci-host/bonito.c		     | 10 ++--
 hw/pci-host/designware.c	     |	6 +-
 hw/pci-host/piix.c		     |	2 +-
 hw/pci-host/ppce500.c		     |	2 +-
 hw/pci-host/prep.c		     |	4 +-
 hw/pci-host/q35.c		     |	4 +-
 hw/pci-host/sabre.c		     |	4 +-
 hw/pci-host/uninorth.c		     |	4 +-
 hw/pci-host/versatile.c	     |	4 +-
 hw/pci/msix.c			     |	4 +-
 hw/pci/pci_host.c		     |	8 +--
 hw/pci/pcie_host.c		     |	2 +-
 hw/pci/shpc.c			     |	2 +-
 hw/pcmcia/pxa2xx.c		     |	6 +-
 hw/ppc/e500.c			     |	4 +-
 hw/ppc/mpc8544_guts.c		     |	2 +-
 hw/ppc/pnv_core.c		     |	6 +-
 hw/ppc/pnv_lpc.c		     |	8 +--
 hw/ppc/pnv_occ.c		     |	4 +-
 hw/ppc/pnv_psi.c		     |	8 +--
 hw/ppc/pnv_xscom.c		     |	2 +-
 hw/ppc/ppc405_boards.c		     |	4 +-
 hw/ppc/ppc405_uc.c		     | 14 ++---
 hw/ppc/ppc440_bamboo.c		     |	4 +-
 hw/ppc/ppc440_pcix.c		     |	4 +-
 hw/ppc/ppc4xx_pci.c		     |	2 +-
 hw/ppc/ppce500_spin.c		     |	2 +-
 hw/ppc/sam460ex.c		     |	4 +-
 hw/ppc/spapr_pci.c		     |	2 +-
 hw/ppc/virtex_ml507.c		     |	2 +-
 hw/rdma/vmw/pvrdma_main.c	     |	4 +-
 hw/riscv/sifive_clint.c	     |	2 +-
 hw/riscv/sifive_gpio.c		     |	2 +-
 hw/riscv/sifive_plic.c		     |	2 +-
 hw/riscv/sifive_prci.c		     |	2 +-
 hw/riscv/sifive_test.c		     |	2 +-
 hw/riscv/sifive_uart.c		     |	2 +-
 hw/riscv/virt.c		     |	2 +-
 hw/s390x/s390-pci-bus.c	     |	2 +-
 hw/scsi/esp-pci.c		     |	2 +-
 hw/scsi/esp.c			     |	2 +-
 hw/scsi/lsi53c895a.c		     |	6 +-
 hw/scsi/megasas.c		     |	6 +-
 hw/scsi/mptsas.c		     |	6 +-
 hw/scsi/vmw_pvscsi.c		     |	2 +-
 hw/sd/bcm2835_sdhost.c		     |	2 +-
 hw/sd/milkymist-memcard.c	     |	2 +-
 hw/sd/omap_mmc.c		     |	2 +-
 hw/sd/pl181.c			     |	2 +-
 hw/sd/pxa2xx_mmci.c		     |	2 +-
 hw/sd/sdhci.c			     |	4 +-
 hw/sh4/r2d.c			     |	2 +-
 hw/sh4/sh7750.c		     |	4 +-
 hw/sh4/sh_pci.c		     |	2 +-
 hw/sparc/sun4m_iommu.c		     |	2 +-
 hw/sparc64/niagara.c		     |	2 +-
 hw/sparc64/sun4u.c		     |	4 +-
 hw/sparc64/sun4u_iommu.c	     |	2 +-
 hw/ssi/aspeed_smc.c		     |	6 +-
 hw/ssi/imx_spi.c		     |	2 +-
 hw/ssi/mss-spi.c		     |	2 +-
 hw/ssi/omap_spi.c		     |	2 +-
 hw/ssi/pl022.c			     |	2 +-
 hw/ssi/stm32f2xx_spi.c		     |	2 +-
 hw/ssi/xilinx_spi.c		     |	2 +-
 hw/ssi/xilinx_spips.c		     |	8 +--
 hw/timer/a9gtimer.c		     |	4 +-
 hw/timer/allwinner-a10-pit.c	     |	2 +-
 hw/timer/altera_timer.c	     |	2 +-
 hw/timer/arm_mptimer.c		     |	4 +-
 hw/timer/arm_timer.c		     |	4 +-
 hw/timer/armv7m_systick.c	     |	2 +-
 hw/timer/aspeed_rtc.c		     |	2 +-
 hw/timer/aspeed_timer.c	     |	2 +-
 hw/timer/cadence_ttc.c		     |	2 +-
 hw/timer/cmsdk-apb-dualtimer.c      |	2 +-
 hw/timer/cmsdk-apb-timer.c	     |	2 +-
 hw/timer/digic-timer.c		     |	2 +-
 hw/timer/etraxfs_timer.c	     |	2 +-
 hw/timer/exynos4210_mct.c	     |	2 +-
 hw/timer/exynos4210_pwm.c	     |	2 +-
 hw/timer/exynos4210_rtc.c	     |	2 +-
 hw/timer/grlib_gptimer.c	     |	2 +-
 hw/timer/hpet.c		     |	2 +-
 hw/timer/i8254.c		     |	2 +-
 hw/timer/imx_epit.c		     |	2 +-
 hw/timer/imx_gpt.c		     |	2 +-
 hw/timer/lm32_timer.c		     |	2 +-
 hw/timer/m48t59.c		     |	4 +-
 hw/timer/mc146818rtc.c		     |	2 +-
 hw/timer/milkymist-sysctl.c	     |	2 +-
 hw/timer/mss-timer.c		     |	2 +-
 hw/timer/nrf51_timer.c		     |	2 +-
 hw/timer/omap_gptimer.c	     |	2 +-
 hw/timer/omap_synctimer.c	     |	2 +-
 hw/timer/pl031.c		     |	2 +-
 hw/timer/puv3_ost.c		     |	2 +-
 hw/timer/pxa2xx_timer.c	     |	2 +-
 hw/timer/sh_timer.c		     |	2 +-
 hw/timer/slavio_timer.c	     |	2 +-
 hw/timer/stm32f2xx_timer.c	     |	2 +-
 hw/timer/sun4v-rtc.c		     |	2 +-
 hw/timer/xilinx_timer.c	     |	2 +-
 hw/timer/xlnx-zynqmp-rtc.c	     |	2 +-
 hw/tpm/tpm_crb.c		     |	2 +-
 hw/tpm/tpm_tis.c		     |	2 +-
 hw/usb/chipidea.c		     |	4 +-
 hw/usb/hcd-ehci-sysbus.c	     |	2 +-
 hw/usb/hcd-ehci.c		     |	6 +-
 hw/usb/hcd-ohci.c		     |	2 +-
 hw/usb/hcd-uhci.c		     |	2 +-
 hw/usb/hcd-xhci.c		     | 10 ++--
 hw/usb/tusb6010.c		     |	2 +-
 hw/vfio/common.c		     |	2 +-
 hw/vfio/pci-quirks.c		     | 26 ++++----
 hw/vfio/pci.c			     |	4 +-
 hw/virtio/virtio-mmio.c	     |	2 +-
 hw/virtio/virtio-pci.c		     | 12 ++--
 hw/watchdog/cmsdk-apb-watchdog.c    |	2 +-
 hw/watchdog/wdt_aspeed.c	     |	2 +-
 hw/watchdog/wdt_i6300esb.c	     |	2 +-
 hw/xen/xen_pt.c		     |	2 +-
 hw/xen/xen_pt_msi.c		     |	2 +-
 hw/xtensa/mx_pic.c		     |	2 +-
 hw/xtensa/xtfpga.c		     |	6 +-
 include/exec/cpu-common.h	     | 12 ----
 include/exec/memory.h		     |	5 +-
 include/hw/char/serial.h	     |	2 +-
 ioport.c			     |	4 +-
 memory.c			     | 35 ++---------
 memory_ldst.inc.c		     | 93 +++++++++++++----------------
 426 files changed, 762 insertions(+), 819 deletions(-)

-- 
2.23.0


