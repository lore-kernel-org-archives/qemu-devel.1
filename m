Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E3AC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:12:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6F6A2084E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYORPvMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F6A2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59076 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOnWS-000297-6a
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 14:12:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOnV8-00010F-AJ
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:10:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOnV7-0001mI-6T
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:10:38 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:33643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOnV6-0001k0-UV
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:10:37 -0400
Received: by mail-lj1-x241.google.com with SMTP id w1so268960ljw.0
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 11:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=gVTbPBUMhAp1p9AzQ0kEU+0GQJ2ctD9A3WAh3Ss8YqY=;
	b=dYORPvMMSIOZCciT62nbcexDQxJnQzrh8dm11KoPKXaa29YnYMntelgfyYy/6i4mFY
	XJ1R7Ro/klt7pmrM1yv+zvqxWeZ6cYV1MLcXMaGp/7QxwelOwbvBQyuDXOo3TEG7BUnG
	+xrA/0+Da9jhyXNoaYWJQM+IW5ZalYCqxUglo7twlzETVvprxshWt0ufEG3kYPC443z9
	SCPxcUDn+kXAd9DmcrPoylwmxE+avfQ7+5zZ+oaB15h9oWYwC6vTkcn7lWMj/MbtyJDA
	Ruw2uu/T8UYxbr2WTulvauCcxPpAZZYJ9zPVHJWvlJ4PRLGKQ1Q8vuS6z621dsfNf2/W
	m1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=gVTbPBUMhAp1p9AzQ0kEU+0GQJ2ctD9A3WAh3Ss8YqY=;
	b=K1u6HJAI7/YHE/rgSp6S3eSkMbFcyUUviejD85uEflJp9nVfMgABaZ9XXxzyULFPcv
	hPTSJ7h/EFOSNIKypbXjMZRSPJyY4HlIuP2dIj0OG3bMqYo0fOZ+wBtJquTbm6Ms22sX
	BTMgtcVXettJdpxxInGXoNgcs1CzeVtqhmrfGhgEB6SciagAobztLjowI+qeuigsbaHE
	vVnb+QW49MPMfGFA0qgSU8ljp5KIReVY3CiYGVgJeBcl1o1T9CRc8G0rkEqcfnRKMewr
	lCGQxhrcKrnxYGeVUwtZxz0Dy+rHBUC/gPiVEuONcJzABUz6/YHP/gC8SwMJwz+3GrvO
	0eEA==
X-Gm-Message-State: APjAAAV4kfK1zDCBBidirmTXVHp3QcXvLqdgduZM/dWr1WTH89IvZA8E
	jpssiM5jI0s5H8PQUo6G/G8YLu495eFQ5YqEr394JnNN
X-Google-Smtp-Source: APXvYqy9hcLeeCej74QuKF1q1RiLCSEqdJvxSv1zYmcbPJ+jrhqaBW83pt9/mEkGmuuM8iBI/UwvxUbluEjc6LjYI/4=
X-Received: by 2002:a2e:5b92:: with SMTP id m18mr3363276lje.115.1557425435325; 
	Thu, 09 May 2019 11:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-16-richard.henderson@linaro.org>
In-Reply-To: <20190508000641.19090-16-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 May 2019 11:08:28 -0700
Message-ID: <CAKmqyKMxHZHQJZgFWkLS3Ud2gFJ1o7MZp+tthKtAtU7Z1wdCqg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v3 15/39] target/lm32: Use env_cpu,
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

On Tue, May 7, 2019 at 5:17 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/lm32/cpu.h       |  5 -----
>  target/lm32/helper.c    | 19 ++++++-------------
>  target/lm32/op_helper.c |  6 +++---
>  target/lm32/translate.c |  2 +-
>  4 files changed, 10 insertions(+), 22 deletions(-)
>
> diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
> index c6b252f90a..8e7b70a275 100644
> --- a/target/lm32/cpu.h
> +++ b/target/lm32/cpu.h
> @@ -195,11 +195,6 @@ struct LM32CPU {
>      uint32_t features;
>  };
>
> -static inline LM32CPU *lm32_env_get_cpu(CPULM32State *env)
> -{
> -    return container_of(env, LM32CPU, env);
> -}
> -
>  #define ENV_OFFSET offsetof(LM32CPU, env)
>
>  #ifndef CONFIG_USER_ONLY
> diff --git a/target/lm32/helper.c b/target/lm32/helper.c
> index a039a993ff..674cbd7fe4 100644
> --- a/target/lm32/helper.c
> +++ b/target/lm32/helper.c
> @@ -58,28 +58,23 @@ hwaddr lm32_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>
>  void lm32_breakpoint_insert(CPULM32State *env, int idx, target_ulong address)
>  {
> -    LM32CPU *cpu = lm32_env_get_cpu(env);
> -
> -    cpu_breakpoint_insert(CPU(cpu), address, BP_CPU,
> +    cpu_breakpoint_insert(env_cpu(env), address, BP_CPU,
>                            &env->cpu_breakpoint[idx]);
>  }
>
>  void lm32_breakpoint_remove(CPULM32State *env, int idx)
>  {
> -    LM32CPU *cpu = lm32_env_get_cpu(env);
> -
>      if (!env->cpu_breakpoint[idx]) {
>          return;
>      }
>
> -    cpu_breakpoint_remove_by_ref(CPU(cpu), env->cpu_breakpoint[idx]);
> +    cpu_breakpoint_remove_by_ref(env_cpu(env), env->cpu_breakpoint[idx]);
>      env->cpu_breakpoint[idx] = NULL;
>  }
>
>  void lm32_watchpoint_insert(CPULM32State *env, int idx, target_ulong address,
>                              lm32_wp_t wp_type)
>  {
> -    LM32CPU *cpu = lm32_env_get_cpu(env);
>      int flags = 0;
>
>      switch (wp_type) {
> @@ -98,26 +93,24 @@ void lm32_watchpoint_insert(CPULM32State *env, int idx, target_ulong address,
>      }
>
>      if (flags != 0) {
> -        cpu_watchpoint_insert(CPU(cpu), address, 1, flags,
> -                &env->cpu_watchpoint[idx]);
> +        cpu_watchpoint_insert(env_cpu(env), address, 1, flags,
> +                              &env->cpu_watchpoint[idx]);
>      }
>  }
>
>  void lm32_watchpoint_remove(CPULM32State *env, int idx)
>  {
> -    LM32CPU *cpu = lm32_env_get_cpu(env);
> -
>      if (!env->cpu_watchpoint[idx]) {
>          return;
>      }
>
> -    cpu_watchpoint_remove_by_ref(CPU(cpu), env->cpu_watchpoint[idx]);
> +    cpu_watchpoint_remove_by_ref(env_cpu(env), env->cpu_watchpoint[idx]);
>      env->cpu_watchpoint[idx] = NULL;
>  }
>
>  static bool check_watchpoints(CPULM32State *env)
>  {
> -    LM32CPU *cpu = lm32_env_get_cpu(env);
> +    LM32CPU *cpu = env_archcpu(env);
>      int i;
>
>      for (i = 0; i < cpu->num_watchpoints; i++) {
> diff --git a/target/lm32/op_helper.c b/target/lm32/op_helper.c
> index 234d55e056..ebff4c4518 100644
> --- a/target/lm32/op_helper.c
> +++ b/target/lm32/op_helper.c
> @@ -16,7 +16,7 @@
>  #if !defined(CONFIG_USER_ONLY)
>  void raise_exception(CPULM32State *env, int index)
>  {
> -    CPUState *cs = CPU(lm32_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>
>      cs->exception_index = index;
>      cpu_loop_exit(cs);
> @@ -29,7 +29,7 @@ void HELPER(raise_exception)(CPULM32State *env, uint32_t index)
>
>  void HELPER(hlt)(CPULM32State *env)
>  {
> -    CPUState *cs = CPU(lm32_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>
>      cs->halted = 1;
>      cs->exception_index = EXCP_HLT;
> @@ -39,7 +39,7 @@ void HELPER(hlt)(CPULM32State *env)
>  void HELPER(ill)(CPULM32State *env)
>  {
>  #ifndef CONFIG_USER_ONLY
> -    CPUState *cs = CPU(lm32_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      fprintf(stderr, "VM paused due to illegal instruction. "
>              "Connect a debugger or switch to the monitor console "
>              "to find out more.\n");
> diff --git a/target/lm32/translate.c b/target/lm32/translate.c
> index f0e0e7058e..b9f2f2c4a7 100644
> --- a/target/lm32/translate.c
> +++ b/target/lm32/translate.c
> @@ -1053,7 +1053,7 @@ static inline void decode(DisasContext *dc, uint32_t ir)
>  void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
>  {
>      CPULM32State *env = cs->env_ptr;
> -    LM32CPU *cpu = lm32_env_get_cpu(env);
> +    LM32CPU *cpu = env_archcpu(env);
>      struct DisasContext ctx, *dc = &ctx;
>      uint32_t pc_start;
>      uint32_t page_start;
> --
> 2.17.1
>
>

