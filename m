Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF70C2D0C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 11:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F19AB206E4
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 11:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6nj5/bw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F19AB206E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iltF1-0007Qj-6d
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 06:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iltEE-0006ba-Ug
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 06:28:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iltEB-0004c9-PN
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 06:28:54 -0500
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:41573)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1iltEB-0004bW-FS; Mon, 30 Dec 2019 06:28:51 -0500
Received: by mail-il1-x143.google.com with SMTP id f10so27583709ils.8;
 Mon, 30 Dec 2019 03:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8CR/JzFbTBly2wjxWR88f/CmSC+C3LPoyCZNuYGI6Cs=;
 b=p6nj5/bwcHRrDH/2TW2KYPRm+Nc7LiZFvccv5J9j4awECvVnIXl1Po9pAPbeV7SkOB
 xJCgP12lkmdyXgv9yelMy3nWh6898hRqjdxg2hUGF62p2/RgonZbp2ANweWeLWh27Odf
 h3Ul302Gc1xZS3H4ySeb5g8xNeCwrRZqpYOAP7hoiQt5arxPkQrxtzOx9+4Ut5+FfTb0
 TKe53oEF5fWvwBJQxLweanE1SBKp5MiO7BtzILd/dWJOQ1Q29Ci39sUa5HIzff5vKVCS
 FeF5ro23KNYnpZHXhS+7WfMww/DdjlVWmMJe87hajK/gUKxzwjc2vJdPsXeUvX4KSYbL
 BJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8CR/JzFbTBly2wjxWR88f/CmSC+C3LPoyCZNuYGI6Cs=;
 b=SiAUt2+7pfXBhbr0c3j1C22WntBty4epQy6XoBNazIS1BHgUwU35ziUH7ZHgsE8gXN
 YaIdXXk8xcaMkxnrSgPbgOFKbXzIlPd7LXMwEnF5X7NM0Gfs6+by+Y8edGF8egJhJLt4
 f3QxI/anLfSxWgu3sfHjXLSdc5xFW90Cs6k6BWSRKSzZZpdRgFvn0naYKUBQ5mZ5vI1l
 xmxsgOvavzAtso4ppqS0FaWdV2QqADTcqJKRiZFmpp54+4/zSZHrxU1J4lp20wjhJtjj
 nhcsdoX/F/jF1V1nRftkYufk/l4lRjNFPMNFVRbKmQ9QQvmDEQTl05Np4X4Mzh3Butrb
 Qo/g==
X-Gm-Message-State: APjAAAWGgMfnpP734eAe0T0lzvQnH9ZELYDNSonkfh2RtTbVr3aqmr/V
 dQIyROI0h/3xC6M41NiNqAU/B0pW/A1WSru1g+INrC3Z
X-Google-Smtp-Source: APXvYqwL18LUSw75GoFSUeeKbzIcnZ6rjKZOYvJnKUFcsN7Ew8z91+ZCurG+SoSK3FpC5C4KXR7lVEwMcYAd/aYggJk=
X-Received: by 2002:a92:d5cf:: with SMTP id d15mr54563487ilq.306.1577705330014; 
 Mon, 30 Dec 2019 03:28:50 -0800 (PST)
MIME-Version: 1.0
References: <20191216233519.29030-1-nieklinnenbank@gmail.com>
In-Reply-To: <20191216233519.29030-1-nieklinnenbank@gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 30 Dec 2019 12:28:38 +0100
Message-ID: <CAPan3WpDbWb_cBMJPgokSLKAJndMQLvRdOav6CPpDbFv+ChN0g@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Add Allwinner H3 SoC and Orange Pi PC Machine
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000c17ee8059aea2500"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::143
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c17ee8059aea2500
Content-Type: text/plain; charset="UTF-8"

Hi,

Here a short status report of this patch series.

For V3 update I already prepared the following:
 - reworked all review comments from Philippe, except:
   - patch#8: question for the SID, whether command-line override is
required (and how is the best way for machine-specific cli arg?) [1]
- added BootROM support, allows booting with only specifying -sd <IMG>
- added SDRAM controller driver, for U-Boot SPL
- added Allwinner generic RTC driver (for both Cubieboard and OrangePi PC,
supports sun4i, sun6i, sun7i)
- small fixes for EMAC

My current TODO:
 - integrate Philips acceptance tests in the series
 - integrate Philips work for generalizing the Allwinner timer, and finish
it
 - test and fix BSD targets (NetBSD, FreeBSD) [2, 3]
 - further generalize the series to cover very similar SoCs: H2+, H5

Does anyone have more comments/requests for the V3 update?

[1] https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg04049.html
[2] https://wiki.netbsd.org/ports/evbarm/allwinner/
[3]
https://wiki.freebsd.org/action/show/arm/Allwinner?action=show&redirect=FreeBSD%2Farm%2FAllwinner

On Tue, Dec 17, 2019 at 12:35 AM Niek Linnenbank <nieklinnenbank@gmail.com>
wrote:

> Dear QEMU developers,
>
> Hereby I would like to contribute the following set of patches to QEMU
> which add support for the Allwinner H3 System on Chip and the
> Orange Pi PC machine. The following features and devices are supported:
>
>  * SMP (Quad Core Cortex A7)
>  * Generic Interrupt Controller configuration
>  * SRAM mappings
>  * Timer device (re-used from Allwinner A10)
>  * UART
>  * SD/MMC storage controller
>  * EMAC ethernet connectivity
>  * USB 2.0 interfaces
>  * Clock Control Unit
>  * System Control module
>  * Security Identifier device
>
> Functionality related to graphical output such as HDMI, GPU,
> Display Engine and audio are not included. Recently released
> mainline Linux kernels (4.19 up to latest master) and mainline U-Boot
> are known to work. The SD/MMC code is tested using bonnie++ and
> various tools such as fsck, dd and fdisk. The EMAC is verified with iperf3
> using -netdev socket.
>
> To build a Linux mainline kernel that can be booted by the Orange Pi PC
> machine, simply configure the kernel using the sunxi_defconfig
> configuration:
>  $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make mrproper
>  $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make sunxi_defconfig
>
> To be able to use USB storage, you need to manually enable the
> corresponding
> configuration item. Start the kconfig configuration tool:
>  $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make menuconfig
>
> Navigate to the following item, enable it and save your configuration:
>  Device Drivers > USB support > USB Mass Storage support
>
> Build the Linux kernel with:
>  $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make -j5
>
> To boot the newly build linux kernel in QEMU with the Orange Pi PC
> machine, use:
>  $ qemu-system-arm -M orangepi-pc -m 512 -nic user -nographic \
>      -kernel /path/to/linux/arch/arm/boot/zImage \
>      -append 'console=ttyS0,115200' \
>      -dtb /path/to/linux/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb
>
> Note that this kernel does not have a root filesystem. You may provide it
> with an official Orange Pi PC image [1] either as an SD card or as
> USB mass storage. To boot using the Orange Pi PC Debian image on SD card,
> simply add the -sd argument and provide the proper root= kernel parameter:
>  $ qemu-system-arm -M orangepi-pc -m 512 -nic user -nographic \
>      -kernel /path/to/linux/arch/arm/boot/zImage \
>      -append 'console=ttyS0,115200 root=/dev/mmcblk0p2' \
>      -dtb /path/to/linux/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb \
>      -sd OrangePi_pc_debian_stretch_server_linux5.3.5_v1.0.img
>
> Alternatively, you can also choose to build and boot a recent buildroot [2]
> using the orangepi_pc_defconfig or Armbian image [3] for Orange Pi PC.
> To attach an USB mass storage device to the machine, simply append to the
> command:
>  -drive if=none,id=stick,file=myimage.img \
>  -device usb-storage,bus=usb-bus.0,drive=stick
>
> U-Boot mainline can be build and configured using the orangepi_pc_defconfig
> using similar commands as describe above for Linux. To start U-Boot using
> the Orange Pi PC machine, provide the u-boot binary to the -kernel
> argument:
>  $ qemu-system-arm -M orangepi-pc -m 512 -nic user -nographic \
>      -kernel /path/to/uboot/u-boot -sd disk.img
>
> Use the following U-boot commands to load and boot a Linux kernel from SD
> card:
>  -> setenv bootargs console=ttyS0,115200
>  -> ext2load mmc 0 0x42000000 zImage
>  -> ext2load mmc 0 0x43000000 sun8i-h3-orangepi-pc.dtb
>  -> bootz 0x42000000 - 0x43000000
>
> Looking forward to your review comments. I will do my best
> to update the patches where needed.
>
> ===== CHANGELOG =====
>
> v2:
>  * hw/arm/allwinner-h3.c: use cpus array in AwH3State instead of
> object_new()
>  * hw/arm/allwinner-h3.c: use error_abort in aw_h3_realize()
>  * hw/arm/allwinner-h3.c: use qdev_init_nofail() in aw_h3_realize()
>  * hw/arm/allwinner-h3.c: use qdev_get_gpio_in() instead of irq array
>  * hw/arm/allwinner-h3.c: add all missing unimplemented devices (memory
> map is complete)
>  * hw/arm/allwinner-h3.c: add UART1, UART2, UART3 and remove 'if
> (serial_hd(...))'
>  * hw/arm/allwinner-h3.c: remove sysbusdev variable and use
> SYS_BUS_DEVICE() directly
>  * include/hw/arm/allwinner-h3.h: move PPI/SPI defines to allwinner-h3.c
> as enum
>  * include/hw/arm/allwinner-h3.h: replace mem base/size defines with enum
> and memmap (like aspeed_soc.h)
>  * hw/arm/orangepi.c: Only allow Cortex-A7 in machine->cpu_type
>  * hw/arm/orangepi.c: Set mc->default_cpu_type to
> ARM_CPU_TYPE_NAME("cortex-a7")
>  * hw/arm/orangepi.c: Use error_abort in orangepi_init()
>  * hw/arm/orangepi.c: only allow maximum 1GiB RAM
>  * hw/arm/orangepi.c: renamed machine name to 'orangepi-pc'
>  * hw/arm/orangepi.c: remove mc->ignore_memory_transaction_failures = true
>  * hw/arm/orangepi.c: remove unnecessary check for 'sd-bus'
>  * hw/net/allwinner-h3-emac.c: use AW_H3_EMAC() for opaque in read/write
> functions
>  * hw/sd/allwinner-h3-sdhost.c: replace register defines with enums
>  * hw/sd/allwinner-h3-sdhost.c: remove 'irq_en' and use if() to set 'irq'
> in update_irq function
>  * hw/sd/allwinner-h3-sdhost.c: simplified if (rlen==) conditions in
> send_command function
>  * hw/sd/allwinner-h3-sdhost.c: use KiB macro to set desc->size
>  * hw/sd/allwinner-h3-sdhost.c: use ARRAY_SIZE() macro in reset function
>  * hw/misc/allwinner-h3-sid.c: replace randomized identifier with QemuUUID
> property
>  * hw/misc/allwinner-h3-sid.c: add tracing for read/write functions
>  * hw/misc/allwinner-h3-sid.c: fix incorrect usage of
> REG_PRCTL_OP_LOCK/REG_PRCTL_WRITE
>  * hw/misc/trace-events: add allwinner_h3_cpucfg* entries in correct patch
> (#7)
>  * hw/*/trace-events: use PRIu32/PRIx32 macros for size and max fields
>  * hw/*/allwinner-h3-*.c: set .impl.min_access_size = 4 to restrict MMIO
> access to 32-bit aligned
>  * hw/*/allwinner-h3-*.c: replace register defines with enums
>  * hw/*/allwinner-h3-*.c: set VMStateDescription.name with inline string
> (dont use TYPE macro)
>  * include/hw/*/allwinner-h3-*.h: remove MEM_SIZE define and use size
> inline in the source file
>  * target/arm/arm-powerctl.c: invoke arm_rebuild_hflags() after setting
> CP15 bits
>
> With kind regards,
>
> Niek Linnenbank
>
> [1] http://www.orangepi.org/downloadresources/
> [2] https://buildroot.org/download.html
> [3] https://www.armbian.com/orange-pi-pc/
>
> Niek Linnenbank (10):
>   hw: arm: add Allwinner H3 System-on-Chip
>   hw: arm: add Xunlong Orange Pi PC machine
>   arm: allwinner-h3: add Clock Control Unit
>   arm: allwinner-h3: add USB host controller
>   arm: allwinner-h3: add System Control module
>   arm/arm-powerctl: rebuild hflags after setting CP15 bits in
>     arm_set_cpu_on()
>   arm: allwinner-h3: add CPU Configuration module
>   arm: allwinner-h3: add Security Identifier device
>   arm: allwinner-h3: add SD/MMC host controller
>   arm: allwinner-h3: add EMAC ethernet device
>
>  default-configs/arm-softmmu.mak       |   1 +
>  hw/usb/hcd-ehci.h                     |   1 +
>  include/hw/arm/allwinner-h3.h         |  93 +++
>  include/hw/misc/allwinner-h3-clk.h    |  40 ++
>  include/hw/misc/allwinner-h3-cpucfg.h |  42 ++
>  include/hw/misc/allwinner-h3-sid.h    |  40 ++
>  include/hw/misc/allwinner-h3-syscon.h |  42 ++
>  include/hw/net/allwinner-h3-emac.h    |  67 +++
>  include/hw/sd/allwinner-h3-sdhost.h   |  71 +++
>  hw/arm/allwinner-h3.c                 | 442 ++++++++++++++
>  hw/arm/orangepi.c                     | 127 ++++
>  hw/misc/allwinner-h3-clk.c            | 238 ++++++++
>  hw/misc/allwinner-h3-cpucfg.c         | 288 +++++++++
>  hw/misc/allwinner-h3-sid.c            | 179 ++++++
>  hw/misc/allwinner-h3-syscon.c         | 146 +++++
>  hw/net/allwinner-h3-emac.c            | 829 ++++++++++++++++++++++++++
>  hw/sd/allwinner-h3-sdhost.c           | 813 +++++++++++++++++++++++++
>  hw/usb/hcd-ehci-sysbus.c              |  17 +
>  target/arm/arm-powerctl.c             |   3 +
>  MAINTAINERS                           |   8 +
>  hw/arm/Kconfig                        |   9 +
>  hw/arm/Makefile.objs                  |   1 +
>  hw/misc/Makefile.objs                 |   4 +
>  hw/misc/trace-events                  |   9 +
>  hw/net/Kconfig                        |   3 +
>  hw/net/Makefile.objs                  |   1 +
>  hw/net/trace-events                   |  10 +
>  hw/sd/Makefile.objs                   |   1 +
>  hw/sd/trace-events                    |   7 +
>  29 files changed, 3532 insertions(+)
>  create mode 100644 include/hw/arm/allwinner-h3.h
>  create mode 100644 include/hw/misc/allwinner-h3-clk.h
>  create mode 100644 include/hw/misc/allwinner-h3-cpucfg.h
>  create mode 100644 include/hw/misc/allwinner-h3-sid.h
>  create mode 100644 include/hw/misc/allwinner-h3-syscon.h
>  create mode 100644 include/hw/net/allwinner-h3-emac.h
>  create mode 100644 include/hw/sd/allwinner-h3-sdhost.h
>  create mode 100644 hw/arm/allwinner-h3.c
>  create mode 100644 hw/arm/orangepi.c
>  create mode 100644 hw/misc/allwinner-h3-clk.c
>  create mode 100644 hw/misc/allwinner-h3-cpucfg.c
>  create mode 100644 hw/misc/allwinner-h3-sid.c
>  create mode 100644 hw/misc/allwinner-h3-syscon.c
>  create mode 100644 hw/net/allwinner-h3-emac.c
>  create mode 100644 hw/sd/allwinner-h3-sdhost.c
>
> --
> 2.17.1
>
>

-- 
Niek Linnenbank

--000000000000c17ee8059aea2500
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>Here a short status repo=
rt of this patch series.</div><div><br></div><div>For V3 update I already p=
repared the following:</div><div>=C2=A0- reworked all review comments from =
Philippe, except:</div><div>=C2=A0=C2=A0 - patch#8: question for the SID, w=
hether command-line override is required (and how is the best way for machi=
ne-specific cli arg?) [1]</div><div>- added BootROM support, allows booting=
 with only specifying -sd &lt;IMG&gt;<br></div><div>- added SDRAM controlle=
r driver, for U-Boot SPL</div><div>- added Allwinner generic RTC driver (fo=
r both Cubieboard and OrangePi PC, supports sun4i, sun6i, sun7i)</div><div>=
- small fixes for EMAC</div><div><br></div><div>My current TODO:</div><div>=
=C2=A0- integrate Philips acceptance tests in the series</div><div>=C2=A0- =
integrate Philips work for generalizing the Allwinner timer, and finish it<=
/div><div>=C2=A0- test and fix BSD targets (NetBSD, FreeBSD) [2, 3]</div><d=
iv>=C2=A0- further generalize the series to cover very similar SoCs: H2+, H=
5<br></div><div><br></div><div>Does anyone have more comments/requests for =
the V3 update?<br></div><div><br></div><div>[1] <a href=3D"https://lists.gn=
u.org/archive/html/qemu-devel/2019-12/msg04049.html">https://lists.gnu.org/=
archive/html/qemu-devel/2019-12/msg04049.html</a></div><div>[2] <a href=3D"=
https://wiki.netbsd.org/ports/evbarm/allwinner/">https://wiki.netbsd.org/po=
rts/evbarm/allwinner/</a></div><div>[3] <a href=3D"https://wiki.freebsd.org=
/action/show/arm/Allwinner?action=3Dshow&amp;redirect=3DFreeBSD%2Farm%2FAll=
winner">https://wiki.freebsd.org/action/show/arm/Allwinner?action=3Dshow&am=
p;redirect=3DFreeBSD%2Farm%2FAllwinner</a></div></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 17, 2019 at 12:=
35 AM Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com">niekl=
innenbank@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Dear QEMU developers,<br>
<br>
Hereby I would like to contribute the following set of patches to QEMU<br>
which add support for the Allwinner H3 System on Chip and the<br>
Orange Pi PC machine. The following features and devices are supported:<br>
<br>
=C2=A0* SMP (Quad Core Cortex A7)<br>
=C2=A0* Generic Interrupt Controller configuration<br>
=C2=A0* SRAM mappings<br>
=C2=A0* Timer device (re-used from Allwinner A10)<br>
=C2=A0* UART<br>
=C2=A0* SD/MMC storage controller<br>
=C2=A0* EMAC ethernet connectivity<br>
=C2=A0* USB 2.0 interfaces<br>
=C2=A0* Clock Control Unit<br>
=C2=A0* System Control module<br>
=C2=A0* Security Identifier device<br>
<br>
Functionality related to graphical output such as HDMI, GPU,<br>
Display Engine and audio are not included. Recently released<br>
mainline Linux kernels (4.19 up to latest master) and mainline U-Boot<br>
are known to work. The SD/MMC code is tested using bonnie++ and<br>
various tools such as fsck, dd and fdisk. The EMAC is verified with iperf3<=
br>
using -netdev socket.<br>
<br>
To build a Linux mainline kernel that can be booted by the Orange Pi PC<br>
machine, simply configure the kernel using the sunxi_defconfig configuratio=
n:<br>
=C2=A0$ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make mrproper<br>
=C2=A0$ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make sunxi_defconfig<=
br>
<br>
To be able to use USB storage, you need to manually enable the correspondin=
g<br>
configuration item. Start the kconfig configuration tool:<br>
=C2=A0$ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make menuconfig<br>
<br>
Navigate to the following item, enable it and save your configuration:<br>
=C2=A0Device Drivers &gt; USB support &gt; USB Mass Storage support<br>
<br>
Build the Linux kernel with:<br>
=C2=A0$ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make -j5<br>
<br>
To boot the newly build linux kernel in QEMU with the Orange Pi PC machine,=
 use:<br>
=C2=A0$ qemu-system-arm -M orangepi-pc -m 512 -nic user -nographic \<br>
=C2=A0 =C2=A0 =C2=A0-kernel /path/to/linux/arch/arm/boot/zImage \<br>
=C2=A0 =C2=A0 =C2=A0-append &#39;console=3DttyS0,115200&#39; \<br>
=C2=A0 =C2=A0 =C2=A0-dtb /path/to/linux/arch/arm/boot/dts/sun8i-h3-orangepi=
-pc.dtb<br>
<br>
Note that this kernel does not have a root filesystem. You may provide it<b=
r>
with an official Orange Pi PC image [1] either as an SD card or as<br>
USB mass storage. To boot using the Orange Pi PC Debian image on SD card,<b=
r>
simply add the -sd argument and provide the proper root=3D kernel parameter=
:<br>
=C2=A0$ qemu-system-arm -M orangepi-pc -m 512 -nic user -nographic \<br>
=C2=A0 =C2=A0 =C2=A0-kernel /path/to/linux/arch/arm/boot/zImage \<br>
=C2=A0 =C2=A0 =C2=A0-append &#39;console=3DttyS0,115200 root=3D/dev/mmcblk0=
p2&#39; \<br>
=C2=A0 =C2=A0 =C2=A0-dtb /path/to/linux/arch/arm/boot/dts/sun8i-h3-orangepi=
-pc.dtb \<br>
=C2=A0 =C2=A0 =C2=A0-sd OrangePi_pc_debian_stretch_server_linux5.3.5_v1.0.i=
mg<br>
<br>
Alternatively, you can also choose to build and boot a recent buildroot [2]=
<br>
using the orangepi_pc_defconfig or Armbian image [3] for Orange Pi PC.<br>
To attach an USB mass storage device to the machine, simply append to the c=
ommand:<br>
=C2=A0-drive if=3Dnone,id=3Dstick,file=3Dmyimage.img \<br>
=C2=A0-device usb-storage,bus=3Dusb-bus.0,drive=3Dstick<br>
<br>
U-Boot mainline can be build and configured using the orangepi_pc_defconfig=
<br>
using similar commands as describe above for Linux. To start U-Boot using<b=
r>
the Orange Pi PC machine, provide the u-boot binary to the -kernel argument=
:<br>
=C2=A0$ qemu-system-arm -M orangepi-pc -m 512 -nic user -nographic \<br>
=C2=A0 =C2=A0 =C2=A0-kernel /path/to/uboot/u-boot -sd disk.img<br>
<br>
Use the following U-boot commands to load and boot a Linux kernel from SD c=
ard:<br>
=C2=A0-&gt; setenv bootargs console=3DttyS0,115200<br>
=C2=A0-&gt; ext2load mmc 0 0x42000000 zImage<br>
=C2=A0-&gt; ext2load mmc 0 0x43000000 sun8i-h3-orangepi-pc.dtb<br>
=C2=A0-&gt; bootz 0x42000000 - 0x43000000<br>
<br>
Looking forward to your review comments. I will do my best<br>
to update the patches where needed.<br>
<br>
=3D=3D=3D=3D=3D CHANGELOG =3D=3D=3D=3D=3D<br>
<br>
v2:<br>
=C2=A0* hw/arm/allwinner-h3.c: use cpus array in AwH3State instead of objec=
t_new()<br>
=C2=A0* hw/arm/allwinner-h3.c: use error_abort in aw_h3_realize()<br>
=C2=A0* hw/arm/allwinner-h3.c: use qdev_init_nofail() in aw_h3_realize()<br=
>
=C2=A0* hw/arm/allwinner-h3.c: use qdev_get_gpio_in() instead of irq array<=
br>
=C2=A0* hw/arm/allwinner-h3.c: add all missing unimplemented devices (memor=
y map is complete)<br>
=C2=A0* hw/arm/allwinner-h3.c: add UART1, UART2, UART3 and remove &#39;if (=
serial_hd(...))&#39;<br>
=C2=A0* hw/arm/allwinner-h3.c: remove sysbusdev variable and use SYS_BUS_DE=
VICE() directly<br>
=C2=A0* include/hw/arm/allwinner-h3.h: move PPI/SPI defines to allwinner-h3=
.c as enum<br>
=C2=A0* include/hw/arm/allwinner-h3.h: replace mem base/size defines with e=
num and memmap (like aspeed_soc.h)<br>
=C2=A0* hw/arm/orangepi.c: Only allow Cortex-A7 in machine-&gt;cpu_type<br>
=C2=A0* hw/arm/orangepi.c: Set mc-&gt;default_cpu_type to ARM_CPU_TYPE_NAME=
(&quot;cortex-a7&quot;)<br>
=C2=A0* hw/arm/orangepi.c: Use error_abort in orangepi_init()<br>
=C2=A0* hw/arm/orangepi.c: only allow maximum 1GiB RAM<br>
=C2=A0* hw/arm/orangepi.c: renamed machine name to &#39;orangepi-pc&#39;<br=
>
=C2=A0* hw/arm/orangepi.c: remove mc-&gt;ignore_memory_transaction_failures=
 =3D true<br>
=C2=A0* hw/arm/orangepi.c: remove unnecessary check for &#39;sd-bus&#39;<br=
>
=C2=A0* hw/net/allwinner-h3-emac.c: use AW_H3_EMAC() for opaque in read/wri=
te functions<br>
=C2=A0* hw/sd/allwinner-h3-sdhost.c: replace register defines with enums<br=
>
=C2=A0* hw/sd/allwinner-h3-sdhost.c: remove &#39;irq_en&#39; and use if() t=
o set &#39;irq&#39; in update_irq function<br>
=C2=A0* hw/sd/allwinner-h3-sdhost.c: simplified if (rlen=3D=3D) conditions =
in send_command function<br>
=C2=A0* hw/sd/allwinner-h3-sdhost.c: use KiB macro to set desc-&gt;size<br>
=C2=A0* hw/sd/allwinner-h3-sdhost.c: use ARRAY_SIZE() macro in reset functi=
on<br>
=C2=A0* hw/misc/allwinner-h3-sid.c: replace randomized identifier with Qemu=
UUID property<br>
=C2=A0* hw/misc/allwinner-h3-sid.c: add tracing for read/write functions<br=
>
=C2=A0* hw/misc/allwinner-h3-sid.c: fix incorrect usage of REG_PRCTL_OP_LOC=
K/REG_PRCTL_WRITE<br>
=C2=A0* hw/misc/trace-events: add allwinner_h3_cpucfg* entries in correct p=
atch (#7)<br>
=C2=A0* hw/*/trace-events: use PRIu32/PRIx32 macros for size and max fields=
<br>
=C2=A0* hw/*/allwinner-h3-*.c: set .impl.min_access_size =3D 4 to restrict =
MMIO access to 32-bit aligned<br>
=C2=A0* hw/*/allwinner-h3-*.c: replace register defines with enums<br>
=C2=A0* hw/*/allwinner-h3-*.c: set VMStateDescription.name with inline stri=
ng (dont use TYPE macro)<br>
=C2=A0* include/hw/*/allwinner-h3-*.h: remove MEM_SIZE define and use size =
inline in the source file<br>
=C2=A0* target/arm/arm-powerctl.c: invoke arm_rebuild_hflags() after settin=
g CP15 bits<br>
<br>
With kind regards,<br>
<br>
Niek Linnenbank<br>
<br>
[1] <a href=3D"http://www.orangepi.org/downloadresources/" rel=3D"noreferre=
r" target=3D"_blank">http://www.orangepi.org/downloadresources/</a><br>
[2] <a href=3D"https://buildroot.org/download.html" rel=3D"noreferrer" targ=
et=3D"_blank">https://buildroot.org/download.html</a><br>
[3] <a href=3D"https://www.armbian.com/orange-pi-pc/" rel=3D"noreferrer" ta=
rget=3D"_blank">https://www.armbian.com/orange-pi-pc/</a><br>
<br>
Niek Linnenbank (10):<br>
=C2=A0 hw: arm: add Allwinner H3 System-on-Chip<br>
=C2=A0 hw: arm: add Xunlong Orange Pi PC machine<br>
=C2=A0 arm: allwinner-h3: add Clock Control Unit<br>
=C2=A0 arm: allwinner-h3: add USB host controller<br>
=C2=A0 arm: allwinner-h3: add System Control module<br>
=C2=A0 arm/arm-powerctl: rebuild hflags after setting CP15 bits in<br>
=C2=A0 =C2=A0 arm_set_cpu_on()<br>
=C2=A0 arm: allwinner-h3: add CPU Configuration module<br>
=C2=A0 arm: allwinner-h3: add Security Identifier device<br>
=C2=A0 arm: allwinner-h3: add SD/MMC host controller<br>
=C2=A0 arm: allwinner-h3: add EMAC ethernet device<br>
<br>
=C2=A0default-configs/arm-softmmu.mak=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A01 +<br>
=C2=A0hw/usb/hcd-ehci.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0include/hw/arm/allwinner-h3.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 93 +++<br>
=C2=A0include/hw/misc/allwinner-h3-clk.h=C2=A0 =C2=A0 |=C2=A0 40 ++<br>
=C2=A0include/hw/misc/allwinner-h3-cpucfg.h |=C2=A0 42 ++<br>
=C2=A0include/hw/misc/allwinner-h3-sid.h=C2=A0 =C2=A0 |=C2=A0 40 ++<br>
=C2=A0include/hw/misc/allwinner-h3-syscon.h |=C2=A0 42 ++<br>
=C2=A0include/hw/net/allwinner-h3-emac.h=C2=A0 =C2=A0 |=C2=A0 67 +++<br>
=C2=A0include/hw/sd/allwinner-h3-sdhost.h=C2=A0 =C2=A0|=C2=A0 71 +++<br>
=C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| 442 ++++++++++++++<br>
=C2=A0hw/arm/orangepi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 127 ++++<br>
=C2=A0hw/misc/allwinner-h3-clk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 238 ++++++++<br>
=C2=A0hw/misc/allwinner-h3-cpucfg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 288 =
+++++++++<br>
=C2=A0hw/misc/allwinner-h3-sid.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 179 ++++++<br>
=C2=A0hw/misc/allwinner-h3-syscon.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 146 =
+++++<br>
=C2=A0hw/net/allwinner-h3-emac.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 829 ++++++++++++++++++++++++++<br>
=C2=A0hw/sd/allwinner-h3-sdhost.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 813 +++++++++++++++++++++++++<br>
=C2=A0hw/usb/hcd-ehci-sysbus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 17 +<br>
=C2=A0target/arm/arm-powerctl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A03 +<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A08 +<br>
=C2=A0hw/arm/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A09 +<br>
=C2=A0hw/arm/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
=C2=A0hw/misc/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A09 +<br>
=C2=A0hw/net/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
=C2=A0hw/net/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0hw/net/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 10 +<br>
=C2=A0hw/sd/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0hw/sd/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 +<br>
=C2=A029 files changed, 3532 insertions(+)<br>
=C2=A0create mode 100644 include/hw/arm/allwinner-h3.h<br>
=C2=A0create mode 100644 include/hw/misc/allwinner-h3-clk.h<br>
=C2=A0create mode 100644 include/hw/misc/allwinner-h3-cpucfg.h<br>
=C2=A0create mode 100644 include/hw/misc/allwinner-h3-sid.h<br>
=C2=A0create mode 100644 include/hw/misc/allwinner-h3-syscon.h<br>
=C2=A0create mode 100644 include/hw/net/allwinner-h3-emac.h<br>
=C2=A0create mode 100644 include/hw/sd/allwinner-h3-sdhost.h<br>
=C2=A0create mode 100644 hw/arm/allwinner-h3.c<br>
=C2=A0create mode 100644 hw/arm/orangepi.c<br>
=C2=A0create mode 100644 hw/misc/allwinner-h3-clk.c<br>
=C2=A0create mode 100644 hw/misc/allwinner-h3-cpucfg.c<br>
=C2=A0create mode 100644 hw/misc/allwinner-h3-sid.c<br>
=C2=A0create mode 100644 hw/misc/allwinner-h3-syscon.c<br>
=C2=A0create mode 100644 hw/net/allwinner-h3-emac.c<br>
=C2=A0create mode 100644 hw/sd/allwinner-h3-sdhost.c<br>
<br>
-- <br>
2.17.1<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div>

--000000000000c17ee8059aea2500--

