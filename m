Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF060C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 01:31:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B9C7222BE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 01:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lfsfSXug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9C7222BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDIcv-0002wl-8T
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 21:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iDIan-0001C2-5j
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 21:29:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iDIal-0003vn-8X
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 21:29:13 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59433 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iDIak-0003t5-S4; Wed, 25 Sep 2019 21:29:11 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46dy4P5jX5z9sPc; Thu, 26 Sep 2019 11:28:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569461317;
 bh=9hYF6cs/lNNcIjtCVChppAjeuojTl4BR0xvGgUQ+YNM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lfsfSXugcAxeggRkbZvndwzJCWojnjlNAmGA0vI3nDRlQHUev0DMmwpmMTZBzDxU8
 SidleCnKFxJaO/81GK7sbsXRSXKUdNTpJri/rhEHpK+xjuJaRY4TZNFjGksapcAL7h
 fHSerDwgwiEjkONZnbZCuFUQ7bpmsjVkHn3w5bIA=
Date: Thu, 26 Sep 2019 11:03:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 09/20] spapr: Clarify and fix handling of nr_irqs
Message-ID: <20190926010324.GQ17405@umbus>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-10-david@gibson.dropbear.id.au>
 <55d983fb-3fd9-7442-cdd7-c2dcdb4a0ea9@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yFH6hwN92mUA4HK5"
Content-Disposition: inline
In-Reply-To: <55d983fb-3fd9-7442-cdd7-c2dcdb4a0ea9@kaod.org>
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


--yFH6hwN92mUA4HK5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2019 at 09:05:34AM +0200, C=E9dric Le Goater wrote:
> On 25/09/2019 08:45, David Gibson wrote:
> > Both the XICS and XIVE interrupt backends have a "nr-irqs" property, but
> > it means slightly different things.  For XICS (or, strictly, the ICS) it
> > indicates the number of "real" external IRQs.  Those start at XICS_IRQ_=
BASE
> > (0x1000) and don't include the special IPI vector.  For XIVE, however, =
it
> > includes the whole IRQ space, including XIVE's many IPI vectors.
> >=20
> > The spapr code currently doesn't handle this sensibly, with the nr_irqs
> > value in SpaprIrq having different meanings depending on the backend.
> > We fix this by renaming nr_irqs to nr_xirqs and making it always indica=
te
> > just the number of external irqs, adjusting the value we pass to XIVE
> > accordingly.  We also use move to using common constants in most of the
> > irq configurations, to make it clearer that the IRQ space looks the same
> > to the guest (and emulated devices), even if the backend is different.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> one comment below,
>=20
> > ---
> >  hw/ppc/spapr_irq.c         | 48 +++++++++++++++-----------------------
> >  include/hw/ppc/spapr_irq.h | 19 +++++++++------
> >  2 files changed, 31 insertions(+), 36 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > index 8c26fa2d1e..5190a33e08 100644
> > --- a/hw/ppc/spapr_irq.c
> > +++ b/hw/ppc/spapr_irq.c
> > @@ -92,7 +92,7 @@ static void spapr_irq_init_kvm(SpaprMachineState *spa=
pr,
> >   * XICS IRQ backend.
> >   */
> > =20
> > -static void spapr_irq_init_xics(SpaprMachineState *spapr, int nr_irqs,
> > +static void spapr_irq_init_xics(SpaprMachineState *spapr, int nr_xirqs,
> >                                  Error **errp)
> >  {
> >      Object *obj;
> > @@ -102,7 +102,7 @@ static void spapr_irq_init_xics(SpaprMachineState *=
spapr, int nr_irqs,
> >      object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
> >      object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
> >                                     &error_fatal);
> > -    object_property_set_int(obj, nr_irqs, "nr-irqs",  &error_fatal);
> > +    object_property_set_int(obj, nr_xirqs, "nr-irqs",  &error_fatal);
> >      object_property_set_bool(obj, true, "realized", &local_err);
> >      if (local_err) {
> >          error_propagate(errp, local_err);
> > @@ -234,13 +234,9 @@ static void spapr_irq_init_kvm_xics(SpaprMachineSt=
ate *spapr, Error **errp)
> >      }
> >  }
> > =20
> > -#define SPAPR_IRQ_XICS_NR_IRQS     0x1000
> > -#define SPAPR_IRQ_XICS_NR_MSIS     \
> > -    (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
> > -
> >  SpaprIrq spapr_irq_xics =3D {
> > -    .nr_irqs     =3D SPAPR_IRQ_XICS_NR_IRQS,
> > -    .nr_msis     =3D SPAPR_IRQ_XICS_NR_MSIS,
> > +    .nr_xirqs    =3D SPAPR_NR_XIRQS,
> > +    .nr_msis     =3D SPAPR_NR_MSIS,
> >      .ov5         =3D SPAPR_OV5_XIVE_LEGACY,
> > =20
> >      .init        =3D spapr_irq_init_xics,
> > @@ -260,7 +256,7 @@ SpaprIrq spapr_irq_xics =3D {
> >  /*
> >   * XIVE IRQ backend.
> >   */
> > -static void spapr_irq_init_xive(SpaprMachineState *spapr, int nr_irqs,
> > +static void spapr_irq_init_xive(SpaprMachineState *spapr, int nr_xirqs,
> >                                  Error **errp)
> >  {
> >      uint32_t nr_servers =3D spapr_max_server_number(spapr);
> > @@ -268,7 +264,7 @@ static void spapr_irq_init_xive(SpaprMachineState *=
spapr, int nr_irqs,
> >      int i;
> > =20
> >      dev =3D qdev_create(NULL, TYPE_SPAPR_XIVE);
> > -    qdev_prop_set_uint32(dev, "nr-irqs", nr_irqs);
> > +    qdev_prop_set_uint32(dev, "nr-irqs", nr_xirqs + SPAPR_XIRQ_BASE);
> >      /*
> >       * 8 XIVE END structures per CPU. One for each available priority
> >       */
> > @@ -308,7 +304,7 @@ static qemu_irq spapr_qirq_xive(SpaprMachineState *=
spapr, int irq)
> >  {
> >      SpaprXive *xive =3D spapr->xive;
> > =20
> > -    if (irq >=3D xive->nr_irqs) {
> > +    if ((irq < SPAPR_XIRQ_BASE) || (irq >=3D xive->nr_irqs)) {
>=20
> So IPIs cannot be pulsed ? I think that is OK in QEMU.

They can be pulsed, they just can't be retrieved via the spapr_qirq()
interface.  Since that interface basically exists for the spapr root
devices (VIO and PHBs) to find the qemu_irqs to wire themselves up to,
I think that's fine.

If we discover some reason we need to grab IPI qirqs by global number
then we can revisit this.

I'll add a comment to clarify this in the later patch where I unify
the qirq implementations.

> XIVE unifies all the interrupts at the controller level. Any one can trig=
ger=20
> an interrupt with a store on the associate ESB page.

Absolutely, and nothing's stopping them.
>=20
> >          return NULL;
> >      }
> > =20
> > @@ -409,12 +405,9 @@ static void spapr_irq_init_kvm_xive(SpaprMachineSt=
ate *spapr, Error **errp)
> >   * with XICS.
> >   */
> > =20
> > -#define SPAPR_IRQ_XIVE_NR_IRQS     0x2000
> > -#define SPAPR_IRQ_XIVE_NR_MSIS     (SPAPR_IRQ_XIVE_NR_IRQS - SPAPR_IRQ=
_MSI)
> > -
> >  SpaprIrq spapr_irq_xive =3D {
> > -    .nr_irqs     =3D SPAPR_IRQ_XIVE_NR_IRQS,
> > -    .nr_msis     =3D SPAPR_IRQ_XIVE_NR_MSIS,
> > +    .nr_xirqs    =3D SPAPR_NR_XIRQS,
> > +    .nr_msis     =3D SPAPR_NR_MSIS,
> >      .ov5         =3D SPAPR_OV5_XIVE_EXPLOIT,
> > =20
> >      .init        =3D spapr_irq_init_xive,
> > @@ -450,18 +443,18 @@ static SpaprIrq *spapr_irq_current(SpaprMachineSt=
ate *spapr)
> >          &spapr_irq_xive : &spapr_irq_xics;
> >  }
> > =20
> > -static void spapr_irq_init_dual(SpaprMachineState *spapr, int nr_irqs,
> > +static void spapr_irq_init_dual(SpaprMachineState *spapr, int nr_xirqs,
> >                                  Error **errp)
> >  {
> >      Error *local_err =3D NULL;
> > =20
> > -    spapr_irq_xics.init(spapr, spapr_irq_xics.nr_irqs, &local_err);
> > +    spapr_irq_xics.init(spapr, spapr_irq_xics.nr_xirqs, &local_err);
> >      if (local_err) {
> >          error_propagate(errp, local_err);
> >          return;
> >      }
> > =20
> > -    spapr_irq_xive.init(spapr, spapr_irq_xive.nr_irqs, &local_err);
> > +    spapr_irq_xive.init(spapr, spapr_irq_xive.nr_xirqs, &local_err);
> >      if (local_err) {
> >          error_propagate(errp, local_err);
> >          return;
> > @@ -586,12 +579,9 @@ static const char *spapr_irq_get_nodename_dual(Spa=
prMachineState *spapr)
> >  /*
> >   * Define values in sync with the XIVE and XICS backend
> >   */
> > -#define SPAPR_IRQ_DUAL_NR_IRQS     0x2000
> > -#define SPAPR_IRQ_DUAL_NR_MSIS     (SPAPR_IRQ_DUAL_NR_IRQS - SPAPR_IRQ=
_MSI)
> > -
> >  SpaprIrq spapr_irq_dual =3D {
> > -    .nr_irqs     =3D SPAPR_IRQ_DUAL_NR_IRQS,
> > -    .nr_msis     =3D SPAPR_IRQ_DUAL_NR_MSIS,
> > +    .nr_xirqs    =3D SPAPR_NR_XIRQS,
> > +    .nr_msis     =3D SPAPR_NR_MSIS,
> >      .ov5         =3D SPAPR_OV5_XIVE_BOTH,
> > =20
> >      .init        =3D spapr_irq_init_dual,
> > @@ -693,10 +683,10 @@ void spapr_irq_init(SpaprMachineState *spapr, Err=
or **errp)
> >          spapr_irq_msi_init(spapr, spapr->irq->nr_msis);
> >      }
> > =20
> > -    spapr->irq->init(spapr, spapr->irq->nr_irqs, errp);
> > +    spapr->irq->init(spapr, spapr->irq->nr_xirqs, errp);
> > =20
> >      spapr->qirqs =3D qemu_allocate_irqs(spapr->irq->set_irq, spapr,
> > -                                      spapr->irq->nr_irqs);
> > +                                      spapr->irq->nr_xirqs + SPAPR_XIR=
Q_BASE);
> >  }
> > =20
> >  int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error=
 **errp)
> > @@ -804,11 +794,11 @@ int spapr_irq_find(SpaprMachineState *spapr, int =
num, bool align, Error **errp)
> >      return first + ics->offset;
> >  }
> > =20
> > -#define SPAPR_IRQ_XICS_LEGACY_NR_IRQS     0x400
> > +#define SPAPR_IRQ_XICS_LEGACY_NR_XIRQS     0x400
> > =20
> >  SpaprIrq spapr_irq_xics_legacy =3D {
> > -    .nr_irqs     =3D SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
> > -    .nr_msis     =3D SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
> > +    .nr_xirqs    =3D SPAPR_IRQ_XICS_LEGACY_NR_XIRQS,
> > +    .nr_msis     =3D SPAPR_IRQ_XICS_LEGACY_NR_XIRQS,
> >      .ov5         =3D SPAPR_OV5_XIVE_LEGACY,
> > =20
> >      .init        =3D spapr_irq_init_xics,
> > diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> > index 5db305165c..a8f9a2ab11 100644
> > --- a/include/hw/ppc/spapr_irq.h
> > +++ b/include/hw/ppc/spapr_irq.h
> > @@ -16,13 +16,18 @@
> >   * IRQ range offsets per device type
> >   */
> >  #define SPAPR_IRQ_IPI        0x0
> > -#define SPAPR_IRQ_EPOW       0x1000  /* XICS_IRQ_BASE offset */
> > -#define SPAPR_IRQ_HOTPLUG    0x1001
> > -#define SPAPR_IRQ_VIO        0x1100  /* 256 VIO devices */
> > -#define SPAPR_IRQ_PCI_LSI    0x1200  /* 32+ PHBs devices */
> > =20
> > -#define SPAPR_IRQ_MSI        0x1300  /* Offset of the dynamic range co=
vered
> > -                                      * by the bitmap allocator */
> > +#define SPAPR_XIRQ_BASE      XICS_IRQ_BASE /* 0x1000 */
> > +#define SPAPR_IRQ_EPOW       (SPAPR_XIRQ_BASE + 0x0000)
> > +#define SPAPR_IRQ_HOTPLUG    (SPAPR_XIRQ_BASE + 0x0001)
> > +#define SPAPR_IRQ_VIO        (SPAPR_XIRQ_BASE + 0x0100)  /* 256 VIO de=
vices */
> > +#define SPAPR_IRQ_PCI_LSI    (SPAPR_XIRQ_BASE + 0x0200)  /* 32+ PHBs d=
evices */
> > +
> > +/* Offset of the dynamic range covered by the bitmap allocator */
> > +#define SPAPR_IRQ_MSI        (SPAPR_XIRQ_BASE + 0x0300)
> > +
> > +#define SPAPR_NR_XIRQS       0x1000
> > +#define SPAPR_NR_MSIS        (SPAPR_XIRQ_BASE + SPAPR_NR_XIRQS - SPAPR=
_IRQ_MSI)
> > =20
> >  typedef struct SpaprMachineState SpaprMachineState;
> > =20
> > @@ -32,7 +37,7 @@ int spapr_irq_msi_alloc(SpaprMachineState *spapr, uin=
t32_t num, bool align,
> >  void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t nu=
m);
> > =20
> >  typedef struct SpaprIrq {
> > -    uint32_t    nr_irqs;
> > +    uint32_t    nr_xirqs;
> >      uint32_t    nr_msis;
> >      uint8_t     ov5;
> > =20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yFH6hwN92mUA4HK5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2MDlwACgkQbDjKyiDZ
s5ITQA//Vs3MO0BZVZcEgWQY2vznJGr3a2TJD8rEnHP8GBefSnWjbqnt6tNANyKz
YMfn8tcGSmFw5ZxeaL2GLzeljujkIQEtlw6fLpDi5pF0zll9BW81CuK8gCIseDxl
HTDYqTeBrNw+jk65pJOR72RBLe5Wb7602D5cA9AlehTjDis7CDCT3sbyYP/Ahlbv
qQUmS9TUPfsWIt3BCYqzHMV9XD2ZH/nPTxvwbAhnT1pi5GYtfDVC79pDv2o7+z1r
n6z3sGjwaQ+L+Y+UEwuny8gQW5/tuKomzBBkIooak+bcTHuuGyvK+Fk/2ZaycjTt
egB9AbzMP17lfnBu5hThMFcY7YtfOCJaj2T3NQVOTWcmf3OM8dsxZJX94fH6RCxb
nsdN2oUpR0TGaOwOuKtUxUPGWLY6ykV1kajF5UdSTQ507w4neqEeExtE7MwQ9vtb
IVLKnEWIyYq+sA78wbftIaKBOsbv/RiA3wMIoZAinryhya/e0IqEfI833hdKZ8IJ
wmkIezluZembTwavU5LCWLB/RqYTkFQLV58kP+hRnLuog3e9IBCUfXMSzw3imkAG
dWAdY4ttPOTB4tXQspJLOKXrKRMQCKiiBgxJTogIn703Fjvehun6Eb3ZSZAeRlrv
Vgbs6SksOn/KNCZipDdVxunFUdvLJTsFDaGD6Y0eM0G8Su9R2bg=
=8jR0
-----END PGP SIGNATURE-----

--yFH6hwN92mUA4HK5--

