Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D5EFA3731
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 08:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA1F20869
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 08:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA1F20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL1Oh-0006gt-IY
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 04:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iL1Nm-0005gH-CB
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 04:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iL1Nk-0005iN-WD
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 04:43:42 -0400
Received: from 5.mo4.mail-out.ovh.net ([188.165.44.50]:56919)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iL1Nk-0005eG-QL
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 04:43:40 -0400
Received: from player711.ha.ovh.net (unknown [10.109.160.62])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 2C41520C2AC
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 10:43:28 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player711.ha.ovh.net (Postfix) with ESMTPSA id C119BAF6D266;
 Thu, 17 Oct 2019 08:43:12 +0000 (UTC)
Subject: Re: [RFC 5/5] spapr: Work around spurious warnings from vfio INTx
 initialization
To: David Gibson <david@gibson.dropbear.id.au>, alex.williamson@redhat.com,
 groug@kaod.org
References: <20191017054218.8876-1-david@gibson.dropbear.id.au>
 <20191017054218.8876-6-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3cded480-ce51-eef7-dc75-686022a18726@kaod.org>
Date: Thu, 17 Oct 2019 10:43:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191017054218.8876-6-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 3003900954685180736
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrjeejgddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.44.50
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
Cc: aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/10/2019 07:42, David Gibson wrote:
> Traditional PCI INTx for vfio devices can only perform well if using
> an in-kernel irqchip.  Therefore, vfio_intx_update() issues a warning
> if an in kernel irqchip is not available.
> 
> We usually do have an in-kernel irqchip available for pseries machines
> on POWER hosts.  However, because the platform allows feature
> negotiation of what interrupt controller model to use, we don't
> currently initialize it until machine reset.  vfio_intx_update() is
> called (first) from vfio_realize() before that, so it can issue a
> spurious warning, even if we will have an in kernel irqchip by the
> time we need it.
> 
> To workaround this, make a call to spapr_irq_update_active_intc() from
> spapr_irq_init() which is called at machine realize time, before the
> vfio realize.  This call will be pretty much obsoleted by the later
> call at reset time, but it serves to suppress the spurious warning
> from VFIO.
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_irq.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 45544b8976..bb91c61fa0 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -345,6 +345,14 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>  
>      spapr->qirqs = qemu_allocate_irqs(spapr_set_irq, spapr,
>                                        smc->nr_xirqs + SPAPR_XIRQ_BASE);
> +
> +    /*
> +     * Mostly we don't actually need this until reset, except that not
> +     * having this set up can cause VFIO devices to issue a
> +     * false-positive warning during realize(), because they don't yet
> +     * have an in-kernel irq chip.
> +     */
> +    spapr_irq_update_active_intc(spapr);

This will call the de/activate hooks of the irq chip very early 
before reset and CAS, and won't call them at reset if the intc
pointers are the same (xive only for instance). It breaks very 
obviously the emulated XIVE device which won't reset the OS CAM 
line with the CPU id values and CPU notification will be broken.

We have to find something else.


>  }
>  
>  int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error **errp)
> @@ -500,7 +508,8 @@ void spapr_irq_update_active_intc(SpaprMachineState *spapr)
>           * this.
>           */
>          new_intc = SPAPR_INTC(spapr->xive);
> -    } else if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> +    } else if (spapr->ov5_cas
> +               && spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {

This change can go in another patch.

C. 

>          new_intc = SPAPR_INTC(spapr->xive);
>      } else {
>          new_intc = SPAPR_INTC(spapr->ics);
> 


