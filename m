Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324AAC31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 07:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC70F208C4
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 07:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC70F208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvyyO-0008HV-1B
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 03:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48541)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hvygM-00010C-Kn
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hvygA-0001rx-AF
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45774)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hvyg8-0001oD-8m
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 32E6130A541A;
 Fri,  9 Aug 2019 06:47:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75FEF608C2;
 Fri,  9 Aug 2019 06:47:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B2FAC113642A; Fri,  9 Aug 2019 08:46:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 08:46:34 +0200
Message-Id: <20190809064645.22656-19-armbru@redhat.com>
In-Reply-To: <20190809064645.22656-1-armbru@redhat.com>
References: <20190809064645.22656-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 09 Aug 2019 06:47:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 18/29] Include hw/hw.h exactly where needed
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

In my "build everything" tree, changing hw/hw.h triggers a recompile
of some 2600 out of 6600 objects (not counting tests and objects that
don't depend on qemu/osdep.h).

The previous commits have left only the declaration of hw_error() in
hw/hw.h.  This permits dropping most of its inclusions.  Touching it
now recompiles less than 200 objects.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 accel/kvm/kvm-all.c                      | 1 -
 audio/audio.c                            | 1 -
 audio/spiceaudio.c                       | 1 -
 audio/wavcapture.c                       | 1 -
 cpus.c                                   | 1 +
 device-hotplug.c                         | 1 -
 exec.c                                   | 1 -
 hw/9pfs/xen-9p-backend.c                 | 1 -
 hw/acpi/core.c                           | 1 -
 hw/acpi/cpu_hotplug.c                    | 1 -
 hw/acpi/ich9.c                           | 1 -
 hw/acpi/pcihp.c                          | 1 -
 hw/acpi/piix4.c                          | 1 -
 hw/adc/stm32f2xx_adc.c                   | 1 -
 hw/alpha/dp264.c                         | 1 -
 hw/alpha/typhoon.c                       | 1 -
 hw/arm/boot.c                            | 1 -
 hw/arm/collie.c                          | 1 -
 hw/arm/gumstix.c                         | 1 -
 hw/arm/integratorcp.c                    | 1 +
 hw/arm/mainstone.c                       | 1 -
 hw/arm/musicpal.c                        | 1 +
 hw/arm/omap2.c                           | 1 -
 hw/arm/omap_sx1.c                        | 1 -
 hw/arm/palm.c                            | 1 -
 hw/arm/pxa2xx_pic.c                      | 1 -
 hw/arm/spitz.c                           | 1 -
 hw/arm/tosa.c                            | 1 -
 hw/arm/virt-acpi-build.c                 | 1 -
 hw/arm/z2.c                              | 1 -
 hw/audio/ac97.c                          | 1 -
 hw/audio/adlib.c                         | 1 -
 hw/audio/cs4231a.c                       | 1 -
 hw/audio/es1370.c                        | 1 -
 hw/audio/gus.c                           | 1 -
 hw/audio/hda-codec.c                     | 1 -
 hw/audio/intel-hda.c                     | 1 -
 hw/audio/marvell_88w8618.c               | 1 -
 hw/audio/milkymist-ac97.c                | 1 -
 hw/audio/pcspk.c                         | 1 -
 hw/audio/sb16.c                          | 1 -
 hw/block/dataplane/xen-block.c           | 1 -
 hw/block/ecc.c                           | 1 -
 hw/block/fdc.c                           | 1 -
 hw/block/m25p80.c                        | 1 -
 hw/block/nvme.c                          | 1 -
 hw/block/pflash_cfi01.c                  | 1 -
 hw/block/pflash_cfi02.c                  | 1 -
 hw/block/tc58128.c                       | 1 -
 hw/block/xen-block.c                     | 1 -
 hw/char/debugcon.c                       | 1 -
 hw/char/digic-uart.c                     | 1 -
 hw/char/escc.c                           | 1 -
 hw/char/lm32_juart.c                     | 1 -
 hw/char/lm32_uart.c                      | 1 -
 hw/char/mcf_uart.c                       | 1 -
 hw/char/milkymist-uart.c                 | 1 -
 hw/char/omap_uart.c                      | 1 -
 hw/char/parallel.c                       | 1 -
 hw/char/sh_serial.c                      | 1 -
 hw/char/xen_console.c                    | 1 -
 hw/char/xilinx_uartlite.c                | 1 +
 hw/core/empty_slot.c                     | 1 -
 hw/core/null-machine.c                   | 1 -
 hw/core/ptimer.c                         | 1 -
 hw/cris/boot.c                           | 1 -
 hw/display/ati.c                         | 1 -
 hw/display/bcm2835_fb.c                  | 1 +
 hw/display/bochs-display.c               | 1 -
 hw/display/cirrus_vga.c                  | 1 -
 hw/display/cirrus_vga_isa.c              | 1 -
 hw/display/exynos4210_fimd.c             | 1 +
 hw/display/framebuffer.c                 | 1 -
 hw/display/milkymist-tmu2.c              | 1 -
 hw/display/omap_lcdc.c                   | 1 -
 hw/display/qxl.h                         | 1 -
 hw/display/sm501.c                       | 1 -
 hw/display/tc6393xb.c                    | 1 -
 hw/display/vga-isa-mm.c                  | 1 -
 hw/display/vga-isa.c                     | 1 -
 hw/display/vga-pci.c                     | 1 -
 hw/display/vga.c                         | 1 -
 hw/display/virtio-vga.c                  | 1 -
 hw/display/vmware_vga.c                  | 1 -
 hw/display/xenfb.c                       | 1 -
 hw/dma/i8257.c                           | 1 -
 hw/dma/pl080.c                           | 1 +
 hw/dma/puv3_dma.c                        | 1 -
 hw/dma/rc4030.c                          | 1 -
 hw/dma/sparc32_dma.c                     | 1 -
 hw/dma/xilinx_axidma.c                   | 1 +
 hw/gpio/max7310.c                        | 1 +
 hw/gpio/omap_gpio.c                      | 1 -
 hw/gpio/puv3_gpio.c                      | 1 -
 hw/gpio/zaurus.c                         | 1 -
 hw/hppa/dino.c                           | 1 -
 hw/hppa/machine.c                        | 1 -
 hw/i2c/bitbang_i2c.c                     | 1 -
 hw/i2c/omap_i2c.c                        | 1 -
 hw/i2c/pm_smbus.c                        | 1 -
 hw/i2c/ppc4xx_i2c.c                      | 1 -
 hw/i2c/smbus_eeprom.c                    | 1 -
 hw/i2c/smbus_ich9.c                      | 1 -
 hw/i2c/smbus_master.c                    | 1 -
 hw/i2c/smbus_slave.c                     | 1 -
 hw/i386/amd_iommu.h                      | 1 -
 hw/i386/multiboot.c                      | 1 -
 hw/i386/pc.c                             | 1 -
 hw/i386/pc_piix.c                        | 1 -
 hw/i386/pc_q35.c                         | 1 -
 hw/i386/pc_sysfw.c                       | 1 -
 hw/i386/vmmouse.c                        | 1 -
 hw/i386/vmport.c                         | 1 -
 hw/i386/xen/xen-hvm.c                    | 1 +
 hw/i386/xen/xen_platform.c               | 1 -
 hw/i386/xen/xen_pvdevice.c               | 1 -
 hw/ide/ahci-allwinner.c                  | 1 -
 hw/ide/ahci.c                            | 1 -
 hw/ide/cmd646.c                          | 1 -
 hw/ide/core.c                            | 1 -
 hw/ide/ich.c                             | 1 -
 hw/ide/ioport.c                          | 1 -
 hw/ide/isa.c                             | 1 -
 hw/ide/macio.c                           | 1 -
 hw/ide/microdrive.c                      | 1 -
 hw/ide/mmio.c                            | 1 -
 hw/ide/pci.c                             | 1 -
 hw/ide/piix.c                            | 1 -
 hw/ide/qdev.c                            | 1 -
 hw/ide/via.c                             | 1 -
 hw/input/hid.c                           | 1 -
 hw/input/lm832x.c                        | 1 -
 hw/input/milkymist-softusb.c             | 1 -
 hw/input/pckbd.c                         | 1 -
 hw/input/ps2.c                           | 1 -
 hw/input/stellaris_input.c               | 1 -
 hw/input/tsc2005.c                       | 1 -
 hw/intc/etraxfs_pic.c                    | 1 -
 hw/intc/exynos4210_combiner.c            | 1 +
 hw/intc/heathrow_pic.c                   | 1 -
 hw/intc/i8259.c                          | 1 -
 hw/intc/ioapic.c                         | 1 -
 hw/intc/lm32_pic.c                       | 1 -
 hw/intc/mips_gic.c                       | 1 -
 hw/intc/omap_intc.c                      | 1 -
 hw/intc/ompic.c                          | 1 -
 hw/intc/openpic.c                        | 1 -
 hw/intc/openpic_kvm.c                    | 1 -
 hw/intc/sh_intc.c                        | 1 -
 hw/intc/xics.c                           | 1 -
 hw/intc/xics_kvm.c                       | 1 -
 hw/intc/xics_spapr.c                     | 1 -
 hw/intc/xilinx_intc.c                    | 1 -
 hw/ipmi/ipmi.c                           | 1 -
 hw/ipmi/isa_ipmi_bt.c                    | 1 -
 hw/ipmi/isa_ipmi_kcs.c                   | 1 -
 hw/isa/apm.c                             | 1 -
 hw/isa/lpc_ich9.c                        | 1 -
 hw/isa/piix4.c                           | 1 -
 hw/isa/vt82c686.c                        | 1 -
 hw/lm32/lm32_boards.c                    | 1 -
 hw/lm32/milkymist.c                      | 1 -
 hw/m68k/an5206.c                         | 1 -
 hw/microblaze/boot.h                     | 1 -
 hw/microblaze/petalogix_ml605_mmu.c      | 1 -
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 1 -
 hw/mips/addr.c                           | 1 -
 hw/mips/boston.c                         | 1 -
 hw/mips/gt64xxx_pci.c                    | 1 -
 hw/mips/mips_fulong2e.c                  | 1 -
 hw/mips/mips_int.c                       | 1 -
 hw/mips/mips_jazz.c                      | 1 -
 hw/mips/mips_malta.c                     | 1 -
 hw/mips/mips_mipssim.c                   | 1 -
 hw/mips/mips_r4k.c                       | 1 -
 hw/misc/applesmc.c                       | 1 -
 hw/misc/arm_integrator_debug.c           | 1 -
 hw/misc/arm_sysctl.c                     | 1 -
 hw/misc/debugexit.c                      | 1 -
 hw/misc/edu.c                            | 1 +
 hw/misc/ivshmem.c                        | 1 -
 hw/misc/macio/cuda.c                     | 1 -
 hw/misc/macio/gpio.c                     | 1 -
 hw/misc/macio/mac_dbdma.c                | 1 -
 hw/misc/macio/macio.c                    | 1 -
 hw/misc/macio/pmu.c                      | 1 -
 hw/misc/milkymist-hpdmc.c                | 1 -
 hw/misc/milkymist-pfpu.c                 | 1 -
 hw/misc/mips_cmgcr.c                     | 1 -
 hw/misc/mos6522.c                        | 1 -
 hw/misc/mst_fpga.c                       | 1 -
 hw/misc/omap_gpmc.c                      | 1 -
 hw/misc/omap_l4.c                        | 1 -
 hw/misc/omap_sdrc.c                      | 1 -
 hw/misc/pc-testdev.c                     | 1 -
 hw/misc/pca9552.c                        | 1 -
 hw/misc/pci-testdev.c                    | 1 -
 hw/misc/puv3_pm.c                        | 1 -
 hw/misc/tmp105.c                         | 1 -
 hw/misc/tmp421.c                         | 1 -
 hw/misc/unimp.c                          | 1 -
 hw/misc/zynq-xadc.c                      | 1 -
 hw/misc/zynq_slcr.c                      | 1 -
 hw/moxie/moxiesim.c                      | 1 -
 hw/net/can/can_kvaser_pci.c              | 1 -
 hw/net/can/can_mioe3680_pci.c            | 1 -
 hw/net/can/can_pcm3680_pci.c             | 1 -
 hw/net/can/can_sja1000.c                 | 1 -
 hw/net/e1000.c                           | 1 -
 hw/net/e1000e.c                          | 1 +
 hw/net/e1000e_core.c                     | 1 +
 hw/net/e1000x_common.c                   | 1 -
 hw/net/eepro100.c                        | 1 -
 hw/net/lan9118.c                         | 1 +
 hw/net/milkymist-minimac2.c              | 1 -
 hw/net/mipsnet.c                         | 1 -
 hw/net/ne2000.h                          | 1 -
 hw/net/opencores_eth.c                   | 1 -
 hw/net/rocker/rocker.c                   | 1 -
 hw/net/rocker/rocker_desc.c              | 1 -
 hw/net/rtl8139.c                         | 1 -
 hw/net/spapr_llan.c                      | 1 -
 hw/net/sunhme.c                          | 1 -
 hw/net/xen_nic.c                         | 1 -
 hw/net/xilinx_axienet.c                  | 1 +
 hw/net/xilinx_ethlite.c                  | 1 -
 hw/nios2/10m50_devboard.c                | 1 -
 hw/nios2/boot.h                          | 1 -
 hw/nios2/generic_nommu.c                 | 1 -
 hw/nvram/chrp_nvram.c                    | 1 -
 hw/nvram/eeprom93xx.c                    | 1 -
 hw/nvram/eeprom_at24c.c                  | 1 -
 hw/nvram/fw_cfg.c                        | 1 -
 hw/nvram/mac_nvram.c                     | 1 -
 hw/openrisc/cputimer.c                   | 1 -
 hw/openrisc/openrisc_sim.c               | 1 -
 hw/openrisc/pic_cpu.c                    | 1 -
 hw/pci-host/bonito.c                     | 1 -
 hw/pci-host/gpex.c                       | 1 -
 hw/pci-host/piix.c                       | 1 -
 hw/pci-host/ppce500.c                    | 1 -
 hw/pci-host/prep.c                       | 1 -
 hw/pci-host/q35.c                        | 1 -
 hw/pci-host/uninorth.c                   | 1 -
 hw/pci/msix.c                            | 1 -
 hw/pci/pci.c                             | 1 -
 hw/pci/pcie_host.c                       | 1 -
 hw/pcmcia/pcmcia.c                       | 1 -
 hw/pcmcia/pxa2xx.c                       | 1 -
 hw/ppc/e500.c                            | 1 -
 hw/ppc/mac_newworld.c                    | 1 -
 hw/ppc/mac_oldworld.c                    | 1 -
 hw/ppc/mpc8544_guts.c                    | 1 -
 hw/ppc/pnv.c                             | 1 -
 hw/ppc/pnv_bmc.c                         | 1 -
 hw/ppc/pnv_occ.c                         | 1 -
 hw/ppc/pnv_psi.c                         | 1 -
 hw/ppc/pnv_xscom.c                       | 1 -
 hw/ppc/ppc.c                             | 1 -
 hw/ppc/ppc405_boards.c                   | 1 -
 hw/ppc/ppc405_uc.c                       | 1 -
 hw/ppc/ppc440_bamboo.c                   | 1 -
 hw/ppc/ppc440_pcix.c                     | 1 -
 hw/ppc/ppc440_uc.c                       | 1 -
 hw/ppc/ppc4xx_devs.c                     | 1 -
 hw/ppc/ppc4xx_pci.c                      | 1 -
 hw/ppc/ppc_booke.c                       | 1 -
 hw/ppc/prep.c                            | 1 -
 hw/ppc/sam460ex.c                        | 1 -
 hw/ppc/spapr.c                           | 1 -
 hw/ppc/spapr_iommu.c                     | 1 -
 hw/ppc/spapr_pci.c                       | 1 -
 hw/ppc/spapr_vio.c                       | 1 -
 hw/ppc/virtex_ml507.c                    | 1 -
 hw/rdma/vmw/pvrdma_cmd.c                 | 1 -
 hw/rdma/vmw/pvrdma_main.c                | 1 -
 hw/riscv/sifive_e.c                      | 1 -
 hw/riscv/sifive_prci.c                   | 1 +
 hw/riscv/sifive_test.c                   | 1 +
 hw/riscv/sifive_u.c                      | 1 -
 hw/riscv/sifive_uart.c                   | 1 +
 hw/riscv/spike.c                         | 1 -
 hw/riscv/virt.c                          | 1 -
 hw/s390x/virtio-ccw.c                    | 1 -
 hw/scsi/lsi53c895a.c                     | 1 -
 hw/scsi/megasas.c                        | 1 -
 hw/scsi/mptconfig.c                      | 1 -
 hw/scsi/mptendian.c                      | 1 -
 hw/scsi/mptsas.c                         | 1 -
 hw/scsi/scsi-bus.c                       | 1 -
 hw/scsi/spapr_vscsi.c                    | 1 -
 hw/sd/milkymist-memcard.c                | 1 -
 hw/sd/omap_mmc.c                         | 1 -
 hw/sd/pxa2xx_mmci.c                      | 1 -
 hw/sd/sd.c                               | 1 -
 hw/sd/sdhci-pci.c                        | 1 -
 hw/sd/sdhci.c                            | 1 -
 hw/sh4/r2d.c                             | 1 -
 hw/sh4/sh7750.c                          | 1 -
 hw/sh4/sh7750_regnames.c                 | 1 -
 hw/sh4/shix.c                            | 1 -
 hw/sparc/leon3.c                         | 1 -
 hw/sparc64/niagara.c                     | 1 -
 hw/sparc64/sun4u.c                       | 1 -
 hw/timer/a9gtimer.c                      | 1 +
 hw/timer/arm_mptimer.c                   | 1 +
 hw/timer/exynos4210_mct.c                | 1 +
 hw/timer/exynos4210_rtc.c                | 1 -
 hw/timer/hpet.c                          | 1 -
 hw/timer/i8254.c                         | 1 -
 hw/timer/i8254_common.c                  | 1 -
 hw/timer/lm32_timer.c                    | 1 -
 hw/timer/m48t59.c                        | 1 -
 hw/timer/mc146818rtc.c                   | 1 -
 hw/timer/milkymist-sysctl.c              | 1 -
 hw/timer/mips_gictimer.c                 | 1 -
 hw/timer/omap_gptimer.c                  | 1 -
 hw/timer/omap_synctimer.c                | 1 -
 hw/timer/pxa2xx_timer.c                  | 1 -
 hw/timer/sun4v-rtc.c                     | 1 -
 hw/timer/twl92230.c                      | 1 -
 hw/tpm/tpm_emulator.c                    | 1 -
 hw/tpm/tpm_passthrough.c                 | 1 -
 hw/tricore/tricore_testboard.c           | 1 -
 hw/usb/bus.c                             | 1 -
 hw/usb/dev-audio.c                       | 1 -
 hw/usb/dev-hid.c                         | 1 -
 hw/usb/dev-wacom.c                       | 1 -
 hw/usb/hcd-ehci.h                        | 1 -
 hw/usb/hcd-ohci-pci.c                    | 1 -
 hw/usb/hcd-ohci.c                        | 1 -
 hw/usb/hcd-uhci.c                        | 1 -
 hw/usb/hcd-xhci-nec.c                    | 1 -
 hw/usb/hcd-xhci.c                        | 1 -
 hw/usb/libhw.c                           | 1 -
 hw/usb/tusb6010.c                        | 1 +
 hw/vfio/pci-quirks.c                     | 1 +
 hw/vfio/pci.c                            | 1 +
 hw/virtio/vhost.c                        | 1 -
 hw/virtio/virtio-bus.c                   | 1 -
 hw/watchdog/wdt_i6300esb.c               | 1 -
 hw/watchdog/wdt_ib700.c                  | 1 -
 hw/xen/xen-bus-helper.c                  | 1 -
 hw/xen/xen-bus.c                         | 1 -
 hw/xen/xen-legacy-backend.c              | 1 -
 hw/xen/xen_pt_load_rom.c                 | 1 -
 hw/xenpv/xen_machine_pv.c                | 1 -
 hw/xtensa/mx_pic.c                       | 1 -
 hw/xtensa/pic_cpu.c                      | 1 -
 include/hw/audio/pcspk.h                 | 1 -
 include/hw/audio/wm8750.h                | 1 -
 include/hw/char/serial.h                 | 1 -
 include/hw/char/stm32f2xx_usart.h        | 1 -
 include/hw/dma/i8257.h                   | 1 -
 include/hw/hw.h                          | 1 -
 include/hw/i386/ich9.h                   | 1 -
 include/hw/i386/ioapic_internal.h        | 1 -
 include/hw/input/i8042.h                 | 1 -
 include/hw/isa/apm.h                     | 1 -
 include/hw/isa/i8259_internal.h          | 1 -
 include/hw/misc/stm32f2xx_syscfg.h       | 1 -
 include/hw/net/ne2000-isa.h              | 1 -
 include/hw/pci-host/designware.h         | 1 -
 include/hw/pci-host/gpex.h               | 1 -
 include/hw/pci-host/q35.h                | 1 -
 include/hw/pci-host/uninorth.h           | 1 -
 include/hw/pci-host/xilinx-pcie.h        | 1 -
 include/hw/pci/pcie.h                    | 1 -
 include/hw/pci/pcie_aer.h                | 1 -
 include/hw/qdev.h                        | 1 -
 include/hw/riscv/riscv_htif.h            | 1 -
 include/hw/ssi/stm32f2xx_spi.h           | 1 -
 include/hw/timer/aspeed_rtc.h            | 1 -
 include/hw/timer/i8254.h                 | 1 -
 include/hw/timer/i8254_internal.h        | 1 -
 include/hw/virtio/vhost.h                | 1 -
 include/hw/virtio/virtio.h               | 1 -
 include/hw/xen/xen_common.h              | 1 -
 include/sysemu/dma.h                     | 1 -
 include/sysemu/hax.h                     | 1 -
 include/sysemu/hvf.h                     | 1 -
 monitor/misc.c                           | 1 -
 target/alpha/machine.c                   | 1 -
 target/arm/machine.c                     | 1 -
 target/cris/machine.c                    | 1 -
 target/hppa/machine.c                    | 1 -
 target/i386/cpu.c                        | 1 -
 target/i386/machine.c                    | 1 -
 target/lm32/machine.c                    | 1 -
 target/mips/machine.c                    | 1 -
 target/moxie/machine.c                   | 1 -
 target/openrisc/machine.c                | 1 -
 target/ppc/kvm.c                         | 1 +
 target/ppc/machine.c                     | 1 -
 target/s390x/cpu.c                       | 1 -
 target/s390x/kvm.c                       | 1 -
 target/s390x/machine.c                   | 1 -
 target/s390x/mmu_helper.c                | 1 +
 target/sparc/machine.c                   | 1 -
 ui/spice-core.c                          | 1 -
 vl.c                                     | 1 -
 401 files changed, 27 insertions(+), 374 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f450f25295..d20da99c21 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -23,7 +23,6 @@
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/s390x/adapter.h"
diff --git a/audio/audio.c b/audio/audio.c
index cf65ae49f4..b9b2d07e54 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "audio.h"
 #include "migration/vmstate.h"
 #include "monitor/monitor.h"
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 0ead5ae43a..ec1c8fe936 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -18,7 +18,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "qemu/host-utils.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
diff --git a/audio/wavcapture.c b/audio/wavcapture.c
index 74320dfecc..493edc60e4 100644
--- a/audio/wavcapture.c
+++ b/audio/wavcapture.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/cpus.c b/cpus.c
index 4ebdacdd44..e70cc58e31 100644
--- a/cpus.c
+++ b/cpus.c
@@ -56,6 +56,7 @@
 #include "hw/nmi.h"
 #include "sysemu/replay.h"
 #include "hw/boards.h"
+#include "hw/hw.h"
=20
 #ifdef CONFIG_LINUX
=20
diff --git a/device-hotplug.c b/device-hotplug.c
index 6153259d71..f01d53774b 100644
--- a/device-hotplug.c
+++ b/device-hotplug.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/boards.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
diff --git a/exec.c b/exec.c
index 3e78de3b8f..78f849de99 100644
--- a/exec.c
+++ b/exec.c
@@ -42,7 +42,6 @@
 #if defined(CONFIG_USER_ONLY)
 #include "qemu.h"
 #else /* !CONFIG_USER_ONLY */
-#include "hw/hw.h"
 #include "exec/memory.h"
 #include "exec/ioport.h"
 #include "sysemu/dma.h"
diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 25ab04d95a..c50b1961d3 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -10,7 +10,6 @@
=20
 #include "qemu/osdep.h"
=20
-#include "hw/hw.h"
 #include "hw/9pfs/9p.h"
 #include "hw/xen/xen-legacy-backend.h"
 #include "hw/9pfs/xen-9pfs.h"
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 39e9fb1a6c..f36d60f619 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -21,7 +21,6 @@
=20
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/acpi/acpi.h"
 #include "hw/nvram/fw_cfg.h"
diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
index 5243918125..a83567e6aa 100644
--- a/hw/acpi/cpu_hotplug.c
+++ b/hw/acpi/cpu_hotplug.c
@@ -10,7 +10,6 @@
  * See the COPYING file in the top-level directory.
  */
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/acpi/cpu_hotplug.h"
 #include "qapi/error.h"
 #include "qom/cpu.h"
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 88eb7dbab1..39649cbe6a 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -25,7 +25,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "hw/i386/pc.h"
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 912ff6dd5c..ac49a5a77b 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -27,7 +27,6 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/pcihp.h"
=20
-#include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 1896dbbfb9..ec47a9143b 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -20,7 +20,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/irq.h"
 #include "hw/isa/apm.h"
diff --git a/hw/adc/stm32f2xx_adc.c b/hw/adc/stm32f2xx_adc.c
index 9684653e5e..4f9d485ecf 100644
--- a/hw/adc/stm32f2xx_adc.c
+++ b/hw/adc/stm32f2xx_adc.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "hw/hw.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/adc/stm32f2xx_adc.h"
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 9dfb835013..546b89bbcc 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -9,7 +9,6 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "elf.h"
 #include "hw/loader.h"
 #include "hw/boards.h"
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 6797eb0abe..5d7f8f3342 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -11,7 +11,6 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "sysemu/sysemu.h"
 #include "alpha_sys.h"
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index d082daf6f2..8563672942 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -12,7 +12,6 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include <libfdt.h>
-#include "hw/hw.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/linux-boot-if.h"
 #include "sysemu/kvm.h"
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 3db3c56004..219643c633 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -10,7 +10,6 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/boards.h"
 #include "strongarm.h"
diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
index 343cbfd7da..f26a0e8010 100644
--- a/hw/arm/gumstix.c
+++ b/hw/arm/gumstix.c
@@ -36,7 +36,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "hw/hw.h"
 #include "hw/arm/pxa.h"
 #include "net/net.h"
 #include "hw/block/flash.h"
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index f8fbe402db..ecccb4125a 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -21,6 +21,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
 #include "hw/char/pl011.h"
+#include "hw/hw.h"
 #include "hw/irq.h"
=20
 #define TYPE_INTEGRATOR_CM "integrator_core"
diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
index cd1f904c6c..1bad1aea76 100644
--- a/hw/arm/mainstone.c
+++ b/hw/arm/mainstone.c
@@ -14,7 +14,6 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "hw/arm/pxa.h"
 #include "hw/arm/boot.h"
 #include "net/net.h"
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 72e522a629..a3cfdc3077 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -19,6 +19,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
 #include "hw/char/serial.h"
+#include "hw/hw.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
 #include "hw/block/flash.h"
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index 397630e2f2..af5e3d0ba7 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -25,7 +25,6 @@
 #include "sysemu/qtest.h"
 #include "sysemu/reset.h"
 #include "hw/boards.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/omap.h"
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index cae78d0a36..75a05c36b0 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -27,7 +27,6 @@
  */
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "ui/console.h"
 #include "hw/arm/omap.h"
 #include "hw/boards.h"
diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index a5eccb7290..bea47b917d 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -19,7 +19,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "audio/audio.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
diff --git a/hw/arm/pxa2xx_pic.c b/hw/arm/pxa2xx_pic.c
index c8bd497e99..203d4d28af 100644
--- a/hw/arm/pxa2xx_pic.c
+++ b/hw/arm/pxa2xx_pic.c
@@ -11,7 +11,6 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/arm/pxa.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index 003929b3e0..2eabb9c814 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -12,7 +12,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "hw/arm/pxa.h"
 #include "hw/arm/boot.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index 80c61aef16..7f136bf187 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -13,7 +13,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "hw/arm/pxa.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/sharpsl.h"
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 4f85eb575c..fa9afd2b7e 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -36,7 +36,6 @@
 #include "hw/acpi/acpi.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/acpi/bios-linker-loader.h"
-#include "hw/hw.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/utils.h"
 #include "hw/acpi/pci.h"
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index 810922d74e..1e3db425ef 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -12,7 +12,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/arm/pxa.h"
 #include "hw/arm/boot.h"
 #include "hw/i2c/i2c.h"
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 26ac84b388..9af584fb12 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -18,7 +18,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/audio/soundhw.h"
 #include "audio/audio.h"
 #include "hw/pci/pci.h"
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index 7dd9a89b89..62e59ccee6 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "hw/hw.h"
 #include "hw/audio/soundhw.h"
 #include "audio/audio.h"
 #include "hw/isa/isa.h"
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index f7a39c0af4..383200e1e2 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/audio/soundhw.h"
 #include "audio/audio.h"
 #include "hw/irq.h"
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 0289f771c1..39deecbbc6 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -27,7 +27,6 @@
 #define SILENT_ES1370
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/audio/soundhw.h"
 #include "audio/audio.h"
 #include "hw/pci/pci.h"
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index 1a78cc47cd..787e04774a 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "hw/hw.h"
 #include "hw/audio/soundhw.h"
 #include "audio/audio.h"
 #include "hw/irq.h"
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 4f6fbb8b13..4c33c477e1 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -18,7 +18,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "intel-hda.h"
 #include "migration/vmstate.h"
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index e6f150bb0d..5a1fcded55 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -18,7 +18,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
 #include "qemu/timer.h"
diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
index 6345bc1d5c..158a456a41 100644
--- a/hw/audio/marvell_88w8618.c
+++ b/hw/audio/marvell_88w8618.c
@@ -13,7 +13,6 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/audio/wm8750.h"
 #include "audio/audio.h"
diff --git a/hw/audio/milkymist-ac97.c b/hw/audio/milkymist-ac97.c
index 890a5fe89e..481dde10a1 100644
--- a/hw/audio/milkymist-ac97.c
+++ b/hw/audio/milkymist-ac97.c
@@ -22,7 +22,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 9039c9786d..016946d4b2 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/isa/isa.h"
 #include "hw/audio/soundhw.h"
 #include "audio/audio.h"
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 599194779d..818659546f 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/audio/soundhw.h"
 #include "audio/audio.h"
 #include "hw/irq.h"
diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-bloc=
k.c
index 0f200c5fb0..71c63330ac 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "hw/xen/xen_common.h"
 #include "hw/block/xen_blkif.h"
 #include "sysemu/block-backend.h"
diff --git a/hw/block/ecc.c b/hw/block/ecc.c
index f846ab3e01..1a182367ee 100644
--- a/hw/block/ecc.c
+++ b/hw/block/ecc.c
@@ -12,7 +12,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "migration/vmstate.h"
 #include "hw/block/flash.h"
=20
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 88feb0f451..7542c8f273 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -28,7 +28,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/block/fdc.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 9d395169b2..c213e2ed7b 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -23,7 +23,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/hw.h"
 #include "sysemu/block-backend.h"
 #include "hw/ssi/ssi.h"
 #include "migration/vmstate.h"
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 079a8ffe80..e08853fe5e 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -28,7 +28,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "hw/block/block.h"
-#include "hw/hw.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 2d6f260491..7bfe9de2a3 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -37,7 +37,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/block/block.h"
 #include "hw/block/flash.h"
 #include "sysemu/block-backend.h"
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index b7070cd8ec..18ea50f4ba 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -33,7 +33,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/block/block.h"
 #include "hw/block/flash.h"
 #include "qapi/error.h"
diff --git a/hw/block/tc58128.c b/hw/block/tc58128.c
index d0fae248dc..9888f01ac6 100644
--- a/hw/block/tc58128.c
+++ b/hw/block/tc58128.c
@@ -1,6 +1,5 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/hw.h"
 #include "hw/sh4/sh.h"
 #include "hw/loader.h"
 #include "sysemu/qtest.h"
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 69d73196e2..848a0ad0ea 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -17,7 +17,6 @@
 #include "qapi/visitor.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
-#include "hw/hw.h"
 #include "hw/xen/xen_common.h"
 #include "hw/block/xen_blkif.h"
 #include "hw/xen/xen-block.h"
diff --git a/hw/char/debugcon.c b/hw/char/debugcon.c
index e1b6d1190f..b38d82891f 100644
--- a/hw/char/debugcon.c
+++ b/hw/char/debugcon.c
@@ -27,7 +27,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "hw/hw.h"
 #include "chardev/char-fe.h"
 #include "hw/isa/isa.h"
=20
diff --git a/hw/char/digic-uart.c b/hw/char/digic-uart.c
index 79ea92249c..cc501678ce 100644
--- a/hw/char/digic-uart.c
+++ b/hw/char/digic-uart.c
@@ -27,7 +27,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "chardev/char-fe.h"
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 404002b899..35c6952bbd 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/char/lm32_juart.c b/hw/char/lm32_juart.c
index f4488fa736..69dd7ac72b 100644
--- a/hw/char/lm32_juart.c
+++ b/hw/char/lm32_juart.c
@@ -18,7 +18,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/char/lm32_uart.c b/hw/char/lm32_uart.c
index 4b3215fe96..00832fba86 100644
--- a/hw/char/lm32_uart.c
+++ b/hw/char/lm32_uart.c
@@ -23,7 +23,6 @@
=20
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index c403a1fdc6..1712b2296e 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -7,7 +7,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
diff --git a/hw/char/milkymist-uart.c b/hw/char/milkymist-uart.c
index 53c1ca789d..e90f84d53e 100644
--- a/hw/char/milkymist-uart.c
+++ b/hw/char/milkymist-uart.c
@@ -22,7 +22,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/char/omap_uart.c b/hw/char/omap_uart.c
index b3bb1cfcec..13e4f43c4c 100644
--- a/hw/char/omap_uart.c
+++ b/hw/char/omap_uart.c
@@ -19,7 +19,6 @@
  */
 #include "qemu/osdep.h"
 #include "chardev/char.h"
-#include "hw/hw.h"
 #include "hw/arm/omap.h"
 #include "hw/char/serial.h"
 #include "exec/address-spaces.h"
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 1798fd0c44..3980eb5909 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -26,7 +26,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "hw/hw.h"
 #include "chardev/char-parallel.h"
 #include "chardev/char-fe.h"
 #include "hw/irq.h"
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 7a40aa90af..07dc16be13 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -26,7 +26,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sh4/sh.h"
 #include "chardev/char-fe.h"
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index 47e1092263..8cc9328b3f 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -24,7 +24,6 @@
 #include <termios.h>
=20
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "chardev/char-fe.h"
 #include "hw/xen/xen-legacy-backend.h"
=20
diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index 250eed945c..fa7451fd67 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
diff --git a/hw/core/empty_slot.c b/hw/core/empty_slot.c
index c694532046..3ba450e1ca 100644
--- a/hw/core/empty_slot.c
+++ b/hw/core/empty_slot.c
@@ -10,7 +10,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "hw/empty_slot.h"
diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index 04a1e2b02a..30b1991b52 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -13,7 +13,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "hw/hw.h"
 #include "hw/boards.h"
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
index 49b60282cf..d58e2dfdb0 100644
--- a/hw/core/ptimer.c
+++ b/hw/core/ptimer.c
@@ -7,7 +7,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
 #include "migration/vmstate.h"
diff --git a/hw/cris/boot.c b/hw/cris/boot.c
index d44fdec43f..2d2cc0c7a5 100644
--- a/hw/cris/boot.c
+++ b/hw/cris/boot.c
@@ -24,7 +24,6 @@
=20
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/loader.h"
 #include "elf.h"
 #include "boot.h"
diff --git a/hw/display/ati.c b/hw/display/ati.c
index a747c4cc98..df978a420d 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -24,7 +24,6 @@
 #include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "ui/console.h"
 #include "hw/display/i2c-ddc.h"
 #include "trace.h"
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index 3d99d99e2b..e606893f28 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/display/bcm2835_fb.h"
+#include "hw/hw.h"
 #include "hw/irq.h"
 #include "framebuffer.h"
 #include "ui/pixel_ops.h"
diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index ce40aea354..0a535de40c 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -8,7 +8,6 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
 #include "hw/display/bochs-vbe.h"
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 3120b3cfaf..0f5465bc14 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -38,7 +38,6 @@
 #include "sysemu/reset.h"
 #include "qapi/error.h"
 #include "trace.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
 #include "ui/pixel_ops.h"
diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
index 69cdb9e066..49f409b638 100644
--- a/hw/display/cirrus_vga_isa.c
+++ b/hw/display/cirrus_vga_isa.c
@@ -26,7 +26,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "hw/hw.h"
 #include "hw/loader.h"
 #include "hw/isa/isa.h"
 #include "cirrus_vga_internal.h"
diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 8e1508a3e6..c1071ecd46 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/display/framebuffer.c b/hw/display/framebuffer.c
index 36e3db189a..4485aa335b 100644
--- a/hw/display/framebuffer.c
+++ b/hw/display/framebuffer.c
@@ -18,7 +18,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "ui/console.h"
 #include "framebuffer.h"
=20
diff --git a/hw/display/milkymist-tmu2.c b/hw/display/milkymist-tmu2.c
index 7bfffa52da..199f1227e7 100644
--- a/hw/display/milkymist-tmu2.c
+++ b/hw/display/milkymist-tmu2.c
@@ -25,7 +25,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/display/omap_lcdc.c b/hw/display/omap_lcdc.c
index b00ce04b3b..6ad13f2e9e 100644
--- a/hw/display/omap_lcdc.c
+++ b/hw/display/omap_lcdc.c
@@ -18,7 +18,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "ui/console.h"
 #include "hw/arm/omap.h"
diff --git a/hw/display/qxl.h b/hw/display/qxl.h
index 4adfdb1e5d..80eb0d2672 100644
--- a/hw/display/qxl.h
+++ b/hw/display/qxl.h
@@ -2,7 +2,6 @@
 #define HW_QXL_H
=20
=20
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "vga_int.h"
 #include "qemu/thread.h"
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 6f88aaaa08..603396358d 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -29,7 +29,6 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/char/serial.h"
 #include "ui/console.h"
 #include "hw/sysbus.h"
diff --git a/hw/display/tc6393xb.c b/hw/display/tc6393xb.c
index 74a77eb43b..49a676d1b0 100644
--- a/hw/display/tc6393xb.c
+++ b/hw/display/tc6393xb.c
@@ -14,7 +14,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/host-utils.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/display/tc6393xb.h"
 #include "exec/memory.h"
diff --git a/hw/display/vga-isa-mm.c b/hw/display/vga-isa-mm.c
index 1c4f43b52b..e9c43e5530 100644
--- a/hw/display/vga-isa-mm.c
+++ b/hw/display/vga-isa-mm.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
 #include "qemu/units.h"
-#include "hw/hw.h"
 #include "migration/vmstate.h"
 #include "hw/display/vga.h"
 #include "vga_int.h"
diff --git a/hw/display/vga-isa.c b/hw/display/vga-isa.c
index 945952a9b0..189a4afc15 100644
--- a/hw/display/vga-isa.c
+++ b/hw/display/vga-isa.c
@@ -25,7 +25,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/isa/isa.h"
 #include "vga_int.h"
 #include "ui/pixel_ops.h"
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index cb956b4545..86299f5e97 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -25,7 +25,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
 #include "vga_int.h"
diff --git a/hw/display/vga.c b/hw/display/vga.c
index f8098f63e9..573d223d46 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -26,7 +26,6 @@
 #include "qemu/units.h"
 #include "sysemu/reset.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "hw/display/vga.h"
 #include "hw/pci/pci.h"
 #include "vga_int.h"
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 79a145e284..e5227fac28 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "qapi/error.h"
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index ebfcc46a2d..f0b136eb16 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -26,7 +26,6 @@
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "hw/loader.h"
 #include "trace.h"
 #include "ui/vnc.h"
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index 3c79913b31..838260b6ad 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -27,7 +27,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
=20
-#include "hw/hw.h"
 #include "ui/input.h"
 #include "ui/console.h"
 #include "hw/xen/xen-legacy-backend.h"
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index b7404cff60..c626bd958a 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/isa/isa.h"
 #include "migration/vmstate.h"
 #include "hw/dma/i8257.h"
diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 59bc929363..3713d5dadd 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -14,6 +14,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/dma/pl080.h"
+#include "hw/hw.h"
 #include "hw/irq.h"
 #include "qapi/error.h"
=20
diff --git a/hw/dma/puv3_dma.c b/hw/dma/puv3_dma.c
index 122f87aff1..5488d388a9 100644
--- a/hw/dma/puv3_dma.c
+++ b/hw/dma/puv3_dma.c
@@ -10,7 +10,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/sysbus.h"
=20
 #undef DEBUG_PUV3
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index d35fb59eee..d54e296d3a 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -24,7 +24,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/mips/mips.h"
 #include "hw/sysbus.h"
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 8955fe262e..16d53b92dd 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -26,7 +26,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sparc/sparc32_dma.h"
 #include "hw/sparc/sun4m_iommu.h"
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 83b52e4ac7..2c2d567a95 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -26,6 +26,7 @@
 #include "hw/sysbus.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
+#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/ptimer.h"
 #include "qemu/log.h"
diff --git a/hw/gpio/max7310.c b/hw/gpio/max7310.c
index 432f0b00fe..87b0f24747 100644
--- a/hw/gpio/max7310.c
+++ b/hw/gpio/max7310.c
@@ -8,6 +8,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/hw.h"
 #include "hw/i2c/i2c.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index 6ab51a9428..46a721779c 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -19,7 +19,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/arm/omap.h"
 #include "hw/sysbus.h"
diff --git a/hw/gpio/puv3_gpio.c b/hw/gpio/puv3_gpio.c
index 54d30cada2..d19e342514 100644
--- a/hw/gpio/puv3_gpio.c
+++ b/hw/gpio/puv3_gpio.c
@@ -10,7 +10,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/sysbus.h"
=20
 #undef DEBUG_PUV3
diff --git a/hw/gpio/zaurus.c b/hw/gpio/zaurus.c
index a1ba09c6f2..9a12c68342 100644
--- a/hw/gpio/zaurus.c
+++ b/hw/gpio/zaurus.c
@@ -17,7 +17,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/arm/sharpsl.h"
 #include "hw/sysbus.h"
diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index dfb9d7a742..bb9d0e033c 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -15,7 +15,6 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "sysemu/sysemu.h"
 #include "hw/pci/pci.h"
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index bc74438496..2736ce835e 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -6,7 +6,6 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "elf.h"
 #include "hw/loader.h"
 #include "hw/boards.h"
diff --git a/hw/i2c/bitbang_i2c.c b/hw/i2c/bitbang_i2c.c
index 2289128aaf..b000952b98 100644
--- a/hw/i2c/bitbang_i2c.c
+++ b/hw/i2c/bitbang_i2c.c
@@ -11,7 +11,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/i2c/bitbang_i2c.h"
 #include "hw/sysbus.h"
diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
index 309a37b1fa..34f34e3b05 100644
--- a/hw/i2c/omap_i2c.c
+++ b/hw/i2c/omap_i2c.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "hw/hw.h"
 #include "hw/i2c/i2c.h"
 #include "hw/irq.h"
 #include "hw/arm/omap.h"
diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index d9e3bad90d..36994ff585 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -19,7 +19,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/boards.h"
 #include "hw/i2c/pm_smbus.h"
 #include "hw/i2c/smbus_master.h"
diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
index d110b417c6..3f015a1581 100644
--- a/hw/i2c/ppc4xx_i2c.c
+++ b/hw/i2c/ppc4xx_i2c.c
@@ -28,7 +28,6 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/i2c/ppc4xx_i2c.h"
 #include "hw/irq.h"
=20
diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index e05bc8c39c..8642f0036d 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "hw/boards.h"
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/smbus_slave.h"
diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
index f7e626e95a..564198dae9 100644
--- a/hw/i2c/smbus_ich9.c
+++ b/hw/i2c/smbus_ich9.c
@@ -21,7 +21,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/i2c/pm_smbus.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
diff --git a/hw/i2c/smbus_master.c b/hw/i2c/smbus_master.c
index 0a6223744c..dc43b8637d 100644
--- a/hw/i2c/smbus_master.c
+++ b/hw/i2c/smbus_master.c
@@ -12,7 +12,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/smbus_master.h"
=20
diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index 7b145a384d..5d10e27664 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -14,7 +14,6 @@
 /* TODO: Implement PEC.  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/smbus_slave.h"
 #include "migration/vmstate.h"
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 3a694b186b..e05a4eff5d 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -21,7 +21,6 @@
 #ifndef AMD_IOMMU_H
 #define AMD_IOMMU_H
=20
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "hw/i386/x86-iommu.h"
=20
diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index a3e33fbe5e..9a59f95497 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "qemu/option.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/nvram/fw_cfg.h"
 #include "multiboot.h"
 #include "hw/loader.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 1e8251d327..14fe8233ae 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -24,7 +24,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/char/serial.h"
 #include "hw/char/parallel.h"
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 129f47493b..2fbb581c46 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -26,7 +26,6 @@
 #include "config-devices.h"
=20
 #include "qemu/units.h"
-#include "hw/hw.h"
 #include "hw/loader.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/apic.h"
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 397e1fdd2f..060b47f845 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -30,7 +30,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/hw.h"
 #include "hw/loader.h"
 #include "sysemu/arch_init.h"
 #include "hw/i2c/smbus_eeprom.h"
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index de43943af8..defea37fe4 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -31,7 +31,6 @@
 #include "qemu/option.h"
 #include "qemu/units.h"
 #include "hw/sysbus.h"
-#include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index a50f5d5dd4..4f81504577 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "ui/console.h"
 #include "hw/i386/pc.h"
 #include "hw/input/i8042.h"
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 3bf8cfe041..26fcbe3827 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -22,7 +22,6 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/isa/isa.h"
 #include "hw/i386/pc.h"
 #include "hw/input/i8042.h"
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index f769cd91f2..63abace70a 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -15,6 +15,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/i386/pc.h"
 #include "hw/irq.h"
+#include "hw/hw.h"
 #include "hw/i386/apic-msidef.h"
 #include "hw/xen/xen_common.h"
 #include "hw/xen/xen-legacy-backend.h"
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index 800687a188..0f7b05e5e1 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -25,7 +25,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "hw/ide.h"
 #include "hw/pci/pci.h"
 #include "hw/irq.h"
diff --git a/hw/i386/xen/xen_pvdevice.c b/hw/i386/xen/xen_pvdevice.c
index 700db81cbc..10c89cda41 100644
--- a/hw/i386/xen/xen_pvdevice.c
+++ b/hw/i386/xen/xen_pvdevice.c
@@ -32,7 +32,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/hw/ide/ahci-allwinner.c b/hw/ide/ahci-allwinner.c
index 8777122c9c..bb8393d2b6 100644
--- a/hw/ide/ahci-allwinner.c
+++ b/hw/ide/ahci-allwinner.c
@@ -16,7 +16,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "sysemu/dma.h"
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index e0b1a91fd9..1d5a54b29e 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -22,7 +22,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index a3763a1d3a..c2ee427f56 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -24,7 +24,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 0453a925f9..005b4d5ef4 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -24,7 +24,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/isa/isa.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index 00fb43a127..eff3188fff 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -61,7 +61,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
diff --git a/hw/ide/ioport.c b/hw/ide/ioport.c
index a0b3c1f6a1..e6085612d4 100644
--- a/hw/ide/ioport.c
+++ b/hw/ide/ioport.c
@@ -24,7 +24,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/isa/isa.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
diff --git a/hw/ide/isa.c b/hw/ide/isa.c
index fda912f3ed..939b473dad 100644
--- a/hw/ide/isa.c
+++ b/hw/ide/isa.c
@@ -24,7 +24,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/isa/isa.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index aa447cd2b5..44f2ff92bb 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -24,7 +24,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/ppc/mac.h"
 #include "hw/ppc/mac_dbdma.h"
 #include "migration/vmstate.h"
diff --git a/hw/ide/microdrive.c b/hw/ide/microdrive.c
index be3cf8779a..b0272ea14b 100644
--- a/hw/ide/microdrive.c
+++ b/hw/ide/microdrive.c
@@ -24,7 +24,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/pcmcia.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/ide/mmio.c b/hw/ide/mmio.c
index f3de6db33e..d2a377f326 100644
--- a/hw/ide/mmio.c
+++ b/hw/ide/mmio.c
@@ -24,7 +24,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index c5b081a028..cce1da804d 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -24,7 +24,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
 #include "sysemu/dma.h"
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index 407d3e3ce8..bcfd119a8e 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -24,7 +24,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index eea22c09f4..d85c31a0ee 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -18,7 +18,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "sysemu/dma.h"
 #include "qapi/error.h"
 #include "qapi/qapi-types-block.h"
diff --git a/hw/ide/via.c b/hw/ide/via.c
index 8fa1972d92..45f929395f 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -25,7 +25,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/input/hid.c b/hw/input/hid.c
index c570ca25b1..89239b5634 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -24,7 +24,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "ui/console.h"
 #include "qemu/timer.h"
 #include "hw/input/hid.h"
diff --git a/hw/input/lm832x.c b/hw/input/lm832x.c
index de03913d7c..a37eb854b9 100644
--- a/hw/input/lm832x.c
+++ b/hw/input/lm832x.c
@@ -19,7 +19,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/i2c/i2c.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
diff --git a/hw/input/milkymist-softusb.c b/hw/input/milkymist-softusb.c
index e17666d56b..8f6fdf2d97 100644
--- a/hw/input/milkymist-softusb.c
+++ b/hw/input/milkymist-softusb.c
@@ -23,7 +23,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index cf1690332d..f2e32a1ed5 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -24,7 +24,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/hw.h"
 #include "hw/isa/isa.h"
 #include "migration/vmstate.h"
 #include "hw/i386/pc.h"
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 07d07ee6bd..68b30229f4 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -24,7 +24,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/hw.h"
 #include "hw/input/ps2.h"
 #include "migration/vmstate.h"
 #include "ui/console.h"
diff --git a/hw/input/stellaris_input.c b/hw/input/stellaris_input.c
index 7582117f0b..59892b07fc 100644
--- a/hw/input/stellaris_input.c
+++ b/hw/input/stellaris_input.c
@@ -8,7 +8,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/input/gamepad.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index b92a034496..55d61cc843 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -20,7 +20,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/hw.h"
 #include "qemu/timer.h"
 #include "sysemu/reset.h"
 #include "ui/console.h"
diff --git a/hw/intc/etraxfs_pic.c b/hw/intc/etraxfs_pic.c
index dc72dd5412..88d3b0c36f 100644
--- a/hw/intc/etraxfs_pic.c
+++ b/hw/intc/etraxfs_pic.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 //#include "pc.h"
 //#include "etraxfs.h"
diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.=
c
index 3b49ce4d27..833e164350 100644
--- a/hw/intc/exynos4210_combiner.c
+++ b/hw/intc/exynos4210_combiner.c
@@ -33,6 +33,7 @@
 #include "qemu/module.h"
=20
 #include "hw/arm/exynos4210.h"
+#include "hw/hw.h"
 #include "hw/irq.h"
=20
 //#define DEBUG_COMBINER
diff --git a/hw/intc/heathrow_pic.c b/hw/intc/heathrow_pic.c
index 572e9115aa..cb97c315da 100644
--- a/hw/intc/heathrow_pic.c
+++ b/hw/intc/heathrow_pic.c
@@ -24,7 +24,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/ppc/mac.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index e581e6b0ab..211a98962e 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index e99c37cceb..c346f50df9 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -23,7 +23,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "monitor/monitor.h"
-#include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/apic.h"
 #include "hw/i386/ioapic.h"
diff --git a/hw/intc/lm32_pic.c b/hw/intc/lm32_pic.c
index 4df4eef7df..36de670c9e 100644
--- a/hw/intc/lm32_pic.c
+++ b/hw/intc/lm32_pic.c
@@ -19,7 +19,6 @@
=20
 #include "qemu/osdep.h"
=20
-#include "hw/hw.h"
 #include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "qemu/module.h"
diff --git a/hw/intc/mips_gic.c b/hw/intc/mips_gic.c
index 166eb6ecce..6b4322bc5c 100644
--- a/hw/intc/mips_gic.c
+++ b/hw/intc/mips_gic.c
@@ -13,7 +13,6 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "exec/memory.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
index 4b3ddc0a67..f740578e7e 100644
--- a/hw/intc/omap_intc.c
+++ b/hw/intc/omap_intc.c
@@ -19,7 +19,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/arm/omap.h"
 #include "hw/sysbus.h"
diff --git a/hw/intc/ompic.c b/hw/intc/ompic.c
index 77591f827d..8a4a422142 100644
--- a/hw/intc/ompic.c
+++ b/hw/intc/ompic.c
@@ -10,7 +10,6 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index bb869ca221..312ac54c7c 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -35,7 +35,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/ppc/mac.h"
 #include "hw/pci/pci.h"
diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
index 49fc6fa0cf..e91910b331 100644
--- a/hw/intc/openpic_kvm.c
+++ b/hw/intc/openpic_kvm.c
@@ -27,7 +27,6 @@
 #include "cpu.h"
 #include <sys/ioctl.h>
 #include "exec/address-spaces.h"
-#include "hw/hw.h"
 #include "hw/ppc/openpic.h"
 #include "hw/ppc/openpic_kvm.h"
 #include "hw/pci/msi.h"
diff --git a/hw/intc/sh_intc.c b/hw/intc/sh_intc.c
index 62521500f9..72a55e32dd 100644
--- a/hw/intc/sh_intc.c
+++ b/hw/intc/sh_intc.c
@@ -11,7 +11,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "hw/sh4/sh_intc.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sh4/sh.h"
=20
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 41da9b3091..88709d4b90 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -28,7 +28,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "trace.h"
 #include "qemu/timer.h"
 #include "hw/ppc/xics.h"
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 65c35f90f9..a4d2e876cc 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -29,7 +29,6 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "trace.h"
 #include "sysemu/kvm.h"
 #include "hw/ppc/spapr.h"
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 7cd3c93d71..6577be0d92 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -27,7 +27,6 @@
=20
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "trace.h"
 #include "qemu/timer.h"
 #include "hw/ppc/spapr.h"
diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
index baf5353cd1..3a5c7f82f4 100644
--- a/hw/intc/xilinx_intc.c
+++ b/hw/intc/xilinx_intc.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
=20
 #define D(x)
diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index a837f91782..2090c6f73a 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/ipmi/ipmi.h"
 #include "sysemu/sysemu.h"
 #include "qom/object_interfaces.h"
diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index 588dfbac34..33c800acb5 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -26,7 +26,6 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "hw/ipmi/ipmi.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index e63753f03e..9a1de662ba 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -26,7 +26,6 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "hw/ipmi/ipmi.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
diff --git a/hw/isa/apm.c b/hw/isa/apm.c
index f22b2d78a4..6300b1ba7a 100644
--- a/hw/isa/apm.c
+++ b/hw/isa/apm.c
@@ -22,7 +22,6 @@
=20
 #include "qemu/osdep.h"
 #include "hw/isa/apm.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
=20
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 79d44c1b41..a037c21104 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -30,7 +30,6 @@
=20
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "qapi/visitor.h"
 #include "qemu/range.h"
 #include "hw/isa/isa.h"
diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 8abd5daaae..3294056cd5 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/pci/pci.h"
 #include "hw/isa/isa.h"
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index d98b94ab05..7379d90cf4 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -11,7 +11,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/isa/vt82c686.h"
 #include "hw/i2c/i2c.h"
 #include "hw/pci/pci.h"
diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
index d710980045..5ae308bfcf 100644
--- a/hw/lm32/lm32_boards.c
+++ b/hw/lm32/lm32_boards.c
@@ -22,7 +22,6 @@
 #include "qemu/error-report.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/block/flash.h"
 #include "hw/boards.h"
diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 864712d977..5ec3ae0300 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -23,7 +23,6 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/block/flash.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index 68d15a6ebe..54ccbe1a82 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -9,7 +9,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/m68k/mcf.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
diff --git a/hw/microblaze/boot.h b/hw/microblaze/boot.h
index dd1090d8b5..5a8c2f7975 100644
--- a/hw/microblaze/boot.h
+++ b/hw/microblaze/boot.h
@@ -1,7 +1,6 @@
 #ifndef MICROBLAZE_BOOT_H
 #define MICROBLAZE_BOOT_H
=20
-#include "hw/hw.h"
=20
 void microblaze_load_kernel(MicroBlazeCPU *cpu, hwaddr ddr_base,
                             uint32_t ramsize,
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogi=
x_ml605_mmu.c
index a88bf16cc8..03f6c1cc7c 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -30,7 +30,6 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
-#include "hw/hw.h"
 #include "net/net.h"
 #include "hw/block/flash.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/pet=
alogix_s3adsp1800_mmu.c
index 8d83474262..849bafc186 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -28,7 +28,6 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
-#include "hw/hw.h"
 #include "net/net.h"
 #include "hw/block/flash.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/mips/addr.c b/hw/mips/addr.c
index 4da46e1731..2f138fe1ea 100644
--- a/hw/mips/addr.c
+++ b/hw/mips/addr.c
@@ -21,7 +21,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/mips/cpudevs.h"
=20
 static int mips_um_ksegs;
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 9eeccbea9a..ce86b75664 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -23,7 +23,6 @@
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
 #include "hw/char/serial.h"
-#include "hw/hw.h"
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci.h"
 #include "hw/loader.h"
diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index b4412c6c24..f325bd6c1c 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/log.h"
-#include "hw/hw.h"
 #include "hw/mips/mips.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 0a1bf5ef5c..6e4fba285b 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -23,7 +23,6 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/dma/i8257.h"
 #include "hw/isa/superio.h"
diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
index ae4244c32e..74cf587d5b 100644
--- a/hw/mips/mips_int.c
+++ b/hw/mips/mips_int.c
@@ -22,7 +22,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/mips/cpudevs.h"
 #include "cpu.h"
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 6ea25cd5f4..388c15c376 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -24,7 +24,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "hw/hw.h"
 #include "hw/mips/mips.h"
 #include "hw/mips/cpudevs.h"
 #include "hw/i386/pc.h"
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 02200ab7d4..bdba712329 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -26,7 +26,6 @@
 #include "qemu/units.h"
 #include "qemu-common.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/isa/superio.h"
 #include "hw/dma/i8257.h"
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index 280e76a482..1ca7e909d1 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -29,7 +29,6 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/mips/mips.h"
 #include "hw/mips/cpudevs.h"
 #include "hw/char/serial.h"
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 191047826d..a41b0b0524 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -13,7 +13,6 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/mips/mips.h"
 #include "hw/mips/cpudevs.h"
 #include "hw/i386/pc.h"
diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 2d7eb3c7e2..d9d369777c 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -31,7 +31,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/isa/isa.h"
 #include "ui/console.h"
 #include "qemu/module.h"
diff --git a/hw/misc/arm_integrator_debug.c b/hw/misc/arm_integrator_debu=
g.c
index 2646107b97..3e23201ae6 100644
--- a/hw/misc/arm_integrator_debug.c
+++ b/hw/misc/arm_integrator_debug.c
@@ -15,7 +15,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/misc/arm_integrator_debug.h"
 #include "qemu/log.h"
diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index 47051436f4..2a4e0458c7 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -8,7 +8,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
diff --git a/hw/misc/debugexit.c b/hw/misc/debugexit.c
index 8e4a2fc701..752cb53cf6 100644
--- a/hw/misc/debugexit.c
+++ b/hw/misc/debugexit.c
@@ -8,7 +8,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/isa/isa.h"
 #include "qemu/module.h"
=20
diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 3b6dba2c72..d5e2bdbb57 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "hw/pci/pci.h"
+#include "hw/hw.h"
 #include "hw/pci/msi.h"
 #include "qemu/timer.h"
 #include "qemu/main-loop.h" /* iothread mutex */
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index d9b7ea145c..7a2334c98b 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -21,7 +21,6 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index feb80df0ff..5e8ee80c25 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -25,7 +25,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "hw/hw.h"
 #include "hw/ppc/mac.h"
 #include "migration/vmstate.h"
 #include "hw/input/adb.h"
diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
index 6f90afefb7..e62b622112 100644
--- a/hw/misc/macio/gpio.c
+++ b/hw/misc/macio/gpio.c
@@ -24,7 +24,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/ppc/mac.h"
 #include "migration/vmstate.h"
 #include "hw/misc/macio/macio.h"
diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
index beaf083578..e220f1a927 100644
--- a/hw/misc/macio/mac_dbdma.c
+++ b/hw/misc/macio/mac_dbdma.c
@@ -38,7 +38,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/ppc/mac_dbdma.h"
 #include "migration/vmstate.h"
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index c797bbd698..222f163139 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -26,7 +26,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "hw/hw.h"
 #include "hw/ppc/mac.h"
 #include "hw/misc/macio/cuda.h"
 #include "hw/pci/pci.h"
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index 507f62ba64..d824a068d9 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -30,7 +30,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "hw/hw.h"
 #include "hw/ppc/mac.h"
 #include "migration/vmstate.h"
 #include "hw/input/adb.h"
diff --git a/hw/misc/milkymist-hpdmc.c b/hw/misc/milkymist-hpdmc.c
index e9722d6c76..61e86e6b34 100644
--- a/hw/misc/milkymist-hpdmc.c
+++ b/hw/misc/milkymist-hpdmc.c
@@ -22,7 +22,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "trace.h"
diff --git a/hw/misc/milkymist-pfpu.c b/hw/misc/milkymist-pfpu.c
index 8c6baf5406..516825e83d 100644
--- a/hw/misc/milkymist-pfpu.c
+++ b/hw/misc/milkymist-pfpu.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/misc/mips_cmgcr.c b/hw/misc/mips_cmgcr.c
index 6dcdb4a225..6bddb2312a 100644
--- a/hw/misc/mips_cmgcr.c
+++ b/hw/misc/mips_cmgcr.c
@@ -12,7 +12,6 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 7e6dead089..f06cf0b52a 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -25,7 +25,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/input/adb.h"
 #include "hw/irq.h"
 #include "hw/misc/mos6522.h"
diff --git a/hw/misc/mst_fpga.c b/hw/misc/mst_fpga.c
index d002870e56..81abdf8ede 100644
--- a/hw/misc/mst_fpga.c
+++ b/hw/misc/mst_fpga.c
@@ -12,7 +12,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/misc/omap_gpmc.c b/hw/misc/omap_gpmc.c
index 6253b0b2d4..10de7a5523 100644
--- a/hw/misc/omap_gpmc.c
+++ b/hw/misc/omap_gpmc.c
@@ -20,7 +20,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/block/flash.h"
 #include "hw/arm/omap.h"
diff --git a/hw/misc/omap_l4.c b/hw/misc/omap_l4.c
index c217728c78..61b6df564a 100644
--- a/hw/misc/omap_l4.c
+++ b/hw/misc/omap_l4.c
@@ -18,7 +18,6 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/arm/omap.h"
=20
 struct omap_l4_s {
diff --git a/hw/misc/omap_sdrc.c b/hw/misc/omap_sdrc.c
index 7b38c5568c..f2f72f6810 100644
--- a/hw/misc/omap_sdrc.c
+++ b/hw/misc/omap_sdrc.c
@@ -18,7 +18,6 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/arm/omap.h"
=20
 /* SDRAM Controller Subsystem */
diff --git a/hw/misc/pc-testdev.c b/hw/misc/pc-testdev.c
index 46adb6b5fc..94cf55440e 100644
--- a/hw/misc/pc-testdev.c
+++ b/hw/misc/pc-testdev.c
@@ -36,7 +36,6 @@
 */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/qdev.h"
 #include "qemu/module.h"
 #include "hw/irq.h"
diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index bb05811e1f..73be28d936 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -12,7 +12,6 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "hw/hw.h"
 #include "hw/misc/pca9552.h"
 #include "hw/misc/pca9552_regs.h"
 #include "migration/vmstate.h"
diff --git a/hw/misc/pci-testdev.c b/hw/misc/pci-testdev.c
index d4d89df4cf..0eb9ed5469 100644
--- a/hw/misc/pci-testdev.c
+++ b/hw/misc/pci-testdev.c
@@ -19,7 +19,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "qemu/event_notifier.h"
 #include "qemu/module.h"
diff --git a/hw/misc/puv3_pm.c b/hw/misc/puv3_pm.c
index b538b4afbb..c213500d9c 100644
--- a/hw/misc/puv3_pm.c
+++ b/hw/misc/puv3_pm.c
@@ -10,7 +10,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/sysbus.h"
=20
 #undef DEBUG_PUV3
diff --git a/hw/misc/tmp105.c b/hw/misc/tmp105.c
index 28996473cb..75ddad3a12 100644
--- a/hw/misc/tmp105.c
+++ b/hw/misc/tmp105.c
@@ -19,7 +19,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/i2c/i2c.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
diff --git a/hw/misc/tmp421.c b/hw/misc/tmp421.c
index 6728aa7e10..9f044705fa 100644
--- a/hw/misc/tmp421.c
+++ b/hw/misc/tmp421.c
@@ -25,7 +25,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/i2c/i2c.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
diff --git a/hw/misc/unimp.c b/hw/misc/unimp.c
index 7f8e42cc2c..0e1cb24629 100644
--- a/hw/misc/unimp.c
+++ b/hw/misc/unimp.c
@@ -12,7 +12,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/misc/unimp.h"
 #include "qemu/log.h"
diff --git a/hw/misc/zynq-xadc.c b/hw/misc/zynq-xadc.c
index edfe76ba20..7745df4c85 100644
--- a/hw/misc/zynq-xadc.c
+++ b/hw/misc/zynq-xadc.c
@@ -14,7 +14,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/misc/zynq-xadc.h"
 #include "migration/vmstate.h"
diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index 82430a146a..d4fdd2c26d 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -15,7 +15,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "qemu/timer.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
index 16a7d58274..57af1b4891 100644
--- a/hw/moxie/moxiesim.c
+++ b/hw/moxie/moxiesim.c
@@ -30,7 +30,6 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
-#include "hw/hw.h"
 #include "net/net.h"
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/net/can/can_kvaser_pci.c b/hw/net/can/can_kvaser_pci.c
index 10963ef58c..401da73cc8 100644
--- a/hw/net/can/can_kvaser_pci.c
+++ b/hw/net/can/can_kvaser_pci.c
@@ -36,7 +36,6 @@
 #include "qemu/sockets.h"
 #include "qapi/error.h"
 #include "chardev/char.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
diff --git a/hw/net/can/can_mioe3680_pci.c b/hw/net/can/can_mioe3680_pci.=
c
index 9e060dff01..0f0ca912c9 100644
--- a/hw/net/can/can_mioe3680_pci.c
+++ b/hw/net/can/can_mioe3680_pci.c
@@ -32,7 +32,6 @@
 #include "qemu/sockets.h"
 #include "qapi/error.h"
 #include "chardev/char.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
diff --git a/hw/net/can/can_pcm3680_pci.c b/hw/net/can/can_pcm3680_pci.c
index 5d12f0c552..632eb0b59b 100644
--- a/hw/net/can/can_pcm3680_pci.c
+++ b/hw/net/can/can_pcm3680_pci.c
@@ -32,7 +32,6 @@
 #include "qemu/sockets.h"
 #include "qapi/error.h"
 #include "chardev/char.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index 6c84be6d29..1f81341554 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -28,7 +28,6 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "chardev/char.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "net/can_emu.h"
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index e4e91382f0..da5f3646fd 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -26,7 +26,6 @@
=20
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 22e3132581..270ff93841 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -40,6 +40,7 @@
 #include "qemu/module.h"
 #include "qemu/range.h"
 #include "sysemu/sysemu.h"
+#include "hw/hw.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "migration/vmstate.h"
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 2a221c2ef9..40e41fdd92 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -37,6 +37,7 @@
 #include "sysemu/sysemu.h"
 #include "net/net.h"
 #include "net/tap.h"
+#include "hw/hw.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
=20
diff --git a/hw/net/e1000x_common.c b/hw/net/e1000x_common.c
index 09047806f2..717f9df1c9 100644
--- a/hw/net/e1000x_common.c
+++ b/hw/net/e1000x_common.c
@@ -24,7 +24,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "net/net.h"
=20
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index 3c1c534cbf..2ad1b328e4 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -42,7 +42,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 937d5603e2..1d32cb79e2 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -15,6 +15,7 @@
 #include "migration/vmstate.h"
 #include "net/net.h"
 #include "net/eth.h"
+#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/net/lan9118.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/net/milkymist-minimac2.c b/hw/net/milkymist-minimac2.c
index a7d879f0ab..1e3fb9c220 100644
--- a/hw/net/milkymist-minimac2.c
+++ b/hw/net/milkymist-minimac2.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h" /* FIXME: why does this use TARGET_PAGE_ALIGN? */
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/net/mipsnet.c b/hw/net/mipsnet.c
index 3910beb9a6..013f762d72 100644
--- a/hw/net/mipsnet.c
+++ b/hw/net/mipsnet.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "net/net.h"
 #include "qemu/module.h"
diff --git a/hw/net/ne2000.h b/hw/net/ne2000.h
index 2cd193e4c6..fc75843703 100644
--- a/hw/net/ne2000.h
+++ b/hw/net/ne2000.h
@@ -2,7 +2,6 @@
 #define HW_NE2000_H
=20
 #include "qemu/units.h"
-#include "hw/hw.h"
 #include "net/net.h"
=20
 #define NE2000_PMEM_SIZE    (32 * KiB)
diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index 3e759d79d8..a9e96cdd3a 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -32,7 +32,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/net/mii.h"
 #include "hw/sysbus.h"
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 4ce8f62a2a..789e5c4876 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -16,7 +16,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
 #include "hw/pci/msix.h"
diff --git a/hw/net/rocker/rocker_desc.c b/hw/net/rocker/rocker_desc.c
index b009da4f89..01845f1157 100644
--- a/hw/net/rocker/rocker_desc.c
+++ b/hw/net/rocker/rocker_desc.c
@@ -16,7 +16,6 @@
=20
 #include "qemu/osdep.h"
 #include "net/net.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
=20
 #include "rocker.h"
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 9975af44dd..89156ed802 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -53,7 +53,6 @@
 #include "qemu/osdep.h"
 #include <zlib.h>
=20
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
 #include "sysemu/dma.h"
diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index 0ce5e37a28..60085b1bf4 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -27,7 +27,6 @@
=20
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index 9d8fd70f51..359bd4f9f5 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
 #include "hw/net/mii.h"
diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
index ffb3b5898d..00a7fdf843 100644
--- a/hw/net/xen_nic.c
+++ b/hw/net/xen_nic.c
@@ -24,7 +24,6 @@
 #include <sys/ioctl.h>
 #include <sys/wait.h>
=20
-#include "hw/hw.h"
 #include "net/net.h"
 #include "net/checksum.h"
 #include "net/util.h"
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index b1247a1d9b..b22e344a4b 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -30,6 +30,7 @@
 #include "net/net.h"
 #include "net/checksum.h"
=20
+#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/stream.h"
=20
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 27a4fc8d87..a963087f16 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -26,7 +26,6 @@
 #include "qemu/module.h"
 #include "cpu.h" /* FIXME should not use tswap* */
 #include "hw/sysbus.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "net/net.h"
=20
diff --git a/hw/nios2/10m50_devboard.c b/hw/nios2/10m50_devboard.c
index 2c3388f5cf..3c01e4f667 100644
--- a/hw/nios2/10m50_devboard.c
+++ b/hw/nios2/10m50_devboard.c
@@ -27,7 +27,6 @@
 #include "cpu.h"
=20
 #include "hw/sysbus.h"
-#include "hw/hw.h"
 #include "hw/char/serial.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
diff --git a/hw/nios2/boot.h b/hw/nios2/boot.h
index 3116753818..59b9fbfc62 100644
--- a/hw/nios2/boot.h
+++ b/hw/nios2/boot.h
@@ -1,7 +1,6 @@
 #ifndef NIOS2_BOOT_H
 #define NIOS2_BOOT_H
=20
-#include "hw/hw.h"
 #include "cpu.h"
=20
 void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base, uint32_t ramsize,
diff --git a/hw/nios2/generic_nommu.c b/hw/nios2/generic_nommu.c
index 1788ffa7a4..2ec91e899b 100644
--- a/hw/nios2/generic_nommu.c
+++ b/hw/nios2/generic_nommu.c
@@ -32,7 +32,6 @@
 #include "cpu.h"
=20
 #include "hw/sysbus.h"
-#include "hw/hw.h"
 #include "hw/char/serial.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
diff --git a/hw/nvram/chrp_nvram.c b/hw/nvram/chrp_nvram.c
index 3837510dd2..d969f26704 100644
--- a/hw/nvram/chrp_nvram.c
+++ b/hw/nvram/chrp_nvram.c
@@ -21,7 +21,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
-#include "hw/hw.h"
 #include "hw/nvram/chrp_nvram.h"
 #include "sysemu/sysemu.h"
=20
diff --git a/hw/nvram/eeprom93xx.c b/hw/nvram/eeprom93xx.c
index c2b012d583..5b01b9b03f 100644
--- a/hw/nvram/eeprom93xx.c
+++ b/hw/nvram/eeprom93xx.c
@@ -36,7 +36,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/nvram/eeprom93xx.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index f75a485738..00f942db51 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -11,7 +11,6 @@
=20
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "hw/hw.h"
 #include "hw/i2c/i2c.h"
 #include "sysemu/block-backend.h"
=20
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index a5e614016a..f192c3ea16 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -24,7 +24,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "hw/hw.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/dma.h"
 #include "sysemu/reset.h"
diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
index 4f0d2f6bd4..853b693109 100644
--- a/hw/nvram/mac_nvram.c
+++ b/hw/nvram/mac_nvram.c
@@ -24,7 +24,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/nvram/chrp_nvram.h"
 #include "hw/ppc/mac.h"
 #include "migration/vmstate.h"
diff --git a/hw/openrisc/cputimer.c b/hw/openrisc/cputimer.c
index e9f89333dc..93268815d8 100644
--- a/hw/openrisc/cputimer.c
+++ b/hw/openrisc/cputimer.c
@@ -20,7 +20,6 @@
=20
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
=20
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 965d5b44ee..13572b8eff 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -22,7 +22,6 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/boards.h"
 #include "elf.h"
diff --git a/hw/openrisc/pic_cpu.c b/hw/openrisc/pic_cpu.c
index d3f179ff8d..36f9350830 100644
--- a/hw/openrisc/pic_cpu.c
+++ b/hw/openrisc/pic_cpu.c
@@ -19,7 +19,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "cpu.h"
=20
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 58870e0d87..30e078763f 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -39,7 +39,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "hw/i386/pc.h"
 #include "hw/irq.h"
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index 1a45c30505..93f28efb49 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -31,7 +31,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/pci-host/gpex.h"
 #include "migration/vmstate.h"
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 9e8c8542d3..bc9726057a 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 840869f19c..241e7e788d 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -15,7 +15,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/ppc/e500-ccsr.h"
 #include "migration/vmstate.h"
diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 34a36812ea..588c7dc6c0 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -27,7 +27,6 @@
 #include "qemu-common.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 25335a8b71..1688a89b6a 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -29,7 +29,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/pci-host/q35.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 4ffb2d0d03..76293ab22b 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/ppc/mac.h"
 #include "qemu/module.h"
diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 81a23accf3..29187898f2 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -15,7 +15,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci.h"
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index de3691eee4..d84ecd8507 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -24,7 +24,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
diff --git a/hw/pci/pcie_host.c b/hw/pci/pcie_host.c
index d6768b8eb6..3534006f99 100644
--- a/hw/pci/pcie_host.c
+++ b/hw/pci/pcie_host.c
@@ -20,7 +20,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pcie_host.h"
 #include "qemu/module.h"
diff --git a/hw/pcmcia/pcmcia.c b/hw/pcmcia/pcmcia.c
index c16b12db01..03d13e7d67 100644
--- a/hw/pcmcia/pcmcia.c
+++ b/hw/pcmcia/pcmcia.c
@@ -6,7 +6,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/module.h"
-#include "hw/hw.h"
 #include "hw/pcmcia.h"
=20
 static const TypeInfo pcmcia_card_type_info =3D {
diff --git a/hw/pcmcia/pxa2xx.c b/hw/pcmcia/pxa2xx.c
index 26ab2267de..14e4dfe8b1 100644
--- a/hw/pcmcia/pxa2xx.c
+++ b/hw/pcmcia/pxa2xx.c
@@ -11,7 +11,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 0451a4e338..3f0c3dea92 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -22,7 +22,6 @@
 #include "e500-ccsr.h"
 #include "net/net.h"
 #include "qemu/config-file.h"
-#include "hw/hw.h"
 #include "hw/char/serial.h"
 #include "hw/pci/pci.h"
 #include "hw/boards.h"
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 0f9f351eb1..94a958e5e0 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -49,7 +49,6 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/mac.h"
 #include "hw/input/adb.h"
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 6640057473..aeeddd1d3b 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -28,7 +28,6 @@
 #include "qemu-common.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "hw/ppc/ppc.h"
 #include "mac.h"
 #include "hw/input/adb.h"
diff --git a/hw/ppc/mpc8544_guts.c b/hw/ppc/mpc8544_guts.c
index 2b7cc14060..ad9c219a8f 100644
--- a/hw/ppc/mpc8544_guts.c
+++ b/hw/ppc/mpc8544_guts.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
=20
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 96608883aa..114d5826df 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -26,7 +26,6 @@
 #include "sysemu/reset.h"
 #include "sysemu/cpus.h"
 #include "sysemu/device_tree.h"
-#include "hw/hw.h"
 #include "target/ppc/cpu.h"
 #include "qemu/log.h"
 #include "hw/ppc/fdt.h"
diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
index 4b76d34f0a..a27776aa99 100644
--- a/hw/ppc/pnv_bmc.c
+++ b/hw/ppc/pnv_bmc.c
@@ -17,7 +17,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "sysemu/sysemu.h"
 #include "target/ppc/cpu.h"
 #include "qemu/log.h"
diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index 636f91f311..6120405379 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -17,7 +17,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "sysemu/sysemu.h"
 #include "target/ppc/cpu.h"
 #include "qapi/error.h"
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index e66aeec4aa..f10d519014 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -18,7 +18,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "target/ppc/cpu.h"
 #include "qemu/log.h"
diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index 2b81c75f56..0e31c5786b 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -18,7 +18,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "sysemu/hw_accel.h"
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 5cc321828e..a1192d7889 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -24,7 +24,6 @@
=20
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc_e500.h"
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 5b278e7791..388cae0b43 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -27,7 +27,6 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/ppc/ppc.h"
 #include "ppc405.h"
 #include "hw/timer/m48t59.h"
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index bb62714fd9..ba092f2931 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -26,7 +26,6 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/ppc/ppc.h"
 #include "hw/boards.h"
 #include "hw/i2c/ppc4xx_i2c.h"
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 1bd92aa749..4d95c0f8a8 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -17,7 +17,6 @@
 #include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "net/net.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "hw/boards.h"
 #include "sysemu/kvm.h"
diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index 77a78388c1..2ee2d4f4fc 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -23,7 +23,6 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 6570c2d120..e7f42d78a1 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -15,7 +15,6 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index 49d714756f..c2e50138aa 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -26,7 +26,6 @@
 #include "qemu/units.h"
 #include "sysemu/reset.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index 7334d75890..3ea47df71f 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -20,7 +20,6 @@
  * 4xx SoCs, such as the 440EP. */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
index ba5f513ca5..ce0e1406e1 100644
--- a/hw/ppc/ppc_booke.c
+++ b/hw/ppc/ppc_booke.c
@@ -24,7 +24,6 @@
=20
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/ppc/ppc.h"
 #include "qemu/timer.h"
 #include "sysemu/reset.h"
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 01dc7e111b..4f3c6bf190 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -25,7 +25,6 @@
=20
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/timer/m48t59.h"
 #include "hw/char/serial.h"
 #include "hw/block/fdc.h"
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index c1d6f74d5b..7ed5518dbc 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -16,7 +16,6 @@
 #include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "hw/boards.h"
 #include "sysemu/kvm.h"
 #include "kvm_ppc.h"
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 76e815ceee..4c02ce9a08 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -32,7 +32,6 @@
 #include "sysemu/numa.h"
 #include "sysemu/qtest.h"
 #include "sysemu/reset.h"
-#include "hw/hw.h"
 #include "qemu/log.h"
 #include "hw/fw-path-provider.h"
 #include "elf.h"
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 57834e6a39..8223bdb39f 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -19,7 +19,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "hw/hw.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "sysemu/kvm.h"
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index e5f592322f..53b799fec7 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -26,7 +26,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 1095aa5f00..31ff0be189 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -23,7 +23,6 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "qemu/log.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 06f5a28601..099b94cc54 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -27,7 +27,6 @@
 #include "qemu/units.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
-#include "hw/hw.h"
 #include "hw/char/serial.h"
 #include "hw/block/flash.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index 8d70c0d23d..692125ac26 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -15,7 +15,6 @@
=20
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_ids.h"
=20
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index adcf79cd63..b924843367 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -16,7 +16,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_ids.h"
 #include "hw/pci/msi.h"
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 2a499d8ed2..862903d6b5 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -32,7 +32,6 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
diff --git a/hw/riscv/sifive_prci.c b/hw/riscv/sifive_prci.c
index f406682c91..562bc3dc4c 100644
--- a/hw/riscv/sifive_prci.c
+++ b/hw/riscv/sifive_prci.c
@@ -22,6 +22,7 @@
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "target/riscv/cpu.h"
+#include "hw/hw.h"
 #include "hw/riscv/sifive_prci.h"
=20
 static uint64_t sifive_prci_read(void *opaque, hwaddr addr, unsigned int=
 size)
diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
index 24a04d7b36..3a14f9f8b6 100644
--- a/hw/riscv/sifive_test.c
+++ b/hw/riscv/sifive_test.c
@@ -22,6 +22,7 @@
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "target/riscv/cpu.h"
+#include "hw/hw.h"
 #include "hw/riscv/sifive_test.h"
=20
 static uint64_t sifive_test_read(void *opaque, hwaddr addr, unsigned int=
 size)
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 71b8083c05..0b3c5dff97 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -29,7 +29,6 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
diff --git a/hw/riscv/sifive_uart.c b/hw/riscv/sifive_uart.c
index d18613fb33..9de42b1680 100644
--- a/hw/riscv/sifive_uart.c
+++ b/hw/riscv/sifive_uart.c
@@ -22,6 +22,7 @@
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
 #include "target/riscv/cpu.h"
+#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/riscv/sifive_uart.h"
=20
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 2991b341a2..9cc786b6b6 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -27,7 +27,6 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 25faf3b417..c72198b720 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -23,7 +23,6 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index fa537bfba3..a371370221 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -12,7 +12,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "net/net.h"
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 175eb79260..222a286d44 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -15,7 +15,6 @@
=20
 #include "qemu/osdep.h"
=20
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/pci/pci.h"
 #include "hw/scsi/scsi.h"
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 970b10048f..3706294a85 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -20,7 +20,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "sysemu/dma.h"
 #include "sysemu/block-backend.h"
diff --git a/hw/scsi/mptconfig.c b/hw/scsi/mptconfig.c
index 87a416a5cb..3b2a857b5c 100644
--- a/hw/scsi/mptconfig.c
+++ b/hw/scsi/mptconfig.c
@@ -16,7 +16,6 @@
  * Lesser General Public License for more details.
  */
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "hw/scsi/scsi.h"
=20
diff --git a/hw/scsi/mptendian.c b/hw/scsi/mptendian.c
index 79f99734d2..313f40edf9 100644
--- a/hw/scsi/mptendian.c
+++ b/hw/scsi/mptendian.c
@@ -21,7 +21,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "sysemu/dma.h"
 #include "hw/pci/msi.h"
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 79501777d4..b32f4c0ca9 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "sysemu/dma.h"
 #include "hw/pci/msi.h"
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 42928a6aec..1f9914739a 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 5290f7569a..fedeec676d 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -35,7 +35,6 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/scsi/scsi.h"
 #include "migration/vmstate.h"
 #include "scsi/constants.h"
diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index dcb7169166..e3c7cf5b5f 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index 15a0bbe87d..c6e516b611 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -21,7 +21,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/arm/omap.h"
 #include "hw/sd/sd.h"
diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 020cd5464c..db2f2adf58 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -12,7 +12,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 02924329bf..3f26b38786 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -33,7 +33,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "hw/qdev.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/registerfields.h"
 #include "sysemu/block-backend.h"
diff --git a/hw/sd/sdhci-pci.c b/hw/sd/sdhci-pci.c
index 9370181993..438cb30af5 100644
--- a/hw/sd/sdhci-pci.c
+++ b/hw/sd/sdhci-pci.c
@@ -18,7 +18,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "hw/hw.h"
 #include "hw/sd/sdhci.h"
 #include "sdhci-internal.h"
=20
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index f9db39c834..1adc16e3e9 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -26,7 +26,6 @@
 #include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "sysemu/dma.h"
 #include "qemu/timer.h"
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 9838ea3323..571e594304 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -28,7 +28,6 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
-#include "hw/hw.h"
 #include "hw/sh4/sh.h"
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index b35d07265d..d660714443 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -24,7 +24,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sh4/sh.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/sh4/sh7750_regnames.c b/hw/sh4/sh7750_regnames.c
index 34b4f99b86..0630fe3cf4 100644
--- a/hw/sh4/sh7750_regnames.c
+++ b/hw/sh4/sh7750_regnames.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/sh4/sh.h"
 #include "sh7750_regs.h"
 #include "sh7750_regnames.h"
diff --git a/hw/sh4/shix.c b/hw/sh4/shix.c
index 6a1c7238e9..2fc2915428 100644
--- a/hw/sh4/shix.c
+++ b/hw/sh4/shix.c
@@ -30,7 +30,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/sh4/sh.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 9c43806690..655939a3f1 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -28,7 +28,6 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index dc0ce7eda4..1efcff628a 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/boards.h"
 #include "hw/char/serial.h"
 #include "hw/misc/unimp.h"
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index c95ed94d2e..54a385970c 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -28,7 +28,6 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index b310dfb1b3..0339b92cf8 100644
--- a/hw/timer/a9gtimer.c
+++ b/hw/timer/a9gtimer.c
@@ -21,6 +21,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/timer/a9gtimer.h"
 #include "migration/vmstate.h"
diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index a13255d308..abfc5baa77 100644
--- a/hw/timer/arm_mptimer.c
+++ b/hw/timer/arm_mptimer.c
@@ -20,6 +20,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/ptimer.h"
 #include "hw/timer/arm_mptimer.h"
diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index 7f2af5287c..79b291863c 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -62,6 +62,7 @@
 #include "hw/ptimer.h"
=20
 #include "hw/arm/exynos4210.h"
+#include "hw/hw.h"
 #include "hw/irq.h"
=20
 //#define DEBUG_MCT
diff --git a/hw/timer/exynos4210_rtc.c b/hw/timer/exynos4210_rtc.c
index 561451059e..f79b970c5e 100644
--- a/hw/timer/exynos4210_rtc.c
+++ b/hw/timer/exynos4210_rtc.c
@@ -35,7 +35,6 @@
 #include "qemu/bcd.h"
 #include "hw/ptimer.h"
=20
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "sysemu/sysemu.h"
=20
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 305704a339..1ddae4e7d7 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -25,7 +25,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/irq.h"
 #include "ui/console.h"
diff --git a/hw/timer/i8254.c b/hw/timer/i8254.c
index 97258757b1..a4be7330ef 100644
--- a/hw/timer/i8254.c
+++ b/hw/timer/i8254.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
diff --git a/hw/timer/i8254_common.c b/hw/timer/i8254_common.c
index 062e8690c4..57bf10cc94 100644
--- a/hw/timer/i8254_common.c
+++ b/hw/timer/i8254_common.c
@@ -24,7 +24,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/isa/isa.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
diff --git a/hw/timer/lm32_timer.c b/hw/timer/lm32_timer.c
index bfa9de76ba..a381e39f0a 100644
--- a/hw/timer/lm32_timer.c
+++ b/hw/timer/lm32_timer.c
@@ -22,7 +22,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
index 1240315206..199003030a 100644
--- a/hw/timer/m48t59.c
+++ b/hw/timer/m48t59.c
@@ -25,7 +25,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/timer/m48t59.h"
 #include "qemu/timer.h"
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index b432662bc4..473935339d 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -27,7 +27,6 @@
 #include "qemu/cutils.h"
 #include "qemu/module.h"
 #include "qemu/bcd.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/timer/milkymist-sysctl.c b/hw/timer/milkymist-sysctl.c
index 7c56224710..900b0b62a9 100644
--- a/hw/timer/milkymist-sysctl.c
+++ b/hw/timer/milkymist-sysctl.c
@@ -22,7 +22,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/timer/mips_gictimer.c b/hw/timer/mips_gictimer.c
index f5c5806724..bc44cd934e 100644
--- a/hw/timer/mips_gictimer.c
+++ b/hw/timer/mips_gictimer.c
@@ -7,7 +7,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "hw/timer/mips_gictimer.h"
diff --git a/hw/timer/omap_gptimer.c b/hw/timer/omap_gptimer.c
index c34f60b5d4..c407190138 100644
--- a/hw/timer/omap_gptimer.c
+++ b/hw/timer/omap_gptimer.c
@@ -19,7 +19,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "qemu/timer.h"
 #include "hw/arm/omap.h"
diff --git a/hw/timer/omap_synctimer.c b/hw/timer/omap_synctimer.c
index 0d75a90f3a..72b997939b 100644
--- a/hw/timer/omap_synctimer.c
+++ b/hw/timer/omap_synctimer.c
@@ -18,7 +18,6 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "qemu/timer.h"
 #include "hw/arm/omap.h"
 struct omap_synctimer_s {
diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index f61053b3c6..99e6c1e250 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -8,7 +8,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/timer/sun4v-rtc.c b/hw/timer/sun4v-rtc.c
index ba62adc826..54272a822f 100644
--- a/hw/timer/sun4v-rtc.c
+++ b/hw/timer/sun4v-rtc.c
@@ -10,7 +10,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
diff --git a/hw/timer/twl92230.c b/hw/timer/twl92230.c
index 6b2a25b9c9..63bd13d2ca 100644
--- a/hw/timer/twl92230.c
+++ b/hw/timer/twl92230.c
@@ -21,7 +21,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "hw/hw.h"
 #include "qemu/timer.h"
 #include "hw/i2c/i2c.h"
 #include "hw/irq.h"
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 76c1e16fa1..22f9113432 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -33,7 +33,6 @@
 #include "io/channel-socket.h"
 #include "sysemu/tpm_backend.h"
 #include "tpm_int.h"
-#include "hw/hw.h"
 #include "tpm_util.h"
 #include "tpm_ioctl.h"
 #include "migration/blocker.h"
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 897e3d5864..f67244b5d4 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -29,7 +29,6 @@
 #include "qemu/sockets.h"
 #include "sysemu/tpm_backend.h"
 #include "tpm_int.h"
-#include "hw/hw.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/qapi-visit-tpm.h"
 #include "tpm_util.h"
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboar=
d.c
index be397ebf92..c6305dcdf1 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -22,7 +22,6 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 6aff15e504..be18221ac6 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/usb.h"
 #include "hw/qdev.h"
 #include "qapi/error.h"
diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index d4074edfc3..c0f35c58d5 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -34,7 +34,6 @@
 #include "hw/usb.h"
 #include "migration/vmstate.h"
 #include "desc.h"
-#include "hw/hw.h"
 #include "audio/audio.h"
=20
 #define USBAUDIO_VENDOR_NUM     0x46f4 /* CRC16() of "QEMU" */
diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index c7c65a8782..79b3be3c3f 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -24,7 +24,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "ui/console.h"
 #include "hw/usb.h"
 #include "migration/vmstate.h"
diff --git a/hw/usb/dev-wacom.c b/hw/usb/dev-wacom.c
index 9a8a2d3081..8ed57b3b44 100644
--- a/hw/usb/dev-wacom.c
+++ b/hw/usb/dev-wacom.c
@@ -27,7 +27,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "ui/console.h"
 #include "hw/usb.h"
 #include "migration/vmstate.h"
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index fedf82c611..fdbcfdcbeb 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -18,7 +18,6 @@
 #ifndef HW_USB_HCD_EHCI_H
 #define HW_USB_HCD_EHCI_H
=20
-#include "hw/hw.h"
 #include "qemu/timer.h"
 #include "hw/usb.h"
 #include "sysemu/dma.h"
diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c
index 67fcfc4d7c..25b0ced804 100644
--- a/hw/usb/hcd-ohci-pci.c
+++ b/hw/usb/hcd-ohci-pci.c
@@ -19,7 +19,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "hw/usb.h"
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 438dfb4b83..94b3410d3c 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -26,7 +26,6 @@
 */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 887885efa0..7c6edd17b4 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -27,7 +27,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/usb.h"
 #include "hw/usb/uhci-regs.h"
 #include "migration/vmstate.h"
diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index e099382b24..aba3716875 100644
--- a/hw/usb/hcd-xhci-nec.c
+++ b/hw/usb/hcd-xhci-nec.c
@@ -20,7 +20,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/usb.h"
 #include "qemu/module.h"
 #include "hw/pci/pci.h"
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index fc67476100..d60ad895a3 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -20,7 +20,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "qemu/timer.h"
 #include "qemu/module.h"
 #include "qemu/queue.h"
diff --git a/hw/usb/libhw.c b/hw/usb/libhw.c
index adbee2f642..9c33a1640f 100644
--- a/hw/usb/libhw.c
+++ b/hw/usb/libhw.c
@@ -20,7 +20,6 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/usb.h"
 #include "sysemu/dma.h"
=20
diff --git a/hw/usb/tusb6010.c b/hw/usb/tusb6010.c
index a61b0f6354..17580876c6 100644
--- a/hw/usb/tusb6010.c
+++ b/hw/usb/tusb6010.c
@@ -24,6 +24,7 @@
 #include "qemu/timer.h"
 #include "hw/usb.h"
 #include "hw/arm/omap.h"
+#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
=20
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index b35a640030..62d765a4ea 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -19,6 +19,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include <sys/ioctl.h>
+#include "hw/hw.h"
 #include "hw/nvram/fw_cfg.h"
 #include "pci.h"
 #include "trace.h"
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 8a58ad670c..48ac0f5a34 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -22,6 +22,7 @@
 #include <linux/vfio.h>
 #include <sys/ioctl.h>
=20
+#include "hw/hw.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_bridge.h"
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index ba1006ad96..34accdf615 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -16,7 +16,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/virtio/vhost.h"
-#include "hw/hw.h"
 #include "qemu/atomic.h"
 #include "qemu/range.h"
 #include "qemu/error-report.h"
diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index 1d29a631f3..207e955996 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
index 288be8f73c..370cf92e85 100644
--- a/hw/watchdog/wdt_i6300esb.c
+++ b/hw/watchdog/wdt_i6300esb.c
@@ -24,7 +24,6 @@
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "sysemu/watchdog.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
=20
diff --git a/hw/watchdog/wdt_ib700.c b/hw/watchdog/wdt_ib700.c
index e233945c2e..985944a84a 100644
--- a/hw/watchdog/wdt_ib700.c
+++ b/hw/watchdog/wdt_ib700.c
@@ -23,7 +23,6 @@
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "sysemu/watchdog.h"
-#include "hw/hw.h"
 #include "hw/isa/isa.h"
 #include "migration/vmstate.h"
=20
diff --git a/hw/xen/xen-bus-helper.c b/hw/xen/xen-bus-helper.c
index 5f7a4b2612..b459bb9396 100644
--- a/hw/xen/xen-bus-helper.c
+++ b/hw/xen/xen-bus-helper.c
@@ -6,7 +6,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/xen/xen.h"
 #include "hw/xen/xen-bus.h"
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 7503eea9e9..3f39a894da 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -9,7 +9,6 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/uuid.h"
-#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/xen/xen.h"
 #include "hw/xen/xen-backend.h"
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 3715c94fa6..2831940ae7 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include <sys/signal.h>
=20
-#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/boards.h"
 #include "qemu/log.h"
diff --git a/hw/xen/xen_pt_load_rom.c b/hw/xen/xen_pt_load_rom.c
index e6a86ca818..d111ecaf7e 100644
--- a/hw/xen/xen_pt_load_rom.c
+++ b/hw/xen/xen_pt_load_rom.c
@@ -3,7 +3,6 @@
  */
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "qemu/error-report.h"
 #include "ui/console.h"
diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index dcaf2a01a3..524d608eab 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -24,7 +24,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "hw/hw.h"
 #include "hw/boards.h"
 #include "hw/xen/xen-legacy-backend.h"
 #include "hw/xen/xen-bus.h"
diff --git a/hw/xtensa/mx_pic.c b/hw/xtensa/mx_pic.c
index 912de66206..d889f953d1 100644
--- a/hw/xtensa/mx_pic.c
+++ b/hw/xtensa/mx_pic.c
@@ -26,7 +26,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/xtensa/mx_pic.h"
 #include "qemu/log.h"
diff --git a/hw/xtensa/pic_cpu.c b/hw/xtensa/pic_cpu.c
index b708290d7b..edd53c9241 100644
--- a/hw/xtensa/pic_cpu.c
+++ b/hw/xtensa/pic_cpu.c
@@ -27,7 +27,6 @@
=20
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "qemu/log.h"
 #include "qemu/timer.h"
diff --git a/include/hw/audio/pcspk.h b/include/hw/audio/pcspk.h
index 172afbf146..0f5d4f9919 100644
--- a/include/hw/audio/pcspk.h
+++ b/include/hw/audio/pcspk.h
@@ -25,7 +25,6 @@
 #ifndef HW_PCSPK_H
 #define HW_PCSPK_H
=20
-#include "hw/hw.h"
 #include "hw/isa/isa.h"
=20
 #define TYPE_PC_SPEAKER "isa-pcspk"
diff --git a/include/hw/audio/wm8750.h b/include/hw/audio/wm8750.h
index e12cb886d1..f7bafd5e38 100644
--- a/include/hw/audio/wm8750.h
+++ b/include/hw/audio/wm8750.h
@@ -14,7 +14,6 @@
 #ifndef HW_DAC_WM8750_H
 #define HW_DAC_WM8750_H
=20
-#include "hw/hw.h"
=20
 #define TYPE_WM8750 "wm8750"
 #define TYPE_MV88W8618_AUDIO "mv88w8618_audio"
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index abd5cf71a9..bfcbbb6e19 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -26,7 +26,6 @@
 #ifndef HW_SERIAL_H
 #define HW_SERIAL_H
=20
-#include "hw/hw.h"
 #include "sysemu/sysemu.h"
 #include "chardev/char-fe.h"
 #include "exec/memory.h"
diff --git a/include/hw/char/stm32f2xx_usart.h b/include/hw/char/stm32f2x=
x_usart.h
index 84c4029777..8e112671e3 100644
--- a/include/hw/char/stm32f2xx_usart.h
+++ b/include/hw/char/stm32f2xx_usart.h
@@ -27,7 +27,6 @@
=20
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
-#include "hw/hw.h"
=20
 #define USART_SR   0x00
 #define USART_DR   0x04
diff --git a/include/hw/dma/i8257.h b/include/hw/dma/i8257.h
index 2cab50bb6c..03e2c166be 100644
--- a/include/hw/dma/i8257.h
+++ b/include/hw/dma/i8257.h
@@ -1,7 +1,6 @@
 #ifndef HW_I8257_H
 #define HW_I8257_H
=20
-#include "hw/hw.h"
 #include "hw/isa/isa.h"
 #include "exec/ioport.h"
=20
diff --git a/include/hw/hw.h b/include/hw/hw.h
index 8079b911fa..fc5301f293 100644
--- a/include/hw/hw.h
+++ b/include/hw/hw.h
@@ -1,4 +1,3 @@
-/* Declarations for use by hardware emulation.  */
 #ifndef QEMU_HW_H
 #define QEMU_HW_H
=20
diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
index 046bcf33be..72e803f6e2 100644
--- a/include/hw/i386/ich9.h
+++ b/include/hw/i386/ich9.h
@@ -1,7 +1,6 @@
 #ifndef HW_ICH9_H
 #define HW_ICH9_H
=20
-#include "hw/hw.h"
 #include "hw/isa/isa.h"
 #include "hw/sysbus.h"
 #include "hw/i386/pc.h"
diff --git a/include/hw/i386/ioapic_internal.h b/include/hw/i386/ioapic_i=
nternal.h
index 3d2eec2aa7..d46c87c510 100644
--- a/include/hw/i386/ioapic_internal.h
+++ b/include/hw/i386/ioapic_internal.h
@@ -22,7 +22,6 @@
 #ifndef QEMU_IOAPIC_INTERNAL_H
 #define QEMU_IOAPIC_INTERNAL_H
=20
-#include "hw/hw.h"
 #include "exec/memory.h"
 #include "hw/i386/ioapic.h"
 #include "hw/sysbus.h"
diff --git a/include/hw/input/i8042.h b/include/hw/input/i8042.h
index f6ff146364..246e6f3335 100644
--- a/include/hw/input/i8042.h
+++ b/include/hw/input/i8042.h
@@ -8,7 +8,6 @@
 #ifndef HW_INPUT_I8042_H
 #define HW_INPUT_I8042_H
=20
-#include "hw/hw.h"
 #include "hw/isa/isa.h"
=20
 #define TYPE_I8042 "i8042"
diff --git a/include/hw/isa/apm.h b/include/hw/isa/apm.h
index 0f93602936..b6e070c00e 100644
--- a/include/hw/isa/apm.h
+++ b/include/hw/isa/apm.h
@@ -1,7 +1,6 @@
 #ifndef APM_H
 #define APM_H
=20
-#include "hw/hw.h"
 #include "exec/memory.h"
=20
 #define APM_CNT_IOPORT  0xb2
diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_inter=
nal.h
index f742c2a726..ee189e4a77 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -25,7 +25,6 @@
 #ifndef QEMU_I8259_INTERNAL_H
 #define QEMU_I8259_INTERNAL_H
=20
-#include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/isa/isa.h"
 #include "hw/intc/intc.h"
diff --git a/include/hw/misc/stm32f2xx_syscfg.h b/include/hw/misc/stm32f2=
xx_syscfg.h
index 69e6a30fc5..84e06fdecf 100644
--- a/include/hw/misc/stm32f2xx_syscfg.h
+++ b/include/hw/misc/stm32f2xx_syscfg.h
@@ -26,7 +26,6 @@
 #define HW_STM32F2XX_SYSCFG_H
=20
 #include "hw/sysbus.h"
-#include "hw/hw.h"
=20
 #define SYSCFG_MEMRMP  0x00
 #define SYSCFG_PMC     0x04
diff --git a/include/hw/net/ne2000-isa.h b/include/hw/net/ne2000-isa.h
index 5acf4a494e..1233928a34 100644
--- a/include/hw/net/ne2000-isa.h
+++ b/include/hw/net/ne2000-isa.h
@@ -10,7 +10,6 @@
 #ifndef HW_NET_NE2000_ISA_H
 #define HW_NET_NE2000_ISA_H
=20
-#include "hw/hw.h"
 #include "hw/qdev.h"
 #include "hw/isa/isa.h"
 #include "net/net.h"
diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/desig=
nware.h
index 186bb36238..31c41231b1 100644
--- a/include/hw/pci-host/designware.h
+++ b/include/hw/pci-host/designware.h
@@ -21,7 +21,6 @@
 #ifndef DESIGNWARE_H
 #define DESIGNWARE_H
=20
-#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
index 2af1c4a37e..faea040a93 100644
--- a/include/hw/pci-host/gpex.h
+++ b/include/hw/pci-host/gpex.h
@@ -20,7 +20,6 @@
 #ifndef HW_GPEX_H
 #define HW_GPEX_H
=20
-#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pcie_host.h"
diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index 5ed77facd0..b3bcf2e632 100644
--- a/include/hw/pci-host/q35.h
+++ b/include/hw/pci-host/q35.h
@@ -22,7 +22,6 @@
 #ifndef HW_Q35_H
 #define HW_Q35_H
=20
-#include "hw/hw.h"
 #include "hw/isa/isa.h"
 #include "hw/sysbus.h"
 #include "hw/i386/pc.h"
diff --git a/include/hw/pci-host/uninorth.h b/include/hw/pci-host/uninort=
h.h
index 9a5cabd4c5..72d2a97355 100644
--- a/include/hw/pci-host/uninorth.h
+++ b/include/hw/pci-host/uninorth.h
@@ -25,7 +25,6 @@
 #ifndef UNINORTH_H
 #define UNINORTH_H
=20
-#include "hw/hw.h"
 #include "hw/pci/pci_host.h"
 #include "hw/ppc/openpic.h"
=20
diff --git a/include/hw/pci-host/xilinx-pcie.h b/include/hw/pci-host/xili=
nx-pcie.h
index 74c04dc9bb..c0f15314be 100644
--- a/include/hw/pci-host/xilinx-pcie.h
+++ b/include/hw/pci-host/xilinx-pcie.h
@@ -20,7 +20,6 @@
 #ifndef HW_XILINX_PCIE_H
 #define HW_XILINX_PCIE_H
=20
-#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 8cf3361fc4..7064875835 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -21,7 +21,6 @@
 #ifndef QEMU_PCIE_H
 #define QEMU_PCIE_H
=20
-#include "hw/hw.h"
 #include "hw/pci/pci_regs.h"
 #include "hw/pci/pcie_regs.h"
 #include "hw/pci/pcie_aer.h"
diff --git a/include/hw/pci/pcie_aer.h b/include/hw/pci/pcie_aer.h
index 502dcd7eba..65e71d98fe 100644
--- a/include/hw/pci/pcie_aer.h
+++ b/include/hw/pci/pcie_aer.h
@@ -21,7 +21,6 @@
 #ifndef QEMU_PCIE_AER_H
 #define QEMU_PCIE_AER_H
=20
-#include "hw/hw.h"
 #include "hw/pci/pci_regs.h"
=20
 /* definitions which PCIExpressDevice uses */
diff --git a/include/hw/qdev.h b/include/hw/qdev.h
index 5cb8b080a6..d68991ae87 100644
--- a/include/hw/qdev.h
+++ b/include/hw/qdev.h
@@ -1,7 +1,6 @@
 #ifndef QDEV_H
 #define QDEV_H
=20
-#include "hw/hw.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
=20
diff --git a/include/hw/riscv/riscv_htif.h b/include/hw/riscv/riscv_htif.=
h
index fb5f88129e..aabc059f32 100644
--- a/include/hw/riscv/riscv_htif.h
+++ b/include/hw/riscv/riscv_htif.h
@@ -20,7 +20,6 @@
 #ifndef HW_RISCV_HTIF_H
 #define HW_RISCV_HTIF_H
=20
-#include "hw/hw.h"
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
 #include "sysemu/sysemu.h"
diff --git a/include/hw/ssi/stm32f2xx_spi.h b/include/hw/ssi/stm32f2xx_sp=
i.h
index 1cd73e4cd4..e24b007abf 100644
--- a/include/hw/ssi/stm32f2xx_spi.h
+++ b/include/hw/ssi/stm32f2xx_spi.h
@@ -26,7 +26,6 @@
 #define HW_STM32F2XX_SPI_H
=20
 #include "hw/sysbus.h"
-#include "hw/hw.h"
 #include "hw/ssi/ssi.h"
=20
 #define STM_SPI_CR1     0x00
diff --git a/include/hw/timer/aspeed_rtc.h b/include/hw/timer/aspeed_rtc.=
h
index 1f1155a676..15ba42912b 100644
--- a/include/hw/timer/aspeed_rtc.h
+++ b/include/hw/timer/aspeed_rtc.h
@@ -10,7 +10,6 @@
=20
 #include <stdint.h>
=20
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
=20
diff --git a/include/hw/timer/i8254.h b/include/hw/timer/i8254.h
index 5b12eb918e..608b116fcf 100644
--- a/include/hw/timer/i8254.h
+++ b/include/hw/timer/i8254.h
@@ -25,7 +25,6 @@
 #ifndef HW_I8254_H
 #define HW_I8254_H
=20
-#include "hw/hw.h"
 #include "hw/qdev.h"
 #include "hw/isa/isa.h"
=20
diff --git a/include/hw/timer/i8254_internal.h b/include/hw/timer/i8254_i=
nternal.h
index e611c6f227..3db462aecd 100644
--- a/include/hw/timer/i8254_internal.h
+++ b/include/hw/timer/i8254_internal.h
@@ -25,7 +25,6 @@
 #ifndef QEMU_I8254_INTERNAL_H
 #define QEMU_I8254_INTERNAL_H
=20
-#include "hw/hw.h"
 #include "hw/isa/isa.h"
 #include "hw/timer/i8254.h"
 #include "qemu/timer.h"
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 619498c8f4..085450c6f8 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -1,7 +1,6 @@
 #ifndef VHOST_H
 #define VHOST_H
=20
-#include "hw/hw.h"
 #include "hw/virtio/vhost-backend.h"
 #include "hw/virtio/virtio.h"
 #include "exec/memory.h"
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index e6a2a0a6e0..7bae09e3ae 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -15,7 +15,6 @@
 #define QEMU_VIRTIO_H
=20
 #include "exec/memory.h"
-#include "hw/hw.h"
 #include "net/net.h"
 #include "hw/qdev.h"
 #include "sysemu/sysemu.h"
diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index 0504b43659..1e3ec4e16e 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -14,7 +14,6 @@
 #include <xenstore.h>
 #include "hw/xen/interface/io/xenbus.h"
=20
-#include "hw/hw.h"
 #include "hw/xen/xen.h"
 #include "hw/pci/pci.h"
 #include "qemu/queue.h"
diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index 5da3c4e3c5..80c5bc3e02 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -12,7 +12,6 @@
=20
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
-#include "hw/hw.h"
 #include "block/block.h"
 #include "block/accounting.h"
=20
diff --git a/include/sysemu/hax.h b/include/sysemu/hax.h
index f005995c50..9b27e65cc7 100644
--- a/include/sysemu/hax.h
+++ b/include/sysemu/hax.h
@@ -37,7 +37,6 @@ void hax_cpu_synchronize_pre_loadvm(CPUState *cpu);
=20
 int hax_enabled(void);
=20
-#include "hw/hw.h"
 #include "qemu/bitops.h"
 #include "exec/memory.h"
 int hax_vcpu_destroy(CPUState *cpu);
diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index dd1722f2df..d211e808e9 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -24,7 +24,6 @@ extern bool hvf_allowed;
 #include <Hypervisor/hv_vmx.h>
 #include <Hypervisor/hv_error.h>
 #include "target/i386/cpu.h"
-#include "hw/hw.h"
 uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
                                  int reg);
 #define hvf_enabled() (hvf_allowed)
diff --git a/monitor/misc.c b/monitor/misc.c
index 00338c002a..117a172928 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "monitor-internal.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "monitor/qdev.h"
 #include "hw/usb.h"
 #include "hw/pci/pci.h"
diff --git a/target/alpha/machine.c b/target/alpha/machine.c
index fdab596438..b26ec29f0f 100644
--- a/target/alpha/machine.c
+++ b/target/alpha/machine.c
@@ -1,6 +1,5 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/boards.h"
 #include "migration/cpu.h"
=20
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 3fd319a309..bf2a0a6a09 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1,6 +1,5 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/boards.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
diff --git a/target/cris/machine.c b/target/cris/machine.c
index ecec41c2c8..be38a89377 100644
--- a/target/cris/machine.c
+++ b/target/cris/machine.c
@@ -20,7 +20,6 @@
=20
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "migration/cpu.h"
=20
 static const VMStateDescription vmstate_tlbset =3D {
diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index 73e8121bde..9fb82a53db 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -19,7 +19,6 @@
=20
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/boards.h"
 #include "migration/cpu.h"
=20
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 80f1443110..ff65e11008 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -54,7 +54,6 @@
 #include "hw/i386/topology.h"
 #ifndef CONFIG_USER_ONLY
 #include "exec/address-spaces.h"
-#include "hw/hw.h"
 #include "hw/xen/xen.h"
 #include "hw/i386/apic_internal.h"
 #include "hw/boards.h"
diff --git a/target/i386/machine.c b/target/i386/machine.c
index b1146093b5..f8c6feea08 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1,7 +1,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "hw/hw.h"
 #include "hw/boards.h"
 #include "hw/i386/pc.h"
 #include "hw/isa/isa.h"
diff --git a/target/lm32/machine.c b/target/lm32/machine.c
index cc46f77324..db43ef0631 100644
--- a/target/lm32/machine.c
+++ b/target/lm32/machine.c
@@ -1,6 +1,5 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/boards.h"
 #include "migration/cpu.h"
=20
diff --git a/target/mips/machine.c b/target/mips/machine.c
index eb2d97001d..7f4b5d524d 100644
--- a/target/mips/machine.c
+++ b/target/mips/machine.c
@@ -1,7 +1,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "internal.h"
-#include "hw/hw.h"
 #include "migration/cpu.h"
=20
 static int cpu_post_load(void *opaque, int version_id)
diff --git a/target/moxie/machine.c b/target/moxie/machine.c
index 322a724e6f..675272f9e0 100644
--- a/target/moxie/machine.c
+++ b/target/moxie/machine.c
@@ -1,6 +1,5 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/boards.h"
 #include "machine.h"
 #include "migration/cpu.h"
diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index 9fa285217d..99c0470a44 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -19,7 +19,6 @@
=20
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/boards.h"
 #include "migration/cpu.h"
=20
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 4bd95be9cd..4b05014a64 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -37,6 +37,7 @@
 #include "hw/sysbus.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_cpu_core.h"
+#include "hw/hw.h"
 #include "hw/ppc/ppc.h"
 #include "migration/qemu-file-types.h"
 #include "sysemu/watchdog.h"
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index e82f5de9db..199f5cef8f 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -1,7 +1,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "hw/hw.h"
 #include "hw/boards.h"
 #include "sysemu/kvm.h"
 #include "helper_regs.h"
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 3caba8d5e1..9466cd832d 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -37,7 +37,6 @@
 #include "sysemu/hw_accel.h"
 #include "hw/qdev-properties.h"
 #ifndef CONFIG_USER_ONLY
-#include "hw/hw.h"
 #include "hw/boards.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/sysemu.h"
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 6e814c230b..b465bb599e 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -36,7 +36,6 @@
 #include "qemu/log.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/hw_accel.h"
-#include "hw/hw.h"
 #include "sysemu/device_tree.h"
 #include "exec/gdbstub.h"
 #include "exec/ram_addr.h"
diff --git a/target/s390x/machine.c b/target/s390x/machine.c
index 12a2cd65b0..549bb6c280 100644
--- a/target/s390x/machine.c
+++ b/target/s390x/machine.c
@@ -15,7 +15,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "cpu.h"
 #include "internal.h"
 #include "kvm_s390x.h"
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 6e9c4d6151..7a563110f0 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -25,6 +25,7 @@
 #include "sysemu/tcg.h"
 #include "exec/exec-all.h"
 #include "trace.h"
+#include "hw/hw.h"
 #include "hw/s390x/storage-keys.h"
=20
 /* #define DEBUG_S390 */
diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index 32d453c008..7309c27319 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -1,7 +1,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "hw/hw.h"
 #include "hw/boards.h"
 #include "qemu/timer.h"
=20
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 2ffc3335f0..16478ecd45 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -34,7 +34,6 @@
 #include "qemu/notify.h"
 #include "qemu/option.h"
 #include "migration/misc.h"
-#include "hw/hw.h"
 #include "hw/pci/pci_bus.h"
 #include "ui/spice-display.h"
=20
diff --git a/vl.c b/vl.c
index 1abfd306e3..20328e682c 100644
--- a/vl.c
+++ b/vl.c
@@ -55,7 +55,6 @@ int main(int argc, char **argv)
=20
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
-#include "hw/hw.h"
 #include "sysemu/accel.h"
 #include "hw/usb.h"
 #include "hw/isa/isa.h"
--=20
2.21.0


