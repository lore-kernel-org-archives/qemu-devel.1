Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842E0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 20:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 372F32078E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 20:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JA7ixFAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372F32078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkvx2-0006UO-9x
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 16:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkvtz-0002KE-Ay
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:40:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60102
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkvtw-0000R4-GU
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592253615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/UYlh6My4xhcANS5Yd+puFzFtWP19FHkcsi2arBkcP8=;
 b=JA7ixFAn8P44cixx8133Xy9joKAS0Uf8/oK9xNgnWoLyZ4ut7TXedj+WOBjFzpsQN82kQU
 x+fNGKT1Ld4E15a5SNYwObUX82jnQmTY0vK2m/GBjJeLekVttWNhmwAUfI9/bjeymtOOzi
 hp3V0CzHYu2jPuCazdBaqu5q+tltTrg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-pK87p9_1NdO53XDOtkdaOw-1; Mon, 15 Jun 2020 16:40:13 -0400
X-MC-Unique: pK87p9_1NdO53XDOtkdaOw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17C5E873409
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 20:40:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EA1C5D9D5
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 20:40:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1A1DA1138648; Mon, 15 Jun 2020 22:40:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/84] QOM patches for 2020-06-15
Date: Mon, 15 Jun 2020 22:38:44 +0200
Message-Id: <20200615204008.3069956-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 15:33:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

The following changes since commit 7d3660e79830a069f1848bb4fa1cdf8f666424fb:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2020-06-12 23:06:22 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qom-2020-06-15

for you to fetch changes up to b77b5b3dc7a4730d804090d359c57d33573cf85a:

  MAINTAINERS: Make section QOM cover hw/core/*bus.c as well (2020-06-15 22:06:04 +0200)

----------------------------------------------------------------
QOM patches for 2020-06-15

* Make "info qom-tree" show children sorted
* Fixes around device realization
* Rework how we plug into devices into their parent bus

----------------------------------------------------------------
Cédric Le Goater (2):
      arm/aspeed: Compute the number of CPUs from the SoC definition
      arm/aspeed: Rework NIC attachment

Markus Armbruster (82):
      qom: Constify object_get_canonical_path{,_component}()'s parameter
      qom: Make "info qom-tree" show children sorted
      arm/stm32f405: Fix realization of "stm32f2xx-adc" devices
      display/xlnx_dp: Fix to realize "i2c-ddc" and "aux-to-i2c-bridge"
      sd/pxa2xx_mmci: Fix to realize "pxa2xx-mmci" device
      armv7m: Delete unused "ARM,bitband-memory" devices
      auxbus: Fix aux-to-i2c-bridge to be a subtype of aux-slave
      mac_via: Fix to realize "mos6522-q800-via*" devices
      macio: Fix to realize "mos6522-cuda" and "mos6522-pmu" devices
      macio: Delete unused "macio-gpio" devices
      pnv/phb4: Delete unused "pnv-phb4-pec-stack" devices
      MAINTAINERS: Make section PowerNV cover pci-host/pnv* as well
      ppc4xx: Drop redundant device realization
      macio: Put "macio-nvram" device on the macio bus
      macio: Fix macio-bus to be a subtype of System bus
      ppc/pnv: Put "*-pnv-chip" and "pnv-xive" on the main system bus
      pnv/psi: Correct the pnv-psi* devices not to be sysbus devices
      display/sm501 display/ati: Fix to realize "i2c-ddc"
      riscv: Fix to put "riscv.hart_array" devices on sysbus
      riscv: Fix type of SiFive[EU]SocState, member parent_obj
      sparc/leon3: Fix to put grlib,* devices on sysbus
      qdev: Assert devices are plugged into a bus that can take them
      sd: Hide the qdev-but-not-quite thing created by sd_init()
      qdev: Assert onboard devices all get realized properly
      qdev: Rename qbus_realize() to qbus_init()
      Revert "hw/prep: realize the PCI root bus as part of the prep init"
      Revert "hw/versatile: realize the PCI root bus as part of the versatile init"
      qdev: New qdev_new(), qdev_realize(), etc.
      qdev: Put qdev_new() to use with Coccinelle
      qdev: Convert to qbus_realize(), qbus_unrealize()
      qdev: Convert to qdev_unrealize() with Coccinelle
      qdev: Convert to qdev_unrealize() manually
      qdev: Convert uses of qdev_create() with Coccinelle
      qdev: Convert uses of qdev_create() manually
      qdev: Convert uses of qdev_set_parent_bus() with Coccinelle
      qdev: Convert uses of qdev_set_parent_bus() manually
      pci: New pci_new(), pci_realize_and_unref() etc.
      hw/ppc: Eliminate two superfluous QOM casts
      pci: Convert uses of pci_create() etc. with Coccinelle
      pci: Convert uses of pci_create() etc. manually
      pci: pci_create(), pci_create_multifunction() are now unused, drop
      isa: New isa_new(), isa_realize_and_unref() etc.
      isa: Convert uses of isa_create() with Coccinelle
      isa: Convert uses of isa_create(), isa_try_create() manually
      isa: isa_create(), isa_try_create() are now unused, drop
      ssi: ssi_auto_connect_slaves() never does anything, drop
      ssi: Convert uses of ssi_create_slave_no_init() with Coccinelle
      ssi: Convert last use of ssi_create_slave_no_init() manually
      ssi: ssi_create_slave_no_init() is now unused, drop
      usb: New usb_new(), usb_realize_and_unref()
      usb: Convert uses of usb_create()
      usb: usb_create() is now unused, drop
      usb: Eliminate usb_try_create_simple()
      qdev: qdev_create(), qdev_try_create() are now unused, drop
      auxbus: Rename aux_init_bus() to aux_bus_init()
      auxbus: New aux_bus_realize(), pairing with aux_bus_init()
      auxbus: Convert a use of qdev_set_parent_bus()
      auxbus: Eliminate aux_create_slave()
      qom: Tidy up a few object_initialize_child() calls
      qom: Less verbose object_initialize_child()
      macio: Convert use of qdev_set_parent_bus()
      macio: Eliminate macio_init_child_obj()
      sysbus: Drop useless OBJECT() in sysbus_init_child_obj() calls
      microbit: Tidy up sysbus_init_child_obj() @child argument
      sysbus: Tidy up sysbus_init_child_obj()'s @childsize arg, part 1
      hw/arm/armsse: Pass correct child size to sysbus_init_child_obj()
      sysbus: Tidy up sysbus_init_child_obj()'s @childsize arg, part 2
      sysbus: New sysbus_realize(), sysbus_realize_and_unref()
      sysbus: Convert to sysbus_realize() etc. with Coccinelle
      qdev: Drop qdev_realize() support for null bus
      sysbus: Convert qdev_set_parent_bus() use with Coccinelle, part 1
      sysbus: Convert qdev_set_parent_bus() use with Coccinelle, part 2
      sysbus: Convert qdev_set_parent_bus() use with Coccinelle, part 3
      sysbus: Convert qdev_set_parent_bus() use with Coccinelle, part 4
      sysbus: sysbus_init_child_obj() is now unused, drop
      microbit: Eliminate two local variables in microbit_init()
      s390x/event-facility: Simplify creation of SCLP event devices
      qdev: Make qdev_realize() support bus-less devices
      qdev: Use qdev_realize() in qdev_device_add()
      qdev: Convert bus-less devices to qdev_realize() with Coccinelle
      qdev: qdev_init_nofail() is now unused, drop
      MAINTAINERS: Make section QOM cover hw/core/*bus.c as well

 hw/lm32/lm32.h                           |  13 +--
 hw/lm32/milkymist-hw.h                   |  37 +++----
 include/hw/arm/aspeed.h                  |   6 ++
 include/hw/arm/aspeed_soc.h              |   1 -
 include/hw/audio/pcspk.h                 |   5 +-
 include/hw/char/cadence_uart.h           |   5 +-
 include/hw/char/cmsdk-apb-uart.h         |   4 +-
 include/hw/char/pl011.h                  |   9 +-
 include/hw/char/xilinx_uartlite.h        |   4 +-
 include/hw/cris/etraxfs.h                |   4 +-
 include/hw/isa/isa.h                     |   5 +-
 include/hw/misc/auxbus.h                 |  18 ++--
 include/hw/misc/unimp.h                  |   5 +-
 include/hw/net/ne2000-isa.h              |   5 +-
 include/hw/pci/pci.h                     |   6 +-
 include/hw/ppc/pnv_psi.h                 |   2 +-
 include/hw/qdev-core.h                   |  13 ++-
 include/hw/riscv/sifive_e.h              |   2 +-
 include/hw/riscv/sifive_u.h              |   2 +-
 include/hw/ssi/ssi.h                     |   5 -
 include/hw/sysbus.h                      |  19 +---
 include/hw/timer/cmsdk-apb-timer.h       |   4 +-
 include/hw/timer/i8254.h                 |   9 +-
 include/hw/usb.h                         |   6 +-
 include/qom/object.h                     |  34 ++++--
 hw/acpi/pcihp.c                          |   2 +-
 hw/acpi/piix4.c                          |   6 +-
 hw/alpha/typhoon.c                       |   4 +-
 hw/arm/allwinner-a10.c                   |  50 ++++-----
 hw/arm/allwinner-h3.c                    |  57 ++++------
 hw/arm/armsse.c                          | 174 +++++++++++++------------------
 hw/arm/armv7m.c                          |  18 ++--
 hw/arm/aspeed.c                          |  60 ++++++++---
 hw/arm/aspeed_ast2600.c                  | 133 ++++++++++-------------
 hw/arm/aspeed_soc.c                      |  96 +++++++----------
 hw/arm/bcm2835_peripherals.c             |  81 ++++++--------
 hw/arm/bcm2836.c                         |  17 ++-
 hw/arm/cubieboard.c                      |   6 +-
 hw/arm/digic.c                           |  16 ++-
 hw/arm/digic_boards.c                    |   2 +-
 hw/arm/exynos4210.c                      |  48 ++++-----
 hw/arm/exynos4_boards.c                  |  11 +-
 hw/arm/fsl-imx25.c                       |  64 +++++-------
 hw/arm/fsl-imx31.c                       |  43 ++++----
 hw/arm/fsl-imx6.c                        |  76 ++++++--------
 hw/arm/fsl-imx6ul.c                      | 105 +++++++------------
 hw/arm/fsl-imx7.c                        | 100 +++++++-----------
 hw/arm/highbank.c                        |  28 ++---
 hw/arm/imx25_pdk.c                       |  10 +-
 hw/arm/integratorcp.c                    |   6 +-
 hw/arm/kzm.c                             |   5 +-
 hw/arm/mcimx6ul-evk.c                    |   7 +-
 hw/arm/mcimx7d-sabre.c                   |   7 +-
 hw/arm/microbit.c                        |  22 ++--
 hw/arm/mps2-tz.c                         |  79 ++++++--------
 hw/arm/mps2.c                            |  26 ++---
 hw/arm/msf2-soc.c                        |  25 ++---
 hw/arm/msf2-som.c                        |  12 +--
 hw/arm/musca.c                           |  60 +++++------
 hw/arm/musicpal.c                        |   8 +-
 hw/arm/netduino2.c                       |   4 +-
 hw/arm/netduinoplus2.c                   |   4 +-
 hw/arm/nrf51_soc.c                       |  30 +++---
 hw/arm/nseries.c                         |   8 +-
 hw/arm/omap1.c                           |  16 +--
 hw/arm/omap2.c                           |  16 +--
 hw/arm/orangepi.c                        |   6 +-
 hw/arm/pxa2xx.c                          |   8 +-
 hw/arm/pxa2xx_gpio.c                     |   5 +-
 hw/arm/pxa2xx_pic.c                      |   5 +-
 hw/arm/raspi.c                           |  10 +-
 hw/arm/realview.c                        |  22 ++--
 hw/arm/sabrelite.c                       |   6 +-
 hw/arm/sbsa-ref.c                        |  26 ++---
 hw/arm/spitz.c                           |   4 +-
 hw/arm/stellaris.c                       |  12 +--
 hw/arm/stm32f205_soc.c                   |  34 +++---
 hw/arm/stm32f405_soc.c                   |  66 ++++++------
 hw/arm/strongarm.c                       |   9 +-
 hw/arm/versatilepb.c                     |  18 ++--
 hw/arm/vexpress.c                        |  18 ++--
 hw/arm/virt.c                            |  38 +++----
 hw/arm/xilinx_zynq.c                     |  44 ++++----
 hw/arm/xlnx-versal-virt.c                |  15 +--
 hw/arm/xlnx-versal.c                     |  53 ++++------
 hw/arm/xlnx-zcu102.c                     |  26 +++--
 hw/arm/xlnx-zynqmp.c                     |  92 +++++++---------
 hw/audio/intel-hda.c                     |   4 +-
 hw/block/fdc.c                           |  16 +--
 hw/block/nand.c                          |   4 +-
 hw/block/pflash_cfi01.c                  |   4 +-
 hw/block/pflash_cfi02.c                  |   4 +-
 hw/block/xen-block.c                     |   4 +-
 hw/char/exynos4210_uart.c                |   5 +-
 hw/char/mcf_uart.c                       |   5 +-
 hw/char/parallel-isa.c                   |   5 +-
 hw/char/serial-isa.c                     |   9 +-
 hw/char/serial-pci-multi.c               |   8 +-
 hw/char/serial-pci.c                     |   7 +-
 hw/char/serial.c                         |  14 ++-
 hw/char/spapr_vty.c                      |   4 +-
 hw/core/bus.c                            |  23 +++-
 hw/core/cpu.c                            |   2 +-
 hw/core/qdev.c                           | 147 ++++++++++++++------------
 hw/core/sysbus.c                         |  27 ++---
 hw/cpu/a15mpcore.c                       |   5 +-
 hw/cpu/a9mpcore.c                        |  23 ++--
 hw/cpu/arm11mpcore.c                     |  18 ++--
 hw/cpu/realview_mpcore.c                 |  10 +-
 hw/cris/axis_dev88.c                     |   4 +-
 hw/display/ati.c                         |   3 +-
 hw/display/milkymist-tmu2.c              |   4 +-
 hw/display/sm501.c                       |  11 +-
 hw/display/virtio-gpu-pci.c              |   3 +-
 hw/display/virtio-vga.c                  |   3 +-
 hw/display/xlnx_dp.c                     |  13 ++-
 hw/dma/i8257.c                           |   9 +-
 hw/dma/pxa2xx_dma.c                      |   8 +-
 hw/dma/rc4030.c                          |   5 +-
 hw/dma/sparc32_dma.c                     |  16 +--
 hw/dma/xilinx_axidma.c                   |   9 +-
 hw/hppa/dino.c                           |   4 +-
 hw/hppa/lasi.c                           |   4 +-
 hw/hppa/machine.c                        |   4 +-
 hw/hyperv/hyperv.c                       |   2 +-
 hw/i2c/core.c                            |   5 +-
 hw/i2c/smbus_eeprom.c                    |   4 +-
 hw/i386/amd_iommu.c                      |   3 +-
 hw/i386/pc.c                             |  12 +--
 hw/i386/pc_q35.c                         |  14 +--
 hw/i386/pc_sysfw.c                       |   4 +-
 hw/i386/x86.c                            |   8 +-
 hw/ide/isa.c                             |   5 +-
 hw/ide/microdrive.c                      |   3 +-
 hw/ide/qdev.c                            |   4 +-
 hw/intc/armv7m_nvic.c                    |  15 ++-
 hw/intc/exynos4210_gic.c                 |   5 +-
 hw/intc/i8259_common.c                   |   5 +-
 hw/intc/pnv_xive.c                       |  10 +-
 hw/intc/realview_gic.c                   |   4 +-
 hw/intc/s390_flic.c                      |   6 +-
 hw/intc/spapr_xive.c                     |  10 +-
 hw/intc/xics.c                           |   2 +-
 hw/intc/xive.c                           |   2 +-
 hw/isa/isa-bus.c                         |  27 +++--
 hw/isa/isa-superio.c                     |  20 ++--
 hw/isa/piix4.c                           |   3 +-
 hw/isa/vt82c686.c                        |  13 +--
 hw/m68k/mcf5208.c                        |   4 +-
 hw/m68k/mcf_intc.c                       |   5 +-
 hw/m68k/next-cube.c                      |  12 +--
 hw/m68k/q800.c                           |  36 +++----
 hw/microblaze/petalogix_ml605_mmu.c      |  26 ++---
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  14 +--
 hw/microblaze/xlnx-zynqmp-pmu.c          |  21 ++--
 hw/mips/boston.c                         |  14 ++-
 hw/mips/cps.c                            |  20 ++--
 hw/mips/fuloong2e.c                      |   6 +-
 hw/mips/gt64xxx_pci.c                    |   5 +-
 hw/mips/jazz.c                           |  16 +--
 hw/mips/malta.c                          |  10 +-
 hw/mips/mipssim.c                        |   8 +-
 hw/misc/auxbus.c                         |  22 ++--
 hw/misc/empty_slot.c                     |   5 +-
 hw/misc/mac_via.c                        |  11 +-
 hw/misc/macio/cuda.c                     |  19 ++--
 hw/misc/macio/macio.c                    |  59 ++++-------
 hw/misc/macio/pmu.c                      |  19 ++--
 hw/net/etraxfs_eth.c                     |   4 +-
 hw/net/fsl_etsec/etsec.c                 |   5 +-
 hw/net/lan9118.c                         |   5 +-
 hw/net/lasi_i82596.c                     |   5 +-
 hw/net/smc91c111.c                       |   5 +-
 hw/net/spapr_llan.c                      |   4 +-
 hw/net/xilinx_axienet.c                  |   9 +-
 hw/nios2/10m50_devboard.c                |  12 +--
 hw/nvram/fw_cfg.c                        |   8 +-
 hw/openrisc/openrisc_sim.c               |   8 +-
 hw/pci-bridge/dec.c                      |   6 +-
 hw/pci-bridge/pci_expander_bridge.c      |   8 +-
 hw/pci-host/bonito.c                     |   9 +-
 hw/pci-host/designware.c                 |   6 +-
 hw/pci-host/gpex.c                       |   6 +-
 hw/pci-host/i440fx.c                     |   4 +-
 hw/pci-host/pnv_phb3.c                   |  21 ++--
 hw/pci-host/pnv_phb4.c                   |  11 +-
 hw/pci-host/pnv_phb4_pec.c               |  11 +-
 hw/pci-host/prep.c                       |   7 +-
 hw/pci-host/q35.c                        |   6 +-
 hw/pci-host/sabre.c                      |  13 +--
 hw/pci-host/versatile.c                  |   4 +-
 hw/pci-host/xilinx-pcie.c                |   6 +-
 hw/pci/pci.c                             |  31 +++---
 hw/pci/pcie.c                            |   2 +-
 hw/pci/shpc.c                            |   2 +-
 hw/pcmcia/pxa2xx.c                       |   5 +-
 hw/ppc/e500.c                            |  32 +++---
 hw/ppc/mac_newworld.c                    |  46 ++++----
 hw/ppc/mac_oldworld.c                    |  26 ++---
 hw/ppc/pnv.c                             | 103 +++++++-----------
 hw/ppc/pnv_bmc.c                         |   2 +-
 hw/ppc/pnv_core.c                        |   2 +-
 hw/ppc/pnv_psi.c                         |  12 +--
 hw/ppc/ppc440_uc.c                       |  10 +-
 hw/ppc/prep.c                            |  35 ++++---
 hw/ppc/sam460ex.c                        |   4 +-
 hw/ppc/spapr.c                           |  27 +++--
 hw/ppc/spapr_cpu_core.c                  |   2 +-
 hw/ppc/spapr_drc.c                       |   2 +-
 hw/ppc/spapr_iommu.c                     |   2 +-
 hw/ppc/spapr_irq.c                       |   6 +-
 hw/ppc/spapr_pci.c                       |   3 +-
 hw/ppc/spapr_vio.c                       |   4 +-
 hw/ppc/virtex_ml507.c                    |   9 +-
 hw/riscv/opentitan.c                     |  13 +--
 hw/riscv/riscv_hart.c                    |   7 +-
 hw/riscv/sifive_clint.c                  |   5 +-
 hw/riscv/sifive_e.c                      |  21 ++--
 hw/riscv/sifive_e_prci.c                 |   5 +-
 hw/riscv/sifive_plic.c                   |   5 +-
 hw/riscv/sifive_test.c                   |   5 +-
 hw/riscv/sifive_u.c                      |  54 ++++------
 hw/riscv/spike.c                         |   7 +-
 hw/riscv/virt.c                          |  15 ++-
 hw/rtc/m48t59-isa.c                      |   7 +-
 hw/rtc/m48t59.c                          |   5 +-
 hw/rtc/mc146818rtc.c                     |   4 +-
 hw/rtc/sun4v-rtc.c                       |   5 +-
 hw/s390x/ap-bridge.c                     |   4 +-
 hw/s390x/css-bridge.c                    |   6 +-
 hw/s390x/event-facility.c                |  64 ++++++------
 hw/s390x/s390-pci-bus.c                  |   8 +-
 hw/s390x/s390-skeys.c                    |   2 +-
 hw/s390x/s390-stattrib.c                 |   2 +-
 hw/s390x/s390-virtio-ccw.c               |  16 +--
 hw/s390x/sclp.c                          |  12 +--
 hw/s390x/tod.c                           |   2 +-
 hw/s390x/vhost-vsock-ccw.c               |   3 +-
 hw/s390x/virtio-ccw-9p.c                 |   3 +-
 hw/s390x/virtio-ccw-balloon.c            |   3 +-
 hw/s390x/virtio-ccw-blk.c                |   3 +-
 hw/s390x/virtio-ccw-crypto.c             |   3 +-
 hw/s390x/virtio-ccw-gpu.c                |   3 +-
 hw/s390x/virtio-ccw-input.c              |   3 +-
 hw/s390x/virtio-ccw-net.c                |   3 +-
 hw/s390x/virtio-ccw-rng.c                |   3 +-
 hw/s390x/virtio-ccw-scsi.c               |   6 +-
 hw/s390x/virtio-ccw-serial.c             |   3 +-
 hw/scsi/scsi-bus.c                       |   4 +-
 hw/scsi/spapr_vscsi.c                    |   4 +-
 hw/sd/aspeed_sdhci.c                     |   2 +-
 hw/sd/milkymist-memcard.c                |   4 +-
 hw/sd/pxa2xx_mmci.c                      |   7 +-
 hw/sd/sd.c                               |  40 ++++---
 hw/sd/ssi-sd.c                           |   4 +-
 hw/sh4/r2d.c                             |  12 +--
 hw/sparc/leon3.c                         |  20 ++--
 hw/sparc/sun4m.c                         |  64 ++++++------
 hw/sparc64/sun4u.c                       |  50 +++++----
 hw/ssi/aspeed_smc.c                      |   1 -
 hw/ssi/imx_spi.c                         |   2 -
 hw/ssi/mss-spi.c                         |   1 -
 hw/ssi/ssi.c                             |  43 +-------
 hw/ssi/xilinx_spi.c                      |   1 -
 hw/ssi/xilinx_spips.c                    |   4 -
 hw/usb/bus.c                             |  52 ++++-----
 hw/usb/dev-serial.c                      |   4 +-
 hw/virtio/vhost-scsi-pci.c               |   3 +-
 hw/virtio/vhost-user-blk-pci.c           |   3 +-
 hw/virtio/vhost-user-fs-pci.c            |   3 +-
 hw/virtio/vhost-user-scsi-pci.c          |   3 +-
 hw/virtio/vhost-user-vsock-pci.c         |   3 +-
 hw/virtio/vhost-vsock-pci.c              |   3 +-
 hw/virtio/virtio-9p-pci.c                |   3 +-
 hw/virtio/virtio-balloon-pci.c           |   3 +-
 hw/virtio/virtio-blk-pci.c               |   3 +-
 hw/virtio/virtio-crypto-pci.c            |   3 +-
 hw/virtio/virtio-input-pci.c             |   3 +-
 hw/virtio/virtio-iommu-pci.c             |   3 +-
 hw/virtio/virtio-net-pci.c               |   3 +-
 hw/virtio/virtio-pmem-pci.c              |   3 +-
 hw/virtio/virtio-rng-pci.c               |   3 +-
 hw/virtio/virtio-scsi-pci.c              |   3 +-
 hw/virtio/virtio-serial-pci.c            |   3 +-
 hw/virtio/virtio.c                       |   5 +-
 hw/xen/xen-bus.c                         |   4 +-
 hw/xen/xen-legacy-backend.c              |   7 +-
 hw/xtensa/virt.c                         |   4 +-
 hw/xtensa/xtfpga.c                       |   8 +-
 migration/migration.c                    |   2 +-
 qdev-monitor.c                           |   8 +-
 qom/object.c                             |  23 ++--
 qom/qom-hmp-cmds.c                       |  24 +++--
 target/i386/cpu.c                        |   3 +-
 tests/test-qdev-global-props.c           |   9 +-
 MAINTAINERS                              |   4 +
 296 files changed, 2127 insertions(+), 2452 deletions(-)

-- 
2.26.2


