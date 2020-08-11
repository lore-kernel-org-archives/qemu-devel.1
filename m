Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6A7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 13:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA99206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 13:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA99206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5UZ9-0007xM-Qk
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 09:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k5UYQ-0007KC-D3
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 09:43:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:53632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k5UYO-0005jc-4k
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 09:43:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 46810B066;
 Tue, 11 Aug 2020 13:43:19 +0000 (UTC)
Subject: Re: [RFC v3 8/8] cpus: extract out hvf-specific code to
 target/i386/hvf/
To: Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200803090533.7410-1-cfontana@suse.de>
 <20200803090533.7410-9-cfontana@suse.de>
 <20200811090034.GB62204@SPB-NB-133.local>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <1e6f2876-4226-b25d-a551-ca22661898ce@suse.de>
Date: Tue, 11 Aug 2020 15:42:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200811090034.GB62204@SPB-NB-133.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 8/11/20 11:00 AM, Roman Bolshakov wrote:
> On Mon, Aug 03, 2020 at 11:05:33AM +0200, Claudio Fontana wrote:
>> register a "CpusAccel" interface for HVF as well.
>>
>> Signed-off-by: Claudio Fontana <cfontana@suse.de>
>> ---
>>  softmmu/cpus.c                |  63 --------------------
>>  target/i386/hvf/Makefile.objs |   2 +-
>>  target/i386/hvf/hvf-cpus.c    | 131 ++++++++++++++++++++++++++++++++++++++++++
>>  target/i386/hvf/hvf-cpus.h    |  17 ++++++
>>  target/i386/hvf/hvf.c         |   3 +
>>  5 files changed, 152 insertions(+), 64 deletions(-)
>>  create mode 100644 target/i386/hvf/hvf-cpus.c
>>  create mode 100644 target/i386/hvf/hvf-cpus.h
>>
>> diff --git a/softmmu/cpus.c b/softmmu/cpus.c
>> index 586b4acaab..d327b2685c 100644
>> --- a/softmmu/cpus.c
>> +++ b/softmmu/cpus.c
>> @@ -33,7 +33,6 @@
>>  #include "exec/gdbstub.h"
>>  #include "sysemu/hw_accel.h"
>>  #include "sysemu/kvm.h"
>> -#include "sysemu/hvf.h"
> 
> I wonder if the declarations should be moved from sysemu/hvf.h to
> someplace inside target/i386/hvf/:
> 
> int hvf_init_vcpu(CPUState *);
> int hvf_vcpu_exec(CPUState *);
> void hvf_cpu_synchronize_state(CPUState *);
> void hvf_cpu_synchronize_post_reset(CPUState *);
> void hvf_cpu_synchronize_post_init(CPUState *);
> void hvf_cpu_synchronize_pre_loadvm(CPUState *);
> void hvf_vcpu_destroy(CPUState *);
> 
> They're not used outside of target/i386/hvf/
> 
> I also wonder if we need stubs at all?
> 
>>  #include "exec/exec-all.h"
>>  #include "qemu/thread.h"
>>  #include "qemu/plugin.h"
>> @@ -391,48 +390,6 @@ void qemu_wait_io_event(CPUState *cpu)
>>      qemu_wait_io_event_common(cpu);
>>  }
>>  
>> -/* The HVF-specific vCPU thread function. This one should only run when the host
>> - * CPU supports the VMX "unrestricted guest" feature. */
>> -static void *qemu_hvf_cpu_thread_fn(void *arg)
>> -{
>> -    CPUState *cpu = arg;
>> -
>> -    int r;
>> -
>> -    assert(hvf_enabled());
>> -
>> -    rcu_register_thread();
>> -
>> -    qemu_mutex_lock_iothread();
>> -    qemu_thread_get_self(cpu->thread);
>> -
>> -    cpu->thread_id = qemu_get_thread_id();
>> -    cpu->can_do_io = 1;
>> -    current_cpu = cpu;
>> -
>> -    hvf_init_vcpu(cpu);
>> -
>> -    /* signal CPU creation */
>> -    cpu_thread_signal_created(cpu);
>> -    qemu_guest_random_seed_thread_part2(cpu->random_seed);
>> -
>> -    do {
>> -        if (cpu_can_run(cpu)) {
>> -            r = hvf_vcpu_exec(cpu);
>> -            if (r == EXCP_DEBUG) {
>> -                cpu_handle_guest_debug(cpu);
>> -            }
>> -        }
>> -        qemu_wait_io_event(cpu);
>> -    } while (!cpu->unplug || cpu_can_run(cpu));
>> -
>> -    hvf_vcpu_destroy(cpu);
>> -    cpu_thread_signal_destroyed(cpu);
>> -    qemu_mutex_unlock_iothread();
>> -    rcu_unregister_thread();
>> -    return NULL;
>> -}
>> -
>>  void cpus_kick_thread(CPUState *cpu)
>>  {
>>  #ifndef _WIN32
>> @@ -603,24 +560,6 @@ void cpu_remove_sync(CPUState *cpu)
>>      qemu_mutex_lock_iothread();
>>  }
>>  
>> -static void qemu_hvf_start_vcpu(CPUState *cpu)
>> -{
>> -    char thread_name[VCPU_THREAD_NAME_SIZE];
>> -
>> -    /* HVF currently does not support TCG, and only runs in
>> -     * unrestricted-guest mode. */
>> -    assert(hvf_enabled());
>> -
>> -    cpu->thread = g_malloc0(sizeof(QemuThread));
>> -    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
>> -    qemu_cond_init(cpu->halt_cond);
>> -
>> -    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HVF",
>> -             cpu->cpu_index);
>> -    qemu_thread_create(cpu->thread, thread_name, qemu_hvf_cpu_thread_fn,
>> -                       cpu, QEMU_THREAD_JOINABLE);
>> -}
>> -
>>  void cpus_register_accel(CpusAccel *ca)
>>  {
>>      assert(ca != NULL);
>> @@ -648,8 +587,6 @@ void qemu_init_vcpu(CPUState *cpu)
>>      if (cpus_accel) {
>>          /* accelerator already implements the CpusAccel interface */
>>          cpus_accel->create_vcpu_thread(cpu);
>> -    } else if (hvf_enabled()) {
>> -        qemu_hvf_start_vcpu(cpu);
>>      } else {
>>          assert(0);
>>      }
>> diff --git a/target/i386/hvf/Makefile.objs b/target/i386/hvf/Makefile.objs
>> index 927b86bc67..af9f7dcfc1 100644
>> --- a/target/i386/hvf/Makefile.objs
>> +++ b/target/i386/hvf/Makefile.objs
>> @@ -1,2 +1,2 @@
>> -obj-y += hvf.o
>> +obj-y += hvf.o hvf-cpus.o
>>  obj-y += x86.o x86_cpuid.o x86_decode.o x86_descr.o x86_emu.o x86_flags.o x86_mmu.o x86hvf.o x86_task.o
>> diff --git a/target/i386/hvf/hvf-cpus.c b/target/i386/hvf/hvf-cpus.c
>> new file mode 100644
>> index 0000000000..9540157f1e
>> --- /dev/null
>> +++ b/target/i386/hvf/hvf-cpus.c
> 
> I'd prefer singular form in variables and file names. More on that in
> the comment to patch 2.
> 
> Besides that it works fine,
> 
> Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
> Tested-by: Roman Bolshakov <r.bolshakov@yadro.com>
> 
> Regards,
> Roman
> 

Hi Roman,

thanks, sure lets discuss more the naming stuff on patch 2.

I noticed a missing chunk in this patch, ie, it leaves a lingering

} else if (hvf_enabled()) {

in cpu_synchronize_pre_loadvm().

that needs to be elided, should not change the behavior, but who knows. I will respin this one in the next version.

Thank you!

Claudio




