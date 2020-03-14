Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49677C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 12:30:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E0EC2076B
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 12:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=jiaxun.yang@flygoat.com header.b="Edolzd0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0EC2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD5w4-00032T-9k
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 08:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jD5vR-0002bl-Il
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 08:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jD5vQ-00040j-1N
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 08:29:57 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17848)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jD5vP-0003Wb-JP
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 08:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1584188655; 
 s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
 h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=AA2sO9QmhdxqxaXBgiWuio9RQeiZHCYGoDYE+57crOs=;
 b=Edolzd0t0g0t/IUx5SoQmfylwEgb191VijBYLsExP2xnWc0IGsqvLtKUuCDBMZ92
 yLqj9OWXOEzYIoUeIXHNzZCGUHh1ttNEY2vDpu36B3j+tZsgiKVTAfqDcTsQicFmxU0
 TAS8/irAhNtAd1F1d+50ZY2WeCF4x4SYbomf5Juk=
Received: from mail.baihui.com by mx.zoho.com.cn
 with SMTP id 1584188652687724.6665524519432;
 Sat, 14 Mar 2020 20:24:12 +0800 (CST)
Date: Sat, 14 Mar 2020 20:24:12 +0800
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?=22Philippe_Mathieu-Daud=C3=A9=22?= <philmd@redhat.com>
Message-ID: <170d9007c8b.13c0df0018230.8565583190152644951@flygoat.com>
In-Reply-To: <d9f08408-9c1e-36d9-869b-bac250c6f027@redhat.com>
References: <20200228032613.1049955-1-jiaxun.yang@flygoat.com>
 <20200303004137.1099502-1-jiaxun.yang@flygoat.com>
 <6b4a7564-eac6-7bd3-b1c0-e9c7ac4e0c80@redhat.com>
 <CAL1e-=gEtCtAnsnkO4_E8rqje=n1bHXY_+BXC5P2h5Ld0umNtQ@mail.gmail.com>
 <d9f08408-9c1e-36d9-869b-bac250c6f027@redhat.com>
Subject: Re: [PATCH v1] mips/mips_malta: Allow more than 2G RAM
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Priority: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 124.251.121.243
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Peter Maydell <peter.maydell@linaro.org>, Yunqiang Su <ysu@wavecomp.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paul Burton <paul.burton@mips.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=85=AD, 2020-03-14 17:09:08 Philippe M=
athieu-Daud=C3=A9 <philmd@redhat.com> =E6=92=B0=E5=86=99 ----
 > Hi Aleksandar,
 >=20

 > >>
 > >> This is annoying, because the CoreLV/CoreFPGA core cards only have 4
 > >> DIMM slots for PC-100 SDRAM, and the Memory Controller of the GT=E2=
=80=9364120A
 > >> north bridge accept at most 256 MiB per SCS for address decoding, so =
we
 > >> have a maximum of 1 GiB on 32-bit boards.
 > >>
 > >> In 64-bit emulation we use the a 20Kc core, provided by the Core20K c=
ore
 > >> card which doesn't use the GT=E2=80=9364120A but the Bonito64. So the=
 model is
 > >> incorrect... The Bonito64 indeed allow more memory.
 > >>
 > >> Maybe it is time to consider that for 64-bit targets, since we are no=
t
 > >> modelling a Malta core board, we can name it the official 'virt' mach=
ine...
 > >>
 > >=20
 > > Philippe, I almost agree 100% with you wrt last three paragraphs.
 > > (in any case, I know much less than you about details of GT-64120A
 > > and Bonito64, but I trust you).
 > >=20
 > > The only area I have a slightly different opinion is that I believe we
 > > should never declare Malta as a virtual board, and try to be within th=
e
 > > boundaries of physical capabilities of real boards, even if in softwar=
e
 > > (QEMU) we could "enhance" some features.
 > >=20
 > > If we want MIPS virtual board, than we should devise a full blown
 > > virtual board, similar to what was already done for MIPS Android
 > > emulator. I really don't want some real/virtual frankenstein in QEMU
 > > upstream just because it is convenient for let's say a particular
 > > test setup.

So probably it's time to work on a "virt" machine. What style would you pre=
fer?
PC-like or SoC style?

In fact we've got two pseudo board (mips, mipssim) for MIPS,
but non of them seems modern enough.

I can launch a Loongson-3 style board after dealing with Kernel code clean-=
up.

 >=20
 > IIUC today all distributions supporting MIPS ports are building their=20
 > MIPS packages on QEMU instances because it is faster than the native=20
 > MIPS hardware they have.
 >=20
 > Since one (or two?) years, some binaries (Linux kernel? QEMU?) are=20
 > failing to link because the amount of guest memory is restricted to 2GB=
=20
 > (probably advance of linker techniques, now linkers use more memory).
 >=20
 > YunQiang, is this why you suggested this change?
 >=20
 > See:
 > - https://www.mail-archive.com/debian-mips@lists.debian.org/msg10912.htm=
l
 > -=20
 > https://alioth-lists.debian.net/pipermail/pkg-rust-maintainers/2019-Janu=
ary/004844.html
 >=20
 > I believe most of the QEMU Malta board users don't care it is a Malta=20
 > board, they only care it is a fast emulated MIPS machine.
 > Unfortunately it is the default board.

Yeah. That's the truth.

 >=20
 > However 32-bit MIPS port is being dropped on Debian:
 > https://lists.debian.org/debian-mips/2019/07/msg00010.html

mipsel (MIPS 32-bit Little Endian) is still alive. I believe Debian won't g=
ive up it as long as i386
still exist.

 >=20
 > Maybe we can sync with the Malta users, ask them to switch to the Boston=
=20
 > machines to build 64-bit packages, then later reduce the Malta board to =
1GB.
 > (The Boston board is more recent, but was not available at the time=20
 > users started to use QEMU to build 64-bit packages).
 >=20
 > Might it be easier starting introducing a malta-5.0 machine restricted=
=20
 > to 1GB?
 >=20
 > >=20
 > > Aleksandar
 > >=20
 > >>>            exit(1);
 > >>>        }
 > >>> +#endif
 > >>>
 > >>>        /* register RAM at high address where it is undisturbed by IO=
 */
 > >>>        memory_region_add_subregion(system_memory, 0x80000000, machin=
e->ram);
 > >>>
 > >>
 > >>
 > >=20
 >=20
 >=20


--
Jiaxun Yang


