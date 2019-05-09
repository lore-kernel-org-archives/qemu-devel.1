Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2325AC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 07:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBBF7208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 07:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBBF7208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49386 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOd8F-0007b4-1L
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 03:06:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hOd6j-0006o5-8v
	for qemu-devel@nongnu.org; Thu, 09 May 2019 03:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hOd6h-0005g5-OF
	for qemu-devel@nongnu.org; Thu, 09 May 2019 03:04:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55103)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hOd6b-0005X0-Ux; Thu, 09 May 2019 03:04:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7835281224;
	Thu,  9 May 2019 07:04:34 +0000 (UTC)
Received: from [10.36.117.56] (ovpn-117-56.ams2.redhat.com [10.36.117.56])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 512ED60C98;
	Thu,  9 May 2019 07:04:33 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190509060246.4031-1-richard.henderson@linaro.org>
	<20190509060246.4031-19-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
	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
	SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <4c37dc44-00ab-369a-fd06-97a77cf34984@redhat.com>
Date: Thu, 9 May 2019 09:04:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509060246.4031-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Thu, 09 May 2019 07:04:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 18/27] target/s390x: Convert to
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09.05.19 08:02, Richard Henderson wrote:
> Cc: qemu-s390x@nongnu.org
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Keep user-only and system tlb_fill separate.
> ---
>  target/s390x/internal.h    |  5 +--
>  target/s390x/cpu.c         |  5 ++-
>  target/s390x/excp_helper.c | 73 ++++++++++++++++++++++++++------------
>  target/s390x/mem_helper.c  | 16 ---------
>  4 files changed, 55 insertions(+), 44 deletions(-)
> 
> diff --git a/target/s390x/internal.h b/target/s390x/internal.h
> index 26575f2130..56534b38e0 100644
> --- a/target/s390x/internal.h
> +++ b/target/s390x/internal.h
> @@ -263,8 +263,9 @@ ObjectClass *s390_cpu_class_by_name(const char *name);
>  void s390x_cpu_debug_excp_handler(CPUState *cs);
>  void s390_cpu_do_interrupt(CPUState *cpu);
>  bool s390_cpu_exec_interrupt(CPUState *cpu, int int_req);
> -int s390_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
> -                              int mmu_idx);
> +bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                       MMUAccessType access_type, int mmu_idx,
> +                       bool probe, uintptr_t retaddr);
>  void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>                                     MMUAccessType access_type,
>                                     int mmu_idx, uintptr_t retaddr);
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index b58ef0a8ef..e28939032b 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -478,9 +478,8 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
>      cc->set_pc = s390_cpu_set_pc;
>      cc->gdb_read_register = s390_cpu_gdb_read_register;
>      cc->gdb_write_register = s390_cpu_gdb_write_register;
> -#ifdef CONFIG_USER_ONLY
> -    cc->handle_mmu_fault = s390_cpu_handle_mmu_fault;
> -#else
> +    cc->tlb_fill = s390_cpu_tlb_fill;
> +#ifndef CONFIG_USER_ONLY
>      cc->get_phys_page_debug = s390_cpu_get_phys_page_debug;
>      cc->vmsd = &vmstate_s390_cpu;
>      cc->write_elf64_note = s390_cpu_write_elf64_note;
> diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
> index f84bfb1284..a4e134bcab 100644
> --- a/target/s390x/excp_helper.c
> +++ b/target/s390x/excp_helper.c
> @@ -74,8 +74,9 @@ void s390_cpu_do_interrupt(CPUState *cs)
>      cs->exception_index = -1;
>  }
>  
> -int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
> -                              int rw, int mmu_idx)
> +bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                       MMUAccessType access_type, int mmu_idx,
> +                       bool probe, uintptr_t retaddr)
>  {
>      S390CPU *cpu = S390_CPU(cs);
>  
> @@ -83,7 +84,7 @@ int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
>      /* On real machines this value is dropped into LowMem.  Since this
>         is userland, simply put this someplace that cpu_loop can find it.  */
>      cpu->env.__excp_addr = address;
> -    return 1;
> +    cpu_loop_exit_restore(cs, retaddr);
>  }
>  
>  #else /* !CONFIG_USER_ONLY */
> @@ -102,19 +103,20 @@ static inline uint64_t cpu_mmu_idx_to_asc(int mmu_idx)
>      }
>  }
>  
> -int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr orig_vaddr, int size,
> -                              int rw, int mmu_idx)
> +bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                       MMUAccessType access_type, int mmu_idx,
> +                       bool probe, uintptr_t retaddr)
>  {
>      S390CPU *cpu = S390_CPU(cs);
>      CPUS390XState *env = &cpu->env;
>      target_ulong vaddr, raddr;
>      uint64_t asc;
> -    int prot;
> +    int prot, fail;
>  
>      qemu_log_mask(CPU_LOG_MMU, "%s: addr 0x%" VADDR_PRIx " rw %d mmu_idx %d\n",
> -                  __func__, orig_vaddr, rw, mmu_idx);
> +                  __func__, address, access_type, mmu_idx);
>  
> -    vaddr = orig_vaddr;
> +    vaddr = address;
>  
>      if (mmu_idx < MMU_REAL_IDX) {
>          asc = cpu_mmu_idx_to_asc(mmu_idx);
> @@ -122,39 +124,64 @@ int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr orig_vaddr, int size,
>          if (!(env->psw.mask & PSW_MASK_64)) {
>              vaddr &= 0x7fffffff;
>          }
> -        if (mmu_translate(env, vaddr, rw, asc, &raddr, &prot, true)) {
> -            return 1;
> -        }
> +        fail = mmu_translate(env, vaddr, access_type, asc, &raddr, &prot, true);
>      } else if (mmu_idx == MMU_REAL_IDX) {
>          /* 31-Bit mode */
>          if (!(env->psw.mask & PSW_MASK_64)) {
>              vaddr &= 0x7fffffff;
>          }
> -        if (mmu_translate_real(env, vaddr, rw, &raddr, &prot)) {
> -            return 1;
> -        }
> +        fail = mmu_translate_real(env, vaddr, access_type, &raddr, &prot);
>      } else {
> -        abort();
> +        g_assert_not_reached();
>      }
>  
>      /* check out of RAM access */
> -    if (!address_space_access_valid(&address_space_memory, raddr,
> -                                    TARGET_PAGE_SIZE, rw,
> +    if (!fail &&
> +        !address_space_access_valid(&address_space_memory, raddr,
> +                                    TARGET_PAGE_SIZE, access_type,
>                                      MEMTXATTRS_UNSPECIFIED)) {
>          qemu_log_mask(CPU_LOG_MMU,
>                        "%s: raddr %" PRIx64 " > ram_size %" PRIx64 "\n",
>                        __func__, (uint64_t)raddr, (uint64_t)ram_size);
>          trigger_pgm_exception(env, PGM_ADDRESSING, ILEN_AUTO);
> -        return 1;
> +        fail = 1;
>      }
>  
> -    qemu_log_mask(CPU_LOG_MMU, "%s: set tlb %" PRIx64 " -> %" PRIx64 " (%x)\n",
> -            __func__, (uint64_t)vaddr, (uint64_t)raddr, prot);
> +    if (!fail) {
> +        qemu_log_mask(CPU_LOG_MMU,
> +                      "%s: set tlb %" PRIx64 " -> %" PRIx64 " (%x)\n",
> +                      __func__, (uint64_t)vaddr, (uint64_t)raddr, prot);
> +        tlb_set_page(cs, address & TARGET_PAGE_MASK, raddr, prot,
> +                     mmu_idx, TARGET_PAGE_SIZE);
> +        return true;
> +    }
> +    if (probe) {
> +        return false;
> +    }
>  
> -    tlb_set_page(cs, orig_vaddr & TARGET_PAGE_MASK, raddr, prot,
> -                 mmu_idx, TARGET_PAGE_SIZE);
> +    cpu_restore_state(cs, retaddr, true);
>  
> -    return 0;
> +    /*
> +     * The ILC value for code accesses is undefined.  The important
> +     * thing here is to *not* leave env->int_pgm_ilen set to ILEN_AUTO,
> +     * which would cause do_program_interrupt to attempt to read from
> +     * env->psw.addr again.  C.f. the condition in trigger_page_fault,
> +     * but is not universally applied.
> +     *
> +     * ??? If we remove ILEN_AUTO, by moving the computation of ILEN
> +     * into cpu_restore_state, then we may remove this entirely.
> +     */
> +    if (access_type == MMU_INST_FETCH) {
> +        env->int_pgm_ilen = 2;
> +    }
> +
> +    cpu_loop_exit(cs);
> +}
> +
> +void tlb_fill(CPUState *cs, target_ulong addr, int size,
> +              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
> +{
> +    s390_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
>  }
>  
>  static void do_program_interrupt(CPUS390XState *env)
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 3f76a8abfd..ffd5f02fbe 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -33,22 +33,6 @@
>  
>  /*****************************************************************************/
>  /* Softmmu support */
> -#if !defined(CONFIG_USER_ONLY)
> -
> -/* try to fill the TLB and return an exception if error. If retaddr is
> -   NULL, it means that the function was called in C code (i.e. not
> -   from generated code or from helper.c) */
> -/* XXX: fix it to restore all registers */
> -void tlb_fill(CPUState *cs, target_ulong addr, int size,
> -              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
> -{
> -    int ret = s390_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
> -    if (unlikely(ret != 0)) {
> -        cpu_loop_exit_restore(cs, retaddr);
> -    }
> -}
> -
> -#endif
>  
>  /* #define DEBUG_HELPER */
>  #ifdef DEBUG_HELPER
> 


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

