Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4212DC432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 07:51:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1633E2146E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 07:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1633E2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDOZ1-0007dJ-AK
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 03:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDOYH-0006jX-I1
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDOYG-0006QG-J6
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:51:01 -0400
Received: from 11.mo5.mail-out.ovh.net ([46.105.47.167]:58387)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDOYG-0006MD-E3
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:51:00 -0400
Received: from player714.ha.ovh.net (unknown [10.109.159.248])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 9357A24F47D
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:50:54 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player714.ha.ovh.net (Postfix) with ESMTPSA id 3D7D8A2F1281;
 Thu, 26 Sep 2019 07:50:43 +0000 (UTC)
Date: Thu, 26 Sep 2019 09:50:42 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 14/20] spapr: Remove unhelpful tracepoints from
 spapr_irq_free_xics()
Message-ID: <20190926095042.77084134@bahia.lan>
In-Reply-To: <20190925064534.19155-15-david@gibson.dropbear.id.au>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-15-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7916765198695307750
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeefgdduvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.47.167
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

On Wed, 25 Sep 2019 16:45:28 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> These traces contain some useless information (the always-0 source#) and
> have no equivalents for XIVE mode.  For now just remove them, and we can
> put back something more sensible if and when we need it.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_irq.c  | 4 ----
>  hw/ppc/trace-events | 4 ----
>  2 files changed, 8 deletions(-)
> 
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 79167ccc68..db6755f3ab 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -140,11 +140,7 @@ static void spapr_irq_free_xics(SpaprMachineState *spapr, int irq, int num)
>      int i;
>  
>      if (ics_valid_irq(ics, irq)) {
> -        trace_spapr_irq_free(0, irq, num);
>          for (i = srcno; i < srcno + num; ++i) {
> -            if (ics_irq_free(ics, i)) {
> -                trace_spapr_irq_free_warn(0, i);
> -            }
>              memset(&ics->irqs[i], 0, sizeof(ICSIRQState));
>          }
>      }
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index 96dad767a1..9ea620f23c 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -13,10 +13,6 @@ spapr_pci_msi_retry(unsigned config_addr, unsigned req_num, unsigned max_irqs) "
>  spapr_cas_failed(unsigned long n) "DT diff buffer is too small: %ld bytes"
>  spapr_cas_continue(unsigned long n) "Copy changes to the guest: %ld bytes"
>  
> -# spapr_irq.c
> -spapr_irq_free(int src, int irq, int num) "Source#%d, first irq %d, %d irqs"
> -spapr_irq_free_warn(int src, int irq) "Source#%d, irq %d is already free"
> -
>  # spapr_hcall.c
>  spapr_cas_pvr(uint32_t cur_pvr, bool explicit_match, uint32_t new_pvr) "current=0x%x, explicit_match=%u, new=0x%x"
>  spapr_h_resize_hpt_prepare(uint64_t flags, uint64_t shift) "flags=0x%"PRIx64", shift=%"PRIu64


