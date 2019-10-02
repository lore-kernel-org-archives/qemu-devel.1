Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C283DC35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 06:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87001215EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 06:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87001215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFXnw-0006ON-IF
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 02:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iFXn9-0005q1-49
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 02:07:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iFXn7-000344-5e
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 02:07:14 -0400
Received: from 10.mo177.mail-out.ovh.net ([46.105.73.133]:49361)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iFXn6-00033E-VR
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 02:07:13 -0400
Received: from player696.ha.ovh.net (unknown [10.108.57.38])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id F04B710C944
 for <qemu-devel@nongnu.org>; Wed,  2 Oct 2019 08:07:10 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player696.ha.ovh.net (Postfix) with ESMTPSA id 15806A85A6D1;
 Wed,  2 Oct 2019 06:07:00 +0000 (UTC)
Subject: Re: [PATCH v3 22/34] spapr, xics, xive: Move cpu_intc_create from
 SpaprIrq to SpaprInterruptController
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20191002025208.3487-1-david@gibson.dropbear.id.au>
 <20191002025208.3487-23-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <360fd118-81c2-7ba1-2faf-d735d887d955@kaod.org>
Date: Wed, 2 Oct 2019 08:06:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191002025208.3487-23-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 4507540278063238041
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeehgddutdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.73.133
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
 Laurent Vivier <laurent@vivier.eu>, groug@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/2019 04:51, David Gibson wrote:
> This method essentially represents code which belongs to the interrupt
> controller, but needs to be called on all possible intcs, rather than
> just the currently active one.  The "dual" version therefore calls
> into the xics and xive versions confusingly.
> 
> Handle this more directly, by making it instead a method on the intc
> backend, and always calling it on every backend that exists.
> 
> While we're there, streamline the error reporting a bit.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/intc/spapr_xive.c       | 25 ++++++++++++
>  hw/intc/xics_spapr.c       | 18 +++++++++
>  hw/ppc/spapr_cpu_core.c    |  3 +-
>  hw/ppc/spapr_irq.c         | 81 +++++++++++---------------------------
>  include/hw/ppc/spapr_irq.h | 13 +++++-
>  5 files changed, 79 insertions(+), 61 deletions(-)
> 
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index b67e9c3245..9338daba3d 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -495,10 +495,33 @@ static Property spapr_xive_properties[] = {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> +static int spapr_xive_cpu_intc_create(SpaprInterruptController *intc,
> +                                      PowerPCCPU *cpu, Error **errp)
> +{
> +    SpaprXive *xive = SPAPR_XIVE(intc);
> +    Object *obj;
> +    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
> +
> +    obj = xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(xive), errp);
> +    if (!obj) {
> +        return -1;
> +    }
> +
> +    spapr_cpu->tctx = XIVE_TCTX(obj);
> +
> +    /*
> +     * (TCG) Early setting the OS CAM line for hotplugged CPUs as they
> +     * don't beneficiate from the reset of the XIVE IRQ backend
> +     */
> +    spapr_xive_set_tctx_os_cam(spapr_cpu->tctx);
> +    return 0;
> +}
> +
>  static void spapr_xive_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      XiveRouterClass *xrc = XIVE_ROUTER_CLASS(klass);
> +    SpaprInterruptControllerClass *sicc = SPAPR_INTC_CLASS(klass);
>  
>      dc->desc    = "sPAPR XIVE Interrupt Controller";
>      dc->props   = spapr_xive_properties;
> @@ -511,6 +534,8 @@ static void spapr_xive_class_init(ObjectClass *klass, void *data)
>      xrc->get_nvt = spapr_xive_get_nvt;
>      xrc->write_nvt = spapr_xive_write_nvt;
>      xrc->get_tctx = spapr_xive_get_tctx;
> +
> +    sicc->cpu_intc_create = spapr_xive_cpu_intc_create;
>  }
>  
>  static const TypeInfo spapr_xive_info = {
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 4874e6be55..946311b858 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -330,13 +330,31 @@ void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void *fdt,
>      _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
>  }
>  
> +static int xics_spapr_cpu_intc_create(SpaprInterruptController *intc,
> +                                       PowerPCCPU *cpu, Error **errp)
> +{
> +    ICSState *ics = ICS_SPAPR(intc);
> +    Object *obj;
> +    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
> +
> +    obj = icp_create(OBJECT(cpu), TYPE_ICP, ics->xics, errp);
> +    if (!obj) {
> +        return -1;
> +    }
> +
> +    spapr_cpu->icp = ICP(obj);
> +    return 0;
> +}
> +
>  static void ics_spapr_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      ICSStateClass *isc = ICS_CLASS(klass);
> +    SpaprInterruptControllerClass *sicc = SPAPR_INTC_CLASS(klass);
>  
>      device_class_set_parent_realize(dc, ics_spapr_realize,
>                                      &isc->parent_realize);
> +    sicc->cpu_intc_create = xics_spapr_cpu_intc_create;
>  }
>  
>  static const TypeInfo ics_spapr_info = {
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 1d93de8161..3e4302c7d5 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -237,8 +237,7 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
>      qemu_register_reset(spapr_cpu_reset, cpu);
>      spapr_cpu_reset(cpu);
>  
> -    spapr->irq->cpu_intc_create(spapr, cpu, &local_err);
> -    if (local_err) {
> +    if (spapr_irq_cpu_intc_create(spapr, cpu, &local_err) < 0) {
>          goto error_unregister;
>      }
>  
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 8791dec1ba..9cb2fc71ca 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -138,23 +138,6 @@ static void spapr_irq_print_info_xics(SpaprMachineState *spapr, Monitor *mon)
>      ics_pic_print_info(spapr->ics, mon);
>  }
>  
> -static void spapr_irq_cpu_intc_create_xics(SpaprMachineState *spapr,
> -                                           PowerPCCPU *cpu, Error **errp)
> -{
> -    Error *local_err = NULL;
> -    Object *obj;
> -    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
> -
> -    obj = icp_create(OBJECT(cpu), TYPE_ICP, XICS_FABRIC(spapr),
> -                     &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
> -    spapr_cpu->icp = ICP(obj);
> -}
> -
>  static int spapr_irq_post_load_xics(SpaprMachineState *spapr, int version_id)
>  {
>      if (!kvm_irqchip_in_kernel()) {
> @@ -203,7 +186,6 @@ SpaprIrq spapr_irq_xics = {
>      .free        = spapr_irq_free_xics,
>      .print_info  = spapr_irq_print_info_xics,
>      .dt_populate = spapr_dt_xics,
> -    .cpu_intc_create = spapr_irq_cpu_intc_create_xics,
>      .post_load   = spapr_irq_post_load_xics,
>      .reset       = spapr_irq_reset_xics,
>      .set_irq     = spapr_irq_set_irq_xics,
> @@ -239,28 +221,6 @@ static void spapr_irq_print_info_xive(SpaprMachineState *spapr,
>      spapr_xive_pic_print_info(spapr->xive, mon);
>  }
>  
> -static void spapr_irq_cpu_intc_create_xive(SpaprMachineState *spapr,
> -                                           PowerPCCPU *cpu, Error **errp)
> -{
> -    Error *local_err = NULL;
> -    Object *obj;
> -    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
> -
> -    obj = xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(spapr->xive), &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
> -    spapr_cpu->tctx = XIVE_TCTX(obj);
> -
> -    /*
> -     * (TCG) Early setting the OS CAM line for hotplugged CPUs as they
> -     * don't beneficiate from the reset of the XIVE IRQ backend
> -     */
> -    spapr_xive_set_tctx_os_cam(spapr_cpu->tctx);
> -}
> -
>  static int spapr_irq_post_load_xive(SpaprMachineState *spapr, int version_id)
>  {
>      return spapr_xive_post_load(spapr->xive, version_id);
> @@ -316,7 +276,6 @@ SpaprIrq spapr_irq_xive = {
>      .free        = spapr_irq_free_xive,
>      .print_info  = spapr_irq_print_info_xive,
>      .dt_populate = spapr_dt_xive,
> -    .cpu_intc_create = spapr_irq_cpu_intc_create_xive,
>      .post_load   = spapr_irq_post_load_xive,
>      .reset       = spapr_irq_reset_xive,
>      .set_irq     = spapr_irq_set_irq_xive,
> @@ -381,20 +340,6 @@ static void spapr_irq_dt_populate_dual(SpaprMachineState *spapr,
>      spapr_irq_current(spapr)->dt_populate(spapr, nr_servers, fdt, phandle);
>  }
>  
> -static void spapr_irq_cpu_intc_create_dual(SpaprMachineState *spapr,
> -                                           PowerPCCPU *cpu, Error **errp)
> -{
> -    Error *local_err = NULL;
> -
> -    spapr_irq_xive.cpu_intc_create(spapr, cpu, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
> -    spapr_irq_xics.cpu_intc_create(spapr, cpu, errp);
> -}
> -
>  static int spapr_irq_post_load_dual(SpaprMachineState *spapr, int version_id)
>  {
>      /*
> @@ -460,7 +405,6 @@ SpaprIrq spapr_irq_dual = {
>      .free        = spapr_irq_free_dual,
>      .print_info  = spapr_irq_print_info_dual,
>      .dt_populate = spapr_irq_dt_populate_dual,
> -    .cpu_intc_create = spapr_irq_cpu_intc_create_dual,
>      .post_load   = spapr_irq_post_load_dual,
>      .reset       = spapr_irq_reset_dual,
>      .set_irq     = spapr_irq_set_irq_dual,
> @@ -527,6 +471,30 @@ static int spapr_irq_check(SpaprMachineState *spapr, Error **errp)
>  /*
>   * sPAPR IRQ frontend routines for devices
>   */
> +#define ALL_INTCS(spapr_) \
> +    { SPAPR_INTC((spapr_)->ics), SPAPR_INTC((spapr_)->xive), }

I would have expected this array to be under the machine.

> +int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
> +                              PowerPCCPU *cpu, Error **errp)
> +{
> +    SpaprInterruptController *intcs[] = ALL_INTCS(spapr);
> +    int i;
> +    int rc;
> +
> +    for (i = 0; i < ARRAY_SIZE(intcs); i++) {

but it would have been difficult to use ARRAY_SIZE. OK then.

> +        SpaprInterruptController *intc = intcs[i];
> +        if (intc) {

Is that test needed ? 

> +            SpaprInterruptControllerClass *sicc = SPAPR_INTC_GET_CLASS(intc);
> +            rc = sicc->cpu_intc_create(intc, cpu, errp);
> +            if (rc < 0) {
> +                return rc;
> +            }
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>  void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>  {
>      MachineState *machine = MACHINE(spapr);
> @@ -762,7 +730,6 @@ SpaprIrq spapr_irq_xics_legacy = {
>      .free        = spapr_irq_free_xics,
>      .print_info  = spapr_irq_print_info_xics,
>      .dt_populate = spapr_dt_xics,
> -    .cpu_intc_create = spapr_irq_cpu_intc_create_xics,
>      .post_load   = spapr_irq_post_load_xics,
>      .reset       = spapr_irq_reset_xics,
>      .set_irq     = spapr_irq_set_irq_xics,
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index b9398e0be3..5e641e23c1 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -43,8 +43,19 @@ typedef struct SpaprInterruptController SpaprInterruptController;
>  
>  typedef struct SpaprInterruptControllerClass {
>      InterfaceClass parent;
> +
> +    /*
> +     * These methods will typically be called on all intcs, active and
> +     * inactive
> +     */
> +    int (*cpu_intc_create)(SpaprInterruptController *intc,
> +                            PowerPCCPU *cpu, Error **errp);
>  } SpaprInterruptControllerClass;
>  
> +int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
> +                              PowerPCCPU *cpu, Error **errp);
> +
> +
>  void spapr_irq_msi_init(SpaprMachineState *spapr, uint32_t nr_msis);
>  int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool align,
>                          Error **errp);
> @@ -61,8 +72,6 @@ typedef struct SpaprIrq {
>      void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
>      void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
>                          void *fdt, uint32_t phandle);
> -    void (*cpu_intc_create)(SpaprMachineState *spapr, PowerPCCPU *cpu,
> -                            Error **errp);
>      int (*post_load)(SpaprMachineState *spapr, int version_id);
>      void (*reset)(SpaprMachineState *spapr, Error **errp);
>      void (*set_irq)(void *opaque, int srcno, int val);
> 


