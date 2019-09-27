Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ACAC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 10:05:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2EBD217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 10:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2EBD217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDn7b-0000wC-TQ
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 06:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDmvd-00053k-JC
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDmvc-0005GO-53
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:52:45 -0400
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:54663)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDmvb-00056r-TY
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:52:44 -0400
Received: from player786.ha.ovh.net (unknown [10.108.54.237])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 2828D11B05C
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 11:52:40 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id BC085A6124BD;
 Fri, 27 Sep 2019 09:52:29 +0000 (UTC)
Date: Fri, 27 Sep 2019 11:52:28 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 20/33] spapr, xics, xive: Introduce
 SpaprInterruptController QOM interface
Message-ID: <20190927115228.176b0b26@bahia.lan>
In-Reply-To: <20190927055028.11493-21-david@gibson.dropbear.id.au>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-21-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 15845915288956803558
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeeigddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.111.180
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

On Fri, 27 Sep 2019 15:50:15 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> The SpaprIrq structure is used to represent ths spapr machine's irq
> backend.  Except that it kind of conflates two concepts: one is the
> backend proper - a specific interrupt controller that we might or
> might not be using, the other is the irq configuration which covers
> the layout of irq space and which interrupt controllers are allowed.
> 
> This leads to some pretty confusing code paths for the "dual"
> configuration where its hooks redirect to other SpaprIrq structures
> depending on the currently active irq controller.
> 
> To clean this up, we start by introducing a new
> SpaprInterruptController QOM interface to represent strictly an
> interrupt controller backend, not counting anything configuration
> related.  We implement this interface in the XICs and XIVE interrupt
> controllers, and in future we'll move relevant methods from SpaprIrq
> into it.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/intc/spapr_xive.c       |  4 ++++
>  hw/intc/xics_spapr.c       |  4 ++++
>  hw/ppc/spapr_irq.c         | 13 +++++++++++++
>  include/hw/ppc/spapr_irq.h | 14 ++++++++++++++
>  4 files changed, 35 insertions(+)
> 
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 04879abf2e..b67e9c3245 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -519,6 +519,10 @@ static const TypeInfo spapr_xive_info = {
>      .instance_init = spapr_xive_instance_init,
>      .instance_size = sizeof(SpaprXive),
>      .class_init = spapr_xive_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_SPAPR_INTC },
> +        { }
> +    },
>  };
>  
>  static void spapr_xive_register_types(void)
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 6e5eb24b3c..4874e6be55 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -343,6 +343,10 @@ static const TypeInfo ics_spapr_info = {
>      .name = TYPE_ICS_SPAPR,
>      .parent = TYPE_ICS,
>      .class_init = ics_spapr_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_SPAPR_INTC },
> +        { }
> +    },
>  };
>  
>  static void xics_spapr_register_types(void)
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 5e448b1fd4..0603c82fe8 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -23,6 +23,12 @@
>  
>  #include "trace.h"
>  
> +static const TypeInfo spapr_intc_info = {
> +    .name = TYPE_SPAPR_INTC,
> +    .parent = TYPE_INTERFACE,
> +    .class_size = sizeof(SpaprInterruptControllerClass),
> +};
> +
>  void spapr_irq_msi_init(SpaprMachineState *spapr, uint32_t nr_msis)
>  {
>      spapr->irq_map_nr = nr_msis;
> @@ -763,3 +769,10 @@ SpaprIrq spapr_irq_xics_legacy = {
>      .set_irq     = spapr_irq_set_irq_xics,
>      .init_kvm    = spapr_irq_init_kvm_xics,
>  };
> +
> +static void spapr_irq_register_types(void)
> +{
> +    type_register_static(&spapr_intc_info);
> +}
> +
> +type_init(spapr_irq_register_types)
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 69a37f608e..b9398e0be3 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -31,6 +31,20 @@
>  
>  typedef struct SpaprMachineState SpaprMachineState;
>  
> +typedef struct SpaprInterruptController SpaprInterruptController;
> +
> +#define TYPE_SPAPR_INTC "spapr-interrupt-controller"
> +#define SPAPR_INTC(obj)                                     \
> +    INTERFACE_CHECK(SpaprInterruptController, (obj), TYPE_SPAPR_INTC)
> +#define SPAPR_INTC_CLASS(klass)                                     \
> +    OBJECT_CLASS_CHECK(SpaprInterruptControllerClass, (klass), TYPE_SPAPR_INTC)
> +#define SPAPR_INTC_GET_CLASS(obj)                                   \
> +    OBJECT_GET_CLASS(SpaprInterruptControllerClass, (obj), TYPE_SPAPR_INTC)
> +
> +typedef struct SpaprInterruptControllerClass {
> +    InterfaceClass parent;
> +} SpaprInterruptControllerClass;
> +
>  void spapr_irq_msi_init(SpaprMachineState *spapr, uint32_t nr_msis);
>  int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool align,
>                          Error **errp);


