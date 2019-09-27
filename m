Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5471EC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:49:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26BD5207E0
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BD5207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDtQa-0004FP-Gp
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 12:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDrHT-0007hc-0e
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDrHQ-0005sX-Vj
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:31:34 -0400
Received: from 8.mo177.mail-out.ovh.net ([46.105.61.98]:37901)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDrHQ-0005rs-5O
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:31:32 -0400
Received: from player774.ha.ovh.net (unknown [10.109.143.238])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 6599A10C73E
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 16:31:29 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player774.ha.ovh.net (Postfix) with ESMTPSA id 0FF7DA4F3DD0;
 Fri, 27 Sep 2019 14:31:17 +0000 (UTC)
Date: Fri, 27 Sep 2019 16:31:16 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 25/33] spapr, xics, xive: Move print_info from
 SpaprIrq to SpaprInterruptController
Message-ID: <20190927163116.061b7d9a@bahia.lan>
In-Reply-To: <20190927055028.11493-26-david@gibson.dropbear.id.au>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-26-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2107684626380790246
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeeigdejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.61.98
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

On Fri, 27 Sep 2019 15:50:20 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> This method depends only on the active irq controller.  Now that we've
> formalized the notion of active controller we can dispatch directly
> through that, rather than dispatching via SpaprIrq with the dual
> version having to do a second conditional dispatch.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/intc/spapr_xive.c       | 15 +++++++++++++
>  hw/intc/xics_spapr.c       | 15 +++++++++++++
>  hw/ppc/spapr.c             |  2 +-
>  hw/ppc/spapr_irq.c         | 44 +++++++-------------------------------
>  include/hw/ppc/spapr_irq.h |  2 +-
>  5 files changed, 40 insertions(+), 38 deletions(-)
> 
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 52d5e71793..700ec5c9c1 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -564,6 +564,20 @@ static void spapr_xive_set_irq(SpaprInterruptController *intc, int irq, int val)
>      }
>  }
>  
> +static void spapr_xive_print_info(SpaprInterruptController *intc, Monitor *mon)
> +{
> +    SpaprXive *xive = SPAPR_XIVE(intc);
> +    CPUState *cs;
> +
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *cpu = POWERPC_CPU(cs);
> +
> +        xive_tctx_pic_print_info(spapr_cpu_state(cpu)->tctx, mon);
> +    }
> +
> +    spapr_xive_pic_print_info(xive, mon);
> +}
> +
>  static void spapr_xive_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -586,6 +600,7 @@ static void spapr_xive_class_init(ObjectClass *klass, void *data)
>      sicc->claim_irq = spapr_xive_claim_irq;
>      sicc->free_irq = spapr_xive_free_irq;
>      sicc->set_irq = spapr_xive_set_irq;
> +    sicc->print_info = spapr_xive_print_info;
>  }
>  
>  static const TypeInfo spapr_xive_info = {
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 02372697f6..415defe394 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -381,6 +381,20 @@ static void xics_spapr_set_irq(SpaprInterruptController *intc, int irq, int val)
>      ics_set_irq(ics, srcno, val);
>  }
>  
> +static void xics_spapr_print_info(SpaprInterruptController *intc, Monitor *mon)
> +{
> +    ICSState *ics = ICS_SPAPR(intc);
> +    CPUState *cs;
> +
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *cpu = POWERPC_CPU(cs);
> +
> +        icp_pic_print_info(spapr_cpu_state(cpu)->icp, mon);
> +    }
> +
> +    ics_pic_print_info(ics, mon);
> +}
> +
>  static void ics_spapr_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -393,6 +407,7 @@ static void ics_spapr_class_init(ObjectClass *klass, void *data)
>      sicc->claim_irq = xics_spapr_claim_irq;
>      sicc->free_irq = xics_spapr_free_irq;
>      sicc->set_irq = xics_spapr_set_irq;
> +    sicc->print_info = xics_spapr_print_info;
>  }
>  
>  static const TypeInfo ics_spapr_info = {
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 795f6ab505..7e04746db1 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4341,7 +4341,7 @@ static void spapr_pic_print_info(InterruptStatsProvider *obj,
>  {
>      SpaprMachineState *spapr = SPAPR_MACHINE(obj);
>  
> -    spapr->irq->print_info(spapr, mon);
> +    spapr_irq_print_info(spapr, mon);
>      monitor_printf(mon, "irqchip: %s\n",
>                     kvm_irqchip_in_kernel() ? "in-kernel" : "emulated");
>  }
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 4922062908..be20bbf3cf 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -98,19 +98,6 @@ static void spapr_irq_init_kvm(SpaprMachineState *spapr,
>   * XICS IRQ backend.
>   */
>  
> -static void spapr_irq_print_info_xics(SpaprMachineState *spapr, Monitor *mon)
> -{
> -    CPUState *cs;
> -
> -    CPU_FOREACH(cs) {
> -        PowerPCCPU *cpu = POWERPC_CPU(cs);
> -
> -        icp_pic_print_info(spapr_cpu_state(cpu)->icp, mon);
> -    }
> -
> -    ics_pic_print_info(spapr->ics, mon);
> -}
> -
>  static int spapr_irq_post_load_xics(SpaprMachineState *spapr, int version_id)
>  {
>      if (!kvm_irqchip_in_kernel()) {
> @@ -147,7 +134,6 @@ SpaprIrq spapr_irq_xics = {
>      .xics        = true,
>      .xive        = false,
>  
> -    .print_info  = spapr_irq_print_info_xics,
>      .dt_populate = spapr_dt_xics,
>      .post_load   = spapr_irq_post_load_xics,
>      .reset       = spapr_irq_reset_xics,
> @@ -158,20 +144,6 @@ SpaprIrq spapr_irq_xics = {
>   * XIVE IRQ backend.
>   */
>  
> -static void spapr_irq_print_info_xive(SpaprMachineState *spapr,
> -                                      Monitor *mon)
> -{
> -    CPUState *cs;
> -
> -    CPU_FOREACH(cs) {
> -        PowerPCCPU *cpu = POWERPC_CPU(cs);
> -
> -        xive_tctx_pic_print_info(spapr_cpu_state(cpu)->tctx, mon);
> -    }
> -
> -    spapr_xive_pic_print_info(spapr->xive, mon);
> -}
> -
>  static int spapr_irq_post_load_xive(SpaprMachineState *spapr, int version_id)
>  {
>      return spapr_xive_post_load(spapr->xive, version_id);
> @@ -212,7 +184,6 @@ SpaprIrq spapr_irq_xive = {
>      .xics        = false,
>      .xive        = true,
>  
> -    .print_info  = spapr_irq_print_info_xive,
>      .dt_populate = spapr_dt_xive,
>      .post_load   = spapr_irq_post_load_xive,
>      .reset       = spapr_irq_reset_xive,
> @@ -238,11 +209,6 @@ static SpaprIrq *spapr_irq_current(SpaprMachineState *spapr)
>          &spapr_irq_xive : &spapr_irq_xics;
>  }
>  
> -static void spapr_irq_print_info_dual(SpaprMachineState *spapr, Monitor *mon)
> -{
> -    spapr_irq_current(spapr)->print_info(spapr, mon);
> -}
> -
>  static void spapr_irq_dt_populate_dual(SpaprMachineState *spapr,
>                                         uint32_t nr_servers, void *fdt,
>                                         uint32_t phandle)
> @@ -304,7 +270,6 @@ SpaprIrq spapr_irq_dual = {
>      .xics        = true,
>      .xive        = true,
>  
> -    .print_info  = spapr_irq_print_info_dual,
>      .dt_populate = spapr_irq_dt_populate_dual,
>      .post_load   = spapr_irq_post_load_dual,
>      .reset       = spapr_irq_reset_dual,
> @@ -402,6 +367,14 @@ static void spapr_set_irq(void *opaque, int irq, int level)
>      sicc->set_irq(spapr->active_intc, irq, level);
>  }
>  
> +void spapr_irq_print_info(SpaprMachineState *spapr, Monitor *mon)
> +{
> +    SpaprInterruptControllerClass *sicc
> +        = SPAPR_INTC_GET_CLASS(spapr->active_intc);
> +
> +    sicc->print_info(spapr->active_intc, mon);
> +}
> +
>  void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>  {
>      MachineState *machine = MACHINE(spapr);
> @@ -720,7 +693,6 @@ SpaprIrq spapr_irq_xics_legacy = {
>      .xics        = true,
>      .xive        = false,
>  
> -    .print_info  = spapr_irq_print_info_xics,
>      .dt_populate = spapr_dt_xics,
>      .post_load   = spapr_irq_post_load_xics,
>      .reset       = spapr_irq_reset_xics,
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 8286a9aa63..2ade580992 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -59,6 +59,7 @@ typedef struct SpaprInterruptControllerClass {
>  
>      /* These methods should only be called on the active intc */
>      void (*set_irq)(SpaprInterruptController *intc, int irq, int val);
> +    void (*print_info)(SpaprInterruptController *intc, Monitor *mon);
>  } SpaprInterruptControllerClass;
>  
>  void spapr_irq_update_active_intc(SpaprMachineState *spapr);
> @@ -81,7 +82,6 @@ typedef struct SpaprIrq {
>      bool        xics;
>      bool        xive;
>  
> -    void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
>      void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
>                          void *fdt, uint32_t phandle);
>      int (*post_load)(SpaprMachineState *spapr, int version_id);


