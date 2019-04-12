Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFDEC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 03:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81E742083E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 03:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="l7679q/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E742083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58136 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEmie-0000O8-N3
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 23:19:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hEmhS-0008J3-MI
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 23:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hEmhR-0000k4-Nz
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 23:17:58 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:41774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <joel.stan@gmail.com>)
	id 1hEmhN-0000hO-FW; Thu, 11 Apr 2019 23:17:55 -0400
Received: by mail-qk1-x742.google.com with SMTP id o129so4822703qke.8;
	Thu, 11 Apr 2019 20:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=FITGN5swjy/EtOZE38wbT6LXFNI+WfrZjFaG31fVn8o=;
	b=l7679q/qLMUsK7xqziDWk2TLx+lVzQjbTE9Shr5pyvIl8aqY/1gmj3H35EACvyArqh
	qCvGBCoCdUbDkqqjoONR3uG7Az9sR7cugSvbfnF1A6e0dpl/WOKVTVgPbdCz+1yl+kkj
	JJRWY3/QPfrI7RLXZgyPmWBHhqwC158MiQiMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=FITGN5swjy/EtOZE38wbT6LXFNI+WfrZjFaG31fVn8o=;
	b=sG63ybX8vFiyMztCkgjMy34N+OOVq35iB2LL5a6kIsYPWqMDQY/YujegCU0ugOFzud
	gJgqIgYMLBSi3gCf0CiqbmGnNrEhVBOtRUFfL7y9M8pKKwCEfYJXUkzU7+djuTtNJB4W
	KQlDpgpwxUzVHQdJT9S4P5g6N/SER6YhbWsxanefVAiWqEfzdmNoSO6G6kZDi5cjlDZs
	NcEGqK/3jPdlvtANH1DfEivJUCHjV00Dn4Reca3XESZ/DMj+RD3dB6gRfcOh43W2ZoWk
	FQzDDGUFT01ecFo7CuQde+7Kscu9qehE9X3VVvDJV45DqMfC+JAVrU+Sr4giHu9KZDuM
	VMpA==
X-Gm-Message-State: APjAAAVjuvAIVqr+53AzzD0zWmFwBkypdlKGNgiUQdYzkW9tU+wCiwJb
	fNBW5GLmtopNaCE68h9dGRO9r1EC75dGz/ifyrg=
X-Google-Smtp-Source: APXvYqwGYR09oRZ+qmeMJpSBhDfXgJj3Q/YP0sUX0AZC7seevw4cw3T9cuCKcco08q/uYIEX2q1LV1hn9I65BIZJQBE=
X-Received: by 2002:a05:620a:16aa:: with SMTP id
	s10mr40991424qkj.305.1555039072463; 
	Thu, 11 Apr 2019 20:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190328062222.8409-1-joel@jms.id.au>
	<20190328062222.8409-2-joel@jms.id.au>
	<CAFEAcA_K1Rv1G-s=ndVYX6i_BvWME6ToShL6ZBpB4gnE3zdZdA@mail.gmail.com>
	<89438392-9a54-7f43-5dff-6ceeffaf9f3e@kaod.org>
In-Reply-To: <89438392-9a54-7f43-5dff-6ceeffaf9f3e@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 12 Apr 2019 03:17:40 +0000
Message-ID:
 <CACPK8Xc_WeP3xuimjTBFRArteecikin9Qj8ZoCW-J2qBY4C=5g@mail.gmail.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::742
Subject: Re: [Qemu-devel] [PATCH 1/2] hw: timer: Add ASPEED RTC device
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412031740.xe2OKsLQ6HAT_5iXc6uiF3bKVh7nQKW4l7OUH9i0ugk@z>

Thanks for the review Peter and Cedric.

On Thu, 11 Apr 2019 at 15:30, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 4/11/19 5:25 PM, Peter Maydell wrote:
> >> +
> >> +#define COUNTER1        (0x00 / 4)
> >> +#define COUNTER2        (0x04 / 4)
> >> +#define ALARM           (0x08 / 4)
> >> +#define CONTROL         (0x10 / 4)
> >> +#define ALARM_STATUS    (0x14 / 4)
> >
> > Not mandatory, but you might like the REG32() macro in
> > hw/registerfields.h which defines A_FOO and R_FOO
> > constants for you for the addresses and the indexes.
>
> Yes. May be we should start using these macros in all our models.

I don't like them as you can no longer jump between the definition and
the use of the defines.

>
> >
> >> +
> >> +#define RTC_UNLOCKED    BIT(1)
> >> +#define RTC_ENABLED     BIT(0)
> >> +
> >> +static void aspeed_rtc_calc_offset(AspeedRtcState *rtc)
> >> +{
> >> +    struct tm tm;
> >> +    uint32_t year, cent;
> >> +    uint32_t reg1 =3D rtc->reg[COUNTER1];
> >> +    uint32_t reg2 =3D rtc->reg[COUNTER2];
> >> +
> >> +    tm.tm_mday =3D (reg1 >> 24) & 0x1f;
> >> +    tm.tm_hour =3D (reg1 >> 16) & 0x1f;
> >> +    tm.tm_min =3D (reg1 >> 8) & 0x3f;
> >> +    tm.tm_sec =3D (reg1 >> 0) & 0x3f;
> >
> > Shift by zero ?
> >
> > Consider using extract32() rather than by-hand shift and mask.

I looked at these and found them more confusing than writing what was
actually happening.

This code came from the Linux kernel driver, which I wrote, so I know
it's correct. The shift by zero is there to follow the pattern of the
code proceeding it, again to stop mistakes.

If we require using these helper macros then I can make the change. If
it's optional then I would prefer to leave it as is.

>
> What about the FIELD*() macros in hw/registerfields.h ?
>

> >> +static void aspeed_rtc_class_init(ObjectClass *klass, void *data)
> >> +{
> >> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> >> +
> >> +    dc->realize =3D aspeed_rtc_realize;
> >
> > This is missing a reset function and vmstate.

Ok, I can add those.

vmstate and migration is a foreign concept for the small ARM machines.
As well as being a developer, I am an end user of Qemu for them (the
aspeeds, microbit), and the use case is to boot up a firmware and
check that it does correct thing. I've never considered saving the
state and resming it, and can't think of a situation where that would
be done.

If we're adding it for consistency then I understand. I don't think it
sees any testing though.

Cheers,

Joel

