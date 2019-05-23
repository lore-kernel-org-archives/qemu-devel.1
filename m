Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F69CC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:49:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 793B0206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 793B0206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38077 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTp2L-0000QU-JR
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:49:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hToos-0004x8-2h
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hTooP-0007ad-54
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:35:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hTooO-0007YE-C9
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:35:17 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A99B43060485
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 14:35:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C20C2E02C
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 14:35:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 1D14B1132BD3; Thu, 23 May 2019 16:35:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 16:35:07 +0200
Message-Id: <20190523143508.25387-4-armbru@redhat.com>
In-Reply-To: <20190523143508.25387-1-armbru@redhat.com>
References: <20190523143508.25387-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Thu, 23 May 2019 14:35:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/4] Include qemu/module.h where needed,
 drop it from qemu-common.h
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 audio/alsaaudio.c                          | 3 ++-
 audio/audio.c                              | 2 ++
 audio/coreaudio.c                          | 2 +-
 audio/dsoundaudio.c                        | 2 +-
 audio/noaudio.c                            | 3 ++-
 audio/ossaudio.c                           | 3 ++-
 audio/paaudio.c                            | 3 ++-
 audio/sdlaudio.c                           | 3 ++-
 audio/spiceaudio.c                         | 1 +
 audio/wavaudio.c                           | 2 ++
 authz/base.c                               | 1 +
 authz/list.c                               | 1 +
 authz/listfile.c                           | 1 +
 authz/pamacct.c                            | 1 +
 authz/simple.c                             | 1 +
 backends/hostmem-file.c                    | 3 ++-
 backends/hostmem-memfd.c                   | 3 ++-
 backends/hostmem-ram.c                     | 2 ++
 backends/rng-egd.c                         | 1 +
 backends/rng-random.c                      | 1 +
 backends/rng.c                             | 1 +
 backends/tpm.c                             | 1 +
 block/blklogwrites.c                       | 1 +
 block/blkreplay.c                          | 2 +-
 block/blkverify.c                          | 1 +
 block/copy-on-read.c                       | 1 +
 block/crypto.c                             | 1 +
 block/curl.c                               | 1 +
 block/gluster.c                            | 1 +
 block/iscsi-opts.c                         | 2 +-
 block/iscsi.c                              | 1 +
 block/nfs.c                                | 1 +
 block/null.c                               | 1 +
 block/nvme.c                               | 1 +
 block/qed.c                                | 1 +
 block/quorum.c                             | 1 +
 block/raw-format.c                         | 1 +
 block/rbd.c                                | 1 +
 block/replication.c                        | 1 +
 block/sheepdog.c                           | 1 +
 block/ssh.c                                | 1 +
 block/throttle.c                           | 1 +
 block/vhdx-log.c                           | 3 +--
 block/vxhs.c                               | 1 +
 block/win32-aio.c                          | 3 +--
 bsd-user/main.c                            | 1 +
 chardev/baum.c                             | 3 ++-
 chardev/char-console.c                     | 2 ++
 chardev/char-fd.c                          | 3 ++-
 chardev/char-file.c                        | 1 +
 chardev/char-mux.c                         | 1 +
 chardev/char-null.c                        | 2 ++
 chardev/char-parallel.c                    | 1 +
 chardev/char-pipe.c                        | 1 +
 chardev/char-pty.c                         | 3 ++-
 chardev/char-ringbuf.c                     | 1 +
 chardev/char-serial.c                      | 1 +
 chardev/char-socket.c                      | 1 +
 chardev/char-stdio.c                       | 1 +
 chardev/char-udp.c                         | 1 +
 chardev/char-win-stdio.c                   | 2 ++
 chardev/char-win.c                         | 3 ++-
 chardev/char.c                             | 1 +
 chardev/msmouse.c                          | 3 ++-
 chardev/spice.c                            | 1 +
 chardev/testdev.c                          | 3 ++-
 chardev/wctablet.c                         | 2 +-
 crypto/secret.c                            | 1 +
 crypto/tlscreds.c                          | 1 +
 crypto/tlscredsanon.c                      | 1 +
 crypto/tlscredspsk.c                       | 1 +
 crypto/tlscredsx509.c                      | 1 +
 fsdev/qemu-fsdev-dummy.c                   | 2 +-
 gdbstub.c                                  | 1 +
 hw/9pfs/virtio-9p-device.c                 | 1 +
 hw/acpi/core.c                             | 1 +
 hw/acpi/vmgenid.c                          | 1 +
 hw/adc/stm32f2xx_adc.c                     | 1 +
 hw/alpha/typhoon.c                         | 1 +
 hw/arm/allwinner-a10.c                     | 2 +-
 hw/arm/armsse.c                            | 1 +
 hw/arm/armv7m.c                            | 2 +-
 hw/arm/aspeed_soc.c                        | 2 +-
 hw/arm/bcm2835_peripherals.c               | 1 +
 hw/arm/bcm2836.c                           | 2 +-
 hw/arm/digic.c                             | 1 +
 hw/arm/fsl-imx6.c                          | 2 +-
 hw/arm/fsl-imx6ul.c                        | 2 +-
 hw/arm/fsl-imx7.c                          | 2 +-
 hw/arm/pxa2xx.c                            | 2 +-
 hw/arm/pxa2xx_gpio.c                       | 1 +
 hw/arm/pxa2xx_pic.c                        | 2 +-
 hw/arm/smmu-common.c                       | 1 +
 hw/arm/stm32f205_soc.c                     | 2 +-
 hw/arm/virt.c                              | 1 +
 hw/arm/xlnx-versal.c                       | 2 +-
 hw/arm/xlnx-zynqmp.c                       | 2 +-
 hw/audio/ac97.c                            | 1 +
 hw/audio/adlib.c                           | 1 +
 hw/audio/cs4231.c                          | 1 +
 hw/audio/cs4231a.c                         | 2 ++
 hw/audio/es1370.c                          | 1 +
 hw/audio/gus.c                             | 2 ++
 hw/audio/hda-codec.c                       | 1 +
 hw/audio/intel-hda.c                       | 1 +
 hw/audio/marvell_88w8618.c                 | 2 ++
 hw/audio/milkymist-ac97.c                  | 1 +
 hw/audio/pcspk.c                           | 1 +
 hw/audio/pl041.c                           | 1 +
 hw/audio/sb16.c                            | 2 ++
 hw/audio/wm8750.c                          | 1 +
 hw/block/fdc.c                             | 1 +
 hw/block/m25p80.c                          | 1 +
 hw/block/nand.c                            | 1 +
 hw/block/nvme.c                            | 1 +
 hw/block/onenand.c                         | 2 +-
 hw/block/pflash_cfi01.c                    | 1 +
 hw/block/pflash_cfi02.c                    | 1 +
 hw/block/virtio-blk.c                      | 2 +-
 hw/block/xen-block.c                       | 1 +
 hw/bt/hci-csr.c                            | 2 +-
 hw/char/bcm2835_aux.c                      | 1 +
 hw/char/cadence_uart.c                     | 1 +
 hw/char/cmsdk-apb-uart.c                   | 1 +
 hw/char/debugcon.c                         | 1 +
 hw/char/digic-uart.c                       | 1 +
 hw/char/escc.c                             | 1 +
 hw/char/etraxfs_ser.c                      | 1 +
 hw/char/exynos4210_uart.c                  | 1 +
 hw/char/grlib_apbuart.c                    | 1 +
 hw/char/imx_serial.c                       | 1 +
 hw/char/ipoctal232.c                       | 1 +
 hw/char/lm32_juart.c                       | 1 +
 hw/char/lm32_uart.c                        | 1 +
 hw/char/mcf_uart.c                         | 2 ++
 hw/char/milkymist-uart.c                   | 1 +
 hw/char/nrf51_uart.c                       | 1 +
 hw/char/parallel.c                         | 2 ++
 hw/char/pl011.c                            | 1 +
 hw/char/sclpconsole-lm.c                   | 1 +
 hw/char/sclpconsole.c                      | 1 +
 hw/char/serial-isa.c                       | 1 +
 hw/char/serial-pci.c                       | 1 +
 hw/char/spapr_vty.c                        | 2 +-
 hw/char/stm32f2xx_usart.c                  | 1 +
 hw/char/terminal3270.c                     | 1 +
 hw/char/virtio-console.c                   | 1 +
 hw/char/virtio-serial-bus.c                | 1 +
 hw/char/xilinx_uartlite.c                  | 1 +
 hw/core/bus.c                              | 1 +
 hw/core/empty_slot.c                       | 1 +
 hw/core/fw-path-provider.c                 | 1 +
 hw/core/generic-loader.c                   | 1 +
 hw/core/nmi.c                              | 1 +
 hw/core/or-irq.c                           | 1 +
 hw/core/platform-bus.c                     | 1 +
 hw/core/register.c                         | 1 +
 hw/core/split-irq.c                        | 1 +
 hw/core/stream.c                           | 1 +
 hw/core/sysbus.c                           | 1 +
 hw/cpu/a15mpcore.c                         | 1 +
 hw/cpu/a9mpcore.c                          | 1 +
 hw/cpu/arm11mpcore.c                       | 1 +
 hw/cpu/core.c                              | 2 ++
 hw/cpu/realview_mpcore.c                   | 1 +
 hw/display/ads7846.c                       | 1 +
 hw/display/ati.c                           | 1 +
 hw/display/bcm2835_fb.c                    | 1 +
 hw/display/bochs-display.c                 | 2 ++
 hw/display/cg3.c                           | 2 +-
 hw/display/cirrus_vga.c                    | 2 ++
 hw/display/cirrus_vga_isa.c                | 1 +
 hw/display/dpcd.c                          | 1 +
 hw/display/exynos4210_fimd.c               | 2 +-
 hw/display/g364fb.c                        | 1 +
 hw/display/i2c-ddc.c                       | 2 +-
 hw/display/jazz_led.c                      | 2 +-
 hw/display/milkymist-tmu2.c                | 1 +
 hw/display/milkymist-vgafb.c               | 1 +
 hw/display/pl110.c                         | 1 +
 hw/display/qxl.c                           | 2 +-
 hw/display/ramfb-standalone.c              | 1 +
 hw/display/sii9022.c                       | 2 +-
 hw/display/sm501.c                         | 2 +-
 hw/display/ssd0303.c                       | 2 ++
 hw/display/ssd0323.c                       | 2 ++
 hw/display/tcx.c                           | 2 +-
 hw/display/vga-isa.c                       | 2 ++
 hw/display/vga-pci.c                       | 2 ++
 hw/display/virtio-gpu-pci.c                | 1 +
 hw/display/virtio-gpu.c                    | 2 +-
 hw/display/virtio-vga.c                    | 1 +
 hw/display/vmware_vga.c                    | 2 ++
 hw/display/xlnx_dp.c                       | 1 +
 hw/dma/bcm2835_dma.c                       | 1 +
 hw/dma/i82374.c                            | 1 +
 hw/dma/i8257.c                             | 2 ++
 hw/dma/pl080.c                             | 1 +
 hw/dma/pl330.c                             | 1 +
 hw/dma/puv3_dma.c                          | 2 ++
 hw/dma/pxa2xx_dma.c                        | 1 +
 hw/dma/rc4030.c                            | 1 +
 hw/dma/sparc32_dma.c                       | 1 +
 hw/dma/xilinx_axidma.c                     | 1 +
 hw/dma/xlnx-zdma.c                         | 1 +
 hw/dma/xlnx-zynq-devcfg.c                  | 1 +
 hw/dma/xlnx_dpdma.c                        | 1 +
 hw/gpio/bcm2835_gpio.c                     | 1 +
 hw/gpio/gpio_key.c                         | 1 +
 hw/gpio/imx_gpio.c                         | 1 +
 hw/gpio/max7310.c                          | 1 +
 hw/gpio/mpc8xxx.c                          | 1 +
 hw/gpio/nrf51_gpio.c                       | 1 +
 hw/gpio/omap_gpio.c                        | 1 +
 hw/gpio/pl061.c                            | 1 +
 hw/gpio/puv3_gpio.c                        | 2 ++
 hw/gpio/zaurus.c                           | 2 ++
 hw/hppa/dino.c                             | 1 +
 hw/hyperv/hyperv.c                         | 1 +
 hw/hyperv/hyperv_testdev.c                 | 1 +
 hw/i2c/aspeed_i2c.c                        | 1 +
 hw/i2c/bitbang_i2c.c                       | 2 ++
 hw/i2c/core.c                              | 1 +
 hw/i2c/exynos4210_i2c.c                    | 1 +
 hw/i2c/imx_i2c.c                           | 1 +
 hw/i2c/microbit_i2c.c                      | 1 +
 hw/i2c/mpc_i2c.c                           | 1 +
 hw/i2c/omap_i2c.c                          | 2 ++
 hw/i2c/ppc4xx_i2c.c                        | 2 +-
 hw/i2c/smbus_ich9.c                        | 2 ++
 hw/i2c/smbus_slave.c                       | 1 +
 hw/i2c/versatile_i2c.c                     | 1 +
 hw/i386/kvm/apic.c                         | 3 ++-
 hw/i386/kvm/clock.c                        | 2 +-
 hw/i386/kvm/i8254.c                        | 1 +
 hw/i386/kvm/i8259.c                        | 2 ++
 hw/i386/kvmvapic.c                         | 3 ++-
 hw/i386/xen/xen_apic.c                     | 2 ++
 hw/i386/xen/xen_platform.c                 | 1 +
 hw/i386/xen/xen_pvdevice.c                 | 1 +
 hw/ide/ahci-allwinner.c                    | 1 +
 hw/ide/ahci.c                              | 1 +
 hw/ide/cmd646.c                            | 2 ++
 hw/ide/ich.c                               | 1 +
 hw/ide/isa.c                               | 2 ++
 hw/ide/macio.c                             | 2 ++
 hw/ide/microdrive.c                        | 2 ++
 hw/ide/mmio.c                              | 2 ++
 hw/ide/pci.c                               | 2 ++
 hw/ide/piix.c                              | 1 +
 hw/ide/qdev.c                              | 2 ++
 hw/ide/sii3112.c                           | 1 +
 hw/ide/via.c                               | 2 ++
 hw/input/adb-kbd.c                         | 2 ++
 hw/input/adb-mouse.c                       | 2 ++
 hw/input/adb.c                             | 2 ++
 hw/input/lm832x.c                          | 1 +
 hw/input/milkymist-softusb.c               | 1 +
 hw/input/pl050.c                           | 1 +
 hw/input/virtio-input-hid.c                | 1 +
 hw/input/virtio-input-host.c               | 2 +-
 hw/input/virtio-input.c                    | 1 +
 hw/intc/allwinner-a10-pic.c                | 1 +
 hw/intc/apic_common.c                      | 3 ++-
 hw/intc/arm_gic.c                          | 1 +
 hw/intc/arm_gic_common.c                   | 1 +
 hw/intc/arm_gic_kvm.c                      | 2 +-
 hw/intc/arm_gicv2m.c                       | 1 +
 hw/intc/arm_gicv3.c                        | 1 +
 hw/intc/arm_gicv3_common.c                 | 1 +
 hw/intc/arm_gicv3_its_common.c             | 1 +
 hw/intc/arm_gicv3_its_kvm.c                | 1 +
 hw/intc/arm_gicv3_kvm.c                    | 1 +
 hw/intc/armv7m_nvic.c                      | 2 +-
 hw/intc/aspeed_vic.c                       | 1 +
 hw/intc/bcm2835_ic.c                       | 1 +
 hw/intc/bcm2836_control.c                  | 1 +
 hw/intc/etraxfs_pic.c                      | 1 +
 hw/intc/exynos4210_combiner.c              | 1 +
 hw/intc/exynos4210_gic.c                   | 2 +-
 hw/intc/grlib_irqmp.c                      | 1 +
 hw/intc/heathrow_pic.c                     | 2 ++
 hw/intc/imx_avic.c                         | 1 +
 hw/intc/imx_gpcv2.c                        | 1 +
 hw/intc/ioapic_common.c                    | 1 +
 hw/intc/lm32_pic.c                         | 1 +
 hw/intc/mips_gic.c                         | 1 +
 hw/intc/nios2_iic.c                        | 2 +-
 hw/intc/omap_intc.c                        | 2 ++
 hw/intc/ompic.c                            | 1 +
 hw/intc/openpic.c                          | 2 ++
 hw/intc/openpic_kvm.c                      | 2 +-
 hw/intc/pl190.c                            | 1 +
 hw/intc/pnv_xive.c                         | 1 +
 hw/intc/puv3_intc.c                        | 2 ++
 hw/intc/realview_gic.c                     | 1 +
 hw/intc/s390_flic.c                        | 1 +
 hw/intc/s390_flic_kvm.c                    | 2 +-
 hw/intc/slavio_intctl.c                    | 1 +
 hw/intc/spapr_xive.c                       | 1 +
 hw/intc/xics.c                             | 2 +-
 hw/intc/xics_pnv.c                         | 1 +
 hw/intc/xilinx_intc.c                      | 1 +
 hw/intc/xive.c                             | 1 +
 hw/intc/xlnx-pmu-iomod-intc.c              | 1 +
 hw/intc/xlnx-zynqmp-ipi.c                  | 1 +
 hw/ipack/ipack.c                           | 1 +
 hw/ipack/tpci200.c                         | 1 +
 hw/ipmi/ipmi.c                             | 1 +
 hw/ipmi/ipmi_bmc_extern.c                  | 1 +
 hw/ipmi/ipmi_bmc_sim.c                     | 1 +
 hw/ipmi/isa_ipmi_bt.c                      | 2 ++
 hw/ipmi/isa_ipmi_kcs.c                     | 2 ++
 hw/isa/isa-bus.c                           | 2 ++
 hw/isa/isa-superio.c                       | 2 ++
 hw/isa/pc87312.c                           | 1 +
 hw/isa/smc37c669-superio.c                 | 1 +
 hw/isa/vt82c686.c                          | 1 +
 hw/m68k/mcf_intc.c                         | 3 ++-
 hw/mem/nvdimm.c                            | 1 +
 hw/mem/pc-dimm.c                           | 1 +
 hw/mips/cps.c                              | 1 +
 hw/misc/a9scu.c                            | 1 +
 hw/misc/applesmc.c                         | 1 +
 hw/misc/arm11scu.c                         | 1 +
 hw/misc/arm_integrator_debug.c             | 1 +
 hw/misc/arm_l2x0.c                         | 1 +
 hw/misc/arm_sysctl.c                       | 1 +
 hw/misc/armsse-cpuid.c                     | 1 +
 hw/misc/armsse-mhu.c                       | 1 +
 hw/misc/aspeed_scu.c                       | 1 +
 hw/misc/aspeed_sdmc.c                      | 1 +
 hw/misc/auxbus.c                           | 1 +
 hw/misc/bcm2835_mbox.c                     | 1 +
 hw/misc/bcm2835_property.c                 | 1 +
 hw/misc/bcm2835_rng.c                      | 1 +
 hw/misc/debugexit.c                        | 1 +
 hw/misc/eccmemctl.c                        | 1 +
 hw/misc/edu.c                              | 1 +
 hw/misc/exynos4210_clk.c                   | 1 +
 hw/misc/exynos4210_pmu.c                   | 1 +
 hw/misc/exynos4210_rng.c                   | 1 +
 hw/misc/imx25_ccm.c                        | 1 +
 hw/misc/imx2_wdt.c                         | 1 +
 hw/misc/imx31_ccm.c                        | 1 +
 hw/misc/imx6_ccm.c                         | 1 +
 hw/misc/imx6_src.c                         | 1 +
 hw/misc/imx6ul_ccm.c                       | 1 +
 hw/misc/imx7_ccm.c                         | 1 +
 hw/misc/imx7_gpr.c                         | 1 +
 hw/misc/imx7_snvs.c                        | 1 +
 hw/misc/imx_ccm.c                          | 1 +
 hw/misc/iotkit-secctl.c                    | 1 +
 hw/misc/iotkit-sysctl.c                    | 1 +
 hw/misc/iotkit-sysinfo.c                   | 1 +
 hw/misc/ivshmem.c                          | 2 ++
 hw/misc/macio/cuda.c                       | 2 ++
 hw/misc/macio/gpio.c                       | 1 +
 hw/misc/macio/mac_dbdma.c                  | 2 ++
 hw/misc/macio/macio.c                      | 2 ++
 hw/misc/macio/pmu.c                        | 1 +
 hw/misc/max111x.c                          | 1 +
 hw/misc/milkymist-hpdmc.c                  | 1 +
 hw/misc/milkymist-pfpu.c                   | 1 +
 hw/misc/mips_cmgcr.c                       | 1 +
 hw/misc/mips_cpc.c                         | 1 +
 hw/misc/mips_itu.c                         | 1 +
 hw/misc/mos6522.c                          | 2 ++
 hw/misc/mps2-fpgaio.c                      | 1 +
 hw/misc/mps2-scc.c                         | 1 +
 hw/misc/msf2-sysreg.c                      | 1 +
 hw/misc/mst_fpga.c                         | 2 ++
 hw/misc/nrf51_rng.c                        | 1 +
 hw/misc/pc-testdev.c                       | 1 +
 hw/misc/pca9552.c                          | 1 +
 hw/misc/pci-testdev.c                      | 2 ++
 hw/misc/puv3_pm.c                          | 2 ++
 hw/misc/pvpanic.c                          | 1 +
 hw/misc/sga.c                              | 2 ++
 hw/misc/slavio_misc.c                      | 1 +
 hw/misc/stm32f2xx_syscfg.c                 | 1 +
 hw/misc/tmp105.c                           | 1 +
 hw/misc/tmp421.c                           | 1 +
 hw/misc/tz-mpc.c                           | 1 +
 hw/misc/tz-msc.c                           | 1 +
 hw/misc/tz-ppc.c                           | 1 +
 hw/misc/unimp.c                            | 1 +
 hw/misc/vmcoreinfo.c                       | 2 ++
 hw/misc/zynq-xadc.c                        | 1 +
 hw/misc/zynq_slcr.c                        | 1 +
 hw/net/allwinner_emac.c                    | 2 ++
 hw/net/cadence_gem.c                       | 1 +
 hw/net/can/can_kvaser_pci.c                | 1 +
 hw/net/can/can_mioe3680_pci.c              | 1 +
 hw/net/can/can_pcm3680_pci.c               | 1 +
 hw/net/dp8393x.c                           | 1 +
 hw/net/e1000.c                             | 1 +
 hw/net/e1000e.c                            | 1 +
 hw/net/eepro100.c                          | 1 +
 hw/net/etraxfs_eth.c                       | 1 +
 hw/net/fsl_etsec/etsec.c                   | 1 +
 hw/net/ftgmac100.c                         | 1 +
 hw/net/imx_fec.c                           | 1 +
 hw/net/lan9118.c                           | 1 +
 hw/net/lance.c                             | 1 +
 hw/net/mcf_fec.c                           | 2 ++
 hw/net/milkymist-minimac2.c                | 2 +-
 hw/net/mipsnet.c                           | 1 +
 hw/net/ne2000-isa.c                        | 2 ++
 hw/net/ne2000.c                            | 2 ++
 hw/net/opencores_eth.c                     | 1 +
 hw/net/pcnet-pci.c                         | 1 +
 hw/net/rocker/rocker.c                     | 1 +
 hw/net/rtl8139.c                           | 2 ++
 hw/net/smc91c111.c                         | 1 +
 hw/net/spapr_llan.c                        | 3 ++-
 hw/net/stellaris_enet.c                    | 2 ++
 hw/net/sungem.c                            | 1 +
 hw/net/sunhme.c                            | 1 +
 hw/net/virtio-net.c                        | 1 +
 hw/net/vmxnet3.c                           | 2 +-
 hw/net/xgmac.c                             | 1 +
 hw/net/xilinx_axienet.c                    | 1 +
 hw/net/xilinx_ethlite.c                    | 2 +-
 hw/nvram/ds1225y.c                         | 1 +
 hw/nvram/eeprom_at24c.c                    | 1 +
 hw/nvram/mac_nvram.c                       | 2 ++
 hw/nvram/nrf51_nvm.c                       | 1 +
 hw/nvram/spapr_nvram.c                     | 2 +-
 hw/pci-bridge/dec.c                        | 1 +
 hw/pci-bridge/gen_pcie_root_port.c         | 1 +
 hw/pci-bridge/i82801b11.c                  | 1 +
 hw/pci-bridge/ioh3420.c                    | 1 +
 hw/pci-bridge/pci_bridge_dev.c             | 1 +
 hw/pci-bridge/pci_expander_bridge.c        | 1 +
 hw/pci-bridge/pcie_pci_bridge.c            | 1 +
 hw/pci-bridge/pcie_root_port.c             | 1 +
 hw/pci-bridge/simba.c                      | 1 +
 hw/pci-bridge/xio3130_downstream.c         | 1 +
 hw/pci-bridge/xio3130_upstream.c           | 1 +
 hw/pci-host/designware.c                   | 1 +
 hw/pci-host/gpex.c                         | 2 ++
 hw/pci-host/grackle.c                      | 1 +
 hw/pci-host/ppce500.c                      | 1 +
 hw/pci-host/q35.c                          | 2 ++
 hw/pci-host/sabre.c                        | 1 +
 hw/pci-host/uninorth.c                     | 2 ++
 hw/pci-host/versatile.c                    | 1 +
 hw/pci-host/xilinx-pcie.c                  | 1 +
 hw/pci/pci_bridge.c                        | 1 +
 hw/pci/pci_host.c                          | 1 +
 hw/pci/pcie_host.c                         | 1 +
 hw/pci/pcie_port.c                         | 1 +
 hw/pcmcia/pcmcia.c                         | 2 +-
 hw/pcmcia/pxa2xx.c                         | 1 +
 hw/ppc/mpc8544_guts.c                      | 2 +-
 hw/ppc/pnv_core.c                          | 2 ++
 hw/ppc/pnv_lpc.c                           | 1 +
 hw/ppc/pnv_occ.c                           | 1 +
 hw/ppc/pnv_psi.c                           | 1 +
 hw/ppc/pnv_xscom.c                         | 2 ++
 hw/ppc/ppc440_pcix.c                       | 1 +
 hw/ppc/ppc440_uc.c                         | 2 +-
 hw/ppc/ppc4xx_pci.c                        | 1 +
 hw/ppc/ppce500_spin.c                      | 1 +
 hw/ppc/prep_systemio.c                     | 1 +
 hw/ppc/spapr_hcall.c                       | 1 +
 hw/ppc/spapr_iommu.c                       | 2 ++
 hw/ppc/spapr_pci.c                         | 3 ++-
 hw/ppc/spapr_rng.c                         | 2 +-
 hw/ppc/spapr_rtas_ddw.c                    | 1 +
 hw/ppc/spapr_rtc.c                         | 1 +
 hw/rdma/vmw/pvrdma_main.c                  | 1 +
 hw/riscv/riscv_hart.c                      | 1 +
 hw/riscv/sifive_clint.c                    | 1 +
 hw/riscv/sifive_plic.c                     | 1 +
 hw/riscv/sifive_prci.c                     | 1 +
 hw/riscv/sifive_test.c                     | 1 +
 hw/s390x/ap-bridge.c                       | 2 ++
 hw/s390x/ccw-device.c                      | 2 ++
 hw/s390x/css-bridge.c                      | 2 ++
 hw/s390x/event-facility.c                  | 1 +
 hw/s390x/s390-ccw.c                        | 1 +
 hw/s390x/s390-pci-bus.c                    | 2 +-
 hw/s390x/s390-skeys-kvm.c                  | 1 +
 hw/s390x/sclpcpu.c                         | 2 ++
 hw/s390x/sclpquiesce.c                     | 2 ++
 hw/s390x/tod-kvm.c                         | 1 +
 hw/s390x/tod-qemu.c                        | 1 +
 hw/s390x/tod.c                             | 1 +
 hw/s390x/vhost-vsock-ccw.c                 | 1 +
 hw/s390x/virtio-ccw-9p.c                   | 1 +
 hw/s390x/virtio-ccw-balloon.c              | 1 +
 hw/s390x/virtio-ccw-blk.c                  | 1 +
 hw/s390x/virtio-ccw-crypto.c               | 1 +
 hw/s390x/virtio-ccw-gpu.c                  | 1 +
 hw/s390x/virtio-ccw-input.c                | 1 +
 hw/s390x/virtio-ccw-net.c                  | 1 +
 hw/s390x/virtio-ccw-rng.c                  | 1 +
 hw/s390x/virtio-ccw-scsi.c                 | 1 +
 hw/s390x/virtio-ccw-serial.c               | 1 +
 hw/s390x/virtio-ccw.c                      | 1 +
 hw/scsi/esp-pci.c                          | 1 +
 hw/scsi/esp.c                              | 1 +
 hw/scsi/lsi53c895a.c                       | 1 +
 hw/scsi/megasas.c                          | 1 +
 hw/scsi/mptsas.c                           | 1 +
 hw/scsi/scsi-bus.c                         | 1 +
 hw/scsi/scsi-disk.c                        | 1 +
 hw/scsi/scsi-generic.c                     | 1 +
 hw/scsi/spapr_vscsi.c                      | 3 ++-
 hw/scsi/vhost-scsi-common.c                | 1 +
 hw/scsi/vhost-scsi.c                       | 1 +
 hw/scsi/virtio-scsi.c                      | 1 +
 hw/scsi/vmw_pvscsi.c                       | 1 +
 hw/sd/bcm2835_sdhost.c                     | 1 +
 hw/sd/core.c                               | 1 +
 hw/sd/milkymist-memcard.c                  | 1 +
 hw/sd/pl181.c                              | 1 +
 hw/sd/pxa2xx_mmci.c                        | 1 +
 hw/sd/sd.c                                 | 1 +
 hw/sd/sdhci-pci.c                          | 1 +
 hw/sd/sdhci.c                              | 1 +
 hw/sd/ssi-sd.c                             | 1 +
 hw/sh4/sh_pci.c                            | 2 ++
 hw/smbios/smbios.c                         | 1 +
 hw/sparc/sun4m_iommu.c                     | 1 +
 hw/sparc64/sun4u_iommu.c                   | 1 +
 hw/ssi/aspeed_smc.c                        | 1 +
 hw/ssi/imx_spi.c                           | 1 +
 hw/ssi/mss-spi.c                           | 1 +
 hw/ssi/pl022.c                             | 1 +
 hw/ssi/ssi.c                               | 1 +
 hw/ssi/stm32f2xx_spi.c                     | 1 +
 hw/ssi/xilinx_spi.c                        | 1 +
 hw/ssi/xilinx_spips.c                      | 1 +
 hw/timer/a9gtimer.c                        | 1 +
 hw/timer/allwinner-a10-pit.c               | 1 +
 hw/timer/altera_timer.c                    | 2 +-
 hw/timer/arm_mptimer.c                     | 1 +
 hw/timer/arm_timer.c                       | 2 +-
 hw/timer/armv7m_systick.c                  | 2 +-
 hw/timer/aspeed_timer.c                    | 2 +-
 hw/timer/cadence_ttc.c                     | 1 +
 hw/timer/cmsdk-apb-dualtimer.c             | 1 +
 hw/timer/cmsdk-apb-timer.c                 | 1 +
 hw/timer/digic-timer.c                     | 1 +
 hw/timer/ds1338.c                          | 1 +
 hw/timer/etraxfs_timer.c                   | 2 ++
 hw/timer/exynos4210_mct.c                  | 2 +-
 hw/timer/exynos4210_pwm.c                  | 2 +-
 hw/timer/exynos4210_rtc.c                  | 2 +-
 hw/timer/grlib_gptimer.c                   | 1 +
 hw/timer/i8254.c                           | 2 ++
 hw/timer/i8254_common.c                    | 2 ++
 hw/timer/imx_epit.c                        | 1 +
 hw/timer/imx_gpt.c                         | 1 +
 hw/timer/lm32_timer.c                      | 1 +
 hw/timer/m41t80.c                          | 1 +
 hw/timer/m48t59-isa.c                      | 2 ++
 hw/timer/m48t59.c                          | 2 ++
 hw/timer/mc146818rtc.c                     | 1 +
 hw/timer/milkymist-sysctl.c                | 1 +
 hw/timer/mss-timer.c                       | 1 +
 hw/timer/nrf51_timer.c                     | 1 +
 hw/timer/pl031.c                           | 1 +
 hw/timer/puv3_ost.c                        | 2 ++
 hw/timer/pxa2xx_timer.c                    | 1 +
 hw/timer/slavio_timer.c                    | 1 +
 hw/timer/stm32f2xx_timer.c                 | 1 +
 hw/timer/sun4v-rtc.c                       | 1 +
 hw/timer/twl92230.c                        | 1 +
 hw/timer/xilinx_timer.c                    | 1 +
 hw/timer/xlnx-zynqmp-rtc.c                 | 1 +
 hw/tpm/tpm_crb.c                           | 2 +-
 hw/tpm/tpm_emulator.c                      | 1 +
 hw/tpm/tpm_passthrough.c                   | 2 +-
 hw/tpm/tpm_tis.c                           | 1 +
 hw/usb/bus.c                               | 1 +
 hw/usb/ccid-card-emulated.c                | 1 +
 hw/usb/ccid-card-passthru.c                | 1 +
 hw/usb/chipidea.c                          | 1 +
 hw/usb/dev-audio.c                         | 2 +-
 hw/usb/dev-bluetooth.c                     | 2 +-
 hw/usb/dev-hid.c                           | 2 ++
 hw/usb/dev-hub.c                           | 3 ++-
 hw/usb/dev-mtp.c                           | 2 +-
 hw/usb/dev-network.c                       | 2 +-
 hw/usb/dev-serial.c                        | 2 +-
 hw/usb/dev-smartcard-reader.c              | 1 +
 hw/usb/dev-storage.c                       | 2 +-
 hw/usb/dev-uas.c                           | 2 +-
 hw/usb/dev-wacom.c                         | 2 ++
 hw/usb/hcd-ehci-pci.c                      | 1 +
 hw/usb/hcd-ehci-sysbus.c                   | 1 +
 hw/usb/hcd-ohci.c                          | 1 +
 hw/usb/hcd-uhci.c                          | 2 ++
 hw/usb/hcd-xhci-nec.c                      | 1 +
 hw/usb/hcd-xhci.c                          | 2 ++
 hw/usb/host-libusb.c                       | 2 +-
 hw/usb/redirect.c                          | 2 +-
 hw/usb/tusb6010.c                          | 3 ++-
 hw/vfio/amd-xgbe.c                         | 1 +
 hw/vfio/ap.c                               | 1 +
 hw/vfio/calxeda-xgmac.c                    | 1 +
 hw/vfio/ccw.c                              | 1 +
 hw/vfio/pci-quirks.c                       | 1 +
 hw/vfio/pci.c                              | 1 +
 hw/vfio/platform.c                         | 1 +
 hw/virtio/vhost-scsi-pci.c                 | 1 +
 hw/virtio/vhost-user-blk-pci.c             | 1 +
 hw/virtio/vhost-user-scsi-pci.c            | 1 +
 hw/virtio/vhost-vsock-pci.c                | 1 +
 hw/virtio/vhost-vsock.c                    | 1 +
 hw/virtio/virtio-9p-pci.c                  | 1 +
 hw/virtio/virtio-balloon-pci.c             | 1 +
 hw/virtio/virtio-balloon.c                 | 2 +-
 hw/virtio/virtio-blk-pci.c                 | 1 +
 hw/virtio/virtio-bus.c                     | 1 +
 hw/virtio/virtio-crypto-pci.c              | 2 ++
 hw/virtio/virtio-crypto.c                  | 2 ++
 hw/virtio/virtio-input-host-pci.c          | 1 +
 hw/virtio/virtio-input-pci.c               | 1 +
 hw/virtio/virtio-mmio.c                    | 1 +
 hw/virtio/virtio-net-pci.c                 | 1 +
 hw/virtio/virtio-pci.c                     | 1 +
 hw/virtio/virtio-rng-pci.c                 | 1 +
 hw/virtio/virtio-rng.c                     | 1 +
 hw/virtio/virtio-scsi-pci.c                | 1 +
 hw/virtio/virtio-serial-pci.c              | 1 +
 hw/virtio/virtio.c                         | 2 +-
 hw/watchdog/cmsdk-apb-watchdog.c           | 1 +
 hw/watchdog/wdt_aspeed.c                   | 1 +
 hw/watchdog/wdt_diag288.c                  | 1 +
 hw/watchdog/wdt_i6300esb.c                 | 2 +-
 hw/watchdog/wdt_ib700.c                    | 2 +-
 hw/xen/xen-bus.c                           | 1 +
 hw/xen/xen-common.c                        | 1 +
 include/hw/boards.h                        | 1 +
 include/hw/hw.h                            | 1 -
 include/hw/i386/pc.h                       | 2 +-
 include/qemu-common.h                      | 2 --
 include/qom/object.h                       | 1 +
 io/channel-buffer.c                        | 1 +
 io/channel-command.c                       | 1 +
 io/channel-file.c                          | 1 +
 io/channel-socket.c                        | 1 +
 io/channel-tls.c                           | 1 +
 io/channel-websock.c                       | 1 +
 io/channel.c                               | 1 +
 io/dns-resolver.c                          | 1 +
 io/net-listener.c                          | 1 +
 linux-user/main.c                          | 1 +
 migration/rdma.c                           | 3 ++-
 net/can/can_core.c                         | 2 ++
 net/can/can_host.c                         | 2 ++
 net/can/can_socketcan.c                    | 2 ++
 net/dump.c                                 | 2 +-
 net/filter-replay.c                        | 2 +-
 net/filter.c                               | 2 +-
 qemu-img.c                                 | 1 +
 qemu-io.c                                  | 1 +
 qemu-nbd.c                                 | 2 +-
 qga/main.c                                 | 1 -
 qtest.c                                    | 2 +-
 replication.h                              | 1 +
 scripts/qapi/commands.py                   | 2 --
 scsi/pr-manager-helper.c                   | 1 +
 scsi/pr-manager.c                          | 1 +
 scsi/qemu-pr-helper.c                      | 2 +-
 target/arm/cpu.c                           | 1 +
 target/arm/cpu64.c                         | 2 +-
 target/hppa/cpu.c                          | 2 +-
 target/i386/cpu.c                          | 1 +
 target/i386/sev.c                          | 1 +
 target/microblaze/cpu.c                    | 2 +-
 target/mips/cpu.c                          | 2 +-
 target/nios2/cpu.c                         | 2 +-
 target/ppc/cpu-models.c                    | 1 +
 target/ppc/translate_init.inc.c            | 1 +
 target/s390x/cpu.c                         | 1 +
 target/s390x/cpu_models.c                  | 1 +
 target/sparc/cpu.c                         | 1 +
 target/tilegx/cpu.c                        | 2 +-
 target/xtensa/cpu.c                        | 2 +-
 tests/ac97-test.c                          | 1 +
 tests/e1000-test.c                         | 1 +
 tests/e1000e-test.c                        | 1 +
 tests/eepro100-test.c                      | 1 +
 tests/es1370-test.c                        | 1 +
 tests/ipoctal232-test.c                    | 1 +
 tests/libqos/aarch64-xlnx-zcu102-machine.c | 1 +
 tests/libqos/arm-raspi2-machine.c          | 1 +
 tests/libqos/arm-sabrelite-machine.c       | 1 +
 tests/libqos/arm-smdkc210-machine.c        | 1 +
 tests/libqos/arm-virt-machine.c            | 1 +
 tests/libqos/arm-xilinx-zynq-a9-machine.c  | 1 +
 tests/libqos/e1000e.c                      | 2 +-
 tests/libqos/pci-pc.c                      | 2 +-
 tests/libqos/pci-spapr.c                   | 2 +-
 tests/libqos/ppc64_pseries-machine.c       | 3 ++-
 tests/libqos/sdhci.c                       | 1 +
 tests/libqos/tpci200.c                     | 1 +
 tests/libqos/virtio-9p.c                   | 1 +
 tests/libqos/virtio-balloon.c              | 1 +
 tests/libqos/virtio-blk.c                  | 1 +
 tests/libqos/virtio-mmio.c                 | 1 +
 tests/libqos/virtio-net.c                  | 1 +
 tests/libqos/virtio-rng.c                  | 1 +
 tests/libqos/virtio-scsi.c                 | 1 +
 tests/libqos/virtio-serial.c               | 1 +
 tests/libqos/x86_64_pc-machine.c           | 1 +
 tests/megasas-test.c                       | 1 +
 tests/migration-test.c                     | 1 +
 tests/ne2000-test.c                        | 1 +
 tests/nvme-test.c                          | 1 +
 tests/pci-test.c                           | 1 +
 tests/pcnet-test.c                         | 1 +
 tests/qos-test.c                           | 1 +
 tests/sdhci-test.c                         | 2 ++
 tests/spapr-phb-test.c                     | 1 +
 tests/test-authz-list.c                    | 1 +
 tests/test-authz-listfile.c                | 1 +
 tests/test-authz-pam.c                     | 1 +
 tests/test-authz-simple.c                  | 1 +
 tests/test-char.c                          | 1 +
 tests/test-crypto-block.c                  | 1 +
 tests/test-crypto-tlscredsx509.c           | 1 +
 tests/test-crypto-tlssession.c             | 1 +
 tests/test-io-channel-buffer.c             | 1 +
 tests/test-io-channel-command.c            | 1 +
 tests/test-io-channel-file.c               | 1 +
 tests/test-io-channel-socket.c             | 1 +
 tests/test-io-channel-tls.c                | 1 +
 tests/test-io-task.c                       | 1 +
 tests/test-qmp-cmds.c                      | 2 --
 tests/test-throttle.c                      | 1 +
 tests/test-vmstate.c                       | 2 +-
 tests/tpm-crb-swtpm-test.c                 | 1 +
 tests/tpm-crb-test.c                       | 1 +
 tests/tpm-tis-swtpm-test.c                 | 1 +
 tests/tpm-tis-test.c                       | 1 +
 tests/usb-hcd-ohci-test.c                  | 1 +
 tests/vhost-user-test.c                    | 1 +
 tests/virtio-9p-test.c                     | 1 +
 tests/virtio-blk-test.c                    | 1 +
 tests/virtio-net-test.c                    | 1 +
 tests/virtio-rng-test.c                    | 1 +
 tests/virtio-scsi-test.c                   | 1 +
 tests/virtio-serial-test.c                 | 1 +
 tests/virtio-test.c                        | 1 +
 tests/vmxnet3-test.c                       | 1 +
 ui/cocoa.m                                 | 2 +-
 ui/console.c                               | 1 +
 ui/curses.c                                | 3 ++-
 ui/egl-headless.c                          | 2 +-
 ui/input-linux.c                           | 2 +-
 ui/sdl2.c                                  | 2 +-
 ui/spice-app.c                             | 3 ++-
 ui/spice-core.c                            | 1 +
 ui/vnc.c                                   | 1 +
 761 files changed, 875 insertions(+), 132 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 49e6884309..3745c823ad 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -21,10 +21,11 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include <alsa/asoundlib.h>
-#include "qemu-common.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 #include "audio.h"
 #include "trace.h"
 
diff --git a/audio/audio.c b/audio/audio.c
index 2040762fef..05adf7ffeb 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -21,6 +21,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "audio.h"
@@ -31,6 +32,7 @@
 #include "qapi/qapi-visit-audio.h"
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
+#include "qemu/module.h"
 #include "sysemu/replay.h"
 #include "trace.h"
 
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index 1ee43b7d5f..4bec6c8c5c 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -26,7 +26,7 @@
 #include <CoreAudio/CoreAudio.h>
 #include <pthread.h>            /* pthread_X */
 
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "audio.h"
 
 #define AUDIO_CAP "coreaudio"
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index a7d04b5033..5da4c864c3 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -27,12 +27,12 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "audio.h"
 
 #define AUDIO_CAP "dsound"
 #include "audio_int.h"
 #include "qemu/host-utils.h"
+#include "qemu/module.h"
 
 #include <windows.h>
 #include <mmsystem.h>
diff --git a/audio/noaudio.c b/audio/noaudio.c
index ccc611fc84..9b195dc52c 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -21,9 +21,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/host-utils.h"
+#include "qemu/module.h"
 #include "audio.h"
 #include "qemu/timer.h"
 
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index fc28981a39..c0af065b6f 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -21,11 +21,12 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 #include <sys/soundcard.h>
-#include "qemu-common.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 #include "qemu/host-utils.h"
 #include "audio.h"
 #include "trace.h"
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 45295b4e5e..fa9dd9efd4 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -1,6 +1,7 @@
 /* public domain */
+
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "audio.h"
 #include "qapi/opts-visitor.h"
 
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index ff9248ba68..e7179ff1d4 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -21,10 +21,11 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include <SDL.h>
 #include <SDL_thread.h>
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "audio.h"
 
 #ifndef _WIN32
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 4f7873af5a..0ead5ae43a 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "qemu/host-utils.h"
+#include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "ui/qemu-spice.h"
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 8d30f57296..803b6cb1f3 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -21,8 +21,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "qapi/opts-visitor.h"
 #include "audio.h"
diff --git a/authz/base.c b/authz/base.c
index baf39fff25..c75bce3fd1 100644
--- a/authz/base.c
+++ b/authz/base.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "authz/base.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 bool qauthz_is_allowed(QAuthZ *authz,
diff --git a/authz/list.c b/authz/list.c
index 831da936fe..5a48074d0a 100644
--- a/authz/list.c
+++ b/authz/list.c
@@ -23,6 +23,7 @@
 #include "trace.h"
 #include "qom/object_interfaces.h"
 #include "qapi/qapi-visit-authz.h"
+#include "qemu/module.h"
 
 static bool qauthz_list_is_allowed(QAuthZ *authz,
                                    const char *identity,
diff --git a/authz/listfile.c b/authz/listfile.c
index d74bbd1048..e7a8c19bcb 100644
--- a/authz/listfile.c
+++ b/authz/listfile.c
@@ -23,6 +23,7 @@
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 #include "qemu/sockets.h"
 #include "qemu/filemonitor.h"
 #include "qom/object_interfaces.h"
diff --git a/authz/pamacct.c b/authz/pamacct.c
index 7539867923..a8ad25b6c7 100644
--- a/authz/pamacct.c
+++ b/authz/pamacct.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "authz/pamacct.h"
 #include "trace.h"
+#include "qemu/module.h"
 #include "qom/object_interfaces.h"
 
 #include <security/pam_appl.h>
diff --git a/authz/simple.c b/authz/simple.c
index c409ce7efc..008912d247 100644
--- a/authz/simple.c
+++ b/authz/simple.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "authz/simple.h"
 #include "trace.h"
+#include "qemu/module.h"
 #include "qom/object_interfaces.h"
 
 static bool qauthz_simple_is_allowed(QAuthZ *authz,
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 37ac6445d2..29e55c9195 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -9,10 +9,11 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "sysemu/hostmem.h"
 #include "sysemu/sysemu.h"
 #include "qom/object_interfaces.h"
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 46b15b916a..26070b425e 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -9,12 +9,13 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
+
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "sysemu/hostmem.h"
 #include "sysemu/sysemu.h"
 #include "qom/object_interfaces.h"
 #include "qemu/memfd.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 
 #define TYPE_MEMORY_BACKEND_MEMFD "memory-backend-memfd"
diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
index 24b65d9ae3..6aab8d3a73 100644
--- a/backends/hostmem-ram.c
+++ b/backends/hostmem-ram.c
@@ -9,9 +9,11 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
+
 #include "qemu/osdep.h"
 #include "sysemu/hostmem.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "qom/object_interfaces.h"
 
 #define TYPE_MEMORY_BACKEND_RAM "memory-backend-ram"
diff --git a/backends/rng-egd.c b/backends/rng-egd.c
index d2b9ce6cbf..e380519408 100644
--- a/backends/rng-egd.c
+++ b/backends/rng-egd.c
@@ -15,6 +15,7 @@
 #include "chardev/char-fe.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
+#include "qemu/module.h"
 
 #define TYPE_RNG_EGD "rng-egd"
 #define RNG_EGD(obj) OBJECT_CHECK(RngEgd, (obj), TYPE_RNG_EGD)
diff --git a/backends/rng-random.c b/backends/rng-random.c
index e2a49b0571..aa5b9285f0 100644
--- a/backends/rng-random.c
+++ b/backends/rng-random.c
@@ -16,6 +16,7 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 
 struct RngRandom
 {
diff --git a/backends/rng.c b/backends/rng.c
index 398ebe4a7d..391888b8b3 100644
--- a/backends/rng.c
+++ b/backends/rng.c
@@ -14,6 +14,7 @@
 #include "sysemu/rng.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
+#include "qemu/module.h"
 #include "qom/object_interfaces.h"
 
 void rng_backend_request_entropy(RngBackend *s, size_t size,
diff --git a/backends/tpm.c b/backends/tpm.c
index a00438b904..375587e743 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -18,6 +18,7 @@
 #include "sysemu/tpm.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 #include "block/thread-pool.h"
 #include "qemu/error-report.h"
 
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index eb2b4901a5..04d8b33607 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -16,6 +16,7 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/cutils.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 
 /* Disk format stuff - taken from Linux drivers/md/dm-log-writes.c */
diff --git a/block/blkreplay.c b/block/blkreplay.c
index b5d9efdeca..2b7931b940 100644
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -10,7 +10,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "block/block_int.h"
 #include "sysemu/replay.h"
 #include "qapi/error.h"
diff --git a/block/blkverify.c b/block/blkverify.c
index 3ff77ff49a..304b0a1368 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -14,6 +14,7 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/cutils.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 
 typedef struct {
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index 53972b1da3..22f24fd0db 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -22,6 +22,7 @@
 
 #include "qemu/osdep.h"
 #include "block/block_int.h"
+#include "qemu/module.h"
 
 
 static int cor_open(BlockDriverState *bs, QDict *options, int flags,
diff --git a/block/crypto.c b/block/crypto.c
index 3af46b805f..be12da2532 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -28,6 +28,7 @@
 #include "qapi/qapi-visit-crypto.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "crypto.h"
 
diff --git a/block/curl.c b/block/curl.c
index 606709fea4..d4c8e94f3e 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "block/block_int.h"
 #include "qapi/qmp/qdict.h"
diff --git a/block/gluster.c b/block/gluster.c
index e664ca4462..dc16f0c329 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -18,6 +18,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qemu/uri.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/cutils.h"
 
diff --git a/block/iscsi-opts.c b/block/iscsi-opts.c
index 9b19bd2f52..afaf8837d6 100644
--- a/block/iscsi-opts.c
+++ b/block/iscsi-opts.c
@@ -23,8 +23,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/config-file.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 
 static QemuOptsList qemu_iscsi_opts = {
diff --git a/block/iscsi.c b/block/iscsi.c
index f31c612d53..cf9d66c07f 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -36,6 +36,7 @@
 #include "block/qdict.h"
 #include "scsi/constants.h"
 #include "qemu/iov.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/uuid.h"
 #include "qapi/error.h"
diff --git a/block/nfs.c b/block/nfs.c
index 531903610b..d93241b3bb 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -32,6 +32,7 @@
 #include "block/qdict.h"
 #include "trace.h"
 #include "qemu/iov.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/uri.h"
 #include "qemu/cutils.h"
diff --git a/block/null.c b/block/null.c
index a322929478..699aa295cb 100644
--- a/block/null.c
+++ b/block/null.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "block/block_int.h"
 
diff --git a/block/nvme.c b/block/nvme.c
index 0684bbd077..73ed5fa75f 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -17,6 +17,7 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qemu/cutils.h"
 #include "qemu/option.h"
 #include "qemu/vfio-helpers.h"
diff --git a/block/qed.c b/block/qed.c
index dcdcd62b4a..e15796b730 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -17,6 +17,7 @@
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "qemu/bswap.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "trace.h"
 #include "qed.h"
diff --git a/block/quorum.c b/block/quorum.c
index 352f729136..ef92d7f63b 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -15,6 +15,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "block/block_int.h"
 #include "block/qdict.h"
diff --git a/block/raw-format.c b/block/raw-format.c
index 385cdc2490..bffd424dd0 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -29,6 +29,7 @@
 #include "qemu/osdep.h"
 #include "block/block_int.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 
 typedef struct BDRVRawState {
diff --git a/block/rbd.c b/block/rbd.c
index 0c549c9935..f2ac2c06f4 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -16,6 +16,7 @@
 #include <rbd/librbd.h>
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "block/block_int.h"
 #include "block/qdict.h"
diff --git a/block/replication.c b/block/replication.c
index 3d4dedddfc..5cffb790b3 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -13,6 +13,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "block/nbd.h"
 #include "block/blockjob.h"
diff --git a/block/sheepdog.c b/block/sheepdog.c
index cbdfe9ab6e..961fe3499a 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -21,6 +21,7 @@
 #include "qapi/qobject-output-visitor.h"
 #include "qemu/uri.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/sockets.h"
 #include "block/block_int.h"
diff --git a/block/ssh.c b/block/ssh.c
index 584c302fe6..6da7b9cbfe 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -31,6 +31,7 @@
 #include "block/qdict.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
diff --git a/block/throttle.c b/block/throttle.c
index f64dcc27b9..0349f42257 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "block/throttle-groups.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/throttle-options.h"
 #include "qapi/error.h"
diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index 5e946846f1..fdd3a7adc3 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -17,12 +17,11 @@
  * See the COPYING.LIB file in the top-level directory.
  *
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "block/block_int.h"
 #include "qemu/error-report.h"
-#include "qemu/module.h"
 #include "qemu/bswap.h"
 #include "vhdx.h"
 
diff --git a/block/vxhs.c b/block/vxhs.c
index 2e18229ba4..77fd5eb20d 100644
--- a/block/vxhs.c
+++ b/block/vxhs.c
@@ -17,6 +17,7 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "trace.h"
+#include "qemu/module.h"
 #include "qemu/uri.h"
 #include "qapi/error.h"
 #include "qemu/uuid.h"
diff --git a/block/win32-aio.c b/block/win32-aio.c
index 9cd355d42f..b7221a272f 100644
--- a/block/win32-aio.c
+++ b/block/win32-aio.c
@@ -21,11 +21,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/timer.h"
 #include "block/block_int.h"
-#include "qemu/module.h"
 #include "block/aio.h"
 #include "block/raw-aio.h"
 #include "qemu/event_notifier.h"
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 5ec6f90af9..d48e2618c8 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -29,6 +29,7 @@
 #include "qemu/error-report.h"
 #include "qemu/path.h"
 #include "qemu/help_option.h"
+#include "qemu/module.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "tcg.h"
diff --git a/chardev/baum.c b/chardev/baum.c
index 78b0c87625..3dc81d5c6c 100644
--- a/chardev/baum.c
+++ b/chardev/baum.c
@@ -21,10 +21,11 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "chardev/char.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/usb.h"
 #include "ui/console.h"
diff --git a/chardev/char-console.c b/chardev/char-console.c
index 535ed65136..6c4ce5dbce 100644
--- a/chardev/char-console.c
+++ b/chardev/char-console.c
@@ -21,8 +21,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "chardev/char-win.h"
+#include "qemu/module.h"
 
 static void qemu_chr_open_win_con(Chardev *chr,
                                   ChardevBackend *backend,
diff --git a/chardev/char-fd.c b/chardev/char-fd.c
index 2c9b2ce567..32092369bf 100644
--- a/chardev/char-fd.c
+++ b/chardev/char-fd.c
@@ -21,10 +21,11 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
+#include "qemu/module.h"
 #include "qemu/sockets.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "chardev/char.h"
 #include "io/channel-file.h"
 
diff --git a/chardev/char-file.c b/chardev/char-file.c
index 87fb61088c..2fd80707e5 100644
--- a/chardev/char-file.c
+++ b/chardev/char-file.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "chardev/char.h"
 
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 23aa82125d..200c62a0d0 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "chardev/char.h"
 #include "sysemu/block-backend.h"
diff --git a/chardev/char-null.c b/chardev/char-null.c
index 90bafe76f4..1c6a2900f9 100644
--- a/chardev/char-null.c
+++ b/chardev/char-null.c
@@ -21,8 +21,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "chardev/char.h"
+#include "qemu/module.h"
 
 static void null_chr_open(Chardev *chr,
                           ChardevBackend *backend,
diff --git a/chardev/char-parallel.c b/chardev/char-parallel.c
index ab82c72ac7..05e7efbd6c 100644
--- a/chardev/char-parallel.c
+++ b/chardev/char-parallel.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "chardev/char.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include <sys/ioctl.h>
 
diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
index 8a51872e5e..cdaddb1e61 100644
--- a/chardev/char-pipe.c
+++ b/chardev/char-pipe.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "chardev/char.h"
 
diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 04759b0ef9..8b34ce985a 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -21,13 +21,14 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "chardev/char.h"
 #include "io/channel-file.h"
 #include "qemu/sockets.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qemu/qemu-print.h"
 
 #include "chardev/char-io.h"
diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c
index 87832e2792..67397a8ce9 100644
--- a/chardev/char-ringbuf.c
+++ b/chardev/char-ringbuf.c
@@ -27,6 +27,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-char.h"
 #include "qemu/base64.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 
 /* Ring buffer chardev */
diff --git a/chardev/char-serial.c b/chardev/char-serial.c
index a8bae31b8d..5b833ea077 100644
--- a/chardev/char-serial.c
+++ b/chardev/char-serial.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/sockets.h"
 #include "io/channel-file.h"
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index b2cf593107..7ca5d97af3 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -29,6 +29,7 @@
 #include "io/channel-websock.h"
 #include "io/net-listener.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index 9624220e6d..82eaebc1db 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/sockets.h"
 #include "qapi/error.h"
diff --git a/chardev/char-udp.c b/chardev/char-udp.c
index 097a2f0f42..bba4145f96 100644
--- a/chardev/char-udp.c
+++ b/chardev/char-udp.c
@@ -26,6 +26,7 @@
 #include "chardev/char.h"
 #include "io/channel-socket.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 
 #include "chardev/char-io.h"
diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
index efcf7827eb..92d34e85aa 100644
--- a/chardev/char-win-stdio.c
+++ b/chardev/char-win-stdio.c
@@ -21,8 +21,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "chardev/char-win.h"
 #include "chardev/char-win-stdio.h"
 
diff --git a/chardev/char-win.c b/chardev/char-win.c
index 05518e0958..0b8181339d 100644
--- a/chardev/char-win.c
+++ b/chardev/char-win.c
@@ -21,8 +21,9 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "chardev/char-win.h"
 
diff --git a/chardev/char.c b/chardev/char.c
index 54724a56b1..e4887bcc82 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -35,6 +35,7 @@
 #include "qapi/qmp/qerror.h"
 #include "sysemu/replay.h"
 #include "qemu/help_option.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 
 #include "chardev/char-mux.h"
diff --git a/chardev/msmouse.c b/chardev/msmouse.c
index 0ffd137ce8..6d8f06fed4 100644
--- a/chardev/msmouse.c
+++ b/chardev/msmouse.c
@@ -21,8 +21,9 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "chardev/char.h"
 #include "ui/console.h"
 #include "ui/input.h"
diff --git a/chardev/spice.c b/chardev/spice.c
index 22c30ae833..241e2b7770 100644
--- a/chardev/spice.c
+++ b/chardev/spice.c
@@ -5,6 +5,7 @@
 #include "chardev/spice.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include <spice/protocol.h>
 
diff --git a/chardev/testdev.c b/chardev/testdev.c
index 031e9a23e8..368a8c041e 100644
--- a/chardev/testdev.c
+++ b/chardev/testdev.c
@@ -23,8 +23,9 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "chardev/char.h"
 
 #define BUF_SIZE 32
diff --git a/chardev/wctablet.c b/chardev/wctablet.c
index 35dbd29a33..e9cb7ca710 100644
--- a/chardev/wctablet.c
+++ b/chardev/wctablet.c
@@ -27,7 +27,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "chardev/char-serial.h"
 #include "ui/console.h"
 #include "ui/input.h"
diff --git a/crypto/secret.c b/crypto/secret.c
index 388abd7df5..30294b3229 100644
--- a/crypto/secret.c
+++ b/crypto/secret.c
@@ -24,6 +24,7 @@
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
 #include "qemu/base64.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 
diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
index 02255a6f3c..50ecb704ee 100644
--- a/crypto/tlscreds.c
+++ b/crypto/tlscreds.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "tlscredspriv.h"
 #include "trace.h"
 
diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
index 7ad66d1e7d..3024b17cfd 100644
--- a/crypto/tlscredsanon.c
+++ b/crypto/tlscredsanon.c
@@ -22,6 +22,7 @@
 #include "crypto/tlscredsanon.h"
 #include "tlscredspriv.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "qom/object_interfaces.h"
 #include "trace.h"
 
diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c
index 7be7c8efdd..9c53c6c7b1 100644
--- a/crypto/tlscredspsk.c
+++ b/crypto/tlscredspsk.c
@@ -22,6 +22,7 @@
 #include "crypto/tlscredspsk.h"
 #include "tlscredspriv.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "qom/object_interfaces.h"
 #include "trace.h"
 
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index d6ab4a9862..5247dd3b18 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -23,6 +23,7 @@
 #include "tlscredspriv.h"
 #include "crypto/secret.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "qom/object_interfaces.h"
 #include "trace.h"
 
diff --git a/fsdev/qemu-fsdev-dummy.c b/fsdev/qemu-fsdev-dummy.c
index 489cd29081..8444a254be 100644
--- a/fsdev/qemu-fsdev-dummy.c
+++ b/fsdev/qemu-fsdev-dummy.c
@@ -10,10 +10,10 @@
  * the COPYING file in the top-level directory.
  *
  */
+
 #include "qemu/osdep.h"
 #include "qemu-fsdev.h"
 #include "qemu/config-file.h"
-#include "qemu/module.h"
 
 int qemu_fsdev_add(QemuOpts *opts, Error **errp)
 {
diff --git a/gdbstub.c b/gdbstub.c
index ae8f1f050a..912a790041 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -22,6 +22,7 @@
 #include "qemu/error-report.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
+#include "qemu/module.h"
 #include "trace-root.h"
 #ifdef CONFIG_USER_ONLY
 #include "qemu.h"
diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 775e8ff766..a3288cbe56 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -19,6 +19,7 @@
 #include "coth.h"
 #include "hw/virtio/virtio-access.h"
 #include "qemu/iov.h"
+#include "qemu/module.h"
 
 static void virtio_9p_push_and_notify(V9fsPDU *pdu)
 {
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 9ed1629f36..228828a494 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -30,6 +30,7 @@
 #include "qapi/qapi-events-run-state.h"
 #include "qapi/qapi-visit-misc.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 
 struct acpi_table_header {
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index 02717a8b0d..b891df375f 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
+#include "qemu/module.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/vmgenid.h"
diff --git a/hw/adc/stm32f2xx_adc.c b/hw/adc/stm32f2xx_adc.c
index 329a8aa673..c93b60e22e 100644
--- a/hw/adc/stm32f2xx_adc.c
+++ b/hw/adc/stm32f2xx_adc.c
@@ -26,6 +26,7 @@
 #include "hw/sysbus.h"
 #include "hw/hw.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/adc/stm32f2xx_adc.h"
 
 #ifndef STM_ADC_ERR_DEBUG
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 9d57361c67..3f34a5153f 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -7,6 +7,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/module.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "cpu.h"
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 06ec6f4dc8..35e906ca54 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -17,7 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/arm/allwinner-a10.h"
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 76cc690579..dcc26ae2c1 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qemu/bitops.h"
 #include "qapi/error.h"
 #include "trace.h"
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index c4b2a9a1f5..accb99cb34 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -10,7 +10,6 @@
 #include "qemu/osdep.h"
 #include "hw/arm/armv7m.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/arm/arm.h"
@@ -18,6 +17,7 @@
 #include "elf.h"
 #include "sysemu/qtest.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "exec/address-spaces.h"
 #include "target/arm/idau.h"
 
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index a27233d487..67ff6e4904 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -12,13 +12,13 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "exec/address-spaces.h"
 #include "hw/misc/unimp.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/char/serial.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/i2c/aspeed_i2c.h"
 #include "net/net.h"
 
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 6be7660e8c..87778bc165 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/arm/bcm2835_peripherals.h"
 #include "hw/misc/bcm2835_mbox_defs.h"
 #include "hw/arm/raspi_platform.h"
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 6a09c339d3..493a913f89 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "cpu.h"
 #include "hw/arm/bcm2836.h"
 #include "hw/arm/raspi_platform.h"
diff --git a/hw/arm/digic.c b/hw/arm/digic.c
index 726abb9b48..020fe4b5c4 100644
--- a/hw/arm/digic.c
+++ b/hw/arm/digic.c
@@ -22,6 +22,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/arm/digic.h"
 #include "sysemu/sysemu.h"
 
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 7b7b97f74c..7129517378 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -21,11 +21,11 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "hw/arm/fsl-imx6.h"
 #include "sysemu/sysemu.h"
 #include "chardev/char.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 
 #define IMX6_ESDHC_CAPABILITIES     0x057834b4
 
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 4b56bfa8d1..05505bac56 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -18,11 +18,11 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "hw/arm/fsl-imx6ul.h"
 #include "hw/misc/unimp.h"
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 
 #define NAME_SIZE 20
 
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 7663ad6861..b7e3526b4f 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -20,11 +20,11 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "hw/arm/fsl-imx7.h"
 #include "hw/misc/unimp.h"
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 
 #define NAME_SIZE 20
 
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 3d7c88910e..432876958d 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -9,8 +9,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/arm/pxa.h"
diff --git a/hw/arm/pxa2xx_gpio.c b/hw/arm/pxa2xx_gpio.c
index e15070188e..d1fc9cba67 100644
--- a/hw/arm/pxa2xx_gpio.c
+++ b/hw/arm/pxa2xx_gpio.c
@@ -13,6 +13,7 @@
 #include "hw/sysbus.h"
 #include "hw/arm/pxa.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #define PXA2XX_GPIO_BANKS	4
 
diff --git a/hw/arm/pxa2xx_pic.c b/hw/arm/pxa2xx_pic.c
index 61275fa040..2f4b461562 100644
--- a/hw/arm/pxa2xx_pic.c
+++ b/hw/arm/pxa2xx_pic.c
@@ -9,7 +9,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/arm/pxa.h"
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index e94be6db6c..717d22bcbe 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -25,6 +25,7 @@
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/jhash.h"
+#include "qemu/module.h"
 
 #include "qemu/error-report.h"
 #include "hw/arm/smmu-common.h"
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index 980e5af13c..4699c2f617 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "hw/arm/arm.h"
 #include "exec/address-spaces.h"
 #include "hw/arm/stm32f205_soc.h"
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 5331ab71e2..851ceb04f6 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -49,6 +49,7 @@
 #include "exec/address-spaces.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/arm/sysbus-fdt.h"
 #include "hw/platform-bus.h"
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 5ee58c09be..61ca39fb21 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -11,8 +11,8 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 4f8bc41d9d..641e11a284 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -17,7 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "cpu.h"
 #include "hw/arm/xlnx-zynqmp.h"
 #include "hw/intc/arm_gic_common.h"
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 2265622d44..e704d0e166 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -22,6 +22,7 @@
 #include "hw/audio/soundhw.h"
 #include "audio/audio.h"
 #include "hw/pci/pci.h"
+#include "qemu/module.h"
 #include "sysemu/dma.h"
 
 enum {
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index 0957780a3d..7dd9a89b89 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/hw.h"
 #include "hw/audio/soundhw.h"
 #include "audio/audio.h"
diff --git a/hw/audio/cs4231.c b/hw/audio/cs4231.c
index 30690f96ae..8372299ebb 100644
--- a/hw/audio/cs4231.c
+++ b/hw/audio/cs4231.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 /*
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 62da75eefe..7216b41cc1 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -21,12 +21,14 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/audio/soundhw.h"
 #include "audio/audio.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "qapi/error.h"
 
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index a5314d66fd..260c142b70 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -31,6 +31,7 @@
 #include "hw/audio/soundhw.h"
 #include "audio/audio.h"
 #include "hw/pci/pci.h"
+#include "qemu/module.h"
 #include "sysemu/dma.h"
 
 /* Missing stuff:
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index b3e2a7fdd5..9ab51631d9 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -21,8 +21,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/hw.h"
 #include "hw/audio/soundhw.h"
 #include "audio/audio.h"
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index c25bfa38b1..84639b5424 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -21,6 +21,7 @@
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "intel-hda.h"
+#include "qemu/module.h"
 #include "intel-hda-defs.h"
 #include "audio/audio.h"
 #include "trace.h"
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 33e333cc26..b78baac295 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -24,6 +24,7 @@
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/audio/soundhw.h"
 #include "intel-hda.h"
 #include "intel-hda-defs.h"
diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
index 035dd76cbf..ff1a0d0d8f 100644
--- a/hw/audio/marvell_88w8618.c
+++ b/hw/audio/marvell_88w8618.c
@@ -9,12 +9,14 @@
  * Contributions after 2012-01-13 are licensed under the terms of the
  * GNU GPL, version 2 or (at your option) any later version.
  */
+
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/hw.h"
 #include "hw/audio/wm8750.h"
 #include "audio/audio.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 
 #define MP_AUDIO_SIZE           0x00001000
 
diff --git a/hw/audio/milkymist-ac97.c b/hw/audio/milkymist-ac97.c
index 90cce1e6ed..bf6a5a6b96 100644
--- a/hw/audio/milkymist-ac97.c
+++ b/hw/audio/milkymist-ac97.c
@@ -27,6 +27,7 @@
 #include "trace.h"
 #include "audio/audio.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 
 enum {
     R_AC97_CTRL = 0,
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 9c7fd74aeb..a7b3ab0c2b 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -27,6 +27,7 @@
 #include "hw/isa/isa.h"
 #include "hw/audio/soundhw.h"
 #include "audio/audio.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/timer/i8254.h"
 #include "hw/audio/pcspk.h"
diff --git a/hw/audio/pl041.c b/hw/audio/pl041.c
index c8cc503236..59c6ce1f2e 100644
--- a/hw/audio/pl041.c
+++ b/hw/audio/pl041.c
@@ -23,6 +23,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #include "pl041.h"
 #include "lm4549.h"
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 65ea0cd938..a2db06a2bb 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -21,6 +21,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/audio/soundhw.h"
@@ -30,6 +31,7 @@
 #include "qemu/timer.h"
 #include "qemu/host-utils.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 
 #define dolog(...) AUD_log ("sb16", __VA_ARGS__)
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index ca0ad73caf..81f83eea88 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
+#include "qemu/module.h"
 #include "hw/audio/wm8750.h"
 #include "audio/audio.h"
 
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 6f19f127a5..14b7384dbe 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -40,6 +40,7 @@
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 /********************************************************/
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index e8dfa14b33..dd87affcf5 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -28,6 +28,7 @@
 #include "hw/ssi/ssi.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 
diff --git a/hw/block/nand.c b/hw/block/nand.c
index 919cb9b803..0a2736b50e 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -25,6 +25,7 @@
 #include "hw/qdev.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 
 # define NAND_CMD_READ0		0x00
 # define NAND_CMD_READ1		0x01
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 63a5b58849..3571456cc1 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -37,6 +37,7 @@
 #include "sysemu/block-backend.h"
 
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qemu/cutils.h"
 #include "trace.h"
 #include "nvme.h"
diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index f11118a687..b3644f7e89 100644
--- a/hw/block/onenand.c
+++ b/hw/block/onenand.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "hw/hw.h"
 #include "hw/block/flash.h"
 #include "hw/irq.h"
@@ -29,6 +28,7 @@
 #include "hw/sysbus.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 /* 11 for 2kB-page OneNAND ("2nd generation") and 10 for 1kB-page chips */
 #define PAGE_SHIFT	11
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 333b736277..35080d915f 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -47,6 +47,7 @@
 #include "qemu/error-report.h"
 #include "qemu/host-utils.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "hw/sysbus.h"
 #include "sysemu/blockdev.h"
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index f2c6201f81..eb106f4996 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -43,6 +43,7 @@
 #include "qemu/timer.h"
 #include "sysemu/block-backend.h"
 #include "qemu/host-utils.h"
+#include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "trace.h"
 
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 06e57a4d39..cbb3729158 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -13,8 +13,8 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/iov.h"
+#include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "hw/block/block.h"
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index ef635be4c2..71fd2d1f77 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -7,6 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-block-core.h"
diff --git a/hw/bt/hci-csr.c b/hw/bt/hci-csr.c
index fa6660a113..3d60654f44 100644
--- a/hw/bt/hci-csr.c
+++ b/hw/bt/hci-csr.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "chardev/char-serial.h"
 #include "qemu/timer.h"
 #include "qemu/bswap.h"
diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 0364596c55..94679d276c 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -23,6 +23,7 @@
 #include "qemu/osdep.h"
 #include "hw/char/bcm2835_aux.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #define AUX_IRQ         0x0
 #define AUX_ENABLES     0x4
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index fbdbd463bb..fa25fe24da 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -27,6 +27,7 @@
 #include "chardev/char-serial.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/char/cadence_uart.h"
 
 #ifdef CADENCE_UART_ERR_DEBUG
diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
index ddfbb25c24..606c9cc7d6 100644
--- a/hw/char/cmsdk-apb-uart.c
+++ b/hw/char/cmsdk-apb-uart.c
@@ -17,6 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "trace.h"
 #include "hw/sysbus.h"
diff --git a/hw/char/debugcon.c b/hw/char/debugcon.c
index e2abc61b04..e1b6d1190f 100644
--- a/hw/char/debugcon.c
+++ b/hw/char/debugcon.c
@@ -26,6 +26,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/hw.h"
 #include "chardev/char-fe.h"
 #include "hw/isa/isa.h"
diff --git a/hw/char/digic-uart.c b/hw/char/digic-uart.c
index ccc75eaa4d..e4ac8435c8 100644
--- a/hw/char/digic-uart.c
+++ b/hw/char/digic-uart.c
@@ -31,6 +31,7 @@
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #include "hw/char/digic-uart.h"
 
diff --git a/hw/char/escc.c b/hw/char/escc.c
index c5b05a63f1..8ddbb4be4f 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
+#include "qemu/module.h"
 #include "hw/char/escc.h"
 #include "ui/console.h"
 #include "trace.h"
diff --git a/hw/char/etraxfs_ser.c b/hw/char/etraxfs_ser.c
index a184026410..9745bca86c 100644
--- a/hw/char/etraxfs_ser.c
+++ b/hw/char/etraxfs_ser.c
@@ -26,6 +26,7 @@
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #define D(x)
 
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index a5a285655f..c5700eeaec 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "sysemu/sysemu.h"
 #include "chardev/char-fe.h"
 #include "chardev/char-serial.h"
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index 9623016d56..c2bb3ac153 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/sparc/grlib.h"
 #include "hw/sysbus.h"
+#include "qemu/module.h"
 #include "chardev/char-fe.h"
 
 #include "trace.h"
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 1e363190e3..0655a9571b 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -22,6 +22,7 @@
 #include "hw/char/imx_serial.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #ifndef DEBUG_IMX_UART
 #define DEBUG_IMX_UART 0
diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index 5e09caf851..5ab731e408 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "hw/ipack/ipack.h"
 #include "qemu/bitops.h"
+#include "qemu/module.h"
 #include "chardev/char-fe.h"
 
 /* #define DEBUG_IPOCTAL */
diff --git a/hw/char/lm32_juart.c b/hw/char/lm32_juart.c
index d75c835ad2..41a3ec81e3 100644
--- a/hw/char/lm32_juart.c
+++ b/hw/char/lm32_juart.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
+#include "qemu/module.h"
 #include "trace.h"
 #include "chardev/char-fe.h"
 
diff --git a/hw/char/lm32_uart.c b/hw/char/lm32_uart.c
index c4a3b9b275..d047a44e34 100644
--- a/hw/char/lm32_uart.c
+++ b/hw/char/lm32_uart.c
@@ -28,6 +28,7 @@
 #include "trace.h"
 #include "chardev/char-fe.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 
 enum {
     R_RXTX = 0,
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index 787f985db6..7b06110c4d 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -5,9 +5,11 @@
  *
  * This code is licensed under the GPL
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
+#include "qemu/module.h"
 #include "hw/m68k/mcf.h"
 #include "chardev/char-fe.h"
 
diff --git a/hw/char/milkymist-uart.c b/hw/char/milkymist-uart.c
index 548ee27bca..8a78fcca8f 100644
--- a/hw/char/milkymist-uart.c
+++ b/hw/char/milkymist-uart.c
@@ -27,6 +27,7 @@
 #include "trace.h"
 #include "chardev/char-fe.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 
 enum {
     R_RXTX = 0,
diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c
index 2f5fae6167..c90b491477 100644
--- a/hw/char/nrf51_uart.c
+++ b/hw/char/nrf51_uart.c
@@ -14,6 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/char/nrf51_uart.h"
 #include "trace.h"
 
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index a80da47ecf..1cd4c54a02 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -22,8 +22,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/hw.h"
 #include "chardev/char-parallel.h"
 #include "chardev/char-fe.h"
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index e5dd448f85..c1ae2f31f5 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -23,6 +23,7 @@
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 #define PL011_INT_TX 0x20
diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index dbc91a1e5b..691dc870ed 100644
--- a/hw/char/sclpconsole-lm.c
+++ b/hw/char/sclpconsole-lm.c
@@ -17,6 +17,7 @@
 #include "hw/qdev.h"
 #include "qemu/thread.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "chardev/char-fe.h"
 
 #include "hw/s390x/sclp.h"
diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
index 1fa16e9055..09b1d45d7a 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -16,6 +16,7 @@
 #include "hw/qdev.h"
 #include "qemu/thread.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/event-facility.h"
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index 116b7b2e69..610426111a 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -25,6 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/char/serial.h"
 #include "hw/isa/isa.h"
 
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index 2d5ffae5cf..9028efbda8 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -27,6 +27,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/char/serial.h"
 #include "hw/pci/pci.h"
 
diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index 617303dbaf..871d2666f3 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -1,7 +1,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/qdev.h"
 #include "chardev/char-fe.h"
diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index 10392c70e2..40c365b908 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/char/stm32f2xx_usart.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #ifndef STM_USART_ERR_DEBUG
 #define STM_USART_ERR_DEBUG 0
diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index 35b079d5c4..3785886c25 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "chardev/char-fe.h"
 #include "hw/s390x/3270-ccw.h"
 
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 2cbe1d4ed5..1bbeb00fae 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "chardev/char-fe.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "trace.h"
 #include "hw/virtio/virtio-serial.h"
 #include "qapi/error.h"
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index bdd917bbb8..f7a54f261b 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/iov.h"
+#include "qemu/module.h"
 #include "monitor/monitor.h"
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index 2a8bc1e497..880962a756 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "qemu/module.h"
 #include "chardev/char-fe.h"
 
 #define DUART(x)
diff --git a/hw/core/bus.c b/hw/core/bus.c
index 60c4720379..e6baa04e52 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/ctype.h"
+#include "qemu/module.h"
 #include "hw/qdev.h"
 #include "qapi/error.h"
 
diff --git a/hw/core/empty_slot.c b/hw/core/empty_slot.c
index 239f78e2a7..c694532046 100644
--- a/hw/core/empty_slot.c
+++ b/hw/core/empty_slot.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
+#include "qemu/module.h"
 #include "hw/empty_slot.h"
 
 //#define DEBUG_EMPTY_SLOT
diff --git a/hw/core/fw-path-provider.c b/hw/core/fw-path-provider.c
index 33b99830e7..4840faefd1 100644
--- a/hw/core/fw-path-provider.c
+++ b/hw/core/fw-path-provider.c
@@ -17,6 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/fw-path-provider.h"
+#include "qemu/module.h"
 
 char *fw_path_provider_get_dev_path(FWPathProvider *p, BusState *bus,
                                     DeviceState *dev)
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index 3695dd439c..79a493e577 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -36,6 +36,7 @@
 #include "sysemu/dma.h"
 #include "hw/loader.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/core/generic-loader.h"
 
 #define CPU_NONE 0xFFFFFFFF
diff --git a/hw/core/nmi.c b/hw/core/nmi.c
index bfd0896daf..481c4b3c7e 100644
--- a/hw/core/nmi.c
+++ b/hw/core/nmi.c
@@ -23,6 +23,7 @@
 #include "hw/nmi.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
+#include "qemu/module.h"
 #include "monitor/monitor.h"
 
 struct do_nmi_s {
diff --git a/hw/core/or-irq.c b/hw/core/or-irq.c
index a86901b673..123a8c644a 100644
--- a/hw/core/or-irq.c
+++ b/hw/core/or-irq.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/or-irq.h"
+#include "qemu/module.h"
 
 static void or_irq_handler(void *opaque, int n, int level)
 {
diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index e473a44746..5fecb29239 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include "hw/platform-bus.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "sysemu/sysemu.h"
 
 
diff --git a/hw/core/register.c b/hw/core/register.c
index d2d1636250..bb5ab9d479 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -19,6 +19,7 @@
 #include "hw/register.h"
 #include "hw/qdev.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 static inline void register_write_val(RegisterInfo *reg, uint64_t val)
 {
diff --git a/hw/core/split-irq.c b/hw/core/split-irq.c
index 7e64cd4969..c606f4a802 100644
--- a/hw/core/split-irq.c
+++ b/hw/core/split-irq.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/split-irq.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 
 static void split_irq_handler(void *opaque, int n, int level)
 {
diff --git a/hw/core/stream.c b/hw/core/stream.c
index 4439ecdf0b..39b1e595cd 100644
--- a/hw/core/stream.c
+++ b/hw/core/stream.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "hw/stream.h"
+#include "qemu/module.h"
 
 size_t
 stream_push(StreamSlave *sink, uint8_t *buf, size_t len)
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 307cf90a51..11bec6515f 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "monitor/monitor.h"
 #include "exec/address-spaces.h"
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 5649843cd8..980f230d75 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/cpu/a15mpcore.h"
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index a5b867872c..187e4d939e 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/cpu/a9mpcore.h"
 #include "qom/cpu.h"
 
diff --git a/hw/cpu/arm11mpcore.c b/hw/cpu/arm11mpcore.c
index 8aead3794e..2404f93a3e 100644
--- a/hw/cpu/arm11mpcore.c
+++ b/hw/cpu/arm11mpcore.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/cpu/arm11mpcore.h"
 #include "hw/intc/realview_gic.h"
 
diff --git a/hw/cpu/core.c b/hw/cpu/core.c
index 7e42e2c87a..e57c73f0ce 100644
--- a/hw/cpu/core.c
+++ b/hw/cpu/core.c
@@ -6,9 +6,11 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
+
 #include "qemu/osdep.h"
 #include "hw/cpu/core.h"
 #include "qapi/visitor.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "sysemu/cpus.h"
 
diff --git a/hw/cpu/realview_mpcore.c b/hw/cpu/realview_mpcore.c
index 9d3f8378fb..f06294bb5e 100644
--- a/hw/cpu/realview_mpcore.c
+++ b/hw/cpu/realview_mpcore.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/cpu/arm11mpcore.h"
 #include "hw/intc/realview_gic.h"
 
diff --git a/hw/display/ads7846.c b/hw/display/ads7846.c
index 166edade7d..1a97e97638 100644
--- a/hw/display/ads7846.c
+++ b/hw/display/ads7846.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/ssi/ssi.h"
+#include "qemu/module.h"
 #include "ui/console.h"
 
 typedef struct {
diff --git a/hw/display/ati.c b/hw/display/ati.c
index 75716dd944..76595d9511 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -21,6 +21,7 @@
 #include "ati_regs.h"
 #include "vga_regs.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index 599863e4e1..2311ec75b8 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -30,6 +30,7 @@
 #include "ui/pixel_ops.h"
 #include "hw/misc/bcm2835_mbox_defs.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #define DEFAULT_VCRAM_SIZE 0x4000000
 #define BCM2835_FB_OFFSET  0x00100000
diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index 3d439eb240..0a2a3e27c4 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -4,7 +4,9 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
+
 #include "qemu/osdep.h"
+#include "qemu/module.h"
 #include "qemu/units.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index e50d97e48c..c6b7361be2 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -25,12 +25,12 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "ui/console.h"
 #include "hw/sysbus.h"
 #include "hw/loader.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 /* Change to 1 to enable debugging */
 #define DEBUG_CG3 0
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 76c052c702..2e4911a1e3 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -31,7 +31,9 @@
  *
  *  https://pdos.csail.mit.edu/6.828/2005/readings/hardware/vgadoc
  */
+
 #include "qemu/osdep.h"
+#include "qemu/module.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "trace.h"
diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
index fa10b74230..69cdb9e066 100644
--- a/hw/display/cirrus_vga_isa.c
+++ b/hw/display/cirrus_vga_isa.c
@@ -25,6 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/hw.h"
 #include "hw/loader.h"
 #include "hw/isa/isa.h"
diff --git a/hw/display/dpcd.c b/hw/display/dpcd.c
index 943002bee5..88cde54821 100644
--- a/hw/display/dpcd.c
+++ b/hw/display/dpcd.c
@@ -28,6 +28,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/misc/auxbus.h"
 #include "hw/display/dpcd.h"
 
diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 083b3172da..61f7408b1c 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -23,11 +23,11 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "hw/sysbus.h"
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
 #include "qemu/bswap.h"
+#include "qemu/module.h"
 
 /* Debug messages configuration */
 #define EXYNOS4210_FIMD_DEBUG              0
diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index 3407adf98d..1774b4452e 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -21,6 +21,7 @@
 #include "qemu/units.h"
 #include "hw/hw.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
 #include "trace.h"
diff --git a/hw/display/i2c-ddc.c b/hw/display/i2c-ddc.c
index 9fe5403a92..041fc4f408 100644
--- a/hw/display/i2c-ddc.c
+++ b/hw/display/i2c-ddc.c
@@ -17,8 +17,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/i2c/i2c.h"
 #include "hw/display/i2c-ddc.h"
 
diff --git a/hw/display/jazz_led.c b/hw/display/jazz_led.c
index eb7933d2a3..783189ebcd 100644
--- a/hw/display/jazz_led.c
+++ b/hw/display/jazz_led.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
 #include "trace.h"
diff --git a/hw/display/milkymist-tmu2.c b/hw/display/milkymist-tmu2.c
index b33fc234e9..e1ed018b8f 100644
--- a/hw/display/milkymist-tmu2.c
+++ b/hw/display/milkymist-tmu2.c
@@ -30,6 +30,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "hw/display/milkymist_tmu2.h"
 
diff --git a/hw/display/milkymist-vgafb.c b/hw/display/milkymist-vgafb.c
index 177fdac7d8..dce1dd7ad6 100644
--- a/hw/display/milkymist-vgafb.c
+++ b/hw/display/milkymist-vgafb.c
@@ -30,6 +30,7 @@
 #include "framebuffer.h"
 #include "ui/pixel_ops.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 
 #define BITS 8
 #include "milkymist-vgafb_template.h"
diff --git a/hw/display/pl110.c b/hw/display/pl110.c
index cf68457fd1..2bdfc3cc49 100644
--- a/hw/display/pl110.c
+++ b/hw/display/pl110.c
@@ -14,6 +14,7 @@
 #include "ui/pixel_ops.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #define PL110_CR_EN   0x001
 #define PL110_CR_BGR  0x100
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 3880a7410b..98c7410032 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -23,10 +23,10 @@
 #include <zlib.h>
 
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/timer.h"
 #include "qemu/queue.h"
 #include "qemu/atomic.h"
+#include "qemu/module.h"
 #include "sysemu/sysemu.h"
 #include "migration/blocker.h"
 #include "trace.h"
diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
index da3229a1f6..c7f9f9f879 100644
--- a/hw/display/ramfb-standalone.c
+++ b/hw/display/ramfb-standalone.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/loader.h"
 #include "hw/display/ramfb.h"
 #include "ui/console.h"
diff --git a/hw/display/sii9022.c b/hw/display/sii9022.c
index 9c36e4c17e..0bebb85a58 100644
--- a/hw/display/sii9022.c
+++ b/hw/display/sii9022.c
@@ -14,7 +14,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "hw/i2c/i2c.h"
 #include "hw/display/i2c-ddc.h"
 #include "trace.h"
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 1e2709b2d0..5918f59b2b 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -27,7 +27,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/char/serial.h"
diff --git a/hw/display/ssd0303.c b/hw/display/ssd0303.c
index 8edf34986c..f2a60c44c9 100644
--- a/hw/display/ssd0303.c
+++ b/hw/display/ssd0303.c
@@ -10,8 +10,10 @@
 /* The controller can support a variety of different displays, but we only
    implement one.  Most of the commends relating to brightness and geometry
    setup are ignored. */
+
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
+#include "qemu/module.h"
 #include "ui/console.h"
 
 //#define DEBUG_SSD0303 1
diff --git a/hw/display/ssd0323.c b/hw/display/ssd0323.c
index e182893157..ac373f1e78 100644
--- a/hw/display/ssd0323.c
+++ b/hw/display/ssd0323.c
@@ -10,8 +10,10 @@
 /* The controller can support a variety of different displays, but we only
    implement one.  Most of the commends relating to brightness and geometry
    setup are ignored. */
+
 #include "qemu/osdep.h"
 #include "hw/ssi/ssi.h"
+#include "qemu/module.h"
 #include "ui/console.h"
 
 //#define DEBUG_SSD0323 1
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 66f2459226..bd5ac8f823 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -24,12 +24,12 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 
 #define TCX_ROM_FILE "QEMU,tcx.bin"
 #define FCODE_MAX_ROM_SIZE 0x10000
diff --git a/hw/display/vga-isa.c b/hw/display/vga-isa.c
index fa44242e0d..945952a9b0 100644
--- a/hw/display/vga-isa.c
+++ b/hw/display/vga-isa.c
@@ -23,11 +23,13 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/isa/isa.h"
 #include "vga_int.h"
 #include "ui/pixel_ops.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/loader.h"
 
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index a17c96e703..c66d9ec7ee 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -23,11 +23,13 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "vga_int.h"
 #include "ui/pixel_ops.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/loader.h"
 #include "hw/display/edid.h"
diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index 0bc4d9d424..9e1c20a3bb 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/pci/pci.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 9e37e0ac96..5444a41aec 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -13,7 +13,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "qemu-common.h"
 #include "qemu/iov.h"
 #include "ui/console.h"
 #include "trace.h"
@@ -24,6 +23,7 @@
 #include "hw/display/edid.h"
 #include "migration/blocker.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 
 #define VIRTIO_GPU_VM_VERSION 1
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 5d57bf5b0c..023542a0ec 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -5,6 +5,7 @@
 #include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 
 /*
  * virtio-vga: This extends VirtioPCIProxy.
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index afbf1c5973..249a179bf6 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -21,7 +21,9 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
+#include "qemu/module.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 11b09bd18c..cfd4c700b7 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/display/xlnx_dp.h"
 
 #ifndef DEBUG_DP
diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
index 5d144a2633..a39e8f4968 100644
--- a/hw/dma/bcm2835_dma.c
+++ b/hw/dma/bcm2835_dma.c
@@ -7,6 +7,7 @@
 #include "qapi/error.h"
 #include "hw/dma/bcm2835_dma.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 /* DMA CS Control and Status bits */
 #define BCM2708_DMA_ACTIVE      (1 << 0)
diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
index 892f655a7e..68fad2dd12 100644
--- a/hw/dma/i82374.c
+++ b/hw/dma/i82374.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/isa/isa.h"
 #include "hw/dma/i8257.h"
 
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 3e1f13a4aa..30a3442437 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -21,11 +21,13 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/isa/isa.h"
 #include "hw/dma/i8257.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 #include "qemu/log.h"
 #include "trace.h"
 
diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index ef15d3e628..7e5762457b 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -11,6 +11,7 @@
 #include "hw/sysbus.h"
 #include "exec/address-spaces.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/dma/pl080.h"
 #include "qapi/error.h"
 
diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index d071049233..62ad356156 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -20,6 +20,7 @@
 #include "qemu/timer.h"
 #include "sysemu/dma.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #ifndef PL330_ERR_DEBUG
 #define PL330_ERR_DEBUG 0
diff --git a/hw/dma/puv3_dma.c b/hw/dma/puv3_dma.c
index c89eade029..122f87aff1 100644
--- a/hw/dma/puv3_dma.c
+++ b/hw/dma/puv3_dma.c
@@ -8,12 +8,14 @@
  * published by the Free Software Foundation, or any later version.
  * See the COPYING file in the top-level directory.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 
 #undef DEBUG_PUV3
 #include "hw/unicore32/puv3.h"
+#include "qemu/module.h"
 
 #define PUV3_DMA_CH_NR          (6)
 #define PUV3_DMA_CH_MASK        (0xff)
diff --git a/hw/dma/pxa2xx_dma.c b/hw/dma/pxa2xx_dma.c
index d498de8ffe..d6fb957417 100644
--- a/hw/dma/pxa2xx_dma.c
+++ b/hw/dma/pxa2xx_dma.c
@@ -13,6 +13,7 @@
 #include "hw/arm/pxa.h"
 #include "hw/sysbus.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 
 #define PXA255_DMA_NUM_CHANNELS 16
 #define PXA27X_DMA_NUM_CHANNELS 32
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index ccd8612888..6ccafece18 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -28,6 +28,7 @@
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "exec/address-spaces.h"
 #include "trace.h"
 
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 7b00a27de6..88765d0c25 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -32,6 +32,7 @@
 #include "hw/sysbus.h"
 #include "sysemu/dma.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 /*
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 401a328e27..921be178d9 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -29,6 +29,7 @@
 #include "hw/ptimer.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 
 #include "hw/stream.h"
 
diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index b6745f5bcf..51e1ead4fa 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -30,6 +30,7 @@
 #include "hw/dma/xlnx-zdma.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 
 #ifndef XLNX_ZDMA_ERR_DEBUG
diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index 12bb2e3716..7a03ce1b02 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -30,6 +30,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/dma.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #define FREQ_HZ 900000000
 
diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
index 077c7da9cc..040df70a93 100644
--- a/hw/dma/xlnx_dpdma.c
+++ b/hw/dma/xlnx_dpdma.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/dma/xlnx_dpdma.h"
 
 #ifndef DEBUG_DPDMA
diff --git a/hw/gpio/bcm2835_gpio.c b/hw/gpio/bcm2835_gpio.c
index acc2e3cf9e..ba8dd6c393 100644
--- a/hw/gpio/bcm2835_gpio.c
+++ b/hw/gpio/bcm2835_gpio.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
diff --git a/hw/gpio/gpio_key.c b/hw/gpio/gpio_key.c
index b34aa49dfb..7d5510257e 100644
--- a/hw/gpio/gpio_key.c
+++ b/hw/gpio/gpio_key.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 
 #define TYPE_GPIOKEY "gpio-key"
diff --git a/hw/gpio/imx_gpio.c b/hw/gpio/imx_gpio.c
index c36c394fda..a51af72c1f 100644
--- a/hw/gpio/imx_gpio.c
+++ b/hw/gpio/imx_gpio.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "hw/gpio/imx_gpio.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #ifndef DEBUG_IMX_GPIO
 #define DEBUG_IMX_GPIO 0
diff --git a/hw/gpio/max7310.c b/hw/gpio/max7310.c
index c6f686c3eb..273da622ca 100644
--- a/hw/gpio/max7310.c
+++ b/hw/gpio/max7310.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
+#include "qemu/module.h"
 
 #define TYPE_MAX7310 "max7310"
 #define MAX7310(obj) OBJECT_CHECK(MAX7310State, (obj), TYPE_MAX7310)
diff --git a/hw/gpio/mpc8xxx.c b/hw/gpio/mpc8xxx.c
index e12edb4933..6ff56dc3f2 100644
--- a/hw/gpio/mpc8xxx.c
+++ b/hw/gpio/mpc8xxx.c
@@ -21,6 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "qemu/module.h"
 
 #define TYPE_MPC8XXX_GPIO "mpc8xxx_gpio"
 #define MPC8XXX_GPIO(obj) OBJECT_CHECK(MPC8XXXGPIOState, (obj), TYPE_MPC8XXX_GPIO)
diff --git a/hw/gpio/nrf51_gpio.c b/hw/gpio/nrf51_gpio.c
index 87a2f2a0dc..dd6c16a841 100644
--- a/hw/gpio/nrf51_gpio.c
+++ b/hw/gpio/nrf51_gpio.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/gpio/nrf51_gpio.h"
 #include "trace.h"
 
diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index 08472193b5..e2785c5dc7 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -23,6 +23,7 @@
 #include "hw/arm/omap.h"
 #include "hw/sysbus.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 
 struct omap_gpio_s {
diff --git a/hw/gpio/pl061.c b/hw/gpio/pl061.c
index 4ae2aa1566..02c01fd521 100644
--- a/hw/gpio/pl061.c
+++ b/hw/gpio/pl061.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 //#define DEBUG_PL061 1
 
diff --git a/hw/gpio/puv3_gpio.c b/hw/gpio/puv3_gpio.c
index 33241b8564..54d30cada2 100644
--- a/hw/gpio/puv3_gpio.c
+++ b/hw/gpio/puv3_gpio.c
@@ -8,12 +8,14 @@
  * published by the Free Software Foundation, or any later version.
  * See the COPYING file in the top-level directory.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 
 #undef DEBUG_PUV3
 #include "hw/unicore32/puv3.h"
+#include "qemu/module.h"
 
 #define TYPE_PUV3_GPIO "puv3_gpio"
 #define PUV3_GPIO(obj) OBJECT_CHECK(PUV3GPIOState, (obj), TYPE_PUV3_GPIO)
diff --git a/hw/gpio/zaurus.c b/hw/gpio/zaurus.c
index 15865e1081..f2f1f67266 100644
--- a/hw/gpio/zaurus.c
+++ b/hw/gpio/zaurus.c
@@ -15,10 +15,12 @@
  * You should have received a copy of the GNU General Public License along
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/arm/sharpsl.h"
 #include "hw/sysbus.h"
+#include "qemu/module.h"
 
 #undef REG_FMT
 #define REG_FMT			"0x%02lx"
diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index 4d1380c51f..e94614abbd 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/module.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "cpu.h"
diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 8758635227..6ebf31c310 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
 #include "sysemu/kvm.h"
diff --git a/hw/hyperv/hyperv_testdev.c b/hw/hyperv/hyperv_testdev.c
index 4880333cf5..0d343a8bc0 100644
--- a/hw/hyperv/hyperv_testdev.c
+++ b/hw/hyperv/hyperv_testdev.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 #include "qemu/queue.h"
 #include "hw/qdev.h"
 #include "hw/isa/isa.h"
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index a085510cfd..219ad3806f 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/i2c/aspeed_i2c.h"
 
 /* I2C Global Register */
diff --git a/hw/i2c/bitbang_i2c.c b/hw/i2c/bitbang_i2c.c
index 8be88ee265..5dfc72d9d7 100644
--- a/hw/i2c/bitbang_i2c.c
+++ b/hw/i2c/bitbang_i2c.c
@@ -9,10 +9,12 @@
  * Contributions after 2012-01-13 are licensed under the terms of the
  * GNU GPL, version 2 or (at your option) any later version.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "bitbang_i2c.h"
 #include "hw/sysbus.h"
+#include "qemu/module.h"
 
 //#define DEBUG_BITBANG_I2C
 
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 15237ad073..20f36f1d55 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 #define I2C_BROADCAST 0x00
diff --git a/hw/i2c/exynos4210_i2c.c b/hw/i2c/exynos4210_i2c.c
index d154b05739..70a97a3e2d 100644
--- a/hw/i2c/exynos4210_i2c.c
+++ b/hw/i2c/exynos4210_i2c.c
@@ -21,6 +21,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/sysbus.h"
 #include "hw/i2c/i2c.h"
diff --git a/hw/i2c/imx_i2c.c b/hw/i2c/imx_i2c.c
index 6da5224e2e..ce7a94c282 100644
--- a/hw/i2c/imx_i2c.c
+++ b/hw/i2c/imx_i2c.c
@@ -22,6 +22,7 @@
 #include "hw/i2c/imx_i2c.h"
 #include "hw/i2c/i2c.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #ifndef DEBUG_IMX_I2C
 #define DEBUG_IMX_I2C 0
diff --git a/hw/i2c/microbit_i2c.c b/hw/i2c/microbit_i2c.c
index 793f1b0f8b..214be07c5a 100644
--- a/hw/i2c/microbit_i2c.c
+++ b/hw/i2c/microbit_i2c.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/i2c/microbit_i2c.h"
 
 static const uint32_t twi_read_sequence[] = {0x5A, 0x5A, 0x40};
diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
index 693ca7ef6b..e9a1127050 100644
--- a/hw/i2c/mpc_i2c.c
+++ b/hw/i2c/mpc_i2c.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/sysbus.h"
 
 /* #define DEBUG_I2C */
diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
index d02e734ea8..d7ebeae8e2 100644
--- a/hw/i2c/omap_i2c.c
+++ b/hw/i2c/omap_i2c.c
@@ -16,8 +16,10 @@
  * You should have received a copy of the GNU General Public License along
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/hw.h"
 #include "hw/i2c/i2c.h"
 #include "hw/arm/omap.h"
diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
index d6dfafab31..d606d3dbeb 100644
--- a/hw/i2c/ppc4xx_i2c.c
+++ b/hw/i2c/ppc4xx_i2c.c
@@ -25,8 +25,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/i2c/ppc4xx_i2c.h"
diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
index 251d3d142f..51a03046a6 100644
--- a/hw/i2c/smbus_ich9.c
+++ b/hw/i2c/smbus_ich9.c
@@ -19,10 +19,12 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/i2c/pm_smbus.h"
 #include "hw/pci/pci.h"
+#include "qemu/module.h"
 #include "sysemu/sysemu.h"
 
 #include "hw/i386/ich9.h"
diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index 9a2d314d1a..a9908c1a9b 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -17,6 +17,7 @@
 #include "hw/hw.h"
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/smbus_slave.h"
+#include "qemu/module.h"
 
 //#define DEBUG_SMBUS 1
 
diff --git a/hw/i2c/versatile_i2c.c b/hw/i2c/versatile_i2c.c
index da9f298ee5..e07be9890c 100644
--- a/hw/i2c/versatile_i2c.c
+++ b/hw/i2c/versatile_i2c.c
@@ -25,6 +25,7 @@
 #include "hw/sysbus.h"
 #include "bitbang_i2c.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #define TYPE_VERSATILE_I2C "versatile_i2c"
 #define VERSATILE_I2C(obj) \
diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index 1df6d26816..91fb622d63 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -9,8 +9,9 @@
  * This work is licensed under the terms of the GNU GPL version 2.
  * See the COPYING file in the top-level directory.
  */
+
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "cpu.h"
 #include "hw/i386/apic_internal.h"
 #include "hw/pci/msi.h"
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 25ea783bec..a5cda15b85 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -14,9 +14,9 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "qemu/host-utils.h"
+#include "qemu/module.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "sysemu/hw_accel.h"
diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index d4d4a859f0..c29956ab77 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include <linux/kvm.h>
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "hw/timer/i8254.h"
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 83b6bfec77..bfdeab29be 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -9,8 +9,10 @@
  * This work is licensed under the terms of the GNU GPL version 2.
  * See the COPYING file in the top-level directory.
  */
+
 #include "qemu/osdep.h"
 #include "hw/isa/i8259_internal.h"
+#include "qemu/module.h"
 #include "hw/i386/apic_internal.h"
 #include "sysemu/kvm.h"
 
diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
index 70f6f26a94..142cc52d19 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/kvmvapic.c
@@ -8,8 +8,9 @@
  * (at your option) any later version. See the COPYING file in the
  * top-level directory.
  */
+
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "cpu.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/cpus.h"
diff --git a/hw/i386/xen/xen_apic.c b/hw/i386/xen/xen_apic.c
index 55769eba7e..7c7a60b166 100644
--- a/hw/i386/xen/xen_apic.c
+++ b/hw/i386/xen/xen_apic.c
@@ -9,10 +9,12 @@
  * This work is licensed under the terms of the GNU GPL version 2 or
  * later. See the COPYING file in the top-level directory.
  */
+
 #include "qemu/osdep.h"
 #include "hw/i386/apic_internal.h"
 #include "hw/pci/msi.h"
 #include "hw/xen/xen.h"
+#include "qemu/module.h"
 
 static uint64_t xen_apic_mem_read(void *opaque, hwaddr addr,
                                   unsigned size)
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index 16afb54fee..7a972e46cf 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -35,6 +35,7 @@
 #include "exec/address-spaces.h"
 #include "sysemu/block-backend.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 
 #include <xenguest.h>
 
diff --git a/hw/i386/xen/xen_pvdevice.c b/hw/i386/xen/xen_pvdevice.c
index a146f1883a..23748f36a2 100644
--- a/hw/i386/xen/xen_pvdevice.c
+++ b/hw/i386/xen/xen_pvdevice.c
@@ -31,6 +31,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "trace.h"
diff --git a/hw/ide/ahci-allwinner.c b/hw/ide/ahci-allwinner.c
index f98e6cb3d4..de08d87790 100644
--- a/hw/ide/ahci-allwinner.c
+++ b/hw/ide/ahci-allwinner.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "sysemu/dma.h"
 #include "hw/ide/internal.h"
 #include "ahci_internal.h"
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index d700ca973b..00ba422a48 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -28,6 +28,7 @@
 
 #include "qemu/error-report.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/dma.h"
 #include "hw/ide/internal.h"
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 5a5679134a..ed23aabf21 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -22,9 +22,11 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
+#include "qemu/module.h"
 #include "hw/isa/isa.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/dma.h"
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index 51c935a0da..c1ba927574 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -64,6 +64,7 @@
 #include "hw/hw.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/pci.h"
+#include "qemu/module.h"
 #include "hw/isa/isa.h"
 #include "sysemu/dma.h"
 #include "hw/ide/pci.h"
diff --git a/hw/ide/isa.c b/hw/ide/isa.c
index 028bd61774..4b5784e3fd 100644
--- a/hw/ide/isa.c
+++ b/hw/ide/isa.c
@@ -22,9 +22,11 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/isa/isa.h"
+#include "qemu/module.h"
 #include "sysemu/dma.h"
 
 #include "hw/ide/internal.h"
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index bab8c45a43..54571fed12 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -22,10 +22,12 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/ppc/mac.h"
 #include "hw/ppc/mac_dbdma.h"
+#include "qemu/module.h"
 #include "hw/misc/macio/macio.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/dma.h"
diff --git a/hw/ide/microdrive.c b/hw/ide/microdrive.c
index 34bb98dce8..92ee6e0af8 100644
--- a/hw/ide/microdrive.c
+++ b/hw/ide/microdrive.c
@@ -22,9 +22,11 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pcmcia.h"
+#include "qemu/module.h"
 #include "sysemu/dma.h"
 
 #include "hw/ide/internal.h"
diff --git a/hw/ide/mmio.c b/hw/ide/mmio.c
index 42fcf139ee..70a58016d0 100644
--- a/hw/ide/mmio.c
+++ b/hw/ide/mmio.c
@@ -22,9 +22,11 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
+#include "qemu/module.h"
 #include "sysemu/dma.h"
 
 #include "hw/ide/internal.h"
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index 942613a9a9..4c6fb9a68e 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -22,11 +22,13 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "sysemu/dma.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "hw/ide/pci.h"
 #include "trace.h"
 
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index 885c16e938..b97e555072 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
+#include "qemu/module.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/blockdev.h"
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 573b022e1e..8b576ebb26 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -16,11 +16,13 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "sysemu/dma.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "hw/ide/internal.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index 59db09cfe4..d7590d4ba4 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -14,6 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/ide/pci.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 #define TYPE_SII3112_PCI "sii3112"
diff --git a/hw/ide/via.c b/hw/ide/via.c
index ac9385228c..c3bda909f9 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -23,9 +23,11 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
+#include "qemu/module.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/dma.h"
 
diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index b026e9d49f..da361f56df 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -21,8 +21,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/input/adb.h"
+#include "qemu/module.h"
 #include "ui/input.h"
 #include "hw/input/adb-keys.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
index 83833b0035..52526fddb7 100644
--- a/hw/input/adb-mouse.c
+++ b/hw/input/adb-mouse.c
@@ -21,9 +21,11 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "ui/console.h"
 #include "hw/input/adb.h"
+#include "qemu/module.h"
 #include "adb-internal.h"
 #include "trace.h"
 
diff --git a/hw/input/adb.c b/hw/input/adb.c
index bbb40aeef1..1446f32521 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -21,8 +21,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/input/adb.h"
+#include "qemu/module.h"
 #include "adb-internal.h"
 
 /* error codes */
diff --git a/hw/input/lm832x.c b/hw/input/lm832x.c
index 1fc7b86f19..5203da2bcf 100644
--- a/hw/input/lm832x.c
+++ b/hw/input/lm832x.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/i2c/i2c.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "ui/console.h"
 
diff --git a/hw/input/milkymist-softusb.c b/hw/input/milkymist-softusb.c
index 8766a17d9e..f779cd4370 100644
--- a/hw/input/milkymist-softusb.c
+++ b/hw/input/milkymist-softusb.c
@@ -29,6 +29,7 @@
 #include "ui/console.h"
 #include "hw/input/hid.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 
 enum {
     R_CTRL = 0,
diff --git a/hw/input/pl050.c b/hw/input/pl050.c
index 15bffbfcad..b79bf1647d 100644
--- a/hw/input/pl050.c
+++ b/hw/input/pl050.c
@@ -11,6 +11,7 @@
 #include "hw/sysbus.h"
 #include "hw/input/ps2.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #define TYPE_PL050 "pl050"
 #define PL050(obj) OBJECT_CHECK(PL050State, (obj), TYPE_PL050)
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index bc5f9a2ed2..f15a063fac 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -6,6 +6,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/iov.h"
+#include "qemu/module.h"
 
 #include "hw/qdev.h"
 #include "hw/virtio/virtio.h"
diff --git a/hw/input/virtio-input-host.c b/hw/input/virtio-input-host.c
index cb79e80024..a54c31eb09 100644
--- a/hw/input/virtio-input-host.c
+++ b/hw/input/virtio-input-host.c
@@ -6,7 +6,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "qemu/sockets.h"
 
 #include "hw/qdev.h"
diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index 0e42f0d02c..9946394cf4 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -7,6 +7,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/iov.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 #include "hw/qdev.h"
diff --git a/hw/intc/allwinner-a10-pic.c b/hw/intc/allwinner-a10-pic.c
index 1aa628cbbb..080bdd791f 100644
--- a/hw/intc/allwinner-a10-pic.c
+++ b/hw/intc/allwinner-a10-pic.c
@@ -20,6 +20,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/intc/allwinner-a10-pic.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 static void aw_a10_pic_update(AwA10PICState *s)
 {
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 78903ea909..e764a2bb03 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -17,10 +17,11 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>
  */
+
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "qapi/visitor.h"
 #include "hw/i386/apic.h"
diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index b3ac2d11fc..77427a4188 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -24,6 +24,7 @@
 #include "qapi/error.h"
 #include "qom/cpu.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "trace.h"
 #include "sysemu/kvm.h"
 
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index 57569a4e59..ccc50d00b6 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "gic_internal.h"
 #include "hw/arm/linux-boot-if.h"
 
diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
index a611e8ee12..b56fda144f 100644
--- a/hw/intc/arm_gic_kvm.c
+++ b/hw/intc/arm_gic_kvm.c
@@ -21,7 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "migration/blocker.h"
diff --git a/hw/intc/arm_gicv2m.c b/hw/intc/arm_gicv2m.c
index 3922fbc1c1..05f299fc7f 100644
--- a/hw/intc/arm_gicv2m.c
+++ b/hw/intc/arm_gicv2m.c
@@ -31,6 +31,7 @@
 #include "hw/pci/msi.h"
 #include "sysemu/kvm.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #define TYPE_ARM_GICV2M "arm-gicv2m"
 #define ARM_GICV2M(obj) OBJECT_CHECK(ARMGICv2mState, (obj), TYPE_ARM_GICV2M)
diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
index 7044133e2d..66eaa97198 100644
--- a/hw/intc/arm_gicv3.c
+++ b/hw/intc/arm_gicv3.c
@@ -17,6 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "hw/intc/arm_gicv3.h"
 #include "gicv3_internal.h"
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 52480c3b4c..5edabb928f 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -23,6 +23,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "qom/cpu.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "gicv3_internal.h"
diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
index 284c0a7584..efb3d51fb5 100644
--- a/hw/intc/arm_gicv3_its_common.c
+++ b/hw/intc/arm_gicv3_its_common.c
@@ -22,6 +22,7 @@
 #include "hw/pci/msi.h"
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 static int gicv3_its_pre_save(void *opaque)
 {
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 01573abb48..52ac01aba3 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 1e11200fe2..d9c72f85be 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -24,6 +24,7 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/sysbus.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
 #include "kvm_arm.h"
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 3a346a682a..d3eb41bc93 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -12,7 +12,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
@@ -21,6 +20,7 @@
 #include "target/arm/cpu.h"
 #include "exec/exec-all.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 /* IRQ number counting:
diff --git a/hw/intc/aspeed_vic.c b/hw/intc/aspeed_vic.c
index 2370e7485f..927638d532 100644
--- a/hw/intc/aspeed_vic.c
+++ b/hw/intc/aspeed_vic.c
@@ -31,6 +31,7 @@
 #include "hw/intc/aspeed_vic.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 #define AVIC_NEW_BASE_OFFSET 0x80
diff --git a/hw/intc/bcm2835_ic.c b/hw/intc/bcm2835_ic.c
index 00d25306fd..61d37643a1 100644
--- a/hw/intc/bcm2835_ic.c
+++ b/hw/intc/bcm2835_ic.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "hw/intc/bcm2835_ic.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #define GPU_IRQS 64
 #define ARM_IRQS 8
diff --git a/hw/intc/bcm2836_control.c b/hw/intc/bcm2836_control.c
index 421469f2ef..66417c85e4 100644
--- a/hw/intc/bcm2836_control.c
+++ b/hw/intc/bcm2836_control.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "hw/intc/bcm2836_control.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #define REG_GPU_ROUTE           0x0c
 #define REG_LOCALTIMERROUTING   0x24
diff --git a/hw/intc/etraxfs_pic.c b/hw/intc/etraxfs_pic.c
index 1bfde2f09e..20e1391d64 100644
--- a/hw/intc/etraxfs_pic.c
+++ b/hw/intc/etraxfs_pic.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "qemu/module.h"
 #include "hw/hw.h"
 //#include "pc.h"
 //#include "etraxfs.h"
diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.c
index f19a7062be..6fed0e8d16 100644
--- a/hw/intc/exynos4210_combiner.c
+++ b/hw/intc/exynos4210_combiner.c
@@ -29,6 +29,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "qemu/module.h"
 
 #include "hw/arm/exynos4210.h"
 
diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
index 69f9c18d73..e37d457fcf 100644
--- a/hw/intc/exynos4210_gic.c
+++ b/hw/intc/exynos4210_gic.c
@@ -22,7 +22,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "hw/irq.h"
 #include "hw/arm/exynos4210.h"
 
diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index 20accb6c4d..21c77a5ec1 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -32,6 +32,7 @@
 
 #include "trace.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 
 #define IRQMP_MAX_CPU 16
 #define IRQMP_REG_SIZE 256      /* Size of memory mapped registers */
diff --git a/hw/intc/heathrow_pic.c b/hw/intc/heathrow_pic.c
index b8b997deca..c282ac4006 100644
--- a/hw/intc/heathrow_pic.c
+++ b/hw/intc/heathrow_pic.c
@@ -22,9 +22,11 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/ppc/mac.h"
+#include "qemu/module.h"
 #include "hw/intc/heathrow_pic.h"
 #include "trace.h"
 
diff --git a/hw/intc/imx_avic.c b/hw/intc/imx_avic.c
index 813e587a63..83a4101528 100644
--- a/hw/intc/imx_avic.c
+++ b/hw/intc/imx_avic.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "hw/intc/imx_avic.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #ifndef DEBUG_IMX_AVIC
 #define DEBUG_IMX_AVIC 0
diff --git a/hw/intc/imx_gpcv2.c b/hw/intc/imx_gpcv2.c
index 4eb9ce2668..a83333bdea 100644
--- a/hw/intc/imx_gpcv2.c
+++ b/hw/intc/imx_gpcv2.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "hw/intc/imx_gpcv2.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #define GPC_PU_PGC_SW_PUP_REQ       0x0f8
 #define GPC_PU_PGC_SW_PDN_REQ       0x104
diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
index 692dc37bb6..fa50382d43 100644
--- a/hw/intc/ioapic_common.c
+++ b/hw/intc/ioapic_common.c
@@ -21,6 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "monitor/monitor.h"
 #include "hw/i386/ioapic.h"
 #include "hw/i386/ioapic_internal.h"
diff --git a/hw/intc/lm32_pic.c b/hw/intc/lm32_pic.c
index db6c7afc2f..170fa7a1ac 100644
--- a/hw/intc/lm32_pic.c
+++ b/hw/intc/lm32_pic.c
@@ -21,6 +21,7 @@
 
 #include "hw/hw.h"
 #include "monitor/monitor.h"
+#include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "trace.h"
 #include "hw/lm32/lm32_pic.h"
diff --git a/hw/intc/mips_gic.c b/hw/intc/mips_gic.c
index 15e6e40f9f..1c5ab8fe6d 100644
--- a/hw/intc/mips_gic.c
+++ b/hw/intc/mips_gic.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
diff --git a/hw/intc/nios2_iic.c b/hw/intc/nios2_iic.c
index 016426f964..7329434b91 100644
--- a/hw/intc/nios2_iic.c
+++ b/hw/intc/nios2_iic.c
@@ -19,7 +19,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 
 #include "hw/sysbus.h"
diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
index 6844c1aa83..053e67c66b 100644
--- a/hw/intc/omap_intc.c
+++ b/hw/intc/omap_intc.c
@@ -17,11 +17,13 @@
  * You should have received a copy of the GNU General Public License along
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/arm/omap.h"
 #include "hw/sysbus.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 
 /* Interrupt Handlers */
diff --git a/hw/intc/ompic.c b/hw/intc/ompic.c
index c0e34d1268..9cb310a5dd 100644
--- a/hw/intc/ompic.c
+++ b/hw/intc/ompic.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 811cee9b26..9b4fc6cf43 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -33,6 +33,7 @@
  * Serial interrupts, as implemented in Raven chipset are not supported yet.
  *
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/ppc/mac.h"
@@ -45,6 +46,7 @@
 #include "qemu/bitops.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
 
diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
index 928bc04a4e..49fc6fa0cf 100644
--- a/hw/intc/openpic_kvm.c
+++ b/hw/intc/openpic_kvm.c
@@ -24,7 +24,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include <sys/ioctl.h>
 #include "exec/address-spaces.h"
@@ -35,6 +34,7 @@
 #include "hw/sysbus.h"
 #include "sysemu/kvm.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #define GCR_RESET        0x80000000
 
diff --git a/hw/intc/pl190.c b/hw/intc/pl190.c
index 55ea15de76..b4f31efc45 100644
--- a/hw/intc/pl190.c
+++ b/hw/intc/pl190.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 /* The number of virtual priority levels.  16 user vectors plus the
    unvectored IRQ.  Chained interrupts would require an additional level
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index bb0877cbdf..a55c2bbc88 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "target/ppc/cpu.h"
 #include "sysemu/cpus.h"
diff --git a/hw/intc/puv3_intc.c b/hw/intc/puv3_intc.c
index 69ddc8c19a..e2f6d9875a 100644
--- a/hw/intc/puv3_intc.c
+++ b/hw/intc/puv3_intc.c
@@ -8,11 +8,13 @@
  * published by the Free Software Foundation, or any later version.
  * See the COPYING file in the top-level directory.
  */
+
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 
 #undef DEBUG_PUV3
 #include "hw/unicore32/puv3.h"
+#include "qemu/module.h"
 
 #define TYPE_PUV3_INTC "puv3_intc"
 #define PUV3_INTC(obj) OBJECT_CHECK(PUV3INTCState, (obj), TYPE_PUV3_INTC)
diff --git a/hw/intc/realview_gic.c b/hw/intc/realview_gic.c
index 7f2ff85c83..99557544db 100644
--- a/hw/intc/realview_gic.c
+++ b/hw/intc/realview_gic.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/intc/realview_gic.h"
 
 static void realview_gic_set_irq(void *opaque, int irq, int level)
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 5f8168f0f0..d0be755c82 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "hw/s390x/ioinst.h"
 #include "hw/s390x/s390_flic.h"
diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index a03df37560..ff45b4ab0b 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -11,11 +11,11 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "kvm_s390x.h"
 #include <sys/ioctl.h>
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "sysemu/kvm.h"
diff --git a/hw/intc/slavio_intctl.c b/hw/intc/slavio_intctl.c
index 817e02617e..ca528753bf 100644
--- a/hw/intc/slavio_intctl.c
+++ b/hw/intc/slavio_intctl.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
+#include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "hw/intc/intc.h"
 #include "trace.h"
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 097f88d460..dc635f0e79 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "target/ppc/cpu.h"
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index af7dc709ab..a9af8704aa 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -27,13 +27,13 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "trace.h"
 #include "qemu/timer.h"
 #include "hw/ppc/xics.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qapi/visitor.h"
 #include "monitor/monitor.h"
 #include "hw/intc/intc.h"
diff --git a/hw/intc/xics_pnv.c b/hw/intc/xics_pnv.c
index fa48505f36..67f2702e52 100644
--- a/hw/intc/xics_pnv.c
+++ b/hw/intc/xics_pnv.c
@@ -21,6 +21,7 @@
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/ppc/xics.h"
 
 #define ICP_XIRR_POLL    0 /* 1 byte (CPRR) or 4 bytes */
diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
index 9d8139bc6d..d5363e977f 100644
--- a/hw/intc/xilinx_intc.c
+++ b/hw/intc/xilinx_intc.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "qemu/module.h"
 #include "hw/hw.h"
 
 #define D(x)
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index a0b87001da..3ede5b33fd 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "target/ppc/cpu.h"
 #include "sysemu/cpus.h"
diff --git a/hw/intc/xlnx-pmu-iomod-intc.c b/hw/intc/xlnx-pmu-iomod-intc.c
index 59235351ba..0b8ff897dc 100644
--- a/hw/intc/xlnx-pmu-iomod-intc.c
+++ b/hw/intc/xlnx-pmu-iomod-intc.c
@@ -29,6 +29,7 @@
 #include "hw/register.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/intc/xlnx-pmu-iomod-intc.h"
 
 #ifndef XLNX_PMU_IO_INTC_ERR_DEBUG
diff --git a/hw/intc/xlnx-zynqmp-ipi.c b/hw/intc/xlnx-zynqmp-ipi.c
index aa50a8ac08..0dad6c04f5 100644
--- a/hw/intc/xlnx-zynqmp-ipi.c
+++ b/hw/intc/xlnx-zynqmp-ipi.c
@@ -30,6 +30,7 @@
 #include "hw/register.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/intc/xlnx-zynqmp-ipi.h"
 
 #ifndef XLNX_ZYNQMP_IPI_ERR_DEBUG
diff --git a/hw/ipack/ipack.c b/hw/ipack/ipack.c
index 6021e6d135..6b1b72f94d 100644
--- a/hw/ipack/ipack.c
+++ b/hw/ipack/ipack.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/ipack/ipack.h"
 
 IPackDevice *ipack_device_find(IPackBus *bus, int32_t slot)
diff --git a/hw/ipack/tpci200.c b/hw/ipack/tpci200.c
index cd3e79139d..d4d85107d0 100644
--- a/hw/ipack/tpci200.c
+++ b/hw/ipack/tpci200.c
@@ -13,6 +13,7 @@
 #include "hw/ipack/ipack.h"
 #include "hw/pci/pci.h"
 #include "qemu/bitops.h"
+#include "qemu/module.h"
 
 /* #define DEBUG_TPCI */
 
diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index 63c031703d..a837f91782 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -30,6 +30,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/visitor.h"
+#include "qemu/module.h"
 
 static uint32_t ipmi_current_uuid = 1;
 
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index bf0b7ee0f5..c0a8dac346 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -29,6 +29,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "chardev/char-fe.h"
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 9b509f829b..1980536517 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -27,6 +27,7 @@
 #include "qemu/timer.h"
 #include "hw/ipmi/ipmi.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "hw/loader.h"
 
 #define IPMI_NETFN_CHASSIS            0x00
diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index 8bbb1fa785..1846d5b9a4 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -21,8 +21,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/ipmi/ipmi.h"
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index a79431554a..068f341256 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -21,8 +21,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/ipmi/ipmi.h"
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 63fa77effc..388800603b 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -16,8 +16,10 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "monitor/monitor.h"
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index d54463bf03..4c73c2100f 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -9,8 +9,10 @@
  * See the COPYING file in the top-level directory.
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
+
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/blockdev.h"
diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index 5cf64505fe..85dbc94439 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -27,6 +27,7 @@
 #include "hw/isa/pc87312.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 
diff --git a/hw/isa/smc37c669-superio.c b/hw/isa/smc37c669-superio.c
index 64466a9373..901a9f8e65 100644
--- a/hw/isa/smc37c669-superio.c
+++ b/hw/isa/smc37c669-superio.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/isa/superio.h"
+#include "qemu/module.h"
 
 /* UARTs (compatible with NS16450 or PC16550) */
 
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 85d0532dd5..7832e220f8 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -23,6 +23,7 @@
 #include "hw/acpi/acpi.h"
 #include "hw/i2c/pm_smbus.h"
 #include "sysemu/sysemu.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "exec/address-spaces.h"
 
diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index 393ce284a2..a613aed820 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -5,8 +5,9 @@
  *
  * This code is licensed under the GPL
  */
+
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index bf2adf5e16..f438abb387 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/module.h"
 #include "qemu/pmem.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 152400b1fc..b1239fd0d3 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -24,6 +24,7 @@
 #include "hw/mem/memory-device.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
+#include "qemu/module.h"
 #include "sysemu/numa.h"
 #include "trace.h"
 
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index fc97f59af4..65dd23ce96 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/mips/cps.h"
 #include "hw/mips/mips.h"
 #include "hw/mips/cpudevs.h"
diff --git a/hw/misc/a9scu.c b/hw/misc/a9scu.c
index 3e8ad8cd73..4307f0082b 100644
--- a/hw/misc/a9scu.c
+++ b/hw/misc/a9scu.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/misc/a9scu.h"
+#include "qemu/module.h"
 
 static uint64_t a9_scu_read(void *opaque, hwaddr offset,
                             unsigned size)
diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 7be8b5f13c..2d7eb3c7e2 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -34,6 +34,7 @@
 #include "hw/hw.h"
 #include "hw/isa/isa.h"
 #include "ui/console.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 
 /* #define DEBUG_SMC */
diff --git a/hw/misc/arm11scu.c b/hw/misc/arm11scu.c
index 7042ce11e8..84275df885 100644
--- a/hw/misc/arm11scu.c
+++ b/hw/misc/arm11scu.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "hw/misc/arm11scu.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 static uint64_t mpcore_scu_read(void *opaque, hwaddr offset,
                                 unsigned size)
diff --git a/hw/misc/arm_integrator_debug.c b/hw/misc/arm_integrator_debug.c
index 533e6e3208..2646107b97 100644
--- a/hw/misc/arm_integrator_debug.c
+++ b/hw/misc/arm_integrator_debug.c
@@ -19,6 +19,7 @@
 #include "hw/sysbus.h"
 #include "hw/misc/arm_integrator_debug.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #define INTEGRATOR_DEBUG(obj) \
     OBJECT_CHECK(IntegratorDebugState, (obj), TYPE_INTEGRATOR_DEBUG)
diff --git a/hw/misc/arm_l2x0.c b/hw/misc/arm_l2x0.c
index 66a0787c47..b88f40ae7e 100644
--- a/hw/misc/arm_l2x0.c
+++ b/hw/misc/arm_l2x0.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 /* L2C-310 r3p2 */
 #define CACHE_ID 0x410000c8
diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index b20b44ea20..457dfadfab 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -15,6 +15,7 @@
 #include "hw/arm/primecell.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #define LOCK_VALUE 0xa05f
 
diff --git a/hw/misc/armsse-cpuid.c b/hw/misc/armsse-cpuid.c
index 7788f6ced6..05c08f3db5 100644
--- a/hw/misc/armsse-cpuid.c
+++ b/hw/misc/armsse-cpuid.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "trace.h"
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/misc/armsse-mhu.c b/hw/misc/armsse-mhu.c
index 9ebca32e9a..514321a9ec 100644
--- a/hw/misc/armsse-mhu.c
+++ b/hw/misc/armsse-mhu.c
@@ -17,6 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "trace.h"
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index c8217740ef..924da189d7 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -16,6 +16,7 @@
 #include "qapi/visitor.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "crypto/random.h"
 #include "trace.h"
 
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index eec77f2435..b84676d36d 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "hw/misc/aspeed_sdmc.h"
 #include "hw/misc/aspeed_scu.h"
diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index 0e56d9a8a4..f8e7b97971 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -29,6 +29,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/misc/auxbus.h"
 #include "hw/i2c/i2c.h"
 #include "monitor/monitor.h"
diff --git a/hw/misc/bcm2835_mbox.c b/hw/misc/bcm2835_mbox.c
index e97cc814af..a87da5ee53 100644
--- a/hw/misc/bcm2835_mbox.c
+++ b/hw/misc/bcm2835_mbox.c
@@ -12,6 +12,7 @@
 #include "qapi/error.h"
 #include "hw/misc/bcm2835_mbox.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #define MAIL0_PEEK   0x90
 #define MAIL0_SENDER 0x94
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 145427ae0f..0bf789cf60 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -9,6 +9,7 @@
 #include "hw/misc/bcm2835_mbox_defs.h"
 #include "sysemu/dma.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 /* https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface */
 
diff --git a/hw/misc/bcm2835_rng.c b/hw/misc/bcm2835_rng.c
index 4d62143b24..0873acbc2c 100644
--- a/hw/misc/bcm2835_rng.c
+++ b/hw/misc/bcm2835_rng.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "crypto/random.h"
 #include "hw/misc/bcm2835_rng.h"
diff --git a/hw/misc/debugexit.c b/hw/misc/debugexit.c
index bed293247e..8e4a2fc701 100644
--- a/hw/misc/debugexit.c
+++ b/hw/misc/debugexit.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/isa/isa.h"
+#include "qemu/module.h"
 
 #define TYPE_ISA_DEBUG_EXIT_DEVICE "isa-debug-exit"
 #define ISA_DEBUG_EXIT_DEVICE(obj) \
diff --git a/hw/misc/eccmemctl.c b/hw/misc/eccmemctl.c
index bb7cc52b5e..8386db07df 100644
--- a/hw/misc/eccmemctl.c
+++ b/hw/misc/eccmemctl.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 /* There are 3 versions of this chip used in SMP sun4m systems:
diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 91af452c9e..a305d4f883 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -28,6 +28,7 @@
 #include "hw/pci/msi.h"
 #include "qemu/timer.h"
 #include "qemu/main-loop.h" /* iothread mutex */
+#include "qemu/module.h"
 #include "qapi/visitor.h"
 
 #define TYPE_PCI_EDU_DEVICE "edu"
diff --git a/hw/misc/exynos4210_clk.c b/hw/misc/exynos4210_clk.c
index 81862c0ada..821d9eab3f 100644
--- a/hw/misc/exynos4210_clk.c
+++ b/hw/misc/exynos4210_clk.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #define TYPE_EXYNOS4210_CLK             "exynos4210.clk"
 #define EXYNOS4210_CLK(obj) \
diff --git a/hw/misc/exynos4210_pmu.c b/hw/misc/exynos4210_pmu.c
index 0d7b64c5b3..8712774768 100644
--- a/hw/misc/exynos4210_pmu.c
+++ b/hw/misc/exynos4210_pmu.c
@@ -26,6 +26,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "qemu/module.h"
 #include "sysemu/sysemu.h"
 
 #ifndef DEBUG_PMU
diff --git a/hw/misc/exynos4210_rng.c b/hw/misc/exynos4210_rng.c
index 4ecbebd2d7..7a3539ee95 100644
--- a/hw/misc/exynos4210_rng.c
+++ b/hw/misc/exynos4210_rng.c
@@ -22,6 +22,7 @@
 #include "hw/sysbus.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #define DEBUG_EXYNOS_RNG 0
 
diff --git a/hw/misc/imx25_ccm.c b/hw/misc/imx25_ccm.c
index 19e948a52d..693ea81040 100644
--- a/hw/misc/imx25_ccm.c
+++ b/hw/misc/imx25_ccm.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "hw/misc/imx25_ccm.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #ifndef DEBUG_IMX25_CCM
 #define DEBUG_IMX25_CCM 0
diff --git a/hw/misc/imx2_wdt.c b/hw/misc/imx2_wdt.c
index e47e442592..5576778a32 100644
--- a/hw/misc/imx2_wdt.c
+++ b/hw/misc/imx2_wdt.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
+#include "qemu/module.h"
 #include "sysemu/watchdog.h"
 
 #include "hw/misc/imx2_wdt.h"
diff --git a/hw/misc/imx31_ccm.c b/hw/misc/imx31_ccm.c
index b890c383be..38a19aa0d0 100644
--- a/hw/misc/imx31_ccm.c
+++ b/hw/misc/imx31_ccm.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "hw/misc/imx31_ccm.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #define CKIH_FREQ 26000000 /* 26MHz crystal input */
 
diff --git a/hw/misc/imx6_ccm.c b/hw/misc/imx6_ccm.c
index 4fa94835fe..9478007f41 100644
--- a/hw/misc/imx6_ccm.c
+++ b/hw/misc/imx6_ccm.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "hw/misc/imx6_ccm.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #ifndef DEBUG_IMX6_CCM
 #define DEBUG_IMX6_CCM 0
diff --git a/hw/misc/imx6_src.c b/hw/misc/imx6_src.c
index cfb08710fb..878ffcdc71 100644
--- a/hw/misc/imx6_src.c
+++ b/hw/misc/imx6_src.c
@@ -13,6 +13,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "arm-powerctl.h"
 #include "qom/cpu.h"
 
diff --git a/hw/misc/imx6ul_ccm.c b/hw/misc/imx6ul_ccm.c
index 90bc374271..37b472d125 100644
--- a/hw/misc/imx6ul_ccm.c
+++ b/hw/misc/imx6ul_ccm.c
@@ -14,6 +14,7 @@
 #include "hw/registerfields.h"
 #include "hw/misc/imx6ul_ccm.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #include "trace.h"
 
diff --git a/hw/misc/imx7_ccm.c b/hw/misc/imx7_ccm.c
index d90c48bfec..d9bdcf1027 100644
--- a/hw/misc/imx7_ccm.c
+++ b/hw/misc/imx7_ccm.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #include "hw/misc/imx7_ccm.h"
 
diff --git a/hw/misc/imx7_gpr.c b/hw/misc/imx7_gpr.c
index c2a9df29c6..09d57d4710 100644
--- a/hw/misc/imx7_gpr.c
+++ b/hw/misc/imx7_gpr.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "hw/misc/imx7_gpr.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "sysemu/sysemu.h"
 
 #include "trace.h"
diff --git a/hw/misc/imx7_snvs.c b/hw/misc/imx7_snvs.c
index 4df482b282..55b962a453 100644
--- a/hw/misc/imx7_snvs.c
+++ b/hw/misc/imx7_snvs.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "hw/misc/imx7_snvs.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "sysemu/sysemu.h"
 
 static uint64_t imx7_snvs_read(void *opaque, hwaddr offset, unsigned size)
diff --git a/hw/misc/imx_ccm.c b/hw/misc/imx_ccm.c
index 7f239a41d8..2f81b0ad73 100644
--- a/hw/misc/imx_ccm.c
+++ b/hw/misc/imx_ccm.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "hw/misc/imx_ccm.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #ifndef DEBUG_IMX_CCM
 #define DEBUG_IMX_CCM 0
diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index 537601cd53..58fd94b14f 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "trace.h"
 #include "hw/sysbus.h"
diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
index 54064a31ef..00d4faa6db 100644
--- a/hw/misc/iotkit-sysctl.c
+++ b/hw/misc/iotkit-sysctl.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "trace.h"
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/misc/iotkit-sysinfo.c b/hw/misc/iotkit-sysinfo.c
index 026ba94261..3e1cf0ec34 100644
--- a/hw/misc/iotkit-sysinfo.c
+++ b/hw/misc/iotkit-sysinfo.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "trace.h"
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index c7b6bbc974..f9cc66aba8 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -16,6 +16,7 @@
  * Contributions after 2012-01-13 are licensed under the terms of the
  * GNU GPL, version 2 or (at your option) any later version.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
@@ -28,6 +29,7 @@
 #include "migration/blocker.h"
 #include "qemu/error-report.h"
 #include "qemu/event_notifier.h"
+#include "qemu/module.h"
 #include "qom/object_interfaces.h"
 #include "chardev/char-fe.h"
 #include "sysemu/hostmem.h"
diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 3febacdd1e..5fd904b79d 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -22,6 +22,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/ppc/mac.h"
@@ -32,6 +33,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 /* Bits in B data register: all active low */
diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
index 9317df759c..31811ab513 100644
--- a/hw/misc/macio/gpio.c
+++ b/hw/misc/macio/gpio.c
@@ -30,6 +30,7 @@
 #include "hw/misc/macio/gpio.h"
 #include "hw/nmi.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 
diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
index e5917d8f2e..548625a5f0 100644
--- a/hw/misc/macio/mac_dbdma.c
+++ b/hw/misc/macio/mac_dbdma.c
@@ -36,10 +36,12 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/ppc/mac_dbdma.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 #include "qemu/log.h"
 #include "sysemu/dma.h"
 
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 94da85c8d7..eab319f1cb 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -22,8 +22,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/hw.h"
 #include "hw/ppc/mac.h"
 #include "hw/misc/macio/cuda.h"
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index 6e6d96c8c5..7201cf4f9a 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -39,6 +39,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 
diff --git a/hw/misc/max111x.c b/hw/misc/max111x.c
index ac6d35a81d..d373ece0c9 100644
--- a/hw/misc/max111x.c
+++ b/hw/misc/max111x.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/ssi/ssi.h"
+#include "qemu/module.h"
 
 typedef struct {
     SSISlave parent_obj;
diff --git a/hw/misc/milkymist-hpdmc.c b/hw/misc/milkymist-hpdmc.c
index 44dc0698ec..701c79e81c 100644
--- a/hw/misc/milkymist-hpdmc.c
+++ b/hw/misc/milkymist-hpdmc.c
@@ -26,6 +26,7 @@
 #include "hw/sysbus.h"
 #include "trace.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 
 enum {
     R_SYSTEM = 0,
diff --git a/hw/misc/milkymist-pfpu.c b/hw/misc/milkymist-pfpu.c
index 4a03c7ee63..1c27f1a4bc 100644
--- a/hw/misc/milkymist-pfpu.c
+++ b/hw/misc/milkymist-pfpu.c
@@ -27,6 +27,7 @@
 #include "hw/sysbus.h"
 #include "trace.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qemu/error-report.h"
 #include <math.h>
 
diff --git a/hw/misc/mips_cmgcr.c b/hw/misc/mips_cmgcr.c
index d019d41a3c..edec164605 100644
--- a/hw/misc/mips_cmgcr.c
+++ b/hw/misc/mips_cmgcr.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index 712d8423a7..446b1ad397 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -21,6 +21,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/sysbus.h"
 
 #include "hw/misc/mips_cpc.h"
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index 3afdbe69c6..e8ba4a3cd0 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 14cff26c61..e72ed69d51 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -23,6 +23,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/input/adb.h"
@@ -31,6 +32,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 /* XXX: implement all timer modes */
diff --git a/hw/misc/mps2-fpgaio.c b/hw/misc/mps2-fpgaio.c
index 5cf10ebd66..b97ad42d75 100644
--- a/hw/misc/mps2-fpgaio.c
+++ b/hw/misc/mps2-fpgaio.c
@@ -17,6 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "trace.h"
 #include "hw/sysbus.h"
diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 6a9d251f18..1fdf5d22bd 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "trace.h"
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
diff --git a/hw/misc/msf2-sysreg.c b/hw/misc/msf2-sysreg.c
index 6eb501104b..21a2863821 100644
--- a/hw/misc/msf2-sysreg.c
+++ b/hw/misc/msf2-sysreg.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/misc/msf2-sysreg.h"
 #include "qemu/error-report.h"
 #include "trace.h"
diff --git a/hw/misc/mst_fpga.c b/hw/misc/mst_fpga.c
index a10f0496fe..fd18303724 100644
--- a/hw/misc/mst_fpga.c
+++ b/hw/misc/mst_fpga.c
@@ -10,9 +10,11 @@
  * Contributions after 2012-01-13 are licensed under the terms of the
  * GNU GPL, version 2 or (at your option) any later version.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
+#include "qemu/module.h"
 
 /* Mainstone FPGA for extern irqs */
 #define FPGA_GPIO_PIN	0
diff --git a/hw/misc/nrf51_rng.c b/hw/misc/nrf51_rng.c
index d188f044f4..a21d318d55 100644
--- a/hw/misc/nrf51_rng.c
+++ b/hw/misc/nrf51_rng.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "hw/arm/nrf51.h"
 #include "hw/misc/nrf51_rng.h"
diff --git a/hw/misc/pc-testdev.c b/hw/misc/pc-testdev.c
index 0aee04f231..1f9abd52b8 100644
--- a/hw/misc/pc-testdev.c
+++ b/hw/misc/pc-testdev.c
@@ -38,6 +38,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/qdev.h"
+#include "qemu/module.h"
 #include "hw/isa/isa.h"
 
 #define IOMEM_LEN    0x10000
diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index 7325d3f287..3422397f89 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/hw.h"
 #include "hw/misc/pca9552.h"
 #include "hw/misc/pca9552_regs.h"
diff --git a/hw/misc/pci-testdev.c b/hw/misc/pci-testdev.c
index 1282d151cb..d4d89df4cf 100644
--- a/hw/misc/pci-testdev.c
+++ b/hw/misc/pci-testdev.c
@@ -17,10 +17,12 @@
  * You should have received a copy of the GNU General Public License along
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "qemu/event_notifier.h"
+#include "qemu/module.h"
 #include "sysemu/kvm.h"
 
 typedef struct PCITestDevHdr {
diff --git a/hw/misc/puv3_pm.c b/hw/misc/puv3_pm.c
index afe191fbe1..b538b4afbb 100644
--- a/hw/misc/puv3_pm.c
+++ b/hw/misc/puv3_pm.c
@@ -8,12 +8,14 @@
  * published by the Free Software Foundation, or any later version.
  * See the COPYING file in the top-level directory.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 
 #undef DEBUG_PUV3
 #include "hw/unicore32/puv3.h"
+#include "qemu/module.h"
 
 #define TYPE_PUV3_PM "puv3_pm"
 #define PUV3_PM(obj) OBJECT_CHECK(PUV3PMState, (obj), TYPE_PUV3_PM)
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 9d8961ba0c..1da24c621e 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #include "hw/nvram/fw_cfg.h"
 #include "hw/misc/pvpanic.h"
diff --git a/hw/misc/sga.c b/hw/misc/sga.c
index 4a22a52a60..da04924f5f 100644
--- a/hw/misc/sga.c
+++ b/hw/misc/sga.c
@@ -24,9 +24,11 @@
  * sgabios code originally available at code.google.com/p/sgabios
  *
  */
+
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
 #include "hw/loader.h"
+#include "qemu/module.h"
 #include "sysemu/sysemu.h"
 
 #define SGABIOS_FILENAME "sgabios.bin"
diff --git a/hw/misc/slavio_misc.c b/hw/misc/slavio_misc.c
index 0b33cdcb61..9c2cf04646 100644
--- a/hw/misc/slavio_misc.c
+++ b/hw/misc/slavio_misc.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 /*
diff --git a/hw/misc/stm32f2xx_syscfg.c b/hw/misc/stm32f2xx_syscfg.c
index 7f10195862..aa59b43549 100644
--- a/hw/misc/stm32f2xx_syscfg.c
+++ b/hw/misc/stm32f2xx_syscfg.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/misc/stm32f2xx_syscfg.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #ifndef STM_SYSCFG_ERR_DEBUG
 #define STM_SYSCFG_ERR_DEBUG 0
diff --git a/hw/misc/tmp105.c b/hw/misc/tmp105.c
index 0c32f6f8b6..19def5c20f 100644
--- a/hw/misc/tmp105.c
+++ b/hw/misc/tmp105.c
@@ -24,6 +24,7 @@
 #include "tmp105.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
+#include "qemu/module.h"
 
 static void tmp105_interrupt_update(TMP105State *s)
 {
diff --git a/hw/misc/tmp421.c b/hw/misc/tmp421.c
index ce6d40ac9c..69ee5db4b7 100644
--- a/hw/misc/tmp421.c
+++ b/hw/misc/tmp421.c
@@ -29,6 +29,7 @@
 #include "hw/i2c/i2c.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
+#include "qemu/module.h"
 
 /* Manufacturer / Device ID's */
 #define TMP421_MANUFACTURER_ID          0x55
diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
index 9a84be75ed..45a3e31c3d 100644
--- a/hw/misc/tz-mpc.c
+++ b/hw/misc/tz-mpc.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "trace.h"
 #include "hw/sysbus.h"
diff --git a/hw/misc/tz-msc.c b/hw/misc/tz-msc.c
index 9e352044ea..52b96ba70d 100644
--- a/hw/misc/tz-msc.c
+++ b/hw/misc/tz-msc.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "trace.h"
 #include "hw/sysbus.h"
diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
index 2e04837bea..2a14a26f29 100644
--- a/hw/misc/tz-ppc.c
+++ b/hw/misc/tz-ppc.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "trace.h"
 #include "hw/sysbus.h"
diff --git a/hw/misc/unimp.c b/hw/misc/unimp.c
index 1c0ba2f0a7..7f8e42cc2c 100644
--- a/hw/misc/unimp.c
+++ b/hw/misc/unimp.c
@@ -16,6 +16,7 @@
 #include "hw/sysbus.h"
 #include "hw/misc/unimp.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 
 static uint64_t unimp_read(void *opaque, hwaddr offset, unsigned size)
diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
index 304c6287c7..987d6f52af 100644
--- a/hw/misc/vmcoreinfo.c
+++ b/hw/misc/vmcoreinfo.c
@@ -9,8 +9,10 @@
  * See the COPYING file in the top-level directory.
  *
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/misc/vmcoreinfo.h"
 
diff --git a/hw/misc/zynq-xadc.c b/hw/misc/zynq-xadc.c
index 14906103c9..f1e48601dc 100644
--- a/hw/misc/zynq-xadc.c
+++ b/hw/misc/zynq-xadc.c
@@ -19,6 +19,7 @@
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 enum {
     CFG                = 0x000 / 4,
diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index d6bdd027ef..6b51ae5ff1 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -20,6 +20,7 @@
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #ifndef ZYNQ_SLCR_ERR_DEBUG
 #define ZYNQ_SLCR_ERR_DEBUG 0
diff --git a/hw/net/allwinner_emac.c b/hw/net/allwinner_emac.c
index 50e8361e52..eecda52800 100644
--- a/hw/net/allwinner_emac.c
+++ b/hw/net/allwinner_emac.c
@@ -16,12 +16,14 @@
  * GNU General Public License for more details.
  *
  */
+
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "qemu/fifo8.h"
 #include "hw/net/allwinner_emac.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include <zlib.h>
 
 static uint8_t padding[60];
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 7f63411430..d412085884 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -28,6 +28,7 @@
 #include "hw/net/cadence_gem.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "sysemu/dma.h"
 #include "net/checksum.h"
 
diff --git a/hw/net/can/can_kvaser_pci.c b/hw/net/can/can_kvaser_pci.c
index 5f82f4359a..df639f8fa0 100644
--- a/hw/net/can/can_kvaser_pci.c
+++ b/hw/net/can/can_kvaser_pci.c
@@ -31,6 +31,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/event_notifier.h"
+#include "qemu/module.h"
 #include "qemu/thread.h"
 #include "qemu/sockets.h"
 #include "qapi/error.h"
diff --git a/hw/net/can/can_mioe3680_pci.c b/hw/net/can/can_mioe3680_pci.c
index fd20b88955..7af0993d7a 100644
--- a/hw/net/can/can_mioe3680_pci.c
+++ b/hw/net/can/can_mioe3680_pci.c
@@ -27,6 +27,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/event_notifier.h"
+#include "qemu/module.h"
 #include "qemu/thread.h"
 #include "qemu/sockets.h"
 #include "qapi/error.h"
diff --git a/hw/net/can/can_pcm3680_pci.c b/hw/net/can/can_pcm3680_pci.c
index 23f7ff45a3..3f7312af07 100644
--- a/hw/net/can/can_pcm3680_pci.c
+++ b/hw/net/can/can_pcm3680_pci.c
@@ -27,6 +27,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/event_notifier.h"
+#include "qemu/module.h"
 #include "qemu/thread.h"
 #include "qemu/sockets.h"
 #include "qapi/error.h"
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 98cb4e58c7..bdb0b3b2c2 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -21,6 +21,7 @@
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include <zlib.h>
 
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 121452d508..1dc1466332 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -33,6 +33,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/dma.h"
 #include "qemu/iov.h"
+#include "qemu/module.h"
 #include "qemu/range.h"
 
 #include "e1000x_common.h"
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 510ddb3897..581f7d03d5 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -37,6 +37,7 @@
 #include "qemu/units.h"
 #include "net/net.h"
 #include "net/tap.h"
+#include "qemu/module.h"
 #include "qemu/range.h"
 #include "sysemu/sysemu.h"
 #include "hw/pci/msi.h"
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index e761daf551..6607c9142d 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -50,6 +50,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/dma.h"
 #include "qemu/bitops.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 
 /* QEMU sends frames smaller than 60 bytes to ethernet nics.
diff --git a/hw/net/etraxfs_eth.c b/hw/net/etraxfs_eth.c
index 36855804db..4cfbf1135a 100644
--- a/hw/net/etraxfs_eth.c
+++ b/hw/net/etraxfs_eth.c
@@ -28,6 +28,7 @@
 #include "net/net.h"
 #include "hw/cris/etraxfs.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 #define D(x)
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index 0b66274ce3..2a8b99a2e4 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -33,6 +33,7 @@
 #include "etsec.h"
 #include "registers.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 /* #define HEX_DUMP */
 /* #define DEBUG_REGISTER */
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 790430346b..eb760472e5 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -15,6 +15,7 @@
 #include "hw/net/ftgmac100.h"
 #include "sysemu/dma.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "net/checksum.h"
 #include "net/eth.h"
 #include "hw/net/mii.h"
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 6e297c5480..404154ebbf 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -25,6 +25,7 @@
 #include "hw/net/imx_fec.h"
 #include "sysemu/dma.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "net/checksum.h"
 #include "net/eth.h"
 
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index b29e3fee49..f6120be219 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -18,6 +18,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/ptimer.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 /* For crc32 */
 #include <zlib.h>
 
diff --git a/hw/net/lance.c b/hw/net/lance.c
index f987b2fd18..2978c01d58 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -36,6 +36,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/sparc/sparc32_dma.h"
 #include "hw/net/lance.h"
diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index 0091e4ecdd..78468fad6b 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -5,9 +5,11 @@
  *
  * This code is licensed under the GPL
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "net/net.h"
+#include "qemu/module.h"
 #include "hw/m68k/mcf.h"
 #include "hw/m68k/mcf_fec.h"
 #include "hw/net/mii.h"
diff --git a/hw/net/milkymist-minimac2.c b/hw/net/milkymist-minimac2.c
index 85c9fc0b65..41ef7a4456 100644
--- a/hw/net/milkymist-minimac2.c
+++ b/hw/net/milkymist-minimac2.c
@@ -24,13 +24,13 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h" /* FIXME: why does this use TARGET_PAGE_ALIGN? */
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "trace.h"
 #include "net/net.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qemu/error-report.h"
 
 #include <zlib.h>
diff --git a/hw/net/mipsnet.c b/hw/net/mipsnet.c
index 5ec13105df..c5fbd8431f 100644
--- a/hw/net/mipsnet.c
+++ b/hw/net/mipsnet.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "net/net.h"
+#include "qemu/module.h"
 #include "trace.h"
 #include "hw/sysbus.h"
 
diff --git a/hw/net/ne2000-isa.c b/hw/net/ne2000-isa.c
index c7fdeb0f6c..3490e54c5a 100644
--- a/hw/net/ne2000-isa.c
+++ b/hw/net/ne2000-isa.c
@@ -21,6 +21,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
 #include "hw/net/ne2000-isa.h"
@@ -29,6 +30,7 @@
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
+#include "qemu/module.h"
 
 #define ISA_NE2000(obj) OBJECT_CHECK(ISANE2000State, (obj), TYPE_ISA_NE2000)
 
diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
index ca792d96f1..1cf4b57341 100644
--- a/hw/net/ne2000.c
+++ b/hw/net/ne2000.c
@@ -21,8 +21,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "net/eth.h"
+#include "qemu/module.h"
 #include "ne2000.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index d6f54f8d82..a5abb8df46 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -36,6 +36,7 @@
 #include "hw/net/mii.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
+#include "qemu/module.h"
 #include "net/eth.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index 7c73855783..600d09ce92 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -30,6 +30,7 @@
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
 #include "net/net.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "sysemu/dma.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 5266f9b7dd..bd54612f2a 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -24,6 +24,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-rocker.h"
 #include "qemu/iov.h"
+#include "qemu/module.h"
 #include "qemu/bitops.h"
 
 #include "rocker.h"
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 2342a095e3..09273171e5 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -49,12 +49,14 @@
  */
 
 /* For crc32 */
+
 #include "qemu/osdep.h"
 #include <zlib.h>
 
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "sysemu/dma.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "net/net.h"
 #include "net/eth.h"
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index d19ea0750d..4a612eebe9 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -12,6 +12,7 @@
 #include "net/net.h"
 #include "hw/net/smc91c111.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 /* For crc32 */
 #include <zlib.h>
 
diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index 63ba3929e9..f162d49025 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -24,11 +24,12 @@
  * THE SOFTWARE.
  *
  */
+
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "net/net.h"
 #include "hw/qdev.h"
 #include "hw/ppc/spapr.h"
diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index b3375ebb45..2f645bfb71 100644
--- a/hw/net/stellaris_enet.c
+++ b/hw/net/stellaris_enet.c
@@ -6,10 +6,12 @@
  *
  * This code is licensed under the GPL.
  */
+
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include <zlib.h>
 
 //#define DEBUG_STELLARIS_ENET 1
diff --git a/hw/net/sungem.c b/hw/net/sungem.c
index 60f1e479f3..89bcf749d1 100644
--- a/hw/net/sungem.c
+++ b/hw/net/sungem.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "net/net.h"
 #include "net/eth.h"
 #include "net/checksum.h"
diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index 7558fca8f9..1ebaee3c82 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -27,6 +27,7 @@
 #include "hw/pci/pci.h"
 #include "hw/net/mii.h"
 #include "net/net.h"
+#include "qemu/module.h"
 #include "net/checksum.h"
 #include "net/eth.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index ffe0872fff..c3f5fccfd1 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/iov.h"
+#include "qemu/module.h"
 #include "hw/virtio/virtio.h"
 #include "net/net.h"
 #include "net/checksum.h"
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 4665dc95ad..10d01d0058 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -21,8 +21,8 @@
 #include "net/tap.h"
 #include "net/checksum.h"
 #include "sysemu/sysemu.h"
-#include "qemu-common.h"
 #include "qemu/bswap.h"
+#include "qemu/module.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/msi.h"
 #include "migration/register.h"
diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
index 63f5a62ebf..f49df95b07 100644
--- a/hw/net/xgmac.c
+++ b/hw/net/xgmac.c
@@ -27,6 +27,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "net/net.h"
 
 #ifdef DEBUG_XGMAC
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index cc880a3d08..feeaca680e 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -26,6 +26,7 @@
 #include "hw/sysbus.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "net/net.h"
 #include "net/checksum.h"
 
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 35de353b7c..8f3a8f8597 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "cpu.h" /* FIXME should not use tswap* */
 #include "hw/sysbus.h"
 #include "hw/hw.h"
diff --git a/hw/nvram/ds1225y.c b/hw/nvram/ds1225y.c
index b6ef463db0..fd49283f41 100644
--- a/hw/nvram/ds1225y.c
+++ b/hw/nvram/ds1225y.c
@@ -26,6 +26,7 @@
 #include "hw/sysbus.h"
 #include "trace.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 
 typedef struct {
     MemoryRegion iomem;
diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index d1456dafbd..f75a485738 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/hw.h"
 #include "hw/i2c/i2c.h"
 #include "sysemu/block-backend.h"
diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
index aef80e64df..a60426c469 100644
--- a/hw/nvram/mac_nvram.c
+++ b/hw/nvram/mac_nvram.c
@@ -22,11 +22,13 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/nvram/chrp_nvram.h"
 #include "hw/ppc/mac.h"
 #include "qemu/cutils.h"
+#include "qemu/module.h"
 #include <zlib.h>
 
 /* debug NVR */
diff --git a/hw/nvram/nrf51_nvm.c b/hw/nvram/nrf51_nvm.c
index 7d94cef1db..eca0cb35b5 100644
--- a/hw/nvram/nrf51_nvm.c
+++ b/hw/nvram/nrf51_nvm.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "exec/address-spaces.h"
 #include "hw/arm/nrf51.h"
 #include "hw/nvram/nrf51_nvm.h"
diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index c98c7576e6..09efd886bf 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -23,9 +23,9 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/module.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include <libfdt.h>
 
diff --git a/hw/pci-bridge/dec.c b/hw/pci-bridge/dec.c
index 8484bfd434..60ba4d5202 100644
--- a/hw/pci-bridge/dec.c
+++ b/hw/pci-bridge/dec.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "dec.h"
 #include "hw/sysbus.h"
+#include "qemu/module.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pci_bridge.h"
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index 26bda73eae..44acda7cb9 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pcie_port.h"
 
diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
index 10e590e5c6..f272b12a9c 100644
--- a/hw/pci-bridge/i82801b11.c
+++ b/hw/pci-bridge/i82801b11.c
@@ -43,6 +43,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
+#include "qemu/module.h"
 #include "hw/i386/ich9.h"
 
 /*****************************************************************************/
diff --git a/hw/pci-bridge/ioh3420.c b/hw/pci-bridge/ioh3420.c
index 81f2de6f07..310af04af9 100644
--- a/hw/pci-bridge/ioh3420.c
+++ b/hw/pci-bridge/ioh3420.c
@@ -25,6 +25,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
+#include "qemu/module.h"
 
 #define PCI_DEVICE_ID_IOH_EPORT         0x3420  /* D0:F0 express mode */
 #define PCI_DEVICE_ID_IOH_REV           0x2
diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index ff6b8323da..89ac9bba86 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -21,6 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_ids.h"
 #include "hw/pci/msi.h"
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index ca66bc721a..aecf3d7ddf 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -18,6 +18,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "qemu/range.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "sysemu/numa.h"
 
 #define TYPE_PXB_BUS "pxb-bus"
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index d491b40d04..05a698d9ea 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_bridge.h"
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index e94d918b6d..929a5ce160 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -14,6 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/pci/pcie_port.h"
 
 static void rp_aer_vector_update(PCIDevice *d)
diff --git a/hw/pci-bridge/simba.c b/hw/pci-bridge/simba.c
index dea4c8c5e7..0a4c30df66 100644
--- a/hw/pci-bridge/simba.c
+++ b/hw/pci-bridge/simba.c
@@ -28,6 +28,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
+#include "qemu/module.h"
 #include "hw/pci-bridge/simba.h"
 
 /*
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index 467bbabe4c..7cb8579618 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -25,6 +25,7 @@
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 
 #define PCI_DEVICE_ID_TI_XIO3130D       0x8233  /* downstream port */
 #define XIO3130_REVISION                0x1
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
index b524908cf1..600a41064b 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -24,6 +24,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
+#include "qemu/module.h"
 
 #define PCI_DEVICE_ID_TI_XIO3130U       0x8232  /* upstream port */
 #define XIO3130_REVISION                0x2
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 64ad21d295..0fdfff5784 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_host.h"
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index 1bafffcc34..629d1a4624 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -28,10 +28,12 @@
  * http://www.kernel.org/doc/Documentation/devicetree/bindings/pci/host-generic-pci.txt
  * http://www.firmware.org/1275/practice/imap/imap0_9d.pdf
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/pci-host/gpex.h"
+#include "qemu/module.h"
 
 /****************************************************************************
  * GPEX host
diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index 5a151e93e9..ed3b3c361f 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -29,6 +29,7 @@
 #include "hw/pci/pci.h"
 #include "hw/intc/heathrow_pic.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 #define GRACKLE_PCI_HOST_BRIDGE(obj) \
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index b8f8c112e6..21eaa30a20 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -20,6 +20,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "qemu/bswap.h"
+#include "qemu/module.h"
 #include "hw/pci-host/ppce500.h"
 
 #ifdef DEBUG_PCI
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 960939f5ed..172b0bc435 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -27,11 +27,13 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci-host/q35.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
+#include "qemu/module.h"
 
 /****************************************************************************
  * Q35 host
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index e33bd46967..2cec1116af 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -35,6 +35,7 @@
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 /*
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 1378c5c7fb..680fefd066 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -21,9 +21,11 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/ppc/mac.h"
+#include "qemu/module.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci-host/uninorth.h"
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index 7b19078c80..791b321ea0 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -13,6 +13,7 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 /* Old and buggy versions of QEMU used the wrong mapping from
  * PCI IRQs to system interrupt lines. Unfortunately the Linux
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index ceb00e23e6..192b697453 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/module.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/pci/pci_bridge.h"
diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index c6d9ded320..634d2fc25d 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -32,6 +32,7 @@
 #include "qemu/osdep.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
+#include "qemu/module.h"
 #include "qemu/range.h"
 #include "qapi/error.h"
 
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 9d64b2e12f..9c72d1cbd9 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -22,6 +22,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_host.h"
+#include "qemu/module.h"
 #include "hw/pci/pci_bus.h"
 #include "trace.h"
 
diff --git a/hw/pci/pcie_host.c b/hw/pci/pcie_host.c
index 1ee4945a6d..d6768b8eb6 100644
--- a/hw/pci/pcie_host.c
+++ b/hw/pci/pcie_host.c
@@ -23,6 +23,7 @@
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pcie_host.h"
+#include "qemu/module.h"
 #include "exec/address-spaces.h"
 
 /* a helper function to get a PCIDevice for a given mmconfig address */
diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
index a30291ef54..c9c3ba540a 100644
--- a/hw/pci/pcie_port.c
+++ b/hw/pci/pcie_port.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/pci/pcie_port.h"
+#include "qemu/module.h"
 #include "hw/hotplug.h"
 
 void pcie_port_init_reg(PCIDevice *d)
diff --git a/hw/pcmcia/pcmcia.c b/hw/pcmcia/pcmcia.c
index 195672186a..c16b12db01 100644
--- a/hw/pcmcia/pcmcia.c
+++ b/hw/pcmcia/pcmcia.c
@@ -5,7 +5,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "hw/hw.h"
 #include "hw/pcmcia.h"
 
diff --git a/hw/pcmcia/pxa2xx.c b/hw/pcmcia/pxa2xx.c
index 20c9c753d2..8993b784bb 100644
--- a/hw/pcmcia/pxa2xx.c
+++ b/hw/pcmcia/pxa2xx.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
+#include "qemu/module.h"
 #include "hw/pcmcia.h"
 #include "hw/arm/pxa.h"
 
diff --git a/hw/ppc/mpc8544_guts.c b/hw/ppc/mpc8544_guts.c
index ce1254b5d4..2b7cc14060 100644
--- a/hw/ppc/mpc8544_guts.c
+++ b/hw/ppc/mpc8544_guts.c
@@ -18,7 +18,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 5feeed6bc4..c6411ecc1d 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -16,10 +16,12 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "target/ppc/cpu.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/pnv.h"
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 641e2046db..a9f150c3ca 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -22,6 +22,7 @@
 #include "target/ppc/cpu.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/isa/isa.h"
 
 #include "hw/ppc/pnv.h"
diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index fdd9296e1b..636f91f311 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -22,6 +22,7 @@
 #include "target/ppc/cpu.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_xscom.h"
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 5345c8389e..d7b6f5d75b 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -21,6 +21,7 @@
 #include "hw/hw.h"
 #include "target/ppc/cpu.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "monitor/monitor.h"
 
diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index c285ef514e..110f476dd7 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -16,9 +16,11 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "sysemu/hw_accel.h"
 #include "target/ppc/cpu.h"
 #include "hw/sysbus.h"
diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index 42ef76b6f5..ca54631f9d 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/hw.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 9130eb314c..5c1a53d6e7 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -10,10 +10,10 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "exec/address-spaces.h"
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index 86981be710..e7cf8d50a5 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -23,6 +23,7 @@
 #include "hw/hw.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
+#include "qemu/module.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "exec/address-spaces.h"
diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
index c45fc858de..0060fcb43f 100644
--- a/hw/ppc/ppce500_spin.c
+++ b/hw/ppc/ppce500_spin.c
@@ -28,6 +28,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/module.h"
 #include "qemu/units.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
index 50893ec529..df7603b986 100644
--- a/hw/ppc/prep_systemio.c
+++ b/hw/ppc/prep_systemio.c
@@ -26,6 +26,7 @@
 #include "hw/isa/isa.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h" /* for error_report() */
+#include "qemu/module.h"
 #include "sysemu/sysemu.h" /* for vm_stop() */
 #include "cpu.h"
 #include "trace.h"
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 6c16d2b120..5c52051ffc 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -3,6 +3,7 @@
 #include "sysemu/hw_accel.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 5aff4d5a05..bd3d0256a6 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -16,10 +16,12 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "sysemu/kvm.h"
 #include "hw/qdev.h"
 #include "kvm_ppc.h"
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 97961b0128..8352276c2c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -22,9 +22,9 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
@@ -39,6 +39,7 @@
 #include <libfdt.h>
 #include "trace.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qapi/qmp/qerror.h"
 #include "hw/ppc/fdt.h"
 #include "hw/pci/pci_bridge.h"
diff --git a/hw/ppc/spapr_rng.c b/hw/ppc/spapr_rng.c
index 4060987590..0e1c7ebcf8 100644
--- a/hw/ppc/spapr_rng.c
+++ b/hw/ppc/spapr_rng.c
@@ -19,9 +19,9 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/rng.h"
diff --git a/hw/ppc/spapr_rtas_ddw.c b/hw/ppc/spapr_rtas_ddw.c
index f6538189f4..3501b05819 100644
--- a/hw/ppc/spapr_rtas_ddw.c
+++ b/hw/ppc/spapr_rtas_ddw.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "hw/ppc/spapr.h"
 #include "hw/pci-host/spapr.h"
 #include "trace.h"
diff --git a/hw/ppc/spapr_rtc.c b/hw/ppc/spapr_rtc.c
index d732a3ea95..b178e05666 100644
--- a/hw/ppc/spapr_rtc.c
+++ b/hw/ppc/spapr_rtc.c
@@ -33,6 +33,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-events-target.h"
 #include "qemu/cutils.h"
+#include "qemu/module.h"
 
 void spapr_rtc_read(SpaprRtcState *rtc, struct tm *tm, uint32_t *ns)
 {
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 769f7990f8..adcf79cd63 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -15,6 +15,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_ids.h"
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index e34a26a0ef..ca69a1bcd8 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
index d4c159e937..591d70deb3 100644
--- a/hw/riscv/sifive_clint.c
+++ b/hw/riscv/sifive_clint.c
@@ -21,6 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "target/riscv/cpu.h"
 #include "hw/riscv/sifive_clint.h"
diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index 07a032d93d..70a4413599 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "hw/sysbus.h"
 #include "hw/pci/msi.h"
diff --git a/hw/riscv/sifive_prci.c b/hw/riscv/sifive_prci.c
index 0910ea32c1..fa136b5a9f 100644
--- a/hw/riscv/sifive_prci.c
+++ b/hw/riscv/sifive_prci.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "qemu/module.h"
 #include "target/riscv/cpu.h"
 #include "hw/riscv/sifive_prci.h"
 
diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
index 8abd2cd525..24a04d7b36 100644
--- a/hw/riscv/sifive_test.c
+++ b/hw/riscv/sifive_test.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "qemu/module.h"
 #include "target/riscv/cpu.h"
 #include "hw/riscv/sifive_test.h"
 
diff --git a/hw/s390x/ap-bridge.c b/hw/s390x/ap-bridge.c
index 75ad0a66b9..9284de4eec 100644
--- a/hw/s390x/ap-bridge.c
+++ b/hw/s390x/ap-bridge.c
@@ -7,10 +7,12 @@
  * your option) any later version. See the COPYING file in the top-level
  * directory.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "qemu/bitops.h"
+#include "qemu/module.h"
 #include "hw/s390x/ap-bridge.h"
 #include "cpu.h"
 
diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index 7cd73df4aa..24f17bb6ca 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -8,8 +8,10 @@
  * your option) any later version. See the COPYING file in the top-level
  * directory.
  */
+
 #include "qemu/osdep.h"
 #include "ccw-device.h"
+#include "qemu/module.h"
 
 static void ccw_device_refill_ids(CcwDevice *dev)
 {
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index e04d51b191..4e9ff481e8 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -9,11 +9,13 @@
  * your option) any later version. See the COPYING file in the top-level
  * directory.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/hotplug.h"
 #include "hw/sysbus.h"
 #include "qemu/bitops.h"
+#include "qemu/module.h"
 #include "hw/s390x/css.h"
 #include "ccw-device.h"
 #include "hw/s390x/css-bridge.h"
diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index ee5b83448b..dbe36cfb1b 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -17,6 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "sysemu/sysemu.h"
 
 #include "hw/s390x/sclp.h"
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index f5f025d1b6..8403f0e3e9 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include <libgen.h>
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "hw/s390x/css.h"
 #include "hw/s390x/css-bridge.h"
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 2d0a28d544..2c6e084e2c 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -14,7 +14,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "s390-pci-bus.h"
 #include "s390-pci-inst.h"
@@ -22,6 +21,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/msi.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 
 #ifndef DEBUG_S390PCI_BUS
 #define DEBUG_S390PCI_BUS  0
diff --git a/hw/s390x/s390-skeys-kvm.c b/hw/s390x/s390-skeys-kvm.c
index dc54ed8b11..1c4d805ad8 100644
--- a/hw/s390x/s390-skeys-kvm.c
+++ b/hw/s390x/s390-skeys-kvm.c
@@ -13,6 +13,7 @@
 #include "hw/s390x/storage-keys.h"
 #include "sysemu/kvm.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 
 static int kvm_s390_skeys_enabled(S390SKeysState *ss)
 {
diff --git a/hw/s390x/sclpcpu.c b/hw/s390x/sclpcpu.c
index 50c021b9c2..a4aab7df51 100644
--- a/hw/s390x/sclpcpu.c
+++ b/hw/s390x/sclpcpu.c
@@ -12,9 +12,11 @@
  * option) any later version.  See the COPYING file in the top-level directory.
  *
  */
+
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
 #include "hw/s390x/sclp.h"
+#include "qemu/module.h"
 #include "hw/s390x/event-facility.h"
 #include "cpu.h"
 #include "sysemu/cpus.h"
diff --git a/hw/s390x/sclpquiesce.c b/hw/s390x/sclpquiesce.c
index 1c8f5c9393..4f73471537 100644
--- a/hw/s390x/sclpquiesce.c
+++ b/hw/s390x/sclpquiesce.c
@@ -11,10 +11,12 @@
  * option) any later version.  See the COPYING file in the top-level directory.
  *
  */
+
 #include "qemu/osdep.h"
 #include "hw/qdev.h"
 #include "sysemu/sysemu.h"
 #include "hw/s390x/sclp.h"
+#include "qemu/module.h"
 #include "hw/s390x/event-facility.h"
 
 typedef struct SignalQuiesce {
diff --git a/hw/s390x/tod-kvm.c b/hw/s390x/tod-kvm.c
index 2456bf7b24..bebe4744af 100644
--- a/hw/s390x/tod-kvm.c
+++ b/hw/s390x/tod-kvm.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "sysemu/sysemu.h"
 #include "hw/s390x/tod.h"
 #include "kvm_s390x.h"
diff --git a/hw/s390x/tod-qemu.c b/hw/s390x/tod-qemu.c
index 59c015c69d..58b66d2d98 100644
--- a/hw/s390x/tod-qemu.c
+++ b/hw/s390x/tod-qemu.c
@@ -13,6 +13,7 @@
 #include "hw/s390x/tod.h"
 #include "qemu/timer.h"
 #include "qemu/cutils.h"
+#include "qemu/module.h"
 #include "cpu.h"
 #include "tcg_s390x.h"
 
diff --git a/hw/s390x/tod.c b/hw/s390x/tod.c
index 1c63f411e6..a9fca8eb0b 100644
--- a/hw/s390x/tod.c
+++ b/hw/s390x/tod.c
@@ -12,6 +12,7 @@
 #include "hw/s390x/tod.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "sysemu/kvm.h"
 #include "migration/register.h"
 
diff --git a/hw/s390x/vhost-vsock-ccw.c b/hw/s390x/vhost-vsock-ccw.c
index cddc5cf652..076f733390 100644
--- a/hw/s390x/vhost-vsock-ccw.c
+++ b/hw/s390x/vhost-vsock-ccw.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "virtio-ccw.h"
 
 static Property vhost_vsock_ccw_properties[] = {
diff --git a/hw/s390x/virtio-ccw-9p.c b/hw/s390x/virtio-ccw-9p.c
index d6be172596..67b2c537cc 100644
--- a/hw/s390x/virtio-ccw-9p.c
+++ b/hw/s390x/virtio-ccw-9p.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "virtio-ccw.h"
 
 static void virtio_ccw_9p_realize(VirtioCcwDevice *ccw_dev, Error **errp)
diff --git a/hw/s390x/virtio-ccw-balloon.c b/hw/s390x/virtio-ccw-balloon.c
index 28d171ac0c..35e43e89fb 100644
--- a/hw/s390x/virtio-ccw-balloon.c
+++ b/hw/s390x/virtio-ccw-balloon.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "virtio-ccw.h"
 
 static void virtio_ccw_balloon_realize(VirtioCcwDevice *ccw_dev, Error **errp)
diff --git a/hw/s390x/virtio-ccw-blk.c b/hw/s390x/virtio-ccw-blk.c
index 1f3d09a75a..83636cb6d7 100644
--- a/hw/s390x/virtio-ccw-blk.c
+++ b/hw/s390x/virtio-ccw-blk.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "virtio-ccw.h"
 
 static void virtio_ccw_blk_realize(VirtioCcwDevice *ccw_dev, Error **errp)
diff --git a/hw/s390x/virtio-ccw-crypto.c b/hw/s390x/virtio-ccw-crypto.c
index aab6a958f2..4569fe0649 100644
--- a/hw/s390x/virtio-ccw-crypto.c
+++ b/hw/s390x/virtio-ccw-crypto.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "virtio-ccw.h"
 
 static void virtio_ccw_crypto_realize(VirtioCcwDevice *ccw_dev, Error **errp)
diff --git a/hw/s390x/virtio-ccw-gpu.c b/hw/s390x/virtio-ccw-gpu.c
index 71869b7fbd..10ee4b86eb 100644
--- a/hw/s390x/virtio-ccw-gpu.c
+++ b/hw/s390x/virtio-ccw-gpu.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "virtio-ccw.h"
 
 static void virtio_ccw_gpu_realize(VirtioCcwDevice *ccw_dev, Error **errp)
diff --git a/hw/s390x/virtio-ccw-input.c b/hw/s390x/virtio-ccw-input.c
index 79c87cb3f2..075bb094ee 100644
--- a/hw/s390x/virtio-ccw-input.c
+++ b/hw/s390x/virtio-ccw-input.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "virtio-ccw.h"
 
 static void virtio_ccw_input_realize(VirtioCcwDevice *ccw_dev, Error **errp)
diff --git a/hw/s390x/virtio-ccw-net.c b/hw/s390x/virtio-ccw-net.c
index 0c0410c643..8ff184265e 100644
--- a/hw/s390x/virtio-ccw-net.c
+++ b/hw/s390x/virtio-ccw-net.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "virtio-ccw.h"
 
 static void virtio_ccw_net_realize(VirtioCcwDevice *ccw_dev, Error **errp)
diff --git a/hw/s390x/virtio-ccw-rng.c b/hw/s390x/virtio-ccw-rng.c
index 3f6abccef8..dc60f084a5 100644
--- a/hw/s390x/virtio-ccw-rng.c
+++ b/hw/s390x/virtio-ccw-rng.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "virtio-ccw.h"
 
 static void virtio_ccw_rng_realize(VirtioCcwDevice *ccw_dev, Error **errp)
diff --git a/hw/s390x/virtio-ccw-scsi.c b/hw/s390x/virtio-ccw-scsi.c
index c9a804fa25..26fa086ef0 100644
--- a/hw/s390x/virtio-ccw-scsi.c
+++ b/hw/s390x/virtio-ccw-scsi.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "virtio-ccw.h"
 
 static void virtio_ccw_scsi_realize(VirtioCcwDevice *ccw_dev, Error **errp)
diff --git a/hw/s390x/virtio-ccw-serial.c b/hw/s390x/virtio-ccw-serial.c
index 3851fc9c9b..8cf5a529a5 100644
--- a/hw/s390x/virtio-ccw-serial.c
+++ b/hw/s390x/virtio-ccw-serial.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/virtio/virtio.h"
+#include "qemu/module.h"
 #include "hw/virtio/virtio-serial.h"
 #include "virtio-ccw.h"
 
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index c2b78c8e9b..43d3a1b029 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -21,6 +21,7 @@
 #include "hw/sysbus.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "hw/virtio/virtio-access.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/s390x/adapter.h"
diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index 6b0bbb9b7f..342f500f82 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -30,6 +30,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #define TYPE_AM53C974_DEVICE "am53c974"
 
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index ca8b36c0c5..7508d035ca 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -28,6 +28,7 @@
 #include "hw/scsi/esp.h"
 #include "trace.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 /*
  * On Sparc32, this is the ESP (NCR53C90) part of chip STP2000 (Master I/O),
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index da7239d94f..6673d1e9e9 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -20,6 +20,7 @@
 #include "hw/scsi/scsi.h"
 #include "sysemu/dma.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 static const char *names[] = {
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 5ad762de23..06f618dbf7 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -26,6 +26,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "qemu/iov.h"
+#include "qemu/module.h"
 #include "hw/scsi/scsi.h"
 #include "scsi/constants.h"
 #include "trace.h"
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 929404fb48..dacafb4098 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -28,6 +28,7 @@
 #include "sysemu/dma.h"
 #include "hw/pci/msi.h"
 #include "qemu/iov.h"
+#include "qemu/module.h"
 #include "hw/scsi/scsi.h"
 #include "scsi/constants.h"
 #include "trace.h"
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index c480553083..196136a307 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -2,6 +2,7 @@
 #include "hw/hw.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "hw/scsi/scsi.h"
 #include "scsi/constants.h"
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index e7e865ab3b..72902c6c15 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -23,6 +23,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "hw/scsi/scsi.h"
 #include "hw/scsi/emulation.h"
 #include "scsi/constants.h"
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index e8a8706a4f..f07891b3f6 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -15,6 +15,7 @@
 #include "qapi/error.h"
 #include "qemu/ctype.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "hw/scsi/scsi.h"
 #include "hw/scsi/emulation.h"
 #include "sysemu/block-backend.h"
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 26dfc0340f..0e491c911d 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -31,8 +31,9 @@
  *  - Add indirect descriptors support
  *  - Maybe do autosense (PAPR seems to mandate it, linux doesn't care)
  */
+
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/scsi/scsi.h"
diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
index b7fbab65dd..8ec49d7fef 100644
--- a/hw/scsi/vhost-scsi-common.c
+++ b/hw/scsi/vhost-scsi-common.c
@@ -17,6 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-scsi-common.h"
 #include "hw/virtio/virtio-scsi.h"
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 61e2e57da9..76504d7893 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -19,6 +19,7 @@
 #include <sys/ioctl.h>
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qemu/queue.h"
 #include "monitor/monitor.h"
 #include "migration/blocker.h"
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 839f120256..2e85aa7094 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -19,6 +19,7 @@
 #include "hw/virtio/virtio-scsi.h"
 #include "qemu/error-report.h"
 #include "qemu/iov.h"
+#include "qemu/module.h"
 #include "sysemu/block-backend.h"
 #include "hw/scsi/scsi.h"
 #include "scsi/constants.h"
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 584b4be07e..39e08161f2 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -27,6 +27,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/scsi/scsi.h"
 #include "scsi/constants.h"
 #include "hw/pci/msi.h"
diff --git a/hw/sd/bcm2835_sdhost.c b/hw/sd/bcm2835_sdhost.c
index 1b760b2a7c..2778fb0de4 100644
--- a/hw/sd/bcm2835_sdhost.c
+++ b/hw/sd/bcm2835_sdhost.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "sysemu/blockdev.h"
 #include "hw/sd/bcm2835_sdhost.h"
 #include "trace.h"
diff --git a/hw/sd/core.c b/hw/sd/core.c
index 107e6d71dd..abec48bccb 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include "hw/qdev-core.h"
 #include "hw/sd/sd.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 static inline const char *sdbus_name(SDBus *sdbus)
diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index df42aa1c54..ebfb997ce3 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -23,6 +23,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 3ad7e925c5..81b406dbf0 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -12,6 +12,7 @@
 #include "hw/sysbus.h"
 #include "hw/sd/sd.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 
 //#define DEBUG_PL181 1
diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 82f8ec0d50..81ff5cea86 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -20,6 +20,7 @@
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 #define TYPE_PXA2XX_MMCI "pxa2xx-mmci"
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index aaab15f386..60500ec8fe 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -43,6 +43,7 @@
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "sdmmc-internal.h"
 #include "trace.h"
 
diff --git a/hw/sd/sdhci-pci.c b/hw/sd/sdhci-pci.c
index f884661862..9370181993 100644
--- a/hw/sd/sdhci-pci.c
+++ b/hw/sd/sdhci-pci.c
@@ -17,6 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "hw/hw.h"
 #include "hw/sd/sdhci.h"
 #include "sdhci-internal.h"
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 17ad5465a7..7b80b1d93f 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -33,6 +33,7 @@
 #include "hw/sd/sdhci.h"
 #include "sdhci-internal.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 #define TYPE_SDHCI_BUS "sdhci-bus"
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 623d0333e8..a635fc6752 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -15,6 +15,7 @@
 #include "hw/ssi/ssi.h"
 #include "hw/sd/sd.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 
 //#define DEBUG_SSI_SD 1
 
diff --git a/hw/sh4/sh_pci.c b/hw/sh4/sh_pci.c
index 379d0685ed..b15f264e99 100644
--- a/hw/sh4/sh_pci.c
+++ b/hw/sh4/sh_pci.c
@@ -21,12 +21,14 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/sh4/sh.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "qemu/bswap.h"
+#include "qemu/module.h"
 #include "exec/address-spaces.h"
 
 #define TYPE_SH_PCI_HOST_BRIDGE "sh_pci"
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 47be9071fa..a36448fc8d 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -20,6 +20,7 @@
 #include "qapi/error.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "sysemu/sysemu.h"
 #include "qemu/uuid.h"
diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
index 7ca1e3fce4..45a61ecf87 100644
--- a/hw/sparc/sun4m_iommu.c
+++ b/hw/sparc/sun4m_iommu.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/sparc/sun4m_iommu.h"
 #include "hw/sysbus.h"
+#include "qemu/module.h"
 #include "exec/address-spaces.h"
 #include "trace.h"
 
diff --git a/hw/sparc64/sun4u_iommu.c b/hw/sparc64/sun4u_iommu.c
index 1ef7645ba5..9178277f82 100644
--- a/hw/sparc64/sun4u_iommu.c
+++ b/hw/sparc64/sun4u_iommu.c
@@ -29,6 +29,7 @@
 #include "hw/sparc/sun4u_iommu.h"
 #include "exec/address-spaces.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index f1e66870d7..9eda0d720b 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -26,6 +26,7 @@
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qemu/error-report.h"
 
 #include "hw/ssi/aspeed_smc.h"
diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
index 02c38c9e47..5cec9b5d05 100644
--- a/hw/ssi/imx_spi.c
+++ b/hw/ssi/imx_spi.c
@@ -12,6 +12,7 @@
 #include "hw/ssi/imx_spi.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #ifndef DEBUG_IMX_SPI
 #define DEBUG_IMX_SPI 0
diff --git a/hw/ssi/mss-spi.c b/hw/ssi/mss-spi.c
index 185e1a3920..918b1f3e82 100644
--- a/hw/ssi/mss-spi.c
+++ b/hw/ssi/mss-spi.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/ssi/mss-spi.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #ifndef MSS_SPI_ERR_DEBUG
 #define MSS_SPI_ERR_DEBUG   0
diff --git a/hw/ssi/pl022.c b/hw/ssi/pl022.c
index e58247554c..fec73cae26 100644
--- a/hw/ssi/pl022.c
+++ b/hw/ssi/pl022.c
@@ -12,6 +12,7 @@
 #include "hw/ssi/pl022.h"
 #include "hw/ssi/ssi.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 //#define DEBUG_PL022 1
 
diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
index 7eaaf565fd..cda7c96a64 100644
--- a/hw/ssi/ssi.c
+++ b/hw/ssi/ssi.c
@@ -14,6 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/ssi/ssi.h"
+#include "qemu/module.h"
 
 struct SSIBus {
     BusState parent_obj;
diff --git a/hw/ssi/stm32f2xx_spi.c b/hw/ssi/stm32f2xx_spi.c
index 930c616de3..4249101386 100644
--- a/hw/ssi/stm32f2xx_spi.c
+++ b/hw/ssi/stm32f2xx_spi.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/ssi/stm32f2xx_spi.h"
 
 #ifndef STM_SPI_ERR_DEBUG
diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index 3dae303d5b..1379cb164b 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -28,6 +28,7 @@
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qemu/fifo8.h"
 
 #include "hw/ssi/ssi.h"
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index c615058cc1..8115bb6d46 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -27,6 +27,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/ptimer.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qemu/bitops.h"
 #include "hw/ssi/xilinx_spips.h"
 #include "qapi/error.h"
diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index 96d534d8a8..09e2a7b7bf 100644
--- a/hw/timer/a9gtimer.c
+++ b/hw/timer/a9gtimer.c
@@ -26,6 +26,7 @@
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qom/cpu.h"
 
 #ifndef A9_GTIMER_ERR_DEBUG
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index 22ceabe1d4..763e1090ec 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -20,6 +20,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/timer/allwinner-a10-pit.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 static void a10_pit_update_irq(AwA10PITState *s)
 {
diff --git a/hw/timer/altera_timer.c b/hw/timer/altera_timer.c
index c9a0fc5dca..5c1d9e4074 100644
--- a/hw/timer/altera_timer.c
+++ b/hw/timer/altera_timer.c
@@ -19,7 +19,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 
 #include "hw/sysbus.h"
diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index daf6c48797..93044aacfd 100644
--- a/hw/timer/arm_mptimer.c
+++ b/hw/timer/arm_mptimer.c
@@ -24,6 +24,7 @@
 #include "hw/timer/arm_mptimer.h"
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 #include "qom/cpu.h"
 
 #define PTIMER_POLICY                       \
diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 98fddd7ac1..f0a753404d 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -10,10 +10,10 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
-#include "qemu-common.h"
 #include "hw/qdev.h"
 #include "hw/ptimer.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 #include "qemu/log.h"
 
 /* Common timer implementation.  */
diff --git a/hw/timer/armv7m_systick.c b/hw/timer/armv7m_systick.c
index df8d2804b3..a17317ce2f 100644
--- a/hw/timer/armv7m_systick.c
+++ b/hw/timer/armv7m_systick.c
@@ -11,10 +11,10 @@
 
 #include "qemu/osdep.h"
 #include "hw/timer/armv7m_systick.h"
-#include "qemu-common.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 /* qemu timers run at 1GHz.   We want something closer to 1MHz.  */
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 5c786e5128..2c3a4d0fe7 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -13,10 +13,10 @@
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/timer/aspeed_timer.h"
-#include "qemu-common.h"
 #include "qemu/bitops.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 #define TIMER_NR_REGS 4
diff --git a/hw/timer/cadence_ttc.c b/hw/timer/cadence_ttc.c
index 10056407ab..115d935f84 100644
--- a/hw/timer/cadence_ttc.c
+++ b/hw/timer/cadence_ttc.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 
 #ifdef CADENCE_TTC_ERR_DEBUG
diff --git a/hw/timer/cmsdk-apb-dualtimer.c b/hw/timer/cmsdk-apb-dualtimer.c
index 30245990f3..383f6e12b1 100644
--- a/hw/timer/cmsdk-apb-dualtimer.c
+++ b/hw/timer/cmsdk-apb-dualtimer.c
@@ -21,6 +21,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
 #include "hw/timer/cmsdk-apb-dualtimer.h"
diff --git a/hw/timer/cmsdk-apb-timer.c b/hw/timer/cmsdk-apb-timer.c
index 801d1dba74..2e7318b81f 100644
--- a/hw/timer/cmsdk-apb-timer.c
+++ b/hw/timer/cmsdk-apb-timer.c
@@ -30,6 +30,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "trace.h"
 #include "hw/sysbus.h"
diff --git a/hw/timer/digic-timer.c b/hw/timer/digic-timer.c
index 4d73077207..c818ed1d98 100644
--- a/hw/timer/digic-timer.c
+++ b/hw/timer/digic-timer.c
@@ -30,6 +30,7 @@
 #include "hw/sysbus.h"
 #include "hw/ptimer.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 #include "qemu/log.h"
 
 #include "hw/timer/digic-timer.h"
diff --git a/hw/timer/ds1338.c b/hw/timer/ds1338.c
index 03da75486b..30d2d21408 100644
--- a/hw/timer/ds1338.c
+++ b/hw/timer/ds1338.c
@@ -14,6 +14,7 @@
 #include "qemu-common.h"
 #include "hw/i2c/i2c.h"
 #include "qemu/bcd.h"
+#include "qemu/module.h"
 
 /* Size of NVRAM including both the user-accessible area and the
  * secondary register area.
diff --git a/hw/timer/etraxfs_timer.c b/hw/timer/etraxfs_timer.c
index 2280914b1d..53834e197f 100644
--- a/hw/timer/etraxfs_timer.c
+++ b/hw/timer/etraxfs_timer.c
@@ -21,9 +21,11 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
 
diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index e4ef4cfd36..874c7b8522 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -57,7 +57,7 @@
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "qemu/main-loop.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "hw/ptimer.h"
 
 #include "hw/arm/exynos4210.h"
diff --git a/hw/timer/exynos4210_pwm.c b/hw/timer/exynos4210_pwm.c
index 87f63f057e..9bc0327785 100644
--- a/hw/timer/exynos4210_pwm.c
+++ b/hw/timer/exynos4210_pwm.c
@@ -24,8 +24,8 @@
 #include "qemu/log.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
-#include "qemu-common.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 #include "hw/ptimer.h"
 
 #include "hw/arm/exynos4210.h"
diff --git a/hw/timer/exynos4210_rtc.c b/hw/timer/exynos4210_rtc.c
index 4607833e3e..0d65f6f3e3 100644
--- a/hw/timer/exynos4210_rtc.c
+++ b/hw/timer/exynos4210_rtc.c
@@ -27,9 +27,9 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
-#include "qemu-common.h"
 #include "qemu/bcd.h"
 #include "hw/ptimer.h"
 
diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index 4b7088fc84..e45a49075b 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -28,6 +28,7 @@
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 
 #include "trace.h"
 
diff --git a/hw/timer/i8254.c b/hw/timer/i8254.c
index 20f834e7da..0972c4724e 100644
--- a/hw/timer/i8254.c
+++ b/hw/timer/i8254.c
@@ -21,8 +21,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/timer/i8254.h"
 #include "hw/timer/i8254_internal.h"
diff --git a/hw/timer/i8254_common.c b/hw/timer/i8254_common.c
index 6190b6fc5d..76ca6ec444 100644
--- a/hw/timer/i8254_common.c
+++ b/hw/timer/i8254_common.c
@@ -22,9 +22,11 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/isa/isa.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/timer/i8254.h"
 #include "hw/timer/i8254_internal.h"
diff --git a/hw/timer/imx_epit.c b/hw/timer/imx_epit.c
index 8677b753b1..7a883160f4 100644
--- a/hw/timer/imx_epit.c
+++ b/hw/timer/imx_epit.c
@@ -16,6 +16,7 @@
 #include "hw/timer/imx_epit.h"
 #include "hw/misc/imx_ccm.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 #include "qemu/log.h"
 
 #ifndef DEBUG_IMX_EPIT
diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index 65e4ee6bcf..3086c03774 100644
--- a/hw/timer/imx_gpt.c
+++ b/hw/timer/imx_gpt.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "hw/timer/imx_gpt.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 #include "qemu/log.h"
 
 #ifndef DEBUG_IMX_GPT
diff --git a/hw/timer/lm32_timer.c b/hw/timer/lm32_timer.c
index 2a07b59524..6ce876c6ae 100644
--- a/hw/timer/lm32_timer.c
+++ b/hw/timer/lm32_timer.c
@@ -29,6 +29,7 @@
 #include "hw/ptimer.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 
 #define DEFAULT_FREQUENCY (50*1000000)
 
diff --git a/hw/timer/m41t80.c b/hw/timer/m41t80.c
index c45b9297d8..5b9192c28d 100644
--- a/hw/timer/m41t80.c
+++ b/hw/timer/m41t80.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "qemu/bcd.h"
 #include "hw/i2c/i2c.h"
diff --git a/hw/timer/m48t59-isa.c b/hw/timer/m48t59-isa.c
index ea1ba703d7..cbc5e61ddd 100644
--- a/hw/timer/m48t59-isa.c
+++ b/hw/timer/m48t59-isa.c
@@ -22,10 +22,12 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
 #include "hw/timer/m48t59.h"
 #include "m48t59-internal.h"
+#include "qemu/module.h"
 
 #define TYPE_M48TXX_ISA "isa-m48txx"
 #define M48TXX_ISA_GET_CLASS(obj) \
diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
index ca3ed445de..5d26e9aef0 100644
--- a/hw/timer/m48t59.c
+++ b/hw/timer/m48t59.c
@@ -22,6 +22,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/timer/m48t59.h"
@@ -30,6 +31,7 @@
 #include "hw/sysbus.h"
 #include "exec/address-spaces.h"
 #include "qemu/bcd.h"
+#include "qemu/module.h"
 
 #include "m48t59-internal.h"
 
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 513f105e62..b61b4ddeaf 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qemu/module.h"
 #include "qemu/bcd.h"
 #include "hw/hw.h"
 #include "qemu/timer.h"
diff --git a/hw/timer/milkymist-sysctl.c b/hw/timer/milkymist-sysctl.c
index 93bc6e1790..a9d250877c 100644
--- a/hw/timer/milkymist-sysctl.c
+++ b/hw/timer/milkymist-sysctl.c
@@ -29,6 +29,7 @@
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 
 enum {
     CTRL_ENABLE      = (1<<0),
diff --git a/hw/timer/mss-timer.c b/hw/timer/mss-timer.c
index 4f814572e2..6add47af99 100644
--- a/hw/timer/mss-timer.c
+++ b/hw/timer/mss-timer.c
@@ -25,6 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 #include "qemu/log.h"
 #include "hw/timer/mss-timer.h"
 
diff --git a/hw/timer/nrf51_timer.c b/hw/timer/nrf51_timer.c
index 0c90662896..29fb81a744 100644
--- a/hw/timer/nrf51_timer.c
+++ b/hw/timer/nrf51_timer.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/arm/nrf51.h"
 #include "hw/timer/nrf51_timer.h"
 #include "trace.h"
diff --git a/hw/timer/pl031.c b/hw/timer/pl031.c
index 274ad47a33..abac73ab42 100644
--- a/hw/timer/pl031.c
+++ b/hw/timer/pl031.c
@@ -18,6 +18,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "trace.h"
 
 #define RTC_DR      0x00    /* Data read register */
diff --git a/hw/timer/puv3_ost.c b/hw/timer/puv3_ost.c
index 3be58c7fdd..4a8ae37ffd 100644
--- a/hw/timer/puv3_ost.c
+++ b/hw/timer/puv3_ost.c
@@ -8,10 +8,12 @@
  * published by the Free Software Foundation, or any later version.
  * See the COPYING file in the top-level directory.
  */
+
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/ptimer.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 
 #undef DEBUG_PUV3
 #include "hw/unicore32/puv3.h"
diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index a489bf5159..8c1ef43cd5 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -14,6 +14,7 @@
 #include "hw/arm/pxa.h"
 #include "hw/sysbus.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #define OSMR0	0x00
 #define OSMR1	0x04
diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index 4694b653a7..005fd599e8 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -28,6 +28,7 @@
 #include "hw/sysbus.h"
 #include "trace.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 
 /*
  * Registers of hardware timer in sun4m.
diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index ae744d1642..4c49dc4995 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/timer/stm32f2xx_timer.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 #ifndef STM_TIMER_ERR_DEBUG
 #define STM_TIMER_ERR_DEBUG 0
diff --git a/hw/timer/sun4v-rtc.c b/hw/timer/sun4v-rtc.c
index b93cbd6a81..ba62adc826 100644
--- a/hw/timer/sun4v-rtc.c
+++ b/hw/timer/sun4v-rtc.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/timer/sun4v-rtc.h"
 #include "trace.h"
diff --git a/hw/timer/twl92230.c b/hw/timer/twl92230.c
index c83d803dd8..7785b96c0b 100644
--- a/hw/timer/twl92230.c
+++ b/hw/timer/twl92230.c
@@ -26,6 +26,7 @@
 #include "sysemu/sysemu.h"
 #include "ui/console.h"
 #include "qemu/bcd.h"
+#include "qemu/module.h"
 
 #define VERBOSE 1
 
diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 59439c05be..16bcd0393b 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -27,6 +27,7 @@
 #include "hw/ptimer.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 
 #define D(x)
 
diff --git a/hw/timer/xlnx-zynqmp-rtc.c b/hw/timer/xlnx-zynqmp-rtc.c
index c98dc3d94e..be078ae72a 100644
--- a/hw/timer/xlnx-zynqmp-rtc.c
+++ b/hw/timer/xlnx-zynqmp-rtc.c
@@ -29,6 +29,7 @@
 #include "hw/register.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "hw/ptimer.h"
 #include "qemu/cutils.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 3087acc4ab..5e2db9e0c4 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -16,7 +16,7 @@
 
 #include "qemu/osdep.h"
 
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
 
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 70f4b10284..1288cbcb8d 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -28,6 +28,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qemu/sockets.h"
 #include "io/channel-socket.h"
 #include "sysemu/tpm_backend.h"
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 479317ee50..e87bd126c6 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -23,8 +23,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qemu/sockets.h"
 #include "sysemu/tpm_backend.h"
 #include "tpm_int.h"
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index fd183e8deb..174618ac30 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 
 #include "hw/acpi/tpm.h"
 #include "hw/pci/pci_ids.h"
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 9a74dc9560..a28e9e3b33 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -4,6 +4,7 @@
 #include "hw/qdev.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "sysemu/sysemu.h"
 #include "monitor/monitor.h"
 #include "trace.h"
diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index 963373ba95..e20f8ed293 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -31,6 +31,7 @@
 
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 #include "ccid.h"
 #include "qapi/error.h"
 
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 0a6c657228..081bcfd70a 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -13,6 +13,7 @@
 #include <libcacard.h>
 #include "chardev/char-fe.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qemu/sockets.h"
 #include "ccid.h"
 #include "qapi/error.h"
diff --git a/hw/usb/chipidea.c b/hw/usb/chipidea.c
index 60d67f88b8..3dcd22ccba 100644
--- a/hw/usb/chipidea.c
+++ b/hw/usb/chipidea.c
@@ -13,6 +13,7 @@
 #include "hw/usb/hcd-ehci.h"
 #include "hw/usb/chipidea.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 enum {
     CHIPIDEA_USBx_DCIVERSION   = 0x000,
diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index c46d5eeb79..718ab53cbb 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -30,7 +30,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "hw/usb.h"
 #include "desc.h"
 #include "hw/hw.h"
diff --git a/hw/usb/dev-bluetooth.c b/hw/usb/dev-bluetooth.c
index c539a1afc6..670ba32290 100644
--- a/hw/usb/dev-bluetooth.c
+++ b/hw/usb/dev-bluetooth.c
@@ -19,8 +19,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "hw/usb.h"
 #include "desc.h"
 #include "sysemu/bt.h"
diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index f9ea3033a1..62793eaf26 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -22,12 +22,14 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "ui/console.h"
 #include "hw/usb.h"
 #include "desc.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/input/hid.h"
 
diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index 7e9339b8a8..7e471a5f20 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -21,13 +21,14 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "trace.h"
 #include "hw/usb.h"
 #include "desc.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 
 #define NUM_PORTS 8
 
diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index d90b336d53..38a8a33dc7 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -18,8 +18,8 @@
 #include <sys/statvfs.h>
 
 
-#include "qemu-common.h"
 #include "qemu/iov.h"
+#include "qemu/module.h"
 #include "qemu/filemonitor.h"
 #include "trace.h"
 #include "hw/usb.h"
diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index ffab3fabee..889069dd5a 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -25,7 +25,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "hw/usb.h"
 #include "desc.h"
 #include "net/net.h"
@@ -34,6 +33,7 @@
 #include "qemu/config-file.h"
 #include "sysemu/sysemu.h"
 #include "qemu/iov.h"
+#include "qemu/module.h"
 #include "qemu/cutils.h"
 
 /*#define TRAFFIC_DEBUG*/
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 03c3bcd240..b82f854103 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -10,9 +10,9 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "hw/usb.h"
 #include "desc.h"
 #include "chardev/char-serial.h"
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 6b0137bb76..8d7e516fe7 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -39,6 +39,7 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "hw/usb.h"
 #include "desc.h"
 
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index cd5551d94f..38030cb769 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -9,8 +9,8 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "hw/usb.h"
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index be566cad02..abd8070d0c 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -10,11 +10,11 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "trace.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 
 #include "hw/usb.h"
 #include "desc.h"
diff --git a/hw/usb/dev-wacom.c b/hw/usb/dev-wacom.c
index ac0bc83b52..8c43db9335 100644
--- a/hw/usb/dev-wacom.c
+++ b/hw/usb/dev-wacom.c
@@ -25,10 +25,12 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "ui/console.h"
 #include "hw/usb.h"
+#include "qemu/module.h"
 #include "desc.h"
 
 /* Interface requests */
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index 38b24b160a..03d3a39067 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -17,6 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/usb/hcd-ehci.h"
+#include "qemu/module.h"
 #include "qemu/range.h"
 
 typedef struct EHCIPCIInfo {
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index 9f7f128f19..cd1f3c70a4 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -17,6 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/usb/hcd-ehci.h"
+#include "qemu/module.h"
 
 static const VMStateDescription vmstate_ehci_sysbus = {
     .name        = "ehci-sysbus",
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index aaba090588..4f6fdbc0a7 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/usb.h"
 #include "hw/sysbus.h"
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 09df29ff9c..98bd5cf49d 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -25,6 +25,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/usb.h"
@@ -36,6 +37,7 @@
 #include "sysemu/dma.h"
 #include "trace.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 
 #define FRAME_TIMER_FREQ 1000
 
diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index 75715a048a..e099382b24 100644
--- a/hw/usb/hcd-xhci-nec.c
+++ b/hw/usb/hcd-xhci-nec.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/usb.h"
+#include "qemu/module.h"
 #include "hw/pci/pci.h"
 
 #include "hcd-xhci.h"
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 2e9a839f2b..5894a18663 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -18,9 +18,11 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "qemu/timer.h"
+#include "qemu/module.h"
 #include "qemu/queue.h"
 #include "hw/usb.h"
 #include "hw/pci/pci.h"
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 67b7465915..c089350276 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -40,9 +40,9 @@
 #include <libusb.h>
 
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "monitor/monitor.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
 
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 7cb6b120d4..084b8f2161 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -28,12 +28,12 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/iov.h"
+#include "qemu/module.h"
 #include "chardev/char-fe.h"
 
 #include <usbredirparser.h>
diff --git a/hw/usb/tusb6010.c b/hw/usb/tusb6010.c
index f76b59afe8..a61b0f6354 100644
--- a/hw/usb/tusb6010.c
+++ b/hw/usb/tusb6010.c
@@ -18,8 +18,9 @@
  * You should have received a copy of the GNU General Public License along
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/usb.h"
 #include "hw/arm/omap.h"
diff --git a/hw/vfio/amd-xgbe.c b/hw/vfio/amd-xgbe.c
index ee64a3b4a2..d362329739 100644
--- a/hw/vfio/amd-xgbe.c
+++ b/hw/vfio/amd-xgbe.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/vfio/vfio-amd-xgbe.h"
+#include "qemu/module.h"
 
 static void amd_xgbe_realize(DeviceState *dev, Error **errp)
 {
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index d8b79ebe53..c68e347858 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -19,6 +19,7 @@
 #include "hw/vfio/vfio-common.h"
 #include "hw/s390x/ap-device.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qemu/queue.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
diff --git a/hw/vfio/calxeda-xgmac.c b/hw/vfio/calxeda-xgmac.c
index e7767c4b02..6dd4cb94f5 100644
--- a/hw/vfio/calxeda-xgmac.c
+++ b/hw/vfio/calxeda-xgmac.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/vfio/vfio-calxeda-xgmac.h"
+#include "qemu/module.h"
 
 static void calxeda_xgmac_realize(DeviceState *dev, Error **errp)
 {
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 31dd3a2a87..cfc64202ac 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -25,6 +25,7 @@
 #include "hw/s390x/ccw-device.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 
 struct VFIOCCWDevice {
     S390CCWDevice cdev;
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 29b2697fe1..b35a640030 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -14,6 +14,7 @@
 #include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 #include "qemu/range.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 8cecb53d5c..92b57d47c2 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -26,6 +26,7 @@
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_bridge.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/range.h"
 #include "qemu/units.h"
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 398db38f14..1a41c1d2ce 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -21,6 +21,7 @@
 
 #include "hw/vfio/vfio-platform.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qemu/range.h"
 #include "sysemu/sysemu.h"
 #include "exec/memory.h"
diff --git a/hw/virtio/vhost-scsi-pci.c b/hw/virtio/vhost-scsi-pci.c
index 523f7cb3ce..95a1f32439 100644
--- a/hw/virtio/vhost-scsi-pci.c
+++ b/hw/virtio/vhost-scsi-pci.c
@@ -19,6 +19,7 @@
 #include "standard-headers/linux/virtio_pci.h"
 #include "hw/virtio/vhost-scsi.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "virtio-pci.h"
 
 typedef struct VHostSCSIPCI VHostSCSIPCI;
diff --git a/hw/virtio/vhost-user-blk-pci.c b/hw/virtio/vhost-user-blk-pci.c
index ca66c217a7..ed81614d43 100644
--- a/hw/virtio/vhost-user-blk-pci.c
+++ b/hw/virtio/vhost-user-blk-pci.c
@@ -24,6 +24,7 @@
 #include "hw/pci/pci.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "virtio-pci.h"
 
 typedef struct VHostUserBlkPCI VHostUserBlkPCI;
diff --git a/hw/virtio/vhost-user-scsi-pci.c b/hw/virtio/vhost-user-scsi-pci.c
index 46f7193cc7..daeea77ce1 100644
--- a/hw/virtio/vhost-user-scsi-pci.c
+++ b/hw/virtio/vhost-user-scsi-pci.c
@@ -24,6 +24,7 @@
 #include "hw/pci/pci.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/loader.h"
diff --git a/hw/virtio/vhost-vsock-pci.c b/hw/virtio/vhost-vsock-pci.c
index 6f43ca35fb..c06c9a83b9 100644
--- a/hw/virtio/vhost-vsock-pci.c
+++ b/hw/virtio/vhost-vsock-pci.c
@@ -15,6 +15,7 @@
 
 #include "virtio-pci.h"
 #include "hw/virtio/vhost-vsock.h"
+#include "qemu/module.h"
 
 typedef struct VHostVSockPCI VHostVSockPCI;
 
diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index aa5af927e1..0371493197 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -20,6 +20,7 @@
 #include "qemu/error-report.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "qemu/iov.h"
+#include "qemu/module.h"
 #include "monitor/monitor.h"
 
 enum {
diff --git a/hw/virtio/virtio-9p-pci.c b/hw/virtio/virtio-9p-pci.c
index 7bf1130966..29c3712feb 100644
--- a/hw/virtio/virtio-9p-pci.c
+++ b/hw/virtio/virtio-9p-pci.c
@@ -17,6 +17,7 @@
 
 #include "virtio-pci.h"
 #include "hw/9pfs/virtio-9p.h"
+#include "qemu/module.h"
 
 /*
  * virtio-9p-pci: This extends VirtioPCIProxy.
diff --git a/hw/virtio/virtio-balloon-pci.c b/hw/virtio/virtio-balloon-pci.c
index 2a213bbb38..7393435a98 100644
--- a/hw/virtio/virtio-balloon-pci.c
+++ b/hw/virtio/virtio-balloon-pci.c
@@ -17,6 +17,7 @@
 #include "virtio-pci.h"
 #include "hw/virtio/virtio-balloon.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 
 typedef struct VirtIOBalloonPCI VirtIOBalloonPCI;
 
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 2112874055..11fad86d64 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -15,8 +15,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/iov.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
-#include "qemu-common.h"
 #include "hw/virtio/virtio.h"
 #include "hw/mem/pc-dimm.h"
 #include "sysemu/balloon.h"
diff --git a/hw/virtio/virtio-blk-pci.c b/hw/virtio/virtio-blk-pci.c
index 60c9185c39..d790b07a99 100644
--- a/hw/virtio/virtio-blk-pci.c
+++ b/hw/virtio/virtio-blk-pci.c
@@ -20,6 +20,7 @@
 #include "hw/virtio/virtio-blk.h"
 #include "virtio-pci.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 
 typedef struct VirtIOBlkPCI VirtIOBlkPCI;
 
diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index f9bc9ea46d..1d29a631f3 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "hw/qdev.h"
 #include "hw/virtio/virtio-bus.h"
diff --git a/hw/virtio/virtio-crypto-pci.c b/hw/virtio/virtio-crypto-pci.c
index 13807e538b..c8a2317a10 100644
--- a/hw/virtio/virtio-crypto-pci.c
+++ b/hw/virtio/virtio-crypto-pci.c
@@ -11,6 +11,7 @@
  * top-level directory.
  *
  */
+
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
 #include "hw/virtio/virtio.h"
@@ -18,6 +19,7 @@
 #include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-crypto.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 
 typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
 
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 9a9fa495d2..45187d3344 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -10,8 +10,10 @@
  * (at your option) any later version.  See the COPYING file in the
  * top-level directory.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/iov.h"
+#include "qemu/module.h"
 #include "hw/qdev.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/virtio/virtio-input-host-pci.c b/hw/virtio/virtio-input-host-pci.c
index 124c4f3447..a82eb5d914 100644
--- a/hw/virtio/virtio-input-host-pci.c
+++ b/hw/virtio/virtio-input-host-pci.c
@@ -10,6 +10,7 @@
 
 #include "virtio-pci.h"
 #include "hw/virtio/virtio-input.h"
+#include "qemu/module.h"
 
 typedef struct VirtIOInputHostPCI VirtIOInputHostPCI;
 
diff --git a/hw/virtio/virtio-input-pci.c b/hw/virtio/virtio-input-pci.c
index 28477729a3..1c40292abc 100644
--- a/hw/virtio/virtio-input-pci.c
+++ b/hw/virtio/virtio-input-pci.c
@@ -10,6 +10,7 @@
 
 #include "virtio-pci.h"
 #include "hw/virtio/virtio-input.h"
+#include "qemu/module.h"
 
 typedef struct VirtIOInputPCI VirtIOInputPCI;
 typedef struct VirtIOInputHIDPCI VirtIOInputHIDPCI;
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 5807aa87fe..d22071a8e4 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -24,6 +24,7 @@
 #include "hw/sysbus.h"
 #include "hw/virtio/virtio.h"
 #include "qemu/host-utils.h"
+#include "qemu/module.h"
 #include "sysemu/kvm.h"
 #include "hw/virtio/virtio-bus.h"
 #include "qemu/error-report.h"
diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
index db07ab9e21..5df36f26bf 100644
--- a/hw/virtio/virtio-net-pci.c
+++ b/hw/virtio/virtio-net-pci.c
@@ -20,6 +20,7 @@
 #include "hw/virtio/virtio-net.h"
 #include "virtio-pci.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 
 typedef struct VirtIONetPCI VirtIONetPCI;
 
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 9056cdfa3c..e6d5467e54 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -23,6 +23,7 @@
 #include "hw/pci/pci_bus.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/loader.h"
diff --git a/hw/virtio/virtio-rng-pci.c b/hw/virtio/virtio-rng-pci.c
index 6cc6374289..8aaf54b781 100644
--- a/hw/virtio/virtio-rng-pci.c
+++ b/hw/virtio/virtio-rng-pci.c
@@ -14,6 +14,7 @@
 #include "virtio-pci.h"
 #include "hw/virtio/virtio-rng.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 
 typedef struct VirtIORngPCI VirtIORngPCI;
 
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 30493a2586..db6d1d9454 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/iov.h"
+#include "qemu/module.h"
 #include "hw/qdev.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-rng.h"
diff --git a/hw/virtio/virtio-scsi-pci.c b/hw/virtio/virtio-scsi-pci.c
index 2830849729..f68f689aee 100644
--- a/hw/virtio/virtio-scsi-pci.c
+++ b/hw/virtio/virtio-scsi-pci.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/virtio/virtio-scsi.h"
+#include "qemu/module.h"
 #include "virtio-pci.h"
 
 typedef struct VirtIOSCSIPCI VirtIOSCSIPCI;
diff --git a/hw/virtio/virtio-serial-pci.c b/hw/virtio/virtio-serial-pci.c
index 971b2eb8d8..ac74b44dae 100644
--- a/hw/virtio/virtio-serial-pci.c
+++ b/hw/virtio/virtio-serial-pci.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/virtio/virtio-serial.h"
+#include "qemu/module.h"
 #include "virtio-pci.h"
 
 typedef struct VirtIOSerialPCI VirtIOSerialPCI;
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 4805727b53..f87cff4f8f 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -13,11 +13,11 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "trace.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "hw/virtio/virtio.h"
 #include "qemu/atomic.h"
 #include "hw/virtio/virtio-bus.h"
diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-watchdog.c
index 9c865bce67..54ac393020 100644
--- a/hw/watchdog/cmsdk-apb-watchdog.c
+++ b/hw/watchdog/cmsdk-apb-watchdog.c
@@ -25,6 +25,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 #include "sysemu/watchdog.h"
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 95f6ad186d..4a8409f0da 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -11,6 +11,7 @@
 
 #include "qapi/error.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "sysemu/watchdog.h"
 #include "hw/misc/aspeed_scu.h"
diff --git a/hw/watchdog/wdt_diag288.c b/hw/watchdog/wdt_diag288.c
index 1475743527..29e5b5dcf6 100644
--- a/hw/watchdog/wdt_diag288.c
+++ b/hw/watchdog/wdt_diag288.c
@@ -17,6 +17,7 @@
 #include "qemu/timer.h"
 #include "hw/watchdog/wdt_diag288.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 
 static WatchdogTimerModel model = {
     .wdt_name = TYPE_WDT_DIAG288,
diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
index 1c6eddf86a..441cd4a551 100644
--- a/hw/watchdog/wdt_i6300esb.c
+++ b/hw/watchdog/wdt_i6300esb.c
@@ -21,7 +21,7 @@
 
 #include "qemu/osdep.h"
 
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "sysemu/watchdog.h"
 #include "hw/hw.h"
diff --git a/hw/watchdog/wdt_ib700.c b/hw/watchdog/wdt_ib700.c
index d045032bf4..e0e5beb99d 100644
--- a/hw/watchdog/wdt_ib700.c
+++ b/hw/watchdog/wdt_ib700.c
@@ -20,7 +20,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "sysemu/watchdog.h"
 #include "hw/hw.h"
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 49a725e8c7..a4416d0bcf 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -7,6 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 #include "qemu/uuid.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index 0e9e58f04d..32503cfc1c 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "hw/xen/xen-legacy-backend.h"
 #include "chardev/char.h"
 #include "sysemu/accel.h"
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 6f7916f88f..eaa050a7ab 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -6,6 +6,7 @@
 #include "sysemu/blockdev.h"
 #include "sysemu/accel.h"
 #include "hw/qdev.h"
+#include "qemu/module.h"
 #include "qom/object.h"
 #include "qom/cpu.h"
 
diff --git a/include/hw/hw.h b/include/hw/hw.h
index ab4950c312..b1b79964b5 100644
--- a/include/hw/hw.h
+++ b/include/hw/hw.h
@@ -12,7 +12,6 @@
 #include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "migration/qemu-file-types.h"
-#include "qemu/module.h"
 #include "sysemu/reset.h"
 
 void QEMU_NORETURN hw_error(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 43df7230a2..c54cc54a47 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -1,7 +1,6 @@
 #ifndef HW_PC_H
 #define HW_PC_H
 
-#include "qemu-common.h"
 #include "exec/memory.h"
 #include "hw/boards.h"
 #include "hw/isa/isa.h"
@@ -12,6 +11,7 @@
 
 #include "qemu/range.h"
 #include "qemu/bitmap.h"
+#include "qemu/module.h"
 #include "sysemu/sysemu.h"
 #include "hw/pci/pci.h"
 #include "hw/mem/pc-dimm.h"
diff --git a/include/qemu-common.h b/include/qemu-common.h
index 9b01f6e7cb..e15adc20dc 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -113,8 +113,6 @@ void os_setup_early_signal_handling(void);
 char *os_find_datadir(void);
 int os_parse_cmd_args(int index, const char *optarg);
 
-#include "qemu/module.h"
-
 /*
  * Hexdump a buffer to a file. An optional string prefix is added to every line
  */
diff --git a/include/qom/object.h b/include/qom/object.h
index 288cdddf44..7bb82a7f56 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -16,6 +16,7 @@
 
 #include "qapi/qapi-builtin-types.h"
 #include "qemu/queue.h"
+#include "qemu/module.h"
 
 struct TypeImpl;
 typedef struct TypeImpl *Type;
diff --git a/io/channel-buffer.c b/io/channel-buffer.c
index 43d795976d..5402e0cced 100644
--- a/io/channel-buffer.c
+++ b/io/channel-buffer.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "io/channel-buffer.h"
 #include "io/channel-watch.h"
+#include "qemu/module.h"
 #include "qemu/sockets.h"
 #include "trace.h"
 
diff --git a/io/channel-command.c b/io/channel-command.c
index 3e7eb17eff..368dd62b7e 100644
--- a/io/channel-command.c
+++ b/io/channel-command.c
@@ -22,6 +22,7 @@
 #include "io/channel-command.h"
 #include "io/channel-watch.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "qemu/sockets.h"
 #include "trace.h"
 
diff --git a/io/channel-file.c b/io/channel-file.c
index db948abc3e..dac21f6012 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -22,6 +22,7 @@
 #include "io/channel-file.h"
 #include "io/channel-watch.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "qemu/sockets.h"
 #include "trace.h"
 
diff --git a/io/channel-socket.c b/io/channel-socket.c
index bc5f80e780..d898cfcd47 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-sockets.h"
+#include "qemu/module.h"
 #include "io/channel-socket.h"
 #include "io/channel-watch.h"
 #include "trace.h"
diff --git a/io/channel-tls.c b/io/channel-tls.c
index c98ead21b0..7ec8ceff2f 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "io/channel-tls.h"
 #include "trace.h"
 
diff --git a/io/channel-websock.c b/io/channel-websock.c
index 77d30f0e4a..fc36d44eba 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -25,6 +25,7 @@
 #include "crypto/hash.h"
 #include "trace.h"
 #include "qemu/iov.h"
+#include "qemu/module.h"
 
 /* Max amount to allow in rawinput/encoutput buffers */
 #define QIO_CHANNEL_WEBSOCK_MAX_BUFFER 8192
diff --git a/io/channel.c b/io/channel.c
index 2a26c2a2c0..e4376eb0bc 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -22,6 +22,7 @@
 #include "io/channel.h"
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 #include "qemu/iov.h"
 
 bool qio_channel_has_feature(QIOChannel *ioc,
diff --git a/io/dns-resolver.c b/io/dns-resolver.c
index 187f725665..6ebe2a5650 100644
--- a/io/dns-resolver.c
+++ b/io/dns-resolver.c
@@ -25,6 +25,7 @@
 #include "qemu/sockets.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
+#include "qemu/module.h"
 
 #ifndef AI_NUMERICSERV
 # define AI_NUMERICSERV 0
diff --git a/io/net-listener.c b/io/net-listener.c
index 3317aa6e5f..d8cfe52673 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -22,6 +22,7 @@
 #include "io/net-listener.h"
 #include "io/dns-resolver.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 
 QIONetListener *qio_net_listener_new(void)
 {
diff --git a/linux-user/main.c b/linux-user/main.c
index dae193fa7e..de26b9b342 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -31,6 +31,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/help_option.h"
+#include "qemu/module.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "tcg.h"
diff --git a/migration/rdma.c b/migration/rdma.c
index c1bcece53b..74cb2aa9f9 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -13,9 +13,9 @@
  * later.  See the COPYING file in the top-level directory.
  *
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "rdma.h"
 #include "migration.h"
@@ -24,6 +24,7 @@
 #include "qemu-file-channel.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 #include "qemu/sockets.h"
 #include "qemu/bitmap.h"
 #include "qemu/coroutine.h"
diff --git a/net/can/can_core.c b/net/can/can_core.c
index 2a83cadfc5..90f4d8576a 100644
--- a/net/can/can_core.c
+++ b/net/can/can_core.c
@@ -24,8 +24,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "chardev/char.h"
+#include "qemu/module.h"
 #include "qemu/sockets.h"
 #include "qapi/error.h"
 #include "net/can_emu.h"
diff --git a/net/can/can_host.c b/net/can/can_host.c
index c79347abab..1dfaf0ced0 100644
--- a/net/can/can_host.c
+++ b/net/can/can_host.c
@@ -24,8 +24,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "chardev/char.h"
+#include "qemu/module.h"
 #include "qemu/sockets.h"
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
diff --git a/net/can/can_socketcan.c b/net/can/can_socketcan.c
index 39865e28e0..3dec108684 100644
--- a/net/can/can_socketcan.c
+++ b/net/can/can_socketcan.c
@@ -24,8 +24,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "chardev/char.h"
 #include "qemu/sockets.h"
diff --git a/net/dump.c b/net/dump.c
index f16c3545e9..cd34f51759 100644
--- a/net/dump.c
+++ b/net/dump.c
@@ -25,10 +25,10 @@
 #include "qemu/osdep.h"
 #include "clients.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "qemu/iov.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "qapi/visitor.h"
 #include "net/filter.h"
diff --git a/net/filter-replay.c b/net/filter-replay.c
index 09e68fd8f5..9dda193928 100644
--- a/net/filter-replay.c
+++ b/net/filter-replay.c
@@ -11,10 +11,10 @@
 
 #include "qemu/osdep.h"
 #include "clients.h"
-#include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "qemu/iov.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qemu/timer.h"
 #include "qapi/visitor.h"
 #include "net/filter.h"
diff --git a/net/filter.c b/net/filter.c
index 28d1930db7..4b932e79f9 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 
@@ -17,6 +16,7 @@
 #include "net/vhost_net.h"
 #include "qom/object_interfaces.h"
 #include "qemu/iov.h"
+#include "qemu/module.h"
 #include "net/colo.h"
 #include "migration/colo.h"
 
diff --git a/qemu-img.c b/qemu-img.c
index 28fba1e7a7..e0269fd7fa 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -37,6 +37,7 @@
 #include "qemu/option.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
+#include "qemu/module.h"
 #include "qemu/units.h"
 #include "qom/object_interfaces.h"
 #include "sysemu/sysemu.h"
diff --git a/qemu-io.c b/qemu-io.c
index 8d5d5911cb..968f0e3dbf 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -19,6 +19,7 @@
 #include "qemu-io.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qemu/readline.h"
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 25ce71e160..410373a321 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -21,13 +21,13 @@
 #include <libgen.h>
 #include <pthread.h>
 
-#include "qemu-common.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "sysemu/block-backend.h"
 #include "block/block_int.h"
 #include "block/nbd.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/error-report.h"
 #include "qemu/config-file.h"
diff --git a/qga/main.c b/qga/main.c
index c0d77c79c4..b54b55589d 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -23,7 +23,6 @@
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qstring.h"
 #include "guest-agent-core.h"
-#include "qemu/module.h"
 #include "qga-qapi-commands.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/error.h"
diff --git a/qtest.c b/qtest.c
index f2e2f27778..15e27e911f 100644
--- a/qtest.c
+++ b/qtest.c
@@ -13,7 +13,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "sysemu/qtest.h"
 #include "hw/qdev.h"
@@ -27,6 +26,7 @@
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qemu/cutils.h"
 #ifdef TARGET_PPC64
 #include "hw/ppc/spapr_rtas.h"
diff --git a/replication.h b/replication.h
index 0a8cc2be7c..eb6a47c50d 100644
--- a/replication.h
+++ b/replication.h
@@ -18,6 +18,7 @@
 #define REPLICATION_H
 
 #include "qapi/qapi-types-block-core.h"
+#include "qemu/module.h"
 #include "qemu/queue.h"
 
 typedef struct ReplicationOps ReplicationOps;
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 6d66bf6aa3..b929e07be4 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -249,8 +249,6 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModularCVisitor):
         visit = self._module_basename('qapi-visit', name)
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "qemu/module.h"
 #include "qapi/visitor.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qobject-output-visitor.h"
diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
index 438380fced..ca27c93283 100644
--- a/scsi/pr-manager-helper.c
+++ b/scsi/pr-manager-helper.c
@@ -18,6 +18,7 @@
 #include "io/channel-socket.h"
 #include "pr-helper.h"
 #include "qapi/qapi-events-block.h"
+#include "qemu/module.h"
 
 #include <scsi/sg.h>
 
diff --git a/scsi/pr-manager.c b/scsi/pr-manager.c
index d9f4e8c3ad..ee43663576 100644
--- a/scsi/pr-manager.c
+++ b/scsi/pr-manager.c
@@ -18,6 +18,7 @@
 #include "scsi/pr-manager.h"
 #include "trace.h"
 #include "qapi/qapi-types-block.h"
+#include "qemu/module.h"
 #include "qapi/qapi-commands-block.h"
 
 #define PR_MANAGER_PATH     "/objects"
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 2541fbbd1b..72acdc7527 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -37,9 +37,9 @@
 #endif
 
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "qemu/config-file.h"
 #include "qemu/bswap.h"
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 27c8a09da4..1a9bea9289 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "target/arm/idau.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "cpu.h"
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 228906f267..4d2e7ad75d 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/loader.h"
 #endif
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 9717ea1798..5ee3e697d1 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -22,7 +22,7 @@
 #include "qapi/error.h"
 #include "qemu/qemu-print.h"
 #include "cpu.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "exec/exec-all.h"
 #include "fpu/softfloat.h"
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7548212f09..0dbb34acb4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -32,6 +32,7 @@
 #include "sev_i386.h"
 
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qapi/error.h"
diff --git a/target/i386/sev.c b/target/i386/sev.c
index cd77f6b5d4..6dbdc3cdf1 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -21,6 +21,7 @@
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
 #include "qemu/base64.h"
+#include "qemu/module.h"
 #include "sysemu/kvm.h"
 #include "sev_i386.h"
 #include "sysemu/sysemu.h"
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 0ea549910b..09fcd989aa 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "exec/exec-all.h"
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index a33058609a..c7226bd7ae 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -23,7 +23,7 @@
 #include "cpu.h"
 #include "internal.h"
 #include "kvm_mips.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "sysemu/kvm.h"
 #include "exec/exec-all.h"
 
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index 186af4913d..e25ce4e372 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -19,7 +19,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "exec/log.h"
diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 9d7050b5fa..086548e9b9 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -21,6 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "qemu/module.h"
 #include "cpu-models.h"
 
 #if defined(CONFIG_USER_ONLY)
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index f44e966a61..6093edd767 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -29,6 +29,7 @@
 #include "mmu-hash32.h"
 #include "mmu-hash64.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qemu/qemu-print.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qnull.h"
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 3ee24b8541..a9d58716f0 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -28,6 +28,7 @@
 #include "sysemu/kvm.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "trace.h"
 #include "qapi/visitor.h"
 #include "qapi/qapi-visit-misc.h"
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 7478b04621..cdee8788a1 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -19,6 +19,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qemu/qemu-print.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qobject-input-visitor.h"
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index f93ce72eb9..382565792c 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "qemu/module.h"
 #include "qemu/qemu-print.h"
 #include "exec/exec-all.h"
 #include "hw/qdev-properties.h"
diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
index b209c55387..b573a07652 100644
--- a/target/tilegx/cpu.c
+++ b/target/tilegx/cpu.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "hw/qdev-properties.h"
 #include "linux-user/syscall_defs.h"
 #include "qemu/qemu-print.h"
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index c79dc75bfe..adba19ed17 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -31,7 +31,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "migration/vmstate.h"
 
 
diff --git a/tests/ac97-test.c b/tests/ac97-test.c
index 532fb1cc98..b084e31bff 100644
--- a/tests/ac97-test.c
+++ b/tests/ac97-test.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
 
diff --git a/tests/e1000-test.c b/tests/e1000-test.c
index 9e67916169..c387984ef6 100644
--- a/tests/e1000-test.c
+++ b/tests/e1000-test.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
 
diff --git a/tests/e1000e-test.c b/tests/e1000e-test.c
index 6a946c0484..781fcbfd89 100644
--- a/tests/e1000e-test.c
+++ b/tests/e1000e-test.c
@@ -30,6 +30,7 @@
 #include "libqos/pci-pc.h"
 #include "qemu/sockets.h"
 #include "qemu/iov.h"
+#include "qemu/module.h"
 #include "qemu/bitops.h"
 #include "libqos/malloc.h"
 #include "libqos/e1000e.h"
diff --git a/tests/eepro100-test.c b/tests/eepro100-test.c
index 90b5c1afd9..8dbffff0b8 100644
--- a/tests/eepro100-test.c
+++ b/tests/eepro100-test.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
 
diff --git a/tests/es1370-test.c b/tests/es1370-test.c
index d845cd06f8..adccdac1be 100644
--- a/tests/es1370-test.c
+++ b/tests/es1370-test.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
 
diff --git a/tests/ipoctal232-test.c b/tests/ipoctal232-test.c
index 42d53718b8..53a8c9b13c 100644
--- a/tests/ipoctal232-test.c
+++ b/tests/ipoctal232-test.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "libqos/qgraph.h"
 
 typedef struct QIpoctal232 QIpoctal232;
diff --git a/tests/libqos/aarch64-xlnx-zcu102-machine.c b/tests/libqos/aarch64-xlnx-zcu102-machine.c
index 6fff040b37..1d5de5af00 100644
--- a/tests/libqos/aarch64-xlnx-zcu102-machine.c
+++ b/tests/libqos/aarch64-xlnx-zcu102-machine.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "libqos/malloc.h"
 #include "libqos/qgraph.h"
 #include "sdhci.h"
diff --git a/tests/libqos/arm-raspi2-machine.c b/tests/libqos/arm-raspi2-machine.c
index 3aff670f76..12a7cb7e4b 100644
--- a/tests/libqos/arm-raspi2-machine.c
+++ b/tests/libqos/arm-raspi2-machine.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "libqos/malloc.h"
 #include "libqos/qgraph.h"
 #include "sdhci.h"
diff --git a/tests/libqos/arm-sabrelite-machine.c b/tests/libqos/arm-sabrelite-machine.c
index c4128d8686..e6df43795a 100644
--- a/tests/libqos/arm-sabrelite-machine.c
+++ b/tests/libqos/arm-sabrelite-machine.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "libqos/malloc.h"
 #include "libqos/qgraph.h"
 #include "sdhci.h"
diff --git a/tests/libqos/arm-smdkc210-machine.c b/tests/libqos/arm-smdkc210-machine.c
index 1fb9dfc0cb..215b628a7d 100644
--- a/tests/libqos/arm-smdkc210-machine.c
+++ b/tests/libqos/arm-smdkc210-machine.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "libqos/malloc.h"
 #include "libqos/qgraph.h"
 #include "sdhci.h"
diff --git a/tests/libqos/arm-virt-machine.c b/tests/libqos/arm-virt-machine.c
index 2abc431ecf..96ffe3ee5c 100644
--- a/tests/libqos/arm-virt-machine.c
+++ b/tests/libqos/arm-virt-machine.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "libqos/malloc.h"
 #include "libqos/qgraph.h"
 #include "libqos/virtio-mmio.h"
diff --git a/tests/libqos/arm-xilinx-zynq-a9-machine.c b/tests/libqos/arm-xilinx-zynq-a9-machine.c
index 4e199fcd48..5bc95f2e73 100644
--- a/tests/libqos/arm-xilinx-zynq-a9-machine.c
+++ b/tests/libqos/arm-xilinx-zynq-a9-machine.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "libqos/malloc.h"
 #include "libqos/qgraph.h"
 #include "sdhci.h"
diff --git a/tests/libqos/e1000e.c b/tests/libqos/e1000e.c
index 54d3898899..1d0592974e 100644
--- a/tests/libqos/e1000e.c
+++ b/tests/libqos/e1000e.c
@@ -18,10 +18,10 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "qemu-common.h"
 #include "libqos/pci-pc.h"
 #include "qemu/sockets.h"
 #include "qemu/iov.h"
+#include "qemu/module.h"
 #include "qemu/bitops.h"
 #include "libqos/malloc.h"
 #include "libqos/qgraph.h"
diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
index 634fedd049..0bc591d1da 100644
--- a/tests/libqos/pci-pc.c
+++ b/tests/libqos/pci-pc.c
@@ -16,7 +16,7 @@
 #include "qapi/qmp/qdict.h"
 #include "hw/pci/pci_regs.h"
 
-#include "qemu-common.h"
+#include "qemu/module.h"
 
 #define ACPI_PCIHP_ADDR         0xae00
 #define PCI_EJ_BASE             0x0008
diff --git a/tests/libqos/pci-spapr.c b/tests/libqos/pci-spapr.c
index 58ba27ae6d..d6f8c01cb7 100644
--- a/tests/libqos/pci-spapr.c
+++ b/tests/libqos/pci-spapr.c
@@ -13,8 +13,8 @@
 
 #include "hw/pci/pci_regs.h"
 
-#include "qemu-common.h"
 #include "qemu/host-utils.h"
+#include "qemu/module.h"
 
 /*
  * PCI devices are always little-endian
diff --git a/tests/libqos/ppc64_pseries-machine.c b/tests/libqos/ppc64_pseries-machine.c
index 2f3640010d..867f27a3c8 100644
--- a/tests/libqos/ppc64_pseries-machine.c
+++ b/tests/libqos/ppc64_pseries-machine.c
@@ -16,10 +16,11 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>
  */
 
- #include "qemu/osdep.h"
+#include "qemu/osdep.h"
 #include "libqtest.h"
 #include "libqos/qgraph.h"
 #include "pci-spapr.h"
+#include "qemu/module.h"
 #include "libqos/malloc-spapr.h"
 
 typedef struct QSPAPR_pci_host QSPAPR_pci_host;
diff --git a/tests/libqos/sdhci.c b/tests/libqos/sdhci.c
index 22c33de453..309794bc52 100644
--- a/tests/libqos/sdhci.c
+++ b/tests/libqos/sdhci.c
@@ -20,6 +20,7 @@
 #include "libqtest.h"
 #include "libqos/qgraph.h"
 #include "pci.h"
+#include "qemu/module.h"
 #include "sdhci.h"
 #include "hw/pci/pci.h"
 
diff --git a/tests/libqos/tpci200.c b/tests/libqos/tpci200.c
index 98dc532933..ae590a456e 100644
--- a/tests/libqos/tpci200.c
+++ b/tests/libqos/tpci200.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
 
diff --git a/tests/libqos/virtio-9p.c b/tests/libqos/virtio-9p.c
index a378b56fa9..8c9efce3e1 100644
--- a/tests/libqos/virtio-9p.c
+++ b/tests/libqos/virtio-9p.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "standard-headers/linux/virtio_ids.h"
 #include "libqos/virtio-9p.h"
 #include "libqos/qgraph.h"
diff --git a/tests/libqos/virtio-balloon.c b/tests/libqos/virtio-balloon.c
index 7e6e9e9de5..42a4c5831e 100644
--- a/tests/libqos/virtio-balloon.c
+++ b/tests/libqos/virtio-balloon.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "libqos/qgraph.h"
 #include "libqos/virtio-balloon.h"
 
diff --git a/tests/libqos/virtio-blk.c b/tests/libqos/virtio-blk.c
index c17bdf4217..726e93c5c1 100644
--- a/tests/libqos/virtio-blk.c
+++ b/tests/libqos/virtio-blk.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "standard-headers/linux/virtio_blk.h"
 #include "libqos/qgraph.h"
 #include "libqos/virtio-blk.h"
diff --git a/tests/libqos/virtio-mmio.c b/tests/libqos/virtio-mmio.c
index 213a5f9de0..5f37b51129 100644
--- a/tests/libqos/virtio-mmio.c
+++ b/tests/libqos/virtio-mmio.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "libqos/virtio.h"
 #include "libqos/virtio-mmio.h"
 #include "libqos/malloc.h"
diff --git a/tests/libqos/virtio-net.c b/tests/libqos/virtio-net.c
index 61c56170e9..66405b646e 100644
--- a/tests/libqos/virtio-net.c
+++ b/tests/libqos/virtio-net.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "libqos/qgraph.h"
 #include "libqos/virtio-net.h"
 #include "hw/virtio/virtio-net.h"
diff --git a/tests/libqos/virtio-rng.c b/tests/libqos/virtio-rng.c
index a1d2c7671c..b86349e2fd 100644
--- a/tests/libqos/virtio-rng.c
+++ b/tests/libqos/virtio-rng.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "libqos/qgraph.h"
 #include "libqos/virtio-rng.h"
 
diff --git a/tests/libqos/virtio-scsi.c b/tests/libqos/virtio-scsi.c
index 482684d0bc..94842ec3fa 100644
--- a/tests/libqos/virtio-scsi.c
+++ b/tests/libqos/virtio-scsi.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "standard-headers/linux/virtio_ids.h"
 #include "libqos/qgraph.h"
 #include "libqos/virtio-scsi.h"
diff --git a/tests/libqos/virtio-serial.c b/tests/libqos/virtio-serial.c
index 91cedefb8d..3e5b8b82c7 100644
--- a/tests/libqos/virtio-serial.c
+++ b/tests/libqos/virtio-serial.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "libqos/qgraph.h"
 #include "libqos/virtio-serial.h"
 
diff --git a/tests/libqos/x86_64_pc-machine.c b/tests/libqos/x86_64_pc-machine.c
index 8bd0360ba9..6dfa705217 100644
--- a/tests/libqos/x86_64_pc-machine.c
+++ b/tests/libqos/x86_64_pc-machine.c
@@ -20,6 +20,7 @@
 #include "libqtest.h"
 #include "libqos/qgraph.h"
 #include "pci-pc.h"
+#include "qemu/module.h"
 #include "malloc-pc.h"
 
 typedef struct QX86PCMachine QX86PCMachine;
diff --git a/tests/megasas-test.c b/tests/megasas-test.c
index 1111d331d3..c3e4ab6595 100644
--- a/tests/megasas-test.c
+++ b/tests/megasas-test.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qemu/bswap.h"
+#include "qemu/module.h"
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
 
diff --git a/tests/migration-test.c b/tests/migration-test.c
index bd3f5c3125..9681af70da 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -15,6 +15,7 @@
 #include "libqtest.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/range.h"
 #include "qemu/sockets.h"
diff --git a/tests/ne2000-test.c b/tests/ne2000-test.c
index 097c2eec6c..3fc0e555d5 100644
--- a/tests/ne2000-test.c
+++ b/tests/ne2000-test.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
 
diff --git a/tests/nvme-test.c b/tests/nvme-test.c
index b48d3a24b9..505299324b 100644
--- a/tests/nvme-test.c
+++ b/tests/nvme-test.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/module.h"
 #include "qemu/units.h"
 #include "libqtest.h"
 #include "libqos/qgraph.h"
diff --git a/tests/pci-test.c b/tests/pci-test.c
index ff80985093..4b2092b949 100644
--- a/tests/pci-test.c
+++ b/tests/pci-test.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
 
diff --git a/tests/pcnet-test.c b/tests/pcnet-test.c
index 484448cc64..900944fa7e 100644
--- a/tests/pcnet-test.c
+++ b/tests/pcnet-test.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
 
diff --git a/tests/qos-test.c b/tests/qos-test.c
index ae2fb5de1c..07cc3538c6 100644
--- a/tests/qos-test.c
+++ b/tests/qos-test.c
@@ -22,6 +22,7 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qstring.h"
+#include "qemu/module.h"
 #include "qapi/qmp/qlist.h"
 #include "libqos/malloc.h"
 #include "libqos/qgraph.h"
diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 2f177e569f..6275e7626c 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -7,9 +7,11 @@
  * See the COPYING file in the top-level directory.
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
+
 #include "qemu/osdep.h"
 #include "hw/registerfields.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "libqos/pci-pc.h"
 #include "hw/pci/pci.h"
 #include "libqos/qgraph.h"
diff --git a/tests/spapr-phb-test.c b/tests/spapr-phb-test.c
index 39b5766710..093dc22f2f 100644
--- a/tests/spapr-phb-test.c
+++ b/tests/spapr-phb-test.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "libqos/qgraph.h"
 
 /* Tests only initialization so far. TODO: Replace with functional tests,
diff --git a/tests/test-authz-list.c b/tests/test-authz-list.c
index 24347a6ac3..d80e6a6d4d 100644
--- a/tests/test-authz-list.c
+++ b/tests/test-authz-list.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 
 #include "authz/list.h"
+#include "qemu/module.h"
 
 static void test_authz_default_deny(void)
 {
diff --git a/tests/test-authz-listfile.c b/tests/test-authz-listfile.c
index 1e452fef6d..26166b691b 100644
--- a/tests/test-authz-listfile.c
+++ b/tests/test-authz-listfile.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
+#include "qemu/module.h"
 #include "authz/listfile.h"
 
 static char *workdir;
diff --git a/tests/test-authz-pam.c b/tests/test-authz-pam.c
index 93d5ac8bbf..02bb1493e7 100644
--- a/tests/test-authz-pam.c
+++ b/tests/test-authz-pam.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "authz/pamacct.h"
 
 #include <security/pam_appl.h>
diff --git a/tests/test-authz-simple.c b/tests/test-authz-simple.c
index 2cf14fb87e..d21d43e2e9 100644
--- a/tests/test-authz-simple.c
+++ b/tests/test-authz-simple.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 
 #include "authz/simple.h"
 
diff --git a/tests/test-char.c b/tests/test-char.c
index 95ccfd3cdb..f9440cdcfd 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -2,6 +2,7 @@
 #include <glib/gstdio.h>
 
 #include "qemu/config-file.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/sockets.h"
 #include "chardev/char-fe.h"
diff --git a/tests/test-crypto-block.c b/tests/test-crypto-block.c
index d309d044ef..7c1ab07855 100644
--- a/tests/test-crypto-block.c
+++ b/tests/test-crypto-block.c
@@ -23,6 +23,7 @@
 #include "crypto/init.h"
 #include "crypto/block.h"
 #include "qemu/buffer.h"
+#include "qemu/module.h"
 #include "crypto/secret.h"
 #ifndef _WIN32
 #include <sys/resource.h>
diff --git a/tests/test-crypto-tlscredsx509.c b/tests/test-crypto-tlscredsx509.c
index 940a026c6e..a27efb7540 100644
--- a/tests/test-crypto-tlscredsx509.c
+++ b/tests/test-crypto-tlscredsx509.c
@@ -23,6 +23,7 @@
 #include "crypto-tls-x509-helpers.h"
 #include "crypto/tlscredsx509.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 
 #ifdef QCRYPTO_HAVE_TLS_TEST_SUPPORT
 
diff --git a/tests/test-crypto-tlssession.c b/tests/test-crypto-tlssession.c
index 15212ec276..6560d7134f 100644
--- a/tests/test-crypto-tlssession.c
+++ b/tests/test-crypto-tlssession.c
@@ -27,6 +27,7 @@
 #include "crypto/tlssession.h"
 #include "qom/object_interfaces.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "qemu/sockets.h"
 #include "authz/list.h"
 
diff --git a/tests/test-io-channel-buffer.c b/tests/test-io-channel-buffer.c
index 64722a214b..59d6c64b04 100644
--- a/tests/test-io-channel-buffer.c
+++ b/tests/test-io-channel-buffer.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "io/channel-buffer.h"
+#include "qemu/module.h"
 #include "io-channel-helpers.h"
 
 
diff --git a/tests/test-io-channel-command.c b/tests/test-io-channel-command.c
index 46ce1ff01c..3bc5266121 100644
--- a/tests/test-io-channel-command.c
+++ b/tests/test-io-channel-command.c
@@ -22,6 +22,7 @@
 #include "io/channel-command.h"
 #include "io-channel-helpers.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 
 #ifndef WIN32
 static void test_io_channel_command_fifo(bool async)
diff --git a/tests/test-io-channel-file.c b/tests/test-io-channel-file.c
index 2e94f638f2..bac2b07562 100644
--- a/tests/test-io-channel-file.c
+++ b/tests/test-io-channel-file.c
@@ -23,6 +23,7 @@
 #include "io/channel-util.h"
 #include "io-channel-helpers.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 
 #define TEST_FILE "tests/test-io-channel-file.txt"
 #define TEST_MASK 0600
diff --git a/tests/test-io-channel-socket.c b/tests/test-io-channel-socket.c
index c253ae30f5..d2053c464c 100644
--- a/tests/test-io-channel-socket.c
+++ b/tests/test-io-channel-socket.c
@@ -24,6 +24,7 @@
 #include "io-channel-helpers.h"
 #include "socket-helpers.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 
 
 static void test_io_channel_set_socket_bufs(QIOChannel *src,
diff --git a/tests/test-io-channel-tls.c b/tests/test-io-channel-tls.c
index 43b707eba7..3c9ef6f941 100644
--- a/tests/test-io-channel-tls.c
+++ b/tests/test-io-channel-tls.c
@@ -30,6 +30,7 @@
 #include "crypto/init.h"
 #include "crypto/tlscredsx509.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 #include "authz/list.h"
 #include "qom/object_interfaces.h"
 
diff --git a/tests/test-io-task.c b/tests/test-io-task.c
index bac1bb4e7a..aa8b653bfa 100644
--- a/tests/test-io-task.c
+++ b/tests/test-io-task.c
@@ -22,6 +22,7 @@
 
 #include "io/task.h"
 #include "qapi/error.h"
+#include "qemu/module.h"
 
 #define TYPE_DUMMY "qemu:dummy"
 
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 630b1b9bac..f0b95dcbc3 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -1,10 +1,8 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/error.h"
-#include "qemu/module.h"
 #include "qapi/qobject-input-visitor.h"
 #include "tests/test-qapi-types.h"
 #include "tests/test-qapi-visit.h"
diff --git a/tests/test-throttle.c b/tests/test-throttle.c
index 948a42c991..a7cf00069b 100644
--- a/tests/test-throttle.c
+++ b/tests/test-throttle.c
@@ -18,6 +18,7 @@
 #include "qapi/error.h"
 #include "qemu/throttle.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "block/throttle-groups.h"
 #include "sysemu/block-backend.h"
 
diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index fc8ce62471..e80c4c6143 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -24,7 +24,6 @@
 
 #include "qemu/osdep.h"
 
-#include "qemu-common.h"
 #include "../migration/migration.h"
 #include "migration/vmstate.h"
 #include "migration/qemu-file-types.h"
@@ -32,6 +31,7 @@
 #include "../migration/qemu-file-channel.h"
 #include "../migration/savevm.h"
 #include "qemu/coroutine.h"
+#include "qemu/module.h"
 #include "io/channel-file.h"
 
 static char temp_file[] = "/tmp/vmst.test.XXXXXX";
diff --git a/tests/tpm-crb-swtpm-test.c b/tests/tpm-crb-swtpm-test.c
index 8c0a55f3ca..2c4fb8ae29 100644
--- a/tests/tpm-crb-swtpm-test.c
+++ b/tests/tpm-crb-swtpm-test.c
@@ -16,6 +16,7 @@
 #include <glib/gstdio.h>
 
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "tpm-tests.h"
 
 typedef struct TestState {
diff --git a/tests/tpm-crb-test.c b/tests/tpm-crb-test.c
index 6fde579bab..a139caa51d 100644
--- a/tests/tpm-crb-test.c
+++ b/tests/tpm-crb-test.c
@@ -16,6 +16,7 @@
 #include "hw/acpi/tpm.h"
 #include "io/channel-socket.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "tpm-emu.h"
 
 #define TPM_CMD "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00"
diff --git a/tests/tpm-tis-swtpm-test.c b/tests/tpm-tis-swtpm-test.c
index 7dcd1d3912..9f58a3a92b 100644
--- a/tests/tpm-tis-swtpm-test.c
+++ b/tests/tpm-tis-swtpm-test.c
@@ -16,6 +16,7 @@
 #include <glib/gstdio.h>
 
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "tpm-tests.h"
 
 typedef struct TestState {
diff --git a/tests/tpm-tis-test.c b/tests/tpm-tis-test.c
index c8ec14888f..92a7e95aad 100644
--- a/tests/tpm-tis-test.c
+++ b/tests/tpm-tis-test.c
@@ -18,6 +18,7 @@
 #include "hw/acpi/tpm.h"
 #include "io/channel-socket.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "tpm-emu.h"
 
 #define TIS_REG(LOCTY, REG) \
diff --git a/tests/usb-hcd-ohci-test.c b/tests/usb-hcd-ohci-test.c
index 98af02e898..c12b892085 100644
--- a/tests/usb-hcd-ohci-test.c
+++ b/tests/usb-hcd-ohci-test.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "libqos/usb.h"
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 3817966010..6ae8a23688 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -19,6 +19,7 @@
 #include "qemu/sockets.h"
 #include "chardev/char-fe.h"
 #include "qemu/memfd.h"
+#include "qemu/module.h"
 #include "sysemu/sysemu.h"
 #include "libqos/libqos.h"
 #include "libqos/pci-pc.h"
diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 16107ad280..ac49bca991 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "hw/9pfs/9p.h"
 #include "hw/9pfs/9p-synth.h"
 #include "libqos/virtio-9p.h"
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index fe1168a90a..1b02714bc7 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qemu/bswap.h"
+#include "qemu/module.h"
 #include "standard-headers/linux/virtio_blk.h"
 #include "standard-headers/linux/virtio_pci.h"
 #include "libqos/qgraph.h"
diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index 163126cf07..6a008bb552 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qemu/iov.h"
+#include "qemu/module.h"
 #include "qapi/qmp/qdict.h"
 #include "hw/virtio/virtio-net.h"
 #include "libqos/qgraph.h"
diff --git a/tests/virtio-rng-test.c b/tests/virtio-rng-test.c
index fcb22481bd..a38a0d175b 100644
--- a/tests/virtio-rng-test.c
+++ b/tests/virtio-rng-test.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "libqos/qgraph.h"
 #include "libqos/virtio-rng.h"
 
diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
index 162b31c88d..fca9f889be 100644
--- a/tests/virtio-scsi-test.c
+++ b/tests/virtio-scsi-test.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "scsi/constants.h"
 #include "libqos/libqos-pc.h"
 #include "libqos/libqos-spapr.h"
diff --git a/tests/virtio-serial-test.c b/tests/virtio-serial-test.c
index 85f35e09b7..066ca61280 100644
--- a/tests/virtio-serial-test.c
+++ b/tests/virtio-serial-test.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "libqos/virtio-serial.h"
 
 /* Tests only initialization so far. TODO: Replace with functional tests */
diff --git a/tests/virtio-test.c b/tests/virtio-test.c
index 804e5371dc..f7c6afdcf1 100644
--- a/tests/virtio-test.c
+++ b/tests/virtio-test.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
 
diff --git a/tests/vmxnet3-test.c b/tests/vmxnet3-test.c
index 35cdea939b..a81025252c 100644
--- a/tests/vmxnet3-test.c
+++ b/tests/vmxnet3-test.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
+#include "qemu/module.h"
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
 
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 420b2411c1..d9624021d5 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -27,7 +27,6 @@
 #import <Cocoa/Cocoa.h>
 #include <crt_externs.h>
 
-#include "qemu-common.h"
 #include "ui/console.h"
 #include "ui/input.h"
 #include "sysemu/sysemu.h"
@@ -36,6 +35,7 @@
 #include "qapi/qapi-commands-misc.h"
 #include "sysemu/blockdev.h"
 #include "qemu-version.h"
+#include "qemu/module.h"
 #include <Carbon/Carbon.h>
 #include "qom/cpu.h"
 
diff --git a/ui/console.c b/ui/console.c
index 6d2282d3e9..eb7e7e0c51 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -27,6 +27,7 @@
 #include "hw/qdev-core.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-ui.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/timer.h"
 #include "chardev/char-fe.h"
diff --git a/ui/curses.c b/ui/curses.c
index 1f3fcabb00..c95ece450b 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -21,6 +21,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 
 #ifndef _WIN32
@@ -33,7 +34,7 @@
 #include <iconv.h>
 
 #include "qapi/error.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "ui/console.h"
 #include "ui/input.h"
 #include "sysemu/sysemu.h"
diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index e67b47aeff..05b2e7d7b1 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "sysemu/sysemu.h"
 #include "ui/console.h"
 #include "ui/egl-helpers.h"
diff --git a/ui/input-linux.c b/ui/input-linux.c
index ba550dd274..c8d22f99d9 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -6,8 +6,8 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/config-file.h"
+#include "qemu/module.h"
 #include "qemu/sockets.h"
 #include "sysemu/sysemu.h"
 #include "ui/input.h"
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 1277cf28fb..b8a31197e8 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -24,7 +24,7 @@
 /* Ported SDL 1.2 code to 2.0 by Dave Airlie. */
 
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/module.h"
 #include "ui/console.h"
 #include "ui/input.h"
 #include "ui/sdl2.h"
diff --git a/ui/spice-app.c b/ui/spice-app.c
index 925b27b708..d6cade5cf1 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -21,15 +21,16 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 
 #include <gio/gio.h>
 
-#include "qemu-common.h"
 #include "ui/console.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "qemu/cutils.h"
+#include "qemu/module.h"
 #include "qapi/error.h"
 #include "io/channel-command.h"
 #include "chardev/spice.h"
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 0632c74e9f..2ffc3335f0 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -22,6 +22,7 @@
 
 #include "ui/qemu-spice.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qemu/thread.h"
 #include "qemu/timer.h"
 #include "qemu/queue.h"
diff --git a/ui/vnc.c b/ui/vnc.c
index 1871422e1d..781844d32a 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -30,6 +30,7 @@
 #include "trace.h"
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
+#include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/sockets.h"
 #include "qemu/timer.h"
-- 
2.17.2


