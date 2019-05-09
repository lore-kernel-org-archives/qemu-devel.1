Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E86AC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 20:19:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17CAA2177B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 20:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/G+Lm7U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17CAA2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60443 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOpVW-0007Om-9u
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 16:19:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOpTx-0006bU-D3
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOpTv-0007Pg-Ka
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:17:33 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:40225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOpTv-0007OU-9P
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:17:31 -0400
Received: by mail-lj1-x244.google.com with SMTP id d15so3145568ljc.7
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 13:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=SIqytqmZMPdvfIcZQslNfPEx6UPIyV8dmU1cCThXGRs=;
	b=g/G+Lm7UA308fRU85bphKNEFIKLkrt1ptcvfZuX470u7paHsII1Y9tWhyOs8xom3KT
	OHHY+AxnV8QnvacRe7QngmKgheC9R7HfiEzEz8niTBHu69KXrPWck5qvpTEDbCtUyoBT
	2LV8biwjdemxXGb8umibXfb5uffYD9I508udIyJid2S4GqW50W6Sbewniyf5fp9RFeAG
	bjeLC9bL1OrAZ2smC4oeRD6AjVodsq7zPqyQP6f9iDLH/IscBENZIJzX2LS0WV4l+s4p
	bNg2isJfJB9G1RNegCSTtVmOfe2LAifSEwtOf3FBXFXsLSGpKF7+OCLEpuOiFQTPFa2y
	7M2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=SIqytqmZMPdvfIcZQslNfPEx6UPIyV8dmU1cCThXGRs=;
	b=jyXdIn+IHWk8IQ45FwmH73/NFXFQJyXSL1XeHEG06bQdqYgJlXBSkYnhSINJOwg+sN
	JsLPkAPB7xSA6MPY/v3sdNkA/OR8hpzg7GWxHi4O8RVEbk0YH1o4MW04LMiI2QJkYr1s
	I+CTxJZha3gAfKJrCnowjByd+wTri89p2WuQuiFQp9VSzZ77W92ziWTc24WDFP7SeRNw
	ti8KXwMhQlUxJzRGoj9Y5lEsLvIrdua9VdWuXTikZ2LQU4N+9to95poIwojeRs7ytx/L
	J9fu2mwPYriTz9LoeaTUqXAUwfJM3g8QDZK2UYzyjEMZFrbw++d3NhR8WQ3dyDbRnJuA
	A7jA==
X-Gm-Message-State: APjAAAXWd0l8+KIgSs4P0afQkClHGfFYt9t8kzI9PXSYRiZ5WqBybS9g
	JPChl1uJ525YwlOVlP7eMU71E6AqwKhHWiTxtrNILjP4
X-Google-Smtp-Source: APXvYqwYaF5fcxYkz/uLHvmDpTMt+z1LJer0zhXEhS/1W6dJWveQnaxS+0lDe7wfQFfkB644LZHX5XEMNBxM9oOLGLk=
X-Received: by 2002:a2e:9c89:: with SMTP id x9mr3462834lji.28.1557433049998;
	Thu, 09 May 2019 13:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-27-richard.henderson@linaro.org>
In-Reply-To: <20190508000641.19090-27-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 May 2019 13:15:23 -0700
Message-ID: <CAKmqyKPqdkB2UqrdHem0phw6b91X_t3YFH8siXdpgAskYUp=9w@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v3 26/39] target/sparc: Use env_cpu,
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 7, 2019 at 5:25 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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
> index 5a10680d8f..1442232cef 100644
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
> index bfdcae4269..f6f76f1a64 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -486,7 +486,7 @@ static void flush_windows(CPUSPARCState *env)
>
>  void cpu_loop(CPUSPARCState *env)
>  {
> -    CPUState *cs =3D CPU(sparc_env_get_cpu(env));
> +    CPUState *cs =3D env_cpu(env);
>      int trapnr, ret, syscall_nr;
>      //target_siginfo_t info;
>
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 774639af33..ef74bc81c2 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -91,7 +91,7 @@ static void leon3_set_pil_in(void *opaque, uint32_t pil=
_in)
>
>                  env->interrupt_index =3D TT_EXTINT | i;
>                  if (old_interrupt !=3D env->interrupt_index) {
> -                    cs =3D CPU(sparc_env_get_cpu(env));
> +                    cs =3D env_cpu(env);
>                      trace_leon3_set_irq(i);
>                      cpu_interrupt(cs, CPU_INTERRUPT_HARD);
>                  }
> @@ -99,7 +99,7 @@ static void leon3_set_pil_in(void *opaque, uint32_t pil=
_in)
>              }
>          }
>      } else if (!env->pil_in && (env->interrupt_index & ~15) =3D=3D TT_EX=
TINT) {
> -        cs =3D CPU(sparc_env_get_cpu(env));
> +        cs =3D env_cpu(env);
>          trace_leon3_reset_irq(env->interrupt_index & 15);
>          env->interrupt_index =3D 0;
>          cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index ca1e3825d5..a87bef6d4f 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -147,7 +147,7 @@ void cpu_check_irqs(CPUSPARCState *env)
>
>                  env->interrupt_index =3D TT_EXTINT | i;
>                  if (old_interrupt !=3D env->interrupt_index) {
> -                    cs =3D CPU(sparc_env_get_cpu(env));
> +                    cs =3D env_cpu(env);
>                      trace_sun4m_cpu_interrupt(i);
>                      cpu_interrupt(cs, CPU_INTERRUPT_HARD);
>                  }
> @@ -155,7 +155,7 @@ void cpu_check_irqs(CPUSPARCState *env)
>              }
>          }
>      } else if (!env->pil_in && (env->interrupt_index & ~15) =3D=3D TT_EX=
TINT) {
> -        cs =3D CPU(sparc_env_get_cpu(env));
> +        cs =3D env_cpu(env);
>          trace_sun4m_cpu_reset_interrupt(env->interrupt_index & 15);
>          env->interrupt_index =3D 0;
>          cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
> index 408388945e..689801f37d 100644
> --- a/hw/sparc64/sparc64.c
> +++ b/hw/sparc64/sparc64.c
> @@ -46,7 +46,7 @@ void cpu_check_irqs(CPUSPARCState *env)
>      if (env->ivec_status & 0x20) {
>          return;
>      }
> -    cs =3D CPU(sparc_env_get_cpu(env));
> +    cs =3D env_cpu(env);
>      /* check if TM or SM in SOFTINT are set
>         setting these also causes interrupt 14 */
>      if (env->softint & (SOFTINT_TIMER | SOFTINT_STIMER)) {
> diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
> index 9e357229c0..d85359037c 100644
> --- a/linux-user/sparc/cpu_loop.c
> +++ b/linux-user/sparc/cpu_loop.c
> @@ -145,7 +145,7 @@ static void flush_windows(CPUSPARCState *env)
>
>  void cpu_loop (CPUSPARCState *env)
>  {
> -    CPUState *cs =3D CPU(sparc_env_get_cpu(env));
> +    CPUState *cs =3D env_cpu(env);
>      int trapnr;
>      abi_long ret;
>      target_siginfo_t info;
> diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
> index b6642fd1d7..9eb9b75718 100644
> --- a/target/sparc/fop_helper.c
> +++ b/target/sparc/fop_helper.c
> @@ -53,7 +53,7 @@ static target_ulong do_check_ieee_exceptions(CPUSPARCSt=
ate *env, uintptr_t ra)
>          }
>
>          if ((fsr & FSR_CEXC_MASK) & ((fsr & FSR_TEM_MASK) >> 23)) {
> -            CPUState *cs =3D CPU(sparc_env_get_cpu(env));
> +            CPUState *cs =3D env_cpu(env);
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
> -    CPUState *cs =3D CPU(sparc_env_get_cpu(env));
> +    CPUState *cs =3D env_cpu(env);
>
>      cs->exception_index =3D tt;
>      cpu_loop_exit_restore(cs, ra);
> @@ -34,7 +34,7 @@ void cpu_raise_exception_ra(CPUSPARCState *env, int tt,=
 uintptr_t ra)
>
>  void helper_raise_exception(CPUSPARCState *env, int tt)
>  {
> -    CPUState *cs =3D CPU(sparc_env_get_cpu(env));
> +    CPUState *cs =3D env_cpu(env);
>
>      cs->exception_index =3D tt;
>      cpu_loop_exit(cs);
> @@ -42,7 +42,7 @@ void helper_raise_exception(CPUSPARCState *env, int tt)
>
>  void helper_debug(CPUSPARCState *env)
>  {
> -    CPUState *cs =3D CPU(sparc_env_get_cpu(env));
> +    CPUState *cs =3D env_cpu(env);
>
>      cs->exception_index =3D EXCP_DEBUG;
>      cpu_loop_exit(cs);
> @@ -243,7 +243,7 @@ target_ulong helper_tsubcctv(CPUSPARCState *env, targ=
et_ulong src1,
>  #ifndef TARGET_SPARC64
>  void helper_power_down(CPUSPARCState *env)
>  {
> -    CPUState *cs =3D CPU(sparc_env_get_cpu(env));
> +    CPUState *cs =3D env_cpu(env);
>
>      cs->halted =3D 1;
>      cs->exception_index =3D EXCP_HLT;
> diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
> index a7fcb84ac0..a2d033a61f 100644
> --- a/target/sparc/ldst_helper.c
> +++ b/target/sparc/ldst_helper.c
> @@ -122,13 +122,13 @@ static uint64_t ultrasparc_tag_target(uint64_t tag_=
access_register)
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
> -        CPUState *cs =3D CPU(sparc_env_get_cpu(env1));
> +        CPUState *cs =3D env_cpu(env);
>
>          size =3D 8192ULL << 3 * TTE_PGSIZE(tlb->tte);
>          mask =3D 1ULL + ~size;
> @@ -499,7 +499,7 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulo=
ng addr,
>  {
>      int size =3D 1 << (memop & MO_SIZE);
>      int sign =3D memop & MO_SIGN;
> -    CPUState *cs =3D CPU(sparc_env_get_cpu(env));
> +    CPUState *cs =3D env_cpu(env);
>      uint64_t ret =3D 0;
>  #if defined(DEBUG_MXCC) || defined(DEBUG_ASI)
>      uint32_t last_addr =3D addr;
> @@ -725,8 +725,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong a=
ddr, uint64_t val,
>                     int asi, uint32_t memop)
>  {
>      int size =3D 1 << (memop & MO_SIZE);
> -    SPARCCPU *cpu =3D sparc_env_get_cpu(env);
> -    CPUState *cs =3D CPU(cpu);
> +    CPUState *cs =3D env_cpu(env);
>
>      do_check_align(env, addr, size - 1, GETPC());
>      switch (asi) {
> @@ -874,13 +873,13 @@ void helper_st_asi(CPUSPARCState *env, target_ulong=
 addr, uint64_t val,
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
> @@ -905,7 +904,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong a=
ddr, uint64_t val,
>                     are invalid in normal mode.  */
>                  if ((oldreg ^ env->mmuregs[reg])
>                      & (MMU_NF | env->def.mmu_bm)) {
> -                    tlb_flush(CPU(cpu));
> +                    tlb_flush(cs);
>                  }
>                  break;
>              case 1: /* Context Table Pointer Register */
> @@ -916,7 +915,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong a=
ddr, uint64_t val,
>                  if (oldreg !=3D env->mmuregs[reg]) {
>                      /* we flush when the MMU context changes because
>                         QEMU has no MMU context support */
> -                    tlb_flush(CPU(cpu));
> +                    tlb_flush(cs);
>                  }
>                  break;
>              case 3: /* Synchronous Fault Status Register with Clear */
> @@ -1027,8 +1026,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong=
 addr, uint64_t val,
>      case ASI_USERTXT: /* User code access, XXX */
>      case ASI_KERNELTXT: /* Supervisor code access, XXX */
>      default:
> -        cpu_unassigned_access(CPU(sparc_env_get_cpu(env)),
> -                              addr, true, false, asi, size);
> +        cpu_unassigned_access(cs, addr, true, false, asi, size);
>          break;
>
>      case ASI_USERDATA: /* User data access */
> @@ -1175,7 +1173,7 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_u=
long addr,
>  {
>      int size =3D 1 << (memop & MO_SIZE);
>      int sign =3D memop & MO_SIGN;
> -    CPUState *cs =3D CPU(sparc_env_get_cpu(env));
> +    CPUState *cs =3D env_cpu(env);
>      uint64_t ret =3D 0;
>  #if defined(DEBUG_ASI)
>      target_ulong last_addr =3D addr;
> @@ -1481,8 +1479,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong=
 addr, target_ulong val,
>                     int asi, uint32_t memop)
>  {
>      int size =3D 1 << (memop & MO_SIZE);
> -    SPARCCPU *cpu =3D sparc_env_get_cpu(env);
> -    CPUState *cs =3D CPU(cpu);
> +    CPUState *cs =3D env_cpu(env);
>
>  #ifdef DEBUG_ASI
>      dump_asi("write", addr, asi, size, val);
> @@ -1686,13 +1683,13 @@ void helper_st_asi(CPUSPARCState *env, target_ulo=
ng addr, target_ulong val,
>                  env->dmmu.mmu_primary_context =3D val;
>                  /* can be optimized to only flush MMU_USER_IDX
>                     and MMU_KERNEL_IDX entries */
> -                tlb_flush(CPU(cpu));
> +                tlb_flush(cs);
>                  break;
>              case 2: /* Secondary context */
>                  env->dmmu.mmu_secondary_context =3D val;
>                  /* can be optimized to only flush MMU_USER_SECONDARY_IDX
>                     and MMU_KERNEL_SECONDARY_IDX entries */
> -                tlb_flush(CPU(cpu));
> +                tlb_flush(cs);
>                  break;
>              case 5: /* TSB access */
>                  DPRINTF_MMU("dmmu TSB write: 0x%016" PRIx64 " -> 0x%016"
> @@ -1768,13 +1765,13 @@ void helper_st_asi(CPUSPARCState *env, target_ulo=
ng addr, target_ulong val,
>            case 1:
>                env->dmmu.mmu_primary_context =3D val;
>                env->immu.mmu_primary_context =3D val;
> -              tlb_flush_by_mmuidx(CPU(cpu),
> +              tlb_flush_by_mmuidx(cs,
>                                    (1 << MMU_USER_IDX) | (1 << MMU_KERNEL=
_IDX));
>                break;
>            case 2:
>                env->dmmu.mmu_secondary_context =3D val;
>                env->immu.mmu_secondary_context =3D val;
> -              tlb_flush_by_mmuidx(CPU(cpu),
> +              tlb_flush_by_mmuidx(cs,
>                                    (1 << MMU_USER_SECONDARY_IDX) |
>                                    (1 << MMU_KERNEL_SECONDARY_IDX));
>                break;
> diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
> index afcc5b617d..2cfcb6a976 100644
> --- a/target/sparc/mmu_helper.c
> +++ b/target/sparc/mmu_helper.c
> @@ -96,7 +96,7 @@ static int get_physical_address(CPUSPARCState *env, hwa=
ddr *physical,
>      uint32_t pde;
>      int error_code =3D 0, is_dirty, is_user;
>      unsigned long page_offset;
> -    CPUState *cs =3D CPU(sparc_env_get_cpu(env));
> +    CPUState *cs =3D env_cpu(env);
>
>      is_user =3D mmu_idx =3D=3D MMU_USER_IDX;
>
> @@ -256,7 +256,7 @@ int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr ad=
dress, int size, int rw,
>
>  target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmu=
lev)
>  {
> -    CPUState *cs =3D CPU(sparc_env_get_cpu(env));
> +    CPUState *cs =3D env_cpu(env);
>      hwaddr pde_ptr;
>      uint32_t pde;
>
> @@ -323,7 +323,7 @@ target_ulong mmu_probe(CPUSPARCState *env, target_ulo=
ng address, int mmulev)
>
>  void dump_mmu(CPUSPARCState *env)
>  {
> -    CPUState *cs =3D CPU(sparc_env_get_cpu(env));
> +    CPUState *cs =3D env_cpu(env);
>      target_ulong va, va1, va2;
>      unsigned int n, m, o;
>      hwaddr pde_ptr, pa;
> @@ -482,7 +482,7 @@ static int get_physical_address_data(CPUSPARCState *e=
nv,
>                                       hwaddr *physical, int *prot,
>                                       target_ulong address, int rw, int m=
mu_idx)
>  {
> -    CPUState *cs =3D CPU(sparc_env_get_cpu(env));
> +    CPUState *cs =3D env_cpu(env);
>      unsigned int i;
>      uint64_t context;
>      uint64_t sfsr =3D 0;
> @@ -600,7 +600,7 @@ static int get_physical_address_code(CPUSPARCState *e=
nv,
>                                       hwaddr *physical, int *prot,
>                                       target_ulong address, int mmu_idx)
>  {
> -    CPUState *cs =3D CPU(sparc_env_get_cpu(env));
> +    CPUState *cs =3D env_cpu(env);
>      unsigned int i;
>      uint64_t context;
>      bool is_user =3D false;
> --
> 2.17.1
>
>

