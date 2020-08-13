Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA39C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 21:31:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97165206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 21:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQ+LpH/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97165206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Kp4-00072A-Gg
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 17:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k6Knu-0005pH-Vd
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 17:30:30 -0400
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a]:32982)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k6Knt-00050f-2C
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 17:30:30 -0400
Received: by mail-io1-xd2a.google.com with SMTP id g14so8939315iom.0
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 14:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZRASCjq07u8rSoC9dPeipnSstfIMDmcFUM3c9LTfpns=;
 b=LQ+LpH/UQl9Fi1m7vuTqCilyRh7Mi9dQoz8sSbMqgJPlIbpzSHP0ST508wUUOxdBja
 OQu0qOG0R3ACnW+QtEUWbwa+Bn80cq9QsxSIvvZa0q5uSF+LCh81d6KeDIsUkiF8cWyI
 UHV90HXP82sbmAZoNx+xU72N/tHOY1+hRaNUFguwnU3mQXMrc4tykUSPFLZWIo3sVyqC
 QOPmdJPnZr9pgRU3qaKyY3Rg71dvsjnr4wi4dC4T2M5LaT/WmvBRXDlOKxXt6CrxWFTc
 8D3K3CSL9p8PG4ZyF2hwOjuUSbzltvKw1qs+M0MY/bwv8XglAV2LwnguXCS5tNLdkcow
 uJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZRASCjq07u8rSoC9dPeipnSstfIMDmcFUM3c9LTfpns=;
 b=UOSA0y6VZDDi8XUruq+bcMMEh9zjOiQ0Qu7nfRnv63nfTfuEG47lngZEqMv6TvTZwP
 D/kBVNuJ/Lw6NXly/JWGLDh9kwozpHZRNa/Mw0NPpRObKat52TrCXA+bFPWrkD0J7yMV
 YlMM65GWPQz3WuZF5vbljQOpq8O3Qi+yMWCLZK00Z06m7S0Ud/yyPeZJdYglBLqDQ5w7
 EJk6Gj1z8+n4YODrMKd2QRgbH3LBICTBglvhXkLuV74vsMzwhUy1n+QHO8BHulLrdAqJ
 AiAvjklWLfccDvsGxibh4txOXrs5fFzrK0H4T9fFFfcLYg+JcoOOtbNY4MIoyx2NZdff
 zplQ==
X-Gm-Message-State: AOAM532IcHJE2rvc73LAbUtzvme6bXY9W/Dw1ruVeQWjCzGCZovNzZP0
 oWZpO23xaK1VthWOY9/Jgx4xr4nRtC5mK6akh3c=
X-Google-Smtp-Source: ABdhPJyrc5kggmrvV3LAqHPDYN2qcvveda0uwt3OvES8v1tdnLd2vtPvwJYEfSSuoKqrjxaKam/Fd0vSiUZA4GL/4+g=
X-Received: by 2002:a6b:400e:: with SMTP id k14mr6547866ioa.175.1597354227852; 
 Thu, 13 Aug 2020 14:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200812223045.96803-1-alistair.francis@wdc.com>
 <20200812223045.96803-6-alistair.francis@wdc.com>
 <39d42765-01de-2439-093d-c0246d81a7ce@c-sky.com>
 <CAKmqyKMBpR0R4C+81GVjjcq39rHDJ9YHUTekopogxnsh1UYWhQ@mail.gmail.com>
 <dca8e8bb-5f30-84e1-c2a1-02b281c24c79@linaro.org>
In-Reply-To: <dca8e8bb-5f30-84e1-c2a1-02b281c24c79@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 13 Aug 2020 14:19:57 -0700
Message-ID: <CAKmqyKNKwUixJBKfKs6EedN0ZxpZ-SCQduyvbKb-gf1R=4odUg@mail.gmail.com>
Subject: Re: [PULL 05/20] target/riscv: Check nanboxed inputs in
 trans_rvf.inc.c
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2a;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd2a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Chih-Min Chao <chihmin.chao@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 13, 2020 at 9:48 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/13/20 7:46 AM, Alistair Francis wrote:
> >> Hi Alistair,
> >>
> >> As Chih-Min said, it's wrong here.  He has given the correct patch code
> >> https://www.mail-archive.com/qemu-devel@nongnu.org/msg728540.html
> >>
> >> We can either  squash the code to this patch or add an separate patch
> >> later. I prefer the former.
> >> Thanks very much.
> >
> > Richard are you ok if I squash this diff into the patch and send a PR v2?
> >
> > diff --git a/target/riscv/insn_trans/trans_rvf.inc.c
> > b/target/riscv/insn_trans/trans_rvf.inc.c
> > index f9a9e0643a..76f281d275 100644
> > --- a/target/riscv/insn_trans/trans_rvf.inc.c
> > +++ b/target/riscv/insn_trans/trans_rvf.inc.c
> > @@ -201,7 +201,8 @@ static bool trans_fsgnjn_s(DisasContext *ctx,
> > arg_fsgnjn_s *a)
> >           * This formulation retains the nanboxing of rs1.
> >           */
> >          mask = tcg_const_i64(~MAKE_64BIT_MASK(31, 1));
> > -        tcg_gen_andc_i64(rs2, mask, rs2);
> > +        tcg_gen_not_i64(rs2, rs2);         // forget to inverse rs2
> > +        tcg_gen_andc_i64(rs2, rs2, mask);  //mask needs to be
>
> Ah, well.  Yes, it's a bug.  However,
>
>    ~rs2 & ~mask
> = ~(rs2 | mask)
>
> so a better fix could be
>
> -    tcg_gen_andc_i64(rs2, mask, rs2);
> +    tcg_gen_nor_i64(rs2, rs2, mask);

Fixed.

Alistair

>
>
> As an aside, I think perhaps I should have added a ppc-style rotate-and-insert
> primitive to handle this sort of bitfield insert, since the best set of host
> insns to perform this operation, when the start of the field is not bit 0, is
> difficult to predict from the translator.
>
>
> r~

