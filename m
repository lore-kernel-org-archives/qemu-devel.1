Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248E7ECE58C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 18:38:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED24F206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 18:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED24F206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHuMy-0008Bu-2j
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 14:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iHuLt-00075z-CV
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 14:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iHuLr-0001lA-S8
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 14:36:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36601)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iHuLr-0001kc-N0
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 14:36:51 -0400
Received: by mail-pl1-f193.google.com with SMTP id j11so8854368plk.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 11:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=1p5wtpKDczKiRs05oJflv+Gkh5Itnx00+VwT+r5Xi7Q=;
 b=bXqhmbOgsnpNqllFiIsyqb9IGyNintGa3C9xPGEPXwSAfe57zbJbYwFAObhXk/ceMu
 3prkoVVrwGfpP/ROKS4pTDiwj9XmDBbBJgIyGg3gPJ/A4Cicny1/AL3gZ60oL9//RGo2
 L7gm/FpXO2j0cgUA7oCdoackh0tqesMVgyUyd2MMGUi3TNFoYAdWAuIQ+4F9n42wNW7z
 pCD7W4DPnb4xdBcKw+/WLxoahJJa7kJx6+z736gktSusxZkAPiF+r6Cc31PClQMaprEw
 ZwrjQsBZcfH4tQ87lStamqkZ36kcJLadlV7RLSGftktdGWUc0Exqp1y4SmXy5QfItkec
 orhQ==
X-Gm-Message-State: APjAAAWREiyNe9PqEF0uwnaAHtJcXfOGq01S6454bzqve/3vaFbVsAre
 DC5RL8mZ1KTGo3Iyv2AgR6BBbGsz25U=
X-Google-Smtp-Source: APXvYqwb6ly2xe5WIntHCkDIF1kuWNe+xbABVhggcUHVW6R5U/QxHy8UymSMu+P4ry6Jlu0W4B/2Ig==
X-Received: by 2002:a17:902:8e8b:: with SMTP id
 bg11mr5465062plb.326.1570559809994; 
 Tue, 08 Oct 2019 11:36:49 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id f14sm20673585pfq.187.2019.10.08.11.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 11:36:49 -0700 (PDT)
Date: Tue, 08 Oct 2019 11:36:49 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Oct 2019 11:34:45 PDT (-0700)
Subject: Re: [PATCH v1 26/28] target/riscv: Add support for the 32-bit
 MSTATUSH CSR
In-Reply-To: <f4e877ca1f9fece2e25f1b8bc655d6e240208ae5.1566603412.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-95ae283b-4369-4508-ab27-784960597e72@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.193
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

On Fri, 23 Aug 2019 16:38:58 PDT (-0700), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c        |  6 ++++++
>  target/riscv/cpu.h        |  7 +++++++
>  target/riscv/cpu_bits.h   |  3 +++
>  target/riscv/cpu_helper.c |  7 +++++++
>  target/riscv/csr.c        | 23 +++++++++++++++++++++++
>  target/riscv/op_helper.c  |  4 ++++
>  6 files changed, 50 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 371d5845af..06ee551ebe 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -229,6 +229,9 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>  #ifndef CONFIG_USER_ONLY
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", *env->mstatus);
> +#ifdef TARGET_RISCV32
> +    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatush ", *env->mstatush);
> +#endif
>      if (riscv_has_ext(env, RVH)) {
>          qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "hstatus ", env->hstatus);
>          qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "bstatus ", env->vsstatus);
> @@ -468,6 +471,9 @@ static void riscv_cpu_init(Object *obj)
>  #ifndef CONFIG_USER_ONLY
>      env->mie = &env->mie_novirt;
>      env->mstatus = &env->mstatus_novirt;
> +# ifdef TARGET_RISCV32
> +    env->mstatush = &env->mstatush_novirt;
> +# endif
>  #endif
>  }
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 05957f32a8..b63f1f3cdc 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -124,6 +124,10 @@ struct CPURISCVState {
>      target_ulong mhartid;
>      target_ulong *mstatus;
>
> +#ifdef TARGET_RISCV32
> +    target_ulong *mstatush;
> +#endif
> +
>      /*
>       * CAUTION! Unlike the rest of this struct, mip and mip_novirt is accessed
>       * asynchonously by I/O threads. It should be read with atomic_read. It should
> @@ -164,6 +168,9 @@ struct CPURISCVState {
>       */
>      target_ulong mie_novirt;
>      target_ulong mstatus_novirt;
> +#ifdef TARGET_RISCV32
> +    target_ulong mstatush_novirt;
> +#endif
>
>      /* Hypervisor CSRs */
>      target_ulong hstatus;
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 353fc9a24a..55e20af6d9 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -135,6 +135,9 @@
>  #define CSR_MTVEC           0x305
>  #define CSR_MCOUNTEREN      0x306
>
> +/* 32-bit only */
> +#define CSR_MSTATUSH        0x310
> +
>  /* Legacy Counter Setup (priv v1.9.1) */
>  /* Update to #define CSR_MCOUNTINHIBIT 0x320 for 1.11.0 */
>  #define CSR_MUCOUNTEREN     0x320
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 0761191f11..8c80486dd0 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -949,10 +949,17 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>              if (riscv_cpu_virt_enabled(env)) {
>                  riscv_cpu_swap_hypervisor_regs(env);
>              }
> +#ifdef TARGET_RISCV32
> +            *env->mstatush = set_field(*env->mstatush, MSTATUS_MPV,
> +                                       riscv_cpu_virt_enabled(env));
> +            *env->mstatush = set_field(*env->mstatush, MSTATUS_MTL,
> +                                       riscv_cpu_force_hs_excep_enabled(env));
> +#else
>              *env->mstatus = set_field(*env->mstatus, MSTATUS_MPV,
>                                        riscv_cpu_virt_enabled(env));
>              *env->mstatus = set_field(*env->mstatus, MSTATUS_MTL,
>                                        riscv_cpu_force_hs_excep_enabled(env));
> +#endif
>
>              /* Trapping to M mode, virt is disabled */
>              riscv_cpu_set_virt_enabled(env, VIRT_OFF);
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 47be4b1d42..b7d6d009dc 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -364,6 +364,25 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
>      return 0;
>  }
>
> +#ifdef TARGET_RISCV32
> +static int read_mstatush(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = *env->mstatush;
> +    return 0;
> +}
> +
> +static int write_mstatush(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    if ((val ^ *env->mstatush) & (MSTATUS_MPV)) {
> +        tlb_flush(env_cpu(env));
> +    }
> +
> +    *env->mstatush = val;

The unsupported bits need to be masked off before writing them in.

> +
> +    return 0;
> +}
> +#endif
> +
>  static int read_misa(CPURISCVState *env, int csrno, target_ulong *val)
>  {
>      *val = env->misa;
> @@ -1095,6 +1114,10 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>      [CSR_MTVEC] =               { any,  read_mtvec,       write_mtvec       },
>      [CSR_MCOUNTEREN] =          { any,  read_mcounteren,  write_mcounteren  },
>
> +#if defined(TARGET_RISCV32)
> +    [CSR_MSTATUSH] =            { any,  read_mstatush,    write_mstatush    },
> +#endif
> +
>      /* Legacy Counter Setup (priv v1.9.1) */
>      [CSR_MUCOUNTEREN] =         { any,  read_mucounteren, write_mucounteren },
>      [CSR_MSCOUNTEREN] =         { any,  read_mscounteren, write_mscounteren },
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 5bcf5d2ff7..8dec1aee99 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -153,7 +153,11 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
>          get_field(mstatus, MSTATUS_MPIE));
>      mstatus = set_field(mstatus, MSTATUS_MPIE, 1);
>      mstatus = set_field(mstatus, MSTATUS_MPP, 0);
> +#ifdef TARGET_RISCV32
> +    *env->mstatush = set_field(*env->mstatush, MSTATUS_MPV, 0);
> +#else
>      mstatus = set_field(mstatus, MSTATUS_MPV, 0);
> +#endif
>      *env->mstatus = mstatus;
>      riscv_cpu_set_mode(env, prev_priv);



