Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AF2C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 10:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F9482075E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 10:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="efiaXMGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F9482075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48634 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM8bo-0004up-Ft
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 06:06:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hM8b3-0004bW-4F
	for qemu-devel@nongnu.org; Thu, 02 May 2019 06:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hM8b2-0000Q4-7T
	for qemu-devel@nongnu.org; Thu, 02 May 2019 06:05:45 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hM8b2-0000OU-23
	for qemu-devel@nongnu.org; Thu, 02 May 2019 06:05:44 -0400
Received: by mail-oi1-x242.google.com with SMTP id j9so469605oie.10
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 03:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=pNk0Q3QckoxPkrut+nhTjV/QVf8jMvXhiGFwpItB8T0=;
	b=efiaXMGO2BCARn/ChTMCqaVezSHUfCiOy6B+nzt+J2vBBOZdsYoz9ghs1yixpzk6AF
	kistrNi2Q8jsJH7JehunCBlPnacyB3xweW09XTQRatzR9wP2Qc7jndBIjt8B4oRyojcI
	R6qcpJ7BrTG8ysDwFHez/te8VsfJU1Hc30VWIoT6xVHBYQzgDVHE2GsruxZm7Vty/EmL
	ebHhU6dUMWz3/CAa1fnbufO690YMWZJlAASH/LlT+Q+8UTUUXljtPIcjaadaUceoZORJ
	mxRAT5q3h1tFbCpp9PH7w9im9u4OTyNcYTqzH8zMOlO4J0IQGBmra6qRLNr8VZQz+TPA
	u6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=pNk0Q3QckoxPkrut+nhTjV/QVf8jMvXhiGFwpItB8T0=;
	b=a+rynXvh7YtBRlSNvOqsd8gS0ts8pU14J6wyw4CwOGEcchMCw0hKDf2Gu9r7Hz9r/J
	f9n+vL7mtkvDz6OE1Wp0/txePveL567SuA3J9eAqOsiosc8jsbFYiXRFanxv9b+KuwZ0
	td9/wFwNEqGHLOJzWQYgP4WFtNvLMMpsLcpItG+GSR4imAAYkIMOu8EAG7A/S2j9/8oV
	zuCWpPcXiFeqADNOK1km7GzC28evjNXqOMuZGr2L3Annn0Af7EahqInfJOb7K1OHnf3o
	ikI9MosXIZwGJG6XLzlua2xwKOoDdWs9jxULYpZd2XU291uO8rkM3BRDWBTcROHpweUa
	/zIg==
X-Gm-Message-State: APjAAAVd89augj/bnohvcCLE/Rkx2XZDzv9dOCBaYIHECnEGbc+luEBf
	uVS0bKrzL8Av+GVHgBJ0gq4QpWs6xO5xpQhwsFbcXg==
X-Google-Smtp-Source: APXvYqz0OD7Lz/EdbW1SVvU82D0JJYwvx4oLqfnFX+YeNCfoIkopkIy3P6kqYusIZ5xBnF/UajCEJ7VOeua220mAkZQ=
X-Received: by 2002:aca:ab12:: with SMTP id u18mr1708710oie.48.1556791541964; 
	Thu, 02 May 2019 03:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556515687.git.alistair@alistair23.me>
	<PSXP216MB02771957D4B9C5A15914D05FDD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
	<CAFEAcA86i3aZx-h2ys5kmc35AMqzd6k=JrfVXObdbcppnn-J8w@mail.gmail.com>
	<CAKmqyKMM0QHgdS3Z9Fd13XjeFsiG1UnZYz5brdjJgnbHXmxBrQ@mail.gmail.com>
In-Reply-To: <CAKmqyKMM0QHgdS3Z9Fd13XjeFsiG1UnZYz5brdjJgnbHXmxBrQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 May 2019 11:05:31 +0100
Message-ID:
 <CAFEAcA-dZ5qdh58QCmX+t2RpJim8Fu9FY0UBY1tMpQOHkG06mA@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v1 5/5] hw/arm: Add the Netduino Plus 2
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
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502100531.RSyKo-Ehj8cbH6MVcKU929TrdQoS87k-jURy_dJMVRQ@z>

On Tue, 30 Apr 2019 at 21:29, Alistair Francis <alistair23@gmail.com> wrote:
>
> On Tue, Apr 30, 2019 at 9:02 AM Peter Maydell <peter.maydell@linaro.org> wrote:
> > Can you explain the purpose of the reset code? None of the other
> > v7m boards seem to need to do a manual qemu_register_reset().
>
> The reset code allows the machine to work with the -kernel option.
> Without the reset override using -kernel results in the guest starting
> at the wrong address. We can use the -device loader option without the
> reset code though.

That sounds in line with how -kernel works on the other armv7m
boards -- the expectation is that your image file includes a
full vector table and the CPU will read the PC and SP from it
when it resets. If you want "honour the entry point" you can
use -device loader, as you say.

Ignoring the entry point for -kernel ELF files is certainly
a bit confusing, but I think if we want to change this we should
do it globally, rather than having one board which behaves
differently to the rest. Changing it does have some awkwardness:
 * possibility of breaking previously working images
 * we can get the initial PC from the ELF entrypoint, but if
   we do this what do we do about the initial SP value ?

thanks
-- PMM

