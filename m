Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C4FC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E6EE20722
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6EE20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aurel32.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGQ6V-00057X-4i
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 12:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aurelien@aurel32.net>) id 1jGQ3n-00048F-M2
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aurelien@aurel32.net>) id 1jGQ3m-0002Nj-DV
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:36:19 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:51640)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aurelien@aurel32.net>)
 id 1jGQ3m-0002If-7H
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:36:18 -0400
Received: from aurel32 by hall.aurel32.net with local (Exim 4.92)
 (envelope-from <aurelien@aurel32.net>)
 id 1jGQ3F-0005Uz-NA; Mon, 23 Mar 2020 17:35:45 +0100
Date: Mon, 23 Mar 2020 17:35:45 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v1] mips/mips_malta: Allow more than 2G RAM
Message-ID: <20200323163545.GA19598@aurel32.net>
References: <20200228032613.1049955-1-jiaxun.yang@flygoat.com>
 <20200303004137.1099502-1-jiaxun.yang@flygoat.com>
 <6b4a7564-eac6-7bd3-b1c0-e9c7ac4e0c80@redhat.com>
 <CAL1e-=gEtCtAnsnkO4_E8rqje=n1bHXY_+BXC5P2h5Ld0umNtQ@mail.gmail.com>
 <d9f08408-9c1e-36d9-869b-bac250c6f027@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d9f08408-9c1e-36d9-869b-bac250c6f027@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:bc8:30d7:100::1
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
 QEMU Developers <qemu-devel@nongnu.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paul Burton <paul.burton@mips.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Sorry for the delay, I just want to give some more details about the
Debian.

On 2020-03-14 10:09, Philippe Mathieu-Daud=E9 wrote:
> IIUC today all distributions supporting MIPS ports are building their MIPS
> packages on QEMU instances because it is faster than the native MIPS
> hardware they have.

Actually Debian requires that packages are built on real hardware. We
have a mix of Loongson 3 and Octeon 3 based build daemons. They all have
8GiB of RAM.

> Since one (or two?) years, some binaries (Linux kernel? QEMU?) are failing
> to link because the amount of guest memory is restricted to 2GB (probably
> advance of linker techniques, now linkers use more memory).

The problem happens with big packages (e.g. ceph which is a dependency
of QEMU). The problem is not the physical memory issue, but the virtual
address space, which is limited to 2GB for 32-bit processes. That's why
we do not have the issue for the 64-bit ports.

> YunQiang, is this why you suggested this change?
>=20
> See:
> - https://www.mail-archive.com/debian-mips@lists.debian.org/msg10912.html
> - https://alioth-lists.debian.net/pipermail/pkg-rust-maintainers/2019-Jan=
uary/004844.html
>=20
> I believe most of the QEMU Malta board users don't care it is a Malta boa=
rd,
> they only care it is a fast emulated MIPS machine.
> Unfortunately it is the default board.
>=20
> However 32-bit MIPS port is being dropped on Debian:
> https://lists.debian.org/debian-mips/2019/07/msg00010.html

The 32-bit big endian port has been dropped after the Buster (10)
release and won't be available for the Bullseye release (11). The
32-bit little endian port is still available, but it's difficult to keep
it alive given the 2GB limit.

> Maybe we can sync with the Malta users, ask them to switch to the Boston
> machines to build 64-bit packages, then later reduce the Malta board to 1=
GB.
> (The Boston board is more recent, but was not available at the time users
> started to use QEMU to build 64-bit packages).
>=20
> Might it be easier starting introducing a malta-5.0 machine restricted to
> 1GB?

In any case having an easy way to simulate machines with more than 2GB
of RAM in QEMU would be great.

Cheers,
Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net

