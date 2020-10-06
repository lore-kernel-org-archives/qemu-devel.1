Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D96C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 18:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95D57206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 18:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URKcrPTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D57206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPrTL-00064w-C3
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 14:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPrR7-0004Xi-Rw; Tue, 06 Oct 2020 14:11:41 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51735)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPrQz-0003pL-Ij; Tue, 06 Oct 2020 14:11:39 -0400
Received: by mail-wm1-x343.google.com with SMTP id d81so3869502wmc.1;
 Tue, 06 Oct 2020 11:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DZyZJdm4muyeZIvxmbfJ7Dzpyn8EAerSoefjqZp86+U=;
 b=URKcrPTj1aBM5t/papfsHBrtU6WwJph69QdXlL4GwWGt1epQqfFmGr7rgTdow2rZ+T
 QgaBr/CCp4uzr1W38IZTGmYLeHs1B0T25Wtg/DZvJCFUQdawff7khz5q3aNhFfcN+jWI
 nUBwD62hLy0hkCTT83THtjaN3DMgRKLhp7+8rsPIYs7f6VIG6owOaum50iAiJfJC0mRu
 o5tZD5Ub1xbukwA7DCAhTLB/FWaOBUbzjZ4NZt4hw7T9pkf/3hQpuhfbIPxSLCyx2Qca
 Y77p4Ch3bTg4ccwSPJqsF7IyYzsmY5WdLkAwT/us+5CU8weTllnTJRUXFduhQDo1jTCt
 2Nog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DZyZJdm4muyeZIvxmbfJ7Dzpyn8EAerSoefjqZp86+U=;
 b=tGqFFMZSFBYKu5+Ik3oVzXIvBSdTULMuPodwjTRJIYfcHP6Dhtu3YrXSKMvVUPQufc
 iXWROviKtaycv6DvSFyfMonQ83Hr08HTNr7cTXmVyVA1pIAXz9+MYgBCVAx0ygloMe4c
 5TwFJ/vCTgqtP1tJLZ08D4KVZloPDqS6lyjuA/UOZ6mLDpP5azNpjjblElGm51TE3j1/
 gEBxvAT0+d8PsEkLwhSN9lZipxnXM2Za+kKhjpCXRfyqP/ARinqBnyu10VgHPvwPrcaW
 kQfMs9liJDMCnJ9YU34lvsKPR1miu0C4zLg9KysG8+vMJ1vSrdraog+/+DtgjuNhMihz
 Lndg==
X-Gm-Message-State: AOAM532P08SKooBZuWwMlgwpyxD2e0eQeYLBoJ30edwO8LVRM9euqSla
 C77+u6sY6/raDqb+OhCUwSA=
X-Google-Smtp-Source: ABdhPJxOVVldIcK3u7jZwb5CX33EYaVrIQ0dm6+N+NjkAm69v8RKmvfsQaOTl6XUcC7ZnCbv5lxV9g==
X-Received: by 2002:a1c:5a06:: with SMTP id o6mr6311641wmb.181.1602007890904; 
 Tue, 06 Oct 2020 11:11:30 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id s17sm5036540wmj.1.2020.10.06.11.11.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 11:11:30 -0700 (PDT)
Subject: Re: [PATCH 01/16] hw/core/cpu: Let CPU object have a clock source
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200928171539.788309-1-f4bug@amsat.org>
 <20200928171539.788309-2-f4bug@amsat.org>
 <20200930094313.1120a040@redhat.com>
 <da7248f7-5098-188b-d274-e122c87bb498@amsat.org>
 <20201005184009.493629b0@redhat.com> <20201005174454.GM7303@habkost.net>
 <8c337ca9-4f03-e6df-0e67-f8ca2b3248e7@amsat.org>
 <ff8b4e4f-e9d3-2539-73a5-1715028a6a76@amsat.org>
 <20201005192208.GO7303@habkost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4c15f35a-110a-5021-77f0-97427b12bd64@amsat.org>
Date: Tue, 6 Oct 2020 20:11:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201005192208.GO7303@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Paul Burton <paulburton@kernel.org>, Huacai Chen <zltjiangshi@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Luc Michel <luc.michel@greensocs.com>, Cleber Rosa <crosa@redhat.com>,
 Huacai Chen <chenhc@lemote.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/5/20 9:22 PM, Eduardo Habkost wrote:
> On Mon, Oct 05, 2020 at 08:29:24PM +0200, Philippe Mathieu-Daudé wrote:
>> On 10/5/20 8:09 PM, Philippe Mathieu-Daudé wrote:
>>> On 10/5/20 7:44 PM, Eduardo Habkost wrote:
>>>> On Mon, Oct 05, 2020 at 06:40:09PM +0200, Igor Mammedov wrote:
>>>>> On Wed, 30 Sep 2020 12:16:53 +0200
>>>>> Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>>
>>>>>> +arm/ppc/riscv folks
>>>>>>
>>>>>> On 9/30/20 9:43 AM, Igor Mammedov wrote:
>>>>>>> On Mon, 28 Sep 2020 19:15:24 +0200
>>>>>>> Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>>>>   
>>>>>>>> Let CPUState have a clock source (named 'clk') and CPUClass
>>>>
>>>> The language here confuses me: is this a clock source inside the
>>>> CPU, or just a clock input that can be connected to a clock
>>>> source somewhere?
>>>
>>> 2nd description, "somewhere". I'll reword.
>>>
>>>>
>>>> See also comment below[1].
>>>>
>>>>>>>> have a clock_update() callback. The clock can be optionally
>>>>>>>> set Using qdev_connect_clock_in() from the Clock API.
>>>>>>>> If the clock changes, the optional clock_update() will be
>>>>>>>> called.  
>>>>
>>>> What does "clock change" means?  Is this just about the
>>>> frequency, or something else?
>>>
>>> A frequency changes -- which can be because a parent (in the
>>> clock tree) changed its source using a MUX.
>>>
>>>>
>>>> (By reading the Clock API documentation, it looks like it only
>>>> represents the clock frequency, but I'm not sure)
>>>>
>>>>>>>
>>>>>>> the sole user of it is mips cpu, so question is why
>>>>>>> you are making it part of generic CPUm instead of
>>>>>>> MIPSCPUClass/MIPSCPU?  
>>>>>>
>>>>>> This is a feature of the CPU, regardless its architecture.
>>>>>>
>>>>>> I expect the other archs to start using it soon.
>>>>>
>>>>> if there aren't any plans to actually to do that,
>>>>> I'd keep it to MIPS class and generalize later when there is demand.
>>>
>>> No problem.
>>>
>>>>
>>>> I normally don't mind if a feature is generic from the beginning.
>>>> But in this case I'm inclined to agree with Igor.  Unless we
>>>> expect to see arch-independent code to use CPUState.clock soon
>>>> (do we?), having CPUState.clock existing but unused by most
>>>> architectures would be misleading.
>>>>
>>>> Also, at least on x86 there are so many different clock sources,
>>>> that I'm not sure it would be a desirable to have a generic clock
>>>> input named "clk".
>>>
>>> Well X86 is the arch I'm less confident with. Anyhow if it has
>>> multiple clock sources, I'd expect a Clock MUX block to select
>>> an unique clock to feed the CPU.
>>>
>>>>
>>>>>  
>>>>>>
>>>>>>>   
>>>>>>>>
>>>>>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>>>>>> ---
>>>>>>>>  include/hw/core/cpu.h |  5 +++++
>>>>>>>>  hw/core/cpu.c         | 12 ++++++++++++
>>>>>>>>  2 files changed, 17 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>>>>>>>> index 6c34798c8b3..6989d90c193 100644
>>>>>>>> --- a/include/hw/core/cpu.h
>>>>>>>> +++ b/include/hw/core/cpu.h
>>>>>>>> @@ -31,6 +31,7 @@
>>>>>>>>  #include "qemu/thread.h"
>>>>>>>>  #include "qemu/plugin.h"
>>>>>>>>  #include "qom/object.h"
>>>>>>>> +#include "hw/clock.h"
>>>>>>>>  
>>>>>>>>  typedef int (*WriteCoreDumpFunction)(const void *buf, size_t size,
>>>>>>>>                                       void *opaque);
>>>>>>>> @@ -155,6 +156,7 @@ struct TranslationBlock;
>>>>>>>>   * @disas_set_info: Setup architecture specific components of disassembly info
>>>>>>>>   * @adjust_watchpoint_address: Perform a target-specific adjustment to an
>>>>>>>>   * address before attempting to match it against watchpoints.
>>>>>>>> + * @clock_update: Callback for input clock changes
>>>>>>>>   *
>>>>>>>>   * Represents a CPU family or model.
>>>>>>>>   */
>>>>>>>> @@ -176,6 +178,7 @@ struct CPUClass {
>>>>>>>>                                    unsigned size, MMUAccessType access_type,
>>>>>>>>                                    int mmu_idx, MemTxAttrs attrs,
>>>>>>>>                                    MemTxResult response, uintptr_t retaddr);
>>>>>>>> +    void (*clock_update)(CPUState *cpu);
>>>>>>>>      bool (*virtio_is_big_endian)(CPUState *cpu);
>>>>>>>>      int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
>>>>>>>>                             uint8_t *buf, int len, bool is_write);
>>>>>>>> @@ -316,6 +319,7 @@ struct qemu_work_item;
>>>>>>>>   *   QOM parent.
>>>>>>>>   * @nr_cores: Number of cores within this CPU package.
>>>>>>>>   * @nr_threads: Number of threads within this CPU.
>>>>>>>> + * @clock: this CPU source clock (an output clock of another device)
>>>>
>>>> [1]
>>>>
>>>> What does "source clock" means?  Is this the same as "clock input"?
>>>
>>> Yes, for clocks it is common to use source/sink instead of input/output.
>>> I'll try to reword.
>>
>> Hard to reword when it looks clear to oneself...
>>
>> @clock is the source, @cpu is the sink.
>> @clock clocks @cpu at some frequency.
>>
>> One output from @clock is the @cpu.
>> The @cpu has an unique input: @clock.
> 
> The interchangeable usage of "clock source" and "clock input" is
> what confuses me here.  CPUState.clock seems to be a clock input,
> which may or may not be connected to a clock source.
> 
> You seem to imply that "clock source" and "clock input" are
> synonymous, but that's not what I understand from the clock API
> documentation.

Hmm the concepts are different.

From a clock generator point of view, the "output" is
the point where the signal leaves the block, to be
eventually consumed by a sink. The generator doesn't
know what the sinks are made of:

+-----------+   +----------> Sink1
|           |   |
|           +---+ ClkOut1
|           |   |
|  ClkGen   |   +----------> Sink2
|           |
|           +--> ClkOut2
|           |
+-----------+

From a device point of view, the "input" is where
the external signal (generated by a source) is
connected. The device doesn't know what is the
source made of:

                     +-----------+
                     |           |
                     |           |
(Source)  ClkIn ----->  Device   |
                     |           |
                     |           |
                     +-----------+

So input/output refer to interface to connect the
clock signal.

Source/sink refer to the other object having a
relation with this signal.

> 
>>
>> Damien/Peter/Luc, do you have better description suggestions?
>>
>>>
>>>>
>>>>
>>>>>>>>   * @running: #true if CPU is currently running (lockless).
>>>>>>>>   * @has_waiter: #true if a CPU is currently waiting for the cpu_exec_end;
>>>>>>>>   * valid under cpu_list_lock.
>>>>>>>> @@ -400,6 +404,7 @@ struct CPUState {
>>>>>>>>      int num_ases;
>>>>>>>>      AddressSpace *as;
>>>>>>>>      MemoryRegion *memory;
>>>>>>>> +    Clock *clock;
>>>>>>>>  
>>>>>>>>      void *env_ptr; /* CPUArchState */
>>>>>>>>      IcountDecr *icount_decr_ptr;
>>>>>>>> diff --git a/hw/core/cpu.c b/hw/core/cpu.c
>>>>>>>> index c55c09f734c..37fcff3ec64 100644
>>>>>>>> --- a/hw/core/cpu.c
>>>>>>>> +++ b/hw/core/cpu.c
>>>>>>>> @@ -30,6 +30,7 @@
>>>>>>>>  #include "qemu/qemu-print.h"
>>>>>>>>  #include "sysemu/tcg.h"
>>>>>>>>  #include "hw/boards.h"
>>>>>>>> +#include "hw/qdev-clock.h"
>>>>>>>>  #include "hw/qdev-properties.h"
>>>>>>>>  #include "trace/trace-root.h"
>>>>>>>>  #include "qemu/plugin.h"
>>>>>>>> @@ -247,6 +248,16 @@ void cpu_reset(CPUState *cpu)
>>>>>>>>      trace_guest_cpu_reset(cpu);
>>>>>>>>  }
>>>>>>>>  
>>>>>>>> +static void cpu_clk_update(void *opaque)
>>>>>>>> +{
>>>>>>>> +    CPUState *cpu = opaque;
>>>>>>>> +    CPUClass *cc = CPU_GET_CLASS(cpu);
>>>>>>>> +
>>>>>>>> +    if (cc->clock_update) {
>>>>>>>> +        cc->clock_update(cpu);
>>>>>>>> +    }
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>  static void cpu_common_reset(DeviceState *dev)
>>>>>>>>  {
>>>>>>>>      CPUState *cpu = CPU(dev);
>>>>>>>> @@ -367,6 +378,7 @@ static void cpu_common_initfn(Object *obj)
>>>>>>>>      /* the default value is changed by qemu_init_vcpu() for softmmu */
>>>>>>>>      cpu->nr_cores = 1;
>>>>>>>>      cpu->nr_threads = 1;
>>>>>>>> +    cpu->clock = qdev_init_clock_in(DEVICE(obj), "clk", cpu_clk_update, cpu);
>>>>>>>>  
>>>>>>>>      qemu_mutex_init(&cpu->work_mutex);
>>>>>>>>      QSIMPLEQ_INIT(&cpu->work_list);  
>>>>>>>   
>>>>>>
>>>>>
>>>>
>>>
>>
> 

