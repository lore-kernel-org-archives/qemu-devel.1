Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06704C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 07:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F146208C4
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 07:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F146208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvyzr-0003Y1-PQ
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 03:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48600)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hvygQ-00011u-FI
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hvygE-0001uc-Qq
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37118)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hvygC-0001qk-HZ
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C76AC30027B3
 for <qemu-devel@nongnu.org>; Fri,  9 Aug 2019 06:47:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A968C5D9CC;
 Fri,  9 Aug 2019 06:47:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BFEC1113642D; Fri,  9 Aug 2019 08:46:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 08:46:37 +0200
Message-Id: <20190809064645.22656-22-armbru@redhat.com>
In-Reply-To: <20190809064645.22656-1-armbru@redhat.com>
References: <20190809064645.22656-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 09 Aug 2019 06:47:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 21/29] Include hw/qdev-properties.h less
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In my "build everything" tree, changing hw/qdev-properties.h triggers
a recompile of some 2700 out of 6600 objects (not counting tests and
objects that don't depend on qemu/osdep.h).

Many places including hw/qdev-properties.h (directly or via hw/qdev.h)
actually need only hw/qdev-core.h.  Include hw/qdev-core.h there
instead.

hw/qdev.h is actually pointless: all it does is include hw/qdev-core.h
and hw/qdev-properties.h, which in turn includes hw/qdev-core.h.
Replace the remaining uses of hw/qdev.h by hw/qdev-properties.h.

While there, delete a few superfluous inclusions of hw/qdev-core.h.

Touching hw/qdev-properties.h now recompiles some 1200 objects.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 backends/vhost-user.c                 | 1 -
 hw/9pfs/virtio-9p-device.c            | 1 +
 hw/acpi/piix4.c                       | 1 +
 hw/acpi/vmgenid.c                     | 1 +
 hw/arm/armv7m.c                       | 1 +
 hw/arm/aspeed.c                       | 1 +
 hw/arm/digic.c                        | 1 +
 hw/arm/exynos4210.c                   | 1 +
 hw/arm/exynos4_boards.c               | 1 +
 hw/arm/fsl-imx25.c                    | 1 +
 hw/arm/fsl-imx31.c                    | 1 +
 hw/arm/fsl-imx6.c                     | 1 +
 hw/arm/mcimx6ul-evk.c                 | 1 +
 hw/arm/mcimx7d-sabre.c                | 1 +
 hw/arm/microbit.c                     | 1 +
 hw/arm/msf2-som.c                     | 1 +
 hw/arm/musicpal.c                     | 1 +
 hw/arm/netduino2.c                    | 1 +
 hw/arm/nseries.c                      | 1 +
 hw/arm/omap1.c                        | 1 +
 hw/arm/omap2.c                        | 1 +
 hw/arm/pxa2xx.c                       | 1 +
 hw/arm/pxa2xx_gpio.c                  | 1 +
 hw/arm/sabrelite.c                    | 1 +
 hw/arm/sbsa-ref.c                     | 1 +
 hw/arm/spitz.c                        | 1 +
 hw/arm/stm32f205_soc.c                | 1 +
 hw/arm/strongarm.c                    | 1 +
 hw/arm/virt.c                         | 1 +
 hw/audio/ac97.c                       | 1 +
 hw/audio/adlib.c                      | 1 +
 hw/audio/cs4231a.c                    | 2 +-
 hw/audio/gus.c                        | 1 +
 hw/audio/hda-codec.c                  | 1 +
 hw/audio/intel-hda.c                  | 1 +
 hw/audio/intel-hda.h                  | 2 +-
 hw/audio/marvell_88w8618.c            | 1 +
 hw/audio/pl041.c                      | 1 +
 hw/audio/sb16.c                       | 2 +-
 hw/block/fdc.c                        | 1 +
 hw/block/m25p80.c                     | 1 +
 hw/block/nand.c                       | 2 +-
 hw/block/nvme.c                       | 1 +
 hw/block/onenand.c                    | 1 +
 hw/block/pflash_cfi01.c               | 1 +
 hw/block/pflash_cfi02.c               | 1 +
 hw/block/vhost-user-blk.c             | 1 +
 hw/block/virtio-blk.c                 | 1 +
 hw/block/xen-block.c                  | 1 +
 hw/char/bcm2835_aux.c                 | 1 +
 hw/char/debugcon.c                    | 1 +
 hw/char/digic-uart.c                  | 1 +
 hw/char/escc.c                        | 1 +
 hw/char/etraxfs_ser.c                 | 1 +
 hw/char/exynos4210_uart.c             | 1 +
 hw/char/grlib_apbuart.c               | 1 +
 hw/char/imx_serial.c                  | 1 +
 hw/char/ipoctal232.c                  | 1 +
 hw/char/lm32_juart.c                  | 1 +
 hw/char/lm32_uart.c                   | 1 +
 hw/char/mcf_uart.c                    | 1 +
 hw/char/milkymist-uart.c              | 1 +
 hw/char/nrf51_uart.c                  | 1 +
 hw/char/parallel-isa.c                | 2 ++
 hw/char/parallel.c                    | 1 +
 hw/char/sclpconsole-lm.c              | 2 +-
 hw/char/sclpconsole.c                 | 2 +-
 hw/char/serial-isa.c                  | 1 +
 hw/char/serial-pci-multi.c            | 1 +
 hw/char/serial-pci.c                  | 1 +
 hw/char/spapr_vty.c                   | 2 +-
 hw/char/stm32f2xx_usart.c             | 1 +
 hw/char/terminal3270.c                | 1 +
 hw/char/virtio-console.c              | 1 +
 hw/char/virtio-serial-bus.c           | 1 +
 hw/char/xilinx_uartlite.c             | 1 +
 hw/core/bus.c                         | 2 +-
 hw/core/generic-loader.c              | 1 +
 hw/core/or-irq.c                      | 1 +
 hw/core/platform-bus.c                | 1 +
 hw/core/qdev-fw.c                     | 2 +-
 hw/core/qdev-properties-system.c      | 2 +-
 hw/core/qdev-properties.c             | 2 +-
 hw/core/qdev.c                        | 2 +-
 hw/core/register.c                    | 1 -
 hw/core/split-irq.c                   | 1 +
 hw/core/vm-change-state-handler.c     | 2 +-
 hw/cpu/a15mpcore.c                    | 1 +
 hw/cpu/a9mpcore.c                     | 1 +
 hw/cpu/arm11mpcore.c                  | 1 +
 hw/cpu/cluster.c                      | 1 +
 hw/cpu/realview_mpcore.c              | 1 +
 hw/display/ati.c                      | 1 +
 hw/display/bcm2835_fb.c               | 1 +
 hw/display/bochs-display.c            | 1 +
 hw/display/cg3.c                      | 1 +
 hw/display/cirrus_vga.c               | 1 +
 hw/display/cirrus_vga_isa.c           | 1 +
 hw/display/g364fb.c                   | 1 +
 hw/display/i2c-ddc.c                  | 1 +
 hw/display/milkymist-vgafb.c          | 1 +
 hw/display/qxl.c                      | 1 +
 hw/display/ramfb-standalone.c         | 1 +
 hw/display/sm501.c                    | 1 +
 hw/display/tcx.c                      | 1 +
 hw/display/vga-isa.c                  | 1 +
 hw/display/vga-pci.c                  | 1 +
 hw/display/vhost-user-gpu.c           | 1 +
 hw/display/virtio-gpu-pci.c           | 1 +
 hw/display/virtio-gpu.c               | 1 +
 hw/display/virtio-vga.c               | 1 +
 hw/display/vmware_vga.c               | 1 +
 hw/dma/i82374.c                       | 1 +
 hw/dma/i8257.c                        | 1 +
 hw/dma/pl080.c                        | 1 +
 hw/dma/pl330.c                        | 1 +
 hw/dma/pxa2xx_dma.c                   | 1 +
 hw/dma/sparc32_dma.c                  | 1 +
 hw/dma/xilinx_axidma.c                | 1 +
 hw/dma/xlnx-zdma.c                    | 1 +
 hw/gpio/imx_gpio.c                    | 1 +
 hw/gpio/max7310.c                     | 1 +
 hw/gpio/omap_gpio.c                   | 1 +
 hw/hyperv/hyperv_testdev.c            | 1 -
 hw/i2c/core.c                         | 1 +
 hw/i2c/omap_i2c.c                     | 1 +
 hw/i2c/smbus_eeprom.c                 | 1 +
 hw/i386/intel_iommu.c                 | 1 +
 hw/i386/kvm/clock.c                   | 1 +
 hw/i386/kvm/ioapic.c                  | 1 +
 hw/i386/pc_q35.c                      | 1 +
 hw/i386/pc_sysfw.c                    | 1 +
 hw/i386/vmmouse.c                     | 2 +-
 hw/i386/vmport.c                      | 1 -
 hw/i386/x86-iommu.c                   | 1 +
 hw/i386/xen/xen_pvdevice.c            | 1 +
 hw/ide/ahci.c                         | 1 +
 hw/ide/cmd646.c                       | 1 +
 hw/ide/isa.c                          | 1 +
 hw/ide/macio.c                        | 1 +
 hw/ide/mmio.c                         | 1 +
 hw/ide/qdev.c                         | 1 +
 hw/input/adb.c                        | 1 +
 hw/input/milkymist-softusb.c          | 1 +
 hw/input/vhost-user-input.c           | 1 -
 hw/input/virtio-input-hid.c           | 2 +-
 hw/input/virtio-input-host.c          | 2 +-
 hw/input/virtio-input.c               | 2 +-
 hw/intc/apic_common.c                 | 2 +-
 hw/intc/arm_gic_common.c              | 1 +
 hw/intc/arm_gicv2m.c                  | 1 +
 hw/intc/arm_gicv3_common.c            | 1 +
 hw/intc/arm_gicv3_its_kvm.c           | 1 +
 hw/intc/armv7m_nvic.c                 | 1 +
 hw/intc/etraxfs_pic.c                 | 1 +
 hw/intc/exynos4210_combiner.c         | 1 +
 hw/intc/exynos4210_gic.c              | 1 +
 hw/intc/grlib_irqmp.c                 | 1 +
 hw/intc/i8259_common.c                | 1 +
 hw/intc/ioapic.c                      | 1 +
 hw/intc/mips_gic.c                    | 1 +
 hw/intc/omap_intc.c                   | 1 +
 hw/intc/ompic.c                       | 1 +
 hw/intc/openpic.c                     | 1 +
 hw/intc/openpic_kvm.c                 | 1 +
 hw/intc/pnv_xive.c                    | 1 +
 hw/intc/realview_gic.c                | 1 +
 hw/intc/s390_flic.c                   | 2 +-
 hw/intc/spapr_xive.c                  | 1 +
 hw/intc/xics.c                        | 1 +
 hw/intc/xilinx_intc.c                 | 1 +
 hw/intc/xlnx-pmu-iomod-intc.c         | 1 +
 hw/ipack/ipack.c                      | 1 +
 hw/ipmi/ipmi.c                        | 1 +
 hw/ipmi/ipmi_bmc_extern.c             | 1 +
 hw/ipmi/ipmi_bmc_sim.c                | 1 +
 hw/ipmi/isa_ipmi_bt.c                 | 1 +
 hw/ipmi/isa_ipmi_kcs.c                | 1 +
 hw/isa/isa-superio.c                  | 1 +
 hw/isa/lpc_ich9.c                     | 1 +
 hw/isa/pc87312.c                      | 1 +
 hw/isa/vt82c686.c                     | 1 +
 hw/lm32/lm32.h                        | 1 +
 hw/lm32/milkymist-hw.h                | 2 +-
 hw/lm32/milkymist.c                   | 1 +
 hw/mem/memory-device.c                | 1 -
 hw/mem/nvdimm.c                       | 1 +
 hw/mem/pc-dimm.c                      | 1 +
 hw/microblaze/petalogix_ml605_mmu.c   | 1 +
 hw/microblaze/xlnx-zynqmp-pmu.c       | 1 -
 hw/mips/boston.c                      | 1 +
 hw/mips/cps.c                         | 1 +
 hw/misc/a9scu.c                       | 1 +
 hw/misc/applesmc.c                    | 1 +
 hw/misc/arm11scu.c                    | 1 +
 hw/misc/arm_l2x0.c                    | 1 +
 hw/misc/arm_sysctl.c                  | 1 +
 hw/misc/armsse-cpuid.c                | 1 +
 hw/misc/bcm2835_property.c            | 1 +
 hw/misc/debugexit.c                   | 1 +
 hw/misc/eccmemctl.c                   | 1 +
 hw/misc/iotkit-sysctl.c               | 1 +
 hw/misc/iotkit-sysinfo.c              | 1 +
 hw/misc/ivshmem.c                     | 1 +
 hw/misc/macio/cuda.c                  | 1 +
 hw/misc/macio/gpio.c                  | 1 +
 hw/misc/macio/macio.c                 | 1 +
 hw/misc/macio/pmu.c                   | 1 +
 hw/misc/mips_cmgcr.c                  | 1 +
 hw/misc/mips_cpc.c                    | 1 +
 hw/misc/mips_itu.c                    | 1 +
 hw/misc/mos6522.c                     | 1 +
 hw/misc/mps2-fpgaio.c                 | 1 +
 hw/misc/mps2-scc.c                    | 1 +
 hw/misc/msf2-sysreg.c                 | 1 +
 hw/misc/nrf51_rng.c                   | 1 +
 hw/misc/pc-testdev.c                  | 1 -
 hw/misc/pci-testdev.c                 | 1 +
 hw/misc/pvpanic.c                     | 1 +
 hw/misc/tz-mpc.c                      | 1 +
 hw/misc/tz-msc.c                      | 1 +
 hw/misc/tz-ppc.c                      | 1 +
 hw/net/allwinner_emac.c               | 1 +
 hw/net/cadence_gem.c                  | 1 +
 hw/net/can/can_kvaser_pci.c           | 1 +
 hw/net/can/can_mioe3680_pci.c         | 1 +
 hw/net/can/can_pcm3680_pci.c          | 1 +
 hw/net/dp8393x.c                      | 1 +
 hw/net/e1000.c                        | 1 +
 hw/net/e1000e.c                       | 1 +
 hw/net/eepro100.c                     | 1 +
 hw/net/fsl_etsec/etsec.c              | 1 +
 hw/net/fsl_etsec/etsec.h              | 1 -
 hw/net/ftgmac100.c                    | 1 +
 hw/net/imx_fec.c                      | 1 +
 hw/net/lan9118.c                      | 1 +
 hw/net/lance.c                        | 1 +
 hw/net/mcf_fec.c                      | 1 +
 hw/net/milkymist-minimac2.c           | 1 +
 hw/net/mipsnet.c                      | 1 +
 hw/net/ne2000-isa.c                   | 1 -
 hw/net/ne2000-pci.c                   | 1 +
 hw/net/opencores_eth.c                | 1 +
 hw/net/pcnet-pci.c                    | 1 +
 hw/net/pcnet.c                        | 2 +-
 hw/net/rocker/rocker.c                | 1 +
 hw/net/rtl8139.c                      | 1 +
 hw/net/smc91c111.c                    | 1 +
 hw/net/spapr_llan.c                   | 2 +-
 hw/net/stellaris_enet.c               | 1 +
 hw/net/sungem.c                       | 1 +
 hw/net/sunhme.c                       | 1 +
 hw/net/virtio-net.c                   | 1 +
 hw/net/vmxnet3.c                      | 1 +
 hw/net/xgmac.c                        | 1 +
 hw/net/xilinx_axienet.c               | 2 ++
 hw/net/xilinx_ethlite.c               | 1 +
 hw/nios2/10m50_devboard.c             | 1 +
 hw/nvram/ds1225y.c                    | 1 +
 hw/nvram/eeprom_at24c.c               | 1 +
 hw/nvram/fw_cfg.c                     | 1 +
 hw/nvram/mac_nvram.c                  | 1 +
 hw/nvram/nrf51_nvm.c                  | 1 +
 hw/nvram/spapr_nvram.c                | 1 +
 hw/openrisc/openrisc_sim.c            | 1 +
 hw/pci-bridge/gen_pcie_root_port.c    | 1 +
 hw/pci-bridge/pci_bridge_dev.c        | 1 +
 hw/pci-bridge/pci_expander_bridge.c   | 1 +
 hw/pci-bridge/pcie_pci_bridge.c       | 1 +
 hw/pci-bridge/pcie_root_port.c        | 1 +
 hw/pci-bridge/xio3130_downstream.c    | 1 +
 hw/pci-host/designware.c              | 1 +
 hw/pci-host/gpex.c                    | 1 +
 hw/pci-host/grackle.c                 | 1 +
 hw/pci-host/piix.c                    | 1 +
 hw/pci-host/ppce500.c                 | 1 +
 hw/pci-host/prep.c                    | 1 +
 hw/pci-host/q35.c                     | 1 +
 hw/pci-host/sabre.c                   | 1 +
 hw/pci-host/uninorth.c                | 1 +
 hw/pci-host/versatile.c               | 1 +
 hw/pci-host/xilinx-pcie.c             | 1 +
 hw/pci/pci.c                          | 1 +
 hw/pci/pcie_port.c                    | 1 +
 hw/ppc/e500.c                         | 1 +
 hw/ppc/mac_newworld.c                 | 1 +
 hw/ppc/mac_oldworld.c                 | 1 +
 hw/ppc/pnv.c                          | 1 +
 hw/ppc/pnv_core.c                     | 1 +
 hw/ppc/pnv_psi.c                      | 1 +
 hw/ppc/ppc440_uc.c                    | 1 +
 hw/ppc/prep_systemio.c                | 1 +
 hw/ppc/rs6000_mc.c                    | 1 +
 hw/ppc/sam460ex.c                     | 1 +
 hw/ppc/spapr.c                        | 1 +
 hw/ppc/spapr_cpu_core.c               | 1 +
 hw/ppc/spapr_drc.c                    | 1 -
 hw/ppc/spapr_events.c                 | 1 -
 hw/ppc/spapr_iommu.c                  | 1 -
 hw/ppc/spapr_irq.c                    | 1 +
 hw/ppc/spapr_pci.c                    | 1 +
 hw/ppc/spapr_rng.c                    | 1 +
 hw/ppc/spapr_rtas.c                   | 1 -
 hw/ppc/virtex_ml507.c                 | 1 +
 hw/rdma/vmw/pvrdma_main.c             | 1 -
 hw/riscv/riscv_hart.c                 | 1 +
 hw/riscv/sifive_clint.c               | 1 +
 hw/riscv/sifive_plic.c                | 1 +
 hw/riscv/sifive_prci.c                | 1 +
 hw/riscv/sifive_test.c                | 1 +
 hw/s390x/3270-ccw.c                   | 2 ++
 hw/s390x/ap-device.c                  | 1 -
 hw/s390x/ccw-device.c                 | 1 +
 hw/s390x/css-bridge.c                 | 1 +
 hw/s390x/css.c                        | 2 +-
 hw/s390x/ipl.c                        | 1 +
 hw/s390x/ipl.h                        | 2 +-
 hw/s390x/s390-pci-bus.c               | 1 +
 hw/s390x/s390-virtio-ccw.c            | 1 +
 hw/s390x/sclpquiesce.c                | 1 -
 hw/s390x/vhost-vsock-ccw.c            | 1 +
 hw/s390x/virtio-ccw-9p.c              | 1 +
 hw/s390x/virtio-ccw-balloon.c         | 1 +
 hw/s390x/virtio-ccw-blk.c             | 1 +
 hw/s390x/virtio-ccw-crypto.c          | 1 +
 hw/s390x/virtio-ccw-gpu.c             | 1 +
 hw/s390x/virtio-ccw-input.c           | 1 +
 hw/s390x/virtio-ccw-net.c             | 1 +
 hw/s390x/virtio-ccw-rng.c             | 1 +
 hw/s390x/virtio-ccw-scsi.c            | 1 +
 hw/s390x/virtio-ccw-serial.c          | 1 +
 hw/scsi/megasas.c                     | 1 +
 hw/scsi/mptsas.c                      | 1 +
 hw/scsi/scsi-bus.c                    | 2 +-
 hw/scsi/scsi-disk.c                   | 1 +
 hw/scsi/scsi-generic.c                | 1 +
 hw/scsi/spapr_vscsi.c                 | 2 +-
 hw/scsi/vhost-scsi.c                  | 1 +
 hw/scsi/vhost-user-scsi.c             | 1 +
 hw/scsi/virtio-scsi.c                 | 1 +
 hw/scsi/vmw_pvscsi.c                  | 1 +
 hw/sd/milkymist-memcard.c             | 1 +
 hw/sd/pxa2xx_mmci.c                   | 1 -
 hw/sd/sd.c                            | 1 -
 hw/sd/sdhci-pci.c                     | 1 +
 hw/sd/sdhci.c                         | 1 +
 hw/sd/ssi-sd.c                        | 1 +
 hw/sh4/r2d.c                          | 1 +
 hw/sparc/leon3.c                      | 1 +
 hw/sparc/sun4m.c                      | 1 +
 hw/sparc/sun4m_iommu.c                | 1 +
 hw/sparc64/sun4u.c                    | 1 +
 hw/ssi/aspeed_smc.c                   | 1 +
 hw/ssi/xilinx_spi.c                   | 1 +
 hw/ssi/xilinx_spips.c                 | 1 +
 hw/timer/a9gtimer.c                   | 1 +
 hw/timer/allwinner-a10-pit.c          | 1 +
 hw/timer/altera_timer.c               | 1 +
 hw/timer/arm_mptimer.c                | 1 +
 hw/timer/arm_timer.c                  | 2 +-
 hw/timer/cmsdk-apb-dualtimer.c        | 1 +
 hw/timer/exynos4210_mct.c             | 1 +
 hw/timer/grlib_gptimer.c              | 1 +
 hw/timer/lm32_timer.c                 | 1 +
 hw/timer/m48t59-isa.c                 | 1 +
 hw/timer/m48t59.c                     | 1 +
 hw/timer/mc146818rtc.c                | 1 +
 hw/timer/milkymist-sysctl.c           | 1 +
 hw/timer/mss-timer.c                  | 1 +
 hw/timer/pl031.c                      | 1 +
 hw/timer/pxa2xx_timer.c               | 1 +
 hw/timer/slavio_timer.c               | 1 +
 hw/timer/stm32f2xx_timer.c            | 1 +
 hw/timer/xilinx_timer.c               | 1 +
 hw/tpm/tpm_crb.c                      | 2 --
 hw/tpm/tpm_tis.c                      | 1 +
 hw/tpm/tpm_util.c                     | 2 +-
 hw/usb/bus.c                          | 2 +-
 hw/usb/ccid-card-emulated.c           | 1 +
 hw/usb/ccid-card-passthru.c           | 1 +
 hw/usb/ccid.h                         | 2 +-
 hw/usb/dev-audio.c                    | 1 +
 hw/usb/dev-hid.c                      | 1 +
 hw/usb/dev-hub.c                      | 1 +
 hw/usb/dev-mtp.c                      | 1 +
 hw/usb/dev-network.c                  | 1 +
 hw/usb/dev-serial.c                   | 1 +
 hw/usb/dev-smartcard-reader.c         | 1 +
 hw/usb/dev-storage.c                  | 1 +
 hw/usb/dev-uas.c                      | 1 +
 hw/usb/hcd-ehci-pci.c                 | 1 +
 hw/usb/hcd-ehci-sysbus.c              | 1 +
 hw/usb/hcd-ohci-pci.c                 | 1 +
 hw/usb/hcd-ohci.c                     | 1 +
 hw/usb/hcd-uhci.c                     | 1 +
 hw/usb/hcd-xhci-nec.c                 | 1 +
 hw/usb/hcd-xhci.c                     | 1 +
 hw/usb/host-libusb.c                  | 1 +
 hw/usb/redirect.c                     | 1 +
 hw/vfio/ap.c                          | 1 +
 hw/vfio/ccw.c                         | 1 +
 hw/vfio/pci-quirks.c                  | 1 +
 hw/vfio/pci.c                         | 1 +
 hw/vfio/platform.c                    | 1 +
 hw/virtio/vhost-scsi-pci.c            | 1 +
 hw/virtio/vhost-user-blk-pci.c        | 1 +
 hw/virtio/vhost-user-scsi-pci.c       | 1 +
 hw/virtio/vhost-vsock-pci.c           | 1 +
 hw/virtio/vhost-vsock.c               | 1 +
 hw/virtio/virtio-9p-pci.c             | 1 +
 hw/virtio/virtio-balloon-pci.c        | 1 +
 hw/virtio/virtio-balloon.c            | 1 +
 hw/virtio/virtio-blk-pci.c            | 1 +
 hw/virtio/virtio-bus.c                | 1 -
 hw/virtio/virtio-crypto-pci.c         | 1 +
 hw/virtio/virtio-crypto.c             | 2 +-
 hw/virtio/virtio-input-pci.c          | 1 +
 hw/virtio/virtio-mmio.c               | 1 +
 hw/virtio/virtio-net-pci.c            | 1 +
 hw/virtio/virtio-pci.c                | 1 +
 hw/virtio/virtio-pmem.c               | 1 +
 hw/virtio/virtio-rng.c                | 2 +-
 hw/virtio/virtio-scsi-pci.c           | 1 +
 hw/virtio/virtio-serial-pci.c         | 1 +
 hw/virtio/virtio.c                    | 1 +
 hw/watchdog/cmsdk-apb-watchdog.c      | 1 +
 hw/watchdog/wdt_aspeed.c              | 1 +
 hw/xen/xen-bus.c                      | 1 +
 hw/xen/xen-legacy-backend.c           | 1 +
 hw/xen/xen_pt.c                       | 1 +
 hw/xtensa/xtfpga.c                    | 1 +
 include/hw/acpi/acpi_dev_interface.h  | 1 +
 include/hw/acpi/vmgenid.h             | 2 +-
 include/hw/audio/pcspk.h              | 1 +
 include/hw/boards.h                   | 1 -
 include/hw/char/cadence_uart.h        | 1 +
 include/hw/char/cmsdk-apb-uart.h      | 1 +
 include/hw/char/lm32_juart.h          | 2 +-
 include/hw/char/pl011.h               | 1 +
 include/hw/char/xilinx_uartlite.h     | 1 +
 include/hw/cpu/cluster.h              | 2 +-
 include/hw/cpu/core.h                 | 2 +-
 include/hw/cris/etraxfs.h             | 1 +
 include/hw/display/milkymist_tmu2.h   | 2 +-
 include/hw/i2c/i2c.h                  | 2 +-
 include/hw/i386/intel_iommu.h         | 2 +-
 include/hw/input/adb.h                | 2 +-
 include/hw/ipack/ipack.h              | 2 +-
 include/hw/ipmi/ipmi.h                | 2 +-
 include/hw/isa/isa.h                  | 2 +-
 include/hw/mem/memory-device.h        | 2 +-
 include/hw/mem/pc-dimm.h              | 2 +-
 include/hw/misc/auxbus.h              | 2 +-
 include/hw/misc/unimp.h               | 1 +
 include/hw/misc/vmcoreinfo.h          | 2 +-
 include/hw/net/ne2000-isa.h           | 2 +-
 include/hw/pci/pci.h                  | 1 -
 include/hw/pcmcia.h                   | 2 +-
 include/hw/ppc/openpic.h              | 1 -
 include/hw/ppc/spapr_cpu_core.h       | 2 +-
 include/hw/ppc/spapr_drc.h            | 2 +-
 include/hw/ppc/xics.h                 | 2 +-
 include/hw/ppc/xive.h                 | 1 -
 include/hw/qdev.h                     | 7 -------
 include/hw/s390x/event-facility.h     | 2 +-
 include/hw/s390x/sclp.h               | 1 -
 include/hw/s390x/storage-attributes.h | 2 +-
 include/hw/s390x/storage-keys.h       | 2 +-
 include/hw/s390x/tod.h                | 2 +-
 include/hw/scsi/scsi.h                | 2 +-
 include/hw/sd/sd.h                    | 2 +-
 include/hw/sparc/grlib.h              | 1 -
 include/hw/ssi/ssi.h                  | 2 +-
 include/hw/sysbus.h                   | 2 +-
 include/hw/timer/cmsdk-apb-timer.h    | 1 +
 include/hw/timer/i8254.h              | 2 +-
 include/hw/usb.h                      | 2 +-
 include/hw/virtio/vhost-scsi-common.h | 1 -
 include/hw/virtio/vhost-scsi.h        | 1 -
 include/hw/virtio/vhost-user-blk.h    | 1 -
 include/hw/virtio/vhost-user-scsi.h   | 1 -
 include/hw/virtio/virtio-bus.h        | 2 +-
 include/hw/virtio/virtio-serial.h     | 1 -
 include/hw/virtio/virtio.h            | 2 +-
 include/hw/watchdog/wdt_diag288.h     | 2 +-
 include/monitor/qdev.h                | 2 --
 include/sysemu/accel.h                | 1 -
 memory.c                              | 1 -
 migration/migration.c                 | 1 +
 migration/migration.h                 | 2 +-
 net/net.c                             | 2 +-
 qdev-monitor.c                        | 1 -
 qom/qom-qmp-cmds.c                    | 2 +-
 qtest.c                               | 1 -
 target/tilegx/cpu.c                   | 1 -
 tests/test-qdev-global-props.c        | 2 +-
 vl.c                                  | 2 +-
 497 files changed, 461 insertions(+), 117 deletions(-)
 delete mode 100644 include/hw/qdev.h

diff --git a/backends/vhost-user.c b/backends/vhost-user.c
index 2b055544a7..0a13506c98 100644
--- a/backends/vhost-user.c
+++ b/backends/vhost-user.c
@@ -12,7 +12,6 @@
=20
=20
 #include "qemu/osdep.h"
-#include "hw/qdev.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index a3288cbe56..b5a7c03f26 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -17,6 +17,7 @@
 #include "virtio-9p.h"
 #include "fsdev/qemu-fsdev.h"
 #include "coth.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-access.h"
 #include "qemu/iov.h"
 #include "qemu/module.h"
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index ec47a9143b..3ff35a49e4 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -25,6 +25,7 @@
 #include "hw/isa/apm.h"
 #include "hw/i2c/pm_smbus.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "hw/acpi/acpi.h"
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index 1e38e21cb7..4eae426969 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -18,6 +18,7 @@
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/vmgenid.h"
 #include "hw/nvram/fw_cfg.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 4b2d8b6574..7a3c48f002 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -14,6 +14,7 @@
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
 #include "hw/loader.h"
+#include "hw/qdev-properties.h"
 #include "elf.h"
 #include "sysemu/qtest.h"
 #include "sysemu/reset.h"
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 843b708247..7a2e885e0b 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -20,6 +20,7 @@
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/misc/pca9552.h"
 #include "hw/misc/tmp105.h"
+#include "hw/qdev-properties.h"
 #include "qemu/log.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/arm/digic.c b/hw/arm/digic.c
index 9015b60c23..4f52465875 100644
--- a/hw/arm/digic.c
+++ b/hw/arm/digic.c
@@ -24,6 +24,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/arm/digic.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/sysemu.h"
=20
 #define DIGIC4_TIMER_BASE(n)    (0xc0210000 + (n) * 0x100)
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 9aa5ec3f5d..0e403f3e78 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -32,6 +32,7 @@
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
 #include "hw/loader.h"
+#include "hw/qdev-properties.h"
 #include "hw/arm/exynos4210.h"
 #include "hw/sd/sdhci.h"
 #include "hw/usb/hcd-ehci.h"
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 7624e16084..f69358a5ba 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -33,6 +33,7 @@
 #include "exec/address-spaces.h"
 #include "hw/arm/exynos4210.h"
 #include "hw/net/lan9118.h"
+#include "hw/qdev-properties.h"
 #include "hw/boards.h"
 #include "hw/irq.h"
=20
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 869ee89b15..098e84c84d 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -29,6 +29,7 @@
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
+#include "hw/qdev-properties.h"
 #include "chardev/char.h"
=20
 static void fsl_imx25_init(Object *obj)
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 662fe78f1b..093ad40984 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -26,6 +26,7 @@
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
+#include "hw/qdev-properties.h"
 #include "chardev/char.h"
=20
 static void fsl_imx31_init(Object *obj)
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index de45833097..8c397ef04b 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -23,6 +23,7 @@
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx6.h"
 #include "hw/boards.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/sysemu.h"
 #include "chardev/char.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 1f6f4aed97..0276875f02 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx6ul.h"
 #include "hw/boards.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
 #include "sysemu/qtest.h"
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 72eab03a0c..97b8bb788a 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -16,6 +16,7 @@
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx7.h"
 #include "hw/boards.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
 #include "sysemu/qtest.h"
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index e9a891f7d3..ef213695bd 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -17,6 +17,7 @@
=20
 #include "hw/arm/nrf51_soc.h"
 #include "hw/i2c/microbit_i2c.h"
+#include "hw/qdev-properties.h"
=20
 typedef struct {
     MachineState parent;
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 2c9984bb3b..dbd35b6def 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -27,6 +27,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/boards.h"
+#include "hw/qdev-properties.h"
 #include "hw/arm/boot.h"
 #include "exec/address-spaces.h"
 #include "hw/arm/msf2-soc.h"
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index a3cfdc3077..92fbe74d74 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -22,6 +22,7 @@
 #include "hw/hw.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
+#include "hw/qdev-properties.h"
 #include "hw/block/flash.h"
 #include "ui/console.h"
 #include "hw/i2c/i2c.h"
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index f57fc38f92..e770d9cac8 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/boards.h"
+#include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f205_soc.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 3f3eca52e2..af99ff4522 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -35,6 +35,7 @@
 #include "hw/input/tsc2xxx.h"
 #include "hw/misc/cbus.h"
 #include "hw/misc/tmp105.h"
+#include "hw/qdev-properties.h"
 #include "hw/block/flash.h"
 #include "hw/hw.h"
 #include "hw/bt.h"
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index ce9247118e..19fca4159a 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -26,6 +26,7 @@
 #include "hw/boards.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/omap.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index af5e3d0ba7..dccb5707f8 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -26,6 +26,7 @@
 #include "sysemu/reset.h"
 #include "hw/boards.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/omap.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 4e99c30e11..cdafde2f76 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -20,6 +20,7 @@
 #include "hw/char/serial.h"
 #include "hw/i2c/i2c.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/ssi/ssi.h"
 #include "chardev/char-fe.h"
 #include "sysemu/blockdev.h"
diff --git a/hw/arm/pxa2xx_gpio.c b/hw/arm/pxa2xx_gpio.c
index aa2c89dcf9..86a0e86c4c 100644
--- a/hw/arm/pxa2xx_gpio.c
+++ b/hw/arm/pxa2xx_gpio.c
@@ -11,6 +11,7 @@
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/arm/pxa.h"
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 934f4c9261..a6185c169e 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx6.h"
 #include "hw/boards.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
 #include "sysemu/qtest.h"
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 9c67d5c6f9..2a0e2ed1d0 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -36,6 +36,7 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/loader.h"
 #include "hw/pci-host/gpex.h"
+#include "hw/qdev-properties.h"
 #include "hw/usb.h"
 #include "net/net.h"
=20
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index 2eabb9c814..ee010c48b2 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -16,6 +16,7 @@
 #include "hw/arm/boot.h"
 #include "sysemu/sysemu.h"
 #include "hw/pcmcia.h"
+#include "hw/qdev-properties.h"
 #include "hw/i2c/i2c.h"
 #include "hw/irq.h"
 #include "hw/ssi/ssi.h"
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index c08041a1c5..be8b7df679 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -28,6 +28,7 @@
 #include "hw/arm/boot.h"
 #include "exec/address-spaces.h"
 #include "hw/arm/stm32f205_soc.h"
+#include "hw/qdev-properties.h"
=20
 /* At the moment only Timer 2 to 5 are modelled */
 static const uint32_t timer_addr[STM_NUM_TIMERS] =3D { 0x40000000, 0x400=
00400,
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index ca377df9e3..dc65d88a65 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -32,6 +32,7 @@
 #include "cpu.h"
 #include "hw/boards.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "strongarm.h"
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0e5152ed3b..e9fddec058 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -54,6 +54,7 @@
 #include "hw/pci-host/gpex.h"
 #include "hw/arm/sysbus-fdt.h"
 #include "hw/platform-bus.h"
+#include "hw/qdev-properties.h"
 #include "hw/arm/fdt.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/intc/arm_gicv3_common.h"
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 9af584fb12..115ee51c7c 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -21,6 +21,7 @@
 #include "hw/audio/soundhw.h"
 #include "audio/audio.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "sysemu/dma.h"
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index 62e59ccee6..2f4aacbf43 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -28,6 +28,7 @@
 #include "hw/audio/soundhw.h"
 #include "audio/audio.h"
 #include "hw/isa/isa.h"
+#include "hw/qdev-properties.h"
=20
 //#define DEBUG
=20
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 383200e1e2..d77a4e713e 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -27,7 +27,7 @@
 #include "audio/audio.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
-#include "hw/qdev.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index 787e04774a..dbfe7cf634 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -29,6 +29,7 @@
 #include "audio/audio.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "gusemu.h"
 #include "gustate.h"
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 4c33c477e1..4fee0673d9 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -19,6 +19,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "intel-hda.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 5a1fcded55..6ecd383540 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -19,6 +19,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "hw/pci/msi.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
diff --git a/hw/audio/intel-hda.h b/hw/audio/intel-hda.h
index 53b78da4df..eee6fee5af 100644
--- a/hw/audio/intel-hda.h
+++ b/hw/audio/intel-hda.h
@@ -1,7 +1,7 @@
 #ifndef HW_INTEL_HDA_H
 #define HW_INTEL_HDA_H
=20
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
=20
 /* ---------------------------------------------------------------------=
 */
 /* hda bus                                                              =
 */
diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
index 158a456a41..883ef74c8b 100644
--- a/hw/audio/marvell_88w8618.c
+++ b/hw/audio/marvell_88w8618.c
@@ -14,6 +14,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/audio/wm8750.h"
 #include "audio/audio.h"
 #include "qapi/error.h"
diff --git a/hw/audio/pl041.c b/hw/audio/pl041.c
index 3c371397de..ca91399078 100644
--- a/hw/audio/pl041.c
+++ b/hw/audio/pl041.c
@@ -22,6 +22,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 818659546f..3ad01f3599 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -27,7 +27,7 @@
 #include "audio/audio.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
-#include "hw/qdev.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "qemu/host-utils.h"
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index e80439482c..ac5d31e8c1 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -34,6 +34,7 @@
 #include "qemu/timer.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/block/block.h"
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index c213e2ed7b..47159de3a4 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -24,6 +24,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "sysemu/block-backend.h"
+#include "hw/qdev-properties.h"
 #include "hw/ssi/ssi.h"
 #include "migration/vmstate.h"
 #include "qemu/bitops.h"
diff --git a/hw/block/nand.c b/hw/block/nand.c
index 4a0d4677c3..e396004315 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -20,9 +20,9 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/qdev-properties.h"
 #include "hw/block/flash.h"
 #include "sysemu/block-backend.h"
-#include "hw/qdev.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index e08853fe5e..12d8254250 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -30,6 +30,7 @@
 #include "hw/block/block.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index 18123f0499..fcc5a69b90 100644
--- a/hw/block/onenand.c
+++ b/hw/block/onenand.c
@@ -23,6 +23,7 @@
 #include "hw/hw.h"
 #include "hw/block/flash.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/block-backend.h"
 #include "exec/memory.h"
 #include "hw/sysbus.h"
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 7bfe9de2a3..de6efe1893 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -39,6 +39,7 @@
 #include "qemu/osdep.h"
 #include "hw/block/block.h"
 #include "hw/block/flash.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 18ea50f4ba..4baca701b7 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -35,6 +35,7 @@
 #include "qemu/osdep.h"
 #include "hw/block/block.h"
 #include "hw/block/flash.h"
+#include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/bitmap.h"
 #include "qemu/timer.h"
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 85bc4017e7..7b44cca6d9 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -22,6 +22,7 @@
 #include "qemu/cutils.h"
 #include "qom/object.h"
 #include "hw/qdev-core.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-user-blk.h"
 #include "hw/virtio/virtio.h"
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 1f40834d27..8cc2a232e0 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -18,6 +18,7 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "hw/block/block.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/blockdev.h"
 #include "hw/virtio/virtio-blk.h"
 #include "dataplane/virtio-blk.h"
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index aef39536ac..f77343db60 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -20,6 +20,7 @@
 #include "qapi/qmp/qstring.h"
 #include "hw/xen/xen_common.h"
 #include "hw/block/xen_blkif.h"
+#include "hw/qdev-properties.h"
 #include "hw/xen/xen-block.h"
 #include "hw/xen/xen-backend.h"
 #include "sysemu/blockdev.h"
diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 45fc34d92d..3f855196e3 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -23,6 +23,7 @@
 #include "qemu/osdep.h"
 #include "hw/char/bcm2835_aux.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/char/debugcon.c b/hw/char/debugcon.c
index b38d82891f..5c592e091b 100644
--- a/hw/char/debugcon.c
+++ b/hw/char/debugcon.c
@@ -29,6 +29,7 @@
 #include "qemu/module.h"
 #include "chardev/char-fe.h"
 #include "hw/isa/isa.h"
+#include "hw/qdev-properties.h"
=20
 #define TYPE_ISA_DEBUGCON_DEVICE "isa-debugcon"
 #define ISA_DEBUGCON_DEVICE(obj) \
diff --git a/hw/char/digic-uart.c b/hw/char/digic-uart.c
index cc501678ce..974a2619dd 100644
--- a/hw/char/digic-uart.c
+++ b/hw/char/digic-uart.c
@@ -34,6 +34,7 @@
 #include "qemu/module.h"
=20
 #include "hw/char/digic-uart.h"
+#include "hw/qdev-properties.h"
=20
 enum {
     ST_RX_RDY =3D (1 << 0),
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 35c6952bbd..e185522e27 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/char/etraxfs_ser.c b/hw/char/etraxfs_ser.c
index e93f31c76a..15ac12ef22 100644
--- a/hw/char/etraxfs_ser.c
+++ b/hw/char/etraxfs_ser.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qemu/log.h"
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 9bd826b33d..49e279d5df 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -30,6 +30,7 @@
=20
 #include "hw/arm/exynos4210.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
=20
 #undef DEBUG_UART
 #undef DEBUG_UART_EXTEND
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index 13013e8a1c..fe3cbf41a3 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/sparc/grlib.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index bf3f07d760..e49baa994c 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "hw/char/imx_serial.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index 1171dc20cf..66c163ba26 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "hw/ipack/ipack.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/bitops.h"
 #include "qemu/module.h"
diff --git a/hw/char/lm32_juart.c b/hw/char/lm32_juart.c
index 69dd7ac72b..e0b1bd6555 100644
--- a/hw/char/lm32_juart.c
+++ b/hw/char/lm32_juart.c
@@ -25,6 +25,7 @@
 #include "chardev/char-fe.h"
=20
 #include "hw/char/lm32_juart.h"
+#include "hw/qdev-properties.h"
=20
 enum {
     LM32_JUART_MIN_SAVE_VERSION =3D 0,
diff --git a/hw/char/lm32_uart.c b/hw/char/lm32_uart.c
index 00832fba86..32f29c44cf 100644
--- a/hw/char/lm32_uart.c
+++ b/hw/char/lm32_uart.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index 1712b2296e..58323baf43 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -11,6 +11,7 @@
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "hw/m68k/mcf.h"
+#include "hw/qdev-properties.h"
 #include "chardev/char-fe.h"
=20
 typedef struct {
diff --git a/hw/char/milkymist-uart.c b/hw/char/milkymist-uart.c
index e90f84d53e..c358ca07f3 100644
--- a/hw/char/milkymist-uart.c
+++ b/hw/char/milkymist-uart.c
@@ -23,6 +23,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c
index bb886f12aa..2777afe366 100644
--- a/hw/char/nrf51_uart.c
+++ b/hw/char/nrf51_uart.c
@@ -17,6 +17,7 @@
 #include "qemu/module.h"
 #include "hw/char/nrf51_uart.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "trace.h"
=20
diff --git a/hw/char/parallel-isa.c b/hw/char/parallel-isa.c
index a043832e72..bcc577f61c 100644
--- a/hw/char/parallel-isa.c
+++ b/hw/char/parallel-isa.c
@@ -8,9 +8,11 @@
  *
  * SPDX-License-Identifier: MIT
  */
+
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
 #include "hw/isa/isa.h"
+#include "hw/qdev-properties.h"
 #include "hw/char/parallel.h"
=20
 static void parallel_init(ISABus *bus, int index, Chardev *chr)
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 3980eb5909..40174eeda1 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -30,6 +30,7 @@
 #include "chardev/char-fe.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/char/parallel.h"
 #include "sysemu/reset.h"
diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index d904265cda..392606259d 100644
--- a/hw/char/sclpconsole-lm.c
+++ b/hw/char/sclpconsole-lm.c
@@ -14,7 +14,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/qdev.h"
 #include "qemu/thread.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
@@ -23,6 +22,7 @@
 #include "hw/s390x/sclp.h"
 #include "migration/vmstate.h"
 #include "hw/s390x/event-facility.h"
+#include "hw/qdev-properties.h"
 #include "hw/s390x/ebcdic.h"
=20
 #define SIZE_BUFFER 4096
diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
index f3669766bf..da126f0133 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -13,13 +13,13 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/qdev.h"
 #include "qemu/thread.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
=20
 #include "hw/s390x/sclp.h"
 #include "migration/vmstate.h"
+#include "hw/qdev-properties.h"
 #include "hw/s390x/event-facility.h"
 #include "chardev/char-fe.h"
=20
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index d3080b76e4..5a0ae02ee7 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -28,6 +28,7 @@
 #include "qemu/module.h"
 #include "hw/char/serial.h"
 #include "hw/isa/isa.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
=20
 #define ISA_SERIAL(obj) OBJECT_CHECK(ISASerialState, (obj), TYPE_ISA_SER=
IAL)
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 867e7840b4..5f13b5663b 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -32,6 +32,7 @@
 #include "hw/char/serial.h"
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
=20
 #define PCI_SERIAL_MAX_PORTS 4
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index ee537890c2..cb9b76e22b 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -31,6 +31,7 @@
 #include "hw/char/serial.h"
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
=20
 typedef struct PCISerialState {
diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index b3995a9e0c..7f860fcce7 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -3,12 +3,12 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "hw/qdev.h"
 #include "migration/vmstate.h"
 #include "chardev/char-fe.h"
 #include "hw/irq.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
+#include "hw/qdev-properties.h"
=20
 #define VTERM_BUFSIZE   16
=20
diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index f43eb74fb1..4ec843de38 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/char/stm32f2xx_usart.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index 3785886c25..6859c1bcb2 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -15,6 +15,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "chardev/char-fe.h"
+#include "hw/qdev-properties.h"
 #include "hw/s390x/3270-ccw.h"
=20
 /* Enough spaces for different window sizes. */
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 1bbeb00fae..c13649f1ef 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -15,6 +15,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "trace.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-serial.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-char.h"
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 272cfb6049..4e0ed829ae 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -27,6 +27,7 @@
 #include "monitor/monitor.h"
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "trace.h"
 #include "hw/virtio/virtio-serial.h"
diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index fa7451fd67..2c47275068 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "chardev/char-fe.h"
diff --git a/hw/core/bus.c b/hw/core/bus.c
index 17bc1edcde..7f3d2a3dbd 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -18,9 +18,9 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
 #include "qemu/ctype.h"
 #include "qemu/module.h"
-#include "hw/qdev.h"
 #include "qapi/error.h"
=20
 void qbus_set_hotplug_handler(BusState *bus, Object *handler, Error **er=
rp)
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index 579fe5ed32..06d8d6466e 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -36,6 +36,7 @@
 #include "sysemu/dma.h"
 #include "sysemu/reset.h"
 #include "hw/loader.h"
+#include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/core/generic-loader.h"
diff --git a/hw/core/or-irq.c b/hw/core/or-irq.c
index 02949dae1a..18d63831cd 100644
--- a/hw/core/or-irq.c
+++ b/hw/core/or-irq.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/or-irq.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
=20
diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index 5fecb29239..9c9a9c271f 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -21,6 +21,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/platform-bus.h"
+#include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/core/qdev-fw.c b/hw/core/qdev-fw.c
index aa35e9d0ac..a31958355f 100644
--- a/hw/core/qdev-fw.c
+++ b/hw/core/qdev-fw.c
@@ -16,8 +16,8 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/qdev.h"
 #include "hw/fw-path-provider.h"
+#include "hw/qdev-core.h"
=20
 const char *qdev_fw_name(DeviceState *dev)
 {
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-s=
ystem.c
index ba412dd2ca..fceab9afd5 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -12,7 +12,7 @@
=20
 #include "qemu/osdep.h"
 #include "net/net.h"
-#include "hw/qdev.h"
+#include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "sysemu/block-backend.h"
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 8510ad14b0..ac28890e5a 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "net/net.h"
-#include "hw/qdev.h"
+#include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "hw/pci/pci.h"
 #include "qapi/qapi-types-block.h"
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index b1fe40d20d..8c055df1cb 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -26,7 +26,6 @@
    this API directly.  */
=20
 #include "qemu/osdep.h"
-#include "hw/qdev.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-qdev.h"
@@ -36,6 +35,7 @@
 #include "qemu/option.h"
 #include "hw/hotplug.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/boards.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/core/register.c b/hw/core/register.c
index bb5ab9d479..3c77396587 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -17,7 +17,6 @@
=20
 #include "qemu/osdep.h"
 #include "hw/register.h"
-#include "hw/qdev.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/core/split-irq.c b/hw/core/split-irq.c
index 6808e812b5..b5acc669fb 100644
--- a/hw/core/split-irq.c
+++ b/hw/core/split-irq.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/split-irq.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
=20
diff --git a/hw/core/vm-change-state-handler.c b/hw/core/vm-change-state-=
handler.c
index f814813bdd..e27ea45977 100644
--- a/hw/core/vm-change-state-handler.c
+++ b/hw/core/vm-change-state-handler.c
@@ -16,7 +16,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
=20
 static int qdev_get_dev_tree_depth(DeviceState *dev)
 {
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index fc19ed0214..7e9983aa19 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -23,6 +23,7 @@
 #include "qemu/module.h"
 #include "hw/cpu/a15mpcore.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
=20
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 9dda4d8888..cd1e165faf 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -13,6 +13,7 @@
 #include "qemu/module.h"
 #include "hw/cpu/a9mpcore.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "qom/cpu.h"
=20
 static void a9mp_priv_set_irq(void *opaque, int irq, int level)
diff --git a/hw/cpu/arm11mpcore.c b/hw/cpu/arm11mpcore.c
index c611a6ff32..e78f5d080c 100644
--- a/hw/cpu/arm11mpcore.c
+++ b/hw/cpu/arm11mpcore.c
@@ -13,6 +13,7 @@
 #include "hw/cpu/arm11mpcore.h"
 #include "hw/intc/realview_gic.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
=20
=20
 static void mpcore_priv_set_irq(void *opaque, int irq, int level)
diff --git a/hw/cpu/cluster.c b/hw/cpu/cluster.c
index 6f5f037b3c..74d8d43c00 100644
--- a/hw/cpu/cluster.c
+++ b/hw/cpu/cluster.c
@@ -20,6 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/cpu/cluster.h"
+#include "hw/qdev-properties.h"
 #include "qom/cpu.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/cpu/realview_mpcore.c b/hw/cpu/realview_mpcore.c
index 34da446d94..ae2c9913f6 100644
--- a/hw/cpu/realview_mpcore.c
+++ b/hw/cpu/realview_mpcore.c
@@ -14,6 +14,7 @@
 #include "hw/cpu/arm11mpcore.h"
 #include "hw/intc/realview_gic.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
=20
 #define TYPE_REALVIEW_MPCORE_RIRQ "realview_mpcore"
 #define REALVIEW_MPCORE_RIRQ(obj) \
diff --git a/hw/display/ati.c b/hw/display/ati.c
index df978a420d..35f49a591b 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "ati_int.h"
 #include "ati_regs.h"
+#include "hw/qdev-properties.h"
 #include "vga_regs.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index e606893f28..8f856878cd 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -31,6 +31,7 @@
 #include "framebuffer.h"
 #include "ui/pixel_ops.h"
 #include "hw/misc/bcm2835_mbox_defs.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index 0a535de40c..01ee814ffa 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -9,6 +9,7 @@
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/display/bochs-vbe.h"
 #include "hw/display/edid.h"
diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 29a8735a38..f90baae4de 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -32,6 +32,7 @@
 #include "migration/vmstate.h"
 #include "hw/irq.h"
 #include "hw/loader.h"
+#include "hw/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 0f5465bc14..cd283e53b4 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -39,6 +39,7 @@
 #include "qapi/error.h"
 #include "trace.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "ui/pixel_ops.h"
 #include "cirrus_vga_internal.h"
diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
index 49f409b638..7ef8e59224 100644
--- a/hw/display/cirrus_vga_isa.c
+++ b/hw/display/cirrus_vga_isa.c
@@ -27,6 +27,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/loader.h"
+#include "hw/qdev-properties.h"
 #include "hw/isa/isa.h"
 #include "cirrus_vga_internal.h"
=20
diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index 1757b777e2..839d26eca1 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -21,6 +21,7 @@
 #include "qemu/units.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "ui/console.h"
diff --git a/hw/display/i2c-ddc.c b/hw/display/i2c-ddc.c
index 3ac85216a5..fc70b7930c 100644
--- a/hw/display/i2c-ddc.c
+++ b/hw/display/i2c-ddc.c
@@ -20,6 +20,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/i2c/i2c.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/display/i2c-ddc.h"
=20
diff --git a/hw/display/milkymist-vgafb.c b/hw/display/milkymist-vgafb.c
index 9a9a481ebd..8b0da4660a 100644
--- a/hw/display/milkymist-vgafb.c
+++ b/hw/display/milkymist-vgafb.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "trace.h"
 #include "ui/console.h"
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 539ede12c0..971c2d0568 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -29,6 +29,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "sysemu/sysemu.h"
+#include "hw/qdev-properties.h"
 #include "migration/blocker.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.=
c
index 56215ef88c..ebd623a669 100644
--- a/hw/display/ramfb-standalone.c
+++ b/hw/display/ramfb-standalone.c
@@ -2,6 +2,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/loader.h"
+#include "hw/qdev-properties.h"
 #include "hw/isa/isa.h"
 #include "hw/display/ramfb.h"
 #include "ui/console.h"
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 603396358d..d9e5762e36 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -34,6 +34,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "hw/i2c/i2c.h"
 #include "hw/display/i2c-ddc.h"
 #include "qemu/range.h"
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index f9b1ae56ec..14e829d3fa 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -28,6 +28,7 @@
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
 #include "hw/loader.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
diff --git a/hw/display/vga-isa.c b/hw/display/vga-isa.c
index 189a4afc15..873e5e9706 100644
--- a/hw/display/vga-isa.c
+++ b/hw/display/vga-isa.c
@@ -31,6 +31,7 @@
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/loader.h"
+#include "hw/qdev-properties.h"
=20
 #define TYPE_ISA_VGA "isa-vga"
 #define ISA_VGA(obj) OBJECT_CHECK(ISAVGAState, (obj), TYPE_ISA_VGA)
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index 86299f5e97..a27b88122d 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -26,6 +26,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "vga_int.h"
 #include "ui/pixel_ops.h"
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 7181d9cdba..279877886e 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -11,6 +11,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "chardev/char-fe.h"
 #include "qapi/error.h"
diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index e4c7eb6193..25e4038874 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -15,6 +15,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-gpu-pci.h"
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index ed92071963..6de9689a30 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -24,6 +24,7 @@
 #include "hw/virtio/virtio-gpu-pixman.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/display/edid.h"
+#include "hw/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index e5227fac28..cc6e66ea1c 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index f0b136eb16..23dc8910cc 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -30,6 +30,7 @@
 #include "trace.h"
 #include "ui/vnc.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
=20
 #undef VERBOSE
diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
index 3f0db4a021..b788b3681a 100644
--- a/hw/dma/i82374.c
+++ b/hw/dma/i82374.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/isa/isa.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/dma/i8257.h"
=20
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index c626bd958a..792f617eb4 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/dma/i8257.h"
 #include "qemu/main-loop.h"
diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 3713d5dadd..52ba23f4bf 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -16,6 +16,7 @@
 #include "hw/dma/pl080.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "qapi/error.h"
=20
 #define PL080_CONF_E    0x1
diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index 28830a42a3..f2bb2d9ac1 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -17,6 +17,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
diff --git a/hw/dma/pxa2xx_dma.c b/hw/dma/pxa2xx_dma.c
index 1124051730..18e7a0b694 100644
--- a/hw/dma/pxa2xx_dma.c
+++ b/hw/dma/pxa2xx_dma.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/arm/pxa.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 16d53b92dd..0e5bbcdc7f 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -27,6 +27,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/sparc/sparc32_dma.h"
 #include "hw/sparc/sun4m_iommu.h"
 #include "hw/sysbus.h"
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 2c2d567a95..d176df6d44 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -29,6 +29,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/ptimer.h"
+#include "hw/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 2dbdfc5739..75b660988f 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -29,6 +29,7 @@
 #include "qemu/osdep.h"
 #include "hw/dma/xlnx-zdma.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
diff --git a/hw/gpio/imx_gpio.c b/hw/gpio/imx_gpio.c
index 8792fb5ad4..ac8304ec56 100644
--- a/hw/gpio/imx_gpio.c
+++ b/hw/gpio/imx_gpio.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "hw/gpio/imx_gpio.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/gpio/max7310.c b/hw/gpio/max7310.c
index 87b0f24747..bebb4030d2 100644
--- a/hw/gpio/max7310.c
+++ b/hw/gpio/max7310.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/i2c/i2c.h"
+#include "hw/hw.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index 46a721779c..41e1aa798c 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -20,6 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/arm/omap.h"
 #include "hw/sysbus.h"
 #include "qemu/error-report.h"
diff --git a/hw/hyperv/hyperv_testdev.c b/hw/hyperv/hyperv_testdev.c
index 0d343a8bc0..88a5a63782 100644
--- a/hw/hyperv/hyperv_testdev.c
+++ b/hw/hyperv/hyperv_testdev.c
@@ -15,7 +15,6 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/queue.h"
-#include "hw/qdev.h"
 #include "hw/isa/isa.h"
 #include "hw/hyperv/hyperv.h"
=20
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 25b792fdd0..92cd489069 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -9,6 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "trace.h"
diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
index 34f34e3b05..3ba965a58f 100644
--- a/hw/i2c/omap_i2c.c
+++ b/hw/i2c/omap_i2c.c
@@ -22,6 +22,7 @@
 #include "qemu/module.h"
 #include "hw/i2c/i2c.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/arm/omap.h"
 #include "hw/sysbus.h"
 #include "qemu/error-report.h"
diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 8642f0036d..54c86a0112 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -28,6 +28,7 @@
 #include "hw/boards.h"
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/smbus_slave.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/i2c/smbus_eeprom.h"
=20
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 50fe5cc1a9..75ca6f9c70 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -28,6 +28,7 @@
 #include "intel_iommu_internal.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
+#include "hw/qdev-properties.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/apic-msidef.h"
 #include "hw/boards.h"
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index d98cf9d5d1..d6a5325f0b 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -24,6 +24,7 @@
 #include "migration/vmstate.h"
 #include "hw/sysbus.h"
 #include "hw/kvm/clock.h"
+#include "hw/qdev-properties.h"
 #include "qapi/error.h"
=20
 #include <linux/kvm.h>
diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index 99ef530967..f94729c565 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -14,6 +14,7 @@
 #include "monitor/monitor.h"
 #include "hw/i386/pc.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/i386/ioapic_internal.h"
 #include "hw/i386/apic_internal.h"
 #include "sysemu/kvm.h"
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 060b47f845..8777c9618b 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -40,6 +40,7 @@
 #include "kvm_i386.h"
 #include "hw/kvm/clock.h"
 #include "hw/pci-host/q35.h"
+#include "hw/qdev-properties.h"
 #include "exec/address-spaces.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/ich9.h"
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index defea37fe4..235928452b 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -34,6 +34,7 @@
 #include "hw/i386/pc.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/sysemu.h"
 #include "hw/block/flash.h"
 #include "sysemu/kvm.h"
diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index 4f81504577..012ab90396 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -26,7 +26,7 @@
 #include "ui/console.h"
 #include "hw/i386/pc.h"
 #include "hw/input/i8042.h"
-#include "hw/qdev.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
=20
 /* debug only vmmouse */
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 26fcbe3827..1f31e27c8a 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -26,7 +26,6 @@
 #include "hw/i386/pc.h"
 #include "hw/input/i8042.h"
 #include "sysemu/hw_accel.h"
-#include "hw/qdev.h"
 #include "qemu/log.h"
 #include "trace.h"
=20
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index d1534c1ae0..1eaf2dd1bc 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -21,6 +21,7 @@
 #include "hw/sysbus.h"
 #include "hw/boards.h"
 #include "hw/i386/x86-iommu.h"
+#include "hw/qdev-properties.h"
 #include "hw/i386/pc.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/i386/xen/xen_pvdevice.c b/hw/i386/xen/xen_pvdevice.c
index 10c89cda41..27f646da06 100644
--- a/hw/i386/xen/xen_pvdevice.c
+++ b/hw/i386/xen/xen_pvdevice.c
@@ -33,6 +33,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "trace.h"
=20
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 378c1f360f..d72da85605 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -24,6 +24,7 @@
 #include "qemu/osdep.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
=20
 #include "qemu/error-report.h"
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index c2ee427f56..3fbfc5ea45 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -25,6 +25,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "hw/isa/isa.h"
diff --git a/hw/ide/isa.c b/hw/ide/isa.c
index 939b473dad..7b6e283679 100644
--- a/hw/ide/isa.c
+++ b/hw/ide/isa.c
@@ -25,6 +25,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "sysemu/dma.h"
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index 44f2ff92bb..79f787c539 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/ppc/mac.h"
 #include "hw/ppc/mac_dbdma.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "hw/misc/macio/macio.h"
diff --git a/hw/ide/mmio.c b/hw/ide/mmio.c
index d2a377f326..7149a9cba6 100644
--- a/hw/ide/mmio.c
+++ b/hw/ide/mmio.c
@@ -30,6 +30,7 @@
 #include "sysemu/dma.h"
=20
 #include "hw/ide/internal.h"
+#include "hw/qdev-properties.h"
=20
 /***********************************************************/
 /* MMIO based ide port
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index d30bdd70ee..39957dd39f 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -25,6 +25,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "hw/ide/internal.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "hw/block/block.h"
diff --git a/hw/input/adb.c b/hw/input/adb.c
index 80ba1259bf..478a90fae2 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/input/adb.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "adb-internal.h"
diff --git a/hw/input/milkymist-softusb.c b/hw/input/milkymist-softusb.c
index 8f6fdf2d97..67fcb3595f 100644
--- a/hw/input/milkymist-softusb.c
+++ b/hw/input/milkymist-softusb.c
@@ -29,6 +29,7 @@
 #include "ui/console.h"
 #include "hw/input/hid.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
=20
diff --git a/hw/input/vhost-user-input.c b/hw/input/vhost-user-input.c
index 6da497b1a8..544452a234 100644
--- a/hw/input/vhost-user-input.c
+++ b/hw/input/vhost-user-input.c
@@ -9,7 +9,6 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
=20
-#include "hw/qdev.h"
 #include "hw/virtio/virtio-input.h"
=20
 static int vhost_input_config_change(struct vhost_dev *dev)
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index f15a063fac..386a363a17 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -8,8 +8,8 @@
 #include "qemu/iov.h"
 #include "qemu/module.h"
=20
-#include "hw/qdev.h"
 #include "hw/virtio/virtio.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-input.h"
=20
 #undef CONFIG_CURSES
diff --git a/hw/input/virtio-input-host.c b/hw/input/virtio-input-host.c
index a54c31eb09..1c3b12ba32 100644
--- a/hw/input/virtio-input-host.c
+++ b/hw/input/virtio-input-host.c
@@ -9,8 +9,8 @@
 #include "qemu/module.h"
 #include "qemu/sockets.h"
=20
-#include "hw/qdev.h"
 #include "hw/virtio/virtio.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-input.h"
=20
 #include <sys/ioctl.h>
diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index 9946394cf4..51617a5885 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -10,8 +10,8 @@
 #include "qemu/module.h"
 #include "trace.h"
=20
-#include "hw/qdev.h"
 #include "hw/virtio/virtio.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-input.h"
=20
 #include "standard-headers/linux/input.h"
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index fbb6e25cf4..aafd8e0e33 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -29,7 +29,7 @@
 #include "trace.h"
 #include "sysemu/hax.h"
 #include "sysemu/kvm.h"
-#include "hw/qdev.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index 5d506bebb5..f0d0d7c467 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -23,6 +23,7 @@
 #include "qemu/module.h"
 #include "gic_internal.h"
 #include "hw/arm/linux-boot-if.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
=20
 static int gic_pre_save(void *opaque)
diff --git a/hw/intc/arm_gicv2m.c b/hw/intc/arm_gicv2m.c
index 2c96d4fba0..6e45f4ff39 100644
--- a/hw/intc/arm_gicv2m.c
+++ b/hw/intc/arm_gicv2m.c
@@ -30,6 +30,7 @@
 #include "hw/sysbus.h"
 #include "hw/irq.h"
 #include "hw/pci/msi.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/kvm.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 12479f94a8..8f5f4c8e94 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -26,6 +26,7 @@
 #include "qemu/module.h"
 #include "qom/cpu.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "gicv3_internal.h"
 #include "hw/arm/linux-boot-if.h"
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 52ac01aba3..d0bd4f1d81 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -22,6 +22,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/intc/arm_gicv3_its_common.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 0c7fc7078b..62ab8b7273 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -18,6 +18,7 @@
 #include "qemu/timer.h"
 #include "hw/intc/armv7m_nvic.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "target/arm/cpu.h"
 #include "exec/exec-all.h"
 #include "qemu/log.h"
diff --git a/hw/intc/etraxfs_pic.c b/hw/intc/etraxfs_pic.c
index 88d3b0c36f..77f652acec 100644
--- a/hw/intc/etraxfs_pic.c
+++ b/hw/intc/etraxfs_pic.c
@@ -26,6 +26,7 @@
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 //#include "pc.h"
 //#include "etraxfs.h"
=20
diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.=
c
index 833e164350..5b33ca6628 100644
--- a/hw/intc/exynos4210_combiner.c
+++ b/hw/intc/exynos4210_combiner.c
@@ -35,6 +35,7 @@
 #include "hw/arm/exynos4210.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
=20
 //#define DEBUG_COMBINER
=20
diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
index 7fa4583b0f..a1b699b6ba 100644
--- a/hw/intc/exynos4210_gic.c
+++ b/hw/intc/exynos4210_gic.c
@@ -25,6 +25,7 @@
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/arm/exynos4210.h"
=20
 enum ExtGicId {
diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index 21c77a5ec1..bc78e1a14f 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -28,6 +28,7 @@
 #include "hw/sysbus.h"
 #include "cpu.h"
=20
+#include "hw/qdev-properties.h"
 #include "hw/sparc/grlib.h"
=20
 #include "trace.h"
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index c7ff2b3274..bd37bb5e68 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/i386/pc.h"
 #include "hw/isa/i8259_internal.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "monitor/monitor.h"
=20
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index c346f50df9..dddd231337 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -28,6 +28,7 @@
 #include "hw/i386/ioapic.h"
 #include "hw/i386/ioapic_internal.h"
 #include "hw/pci/msi.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/kvm.h"
 #include "hw/i386/apic-msidef.h"
 #include "hw/i386/x86-iommu.h"
diff --git a/hw/intc/mips_gic.c b/hw/intc/mips_gic.c
index 6b4322bc5c..524cc3ca45 100644
--- a/hw/intc/mips_gic.c
+++ b/hw/intc/mips_gic.c
@@ -21,6 +21,7 @@
 #include "kvm_mips.h"
 #include "hw/intc/mips_gic.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
=20
 static void mips_gic_set_vp_irq(MIPSGICState *gic, int vp, int pin)
 {
diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
index f740578e7e..854b709ca0 100644
--- a/hw/intc/omap_intc.c
+++ b/hw/intc/omap_intc.c
@@ -20,6 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/arm/omap.h"
 #include "hw/sysbus.h"
 #include "qemu/error-report.h"
diff --git a/hw/intc/ompic.c b/hw/intc/ompic.c
index 8a4a422142..ca9614fda1 100644
--- a/hw/intc/ompic.c
+++ b/hw/intc/ompic.c
@@ -11,6 +11,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "exec/memory.h"
diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 312ac54c7c..c797ba78f3 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -40,6 +40,7 @@
 #include "hw/pci/pci.h"
 #include "hw/ppc/openpic.h"
 #include "hw/ppc/ppc_e500.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/pci/msi.h"
diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
index e91910b331..c09bebedd1 100644
--- a/hw/intc/openpic_kvm.c
+++ b/hw/intc/openpic_kvm.c
@@ -30,6 +30,7 @@
 #include "hw/ppc/openpic.h"
 #include "hw/ppc/openpic_kvm.h"
 #include "hw/pci/msi.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "sysemu/kvm.h"
 #include "qemu/log.h"
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 63b0f461ec..a8caf258fd 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -22,6 +22,7 @@
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/ppc/pnv_xive.h"
 #include "hw/ppc/xive_regs.h"
+#include "hw/qdev-properties.h"
 #include "hw/ppc/ppc.h"
=20
 #include <libfdt.h>
diff --git a/hw/intc/realview_gic.c b/hw/intc/realview_gic.c
index ac22a2abde..73fe8cd815 100644
--- a/hw/intc/realview_gic.c
+++ b/hw/intc/realview_gic.c
@@ -12,6 +12,7 @@
 #include "qemu/module.h"
 #include "hw/intc/realview_gic.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
=20
 static void realview_gic_set_irq(void *opaque, int irq, int level)
 {
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index f97a6e9867..8c4152e0a5 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -17,10 +17,10 @@
 #include "hw/sysbus.h"
 #include "hw/s390x/ioinst.h"
 #include "hw/s390x/s390_flic.h"
+#include "hw/qdev-properties.h"
 #include "hw/s390x/css.h"
 #include "trace.h"
 #include "cpu.h"
-#include "hw/qdev.h"
 #include "qapi/error.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "migration/qemu-file-types.h"
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 2fdd68035a..aad981cb78 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -23,6 +23,7 @@
 #include "hw/ppc/spapr_xive.h"
 #include "hw/ppc/xive.h"
 #include "hw/ppc/xive_regs.h"
+#include "hw/qdev-properties.h"
=20
 /*
  * XIVE Virtualization Controller BAR and Thread Managment BAR that we
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 88709d4b90..b2fca2975c 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -31,6 +31,7 @@
 #include "trace.h"
 #include "qemu/timer.h"
 #include "hw/ppc/xics.h"
+#include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qapi/visitor.h"
diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
index 3a5c7f82f4..e15cb42b36 100644
--- a/hw/intc/xilinx_intc.c
+++ b/hw/intc/xilinx_intc.c
@@ -26,6 +26,7 @@
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
=20
 #define D(x)
=20
diff --git a/hw/intc/xlnx-pmu-iomod-intc.c b/hw/intc/xlnx-pmu-iomod-intc.=
c
index f2ba9b4ada..f9a1401a94 100644
--- a/hw/intc/xlnx-pmu-iomod-intc.c
+++ b/hw/intc/xlnx-pmu-iomod-intc.c
@@ -33,6 +33,7 @@
 #include "qemu/module.h"
 #include "hw/intc/xlnx-pmu-iomod-intc.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
=20
 #ifndef XLNX_PMU_IO_INTC_ERR_DEBUG
 #define XLNX_PMU_IO_INTC_ERR_DEBUG 0
diff --git a/hw/ipack/ipack.c b/hw/ipack/ipack.c
index 9a520806d7..30e16696c0 100644
--- a/hw/ipack/ipack.c
+++ b/hw/ipack/ipack.c
@@ -13,6 +13,7 @@
 #include "qemu/module.h"
 #include "hw/ipack/ipack.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
=20
 IPackDevice *ipack_device_find(IPackBus *bus, int32_t slot)
diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index 2090c6f73a..ff05a889ec 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/ipmi/ipmi.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/sysemu.h"
 #include "qom/object_interfaces.h"
 #include "qapi/error.h"
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index eb2eba891c..4405aa634e 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -35,6 +35,7 @@
 #include "chardev/char-fe.h"
 #include "sysemu/sysemu.h"
 #include "hw/ipmi/ipmi.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
=20
 #define VM_MSG_CHAR        0xA0 /* Marks end of message */
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 91e1484103..246a6d390c 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -29,6 +29,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/loader.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
=20
 #define IPMI_NETFN_CHASSIS            0x00
diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index 33c800acb5..a696096cbb 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -29,6 +29,7 @@
 #include "hw/ipmi/ipmi.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
=20
 /* Control register */
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index 9a1de662ba..374b2a0709 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -29,6 +29,7 @@
 #include "hw/ipmi/ipmi.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
=20
 #define IPMI_KCS_OBF_BIT        0
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index 4c73c2100f..c4e391916c 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -18,6 +18,7 @@
 #include "sysemu/blockdev.h"
 #include "chardev/char.h"
 #include "hw/isa/superio.h"
+#include "hw/qdev-properties.h"
 #include "hw/input/i8042.h"
 #include "hw/char/serial.h"
 #include "trace.h"
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index a037c21104..41452f36b8 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -45,6 +45,7 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/ich9.h"
 #include "hw/pci/pci_bus.h"
+#include "hw/qdev-properties.h"
 #include "exec/address-spaces.h"
 #include "sysemu/sysemu.h"
 #include "qom/cpu.h"
diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index 60845f3ff0..b9bd57471e 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -25,6 +25,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/isa/pc87312.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 7379d90cf4..1bc915405b 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -14,6 +14,7 @@
 #include "hw/isa/vt82c686.h"
 #include "hw/i2c/i2c.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "hw/isa/isa.h"
 #include "hw/isa/superio.h"
 #include "hw/sysbus.h"
diff --git a/hw/lm32/lm32.h b/hw/lm32/lm32.h
index d1514a61b3..98de07acf2 100644
--- a/hw/lm32/lm32.h
+++ b/hw/lm32/lm32.h
@@ -2,6 +2,7 @@
 #define HW_LM32_H
=20
 #include "hw/char/lm32_juart.h"
+#include "hw/qdev-properties.h"
=20
 static inline DeviceState *lm32_pic_init(qemu_irq cpu_irq)
 {
diff --git a/hw/lm32/milkymist-hw.h b/hw/lm32/milkymist-hw.h
index 976cf9254d..5f63024355 100644
--- a/hw/lm32/milkymist-hw.h
+++ b/hw/lm32/milkymist-hw.h
@@ -1,7 +1,7 @@
 #ifndef QEMU_HW_MILKYMIST_HW_H
 #define QEMU_HW_MILKYMIST_HW_H
=20
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
 #include "net/net.h"
=20
 static inline DeviceState *milkymist_uart_create(hwaddr base,
diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 5ec3ae0300..460d322de5 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -30,6 +30,7 @@
 #include "sysemu/reset.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
+#include "hw/qdev-properties.h"
 #include "elf.h"
 #include "milkymist-hw.h"
 #include "hw/display/milkymist_tmu2.h"
diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 5f2c408036..53953fdc3a 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -11,7 +11,6 @@
=20
 #include "qemu/osdep.h"
 #include "hw/mem/memory-device.h"
-#include "hw/qdev.h"
 #include "qapi/error.h"
 #include "hw/boards.h"
 #include "qemu/range.h"
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index f438abb387..6fefd65092 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -28,6 +28,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/qdev-properties.h"
 #include "hw/mem/memory-device.h"
=20
 static void nvdimm_get_label_size(Object *obj, Visitor *v, const char *n=
ame,
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index ff43150e7d..1f3e676066 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -20,6 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/mem/pc-dimm.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/mem/memory-device.h"
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogi=
x_ml605_mmu.c
index 03f6c1cc7c..09486bc8bf 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -35,6 +35,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
 #include "hw/char/serial.h"
+#include "hw/qdev-properties.h"
 #include "exec/address-spaces.h"
 #include "hw/ssi/ssi.h"
=20
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-=
pmu.c
index 67cedec4ef..028f31894d 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -19,7 +19,6 @@
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
-#include "hw/qdev-properties.h"
 #include "cpu.h"
 #include "boot.h"
=20
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index ce86b75664..aa8016f986 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -30,6 +30,7 @@
 #include "hw/mips/cps.h"
 #include "hw/mips/cpudevs.h"
 #include "hw/pci-host/xilinx-pcie.h"
+#include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index aea6bcd7fe..cd8b07ded2 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -22,6 +22,7 @@
 #include "qemu/module.h"
 #include "hw/mips/cps.h"
 #include "hw/mips/mips.h"
+#include "hw/qdev-properties.h"
 #include "hw/mips/cpudevs.h"
 #include "sysemu/kvm.h"
 #include "sysemu/reset.h"
diff --git a/hw/misc/a9scu.c b/hw/misc/a9scu.c
index 62bc60b2ae..45c91db303 100644
--- a/hw/misc/a9scu.c
+++ b/hw/misc/a9scu.c
@@ -10,6 +10,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/misc/a9scu.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
=20
diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index d9d369777c..24d57e8677 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -32,6 +32,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
+#include "hw/qdev-properties.h"
 #include "ui/console.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
diff --git a/hw/misc/arm11scu.c b/hw/misc/arm11scu.c
index 84275df885..3023284d6f 100644
--- a/hw/misc/arm11scu.c
+++ b/hw/misc/arm11scu.c
@@ -10,6 +10,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/misc/arm11scu.h"
+#include "hw/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/misc/arm_l2x0.c b/hw/misc/arm_l2x0.c
index 454a942ce0..af2c7af4a0 100644
--- a/hw/misc/arm_l2x0.c
+++ b/hw/misc/arm_l2x0.c
@@ -19,6 +19,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index 2a4e0458c7..e0b299c235 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -9,6 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
 #include "hw/sysbus.h"
diff --git a/hw/misc/armsse-cpuid.c b/hw/misc/armsse-cpuid.c
index 05c08f3db5..5f225096f6 100644
--- a/hw/misc/armsse-cpuid.c
+++ b/hw/misc/armsse-cpuid.c
@@ -27,6 +27,7 @@
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
 #include "hw/misc/armsse-cpuid.h"
+#include "hw/qdev-properties.h"
=20
 REG32(CPUID, 0x0)
 REG32(PID4, 0xfd0)
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 0d078f15f9..d86d510572 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -6,6 +6,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/misc/bcm2835_property.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/irq.h"
 #include "hw/misc/bcm2835_mbox_defs.h"
diff --git a/hw/misc/debugexit.c b/hw/misc/debugexit.c
index 752cb53cf6..ccf02bdbd4 100644
--- a/hw/misc/debugexit.c
+++ b/hw/misc/debugexit.c
@@ -9,6 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
+#include "hw/qdev-properties.h"
 #include "qemu/module.h"
=20
 #define TYPE_ISA_DEBUG_EXIT_DEVICE "isa-debug-exit"
diff --git a/hw/misc/eccmemctl.c b/hw/misc/eccmemctl.c
index 3300a46bb3..4b1f2b675a 100644
--- a/hw/misc/eccmemctl.c
+++ b/hw/misc/eccmemctl.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
index 31fe9a5997..dba91f94a7 100644
--- a/hw/misc/iotkit-sysctl.c
+++ b/hw/misc/iotkit-sysctl.c
@@ -27,6 +27,7 @@
 #include "migration/vmstate.h"
 #include "hw/registerfields.h"
 #include "hw/misc/iotkit-sysctl.h"
+#include "hw/qdev-properties.h"
 #include "target/arm/arm-powerctl.h"
 #include "target/arm/cpu.h"
=20
diff --git a/hw/misc/iotkit-sysinfo.c b/hw/misc/iotkit-sysinfo.c
index 3e1cf0ec34..0106fa48d3 100644
--- a/hw/misc/iotkit-sysinfo.c
+++ b/hw/misc/iotkit-sysinfo.c
@@ -26,6 +26,7 @@
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
 #include "hw/misc/iotkit-sysinfo.h"
+#include "hw/qdev-properties.h"
=20
 REG32(SYS_VERSION, 0x0)
 REG32(SYS_CONFIG, 0x4)
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 7a2334c98b..5e3b05eae0 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -22,6 +22,7 @@
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "sysemu/kvm.h"
diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 5e8ee80c25..9011f93086 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "hw/ppc/mac.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/input/adb.h"
 #include "hw/misc/mos6522.h"
diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
index e62b622112..6cca6b27d6 100644
--- a/hw/misc/macio/gpio.c
+++ b/hw/misc/macio/gpio.c
@@ -25,6 +25,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/ppc/mac.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/misc/macio/macio.h"
 #include "hw/misc/macio/gpio.h"
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 222f163139..b59df4e3b8 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -30,6 +30,7 @@
 #include "hw/misc/macio/cuda.h"
 #include "hw/pci/pci.h"
 #include "hw/ppc/mac_dbdma.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/char/escc.h"
 #include "hw/misc/macio/macio.h"
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index d824a068d9..a289340036 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -31,6 +31,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "hw/ppc/mac.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/input/adb.h"
 #include "hw/irq.h"
diff --git a/hw/misc/mips_cmgcr.c b/hw/misc/mips_cmgcr.c
index 6bddb2312a..0feab092f1 100644
--- a/hw/misc/mips_cmgcr.c
+++ b/hw/misc/mips_cmgcr.c
@@ -17,6 +17,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/misc/mips_cmgcr.h"
 #include "hw/misc/mips_cpc.h"
+#include "hw/qdev-properties.h"
 #include "hw/intc/mips_gic.h"
=20
 static inline bool is_cpc_connected(MIPSGCRState *s)
diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index caa618f582..19ea016b87 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -26,6 +26,7 @@
 #include "migration/vmstate.h"
=20
 #include "hw/misc/mips_cpc.h"
+#include "hw/qdev-properties.h"
=20
 static inline uint64_t cpc_vp_run_mask(MIPSCPCState *cpc)
 {
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index e8ba4a3cd0..ea0cf9726b 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -25,6 +25,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "hw/misc/mips_itu.h"
+#include "hw/qdev-properties.h"
=20
 #define ITC_TAG_ADDRSPACE_SZ (ITC_ADDRESSMAP_NUM * 8)
 /* Initialize as 4kB area to fit all 32 cells with default 128B grain.
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index f06cf0b52a..4d99350e22 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -28,6 +28,7 @@
 #include "hw/input/adb.h"
 #include "hw/irq.h"
 #include "hw/misc/mos6522.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/misc/mps2-fpgaio.c b/hw/misc/mps2-fpgaio.c
index 4824dc09b2..5e8b103914 100644
--- a/hw/misc/mps2-fpgaio.c
+++ b/hw/misc/mps2-fpgaio.c
@@ -24,6 +24,7 @@
 #include "migration/vmstate.h"
 #include "hw/registerfields.h"
 #include "hw/misc/mps2-fpgaio.h"
+#include "hw/qdev-properties.h"
 #include "qemu/timer.h"
=20
 REG32(LED0, 0)
diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 042ce130ba..25779a1dca 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -25,6 +25,7 @@
 #include "migration/vmstate.h"
 #include "hw/registerfields.h"
 #include "hw/misc/mps2-scc.h"
+#include "hw/qdev-properties.h"
=20
 REG32(CFG0, 0)
 REG32(CFG1, 4)
diff --git a/hw/misc/msf2-sysreg.c b/hw/misc/msf2-sysreg.c
index da0f7c26e1..ddc5a30c80 100644
--- a/hw/misc/msf2-sysreg.c
+++ b/hw/misc/msf2-sysreg.c
@@ -17,6 +17,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/misc/msf2-sysreg.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "trace.h"
diff --git a/hw/misc/nrf51_rng.c b/hw/misc/nrf51_rng.c
index 8528c8880c..5140981c96 100644
--- a/hw/misc/nrf51_rng.c
+++ b/hw/misc/nrf51_rng.c
@@ -16,6 +16,7 @@
 #include "hw/arm/nrf51.h"
 #include "hw/irq.h"
 #include "hw/misc/nrf51_rng.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/guest-random.h"
=20
diff --git a/hw/misc/pc-testdev.c b/hw/misc/pc-testdev.c
index 94cf55440e..0fb84ddc6b 100644
--- a/hw/misc/pc-testdev.c
+++ b/hw/misc/pc-testdev.c
@@ -36,7 +36,6 @@
 */
=20
 #include "qemu/osdep.h"
-#include "hw/qdev.h"
 #include "qemu/module.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
diff --git a/hw/misc/pci-testdev.c b/hw/misc/pci-testdev.c
index 0eb9ed5469..74d8571a73 100644
--- a/hw/misc/pci-testdev.c
+++ b/hw/misc/pci-testdev.c
@@ -20,6 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "qemu/event_notifier.h"
 #include "qemu/module.h"
 #include "sysemu/kvm.h"
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 1da24c621e..653393ef02 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -18,6 +18,7 @@
 #include "qemu/module.h"
=20
 #include "hw/nvram/fw_cfg.h"
+#include "hw/qdev-properties.h"
 #include "hw/misc/pvpanic.h"
=20
 /* The bit of supported pv event */
diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
index deb7796ec2..49dd6050bd 100644
--- a/hw/misc/tz-mpc.c
+++ b/hw/misc/tz-mpc.c
@@ -19,6 +19,7 @@
 #include "hw/registerfields.h"
 #include "hw/irq.h"
 #include "hw/misc/tz-mpc.h"
+#include "hw/qdev-properties.h"
=20
 /* Our IOMMU has two IOMMU indexes, one for secure transactions and one =
for
  * non-secure transactions.
diff --git a/hw/misc/tz-msc.c b/hw/misc/tz-msc.c
index 5b664d760f..7d522ac0ec 100644
--- a/hw/misc/tz-msc.c
+++ b/hw/misc/tz-msc.c
@@ -19,6 +19,7 @@
 #include "hw/registerfields.h"
 #include "hw/irq.h"
 #include "hw/misc/tz-msc.h"
+#include "hw/qdev-properties.h"
=20
 static void tz_msc_update_irq(TZMSC *s)
 {
diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
index ccc4468c11..181a5f1e81 100644
--- a/hw/misc/tz-ppc.c
+++ b/hw/misc/tz-ppc.c
@@ -19,6 +19,7 @@
 #include "hw/registerfields.h"
 #include "hw/irq.h"
 #include "hw/misc/tz-ppc.h"
+#include "hw/qdev-properties.h"
=20
 static void tz_ppc_update_irq(TZPPC *s)
 {
diff --git a/hw/net/allwinner_emac.c b/hw/net/allwinner_emac.c
index f4b8c4fa67..e055a661c4 100644
--- a/hw/net/allwinner_emac.c
+++ b/hw/net/allwinner_emac.c
@@ -24,6 +24,7 @@
 #include "qemu/fifo8.h"
 #include "hw/irq.h"
 #include "hw/net/allwinner_emac.h"
+#include "hw/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include <zlib.h>
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index ab6f7e8262..7f9cb5ab95 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -27,6 +27,7 @@
=20
 #include "hw/irq.h"
 #include "hw/net/cadence_gem.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
diff --git a/hw/net/can/can_kvaser_pci.c b/hw/net/can/can_kvaser_pci.c
index 401da73cc8..16861b8f9f 100644
--- a/hw/net/can/can_kvaser_pci.c
+++ b/hw/net/can/can_kvaser_pci.c
@@ -38,6 +38,7 @@
 #include "chardev/char.h"
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "net/can_emu.h"
=20
diff --git a/hw/net/can/can_mioe3680_pci.c b/hw/net/can/can_mioe3680_pci.=
c
index 0f0ca912c9..965e252d9d 100644
--- a/hw/net/can/can_mioe3680_pci.c
+++ b/hw/net/can/can_mioe3680_pci.c
@@ -34,6 +34,7 @@
 #include "chardev/char.h"
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "net/can_emu.h"
=20
diff --git a/hw/net/can/can_pcm3680_pci.c b/hw/net/can/can_pcm3680_pci.c
index 632eb0b59b..51b6540072 100644
--- a/hw/net/can/can_pcm3680_pci.c
+++ b/hw/net/can/can_pcm3680_pci.c
@@ -34,6 +34,7 @@
 #include "chardev/char.h"
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "net/can_emu.h"
=20
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 8d0cafc6ba..a5678e11fa 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -19,6 +19,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index da5f3646fd..8ae4e08f1e 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -27,6 +27,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
 #include "net/checksum.h"
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 270ff93841..b69fd7d8ad 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -43,6 +43,7 @@
 #include "hw/hw.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
=20
 #include "e1000_regs.h"
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index 2ad1b328e4..cc2dd8b1c9 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -43,6 +43,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
 #include "net/eth.h"
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index e5c902ada4..e1556236b0 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -31,6 +31,7 @@
 #include "hw/sysbus.h"
 #include "hw/irq.h"
 #include "hw/ptimer.h"
+#include "hw/qdev-properties.h"
 #include "etsec.h"
 #include "registers.h"
 #include "qemu/log.h"
diff --git a/hw/net/fsl_etsec/etsec.h b/hw/net/fsl_etsec/etsec.h
index 877988572e..09d05c2133 100644
--- a/hw/net/fsl_etsec/etsec.h
+++ b/hw/net/fsl_etsec/etsec.h
@@ -25,7 +25,6 @@
 #ifndef ETSEC_H
 #define ETSEC_H
=20
-#include "hw/qdev.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "hw/ptimer.h"
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 4d0f56c123..04c78e8517 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -20,6 +20,7 @@
 #include "net/checksum.h"
 #include "net/eth.h"
 #include "hw/net/mii.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
=20
 /* For crc32 */
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 5a22542aaf..7ac4ed7c12 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -24,6 +24,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/net/imx_fec.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "sysemu/dma.h"
 #include "qemu/log.h"
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index ea20a92cda..e7662f0575 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -20,6 +20,7 @@
 #include "hw/net/lan9118.h"
 #include "sysemu/sysemu.h"
 #include "hw/ptimer.h"
+#include "hw/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/hw/net/lance.c b/hw/net/lance.c
index 0d094327cb..6631e2a4e0 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -41,6 +41,7 @@
 #include "hw/sparc/sparc32_dma.h"
 #include "migration/vmstate.h"
 #include "hw/net/lance.h"
+#include "hw/qdev-properties.h"
 #include "trace.h"
 #include "sysemu/sysemu.h"
=20
diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index e4a3b55eb6..8fcf354a4b 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -14,6 +14,7 @@
 #include "hw/m68k/mcf.h"
 #include "hw/m68k/mcf_fec.h"
 #include "hw/net/mii.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 /* For crc32 */
 #include <zlib.h>
diff --git a/hw/net/milkymist-minimac2.c b/hw/net/milkymist-minimac2.c
index 1e3fb9c220..86b6d28033 100644
--- a/hw/net/milkymist-minimac2.c
+++ b/hw/net/milkymist-minimac2.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "cpu.h" /* FIXME: why does this use TARGET_PAGE_ALIGN? */
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/hw/net/mipsnet.c b/hw/net/mipsnet.c
index 013f762d72..f7ae1ced4d 100644
--- a/hw/net/mipsnet.c
+++ b/hw/net/mipsnet.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "net/net.h"
 #include "qemu/module.h"
 #include "trace.h"
diff --git a/hw/net/ne2000-isa.c b/hw/net/ne2000-isa.c
index 5195c107d0..6fcf3d5cd9 100644
--- a/hw/net/ne2000-isa.c
+++ b/hw/net/ne2000-isa.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
 #include "hw/net/ne2000-isa.h"
-#include "hw/qdev.h"
 #include "migration/vmstate.h"
 #include "ne2000.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/net/ne2000-pci.c b/hw/net/ne2000-pci.c
index 084d92f955..9a20d427e3 100644
--- a/hw/net/ne2000-pci.c
+++ b/hw/net/ne2000-pci.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "ne2000.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index a9e96cdd3a..aa13159464 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -34,6 +34,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/net/mii.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "qemu/module.h"
diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index a77d2c9368..4723c30c79 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -30,6 +30,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
 #include "qemu/module.h"
diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index bfcfcf5be3..107ac680b2 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -38,7 +38,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/irq.h"
-#include "hw/qdev.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
 #include "net/eth.h"
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 789e5c4876..50f9e33e2f 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -17,6 +17,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/pci/msix.h"
 #include "net/net.h"
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 89156ed802..88a97d756d 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -54,6 +54,7 @@
 #include <zlib.h>
=20
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "sysemu/dma.h"
 #include "qemu/module.h"
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 67e3f2408e..e574635969 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -13,6 +13,7 @@
 #include "net/net.h"
 #include "hw/irq.h"
 #include "hw/net/smc91c111.h"
+#include "hw/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 /* For crc32 */
diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index 60085b1bf4..701e6e1514 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -31,10 +31,10 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "net/net.h"
-#include "hw/qdev.h"
 #include "migration/vmstate.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
=20
diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index 154214ca1d..3aca2a09f3 100644
--- a/hw/net/stellaris_enet.c
+++ b/hw/net/stellaris_enet.c
@@ -9,6 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
diff --git a/hw/net/sungem.c b/hw/net/sungem.c
index f5e30725be..f31d41ac5b 100644
--- a/hw/net/sungem.c
+++ b/hw/net/sungem.c
@@ -9,6 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index 359bd4f9f5..2243b7cf7b 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/net/mii.h"
 #include "net/net.h"
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index cdf4d774da..4113729fcf 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -27,6 +27,7 @@
 #include "hw/virtio/virtio-bus.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-net.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-access.h"
 #include "migration/misc.h"
 #include "standard-headers/linux/ethtool.h"
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 88a7c13a96..17b420b2a8 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "net/tap.h"
 #include "net/checksum.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
index ded8b9cf9d..2ea8d2ec72 100644
--- a/hw/net/xgmac.c
+++ b/hw/net/xgmac.c
@@ -26,6 +26,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index b22e344a4b..d8716a1f73 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
@@ -32,6 +33,7 @@
=20
 #include "hw/hw.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/stream.h"
=20
 #define DPHY(x)
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index a963087f16..384e72b157 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -27,6 +27,7 @@
 #include "cpu.h" /* FIXME should not use tswap* */
 #include "hw/sysbus.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "net/net.h"
=20
 #define D(x)
diff --git a/hw/nios2/10m50_devboard.c b/hw/nios2/10m50_devboard.c
index 3c01e4f667..ad8b2fc670 100644
--- a/hw/nios2/10m50_devboard.c
+++ b/hw/nios2/10m50_devboard.c
@@ -28,6 +28,7 @@
=20
 #include "hw/sysbus.h"
 #include "hw/char/serial.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
 #include "exec/memory.h"
diff --git a/hw/nvram/ds1225y.c b/hw/nvram/ds1225y.c
index 9cddb37925..934e09bf75 100644
--- a/hw/nvram/ds1225y.c
+++ b/hw/nvram/ds1225y.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index 00f942db51..3416367523 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -12,6 +12,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/i2c/i2c.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/block-backend.h"
=20
 /* #define DEBUG_AT24C */
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index f192c3ea16..7dc3ac378e 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -29,6 +29,7 @@
 #include "sysemu/reset.h"
 #include "hw/boards.h"
 #include "hw/nvram/fw_cfg.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
index 853b693109..9a47e35b8e 100644
--- a/hw/nvram/mac_nvram.c
+++ b/hw/nvram/mac_nvram.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/nvram/chrp_nvram.h"
 #include "hw/ppc/mac.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/cutils.h"
 #include "qemu/module.h"
diff --git a/hw/nvram/nrf51_nvm.c b/hw/nvram/nrf51_nvm.c
index e13ff4b2fe..4d678f994e 100644
--- a/hw/nvram/nrf51_nvm.c
+++ b/hw/nvram/nrf51_nvm.c
@@ -24,6 +24,7 @@
 #include "exec/address-spaces.h"
 #include "hw/arm/nrf51.h"
 #include "hw/nvram/nrf51_nvm.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
=20
 /*
diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index ef22962767..c7bcd29e15 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -36,6 +36,7 @@
 #include "hw/nvram/chrp_nvram.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
+#include "hw/qdev-properties.h"
=20
 typedef struct SpaprNvram {
     SpaprVioDevice sdev;
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 13572b8eff..79e70493fc 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -28,6 +28,7 @@
 #include "hw/char/serial.h"
 #include "net/net.h"
 #include "hw/loader.h"
+#include "hw/qdev-properties.h"
 #include "exec/address-spaces.h"
 #include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_=
root_port.c
index fb78cf1905..9eaefebca8 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -15,6 +15,7 @@
 #include "qemu/module.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pcie_port.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
=20
 #define TYPE_GEN_PCIE_ROOT_PORT                "pcie-root-port"
diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_de=
v.c
index 5fe96d02b3..cc80cb4898 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -27,6 +27,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/shpc.h"
 #include "hw/pci/slotid_cap.h"
+#include "hw/qdev-properties.h"
 #include "exec/memory.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/hotplug.h"
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expa=
nder_bridge.c
index aecf3d7ddf..06a7c018d7 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -15,6 +15,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
+#include "hw/qdev-properties.h"
 #include "hw/pci/pci_bridge.h"
 #include "qemu/range.h"
 #include "qemu/error-report.h"
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bri=
dge.c
index d0bfa0189a..7679bef6c1 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -16,6 +16,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/shpc.h"
 #include "hw/pci/slotid_cap.h"
+#include "hw/qdev-properties.h"
=20
 typedef struct PCIEPCIBridge {
     /*< private >*/
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_por=
t.c
index 1d8a778709..012c2cb12c 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -16,6 +16,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/pci/pcie_port.h"
+#include "hw/qdev-properties.h"
=20
 static void rp_aer_vector_update(PCIDevice *d)
 {
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_d=
ownstream.c
index 1d62e31272..a9f084b863 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -24,6 +24,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 083f5bb1a6..71e9b0d9b5 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -25,6 +25,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pcie_port.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/irq.h"
 #include "hw/pci-host/designware.h"
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index 93f28efb49..0ca604dc62 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -33,6 +33,7 @@
 #include "qapi/error.h"
 #include "hw/irq.h"
 #include "hw/pci-host/gpex.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
=20
diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index 912f8bf13f..537273e578 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/pci/pci_host.h"
 #include "hw/ppc/mac.h"
+#include "hw/qdev-properties.h"
 #include "hw/pci/pci.h"
 #include "hw/intc/heathrow_pic.h"
 #include "hw/irq.h"
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index bc9726057a..2e97bc0bdb 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -27,6 +27,7 @@
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
+#include "hw/qdev-properties.h"
 #include "hw/isa/isa.h"
 #include "hw/sysbus.h"
 #include "qapi/error.h"
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 241e7e788d..8bed8e8941 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -17,6 +17,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/ppc/e500-ccsr.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 588c7dc6c0..85d7ba9037 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -30,6 +30,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/i386/pc.h"
 #include "hw/irq.h"
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 1688a89b6a..158d270b9f 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -30,6 +30,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/pci-host/q35.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index 772ac1f725..a6520511b4 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -28,6 +28,7 @@
 #include "hw/sysbus.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
+#include "hw/qdev-properties.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/irq.h"
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 76293ab22b..75bc506965 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/ppc/mac.h"
+#include "hw/qdev-properties.h"
 #include "qemu/module.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index 1cd832a393..b731d0544f 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -14,6 +14,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
+#include "hw/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
=20
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index f42fabbbe7..17d5024349 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -22,6 +22,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/pci/pci_bridge.h"
+#include "hw/qdev-properties.h"
 #include "hw/irq.h"
 #include "hw/pci-host/xilinx-pcie.h"
=20
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d84ecd8507..9001b81daa 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -29,6 +29,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
+#include "hw/qdev-properties.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "monitor/monitor.h"
diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
index c9c3ba540a..c19a9be592 100644
--- a/hw/pci/pcie_port.c
+++ b/hw/pci/pcie_port.c
@@ -20,6 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/pci/pcie_port.h"
+#include "hw/qdev-properties.h"
 #include "qemu/module.h"
 #include "hw/hotplug.h"
=20
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 3f0c3dea92..3b04484654 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -33,6 +33,7 @@
 #include "hw/ppc/openpic.h"
 #include "hw/ppc/openpic_kvm.h"
 #include "hw/ppc/ppc.h"
+#include "hw/qdev-properties.h"
 #include "hw/loader.h"
 #include "elf.h"
 #include "hw/sysbus.h"
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 94a958e5e0..c5bbcc7433 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -50,6 +50,7 @@
 #include "qemu-common.h"
 #include "qapi/error.h"
 #include "hw/ppc/ppc.h"
+#include "hw/qdev-properties.h"
 #include "hw/ppc/mac.h"
 #include "hw/input/adb.h"
 #include "hw/ppc/mac_dbdma.h"
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index aeeddd1d3b..0fa680b749 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -29,6 +29,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/ppc/ppc.h"
+#include "hw/qdev-properties.h"
 #include "mac.h"
 #include "hw/input/adb.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 114d5826df..cf31830655 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -41,6 +41,7 @@
 #include "target/ppc/mmu-hash64.h"
=20
 #include "hw/ppc/xics.h"
+#include "hw/qdev-properties.h"
 #include "hw/ppc/pnv_xscom.h"
=20
 #include "hw/isa/isa.h"
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index ff477ba6c9..c6b0fee56f 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -29,6 +29,7 @@
 #include "hw/ppc/pnv_core.h"
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/ppc/xics.h"
+#include "hw/qdev-properties.h"
=20
 static const char *pnv_core_cpu_typename(PnvCore *pc)
 {
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index f10d519014..88ba8e7b9b 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -31,6 +31,7 @@
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_xscom.h"
+#include "hw/qdev-properties.h"
 #include "hw/ppc/pnv_psi.h"
=20
 #include <libfdt.h>
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 761d551967..95475c9c5f 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -20,6 +20,7 @@
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
 #include "hw/ppc/ppc.h"
+#include "hw/qdev-properties.h"
 #include "hw/pci/pci.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/reset.h"
diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
index d46792d366..10f9725f41 100644
--- a/hw/ppc/prep_systemio.c
+++ b/hw/ppc/prep_systemio.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h" /* for error_report() */
diff --git a/hw/ppc/rs6000_mc.c b/hw/ppc/rs6000_mc.c
index daea13cdea..df7c0006fc 100644
--- a/hw/ppc/rs6000_mc.c
+++ b/hw/ppc/rs6000_mc.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "hw/isa/isa.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 7ed5518dbc..437e214210 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -37,6 +37,7 @@
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/usb/hcd-ehci.h"
 #include "hw/ppc/fdt.h"
+#include "hw/qdev-properties.h"
=20
 #include <libfdt.h>
=20
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4c02ce9a08..06d23a5004 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -56,6 +56,7 @@
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
+#include "hw/qdev-properties.h"
 #include "hw/pci-host/spapr.h"
 #include "hw/pci/msi.h"
=20
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index f86f773d42..920bc365ef 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "hw/cpu/core.h"
 #include "hw/ppc/spapr_cpu_core.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "target/ppc/cpu.h"
 #include "hw/ppc/spapr.h"
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index c09bbcc22d..09255f4951 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -17,7 +17,6 @@
 #include "qemu/cutils.h"
 #include "hw/ppc/spapr_drc.h"
 #include "qom/object.h"
-#include "hw/qdev.h"
 #include "migration/vmstate.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index d75359c5f3..53c973bdd1 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -29,7 +29,6 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "sysemu/sysemu.h"
-#include "hw/qdev.h"
 #include "sysemu/device_tree.h"
=20
 #include "hw/ppc/fdt.h"
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 8223bdb39f..ce85f8ac63 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -22,7 +22,6 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "sysemu/kvm.h"
-#include "hw/qdev.h"
 #include "kvm_ppc.h"
 #include "migration/vmstate.h"
 #include "sysemu/dma.h"
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 66705962e7..2f87fe08f3 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -17,6 +17,7 @@
 #include "hw/ppc/spapr_xive.h"
 #include "hw/ppc/xics.h"
 #include "hw/ppc/xics_spapr.h"
+#include "hw/qdev-properties.h"
 #include "cpu-models.h"
 #include "sysemu/kvm.h"
=20
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 53b799fec7..bf31fd854c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -47,6 +47,7 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_ids.h"
 #include "hw/ppc/spapr_drc.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/kvm.h"
 #include "sysemu/hostmem.h"
diff --git a/hw/ppc/spapr_rng.c b/hw/ppc/spapr_rng.c
index cfe43eaae9..27198e0ced 100644
--- a/hw/ppc/spapr_rng.c
+++ b/hw/ppc/spapr_rng.c
@@ -27,6 +27,7 @@
 #include "sysemu/device_tree.h"
 #include "sysemu/rng.h"
 #include "hw/ppc/spapr.h"
+#include "hw/qdev-properties.h"
 #include "kvm_ppc.h"
=20
 #define SPAPR_RNG(obj) \
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index a618a2ac0f..558d702833 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -29,7 +29,6 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
-#include "hw/qdev.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/cpus.h"
 #include "sysemu/hw_accel.h"
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 099b94cc54..68625522d8 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -43,6 +43,7 @@
=20
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
+#include "hw/qdev-properties.h"
 #include "ppc405.h"
=20
 #define EPAPR_MAGIC    (0x45504150)
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index b924843367..e3a12173e3 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -20,7 +20,6 @@
 #include "hw/pci/pci_ids.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
-#include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "cpu.h"
 #include "trace.h"
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 61bd4d5170..d0f3199968 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -24,6 +24,7 @@
 #include "sysemu/reset.h"
 #include "hw/sysbus.h"
 #include "target/riscv/cpu.h"
+#include "hw/qdev-properties.h"
 #include "hw/riscv/riscv_hart.h"
=20
 static Property riscv_harts_props[] =3D {
diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
index 591d70deb3..e5a8f75cee 100644
--- a/hw/riscv/sifive_clint.c
+++ b/hw/riscv/sifive_clint.c
@@ -24,6 +24,7 @@
 #include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "target/riscv/cpu.h"
+#include "hw/qdev-properties.h"
 #include "hw/riscv/sifive_clint.h"
 #include "qemu/timer.h"
=20
diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index 0950e89e15..64a1a10380 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -25,6 +25,7 @@
 #include "hw/sysbus.h"
 #include "hw/pci/msi.h"
 #include "hw/boards.h"
+#include "hw/qdev-properties.h"
 #include "target/riscv/cpu.h"
 #include "sysemu/sysemu.h"
 #include "hw/riscv/sifive_plic.h"
diff --git a/hw/riscv/sifive_prci.c b/hw/riscv/sifive_prci.c
index 562bc3dc4c..9837b6166f 100644
--- a/hw/riscv/sifive_prci.c
+++ b/hw/riscv/sifive_prci.c
@@ -19,6 +19,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "target/riscv/cpu.h"
diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
index 3a14f9f8b6..afbb3aaf34 100644
--- a/hw/riscv/sifive_test.c
+++ b/hw/riscv/sifive_test.c
@@ -19,6 +19,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "target/riscv/cpu.h"
diff --git a/hw/s390x/3270-ccw.c b/hw/s390x/3270-ccw.c
index 14882242c3..c19a75b9b7 100644
--- a/hw/s390x/3270-ccw.c
+++ b/hw/s390x/3270-ccw.c
@@ -9,12 +9,14 @@
  * your option) any later version. See the COPYING file in the top-level
  * directory.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "cpu.h"
 #include "hw/s390x/css.h"
 #include "hw/s390x/css-bridge.h"
+#include "hw/qdev-properties.h"
 #include "hw/s390x/3270-ccw.h"
=20
 /* Handle READ ccw commands from guest */
diff --git a/hw/s390x/ap-device.c b/hw/s390x/ap-device.c
index f5ac8db968..fc0b41e937 100644
--- a/hw/s390x/ap-device.c
+++ b/hw/s390x/ap-device.c
@@ -10,7 +10,6 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "hw/qdev.h"
 #include "hw/s390x/ap-device.h"
=20
 static void ap_class_init(ObjectClass *klass, void *data)
diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index 24f17bb6ca..4d222ad202 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -11,6 +11,7 @@
=20
 #include "qemu/osdep.h"
 #include "ccw-device.h"
+#include "hw/qdev-properties.h"
 #include "qemu/module.h"
=20
 static void ccw_device_refill_ids(CcwDevice *dev)
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index 4e9ff481e8..15a8ed96de 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/hotplug.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qemu/bitops.h"
 #include "qemu/module.h"
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index b92395f165..844caab408 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -12,12 +12,12 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "hw/qdev.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
 #include "exec/address-spaces.h"
 #include "cpu.h"
 #include "hw/s390x/ioinst.h"
+#include "hw/qdev-properties.h"
 #include "hw/s390x/css.h"
 #include "trace.h"
 #include "hw/s390x/s390_flic.h"
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 2e5ce11a6b..304063cbe0 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -20,6 +20,7 @@
 #include "cpu.h"
 #include "elf.h"
 #include "hw/loader.h"
+#include "hw/qdev-properties.h"
 #include "hw/boards.h"
 #include "hw/s390x/virtio-ccw.h"
 #include "hw/s390x/vfio-ccw.h"
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index b3a07a12d8..d4813105db 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -12,8 +12,8 @@
 #ifndef HW_S390_IPL_H
 #define HW_S390_IPL_H
=20
-#include "hw/qdev.h"
 #include "cpu.h"
+#include "hw/qdev-core.h"
=20
 struct IplBlockCcw {
     uint8_t  reserved0[85];
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 2c6e084e2c..963a41c7f5 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -18,6 +18,7 @@
 #include "s390-pci-bus.h"
 #include "s390-pci-inst.h"
 #include "hw/pci/pci_bus.h"
+#include "hw/qdev-properties.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/msi.h"
 #include "qemu/error-report.h"
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 4ffdd53a85..a543b64e56 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -38,6 +38,7 @@
 #include "migration/register.h"
 #include "cpu_models.h"
 #include "hw/nmi.h"
+#include "hw/qdev-properties.h"
 #include "hw/s390x/tod.h"
=20
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
diff --git a/hw/s390x/sclpquiesce.c b/hw/s390x/sclpquiesce.c
index 6dfb087568..f56273ca4b 100644
--- a/hw/s390x/sclpquiesce.c
+++ b/hw/s390x/sclpquiesce.c
@@ -13,7 +13,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/qdev.h"
 #include "sysemu/sysemu.h"
 #include "hw/s390x/sclp.h"
 #include "migration/vmstate.h"
diff --git a/hw/s390x/vhost-vsock-ccw.c b/hw/s390x/vhost-vsock-ccw.c
index 076f733390..1835812bd1 100644
--- a/hw/s390x/vhost-vsock-ccw.c
+++ b/hw/s390x/vhost-vsock-ccw.c
@@ -7,6 +7,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/s390x/virtio-ccw-9p.c b/hw/s390x/virtio-ccw-9p.c
index 67b2c537cc..5453a964d2 100644
--- a/hw/s390x/virtio-ccw-9p.c
+++ b/hw/s390x/virtio-ccw-9p.c
@@ -10,6 +10,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/s390x/virtio-ccw-balloon.c b/hw/s390x/virtio-ccw-balloon.=
c
index 35e43e89fb..7088612f6b 100644
--- a/hw/s390x/virtio-ccw-balloon.c
+++ b/hw/s390x/virtio-ccw-balloon.c
@@ -10,6 +10,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/s390x/virtio-ccw-blk.c b/hw/s390x/virtio-ccw-blk.c
index 83636cb6d7..1512af8974 100644
--- a/hw/s390x/virtio-ccw-blk.c
+++ b/hw/s390x/virtio-ccw-blk.c
@@ -10,6 +10,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/s390x/virtio-ccw-crypto.c b/hw/s390x/virtio-ccw-crypto.c
index 4569fe0649..086b397ad2 100644
--- a/hw/s390x/virtio-ccw-crypto.c
+++ b/hw/s390x/virtio-ccw-crypto.c
@@ -9,6 +9,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/s390x/virtio-ccw-gpu.c b/hw/s390x/virtio-ccw-gpu.c
index 10ee4b86eb..be46ca7a96 100644
--- a/hw/s390x/virtio-ccw-gpu.c
+++ b/hw/s390x/virtio-ccw-gpu.c
@@ -9,6 +9,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/s390x/virtio-ccw-input.c b/hw/s390x/virtio-ccw-input.c
index 075bb094ee..370b776790 100644
--- a/hw/s390x/virtio-ccw-input.c
+++ b/hw/s390x/virtio-ccw-input.c
@@ -9,6 +9,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/s390x/virtio-ccw-net.c b/hw/s390x/virtio-ccw-net.c
index 8ff184265e..12c03d73c4 100644
--- a/hw/s390x/virtio-ccw-net.c
+++ b/hw/s390x/virtio-ccw-net.c
@@ -10,6 +10,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/s390x/virtio-ccw-rng.c b/hw/s390x/virtio-ccw-rng.c
index dc60f084a5..854254dd50 100644
--- a/hw/s390x/virtio-ccw-rng.c
+++ b/hw/s390x/virtio-ccw-rng.c
@@ -10,6 +10,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/s390x/virtio-ccw-scsi.c b/hw/s390x/virtio-ccw-scsi.c
index 26fa086ef0..4662288b5b 100644
--- a/hw/s390x/virtio-ccw-scsi.c
+++ b/hw/s390x/virtio-ccw-scsi.c
@@ -10,6 +10,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/s390x/virtio-ccw-serial.c b/hw/s390x/virtio-ccw-serial.c
index 8cf5a529a5..eafb7d5c1f 100644
--- a/hw/s390x/virtio-ccw-serial.c
+++ b/hw/s390x/virtio-ccw-serial.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "hw/virtio/virtio.h"
 #include "qemu/module.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-serial.h"
 #include "virtio-ccw.h"
=20
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 3706294a85..de9bd20887 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/dma.h"
 #include "sysemu/block-backend.h"
 #include "hw/pci/msi.h"
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index efa54a30c5..b8a4b37cf3 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/dma.h"
 #include "hw/pci/msi.h"
 #include "qemu/iov.h"
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 1f9914739a..db785e6001 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -3,11 +3,11 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
+#include "hw/qdev-properties.h"
 #include "hw/scsi/scsi.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "scsi/constants.h"
-#include "hw/qdev.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "trace.h"
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index aa34297a5d..6370cfe190 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -34,6 +34,7 @@
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "hw/block/block.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/dma.h"
 #include "qemu/cutils.h"
 #include "trace.h"
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 44430b6ea6..e7798ebcd0 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -18,6 +18,7 @@
 #include "qemu/module.h"
 #include "hw/scsi/scsi.h"
 #include "migration/qemu-file-types.h"
+#include "hw/qdev-properties.h"
 #include "hw/scsi/emulation.h"
 #include "sysemu/block-backend.h"
 #include "trace.h"
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index fedeec676d..2120ceb051 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -39,9 +39,9 @@
 #include "migration/vmstate.h"
 #include "scsi/constants.h"
 #include "srp.h"
-#include "hw/qdev.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
+#include "hw/qdev-properties.h"
 #include "viosrp.h"
 #include "trace.h"
=20
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 83c9d83459..cd5cf1679d 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -28,6 +28,7 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
 #include "hw/fw-path-provider.h"
+#include "hw/qdev-properties.h"
 #include "qemu/cutils.h"
=20
 /* Features supported by host kernel. */
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index fcee67d5a7..a5be128b54 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -21,6 +21,7 @@
 #include "qom/object.h"
 #include "hw/fw-path-provider.h"
 #include "hw/qdev-core.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-backend.h"
 #include "hw/virtio/vhost-user-scsi.h"
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index a6d61aacdb..ee52aa7d17 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -22,6 +22,7 @@
 #include "qemu/iov.h"
 #include "qemu/module.h"
 #include "sysemu/block-backend.h"
+#include "hw/qdev-properties.h"
 #include "hw/scsi/scsi.h"
 #include "scsi/constants.h"
 #include "hw/virtio/virtio-bus.h"
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 7e27bce43e..452a3b63b2 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -33,6 +33,7 @@
 #include "migration/vmstate.h"
 #include "scsi/constants.h"
 #include "hw/pci/msi.h"
+#include "hw/qdev-properties.h"
 #include "vmw_pvscsi.h"
 #include "trace.h"
=20
diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index e3c7cf5b5f..79a9a5c52c 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -31,6 +31,7 @@
 #include "qapi/error.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
+#include "hw/qdev-properties.h"
 #include "hw/sd/sd.h"
=20
 enum {
diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index db2f2adf58..8f9ab0ec16 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -17,7 +17,6 @@
 #include "migration/vmstate.h"
 #include "hw/arm/pxa.h"
 #include "hw/sd/sd.h"
-#include "hw/qdev.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 3f26b38786..49b83576e7 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -32,7 +32,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/qdev.h"
 #include "hw/irq.h"
 #include "hw/registerfields.h"
 #include "sysemu/block-backend.h"
diff --git a/hw/sd/sdhci-pci.c b/hw/sd/sdhci-pci.c
index 438cb30af5..2c8d8f59b5 100644
--- a/hw/sd/sdhci-pci.c
+++ b/hw/sd/sdhci-pci.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "hw/qdev-properties.h"
 #include "hw/sd/sdhci.h"
 #include "sdhci-internal.h"
=20
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 1adc16e3e9..e08ec3e398 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -27,6 +27,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/dma.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 571aabea5c..91db069212 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -14,6 +14,7 @@
 #include "sysemu/blockdev.h"
 #include "hw/ssi/ssi.h"
 #include "migration/vmstate.h"
+#include "hw/qdev-properties.h"
 #include "hw/sd/sd.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 571e594304..b421b3bc83 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -33,6 +33,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "net/net.h"
 #include "sh7750_regs.h"
 #include "hw/ide.h"
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 655939a3f1..c5f1b1ee72 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -31,6 +31,7 @@
 #include "hw/irq.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
 #include "sysemu/reset.h"
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 99b8693a0c..267895b93e 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -41,6 +41,7 @@
 #include "hw/boards.h"
 #include "hw/scsi/esp.h"
 #include "hw/nvram/sun_nvram.h"
+#include "hw/qdev-properties.h"
 #include "hw/nvram/chrp_nvram.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/char/escc.h"
diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
index a5681ded6a..ccf46a5147 100644
--- a/hw/sparc/sun4m_iommu.c
+++ b/hw/sparc/sun4m_iommu.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/sparc/sun4m_iommu.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 54a385970c..08e12aa88b 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -32,6 +32,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
+#include "hw/qdev-properties.h"
 #include "hw/pci-host/sabre.h"
 #include "hw/char/serial.h"
 #include "hw/char/parallel.h"
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 7ace5780a3..b8332150f1 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -31,6 +31,7 @@
 #include "qemu/error-report.h"
=20
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/ssi/aspeed_smc.h"
=20
 /* CE Type Setting Register */
diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index 081433c2f0..24280dfeab 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -33,6 +33,7 @@
 #include "qemu/fifo8.h"
=20
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/ssi/ssi.h"
=20
 #ifdef XILINX_SPI_ERR_DEBUG
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index a28cd8f8f0..1605fa102b 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -27,6 +27,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/irq.h"
 #include "hw/ptimer.h"
+#include "hw/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/bitops.h"
diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index 0339b92cf8..75f1867174 100644
--- a/hw/timer/a9gtimer.c
+++ b/hw/timer/a9gtimer.c
@@ -23,6 +23,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/timer/a9gtimer.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index 904da4fc88..1e1f74f1a1 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -17,6 +17,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
 #include "hw/timer/allwinner-a10-pit.h"
diff --git a/hw/timer/altera_timer.c b/hw/timer/altera_timer.c
index 51971e44ca..c9988f67ac 100644
--- a/hw/timer/altera_timer.c
+++ b/hw/timer/altera_timer.c
@@ -27,6 +27,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/irq.h"
 #include "hw/ptimer.h"
+#include "hw/qdev-properties.h"
=20
 #define R_STATUS      0
 #define R_CONTROL     1
diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index abfc5baa77..983e61847e 100644
--- a/hw/timer/arm_mptimer.c
+++ b/hw/timer/arm_mptimer.c
@@ -23,6 +23,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/ptimer.h"
+#include "hw/qdev-properties.h"
 #include "hw/timer/arm_mptimer.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 0b121252fd..c2e6211188 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -11,9 +11,9 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
-#include "hw/qdev.h"
 #include "hw/irq.h"
 #include "hw/ptimer.h"
+#include "hw/qdev-properties.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
diff --git a/hw/timer/cmsdk-apb-dualtimer.c b/hw/timer/cmsdk-apb-dualtime=
r.c
index 6a084a91dd..5e2352dd32 100644
--- a/hw/timer/cmsdk-apb-dualtimer.c
+++ b/hw/timer/cmsdk-apb-dualtimer.c
@@ -24,6 +24,7 @@
 #include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/registerfields.h"
 #include "hw/timer/cmsdk-apb-dualtimer.h"
 #include "migration/vmstate.h"
diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index 79b291863c..77b9af05f4 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -54,6 +54,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index 28ba1259d0..32dbf870d4 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -28,6 +28,7 @@
 #include "qemu/timer.h"
 #include "hw/irq.h"
 #include "hw/ptimer.h"
+#include "hw/qdev-properties.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
=20
diff --git a/hw/timer/lm32_timer.c b/hw/timer/lm32_timer.c
index a381e39f0a..ac3edaff4f 100644
--- a/hw/timer/lm32_timer.c
+++ b/hw/timer/lm32_timer.c
@@ -28,6 +28,7 @@
 #include "trace.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
+#include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/hw/timer/m48t59-isa.c b/hw/timer/m48t59-isa.c
index cbc5e61ddd..5e5432abfd 100644
--- a/hw/timer/m48t59-isa.c
+++ b/hw/timer/m48t59-isa.c
@@ -25,6 +25,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
+#include "hw/qdev-properties.h"
 #include "hw/timer/m48t59.h"
 #include "m48t59-internal.h"
 #include "qemu/module.h"
diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
index 199003030a..56f9dfa8dd 100644
--- a/hw/timer/m48t59.c
+++ b/hw/timer/m48t59.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/timer/m48t59.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 473935339d..5aa584c080 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -28,6 +28,7 @@
 #include "qemu/module.h"
 #include "qemu/bcd.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/replay.h"
diff --git a/hw/timer/milkymist-sysctl.c b/hw/timer/milkymist-sysctl.c
index 4d75d73a93..a65c174c04 100644
--- a/hw/timer/milkymist-sysctl.c
+++ b/hw/timer/milkymist-sysctl.c
@@ -29,6 +29,7 @@
 #include "trace.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
+#include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/hw/timer/mss-timer.c b/hw/timer/mss-timer.c
index 084e02199d..45f1cf42f9 100644
--- a/hw/timer/mss-timer.c
+++ b/hw/timer/mss-timer.c
@@ -28,6 +28,7 @@
 #include "qemu/module.h"
 #include "qemu/log.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/timer/mss-timer.h"
 #include "migration/vmstate.h"
=20
diff --git a/hw/timer/pl031.c b/hw/timer/pl031.c
index 39abd08643..2b3e261006 100644
--- a/hw/timer/pl031.c
+++ b/hw/timer/pl031.c
@@ -16,6 +16,7 @@
 #include "hw/timer/pl031.h"
 #include "migration/vmstate.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index 99e6c1e250..af7e4dbcbd 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -9,6 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "hw/arm/pxa.h"
diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index 931ffd483f..38fd32b62a 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -26,6 +26,7 @@
 #include "qemu/timer.h"
 #include "hw/irq.h"
 #include "hw/ptimer.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index b41822f047..edc557a4b9 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -24,6 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/timer/stm32f2xx_timer.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index c4a83af8b9..355518232c 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -26,6 +26,7 @@
 #include "hw/sysbus.h"
 #include "hw/irq.h"
 #include "hw/ptimer.h"
+#include "hw/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index db0e3e7c67..faae733120 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -19,8 +19,6 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
-
-#include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "hw/pci/pci_ids.h"
 #include "hw/acpi/tpm.h"
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 774d12a5e1..7aaf9b946d 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -30,6 +30,7 @@
=20
 #include "hw/acpi/tpm.h"
 #include "hw/pci/pci_ids.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "sysemu/tpm_backend.h"
 #include "tpm_int.h"
diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index ee41757ea2..62b091f0c0 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -26,8 +26,8 @@
 #include "tpm_util.h"
 #include "tpm_int.h"
 #include "exec/memory.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/tpm_backend.h"
-#include "hw/qdev.h"
 #include "trace.h"
=20
 /* tpm backend property */
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index be18221ac6..a6522f5429 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
 #include "hw/usb.h"
-#include "hw/qdev.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index e20f8ed293..291e41db8a 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -33,6 +33,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "ccid.h"
+#include "hw/qdev-properties.h"
 #include "qapi/error.h"
=20
 #define DPRINTF(card, lvl, fmt, ...) \
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 9e42547fc8..267ed9a8a0 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -13,6 +13,7 @@
 #include "qemu/units.h"
 #include <libcacard.h>
 #include "chardev/char-fe.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/usb/ccid.h b/hw/usb/ccid.h
index 3920733f13..bb2fdbfff3 100644
--- a/hw/usb/ccid.h
+++ b/hw/usb/ccid.h
@@ -10,7 +10,7 @@
 #ifndef CCID_H
 #define CCID_H
=20
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
=20
 typedef struct CCIDCardState CCIDCardState;
 typedef struct CCIDCardInfo CCIDCardInfo;
diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index c0f35c58d5..d3ca3bd1ab 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -31,6 +31,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/module.h"
+#include "hw/qdev-properties.h"
 #include "hw/usb.h"
 #include "migration/vmstate.h"
 #include "desc.h"
diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index 79b3be3c3f..88492f26e6 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -32,6 +32,7 @@
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/input/hid.h"
+#include "hw/qdev-properties.h"
=20
 /* HID interface requests */
 #define GET_REPORT   0xa101
diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index 886423bdec..07ecfefc12 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "trace.h"
+#include "hw/qdev-properties.h"
 #include "hw/usb.h"
 #include "migration/vmstate.h"
 #include "desc.h"
diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 2e2a47ff7c..9846e4b513 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -23,6 +23,7 @@
 #include "qemu/module.h"
 #include "qemu/filemonitor.h"
 #include "trace.h"
+#include "hw/qdev-properties.h"
 #include "hw/usb.h"
 #include "migration/vmstate.h"
 #include "desc.h"
diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index db928d7cdf..5de6213cc4 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -25,6 +25,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "hw/qdev-properties.h"
 #include "hw/usb.h"
 #include "migration/vmstate.h"
 #include "desc.h"
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 039dc4889f..45cc74128a 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -13,6 +13,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "hw/qdev-properties.h"
 #include "hw/usb.h"
 #include "migration/vmstate.h"
 #include "desc.h"
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.=
c
index 57a0cbcae7..4568db2568 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -40,6 +40,7 @@
 #include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "hw/qdev-properties.h"
 #include "hw/usb.h"
 #include "migration/vmstate.h"
 #include "desc.h"
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 8bc5d8728a..8545193488 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -15,6 +15,7 @@
 #include "qemu/config-file.h"
 #include "hw/usb.h"
 #include "desc.h"
+#include "hw/qdev-properties.h"
 #include "hw/scsi/scsi.h"
 #include "ui/console.h"
 #include "migration/vmstate.h"
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index c7d215d4ef..6d6d1073b9 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -20,6 +20,7 @@
 #include "hw/usb.h"
 #include "migration/vmstate.h"
 #include "desc.h"
+#include "hw/qdev-properties.h"
 #include "hw/scsi/scsi.h"
 #include "scsi/constants.h"
=20
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index 7232dee882..5b9a8d3dc1 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -16,6 +16,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
 #include "hw/usb/hcd-ehci.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index 9a509f3b08..020211fd10 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -16,6 +16,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/qdev-properties.h"
 #include "hw/usb/hcd-ehci.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c
index 25b0ced804..c052f10521 100644
--- a/hw/usb/hcd-ohci-pci.c
+++ b/hw/usb/hcd-ohci-pci.c
@@ -26,6 +26,7 @@
 #include "hw/pci/pci.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-dma.h"
+#include "hw/qdev-properties.h"
 #include "trace.h"
 #include "hcd-ohci.h"
=20
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 94b3410d3c..145ee21fd6 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -34,6 +34,7 @@
 #include "migration/vmstate.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-dma.h"
+#include "hw/qdev-properties.h"
 #include "trace.h"
 #include "hcd-ohci.h"
=20
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 7c6edd17b4..23507ad3b5 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -31,6 +31,7 @@
 #include "hw/usb/uhci-regs.h"
 #include "migration/vmstate.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "qemu/iov.h"
diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index aba3716875..05fb3f54b3 100644
--- a/hw/usb/hcd-xhci-nec.c
+++ b/hw/usb/hcd-xhci-nec.c
@@ -23,6 +23,7 @@
 #include "hw/usb.h"
 #include "qemu/module.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
=20
 #include "hcd-xhci.h"
=20
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index d60ad895a3..f698224c8a 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -26,6 +26,7 @@
 #include "hw/usb.h"
 #include "migration/vmstate.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "trace.h"
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index c043487298..80fd1e9a80 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -48,6 +48,7 @@
 #include "sysemu/sysemu.h"
 #include "trace.h"
=20
+#include "hw/qdev-properties.h"
 #include "hw/usb.h"
=20
 /* ---------------------------------------------------------------------=
--- */
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 84ec3d5219..8db2c68a1e 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -40,6 +40,7 @@
 #include <usbredirparser.h>
 #include <usbredirfilter.h>
=20
+#include "hw/qdev-properties.h"
 #include "hw/usb.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 2bfc402037..d53453aad6 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -26,6 +26,7 @@
 #include "kvm_s390x.h"
 #include "migration/vmstate.h"
 #include "sysemu/sysemu.h"
+#include "hw/qdev-properties.h"
 #include "hw/s390x/ap-bridge.h"
 #include "exec/address-spaces.h"
=20
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index c78a85a864..6863f6c69f 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -25,6 +25,7 @@
 #include "hw/vfio/vfio-common.h"
 #include "hw/s390x/s390-ccw.h"
 #include "hw/s390x/vfio-ccw.h"
+#include "hw/qdev-properties.h"
 #include "hw/s390x/ccw-device.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 62d765a4ea..f71aace156 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -21,6 +21,7 @@
 #include <sys/ioctl.h>
 #include "hw/hw.h"
 #include "hw/nvram/fw_cfg.h"
+#include "hw/qdev-properties.h"
 #include "pci.h"
 #include "trace.h"
=20
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ab3ee2ca7a..8337af8434 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -26,6 +26,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_bridge.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index ff5f805d68..d14f6b4a7a 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -33,6 +33,7 @@
 #include "trace.h"
 #include "hw/irq.h"
 #include "hw/platform-bus.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/kvm.h"
=20
 /*
diff --git a/hw/virtio/vhost-scsi-pci.c b/hw/virtio/vhost-scsi-pci.c
index 95a1f32439..e8dfbfc60f 100644
--- a/hw/virtio/vhost-scsi-pci.c
+++ b/hw/virtio/vhost-scsi-pci.c
@@ -17,6 +17,7 @@
 #include "qemu/osdep.h"
=20
 #include "standard-headers/linux/virtio_pci.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/vhost-scsi.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/virtio/vhost-user-blk-pci.c b/hw/virtio/vhost-user-blk-pc=
i.c
index ed81614d43..1dc834a3ff 100644
--- a/hw/virtio/vhost-user-blk-pci.c
+++ b/hw/virtio/vhost-user-blk-pci.c
@@ -22,6 +22,7 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/vhost-user-blk.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/virtio/vhost-user-scsi-pci.c b/hw/virtio/vhost-user-scsi-=
pci.c
index daeea77ce1..ff13af7030 100644
--- a/hw/virtio/vhost-user-scsi-pci.c
+++ b/hw/virtio/vhost-user-scsi-pci.c
@@ -22,6 +22,7 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-scsi.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/virtio/vhost-vsock-pci.c b/hw/virtio/vhost-vsock-pci.c
index c06c9a83b9..4ca097ffff 100644
--- a/hw/virtio/vhost-vsock-pci.c
+++ b/hw/virtio/vhost-vsock-pci.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
=20
 #include "virtio-pci.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "qemu/module.h"
=20
diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 0371493197..f5744363a8 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -18,6 +18,7 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
 #include "qemu/error-report.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "qemu/iov.h"
 #include "qemu/module.h"
diff --git a/hw/virtio/virtio-9p-pci.c b/hw/virtio/virtio-9p-pci.c
index 29c3712feb..22a183cca7 100644
--- a/hw/virtio/virtio-9p-pci.c
+++ b/hw/virtio/virtio-9p-pci.c
@@ -17,6 +17,7 @@
=20
 #include "virtio-pci.h"
 #include "hw/9pfs/virtio-9p.h"
+#include "hw/qdev-properties.h"
 #include "qemu/module.h"
=20
 /*
diff --git a/hw/virtio/virtio-balloon-pci.c b/hw/virtio/virtio-balloon-pc=
i.c
index 7393435a98..69ca057911 100644
--- a/hw/virtio/virtio-balloon-pci.c
+++ b/hw/virtio/virtio-balloon-pci.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
=20
 #include "virtio-pci.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-balloon.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 25de154307..40b04f5180 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -19,6 +19,7 @@
 #include "qemu/timer.h"
 #include "hw/virtio/virtio.h"
 #include "hw/mem/pc-dimm.h"
+#include "hw/qdev-properties.h"
 #include "sysemu/balloon.h"
 #include "hw/virtio/virtio-balloon.h"
 #include "exec/address-spaces.h"
diff --git a/hw/virtio/virtio-blk-pci.c b/hw/virtio/virtio-blk-pci.c
index d790b07a99..d9b69a5af3 100644
--- a/hw/virtio/virtio-blk-pci.c
+++ b/hw/virtio/virtio-blk-pci.c
@@ -17,6 +17,7 @@
=20
 #include "qemu/osdep.h"
=20
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-blk.h"
 #include "virtio-pci.h"
 #include "qapi/error.h"
diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index 207e955996..b2c804292e 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -26,7 +26,6 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "hw/qdev.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio.h"
 #include "exec/address-spaces.h"
diff --git a/hw/virtio/virtio-crypto-pci.c b/hw/virtio/virtio-crypto-pci.=
c
index 91d4446080..d853dc460c 100644
--- a/hw/virtio/virtio-crypto-pci.c
+++ b/hw/virtio/virtio-crypto-pci.c
@@ -14,6 +14,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-pci.h"
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index dbfaee6d7c..6d42f95a89 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -15,12 +15,12 @@
 #include "qemu/iov.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
-#include "hw/qdev.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
=20
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-crypto.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-access.h"
 #include "standard-headers/linux/virtio_ids.h"
 #include "sysemu/cryptodev-vhost.h"
diff --git a/hw/virtio/virtio-input-pci.c b/hw/virtio/virtio-input-pci.c
index ad7774e93e..80b1172c90 100644
--- a/hw/virtio/virtio-input-pci.c
+++ b/hw/virtio/virtio-input-pci.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
=20
 #include "virtio-pci.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-input.h"
 #include "qemu/module.h"
=20
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 3dc525dea4..eccc795f28 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include "standard-headers/linux/virtio_mmio.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "hw/virtio/virtio.h"
 #include "migration/qemu-file-types.h"
diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
index 5df36f26bf..f670aed0a7 100644
--- a/hw/virtio/virtio-net-pci.c
+++ b/hw/virtio/virtio-net-pci.c
@@ -17,6 +17,7 @@
=20
 #include "qemu/osdep.h"
=20
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-net.h"
 #include "virtio-pci.h"
 #include "qapi/error.h"
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 1117f2347b..8babd92e59 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -22,6 +22,7 @@
 #include "migration/qemu-file-types.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
+#include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index ca487f63d2..ff1a2ddb36 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -17,6 +17,7 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "hw/virtio/virtio-pmem.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-access.h"
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_pmem.h"
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index db6d1d9454..34b4619fd3 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -13,8 +13,8 @@
 #include "qapi/error.h"
 #include "qemu/iov.h"
 #include "qemu/module.h"
-#include "hw/qdev.h"
 #include "hw/virtio/virtio.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-rng.h"
 #include "sysemu/rng.h"
 #include "qom/object_interfaces.h"
diff --git a/hw/virtio/virtio-scsi-pci.c b/hw/virtio/virtio-scsi-pci.c
index f68f689aee..3c55dc19a1 100644
--- a/hw/virtio/virtio-scsi-pci.c
+++ b/hw/virtio/virtio-scsi-pci.c
@@ -15,6 +15,7 @@
=20
 #include "qemu/osdep.h"
=20
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-scsi.h"
 #include "qemu/module.h"
 #include "virtio-pci.h"
diff --git a/hw/virtio/virtio-serial-pci.c b/hw/virtio/virtio-serial-pci.=
c
index ac74b44dae..953abbd13a 100644
--- a/hw/virtio/virtio-serial-pci.c
+++ b/hw/virtio/virtio-serial-pci.c
@@ -17,6 +17,7 @@
=20
 #include "qemu/osdep.h"
=20
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-serial.h"
 #include "qemu/module.h"
 #include "virtio-pci.h"
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index f4c8337930..721dcccc96 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -23,6 +23,7 @@
 #include "migration/qemu-file-types.h"
 #include "qemu/atomic.h"
 #include "hw/virtio/virtio-bus.h"
+#include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-access.h"
 #include "sysemu/dma.h"
=20
diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-wat=
chdog.c
index 3140e91959..6bf43f943f 100644
--- a/hw/watchdog/cmsdk-apb-watchdog.c
+++ b/hw/watchdog/cmsdk-apb-watchdog.c
@@ -29,6 +29,7 @@
 #include "sysemu/watchdog.h"
 #include "hw/sysbus.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/registerfields.h"
 #include "hw/watchdog/cmsdk-apb-watchdog.h"
 #include "migration/vmstate.h"
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 49415f132d..9b93213417 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -15,6 +15,7 @@
 #include "qemu/timer.h"
 #include "sysemu/watchdog.h"
 #include "hw/misc/aspeed_scu.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "hw/watchdog/wdt_aspeed.h"
 #include "migration/vmstate.h"
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 3f39a894da..e40500242d 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -9,6 +9,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/uuid.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "hw/xen/xen.h"
 #include "hw/xen/xen-backend.h"
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 47a7c9760a..4412d7aa76 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -27,6 +27,7 @@
=20
 #include "hw/sysbus.h"
 #include "hw/boards.h"
+#include "hw/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 5539d56c3a..8fbaf2eae9 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -57,6 +57,7 @@
 #include <sys/ioctl.h>
=20
 #include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
 #include "hw/xen/xen.h"
 #include "hw/i386/pc.h"
 #include "hw/xen/xen-legacy-backend.h"
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 83103974ab..62119d2555 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -32,6 +32,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
+#include "hw/qdev-properties.h"
 #include "elf.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_=
dev_interface.h
index 6465072b7d..0ba90effd2 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -4,6 +4,7 @@
 #include "qapi/qapi-types-misc.h"
 #include "qom/object.h"
 #include "hw/boards.h"
+#include "hw/qdev-core.h"
=20
 /* These values are part of guest ABI, and can not be changed */
 typedef enum {
diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
index 38586ecbdf..c49d913f3e 100644
--- a/include/hw/acpi/vmgenid.h
+++ b/include/hw/acpi/vmgenid.h
@@ -2,7 +2,7 @@
 #define ACPI_VMGENID_H
=20
 #include "hw/acpi/bios-linker-loader.h"
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
 #include "qemu/uuid.h"
=20
 #define VMGENID_DEVICE           "vmgenid"
diff --git a/include/hw/audio/pcspk.h b/include/hw/audio/pcspk.h
index 0f5d4f9919..632cce9f68 100644
--- a/include/hw/audio/pcspk.h
+++ b/include/hw/audio/pcspk.h
@@ -26,6 +26,7 @@
 #define HW_PCSPK_H
=20
 #include "hw/isa/isa.h"
+#include "hw/qdev-properties.h"
=20
 #define TYPE_PC_SPEAKER "isa-pcspk"
=20
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 3a0be3131a..67e551636a 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -6,7 +6,6 @@
 #include "exec/memory.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/accel.h"
-#include "hw/qdev.h"
 #include "qapi/qapi-types-machine.h"
 #include "qemu/module.h"
 #include "qom/object.h"
diff --git a/include/hw/char/cadence_uart.h b/include/hw/char/cadence_uar=
t.h
index e1cf33e94c..47cec956c4 100644
--- a/include/hw/char/cadence_uart.h
+++ b/include/hw/char/cadence_uart.h
@@ -19,6 +19,7 @@
 #ifndef CADENCE_UART_H
 #define CADENCE_UART_H
=20
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qemu/timer.h"
diff --git a/include/hw/char/cmsdk-apb-uart.h b/include/hw/char/cmsdk-apb=
-uart.h
index c41fba9a27..3c1b53db4e 100644
--- a/include/hw/char/cmsdk-apb-uart.h
+++ b/include/hw/char/cmsdk-apb-uart.h
@@ -12,6 +12,7 @@
 #ifndef CMSDK_APB_UART_H
 #define CMSDK_APB_UART_H
=20
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
=20
diff --git a/include/hw/char/lm32_juart.h b/include/hw/char/lm32_juart.h
index e7c6fb5a3b..6fce278326 100644
--- a/include/hw/char/lm32_juart.h
+++ b/include/hw/char/lm32_juart.h
@@ -1,7 +1,7 @@
 #ifndef QEMU_HW_CHAR_LM32_JUART_H
 #define QEMU_HW_CHAR_LM32_JUART_H
=20
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
=20
 #define TYPE_LM32_JUART "lm32-juart"
=20
diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
index dad3cf2912..14187165c6 100644
--- a/include/hw/char/pl011.h
+++ b/include/hw/char/pl011.h
@@ -15,6 +15,7 @@
 #ifndef HW_PL011_H
 #define HW_PL011_H
=20
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
=20
diff --git a/include/hw/char/xilinx_uartlite.h b/include/hw/char/xilinx_u=
artlite.h
index 99d8bbf405..194e2feafe 100644
--- a/include/hw/char/xilinx_uartlite.h
+++ b/include/hw/char/xilinx_uartlite.h
@@ -15,6 +15,7 @@
 #ifndef XILINX_UARTLITE_H
 #define XILINX_UARTLITE_H
=20
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
=20
 static inline DeviceState *xilinx_uartlite_create(hwaddr addr,
diff --git a/include/hw/cpu/cluster.h b/include/hw/cpu/cluster.h
index 01c1e50cd2..a616501a55 100644
--- a/include/hw/cpu/cluster.h
+++ b/include/hw/cpu/cluster.h
@@ -20,7 +20,7 @@
 #ifndef HW_CPU_CLUSTER_H
 #define HW_CPU_CLUSTER_H
=20
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
=20
 /*
  * CPU Cluster type
diff --git a/include/hw/cpu/core.h b/include/hw/cpu/core.h
index b7470644d8..555ad831bb 100644
--- a/include/hw/cpu/core.h
+++ b/include/hw/cpu/core.h
@@ -9,7 +9,7 @@
 #ifndef HW_CPU_CORE_H
 #define HW_CPU_CORE_H
=20
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
=20
 #define TYPE_CPU_CORE "cpu-core"
=20
diff --git a/include/hw/cris/etraxfs.h b/include/hw/cris/etraxfs.h
index 494222d315..aa146a2cd8 100644
--- a/include/hw/cris/etraxfs.h
+++ b/include/hw/cris/etraxfs.h
@@ -27,6 +27,7 @@
=20
 #include "net/net.h"
 #include "hw/cris/etraxfs_dma.h"
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
=20
 /* Instantiate an ETRAXFS Ethernet MAC.  */
diff --git a/include/hw/display/milkymist_tmu2.h b/include/hw/display/mil=
kymist_tmu2.h
index 1fd978dcc5..e3394ff158 100644
--- a/include/hw/display/milkymist_tmu2.h
+++ b/include/hw/display/milkymist_tmu2.h
@@ -28,7 +28,7 @@
 #define HW_DISPLAY_MILKYMIST_TMU2_H
=20
 #include "exec/hwaddr.h"
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
=20
 #if defined(CONFIG_X11) && defined(CONFIG_OPENGL)
 DeviceState *milkymist_tmu2_create(hwaddr base, qemu_irq irq);
diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index 75c5bd638b..4117211565 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -1,7 +1,7 @@
 #ifndef QEMU_I2C_H
 #define QEMU_I2C_H
=20
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
=20
 /* The QEMU I2C implementation only supports simple transfers that compl=
ete
    immediately.  It does not support slave devices that need to be able =
to
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.=
h
index 12f3d266e2..66b931e526 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -21,7 +21,7 @@
=20
 #ifndef INTEL_IOMMU_H
 #define INTEL_IOMMU_H
-#include "hw/qdev.h"
+
 #include "sysemu/dma.h"
 #include "hw/i386/x86-iommu.h"
 #include "hw/i386/ioapic.h"
diff --git a/include/hw/input/adb.h b/include/hw/input/adb.h
index f99d478252..b7b32e2b16 100644
--- a/include/hw/input/adb.h
+++ b/include/hw/input/adb.h
@@ -26,7 +26,7 @@
 #ifndef ADB_H
 #define ADB_H
=20
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
=20
 #define MAX_ADB_DEVICES 16
=20
diff --git a/include/hw/ipack/ipack.h b/include/hw/ipack/ipack.h
index e33e032ced..1c07969bc9 100644
--- a/include/hw/ipack/ipack.h
+++ b/include/hw/ipack/ipack.h
@@ -11,7 +11,7 @@
 #ifndef QEMU_IPACK_H
 #define QEMU_IPACK_H
=20
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
=20
 typedef struct IPackBus IPackBus;
=20
diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
index 011faf22e9..70871da0a7 100644
--- a/include/hw/ipmi/ipmi.h
+++ b/include/hw/ipmi/ipmi.h
@@ -26,7 +26,7 @@
 #define HW_IPMI_H
=20
 #include "exec/memory.h"
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
=20
 #define MAX_IPMI_MSG_SIZE 300
=20
diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index e62ac91c19..018ada4f6f 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -5,7 +5,7 @@
=20
 #include "exec/memory.h"
 #include "exec/ioport.h"
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
=20
 #define ISA_NUM_IRQS 16
=20
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-devic=
e.h
index 2ada6e7bde..04476acb8f 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -13,9 +13,9 @@
 #ifndef MEMORY_DEVICE_H
 #define MEMORY_DEVICE_H
=20
+#include "hw/qdev-core.h"
 #include "qapi/qapi-types-misc.h"
 #include "qom/object.h"
-#include "hw/qdev.h"
=20
 #define TYPE_MEMORY_DEVICE "memory-device"
=20
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 01436b9f50..66dee284ac 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -18,7 +18,7 @@
=20
 #include "exec/memory.h"
 #include "sysemu/hostmem.h"
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
 #include "hw/boards.h"
=20
 #define TYPE_PC_DIMM "pc-dimm"
diff --git a/include/hw/misc/auxbus.h b/include/hw/misc/auxbus.h
index ee0ca3dd51..a539a98c4b 100644
--- a/include/hw/misc/auxbus.h
+++ b/include/hw/misc/auxbus.h
@@ -26,7 +26,7 @@
 #define HW_MISC_AUXBUS_H
=20
 #include "exec/memory.h"
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
=20
 typedef struct AUXBus AUXBus;
 typedef struct AUXSlave AUXSlave;
diff --git a/include/hw/misc/unimp.h b/include/hw/misc/unimp.h
index 2a291ca42d..44d87be903 100644
--- a/include/hw/misc/unimp.h
+++ b/include/hw/misc/unimp.h
@@ -8,6 +8,7 @@
 #ifndef HW_MISC_UNIMP_H
 #define HW_MISC_UNIMP_H
=20
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
=20
 #define TYPE_UNIMPLEMENTED_DEVICE "unimplemented-device"
diff --git a/include/hw/misc/vmcoreinfo.h b/include/hw/misc/vmcoreinfo.h
index 0d11578059..d4f3d3a91c 100644
--- a/include/hw/misc/vmcoreinfo.h
+++ b/include/hw/misc/vmcoreinfo.h
@@ -12,7 +12,7 @@
 #ifndef VMCOREINFO_H
 #define VMCOREINFO_H
=20
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
 #include "standard-headers/linux/qemu_fw_cfg.h"
=20
 #define VMCOREINFO_DEVICE "vmcoreinfo"
diff --git a/include/hw/net/ne2000-isa.h b/include/hw/net/ne2000-isa.h
index 1233928a34..eef17a680d 100644
--- a/include/hw/net/ne2000-isa.h
+++ b/include/hw/net/ne2000-isa.h
@@ -10,8 +10,8 @@
 #ifndef HW_NET_NE2000_ISA_H
 #define HW_NET_NE2000_ISA_H
=20
-#include "hw/qdev.h"
 #include "hw/isa/isa.h"
+#include "hw/qdev-properties.h"
 #include "net/net.h"
=20
 #define TYPE_ISA_NE2000 "ne2k_isa"
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index aaf1b9f70d..1b840e61a2 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -1,7 +1,6 @@
 #ifndef QEMU_PCI_H
 #define QEMU_PCI_H
=20
-#include "hw/qdev.h"
 #include "exec/memory.h"
 #include "sysemu/dma.h"
=20
diff --git a/include/hw/pcmcia.h b/include/hw/pcmcia.h
index 1b4080764f..ebad7bc504 100644
--- a/include/hw/pcmcia.h
+++ b/include/hw/pcmcia.h
@@ -3,7 +3,7 @@
=20
 /* PCMCIA/Cardbus */
=20
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
=20
 typedef struct PCMCIASocket {
     qemu_irq irq;
diff --git a/include/hw/ppc/openpic.h b/include/hw/ppc/openpic.h
index 7642a8ea1d..ec16897bfb 100644
--- a/include/hw/ppc/openpic.h
+++ b/include/hw/ppc/openpic.h
@@ -2,7 +2,6 @@
 #define OPENPIC_H
=20
 #include "hw/sysbus.h"
-#include "hw/qdev-core.h"
 #include "qom/cpu.h"
=20
 #define MAX_CPU     32
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_c=
ore.h
index f9645a7290..35e0a7eead 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -9,8 +9,8 @@
 #ifndef HW_SPAPR_CPU_CORE_H
 #define HW_SPAPR_CPU_CORE_H
=20
-#include "hw/qdev.h"
 #include "hw/cpu/core.h"
+#include "hw/qdev-core.h"
 #include "target/ppc/cpu-qom.h"
 #include "target/ppc/cpu.h"
=20
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 576c711b86..721213d5b0 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -16,7 +16,7 @@
 #include <libfdt.h>
 #include "qom/object.h"
 #include "sysemu/sysemu.h"
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
 #include "qapi/error.h"
=20
 #define TYPE_SPAPR_DR_CONNECTOR "spapr-dr-connector"
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 457aa98f81..f2a8d6a4b4 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -29,7 +29,7 @@
 #define XICS_H
=20
 #include "exec/memory.h"
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
=20
 #define XICS_IPI        0x2
 #define XICS_BUID       0x1
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 55c53c7417..e10b96b10a 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -141,7 +141,6 @@
 #define PPC_XIVE_H
=20
 #include "sysemu/kvm.h"
-#include "hw/qdev-core.h"
 #include "hw/sysbus.h"
 #include "hw/ppc/xive_regs.h"
=20
diff --git a/include/hw/qdev.h b/include/hw/qdev.h
deleted file mode 100644
index d68991ae87..0000000000
--- a/include/hw/qdev.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef QDEV_H
-#define QDEV_H
-
-#include "hw/qdev-core.h"
-#include "hw/qdev-properties.h"
-
-#endif
diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-f=
acility.h
index 6cf71cec38..bdc32a3c09 100644
--- a/include/hw/s390x/event-facility.h
+++ b/include/hw/s390x/event-facility.h
@@ -15,8 +15,8 @@
 #ifndef HW_S390_SCLP_EVENT_FACILITY_H
 #define HW_S390_SCLP_EVENT_FACILITY_H
=20
-#include "hw/qdev.h"
 #include "qemu/thread.h"
+#include "hw/qdev-core.h"
 #include "hw/s390x/sclp.h"
=20
 /* SCLP event types */
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index f9db243484..c54413b78c 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -15,7 +15,6 @@
 #define HW_S390_SCLP_H
=20
 #include "hw/sysbus.h"
-#include "hw/qdev.h"
 #include "target/s390x/cpu-qom.h"
=20
 #define SCLP_CMD_CODE_MASK                      0xffff00ff
diff --git a/include/hw/s390x/storage-attributes.h b/include/hw/s390x/sto=
rage-attributes.h
index d6403a0a7e..4f7c6c0877 100644
--- a/include/hw/s390x/storage-attributes.h
+++ b/include/hw/s390x/storage-attributes.h
@@ -12,7 +12,7 @@
 #ifndef S390_STORAGE_ATTRIBUTES_H
 #define S390_STORAGE_ATTRIBUTES_H
=20
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
 #include "monitor/monitor.h"
=20
 #define TYPE_S390_STATTRIB "s390-storage_attributes"
diff --git a/include/hw/s390x/storage-keys.h b/include/hw/s390x/storage-k=
eys.h
index 62df48ec06..3f1ae7e778 100644
--- a/include/hw/s390x/storage-keys.h
+++ b/include/hw/s390x/storage-keys.h
@@ -12,7 +12,7 @@
 #ifndef S390_STORAGE_KEYS_H
 #define S390_STORAGE_KEYS_H
=20
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
 #include "monitor/monitor.h"
=20
 #define TYPE_S390_SKEYS "s390-skeys"
diff --git a/include/hw/s390x/tod.h b/include/hw/s390x/tod.h
index d71f4ea8a7..4251623f7f 100644
--- a/include/hw/s390x/tod.h
+++ b/include/hw/s390x/tod.h
@@ -11,7 +11,7 @@
 #ifndef HW_S390_TOD_H
 #define HW_S390_TOD_H
=20
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
 #include "target/s390x/s390-tod.h"
=20
 typedef struct S390TOD {
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 15a763dc18..2bfaad0fe9 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -1,9 +1,9 @@
 #ifndef QEMU_HW_SCSI_H
 #define QEMU_HW_SCSI_H
=20
-#include "hw/qdev.h"
 #include "block/aio.h"
 #include "hw/block/block.h"
+#include "hw/qdev-core.h"
 #include "sysemu/sysemu.h"
 #include "scsi/utils.h"
 #include "qemu/notify.h"
diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index b865aafc33..a84b8e274a 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -30,7 +30,7 @@
 #ifndef HW_SD_H
 #define HW_SD_H
=20
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
=20
 #define OUT_OF_RANGE		(1 << 31)
 #define ADDRESS_ERROR		(1 << 30)
diff --git a/include/hw/sparc/grlib.h b/include/hw/sparc/grlib.h
index 5606ff0a97..78b6178fcd 100644
--- a/include/hw/sparc/grlib.h
+++ b/include/hw/sparc/grlib.h
@@ -25,7 +25,6 @@
 #ifndef GRLIB_H
 #define GRLIB_H
=20
-#include "hw/qdev.h"
 #include "hw/sysbus.h"
=20
 /* Emulation of GrLib device is base on the GRLIB IP Core User's Manual:
diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
index 6a0c3c3cdb..1107cb89ee 100644
--- a/include/hw/ssi/ssi.h
+++ b/include/hw/ssi/ssi.h
@@ -11,7 +11,7 @@
 #ifndef QEMU_SSI_H
 #define QEMU_SSI_H
=20
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
=20
 typedef struct SSISlave SSISlave;
 typedef struct SSISlaveClass SSISlaveClass;
diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index 4c668fbbdc..27e80881da 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -3,7 +3,7 @@
=20
 /* Devices attached directly to the main system bus.  */
=20
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
 #include "exec/memory.h"
=20
 #define QDEV_MAX_MMIO 32
diff --git a/include/hw/timer/cmsdk-apb-timer.h b/include/hw/timer/cmsdk-=
apb-timer.h
index f21686d26b..e93caccc3c 100644
--- a/include/hw/timer/cmsdk-apb-timer.h
+++ b/include/hw/timer/cmsdk-apb-timer.h
@@ -12,6 +12,7 @@
 #ifndef CMSDK_APB_TIMER_H
 #define CMSDK_APB_TIMER_H
=20
+#include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "hw/ptimer.h"
=20
diff --git a/include/hw/timer/i8254.h b/include/hw/timer/i8254.h
index 608b116fcf..45cb42571f 100644
--- a/include/hw/timer/i8254.h
+++ b/include/hw/timer/i8254.h
@@ -25,7 +25,7 @@
 #ifndef HW_I8254_H
 #define HW_I8254_H
=20
-#include "hw/qdev.h"
+#include "hw/qdev-properties.h"
 #include "hw/isa/isa.h"
=20
 #define PIT_FREQ 1193182
diff --git a/include/hw/usb.h b/include/hw/usb.h
index 96971a4c26..c24d968a19 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -26,7 +26,7 @@
  */
=20
 #include "exec/memory.h"
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
 #include "qemu/iov.h"
 #include "qemu/queue.h"
=20
diff --git a/include/hw/virtio/vhost-scsi-common.h b/include/hw/virtio/vh=
ost-scsi-common.h
index 54357164f0..16bf1a73c1 100644
--- a/include/hw/virtio/vhost-scsi-common.h
+++ b/include/hw/virtio/vhost-scsi-common.h
@@ -14,7 +14,6 @@
 #ifndef VHOST_SCSI_COMMON_H
 #define VHOST_SCSI_COMMON_H
=20
-#include "hw/qdev.h"
 #include "hw/virtio/virtio-scsi.h"
 #include "hw/virtio/vhost.h"
 #include "hw/fw-path-provider.h"
diff --git a/include/hw/virtio/vhost-scsi.h b/include/hw/virtio/vhost-scs=
i.h
index df5bfdb188..23252153ff 100644
--- a/include/hw/virtio/vhost-scsi.h
+++ b/include/hw/virtio/vhost-scsi.h
@@ -14,7 +14,6 @@
 #ifndef VHOST_SCSI_H
 #define VHOST_SCSI_H
=20
-#include "hw/qdev.h"
 #include "hw/virtio/virtio-scsi.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-scsi-common.h"
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost=
-user-blk.h
index 8dbf11c6f0..108bfadeeb 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -16,7 +16,6 @@
 #define VHOST_USER_BLK_H
=20
 #include "standard-headers/linux/virtio_blk.h"
-#include "hw/qdev.h"
 #include "hw/block/block.h"
 #include "chardev/char-fe.h"
 #include "hw/virtio/vhost.h"
diff --git a/include/hw/virtio/vhost-user-scsi.h b/include/hw/virtio/vhos=
t-user-scsi.h
index 1b332ea910..99ab2f2cc4 100644
--- a/include/hw/virtio/vhost-user-scsi.h
+++ b/include/hw/virtio/vhost-user-scsi.h
@@ -17,7 +17,6 @@
 #ifndef VHOST_USER_SCSI_H
 #define VHOST_USER_SCSI_H
=20
-#include "hw/qdev.h"
 #include "hw/virtio/virtio-scsi.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-user.h"
diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bu=
s.h
index 7fec9dc929..8c9cc25b16 100644
--- a/include/hw/virtio/virtio-bus.h
+++ b/include/hw/virtio/virtio-bus.h
@@ -25,8 +25,8 @@
 #ifndef VIRTIO_BUS_H
 #define VIRTIO_BUS_H
=20
-#include "hw/qdev.h"
 #include "sysemu/sysemu.h"
+#include "hw/qdev-core.h"
 #include "hw/virtio/virtio.h"
=20
 #define TYPE_VIRTIO_BUS "virtio-bus"
diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/virtio=
-serial.h
index 12657a9f39..ed3e916b68 100644
--- a/include/hw/virtio/virtio-serial.h
+++ b/include/hw/virtio/virtio-serial.h
@@ -17,7 +17,6 @@
 #define QEMU_VIRTIO_SERIAL_H
=20
 #include "standard-headers/linux/virtio_console.h"
-#include "hw/qdev.h"
 #include "hw/virtio/virtio.h"
=20
 struct virtio_serial_conf {
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 7bae09e3ae..df40a46d60 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -15,8 +15,8 @@
 #define QEMU_VIRTIO_H
=20
 #include "exec/memory.h"
+#include "hw/qdev-core.h"
 #include "net/net.h"
-#include "hw/qdev.h"
 #include "sysemu/sysemu.h"
 #include "migration/vmstate.h"
 #include "qemu/event_notifier.h"
diff --git a/include/hw/watchdog/wdt_diag288.h b/include/hw/watchdog/wdt_=
diag288.h
index 706d96b753..19d83a0937 100644
--- a/include/hw/watchdog/wdt_diag288.h
+++ b/include/hw/watchdog/wdt_diag288.h
@@ -1,7 +1,7 @@
 #ifndef WDT_DIAG288_H
 #define WDT_DIAG288_H
=20
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
=20
 #define TYPE_WDT_DIAG288 "diag288"
 #define DIAG288(obj) \
diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
index 084799e4d9..eaa947d73a 100644
--- a/include/monitor/qdev.h
+++ b/include/monitor/qdev.h
@@ -1,8 +1,6 @@
 #ifndef MONITOR_QDEV_H
 #define MONITOR_QDEV_H
=20
-#include "hw/qdev-core.h"
-
 /*** monitor commands ***/
=20
 void hmp_info_qtree(Monitor *mon, const QDict *qdict);
diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
index 89ce57e404..8eb60b870b 100644
--- a/include/sysemu/accel.h
+++ b/include/sysemu/accel.h
@@ -24,7 +24,6 @@
 #define HW_ACCEL_H
=20
 #include "qom/object.h"
-#include "hw/qdev-properties.h"
 #include "exec/hwaddr.h"
=20
 typedef struct AccelState {
diff --git a/memory.c b/memory.c
index cbf0e5a6cc..c3486b0f28 100644
--- a/memory.c
+++ b/memory.c
@@ -32,7 +32,6 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/tcg.h"
 #include "sysemu/accel.h"
-#include "hw/qdev-properties.h"
 #include "hw/boards.h"
 #include "migration/vmstate.h"
=20
diff --git a/migration/migration.c b/migration/migration.c
index 85e5d22e32..3a6340f602 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -47,6 +47,7 @@
 #include "io/channel-buffer.h"
 #include "migration/colo.h"
 #include "hw/boards.h"
+#include "hw/qdev-properties.h"
 #include "monitor/monitor.h"
 #include "net/announce.h"
=20
diff --git a/migration/migration.h b/migration/migration.h
index a7882af67a..b150937180 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -15,10 +15,10 @@
 #define QEMU_MIGRATION_H
=20
 #include "exec/cpu-common.h"
+#include "hw/qdev-core.h"
 #include "qapi/qapi-types-migration.h"
 #include "qemu/thread.h"
 #include "qemu/coroutine_int.h"
-#include "hw/qdev.h"
 #include "io/channel.h"
 #include "net/announce.h"
=20
diff --git a/net/net.c b/net/net.c
index 7d4098254f..11b505a6fd 100644
--- a/net/net.c
+++ b/net/net.c
@@ -27,6 +27,7 @@
 #include "net/net.h"
 #include "clients.h"
 #include "hub.h"
+#include "hw/qdev-properties.h"
 #include "net/slirp.h"
 #include "net/eth.h"
 #include "util.h"
@@ -42,7 +43,6 @@
 #include "qemu/cutils.h"
 #include "qemu/config-file.h"
 #include "qemu/ctype.h"
-#include "hw/qdev.h"
 #include "qemu/iov.h"
 #include "qemu/main-loop.h"
 #include "qemu/option.h"
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 58222c2211..21c1c301d0 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -18,7 +18,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/qdev.h"
 #include "hw/sysbus.h"
 #include "monitor/monitor.h"
 #include "monitor/qdev.h"
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index e046a0f190..236e8e41dd 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -14,7 +14,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/qdev.h"
+#include "hw/qdev-core.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-qdev.h"
 #include "qapi/qapi-commands-qom.h"
diff --git a/qtest.c b/qtest.c
index 15e27e911f..313821faed 100644
--- a/qtest.c
+++ b/qtest.c
@@ -15,7 +15,6 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "sysemu/qtest.h"
-#include "hw/qdev.h"
 #include "chardev/char-fe.h"
 #include "exec/ioport.h"
 #include "exec/memory.h"
diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
index 69971247f2..2b2a7ccc31 100644
--- a/target/tilegx/cpu.c
+++ b/target/tilegx/cpu.c
@@ -22,7 +22,6 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "qemu/module.h"
-#include "hw/qdev-properties.h"
 #include "linux-user/syscall_defs.h"
 #include "qemu/qemu-print.h"
 #include "exec/exec-all.h"
diff --git a/tests/test-qdev-global-props.c b/tests/test-qdev-global-prop=
s.c
index 60231b1372..4ed3d06f4e 100644
--- a/tests/test-qdev-global-props.c
+++ b/tests/test-qdev-global-props.c
@@ -24,7 +24,7 @@
=20
 #include "qemu/osdep.h"
=20
-#include "hw/qdev.h"
+#include "hw/qdev-properties.h"
 #include "qom/object.h"
 #include "qapi/visitor.h"
=20
diff --git a/vl.c b/vl.c
index 20328e682c..08ef28f100 100644
--- a/vl.c
+++ b/vl.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/units.h"
+#include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu-version.h"
 #include "qemu/cutils.h"
@@ -65,7 +66,6 @@ int main(int argc, char **argv)
 #include "hw/firmware/smbios.h"
 #include "hw/acpi/acpi.h"
 #include "hw/xen/xen.h"
-#include "hw/qdev.h"
 #include "hw/loader.h"
 #include "monitor/qdev.h"
 #include "sysemu/bt.h"
--=20
2.21.0


