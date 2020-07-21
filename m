Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE88C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14BE52065F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7pnYrlk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14BE52065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxu5u-0003eK-8p
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 11:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jxu5D-0002tf-BY; Tue, 21 Jul 2020 11:21:31 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:43547)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jxu5B-000585-SM; Tue, 21 Jul 2020 11:21:31 -0400
Received: by mail-io1-xd43.google.com with SMTP id k23so21790658iom.10;
 Tue, 21 Jul 2020 08:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B/WewGkuED5ZclfNuICMT67tC9Y0KAaeDc8gnr/D54Q=;
 b=E7pnYrlkEXAAhuiMhovn3MPu+81vCx5yCXawGyFNBJC6AiOTDOob7hrIevQUsUmcvS
 pHef+lGT4UrH//JmYGQMmlOsTNBSG78MsFfuqVp+ga8WzLVY9C4RcheOG9wCuT6cjjX6
 DH8zzna46O92mYJz6FInQTVKfuiHbt/xpVztwuMP+O2dJs0IJk2smz3JF9rxj5VBp0DM
 yGVDwVSVaeOnLh7ae08NRLtFBEh/VN+sjAr9n+IFJGk/4XF3Mf0s45TlzuvdYrlcy3SS
 Kw6aAUndCaTNydEvIw0vRYKM82XfIReE7fQFuq2FDyfexqALIaFS2E6gX1QElG3+PMOE
 3HRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B/WewGkuED5ZclfNuICMT67tC9Y0KAaeDc8gnr/D54Q=;
 b=tK30jk/6lZba+utNF8QLO7+aRlcdX6+/GcScsrsXQi+Cklw1xCeHhb3xTsnMFBCOFt
 t7U3V5mYC4ScfVkKIsZV8VSSJ2z3d3y0Kun2mbfYd9LkJ2Zx0VEHoDJ1ODiTKxoppu7r
 kWI0oaa+/9odTCUnTpUoZaVJGuaJG+i1aOOgbHVpqIBeL2Gf01800wm7xdx8RfHMsbhY
 3LtCZbEUXupWFmuv/Apqg7B/Cq6o8VpC22VUeTlD1qB0qRBGtTz7EQ2Cxy1bHRJYl5rb
 M6BwqgrRhvCNL2fGe/EXtynyQpR0JXJd5DfvPivZ+NOrgPoLUkiDunEC7ZW3fJujr7ez
 ZL7A==
X-Gm-Message-State: AOAM530q6451I8pJiJeKdHbpW8CoeQW3XkieQIxG2p6NYSlhvxQHMrJ7
 SCuv1zw0JVTNJjzBQ5xx6VLNRFGfHFafWSCZNzY=
X-Google-Smtp-Source: ABdhPJxZTgGDhzLoCe/0QER79v1EQDAhKkC79ytFKTiqBjDzQM3u5B+mr0p4EaUuSpNVUo9osTGtlaoHGhO1MAg+Euw=
X-Received: by 2002:a02:7092:: with SMTP id f140mr3548254jac.8.1595344888308; 
 Tue, 21 Jul 2020 08:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200721133742.2298-1-zhiwei_liu@c-sky.com>
 <20200721133742.2298-2-zhiwei_liu@c-sky.com>
In-Reply-To: <20200721133742.2298-2-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Jul 2020 08:11:22 -0700
Message-ID: <CAKmqyKPVPJDAYdUQrMLS6db8E1dqosGV5bN5Qeoqk7Ox_+G9_w@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/riscv: fix vector index load/store constraints
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 21, 2020 at 6:38 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Although not explicitly specified that the the destination
> vector register groups cannot overlap the source vector register group,
> it is still necessary.
>
> And this constraint has been added to the v0.8 spec.
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rvv.inc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index 7b4752b911..887c6b8883 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -513,13 +513,21 @@ static bool ld_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
>      return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s);
>  }
>
> +/*
> + * For vector indexed segment loads, the destination vector register
> + * groups cannot overlap the source vector register group (specified by
> + * `vs2`), else an illegal instruction exception is raised.
> + */
>  static bool ld_index_check(DisasContext *s, arg_rnfvm* a)
>  {
>      return (vext_check_isa_ill(s) &&
>              vext_check_overlap_mask(s, a->rd, a->vm, false) &&
>              vext_check_reg(s, a->rd, false) &&
>              vext_check_reg(s, a->rs2, false) &&
> -            vext_check_nf(s, a->nf));
> +            vext_check_nf(s, a->nf) &&
> +            ((a->nf == 1) ||
> +             vext_check_overlap_group(a->rd, a->nf << s->lmul,
> +                                      a->rs2, 1 << s->lmul)));
>  }
>
>  GEN_VEXT_TRANS(vlxb_v, 0, rnfvm, ld_index_op, ld_index_check)
> --
> 2.23.0
>
>

