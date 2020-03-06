Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC5EC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C005B20848
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U6q7GzZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C005B20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAB1f-0005AX-S9
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 06:20:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAAs6-0003hV-6r
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAAry-0004rL-Hi
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:26 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:38123)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAAry-0004oc-2x
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:18 -0500
Received: by mail-wm1-x331.google.com with SMTP id u9so1919587wml.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 03:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/7cmXLJ1jGIo0MPxJr7hgm+Yw61B2AjxAAA11QOLFQ4=;
 b=U6q7GzZlTozpZw+vJPyVSfTQ2GFdCorSRWq/c6jowb/czB94odSmVhgkyzk82DQbIb
 lRx9Jeo0J0ZLp3nUYPUWKuOfzwHc/tKGRVNVanXifQa+I56oA+A0nbFtYZm47W4MbMEh
 9oMeNM2OK1fGUB2whCOc+zbyMEt+TizTD/27pvtvCVtBeyrTFVZkau7yKTpWsqHPcwl/
 UI+ikdoT2DvOxsgE6vB1svf/QxtrPyTf0FdWla+1Qgqqs3rIKChUaDom8yoDZW1lXtGd
 8DT3vPn3TZ3kdTLIusgFxEyUo38J3XDGh8hQO/HksC2vN6MhQ1ZGPPzqvTPTlvg/Pkfk
 PEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/7cmXLJ1jGIo0MPxJr7hgm+Yw61B2AjxAAA11QOLFQ4=;
 b=L8MobkTYbHkzJ29X9P0w1O/FzFMpQJiH6X/tveb2hNBZgqUWTGOOG/2GK8tEl5CpdN
 /MiGl30/Cs+xOYlJYJA4qbanmXMMVNio/oraETXGppSRO1VxyycAo+jMg2gox4EnHikn
 mzb6/wXi8MBjNO3Os039sBxsUV0/IycrKaUGntQlNAlAGRYHW1rMssXinNqos6QM5Ysc
 Tpda0/VaJxhGfrCTeddIlxa+Nf3oX0IrhPnCjkMuE4XekVjg3x8KIIx7aHC1kjC4tEnJ
 VG06Z1l+X/S6kv6VHBMwMvr84HTDrEfbNkhQ3iD/9RHA98t+TJQoJwUTU9lWW6fQ/0PN
 +Kyw==
X-Gm-Message-State: ANhLgQ0aHAduQPi9Uld6hrNNo/fP8jsjUZJFtuIOFp5d5Yc0P7NCosms
 pXlvT7M6F6Yszezh4R5S/3HCKMilbsHZ2A==
X-Google-Smtp-Source: ADFU+vvhbmZHelLhywns0jw/XfTbZrokWV3gA5a1ot6tezDwi6NYHtwMl2Xzy25xMNulD9mjsQxtlg==
X-Received: by 2002:a7b:c1c1:: with SMTP id a1mr3648242wmj.56.1583493013917;
 Fri, 06 Mar 2020 03:10:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm12553029wma.26.2020.03.06.03.10.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 03:10:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/33] qemu-doc: split target sections to separate files
Date: Fri,  6 Mar 2020 11:09:34 +0000
Message-Id: <20200306110959.29461-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306110959.29461-1-peter.maydell@linaro.org>
References: <20200306110959.29461-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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

From: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200228153619.9906-9-peter.maydell@linaro.org
Message-id: 20200226113034.6741-9-pbonzini@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/target-arm.texi     | 264 ++++++++++
 docs/system/target-i386.texi    |  92 ++++
 docs/system/target-m68k.texi    |  46 ++
 docs/system/target-mips.texi    | 152 ++++++
 docs/system/target-ppc.texi     |  78 +++
 docs/system/target-sparc.texi   |  96 ++++
 docs/system/target-sparc64.texi |  61 +++
 docs/system/target-xtensa.texi  |  56 ++
 qemu-doc.texi                   | 873 +-------------------------------
 9 files changed, 853 insertions(+), 865 deletions(-)
 create mode 100644 docs/system/target-arm.texi
 create mode 100644 docs/system/target-i386.texi
 create mode 100644 docs/system/target-m68k.texi
 create mode 100644 docs/system/target-mips.texi
 create mode 100644 docs/system/target-ppc.texi
 create mode 100644 docs/system/target-sparc.texi
 create mode 100644 docs/system/target-sparc64.texi
 create mode 100644 docs/system/target-xtensa.texi

diff --git a/docs/system/target-arm.texi b/docs/system/target-arm.texi
new file mode 100644
index 00000000000..040d77b5e05
--- /dev/null
+++ b/docs/system/target-arm.texi
@@ -0,0 +1,264 @@
+@node ARM System emulator
+@section ARM System emulator
+@cindex system emulation (ARM)
+
+Use the executable @file{qemu-system-arm} to simulate a ARM
+machine. The ARM Integrator/CP board is emulated with the following
+devices:
+
+@itemize @minus
+@item
+ARM926E, ARM1026E, ARM946E, ARM1136 or Cortex-A8 CPU
+@item
+Two PL011 UARTs
+@item
+SMC 91c111 Ethernet adapter
+@item
+PL110 LCD controller
+@item
+PL050 KMI with PS/2 keyboard and mouse.
+@item
+PL181 MultiMedia Card Interface with SD card.
+@end itemize
+
+The ARM Versatile baseboard is emulated with the following devices:
+
+@itemize @minus
+@item
+ARM926E, ARM1136 or Cortex-A8 CPU
+@item
+PL190 Vectored Interrupt Controller
+@item
+Four PL011 UARTs
+@item
+SMC 91c111 Ethernet adapter
+@item
+PL110 LCD controller
+@item
+PL050 KMI with PS/2 keyboard and mouse.
+@item
+PCI host bridge.  Note the emulated PCI bridge only provides access to
+PCI memory space.  It does not provide access to PCI IO space.
+This means some devices (eg. ne2k_pci NIC) are not usable, and others
+(eg. rtl8139 NIC) are only usable when the guest drivers use the memory
+mapped control registers.
+@item
+PCI OHCI USB controller.
+@item
+LSI53C895A PCI SCSI Host Bus Adapter with hard disk and CD-ROM devices.
+@item
+PL181 MultiMedia Card Interface with SD card.
+@end itemize
+
+Several variants of the ARM RealView baseboard are emulated,
+including the EB, PB-A8 and PBX-A9.  Due to interactions with the
+bootloader, only certain Linux kernel configurations work out
+of the box on these boards.
+
+Kernels for the PB-A8 board should have CONFIG_REALVIEW_HIGH_PHYS_OFFSET
+enabled in the kernel, and expect 512M RAM.  Kernels for The PBX-A9 board
+should have CONFIG_SPARSEMEM enabled, CONFIG_REALVIEW_HIGH_PHYS_OFFSET
+disabled and expect 1024M RAM.
+
+The following devices are emulated:
+
+@itemize @minus
+@item
+ARM926E, ARM1136, ARM11MPCore, Cortex-A8 or Cortex-A9 MPCore CPU
+@item
+ARM AMBA Generic/Distributed Interrupt Controller
+@item
+Four PL011 UARTs
+@item
+SMC 91c111 or SMSC LAN9118 Ethernet adapter
+@item
+PL110 LCD controller
+@item
+PL050 KMI with PS/2 keyboard and mouse
+@item
+PCI host bridge
+@item
+PCI OHCI USB controller
+@item
+LSI53C895A PCI SCSI Host Bus Adapter with hard disk and CD-ROM devices
+@item
+PL181 MultiMedia Card Interface with SD card.
+@end itemize
+
+The XScale-based clamshell PDA models ("Spitz", "Akita", "Borzoi"
+and "Terrier") emulation includes the following peripherals:
+
+@itemize @minus
+@item
+Intel PXA270 System-on-chip (ARM V5TE core)
+@item
+NAND Flash memory
+@item
+IBM/Hitachi DSCM microdrive in a PXA PCMCIA slot - not in "Akita"
+@item
+On-chip OHCI USB controller
+@item
+On-chip LCD controller
+@item
+On-chip Real Time Clock
+@item
+TI ADS7846 touchscreen controller on SSP bus
+@item
+Maxim MAX1111 analog-digital converter on I@math{^2}C bus
+@item
+GPIO-connected keyboard controller and LEDs
+@item
+Secure Digital card connected to PXA MMC/SD host
+@item
+Three on-chip UARTs
+@item
+WM8750 audio CODEC on I@math{^2}C and I@math{^2}S busses
+@end itemize
+
+The Palm Tungsten|E PDA (codename "Cheetah") emulation includes the
+following elements:
+
+@itemize @minus
+@item
+Texas Instruments OMAP310 System-on-chip (ARM 925T core)
+@item
+ROM and RAM memories (ROM firmware image can be loaded with -option-rom)
+@item
+On-chip LCD controller
+@item
+On-chip Real Time Clock
+@item
+TI TSC2102i touchscreen controller / analog-digital converter / Audio
+CODEC, connected through MicroWire and I@math{^2}S busses
+@item
+GPIO-connected matrix keypad
+@item
+Secure Digital card connected to OMAP MMC/SD host
+@item
+Three on-chip UARTs
+@end itemize
+
+Nokia N800 and N810 internet tablets (known also as RX-34 and RX-44 / 48)
+emulation supports the following elements:
+
+@itemize @minus
+@item
+Texas Instruments OMAP2420 System-on-chip (ARM 1136 core)
+@item
+RAM and non-volatile OneNAND Flash memories
+@item
+Display connected to EPSON remote framebuffer chip and OMAP on-chip
+display controller and a LS041y3 MIPI DBI-C controller
+@item
+TI TSC2301 (in N800) and TI TSC2005 (in N810) touchscreen controllers
+driven through SPI bus
+@item
+National Semiconductor LM8323-controlled qwerty keyboard driven
+through I@math{^2}C bus
+@item
+Secure Digital card connected to OMAP MMC/SD host
+@item
+Three OMAP on-chip UARTs and on-chip STI debugging console
+@item
+Mentor Graphics "Inventra" dual-role USB controller embedded in a TI
+TUSB6010 chip - only USB host mode is supported
+@item
+TI TMP105 temperature sensor driven through I@math{^2}C bus
+@item
+TI TWL92230C power management companion with an RTC on I@math{^2}C bus
+@item
+Nokia RETU and TAHVO multi-purpose chips with an RTC, connected
+through CBUS
+@end itemize
+
+The Luminary Micro Stellaris LM3S811EVB emulation includes the following
+devices:
+
+@itemize @minus
+@item
+Cortex-M3 CPU core.
+@item
+64k Flash and 8k SRAM.
+@item
+Timers, UARTs, ADC and I@math{^2}C interface.
+@item
+OSRAM Pictiva 96x16 OLED with SSD0303 controller on I@math{^2}C bus.
+@end itemize
+
+The Luminary Micro Stellaris LM3S6965EVB emulation includes the following
+devices:
+
+@itemize @minus
+@item
+Cortex-M3 CPU core.
+@item
+256k Flash and 64k SRAM.
+@item
+Timers, UARTs, ADC, I@math{^2}C and SSI interfaces.
+@item
+OSRAM Pictiva 128x64 OLED with SSD0323 controller connected via SSI.
+@end itemize
+
+The Freecom MusicPal internet radio emulation includes the following
+elements:
+
+@itemize @minus
+@item
+Marvell MV88W8618 ARM core.
+@item
+32 MB RAM, 256 KB SRAM, 8 MB flash.
+@item
+Up to 2 16550 UARTs
+@item
+MV88W8xx8 Ethernet controller
+@item
+MV88W8618 audio controller, WM8750 CODEC and mixer
+@item
+128×64 display with brightness control
+@item
+2 buttons, 2 navigation wheels with button function
+@end itemize
+
+The Siemens SX1 models v1 and v2 (default) basic emulation.
+The emulation includes the following elements:
+
+@itemize @minus
+@item
+Texas Instruments OMAP310 System-on-chip (ARM 925T core)
+@item
+ROM and RAM memories (ROM firmware image can be loaded with -pflash)
+V1
+1 Flash of 16MB and 1 Flash of 8MB
+V2
+1 Flash of 32MB
+@item
+On-chip LCD controller
+@item
+On-chip Real Time Clock
+@item
+Secure Digital card connected to OMAP MMC/SD host
+@item
+Three on-chip UARTs
+@end itemize
+
+A Linux 2.6 test image is available on the QEMU web site. More
+information is available in the QEMU mailing-list archive.
+
+@c man begin OPTIONS
+
+The following options are specific to the ARM emulation:
+
+@table @option
+
+@item -semihosting
+Enable semihosting syscall emulation.
+
+On ARM this implements the "Angel" interface.
+
+Note that this allows guest direct access to the host filesystem,
+so should only be used with trusted guest OS.
+
+@end table
+
+@c man end
+
diff --git a/docs/system/target-i386.texi b/docs/system/target-i386.texi
new file mode 100644
index 00000000000..edd23fa8df5
--- /dev/null
+++ b/docs/system/target-i386.texi
@@ -0,0 +1,92 @@
+@node x86 (PC) System emulator
+@section x86 (PC) System emulator
+@cindex system emulation (PC)
+
+@menu
+* pcsys_devices::      Peripherals
+* cpu_models_x86::     CPU models
+* pcsys_req::          OS requirements
+@end menu
+
+@node pcsys_devices
+@subsection Peripherals
+
+@c man begin DESCRIPTION
+
+The QEMU PC System emulator simulates the following peripherals:
+
+@itemize @minus
+@item
+i440FX host PCI bridge and PIIX3 PCI to ISA bridge
+@item
+Cirrus CLGD 5446 PCI VGA card or dummy VGA card with Bochs VESA
+extensions (hardware level, including all non standard modes).
+@item
+PS/2 mouse and keyboard
+@item
+2 PCI IDE interfaces with hard disk and CD-ROM support
+@item
+Floppy disk
+@item
+PCI and ISA network adapters
+@item
+Serial ports
+@item
+IPMI BMC, either and internal or external one
+@item
+Creative SoundBlaster 16 sound card
+@item
+ENSONIQ AudioPCI ES1370 sound card
+@item
+Intel 82801AA AC97 Audio compatible sound card
+@item
+Intel HD Audio Controller and HDA codec
+@item
+Adlib (OPL2) - Yamaha YM3812 compatible chip
+@item
+Gravis Ultrasound GF1 sound card
+@item
+CS4231A compatible sound card
+@item
+PCI UHCI, OHCI, EHCI or XHCI USB controller and a virtual USB-1.1 hub.
+@end itemize
+
+SMP is supported with up to 255 CPUs.
+
+QEMU uses the PC BIOS from the Seabios project and the Plex86/Bochs LGPL
+VGA BIOS.
+
+QEMU uses YM3812 emulation by Tatsuyuki Satoh.
+
+QEMU uses GUS emulation (GUSEMU32 @url{http://www.deinmeister.de/gusemu/})
+by Tibor "TS" Schütz.
+
+Note that, by default, GUS shares IRQ(7) with parallel ports and so
+QEMU must be told to not have parallel ports to have working GUS.
+
+@example
+@value{qemu_system_x86} dos.img -soundhw gus -parallel none
+@end example
+
+Alternatively:
+@example
+@value{qemu_system_x86} dos.img -device gus,irq=5
+@end example
+
+Or some other unclaimed IRQ.
+
+CS4231A is the chip used in Windows Sound System and GUSMAX products
+
+@c man end
+
+@lowersections
+@include docs/system/cpu-models-x86.texi
+@raisesections
+
+@node pcsys_req
+@subsection OS requirements
+
+On x86_64 hosts, the default set of CPU features enabled by the KVM accelerator
+require the host to be running Linux v4.5 or newer.  Red Hat Enterprise Linux
+7 is also supported, since the required functionality was backported.
+
diff --git a/docs/system/target-m68k.texi b/docs/system/target-m68k.texi
new file mode 100644
index 00000000000..b5bc9df40ae
--- /dev/null
+++ b/docs/system/target-m68k.texi
@@ -0,0 +1,46 @@
+@node ColdFire System emulator
+@section ColdFire System emulator
+@cindex system emulation (ColdFire)
+@cindex system emulation (M68K)
+
+Use the executable @file{qemu-system-m68k} to simulate a ColdFire machine.
+The emulator is able to boot a uClinux kernel.
+
+The M5208EVB emulation includes the following devices:
+
+@itemize @minus
+@item
+MCF5208 ColdFire V2 Microprocessor (ISA A+ with EMAC).
+@item
+Three Two on-chip UARTs.
+@item
+Fast Ethernet Controller (FEC)
+@end itemize
+
+The AN5206 emulation includes the following devices:
+
+@itemize @minus
+@item
+MCF5206 ColdFire V2 Microprocessor.
+@item
+Two on-chip UARTs.
+@end itemize
+
+@c man begin OPTIONS
+
+The following options are specific to the ColdFire emulation:
+
+@table @option
+
+@item -semihosting
+Enable semihosting syscall emulation.
+
+On M68K this implements the "ColdFire GDB" interface used by libgloss.
+
+Note that this allows guest direct access to the host filesystem,
+so should only be used with trusted guest OS.
+
+@end table
+
+@c man end
+
diff --git a/docs/system/target-mips.texi b/docs/system/target-mips.texi
new file mode 100644
index 00000000000..f722c00912a
--- /dev/null
+++ b/docs/system/target-mips.texi
@@ -0,0 +1,152 @@
+@node MIPS System emulator
+@section MIPS System emulator
+@cindex system emulation (MIPS)
+
+@menu
+* recommendations_cpu_models_MIPS:: Supported CPU model configurations on MIPS hosts
+* nanoMIPS System emulator ::
+@end menu
+
+Four executables cover simulation of 32 and 64-bit MIPS systems in
+both endian options, @file{qemu-system-mips}, @file{qemu-system-mipsel}
+@file{qemu-system-mips64} and @file{qemu-system-mips64el}.
+Five different machine types are emulated:
+
+@itemize @minus
+@item
+A generic ISA PC-like machine "mips"
+@item
+The MIPS Malta prototype board "malta"
+@item
+An ACER Pica "pica61". This machine needs the 64-bit emulator.
+@item
+MIPS emulator pseudo board "mipssim"
+@item
+A MIPS Magnum R4000 machine "magnum". This machine needs the 64-bit emulator.
+@end itemize
+
+The generic emulation is supported by Debian 'Etch' and is able to
+install Debian into a virtual disk image. The following devices are
+emulated:
+
+@itemize @minus
+@item
+A range of MIPS CPUs, default is the 24Kf
+@item
+PC style serial port
+@item
+PC style IDE disk
+@item
+NE2000 network card
+@end itemize
+
+The Malta emulation supports the following devices:
+
+@itemize @minus
+@item
+Core board with MIPS 24Kf CPU and Galileo system controller
+@item
+PIIX4 PCI/USB/SMbus controller
+@item
+The Multi-I/O chip's serial device
+@item
+PCI network cards (PCnet32 and others)
+@item
+Malta FPGA serial device
+@item
+Cirrus (default) or any other PCI VGA graphics card
+@end itemize
+
+The Boston board emulation supports the following devices:
+
+@itemize @minus
+@item
+Xilinx FPGA, which includes a PCIe root port and an UART
+@item
+Intel EG20T PCH connects the I/O peripherals, but only the SATA bus is emulated
+@end itemize
+
+The ACER Pica emulation supports:
+
+@itemize @minus
+@item
+MIPS R4000 CPU
+@item
+PC-style IRQ and DMA controllers
+@item
+PC Keyboard
+@item
+IDE controller
+@end itemize
+
+The MIPS Magnum R4000 emulation supports:
+
+@itemize @minus
+@item
+MIPS R4000 CPU
+@item
+PC-style IRQ controller
+@item
+PC Keyboard
+@item
+SCSI controller
+@item
+G364 framebuffer
+@end itemize
+
+The Fulong 2E emulation supports:
+
+@itemize @minus
+@item
+Loongson 2E CPU
+@item
+Bonito64 system controller as North Bridge
+@item
+VT82C686 chipset as South Bridge
+@item
+RTL8139D as a network card chipset
+@end itemize
+
+The mipssim pseudo board emulation provides an environment similar
+to what the proprietary MIPS emulator uses for running Linux.
+It supports:
+
+@itemize @minus
+@item
+A range of MIPS CPUs, default is the 24Kf
+@item
+PC style serial port
+@item
+MIPSnet network emulation
+@end itemize
+
+@lowersections
+@include docs/system/cpu-models-mips.texi
+@raisesections
+
+@node nanoMIPS System emulator
+@subsection nanoMIPS System emulator
+@cindex system emulation (nanoMIPS)
+
+Executable @file{qemu-system-mipsel} also covers simulation of
+32-bit nanoMIPS system in little endian mode:
+
+@itemize @minus
+@item
+nanoMIPS I7200 CPU
+@end itemize
+
+Example of @file{qemu-system-mipsel} usage for nanoMIPS is shown below:
+
+Download @code{<disk_image_file>} from @url{https://mipsdistros.mips.com/LinuxDistro/nanomips/buildroot/index.html}.
+
+Download @code{<kernel_image_file>} from @url{https://mipsdistros.mips.com/LinuxDistro/nanomips/kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/index.html}.
+
+Start system emulation of Malta board with nanoMIPS I7200 CPU:
+@example
+qemu-system-mipsel -cpu I7200 -kernel @code{<kernel_image_file>} \
+    -M malta -serial stdio -m @code{<memory_size>} -hda @code{<disk_image_file>} \
+    -append "mem=256m@@0x0 rw console=ttyS0 vga=cirrus vesa=0x111 root=/dev/sda"
+@end example
+
+
diff --git a/docs/system/target-ppc.texi b/docs/system/target-ppc.texi
new file mode 100644
index 00000000000..c2c254d3d23
--- /dev/null
+++ b/docs/system/target-ppc.texi
@@ -0,0 +1,78 @@
+@node PowerPC System emulator
+@section PowerPC System emulator
+@cindex system emulation (PowerPC)
+
+Use the executable @file{qemu-system-ppc} to simulate a complete 40P (PREP)
+or PowerMac PowerPC system.
+
+QEMU emulates the following PowerMac peripherals:
+
+@itemize @minus
+@item
+UniNorth or Grackle PCI Bridge
+@item
+PCI VGA compatible card with VESA Bochs Extensions
+@item
+2 PMAC IDE interfaces with hard disk and CD-ROM support
+@item
+NE2000 PCI adapters
+@item
+Non Volatile RAM
+@item
+VIA-CUDA with ADB keyboard and mouse.
+@end itemize
+
+QEMU emulates the following 40P (PREP) peripherals:
+
+@itemize @minus
+@item
+PCI Bridge
+@item
+PCI VGA compatible card with VESA Bochs Extensions
+@item
+2 IDE interfaces with hard disk and CD-ROM support
+@item
+Floppy disk
+@item
+PCnet network adapters
+@item
+Serial port
+@item
+PREP Non Volatile RAM
+@item
+PC compatible keyboard and mouse.
+@end itemize
+
+Since version 0.9.1, QEMU uses OpenBIOS @url{https://www.openbios.org/}
+for the g3beige and mac99 PowerMac and the 40p machines. OpenBIOS is a free
+(GPL v2) portable firmware implementation. The goal is to implement a 100%
+IEEE 1275-1994 (referred to as Open Firmware) compliant firmware.
+
+@c man begin OPTIONS
+
+The following options are specific to the PowerPC emulation:
+
+@table @option
+
+@item -g @var{W}x@var{H}[x@var{DEPTH}]
+
+Set the initial VGA graphic mode. The default is 800x600x32.
+
+@item -prom-env @var{string}
+
+Set OpenBIOS variables in NVRAM, for example:
+
+@example
+qemu-system-ppc -prom-env 'auto-boot?=false' \
+ -prom-env 'boot-device=hd:2,\yaboot' \
+ -prom-env 'boot-args=conf=hd:2,\yaboot.conf'
+@end example
+
+@end table
+
+@c man end
+
+
+More information is available at
+@url{http://perso.magic.fr/l_indien/qemu-ppc/}.
+
diff --git a/docs/system/target-sparc.texi b/docs/system/target-sparc.texi
new file mode 100644
index 00000000000..7fe0aec9c39
--- /dev/null
+++ b/docs/system/target-sparc.texi
@@ -0,0 +1,96 @@
+@node Sparc32 System emulator
+@section Sparc32 System emulator
+@cindex system emulation (Sparc32)
+
+Use the executable @file{qemu-system-sparc} to simulate the following
+Sun4m architecture machines:
+@itemize @minus
+@item
+SPARCstation 4
+@item
+SPARCstation 5
+@item
+SPARCstation 10
+@item
+SPARCstation 20
+@item
+SPARCserver 600MP
+@item
+SPARCstation LX
+@item
+SPARCstation Voyager
+@item
+SPARCclassic
+@item
+SPARCbook
+@end itemize
+
+The emulation is somewhat complete. SMP up to 16 CPUs is supported,
+but Linux limits the number of usable CPUs to 4.
+
+QEMU emulates the following sun4m peripherals:
+
+@itemize @minus
+@item
+IOMMU
+@item
+TCX or cgthree Frame buffer
+@item
+Lance (Am7990) Ethernet
+@item
+Non Volatile RAM M48T02/M48T08
+@item
+Slave I/O: timers, interrupt controllers, Zilog serial ports, keyboard
+and power/reset logic
+@item
+ESP SCSI controller with hard disk and CD-ROM support
+@item
+Floppy drive (not on SS-600MP)
+@item
+CS4231 sound device (only on SS-5, not working yet)
+@end itemize
+
+The number of peripherals is fixed in the architecture.  Maximum
+memory size depends on the machine type, for SS-5 it is 256MB and for
+others 2047MB.
+
+Since version 0.8.2, QEMU uses OpenBIOS
+@url{https://www.openbios.org/}. OpenBIOS is a free (GPL v2) portable
+firmware implementation. The goal is to implement a 100% IEEE
+1275-1994 (referred to as Open Firmware) compliant firmware.
+
+A sample Linux 2.6 series kernel and ram disk image are available on
+the QEMU web site. There are still issues with NetBSD and OpenBSD, but
+most kernel versions work. Please note that currently older Solaris kernels
+don't work probably due to interface issues between OpenBIOS and
+Solaris.
+
+@c man begin OPTIONS
+
+The following options are specific to the Sparc32 emulation:
+
+@table @option
+
+@item -g @var{W}x@var{H}x[x@var{DEPTH}]
+
+Set the initial graphics mode. For TCX, the default is 1024x768x8 with the
+option of 1024x768x24. For cgthree, the default is 1024x768x8 with the option
+of 1152x900x8 for people who wish to use OBP.
+
+@item -prom-env @var{string}
+
+Set OpenBIOS variables in NVRAM, for example:
+
+@example
+qemu-system-sparc -prom-env 'auto-boot?=false' \
+ -prom-env 'boot-device=sd(0,2,0):d' -prom-env 'boot-args=linux single'
+@end example
+
+@item -M [SS-4|SS-5|SS-10|SS-20|SS-600MP|LX|Voyager|SPARCClassic] [|SPARCbook]
+
+Set the emulated machine type. Default is SS-5.
+
+@end table
+
+@c man end
+
diff --git a/docs/system/target-sparc64.texi b/docs/system/target-sparc64.texi
new file mode 100644
index 00000000000..9e7a27de0ce
--- /dev/null
+++ b/docs/system/target-sparc64.texi
@@ -0,0 +1,61 @@
+@node Sparc64 System emulator
+@section Sparc64 System emulator
+@cindex system emulation (Sparc64)
+
+Use the executable @file{qemu-system-sparc64} to simulate a Sun4u
+(UltraSPARC PC-like machine), Sun4v (T1 PC-like machine), or generic
+Niagara (T1) machine. The Sun4u emulator is mostly complete, being
+able to run Linux, NetBSD and OpenBSD in headless (-nographic) mode. The
+Sun4v emulator is still a work in progress.
+
+The Niagara T1 emulator makes use of firmware and OS binaries supplied in the S10image/ directory
+of the OpenSPARC T1 project @url{http://download.oracle.com/technetwork/systems/opensparc/OpenSPARCT1_Arch.1.5.tar.bz2}
+and is able to boot the disk.s10hw2 Solaris image.
+@example
+qemu-system-sparc64 -M niagara -L /path-to/S10image/ \
+                    -nographic -m 256 \
+                    -drive if=pflash,readonly=on,file=/S10image/disk.s10hw2
+@end example
+
+
+QEMU emulates the following peripherals:
+
+@itemize @minus
+@item
+UltraSparc IIi APB PCI Bridge
+@item
+PCI VGA compatible card with VESA Bochs Extensions
+@item
+PS/2 mouse and keyboard
+@item
+Non Volatile RAM M48T59
+@item
+PC-compatible serial ports
+@item
+2 PCI IDE interfaces with hard disk and CD-ROM support
+@item
+Floppy disk
+@end itemize
+
+@c man begin OPTIONS
+
+The following options are specific to the Sparc64 emulation:
+
+@table @option
+
+@item -prom-env @var{string}
+
+Set OpenBIOS variables in NVRAM, for example:
+
+@example
+qemu-system-sparc64 -prom-env 'auto-boot?=false'
+@end example
+
+@item -M [sun4u|sun4v|niagara]
+
+Set the emulated machine type. The default is sun4u.
+
+@end table
+
+@c man end
+
diff --git a/docs/system/target-xtensa.texi b/docs/system/target-xtensa.texi
new file mode 100644
index 00000000000..08b0b362991
--- /dev/null
+++ b/docs/system/target-xtensa.texi
@@ -0,0 +1,56 @@
+@node Xtensa System emulator
+@section Xtensa System emulator
+@cindex system emulation (Xtensa)
+
+Two executables cover simulation of both Xtensa endian options,
+@file{qemu-system-xtensa} and @file{qemu-system-xtensaeb}.
+Two different machine types are emulated:
+
+@itemize @minus
+@item
+Xtensa emulator pseudo board "sim"
+@item
+Avnet LX60/LX110/LX200 board
+@end itemize
+
+The sim pseudo board emulation provides an environment similar
+to one provided by the proprietary Tensilica ISS.
+It supports:
+
+@itemize @minus
+@item
+A range of Xtensa CPUs, default is the DC232B
+@item
+Console and filesystem access via semihosting calls
+@end itemize
+
+The Avnet LX60/LX110/LX200 emulation supports:
+
+@itemize @minus
+@item
+A range of Xtensa CPUs, default is the DC232B
+@item
+16550 UART
+@item
+OpenCores 10/100 Mbps Ethernet MAC
+@end itemize
+
+@c man begin OPTIONS
+
+The following options are specific to the Xtensa emulation:
+
+@table @option
+
+@item -semihosting
+Enable semihosting syscall emulation.
+
+Xtensa semihosting provides basic file IO calls, such as open/read/write/seek/select.
+Tensilica baremetal libc for ISS and linux platform "sim" use this interface.
+
+Note that this allows guest direct access to the host filesystem,
+so should only be used with trusted guest OS.
+
+@end table
+
+@c man end
+
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 40fab523f35..f702dce4557 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -176,874 +176,17 @@ various targets are mentioned in the following sections.
 * MIPS System emulator::
 * ARM System emulator::
 * ColdFire System emulator::
-* Cris System emulator::
-* Microblaze System emulator::
-* SH4 System emulator::
 * Xtensa System emulator::
 @end menu
 
-@node x86 (PC) System emulator
-@section x86 (PC) System emulator
-@cindex system emulation (PC)
-
-@menu
-* pcsys_devices::      Peripherals
-* cpu_models_x86::     Supported CPU model configurations on x86 hosts
-* pcsys_req::          OS requirements
-@end menu
-
-@node pcsys_devices
-@subsection Peripherals
-
-@c man begin DESCRIPTION
-
-The QEMU PC System emulator simulates the following peripherals:
-
-@itemize @minus
-@item
-i440FX host PCI bridge and PIIX3 PCI to ISA bridge
-@item
-Cirrus CLGD 5446 PCI VGA card or dummy VGA card with Bochs VESA
-extensions (hardware level, including all non standard modes).
-@item
-PS/2 mouse and keyboard
-@item
-2 PCI IDE interfaces with hard disk and CD-ROM support
-@item
-Floppy disk
-@item
-PCI and ISA network adapters
-@item
-Serial ports
-@item
-IPMI BMC, either and internal or external one
-@item
-Creative SoundBlaster 16 sound card
-@item
-ENSONIQ AudioPCI ES1370 sound card
-@item
-Intel 82801AA AC97 Audio compatible sound card
-@item
-Intel HD Audio Controller and HDA codec
-@item
-Adlib (OPL2) - Yamaha YM3812 compatible chip
-@item
-Gravis Ultrasound GF1 sound card
-@item
-CS4231A compatible sound card
-@item
-PCI UHCI, OHCI, EHCI or XHCI USB controller and a virtual USB-1.1 hub.
-@end itemize
-
-SMP is supported with up to 255 CPUs.
-
-QEMU uses the PC BIOS from the Seabios project and the Plex86/Bochs LGPL
-VGA BIOS.
-
-QEMU uses YM3812 emulation by Tatsuyuki Satoh.
-
-QEMU uses GUS emulation (GUSEMU32 @url{http://www.deinmeister.de/gusemu/})
-by Tibor "TS" Schütz.
-
-Note that, by default, GUS shares IRQ(7) with parallel ports and so
-QEMU must be told to not have parallel ports to have working GUS.
-
-@example
-@value{qemu_system_x86} dos.img -soundhw gus -parallel none
-@end example
-
-Alternatively:
-@example
-@value{qemu_system_x86} dos.img -device gus,irq=5
-@end example
-
-Or some other unclaimed IRQ.
-
-CS4231A is the chip used in Windows Sound System and GUSMAX products
-
-@c man end
-
-@lowersections
-@include docs/system/cpu-models-x86.texi
-@raisesections
-
-@node pcsys_req
-@subsection OS requirements
-
-On x86_64 hosts, the default set of CPU features enabled by the KVM accelerator
-require the host to be running Linux v4.5 or newer.  Red Hat Enterprise Linux
-7 is also supported, since the required functionality was backported.
-
-@node PowerPC System emulator
-@section PowerPC System emulator
-@cindex system emulation (PowerPC)
-
-Use the executable @file{qemu-system-ppc} to simulate a complete 40P (PREP)
-or PowerMac PowerPC system.
-
-QEMU emulates the following PowerMac peripherals:
-
-@itemize @minus
-@item
-UniNorth or Grackle PCI Bridge
-@item
-PCI VGA compatible card with VESA Bochs Extensions
-@item
-2 PMAC IDE interfaces with hard disk and CD-ROM support
-@item
-NE2000 PCI adapters
-@item
-Non Volatile RAM
-@item
-VIA-CUDA with ADB keyboard and mouse.
-@end itemize
-
-QEMU emulates the following 40P (PREP) peripherals:
-
-@itemize @minus
-@item
-PCI Bridge
-@item
-PCI VGA compatible card with VESA Bochs Extensions
-@item
-2 IDE interfaces with hard disk and CD-ROM support
-@item
-Floppy disk
-@item
-PCnet network adapters
-@item
-Serial port
-@item
-PREP Non Volatile RAM
-@item
-PC compatible keyboard and mouse.
-@end itemize
-
-Since version 0.9.1, QEMU uses OpenBIOS @url{https://www.openbios.org/}
-for the g3beige and mac99 PowerMac and the 40p machines. OpenBIOS is a free
-(GPL v2) portable firmware implementation. The goal is to implement a 100%
-IEEE 1275-1994 (referred to as Open Firmware) compliant firmware.
-
-@c man begin OPTIONS
-
-The following options are specific to the PowerPC emulation:
-
-@table @option
-
-@item -g @var{W}x@var{H}[x@var{DEPTH}]
-
-Set the initial VGA graphic mode. The default is 800x600x32.
-
-@item -prom-env @var{string}
-
-Set OpenBIOS variables in NVRAM, for example:
-
-@example
-qemu-system-ppc -prom-env 'auto-boot?=false' \
- -prom-env 'boot-device=hd:2,\yaboot' \
- -prom-env 'boot-args=conf=hd:2,\yaboot.conf'
-@end example
-
-@end table
-
-@c man end
-
-
-More information is available at
-@url{http://perso.magic.fr/l_indien/qemu-ppc/}.
-
-@node Sparc32 System emulator
-@section Sparc32 System emulator
-@cindex system emulation (Sparc32)
-
-Use the executable @file{qemu-system-sparc} to simulate the following
-Sun4m architecture machines:
-@itemize @minus
-@item
-SPARCstation 4
-@item
-SPARCstation 5
-@item
-SPARCstation 10
-@item
-SPARCstation 20
-@item
-SPARCserver 600MP
-@item
-SPARCstation LX
-@item
-SPARCstation Voyager
-@item
-SPARCclassic
-@item
-SPARCbook
-@end itemize
-
-The emulation is somewhat complete. SMP up to 16 CPUs is supported,
-but Linux limits the number of usable CPUs to 4.
-
-QEMU emulates the following sun4m peripherals:
-
-@itemize @minus
-@item
-IOMMU
-@item
-TCX or cgthree Frame buffer
-@item
-Lance (Am7990) Ethernet
-@item
-Non Volatile RAM M48T02/M48T08
-@item
-Slave I/O: timers, interrupt controllers, Zilog serial ports, keyboard
-and power/reset logic
-@item
-ESP SCSI controller with hard disk and CD-ROM support
-@item
-Floppy drive (not on SS-600MP)
-@item
-CS4231 sound device (only on SS-5, not working yet)
-@end itemize
-
-The number of peripherals is fixed in the architecture.  Maximum
-memory size depends on the machine type, for SS-5 it is 256MB and for
-others 2047MB.
-
-Since version 0.8.2, QEMU uses OpenBIOS
-@url{https://www.openbios.org/}. OpenBIOS is a free (GPL v2) portable
-firmware implementation. The goal is to implement a 100% IEEE
-1275-1994 (referred to as Open Firmware) compliant firmware.
-
-A sample Linux 2.6 series kernel and ram disk image are available on
-the QEMU web site. There are still issues with NetBSD and OpenBSD, but
-most kernel versions work. Please note that currently older Solaris kernels
-don't work probably due to interface issues between OpenBIOS and
-Solaris.
-
-@c man begin OPTIONS
-
-The following options are specific to the Sparc32 emulation:
-
-@table @option
-
-@item -g @var{W}x@var{H}x[x@var{DEPTH}]
-
-Set the initial graphics mode. For TCX, the default is 1024x768x8 with the
-option of 1024x768x24. For cgthree, the default is 1024x768x8 with the option
-of 1152x900x8 for people who wish to use OBP.
-
-@item -prom-env @var{string}
-
-Set OpenBIOS variables in NVRAM, for example:
-
-@example
-qemu-system-sparc -prom-env 'auto-boot?=false' \
- -prom-env 'boot-device=sd(0,2,0):d' -prom-env 'boot-args=linux single'
-@end example
-
-@item -M [SS-4|SS-5|SS-10|SS-20|SS-600MP|LX|Voyager|SPARCClassic] [|SPARCbook]
-
-Set the emulated machine type. Default is SS-5.
-
-@end table
-
-@c man end
-
-@node Sparc64 System emulator
-@section Sparc64 System emulator
-@cindex system emulation (Sparc64)
-
-Use the executable @file{qemu-system-sparc64} to simulate a Sun4u
-(UltraSPARC PC-like machine), Sun4v (T1 PC-like machine), or generic
-Niagara (T1) machine. The Sun4u emulator is mostly complete, being
-able to run Linux, NetBSD and OpenBSD in headless (-nographic) mode. The
-Sun4v emulator is still a work in progress.
-
-The Niagara T1 emulator makes use of firmware and OS binaries supplied in the S10image/ directory
-of the OpenSPARC T1 project @url{http://download.oracle.com/technetwork/systems/opensparc/OpenSPARCT1_Arch.1.5.tar.bz2}
-and is able to boot the disk.s10hw2 Solaris image.
-@example
-qemu-system-sparc64 -M niagara -L /path-to/S10image/ \
-                    -nographic -m 256 \
-                    -drive if=pflash,readonly=on,file=/S10image/disk.s10hw2
-@end example
-
-
-QEMU emulates the following peripherals:
-
-@itemize @minus
-@item
-UltraSparc IIi APB PCI Bridge
-@item
-PCI VGA compatible card with VESA Bochs Extensions
-@item
-PS/2 mouse and keyboard
-@item
-Non Volatile RAM M48T59
-@item
-PC-compatible serial ports
-@item
-2 PCI IDE interfaces with hard disk and CD-ROM support
-@item
-Floppy disk
-@end itemize
-
-@c man begin OPTIONS
-
-The following options are specific to the Sparc64 emulation:
-
-@table @option
-
-@item -prom-env @var{string}
-
-Set OpenBIOS variables in NVRAM, for example:
-
-@example
-qemu-system-sparc64 -prom-env 'auto-boot?=false'
-@end example
-
-@item -M [sun4u|sun4v|niagara]
-
-Set the emulated machine type. The default is sun4u.
-
-@end table
-
-@c man end
-
-@node MIPS System emulator
-@section MIPS System emulator
-@cindex system emulation (MIPS)
-
-@menu
-* recommendations_cpu_models_MIPS:: Supported CPU model configurations on MIPS hosts
-* nanoMIPS System emulator ::
-@end menu
-
-Four executables cover simulation of 32 and 64-bit MIPS systems in
-both endian options, @file{qemu-system-mips}, @file{qemu-system-mipsel}
-@file{qemu-system-mips64} and @file{qemu-system-mips64el}.
-Five different machine types are emulated:
-
-@itemize @minus
-@item
-A generic ISA PC-like machine "mips"
-@item
-The MIPS Malta prototype board "malta"
-@item
-An ACER Pica "pica61". This machine needs the 64-bit emulator.
-@item
-MIPS emulator pseudo board "mipssim"
-@item
-A MIPS Magnum R4000 machine "magnum". This machine needs the 64-bit emulator.
-@end itemize
-
-The generic emulation is supported by Debian 'Etch' and is able to
-install Debian into a virtual disk image. The following devices are
-emulated:
-
-@itemize @minus
-@item
-A range of MIPS CPUs, default is the 24Kf
-@item
-PC style serial port
-@item
-PC style IDE disk
-@item
-NE2000 network card
-@end itemize
-
-The Malta emulation supports the following devices:
-
-@itemize @minus
-@item
-Core board with MIPS 24Kf CPU and Galileo system controller
-@item
-PIIX4 PCI/USB/SMbus controller
-@item
-The Multi-I/O chip's serial device
-@item
-PCI network cards (PCnet32 and others)
-@item
-Malta FPGA serial device
-@item
-Cirrus (default) or any other PCI VGA graphics card
-@end itemize
-
-The Boston board emulation supports the following devices:
-
-@itemize @minus
-@item
-Xilinx FPGA, which includes a PCIe root port and an UART
-@item
-Intel EG20T PCH connects the I/O peripherals, but only the SATA bus is emulated
-@end itemize
-
-The ACER Pica emulation supports:
-
-@itemize @minus
-@item
-MIPS R4000 CPU
-@item
-PC-style IRQ and DMA controllers
-@item
-PC Keyboard
-@item
-IDE controller
-@end itemize
-
-The MIPS Magnum R4000 emulation supports:
-
-@itemize @minus
-@item
-MIPS R4000 CPU
-@item
-PC-style IRQ controller
-@item
-PC Keyboard
-@item
-SCSI controller
-@item
-G364 framebuffer
-@end itemize
-
-The Fulong 2E emulation supports:
-
-@itemize @minus
-@item
-Loongson 2E CPU
-@item
-Bonito64 system controller as North Bridge
-@item
-VT82C686 chipset as South Bridge
-@item
-RTL8139D as a network card chipset
-@end itemize
-
-The mipssim pseudo board emulation provides an environment similar
-to what the proprietary MIPS emulator uses for running Linux.
-It supports:
-
-@itemize @minus
-@item
-A range of MIPS CPUs, default is the 24Kf
-@item
-PC style serial port
-@item
-MIPSnet network emulation
-@end itemize
-
-@lowersections
-@include docs/system/cpu-models-mips.texi
-@raisesections
-
-@node nanoMIPS System emulator
-@subsection nanoMIPS System emulator
-@cindex system emulation (nanoMIPS)
-
-Executable @file{qemu-system-mipsel} also covers simulation of
-32-bit nanoMIPS system in little endian mode:
-
-@itemize @minus
-@item
-nanoMIPS I7200 CPU
-@end itemize
-
-Example of @file{qemu-system-mipsel} usage for nanoMIPS is shown below:
-
-Download @code{<disk_image_file>} from @url{https://mipsdistros.mips.com/LinuxDistro/nanomips/buildroot/index.html}.
-
-Download @code{<kernel_image_file>} from @url{https://mipsdistros.mips.com/LinuxDistro/nanomips/kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/index.html}.
-
-Start system emulation of Malta board with nanoMIPS I7200 CPU:
-@example
-qemu-system-mipsel -cpu I7200 -kernel @code{<kernel_image_file>} \
-    -M malta -serial stdio -m @code{<memory_size>} -hda @code{<disk_image_file>} \
-    -append "mem=256m@@0x0 rw console=ttyS0 vga=cirrus vesa=0x111 root=/dev/sda"
-@end example
-
-
-@node ARM System emulator
-@section ARM System emulator
-@cindex system emulation (ARM)
-
-Use the executable @file{qemu-system-arm} to simulate a ARM
-machine. The ARM Integrator/CP board is emulated with the following
-devices:
-
-@itemize @minus
-@item
-ARM926E, ARM1026E, ARM946E, ARM1136 or Cortex-A8 CPU
-@item
-Two PL011 UARTs
-@item
-SMC 91c111 Ethernet adapter
-@item
-PL110 LCD controller
-@item
-PL050 KMI with PS/2 keyboard and mouse.
-@item
-PL181 MultiMedia Card Interface with SD card.
-@end itemize
-
-The ARM Versatile baseboard is emulated with the following devices:
-
-@itemize @minus
-@item
-ARM926E, ARM1136 or Cortex-A8 CPU
-@item
-PL190 Vectored Interrupt Controller
-@item
-Four PL011 UARTs
-@item
-SMC 91c111 Ethernet adapter
-@item
-PL110 LCD controller
-@item
-PL050 KMI with PS/2 keyboard and mouse.
-@item
-PCI host bridge.  Note the emulated PCI bridge only provides access to
-PCI memory space.  It does not provide access to PCI IO space.
-This means some devices (eg. ne2k_pci NIC) are not usable, and others
-(eg. rtl8139 NIC) are only usable when the guest drivers use the memory
-mapped control registers.
-@item
-PCI OHCI USB controller.
-@item
-LSI53C895A PCI SCSI Host Bus Adapter with hard disk and CD-ROM devices.
-@item
-PL181 MultiMedia Card Interface with SD card.
-@end itemize
-
-Several variants of the ARM RealView baseboard are emulated,
-including the EB, PB-A8 and PBX-A9.  Due to interactions with the
-bootloader, only certain Linux kernel configurations work out
-of the box on these boards.
-
-Kernels for the PB-A8 board should have CONFIG_REALVIEW_HIGH_PHYS_OFFSET
-enabled in the kernel, and expect 512M RAM.  Kernels for The PBX-A9 board
-should have CONFIG_SPARSEMEM enabled, CONFIG_REALVIEW_HIGH_PHYS_OFFSET
-disabled and expect 1024M RAM.
-
-The following devices are emulated:
-
-@itemize @minus
-@item
-ARM926E, ARM1136, ARM11MPCore, Cortex-A8 or Cortex-A9 MPCore CPU
-@item
-ARM AMBA Generic/Distributed Interrupt Controller
-@item
-Four PL011 UARTs
-@item
-SMC 91c111 or SMSC LAN9118 Ethernet adapter
-@item
-PL110 LCD controller
-@item
-PL050 KMI with PS/2 keyboard and mouse
-@item
-PCI host bridge
-@item
-PCI OHCI USB controller
-@item
-LSI53C895A PCI SCSI Host Bus Adapter with hard disk and CD-ROM devices
-@item
-PL181 MultiMedia Card Interface with SD card.
-@end itemize
-
-The XScale-based clamshell PDA models ("Spitz", "Akita", "Borzoi"
-and "Terrier") emulation includes the following peripherals:
-
-@itemize @minus
-@item
-Intel PXA270 System-on-chip (ARM V5TE core)
-@item
-NAND Flash memory
-@item
-IBM/Hitachi DSCM microdrive in a PXA PCMCIA slot - not in "Akita"
-@item
-On-chip OHCI USB controller
-@item
-On-chip LCD controller
-@item
-On-chip Real Time Clock
-@item
-TI ADS7846 touchscreen controller on SSP bus
-@item
-Maxim MAX1111 analog-digital converter on I@math{^2}C bus
-@item
-GPIO-connected keyboard controller and LEDs
-@item
-Secure Digital card connected to PXA MMC/SD host
-@item
-Three on-chip UARTs
-@item
-WM8750 audio CODEC on I@math{^2}C and I@math{^2}S busses
-@end itemize
-
-The Palm Tungsten|E PDA (codename "Cheetah") emulation includes the
-following elements:
-
-@itemize @minus
-@item
-Texas Instruments OMAP310 System-on-chip (ARM 925T core)
-@item
-ROM and RAM memories (ROM firmware image can be loaded with -option-rom)
-@item
-On-chip LCD controller
-@item
-On-chip Real Time Clock
-@item
-TI TSC2102i touchscreen controller / analog-digital converter / Audio
-CODEC, connected through MicroWire and I@math{^2}S busses
-@item
-GPIO-connected matrix keypad
-@item
-Secure Digital card connected to OMAP MMC/SD host
-@item
-Three on-chip UARTs
-@end itemize
-
-Nokia N800 and N810 internet tablets (known also as RX-34 and RX-44 / 48)
-emulation supports the following elements:
-
-@itemize @minus
-@item
-Texas Instruments OMAP2420 System-on-chip (ARM 1136 core)
-@item
-RAM and non-volatile OneNAND Flash memories
-@item
-Display connected to EPSON remote framebuffer chip and OMAP on-chip
-display controller and a LS041y3 MIPI DBI-C controller
-@item
-TI TSC2301 (in N800) and TI TSC2005 (in N810) touchscreen controllers
-driven through SPI bus
-@item
-National Semiconductor LM8323-controlled qwerty keyboard driven
-through I@math{^2}C bus
-@item
-Secure Digital card connected to OMAP MMC/SD host
-@item
-Three OMAP on-chip UARTs and on-chip STI debugging console
-@item
-Mentor Graphics "Inventra" dual-role USB controller embedded in a TI
-TUSB6010 chip - only USB host mode is supported
-@item
-TI TMP105 temperature sensor driven through I@math{^2}C bus
-@item
-TI TWL92230C power management companion with an RTC on I@math{^2}C bus
-@item
-Nokia RETU and TAHVO multi-purpose chips with an RTC, connected
-through CBUS
-@end itemize
-
-The Luminary Micro Stellaris LM3S811EVB emulation includes the following
-devices:
-
-@itemize @minus
-@item
-Cortex-M3 CPU core.
-@item
-64k Flash and 8k SRAM.
-@item
-Timers, UARTs, ADC and I@math{^2}C interface.
-@item
-OSRAM Pictiva 96x16 OLED with SSD0303 controller on I@math{^2}C bus.
-@end itemize
-
-The Luminary Micro Stellaris LM3S6965EVB emulation includes the following
-devices:
-
-@itemize @minus
-@item
-Cortex-M3 CPU core.
-@item
-256k Flash and 64k SRAM.
-@item
-Timers, UARTs, ADC, I@math{^2}C and SSI interfaces.
-@item
-OSRAM Pictiva 128x64 OLED with SSD0323 controller connected via SSI.
-@end itemize
-
-The Freecom MusicPal internet radio emulation includes the following
-elements:
-
-@itemize @minus
-@item
-Marvell MV88W8618 ARM core.
-@item
-32 MB RAM, 256 KB SRAM, 8 MB flash.
-@item
-Up to 2 16550 UARTs
-@item
-MV88W8xx8 Ethernet controller
-@item
-MV88W8618 audio controller, WM8750 CODEC and mixer
-@item
-128×64 display with brightness control
-@item
-2 buttons, 2 navigation wheels with button function
-@end itemize
-
-The Siemens SX1 models v1 and v2 (default) basic emulation.
-The emulation includes the following elements:
-
-@itemize @minus
-@item
-Texas Instruments OMAP310 System-on-chip (ARM 925T core)
-@item
-ROM and RAM memories (ROM firmware image can be loaded with -pflash)
-V1
-1 Flash of 16MB and 1 Flash of 8MB
-V2
-1 Flash of 32MB
-@item
-On-chip LCD controller
-@item
-On-chip Real Time Clock
-@item
-Secure Digital card connected to OMAP MMC/SD host
-@item
-Three on-chip UARTs
-@end itemize
-
-A Linux 2.6 test image is available on the QEMU web site. More
-information is available in the QEMU mailing-list archive.
-
-@c man begin OPTIONS
-
-The following options are specific to the ARM emulation:
-
-@table @option
-
-@item -semihosting
-Enable semihosting syscall emulation.
-
-On ARM this implements the "Angel" interface.
-
-Note that this allows guest direct access to the host filesystem,
-so should only be used with trusted guest OS.
-
-@end table
-
-@c man end
-
-@node ColdFire System emulator
-@section ColdFire System emulator
-@cindex system emulation (ColdFire)
-@cindex system emulation (M68K)
-
-Use the executable @file{qemu-system-m68k} to simulate a ColdFire machine.
-The emulator is able to boot a uClinux kernel.
-
-The M5208EVB emulation includes the following devices:
-
-@itemize @minus
-@item
-MCF5208 ColdFire V2 Microprocessor (ISA A+ with EMAC).
-@item
-Three Two on-chip UARTs.
-@item
-Fast Ethernet Controller (FEC)
-@end itemize
-
-The AN5206 emulation includes the following devices:
-
-@itemize @minus
-@item
-MCF5206 ColdFire V2 Microprocessor.
-@item
-Two on-chip UARTs.
-@end itemize
-
-@c man begin OPTIONS
-
-The following options are specific to the ColdFire emulation:
-
-@table @option
-
-@item -semihosting
-Enable semihosting syscall emulation.
-
-On M68K this implements the "ColdFire GDB" interface used by libgloss.
-
-Note that this allows guest direct access to the host filesystem,
-so should only be used with trusted guest OS.
-
-@end table
-
-@c man end
-
-@node Cris System emulator
-@section Cris System emulator
-@cindex system emulation (Cris)
-
-TODO
-
-@node Microblaze System emulator
-@section Microblaze System emulator
-@cindex system emulation (Microblaze)
-
-TODO
-
-@node SH4 System emulator
-@section SH4 System emulator
-@cindex system emulation (SH4)
-
-TODO
-
-@node Xtensa System emulator
-@section Xtensa System emulator
-@cindex system emulation (Xtensa)
-
-Two executables cover simulation of both Xtensa endian options,
-@file{qemu-system-xtensa} and @file{qemu-system-xtensaeb}.
-Two different machine types are emulated:
-
-@itemize @minus
-@item
-Xtensa emulator pseudo board "sim"
-@item
-Avnet LX60/LX110/LX200 board
-@end itemize
-
-The sim pseudo board emulation provides an environment similar
-to one provided by the proprietary Tensilica ISS.
-It supports:
-
-@itemize @minus
-@item
-A range of Xtensa CPUs, default is the DC232B
-@item
-Console and filesystem access via semihosting calls
-@end itemize
-
-The Avnet LX60/LX110/LX200 emulation supports:
-
-@itemize @minus
-@item
-A range of Xtensa CPUs, default is the DC232B
-@item
-16550 UART
-@item
-OpenCores 10/100 Mbps Ethernet MAC
-@end itemize
-
-@c man begin OPTIONS
-
-The following options are specific to the Xtensa emulation:
-
-@table @option
-
-@item -semihosting
-Enable semihosting syscall emulation.
-
-Xtensa semihosting provides basic file IO calls, such as open/read/write/seek/select.
-Tensilica baremetal libc for ISS and linux platform "sim" use this interface.
-
-Note that this allows guest direct access to the host filesystem,
-so should only be used with trusted guest OS.
-
-@end table
-
-@c man end
+@include docs/system/target-i386.texi
+@include docs/system/target-ppc.texi
+@include docs/system/target-sparc.texi
+@include docs/system/target-sparc64.texi
+@include docs/system/target-mips.texi
+@include docs/system/target-arm.texi
+@include docs/system/target-m68k.texi
+@include docs/system/target-xtensa.texi
 
 @include docs/security.texi
 
-- 
2.20.1


