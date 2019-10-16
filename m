Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F2CFA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D91E21A4C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D91E21A4C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKlu2-0004RC-3G
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 12:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iKlmh-0005Qs-S3
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iKlmg-0000lD-2o
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:04:23 -0400
Received: from 19.mo7.mail-out.ovh.net ([178.33.251.118]:47485)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iKlmf-0000jV-Rq
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:04:22 -0400
Received: from player691.ha.ovh.net (unknown [10.108.35.12])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 4C5DA137B14
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 18:04:19 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player691.ha.ovh.net (Postfix) with ESMTPSA id B00C8B24DBDF;
 Wed, 16 Oct 2019 16:04:06 +0000 (UTC)
Date: Wed, 16 Oct 2019 18:04:04 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v4 00/19] spapr: IRQ subsystem cleanup
Message-ID: <20191016180404.6cbfce9f@bahia.lan>
In-Reply-To: <20191009060818.29719-1-david@gibson.dropbear.id.au>
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 4576220172858202598
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrjeehgdelkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.251.118
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
 clg@kaod.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  9 Oct 2019 17:07:59 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> This is a substantial rework to clean up the handling of IRQs in
> spapr.  It includes some cleanups to both the XICS and XIVE interrupt
> controller backends, as well as more to the common spapr irq handling
> infrastructure.
> 

Patches up to 16 have been reviewed. Any chance you merge them before
soft freeze (12 days left) ?

> The last two patches of this series, dealing with VFIO devices, are
> RFC only - there some problems that I'm discussing with Alex
> Williamson.
> 
> Changes since v3:
>  * Further minor tweaks to error handling
>  * Other minor polishes from feedback
>  * Added some patches to address VFIO irq routing
>  * Removed the first ~20 patches, which are now merged
> 
> Changes since v2:
>  * Fixed a bug where the "move handling multiple irq frees" to
>    frontend patch was actually freeing one irq over and over, rather
>    than freeing multiple irqs
>  * Fixed some places I missed still using only-Error * style, and flow
>    on adjustments
>  * New idiom to iterate across all constructed backends for the things
>    that need that (cpu_intc_create, claim & freem), rather than
>    open-coding a call on the xics, then xive versions.
> 
> Changes since v1:
>  * Lots of extra patches
>  * Many minor adjustments based on feedback
>  * Moved towards return value + Error * style, instead of just Error *
>    style
> 
> David Gibson (16):
>   spapr, xics, xive: Introduce SpaprInterruptController QOM interface
>   spapr, xics, xive: Move cpu_intc_create from SpaprIrq to
>     SpaprInterruptController
>   spapr, xics, xive: Move irq claim and free from SpaprIrq to
>     SpaprInterruptController
>   spapr: Formalize notion of active interrupt controller
>   spapr, xics, xive: Move set_irq from SpaprIrq to
>     SpaprInterruptController
>   spapr, xics, xive: Move print_info from SpaprIrq to
>     SpaprInterruptController
>   spapr, xics, xive: Move dt_populate from SpaprIrq to
>     SpaprInterruptController
>   spapr, xics, xive: Match signatures for XICS and XIVE KVM connect
>     routines
>   spapr: Remove SpaprIrq::init_kvm hook
>   spapr, xics, xive: Move SpaprIrq::reset hook logic into
>     activate/deactivate
>   spapr, xics, xive: Move SpaprIrq::post_load hook to backends
>   spapr: Remove SpaprIrq::nr_msis
>   spapr: Move SpaprIrq::nr_xirqs to SpaprMachineClass
>   spapr: Remove last pieces of SpaprIrq
>   spapr: Handle irq backend changes with VFIO PCI devices
>   spapr: Work around spurious warnings from vfio INTx initialization
> 
> Greg Kurz (2):
>   xive: Make some device types not user creatable
>   xics: Make some device types not user creatable
> 
> Stefan Brankovic (1):
>   target/ppc: Fix for optimized vsl/vsr instructions
> 
>  hw/intc/spapr_xive.c                | 295 ++++++++----
>  hw/intc/spapr_xive_kvm.c            |  22 +-
>  hw/intc/xics.c                      |  10 +
>  hw/intc/xics_kvm.c                  |   9 +-
>  hw/intc/xics_spapr.c                | 110 ++++-
>  hw/intc/xive.c                      |  15 +
>  hw/ppc/spapr.c                      |  52 ++-
>  hw/ppc/spapr_caps.c                 |  64 +++
>  hw/ppc/spapr_cpu_core.c             |   3 +-
>  hw/ppc/spapr_hcall.c                |   7 +-
>  hw/ppc/spapr_irq.c                  | 668 +++++++++-------------------
>  hw/ppc/spapr_pci.c                  |  16 +-
>  include/hw/pci-host/spapr.h         |   4 +-
>  include/hw/ppc/spapr.h              |  17 +-
>  include/hw/ppc/spapr_irq.h          |  72 +--
>  include/hw/ppc/spapr_xive.h         |   9 +-
>  include/hw/ppc/xics_spapr.h         |   6 +-
>  target/ppc/translate/vmx-impl.inc.c |  84 ++--
>  18 files changed, 769 insertions(+), 694 deletions(-)
> 


