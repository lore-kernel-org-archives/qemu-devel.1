Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E912C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 14:32:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18F3A2173E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 14:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F3A2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2G2Q-0006m6-0T
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 10:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i2FqP-0004p3-Ji
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 10:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i2FqM-0000wv-Sx
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 10:19:41 -0400
Received: from nsstlmta09p.bpe.bigpond.com ([203.38.21.9]:38679)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1i2FqL-0000ru-4h; Mon, 26 Aug 2019 10:19:38 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep09p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190826141933.NTWW7749.nsstlfep09p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Tue, 27 Aug 2019 00:19:33 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrudehgedgjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuuffpveftpgfvgffnuffvtfetpdfqfgfvnecuuegrihhlohhuthemucegtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhonhihucfpghhuhigvnhcuoehtohhnhidrnhhguhihvghnsegsthdrtghomheqnecukfhppeehkedrudejfedrleekrdeikeenucfrrghrrghmpehhvghlohepuggsiidrthgvlhhsthhrrgdrtghomhdrrghupdhinhgvthepheekrddujeefrdelkedrieekpdhmrghilhhfrhhomhepoehtohhnhidrnhhguhihvghnsegsthdrtghomheqpdhrtghpthhtohepoegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgeqpdhrtghpthhtohepoehfrghmsegvuhhphhhonhdrnhgvtheqpdhrtghpthhtohepoehjrghsohifrghnghesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeokhifohhlfhesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeomhgrrhgtrghnughrvgdrlhhurhgvrghusehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehmrhgvihhtiiesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeomhhsthesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeophgsohhniihinhhisehrvgguhhgrthdrtghomheqpdhrtghpthht
 ohepoehqvghmuhdqsghlohgtkhesnhhonhhgnhhurdhorhhgqedprhgtphhtthhopeeoqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgheqpdhrtghpthhtohepoehtohhnhidrnhhguhihvghnsegsthdrtghomheqnecuvehluhhsthgvrhfuihiivgepge
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from dbz.telstra.com.au (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D3692920D8AE5A1; Tue, 27 Aug 2019 00:19:32 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 00:21:45 +1000
Message-Id: <824d87bc2059bca369e6be48b556b456b373dc03.1566829168.git.tony.nguyen@bt.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566829168.git.tony.nguyen@bt.com>
References: <cover.1566829168.git.tony.nguyen@bt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.9
Subject: [Qemu-devel] [PATCH 19/19] build: Correct non-common common-obj-*
 to obj-*
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
Cc: Kevin Wolf <kwolf@redhat.com>, Tony Nguyen <tony.nguyen@bt.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Device realizing code with MemorRegionOps endianness as
DEVICE_NATIVE_ENDIAN is not common code.

Corrected devices were identified by making the declaration of
DEVICE_NATIVE_ENDIAN conditional upon NEED_CPU_H and then listing
what failed to compile.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
---
 hw/block/Makefile.objs   | 4 ++--
 hw/char/Makefile.objs    | 4 ++--
 hw/display/Makefile.objs | 2 +-
 hw/dma/Makefile.objs     | 4 ++--
 hw/input/Makefile.objs   | 2 +-
 hw/intc/Makefile.objs    | 2 +-
 hw/net/Makefile.objs     | 2 +-
 hw/scsi/Makefile.objs    | 2 +-
 hw/ssi/Makefile.objs     | 2 +-
 hw/timer/Makefile.objs   | 2 +-
 hw/virtio/Makefile.objs  | 2 +-
 11 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
index f5f643f0cc..3d5d80e2e3 100644
--- a/hw/block/Makefile.objs
+++ b/hw/block/Makefile.objs
@@ -2,8 +2,8 @@ common-obj-y += block.o cdrom.o hd-geometry.o
 common-obj-$(CONFIG_FDC) += fdc.o
 common-obj-$(CONFIG_SSI_M25P80) += m25p80.o
 common-obj-$(CONFIG_NAND) += nand.o
-common-obj-$(CONFIG_PFLASH_CFI01) += pflash_cfi01.o
-common-obj-$(CONFIG_PFLASH_CFI02) += pflash_cfi02.o
+obj-$(CONFIG_PFLASH_CFI01) += pflash_cfi01.o
+obj-$(CONFIG_PFLASH_CFI02) += pflash_cfi02.o
 common-obj-$(CONFIG_XEN) += xen-block.o
 common-obj-$(CONFIG_ECC) += ecc.o
 common-obj-$(CONFIG_ONENAND) += onenand.o
diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
index 02d8a66925..215c02b752 100644
--- a/hw/char/Makefile.objs
+++ b/hw/char/Makefile.objs
@@ -1,7 +1,6 @@
 common-obj-$(CONFIG_IPACK) += ipoctal232.o
 common-obj-$(CONFIG_ESCC) += escc.o
 common-obj-$(CONFIG_NRF51_SOC) += nrf51_uart.o
-common-obj-$(CONFIG_PARALLEL) += parallel.o
 common-obj-$(CONFIG_ISA_BUS) += parallel-isa.o
 common-obj-$(CONFIG_PL011) += pl011.o
 common-obj-$(CONFIG_SERIAL) += serial.o
@@ -9,7 +8,6 @@ common-obj-$(CONFIG_SERIAL_ISA) += serial-isa.o
 common-obj-$(CONFIG_SERIAL_PCI) += serial-pci.o
 common-obj-$(CONFIG_SERIAL_PCI_MULTI) += serial-pci-multi.o
 common-obj-$(CONFIG_VIRTIO_SERIAL) += virtio-console.o
-common-obj-$(CONFIG_XILINX) += xilinx_uartlite.o
 common-obj-$(CONFIG_XEN) += xen_console.o
 common-obj-$(CONFIG_CADENCE) += cadence_uart.o
 
@@ -21,6 +19,8 @@ obj-$(CONFIG_PSERIES) += spapr_vty.o
 obj-$(CONFIG_DIGIC) += digic-uart.o
 obj-$(CONFIG_STM32F2XX_USART) += stm32f2xx_usart.o
 obj-$(CONFIG_RASPI) += bcm2835_aux.o
+obj-$(CONFIG_PARALLEL) += parallel.o
+obj-$(CONFIG_XILINX) += xilinx_uartlite.o
 
 common-obj-$(CONFIG_CMSDK_APB_UART) += cmsdk-apb-uart.o
 common-obj-$(CONFIG_ETRAXFS) += etraxfs_ser.o
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 0f11d55b14..8d3be95cbd 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -17,7 +17,7 @@ common-obj-$(CONFIG_XEN) += xenfb.o
 
 common-obj-$(CONFIG_VGA_PCI) += vga-pci.o
 common-obj-$(CONFIG_VGA_ISA) += vga-isa.o
-common-obj-$(CONFIG_VGA_ISA_MM) += vga-isa-mm.o
+obj-$(CONFIG_VGA_ISA_MM) += vga-isa-mm.o
 common-obj-$(CONFIG_VMWARE_VGA) += vmware_vga.o
 common-obj-$(CONFIG_BOCHS_DISPLAY) += bochs-display.o
 
diff --git a/hw/dma/Makefile.objs b/hw/dma/Makefile.objs
index b672e7a522..61021d8797 100644
--- a/hw/dma/Makefile.objs
+++ b/hw/dma/Makefile.objs
@@ -1,10 +1,10 @@
 common-obj-$(CONFIG_PUV3) += puv3_dma.o
-common-obj-$(CONFIG_RC4030) += rc4030.o
+obj-$(CONFIG_RC4030) += rc4030.o
 common-obj-$(CONFIG_PL080) += pl080.o
 common-obj-$(CONFIG_PL330) += pl330.o
 common-obj-$(CONFIG_I82374) += i82374.o
 common-obj-$(CONFIG_I8257) += i8257.o
-common-obj-$(CONFIG_XILINX_AXI) += xilinx_axidma.o
+obj-$(CONFIG_XILINX_AXI) += xilinx_axidma.o
 common-obj-$(CONFIG_ZYNQ_DEVCFG) += xlnx-zynq-devcfg.o
 common-obj-$(CONFIG_ETRAXFS) += etraxfs_dma.o
 common-obj-$(CONFIG_STP2000) += sparc32_dma.o
diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
index a1bc502ed0..e28f84428d 100644
--- a/hw/input/Makefile.objs
+++ b/hw/input/Makefile.objs
@@ -1,7 +1,7 @@
 common-obj-$(CONFIG_ADB) += adb.o adb-mouse.o adb-kbd.o
 common-obj-y += hid.o
 common-obj-$(CONFIG_LM832X) += lm832x.o
-common-obj-$(CONFIG_PCKBD) += pckbd.o
+obj-$(CONFIG_PCKBD) += pckbd.o
 common-obj-$(CONFIG_PL050) += pl050.o
 common-obj-$(CONFIG_PS2) += ps2.o
 common-obj-$(CONFIG_STELLARIS_INPUT) += stellaris_input.o
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index f726d87532..660c6da00c 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -2,7 +2,7 @@ common-obj-$(CONFIG_HEATHROW_PIC) += heathrow_pic.o
 common-obj-$(CONFIG_I8259) += i8259_common.o i8259.o
 common-obj-$(CONFIG_PL190) += pl190.o
 common-obj-$(CONFIG_PUV3) += puv3_intc.o
-common-obj-$(CONFIG_XILINX) += xilinx_intc.o
+obj-$(CONFIG_XILINX) += xilinx_intc.o
 common-obj-$(CONFIG_XLNX_ZYNQMP_PMU) += xlnx-pmu-iomod-intc.o
 common-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp-ipi.o
 common-obj-$(CONFIG_ETRAXFS) += etraxfs_pic.o
diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
index 9904273b06..8526611606 100644
--- a/hw/net/Makefile.objs
+++ b/hw/net/Makefile.objs
@@ -1,4 +1,4 @@
-common-obj-$(CONFIG_DP8393X) += dp8393x.o
+obj-$(CONFIG_DP8393X) += dp8393x.o
 common-obj-$(CONFIG_XEN) += xen_nic.o
 common-obj-$(CONFIG_NE2000_COMMON) += ne2000.o
 
diff --git a/hw/scsi/Makefile.objs b/hw/scsi/Makefile.objs
index 54b36ed8b1..418af9a7ec 100644
--- a/hw/scsi/Makefile.objs
+++ b/hw/scsi/Makefile.objs
@@ -4,7 +4,7 @@ common-obj-$(CONFIG_LSI_SCSI_PCI) += lsi53c895a.o
 common-obj-$(CONFIG_MPTSAS_SCSI_PCI) += mptsas.o mptconfig.o mptendian.o
 common-obj-$(CONFIG_MEGASAS_SCSI_PCI) += megasas.o
 common-obj-$(CONFIG_VMW_PVSCSI_SCSI_PCI) += vmw_pvscsi.o
-common-obj-$(CONFIG_ESP) += esp.o
+obj-$(CONFIG_ESP) += esp.o
 common-obj-$(CONFIG_ESP_PCI) += esp-pci.o
 obj-$(CONFIG_SPAPR_VSCSI) += spapr_vscsi.o
 
diff --git a/hw/ssi/Makefile.objs b/hw/ssi/Makefile.objs
index f5bcc65fe7..54b5542c22 100644
--- a/hw/ssi/Makefile.objs
+++ b/hw/ssi/Makefile.objs
@@ -1,6 +1,6 @@
 common-obj-$(CONFIG_PL022) += pl022.o
 common-obj-$(CONFIG_SSI) += ssi.o
-common-obj-$(CONFIG_XILINX_SPI) += xilinx_spi.o
+obj-$(CONFIG_XILINX_SPI) += xilinx_spi.o
 common-obj-$(CONFIG_XILINX_SPIPS) += xilinx_spips.o
 common-obj-$(CONFIG_ASPEED_SOC) += aspeed_smc.o
 common-obj-$(CONFIG_STM32F2XX_SPI) += stm32f2xx_spi.o
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 123d92c969..1c249cc34e 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -14,7 +14,7 @@ endif
 common-obj-$(CONFIG_PL031) += pl031.o
 common-obj-$(CONFIG_PUV3) += puv3_ost.o
 common-obj-$(CONFIG_TWL92230) += twl92230.o
-common-obj-$(CONFIG_XILINX) += xilinx_timer.o
+obj-$(CONFIG_XILINX) += xilinx_timer.o
 common-obj-$(CONFIG_SLAVIO) += slavio_timer.o
 common-obj-$(CONFIG_ETRAXFS) += etraxfs_timer.o
 common-obj-$(CONFIG_GRLIB) += grlib_gptimer.o
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 964ce78607..573b1a9e31 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -8,7 +8,7 @@ obj-$(CONFIG_VHOST_USER) += vhost-user.o
 
 common-obj-$(CONFIG_VIRTIO_RNG) += virtio-rng.o
 common-obj-$(CONFIG_VIRTIO_PCI) += virtio-pci.o
-common-obj-$(CONFIG_VIRTIO_MMIO) += virtio-mmio.o
+obj-$(CONFIG_VIRTIO_MMIO) += virtio-mmio.o
 obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon.o
 obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-crypto.o
 obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-pci.o
-- 
2.23.0


