Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327CAC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 07:53:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFC8F2077C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 07:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC8F2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyX2j-0003sa-PS
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 03:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1hyWo0-0003Pg-An
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hyWnq-00032m-36
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:37:48 -0400
Received: from smtpe1.intersmtp.com ([62.239.224.236]:55295)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1hyWmo-0002aM-AX; Fri, 16 Aug 2019 03:36:36 -0400
Received: from tpw09926dag18g.domain1.systemhost.net (10.9.212.34) by
 RDW083A009ED65.bt.com (10.187.98.35) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 16 Aug 2019 08:32:38 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18g.domain1.systemhost.net (10.9.212.34) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Fri, 16 Aug 2019 08:36:31 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Fri, 16 Aug
 2019 08:36:31 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v7 31/42] build: Correct non-common
 common-obj-* to obj-*
Thread-Index: AQHVVAVS/TjWO9oigkGl9/kJPh9JuQ==
Date: Fri, 16 Aug 2019 07:36:31 +0000
Message-ID: <1565940990109.1573@bt.com>
References: <43bc5e07ac614d0e8e740bf6007ff77b@tpw09926dag18e.domain1.systemhost.net>
In-Reply-To: <43bc5e07ac614d0e8e740bf6007ff77b@tpw09926dag18e.domain1.systemhost.net>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.40]
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 62.239.224.236
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] [PATCH v7 31/42] build: Correct non-common
 common-obj-* to obj-*
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
Cc: frederic.konrad@adacore.com, berto@igalia.com, qemu-block@nongnu.org,
 arikalo@wavecomp.com, pasic@linux.ibm.com, hpoussin@reactos.org,
 anthony.perard@citrix.com, xen-devel@lists.xenproject.org, lersek@redhat.com,
 jasowang@redhat.com, jiri@resnulli.us, ehabkost@redhat.com,
 b.galvani@gmail.com, eric.auger@redhat.com, alex.williamson@redhat.com,
 stefanha@redhat.com, jsnow@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 andrew@aj.id.au, claudio.fontana@suse.com, crwulff@gmail.com,
 laurent@vivier.eu, sundeep.lkml@gmail.com, michael@walle.cc,
 qemu-ppc@nongnu.org, kbastian@mail.uni-paderborn.de, imammedo@redhat.com,
 fam@euphon.net, peter.maydell@linaro.org, david@redhat.com, palmer@sifive.com,
 keith.busch@intel.com, jcmvbkbc@gmail.com, hare@suse.com,
 sstabellini@kernel.org, andrew.smirnov@gmail.com, deller@gmx.de,
 magnus.damm@gmail.com, atar4qemu@gmail.com, minyard@acm.org, sw@weilnetz.de,
 yuval.shaia@oracle.com, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 jan.kiszka@web.de, clg@kaod.org, shorne@gmail.com, qemu-riscv@nongnu.org,
 i.mitsyanko@gmail.com, cohuck@redhat.com, philmd@redhat.com,
 amarkovic@wavecomp.com, peter.chubb@nicta.com.au, aurelien@aurel32.net,
 pburton@wavecomp.com, sagark@eecs.berkeley.edu, green@moxielogic.com,
 kraxel@redhat.com, edgar.iglesias@gmail.com, gxt@mprc.pku.edu.cn,
 robh@kernel.org, borntraeger@de.ibm.com, joel@jms.id.au,
 antonynpavlov@gmail.com, chouteau@adacore.com, Andrew.Baumann@microsoft.com,
 mreitz@redhat.com, walling@linux.ibm.com, dmitry.fleytman@gmail.com,
 mst@redhat.com, mark.cave-ayland@ilande.co.uk, jslaby@suse.cz, marex@denx.de,
 proljc@gmail.com, marcandre.lureau@redhat.com, alistair@alistair23.me,
 paul.durrant@citrix.com, david@gibson.dropbear.id.au,
 xiaoguangrong.eric@gmail.com, huth@tuxfamily.org, jcd@tribudubois.net,
 pbonzini@redhat.com, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Preparation for replacing device_endian with MemOp.

Device realizing code with MemorRegionOps endianness as
DEVICE_NATIVE_ENDIAN is not common code.

Corrected devices were identified by making the declaration of
DEVICE_NATIVE_ENDIAN conditional upon NEED_CPU_H and then listing
what failed to compile.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
---
 hw/audio/Makefile.objs    |  3 ++-
 hw/block/Makefile.objs    |  6 +++---
 hw/char/Makefile.objs     |  4 ++--
 hw/core/Makefile.objs     |  2 +-
 hw/display/Makefile.objs  |  6 +++---
 hw/dma/Makefile.objs      |  6 +++---
 hw/gpio/Makefile.objs     |  2 +-
 hw/i2c/Makefile.objs      |  2 +-
 hw/input/Makefile.objs    |  2 +-
 hw/intc/Makefile.objs     |  6 +++---
 hw/ipack/Makefile.objs    |  2 +-
 hw/misc/Makefile.objs     | 10 +++++-----
 hw/net/Makefile.objs      |  2 +-
 hw/pci-host/Makefile.objs |  2 +-
 hw/scsi/Makefile.objs     |  2 +-
 hw/ssi/Makefile.objs      |  2 +-
 hw/timer/Makefile.objs    |  6 +++---
 hw/virtio/Makefile.objs   |  2 +-
 18 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/hw/audio/Makefile.objs b/hw/audio/Makefile.objs
index 63db383..13133b4 100644
--- a/hw/audio/Makefile.objs
+++ b/hw/audio/Makefile.objs
@@ -5,7 +5,8 @@ common-obj-$(CONFIG_AC97) +=3D ac97.o
 common-obj-$(CONFIG_ADLIB) +=3D fmopl.o adlib.o
 common-obj-$(CONFIG_GUS) +=3D gus.o gusemu_hal.o gusemu_mixer.o
 common-obj-$(CONFIG_CS4231A) +=3D cs4231a.o
-common-obj-$(CONFIG_HDA) +=3D intel-hda.o hda-codec.o
+common-obj-$(CONFIG_HDA) +=3D hda-codec.o
+obj-$(CONFIG_HDA) +=3D intel-hda.o

 common-obj-$(CONFIG_PCSPK) +=3D pcspk.o
 common-obj-$(CONFIG_WM8750) +=3D wm8750.o
diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
index f5f643f..04ed4d7 100644
--- a/hw/block/Makefile.objs
+++ b/hw/block/Makefile.objs
@@ -1,9 +1,9 @@
 common-obj-y +=3D block.o cdrom.o hd-geometry.o
-common-obj-$(CONFIG_FDC) +=3D fdc.o
+obj-$(CONFIG_FDC) +=3D fdc.o
 common-obj-$(CONFIG_SSI_M25P80) +=3D m25p80.o
 common-obj-$(CONFIG_NAND) +=3D nand.o
-common-obj-$(CONFIG_PFLASH_CFI01) +=3D pflash_cfi01.o
-common-obj-$(CONFIG_PFLASH_CFI02) +=3D pflash_cfi02.o
+obj-$(CONFIG_PFLASH_CFI01) +=3D pflash_cfi01.o
+obj-$(CONFIG_PFLASH_CFI02) +=3D pflash_cfi02.o
 common-obj-$(CONFIG_XEN) +=3D xen-block.o
 common-obj-$(CONFIG_ECC) +=3D ecc.o
 common-obj-$(CONFIG_ONENAND) +=3D onenand.o
diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
index 02d8a66..215c02b 100644
--- a/hw/char/Makefile.objs
+++ b/hw/char/Makefile.objs
@@ -1,7 +1,6 @@
 common-obj-$(CONFIG_IPACK) +=3D ipoctal232.o
 common-obj-$(CONFIG_ESCC) +=3D escc.o
 common-obj-$(CONFIG_NRF51_SOC) +=3D nrf51_uart.o
-common-obj-$(CONFIG_PARALLEL) +=3D parallel.o
 common-obj-$(CONFIG_ISA_BUS) +=3D parallel-isa.o
 common-obj-$(CONFIG_PL011) +=3D pl011.o
 common-obj-$(CONFIG_SERIAL) +=3D serial.o
@@ -9,7 +8,6 @@ common-obj-$(CONFIG_SERIAL_ISA) +=3D serial-isa.o
 common-obj-$(CONFIG_SERIAL_PCI) +=3D serial-pci.o
 common-obj-$(CONFIG_SERIAL_PCI_MULTI) +=3D serial-pci-multi.o
 common-obj-$(CONFIG_VIRTIO_SERIAL) +=3D virtio-console.o
-common-obj-$(CONFIG_XILINX) +=3D xilinx_uartlite.o
 common-obj-$(CONFIG_XEN) +=3D xen_console.o
 common-obj-$(CONFIG_CADENCE) +=3D cadence_uart.o

@@ -21,6 +19,8 @@ obj-$(CONFIG_PSERIES) +=3D spapr_vty.o
 obj-$(CONFIG_DIGIC) +=3D digic-uart.o
 obj-$(CONFIG_STM32F2XX_USART) +=3D stm32f2xx_usart.o
 obj-$(CONFIG_RASPI) +=3D bcm2835_aux.o
+obj-$(CONFIG_PARALLEL) +=3D parallel.o
+obj-$(CONFIG_XILINX) +=3D xilinx_uartlite.o

 common-obj-$(CONFIG_CMSDK_APB_UART) +=3D cmsdk-apb-uart.o
 common-obj-$(CONFIG_ETRAXFS) +=3D etraxfs_ser.o
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index f8481d9..1b336c6 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -9,7 +9,7 @@ common-obj-y +=3D hotplug.o
 common-obj-$(CONFIG_SOFTMMU) +=3D nmi.o
 common-obj-$(CONFIG_SOFTMMU) +=3D vm-change-state-handler.o

-common-obj-$(CONFIG_EMPTY_SLOT) +=3D empty_slot.o
+obj-$(CONFIG_EMPTY_SLOT) +=3D empty_slot.o
 common-obj-$(CONFIG_XILINX_AXI) +=3D stream.o
 common-obj-$(CONFIG_PTIMER) +=3D ptimer.o
 common-obj-$(CONFIG_SOFTMMU) +=3D sysbus.o
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index a64998f..facc1d4 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -8,7 +8,7 @@ common-obj-$(CONFIG_ADS7846) +=3D ads7846.o
 common-obj-$(CONFIG_VGA_CIRRUS) +=3D cirrus_vga.o
 common-obj-$(call land,$(CONFIG_VGA_CIRRUS),$(CONFIG_VGA_ISA))+=3Dcirrus_v=
ga_isa.o
 common-obj-$(CONFIG_G364FB) +=3D g364fb.o
-common-obj-$(CONFIG_JAZZ_LED) +=3D jazz_led.o
+obj-$(CONFIG_JAZZ_LED) +=3D jazz_led.o
 common-obj-$(CONFIG_PL110) +=3D pl110.o
 common-obj-$(CONFIG_SII9022) +=3D sii9022.o
 common-obj-$(CONFIG_SSD0303) +=3D ssd0303.o
@@ -17,12 +17,12 @@ common-obj-$(CONFIG_XEN) +=3D xenfb.o

 common-obj-$(CONFIG_VGA_PCI) +=3D vga-pci.o
 common-obj-$(CONFIG_VGA_ISA) +=3D vga-isa.o
-common-obj-$(CONFIG_VGA_ISA_MM) +=3D vga-isa-mm.o
+obj-$(CONFIG_VGA_ISA_MM) +=3D vga-isa-mm.o
 common-obj-$(CONFIG_VMWARE_VGA) +=3D vmware_vga.o
 common-obj-$(CONFIG_BOCHS_DISPLAY) +=3D bochs-display.o

 common-obj-$(CONFIG_BLIZZARD) +=3D blizzard.o
-common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_fimd.o
+obj-$(CONFIG_EXYNOS4) +=3D exynos4210_fimd.o
 common-obj-$(CONFIG_FRAMEBUFFER) +=3D framebuffer.o
 obj-$(CONFIG_MILKYMIST) +=3D milkymist-vgafb.o
 common-obj-$(CONFIG_ZAURUS) +=3D tc6393xb.o
diff --git a/hw/dma/Makefile.objs b/hw/dma/Makefile.objs
index 8b39f9c..fff43e0 100644
--- a/hw/dma/Makefile.objs
+++ b/hw/dma/Makefile.objs
@@ -1,10 +1,10 @@
 common-obj-$(CONFIG_PUV3) +=3D puv3_dma.o
-common-obj-$(CONFIG_RC4030) +=3D rc4030.o
+obj-$(CONFIG_RC4030) +=3D rc4030.o
 common-obj-$(CONFIG_PL080) +=3D pl080.o
 common-obj-$(CONFIG_PL330) +=3D pl330.o
 common-obj-$(CONFIG_I82374) +=3D i82374.o
-common-obj-$(CONFIG_I8257) +=3D i8257.o
-common-obj-$(CONFIG_XILINX_AXI) +=3D xilinx_axidma.o
+obj-$(CONFIG_I8257) +=3D i8257.o
+obj-$(CONFIG_XILINX_AXI) +=3D xilinx_axidma.o
 common-obj-$(CONFIG_ZYNQ_DEVCFG) +=3D xlnx-zynq-devcfg.o
 common-obj-$(CONFIG_ETRAXFS) +=3D etraxfs_dma.o
 common-obj-$(CONFIG_STP2000) +=3D sparc32_dma.o
diff --git a/hw/gpio/Makefile.objs b/hw/gpio/Makefile.objs
index e5da0cb..3199288 100644
--- a/hw/gpio/Makefile.objs
+++ b/hw/gpio/Makefile.objs
@@ -1,6 +1,6 @@
 common-obj-$(CONFIG_MAX7310) +=3D max7310.o
 common-obj-$(CONFIG_PL061) +=3D pl061.o
-common-obj-$(CONFIG_PUV3) +=3D puv3_gpio.o
+obj-$(CONFIG_PUV3) +=3D puv3_gpio.o
 common-obj-$(CONFIG_ZAURUS) +=3D zaurus.o
 common-obj-$(CONFIG_E500) +=3D mpc8xxx.o
 common-obj-$(CONFIG_GPIO_KEY) +=3D gpio_key.o
diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
index d7073a4..f026949 100644
--- a/hw/i2c/Makefile.objs
+++ b/hw/i2c/Makefile.objs
@@ -4,7 +4,7 @@ common-obj-$(CONFIG_VERSATILE_I2C) +=3D versatile_i2c.o
 common-obj-$(CONFIG_ACPI_X86_ICH) +=3D smbus_ich9.o
 common-obj-$(CONFIG_ACPI_SMBUS) +=3D pm_smbus.o
 common-obj-$(CONFIG_BITBANG_I2C) +=3D bitbang_i2c.o
-common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_i2c.o
+obj-$(CONFIG_EXYNOS4) +=3D exynos4210_i2c.o
 common-obj-$(CONFIG_IMX_I2C) +=3D imx_i2c.o
 common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_i2c.o
 common-obj-$(CONFIG_NRF51_SOC) +=3D microbit_i2c.o
diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
index a1bc502..e28f844 100644
--- a/hw/input/Makefile.objs
+++ b/hw/input/Makefile.objs
@@ -1,7 +1,7 @@
 common-obj-$(CONFIG_ADB) +=3D adb.o adb-mouse.o adb-kbd.o
 common-obj-y +=3D hid.o
 common-obj-$(CONFIG_LM832X) +=3D lm832x.o
-common-obj-$(CONFIG_PCKBD) +=3D pckbd.o
+obj-$(CONFIG_PCKBD) +=3D pckbd.o
 common-obj-$(CONFIG_PL050) +=3D pl050.o
 common-obj-$(CONFIG_PS2) +=3D ps2.o
 common-obj-$(CONFIG_STELLARIS_INPUT) +=3D stellaris_input.o
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index 03019b9..650de8b 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -2,14 +2,14 @@ common-obj-$(CONFIG_HEATHROW_PIC) +=3D heathrow_pic.o
 common-obj-$(CONFIG_I8259) +=3D i8259_common.o i8259.o
 common-obj-$(CONFIG_PL190) +=3D pl190.o
 common-obj-$(CONFIG_PUV3) +=3D puv3_intc.o
-common-obj-$(CONFIG_XILINX) +=3D xilinx_intc.o
+obj-$(CONFIG_XILINX) +=3D xilinx_intc.o
 common-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx-pmu-iomod-intc.o
 common-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx-zynqmp-ipi.o
 common-obj-$(CONFIG_ETRAXFS) +=3D etraxfs_pic.o
 common-obj-$(CONFIG_IMX) +=3D imx_avic.o imx_gpcv2.o
 common-obj-$(CONFIG_LM32) +=3D lm32_pic.o
 common-obj-$(CONFIG_REALVIEW) +=3D realview_gic.o
-common-obj-$(CONFIG_SLAVIO) +=3D slavio_intctl.o
+obj-$(CONFIG_SLAVIO) +=3D slavio_intctl.o
 common-obj-$(CONFIG_IOAPIC) +=3D ioapic_common.o
 common-obj-$(CONFIG_ARM_GIC) +=3D arm_gic_common.o
 common-obj-$(CONFIG_ARM_GIC) +=3D arm_gic.o
@@ -18,7 +18,7 @@ common-obj-$(CONFIG_ARM_GIC) +=3D arm_gicv3_common.o
 common-obj-$(CONFIG_ARM_GIC) +=3D arm_gicv3.o
 common-obj-$(CONFIG_ARM_GIC) +=3D arm_gicv3_dist.o
 common-obj-$(CONFIG_ARM_GIC) +=3D arm_gicv3_redist.o
-common-obj-$(CONFIG_ARM_GIC) +=3D arm_gicv3_its_common.o
+obj-$(CONFIG_ARM_GIC) +=3D arm_gicv3_its_common.o
 common-obj-$(CONFIG_OPENPIC) +=3D openpic.o
 common-obj-y +=3D intc.o

diff --git a/hw/ipack/Makefile.objs b/hw/ipack/Makefile.objs
index 8b9bdcb..a7c5485 100644
--- a/hw/ipack/Makefile.objs
+++ b/hw/ipack/Makefile.objs
@@ -1,2 +1,2 @@
 common-obj-$(CONFIG_IPACK) +=3D ipack.o
-common-obj-$(CONFIG_IPACK) +=3D tpci200.o
+obj-$(CONFIG_IPACK) +=3D tpci200.o
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index e9aab51..10932b2 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -1,4 +1,4 @@
-common-obj-$(CONFIG_APPLESMC) +=3D applesmc.o
+ommon-obj-$(CONFIG_APPLESMC) +=3D applesmc.o
 common-obj-$(CONFIG_MAX111X) +=3D max111x.o
 common-obj-$(CONFIG_TMP105) +=3D tmp105.o
 common-obj-$(CONFIG_TMP421) +=3D tmp421.o
@@ -6,20 +6,20 @@ common-obj-$(CONFIG_ISA_DEBUG) +=3D debugexit.o
 common-obj-$(CONFIG_SGA) +=3D sga.o
 common-obj-$(CONFIG_ISA_TESTDEV) +=3D pc-testdev.o
 common-obj-$(CONFIG_PCI_TESTDEV) +=3D pci-testdev.o
-common-obj-$(CONFIG_EDU) +=3D edu.o
+obj-$(CONFIG_EDU) +=3D edu.o
 common-obj-$(CONFIG_PCA9552) +=3D pca9552.o

-common-obj-y +=3D unimp.o
+obj-y +=3D unimp.o
 common-obj-$(CONFIG_FW_CFG_DMA) +=3D vmcoreinfo.o

 # ARM devices
 common-obj-$(CONFIG_PL310) +=3D arm_l2x0.o
-common-obj-$(CONFIG_INTEGRATOR_DEBUG) +=3D arm_integrator_debug.o
+obj-$(CONFIG_INTEGRATOR_DEBUG) +=3D arm_integrator_debug.o
 common-obj-$(CONFIG_A9SCU) +=3D a9scu.o
 common-obj-$(CONFIG_ARM11SCU) +=3D arm11scu.o

 # Mac devices
-common-obj-$(CONFIG_MOS6522) +=3D mos6522.o
+obj-$(CONFIG_MOS6522) +=3D mos6522.o

 # PKUnity SoC devices
 common-obj-$(CONFIG_PUV3) +=3D puv3_pm.o
diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
index 9904273..8526611 100644
--- a/hw/net/Makefile.objs
+++ b/hw/net/Makefile.objs
@@ -1,4 +1,4 @@
-common-obj-$(CONFIG_DP8393X) +=3D dp8393x.o
+obj-$(CONFIG_DP8393X) +=3D dp8393x.o
 common-obj-$(CONFIG_XEN) +=3D xen_nic.o
 common-obj-$(CONFIG_NE2000_COMMON) +=3D ne2000.o

diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
index a9cd3e0..02f286b 100644
--- a/hw/pci-host/Makefile.objs
+++ b/hw/pci-host/Makefile.objs
@@ -12,7 +12,7 @@ common-obj-$(CONFIG_PPCE500_PCI) +=3D ppce500.o
 common-obj-$(CONFIG_VERSATILE_PCI) +=3D versatile.o

 common-obj-$(CONFIG_PCI_SABRE) +=3D sabre.o
-common-obj-$(CONFIG_FULONG) +=3D bonito.o
+obj-$(CONFIG_FULONG) +=3D bonito.o
 common-obj-$(CONFIG_PCI_PIIX) +=3D piix.o
 common-obj-$(CONFIG_PCI_EXPRESS_Q35) +=3D q35.o
 common-obj-$(CONFIG_PCI_EXPRESS_GENERIC_BRIDGE) +=3D gpex.o
diff --git a/hw/scsi/Makefile.objs b/hw/scsi/Makefile.objs
index 54b36ed..418af9a 100644
--- a/hw/scsi/Makefile.objs
+++ b/hw/scsi/Makefile.objs
@@ -4,7 +4,7 @@ common-obj-$(CONFIG_LSI_SCSI_PCI) +=3D lsi53c895a.o
 common-obj-$(CONFIG_MPTSAS_SCSI_PCI) +=3D mptsas.o mptconfig.o mptendian.o
 common-obj-$(CONFIG_MEGASAS_SCSI_PCI) +=3D megasas.o
 common-obj-$(CONFIG_VMW_PVSCSI_SCSI_PCI) +=3D vmw_pvscsi.o
-common-obj-$(CONFIG_ESP) +=3D esp.o
+obj-$(CONFIG_ESP) +=3D esp.o
 common-obj-$(CONFIG_ESP_PCI) +=3D esp-pci.o
 obj-$(CONFIG_SPAPR_VSCSI) +=3D spapr_vscsi.o

diff --git a/hw/ssi/Makefile.objs b/hw/ssi/Makefile.objs
index f5bcc65..54b5542 100644
--- a/hw/ssi/Makefile.objs
+++ b/hw/ssi/Makefile.objs
@@ -1,6 +1,6 @@
 common-obj-$(CONFIG_PL022) +=3D pl022.o
 common-obj-$(CONFIG_SSI) +=3D ssi.o
-common-obj-$(CONFIG_XILINX_SPI) +=3D xilinx_spi.o
+obj-$(CONFIG_XILINX_SPI) +=3D xilinx_spi.o
 common-obj-$(CONFIG_XILINX_SPIPS) +=3D xilinx_spips.o
 common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_smc.o
 common-obj-$(CONFIG_STM32F2XX_SPI) +=3D stm32f2xx_spi.o
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 123d92c..b27513f 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -12,10 +12,10 @@ ifeq ($(CONFIG_ISA_BUS),y)
 common-obj-$(CONFIG_M48T59) +=3D m48t59-isa.o
 endif
 common-obj-$(CONFIG_PL031) +=3D pl031.o
-common-obj-$(CONFIG_PUV3) +=3D puv3_ost.o
+obj-$(CONFIG_PUV3) +=3D puv3_ost.o
 common-obj-$(CONFIG_TWL92230) +=3D twl92230.o
-common-obj-$(CONFIG_XILINX) +=3D xilinx_timer.o
-common-obj-$(CONFIG_SLAVIO) +=3D slavio_timer.o
+obj-$(CONFIG_XILINX) +=3D xilinx_timer.o
+obj-$(CONFIG_SLAVIO) +=3D slavio_timer.o
 common-obj-$(CONFIG_ETRAXFS) +=3D etraxfs_timer.o
 common-obj-$(CONFIG_GRLIB) +=3D grlib_gptimer.o
 common-obj-$(CONFIG_IMX) +=3D imx_epit.o
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 964ce78..573b1a9 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -8,7 +8,7 @@ obj-$(CONFIG_VHOST_USER) +=3D vhost-user.o

 common-obj-$(CONFIG_VIRTIO_RNG) +=3D virtio-rng.o
 common-obj-$(CONFIG_VIRTIO_PCI) +=3D virtio-pci.o
-common-obj-$(CONFIG_VIRTIO_MMIO) +=3D virtio-mmio.o
+obj-$(CONFIG_VIRTIO_MMIO) +=3D virtio-mmio.o
 obj-$(CONFIG_VIRTIO_BALLOON) +=3D virtio-balloon.o
 obj-$(CONFIG_VIRTIO_CRYPTO) +=3D virtio-crypto.o
 obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) +=3D virtio-=
crypto-pci.o
--
1.8.3.1

?

