Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D77C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 22:06:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 202A722440
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 22:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Kj3y/kJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202A722440
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXBdV-00042p-0J
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 17:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iXBb2-0002IY-VU
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 17:03:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iXBb0-0007p6-Pm
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 17:03:40 -0500
Received: from ozlabs.org ([203.11.71.1]:34459)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iXBaz-0007nH-9O; Tue, 19 Nov 2019 17:03:38 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47HfwP2YJQz9sPW; Wed, 20 Nov 2019 09:03:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574201013;
 bh=66HDvuFwDEuPKV+KTZ6dV9LErJkqueGuG8ytAi8Xak0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Kj3y/kJ95RZaSen7qBNXJ+yMIT2KCKT0l6+Yx0QxBib5a9clHZ8BGpKCqpgQVq7lb
 8voXTgEqXWRmkAL4G/l9FMcCWTPQ6fzEDIdVKbFVUYTyRqmcfo2Jb7UwsviiY1ah0l
 oJocxbs0uVpzcKDEkzEkswYUEGUY0td45V8z0iuo=
Date: Wed, 20 Nov 2019 09:02:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Balamuruhan S <bala24@linux.ibm.com>
Subject: Re: [PATCH 2/5] hw/ppc/pnv_xscom: PBA bar mask values are incorrect
 with homer/occ sizes
Message-ID: <20191119220226.GW5582@umbus.fritz.box>
References: <20191119175056.32518-1-bala24@linux.ibm.com>
 <20191119175056.32518-3-bala24@linux.ibm.com>
 <20191119215618.GU5582@umbus.fritz.box>
 <20191119220032.GV5582@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="aKl9HDSa9q6Cj3fk"
Content-Disposition: inline
In-Reply-To: <20191119220032.GV5582@umbus.fritz.box>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--aKl9HDSa9q6Cj3fk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2019 at 09:00:32AM +1100, David Gibson wrote:
> On Wed, Nov 20, 2019 at 08:56:18AM +1100, David Gibson wrote:
> > On Tue, Nov 19, 2019 at 11:20:53PM +0530, Balamuruhan S wrote:
> > > homer/occ sizes are calculated in skiboot with `(mask | 0xfffff) + 1`,
> > > and from xscom access should return correct mask values instead of ac=
tual
> > > sizes.
> > >=20
> > > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > > Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> > > ---
> > >  hw/ppc/pnv_xscom.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> > > index f01d788a65..cdd5fa356e 100644
> > > --- a/hw/ppc/pnv_xscom.c
> > > +++ b/hw/ppc/pnv_xscom.c
> > > @@ -46,6 +46,10 @@
> > >  #define P9_PBA_BARMASK0                 0x5012b04
> > >  #define P9_PBA_BARMASK2                 0x5012b06
> > > =20
> > > +/* Mask to calculate Homer/Occ size */
> > > +#define HOMER_SIZE_MASK                 0x0000000000300000ull
> > > +#define OCC_SIZE_MASK                   0x0000000000700000ull
> >=20
> > Uuuhhhhh... AFAICT these defines have identical values to
> > PNV_HOMER_SIZE and PNV_OCC_COMMON_AREA_SIZE, so I don't see what this
> > patch is actually changing.
>=20
> Oh, sorry, missed that the values were changed in 1/5.  Would have
> been easier to follow if the two patches were folded together, but
> never mind.  Applied.

Ugh.. or not.  The first patch doesn't apply for me, looks like it
needs a rebase (or you have something else in your tree I don't know
about).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aKl9HDSa9q6Cj3fk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3UZnIACgkQbDjKyiDZ
s5ISARAAh0Xp5n11uoDmEy9PY+YkzXm6iyiX9mrfK4kprNgbjD2g3db5F5O3lOtw
+u+ltFoQogpdNmu3wHrhwGAUFy1cp4U55Iemx8qf8idiHZ2BCqln1Uuh5wE6ILI2
W2AjvR9Wb4s6lSxUODVCyLLPvKdp1APl5TKJ5w959u70WGohq5ZxtlT1PvoRKFJI
dCuSwUj53XzFzMpw5QvrGvjRxrShiaKRp27JWaIURIUia4tHMrd5ZzB+JypWnlvc
nOdhj/aATPM2E7RKlHD/VAwbZtuQ6I3MTyblK/e8G5OiUI5S8SPcsvg1RbHldxxM
V6BOURN/oGSVN8DqeRJBU9W+cdevIcjJiI8pvQRLPNtlbexXH4DvHOVRTPGGCOSd
O/b1Wl+RHjXFzToPDq+e5eRg42BZY7gKe4YONdmVMHZZWLP/2Dp5Piu2YyxVBFgO
e6EaBDECvAKk35MNGTtRCa6Jf54avYdB8TUptjq+vfG49brhZURVnEyK+DQU+gti
gAtcRdT/ly57mgvx3uWt5xluZL2GNMSw7auv6g8CpNf/dVJcE9eMT35ZSJEWBHKp
wbj1Kp1N4tNpkT4P9enWPhPx3LSHeePG1ySBRN8UEuAQPH+AS8L5lsO+aA2pq79A
c/iYeA6t6mZvI2Yn9LcFFeYhv2IuqfiVfGOsw7GRVaDVWpQsysI=
=hkvN
-----END PGP SIGNATURE-----

--aKl9HDSa9q6Cj3fk--

