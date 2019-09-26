Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3ABC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:37:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7310222BF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7310222BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDPHG-0005rC-VK
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 04:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDPGB-0004le-0d
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDPG8-0004N0-Fd
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:36:22 -0400
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:49982)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDPG8-00048r-9f
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:36:20 -0400
Received: from player687.ha.ovh.net (unknown [10.109.146.173])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 9D88B7A4EC
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 10:36:15 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id 279C3A360B53;
 Thu, 26 Sep 2019 08:36:03 +0000 (UTC)
Date: Thu, 26 Sep 2019 10:36:02 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 17/20] spapr: Remove unused return value in claim path
Message-ID: <20190926103602.0c948b6f@bahia.lan>
In-Reply-To: <20190925064534.19155-18-david@gibson.dropbear.id.au>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-18-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 8682658608102218214
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeeggddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.76.150
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 clg@kaod.org,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Sep 2019 16:45:31 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> spapr_irq_claim() and the hooks it is based on return an integer error code
> as well as taking an Error ** parameter.  But none of the callers check the
> integer, so we can remove it and just use the richer Error **.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

FYI, the very same topic of using the return value versus Error ** to
check errors was discussed recently in this thread:

https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg04197.html

I tend to agree with Daniel (Cc'd) at first thought, but I don't have a strong
opinion about this yet. It is mostly to inform you that people are currently
discussing/working on it.

>  hw/ppc/spapr_irq.c         | 32 +++++++++++++-------------------
>  include/hw/ppc/spapr_irq.h |  4 ++--
>  2 files changed, 15 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 261d66ba17..2673a90604 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -112,8 +112,8 @@ static void spapr_irq_init_xics(SpaprMachineState *spapr, Error **errp)
>      spapr->ics = ICS_SPAPR(obj);
>  }
>  
> -static int spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, bool lsi,
> -                                Error **errp)
> +static void spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, bool lsi,
> +                                 Error **errp)
>  {
>      ICSState *ics = spapr->ics;
>  
> @@ -122,11 +122,10 @@ static int spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, bool lsi,
>  
>      if (!ics_irq_free(ics, irq - ics->offset)) {
>          error_setg(errp, "IRQ %d is not free", irq);
> -        return -1;
> +        return;
>      }
>  
>      ics_set_irq_type(ics, irq - ics->offset, lsi);
> -    return 0;
>  }
>  
>  static void spapr_irq_free_xics(SpaprMachineState *spapr, int irq)
> @@ -252,14 +251,12 @@ static void spapr_irq_init_xive(SpaprMachineState *spapr, Error **errp)
>      spapr_xive_hcall_init(spapr);
>  }
>  
> -static int spapr_irq_claim_xive(SpaprMachineState *spapr, int irq, bool lsi,
> -                                Error **errp)
> +static void spapr_irq_claim_xive(SpaprMachineState *spapr, int irq, bool lsi,
> +                                 Error **errp)
>  {
>      if (!spapr_xive_irq_claim(spapr->xive, irq, lsi)) {
>          error_setg(errp, "IRQ %d is invalid", irq);
> -        return -1;
>      }
> -    return 0;
>  }
>  
>  static void spapr_irq_free_xive(SpaprMachineState *spapr, int irq)
> @@ -406,25 +403,22 @@ static void spapr_irq_init_dual(SpaprMachineState *spapr, Error **errp)
>      }
>  }
>  
> -static int spapr_irq_claim_dual(SpaprMachineState *spapr, int irq, bool lsi,
> -                                Error **errp)
> +static void spapr_irq_claim_dual(SpaprMachineState *spapr, int irq, bool lsi,
> +                                 Error **errp)
>  {
>      Error *local_err = NULL;
> -    int ret;
>  
> -    ret = spapr_irq_xics.claim(spapr, irq, lsi, &local_err);
> +    spapr_irq_xics.claim(spapr, irq, lsi, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> -        return ret;
> +        return;
>      }
>  
> -    ret = spapr_irq_xive.claim(spapr, irq, lsi, &local_err);
> +    spapr_irq_xive.claim(spapr, irq, lsi, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> -        return ret;
> +        return;
>      }
> -
> -    return ret;
>  }
>  
>  static void spapr_irq_free_dual(SpaprMachineState *spapr, int irq)
> @@ -622,12 +616,12 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>                                        spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE);
>  }
>  
> -int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error **errp)
> +void spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error **errp)
>  {
>      assert(irq >= SPAPR_XIRQ_BASE);
>      assert(irq < (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
>  
> -    return spapr->irq->claim(spapr, irq, lsi, errp);
> +    spapr->irq->claim(spapr, irq, lsi, errp);
>  }
>  
>  void spapr_irq_free(SpaprMachineState *spapr, int irq, int num)
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index ed88b4599a..75279ca137 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -42,7 +42,7 @@ typedef struct SpaprIrq {
>      uint8_t     ov5;
>  
>      void (*init)(SpaprMachineState *spapr, Error **errp);
> -    int (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error **errp);
> +    void (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error **errp);
>      void (*free)(SpaprMachineState *spapr, int irq);
>      void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
>      void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
> @@ -61,7 +61,7 @@ extern SpaprIrq spapr_irq_xive;
>  extern SpaprIrq spapr_irq_dual;
>  
>  void spapr_irq_init(SpaprMachineState *spapr, Error **errp);
> -int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error **errp);
> +void spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error **errp);
>  void spapr_irq_free(SpaprMachineState *spapr, int irq, int num);
>  qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq);
>  int spapr_irq_post_load(SpaprMachineState *spapr, int version_id);


