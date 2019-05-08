Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E82C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:08:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E969214AF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E969214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59950 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOFkH-0005Wc-TA
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 02:08:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOFjY-0005DL-6w
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOFjX-00069s-2T
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:07:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOFjW-00069X-SN
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:07:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id f7so15167881wrq.1
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 23:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=/WzalhdvLjWPvOvhdz38ZL59gCgXD+gX0bV3LsR2CSI=;
	b=Ee7d3at40wFuZ0j0Sxmgblt466FETOeq9Vgq5RcpFtZZJcMeDwt6OJ4IJN+5C4chZt
	5OcWUf9iU/DZar4/up8YdckyPsvUmF6YkN5mBlPXwPpAol1zzaQb5O+Hm/sAqO80qkCE
	XwIm8xyhqQ4C9Y/9VQcq+0qMGly8GGon4zL31xU7hRPH4eVSYOkc+xUu26vhxH1S/Mbr
	1KjzcDDuUdbiBCQoLb1HCDX3/pLknlmSAJxHhgruJDy8Vfnh13VTTOEa72SG2KAAdUzw
	kTZDolKcQ6Gtii49uY3ZMm/El9GmKh4akTaeE7YC22+yPSnJdFJm5/rewP11H0380r65
	4c2w==
X-Gm-Message-State: APjAAAV178oluS21MTCENPFPZiJtmy+J+6XjQtpjmY5EecnlZJHLqF32
	VQQNn77Gqe90Vslhc9pfn9EJLMSNzBA=
X-Google-Smtp-Source: APXvYqwe2iDM2bjL7FulueLznHDj2kH1bM2gTzdYNgmebH9TS0cfZBpWv8DpGoA3r1AT60RsVn3PIg==
X-Received: by 2002:adf:eb50:: with SMTP id u16mr13565469wrn.54.1557295633562; 
	Tue, 07 May 2019 23:07:13 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id f7sm1645516wrv.17.2019.05.07.23.07.12
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 23:07:13 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a61f3d2a-cf54-f09f-cd69-a585799e13f7@redhat.com>
Date: Wed, 8 May 2019 08:07:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403034358.21999-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 06/26] target/hppa: Convert to
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
>  target/hppa/cpu.h        |  8 ++++----
>  target/hppa/cpu.c        |  5 ++---
>  target/hppa/mem_helper.c | 22 +++++++++++++++++-----
>  3 files changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
> index c062c7969c..e0e5d879e1 100644
> --- a/target/hppa/cpu.h
> +++ b/target/hppa/cpu.h
> @@ -360,10 +360,10 @@ int hppa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>  void hppa_cpu_do_interrupt(CPUState *cpu);
>  bool hppa_cpu_exec_interrupt(CPUState *cpu, int int_req);
>  void hppa_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function, int);
> -#ifdef CONFIG_USER_ONLY
> -int hppa_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
> -                              int rw, int midx);
> -#else
> +bool hppa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                       MMUAccessType access_type, int mmu_idx,
> +                       bool probe, uintptr_t retaddr);
> +#ifndef CONFIG_USER_ONLY
>  int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
>                                int type, hwaddr *pphys, int *pprot);
>  extern const MemoryRegionOps hppa_io_eir_ops;
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index 00bf444620..46750980f7 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -167,9 +167,8 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
>      cc->synchronize_from_tb = hppa_cpu_synchronize_from_tb;
>      cc->gdb_read_register = hppa_cpu_gdb_read_register;
>      cc->gdb_write_register = hppa_cpu_gdb_write_register;
> -#ifdef CONFIG_USER_ONLY
> -    cc->handle_mmu_fault = hppa_cpu_handle_mmu_fault;
> -#else
> +    cc->tlb_fill = hppa_cpu_tlb_fill;
> +#ifndef CONFIG_USER_ONLY
>      cc->get_phys_page_debug = hppa_cpu_get_phys_page_debug;
>      dc->vmsd = &vmstate_hppa_cpu;
>  #endif
> diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
> index c9b57d07c3..f61b0fdb9f 100644
> --- a/target/hppa/mem_helper.c
> +++ b/target/hppa/mem_helper.c
> @@ -25,8 +25,9 @@
>  #include "trace.h"
>  
>  #ifdef CONFIG_USER_ONLY
> -int hppa_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
> -                              int size, int rw, int mmu_idx)
> +bool hppa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                       MMUAccessType access_type, int mmu_idx,
> +                       bool probe, uintptr_t retaddr)
>  {
>      HPPACPU *cpu = HPPA_CPU(cs);
>  
> @@ -34,7 +35,7 @@ int hppa_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
>         which would affect si_code.  */
>      cs->exception_index = EXCP_DMP;
>      cpu->env.cr[CR_IOR] = address;
> -    return 1;
> +    cpu_loop_exit_restore(cs, retaddr);

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  }
>  #else
>  static hppa_tlb_entry *hppa_find_tlb(CPUHPPAState *env, vaddr addr)
> @@ -214,8 +215,9 @@ hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>      return excp == EXCP_DTLB_MISS ? -1 : phys;
>  }
>  
> -void tlb_fill(CPUState *cs, target_ulong addr, int size,
> -              MMUAccessType type, int mmu_idx, uintptr_t retaddr)
> +bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
> +                       MMUAccessType type, int mmu_idx,
> +                       bool probe, uintptr_t retaddr)
>  {
>      HPPACPU *cpu = HPPA_CPU(cs);
>      CPUHPPAState *env = &cpu->env;
> @@ -237,6 +239,9 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
>      excp = hppa_get_physical_address(env, addr, mmu_idx,
>                                       a_prot, &phys, &prot);
>      if (unlikely(excp >= 0)) {
> +        if (probe) {
> +            return false;
> +        }
>          trace_hppa_tlb_fill_excp(env, addr, size, type, mmu_idx);
>          /* Failure.  Raise the indicated exception.  */
>          cs->exception_index = excp;
> @@ -253,6 +258,13 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
>      /* Success!  Store the translation into the QEMU TLB.  */
>      tlb_set_page(cs, addr & TARGET_PAGE_MASK, phys & TARGET_PAGE_MASK,
>                   prot, mmu_idx, TARGET_PAGE_SIZE);
> +    return true;
> +}
> +
> +void tlb_fill(CPUState *cs, target_ulong addr, int size,
> +              MMUAccessType type, int mmu_idx, uintptr_t retaddr)
> +{
> +    hppa_cpu_tlb_fill(cs, addr, size, type, mmu_idx, false, retaddr);
>  }
>  
>  /* Insert (Insn/Data) TLB Address.  Note this is PA 1.1 only.  */
> 

