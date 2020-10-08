Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2C5C43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 561BB21734
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UBDbBTRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561BB21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQTPs-0002D1-Qn
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 06:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxim.uvarov@linaro.org>)
 id 1kQTOr-0001RT-MA
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:43:53 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxim.uvarov@linaro.org>)
 id 1kQTOm-0007Bx-Er
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:43:53 -0400
Received: by mail-pf1-x442.google.com with SMTP id f19so3635884pfj.11
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 03:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BhZ4/xt8LdCx2EzL+SVc4Ir7nM51yRazFbJfXLcOY2Y=;
 b=UBDbBTRXPqdYRVLFt4Z5Fxml/KdvQCKHFKuz2YY8pSQtNUeHKHT2NAu8rmEwGvG4xZ
 uAW0r5+dDIW+9VgKrnLZ2EzeTsEyRJtVOr+Jqu6RhNFDVwQtJTufamEqVkaE9zmW4UmK
 1A/FcFNY1JctZ8uOhDGv8tO/WIs1uIcj1jHAlWJfnI+P/r+Lf6xNnbJw5Z+uZkxpVs0d
 xNcnLW3hAsby8ooVFIDemLeMbkoRDXu2OuDYBp7lbANhF1XE+hY3h620BNSgol8ACZ1q
 2gzqpJ1s2jMPEyX+1Qy33u+ZrtFBs/Z5SZzw59VLvC1Q3C9umTALi2pp0qHTeTmulmBC
 Qzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BhZ4/xt8LdCx2EzL+SVc4Ir7nM51yRazFbJfXLcOY2Y=;
 b=OBrE0IlGbwoAEMCL0Z691SGrm2wrGnjN66PKhCvD5kiP3GnwZiHVL3OEjkwgE8J1nV
 QEyWrbZ1EjKhfc31767bAaxppxH7lUBAQVihTg9HGGW4raJtmIl2fIJOHFbzprBRv6FQ
 Wy0HfAlGuWdDA1tZEa1dr03fNQddoJTbezSqdaYJtZXE92efBjcrbLjQpHDijz/yDOzC
 C4IgQ5WKjLwyySJeJb+ka4/5JWkyM171dD8AyxpPQRrh97Es3QaPcxp8Xj2NexiN7WjP
 pvP8E6Quy8R1afKxsqz23UKgko2Lp0WRZLmr5D7xrqD/Df3VC5xAnx2VpRcws+Os+Rb4
 WaaQ==
X-Gm-Message-State: AOAM532aKDSKCrqNE+RJ0ifpjTWdCXyw7ySGdyQjMZmdI3fGP4xxrELj
 coiDGm3luwiBZ1hMls5jKDWVgeP28E6ekbXn5MvrYw==
X-Google-Smtp-Source: ABdhPJyflsmoB/ORnp2FAVhR2VvSEv5cwTvJs6jzVHp+iD/NErVc2OxgdcqXTQwb3chnH7O6aQBP3zRmROHz81tA8ak=
X-Received: by 2002:a17:90a:4b42:: with SMTP id
 o2mr7002123pjl.205.1602153826657; 
 Thu, 08 Oct 2020 03:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201008024203.112303-1-shashi.mallela@linaro.org>
 <20201008024203.112303-2-shashi.mallela@linaro.org>
 <CAD8XO3ZRGqNbr1GM6jMAdhm=pPXXr6K7m_F0MKRDQMnrDw=yDA@mail.gmail.com>
 <CAFEAcA9QRJhorL1XtWBCQk9uo21OtMHUrH7ipG3tiFbOBGizPQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9QRJhorL1XtWBCQk9uo21OtMHUrH7ipG3tiFbOBGizPQ@mail.gmail.com>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Thu, 8 Oct 2020 13:43:35 +0300
Message-ID: <CAD8XO3YaavVfz6yaAx2N95B8a87tkp=-GKt814Zou4e7B+cVvg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] hw/watchdog: Implement SBSA watchdog device
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=maxim.uvarov@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: Shashi Mallela <shashi.mallela@linaro.org>,
 Leif Lindholm <leif@nuviainc.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Rados=C5=82aw_Biernacki?= <rad@semihalf.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 8 Oct 2020 at 13:27, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 8 Oct 2020 at 11:21, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
> >
> > On Thu, 8 Oct 2020 at 05:43, Shashi Mallela <shashi.mallela@linaro.org> wrote:
> > > +static void sbsa_gwdt_update_timer(SBSA_GWDTState *s)
> > > +{
> > > +    uint64_t timeout = 0;
> > > +
> > > +    if (s->enabled) {
> > > +        /*
> > > +         * Extract the upper 16 bits from woru & 32 bits from worl
> > > +         * registers to construct the 48 bit offset value
> > > +         */
> > > +        timeout = s->woru & SBSA_GWDT_WOR_MASK;
> > > +        timeout <<= 32;
> > > +        timeout |= s->worl;
> > > +        timeout = muldiv64(timeout, NANOSECONDS_PER_SECOND, SBSA_TIMER_FREQ);
> >
> > static inline uint64_t muldiv64(uint64_t a, uint32_t b, uint32_t c)
> > {
> >     return (__int128_t)a * b / c;
> > }
> >
> > #define NANOSECONDS_PER_SECOND 1000000000LL
> >
> > Interesting why gcc does not warn on  64bit signed to 32bit unsigned
> > truncation here. Looks like it's too smart to understand
> > that value fits in 32 bits.
>
> What truncation? 1000000000 in decimal is 0x3B9ACA00 in hex:
> the number fits in an 32 bit integer without truncation.
>
> (ns = muldiv64(ticks, NANOSECONDS_PER_SECOND, frequency) is a pretty
> common pattern in our timer devices for converting a number of
> ticks to a duration in nanoseconds, as is the reverse
> conversion of ticks = muldiv64(ns, NANOSECONDS_PER_SECOND, frequency).)
>
> thanks
> -- PMM

I meant that LL is an long long int which is 64 bit size type. And
then you pass it to uint32_t.

