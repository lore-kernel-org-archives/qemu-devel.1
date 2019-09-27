Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF583C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1220217D9
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1220217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDsqG-0005Z6-BJ
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 12:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDrnM-0006JE-7m
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 11:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDrnJ-0005AX-Al
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 11:04:31 -0400
Received: from 15.mo4.mail-out.ovh.net ([91.121.62.11]:36734)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDrnI-0005A9-Qc
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 11:04:29 -0400
Received: from player688.ha.ovh.net (unknown [10.109.146.213])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 4F2ED2091FB
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 17:04:26 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id 67AAAA3D903E;
 Fri, 27 Sep 2019 15:04:14 +0000 (UTC)
Date: Fri, 27 Sep 2019 17:04:13 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 28/33] spapr: Remove SpaprIrq::init_kvm hook
Message-ID: <20190927170413.61d85376@bahia.lan>
In-Reply-To: <20190927055028.11493-29-david@gibson.dropbear.id.au>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-29-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2664160656707459558
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeeigdekvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.121.62.11
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

On Fri, 27 Sep 2019 15:50:23 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> This hook is a bit odd.  The only caller is spapr_irq_init_kvm(), but
> it explicitly takes an SpaprIrq *, so it's never really called through the
> current SpaprIrq.  Essentially this is just a way of passing through a
> function pointer so that spapr_irq_init_kvm() can handle some
> configuration and error handling logic without duplicating it between the
> xics and xive reset paths.
> 
> So, make it just take that function pointer.  Because of earlier reworks
> to the KVM connect/disconnect code in the xics and xive backends we can
> also eliminate some wrapper functions and streamline error handling a bit.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_irq.c         | 74 +++++++++++++-------------------------
>  include/hw/ppc/spapr_irq.h |  1 -
>  2 files changed, 25 insertions(+), 50 deletions(-)
> 
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 561bdbc4de..c6abebc4ef 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -65,33 +65,35 @@ void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t num)
>      bitmap_clear(spapr->irq_map, irq - SPAPR_IRQ_MSI, num);
>  }
>  
> -static void spapr_irq_init_kvm(SpaprMachineState *spapr,
> -                                  SpaprIrq *irq, Error **errp)
> +static int spapr_irq_init_kvm(int (*fn)(SpaprInterruptController *, Error **),
> +                              SpaprInterruptController *intc,
> +                              Error **errp)
>  {
> -    MachineState *machine = MACHINE(spapr);
> +    MachineState *machine = MACHINE(qdev_get_machine());
>      Error *local_err = NULL;
>  
>      if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
> -        irq->init_kvm(spapr, &local_err);
> -        if (local_err && machine_kernel_irqchip_required(machine)) {
> -            error_prepend(&local_err,
> -                          "kernel_irqchip requested but unavailable: ");
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> +        if (fn(intc, &local_err) < 0) {
> +            if (machine_kernel_irqchip_required(machine)) {
> +                error_prepend(&local_err,
> +                              "kernel_irqchip requested but unavailable: ");
> +                error_propagate(errp, local_err);
> +                return -1;
> +            }
>  
> -        if (!local_err) {
> -            return;
> +            /*
> +             * We failed to initialize the KVM device, fallback to
> +             * emulated mode
> +             */
> +            error_prepend(&local_err,
> +                          "kernel_irqchip allowed but unavailable: ");
> +            error_append_hint(&local_err,
> +                              "Falling back to kernel-irqchip=off\n");
> +            warn_report_err(local_err);
>          }
> -
> -        /*
> -         * We failed to initialize the KVM device, fallback to
> -         * emulated mode
> -         */
> -        error_prepend(&local_err, "kernel_irqchip allowed but unavailable: ");
> -        error_append_hint(&local_err, "Falling back to kernel-irqchip=off\n");
> -        warn_report_err(local_err);
>      }
> +
> +    return 0;
>  }
>  
>  /*
> @@ -112,20 +114,7 @@ static int spapr_irq_post_load_xics(SpaprMachineState *spapr, int version_id)
>  
>  static void spapr_irq_reset_xics(SpaprMachineState *spapr, Error **errp)
>  {
> -    Error *local_err = NULL;
> -
> -    spapr_irq_init_kvm(spapr, &spapr_irq_xics, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -}
> -
> -static void spapr_irq_init_kvm_xics(SpaprMachineState *spapr, Error **errp)
> -{
> -    if (kvm_enabled()) {
> -        xics_kvm_connect(SPAPR_INTC(spapr->ics), errp);
> -    }
> +    spapr_irq_init_kvm(xics_kvm_connect, SPAPR_INTC(spapr->ics), errp);
>  }
>  
>  SpaprIrq spapr_irq_xics = {
> @@ -136,7 +125,6 @@ SpaprIrq spapr_irq_xics = {
>  
>      .post_load   = spapr_irq_post_load_xics,
>      .reset       = spapr_irq_reset_xics,
> -    .init_kvm    = spapr_irq_init_kvm_xics,
>  };
>  
>  /*
> @@ -151,7 +139,6 @@ static int spapr_irq_post_load_xive(SpaprMachineState *spapr, int version_id)
>  static void spapr_irq_reset_xive(SpaprMachineState *spapr, Error **errp)
>  {
>      CPUState *cs;
> -    Error *local_err = NULL;
>  
>      CPU_FOREACH(cs) {
>          PowerPCCPU *cpu = POWERPC_CPU(cs);
> @@ -160,9 +147,8 @@ static void spapr_irq_reset_xive(SpaprMachineState *spapr, Error **errp)
>          spapr_xive_set_tctx_os_cam(spapr_cpu_state(cpu)->tctx);
>      }
>  
> -    spapr_irq_init_kvm(spapr, &spapr_irq_xive, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    if (spapr_irq_init_kvm(kvmppc_xive_connect,
> +                           SPAPR_INTC(spapr->xive), errp) < 0) {
>          return;
>      }
>  
> @@ -170,13 +156,6 @@ static void spapr_irq_reset_xive(SpaprMachineState *spapr, Error **errp)
>      spapr_xive_mmio_set_enabled(spapr->xive, true);
>  }
>  
> -static void spapr_irq_init_kvm_xive(SpaprMachineState *spapr, Error **errp)
> -{
> -    if (kvm_enabled()) {
> -        kvmppc_xive_connect(SPAPR_INTC(spapr->xive), errp);
> -    }
> -}
> -
>  SpaprIrq spapr_irq_xive = {
>      .nr_xirqs    = SPAPR_NR_XIRQS,
>      .nr_msis     = SPAPR_NR_MSIS,
> @@ -185,7 +164,6 @@ SpaprIrq spapr_irq_xive = {
>  
>      .post_load   = spapr_irq_post_load_xive,
>      .reset       = spapr_irq_reset_xive,
> -    .init_kvm    = spapr_irq_init_kvm_xive,
>  };
>  
>  /*
> @@ -251,7 +229,6 @@ SpaprIrq spapr_irq_dual = {
>  
>      .post_load   = spapr_irq_post_load_dual,
>      .reset       = spapr_irq_reset_dual,
> -    .init_kvm    = NULL, /* should not be used */
>  };
>  
>  
> @@ -682,7 +659,6 @@ SpaprIrq spapr_irq_xics_legacy = {
>  
>      .post_load   = spapr_irq_post_load_xics,
>      .reset       = spapr_irq_reset_xics,
> -    .init_kvm    = spapr_irq_init_kvm_xics,
>  };
>  
>  static void spapr_irq_register_types(void)
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index c82724fc2b..c947f40571 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -85,7 +85,6 @@ typedef struct SpaprIrq {
>  
>      int (*post_load)(SpaprMachineState *spapr, int version_id);
>      void (*reset)(SpaprMachineState *spapr, Error **errp);
> -    void (*init_kvm)(SpaprMachineState *spapr, Error **errp);
>  } SpaprIrq;
>  
>  extern SpaprIrq spapr_irq_xics;


