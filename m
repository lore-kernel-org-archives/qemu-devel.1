Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FDAC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:15:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C63DE21841
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63DE21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDstm-0001AI-5A
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 12:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDs0Q-0003TS-Mm
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 11:18:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDs0P-000102-1l
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 11:18:02 -0400
Received: from 9.mo179.mail-out.ovh.net ([46.105.76.148]:50824)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDs0O-0000zD-PV
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 11:18:00 -0400
Received: from player697.ha.ovh.net (unknown [10.109.160.244])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 1B284142383
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 17:17:57 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player697.ha.ovh.net (Postfix) with ESMTPSA id 4DCD6A56105F;
 Fri, 27 Sep 2019 15:17:46 +0000 (UTC)
Date: Fri, 27 Sep 2019 17:17:45 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 31/33] spapr: Remove SpaprIrq::nr_msis
Message-ID: <20190927171745.52f69866@bahia.lan>
In-Reply-To: <20190927055028.11493-32-david@gibson.dropbear.id.au>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-32-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2892718339353647590
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeeigdekhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.76.148
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

On Fri, 27 Sep 2019 15:50:26 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> The nr_msis value we use here has to line up with whether we're using
> legacy or modern irq allocation.  Therefore it's safer to derive it based
> on legacy_irq_allocation rather than having SpaprIrq contain a canned
> value.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c              |  5 ++---
>  hw/ppc/spapr_irq.c          | 26 +++++++++++++++++---------
>  hw/ppc/spapr_pci.c          |  7 ++++---
>  include/hw/pci-host/spapr.h |  4 ++--
>  include/hw/ppc/spapr_irq.h  |  5 +----
>  5 files changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f55d227cd3..34b693beba 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1345,7 +1345,7 @@ static void *spapr_build_fdt(SpaprMachineState *spapr)
>      }
>  
>      QLIST_FOREACH(phb, &spapr->phbs, list) {
> -        ret = spapr_dt_phb(phb, PHANDLE_INTC, fdt, spapr->irq->nr_msis, NULL);
> +        ret = spapr_dt_phb(spapr, phb, PHANDLE_INTC, fdt, NULL);
>          if (ret < 0) {
>              error_report("couldn't setup PCI devices in fdt");
>              exit(1);
> @@ -3980,8 +3980,7 @@ int spapr_phb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
>          return -1;
>      }
>  
> -    if (spapr_dt_phb(sphb, intc_phandle, fdt, spapr->irq->nr_msis,
> -                     fdt_start_offset)) {
> +    if (spapr_dt_phb(spapr, sphb, intc_phandle, fdt, fdt_start_offset)) {
>          error_setg(errp, "unable to create FDT node for PHB %d", sphb->index);
>          return -1;
>      }
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 040384b0fe..799755c811 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -29,9 +29,14 @@ static const TypeInfo spapr_intc_info = {
>      .class_size = sizeof(SpaprInterruptControllerClass),
>  };
>  
> -void spapr_irq_msi_init(SpaprMachineState *spapr, uint32_t nr_msis)
> +static void spapr_irq_msi_init(SpaprMachineState *spapr)
>  {
> -    spapr->irq_map_nr = nr_msis;
> +    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> +        /* Legacy mode doesn't use this allocater */
> +        return;
> +    }
> +
> +    spapr->irq_map_nr = spapr_irq_nr_msis(spapr);
>      spapr->irq_map = bitmap_new(spapr->irq_map_nr);
>  }
>  
> @@ -102,7 +107,6 @@ int spapr_irq_init_kvm(int (*fn)(SpaprInterruptController *, Error **),
>  
>  SpaprIrq spapr_irq_xics = {
>      .nr_xirqs    = SPAPR_NR_XIRQS,
> -    .nr_msis     = SPAPR_NR_MSIS,
>      .xics        = true,
>      .xive        = false,
>  };
> @@ -113,7 +117,6 @@ SpaprIrq spapr_irq_xics = {
>  
>  SpaprIrq spapr_irq_xive = {
>      .nr_xirqs    = SPAPR_NR_XIRQS,
> -    .nr_msis     = SPAPR_NR_MSIS,
>      .xics        = false,
>      .xive        = true,
>  };
> @@ -132,7 +135,6 @@ SpaprIrq spapr_irq_xive = {
>   */
>  SpaprIrq spapr_irq_dual = {
>      .nr_xirqs    = SPAPR_NR_XIRQS,
> -    .nr_msis     = SPAPR_NR_MSIS,
>      .xics        = true,
>      .xive        = true,
>  };
> @@ -245,6 +247,15 @@ void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
>      sicc->dt(spapr->active_intc, nr_servers, fdt, phandle);
>  }
>  
> +uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr)
> +{
> +    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> +        return spapr->irq->nr_xirqs;
> +    } else {
> +        return SPAPR_XIRQ_BASE + spapr->irq->nr_xirqs - SPAPR_IRQ_MSI;
> +    }
> +}
> +
>  void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>  {
>      MachineState *machine = MACHINE(spapr);
> @@ -267,9 +278,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>      }
>  
>      /* Initialize the MSI IRQ allocator. */
> -    if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> -        spapr_irq_msi_init(spapr, spapr->irq->nr_msis);
> -    }
> +    spapr_irq_msi_init(spapr);
>  
>      if (spapr->irq->xics) {
>          Object *obj;
> @@ -558,7 +567,6 @@ int spapr_irq_find(SpaprMachineState *spapr, int num, bool align, Error **errp)
>  
>  SpaprIrq spapr_irq_xics_legacy = {
>      .nr_xirqs    = SPAPR_IRQ_XICS_LEGACY_NR_XIRQS,
> -    .nr_msis     = SPAPR_IRQ_XICS_LEGACY_NR_XIRQS,
>      .xics        = true,
>      .xive        = false,
>  };
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 6934d506a7..8ed06e5964 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2305,8 +2305,8 @@ static void spapr_phb_pci_enumerate(SpaprPhbState *phb)
>  
>  }
>  
> -int spapr_dt_phb(SpaprPhbState *phb, uint32_t intc_phandle, void *fdt,
> -                 uint32_t nr_msis, int *node_offset)
> +int spapr_dt_phb(SpaprMachineState *spapr, SpaprPhbState *phb,
> +                 uint32_t intc_phandle, void *fdt, int *node_offset)
>  {
>      int bus_off, i, j, ret;
>      uint32_t bus_range[] = { cpu_to_be32(0), cpu_to_be32(0xff) };
> @@ -2371,7 +2371,8 @@ int spapr_dt_phb(SpaprPhbState *phb, uint32_t intc_phandle, void *fdt,
>      _FDT(fdt_setprop(fdt, bus_off, "ranges", &ranges, sizeof_ranges));
>      _FDT(fdt_setprop(fdt, bus_off, "reg", &bus_reg, sizeof(bus_reg)));
>      _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pci-config-space-type", 0x1));
> -    _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi", nr_msis));
> +    _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi",
> +                          spapr_irq_nr_msis(spapr)));
>  
>      /* Dynamic DMA window */
>      if (phb->ddw_enabled) {
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index 23506f05d9..8877ff51fb 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -128,8 +128,8 @@ struct SpaprPhbState {
>  #define SPAPR_PCI_NV2ATSD_WIN_SIZE   (NVGPU_MAX_NUM * NVGPU_MAX_LINKS * \
>                                        64 * KiB)
>  
> -int spapr_dt_phb(SpaprPhbState *phb, uint32_t intc_phandle, void *fdt,
> -                 uint32_t nr_msis, int *node_offset);
> +int spapr_dt_phb(SpaprMachineState *spapr, SpaprPhbState *phb,
> +                 uint32_t intc_phandle, void *fdt, int *node_offset);
>  
>  void spapr_pci_rtas_init(void);
>  
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index bc379b0761..308bfcefd1 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -27,7 +27,6 @@
>  #define SPAPR_IRQ_MSI        (SPAPR_XIRQ_BASE + 0x0300)
>  
>  #define SPAPR_NR_XIRQS       0x1000
> -#define SPAPR_NR_MSIS        (SPAPR_XIRQ_BASE + SPAPR_NR_XIRQS - SPAPR_IRQ_MSI)
>  
>  typedef struct SpaprMachineState SpaprMachineState;
>  
> @@ -72,15 +71,13 @@ void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
>                    void *fdt, uint32_t phandle);
>  int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
>                                PowerPCCPU *cpu, Error **errp);
> -
> -void spapr_irq_msi_init(SpaprMachineState *spapr, uint32_t nr_msis);
> +uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr);
>  int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool align,
>                          Error **errp);
>  void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t num);
>  
>  typedef struct SpaprIrq {
>      uint32_t    nr_xirqs;
> -    uint32_t    nr_msis;
>      bool        xics;
>      bool        xive;
>  } SpaprIrq;


