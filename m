Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A937C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 17:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 636892146E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 17:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636892146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDAzx-0001Oh-Fk
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 13:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDAu0-0005hJ-SV
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 13:16:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDAtz-0005M2-JA
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 13:16:32 -0400
Received: from 13.mo4.mail-out.ovh.net ([178.33.251.8]:60844)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDAtz-0005LG-Cm
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 13:16:31 -0400
Received: from player789.ha.ovh.net (unknown [10.108.42.5])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 06B3520817F
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 19:16:28 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player789.ha.ovh.net (Postfix) with ESMTPSA id 832DFA2FFFBD;
 Wed, 25 Sep 2019 17:16:18 +0000 (UTC)
Date: Wed, 25 Sep 2019 19:16:17 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 10/20] spapr: Eliminate nr_irqs parameter to SpaprIrq::init
Message-ID: <20190925191617.65acbc68@bahia.lan>
In-Reply-To: <20190925064534.19155-11-david@gibson.dropbear.id.au>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-11-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 11595643143125309926
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedvgdduuddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.251.8
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

On Wed, 25 Sep 2019 16:45:24 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> The only reason this parameter was needed was to work around the
> inconsistent meaning of nr_irqs between xics and xive.  Now that we've
> fixed that, we can consistently use the number directly in the SpaprIrq
> configuration.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_irq.c         | 21 ++++++++++-----------
>  include/hw/ppc/spapr_irq.h |  2 +-
>  2 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 5190a33e08..300c65be3a 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -92,8 +92,7 @@ static void spapr_irq_init_kvm(SpaprMachineState *spapr,
>   * XICS IRQ backend.
>   */
>  
> -static void spapr_irq_init_xics(SpaprMachineState *spapr, int nr_xirqs,
> -                                Error **errp)
> +static void spapr_irq_init_xics(SpaprMachineState *spapr, Error **errp)
>  {
>      Object *obj;
>      Error *local_err = NULL;
> @@ -102,7 +101,8 @@ static void spapr_irq_init_xics(SpaprMachineState *spapr, int nr_xirqs,
>      object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
>      object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
>                                     &error_fatal);
> -    object_property_set_int(obj, nr_xirqs, "nr-irqs",  &error_fatal);
> +    object_property_set_int(obj, spapr->irq->nr_xirqs,
> +                            "nr-irqs",  &error_fatal);
>      object_property_set_bool(obj, true, "realized", &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> @@ -256,15 +256,15 @@ SpaprIrq spapr_irq_xics = {
>  /*
>   * XIVE IRQ backend.
>   */
> -static void spapr_irq_init_xive(SpaprMachineState *spapr, int nr_xirqs,
> -                                Error **errp)
> +static void spapr_irq_init_xive(SpaprMachineState *spapr, Error **errp)
>  {
>      uint32_t nr_servers = spapr_max_server_number(spapr);
>      DeviceState *dev;
>      int i;
>  
>      dev = qdev_create(NULL, TYPE_SPAPR_XIVE);
> -    qdev_prop_set_uint32(dev, "nr-irqs", nr_xirqs + SPAPR_XIRQ_BASE);
> +    qdev_prop_set_uint32(dev, "nr-irqs",
> +                         spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE);
>      /*
>       * 8 XIVE END structures per CPU. One for each available priority
>       */
> @@ -443,18 +443,17 @@ static SpaprIrq *spapr_irq_current(SpaprMachineState *spapr)
>          &spapr_irq_xive : &spapr_irq_xics;
>  }
>  
> -static void spapr_irq_init_dual(SpaprMachineState *spapr, int nr_xirqs,
> -                                Error **errp)
> +static void spapr_irq_init_dual(SpaprMachineState *spapr, Error **errp)
>  {
>      Error *local_err = NULL;
>  
> -    spapr_irq_xics.init(spapr, spapr_irq_xics.nr_xirqs, &local_err);
> +    spapr_irq_xics.init(spapr, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
>      }
>  
> -    spapr_irq_xive.init(spapr, spapr_irq_xive.nr_xirqs, &local_err);
> +    spapr_irq_xive.init(spapr, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> @@ -683,7 +682,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>          spapr_irq_msi_init(spapr, spapr->irq->nr_msis);
>      }
>  
> -    spapr->irq->init(spapr, spapr->irq->nr_xirqs, errp);
> +    spapr->irq->init(spapr, errp);
>  
>      spapr->qirqs = qemu_allocate_irqs(spapr->irq->set_irq, spapr,
>                                        spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE);
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index a8f9a2ab11..7e26288fcd 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -41,7 +41,7 @@ typedef struct SpaprIrq {
>      uint32_t    nr_msis;
>      uint8_t     ov5;
>  
> -    void (*init)(SpaprMachineState *spapr, int nr_irqs, Error **errp);
> +    void (*init)(SpaprMachineState *spapr, Error **errp);
>      int (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error **errp);
>      void (*free)(SpaprMachineState *spapr, int irq, int num);
>      qemu_irq (*qirq)(SpaprMachineState *spapr, int irq);


