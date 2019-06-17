Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72A2C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:44:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84A39208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hYI8KOdQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A39208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47042 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcqzg-0006t8-OI
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 08:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44158)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <christophe.lyon@linaro.org>) id 1hcqws-0004Mw-5X
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <christophe.lyon@linaro.org>) id 1hcqwq-0007bE-Nw
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:41:22 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:40919)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <christophe.lyon@linaro.org>)
 id 1hcqwq-0007a9-Eg
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:41:20 -0400
Received: by mail-lf1-x144.google.com with SMTP id a9so6379281lff.7
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 05:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q4QZHR04tFJMDCJn2kX/l4auW5B3f6jJvLuZANJ601A=;
 b=hYI8KOdQoVgwgHqwvj49vXqZxDXffCWxbRLqluClwHk6l61PW3htAErPFSQreu9OtT
 MYGyLcsIjN6KklP9deRzF7nVDfQpSQpXNzBxrd69eqh9KDqtxyEDQpBNa9FaN99CxWk5
 0BJYMZGDrrqRH2/twuIcfT6G6X4wPrEki7R1mjIpnUrszTncVGuboP1h8k6TnomtXQ7o
 r/sgksChCl+Vwb5QcdTceHuerXF3a46YAlmdALaEbrTbWKtIr2/KDAXx2JGWHAHkdLtW
 8Q2WC7LEU09aEvhn2nKOkq/nPVtFbmdY4wa2gGOUw2+jyy8u9OXnffAzKO42AZGynvP7
 4Ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q4QZHR04tFJMDCJn2kX/l4auW5B3f6jJvLuZANJ601A=;
 b=CJ0MlRFPi0H1nIK8MCjov+UCKqs3Z9zw059hdeZ7KjBleSSkb7uZ83aNDHGUZ5xz+U
 v91P3J/S1/I1cbC2GcU7HHuGJ2Bny0Llp1rm7lWmoBOKCI3HgGEB2cokk384/sgERmRn
 tjLaEMnwQgolrn0Z7WMQiXaDzy6lj3tl8xbBf4w6hQUedCah5ew9QCHcCg7Y1SOz3+nG
 mLxCA0xTbTw4uacNbouBmqRoezbaIr6nKw4ZusWd4H3j4xS7r9SZMeHM+1lztdErQl0z
 2+yelRA+X1jCgTCB+UcIunPyGNj3cD0UqrpSOylbqVrt+TEL9S5ClxweTT7MVrzzhdwO
 fWOQ==
X-Gm-Message-State: APjAAAXFgRSpym+azyCNJfMopc2VIMuYCHbD3GTwuyFqQJ/wCG+1S9lW
 5A8h+aIqlmMjiZEl3oNpbDA6nvmTw7hhnZ4lrkMSvw==
X-Google-Smtp-Source: APXvYqw1A+1/Ypgrdtpf60rgownB39gNYKbEcWm34v9Ak2/kWeLbbX/W7bdRru62HWl+bXVsPYYQ0z/Xgg/ZKfdoERY=
X-Received: by 2002:a19:6e41:: with SMTP id q1mr47872071lfk.20.1560775278338; 
 Mon, 17 Jun 2019 05:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190616210546.17221-1-richard.henderson@linaro.org>
In-Reply-To: <20190616210546.17221-1-richard.henderson@linaro.org>
From: Christophe Lyon <christophe.lyon@linaro.org>
Date: Mon, 17 Jun 2019 14:41:07 +0200
Message-ID: <CAKdteOa9kCO4+yyrCNFabSQdMQjzNbbBxCx2Zk0p8Gsfm8ycOw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
Subject: Re: [Qemu-devel] [PATCH] tcg: Fix mmap lock assert on translation
 failure
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 16 Jun 2019 at 23:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Check page flags before letting an invalid pc cause a SIGSEGV.
>
> Prepare for eventially validating PROT_EXEC.  The current wrinkle being
> that we have a problem with our implementation of signals.  We should
> be using a vdso like the kernel, but we instead put the trampoline on
> the stack.  In the meantime, let PROT_READ match PROT_EXEC.
>

Thanks for the quick fix, I can confirm it works for my testcase.

Christophe

> Fixes: https://bugs.launchpad.net/qemu/+bug/1832353
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu-all.h                    |  1 +
>  include/exec/cpu_ldst_useronly_template.h |  8 +++++--
>  accel/tcg/translate-all.c                 | 29 +++++++++++++++++++++++
>  3 files changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 536ea58f81..58b8915617 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -259,6 +259,7 @@ int walk_memory_regions(void *, walk_memory_regions_fn);
>  int page_get_flags(target_ulong address);
>  void page_set_flags(target_ulong start, target_ulong end, int flags);
>  int page_check_range(target_ulong start, target_ulong len, int flags);
> +void validate_exec_access(CPUArchState *env, target_ulong s, target_ulong l);
>  #endif
>
>  CPUArchState *cpu_copy(CPUArchState *env);
> diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
> index bc45e2b8d4..f095415149 100644
> --- a/include/exec/cpu_ldst_useronly_template.h
> +++ b/include/exec/cpu_ldst_useronly_template.h
> @@ -64,7 +64,9 @@
>  static inline RES_TYPE
>  glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
>  {
> -#if !defined(CODE_ACCESS)
> +#ifdef CODE_ACCESS
> +    validate_exec_access(env, ptr, DATA_SIZE);
> +#else
>      trace_guest_mem_before_exec(
>          env_cpu(env), ptr,
>          trace_mem_build_info(SHIFT, false, MO_TE, false));
> @@ -88,7 +90,9 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
>  static inline int
>  glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
>  {
> -#if !defined(CODE_ACCESS)
> +#ifdef CODE_ACCESS
> +    validate_exec_access(env, ptr, DATA_SIZE);
> +#else
>      trace_guest_mem_before_exec(
>          env_cpu(env), ptr,
>          trace_mem_build_info(SHIFT, true, MO_TE, false));
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 5d1e08b169..1d4a8a260f 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -2600,10 +2600,39 @@ int page_check_range(target_ulong start, target_ulong len, int flags)
>                  }
>              }
>          }
> +        /*
> +         * FIXME: We place the signal trampoline on the stack,
> +         * even when the guest expects that to be in the vdso.
> +         * Until we fix that, allow execute on any readable page.
> +         */
> +        if ((flags & PAGE_EXEC) && !(p->flags & (PAGE_EXEC | PAGE_READ))) {
> +            return -1;
> +        }
>      }
>      return 0;
>  }
>
> +/*
> + * Called for each code read, longjmp out to issue SIGSEGV if the page(s)
> + * do not have execute access.
> + */
> +void validate_exec_access(CPUArchState *env,
> +                          target_ulong ptr, target_ulong len)
> +{
> +    if (page_check_range(ptr, len, PAGE_EXEC) < 0) {
> +        CPUState *cs = env_cpu(env);
> +        CPUClass *cc = CPU_GET_CLASS(cs);
> +
> +        /* Like tb_gen_code, release the memory lock before cpu_loop_exit.  */
> +        assert_memory_lock();
> +        mmap_unlock();
> +
> +        /* This is user-only.  The target must raise an exception.  */
> +        cc->tlb_fill(cs, ptr, 0, MMU_INST_FETCH, MMU_USER_IDX, false, 0);
> +        g_assert_not_reached();
> +    }
> +}
> +
>  /* called from signal handler: invalidate the code and unprotect the
>   * page. Return 0 if the fault was not handled, 1 if it was handled,
>   * and 2 if it was handled but the caller must cause the TB to be
> --
> 2.17.1
>

