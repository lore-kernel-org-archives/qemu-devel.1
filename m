Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BB6C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 09:45:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A6752080C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 09:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j7hRIMpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6752080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42272 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLPK7-0008ET-PN
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 05:45:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLPJA-0007m4-AR
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLPJ9-0005qe-4R
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:44:16 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLPJ8-0005q8-VO
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:44:15 -0400
Received: by mail-ot1-x343.google.com with SMTP id f23so11290374otl.9
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 02:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=9Vh4ks259VgBqm7RvIXoC0vCYgfqPG74C7X8nnzKmcw=;
	b=j7hRIMpHMFCbmojf7qtSRMpgWwhpT7ENBco1sde3o1338TM41GfhjGstpg+EGRFSpy
	QsopB2KKyuVxhAenXh6D6jet5DxAIyhBpWmxO9ZWY/OzW8wVWPcywEy2hi3WpBR7J0IC
	w9A2KRdvl4iCd/DAWMYIHSjJJc9H4cmCGYI43AcwKU2VwasdKqwsCOcA31scmJyZo4T+
	Wn5Bw3qaViQXnv4rTZFyH6yBtkMVtfkk5BrERHeOyG45l/4e94YU6xhtjqdz2JRjzLIZ
	Is6rvXdwUvRgwc+JTyeeTbyD1tWu2WRBhbkWmJ7zY2pg8oFRFIcEdrjTSgWicSk6MnCf
	10gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=9Vh4ks259VgBqm7RvIXoC0vCYgfqPG74C7X8nnzKmcw=;
	b=ql8fbhK8Ec6xXVGPEXHj2FM/qbTNW6ksnWVsZcqJ4M2OYTTFi/a6pb5a6Jt7Xn8cSh
	0S11i3RlRZI4k5k81yiSG8T3Ho7ccfCgciM98XZG8MfpXnxXflj3OIW9Z88piuzOPFkn
	fbM2J3ALuqe+VxG029+k+ep/i5aHQa4ZLRkJXfMRrUFHim0TYRl5/bbfXI/TLGNBk2u3
	GBURCO9EQNAMU4iWljCnH3bAxlCHB6uKmR41EGilEzctUs6NBFcCqGL12CNrPv+SUOwt
	AWtJTFf/QZGc5wA3Qk9TMCQiEl696u3AGsujl1dkzmOyNtFvg4b0f8vFrQldU/+EZerZ
	kUsQ==
X-Gm-Message-State: APjAAAVdBc743Otxp5kF5tO8CquNZaY648GNKf9L0vDm9sXzM/VmZSjU
	TPcnkuugurwOEg/4fy4adUUdWlaASiN+Vh+wBPaJ8Q==
X-Google-Smtp-Source: APXvYqweqpTvq0eD6GLqaRWRqpwlRtFEgp8N6Fh9cfPG4UfjpUmvZ9DUcwf3hy5+pOpGCVXjLU+8b2km33FtMZWm3A8=
X-Received: by 2002:a9d:6156:: with SMTP id c22mr11681042otk.363.1556617453334;
	Tue, 30 Apr 2019 02:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-14-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 10:44:02 +0100
Message-ID:
 <CAFEAcA_PFGUWdhGuPzjuzW7kdu849iRTGLRNMewT-7RnTAuA+A@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 13/26] target/nios2: Convert to
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
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430094402.p23hw9Odpi_KTx8jZggI_HWlsHxMtXVLpmFXRDMvlLE@z>

On Wed, 3 Apr 2019 at 04:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: Chris Wulff <crwulff@gmail.com>
> Cc: Marek Vasut <marex@denx.de>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/nios2/cpu.h    |   5 +-
>  target/nios2/cpu.c    |   5 +-
>  target/nios2/helper.c | 181 ++++++++++++++++++++----------------------
>  target/nios2/mmu.c    |  12 ---
>  4 files changed, 92 insertions(+), 111 deletions(-)
> --- a/target/nios2/helper.c
> +++ b/target/nios2/helper.c
> @@ -36,17 +36,6 @@ void nios2_cpu_do_interrupt(CPUState *cs)
>      env->regs[R_EA] = env->regs[R_PC] + 4;
>  }
>
> -int nios2_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
> -                               int rw, int mmu_idx)
> -{
> -    cs->exception_index = 0xaa;
> -    /* Page 0x1000 is kuser helper */
> -    if (address < 0x1000 || address >= 0x2000) {
> -        cpu_dump_state(cs, stderr, fprintf, 0);
> -    }
> -    return 1;
> -}

For user mode we used to set cs->exception_index to 0xaa...

> +bool nios2_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                        MMUAccessType access_type, int mmu_idx,
> +                        bool probe, uintptr_t retaddr)
> +{
> +    Nios2CPU *cpu = NIOS2_CPU(cs);
> +    CPUNios2State *env = &cpu->env;
> +    unsigned int excp = EXCP_TLBD;

...but in the new code we end up setting it to
EXCP_TLBD, which is 12.

> +
> +#ifndef CONFIG_USER_ONLY

[...]

>  #endif /* !CONFIG_USER_ONLY */
> +
> +    cs->exception_index = excp;
> +    env->regs[CR_BADADDR] = address;
> +    cpu_loop_exit_restore(cs, retaddr);
> +}

We also set env->regs[CR_BADADDR], which we weren't
doing before.

We've lost the cpu_dump_state() as well (though I'm not
sure why that was there -- maybe stray debug printing?)

Otherwise the changes look OK (ie no-behaviour-change).

thanks
-- PMM

