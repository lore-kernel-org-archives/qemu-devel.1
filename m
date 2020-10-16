Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF81C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 08:05:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9BBB207F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 08:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BBB207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTKjc-0002sp-RF
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 04:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kTKf3-0007fE-Vk
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 04:00:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:48792)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kTKf1-0008Hy-N2
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 04:00:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C9530AB95;
 Fri, 16 Oct 2020 08:00:20 +0000 (UTC)
Subject: Re: [PULL 07/37] cpus: extract out hax-specific code to target/i386/
To: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
References: <20201006072947.487729-1-pbonzini@redhat.com>
 <20201006072947.487729-8-pbonzini@redhat.com>
 <a412667e-c486-b002-1e9c-5128345cad75@t-online.de>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <39069adb-ee6d-ddf9-cc70-f069bcab5843@suse.de>
Date: Fri, 16 Oct 2020 10:00:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <a412667e-c486-b002-1e9c-5128345cad75@t-online.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 22:26:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.019,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/20 8:48 AM, Volker Rümelin wrote:
>> From: Claudio Fontana <cfontana@suse.de>
>>
>> register a "CpusAccel" interface for HAX as well.
>>
> 
>> diff --git a/softmmu/cpus.c b/softmmu/cpus.c
>> index 9fa73735a2..900fff827a 100644
>> --- a/softmmu/cpus.c
>> +++ b/softmmu/cpus.c
>> @@ -416,35 +403,6 @@ void qemu_wait_io_event(CPUState *cpu)
>>      qemu_wait_io_event_common(cpu);
>>  }
>>  
>> -static void *qemu_hax_cpu_thread_fn(void *arg)
>> -{
>> -    CPUState *cpu = arg;
>> -    int r;
>> -
>> -    rcu_register_thread();
>> -    qemu_mutex_lock_iothread();
>> -    qemu_thread_get_self(cpu->thread);
>> -
>> -    cpu->thread_id = qemu_get_thread_id();
>> -    current_cpu = cpu;
> 
> Hi Claudio,
> 
> is there a reason why you removed current_cpu = cpu; from hax_cpu_thread_fn() when you moved that function to target/i386/hax-cpus.c? This change broke HAX on Windows. Adding back that line makes it work again.


Hello Volker, I see the change in the history and it was clearly an ugly mistake on my part.
There was no reason or intention to remove the current_cpu = cpu assignment

The fix seems indeed to just + current_cpu = cpu;
and I will send a patch momentarily that does just that,

but I don't know of any CI coverage for Windows + hax currently,
so it would be good if you could spin the change to verify that it fixes the problem.

Ciao,

Claudio

> 
> The simplest reproducer is:
> $ ./qemu-system-x86_64.exe -machine pc,accel=hax -smp 2 -display gtk
> HAX is working and emulator runs in fast virt mode.
> 
> Then the QEMU window opens and shows 'Guest has not initialized the display (yet).' forever.
> 
> A look at the Windows Task Manager suggests one thread is busy looping.
> 
> With best regards,
> Volker
> 
>> -    hax_init_vcpu(cpu);
>> -    cpu_thread_signal_created(cpu);
>> -    qemu_guest_random_seed_thread_part2(cpu->random_seed);
>> -
>> -    do {
>> -        if (cpu_can_run(cpu)) {
>> -            r = hax_smp_cpu_exec(cpu);
>> -            if (r == EXCP_DEBUG) {
>> -                cpu_handle_guest_debug(cpu);
>> -            }
>> -        }
>> -
>> -        qemu_wait_io_event(cpu);
>> -    } while (!cpu->unplug || cpu_can_run(cpu));
>> -    rcu_unregister_thread();
>> -    return NULL;
>> -}
>> -
>>  /* The HVF-specific vCPU thread function. This one should only run when the host
>>   * CPU supports the VMX "unrestricted guest" feature. */
>>  static void *qemu_hvf_cpu_thread_fn(void *arg)
>>


