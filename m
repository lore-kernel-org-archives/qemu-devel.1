Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A289C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 13:10:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3653C21852
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 13:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gNzF7Uce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3653C21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj1VJ-0004Qk-Dq
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 09:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45827)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hj1TZ-0003PX-Kn
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 09:08:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hj1TX-0007dD-Pm
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 09:08:37 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43392)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hj1TW-0007bt-DD
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 09:08:34 -0400
Received: by mail-ot1-x341.google.com with SMTP id q10so5893678otk.10
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 06:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Rs6zRJeUQE19QRdvqv0nWAusH67o0A4RvKI6AFFZ8No=;
 b=gNzF7Uceon3eGq9lxRj8H2MXTUSXqKUOjQKsPu0rOn2FEzwVsKYVgLb7y9Vbtq+Ft6
 zMyiHc2R7etcKgyDlf7eB9u1TcZhtnIk2MNIIzQq3nswlSf36gteUG7lJSuyIK1wFL+b
 uixJ1JuuMbEf/lLHhqwPL/DqRSkR3jYH202D4hXsQxC79bCRp7Mf5JALSml1D67wAibK
 q31gA51gktJVzr26t5FSuXHOGeIeCKWNZQdbth32GMnNHAJCWO3UgYIYMf/KIGZ+hp4j
 mHyDXj7QB5alq3EsxcyZBULtbB0qS6w9rtjqdr8DAFoWuMGct9MBNprTZaVVHL2dHiXP
 09cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Rs6zRJeUQE19QRdvqv0nWAusH67o0A4RvKI6AFFZ8No=;
 b=gQraB/bYa/1/zA/LEIHqh9SJY+kbnydVVx4M1q8u7rL7QsA35E/xcbgCYEMWRDixMp
 f2NHtnlOZ5GRKbXlyZYhbEKcdx569sD2B7C5xIzQylWMCkjnfqjRk6NqAvS+r4tI9+WR
 HosIWMeMS35rYRvAxe62Kr/Gv19lghqhSkNhjMXoqPPLHe18MRKIqiWXowhaE8ZNxyiB
 kz6yBIuFrI82Wpu+bElt7N3oOsl/TqffacBDEt7hjbmtRYV9U/4QQ956ZFD4SwBC9Aar
 35HlZiMB3m+Rfenl9TI53GvO/yHhz1xJUKJ//Dh8FCLLS/E3/QFfufCVmnqC7mDH6eCz
 /4sA==
X-Gm-Message-State: APjAAAVzGOb4DjkRSiWIRQIW8PaRVIM4c6l4emnuuyJoVYskz9qFvtPr
 60MJ1yTOP/nJOiN44G7UJl3LCUA2SW70N3EJkabp5w==
X-Google-Smtp-Source: APXvYqxt5ehwmDG+OqBfrQBYVyByBKasmI0zbbMOgu64NIOIvqGSiyRN8RNp+y/r2bt4OoanE/hlrTrCXIgA0uhmxGU=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr11409364otk.221.1562245712526; 
 Thu, 04 Jul 2019 06:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190618165311.27066-1-clg@kaod.org>
 <20190618165311.27066-4-clg@kaod.org>
 <CAFEAcA_wCFE0BL_LjF+04MBPa2XnVgCKk4SP4nPrBjrcjmNVVQ@mail.gmail.com>
 <CACPK8XfdqDARHV4TupC+c-qsgscOn4kWjtYdpdR+GxOZQzNNMA@mail.gmail.com>
In-Reply-To: <CACPK8XfdqDARHV4TupC+c-qsgscOn4kWjtYdpdR+GxOZQzNNMA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jul 2019 14:08:21 +0100
Message-ID: <CAFEAcA8W6moG+dPOpPazEKFXYg3Gp0COrks1uYz94hn9HHeV5A@mail.gmail.com>
To: Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v2 03/21] hw: timer: Add ASPEED RTC device
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 4 Jul 2019 at 08:49, Joel Stanley <joel@jms.id.au> wrote:
>
> On Tue, 2 Jul 2019 at 19:19, Peter Maydell <peter.maydell@linaro.org> wro=
te:
> >
> > On Tue, 18 Jun 2019 at 17:53, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
> > >
> > > From: Joel Stanley <joel@jms.id.au>
> > >
> > > The RTC is modeled to provide time and date functionality. It is
> > > initialised at zero to match the hardware.
> > >
> > > There is no modelling of the alarm functionality, which includes the =
IRQ
> > > line. As there is no guest code to exercise this function that is
> > > acceptable for now.
> > >
> > > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> >
> > Hi; Coverity complains about this function (CID 1402782):
> >
> > > +static void aspeed_rtc_calc_offset(AspeedRtcState *rtc)
> > > +{
> > > +    struct tm tm;
> > > +    uint32_t year, cent;
> > > +    uint32_t reg1 =3D rtc->reg[COUNTER1];
> > > +    uint32_t reg2 =3D rtc->reg[COUNTER2];
> > > +
> > > +    tm.tm_mday =3D (reg1 >> 24) & 0x1f;
> > > +    tm.tm_hour =3D (reg1 >> 16) & 0x1f;
> > > +    tm.tm_min =3D (reg1 >> 8) & 0x3f;
> > > +    tm.tm_sec =3D (reg1 >> 0) & 0x3f;
> > > +
> > > +    cent =3D (reg2 >> 16) & 0x1f;
> > > +    year =3D (reg2 >> 8) & 0x7f;
> > > +    tm.tm_mon =3D ((reg2 >>  0) & 0x0f) - 1;
> > > +    tm.tm_year =3D year + (cent * 100) - 1900;
> > > +
> > > +    rtc->offset =3D qemu_timedate_diff(&tm);
> > > +}
> >
> > because the tm_wday field of 'struct tm tm' is not initialized
> > before we call qemu_timedate_diff(). This is a false
> > positive because the "read" of this field is just the place
> > in qemu_timedate_diff() that does "struct tm tmp =3D *tm;"
> > before calling mktime(), and mktime() ignores tm_wday.
> > We could make Coverity happy by using a struct initializer
> > on 'tm' here; on the other hand we don't do that anywhere else
> > which calls qemu_timedate_diff(), so maybe I should just mark
> > this a false positive?
>
> I don't have an opinion on which option to take. Perhaps mark it as a
> false positive?

Yeah, seems reasonable.

-- PMM

