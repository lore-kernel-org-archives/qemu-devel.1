Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681C1C35240
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 08:45:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DDB52067C
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 08:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nh/cM3Ad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DDB52067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyAse-0001ut-BS
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 03:45:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iyAs0-0001KW-Aq
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 03:44:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iyAry-0002se-OA
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 03:44:43 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:56777 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iyArx-0002gb-Jx; Sun, 02 Feb 2020 03:44:42 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 489Pds25f6z9sRK; Sun,  2 Feb 2020 19:44:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580633073;
 bh=xUJfUYBaT5i5reJCBIPsALXLLuM1cn8Tus9wNX+ktbw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nh/cM3AdOp1s15rYcfvm6SYIU7sjD1sXqv1qSfh8BGoahWIe2eL488BI54EeWSgAC
 I8tl7uadhxBityNS4Qr3t1HcDR//qtQQVDyKL77zbZZr6UXEU9/mSkyZQLKliTYbpc
 r7JER0BU2FtvzkFU1nN2QLRBjQNEUwL1aVdZrsig=
Date: Sun, 2 Feb 2020 19:43:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/34] ppc-for-5.0 queue 20200131
Message-ID: <20200202084358.GF30687@umbus.fritz.box>
References: <20200131060924.147449-1-david@gibson.dropbear.id.au>
 <CAFEAcA8Uzt79o9509fyZOYgAot5m2mk2wWkQkgETW2gL0XOHWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="H4SyuGOnfnj3aJqJ"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8Uzt79o9509fyZOYgAot5m2mk2wWkQkgETW2gL0XOHWA@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--H4SyuGOnfnj3aJqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2020 at 04:42:14PM +0000, Peter Maydell wrote:
> On Fri, 31 Jan 2020 at 06:09, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> >
> > The following changes since commit 928173659d6e5dc368284f73f90ea1d129e1=
f57d:
> >
> >   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-2=
0200130' into staging (2020-01-30 16:19:04 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/dgibson/qemu.git tags/ppc-for-5.0-20200131
> >
> > for you to fetch changes up to 532fe321cf06d39d864de3642b4e1b18cc83c4de:
> >
> >   target/ppc: Use probe_write for DCBZ (2020-01-31 14:54:16 +1100)
> >
> > ----------------------------------------------------------------
> > ppc patch queue 2020-01-31
> >
> > Here's the next batch of patches for ppc and associated machine types.
> > Highlights includes:
> >  * Remove the deprecated "prep" machine type and its OpenHackware
> >    firmware
> >  * Add TCG emulation of the msgsndp etc. supervisor privileged
> >    doorbell instructions
> >  * Allow "pnv" machine type to run Hostboot style firmwares
> >  * Add a virtual TPM device for spapr machines
> >  * Implement devices for POWER8 PHB3 and POWER9 PHB4 host bridges for
> >    the pnv machine type
> >  * Use faster Spectre mitigation by default for POWER9 DD2.3 machines
> >  * Introduce Firmware Assisted NMI dump facility for spapr machines
> >  * Fix a performance regression with load/store multiple instructions
> >    in TCG
> >
> > as well as some other assorted cleanups and fixes.
> >
>=20
> Hi; this pull req produces a bunch of extra warning messages in
> my log files; is it possible to suppress them ?
>=20
>=20
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-ccf-assist=3Don
> qemu-system-ppc64: warning: Firmware Assisted Non-Maskable
> Interrupts(FWNMI) not supported in TCG
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-ccf-assist=3Don
> qemu-system-ppc64: warning: Firmware Assisted Non-Maskable
> Interrupts(FWNMI) not supported in TCG
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-ccf-assist=3Don
> qemu-system-ppc64: warning: Firmware Assisted Non-Maskable
> Interrupts(FWNMI) not supported in TCG

As you've seen, Greg has sent a fix for these.  Do you want me to
resend the series with his patch included, or will you merge this lot
and I'll follow up with Greg's patch?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--H4SyuGOnfnj3aJqJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl42i80ACgkQbDjKyiDZ
s5LkJRAA4WLwKdFthixMk341RSg82KjGhx5wPSn0eT6BHzq0ccoE+9j93nzqiM50
Ss5ohWjuea2zw9bjfPR08g/nwW/fVAsQ40Za8wJ622GxNlYtK4UwfL+3jfUMHcrg
F/KY298dAelhEvW7ZVuQnL0HaG/13FKza87z0BvIILR1ruIUcRSErksX6RbvGjXJ
HiAznHe2djW89ySqA7azI0mAojLSyEUpaD25SxePBxyb4Qw0OuBc4j34Rj0ge+d5
/E9XnXpmqnjEadkj1kJf1yZBn5LJYxzv/tE9twQg3knsMCIJuT9B1RDx+/7z1CD5
QL3qC9SUreUb1kA7lUSHq94yLNhRXaeWYezHz/MUrCwUrsrxVdodv1wA/lOWN67E
x5MaZglxCiHmEye+tT0ntrJA+HnMXEwWdUGXZZdBv2sCb4OGGS/rkjVe9h3BqbT4
7sWRY2V+DWvUoBNQKFPTRAzxkSQrK6M5VOV4Wzv6Mxy6n1auO/Fj666gYSmjhmI8
EzUa136bfrVFyJU383lnOsI4zLQk/OCAkLsWrcEqKDyRsYeE80YiDivAXhNiWGGv
snOfWWyvtpsKX/NyARLMJYnvQPFZO6viAFWk0ZqoyXzK87Tg5ZEDiOM38wiIGw0f
pfvrHh/VJv/KwpROxBo0EE/OiYcuD8Ge7FTv8hJCERFoVTDdXYU=
=b/LP
-----END PGP SIGNATURE-----

--H4SyuGOnfnj3aJqJ--

