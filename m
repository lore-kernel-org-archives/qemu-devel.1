Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199E0C388F3
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 15:19:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7444207E0
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 15:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7444207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDs20-0004Bv-UK
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 11:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDr31-0000D2-Er
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDr2z-0003Bw-Mn
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:16:39 -0400
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:57801)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDr2z-0003BU-Cv
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:16:37 -0400
Received: from player726.ha.ovh.net (unknown [10.109.146.137])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id EFF1A1187B6
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 16:16:34 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player726.ha.ovh.net (Postfix) with ESMTPSA id 2D53BA3ED097;
 Fri, 27 Sep 2019 14:16:23 +0000 (UTC)
Date: Fri, 27 Sep 2019 16:16:22 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 23/33] spapr: Formalize notion of active interrupt
 controller
Message-ID: <20190927161622.2097585b@bahia.lan>
In-Reply-To: <20190927055028.11493-24-david@gibson.dropbear.id.au>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-24-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1856045998940330470
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeeigdejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.40.148
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

On Fri, 27 Sep 2019 15:50:18 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> spapr now has the mechanism of constructing both XICS and XIVE instances of
> the SpaprInterruptController interface.  However, only one of the interrupt
> controllers will actually be active at any given time, depending on feature
> negotiation with the guest.  This is handled in the current code via
> spapr_irq_current() which checks the OV5 vector from feature negotiation to
> determine the current backend.
> 
> Determining the active controller at the point we need it like this
> can be pretty confusing, because it makes it very non obvious at what
> points the active controller can change.  This can make it difficult
> to reason about the code and where a change of active controller could
> appear in sequence with other events.
> 
> Make this mechanism more explicit by adding an 'active_intc' pointer
> and an explicit spapr_irq_update_active_intc() function to update it
> from the CAS state.  We also add hooks on the intc backend which will
> get called when it is activated or deactivated.
> 
> For now we just introduce the switch and hooks, later patches will
> actually start using them.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_irq.c         | 51 ++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h     |  5 ++--
>  include/hw/ppc/spapr_irq.h |  5 ++++
>  3 files changed, 59 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index ea44378d8c..dfa875b7cd 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -593,6 +593,7 @@ qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq)
>  
>  int spapr_irq_post_load(SpaprMachineState *spapr, int version_id)
>  {
> +    spapr_irq_update_active_intc(spapr);
>      return spapr->irq->post_load(spapr, version_id);
>  }
>  
> @@ -600,6 +601,8 @@ void spapr_irq_reset(SpaprMachineState *spapr, Error **errp)
>  {
>      assert(!spapr->irq_map || bitmap_empty(spapr->irq_map, spapr->irq_map_nr));
>  
> +    spapr_irq_update_active_intc(spapr);
> +
>      if (spapr->irq->reset) {
>          spapr->irq->reset(spapr, errp);
>      }
> @@ -626,6 +629,54 @@ int spapr_irq_get_phandle(SpaprMachineState *spapr, void *fdt, Error **errp)
>      return phandle;
>  }
>  
> +static void set_active_intc(SpaprMachineState *spapr,
> +                            SpaprInterruptController *new_intc)
> +{
> +    SpaprInterruptControllerClass *sicc;
> +
> +    assert(new_intc);
> +
> +    if (new_intc == spapr->active_intc) {
> +        /* Nothing to do */
> +        return;
> +    }
> +
> +    if (spapr->active_intc) {
> +        sicc = SPAPR_INTC_GET_CLASS(spapr->active_intc);
> +        if (sicc->deactivate) {
> +            sicc->deactivate(spapr->active_intc);
> +        }
> +    }
> +
> +    sicc = SPAPR_INTC_GET_CLASS(new_intc);
> +    if (sicc->activate) {
> +        sicc->activate(new_intc, &error_fatal);
> +    }
> +
> +    spapr->active_intc = new_intc;
> +}
> +
> +void spapr_irq_update_active_intc(SpaprMachineState *spapr)
> +{
> +    SpaprInterruptController *new_intc;
> +
> +    if (!spapr->ics) {
> +        /*
> +         * XXX before we run CAS, ov5_cas is initialized empty, which
> +         * indicates XICS, even if we have ic-mode=xive.  TODO: clean
> +         * up the CAS path so that we have a clearer way of handling
> +         * this.
> +         */
> +        new_intc = SPAPR_INTC(spapr->xive);
> +    } else if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> +        new_intc = SPAPR_INTC(spapr->xive);
> +    } else {
> +        new_intc = SPAPR_INTC(spapr->ics);
> +    }
> +
> +    set_active_intc(spapr, new_intc);
> +}
> +
>  /*
>   * XICS legacy routines - to deprecate one day
>   */
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index cbd1a4c9f3..763da757f0 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -143,7 +143,6 @@ struct SpaprMachineState {
>      struct SpaprVioBus *vio_bus;
>      QLIST_HEAD(, SpaprPhbState) phbs;
>      struct SpaprNvram *nvram;
> -    ICSState *ics;
>      SpaprRtcState rtc;
>  
>      SpaprResizeHpt resize_hpt;
> @@ -195,9 +194,11 @@ struct SpaprMachineState {
>  
>      int32_t irq_map_nr;
>      unsigned long *irq_map;
> -    SpaprXive  *xive;
>      SpaprIrq *irq;
>      qemu_irq *qirqs;
> +    SpaprInterruptController *active_intc;
> +    ICSState *ics;
> +    SpaprXive *xive;
>  
>      bool cmd_line_caps[SPAPR_CAP_NUM];
>      SpaprCapabilities def, eff, mig;
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 616086f9bb..3102d152b2 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -44,6 +44,9 @@ typedef struct SpaprInterruptController SpaprInterruptController;
>  typedef struct SpaprInterruptControllerClass {
>      InterfaceClass parent;
>  
> +    void (*activate)(SpaprInterruptController *intc, Error **errp);
> +    void (*deactivate)(SpaprInterruptController *intc);
> +
>      /*
>       * These methods will typically be called on all intcs, active and
>       * inactive
> @@ -55,6 +58,8 @@ typedef struct SpaprInterruptControllerClass {
>      void (*free_irq)(SpaprInterruptController *intc, int irq);
>  } SpaprInterruptControllerClass;
>  
> +void spapr_irq_update_active_intc(SpaprMachineState *spapr);
> +
>  void spapr_irq_print_info(SpaprMachineState *spapr, Monitor *mon);
>  void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
>                    void *fdt, uint32_t phandle);


