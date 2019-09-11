Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F66EC5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D933D20863
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D933D20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i83RY-0007Ob-05
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 10:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i83Qe-0006nr-JY
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i83Qd-0007LB-32
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:17:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43569)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i83Qc-0007Kg-TC
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:17:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id q17so20064053wrx.10
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 07:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=Ab/dq4y+buOFjvxGG++VYANlrXTert/BAh1ff8G4/nk=;
 b=E9sbsub6dKPTNTa5SKgjHepCeBW7m63dXqfNu/BmEi4uBI6/YzYGJT0WtYCQkttSC9
 dUZKbLX6g+gDP3klMVlU7eoJD0Wpl1bXMvCoqHzZ9lJMjv+/ZM4q+U7Sfai5B4QYZ08Y
 Hxvk9LVjSra7Rk8azcTCs1KfcSc4DK2+JYN9pv+ieHDmuYQlMkqliBRJzVtll/itjC3R
 Exboiql8HLCRpxFAwemB8tfJVjquM3niNpC0DeePX4ukDocrDD3R7fFB4DcDbNCGNI6l
 qynG2FppoS+MuyuAUsIYj0ZCVabiJ18wfSzi+XnJKUljMM0YB+B916DvRY6M2JmbcvqE
 7hQg==
X-Gm-Message-State: APjAAAVOE3UQe0C90rynQuUo8pwsqWO3tTDaXdS9lT8lzDlcW9ao2KX3
 m6/KuqiQSBEguyrpNUmMlOiiAoc3/MxWyw==
X-Google-Smtp-Source: APXvYqwa5YZbCitNiWv1YwC13oy5vmbJMFCYcde/TauginUp7WH74gUAblzlr955fKJ4ftzXCMj2Yw==
X-Received: by 2002:a5d:4d42:: with SMTP id a2mr31488872wru.66.1568211421267; 
 Wed, 11 Sep 2019 07:17:01 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id i93sm20721149wri.57.2019.09.11.07.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 07:17:00 -0700 (PDT)
Date: Wed, 11 Sep 2019 07:17:00 -0700 (PDT)
X-Google-Original-Date: Wed, 11 Sep 2019 06:28:38 PDT (-0700)
In-Reply-To: <ec79c985398944a8443eac5673d40bc0969f8380.1566603412.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-fe7f7960-29da-4b78-a6e1-37b03bc878b8@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v1 11/28] target/riscv: Add background
 register swapping function
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

On Fri, 23 Aug 2019 16:38:18 PDT (-0700), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.h        | 24 ++++++++---
>  target/riscv/cpu_bits.h   |  7 ++++
>  target/riscv/cpu_helper.c | 88 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 113 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 680592cb60..05957f32a8 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -125,15 +125,18 @@ struct CPURISCVState {
>      target_ulong *mstatus;
>
>      /*
> -     * CAUTION! Unlike the rest of this struct, mip is accessed asynchonously
> -     * by I/O threads. It should be read with atomic_read. It should be updated
> -     * using riscv_cpu_update_mip with the iothread mutex held. The iothread
> -     * mutex must be held because mip must be consistent with the CPU inturrept
> -     * state. riscv_cpu_update_mip calls cpu_interrupt or cpu_reset_interrupt
> -     * wuth the invariant that CPU_INTERRUPT_HARD is set iff mip is non-zero.
> +     * CAUTION! Unlike the rest of this struct, mip and mip_novirt is accessed
> +     * asynchonously by I/O threads. It should be read with atomic_read. It should
> +     * be updated using riscv_cpu_update_mip with the iothread mutex held. The
> +     * iothread mutex must be held because mip must be consistent with the CPU
> +     * inturrept state. riscv_cpu_update_mip calls cpu_interrupt or
> +     * cpu_reset_interrupt wuth the invariant that CPU_INTERRUPT_HARD is set if
> +     * mip is non-zero.
>       * mip is 32-bits to allow atomic_read on 32-bit hosts.
>       */
>      uint32_t mip;
> +    uint32_t mip_novirt;
> +
>      uint32_t miclaim;
>
>      target_ulong *mie;
> @@ -179,6 +182,14 @@ struct CPURISCVState {
>      target_ulong vstval;
>      target_ulong vsatp;
>
> +    /* HS Backup CSRs */
> +    target_ulong stvec_hs;
> +    target_ulong sscratch_hs;
> +    target_ulong sepc_hs;
> +    target_ulong scause_hs;
> +    target_ulong stval_hs;
> +    target_ulong satp_hs;
> +
>      target_ulong scounteren;
>      target_ulong mcounteren;
>
> @@ -306,6 +317,7 @@ void riscv_cpu_list(void);
>  #define cpu_mmu_index riscv_cpu_mmu_index
>
>  #ifndef CONFIG_USER_ONLY
> +void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
>  int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts);
>  uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value);
>  #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 78067901a2..5cee72b726 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -556,4 +556,11 @@
>  #define SIP_STIP                           MIP_STIP
>  #define SIP_SEIP                           MIP_SEIP
>
> +/* MIE masks */
> +#define MIE_SEIE                           (1 << IRQ_S_EXT)
> +#define MIE_UEIE                           (1 << IRQ_U_EXT)
> +#define MIE_STIE                           (1 << IRQ_S_TIMER)
> +#define MIE_UTIE                           (1 << IRQ_U_TIMER)
> +#define MIE_SSIE                           (1 << IRQ_S_SOFT)
> +#define MIE_USIE                           (1 << IRQ_U_SOFT)
>  #endif
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index c597523d74..41d4368128 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -81,6 +81,94 @@ bool riscv_cpu_fp_enabled(CPURISCVState *env)
>      return false;
>  }
>
> +void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(env_cpu(env));
> +    uint32_t tmp;
> +    target_ulong mstatus_mask = MSTATUS_MXR | MSTATUS_SUM | MSTATUS_FS |
> +                                MSTATUS_SPP | MSTATUS_SPIE | MSTATUS_SIE;
> +    target_ulong sie_mask = MIE_SEIE | MIE_STIE | MIE_SSIE |
> +                            MIE_UEIE | MIE_UTIE | MIE_USIE;
> +    target_ulong mip_mask = MIP_SSIP | MIP_STIP | MIP_SEIP;
> +    bool current_virt = riscv_cpu_virt_enabled(env);
> +
> +    g_assert(riscv_has_ext(env, RVH));
> +
> +#if defined(TARGET_RISCV64)
> +    mstatus_mask |= MSTATUS64_UXL;
> +#endif
> +
> +    if (current_virt) {

This worries me more than the pointer stuff: specifically, my worry is keeping 
V in sync with the register set in use.

> +        /* Current V=1 and we are about to change to V=0 */
> +        env->mstatus = &env->mstatus_novirt;
> +        *env->mstatus &= mstatus_mask;
> +        *env->mstatus |= env->vsstatus & ~mstatus_mask;
> +        /* Ensure that vsstatus only holds the correct bits */
> +        env->vsstatus &= mstatus_mask;
> +
> +        env->mie = &env->mie_novirt;
> +        *env->mie &= sie_mask;
> +        *env->mie |= env->vsie & ~sie_mask;
> +        /* Ensure that vsie only holds the correct bits */
> +        env->vsie &= sie_mask;
> +
> +        env->vstvec = env->stvec;
> +        env->stvec = env->stvec_hs;
> +
> +        env->vsscratch = env->sscratch;
> +        env->sscratch = env->sscratch_hs;
> +
> +        env->vsepc = env->sepc;
> +        env->sepc = env->sepc_hs;
> +
> +        env->vscause = env->scause;
> +        env->scause = env->scause_hs;
> +
> +        env->vstval = env->sbadaddr;
> +        env->sbadaddr = env->stval_hs;
> +
> +        env->vsatp = env->satp;
> +        env->satp = env->satp_hs;
> +
> +        tmp = (uint32_t)atomic_read(&env->mip_novirt);
> +        tmp = riscv_cpu_update_mip(cpu, mip_mask, tmp);
> +        tmp &= mip_mask;
> +        atomic_set(&env->vsip, tmp);

We talked about this in person, and Alistair is going to do the fake interrupt 
thing to avoid the atomicity requirements entirely.

> +    } else {
> +        /* Current V=0 and we are about to change to V=1 */
> +        env->mstatus = &env->vsstatus;
> +        *env->mstatus &= mstatus_mask;
> +        *env->mstatus |= env->mstatus_novirt & ~mstatus_mask;
> +
> +        env->mie = &env->vsie;
> +        *env->mie &= sie_mask;
> +        *env->mie |= env->mie_novirt & ~sie_mask;
> +
> +        env->stvec_hs = env->stvec;
> +        env->stvec = env->vstvec;
> +
> +        env->sscratch_hs = env->sscratch;
> +        env->sscratch = env->vsscratch;
> +
> +        env->sepc_hs = env->sepc;
> +        env->sepc = env->vsepc;
> +
> +        env->scause_hs = env->scause;
> +        env->scause = env->vscause;
> +
> +        env->stval_hs = env->sbadaddr;
> +        env->sbadaddr = env->vstval;
> +
> +        env->satp_hs = env->satp;
> +        env->satp = env->vsatp;
> +
> +        tmp = (uint32_t)atomic_read(&env->vsip);
> +        tmp = riscv_cpu_update_mip(cpu, mip_mask, tmp);
> +        tmp &= mip_mask;
> +        atomic_set(&env->mip_novirt, tmp);
> +    }
> +}
> +
>  bool riscv_cpu_virt_enabled(CPURISCVState *env)
>  {
>      bool tmp;

