Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42D8C43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:29:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E2A2076B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w6b5Kk/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E2A2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQTAr-00077F-Jj
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 06:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQT9Q-0006FA-Jb
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:27:56 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:45350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQT9N-0004yB-Im
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:27:56 -0400
Received: by mail-ej1-x642.google.com with SMTP id dt13so7320576ejb.12
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 03:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kpFG6F80pPYCpWJ8Uu5Is5OLpc+9U57qrLDC/er5blQ=;
 b=w6b5Kk/51a6Z5Hrc1ljCFdIDvhTeU46I9kzDlxk859nNeCkyoHQ3pB3HD57kKabLPG
 AKZu7vkoR+q2XnrDbKUAV6YeU36IwxQQpw4OE2JGPZFmlUOWo4Aq6nie8BSfZBj94F4C
 B6KTR0emdIidJquQajWfKx8loGcmjSa9H07w1FM3YsjdaGaXPsEBS5HPQqAbFLfRSMsD
 kUE6nllCP2YO2cKtygbTJCXkuPF/McnrNBw+zWh/sQxNZf44+aIPjdym9B8AfmmY0k1x
 tH0eUdVz1DT4VDS3Jb7v2tz1cJVR4fFluhkFaOP0ugnRpChnEUWBJjtzBhvtxSYEOk0g
 Xndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kpFG6F80pPYCpWJ8Uu5Is5OLpc+9U57qrLDC/er5blQ=;
 b=GNbFHUCo62kJCR3kt3IkpEAzmb77CCHIFlisli0ENwCoV0gQ22H38f48dLQIt/ujqB
 43YSC/oAAJ6SFAM5I6DFazEwJzik1GrAq82afPSiST1q+SBF1ZYlm8Zr/cTViMRyavwW
 qNZQj6GY6NxaEk43ymLNPVog4uZws6G+vtYGCLlygluLoF4+I09r+wSdv4BjD8lCm9Xl
 ldmsqp0afCatSiKeMWONk+1cPyFIcMkgOchUqSk/5L/B1Tm1/somoi8AWi9mQU3kwAHd
 fVzGWR8m5qMI8PTgXUBjPH9qrPXENH5sjETdDAK96vcQVAYzcgWPRpxLPoYWLoA8QKCa
 lScQ==
X-Gm-Message-State: AOAM53372HMrgO0oLbvgSIpXuPOwUEgFvctd7T8nL7TwzD2n9txJDkBQ
 rkcItbK6YOItdZA5+onl+1XgwHzM7JQo2ZNtk1MuIg==
X-Google-Smtp-Source: ABdhPJyeObeZQj4pYprNl2yEBGwu+yYjPEdTAtU6hRV7U+pky71Hf6t/+6S9IP5a1fQEqPhJx2o0u8/a3zJpioVyCWw=
X-Received: by 2002:a17:907:4365:: with SMTP id
 nd5mr8241447ejb.56.1602152871883; 
 Thu, 08 Oct 2020 03:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201008024203.112303-1-shashi.mallela@linaro.org>
 <20201008024203.112303-2-shashi.mallela@linaro.org>
 <CAD8XO3ZRGqNbr1GM6jMAdhm=pPXXr6K7m_F0MKRDQMnrDw=yDA@mail.gmail.com>
In-Reply-To: <CAD8XO3ZRGqNbr1GM6jMAdhm=pPXXr6K7m_F0MKRDQMnrDw=yDA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Oct 2020 11:27:40 +0100
Message-ID: <CAFEAcA9QRJhorL1XtWBCQk9uo21OtMHUrH7ipG3tiFbOBGizPQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] hw/watchdog: Implement SBSA watchdog device
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Cc: Shashi Mallela <shashi.mallela@linaro.org>,
 Leif Lindholm <leif@nuviainc.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Rados=C5=82aw_Biernacki?= <rad@semihalf.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 8 Oct 2020 at 11:21, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> On Thu, 8 Oct 2020 at 05:43, Shashi Mallela <shashi.mallela@linaro.org> wrote:
> > +static void sbsa_gwdt_update_timer(SBSA_GWDTState *s)
> > +{
> > +    uint64_t timeout = 0;
> > +
> > +    if (s->enabled) {
> > +        /*
> > +         * Extract the upper 16 bits from woru & 32 bits from worl
> > +         * registers to construct the 48 bit offset value
> > +         */
> > +        timeout = s->woru & SBSA_GWDT_WOR_MASK;
> > +        timeout <<= 32;
> > +        timeout |= s->worl;
> > +        timeout = muldiv64(timeout, NANOSECONDS_PER_SECOND, SBSA_TIMER_FREQ);
>
> static inline uint64_t muldiv64(uint64_t a, uint32_t b, uint32_t c)
> {
>     return (__int128_t)a * b / c;
> }
>
> #define NANOSECONDS_PER_SECOND 1000000000LL
>
> Interesting why gcc does not warn on  64bit signed to 32bit unsigned
> truncation here. Looks like it's too smart to understand
> that value fits in 32 bits.

What truncation? 1000000000 in decimal is 0x3B9ACA00 in hex:
the number fits in an 32 bit integer without truncation.

(ns = muldiv64(ticks, NANOSECONDS_PER_SECOND, frequency) is a pretty
common pattern in our timer devices for converting a number of
ticks to a duration in nanoseconds, as is the reverse
conversion of ticks = muldiv64(ns, NANOSECONDS_PER_SECOND, frequency).)

thanks
-- PMM

