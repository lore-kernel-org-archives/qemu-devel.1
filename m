Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4455AC4741C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:25:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99AC62465A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CW1sM6e4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99AC62465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifrqe-0000pL-0D
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 15:47:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ifrp8-00086k-BU
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 15:46:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ifrp3-00023Z-Lx
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 15:46:05 -0500
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:40756)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ifrp3-00021c-C6; Fri, 13 Dec 2019 15:46:01 -0500
Received: by mail-io1-xd44.google.com with SMTP id x1so988081iop.7;
 Fri, 13 Dec 2019 12:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3wTaebObS2Pqs6jood4W/1S3RjJObJ21+auWyMLqj5U=;
 b=CW1sM6e44cnlFEG9Gh6emq7kVOpmw3m5B3s61PX0vaGD9HdKo8tb5gJ4qgbu6TWBf2
 hDFnlSMGzLBCYiVdkYNtZW1drWQQOFUVkybCIqAlKe8eZOz3vqtzByOUQD9j8pbXdws8
 OdX7JbHS8UshK3i8+pDOB4GoJ60c72ebvm+3OOjGqTetFNZPps6noHcLoP99hdmpLXaq
 GKruhjC2ktIN+w95/oxsGRtLSBg84t6OV3VyHtPLxdRsmyil07ZFpB/oiPVVfKvNSfy/
 Gbe+TJOcl8Tzez17xHLr/niuWIVWosG50JUDvkq30YBob+PGTyr6M0If96IocoEBCoUw
 n8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3wTaebObS2Pqs6jood4W/1S3RjJObJ21+auWyMLqj5U=;
 b=izfLS+xXvdlPcYdqyyb3i/+GgWuRkeA0DwJCMfmGkjfYZSFuqr/WTVi+juVCuRj3Xq
 eMzXJlxzGy/g29SliufWumfSX8WM5aBCLymvBbRxQ3qqwIXcuW+IaxOAtgP8At1swAxr
 k2RufHqdW1uaS9DfzoAc3fZZ3mL3+d5J8AI8qzjSPqM6L1Jv7KHk+3uGlHiKEz/FtnMD
 wfKDtc+Ms+r9y3bB5xGpr3WgOy3Q3KE4RbeGhDs0yymaw8qG0aiQPz++g+OAyTViB5Ld
 jtFyN6CkPLpR6EsndFTsJIdDHhvKw0cf6wK6keJ3AHunKNkX6apWRCJzFpcL7eA/CM7g
 0nBQ==
X-Gm-Message-State: APjAAAXl+nQXmdlMju97PdKGfp9T1DDF/yVfCyELa7U53MFJJw5RcngY
 kQ9ZHmm/75hA+NcNG5BeIccPsE7TIoTm+zN6o/o=
X-Google-Smtp-Source: APXvYqzsNCDTJrJi2yJ9gmmTgAYsS2clX7HbxgZo/r2MVslxXsPqs3/DxxQL1uw4VdgCkL8PYUcr5Xu5FCkqneGZSBw=
X-Received: by 2002:a02:8817:: with SMTP id r23mr1315146jai.120.1576269960273; 
 Fri, 13 Dec 2019 12:46:00 -0800 (PST)
MIME-Version: 1.0
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <f54375da-4383-04c5-d57c-3a2f6ff46189@redhat.com>
 <CAPan3WrAgWZF1JvSAe=nWUb4rvN6qjfC6JDCnH2P6xmBuitn5w@mail.gmail.com>
 <74df65db-1f84-62ba-6d01-edf765fd1dc2@redhat.com>
 <CAPan3Wojt3SSV_kBPfinVLN+mvR_6=rf9zsHV5yq11+qe2Umyg@mail.gmail.com>
 <CAPan3Woucroq2+c5J8Trw+ssEMD4tnwfKzPeOf3AZKmv_R0EgQ@mail.gmail.com>
 <7ed70514-e67e-9403-63b3-5a81c59fe952@redhat.com>
In-Reply-To: <7ed70514-e67e-9403-63b3-5a81c59fe952@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Fri, 13 Dec 2019 21:45:48 +0100
Message-ID: <CAPan3Wp1Cqi3n0kH1hY-BxDA+kxJnFVi0-m2c0HBT+RXDPz4bg@mail.gmail.com>
Subject: Re: [PATCH 00/10] Add Allwinner H3 SoC and Orange Pi PC Machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000d68d305999bf369"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000d68d305999bf369
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Fri, Dec 13, 2019 at 12:25 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com>
wrote:

> Cc'ing Alex.
>
> On 12/13/19 12:07 AM, Niek Linnenbank wrote:
> > Hi Philippe,
> >
> > I have discovered that the hflags assertion error you reported is not
> > caused by the Allwinner H3
> > patches but actually an existing problem. What I did is to use the
> > latest master (v4.2.0 tag) without any patches applied.
> > and tried to boot the raspi2 machine with and without debugging enabled=
.
> > Without debuggin, the raspi2
> > machine runs fine and can boot the 5.4.2 linux kernel. With debugging
> > enabled, the same hflags error shows.
>
> This might be the same bug I hit last week... Alex suggested a patch:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg664500.html
>
> Do you mind to try it?
>

Ahh OK, I was not aware that this was already seen and solved!
Sometimes I try use the lists.gnu.org site to keep an eye out for relevant
emails going to qemu-devel,
but I totally missed this fix. Too many e-mails. Perhaps instead I should
just subscribe to the mailing list and use filters.

I retried with the raspi2 machine and alex's patch, and indeed the hflags
error is gone and
the machine starts fine with debugging enabled.

Ofcourse, I also retried with the Allwinner H3 patches + alex's fix applied
and the orangepi-pc machine,
and unfortunately, there the hflags assertion did still show up.

Then I looked further to try and understand what is going on, and it looked
to me that the hflags is a
state variable, that needs to be rebuild after changing some other fields
inside the ARM cpu object.
And in my patch #0006 I did just that: I tried to resolve the undefined
exceptions I got using arm_set_cpu_on(),
by setting CP10,CP11 bits. So I tried to use the arm_rebuild_hflags()
function after applying the CP10,CP11 bits,
and that solved the assertion issue (see below).

Can you verify if this change also resolves the hflags assertion on your
side?

I'll also reply to the mail for patch #0006 with this info.

Regards,
Niek

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index f77a950db6..cf2f3d69ab 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -104,6 +104,9 @@ static void arm_set_cpu_on_async_work(CPUState
*target_cpu_state,
         /* Processor is not in secure mode */
         target_cpu->env.cp15.scr_el3 |=3D SCR_NS;

+        /* Set NSACR.{CP11,CP10} so NS can access the FPU */
+        target_cpu->env.cp15.nsacr |=3D 3 << 10;
+
         /*
          * If QEMU is providing the equivalent of EL3 firmware, then we ne=
ed
          * to make sure a CPU targeting EL2 comes out of reset with a
@@ -124,6 +127,9 @@ static void arm_set_cpu_on_async_work(CPUState
*target_cpu_state,
         target_cpu->env.regs[0] =3D info->context_id;
     }

+    /* Ensure hflags is rebuild */
+    arm_rebuild_hflags(&target_cpu->env);
+
     /* Start the new CPU at the requested address */
     cpu_set_pc(target_cpu_state, info->entry);




>
> If it still fails, you might also add this one on top:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg663843.html
> and report the error.
>
> That patch is indeed very helpful


> >
> > To reproduce it, build Linux 5.4.2 with the bmc2835_defconfig:
> >
> > $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make mrproper
> > $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make bcm2835_defconfig
> > $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make -j5
> > ...
> >
> > First build QEMU without debugging and try to boot linux:
> > $ ./configure --target-list=3Darm-softmmu; make clean; make -j5
> > $ ./arm-softmmu/qemu-system-arm -M raspi2 \
> >    -kernel $HOME/linux-5.4.2/arch/arm/boot/zImage \
> >    -append 'console=3DttyAMA0,115200 earlyprintk debug' \
> >    -dtb $HOME/linux-5.4.2/arch/arm/boot/dts/bcm2836-rpi-2-b.dtb \
> >    -m 1024 -nographic -s
> > [    0.000000] Booting Linux on physical CPU 0x0
> > [    0.000000] Linux version 5.4.2 (me@host) (gcc version 7.4.0
> (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1)) #1 Thu Dec 12 22:49:14 CET 2019
> > [    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7),
> cr=3D10c53c7d
> > ...
> >
> > Then rebuild QEMU with debugging enabled and again try to boot linux:
> > $ ./configure --target-list=3Darm-softmmu --enable-debug
> --extra-cflags=3D-ggdb; make clean; make -j5
> > $ ./arm-softmmu/qemu-system-arm -M raspi2 \
> >    -kernel $HOME/linux-5.4.2/arch/arm/boot/zImage \
> >    -append 'console=3DttyAMA0,115200 earlyprintk debug' \
> >    -dtb $HOME/linux-5.4.2/arch/arm/boot/dts/bcm2836-rpi-2-b.dtb \
> >    -m 1024 -nographic -s
> > qemu-system-arm: /home/me/qemu/target/arm/helper.c:11359:
> cpu_get_tb_cpu_state: Assertion `flags =3D=3D rebuild_hflags_internal(env=
)'
> failed.
> > qemu-system-arm: /home/me/qemu/target/arm/helper.c:11359:
> cpu_get_tb_cpu_state: Assertion `flags =3D=3D rebuild_hflags_internal(env=
)'
> failed.
> > qemu-system-arm: /home/me/qemu/target/arm/helper.c:11359:
> cpu_get_tb_cpu_state: Assertion `flags =3D=3D rebuild_hflags_internal(env=
)'
> failed.
> > Aborted (core dumped)
> >
> > $ git describe
> > v4.2.0
> >
> >
> > What should be the next step? Should this be reported as a bug?
>
> In this case we might already have the fix, but if Alex patch doesn't
> help, you are always welcome to open a bug report:
> https://bugs.launchpad.net/qemu/+filebug
> This help to have notes/progress gathered.
>
> > On Tue, Dec 10, 2019 at 9:12 PM Niek Linnenbank
> > <nieklinnenbank@gmail.com <mailto:nieklinnenbank@gmail.com>> wrote:
> >
> >     Hi Philippe,
> >
> >     On Tue, Dec 10, 2019 at 9:26 AM Philippe Mathieu-Daud=C3=A9
> >     <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
> >
> >         On 12/9/19 10:37 PM, Niek Linnenbank wrote:
> >          > Hi Philippe,
> >          >
> >          > On Tue, Dec 3, 2019 at 9:47 AM Philippe Mathieu-Daud=C3=A9
> >         <philmd@redhat.com <mailto:philmd@redhat.com>
> >          > <mailto:philmd@redhat.com <mailto:philmd@redhat.com>>> wrote=
:
> >          >
> >          >     On 12/2/19 10:09 PM, Niek Linnenbank wrote:
> >          >      > Dear QEMU developers,
> >          >      >
> >          >      > Hereby I would like to contribute the following set o=
f
> >         patches to
> >          >     QEMU
> >          >      > which add support for the Allwinner H3 System on Chip
> >         and the
> >          >      > Orange Pi PC machine. The following features and
> >         devices are
> >          >     supported:
> >          >      >
> >          >      >   * SMP (Quad Core Cortex A7)
> >          >      >   * Generic Interrupt Controller configuration
> >          >      >   * SRAM mappings
> >          >      >   * Timer device (re-used from Allwinner A10)
> >          >      >   * UART
> >          >      >   * SD/MMC storage controller
> >          >      >   * EMAC ethernet connectivity
> >          >      >   * USB 2.0 interfaces
> >          >      >   * Clock Control Unit
> >          >      >   * System Control module
> >          >      >   * Security Identifier device
> >          >
> >          >     Awesome!
> >          >
> >          >      > Functionality related to graphical output such as
> >         HDMI, GPU,
> >          >      > Display Engine and audio are not included. Recently
> >         released
> >          >      > mainline Linux kernels (4.19 up to latest master) and
> >         mainline U-Boot
> >          >      > are known to work. The SD/MMC code is tested using
> >         bonnie++ and
> >          >      > various tools such as fsck, dd and fdisk. The EMAC is
> >         verified
> >          >     with iperf3
> >          >      > using -netdev socket.
> >          >      >
> >          >      > To build a Linux mainline kernel that can be booted b=
y
> >         the Orange
> >          >     Pi PC
> >          >      > machine, simply configure the kernel using the
> >         sunxi_defconfig
> >          >     configuration:
> >          >      >   $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- mak=
e
> >         mrproper
> >          >      >   $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- mak=
e
> >         sunxi_defconfig
> >          >      >
> >          >      > To be able to use USB storage, you need to manually
> >         enable the
> >          >     corresponding
> >          >      > configuration item. Start the kconfig configuration
> tool:
> >          >      >   $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- mak=
e
> >         menuconfig
> >          >      >
> >          >      > Navigate to the following item, enable it and save yo=
ur
> >          >     configuration:
> >          >      >   Device Drivers > USB support > USB Mass Storage
> support
> >          >      >
> >          >      > Build the Linux kernel with:
> >          >      >   $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- mak=
e -j5
> >          >      >
> >          >      > To boot the newly build linux kernel in QEMU with the
> >         Orange Pi
> >          >     PC machine, use:
> >          >      >   $ qemu-system-arm -M orangepi -m 512 -nic user
> >         -nographic \
> >          >      >       -kernel /path/to/linux/arch/arm/boot/zImage \
> >          >      >       -append 'console=3DttyS0,115200' \
> >          >      >       -dtb
> >         /path/to/linux/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb
> >          >      >
> >          >      > Note that this kernel does not have a root filesystem=
.
> >         You may
> >          >     provide it
> >          >      > with an official Orange Pi PC image [1] either as an
> >         SD card or as
> >          >      > USB mass storage. To boot using the Orange Pi PC
> >         Debian image on
> >          >     SD card,
> >          >      > simply add the -sd argument and provide the proper
> >         root=3D kernel
> >          >     parameter:
> >          >      >   $ qemu-system-arm -M orangepi -m 512 -nic user
> >         -nographic \
> >          >      >       -kernel /path/to/linux/arch/arm/boot/zImage \
> >          >      >       -append 'console=3DttyS0,115200
> root=3D/dev/mmcblk0p2' \
> >          >      >       -dtb
> >          >     /path/to/linux/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dt=
b
> \
> >          >      >       -sd
> >         OrangePi_pc_debian_stretch_server_linux5.3.5_v1.0.img
> >          >      >
> >          >      > Alternatively, you can also choose to build and boot =
a
> >         recent
> >          >     buildroot [2]
> >          >      > using the orangepi_pc_defconfig or Armbian image [3]
> >         for Orange
> >          >     Pi PC.
> >          >
> >          >     Richard, trying the Armbian image from
> >          > https://apt.armbian.com/pool/main/l/linux-4.20.7-sunxi/ I
> get:
> >          >
> >          >     $ arm-softmmu/qemu-system-arm -M orangepi -m 512 -nic
> user \
> >          >         -append 'console=3DttyS0,115200' \
> >          >         -kernel boot/vmlinuz-4.20.7-sunxi \
> >          >         -dtb
> >         usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-pc.dtb \
> >          >         -serial stdio -d unimp
> >          >     Uncompressing Linux... done, booting the kernel.
> >          >     rtc: unimplemented device write (size 4, value
> >         0x16aa0001, offset 0x0)
> >          >     rtc: unimplemented device read (size 4, offset 0x0)
> >          >     rtc: unimplemented device read (size 4, offset 0x0)
> >          >     rtc: unimplemented device read (size 4, offset 0x8)
> >          >     qemu-system-arm: target/arm/helper.c:11359:
> >         cpu_get_tb_cpu_state:
> >          >     Assertion `flags =3D=3D rebuild_hflags_internal(env)' fa=
iled.
> >          >     Aborted (core dumped)
> >          >
> >          >
> >          > I'm trying to reproduce the error you reported here with my
> >         patch set on
> >          > latest master,
> >          > but so far without any result. The host OS I'm using is
> >         Ubuntu 18.04.3
> >          > LTS on x86_64.
> >          > I ran several times using the same 4.20.7-sunxi kernel and
> >         same command
> >          > line.
> >          >
> >          > Some questions that might help:
> >          > 1) Are there any specific steps you did in order to produce
> >         this error?
> >
> >         I build QEMU with:
> >
> >         ./configure --enable-trace-backends=3Dlog --extra-cflags=3D-ggd=
b
> >         --enable-debug
> >
> >          > 2) Could this be a known / existing issue?
> >          > 3) How many times did you see this error?
> >
> >         Always
> >
> >          > 4) Are you also using Ubuntu 18.04.3 LTS on x86_64, or a
> >         different host OS?
> >
> >         Host is Fedora 30.
> >
> >
> >     OK thanks, I will try again using the info above after I finished
> >     reworking the other patch comments.
> >
> >     Niek
>
>

--=20
Niek Linnenbank

--0000000000000d68d305999bf369
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Philippe,<br></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Dec 13, 2019 at 1=
2:25 AM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com=
">philmd@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Cc&#39;ing Alex.<br>
<br>
On 12/13/19 12:07 AM, Niek Linnenbank wrote:<br>
&gt; Hi Philippe,<br>
&gt; <br>
&gt; I have discovered that the hflags assertion error you reported is not =
<br>
&gt; caused by the Allwinner H3<br>
&gt; patches but actually an existing problem. What I did is to use the <br=
>
&gt; latest master (v4.2.0 tag) without any patches applied.<br>
&gt; and tried to boot the raspi2 machine with and without debugging enable=
d. <br>
&gt; Without debuggin, the raspi2<br>
&gt; machine runs fine and can boot the 5.4.2 linux kernel. With debugging =
<br>
&gt; enabled, the same hflags error shows.<br>
<br>
This might be the same bug I hit last week... Alex suggested a patch:<br>
<a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg664500.htm=
l" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/qemu-d=
evel@nongnu.org/msg664500.html</a><br>
<br>
Do you mind to try it?<br></blockquote><div><br></div><div>Ahh OK, I was no=
t aware that this was already seen and solved!</div><div>Sometimes I try us=
e the <a href=3D"http://lists.gnu.org">lists.gnu.org</a> site to keep an ey=
e out for relevant emails going to qemu-devel,</div><div>but I totally miss=
ed this fix. Too many e-mails. Perhaps instead I should just subscribe to t=
he mailing list and use filters.<br></div><div><br></div><div>I retried wit=
h the raspi2 machine and alex&#39;s patch, and indeed the hflags error is g=
one and</div><div>the machine starts fine with debugging enabled.</div><div=
><br></div><div>Ofcourse, I also retried with the Allwinner H3 patches=C2=
=A0+ alex&#39;s fix applied and the orangepi-pc machine,</div><div>and unfo=
rtunately, there the hflags assertion did still show up. </div><div><br></d=
iv><div> Then I looked further to try and understand what is going on, and =
it looked to me that the hflags is a</div><div>state variable, that needs t=
o be rebuild after changing some other fields inside the ARM cpu object.</d=
iv><div><div>And in my patch #0006 I did just that: I tried to resolve the =
undefined exceptions I got using arm_set_cpu_on(),</div><div>by setting CP1=
0,CP11 bits. So I tried to use the arm_rebuild_hflags() function after appl=
ying the CP10,CP11 bits,</div><div>and that solved the assertion issue (see=
 below).<br></div></div><div><br></div><div>Can you verify if this change a=
lso resolves the hflags assertion on your side?</div><div><br></div><div>I&=
#39;ll also reply to the mail for patch #0006 with this info.</div><div><br=
></div><div>Regards,</div><div>Niek<br></div><div><br></div><div><pre>diff =
--git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index f77a950db6..cf2f3d69ab 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -104,6 +104,9 @@ static void arm_set_cpu_on_async_work(CPUState *target_=
cpu_state,
         /* Processor is not in secure mode */
         target_cpu-&gt;env.cp15.scr_el3 |=3D SCR_NS;
=20
+        /* Set NSACR.{CP11,CP10} so NS can access the FPU */
+        target_cpu-&gt;env.cp15.nsacr |=3D 3 &lt;&lt; 10;
+
         /*
          * If QEMU is providing the equivalent of EL3 firmware, then we ne=
ed
          * to make sure a CPU targeting EL2 comes out of reset with a
@@ -124,6 +127,9 @@ static void arm_set_cpu_on_async_work(CPUState *target_=
cpu_state,
         target_cpu-&gt;env.regs[0] =3D info-&gt;context_id;
     }
=20
+    /* Ensure hflags is rebuild */
+    arm_rebuild_hflags(&amp;target_cpu-&gt;env);
+
     /* Start the new CPU at the requested address */
     cpu_set_pc(target_cpu_state, info-&gt;entry);
=20
</pre></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
<br>
If it still fails, you might also add this one on top:<br>
<a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg663843.htm=
l" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/qemu-d=
evel@nongnu.org/msg663843.html</a><br>
and report the error.<br>
<br></blockquote><div>That patch is indeed very helpful<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt; To reproduce it, build Linux 5.4.2 with the bmc2835_defconfig:<br>
&gt; <br>
&gt; $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make mrproper<br>
&gt; $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make bcm2835_defconfig=
<br>
&gt; $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make -j5<br>
&gt; ...<br>
&gt; <br>
&gt; First build QEMU without debugging and try to boot linux:<br>
&gt; $ ./configure --target-list=3Darm-softmmu; make clean; make -j5<br>
&gt; $ ./arm-softmmu/qemu-system-arm -M raspi2 \<br>
&gt;=C2=A0 =C2=A0 -kernel $HOME/linux-5.4.2/arch/arm/boot/zImage \<br>
&gt;=C2=A0 =C2=A0 -append &#39;console=3DttyAMA0,115200 earlyprintk debug&#=
39; \<br>
&gt;=C2=A0 =C2=A0 -dtb $HOME/linux-5.4.2/arch/arm/boot/dts/bcm2836-rpi-2-b.=
dtb \<br>
&gt;=C2=A0 =C2=A0 -m 1024 -nographic -s<br>
&gt; [=C2=A0 =C2=A0 0.000000] Booting Linux on physical CPU 0x0<br>
&gt; [=C2=A0 =C2=A0 0.000000] Linux version 5.4.2 (me@host) (gcc version 7.=
4.0 (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1)) #1 Thu Dec 12 22:49:14 CET 2019=
<br>
&gt; [=C2=A0 =C2=A0 0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (A=
RMv7), cr=3D10c53c7d<br>
&gt; ...<br>
&gt; <br>
&gt; Then rebuild QEMU with debugging enabled and again try to boot linux:<=
br>
&gt; $ ./configure --target-list=3Darm-softmmu --enable-debug --extra-cflag=
s=3D-ggdb; make clean; make -j5<br>
&gt; $ ./arm-softmmu/qemu-system-arm -M raspi2 \<br>
&gt;=C2=A0 =C2=A0 -kernel $HOME/linux-5.4.2/arch/arm/boot/zImage \<br>
&gt;=C2=A0 =C2=A0 -append &#39;console=3DttyAMA0,115200 earlyprintk debug&#=
39; \<br>
&gt;=C2=A0 =C2=A0 -dtb $HOME/linux-5.4.2/arch/arm/boot/dts/bcm2836-rpi-2-b.=
dtb \<br>
&gt;=C2=A0 =C2=A0 -m 1024 -nographic -s<br>
&gt; qemu-system-arm: /home/me/qemu/target/arm/helper.c:11359: cpu_get_tb_c=
pu_state: Assertion `flags =3D=3D rebuild_hflags_internal(env)&#39; failed.=
<br>
&gt; qemu-system-arm: /home/me/qemu/target/arm/helper.c:11359: cpu_get_tb_c=
pu_state: Assertion `flags =3D=3D rebuild_hflags_internal(env)&#39; failed.=
<br>
&gt; qemu-system-arm: /home/me/qemu/target/arm/helper.c:11359: cpu_get_tb_c=
pu_state: Assertion `flags =3D=3D rebuild_hflags_internal(env)&#39; failed.=
<br>
&gt; Aborted (core dumped)<br>
&gt; <br>
&gt; $ git describe<br>
&gt; v4.2.0<br>
&gt; <br>
&gt; <br>
&gt; What should be the next step? Should this be reported as a bug?<br>
<br>
In this case we might already have the fix, but if Alex patch doesn&#39;t <=
br>
help, you are always welcome to open a bug report:<br>
<a href=3D"https://bugs.launchpad.net/qemu/+filebug" rel=3D"noreferrer" tar=
get=3D"_blank">https://bugs.launchpad.net/qemu/+filebug</a><br>
This help to have notes/progress gathered.<br>
<br>
&gt; On Tue, Dec 10, 2019 at 9:12 PM Niek Linnenbank <br>
&gt; &lt;<a href=3D"mailto:nieklinnenbank@gmail.com" target=3D"_blank">niek=
linnenbank@gmail.com</a> &lt;mailto:<a href=3D"mailto:nieklinnenbank@gmail.=
com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi Philippe,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Tue, Dec 10, 2019 at 9:26 AM Philippe Mathieu-Da=
ud=C3=A9<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:philmd@redhat.com" target=3D"=
_blank">philmd@redhat.com</a> &lt;mailto:<a href=3D"mailto:philmd@redhat.co=
m" target=3D"_blank">philmd@redhat.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0On 12/9/19 10:37 PM, Niek Linnenbank =
wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; Hi Philippe,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; On Tue, Dec 3, 2019 at 9:47 AM =
Philippe Mathieu-Daud=C3=A9<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:philmd@redhat.c=
om" target=3D"_blank">philmd@redhat.com</a> &lt;mailto:<a href=3D"mailto:ph=
ilmd@redhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &lt;mailto:<a href=3D"mailto:ph=
ilmd@redhat.com" target=3D"_blank">philmd@redhat.com</a> &lt;mailto:<a href=
=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;&g=
t;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0On 12/2/19 1=
0:09 PM, Niek Linnenbank wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Dear Q=
EMU developers,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Hereby=
 I would like to contribute the following set of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0patches to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0QEMU<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; which =
add support for the Allwinner H3 System on Chip<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Orange=
 Pi PC machine. The following features and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0devices are<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0supported:<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0* SMP (Quad Core Cortex A7)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0* Generic Interrupt Controller configuration<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0* SRAM mappings<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0* Timer device (re-used from Allwinner A10)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0* UART<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0* SD/MMC storage controller<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0* EMAC ethernet connectivity<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0* USB 2.0 interfaces<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0* Clock Control Unit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0* System Control module<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0* Security Identifier device<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Awesome!<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Functi=
onality related to graphical output such as<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0HDMI, GPU,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Displa=
y Engine and audio are not included. Recently<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0released<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; mainli=
ne Linux kernels (4.19 up to latest master) and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mainline U-Boot<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; are kn=
own to work. The SD/MMC code is tested using<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bonnie++ and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; variou=
s tools such as fsck, dd and fdisk. The EMAC is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0verified<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0with iperf3<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; using =
-netdev socket.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; To bui=
ld a Linux mainline kernel that can be booted by<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the Orange<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Pi PC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; machin=
e, simply configure the kernel using the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sunxi_defconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0configuratio=
n:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0$ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mrproper<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0$ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sunxi_defconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; To be =
able to use USB storage, you need to manually<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enable the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0correspondin=
g<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; config=
uration item. Start the kconfig configuration tool:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0$ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0menuconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Naviga=
te to the following item, enable it and save your<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0configuratio=
n:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0Device Drivers &gt; USB support &gt; USB Mass Storage support<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Build =
the Linux kernel with:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0$ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make -j5<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; To boo=
t the newly build linux kernel in QEMU with the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Orange Pi<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0PC machine, =
use:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0$ qemu-system-arm -M orangepi -m 512 -nic user<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-nographic \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-kernel /path/to/linux/arch/arm/boot/zImage \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-append &#39;console=3DttyS0,115200&#39; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-dtb<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/path/to/linux/arch/arm/boot/dts/sun8=
i-h3-orangepi-pc.dtb<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Note t=
hat this kernel does not have a root filesystem.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0You may<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0provide it<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; with a=
n official Orange Pi PC image [1] either as an<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SD card or as<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; USB ma=
ss storage. To boot using the Orange Pi PC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Debian image on<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0SD card,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; simply=
 add the -sd argument and provide the proper<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0root=3D kernel<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0parameter:<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0$ qemu-system-arm -M orangepi -m 512 -nic user<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-nographic \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-kernel /path/to/linux/arch/arm/boot/zImage \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-append &#39;console=3DttyS0,115200 root=3D/dev/mmcblk0=
p2&#39; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-dtb<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0/path/to/lin=
ux/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0-sd<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OrangePi_pc_debian_stretch_server_lin=
ux5.3.5_v1.0.img<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; Altern=
atively, you can also choose to build and boot a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0recent<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0buildroot [2=
]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; using =
the orangepi_pc_defconfig or Armbian image [3]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for Orange<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Pi PC.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Richard, try=
ing the Armbian image from<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; <a href=3D"https://apt.armbian.=
com/pool/main/l/linux-4.20.7-sunxi/" rel=3D"noreferrer" target=3D"_blank">h=
ttps://apt.armbian.com/pool/main/l/linux-4.20.7-sunxi/</a> I get:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0$ arm-softmm=
u/qemu-system-arm -M orangepi -m 512 -nic user \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0-append &#39;console=3DttyS0,115200&#39; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0-kernel boot/vmlinuz-4.20.7-sunxi \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0-dtb<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0usr/lib/linux-image-dev-sunxi/sun8i-h=
3-orangepi-pc.dtb \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0-serial stdio -d unimp<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Uncompressin=
g Linux... done, booting the kernel.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0rtc: unimple=
mented device write (size 4, value<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x16aa0001, offset 0x0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0rtc: unimple=
mented device read (size 4, offset 0x0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0rtc: unimple=
mented device read (size 4, offset 0x0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0rtc: unimple=
mented device read (size 4, offset 0x8)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0qemu-system-=
arm: target/arm/helper.c:11359:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_get_tb_cpu_state:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Assertion `f=
lags =3D=3D rebuild_hflags_internal(env)&#39; failed.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Aborted (cor=
e dumped)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; I&#39;m trying to reproduce the=
 error you reported here with my<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0patch set on<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; latest master,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; but so far without any result. =
The host OS I&#39;m using is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Ubuntu 18.04.3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; LTS on x86_64.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; I ran several times using the s=
ame 4.20.7-sunxi kernel and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0same command<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; line.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; Some questions that might help:=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; 1) Are there any specific steps=
 you did in order to produce<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0this error?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I build QEMU with:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0./configure --enable-trace-backends=
=3Dlog --extra-cflags=3D-ggdb<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--enable-debug<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; 2) Could this be a known / exis=
ting issue?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; 3) How many times did you see t=
his error?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Always<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; 4) Are you also using Ubuntu 18=
.04.3 LTS on x86_64, or a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0different host OS?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Host is Fedora 30.<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0OK thanks, I will try again using the info above af=
ter I finished<br>
&gt;=C2=A0 =C2=A0 =C2=A0reworking the other patch comments.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Niek<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--0000000000000d68d305999bf369--

