Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6B5C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 05:59:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CAE9205C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 05:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CAE9205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59858 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOFba-0001wH-Ki
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 01:59:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOFas-0001cc-KV
	for qemu-devel@nongnu.org; Wed, 08 May 2019 01:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOFar-0003Yv-Bd
	for qemu-devel@nongnu.org; Wed, 08 May 2019 01:58:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOFar-0003Yo-5v
	for qemu-devel@nongnu.org; Wed, 08 May 2019 01:58:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so1534784wmk.4
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 22:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=dNF5LKjbbYvq8ihtWiY9soX7vEahcPfPLat2Dr05ato=;
	b=jCXdX3yR1Ce4LH/Z1FGaCFSyP98in/+fYeOlgzcxDvejrd3WriwK4Yu6TjJx7QG3fv
	lolCXaHViVReTsidlpuF9DLwYv6qFLfEQrQ68pM6Ba/H5XaRgoDdlMTPDG2b+7Tv8UMo
	8QLuErtqVLBJGfBTJMwuAPYQEZVdslqUBeYJXAxy7VmyPPO9DwFlaf5gdB4PNV6xeksQ
	eAvWj3144FEkKj6PQt9q6UzZS9VPp/FgJuIvKQuIIR+SCA4/W9uelCr94n1faIzWYGLf
	YyLbe3F5uSznp8Uos8m1jsu+W5TjbkypxRm4YlyyJ/kkvJjEtwtEK+j+5h7PF5Rk53Ep
	5Mow==
X-Gm-Message-State: APjAAAVPD7ezVrdE8OO0Uhqy4J6VYPb5tTOGn6Gqqtcnq2TwU+JssUSH
	wsUdXwzsDDBFwLj+7yuGvu/GMHChC4o=
X-Google-Smtp-Source: APXvYqyLlMRJBrblfGxj92x+aK/Cgo8CoOOxePwIBzw3ub/JvMRR6CNG2vySfYitpOECAQk7r/clVw==
X-Received: by 2002:a1c:6342:: with SMTP id x63mr1551782wmb.58.1557295095827; 
	Tue, 07 May 2019 22:58:15 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	r23sm1212616wmh.29.2019.05.07.22.58.14
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 22:58:15 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-3-richard.henderson@linaro.org>
	<CAFEAcA_=PiLXOn+H9=VAdXx-YKDbh0eZ83NDWw=TmbrqTmGn7g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e675b3a8-5230-37a1-b7fa-4597d18b7ab8@redhat.com>
Date: Wed, 8 May 2019 07:58:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_=PiLXOn+H9=VAdXx-YKDbh0eZ83NDWw=TmbrqTmGn7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH 02/26] tcg: Add CPUClass::tlb_fill
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

On 4/29/19 7:25 PM, Peter Maydell wrote:
> On Wed, 3 Apr 2019 at 04:49, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This hook will replace the (user-only mode specific) handle_mmu_fault
>> hook, and the (system mode specific) tlb_fill function.
>>
>> The handle_mmu_fault hook was written as if there was a valid
>> way to recover from an mmu fault, and had 3 possible return states.
>> In reality, the only valid action is to raise an exception,
>> return to the main loop, and delver the SIGSEGV to the guest.
> 
> "deliver"
> 
> You might also mention here that all of the implementations
> of handle_mmu_fault for guest architectures which support
> linux-user do in fact only ever return 1.
> 
>>
>> Using the hook for system mode requires that all targets be converted,
>> so for now the hook is (optionally) used only from user-only mode.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  include/qom/cpu.h     |  9 +++++++++
>>  accel/tcg/user-exec.c | 42 ++++++++++++++----------------------------
>>  2 files changed, 23 insertions(+), 28 deletions(-)
>>
>> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
>> index 1d6099e5d4..7e96a0aed3 100644
>> --- a/include/qom/cpu.h
>> +++ b/include/qom/cpu.h
>> @@ -119,6 +119,12 @@ struct TranslationBlock;
>>   *       will need to do more. If this hook is not implemented then the
>>   *       default is to call @set_pc(tb->pc).
>>   * @handle_mmu_fault: Callback for handling an MMU fault.
>> + * @tlb_fill: Callback for handling a softmmu tlb miss or user-only
>> + *       address fault.  For system mode, if the access is valid, call
>> + *       tlb_set_page and return true; if the access is invalid, and
>> + *       probe is true, return false; otherwise raise an exception and
>> + *       do not return.  For user-only mode, always raise an exception
>> + *       and do not return.
>>   * @get_phys_page_debug: Callback for obtaining a physical address.
>>   * @get_phys_page_attrs_debug: Callback for obtaining a physical address and the
>>   *       associated memory transaction attributes to use for the access.
>> @@ -194,6 +200,9 @@ typedef struct CPUClass {
>>      void (*synchronize_from_tb)(CPUState *cpu, struct TranslationBlock *tb);
>>      int (*handle_mmu_fault)(CPUState *cpu, vaddr address, int size, int rw,
>>                              int mmu_index);
>> +    bool (*tlb_fill)(CPUState *cpu, vaddr address, int size,
>> +                     MMUAccessType access_type, int mmu_idx,
>> +                     bool probe, uintptr_t retaddr);
>>      hwaddr (*get_phys_page_debug)(CPUState *cpu, vaddr addr);
>>      hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu, vaddr addr,
>>                                          MemTxAttrs *attrs);
>> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
>> index fa9380a380..f13c0b2b67 100644
>> --- a/accel/tcg/user-exec.c
>> +++ b/accel/tcg/user-exec.c
>> @@ -65,6 +65,7 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
>>      CPUClass *cc;
>>      int ret;
>>      unsigned long address = (unsigned long)info->si_addr;
>> +    MMUAccessType access_type;
>>
>>      /* We must handle PC addresses from two different sources:
>>       * a call return address and a signal frame address.
>> @@ -151,40 +152,25 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
>>  #if TARGET_LONG_BITS == 32 && HOST_LONG_BITS == 64
>>      g_assert(h2g_valid(address));
>>  #endif
>> -
>> -    /* Convert forcefully to guest address space, invalid addresses
>> -       are still valid segv ones */
> 
> This comment is still valid so I don't think it should be deleted.
> 
>>      address = h2g_nocheck(address);
> 
> Otherwise
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


