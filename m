Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C465AC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:12:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C62A20835
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zNgexLOq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C62A20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49266 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLVND-0007NU-Pp
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 12:12:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLV2T-0006WW-Se
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLV2T-0007fU-2Z
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:51:25 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLV2R-0007do-Tm
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:51:24 -0400
Received: by mail-ot1-x343.google.com with SMTP id g8so11355975otl.8
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 08:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=H92g6IK0gE47e1yuPe+y1KlYH7xjzRkY2VktOjLQKhw=;
	b=zNgexLOqtG5zDsnpTM1o0tUIy9NVG5+lKrLKsDBlDcVykth9f1xAstXlNf73kO+jpL
	im+AMNN+OtGSS+WijPwTsmQxcW7aDOWwr4gFHaKI3HG4RIMbhHwPV2ThIl6y7Aauf0lL
	2dO+CA8BffAfpyjuQl/TcWSWhOipn0IpwF77/MtrUxNcNKtyKSChvWlCJKoZqgCvMf0W
	AeUy2X31JtE9At4SpijTETF8PXEVHMlAdyXbVp3fOY+MqTKSUL9zhyvJ5IXcB1nz/F/h
	EZM8YMAq4EcuXFLjt69DYAN9kHSpp5oEoR3J3czKLzDdyGy7hZRmjV4atglyYJWnbnMA
	R+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=H92g6IK0gE47e1yuPe+y1KlYH7xjzRkY2VktOjLQKhw=;
	b=N69RUuVWLqPHTxfxS2md3+QPkuIwdER+cly/BJtqL6LU0beSLSE7UXb+eNMQxlc4Sf
	ompjCqHWYAAaV2wEDAxM/0uCwR/UHPrlvvJTbi7eMBfWmegq7NYCUa+SiCkd48fqT8ce
	YfiiprT/zW0ykGob6Pk9rN78mgTAAa1P9uBsxQN124lAen6bGxF4zSwwcLx0Pee7dOrr
	hLs7n9CuY3UK9HLbYK+H+almkP9XVRH7l7w7IluvI47pFLrnAJo04pxppjt0Sv19nBNI
	QWa9pZs3kH4q7ArNreaqJoE5e930YQN6BwQusa5UvgU+/CvTK7PUycEWS07thNXUnoe5
	/aMg==
X-Gm-Message-State: APjAAAXGS41OVZnf+/juB0uVWVXyn8snDProKusDJTGsGgEJGRcpbv1T
	jTptdzw2uB0c8iuc2sOsdZ9wdbmFkX2Upuv7yoiqNQ==
X-Google-Smtp-Source: APXvYqxJYDmcaMBtMVk7g2SLVRmdEwuVx2bKSJlTcdzPBejYIYOrTll4s/QBMfWjiIEU9F7oPXwKxRxIAKpGIeZPjH0=
X-Received: by 2002:a9d:404:: with SMTP id 4mr40749901otc.352.1556639481238;
	Tue, 30 Apr 2019 08:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556515687.git.alistair@alistair23.me>
	<PSXP216MB027793B449E7DAAB995E0F33DD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
	<1c2303a0-62bf-53ce-e91c-b45a95a91376@redhat.com>
	<CAKmqyKMWHot3UaRkN4gnwtcj7kje-Yx3ZJa7-9NGbgfg6vMJdQ@mail.gmail.com>
In-Reply-To: <CAKmqyKMWHot3UaRkN4gnwtcj7kje-Yx3ZJa7-9NGbgfg6vMJdQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 16:51:09 +0100
Message-ID:
 <CAFEAcA-UaW=0QpCcLo4_HkKHskhvAJhnCBm949Dbr8qBNM8aJw@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v1 4/5] hw/arm: Add the STM32F4xx SoC
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
Cc: Alistair Francis <alistair@alistair23.me>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430155109.oQgRea4qs8n1LyiQ_PXZGArOlRGMypIYCTY0VjgHv94@z>

On Mon, 29 Apr 2019 at 18:30, Alistair Francis <alistair23@gmail.com> wrote=
:
>
> On Mon, Apr 29, 2019 at 5:43 AM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
> >
> > On 4/29/19 7:33 AM, Alistair Francis wrote:
> > > --- /dev/null
> > > +++ b/hw/arm/stm32f405_soc.c
> > > @@ -0,0 +1,292 @@
> > > +/*
> > > + * STM32F405 SoC
> > > + *
> > > + * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
> >
> > 2019?
>
> I never know how this works. It was originally written in 2014, do I
> update the year based on the upstream submission?

You could say "2014, 2019" if you like; or just use the date of
original authorship.

thanks
-- PMM

