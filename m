Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39064C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 13:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0037F20C56
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 13:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L24Cjb2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0037F20C56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC1H7-0006QE-84
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 09:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kC1GQ-0005pV-W6
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 09:51:27 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:35383)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kC1GP-00037X-5b
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 09:51:26 -0400
Received: by mail-ed1-x542.google.com with SMTP id ba12so1592902edb.2
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 06:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9KH9nr6joWT50Gqz1LjlhoH5FgAQwIqhLeZ95q8fYRM=;
 b=L24Cjb2dhWhZen6EmLvpzVFVaEBU8UitY2T4QuVyv88+8Zp9GW4Cv4RvUYhCuW4YKb
 R9uWfR9EnFSusK7uFtJT6MEkm/ciR/11MhWky+EigzHxXd4CyZhYdSodRpfELqge8tiF
 3fH/W8KMfqVfidkaQMRzpXfUIVkPTftfqmBpGkVDD1MlJBynafOeNKZNtuhMfXD9HayN
 F7CJFlKToUt3GXcdD4s4RFM1SydaiSfeT8DVyh4qXtDqZsAz8/k6P3bnneEJWm5+IcWJ
 ErQ0B0gwMzvS+SO/Ellcw/FATqMJgWH27cgVci1qhjXVYZRIzR9/I1EuVfm81uxoGR81
 60QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9KH9nr6joWT50Gqz1LjlhoH5FgAQwIqhLeZ95q8fYRM=;
 b=EIdbCZQ+fQCQ1djMtQ6An/CQQSWwT5nwwf9C59n0mrKn3zoKrIk8kU5zZfaBL0kgjy
 TEUUG/aK4w3K1WS4XGWWebs/M9EqeL6mDsc5K7NETTpVoBGmY2EuHkHdM4zjja3GIszs
 HJwGlQiulpWswY4uC0NLrm+LcdS1CEQJ7H45bJgk92Ieoknezg2841BCrz23plMq5csU
 M2SHE6yZHd/rK06P/xPf86cs+APk7HkFMKoMtQdwON9r5DHGube2BkPy/QdUpjoRuWxg
 U0gt+hbxtGtWep9q8LyKadegYp4Tpe8+vwxSQw7ZgUeyTLhroSbmZwpHbf1pmT7T1Qe/
 CXog==
X-Gm-Message-State: AOAM532LftO1GpiElZeKV40wedLKrZ7I8bNJ3Nb1Xu8HYJvLPigAVfSK
 YpMVVzT1vGrxWr28XbJ0vUITB1oZ6dr7EmOwLMpFVA==
X-Google-Smtp-Source: ABdhPJzwHpZYsmvX7RjjbpX8AarmRNm7V/ZCTsgAkzca8IBzsA5zTf8cVyr7OZJUobOe2QgxodjXstgcGA75Qap/5wc=
X-Received: by 2002:a50:f28b:: with SMTP id f11mr700070edm.44.1598709083473;
 Sat, 29 Aug 2020 06:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200828183354.27913-1-peter.maydell@linaro.org>
 <20200828183354.27913-44-peter.maydell@linaro.org>
 <a9995eb6-6cb6-f041-ea09-9104e9dc293e@linaro.org>
In-Reply-To: <a9995eb6-6cb6-f041-ea09-9104e9dc293e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 29 Aug 2020 14:51:12 +0100
Message-ID: <CAFEAcA_w4t4XsDbkws3MgDVW-9V6pzCY09pNU++9WGvtCCma2Q@mail.gmail.com>
Subject: Re: [PATCH v2 43/45] target/arm/vec_helper: Add gvec fp indexed
 multiply-and-add operations
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 29 Aug 2020 at 00:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/28/20 11:33 AM, Peter Maydell wrote:
> > +#define float16_nop(N, M, S) (M)
> > +#define float32_nop(N, M, S) (M)
> > +#define float64_nop(N, M, S) (M)
> >
> > +DO_FMUL_IDX(gvec_fmul_idx_h, nop, float16, H2)
> > +DO_FMUL_IDX(gvec_fmul_idx_s, nop, float32, H4)
> > +DO_FMUL_IDX(gvec_fmul_idx_d, nop, float64, )
> > +
> > +/*
> > + * Non-fused multiply-accumulate operations, for Neon. NB that unlike
> > + * the fused ops below they assume accumulate both from and into Vd.
> > + */
> > +DO_FMUL_IDX(gvec_fmla_nf_idx_h, add, float16, H2)
> > +DO_FMUL_IDX(gvec_fmla_nf_idx_s, add, float32, H4)
> > +DO_FMUL_IDX(gvec_fmls_nf_idx_h, sub, float16, H2)
> > +DO_FMUL_IDX(gvec_fmls_nf_idx_s, sub, float32, H4)
> > +
> > +#undef float16_nop
> > +#undef float32_nop
> > +#undef float64_nop
>
> This floatN_nop stuff is pretty ugly.
>
> Better to pass in either floatN_mul, or the floatN_muladd_nf helpers that you
> added earlier.  Although I guess you're missing float64_muladd_nf so far.

I thought about doing that, but the float*_muladd_nf functions
don't have the same signature as float*_mul -- they take
(dest, op1, op2, stat) and float*_mul only takes (op1, op2, stat) --
so it doesn't work. You'd have to construct a wrapper for
the mul function that took and ignored the dest argument,
or split out mul entirely into its own macro rather than
using DO_FMUL_IDX for mul and muladd. The nop macros seemed
the simplest.

thanks
-- PMM

