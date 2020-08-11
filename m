Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F44C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:00:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB0B6206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="eYMSYHKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0B6206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Q8r-0004IE-1j
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 05:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1k5Q86-0003bT-MN
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 04:59:34 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:48220 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1k5Q84-0005Qo-Ie
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 04:59:34 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 0D79F4C882;
 Tue, 11 Aug 2020 08:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-transfer-encoding:content-disposition
 :content-type:content-type:mime-version:references:message-id
 :subject:subject:from:from:date:date:received:received:received;
 s=mta-01; t=1597136367; x=1598950768; bh=FGhwUNwEaenQWkMMy2IzZ0
 9Cj3mVKO3P5YOKEwnD5R8=; b=eYMSYHKlM1VVzdvNVzOC+9eSUIrlME+qeOn3/o
 /YhjdXXhHMxLIJnJNLTqp00mLVP0ZrXsElmna2jaaSPaEjBp+4rg8Kc1os1O/+hW
 X+k9PTA1zypiZgqqtUDa09jGdiUTkCTSq9BMdnz8pZT+1226kI8c4EE0ZksAfAlW
 6VeVM=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NhphuFSBM8Wd; Tue, 11 Aug 2020 11:59:27 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id DD3DE4C84A;
 Tue, 11 Aug 2020 11:59:26 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 11
 Aug 2020 11:59:26 +0300
Date: Tue, 11 Aug 2020 11:59:07 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC v3 2/8] cpus: prepare new CpusAccel cpu accelerator interface
Message-ID: <20200811085907.GA62204@SPB-NB-133.local>
References: <20200803090533.7410-1-cfontana@suse.de>
 <20200803090533.7410-3-cfontana@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200803090533.7410-3-cfontana@suse.de>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 04:59:29
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, haxm-team@intel.com,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Colin Xu <colin.xu@intel.com>,
 Wenchao Wang <wenchao.wang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 03, 2020 at 11:05:27AM +0200, Claudio Fontana wrote:
> The new interface starts unused, will start being used by the
> next patches.
> 
> It provides methods for each accelerator to start a vcpu, kick a vcpu,
> synchronize state, get cpu virtual clock and elapsed ticks.
> 
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  hw/core/cpu.c                  |   1 +
>  hw/i386/x86.c                  |   2 +-
>  include/sysemu/cpu-timers.h    |   9 +-
>  include/sysemu/cpus.h          |  36 ++++++++
>  include/sysemu/hw_accel.h      |  69 ++-------------
>  softmmu/cpu-timers.c           |   9 +-
>  softmmu/cpus.c                 | 194 ++++++++++++++++++++++++++++++++---------
>  stubs/Makefile.objs            |   2 +
>  stubs/cpu-synchronize-state.c  |  15 ++++
>  stubs/cpus-get-virtual-clock.c |   8 ++
>  util/qemu-timer.c              |   8 +-
>  11 files changed, 231 insertions(+), 122 deletions(-)
>  create mode 100644 stubs/cpu-synchronize-state.c
>  create mode 100644 stubs/cpus-get-virtual-clock.c
> 
> diff --git a/hw/core/cpu.c b/hw/core/cpu.c
> index 594441a150..b389a312df 100644
> --- a/hw/core/cpu.c
> +++ b/hw/core/cpu.c
> @@ -33,6 +33,7 @@
>  #include "hw/qdev-properties.h"
>  #include "trace-root.h"
>  #include "qemu/plugin.h"
> +#include "sysemu/hw_accel.h"
>  
>  CPUInterruptHandler cpu_interrupt_handler;
>  
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 58cf2229d5..00c35bad7e 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -264,7 +264,7 @@ static long get_file_size(FILE *f)
>  /* TSC handling */
>  uint64_t cpu_get_tsc(CPUX86State *env)
>  {
> -    return cpu_get_ticks();
> +    return cpus_get_elapsed_ticks();

Hi Claudio,

I still don't understand why plural form of "cpus" is used in files,
CpusAccel interface name and cpus_ prefix of the functions/variables.

Original cpus.c had functions to create CPU threads for multiple
accelerators, that justified naming of cpus.c. It had TCG, KVM and other
kinds of vCPUs. After you factor cpus.c into separate implementations of
CPU interface it should get singular form.

I’m not a native English speaker but the naming looks confusing to me.

>  }
>  
>  /* IRQ handling */
> diff --git a/softmmu/cpus.c b/softmmu/cpus.c
> index 54fdb2761c..bad6302ca3 100644
> --- a/softmmu/cpus.c
> +++ b/softmmu/cpus.c
> @@ -87,7 +87,7 @@ bool cpu_is_stopped(CPUState *cpu)
>      return cpu->stopped || !runstate_is_running();
>  }
>  
> -static inline bool cpu_work_list_empty(CPUState *cpu)
> +bool cpu_work_list_empty(CPUState *cpu)
>  {
>      bool ret;
>  
> @@ -97,7 +97,7 @@ static inline bool cpu_work_list_empty(CPUState *cpu)
>      return ret;
>  }
>  
> -static bool cpu_thread_is_idle(CPUState *cpu)
> +bool cpu_thread_is_idle(CPUState *cpu)
>  {
>      if (cpu->stop || !cpu_work_list_empty(cpu)) {
>          return false;
> @@ -215,6 +215,11 @@ void hw_error(const char *fmt, ...)
>      abort();
>  }
>  
> +/*
> + * The chosen accelerator is supposed to register this.
> + */
> +static CpusAccel *cpus_accel;
> +
>  void cpu_synchronize_all_states(void)
>  {
>      CPUState *cpu;
> @@ -251,6 +256,102 @@ void cpu_synchronize_all_pre_loadvm(void)
>      }
>  }
>  
> +void cpu_synchronize_state(CPUState *cpu)
> +{
> +    if (cpus_accel && cpus_accel->synchronize_state) {
> +        cpus_accel->synchronize_state(cpu);

I think the condition can be removed altogether if you move it to the
bootom inside else body. cpu_interrupt_handler and cpu_interrupt() in
hw/core/cpu.c is an example of that. Likely cpu_interrupt_handler should
be part of the accel interface. You might also avoid indirected function
call by using standalone fuction pointer. Like that:


void cpu_synchronize_state(CPUState *cpu)
{
    if (cpus_accel && cpus_accel->synchronize_state) {
        cpus_accel->synchronize_state(cpu);
    }
    if (kvm_enabled()) {
        kvm_cpu_synchronize_state(cpu);
    }
    else if (hax_enabled()) {
        hax_cpu_synchronize_state(cpu);
    }
    else if (whpx_enabled()) {
        whpx_cpu_synchronize_state(cpu);
    } else {
        cpu_synchronize_state_handler(cpu);
    }
}

After you finish factoring, it becomes:


void cpu_synchronize_state(CPUState *cpu)
{
    cpu_synchronize_state_handler(cpu);
}

cpu_register_accel would just assign non-NULL function pointer
from a CPUAccel field over generic_cpu_synchronize_state_handler.

Regards,
Roman

> +    }
> +    if (kvm_enabled()) {
> +        kvm_cpu_synchronize_state(cpu);
> +    }
> +    if (hax_enabled()) {
> +        hax_cpu_synchronize_state(cpu);
> +    }
> +    if (whpx_enabled()) {
> +        whpx_cpu_synchronize_state(cpu);
> +    }
> +}
> +

