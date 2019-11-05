Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E9FC49EAB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:58:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D090220869
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D090220869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRvc1-0004ox-2y
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 04:58:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iRvWC-0006sG-UR
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:52:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iRvWA-0002cs-S1
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:52:56 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:46683)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iRvWA-0002Y9-Gf
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:52:54 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MIxJq-1iD1023ceQ-00KSWA; Tue, 05 Nov 2019 10:52:53 +0100
Subject: Re: [PATCH v2 10/12] linux-user: Introduce cpu_clone_regs_parent
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191025113921.9412-1-richard.henderson@linaro.org>
 <20191025113921.9412-11-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <58a009e6-d0c6-7a99-72fa-86b087efb4ad@vivier.eu>
Date: Tue, 5 Nov 2019 10:52:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025113921.9412-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:T7Dj6O9js0NUGy/+JWLAQ1A2kPIUS6JVeubFEllAtC4xdFAeD8t
 A+Dzxutz9j+SdfD+JPd8GsVcYr7fdGHgUO2zHm54hsUUAnVDV+E0ibLh3QLIzlQiNon4KyG
 sY6ldD+2h+1G/R5ecYJfKwxt/xtpsulxi0VK3h0EQhE+yTU/W7oCYu4cHu1MxXKLkbeFv+Y
 fRmd6ewUbsepZYBxX9VVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nVLqCoKy6K0=:v3/4fWJaDcBD34fKgbFXeC
 X0NdeDHu4+8PPY9uK3ZHyP5LGULo/VwEz4AW6HbPECSxejg2sDGnqP1zW5/4pn5S5dXceQAtA
 BD3JRRLBYDbz913C9qqc7GP9/f6ydEWjMii9h74vkH0PvK5AB69sl4agj/LTSl0TITQ6iXEqR
 KRkVjv7k6kJ5bzCZ8clflvA2B8Ta4QrAA5HQZzMhbUb6nTFNBwS+8vNT9HQhwWqqRd/r73dUy
 bXOro95HWGlQPPQr4uHoqRfrs97jH8OShz020MXRSxl/3KVfjsQEq5j5ZVFpsC53k3U7qgmAP
 3D3zNPfb9FYpOgiDxLzbwgAl7Jv5Fb9XziDjuB3cv0xo/DYKaULOvI81lUSQncjyYjKE1EMQU
 TFcOsIdhN+xTKB4tkEjz9tzFpgZBR8fB12Q1R75mRtSDmz9pxJqWnH3t9mrkYJEKQE62Qw+C4
 e/lUcTlx72Z1yvGtbb2TX8xecn1St4ZTgudWgB1bWXt2pC2ysdCtdj1Er7XlMNjZg9ruWorNT
 Af3iu+H9slvPj4iPPdWSqOiXGCa1s/FvPRD4qV0fKJoyIVALuu2vzwVJ4o4bvPymed8KfaU7O
 Rx8ntHE22OfA+vaqHi/v4ctvvrJGTRFVV5bvFoS+0IfalT8DxxUtVahG4g4fDJQBQnT5Pzkpg
 tcSp9QFtrrTXIGmxJrt4HDqjMwkzoRbQ8dET7WrgYMFgYJvgU4SFcTBJrLbLB6dcZXReS7KXf
 84usITD6wP+6nUagBRMloX3/w6CiP/q8i4ywOc5AyBU53WbJi3h/yerNDc4HQih2/eZjk/mSB
 5lJEjWyIt2lDGoib9DeTLV9R4tXkztEpLuDUPc+qObCv9DFmIaN+vE1rn3MClr2cXuZfItPBJ
 LmS190ulDkp00mdCF1hubwLBZNdqQMppzOQOU9bmo=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.131
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 25/10/2019 à 13:39, Richard Henderson a écrit :
> We will need a target-specific hook for adjusting registers
> in the parent during clone.  Add an empty inline function for
> each target, and invoke it from the proper places.
> 
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
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
> diff --git a/linux-user/aarch64/target_cpu.h b/linux-user/aarch64/target_cpu.h
> index cd012e0dc1..6cc02e7dcd 100644
> --- a/linux-user/aarch64/target_cpu.h
> +++ b/linux-user/aarch64/target_cpu.h
> @@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUARMState *env, target_ulong newsp,
>      env->xregs[0] = 0;
>  }
>  
> +static inline void cpu_clone_regs_parent(CPUARMState *env, unsigned flags)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUARMState *env, target_ulong newtls)
>  {
>      /* Note that AArch64 Linux keeps the TLS pointer in TPIDR; this is
> diff --git a/linux-user/alpha/target_cpu.h b/linux-user/alpha/target_cpu.h
> index 37ba00cf41..dd25e18f47 100644
> --- a/linux-user/alpha/target_cpu.h
> +++ b/linux-user/alpha/target_cpu.h
> @@ -29,6 +29,10 @@ static inline void cpu_clone_regs_child(CPUAlphaState *env, target_ulong newsp,
>      env->ir[IR_A3] = 0;
>  }
>  
> +static inline void cpu_clone_regs_parent(CPUAlphaState *env, unsigned flags)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUAlphaState *env, target_ulong newtls)
>  {
>      env->unique = newtls;
> diff --git a/linux-user/arm/target_cpu.h b/linux-user/arm/target_cpu.h
> index 6e2ba8ad4b..2747211b24 100644
> --- a/linux-user/arm/target_cpu.h
> +++ b/linux-user/arm/target_cpu.h
> @@ -50,6 +50,10 @@ static inline void cpu_clone_regs_child(CPUARMState *env, target_ulong newsp,
>      env->regs[0] = 0;
>  }
>  
> +static inline void cpu_clone_regs_parent(CPUARMState *env, unsigned flags)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUARMState *env, target_ulong newtls)
>  {
>      if (access_secure_reg(env)) {
> diff --git a/linux-user/cris/target_cpu.h b/linux-user/cris/target_cpu.h
> index eacc4d8d13..74ead55c81 100644
> --- a/linux-user/cris/target_cpu.h
> +++ b/linux-user/cris/target_cpu.h
> @@ -29,6 +29,10 @@ static inline void cpu_clone_regs_child(CPUCRISState *env, target_ulong newsp,
>      env->regs[10] = 0;
>  }
>  
> +static inline void cpu_clone_regs_parent(CPUCRISState *env, unsigned flags)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUCRISState *env, target_ulong newtls)
>  {
>      env->pregs[PR_PID] = (env->pregs[PR_PID] & 0xff) | newtls;
> diff --git a/linux-user/hppa/target_cpu.h b/linux-user/hppa/target_cpu.h
> index f250770790..71654b3cd4 100644
> --- a/linux-user/hppa/target_cpu.h
> +++ b/linux-user/hppa/target_cpu.h
> @@ -32,6 +32,10 @@ static inline void cpu_clone_regs_child(CPUHPPAState *env, target_ulong newsp,
>      env->iaoq_b = env->gr[31] + 4;
>  }
>  
> +static inline void cpu_clone_regs_parent(CPUHPPAState *env, unsigned flags)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUHPPAState *env, target_ulong newtls)
>  {
>      env->cr[27] = newtls;
> diff --git a/linux-user/i386/target_cpu.h b/linux-user/i386/target_cpu.h
> index 1fadbf57c3..0b44530854 100644
> --- a/linux-user/i386/target_cpu.h
> +++ b/linux-user/i386/target_cpu.h
> @@ -29,6 +29,10 @@ static inline void cpu_clone_regs_child(CPUX86State *env, target_ulong newsp,
>      env->regs[R_EAX] = 0;
>  }
>  
> +static inline void cpu_clone_regs_parent(CPUX86State *env, unsigned flags)
> +{
> +}
> +
>  #if defined(TARGET_ABI32)
>  abi_long do_set_thread_area(CPUX86State *env, abi_ulong ptr);
>  
> diff --git a/linux-user/m68k/target_cpu.h b/linux-user/m68k/target_cpu.h
> index 57b647bc07..c3f288dfe8 100644
> --- a/linux-user/m68k/target_cpu.h
> +++ b/linux-user/m68k/target_cpu.h
> @@ -30,6 +30,10 @@ static inline void cpu_clone_regs_child(CPUM68KState *env, target_ulong newsp,
>      env->dregs[0] = 0;
>  }
>  
> +static inline void cpu_clone_regs_parent(CPUM68KState *env, unsigned flags)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUM68KState *env, target_ulong newtls)
>  {
>      CPUState *cs = env_cpu(env);
> diff --git a/linux-user/microblaze/target_cpu.h b/linux-user/microblaze/target_cpu.h
> index e9bc0fce65..ce7b22ece7 100644
> --- a/linux-user/microblaze/target_cpu.h
> +++ b/linux-user/microblaze/target_cpu.h
> @@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUMBState *env, target_ulong newsp,
>      env->regs[3] = 0;
>  }
>  
> +static inline void cpu_clone_regs_parent(CPUMBState *env, unsigned flags)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUMBState *env, target_ulong newtls)
>  {
>      env->regs[21] = newtls;
> diff --git a/linux-user/mips/target_cpu.h b/linux-user/mips/target_cpu.h
> index 8601f712e0..758ae4d933 100644
> --- a/linux-user/mips/target_cpu.h
> +++ b/linux-user/mips/target_cpu.h
> @@ -29,6 +29,10 @@ static inline void cpu_clone_regs_child(CPUMIPSState *env, target_ulong newsp,
>      env->active_tc.gpr[2] = 0;
>  }
>  
> +static inline void cpu_clone_regs_parent(CPUMIPSState *env, unsigned flags)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUMIPSState *env, target_ulong newtls)
>  {
>      env->active_tc.CP0_UserLocal = newtls;
> diff --git a/linux-user/nios2/target_cpu.h b/linux-user/nios2/target_cpu.h
> index fe5de7a9e3..50f0381067 100644
> --- a/linux-user/nios2/target_cpu.h
> +++ b/linux-user/nios2/target_cpu.h
> @@ -29,6 +29,10 @@ static inline void cpu_clone_regs_child(CPUNios2State *env, target_ulong newsp,
>      env->regs[R_RET0] = 0;
>  }
>  
> +static inline void cpu_clone_regs_parent(CPUNios2State *env, unsigned flags)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUNios2State *env, target_ulong newtls)
>  {
>      /*
> diff --git a/linux-user/openrisc/target_cpu.h b/linux-user/openrisc/target_cpu.h
> index 309cf3eeb7..74370d67c4 100644
> --- a/linux-user/openrisc/target_cpu.h
> +++ b/linux-user/openrisc/target_cpu.h
> @@ -30,6 +30,10 @@ static inline void cpu_clone_regs_child(CPUOpenRISCState *env,
>      cpu_set_gpr(env, 11, 0);
>  }
>  
> +static inline void cpu_clone_regs_parent(CPUOpenRISCState *env, unsigned flags)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUOpenRISCState *env, target_ulong newtls)
>  {
>      cpu_set_gpr(env, 10, newtls);
> diff --git a/linux-user/ppc/target_cpu.h b/linux-user/ppc/target_cpu.h
> index 028b28312c..76b67d2882 100644
> --- a/linux-user/ppc/target_cpu.h
> +++ b/linux-user/ppc/target_cpu.h
> @@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUPPCState *env, target_ulong newsp,
>      env->gpr[3] = 0;
>  }
>  
> +static inline void cpu_clone_regs_parent(CPUPPCState *env, unsigned flags)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUPPCState *env, target_ulong newtls)
>  {
>  #if defined(TARGET_PPC64)
> diff --git a/linux-user/riscv/target_cpu.h b/linux-user/riscv/target_cpu.h
> index 26dcafab1c..9c642367a3 100644
> --- a/linux-user/riscv/target_cpu.h
> +++ b/linux-user/riscv/target_cpu.h
> @@ -11,6 +11,10 @@ static inline void cpu_clone_regs_child(CPURISCVState *env, target_ulong newsp,
>      env->gpr[xA0] = 0;
>  }
>  
> +static inline void cpu_clone_regs_parent(CPURISCVState *env, unsigned flags)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPURISCVState *env, target_ulong newtls)
>  {
>      env->gpr[xTP] = newtls;
> diff --git a/linux-user/s390x/target_cpu.h b/linux-user/s390x/target_cpu.h
> index 0b19e42f75..7cd71e2dba 100644
> --- a/linux-user/s390x/target_cpu.h
> +++ b/linux-user/s390x/target_cpu.h
> @@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUS390XState *env, target_ulong newsp,
>      env->regs[2] = 0;
>  }
>  
> +static inline void cpu_clone_regs_parent(CPUS390XState *env, unsigned flags)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUS390XState *env, target_ulong newtls)
>  {
>      env->aregs[0] = newtls >> 32;
> diff --git a/linux-user/sh4/target_cpu.h b/linux-user/sh4/target_cpu.h
> index 857af43ee3..5114f19424 100644
> --- a/linux-user/sh4/target_cpu.h
> +++ b/linux-user/sh4/target_cpu.h
> @@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUSH4State *env, target_ulong newsp,
>      env->gregs[0] = 0;
>  }
>  
> +static inline void cpu_clone_regs_parent(CPUSH4State *env, unsigned flags)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUSH4State *env, target_ulong newtls)
>  {
>    env->gbr = newtls;
> diff --git a/linux-user/sparc/target_cpu.h b/linux-user/sparc/target_cpu.h
> index 029b0fc547..8ff706adce 100644
> --- a/linux-user/sparc/target_cpu.h
> +++ b/linux-user/sparc/target_cpu.h
> @@ -37,6 +37,10 @@ static inline void cpu_clone_regs_child(CPUSPARCState *env, target_ulong newsp,
>  #endif
>  }
>  
> +static inline void cpu_clone_regs_parent(CPUSPARCState *env, unsigned flags)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUSPARCState *env, target_ulong newtls)
>  {
>      env->gregs[7] = newtls;
> diff --git a/linux-user/tilegx/target_cpu.h b/linux-user/tilegx/target_cpu.h
> index 0523dc414c..316b7a639c 100644
> --- a/linux-user/tilegx/target_cpu.h
> +++ b/linux-user/tilegx/target_cpu.h
> @@ -28,6 +28,10 @@ static inline void cpu_clone_regs_child(CPUTLGState *env, target_ulong newsp,
>      env->regs[TILEGX_R_RE] = 0;
>  }
>  
> +static inline void cpu_clone_regs_parent(CPUTLGState *env, unsigned flags)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUTLGState *env, target_ulong newtls)
>  {
>      env->regs[TILEGX_R_TP] = newtls;
> diff --git a/linux-user/xtensa/target_cpu.h b/linux-user/xtensa/target_cpu.h
> index 84f67d469e..0c77bafd66 100644
> --- a/linux-user/xtensa/target_cpu.h
> +++ b/linux-user/xtensa/target_cpu.h
> @@ -16,6 +16,10 @@ static inline void cpu_clone_regs_child(CPUXtensaState *env,
>      env->regs[2] = 0;
>  }
>  
> +static inline void cpu_clone_regs_parent(CPUXtensaState *env, unsigned flags)
> +{
> +}
> +
>  static inline void cpu_set_tls(CPUXtensaState *env, target_ulong newtls)
>  {
>      env->uregs[THREADPTR] = newtls;
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index a07d4b4774..ed18bcc825 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -5719,6 +5719,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
>          new_env = cpu_copy(env);
>          /* Init regs that differ from the parent.  */
>          cpu_clone_regs_child(new_env, newsp, flags);
> +        cpu_clone_regs_parent(env, flags);
>          new_cpu = env_cpu(new_env);
>          new_cpu->opaque = ts;
>          ts->bprm = parent_ts->bprm;
> @@ -5815,6 +5816,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
>              if (flags & CLONE_CHILD_CLEARTID)
>                  ts->child_tidptr = child_tidptr;
>          } else {
> +            cpu_clone_regs_parent(env, flags);
>              fork_end(0);
>          }
>      }
> 

Applied to my linux-user branch.

Thanks,
Laurent

