Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFB7C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 09:45:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFBBB20717
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 09:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PDXNOtl4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFBBB20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huw1l-0001Uq-77
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 05:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36158)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1huw1I-0000x6-6f
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 05:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1huw1G-0000ul-6E
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 05:44:40 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46494)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1huw18-0000rO-HR
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 05:44:32 -0400
Received: by mail-ot1-x343.google.com with SMTP id z23so62585807ote.13
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 02:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=midoLkk2oROs660CFtNkSmeuZgvHzcbI7Yf4h/5nf/4=;
 b=PDXNOtl40nrF18gOQXLL51CBSw2F4g+TaQhJ78B/HwWoir17gxEGA8zr21GyU7mgWV
 pd5rqX69Gx2SHudBbKOMnkZO8oVQjqkdORh1rQTRe4p0VAU0Qa/lyeYFzOzE0OnZ4+2G
 k+97PFY8Yz7GVJbrsXeL1hWVJ8bVVyleZXMajRZws2pm3KfC6e1XgQtU1qhQniz2yvTx
 u2dWQ3pX9j3qq9oXFqHnPQ4cETOwo4fKr2RsndOD/31Ec8nceNLDKEa1x4rBWwgjdyD3
 /hLYY/BU3yzN6u3Qcr3on3AkgYx2sHgMqIRmgrP9dWQLUYG+QRQSTIU5QvsFCcgiY2gf
 seNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=midoLkk2oROs660CFtNkSmeuZgvHzcbI7Yf4h/5nf/4=;
 b=hrgcKXOQNr2x24T4IzPAXgHMYz8FSL03qRPB7gyfFJvpnpeZzkpg6sa8jrGj0f+rvN
 NhcJU6y+2LmVq79ekymVMBVku9nWL2aQz+8M7j3mzfdwK67aJdYyqukPQFA47yl/fdgv
 OzOCNlBjwF0zeq3/B4UhbPxbref4MTunhee34mDx6M9VbDzCbVqc+5H/WDk5sGf6L6sm
 LoZk8hAnFBrL3gmrZcuRr+8iiApuMUSlEpUQ3J8mRAMldAlzhZ/n598wHneaE9NfhjAG
 udXfXSx+I+MMPB3VaovxMMNpwT4SinzGffQ5bTU0WzgGemOoq/N2EzxPWCA96wXhZ0D4
 sK2Q==
X-Gm-Message-State: APjAAAXvKWrEb5g1JM2omTy/KlTjChlsPU56TJ6irfu2M9UZ83P8IQSD
 bp37vJHwdRIa3yejERhei3Z2/u7jOdauco65xgSQFQ==
X-Google-Smtp-Source: APXvYqwZ+2O/NhfRLHtWqfelbIErtceLNVP16Ak1dS5XMiJkSTmB0KvSUZxMZJaMzCvErIN18OlB0ib6flLWUUz4IuY=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr2063944otj.97.1565084665664; 
 Tue, 06 Aug 2019 02:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-8-richard.henderson@linaro.org>
 <CAFEAcA_HY=WuGEPxTEm5g5tYuCDHXRDs=9EXQd6r+zvsL6_=Uw@mail.gmail.com>
 <af4f9f07-ac63-dfeb-9f2d-734ffff3fe7d@linaro.org>
In-Reply-To: <af4f9f07-ac63-dfeb-9f2d-734ffff3fe7d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Aug 2019 10:44:14 +0100
Message-ID: <CAFEAcA8Ju1C9x9uR1f0Pyzf1sGPnXdyNZmVSqos6BNrbidhMpw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 07/67] target/arm: Introduce add_reg_for_lit
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jul 2019 at 01:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/29/19 7:15 AM, Peter Maydell wrote:
> > On Fri, 26 Jul 2019 at 18:50, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> Used only on the thumb side so far, but will be more obvious
> >> once we start unifying the implementation of A32+T32.
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---

> > This is losing the information in the comments about the UNPREDICTABLE
> > cases. Are there callsites where the new function is called where
> > "thumb and reg == 15" is not UNPREDICTABLE, or are they all
> > that way?
>
> These call sites are that way, but this function will eventually be used for
> LDR (literal) and ADR, which obviously are not UNPREDICTABLE.
>
> I don't think this comment attached to this code is useful as-is.  Either we do
> the natural a32-ish behaviour and use ALIGN(PC,4), or we should
> gen_illegal_op() and be done with it.

I think it's usually worth noting when something's UNPREDICTABLE
and we're choosing to take the falls-out-of-the-code behaviour,
that's all.

> Would you prefer a function like
>
> /* Use of PC is UNPREDICTABLE in thumb mode, but allowed in arm mode. */
> static TCGv_i32 load_reg_nothumbpc(DisasContext *s, int reg)
> {
>     if (unlikely(reg == 15) && s->thumb) {
>         gen_illegal_op(s);
>         /* Unreachable tcg ops will be deleted but must still be legal. */
>         return tcg_const_i32(0);
>     }
>     return load_reg(s, reg);
> }
>
> for these specific usages?

I definitely don't favour this -- all our "is this going to UNDEF"
checks should go right at the start before we generate any
TCG code at all for the insn. One of the things I'm hoping this
series cleans up is that the current decoder is quite bad at
sometimes detecting UNDEF conditions late (which then results
in warnings about potential leaks of TCG variables).

thanks
-- PMM

