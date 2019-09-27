Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7591FC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:21:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ADDF217D9
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADDF217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDszV-0005wC-Pr
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 12:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDs4p-0007rS-4q
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 11:22:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDs4n-0002th-5l
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 11:22:34 -0400
Received: from 11.mo4.mail-out.ovh.net ([46.105.34.195]:47800)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDs4m-0002t1-Ur
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 11:22:33 -0400
Received: from player687.ha.ovh.net (unknown [10.109.159.48])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 18FAD208D75
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 17:22:28 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id 48404A482132;
 Fri, 27 Sep 2019 15:22:17 +0000 (UTC)
Date: Fri, 27 Sep 2019 17:22:16 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 32/33] spapr: Move SpaprIrq::nr_xirqs to
 SpaprMachineClass
Message-ID: <20190927172216.7249f34d@bahia.lan>
In-Reply-To: <20190927055028.11493-33-david@gibson.dropbear.id.au>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-33-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2968998055657249254
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeeigdekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.34.195
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

On Fri, 27 Sep 2019 15:50:27 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> For the benefit of peripheral device allocation, the number of available
> irqs really wants to be the same on a given machine type version,
> regardless of what irq backends we are using.  That's the case now, but
> only because we make sure the different SpaprIrq instances have the same
> value except for the special legacy one.
> 
> Since this really only depends on machine type version, move the value to
> SpaprMachineClass instead of SpaprIrq.  This also puts the code to set it
> to the lower value on old machine types right next to setting
> legacy_irq_allocation, which needs to go hand in hand.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c             |  2 ++
>  hw/ppc/spapr_irq.c         | 33 ++++++++++++++++-----------------
>  include/hw/ppc/spapr.h     |  1 +
>  include/hw/ppc/spapr_irq.h |  1 -
>  4 files changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 34b693beba..7113249c89 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4513,6 +4513,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>      smc->irq = &spapr_irq_dual;
>      smc->dr_phb_enabled = true;
>      smc->linux_pci_probe = true;
> +    smc->nr_xirqs = SPAPR_NR_XIRQS;

This is the last user of SPAPR_NR_XIRQS.

$ git grep SPAPR_NR_XIRQS
hw/ppc/spapr.c:    smc->nr_xirqs = SPAPR_NR_XIRQS;
include/hw/ppc/spapr_irq.h:#define SPAPR_NR_XIRQS       0x1000

Maybe open-code it here, like you already do for SPAPR_IRQ_XICS_LEGACY_NR_XIRQS
below.

With or without that fixed.

Reviewed-by: Greg Kurz <groug@kaod.org>

>  }
>  
>  static const TypeInfo spapr_machine_info = {
> @@ -4648,6 +4649,7 @@ static void spapr_machine_3_0_class_options(MachineClass *mc)
>      compat_props_add(mc->compat_props, hw_compat_3_0, hw_compat_3_0_len);
>  
>      smc->legacy_irq_allocation = true;
> +    smc->nr_xirqs = 0x400;
>      smc->irq = &spapr_irq_xics_legacy;
>  }
>  
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 799755c811..f76f30f54b 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -106,7 +106,6 @@ int spapr_irq_init_kvm(int (*fn)(SpaprInterruptController *, Error **),
>   */
>  
>  SpaprIrq spapr_irq_xics = {
> -    .nr_xirqs    = SPAPR_NR_XIRQS,
>      .xics        = true,
>      .xive        = false,
>  };
> @@ -116,7 +115,6 @@ SpaprIrq spapr_irq_xics = {
>   */
>  
>  SpaprIrq spapr_irq_xive = {
> -    .nr_xirqs    = SPAPR_NR_XIRQS,
>      .xics        = false,
>      .xive        = true,
>  };
> @@ -134,7 +132,6 @@ SpaprIrq spapr_irq_xive = {
>   * Define values in sync with the XIVE and XICS backend
>   */
>  SpaprIrq spapr_irq_dual = {
> -    .nr_xirqs    = SPAPR_NR_XIRQS,
>      .xics        = true,
>      .xive        = true,
>  };
> @@ -249,16 +246,19 @@ void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
>  
>  uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr)
>  {
> -    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> -        return spapr->irq->nr_xirqs;
> +    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
> +
> +    if (smc->legacy_irq_allocation) {
> +        return smc->nr_xirqs;
>      } else {
> -        return SPAPR_XIRQ_BASE + spapr->irq->nr_xirqs - SPAPR_IRQ_MSI;
> +        return SPAPR_XIRQ_BASE + smc->nr_xirqs - SPAPR_IRQ_MSI;
>      }
>  }
>  
>  void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>  {
>      MachineState *machine = MACHINE(spapr);
> +    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
>      Error *local_err = NULL;
>  
>      if (machine_kernel_irqchip_split(machine)) {
> @@ -295,8 +295,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>              goto out;
>          }
>  
> -        object_property_set_int(obj, spapr->irq->nr_xirqs, "nr-irqs",
> -                                &local_err);
> +        object_property_set_int(obj, smc->nr_xirqs, "nr-irqs", &local_err);
>          if (local_err) {
>              goto out;
>          }
> @@ -315,8 +314,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>          int i;
>  
>          dev = qdev_create(NULL, TYPE_SPAPR_XIVE);
> -        qdev_prop_set_uint32(dev, "nr-irqs",
> -                             spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE);
> +        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + SPAPR_XIRQ_BASE);
>          /*
>           * 8 XIVE END structures per CPU. One for each available
>           * priority
> @@ -343,7 +341,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>      }
>  
>      spapr->qirqs = qemu_allocate_irqs(spapr_set_irq, spapr,
> -                                      spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE);
> +                                      smc->nr_xirqs + SPAPR_XIRQ_BASE);
>  
>  out:
>      error_propagate(errp, local_err);
> @@ -351,10 +349,11 @@ out:
>  
>  int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error **errp)
>  {
> +    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
>      int rc;
>  
>      assert(irq >= SPAPR_XIRQ_BASE);
> -    assert(irq < (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
> +    assert(irq < (smc->nr_xirqs + SPAPR_XIRQ_BASE));
>  
>      if (spapr->xive) {
>          SpaprInterruptControllerClass *sicc = SPAPR_INTC_GET_CLASS(spapr->xive);
> @@ -379,10 +378,11 @@ int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error **errp)
>  
>  void spapr_irq_free(SpaprMachineState *spapr, int irq, int num)
>  {
> +    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
>      int i;
>  
>      assert(irq >= SPAPR_XIRQ_BASE);
> -    assert((irq + num) <= (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
> +    assert((irq + num) <= (smc->nr_xirqs + SPAPR_XIRQ_BASE));
>  
>      for (i = irq; i < (irq + num); i++) {
>          if (spapr->xive) {
> @@ -402,6 +402,8 @@ void spapr_irq_free(SpaprMachineState *spapr, int irq, int num)
>  
>  qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq)
>  {
> +    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
> +
>      /*
>       * This interface is basically for VIO and PHB devices to find the
>       * right qemu_irq to manipulate, so we only allow access to the
> @@ -410,7 +412,7 @@ qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq)
>       * interfaces, we can change this if we need to in future.
>       */
>      assert(irq >= SPAPR_XIRQ_BASE);
> -    assert(irq < (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
> +    assert(irq < (smc->nr_xirqs + SPAPR_XIRQ_BASE));
>  
>      if (spapr->ics) {
>          assert(ics_valid_irq(spapr->ics, irq));
> @@ -563,10 +565,7 @@ int spapr_irq_find(SpaprMachineState *spapr, int num, bool align, Error **errp)
>      return first + ics->offset;
>  }
>  
> -#define SPAPR_IRQ_XICS_LEGACY_NR_XIRQS     0x400
> -
>  SpaprIrq spapr_irq_xics_legacy = {
> -    .nr_xirqs    = SPAPR_IRQ_XICS_LEGACY_NR_XIRQS,
>      .xics        = true,
>      .xive        = false,
>  };
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 763da757f0..623e8e3f93 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -119,6 +119,7 @@ struct SpaprMachineClass {
>      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
>      bool pre_2_10_has_unused_icps;
>      bool legacy_irq_allocation;
> +    uint32_t nr_xirqs;
>      bool broken_host_serial_model; /* present real host info to the guest */
>      bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
>      bool linux_pci_probe;
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 308bfcefd1..73d8beda39 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -77,7 +77,6 @@ int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool align,
>  void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t num);
>  
>  typedef struct SpaprIrq {
> -    uint32_t    nr_xirqs;
>      bool        xics;
>      bool        xive;
>  } SpaprIrq;


