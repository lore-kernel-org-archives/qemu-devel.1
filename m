Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F422C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:10:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D9BE214AF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9BE214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59992 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOFmi-0006P4-Eb
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 02:10:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOFly-00063A-Qw
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOFlx-0007L9-JC
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:09:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOFlx-0007L2-CP
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:09:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id y2so1582531wmi.5
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 23:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=xGakqhVfRfFnrDETF6RPKivNuyfCIKhxVJsbeKGQugU=;
	b=lmgAFvBeFLTBp7Tuz43Wu/CZyT2cW67fGt4q5GQtph2ajUvSMGcg+y0KEne2fjhjKK
	KCGzWDFBMsxzWmxpcQXiMWYLUHYt5Q0o/228H5Wjq/1sxCaILCtTLGdjW38aX8IsQMql
	T6q2wWZQHpVAFhl//IfnI2i+kxEP0cRIDhkv6Fo5HNQTj+mIlD5gg9txBfuOJKYRxPiR
	B8u/2NybN13NOm/ELjU8z09jU3wjlj5lU/rCkLWYp0JSXdt7FJGmF2ZDFbeuXSLVh0X4
	VLDGhbfnDoFsozqnWrtvJ5A9uVm5KqAgLGxxlQillWwVBunrbe4aa9J37Gqc9Q4DGiIt
	nBMg==
X-Gm-Message-State: APjAAAWqFevDPP2FXGFvqQr8A4oWJEg9H7SVsU3zijY6b4/snpu1kRTV
	rsZKUoulkowMSSbjrGLylIbPTddEGNI=
X-Google-Smtp-Source: APXvYqzM/FwOS92SEr9yV+QEYovTYM72UbCBPcPiO5MWTRRcJg56RfyQ603c8FuIUGjQsGeQP5rDrw==
X-Received: by 2002:a1c:f310:: with SMTP id q16mr1649160wmq.102.1557295784269; 
	Tue, 07 May 2019 23:09:44 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	j46sm3323181wre.54.2019.05.07.23.09.43
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 23:09:43 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8985d739-041d-9a6f-5b18-3d8c6875c245@redhat.com>
Date: Wed, 8 May 2019 08:09:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403034358.21999-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH 03/26] target/alpha: Convert to
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/3/19 5:43 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/alpha/cpu.h        |  5 ++--
>  target/alpha/cpu.c        |  5 ++--
>  target/alpha/helper.c     | 50 +++++++++++++++++++++++----------------
>  target/alpha/mem_helper.c | 16 -------------
>  4 files changed, 35 insertions(+), 41 deletions(-)
> 
> diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
> index 7b50be785d..aecf8d75c1 100644
> --- a/target/alpha/cpu.h
> +++ b/target/alpha/cpu.h
> @@ -476,8 +476,9 @@ void alpha_cpu_list(FILE *f, fprintf_function cpu_fprintf);
>     is returned if the signal was handled by the virtual CPU.  */
>  int cpu_alpha_signal_handler(int host_signum, void *pinfo,
>                               void *puc);
> -int alpha_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
> -                               int mmu_idx);
> +bool alpha_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                        MMUAccessType access_type, int mmu_idx,
> +                        bool probe, uintptr_t retaddr);
>  void QEMU_NORETURN dynamic_excp(CPUAlphaState *, uintptr_t, int, int);
>  void QEMU_NORETURN arith_excp(CPUAlphaState *, uintptr_t, int, uint64_t);
>  
> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
> index 1fd95d6c0f..5aa4581b9f 100644
> --- a/target/alpha/cpu.c
> +++ b/target/alpha/cpu.c
> @@ -230,9 +230,8 @@ static void alpha_cpu_class_init(ObjectClass *oc, void *data)
>      cc->set_pc = alpha_cpu_set_pc;
>      cc->gdb_read_register = alpha_cpu_gdb_read_register;
>      cc->gdb_write_register = alpha_cpu_gdb_write_register;
> -#ifdef CONFIG_USER_ONLY
> -    cc->handle_mmu_fault = alpha_cpu_handle_mmu_fault;
> -#else
> +    cc->tlb_fill = alpha_cpu_tlb_fill;
> +#ifndef CONFIG_USER_ONLY
>      cc->do_transaction_failed = alpha_cpu_do_transaction_failed;
>      cc->do_unaligned_access = alpha_cpu_do_unaligned_access;
>      cc->get_phys_page_debug = alpha_cpu_get_phys_page_debug;
> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> index 57e2c212b3..e54197d5fb 100644
> --- a/target/alpha/helper.c
> +++ b/target/alpha/helper.c
> @@ -102,17 +102,7 @@ void cpu_alpha_store_gr(CPUAlphaState *env, unsigned reg, uint64_t val)
>      *cpu_alpha_addr_gr(env, reg) = val;
>  }
>  
> -#if defined(CONFIG_USER_ONLY)
> -int alpha_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
> -                               int rw, int mmu_idx)
> -{
> -    AlphaCPU *cpu = ALPHA_CPU(cs);
> -
> -    cs->exception_index = EXCP_MMFAULT;
> -    cpu->env.trap_arg0 = address;
> -    return 1;
> -}
> -#else
> +#ifndef CONFIG_USER_ONLY
>  /* Returns the OSF/1 entMM failure indication, or -1 on success.  */
>  static int get_physical_address(CPUAlphaState *env, target_ulong addr,
>                                  int prot_need, int mmu_idx,
> @@ -246,29 +236,49 @@ hwaddr alpha_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>      fail = get_physical_address(&cpu->env, addr, 0, 0, &phys, &prot);
>      return (fail >= 0 ? -1 : phys);
>  }
> +#endif /* !USER_ONLY */
>  
> -int alpha_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int size, int rw,
> -                               int mmu_idx)
> +bool alpha_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                        MMUAccessType access_type, int mmu_idx,
> +                        bool probe, uintptr_t retaddr)
>  {
>      AlphaCPU *cpu = ALPHA_CPU(cs);
> +
> +#ifdef CONFIG_USER_ONLY
> +    cs->exception_index = EXCP_MMFAULT;
> +    cpu->env.trap_arg0 = address;
> +    cpu_loop_exit_restore(cs, retaddr);
> +#else
>      CPUAlphaState *env = &cpu->env;
>      target_ulong phys;
>      int prot, fail;
>  
> -    fail = get_physical_address(env, addr, 1 << rw, mmu_idx, &phys, &prot);
> +    fail = get_physical_address(env, address, 1 << access_type,
> +                                mmu_idx, &phys, &prot);
>      if (unlikely(fail >= 0)) {
> +        if (probe) {
> +            return false;
> +        }
>          cs->exception_index = EXCP_MMFAULT;
> -        env->trap_arg0 = addr;
> +        env->trap_arg0 = address;
>          env->trap_arg1 = fail;
> -        env->trap_arg2 = (rw == 2 ? -1 : rw);
> -        return 1;
> +        env->trap_arg2 = (access_type == MMU_INST_FETCH ? -1 : access_type);
> +        cpu_loop_exit_restore(cs, retaddr);
>      }
>  
> -    tlb_set_page(cs, addr & TARGET_PAGE_MASK, phys & TARGET_PAGE_MASK,
> +    tlb_set_page(cs, address & TARGET_PAGE_MASK, phys & TARGET_PAGE_MASK,
>                   prot, mmu_idx, TARGET_PAGE_SIZE);
> -    return 0;
> +    return true;
> +#endif
>  }
> -#endif /* USER_ONLY */
> +
> +#ifndef CONFIG_USER_ONLY
> +void tlb_fill(CPUState *cs, target_ulong addr, int size,
> +              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
> +{
> +    alpha_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
> +}
> +#endif
>  
>  void alpha_cpu_do_interrupt(CPUState *cs)
>  {
> diff --git a/target/alpha/mem_helper.c b/target/alpha/mem_helper.c
> index 011bc73dca..934faa1d6f 100644
> --- a/target/alpha/mem_helper.c
> +++ b/target/alpha/mem_helper.c
> @@ -62,20 +62,4 @@ void alpha_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
>      env->error_code = 0;
>      cpu_loop_exit_restore(cs, retaddr);
>  }
> -
> -/* try to fill the TLB and return an exception if error. If retaddr is
> -   NULL, it means that the function was called in C code (i.e. not
> -   from generated code or from helper.c) */
> -/* XXX: fix it to restore all registers */
> -void tlb_fill(CPUState *cs, target_ulong addr, int size,
> -              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
> -{
> -    int ret;
> -
> -    ret = alpha_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
> -    if (unlikely(ret != 0)) {
> -        /* Exception index and error code are already set */
> -        cpu_loop_exit_restore(cs, retaddr);
> -    }
> -}
>  #endif /* CONFIG_USER_ONLY */
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

