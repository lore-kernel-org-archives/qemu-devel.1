Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44278C04AAD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 05:56:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08FE821530
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 05:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08FE821530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59852 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOFZP-00012f-D1
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 01:56:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOFYf-0000P3-5E
	for qemu-devel@nongnu.org; Wed, 08 May 2019 01:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOFYd-0002NT-KC
	for qemu-devel@nongnu.org; Wed, 08 May 2019 01:56:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42539)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOFYd-0002NJ-CE
	for qemu-devel@nongnu.org; Wed, 08 May 2019 01:55:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id l2so25463196wrb.9
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 22:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=DsqIVQbV70thLFeyEy04EutJHIPC5qKLfk5pb0valWo=;
	b=ih459jCxCbAOYLYgaptQ2e+indyfAu1fhNUaenBmVInJ2SdCqV1KqeAx2+UdQSkfI9
	yNSugT9AuSCIk3ddOKEUESZPZmeinfcdje9eUbZxoY+uAHmfsEesHcumpqFLL995j6F3
	grHfEuODJ+Ln9ihnhI1lXyDyVOMYDNyLRkgaG35JV8QmqULCHUOVQojnRQMWn0mrF7cc
	cXtTnPWuidRIfQIXmOuEtMj0ydDORXEgzTSPuodF3al8lySNPVCftdzrIGh+sKl+RyZ5
	q2m1hCeTj3Vy56ZBMw99HubAN8fOQwFN4bpIvOgAwI/Vt+F1JzT/P6Nt4fo1xTamq0PO
	ru0w==
X-Gm-Message-State: APjAAAUUhGUktvQdHLo3eJ5claqo3HNtxM6gFmbx0oVmZKHRUsC2EYUV
	eV05T5CETj7MC5lJQ+Dld/V3Tw==
X-Google-Smtp-Source: APXvYqyCb96MRrHVEevN1fmQW2LPrbYZJteiwdLoFMy1mldGJj5Q1kFFWAmZGslEQ8mvnnd9kqCz3g==
X-Received: by 2002:adf:b3d1:: with SMTP id x17mr10266517wrd.31.1557294958445; 
	Tue, 07 May 2019 22:55:58 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id q7sm1161000wmc.11.2019.05.07.22.55.57
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 22:55:57 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <5bade5e4-304f-2b4e-9b16-545b15059839@redhat.com>
Date: Wed, 8 May 2019 07:55:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403034358.21999-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH 11/26] target/mips: Convert to
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/3/19 5:43 AM, Richard Henderson wrote:
> Note that env->active_tc.PC is removed from the qemu_log as that value
> is garbage.  The PC isn't recovered until cpu_restore_state, called from
> cpu_loop_exit_restore, called from do_raise_exception_err.
> 
> Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
> Cc: Aleksandar Rikalo <arikalo@wavecomp.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/mips/internal.h  |   5 +-
>  target/mips/cpu.c       |   5 +-
>  target/mips/helper.c    | 115 +++++++++++++++++++---------------------
>  target/mips/op_helper.c |  15 ------
>  4 files changed, 61 insertions(+), 79 deletions(-)
> 
> diff --git a/target/mips/internal.h b/target/mips/internal.h
> index 8f6fc919d5..5ec9d0bd65 100644
> --- a/target/mips/internal.h
> +++ b/target/mips/internal.h
> @@ -203,8 +203,9 @@ void cpu_mips_start_count(CPUMIPSState *env);
>  void cpu_mips_stop_count(CPUMIPSState *env);
>  
>  /* helper.c */
> -int mips_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
> -                              int mmu_idx);
> +bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                       MMUAccessType access_type, int mmu_idx,
> +                       bool probe, uintptr_t retaddr);
>  
>  /* op_helper.c */
>  uint32_t float_class_s(uint32_t arg, float_status *fst);
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index e217fb3e36..ebdb834b97 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -197,9 +197,8 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
>      cc->synchronize_from_tb = mips_cpu_synchronize_from_tb;
>      cc->gdb_read_register = mips_cpu_gdb_read_register;
>      cc->gdb_write_register = mips_cpu_gdb_write_register;
> -#ifdef CONFIG_USER_ONLY
> -    cc->handle_mmu_fault = mips_cpu_handle_mmu_fault;
> -#else
> +    cc->tlb_fill = mips_cpu_tlb_fill;
> +#ifndef CONFIG_USER_ONLY
>      cc->do_unassigned_access = mips_cpu_unassigned_access;
>      cc->do_unaligned_access = mips_cpu_do_unaligned_access;
>      cc->get_phys_page_debug = mips_cpu_get_phys_page_debug;
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index c44cdca3b5..7fe0ba4754 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -874,85 +874,82 @@ refill:
>  #endif
>  #endif
>  
> -int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
> -                              int mmu_idx)
> +bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                       MMUAccessType access_type, int mmu_idx,
> +                       bool probe, uintptr_t retaddr)
>  {
>      MIPSCPU *cpu = MIPS_CPU(cs);
>      CPUMIPSState *env = &cpu->env;
> -#if !defined(CONFIG_USER_ONLY)
> +    int ret = TLBRET_NOMATCH;
> +
> +#ifndef CONFIG_USER_ONLY
>      hwaddr physical;
>      int prot;
> -    int access_type;
> -#endif
> -    int ret = 0;
> +    int mips_access_type = ACCESS_INT;
>  
> -#if 0
> -    log_cpu_state(cs, 0);
> -#endif
>      qemu_log_mask(CPU_LOG_MMU,
> -              "%s pc " TARGET_FMT_lx " ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
> -              __func__, env->active_tc.PC, address, rw, mmu_idx);
> +                  "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
> +                  __func__, address, access_type, mmu_idx);
>  
>      /* data access */
> -#if !defined(CONFIG_USER_ONLY)
>      /* XXX: put correct access by using cpu_restore_state() correctly */
> -    access_type = ACCESS_INT;
> -    ret = get_physical_address(env, &physical, &prot,
> -                               address, rw, access_type, mmu_idx);
> -    switch (ret) {
> -    case TLBRET_MATCH:
> +    ret = get_physical_address(env, &physical, &prot, address,
> +                               access_type, mips_access_type, mmu_idx);
> +    if (ret == TLBRET_MATCH) {
>          qemu_log_mask(CPU_LOG_MMU,
>                        "%s address=%" VADDR_PRIx " physical " TARGET_FMT_plx
>                        " prot %d\n", __func__, address, physical, prot);
> -        break;
> -    default:
> -        qemu_log_mask(CPU_LOG_MMU,
> -                      "%s address=%" VADDR_PRIx " ret %d\n", __func__, address,
> -                      ret);
> -        break;
> -    }
> -    if (ret == TLBRET_MATCH) {
>          tlb_set_page(cs, address & TARGET_PAGE_MASK,
>                       physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
>                       mmu_idx, TARGET_PAGE_SIZE);
> -        ret = 0;
> -    } else if (ret < 0)
> -#endif
> -    {
> -#if !defined(CONFIG_USER_ONLY)
> -#if !defined(TARGET_MIPS64)
> -        if ((ret == TLBRET_NOMATCH) && (env->tlb->nb_tlb > 1)) {
> -            /*
> -             * Memory reads during hardware page table walking are performed
> -             * as if they were kernel-mode load instructions.
> -             */
> -            int mode = (env->hflags & MIPS_HFLAG_KSU);
> -            bool ret_walker;
> -            env->hflags &= ~MIPS_HFLAG_KSU;
> -            ret_walker = page_table_walk_refill(env, address, rw, mmu_idx);
> -            env->hflags |= mode;
> -            if (ret_walker) {
> -                ret = get_physical_address(env, &physical, &prot,
> -                                           address, rw, access_type, mmu_idx);
> -                if (ret == TLBRET_MATCH) {
> -                    tlb_set_page(cs, address & TARGET_PAGE_MASK,
> -                            physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
> -                            mmu_idx, TARGET_PAGE_SIZE);
> -                    ret = 0;
> -                    return ret;
> -                }
> -            }
> -        }
> -#endif
> -#endif
> -        raise_mmu_exception(env, address, rw, ret);
> -        ret = 1;
> +        return true;
>      }
>  
> -    return ret;
> +    qemu_log_mask(CPU_LOG_MMU, "%s address=%" VADDR_PRIx " ret %d\n",
> +                  __func__, address, ret);
> +
> +#ifndef TARGET_MIPS64
> +    if ((ret == TLBRET_NOMATCH) && (env->tlb->nb_tlb > 1)) {
> +        /*
> +         * Memory reads during hardware page table walking are performed
> +         * as if they were kernel-mode load instructions.
> +         */
> +        int mode = (env->hflags & MIPS_HFLAG_KSU);
> +        bool ret_walker;
> +
> +        env->hflags &= ~MIPS_HFLAG_KSU;
> +        ret_walker = page_table_walk_refill(env, address, access_type, mmu_idx);
> +        env->hflags |= mode;
> +
> +        if (ret_walker) {
> +            ret = get_physical_address(env, &physical, &prot, address,
> +                                       access_type, mips_access_type, mmu_idx);
> +            if (ret == TLBRET_MATCH) {
> +                tlb_set_page(cs, address & TARGET_PAGE_MASK,
> +                             physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
> +                             mmu_idx, TARGET_PAGE_SIZE);
> +                return true;
> +            }
> +        }
> +    }
> +#endif
> +
> +    if (probe) {
> +        return false;
> +    }
> +#endif /* !CONFIG_USER_ONLY */
> +
> +    raise_mmu_exception(env, address, access_type, ret);
> +    do_raise_exception_err(env, cs->exception_index, env->error_code, retaddr);
> +}
> +
> +#ifndef CONFIG_USER_ONLY
> +void tlb_fill(CPUState *cs, target_ulong addr, int size,
> +              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
> +{
> +    mips_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
>  }
>  
> -#if !defined(CONFIG_USER_ONLY)
>  hwaddr cpu_mips_translate_address(CPUMIPSState *env, target_ulong address, int rw)
>  {
>      hwaddr physical;
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 0f272a5b93..6d86912958 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -2669,21 +2669,6 @@ void mips_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>      do_raise_exception_err(env, excp, error_code, retaddr);
>  }
>  
> -void tlb_fill(CPUState *cs, target_ulong addr, int size,
> -              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
> -{
> -    int ret;
> -
> -    ret = mips_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
> -    if (ret) {
> -        MIPSCPU *cpu = MIPS_CPU(cs);
> -        CPUMIPSState *env = &cpu->env;
> -
> -        do_raise_exception_err(env, cs->exception_index,
> -                               env->error_code, retaddr);
> -    }
> -}
> -
>  void mips_cpu_unassigned_access(CPUState *cs, hwaddr addr,
>                                  bool is_write, bool is_exec, int unused,
>                                  unsigned size)
> 

