Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807B3C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E0D020748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAHUHC1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0D020748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnaI-00017L-Fd
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jbnYt-0007gA-FT; Thu, 21 May 2020 11:56:47 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:42007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jbnYs-0003Jh-9u; Thu, 21 May 2020 11:56:47 -0400
Received: by mail-io1-xd41.google.com with SMTP id e18so7927387iog.9;
 Thu, 21 May 2020 08:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oLR7dVAHollce4e7Rsge3CYJzhnQgXioaSrOT96WRko=;
 b=nAHUHC1oGJ65TsoJss/1RVz7wa1w+aK8kVuvgc/OlY3ADUGbgGqfaxBkdbP+a2Nlf2
 vPzBzsedQ8xBHw6WBdhjFkKd7ieTW9lkmQR7JcuTym27jOFRiuhNeqgxQ3RVAg32T9GO
 nv7aMPAgPGPt/cS+1KQNgal4jClF/z4ut5a4Uy0+T6XjsgHStIeVaUJLVncaMjhRliZs
 DOxXKMQAs8B7F3tK2fgQf4phhBLg59RWfANK3P0myqRzAw3nV7q5Hbi29VasUE/NTpHB
 8YxrhLvLJCQk10gqJFAUETvdN1fM3wEJYkD+KBDtoZAVvNJi7WkMGP2qRds9kMmkk8ZA
 HEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oLR7dVAHollce4e7Rsge3CYJzhnQgXioaSrOT96WRko=;
 b=FMKIDe4BazD3+h6UHd8HogQgsbkM5H8MzKLG0UvvZ/WO3iiQ8G5QRAM5+teWC/3c60
 7+HE3kzTEmZ2cD3aWvK1Ze5hmkrAFaJki69gALawEL9VXcgtJYYIUjD4x9dvveqdUhD0
 9sjQdq4z7dfusGr5PIBpCHq2P3GN4kQ27mShzrWETZo2lIpwDCQlXJbWDRj391S8vfWO
 LR8WuXJUd78j8NXWY0bTfGv4qGG0azdz7/HPZSdwzHlTaoqOXTKnftS/0caLZo5qQgyp
 YLoDPUm+855DZaA3ioy3fz5+hK/U+E7N0qmSNOTCgklloxc+9zPIgfR+bDtHNagbklVg
 ET+g==
X-Gm-Message-State: AOAM532okadRodMaX6ZuE7dqF+23Z518U94+k8phBuXCRTk562aBh7AL
 BqdGTpeD7+cRcgwJqRU1GkvWSB4mqZNdkzqsYw0=
X-Google-Smtp-Source: ABdhPJwWYB56fqLTjZ2KMcu/kaXxSCV5wqRCqo7Bewgrc6mYhxWUD8u1udqmRYqa1epHeLpIFORn/WmdEwokDJvPn9s=
X-Received: by 2002:a5d:9604:: with SMTP id w4mr8442667iol.105.1590076604224; 
 Thu, 21 May 2020 08:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588878640.git.alistair.francis@wdc.com>
 <341f49712f36d53b9d8588da8c7bac712fa7bfcc.1588878640.git.alistair.francis@wdc.com>
 <CAEUhbmUemew2k9EthWStX5UADMN1JGRqj0+Tk1nOpZJ2WSEAHQ@mail.gmail.com>
In-Reply-To: <CAEUhbmUemew2k9EthWStX5UADMN1JGRqj0+Tk1nOpZJ2WSEAHQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 21 May 2020 08:47:48 -0700
Message-ID: <CAKmqyKOHfagzmOttP4Yx-9fwL9_zCUs66V0seUz3=2ZJJYa2Lg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] target/riscv: Drop support for ISA spec version
 1.09.1
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 20, 2020 at 6:18 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Fri, May 8, 2020 at 3:22 AM Alistair Francis
> <alistair.francis@wdc.com> wrote:
> >
> > The RISC-V ISA spec version 1.09.1 has been deprecated in QEMU since
> > 4.1. It's not commonly used so let's remove support for it.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/cpu.c                            |  2 -
> >  target/riscv/cpu.h                            |  1 -
> >  target/riscv/csr.c                            | 82 ++++---------------
> >  .../riscv/insn_trans/trans_privileged.inc.c   |  6 --
> >  4 files changed, 17 insertions(+), 74 deletions(-)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index 112f2e3a2f..eeb91f8513 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -368,8 +368,6 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
> >              priv_version = PRIV_VERSION_1_11_0;
> >          } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.10.0")) {
> >              priv_version = PRIV_VERSION_1_10_0;
> > -        } else if (!g_strcmp0(cpu->cfg.priv_spec, "v1.9.1")) {
> > -            priv_version = PRIV_VERSION_1_09_1;
> >          } else {
> >              error_setg(errp,
> >                         "Unsupported privilege spec version '%s'",
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 76b98d7a33..c022539012 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -73,7 +73,6 @@ enum {
> >      RISCV_FEATURE_MISA
> >  };
> >
> > -#define PRIV_VERSION_1_09_1 0x00010901
> >  #define PRIV_VERSION_1_10_0 0x00011000
> >  #define PRIV_VERSION_1_11_0 0x00011100
> >
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index 11d184cd16..df3498b24f 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -58,31 +58,11 @@ static int ctr(CPURISCVState *env, int csrno)
> >  #if !defined(CONFIG_USER_ONLY)
> >      CPUState *cs = env_cpu(env);
> >      RISCVCPU *cpu = RISCV_CPU(cs);
> > -    uint32_t ctr_en = ~0u;
> >
> >      if (!cpu->cfg.ext_counters) {
> >          /* The Counters extensions is not enabled */
> >          return -1;
> >      }
> > -
> > -    /*
> > -     * The counters are always enabled at run time on newer priv specs, as the
> > -     * CSR has changed from controlling that the counters can be read to
> > -     * controlling that the counters increment.
> > -     */
> > -    if (env->priv_ver > PRIV_VERSION_1_09_1) {
> > -        return 0;
> > -    }
> > -
> > -    if (env->priv < PRV_M) {
> > -        ctr_en &= env->mcounteren;
> > -    }
> > -    if (env->priv < PRV_S) {
> > -        ctr_en &= env->scounteren;
> > -    }
> > -    if (!(ctr_en & (1u << (csrno & 31)))) {
> > -        return -1;
> > -    }
> >  #endif
> >      return 0;
> >  }
> > @@ -358,34 +338,21 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
> >      int dirty;
> >
> >      /* flush tlb on mstatus fields that affect VM */
> > -    if (env->priv_ver <= PRIV_VERSION_1_09_1) {
> > -        if ((val ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP |
> > -                MSTATUS_MPRV | MSTATUS_SUM | MSTATUS_VM)) {
> > -            tlb_flush(env_cpu(env));
> > -        }
> > -        mask = MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
> > -            MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
> > -            MSTATUS_MPP | MSTATUS_MXR |
> > -            (validate_vm(env, get_field(val, MSTATUS_VM)) ?
> > -                MSTATUS_VM : 0);
> > +    if ((val ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP | MSTATUS_MPV |
> > +            MSTATUS_MPRV | MSTATUS_SUM)) {
> > +        tlb_flush(env_cpu(env));
> >      }
> > -    if (env->priv_ver >= PRIV_VERSION_1_10_0) {
> > -        if ((val ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP | MSTATUS_MPV |
> > -                MSTATUS_MPRV | MSTATUS_SUM)) {
> > -            tlb_flush(env_cpu(env));
> > -        }
> > -        mask = MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
> > -            MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
> > -            MSTATUS_MPP | MSTATUS_MXR | MSTATUS_TVM | MSTATUS_TSR |
> > -            MSTATUS_TW;
> > +    mask = MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
> > +        MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
> > +        MSTATUS_MPP | MSTATUS_MXR | MSTATUS_TVM | MSTATUS_TSR |
> > +        MSTATUS_TW;
> >  #if defined(TARGET_RISCV64)
> > -            /*
> > -             * RV32: MPV and MTL are not in mstatus. The current plan is to
> > -             * add them to mstatush. For now, we just don't support it.
> > -             */
> > -            mask |= MSTATUS_MTL | MSTATUS_MPV;
> > +        /*
> > +         * RV32: MPV and MTL are not in mstatus. The current plan is to
> > +         * add them to mstatush. For now, we just don't support it.
> > +         */
> > +        mask |= MSTATUS_MTL | MSTATUS_MPV;
>
> The indentation level is wrong

Good catch.

>
> >  #endif
> > -    }
> >
> >      mstatus = (mstatus & ~mask) | (val & mask);
> >
> > @@ -553,8 +520,7 @@ static int write_mcounteren(CPURISCVState *env, int csrno, target_ulong val)
> >  /* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
> >  static int read_mscounteren(CPURISCVState *env, int csrno, target_ulong *val)
> >  {
> > -    if (env->priv_ver > PRIV_VERSION_1_09_1
> > -        && env->priv_ver < PRIV_VERSION_1_11_0) {
> > +    if (env->priv_ver < PRIV_VERSION_1_11_0) {
> >          return -1;
> >      }
> >      *val = env->mcounteren;
> > @@ -564,8 +530,7 @@ static int read_mscounteren(CPURISCVState *env, int csrno, target_ulong *val)
> >  /* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
> >  static int write_mscounteren(CPURISCVState *env, int csrno, target_ulong val)
> >  {
> > -    if (env->priv_ver > PRIV_VERSION_1_09_1
> > -        && env->priv_ver < PRIV_VERSION_1_11_0) {
> > +    if (env->priv_ver < PRIV_VERSION_1_11_0) {
> >          return -1;
> >      }
> >      env->mcounteren = val;
> > @@ -574,20 +539,13 @@ static int write_mscounteren(CPURISCVState *env, int csrno, target_ulong val)
> >
> >  static int read_mucounteren(CPURISCVState *env, int csrno, target_ulong *val)
> >  {
> > -    if (env->priv_ver > PRIV_VERSION_1_09_1) {
> > -        return -1;
> > -    }
> > -    *val = env->scounteren;
> > +    return -1;
> >      return 0;
> >  }
> >
> >  static int write_mucounteren(CPURISCVState *env, int csrno, target_ulong val)
> >  {
> > -    if (env->priv_ver > PRIV_VERSION_1_09_1) {
> > -        return -1;
> > -    }
> > -    env->scounteren = val;
> > -    return 0;
> > +    return -1;
> >  }
> >
> >  /* Machine Trap Handling */
> > @@ -829,13 +787,7 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
> >      if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
> >          return 0;
> >      }
> > -    if (env->priv_ver <= PRIV_VERSION_1_09_1 && (val ^ env->sptbr)) {
> > -        tlb_flush(env_cpu(env));
> > -        env->sptbr = val & (((target_ulong)
> > -            1 << (TARGET_PHYS_ADDR_SPACE_BITS - PGSHIFT)) - 1);
> > -    }
> > -    if (env->priv_ver >= PRIV_VERSION_1_10_0 &&
> > -        validate_vm(env, get_field(val, SATP_MODE)) &&
> > +    if (validate_vm(env, get_field(val, SATP_MODE)) &&
> >          ((val ^ env->satp) & (SATP_MODE | SATP_ASID | SATP_PPN)))
> >      {
> >          if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
> > diff --git a/target/riscv/insn_trans/trans_privileged.inc.c b/target/riscv/insn_trans/trans_privileged.inc.c
> > index 76c2fad71c..1af9fa7df8 100644
> > --- a/target/riscv/insn_trans/trans_privileged.inc.c
> > +++ b/target/riscv/insn_trans/trans_privileged.inc.c
> > @@ -95,12 +95,6 @@ static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a)
> >
> >  static bool trans_sfence_vm(DisasContext *ctx, arg_sfence_vm *a)
> >  {
> > -#ifndef CONFIG_USER_ONLY
> > -    if (ctx->priv_ver <= PRIV_VERSION_1_09_1) {
> > -        gen_helper_tlb_flush(cpu_env);
> > -        return true;
> > -    }
> > -#endif
> >      return false;
> >  }
>
> There are 3 more places in this file that should be cleaned up:
>
> ./target/riscv/insn_trans/trans_privileged.inc.c:88:    if
> (ctx->priv_ver >= PRIV_VERSION_1_10_0) {
> ./target/riscv/insn_trans/trans_privileged.inc.c:110:    if
> (ctx->priv_ver >= PRIV_VERSION_1_10_0 &&
> ./target/riscv/insn_trans/trans_privileged.inc.c:130:    if
> (ctx->priv_ver >= PRIV_VERSION_1_10_0 &&
>
> And the following place in monitor.c should be cleaned up too:
>
> ./target/riscv/monitor.c:218:    if (env->priv_ver < PRIV_VERSION_1_10_0) {
>
> And several other places in
>
> ./target/riscv/op_helper.c:87:    if (env->priv_ver >= PRIV_VERSION_1_10_0 &&
> ./target/riscv/op_helper.c:123:            env->priv_ver >=
> PRIV_VERSION_1_10_0 ?
> ./target/riscv/op_helper.c:151:        env->priv_ver >= PRIV_VERSION_1_10_0 ?
> ./target/riscv/op_helper.c:180:        env->priv_ver >= PRIV_VERSION_1_10_0 &&
> ./target/riscv/op_helper.c:196:         env->priv_ver >= PRIV_VERSION_1_10_0 &&

Yeah you are right. I have fixed all of these.

Alistair

>
> Regards,
> Bin

