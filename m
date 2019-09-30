Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAA4C4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 05:40:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9253221855
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 05:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9253221855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEoPo-0004o3-OS
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 01:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iEoP2-0004GY-Gu
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 01:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iEoP1-0007gA-8R
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 01:39:20 -0400
Received: from 8.mo6.mail-out.ovh.net ([178.33.42.204]:46690)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iEoP1-0007ea-03
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 01:39:19 -0400
Received: from player735.ha.ovh.net (unknown [10.109.159.152])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id D7DDF1E1F47
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 07:39:16 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player735.ha.ovh.net (Postfix) with ESMTPSA id CA770A5EC30A;
 Mon, 30 Sep 2019 05:39:05 +0000 (UTC)
Subject: Re: [PATCH v2 23/33] spapr: Formalize notion of active interrupt
 controller
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-24-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <77f60c2e-55a9-c651-936d-457e97cafec4@kaod.org>
Date: Mon, 30 Sep 2019 07:39:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190927055028.11493-24-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 10737707413928643353
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgedugdeljecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.42.204
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

On 27/09/2019 07:50, David Gibson wrote:
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

I don't see the exact benefit of extra pointers and routines as we can 
calculate the exact same state from other pointers. 

> For now we just introduce the switch and hooks, later patches will
> actually start using them.

OK. 

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
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
> 


