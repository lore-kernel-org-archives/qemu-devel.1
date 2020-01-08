Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B61C33C99
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 02:12:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9FC9206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 02:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XvRPdLkr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FC9206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip0pE-0004dh-0G
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 21:12:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1ip0kg-0006Ih-7I
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 21:07:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1ip0ke-0000Bg-OP
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 21:07:17 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42022)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1ip0ke-0000Au-Ge
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 21:07:16 -0500
Received: by mail-pl1-x644.google.com with SMTP id p9so451612plk.9
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 18:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:subject:cc:to:in-reply-to:references:message-id
 :mime-version:content-transfer-encoding;
 bh=MiNODDWVO4yc/L/Pc1YPuc7B7iALbiFd05MQOgI5d0A=;
 b=XvRPdLkrFpVCutBxKTH1nD+xr4PBVlFFIUJUk7HF67b79U2FeI0GQ7K3AqcJd92RMY
 YiSSFzebkXGLPBLNQV31euOYU6X/QUBhAzxkE0B9oTu9tjAA1LAkHr1//8rBIRMK2uGQ
 1WgtwyhUKGFmY2/gjU/YQTYaW5sUT+U1O/ZwpgSefzSYt+wDQpeN2AGixvOmGOromHxs
 JRPioGhtMotfFKW4HlNT4l8oGtlmGTTjwPI2tfQUZX47QD2JcOauHYh/Mcx90imgvI7u
 Ll7d9lpPSGACMayCRPyKYg5ZUMCSS2NF3X+ew0X2ghniWLzSsKdGDIfLBeyBO+4NWFY6
 fFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=MiNODDWVO4yc/L/Pc1YPuc7B7iALbiFd05MQOgI5d0A=;
 b=IRsOfbT7m19uT9Y6t30X5TbhGoWHqdMeUTd8I8lcg/QJ7KaBZDM9jFBUTIwdx11235
 lwDTkxJ1FNPu4iZcgOb5Q07mdDP3fVRFyB6QB4rIm7XUKFV8nFo1kjiWm/QDcmjtAuWe
 EzblDMgVRM9ZbB1PrwQmpDJcwfXco3NuCPkaNMHbkpHUuJiAbcGo9jWl/tY+08zXkzw+
 a2qjFbLJs17fV1EX/H1DKC2bK5PEmOBPZShsFAhjaNJctcVbfvFSxxRUPsFrSqgcWuHy
 oLKU63llToV2mTHZeeEaJa9UYQKt6PXXEhKwdEpNy4KN1xflCm3O6k37YtEano7IjwTd
 tCVQ==
X-Gm-Message-State: APjAAAWL280yic0UoROKbQEZxjNqykjJxCaC67M+4Q9BhfhoM3RfXv+m
 PDDBZsA8zzcsgFBNJ5rwChcwiSfEs/U=
X-Google-Smtp-Source: APXvYqyM7oSGL8ibqDOvDbRVp4lYilXW1WU0cSW7LnuEm0Vo7oBjhtBR5OLC7TDoCzaPN3r6WKM7fQ==
X-Received: by 2002:a17:90a:8d84:: with SMTP id
 d4mr1798695pjo.114.1578449234787; 
 Tue, 07 Jan 2020 18:07:14 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
 by smtp.gmail.com with ESMTPSA id s7sm868505pjk.22.2020.01.07.18.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 18:07:14 -0800 (PST)
Date: Tue, 07 Jan 2020 18:07:14 -0800 (PST)
X-Google-Original-Date: Tue, 07 Jan 2020 17:36:58 PST (-0800)
From: Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v1 16/36] target/riscv: Add virtual register swapping
 function
CC: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
To: Alistair Francis <Alistair.Francis@wdc.com>
In-Reply-To: <e89e42f47b337c82ff7fe0ef50986e2df0d7214a.1575914822.git.alistair.francis@wdc.com>
References: <e89e42f47b337c82ff7fe0ef50986e2df0d7214a.1575914822.git.alistair.francis@wdc.com><cover.1575914822.git.alistair.francis@wdc.com>
Message-ID: <mhng-7d5b34f4-067d-4a7b-a114-b9ac12db9809@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 09 Dec 2019 10:11:22 PST (-0800), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.h        | 10 +++++++
>  target/riscv/cpu_bits.h   |  7 +++++
>  target/riscv/cpu_helper.c | 63 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 80 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 9dc8303c62..eb089fbdb6 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -125,6 +125,7 @@ struct CPURISCVState {
>      target_ulong *mstatus;
>
>      target_ulong mip;
> +
>      uint32_t miclaim;
>
>      target_ulong mie;
> @@ -173,6 +174,14 @@ struct CPURISCVState {
>      target_ulong mtval2;
>      target_ulong mtinst;
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
> @@ -303,6 +312,7 @@ void riscv_cpu_list(void);
>  #define cpu_mmu_index riscv_cpu_mmu_index
>
>  #ifndef CONFIG_USER_ONLY
> +void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
>  int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts);
>  uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value);
>  #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index ad6479796c..a24654d137 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -553,4 +553,11 @@
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
> index 9684da7f7d..63439c9370 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -82,6 +82,69 @@ bool riscv_cpu_fp_enabled(CPURISCVState *env)
>      return false;
>  }
>
> +void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
> +{
> +    target_ulong mstatus_mask = MSTATUS_MXR | MSTATUS_SUM | MSTATUS_FS |
> +                                MSTATUS_SPP | MSTATUS_SPIE | MSTATUS_SIE;
> +    bool current_virt = riscv_cpu_virt_enabled(env);
> +
> +    g_assert(riscv_has_ext(env, RVH));
> +
> +#if defined(TARGET_RISCV64)
> +    mstatus_mask |= MSTATUS64_UXL;
> +#endif
> +
> +    if (current_virt) {
> +        /* Current V=1 and we are about to change to V=0 */
> +        env->mstatus = &env->mstatus_novirt;
> +        *env->mstatus &= mstatus_mask;
> +        *env->mstatus |= env->vsstatus & ~mstatus_mask;
> +        /* Ensure that vsstatus only holds the correct bits */
> +        env->vsstatus &= mstatus_mask;
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
> +    } else {
> +        /* Current V=0 and we are about to change to V=1 */
> +        env->mstatus = &env->vsstatus;
> +        *env->mstatus &= mstatus_mask;
> +        *env->mstatus |= env->mstatus_novirt & ~mstatus_mask;
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
> +    }
> +}
> +
>  bool riscv_cpu_virt_enabled(CPURISCVState *env)
>  {
>      if (!riscv_has_ext(env, RVH)) {

Modulo that question about the concept of pointer swapping on the previous
patch:

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

