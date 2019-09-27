Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B19C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D3E520872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3E520872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDtkr-00082t-T5
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 13:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDrZb-0000J0-7A
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:50:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDrZY-00018x-6c
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:50:18 -0400
Received: from 3.mo6.mail-out.ovh.net ([178.33.253.26]:43433)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDrZX-00017Z-LR
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:50:16 -0400
Received: from player795.ha.ovh.net (unknown [10.108.57.95])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 044231E14CE
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 16:50:12 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player795.ha.ovh.net (Postfix) with ESMTPSA id EA5D5A3E2E69;
 Fri, 27 Sep 2019 14:49:59 +0000 (UTC)
Date: Fri, 27 Sep 2019 16:49:58 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 27/33] spapr, xics, xive: Match signatures for XICS
 and XIVE KVM connect routines
Message-ID: <20190927164958.4949f83b@bahia.lan>
In-Reply-To: <20190927055028.11493-28-david@gibson.dropbear.id.au>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-28-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2424062501213346278
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeeigdektdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.253.26
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

On Fri, 27 Sep 2019 15:50:22 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> Both XICS and XIVE have routines to connect and disconnect KVM with similar
> but not identical signatures.  This adjusts them to match exactly, which

Maybe mention this includes a return value to be able to streamline error
reporting.

> will be useful for further cleanups later.
> 
> While we're at it, remove error reporting from the disconnect path.  In the
> XICS case this wasn't used at all.  In the XIVE case the only error case
> was if the KVM device was set up, but KVM didn't have the capability to do
> so which is pretty obviously impossible.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/intc/spapr_xive_kvm.c    | 22 ++++++++++------------
>  hw/intc/xics_kvm.c          |  9 +++++----
>  hw/ppc/spapr_irq.c          | 22 +++++-----------------
>  include/hw/ppc/spapr_xive.h |  4 ++--
>  include/hw/ppc/xics_spapr.h |  4 ++--
>  5 files changed, 24 insertions(+), 37 deletions(-)
> 
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 51b334b676..08012ac7cd 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -740,8 +740,9 @@ static void *kvmppc_xive_mmap(SpaprXive *xive, int pgoff, size_t len,
>   * All the XIVE memory regions are now backed by mappings from the KVM
>   * XIVE device.
>   */
> -void kvmppc_xive_connect(SpaprXive *xive, Error **errp)
> +int kvmppc_xive_connect(SpaprInterruptController *intc, Error **errp)
>  {
> +    SpaprXive *xive = SPAPR_XIVE(intc);
>      XiveSource *xsrc = &xive->source;
>      Error *local_err = NULL;
>      size_t esb_len = (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
> @@ -753,19 +754,19 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **errp)
>       * rebooting under the XIVE-only interrupt mode.
>       */
>      if (xive->fd != -1) {
> -        return;
> +        return 0;
>      }
>  
>      if (!kvmppc_has_cap_xive()) {
>          error_setg(errp, "IRQ_XIVE capability must be present for KVM");
> -        return;
> +        return -1;
>      }
>  
>      /* First, create the KVM XIVE device */
>      xive->fd = kvm_create_device(kvm_state, KVM_DEV_TYPE_XIVE, false);
>      if (xive->fd < 0) {
>          error_setg_errno(errp, -xive->fd, "XIVE: error creating KVM device");
> -        return;
> +        return -1;
>      }
>  
>      /*
> @@ -821,15 +822,17 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **errp)
>      kvm_kernel_irqchip = true;
>      kvm_msi_via_irqfd_allowed = true;
>      kvm_gsi_direct_mapping = true;
> -    return;
> +    return 0;
>  
>  fail:
>      error_propagate(errp, local_err);
> -    kvmppc_xive_disconnect(xive, NULL);
> +    kvmppc_xive_disconnect(intc);
> +    return -1;
>  }
>  
> -void kvmppc_xive_disconnect(SpaprXive *xive, Error **errp)
> +void kvmppc_xive_disconnect(SpaprInterruptController *intc)
>  {
> +    SpaprXive *xive = SPAPR_XIVE(intc);
>      XiveSource *xsrc;
>      size_t esb_len;
>  
> @@ -838,11 +841,6 @@ void kvmppc_xive_disconnect(SpaprXive *xive, Error **errp)
>          return;
>      }
>  
> -    if (!kvmppc_has_cap_xive()) {
> -        error_setg(errp, "IRQ_XIVE capability must be present for KVM");
> -        return;
> -    }
> -
>      /* Clear the KVM mapping */
>      xsrc = &xive->source;
>      esb_len = (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index ba90d6dc96..954c424b36 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -342,8 +342,9 @@ void ics_kvm_set_irq(ICSState *ics, int srcno, int val)
>      }
>  }
>  
> -int xics_kvm_connect(SpaprMachineState *spapr, Error **errp)
> +int xics_kvm_connect(SpaprInterruptController *intc, Error **errp)
>  {
> +    ICSState *ics = ICS_SPAPR(intc);
>      int rc;
>      CPUState *cs;
>      Error *local_err = NULL;
> @@ -413,7 +414,7 @@ int xics_kvm_connect(SpaprMachineState *spapr, Error **errp)
>      }
>  
>      /* Update the KVM sources */
> -    ics_set_kvm_state(spapr->ics, &local_err);
> +    ics_set_kvm_state(ics, &local_err);
>      if (local_err) {
>          goto fail;
>      }
> @@ -431,11 +432,11 @@ int xics_kvm_connect(SpaprMachineState *spapr, Error **errp)
>  
>  fail:
>      error_propagate(errp, local_err);
> -    xics_kvm_disconnect(spapr, NULL);
> +    xics_kvm_disconnect(intc);
>      return -1;
>  }
>  
> -void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp)
> +void xics_kvm_disconnect(SpaprInterruptController *intc)
>  {
>      /*
>       * Only on P9 using the XICS-on XIVE KVM device:
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 79cbe8064e..561bdbc4de 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -124,7 +124,7 @@ static void spapr_irq_reset_xics(SpaprMachineState *spapr, Error **errp)
>  static void spapr_irq_init_kvm_xics(SpaprMachineState *spapr, Error **errp)
>  {
>      if (kvm_enabled()) {
> -        xics_kvm_connect(spapr, errp);
> +        xics_kvm_connect(SPAPR_INTC(spapr->ics), errp);
>      }
>  }
>  
> @@ -173,7 +173,7 @@ static void spapr_irq_reset_xive(SpaprMachineState *spapr, Error **errp)
>  static void spapr_irq_init_kvm_xive(SpaprMachineState *spapr, Error **errp)
>  {
>      if (kvm_enabled()) {
> -        kvmppc_xive_connect(spapr->xive, errp);
> +        kvmppc_xive_connect(SPAPR_INTC(spapr->xive), errp);
>      }
>  }
>  
> @@ -215,7 +215,7 @@ static int spapr_irq_post_load_dual(SpaprMachineState *spapr, int version_id)
>       */
>      if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
>          if (kvm_irqchip_in_kernel()) {
> -            xics_kvm_disconnect(spapr, &error_fatal);
> +            xics_kvm_disconnect(SPAPR_INTC(spapr->ics));
>          }
>          spapr_irq_xive.reset(spapr, &error_fatal);
>      }
> @@ -225,8 +225,6 @@ static int spapr_irq_post_load_dual(SpaprMachineState *spapr, int version_id)
>  
>  static void spapr_irq_reset_dual(SpaprMachineState *spapr, Error **errp)
>  {
> -    Error *local_err = NULL;
> -
>      /*
>       * Deactivate the XIVE MMIOs. The XIVE backend will reenable them
>       * if selected.
> @@ -235,18 +233,8 @@ static void spapr_irq_reset_dual(SpaprMachineState *spapr, Error **errp)
>  
>      /* Destroy all KVM devices */
>      if (kvm_irqchip_in_kernel()) {
> -        xics_kvm_disconnect(spapr, &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            error_prepend(errp, "KVM XICS disconnect failed: ");
> -            return;
> -        }
> -        kvmppc_xive_disconnect(spapr->xive, &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            error_prepend(errp, "KVM XIVE disconnect failed: ");
> -            return;
> -        }
> +        xics_kvm_disconnect(SPAPR_INTC(spapr->ics));
> +        kvmppc_xive_disconnect(SPAPR_INTC(spapr->xive));
>      }
>  
>      spapr_irq_current(spapr)->reset(spapr, errp);
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index ebe156eb30..64972754f9 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -68,8 +68,8 @@ int spapr_xive_end_to_target(uint8_t end_blk, uint32_t end_idx,
>  /*
>   * KVM XIVE device helpers
>   */
> -void kvmppc_xive_connect(SpaprXive *xive, Error **errp);
> -void kvmppc_xive_disconnect(SpaprXive *xive, Error **errp);
> +int kvmppc_xive_connect(SpaprInterruptController *intc, Error **errp);
> +void kvmppc_xive_disconnect(SpaprInterruptController *intc);
>  void kvmppc_xive_reset(SpaprXive *xive, Error **errp);
>  void kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveEAS *eas,
>                                     Error **errp);
> diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
> index 9c9044db65..445beeffef 100644
> --- a/include/hw/ppc/xics_spapr.h
> +++ b/include/hw/ppc/xics_spapr.h
> @@ -33,8 +33,8 @@
>  #define ICS_SPAPR(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SPAPR)
>  
>  void ics_spapr_create(SpaprMachineState *spapr, int nr_xirqs, Error **errp);
> -int xics_kvm_connect(SpaprMachineState *spapr, Error **errp);
> -void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp);
> +int xics_kvm_connect(SpaprInterruptController *intc, Error **errp);
> +void xics_kvm_disconnect(SpaprInterruptController *intc);
>  bool xics_kvm_has_broken_disconnect(SpaprMachineState *spapr);
>  
>  #endif /* XICS_SPAPR_H */


