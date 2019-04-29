Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED5AC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:41:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1697420656
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UhFoGJda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1697420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58593 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL7TD-0007zd-DQ
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 10:41:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7SF-0007VT-SH
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL7S6-0006CC-PM
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:40:25 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL7S6-0006BG-3p
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:40:18 -0400
Received: by mail-ot1-x343.google.com with SMTP id n15so2750237ota.1
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=0WLMKGLLyBLefqLuQAGXA55Mu5hVrWR6naUBEQET3NI=;
	b=UhFoGJdaLNw3BSgXddj3sMaZ712XOCLWwPdn4FjYHY/I2J0qjFaDFb4HYZ3Xw++ouF
	VN8DPk/BIXTYpBSFp8C9cSxKTqEp3F1+9xkQL7LB8aBnrpTwVRktWhJTtjWziAAVQC4g
	/Dgmo4ATPM8dPXMhzPkMvH0BcM0tRprfdv0uivY0dywLldUWk5pjZxmiHa5SL2aEMJtq
	3BA/BmQLvquAlquBBEzBXc6Gjx4k0OrL/XiWGk5TIErnDU2pdOgqqbix4BeDeHFu/JoK
	Kx6UwsDN+U/Y52koyywbdc2grB37oInGJ3B4EJCk7PsmwsjFHith2JcRSL1CPYzSqIbW
	dYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=0WLMKGLLyBLefqLuQAGXA55Mu5hVrWR6naUBEQET3NI=;
	b=irv3PcNxUymKXKUNzaKPjX7LbTlVmqoYrkwPdr3dQ6RaZ2MKFQ+zm1b4pKZ3dmls0c
	lnmjffSnsy2fbP5b80h+zuEWjYspQsQ2SwIG3WBMkGW7SN3u4Cx2HVQYpTMRvSdNqUh8
	09O3jfzThJk5nAoGIcps9npy9PIMht/c1ldC7FxzvnhVxVMapo6xxqqmzhxzPter+WlK
	hJw0uIQoB5K3kg6ab+6/TIi+ElJ25H2366nOGcgh9TRFd14CpWVVTkylrjOL6XEoxMOp
	f+pHt8j4UB4UXxk8PX293RvDdZOwcAfGbcsduJ2mFI8rnog7rGY4gdKGpttcjoCSlgG2
	6EYg==
X-Gm-Message-State: APjAAAVBdszJCJvfg5AYn0qORlEaOSfvYta3nUvv9RqTJvwmR0fGkFa1
	8NyOxmN5PZEwAtSeXG6AX4EJAQvVNCk34VA282g9TA==
X-Google-Smtp-Source: APXvYqz7OMcTeCg6pgaM5aJkrmjID8vP96ruyel5/24kR7FV25nu/W+ihNucq3UuGeWHGxNx0Zg2ZhuHO/ptLQs7SVA=
X-Received: by 2002:a9d:360b:: with SMTP id w11mr12296884otb.238.1556548816594;
	Mon, 29 Apr 2019 07:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-31-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-31-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 15:40:05 +0100
Message-ID:
 <CAFEAcA_0wTL0K8nJw+LQK4-y6_qJ+Lj7nEL=xuU6vXQPW4YEqg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 30/36] cpu: Introduce
 cpu_set_cpustate_pointers
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
Message-ID: <20190429144005.3MRyumqXxE_kcGkp6zCFJYlMfx-0Clx5lUxx8_fIL9s@z>

On Thu, 28 Mar 2019 at 23:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Consolidate some boilerplate from foo_cpu_initfn.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -371,6 +371,17 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
>
>  int cpu_exec(CPUState *cpu);
>
> +/**
> + * cpu_set_cpustate_pointers(cpu)
> + * @cpu: The cpu object
> + *
> + * Set the generic pointers in CPUState into the outer object.
> + */
> +static inline void cpu_set_cpustate_pointers(ArchCPU *cpu)
> +{
> +    cpu->parent_obj.env_ptr = &cpu->env;
> +}
> +
>  /**
>   * env_archcpu(env)
>   * @env: The architecture environment
> @@ -392,5 +403,4 @@ static inline CPUState *env_cpu(CPUArchState *env)
>  {
>      return &env_archcpu(env)->parent_obj;
>  }
> -

Stray blank line deletion.

>  #endif /* CPU_ALL_H */

> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 698dd9cb82..790670ebeb 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -282,17 +282,18 @@ static void s390_cpu_initfn(Object *obj)
>  {
>      CPUState *cs = CPU(obj);
>      S390CPU *cpu = S390_CPU(obj);
> -    CPUS390XState *env = &cpu->env;
>
> -    cs->env_ptr = env;
> +    cpu_set_cpustate_pointers(cpu);
>      cs->halted = 1;
>      cs->exception_index = EXCP_HLT;
>      object_property_add(obj, "crash-information", "GuestPanicInformation",
>                          s390_cpu_get_crash_info_qom, NULL, NULL, NULL, NULL);
>      s390_cpu_model_register_props(obj);
>  #if !defined(CONFIG_USER_ONLY)
> -    env->tod_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);
> -    env->cpu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_cpu_timer, cpu);
> +    cpu->env.tod_timer =
> +        timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);
> +    cpu->env.cpu_timer =
> +        timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_cpu_timer, cpu);
>      s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
>  #endif

I would have left the local variable so that we didn't
need to change these lines, but whatever.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

