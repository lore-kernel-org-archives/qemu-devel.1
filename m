Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A22BC4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 08:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 130652089E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 08:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130652089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52886 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hacRZ-0007Ih-A3
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 04:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54046)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hacNa-0004II-9J
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 04:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hacIH-0006CF-7k
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 04:38:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32954)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hacIH-0006Bf-1g
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 04:38:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so12021944wru.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 01:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cOro0KysdX3QwbpINHnu3I5LEUCneGO+Y3Kh/3Gfvno=;
 b=eYSZneScUVFxIRV9g1ZjiRWBLRxGkFP8eL+VPUaChe35tSbQiHUQp3amiHaYc4vcQW
 rTvjBO6nc5TyQYsAS0XW2OO4DRMMPwst6RKxkOQ+7EGaQCiXMVNinsZVIOuNNtwu2fG8
 HEUk4bT83L9qWmsg5NMItbdwNii3UdXzpzhzS1sBWKCZTPvebsVTUgNervAEYyYedq1r
 T24B4/TlJ5dmcHtu6rCjXyBaTXtMQo6AOKKCZot+CaY7rsljnACU7MjbICNJKyERpKZu
 aAdIKt4J+UHLUo9vVt22/ehZkMcIeDXqD/GUnNuiBj4YSeEohetBc/SMla+d57kVe0lo
 27Bw==
X-Gm-Message-State: APjAAAWbLd9UC+RI3WmQKFqARfrgQ4fjaSqq6oTUVZlazMm5+fLK32zd
 nXNAFS6I0ey/qnjFfzVCxux+ew==
X-Google-Smtp-Source: APXvYqzVZoTnW1b8g0PRPXudbmNDB7srtvoBiSmn96onKc8wwY9IAtcbZ2/OyqKppfgiNkC+d6eBhw==
X-Received: by 2002:a5d:5448:: with SMTP id w8mr15718169wrv.180.1560242292055; 
 Tue, 11 Jun 2019 01:38:12 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2eec:b420:d26b:a0d4:f86e:1389?
 ([2a01:e35:2eec:b420:d26b:a0d4:f86e:1389])
 by smtp.gmail.com with ESMTPSA id a2sm2922753wmj.9.2019.06.11.01.38.11
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 01:38:11 -0700 (PDT)
To: Colin.Xu@intel.com, qemu-devel@nongnu.org
References: <20190610021939.13669-1-colin.xu@intel.com>
 <d2859fe1-df24-e5fa-a5dd-54d5f8640c1b@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e02689d9-ce19-027b-bb6a-ae7471e18d78@redhat.com>
Date: Tue, 11 Jun 2019 10:38:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d2859fe1-df24-e5fa-a5dd-54d5f8640c1b@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] hax: Honor CPUState::halted
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
Cc: liq3ea@gmail.com, Richard Henderson <richard.henderson@linaro.org>,
 armbru@redhat.com, yu.ning@intel.com, chuanxiao.dong@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Paolo & Richard.

On 6/10/19 4:27 AM, Colin Xu wrote:
> cc more.
> 
> On 2019-06-10 10:19, Colin Xu wrote:
>> QEMU tracks whether a vcpu is halted using CPUState::halted. E.g.,
>> after initialization or reset, halted is 0 for the BSP (vcpu 0)
>> and 1 for the APs (vcpu 1, 2, ...). A halted vcpu should not be
>> handed to the hypervisor to run (e.g. hax_vcpu_run()).
>>
>> Under HAXM, Android Emulator sometimes boots into a "vcpu shutdown
>> request" error while executing in SeaBIOS, with the HAXM driver
>> logging a guest triple fault in vcpu 1, 2, ... at RIP 0x3. That is
>> ultimately because the HAX accelerator asks HAXM to run those APs
>> when they are still in the halted state.
>>
>> Normally, the vcpu thread for an AP will start by looping in
>> qemu_wait_io_event(), until the BSP kicks it via a pair of IPIs
>> (INIT followed by SIPI). But because the HAX accelerator does not
>> honor cpu->halted, it allows the AP vcpu thread to proceed to
>> hax_vcpu_run() as soon as it receives any kick, even if the kick
>> does not come from the BSP. It turns out that emulator has a
>> worker thread which periodically kicks every vcpu thread (possibly
>> to collect CPU usage data), and if one of these kicks comes before
>> those by the BSP, the AP will start execution from the wrong RIP,
>> resulting in the aforementioned SMP boot failure.
>>
>> The solution is inspired by the KVM accelerator (credit to
>> Chuanxiao Dong <chuanxiao.dong@intel.com> for the pointer):
>>
>> 1. Get rid of questionable logic that unconditionally resets
>>     cpu->halted before hax_vcpu_run(). Instead, only reset it at the
>>     right moments (there are only a few "unhalt" events).
>> 2. Add a check for cpu->halted before hax_vcpu_run().
>>
>> Note that although the non-Unrestricted Guest (!ug_platform) code
>> path also forcibly resets cpu->halted, it is left untouched,
>> because only the UG code path supports SMP guests.
>>
>> The patch is first merged to android emulator with Change-Id:
>> I9c5752cc737fd305d7eace1768ea12a07309d716
>>
>> Cc: Yu Ning <yu.ning@intel.com>
>> Cc: Chuanxiao Dong <chuanxiao.dong@intel.com>
>> Signed-off-by: Colin Xu <colin.xu@intel.com>
>> ---
>>   cpus.c                |  1 -
>>   target/i386/hax-all.c | 36 ++++++++++++++++++++++++++++++++++--
>>   2 files changed, 34 insertions(+), 3 deletions(-)
>>
>> diff --git a/cpus.c b/cpus.c
>> index ffc57119ca5e..c1a56cd9ab01 100644
>> --- a/cpus.c
>> +++ b/cpus.c
>> @@ -1591,7 +1591,6 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
>>         cpu->thread_id = qemu_get_thread_id();
>>       cpu->created = true;
>> -    cpu->halted = 0;
>>       current_cpu = cpu;
>>         hax_init_vcpu(cpu);
>> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
>> index 44b89c1d74ae..58a27b475ec8 100644
>> --- a/target/i386/hax-all.c
>> +++ b/target/i386/hax-all.c
>> @@ -471,13 +471,35 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
>>           return 0;
>>       }
>>   -    cpu->halted = 0;
>> -
>>       if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
>>           cpu->interrupt_request &= ~CPU_INTERRUPT_POLL;
>>           apic_poll_irq(x86_cpu->apic_state);
>>       }
>>   +    /* After a vcpu is halted (either because it is an AP and has
>> just been
>> +     * reset, or because it has executed the HLT instruction), it
>> will not be
>> +     * run (hax_vcpu_run()) until it is unhalted. The next few if
>> blocks check
>> +     * for events that may change the halted state of this vcpu:
>> +     *  a) Maskable interrupt, when RFLAGS.IF is 1;
>> +     *     Note: env->eflags may not reflect the current RFLAGS
>> state, because
>> +     *           it is not updated after each hax_vcpu_run(). We
>> cannot afford
>> +     *           to fail to recognize any
>> unhalt-by-maskable-interrupt event
>> +     *           (in which case the vcpu will halt forever), and yet
>> we cannot
>> +     *           afford the overhead of hax_vcpu_sync_state(). The
>> current
>> +     *           solution is to err on the side of caution and have
>> the HLT
>> +     *           handler (see case HAX_EXIT_HLT below)
>> unconditionally set the
>> +     *           IF_MASK bit in env->eflags, which, in effect,
>> disables the
>> +     *           RFLAGS.IF check.
>> +     *  b) NMI;
>> +     *  c) INIT signal;
>> +     *  d) SIPI signal.
>> +     */
>> +    if (((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
>> +         (env->eflags & IF_MASK)) ||
>> +        (cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
>> +        cpu->halted = 0;
>> +    }
>> +
>>       if (cpu->interrupt_request & CPU_INTERRUPT_INIT) {
>>           DPRINTF("\nhax_vcpu_hax_exec: handling INIT for %d\n",
>>                   cpu->cpu_index);
>> @@ -493,6 +515,16 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
>>           hax_vcpu_sync_state(env, 1);
>>       }
>>   +    if (cpu->halted) {
>> +        /* If this vcpu is halted, we must not ask HAXM to run it.
>> Instead, we
>> +         * break out of hax_smp_cpu_exec() as if this vcpu had
>> executed HLT.
>> +         * That way, this vcpu thread will be trapped in
>> qemu_wait_io_event(),
>> +         * until the vcpu is unhalted.
>> +         */
>> +        cpu->exception_index = EXCP_HLT;
>> +        return 0;
>> +    }
>> +
>>       do {
>>           int hax_ret;
>>   
> 

