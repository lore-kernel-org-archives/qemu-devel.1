Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F74AC0650E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 07:50:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C6B22133F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 07:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="XOs/Xq6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6B22133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiwVc-0007VM-IO
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 03:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49569)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <joel.stan@gmail.com>) id 1hiwV0-0006wh-Ja
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 03:49:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1hiwUw-0006Sx-Rf
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 03:49:45 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:41933)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1hiwUe-0006Ia-CJ; Thu, 04 Jul 2019 03:49:26 -0400
Received: by mail-qt1-x843.google.com with SMTP id d17so5729365qtj.8;
 Thu, 04 Jul 2019 00:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=c2arl7QFyQiG434wqZ8b5wc77IqMT54t33qFFEulGPk=;
 b=XOs/Xq6GiSKSWJxHLpMT8Tx6OcMJRgUznAjM0WuDVDNj9/z1MQ6WGSJ+SweAAKcjrS
 iyeen7PZw1k3awhEsHzvILOdWlxktd4BxMQLEsXwPz33gf1QOT7SGrtJIXGwvJ2FVm9b
 fBmNAIyV6tr/lTVwyHHxLnPNGBU5ORRZiaYmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=c2arl7QFyQiG434wqZ8b5wc77IqMT54t33qFFEulGPk=;
 b=sHlFmXBuZDo/6A4qGwqzhfb7PWaZ0OKFZmZgYU41iPysHpNp8L3XcVjWqjsb6Ai3v0
 NJsrC95LfX751IhdcO5zarBdJZvUBv7UvkxYGQv8t+UWOsXtFuK5SHSa0ZUdcnW1x0eG
 HYbx/OLaWrWqCjAsOO1l1nfOJR4/v/4MtzY45aO6GMgdWE//MHehjucc1gc4v1CQAZXR
 OjFoPI4ZKgUDR7fHBrJrjTiYUVbvry4ZocaAwzpRcYrjxAwZCBKXFvNBUf3YiAVJX00g
 E4vL6HhGjZvOOJsO9ulEMazLrJUfzr6S/z10vPtj3/IW2B+IWgH2LZ/Du7Dao8uKJU1w
 eBAg==
X-Gm-Message-State: APjAAAV1/6mhoT/t/54GkljFdEGCZaykc5l1LilokjV/2dYt/w3fEoy6
 el8Tq9X2ry5UNQlzcblvKfWfBgA8heXn/XPPKuAtCBTW
X-Google-Smtp-Source: APXvYqw5mSPWexB4mk5Y1EVQ+0zGm8xVybfaN1fltapvooa8jRWH89GlZJKGLN1zdMChvu2JBAiHIGRBhPAHbpxJeas=
X-Received: by 2002:a0c:ae31:: with SMTP id y46mr35975520qvc.172.1562226561081; 
 Thu, 04 Jul 2019 00:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190618165311.27066-1-clg@kaod.org>
 <20190618165311.27066-4-clg@kaod.org>
 <CAFEAcA_wCFE0BL_LjF+04MBPa2XnVgCKk4SP4nPrBjrcjmNVVQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_wCFE0BL_LjF+04MBPa2XnVgCKk4SP4nPrBjrcjmNVVQ@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 4 Jul 2019 07:49:09 +0000
Message-ID: <CACPK8XfdqDARHV4TupC+c-qsgscOn4kWjtYdpdR+GxOZQzNNMA@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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

On Tue, 2 Jul 2019 at 19:19, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>
> On Tue, 18 Jun 2019 at 17:53, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >
> > From: Joel Stanley <joel@jms.id.au>
> >
> > The RTC is modeled to provide time and date functionality. It is
> > initialised at zero to match the hardware.
> >
> > There is no modelling of the alarm functionality, which includes the IR=
Q
> > line. As there is no guest code to exercise this function that is
> > acceptable for now.
> >
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> Hi; Coverity complains about this function (CID 1402782):
>
> > +static void aspeed_rtc_calc_offset(AspeedRtcState *rtc)
> > +{
> > +    struct tm tm;
> > +    uint32_t year, cent;
> > +    uint32_t reg1 =3D rtc->reg[COUNTER1];
> > +    uint32_t reg2 =3D rtc->reg[COUNTER2];
> > +
> > +    tm.tm_mday =3D (reg1 >> 24) & 0x1f;
> > +    tm.tm_hour =3D (reg1 >> 16) & 0x1f;
> > +    tm.tm_min =3D (reg1 >> 8) & 0x3f;
> > +    tm.tm_sec =3D (reg1 >> 0) & 0x3f;
> > +
> > +    cent =3D (reg2 >> 16) & 0x1f;
> > +    year =3D (reg2 >> 8) & 0x7f;
> > +    tm.tm_mon =3D ((reg2 >>  0) & 0x0f) - 1;
> > +    tm.tm_year =3D year + (cent * 100) - 1900;
> > +
> > +    rtc->offset =3D qemu_timedate_diff(&tm);
> > +}
>
> because the tm_wday field of 'struct tm tm' is not initialized
> before we call qemu_timedate_diff(). This is a false
> positive because the "read" of this field is just the place
> in qemu_timedate_diff() that does "struct tm tmp =3D *tm;"
> before calling mktime(), and mktime() ignores tm_wday.
> We could make Coverity happy by using a struct initializer
> on 'tm' here; on the other hand we don't do that anywhere else
> which calls qemu_timedate_diff(), so maybe I should just mark
> this a false positive?

I don't have an opinion on which option to take. Perhaps mark it as a
false positive?

Cheers,

Joel

