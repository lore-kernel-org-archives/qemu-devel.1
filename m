Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACB2C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 06:10:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D8FA215EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 06:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8FA215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFXpx-0007gF-Ao
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 02:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iFXol-00070I-SN
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 02:08:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iFXok-0003zg-PN
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 02:08:55 -0400
Received: from 12.mo1.mail-out.ovh.net ([87.98.162.229]:36937)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iFXok-0003yC-Gi
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 02:08:54 -0400
Received: from player756.ha.ovh.net (unknown [10.108.57.95])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 15E8C191ED4
 for <qemu-devel@nongnu.org>; Wed,  2 Oct 2019 08:08:51 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player756.ha.ovh.net (Postfix) with ESMTPSA id EA8719A540C0;
 Wed,  2 Oct 2019 06:08:40 +0000 (UTC)
Date: Wed, 2 Oct 2019 08:08:39 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 19/34] spapr: Add return value to spapr_irq_check()
Message-ID: <20191002080839.7db03b70@bahia.lan>
In-Reply-To: <20191002025208.3487-20-david@gibson.dropbear.id.au>
References: <20191002025208.3487-1-david@gibson.dropbear.id.au>
 <20191002025208.3487-20-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 4535969251507673574
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeehgddutdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.162.229
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

On Wed,  2 Oct 2019 12:51:53 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> Explicitly return success or failure, rather than just relying on the
> Error ** parameter.  This makes handling it less verbose in the caller.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_irq.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 3ac67ba0c7..0413fbd0a3 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -529,7 +529,7 @@ SpaprIrq spapr_irq_dual = {
>  };
>  
>  
> -static void spapr_irq_check(SpaprMachineState *spapr, Error **errp)
> +static int spapr_irq_check(SpaprMachineState *spapr, Error **errp)
>  {
>      MachineState *machine = MACHINE(spapr);
>  
> @@ -545,7 +545,7 @@ static void spapr_irq_check(SpaprMachineState *spapr, Error **errp)
>           */
>          if (spapr->irq == &spapr_irq_dual) {
>              spapr->irq = &spapr_irq_xics;
> -            return;
> +            return 0;
>          }
>  
>          /*
> @@ -565,7 +565,7 @@ static void spapr_irq_check(SpaprMachineState *spapr, Error **errp)
>           */
>          if (spapr->irq == &spapr_irq_xive) {
>              error_setg(errp, "XIVE-only machines require a POWER9 CPU");
> -            return;
> +            return -1;
>          }
>      }
>  
> @@ -579,8 +579,10 @@ static void spapr_irq_check(SpaprMachineState *spapr, Error **errp)
>          machine_kernel_irqchip_required(machine) &&
>          xics_kvm_has_broken_disconnect(spapr)) {
>          error_setg(errp, "KVM is too old to support ic-mode=dual,kernel-irqchip=on");
> -        return;
> +        return -1;
>      }
> +
> +    return 0;
>  }
>  
>  /*
> @@ -589,7 +591,6 @@ static void spapr_irq_check(SpaprMachineState *spapr, Error **errp)
>  void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>  {
>      MachineState *machine = MACHINE(spapr);
> -    Error *local_err = NULL;
>  
>      if (machine_kernel_irqchip_split(machine)) {
>          error_setg(errp, "kernel_irqchip split mode not supported on pseries");
> @@ -602,9 +603,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>          return;
>      }
>  
> -    spapr_irq_check(spapr, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    if (spapr_irq_check(spapr, errp) < 0) {
>          return;
>      }
>  


