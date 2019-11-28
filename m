Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E09C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 04:05:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68E4B2154A
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 04:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="AH6ujE9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E4B2154A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaB3d-0001L5-Kv
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 23:05:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iaB02-0006JM-Bh
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 23:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iaAzy-0001U8-Am
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 23:01:48 -0500
Received: from ozlabs.org ([203.11.71.1]:34701)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iaAzs-0001Jp-Ge; Wed, 27 Nov 2019 23:01:45 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47NkTr3hLvz9sPh; Thu, 28 Nov 2019 15:01:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574913696;
 bh=i/IfRQ1xv6XyH9yfUn9fWpyvJ14a2esGi9w/LcVAxKI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AH6ujE9Ybwd1AO/VH2iVGR+9biYC8lvXiTDELBx16xn57FpHbYdy+9gTcMjtMonf9
 zjR0RhpA+wmL4jdUF4/v6RMD71qkaLQ4SPwq9XdboBExBZvdnqR0JcMRy93irykDvH
 /jBrwKp6WsJvbzTfO4jI8C7GRlmpvAdVZfHCA6Gk=
Date: Thu, 28 Nov 2019 12:35:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v6 16/20] ppc/xive: Introduce a xive_tctx_ipb_update()
 helper
Message-ID: <20191128013535.GC4765@umbus.fritz.box>
References: <20191125065820.927-1-clg@kaod.org>
 <20191125065820.927-17-clg@kaod.org>
 <20191127095050.2e916a03@bahia.w3ibm.bluemix.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline
In-Reply-To: <20191127095050.2e916a03@bahia.w3ibm.bluemix.net>
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2019 at 09:50:50AM +0100, Greg Kurz wrote:
65;5802;1c> On Mon, 25 Nov 2019 07:58:16 +0100
> C=E9dric Le Goater <clg@kaod.org> wrote:
>=20
> > We will use it to resend missed interrupts when a vCPU context is
> > pushed on a HW thread.
> >=20
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > ---
> >  include/hw/ppc/xive.h |  1 +
> >  hw/intc/xive.c        | 21 +++++++++++----------
> >  2 files changed, 12 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> > index 24315480e7c2..9c0bf2c301e2 100644
> > --- a/include/hw/ppc/xive.h
> > +++ b/include/hw/ppc/xive.h
> > @@ -469,6 +469,7 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Monit=
or *mon);
> >  Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp);
> >  void xive_tctx_reset(XiveTCTX *tctx);
> >  void xive_tctx_destroy(XiveTCTX *tctx);
> > +void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb);
> > =20
> >  /*
> >   * KVM XIVE device helpers
> > diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> > index 4bff3abdc3eb..7047e45daca1 100644
> > --- a/hw/intc/xive.c
> > +++ b/hw/intc/xive.c
> > @@ -47,12 +47,6 @@ static uint8_t ipb_to_pipr(uint8_t ibp)
> >      return ibp ? clz32((uint32_t)ibp << 24) : 0xff;
> >  }
> > =20
> > -static void ipb_update(uint8_t *regs, uint8_t priority)
> > -{
> > -    regs[TM_IPB] |=3D priority_to_ipb(priority);
> > -    regs[TM_PIPR] =3D ipb_to_pipr(regs[TM_IPB]);
> > -}
> > -
> >  static uint8_t exception_mask(uint8_t ring)
> >  {
> >      switch (ring) {
> > @@ -135,6 +129,15 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uin=
t8_t ring, uint8_t cppr)
> >      xive_tctx_notify(tctx, ring);
> >  }
> > =20
> > +void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb)
> > +{
> > +    uint8_t *regs =3D &tctx->regs[ring];
> > +
> > +    regs[TM_IPB] |=3D ipb;
> > +    regs[TM_PIPR] =3D ipb_to_pipr(regs[TM_IPB]);
> > +    xive_tctx_notify(tctx, ring);
> > +}
> > +
>=20
> Maybe rename the helper to xive_tctx_update_ipb_and_notify() to
> make it clear this raises an irq in the end ?

I'm actually happy enough with the name as is.  I think it's
reasonable for "update" on a register which has active effects on the
real hardware to implicitly have the same effects in the qemu model.

Applied to ppc-for-5.0.

>=20
> This can be done as follow-up though and the rest looks good, so:
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> >  static inline uint32_t xive_tctx_word2(uint8_t *ring)
> >  {
> >      return *((uint32_t *) &ring[TM_WORD2]);
> > @@ -336,8 +339,7 @@ static void xive_tm_set_os_cppr(XivePresenter *xptr=
, XiveTCTX *tctx,
> >  static void xive_tm_set_os_pending(XivePresenter *xptr, XiveTCTX *tctx,
> >                                     hwaddr offset, uint64_t value, unsi=
gned size)
> >  {
> > -    ipb_update(&tctx->regs[TM_QW1_OS], value & 0xff);
> > -    xive_tctx_notify(tctx, TM_QW1_OS);
> > +    xive_tctx_ipb_update(tctx, TM_QW1_OS, priority_to_ipb(value & 0xff=
));
> >  }
> > =20
> >  static void xive_os_cam_decode(uint32_t cam, uint8_t *nvt_blk,
> > @@ -1429,8 +1431,7 @@ static bool xive_presenter_notify(uint8_t format,
> > =20
> >      /* handle CPU exception delivery */
> >      if (count) {
> > -        ipb_update(&match.tctx->regs[match.ring], priority);
> > -        xive_tctx_notify(match.tctx, match.ring);
> > +        xive_tctx_ipb_update(match.tctx, match.ring, priority_to_ipb(p=
riority));
> >      }
> > =20
> >      return !!count;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3fJGYACgkQbDjKyiDZ
s5IipQ//eJ0eMX6dFOExhEfVIxvzrz2NhnhCbDJtzGYOXuoqsyPn8g6tb5/8WHxC
aXgDB24CBi5LxBsftGMYEkHDcxP55txg9NsjtcoTs4DRWXfe1LxB0wonmbE6gBAn
E0Qp4D0gwbV8jxWWfGekiduvv06UXd7BS2WjD3i1VdST/00nkY1dPcRSgU0oCzIB
m5+2GUCw5WtdsYNdzUxQcdL5UPiics+OokCltfdFpydqV13fWwKlnMz1+UMPL5cr
XlyrcWLraKq+RhKYD/9WsGGd3sJau7agmOucIWDI5+h65mehLPC5C/qIjpWr6I3A
jZRive9i9iv0XtdtmZed/CDLOFULGO4Q9XWguaNj4jnzwyRydxRC2A1aceoZ1ARl
4JX2jBL19TacdMTxrvz8U+rHpl7DLAYcYBo5r9GpgFPsr2o+miRjDvMH4Qf/egc2
SBLGFJ22jqQuAmoGDM+Q7pUDAqsETz6euiHaX8X3GE7AVXR0u0pIpso2yQiuPh37
m2MFurprGSM/OcWYD2ixOOWQmhMAHf3BYgC46LSjMcXnVzjpUUK6uU1DwSrw3Pa9
ge2jENjRVqhNd/N4Khq0tIlWaVm65tlhUYH01j4kemcZBVmJ4esSMErICmBCK9o3
p2Yq5ns2K/zRUrxRFOwsRNfdG2WoEiK3ta+Gwm1Jis2iCaPJzF4=
=6drJ
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--

