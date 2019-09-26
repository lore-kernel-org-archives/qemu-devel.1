Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDD0C352A7
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 12:14:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3101206E0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 12:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="k5LIr3lm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3101206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDSel-0001wl-Sa
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 08:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iDSdE-0000IR-L9
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:12:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iDSdD-0001yZ-89
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:12:24 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55635 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iDSdC-0001wo-Sr; Thu, 26 Sep 2019 08:12:23 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46fDLZ41bRz9sPK; Thu, 26 Sep 2019 22:11:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569499910;
 bh=UDRwOG2f2d5+VMwe3gnwGDaVkVCAwC1ssMXXSOll1Ug=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k5LIr3lmEPaqWqerwY4gmYodQ6DZpO/PMemzlQevofdq7GpuP8aFJd7qQQO3WJT3d
 X4HhzhegFUbbZys9QY+0sB1w6VtuxLAEPujzq1InP/j9Zty9tcc0ZkpoTeSOucz+YK
 UMyimDquVqQAN3qfN/yzjL1nOjHkTX/8MEnOHueQ=
Date: Thu, 26 Sep 2019 21:39:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 16/20] spapr, xics, xive: Better use of assert()s on irq
 claim/free paths
Message-ID: <20190926113922.GB17405@umbus>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-17-david@gibson.dropbear.id.au>
 <20190926100841.5c8b779b@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="M5PHxtWZRXQUdpfa"
Content-Disposition: inline
In-Reply-To: <20190926100841.5c8b779b@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 clg@kaod.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--M5PHxtWZRXQUdpfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2019 at 10:08:41AM +0200, Greg Kurz wrote:
> On Wed, 25 Sep 2019 16:45:30 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > The irq claim and free paths for both XICS and XIVE check for some
> > validity conditions.  Some of these represent genuine runtime failures,
> > however others - particularly checking that the basic irq number is in a
> > sane range - could only fail in the case of bugs in the callin code.
> > Therefore use assert()s instead of runtime failures for those.
> >=20
> > In addition the non backend-specific part of the claim/free paths should
> > only be used for PAPR external irqs, that is in the range SPAPR_XIRQ_BA=
SE
> > to the maximum irq number.  Put assert()s for that into the top level
> > dispatchers as well.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/intc/spapr_xive.c |  8 ++------
> >  hw/ppc/spapr_irq.c   | 18 ++++++++++--------
> >  2 files changed, 12 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> > index c1c97192a7..47b5ec0b56 100644
> > --- a/hw/intc/spapr_xive.c
> > +++ b/hw/intc/spapr_xive.c
> > @@ -532,9 +532,7 @@ bool spapr_xive_irq_claim(SpaprXive *xive, uint32_t=
 lisn, bool lsi)
> >  {
> >      XiveSource *xsrc =3D &xive->source;
> > =20
> > -    if (lisn >=3D xive->nr_irqs) {
> > -        return false;
> > -    }
> > +    assert(lisn < xive->nr_irqs);
> > =20
> >      /*
> >       * Set default values when allocating an IRQ number
> > @@ -559,9 +557,7 @@ bool spapr_xive_irq_claim(SpaprXive *xive, uint32_t=
 lisn, bool lsi)
> > =20
> >  bool spapr_xive_irq_free(SpaprXive *xive, uint32_t lisn)
> >  {
> > -    if (lisn >=3D xive->nr_irqs) {
> > -        return false;
> > -    }
> > +    assert(lisn < xive->nr_irqs);
> > =20
> >      xive->eat[lisn].w &=3D cpu_to_be64(~EAS_VALID);
> >      return true;
> > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > index c40357a985..261d66ba17 100644
> > --- a/hw/ppc/spapr_irq.c
> > +++ b/hw/ppc/spapr_irq.c
> > @@ -118,11 +118,7 @@ static int spapr_irq_claim_xics(SpaprMachineState =
*spapr, int irq, bool lsi,
> >      ICSState *ics =3D spapr->ics;
> > =20
> >      assert(ics);
> > -
> > -    if (!ics_valid_irq(ics, irq)) {
> > -        error_setg(errp, "IRQ %d is invalid", irq);
> > -        return -1;
> > -    }
> > +    assert(ics_valid_irq(ics, irq));
> > =20
> >      if (!ics_irq_free(ics, irq - ics->offset)) {
> >          error_setg(errp, "IRQ %d is not free", irq);
> > @@ -138,9 +134,9 @@ static void spapr_irq_free_xics(SpaprMachineState *=
spapr, int irq)
> >      ICSState *ics =3D spapr->ics;
> >      uint32_t srcno =3D irq - ics->offset;
> > =20
> > -    if (ics_valid_irq(ics, irq)) {
> > -        memset(&ics->irqs[srcno], 0, sizeof(ICSIRQState));
> > -    }
> > +    assert(ics_valid_irq(ics, irq));
> > +
> > +    memset(&ics->irqs[srcno], 0, sizeof(ICSIRQState));
> >  }
> > =20
> >  static void spapr_irq_print_info_xics(SpaprMachineState *spapr, Monito=
r *mon)
> > @@ -628,6 +624,9 @@ void spapr_irq_init(SpaprMachineState *spapr, Error=
 **errp)
> > =20
> >  int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error=
 **errp)
> >  {
> > +    assert(irq >=3D SPAPR_XIRQ_BASE);
> > +    assert(irq < (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
> > +
> >      return spapr->irq->claim(spapr, irq, lsi, errp);
> >  }
> > =20
> > @@ -635,6 +634,9 @@ void spapr_irq_free(SpaprMachineState *spapr, int i=
rq, int num)
> >  {
> >      int i;
> > =20
> > +    assert(irq >=3D SPAPR_XIRQ_BASE);
> > +    assert((irq+num) <=3D (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
>=20
> Non surprisingly this makes checkpatch unhappy:
>=20
> ERROR: spaces required around that '+' (ctx:VxV)
> #91: FILE: hw/ppc/spapr_irq.c:638:
> +    assert((irq+num) <=3D (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));

Oops, fixed.  I hadn't done a checkpatch run yet, since I'm still
working actively on the series.

>=20
> With that fixed,
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> > +
> >      for (i =3D irq; i < (irq + num); i++) {
> >          spapr->irq->free(spapr, irq);
> >      }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--M5PHxtWZRXQUdpfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2Mo2oACgkQbDjKyiDZ
s5JSsQ//Xo3iKYfE1YBcsp3/R9ul7gln2SXqpCsh9IKasLsWfRHRmldTNW/v6Ml8
G75I8vo4kT1aZclNOcol2MBQo78cCTKwQmhJC9qYlhRsEzppYdqywPP+KuHGVtHL
+WOkXcrgd/Xzh3tviD5FVFPl+mfdBiIoa0X5sOCjayibbjGarp4hnNF2zfC6ssac
NxDRG2eRmJwJ98ALyP6396BtMSK6+nrLVMfC/0NPNpq4r1kgogThEZRQIBpQon/v
q0+IG3PvcjiexfjoDLKN5C41DBbc3eq8E88khkAnc8z5XE0aqYAWt+c9FJl/TM6u
vF4n+zF7tD6shNuW6j3Hsl/MM+VhvcEUetMebvL1opCxZAoWtUchn1UGCe3X3j2S
v9cJ+hqVGFjO/FL+gyKpuz3Zy9RJpv2GpB4ArQg3DpSxLuZrSBtIC53z4GYHbEBk
cytv92GcjOvzER9LjNdzlMOMLP/jH6Ip/nfg7NzGzUfUv4LArYupLbBTLQ/gMBwe
FAL5IidL80cHIDSHg31MplF95lQazupo0qEU7zqprZYgeGSAhDwEYUwGefMbJNc8
fdErJdJMhdv+VoYkdiHceAk8POwh/GA851GuYR0t0Z0HadA/pW154GY8nW7koeZg
QqYObW43bHV0EK7sc1/jOpLU0hf5TVAnGS2xrRztyUTbAgnzh5I=
=LY0Y
-----END PGP SIGNATURE-----

--M5PHxtWZRXQUdpfa--

