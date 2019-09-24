Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C95C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F5D620872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VHXwT1x+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5D620872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iClIF-00016P-L2
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 09:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iCkda-0001xa-Re
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iCkdY-0003cA-OC
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:13:50 -0400
Received: from ozlabs.org ([203.11.71.1]:51281)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iCkdW-0003aj-UQ; Tue, 24 Sep 2019 09:13:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46d1pt758Hz9sDB; Tue, 24 Sep 2019 23:13:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569330822;
 bh=MUy62fnC9Q3tdtEumVy6L/w62/D/WbSATekce/C4ToM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VHXwT1x+VwQhCF1Dg/TUh6uXw0C41mRXu704EGKmVCOJkstdoky6NS4NuHhhmuGeY
 TiVhXC0fxk8q8x4DePHSDDdt6LwvNV0KFFgwTgzKYwrUniNfLlD33nFSIbhL4pT9eP
 OlZjkjvtGq8wjQzr3x2hsomxd7H3ThXETola0+rU=
Date: Tue, 24 Sep 2019 21:41:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 4/4] xics: Merge TYPE_ICS_BASE and TYPE_ICS_SIMPLE classes
Message-ID: <20190924114124.GC17405@umbus>
References: <20190924045952.11412-1-david@gibson.dropbear.id.au>
 <20190924045952.11412-5-david@gibson.dropbear.id.au>
 <9636ac3a-f0db-7fb8-cb5d-a4a2b83479b5@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Content-Disposition: inline
In-Reply-To: <9636ac3a-f0db-7fb8-cb5d-a4a2b83479b5@kaod.org>
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
Cc: gkurz@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2019 at 07:31:44AM +0200, C=E9dric Le Goater wrote:
> On 24/09/2019 06:59, David Gibson wrote:
> > TYPE_ICS_SIMPLE is the only subtype of TYPE_ICS_BASE that's ever
> > instantiated, and the only one we're ever likely to want.  The
> > existence of different classes is just a hang over from when we
> > (misguidedly) had separate subtypes for the KVM and non-KVM version of
> > the device.
> >=20
> > So, collapse the two classes together into just TYPE_ICS.
>=20
>=20
> Well, I have been maintaining another subclass for the PHB3 MSI=20
> but it has never been merged and it will require some rework.

Well, if you did do this again, is there an actual need for it to be a
subclass of ICS_BASE, and not ICS_SIMPLE?  AFAICT the merged ICS class
should be fine for pnv as well.

> Anyhow the base ICS code is cleaner with that patch and it
> does not seem to break migration.
>=20
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
>=20
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> C.
>=20
>=20
> > ---
> >  hw/intc/xics.c        | 57 ++++++++++++++++---------------------------
> >  hw/ppc/pnv_psi.c      |  2 +-
> >  hw/ppc/spapr_irq.c    |  4 +--
> >  include/hw/ppc/xics.h | 17 ++-----------
> >  4 files changed, 26 insertions(+), 54 deletions(-)
> >=20
> > diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> > index 9ae51bbc76..388dbba870 100644
> > --- a/hw/intc/xics.c
> > +++ b/hw/intc/xics.c
> > @@ -555,7 +555,7 @@ static void ics_reset_irq(ICSIRQState *irq)
> > =20
> >  static void ics_reset(DeviceState *dev)
> >  {
> > -    ICSState *ics =3D ICS_BASE(dev);
> > +    ICSState *ics =3D ICS(dev);
> >      int i;
> >      uint8_t flags[ics->nr_irqs];
> > =20
> > @@ -573,7 +573,7 @@ static void ics_reset(DeviceState *dev)
> >      if (kvm_irqchip_in_kernel()) {
> >          Error *local_err =3D NULL;
> > =20
> > -        ics_set_kvm_state(ICS_BASE(dev), &local_err);
> > +        ics_set_kvm_state(ICS(dev), &local_err);
> >          if (local_err) {
> >              error_report_err(local_err);
> >          }
> > @@ -587,7 +587,7 @@ static void ics_reset_handler(void *dev)
> > =20
> >  static void ics_realize(DeviceState *dev, Error **errp)
> >  {
> > -    ICSState *ics =3D ICS_BASE(dev);
> > +    ICSState *ics =3D ICS(dev);
> >      Error *local_err =3D NULL;
> >      Object *obj;
> > =20
> > @@ -609,26 +609,14 @@ static void ics_realize(DeviceState *dev, Error *=
*errp)
> >      qemu_register_reset(ics_reset_handler, ics);
> >  }
> > =20
> > -static void ics_simple_class_init(ObjectClass *klass, void *data)
> > +static void ics_instance_init(Object *obj)
> >  {
> > -}
> > -
> > -static const TypeInfo ics_simple_info =3D {
> > -    .name =3D TYPE_ICS_SIMPLE,
> > -    .parent =3D TYPE_ICS_BASE,
> > -    .instance_size =3D sizeof(ICSState),
> > -    .class_init =3D ics_simple_class_init,
> > -    .class_size =3D sizeof(ICSStateClass),
> > -};
> > -
> > -static void ics_base_instance_init(Object *obj)
> > -{
> > -    ICSState *ics =3D ICS_BASE(obj);
> > +    ICSState *ics =3D ICS(obj);
> > =20
> >      ics->offset =3D XICS_IRQ_BASE;
> >  }
> > =20
> > -static int ics_base_pre_save(void *opaque)
> > +static int ics_pre_save(void *opaque)
> >  {
> >      ICSState *ics =3D opaque;
> > =20
> > @@ -639,7 +627,7 @@ static int ics_base_pre_save(void *opaque)
> >      return 0;
> >  }
> > =20
> > -static int ics_base_post_load(void *opaque, int version_id)
> > +static int ics_post_load(void *opaque, int version_id)
> >  {
> >      ICSState *ics =3D opaque;
> > =20
> > @@ -657,7 +645,7 @@ static int ics_base_post_load(void *opaque, int ver=
sion_id)
> >      return 0;
> >  }
> > =20
> > -static const VMStateDescription vmstate_ics_base_irq =3D {
> > +static const VMStateDescription vmstate_ics_irq =3D {
> >      .name =3D "ics/irq",
> >      .version_id =3D 2,
> >      .minimum_version_id =3D 1,
> > @@ -671,46 +659,44 @@ static const VMStateDescription vmstate_ics_base_=
irq =3D {
> >      },
> >  };
> > =20
> > -static const VMStateDescription vmstate_ics_base =3D {
> > +static const VMStateDescription vmstate_ics =3D {
> >      .name =3D "ics",
> >      .version_id =3D 1,
> >      .minimum_version_id =3D 1,
> > -    .pre_save =3D ics_base_pre_save,
> > -    .post_load =3D ics_base_post_load,
> > +    .pre_save =3D ics_pre_save,
> > +    .post_load =3D ics_post_load,
> >      .fields =3D (VMStateField[]) {
> >          /* Sanity check */
> >          VMSTATE_UINT32_EQUAL(nr_irqs, ICSState, NULL),
> > =20
> >          VMSTATE_STRUCT_VARRAY_POINTER_UINT32(irqs, ICSState, nr_irqs,
> > -                                             vmstate_ics_base_irq,
> > +                                             vmstate_ics_irq,
> >                                               ICSIRQState),
> >          VMSTATE_END_OF_LIST()
> >      },
> >  };
> > =20
> > -static Property ics_base_properties[] =3D {
> > +static Property ics_properties[] =3D {
> >      DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> > =20
> > -static void ics_base_class_init(ObjectClass *klass, void *data)
> > +static void ics_class_init(ObjectClass *klass, void *data)
> >  {
> >      DeviceClass *dc =3D DEVICE_CLASS(klass);
> > =20
> >      dc->realize =3D ics_realize;
> > -    dc->props =3D ics_base_properties;
> > +    dc->props =3D ics_properties;
> >      dc->reset =3D ics_reset;
> > -    dc->vmsd =3D &vmstate_ics_base;
> > +    dc->vmsd =3D &vmstate_ics;
> >  }
> > =20
> > -static const TypeInfo ics_base_info =3D {
> > -    .name =3D TYPE_ICS_BASE,
> > +static const TypeInfo ics_info =3D {
> > +    .name =3D TYPE_ICS,
> >      .parent =3D TYPE_DEVICE,
> > -    .abstract =3D true,
> >      .instance_size =3D sizeof(ICSState),
> > -    .instance_init =3D ics_base_instance_init,
> > -    .class_init =3D ics_base_class_init,
> > -    .class_size =3D sizeof(ICSStateClass),
> > +    .instance_init =3D ics_instance_init,
> > +    .class_init =3D ics_class_init,
> >  };
> > =20
> >  static const TypeInfo xics_fabric_info =3D {
> > @@ -749,8 +735,7 @@ void ics_set_irq_type(ICSState *ics, int srcno, boo=
l lsi)
> > =20
> >  static void xics_register_types(void)
> >  {
> > -    type_register_static(&ics_simple_info);
> > -    type_register_static(&ics_base_info);
> > +    type_register_static(&ics_info);
> >      type_register_static(&icp_info);
> >      type_register_static(&xics_fabric_info);
> >  }
> > diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> > index 8ea81e9d8e..a997f16bb4 100644
> > --- a/hw/ppc/pnv_psi.c
> > +++ b/hw/ppc/pnv_psi.c
> > @@ -469,7 +469,7 @@ static void pnv_psi_power8_instance_init(Object *ob=
j)
> >      Pnv8Psi *psi8 =3D PNV8_PSI(obj);
> > =20
> >      object_initialize_child(obj, "ics-psi",  &psi8->ics, sizeof(psi8->=
ics),
> > -                            TYPE_ICS_SIMPLE, &error_abort, NULL);
> > +                            TYPE_ICS, &error_abort, NULL);
> >  }
> > =20
> >  static const uint8_t irq_to_xivr[] =3D {
> > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > index ac189c5796..6c45d2a3c0 100644
> > --- a/hw/ppc/spapr_irq.c
> > +++ b/hw/ppc/spapr_irq.c
> > @@ -98,7 +98,7 @@ static void spapr_irq_init_xics(SpaprMachineState *sp=
apr, int nr_irqs,
> >      Object *obj;
> >      Error *local_err =3D NULL;
> > =20
> > -    obj =3D object_new(TYPE_ICS_SIMPLE);
> > +    obj =3D object_new(TYPE_ICS);
> >      object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
> >      object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
> >                                     &error_fatal);
> > @@ -109,7 +109,7 @@ static void spapr_irq_init_xics(SpaprMachineState *=
spapr, int nr_irqs,
> >          return;
> >      }
> > =20
> > -    spapr->ics =3D ICS_BASE(obj);
> > +    spapr->ics =3D ICS(obj);
> > =20
> >      xics_spapr_init(spapr);
> >  }
> > diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> > index 92628e7cab..d8cf206a69 100644
> > --- a/include/hw/ppc/xics.h
> > +++ b/include/hw/ppc/xics.h
> > @@ -89,21 +89,8 @@ struct PnvICPState {
> >      uint32_t links[3];
> >  };
> > =20
> > -#define TYPE_ICS_BASE "ics-base"
> > -#define ICS_BASE(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_BASE)
> > -
> > -/* Retain ics for sPAPR for migration from existing sPAPR guests */
> > -#define TYPE_ICS_SIMPLE "ics"
> > -#define ICS_SIMPLE(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SIMPLE)
> > -
> > -#define ICS_BASE_CLASS(klass) \
> > -     OBJECT_CLASS_CHECK(ICSStateClass, (klass), TYPE_ICS_BASE)
> > -#define ICS_BASE_GET_CLASS(obj) \
> > -     OBJECT_GET_CLASS(ICSStateClass, (obj), TYPE_ICS_BASE)
> > -
> > -struct ICSStateClass {
> > -    DeviceClass parent_class;
> > -};
> > +#define TYPE_ICS "ics"
> > +#define ICS(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS)
> > =20
> >  struct ICSState {
> >      /*< private >*/
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2KAOQACgkQbDjKyiDZ
s5IW0hAArsbBc7B3fmxXtPPY3KkBSaurZj18FNuXhJVJTQkXeF0DGlwgCfjYOtSn
Sy2yOHxx6oDfYY5thbUPxH0CYnKcdGIqJ5B7wvOhfXcFE6M6GACWaNpcufGh3wRp
1LsFfH/FG4Qy1qmSbD/YuUHI/lieCZ2o7MUTBtqH6WlHKCi7dK3Js0j7QkEdj/l8
qC3ARGoR/OVS+1Dj62yRZ3l5l6YpIG6RKVKgsJyBN8MC/HD3wdR06qVPLO7c2+6G
De4zd7vP/lHSgbVuZR8ro7XeDI2s3/mgn5iTAxTPoh3CYjDdIwelEqIUnFgr5+5Q
lwPXIt8O820FQ73o/RJ91aJdmx1/I6/ZhhYCJGo+vsrZTdAy7h75HAFzAINDy0dS
l+Ltd6tBLoB8G5D2/KkE7YlHtpODEElKCWuX+6V9Mt6HjXysXS768rKsEqc5kvqJ
4X67GL5Er80PdAG32F37C5xIxVxGgmlmP45aBm59KChh/kanITK/iw+qgKA0gy6R
VtcnVc2c3kGFymHiRyGezJylUL9JIKfsEnrm+fWguf8ktiqGts5Q31HIYBLv/JEQ
ugckHoWRw4ZWOs6cifQyUqXxEIHMwIZE5KIllbcBOu5xpTJoL9e4zYcpXBJtTp2N
gzC6rtWnZel2vp8XTnDJ9VwBYYrD97ebCmSCruyF3UBOEjfY7b8=
=cAfW
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--

