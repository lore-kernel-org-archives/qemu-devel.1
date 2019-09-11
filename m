Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6740DECDE28
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:27:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 268F32168B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268F32168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7xxx-0001Cu-Mt
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 04:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7xva-0007H2-6w
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7xvX-0006KS-QV
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:24:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34401)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7xvX-0006KE-JU
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:24:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id y135so1611529wmc.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 01:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=fbsDRv6IKEhUUnch1meN3uGim1gBi/qa6I8FRQ87f8M=;
 b=VQD+37UeURZIyI08hwyVT8pwrt/YlzNGaUUmQMPFQTZbxM8reHi5I3Y8cFzwqevdXr
 hbPC090KB8G4M48LFR0Sj1wsBVwUYganI2mB/S5rsUUATWZd2fQv1BPE9nY08TwOrMlX
 /DmJouGiuuvc/Z4O0Xs7tchyJ840lMgQNJJisDRmDpEL01ZjUvYKOWoF56JRHDfMQAlk
 8Qr+DmZmktpKRsb77iEeClRP1MUL5UjDtRD6vw+KN1BbWfyqzEbaEIk6PfnEFnBn+QnC
 4wNep2576zaHCozMIGTEXb12XgPTWsa/nsc/66R1anF5q6utsalLfXVr3OarODa9ms8m
 8/6Q==
X-Gm-Message-State: APjAAAUBQMFQK2EZkPTF09NaCH27LxTJdyvdMsNSH+HLtciv11V6edGx
 WM43nWDZWC8lmGPbm0n2JF36m9y8EPrHaA==
X-Google-Smtp-Source: APXvYqy5pP23OsNzs+DkQBl1QOAGGy0rvlVWgHovoRxjA7vUuoM6+lICkXlTJoh4dweAQxgtzLMiog==
X-Received: by 2002:a7b:c8c6:: with SMTP id f6mr2793758wml.75.1568190273517;
 Wed, 11 Sep 2019 01:24:33 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id e20sm40116799wrc.34.2019.09.11.01.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 01:24:32 -0700 (PDT)
Date: Wed, 11 Sep 2019 01:24:32 -0700 (PDT)
X-Google-Original-Date: Tue, 10 Sep 2019 07:50:24 PDT (-0700)
In-Reply-To: <850360df8fc15a3671bf2237f972ebaf09110015.1566603412.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-b813f03d-c23e-405a-8213-c4c9b22a6831@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v1 10/28] target/riscv: Convert mie and
 mstatus to pointers
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
Cc: qemu-riscv@nongnu.org, Anup Patel <Anup.Patel@wdc.com>,
 qemu-devel@nongnu.org, Atish Patra <Atish.Patra@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Aug 2019 16:38:15 PDT (-0700), Alistair Francis wrote:
> To handle the new Hypervisor CSR register swapping let's use pointers.
>
> We only need to convert the MIE and MSTATUS CSRs. With the exception of
> MIP all of the other CSRs that swap with virtulsation changes are S-Mode
> only, so we can just do a lazy switch. This because more challenging for
> the M-Mode registers so it ends up being easier to use pointers.
>
> As the MIP CSR is always accessed atomicly the pointer swap doesn't work
> so we leave that as is.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c        | 16 ++++++++++++----
>  target/riscv/cpu.h        | 12 ++++++++++--
>  target/riscv/cpu_helper.c | 32 ++++++++++++++++----------------
>  target/riscv/csr.c        | 28 ++++++++++++++--------------
>  target/riscv/op_helper.c  | 14 +++++++-------
>  5 files changed, 59 insertions(+), 43 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index be8f643fc2..371d5845af 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -228,7 +228,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "pc      ", env->pc);
>  #ifndef CONFIG_USER_ONLY
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
> -    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
> +    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", *env->mstatus);
>      if (riscv_has_ext(env, RVH)) {
>          qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "hstatus ", env->hstatus);
>          qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "bstatus ", env->vsstatus);
> @@ -239,7 +239,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>          qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsip    ",
>                       (target_ulong)atomic_read(&env->vsip));
>      }
> -    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mie     ", env->mie);
> +    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mie     ", *env->mie);
>      if (riscv_has_ext(env, RVH)) {
>          qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsie    ", env->vsie);
>      }
> @@ -309,7 +309,7 @@ static bool riscv_cpu_has_work(CPUState *cs)
>       * Definition of the WFI instruction requires it to ignore the privilege
>       * mode and delegation registers, but respect individual enables
>       */
> -    return (atomic_read(&env->mip) & env->mie) != 0;
> +    return (atomic_read(&env->mip) & *env->mie) != 0;
>  #else
>      return true;
>  #endif
> @@ -330,7 +330,7 @@ static void riscv_cpu_reset(CPUState *cs)
>      mcc->parent_reset(cs);
>  #ifndef CONFIG_USER_ONLY
>      env->priv = PRV_M;
> -    env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
> +    *env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
>      env->mcause = 0;
>      env->pc = env->resetvec;
>  #endif
> @@ -459,8 +459,16 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>  static void riscv_cpu_init(Object *obj)
>  {
>      RISCVCPU *cpu = RISCV_CPU(obj);
> +#ifndef CONFIG_USER_ONLY
> +    CPURISCVState *env = &cpu->env;
> +#endif
>
>      cpu_set_cpustate_pointers(cpu);
> +
> +#ifndef CONFIG_USER_ONLY
> +    env->mie = &env->mie_novirt;
> +    env->mstatus = &env->mstatus_novirt;
> +#endif
>  }
>
>  static const VMStateDescription vmstate_riscv_cpu = {
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 4c342e7a79..680592cb60 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -122,7 +122,7 @@ struct CPURISCVState {
>      target_ulong resetvec;
>
>      target_ulong mhartid;
> -    target_ulong mstatus;
> +    target_ulong *mstatus;
>
>      /*
>       * CAUTION! Unlike the rest of this struct, mip is accessed asynchonously
> @@ -136,7 +136,7 @@ struct CPURISCVState {
>      uint32_t mip;
>      uint32_t miclaim;
>
> -    target_ulong mie;
> +    target_ulong *mie;
>      target_ulong mideleg;
>
>      target_ulong sptbr;  /* until: priv-1.9.1 */
> @@ -154,6 +154,14 @@ struct CPURISCVState {
>      target_ulong mcause;
>      target_ulong mtval;  /* since: priv-1.10.0 */
>
> +    /* The following registers are the "real" versions that the pointer
> +     * versions point to. These should never be used unless you know what you
> +     * are doing. To access these use the pointer versions instead. This is
> +     * required to handle the Hypervisor register swapping.
> +     */
> +    target_ulong mie_novirt;
> +    target_ulong mstatus_novirt;
> +
>      /* Hypervisor CSRs */
>      target_ulong hstatus;
>      target_ulong hedeleg;
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 5bcfc2e090..c597523d74 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -36,9 +36,9 @@ int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
>  #ifndef CONFIG_USER_ONLY
>  static int riscv_cpu_local_irq_pending(CPURISCVState *env)
>  {
> -    target_ulong mstatus_mie = get_field(env->mstatus, MSTATUS_MIE);
> -    target_ulong mstatus_sie = get_field(env->mstatus, MSTATUS_SIE);
> -    target_ulong pending = atomic_read(&env->mip) & env->mie;
> +    target_ulong mstatus_mie = get_field(*env->mstatus, MSTATUS_MIE);
> +    target_ulong mstatus_sie = get_field(*env->mstatus, MSTATUS_SIE);
> +    target_ulong pending = atomic_read(env->mip) & *env->mie;
>      target_ulong mie = env->priv < PRV_M || (env->priv == PRV_M && mstatus_mie);
>      target_ulong sie = env->priv < PRV_S || (env->priv == PRV_S && mstatus_sie);
>      target_ulong irqs = (pending & ~env->mideleg & -mie) |
> @@ -74,7 +74,7 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>  /* Return true is floating point support is currently enabled */
>  bool riscv_cpu_fp_enabled(CPURISCVState *env)
>  {
> -    if (env->mstatus & MSTATUS_FS) {
> +    if (*env->mstatus & MSTATUS_FS) {
>          return true;
>      }
>
> @@ -219,8 +219,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>      int mode = mmu_idx;
>
>      if (mode == PRV_M && access_type != MMU_INST_FETCH) {
> -        if (get_field(env->mstatus, MSTATUS_MPRV)) {
> -            mode = get_field(env->mstatus, MSTATUS_MPP);
> +        if (get_field(*env->mstatus, MSTATUS_MPRV)) {
> +            mode = get_field(*env->mstatus, MSTATUS_MPP);
>          }
>      }
>
> @@ -234,11 +234,11 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>
>      target_ulong base;
>      int levels, ptidxbits, ptesize, vm, sum;
> -    int mxr = get_field(env->mstatus, MSTATUS_MXR);
> +    int mxr = get_field(*env->mstatus, MSTATUS_MXR);
>
>      if (env->priv_ver >= PRIV_VERSION_1_10_0) {
>          base = get_field(env->satp, SATP_PPN) << PGSHIFT;
> -        sum = get_field(env->mstatus, MSTATUS_SUM);
> +        sum = get_field(*env->mstatus, MSTATUS_SUM);
>          vm = get_field(env->satp, SATP_MODE);
>          switch (vm) {
>          case VM_1_10_SV32:
> @@ -258,8 +258,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>          }
>      } else {
>          base = env->sptbr << PGSHIFT;
> -        sum = !get_field(env->mstatus, MSTATUS_PUM);
> -        vm = get_field(env->mstatus, MSTATUS_VM);
> +        sum = !get_field(*env->mstatus, MSTATUS_PUM);
> +        vm = get_field(*env->mstatus, MSTATUS_VM);
>          switch (vm) {
>          case VM_1_09_SV32:
>            levels = 2; ptidxbits = 10; ptesize = 4; break;
> @@ -505,8 +505,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>      ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx);
>
>      if (mode == PRV_M && access_type != MMU_INST_FETCH) {
> -        if (get_field(env->mstatus, MSTATUS_MPRV)) {
> -            mode = get_field(env->mstatus, MSTATUS_MPP);
> +        if (get_field(*env->mstatus, MSTATUS_MPRV)) {
> +            mode = get_field(*env->mstatus, MSTATUS_MPP);
>          }
>      }
>
> @@ -606,12 +606,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      if (env->priv <= PRV_S &&
>              cause < TARGET_LONG_BITS && ((deleg >> cause) & 1)) {
>          /* handle the trap in S-mode */
> -        target_ulong s = env->mstatus;
> +        target_ulong s = *env->mstatus;
>          s = set_field(s, MSTATUS_SPIE, env->priv_ver >= PRIV_VERSION_1_10_0 ?
>              get_field(s, MSTATUS_SIE) : get_field(s, MSTATUS_UIE << env->priv));
>          s = set_field(s, MSTATUS_SPP, env->priv);
>          s = set_field(s, MSTATUS_SIE, 0);
> -        env->mstatus = s;
> +        *env->mstatus = s;
>          env->scause = cause | ((target_ulong)async << (TARGET_LONG_BITS - 1));
>          env->sepc = env->pc;
>          env->sbadaddr = tval;
> @@ -620,12 +620,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          riscv_cpu_set_mode(env, PRV_S);
>      } else {
>          /* handle the trap in M-mode */
> -        target_ulong s = env->mstatus;
> +        target_ulong s = *env->mstatus;
>          s = set_field(s, MSTATUS_MPIE, env->priv_ver >= PRIV_VERSION_1_10_0 ?
>              get_field(s, MSTATUS_MIE) : get_field(s, MSTATUS_UIE << env->priv));
>          s = set_field(s, MSTATUS_MPP, env->priv);
>          s = set_field(s, MSTATUS_MIE, 0);
> -        env->mstatus = s;
> +        *env->mstatus = s;
>          env->mcause = cause | ~(((target_ulong)-1) >> async);
>          env->mepc = env->pc;
>          env->mbadaddr = tval;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index e2e908fbc0..30ec8c0a8e 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -136,7 +136,7 @@ static int write_fflags(CPURISCVState *env, int csrno, target_ulong val)
>      if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>          return -1;
>      }
> -    env->mstatus |= MSTATUS_FS;
> +    *env->mstatus |= MSTATUS_FS;
>  #endif
>      riscv_cpu_set_fflags(env, val & (FSR_AEXC >> FSR_AEXC_SHIFT));
>      return 0;
> @@ -159,7 +159,7 @@ static int write_frm(CPURISCVState *env, int csrno, target_ulong val)
>      if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>          return -1;
>      }
> -    env->mstatus |= MSTATUS_FS;
> +    *env->mstatus |= MSTATUS_FS;
>  #endif
>      env->frm = val & (FSR_RD >> FSR_RD_SHIFT);
>      return 0;
> @@ -183,7 +183,7 @@ static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
>      if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>          return -1;
>      }
> -    env->mstatus |= MSTATUS_FS;
> +    *env->mstatus |= MSTATUS_FS;
>  #endif
>      env->frm = (val & FSR_RD) >> FSR_RD_SHIFT;
>      riscv_cpu_set_fflags(env, (val & FSR_AEXC) >> FSR_AEXC_SHIFT);
> @@ -307,7 +307,7 @@ static int read_mhartid(CPURISCVState *env, int csrno, target_ulong *val)
>  /* Machine Trap Setup */
>  static int read_mstatus(CPURISCVState *env, int csrno, target_ulong *val)
>  {
> -    *val = env->mstatus;
> +    *val = *env->mstatus;
>      return 0;
>  }
>
> @@ -319,7 +319,7 @@ static int validate_vm(CPURISCVState *env, target_ulong vm)
>
>  static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
>  {
> -    target_ulong mstatus = env->mstatus;
> +    target_ulong mstatus = *env->mstatus;
>      target_ulong mask = 0;
>      int dirty;
>
> @@ -359,7 +359,7 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
>               ((mstatus & MSTATUS_FS) == MSTATUS_FS)) |
>              ((mstatus & MSTATUS_XS) == MSTATUS_XS);
>      mstatus = set_field(mstatus, MSTATUS_SD, dirty);
> -    env->mstatus = mstatus;
> +    *env->mstatus = mstatus;
>
>      return 0;
>  }
> @@ -448,13 +448,13 @@ static int write_mideleg(CPURISCVState *env, int csrno, target_ulong val)
>
>  static int read_mie(CPURISCVState *env, int csrno, target_ulong *val)
>  {
> -    *val = env->mie;
> +    *val = *env->mie;
>      return 0;
>  }
>
>  static int write_mie(CPURISCVState *env, int csrno, target_ulong val)
>  {
> -    env->mie = (env->mie & ~all_ints) | (val & all_ints);
> +    *env->mie = (*env->mie & ~all_ints) | (val & all_ints);
>      return 0;
>  }
>
> @@ -608,7 +608,7 @@ static int read_sstatus(CPURISCVState *env, int csrno, target_ulong *val)
>  {
>      target_ulong mask = ((env->priv_ver >= PRIV_VERSION_1_10_0) ?
>                           sstatus_v1_10_mask : sstatus_v1_9_mask);
> -    *val = env->mstatus & mask;
> +    *val = *env->mstatus & mask;
>      return 0;
>  }
>
> @@ -616,19 +616,19 @@ static int write_sstatus(CPURISCVState *env, int csrno, target_ulong val)
>  {
>      target_ulong mask = ((env->priv_ver >= PRIV_VERSION_1_10_0) ?
>                           sstatus_v1_10_mask : sstatus_v1_9_mask);
> -    target_ulong newval = (env->mstatus & ~mask) | (val & mask);
> +    target_ulong newval = (*env->mstatus & ~mask) | (val & mask);
>      return write_mstatus(env, CSR_MSTATUS, newval);
>  }
>
>  static int read_sie(CPURISCVState *env, int csrno, target_ulong *val)
>  {
> -    *val = env->mie & env->mideleg;
> +    *val = *env->mie & env->mideleg;
>      return 0;
>  }
>
>  static int write_sie(CPURISCVState *env, int csrno, target_ulong val)
>  {
> -    target_ulong newval = (env->mie & ~env->mideleg) | (val & env->mideleg);
> +    target_ulong newval = (*env->mie & ~env->mideleg) | (val & env->mideleg);
>      return write_mie(env, CSR_MIE, newval);
>  }
>
> @@ -731,7 +731,7 @@ static int read_satp(CPURISCVState *env, int csrno, target_ulong *val)
>      if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
>          *val = 0;
>      } else if (env->priv_ver >= PRIV_VERSION_1_10_0) {
> -        if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
> +        if (env->priv == PRV_S && get_field(*env->mstatus, MSTATUS_TVM)) {
>              return -1;
>          } else {
>              *val = env->satp;
> @@ -756,7 +756,7 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
>          validate_vm(env, get_field(val, SATP_MODE)) &&
>          ((val ^ env->satp) & (SATP_MODE | SATP_ASID | SATP_PPN)))
>      {
> -        if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
> +        if (env->priv == PRV_S && get_field(*env->mstatus, MSTATUS_TVM)) {
>              return -1;
>          } else {
>              if((val ^ env->satp) & SATP_ASID) {
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 331cc36232..d150551bc9 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -83,11 +83,11 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
>      }
>
>      if (env->priv_ver >= PRIV_VERSION_1_10_0 &&
> -        get_field(env->mstatus, MSTATUS_TSR)) {
> +        get_field(*env->mstatus, MSTATUS_TSR)) {
>          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>      }
>
> -    target_ulong mstatus = env->mstatus;
> +    target_ulong mstatus = *env->mstatus;
>      target_ulong prev_priv = get_field(mstatus, MSTATUS_SPP);
>      mstatus = set_field(mstatus,
>          env->priv_ver >= PRIV_VERSION_1_10_0 ?
> @@ -96,7 +96,7 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
>      mstatus = set_field(mstatus, MSTATUS_SPIE, 0);
>      mstatus = set_field(mstatus, MSTATUS_SPP, PRV_U);
>      riscv_cpu_set_mode(env, prev_priv);
> -    env->mstatus = mstatus;
> +    *env->mstatus = mstatus;
>
>      return retpc;
>  }
> @@ -112,7 +112,7 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
>          riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
>      }
>
> -    target_ulong mstatus = env->mstatus;
> +    target_ulong mstatus = *env->mstatus;
>      target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
>      mstatus = set_field(mstatus,
>          env->priv_ver >= PRIV_VERSION_1_10_0 ?
> @@ -121,7 +121,7 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
>      mstatus = set_field(mstatus, MSTATUS_MPIE, 0);
>      mstatus = set_field(mstatus, MSTATUS_MPP, PRV_U);
>      riscv_cpu_set_mode(env, prev_priv);
> -    env->mstatus = mstatus;
> +    *env->mstatus = mstatus;
>
>      return retpc;
>  }
> @@ -132,7 +132,7 @@ void helper_wfi(CPURISCVState *env)
>
>      if (env->priv == PRV_S &&
>          env->priv_ver >= PRIV_VERSION_1_10_0 &&
> -        get_field(env->mstatus, MSTATUS_TW)) {
> +        get_field(*env->mstatus, MSTATUS_TW)) {
>          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>      } else {
>          cs->halted = 1;
> @@ -147,7 +147,7 @@ void helper_tlb_flush(CPURISCVState *env)
>      if (!(env->priv >= PRV_S) ||
>          (env->priv == PRV_S &&
>           env->priv_ver >= PRIV_VERSION_1_10_0 &&
> -         get_field(env->mstatus, MSTATUS_TVM))) {
> +         get_field(*env->mstatus, MSTATUS_TVM))) {
>          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>      } else {
>          tlb_flush(cs);

I don't think this is that bad.

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

