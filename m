Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6286BC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 23:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 188DD21556
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 23:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpE1aob5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188DD21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifXa2-0002FL-48
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 18:09:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ifXZ3-0001hn-D4
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 18:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ifXZ0-0001O2-Rb
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 18:08:09 -0500
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132]:42401)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ifXZ0-0001Lt-I3; Thu, 12 Dec 2019 18:08:06 -0500
Received: by mail-il1-x132.google.com with SMTP id a6so439968ili.9;
 Thu, 12 Dec 2019 15:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=y0TZkHXy72FpeYL3bZsOfbboQwjTGkf66FhGCbZ2cWo=;
 b=EpE1aob5Wn1nWhkVSECLNHXsYvzq1MnTYMxI01O2w62ZXlbx9M+xn1+NiDaywR5583
 14mIVIeN7982sxZF4X2r808h/etbkontxp44IND7g/UVuOMMgLDGh3TPkiLppqbYyn1G
 N0nme8j8i1TR2vPXvij6o+Qo7WzKcVxgiDPfLqr1YbC+P9rfaYQobRONomIuAawYaZMC
 fds+k+o8pMLDSXBiRCgMqawG+Zh8x1Tx3P6Lh4FBqlCcmOdRBWsLrlPSzhYAqOAgMAE8
 AlHEsoB1Jq/bfBNGMbkKgHNAwTbb0iblECqsK6zb6qnCUv8plR7vyxgnK++3NzpqarCZ
 Xf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y0TZkHXy72FpeYL3bZsOfbboQwjTGkf66FhGCbZ2cWo=;
 b=XByAZypPTsdmxqlebCrTtjJIGFWayXDnBnWyvZspQD3/paN0gUvmiYZiHkYN3h/Tty
 o72B7n7atZNbK8+p+5hRy5VA3iYoW3yA2irPHCtQssK8UmwNWlwRfU/0h9VY2T7qjStK
 WESj+1sflTdRbI67hwizBwSfHyt+Bsgyhut3kQc9ZW7Bvn94VSGDhmM8bV7NlOFDhC3l
 lrdQl40xZ/32yDyaz5/KZhWNo90bULG/4GLMIl2nszmWjG6BuDs99X3cBauWOYLWU14Z
 y20fuR8G+U1ZiNUYBMNJZkgmQKnBq+8fdCImHvQaR9ruDqRm2HUzlcJRsk5EUURncv/n
 H+Mw==
X-Gm-Message-State: APjAAAWXK8atEXa2ykR2R3QSE8Cyj2ZFBcHolqxOiq57GRtAmHZIjPQL
 V+vHM0oRjP58ntp8NIAOPTeoV659Sgzu5M5y7Sg=
X-Google-Smtp-Source: APXvYqwYuKfPkqOtow9XIUsIq+IlSrgq9IeBjp8fK9789tHkj+OK3ByMpMlhIpE5ECqgCDEy2wfV0dczrpASKi/davA=
X-Received: by 2002:a92:d5cf:: with SMTP id d15mr10329035ilq.306.1576192085368; 
 Thu, 12 Dec 2019 15:08:05 -0800 (PST)
MIME-Version: 1.0
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <f54375da-4383-04c5-d57c-3a2f6ff46189@redhat.com>
 <CAPan3WrAgWZF1JvSAe=nWUb4rvN6qjfC6JDCnH2P6xmBuitn5w@mail.gmail.com>
 <74df65db-1f84-62ba-6d01-edf765fd1dc2@redhat.com>
 <CAPan3Wojt3SSV_kBPfinVLN+mvR_6=rf9zsHV5yq11+qe2Umyg@mail.gmail.com>
In-Reply-To: <CAPan3Wojt3SSV_kBPfinVLN+mvR_6=rf9zsHV5yq11+qe2Umyg@mail.gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Fri, 13 Dec 2019 00:07:54 +0100
Message-ID: <CAPan3Woucroq2+c5J8Trw+ssEMD4tnwfKzPeOf3AZKmv_R0EgQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] Add Allwinner H3 SoC and Orange Pi PC Machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000058a540059989d12b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::132
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000058a540059989d12b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

I have discovered that the hflags assertion error you reported is not
caused by the Allwinner H3
patches but actually an existing problem. What I did is to use the latest
master (v4.2.0 tag) without any patches applied.
and tried to boot the raspi2 machine with and without debugging enabled.
Without debuggin, the raspi2
machine runs fine and can boot the 5.4.2 linux kernel. With debugging
enabled, the same hflags error shows.

To reproduce it, build Linux 5.4.2 with the bmc2835_defconfig:

$ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make mrproper
$ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make bcm2835_defconfig
$ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make -j5
...
First build QEMU without debugging and try to boot linux:
$ ./configure --target-list=3Darm-softmmu; make clean; make -j5
$ ./arm-softmmu/qemu-system-arm -M raspi2 \
  -kernel $HOME/linux-5.4.2/arch/arm/boot/zImage \
  -append 'console=3DttyAMA0,115200 earlyprintk debug' \
  -dtb $HOME/linux-5.4.2/arch/arm/boot/dts/bcm2836-rpi-2-b.dtb \
  -m 1024 -nographic -s
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 5.4.2 (me@host) (gcc version 7.4.0
(Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1)) #1 Thu Dec 12 22:49:14 CET
2019
[    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=3D10c=
53c7d
...
Then rebuild QEMU with debugging enabled and again try to boot linux:
$ ./configure --target-list=3Darm-softmmu --enable-debug
--extra-cflags=3D-ggdb; make clean; make -j5
$ ./arm-softmmu/qemu-system-arm -M raspi2 \
  -kernel $HOME/linux-5.4.2/arch/arm/boot/zImage \
  -append 'console=3DttyAMA0,115200 earlyprintk debug' \
  -dtb $HOME/linux-5.4.2/arch/arm/boot/dts/bcm2836-rpi-2-b.dtb \
  -m 1024 -nographic -s
qemu-system-arm: /home/me/qemu/target/arm/helper.c:11359:
cpu_get_tb_cpu_state: Assertion `flags =3D=3D
rebuild_hflags_internal(env)' failed.
qemu-system-arm: /home/me/qemu/target/arm/helper.c:11359:
cpu_get_tb_cpu_state: Assertion `flags =3D=3D
rebuild_hflags_internal(env)' failed.
qemu-system-arm: /home/me/qemu/target/arm/helper.c:11359:
cpu_get_tb_cpu_state: Assertion `flags =3D=3D
rebuild_hflags_internal(env)' failed.
Aborted (core dumped)

$ git describe
v4.2.0


What should be the next step? Should this be reported as a bug?

Regards,
Niek

On Tue, Dec 10, 2019 at 9:12 PM Niek Linnenbank <nieklinnenbank@gmail.com>
wrote:

> Hi Philippe,
>
> On Tue, Dec 10, 2019 at 9:26 AM Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com>
> wrote:
>
>> On 12/9/19 10:37 PM, Niek Linnenbank wrote:
>> > Hi Philippe,
>> >
>> > On Tue, Dec 3, 2019 at 9:47 AM Philippe Mathieu-Daud=C3=A9 <
>> philmd@redhat.com
>> > <mailto:philmd@redhat.com>> wrote:
>> >
>> >     On 12/2/19 10:09 PM, Niek Linnenbank wrote:
>> >      > Dear QEMU developers,
>> >      >
>> >      > Hereby I would like to contribute the following set of patches =
to
>> >     QEMU
>> >      > which add support for the Allwinner H3 System on Chip and the
>> >      > Orange Pi PC machine. The following features and devices are
>> >     supported:
>> >      >
>> >      >   * SMP (Quad Core Cortex A7)
>> >      >   * Generic Interrupt Controller configuration
>> >      >   * SRAM mappings
>> >      >   * Timer device (re-used from Allwinner A10)
>> >      >   * UART
>> >      >   * SD/MMC storage controller
>> >      >   * EMAC ethernet connectivity
>> >      >   * USB 2.0 interfaces
>> >      >   * Clock Control Unit
>> >      >   * System Control module
>> >      >   * Security Identifier device
>> >
>> >     Awesome!
>> >
>> >      > Functionality related to graphical output such as HDMI, GPU,
>> >      > Display Engine and audio are not included. Recently released
>> >      > mainline Linux kernels (4.19 up to latest master) and mainline
>> U-Boot
>> >      > are known to work. The SD/MMC code is tested using bonnie++ and
>> >      > various tools such as fsck, dd and fdisk. The EMAC is verified
>> >     with iperf3
>> >      > using -netdev socket.
>> >      >
>> >      > To build a Linux mainline kernel that can be booted by the Oran=
ge
>> >     Pi PC
>> >      > machine, simply configure the kernel using the sunxi_defconfig
>> >     configuration:
>> >      >   $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make mrproper
>> >      >   $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make
>> sunxi_defconfig
>> >      >
>> >      > To be able to use USB storage, you need to manually enable the
>> >     corresponding
>> >      > configuration item. Start the kconfig configuration tool:
>> >      >   $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make menuconf=
ig
>> >      >
>> >      > Navigate to the following item, enable it and save your
>> >     configuration:
>> >      >   Device Drivers > USB support > USB Mass Storage support
>> >      >
>> >      > Build the Linux kernel with:
>> >      >   $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make -j5
>> >      >
>> >      > To boot the newly build linux kernel in QEMU with the Orange Pi
>> >     PC machine, use:
>> >      >   $ qemu-system-arm -M orangepi -m 512 -nic user -nographic \
>> >      >       -kernel /path/to/linux/arch/arm/boot/zImage \
>> >      >       -append 'console=3DttyS0,115200' \
>> >      >       -dtb
>> /path/to/linux/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb
>> >      >
>> >      > Note that this kernel does not have a root filesystem. You may
>> >     provide it
>> >      > with an official Orange Pi PC image [1] either as an SD card or
>> as
>> >      > USB mass storage. To boot using the Orange Pi PC Debian image o=
n
>> >     SD card,
>> >      > simply add the -sd argument and provide the proper root=3D kern=
el
>> >     parameter:
>> >      >   $ qemu-system-arm -M orangepi -m 512 -nic user -nographic \
>> >      >       -kernel /path/to/linux/arch/arm/boot/zImage \
>> >      >       -append 'console=3DttyS0,115200 root=3D/dev/mmcblk0p2' \
>> >      >       -dtb
>> >     /path/to/linux/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb \
>> >      >       -sd OrangePi_pc_debian_stretch_server_linux5.3.5_v1.0.img
>> >      >
>> >      > Alternatively, you can also choose to build and boot a recent
>> >     buildroot [2]
>> >      > using the orangepi_pc_defconfig or Armbian image [3] for Orange
>> >     Pi PC.
>> >
>> >     Richard, trying the Armbian image from
>> >     https://apt.armbian.com/pool/main/l/linux-4.20.7-sunxi/ I get:
>> >
>> >     $ arm-softmmu/qemu-system-arm -M orangepi -m 512 -nic user \
>> >         -append 'console=3DttyS0,115200' \
>> >         -kernel boot/vmlinuz-4.20.7-sunxi \
>> >         -dtb usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-pc.dtb \
>> >         -serial stdio -d unimp
>> >     Uncompressing Linux... done, booting the kernel.
>> >     rtc: unimplemented device write (size 4, value 0x16aa0001, offset
>> 0x0)
>> >     rtc: unimplemented device read (size 4, offset 0x0)
>> >     rtc: unimplemented device read (size 4, offset 0x0)
>> >     rtc: unimplemented device read (size 4, offset 0x8)
>> >     qemu-system-arm: target/arm/helper.c:11359: cpu_get_tb_cpu_state:
>> >     Assertion `flags =3D=3D rebuild_hflags_internal(env)' failed.
>> >     Aborted (core dumped)
>> >
>> >
>> > I'm trying to reproduce the error you reported here with my patch set
>> on
>> > latest master,
>> > but so far without any result. The host OS I'm using is Ubuntu 18.04.3
>> > LTS on x86_64.
>> > I ran several times using the same 4.20.7-sunxi kernel and same comman=
d
>> > line.
>> >
>> > Some questions that might help:
>> > 1) Are there any specific steps you did in order to produce this error=
?
>>
>> I build QEMU with:
>>
>> ./configure --enable-trace-backends=3Dlog --extra-cflags=3D-ggdb
>> --enable-debug
>>
>> > 2) Could this be a known / existing issue?
>> > 3) How many times did you see this error?
>>
>> Always
>>
>> > 4) Are you also using Ubuntu 18.04.3 LTS on x86_64, or a different hos=
t
>> OS?
>>
>> Host is Fedora 30.
>>
>
> OK thanks, I will try again using the info above after I finished
> reworking the other patch comments.
>
> Niek
>
>
>>
>> >
>> > Regards,
>> > Niek
>>
>>
>
> --
> Niek Linnenbank
>
>

--=20
Niek Linnenbank

--00000000000058a540059989d12b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi Phil=
ippe,<br></div><div><br></div><div>I have discovered that the hflags assert=
ion error you reported is not caused by the Allwinner H3</div><div>patches =
but actually an existing problem. What I did is to use the latest master (v=
4.2.0 tag) without any patches applied.<br></div><div>and tried to boot the=
 raspi2 machine with and without debugging enabled. Without debuggin, the r=
aspi2</div><div>machine runs fine and can boot the 5.4.2 linux kernel. With=
 debugging enabled, the same hflags error shows.</div><div><br></div><div>T=
o reproduce it, build Linux 5.4.2 with the bmc2835_defconfig:<br></div><div=
><pre>$ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make mrproper
$ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make bcm2835_defconfig
$ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make -j5
...
<br><font face=3D"arial,sans-serif">First build QEMU without debugging and =
try to boot linux:</font><br>$ ./configure --target-list=3Darm-softmmu; mak=
e clean; make -j5
$ ./arm-softmmu/qemu-system-arm -M raspi2 \
  -kernel $HOME/linux-5.4.2/arch/arm/boot/zImage \
  -append &#39;console=3DttyAMA0,115200 earlyprintk debug&#39; \
  -dtb $HOME/linux-5.4.2/arch/arm/boot/dts/bcm2836-rpi-2-b.dtb \
  -m 1024 -nographic -s
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 5.4.2 (me@host) (gcc version 7.4.0 (Ubuntu/Lin=
aro 7.4.0-1ubuntu1~18.04.1)) #1 Thu Dec 12 22:49:14 CET 2019
[    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=3D10c=
53c7d
...
<br><font face=3D"arial,sans-serif">Then rebuild QEMU with debugging enable=
d and again try to boot linux:</font><br>$ ./configure --target-list=3Darm-=
softmmu --enable-debug --extra-cflags=3D-ggdb; make clean; make -j5
$ ./arm-softmmu/qemu-system-arm -M raspi2 \
  -kernel $HOME/linux-5.4.2/arch/arm/boot/zImage \
  -append &#39;console=3DttyAMA0,115200 earlyprintk debug&#39; \
  -dtb $HOME/linux-5.4.2/arch/arm/boot/dts/bcm2836-rpi-2-b.dtb \
  -m 1024 -nographic -s
qemu-system-arm: /home/me/qemu/target/arm/helper.c:11359: cpu_get_tb_cpu_st=
ate: Assertion `flags =3D=3D rebuild_hflags_internal(env)&#39; failed.
qemu-system-arm: /home/me/qemu/target/arm/helper.c:11359: cpu_get_tb_cpu_st=
ate: Assertion `flags =3D=3D rebuild_hflags_internal(env)&#39; failed.
qemu-system-arm: /home/me/qemu/target/arm/helper.c:11359: cpu_get_tb_cpu_st=
ate: Assertion `flags =3D=3D rebuild_hflags_internal(env)&#39; failed.
Aborted (core dumped)

$ git describe
v4.2.0</pre></div><div><br></div><div>What should be the next step? Should =
this be reported as a bug?</div><div><br></div><div>Regards,</div><div>Niek=
<br></div><div><br></div><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Dec 10, 2019 at 9:12 PM Niek Linnenbank &lt;<a href=
=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"lt=
r"><div>Hi Philippe,<br></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Dec 10, 2019 at 9:26 AM Philippe Mathieu-Da=
ud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@=
redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On 12/9/19 10:37 PM, Niek Linnenbank wrote:<br>
&gt; Hi Philippe,<br>
&gt; <br>
&gt; On Tue, Dec 3, 2019 at 9:47 AM Philippe Mathieu-Daud=C3=A9 &lt;<a href=
=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:philmd@redhat.com" target=3D"_blank">phil=
md@redhat.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 12/2/19 10:09 PM, Niek Linnenbank wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Dear QEMU developers,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Hereby I would like to contribute the followi=
ng set of patches to<br>
&gt;=C2=A0 =C2=A0 =C2=A0QEMU<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; which add support for the Allwinner H3 System=
 on Chip and the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Orange Pi PC machine. The following features =
and devices are<br>
&gt;=C2=A0 =C2=A0 =C2=A0supported:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* SMP (Quad Core Cortex A7)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Generic Interrupt Controller co=
nfiguration<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* SRAM mappings<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Timer device (re-used from Allw=
inner A10)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* UART<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* SD/MMC storage controller<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* EMAC ethernet connectivity<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* USB 2.0 interfaces<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Clock Control Unit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* System Control module<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0* Security Identifier device<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Awesome!<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Functionality related to graphical output suc=
h as HDMI, GPU,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Display Engine and audio are not included. Re=
cently released<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; mainline Linux kernels (4.19 up to latest mas=
ter) and mainline U-Boot<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; are known to work. The SD/MMC code is tested =
using bonnie++ and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; various tools such as fsck, dd and fdisk. The=
 EMAC is verified<br>
&gt;=C2=A0 =C2=A0 =C2=A0with iperf3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; using -netdev socket.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; To build a Linux mainline kernel that can be =
booted by the Orange<br>
&gt;=C2=A0 =C2=A0 =C2=A0Pi PC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; machine, simply configure the kernel using th=
e sunxi_defconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0configuration:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0$ ARCH=3Darm CROSS_COMPILE=3Darm-=
linux-gnueabi- make mrproper<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0$ ARCH=3Darm CROSS_COMPILE=3Darm-=
linux-gnueabi- make sunxi_defconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; To be able to use USB storage, you need to ma=
nually enable the<br>
&gt;=C2=A0 =C2=A0 =C2=A0corresponding<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; configuration item. Start the kconfig configu=
ration tool:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0$ ARCH=3Darm CROSS_COMPILE=3Darm-=
linux-gnueabi- make menuconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Navigate to the following item, enable it and=
 save your<br>
&gt;=C2=A0 =C2=A0 =C2=A0configuration:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0Device Drivers &gt; USB support &=
gt; USB Mass Storage support<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Build the Linux kernel with:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0$ ARCH=3Darm CROSS_COMPILE=3Darm-=
linux-gnueabi- make -j5<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; To boot the newly build linux kernel in QEMU =
with the Orange Pi<br>
&gt;=C2=A0 =C2=A0 =C2=A0PC machine, use:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0$ qemu-system-arm -M orangepi -m =
512 -nic user -nographic \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-kernel /path/to/li=
nux/arch/arm/boot/zImage \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-append &#39;consol=
e=3DttyS0,115200&#39; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-dtb /path/to/linux=
/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Note that this kernel does not have a root fi=
lesystem. You may<br>
&gt;=C2=A0 =C2=A0 =C2=A0provide it<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; with an official Orange Pi PC image [1] eithe=
r as an SD card or as<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; USB mass storage. To boot using the Orange Pi=
 PC Debian image on<br>
&gt;=C2=A0 =C2=A0 =C2=A0SD card,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; simply add the -sd argument and provide the p=
roper root=3D kernel<br>
&gt;=C2=A0 =C2=A0 =C2=A0parameter:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0$ qemu-system-arm -M orangepi -m =
512 -nic user -nographic \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-kernel /path/to/li=
nux/arch/arm/boot/zImage \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-append &#39;consol=
e=3DttyS0,115200 root=3D/dev/mmcblk0p2&#39; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-dtb<br>
&gt;=C2=A0 =C2=A0 =C2=A0/path/to/linux/arch/arm/boot/dts/sun8i-h3-orangepi-=
pc.dtb \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-sd OrangePi_pc_deb=
ian_stretch_server_linux5.3.5_v1.0.img<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Alternatively, you can also choose to build a=
nd boot a recent<br>
&gt;=C2=A0 =C2=A0 =C2=A0buildroot [2]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; using the orangepi_pc_defconfig or Armbian im=
age [3] for Orange<br>
&gt;=C2=A0 =C2=A0 =C2=A0Pi PC.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Richard, trying the Armbian image from<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://apt.armbian.com/pool/main/l/linu=
x-4.20.7-sunxi/" rel=3D"noreferrer" target=3D"_blank">https://apt.armbian.c=
om/pool/main/l/linux-4.20.7-sunxi/</a> I get:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0$ arm-softmmu/qemu-system-arm -M orangepi -m 512 -n=
ic user \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-append &#39;console=3DttyS0,115200&#=
39; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-kernel boot/vmlinuz-4.20.7-sunxi \<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-dtb usr/lib/linux-image-dev-sunxi/su=
n8i-h3-orangepi-pc.dtb \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-serial stdio -d unimp<br>
&gt;=C2=A0 =C2=A0 =C2=A0Uncompressing Linux... done, booting the kernel.<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0rtc: unimplemented device write (size 4, value 0x16=
aa0001, offset 0x0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0rtc: unimplemented device read (size 4, offset 0x0)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0rtc: unimplemented device read (size 4, offset 0x0)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0rtc: unimplemented device read (size 4, offset 0x8)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0qemu-system-arm: target/arm/helper.c:11359: cpu_get=
_tb_cpu_state:<br>
&gt;=C2=A0 =C2=A0 =C2=A0Assertion `flags =3D=3D rebuild_hflags_internal(env=
)&#39; failed.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Aborted (core dumped)<br>
&gt; <br>
&gt; <br>
&gt; I&#39;m trying to reproduce the error you reported here with my patch =
set on <br>
&gt; latest master,<br>
&gt; but so far without any result. The host OS I&#39;m using is Ubuntu 18.=
04.3 <br>
&gt; LTS on x86_64.<br>
&gt; I ran several times using the same 4.20.7-sunxi kernel and same comman=
d <br>
&gt; line.<br>
&gt; <br>
&gt; Some questions that might help:<br>
&gt; 1) Are there any specific steps you did in order to produce this error=
?<br>
<br>
I build QEMU with:<br>
<br>
./configure --enable-trace-backends=3Dlog --extra-cflags=3D-ggdb --enable-d=
ebug<br>
<br>
&gt; 2) Could this be a known / existing issue?<br>
&gt; 3) How many times did you see this error?<br>
<br>
Always<br>
<br>
&gt; 4) Are you also using Ubuntu 18.04.3 LTS on x86_64, or a different hos=
t OS?<br>
<br>
Host is Fedora 30.<br></blockquote><div><br></div><div>OK thanks, I will tr=
y again using the info above after I finished reworking the other patch com=
ments.</div><div><br></div><div>Niek<br></div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; Regards,<br>
&gt; Niek<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr"><div dir=
=3D"ltr"><div>Niek Linnenbank<br><br></div></div></div></div>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div></div></div>

--00000000000058a540059989d12b--

