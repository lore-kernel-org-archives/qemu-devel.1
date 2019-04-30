Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0136CC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:45:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD5B20835
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oXNyiJ/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD5B20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51124 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLWp5-0000TX-0y
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 13:45:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLWoM-000062-6e
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLWoL-0006iV-0S
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:44:58 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLWoK-0006hr-Oq
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:44:56 -0400
Received: by mail-pl1-x642.google.com with SMTP id w20so6452871plq.3
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 10:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=OAmTvKtvAGlwcO+b0hVMifxRCnGn0mTAB0o39gE3ahE=;
	b=oXNyiJ/dT8uy6Tz3Npmns2zO0pNtdmzLBQO63yFPKEU4VoIjA8eQ02T2NjLQm7huxg
	Zg0894S16KfQHSKXkL7t7ALx/vuuNXFPmgStjKMkxjprprrqzFyy9uPGcvv+OjHMKwGQ
	CkTxbjTL9Vdq5aAfbW9u8vDEX4I9d1JgJXNcyVWSzUp2bjn/mPb1wrE4PCkutMJZk9bQ
	ZwOMfhjepBQTGskc9Ar5NqCiG1adiQF8kup9KC5FVR3s6T+eaY3Av+PFZaCuE1vJ1XSC
	H8dEEyHsEptV21IU6vpukZXnqVVQ9feuR/TgWuoJqjANErn7sQWxzMNuvRSnlpuIKUEE
	57Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=OAmTvKtvAGlwcO+b0hVMifxRCnGn0mTAB0o39gE3ahE=;
	b=m7k84R1u+rez3KCdk9XMAMgyqvFQVzueedgKmSctqmyn8iekriFhhXomh1ilLqIHmF
	nzflaLUiyU8NBZTy18TJLd/xPEgOBbrphxyTFYXxMa460fmbMTl91dxAASbHTUqDOGmv
	m9F4c7ROAwdKWv9B3WwH3JL+Y8DQauXCZTBIXdjRvzW+/8B0FPvkTVnhyAYx3cCl/46E
	L4CpKcAsatarxhqshppmVgI+yDLAb1h27RmBOL1PAn/77PBIqVCWMEuxTt4gkNROMtzv
	esB/5CfrX0YEM3zkZs1YWqr23UxGg8gMy4Rb3P7evwiijuTQmujH+JhHrwWLA6+OwL7d
	R6JA==
X-Gm-Message-State: APjAAAX2vDtrPQiVijB5m4AQv0xPFzjh5fE7ED/6lLGs6a4yH9V047uN
	KsNW6iyxteZ69NyOFYuooh8sZFEFW+8=
X-Google-Smtp-Source: APXvYqzj++5iOvlNoPDsZKZFGCGHfLRhyOfLb5C14k4jIg9G0bQJXx80LfGyifVCayqS2fH0uK1s7Q==
X-Received: by 2002:a17:902:6809:: with SMTP id
	h9mr10683031plk.129.1556646295293; 
	Tue, 30 Apr 2019 10:44:55 -0700 (PDT)
Received: from [192.168.1.11] (97-113-18-231.tukw.qwest.net. [97.113.18.231])
	by smtp.gmail.com with ESMTPSA id
	y68sm2411400pfy.28.2019.04.30.10.44.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 10:44:54 -0700 (PDT)
To: Max Filippov <jcmvbkbc@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-24-richard.henderson@linaro.org>
	<CAFEAcA_FZHKXJHg4819JOZkwwhE44Vx874GKrnxRrOau1HhzRw@mail.gmail.com>
	<CAMo8BfJVdDvYWEdN_08ed5OKBGXc+U8kSbmWaSWY9WCuvDj2pw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <bd57c22c-1bdc-80b4-0415-565117f6ae3e@linaro.org>
Date: Tue, 30 Apr 2019 10:44:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMo8BfJVdDvYWEdN_08ed5OKBGXc+U8kSbmWaSWY9WCuvDj2pw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH 23/26] target/xtensa: Convert to
 CPUClass::tlb_fill
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430174448.ibixoH5PDBqgqxap62oxXp25qPBdzY1-EAUu8gaowVU@z>

On 4/30/19 10:32 AM, Max Filippov wrote:
> On Tue, Apr 30, 2019 at 3:11 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Wed, 3 Apr 2019 at 05:00, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>>
>>> Cc: Max Filippov <jcmvbkbc@gmail.com>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>  target/xtensa/cpu.h    |  5 +--
>>>  target/xtensa/cpu.c    |  5 ++-
>>>  target/xtensa/helper.c | 74 +++++++++++++++++++++---------------------
>>>  3 files changed, 42 insertions(+), 42 deletions(-)
>>
>>> -#ifdef CONFIG_USER_ONLY
>>> -
>>> -int xtensa_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
>>> -                                int mmu_idx)
>>> +bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>>> +                         MMUAccessType access_type, int mmu_idx,
>>> +                         bool probe, uintptr_t retaddr)
>>>  {
>>>      XtensaCPU *cpu = XTENSA_CPU(cs);
>>>      CPUXtensaState *env = &cpu->env;
>>> +    target_ulong vaddr = address;
>>> +    int ret;
>>>
>>> -    qemu_log_mask(CPU_LOG_INT,
>>> -                  "%s: rw = %d, address = 0x%08" VADDR_PRIx ", size = %d\n",
>>> -                  __func__, rw, address, size);
>>> -    env->sregs[EXCVADDR] = address;
>>> -    env->sregs[EXCCAUSE] = rw ? STORE_PROHIBITED_CAUSE : LOAD_PROHIBITED_CAUSE;
>>> -    cs->exception_index = EXC_USER;
>>> -    return 1;
>>
>> Previously we set exception_index to EXC_USER...
>>
>>> +#ifdef CONFIG_USER_ONLY
>>> +    ret = (access_type == MMU_DATA_STORE ?
>>> +           STORE_PROHIBITED_CAUSE : LOAD_PROHIBITED_CAUSE);
>>> +#else
>>> +    uint32_t paddr;
>>> +    uint32_t page_size;
>>> +    unsigned access;
>>> +
>>> +    ret = xtensa_get_physical_addr(env, true, vaddr, access_type, mmu_idx,
>>> +                                   &paddr, &page_size, &access);
>>> +
>>> +    qemu_log_mask(CPU_LOG_MMU, "%s(%08x, %d, %d) -> %08x, ret = %d\n",
>>> +                  __func__, vaddr, access_type, mmu_idx, paddr, ret);
>>> +
>>> +    if (ret == 0) {
>>> +        tlb_set_page(cs, vaddr & TARGET_PAGE_MASK, paddr & TARGET_PAGE_MASK,
>>> +                     access, mmu_idx, page_size);
>>> +        return true;
>>> +    }
>>> +    if (probe) {
>>> +        return false;
>>> +    }
>>> +#endif
>>> +
>>> +    cpu_restore_state(cs, retaddr, true);
>>> +    HELPER(exception_cause_vaddr)(env, env->pc, ret, vaddr);
>>
>> ...but now we'll set it to whatever exception_cause_vaddr does,
>> which is something more complicated based on the state of
>> env->sregs[PS].
>>
>> We'll also end up setting env->sregs[PS] bits and env->pc, which
>> the old code did not. (In particular since we set the PS_EXCM bit,
>> the second time we take an exception won't we then end up
>> setting exception_index to EXC_DOUBLE, not EXC_USER ?)
> 
> I guess it doesn't matter, because linux-user userspace never handles
> exceptions. PS, PC and similar must be fixed up by the linux-user
> exception handler. But I haven't tested it.

It does handle exceptions, in linux-user/xtensa/cpu_loop.c.
And Peter's right that I should have kept EXC_USER.

> Richard, is there a branch with this series available somewhere?

https://github.com/rth7680/qemu/tree/tcg-tlb-fill


r~


