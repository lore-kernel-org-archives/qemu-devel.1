Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45910C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 06:18:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1F7C205C9
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 06:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bqSDE/cq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F7C205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFXxv-0005Mn-1o
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 02:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFXwO-0004Ng-S6
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 02:16:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFXwN-0007cq-09
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 02:16:48 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:52807)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFXwM-0007aK-K7; Wed, 02 Oct 2019 02:16:46 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46jmB16CsSz9sPl; Wed,  2 Oct 2019 16:16:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569997001;
 bh=UvEvbvkdNMkfehWvigyyLcrNkorbE3OIBp8fGHyKvgY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bqSDE/cqdQXsi3VjjBCtnTVnkrSGTA38boVgIvsFeQj4i1nV/zVag670P59/Wqt9C
 d9fjA2NShZ1Fc7UEBothCjv1GYnTszwkdhdPPGDKn/M1q/4CuHY0ZJJ8rpD61qlMUt
 5vVOD2rxxNgNyU9hG7682kFP/YfmsTFu8tr8WBh0=
Date: Wed, 2 Oct 2019 16:16:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3 23/34] spapr, xics, xive: Move irq claim and free from
 SpaprIrq to SpaprInterruptController
Message-ID: <20191002061636.GX11105@umbus.fritz.box>
References: <20191002025208.3487-1-david@gibson.dropbear.id.au>
 <20191002025208.3487-24-david@gibson.dropbear.id.au>
 <d4506422-a905-7e53-2daf-5b3bc4cb0470@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dZJOqldIUwtPuZvk"
Content-Disposition: inline
In-Reply-To: <d4506422-a905-7e53-2daf-5b3bc4cb0470@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--dZJOqldIUwtPuZvk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2019 at 08:10:33AM +0200, C=E9dric Le Goater wrote:
> On 02/10/2019 04:51, David Gibson wrote:
> > These methods, like cpu_intc_create, really belong to the interrupt
> > controller, but need to be called on all possible intcs.
> >=20
> > Like cpu_intc_create, therefore, make them methods on the intc and
> > always call it for all existing intcs.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/intc/spapr_xive.c        |  71 ++++++++++++-----------
> >  hw/intc/xics_spapr.c        |  29 ++++++++++
> >  hw/ppc/spapr_irq.c          | 110 +++++++++++-------------------------
> >  include/hw/ppc/spapr_irq.h  |   5 +-
> >  include/hw/ppc/spapr_xive.h |   2 -
> >  5 files changed, 102 insertions(+), 115 deletions(-)
> >=20
> > diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> > index 9338daba3d..ff1a175b44 100644
> > --- a/hw/intc/spapr_xive.c
> > +++ b/hw/intc/spapr_xive.c
> > @@ -487,6 +487,42 @@ static const VMStateDescription vmstate_spapr_xive=
 =3D {
> >      },
> >  };
> > =20
> > +static int spapr_xive_claim_irq(SpaprInterruptController *intc, int li=
sn,
> > +                                bool lsi, Error **errp)
> > +{
> > +    SpaprXive *xive =3D SPAPR_XIVE(intc);
> > +    XiveSource *xsrc =3D &xive->source;
> > +
> > +    assert(lisn < xive->nr_irqs);
> > +
> > +    if (xive_eas_is_valid(&xive->eat[lisn])) {
> > +        error_setg(errp, "IRQ %d is not free", lisn);
> > +        return -EBUSY;
> > +    }
> > +
> > +    /*
> > +     * Set default values when allocating an IRQ number
> > +     */
> > +    xive->eat[lisn].w |=3D cpu_to_be64(EAS_VALID | EAS_MASKED);
> > +    if (lsi) {
> > +        xive_source_irq_set_lsi(xsrc, lisn);
> > +    }
> > +
> > +    if (kvm_irqchip_in_kernel()) {
> > +        return kvmppc_xive_source_reset_one(xsrc, lisn, errp);
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static void spapr_xive_free_irq(SpaprInterruptController *intc, int li=
sn)
> > +{
> > +    SpaprXive *xive =3D SPAPR_XIVE(intc);
> > +    assert(lisn < xive->nr_irqs);
> > +
> > +    xive->eat[lisn].w &=3D cpu_to_be64(~EAS_VALID);
> > +}
> > +
> >  static Property spapr_xive_properties[] =3D {
> >      DEFINE_PROP_UINT32("nr-irqs", SpaprXive, nr_irqs, 0),
> >      DEFINE_PROP_UINT32("nr-ends", SpaprXive, nr_ends, 0),
> > @@ -536,6 +572,8 @@ static void spapr_xive_class_init(ObjectClass *klas=
s, void *data)
> >      xrc->get_tctx =3D spapr_xive_get_tctx;
> > =20
> >      sicc->cpu_intc_create =3D spapr_xive_cpu_intc_create;
> > +    sicc->claim_irq =3D spapr_xive_claim_irq;
> > +    sicc->free_irq =3D spapr_xive_free_irq;
> >  }
> > =20
> >  static const TypeInfo spapr_xive_info =3D {
> > @@ -557,39 +595,6 @@ static void spapr_xive_register_types(void)
> > =20
> >  type_init(spapr_xive_register_types)
> > =20
> > -int spapr_xive_irq_claim(SpaprXive *xive, int lisn, bool lsi, Error **=
errp)
> > -{
> > -    XiveSource *xsrc =3D &xive->source;
> > -
> > -    assert(lisn < xive->nr_irqs);
> > -
> > -    if (xive_eas_is_valid(&xive->eat[lisn])) {
> > -        error_setg(errp, "IRQ %d is not free", lisn);
> > -        return -EBUSY;
> > -    }
> > -
> > -    /*
> > -     * Set default values when allocating an IRQ number
> > -     */
> > -    xive->eat[lisn].w |=3D cpu_to_be64(EAS_VALID | EAS_MASKED);
> > -    if (lsi) {
> > -        xive_source_irq_set_lsi(xsrc, lisn);
> > -    }
> > -
> > -    if (kvm_irqchip_in_kernel()) {
> > -        return kvmppc_xive_source_reset_one(xsrc, lisn, errp);
> > -    }
> > -
> > -    return 0;
> > -}
> > -
> > -void spapr_xive_irq_free(SpaprXive *xive, int lisn)
> > -{
> > -    assert(lisn < xive->nr_irqs);
> > -
> > -    xive->eat[lisn].w &=3D cpu_to_be64(~EAS_VALID);
> > -}
> > -
> >  /*
> >   * XIVE hcalls
> >   *
> > diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> > index 946311b858..224fe1efcd 100644
> > --- a/hw/intc/xics_spapr.c
> > +++ b/hw/intc/xics_spapr.c
> > @@ -346,6 +346,33 @@ static int xics_spapr_cpu_intc_create(SpaprInterru=
ptController *intc,
> >      return 0;
> >  }
> > =20
> > +static int xics_spapr_claim_irq(SpaprInterruptController *intc, int ir=
q,
> > +                                bool lsi, Error **errp)
> > +{
> > +    ICSState *ics =3D ICS_SPAPR(intc);
> > +
> > +    assert(ics);
> > +    assert(ics_valid_irq(ics, irq));
> > +
> > +    if (!ics_irq_free(ics, irq - ics->offset)) {
> > +        error_setg(errp, "IRQ %d is not free", irq);
> > +        return -EBUSY;
> > +    }
> > +
> > +    ics_set_irq_type(ics, irq - ics->offset, lsi);
> > +    return 0;
> > +}
> > +
> > +static void xics_spapr_free_irq(SpaprInterruptController *intc, int ir=
q)
> > +{
> > +    ICSState *ics =3D ICS_SPAPR(intc);
> > +    uint32_t srcno =3D irq - ics->offset;
> > +
> > +    assert(ics_valid_irq(ics, irq));
> > +
> > +    memset(&ics->irqs[srcno], 0, sizeof(ICSIRQState));
> > +}
> > +
> >  static void ics_spapr_class_init(ObjectClass *klass, void *data)
> >  {
> >      DeviceClass *dc =3D DEVICE_CLASS(klass);
> > @@ -355,6 +382,8 @@ static void ics_spapr_class_init(ObjectClass *klass=
, void *data)
> >      device_class_set_parent_realize(dc, ics_spapr_realize,
> >                                      &isc->parent_realize);
> >      sicc->cpu_intc_create =3D xics_spapr_cpu_intc_create;
> > +    sicc->claim_irq =3D xics_spapr_claim_irq;
> > +    sicc->free_irq =3D xics_spapr_free_irq;
> >  }
> > =20
> >  static const TypeInfo ics_spapr_info =3D {
> > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > index 9cb2fc71ca..83882cfad3 100644
> > --- a/hw/ppc/spapr_irq.c
> > +++ b/hw/ppc/spapr_irq.c
> > @@ -98,33 +98,6 @@ static void spapr_irq_init_kvm(SpaprMachineState *sp=
apr,
> >   * XICS IRQ backend.
> >   */
> > =20
> > -static int spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, boo=
l lsi,
> > -                                Error **errp)
> > -{
> > -    ICSState *ics =3D spapr->ics;
> > -
> > -    assert(ics);
> > -    assert(ics_valid_irq(ics, irq));
> > -
> > -    if (!ics_irq_free(ics, irq - ics->offset)) {
> > -        error_setg(errp, "IRQ %d is not free", irq);
> > -        return -1;
> > -    }
> > -
> > -    ics_set_irq_type(ics, irq - ics->offset, lsi);
> > -    return 0;
> > -}
> > -
> > -static void spapr_irq_free_xics(SpaprMachineState *spapr, int irq)
> > -{
> > -    ICSState *ics =3D spapr->ics;
> > -    uint32_t srcno =3D irq - ics->offset;
> > -
> > -    assert(ics_valid_irq(ics, irq));
> > -
> > -    memset(&ics->irqs[srcno], 0, sizeof(ICSIRQState));
> > -}
> > -
> >  static void spapr_irq_print_info_xics(SpaprMachineState *spapr, Monito=
r *mon)
> >  {
> >      CPUState *cs;
> > @@ -182,8 +155,6 @@ SpaprIrq spapr_irq_xics =3D {
> >      .xics        =3D true,
> >      .xive        =3D false,
> > =20
> > -    .claim       =3D spapr_irq_claim_xics,
> > -    .free        =3D spapr_irq_free_xics,
> >      .print_info  =3D spapr_irq_print_info_xics,
> >      .dt_populate =3D spapr_dt_xics,
> >      .post_load   =3D spapr_irq_post_load_xics,
> > @@ -196,17 +167,6 @@ SpaprIrq spapr_irq_xics =3D {
> >   * XIVE IRQ backend.
> >   */
> > =20
> > -static int spapr_irq_claim_xive(SpaprMachineState *spapr, int irq, boo=
l lsi,
> > -                                Error **errp)
> > -{
> > -    return spapr_xive_irq_claim(spapr->xive, irq, lsi, errp);
> > -}
> > -
> > -static void spapr_irq_free_xive(SpaprMachineState *spapr, int irq)
> > -{
> > -    spapr_xive_irq_free(spapr->xive, irq);
> > -}
> > -
> >  static void spapr_irq_print_info_xive(SpaprMachineState *spapr,
> >                                        Monitor *mon)
> >  {
> > @@ -272,8 +232,6 @@ SpaprIrq spapr_irq_xive =3D {
> >      .xics        =3D false,
> >      .xive        =3D true,
> > =20
> > -    .claim       =3D spapr_irq_claim_xive,
> > -    .free        =3D spapr_irq_free_xive,
> >      .print_info  =3D spapr_irq_print_info_xive,
> >      .dt_populate =3D spapr_dt_xive,
> >      .post_load   =3D spapr_irq_post_load_xive,
> > @@ -301,33 +259,6 @@ static SpaprIrq *spapr_irq_current(SpaprMachineSta=
te *spapr)
> >          &spapr_irq_xive : &spapr_irq_xics;
> >  }
> > =20
> > -static int spapr_irq_claim_dual(SpaprMachineState *spapr, int irq, boo=
l lsi,
> > -                                Error **errp)
> > -{
> > -    Error *local_err =3D NULL;
> > -    int ret;
> > -
> > -    ret =3D spapr_irq_xics.claim(spapr, irq, lsi, &local_err);
> > -    if (local_err) {
> > -        error_propagate(errp, local_err);
> > -        return ret;
> > -    }
> > -
> > -    ret =3D spapr_irq_xive.claim(spapr, irq, lsi, &local_err);
> > -    if (local_err) {
> > -        error_propagate(errp, local_err);
> > -        return ret;
> > -    }
> > -
> > -    return ret;
> > -}
> > -
> > -static void spapr_irq_free_dual(SpaprMachineState *spapr, int irq)
> > -{
> > -    spapr_irq_xics.free(spapr, irq);
> > -    spapr_irq_xive.free(spapr, irq);
> > -}
> > -
> >  static void spapr_irq_print_info_dual(SpaprMachineState *spapr, Monito=
r *mon)
> >  {
> >      spapr_irq_current(spapr)->print_info(spapr, mon);
> > @@ -401,8 +332,6 @@ SpaprIrq spapr_irq_dual =3D {
> >      .xics        =3D true,
> >      .xive        =3D true,
> > =20
> > -    .claim       =3D spapr_irq_claim_dual,
> > -    .free        =3D spapr_irq_free_dual,
> >      .print_info  =3D spapr_irq_print_info_dual,
> >      .dt_populate =3D spapr_irq_dt_populate_dual,
> >      .post_load   =3D spapr_irq_post_load_dual,
> > @@ -572,8 +501,11 @@ void spapr_irq_init(SpaprMachineState *spapr, Erro=
r **errp)
> > =20
> >          /* Enable the CPU IPIs */
> >          for (i =3D 0; i < nr_servers; ++i) {
> > -            if (spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i,
> > -                                     false, errp) < 0) {
> > +            SpaprInterruptControllerClass *sicc
> > +                =3D SPAPR_INTC_GET_CLASS(spapr->xive);
> > +
> > +            if (sicc->claim_irq(SPAPR_INTC(spapr->xive), SPAPR_IRQ_IPI=
 + i,
> > +                                false, errp) < 0) {
>=20
>=20
> This should be called for Xive only. Why is this using the class
> handler ?

Only to avoid adding another exported function to the headers, when
it's already indirectly exposed via the hook.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dZJOqldIUwtPuZvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2UQMQACgkQbDjKyiDZ
s5KKahAAiAjhgWggk4abgllFuoHVX2UhO4a0JFL3f426U5CfPyWi1EtKUNqNtQh+
WcCzzhLZyDSIt9nmozVuMuzCJQ4tjVqPsVGtnANTR67bT2BpL+cj36E2oS6+SrCl
fhSzBsayLYK+aHQ0LVfcSMSlo92IJ8gUAIe3YNr1kRLX+eMPQwguj6Lzqxhbtvbz
44E827s/xqFr/FUcgKTErPoKshIyQLDhj0DlNSOVxGLfKvfIv64W0ZVs+rrjh6F3
XGMaBp6h69dqUeUVuCyVilKP8nMzTUWjyddo1HvlOvzxXwtOuDGuTBlPNuhF7iva
ilISkgfRgnzrcse5shbNyTz88GJNX5MxzG3oMSqPmG1tB1rnIHHw9Rwy/qSoG0HS
lRxQunCyztCe8ob052Hpu+YuHig6qBN9bbaJN12+rWRaO1hfSef2DHs9m0P/CROc
/tRo/jghazAtBLF/CLC2Uwq8ZH9KVNH6A3DEBJVbk1WDffad96oKO9n9Vzw8C9Ev
wGvGFmp77WQUL7Z1S8T1s24FzfJuAEwxGPuQWhQJIx3sCliwHhe1DJUmnLc1FjUU
tuWph28oS36EU/F7yizJ+CXoHl0xBRSrNHWgN27BSfqL/+C0t6DmKUh/YiLATvh/
TqcUlXMtadw3H1XPDHQHIkpQYUdQAU5Y8P0Ma1oC3+uRo4a2/3c=
=NVfD
-----END PGP SIGNATURE-----

--dZJOqldIUwtPuZvk--

