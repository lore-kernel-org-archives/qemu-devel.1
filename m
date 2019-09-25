Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6005C4320D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 08:42:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5F2214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 08:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5F2214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD2t0-0000RQ-Eo
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 04:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iD2rD-0007VD-En
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iD2rB-0004M1-Sb
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:41:07 -0400
Received: from 2.mo173.mail-out.ovh.net ([178.33.251.49]:36442)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iD2rB-0004LI-Lr
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:41:05 -0400
Received: from player779.ha.ovh.net (unknown [10.109.143.249])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 623D011ABF3
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 10:41:03 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player779.ha.ovh.net (Postfix) with ESMTPSA id 6BC93A193D32;
 Wed, 25 Sep 2019 08:40:52 +0000 (UTC)
Date: Wed, 25 Sep 2019 10:40:50 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 06/20] xics: Create sPAPR specific ICS subtype
Message-ID: <20190925104050.072877f1@bahia.lan>
In-Reply-To: <20190925064534.19155-7-david@gibson.dropbear.id.au>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-7-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2890748012287531494
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedvgddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.251.49
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
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Sep 2019 16:45:20 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> We create a subtype of TYPE_ICS specifically for sPAPR.  For now all this
> does is move the setup of the PAPR specific hcalls and RTAS calls to
> the realize() function for this, rather than requiring the PAPR code to
> explicitly call xics_spapr_init().  In future it will have some more
> function.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

LGTM, but for extra safety I would also introduce a SpaprIcsState typedef
and use it everywhere where we only expect this subtype. Especially in
the definition of SpaprMachineState.

>  hw/intc/xics_spapr.c        | 34 +++++++++++++++++++++++++++++++++-
>  hw/ppc/spapr_irq.c          |  6 ++----
>  include/hw/ppc/xics_spapr.h |  4 +++-
>  3 files changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 3e9444813a..e6dd004587 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -283,8 +283,18 @@ static void rtas_int_on(PowerPCCPU *cpu, SpaprMachineState *spapr,
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
>  
> -void xics_spapr_init(SpaprMachineState *spapr)
> +static void ics_spapr_realize(DeviceState *dev, Error **errp)
>  {
> +    ICSState *ics = ICS_SPAPR(dev);
> +    ICSStateClass *icsc = ICS_GET_CLASS(ics);
> +    Error *local_err = NULL;
> +
> +    icsc->parent_realize(dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
>      spapr_rtas_register(RTAS_IBM_SET_XIVE, "ibm,set-xive", rtas_set_xive);
>      spapr_rtas_register(RTAS_IBM_GET_XIVE, "ibm,get-xive", rtas_get_xive);
>      spapr_rtas_register(RTAS_IBM_INT_OFF, "ibm,int-off", rtas_int_off);
> @@ -319,3 +329,25 @@ void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void *fdt,
>      _FDT(fdt_setprop_cell(fdt, node, "linux,phandle", phandle));
>      _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
>  }
> +
> +static void ics_spapr_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ICSStateClass *isc = ICS_CLASS(klass);
> +
> +    device_class_set_parent_realize(dc, ics_spapr_realize,
> +                                    &isc->parent_realize);
> +}
> +
> +static const TypeInfo ics_spapr_info = {
> +    .name = TYPE_ICS_SPAPR,
> +    .parent = TYPE_ICS,
> +    .class_init = ics_spapr_class_init,
> +};
> +
> +static void xics_spapr_register_types(void)
> +{
> +    type_register_static(&ics_spapr_info);
> +}
> +
> +type_init(xics_spapr_register_types)
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 6c45d2a3c0..8c26fa2d1e 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -98,7 +98,7 @@ static void spapr_irq_init_xics(SpaprMachineState *spapr, int nr_irqs,
>      Object *obj;
>      Error *local_err = NULL;
>  
> -    obj = object_new(TYPE_ICS);
> +    obj = object_new(TYPE_ICS_SPAPR);
>      object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
>      object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
>                                     &error_fatal);
> @@ -109,9 +109,7 @@ static void spapr_irq_init_xics(SpaprMachineState *spapr, int nr_irqs,
>          return;
>      }
>  
> -    spapr->ics = ICS(obj);
> -
> -    xics_spapr_init(spapr);
> +    spapr->ics = ICS_SPAPR(obj);
>  }
>  
>  static int spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, bool lsi,
> diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
> index 5dabc9a138..691a6d00f7 100644
> --- a/include/hw/ppc/xics_spapr.h
> +++ b/include/hw/ppc/xics_spapr.h
> @@ -31,11 +31,13 @@
>  
>  #define XICS_NODENAME "interrupt-controller"
>  
> +#define TYPE_ICS_SPAPR "ics-spapr"
> +#define ICS_SPAPR(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SPAPR)
> +
>  void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void *fdt,
>                     uint32_t phandle);
>  int xics_kvm_connect(SpaprMachineState *spapr, Error **errp);
>  void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp);
>  bool xics_kvm_has_broken_disconnect(SpaprMachineState *spapr);
> -void xics_spapr_init(SpaprMachineState *spapr);
>  
>  #endif /* XICS_SPAPR_H */


