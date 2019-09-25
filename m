Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0BFC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 08:32:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C08B420872
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 08:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C08B420872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD2jF-00031G-Qv
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 04:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iD2hu-0002FC-RE
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iD2hs-0000QT-Mf
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:31:30 -0400
Received: from 12.mo7.mail-out.ovh.net ([178.33.107.167]:52917)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iD2hs-0000PP-Df
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:31:28 -0400
Received: from player688.ha.ovh.net (unknown [10.109.159.48])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 1EDD91306D1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 10:31:25 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id D7F40A1FB9B1;
 Wed, 25 Sep 2019 08:31:14 +0000 (UTC)
Date: Wed, 25 Sep 2019 10:31:12 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 05/20] xics: Merge TYPE_ICS_BASE and TYPE_ICS_SIMPLE
 classes
Message-ID: <20190925103112.01feada6@bahia.lan>
In-Reply-To: <20190925101610.43a5bda8@bahia.lan>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-6-david@gibson.dropbear.id.au>
 <20190925101610.43a5bda8@bahia.lan>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2728336950688848358
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedvgddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.107.167
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
 clg@kaod.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Sep 2019 10:16:10 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Wed, 25 Sep 2019 16:45:19 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
> > TYPE_ICS_SIMPLE is the only subtype of TYPE_ICS_BASE that's ever
> > instantiated, and the only one we're ever likely to want.  The
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This seems to be kind of contradicted by the next patch BTW. Maybe just
drop that to avoid confusion ? The rest of the changelog explains why we
should merge the classes well enough IMHO.

> > existence of different classes is just a hang over from when we
> > (misguidedly) had separate subtypes for the KVM and non-KVM version of
> > the device.
> > 
> > So, collapse the two classes together into just TYPE_ICS.
> > 
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> 
> So this also kills the realize hook, unlike in your previous series
> where this was done along with the reset hook change. Makes sense
> when merging parent/child class as well.
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>
> 
> >  hw/intc/xics.c        | 86 ++++++++++++++-----------------------------
> >  hw/ppc/pnv_psi.c      |  2 +-
> >  hw/ppc/spapr_irq.c    |  4 +-
> >  include/hw/ppc/xics.h | 16 +++-----
> >  4 files changed, 36 insertions(+), 72 deletions(-)
> > 
> > diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> > index 82e6f09259..dfe7dbd254 100644
> > --- a/hw/intc/xics.c
> > +++ b/hw/intc/xics.c
> > @@ -555,7 +555,7 @@ static void ics_reset_irq(ICSIRQState *irq)
> >  
> >  static void ics_reset(DeviceState *dev)
> >  {
> > -    ICSState *ics = ICS_BASE(dev);
> > +    ICSState *ics = ICS(dev);
> >      int i;
> >      uint8_t flags[ics->nr_irqs];
> >  
> > @@ -573,7 +573,7 @@ static void ics_reset(DeviceState *dev)
> >      if (kvm_irqchip_in_kernel()) {
> >          Error *local_err = NULL;
> >  
> > -        ics_set_kvm_state(ICS_BASE(dev), &local_err);
> > +        ics_set_kvm_state(ICS(dev), &local_err);
> >          if (local_err) {
> >              error_report_err(local_err);
> >          }
> > @@ -585,47 +585,15 @@ static void ics_reset_handler(void *dev)
> >      ics_reset(dev);
> >  }
> >  
> > -static void ics_simple_realize(DeviceState *dev, Error **errp)
> > +static void ics_realize(DeviceState *dev, Error **errp)
> >  {
> > -    ICSState *ics = ICS_SIMPLE(dev);
> > -    ICSStateClass *icsc = ICS_BASE_GET_CLASS(ics);
> > +    ICSState *ics = ICS(dev);
> >      Error *local_err = NULL;
> > -
> > -    icsc->parent_realize(dev, &local_err);
> > -    if (local_err) {
> > -        error_propagate(errp, local_err);
> > -        return;
> > -    }
> > -
> > -    qemu_register_reset(ics_reset_handler, ics);
> > -}
> > -
> > -static void ics_simple_class_init(ObjectClass *klass, void *data)
> > -{
> > -    DeviceClass *dc = DEVICE_CLASS(klass);
> > -    ICSStateClass *isc = ICS_BASE_CLASS(klass);
> > -
> > -    device_class_set_parent_realize(dc, ics_simple_realize,
> > -                                    &isc->parent_realize);
> > -}
> > -
> > -static const TypeInfo ics_simple_info = {
> > -    .name = TYPE_ICS_SIMPLE,
> > -    .parent = TYPE_ICS_BASE,
> > -    .instance_size = sizeof(ICSState),
> > -    .class_init = ics_simple_class_init,
> > -    .class_size = sizeof(ICSStateClass),
> > -};
> > -
> > -static void ics_base_realize(DeviceState *dev, Error **errp)
> > -{
> > -    ICSState *ics = ICS_BASE(dev);
> >      Object *obj;
> > -    Error *err = NULL;
> >  
> > -    obj = object_property_get_link(OBJECT(dev), ICS_PROP_XICS, &err);
> > +    obj = object_property_get_link(OBJECT(dev), ICS_PROP_XICS, &local_err);
> >      if (!obj) {
> > -        error_propagate_prepend(errp, err,
> > +        error_propagate_prepend(errp, local_err,
> >                                  "required link '" ICS_PROP_XICS
> >                                  "' not found: ");
> >          return;
> > @@ -637,16 +605,18 @@ static void ics_base_realize(DeviceState *dev, Error **errp)
> >          return;
> >      }
> >      ics->irqs = g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
> > +
> > +    qemu_register_reset(ics_reset_handler, ics);
> >  }
> >  
> > -static void ics_base_instance_init(Object *obj)
> > +static void ics_instance_init(Object *obj)
> >  {
> > -    ICSState *ics = ICS_BASE(obj);
> > +    ICSState *ics = ICS(obj);
> >  
> >      ics->offset = XICS_IRQ_BASE;
> >  }
> >  
> > -static int ics_base_pre_save(void *opaque)
> > +static int ics_pre_save(void *opaque)
> >  {
> >      ICSState *ics = opaque;
> >  
> > @@ -657,7 +627,7 @@ static int ics_base_pre_save(void *opaque)
> >      return 0;
> >  }
> >  
> > -static int ics_base_post_load(void *opaque, int version_id)
> > +static int ics_post_load(void *opaque, int version_id)
> >  {
> >      ICSState *ics = opaque;
> >  
> > @@ -675,7 +645,7 @@ static int ics_base_post_load(void *opaque, int version_id)
> >      return 0;
> >  }
> >  
> > -static const VMStateDescription vmstate_ics_base_irq = {
> > +static const VMStateDescription vmstate_ics_irq = {
> >      .name = "ics/irq",
> >      .version_id = 2,
> >      .minimum_version_id = 1,
> > @@ -689,45 +659,44 @@ static const VMStateDescription vmstate_ics_base_irq = {
> >      },
> >  };
> >  
> > -static const VMStateDescription vmstate_ics_base = {
> > +static const VMStateDescription vmstate_ics = {
> >      .name = "ics",
> >      .version_id = 1,
> >      .minimum_version_id = 1,
> > -    .pre_save = ics_base_pre_save,
> > -    .post_load = ics_base_post_load,
> > +    .pre_save = ics_pre_save,
> > +    .post_load = ics_post_load,
> >      .fields = (VMStateField[]) {
> >          /* Sanity check */
> >          VMSTATE_UINT32_EQUAL(nr_irqs, ICSState, NULL),
> >  
> >          VMSTATE_STRUCT_VARRAY_POINTER_UINT32(irqs, ICSState, nr_irqs,
> > -                                             vmstate_ics_base_irq,
> > +                                             vmstate_ics_irq,
> >                                               ICSIRQState),
> >          VMSTATE_END_OF_LIST()
> >      },
> >  };
> >  
> > -static Property ics_base_properties[] = {
> > +static Property ics_properties[] = {
> >      DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >  
> > -static void ics_base_class_init(ObjectClass *klass, void *data)
> > +static void ics_class_init(ObjectClass *klass, void *data)
> >  {
> >      DeviceClass *dc = DEVICE_CLASS(klass);
> >  
> > -    dc->realize = ics_base_realize;
> > -    dc->props = ics_base_properties;
> > +    dc->realize = ics_realize;
> > +    dc->props = ics_properties;
> >      dc->reset = ics_reset;
> > -    dc->vmsd = &vmstate_ics_base;
> > +    dc->vmsd = &vmstate_ics;
> >  }
> >  
> > -static const TypeInfo ics_base_info = {
> > -    .name = TYPE_ICS_BASE,
> > +static const TypeInfo ics_info = {
> > +    .name = TYPE_ICS,
> >      .parent = TYPE_DEVICE,
> > -    .abstract = true,
> >      .instance_size = sizeof(ICSState),
> > -    .instance_init = ics_base_instance_init,
> > -    .class_init = ics_base_class_init,
> > +    .instance_init = ics_instance_init,
> > +    .class_init = ics_class_init,
> >      .class_size = sizeof(ICSStateClass),
> >  };
> >  
> > @@ -767,8 +736,7 @@ void ics_set_irq_type(ICSState *ics, int srcno, bool lsi)
> >  
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
> > @@ -469,7 +469,7 @@ static void pnv_psi_power8_instance_init(Object *obj)
> >      Pnv8Psi *psi8 = PNV8_PSI(obj);
> >  
> >      object_initialize_child(obj, "ics-psi",  &psi8->ics, sizeof(psi8->ics),
> > -                            TYPE_ICS_SIMPLE, &error_abort, NULL);
> > +                            TYPE_ICS, &error_abort, NULL);
> >  }
> >  
> >  static const uint8_t irq_to_xivr[] = {
> > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > index ac189c5796..6c45d2a3c0 100644
> > --- a/hw/ppc/spapr_irq.c
> > +++ b/hw/ppc/spapr_irq.c
> > @@ -98,7 +98,7 @@ static void spapr_irq_init_xics(SpaprMachineState *spapr, int nr_irqs,
> >      Object *obj;
> >      Error *local_err = NULL;
> >  
> > -    obj = object_new(TYPE_ICS_SIMPLE);
> > +    obj = object_new(TYPE_ICS);
> >      object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
> >      object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
> >                                     &error_fatal);
> > @@ -109,7 +109,7 @@ static void spapr_irq_init_xics(SpaprMachineState *spapr, int nr_irqs,
> >          return;
> >      }
> >  
> > -    spapr->ics = ICS_BASE(obj);
> > +    spapr->ics = ICS(obj);
> >  
> >      xics_spapr_init(spapr);
> >  }
> > diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> > index 18fcd2b11c..5a9b73d144 100644
> > --- a/include/hw/ppc/xics.h
> > +++ b/include/hw/ppc/xics.h
> > @@ -89,17 +89,13 @@ struct PnvICPState {
> >      uint32_t links[3];
> >  };
> >  
> > -#define TYPE_ICS_BASE "ics-base"
> > -#define ICS_BASE(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_BASE)
> > +#define TYPE_ICS "ics"
> > +#define ICS(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS)
> >  
> > -/* Retain ics for sPAPR for migration from existing sPAPR guests */
> > -#define TYPE_ICS_SIMPLE "ics"
> > -#define ICS_SIMPLE(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SIMPLE)
> > -
> > -#define ICS_BASE_CLASS(klass) \
> > -     OBJECT_CLASS_CHECK(ICSStateClass, (klass), TYPE_ICS_BASE)
> > -#define ICS_BASE_GET_CLASS(obj) \
> > -     OBJECT_GET_CLASS(ICSStateClass, (obj), TYPE_ICS_BASE)
> > +#define ICS_CLASS(klass) \
> > +     OBJECT_CLASS_CHECK(ICSStateClass, (klass), TYPE_ICS)
> > +#define ICS_GET_CLASS(obj) \
> > +     OBJECT_GET_CLASS(ICSStateClass, (obj), TYPE_ICS)
> >  
> >  struct ICSStateClass {
> >      DeviceClass parent_class;
> 
> 


