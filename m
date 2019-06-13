Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F73DC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 19:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3E732054F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 19:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGMbgV2W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E732054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44438 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbVA9-0007Ho-AU
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 15:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43989)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hbV7o-0005Wv-CY
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 15:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hbV7i-0004t6-Ex
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 15:11:04 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39050)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hbV7i-0004Ys-1m
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 15:10:58 -0400
Received: by mail-ot1-x344.google.com with SMTP id r21so244628otq.6
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 12:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=dHoUlv8DCkW+CTsCAOpGTAeCd7DEmn0QLagHKgdfuRo=;
 b=fGMbgV2WLjos9cqrRmSOaqm9FRk9Kwxxb2yn5D5IYX7rOmNRXt7h0ImCnYz+qxN4Ts
 3d9zl51tBBQtBb+mtrOgJ4Xjz2sA/AH3/mV8KelZv3oDfkiI94mnllrMFm9T/T+Uf6iZ
 EWI0RdgyjHfpbyk7sgqj8agUEeUlAWsCUMGnzukyGlCWrh9nT4A/Z213oYPYriyLSTo6
 OqMYki9s4QCXvqLVpuSmYQLBc7qEtvu2gpLb0Hq2UOwOYKEcrmKHPPihW68fTPrTVdmi
 YnwRiTtriQMy3B8SEv97+iwczSVH69QOIJK8cfGe+s8tGGs+VEs8L9UtFPIpADzinONO
 oesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=dHoUlv8DCkW+CTsCAOpGTAeCd7DEmn0QLagHKgdfuRo=;
 b=eVFoHysoPUs70JLmPdaZ6edevrxpxdfsHEXDs509Z7JW98kwuTV4tAlrz2cCU/R8Gt
 LabCQmyrMbfDoyiPmLwYK7MYwZAn2x8QNVrMc9zRy+DoGGov2yGHBnco/cNfqjSG1wKw
 LaIuDY/zsmnsC+yn6lA1qD84XjZ61whNxKpXQpbeDasIWkOnbJMOq7jnGZ+1594qMQRl
 0IpAADkMGnGruZhD2s27MsXwjNw9Fi4Ec8zUy3BEz1VkDNSmSlOBl7tDe8+jX+mUFxAx
 mnhE46ycwL5Lrfizms8eA8OcMf7ejdbLHiWav2/sv5JsIuBGi5nxSQWFVKGffQ1z4/3L
 ezQw==
X-Gm-Message-State: APjAAAXbhQzBylnPKJqivLZ4DQ+VdieA5b7gzcGAS1N3TGduFXRlM0w5
 1kdtVgR0qEOyKH7u/HH4cK1WmWwp7LzLeW1HlC0=
X-Google-Smtp-Source: APXvYqzHQLdr5Lwf26oi8whPOqQYiVwwHdkOWIY9xdw/1fvdXZnX4LWq3zfRvqF+WE1WupJMSJBhZdvqtDJGgtmbrvc=
X-Received: by 2002:a9d:6ad7:: with SMTP id m23mr37666314otq.306.1560453037072; 
 Thu, 13 Jun 2019 12:10:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Thu, 13 Jun 2019 12:10:36
 -0700 (PDT)
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Thu, 13 Jun 2019 12:10:36
 -0700 (PDT)
In-Reply-To: <20190519201953.20161-4-richard.henderson@linaro.org>
References: <20190519201953.20161-1-richard.henderson@linaro.org>
 <20190519201953.20161-4-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 13 Jun 2019 21:10:36 +0200
Message-ID: <CAL1e-=jU2ZnUooP2hBUW01_x030cJ2Ehd5N+zn9mgzQhr73DrQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 03/13] linux-user: Introduce
 cpu_clone_regs_parent
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
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 19, 2019 10:27 PM, "Richard Henderson" <richard.henderson@linaro.org>
wrote:
>
> Add an empty inline function for each target, and invoke it
> from the proper places.
>

Can we outline the meaning/purpose of the new function here?

This commit message looks horrible.

Regards,
Aleksandar

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/target_cpu.h    | 4 ++++
>  linux-user/alpha/target_cpu.h      | 4 ++++
>  linux-user/arm/target_cpu.h        | 4 ++++
>  linux-user/cris/target_cpu.h       | 4 ++++
>  linux-user/hppa/target_cpu.h       | 4 ++++
>  linux-user/i386/target_cpu.h       | 4 ++++
>  linux-user/m68k/target_cpu.h       | 4 ++++
>  linux-user/microblaze/target_cpu.h | 4 ++++
>  linux-user/mips/target_cpu.h       | 4 ++++
>  linux-user/nios2/target_cpu.h      | 4 ++++
>  linux-user/openrisc/target_cpu.h   | 4 ++++
>  linux-user/ppc/target_cpu.h        | 4 ++++
>  linux-user/riscv/target_cpu.h      | 4 ++++
>  linux-user/s390x/target_cpu.h      | 4 ++++
>  linux-user/sh4/target_cpu.h        | 4 ++++
>  linux-user/sparc/target_cpu.h      | 4 ++++
>  linux-user/tilegx/target_cpu.h     | 4 ++++
>  linux-user/xtensa/target_cpu.h     | 4 ++++
>  linux-user/syscall.c               | 2 ++
>  19 files changed, 74 insertions(+)
>
> diff --git a/linux-user/aarch64/target_cpu.h
b/linux-user/aarch64/target_cpu.h
> index abde35b104..0182bfca07 100644
> --- a/linux-user/aarch64/target_cpu.h
> +++ b/linux-user/aarch64/target_cpu.h
> @@ -27,6 +27,10 @@ static inline void cpu_clone_regs_child(CPUARMState
*env, target_ulong newsp)
>      env->xregs[0] = 0;
>  }
>
> +static inline void cpu_clone_regs_parent(CPUARMState *env)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUARMState *env, target_ulong newtls)
>  {
>      /* Note that AArch64 Linux keeps the TLS pointer in TPIDR; this is
> diff --git a/linux-user/alpha/target_cpu.h b/linux-user/alpha/target_cpu.h
> index dc02f2234c..140a459f73 100644
> --- a/linux-user/alpha/target_cpu.h
> +++ b/linux-user/alpha/target_cpu.h
> @@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUAlphaState
*env, target_ulong newsp)
>      env->ir[IR_A3] = 0;
>  }
>
> +static inline void cpu_clone_regs_parent(CPUAlphaState *env)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUAlphaState *env, target_ulong newtls)
>  {
>      env->unique = newtls;
> diff --git a/linux-user/arm/target_cpu.h b/linux-user/arm/target_cpu.h
> index d35c997287..3e66d5b106 100644
> --- a/linux-user/arm/target_cpu.h
> +++ b/linux-user/arm/target_cpu.h
> @@ -31,6 +31,10 @@ static inline void cpu_clone_regs_child(CPUARMState
*env, target_ulong newsp)
>      env->regs[0] = 0;
>  }
>
> +static inline void cpu_clone_regs_parent(CPUARMState *env)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUARMState *env, target_ulong newtls)
>  {
>      if (access_secure_reg(env)) {
> diff --git a/linux-user/cris/target_cpu.h b/linux-user/cris/target_cpu.h
> index 9c847caaef..4da074b4fd 100644
> --- a/linux-user/cris/target_cpu.h
> +++ b/linux-user/cris/target_cpu.h
> @@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUCRISState
*env, target_ulong newsp)
>      env->regs[10] = 0;
>  }
>
> +static inline void cpu_clone_regs_parent(CPUCRISState *env)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUCRISState *env, target_ulong newtls)
>  {
>      env->pregs[PR_PID] = (env->pregs[PR_PID] & 0xff) | newtls;
> diff --git a/linux-user/hppa/target_cpu.h b/linux-user/hppa/target_cpu.h
> index b98e5a1cfe..6b323297af 100644
> --- a/linux-user/hppa/target_cpu.h
> +++ b/linux-user/hppa/target_cpu.h
> @@ -31,6 +31,10 @@ static inline void cpu_clone_regs_child(CPUHPPAState
*env, target_ulong newsp)
>      env->iaoq_b = env->gr[31] + 4;
>  }
>
> +static inline void cpu_clone_regs_parent(CPUHPPAState *env)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUHPPAState *env, target_ulong newtls)
>  {
>      env->cr[27] = newtls;
> diff --git a/linux-user/i386/target_cpu.h b/linux-user/i386/target_cpu.h
> index e1c9e03490..6dbb856c52 100644
> --- a/linux-user/i386/target_cpu.h
> +++ b/linux-user/i386/target_cpu.h
> @@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUX86State
*env, target_ulong newsp)
>      env->regs[R_EAX] = 0;
>  }
>
> +static inline void cpu_clone_regs_parent(CPUX86State *env)
> +{
> +}
> +
>  #if defined(TARGET_ABI32)
>  abi_long do_set_thread_area(CPUX86State *env, abi_ulong ptr);
>
> diff --git a/linux-user/m68k/target_cpu.h b/linux-user/m68k/target_cpu.h
> index 7637a98cab..f1a53cdee5 100644
> --- a/linux-user/m68k/target_cpu.h
> +++ b/linux-user/m68k/target_cpu.h
> @@ -29,6 +29,10 @@ static inline void cpu_clone_regs_child(CPUM68KState
*env, target_ulong newsp)
>      env->dregs[0] = 0;
>  }
>
> +static inline void cpu_clone_regs_parent(CPUM68KState *env)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUM68KState *env, target_ulong newtls)
>  {
>      CPUState *cs = CPU(m68k_env_get_cpu(env));
> diff --git a/linux-user/microblaze/target_cpu.h
b/linux-user/microblaze/target_cpu.h
> index 526b80d54d..5e285e9211 100644
> --- a/linux-user/microblaze/target_cpu.h
> +++ b/linux-user/microblaze/target_cpu.h
> @@ -27,6 +27,10 @@ static inline void cpu_clone_regs_child(CPUMBState
*env, target_ulong newsp)
>      env->regs[3] = 0;
>  }
>
> +static inline void cpu_clone_regs_parent(CPUMBState *env)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUMBState *env, target_ulong newtls)
>  {
>      env->regs[21] = newtls;
> diff --git a/linux-user/mips/target_cpu.h b/linux-user/mips/target_cpu.h
> index c42660b047..d0e0b1bac0 100644
> --- a/linux-user/mips/target_cpu.h
> +++ b/linux-user/mips/target_cpu.h
> @@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUMIPSState
*env, target_ulong newsp)
>      env->active_tc.gpr[2] = 0;
>  }
>
> +static inline void cpu_clone_regs_parent(CPUMIPSState *env)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUMIPSState *env, target_ulong newtls)
>  {
>      env->active_tc.CP0_UserLocal = newtls;
> diff --git a/linux-user/nios2/target_cpu.h b/linux-user/nios2/target_cpu.h
> index bec2ea79c4..01725ba004 100644
> --- a/linux-user/nios2/target_cpu.h
> +++ b/linux-user/nios2/target_cpu.h
> @@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUNios2State
*env, target_ulong newsp)
>      env->regs[R_RET0] = 0;
>  }
>
> +static inline void cpu_clone_regs_parent(CPUNios2State *env)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUNios2State *env, target_ulong newtls)
>  {
>      /*
> diff --git a/linux-user/openrisc/target_cpu.h
b/linux-user/openrisc/target_cpu.h
> index d163ba2e26..6586951c5b 100644
> --- a/linux-user/openrisc/target_cpu.h
> +++ b/linux-user/openrisc/target_cpu.h
> @@ -29,6 +29,10 @@ static inline void
cpu_clone_regs_child(CPUOpenRISCState *env,
>      cpu_set_gpr(env, 11, 0);
>  }
>
> +static inline void cpu_clone_regs_parent(CPUOpenRISCState *env)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUOpenRISCState *env, target_ulong
newtls)
>  {
>      cpu_set_gpr(env, 10, newtls);
> diff --git a/linux-user/ppc/target_cpu.h b/linux-user/ppc/target_cpu.h
> index 34decf3876..00c9f5eb86 100644
> --- a/linux-user/ppc/target_cpu.h
> +++ b/linux-user/ppc/target_cpu.h
> @@ -27,6 +27,10 @@ static inline void cpu_clone_regs_child(CPUPPCState
*env, target_ulong newsp)
>      env->gpr[3] = 0;
>  }
>
> +static inline void cpu_clone_regs_parent(CPUPPCState *env)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUPPCState *env, target_ulong newtls)
>  {
>  #if defined(TARGET_PPC64)
> diff --git a/linux-user/riscv/target_cpu.h b/linux-user/riscv/target_cpu.h
> index d92153851c..4ef1b23b4f 100644
> --- a/linux-user/riscv/target_cpu.h
> +++ b/linux-user/riscv/target_cpu.h
> @@ -10,6 +10,10 @@ static inline void cpu_clone_regs_child(CPURISCVState
*env, target_ulong newsp)
>      env->gpr[xA0] = 0;
>  }
>
> +static inline void cpu_clone_regs_parent(CPURISCVState *env)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPURISCVState *env, target_ulong newtls)
>  {
>      env->gpr[xTP] = newtls;
> diff --git a/linux-user/s390x/target_cpu.h b/linux-user/s390x/target_cpu.h
> index e0baa98e75..18e290ece8 100644
> --- a/linux-user/s390x/target_cpu.h
> +++ b/linux-user/s390x/target_cpu.h
> @@ -27,6 +27,10 @@ static inline void cpu_clone_regs_child(CPUS390XState
*env, target_ulong newsp)
>      env->regs[2] = 0;
>  }
>
> +static inline void cpu_clone_regs_parent(CPUS390XState *env)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUS390XState *env, target_ulong newtls)
>  {
>      env->aregs[0] = newtls >> 32;
> diff --git a/linux-user/sh4/target_cpu.h b/linux-user/sh4/target_cpu.h
> index 854955aa5a..b0e4ab23a7 100644
> --- a/linux-user/sh4/target_cpu.h
> +++ b/linux-user/sh4/target_cpu.h
> @@ -27,6 +27,10 @@ static inline void cpu_clone_regs_child(CPUSH4State
*env, target_ulong newsp)
>      env->gregs[0] = 0;
>  }
>
> +static inline void cpu_clone_regs_parent(CPUSH4State *env)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUSH4State *env, target_ulong newtls)
>  {
>    env->gbr = newtls;
> diff --git a/linux-user/sparc/target_cpu.h b/linux-user/sparc/target_cpu.h
> index 8511fc3f6f..52c9d8c7db 100644
> --- a/linux-user/sparc/target_cpu.h
> +++ b/linux-user/sparc/target_cpu.h
> @@ -36,6 +36,10 @@ static inline void cpu_clone_regs_child(CPUSPARCState
*env, target_ulong newsp)
>  #endif
>  }
>
> +static inline void cpu_clone_regs_parent(CPUSPARCState *env)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUSPARCState *env, target_ulong newtls)
>  {
>      env->gregs[7] = newtls;
> diff --git a/linux-user/tilegx/target_cpu.h
b/linux-user/tilegx/target_cpu.h
> index dfca8d9598..9577462821 100644
> --- a/linux-user/tilegx/target_cpu.h
> +++ b/linux-user/tilegx/target_cpu.h
> @@ -27,6 +27,10 @@ static inline void cpu_clone_regs_child(CPUTLGState
*env, target_ulong newsp)
>      env->regs[TILEGX_R_RE] = 0;
>  }
>
> +static inline void cpu_clone_regs_parent(CPUTLGState *env)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUTLGState *env, target_ulong newtls)
>  {
>      env->regs[TILEGX_R_TP] = newtls;
> diff --git a/linux-user/xtensa/target_cpu.h
b/linux-user/xtensa/target_cpu.h
> index f436b160c4..42e66211cf 100644
> --- a/linux-user/xtensa/target_cpu.h
> +++ b/linux-user/xtensa/target_cpu.h
> @@ -15,6 +15,10 @@ static inline void cpu_clone_regs_child(CPUXtensaState
*env,
>      env->regs[2] = 0;
>  }
>
> +static inline void cpu_clone_regs_parent(CPUXtensaState *env)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUXtensaState *env, target_ulong newtls)
>  {
>      env->uregs[THREADPTR] = newtls;
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index b9127a9601..f960556bf8 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -5535,6 +5535,7 @@ static int do_fork(CPUArchState *env, unsigned int
flags, abi_ulong newsp,
>          new_env = cpu_copy(env);
>          /* Init regs that differ from the parent.  */
>          cpu_clone_regs_child(new_env, newsp);
> +        cpu_clone_regs_parent(env);
>          new_cpu = ENV_GET_CPU(new_env);
>          new_cpu->opaque = ts;
>          ts->bprm = parent_ts->bprm;
> @@ -5630,6 +5631,7 @@ static int do_fork(CPUArchState *env, unsigned int
flags, abi_ulong newsp,
>              if (flags & CLONE_CHILD_CLEARTID)
>                  ts->child_tidptr = child_tidptr;
>          } else {
> +            cpu_clone_regs_parent(env);
>              fork_end(0);
>          }
>      }
> --
> 2.17.1
>
>
