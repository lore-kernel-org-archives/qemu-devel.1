Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCB7C33CB1
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 09:01:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7DB206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 09:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="g/vUmzvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7DB206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1it6Sz-000118-ND
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 04:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1it6L7-0006WL-78
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 03:53:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1it6L4-00034H-Jw
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 03:53:49 -0500
Received: from mout.gmx.net ([212.227.15.15]:60301)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>)
 id 1it6L4-00033a-4j; Sun, 19 Jan 2020 03:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1579424008;
 bh=ahn4fvKK87+ZG2+aO7SpaR64fm0hb++AxKczKceteys=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=g/vUmzvBdkmIbEo1tdHGaKSLic19Y408QOIjRelVq57iP0SurTNyWwd0PYK+m8rnr
 RvcOmd3iIjPXB9UuhjjUDVu5kttQ90XPPgjd8UyX63nHKbL442ItVcHSSeLVgQ6g31
 M1eQ7ZaiN3yfUzXJ77TuRHrXJ43mjgurPryuH86I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MuDXz-1jlTTO43SP-00ucVQ; Sun, 19
 Jan 2020 09:53:28 +0100
Subject: Re: [PATCH 0/4] tests/boot_linux_console: Test booting NetBSD via
 U-Boot on OrangePi PC
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20200118191623.32549-1-f4bug@amsat.org>
From: Kamil Rytarowski <n54@gmx.com>
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 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
 4XSbcg==
Message-ID: <34207028-dbd4-4886-3b54-2e973b3fdb10@gmx.com>
Date: Sun, 19 Jan 2020 09:52:47 +0100
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200118191623.32549-1-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qRVxaDxvnBDa7fW3pPFSMKyKV5t76uQPg"
X-Provags-ID: V03:K1:XHGt3VUi3h0oM2CL3z+6YQQ3cWZmHMcwiVVw5xp7JgvN9L2Vl7B
 4MM955l/z5recaYst95+FGH2e7oop4C0gpWKYsDVIx0fqxbLJ94cn9vALElS+51TyJto7ia
 xelAU3eP7Q6UALU6hFrbIbg2lp27dbIROkyNmdOTgz0X1bXxr7fFHL2wHa0qO/IpxScrj2d
 uh2lkqx8pQXHY6PoL+orQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nmJ+WZftDwg=:BzeWGXLFvEeHb4ayv/Vv+L
 zf9YElVgnuMXP3vMCi9bvJX/BBWl8w+DWQqJ2nPVm0xWMlItM+7jyhtqDcLh+/4rbq31FHgW1
 s//m0vZewrChMmwOKuG1G8ZZLVYxgYILhpGcGY765aTmKV5fKzo545M64LW+yrED4GpHskets
 4A+pY7X5FibrUZiqNr0ZvM0zH46O2u1pT4vzaCFxkpS2vHn9J02WkVQeleOCYMWq4jijtA5gt
 gTjhv/zXAV3fOP7Y5ZUQEu3ildze2MbaEyHMO8mjrTDK7tpBhXX2NdNSHEPbcXkbAMhsDvZW7
 EXrQT/8EzeEjSOLvoK//4ktwhdsZO8W2qSIcKlamWO2dHWg70VCJCZoebmLneUnx3k+rrjbSo
 dIWxpJpi8/S07GWTDD4SFFem2wqi8qSUvfyuYuzgsGA3GkZ3libqhAW04AuQgj93QrrOwWvvH
 E84zG6dtw+X79jB+vgI7F4CpVbrEupTmDZy8LtA/RocpPVAmKurUZFJJhKRT3DzLFn0Swr2h/
 4N2eNPoDTuqzNB8oLJbU/vueBLhzmdAqNpIAffpDmAHNocxjfq8xO4NwBbXZNeGwAyavt0iBv
 sV0x/5yvk+sKcJMEnJqOb1CiixXM8q0hzcHnoCQcLIfeLjqGQqRqlD0ebvo9ZhUWtY7HSw8wZ
 20uKHLoW8iCKzwryOt/GwWQCH4BoTRvWBwakYxvNWtxqPYb0L+9H1RXmBOrL75gtHevc/tvmd
 o5lOtrEKcGMQogTuvCMESnnAgEA1GVCWTwz9wLn0RheEkWXdu2J4ELjuDvuKt/fR0XGdlAAkR
 DCmC8K0HxNDoQ0k+3Gu/h1LO62iZqHkJ0hFlltMyY7AntQuelaB2JfQYyisUPKRNOZkAES3SE
 rc3A9ni9XiYFhlNrw3cobXDRtHepW14eEJQTR32OLZE0DOPybhodF8LyMjFaDL7y4LbmON4rj
 twnjaUA6C19AzuC84TAgnOXE0yMd+G8xBKviHSg5KNxcziY+3/Ec0ptSssiklPixoRkbhQPUV
 HsdgzGLbV2ZhlCzWak22eYI7ZNHvwjXsNMx9Z3i1w702qNdkEdbHoJcAdzw7mtKqYAAK1TVOI
 uy9fi04v0TveXxnXdQe0k3JyVCgZdo5RVtxN3zMUcPrtytk42U+pGZpPbVysA0SnlXNUHECQN
 QWuLZZAa0WqRbNgccq+FYs1wd6IRR9wn2rrgfL1avhzf/DUx7FnyosMjApRW3PUtwdmH9Cq9f
 HaY/nJBpDFpV/qkPn1s2ttjIQm2E1SEx4ZR2U6Q==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.15
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qRVxaDxvnBDa7fW3pPFSMKyKV5t76uQPg
Content-Type: multipart/mixed; boundary="HK4t6R4G6GQBDlGzwQ4yCCxPhFKCWOJld";
 protected-headers="v1"
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>
Message-ID: <34207028-dbd4-4886-3b54-2e973b3fdb10@gmx.com>
Subject: Re: [PATCH 0/4] tests/boot_linux_console: Test booting NetBSD via
 U-Boot on OrangePi PC
References: <20200118191623.32549-1-f4bug@amsat.org>
In-Reply-To: <20200118191623.32549-1-f4bug@amsat.org>

--HK4t6R4G6GQBDlGzwQ4yCCxPhFKCWOJld
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Thank you for improving testing of the NetBSD target.

On 18.01.2020 20:16, Philippe Mathieu-Daud=C3=A9 wrote:
> This series add a test on the OrangePi PC for:
> - SD Card booting
> - U-boot & UART
> - NetBSD 9
>=20
> I simply followed Niek description in docs/orangepi.rst:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg669347.html
>=20
> The sdcard image is big, but the test runs very quick (1min),
> even on Travis CI: https://travis-ci.org/philmd/qemu/jobs/638823612#L37=
78
>=20
> (11/48) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_ar=
m_orangepi_uboot_netbsd9:  PASS (65.17 s)
>=20
>   $ TMPDIR=3D/tmp AVOCADO_ALLOW_LARGE_STORAGE=3Dyes avocado --show=3Dap=
p,console run -t machine:orangepi-pc tests/acceptance/boot_linux_console.=
py
>   JOB ID     : 4e11f0d22d121fd766ab5f0956ec464cf9fce64b
>   JOB LOG    : /home/phil/avocado/job-results/job-2020-01-18T19.14-4e11=
f0d/job.log
>    (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_a=
rm_orangepi_uboot_netbsd9:
>   console: U-Boot SPL 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000)
>   console: DRAM: 1024 MiB
>   console: Failed to set core voltage! Can't set CPU frequency
>   console: Trying to boot from MMC1
>   console: U-Boot 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000) Allwinn=
er Technology
>   console: CPU:   Allwinner H3 (SUN8I 0000)
>   console: Model: Xunlong Orange Pi Plus / Plus 2
>   console: DRAM:  1 GiB
>   console: MMC:   Device 'mmc@1c11000': seq 1 is in use by 'mmc@1c10000=
'
>   console: mmc@1c0f000: 0, mmc@1c10000: 2, mmc@1c11000: 1
>   console: Loading Environment from FAT... Warning: HDMI PHY init timeo=
ut!
>   console: Warning: HDMI PHY init timeout!
>   console: In:    serial
>   console: Out:   serial
>   console: Err:   serial
>   console: Net:   phy interface7
>   console: Could not get PHY for ethernet@1c30000: addr 0
>   console: No ethernet found.
>   console: starting USB...
>   console: Bus usb@1c1b000: USB EHCI 1.00
>   console: Bus usb@1c1d000: USB EHCI 1.00
>   console: scanning bus usb@1c1b000 for devices... 1 USB Device(s) foun=
d
>   console: scanning bus usb@1c1d000 for devices... 1 USB Device(s) foun=
d
>   console: scanning usb for storage devices... 0 Storage Device(s) foun=
d
>   console: Hit any key to stop autoboot:  0
>   console: =3D>
>   console: =3D>
>   console: =3D>
>   console: =3D>
>   console: =3D>
>   console: =3D>
>   console: =3D>
>   console: =3D>
>   console: =3D>
>   console: =3D>
>   console: =3D>
>   console: =3D>
>   console: =3D>
>   console: =3D>
>   console: =3D>
>   console: =3D>
>   console: =3D>
>   console: =3D>
>   console: =3D>
>   console: =3D> setenv bootargs root=3Dld0a
>   console: =3D> setenv kernel netbsd-GENERIC.ub
>   console: =3D> setenv fdtfile dtb/sun8i-h3-orangepi-pc.dtb
>   console: =3D> setenv bootcmd 'fatload mmc 0:1 ${kernel_addr_r} ${kern=
el}; fatload mmc 0:1 ${fdt_addr_r} ${fdtfile}; fdt addr ${fdt_addr_r}; bo=
otm ${kernel_addr_r} - ${fdt_addr_r}'
>   console: =3D> boot
>   console: 8850008 bytes read in 2583 ms (3.3 MiB/s)
>   console: 28162 bytes read in 34 ms (808.6 KiB/s)
>   console: ## Booting kernel from Legacy Image at 42000000 ...
>   console: Image Name:   NetBSD/earmv7hf 9.0_RC1
>   console: Image Type:   ARM Linux Kernel Image (no loading done) (unco=
mpressed)
>   console: Data Size:    8849944 Bytes =3D 8.4 MiB
>   console: Load Address: 00000000
>   console: Entry Point:  00000000
>   console: Verifying Checksum ... OK
>   console: ## Flattened Device Tree blob at 43000000
>   console: Booting using the fdt blob at 0x43000000
>   console: XIP Kernel Image (no loading done)
>   console: Loading Device Tree to 49ff6000, end 49fffe01 ... OK
>   console: Starting kernel ...
>   console: [   1.0000000] NetBSD/evbarm (fdt) booting ...
>   console: [   1.0000000] [ Kernel symbol table missing! ]
>   console: [   1.0000000] Copyright (c) 1996, 1997, 1998, 1999, 2000, 2=
001, 2002, 2003, 2004, 2005,
>   console: [   1.0000000]     2006, 2007, 2008, 2009, 2010, 2011, 2012,=
 2013, 2014, 2015, 2016, 2017,
>   console: [   1.0000000]     2018, 2019 The NetBSD Foundation, Inc.  A=
ll rights reserved.
>   console: [   1.0000000] Copyright (c) 1982, 1986, 1989, 1991, 1993
>   console: [   1.0000000]     The Regents of the University of Californ=
ia.  All rights reserved.
>   console: [   1.0000000] NetBSD 9.0_RC1 (GENERIC) #0: Wed Nov 27 16:14=
:52 UTC 2019
>   console: [   1.0000000]         mkrepro@mkrepro.NetBSD.org:/usr/src/s=
ys/arch/evbarm/compile/GENERIC
>   console: [   1.0000000] total memory =3D 1024 MB
>   console: [   1.0000000] avail memory =3D 1003 MB
>   console: [   1.0000000] armfdt0 (root)
>   console: [   1.0000000] simplebus0 at armfdt0: Xunlong Orange Pi PC
>   console: [   1.0000000] simplebus1 at simplebus0
>   console: [   1.0000000] simplebus2 at simplebus0
>   console: [   1.0000000] cpus0 at simplebus0
>   console: [   1.0000000] simplebus3 at simplebus0
>   console: [   1.0000000] cpu0 at cpus0: Cortex-A7 r0p5 (Cortex V7A cor=
e)
>   console: [   1.0000000] cpu0: DC enabled IC enabled WB enabled LABT b=
ranch prediction enabled
>   console: [   1.0000000] cpu0: 32KB/64B 2-way L1 VIPT Instruction cach=
e
>   console: [   1.0000000] cpu0: 32KB/64B 2-way write-back-locking-C L1 =
PIPT Data cache
>   console: [   1.0000000] cpu0: 2304KB/64B 16-way write-through L2 PIPT=
 Unified cache
>   console: [   1.0000000] vfp0 at cpu0: NEON MPE (VFP 3.0+), rounding, =
NaN propagation, denormals
>   console: [   1.0000000] cpufreqdt0 at cpu0
>   console: [   1.0000000] cpu1 at cpus0
>   console: [   1.0000000] cpufreqdt1 at cpu1
>   console: [   1.0000000] cpu2 at cpus0
>   console: [   1.0000000] cpufreqdt2 at cpu2
>   console: [   1.0000000] cpu3 at cpus0
>   console: [   1.0000000] cpufreqdt3 at cpu3
>   console: [   1.0000000] gic0 at simplebus1: GIC
>   console: [   1.0000000] armgic0 at gic0: Generic Interrupt Controller=
, 160 sources (160 valid)
>   console: [   1.0000000] armgic0: 256 Priorities, 128 SPIs, 16 PPIs, 1=
6 SGIs
>   console: [   1.0000000] fclock0 at simplebus2: 24000000 Hz fixed cloc=
k (osc24M)
>   console: [   1.0000000] fclock1 at simplebus2: 32768 Hz fixed clock (=
ext_osc32k)
>   console: [   1.0000000] gtmr0 at simplebus0: Generic Timer
>   console: [   1.0000000] gtmr0: interrupting on GIC irq 27
>   console: [   1.0000000] armgtmr0 at gtmr0: Generic Timer (24000 kHz, =
virtual)
>   console: [   1.0000060] sun8ih3ccu0 at simplebus1: H3 CCU
>   console: [   1.0000060] sun8ih3rccu0 at simplebus1: H3 PRCM CCU
>   console: [   1.0000060] sunxigpio0 at simplebus1: PIO
>   console: [   1.0000060] gpio0 at sunxigpio0: 94 pins
>   console: [   1.0000060] sunxigpio0: interrupting on GIC irq 43
>   console: [   1.0000060] sunxigpio1 at simplebus1: PIO
>   console: [   1.0000060] gpio1 at sunxigpio1: 12 pins
>   console: [   1.0000060] sunxigpio1: interrupting on GIC irq 77
>   console: [   1.0000060] sunxisramc0 at simplebus1: SRAM Controller
>   console: [   1.0000060] sun6idma0 at simplebus1: DMA controller (12 c=
hannels)
>   console: [   1.0000060] sun6idma0: interrupting on GIC irq 82
>   console: [   1.0000060] connector0 at simplebus0: HDMI connector
>   console: [   1.0000060] com0 at simplebus1: ns16550a, working fifo
>   console: [   1.0000060] com0: console
>   console: [   1.0000060] com0: interrupting on GIC irq 32
>   console: [   1.0000060] fregulator0 at simplebus0: vcc3v3
>   console: [   1.0000060] fregulator1 at simplebus0: usb0-vbus
>   console: [   1.0000060] fregulator2 at simplebus0: vcc3v0
>   console: [   1.0000060] fregulator3 at simplebus0: vcc5v0
>   console: [   1.0000060] sunxiusbphy0 at simplebus1: USB PHY
>   console: [   1.0000060] /soc/clock@1000000 at simplebus1 not configur=
ed
>   console: [   1.0000060] /soc/mixer@1100000 at simplebus1 not configur=
ed
>   console: [   1.0000060] /soc/lcd-controller@1c0c000 at simplebus1 not=
 configured
>   console: [   1.0000060] /soc/hdmi@1ee0000 at simplebus1 not configure=
d
>   console: [   1.0000060] sunxirtc0 at simplebus1: RTC
>   console: [   1.0000060] emac0 at simplebus1: EMAC
>   console: [   1.0000060] emac0: Ethernet address 52:54:00:12:34:56
>   console: [   1.0000060] emac0: interrupting on GIC irq 114
>   console: [   1.0000060] ukphy0 at emac0 phy 1: OUI 0x0088a0, model 0x=
0000, rev. 0
>   console: [   1.0000060] ukphy0: 10baseT, 10baseT-FDX, 100baseTX, 100b=
aseTX-FDX, 100baseT4, auto
>   console: [   1.0000060] h3codec0 at simplebus1: H3 Audio Codec (analo=
g part)
>   console: [   1.0000060] /soc/hdmi-phy@1ef0000 at simplebus1 not confi=
gured
>   console: [   1.0000060] /opp_table0 at simplebus0 not configured
>   console: [   1.0000060] sunxitwi0 at simplebus1: Marvell TWSI control=
ler
>   console: [   1.0000060] sunxitwi0: interrupting on GIC irq 76
>   console: [   1.0000060] iic0 at sunxitwi0: I2C bus
>   console: [   1.0000060] sy8106a0 at iic0 addr 0x65: Silergy SY8106A r=
egulator
>   console: [   1.0000060] /display-engine at simplebus0 not configured
>   console: [   1.0000060] sunximmc0 at simplebus1: SD/MMC controller
>   console: [   1.0000060] sunximmc0: interrupting on GIC irq 92
>   console: [   1.0000060] motg0 at simplebus1: 'otg' mode not supported=

>   console: [   1.0000060] ehci0 at simplebus1: EHCI
>   console: [   1.0000060] ehci0: interrupting on GIC irq 104
>   console: ehci0: ohci or uhci probably not configured
>   console: [   1.0000060] usb0 at ehci0: USB revision 2.0
>   console: [   1.0000060] ohci0 at simplebus1: OHCI
>   console: [   1.0000060] ohci0: interrupting on GIC irq 105
>   console: [   1.0000060] ohci0: OHCI version 1.0
>   console: [   1.0000060] usb1 at ohci0: USB revision 1.0
>   console: [   1.0000060] ehci1 at simplebus1: EHCI
>   console: [   1.0000060] ehci1: interrupting on GIC irq 106
>   console: ehci1: ohci or uhci probably not configured
>   console: [   1.0000060] usb2 at ehci1: USB revision 2.0
>   console: [   1.0000060] ohci1 at simplebus1: OHCI
>   console: [   1.0000060] ohci1: interrupting on GIC irq 107
>   console: [   1.0000060] ohci1: OHCI version 1.0
>   -console: [   1.0000060] usb3 at ohci1: USB revision 1.0
>   console: [   1.0000060] ehci2 at simplebus1: EHCI
>   console: [   1.0000060] ehci2: interrupting on GIC irq 108
>   console: ehci2: ohci or uhci probably not configured
>   console: [   1.0000060] usb4 at ehci2: USB revision 2.0
>   console: [   1.0000060] ohci2 at simplebus1: OHCI
>   console: [   1.0000060] ohci2: interrupting on GIC irq 109
>   console: [   1.0000060] ohci2: OHCI version 1.0
>   console: [   1.0000060] usb5 at ohci2: USB revision 1.0
>   console: [   1.0000060] ehci3 at simplebus1: EHCI
>   console: [   1.0000060] ehci3: interrupting on GIC irq 110
>   console: ehci3: ohci or uhci probably not configured
>   console: [   1.0000060] usb6 at ehci3: USB revision 2.0
>   console: [   1.0000060] ohci3 at simplebus1: OHCI
>   console: [   1.0000060] ohci3: interrupting on GIC irq 111
>   console: [   1.0000060] ohci3: OHCI version 1.0
>   console: [   1.0000060] usb7 at ohci3: USB revision 1.0
>   console: [   1.0000060] sunxiwdt0 at simplebus1: Watchdog
>   console: [   1.0000060] sunxiwdt0: default watchdog period is 16 seco=
nds
>   console: [   1.0000060] sunxicodec0 at simplebus1: H3 Audio Codec
>   console: [   1.0000060] audio0 at sunxicodec0: playback, capture, ful=
l duplex, independent
>   console: [   1.0000060] audio0: slinear_le:16 2ch 48000Hz, blk 40ms f=
or playback
>   console: [   1.0000060] audio0: slinear_le:16 2ch 48000Hz, blk 40ms f=
or recording
>   console: [   1.0000060] spkr0 at audio0: PC Speaker (synthesized)
>   console: [   1.0000060] wsbell at spkr0 not configured
>   console: [   1.0000060] /soc/ir@1f02000 at simplebus1 not configured
>   console: [   1.0000060] /soc/gpu@1c40000 at simplebus1 not configured=

>   console: [   1.0000060] psci0 at simplebus0: PSCI 0.1
>   console: [   1.0000060] gpioleds0 at simplebus0: orangepi:green:pwr o=
rangepi:red:status
>   console: [   1.0000060] gpiokeys0 at simplebus0: sw4
>   console: [   1.0000060] sunxitimer0 at simplebus1: Timer
>   console: [   1.0000060] /soc/video-codec@1c0e000 at simplebus1 not co=
nfigured
>   console: [   1.0000060] cpu3: Cortex-A7 r0p5 (Cortex V7A core)
>   console: [   1.0000060] cpu3: DC enabled IC enabled WB enabled LABT b=
ranch prediction enabled
>   console: [   1.0000060] cpu3: 32KB/64B 2-way L1 VIPT Instruction cach=
e
>   console: [   1.0000060] cpu3: 32KB/64B 2-way write-back-locking-C L1 =
PIPT Data cache
>   console: [   1.0160154] cpu3: 2304KB/64B 16-way write-through L2 PIPT=
 Unified cache
>   console: [   1.0234452] vfp3 at cpu3: NEON MPE (VFP 3.0+), rounding, =
NaN propagation, denormals
>   console: [   1.0291986] cpu1: Cortex-A7 r0p5 (Cortex V7A core)
>   console: [   1.0291986] cpu1: DC enabled IC enabled WB enabled LABT b=
ranch prediction enabled
>   console: [   1.0291986] cpu1: 32KB/64B 2-way L1 VIPT Instruction cach=
e
>   console: [   1.0394135] cpu1: 32KB/64B 2-way write-back-locking-C L1 =
PIPT Data cache
>   console: [   1.0394135] cpu1: 2304KB/64B 16-way write-through L2 PIPT=
 Unified cache
>   console: [   1.0394135] vfp1 at cpu1: NEON MPE (VFP 3.0+), rounding, =
NaN propagation, denormals
>   console: [   1.0493315] cpu2: Cortex-A7 r0p5 (Cortex V7A core)
>   console: [   1.0634020] cpu2: DC enabled IC enabled WB enabled LABT b=
ranch prediction enabled
>   console: [   1.0694913] cpu2: 32KB/64B 2-way L1 VIPT Instruction cach=
e
>   console: [   1.0694913] cpu2: 32KB/64B 2-way write-back-locking-C L1 =
PIPT Data cache
>   console: [   1.0806243] cpu2: 2304KB/64B 16-way write-through L2 PIPT=
 Unified cache
>   console: [   1.0896281] vfp2 at cpu2: NEON MPE (VFP 3.0+), rounding, =
NaN propagation, denormals
>   console: [   1.6053940] sdmmc0 at sunximmc0
>   console: [   1.9566931] uhub0 at usb0: NetBSD (0000) EHCI root hub (0=
000), class 9/0, rev 2.00/1.00, addr 1
>   console: [   2.0663940] uhub1 at usb2: NetBSD (0000) EHCI root hub (0=
000), class 9/0, rev 2.00/1.00, addr 1
>   console: [   2.1170633] uhub2 at usb1: NetBSD (0000) OHCI root hub (0=
000), class 9/0, rev 1.00/1.00, addr 1
>   console: [   2.2277627] uhub3 at usb4: NetBSD (0000) EHCI root hub (0=
000), class 9/0, rev 2.00/1.00, addr 1
>   console: [   2.2800297] uhub4 at usb3: NetBSD (0000) OHCI root hub (0=
000), class 9/0, rev 1.00/1.00, addr 1
>   console: [   2.3289886] uhub5 at usb6: NetBSD (0000) EHCI root hub (0=
000), class 9/0, rev 2.00/1.00, addr 1
>   console: [   2.4083724] uhub6 at usb7: NetBSD (0000) OHCI root hub (0=
000), class 9/0, rev 1.00/1.00, addr 1
>   console: [   2.4895047] uhub7 at usb5: NetBSD (0000) OHCI root hub (0=
000), class 9/0, rev 1.00/1.00, addr 1
>   console: [   2.8171937] sdmmc0: SD card status: 4-bit, C0
>   console: [   2.8234040] ld0 at sdmmc0: <0xaa:0x5859:QEMU!:0x01:0xdead=
beef:0x062>
>   console: [   2.8743967] ld0: 1290 MB, 655 cyl, 64 head, 63 sec, 512 b=
ytes/sect x 2642944 sectors
>   console: [   3.1588850] ld0: 4-bit width, High-Speed/SDR25, 50.000 MH=
z
>   console: [   4.9942260] WARNING: 4 errors while detecting hardware; c=
heck system log.
>   console: [   5.0142912] boot device: ld0
>   console: [   5.0551260] root on ld0a dumps on ld0b
>   console: [   5.2175484] root file system type: ffs
>   console: [   5.2858559] kern.module.path=3D/stand/evbarm/9.0/modules
>   console: Tue Jan 18 18:15:15 UTC 2050
>   console: Starting root file system check:
>   PASS (35.96 s)
>   RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT =
0 | CANCEL 0
>   JOB TIME   : 36.09 s
>=20
> Based-on: <20200108200020.4745-1-nieklinnenbank@gmail.com>
> "Add Allwinner H3 SoC and Orange Pi PC Machine" v3
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg669328.html
>=20
> Philippe Mathieu-Daud=C3=A9 (4):
>   Acceptance tests: Extract _console_interaction()
>   Acceptance tests: Add interrupt_interactive_console_until_pattern()
>   tests/boot_linux_console: Test booting NetBSD via U-Boot on OrangePi
>     PC
>   .travis.yml: Allow untrusted code and large files
>=20
>  .travis.yml                               |  2 +
>  tests/acceptance/avocado_qemu/__init__.py | 59 ++++++++++++++++-----
>  tests/acceptance/boot_linux_console.py    | 63 +++++++++++++++++++++++=

>  3 files changed, 110 insertions(+), 14 deletions(-)
>=20



--HK4t6R4G6GQBDlGzwQ4yCCxPhFKCWOJld--

--qRVxaDxvnBDa7fW3pPFSMKyKV5t76uQPg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAl4kGOYACgkQS7MI6bAu
dmw8ehAApahgRB4V0aXpE43C79KZqPTZpnEQe9mtnApgf4nu4qFDUZ7t1yyuenhA
ptdHpIyIqtnAwSdkaPS6c1NZtgAmnlo1JGs9NeV098BNaMZI8+kXEXO/hM/nb7Pn
rn0SSUbbe6KqknDijL45o1AzgVAk4I277/7pIpEvc6FitWRNMYWya7D4VZrqIHsx
QBoLqWSepZKq9oNCuUKLU+mUWrT6pLZ5AJWMQcU/EOcUzhGkLzd8g3ILQYQmxePw
L6B1IT9sl/HoOsxVoJLZXDXMPb3UeQbPsXMJmwU88ZF+2TBAiQkDQQ9ksldfic0h
yPi+mJC1x1lWp4VtP2JMaHkIQqT8OGk9pJjadI5PQSuqazPZZv42ATsU6DrAO5yR
+GF7j0RrV5ZZzc8NVaLZPC/a2CE+m/uHHEe/PfUg2PnwtX1+AB3kVEtAK8O1Jx+T
BTlXd5nhgtRCssE8/rvwPZ+bO1ckl/i0wUXeiGEz/kVJFByazOvIEtxfdXCowTJ7
cdqY24+XoPfEYaxBC7FmWPmG3RvUhDqODqMACX6Xar5QfiLHo412gbqF+KlGVcNK
xYI5UF9vnv5rWR2xX0fnDqjy5z4MJNI7C7biZvArxQUW94NymvaWeXAzCAsJ8ad6
cWyC/MCc+8FGZ2kOuAD/jEKyEkNFeuEkNg1hoGRWBr54jl7Ozpc=
=yJg1
-----END PGP SIGNATURE-----

--qRVxaDxvnBDa7fW3pPFSMKyKV5t76uQPg--

