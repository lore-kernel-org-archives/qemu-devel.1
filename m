Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE739C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 07:30:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 832AE214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 07:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 832AE214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCfHY-0001kH-II
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 03:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iCfFc-0000ip-Rn
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 03:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iCfFb-0002wN-9s
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 03:28:44 -0400
Received: from 8.mo3.mail-out.ovh.net ([87.98.172.249]:40352)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iCfFb-0002vH-3R
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 03:28:43 -0400
Received: from player761.ha.ovh.net (unknown [10.108.42.102])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id D29AB228D3C
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 09:28:40 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player761.ha.ovh.net (Postfix) with ESMTPSA id F362AA28FA3B;
 Tue, 24 Sep 2019 07:28:34 +0000 (UTC)
Date: Tue, 24 Sep 2019 09:28:32 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 1/4] xics: Eliminate 'reject', 'resend' and 'eoi' class
 hooks
Message-ID: <20190924092832.09452db5@bahia.lan>
In-Reply-To: <20190924045952.11412-2-david@gibson.dropbear.id.au>
References: <20190924045952.11412-1-david@gibson.dropbear.id.au>
 <20190924045952.11412-2-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 14242633823946971622
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdelgdduvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.172.249
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

On Tue, 24 Sep 2019 14:59:49 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> Currently ics_reject(), ics_resend() and ics_eoi() indirect through
> class methods.  But there's only one implementation of each method,
> the one in TYPE_ICS_SIMPLE.  TYPE_ICS_BASE has no implementation, but
> it's never instantiated, and has no other subtypes.
> 
> So clean up by eliminating the method and just having ics_reject(),
> ics_resend() and ics_eoi() contain the logic directly.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/intc/trace-events  |  4 ++--
>  hw/intc/xics.c        | 54 +++++++++++--------------------------------
>  include/hw/ppc/xics.h |  4 ----
>  3 files changed, 15 insertions(+), 47 deletions(-)
> 
> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
> index 719f46b516..fdc716c2cc 100644
> --- a/hw/intc/trace-events
> +++ b/hw/intc/trace-events
> @@ -70,8 +70,8 @@ xics_ics_simple_set_irq_msi(int srcno, int nr) "set_irq_msi: srcno %d [irq 0x%x]
>  xics_masked_pending(void) "set_irq_msi: masked pending"
>  xics_ics_simple_set_irq_lsi(int srcno, int nr) "set_irq_lsi: srcno %d [irq 0x%x]"
>  xics_ics_simple_write_xive(int nr, int srcno, int server, uint8_t priority) "ics_write_xive: irq 0x%x [src %d] server 0x%x prio 0x%x"
> -xics_ics_simple_reject(int nr, int srcno) "reject irq 0x%x [src %d]"
> -xics_ics_simple_eoi(int nr) "ics_eoi: irq 0x%x"
> +xics_ics_reject(int nr, int srcno) "reject irq 0x%x [src %d]"
> +xics_ics_eoi(int nr) "ics_eoi: irq 0x%x"
>  
>  # s390_flic_kvm.c
>  flic_create_device(int err) "flic: create device failed %d"
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index b2fca2975c..93139b0189 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -98,32 +98,8 @@ void ics_pic_print_info(ICSState *ics, Monitor *mon)
>  #define XISR(icp)   (((icp)->xirr) & XISR_MASK)
>  #define CPPR(icp)   (((icp)->xirr) >> 24)
>  
> -static void ics_reject(ICSState *ics, uint32_t nr)
> -{
> -    ICSStateClass *k = ICS_BASE_GET_CLASS(ics);
> -
> -    if (k->reject) {
> -        k->reject(ics, nr);
> -    }
> -}
> -
> -void ics_resend(ICSState *ics)
> -{
> -    ICSStateClass *k = ICS_BASE_GET_CLASS(ics);
> -
> -    if (k->resend) {
> -        k->resend(ics);
> -    }
> -}
> -
> -static void ics_eoi(ICSState *ics, int nr)
> -{
> -    ICSStateClass *k = ICS_BASE_GET_CLASS(ics);
> -
> -    if (k->eoi) {
> -        k->eoi(ics, nr);
> -    }
> -}
> +static void ics_reject(ICSState *ics, uint32_t nr);
> +static void ics_eoi(ICSState *ics, uint32_t nr);
>  
>  static void icp_check_ipi(ICPState *icp)
>  {
> @@ -427,7 +403,7 @@ Object *icp_create(Object *cpu, const char *type, XICSFabric *xi, Error **errp)
>  /*
>   * ICS: Source layer
>   */
> -static void ics_simple_resend_msi(ICSState *ics, int srcno)
> +static void ics_resend_msi(ICSState *ics, int srcno)
>  {
>      ICSIRQState *irq = ics->irqs + srcno;
>  
> @@ -440,7 +416,7 @@ static void ics_simple_resend_msi(ICSState *ics, int srcno)
>      }
>  }
>  
> -static void ics_simple_resend_lsi(ICSState *ics, int srcno)
> +static void ics_resend_lsi(ICSState *ics, int srcno)
>  {
>      ICSIRQState *irq = ics->irqs + srcno;
>  
> @@ -478,7 +454,7 @@ static void ics_simple_set_irq_lsi(ICSState *ics, int srcno, int val)
>      } else {
>          irq->status &= ~XICS_STATUS_ASSERTED;
>      }
> -    ics_simple_resend_lsi(ics, srcno);
> +    ics_resend_lsi(ics, srcno);
>  }
>  
>  void ics_simple_set_irq(void *opaque, int srcno, int val)
> @@ -512,7 +488,7 @@ static void ics_simple_write_xive_msi(ICSState *ics, int srcno)
>  
>  static void ics_simple_write_xive_lsi(ICSState *ics, int srcno)
>  {
> -    ics_simple_resend_lsi(ics, srcno);
> +    ics_resend_lsi(ics, srcno);
>  }
>  
>  void ics_simple_write_xive(ICSState *ics, int srcno, int server,
> @@ -534,11 +510,11 @@ void ics_simple_write_xive(ICSState *ics, int srcno, int server,
>      }
>  }
>  
> -static void ics_simple_reject(ICSState *ics, uint32_t nr)
> +static void ics_reject(ICSState *ics, uint32_t nr)
>  {
>      ICSIRQState *irq = ics->irqs + nr - ics->offset;
>  
> -    trace_xics_ics_simple_reject(nr, nr - ics->offset);
> +    trace_xics_ics_reject(nr, nr - ics->offset);
>      if (irq->flags & XICS_FLAGS_IRQ_MSI) {
>          irq->status |= XICS_STATUS_REJECTED;
>      } else if (irq->flags & XICS_FLAGS_IRQ_LSI) {
> @@ -546,26 +522,26 @@ static void ics_simple_reject(ICSState *ics, uint32_t nr)
>      }
>  }
>  
> -static void ics_simple_resend(ICSState *ics)
> +void ics_resend(ICSState *ics)
>  {
>      int i;
>  
>      for (i = 0; i < ics->nr_irqs; i++) {
>          /* FIXME: filter by server#? */
>          if (ics->irqs[i].flags & XICS_FLAGS_IRQ_LSI) {
> -            ics_simple_resend_lsi(ics, i);
> +            ics_resend_lsi(ics, i);
>          } else {
> -            ics_simple_resend_msi(ics, i);
> +            ics_resend_msi(ics, i);
>          }
>      }
>  }
>  
> -static void ics_simple_eoi(ICSState *ics, uint32_t nr)
> +static void ics_eoi(ICSState *ics, uint32_t nr)
>  {
>      int srcno = nr - ics->offset;
>      ICSIRQState *irq = ics->irqs + srcno;
>  
> -    trace_xics_ics_simple_eoi(nr);
> +    trace_xics_ics_eoi(nr);
>  
>      if (ics->irqs[srcno].flags & XICS_FLAGS_IRQ_LSI) {
>          irq->status &= ~XICS_STATUS_SENT;
> @@ -617,10 +593,6 @@ static void ics_simple_class_init(ObjectClass *klass, void *data)
>                                      &isc->parent_realize);
>      device_class_set_parent_reset(dc, ics_simple_reset,
>                                    &isc->parent_reset);
> -
> -    isc->reject = ics_simple_reject;
> -    isc->resend = ics_simple_resend;
> -    isc->eoi = ics_simple_eoi;
>  }
>  
>  static const TypeInfo ics_simple_info = {
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 64a2c8862a..34d7985b7c 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -106,10 +106,6 @@ struct ICSStateClass {
>  
>      DeviceRealize parent_realize;
>      DeviceReset parent_reset;
> -
> -    void (*reject)(ICSState *s, uint32_t irq);
> -    void (*resend)(ICSState *s);
> -    void (*eoi)(ICSState *s, uint32_t irq);
>  };
>  
>  struct ICSState {


