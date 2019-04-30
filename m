Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C43C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 10:20:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C9721670
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 10:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NA5QHkjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C9721670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42599 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLPrj-0002gS-Gf
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 06:19:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLPpi-0001Py-W4
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLPjX-00076Q-It
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:11:32 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLPjX-000765-DC
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:11:31 -0400
Received: by mail-ot1-x343.google.com with SMTP id o39so113584ota.6
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 03:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=i5io46Kav2gQs961t3VuYW7PbPNoFv0KP03aGQgLLEg=;
	b=NA5QHkjTUBGjNSCka24qkb8yZtoQhO6aMsbrkVL9kVr8uUAW+xIXUFg4+376mO18uZ
	nh/R+mLlA+WSrLBNicmdcN7JgPhq5IyEd1LNJL7LwD7dyZA7RBdVrdWWoyXSrb63a57k
	PCHhM9x8ThauoUlAfSNGW9TJrG4HrnW3Jb7UWmVl0OF7y4OhuKSVcBAIQZgiwXFHmL3Z
	1B6e9J6nIiTomLv4R6vdM7MvTHOnh9ylKYFPfHMk5LoZXSjnt/J6AbjxjUNOGQollKdx
	Vm3Hl10NBwSwwkWx/URyr2XVJ5+huBcas/vs+KJzkljsTyw7yTJszsdS3WhPKz+OiNDS
	1Ndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=i5io46Kav2gQs961t3VuYW7PbPNoFv0KP03aGQgLLEg=;
	b=XJvOVhzGBX9SHsXKpR7UZdDyLlgY4niECKDPnJ3PAvvhHzLrl+bZhxusUIuu/Ohgc4
	w+snuNwG86YqHP0Z2vnGNDyiEimD95YDTuiAjmsee/62oLnYHO1Iwi62EX+YRT1HWqye
	/YvwbDKL+WswcZFYTGRODU0nT34tk9OyFaYyTHdHT7loYZfxQOthyvtDlKUS6A9o/1ff
	h1DwXgGFgZnCUHrYQhl/LYkwIZbHKN7UKWD/VC5Dy9NgFExnNvt64wjytBvtaWSj70fr
	es5S5WQp4MIsjeVGzIl6kZINqN8XJFlA4bQTfwzWxtx/UCxDI/FVoQBeGZgBM18x0And
	StEQ==
X-Gm-Message-State: APjAAAVNKxLnYVH6F9y4BwFAQ1MoKlA88Ee7M4GaqrX7UF47e7eEK817
	cO1dcG10eTjBLFQlHYjP9HPwoCt7nI5qPTq2YaZrQA==
X-Google-Smtp-Source: APXvYqxW8268gnUu9QjrAo4NK+OQPDKP8P/x+dP8w1pvTHo9aR1JWk2vis9laS+lNyU/mK1hoX/JEGrmPwBnza11XTU=
X-Received: by 2002:a9d:61c6:: with SMTP id h6mr4360695otk.316.1556619090733; 
	Tue, 30 Apr 2019 03:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-24-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-24-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 11:11:19 +0100
Message-ID:
 <CAFEAcA_FZHKXJHg4819JOZkwwhE44Vx874GKrnxRrOau1HhzRw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430101119.sMSf6ZulW-8OunAWoEPfI-2GDbOzVnB3T-03wpDBNtw@z>

On Wed, 3 Apr 2019 at 05:00, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/xtensa/cpu.h    |  5 +--
>  target/xtensa/cpu.c    |  5 ++-
>  target/xtensa/helper.c | 74 +++++++++++++++++++++---------------------
>  3 files changed, 42 insertions(+), 42 deletions(-)

> -#ifdef CONFIG_USER_ONLY
> -
> -int xtensa_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
> -                                int mmu_idx)
> +bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                         MMUAccessType access_type, int mmu_idx,
> +                         bool probe, uintptr_t retaddr)
>  {
>      XtensaCPU *cpu = XTENSA_CPU(cs);
>      CPUXtensaState *env = &cpu->env;
> +    target_ulong vaddr = address;
> +    int ret;
>
> -    qemu_log_mask(CPU_LOG_INT,
> -                  "%s: rw = %d, address = 0x%08" VADDR_PRIx ", size = %d\n",
> -                  __func__, rw, address, size);
> -    env->sregs[EXCVADDR] = address;
> -    env->sregs[EXCCAUSE] = rw ? STORE_PROHIBITED_CAUSE : LOAD_PROHIBITED_CAUSE;
> -    cs->exception_index = EXC_USER;
> -    return 1;

Previously we set exception_index to EXC_USER...

> +#ifdef CONFIG_USER_ONLY
> +    ret = (access_type == MMU_DATA_STORE ?
> +           STORE_PROHIBITED_CAUSE : LOAD_PROHIBITED_CAUSE);
> +#else
> +    uint32_t paddr;
> +    uint32_t page_size;
> +    unsigned access;
> +
> +    ret = xtensa_get_physical_addr(env, true, vaddr, access_type, mmu_idx,
> +                                   &paddr, &page_size, &access);
> +
> +    qemu_log_mask(CPU_LOG_MMU, "%s(%08x, %d, %d) -> %08x, ret = %d\n",
> +                  __func__, vaddr, access_type, mmu_idx, paddr, ret);
> +
> +    if (ret == 0) {
> +        tlb_set_page(cs, vaddr & TARGET_PAGE_MASK, paddr & TARGET_PAGE_MASK,
> +                     access, mmu_idx, page_size);
> +        return true;
> +    }
> +    if (probe) {
> +        return false;
> +    }
> +#endif
> +
> +    cpu_restore_state(cs, retaddr, true);
> +    HELPER(exception_cause_vaddr)(env, env->pc, ret, vaddr);

...but now we'll set it to whatever exception_cause_vaddr does,
which is something more complicated based on the state of
env->sregs[PS].

We'll also end up setting env->sregs[PS] bits and env->pc, which
the old code did not. (In particular since we set the PS_EXCM bit,
the second time we take an exception won't we then end up
setting exception_index to EXC_DOUBLE, not EXC_USER ?)

thanks
-- PMM

