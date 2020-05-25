Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C504C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 09:46:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2332073B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 09:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2332073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd9gK-0008Ua-Ef
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 05:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jd9fj-0007sd-F3
 for qemu-devel@nongnu.org; Mon, 25 May 2020 05:45:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:56568)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jd9fh-0008Nu-W1
 for qemu-devel@nongnu.org; Mon, 25 May 2020 05:45:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 389EEAF57;
 Mon, 25 May 2020 09:45:26 +0000 (UTC)
Subject: Re: [RFC v2 1/3] cpu-throttle: new module, extracted from cpus.c
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200522171013.27597-1-cfontana@suse.de>
 <20200522171013.27597-2-cfontana@suse.de>
 <3c30d830-cd4b-63f6-b942-afd4bc0fb6d6@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <cecbeee8-12d3-1716-83b2-ce126134a3e2@suse.de>
Date: Mon, 25 May 2020 11:45:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3c30d830-cd4b-63f6-b942-afd4bc0fb6d6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:03:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Roman Bolshakov <r.bolshakov@yadro.com>,
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>,
 Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Thomas,

thanks for looking at this,

On 5/25/20 10:44 AM, Thomas Huth wrote:
> On 22/05/2020 19.10, Claudio Fontana wrote:
>> move the vcpu throttling functionality into its own module.
>>
>> This functionality is not specific to any accelerator,
>> and it is used currently by migration to slow down guests to try to
>> have migrations converge, and by the cocoa MacOS UI to throttle speed.
>>
>> cpu-throttle contains the controls to adjust and inspect throttle
>> settings, start (set) and stop vcpu throttling, and the throttling
>> function itself that is run periodically on vcpus to make them take a nap.
>>
>> Execution of the throttling function on all vcpus is triggered by a timer,
>> registered at module initialization.
>>
>> No functionality change.
> 
> Thanks for the update, sounds better now!
> 
>> Signed-off-by: Claudio Fontana <cfontana@suse.de>
>> ---
>>  MAINTAINERS                   |   1 +
>>  Makefile.target               |   8 ++-
>>  cpu-throttle.c                | 122 ++++++++++++++++++++++++++++++++++++++++++
>>  cpus.c                        |  95 +++-----------------------------
>>  include/hw/core/cpu.h         |  37 -------------
>>  include/qemu/main-loop.h      |   5 ++
>>  include/sysemu/cpu-throttle.h |  50 +++++++++++++++++
>>  migration/migration.c         |   1 +
>>  migration/ram.c               |   1 +
>>  9 files changed, 195 insertions(+), 125 deletions(-)
>>  create mode 100644 cpu-throttle.c
>>  create mode 100644 include/sysemu/cpu-throttle.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3690f313c3..95be18c0b5 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2148,6 +2148,7 @@ Main loop
>>  M: Paolo Bonzini <pbonzini@redhat.com>
>>  S: Maintained
>>  F: cpus.c
>> +F: cpu-throttle.c
>>  F: include/qemu/main-loop.h
>>  F: include/sysemu/runstate.h
>>  F: util/main-loop.c
>> diff --git a/Makefile.target b/Makefile.target
>> index 8ed1eba95b..60cfa2a78b 100644
>> --- a/Makefile.target
>> +++ b/Makefile.target
>> @@ -152,7 +152,13 @@ endif #CONFIG_BSD_USER
>>  #########################################################
>>  # System emulator target
>>  ifdef CONFIG_SOFTMMU
>> -obj-y += arch_init.o cpus.o gdbstub.o balloon.o ioport.o
>> +obj-y += arch_init.o
>> +obj-y += cpus.o
>> +obj-y += cpu-throttle.o
> 
> Hmm, maybe the new files should rather be created in the softmmu/ folder
> (now that we've got it)? And cpus.c could finally be moved there, too...
> well, it's just an idea, I've got no strong opinion about this.

Absolutely, yes.

Initially I thought to do it in a later phase, but if the consensus is to start already to put stuff in place,
I would be happy to do it.

It would make things easier to understand, currently it is confusing to remember whether a component is
user-mode only, softmmu, tcg-only, ...

> 
>> +obj-y += gdbstub.o
>> +obj-y += balloon.o
>> +obj-y += ioport.o
>> +
>>  obj-y += qtest.o
>>  obj-y += dump/
>>  obj-y += hw/
>> diff --git a/cpu-throttle.c b/cpu-throttle.c
>> new file mode 100644
>> index 0000000000..4e6b2818ca
>> --- /dev/null
>> +++ b/cpu-throttle.c
>> @@ -0,0 +1,122 @@
>> +/*
>> + * QEMU System Emulator
>> + *
>> + * Copyright (c) 2003-2008 Fabrice Bellard
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a copy
>> + * of this software and associated documentation files (the "Software"), to deal
>> + * in the Software without restriction, including without limitation the rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>> + * copies of the Software, and to permit persons to whom the Software is
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>> + * THE SOFTWARE.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu-common.h"
>> +#include "qemu/thread.h"
>> +#include "hw/core/cpu.h"
>> +#include "qemu/main-loop.h"
>> +#include "sysemu/cpus.h"
>> +#include "sysemu/cpu-throttle.h"
>> +
>> +/* vcpu throttling controls */
>> +static QEMUTimer *throttle_timer;
>> +static unsigned int throttle_percentage;
>> +
>> +#define CPU_THROTTLE_PCT_MIN 1
>> +#define CPU_THROTTLE_PCT_MAX 99
>> +#define CPU_THROTTLE_TIMESLICE_NS 10000000
>> +
>> +static void cpu_throttle_thread(CPUState *cpu, run_on_cpu_data opaque)
>> +{
>> +    double pct;
>> +    double throttle_ratio;
>> +    int64_t sleeptime_ns, endtime_ns;
>> +
>> +    if (!cpu_throttle_get_percentage()) {
>> +        return;
>> +    }
>> +
>> +    pct = (double)cpu_throttle_get_percentage() / 100;
>> +    throttle_ratio = pct / (1 - pct);
>> +    /* Add 1ns to fix double's rounding error (like 0.9999999...) */
>> +    sleeptime_ns = (int64_t)(throttle_ratio * CPU_THROTTLE_TIMESLICE_NS + 1);
>> +    endtime_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + sleeptime_ns;
>> +    while (sleeptime_ns > 0 && !cpu->stop) {
>> +        if (sleeptime_ns > SCALE_MS) {
>> +            qemu_cond_timedwait_iothread(cpu->halt_cond,
>> +                                         sleeptime_ns / SCALE_MS);
>> +        } else {
>> +            qemu_mutex_unlock_iothread();
>> +            g_usleep(sleeptime_ns / SCALE_US);
>> +            qemu_mutex_lock_iothread();
>> +        }
>> +        sleeptime_ns = endtime_ns - qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
>> +    }
>> +    atomic_set(&cpu->throttle_thread_scheduled, 0);
>> +}
>> +
>> +static void cpu_throttle_timer_tick(void *opaque)
>> +{
>> +    CPUState *cpu;
>> +    double pct;
>> +
>> +    /* Stop the timer if needed */
>> +    if (!cpu_throttle_get_percentage()) {
>> +        return;
>> +    }
>> +    CPU_FOREACH(cpu) {
>> +        if (!atomic_xchg(&cpu->throttle_thread_scheduled, 1)) {
>> +            async_run_on_cpu(cpu, cpu_throttle_thread,
>> +                             RUN_ON_CPU_NULL);
>> +        }
>> +    }
>> +
>> +    pct = (double)cpu_throttle_get_percentage() / 100;
>> +    timer_mod(throttle_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) +
>> +                                   CPU_THROTTLE_TIMESLICE_NS / (1 - pct));
>> +}
>> +
>> +void cpu_throttle_set(int new_throttle_pct)
>> +{
>> +    /* Ensure throttle percentage is within valid range */
>> +    new_throttle_pct = MIN(new_throttle_pct, CPU_THROTTLE_PCT_MAX);
>> +    new_throttle_pct = MAX(new_throttle_pct, CPU_THROTTLE_PCT_MIN);
>> +
>> +    atomic_set(&throttle_percentage, new_throttle_pct);
>> +
>> +    timer_mod(throttle_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) +
>> +                                       CPU_THROTTLE_TIMESLICE_NS);
>> +}
>> +
>> +void cpu_throttle_stop(void)
>> +{
>> +    atomic_set(&throttle_percentage, 0);
>> +}
>> +
>> +bool cpu_throttle_active(void)
>> +{
>> +    return (cpu_throttle_get_percentage() != 0);
>> +}
>> +
>> +int cpu_throttle_get_percentage(void)
>> +{
>> +    return atomic_read(&throttle_percentage);
>> +}
>> +
>> +void cpu_throttle_init(void)
>> +{
>> +    throttle_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL_RT,
>> +                                  cpu_throttle_timer_tick, NULL);
>> +}
>> diff --git a/cpus.c b/cpus.c
>> index 5670c96bcf..3a46a4fc2b 100644
>> --- a/cpus.c
>> +++ b/cpus.c
> [...]
>>  
>> +void qemu_cond_timedwait_iothread(QemuCond *cond, int ms)
>> +{
>> +    qemu_cond_timedwait(cond, &qemu_global_mutex, ms);
>> +}
> 
> So the new function is in cpus.c ...

Yes, it is just below the very similar function it is derived from (the non-timed variant).

> 
>> diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
>> index a6d20b0719..2fa3d90ad6 100644
>> --- a/include/qemu/main-loop.h
>> +++ b/include/qemu/main-loop.h
>> @@ -263,6 +263,11 @@ int qemu_add_child_watch(pid_t pid);
>>   */
>>  bool qemu_mutex_iothread_locked(void);
>>  
>> +/*
>> + * qemu_cond_timedwait_iothread: like the previous, but with timeout
>> + */
>> +void qemu_cond_timedwait_iothread(QemuCond *cond, int ms);
> 
> ... but it's prototype is in main-loop.h ? That's a little bit
> confusing... I'd rather expect it in include/sysemu/cpus.h instead? Or
> should the new function rather be moved to softmmu/vl.c ?

Here I tried to stay close to the existing code/convention for qemu_cond_wait_iothread,
which together with other similar prototypes is in main_loop.h and implemented in cpus.c

I agree that the current include files are not streamlined, but it would be surprising to find
qemu_cond_wait_iothread and qemu_cond_timedwait_iothread in separate places.

I noticed however that while the implementation is close to its sister function,
I put the prototype in a non-obvious place, I think I should move it just below
qemu_cond_wait_iothread.

> 
>  Thomas
> 

Thanks!

Claudio

