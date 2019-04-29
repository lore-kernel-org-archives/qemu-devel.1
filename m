Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B75C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:21:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1512E20673
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 14:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1512E20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58322 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL7A6-00049J-8M
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 10:21:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL77c-0002du-1R
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:19:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL77Z-0007se-Jy
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:19:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hL77Z-0007rc-B7
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:19:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id f7so7820814wrs.2
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=+7WuYERQPnJ6YeVvaVnA9euxEo8u3wYUETrhfi+LAPw=;
	b=MPOjhntzChFhTioL4NxrVj7BUrmWJxm+7WbbSZhuy/Zpx0lap5et6XNkgu9f0S6U42
	1Nu4u4kvyQjkR9DPsOg+fyFhQwFD3+zNfOwZnXVWMKifrha3YZfnpke2y3n0HBX23zKN
	WV5XUSZcG8pMa6uDzhFuO1jQ4PiLXeAx4a0Mbu5uIuRN7ajuZhN7fwPEKM7mgYZeumfJ
	IPlx2sJMNonvCrK/Nfkqa76olhqFzCR0L4gFjsbsMwboU5QViyU7QaMI6Su9a+QYZ+ve
	glnA/wEmUfOKY7RHAKg66iKGZnOy7jTQTlo/dTLAcA5QxDjKPfK7EoN/xu93i9O9qjZ4
	8jpw==
X-Gm-Message-State: APjAAAVxQizEkHEODZA6JFw4tg9Kblslx6UZ4FHP6i44sxPOlrMDxIPP
	45Xl5fDjXclgN0ToV2l4ewiHx06ReiU=
X-Google-Smtp-Source: APXvYqzkPtaXb21RfcR+wLZFs2HL+36TtIfjhm+qiejTcPnrKLzq1XjFf+ODv+xiZcnWCHFckqd34A==
X-Received: by 2002:adf:b64e:: with SMTP id i14mr18726957wre.72.1556547543474; 
	Mon, 29 Apr 2019 07:19:03 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	c139sm32911892wmd.26.2019.04.29.07.19.02
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 07:19:02 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-25-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <15fa6797-d7bf-09c4-d275-ebc88bfd381b@redhat.com>
Date: Mon, 29 Apr 2019 16:19:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328230404.12909-25-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 24/36] target/sparc: Use env_cpu,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429141902.uWmpRnRHkWQFSip1TICIfXVx2huiQHrThXP1SXChWkk@z>

On 3/29/19 12:03 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/sparc/cpu.h          |  5 -----
>  bsd-user/main.c             |  2 +-
>  hw/sparc/leon3.c            |  4 ++--
>  hw/sparc/sun4m.c            |  4 ++--
>  hw/sparc64/sparc64.c        |  2 +-
>  linux-user/sparc/cpu_loop.c |  2 +-
>  target/sparc/fop_helper.c   |  2 +-
>  target/sparc/helper.c       |  8 ++++----
>  target/sparc/ldst_helper.c  | 33 +++++++++++++++------------------
>  target/sparc/mmu_helper.c   | 10 +++++-----
>  10 files changed, 32 insertions(+), 40 deletions(-)
> 
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index 77dec0d865..bf6f63d029 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -532,11 +532,6 @@ struct SPARCCPU {
>      CPUSPARCState env;
>  };
>  
> -static inline SPARCCPU *sparc_env_get_cpu(CPUSPARCState *env)
> -{
> -    return container_of(env, SPARCCPU, env);
> -}
> -
>  #define ENV_OFFSET offsetof(SPARCCPU, env)
>  
>  #ifndef CONFIG_USER_ONLY
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index e554ebdfb3..7a0eb316a2 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -485,7 +485,7 @@ static void flush_windows(CPUSPARCState *env)
>  
>  void cpu_loop(CPUSPARCState *env)
>  {
> -    CPUState *cs = CPU(sparc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      int trapnr, ret, syscall_nr;
>      //target_siginfo_t info;
>  
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 774639af33..ef74bc81c2 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -91,7 +91,7 @@ static void leon3_set_pil_in(void *opaque, uint32_t pil_in)
>  
>                  env->interrupt_index = TT_EXTINT | i;
>                  if (old_interrupt != env->interrupt_index) {
> -                    cs = CPU(sparc_env_get_cpu(env));
> +                    cs = env_cpu(env);
>                      trace_leon3_set_irq(i);
>                      cpu_interrupt(cs, CPU_INTERRUPT_HARD);
>                  }
> @@ -99,7 +99,7 @@ static void leon3_set_pil_in(void *opaque, uint32_t pil_in)
>              }
>          }
>      } else if (!env->pil_in && (env->interrupt_index & ~15) == TT_EXTINT) {
> -        cs = CPU(sparc_env_get_cpu(env));
> +        cs = env_cpu(env);
>          trace_leon3_reset_irq(env->interrupt_index & 15);
>          env->interrupt_index = 0;
>          cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index ca1e3825d5..a87bef6d4f 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -147,7 +147,7 @@ void cpu_check_irqs(CPUSPARCState *env)
>  
>                  env->interrupt_index = TT_EXTINT | i;
>                  if (old_interrupt != env->interrupt_index) {
> -                    cs = CPU(sparc_env_get_cpu(env));
> +                    cs = env_cpu(env);
>                      trace_sun4m_cpu_interrupt(i);
>                      cpu_interrupt(cs, CPU_INTERRUPT_HARD);
>                  }
> @@ -155,7 +155,7 @@ void cpu_check_irqs(CPUSPARCState *env)
>              }
>          }
>      } else if (!env->pil_in && (env->interrupt_index & ~15) == TT_EXTINT) {
> -        cs = CPU(sparc_env_get_cpu(env));
> +        cs = env_cpu(env);
>          trace_sun4m_cpu_reset_interrupt(env->interrupt_index & 15);
>          env->interrupt_index = 0;
>          cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
> index 408388945e..689801f37d 100644
> --- a/hw/sparc64/sparc64.c
> +++ b/hw/sparc64/sparc64.c
> @@ -46,7 +46,7 @@ void cpu_check_irqs(CPUSPARCState *env)
>      if (env->ivec_status & 0x20) {
>          return;
>      }
> -    cs = CPU(sparc_env_get_cpu(env));
> +    cs = env_cpu(env);
>      /* check if TM or SM in SOFTINT are set
>         setting these also causes interrupt 14 */
>      if (env->softint & (SOFTINT_TIMER | SOFTINT_STIMER)) {
> diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
> index 7d5b337b97..7a4f5792be 100644
> --- a/linux-user/sparc/cpu_loop.c
> +++ b/linux-user/sparc/cpu_loop.c
> @@ -145,7 +145,7 @@ static void flush_windows(CPUSPARCState *env)
>  
>  void cpu_loop (CPUSPARCState *env)
>  {
> -    CPUState *cs = CPU(sparc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      int trapnr;
>      abi_long ret;
>      target_siginfo_t info;
> diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
> index b6642fd1d7..9eb9b75718 100644
> --- a/target/sparc/fop_helper.c
> +++ b/target/sparc/fop_helper.c
> @@ -53,7 +53,7 @@ static target_ulong do_check_ieee_exceptions(CPUSPARCState *env, uintptr_t ra)
>          }
>  
>          if ((fsr & FSR_CEXC_MASK) & ((fsr & FSR_TEM_MASK) >> 23)) {
> -            CPUState *cs = CPU(sparc_env_get_cpu(env));
> +            CPUState *cs = env_cpu(env);
>  
>              /* Unmasked exception, generate a trap.  Note that while
>                 the helper is marked as NO_WG, we can get away with
> diff --git a/target/sparc/helper.c b/target/sparc/helper.c
> index 46232788c8..1a52061fbf 100644
> --- a/target/sparc/helper.c
> +++ b/target/sparc/helper.c
> @@ -26,7 +26,7 @@
>  
>  void cpu_raise_exception_ra(CPUSPARCState *env, int tt, uintptr_t ra)
>  {
> -    CPUState *cs = CPU(sparc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>  
>      cs->exception_index = tt;
>      cpu_loop_exit_restore(cs, ra);
> @@ -34,7 +34,7 @@ void cpu_raise_exception_ra(CPUSPARCState *env, int tt, uintptr_t ra)
>  
>  void helper_raise_exception(CPUSPARCState *env, int tt)
>  {
> -    CPUState *cs = CPU(sparc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>  
>      cs->exception_index = tt;
>      cpu_loop_exit(cs);
> @@ -42,7 +42,7 @@ void helper_raise_exception(CPUSPARCState *env, int tt)
>  
>  void helper_debug(CPUSPARCState *env)
>  {
> -    CPUState *cs = CPU(sparc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>  
>      cs->exception_index = EXCP_DEBUG;
>      cpu_loop_exit(cs);
> @@ -243,7 +243,7 @@ target_ulong helper_tsubcctv(CPUSPARCState *env, target_ulong src1,
>  #ifndef TARGET_SPARC64
>  void helper_power_down(CPUSPARCState *env)
>  {
> -    CPUState *cs = CPU(sparc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>  
>      cs->halted = 1;
>      cs->exception_index = EXCP_HLT;
> diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
> index 5bc090213c..861b420c3e 100644
> --- a/target/sparc/ldst_helper.c
> +++ b/target/sparc/ldst_helper.c
> @@ -122,13 +122,13 @@ static uint64_t ultrasparc_tag_target(uint64_t tag_access_register)
>  
>  static void replace_tlb_entry(SparcTLBEntry *tlb,
>                                uint64_t tlb_tag, uint64_t tlb_tte,
> -                              CPUSPARCState *env1)
> +                              CPUSPARCState *env)
>  {
>      target_ulong mask, size, va, offset;
>  
>      /* flush page range if translation is valid */
>      if (TTE_IS_VALID(tlb->tte)) {
> -        CPUState *cs = CPU(sparc_env_get_cpu(env1));
> +        CPUState *cs = env_cpu(env);
>  
>          size = 8192ULL << 3 * TTE_PGSIZE(tlb->tte);
>          mask = 1ULL + ~size;
> @@ -499,7 +499,7 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
>  {
>      int size = 1 << (memop & MO_SIZE);
>      int sign = memop & MO_SIGN;
> -    CPUState *cs = CPU(sparc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      uint64_t ret = 0;
>  #if defined(DEBUG_MXCC) || defined(DEBUG_ASI)
>      uint32_t last_addr = addr;
> @@ -725,8 +725,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
>                     int asi, uint32_t memop)
>  {
>      int size = 1 << (memop & MO_SIZE);
> -    SPARCCPU *cpu = sparc_env_get_cpu(env);
> -    CPUState *cs = CPU(cpu);
> +    CPUState *cs = env_cpu(env);
>  
>      do_check_align(env, addr, size - 1, GETPC());
>      switch (asi) {
> @@ -874,13 +873,13 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
>              DPRINTF_MMU("mmu flush level %d\n", mmulev);
>              switch (mmulev) {
>              case 0: /* flush page */
> -                tlb_flush_page(CPU(cpu), addr & 0xfffff000);
> +                tlb_flush_page(cs, addr & 0xfffff000);
>                  break;
>              case 1: /* flush segment (256k) */
>              case 2: /* flush region (16M) */
>              case 3: /* flush context (4G) */
>              case 4: /* flush entire */
> -                tlb_flush(CPU(cpu));
> +                tlb_flush(cs);
>                  break;
>              default:
>                  break;
> @@ -905,7 +904,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
>                     are invalid in normal mode.  */
>                  if ((oldreg ^ env->mmuregs[reg])
>                      & (MMU_NF | env->def.mmu_bm)) {
> -                    tlb_flush(CPU(cpu));
> +                    tlb_flush(cs);
>                  }
>                  break;
>              case 1: /* Context Table Pointer Register */
> @@ -916,7 +915,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
>                  if (oldreg != env->mmuregs[reg]) {
>                      /* we flush when the MMU context changes because
>                         QEMU has no MMU context support */
> -                    tlb_flush(CPU(cpu));
> +                    tlb_flush(cs);
>                  }
>                  break;
>              case 3: /* Synchronous Fault Status Register with Clear */
> @@ -1027,8 +1026,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
>      case ASI_USERTXT: /* User code access, XXX */
>      case ASI_KERNELTXT: /* Supervisor code access, XXX */
>      default:
> -        cpu_unassigned_access(CPU(sparc_env_get_cpu(env)),
> -                              addr, true, false, asi, size);
> +        cpu_unassigned_access(cs, addr, true, false, asi, size);
>          break;
>  
>      case ASI_USERDATA: /* User data access */
> @@ -1175,7 +1173,7 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
>  {
>      int size = 1 << (memop & MO_SIZE);
>      int sign = memop & MO_SIGN;
> -    CPUState *cs = CPU(sparc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      uint64_t ret = 0;
>  #if defined(DEBUG_ASI)
>      target_ulong last_addr = addr;
> @@ -1481,8 +1479,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
>                     int asi, uint32_t memop)
>  {
>      int size = 1 << (memop & MO_SIZE);
> -    SPARCCPU *cpu = sparc_env_get_cpu(env);
> -    CPUState *cs = CPU(cpu);
> +    CPUState *cs = env_cpu(env);
>  
>  #ifdef DEBUG_ASI
>      dump_asi("write", addr, asi, size, val);
> @@ -1686,13 +1683,13 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
>                  env->dmmu.mmu_primary_context = val;
>                  /* can be optimized to only flush MMU_USER_IDX
>                     and MMU_KERNEL_IDX entries */
> -                tlb_flush(CPU(cpu));
> +                tlb_flush(cs);
>                  break;
>              case 2: /* Secondary context */
>                  env->dmmu.mmu_secondary_context = val;
>                  /* can be optimized to only flush MMU_USER_SECONDARY_IDX
>                     and MMU_KERNEL_SECONDARY_IDX entries */
> -                tlb_flush(CPU(cpu));
> +                tlb_flush(cs);
>                  break;
>              case 5: /* TSB access */
>                  DPRINTF_MMU("dmmu TSB write: 0x%016" PRIx64 " -> 0x%016"
> @@ -1768,13 +1765,13 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
>            case 1:
>                env->dmmu.mmu_primary_context = val;
>                env->immu.mmu_primary_context = val;
> -              tlb_flush_by_mmuidx(CPU(cpu),
> +              tlb_flush_by_mmuidx(cs,
>                                    (1 << MMU_USER_IDX) | (1 << MMU_KERNEL_IDX));
>                break;
>            case 2:
>                env->dmmu.mmu_secondary_context = val;
>                env->immu.mmu_secondary_context = val;
> -              tlb_flush_by_mmuidx(CPU(cpu),
> +              tlb_flush_by_mmuidx(cs,
>                                    (1 << MMU_USER_SECONDARY_IDX) |
>                                    (1 << MMU_KERNEL_SECONDARY_IDX));
>                break;
> diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
> index 135a9c9d9b..0366c26246 100644
> --- a/target/sparc/mmu_helper.c
> +++ b/target/sparc/mmu_helper.c
> @@ -95,7 +95,7 @@ static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
>      uint32_t pde;
>      int error_code = 0, is_dirty, is_user;
>      unsigned long page_offset;
> -    CPUState *cs = CPU(sparc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>  
>      is_user = mmu_idx == MMU_USER_IDX;
>  
> @@ -255,7 +255,7 @@ int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
>  
>  target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev)
>  {
> -    CPUState *cs = CPU(sparc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      hwaddr pde_ptr;
>      uint32_t pde;
>  
> @@ -322,7 +322,7 @@ target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev)
>  
>  void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUSPARCState *env)
>  {
> -    CPUState *cs = CPU(sparc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      target_ulong va, va1, va2;
>      unsigned int n, m, o;
>      hwaddr pde_ptr, pa;
> @@ -481,7 +481,7 @@ static int get_physical_address_data(CPUSPARCState *env,
>                                       hwaddr *physical, int *prot,
>                                       target_ulong address, int rw, int mmu_idx)
>  {
> -    CPUState *cs = CPU(sparc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      unsigned int i;
>      uint64_t context;
>      uint64_t sfsr = 0;
> @@ -599,7 +599,7 @@ static int get_physical_address_code(CPUSPARCState *env,
>                                       hwaddr *physical, int *prot,
>                                       target_ulong address, int mmu_idx)
>  {
> -    CPUState *cs = CPU(sparc_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      unsigned int i;
>      uint64_t context;
>      bool is_user = false;
> 

