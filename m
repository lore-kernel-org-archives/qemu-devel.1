Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07078C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 09:52:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA17221783
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 09:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA17221783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFbIc-0007gp-RG
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 05:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iFbHq-00079q-Cg
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 05:51:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iFbHo-0004NH-OQ
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 05:51:10 -0400
Received: from 9.mo4.mail-out.ovh.net ([46.105.40.176]:40805)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iFbHo-0004MF-H4
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 05:51:08 -0400
Received: from player779.ha.ovh.net (unknown [10.109.160.153])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 9AB19209A0C
 for <qemu-devel@nongnu.org>; Wed,  2 Oct 2019 11:51:04 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player779.ha.ovh.net (Postfix) with ESMTPSA id D10D9A5F648F;
 Wed,  2 Oct 2019 09:50:51 +0000 (UTC)
Date: Wed, 2 Oct 2019 11:50:50 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 31/34] spapr, xics, xive: Move SpaprIrq::post_load
 hook to backends
Message-ID: <20191002115050.052cb2fe@bahia.lan>
In-Reply-To: <20191002025208.3487-32-david@gibson.dropbear.id.au>
References: <20191002025208.3487-1-david@gibson.dropbear.id.au>
 <20191002025208.3487-32-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 8288593639687887334
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeeigddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.40.176
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

On Wed,  2 Oct 2019 12:52:05 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> The remaining logic in the post_load hook really belongs to the interrupt
> controller backends, and just needs to be called on the active controller
> (after the active controller is set to the right thing based on the
> incoming migration in the generic spapr_irq_post_load() logic).
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/intc/spapr_xive.c        |  5 +++--
>  hw/intc/xics_spapr.c        | 13 +++++++++++
>  hw/ppc/spapr_irq.c          | 45 ++++---------------------------------
>  include/hw/ppc/spapr_irq.h  |  3 +--
>  include/hw/ppc/spapr_xive.h |  1 -
>  5 files changed, 21 insertions(+), 46 deletions(-)
> 
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index e8b946982c..ab68e6eaf6 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -462,10 +462,10 @@ static int vmstate_spapr_xive_pre_save(void *opaque)
>   * Called by the sPAPR IRQ backend 'post_load' method at the machine
>   * level.
>   */
> -int spapr_xive_post_load(SpaprXive *xive, int version_id)
> +static int spapr_xive_post_load(SpaprInterruptController *intc, int version_id)
>  {
>      if (kvm_irqchip_in_kernel()) {
> -        return kvmppc_xive_post_load(xive, version_id);
> +        return kvmppc_xive_post_load(SPAPR_XIVE(intc), version_id);
>      }
>  
>      return 0;
> @@ -699,6 +699,7 @@ static void spapr_xive_class_init(ObjectClass *klass, void *data)
>      sicc->set_irq = spapr_xive_set_irq;
>      sicc->print_info = spapr_xive_print_info;
>      sicc->dt = spapr_xive_dt;
> +    sicc->post_load = spapr_xive_post_load;
>  }
>  
>  static const TypeInfo spapr_xive_info = {
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 8abbc799ba..9590eedc3d 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -395,6 +395,18 @@ static void xics_spapr_print_info(SpaprInterruptController *intc, Monitor *mon)
>      ics_pic_print_info(ics, mon);
>  }
>  
> +static int xics_spapr_post_load(SpaprInterruptController *intc, int version_id)
> +{
> +    if (!kvm_irqchip_in_kernel()) {
> +        CPUState *cs;
> +        CPU_FOREACH(cs) {
> +            PowerPCCPU *cpu = POWERPC_CPU(cs);
> +            icp_resend(spapr_cpu_state(cpu)->icp);
> +        }
> +    }
> +    return 0;
> +}
> +
>  static void xics_spapr_activate(SpaprInterruptController *intc, Error **errp)
>  {
>      if (kvm_enabled()) {
> @@ -425,6 +437,7 @@ static void ics_spapr_class_init(ObjectClass *klass, void *data)
>      sicc->set_irq = xics_spapr_set_irq;
>      sicc->print_info = xics_spapr_print_info;
>      sicc->dt = xics_spapr_dt;
> +    sicc->post_load = xics_spapr_post_load;
>  }
>  
>  static const TypeInfo ics_spapr_info = {
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index f70b331f44..f3d18b1dad 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -100,43 +100,22 @@ int spapr_irq_init_kvm(int (*fn)(SpaprInterruptController *, Error **),
>   * XICS IRQ backend.
>   */
>  
> -static int spapr_irq_post_load_xics(SpaprMachineState *spapr, int version_id)
> -{
> -    if (!kvm_irqchip_in_kernel()) {
> -        CPUState *cs;
> -        CPU_FOREACH(cs) {
> -            PowerPCCPU *cpu = POWERPC_CPU(cs);
> -            icp_resend(spapr_cpu_state(cpu)->icp);
> -        }
> -    }
> -    return 0;
> -}
> -
>  SpaprIrq spapr_irq_xics = {
>      .nr_xirqs    = SPAPR_NR_XIRQS,
>      .nr_msis     = SPAPR_NR_MSIS,
>      .xics        = true,
>      .xive        = false,
> -
> -    .post_load   = spapr_irq_post_load_xics,
>  };
>  
>  /*
>   * XIVE IRQ backend.
>   */
>  
> -static int spapr_irq_post_load_xive(SpaprMachineState *spapr, int version_id)
> -{
> -    return spapr_xive_post_load(spapr->xive, version_id);
> -}
> -
>  SpaprIrq spapr_irq_xive = {
>      .nr_xirqs    = SPAPR_NR_XIRQS,
>      .nr_msis     = SPAPR_NR_MSIS,
>      .xics        = false,
>      .xive        = true,
> -
> -    .post_load   = spapr_irq_post_load_xive,
>  };
>  
>  /*
> @@ -148,21 +127,6 @@ SpaprIrq spapr_irq_xive = {
>   * activated after an extra machine reset.
>   */
>  
> -/*
> - * Returns the sPAPR IRQ backend negotiated by CAS. XICS is the
> - * default.
> - */
> -static SpaprIrq *spapr_irq_current(SpaprMachineState *spapr)
> -{
> -    return spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT) ?
> -        &spapr_irq_xive : &spapr_irq_xics;
> -}
> -
> -static int spapr_irq_post_load_dual(SpaprMachineState *spapr, int version_id)
> -{
> -    return spapr_irq_current(spapr)->post_load(spapr, version_id);
> -}
> -
>  /*
>   * Define values in sync with the XIVE and XICS backend
>   */
> @@ -171,8 +135,6 @@ SpaprIrq spapr_irq_dual = {
>      .nr_msis     = SPAPR_NR_MSIS,
>      .xics        = true,
>      .xive        = true,
> -
> -    .post_load   = spapr_irq_post_load_dual,
>  };
>  
>  
> @@ -447,8 +409,11 @@ qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq)
>  
>  int spapr_irq_post_load(SpaprMachineState *spapr, int version_id)
>  {
> +    SpaprInterruptControllerClass *sicc;
> +
>      spapr_irq_update_active_intc(spapr);
> -    return spapr->irq->post_load(spapr, version_id);
> +    sicc = SPAPR_INTC_GET_CLASS(spapr->active_intc);
> +    return sicc->post_load(spapr->active_intc, version_id);
>  }
>  
>  void spapr_irq_reset(SpaprMachineState *spapr, Error **errp)
> @@ -589,8 +554,6 @@ SpaprIrq spapr_irq_xics_legacy = {
>      .nr_msis     = SPAPR_IRQ_XICS_LEGACY_NR_XIRQS,
>      .xics        = true,
>      .xive        = false,
> -
> -    .post_load   = spapr_irq_post_load_xics,
>  };
>  
>  static void spapr_irq_register_types(void)
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 1aff1c2eb7..4c2cd091da 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -62,6 +62,7 @@ typedef struct SpaprInterruptControllerClass {
>      void (*print_info)(SpaprInterruptController *intc, Monitor *mon);
>      void (*dt)(SpaprInterruptController *intc, uint32_t nr_servers,
>                 void *fdt, uint32_t phandle);
> +    int (*post_load)(SpaprInterruptController *intc, int version_id);
>  } SpaprInterruptControllerClass;
>  
>  void spapr_irq_update_active_intc(SpaprMachineState *spapr);
> @@ -82,8 +83,6 @@ typedef struct SpaprIrq {
>      uint32_t    nr_msis;
>      bool        xics;
>      bool        xive;
> -
> -    int (*post_load)(SpaprMachineState *spapr, int version_id);
>  } SpaprIrq;
>  
>  extern SpaprIrq spapr_irq_xics;
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 64972754f9..d84bd5c229 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -55,7 +55,6 @@ typedef struct SpaprXive {
>  #define SPAPR_XIVE_BLOCK_ID 0x0
>  
>  void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon);
> -int spapr_xive_post_load(SpaprXive *xive, int version_id);
>  
>  void spapr_xive_hcall_init(SpaprMachineState *spapr);
>  void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);


