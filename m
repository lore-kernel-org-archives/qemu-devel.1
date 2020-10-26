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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E283C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:29:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70A482222C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrNjT2La"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A482222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX4Qc-00014P-Dg
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 11:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kX4Pw-0000Z4-EB; Mon, 26 Oct 2020 11:28:16 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:33139)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kX4Pu-00089B-RV; Mon, 26 Oct 2020 11:28:16 -0400
Received: by mail-il1-x141.google.com with SMTP id f16so1145329ilr.0;
 Mon, 26 Oct 2020 08:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DD/T7sj+ICbpJaUZDvl+PbkEQRSCyuwmsQ7/VCJTxRQ=;
 b=MrNjT2LaBblALrEaMv8b1qvCrUU5VYV56IO/3kxpjZO2TCZ7q0+vIdQKAt3pGgwafB
 1MnlHLLH8kv3fBrvqvUukz3s6GqX2zVsltIL8kTuYFCVOIIdk717a1eqE6+ZjZys82KG
 wxxJUDC4TT4fIMq6noli/GnidQfWiWMYGjpiUi6KmPtrOqq/b7g4A7n58N383i3+St0R
 6s84Mnpe2NWS4FGa7jAaqCLXPUmH8/V+IHJeIR1MIDRZ8sEMeBUtzDavoYZXcW+bGQzI
 /CfMvolugVmA9+eyO8/tpqhLerfIkCdqnLhn5x+C4Gg7yueg378srf8+yxXoWmAYTYe9
 4Jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DD/T7sj+ICbpJaUZDvl+PbkEQRSCyuwmsQ7/VCJTxRQ=;
 b=pK9irM9Yp0dcXbuYHPoPT+QbCJGbrCKmcAx37LgBw25CpOP2tJEdhXNhCmy+k4ntZT
 lq8ytB3xJIltOv/cfTbiqv5yTb+AGlDE2Q8WVs++WHC08g53bnZtuqKSoqMBzhhilWyr
 XxfiLA/rsMvqScvQjBZCa/rJEiwAFLqx80gQm053Tm9Kwutp3M+ev4Vt4QVoXnDhGH2u
 NBT+iJSmgi7uvmZj0Ss1Y7Eazu8j05fX37jU6aez+fYXoZBttWgIPHy6izrjcbff28yq
 BCZvuxipYpAR8Jtdgahm+GRI4ppE5sv/Y2zAVUqEa8/4RHMGWN7JLlKb4WKW2t5RAJtp
 CZbg==
X-Gm-Message-State: AOAM5336F4aIntyK+ISOKMjEVa94xb01nbRP7Grqeit7GrAk9vpewMB9
 Cx2xWRm09RfJmKqIxuiUQDz99yhov9LVFAWdjOf1ZK3z1ds=
X-Google-Smtp-Source: ABdhPJzD/2TG+K2IbM9DtupM+28kG3eaaF3ZatH4HXlfU92RfsHDDnr8X/EXjQxB1IknNQaWF0mLxFBTR30vmkIfDkc=
X-Received: by 2002:a05:6e02:f41:: with SMTP id
 y1mr4496506ilj.267.1603726093336; 
 Mon, 26 Oct 2020 08:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603467169.git.alistair.francis@wdc.com>
 <8786fd77439c26f677eeac2eccedf75ba3b68bb4.1603467169.git.alistair.francis@wdc.com>
 <CAEUhbmUotC9UXgSH2GiipxZ6nrzHvWMFgYqjGE4AF8mO3JSAmw@mail.gmail.com>
In-Reply-To: <CAEUhbmUotC9UXgSH2GiipxZ6nrzHvWMFgYqjGE4AF8mO3JSAmw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Oct 2020 08:16:25 -0700
Message-ID: <CAKmqyKORAbDmGM3H96g7RVaT9VPYzdaUp+Z8g4+fzD4Jb+cigw@mail.gmail.com>
Subject: Re: [PATCH v1 08/16] target/riscv: fpu_helper: Match function defs in
 HELPER macros
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
> On Fri, Oct 23, 2020 at 11:44 PM Alistair Francis
> <alistair.francis@wdc.com> wrote:
> >
>
> Could you please put some details as to why changing uint64_t to
> target_ulong (and vice versa) is needed?

Done!

Alistair

>
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/fpu_helper.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
> > index bb346a8249..507d7fe7fa 100644
> > --- a/target/riscv/fpu_helper.c
> > +++ b/target/riscv/fpu_helper.c
> > @@ -224,13 +224,13 @@ target_ulong helper_fcvt_wu_s(CPURISCVState *env, uint64_t rs1)
> >  }
> >
> >  #if defined(TARGET_RISCV64)
> > -uint64_t helper_fcvt_l_s(CPURISCVState *env, uint64_t rs1)
> > +target_ulong helper_fcvt_l_s(CPURISCVState *env, uint64_t rs1)
> >  {
> >      float32 frs1 = check_nanbox_s(rs1);
> >      return float32_to_int64(frs1, &env->fp_status);
> >  }
> >
> > -uint64_t helper_fcvt_lu_s(CPURISCVState *env, uint64_t rs1)
> > +target_ulong helper_fcvt_lu_s(CPURISCVState *env, uint64_t rs1)
> >  {
> >      float32 frs1 = check_nanbox_s(rs1);
> >      return float32_to_uint64(frs1, &env->fp_status);
> > @@ -248,12 +248,12 @@ uint64_t helper_fcvt_s_wu(CPURISCVState *env, target_ulong rs1)
> >  }
> >
> >  #if defined(TARGET_RISCV64)
> > -uint64_t helper_fcvt_s_l(CPURISCVState *env, uint64_t rs1)
> > +uint64_t helper_fcvt_s_l(CPURISCVState *env, target_ulong rs1)
> >  {
> >      return nanbox_s(int64_to_float32(rs1, &env->fp_status));
> >  }
> >
> > -uint64_t helper_fcvt_s_lu(CPURISCVState *env, uint64_t rs1)
> > +uint64_t helper_fcvt_s_lu(CPURISCVState *env, target_ulong rs1)
> >  {
> >      return nanbox_s(uint64_to_float32(rs1, &env->fp_status));
> >  }
> > @@ -337,12 +337,12 @@ target_ulong helper_fcvt_wu_d(CPURISCVState *env, uint64_t frs1)
> >  }
> >
> >  #if defined(TARGET_RISCV64)
> > -uint64_t helper_fcvt_l_d(CPURISCVState *env, uint64_t frs1)
> > +target_ulong helper_fcvt_l_d(CPURISCVState *env, uint64_t frs1)
> >  {
> >      return float64_to_int64(frs1, &env->fp_status);
> >  }
> >
> > -uint64_t helper_fcvt_lu_d(CPURISCVState *env, uint64_t frs1)
> > +target_ulong helper_fcvt_lu_d(CPURISCVState *env, uint64_t frs1)
> >  {
> >      return float64_to_uint64(frs1, &env->fp_status);
> >  }
> > @@ -359,12 +359,12 @@ uint64_t helper_fcvt_d_wu(CPURISCVState *env, target_ulong rs1)
> >  }
> >
> >  #if defined(TARGET_RISCV64)
> > -uint64_t helper_fcvt_d_l(CPURISCVState *env, uint64_t rs1)
> > +uint64_t helper_fcvt_d_l(CPURISCVState *env, target_ulong rs1)
> >  {
> >      return int64_to_float64(rs1, &env->fp_status);
> >  }
> >
> > -uint64_t helper_fcvt_d_lu(CPURISCVState *env, uint64_t rs1)
> > +uint64_t helper_fcvt_d_lu(CPURISCVState *env, target_ulong rs1)
> >  {
> >      return uint64_to_float64(rs1, &env->fp_status);
> >  }
> > --
>
> Regards,
> Bin

