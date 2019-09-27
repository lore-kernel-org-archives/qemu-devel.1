Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4360C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E35217D9
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E35217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDstG-0000b8-Ib
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 12:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDrOL-0006ib-BE
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDrOI-00074s-3l
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:38:40 -0400
Received: from 17.mo3.mail-out.ovh.net ([87.98.178.58]:51011)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDrOH-000742-Hd
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:38:38 -0400
Received: from player693.ha.ovh.net (unknown [10.109.143.3])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 087F022961F
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 16:38:34 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player693.ha.ovh.net (Postfix) with ESMTPSA id DB4E2A4AB388;
 Fri, 27 Sep 2019 14:38:23 +0000 (UTC)
Date: Fri, 27 Sep 2019 16:38:22 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 26/33] spapr, xics, xive: Move dt_populate from
 SpaprIrq to SpaprInterruptController
Message-ID: <20190927163822.70dfd6fd@bahia.lan>
In-Reply-To: <20190927055028.11493-27-david@gibson.dropbear.id.au>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-27-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2227592966156163558
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeeigdejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.178.58
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

On Fri, 27 Sep 2019 15:50:21 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> This method depends only on the active irq controller.  Now that we've
> formalized the notion of active controller we can dispatch directly
> through that, rather than dispatching via SpaprIrq with the dual
> version having to do a second conditional dispatch.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/intc/spapr_xive.c        | 125 ++++++++++++++++++------------------
>  hw/intc/xics_spapr.c        |   5 +-
>  hw/ppc/spapr.c              |   3 +-
>  hw/ppc/spapr_irq.c          |  20 +++---
>  include/hw/ppc/spapr_irq.h  |   5 +-
>  include/hw/ppc/spapr_xive.h |   2 -
>  include/hw/ppc/xics_spapr.h |   2 -
>  7 files changed, 78 insertions(+), 84 deletions(-)
> 
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 700ec5c9c1..37ffb74ca5 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -578,6 +578,68 @@ static void spapr_xive_print_info(SpaprInterruptController *intc, Monitor *mon)
>      spapr_xive_pic_print_info(xive, mon);
>  }
>  
> +static void spapr_xive_dt(SpaprInterruptController *intc, uint32_t nr_servers,
> +                          void *fdt, uint32_t phandle)
> +{
> +    SpaprXive *xive = SPAPR_XIVE(intc);
> +    int node;
> +    uint64_t timas[2 * 2];
> +    /* Interrupt number ranges for the IPIs */
> +    uint32_t lisn_ranges[] = {
> +        cpu_to_be32(0),
> +        cpu_to_be32(nr_servers),
> +    };
> +    /*
> +     * EQ size - the sizes of pages supported by the system 4K, 64K,
> +     * 2M, 16M. We only advertise 64K for the moment.
> +     */
> +    uint32_t eq_sizes[] = {
> +        cpu_to_be32(16), /* 64K */
> +    };
> +    /*
> +     * The following array is in sync with the reserved priorities
> +     * defined by the 'spapr_xive_priority_is_reserved' routine.
> +     */
> +    uint32_t plat_res_int_priorities[] = {
> +        cpu_to_be32(7),    /* start */
> +        cpu_to_be32(0xf8), /* count */
> +    };
> +
> +    /* Thread Interrupt Management Area : User (ring 3) and OS (ring 2) */
> +    timas[0] = cpu_to_be64(xive->tm_base +
> +                           XIVE_TM_USER_PAGE * (1ull << TM_SHIFT));
> +    timas[1] = cpu_to_be64(1ull << TM_SHIFT);
> +    timas[2] = cpu_to_be64(xive->tm_base +
> +                           XIVE_TM_OS_PAGE * (1ull << TM_SHIFT));
> +    timas[3] = cpu_to_be64(1ull << TM_SHIFT);
> +
> +    _FDT(node = fdt_add_subnode(fdt, 0, xive->nodename));
> +
> +    _FDT(fdt_setprop_string(fdt, node, "device_type", "power-ivpe"));
> +    _FDT(fdt_setprop(fdt, node, "reg", timas, sizeof(timas)));
> +
> +    _FDT(fdt_setprop_string(fdt, node, "compatible", "ibm,power-ivpe"));
> +    _FDT(fdt_setprop(fdt, node, "ibm,xive-eq-sizes", eq_sizes,
> +                     sizeof(eq_sizes)));
> +    _FDT(fdt_setprop(fdt, node, "ibm,xive-lisn-ranges", lisn_ranges,
> +                     sizeof(lisn_ranges)));
> +
> +    /* For Linux to link the LSIs to the interrupt controller. */
> +    _FDT(fdt_setprop(fdt, node, "interrupt-controller", NULL, 0));
> +    _FDT(fdt_setprop_cell(fdt, node, "#interrupt-cells", 2));
> +
> +    /* For SLOF */
> +    _FDT(fdt_setprop_cell(fdt, node, "linux,phandle", phandle));
> +    _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
> +
> +    /*
> +     * The "ibm,plat-res-int-priorities" property defines the priority
> +     * ranges reserved by the hypervisor
> +     */
> +    _FDT(fdt_setprop(fdt, 0, "ibm,plat-res-int-priorities",
> +                     plat_res_int_priorities, sizeof(plat_res_int_priorities)));
> +}
> +
>  static void spapr_xive_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -601,6 +663,7 @@ static void spapr_xive_class_init(ObjectClass *klass, void *data)
>      sicc->free_irq = spapr_xive_free_irq;
>      sicc->set_irq = spapr_xive_set_irq;
>      sicc->print_info = spapr_xive_print_info;
> +    sicc->dt = spapr_xive_dt;
>  }
>  
>  static const TypeInfo spapr_xive_info = {
> @@ -1601,65 +1664,3 @@ void spapr_xive_hcall_init(SpaprMachineState *spapr)
>      spapr_register_hypercall(H_INT_SYNC, h_int_sync);
>      spapr_register_hypercall(H_INT_RESET, h_int_reset);
>  }
> -
> -void spapr_dt_xive(SpaprMachineState *spapr, uint32_t nr_servers, void *fdt,
> -                   uint32_t phandle)
> -{
> -    SpaprXive *xive = spapr->xive;
> -    int node;
> -    uint64_t timas[2 * 2];
> -    /* Interrupt number ranges for the IPIs */
> -    uint32_t lisn_ranges[] = {
> -        cpu_to_be32(0),
> -        cpu_to_be32(nr_servers),
> -    };
> -    /*
> -     * EQ size - the sizes of pages supported by the system 4K, 64K,
> -     * 2M, 16M. We only advertise 64K for the moment.
> -     */
> -    uint32_t eq_sizes[] = {
> -        cpu_to_be32(16), /* 64K */
> -    };
> -    /*
> -     * The following array is in sync with the reserved priorities
> -     * defined by the 'spapr_xive_priority_is_reserved' routine.
> -     */
> -    uint32_t plat_res_int_priorities[] = {
> -        cpu_to_be32(7),    /* start */
> -        cpu_to_be32(0xf8), /* count */
> -    };
> -
> -    /* Thread Interrupt Management Area : User (ring 3) and OS (ring 2) */
> -    timas[0] = cpu_to_be64(xive->tm_base +
> -                           XIVE_TM_USER_PAGE * (1ull << TM_SHIFT));
> -    timas[1] = cpu_to_be64(1ull << TM_SHIFT);
> -    timas[2] = cpu_to_be64(xive->tm_base +
> -                           XIVE_TM_OS_PAGE * (1ull << TM_SHIFT));
> -    timas[3] = cpu_to_be64(1ull << TM_SHIFT);
> -
> -    _FDT(node = fdt_add_subnode(fdt, 0, xive->nodename));
> -
> -    _FDT(fdt_setprop_string(fdt, node, "device_type", "power-ivpe"));
> -    _FDT(fdt_setprop(fdt, node, "reg", timas, sizeof(timas)));
> -
> -    _FDT(fdt_setprop_string(fdt, node, "compatible", "ibm,power-ivpe"));
> -    _FDT(fdt_setprop(fdt, node, "ibm,xive-eq-sizes", eq_sizes,
> -                     sizeof(eq_sizes)));
> -    _FDT(fdt_setprop(fdt, node, "ibm,xive-lisn-ranges", lisn_ranges,
> -                     sizeof(lisn_ranges)));
> -
> -    /* For Linux to link the LSIs to the interrupt controller. */
> -    _FDT(fdt_setprop(fdt, node, "interrupt-controller", NULL, 0));
> -    _FDT(fdt_setprop_cell(fdt, node, "#interrupt-cells", 2));
> -
> -    /* For SLOF */
> -    _FDT(fdt_setprop_cell(fdt, node, "linux,phandle", phandle));
> -    _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
> -
> -    /*
> -     * The "ibm,plat-res-int-priorities" property defines the priority
> -     * ranges reserved by the hypervisor
> -     */
> -    _FDT(fdt_setprop(fdt, 0, "ibm,plat-res-int-priorities",
> -                     plat_res_int_priorities, sizeof(plat_res_int_priorities)));
> -}
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 415defe394..4eabafc7e1 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -308,8 +308,8 @@ static void ics_spapr_realize(DeviceState *dev, Error **errp)
>      spapr_register_hypercall(H_IPOLL, h_ipoll);
>  }
>  
> -void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void *fdt,
> -                   uint32_t phandle)
> +static void xics_spapr_dt(SpaprInterruptController *intc, uint32_t nr_servers,
> +                          void *fdt, uint32_t phandle)
>  {
>      uint32_t interrupt_server_ranges_prop[] = {
>          0, cpu_to_be32(nr_servers),
> @@ -408,6 +408,7 @@ static void ics_spapr_class_init(ObjectClass *klass, void *data)
>      sicc->free_irq = xics_spapr_free_irq;
>      sicc->set_irq = xics_spapr_set_irq;
>      sicc->print_info = xics_spapr_print_info;
> +    sicc->dt = xics_spapr_dt;
>  }
>  
>  static const TypeInfo ics_spapr_info = {
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 7e04746db1..f55d227cd3 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1325,8 +1325,7 @@ static void *spapr_build_fdt(SpaprMachineState *spapr)
>      _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
>  
>      /* /interrupt controller */
> -    spapr->irq->dt_populate(spapr, spapr_max_server_number(spapr), fdt,
> -                          PHANDLE_INTC);
> +    spapr_irq_dt(spapr, spapr_max_server_number(spapr), fdt, PHANDLE_INTC);
>  
>      ret = spapr_populate_memory(spapr, fdt);
>      if (ret < 0) {
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index be20bbf3cf..79cbe8064e 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -134,7 +134,6 @@ SpaprIrq spapr_irq_xics = {
>      .xics        = true,
>      .xive        = false,
>  
> -    .dt_populate = spapr_dt_xics,
>      .post_load   = spapr_irq_post_load_xics,
>      .reset       = spapr_irq_reset_xics,
>      .init_kvm    = spapr_irq_init_kvm_xics,
> @@ -184,7 +183,6 @@ SpaprIrq spapr_irq_xive = {
>      .xics        = false,
>      .xive        = true,
>  
> -    .dt_populate = spapr_dt_xive,
>      .post_load   = spapr_irq_post_load_xive,
>      .reset       = spapr_irq_reset_xive,
>      .init_kvm    = spapr_irq_init_kvm_xive,
> @@ -209,13 +207,6 @@ static SpaprIrq *spapr_irq_current(SpaprMachineState *spapr)
>          &spapr_irq_xive : &spapr_irq_xics;
>  }
>  
> -static void spapr_irq_dt_populate_dual(SpaprMachineState *spapr,
> -                                       uint32_t nr_servers, void *fdt,
> -                                       uint32_t phandle)
> -{
> -    spapr_irq_current(spapr)->dt_populate(spapr, nr_servers, fdt, phandle);
> -}
> -
>  static int spapr_irq_post_load_dual(SpaprMachineState *spapr, int version_id)
>  {
>      /*
> @@ -270,7 +261,6 @@ SpaprIrq spapr_irq_dual = {
>      .xics        = true,
>      .xive        = true,
>  
> -    .dt_populate = spapr_irq_dt_populate_dual,
>      .post_load   = spapr_irq_post_load_dual,
>      .reset       = spapr_irq_reset_dual,
>      .init_kvm    = NULL, /* should not be used */
> @@ -375,6 +365,15 @@ void spapr_irq_print_info(SpaprMachineState *spapr, Monitor *mon)
>      sicc->print_info(spapr->active_intc, mon);
>  }
>  
> +void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
> +                  void *fdt, uint32_t phandle)
> +{
> +    SpaprInterruptControllerClass *sicc
> +        = SPAPR_INTC_GET_CLASS(spapr->active_intc);
> +
> +    sicc->dt(spapr->active_intc, nr_servers, fdt, phandle);
> +}
> +
>  void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>  {
>      MachineState *machine = MACHINE(spapr);
> @@ -693,7 +692,6 @@ SpaprIrq spapr_irq_xics_legacy = {
>      .xics        = true,
>      .xive        = false,
>  
> -    .dt_populate = spapr_dt_xics,
>      .post_load   = spapr_irq_post_load_xics,
>      .reset       = spapr_irq_reset_xics,
>      .init_kvm    = spapr_irq_init_kvm_xics,
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 2ade580992..c82724fc2b 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -60,6 +60,8 @@ typedef struct SpaprInterruptControllerClass {
>      /* These methods should only be called on the active intc */
>      void (*set_irq)(SpaprInterruptController *intc, int irq, int val);
>      void (*print_info)(SpaprInterruptController *intc, Monitor *mon);
> +    void (*dt)(SpaprInterruptController *intc, uint32_t nr_servers,
> +               void *fdt, uint32_t phandle);
>  } SpaprInterruptControllerClass;
>  
>  void spapr_irq_update_active_intc(SpaprMachineState *spapr);
> @@ -70,7 +72,6 @@ void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
>  int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
>                                PowerPCCPU *cpu, Error **errp);
>  
> -
>  void spapr_irq_msi_init(SpaprMachineState *spapr, uint32_t nr_msis);
>  int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool align,
>                          Error **errp);
> @@ -82,8 +83,6 @@ typedef struct SpaprIrq {
>      bool        xics;
>      bool        xive;
>  
> -    void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
> -                        void *fdt, uint32_t phandle);
>      int (*post_load)(SpaprMachineState *spapr, int version_id);
>      void (*reset)(SpaprMachineState *spapr, Error **errp);
>      void (*init_kvm)(SpaprMachineState *spapr, Error **errp);
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 8f875673f5..ebe156eb30 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -58,8 +58,6 @@ void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon);
>  int spapr_xive_post_load(SpaprXive *xive, int version_id);
>  
>  void spapr_xive_hcall_init(SpaprMachineState *spapr);
> -void spapr_dt_xive(SpaprMachineState *spapr, uint32_t nr_servers, void *fdt,
> -                   uint32_t phandle);
>  void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
>  void spapr_xive_mmio_set_enabled(SpaprXive *xive, bool enable);
>  void spapr_xive_map_mmio(SpaprXive *xive);
> diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
> index 0a32a86e3e..9c9044db65 100644
> --- a/include/hw/ppc/xics_spapr.h
> +++ b/include/hw/ppc/xics_spapr.h
> @@ -33,8 +33,6 @@
>  #define ICS_SPAPR(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SPAPR)
>  
>  void ics_spapr_create(SpaprMachineState *spapr, int nr_xirqs, Error **errp);
> -void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void *fdt,
> -                   uint32_t phandle);
>  int xics_kvm_connect(SpaprMachineState *spapr, Error **errp);
>  void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp);
>  bool xics_kvm_has_broken_disconnect(SpaprMachineState *spapr);


