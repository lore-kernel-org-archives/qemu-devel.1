Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A0AC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 21:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FF9620838
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 21:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N9yLLRLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF9620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBm85-0004Mb-5D
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 17:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBm72-0003Uh-9S
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 17:40:44 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:38025)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBm6z-0003Ii-3E
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 17:40:43 -0400
Received: by mail-ej1-x643.google.com with SMTP id oz20so1005209ejb.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 14:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WAAqBab0dsaOmEhirldciEMZEwkJuEViOintycNFPAM=;
 b=N9yLLRLggf0d37kPNyOcqRtC6aabQpbRQJAKop/MHxZWLyuIwsQe1Kkr5gNuuUz+Ay
 Rz4hpMQyTVOl+Fs3ezqSIaT9NNlaE+1f3Ke72kck3s8G7whNlaJTKxBzJnytQ3AGZhSg
 ojUc0MixGAQoVBz/b9TLQGMfci8SZGvB4pq7XMWca2cIBKp7ZG5XncBL3WRMxGh8XSpY
 EqiaIlWvqwhv/D5apwAbMPtzdP8Qs+mXaKEDn+XUxen/sw5ZLnMlgq4hVRuGnAPRjUJ5
 eAgMGSmBjhx1t3TUH9Iv7hnTkRjGzvCeWLSX7FJ1rzr8Gqt5Tor+ONO3xbnq2cDG+wRH
 vgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WAAqBab0dsaOmEhirldciEMZEwkJuEViOintycNFPAM=;
 b=tYORJ9Au41oPSzNSav5lQmROMvI00jdBFhLgwE0oohg3hDMW0vA7kpufNZMbgHFC4e
 Fy+3onwxCyU3dpaKkyVt64rQpBdzd62vBsSKGOMZHwDbC2/9boptQib2XSTcceuy2yUE
 h2IUBqyw1x5Z7ZioTZF9aOsZGKCDluJIbpkjmacXqg8gAK2cMWFo/vEbstqlfGAGp5b6
 bxaQQNrZiekR4O/EdJSGNRlgB8zIGjWvNYdKSwJkAdcaa3McCiwtDugpLnoHFe57F+hA
 R7RLeM/3dn5WUjzyIWlIiEPgRygzeTbZ8kQz56lPNfEPFSCvG68tGBFdIqfBZeO8ku5g
 Vlhg==
X-Gm-Message-State: AOAM531/EUXhG9HmWmyqM/oEg8ZHw5eLGlAWr4lRmQH08Y+p9CDzxbZK
 oGJzGoGWsrXf1UfMc2dqprnsWaIIRFoXe0FwLodGxQ==
X-Google-Smtp-Source: ABdhPJwaP1W+cX+ydxrXL36HgoR7HkyNwUtEyOivE5KCl0ne4EdRVAidAe6zBffxkCDHxHN1jRMRLeBPV+S9yggQ0JA=
X-Received: by 2002:a17:906:f28b:: with SMTP id
 gu11mr717177ejb.407.1598650839367; 
 Fri, 28 Aug 2020 14:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200828183354.27913-1-peter.maydell@linaro.org>
 <20200828183354.27913-25-peter.maydell@linaro.org>
 <55675521-a61c-186c-599f-7373e9165184@linaro.org>
In-Reply-To: <55675521-a61c-186c-599f-7373e9165184@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Aug 2020 22:40:28 +0100
Message-ID: <CAFEAcA87JLog+Ly5wvRi2bOvwDvFVL5mjpnkeB3h+pckbnNMmQ@mail.gmail.com>
Subject: Re: [PATCH v2 24/45] target/arm: Implement fp16 for Neon VRECPE,
 VRSQRTE using gvec
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 28 Aug 2020 at 21:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/28/20 11:33 AM, Peter Maydell wrote:
> > We already have gvec helpers for floating point VRECPE and
> > VRQSRTE, so convert the Neon decoder to use them and
> > add the fp16 support.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  target/arm/translate-neon.c.inc | 29 +++++++++++++++++++++++++++--
> >  1 file changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
> > index 9d0959517fa..872f093a1fc 100644
> > --- a/target/arm/translate-neon.c.inc
> > +++ b/target/arm/translate-neon.c.inc
> > @@ -3857,13 +3857,38 @@ static bool do_2misc_fp(DisasContext *s, arg_2misc *a,
> >          return do_2misc_fp(s, a, FUNC);                         \
> >      }
> >
> > -DO_2MISC_FP(VRECPE_F, gen_helper_recpe_f32)
> > -DO_2MISC_FP(VRSQRTE_F, gen_helper_rsqrte_f32)
> >  DO_2MISC_FP(VCVT_FS, gen_helper_vfp_sitos)
> >  DO_2MISC_FP(VCVT_FU, gen_helper_vfp_uitos)
> >  DO_2MISC_FP(VCVT_SF, gen_helper_vfp_tosizs)
> >  DO_2MISC_FP(VCVT_UF, gen_helper_vfp_touizs)
> >
> > +#define DO_2MISC_FP_VEC(INSN, HFUNC, SFUNC)                             \
> > +    static void gen_##INSN(unsigned vece, uint32_t rd_ofs,              \
> > +                           uint32_t rm_ofs,                             \
> > +                           uint32_t oprsz, uint32_t maxsz)              \
> > +    {                                                                   \
> > +        static gen_helper_gvec_2_ptr * const fns[4] = {                 \
> > +            NULL, HFUNC, SFUNC, NULL,                                   \
> > +        };                                                              \
> > +        TCGv_ptr fpst;                                                  \
> > +        fpst = fpstatus_ptr(vece == 1 ? FPST_STD_F16 : FPST_STD);       \
>
> Perhaps clearer with MO_16 instead of 1.

OK (matches what we've mostly used elsewhere when selecting the
argument to fpstatus_ptr()).

> > +        tcg_gen_gvec_2_ptr(rd_ofs, rm_ofs, fpst, oprsz, maxsz, 0,       \
> > +                           fns[vece]);                                  \
> > +        tcg_temp_free_ptr(fpst);                                        \
> > +    }                                                                   \
> > +    static bool trans_##INSN(DisasContext *s, arg_2misc *a)             \
> > +    {                                                                   \
> > +        if (a->size == 0 ||                                             \
> > +            (a->size == 1 && !dc_isar_feature(aa32_fp16_arith, s)))     \
> > +        {                                                               \
>
> Likewise

Here I'm not so sure -- the thing you'd be cross-checking the size
against is the Arm ARM, which uses '01' and '10' (or '1' and '0', depending
on the insn), since it's the raw size field from the insn we're
looking at, not the data-type size. They happen to be the same values
for this insn, but aren't for all insns. (VADD (fp) and the other
@3same_fp patterns are examples of the other encoding.)

The other approach would be to standardize on "the decodetree pattern
always converts the size to the data-type size, regardless of how
it's encoded in the insn fields", and then you could check against
MO_16 here. Would that be better ?

> , and the { is on the wrong line.

Will fix.

thanks
-- PMM

