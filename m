Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC76C04AB2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:09:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F9582177E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bV3yhBr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9582177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59021 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOnUO-0008U1-8n
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 14:09:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOnSa-0007R3-23
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:08:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOnSY-0006el-4m
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:07:59 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:42216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOnSX-0006a6-RA
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:07:58 -0400
Received: by mail-lf1-x142.google.com with SMTP id w23so2212167lfc.9
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 11:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=GwB1YnuWXuHrqD76fyvNVTLJOuNg/0RQ62wbzeabbY8=;
	b=bV3yhBr/CJVsD2Dw4/91j4wLNg/MBfQQsHCN2WYh7iC13Wd/0ETS2CSsMSjmS9jA4o
	GewG8IFV5sOxtQydpBnDCpWczFy6WK4VC06JiB3im25NyqYgMQWqttu1NPprquUYC9gb
	7NSOxfTdDFWu1zzNxaf873WK1hKHf1Qp5zJ25EqrkQN7/dqq1zwu8Yfp2s3kZIaeyUWr
	dK3QCpKS5BWXARIlTVaUJiIJxdyaWBE7KFyesiha6y3gA5yZhvdyY83Z7lqvoSiNjm53
	+QPoAE1d4kNwgzonQ9wnuDTdELvLj1iN0ZFrRBFSJSoGAjMWHzPYMREeaIYqN0xbgUNn
	/isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=GwB1YnuWXuHrqD76fyvNVTLJOuNg/0RQ62wbzeabbY8=;
	b=pkOISpIxB30a8ZX3mjD2lSgXVyf9auQtGo35FSydlc+5cgvxI/iUf77vpee3MZR8JJ
	lAO6UxhXJQ+G1SQaqN8NcDgxANAI4a7Bp0KMRFlYQ/TaUBXRCo4jHx65GmJPWYbl/e3w
	fLv+Iq4PTtAwI1jnZwfd34MSkULvDhcbbJCth+f5DVZkJSHI7ZCKCD13wlO/qaucenO2
	WuLMgaNmfqPPPjsmeDvv4Hii7UXD7FESQu5CzZMhClzepDHbfKpP01uRAyN1ugsYyiQV
	l5WCLXCNAyulLvNT0n7VB6BDjqkntcS1WCoZEMymYF62j2IPKzlCEe33bo7udGSU5DGX
	GAZg==
X-Gm-Message-State: APjAAAV8leyEyw070JdC23IxMTfCKzaBhcvfEnFj98EsGSvdXR5DcN1Q
	/K9Zpu0l/lRmzgJ7zEVdvX8zh8W9fTVHYO6oFRI=
X-Google-Smtp-Source: APXvYqy5Ei/pjngZVTGOARqXUXVv4ltX0O3WLlQZBPwnhkJNetVe383OxcXe6+vmfvoUzvEQMlb/lRvADBj/OPuxz/s=
X-Received: by 2002:a19:189:: with SMTP id 131mr3231473lfb.74.1557425265083;
	Thu, 09 May 2019 11:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-14-richard.henderson@linaro.org>
In-Reply-To: <20190508000641.19090-14-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 May 2019 11:05:38 -0700
Message-ID: <CAKmqyKNRDPR++LpnQat2-uzMemD13wjHT-H8qkJypF1GP=3ibQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [PATCH v3 13/39] target/hppa: Use env_cpu,
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

On Tue, May 7, 2019 at 5:21 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Combined uses of CPU(hppa_env_get_cpu()) were failures to use
> the more proper, ENV_GET_CPU macro, now replaced by env_cpu.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/hppa/cpu.h          |  5 -----
>  linux-user/hppa/cpu_loop.c |  2 +-
>  target/hppa/helper.c       |  3 +--
>  target/hppa/int_helper.c   |  4 ++--
>  target/hppa/mem_helper.c   | 10 ++++------
>  target/hppa/op_helper.c    |  8 +++-----
>  6 files changed, 11 insertions(+), 21 deletions(-)
>
> diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
> index 887e10398a..a5ddc53bf1 100644
> --- a/target/hppa/cpu.h
> +++ b/target/hppa/cpu.h
> @@ -222,11 +222,6 @@ struct HPPACPU {
>      QEMUTimer *alarm_timer;
>  };
>
> -static inline HPPACPU *hppa_env_get_cpu(CPUHPPAState *env)
> -{
> -    return container_of(env, HPPACPU, env);
> -}
> -
>  #define ENV_OFFSET      offsetof(HPPACPU, env)
>
>  typedef CPUHPPAState CPUArchState;
> diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
> index 880955fdef..9915456a1d 100644
> --- a/linux-user/hppa/cpu_loop.c
> +++ b/linux-user/hppa/cpu_loop.c
> @@ -105,7 +105,7 @@ static abi_ulong hppa_lws(CPUHPPAState *env)
>
>  void cpu_loop(CPUHPPAState *env)
>  {
> -    CPUState *cs = CPU(hppa_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      target_siginfo_t info;
>      abi_ulong ret;
>      int trapnr;
> diff --git a/target/hppa/helper.c b/target/hppa/helper.c
> index 11c61b3ca2..0dcd105b88 100644
> --- a/target/hppa/helper.c
> +++ b/target/hppa/helper.c
> @@ -71,8 +71,7 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ureg psw)
>      /* If PSW_P changes, it affects how we translate addresses.  */
>      if ((psw ^ old_psw) & PSW_P) {
>  #ifndef CONFIG_USER_ONLY
> -        CPUState *src = CPU(hppa_env_get_cpu(env));
> -        tlb_flush_by_mmuidx(src, 0xf);
> +        tlb_flush_by_mmuidx(env_cpu(env), 0xf);
>  #endif
>      }
>  }
> diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
> index 8d5edd3a20..89241c31e7 100644
> --- a/target/hppa/int_helper.c
> +++ b/target/hppa/int_helper.c
> @@ -77,7 +77,7 @@ void HELPER(write_eirr)(CPUHPPAState *env, target_ureg val)
>  {
>      env->cr[CR_EIRR] &= ~val;
>      qemu_mutex_lock_iothread();
> -    eval_interrupt(hppa_env_get_cpu(env));
> +    eval_interrupt(env_archcpu(env));
>      qemu_mutex_unlock_iothread();
>  }
>
> @@ -85,7 +85,7 @@ void HELPER(write_eiem)(CPUHPPAState *env, target_ureg val)
>  {
>      env->cr[CR_EIEM] = val;
>      qemu_mutex_lock_iothread();
> -    eval_interrupt(hppa_env_get_cpu(env));
> +    eval_interrupt(env_archcpu(env));
>      qemu_mutex_unlock_iothread();
>  }
>  #endif /* !CONFIG_USER_ONLY */
> diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
> index 77fb544838..e2f464c78c 100644
> --- a/target/hppa/mem_helper.c
> +++ b/target/hppa/mem_helper.c
> @@ -55,7 +55,7 @@ static hppa_tlb_entry *hppa_find_tlb(CPUHPPAState *env, vaddr addr)
>
>  static void hppa_flush_tlb_ent(CPUHPPAState *env, hppa_tlb_entry *ent)
>  {
> -    CPUState *cs = CPU(hppa_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      unsigned i, n = 1 << (2 * ent->page_size);
>      uint64_t addr = ent->va_b;
>
> @@ -323,7 +323,7 @@ static void ptlb_work(CPUState *cpu, run_on_cpu_data data)
>
>  void HELPER(ptlb)(CPUHPPAState *env, target_ulong addr)
>  {
> -    CPUState *src = CPU(hppa_env_get_cpu(env));
> +    CPUState *src = env_cpu(env);
>      CPUState *cpu;
>      trace_hppa_tlb_ptlb(env);
>      run_on_cpu_data data = RUN_ON_CPU_TARGET_PTR(addr);
> @@ -340,17 +340,15 @@ void HELPER(ptlb)(CPUHPPAState *env, target_ulong addr)
>     number of pages/entries (we choose all), and is local to the cpu.  */
>  void HELPER(ptlbe)(CPUHPPAState *env)
>  {
> -    CPUState *src = CPU(hppa_env_get_cpu(env));
>      trace_hppa_tlb_ptlbe(env);
>      memset(env->tlb, 0, sizeof(env->tlb));
> -    tlb_flush_by_mmuidx(src, 0xf);
> +    tlb_flush_by_mmuidx(env_cpu(env), 0xf);
>  }
>
>  void cpu_hppa_change_prot_id(CPUHPPAState *env)
>  {
>      if (env->psw & PSW_P) {
> -        CPUState *src = CPU(hppa_env_get_cpu(env));
> -        tlb_flush_by_mmuidx(src, 0xf);
> +        tlb_flush_by_mmuidx(env_cpu(env), 0xf);
>      }
>  }
>
> diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
> index 952e97a7d7..04d23c1b22 100644
> --- a/target/hppa/op_helper.c
> +++ b/target/hppa/op_helper.c
> @@ -29,8 +29,7 @@
>
>  void QEMU_NORETURN HELPER(excp)(CPUHPPAState *env, int excp)
>  {
> -    HPPACPU *cpu = hppa_env_get_cpu(env);
> -    CPUState *cs = CPU(cpu);
> +    CPUState *cs = env_cpu(env);
>
>      cs->exception_index = excp;
>      cpu_loop_exit(cs);
> @@ -38,8 +37,7 @@ void QEMU_NORETURN HELPER(excp)(CPUHPPAState *env, int excp)
>
>  void QEMU_NORETURN hppa_dynamic_excp(CPUHPPAState *env, int excp, uintptr_t ra)
>  {
> -    HPPACPU *cpu = hppa_env_get_cpu(env);
> -    CPUState *cs = CPU(cpu);
> +    CPUState *cs = env_cpu(env);
>
>      cs->exception_index = excp;
>      cpu_loop_exit_restore(cs, ra);
> @@ -630,7 +628,7 @@ target_ureg HELPER(read_interval_timer)(void)
>  #ifndef CONFIG_USER_ONLY
>  void HELPER(write_interval_timer)(CPUHPPAState *env, target_ureg val)
>  {
> -    HPPACPU *cpu = hppa_env_get_cpu(env);
> +    HPPACPU *cpu = env_archcpu(env);
>      uint64_t current = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>      uint64_t timeout;
>
> --
> 2.17.1
>
>

