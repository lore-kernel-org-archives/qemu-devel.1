Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858B7C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 01:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F280222BE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 01:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ddTocqig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F280222BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDIfx-00061K-7p
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 21:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iDIaP-0000tf-Fa
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 21:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iDIaN-0003Xj-OG
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 21:28:49 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59729 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iDIaN-0003Sc-Bl; Wed, 25 Sep 2019 21:28:47 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46dy4P71jXz9sPd; Thu, 26 Sep 2019 11:28:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569461317;
 bh=R8TTETgP1sRhiGF7uPRTcR0/3uAs4hmUeUq8NJwfVmA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ddTocqig5Ie/Wcn8yGjy1M2BBf5xg+dzDKlU2yGS72+eJKciibFLZobvpIHM7tDfs
 nDR+of3nHuXwRs90l7EsEguglmEVUjrpTc0OCWF5HwojLl1Sq62HuIpSfIY/+v3LCx
 w/nqIuTlvX4P7gAyhIlInoLFqgf/r7faV+joIriI=
Date: Thu, 26 Sep 2019 11:13:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 20/20] spapr: Eliminate SpaprIrq::init hook
Message-ID: <20190926011336.GS17405@umbus>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-21-david@gibson.dropbear.id.au>
 <1b74c0fc-b318-df5a-d66d-fe59ae562d70@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5G+Imvfxoe+o1e80"
Content-Disposition: inline
In-Reply-To: <1b74c0fc-b318-df5a-d66d-fe59ae562d70@kaod.org>
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
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5G+Imvfxoe+o1e80
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2019 at 09:31:54AM +0200, C=E9dric Le Goater wrote:
> On 25/09/2019 08:45, David Gibson wrote:
> > This method is used to set up the interrupt backends for the current
> > configuration.  However, this means some confusing redirection between
> > the "dual" mode init and the init hooks for xics only and xive only mod=
es.
> >=20
> > Since we now have simple flags indicating whether XICS and/or XIVE are
> > supported, it's easier to just open code each initialization directly in
> > spapr_irq_init().  This will also make some future cleanups simpler.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> one comment below,
>=20
> > ---
> >  hw/ppc/spapr_irq.c          | 138 ++++++++++++++++--------------------
> >  include/hw/ppc/spapr_irq.h  |   1 -
> >  include/hw/ppc/xics_spapr.h |   1 +
> >  3 files changed, 63 insertions(+), 77 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > index 073f375ba2..62647dd5a3 100644
> > --- a/hw/ppc/spapr_irq.c
> > +++ b/hw/ppc/spapr_irq.c
> > @@ -91,27 +91,6 @@ static void spapr_irq_init_kvm(SpaprMachineState *sp=
apr,
> >  /*
> >   * XICS IRQ backend.
> >   */
> > -
> > -static void spapr_irq_init_xics(SpaprMachineState *spapr, Error **errp)
> > -{
> > -    Object *obj;
> > -    Error *local_err =3D NULL;
> > -
> > -    obj =3D object_new(TYPE_ICS_SPAPR);
> > -    object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
> > -    object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
> > -                                   &error_fatal);
> > -    object_property_set_int(obj, spapr->irq->nr_xirqs,
> > -                            "nr-irqs",  &error_fatal);
> > -    object_property_set_bool(obj, true, "realized", &local_err);
> > -    if (local_err) {
> > -        error_propagate(errp, local_err);
> > -        return;
> > -    }
> > -
> > -    spapr->ics =3D ICS_SPAPR(obj);
> > -}
> > -
> >  static void spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, bo=
ol lsi,
> >                                   Error **errp)
> >  {
> > @@ -212,7 +191,6 @@ SpaprIrq spapr_irq_xics =3D {
> >      .xics        =3D true,
> >      .xive        =3D false,
> > =20
> > -    .init        =3D spapr_irq_init_xics,
> >      .claim       =3D spapr_irq_claim_xics,
> >      .free        =3D spapr_irq_free_xics,
> >      .print_info  =3D spapr_irq_print_info_xics,
> > @@ -227,37 +205,6 @@ SpaprIrq spapr_irq_xics =3D {
> >  /*
> >   * XIVE IRQ backend.
> >   */
> > -static void spapr_irq_init_xive(SpaprMachineState *spapr, Error **errp)
> > -{
> > -    uint32_t nr_servers =3D spapr_max_server_number(spapr);
> > -    DeviceState *dev;
> > -    int i;
> > -
> > -    dev =3D qdev_create(NULL, TYPE_SPAPR_XIVE);
> > -    qdev_prop_set_uint32(dev, "nr-irqs",
> > -                         spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE);
> > -    /*
> > -     * 8 XIVE END structures per CPU. One for each available priority
> > -     */
> > -    qdev_prop_set_uint32(dev, "nr-ends", nr_servers << 3);
> > -    qdev_init_nofail(dev);
> > -
> > -    spapr->xive =3D SPAPR_XIVE(dev);
> > -
> > -    /* Enable the CPU IPIs */
> > -    for (i =3D 0; i < nr_servers; ++i) {
> > -        Error *local_err =3D NULL;
> > -
> > -        spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i, false, &l=
ocal_err);
> > -        if (local_err) {
> > -            error_propagate(errp, local_err);
> > -            return;
> > -        }
> > -    }
> > -
> > -    spapr_xive_hcall_init(spapr);
> > -}
> > -
> >  static void spapr_irq_claim_xive(SpaprMachineState *spapr, int irq, bo=
ol lsi,
> >                                   Error **errp)
> >  {
> > @@ -361,7 +308,6 @@ SpaprIrq spapr_irq_xive =3D {
> >      .xics        =3D false,
> >      .xive        =3D true,
> > =20
> > -    .init        =3D spapr_irq_init_xive,
> >      .claim       =3D spapr_irq_claim_xive,
> >      .free        =3D spapr_irq_free_xive,
> >      .print_info  =3D spapr_irq_print_info_xive,
> > @@ -392,23 +338,6 @@ static SpaprIrq *spapr_irq_current(SpaprMachineSta=
te *spapr)
> >          &spapr_irq_xive : &spapr_irq_xics;
> >  }
> > =20
> > -static void spapr_irq_init_dual(SpaprMachineState *spapr, Error **errp)
> > -{
> > -    Error *local_err =3D NULL;
> > -
> > -    spapr_irq_xics.init(spapr, &local_err);
> > -    if (local_err) {
> > -        error_propagate(errp, local_err);
> > -        return;
> > -    }
> > -
> > -    spapr_irq_xive.init(spapr, &local_err);
> > -    if (local_err) {
> > -        error_propagate(errp, local_err);
> > -        return;
> > -    }
> > -}
> > -
> >  static void spapr_irq_claim_dual(SpaprMachineState *spapr, int irq, bo=
ol lsi,
> >                                   Error **errp)
> >  {
> > @@ -520,7 +449,6 @@ SpaprIrq spapr_irq_dual =3D {
> >      .xics        =3D true,
> >      .xive        =3D true,
> > =20
> > -    .init        =3D spapr_irq_init_dual,
> >      .claim       =3D spapr_irq_claim_dual,
> >      .free        =3D spapr_irq_free_dual,
> >      .print_info  =3D spapr_irq_print_info_dual,
> > @@ -608,8 +536,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error=
 **errp)
> > =20
> >      spapr_irq_check(spapr, &local_err);
> >      if (local_err) {
> > -        error_propagate(errp, local_err);
> > -        return;
> > +        goto out;
> >      }
> > =20
> >      /* Initialize the MSI IRQ allocator. */
> > @@ -617,10 +544,70 @@ void spapr_irq_init(SpaprMachineState *spapr, Err=
or **errp)
> >          spapr_irq_msi_init(spapr, spapr->irq->nr_msis);
> >      }
> > =20
> > -    spapr->irq->init(spapr, errp);
> > +    if (spapr->irq->xics) {
> > +        Object *obj;
> > +
> > +        obj =3D object_new(TYPE_ICS_SPAPR);
> > +        object_property_add_child(OBJECT(spapr), "ics", obj, &local_er=
r);
> > +        if (local_err) {
> > +            goto out;
> > +        }
> > +
> > +        object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spap=
r),
> > +                                       &local_err);
> > +        if (local_err) {
> > +            goto out;
> > +        }
> > +
> > +        object_property_set_int(obj, spapr->irq->nr_xirqs, "nr-irqs",
> > +                                &local_err);
> > +        if (local_err) {
> > +            goto out;
> > +        }
> > +
> > +        object_property_set_bool(obj, true, "realized", &local_err);
> > +        if (local_err) {
> > +            goto out;
> > +        }
> > +
> > +        spapr->ics =3D ICS_SPAPR(obj);
> > +    }
> > +
> > +    if (spapr->irq->xive) {
> > +        uint32_t nr_servers =3D spapr_max_server_number(spapr);
> > +        DeviceState *dev;
> > +        int i;
> > +
> > +        dev =3D qdev_create(NULL, TYPE_SPAPR_XIVE);
> > +        qdev_prop_set_uint32(dev, "nr-irqs",
> > +                             spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE);
> > +        /*
> > +         * 8 XIVE END structures per CPU. One for each available
> > +         * priority
> > +         */
> > +        qdev_prop_set_uint32(dev, "nr-ends", nr_servers << 3);
> > +        qdev_init_nofail(dev);
> > +
> > +        spapr->xive =3D SPAPR_XIVE(dev);
> > +
> > +        /* Enable the CPU IPIs */
> > +        for (i =3D 0; i < nr_servers; ++i) {
> > +            Error *local_err =3D NULL;
> > +
> > +            spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i, false=
, &local_err);
> > +            if (local_err) {
> > +                goto out;
> > +            }
> > +        }
>=20
> We could move the IPI claim part in the realize routine of SPAPR_XIVE.

Yeah, I know.  I thought about this, but there's a slight complication
in that the XIVE part doesn't know nr_servers directly.  There's
several possible ways to handle that, but I wasn't 100% happy with any
that I came up with yet.
>=20
> > +        spapr_xive_hcall_init(spapr);
>=20
> This also.

Right.

> It can be done later one.

That's my intention.

>=20
> C.
>=20
> > +    }
> > =20
> >      spapr->qirqs =3D qemu_allocate_irqs(spapr->irq->set_irq, spapr,
> >                                        spapr->irq->nr_xirqs + SPAPR_XIR=
Q_BASE);
> > +
> > +out:
> > +    error_propagate(errp, local_err);
> >  }
> > =20
> >  void spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Erro=
r **errp)
> > @@ -757,7 +744,6 @@ SpaprIrq spapr_irq_xics_legacy =3D {
> >      .xics        =3D true,
> >      .xive        =3D false,
> > =20
> > -    .init        =3D spapr_irq_init_xics,
> >      .claim       =3D spapr_irq_claim_xics,
> >      .free        =3D spapr_irq_free_xics,
> >      .print_info  =3D spapr_irq_print_info_xics,
> > diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> > index 6816cb0500..fa862c665b 100644
> > --- a/include/hw/ppc/spapr_irq.h
> > +++ b/include/hw/ppc/spapr_irq.h
> > @@ -42,7 +42,6 @@ typedef struct SpaprIrq {
> >      bool        xics;
> >      bool        xive;
> > =20
> > -    void (*init)(SpaprMachineState *spapr, Error **errp);
> >      void (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error *=
*errp);
> >      void (*free)(SpaprMachineState *spapr, int irq);
> >      void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
> > diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
> > index 691a6d00f7..267984a97b 100644
> > --- a/include/hw/ppc/xics_spapr.h
> > +++ b/include/hw/ppc/xics_spapr.h
> > @@ -34,6 +34,7 @@
> >  #define TYPE_ICS_SPAPR "ics-spapr"
> >  #define ICS_SPAPR(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SPAPR)
> > =20
> > +void ics_spapr_create(SpaprMachineState *spapr, int nr_xirqs, Error **=
errp);
> >  void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void=
 *fdt,
> >                     uint32_t phandle);
> >  int xics_kvm_connect(SpaprMachineState *spapr, Error **errp);
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5G+Imvfxoe+o1e80
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2MEMAACgkQbDjKyiDZ
s5I4Qw//doKBOKHH7lv8FUtCSgaX7ltDd2LPTkcvCfwZH4OyvmrMXcjEBhGtb2ZT
eXsIr9WABPxtyjfFBy9cIPTmlpM7gu0rMxD1f3mdvIiOFu49arN5HiV3IPN3LV+8
eYRNvin/VJiqoWyb8dZLQCGqvFTqU9PwQFIfTfr4iftS1ZXxfnUbceBf7KvQ2mnS
TmfqptDhB9VUBHCnaMnsGrZsuT7IaXpdoq3+jp5O51Q5/PqVfGb1ZODiLnOh4HiK
BlWmTz7YQ6VIkZRH/ezx4eo3mpEcrg4FBK0oTBYdwWmK6JzzIXHkZ3QGL7lYfqzG
elYwo48FMZxCT86b7frMs7nZIwZlOozFAS8K5kj71mZqte69Rg7ZmcAVeJb+tiOh
cz5Vw9IDaDHgwJrTywh/5PGcn7MuAPkBmY4i/qPKGd6nvRE06GbyKxa1OJA3tFA0
1svJn0P6SkQIENrJ+N2Oz2BfTxFZDVocpr/an2J5zCvnF5oujgU9g7Ea2HBJpVU0
kSqC9PB3sP7qrHh7ifsziLmbhoYdl0aHkk3Di7kiWlSKfD4grYw/xihMHuq5BvJS
cRf+WlCBLvcvu2j042NIWTUkEfMUDPxY778183SE4uU8doIsPAPXZitgB+dMs5Px
9gcZo/1j/AJQV0qc1JyAwd+ZehAjfik8w5uJAkGlr2KkBMpUl9k=
=xG2+
-----END PGP SIGNATURE-----

--5G+Imvfxoe+o1e80--

