Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BDCC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:50:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE07F204EC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE07F204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1FZf-0000ZZ-Em
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 15:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i1FPs-0007rx-Qg
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:40:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i1FPi-0002Gv-Ji
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:40:08 -0400
Received: from nsstlmta39p.bpe.bigpond.com ([203.38.21.39]:45799)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1i1FPg-0002DQ-JU; Fri, 23 Aug 2019 15:39:58 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep39p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190823193950.RIGR26347.nsstlfep39p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Sat, 24 Aug 2019 05:39:50 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: 
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from dbz.telstra.com.au (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D3692920C8EC1BD; Sat, 24 Aug 2019 05:39:47 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: qemu-devel@nongnu.org
Date: Sat, 24 Aug 2019 05:42:42 +1000
Message-Id: <7ef84d32116ddd701b8423f64aa0a390a2479e85.1566588034.git.tony.nguyen@bt.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566588033.git.tony.nguyen@bt.com>
References: <cover.1566588033.git.tony.nguyen@bt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.39
Subject: [Qemu-devel] [PATCH 3/9] exec: Replace DEVICE_LITTLE_ENDIAN with
 MO_LE
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anthony Green <green@moxielogic.com>,
 Palmer Dabbelt <palmer@sifive.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Keith Busch <keith.busch@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Rob Herring <robh@kernel.org>,
 Hannes Reinecke <hare@suse.com>, Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Jason Wang <jasowang@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eduardo Habkost <ehabkost@redhat.com>,
 Corey Minyard <minyard@acm.org>, qemu-s390x@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yuval Shaia <yuval.shaia@oracle.com>, Beniamino Galvani <b.galvani@gmail.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Durrant <paul.durrant@citrix.com>, Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Tony Nguyen <tony.nguyen@bt.com>, qemu-riscv@nongnu.org,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Andrew Jeffery <andrew@aj.id.au>, Laszlo Ersek <lersek@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, Max Reitz <mreitz@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Simplify endianness comparisons with consistent use of the more
expressive MemOp.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/acpi/core.c                      |  6 +++---
 hw/acpi/cpu.c                       |  2 +-
 hw/acpi/cpu_hotplug.c               |  2 +-
 hw/acpi/ich9.c                      |  4 ++--
 hw/acpi/memory_hotplug.c            |  2 +-
 hw/acpi/nvdimm.c                    |  2 +-
 hw/acpi/pcihp.c                     |  2 +-
 hw/acpi/piix4.c                     |  2 +-
 hw/acpi/tco.c                       |  2 +-
 hw/alpha/pci.c                      |  6 +++---
 hw/alpha/typhoon.c                  |  6 +++---
 hw/arm/aspeed_soc.c                 |  2 +-
 hw/arm/omap1.c                      |  2 +-
 hw/arm/smmuv3.c                     |  2 +-
 hw/audio/ac97.c                     |  4 ++--
 hw/audio/es1370.c                   |  2 +-
 hw/audio/marvell_88w8618.c          |  2 +-
 hw/audio/pl041.c                    |  2 +-
 hw/block/nvme.c                     |  4 ++--
 hw/block/onenand.c                  |  2 +-
 hw/char/cadence_uart.c              |  2 +-
 hw/char/cmsdk-apb-uart.c            |  2 +-
 hw/char/debugcon.c                  |  2 +-
 hw/char/etraxfs_ser.c               |  2 +-
 hw/char/imx_serial.c                |  2 +-
 hw/char/nrf51_uart.c                |  2 +-
 hw/char/pl011.c                     |  2 +-
 hw/char/serial.c                    |  4 ++--
 hw/display/ati.c                    |  2 +-
 hw/display/bochs-display.c          |  4 ++--
 hw/display/cirrus_vga.c             | 10 +++++-----
 hw/display/edid-region.c            |  2 +-
 hw/display/g364fb.c                 |  2 +-
 hw/display/pl110.c                  |  2 +-
 hw/display/sm501.c                  | 10 +++++-----
 hw/display/tc6393xb.c               |  2 +-
 hw/display/vga-pci.c                |  6 +++---
 hw/display/vga.c                    |  2 +-
 hw/display/vmware_vga.c             |  2 +-
 hw/dma/bcm2835_dma.c                |  4 ++--
 hw/dma/etraxfs_dma.c                |  2 +-
 hw/dma/pl080.c                      |  2 +-
 hw/dma/pl330.c                      |  2 +-
 hw/dma/puv3_dma.c                   |  2 +-
 hw/dma/xlnx-zdma.c                  |  2 +-
 hw/dma/xlnx-zynq-devcfg.c           |  2 +-
 hw/gpio/nrf51_gpio.c                |  2 +-
 hw/gpio/pl061.c                     |  2 +-
 hw/gpio/zaurus.c                    |  2 +-
 hw/hppa/dino.c                      |  2 +-
 hw/hyperv/hyperv_testdev.c          |  2 +-
 hw/i2c/aspeed_i2c.c                 |  4 ++--
 hw/i2c/imx_i2c.c                    |  2 +-
 hw/i2c/microbit_i2c.c               |  2 +-
 hw/i2c/pm_smbus.c                   |  2 +-
 hw/i2c/versatile_i2c.c              |  2 +-
 hw/i386/amd_iommu.c                 |  4 ++--
 hw/i386/intel_iommu.c               |  4 ++--
 hw/i386/pc.c                        |  2 +-
 hw/i386/vmport.c                    |  2 +-
 hw/i386/xen/xen_platform.c          |  2 +-
 hw/i386/xen/xen_pvdevice.c          |  2 +-
 hw/ide/ahci-allwinner.c             |  2 +-
 hw/ide/ahci.c                       |  4 ++--
 hw/ide/macio.c                      |  2 +-
 hw/ide/mmio.c                       |  4 ++--
 hw/ide/pci.c                        |  6 +++---
 hw/ide/sii3112.c                    |  2 +-
 hw/input/pckbd.c                    |  4 ++--
 hw/input/pl050.c                    |  2 +-
 hw/intc/arm_gic.c                   | 12 ++++++------
 hw/intc/arm_gicv2m.c                |  2 +-
 hw/intc/arm_gicv3.c                 |  4 ++--
 hw/intc/aspeed_vic.c                |  2 +-
 hw/intc/etraxfs_pic.c               |  2 +-
 hw/intc/heathrow_pic.c              |  2 +-
 hw/intc/imx_avic.c                  |  2 +-
 hw/intc/imx_gpcv2.c                 |  2 +-
 hw/intc/openpic.c                   |  8 ++++----
 hw/intc/pl190.c                     |  2 +-
 hw/intc/puv3_intc.c                 |  2 +-
 hw/intc/xlnx-pmu-iomod-intc.c       |  2 +-
 hw/intc/xlnx-zynqmp-ipi.c           |  2 +-
 hw/ipmi/isa_ipmi_bt.c               |  2 +-
 hw/ipmi/isa_ipmi_kcs.c              |  2 +-
 hw/isa/lpc_ich9.c                   |  4 ++--
 hw/isa/pc87312.c                    |  2 +-
 hw/isa/vt82c686.c                   |  2 +-
 hw/microblaze/petalogix_ml605_mmu.c |  2 +-
 hw/misc/a9scu.c                     |  2 +-
 hw/misc/applesmc.c                  |  6 +++---
 hw/misc/arm11scu.c                  |  2 +-
 hw/misc/arm_l2x0.c                  |  2 +-
 hw/misc/armsse-cpuid.c              |  2 +-
 hw/misc/armsse-mhu.c                |  2 +-
 hw/misc/aspeed_scu.c                |  2 +-
 hw/misc/aspeed_sdmc.c               |  2 +-
 hw/misc/debugexit.c                 |  2 +-
 hw/misc/iotkit-secctl.c             |  4 ++--
 hw/misc/iotkit-sysctl.c             |  2 +-
 hw/misc/iotkit-sysinfo.c            |  2 +-
 hw/misc/macio/gpio.c                |  2 +-
 hw/misc/macio/mac_dbdma.c           |  2 +-
 hw/misc/macio/macio.c               |  2 +-
 hw/misc/mps2-fpgaio.c               |  2 +-
 hw/misc/mps2-scc.c                  |  2 +-
 hw/misc/nrf51_rng.c                 |  2 +-
 hw/misc/pc-testdev.c                | 10 +++++-----
 hw/misc/pci-testdev.c               |  4 ++--
 hw/misc/puv3_pm.c                   |  2 +-
 hw/misc/tz-mpc.c                    |  4 ++--
 hw/misc/tz-msc.c                    |  2 +-
 hw/misc/tz-ppc.c                    |  2 +-
 hw/moxie/moxiesim.c                 |  2 +-
 hw/net/allwinner_emac.c             |  2 +-
 hw/net/cadence_gem.c                |  2 +-
 hw/net/can/can_kvaser_pci.c         |  6 +++---
 hw/net/can/can_mioe3680_pci.c       |  4 ++--
 hw/net/can/can_pcm3680_pci.c        |  4 ++--
 hw/net/e1000.c                      |  4 ++--
 hw/net/e1000e.c                     |  4 ++--
 hw/net/eepro100.c                   |  2 +-
 hw/net/etraxfs_eth.c                |  2 +-
 hw/net/ftgmac100.c                  |  2 +-
 hw/net/imx_fec.c                    |  2 +-
 hw/net/lan9118.c                    |  4 ++--
 hw/net/ne2000.c                     |  2 +-
 hw/net/pcnet-pci.c                  |  4 ++--
 hw/net/rocker/rocker.c              |  2 +-
 hw/net/rtl8139.c                    |  2 +-
 hw/net/smc91c111.c                  |  2 +-
 hw/net/stellaris_enet.c             |  2 +-
 hw/net/sungem.c                     | 12 ++++++------
 hw/net/sunhme.c                     | 10 +++++-----
 hw/net/vmxnet3.c                    |  4 ++--
 hw/net/xgmac.c                      |  2 +-
 hw/net/xilinx_axienet.c             |  2 +-
 hw/nvram/ds1225y.c                  |  2 +-
 hw/nvram/fw_cfg.c                   |  2 +-
 hw/nvram/nrf51_nvm.c                |  8 ++++----
 hw/pci-host/designware.c            |  6 +++---
 hw/pci-host/piix.c                  |  2 +-
 hw/pci-host/prep.c                  |  4 ++--
 hw/pci-host/q35.c                   |  4 ++--
 hw/pci-host/sabre.c                 |  2 +-
 hw/pci-host/uninorth.c              |  2 +-
 hw/pci-host/versatile.c             |  4 ++--
 hw/pci/msix.c                       |  4 ++--
 hw/pci/pci_host.c                   |  4 ++--
 hw/pci/pcie_host.c                  |  2 +-
 hw/pci/shpc.c                       |  2 +-
 hw/ppc/ppc440_pcix.c                |  4 ++--
 hw/ppc/ppc4xx_pci.c                 |  2 +-
 hw/ppc/spapr_pci.c                  |  2 +-
 hw/ppc/virtex_ml507.c               |  2 +-
 hw/rdma/vmw/pvrdma_main.c           |  4 ++--
 hw/riscv/sifive_clint.c             |  2 +-
 hw/riscv/sifive_gpio.c              |  2 +-
 hw/riscv/sifive_plic.c              |  2 +-
 hw/riscv/virt.c                     |  2 +-
 hw/s390x/s390-pci-bus.c             |  2 +-
 hw/scsi/esp-pci.c                   |  2 +-
 hw/scsi/lsi53c895a.c                |  6 +++---
 hw/scsi/megasas.c                   |  6 +++---
 hw/scsi/mptsas.c                    |  6 +++---
 hw/scsi/vmw_pvscsi.c                |  2 +-
 hw/sd/pl181.c                       |  2 +-
 hw/sd/sdhci.c                       |  4 ++--
 hw/ssi/aspeed_smc.c                 |  6 +++---
 hw/ssi/mss-spi.c                    |  2 +-
 hw/ssi/pl022.c                      |  2 +-
 hw/ssi/stm32f2xx_spi.c              |  2 +-
 hw/ssi/xilinx_spips.c               |  8 ++++----
 hw/timer/a9gtimer.c                 |  4 ++--
 hw/timer/arm_mptimer.c              |  4 ++--
 hw/timer/arm_timer.c                |  4 ++--
 hw/timer/armv7m_systick.c           |  2 +-
 hw/timer/aspeed_rtc.c               |  2 +-
 hw/timer/aspeed_timer.c             |  2 +-
 hw/timer/cadence_ttc.c              |  2 +-
 hw/timer/cmsdk-apb-dualtimer.c      |  2 +-
 hw/timer/cmsdk-apb-timer.c          |  2 +-
 hw/timer/etraxfs_timer.c            |  2 +-
 hw/timer/hpet.c                     |  2 +-
 hw/timer/i8254.c                    |  2 +-
 hw/timer/imx_epit.c                 |  2 +-
 hw/timer/imx_gpt.c                  |  2 +-
 hw/timer/m48t59.c                   |  2 +-
 hw/timer/mc146818rtc.c              |  2 +-
 hw/timer/mss-timer.c                |  2 +-
 hw/timer/nrf51_timer.c              |  2 +-
 hw/timer/pl031.c                    |  2 +-
 hw/timer/stm32f2xx_timer.c          |  2 +-
 hw/timer/xlnx-zynqmp-rtc.c          |  2 +-
 hw/tpm/tpm_crb.c                    |  2 +-
 hw/tpm/tpm_tis.c                    |  2 +-
 hw/usb/hcd-ehci-sysbus.c            |  2 +-
 hw/usb/hcd-ehci.c                   |  6 +++---
 hw/usb/hcd-ohci.c                   |  2 +-
 hw/usb/hcd-uhci.c                   |  2 +-
 hw/usb/hcd-xhci.c                   | 10 +++++-----
 hw/vfio/common.c                    |  2 +-
 hw/vfio/pci-quirks.c                | 26 +++++++++++++-------------
 hw/vfio/pci.c                       |  4 ++--
 hw/virtio/virtio-pci.c              | 12 ++++++------
 hw/watchdog/cmsdk-apb-watchdog.c    |  2 +-
 hw/watchdog/wdt_aspeed.c            |  2 +-
 hw/watchdog/wdt_i6300esb.c          |  2 +-
 include/exec/cpu-common.h           |  2 +-
 ioport.c                            |  2 +-
 memory.c                            |  6 +++---
 memory_ldst.inc.c                   | 24 ++++++++++++------------
 212 files changed, 343 insertions(+), 343 deletions(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 45cbed49ab..fd5be650dc 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -463,7 +463,7 @@ static const MemoryRegionOps acpi_pm_evt_ops = {
     .write = acpi_pm_evt_write,
     .valid.min_access_size = 2,
     .valid.max_access_size = 2,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 void acpi_pm1_evt_init(ACPIREGS *ar, acpi_update_sci_fn update_sci,
@@ -532,7 +532,7 @@ static const MemoryRegionOps acpi_pm_tmr_ops = {
     .write = acpi_pm_tmr_write,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 void acpi_pm_tmr_init(ACPIREGS *ar, acpi_update_sci_fn update_sci,
@@ -604,7 +604,7 @@ static const MemoryRegionOps acpi_pm_cnt_ops = {
     .write = acpi_pm_cnt_write,
     .valid.min_access_size = 2,
     .valid.max_access_size = 2,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 void acpi_pm1_cnt_init(ACPIREGS *ar, MemoryRegion *parent,
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 87f30a31d7..09b0d676c3 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -180,7 +180,7 @@ static void cpu_hotplug_wr(void *opaque, hwaddr addr, uint64_t data,
 static const MemoryRegionOps cpu_hotplug_ops = {
     .read = cpu_hotplug_rd,
     .write = cpu_hotplug_wr,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4,
diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
index a83567e6aa..c9a210b700 100644
--- a/hw/acpi/cpu_hotplug.c
+++ b/hw/acpi/cpu_hotplug.c
@@ -48,7 +48,7 @@ static void cpu_status_write(void *opaque, hwaddr addr, uint64_t data,
 static const MemoryRegionOps AcpiCpuHotplug_ops = {
     .read = cpu_status_read,
     .write = cpu_status_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 1,
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 2ca52bf045..140ed7784b 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -77,7 +77,7 @@ static const MemoryRegionOps ich9_gpe_ops = {
     .valid.max_access_size = 4,
     .impl.min_access_size = 1,
     .impl.max_access_size = 1,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static uint64_t ich9_smi_readl(void *opaque, hwaddr addr, unsigned width)
@@ -118,7 +118,7 @@ static const MemoryRegionOps ich9_smi_ops = {
     .write = ich9_smi_writel,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 void ich9_pm_iospace_update(ICH9LPCPMRegs *pm, uint32_t pm_io_base)
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 9483d66e86..e7e5c4801b 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -202,7 +202,7 @@ static void acpi_memory_hotplug_write(void *opaque, hwaddr addr, uint64_t data,
 static const MemoryRegionOps acpi_memory_hotplug_ops = {
     .read = acpi_memory_hotplug_read,
     .write = acpi_memory_hotplug_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4,
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 9fdad6dc3f..b7fe093e3f 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -911,7 +911,7 @@ exit:
 static const MemoryRegionOps nvdimm_dsm_ops = {
     .read = nvdimm_dsm_read,
     .write = nvdimm_dsm_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 82d295b6e8..f4959f9a9a 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -352,7 +352,7 @@ static void pci_write(void *opaque, hwaddr addr, uint64_t data,
 static const MemoryRegionOps acpi_pcihp_io_ops = {
     .read = pci_read,
     .write = pci_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 1c907d2a7d..6e3f736952 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -603,7 +603,7 @@ static const MemoryRegionOps piix4_gpe_ops = {
     .valid.max_access_size = 4,
     .impl.min_access_size = 1,
     .impl.max_access_size = 1,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 
diff --git a/hw/acpi/tco.c b/hw/acpi/tco.c
index fb9052dbca..16222c920c 100644
--- a/hw/acpi/tco.c
+++ b/hw/acpi/tco.c
@@ -217,7 +217,7 @@ static const MemoryRegionOps tco_io_ops = {
     .valid.max_access_size = 4,
     .impl.min_access_size = 1,
     .impl.max_access_size = 2,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 void acpi_pm_tco_init(TCOIORegs *tr, MemoryRegion *parent)
diff --git a/hw/alpha/pci.c b/hw/alpha/pci.c
index 72251fcdf0..0dfaa5cb45 100644
--- a/hw/alpha/pci.c
+++ b/hw/alpha/pci.c
@@ -26,7 +26,7 @@ static void ignore_write(void *opaque, hwaddr addr, uint64_t v, unsigned size)
 const MemoryRegionOps alpha_pci_ignore_ops = {
     .read = ignore_read,
     .write = ignore_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 8,
@@ -56,7 +56,7 @@ static void bw_conf1_write(void *opaque, hwaddr addr,
 const MemoryRegionOps alpha_pci_conf1_ops = {
     .read = bw_conf1_read,
     .write = bw_conf1_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 4,
@@ -79,7 +79,7 @@ static void special_write(void *opaque, hwaddr addr,
 const MemoryRegionOps alpha_pci_iack_ops = {
     .read = iack_read,
     .write = special_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 179e1f7658..75d113788b 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -568,7 +568,7 @@ static MemTxResult pchip_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps cchip_ops = {
     .read_with_attrs = cchip_read,
     .write_with_attrs = cchip_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 8,
         .max_access_size = 8,
@@ -582,7 +582,7 @@ static const MemoryRegionOps cchip_ops = {
 static const MemoryRegionOps dchip_ops = {
     .read = dchip_read,
     .write = dchip_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 8,
         .max_access_size = 8,
@@ -596,7 +596,7 @@ static const MemoryRegionOps dchip_ops = {
 static const MemoryRegionOps pchip_ops = {
     .read_with_attrs = pchip_read,
     .write_with_attrs = pchip_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 8,
         .max_access_size = 8,
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 9ee8104832..93360895cc 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -332,7 +332,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     if (serial_hd(0)) {
         qemu_irq uart5 = aspeed_soc_get_irq(s, ASPEED_UART5);
         serial_mm_init(get_system_memory(), sc->info->memmap[ASPEED_UART5], 2,
-                       uart5, 38400, serial_hd(0), DEVICE_LITTLE_ENDIAN);
+                       uart5, 38400, serial_hd(0), MO_LE);
     }
 
     /* I2C */
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index b6807be542..def50d0b09 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -258,7 +258,7 @@ static void omap_mpu_timer_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps omap_mpu_timer_ops = {
     .read = omap_mpu_timer_read,
     .write = omap_mpu_timer_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void omap_mpu_timer_reset(struct omap_mpu_timer_s *s)
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 2eaf07fb5f..d7c2bbb014 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1349,7 +1349,7 @@ static MemTxResult smmu_read_mmio(void *opaque, hwaddr offset, uint64_t *data,
 static const MemoryRegionOps smmu_mem_ops = {
     .read_with_attrs = smmu_read_mmio,
     .write_with_attrs = smmu_write_mmio,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 8,
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index a136b97f68..1ee74a9d21 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1276,7 +1276,7 @@ static const MemoryRegionOps ac97_io_nam_ops = {
         .min_access_size = 1,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static uint64_t nabm_read(void *opaque, hwaddr addr, unsigned size)
@@ -1325,7 +1325,7 @@ static const MemoryRegionOps ac97_io_nabm_ops = {
         .min_access_size = 1,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void ac97_on_reset (DeviceState *dev)
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index f9e9f2a3b3..2ccee054b8 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -774,7 +774,7 @@ static const MemoryRegionOps es1370_io_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const VMStateDescription vmstate_es1370_channel = {
diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
index da1ab89ce6..6431d1af8f 100644
--- a/hw/audio/marvell_88w8618.c
+++ b/hw/audio/marvell_88w8618.c
@@ -242,7 +242,7 @@ static void mv88w8618_audio_reset(DeviceState *d)
 static const MemoryRegionOps mv88w8618_audio_ops = {
     .read = mv88w8618_audio_read,
     .write = mv88w8618_audio_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void mv88w8618_audio_init(Object *obj)
diff --git a/hw/audio/pl041.c b/hw/audio/pl041.c
index 5803bfcf0c..2715dae341 100644
--- a/hw/audio/pl041.c
+++ b/hw/audio/pl041.c
@@ -522,7 +522,7 @@ static void pl041_device_reset(DeviceState *d)
 static const MemoryRegionOps pl041_ops = {
     .read = pl041_read,
     .write = pl041_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void pl041_init(Object *obj)
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 12d8254250..ce5424dc99 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1273,7 +1273,7 @@ static void nvme_mmio_write(void *opaque, hwaddr addr, uint64_t data,
 static const MemoryRegionOps nvme_mmio_ops = {
     .read = nvme_mmio_read,
     .write = nvme_mmio_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 2,
         .max_access_size = 8,
@@ -1296,7 +1296,7 @@ static uint64_t nvme_cmb_read(void *opaque, hwaddr addr, unsigned size)
 static const MemoryRegionOps nvme_cmb_ops = {
     .read = nvme_cmb_read,
     .write = nvme_cmb_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 8,
diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index 95fc0443d3..e5901e70b8 100644
--- a/hw/block/onenand.c
+++ b/hw/block/onenand.c
@@ -771,7 +771,7 @@ static void onenand_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps onenand_ops = {
     .read = onenand_read,
     .write = onenand_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void onenand_realize(DeviceState *dev, Error **errp)
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index 5a128aa5b3..c961c16457 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -459,7 +459,7 @@ static uint64_t uart_read(void *opaque, hwaddr offset,
 static const MemoryRegionOps uart_ops = {
     .read = uart_read,
     .write = uart_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void cadence_uart_reset(DeviceState *dev)
diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
index 9e1aa43bd3..2002eba5d3 100644
--- a/hw/char/cmsdk-apb-uart.c
+++ b/hw/char/cmsdk-apb-uart.c
@@ -300,7 +300,7 @@ static void uart_write(void *opaque, hwaddr offset, uint64_t value,
 static const MemoryRegionOps uart_ops = {
     .read = uart_read,
     .write = uart_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void cmsdk_apb_uart_reset(DeviceState *dev)
diff --git a/hw/char/debugcon.c b/hw/char/debugcon.c
index 5c592e091b..b214154d21 100644
--- a/hw/char/debugcon.c
+++ b/hw/char/debugcon.c
@@ -82,7 +82,7 @@ static const MemoryRegionOps debugcon_ops = {
     .write = debugcon_ioport_write,
     .valid.min_access_size = 1,
     .valid.max_access_size = 1,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void debugcon_realize_core(DebugconState *s, Error **errp)
diff --git a/hw/char/etraxfs_ser.c b/hw/char/etraxfs_ser.c
index 6096158188..2c2b0271b7 100644
--- a/hw/char/etraxfs_ser.c
+++ b/hw/char/etraxfs_ser.c
@@ -157,7 +157,7 @@ ser_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps ser_ops = {
     .read = ser_read,
     .write = ser_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 8a2f10d7bd..52a305f9eb 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -334,7 +334,7 @@ static void imx_event(void *opaque, int event)
 static const struct MemoryRegionOps imx_serial_ops = {
     .read = imx_serial_read,
     .write = imx_serial_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void imx_serial_realize(DeviceState *dev, Error **errp)
diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c
index 2777afe366..937444a763 100644
--- a/hw/char/nrf51_uart.c
+++ b/hw/char/nrf51_uart.c
@@ -192,7 +192,7 @@ static void uart_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps uart_ops = {
     .read =  uart_read,
     .write = uart_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void nrf51_uart_reset(DeviceState *dev)
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 0a86f6f340..6f46f39486 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -289,7 +289,7 @@ static void pl011_event(void *opaque, int event)
 static const MemoryRegionOps pl011_ops = {
     .read = pl011_read,
     .write = pl011_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const VMStateDescription vmstate_pl011 = {
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 6328476f52..b4e2232fc7 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -977,7 +977,7 @@ const MemoryRegionOps serial_io_ops = {
         .min_access_size = 1,
         .max_access_size = 1,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 SerialState *serial_init(int base, qemu_irq irq, int baudbase,
@@ -1020,7 +1020,7 @@ static const MemoryRegionOps serial_mm_ops[2] = {
     [0] = {
         .read = serial_mm_read,
         .write = serial_mm_write,
-        .endianness = DEVICE_LITTLE_ENDIAN,
+        .endianness = MO_LE,
         .valid.max_access_size = 8,
         .impl.max_access_size = 8,
     },
diff --git a/hw/display/ati.c b/hw/display/ati.c
index 35f49a591b..61b6f9447a 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -810,7 +810,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps ati_mm_ops = {
     .read = ati_mm_read,
     .write = ati_mm_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void ati_vga_realize(PCIDevice *dev, Error **errp)
diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index dc1bd1641d..62fea0c07c 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -107,7 +107,7 @@ static const MemoryRegionOps bochs_display_vbe_ops = {
     .valid.max_access_size = 4,
     .impl.min_access_size = 2,
     .impl.max_access_size = 2,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static uint64_t bochs_display_qext_read(void *ptr, hwaddr addr,
@@ -148,7 +148,7 @@ static const MemoryRegionOps bochs_display_qext_ops = {
     .write = bochs_display_qext_write,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static int bochs_display_get_mode(BochsDisplayState *s,
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index cd283e53b4..cda7d9f5ff 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -2125,7 +2125,7 @@ static void cirrus_vga_mem_write(void *opaque,
 static const MemoryRegionOps cirrus_vga_mem_ops = {
     .read = cirrus_vga_mem_read,
     .write = cirrus_vga_mem_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -2438,7 +2438,7 @@ static void cirrus_linear_bitblt_write(void *opaque,
 static const MemoryRegionOps cirrus_linear_bitblt_io_ops = {
     .read = cirrus_linear_bitblt_read,
     .write = cirrus_linear_bitblt_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -2738,7 +2738,7 @@ static void cirrus_mmio_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps cirrus_mmio_io_ops = {
     .read = cirrus_mmio_read,
     .write = cirrus_mmio_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -2849,7 +2849,7 @@ static void cirrus_reset(void *opaque)
 static const MemoryRegionOps cirrus_linear_io_ops = {
     .read = cirrus_linear_read,
     .write = cirrus_linear_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -2859,7 +2859,7 @@ static const MemoryRegionOps cirrus_linear_io_ops = {
 static const MemoryRegionOps cirrus_vga_io_ops = {
     .read = cirrus_vga_ioport_read,
     .write = cirrus_vga_ioport_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
diff --git a/hw/display/edid-region.c b/hw/display/edid-region.c
index 675429dc18..a7b2252890 100644
--- a/hw/display/edid-region.c
+++ b/hw/display/edid-region.c
@@ -22,7 +22,7 @@ static const MemoryRegionOps edid_region_ops = {
     .valid.max_access_size = 4,
     .impl.min_access_size = 1,
     .impl.max_access_size = 1,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 void qemu_edid_region_io(MemoryRegion *region, Object *owner,
diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index 839d26eca1..d6111a7391 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -431,7 +431,7 @@ static void g364fb_ctrl_write(void *opaque,
 static const MemoryRegionOps g364fb_ctrl_ops = {
     .read = g364fb_ctrl_read,
     .write = g364fb_ctrl_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
 };
diff --git a/hw/display/pl110.c b/hw/display/pl110.c
index 3831505165..65361a0118 100644
--- a/hw/display/pl110.c
+++ b/hw/display/pl110.c
@@ -473,7 +473,7 @@ static void pl110_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps pl110_ops = {
     .read = pl110_read,
     .write = pl110_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void pl110_mux_ctrl_set(void *opaque, int line, int level)
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index d9e5762e36..aa7287c343 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -968,7 +968,7 @@ static const MemoryRegionOps sm501_system_config_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static uint64_t sm501_i2c_read(void *opaque, hwaddr addr, unsigned size)
@@ -1071,7 +1071,7 @@ static const MemoryRegionOps sm501_i2c_ops = {
         .min_access_size = 1,
         .max_access_size = 1,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static uint32_t sm501_palette_read(void *opaque, hwaddr addr)
@@ -1359,7 +1359,7 @@ static const MemoryRegionOps sm501_disp_ctrl_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static uint64_t sm501_2d_engine_read(void *opaque, hwaddr addr,
@@ -1534,7 +1534,7 @@ static const MemoryRegionOps sm501_2d_engine_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 /* draw line functions for all console modes */
@@ -1962,7 +1962,7 @@ static void sm501_realize_sysbus(DeviceState *dev, Error **errp)
     if (s->chr_state) {
         serial_mm_init(&s->state.mmio_region, SM501_UART0, 2,
                        NULL, /* TODO : chain irq to IRL */
-                       115200, s->chr_state, DEVICE_LITTLE_ENDIAN);
+                       115200, s->chr_state, MO_LE);
     }
 }
 
diff --git a/hw/display/tc6393xb.c b/hw/display/tc6393xb.c
index 6a9477a0c7..dd0cf3505d 100644
--- a/hw/display/tc6393xb.c
+++ b/hw/display/tc6393xb.c
@@ -549,7 +549,7 @@ TC6393xbState *tc6393xb_init(MemoryRegion *sysmem, uint32_t base, qemu_irq irq)
     static const MemoryRegionOps tc6393xb_ops = {
         .read = tc6393xb_readb,
         .write = tc6393xb_writeb,
-        .endianness = DEVICE_LITTLE_ENDIAN,
+        .endianness = MO_LE,
         .impl = {
             .min_access_size = 1,
             .max_access_size = 1,
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index a27b88122d..43e0547659 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -111,7 +111,7 @@ static const MemoryRegionOps pci_vga_ioport_ops = {
     .valid.max_access_size = 4,
     .impl.min_access_size = 1,
     .impl.max_access_size = 2,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static uint64_t pci_vga_bochs_read(void *ptr, hwaddr addr,
@@ -141,7 +141,7 @@ static const MemoryRegionOps pci_vga_bochs_ops = {
     .valid.max_access_size = 4,
     .impl.min_access_size = 2,
     .impl.max_access_size = 2,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static uint64_t pci_vga_qext_read(void *ptr, hwaddr addr, unsigned size)
@@ -195,7 +195,7 @@ static const MemoryRegionOps pci_vga_qext_ops = {
     .write = pci_vga_qext_write,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 void pci_std_vga_mmio_region_init(VGACommonState *s,
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 573d223d46..4b04d9bd1e 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -2064,7 +2064,7 @@ static void vga_mem_write(void *opaque, hwaddr addr,
 const MemoryRegionOps vga_mem_ops = {
     .read = vga_mem_read,
     .write = vga_mem_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 23dc8910cc..9408a3b845 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1281,7 +1281,7 @@ static void vmsvga_io_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps vmsvga_io_ops = {
     .read = vmsvga_io_read,
     .write = vmsvga_io_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
index 550e67f686..e5b6e94df9 100644
--- a/hw/dma/bcm2835_dma.c
+++ b/hw/dma/bcm2835_dma.c
@@ -290,7 +290,7 @@ static void bcm2835_dma15_write(void *opaque, hwaddr offset, uint64_t value,
 static const MemoryRegionOps bcm2835_dma0_ops = {
     .read = bcm2835_dma0_read,
     .write = bcm2835_dma0_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
 };
@@ -298,7 +298,7 @@ static const MemoryRegionOps bcm2835_dma0_ops = {
 static const MemoryRegionOps bcm2835_dma15_ops = {
     .read = bcm2835_dma15_read,
     .write = bcm2835_dma15_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
 };
diff --git a/hw/dma/etraxfs_dma.c b/hw/dma/etraxfs_dma.c
index b4e3f83ca4..0c68bd29d2 100644
--- a/hw/dma/etraxfs_dma.c
+++ b/hw/dma/etraxfs_dma.c
@@ -700,7 +700,7 @@ dma_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps dma_ops = {
 	.read = dma_read,
 	.write = dma_write,
-	.endianness = DEVICE_LITTLE_ENDIAN,
+	.endianness = MO_LE,
 	.valid = {
 		.min_access_size = 1,
 		.max_access_size = 4
diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index cbdd1849cd..19fab1b3ed 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -350,7 +350,7 @@ static void pl080_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps pl080_ops = {
     .read = pl080_read,
     .write = pl080_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void pl080_reset(DeviceState *dev)
diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index a9216680ef..f1120abc56 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -1496,7 +1496,7 @@ static uint64_t pl330_iomem_read(void *opaque, hwaddr offset,
 static const MemoryRegionOps pl330_ops = {
     .read = pl330_iomem_read,
     .write = pl330_iomem_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/dma/puv3_dma.c b/hw/dma/puv3_dma.c
index 1577056715..ae58c20b65 100644
--- a/hw/dma/puv3_dma.c
+++ b/hw/dma/puv3_dma.c
@@ -74,7 +74,7 @@ static const MemoryRegionOps puv3_dma_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void puv3_dma_realize(DeviceState *dev, Error **errp)
diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 75b660988f..69e16b0d46 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -745,7 +745,7 @@ static void zdma_write(void *opaque, hwaddr addr, uint64_t value,
 static const MemoryRegionOps zdma_ops = {
     .read = zdma_read,
     .write = zdma_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index e33112b6f0..dd7145aa80 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -320,7 +320,7 @@ static const RegisterAccessInfo xlnx_zynq_devcfg_regs_info[] = {
 static const MemoryRegionOps xlnx_zynq_devcfg_reg_ops = {
     .read = register_read_memory,
     .write = register_write_memory,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/gpio/nrf51_gpio.c b/hw/gpio/nrf51_gpio.c
index b47fddf4ed..4e09e57ef9 100644
--- a/hw/gpio/nrf51_gpio.c
+++ b/hw/gpio/nrf51_gpio.c
@@ -227,7 +227,7 @@ static void nrf51_gpio_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps gpio_ops = {
     .read =  nrf51_gpio_read,
     .write = nrf51_gpio_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
 };
diff --git a/hw/gpio/pl061.c b/hw/gpio/pl061.c
index 25371d6c5a..15a45a22e7 100644
--- a/hw/gpio/pl061.c
+++ b/hw/gpio/pl061.c
@@ -341,7 +341,7 @@ static void pl061_set_irq(void * opaque, int irq, int level)
 static const MemoryRegionOps pl061_ops = {
     .read = pl061_read,
     .write = pl061_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void pl061_luminary_init(Object *obj)
diff --git a/hw/gpio/zaurus.c b/hw/gpio/zaurus.c
index 60bbbb8564..d7ba4c2ee7 100644
--- a/hw/gpio/zaurus.c
+++ b/hw/gpio/zaurus.c
@@ -157,7 +157,7 @@ static void scoop_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps scoop_ops = {
     .read = scoop_read,
     .write = scoop_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void scoop_gpio_set(void *opaque, int line, int level)
diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index e0466ee055..5bc223d9b2 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -357,7 +357,7 @@ static void dino_config_data_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps dino_config_data_ops = {
     .read = dino_config_data_read,
     .write = dino_config_data_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static uint64_t dino_config_addr_read(void *opaque, hwaddr addr, unsigned len)
diff --git a/hw/hyperv/hyperv_testdev.c b/hw/hyperv/hyperv_testdev.c
index 88a5a63782..e09e575800 100644
--- a/hw/hyperv/hyperv_testdev.c
+++ b/hw/hyperv/hyperv_testdev.c
@@ -287,7 +287,7 @@ static const MemoryRegionOps synic_test_sint_ops = {
     .write = hv_test_dev_write,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void hv_test_dev_realizefn(DeviceState *d, Error **errp)
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index a956eb3849..4fffc49bfa 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -366,13 +366,13 @@ static void aspeed_i2c_ctrl_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps aspeed_i2c_bus_ops = {
     .read = aspeed_i2c_bus_read,
     .write = aspeed_i2c_bus_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const MemoryRegionOps aspeed_i2c_ctrl_ops = {
     .read = aspeed_i2c_ctrl_read,
     .write = aspeed_i2c_ctrl_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const VMStateDescription aspeed_i2c_bus_vmstate = {
diff --git a/hw/i2c/imx_i2c.c b/hw/i2c/imx_i2c.c
index cc2689d967..a74a6672b6 100644
--- a/hw/i2c/imx_i2c.c
+++ b/hw/i2c/imx_i2c.c
@@ -278,7 +278,7 @@ static const MemoryRegionOps imx_i2c_ops = {
     .write = imx_i2c_write,
     .valid.min_access_size = 1,
     .valid.max_access_size = 2,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const VMStateDescription imx_i2c_vmstate = {
diff --git a/hw/i2c/microbit_i2c.c b/hw/i2c/microbit_i2c.c
index 4661f05253..3d5c730870 100644
--- a/hw/i2c/microbit_i2c.c
+++ b/hw/i2c/microbit_i2c.c
@@ -71,7 +71,7 @@ static void microbit_i2c_write(void *opaque, hwaddr addr, uint64_t data,
 static const MemoryRegionOps microbit_i2c_ops = {
     .read = microbit_i2c_read,
     .write = microbit_i2c_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
 };
diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 36994ff585..c01cc04a5b 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -452,7 +452,7 @@ static const MemoryRegionOps pm_smbus_ops = {
     .write = smb_ioport_writeb,
     .valid.min_access_size = 1,
     .valid.max_access_size = 1,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 bool pm_smbus_vmstate_needed(void)
diff --git a/hw/i2c/versatile_i2c.c b/hw/i2c/versatile_i2c.c
index c92d3b115c..be0f9892fe 100644
--- a/hw/i2c/versatile_i2c.c
+++ b/hw/i2c/versatile_i2c.c
@@ -77,7 +77,7 @@ static void versatile_i2c_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps versatile_i2c_ops = {
     .read = versatile_i2c_read,
     .write = versatile_i2c_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void versatile_i2c_init(Object *obj)
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 08884523e2..140755ec1d 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1380,7 +1380,7 @@ static MemTxResult amdvi_mem_ir_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps amdvi_ir_ops = {
     .read_with_attrs = amdvi_mem_ir_read,
     .write_with_attrs = amdvi_mem_ir_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -1454,7 +1454,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 static const MemoryRegionOps mmio_mem_ops = {
     .read = amdvi_mmio_read,
     .write = amdvi_mmio_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 8,
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 75ca6f9c70..eb7f2cf841 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2996,7 +2996,7 @@ static const VMStateDescription vtd_vmstate = {
 static const MemoryRegionOps vtd_mem_ops = {
     .read = vtd_mem_read,
     .write = vtd_mem_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 8,
@@ -3273,7 +3273,7 @@ static MemTxResult vtd_mem_ir_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps vtd_mem_ir_ops = {
     .read_with_attrs = vtd_mem_ir_read,
     .write_with_attrs = vtd_mem_ir_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f79922d096..a4fb97fdf1 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -819,7 +819,7 @@ static const MemoryRegionOps port92_ops = {
         .min_access_size = 1,
         .max_access_size = 1,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void port92_initfn(Object *obj)
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 1f31e27c8a..65bce73024 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -137,7 +137,7 @@ static const MemoryRegionOps vmport_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void vmport_realizefn(DeviceState *dev, Error **errp)
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index bf0c6eb341..3e6b476cf4 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -329,7 +329,7 @@ static const MemoryRegionOps platform_fixed_io_ops = {
         .max_access_size = 4,
         .unaligned = true,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void platform_fixed_ioport_init(PCIXenPlatformState* s)
diff --git a/hw/i386/xen/xen_pvdevice.c b/hw/i386/xen/xen_pvdevice.c
index 27f646da06..a4d06b25bd 100644
--- a/hw/i386/xen/xen_pvdevice.c
+++ b/hw/i386/xen/xen_pvdevice.c
@@ -70,7 +70,7 @@ static void xen_pv_mmio_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps xen_pv_mmio_ops = {
     .read = &xen_pv_mmio_read,
     .write = &xen_pv_mmio_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const VMStateDescription vmstate_xen_pvdevice = {
diff --git a/hw/ide/ahci-allwinner.c b/hw/ide/ahci-allwinner.c
index bb8393d2b6..1d1686a4fe 100644
--- a/hw/ide/ahci-allwinner.c
+++ b/hw/ide/ahci-allwinner.c
@@ -82,7 +82,7 @@ static const MemoryRegionOps allwinner_ahci_mem_ops = {
     .write = allwinner_ahci_mem_write,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void allwinner_ahci_init(Object *obj)
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index d45393c019..5271ae1338 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -523,7 +523,7 @@ static void ahci_mem_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps ahci_mem_ops = {
     .read = ahci_mem_read,
     .write = ahci_mem_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static uint64_t ahci_idp_read(void *opaque, hwaddr addr,
@@ -559,7 +559,7 @@ static void ahci_idp_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps ahci_idp_ops = {
     .read = ahci_idp_read,
     .write = ahci_idp_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index 79f787c539..9aa802153d 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -352,7 +352,7 @@ static const MemoryRegionOps pmac_ide_ops = {
     .write = pmac_ide_write,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const VMStateDescription vmstate_pmac = {
diff --git a/hw/ide/mmio.c b/hw/ide/mmio.c
index 7149a9cba6..339b064ed4 100644
--- a/hw/ide/mmio.c
+++ b/hw/ide/mmio.c
@@ -85,7 +85,7 @@ static void mmio_ide_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps mmio_ide_ops = {
     .read = mmio_ide_read,
     .write = mmio_ide_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static uint64_t mmio_ide_status_read(void *opaque, hwaddr addr,
@@ -105,7 +105,7 @@ static void mmio_ide_cmd_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps mmio_ide_cs_ops = {
     .read = mmio_ide_status_read,
     .write = mmio_ide_cmd_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const VMStateDescription vmstate_ide_mmio = {
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index cce1da804d..abff389665 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -62,7 +62,7 @@ static void pci_ide_cmd_write(void *opaque, hwaddr addr,
 const MemoryRegionOps pci_ide_cmd_le_ops = {
     .read = pci_ide_cmd_read,
     .write = pci_ide_cmd_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static uint64_t pci_ide_data_read(void *opaque, hwaddr addr, unsigned size)
@@ -100,7 +100,7 @@ static void pci_ide_data_write(void *opaque, hwaddr addr,
 const MemoryRegionOps pci_ide_data_le_ops = {
     .read = pci_ide_data_read,
     .write = pci_ide_data_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void bmdma_start_dma(IDEDMA *dma, IDEState *s,
@@ -338,7 +338,7 @@ static void bmdma_addr_write(void *opaque, hwaddr addr,
 MemoryRegionOps bmdma_addr_ioport_ops = {
     .read = bmdma_addr_read,
     .write = bmdma_addr_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static bool ide_bmdma_current_needed(void *opaque)
diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index 2181260531..9d15472cdd 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -209,7 +209,7 @@ static void sii3112_reg_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps sii3112_reg_ops = {
     .read = sii3112_reg_read,
     .write = sii3112_reg_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 /* the PCI irq level is the logical OR of the two channels */
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index 3676131427..447376009a 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -521,7 +521,7 @@ static const MemoryRegionOps i8042_data_ops = {
         .min_access_size = 1,
         .max_access_size = 1,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const MemoryRegionOps i8042_cmd_ops = {
@@ -531,7 +531,7 @@ static const MemoryRegionOps i8042_cmd_ops = {
         .min_access_size = 1,
         .max_access_size = 1,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void i8042_initfn(Object *obj)
diff --git a/hw/input/pl050.c b/hw/input/pl050.c
index 873f44abad..76e21428f2 100644
--- a/hw/input/pl050.c
+++ b/hw/input/pl050.c
@@ -139,7 +139,7 @@ static void pl050_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps pl050_ops = {
     .read = pl050_read,
     .write = pl050_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void pl050_realize(DeviceState *dev, Error **errp)
diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index abcadc9af4..3b5d8320bd 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -2000,38 +2000,38 @@ static const MemoryRegionOps gic_ops[2] = {
     {
         .read_with_attrs = gic_dist_read,
         .write_with_attrs = gic_dist_write,
-        .endianness = DEVICE_LITTLE_ENDIAN,
+        .endianness = MO_LE,
     },
     {
         .read_with_attrs = gic_thiscpu_read,
         .write_with_attrs = gic_thiscpu_write,
-        .endianness = DEVICE_LITTLE_ENDIAN,
+        .endianness = MO_LE,
     }
 };
 
 static const MemoryRegionOps gic_cpu_ops = {
     .read_with_attrs = gic_do_cpu_read,
     .write_with_attrs = gic_do_cpu_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const MemoryRegionOps gic_virt_ops[2] = {
     {
         .read_with_attrs = gic_thiscpu_hyp_read,
         .write_with_attrs = gic_thiscpu_hyp_write,
-        .endianness = DEVICE_LITTLE_ENDIAN,
+        .endianness = MO_LE,
     },
     {
         .read_with_attrs = gic_thisvcpu_read,
         .write_with_attrs = gic_thisvcpu_write,
-        .endianness = DEVICE_LITTLE_ENDIAN,
+        .endianness = MO_LE,
     }
 };
 
 static const MemoryRegionOps gic_viface_ops = {
     .read_with_attrs = gic_do_hyp_read,
     .write_with_attrs = gic_do_hyp_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void arm_gic_realize(DeviceState *dev, Error **errp)
diff --git a/hw/intc/arm_gicv2m.c b/hw/intc/arm_gicv2m.c
index 6e45f4ff39..aa2aafe086 100644
--- a/hw/intc/arm_gicv2m.c
+++ b/hw/intc/arm_gicv2m.c
@@ -128,7 +128,7 @@ static void gicv2m_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps gicv2m_ops = {
     .read = gicv2m_read,
     .write = gicv2m_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void gicv2m_realize(DeviceState *dev, Error **errp)
diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
index 9b4d5bad69..3e6526dcd1 100644
--- a/hw/intc/arm_gicv3.c
+++ b/hw/intc/arm_gicv3.c
@@ -352,12 +352,12 @@ static const MemoryRegionOps gic_ops[] = {
     {
         .read_with_attrs = gicv3_dist_read,
         .write_with_attrs = gicv3_dist_write,
-        .endianness = DEVICE_LITTLE_ENDIAN,
+        .endianness = MO_LE,
     },
     {
         .read_with_attrs = gicv3_redist_read,
         .write_with_attrs = gicv3_redist_write,
-        .endianness = DEVICE_LITTLE_ENDIAN,
+        .endianness = MO_LE,
     }
 };
 
diff --git a/hw/intc/aspeed_vic.c b/hw/intc/aspeed_vic.c
index 5ba06c5262..42ff5c8b2c 100644
--- a/hw/intc/aspeed_vic.c
+++ b/hw/intc/aspeed_vic.c
@@ -285,7 +285,7 @@ static void aspeed_vic_write(void *opaque, hwaddr offset, uint64_t data,
 static const MemoryRegionOps aspeed_vic_ops = {
     .read = aspeed_vic_read,
     .write = aspeed_vic_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
     .valid.unaligned = false,
diff --git a/hw/intc/etraxfs_pic.c b/hw/intc/etraxfs_pic.c
index 5895b671b1..2bedb55026 100644
--- a/hw/intc/etraxfs_pic.c
+++ b/hw/intc/etraxfs_pic.c
@@ -112,7 +112,7 @@ static void pic_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps pic_ops = {
     .read = pic_read,
     .write = pic_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/intc/heathrow_pic.c b/hw/intc/heathrow_pic.c
index cb97c315da..82c6f3c6d0 100644
--- a/hw/intc/heathrow_pic.c
+++ b/hw/intc/heathrow_pic.c
@@ -110,7 +110,7 @@ static uint64_t heathrow_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps heathrow_ops = {
     .read = heathrow_read,
     .write = heathrow_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void heathrow_set_irq(void *opaque, int num, int level)
diff --git a/hw/intc/imx_avic.c b/hw/intc/imx_avic.c
index 15ed512e86..d16cb3db76 100644
--- a/hw/intc/imx_avic.c
+++ b/hw/intc/imx_avic.c
@@ -310,7 +310,7 @@ static void imx_avic_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps imx_avic_ops = {
     .read = imx_avic_read,
     .write = imx_avic_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void imx_avic_reset(DeviceState *dev)
diff --git a/hw/intc/imx_gpcv2.c b/hw/intc/imx_gpcv2.c
index 3df4a443b8..f808892e19 100644
--- a/hw/intc/imx_gpcv2.c
+++ b/hw/intc/imx_gpcv2.c
@@ -65,7 +65,7 @@ static void imx_gpcv2_write(void *opaque, hwaddr offset,
 static const struct MemoryRegionOps imx_gpcv2_ops = {
     .read = imx_gpcv2_read,
     .write = imx_gpcv2_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         /*
          * Our device would not work correctly if the guest was doing
diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index c797ba78f3..4e8d5a8050 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -1150,7 +1150,7 @@ static uint64_t openpic_cpu_read(void *opaque, hwaddr addr, unsigned len)
 static const MemoryRegionOps openpic_glb_ops_le = {
     .write = openpic_gbl_write,
     .read  = openpic_gbl_read,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -1170,7 +1170,7 @@ static const MemoryRegionOps openpic_glb_ops_be = {
 static const MemoryRegionOps openpic_tmr_ops_le = {
     .write = openpic_tmr_write,
     .read  = openpic_tmr_read,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -1190,7 +1190,7 @@ static const MemoryRegionOps openpic_tmr_ops_be = {
 static const MemoryRegionOps openpic_cpu_ops_le = {
     .write = openpic_cpu_write,
     .read  = openpic_cpu_read,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -1210,7 +1210,7 @@ static const MemoryRegionOps openpic_cpu_ops_be = {
 static const MemoryRegionOps openpic_src_ops_le = {
     .write = openpic_src_write,
     .read  = openpic_src_read,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/intc/pl190.c b/hw/intc/pl190.c
index 1b474d25b9..88e6e3df6c 100644
--- a/hw/intc/pl190.c
+++ b/hw/intc/pl190.c
@@ -222,7 +222,7 @@ static void pl190_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps pl190_ops = {
     .read = pl190_read,
     .write = pl190_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void pl190_reset(DeviceState *d)
diff --git a/hw/intc/puv3_intc.c b/hw/intc/puv3_intc.c
index 1c8ddbd70d..b4a85039c0 100644
--- a/hw/intc/puv3_intc.c
+++ b/hw/intc/puv3_intc.c
@@ -101,7 +101,7 @@ static const MemoryRegionOps puv3_intc_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void puv3_intc_realize(DeviceState *dev, Error **errp)
diff --git a/hw/intc/xlnx-pmu-iomod-intc.c b/hw/intc/xlnx-pmu-iomod-intc.c
index f9a1401a94..cb8fb86053 100644
--- a/hw/intc/xlnx-pmu-iomod-intc.c
+++ b/hw/intc/xlnx-pmu-iomod-intc.c
@@ -467,7 +467,7 @@ static void xlnx_pmu_io_intc_reset(DeviceState *dev)
 static const MemoryRegionOps xlnx_pmu_io_intc_ops = {
     .read = register_read_memory,
     .write = register_write_memory,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/intc/xlnx-zynqmp-ipi.c b/hw/intc/xlnx-zynqmp-ipi.c
index adc1179014..93a87a281c 100644
--- a/hw/intc/xlnx-zynqmp-ipi.c
+++ b/hw/intc/xlnx-zynqmp-ipi.c
@@ -297,7 +297,7 @@ static void xlnx_zynqmp_obs_handler(void *opaque, int n, int level)
 static const MemoryRegionOps xlnx_zynqmp_ipi_ops = {
     .read = register_read_memory,
     .write = register_write_memory,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index a696096cbb..69c2f6f466 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -322,7 +322,7 @@ static const MemoryRegionOps ipmi_bt_io_ops = {
         .min_access_size = 1,
         .max_access_size = 1,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void ipmi_bt_set_atn(IPMIInterface *ii, int val, int irq)
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index 374b2a0709..6ea485a106 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -315,7 +315,7 @@ const MemoryRegionOps ipmi_kcs_io_ops = {
         .min_access_size = 1,
         .max_access_size = 1,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void ipmi_kcs_set_atn(IPMIInterface *ii, int val, int irq)
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index eec9eb31c1..fd75d1e63d 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -573,7 +573,7 @@ static void ich9_lpc_reset(DeviceState *qdev)
 static const MemoryRegionOps rcrb_mmio_ops = {
     .read = ich9_cc_read,
     .write = ich9_cc_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void ich9_lpc_machine_ready(Notifier *n, void *opaque)
@@ -624,7 +624,7 @@ static uint64_t ich9_rst_cnt_read(void *opaque, hwaddr addr, unsigned len)
 static const MemoryRegionOps ich9_rst_cnt_ops = {
     .read = ich9_rst_cnt_read,
     .write = ich9_rst_cnt_write,
-    .endianness = DEVICE_LITTLE_ENDIAN
+    .endianness = MO_LE
 };
 
 static void ich9_lpc_get_sci_int(Object *obj, Visitor *v, const char *name,
diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index b9bd57471e..11a9a8466f 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -267,7 +267,7 @@ static uint64_t pc87312_io_read(void *opaque, hwaddr addr, unsigned int size)
 static const MemoryRegionOps pc87312_io_ops = {
     .read  = pc87312_io_read,
     .write = pc87312_io_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 1,
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 400f2b3c87..3596adee51 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -109,7 +109,7 @@ static uint64_t superio_ioport_readb(void *opaque, hwaddr addr, unsigned size)
 static const MemoryRegionOps superio_ops = {
     .read = superio_ioport_readb,
     .write = superio_ioport_writeb,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 09486bc8bf..c06ca9280e 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -122,7 +122,7 @@ petalogix_ml605_init(MachineState *machine)
 
     serial_mm_init(address_space_mem, UART16550_BASEADDR + 0x1000, 2,
                    irq[UART16550_IRQ], 115200, serial_hd(0),
-                   DEVICE_LITTLE_ENDIAN);
+                   MO_LE);
 
     /* 2 timers at irq 2 @ 100 Mhz.  */
     dev = qdev_create(NULL, "xlnx.xps-timer");
diff --git a/hw/misc/a9scu.c b/hw/misc/a9scu.c
index 59335ca72f..6396a78778 100644
--- a/hw/misc/a9scu.c
+++ b/hw/misc/a9scu.c
@@ -96,7 +96,7 @@ static void a9_scu_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps a9_scu_ops = {
     .read = a9_scu_read,
     .write = a9_scu_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void a9_scu_reset(DeviceState *dev)
diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index fb39837b7f..0de32d4275 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -285,7 +285,7 @@ static void qdev_applesmc_isa_reset(DeviceState *dev)
 static const MemoryRegionOps applesmc_data_io_ops = {
     .write = applesmc_io_data_write,
     .read = applesmc_io_data_read,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -295,7 +295,7 @@ static const MemoryRegionOps applesmc_data_io_ops = {
 static const MemoryRegionOps applesmc_cmd_io_ops = {
     .write = applesmc_io_cmd_write,
     .read = applesmc_io_cmd_read,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -305,7 +305,7 @@ static const MemoryRegionOps applesmc_cmd_io_ops = {
 static const MemoryRegionOps applesmc_err_io_ops = {
     .write = applesmc_io_err_write,
     .read = applesmc_io_err_read,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
diff --git a/hw/misc/arm11scu.c b/hw/misc/arm11scu.c
index dd690dc985..a4ad53638c 100644
--- a/hw/misc/arm11scu.c
+++ b/hw/misc/arm11scu.c
@@ -58,7 +58,7 @@ static void mpcore_scu_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps mpcore_scu_ops = {
     .read = mpcore_scu_read,
     .write = mpcore_scu_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void arm11_scu_realize(DeviceState *dev, Error **errp)
diff --git a/hw/misc/arm_l2x0.c b/hw/misc/arm_l2x0.c
index cd1747b7a1..2d0ccc1228 100644
--- a/hw/misc/arm_l2x0.c
+++ b/hw/misc/arm_l2x0.c
@@ -159,7 +159,7 @@ static void l2x0_priv_reset(DeviceState *dev)
 static const MemoryRegionOps l2x0_mem_ops = {
     .read = l2x0_priv_read,
     .write = l2x0_priv_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
  };
 
 static void l2x0_priv_init(Object *obj)
diff --git a/hw/misc/armsse-cpuid.c b/hw/misc/armsse-cpuid.c
index 8ab15fea81..61294b7413 100644
--- a/hw/misc/armsse-cpuid.c
+++ b/hw/misc/armsse-cpuid.c
@@ -84,7 +84,7 @@ static void armsse_cpuid_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps armsse_cpuid_ops = {
     .read = armsse_cpuid_read,
     .write = armsse_cpuid_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     /* byte/halfword accesses are just zero-padded on reads and writes */
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
diff --git a/hw/misc/armsse-mhu.c b/hw/misc/armsse-mhu.c
index a45d97fada..24cfdedddf 100644
--- a/hw/misc/armsse-mhu.c
+++ b/hw/misc/armsse-mhu.c
@@ -140,7 +140,7 @@ static void armsse_mhu_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps armsse_mhu_ops = {
     .read = armsse_mhu_read,
     .write = armsse_mhu_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
 };
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 268cb24e56..66db82959d 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -277,7 +277,7 @@ static void aspeed_scu_write(void *opaque, hwaddr offset, uint64_t data,
 static const MemoryRegionOps aspeed_scu_ops = {
     .read = aspeed_scu_read,
     .write = aspeed_scu_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
     .valid.unaligned = false,
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index cb13c63ec8..34a38c7503 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -170,7 +170,7 @@ static void aspeed_sdmc_write(void *opaque, hwaddr addr, uint64_t data,
 static const MemoryRegionOps aspeed_sdmc_ops = {
     .read = aspeed_sdmc_read,
     .write = aspeed_sdmc_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
 };
diff --git a/hw/misc/debugexit.c b/hw/misc/debugexit.c
index ccf02bdbd4..e15a4755a8 100644
--- a/hw/misc/debugexit.c
+++ b/hw/misc/debugexit.c
@@ -40,7 +40,7 @@ static const MemoryRegionOps debug_exit_ops = {
     .write = debug_exit_write,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void debug_exit_realizefn(DeviceState *d, Error **errp)
diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index 609869821a..1b64231788 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -562,7 +562,7 @@ static MemTxResult iotkit_secctl_ns_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps iotkit_secctl_s_ops = {
     .read_with_attrs = iotkit_secctl_s_read,
     .write_with_attrs = iotkit_secctl_s_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .impl.min_access_size = 1,
@@ -572,7 +572,7 @@ static const MemoryRegionOps iotkit_secctl_s_ops = {
 static const MemoryRegionOps iotkit_secctl_ns_ops = {
     .read_with_attrs = iotkit_secctl_ns_read,
     .write_with_attrs = iotkit_secctl_ns_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .impl.min_access_size = 1,
diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
index 9aa8109463..cd23d3f273 100644
--- a/hw/misc/iotkit-sysctl.c
+++ b/hw/misc/iotkit-sysctl.c
@@ -390,7 +390,7 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps iotkit_sysctl_ops = {
     .read = iotkit_sysctl_read,
     .write = iotkit_sysctl_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     /* byte/halfword accesses are just zero-padded on reads and writes */
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
diff --git a/hw/misc/iotkit-sysinfo.c b/hw/misc/iotkit-sysinfo.c
index 783e613959..8bb8e717b1 100644
--- a/hw/misc/iotkit-sysinfo.c
+++ b/hw/misc/iotkit-sysinfo.c
@@ -88,7 +88,7 @@ static void iotkit_sysinfo_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps iotkit_sysinfo_ops = {
     .read = iotkit_sysinfo_read,
     .write = iotkit_sysinfo_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     /* byte/halfword accesses are just zero-padded on reads and writes */
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
index 6cca6b27d6..920fa93196 100644
--- a/hw/misc/macio/gpio.c
+++ b/hw/misc/macio/gpio.c
@@ -145,7 +145,7 @@ static uint64_t macio_gpio_read(void *opaque, hwaddr addr, unsigned size)
 static const MemoryRegionOps macio_gpio_ops = {
     .read = macio_gpio_read,
     .write = macio_gpio_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
index e220f1a927..a5dd2c68a1 100644
--- a/hw/misc/macio/mac_dbdma.c
+++ b/hw/misc/macio/mac_dbdma.c
@@ -794,7 +794,7 @@ static uint64_t dbdma_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps dbdma_ops = {
     .read = dbdma_read,
     .write = dbdma_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 50f20d8206..72c66a0fa9 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -286,7 +286,7 @@ static uint64_t timer_read(void *opaque, hwaddr addr, unsigned size)
 static const MemoryRegionOps timer_ops = {
     .read = timer_read,
     .write = timer_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void macio_newworld_realize(PCIDevice *d, Error **errp)
diff --git a/hw/misc/mps2-fpgaio.c b/hw/misc/mps2-fpgaio.c
index 5e8b103914..f57ff87542 100644
--- a/hw/misc/mps2-fpgaio.c
+++ b/hw/misc/mps2-fpgaio.c
@@ -222,7 +222,7 @@ static void mps2_fpgaio_write(void *opaque, hwaddr offset, uint64_t value,
 static const MemoryRegionOps mps2_fpgaio_ops = {
     .read = mps2_fpgaio_read,
     .write = mps2_fpgaio_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void mps2_fpgaio_reset(DeviceState *dev)
diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 25779a1dca..c7f9ba98cc 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -217,7 +217,7 @@ static void mps2_scc_write(void *opaque, hwaddr offset, uint64_t value,
 static const MemoryRegionOps mps2_scc_ops = {
     .read = mps2_scc_read,
     .write = mps2_scc_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void mps2_scc_reset(DeviceState *dev)
diff --git a/hw/misc/nrf51_rng.c b/hw/misc/nrf51_rng.c
index 5140981c96..fba72e2937 100644
--- a/hw/misc/nrf51_rng.c
+++ b/hw/misc/nrf51_rng.c
@@ -140,7 +140,7 @@ static void rng_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps rng_ops = {
     .read =  rng_read,
     .write = rng_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4
 };
diff --git a/hw/misc/pc-testdev.c b/hw/misc/pc-testdev.c
index 0fb84ddc6b..c56726e3f4 100644
--- a/hw/misc/pc-testdev.c
+++ b/hw/misc/pc-testdev.c
@@ -77,7 +77,7 @@ static const MemoryRegionOps test_irq_ops = {
     .write = test_irq_line_write,
     .valid.min_access_size = 1,
     .valid.max_access_size = 1,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void test_ioport_write(void *opaque, hwaddr addr, uint64_t data,
@@ -103,7 +103,7 @@ static uint64_t test_ioport_read(void *opaque, hwaddr addr, unsigned len)
 static const MemoryRegionOps test_ioport_ops = {
     .read = test_ioport_read,
     .write = test_ioport_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const MemoryRegionOps test_ioport_byte_ops = {
@@ -113,7 +113,7 @@ static const MemoryRegionOps test_ioport_byte_ops = {
     .valid.max_access_size = 4,
     .impl.min_access_size = 1,
     .impl.max_access_size = 1,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static uint64_t test_flush_page_read(void *opaque, hwaddr addr, unsigned size)
@@ -141,7 +141,7 @@ static const MemoryRegionOps test_flush_ops = {
     .write = test_flush_page_write,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static uint64_t test_iomem_read(void *opaque, hwaddr addr, unsigned len)
@@ -164,7 +164,7 @@ static void test_iomem_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps test_iomem_ops = {
     .read = test_iomem_read,
     .write = test_iomem_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void testdev_realizefn(DeviceState *d, Error **errp)
diff --git a/hw/misc/pci-testdev.c b/hw/misc/pci-testdev.c
index 74d8571a73..615c5deea0 100644
--- a/hw/misc/pci-testdev.c
+++ b/hw/misc/pci-testdev.c
@@ -222,7 +222,7 @@ pci_testdev_pio_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps pci_testdev_mmio_ops = {
     .read = pci_testdev_read,
     .write = pci_testdev_mmio_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -232,7 +232,7 @@ static const MemoryRegionOps pci_testdev_mmio_ops = {
 static const MemoryRegionOps pci_testdev_pio_ops = {
     .read = pci_testdev_read,
     .write = pci_testdev_pio_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
diff --git a/hw/misc/puv3_pm.c b/hw/misc/puv3_pm.c
index b04950ecb9..d83bf6a786 100644
--- a/hw/misc/puv3_pm.c
+++ b/hw/misc/puv3_pm.c
@@ -117,7 +117,7 @@ static const MemoryRegionOps puv3_pm_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void puv3_pm_realize(DeviceState *dev, Error **errp)
diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
index 49dd6050bd..e310dc59ba 100644
--- a/hw/misc/tz-mpc.c
+++ b/hw/misc/tz-mpc.c
@@ -335,7 +335,7 @@ static MemTxResult tz_mpc_reg_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps tz_mpc_reg_ops = {
     .read_with_attrs = tz_mpc_reg_read,
     .write_with_attrs = tz_mpc_reg_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .impl.min_access_size = 1,
@@ -411,7 +411,7 @@ static MemTxResult tz_mpc_mem_blocked_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps tz_mpc_mem_blocked_ops = {
     .read_with_attrs = tz_mpc_mem_blocked_read,
     .write_with_attrs = tz_mpc_mem_blocked_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid.min_access_size = 1,
     .valid.max_access_size = 8,
     .impl.min_access_size = 1,
diff --git a/hw/misc/tz-msc.c b/hw/misc/tz-msc.c
index 7d522ac0ec..4d15a03462 100644
--- a/hw/misc/tz-msc.c
+++ b/hw/misc/tz-msc.c
@@ -209,7 +209,7 @@ static MemTxResult tz_msc_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps tz_msc_ops = {
     .read_with_attrs = tz_msc_read,
     .write_with_attrs = tz_msc_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void tz_msc_reset(DeviceState *dev)
diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
index 181a5f1e81..fd525f2535 100644
--- a/hw/misc/tz-ppc.c
+++ b/hw/misc/tz-ppc.c
@@ -182,7 +182,7 @@ static MemTxResult tz_ppc_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps tz_ppc_ops = {
     .read_with_attrs = tz_ppc_read,
     .write_with_attrs = tz_ppc_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static bool tz_ppc_dummy_accepts(void *opaque, hwaddr addr,
diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
index 57af1b4891..f56b1300d4 100644
--- a/hw/moxie/moxiesim.c
+++ b/hw/moxie/moxiesim.c
@@ -142,7 +142,7 @@ static void moxiesim_init(MachineState *machine)
     /* A single 16450 sits at offset 0x3f8.  */
     if (serial_hd(0)) {
         serial_mm_init(address_space_mem, 0x3f8, 0, env->irq[4],
-                       8000000/16, serial_hd(0), DEVICE_LITTLE_ENDIAN);
+                       8000000/16, serial_hd(0), MO_LE);
     }
 }
 
diff --git a/hw/net/allwinner_emac.c b/hw/net/allwinner_emac.c
index 84b48b1774..67b91088e3 100644
--- a/hw/net/allwinner_emac.c
+++ b/hw/net/allwinner_emac.c
@@ -421,7 +421,7 @@ static void aw_emac_set_link(NetClientState *nc)
 static const MemoryRegionOps aw_emac_mem_ops = {
     .read = aw_emac_read,
     .write = aw_emac_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 7f9cb5ab95..6566b890d1 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1518,7 +1518,7 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
 static const MemoryRegionOps gem_ops = {
     .read = gem_read,
     .write = gem_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void gem_set_link(NetClientState *nc)
diff --git a/hw/net/can/can_kvaser_pci.c b/hw/net/can/can_kvaser_pci.c
index 16861b8f9f..3a55c3046d 100644
--- a/hw/net/can/can_kvaser_pci.c
+++ b/hw/net/can/can_kvaser_pci.c
@@ -192,7 +192,7 @@ static void kvaser_pci_xilinx_io_write(void *opaque, hwaddr addr, uint64_t data,
 static const MemoryRegionOps kvaser_pci_s5920_io_ops = {
     .read = kvaser_pci_s5920_io_read,
     .write = kvaser_pci_s5920_io_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -202,7 +202,7 @@ static const MemoryRegionOps kvaser_pci_s5920_io_ops = {
 static const MemoryRegionOps kvaser_pci_sja_io_ops = {
     .read = kvaser_pci_sja_io_read,
     .write = kvaser_pci_sja_io_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .max_access_size = 1,
     },
@@ -211,7 +211,7 @@ static const MemoryRegionOps kvaser_pci_sja_io_ops = {
 static const MemoryRegionOps kvaser_pci_xilinx_io_ops = {
     .read = kvaser_pci_xilinx_io_read,
     .write = kvaser_pci_xilinx_io_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .max_access_size = 1,
     },
diff --git a/hw/net/can/can_mioe3680_pci.c b/hw/net/can/can_mioe3680_pci.c
index 965e252d9d..3143049489 100644
--- a/hw/net/can/can_mioe3680_pci.c
+++ b/hw/net/can/can_mioe3680_pci.c
@@ -137,7 +137,7 @@ static void mioe3680_pci_sja2_io_write(void *opaque, hwaddr addr, uint64_t data,
 static const MemoryRegionOps mioe3680_pci_sja1_io_ops = {
     .read = mioe3680_pci_sja1_io_read,
     .write = mioe3680_pci_sja1_io_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .max_access_size = 1,
     },
@@ -146,7 +146,7 @@ static const MemoryRegionOps mioe3680_pci_sja1_io_ops = {
 static const MemoryRegionOps mioe3680_pci_sja2_io_ops = {
     .read = mioe3680_pci_sja2_io_read,
     .write = mioe3680_pci_sja2_io_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .max_access_size = 1,
     },
diff --git a/hw/net/can/can_pcm3680_pci.c b/hw/net/can/can_pcm3680_pci.c
index 51b6540072..284350f14e 100644
--- a/hw/net/can/can_pcm3680_pci.c
+++ b/hw/net/can/can_pcm3680_pci.c
@@ -137,7 +137,7 @@ static void pcm3680i_pci_sja2_io_write(void *opaque, hwaddr addr, uint64_t data,
 static const MemoryRegionOps pcm3680i_pci_sja1_io_ops = {
     .read = pcm3680i_pci_sja1_io_read,
     .write = pcm3680i_pci_sja1_io_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .max_access_size = 1,
     },
@@ -146,7 +146,7 @@ static const MemoryRegionOps pcm3680i_pci_sja1_io_ops = {
 static const MemoryRegionOps pcm3680i_pci_sja2_io_ops = {
     .read = pcm3680i_pci_sja2_io_read,
     .write = pcm3680i_pci_sja2_io_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .max_access_size = 1,
     },
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 8ae4e08f1e..e037e81f7d 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1342,7 +1342,7 @@ e1000_mmio_read(void *opaque, hwaddr addr, unsigned size)
 static const MemoryRegionOps e1000_mmio_ops = {
     .read = e1000_mmio_read,
     .write = e1000_mmio_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -1369,7 +1369,7 @@ static void e1000_io_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps e1000_io_ops = {
     .read = e1000_io_read,
     .write = e1000_io_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static bool is_version_1(void *opaque, int version_id)
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index b69fd7d8ad..24b2d99122 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -182,7 +182,7 @@ e1000e_io_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps mmio_ops = {
     .read = e1000e_mmio_read,
     .write = e1000e_mmio_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -192,7 +192,7 @@ static const MemoryRegionOps mmio_ops = {
 static const MemoryRegionOps io_ops = {
     .read = e1000e_io_read,
     .write = e1000e_io_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index cc2dd8b1c9..477e405352 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -1603,7 +1603,7 @@ static void eepro100_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps eepro100_ops = {
     .read = eepro100_read,
     .write = eepro100_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static ssize_t nic_receive(NetClientState *nc, const uint8_t * buf, size_t size)
diff --git a/hw/net/etraxfs_eth.c b/hw/net/etraxfs_eth.c
index 4cfbf1135a..f748f5e759 100644
--- a/hw/net/etraxfs_eth.c
+++ b/hw/net/etraxfs_eth.c
@@ -569,7 +569,7 @@ static void eth_set_link(NetClientState *nc)
 static const MemoryRegionOps eth_ops = {
     .read = eth_read,
     .write = eth_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 04c78e8517..24ad88279b 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -982,7 +982,7 @@ static const MemoryRegionOps ftgmac100_ops = {
     .write = ftgmac100_write,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void ftgmac100_cleanup(NetClientState *nc)
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 0f3dd7e8e4..bf67a70a5b 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -1285,7 +1285,7 @@ static const MemoryRegionOps imx_eth_ops = {
     .write                 = imx_eth_write,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
-    .endianness            = DEVICE_LITTLE_ENDIAN,
+    .endianness            = MO_LE,
 };
 
 static void imx_eth_cleanup(NetClientState *nc)
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 498a6acfe9..244cfd8d4e 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -1308,13 +1308,13 @@ static uint64_t lan9118_16bit_mode_read(void *opaque, hwaddr offset,
 static const MemoryRegionOps lan9118_mem_ops = {
     .read = lan9118_readl,
     .write = lan9118_writel,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const MemoryRegionOps lan9118_16bit_mem_ops = {
     .read = lan9118_16bit_mode_read,
     .write = lan9118_16bit_mode_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static NetClientInfo net_lan9118_info = {
diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
index 6c17ee1ae2..0f2b24c5a2 100644
--- a/hw/net/ne2000.c
+++ b/hw/net/ne2000.c
@@ -688,7 +688,7 @@ static void ne2000_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps ne2000_ops = {
     .read = ne2000_read,
     .write = ne2000_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 /***********************************************************/
diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index 4723c30c79..2144bdecc1 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -140,7 +140,7 @@ static void pcnet_ioport_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps pcnet_io_ops = {
     .read = pcnet_ioport_read,
     .write = pcnet_ioport_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const VMStateDescription vmstate_pci_pcnet = {
@@ -163,7 +163,7 @@ static const MemoryRegionOps pcnet_mmio_ops = {
     .valid.max_access_size = 4,
     .impl.min_access_size = 1,
     .impl.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void pci_physical_memory_write(void *dma_opaque, hwaddr addr,
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 50f9e33e2f..bbd9f09f94 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -1197,7 +1197,7 @@ static uint64_t rocker_mmio_read(void *opaque, hwaddr addr, unsigned size)
 static const MemoryRegionOps rocker_mmio_ops = {
     .read = rocker_mmio_read,
     .write = rocker_mmio_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 8,
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 88a97d756d..629d627496 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -3312,7 +3312,7 @@ static const MemoryRegionOps rtl8139_io_ops = {
         .min_access_size = 1,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void rtl8139_timer(void *opaque)
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 50cd6fc140..861dca9fc2 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -760,7 +760,7 @@ static const MemoryRegionOps smc91c111_mem_ops = {
     .write = smc91c111_writefn,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static NetClientInfo net_smc91c111_info = {
diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index 5dfd43b3f2..ddeccefb30 100644
--- a/hw/net/stellaris_enet.c
+++ b/hw/net/stellaris_enet.c
@@ -459,7 +459,7 @@ static void stellaris_enet_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps stellaris_enet_ops = {
     .read = stellaris_enet_read,
     .write = stellaris_enet_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void stellaris_enet_reset(DeviceState *dev)
diff --git a/hw/net/sungem.c b/hw/net/sungem.c
index f31d41ac5b..d7b395239e 100644
--- a/hw/net/sungem.c
+++ b/hw/net/sungem.c
@@ -926,7 +926,7 @@ static uint64_t sungem_mmio_greg_read(void *opaque, hwaddr addr, unsigned size)
 static const MemoryRegionOps sungem_mmio_greg_ops = {
     .read = sungem_mmio_greg_read,
     .write = sungem_mmio_greg_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -995,7 +995,7 @@ static uint64_t sungem_mmio_txdma_read(void *opaque, hwaddr addr, unsigned size)
 static const MemoryRegionOps sungem_mmio_txdma_ops = {
     .read = sungem_mmio_txdma_read,
     .write = sungem_mmio_txdma_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -1068,7 +1068,7 @@ static uint64_t sungem_mmio_rxdma_read(void *opaque, hwaddr addr, unsigned size)
 static const MemoryRegionOps sungem_mmio_rxdma_ops = {
     .read = sungem_mmio_rxdma_read,
     .write = sungem_mmio_rxdma_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -1165,7 +1165,7 @@ static uint64_t sungem_mmio_mac_read(void *opaque, hwaddr addr, unsigned size)
 static const MemoryRegionOps sungem_mmio_mac_ops = {
     .read = sungem_mmio_mac_read,
     .write = sungem_mmio_mac_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -1231,7 +1231,7 @@ static uint64_t sungem_mmio_mif_read(void *opaque, hwaddr addr, unsigned size)
 static const MemoryRegionOps sungem_mmio_mif_ops = {
     .read = sungem_mmio_mif_read,
     .write = sungem_mmio_mif_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -1286,7 +1286,7 @@ static uint64_t sungem_mmio_pcs_read(void *opaque, hwaddr addr, unsigned size)
 static const MemoryRegionOps sungem_mmio_pcs_ops = {
     .read = sungem_mmio_pcs_read,
     .write = sungem_mmio_pcs_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index 2243b7cf7b..637f6ab62b 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -288,7 +288,7 @@ static uint64_t sunhme_seb_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps sunhme_seb_ops = {
     .read = sunhme_seb_read,
     .write = sunhme_seb_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -331,7 +331,7 @@ static uint64_t sunhme_etx_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps sunhme_etx_ops = {
     .read = sunhme_etx_read,
     .write = sunhme_etx_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -364,7 +364,7 @@ static uint64_t sunhme_erx_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps sunhme_erx_ops = {
     .read = sunhme_erx_read,
     .write = sunhme_erx_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -407,7 +407,7 @@ static uint64_t sunhme_mac_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps sunhme_mac_ops = {
     .read = sunhme_mac_read,
     .write = sunhme_mac_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -529,7 +529,7 @@ static uint64_t sunhme_mif_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps sunhme_mif_ops = {
     .read = sunhme_mif_read,
     .write = sunhme_mif_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index b07adeed9c..ce42a92b81 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2146,7 +2146,7 @@ vmxnet3_cleanup_msi(VMXNET3State *s)
 static const MemoryRegionOps b0_ops = {
     .read = vmxnet3_io_bar0_read,
     .write = vmxnet3_io_bar0_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
             .min_access_size = 4,
             .max_access_size = 4,
@@ -2156,7 +2156,7 @@ static const MemoryRegionOps b0_ops = {
 static const MemoryRegionOps b1_ops = {
     .read = vmxnet3_io_bar1_read,
     .write = vmxnet3_io_bar1_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
             .min_access_size = 4,
             .max_access_size = 4,
diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
index 2ea8d2ec72..e6c267060a 100644
--- a/hw/net/xgmac.c
+++ b/hw/net/xgmac.c
@@ -312,7 +312,7 @@ static void enet_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps enet_mem_ops = {
     .read = enet_read,
     .write = enet_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static int eth_can_rx(XgmacState *s)
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index d8716a1f73..02b0c875b6 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -665,7 +665,7 @@ static void enet_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps enet_ops = {
     .read = enet_read,
     .write = enet_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static int eth_can_rx(XilinxAXIEnet *s)
diff --git a/hw/nvram/ds1225y.c b/hw/nvram/ds1225y.c
index 934e09bf75..81599d62df 100644
--- a/hw/nvram/ds1225y.c
+++ b/hw/nvram/ds1225y.c
@@ -71,7 +71,7 @@ static const MemoryRegionOps nvram_ops = {
         .min_access_size = 1,
         .max_access_size = 1,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static int nvram_post_load(void *opaque, int version_id)
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 7dc3ac378e..4c62667afd 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -544,7 +544,7 @@ static const MemoryRegionOps fw_cfg_data_mem_ops = {
 static const MemoryRegionOps fw_cfg_comb_mem_ops = {
     .read = fw_cfg_data_read,
     .write = fw_cfg_comb_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid.accepts = fw_cfg_comb_valid,
 };
 
diff --git a/hw/nvram/nrf51_nvm.c b/hw/nvram/nrf51_nvm.c
index 4d678f994e..69b158a666 100644
--- a/hw/nvram/nrf51_nvm.c
+++ b/hw/nvram/nrf51_nvm.c
@@ -98,7 +98,7 @@ static const MemoryRegionOps ficr_ops = {
     .write = ficr_write,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN
+    .endianness = MO_LE
 };
 
 /*
@@ -191,7 +191,7 @@ static const MemoryRegionOps uicr_ops = {
     .write = uicr_write,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN
+    .endianness = MO_LE
 };
 
 
@@ -270,7 +270,7 @@ static const MemoryRegionOps io_ops = {
         .write = io_write,
         .impl.min_access_size = 4,
         .impl.max_access_size = 4,
-        .endianness = DEVICE_LITTLE_ENDIAN,
+        .endianness = MO_LE,
 };
 
 
@@ -303,7 +303,7 @@ static const MemoryRegionOps flash_ops = {
     .write = flash_write,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void nrf51_nvm_init(Object *obj)
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 71e9b0d9b5..d2bf587a30 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -78,7 +78,7 @@ static void designware_pcie_root_msi_write(void *opaque, hwaddr addr,
 
 static const MemoryRegionOps designware_pci_host_msi_ops = {
     .write = designware_pcie_root_msi_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -238,7 +238,7 @@ static void designware_pcie_root_data_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps designware_pci_host_conf_ops = {
     .read = designware_pcie_root_data_read,
     .write = designware_pcie_root_data_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4,
@@ -623,7 +623,7 @@ static void designware_pcie_host_mmio_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps designware_pci_mmio_ops = {
     .read       = designware_pcie_host_mmio_read,
     .write      = designware_pcie_host_mmio_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         /*
          * Our device would not work correctly if the guest was doing
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 135c645535..4ed3539566 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -695,7 +695,7 @@ static uint64_t rcr_read(void *opaque, hwaddr addr, unsigned len)
 static const MemoryRegionOps rcr_ops = {
     .read = rcr_read,
     .write = rcr_write,
-    .endianness = DEVICE_LITTLE_ENDIAN
+    .endianness = MO_LE
 };
 
 static void piix3_realize(PCIDevice *dev, Error **errp)
diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 85d7ba9037..aa6b78132d 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -110,7 +110,7 @@ static uint64_t raven_pci_io_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps raven_pci_io_ops = {
     .read = raven_pci_io_read,
     .write = raven_pci_io_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static uint64_t raven_intack_read(void *opaque, hwaddr addr,
@@ -188,7 +188,7 @@ static void raven_io_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps raven_io_ops = {
     .read = raven_io_read,
     .write = raven_io_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl.max_access_size = 4,
     .valid.unaligned = true,
 };
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 485e2a02af..0a31a500cc 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -289,12 +289,12 @@ static void tseg_blackhole_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps tseg_blackhole_ops = {
     .read = tseg_blackhole_read,
     .write = tseg_blackhole_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 /* PCIe MMCFG */
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index fae20ee97c..7f9520bcc4 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -370,7 +370,7 @@ static void sabre_reset(DeviceState *d)
 static const MemoryRegionOps pci_config_ops = {
     .read = sabre_pci_config_read,
     .write = sabre_pci_config_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void sabre_realize(DeviceState *dev, Error **errp)
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 75bc506965..c3c2c85192 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -109,7 +109,7 @@ static uint64_t unin_data_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps unin_data_ops = {
     .read = unin_data_read,
     .write = unin_data_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void pci_unin_init_irqs(UNINHostState *s)
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index df7212237d..cd4d1c623d 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -243,7 +243,7 @@ static uint64_t pci_vpb_reg_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps pci_vpb_reg_ops = {
     .read = pci_vpb_reg_read,
     .write = pci_vpb_reg_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -309,7 +309,7 @@ static uint64_t pci_vpb_config_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps pci_vpb_config_ops = {
     .read = pci_vpb_config_read,
     .write = pci_vpb_config_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static int pci_vpb_map_irq(PCIDevice *d, int irq_num)
diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 29187898f2..bcec8aa74b 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -196,7 +196,7 @@ static void msix_table_mmio_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps msix_table_mmio_ops = {
     .read = msix_table_mmio_read,
     .write = msix_table_mmio_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -224,7 +224,7 @@ static void msix_pba_mmio_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps msix_pba_mmio_ops = {
     .read = msix_pba_mmio_read,
     .write = msix_pba_mmio_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index c5f9244934..ed407d096d 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -190,7 +190,7 @@ static uint64_t pci_host_data_read(void *opaque,
 const MemoryRegionOps pci_host_conf_le_ops = {
     .read = pci_host_config_read,
     .write = pci_host_config_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 const MemoryRegionOps pci_host_conf_be_ops = {
@@ -202,7 +202,7 @@ const MemoryRegionOps pci_host_conf_be_ops = {
 const MemoryRegionOps pci_host_data_le_ops = {
     .read = pci_host_data_read,
     .write = pci_host_data_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 const MemoryRegionOps pci_host_data_be_ops = {
diff --git a/hw/pci/pcie_host.c b/hw/pci/pcie_host.c
index 3534006f99..da10d259c1 100644
--- a/hw/pci/pcie_host.c
+++ b/hw/pci/pcie_host.c
@@ -71,7 +71,7 @@ static uint64_t pcie_mmcfg_data_read(void *opaque,
 static const MemoryRegionOps pcie_mmcfg_ops = {
     .read = pcie_mmcfg_data_read,
     .write = pcie_mmcfg_data_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void pcie_host_init(Object *obj)
diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index 7f0aa28e44..cb38d643f2 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -478,7 +478,7 @@ static void shpc_mmio_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps shpc_mmio_ops = {
     .read = shpc_mmio_read,
     .write = shpc_mmio_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         /* SHPC ECN requires dword accesses, but the original 1.0 spec doesn't.
          * It's easier to suppport all sizes than worry about it. */
diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index 2ee2d4f4fc..c5b9c32f81 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -393,7 +393,7 @@ static uint64_t ppc440_pcix_reg_read4(void *opaque, hwaddr addr,
 static const MemoryRegionOps pci_reg_ops = {
     .read = ppc440_pcix_reg_read4,
     .write = ppc440_pcix_reg_write4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void ppc440_pcix_reset(DeviceState *dev)
@@ -464,7 +464,7 @@ static uint64_t pci_host_data_read(void *opaque,
 const MemoryRegionOps ppc440_pcix_host_data_ops = {
     .read = pci_host_data_read,
     .write = pci_host_data_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void ppc440_pcix_realize(DeviceState *dev, Error **errp)
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index 3ea47df71f..860f1b7341 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -229,7 +229,7 @@ static uint64_t ppc4xx_pci_reg_read4(void *opaque, hwaddr offset,
 static const MemoryRegionOps pci_reg_ops = {
     .read = ppc4xx_pci_reg_read4,
     .write = ppc4xx_pci_reg_write4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void ppc4xx_pci_reset(void *opaque)
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index deb0b0c80c..f71a06b3af 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -757,7 +757,7 @@ static const MemoryRegionOps spapr_msi_ops = {
     /* There is no .read as the read result is undefined by PCI spec */
     .read = NULL,
     .write = spapr_msi_write,
-    .endianness = DEVICE_LITTLE_ENDIAN
+    .endianness = MO_LE
 };
 
 /*
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 68625522d8..18ab4b8c87 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -243,7 +243,7 @@ static void virtex_init(MachineState *machine)
     }
 
     serial_mm_init(address_space_mem, UART16550_BASEADDR, 2, irq[UART16550_IRQ],
-                   115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
+                   115200, serial_hd(0), MO_LE);
 
     /* 2 timers at irq 2 @ 62 Mhz.  */
     dev = qdev_create(NULL, "xlnx.xps-timer");
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 3e36e13013..c2df742180 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -437,7 +437,7 @@ static void pvrdma_regs_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps regs_ops = {
     .read = pvrdma_regs_read,
     .write = pvrdma_regs_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = sizeof(uint32_t),
         .max_access_size = sizeof(uint32_t),
@@ -505,7 +505,7 @@ static void pvrdma_uar_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps uar_ops = {
     .read = pvrdma_uar_read,
     .write = pvrdma_uar_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = sizeof(uint32_t),
         .max_access_size = sizeof(uint32_t),
diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
index e5a8f75cee..43c26fc96e 100644
--- a/hw/riscv/sifive_clint.c
+++ b/hw/riscv/sifive_clint.c
@@ -177,7 +177,7 @@ static void sifive_clint_write(void *opaque, hwaddr addr, uint64_t value,
 static const MemoryRegionOps sifive_clint_ops = {
     .read = sifive_clint_read,
     .write = sifive_clint_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/riscv/sifive_gpio.c b/hw/riscv/sifive_gpio.c
index 5c7c596e6b..13d41aa0ba 100644
--- a/hw/riscv/sifive_gpio.c
+++ b/hw/riscv/sifive_gpio.c
@@ -274,7 +274,7 @@ static void sifive_gpio_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps gpio_ops = {
     .read =  sifive_gpio_read,
     .write = sifive_gpio_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
 };
diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index 64a1a10380..a64b20c265 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -355,7 +355,7 @@ err:
 static const MemoryRegionOps sifive_plic_ops = {
     .read = sifive_plic_read,
     .write = sifive_plic_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 9bced28486..8e767c8faa 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -502,7 +502,7 @@ static void riscv_virt_board_init(MachineState *machine)
 
     serial_mm_init(system_memory, memmap[VIRT_UART0].base,
         0, qdev_get_gpio_in(DEVICE(s->plic), UART0_IRQ), 399193,
-        serial_hd(0), DEVICE_LITTLE_ENDIAN);
+        serial_hd(0), MO_LE);
 
     g_free(plic_hart_config);
 }
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 963a41c7f5..3228ff28bd 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -690,7 +690,7 @@ static uint64_t s390_msi_ctrl_read(void *opaque, hwaddr addr, unsigned size)
 static const MemoryRegionOps s390_msi_ctrl_ops = {
     .write = s390_msi_ctrl_write,
     .read = s390_msi_ctrl_read,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index d5a1f9e017..889ab35cbe 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -293,7 +293,7 @@ static void esp_pci_dma_memory_write(void *opaque, uint8_t *buf, int len)
 static const MemoryRegionOps esp_pci_io_ops = {
     .read = esp_pci_io_read,
     .write = esp_pci_io_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 4,
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index ec53b14f7f..5c3977c926 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2105,7 +2105,7 @@ static uint64_t lsi_mmio_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps lsi_mmio_ops = {
     .read = lsi_mmio_read,
     .write = lsi_mmio_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -2129,7 +2129,7 @@ static uint64_t lsi_ram_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps lsi_ram_ops = {
     .read = lsi_ram_read,
     .write = lsi_ram_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static uint64_t lsi_io_read(void *opaque, hwaddr addr,
@@ -2149,7 +2149,7 @@ static void lsi_io_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps lsi_io_ops = {
     .read = lsi_io_read,
     .write = lsi_io_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index de9bd20887..752da4f6a5 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2154,7 +2154,7 @@ static void megasas_mmio_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps megasas_mmio_ops = {
     .read = megasas_mmio_read,
     .write = megasas_mmio_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 8,
         .max_access_size = 8,
@@ -2176,7 +2176,7 @@ static void megasas_port_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps megasas_port_ops = {
     .read = megasas_port_read,
     .write = megasas_port_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -2198,7 +2198,7 @@ static void megasas_queue_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps megasas_queue_ops = {
     .read = megasas_queue_read,
     .write = megasas_queue_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 8,
         .max_access_size = 8,
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index b8a4b37cf3..2bdc49d5f7 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -1088,7 +1088,7 @@ static void mptsas_mmio_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps mptsas_mmio_ops = {
     .read = mptsas_mmio_read,
     .write = mptsas_mmio_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -1098,7 +1098,7 @@ static const MemoryRegionOps mptsas_mmio_ops = {
 static const MemoryRegionOps mptsas_port_ops = {
     .read = mptsas_mmio_read,
     .write = mptsas_mmio_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -1123,7 +1123,7 @@ static void mptsas_diag_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps mptsas_diag_ops = {
     .read = mptsas_diag_read,
     .write = mptsas_diag_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 452a3b63b2..72443f0c66 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1089,7 +1089,7 @@ pvscsi_cleanup_msi(PVSCSIState *s)
 static const MemoryRegionOps pvscsi_ops = {
         .read = pvscsi_io_read,
         .write = pvscsi_io_write,
-        .endianness = DEVICE_LITTLE_ENDIAN,
+        .endianness = MO_LE,
         .impl = {
                 .min_access_size = 4,
                 .max_access_size = 4,
diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index f19d8764e8..907fb7c003 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -451,7 +451,7 @@ static void pl181_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps pl181_ops = {
     .read = pl181_read,
     .write = pl181_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void pl181_reset(DeviceState *d)
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index e08ec3e398..54b604121f 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1288,7 +1288,7 @@ static const MemoryRegionOps sdhci_mmio_ops = {
         .max_access_size = 4,
         .unaligned = false
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
@@ -1743,7 +1743,7 @@ static const MemoryRegionOps usdhc_mmio_ops = {
         .max_access_size = 4,
         .unaligned = false
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void imx_usdhc_init(Object *obj)
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 9f3cff5fb6..833ea7b85b 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -401,7 +401,7 @@ static void aspeed_smc_flash_default_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps aspeed_smc_flash_default_ops = {
     .read = aspeed_smc_flash_default_read,
     .write = aspeed_smc_flash_default_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4,
@@ -709,7 +709,7 @@ static void aspeed_smc_flash_write(void *opaque, hwaddr addr, uint64_t data,
 static const MemoryRegionOps aspeed_smc_flash_ops = {
     .read = aspeed_smc_flash_read,
     .write = aspeed_smc_flash_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4,
@@ -820,7 +820,7 @@ static void aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
 static const MemoryRegionOps aspeed_smc_ops = {
     .read = aspeed_smc_read,
     .write = aspeed_smc_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid.unaligned = true,
 };
 
diff --git a/hw/ssi/mss-spi.c b/hw/ssi/mss-spi.c
index 914f90f3ad..3cef81565b 100644
--- a/hw/ssi/mss-spi.c
+++ b/hw/ssi/mss-spi.c
@@ -361,7 +361,7 @@ static void spi_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps spi_ops = {
     .read = spi_read,
     .write = spi_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4
diff --git a/hw/ssi/pl022.c b/hw/ssi/pl022.c
index 1501af2850..54a3d13880 100644
--- a/hw/ssi/pl022.c
+++ b/hw/ssi/pl022.c
@@ -228,7 +228,7 @@ static void pl022_reset(DeviceState *dev)
 static const MemoryRegionOps pl022_ops = {
     .read = pl022_read,
     .write = pl022_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static int pl022_post_load(void *opaque, int version_id)
diff --git a/hw/ssi/stm32f2xx_spi.c b/hw/ssi/stm32f2xx_spi.c
index dbb109b2dc..b68d249b5b 100644
--- a/hw/ssi/stm32f2xx_spi.c
+++ b/hw/ssi/stm32f2xx_spi.c
@@ -167,7 +167,7 @@ static void stm32f2xx_spi_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps stm32f2xx_spi_ops = {
     .read = stm32f2xx_spi_read,
     .write = stm32f2xx_spi_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const VMStateDescription vmstate_stm32f2xx_spi = {
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index e622e38f6d..18c1446118 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -1031,7 +1031,7 @@ no_reg_update:
 static const MemoryRegionOps spips_ops = {
     .read = xilinx_spips_read,
     .write = xilinx_spips_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void xilinx_qspips_invalidate_mmio_ptr(XilinxQSPIPS *q)
@@ -1122,13 +1122,13 @@ static void xlnx_zynqmp_qspips_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps qspips_ops = {
     .read = xilinx_spips_read,
     .write = xilinx_qspips_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const MemoryRegionOps xlnx_zynqmp_qspips_ops = {
     .read = xlnx_zynqmp_qspips_read,
     .write = xlnx_zynqmp_qspips_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 #define LQSPI_CACHE_SIZE 1024
@@ -1240,7 +1240,7 @@ static MemTxResult lqspi_write(void *opaque, hwaddr offset, uint64_t value,
 static const MemoryRegionOps lqspi_ops = {
     .read_with_attrs = lqspi_read,
     .write_with_attrs = lqspi_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index ffdc78f383..4745e79fe4 100644
--- a/hw/timer/a9gtimer.c
+++ b/hw/timer/a9gtimer.c
@@ -258,7 +258,7 @@ static const MemoryRegionOps a9_gtimer_this_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const MemoryRegionOps a9_gtimer_ops = {
@@ -268,7 +268,7 @@ static const MemoryRegionOps a9_gtimer_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void a9_gtimer_reset(DeviceState *dev)
diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index bf6295add1..3c13f86a6d 100644
--- a/hw/timer/arm_mptimer.c
+++ b/hw/timer/arm_mptimer.c
@@ -194,7 +194,7 @@ static const MemoryRegionOps arm_thistimer_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const MemoryRegionOps timerblock_ops = {
@@ -204,7 +204,7 @@ static const MemoryRegionOps timerblock_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void timerblock_reset(TimerBlock *tb)
diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index f95c897d05..ac5b1c0935 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -267,7 +267,7 @@ static void sp804_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps sp804_ops = {
     .read = sp804_read,
     .write = sp804_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const VMStateDescription vmstate_sp804 = {
@@ -348,7 +348,7 @@ static void icp_pit_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps icp_pit_ops = {
     .read = icp_pit_read,
     .write = icp_pit_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void icp_pit_init(Object *obj)
diff --git a/hw/timer/armv7m_systick.c b/hw/timer/armv7m_systick.c
index b8003e2962..4565d3c144 100644
--- a/hw/timer/armv7m_systick.c
+++ b/hw/timer/armv7m_systick.c
@@ -193,7 +193,7 @@ static MemTxResult systick_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps systick_ops = {
     .read_with_attrs = systick_read,
     .write_with_attrs = systick_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
 };
diff --git a/hw/timer/aspeed_rtc.c b/hw/timer/aspeed_rtc.c
index e3bd196dc0..803b4ab791 100644
--- a/hw/timer/aspeed_rtc.c
+++ b/hw/timer/aspeed_rtc.c
@@ -131,7 +131,7 @@ static void aspeed_rtc_reset(DeviceState *d)
 static const MemoryRegionOps aspeed_rtc_ops = {
     .read = aspeed_rtc_read,
     .write = aspeed_rtc_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const VMStateDescription vmstate_aspeed_rtc = {
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index ed81d5c44c..408eb439f3 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -450,7 +450,7 @@ static void aspeed_timer_write(void *opaque, hwaddr offset, uint64_t value,
 static const MemoryRegionOps aspeed_timer_ops = {
     .read = aspeed_timer_read,
     .write = aspeed_timer_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
     .valid.unaligned = false,
diff --git a/hw/timer/cadence_ttc.c b/hw/timer/cadence_ttc.c
index 6155d0055f..0752c52da9 100644
--- a/hw/timer/cadence_ttc.c
+++ b/hw/timer/cadence_ttc.c
@@ -391,7 +391,7 @@ static void cadence_ttc_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps cadence_ttc_ops = {
     .read = cadence_ttc_read,
     .write = cadence_ttc_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void cadence_timer_reset(CadenceTimerState *s)
diff --git a/hw/timer/cmsdk-apb-dualtimer.c b/hw/timer/cmsdk-apb-dualtimer.c
index 5e2352dd32..dbe1e847ca 100644
--- a/hw/timer/cmsdk-apb-dualtimer.c
+++ b/hw/timer/cmsdk-apb-dualtimer.c
@@ -376,7 +376,7 @@ static void cmsdk_apb_dualtimer_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps cmsdk_apb_dualtimer_ops = {
     .read = cmsdk_apb_dualtimer_read,
     .write = cmsdk_apb_dualtimer_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     /* byte/halfword accesses are just zero-padded on reads and writes */
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
diff --git a/hw/timer/cmsdk-apb-timer.c b/hw/timer/cmsdk-apb-timer.c
index c83e26566a..c02f4b8f0c 100644
--- a/hw/timer/cmsdk-apb-timer.c
+++ b/hw/timer/cmsdk-apb-timer.c
@@ -171,7 +171,7 @@ static void cmsdk_apb_timer_write(void *opaque, hwaddr offset, uint64_t value,
 static const MemoryRegionOps cmsdk_apb_timer_ops = {
     .read = cmsdk_apb_timer_read,
     .write = cmsdk_apb_timer_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void cmsdk_apb_timer_tick(void *opaque)
diff --git a/hw/timer/etraxfs_timer.c b/hw/timer/etraxfs_timer.c
index d62025b879..582a000241 100644
--- a/hw/timer/etraxfs_timer.c
+++ b/hw/timer/etraxfs_timer.c
@@ -300,7 +300,7 @@ timer_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps timer_ops = {
     .read = timer_read,
     .write = timer_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 380abeb709..8d628af08c 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -676,7 +676,7 @@ static const MemoryRegionOps hpet_ram_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void hpet_reset(DeviceState *d)
diff --git a/hw/timer/i8254.c b/hw/timer/i8254.c
index a4be7330ef..5dd47f49b1 100644
--- a/hw/timer/i8254.c
+++ b/hw/timer/i8254.c
@@ -315,7 +315,7 @@ static const MemoryRegionOps pit_ioport_ops = {
         .min_access_size = 1,
         .max_access_size = 1,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void pit_post_load(PITCommonState *s)
diff --git a/hw/timer/imx_epit.c b/hw/timer/imx_epit.c
index 7e605d29c7..2e9861fafa 100644
--- a/hw/timer/imx_epit.c
+++ b/hw/timer/imx_epit.c
@@ -284,7 +284,7 @@ static void imx_epit_cmp(void *opaque)
 static const MemoryRegionOps imx_epit_ops = {
     .read = imx_epit_read,
     .write = imx_epit_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const VMStateDescription vmstate_imx_timer_epit = {
diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index 27bacdb758..d2e9f90cc1 100644
--- a/hw/timer/imx_gpt.c
+++ b/hw/timer/imx_gpt.c
@@ -476,7 +476,7 @@ static void imx_gpt_timeout(void *opaque)
 static const MemoryRegionOps imx_gpt_ops = {
     .read = imx_gpt_read,
     .write = imx_gpt_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 
diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
index a9fc2f981a..191b19494b 100644
--- a/hw/timer/m48t59.c
+++ b/hw/timer/m48t59.c
@@ -562,7 +562,7 @@ const MemoryRegionOps m48t59_io_ops = {
         .min_access_size = 1,
         .max_access_size = 1,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 /* Initialisation routine */
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 6cb378751b..8fe25acd25 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -919,7 +919,7 @@ static const MemoryRegionOps cmos_ops = {
         .min_access_size = 1,
         .max_access_size = 1,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void rtc_get_date(Object *obj, struct tm *current_tm, Error **errp)
diff --git a/hw/timer/mss-timer.c b/hw/timer/mss-timer.c
index b9edb39837..7903087f64 100644
--- a/hw/timer/mss-timer.c
+++ b/hw/timer/mss-timer.c
@@ -200,7 +200,7 @@ timer_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps timer_ops = {
     .read = timer_read,
     .write = timer_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4
diff --git a/hw/timer/nrf51_timer.c b/hw/timer/nrf51_timer.c
index e04046eb15..0c6c7f397a 100644
--- a/hw/timer/nrf51_timer.c
+++ b/hw/timer/nrf51_timer.c
@@ -302,7 +302,7 @@ static void nrf51_timer_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps rng_ops = {
     .read =  nrf51_timer_read,
     .write = nrf51_timer_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
 };
diff --git a/hw/timer/pl031.c b/hw/timer/pl031.c
index 7ac2a0ca37..9101fcb8c9 100644
--- a/hw/timer/pl031.c
+++ b/hw/timer/pl031.c
@@ -178,7 +178,7 @@ static void pl031_write(void * opaque, hwaddr offset,
 static const MemoryRegionOps pl031_ops = {
     .read = pl031_read,
     .write = pl031_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void pl031_init(Object *obj)
diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index 88ae286b14..3fccab99d3 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -268,7 +268,7 @@ static void stm32f2xx_timer_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps stm32f2xx_timer_ops = {
     .read = stm32f2xx_timer_read,
     .write = stm32f2xx_timer_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const VMStateDescription vmstate_stm32f2xx_timer = {
diff --git a/hw/timer/xlnx-zynqmp-rtc.c b/hw/timer/xlnx-zynqmp-rtc.c
index 5692db98c2..e153fd421a 100644
--- a/hw/timer/xlnx-zynqmp-rtc.c
+++ b/hw/timer/xlnx-zynqmp-rtc.c
@@ -175,7 +175,7 @@ static void rtc_reset(DeviceState *dev)
 static const MemoryRegionOps rtc_ops = {
     .read = register_read_memory,
     .write = register_write_memory,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index faae733120..ae7fe038bd 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -178,7 +178,7 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps tpm_crb_memory_ops = {
     .read = tpm_crb_mmio_read,
     .write = tpm_crb_mmio_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4,
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 7aaf9b946d..2663e166d8 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -849,7 +849,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps tpm_tis_memory_ops = {
     .read = tpm_tis_mmio_read,
     .write = tpm_tis_mmio_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4,
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index 020211fd10..d6a0f0bacb 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -225,7 +225,7 @@ static const MemoryRegionOps fusbh200_ehci_mmio_ops = {
     .write = fusbh200_ehci_write,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void fusbh200_ehci_init(Object *obj)
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 9ca7b87a80..1ccc214d63 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -2361,7 +2361,7 @@ static const MemoryRegionOps ehci_mmio_caps_ops = {
     .valid.max_access_size = 4,
     .impl.min_access_size = 1,
     .impl.max_access_size = 1,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const MemoryRegionOps ehci_mmio_opreg_ops = {
@@ -2369,7 +2369,7 @@ static const MemoryRegionOps ehci_mmio_opreg_ops = {
     .write = ehci_opreg_write,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const MemoryRegionOps ehci_mmio_port_ops = {
@@ -2377,7 +2377,7 @@ static const MemoryRegionOps ehci_mmio_port_ops = {
     .write = ehci_port_write,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static USBPortOps ehci_port_ops = {
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 145ee21fd6..f7fd3b8d19 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -1776,7 +1776,7 @@ static void ohci_async_cancel_device(OHCIState *ohci, USBDevice *dev)
 static const MemoryRegionOps ohci_mem_ops = {
     .read = ohci_mem_read,
     .write = ohci_mem_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static USBPortOps ohci_port_ops = {
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 23507ad3b5..72bce48726 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -1197,7 +1197,7 @@ static const MemoryRegionOps uhci_ioport_ops = {
     .valid.max_access_size = 4,
     .impl.min_access_size = 2,
     .impl.max_access_size = 2,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static USBPortOps uhci_port_ops = {
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index f698224c8a..a5e91a226d 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3162,7 +3162,7 @@ static const MemoryRegionOps xhci_cap_ops = {
     .valid.max_access_size = 4,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const MemoryRegionOps xhci_oper_ops = {
@@ -3170,7 +3170,7 @@ static const MemoryRegionOps xhci_oper_ops = {
     .write = xhci_oper_write,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const MemoryRegionOps xhci_port_ops = {
@@ -3178,7 +3178,7 @@ static const MemoryRegionOps xhci_port_ops = {
     .write = xhci_port_write,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const MemoryRegionOps xhci_runtime_ops = {
@@ -3186,7 +3186,7 @@ static const MemoryRegionOps xhci_runtime_ops = {
     .write = xhci_runtime_write,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const MemoryRegionOps xhci_doorbell_ops = {
@@ -3194,7 +3194,7 @@ static const MemoryRegionOps xhci_doorbell_ops = {
     .write = xhci_doorbell_write,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void xhci_attach(USBPort *usbport)
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 3e03c495d8..ec9b905d5d 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -276,7 +276,7 @@ uint64_t vfio_region_read(void *opaque,
 const MemoryRegionOps vfio_region_ops = {
     .read = vfio_region_read,
     .write = vfio_region_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 8,
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 136f3a9ad6..82b7a9d6f8 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -152,7 +152,7 @@ static void vfio_generic_window_quirk_address_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps vfio_generic_window_address_quirk = {
     .read = vfio_generic_window_quirk_address_read,
     .write = vfio_generic_window_quirk_address_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static uint64_t vfio_generic_window_quirk_data_read(void *opaque,
@@ -195,7 +195,7 @@ static void vfio_generic_window_quirk_data_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps vfio_generic_window_data_quirk = {
     .read = vfio_generic_window_quirk_data_read,
     .write = vfio_generic_window_quirk_data_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 /*
@@ -245,7 +245,7 @@ static void vfio_generic_quirk_mirror_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps vfio_generic_mirror_quirk = {
     .read = vfio_generic_quirk_mirror_read,
     .write = vfio_generic_quirk_mirror_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 /* Is range1 fully contained within range2?  */
@@ -280,7 +280,7 @@ static uint64_t vfio_ati_3c3_quirk_read(void *opaque,
 
 static const MemoryRegionOps vfio_ati_3c3_quirk = {
     .read = vfio_ati_3c3_quirk_read,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static VFIOQuirk *vfio_quirk_alloc(int nr_mem)
@@ -607,7 +607,7 @@ static void vfio_nvidia_3d4_quirk_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps vfio_nvidia_3d4_quirk = {
     .read = vfio_nvidia_3d4_quirk_read,
     .write = vfio_nvidia_3d4_quirk_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static uint64_t vfio_nvidia_3d0_quirk_read(void *opaque,
@@ -665,7 +665,7 @@ static void vfio_nvidia_3d0_quirk_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps vfio_nvidia_3d0_quirk = {
     .read = vfio_nvidia_3d0_quirk_read,
     .write = vfio_nvidia_3d0_quirk_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void vfio_vga_probe_nvidia_3d0_quirk(VFIOPCIDevice *vdev)
@@ -754,7 +754,7 @@ static void vfio_nvidia_bar5_quirk_master_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps vfio_nvidia_bar5_quirk_master = {
     .read = vfio_nvidia_bar5_quirk_master_read,
     .write = vfio_nvidia_bar5_quirk_master_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static uint64_t vfio_nvidia_bar5_quirk_enable_read(void *opaque,
@@ -781,7 +781,7 @@ static void vfio_nvidia_bar5_quirk_enable_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps vfio_nvidia_bar5_quirk_enable = {
     .read = vfio_nvidia_bar5_quirk_enable_read,
     .write = vfio_nvidia_bar5_quirk_enable_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void vfio_probe_nvidia_bar5_quirk(VFIOPCIDevice *vdev, int nr)
@@ -931,7 +931,7 @@ static void vfio_nvidia_quirk_mirror_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps vfio_nvidia_mirror_quirk = {
     .read = vfio_generic_quirk_mirror_read,
     .write = vfio_nvidia_quirk_mirror_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void vfio_nvidia_bar0_quirk_reset(VFIOPCIDevice *vdev, VFIOQuirk *quirk)
@@ -1093,7 +1093,7 @@ static const MemoryRegionOps vfio_rtl_address_quirk = {
         .max_access_size = 4,
         .unaligned = false,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static uint64_t vfio_rtl8168_quirk_data_read(void *opaque,
@@ -1133,7 +1133,7 @@ static const MemoryRegionOps vfio_rtl_data_quirk = {
         .max_access_size = 4,
         .unaligned = false,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void vfio_probe_rtl8168_bar2_quirk(VFIOPCIDevice *vdev, int nr)
@@ -1529,7 +1529,7 @@ static void vfio_igd_quirk_data_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps vfio_igd_data_quirk = {
     .read = vfio_igd_quirk_data_read,
     .write = vfio_igd_quirk_data_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static uint64_t vfio_igd_quirk_index_read(void *opaque,
@@ -1557,7 +1557,7 @@ static void vfio_igd_quirk_index_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps vfio_igd_index_quirk = {
     .read = vfio_igd_quirk_index_read,
     .write = vfio_igd_quirk_index_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index dc3479c374..7010f0575d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -884,7 +884,7 @@ static void vfio_rom_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps vfio_rom_ops = {
     .read = vfio_rom_read,
     .write = vfio_rom_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
@@ -1032,7 +1032,7 @@ uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size)
 static const MemoryRegionOps vfio_vga_ops = {
     .read = vfio_vga_read,
     .write = vfio_vga_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 /*
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index ffb03728f9..4450c24d57 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -486,7 +486,7 @@ static const MemoryRegionOps virtio_pci_config_ops = {
         .min_access_size = 1,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static MemoryRegion *virtio_address_space_lookup(VirtIOPCIProxy *proxy,
@@ -1389,7 +1389,7 @@ static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy)
             .min_access_size = 1,
             .max_access_size = 4,
         },
-        .endianness = DEVICE_LITTLE_ENDIAN,
+        .endianness = MO_LE,
     };
     static const MemoryRegionOps isr_ops = {
         .read = virtio_pci_isr_read,
@@ -1398,7 +1398,7 @@ static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy)
             .min_access_size = 1,
             .max_access_size = 4,
         },
-        .endianness = DEVICE_LITTLE_ENDIAN,
+        .endianness = MO_LE,
     };
     static const MemoryRegionOps device_ops = {
         .read = virtio_pci_device_read,
@@ -1407,7 +1407,7 @@ static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy)
             .min_access_size = 1,
             .max_access_size = 4,
         },
-        .endianness = DEVICE_LITTLE_ENDIAN,
+        .endianness = MO_LE,
     };
     static const MemoryRegionOps notify_ops = {
         .read = virtio_pci_notify_read,
@@ -1416,7 +1416,7 @@ static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy)
             .min_access_size = 1,
             .max_access_size = 4,
         },
-        .endianness = DEVICE_LITTLE_ENDIAN,
+        .endianness = MO_LE,
     };
     static const MemoryRegionOps notify_pio_ops = {
         .read = virtio_pci_notify_read,
@@ -1425,7 +1425,7 @@ static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy)
             .min_access_size = 1,
             .max_access_size = 4,
         },
-        .endianness = DEVICE_LITTLE_ENDIAN,
+        .endianness = MO_LE,
     };
 
 
diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-watchdog.c
index 6bf43f943f..29ac258f3f 100644
--- a/hw/watchdog/cmsdk-apb-watchdog.c
+++ b/hw/watchdog/cmsdk-apb-watchdog.c
@@ -264,7 +264,7 @@ bad_offset:
 static const MemoryRegionOps cmsdk_apb_watchdog_ops = {
     .read = cmsdk_apb_watchdog_read,
     .write = cmsdk_apb_watchdog_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     /* byte/halfword accesses are just zero-padded on reads and writes */
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 9b93213417..d761509529 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -204,7 +204,7 @@ static const VMStateDescription vmstate_aspeed_wdt = {
 static const MemoryRegionOps aspeed_wdt_ops = {
     .read = aspeed_wdt_read,
     .write = aspeed_wdt_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
     .valid.unaligned = false,
diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
index 370cf92e85..3ea9a74a5e 100644
--- a/hw/watchdog/wdt_i6300esb.c
+++ b/hw/watchdog/wdt_i6300esb.c
@@ -398,7 +398,7 @@ static const MemoryRegionOps i6300esb_ops = {
     .write = i6300esb_mem_writefn,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
 };
 
 static const VMStateDescription vmstate_i6300esb = {
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index c388453ed7..f61f269465 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -29,7 +29,7 @@ enum device_endian {
 #if defined(HOST_WORDS_BIGENDIAN)
 #define DEVICE_HOST_ENDIAN DEVICE_BIG_ENDIAN
 #else
-#define DEVICE_HOST_ENDIAN DEVICE_LITTLE_ENDIAN
+#define DEVICE_HOST_ENDIAN MO_LE
 #endif
 
 /* address in the RAM (different from a physical address) */
diff --git a/ioport.c b/ioport.c
index c8a4128d33..e5713e83c8 100644
--- a/ioport.c
+++ b/ioport.c
@@ -213,7 +213,7 @@ static void portio_write(void *opaque, hwaddr addr, uint64_t data,
 static const MemoryRegionOps portio_ops = {
     .read = portio_read,
     .write = portio_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = MO_LE,
     .valid.unaligned = true,
     .impl.unaligned = true,
 };
diff --git a/memory.c b/memory.c
index 7578ad1dfd..01703988be 100644
--- a/memory.c
+++ b/memory.c
@@ -346,7 +346,7 @@ static void flatview_simplify(FlatView *view)
 static bool memory_region_big_endian(MemoryRegion *mr)
 {
 #ifdef TARGET_WORDS_BIGENDIAN
-    return mr->ops->endianness != DEVICE_LITTLE_ENDIAN;
+    return mr->ops->endianness != MO_LE;
 #else
     return mr->ops->endianness == DEVICE_BIG_ENDIAN;
 #endif
@@ -3275,13 +3275,13 @@ type_init(memory_register_types)
 MemOp devend_memop(enum device_endian end)
 {
     static MemOp conv[] = {
-        [DEVICE_LITTLE_ENDIAN] = MO_LE,
+        [MO_LE] = MO_LE,
         [DEVICE_BIG_ENDIAN] = MO_BE,
         [MO_TE] = MO_TE,
         [DEVICE_HOST_ENDIAN] = 0,
     };
     switch (end) {
-    case DEVICE_LITTLE_ENDIAN:
+    case MO_LE:
     case DEVICE_BIG_ENDIAN:
         return conv[end];
     default:
diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
index b321da28de..8d723cffc2 100644
--- a/memory_ldst.inc.c
+++ b/memory_ldst.inc.c
@@ -44,7 +44,7 @@ static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
         switch (endian) {
-        case DEVICE_LITTLE_ENDIAN:
+        case MO_LE:
             val = ldl_le_p(ptr);
             break;
         case DEVICE_BIG_ENDIAN:
@@ -77,7 +77,7 @@ uint32_t glue(address_space_ldl_le, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
     return glue(address_space_ldl_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                    DEVICE_LITTLE_ENDIAN);
+                                                    MO_LE);
 }
 
 uint32_t glue(address_space_ldl_be, SUFFIX)(ARG1_DECL,
@@ -112,7 +112,7 @@ static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
         switch (endian) {
-        case DEVICE_LITTLE_ENDIAN:
+        case MO_LE:
             val = ldq_le_p(ptr);
             break;
         case DEVICE_BIG_ENDIAN:
@@ -145,7 +145,7 @@ uint64_t glue(address_space_ldq_le, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
     return glue(address_space_ldq_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                    DEVICE_LITTLE_ENDIAN);
+                                                    MO_LE);
 }
 
 uint64_t glue(address_space_ldq_be, SUFFIX)(ARG1_DECL,
@@ -214,7 +214,7 @@ static inline uint32_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
         switch (endian) {
-        case DEVICE_LITTLE_ENDIAN:
+        case MO_LE:
             val = lduw_le_p(ptr);
             break;
         case DEVICE_BIG_ENDIAN:
@@ -247,7 +247,7 @@ uint32_t glue(address_space_lduw_le, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
     return glue(address_space_lduw_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                     DEVICE_LITTLE_ENDIAN);
+                                                     MO_LE);
 }
 
 uint32_t glue(address_space_lduw_be, SUFFIX)(ARG1_DECL,
@@ -318,7 +318,7 @@ static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
         switch (endian) {
-        case DEVICE_LITTLE_ENDIAN:
+        case MO_LE:
             stl_le_p(ptr, val);
             break;
         case DEVICE_BIG_ENDIAN:
@@ -351,7 +351,7 @@ void glue(address_space_stl_le, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
 {
     glue(address_space_stl_internal, SUFFIX)(ARG1, addr, val, attrs,
-                                             result, DEVICE_LITTLE_ENDIAN);
+                                             result, MO_LE);
 }
 
 void glue(address_space_stl_be, SUFFIX)(ARG1_DECL,
@@ -414,7 +414,7 @@ static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
         switch (endian) {
-        case DEVICE_LITTLE_ENDIAN:
+        case MO_LE:
             stw_le_p(ptr, val);
             break;
         case DEVICE_BIG_ENDIAN:
@@ -447,7 +447,7 @@ void glue(address_space_stw_le, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
 {
     glue(address_space_stw_internal, SUFFIX)(ARG1, addr, val, attrs, result,
-                                             DEVICE_LITTLE_ENDIAN);
+                                             MO_LE);
 }
 
 void glue(address_space_stw_be, SUFFIX)(ARG1_DECL,
@@ -478,7 +478,7 @@ static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
         switch (endian) {
-        case DEVICE_LITTLE_ENDIAN:
+        case MO_LE:
             stq_le_p(ptr, val);
             break;
         case DEVICE_BIG_ENDIAN:
@@ -511,7 +511,7 @@ void glue(address_space_stq_le, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
 {
     glue(address_space_stq_internal, SUFFIX)(ARG1, addr, val, attrs, result,
-                                             DEVICE_LITTLE_ENDIAN);
+                                             MO_LE);
 }
 
 void glue(address_space_stq_be, SUFFIX)(ARG1_DECL,
-- 
2.23.0


