Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9459FC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 15:42:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D6BD21D56
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 15:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6BD21D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDVuu-0001nX-1V
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 11:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDVs6-0008Hi-Tj
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:40:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDVs3-0006jR-NU
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:39:57 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:55291)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDVs3-0006eY-GW
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:39:55 -0400
Received: from player731.ha.ovh.net (unknown [10.109.159.139])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 06AA81AB9CE
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 17:39:48 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player731.ha.ovh.net (Postfix) with ESMTPSA id DEEE2A17647A;
 Thu, 26 Sep 2019 15:39:38 +0000 (UTC)
Date: Thu, 26 Sep 2019 17:39:37 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 20/20] spapr: Eliminate SpaprIrq::init hook
Message-ID: <20190926173937.302ec223@bahia.lan>
In-Reply-To: <20190925064534.19155-21-david@gibson.dropbear.id.au>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-21-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 15835782191209421286
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeeggdeltdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.165.38
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

On Wed, 25 Sep 2019 16:45:34 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> This method is used to set up the interrupt backends for the current
> configuration.  However, this means some confusing redirection between
> the "dual" mode init and the init hooks for xics only and xive only modes.
> 
> Since we now have simple flags indicating whether XICS and/or XIVE are
> supported, it's easier to just open code each initialization directly in
> spapr_irq_init().  This will also make some future cleanups simpler.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_irq.c          | 138 ++++++++++++++++--------------------
>  include/hw/ppc/spapr_irq.h  |   1 -
>  include/hw/ppc/xics_spapr.h |   1 +
>  3 files changed, 63 insertions(+), 77 deletions(-)
> 
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 073f375ba2..62647dd5a3 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -91,27 +91,6 @@ static void spapr_irq_init_kvm(SpaprMachineState *spapr,
>  /*
>   * XICS IRQ backend.
>   */
> -
> -static void spapr_irq_init_xics(SpaprMachineState *spapr, Error **errp)
> -{
> -    Object *obj;
> -    Error *local_err = NULL;
> -
> -    obj = object_new(TYPE_ICS_SPAPR);
> -    object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
> -    object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
> -                                   &error_fatal);
> -    object_property_set_int(obj, spapr->irq->nr_xirqs,
> -                            "nr-irqs",  &error_fatal);
> -    object_property_set_bool(obj, true, "realized", &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
> -    spapr->ics = ICS_SPAPR(obj);
> -}
> -
>  static void spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, bool lsi,
>                                   Error **errp)
>  {
> @@ -212,7 +191,6 @@ SpaprIrq spapr_irq_xics = {
>      .xics        = true,
>      .xive        = false,
>  
> -    .init        = spapr_irq_init_xics,
>      .claim       = spapr_irq_claim_xics,
>      .free        = spapr_irq_free_xics,
>      .print_info  = spapr_irq_print_info_xics,
> @@ -227,37 +205,6 @@ SpaprIrq spapr_irq_xics = {
>  /*
>   * XIVE IRQ backend.
>   */
> -static void spapr_irq_init_xive(SpaprMachineState *spapr, Error **errp)
> -{
> -    uint32_t nr_servers = spapr_max_server_number(spapr);
> -    DeviceState *dev;
> -    int i;
> -
> -    dev = qdev_create(NULL, TYPE_SPAPR_XIVE);
> -    qdev_prop_set_uint32(dev, "nr-irqs",
> -                         spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE);
> -    /*
> -     * 8 XIVE END structures per CPU. One for each available priority
> -     */
> -    qdev_prop_set_uint32(dev, "nr-ends", nr_servers << 3);
> -    qdev_init_nofail(dev);
> -
> -    spapr->xive = SPAPR_XIVE(dev);
> -
> -    /* Enable the CPU IPIs */
> -    for (i = 0; i < nr_servers; ++i) {
> -        Error *local_err = NULL;
> -
> -        spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i, false, &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> -    }
> -
> -    spapr_xive_hcall_init(spapr);
> -}
> -
>  static void spapr_irq_claim_xive(SpaprMachineState *spapr, int irq, bool lsi,
>                                   Error **errp)
>  {
> @@ -361,7 +308,6 @@ SpaprIrq spapr_irq_xive = {
>      .xics        = false,
>      .xive        = true,
>  
> -    .init        = spapr_irq_init_xive,
>      .claim       = spapr_irq_claim_xive,
>      .free        = spapr_irq_free_xive,
>      .print_info  = spapr_irq_print_info_xive,
> @@ -392,23 +338,6 @@ static SpaprIrq *spapr_irq_current(SpaprMachineState *spapr)
>          &spapr_irq_xive : &spapr_irq_xics;
>  }
>  
> -static void spapr_irq_init_dual(SpaprMachineState *spapr, Error **errp)
> -{
> -    Error *local_err = NULL;
> -
> -    spapr_irq_xics.init(spapr, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
> -    spapr_irq_xive.init(spapr, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -}
> -
>  static void spapr_irq_claim_dual(SpaprMachineState *spapr, int irq, bool lsi,
>                                   Error **errp)
>  {
> @@ -520,7 +449,6 @@ SpaprIrq spapr_irq_dual = {
>      .xics        = true,
>      .xive        = true,
>  
> -    .init        = spapr_irq_init_dual,
>      .claim       = spapr_irq_claim_dual,
>      .free        = spapr_irq_free_dual,
>      .print_info  = spapr_irq_print_info_dual,
> @@ -608,8 +536,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>  
>      spapr_irq_check(spapr, &local_err);
>      if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> +        goto out;
>      }
>  
>      /* Initialize the MSI IRQ allocator. */
> @@ -617,10 +544,70 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>          spapr_irq_msi_init(spapr, spapr->irq->nr_msis);
>      }
>  
> -    spapr->irq->init(spapr, errp);
> +    if (spapr->irq->xics) {
> +        Object *obj;
> +
> +        obj = object_new(TYPE_ICS_SPAPR);
> +        object_property_add_child(OBJECT(spapr), "ics", obj, &local_err);
> +        if (local_err) {
> +            goto out;
> +        }
> +
> +        object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
> +                                       &local_err);
> +        if (local_err) {
> +            goto out;
> +        }
> +
> +        object_property_set_int(obj, spapr->irq->nr_xirqs, "nr-irqs",
> +                                &local_err);
> +        if (local_err) {
> +            goto out;
> +        }
> +
> +        object_property_set_bool(obj, true, "realized", &local_err);
> +        if (local_err) {
> +            goto out;
> +        }
> +
> +        spapr->ics = ICS_SPAPR(obj);
> +    }
> +
> +    if (spapr->irq->xive) {
> +        uint32_t nr_servers = spapr_max_server_number(spapr);
> +        DeviceState *dev;
> +        int i;
> +
> +        dev = qdev_create(NULL, TYPE_SPAPR_XIVE);
> +        qdev_prop_set_uint32(dev, "nr-irqs",
> +                             spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE);
> +        /*
> +         * 8 XIVE END structures per CPU. One for each available
> +         * priority
> +         */
> +        qdev_prop_set_uint32(dev, "nr-ends", nr_servers << 3);
> +        qdev_init_nofail(dev);
> +
> +        spapr->xive = SPAPR_XIVE(dev);
> +
> +        /* Enable the CPU IPIs */
> +        for (i = 0; i < nr_servers; ++i) {
> +            Error *local_err = NULL;
> +
> +            spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i, false, &local_err);
> +            if (local_err) {
> +                goto out;
> +            }
> +        }
> +
> +        spapr_xive_hcall_init(spapr);
> +    }
>  
>      spapr->qirqs = qemu_allocate_irqs(spapr->irq->set_irq, spapr,
>                                        spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE);
> +
> +out:
> +    error_propagate(errp, local_err);
>  }
>  
>  void spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error **errp)
> @@ -757,7 +744,6 @@ SpaprIrq spapr_irq_xics_legacy = {
>      .xics        = true,
>      .xive        = false,
>  
> -    .init        = spapr_irq_init_xics,
>      .claim       = spapr_irq_claim_xics,
>      .free        = spapr_irq_free_xics,
>      .print_info  = spapr_irq_print_info_xics,
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 6816cb0500..fa862c665b 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -42,7 +42,6 @@ typedef struct SpaprIrq {
>      bool        xics;
>      bool        xive;
>  
> -    void (*init)(SpaprMachineState *spapr, Error **errp);
>      void (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error **errp);
>      void (*free)(SpaprMachineState *spapr, int irq);
>      void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
> diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
> index 691a6d00f7..267984a97b 100644
> --- a/include/hw/ppc/xics_spapr.h
> +++ b/include/hw/ppc/xics_spapr.h
> @@ -34,6 +34,7 @@
>  #define TYPE_ICS_SPAPR "ics-spapr"
>  #define ICS_SPAPR(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SPAPR)
>  
> +void ics_spapr_create(SpaprMachineState *spapr, int nr_xirqs, Error **errp);
>  void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void *fdt,
>                     uint32_t phandle);
>  int xics_kvm_connect(SpaprMachineState *spapr, Error **errp);


