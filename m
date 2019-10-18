Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF1CCA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:42:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EF8C20820
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF8C20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLOmX-00023Q-Mx
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 05:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iLOlj-0001Jw-Iu
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iLOlh-0002L6-NH
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:41:59 -0400
Received: from 20.mo1.mail-out.ovh.net ([188.165.45.168]:57547)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iLOlh-0002KE-Cj
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:41:57 -0400
Received: from player716.ha.ovh.net (unknown [10.109.160.106])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id E8185194CC5
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 11:41:54 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player716.ha.ovh.net (Postfix) with ESMTPSA id 41E39B111E63;
 Fri, 18 Oct 2019 09:41:48 +0000 (UTC)
Date: Fri, 18 Oct 2019 11:41:46 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 1/2] spapr: Introduce a interrupt presenter reset handler
Message-ID: <20191018114146.3fe2f60d@bahia.lan>
In-Reply-To: <20191018024707.GB2000@umbus.fritz.box>
References: <20191017144241.12522-1-clg@kaod.org>
 <20191017144241.12522-2-clg@kaod.org>
 <20191018024707.GB2000@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zZ7miGw67LAU9P1TpW=q.Zs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 9863446137521674726
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrjeelgddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.45.168
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
Cc: qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/zZ7miGw67LAU9P1TpW=q.Zs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Oct 2019 13:47:07 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Oct 17, 2019 at 04:42:40PM +0200, C=C3=A9dric Le Goater wrote:
> > The interrupt presenters are not reseted today.
>=20
> I don't think that's accurate.  We register reset handlers for both
> ICP and TCTX already.  We might not be resetting in quite the right
> order, but this will need a clearer description of what's changing.
>=20
> Also, with this patch as is, I think we'll reset twice (once from the
> registered handler, once via the cpu).
>=20

That makes three at first boot since we also reset the CPU during
realize :) But yes, if we go that way, we should probably change
the pnv machine to do the same and stop registering reset handlers.

> > Extend the sPAPR IRQ
> > backend with a new cpu_intc_reset() handler which will be called by
> > the CPU reset handler.
> >=20
> > spapr_realize_vcpu() is modified to call the CPU reset only after the
> > the intc presenter has been created.
> >=20
> > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > ---
> >  include/hw/ppc/spapr_irq.h |  4 ++++
> >  include/hw/ppc/xics.h      |  1 +
> >  include/hw/ppc/xive.h      |  1 +
> >  hw/intc/spapr_xive.c       |  8 ++++++++
> >  hw/intc/xics.c             |  5 +++++
> >  hw/intc/xics_spapr.c       |  8 ++++++++
> >  hw/intc/xive.c             | 11 ++++++++---
> >  hw/ppc/spapr_cpu_core.c    |  8 ++++++--
> >  hw/ppc/spapr_irq.c         | 21 +++++++++++++++++++++
> >  9 files changed, 62 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> > index 5e150a667902..78327496c102 100644
> > --- a/include/hw/ppc/spapr_irq.h
> > +++ b/include/hw/ppc/spapr_irq.h
> > @@ -52,6 +52,8 @@ typedef struct SpaprInterruptControllerClass {
> >       */
> >      int (*cpu_intc_create)(SpaprInterruptController *intc,
> >                              PowerPCCPU *cpu, Error **errp);
> > +    int (*cpu_intc_reset)(SpaprInterruptController *intc, PowerPCCPU *=
cpu,
> > +                          Error **errp);
> >      int (*claim_irq)(SpaprInterruptController *intc, int irq, bool lsi,
> >                       Error **errp);
> >      void (*free_irq)(SpaprInterruptController *intc, int irq);
> > @@ -68,6 +70,8 @@ void spapr_irq_update_active_intc(SpaprMachineState *=
spapr);
> > =20
> >  int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
> >                                PowerPCCPU *cpu, Error **errp);
> > +int spapr_irq_cpu_intc_reset(SpaprMachineState *spapr,
> > +                             PowerPCCPU *cpu, Error **errp);
> >  void spapr_irq_print_info(SpaprMachineState *spapr, Monitor *mon);
> >  void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
> >                    void *fdt, uint32_t phandle);
> > diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> > index 1e6a9300eb2b..602173c12250 100644
> > --- a/include/hw/ppc/xics.h
> > +++ b/include/hw/ppc/xics.h
> > @@ -161,6 +161,7 @@ void icp_set_mfrr(ICPState *icp, uint8_t mfrr);
> >  uint32_t icp_accept(ICPState *ss);
> >  uint32_t icp_ipoll(ICPState *ss, uint32_t *mfrr);
> >  void icp_eoi(ICPState *icp, uint32_t xirr);
> > +void icp_reset(ICPState *icp);
> > =20
> >  void ics_write_xive(ICSState *ics, int nr, int server,
> >                      uint8_t priority, uint8_t saved_priority);
> > diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> > index fd3319bd3202..99381639f50c 100644
> > --- a/include/hw/ppc/xive.h
> > +++ b/include/hw/ppc/xive.h
> > @@ -415,6 +415,7 @@ uint64_t xive_tctx_tm_read(XiveTCTX *tctx, hwaddr o=
ffset, unsigned size);
> > =20
> >  void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
> >  Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp);
> > +void xive_tctx_reset(XiveTCTX *tctx);
> > =20
> >  static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt=
_idx)
> >  {
> > diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> > index ba32d2cc5b0f..0c3acf1a4192 100644
> > --- a/hw/intc/spapr_xive.c
> > +++ b/hw/intc/spapr_xive.c
> > @@ -553,6 +553,13 @@ static int spapr_xive_cpu_intc_create(SpaprInterru=
ptController *intc,
> >      return 0;
> >  }
> > =20
> > +static int spapr_xive_cpu_intc_reset(SpaprInterruptController *intc,
> > +                                     PowerPCCPU *cpu, Error **errp)
> > +{
> > +    xive_tctx_reset(spapr_cpu_state(cpu)->tctx);
> > +    return 0;
> > +}
> > +
> >  static void spapr_xive_set_irq(SpaprInterruptController *intc, int irq=
, int val)
> >  {
> >      SpaprXive *xive =3D SPAPR_XIVE(intc);
> > @@ -697,6 +704,7 @@ static void spapr_xive_class_init(ObjectClass *klas=
s, void *data)
> >      sicc->activate =3D spapr_xive_activate;
> >      sicc->deactivate =3D spapr_xive_deactivate;
> >      sicc->cpu_intc_create =3D spapr_xive_cpu_intc_create;
> > +    sicc->cpu_intc_reset =3D spapr_xive_cpu_intc_reset;
> >      sicc->claim_irq =3D spapr_xive_claim_irq;
> >      sicc->free_irq =3D spapr_xive_free_irq;
> >      sicc->set_irq =3D spapr_xive_set_irq;
> > diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> > index b5ac408f7b74..652771d6a5a5 100644
> > --- a/hw/intc/xics.c
> > +++ b/hw/intc/xics.c
> > @@ -295,6 +295,11 @@ static void icp_reset_handler(void *dev)
> >      }
> >  }
> > =20
> > +void icp_reset(ICPState *icp)
> > +{
> > +    icp_reset_handler(icp);
> > +}
> > +
> >  static void icp_realize(DeviceState *dev, Error **errp)
> >  {
> >      ICPState *icp =3D ICP(dev);
> > diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> > index 4f64b9a9fc66..c0b2a576effe 100644
> > --- a/hw/intc/xics_spapr.c
> > +++ b/hw/intc/xics_spapr.c
> > @@ -346,6 +346,13 @@ static int xics_spapr_cpu_intc_create(SpaprInterru=
ptController *intc,
> >      return 0;
> >  }
> > =20
> > +static int xics_spapr_cpu_intc_reset(SpaprInterruptController *intc,
> > +                                     PowerPCCPU *cpu, Error **errp)
> > +{
> > +    icp_reset(spapr_cpu_state(cpu)->icp);
> > +    return 0;
> > +}
> > +
> >  static int xics_spapr_claim_irq(SpaprInterruptController *intc, int ir=
q,
> >                                  bool lsi, Error **errp)
> >  {
> > @@ -433,6 +440,7 @@ static void ics_spapr_class_init(ObjectClass *klass=
, void *data)
> >      sicc->activate =3D xics_spapr_activate;
> >      sicc->deactivate =3D xics_spapr_deactivate;
> >      sicc->cpu_intc_create =3D xics_spapr_cpu_intc_create;
> > +    sicc->cpu_intc_reset =3D xics_spapr_cpu_intc_reset;
> >      sicc->claim_irq =3D xics_spapr_claim_irq;
> >      sicc->free_irq =3D xics_spapr_free_irq;
> >      sicc->set_irq =3D xics_spapr_set_irq;
> > diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> > index d420c6571e14..0ae3f9b1efe4 100644
> > --- a/hw/intc/xive.c
> > +++ b/hw/intc/xive.c
> > @@ -547,7 +547,7 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Monit=
or *mon)
> >      }
> >  }
> > =20
> > -static void xive_tctx_reset(void *dev)
> > +static void xive_tctx_reset_handler(void *dev)
> >  {
> >      XiveTCTX *tctx =3D XIVE_TCTX(dev);
> > =20
> > @@ -568,6 +568,11 @@ static void xive_tctx_reset(void *dev)
> >          ipb_to_pipr(tctx->regs[TM_QW3_HV_PHYS + TM_IPB]);
> >  }
> > =20
> > +void xive_tctx_reset(XiveTCTX *tctx)
> > +{
> > +    xive_tctx_reset_handler(tctx);
> > +}
> > +
> >  static void xive_tctx_realize(DeviceState *dev, Error **errp)
> >  {
> >      XiveTCTX *tctx =3D XIVE_TCTX(dev);
> > @@ -608,12 +613,12 @@ static void xive_tctx_realize(DeviceState *dev, E=
rror **errp)
> >          }
> >      }
> > =20
> > -    qemu_register_reset(xive_tctx_reset, dev);
> > +    qemu_register_reset(xive_tctx_reset_handler, dev);
> >  }
> > =20
> >  static void xive_tctx_unrealize(DeviceState *dev, Error **errp)
> >  {
> > -    qemu_unregister_reset(xive_tctx_reset, dev);
> > +    qemu_unregister_reset(xive_tctx_reset_handler, dev);
> >  }
> > =20
> >  static int vmstate_xive_tctx_pre_save(void *opaque)
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 3e4302c7d596..416aa75e5fba 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -33,6 +33,7 @@ static void spapr_cpu_reset(void *opaque)
> >      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> >      SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> >      target_ulong lpcr;
> > +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> > =20
> >      cpu_reset(cs);
> > =20
> > @@ -77,9 +78,11 @@ static void spapr_cpu_reset(void *opaque)
> >      spapr_cpu->dtl_addr =3D 0;
> >      spapr_cpu->dtl_size =3D 0;
> > =20
> > -    spapr_caps_cpu_apply(SPAPR_MACHINE(qdev_get_machine()), cpu);
> > +    spapr_caps_cpu_apply(spapr, cpu);
> > =20
> >      kvm_check_mmu(cpu, &error_fatal);
> > +
> > +    spapr_irq_cpu_intc_reset(spapr, cpu, &error_fatal);
> >  }
> > =20
> >  void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, targ=
et_ulong r3)
> > @@ -235,12 +238,13 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, S=
paprMachineState *spapr,
> >      kvmppc_set_papr(cpu);
> > =20
> >      qemu_register_reset(spapr_cpu_reset, cpu);
> > -    spapr_cpu_reset(cpu);
> > =20
> >      if (spapr_irq_cpu_intc_create(spapr, cpu, &local_err) < 0) {
> >          goto error_unregister;
> >      }
> > =20
> > +    spapr_cpu_reset(cpu);
> > +
> >      if (!sc->pre_3_0_migration) {
> >          vmstate_register(NULL, cs->cpu_index, &vmstate_spapr_cpu_state,
> >                           cpu->machine_data);
> > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > index bb91c61fa000..5d2b64029cd5 100644
> > --- a/hw/ppc/spapr_irq.c
> > +++ b/hw/ppc/spapr_irq.c
> > @@ -220,6 +220,27 @@ int spapr_irq_cpu_intc_create(SpaprMachineState *s=
papr,
> >      return 0;
> >  }
> > =20
> > +int spapr_irq_cpu_intc_reset(SpaprMachineState *spapr,
> > +                             PowerPCCPU *cpu, Error **errp)
> > +{
> > +    SpaprInterruptController *intcs[] =3D ALL_INTCS(spapr);
> > +    int i;
> > +    int rc;
> > +
> > +    for (i =3D 0; i < ARRAY_SIZE(intcs); i++) {
> > +        SpaprInterruptController *intc =3D intcs[i];
> > +        if (intc) {
> > +            SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_GET_CLA=
SS(intc);
> > +            rc =3D sicc->cpu_intc_reset(intc, cpu, errp);
> > +            if (rc < 0) {
> > +                return rc;
> > +            }
> > +        }
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> >  static void spapr_set_irq(void *opaque, int irq, int level)
> >  {
> >      SpaprMachineState *spapr =3D SPAPR_MACHINE(opaque);
>=20


--Sig_/zZ7miGw67LAU9P1TpW=q.Zs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl2piNsACgkQcdTV5YIv
c9YfpBAAj9/OEFH/Cjw9VBmB1bDW7ujfrDWfOVUOmn4O2NlMSbW5I21QlGdA8DBa
z/Gf0ebmyRilIkIOVzHo6jd7EKtvtsJvh49BlVoHH00MT6O1NBZfDyNqsNhgDfAV
5IfCRlRmFnkq/dNZEbC4EMdIwTujDASIezd6W5yBoIsZSpxndQlzzhmX3nzq/AM6
bZfMFZhQ6PK1kzLIdCoSFJO7GjTiBllPpGnsKfI5/dqoVOCxnu6vhUGLxq12Ud1P
W+okFfpkmZRIiX5Ua1PDEQ2N2p2m0//YQFf3gj1qTexcudCtOlIoZVCO+8S+9XV3
PdGrmdSjukNN06JocOh2DZvpy9hsvV8bbvR0miaBCAlhBp00LQ5fXKmkeORRhK1f
U6yYGhjfPwuNtaACNBmMiEYxlSBgaEKaBU1UePhjL+i5M+42Vs6juynKpWdWFXEk
oboeXJ+IswnjPkV9LhTtLOgvhq55eyM37A0wL0h8BXFi1Hz1gr1Vp8dsq8d30WrF
iX006OM1sWr2i5yTP4R5BAYTd4Uai61DWrjcqmpuv8AXna8ck04isjz19ieSaarm
N/dF2vghyeOJ9urNMp3l8K9FsDb7ScbyWI6kVJwv/R0dLXE7GzuKQTFPz1oDH/nK
S0k5OyT2ffWgC7LIcyTivmE//yZQnkzxca0+0RAi0Pze2JdXDCk=
=eTaD
-----END PGP SIGNATURE-----

--Sig_/zZ7miGw67LAU9P1TpW=q.Zs--

