Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE93C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:23:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B340217D7
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7eKSgza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B340217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59228 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOnhq-0000AD-M7
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 14:23:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOnfi-0007Er-Ao
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOnfh-00085J-AB
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:21:34 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:38446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOnfh-00084k-2z
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:21:33 -0400
Received: by mail-lf1-x144.google.com with SMTP id y19so2257868lfy.5
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 11:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=vTTcP1atlRjqA1v73RbGLpI4QztLCtimT/yo3k5IS9Q=;
	b=C7eKSgza5lUv+s/U9Za47aY0FeW11+EqmGMpItoLZBP0xC0zUh98r3EVVQVPwxBUIf
	FSSJqG6bW8NqZbcPWsHfHoHJg1lbVsdk6VDZ5ussilmF5r+PQhuU1UfvMsCZh7ztqdgB
	dG5e1yzfxpSVD8DX26WEZejzQizwf9mIFoHcsk6AlcgPeiZsIkEr6mjUHQZb1BgJul6y
	P/3zmPgDzTZAUzM1+t+CWy4gglbGNDSDngB5UywwnWVe7U7thE1B137Cqew03Nejb1tF
	NkPo/BHAe9WaoCkNVcJFsXTUTKGIZoVifa4MEYzuh3pRuS1rotDGoglNI3LUyeUpEqeV
	OO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=vTTcP1atlRjqA1v73RbGLpI4QztLCtimT/yo3k5IS9Q=;
	b=ktYhBHd7tOLTSAZyOXFFZe3narqrrjwaexKY841r2uyceNB/1A/Y9GeXJmmv+G6gTV
	ZKYR7YSreL0NTwfyHSuZOXktZwlx/ePAD8Y9Cn0IrLdl1K6lO1eJL0pAwuPrVOhHyhkC
	L3plup92qdPY+U6EDyAA9cSESBWdNth3nR3vmT+ATwAGb2gV/gAPJ8ppr5CpZPBLf91+
	Saj/K+wFIflAKa5XBkyp0NDs2YFM/3GN9UFU6sAXquFrF8fbSDc31X8PNAK9Gy9dYfCo
	hMqGoIaHt+NZBq8o9HSgNfunKr3i9fDA8LdVEcXiBn8Ksp5NeR7AgDAVsX5wSpaMF6WZ
	mAKA==
X-Gm-Message-State: APjAAAV3gjyAzyaL22lu96x2dggsHl7o1BQQWwe7E0SeJx6oa37vefKE
	NegnTivwV+IZ2Z76tuZNUXQZBYJNtLWY2heIU0M=
X-Google-Smtp-Source: APXvYqwPl5os99e+qQZV2pqnCyhGoc77WklisIkNM+01G80tAnnjzXWCvLs+C3LvxLDjl0a6fFhpnCgtTffh9CpyjaY=
X-Received: by 2002:a19:4a04:: with SMTP id x4mr3257959lfa.124.1557426091825; 
	Thu, 09 May 2019 11:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-20-richard.henderson@linaro.org>
In-Reply-To: <20190508000641.19090-20-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 May 2019 11:19:25 -0700
Message-ID: <CAKmqyKMArOc8=f547KnHqQ9Ufj8SpQgQfYxxCmk_UQhBtjJ+Hw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::144
Subject: Re: [Qemu-devel] [PATCH v3 19/39] target/moxie: Use env_cpu,
 env_archcpu
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 7, 2019 at 5:20 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/moxie/cpu.h       | 5 -----
>  target/moxie/helper.c    | 6 +++---
>  target/moxie/translate.c | 2 +-
>  3 files changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
> index 5b9aae95d2..a481a92833 100644
> --- a/target/moxie/cpu.h
> +++ b/target/moxie/cpu.h
> @@ -90,11 +90,6 @@ typedef struct MoxieCPU {
>      CPUMoxieState env;
>  } MoxieCPU;
>
> -static inline MoxieCPU *moxie_env_get_cpu(CPUMoxieState *env)
> -{
> -    return container_of(env, MoxieCPU, env);
> -}
> -
>  #define ENV_OFFSET offsetof(MoxieCPU, env)
>
>  void moxie_cpu_do_interrupt(CPUState *cs);
> diff --git a/target/moxie/helper.c b/target/moxie/helper.c
> index 287a45232c..a18b21c4c0 100644
> --- a/target/moxie/helper.c
> +++ b/target/moxie/helper.c
> @@ -42,7 +42,7 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
>
>  void helper_raise_exception(CPUMoxieState *env, int ex)
>  {
> -    CPUState *cs = CPU(moxie_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>
>      cs->exception_index = ex;
>      /* Stash the exception type.  */
> @@ -79,7 +79,7 @@ uint32_t helper_udiv(CPUMoxieState *env, uint32_t a, uint32_t b)
>
>  void helper_debug(CPUMoxieState *env)
>  {
> -    CPUState *cs = CPU(moxie_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>
>      cs->exception_index = EXCP_DEBUG;
>      cpu_loop_exit(cs);
> @@ -89,7 +89,7 @@ void helper_debug(CPUMoxieState *env)
>
>  void moxie_cpu_do_interrupt(CPUState *cs)
>  {
> -    CPUState *cs = CPU(moxie_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>
>      cs->exception_index = -1;
>  }
> diff --git a/target/moxie/translate.c b/target/moxie/translate.c
> index c668178f2c..c87e9ec2b1 100644
> --- a/target/moxie/translate.c
> +++ b/target/moxie/translate.c
> @@ -816,7 +816,7 @@ static int decode_opc(MoxieCPU *cpu, DisasContext *ctx)
>  void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
>  {
>      CPUMoxieState *env = cs->env_ptr;
> -    MoxieCPU *cpu = moxie_env_get_cpu(env);
> +    MoxieCPU *cpu = env_archcpu(env);
>      DisasContext ctx;
>      target_ulong pc_start;
>      int num_insns;
> --
> 2.17.1
>
>

