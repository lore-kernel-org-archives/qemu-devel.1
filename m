Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4E9C32771
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:18:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3690F214AF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCuKX+gl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3690F214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuv6M-0008VT-F4
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 04:18:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iuv5L-0007Nf-FG
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:17:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iuv5H-0000TY-SK
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:17:02 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47225
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iuv5H-0000SF-FP
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579857418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5LJdmv9OwWPxA8vdr8msyiECtTvqC+Dy/FvgDQaI8gM=;
 b=ZCuKX+glwDrhnSTyT05mHWGrCJF7nvx5hgOngoPaHS6La0Ujf4LtyVkt/xh9/8i9kYcmAW
 5zmS3OJVKd0zVRDibd8m7QeYsLrTb41SANSPLuoLed5j+YqixeD3NyWPF83CpWpOFb9osU
 0SEIuvh5BB8/bhjW/gQUrsSei2pxMDM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-50XuSyOHN8SACKLCN8_IQA-1; Fri, 24 Jan 2020 04:16:55 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61C2A1800D48
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 09:16:54 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 754CE5C1BB
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 09:16:53 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/59] Misc (x86 and QOM) patches for 2020-01-23
Date: Fri, 24 Jan 2020 10:16:50 +0100
Message-Id: <1579857411-12996-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 50XuSyOHN8SACKLCN8_IQA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 3e08b2b9cb64bff2b73fa9128c0e49bfcde0dd40=
:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-202001=
21' into staging (2020-01-21 15:29:25 +0000)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to b0993e347e065d2323fbb051fdd5a72c95a6e872:

  tests: fix test-qga on macosx (2020-01-24 10:14:32 +0100)

----------------------------------------------------------------
* Register qdev properties as class properties (Marc-Andr=C3=A9)
* Cleanups (Philippe)
* virtio-scsi fix (Pan Nengyuan)
* Tweak Skylake-v3 model id (Kashyap)
* x86 UCODE_REV support and nested live migration fix (myself)
* Advisory mode for pvpanic (Zhenwei)

----------------------------------------------------------------
Greg Kurz (2):
      cpu: Introduce cpu_class_set_parent_reset()
      cpu: Use cpu_class_set_parent_reset()

Kashyap Chamarthy (1):
      target/i386: Add the 'model-id' for Skylake -v3 CPU models

Marc-Andr=C3=A9 Lureau (25):
      object: add extra sanity checks
      qdev: remove duplicated qdev_property_add_static() doc
      qdev: remove extraneous error
      qdev: move helper function to monitor/misc
      object: avoid extra class property key duplication
      object: add class property initializer
      object: make object_class_property_add* return property
      qstring: add qstring_free()
      object: add object_property_set_default
      object: do not free class properties
      object: check strong flag with &
      object: rename link "child" to "target"
      object: add direct link flag
      object: express const link with link property
      object: add object_class_property_add_link()
      object: release all props
      object: return self in object_ref()
      qdev: set properties with device_class_set_props()
      qdev: move instance properties to class properties
      qdev: register properties as class properties
      vl: print default value in object help
      qom: introduce object_property_help()
      qapi/qmp: add ObjectPropertyInfo.default-value
      qdev: use object_property_help()
      tests: fix test-qga on macosx

Pan Nengyuan (2):
      virtio-scsi: delete vqs in unrealize to avoid memleaks
      virtio-scsi: convert to new virtio_delete_queue

Paolo Bonzini (6):
      target/i386: kvm: initialize feature MSRs very early
      target/i386: add a ucode-rev property
      target/i386: kvm: initialize microcode revision from KVM
      qdev: rename DeviceClass.props
      qom: simplify qmp_device_list_properties()
      build-sys: clean up flags included in the linker command line

Philippe Mathieu-Daud=C3=A9 (21):
      qom/object: Display more helpful message when an interface is missing
      audio/audio: Add missing fall through comment
      hw/display/tcx: Add missing fall through comments
      hw/timer/aspeed_timer: Add a fall through comment
      hw/net/imx_fec: Rewrite fall through comments
      hw/net/imx_fec: Remove unuseful FALLTHROUGH comments
      hw/pci-host/designware: Remove unuseful FALLTHROUGH comment
      configure: Do not build libfdt if not required
      Makefile: Clarify all the codebase requires qom/ objects
      Makefile: Restrict system emulation and tools objects
      Makefile: Remove unhelpful comment
      hw/core: Restrict reset handlers API to system-mode
      hw/core/Makefile: Group generic objects versus system-mode objects
      hw/ppc/spapr_rtas: Use local MachineState variable
      hw/ppc/spapr_rtas: Access MachineState via SpaprMachineState argument
      hw/ppc/spapr_rtas: Remove local variable
      target/arm/kvm: Use CPUState::kvm_state in kvm_arm_pmu_supported()
      qom/object: Display more helpful message when a parent is missing
      accel: Introduce the current_accel() wrapper
      accel: Replace current_machine->accelerator by current_accel() wrappe=
r
      accel/tcg: Sanitize include path

Zhenwei Pi (2):
      pvpanic: introduce crashloaded for pvpanic
      pvpanic: implement crashloaded event handling

 .travis.yml                         |   2 +-
 Makefile                            |   4 +-
 Makefile.objs                       |  31 ++--
 accel/accel.c                       |   5 +
 accel/kvm/kvm-all.c                 |   4 +-
 accel/tcg/tcg-all.c                 |   8 +-
 audio/audio.c                       |   1 +
 configure                           |  63 ++++----
 docs/specs/pvpanic.txt              |  18 ++-
 hw/9pfs/virtio-9p-device.c          |   2 +-
 hw/acpi/generic_event_device.c      |   2 +-
 hw/acpi/piix4.c                     |   2 +-
 hw/acpi/vmgenid.c                   |   2 +-
 hw/arm/armsse.c                     |   2 +-
 hw/arm/armv7m.c                     |   4 +-
 hw/arm/aspeed_soc.c                 |   2 +-
 hw/arm/bcm2836.c                    |   2 +-
 hw/arm/integratorcp.c               |   2 +-
 hw/arm/msf2-soc.c                   |   2 +-
 hw/arm/musicpal.c                   |   2 +-
 hw/arm/nrf51_soc.c                  |   2 +-
 hw/arm/pxa2xx.c                     |   4 +-
 hw/arm/pxa2xx_gpio.c                |   2 +-
 hw/arm/smmu-common.c                |   2 +-
 hw/arm/spitz.c                      |   2 +-
 hw/arm/stm32f205_soc.c              |   2 +-
 hw/arm/stm32f405_soc.c              |   2 +-
 hw/arm/strongarm.c                  |   2 +-
 hw/arm/xlnx-versal.c                |   2 +-
 hw/arm/xlnx-zynqmp.c                |   2 +-
 hw/audio/ac97.c                     |   2 +-
 hw/audio/adlib.c                    |   2 +-
 hw/audio/cs4231.c                   |   2 +-
 hw/audio/cs4231a.c                  |   2 +-
 hw/audio/es1370.c                   |   2 +-
 hw/audio/gus.c                      |   2 +-
 hw/audio/hda-codec.c                |   2 +-
 hw/audio/intel-hda.c                |   4 +-
 hw/audio/milkymist-ac97.c           |   2 +-
 hw/audio/pcspk.c                    |   2 +-
 hw/audio/pl041.c                    |   2 +-
 hw/audio/sb16.c                     |   2 +-
 hw/audio/wm8750.c                   |   2 +-
 hw/block/fdc.c                      |   8 +-
 hw/block/m25p80.c                   |   2 +-
 hw/block/nand.c                     |   2 +-
 hw/block/nvme.c                     |   2 +-
 hw/block/onenand.c                  |   2 +-
 hw/block/pflash_cfi01.c             |   2 +-
 hw/block/pflash_cfi02.c             |   2 +-
 hw/block/swim.c                     |   2 +-
 hw/block/vhost-user-blk.c           |   2 +-
 hw/block/virtio-blk.c               |   2 +-
 hw/block/xen-block.c                |   2 +-
 hw/char/bcm2835_aux.c               |   2 +-
 hw/char/cadence_uart.c              |   2 +-
 hw/char/cmsdk-apb-uart.c            |   2 +-
 hw/char/debugcon.c                  |   2 +-
 hw/char/digic-uart.c                |   2 +-
 hw/char/escc.c                      |   2 +-
 hw/char/etraxfs_ser.c               |   2 +-
 hw/char/exynos4210_uart.c           |   2 +-
 hw/char/grlib_apbuart.c             |   2 +-
 hw/char/imx_serial.c                |   2 +-
 hw/char/ipoctal232.c                |   2 +-
 hw/char/lm32_juart.c                |   2 +-
 hw/char/lm32_uart.c                 |   2 +-
 hw/char/mcf_uart.c                  |   2 +-
 hw/char/milkymist-uart.c            |   2 +-
 hw/char/nrf51_uart.c                |   2 +-
 hw/char/parallel.c                  |   2 +-
 hw/char/pl011.c                     |   2 +-
 hw/char/sclpconsole-lm.c            |   2 +-
 hw/char/sclpconsole.c               |   2 +-
 hw/char/serial-isa.c                |   2 +-
 hw/char/serial-pci-multi.c          |   4 +-
 hw/char/serial-pci.c                |   2 +-
 hw/char/serial.c                    |   4 +-
 hw/char/spapr_vty.c                 |   2 +-
 hw/char/stm32f2xx_usart.c           |   2 +-
 hw/char/terminal3270.c              |   2 +-
 hw/char/virtio-console.c            |   2 +-
 hw/char/virtio-serial-bus.c         |   4 +-
 hw/char/xilinx_uartlite.c           |   2 +-
 hw/core/Makefile.objs               |  31 ++--
 hw/core/cpu.c                       |  10 +-
 hw/core/generic-loader.c            |   2 +-
 hw/core/or-irq.c                    |   2 +-
 hw/core/platform-bus.c              |   2 +-
 hw/core/qdev-properties.c           |  40 +++--
 hw/core/qdev.c                      | 159 ++++++++-----------
 hw/core/split-irq.c                 |   2 +-
 hw/cpu/a15mpcore.c                  |   2 +-
 hw/cpu/a9mpcore.c                   |   2 +-
 hw/cpu/arm11mpcore.c                |   2 +-
 hw/cpu/cluster.c                    |   2 +-
 hw/cpu/realview_mpcore.c            |   2 +-
 hw/display/ati.c                    |   2 +-
 hw/display/bcm2835_fb.c             |   2 +-
 hw/display/bochs-display.c          |   2 +-
 hw/display/cg3.c                    |   2 +-
 hw/display/cirrus_vga.c             |   2 +-
 hw/display/cirrus_vga_isa.c         |   2 +-
 hw/display/g364fb.c                 |   2 +-
 hw/display/i2c-ddc.c                |   2 +-
 hw/display/macfb.c                  |   4 +-
 hw/display/milkymist-vgafb.c        |   2 +-
 hw/display/qxl.c                    |   2 +-
 hw/display/ramfb-standalone.c       |   2 +-
 hw/display/sm501.c                  |   4 +-
 hw/display/tcx.c                    |   4 +-
 hw/display/vga-isa.c                |   2 +-
 hw/display/vga-pci.c                |   4 +-
 hw/display/vhost-user-gpu.c         |   2 +-
 hw/display/virtio-gpu-pci.c         |   2 +-
 hw/display/virtio-gpu.c             |   2 +-
 hw/display/virtio-vga.c             |   2 +-
 hw/display/vmware_vga.c             |   2 +-
 hw/dma/i82374.c                     |   2 +-
 hw/dma/i8257.c                      |   2 +-
 hw/dma/pl080.c                      |   2 +-
 hw/dma/pl330.c                      |   2 +-
 hw/dma/pxa2xx_dma.c                 |   2 +-
 hw/dma/xilinx_axidma.c              |   2 +-
 hw/dma/xlnx-zdma.c                  |   2 +-
 hw/gpio/imx_gpio.c                  |   2 +-
 hw/gpio/omap_gpio.c                 |   4 +-
 hw/i2c/aspeed_i2c.c                 |   2 +-
 hw/i2c/core.c                       |   2 +-
 hw/i2c/omap_i2c.c                   |   2 +-
 hw/i386/intel_iommu.c               |   2 +-
 hw/i386/kvm/clock.c                 |   2 +-
 hw/i386/kvm/i8254.c                 |   2 +-
 hw/i386/kvm/ioapic.c                |   2 +-
 hw/i386/vmmouse.c                   |   2 +-
 hw/i386/x86-iommu.c                 |   2 +-
 hw/i386/xen/xen_pvdevice.c          |   2 +-
 hw/ide/ahci.c                       |   2 +-
 hw/ide/cmd646.c                     |   2 +-
 hw/ide/isa.c                        |   2 +-
 hw/ide/macio.c                      |   2 +-
 hw/ide/mmio.c                       |   2 +-
 hw/ide/qdev.c                       |   8 +-
 hw/input/adb.c                      |   2 +-
 hw/input/milkymist-softusb.c        |   2 +-
 hw/input/virtio-input-hid.c         |   6 +-
 hw/input/virtio-input-host.c        |   2 +-
 hw/input/virtio-input.c             |   2 +-
 hw/intc/apic_common.c               |   2 +-
 hw/intc/arm_gic_common.c            |   2 +-
 hw/intc/arm_gicv2m.c                |   2 +-
 hw/intc/arm_gicv3_common.c          |   2 +-
 hw/intc/arm_gicv3_its_kvm.c         |   2 +-
 hw/intc/armv7m_nvic.c               |   2 +-
 hw/intc/exynos4210_combiner.c       |   2 +-
 hw/intc/exynos4210_gic.c            |   4 +-
 hw/intc/i8259_common.c              |   2 +-
 hw/intc/ioapic.c                    |   2 +-
 hw/intc/mips_gic.c                  |   2 +-
 hw/intc/omap_intc.c                 |   4 +-
 hw/intc/ompic.c                     |   2 +-
 hw/intc/openpic.c                   |   2 +-
 hw/intc/openpic_kvm.c               |   2 +-
 hw/intc/pnv_xive.c                  |   2 +-
 hw/intc/s390_flic.c                 |   2 +-
 hw/intc/spapr_xive.c                |   2 +-
 hw/intc/xics.c                      |   4 +-
 hw/intc/xilinx_intc.c               |   2 +-
 hw/intc/xive.c                      |   8 +-
 hw/intc/xlnx-pmu-iomod-intc.c       |   2 +-
 hw/ipack/ipack.c                    |   2 +-
 hw/ipmi/ipmi.c                      |   2 +-
 hw/ipmi/ipmi_bmc_extern.c           |   2 +-
 hw/ipmi/ipmi_bmc_sim.c              |   2 +-
 hw/ipmi/isa_ipmi_bt.c               |   2 +-
 hw/ipmi/isa_ipmi_kcs.c              |   2 +-
 hw/isa/lpc_ich9.c                   |   2 +-
 hw/isa/pc87312.c                    |   2 +-
 hw/isa/vt82c686.c                   |   2 +-
 hw/mem/nvdimm.c                     |   2 +-
 hw/mem/pc-dimm.c                    |   2 +-
 hw/mips/cps.c                       |   2 +-
 hw/misc/a9scu.c                     |   2 +-
 hw/misc/applesmc.c                  |   2 +-
 hw/misc/arm11scu.c                  |   2 +-
 hw/misc/arm_l2x0.c                  |   2 +-
 hw/misc/arm_sysctl.c                |   2 +-
 hw/misc/armsse-cpuid.c              |   2 +-
 hw/misc/aspeed_scu.c                |   2 +-
 hw/misc/aspeed_sdmc.c               |   2 +-
 hw/misc/bcm2835_property.c          |   2 +-
 hw/misc/debugexit.c                 |   2 +-
 hw/misc/eccmemctl.c                 |   2 +-
 hw/misc/iotkit-sysctl.c             |   2 +-
 hw/misc/iotkit-sysinfo.c            |   2 +-
 hw/misc/ivshmem.c                   |   4 +-
 hw/misc/mac_via.c                   |   2 +-
 hw/misc/macio/cuda.c                |   2 +-
 hw/misc/macio/macio.c               |   4 +-
 hw/misc/macio/pmu.c                 |   2 +-
 hw/misc/mips_cmgcr.c                |   2 +-
 hw/misc/mips_cpc.c                  |   2 +-
 hw/misc/mips_itu.c                  |   2 +-
 hw/misc/mos6522.c                   |   2 +-
 hw/misc/mps2-fpgaio.c               |   2 +-
 hw/misc/mps2-scc.c                  |   2 +-
 hw/misc/msf2-sysreg.c               |   2 +-
 hw/misc/nrf51_rng.c                 |   2 +-
 hw/misc/pci-testdev.c               |   2 +-
 hw/misc/pvpanic.c                   |  13 +-
 hw/misc/tz-mpc.c                    |   2 +-
 hw/misc/tz-msc.c                    |   2 +-
 hw/misc/tz-ppc.c                    |   2 +-
 hw/misc/unimp.c                     |   2 +-
 hw/net/allwinner_emac.c             |   2 +-
 hw/net/cadence_gem.c                |   2 +-
 hw/net/dp8393x.c                    |   2 +-
 hw/net/e1000.c                      |   2 +-
 hw/net/e1000e.c                     |   2 +-
 hw/net/eepro100.c                   |   2 +-
 hw/net/etraxfs_eth.c                |   2 +-
 hw/net/fsl_etsec/etsec.c            |   2 +-
 hw/net/ftgmac100.c                  |   4 +-
 hw/net/imx_fec.c                    |   9 +-
 hw/net/lan9118.c                    |   2 +-
 hw/net/lance.c                      |   2 +-
 hw/net/mcf_fec.c                    |   2 +-
 hw/net/milkymist-minimac2.c         |   2 +-
 hw/net/mipsnet.c                    |   2 +-
 hw/net/ne2000-isa.c                 |   2 +-
 hw/net/ne2000-pci.c                 |   2 +-
 hw/net/opencores_eth.c              |   2 +-
 hw/net/pcnet-pci.c                  |   2 +-
 hw/net/rocker/rocker.c              |   2 +-
 hw/net/rtl8139.c                    |   2 +-
 hw/net/smc91c111.c                  |   2 +-
 hw/net/spapr_llan.c                 |   2 +-
 hw/net/stellaris_enet.c             |   2 +-
 hw/net/sungem.c                     |   2 +-
 hw/net/sunhme.c                     |   2 +-
 hw/net/tulip.c                      |   2 +-
 hw/net/virtio-net.c                 |   2 +-
 hw/net/vmxnet3.c                    |   2 +-
 hw/net/xgmac.c                      |   2 +-
 hw/net/xilinx_axienet.c             |   2 +-
 hw/net/xilinx_ethlite.c             |   2 +-
 hw/nvram/ds1225y.c                  |   2 +-
 hw/nvram/eeprom_at24c.c             |   2 +-
 hw/nvram/fw_cfg.c                   |   4 +-
 hw/nvram/mac_nvram.c                |   2 +-
 hw/nvram/nrf51_nvm.c                |   2 +-
 hw/nvram/spapr_nvram.c              |   2 +-
 hw/pci-bridge/gen_pcie_root_port.c  |   2 +-
 hw/pci-bridge/pci_bridge_dev.c      |   2 +-
 hw/pci-bridge/pci_expander_bridge.c |   4 +-
 hw/pci-bridge/pcie_pci_bridge.c     |   2 +-
 hw/pci-bridge/pcie_root_port.c      |   2 +-
 hw/pci-bridge/xio3130_downstream.c  |   2 +-
 hw/pci-host/designware.c            |   2 +-
 hw/pci-host/grackle.c               |   2 +-
 hw/pci-host/i440fx.c                |   2 +-
 hw/pci-host/ppce500.c               |   2 +-
 hw/pci-host/prep.c                  |   2 +-
 hw/pci-host/q35.c                   |   4 +-
 hw/pci-host/sabre.c                 |   2 +-
 hw/pci-host/uninorth.c              |   2 +-
 hw/pci-host/versatile.c             |   2 +-
 hw/pci-host/xilinx-pcie.c           |   2 +-
 hw/pci/pci.c                        |   2 +-
 hw/pci/pcie_port.c                  |   4 +-
 hw/ppc/pnv.c                        |   2 +-
 hw/ppc/pnv_core.c                   |   4 +-
 hw/ppc/pnv_homer.c                  |   2 +-
 hw/ppc/pnv_lpc.c                    |   2 +-
 hw/ppc/pnv_occ.c                    |   2 +-
 hw/ppc/pnv_pnor.c                   |   2 +-
 hw/ppc/pnv_psi.c                    |   2 +-
 hw/ppc/ppc440_uc.c                  |   2 +-
 hw/ppc/prep_systemio.c              |   2 +-
 hw/ppc/rs6000_mc.c                  |   2 +-
 hw/ppc/spapr_cpu_core.c             |   2 +-
 hw/ppc/spapr_pci.c                  |   2 +-
 hw/ppc/spapr_rng.c                  |   2 +-
 hw/ppc/spapr_rtas.c                 |   9 +-
 hw/ppc/spapr_tpm_proxy.c            |   2 +-
 hw/rdma/vmw/pvrdma_main.c           |   2 +-
 hw/riscv/riscv_hart.c               |   2 +-
 hw/riscv/sifive_clint.c             |   2 +-
 hw/riscv/sifive_plic.c              |   2 +-
 hw/riscv/sifive_u_otp.c             |   2 +-
 hw/rtc/m48t59-isa.c                 |   2 +-
 hw/rtc/m48t59.c                     |   2 +-
 hw/rtc/mc146818rtc.c                |   2 +-
 hw/rtc/pl031.c                      |   2 +-
 hw/s390x/3270-ccw.c                 |   2 +-
 hw/s390x/ccw-device.c               |   2 +-
 hw/s390x/css-bridge.c               |   2 +-
 hw/s390x/ipl.c                      |   2 +-
 hw/s390x/s390-pci-bus.c             |   2 +-
 hw/s390x/vhost-vsock-ccw.c          |   2 +-
 hw/s390x/virtio-ccw-9p.c            |   2 +-
 hw/s390x/virtio-ccw-balloon.c       |   2 +-
 hw/s390x/virtio-ccw-blk.c           |   2 +-
 hw/s390x/virtio-ccw-crypto.c        |   2 +-
 hw/s390x/virtio-ccw-gpu.c           |   2 +-
 hw/s390x/virtio-ccw-input.c         |   2 +-
 hw/s390x/virtio-ccw-net.c           |   2 +-
 hw/s390x/virtio-ccw-rng.c           |   2 +-
 hw/s390x/virtio-ccw-scsi.c          |   4 +-
 hw/s390x/virtio-ccw-serial.c        |   2 +-
 hw/scsi/megasas.c                   |   2 +-
 hw/scsi/mptsas.c                    |   2 +-
 hw/scsi/scsi-bus.c                  |   2 +-
 hw/scsi/scsi-disk.c                 |   8 +-
 hw/scsi/scsi-generic.c              |   2 +-
 hw/scsi/spapr_vscsi.c               |   2 +-
 hw/scsi/vhost-scsi.c                |   2 +-
 hw/scsi/vhost-user-scsi.c           |   2 +-
 hw/scsi/virtio-scsi.c               |   8 +-
 hw/scsi/vmw_pvscsi.c                |   2 +-
 hw/sd/sd.c                          |   2 +-
 hw/sd/sdhci-pci.c                   |   2 +-
 hw/sd/sdhci.c                       |   2 +-
 hw/sparc/sun4m.c                    |   4 +-
 hw/sparc/sun4m_iommu.c              |   2 +-
 hw/sparc64/sun4u.c                  |   6 +-
 hw/ssi/aspeed_smc.c                 |   2 +-
 hw/ssi/xilinx_spi.c                 |   2 +-
 hw/ssi/xilinx_spips.c               |   4 +-
 hw/timer/a9gtimer.c                 |   2 +-
 hw/timer/allwinner-a10-pit.c        |   2 +-
 hw/timer/altera_timer.c             |   2 +-
 hw/timer/arm_mptimer.c              |   2 +-
 hw/timer/arm_timer.c                |   2 +-
 hw/timer/aspeed_timer.c             |   4 +-
 hw/timer/cmsdk-apb-dualtimer.c      |   2 +-
 hw/timer/cmsdk-apb-timer.c          |   2 +-
 hw/timer/grlib_gptimer.c            |   2 +-
 hw/timer/hpet.c                     |   2 +-
 hw/timer/i8254.c                    |   2 +-
 hw/timer/lm32_timer.c               |   2 +-
 hw/timer/milkymist-sysctl.c         |   2 +-
 hw/timer/mss-timer.c                |   2 +-
 hw/timer/pxa2xx_timer.c             |   4 +-
 hw/timer/slavio_timer.c             |   2 +-
 hw/timer/stm32f2xx_timer.c          |   2 +-
 hw/timer/xilinx_timer.c             |   2 +-
 hw/tpm/tpm_crb.c                    |   2 +-
 hw/tpm/tpm_tis.c                    |   2 +-
 hw/usb/bus.c                        |   2 +-
 hw/usb/ccid-card-emulated.c         |   2 +-
 hw/usb/ccid-card-passthru.c         |   2 +-
 hw/usb/dev-audio.c                  |   2 +-
 hw/usb/dev-hid.c                    |   6 +-
 hw/usb/dev-hub.c                    |   2 +-
 hw/usb/dev-mtp.c                    |   2 +-
 hw/usb/dev-network.c                |   2 +-
 hw/usb/dev-serial.c                 |   4 +-
 hw/usb/dev-smartcard-reader.c       |   4 +-
 hw/usb/dev-storage.c                |   2 +-
 hw/usb/dev-uas.c                    |   2 +-
 hw/usb/hcd-ehci-pci.c               |   2 +-
 hw/usb/hcd-ehci-sysbus.c            |   2 +-
 hw/usb/hcd-ohci-pci.c               |   2 +-
 hw/usb/hcd-ohci.c                   |   2 +-
 hw/usb/hcd-uhci.c                   |   4 +-
 hw/usb/hcd-xhci-nec.c               |   2 +-
 hw/usb/hcd-xhci.c                   |   2 +-
 hw/usb/host-libusb.c                |   2 +-
 hw/usb/redirect.c                   |   2 +-
 hw/vfio/ap.c                        |   2 +-
 hw/vfio/ccw.c                       |   2 +-
 hw/vfio/pci.c                       |   4 +-
 hw/vfio/platform.c                  |   2 +-
 hw/virtio/vhost-scsi-pci.c          |   2 +-
 hw/virtio/vhost-user-blk-pci.c      |   2 +-
 hw/virtio/vhost-user-fs-pci.c       |   2 +-
 hw/virtio/vhost-user-fs.c           |   2 +-
 hw/virtio/vhost-user-scsi-pci.c     |   2 +-
 hw/virtio/vhost-vsock-pci.c         |   2 +-
 hw/virtio/vhost-vsock.c             |   2 +-
 hw/virtio/virtio-9p-pci.c           |   2 +-
 hw/virtio/virtio-balloon-pci.c      |   2 +-
 hw/virtio/virtio-balloon.c          |   2 +-
 hw/virtio/virtio-blk-pci.c          |   2 +-
 hw/virtio/virtio-crypto-pci.c       |   2 +-
 hw/virtio/virtio-crypto.c           |   2 +-
 hw/virtio/virtio-input-pci.c        |   2 +-
 hw/virtio/virtio-mmio.c             |   2 +-
 hw/virtio/virtio-net-pci.c          |   2 +-
 hw/virtio/virtio-pci.c              |   4 +-
 hw/virtio/virtio-pmem.c             |   2 +-
 hw/virtio/virtio-rng.c              |   2 +-
 hw/virtio/virtio-scsi-pci.c         |   2 +-
 hw/virtio/virtio-serial-pci.c       |   2 +-
 hw/virtio/virtio.c                  |   2 +-
 hw/watchdog/cmsdk-apb-watchdog.c    |   2 +-
 hw/watchdog/wdt_aspeed.c            |   2 +-
 hw/xen/xen-bus.c                    |   2 +-
 hw/xen/xen-legacy-backend.c         |   4 +-
 hw/xen/xen_pt.c                     |   2 +-
 include/hw/core/cpu.h               |   4 +
 include/hw/qdev-core.h              |  15 +-
 include/hw/qdev-properties.h        |   3 +-
 include/qapi/qmp/qstring.h          |   1 +
 include/qom/object.h                | 109 +++++++++++--
 include/sysemu/accel.h              |   2 +
 include/sysemu/runstate.h           |   1 +
 memory.c                            |   2 +-
 migration/migration.c               |   2 +-
 monitor/misc.c                      |  26 ++++
 qapi/qom.json                       |   7 +-
 qapi/run-state.json                 |  24 ++-
 qdev-monitor.c                      |  30 ++--
 qga/vss-win32/Makefile.objs         |   4 +-
 qobject/qstring.c                   |  27 +++-
 qom/object.c                        | 299 +++++++++++++++++++++++++++-----=
----
 qom/object_interfaces.c             |  39 +++--
 qom/qom-qmp-cmds.c                  |  54 +------
 rules.mak                           |   4 +-
 target/arm/cpu.c                    |  41 ++---
 target/arm/kvm.c                    |   4 +-
 target/arm/kvm64.c                  |   5 +-
 target/cris/cpu.c                   |   3 +-
 target/i386/cpu.c                   |  25 ++-
 target/i386/cpu.h                   |   3 +
 target/i386/hvf/x86_emu.c           |   4 +-
 target/i386/kvm.c                   |  88 +++++++----
 target/i386/kvm_i386.h              |   1 +
 target/i386/misc_helper.c           |   4 +
 target/lm32/cpu.c                   |   3 +-
 target/m68k/cpu.c                   |   3 +-
 target/microblaze/cpu.c             |   5 +-
 target/mips/cpu.c                   |   3 +-
 target/moxie/cpu.c                  |   3 +-
 target/nios2/cpu.c                  |   5 +-
 target/openrisc/cpu.c               |   3 +-
 target/ppc/kvm.c                    |   4 +-
 target/ppc/translate_init.inc.c     |  13 +-
 target/riscv/cpu.c                  |   5 +-
 target/s390x/cpu.c                  |   5 +-
 target/sh4/cpu.c                    |   3 +-
 target/sparc/cpu.c                  |   5 +-
 target/tilegx/cpu.c                 |   3 +-
 target/tricore/cpu.c                |   3 +-
 target/xtensa/cpu.c                 |   3 +-
 tests/Makefile.include              |   2 +-
 tests/test-qdev-global-props.c      |   2 +-
 tests/test-qga.c                    |  25 ++-
 vl.c                                |  14 +-
 450 files changed, 1280 insertions(+), 948 deletions(-)
--=20
1.8.3.1


