Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF5DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 10:58:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 051B420658
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 10:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051B420658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Ryv-0001nP-8W
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 06:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k5RyI-00010w-Ut
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 06:57:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:56492)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k5RyG-0002uj-PE
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 06:57:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D004BAC55;
 Tue, 11 Aug 2020 10:57:51 +0000 (UTC)
Subject: Re: [RFC v3 2/8] cpus: prepare new CpusAccel cpu accelerator interface
To: Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200803090533.7410-1-cfontana@suse.de>
 <20200803090533.7410-3-cfontana@suse.de>
 <20200811085907.GA62204@SPB-NB-133.local>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <c2767b55-a63e-55f6-41f9-83dd4f36824a@suse.de>
Date: Tue, 11 Aug 2020 12:57:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200811085907.GA62204@SPB-NB-133.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 02:05:49
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, haxm-team@intel.com,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Colin Xu <colin.xu@intel.com>,
 Wenchao Wang <wenchao.wang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/11/20 10:59 AM, Roman Bolshakov wrote:
> On Mon, Aug 03, 2020 at 11:05:27AM +0200, Claudio Fontana wrote:
>> The new interface starts unused, will start being used by the
>> next patches.
>>
>> It provides methods for each accelerator to start a vcpu, kick a vcpu,
>> synchronize state, get cpu virtual clock and elapsed ticks.
>>
>> Signed-off-by: Claudio Fontana <cfontana@suse.de>
>> ---
>>  hw/core/cpu.c                  |   1 +
>>  hw/i386/x86.c                  |   2 +-
>>  include/sysemu/cpu-timers.h    |   9 +-
>>  include/sysemu/cpus.h          |  36 ++++++++
>>  include/sysemu/hw_accel.h      |  69 ++-------------
>>  softmmu/cpu-timers.c           |   9 +-
>>  softmmu/cpus.c                 | 194 ++++++++++++++++++++++++++++++++---------
>>  stubs/Makefile.objs            |   2 +
>>  stubs/cpu-synchronize-state.c  |  15 ++++
>>  stubs/cpus-get-virtual-clock.c |   8 ++
>>  util/qemu-timer.c              |   8 +-
>>  11 files changed, 231 insertions(+), 122 deletions(-)
>>  create mode 100644 stubs/cpu-synchronize-state.c
>>  create mode 100644 stubs/cpus-get-virtual-clock.c
>>
>> diff --git a/hw/core/cpu.c b/hw/core/cpu.c
>> index 594441a150..b389a312df 100644
>> --- a/hw/core/cpu.c
>> +++ b/hw/core/cpu.c
>> @@ -33,6 +33,7 @@
>>  #include "hw/qdev-properties.h"
>>  #include "trace-root.h"
>>  #include "qemu/plugin.h"
>> +#include "sysemu/hw_accel.h"
>>  
>>  CPUInterruptHandler cpu_interrupt_handler;
>>  
>> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
>> index 58cf2229d5..00c35bad7e 100644
>> --- a/hw/i386/x86.c
>> +++ b/hw/i386/x86.c
>> @@ -264,7 +264,7 @@ static long get_file_size(FILE *f)
>>  /* TSC handling */
>>  uint64_t cpu_get_tsc(CPUX86State *env)
>>  {
>> -    return cpu_get_ticks();
>> +    return cpus_get_elapsed_ticks();
> 
> Hi Claudio,
> 
> I still don't understand why plural form of "cpus" is used in files,
> CpusAccel interface name and cpus_ prefix of the functions/variables.

cpus.c is the module, and the functions do sometimes affect more than one single cpu,
or get properties that are not specific to a single cpu.

For example the existing functions:

all_cpu_threads_idle
cpu_synchronize_all_states
cpu_synchronize_all_post_reset
cpu_synchronize_all_post_init
cpu_synchronize_all_pre_loadvm
qemu_init_cpu_loop
qemu_init_sigbus
qemu_in_vcpu_thread
qemu_mutex_iothread_locked
qemu_mutex_lock_iothread_impl
qemu_mutex_unlock_iothread
pause_all_vcpus
resume_all_vcpus
vm_shutdown
vm_stop
vm_prepare_start
vm_start
vm_stop_force_state
list_cpus

and the new identifiers:

cpus_accel
cpus_register_accel
cpus_get_virtual_clock
cpus_get_elapsed_ticks

are all affecting _all_ the cpus in the VM, not just one.

Of course the module contains also functions that do affect one single cpu,
but with the huge amount of functions in the qemu code called cpu_something,
scattered all around the directories, having a cpus_ prefix would immediately point to softmmu/cpus.c making it
easier to find and understand.

So I would be for eventually having all the functions prefixed with the cpus_ prefix for the cpus.c module,
as this module is about the _set_ of cpus running in the VM.


> 
> Original cpus.c had functions to create CPU threads for multiple
> accelerators, that justified naming of cpus.c. It had TCG, KVM and other
> kinds of vCPUs. After you factor cpus.c into separate implementations of
> CPU interface it should get singular form.
> 
> I’m not a native English speaker but the naming looks confusing to me.

See above for the reason I think cpus as a name is still warranted for this module.
It is about the set of all cpus, not a single cpu.

> 
>>  }
>>  
>>  /* IRQ handling */
>> diff --git a/softmmu/cpus.c b/softmmu/cpus.c
>> index 54fdb2761c..bad6302ca3 100644
>> --- a/softmmu/cpus.c
>> +++ b/softmmu/cpus.c
>> @@ -87,7 +87,7 @@ bool cpu_is_stopped(CPUState *cpu)
>>      return cpu->stopped || !runstate_is_running();
>>  }
>>  
>> -static inline bool cpu_work_list_empty(CPUState *cpu)
>> +bool cpu_work_list_empty(CPUState *cpu)
>>  {
>>      bool ret;
>>  
>> @@ -97,7 +97,7 @@ static inline bool cpu_work_list_empty(CPUState *cpu)
>>      return ret;
>>  }
>>  
>> -static bool cpu_thread_is_idle(CPUState *cpu)
>> +bool cpu_thread_is_idle(CPUState *cpu)
>>  {
>>      if (cpu->stop || !cpu_work_list_empty(cpu)) {
>>          return false;
>> @@ -215,6 +215,11 @@ void hw_error(const char *fmt, ...)
>>      abort();
>>  }
>>  
>> +/*
>> + * The chosen accelerator is supposed to register this.
>> + */
>> +static CpusAccel *cpus_accel;
>> +
>>  void cpu_synchronize_all_states(void)
>>  {
>>      CPUState *cpu;
>> @@ -251,6 +256,102 @@ void cpu_synchronize_all_pre_loadvm(void)
>>      }
>>  }
>>  
>> +void cpu_synchronize_state(CPUState *cpu)
>> +{
>> +    if (cpus_accel && cpus_accel->synchronize_state) {
>> +        cpus_accel->synchronize_state(cpu);
> 
> I think the condition can be removed altogether if you move it to the
> bootom inside else body. cpu_interrupt_handler and cpu_interrupt() in
> hw/core/cpu.c is an example of that. Likely cpu_interrupt_handler should
> be part of the accel interface. You might also avoid indirected function
> call by using standalone fuction pointer. Like that:
> 
> 
> void cpu_synchronize_state(CPUState *cpu)
> {
>     if (cpus_accel && cpus_accel->synchronize_state) {
>         cpus_accel->synchronize_state(cpu);
>     }
>     if (kvm_enabled()) {
>         kvm_cpu_synchronize_state(cpu);
>     }
>     else if (hax_enabled()) {
>         hax_cpu_synchronize_state(cpu);
>     }
>     else if (whpx_enabled()) {
>         whpx_cpu_synchronize_state(cpu);
>     } else {
>         cpu_synchronize_state_handler(cpu);
>     }
> }
> 
> After you finish factoring, it becomes:
> 
> 
> void cpu_synchronize_state(CPUState *cpu)
> {
>     cpu_synchronize_state_handler(cpu);
> }
> 
> cpu_register_accel would just assign non-NULL function pointer
> from a CPUAccel field over generic_cpu_synchronize_state_handler.
> 
> Regards,
> Roman

I'll take a look at how things look after adding static inlines to the .h file to speed this up,
I wonder what are the real hot paths here though, I'd like to find the best balance between
readability and performance, as we could go overboard with this when a simpler to read solution would suffice.

Thanks!

Claudio

> 
>> +    }
>> +    if (kvm_enabled()) {
>> +        kvm_cpu_synchronize_state(cpu);
>> +    }
>> +    if (hax_enabled()) {
>> +        hax_cpu_synchronize_state(cpu);
>> +    }
>> +    if (whpx_enabled()) {
>> +        whpx_cpu_synchronize_state(cpu);
>> +    }
>> +}
>> +


