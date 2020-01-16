Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E46CC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:27:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5848D206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J6SjtpTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5848D206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is7zl-0005kc-FA
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 11:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1is7yW-0004lb-D9
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:26:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1is7yU-00053o-Ed
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:26:28 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35131)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1is7yU-000535-6N
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:26:26 -0500
Received: by mail-wr1-x441.google.com with SMTP id g17so19773146wro.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 08:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=OE5TKxFZj9d3qXk8MQJGD+kYSY6qwMZxS4fEz75Jfm4=;
 b=J6SjtpTULLJFS4OKFJekOznCrGzcRepKVExPLfVGm671/5YJ5p+fk/qIwZEXGng3lY
 MzYey+dH3+tWsFq9L0x+JzWl+DGT6MbyIgfXy6AdtmTK/0bVs/KKFKCcQGKDVhDNnAsW
 ZNP5Js63LKtmBX4Vg59tygQ/cTprRZy7NQtMLhXq/QxiVSsJ2M7YsLgd+KsfzO1dgAP7
 9j5TBQLeNW6geW8tTy/XmJ4Tnfyh/l+xHOG59yauqbN+v3t63BlIwfA6u9bp4cJtny3H
 7kGHv6FwK2MYncPJIwe5AfDwNrp9Xd0dP474VJK3wuCGbjPXAL/QibY/J7/WCTWpgA+F
 iRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=OE5TKxFZj9d3qXk8MQJGD+kYSY6qwMZxS4fEz75Jfm4=;
 b=jT00iIE6xwFjel7O7+sTUv5KHHuIki6+hthW4vUv9IQYwvVyGZX/EEtOVBrhS/fVP7
 SIEWYcJv9HMAUtQfIGlbKvA/H8qBpDbl/fGWkOTo3OMdhZkXjtvsvWJTnfcKpnnM1UL8
 +CXMusQPgX/yhjUrEaA/0cP6SemaNLmOQmx852WLuw6r2D5AyJQZTlBFQ9gJHieLISgq
 I4p8SzReqUxHG/UMvUEvkBZh6iH0S0yQhJYX8ng2ru0db0nFbV6lcd0FIcj2J5hOrcT6
 lHAUKso/zOrlzmSKISmW9WJVkjzK+5kmZaACf3laDoWdMbQPbVrgmqiNOkXjekaBT4ID
 CffA==
X-Gm-Message-State: APjAAAXQ+EiChYdS3IxcCoEyAFljA6uaHcCxstmOfz8is/zKETlIr0mp
 XsGOBR+8fQXIrunAJAXX437kRw==
X-Google-Smtp-Source: APXvYqz/C4Q0ffXPTwmYNKcHT7C9Da38a0jyEFE1Zt1LnPefbC03dw+W9x8KV5khBh+CGNKG9AZ9WA==
X-Received: by 2002:adf:db41:: with SMTP id f1mr4257473wrj.392.1579191984213; 
 Thu, 16 Jan 2020 08:26:24 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u18sm29497696wrt.26.2020.01.16.08.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 08:26:23 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1E2961FF87;
 Thu, 16 Jan 2020 16:26:22 +0000 (GMT)
References: <20200114210921.11216-1-richard.henderson@linaro.org>
 <20200114210921.11216-4-richard.henderson@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 3/3] linux-user/i386: Emulate x86_64 vsyscalls
In-reply-to: <20200114210921.11216-4-richard.henderson@linaro.org>
Date: Thu, 16 Jan 2020 16:26:22 +0000
Message-ID: <87ftgfl64x.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, riku.voipio@iki.fi,
 laurent@vivier.eu, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Notice the magic page during translate, much like we already
> do for the arm32 commpage.  At runtime, raise an exception to
> return cpu_loop for emulation.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/i386/cpu.h          |   1 +
>  linux-user/i386/cpu_loop.c | 104 +++++++++++++++++++++++++++++++++++++
>  target/i386/translate.c    |  16 +++++-
>  3 files changed, 120 insertions(+), 1 deletion(-)
>
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 164d038d1f..3fb2d2a986 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1000,6 +1000,7 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
>=20=20
>  #define EXCP_VMEXIT     0x100 /* only for system emulation */
>  #define EXCP_SYSCALL    0x101 /* only for user emulation */
> +#define EXCP_VSYSCALL   0x102 /* only for user emulation */
>=20=20
>  /* i386-specific interrupt pending bits.  */
>  #define CPU_INTERRUPT_POLL      CPU_INTERRUPT_TGT_EXT_1
> diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
> index e217cca5ee..8b7c9f7337 100644
> --- a/linux-user/i386/cpu_loop.c
> +++ b/linux-user/i386/cpu_loop.c
> @@ -92,6 +92,105 @@ static void gen_signal(CPUX86State *env, int sig, int=
 code, abi_ptr addr)
>      queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
>  }
>=20=20
> +#ifdef TARGET_X86_64
> +static bool write_ok_or_segv(CPUX86State *env, abi_ptr addr, size_t len)
> +{
> +    /*
> +     * For all the vsyscalls, NULL means "don't write anything" not
> +     * "write it at address 0".
> +     */
> +    if (addr =3D=3D 0 || access_ok(VERIFY_WRITE, addr, len)) {
> +        return true;
> +    }
> +
> +    gen_signal(env, TARGET_SIGSEGV, TARGET_SEGV_MAPERR, addr);
> +    return false;
> +}
> +
> +/*
> + * Since v3.1, the kernel traps and emulates the vsyscall page.
> + * Entry points other than the official generate SIGSEGV.
> + */
> +static void emulate_vsyscall(CPUX86State *env)
> +{
> +    int syscall;
> +    abi_ulong ret;
> +    uint64_t caller;
> +
> +    /*
> +     * Validate the entry point.  We have already validated the page
> +     * during translation, now verify the offset.
> +     */
> +    switch (env->eip & ~TARGET_PAGE_MASK) {
> +    case 0x000:
> +        syscall =3D TARGET_NR_gettimeofday;
> +        break;
> +    case 0x400:
> +        syscall =3D TARGET_NR_time;
> +        break;
> +    case 0x800:
> +        syscall =3D TARGET_NR_getcpu;
> +        break;
> +    default:
> +    sigsegv:
> +        /* Like force_sig(SIGSEGV).  */
> +        gen_signal(env, TARGET_SIGSEGV, TARGET_SI_KERNEL, 0);
> +        return;
> +    }
> +
> +    /*
> +     * Validate the return address.
> +     * Note that the kernel treats this the same as an invalid entry poi=
nt.
> +     */
> +    if (get_user_u64(caller, env->regs[R_ESP])) {
> +        goto sigsegv;
> +    }
> +
> +    /*
> +     * Validate the the pointer arguments.
> +     */
> +    switch (syscall) {
> +    case TARGET_NR_gettimeofday:
> +        if (!write_ok_or_segv(env, env->regs[R_EDI],
> +                              sizeof(struct target_timeval)) ||
> +            !write_ok_or_segv(env, env->regs[R_ESI],
> +                              sizeof(struct target_timezone))) {
> +            return;
> +        }
> +        break;
> +    case TARGET_NR_time:
> +        if (!write_ok_or_segv(env, env->regs[R_EDI], sizeof(abi_long))) {
> +            return;
> +        }
> +        break;
> +    case TARGET_NR_getcpu:
> +        if (!write_ok_or_segv(env, env->regs[R_EDI], sizeof(uint32_t)) ||
> +            !write_ok_or_segv(env, env->regs[R_ESI], sizeof(uint32_t))) {
> +            return;
> +        }
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    /*
> +     * Perform the syscall.  None of the vsyscalls should need restartin=
g,
> +     * and all faults should have been caught above.
> +     */
> +    ret =3D do_syscall(env, syscall, env->regs[R_EDI], env->regs[R_ESI],
> +                     env->regs[R_EDX], env->regs[10], env->regs[8],
> +                     env->regs[9], 0, 0);

How come the register ABI to the syscall is different to the others. I
can see why syscall doesn't come from EAX but the others are a different
set to normal syscalls which might be why:

> +    g_assert(ret !=3D -TARGET_ERESTARTSYS);
> +    g_assert(ret !=3D -TARGET_QEMU_ESIGRETURN);
> +    g_assert(ret !=3D -TARGET_EFAULT);

I'm seeing a EFAULT on the gettimeofday failure:

   #0  do_syscall (cpu_env=3Dcpu_env@entry=3D0x5555577d2b10, num=3Dnum@entr=
y=3D96, arg1=3D0, arg2=3D0, arg3=3D4211016, arg4=3D8, arg5=3D274888677184, =
arg6=3D274886295415, arg7=3D0, arg8=3D0) at /home/alex/lsrc/qemu.git/linux-=
user/syscall.c:12076=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20
   #1  0x0000555555609b6e in emulate_vsyscall (env=3D0x5555577d2b10) at /ho=
me/alex/lsrc/qemu.git/linux-user/x86_64/../i386/cpu_loop.c:180
   #2  cpu_loop (env=3D0x5555577d2b10) at /home/alex/lsrc/qemu.git/linux-us=
er/x86_64/../i386/cpu_loop.c:246=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
   #3  0x000055555559640e in main (argc=3D<optimized out>, argv=3D<optimized
   #out>, envp=3D<optimized out>) at
   #/home/alex/lsrc/qemu.git/linux-user/main.c:865

arg1/arg2 don't seem right here.

> +    env->regs[R_EAX] =3D ret;
> +
> +    /* Emulate a ret instruction to leave the vsyscall page.  */
> +    env->eip =3D caller;
> +    env->regs[R_ESP] +=3D 8;
> +}
> +#endif
> +
>  void cpu_loop(CPUX86State *env)
>  {
>      CPUState *cs =3D env_cpu(env);
> @@ -141,6 +240,11 @@ void cpu_loop(CPUX86State *env)
>                  env->regs[R_EAX] =3D ret;
>              }
>              break;
> +#endif
> +#ifdef TARGET_X86_64
> +        case EXCP_VSYSCALL:
> +            emulate_vsyscall(env);
> +            break;
>  #endif
>          case EXCP0B_NOSEG:
>          case EXCP0C_STACK:
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 7c99ef1385..391b4ef149 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -8555,7 +8555,21 @@ static bool i386_tr_breakpoint_check(DisasContextB=
ase *dcbase, CPUState *cpu,
>  static void i386_tr_translate_insn(DisasContextBase *dcbase, CPUState *c=
pu)
>  {
>      DisasContext *dc =3D container_of(dcbase, DisasContext, base);
> -    target_ulong pc_next =3D disas_insn(dc, cpu);
> +    target_ulong pc_next;
> +
> +#if defined(TARGET_X86_64) && \
> +    defined(CONFIG_USER_ONLY) && \
> +    defined(CONFIG_LINUX)
> +    /*
> +     * Detect entry into the vsyscall page and invoke the syscall.
> +     */
> +    if ((dc->base.pc_next & TARGET_PAGE_MASK) =3D=3D 0xffffffffff600000u=
ll) {
> +        gen_exception(dc, EXCP_VSYSCALL, dc->base.pc_next);
> +        return;
> +    }
> +#endif
> +
> +    pc_next =3D disas_insn(dc, cpu);
>=20=20
>      if (dc->tf || (dc->base.tb->flags & HF_INHIBIT_IRQ_MASK)) {
>          /* if single step mode, we generate only one instruction and


--=20
Alex Benn=C3=A9e

