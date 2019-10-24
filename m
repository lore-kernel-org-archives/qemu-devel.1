Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4281CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F0B20856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F0B20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZ4K-0001S4-Oj
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iNZ3N-0000Rm-2b
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:05:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iNZ3L-0000BK-1Z
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:05:09 -0400
Received: from 2.mo179.mail-out.ovh.net ([178.33.250.45]:40139)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iNZ3K-000094-S3
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:05:06 -0400
Received: from player695.ha.ovh.net (unknown [10.109.143.109])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 76FBB1463FC
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 11:05:03 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player695.ha.ovh.net (Postfix) with ESMTPSA id C43D4B3CD334;
 Thu, 24 Oct 2019 09:04:55 +0000 (UTC)
Date: Thu, 24 Oct 2019 11:04:53 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 3/6] ppc: Reparent presenter objects to the interrupt
 controller object
Message-ID: <20191024110453.0b81b1b2@bahia.lan>
In-Reply-To: <20191024025841.GT6439@umbus.fritz.box>
References: <157184231371.3053790.17713393349394736594.stgit@bahia.lan>
 <157184233056.3053790.13073641279894392321.stgit@bahia.lan>
 <20191024025841.GT6439@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rRdzXmNG0qWv/juBAXMrvqU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 7583498824062048742
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrledugddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.250.45
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/rRdzXmNG0qWv/juBAXMrvqU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Oct 2019 13:58:41 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Oct 23, 2019 at 04:52:10PM +0200, Greg Kurz wrote:
> > Each VCPU is associated to a presenter object within the interrupt
> > controller, ie. TCTX for XIVE and ICP for XICS, but our current
> > models put these objects below the VCPU, and we rely on CPU_FOREACH()
> > to do anything that involves presenters.
> >=20
> > This recently bit us with the CAM line matching logic in XIVE because
> > CPU_FOREACH() can race with CPU hotplug and we ended up considering a
> > VCPU that wasn't associated to a TCTX object yet. Other users of
> > CPU_FOREACH() are 'info pic' for both XICS and XIVE. It is again very
> > easy to crash QEMU with concurrent VCPU hotplug/unplug and 'info pic'.
> >=20
> > Reparent the presenter objects to the corresponding interrupt controller
> > object, ie. XIVE router or ICS, to make it clear they are not some extra
> > data hanging from the CPU but internal XIVE or XICS entities. The CPU
> > object now needs to explicitely take a reference on the presenter to
> > ensure its pointer remains valid until unrealize time.
> >=20
> > This will allow to get rid of CPU_FOREACH() and ease further improvemen=
ts
> > to the XIVE model.
> >=20
> > This change doesn't impact section ids and is thus transparent to
> > migration.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
>=20
> Urgh.  I see why we want something like this, but reparenting the
> presenters to the source modules (particularly for XICS) makes me
> uncomfortable.
>=20
> AFAICT the association here is *purely* about managing lifetimes, not
> because those ICPs inherently have something to do with those ICSes.
> Same with XIVE, although since they'll be on the same chip there's a
> bit more logic to it.
>=20

I did it this way for XIVE because they are indeed on the same chip,
but I agree it is questionable for XICS.

> For spapr we kinda-sorta treat the (single) ICS or XiveRouter object
> as the "master" of the interrupt controller.  But that's not really

Agreed for XICS. On the other side, the XIVE controller chip really has
a routing sub-engine (IVRE) and a presenter sub-engine (IVPE), and the
TCTXs do reside in an SRAM within the IVPE. The XiveRouter type might
be better named XiveController, and each instance to expose a XiveRouter
and a XivePresenter interface. We have one per chip for PNV and only a
single one for sPAPR.

> accurate to the hardware, so I don't really want to push that way of
> looking at it any further than it already is.
>=20
> If we could make the presenters children of the machine (spapr) or
> chip (pnv) that might make more sense?
>=20

It probably makes sense for XICS, not sure this makes things clearer
for XIVE.

> I'm also not totally convinced that having the presenter as a child of
> the cpu is inherently bad.  Yes we have bugs now, but maybe the right
> fix *is* actually to do the NULL check on every CPU_FOREACH().
>=20
> For comparison, the lapic on x86 machines is a child of the cpu, and I
> believe they do have NULL checks on cpu->apic_state in various places
> they use CPU_FOREACH().
>=20

I didn't want to go that way because I was finding CPU_FOREACH() to
be fragile since all users are broken, but I can revisit that. Maybe
worth consolidating the logic in a PRESENTER_FOREACH() macro in order
to avoid future breakage with CPU_FOREACH() ?

> > ---
> >  hw/intc/spapr_xive.c  |    6 +++++-
> >  hw/intc/xics.c        |    7 +++++--
> >  hw/intc/xics_spapr.c  |    8 ++++++--
> >  hw/intc/xive.c        |    4 +++-
> >  hw/ppc/pnv.c          |   17 +++++++++++++----
> >  include/hw/ppc/xics.h |    2 +-
> >  6 files changed, 33 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> > index b09cc48bcb61..d74ee71e76b4 100644
> > --- a/hw/intc/spapr_xive.c
> > +++ b/hw/intc/spapr_xive.c
> > @@ -526,6 +526,7 @@ static int spapr_xive_cpu_intc_create(SpaprInterrup=
tController *intc,
> >          return -1;
> >      }
> > =20
> > +    object_ref(obj);
> >      spapr_cpu->tctx =3D XIVE_TCTX(obj);
> >      return 0;
> >  }
> > @@ -558,7 +559,10 @@ static void spapr_xive_cpu_intc_reset(SpaprInterru=
ptController *intc,
> >  static void spapr_xive_cpu_intc_destroy(SpaprInterruptController *intc,
> >                                          PowerPCCPU *cpu)
> >  {
> > -    xive_tctx_destroy(spapr_cpu_state(cpu)->tctx);
> > +    XiveTCTX *tctx =3D spapr_cpu_state(cpu)->tctx;
> > +
> > +    object_unref(OBJECT(tctx));
> > +    xive_tctx_destroy(tctx);
> >  }
> > =20
> >  static void spapr_xive_set_irq(SpaprInterruptController *intc, int irq=
, int val)
> > diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> > index 5f746079be46..d5e4db668a4b 100644
> > --- a/hw/intc/xics.c
> > +++ b/hw/intc/xics.c
> > @@ -380,13 +380,16 @@ static const TypeInfo icp_info =3D {
> >      .class_size =3D sizeof(ICPStateClass),
> >  };
> > =20
> > -Object *icp_create(Object *cpu, const char *type, XICSFabric *xi, Erro=
r **errp)
> > +Object *icp_create(Object *cpu, const char *type, ICSState *ics, XICSF=
abric *xi,
> > +                   Error **errp)
> >  {
> >      Error *local_err =3D NULL;
> > +    g_autofree char *name =3D NULL;
> >      Object *obj;
> > =20
> >      obj =3D object_new(type);
> > -    object_property_add_child(cpu, type, obj, &error_abort);
> > +    name =3D g_strdup_printf("%s[%d]", type, CPU(cpu)->cpu_index);
> > +    object_property_add_child(OBJECT(ics), name, obj, &error_abort);
> >      object_unref(obj);
> >      object_ref(OBJECT(xi));
> >      object_property_add_const_link(obj, ICP_PROP_XICS, OBJECT(xi),
> > diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> > index 5977d1bdb73f..080ed73aad64 100644
> > --- a/hw/intc/xics_spapr.c
> > +++ b/hw/intc/xics_spapr.c
> > @@ -337,11 +337,12 @@ static int xics_spapr_cpu_intc_create(SpaprInterr=
uptController *intc,
> >      Object *obj;
> >      SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> > =20
> > -    obj =3D icp_create(OBJECT(cpu), TYPE_ICP, ics->xics, errp);
> > +    obj =3D icp_create(OBJECT(cpu), TYPE_ICP, ics, ics->xics, errp);
> >      if (!obj) {
> >          return -1;
> >      }
> > =20
> > +    object_ref(obj);
> >      spapr_cpu->icp =3D ICP(obj);
> >      return 0;
> >  }
> > @@ -355,7 +356,10 @@ static void xics_spapr_cpu_intc_reset(SpaprInterru=
ptController *intc,
> >  static void xics_spapr_cpu_intc_destroy(SpaprInterruptController *intc,
> >                                          PowerPCCPU *cpu)
> >  {
> > -    icp_destroy(spapr_cpu_state(cpu)->icp);
> > +    ICPState *icp =3D spapr_cpu_state(cpu)->icp;
> > +
> > +    object_unref(OBJECT(icp));
> > +    icp_destroy(icp);
> >  }
> > =20
> >  static int xics_spapr_claim_irq(SpaprInterruptController *intc, int ir=
q,
> > diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> > index 952a461d5329..8d2da4a11163 100644
> > --- a/hw/intc/xive.c
> > +++ b/hw/intc/xive.c
> > @@ -677,10 +677,12 @@ static const TypeInfo xive_tctx_info =3D {
> >  Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp)
> >  {
> >      Error *local_err =3D NULL;
> > +    g_autofree char *name =3D NULL;
> >      Object *obj;
> > =20
> >      obj =3D object_new(TYPE_XIVE_TCTX);
> > -    object_property_add_child(cpu, TYPE_XIVE_TCTX, obj, &error_abort);
> > +    name =3D g_strdup_printf(TYPE_XIVE_TCTX "[%d]", CPU(cpu)->cpu_inde=
x);
> > +    object_property_add_child(OBJECT(xrtr), name, obj, &error_abort);
> >      object_unref(obj);
> >      object_ref(cpu);
> >      object_property_add_const_link(obj, "cpu", cpu, &error_abort);
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index bd17c3536dd5..cbeabf98bff6 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -767,14 +767,16 @@ static void pnv_chip_power8_intc_create(PnvChip *=
chip, PowerPCCPU *cpu,
> >      Error *local_err =3D NULL;
> >      Object *obj;
> >      PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
> > +    Pnv8Chip *chip8 =3D PNV8_CHIP(chip);
> > =20
> > -    obj =3D icp_create(OBJECT(cpu), TYPE_PNV_ICP, XICS_FABRIC(qdev_get=
_machine()),
> > -                     &local_err);
> > +    obj =3D icp_create(OBJECT(cpu), TYPE_PNV_ICP, &chip8->psi.ics,
> > +                     XICS_FABRIC(qdev_get_machine()), &local_err);
>=20
> Here, the association of the ICPs with the PSI ICS is particularly arbitr=
ary.
>=20
> >      if (local_err) {
> >          error_propagate(errp, local_err);
> >          return;
> >      }
> > =20
> > +    object_ref(obj);
> >      pnv_cpu->intc =3D obj;
> >  }
> > =20
> > @@ -788,7 +790,10 @@ static void pnv_chip_power8_intc_reset(PnvChip *ch=
ip, PowerPCCPU *cpu)
> > =20
> >  static void pnv_chip_power8_intc_destroy(PnvChip *chip, PowerPCCPU *cp=
u)
> >  {
> > -    icp_destroy(ICP(pnv_cpu_state(cpu)->intc));
> > +    Object *intc =3D pnv_cpu_state(cpu)->intc;
> > +
> > +    object_unref(intc);
> > +    icp_destroy(ICP(intc));
> >  }
> > =20
> >  /*
> > @@ -825,6 +830,7 @@ static void pnv_chip_power9_intc_create(PnvChip *ch=
ip, PowerPCCPU *cpu,
> >          return;
> >      }
> > =20
> > +    object_ref(obj);
> >      pnv_cpu->intc =3D obj;
> >  }
> > =20
> > @@ -837,7 +843,10 @@ static void pnv_chip_power9_intc_reset(PnvChip *ch=
ip, PowerPCCPU *cpu)
> > =20
> >  static void pnv_chip_power9_intc_destroy(PnvChip *chip, PowerPCCPU *cp=
u)
> >  {
> > -    xive_tctx_destroy(XIVE_TCTX(pnv_cpu_state(cpu)->intc));
> > +    Object *intc =3D pnv_cpu_state(cpu)->intc;
> > +
> > +    object_unref(intc);
> > +    xive_tctx_destroy(XIVE_TCTX(intc));
> >  }
> > =20
> >  /*
> > diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> > index 48a75aa4ab75..f4827e748fd8 100644
> > --- a/include/hw/ppc/xics.h
> > +++ b/include/hw/ppc/xics.h
> > @@ -179,7 +179,7 @@ void ics_pic_print_info(ICSState *ics, Monitor *mon=
);
> >  void ics_resend(ICSState *ics);
> >  void icp_resend(ICPState *ss);
> > =20
> > -Object *icp_create(Object *cpu, const char *type, XICSFabric *xi,
> > +Object *icp_create(Object *cpu, const char *type, ICSState *ics, XICSF=
abric *xi,
> >                     Error **errp);
> >  void icp_destroy(ICPState *icp);
> > =20
> >=20
>=20


--Sig_/rRdzXmNG0qWv/juBAXMrvqU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl2xaTUACgkQcdTV5YIv
c9akcw/8CbtRCOYj+xaeFrnoV1Ecb8MmVzrMH/8wxdpiRgp6egGeQlq4S4TcoMWY
/oPCDdoETYcOKsL7TbqTkPez+otNKUz83du3EXU068TNesMcVUMKxMDusPwfUEvI
q+HGD8ioMAqPeH1oZlT3Vcju8vPM2VjQpqj9lBVwhPRh63ATQCUMQ/kfOaCGMMtO
BJWBT/2bq89FZ0ESlCNQzta09PvqigR1XgxTwjoo6d4yiDwpPNZhPiV43fV4J6r5
o0bKOTFp9BAoX23c/zsSsC1V1B71UTPiBo1wHkuz68zOjvW6GCQBl8q4YEcUN1e3
OKOphe4cyu2z3ZrRGK29Hx8AV0z6as9O5VaAPPjS0xKmZ00v6bKPczkjf2e+UnZp
ep4UEu/lxR9zUPMVCU3VYXWk9NiBLgpqZ154yHRktgV6Mj7vCkBl8FaIjdDBTI94
1no4n9E8HZ44wZ1YzinMO0bNBj6l8nbxGrdBRI2tZXvz4hwQdO3ahCQSjOsbf1q9
OYDm6kwTsEQC0MvWG7LDdsXJjTOrAfvYVWsgoRpZm99S0pJzs/y+BxfLz/egyeVJ
pkR6KC5HQCrRFLnDRuAaEyEM87C+7JRsYNiyQUW8NdEZkfFcPi+cwTd5zKYLwmbF
9o8XFPmEU4SsGrRl33K/GO8G7uKiOiadH5CMTEV8bY3N4wHJUkY=
=nrjq
-----END PGP SIGNATURE-----

--Sig_/rRdzXmNG0qWv/juBAXMrvqU--

