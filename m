Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8458AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E71B9223FD
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZfhRMZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71B9223FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWyTH-0006Bx-Sp
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 05:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWyIu-0002On-BW; Mon, 26 Oct 2020 04:56:37 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:39062)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWyIq-0005p5-ER; Mon, 26 Oct 2020 04:56:36 -0400
Received: by mail-yb1-xb41.google.com with SMTP id 67so7004184ybt.6;
 Mon, 26 Oct 2020 01:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eExcM98DT1qtbKtYttuIhUJRd0xDON2inxmRL9zaqp0=;
 b=pZfhRMZ+164AeohYd+6grqG+H1kupdsoS7chrJsNIIij/n6nqUm+OX2qVxH6p/IOO/
 sh3mSp41S8pB3KWULm7tehg21/EauO8OhiXsqj1eFDuih+SuzILb3XY5LSnJUNfma2CE
 XFu5AUfzXB6kKTQeEcBVNuxVcuesnqNxqAxrPXgXfaR3zmjvIgaYwpk5Pi5YW7QCrW3V
 Ucxkld8l5TBDaUBVipOcAihW96I4HbH1ljpWThXYad1HlwVzOczM97pLzkBPKomAVFdz
 Br5XwtE5/1iRRmE3SsxJh8887w8XZlWiQ0Qej5MCAp0iLaVeYWaY5ZxT8VvAQL1TiI4/
 s5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eExcM98DT1qtbKtYttuIhUJRd0xDON2inxmRL9zaqp0=;
 b=XHZ2Q9YTtQ5LlrP1t0Q6orm3WZ47JAHM+stq2Cyx61Zd2Pod3ECwst9vyQBtfTTDxn
 9rDUaWE7ZsnNg+hsgkcPZeeHJ2xLOe7qwDB8B5yQZTQEeoqfeoNgGju+oCEUp0ES8+Eq
 61MXdLBnYHRmchs69MDoZ887JXK7Z1v8SS3xEwz3yvf1p9Mv6ZNHmRGWFZI/9Y4XFJ28
 uM4QA0b3ImceIdV3vM7Mv8/OTgQ4VtnTNvEX1u9BEpyjVMc4MKIY6Z+yUZekvbywSItk
 7gfEdLpYzRZ/YdVIRbxpkokC7D4pGJ24+BjY0muiG/2lYW1e/soNEMtsgwsiMSl21mxJ
 FoFg==
X-Gm-Message-State: AOAM533qCQcfcILmJfW0+JE0XsjLU4tvR+8c7+pi8HiopMUa1NDzWwu8
 ePhittpF96jfm6opbPu1zrJ+/jPE/xTeUoocTes=
X-Google-Smtp-Source: ABdhPJy2c2hZ2Twpw6rsDiiwDtt32laRd/+RoaHftR9HvhR27SkjtH/8hc7HFopKyH6WlNjS+NtQN/auf4VpdnO0FuI=
X-Received: by 2002:a25:4113:: with SMTP id o19mr18733027yba.314.1603702589563; 
 Mon, 26 Oct 2020 01:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603467169.git.alistair.francis@wdc.com>
 <6b17e9aff7bd6823574a94dc0d615117ce6edef6.1603467169.git.alistair.francis@wdc.com>
In-Reply-To: <6b17e9aff7bd6823574a94dc0d615117ce6edef6.1603467169.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 26 Oct 2020 16:56:18 +0800
Message-ID: <CAEUhbmVtYUro2QBKKhDkQNF3go7HjNr-QBj0=msvG9_hhhHYgg@mail.gmail.com>
Subject: Re: [PATCH v1 12/16] target/riscv: cpu_helper: Remove compile time
 XLEN checks
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b41;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 23, 2020 at 11:45 PM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.h        |  6 ++---
>  target/riscv/cpu_helper.c | 52 ++++++++++++++++++++-------------------
>  2 files changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 6096243aed..8bde15544d 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -194,9 +194,8 @@ struct CPURISCVState {
>      target_ulong vscause;
>      target_ulong vstval;
>      target_ulong vsatp;
> -#ifdef TARGET_RISCV32
> +    /* This is RV32 only */
>      target_ulong vsstatush;

nits: could we move the definition to the line just below where
vsstatus is defined in this structure, like other similar *h members?

> -#endif
>
>      target_ulong mtval2;
>      target_ulong mtinst;
> @@ -209,9 +208,8 @@ struct CPURISCVState {
>      target_ulong stval_hs;
>      target_ulong satp_hs;
>      target_ulong mstatus_hs;
> -#ifdef TARGET_RISCV32
> +    /* This is RV32 only */
>      target_ulong mstatush_hs;
> -#endif
>
>      target_ulong scounteren;
>      target_ulong mcounteren;
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 4652082df1..62aed24feb 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -126,10 +126,10 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
>          env->mstatus &= ~mstatus_mask;
>          env->mstatus |= env->mstatus_hs;
>
> -#if defined(TARGET_RISCV32)
> -        env->vsstatush = env->mstatush;
> -        env->mstatush |= env->mstatush_hs;
> -#endif
> +        if (riscv_cpu_is_32bit(env)) {
> +            env->vsstatush = env->mstatush;
> +            env->mstatush |= env->mstatush_hs;
> +        }
>
>          env->vstvec = env->stvec;
>          env->stvec = env->stvec_hs;
> @@ -154,10 +154,10 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
>          env->mstatus &= ~mstatus_mask;
>          env->mstatus |= env->vsstatus;
>
> -#if defined(TARGET_RISCV32)
> -        env->mstatush_hs = env->mstatush;
> -        env->mstatush |= env->vsstatush;
> -#endif
> +        if (riscv_cpu_is_32bit(env)) {
> +            env->mstatush_hs = env->mstatush;
> +            env->mstatush |= env->vsstatush;
> +        }
>
>          env->stvec_hs = env->stvec;
>          env->stvec = env->vstvec;
> @@ -472,11 +472,13 @@ restart:
>              return TRANSLATE_PMP_FAIL;
>          }
>
> -#if defined(TARGET_RISCV32)
> -        target_ulong pte = address_space_ldl(cs->as, pte_addr, attrs, &res);
> -#elif defined(TARGET_RISCV64)
> -        target_ulong pte = address_space_ldq(cs->as, pte_addr, attrs, &res);
> -#endif
> +        target_ulong pte;
> +        if (riscv_cpu_is_32bit(env)) {
> +            pte = address_space_ldl(cs->as, pte_addr, attrs, &res);
> +        } else {
> +            pte = address_space_ldq(cs->as, pte_addr, attrs, &res);
> +        }
> +
>          if (res != MEMTX_OK) {
>              return TRANSLATE_FAIL;
>          }
> @@ -995,19 +997,19 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>              if (riscv_cpu_virt_enabled(env)) {
>                  riscv_cpu_swap_hypervisor_regs(env);
>              }
> -#ifdef TARGET_RISCV32
> -            env->mstatush = set_field(env->mstatush, MSTATUS_MPV,
> -                                       riscv_cpu_virt_enabled(env));
> -            if (riscv_cpu_virt_enabled(env) && tval) {
> -                env->mstatush = set_field(env->mstatush, MSTATUS_GVA, 1);
> -            }
> -#else
> -            env->mstatus = set_field(env->mstatus, MSTATUS_MPV,
> -                                      riscv_cpu_virt_enabled(env));
> -            if (riscv_cpu_virt_enabled(env) && tval) {
> -                env->mstatus = set_field(env->mstatus, MSTATUS_GVA, 1);
> +            if (riscv_cpu_is_32bit(env)) {
> +                env->mstatush = set_field(env->mstatush, MSTATUS_MPV,
> +                                           riscv_cpu_virt_enabled(env));

nits: looks the alignment is not on the left parenthesis

> +                if (riscv_cpu_virt_enabled(env) && tval) {
> +                    env->mstatush = set_field(env->mstatush, MSTATUS_GVA, 1);
> +                }
> +            } else {
> +                env->mstatus = set_field(env->mstatus, MSTATUS_MPV,
> +                                          riscv_cpu_virt_enabled(env));

ditto

> +                if (riscv_cpu_virt_enabled(env) && tval) {
> +                    env->mstatus = set_field(env->mstatus, MSTATUS_GVA, 1);
> +                }
>              }
> -#endif
>
>              mtval2 = env->guest_phys_fault_addr;
>

Regards,
Bin

