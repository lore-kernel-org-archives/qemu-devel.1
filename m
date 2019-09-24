Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AB9C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 07:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2CF220640
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 07:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CF220640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCfOf-0006qj-3e
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 03:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iCfNM-0005zm-1Y
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 03:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iCfNG-0006LN-Sd
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 03:36:43 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:43438)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iCfNG-0006Kv-MK
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 03:36:38 -0400
Received: from player760.ha.ovh.net (unknown [10.109.146.132])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id ACE1A1AD2FD
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 09:36:36 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player760.ha.ovh.net (Postfix) with ESMTPSA id C2983A2A82A8;
 Tue, 24 Sep 2019 07:36:31 +0000 (UTC)
Date: Tue, 24 Sep 2019 09:36:30 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/4] xics: Merge reset and realize hooks
Message-ID: <20190924093630.079a5213@bahia.lan>
In-Reply-To: <20190924045952.11412-3-david@gibson.dropbear.id.au>
References: <20190924045952.11412-1-david@gibson.dropbear.id.au>
 <20190924045952.11412-3-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 14376615913406175718
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdelgdduvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.172.75
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
Cc: gkurz@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Sep 2019 14:59:50 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> Currently TYPE_XICS_BASE and TYPE_XICS_SIMPLE have their own reset and
> realize methods, using the standard technique for having the subtype
> call the supertype's methods before doing its own thing.
> 
> But TYPE_XICS_SIMPLE is the only subtype of TYPE_XICS_BASE ever
> instantiated, so there's no point having the split here.  Merge them
> together into just ics_reset() and ics_realize() functions.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/intc/xics.c        | 97 ++++++++++++++++---------------------------
>  include/hw/ppc/xics.h |  3 --
>  2 files changed, 35 insertions(+), 65 deletions(-)
> 
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 93139b0189..db0e532bd9 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -548,68 +548,13 @@ static void ics_eoi(ICSState *ics, uint32_t nr)
>      }
>  }
>  
> -static void ics_simple_reset(DeviceState *dev)
> -{
> -    ICSStateClass *icsc = ICS_BASE_GET_CLASS(dev);
> -
> -    icsc->parent_reset(dev);
> -
> -    if (kvm_irqchip_in_kernel()) {
> -        Error *local_err = NULL;
> -
> -        ics_set_kvm_state(ICS_BASE(dev), &local_err);
> -        if (local_err) {
> -            error_report_err(local_err);
> -        }
> -    }
> -}
> -
> -static void ics_simple_reset_handler(void *dev)
> -{
> -    ics_simple_reset(dev);
> -}
> -
> -static void ics_simple_realize(DeviceState *dev, Error **errp)
> -{
> -    ICSState *ics = ICS_SIMPLE(dev);
> -    ICSStateClass *icsc = ICS_BASE_GET_CLASS(ics);
> -    Error *local_err = NULL;
> -
> -    icsc->parent_realize(dev, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
> -    qemu_register_reset(ics_simple_reset_handler, ics);
> -}
> -
> -static void ics_simple_class_init(ObjectClass *klass, void *data)
> -{
> -    DeviceClass *dc = DEVICE_CLASS(klass);
> -    ICSStateClass *isc = ICS_BASE_CLASS(klass);
> -
> -    device_class_set_parent_realize(dc, ics_simple_realize,
> -                                    &isc->parent_realize);
> -    device_class_set_parent_reset(dc, ics_simple_reset,
> -                                  &isc->parent_reset);
> -}
> -
> -static const TypeInfo ics_simple_info = {
> -    .name = TYPE_ICS_SIMPLE,
> -    .parent = TYPE_ICS_BASE,
> -    .instance_size = sizeof(ICSState),
> -    .class_init = ics_simple_class_init,
> -    .class_size = sizeof(ICSStateClass),
> -};
> -
>  static void ics_reset_irq(ICSIRQState *irq)
>  {
>      irq->priority = 0xff;
>      irq->saved_priority = 0xff;
>  }
>  
> -static void ics_base_reset(DeviceState *dev)
> +static void ics_reset(DeviceState *dev)
>  {
>      ICSState *ics = ICS_BASE(dev);
>      int i;
> @@ -625,17 +570,31 @@ static void ics_base_reset(DeviceState *dev)
>          ics_reset_irq(ics->irqs + i);
>          ics->irqs[i].flags = flags[i];
>      }
> +
> +    if (kvm_irqchip_in_kernel()) {
> +        Error *local_err = NULL;
> +
> +        ics_set_kvm_state(ICS_BASE(dev), &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +        }
> +    }
> +}
> +
> +static void ics_reset_handler(void *dev)
> +{
> +    ics_reset(dev);
>  }
>  
> -static void ics_base_realize(DeviceState *dev, Error **errp)
> +static void ics_realize(DeviceState *dev, Error **errp)
>  {
>      ICSState *ics = ICS_BASE(dev);
> +    Error *local_err = NULL;
>      Object *obj;
> -    Error *err = NULL;
>  
> -    obj = object_property_get_link(OBJECT(dev), ICS_PROP_XICS, &err);
> +    obj = object_property_get_link(OBJECT(dev), ICS_PROP_XICS, &local_err);
>      if (!obj) {
> -        error_propagate_prepend(errp, err,
> +        error_propagate_prepend(errp, local_err,
>                                  "required link '" ICS_PROP_XICS
>                                  "' not found: ");
>          return;
> @@ -647,8 +606,22 @@ static void ics_base_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>      ics->irqs = g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
> +
> +    qemu_register_reset(ics_reset_handler, ics);
> +}
> +
> +static void ics_simple_class_init(ObjectClass *klass, void *data)
> +{
>  }
>  
> +static const TypeInfo ics_simple_info = {
> +    .name = TYPE_ICS_SIMPLE,
> +    .parent = TYPE_ICS_BASE,
> +    .instance_size = sizeof(ICSState),
> +    .class_init = ics_simple_class_init,
> +    .class_size = sizeof(ICSStateClass),
> +};
> +
>  static void ics_base_instance_init(Object *obj)
>  {
>      ICSState *ics = ICS_BASE(obj);
> @@ -725,9 +698,9 @@ static void ics_base_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
> -    dc->realize = ics_base_realize;
> +    dc->realize = ics_realize;
>      dc->props = ics_base_properties;
> -    dc->reset = ics_base_reset;
> +    dc->reset = ics_reset;
>      dc->vmsd = &vmstate_ics_base;
>  }
>  
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 34d7985b7c..0eb39c2561 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -103,9 +103,6 @@ struct PnvICPState {
>  
>  struct ICSStateClass {
>      DeviceClass parent_class;
> -
> -    DeviceRealize parent_realize;
> -    DeviceReset parent_reset;
>  };
>  
>  struct ICSState {


