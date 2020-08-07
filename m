Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C53C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 07:16:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8FCD2177B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 07:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FCD2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3wcV-0003o4-23
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 03:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1k3wbk-0003I2-45; Fri, 07 Aug 2020 03:16:04 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:40873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1k3wbh-0003V1-0q; Fri, 07 Aug 2020 03:16:03 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.13])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id E579654A24A6;
 Fri,  7 Aug 2020 09:15:56 +0200 (CEST)
Received: from kaod.org (37.59.142.104) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 7 Aug 2020
 09:15:55 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R0052ccaea67-06ff-477a-8ca6-f9579c8f4811,
 0FAFD30B9C3B2BFB516736AB00726897D031F517) smtp.auth=groug@kaod.org
Date: Fri, 7 Aug 2020 09:15:54 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 for-5.2 3/5] ppc/xive: Introduce dedicated
 kvm_irqchip_in_kernel() wrappers
Message-ID: <20200807091554.633833c5@bahia.lan>
In-Reply-To: <64551e66-e867-037e-bf2e-efa22ebdd324@kaod.org>
References: <159673295739.766512.2950380687630225803.stgit@bahia.lan>
 <159673298011.766512.17389427967409788911.stgit@bahia.lan>
 <64551e66-e867-037e-bf2e-efa22ebdd324@kaod.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.104]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: fa51e869-8644-4f67-8a69-5b50bfe75d7d
X-Ovh-Tracer-Id: 18423100178666199459
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrkedugdduvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeevlefhtddufffhieevhefhleegleelgfetffetkedugeehjeffgfehhfefueduffenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtoheptghlgheskhgrohgurdhorhhg
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 01:59:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Daniel Henrique Barboza <danielhb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Aug 2020 19:55:29 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 8/6/20 6:56 PM, Greg Kurz wrote:
> > Calls to the KVM XIVE device are guarded by kvm_irqchip_in_kernel(). Th=
is
> > ensures that QEMU won't try to use the device if KVM is disabled or if
> > an in-kernel irqchip isn't required.
> >=20
> > When using ic-mode=3Ddual with the pseries machine, we have two possible
> > interrupt controllers: XIVE and XICS. The kvm_irqchip_in_kernel() helper
> > will return true as soon as any of the KVM device is created. It might
> > lure QEMU to think that the other one is also around, while it is not.
> > This is exactly what happens with ic-mode=3Ddual at machine init when
> > claiming IRQ numbers, which must be done on all possible IRQ backends,
> > eg. RTAS event sources or the PHB0 LSI table : only the KVM XICS device
> > is active but we end up calling kvmppc_xive_source_reset_one() anyway,
> > which fails. This doesn't cause any trouble because of another bug :
> > kvmppc_xive_source_reset_one() lacks an error_setg() and callers don't
> > see the failure.
> >=20
> > Most of the other kvmppc_xive_* functions have similar xive->fd
> > checks to filter out the case when KVM XIVE isn't active. It
> > might look safer to have idempotent functions but it doesn't
> > really help to understand what's going on when debugging.
> >=20
> > Since we already have all the kvm_irqchip_in_kernel() in place,
> > also have the callers to check xive->fd as well before calling
> > KVM XIVE specific code. This is straight-forward for the spapr
> > specific XIVE code. Some more care is needed for the platform
> > agnostic XIVE code since it cannot access xive->fd directly.
> > Introduce new in_kernel() methods in some base XIVE classes
> > for this purpose and implement them only in spapr.
> >=20
> > In all cases, we still need to call kvm_irqchip_in_kernel() so that
> > compilers can optimize the kvmppc_xive_* calls away when CONFIG_KVM
> > isn't defined, thus avoiding the need for stubs.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > v2: Introduce in_kernel() abstract methods in the base XIVE classes
> > ---
> >  hw/intc/spapr_xive.c  |   53 ++++++++++++++++++++++++++++++++++++-----=
--------
> >  hw/intc/xive.c        |   28 +++++++++++++++++++-------
> >  include/hw/ppc/xive.h |    2 ++
> >  3 files changed, 62 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> > index 89c8cd96670b..cd001c580e89 100644
> > --- a/hw/intc/spapr_xive.c
> > +++ b/hw/intc/spapr_xive.c
> > @@ -148,12 +148,19 @@ static void spapr_xive_end_pic_print_info(SpaprXi=
ve *xive, XiveEND *end,
> >      xive_end_queue_pic_print_info(end, 6, mon);
> >  }
> > =20
> > +/*
> > + * kvm_irqchip_in_kernel() will cause the compiler to turn this
> > + * info a nop if CONFIG_KVM isn't defined.
> > + */
> > +#define spapr_xive_in_kernel(xive) \
> > +    (kvm_irqchip_in_kernel() && (xive)->fd !=3D -1)
> > +
>=20
> This looks ok. SpaprXive is the userspace frontend device of=20
> the KVM XIVE native device in the hypervisor.
>=20
> >  void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon)
> >  {
> >      XiveSource *xsrc =3D &xive->source;
> >      int i;
> > =20
> > -    if (kvm_irqchip_in_kernel()) {
> > +    if (spapr_xive_in_kernel(xive)) {
> >          Error *local_err =3D NULL;
> > =20
> >          kvmppc_xive_synchronize_state(xive, &local_err);
> > @@ -507,8 +514,10 @@ static const VMStateDescription vmstate_spapr_xive=
_eas =3D {
> > =20
> >  static int vmstate_spapr_xive_pre_save(void *opaque)
> >  {
> > -    if (kvm_irqchip_in_kernel()) {
> > -        return kvmppc_xive_pre_save(SPAPR_XIVE(opaque));
> > +    SpaprXive *xive =3D SPAPR_XIVE(opaque);
> > +
> > +    if (spapr_xive_in_kernel(xive)) {
> > +        return kvmppc_xive_pre_save(xive);
> >      }
> > =20
> >      return 0;
> > @@ -520,8 +529,10 @@ static int vmstate_spapr_xive_pre_save(void *opaqu=
e)
> >   */
> >  static int spapr_xive_post_load(SpaprInterruptController *intc, int ve=
rsion_id)
> >  {
> > -    if (kvm_irqchip_in_kernel()) {
> > -        return kvmppc_xive_post_load(SPAPR_XIVE(intc), version_id);
> > +    SpaprXive *xive =3D SPAPR_XIVE(intc);
> > +
> > +    if (spapr_xive_in_kernel(xive)) {
> > +        return kvmppc_xive_post_load(xive, version_id);
> >      }
> > =20
> >      return 0;
> > @@ -564,7 +575,7 @@ static int spapr_xive_claim_irq(SpaprInterruptContr=
oller *intc, int lisn,
> >          xive_source_irq_set_lsi(xsrc, lisn);
> >      }
> > =20
> > -    if (kvm_irqchip_in_kernel()) {
> > +    if (spapr_xive_in_kernel(xive)) {
> >          return kvmppc_xive_source_reset_one(xsrc, lisn, errp);
> >      }
> > =20
> > @@ -641,7 +652,7 @@ static void spapr_xive_set_irq(SpaprInterruptContro=
ller *intc, int irq, int val)
> >  {
> >      SpaprXive *xive =3D SPAPR_XIVE(intc);
> > =20
> > -    if (kvm_irqchip_in_kernel()) {
> > +    if (spapr_xive_in_kernel(xive)) {
> >          kvmppc_xive_source_set_irq(&xive->source, irq, val);
> >      } else {
> >          xive_source_set_irq(&xive->source, irq, val);
> > @@ -749,11 +760,21 @@ static void spapr_xive_deactivate(SpaprInterruptC=
ontroller *intc)
> > =20
> >      spapr_xive_mmio_set_enabled(xive, false);
> > =20
> > -    if (kvm_irqchip_in_kernel()) {
> > +    if (spapr_xive_in_kernel(xive)) {
> >          kvmppc_xive_disconnect(intc);
> >      }
> >  }
> > =20
> > +static bool spapr_xive_in_kernel_xptr(const XivePresenter *xptr)
> > +{
> > +    return spapr_xive_in_kernel(SPAPR_XIVE(xptr));
> > +}
>=20
> This is mostly OK, a XivePresenter is a part of the XiveRouter.
>=20
> > +static bool spapr_xive_in_kernel_xn(const XiveNotifier *xn)
> > +{
> > +    return spapr_xive_in_kernel(SPAPR_XIVE(xn));
> > +}
>=20
>=20
> This is weird. we have other XiveNotifiers which have no relation
> with a kernel backend.
>=20

These other XiveNotifiers don't implement the in_kernel() method.

What's the problem ?

> >  static void spapr_xive_class_init(ObjectClass *klass, void *data)
> >  {
> >      DeviceClass *dc =3D DEVICE_CLASS(klass);
> > @@ -761,6 +782,7 @@ static void spapr_xive_class_init(ObjectClass *klas=
s, void *data)
> >      SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_CLASS(klass);
> >      XivePresenterClass *xpc =3D XIVE_PRESENTER_CLASS(klass);
> >      SpaprXiveClass *sxc =3D SPAPR_XIVE_CLASS(klass);
> > +    XiveNotifierClass *xnc =3D XIVE_NOTIFIER_CLASS(klass);
> > =20
> >      dc->desc    =3D "sPAPR XIVE Interrupt Controller";
> >      device_class_set_props(dc, spapr_xive_properties);
> > @@ -788,6 +810,9 @@ static void spapr_xive_class_init(ObjectClass *klas=
s, void *data)
> >      sicc->post_load =3D spapr_xive_post_load;
> > =20
> >      xpc->match_nvt  =3D spapr_xive_match_nvt;
> > +    xpc->in_kernel  =3D spapr_xive_in_kernel_xptr;
> > +
> > +    xnc->in_kernel  =3D spapr_xive_in_kernel_xn;
> >  }
> > =20
> >  static const TypeInfo spapr_xive_info =3D {
> > @@ -1058,7 +1083,7 @@ static target_ulong h_int_set_source_config(Power=
PCCPU *cpu,
> >          new_eas.w =3D xive_set_field64(EAS_END_DATA, new_eas.w, eisn);
> >      }
> > =20
> > -    if (kvm_irqchip_in_kernel()) {
> > +    if (spapr_xive_in_kernel(xive)) {
> >          Error *local_err =3D NULL;
> > =20
> >          kvmppc_xive_set_source_config(xive, lisn, &new_eas, &local_err=
);
> > @@ -1379,7 +1404,7 @@ static target_ulong h_int_set_queue_config(PowerP=
CCPU *cpu,
> >       */
> > =20
> >  out:
> > -    if (kvm_irqchip_in_kernel()) {
> > +    if (spapr_xive_in_kernel(xive)) {
> >          Error *local_err =3D NULL;
> > =20
> >          kvmppc_xive_set_queue_config(xive, end_blk, end_idx, &end, &lo=
cal_err);
> > @@ -1480,7 +1505,7 @@ static target_ulong h_int_get_queue_config(PowerP=
CCPU *cpu,
> >          args[2] =3D 0;
> >      }
> > =20
> > -    if (kvm_irqchip_in_kernel()) {
> > +    if (spapr_xive_in_kernel(xive)) {
> >          Error *local_err =3D NULL;
> > =20
> >          kvmppc_xive_get_queue_config(xive, end_blk, end_idx, end, &loc=
al_err);
> > @@ -1642,7 +1667,7 @@ static target_ulong h_int_esb(PowerPCCPU *cpu,
> >          return H_P3;
> >      }
> > =20
> > -    if (kvm_irqchip_in_kernel()) {
> > +    if (spapr_xive_in_kernel(xive)) {
> >          args[0] =3D kvmppc_xive_esb_rw(xsrc, lisn, offset, data,
> >                                       flags & SPAPR_XIVE_ESB_STORE);
> >      } else {
> > @@ -1717,7 +1742,7 @@ static target_ulong h_int_sync(PowerPCCPU *cpu,
> >       * under KVM
> >       */
> > =20
> > -    if (kvm_irqchip_in_kernel()) {
> > +    if (spapr_xive_in_kernel(xive)) {
> >          Error *local_err =3D NULL;
> > =20
> >          kvmppc_xive_sync_source(xive, lisn, &local_err);
> > @@ -1761,7 +1786,7 @@ static target_ulong h_int_reset(PowerPCCPU *cpu,
> > =20
> >      device_legacy_reset(DEVICE(xive));
> > =20
> > -    if (kvm_irqchip_in_kernel()) {
> > +    if (spapr_xive_in_kernel(xive)) {
> >          Error *local_err =3D NULL;
> > =20
> >          kvmppc_xive_reset(xive, &local_err);
> > diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> > index 9b55e0356c62..27d27fdc9ee4 100644
> > --- a/hw/intc/xive.c
> > +++ b/hw/intc/xive.c
> > @@ -592,6 +592,17 @@ static const char * const xive_tctx_ring_names[] =
=3D {
> >      "USER", "OS", "POOL", "PHYS",
> >  };
> > =20
> > +/*
> > + * kvm_irqchip_in_kernel() will cause the compiler to turn this
> > + * info a nop if CONFIG_KVM isn't defined.
> > + */
> > +#define xive_in_kernel(xptr)                                  \
> > +    (kvm_irqchip_in_kernel() &&                                       =
  \
> > +     ({                                                               =
  \
> > +         XivePresenterClass *xpc =3D XIVE_PRESENTER_GET_CLASS(xptr);  =
    \
> > +         xpc->in_kernel ? xpc->in_kernel(xptr) : false;               =
  \
> > +     }))
> > +
> >
> >  void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon)
> >  {
> >      int cpu_index;
> > @@ -606,7 +617,7 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Monit=
or *mon)
> > =20
> >      cpu_index =3D tctx->cs ? tctx->cs->cpu_index : -1;
> > =20
> > -    if (kvm_irqchip_in_kernel()) {
> > +    if (xive_in_kernel(tctx->xptr)) {
> >          Error *local_err =3D NULL;
> > =20
> >          kvmppc_xive_cpu_synchronize_state(tctx, &local_err);
> > @@ -671,7 +682,7 @@ static void xive_tctx_realize(DeviceState *dev, Err=
or **errp)
> >      }
> > =20
> >      /* Connect the presenter to the VCPU (required for CPU hotplug) */
> > -    if (kvm_irqchip_in_kernel()) {
> > +    if (xive_in_kernel(tctx->xptr)) {
> >          kvmppc_xive_cpu_connect(tctx, &local_err);
> >          if (local_err) {
> >              error_propagate(errp, local_err);
> > @@ -682,10 +693,11 @@ static void xive_tctx_realize(DeviceState *dev, E=
rror **errp)
> > =20
> >  static int vmstate_xive_tctx_pre_save(void *opaque)
> >  {
> > +    XiveTCTX *tctx =3D XIVE_TCTX(opaque);
> >      Error *local_err =3D NULL;
> > =20
> > -    if (kvm_irqchip_in_kernel()) {
> > -        kvmppc_xive_cpu_get_state(XIVE_TCTX(opaque), &local_err);
> > +    if (xive_in_kernel(tctx->xptr)) {
> > +        kvmppc_xive_cpu_get_state(tctx, &local_err);
> >          if (local_err) {
> >              error_report_err(local_err);
> >              return -1;
> > @@ -697,14 +709,15 @@ static int vmstate_xive_tctx_pre_save(void *opaqu=
e)
> > =20
> >  static int vmstate_xive_tctx_post_load(void *opaque, int version_id)
> >  {
> > +    XiveTCTX *tctx =3D XIVE_TCTX(opaque);
> >      Error *local_err =3D NULL;
> > =20
> > -    if (kvm_irqchip_in_kernel()) {
> > +    if (xive_in_kernel(tctx->xptr)) {
> >          /*
> >           * Required for hotplugged CPU, for which the state comes
> >           * after all states of the machine.
> >           */
> > -        kvmppc_xive_cpu_set_state(XIVE_TCTX(opaque), &local_err);
> > +        kvmppc_xive_cpu_set_state(tctx, &local_err);
> >          if (local_err) {
> >              error_report_err(local_err);
> >              return -1;
> > @@ -1128,6 +1141,7 @@ static void xive_source_reset(void *dev)
> >  static void xive_source_realize(DeviceState *dev, Error **errp)
> >  {
> >      XiveSource *xsrc =3D XIVE_SOURCE(dev);
> > +    XiveNotifierClass *xnc =3D XIVE_NOTIFIER_GET_CLASS(xsrc->xive);
> > =20
> >      assert(xsrc->xive);
> > =20
> > @@ -1147,7 +1161,7 @@ static void xive_source_realize(DeviceState *dev,=
 Error **errp)
> >      xsrc->status =3D g_malloc0(xsrc->nr_irqs);
> >      xsrc->lsi_map =3D bitmap_new(xsrc->nr_irqs);
> > =20
> > -    if (!kvm_irqchip_in_kernel()) {
> > +    if (!xnc->in_kernel || !xnc->in_kernel(xsrc->xive)) {
> >          memory_region_init_io(&xsrc->esb_mmio, OBJECT(xsrc),
> >                                &xive_source_esb_ops, xsrc, "xive.esb",
> >                                (1ull << xsrc->esb_shift) * xsrc->nr_irq=
s);
> > diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> > index 705cf48176fc..aa46e3fcf512 100644
> > --- a/include/hw/ppc/xive.h
> > +++ b/include/hw/ppc/xive.h
> > @@ -161,6 +161,7 @@ typedef struct XiveNotifier XiveNotifier;
> >  typedef struct XiveNotifierClass {
> >      InterfaceClass parent;
> >      void (*notify)(XiveNotifier *xn, uint32_t lisn);
> > +    bool (*in_kernel)(const XiveNotifier *xn);
> >  } XiveNotifierClass;
> > =20
> >  /*
> > @@ -396,6 +397,7 @@ typedef struct XivePresenterClass {
> >                       uint8_t nvt_blk, uint32_t nvt_idx,
> >                       bool cam_ignore, uint8_t priority,
> >                       uint32_t logic_serv, XiveTCTXMatch *match);
> > +    bool (*in_kernel)(const XivePresenter *xptr);
> >  } XivePresenterClass;
> > =20
> >  int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
> >=20
> >=20
>=20
> It seems redundant. Can we introduce a new XiveBackend QOM interface=20
> which would implement an in_kernel() handler ? and XiveRouter would=20
> inherit from it.=20
>=20

Not sure to see how it would help... the XiveRouter type isn't used
at the locations where we call kvm_irqchip_in_kernel(). Only
XivePresenter and XiveNotifier...

> C.
>=20
>=20
>=20
>=20
>=20


