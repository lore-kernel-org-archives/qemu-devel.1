Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B06C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:19:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8094217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8094217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDPvT-0004Me-Ud
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 05:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDPth-0003S4-VY
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDPtd-0004Z2-EI
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:17:11 -0400
Received: from 1.mo69.mail-out.ovh.net ([178.33.251.173]:34844)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDPtZ-0004Ro-IA
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:17:08 -0400
Received: from player750.ha.ovh.net (unknown [10.109.143.18])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id D91EB6AA4B
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 11:16:56 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player750.ha.ovh.net (Postfix) with ESMTPSA id 8D42EA56D3E8;
 Thu, 26 Sep 2019 09:16:44 +0000 (UTC)
Date: Thu, 26 Sep 2019 11:16:43 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 19/20] spapr: Use less cryptic representation of which
 irq backends are supported
Message-ID: <20190926111643.54358d3f@bahia.lan>
In-Reply-To: <20190925064534.19155-20-david@gibson.dropbear.id.au>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-20-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9369739028223138278
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeeggddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.251.173
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

On Wed, 25 Sep 2019 16:45:33 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> SpaprIrq::ov5 stores the value for a particular byte in PAPR option vector
> 5 which indicates whether XICS, XIVE or both interrupt controllers are
> available.  As usual for PAPR, the encoding is kind of overly complicated
> and confusing (though to be fair there are some backwards compat things it
> has to handle).
> 
> But to make our internal code clearer, have SpaprIrq encode more directly
> which backends are available as two booleans, and derive the OV5 value from
> that at the point we need it.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c             | 15 ++++++++++++---
>  hw/ppc/spapr_hcall.c       |  6 +++---
>  hw/ppc/spapr_irq.c         | 12 ++++++++----
>  include/hw/ppc/spapr_irq.h |  3 ++-
>  4 files changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 3742a8cf06..795f6ab505 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1136,19 +1136,28 @@ static void spapr_dt_ov5_platform_support(SpaprMachineState *spapr, void *fdt,
>      PowerPCCPU *first_ppc_cpu = POWERPC_CPU(first_cpu);
>  
>      char val[2 * 4] = {
> -        23, spapr->irq->ov5, /* Xive mode. */
> +        23, 0x00, /* XICS / XIVE mode */
>          24, 0x00, /* Hash/Radix, filled in below. */
>          25, 0x00, /* Hash options: Segment Tables == no, GTSE == no. */
>          26, 0x40, /* Radix options: GTSE == yes. */
>      };
>  
> +    if (spapr->irq->xics && spapr->irq->xive) {
> +        val[1] = SPAPR_OV5_XIVE_BOTH;
> +    } else if (spapr->irq->xive) {
> +        val[1] = SPAPR_OV5_XIVE_EXPLOIT;
> +    } else {
> +        assert(spapr->irq->xics);
> +        val[1] = SPAPR_OV5_XIVE_LEGACY;
> +    }
> +
>      if (!ppc_check_compat(first_ppc_cpu, CPU_POWERPC_LOGICAL_3_00, 0,
>                            first_ppc_cpu->compat_pvr)) {
>          /*
>           * If we're in a pre POWER9 compat mode then the guest should
>           * do hash and use the legacy interrupt mode
>           */
> -        val[1] = 0x00; /* XICS */
> +        val[1] = SPAPR_OV5_XIVE_LEGACY; /* XICS */
>          val[3] = 0x00; /* Hash */
>      } else if (kvm_enabled()) {
>          if (kvmppc_has_cap_mmu_radix() && kvmppc_has_cap_mmu_hash_v3()) {
> @@ -2837,7 +2846,7 @@ static void spapr_machine_init(MachineState *machine)
>      spapr_ovec_set(spapr->ov5, OV5_DRMEM_V2);
>  
>      /* advertise XIVE on POWER9 machines */
> -    if (spapr->irq->ov5 & (SPAPR_OV5_XIVE_EXPLOIT | SPAPR_OV5_XIVE_BOTH)) {
> +    if (spapr->irq->xive) {
>          spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
>      }
>  
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 3d3a67149a..140f05c1c6 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1784,13 +1784,13 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>       * terminate the boot.
>       */
>      if (guest_xive) {
> -        if (spapr->irq->ov5 == SPAPR_OV5_XIVE_LEGACY) {
> +        if (!spapr->irq->xive) {
>              error_report(
>  "Guest requested unavailable interrupt mode (XIVE), try the ic-mode=xive or ic-mode=dual machine property");
>              exit(EXIT_FAILURE);
>          }
>      } else {
> -        if (spapr->irq->ov5 == SPAPR_OV5_XIVE_EXPLOIT) {
> +        if (!spapr->irq->xics) {
>              error_report(
>  "Guest requested unavailable interrupt mode (XICS), either don't set the ic-mode machine property or try ic-mode=xics or ic-mode=dual");
>              exit(EXIT_FAILURE);
> @@ -1804,7 +1804,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>       */
>      if (!spapr->cas_reboot) {
>          spapr->cas_reboot = spapr_ovec_test(ov5_updates, OV5_XIVE_EXPLOIT)
> -            && spapr->irq->ov5 & SPAPR_OV5_XIVE_BOTH;
> +            && spapr->irq->xics && spapr->irq->xive;
>      }
>  
>      spapr_ovec_cleanup(ov5_updates);
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index f53544e45e..073f375ba2 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -209,7 +209,8 @@ static void spapr_irq_init_kvm_xics(SpaprMachineState *spapr, Error **errp)
>  SpaprIrq spapr_irq_xics = {
>      .nr_xirqs    = SPAPR_NR_XIRQS,
>      .nr_msis     = SPAPR_NR_MSIS,
> -    .ov5         = SPAPR_OV5_XIVE_LEGACY,
> +    .xics        = true,
> +    .xive        = false,
>  
>      .init        = spapr_irq_init_xics,
>      .claim       = spapr_irq_claim_xics,
> @@ -357,7 +358,8 @@ static void spapr_irq_init_kvm_xive(SpaprMachineState *spapr, Error **errp)
>  SpaprIrq spapr_irq_xive = {
>      .nr_xirqs    = SPAPR_NR_XIRQS,
>      .nr_msis     = SPAPR_NR_MSIS,
> -    .ov5         = SPAPR_OV5_XIVE_EXPLOIT,
> +    .xics        = false,
> +    .xive        = true,
>  
>      .init        = spapr_irq_init_xive,
>      .claim       = spapr_irq_claim_xive,
> @@ -515,7 +517,8 @@ static void spapr_irq_set_irq_dual(void *opaque, int irq, int val)
>  SpaprIrq spapr_irq_dual = {
>      .nr_xirqs    = SPAPR_NR_XIRQS,
>      .nr_msis     = SPAPR_NR_MSIS,
> -    .ov5         = SPAPR_OV5_XIVE_BOTH,
> +    .xics        = true,
> +    .xive        = true,
>  
>      .init        = spapr_irq_init_dual,
>      .claim       = spapr_irq_claim_dual,
> @@ -751,7 +754,8 @@ int spapr_irq_find(SpaprMachineState *spapr, int num, bool align, Error **errp)
>  SpaprIrq spapr_irq_xics_legacy = {
>      .nr_xirqs    = SPAPR_IRQ_XICS_LEGACY_NR_XIRQS,
>      .nr_msis     = SPAPR_IRQ_XICS_LEGACY_NR_XIRQS,
> -    .ov5         = SPAPR_OV5_XIVE_LEGACY,
> +    .xics        = true,
> +    .xive        = false,
>  
>      .init        = spapr_irq_init_xics,
>      .claim       = spapr_irq_claim_xics,
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 75279ca137..6816cb0500 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -39,7 +39,8 @@ void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t num);
>  typedef struct SpaprIrq {
>      uint32_t    nr_xirqs;
>      uint32_t    nr_msis;
> -    uint8_t     ov5;
> +    bool        xics;
> +    bool        xive;
>  
>      void (*init)(SpaprMachineState *spapr, Error **errp);
>      void (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error **errp);


