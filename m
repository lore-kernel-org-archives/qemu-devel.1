Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4C2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 07:10:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7163F20672
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 07:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7163F20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joM1X-0000C4-Pi
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 03:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1joM0t-0008CA-6G
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 03:09:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:59442)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1joM0q-0005Cf-Ra
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 03:09:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 616BBB154;
 Thu, 25 Jun 2020 07:09:31 +0000 (UTC)
Subject: Re: [PATCH 2/8] i386: hvf: Move synchronize functions to sysemu
To: Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
References: <20200624225850.16982-1-r.bolshakov@yadro.com>
 <20200624225850.16982-3-r.bolshakov@yadro.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <d1cc8a7e-2f4a-d496-44e0-d18cd4993c63@suse.de>
Date: Thu, 25 Jun 2020 09:09:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200624225850.16982-3-r.bolshakov@yadro.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 22:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Claudio Fontana <cfontana@suse.de>

On 6/25/20 12:58 AM, Roman Bolshakov wrote:
> Cc: Cameron Esfahani <dirty@apple.com>
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
>  cpus.c                    | 12 ------------
>  include/sysemu/hw_accel.h | 10 ++++++++++
>  2 files changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/cpus.c b/cpus.c
> index 7317ae06b9..26709677d3 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1017,10 +1017,6 @@ void cpu_synchronize_all_states(void)
>  
>      CPU_FOREACH(cpu) {
>          cpu_synchronize_state(cpu);
> -        /* TODO: move to cpu_synchronize_state() */
> -        if (hvf_enabled()) {
> -            hvf_cpu_synchronize_state(cpu);
> -        }
>      }
>  }
>  
> @@ -1030,10 +1026,6 @@ void cpu_synchronize_all_post_reset(void)
>  
>      CPU_FOREACH(cpu) {
>          cpu_synchronize_post_reset(cpu);
> -        /* TODO: move to cpu_synchronize_post_reset() */
> -        if (hvf_enabled()) {
> -            hvf_cpu_synchronize_post_reset(cpu);
> -        }
>      }
>  }
>  
> @@ -1043,10 +1035,6 @@ void cpu_synchronize_all_post_init(void)
>  
>      CPU_FOREACH(cpu) {
>          cpu_synchronize_post_init(cpu);
> -        /* TODO: move to cpu_synchronize_post_init() */
> -        if (hvf_enabled()) {
> -            hvf_cpu_synchronize_post_init(cpu);
> -        }
>      }
>  }
>  
> diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
> index 0ec2372477..80bce75921 100644
> --- a/include/sysemu/hw_accel.h
> +++ b/include/sysemu/hw_accel.h
> @@ -14,6 +14,7 @@
>  #include "hw/core/cpu.h"
>  #include "sysemu/hax.h"
>  #include "sysemu/kvm.h"
> +#include "sysemu/hvf.h"
>  #include "sysemu/whpx.h"
>  
>  static inline void cpu_synchronize_state(CPUState *cpu)
> @@ -24,6 +25,9 @@ static inline void cpu_synchronize_state(CPUState *cpu)
>      if (hax_enabled()) {
>          hax_cpu_synchronize_state(cpu);
>      }
> +    if (hvf_enabled()) {
> +        hvf_cpu_synchronize_state(cpu);
> +    }
>      if (whpx_enabled()) {
>          whpx_cpu_synchronize_state(cpu);
>      }
> @@ -37,6 +41,9 @@ static inline void cpu_synchronize_post_reset(CPUState *cpu)
>      if (hax_enabled()) {
>          hax_cpu_synchronize_post_reset(cpu);
>      }
> +    if (hvf_enabled()) {
> +        hvf_cpu_synchronize_post_reset(cpu);
> +    }
>      if (whpx_enabled()) {
>          whpx_cpu_synchronize_post_reset(cpu);
>      }
> @@ -50,6 +57,9 @@ static inline void cpu_synchronize_post_init(CPUState *cpu)
>      if (hax_enabled()) {
>          hax_cpu_synchronize_post_init(cpu);
>      }
> +    if (hvf_enabled()) {
> +        hvf_cpu_synchronize_post_init(cpu);
> +    }
>      if (whpx_enabled()) {
>          whpx_cpu_synchronize_post_init(cpu);
>      }
> 


