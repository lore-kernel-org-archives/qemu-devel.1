Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B29FC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 633322147A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5r3rBRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633322147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50798 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLWdx-0001lf-Lz
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 13:34:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hLWcH-0000sC-Cp
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hLWcG-0006iz-Ao
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:32:29 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:37759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hLWcG-0006gy-6Z
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:32:28 -0400
Received: by mail-yw1-xc43.google.com with SMTP id a62so6512077ywa.4
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 10:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=pnZeMzauN6wvpHjZ0/W2ENQO7I5smyRwTKX3H6mXbV0=;
	b=P5r3rBRDUjRVJWlTBpDiEcgyQhNp3wBeVBpHrJlIUVAfuOgeFIAzIvatM/uc15aWjH
	rj1kWs+my0XSOM6auuKEOiLb7bledSbm0oXjz5HHUqLguYWbxGp9Ujqi1q3LFrWD57fp
	3U2ZbQiS8SPtmNrnfpKtA0/4uNippEIrVBeftMEEPiE+/TAsocN5Q1oohIZIKpw4UdIM
	uZL91JwMdk98sUW0kPtZ3TD/Ufc8tJG/mShgOmjuVxDhfVOq7YAA+LHcpWC/zBI6lTgF
	vRLWeogZyE6voP5/TRos8j1/iVxuKyvp/j2a5GaYEWc1UhgxvtgSCC9RQ2wg38xKCtxh
	4ghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=pnZeMzauN6wvpHjZ0/W2ENQO7I5smyRwTKX3H6mXbV0=;
	b=lpm00xdoPpcr7VxhCPh7pqYHyLSbNMCtxBTVqPm9Yu11hCQOQAxPPeD75D2QNblQTF
	scIaNs6SmxsKwqm2Z1vTNJ05bdeR1/1Br3INLgkk5tSpx9O/wktrLihBxE3TRdR532X5
	gS6ma1r0JIqcdKhky20xmLm0FIfVt9ImQyWPIsRrxS5WeMXiJA0fzcFEm5BMzc3qcZbw
	5mSRQ1ozlXNlqOuFYH90g33CDsoyCT9PHNIA63o43mbkxpyLLYfsK2Ye9It5GORMck0B
	Fs9+7r+AV0nPTIvWAg5u5ydjfsBsOAmaEr3rCl3k4RItcnwNu969QMH0pIziFMszEKHx
	jWfw==
X-Gm-Message-State: APjAAAVboXg9K++l6ALJRKh5j0qSu1A7Bcrhe1g6fIrvnJepP2+iauE4
	FlQV1s1Ml9oPMJcB9a+MaFds21zsenhJBWXbYm4=
X-Google-Smtp-Source: APXvYqwHYIcLehJWORxwMBqwz2YgPVQ7hw4/uyIMEewv6ieTTrC+ZUhx3d/bsSw3wsXUfZzmo83OpATtW4ZkYAg7D3E=
X-Received: by 2002:a25:3858:: with SMTP id f85mr58758121yba.252.1556645546785;
	Tue, 30 Apr 2019 10:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-24-richard.henderson@linaro.org>
	<CAFEAcA_FZHKXJHg4819JOZkwwhE44Vx874GKrnxRrOau1HhzRw@mail.gmail.com>
In-Reply-To: <CAFEAcA_FZHKXJHg4819JOZkwwhE44Vx874GKrnxRrOau1HhzRw@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 30 Apr 2019 10:32:14 -0700
Message-ID:
 <CAMo8BfJVdDvYWEdN_08ed5OKBGXc+U8kSbmWaSWY9WCuvDj2pw@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c43
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430173214.Go2_ZSfQXlGJrv3sUzqo3yAPRmhK9WrnJnmXZyYs6yg@z>

On Tue, Apr 30, 2019 at 3:11 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 3 Apr 2019 at 05:00, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Cc: Max Filippov <jcmvbkbc@gmail.com>
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  target/xtensa/cpu.h    |  5 +--
> >  target/xtensa/cpu.c    |  5 ++-
> >  target/xtensa/helper.c | 74 +++++++++++++++++++++---------------------
> >  3 files changed, 42 insertions(+), 42 deletions(-)
>
> > -#ifdef CONFIG_USER_ONLY
> > -
> > -int xtensa_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
> > -                                int mmu_idx)
> > +bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> > +                         MMUAccessType access_type, int mmu_idx,
> > +                         bool probe, uintptr_t retaddr)
> >  {
> >      XtensaCPU *cpu = XTENSA_CPU(cs);
> >      CPUXtensaState *env = &cpu->env;
> > +    target_ulong vaddr = address;
> > +    int ret;
> >
> > -    qemu_log_mask(CPU_LOG_INT,
> > -                  "%s: rw = %d, address = 0x%08" VADDR_PRIx ", size = %d\n",
> > -                  __func__, rw, address, size);
> > -    env->sregs[EXCVADDR] = address;
> > -    env->sregs[EXCCAUSE] = rw ? STORE_PROHIBITED_CAUSE : LOAD_PROHIBITED_CAUSE;
> > -    cs->exception_index = EXC_USER;
> > -    return 1;
>
> Previously we set exception_index to EXC_USER...
>
> > +#ifdef CONFIG_USER_ONLY
> > +    ret = (access_type == MMU_DATA_STORE ?
> > +           STORE_PROHIBITED_CAUSE : LOAD_PROHIBITED_CAUSE);
> > +#else
> > +    uint32_t paddr;
> > +    uint32_t page_size;
> > +    unsigned access;
> > +
> > +    ret = xtensa_get_physical_addr(env, true, vaddr, access_type, mmu_idx,
> > +                                   &paddr, &page_size, &access);
> > +
> > +    qemu_log_mask(CPU_LOG_MMU, "%s(%08x, %d, %d) -> %08x, ret = %d\n",
> > +                  __func__, vaddr, access_type, mmu_idx, paddr, ret);
> > +
> > +    if (ret == 0) {
> > +        tlb_set_page(cs, vaddr & TARGET_PAGE_MASK, paddr & TARGET_PAGE_MASK,
> > +                     access, mmu_idx, page_size);
> > +        return true;
> > +    }
> > +    if (probe) {
> > +        return false;
> > +    }
> > +#endif
> > +
> > +    cpu_restore_state(cs, retaddr, true);
> > +    HELPER(exception_cause_vaddr)(env, env->pc, ret, vaddr);
>
> ...but now we'll set it to whatever exception_cause_vaddr does,
> which is something more complicated based on the state of
> env->sregs[PS].
>
> We'll also end up setting env->sregs[PS] bits and env->pc, which
> the old code did not. (In particular since we set the PS_EXCM bit,
> the second time we take an exception won't we then end up
> setting exception_index to EXC_DOUBLE, not EXC_USER ?)

I guess it doesn't matter, because linux-user userspace never handles
exceptions. PS, PC and similar must be fixed up by the linux-user
exception handler. But I haven't tested it.
Richard, is there a branch with this series available somewhere?

-- 
Thanks.
-- Max

