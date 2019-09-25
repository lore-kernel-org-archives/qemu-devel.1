Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BE3C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 17:15:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0570420872
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 17:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0570420872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDAsq-0004Jn-Sd
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 13:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDArN-00036s-TE
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 13:13:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDArL-0004Iu-U7
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 13:13:49 -0400
Received: from 8.mo5.mail-out.ovh.net ([178.32.116.78]:53333)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDArL-0004Hz-Kv
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 13:13:47 -0400
Received: from player759.ha.ovh.net (unknown [10.108.54.87])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 7DFE924D862
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 19:13:45 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player759.ha.ovh.net (Postfix) with ESMTPSA id 76D94A43A778;
 Wed, 25 Sep 2019 17:13:34 +0000 (UTC)
Date: Wed, 25 Sep 2019 19:13:34 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 09/20] spapr: Clarify and fix handling of nr_irqs
Message-ID: <20190925191334.4597802c@bahia.lan>
In-Reply-To: <20190925064534.19155-10-david@gibson.dropbear.id.au>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-10-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 11549762719980362214
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedvgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.116.78
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

On Wed, 25 Sep 2019 16:45:23 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> Both the XICS and XIVE interrupt backends have a "nr-irqs" property, but
> it means slightly different things.  For XICS (or, strictly, the ICS) it
> indicates the number of "real" external IRQs.  Those start at XICS_IRQ_BASE
> (0x1000) and don't include the special IPI vector.  For XIVE, however, it
> includes the whole IRQ space, including XIVE's many IPI vectors.
> 
> The spapr code currently doesn't handle this sensibly, with the nr_irqs
> value in SpaprIrq having different meanings depending on the backend.
> We fix this by renaming nr_irqs to nr_xirqs and making it always indicate
> just the number of external irqs, adjusting the value we pass to XIVE
> accordingly.  We also use move to using common constants in most of the
                        ^^^
s/use//

> irq configurations, to make it clearer that the IRQ space looks the same
> to the guest (and emulated devices), even if the backend is different.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_irq.c         | 48 +++++++++++++++-----------------------
>  include/hw/ppc/spapr_irq.h | 19 +++++++++------
>  2 files changed, 31 insertions(+), 36 deletions(-)
> 
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 8c26fa2d1e..5190a33e08 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -92,7 +92,7 @@ static void spapr_irq_init_kvm(SpaprMachineState *spapr,
>   * XICS IRQ backend.
>   */
>  
> -static void spapr_irq_init_xics(SpaprMachineState *spapr, int nr_irqs,
> +static void spapr_irq_init_xics(SpaprMachineState *spapr, int nr_xirqs,
>                                  Error **errp)
>  {
>      Object *obj;
> @@ -102,7 +102,7 @@ static void spapr_irq_init_xics(SpaprMachineState *spapr, int nr_irqs,
>      object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
>      object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
>                                     &error_fatal);
> -    object_property_set_int(obj, nr_irqs, "nr-irqs",  &error_fatal);
> +    object_property_set_int(obj, nr_xirqs, "nr-irqs",  &error_fatal);
>      object_property_set_bool(obj, true, "realized", &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> @@ -234,13 +234,9 @@ static void spapr_irq_init_kvm_xics(SpaprMachineState *spapr, Error **errp)
>      }
>  }
>  
> -#define SPAPR_IRQ_XICS_NR_IRQS     0x1000
> -#define SPAPR_IRQ_XICS_NR_MSIS     \
> -    (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
> -
>  SpaprIrq spapr_irq_xics = {
> -    .nr_irqs     = SPAPR_IRQ_XICS_NR_IRQS,
> -    .nr_msis     = SPAPR_IRQ_XICS_NR_MSIS,
> +    .nr_xirqs    = SPAPR_NR_XIRQS,
> +    .nr_msis     = SPAPR_NR_MSIS,
>      .ov5         = SPAPR_OV5_XIVE_LEGACY,
>  
>      .init        = spapr_irq_init_xics,
> @@ -260,7 +256,7 @@ SpaprIrq spapr_irq_xics = {
>  /*
>   * XIVE IRQ backend.
>   */
> -static void spapr_irq_init_xive(SpaprMachineState *spapr, int nr_irqs,
> +static void spapr_irq_init_xive(SpaprMachineState *spapr, int nr_xirqs,
>                                  Error **errp)
>  {
>      uint32_t nr_servers = spapr_max_server_number(spapr);
> @@ -268,7 +264,7 @@ static void spapr_irq_init_xive(SpaprMachineState *spapr, int nr_irqs,
>      int i;
>  
>      dev = qdev_create(NULL, TYPE_SPAPR_XIVE);
> -    qdev_prop_set_uint32(dev, "nr-irqs", nr_irqs);
> +    qdev_prop_set_uint32(dev, "nr-irqs", nr_xirqs + SPAPR_XIRQ_BASE);
>      /*
>       * 8 XIVE END structures per CPU. One for each available priority
>       */
> @@ -308,7 +304,7 @@ static qemu_irq spapr_qirq_xive(SpaprMachineState *spapr, int irq)
>  {
>      SpaprXive *xive = spapr->xive;
>  
> -    if (irq >= xive->nr_irqs) {
> +    if ((irq < SPAPR_XIRQ_BASE) || (irq >= xive->nr_irqs)) {
>          return NULL;
>      }
>  
> @@ -409,12 +405,9 @@ static void spapr_irq_init_kvm_xive(SpaprMachineState *spapr, Error **errp)
>   * with XICS.
>   */
>  
> -#define SPAPR_IRQ_XIVE_NR_IRQS     0x2000
> -#define SPAPR_IRQ_XIVE_NR_MSIS     (SPAPR_IRQ_XIVE_NR_IRQS - SPAPR_IRQ_MSI)
> -
>  SpaprIrq spapr_irq_xive = {
> -    .nr_irqs     = SPAPR_IRQ_XIVE_NR_IRQS,
> -    .nr_msis     = SPAPR_IRQ_XIVE_NR_MSIS,
> +    .nr_xirqs    = SPAPR_NR_XIRQS,
> +    .nr_msis     = SPAPR_NR_MSIS,
>      .ov5         = SPAPR_OV5_XIVE_EXPLOIT,
>  
>      .init        = spapr_irq_init_xive,
> @@ -450,18 +443,18 @@ static SpaprIrq *spapr_irq_current(SpaprMachineState *spapr)
>          &spapr_irq_xive : &spapr_irq_xics;
>  }
>  
> -static void spapr_irq_init_dual(SpaprMachineState *spapr, int nr_irqs,
> +static void spapr_irq_init_dual(SpaprMachineState *spapr, int nr_xirqs,
>                                  Error **errp)
>  {
>      Error *local_err = NULL;
>  
> -    spapr_irq_xics.init(spapr, spapr_irq_xics.nr_irqs, &local_err);
> +    spapr_irq_xics.init(spapr, spapr_irq_xics.nr_xirqs, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
>      }
>  
> -    spapr_irq_xive.init(spapr, spapr_irq_xive.nr_irqs, &local_err);
> +    spapr_irq_xive.init(spapr, spapr_irq_xive.nr_xirqs, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> @@ -586,12 +579,9 @@ static const char *spapr_irq_get_nodename_dual(SpaprMachineState *spapr)
>  /*
>   * Define values in sync with the XIVE and XICS backend
>   */
> -#define SPAPR_IRQ_DUAL_NR_IRQS     0x2000
> -#define SPAPR_IRQ_DUAL_NR_MSIS     (SPAPR_IRQ_DUAL_NR_IRQS - SPAPR_IRQ_MSI)
> -
>  SpaprIrq spapr_irq_dual = {
> -    .nr_irqs     = SPAPR_IRQ_DUAL_NR_IRQS,
> -    .nr_msis     = SPAPR_IRQ_DUAL_NR_MSIS,
> +    .nr_xirqs    = SPAPR_NR_XIRQS,
> +    .nr_msis     = SPAPR_NR_MSIS,
>      .ov5         = SPAPR_OV5_XIVE_BOTH,
>  
>      .init        = spapr_irq_init_dual,
> @@ -693,10 +683,10 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>          spapr_irq_msi_init(spapr, spapr->irq->nr_msis);
>      }
>  
> -    spapr->irq->init(spapr, spapr->irq->nr_irqs, errp);
> +    spapr->irq->init(spapr, spapr->irq->nr_xirqs, errp);
>  
>      spapr->qirqs = qemu_allocate_irqs(spapr->irq->set_irq, spapr,
> -                                      spapr->irq->nr_irqs);
> +                                      spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE);
>  }
>  
>  int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error **errp)
> @@ -804,11 +794,11 @@ int spapr_irq_find(SpaprMachineState *spapr, int num, bool align, Error **errp)
>      return first + ics->offset;
>  }
>  
> -#define SPAPR_IRQ_XICS_LEGACY_NR_IRQS     0x400
> +#define SPAPR_IRQ_XICS_LEGACY_NR_XIRQS     0x400
>  
>  SpaprIrq spapr_irq_xics_legacy = {
> -    .nr_irqs     = SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
> -    .nr_msis     = SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
> +    .nr_xirqs    = SPAPR_IRQ_XICS_LEGACY_NR_XIRQS,
> +    .nr_msis     = SPAPR_IRQ_XICS_LEGACY_NR_XIRQS,
>      .ov5         = SPAPR_OV5_XIVE_LEGACY,
>  
>      .init        = spapr_irq_init_xics,
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 5db305165c..a8f9a2ab11 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -16,13 +16,18 @@
>   * IRQ range offsets per device type
>   */
>  #define SPAPR_IRQ_IPI        0x0
> -#define SPAPR_IRQ_EPOW       0x1000  /* XICS_IRQ_BASE offset */
> -#define SPAPR_IRQ_HOTPLUG    0x1001
> -#define SPAPR_IRQ_VIO        0x1100  /* 256 VIO devices */
> -#define SPAPR_IRQ_PCI_LSI    0x1200  /* 32+ PHBs devices */
>  
> -#define SPAPR_IRQ_MSI        0x1300  /* Offset of the dynamic range covered
> -                                      * by the bitmap allocator */
> +#define SPAPR_XIRQ_BASE      XICS_IRQ_BASE /* 0x1000 */
> +#define SPAPR_IRQ_EPOW       (SPAPR_XIRQ_BASE + 0x0000)
> +#define SPAPR_IRQ_HOTPLUG    (SPAPR_XIRQ_BASE + 0x0001)
> +#define SPAPR_IRQ_VIO        (SPAPR_XIRQ_BASE + 0x0100)  /* 256 VIO devices */
> +#define SPAPR_IRQ_PCI_LSI    (SPAPR_XIRQ_BASE + 0x0200)  /* 32+ PHBs devices */
> +
> +/* Offset of the dynamic range covered by the bitmap allocator */
> +#define SPAPR_IRQ_MSI        (SPAPR_XIRQ_BASE + 0x0300)
> +
> +#define SPAPR_NR_XIRQS       0x1000
> +#define SPAPR_NR_MSIS        (SPAPR_XIRQ_BASE + SPAPR_NR_XIRQS - SPAPR_IRQ_MSI)
>  
>  typedef struct SpaprMachineState SpaprMachineState;
>  
> @@ -32,7 +37,7 @@ int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool align,
>  void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t num);
>  
>  typedef struct SpaprIrq {
> -    uint32_t    nr_irqs;
> +    uint32_t    nr_xirqs;
>      uint32_t    nr_msis;
>      uint8_t     ov5;
>  


