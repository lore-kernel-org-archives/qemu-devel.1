Return-Path: <SRS0=nJ0+=TL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05801C04AB1
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2019 13:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD132146F
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2019 13:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuApJOfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD132146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59026 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPSIS-0003Gj-Qk
	for qemu-devel@archiver.kernel.org; Sat, 11 May 2019 09:44:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hPSHh-0002xf-MO
	for qemu-devel@nongnu.org; Sat, 11 May 2019 09:43:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hPSHf-0000X0-HA
	for qemu-devel@nongnu.org; Sat, 11 May 2019 09:43:29 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:42535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hPSHf-0000WF-8y
	for qemu-devel@nongnu.org; Sat, 11 May 2019 09:43:27 -0400
Received: by mail-oi1-x22e.google.com with SMTP id k9so6437765oig.9
	for <qemu-devel@nongnu.org>; Sat, 11 May 2019 06:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=vPECgHsHWR8GpgTxE5tb28CUFLfXzcFRZc58002qRPo=;
	b=TuApJOfAFIGQ6IxOGudYU7oi7HI19Q75UhbEWnQbyfmLohNjs8joEyE8fvqwEJ4Afv
	xH8M3+HVD8wBXrxM8gXncmrsk4tN/ZebcmnVXQchy3GLeHKdnGseTvUeRRqu+tHzky0g
	Y4pGxVaI4DRaBwZJCbM7/AglqP09A6DeV16A+vhzVeYu9d4dMM2PMn4EczkP36XPivCK
	VfCfbwb8aI2goWFWyFLFcslRnAzAAnFAaIuaQUfMVtKwLum2+VbvEWqhNV719lqO+Ubh
	+vXEYKZbs5EflwYbluM5n2PF0UkMx8ROYy+s2Tn0r68HlTgVHvdnGZXv3KkH1xciGGxR
	udtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=vPECgHsHWR8GpgTxE5tb28CUFLfXzcFRZc58002qRPo=;
	b=tu3nkuXaHd9+g+1o4WS6IbZpOii/Nl7Zj+UzQ64n5GccTfu+XxWfic44nc5iHDPXNo
	OSH8mQmsAFdFc1RV2np0a43dkC8bUD5bpty/nVol/Vn+XFN4Lspuf44le/5XlPXybqOi
	m3LkjjaTu0tUh6Ezg0TP1zbEBJP3S5rAIoP1twi+r69d9wSK/O+2vXfknMZzlfdnLtb3
	F2AVtJF5Wy13uwwcJvRREkJocnxSgD10W7N8iI0FF/S2KB6ABbcYHFz5uOof3Jc7NoUX
	hYfByjPWyMcBKKlaqxxJnaaO4Fe7oGO+jZcbqUJZP2Rgb/2yhVY+4GhYXnEGaZh5QriU
	fzzA==
X-Gm-Message-State: APjAAAWny3lqyX16k6P4oRyRfKQaXJdB55YV7gy1NueDJhotYw1yCyZE
	4qDKV1bbIgCdIy+nDlTZjMVZxe9btxkCZW8ODrg=
X-Google-Smtp-Source: APXvYqxfW+VsynZxQHk/3YFqnDQy7Z6IjKrihAyPgAQJz4e9wbsiAmnNF00Fl4cKOEBexgv//SRqb0ZLFxbSeN3Iu0M=
X-Received: by 2002:a54:4f99:: with SMTP id g25mr8726350oiy.136.1557582206289; 
	Sat, 11 May 2019 06:43:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Sat, 11 May 2019 06:43:25
	-0700 (PDT)
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Sat, 11 May 2019 06:43:25
	-0700 (PDT)
In-Reply-To: <20190510185438.29533-4-richard.henderson@linaro.org>
References: <20190510185438.29533-1-richard.henderson@linaro.org>
	<20190510185438.29533-4-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 11 May 2019 15:43:25 +0200
Message-ID: <CAL1e-=hRXg7eykwjDxTDXt33FiFOAkkGQk23mEZRB3ChaZcAQA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PULL v2 12/27] target/mips: Convert to
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, peter.maydell@linaro.org,
	qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 10, 2019 8:57 PM, "Richard Henderson" <richard.henderson@linaro.org>
wrote:
>

Please change the title to 'target/mips: Switch to using
mips_cpu_tlb_fill()', or something along that line.

Also, the reason for changing the field access_type to mips_access type
should be explained in the commit message.

This commit message is generally poor, as it explains relatively
unimportant logging issue, while not explaining the core of the change.

Thanks,
Aleksandar

> Note that env->active_tc.PC is removed from the qemu_log as that value
> is garbage.  The PC isn't recovered until cpu_restore_state, called from
> cpu_loop_exit_restore, called from do_raise_exception_err.
>
> Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
> Cc: Aleksandar Rikalo <arikalo@wavecomp.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/mips/internal.h  |  5 +++--
>  target/mips/cpu.c       |  5 ++---
>  target/mips/helper.c    | 45 ++++++++++++++++++++++-------------------
>  target/mips/op_helper.c | 15 --------------
>  4 files changed, 29 insertions(+), 41 deletions(-)
>
> diff --git a/target/mips/internal.h b/target/mips/internal.h
> index 286e3888ab..b2b41a51ab 100644
> --- a/target/mips/internal.h
> +++ b/target/mips/internal.h
> @@ -202,8 +202,9 @@ void cpu_mips_start_count(CPUMIPSState *env);
>  void cpu_mips_stop_count(CPUMIPSState *env);
>
>  /* helper.c */
> -int mips_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
int rw,
> -                              int mmu_idx);
> +bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                       MMUAccessType access_type, int mmu_idx,
> +                       bool probe, uintptr_t retaddr);
>
>  /* op_helper.c */
>  uint32_t float_class_s(uint32_t arg, float_status *fst);
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index e217fb3e36..a33058609a 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -197,9 +197,7 @@ static void mips_cpu_class_init(ObjectClass *c, void
*data)
>      cc->synchronize_from_tb =3D mips_cpu_synchronize_from_tb;
>      cc->gdb_read_register =3D mips_cpu_gdb_read_register;
>      cc->gdb_write_register =3D mips_cpu_gdb_write_register;
> -#ifdef CONFIG_USER_ONLY
> -    cc->handle_mmu_fault =3D mips_cpu_handle_mmu_fault;
> -#else
> +#ifndef CONFIG_USER_ONLY
>      cc->do_unassigned_access =3D mips_cpu_unassigned_access;
>      cc->do_unaligned_access =3D mips_cpu_do_unaligned_access;
>      cc->get_phys_page_debug =3D mips_cpu_get_phys_page_debug;
> @@ -208,6 +206,7 @@ static void mips_cpu_class_init(ObjectClass *c, void
*data)
>      cc->disas_set_info =3D mips_cpu_disas_set_info;
>  #ifdef CONFIG_TCG
>      cc->tcg_initialize =3D mips_tcg_init;
> +    cc->tlb_fill =3D mips_cpu_tlb_fill;
>  #endif
>
>      cc->gdb_num_core_regs =3D 73;
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index 86e622efb8..3a4917ce7b 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -874,31 +874,25 @@ refill:
>  #endif
>  #endif
>
> -int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int
rw,
> -                              int mmu_idx)
> +bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                       MMUAccessType access_type, int mmu_idx,
> +                       bool probe, uintptr_t retaddr)
>  {
>      MIPSCPU *cpu =3D MIPS_CPU(cs);
>      CPUMIPSState *env =3D &cpu->env;
>  #if !defined(CONFIG_USER_ONLY)
>      hwaddr physical;
>      int prot;
> -    int access_type;
> +    int mips_access_type;
>  #endif
>      int ret =3D TLBRET_BADADDR;
>
> -#if 0
> -    log_cpu_state(cs, 0);
> -#endif
> -    qemu_log_mask(CPU_LOG_MMU,
> -              "%s pc " TARGET_FMT_lx " ad %" VADDR_PRIx " rw %d mmu_idx
%d\n",
> -              __func__, env->active_tc.PC, address, rw, mmu_idx);
> -
>      /* data access */
>  #if !defined(CONFIG_USER_ONLY)
>      /* XXX: put correct access by using cpu_restore_state() correctly */
> -    access_type =3D ACCESS_INT;
> -    ret =3D get_physical_address(env, &physical, &prot,
> -                               address, rw, access_type, mmu_idx);
> +    mips_access_type =3D ACCESS_INT;
> +    ret =3D get_physical_address(env, &physical, &prot, address,
> +                               access_type, mips_access_type, mmu_idx);
>      switch (ret) {
>      case TLBRET_MATCH:
>          qemu_log_mask(CPU_LOG_MMU,
> @@ -915,7 +909,7 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr
address, int size, int rw,
>          tlb_set_page(cs, address & TARGET_PAGE_MASK,
>                       physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
>                       mmu_idx, TARGET_PAGE_SIZE);
> -        return 0;
> +        return true;
>      }
>  #if !defined(TARGET_MIPS64)
>      if ((ret =3D=3D TLBRET_NOMATCH) && (env->tlb->nb_tlb > 1)) {
> @@ -926,27 +920,36 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr
address, int size, int rw,
>          int mode =3D (env->hflags & MIPS_HFLAG_KSU);
>          bool ret_walker;
>          env->hflags &=3D ~MIPS_HFLAG_KSU;
> -        ret_walker =3D page_table_walk_refill(env, address, rw, mmu_idx)=
;
> +        ret_walker =3D page_table_walk_refill(env, address, access_type,
mmu_idx);
>          env->hflags |=3D mode;
>          if (ret_walker) {
> -            ret =3D get_physical_address(env, &physical, &prot,
> -                                       address, rw, access_type,
mmu_idx);
> +            ret =3D get_physical_address(env, &physical, &prot, address,
> +                                       access_type, mips_access_type,
mmu_idx);=C2=BF
>              if (ret =3D=3D TLBRET_MATCH) {
>                  tlb_set_page(cs, address & TARGET_PAGE_MASK,
>                               physical & TARGET_PAGE_MASK, prot |
PAGE_EXEC,
>                               mmu_idx, TARGET_PAGE_SIZE);
> -                return 0;
> +                return true;
>              }
>          }
>      }
>  #endif
> +    if (probe) {
> +        return false;
> +    }
>  #endif
>
> -    raise_mmu_exception(env, address, rw, ret);
> -    return 1;
> +    raise_mmu_exception(env, address, access_type, ret);
> +    do_raise_exception_err(env, cs->exception_index, env->error_code,
retaddr);
> +}
> +
> +#ifndef CONFIG_USER_ONLY
> +void tlb_fill(CPUState *cs, target_ulong addr, int size,
> +              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
> +{
> +    mips_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false,
retaddr);
>  }
>
> -#if !defined(CONFIG_USER_ONLY)
>  hwaddr cpu_mips_translate_address(CPUMIPSState *env, target_ulong
address, int rw)
>  {
>      hwaddr physical;
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 0f272a5b93..6d86912958 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -2669,21 +2669,6 @@ void mips_cpu_do_unaligned_access(CPUState *cs,
vaddr addr,
>      do_raise_exception_err(env, excp, error_code, retaddr);
>  }
>
> -void tlb_fill(CPUState *cs, target_ulong addr, int size,
> -              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
> -{
> -    int ret;
> -
> -    ret =3D mips_cpu_handle_mmu_fault(cs, addr, size, access_type,
mmu_idx);
> -    if (ret) {
> -        MIPSCPU *cpu =3D MIPS_CPU(cs);
> -        CPUMIPSState *env =3D &cpu->env;
> -
> -        do_raise_exception_err(env, cs->exception_index,
> -                               env->error_code, retaddr);
> -    }
> -}
> -
>  void mips_cpu_unassigned_access(CPUState *cs, hwaddr addr,
>                                  bool is_write, bool is_exec, int unused,
>                                  unsigned size)
> --
> 2.17.1
>
>
