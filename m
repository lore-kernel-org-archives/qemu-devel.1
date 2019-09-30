Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FEDC4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 08:43:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A01CF2081B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 08:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KMNjDHOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01CF2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iErHP-0003L7-Qu
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 04:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iErGU-0002nG-GC
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 04:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iErGS-0002Ru-KC
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 04:42:41 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:51787 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iErGR-0002Qi-E8; Mon, 30 Sep 2019 04:42:40 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46hbWH0hpfz9sDB; Mon, 30 Sep 2019 18:42:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569832955;
 bh=JjwsiIXCdx29DvkfRPU3QvRl+wtkOa9IU/qeVmkJlv0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KMNjDHOd1htN0Lf2jZAn3gIE228cDnyQmIhwyZ9EHpO6Z5W1t61Tz/EOeEbP4JHWO
 Cd6lTmHlvyyOaGJxo9WtZ/XJb1g3xfu9hk3NwopQ8ulHJCwniSAe4LgMofnJ8EAPcF
 GJeBFGZZ9MAIS5tB+Hd1yMk8u8JIrhFve520Dc+k=
Date: Mon, 30 Sep 2019 18:28:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 24/33] spapr, xics, xive: Move set_irq from SpaprIrq
 to SpaprInterruptController
Message-ID: <20190930082841.GI11105@umbus.fritz.box>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-25-david@gibson.dropbear.id.au>
 <20190927162712.049286e1@bahia.lan>
 <20190930024139.GE11105@umbus.fritz.box>
 <20190930092216.544312b9@bahia.w3ibm.bluemix.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4LwthZj+AV2mq5CX"
Content-Disposition: inline
In-Reply-To: <20190930092216.544312b9@bahia.w3ibm.bluemix.net>
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
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 clg@kaod.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--4LwthZj+AV2mq5CX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2019 at 09:22:16AM +0200, Greg Kurz wrote:
> On Mon, 30 Sep 2019 12:41:39 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Sep 27, 2019 at 04:27:12PM +0200, Greg Kurz wrote:
> > > On Fri, 27 Sep 2019 15:50:19 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >=20
> > > > This method depends only on the active irq controller.  Now that we=
've
> > > > formalized the notion of active controller we can dispatch directly=
 through
> > > > that, rather than dispatching via SpaprIrq with the dual version ha=
ving
> > > > to do a second conditional dispatch.
> > > >=20
> > > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > > ---
> > > >  hw/intc/spapr_xive.c       | 12 +++++++++++
> > > >  hw/intc/xics_spapr.c       |  9 +++++++++
> > > >  hw/ppc/spapr_irq.c         | 41 ++++++++++------------------------=
----
> > > >  include/hw/ppc/spapr_irq.h |  4 +++-
> > > >  4 files changed, 34 insertions(+), 32 deletions(-)
> > > >=20
> > > > diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> > > > index ff1a175b44..52d5e71793 100644
> > > > --- a/hw/intc/spapr_xive.c
> > > > +++ b/hw/intc/spapr_xive.c
> > > > @@ -553,6 +553,17 @@ static int spapr_xive_cpu_intc_create(SpaprInt=
erruptController *intc,
> > > >      return 0;
> > > >  }
> > > > =20
> > > > +static void spapr_xive_set_irq(SpaprInterruptController *intc, int=
 irq, int val)
> > > > +{
> > > > +    SpaprXive *xive =3D SPAPR_XIVE(intc);
> > > > +
> > > > +    if (kvm_irqchip_in_kernel()) {
> > > > +        kvmppc_xive_source_set_irq(&xive->source, irq, val);
> > > > +    } else {
> > > > +        xive_source_set_irq(&xive->source, irq, val);
> > > > +    }
> > > > +}
> > > > +
> > > >  static void spapr_xive_class_init(ObjectClass *klass, void *data)
> > > >  {
> > > >      DeviceClass *dc =3D DEVICE_CLASS(klass);
> > > > @@ -574,6 +585,7 @@ static void spapr_xive_class_init(ObjectClass *=
klass, void *data)
> > > >      sicc->cpu_intc_create =3D spapr_xive_cpu_intc_create;
> > > >      sicc->claim_irq =3D spapr_xive_claim_irq;
> > > >      sicc->free_irq =3D spapr_xive_free_irq;
> > > > +    sicc->set_irq =3D spapr_xive_set_irq;
> > > >  }
> > > > =20
> > > >  static const TypeInfo spapr_xive_info =3D {
> > > > diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> > > > index 224fe1efcd..02372697f6 100644
> > > > --- a/hw/intc/xics_spapr.c
> > > > +++ b/hw/intc/xics_spapr.c
> > > > @@ -373,6 +373,14 @@ static void xics_spapr_free_irq(SpaprInterrupt=
Controller *intc, int irq)
> > > >      memset(&ics->irqs[srcno], 0, sizeof(ICSIRQState));
> > > >  }
> > > > =20
> > > > +static void xics_spapr_set_irq(SpaprInterruptController *intc, int=
 irq, int val)
> > > > +{
> > > > +    ICSState *ics =3D ICS_SPAPR(intc);
> > > > +    uint32_t srcno =3D irq - ics->offset;
> > > > +
> > > > +    ics_set_irq(ics, srcno, val);
> > >=20
> > > And we have:
> > >=20
> > > void ics_set_irq(void *opaque, int srcno, int val)
> > > {
> > >     ICSState *ics =3D (ICSState *)opaque;
> > >=20
> > >     if (kvm_irqchip_in_kernel()) {
> > >         ics_kvm_set_irq(ics, srcno, val);
> > >         return;
> > >     }
> > >=20
> > >     if (ics->irqs[srcno].flags & XICS_FLAGS_IRQ_LSI) {
> > >         ics_set_irq_lsi(ics, srcno, val);
> > >     } else {
> > >         ics_set_irq_msi(ics, srcno, val);
> > >     }
> > > }
> > >=20
> > > The kvm_irqchip_in_kernel() block would fit better in xics_spapr_set_=
irq(),
> > > like it is already the case for XIVE.
> >=20
> > Hmm.. I don't really see why you say that.
> >=20
>=20
> I mean this:
>=20
> static void xics_spapr_set_irq(SpaprInterruptController *intc, int irq, i=
nt val)
> {
>     IcsSpapr *icss =3D ICS_SPAPR(intc);
>     ICSState *ics =3D &icss->parent;
>     uint32_t srcno =3D irq - ics->offset;
>=20
>     if (kvm_irqchip_in_kernel()) {
>         ics_kvm_set_irq(ics, srcno, val);
>     } else {
>         ics_set_irq(ics, srcno, val);
>     }
> }
>=20
> It is very similar to spapr_xive_set_irq() and looks nicer to me.

Eh.. I don't really agree.  Seems to me KVM is essentialy an
implementation detail, so belongs in the ICS proper rather than the
papr specific wrapper.

It's not really obvious where it belongs, because the KVM
implementation only works for the PAPR version of the thing, but the
way we call it doesn't explicitly depend on any PAPR specific
information.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4LwthZj+AV2mq5CX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2RvLkACgkQbDjKyiDZ
s5LSUA//Tp0AdnA9IRQsBolUszIAEN5Q699+5R9OJVK6+hUFF9ITYHagAhIRV10L
cgVtEjHFamMHvb8IjM//ZGhScp7KijTVPXKwTpjTJ9BHID0QH4hV7Mpb73XvtE9o
TK+LSI1GPxMb0R9LMuADuZTnnoFnpn4tB5Dn4LYy2+1OBv54VMwoD21yFVsbnD3d
5lZGqG+9gKT39IuMiy1Q3+a+ZY8285rzUwLYX8v8TDxzCHkPC8rkhYU+Lr3YzGdO
vtZmBMAZacG6iIYP4CANwZ5iFfI2oBWBLrgIc3a/eJu9eYuNKda0sceIsdBC1pO1
aRybkeJenecWfMq9ph2SiN1WAUExQKPZ+HCQ9qSWn3MELTcSxojkZo+XuYQui+7Q
unTfpz5lsYLz9INSpBrxS+vvyuZs5wQ2nauoigDokmGJjBPypKLKTlbiA8SsBKWR
gQT/vHb7EaRKRRPFNPGYqxvenXyljnnRgNZa38NW2AXB+QZmSgAnlvWRKq7HCKdB
fRHkGAQy11HKNECSOwqdqiDwaS77h64ducXKYLLuhd7xFchh+zVNI184aQsTg7uT
7qQVqV/ZrlpOe0wXe36zwgWuzERqQ62e8Stp7fIZGDt0MS+wUd1cRBONeOyTY0Hd
du8Ax33EvaG6KX35mM4T4izkqfc94YtLbEkwWawxv+lBB5Sp0hI=
=/58H
-----END PGP SIGNATURE-----

--4LwthZj+AV2mq5CX--

