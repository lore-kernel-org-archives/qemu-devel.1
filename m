Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B0FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 07:08:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4283207E8
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 07:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4283207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joLzU-0007bX-0L
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 03:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1joLyZ-0006ZI-Po
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 03:07:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:58364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1joLyX-0004DR-Mo
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 03:07:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2C3A6B083;
 Thu, 25 Jun 2020 07:07:07 +0000 (UTC)
Subject: Re: [PATCH 4/8] i386: hvf: Implement CPU kick
To: Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
References: <20200624225850.16982-1-r.bolshakov@yadro.com>
 <20200624225850.16982-5-r.bolshakov@yadro.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <77df3139-501d-d4b9-c651-35de66474d57@suse.de>
Date: Thu, 25 Jun 2020 09:07:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200624225850.16982-5-r.bolshakov@yadro.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Roman,

On 6/25/20 12:58 AM, Roman Bolshakov wrote:
> HVF doesn't have a CPU kick and without it it's not possible to perform
> an action on CPU thread until a VMEXIT happens. The kick is also needed
> for timely interrupt delivery.
> 
> Existing implementation of CPU kick sends SIG_IPI (aka SIGUSR1) to vCPU
> thread, but it's different from what hv_vcpu_interrupt does. The latter
> one results in invocation of mp_cpus_kick() in XNU kernel [1].
> 
> While at it, correct type of hvf_fd to the type of hv_vcpuid_t to avoid
> compilation warnings.
> 
> 1. https://opensource.apple.com/source/xnu/xnu-6153.81.5/osfmk/i386/mp.c
> 
> Cc: Cameron Esfahani <dirty@apple.com>
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
>  cpus.c                | 13 +++++++++----
>  include/hw/core/cpu.h |  2 +-
>  include/sysemu/hvf.h  |  1 +
>  target/i386/hvf/hvf.c | 11 +++++++++++
>  4 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/cpus.c b/cpus.c
> index 26709677d3..36f38ce5c8 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1783,10 +1783,15 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
>          return;
>      }
>      cpu->thread_kicked = true;
> -    err = pthread_kill(cpu->thread->thread, SIG_IPI);
> -    if (err && err != ESRCH) {
> -        fprintf(stderr, "qemu:%s: %s", __func__, strerror(err));
> -        exit(1);
> +
> +    if (hvf_enabled()) {
> +        hvf_vcpu_kick(cpu);

could this be moved to qemu_cpu_kick, where we have already the ifs for accelerator types tcg and hax?

Not terribly important if then my cpus-refactoring goes forward, but on its own that should be the proper place for if (hvf_enabled()) I think.



> +    } else {
> +        err = pthread_kill(cpu->thread->thread, SIG_IPI);
> +        if (err && err != ESRCH) {
> +            fprintf(stderr, "qemu:%s: %s", __func__, strerror(err));
> +            exit(1);
> +        }
>      }
>  #else /* _WIN32 */
>      if (!qemu_cpu_is_self(cpu)) {
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index b3f4b79318..288a2bd57e 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -438,7 +438,7 @@ struct CPUState {
>  
>      struct hax_vcpu_state *hax_vcpu;
>  
> -    int hvf_fd;
> +    unsigned hvf_fd;
>  
>      /* track IOMMUs whose translations we've cached in the TCG TLB */
>      GArray *iommu_notifiers;
> diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
> index 1d40a8ec01..aaa00cbf05 100644
> --- a/include/sysemu/hvf.h
> +++ b/include/sysemu/hvf.h
> @@ -25,6 +25,7 @@ extern bool hvf_allowed;
>  
>  int hvf_init_vcpu(CPUState *);
>  int hvf_vcpu_exec(CPUState *);
> +void hvf_vcpu_kick(CPUState *);
>  void hvf_cpu_synchronize_state(CPUState *);
>  void hvf_cpu_synchronize_post_reset(CPUState *);
>  void hvf_cpu_synchronize_post_init(CPUState *);
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index efe9802962..4d254a477a 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -966,6 +966,17 @@ int hvf_vcpu_exec(CPUState *cpu)
>      return ret;
>  }
>  
> +void hvf_vcpu_kick(CPUState *cpu)
> +{
> +    hv_return_t err;
> +
> +    err = hv_vcpu_interrupt(&cpu->hvf_fd, 1);
> +    if (err) {
> +        fprintf(stderr, "qemu:%s error %#x\n", __func__, err);
> +        exit(1);
> +    }
> +}
> +
>  bool hvf_allowed;
>  
>  static int hvf_accel_init(MachineState *ms)
> 


