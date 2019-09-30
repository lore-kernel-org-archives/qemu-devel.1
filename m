Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E8DC4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 04:24:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54B602086A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 04:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="o4hvJqIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B602086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43609 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEnE8-0000Xz-Hd
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 00:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iEn65-0002Sg-Jp
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 00:15:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iEn62-0001qT-QF
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 00:15:41 -0400
Received: from ozlabs.org ([203.11.71.1]:34321)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iEn62-0001ph-4g; Mon, 30 Sep 2019 00:15:38 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46hTb65vxZz9sPc; Mon, 30 Sep 2019 14:15:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569816930;
 bh=RRQTRaO5OFnniHtkmGnU0R2/DhqyUuh9obzMt/RBEgk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=o4hvJqIr3zefUCHEaD9+Fde/5Wli6AsVPoGh5Ldhen7eRpK+2bqv1cbAep/jPXXW7
 r6IV8PfBHM7vr5NdaRFLRKGCTpLKrTkBa151aO3cdnud1ClWcHyD9S5Fx7Oc5EmrZh
 9McnVLsEjKUaYXZ2HRlymNdmQ53COvlAzz3Z7rBQ=
Date: Mon, 30 Sep 2019 12:41:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 24/33] spapr, xics, xive: Move set_irq from SpaprIrq
 to SpaprInterruptController
Message-ID: <20190930024139.GE11105@umbus.fritz.box>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-25-david@gibson.dropbear.id.au>
 <20190927162712.049286e1@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IU5/I01NYhRvwH70"
Content-Disposition: inline
In-Reply-To: <20190927162712.049286e1@bahia.lan>
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 clg@kaod.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--IU5/I01NYhRvwH70
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2019 at 04:27:12PM +0200, Greg Kurz wrote:
> On Fri, 27 Sep 2019 15:50:19 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > This method depends only on the active irq controller.  Now that we've
> > formalized the notion of active controller we can dispatch directly thr=
ough
> > that, rather than dispatching via SpaprIrq with the dual version having
> > to do a second conditional dispatch.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/intc/spapr_xive.c       | 12 +++++++++++
> >  hw/intc/xics_spapr.c       |  9 +++++++++
> >  hw/ppc/spapr_irq.c         | 41 ++++++++++----------------------------
> >  include/hw/ppc/spapr_irq.h |  4 +++-
> >  4 files changed, 34 insertions(+), 32 deletions(-)
> >=20
> > diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> > index ff1a175b44..52d5e71793 100644
> > --- a/hw/intc/spapr_xive.c
> > +++ b/hw/intc/spapr_xive.c
> > @@ -553,6 +553,17 @@ static int spapr_xive_cpu_intc_create(SpaprInterru=
ptController *intc,
> >      return 0;
> >  }
> > =20
> > +static void spapr_xive_set_irq(SpaprInterruptController *intc, int irq=
, int val)
> > +{
> > +    SpaprXive *xive =3D SPAPR_XIVE(intc);
> > +
> > +    if (kvm_irqchip_in_kernel()) {
> > +        kvmppc_xive_source_set_irq(&xive->source, irq, val);
> > +    } else {
> > +        xive_source_set_irq(&xive->source, irq, val);
> > +    }
> > +}
> > +
> >  static void spapr_xive_class_init(ObjectClass *klass, void *data)
> >  {
> >      DeviceClass *dc =3D DEVICE_CLASS(klass);
> > @@ -574,6 +585,7 @@ static void spapr_xive_class_init(ObjectClass *klas=
s, void *data)
> >      sicc->cpu_intc_create =3D spapr_xive_cpu_intc_create;
> >      sicc->claim_irq =3D spapr_xive_claim_irq;
> >      sicc->free_irq =3D spapr_xive_free_irq;
> > +    sicc->set_irq =3D spapr_xive_set_irq;
> >  }
> > =20
> >  static const TypeInfo spapr_xive_info =3D {
> > diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> > index 224fe1efcd..02372697f6 100644
> > --- a/hw/intc/xics_spapr.c
> > +++ b/hw/intc/xics_spapr.c
> > @@ -373,6 +373,14 @@ static void xics_spapr_free_irq(SpaprInterruptCont=
roller *intc, int irq)
> >      memset(&ics->irqs[srcno], 0, sizeof(ICSIRQState));
> >  }
> > =20
> > +static void xics_spapr_set_irq(SpaprInterruptController *intc, int irq=
, int val)
> > +{
> > +    ICSState *ics =3D ICS_SPAPR(intc);
> > +    uint32_t srcno =3D irq - ics->offset;
> > +
> > +    ics_set_irq(ics, srcno, val);
>=20
> And we have:
>=20
> void ics_set_irq(void *opaque, int srcno, int val)
> {
>     ICSState *ics =3D (ICSState *)opaque;
>=20
>     if (kvm_irqchip_in_kernel()) {
>         ics_kvm_set_irq(ics, srcno, val);
>         return;
>     }
>=20
>     if (ics->irqs[srcno].flags & XICS_FLAGS_IRQ_LSI) {
>         ics_set_irq_lsi(ics, srcno, val);
>     } else {
>         ics_set_irq_msi(ics, srcno, val);
>     }
> }
>=20
> The kvm_irqchip_in_kernel() block would fit better in xics_spapr_set_irq(=
),
> like it is already the case for XIVE.

Hmm.. I don't really see why you say that.

> Maybe do it now while here ?
>=20
> Anyway,
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> > +}
> > +
> >  static void ics_spapr_class_init(ObjectClass *klass, void *data)
> >  {
> >      DeviceClass *dc =3D DEVICE_CLASS(klass);
> > @@ -384,6 +392,7 @@ static void ics_spapr_class_init(ObjectClass *klass=
, void *data)
> >      sicc->cpu_intc_create =3D xics_spapr_cpu_intc_create;
> >      sicc->claim_irq =3D xics_spapr_claim_irq;
> >      sicc->free_irq =3D xics_spapr_free_irq;
> > +    sicc->set_irq =3D xics_spapr_set_irq;
> >  }
> > =20
> >  static const TypeInfo ics_spapr_info =3D {
> > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > index dfa875b7cd..4922062908 100644
> > --- a/hw/ppc/spapr_irq.c
> > +++ b/hw/ppc/spapr_irq.c
> > @@ -123,14 +123,6 @@ static int spapr_irq_post_load_xics(SpaprMachineSt=
ate *spapr, int version_id)
> >      return 0;
> >  }
> > =20
> > -static void spapr_irq_set_irq_xics(void *opaque, int irq, int val)
> > -{
> > -    SpaprMachineState *spapr =3D opaque;
> > -    uint32_t srcno =3D irq - spapr->ics->offset;
> > -
> > -    ics_set_irq(spapr->ics, srcno, val);
> > -}
> > -
> >  static void spapr_irq_reset_xics(SpaprMachineState *spapr, Error **err=
p)
> >  {
> >      Error *local_err =3D NULL;
> > @@ -159,7 +151,6 @@ SpaprIrq spapr_irq_xics =3D {
> >      .dt_populate =3D spapr_dt_xics,
> >      .post_load   =3D spapr_irq_post_load_xics,
> >      .reset       =3D spapr_irq_reset_xics,
> > -    .set_irq     =3D spapr_irq_set_irq_xics,
> >      .init_kvm    =3D spapr_irq_init_kvm_xics,
> >  };
> > =20
> > @@ -208,17 +199,6 @@ static void spapr_irq_reset_xive(SpaprMachineState=
 *spapr, Error **errp)
> >      spapr_xive_mmio_set_enabled(spapr->xive, true);
> >  }
> > =20
> > -static void spapr_irq_set_irq_xive(void *opaque, int irq, int val)
> > -{
> > -    SpaprMachineState *spapr =3D opaque;
> > -
> > -    if (kvm_irqchip_in_kernel()) {
> > -        kvmppc_xive_source_set_irq(&spapr->xive->source, irq, val);
> > -    } else {
> > -        xive_source_set_irq(&spapr->xive->source, irq, val);
> > -    }
> > -}
> > -
> >  static void spapr_irq_init_kvm_xive(SpaprMachineState *spapr, Error **=
errp)
> >  {
> >      if (kvm_enabled()) {
> > @@ -236,7 +216,6 @@ SpaprIrq spapr_irq_xive =3D {
> >      .dt_populate =3D spapr_dt_xive,
> >      .post_load   =3D spapr_irq_post_load_xive,
> >      .reset       =3D spapr_irq_reset_xive,
> > -    .set_irq     =3D spapr_irq_set_irq_xive,
> >      .init_kvm    =3D spapr_irq_init_kvm_xive,
> >  };
> > =20
> > @@ -316,13 +295,6 @@ static void spapr_irq_reset_dual(SpaprMachineState=
 *spapr, Error **errp)
> >      spapr_irq_current(spapr)->reset(spapr, errp);
> >  }
> > =20
> > -static void spapr_irq_set_irq_dual(void *opaque, int irq, int val)
> > -{
> > -    SpaprMachineState *spapr =3D opaque;
> > -
> > -    spapr_irq_current(spapr)->set_irq(spapr, irq, val);
> > -}
> > -
> >  /*
> >   * Define values in sync with the XIVE and XICS backend
> >   */
> > @@ -336,7 +308,6 @@ SpaprIrq spapr_irq_dual =3D {
> >      .dt_populate =3D spapr_irq_dt_populate_dual,
> >      .post_load   =3D spapr_irq_post_load_dual,
> >      .reset       =3D spapr_irq_reset_dual,
> > -    .set_irq     =3D spapr_irq_set_irq_dual,
> >      .init_kvm    =3D NULL, /* should not be used */
> >  };
> > =20
> > @@ -422,6 +393,15 @@ int spapr_irq_cpu_intc_create(SpaprMachineState *s=
papr,
> >      return 0;
> >  }
> > =20
> > +static void spapr_set_irq(void *opaque, int irq, int level)
> > +{
> > +    SpaprMachineState *spapr =3D SPAPR_MACHINE(opaque);
> > +    SpaprInterruptControllerClass *sicc
> > +        =3D SPAPR_INTC_GET_CLASS(spapr->active_intc);
> > +
> > +    sicc->set_irq(spapr->active_intc, irq, level);
> > +}
> > +
> >  void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
> >  {
> >      MachineState *machine =3D MACHINE(spapr);
> > @@ -510,7 +490,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error=
 **errp)
> >          spapr_xive_hcall_init(spapr);
> >      }
> > =20
> > -    spapr->qirqs =3D qemu_allocate_irqs(spapr->irq->set_irq, spapr,
> > +    spapr->qirqs =3D qemu_allocate_irqs(spapr_set_irq, spapr,
> >                                        spapr->irq->nr_xirqs + SPAPR_XIR=
Q_BASE);
> > =20
> >  out:
> > @@ -744,7 +724,6 @@ SpaprIrq spapr_irq_xics_legacy =3D {
> >      .dt_populate =3D spapr_dt_xics,
> >      .post_load   =3D spapr_irq_post_load_xics,
> >      .reset       =3D spapr_irq_reset_xics,
> > -    .set_irq     =3D spapr_irq_set_irq_xics,
> >      .init_kvm    =3D spapr_irq_init_kvm_xics,
> >  };
> > =20
> > diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> > index 3102d152b2..8286a9aa63 100644
> > --- a/include/hw/ppc/spapr_irq.h
> > +++ b/include/hw/ppc/spapr_irq.h
> > @@ -56,6 +56,9 @@ typedef struct SpaprInterruptControllerClass {
> >      int (*claim_irq)(SpaprInterruptController *intc, int irq, bool lsi,
> >                       Error **errp);
> >      void (*free_irq)(SpaprInterruptController *intc, int irq);
> > +
> > +    /* These methods should only be called on the active intc */
> > +    void (*set_irq)(SpaprInterruptController *intc, int irq, int val);
> >  } SpaprInterruptControllerClass;
> > =20
> >  void spapr_irq_update_active_intc(SpaprMachineState *spapr);
> > @@ -83,7 +86,6 @@ typedef struct SpaprIrq {
> >                          void *fdt, uint32_t phandle);
> >      int (*post_load)(SpaprMachineState *spapr, int version_id);
> >      void (*reset)(SpaprMachineState *spapr, Error **errp);
> > -    void (*set_irq)(void *opaque, int srcno, int val);
> >      void (*init_kvm)(SpaprMachineState *spapr, Error **errp);
> >  } SpaprIrq;
> > =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IU5/I01NYhRvwH70
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2Ra2IACgkQbDjKyiDZ
s5L4xxAArPwQGJOgzCY9nv77RFUbodZzTx5syKVZiJOj1ptU81OAH2AjQWw9qCjx
ZEL20BZ9zkDI3aI9pro+5lIaiOi0BmBthJG3yrdBDLz3bW3N+Jux07N3YjdYVM2g
BaAT1oazn67IypD8KHRjZiRSRvoS7bbzs9EMJPTwD3WBxipzrjezQ84buoRqM4yj
q618zdLCSl50UXUxkzmZc0FWRzs97W0AEl1Z5TXTv8T79zpO4p9r1CmvAmMilWZC
HSZ2mwTfuEqIxPHHr08lS/50uIkkQL1LIpirqhiH4iY/G43nolCUc+Nshx2ehfPs
1blgnTGtinSEKML9HFJzJab7KH4kuqEh7VIQwJEDbkBVnSq3uCf1Sw4jwKv2C05+
punuiojVopD3IsdiumoXWmPj++mfBnngQBzUYuT4k3JnmiETriIhmPe1fTKtSePg
WkGjXUiW2OUGM17HfMu2x1gchMVNAG4GOq6kXMrnR2G8rTSdctgm1Sf0KOz30giG
OQpNs8pW6qYy1S4d9o26C8Xumuw6mFwvgoISOA8uUzyzZqobY4ock0y5bnyroKbM
zgnks5HpGIXrZChm/OzHO03V8rtRQVaTGTjcP7CmouQ2lQG+/OVB/eZCQDgsYDrH
4qMSQz3e1qL5DPILvpF+8CqwrjFIOgzPHssASc6p1zCH650fDPo=
=kIPg
-----END PGP SIGNATURE-----

--IU5/I01NYhRvwH70--

