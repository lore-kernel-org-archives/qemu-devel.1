Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A911C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 07:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2BAB20640
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 07:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2BAB20640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCfQ0-00006g-4t
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 03:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iCfP8-0007tk-Mk
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 03:38:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iCfP5-0007QZ-Gk
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 03:38:34 -0400
Received: from 5.mo68.mail-out.ovh.net ([46.105.62.179]:57301)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iCfP5-0007Oj-7D
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 03:38:31 -0400
Received: from player688.ha.ovh.net (unknown [10.109.160.5])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id BFDCE141860
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 09:38:28 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id DEF93A124FDD;
 Tue, 24 Sep 2019 07:38:23 +0000 (UTC)
Date: Tue, 24 Sep 2019 09:38:22 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 3/4] xics: Rename misleading ics_simple_*() functions
Message-ID: <20190924093822.78c2037d@bahia.lan>
In-Reply-To: <20190924045952.11412-4-david@gibson.dropbear.id.au>
References: <20190924045952.11412-1-david@gibson.dropbear.id.au>
 <20190924045952.11412-4-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 14408141111332542950
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdelgdduvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.62.179
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
Cc: gkurz@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Sep 2019 14:59:51 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> There are a number of ics_simple_*() functions that aren't actually
> specific to TYPE_XICS_SIMPLE at all, and are equally valid on
> TYPE_XICS_BASE.  Rename them to ics_*() accordingly.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/intc/trace-events  |  6 +++---
>  hw/intc/xics.c        | 29 ++++++++++++++---------------
>  hw/intc/xics_spapr.c  | 12 ++++++------
>  hw/ppc/pnv_psi.c      |  4 ++--
>  hw/ppc/spapr_irq.c    |  2 +-
>  include/hw/ppc/xics.h |  6 +++---
>  6 files changed, 29 insertions(+), 30 deletions(-)
> 
> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
> index fdc716c2cc..527c3f76ca 100644
> --- a/hw/intc/trace-events
> +++ b/hw/intc/trace-events
> @@ -66,10 +66,10 @@ xics_icp_accept(uint32_t old_xirr, uint32_t new_xirr) "icp_accept: XIRR 0x%"PRIx
>  xics_icp_eoi(int server, uint32_t xirr, uint32_t new_xirr) "icp_eoi: server %d given XIRR 0x%"PRIx32" new XIRR 0x%"PRIx32
>  xics_icp_irq(int server, int nr, uint8_t priority) "cpu %d trying to deliver irq 0x%"PRIx32" priority 0x%x"
>  xics_icp_raise(uint32_t xirr, uint8_t pending_priority) "raising IRQ new XIRR=0x%x new pending priority=0x%x"
> -xics_ics_simple_set_irq_msi(int srcno, int nr) "set_irq_msi: srcno %d [irq 0x%x]"
> +xics_ics_set_irq_msi(int srcno, int nr) "set_irq_msi: srcno %d [irq 0x%x]"
>  xics_masked_pending(void) "set_irq_msi: masked pending"
> -xics_ics_simple_set_irq_lsi(int srcno, int nr) "set_irq_lsi: srcno %d [irq 0x%x]"
> -xics_ics_simple_write_xive(int nr, int srcno, int server, uint8_t priority) "ics_write_xive: irq 0x%x [src %d] server 0x%x prio 0x%x"
> +xics_ics_set_irq_lsi(int srcno, int nr) "set_irq_lsi: srcno %d [irq 0x%x]"
> +xics_ics_write_xive(int nr, int srcno, int server, uint8_t priority) "ics_write_xive: irq 0x%x [src %d] server 0x%x prio 0x%x"
>  xics_ics_reject(int nr, int srcno) "reject irq 0x%x [src %d]"
>  xics_ics_eoi(int nr) "ics_eoi: irq 0x%x"
>  
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index db0e532bd9..9ae51bbc76 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -428,11 +428,11 @@ static void ics_resend_lsi(ICSState *ics, int srcno)
>      }
>  }
>  
> -static void ics_simple_set_irq_msi(ICSState *ics, int srcno, int val)
> +static void ics_set_irq_msi(ICSState *ics, int srcno, int val)
>  {
>      ICSIRQState *irq = ics->irqs + srcno;
>  
> -    trace_xics_ics_simple_set_irq_msi(srcno, srcno + ics->offset);
> +    trace_xics_ics_set_irq_msi(srcno, srcno + ics->offset);
>  
>      if (val) {
>          if (irq->priority == 0xff) {
> @@ -444,11 +444,11 @@ static void ics_simple_set_irq_msi(ICSState *ics, int srcno, int val)
>      }
>  }
>  
> -static void ics_simple_set_irq_lsi(ICSState *ics, int srcno, int val)
> +static void ics_set_irq_lsi(ICSState *ics, int srcno, int val)
>  {
>      ICSIRQState *irq = ics->irqs + srcno;
>  
> -    trace_xics_ics_simple_set_irq_lsi(srcno, srcno + ics->offset);
> +    trace_xics_ics_set_irq_lsi(srcno, srcno + ics->offset);
>      if (val) {
>          irq->status |= XICS_STATUS_ASSERTED;
>      } else {
> @@ -457,7 +457,7 @@ static void ics_simple_set_irq_lsi(ICSState *ics, int srcno, int val)
>      ics_resend_lsi(ics, srcno);
>  }
>  
> -void ics_simple_set_irq(void *opaque, int srcno, int val)
> +void ics_set_irq(void *opaque, int srcno, int val)
>  {
>      ICSState *ics = (ICSState *)opaque;
>  
> @@ -467,13 +467,13 @@ void ics_simple_set_irq(void *opaque, int srcno, int val)
>      }
>  
>      if (ics->irqs[srcno].flags & XICS_FLAGS_IRQ_LSI) {
> -        ics_simple_set_irq_lsi(ics, srcno, val);
> +        ics_set_irq_lsi(ics, srcno, val);
>      } else {
> -        ics_simple_set_irq_msi(ics, srcno, val);
> +        ics_set_irq_msi(ics, srcno, val);
>      }
>  }
>  
> -static void ics_simple_write_xive_msi(ICSState *ics, int srcno)
> +static void ics_write_xive_msi(ICSState *ics, int srcno)
>  {
>      ICSIRQState *irq = ics->irqs + srcno;
>  
> @@ -486,13 +486,13 @@ static void ics_simple_write_xive_msi(ICSState *ics, int srcno)
>      icp_irq(ics, irq->server, srcno + ics->offset, irq->priority);
>  }
>  
> -static void ics_simple_write_xive_lsi(ICSState *ics, int srcno)
> +static void ics_write_xive_lsi(ICSState *ics, int srcno)
>  {
>      ics_resend_lsi(ics, srcno);
>  }
>  
> -void ics_simple_write_xive(ICSState *ics, int srcno, int server,
> -                           uint8_t priority, uint8_t saved_priority)
> +void ics_write_xive(ICSState *ics, int srcno, int server,
> +                    uint8_t priority, uint8_t saved_priority)
>  {
>      ICSIRQState *irq = ics->irqs + srcno;
>  
> @@ -500,13 +500,12 @@ void ics_simple_write_xive(ICSState *ics, int srcno, int server,
>      irq->priority = priority;
>      irq->saved_priority = saved_priority;
>  
> -    trace_xics_ics_simple_write_xive(ics->offset + srcno, srcno, server,
> -                                     priority);
> +    trace_xics_ics_write_xive(ics->offset + srcno, srcno, server, priority);
>  
>      if (ics->irqs[srcno].flags & XICS_FLAGS_IRQ_LSI) {
> -        ics_simple_write_xive_lsi(ics, srcno);
> +        ics_write_xive_lsi(ics, srcno);
>      } else {
> -        ics_simple_write_xive_msi(ics, srcno);
> +        ics_write_xive_msi(ics, srcno);
>      }
>  }
>  
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 6577be0d92..3e9444813a 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -179,7 +179,7 @@ static void rtas_set_xive(PowerPCCPU *cpu, SpaprMachineState *spapr,
>      }
>  
>      srcno = nr - ics->offset;
> -    ics_simple_write_xive(ics, srcno, server, priority, priority);
> +    ics_write_xive(ics, srcno, server, priority, priority);
>  
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
> @@ -243,8 +243,8 @@ static void rtas_int_off(PowerPCCPU *cpu, SpaprMachineState *spapr,
>      }
>  
>      srcno = nr - ics->offset;
> -    ics_simple_write_xive(ics, srcno, ics->irqs[srcno].server, 0xff,
> -                          ics->irqs[srcno].priority);
> +    ics_write_xive(ics, srcno, ics->irqs[srcno].server, 0xff,
> +                   ics->irqs[srcno].priority);
>  
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
> @@ -276,9 +276,9 @@ static void rtas_int_on(PowerPCCPU *cpu, SpaprMachineState *spapr,
>      }
>  
>      srcno = nr - ics->offset;
> -    ics_simple_write_xive(ics, srcno, ics->irqs[srcno].server,
> -                          ics->irqs[srcno].saved_priority,
> -                          ics->irqs[srcno].saved_priority);
> +    ics_write_xive(ics, srcno, ics->irqs[srcno].server,
> +                   ics->irqs[srcno].saved_priority,
> +                   ics->irqs[srcno].saved_priority);
>  
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 88ba8e7b9b..8ea81e9d8e 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -311,7 +311,7 @@ static void pnv_psi_set_xivr(PnvPsi *psi, uint32_t reg, uint64_t val)
>       * do for now but a more accurate implementation would instead
>       * use a fixed server/prio and a remapper of the generated irq.
>       */
> -    ics_simple_write_xive(ics, src, server, prio, prio);
> +    ics_write_xive(ics, src, server, prio, prio);
>  }
>  
>  static uint64_t pnv_psi_reg_read(PnvPsi *psi, uint32_t offset, bool mmio)
> @@ -514,7 +514,7 @@ static void pnv_psi_power8_realize(DeviceState *dev, Error **errp)
>          ics_set_irq_type(ics, i, true);
>      }
>  
> -    psi->qirqs = qemu_allocate_irqs(ics_simple_set_irq, ics, ics->nr_irqs);
> +    psi->qirqs = qemu_allocate_irqs(ics_set_irq, ics, ics->nr_irqs);
>  
>      /* XSCOM region for PSI registers */
>      pnv_xscom_region_init(&psi->xscom_regs, OBJECT(dev), &pnv_psi_xscom_ops,
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index d8f46b6797..ac189c5796 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -210,7 +210,7 @@ static void spapr_irq_set_irq_xics(void *opaque, int srcno, int val)
>  {
>      SpaprMachineState *spapr = opaque;
>  
> -    ics_simple_set_irq(spapr->ics, srcno, val);
> +    ics_set_irq(spapr->ics, srcno, val);
>  }
>  
>  static void spapr_irq_reset_xics(SpaprMachineState *spapr, Error **errp)
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 0eb39c2561..92628e7cab 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -168,9 +168,9 @@ uint32_t icp_accept(ICPState *ss);
>  uint32_t icp_ipoll(ICPState *ss, uint32_t *mfrr);
>  void icp_eoi(ICPState *icp, uint32_t xirr);
>  
> -void ics_simple_write_xive(ICSState *ics, int nr, int server,
> -                           uint8_t priority, uint8_t saved_priority);
> -void ics_simple_set_irq(void *opaque, int srcno, int val);
> +void ics_write_xive(ICSState *ics, int nr, int server,
> +                    uint8_t priority, uint8_t saved_priority);
> +void ics_set_irq(void *opaque, int srcno, int val);
>  
>  static inline bool ics_irq_free(ICSState *ics, uint32_t srcno)
>  {


