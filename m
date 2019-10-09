Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EE8C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F4B6206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F4B6206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIFuW-00042t-B4
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 13:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iI7Tq-0007yO-UF
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 04:38:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iI7Tp-0000Md-DD
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 04:37:58 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:39984)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iI7Tp-0000L0-2i
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 04:37:57 -0400
Received: from player714.ha.ovh.net (unknown [10.109.159.90])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 9FFBF1AEE4F
 for <qemu-devel@nongnu.org>; Wed,  9 Oct 2019 10:37:54 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player714.ha.ovh.net (Postfix) with ESMTPSA id 3822BAAEB6B8;
 Wed,  9 Oct 2019 08:37:40 +0000 (UTC)
Date: Wed, 9 Oct 2019 10:37:38 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v4 19/19] spapr: Work around spurious warnings from vfio
 INTx initialization
Message-ID: <20191009103738.01bc146a@bahia.lan>
In-Reply-To: <20191009060818.29719-20-david@gibson.dropbear.id.au>
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
 <20191009060818.29719-20-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 11268569217915656678
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedriedtgddufeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Jason Wang <jasowang@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 clg@kaod.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  9 Oct 2019 17:08:18 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> Traditional PCI INTx for vfio devices can only perform well if using
> an in-kernel irqchip.  Therefore, vfio_intx_update() issues a warning
> if an in kernel irqchip is not available.
> 

Can you elaborate on what doesn't "perform well" without an
in-kernel irqchip ? Is it a matter of performance or is it
actually broken or something else ?

What is the impact on -machine accel=kvm,kernel-irqchip=off which
always spit this warning ?

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
> index 7964e4a1b8..3aeb523f3e 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -274,6 +274,14 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
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
>  }
>  
>  int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error **errp)
> @@ -429,7 +437,8 @@ void spapr_irq_update_active_intc(SpaprMachineState *spapr)
>           * this.
>           */
>          new_intc = SPAPR_INTC(spapr->xive);
> -    } else if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> +    } else if (spapr->ov5_cas
> +               && spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
>          new_intc = SPAPR_INTC(spapr->xive);
>      } else {
>          new_intc = SPAPR_INTC(spapr->ics);


