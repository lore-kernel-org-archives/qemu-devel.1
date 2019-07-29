Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F291C76186
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 06:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A48F204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 06:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cul/qQ42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A48F204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrytp-0006n2-I9
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 02:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50204)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hryt3-0005vE-NI
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 02:11:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hryt2-0002MN-A5
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 02:11:57 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38239 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hryt0-0002BW-Hp; Mon, 29 Jul 2019 02:11:55 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45xq8H5m3hz9sMQ; Mon, 29 Jul 2019 16:11:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1564380703;
 bh=kLoindXVCUcYpOpBNte7tUr+KLgqfhCiCxGQnRw2cgU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cul/qQ42drikmGOpvm/FdX1zz254+prXqnFeo69Bog7PMK6Msta3w1ZgMjuuO+68T
 Ky/rDbQvYmThjHsiVfnDC1LA4feuJa0Yh6sR1BoirZ1k4O28pg5O79mKW02jLafBAD
 /Dt1lemsZewT1epkMMmbbQ42YyDncxt1nuu0XXp0=
Date: Mon, 29 Jul 2019 16:11:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190729061131.GA8687@umbus>
References: <20190718115420.19919-1-clg@kaod.org>
 <20190718115420.19919-10-clg@kaod.org>
 <20190728074602.GF5110@umbus>
 <024c66ef-b622-54ce-1ed3-3716cf6102f1@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <024c66ef-b622-54ce-1ed3-3716cf6102f1@kaod.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v2 09/17] ppc/xive: Extend XiveTCTX with a
 XiveRouter pointer
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2019 at 11:06:27AM +0200, C=E9dric Le Goater wrote:
> On 28/07/2019 09:46, David Gibson wrote:
> > On Thu, Jul 18, 2019 at 01:54:12PM +0200, C=E9dric Le Goater wrote:
> >> This is to perform lookups in the NVT table when a vCPU is dispatched
> >> and possibily resend interrupts.
> >>
> >> Future XIVE chip will use a different class for the model of the
> >> interrupt controller and we might need to change the type of
> >> 'XiveRouter *' to 'Object *'
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > Hrm.  This still bothers me.=20
>=20
> Your feeling is right. There should be a good reason to link two objects=
=20
> together as it can be an issue later on (such P10). It should not be an=
=20
> hidden parameter to function calls. this is more or less the case.=20
> =20
> See below for more explanation.
>=20
> > AIUI there can be multiple XiveRouters in the system, yes? =20
>=20
> yes and it works relatively well with 4 chips. I say relatively because=
=20
> the presenter model is taking a shortcut we should fix.=20
>=20
> > And at least theoretically can present irqs from multiple routers?=20
>=20
> Yes. the console being the most simple example. We only have one device=
=20
> per system on the LPC bus of chip 0.=20
> =20
> > In which case what's the rule for which one should be associated with=
=20
> > a specific.
> > I guess it's the one on the same chip, but that needs to be explained
> > up front, with some justification of why that's the relevant one.
>=20
> Yes. we try to minimize the traffic on the PowerBUS so generally CPU=20
> targets are on the same IC. The EAT on POWER10 should be on the same
> HW chip.
>=20
>=20
> I think we can address the proposed changes from another perspective,=20
> from the presenter one. this is cleaner and reflects better the HW design=
=2E=20
>=20
> The thread contexts are owned by the presenter. It can scan its list=20
> when doing CAM matching and when the thread context registers are being=
=20
> accessed by a CPU. Adding a XiveRouter parameter to all the TIMA=20
> operations seems like a better option and solves the problem.
> =20
>=20
> The thread context registers are modeled under the CPU object today=20
> because it was practical for sPAPR but on HW, these are SRAM entries,
> one for each HW thread of the chip. So may be, we should have introduced
> an other table under the XiveRouter to model the contexts but there
> was no real need for the XIVE POWER9 IC of the pseries machine. This=20
> design might be reaching its limits with PowerNV and POWER10. =20
>=20
>=20
> Looking at :
> =20
>   [PATCH v2 15/17] ppc/pnv: Grab the XiveRouter object from XiveTCTX in p=
nv_xive_get_tctx()
>=20
> we see that the code adds an extra check on the THREAD_ENABLE registers=
=20
> and for that, its needs the IC to which belongs the thread context. This=
=20
> code is wrong. We should not be need to find a XiveRouter object from a=
=20
> XiveRouter handler.
>=20
> This is because the xive_presenter_match() routine does:
>                       =20
>     CPU_FOREACH(cs) {
>         XiveTCTX *tctx =3D xive_router_get_tctx(xrtr, cs);
> =20
> we should be, instead, looping on the different IC of the system=20
> looking for a match. Something else to fix. I think I will use the
> PIR to match the CPU of a chip.
>=20
>=20
> Looking at POWER10, XIVE internal structures have changed and we will
> need to introduce new IC models, one for PowerNV obviously but surely=20
> also one for pseries. A third one ... yes, sorry about that. If we go=20
> in that direction, it would be good to have a common XiveTCTX and not=20
> link it to a specific XiveRouter (P9 or P10). Another good reason not
> to use that link.
>=20
>=20
> So I will rework the end of that patchset. Thanks for having given me=20
> time to think more about it before merging. I did more experiments and
> the models are now more precise, specially with guest and multichip
> support.

Ok, good to hear.  I will wait for the respin.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0+jhEACgkQbDjKyiDZ
s5LWRQ//UvltZJYiKNmM7GMO9uALnkCE3ctC+lGsBN+DLZFKDajyzkS+6a5PVWEM
pfgA4EmAhOTha0pjIg3sVf1iZ4cT+80AdmA4tZfxRs5Od08Se17xQaETBXvMwTVT
K02sx7dFGmhdReW03xbFxpty0HGDZnC1dqKbPw0Y0cWsBvIOO0pA2biutSYaY+Cn
YeMhA2lk7BCot5DWBLZ4bvU71Nv8SxSJDuXUSoRKYaLNbl2O6mo67X4NVAhUnK4a
89unkhVq4FomVNin3uWbHsjG8q4hLuXpvIlYxfqWqVtfSXIaa8Xo3tDOg/81C3+n
mnXi02pvqqk1VrTc+Y8LZLIC5BfHOjPl5HDmD6sXuefOmORTqr9OTgpSJ4rVQOe/
gFUTjTUfMlElcPL9pjx5Cz7erDMHauvzHTwwqkhqKs1v3kU6r80VqUOdu9ndZ0Xz
5vsa4UpMdAw0pI9KwAlUwCHvuqDImJcBw2JTA8uat9OLhyYH8hEA6s6D/f683v+D
CafYIV3hZz+z0Rz4m3zy2cm+8AB2fS18Lvn1FEo0ad2QSvKqGifhk9jtXc66SXFB
Q64NL5KvPGl8667NzR+W4S+k21sypIDCF3i1ekFHZxyXzQgnMlSfzRhETEUhbgk0
CW2C0pdkyxrtBt9M+egPsPpgCuakhvbWWdOSglNcY8y7FiHQG5k=
=ufNS
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--

