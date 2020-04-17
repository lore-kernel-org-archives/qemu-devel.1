Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EF1C352BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 09:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FDC32137B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 09:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Yu8TXgEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FDC32137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPNA1-0006W2-Hc
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 05:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jPN9D-00065A-3T
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 05:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jPN9C-0002TC-1u
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 05:18:55 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:38953 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jPN9B-0002OK-NN; Fri, 17 Apr 2020 05:18:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 493Vrp51qjz9sSM; Fri, 17 Apr 2020 19:18:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1587115130;
 bh=lItEv67cnf3x7aZX3FiD3AIyQkS2bJHdACixw7VtxrI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Yu8TXgEHrSGf0++7RL2NyErVxG07MvdSESJ8dvoUnrVfIc2CVA2dHdvva2udi8+dG
 BZayr1Azn5O7bfrtDzh6VhQ9jbDMR0qeRXp5RxCNx3DvU6/+T8eQPeWzXTShhpS7ys
 rC0Srwv8lWW9lXMkVLMeYkzdCIgfSDgTO2TTzvUo=
Date: Fri, 17 Apr 2020 19:18:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/3] ppc-for-5.0 queue 20200417
Message-ID: <20200417091812.GE2102@umbus.fritz.box>
References: <20200417050514.235060-1-david@gibson.dropbear.id.au>
 <CAFEAcA8qLznGS2YCFxz7QYrhbociZsqzEcxQPdp1rUy4OnnnFQ@mail.gmail.com>
 <20200417091431.GC2102@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="brEuL7wsLY8+TuWz"
Content-Disposition: inline
In-Reply-To: <20200417091431.GC2102@umbus.fritz.box>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Greg Kurz <groug@kaod.org>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--brEuL7wsLY8+TuWz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2020 at 07:14:31PM +1000, David Gibson wrote:
> On Fri, Apr 17, 2020 at 09:28:46AM +0100, Peter Maydell wrote:
> > On Fri, 17 Apr 2020 at 06:05, David Gibson <david@gibson.dropbear.id.au=
> wrote:
> > >
> > > The following changes since commit 20038cd7a8412feeb49c01f6ede89e36c8=
995472:
> > >
> > >   Update version for v5.0.0-rc3 release (2020-04-15 20:51:54 +0100)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://github.com/dgibson/qemu.git tags/ppc-for-5.0-20200417
> > >
> > > for you to fetch changes up to 5ed195065cc6895f61b9d59bfa0a0536ed5ed5=
1e:
> > >
> > >   target/ppc: Fix mtmsr(d) L=3D1 variant that loses interrupts (2020-=
04-17 10:39:03 +1000)
> > >
> > > ----------------------------------------------------------------
> > > ppc patch queue for 2020-04-17
> > >
> > > Here are a few late bugfixes for qemu-5.0 in the ppc target code.
> > > Unless some really nasty last minute bug shows up, I expect this to be
> > > the last ppc pull request for qemu-5.0.
> > >
> >=20
> > We're past rc3 now, so I don't really want to do an rc4 unless we
> > absolutely critically need to. How important are these bug fixes?
>=20
> Eh, probably not important enough.  They're not regressions AFAICT -
> two fairly longstanding bugs, and one bug in a new feature.  It can
> wait until 5.1.
>=20
> But, I guess throw them in if something else does force an rc4.

Oof.  Such as, perhaps the TCG temp leak in slbia.  That one *is* a
regression :(.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--brEuL7wsLY8+TuWz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6ZdFQACgkQbDjKyiDZ
s5KXcg/+PrDhyjMVTITIThpES0zU9jPHq0UqNswZRd95WM5vk8Kv6F2iYShCWEYR
6z5N2K5uVwElTHrJ5kN5eFMLi5d8LmVTHQSSuQv2BrQG9EuR2iC1ZNHTLgm9iyRh
kbvidLQo3hTw26T42fEbkfNKZHiN5bL4X2ipqk8VeAjSLX4l6NBvZfwFPiF+AJBa
zIwl+RPVk8njWoc07R0wEXJ/p1Y7entz/M+1XMehDPTq6lDeIauAvRttGhfhZkCc
qouiCNG0F+PM0caSkCTgyt4piw9y3JB50kSQhltedwLN8C9+tsHGbTXoCKV4kBJK
SfHTv2/R+g79nAPKmGugq7GebzPv5QXOyaT7fdZ4ee0CvIYy+umikB8iMDvVNyID
4BHwFy0LAg8dihyZ7sv0vtxcQCGYJvL4RtTvi6Bia/P1DbDZV3mUreX/u+XMmLEA
PpiAgX/itDH1cLNcMTQXHZxcYJ8N2yrWXhUbq3pn3QazFVKDjprnmKpxWOkVarwY
rjh397e6q1vsgwTrRo0WREmSP9v3/2K0ayV6iyIvkZSQ0VhUouZTZ0tGxtuIqzk2
x2W6raPodAFB+f4K2N17mmYXLoya4vzEx7XgkK1mFXDB6aNKHgRsPIIP0HbnFaeE
0c32ZjaPCi5ynO862wbtIAGTx+67Dm/QcCnNgnZ8gob4BlV+lhw=
=6UnZ
-----END PGP SIGNATURE-----

--brEuL7wsLY8+TuWz--

