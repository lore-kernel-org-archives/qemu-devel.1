Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7459C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 06:11:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54FE1215EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 06:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="podO1+4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FE1215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFXre-0000xl-Fs
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 02:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFXqP-0008Ew-Gg
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 02:10:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFXqN-00050T-HZ
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 02:10:37 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60087 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFXqM-0004yx-TP; Wed, 02 Oct 2019 02:10:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46jm2v08YXz9sPc; Wed,  2 Oct 2019 16:10:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569996631;
 bh=8Pp3Jojt8P5Afz0xcHst44GQA2ooJkuqyAa8go7gilw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=podO1+4LivTL1AnS7Kr9b6kTbHXMYd3Qp9gAIHIh7VUfxrA2G8JeZK2hUqCCbwKUy
 QcyCmMxV0x5y49FlMU7ak4AZOHyBWcno86ptRB956RoweltO6ejPkyD5da7cNHf2zX
 x7jsyISe+ipC7m0qi+Qu2tbcz5RuB6I+JrJCar/g=
Date: Wed, 2 Oct 2019 16:10:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3 22/34] spapr, xics, xive: Move cpu_intc_create from
 SpaprIrq to SpaprInterruptController
Message-ID: <20191002061025.GW11105@umbus.fritz.box>
References: <20191002025208.3487-1-david@gibson.dropbear.id.au>
 <20191002025208.3487-23-david@gibson.dropbear.id.au>
 <360fd118-81c2-7ba1-2faf-d735d887d955@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Cf1qy2gtPj5yoBMh"
Content-Disposition: inline
In-Reply-To: <360fd118-81c2-7ba1-2faf-d735d887d955@kaod.org>
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
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Cf1qy2gtPj5yoBMh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2019 at 08:06:59AM +0200, C=E9dric Le Goater wrote:
> On 02/10/2019 04:51, David Gibson wrote:
> > This method essentially represents code which belongs to the interrupt
> > controller, but needs to be called on all possible intcs, rather than
> > just the currently active one.  The "dual" version therefore calls
> > into the xics and xive versions confusingly.
> >=20
> > Handle this more directly, by making it instead a method on the intc
> > backend, and always calling it on every backend that exists.
> >=20
> > While we're there, streamline the error reporting a bit.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/intc/spapr_xive.c       | 25 ++++++++++++
> >  hw/intc/xics_spapr.c       | 18 +++++++++
> >  hw/ppc/spapr_cpu_core.c    |  3 +-
> >  hw/ppc/spapr_irq.c         | 81 +++++++++++---------------------------
> >  include/hw/ppc/spapr_irq.h | 13 +++++-
> >  5 files changed, 79 insertions(+), 61 deletions(-)
> >=20
> > diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> > index b67e9c3245..9338daba3d 100644
> > --- a/hw/intc/spapr_xive.c
> > +++ b/hw/intc/spapr_xive.c
> > @@ -495,10 +495,33 @@ static Property spapr_xive_properties[] =3D {
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> > =20
> > +static int spapr_xive_cpu_intc_create(SpaprInterruptController *intc,
> > +                                      PowerPCCPU *cpu, Error **errp)
> > +{
> > +    SpaprXive *xive =3D SPAPR_XIVE(intc);
> > +    Object *obj;
> > +    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> > +
> > +    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(xive), errp);
> > +    if (!obj) {
> > +        return -1;
> > +    }
> > +
> > +    spapr_cpu->tctx =3D XIVE_TCTX(obj);
> > +
> > +    /*
> > +     * (TCG) Early setting the OS CAM line for hotplugged CPUs as they
> > +     * don't beneficiate from the reset of the XIVE IRQ backend
> > +     */
> > +    spapr_xive_set_tctx_os_cam(spapr_cpu->tctx);
> > +    return 0;
> > +}
> > +
> >  static void spapr_xive_class_init(ObjectClass *klass, void *data)
> >  {
> >      DeviceClass *dc =3D DEVICE_CLASS(klass);
> >      XiveRouterClass *xrc =3D XIVE_ROUTER_CLASS(klass);
> > +    SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_CLASS(klass);
> > =20
> >      dc->desc    =3D "sPAPR XIVE Interrupt Controller";
> >      dc->props   =3D spapr_xive_properties;
> > @@ -511,6 +534,8 @@ static void spapr_xive_class_init(ObjectClass *klas=
s, void *data)
> >      xrc->get_nvt =3D spapr_xive_get_nvt;
> >      xrc->write_nvt =3D spapr_xive_write_nvt;
> >      xrc->get_tctx =3D spapr_xive_get_tctx;
> > +
> > +    sicc->cpu_intc_create =3D spapr_xive_cpu_intc_create;
> >  }
> > =20
> >  static const TypeInfo spapr_xive_info =3D {
> > diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> > index 4874e6be55..946311b858 100644
> > --- a/hw/intc/xics_spapr.c
> > +++ b/hw/intc/xics_spapr.c
> > @@ -330,13 +330,31 @@ void spapr_dt_xics(SpaprMachineState *spapr, uint=
32_t nr_servers, void *fdt,
> >      _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
> >  }
> > =20
> > +static int xics_spapr_cpu_intc_create(SpaprInterruptController *intc,
> > +                                       PowerPCCPU *cpu, Error **errp)
> > +{
> > +    ICSState *ics =3D ICS_SPAPR(intc);
> > +    Object *obj;
> > +    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> > +
> > +    obj =3D icp_create(OBJECT(cpu), TYPE_ICP, ics->xics, errp);
> > +    if (!obj) {
> > +        return -1;
> > +    }
> > +
> > +    spapr_cpu->icp =3D ICP(obj);
> > +    return 0;
> > +}
> > +
> >  static void ics_spapr_class_init(ObjectClass *klass, void *data)
> >  {
> >      DeviceClass *dc =3D DEVICE_CLASS(klass);
> >      ICSStateClass *isc =3D ICS_CLASS(klass);
> > +    SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_CLASS(klass);
> > =20
> >      device_class_set_parent_realize(dc, ics_spapr_realize,
> >                                      &isc->parent_realize);
> > +    sicc->cpu_intc_create =3D xics_spapr_cpu_intc_create;
> >  }
> > =20
> >  static const TypeInfo ics_spapr_info =3D {
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 1d93de8161..3e4302c7d5 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -237,8 +237,7 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, Spa=
prMachineState *spapr,
> >      qemu_register_reset(spapr_cpu_reset, cpu);
> >      spapr_cpu_reset(cpu);
> > =20
> > -    spapr->irq->cpu_intc_create(spapr, cpu, &local_err);
> > -    if (local_err) {
> > +    if (spapr_irq_cpu_intc_create(spapr, cpu, &local_err) < 0) {
> >          goto error_unregister;
> >      }
> > =20
> > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > index 8791dec1ba..9cb2fc71ca 100644
> > --- a/hw/ppc/spapr_irq.c
> > +++ b/hw/ppc/spapr_irq.c
> > @@ -138,23 +138,6 @@ static void spapr_irq_print_info_xics(SpaprMachine=
State *spapr, Monitor *mon)
> >      ics_pic_print_info(spapr->ics, mon);
> >  }
> > =20
> > -static void spapr_irq_cpu_intc_create_xics(SpaprMachineState *spapr,
> > -                                           PowerPCCPU *cpu, Error **er=
rp)
> > -{
> > -    Error *local_err =3D NULL;
> > -    Object *obj;
> > -    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> > -
> > -    obj =3D icp_create(OBJECT(cpu), TYPE_ICP, XICS_FABRIC(spapr),
> > -                     &local_err);
> > -    if (local_err) {
> > -        error_propagate(errp, local_err);
> > -        return;
> > -    }
> > -
> > -    spapr_cpu->icp =3D ICP(obj);
> > -}
> > -
> >  static int spapr_irq_post_load_xics(SpaprMachineState *spapr, int vers=
ion_id)
> >  {
> >      if (!kvm_irqchip_in_kernel()) {
> > @@ -203,7 +186,6 @@ SpaprIrq spapr_irq_xics =3D {
> >      .free        =3D spapr_irq_free_xics,
> >      .print_info  =3D spapr_irq_print_info_xics,
> >      .dt_populate =3D spapr_dt_xics,
> > -    .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
> >      .post_load   =3D spapr_irq_post_load_xics,
> >      .reset       =3D spapr_irq_reset_xics,
> >      .set_irq     =3D spapr_irq_set_irq_xics,
> > @@ -239,28 +221,6 @@ static void spapr_irq_print_info_xive(SpaprMachine=
State *spapr,
> >      spapr_xive_pic_print_info(spapr->xive, mon);
> >  }
> > =20
> > -static void spapr_irq_cpu_intc_create_xive(SpaprMachineState *spapr,
> > -                                           PowerPCCPU *cpu, Error **er=
rp)
> > -{
> > -    Error *local_err =3D NULL;
> > -    Object *obj;
> > -    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> > -
> > -    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(spapr->xive), &l=
ocal_err);
> > -    if (local_err) {
> > -        error_propagate(errp, local_err);
> > -        return;
> > -    }
> > -
> > -    spapr_cpu->tctx =3D XIVE_TCTX(obj);
> > -
> > -    /*
> > -     * (TCG) Early setting the OS CAM line for hotplugged CPUs as they
> > -     * don't beneficiate from the reset of the XIVE IRQ backend
> > -     */
> > -    spapr_xive_set_tctx_os_cam(spapr_cpu->tctx);
> > -}
> > -
> >  static int spapr_irq_post_load_xive(SpaprMachineState *spapr, int vers=
ion_id)
> >  {
> >      return spapr_xive_post_load(spapr->xive, version_id);
> > @@ -316,7 +276,6 @@ SpaprIrq spapr_irq_xive =3D {
> >      .free        =3D spapr_irq_free_xive,
> >      .print_info  =3D spapr_irq_print_info_xive,
> >      .dt_populate =3D spapr_dt_xive,
> > -    .cpu_intc_create =3D spapr_irq_cpu_intc_create_xive,
> >      .post_load   =3D spapr_irq_post_load_xive,
> >      .reset       =3D spapr_irq_reset_xive,
> >      .set_irq     =3D spapr_irq_set_irq_xive,
> > @@ -381,20 +340,6 @@ static void spapr_irq_dt_populate_dual(SpaprMachin=
eState *spapr,
> >      spapr_irq_current(spapr)->dt_populate(spapr, nr_servers, fdt, phan=
dle);
> >  }
> > =20
> > -static void spapr_irq_cpu_intc_create_dual(SpaprMachineState *spapr,
> > -                                           PowerPCCPU *cpu, Error **er=
rp)
> > -{
> > -    Error *local_err =3D NULL;
> > -
> > -    spapr_irq_xive.cpu_intc_create(spapr, cpu, &local_err);
> > -    if (local_err) {
> > -        error_propagate(errp, local_err);
> > -        return;
> > -    }
> > -
> > -    spapr_irq_xics.cpu_intc_create(spapr, cpu, errp);
> > -}
> > -
> >  static int spapr_irq_post_load_dual(SpaprMachineState *spapr, int vers=
ion_id)
> >  {
> >      /*
> > @@ -460,7 +405,6 @@ SpaprIrq spapr_irq_dual =3D {
> >      .free        =3D spapr_irq_free_dual,
> >      .print_info  =3D spapr_irq_print_info_dual,
> >      .dt_populate =3D spapr_irq_dt_populate_dual,
> > -    .cpu_intc_create =3D spapr_irq_cpu_intc_create_dual,
> >      .post_load   =3D spapr_irq_post_load_dual,
> >      .reset       =3D spapr_irq_reset_dual,
> >      .set_irq     =3D spapr_irq_set_irq_dual,
> > @@ -527,6 +471,30 @@ static int spapr_irq_check(SpaprMachineState *spap=
r, Error **errp)
> >  /*
> >   * sPAPR IRQ frontend routines for devices
> >   */
> > +#define ALL_INTCS(spapr_) \
> > +    { SPAPR_INTC((spapr_)->ics), SPAPR_INTC((spapr_)->xive), }
>=20
> I would have expected this array to be under the machine.
>=20
> > +int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
> > +                              PowerPCCPU *cpu, Error **errp)
> > +{
> > +    SpaprInterruptController *intcs[] =3D ALL_INTCS(spapr);
> > +    int i;
> > +    int rc;
> > +
> > +    for (i =3D 0; i < ARRAY_SIZE(intcs); i++) {
>=20
> but it would have been difficult to use ARRAY_SIZE. OK then.

Right.  It's kind of a compromise, to keep it as separate (and
differently typed) pointers in the machine for now.

> > +        SpaprInterruptController *intc =3D intcs[i];
> > +        if (intc) {
>=20
> Is that test needed ?

Yes.  The array always has two elements even in xics only or xive only
modes, but in those cases one of the entries is NULL.

>=20
> > +            SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_GET_CLA=
SS(intc);
> > +            rc =3D sicc->cpu_intc_create(intc, cpu, errp);
> > +            if (rc < 0) {
> > +                return rc;
> > +            }
> > +        }
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> >  void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
> >  {
> >      MachineState *machine =3D MACHINE(spapr);
> > @@ -762,7 +730,6 @@ SpaprIrq spapr_irq_xics_legacy =3D {
> >      .free        =3D spapr_irq_free_xics,
> >      .print_info  =3D spapr_irq_print_info_xics,
> >      .dt_populate =3D spapr_dt_xics,
> > -    .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
> >      .post_load   =3D spapr_irq_post_load_xics,
> >      .reset       =3D spapr_irq_reset_xics,
> >      .set_irq     =3D spapr_irq_set_irq_xics,
> > diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> > index b9398e0be3..5e641e23c1 100644
> > --- a/include/hw/ppc/spapr_irq.h
> > +++ b/include/hw/ppc/spapr_irq.h
> > @@ -43,8 +43,19 @@ typedef struct SpaprInterruptController SpaprInterru=
ptController;
> > =20
> >  typedef struct SpaprInterruptControllerClass {
> >      InterfaceClass parent;
> > +
> > +    /*
> > +     * These methods will typically be called on all intcs, active and
> > +     * inactive
> > +     */
> > +    int (*cpu_intc_create)(SpaprInterruptController *intc,
> > +                            PowerPCCPU *cpu, Error **errp);
> >  } SpaprInterruptControllerClass;
> > =20
> > +int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
> > +                              PowerPCCPU *cpu, Error **errp);
> > +
> > +
> >  void spapr_irq_msi_init(SpaprMachineState *spapr, uint32_t nr_msis);
> >  int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool a=
lign,
> >                          Error **errp);
> > @@ -61,8 +72,6 @@ typedef struct SpaprIrq {
> >      void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
> >      void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
> >                          void *fdt, uint32_t phandle);
> > -    void (*cpu_intc_create)(SpaprMachineState *spapr, PowerPCCPU *cpu,
> > -                            Error **errp);
> >      int (*post_load)(SpaprMachineState *spapr, int version_id);
> >      void (*reset)(SpaprMachineState *spapr, Error **errp);
> >      void (*set_irq)(void *opaque, int srcno, int val);
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Cf1qy2gtPj5yoBMh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2UP04ACgkQbDjKyiDZ
s5IpVw/+O5+oCHps0Vcx0pIuUv5NXrC2/NR39gmLFNalRxpK3hNIfaBI1krzbyfH
GzCkU/vGnWmTgrN+tEpSTKcPI2CgL9JVwed3PTacD36FBGeorDbXtLRXRtz22ZFQ
8qVG0hwCJrvv+nNP+vXF3v8h2uRQszhYRlzY/dU9u7lsHXWQbKYWFFggq99Hp177
juQn/a+QwcJlpRGvtn5AOkDcr8EZ1b6lvhN/iAEH9YU/JwcsmlpIYtqZblQb5NO+
zAsPYd8dbMbuy5ERaQmAQ9+eNUWsqgmhfuTsLNY44yydY3H7Ht/s7aiFy2u+tJ30
TRXXO36KVJnsq1e67DJNuXyPZ1Av41EU9Zetl9FKp/U5hbqAodiq1i/6f8jsLlch
ejmYgYInTkOgBqw0imJRWKHokah+jmkUDnPLPZHqv9FUsXhUAm/QBFmblgRsvHF5
bc+60UuwpihBEYQrvpOmaLg4qlK8Spcfx5Y/plcG3JhgHoiCrUKam4KF7m6ajnep
ZoQqtj4x4/IULDQ0qiHYeN17yuh6aU2BKIsz1vHoG7i50YOpzbOreaEyJTXrUhkH
Sj9NiOR5+6AgETsFEKyxotMzHP9QPDC+0XSQeduAK4NCggxWCa9ROH7DOzDsc3+X
UpuXa9gPM3kTQMlYSHddkxS5IdUtmhIzm9qee7o+sYC0hRg7/00=
=nsI/
-----END PGP SIGNATURE-----

--Cf1qy2gtPj5yoBMh--

