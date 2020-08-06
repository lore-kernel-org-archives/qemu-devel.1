Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D40C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11380204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11380204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3c89-0002Tz-2A
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 05:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1k3c7N-0001nV-SN; Thu, 06 Aug 2020 05:23:21 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:38553)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1k3c7K-0005sO-F3; Thu, 06 Aug 2020 05:23:21 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.10])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id E1E524D98AD4;
 Thu,  6 Aug 2020 11:23:14 +0200 (CEST)
Received: from kaod.org (37.59.142.101) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 6 Aug 2020
 11:23:13 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004f73a699b-f109-4aeb-b8d3-bb668999bbcf,
 576280D6912C6263F4559E70A1150E7551188EC0) smtp.auth=groug@kaod.org
Date: Thu, 6 Aug 2020 11:23:11 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH for-5.2 3/5] ppc/xive: Introduce dedicated
 kvm_irqchip_in_kernel() wrappers
Message-ID: <20200806112311.72a152a2@bahia.lan>
In-Reply-To: <20200806050835.GC100968@yekko.fritz.box>
References: <159664891296.638781.18417631893299150932.stgit@bahia.lan>
 <159664893734.638781.14358602267403682394.stgit@bahia.lan>
 <20200806050835.GC100968@yekko.fritz.box>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/b8f1Z4MxipW.ICG8fX02L3U";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 7db2e243-c5d2-42fe-a040-00200b469af4
X-Ovh-Tracer-Id: 14700312136043305379
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrkedtgdduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtghisehgtderreertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeelgffgfeeugedugeekveeiveevjeffhfduvdegffetkeeiveeufefgledtgfeiteenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtoheptghlgheskhgrohgurdhorhhg
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 05:23:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/b8f1Z4MxipW.ICG8fX02L3U
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Aug 2020 15:08:35 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Aug 05, 2020 at 07:35:37PM +0200, Greg Kurz wrote:
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
> > KVM XIVE specific code. Introduce helpers to access the underlying
> > fd for various XIVE types and call them with a kvm_irqchip_in_kernel()
> > guard : this allows the compiler to optimize the kvmppc_xive_* calls
> > out if CONFIG_KVM isn't defined, thus avoiding the need for stubs.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/intc/spapr_xive.c        |   39 +++++++++++++++++++++++++----------=
----
> >  hw/intc/spapr_xive_kvm.c    |   15 +++++++++++++++
> >  hw/intc/xive.c              |   30 +++++++++++++++++++++++-------
> >  include/hw/ppc/spapr_xive.h |    1 +
> >  include/hw/ppc/xive.h       |    2 ++
> >  5 files changed, 66 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> > index 89c8cd96670b..98e6489fb16d 100644
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
> > +#define kvmppc_xive_in_kernel(xive) \
> > +    (kvm_irqchip_in_kernel() && kvmppc_xive_kernel_irqchip(xive))
>=20
> This all seems like a good idea, my only concern is that the semantic
> difference between kvmppc_xive_in_kernel() and
> kvmppc_xive_kernel_irqchip() is pretty subtle and non-obvious (and
> likewise for the tctx and xsrc variations).
>=20

Yeah, kvmppc_xive_in_kernel() and friends are essentially versions
that also work when CONFIG_KVM is not set (needed to build
qemu-system-ppc64 for non-POWER hosts).

> We're right in the XIVE implementation, so I suggest you eliminate the
> kvmppc_xive_kernel_irqchip() etc. wrappers and just open code a check
> on the fd in kvmppc_xive_in_kernel() etc.
>=20

This is true for the kvmppc_xive_in_kernel() variant that takes a
SpaprXive * arg. Things are different for the tctx and xsrc
variants, because xive.c is platform agnostic (shared between
spapr and powernv). Exposing the SpaprXive type to xive.c
would look like a layering violation to me.

Maybe introducing abstract class methods at the base XIVE level (eg.
XivePresenterClass) and implement them in platform-specific code
would make things clearer ?

> > +
> >  void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon)
> >  {
> >      XiveSource *xsrc =3D &xive->source;
> >      int i;
> > =20
> > -    if (kvm_irqchip_in_kernel()) {
> > +    if (kvmppc_xive_in_kernel(xive)) {
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
> > +    if (kvmppc_xive_in_kernel(xive)) {
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
> > +    if (kvmppc_xive_in_kernel(xive)) {
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
> > +    if (kvmppc_xive_in_kernel(xive)) {
> >          return kvmppc_xive_source_reset_one(xsrc, lisn, errp);
> >      }
> > =20
> > @@ -641,7 +652,7 @@ static void spapr_xive_set_irq(SpaprInterruptContro=
ller *intc, int irq, int val)
> >  {
> >      SpaprXive *xive =3D SPAPR_XIVE(intc);
> > =20
> > -    if (kvm_irqchip_in_kernel()) {
> > +    if (kvmppc_xive_in_kernel(xive)) {
> >          kvmppc_xive_source_set_irq(&xive->source, irq, val);
> >      } else {
> >          xive_source_set_irq(&xive->source, irq, val);
> > @@ -749,7 +760,7 @@ static void spapr_xive_deactivate(SpaprInterruptCon=
troller *intc)
> > =20
> >      spapr_xive_mmio_set_enabled(xive, false);
> > =20
> > -    if (kvm_irqchip_in_kernel()) {
> > +    if (kvmppc_xive_in_kernel(xive)) {
> >          kvmppc_xive_disconnect(intc);
> >      }
> >  }
> > @@ -1058,7 +1069,7 @@ static target_ulong h_int_set_source_config(Power=
PCCPU *cpu,
> >          new_eas.w =3D xive_set_field64(EAS_END_DATA, new_eas.w, eisn);
> >      }
> > =20
> > -    if (kvm_irqchip_in_kernel()) {
> > +    if (kvmppc_xive_in_kernel(xive)) {
> >          Error *local_err =3D NULL;
> > =20
> >          kvmppc_xive_set_source_config(xive, lisn, &new_eas, &local_err=
);
> > @@ -1379,7 +1390,7 @@ static target_ulong h_int_set_queue_config(PowerP=
CCPU *cpu,
> >       */
> > =20
> >  out:
> > -    if (kvm_irqchip_in_kernel()) {
> > +    if (kvmppc_xive_in_kernel(xive)) {
> >          Error *local_err =3D NULL;
> > =20
> >          kvmppc_xive_set_queue_config(xive, end_blk, end_idx, &end, &lo=
cal_err);
> > @@ -1480,7 +1491,7 @@ static target_ulong h_int_get_queue_config(PowerP=
CCPU *cpu,
> >          args[2] =3D 0;
> >      }
> > =20
> > -    if (kvm_irqchip_in_kernel()) {
> > +    if (kvmppc_xive_in_kernel(xive)) {
> >          Error *local_err =3D NULL;
> > =20
> >          kvmppc_xive_get_queue_config(xive, end_blk, end_idx, end, &loc=
al_err);
> > @@ -1642,7 +1653,7 @@ static target_ulong h_int_esb(PowerPCCPU *cpu,
> >          return H_P3;
> >      }
> > =20
> > -    if (kvm_irqchip_in_kernel()) {
> > +    if (kvmppc_xive_in_kernel(xive)) {
> >          args[0] =3D kvmppc_xive_esb_rw(xsrc, lisn, offset, data,
> >                                       flags & SPAPR_XIVE_ESB_STORE);
> >      } else {
> > @@ -1717,7 +1728,7 @@ static target_ulong h_int_sync(PowerPCCPU *cpu,
> >       * under KVM
> >       */
> > =20
> > -    if (kvm_irqchip_in_kernel()) {
> > +    if (kvmppc_xive_in_kernel(xive)) {
> >          Error *local_err =3D NULL;
> > =20
> >          kvmppc_xive_sync_source(xive, lisn, &local_err);
> > @@ -1761,7 +1772,7 @@ static target_ulong h_int_reset(PowerPCCPU *cpu,
> > =20
> >      device_legacy_reset(DEVICE(xive));
> > =20
> > -    if (kvm_irqchip_in_kernel()) {
> > +    if (kvmppc_xive_in_kernel(xive)) {
> >          Error *local_err =3D NULL;
> > =20
> >          kvmppc_xive_reset(xive, &local_err);
> > diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> > index 893a1ee77e70..a9657e2b0cda 100644
> > --- a/hw/intc/spapr_xive_kvm.c
> > +++ b/hw/intc/spapr_xive_kvm.c
> > @@ -889,3 +889,18 @@ void kvmppc_xive_disconnect(SpaprInterruptControll=
er *intc)
> >          xive->change =3D NULL;
> >      }
> >  }
> > +
> > +bool kvmppc_xive_kernel_irqchip(SpaprXive *xive)
> > +{
> > +    return xive->fd !=3D -1;
> > +}
> > +
> > +bool kvmppc_xive_kernel_irqchip_tctx(XiveTCTX *tctx)
> > +{
> > +    return kvmppc_xive_kernel_irqchip(SPAPR_XIVE(tctx->xptr));
> > +}
> > +
> > +bool kvmppc_xive_kernel_irqchip_xsrc(XiveSource *xsrc)
> > +{
> > +    return kvmppc_xive_kernel_irqchip(SPAPR_XIVE(xsrc->xive));
> > +}
> > diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> > index 9b55e0356c62..2e1af4530dc5 100644
> > --- a/hw/intc/xive.c
> > +++ b/hw/intc/xive.c
> > @@ -592,6 +592,13 @@ static const char * const xive_tctx_ring_names[] =
=3D {
> >      "USER", "OS", "POOL", "PHYS",
> >  };
> > =20
> > +/*
> > + * kvm_irqchip_in_kernel() will cause the compiler to turn this
> > + * info a nop if CONFIG_KVM isn't defined.
> > + */
> > +#define kvmppc_xive_in_kernel_tctx(tctx) \
> > +    (kvm_irqchip_in_kernel() && kvmppc_xive_kernel_irqchip_tctx(tctx))
> > +
> >  void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon)
> >  {
> >      int cpu_index;
> > @@ -606,7 +613,7 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Monit=
or *mon)
> > =20
> >      cpu_index =3D tctx->cs ? tctx->cs->cpu_index : -1;
> > =20
> > -    if (kvm_irqchip_in_kernel()) {
> > +    if (kvmppc_xive_in_kernel_tctx(tctx)) {
> >          Error *local_err =3D NULL;
> > =20
> >          kvmppc_xive_cpu_synchronize_state(tctx, &local_err);
> > @@ -671,7 +678,7 @@ static void xive_tctx_realize(DeviceState *dev, Err=
or **errp)
> >      }
> > =20
> >      /* Connect the presenter to the VCPU (required for CPU hotplug) */
> > -    if (kvm_irqchip_in_kernel()) {
> > +    if (kvmppc_xive_in_kernel_tctx(tctx)) {
> >          kvmppc_xive_cpu_connect(tctx, &local_err);
> >          if (local_err) {
> >              error_propagate(errp, local_err);
> > @@ -682,10 +689,11 @@ static void xive_tctx_realize(DeviceState *dev, E=
rror **errp)
> > =20
> >  static int vmstate_xive_tctx_pre_save(void *opaque)
> >  {
> > +    XiveTCTX *tctx =3D XIVE_TCTX(opaque);
> >      Error *local_err =3D NULL;
> > =20
> > -    if (kvm_irqchip_in_kernel()) {
> > -        kvmppc_xive_cpu_get_state(XIVE_TCTX(opaque), &local_err);
> > +    if (kvmppc_xive_in_kernel_tctx(tctx)) {
> > +        kvmppc_xive_cpu_get_state(tctx, &local_err);
> >          if (local_err) {
> >              error_report_err(local_err);
> >              return -1;
> > @@ -697,14 +705,15 @@ static int vmstate_xive_tctx_pre_save(void *opaqu=
e)
> > =20
> >  static int vmstate_xive_tctx_post_load(void *opaque, int version_id)
> >  {
> > +    XiveTCTX *tctx =3D XIVE_TCTX(opaque);
> >      Error *local_err =3D NULL;
> > =20
> > -    if (kvm_irqchip_in_kernel()) {
> > +    if (kvmppc_xive_in_kernel_tctx(tctx)) {
> >          /*
> >           * Required for hotplugged CPU, for which the state comes
> >           * after all states of the machine.
> >           */
> > -        kvmppc_xive_cpu_set_state(XIVE_TCTX(opaque), &local_err);
> > +        kvmppc_xive_cpu_set_state(tctx, &local_err);
> >          if (local_err) {
> >              error_report_err(local_err);
> >              return -1;
> > @@ -1125,6 +1134,13 @@ static void xive_source_reset(void *dev)
> >      memset(xsrc->status, XIVE_ESB_OFF, xsrc->nr_irqs);
> >  }
> > =20
> > +/*
> > + * kvm_irqchip_in_kernel() will cause the compiler to turn this
> > + * info a nop if CONFIG_KVM isn't defined.
> > + */
> > +#define kvmppc_xive_in_kernel_xsrc(xsrc) \
> > +    (kvm_irqchip_in_kernel() && kvmppc_xive_kernel_irqchip_xsrc(xsrc))
> > +
> >  static void xive_source_realize(DeviceState *dev, Error **errp)
> >  {
> >      XiveSource *xsrc =3D XIVE_SOURCE(dev);
> > @@ -1147,7 +1163,7 @@ static void xive_source_realize(DeviceState *dev,=
 Error **errp)
> >      xsrc->status =3D g_malloc0(xsrc->nr_irqs);
> >      xsrc->lsi_map =3D bitmap_new(xsrc->nr_irqs);
> > =20
> > -    if (!kvm_irqchip_in_kernel()) {
> > +    if (!kvmppc_xive_in_kernel_xsrc(xsrc)) {
> >          memory_region_init_io(&xsrc->esb_mmio, OBJECT(xsrc),
> >                                &xive_source_esb_ops, xsrc, "xive.esb",
> >                                (1ull << xsrc->esb_shift) * xsrc->nr_irq=
s);
> > diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> > index 93d09d68deb7..9fd00378ac1f 100644
> > --- a/include/hw/ppc/spapr_xive.h
> > +++ b/include/hw/ppc/spapr_xive.h
> > @@ -94,5 +94,6 @@ void kvmppc_xive_get_queue_config(SpaprXive *xive, ui=
nt8_t end_blk,
> >  void kvmppc_xive_synchronize_state(SpaprXive *xive, Error **errp);
> >  int kvmppc_xive_pre_save(SpaprXive *xive);
> >  int kvmppc_xive_post_load(SpaprXive *xive, int version_id);
> > +bool kvmppc_xive_kernel_irqchip(SpaprXive *xive);
> > =20
> >  #endif /* PPC_SPAPR_XIVE_H */
> > diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> > index 705cf48176fc..ea66e9ea9c7b 100644
> > --- a/include/hw/ppc/xive.h
> > +++ b/include/hw/ppc/xive.h
> > @@ -484,5 +484,7 @@ void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error =
**errp);
> >  void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp);
> >  void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp);
> >  void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp);
> > +bool kvmppc_xive_kernel_irqchip_tctx(XiveTCTX *tctx);
> > +bool kvmppc_xive_kernel_irqchip_xsrc(XiveSource *xsrc);
> > =20
> >  #endif /* PPC_XIVE_H */
> >=20
> >=20
>=20


--Sig_/b8f1Z4MxipW.ICG8fX02L3U
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl8rzAAACgkQcdTV5YIv
c9ZGLBAAh9fcJLCnm6gkMgxFrDmjvOfHcp5U5ofeH/4FIGoqTaA1v/+rHWEKqKrV
tEzUC1GtFdsaI7JD9doXTChux56Uhwgk/TxhjLJfaL0lpbH4wrnw5NZzy13Jb5Uq
R5h84cpVxMa/Rjzfh04TMl48g1B6XHMS1eO36ulKUoD2TL/xFjAM+u4mHuWh+ZQ8
ab+hzRstCfsJYFKazOYTLMSVOqot8+h6CvSr97YwtXBWnYHlx5r3CpfWc9aWj7/A
fllcmFCrmZ4bGbcMBXDCIazOu8FZwLnW4oorKA6vIaRqn3NmaRf0lfHzFNPaXAoa
u9v9UlPjA7qOkgiu0CFLUzIvg59k2yIWPGK0QAMZh269n3a6jalu5vFzw2xbauRN
O265r4vQZD4rbRtAOpzxlrvMR/wtt2QNBbdtemk8GvEFcbakOiugLCZ+qZSvKi1Y
R4ajGhHk+1Kg03PoseY45stKmO/YlLdcHkIS9IDcsB9ETd4h1ra4tUTAWF9288NW
RbsckE605pbzfkPELG5dTz+0NDjb+37jYzhiq+RK/qcUMI6hJESX4fgjktL64Vhk
tu5cUPB5Ya63Cx/kBkMcs1bFRLuobjWOKMNDHROdv0RMzH9DTQyeO7MSp+p/RJid
b9fD8Ug7F17WskOWchqgJJG+19Iqas6dJ0V5NlQE2O41+eazuPc=
=d5yE
-----END PGP SIGNATURE-----

--Sig_/b8f1Z4MxipW.ICG8fX02L3U--

