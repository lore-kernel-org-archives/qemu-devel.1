Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF12C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 23:26:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B36B1214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 23:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iraOjb6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36B1214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifXr7-0008Vc-7V
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 18:26:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ifXqD-0007gn-FA
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 18:25:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ifXqA-0002Zw-WB
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 18:25:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24883
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ifXqA-0002Xa-LX
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 18:25:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576193149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9bm5i+WqIWVShCZh3myFNfdKln7wDmsnYzUCxNSPbsg=;
 b=iraOjb6hMzbzkpFwD4raiNSq3G38NIRfuizanN7unbKKT346mS7GqyHtQM18+iuFCPjkxO
 TCTnwmyEkDdBgFY8qbfhwRtJwcivzRWu0ZvqMJzstWoozUGUtHzXxKHd/fsIe3yiqy6WB1
 IlK1STev7gnufcgCeCtAFZpSdas5zcI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-eCeedy-bMOywOO26SYxKWQ-1; Thu, 12 Dec 2019 18:25:48 -0500
Received: by mail-wm1-f71.google.com with SMTP id z2so999845wmf.5
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 15:25:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DzKIlFG2oRJSszzlv3np93HXTN09dZqGbswUkVllOdc=;
 b=XgCgVhIwqT0t6Rzjdq+VPoRo5tHDSdOhF/r8veUKxVF0xsE+1z9rOeYjjhBCdpjLCM
 1J1GGdu+BgBcLRaHwve07LJaboxHpucmk/4I6HzaNBGpypKKrhv314OBEPGIFR7lL4c1
 tXucbFUpjIdKiDvmjWDRkboVRirbBGSO6LP3u7BndY3WfPPpXt0cfUlfbOZOc+eJHraZ
 q2xOpssIG2Pll3EP0bJCwL+x3s8Qokdk7a0nvaoUV/zRJJSsdxfsiRy/qqCo8Hjmy3PA
 HDf/JuNYJNStGTtsLO/uCgET9/qi2ojwrsehhZinKifGzr3Qo7amTfho/btxXHrfEVvb
 /4rQ==
X-Gm-Message-State: APjAAAWCTcHa607FIRXdlkeH729Qhr+iSim3MoVAtfb/n0M14SBa5hvw
 M3XocLKdapUAmspZPeeOnUMJ97v+A6Y7vRWPLIx4oGr8lMcFOeT4I/WlMVnh5L3TnBKRFjZFiIE
 otwhlojlZcgMLjjQ=
X-Received: by 2002:a5d:5592:: with SMTP id i18mr8592372wrv.55.1576193146831; 
 Thu, 12 Dec 2019 15:25:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqzYtM/0MD5xd1WDUnI0Aa51bqAhzU4Myji0dWVmQhpxnLN8ApTBTXOt+njuVwQkoVskRv6B8g==
X-Received: by 2002:a5d:5592:: with SMTP id i18mr8592342wrv.55.1576193146424; 
 Thu, 12 Dec 2019 15:25:46 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id v188sm7985013wma.10.2019.12.12.15.25.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2019 15:25:45 -0800 (PST)
Subject: Re: [PATCH 00/10] Add Allwinner H3 SoC and Orange Pi PC Machine
To: Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <f54375da-4383-04c5-d57c-3a2f6ff46189@redhat.com>
 <CAPan3WrAgWZF1JvSAe=nWUb4rvN6qjfC6JDCnH2P6xmBuitn5w@mail.gmail.com>
 <74df65db-1f84-62ba-6d01-edf765fd1dc2@redhat.com>
 <CAPan3Wojt3SSV_kBPfinVLN+mvR_6=rf9zsHV5yq11+qe2Umyg@mail.gmail.com>
 <CAPan3Woucroq2+c5J8Trw+ssEMD4tnwfKzPeOf3AZKmv_R0EgQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7ed70514-e67e-9403-63b3-5a81c59fe952@redhat.com>
Date: Fri, 13 Dec 2019 00:25:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAPan3Woucroq2+c5J8Trw+ssEMD4tnwfKzPeOf3AZKmv_R0EgQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: eCeedy-bMOywOO26SYxKWQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Alex.

On 12/13/19 12:07 AM, Niek Linnenbank wrote:
> Hi Philippe,
>=20
> I have discovered that the hflags assertion error you reported is not=20
> caused by the Allwinner H3
> patches but actually an existing problem. What I did is to use the=20
> latest master (v4.2.0 tag) without any patches applied.
> and tried to boot the raspi2 machine with and without debugging enabled.=
=20
> Without debuggin, the raspi2
> machine runs fine and can boot the 5.4.2 linux kernel. With debugging=20
> enabled, the same hflags error shows.

This might be the same bug I hit last week... Alex suggested a patch:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg664500.html

Do you mind to try it?

If it still fails, you might also add this one on top:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg663843.html
and report the error.

>=20
> To reproduce it, build Linux 5.4.2 with the bmc2835_defconfig:
>=20
> $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make mrproper
> $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make bcm2835_defconfig
> $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make -j5
> ...
>=20
> First build QEMU without debugging and try to boot linux:
> $ ./configure --target-list=3Darm-softmmu; make clean; make -j5
> $ ./arm-softmmu/qemu-system-arm -M raspi2 \
>    -kernel $HOME/linux-5.4.2/arch/arm/boot/zImage \
>    -append 'console=3DttyAMA0,115200 earlyprintk debug' \
>    -dtb $HOME/linux-5.4.2/arch/arm/boot/dts/bcm2836-rpi-2-b.dtb \
>    -m 1024 -nographic -s
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 5.4.2 (me@host) (gcc version 7.4.0 (Ubuntu/L=
inaro 7.4.0-1ubuntu1~18.04.1)) #1 Thu Dec 12 22:49:14 CET 2019
> [    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=3D1=
0c53c7d
> ...
>=20
> Then rebuild QEMU with debugging enabled and again try to boot linux:
> $ ./configure --target-list=3Darm-softmmu --enable-debug --extra-cflags=
=3D-ggdb; make clean; make -j5
> $ ./arm-softmmu/qemu-system-arm -M raspi2 \
>    -kernel $HOME/linux-5.4.2/arch/arm/boot/zImage \
>    -append 'console=3DttyAMA0,115200 earlyprintk debug' \
>    -dtb $HOME/linux-5.4.2/arch/arm/boot/dts/bcm2836-rpi-2-b.dtb \
>    -m 1024 -nographic -s
> qemu-system-arm: /home/me/qemu/target/arm/helper.c:11359: cpu_get_tb_cpu_=
state: Assertion `flags =3D=3D rebuild_hflags_internal(env)' failed.
> qemu-system-arm: /home/me/qemu/target/arm/helper.c:11359: cpu_get_tb_cpu_=
state: Assertion `flags =3D=3D rebuild_hflags_internal(env)' failed.
> qemu-system-arm: /home/me/qemu/target/arm/helper.c:11359: cpu_get_tb_cpu_=
state: Assertion `flags =3D=3D rebuild_hflags_internal(env)' failed.
> Aborted (core dumped)
>=20
> $ git describe
> v4.2.0
>=20
>=20
> What should be the next step? Should this be reported as a bug?

In this case we might already have the fix, but if Alex patch doesn't=20
help, you are always welcome to open a bug report:
https://bugs.launchpad.net/qemu/+filebug
This help to have notes/progress gathered.

> On Tue, Dec 10, 2019 at 9:12 PM Niek Linnenbank=20
> <nieklinnenbank@gmail.com <mailto:nieklinnenbank@gmail.com>> wrote:
>=20
>     Hi Philippe,
>=20
>     On Tue, Dec 10, 2019 at 9:26 AM Philippe Mathieu-Daud=C3=A9
>     <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
>=20
>         On 12/9/19 10:37 PM, Niek Linnenbank wrote:
>          > Hi Philippe,
>          >
>          > On Tue, Dec 3, 2019 at 9:47 AM Philippe Mathieu-Daud=C3=A9
>         <philmd@redhat.com <mailto:philmd@redhat.com>
>          > <mailto:philmd@redhat.com <mailto:philmd@redhat.com>>> wrote:
>          >
>          >=C2=A0 =C2=A0 =C2=A0On 12/2/19 10:09 PM, Niek Linnenbank wrote:
>          >=C2=A0 =C2=A0 =C2=A0 > Dear QEMU developers,
>          >=C2=A0 =C2=A0 =C2=A0 >
>          >=C2=A0 =C2=A0 =C2=A0 > Hereby I would like to contribute the fo=
llowing set of
>         patches to
>          >=C2=A0 =C2=A0 =C2=A0QEMU
>          >=C2=A0 =C2=A0 =C2=A0 > which add support for the Allwinner H3 S=
ystem on Chip
>         and the
>          >=C2=A0 =C2=A0 =C2=A0 > Orange Pi PC machine. The following feat=
ures and
>         devices are
>          >=C2=A0 =C2=A0 =C2=A0supported:
>          >=C2=A0 =C2=A0 =C2=A0 >
>          >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0* SMP (Quad Core Cortex A7)
>          >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0* Generic Interrupt Controll=
er configuration
>          >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0* SRAM mappings
>          >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0* Timer device (re-used from=
 Allwinner A10)
>          >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0* UART
>          >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0* SD/MMC storage controller
>          >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0* EMAC ethernet connectivity
>          >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0* USB 2.0 interfaces
>          >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0* Clock Control Unit
>          >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0* System Control module
>          >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0* Security Identifier device
>          >
>          >=C2=A0 =C2=A0 =C2=A0Awesome!
>          >
>          >=C2=A0 =C2=A0 =C2=A0 > Functionality related to graphical outpu=
t such as
>         HDMI, GPU,
>          >=C2=A0 =C2=A0 =C2=A0 > Display Engine and audio are not include=
d. Recently
>         released
>          >=C2=A0 =C2=A0 =C2=A0 > mainline Linux kernels (4.19 up to lates=
t master) and
>         mainline U-Boot
>          >=C2=A0 =C2=A0 =C2=A0 > are known to work. The SD/MMC code is te=
sted using
>         bonnie++ and
>          >=C2=A0 =C2=A0 =C2=A0 > various tools such as fsck, dd and fdisk=
. The EMAC is
>         verified
>          >=C2=A0 =C2=A0 =C2=A0with iperf3
>          >=C2=A0 =C2=A0 =C2=A0 > using -netdev socket.
>          >=C2=A0 =C2=A0 =C2=A0 >
>          >=C2=A0 =C2=A0 =C2=A0 > To build a Linux mainline kernel that ca=
n be booted by
>         the Orange
>          >=C2=A0 =C2=A0 =C2=A0Pi PC
>          >=C2=A0 =C2=A0 =C2=A0 > machine, simply configure the kernel usi=
ng the
>         sunxi_defconfig
>          >=C2=A0 =C2=A0 =C2=A0configuration:
>          >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0$ ARCH=3Darm CROSS_COMPILE=
=3Darm-linux-gnueabi- make
>         mrproper
>          >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0$ ARCH=3Darm CROSS_COMPILE=
=3Darm-linux-gnueabi- make
>         sunxi_defconfig
>          >=C2=A0 =C2=A0 =C2=A0 >
>          >=C2=A0 =C2=A0 =C2=A0 > To be able to use USB storage, you need =
to manually
>         enable the
>          >=C2=A0 =C2=A0 =C2=A0corresponding
>          >=C2=A0 =C2=A0 =C2=A0 > configuration item. Start the kconfig co=
nfiguration tool:
>          >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0$ ARCH=3Darm CROSS_COMPILE=
=3Darm-linux-gnueabi- make
>         menuconfig
>          >=C2=A0 =C2=A0 =C2=A0 >
>          >=C2=A0 =C2=A0 =C2=A0 > Navigate to the following item, enable i=
t and save your
>          >=C2=A0 =C2=A0 =C2=A0configuration:
>          >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0Device Drivers > USB support=
 > USB Mass Storage support
>          >=C2=A0 =C2=A0 =C2=A0 >
>          >=C2=A0 =C2=A0 =C2=A0 > Build the Linux kernel with:
>          >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0$ ARCH=3Darm CROSS_COMPILE=
=3Darm-linux-gnueabi- make -j5
>          >=C2=A0 =C2=A0 =C2=A0 >
>          >=C2=A0 =C2=A0 =C2=A0 > To boot the newly build linux kernel in =
QEMU with the
>         Orange Pi
>          >=C2=A0 =C2=A0 =C2=A0PC machine, use:
>          >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0$ qemu-system-arm -M orangep=
i -m 512 -nic user
>         -nographic \
>          >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0 =C2=A0-kernel /path/=
to/linux/arch/arm/boot/zImage \
>          >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0 =C2=A0-append 'conso=
le=3DttyS0,115200' \
>          >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0 =C2=A0-dtb
>         /path/to/linux/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb
>          >=C2=A0 =C2=A0 =C2=A0 >
>          >=C2=A0 =C2=A0 =C2=A0 > Note that this kernel does not have a ro=
ot filesystem.
>         You may
>          >=C2=A0 =C2=A0 =C2=A0provide it
>          >=C2=A0 =C2=A0 =C2=A0 > with an official Orange Pi PC image [1] =
either as an
>         SD card or as
>          >=C2=A0 =C2=A0 =C2=A0 > USB mass storage. To boot using the Oran=
ge Pi PC
>         Debian image on
>          >=C2=A0 =C2=A0 =C2=A0SD card,
>          >=C2=A0 =C2=A0 =C2=A0 > simply add the -sd argument and provide =
the proper
>         root=3D kernel
>          >=C2=A0 =C2=A0 =C2=A0parameter:
>          >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0$ qemu-system-arm -M orangep=
i -m 512 -nic user
>         -nographic \
>          >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0 =C2=A0-kernel /path/=
to/linux/arch/arm/boot/zImage \
>          >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0 =C2=A0-append 'conso=
le=3DttyS0,115200 root=3D/dev/mmcblk0p2' \
>          >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0 =C2=A0-dtb
>          >=C2=A0 =C2=A0 =C2=A0/path/to/linux/arch/arm/boot/dts/sun8i-h3-o=
rangepi-pc.dtb \
>          >=C2=A0 =C2=A0 =C2=A0 >=C2=A0 =C2=A0 =C2=A0 =C2=A0-sd
>         OrangePi_pc_debian_stretch_server_linux5.3.5_v1.0.img
>          >=C2=A0 =C2=A0 =C2=A0 >
>          >=C2=A0 =C2=A0 =C2=A0 > Alternatively, you can also choose to bu=
ild and boot a
>         recent
>          >=C2=A0 =C2=A0 =C2=A0buildroot [2]
>          >=C2=A0 =C2=A0 =C2=A0 > using the orangepi_pc_defconfig or Armbi=
an image [3]
>         for Orange
>          >=C2=A0 =C2=A0 =C2=A0Pi PC.
>          >
>          >=C2=A0 =C2=A0 =C2=A0Richard, trying the Armbian image from
>          > https://apt.armbian.com/pool/main/l/linux-4.20.7-sunxi/ I get:
>          >
>          >=C2=A0 =C2=A0 =C2=A0$ arm-softmmu/qemu-system-arm -M orangepi -=
m 512 -nic user \
>          >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-append 'console=3DttyS0,1152=
00' \
>          >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-kernel boot/vmlinuz-4.20.7-s=
unxi \
>          >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-dtb
>         usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-pc.dtb \
>          >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-serial stdio -d unimp
>          >=C2=A0 =C2=A0 =C2=A0Uncompressing Linux... done, booting the ke=
rnel.
>          >=C2=A0 =C2=A0 =C2=A0rtc: unimplemented device write (size 4, va=
lue
>         0x16aa0001, offset 0x0)
>          >=C2=A0 =C2=A0 =C2=A0rtc: unimplemented device read (size 4, off=
set 0x0)
>          >=C2=A0 =C2=A0 =C2=A0rtc: unimplemented device read (size 4, off=
set 0x0)
>          >=C2=A0 =C2=A0 =C2=A0rtc: unimplemented device read (size 4, off=
set 0x8)
>          >=C2=A0 =C2=A0 =C2=A0qemu-system-arm: target/arm/helper.c:11359:
>         cpu_get_tb_cpu_state:
>          >=C2=A0 =C2=A0 =C2=A0Assertion `flags =3D=3D rebuild_hflags_inte=
rnal(env)' failed.
>          >=C2=A0 =C2=A0 =C2=A0Aborted (core dumped)
>          >
>          >
>          > I'm trying to reproduce the error you reported here with my
>         patch set on
>          > latest master,
>          > but so far without any result. The host OS I'm using is
>         Ubuntu 18.04.3
>          > LTS on x86_64.
>          > I ran several times using the same 4.20.7-sunxi kernel and
>         same command
>          > line.
>          >
>          > Some questions that might help:
>          > 1) Are there any specific steps you did in order to produce
>         this error?
>=20
>         I build QEMU with:
>=20
>         ./configure --enable-trace-backends=3Dlog --extra-cflags=3D-ggdb
>         --enable-debug
>=20
>          > 2) Could this be a known / existing issue?
>          > 3) How many times did you see this error?
>=20
>         Always
>=20
>          > 4) Are you also using Ubuntu 18.04.3 LTS on x86_64, or a
>         different host OS?
>=20
>         Host is Fedora 30.
>=20
>=20
>     OK thanks, I will try again using the info above after I finished
>     reworking the other patch comments.
>=20
>     Niek


