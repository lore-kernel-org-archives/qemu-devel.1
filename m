Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE42C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 20:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF0F20791
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 20:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKvHW3b7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF0F20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXVjs-0006Ls-SR
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 16:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kXViu-0005P5-UI; Tue, 27 Oct 2020 16:37:40 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:39456)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kXVit-00060x-3s; Tue, 27 Oct 2020 16:37:40 -0400
Received: by mail-il1-x141.google.com with SMTP id q1so2727794ilt.6;
 Tue, 27 Oct 2020 13:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X9RahUUyrifBPdfddEYb5xPOXPvLGCxS88vNDIAq6fE=;
 b=tKvHW3b7FlQoqDtzTGmfLyE5U8b/EdNScCh7rogBHV7ZHKYPWyEmck/cI0UTg9EBe2
 I3TEPjcRyzP3yg17EpzgBBcXNMjAk2hMUUmCVtpwo/LUdY+P8t7xL2fW6F7pwO2TBmMe
 DqO8JL/WW5vl4+FAxEuxta4rYZnbHvndPTtBKgNBd+PkirIN1+SUSpx2WoAx0Zzu5C1s
 UczTQv4QVysjHnHBsU8u7+3kFnXhnpLVbJGzsWNLgMmu6sYXINxTu2Zspopveom9ePcH
 MnDBf/r4ntSeuAS6G3fpkzywu0UaQh+4ePjG4S+2fKF31ru5UdCArd05B6CS9Bpi/aL5
 nA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X9RahUUyrifBPdfddEYb5xPOXPvLGCxS88vNDIAq6fE=;
 b=Kg2wjLEQyzDptDVyDRaXRznThNvalZ4I1MfJFAdrEE0n1l3rbpWqHJgwAao2vnWpgW
 GEErF53ZyN8RG/nfPPNrwyhRTIEg/KFJJeOFPEWzwBXGzx5LEvITjkxbJrnXieT5FhAx
 PFPPL++1QKQbB5iZBWxsmVNwfiuGeh5sYC/ZRucjX/5MlBdDEaOYp5/5/AweoLzpOqhJ
 edbJxLKJYg2chaLLuFJ2qbge8eqqnx3tenJ110/GkDYrQtiCPAB/suB3L+a8cBF6+bvT
 yimwzMbuPNuPZgX5W48xvps4j3cNHlS6PROh3ia488+68sZG2+G28zE58mIMU1ZENlXa
 0vFg==
X-Gm-Message-State: AOAM532mC0WpzbTXcoKTwgAZ1s9hY2cADi09FqHG9BrrxSKLDYwifATT
 btJ+4QqFCKT4+lDSaKKSStmPxk0eyyBfDrKL41Q=
X-Google-Smtp-Source: ABdhPJwCfMMKQipOiyfFa3KsPL3RkL+VQ1pmuPeT3DqsHwlOn1+j6s6j1cbuL7cc5YF5H9N3vmlvrMW+AlVdw4Ahrks=
X-Received: by 2002:a92:c5ce:: with SMTP id s14mr3539452ilt.40.1603831057442; 
 Tue, 27 Oct 2020 13:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603467169.git.alistair.francis@wdc.com>
 <6b17e9aff7bd6823574a94dc0d615117ce6edef6.1603467169.git.alistair.francis@wdc.com>
 <CAEUhbmVtYUro2QBKKhDkQNF3go7HjNr-QBj0=msvG9_hhhHYgg@mail.gmail.com>
In-Reply-To: <CAEUhbmVtYUro2QBKKhDkQNF3go7HjNr-QBj0=msvG9_hhhHYgg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Oct 2020 13:25:47 -0700
Message-ID: <CAKmqyKM5bNqK0K4f9by0vQFbmm7C0Gxqy_V=2Ao8i=HB8k=EPg@mail.gmail.com>
Subject: Re: [PATCH v1 12/16] target/riscv: cpu_helper: Remove compile time
 XLEN checks
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 26, 2020 at 1:56 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Fri, Oct 23, 2020 at 11:45 PM Alistair Francis
> <alistair.francis@wdc.com> wrote:
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/cpu.h        |  6 ++---
> >  target/riscv/cpu_helper.c | 52 ++++++++++++++++++++-------------------
> >  2 files changed, 29 insertions(+), 29 deletions(-)
> >
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 6096243aed..8bde15544d 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -194,9 +194,8 @@ struct CPURISCVState {
> >      target_ulong vscause;
> >      target_ulong vstval;
> >      target_ulong vsatp;
> > -#ifdef TARGET_RISCV32
> > +    /* This is RV32 only */
> >      target_ulong vsstatush;
>
> nits: could we move the definition to the line just below where
> vsstatus is defined in this structure, like other similar *h members?

This has been removed in the latest rebase.

Alistair

>
> > -#endif
> >
> >      target_ulong mtval2;
> >      target_ulong mtinst;
> > @@ -209,9 +208,8 @@ struct CPURISCVState {
> >      target_ulong stval_hs;
> >      target_ulong satp_hs;
> >      target_ulong mstatus_hs;
> > -#ifdef TARGET_RISCV32
> > +    /* This is RV32 only */
> >      target_ulong mstatush_hs;
> > -#endif
> >
> >      target_ulong scounteren;
> >      target_ulong mcounteren;
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index 4652082df1..62aed24feb 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -126,10 +126,10 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
> >          env->mstatus &= ~mstatus_mask;
> >          env->mstatus |= env->mstatus_hs;
> >
> > -#if defined(TARGET_RISCV32)
> > -        env->vsstatush = env->mstatush;
> > -        env->mstatush |= env->mstatush_hs;
> > -#endif
> > +        if (riscv_cpu_is_32bit(env)) {
> > +            env->vsstatush = env->mstatush;
> > +            env->mstatush |= env->mstatush_hs;
> > +        }
> >
> >          env->vstvec = env->stvec;
> >          env->stvec = env->stvec_hs;
> > @@ -154,10 +154,10 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
> >          env->mstatus &= ~mstatus_mask;
> >          env->mstatus |= env->vsstatus;
> >
> > -#if defined(TARGET_RISCV32)
> > -        env->mstatush_hs = env->mstatush;
> > -        env->mstatush |= env->vsstatush;
> > -#endif
> > +        if (riscv_cpu_is_32bit(env)) {
> > +            env->mstatush_hs = env->mstatush;
> > +            env->mstatush |= env->vsstatush;
> > +        }
> >
> >          env->stvec_hs = env->stvec;
> >          env->stvec = env->vstvec;
> > @@ -472,11 +472,13 @@ restart:
> >              return TRANSLATE_PMP_FAIL;
> >          }
> >
> > -#if defined(TARGET_RISCV32)
> > -        target_ulong pte = address_space_ldl(cs->as, pte_addr, attrs, &res);
> > -#elif defined(TARGET_RISCV64)
> > -        target_ulong pte = address_space_ldq(cs->as, pte_addr, attrs, &res);
> > -#endif
> > +        target_ulong pte;
> > +        if (riscv_cpu_is_32bit(env)) {
> > +            pte = address_space_ldl(cs->as, pte_addr, attrs, &res);
> > +        } else {
> > +            pte = address_space_ldq(cs->as, pte_addr, attrs, &res);
> > +        }
> > +
> >          if (res != MEMTX_OK) {
> >              return TRANSLATE_FAIL;
> >          }
> > @@ -995,19 +997,19 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >              if (riscv_cpu_virt_enabled(env)) {
> >                  riscv_cpu_swap_hypervisor_regs(env);
> >              }
> > -#ifdef TARGET_RISCV32
> > -            env->mstatush = set_field(env->mstatush, MSTATUS_MPV,
> > -                                       riscv_cpu_virt_enabled(env));
> > -            if (riscv_cpu_virt_enabled(env) && tval) {
> > -                env->mstatush = set_field(env->mstatush, MSTATUS_GVA, 1);
> > -            }
> > -#else
> > -            env->mstatus = set_field(env->mstatus, MSTATUS_MPV,
> > -                                      riscv_cpu_virt_enabled(env));
> > -            if (riscv_cpu_virt_enabled(env) && tval) {
> > -                env->mstatus = set_field(env->mstatus, MSTATUS_GVA, 1);
> > +            if (riscv_cpu_is_32bit(env)) {
> > +                env->mstatush = set_field(env->mstatush, MSTATUS_MPV,
> > +                                           riscv_cpu_virt_enabled(env));
>
> nits: looks the alignment is not on the left parenthesis
>
> > +                if (riscv_cpu_virt_enabled(env) && tval) {
> > +                    env->mstatush = set_field(env->mstatush, MSTATUS_GVA, 1);
> > +                }
> > +            } else {
> > +                env->mstatus = set_field(env->mstatus, MSTATUS_MPV,
> > +                                          riscv_cpu_virt_enabled(env));
>
> ditto
>
> > +                if (riscv_cpu_virt_enabled(env) && tval) {
> > +                    env->mstatus = set_field(env->mstatus, MSTATUS_GVA, 1);
> > +                }
> >              }
> > -#endif
> >
> >              mtval2 = env->guest_phys_fault_addr;
> >
>
> Regards,
> Bin

