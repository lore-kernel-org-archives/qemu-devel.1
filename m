Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA75C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 11:06:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2153021670
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 11:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fnHetVwz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2153021670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43236 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLQag-0004hf-3Q
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 07:06:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLQZJ-0003q8-G6
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLQZH-0000B9-J6
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:05:00 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLQZH-00009h-13
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:04:59 -0400
Received: by mail-oi1-x244.google.com with SMTP id t81so10850720oig.10
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 04:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=MxGDNdWQZ8/DgUDV0PBRLPM9gCCe2QynjGytKO5kQ7A=;
	b=fnHetVwzW+miYzszrcvg9mpHk6k7rJo37tl5cRQykD3YheAK4QgIPBF+8L3nejPKPe
	mG5v2VgOSnfvygd8TsEa6VLvl2DI1oG6XPF7Tf4ccX35rzeTdCFALRh0rOhFdjhk5RsB
	SFWrlglehBh85XyP6bPi7VkHMRuMloHC87ZE64QT2EUna9ocu4rjUc0Omu7zLRBzI5h0
	fFlcq/X9Oj3r5s7T0q/njQ/X/OGdg9gDLtsBqEjEVLb4+R+nWE1t2EYehhWNa4S1xIl/
	P8zmWjyM3p+LgPrd68hEaEUhj/LRnb8kNiWbigQ8leqmVK+zPsufNRmOKWppHsUXEqhX
	jufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=MxGDNdWQZ8/DgUDV0PBRLPM9gCCe2QynjGytKO5kQ7A=;
	b=Tyoi/921MMUJWBwfiulJog6orX0KpjS10s69miHFtfhGnRkgzUovkYOSL2XYGZDK0l
	h+fnmMnnDgfSfCkIssROh9JNI0901ge6MIa2oSP7JzxLPvmsVYJDrIWxImJ0uuL+TdnM
	u7nQxyRLbVoY4FOSP1ok2M767kWcOzhaksIBK7tWLiCeEUPimDKBvDfEUc/4EVd6KOhh
	TEefPbwf6zHL1adISVlmkZQOmjDAIcf8Ys9jgPFFI+a2yh2tFJ+MHrHoINDloYH4SDTh
	ueI4kivrTGwUjdD+wd1/XO8TaD/Ar3qxq9Mxfdaw0Wb9DU1WnEsKcvQc0dROjxJDz//X
	IRug==
X-Gm-Message-State: APjAAAWYScpM2QHP95ZvRwxn6WVc1m0rcDagLRXgQRErVCDONY/yLMSt
	+YjOUX0SdRfRbDw16XWQw7T8ewqGIHFRwG681gZGuA==
X-Google-Smtp-Source: APXvYqzSPuOGJWY5AdYc6fKe0woKs2c5+i689tiACrB2d6f7+XfVvcyUT+WGaS9rtnPZayiobdcF646fDziFCeRTOuA=
X-Received: by 2002:aca:4b04:: with SMTP id y4mr2369808oia.170.1556622297572; 
	Tue, 30 Apr 2019 04:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-11-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 12:04:46 +0100
Message-ID:
 <CAFEAcA8RQt83x008=+6J2ijUomL=7Ou3qF-=2sWmp9-K57sS-w@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH 10/26] target/microblaze: Convert to
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430110446.ydgxF6OcjdUFRFLqCzIy_LnTn_ZHrfWlQeGQAhkXQqA@z>

On Wed, 3 Apr 2019 at 04:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>



> -#if defined(CONFIG_USER_ONLY)
> +bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                     MMUAccessType access_type, int mmu_idx,
> +                     bool probe, uintptr_t retaddr)
> +{
> +    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
> +    CPUMBState *env = &cpu->env;
> +
> +#ifndef CONFIG_USER_ONLY
> +    uint32_t vaddr, paddr;
> +    struct microblaze_mmu_lookup lu;
> +    unsigned int hit;
> +    int prot;
> +
> +    if (mmu_idx == MMU_NOMMU_IDX) {
> +        /* MMU disabled or not available.  */
> +        address &= TARGET_PAGE_MASK;
> +        prot = PAGE_BITS;
> +        tlb_set_page(cs, address, address, prot, mmu_idx, TARGET_PAGE_SIZE);
> +        return true;
> +    }
> +
> +    hit = mmu_translate(&env->mmu, &lu, address, access_type, mmu_idx);
> +    if (likely(hit)) {
> +        vaddr = address & TARGET_PAGE_MASK;
> +        paddr = lu.paddr + vaddr - lu.vaddr;
> +
> +        qemu_log_mask(CPU_LOG_MMU, "MMU map mmu=%d v=%x p=%x prot=%x\n",
> +                      mmu_idx, vaddr, paddr, lu.prot);
> +        tlb_set_page(cs, vaddr, paddr, lu.prot, mmu_idx, TARGET_PAGE_SIZE);
> +        return true;
> +    }
> +
> +    /* TLB miss.  */
> +    if (probe) {
> +        return false;
> +    }
> +
> +    qemu_log_mask(CPU_LOG_MMU, "mmu=%d miss v=%" VADDR_PRIx "\n",
> +                  mmu_idx, address);
> +
> +    switch (lu.err) {
> +    case ERR_PROT:
> +        env->sregs[SR_ESR] = access_type == MMU_INST_FETCH ? 17 : 16;
> +        env->sregs[SR_ESR] |= (access_type == MMU_DATA_STORE) << 10;
> +        break;
> +    case ERR_MISS:
> +        env->sregs[SR_ESR] = access_type == MMU_INST_FETCH ? 19 : 18;
> +        env->sregs[SR_ESR] |= (access_type == MMU_DATA_STORE) << 10;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    if (cs->exception_index == EXCP_MMU) {
> +        cpu_abort(cs, "recursive faults\n");
> +    }
> +#endif
> +
> +    env->sregs[SR_EAR] = address;
> +    cs->exception_index = EXCP_MMU;
> +    cpu_loop_exit_restore(cs, retaddr);
> +}


> -int mb_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
> -                            int mmu_idx)
> -{
> -    cs->exception_index = 0xaa;
> -    cpu_dump_state(cs, stderr, fprintf, 0);
> -    return 1;
> -}
> -
> -#else /* !CONFIG_USER_ONLY */

For the user-mode case we used to set cs->exception_state to 0xaa,
but now we set it to EXCP_MMU. We also set SR_EAR which we didn't
previously.

Otherwise the refactoring looks ok.

thanks
-- PMM

