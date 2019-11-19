Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E5EC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 18:16:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 834C12231E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 18:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834C12231E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX83B-0005vx-Lx
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 13:16:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iX81g-0004o6-6j
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 13:14:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iX81d-0004PQ-Sw
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 13:14:55 -0500
Received: from 10.mo6.mail-out.ovh.net ([87.98.157.236]:48234)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iX81d-0004O7-J1
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 13:14:53 -0500
Received: from player792.ha.ovh.net (unknown [10.108.42.102])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 244B51E63AE
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 19:14:50 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: groug@kaod.org)
 by player792.ha.ovh.net (Postfix) with ESMTPSA id EE4D5C47AF47;
 Tue, 19 Nov 2019 18:14:42 +0000 (UTC)
Date: Tue, 19 Nov 2019 19:14:41 +0100
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [RFC v5 065/126] XIVE: introduce ERRP_AUTO_PROPAGATE
Message-ID: <20191119191441.2240439d@bahia.lan>
In-Reply-To: <20191011160552.22907-66-vsementsov@virtuozzo.com>
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-66-vsementsov@virtuozzo.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 3538140459759671635
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegkedgudduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedtrddtrddtrddtpdduleehrddvuddvrddvledrudeiieenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelvddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.157.236
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com,
 qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Oct 2019 19:04:51 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> If we want to add some info to errp (by error_prepend() or
> error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
> Otherwise, this info will not be added when errp == &fatal_err
> (the program will exit prior to the error_append_hint() or
> error_prepend() call).  Fix such cases.
> 
> If we want to check error after errp-function call, we need to
> introduce local_err and than propagate it to errp. Instead, use
> ERRP_AUTO_PROPAGATE macro, benefits are:
> 1. No need of explicit error_propagate call
> 2. No need of explicit local_err variable: use errp directly
> 3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
>    &error_fatel, this means that we don't break error_abort
>    (we'll abort on error_set, not on error_propagate)
> 
> This commit (together with its neighbors) was generated by
> 
> for f in $(git grep -l errp \*.[ch]); do \
>     spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>     --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff $f; \
> done;
> 
> then fix a bit of compilation problems: coccinelle for some reason
> leaves several
> f() {
>     ...
>     goto out;
>     ...
>     out:
> }
> patterns, with "out:" at function end.
> 
> then
> ./python/commit-per-subsystem.py MAINTAINERS "$(< auto-msg)"
> 
> (auto-msg was a file with this commit message)
> 
> Still, for backporting it may be more comfortable to use only the first
> command and then do one huge commit.
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Reported-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  hw/intc/spapr_xive.c     | 12 ++++-----
>  hw/intc/spapr_xive_kvm.c | 55 ++++++++++++++++++----------------------
>  hw/intc/xive.c           | 27 ++++++++------------
>  3 files changed, 40 insertions(+), 54 deletions(-)
> 

We did a huge cleanup recently in this area so this patch doesn't apply
anymore. Ideally it should be based on David Gibson's ppc-for-5.0 branch
available at https://github.com/dgibson/qemu .

Same goes for the PowerPC patch 035/126 actually.

> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 04879abf2e..b25c9ef9ea 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -273,10 +273,10 @@ static void spapr_xive_instance_init(Object *obj)
>  
>  static void spapr_xive_realize(DeviceState *dev, Error **errp)
>  {
> +    ERRP_AUTO_PROPAGATE();
>      SpaprXive *xive = SPAPR_XIVE(dev);
>      XiveSource *xsrc = &xive->source;
>      XiveENDSource *end_xsrc = &xive->end_source;
> -    Error *local_err = NULL;
>  
>      if (!xive->nr_irqs) {
>          error_setg(errp, "Number of interrupt needs to be greater 0");
> @@ -295,9 +295,8 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
>                              &error_fatal);
>      object_property_add_const_link(OBJECT(xsrc), "xive", OBJECT(xive),
>                                     &error_fatal);
> -    object_property_set_bool(OBJECT(xsrc), true, "realized", &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    object_property_set_bool(OBJECT(xsrc), true, "realized", errp);
> +    if (*errp) {
>          return;
>      }
>      sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xsrc->esb_mmio);
> @@ -309,9 +308,8 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
>                              &error_fatal);
>      object_property_add_const_link(OBJECT(end_xsrc), "xive", OBJECT(xive),
>                                     &error_fatal);
> -    object_property_set_bool(OBJECT(end_xsrc), true, "realized", &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    object_property_set_bool(OBJECT(end_xsrc), true, "realized", errp);
> +    if (*errp) {
>          return;
>      }
>      sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 51b334b676..02243537e6 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -186,6 +186,7 @@ void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
>  void kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveEAS *eas,
>                                     Error **errp)
>  {
> +    ERRP_AUTO_PROPAGATE();
>      uint32_t end_idx;
>      uint32_t end_blk;
>      uint8_t priority;
> @@ -193,7 +194,6 @@ void kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveEAS *eas,
>      bool masked;
>      uint32_t eisn;
>      uint64_t kvm_src;
> -    Error *local_err = NULL;
>  
>      assert(xive_eas_is_valid(eas));
>  
> @@ -214,9 +214,8 @@ void kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, XiveEAS *eas,
>          KVM_XIVE_SOURCE_EISN_MASK;
>  
>      kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCE_CONFIG, lisn,
> -                      &kvm_src, true, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +                      &kvm_src, true, errp);
> +    if (*errp) {
>          return;
>      }
>  }
> @@ -255,19 +254,17 @@ int kvmppc_xive_source_reset_one(XiveSource *xsrc, int srcno, Error **errp)
>  
>  static void kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp)
>  {
> +    ERRP_AUTO_PROPAGATE();
>      SpaprXive *xive = SPAPR_XIVE(xsrc->xive);
>      int i;
>  
>      for (i = 0; i < xsrc->nr_irqs; i++) {
> -        Error *local_err = NULL;
> -
>          if (!xive_eas_is_valid(&xive->eat[i])) {
>              continue;
>          }
>  
> -        kvmppc_xive_source_reset_one(xsrc, i, &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> +        kvmppc_xive_source_reset_one(xsrc, i, errp);
> +        if (*errp) {
>              return;
>          }
>      }
> @@ -389,11 +386,11 @@ void kvmppc_xive_get_queue_config(SpaprXive *xive, uint8_t end_blk,
>                                    uint32_t end_idx, XiveEND *end,
>                                    Error **errp)
>  {
> +    ERRP_AUTO_PROPAGATE();
>      struct kvm_ppc_xive_eq kvm_eq = { 0 };
>      uint64_t kvm_eq_idx;
>      uint8_t priority;
>      uint32_t server;
> -    Error *local_err = NULL;
>  
>      assert(xive_end_is_valid(end));
>  
> @@ -406,9 +403,8 @@ void kvmppc_xive_get_queue_config(SpaprXive *xive, uint8_t end_blk,
>          KVM_XIVE_EQ_SERVER_MASK;
>  
>      kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_EQ_CONFIG, kvm_eq_idx,
> -                      &kvm_eq, false, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +                      &kvm_eq, false, errp);
> +    if (*errp) {
>          return;
>      }
>  
> @@ -425,11 +421,11 @@ void kvmppc_xive_set_queue_config(SpaprXive *xive, uint8_t end_blk,
>                                    uint32_t end_idx, XiveEND *end,
>                                    Error **errp)
>  {
> +    ERRP_AUTO_PROPAGATE();
>      struct kvm_ppc_xive_eq kvm_eq = { 0 };
>      uint64_t kvm_eq_idx;
>      uint8_t priority;
>      uint32_t server;
> -    Error *local_err = NULL;
>  
>      /*
>       * Build the KVM state from the local END structure.
> @@ -468,9 +464,8 @@ void kvmppc_xive_set_queue_config(SpaprXive *xive, uint8_t end_blk,
>          KVM_XIVE_EQ_SERVER_MASK;
>  
>      kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_EQ_CONFIG, kvm_eq_idx,
> -                      &kvm_eq, true, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +                      &kvm_eq, true, errp);
> +    if (*errp) {
>          return;
>      }
>  }
> @@ -483,7 +478,7 @@ void kvmppc_xive_reset(SpaprXive *xive, Error **errp)
>  
>  static void kvmppc_xive_get_queues(SpaprXive *xive, Error **errp)
>  {
> -    Error *local_err = NULL;
> +    ERRP_AUTO_PROPAGATE();
>      int i;
>  
>      for (i = 0; i < xive->nr_ends; i++) {
> @@ -492,9 +487,8 @@ static void kvmppc_xive_get_queues(SpaprXive *xive, Error **errp)
>          }
>  
>          kvmppc_xive_get_queue_config(xive, SPAPR_XIVE_BLOCK_ID, i,
> -                                     &xive->endt[i], &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> +                                     &xive->endt[i], errp);
> +        if (*errp) {
>              return;
>          }
>      }
> @@ -742,8 +736,8 @@ static void *kvmppc_xive_mmap(SpaprXive *xive, int pgoff, size_t len,
>   */
>  void kvmppc_xive_connect(SpaprXive *xive, Error **errp)
>  {
> +    ERRP_AUTO_PROPAGATE();
>      XiveSource *xsrc = &xive->source;
> -    Error *local_err = NULL;
>      size_t esb_len = (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
>      size_t tima_len = 4ull << TM_SHIFT;
>      CPUState *cs;
> @@ -772,8 +766,8 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **errp)
>       * 1. Source ESB pages - KVM mapping
>       */
>      xsrc->esb_mmap = kvmppc_xive_mmap(xive, KVM_XIVE_ESB_PAGE_OFFSET, esb_len,
> -                                      &local_err);
> -    if (local_err) {
> +                                      errp);
> +    if (*errp) {
>          goto fail;
>      }
>  
> @@ -790,8 +784,8 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **errp)
>       * 3. TIMA pages - KVM mapping
>       */
>      xive->tm_mmap = kvmppc_xive_mmap(xive, KVM_XIVE_TIMA_PAGE_OFFSET, tima_len,
> -                                     &local_err);
> -    if (local_err) {
> +                                     errp);
> +    if (*errp) {
>          goto fail;
>      }
>      memory_region_init_ram_device_ptr(&xive->tm_mmio_kvm, OBJECT(xive),
> @@ -806,15 +800,15 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **errp)
>      CPU_FOREACH(cs) {
>          PowerPCCPU *cpu = POWERPC_CPU(cs);
>  
> -        kvmppc_xive_cpu_connect(spapr_cpu_state(cpu)->tctx, &local_err);
> -        if (local_err) {
> +        kvmppc_xive_cpu_connect(spapr_cpu_state(cpu)->tctx, errp);
> +        if (*errp) {
>              goto fail;
>          }
>      }
>  
>      /* Update the KVM sources */
> -    kvmppc_xive_source_reset(xsrc, &local_err);
> -    if (local_err) {
> +    kvmppc_xive_source_reset(xsrc, errp);
> +    if (*errp) {
>          goto fail;
>      }
>  
> @@ -824,7 +818,6 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **errp)
>      return;
>  
>  fail:
> -    error_propagate(errp, local_err);
>      kvmppc_xive_disconnect(xive, NULL);
>  }
>  
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 29df06df11..368f94df71 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -570,15 +570,14 @@ static void xive_tctx_reset(void *dev)
>  
>  static void xive_tctx_realize(DeviceState *dev, Error **errp)
>  {
> +    ERRP_AUTO_PROPAGATE();
>      XiveTCTX *tctx = XIVE_TCTX(dev);
>      PowerPCCPU *cpu;
>      CPUPPCState *env;
>      Object *obj;
> -    Error *local_err = NULL;
>  
> -    obj = object_property_get_link(OBJECT(dev), "cpu", &local_err);
> +    obj = object_property_get_link(OBJECT(dev), "cpu", errp);
>      if (!obj) {
> -        error_propagate(errp, local_err);
>          error_prepend(errp, "required link 'cpu' not found: ");
>          return;
>      }
> @@ -601,9 +600,8 @@ static void xive_tctx_realize(DeviceState *dev, Error **errp)
>  
>      /* Connect the presenter to the VCPU (required for CPU hotplug) */
>      if (kvm_irqchip_in_kernel()) {
> -        kvmppc_xive_cpu_connect(tctx, &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> +        kvmppc_xive_cpu_connect(tctx, errp);
> +        if (*errp) {
>              return;
>          }
>      }
> @@ -681,15 +679,15 @@ static const TypeInfo xive_tctx_info = {
>  
>  Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp)
>  {
> -    Error *local_err = NULL;
> +    ERRP_AUTO_PROPAGATE();
>      Object *obj;
>  
>      obj = object_new(TYPE_XIVE_TCTX);
>      object_property_add_child(cpu, TYPE_XIVE_TCTX, obj, &error_abort);
>      object_unref(obj);
>      object_property_add_const_link(obj, "cpu", cpu, &error_abort);
> -    object_property_set_bool(obj, true, "realized", &local_err);
> -    if (local_err) {
> +    object_property_set_bool(obj, true, "realized", errp);
> +    if (*errp) {
>          goto error;
>      }
>  
> @@ -697,7 +695,6 @@ Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp)
>  
>  error:
>      object_unparent(obj);
> -    error_propagate(errp, local_err);
>      return NULL;
>  }
>  
> @@ -1050,13 +1047,12 @@ static void xive_source_reset(void *dev)
>  
>  static void xive_source_realize(DeviceState *dev, Error **errp)
>  {
> +    ERRP_AUTO_PROPAGATE();
>      XiveSource *xsrc = XIVE_SOURCE(dev);
>      Object *obj;
> -    Error *local_err = NULL;
>  
> -    obj = object_property_get_link(OBJECT(dev), "xive", &local_err);
> +    obj = object_property_get_link(OBJECT(dev), "xive", errp);
>      if (!obj) {
> -        error_propagate(errp, local_err);
>          error_prepend(errp, "required link 'xive' not found: ");
>          return;
>      }
> @@ -1806,13 +1802,12 @@ static const MemoryRegionOps xive_end_source_ops = {
>  
>  static void xive_end_source_realize(DeviceState *dev, Error **errp)
>  {
> +    ERRP_AUTO_PROPAGATE();
>      XiveENDSource *xsrc = XIVE_END_SOURCE(dev);
>      Object *obj;
> -    Error *local_err = NULL;
>  
> -    obj = object_property_get_link(OBJECT(dev), "xive", &local_err);
> +    obj = object_property_get_link(OBJECT(dev), "xive", errp);
>      if (!obj) {
> -        error_propagate(errp, local_err);
>          error_prepend(errp, "required link 'xive' not found: ");
>          return;
>      }


