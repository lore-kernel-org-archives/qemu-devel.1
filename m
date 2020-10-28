Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C927FC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 21:04:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA12024836
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 21:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdiPOUQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA12024836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXsce-0001mx-QX
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 17:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kXsbH-0001Cj-63; Wed, 28 Oct 2020 17:03:19 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:37587)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kXsbF-0005Rj-9t; Wed, 28 Oct 2020 17:03:18 -0400
Received: by mail-io1-xd44.google.com with SMTP id q25so966375ioh.4;
 Wed, 28 Oct 2020 14:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TsL3Jj41MNVM8Xv1or+fBZGng4LvzbPF6efeJYcIiKY=;
 b=HdiPOUQ5cXzaOGMZOAOz0kkZN0VHmTAIEpczqCyEtHszBkjzmXIghy4Ikvb3O++7+r
 szR1bPVYB06EX70vPHl5NpOoGAHjLHenR8OxR6dzdbMkGY8xF1TDJza23kyWwJyZ1Cqw
 ILme91lNHkfKgv7X+jGgRKSbRfGWNyDTE0ketE2iKhg8rnu1/s4X6xB+T6jUOChFFD71
 /Y3Y8jl5Lnki5FZJjB9Yga6Nb/MzqV1CdxAKP7P0VtuCFWN0XF95LSIk7we3YPeo5k2w
 uNSV+h2KkvLhq9nSApKAAx4x2J0jd2BDI/E+inmpUBsxBTaa7ZhKussYuW7eHES5r7h2
 0AAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TsL3Jj41MNVM8Xv1or+fBZGng4LvzbPF6efeJYcIiKY=;
 b=tdqzU5O3rdITWqfgLhJ1EawPvGfbBG10OQnIiBW2iCofmxtKX3hyeMxGw26z1LlCWy
 CYx4gI6GL2qqb4NkhgIXBJnGD9IaHge1uDcBOYKmMOdmgrQ5pd/gdpnGzfCOyDnSePvv
 ucz5BFpE99BaW79OycPJWHxgm7plNUqEVgGlUnqYKGwP6YAIW0tidzD9uWemph8kKmyf
 oX/fYiM4WirG78cHs4xT4J7jQTkG1ki23maGqak6p1D4NrnKxZ6VGmRzG3Os7mATLoPa
 cPaG+Rk/9B2Cauaa/DkfC7BqMjBijyUAymqZNfAMt5E0lK6p4fNMD3/oLUB/H4vadylJ
 CiXA==
X-Gm-Message-State: AOAM533Zy6qOr/XTLB5c27/c0J1/2jEnD205OYSKEuXC4g9bZQRVTW6Z
 C6zN8Wqcov/e/K0/rk/WNmx5fdh+TEU3A5OVCng=
X-Google-Smtp-Source: ABdhPJw6/hcUlT7eSaNf5LsZMWhrsZOXWJGPoTg3azvY41fsKTIpAfnCeClrSaXZ86YvuR+X5R6YCUtYWJ/fD7lGRcI=
X-Received: by 2002:a6b:c9c9:: with SMTP id z192mr1003942iof.175.1603918995970; 
 Wed, 28 Oct 2020 14:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603896075.git.alistair.francis@wdc.com>
 <d0eeb9ea64462044a67f5b803d6cb62dd10e017a.1603896075.git.alistair.francis@wdc.com>
 <f8c23bed-3b6c-e01d-cb04-ce945d509970@linaro.org>
In-Reply-To: <f8c23bed-3b6c-e01d-cb04-ce945d509970@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 28 Oct 2020 13:51:24 -0700
Message-ID: <CAKmqyKNGUcz+WkNNY6dac5d0cypAw4jFiBQFvxAwTQyK0mkGtw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] target/riscv: Add a virtualised MMU Mode
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
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
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 28, 2020 at 8:13 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/28/20 7:42 AM, Alistair Francis wrote:
> > Add a new MMU mode that includes the current virt mode.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/cpu-param.h  | 10 +++++++++-
> >  target/riscv/cpu.h        |  4 +++-
> >  target/riscv/cpu_helper.c |  6 +++++-
> >  3 files changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/target/riscv/cpu-param.h b/target/riscv/cpu-param.h
> > index 664fc1d371..0db6e23140 100644
> > --- a/target/riscv/cpu-param.h
> > +++ b/target/riscv/cpu-param.h
> > @@ -18,6 +18,14 @@
> >  # define TARGET_VIRT_ADDR_SPACE_BITS 32 /* sv32 */
> >  #endif
> >  #define TARGET_PAGE_BITS 12 /* 4 KiB Pages */
> > -#define NB_MMU_MODES 4
> > +/*
> > + * The current MMU Modes are:
> > + *  - U  mode 0b000
> > + *  - S  mode 0b001
> > + *  - M  mode 0b011
> > + *  - HU mode 0b100
> > + *  - HS mode 0b101
> > + */
> > +#define NB_MMU_MODES 6
> >
> >  #endif
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 87b68affa8..5d8e54c426 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -363,7 +363,9 @@ void QEMU_NORETURN riscv_raise_exception(CPURISCVState *env,
> >  target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
> >  void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
> >
> > -#define TB_FLAGS_MMU_MASK   3
> > +#define TB_FLAGS_MMU_MASK   7
> > +#define TB_FLAGS_PRIV_MMU_MASK                3
> > +#define TB_FLAGS_PRIV_HYP_ACCESS_MASK   (1 << 2)
> >  #define TB_FLAGS_MSTATUS_FS MSTATUS_FS
> >
> >  typedef CPURISCVState CPUArchState;
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index 3eb3a034db..453e4c6d8a 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -30,6 +30,10 @@ int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
> >  #ifdef CONFIG_USER_ONLY
> >      return 0;
> >  #else
> > +    if (riscv_cpu_virt_enabled(env)) {
> > +        return env->priv | TB_FLAGS_PRIV_HYP_ACCESS_MASK;
> > +    }
>
> This is wrong.  You only want to set this flag in response to one of the
> hypervisor special instructions.  This is setting it any time virt is enabled.

Isn't that ok though? I thought this was the correct approach.

Now we have a MMU context for Virtual guests (VS) which have different
contexts to the hypervisor (S). It also then means that when doing the
hypervisor access load/stores we can re-use the existing MMU context
from when the Hypervisor guest was running.

Alistair

>
>
> r~

