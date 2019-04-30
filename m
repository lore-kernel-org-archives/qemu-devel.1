Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F62C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 10:49:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DCAA20675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 10:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h4iX0os5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCAA20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43080 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLQKV-0001S1-EW
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 06:49:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLQIx-0000SX-5Y
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLQIw-0004wE-7I
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:48:07 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLQIw-0004vo-1H
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:48:06 -0400
Received: by mail-ot1-x344.google.com with SMTP id n15so5393254ota.1
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 03:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=4kYdwOZeIyFXGcXBixjczW8ViVaZVBji2mE3exKcDvE=;
	b=h4iX0os5/IVH6y8ukE7Umzfkhp4cM+jYLW+/30jgkMABFSR3s/1EvwqHj0gbJyqgQX
	4W1bOXviDv0D9efLydtoQnnoB5apCZw2gTNDy+87Wf9Bp6UdFV5UWV+TlsIFx9a8ProH
	/R8xYndzcBwIqompYXJfsHHWKs7COPNUvRzjePENt2K+A7EyLLHzkdzOLwezLPa5BvP/
	5JCSndtZGoJ76Wfsu8EV8AGAUzzuEM9YO0U1sG7xxOHyQ/tQExrrJ0FYrzdIZp+nwUal
	H6D8QP1gq5GDag+jlGIzHd+Xd0/ItK7gT4iGSskn0soVrYKRxZVDNvHaoNbgXJcfveWm
	1QQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=4kYdwOZeIyFXGcXBixjczW8ViVaZVBji2mE3exKcDvE=;
	b=shjcQC/l8S7CuCQpRah2sLNSjvLC/hJoBgot+XE5Zd6eBudeFjvHH8am1FyyEsEXfb
	KcQQ1GkjhgSenju4PCYhhphd9A4qJFYwr3HKWlCBzfdbt1O1F2sTszXTmFsA5+iEWOl+
	L4+SIdmyQeTJ9ow0WH0djFV7XI8cQQawjJCRfikTi1UPxEZvAbucGO8lfJs5Hlxsfx5e
	+XZyF/rZUEs81Z3/quRzDaaQRnkCbb6sA0V35ReHCtyf1HTpxuETnK3MWKXFaPKalSaA
	j7o/TKJjeRsQa+iCw3wVmAxV5Od10LbQoRQ2L1+M2N6rPqgE3/9BOvdgjYYFA91/ZFLY
	stYQ==
X-Gm-Message-State: APjAAAV+rEu79Y2F05Gw3fFa5aJHQFOozSwqmr9IgemubvRIkayLM242
	tfqvmT5KE7XZicUH20giPvH2bz6byDgwO3oDfPwnlg==
X-Google-Smtp-Source: APXvYqxgw3pUYrb75Bq21w8iUP6fa9gql85ThBuZyXgGumF6YgyXv2c5galE5HOKaRkT4XJ3qHKmfwJqR2tqb4WQPHk=
X-Received: by 2002:a9d:360b:: with SMTP id w11mr15556204otb.238.1556621284869;
	Tue, 30 Apr 2019 03:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-13-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 11:47:54 +0100
Message-ID:
 <CAFEAcA9VotyrbWMSjfg-M565sE-HTiyJ_ZhfcvKku0u0fDa9Dg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 12/26] target/moxie: Convert to
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
Cc: Anthony Green <green@moxielogic.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430104754.M7rfVnCW-CxqsxuKZshTCuUfvY9lWRg7WfND__9Ejko@z>

On Wed, 3 Apr 2019 at 04:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: Anthony Green <green@moxielogic.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

>
> -#if defined(CONFIG_USER_ONLY)
> -
> -void moxie_cpu_do_interrupt(CPUState *cs)
> -{
> -    CPUState *cs = CPU(moxie_env_get_cpu(env));
> -
> -    cs->exception_index = -1;
> -}
> -
> -int moxie_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
> -                               int rw, int mmu_idx)
> -{
> -    MoxieCPU *cpu = MOXIE_CPU(cs);
> -
> -    cs->exception_index = 0xaa;
> -    cpu->env.debug1 = address;
> -    cpu_dump_state(cs, stderr, fprintf, 0);
> -    return 1;
> -}

The commit message should say that we can just delete the old
user-only code because we don't have a moxie-linux-user config.

> -
> -#else /* !CONFIG_USER_ONLY */
> -
> -int moxie_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
> -                               int rw, int mmu_idx)
> +bool moxie_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                        MMUAccessType access_type, int mmu_idx,
> +                        bool probe, uintptr_t retaddr)
>  {
>      MoxieCPU *cpu = MOXIE_CPU(cs);
>      CPUMoxieState *env = &cpu->env;
>      MoxieMMUResult res;
>      int prot, miss;
> -    target_ulong phy;
> -    int r = 1;
>
>      address &= TARGET_PAGE_MASK;
>      prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> -    miss = moxie_mmu_translate(&res, env, address, rw, mmu_idx);
> -    if (miss) {
> -        /* handle the miss.  */
> -        phy = 0;
> -        cs->exception_index = MOXIE_EX_MMU_MISS;
> -    } else {
> -        phy = res.phy;
> -        r = 0;
> +    miss = moxie_mmu_translate(&res, env, address, access_type, mmu_idx);
> +    if (likely(!miss)) {
> +        tlb_set_page(cs, address, res.phy, prot, mmu_idx, TARGET_PAGE_SIZE);
> +        return true;
> +    }
> +    if (probe) {
> +        return false;
>      }
> -    tlb_set_page(cs, address, phy, prot, mmu_idx, TARGET_PAGE_SIZE);
> -    return r;
> -}
>
> +    cs->exception_index = MOXIE_EX_MMU_MISS;
> +    cpu_loop_exit_restore(cs, retaddr);
> +}

The old code was calling tlb_set_page() even on an MMU miss,
and the new could doesn't do that. This looks like it was
a bug to me, but if we're fixing bugs we should mention them
in the commit message, at least.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

