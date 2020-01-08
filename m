Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA15C33C9E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 02:06:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A88EA20692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 02:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EZwGqXLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88EA20692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip0k9-0004XI-Aa
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 21:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ip0ie-0002dE-Gg
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 21:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ip0id-0007h2-94
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 21:05:12 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:41573 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ip0ic-0007ee-CH; Tue, 07 Jan 2020 21:05:11 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47ssyV6Tfnz9sRp; Wed,  8 Jan 2020 13:05:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578449106;
 bh=eck8x1LIVNF1XCB52DlZOygdPnqzcu5E95oruIIGeQ4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EZwGqXLlGpWbqx0DLSSoCfv5w71VVltFLP9rm2D4splOh3zLOsT3/7snp1HCLvNrM
 5D+jMo7ERbpFlqOMZV+61crUSCwz7oggkhWAllCqxydhUQhzktxbQ19sweX4CpSW+Y
 u0vSI9+x9JDpPLQ96Yvg7r/Ye3cMxbgIDrK+W7fA=
Date: Wed, 8 Jan 2020 12:09:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH v2 02/10] ppc: Remove stub of PPC970 HID4 implementation
Message-ID: <20200108010908.GK2137@umbus.fritz.box>
References: <20200107044827.471355-1-david@gibson.dropbear.id.au>
 <20200107044827.471355-3-david@gibson.dropbear.id.au>
 <20200107183215.09ce18c6@bahia.lan>
 <20200107183638.1c84f172@bahia.lan>
 <alpine.BSF.2.21.99999.352.2001071900510.93471@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="aznLbwQ42o7LEaqN"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.99999.352.2001071900510.93471@zero.eik.bme.hu>
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
Cc: lvivier@redhat.com, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, clg@kaod.org, paulus@samba.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--aznLbwQ42o7LEaqN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2020 at 07:05:41PM +0100, BALATON Zoltan wrote:
> On Tue, 7 Jan 2020, Greg Kurz wrote:
> > On Tue, 7 Jan 2020 18:32:15 +0100
> > Greg Kurz <groug@kaod.org> wrote:
> >=20
> > > On Tue,  7 Jan 2020 15:48:19 +1100
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >=20
> > > > The PowerPC 970 CPU was a cut-down POWER4, which had hypervisor cap=
ability.
> > > > However, it can be (and often was) strapped into "Apple mode", wher=
e the
> > > > hypervisor capabilities were disabled (essentially putting it alway=
s in
> > > > hypervisor mode).
> >=20
> > Isn't it supervisor mode instead of hypervisor mode ?
>=20
> By the way, do you know if this strapping is hardware or software based? =
So
> is it the firmware that disables it on Apple hardware or is it some CPU p=
in
> connected somewhere on the motherboard or it's within the CPU and cannot =
be
> changed? I wonder if it's theoretically possible to re-enable it on an Ap=
ple
> G5 or we would likely never see a PowerPC 970 with HV enabled?

I don't know, sorry.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aznLbwQ42o7LEaqN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4VK7QACgkQbDjKyiDZ
s5K9HBAAkw4grQvdH/ALPbJ6/ReJdsKg9vcurgX+1GS7+pnRr5NyeRZn4PPHDfok
8VHNaggDZOtBDH0RJK5I+pvl0eP+wHC7CzO4edbcvIJAeE9SydRJQ5sfuGQYxBEJ
hkxCcOILUeW3aRBCFL9r5q25pVQcpX64mhX/RRzEEyakog3Urda79X/7TZPU1cQQ
Otcc7XiByX8mIMkYVe58xEy5PyaW6m4cwOK/bWX6n/gpV2cpp5AEc9CkNSivpdR2
OIMFrUgy7nBZ+9WOyM34Ju1Hg4eA7lbmPaFK8RTpMsxud40siTscB2JOhp66r7U8
DWjWV9N3CegKFZuK91GNJ09FEoHpV7Y/EedRMoqCz7twFxDf61PjJPH1/8kacwov
6pGm6bDDPYex3yVHIZJXQX/UKihiE2NHwTv5As1PU9+1J0IT/kD1OxONYCd9p/Lw
77flWxUDGC0ImbXjS5tu3XklHIcgNYNa+0B4x3apnv7h4l1012nvbOabYe0MaOlD
E5gSFNAgrnps16yRow2TO6X/VLcwz+qqWRLRXTGSgDxA9cKoLe3AajaPQoJaFDpJ
Ndiz9E6jlSj5Dv/Gf2bM6U2hujnoHtBg3WZB6Zu2t1f+mjIH8Q17VDfZOW2kLq5Z
/R4Kaz5/UcsC8LegkdEGfOw5DMEgg2BC+XQyC5sKO7fi0/ulO8c=
=07Fc
-----END PGP SIGNATURE-----

--aznLbwQ42o7LEaqN--

