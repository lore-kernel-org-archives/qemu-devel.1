Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AF0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:34:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37165206DA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37165206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2sP4-0006ZX-BH
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 04:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k2s4v-000561-JJ
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 04:13:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:40990)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k2s4t-0006kb-NX
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 04:13:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 45308AC85;
 Tue,  4 Aug 2020 08:13:58 +0000 (UTC)
Subject: Re: [RFC v3 1/8] cpu-timers, icount: new modules
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>
References: <20200803090533.7410-1-cfontana@suse.de>
 <20200803090533.7410-2-cfontana@suse.de>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <910286a7-805d-3b62-a3b0-aeb5d0a9606e@suse.de>
Date: Tue, 4 Aug 2020 10:13:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200803090533.7410-2-cfontana@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 02:44:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Roman Bolshakov <r.bolshakov@yadro.com>, haxm-team@intel.com,
 Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>,
 Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex, Paolo and all,

thank you for your feedback, could you help me answer the question below?

On 8/3/20 11:05 AM, Claudio Fontana wrote:
> ...

> diff --git a/dma-helpers.c b/dma-helpers.c
> index 2a77b5a9cb..240ef4d5b8 100644
> --- a/dma-helpers.c
> +++ b/dma-helpers.c
> @@ -13,7 +13,7 @@
>  #include "trace-root.h"
>  #include "qemu/thread.h"
>  #include "qemu/main-loop.h"
> -#include "sysemu/cpus.h"
> +#include "sysemu/cpu-timers.h"
>  #include "qemu/range.h"
>  
>  /* #define DEBUG_IOMMU */
> @@ -151,7 +151,7 @@ static void dma_blk_cb(void *opaque, int ret)
>           * from several sectors. This code splits all SGs into several
>           * groups. SGs in every group do not overlap.
>           */
> -        if (mem && use_icount && dbs->dir == DMA_DIRECTION_FROM_DEVICE) {
> +        if (mem && icount_enabled() && dbs->dir == DMA_DIRECTION_FROM_DEVICE) {




In this specific case, where dma_blk_cb() changes its behaviour to be more deterministic
if icount_enabled(),

do you think that if qtest_enabled() we should also follow the more deterministic path,
or should we go through the "normal" path instead, as this patch does?

Tests pass in any case, but I wonder what would be the best behavior for qtest accel in this case.
(Maybe Pavel?)



>              int i;
>              for (i = 0 ; i < dbs->iov.niov ; ++i) {
>                  if (ranges_overlap((intptr_t)dbs->iov.iov[i].iov_base,
> diff --git a/docs/replay.txt b/docs/replay.txt
> index 70c27edb36..8952e6d852 100644
> --- a/docs/replay.txt
> +++ b/docs/replay.txt
> @@ -184,11 +184,11 @@ is then incremented (which is called "warping" the virtual clock) as
>  soon as the timer fires or the CPUs need to go out of the idle state.
>  Two functions are used for this purpose; because these actions change
>  virtual machine state and must be deterministic, each of them creates a
> -checkpoint.  qemu_start_warp_timer checks if the CPUs are idle and if so
> -starts accounting real time to virtual clock.  qemu_account_warp_timer
> +checkpoint.  icount_start_warp_timer checks if the CPUs are idle and if so
> +starts accounting real time to virtual clock.  icount_account_warp_timer
>  is called when the CPUs get an interrupt or when the warp timer fires,
>  and it warps the virtual clock by the amount of real time that has passed
> -since qemu_start_warp_timer.
> +since icount_start_warp_timer.
>  
>  Bottom halves
>  -------------
> diff --git a/exec.c b/exec.c
> index 6f381f98e2..a89ffa93c1 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -102,10 +102,6 @@ uintptr_t qemu_host_page_size;
>  intptr_t qemu_host_page_mask;
>  
>  #if !defined(CONFIG_USER_ONLY)
> -/* 0 = Do not count executed instructions.
> -   1 = Precise instruction counting.
> -   2 = Adaptive rate instruction counting.  */
> -int use_icount;
>  
>  typedef struct PhysPageEntry PhysPageEntry;
>  
> diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
> index b5a54e2536..c6d2beb1da 100644
> --- a/hw/core/ptimer.c
> +++ b/hw/core/ptimer.c
> @@ -7,11 +7,11 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "qemu/timer.h"
>  #include "hw/ptimer.h"
>  #include "migration/vmstate.h"
>  #include "qemu/host-utils.h"
>  #include "sysemu/replay.h"
> +#include "sysemu/cpu-timers.h"
>  #include "sysemu/qtest.h"
>  #include "block/aio.h"
>  #include "sysemu/cpus.h"
> @@ -134,7 +134,8 @@ static void ptimer_reload(ptimer_state *s, int delta_adjust)
>       * on the current generation of host machines.
>       */
>  
> -    if (s->enabled == 1 && (delta * period < 10000) && !use_icount) {
> +    if (s->enabled == 1 && (delta * period < 10000) &&
> +        !icount_enabled() && !qtest_enabled()) {


In this case, it is necessary to also make qtest more deterministic in order to make existing tests pass,
as the results of the timer are affecting the ptimer test results (IIRC tests/ptimer-test.c)


>          period = 10000 / delta;
>          period_frac = 0;
>      }
> @@ -217,7 +218,8 @@ uint64_t ptimer_get_count(ptimer_state *s)
>              uint32_t period_frac = s->period_frac;
>              uint64_t period = s->period;
>  
> -            if (!oneshot && (s->delta * period < 10000) && !use_icount) {
> +            if (!oneshot && (s->delta * period < 10000) &&
> +                !icount_enabled() && !qtest_enabled()) {

...same here.

>                  period = 10000 / s->delta;
>                  period_frac = 0;
>              }


Thanks for your feedback,

Claudio

