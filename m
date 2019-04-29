Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1197C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 12:08:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6745E2075E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 12:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZbsYgRI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6745E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56759 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL54r-0002c6-JE
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 08:08:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL540-0002ES-VA
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL540-0008Av-5T
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:07:16 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL540-0008AN-1F
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:07:16 -0400
Received: by mail-oi1-x241.google.com with SMTP id l1so6204016oib.0
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 05:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=ECDxqSbFCFY9J+bizJ75Z9ywtSsPY7m+UprrYkgIs0w=;
	b=ZbsYgRI7AIOKhScMBMnK0jP8sDlyfZDtRmlyRb45xRJ4WDJpZn8qH5eR0/wJkZmLQi
	y6b6ZxsptfzychtP1ySp9S9IhKO5G4FcpTyrFl4l5lwQIxk4YKk+izYbtx7XwjTd7VHZ
	aohg3NDBN43HuDhjMrn97gY8D/G8AXpkskFqlVGIXuDhA+YfU3VRSDY5DVOsSuKxoBxf
	cHU6xDLlDEYtS4jWicv0XB5d3osCBDd+wYq8Nyvz97yEkCAcpkaPhsFVA2Mc4AJ6BnxD
	Wawdz/bAZV/5aT7ZRNhH4W1WdPDiEcROfxSgVQEwDpp21rGhSJ9wgZJJviSl8z0BXwcv
	gGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=ECDxqSbFCFY9J+bizJ75Z9ywtSsPY7m+UprrYkgIs0w=;
	b=VWx0wW5SrFFzrPYyA2oQy2Nb56zjNu1hcuDcehQYb7GMCVXLUKmVaZMuvjPV/dxLOO
	c4k7odVNaP1pxNTRoMf4nfa+ZknOzOZmBaU7l4FrkWPMsH5fq8ioW6iVXwAqtJvkrbR8
	cUZ9mik+jI3/rfCPuT3is1jvCMU68tdhPnpXdkYgazjggly6zwS16om+B06ZtyQeXbJS
	Jne6mr6+RHyd/kMNe1Wo13Y31U8y8iJyILGz3NhKGpZb9qT8dlxVIeamPxG+TXA3VqhY
	pisLbDqU9+rdPYAAYLGKuB1f8NVHv5CxyZ4iRxZOib4ojBSVf2JjHb8fYKYPxDug3HyJ
	Mwrw==
X-Gm-Message-State: APjAAAUci3najS9tI/huqjm2/ReKhK+xWBCUcUCWfwn/1u/drtFRHEdW
	15It6hXfQEPwFlQzV6vFmEtCsXdryKpKhvLx5xiSBA==
X-Google-Smtp-Source: APXvYqzNm146BeMqBivxxcI1lvPcxS06XJiAN11YLtpJXIImZ+VjAJSGROFrbP4R6uicFTVscKqeOEK0G9dzql24+A4=
X-Received: by 2002:aca:b3c2:: with SMTP id c185mr16485722oif.98.1556539634668;
	Mon, 29 Apr 2019 05:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190411161013.4514-1-clg@kaod.org>
In-Reply-To: <20190411161013.4514-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 13:07:03 +0100
Message-ID:
 <CAFEAcA-WeTRp0zs5Zu_g3uCjzXaqSf5-G3nyrxMn_n+fQAN08A@mail.gmail.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH 0/3] aspeed: cleanups and extenstions
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429120703.uYmYWbGxgWDn4F8D89IFsTEUXsHBtt2VtTu09f1eb2M@z>

On Thu, 11 Apr 2019 at 17:10, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Hello,
>
> Here is a series adding a couple of cleanups to the Aspeed SoCs to
> prepare ground for extensions and new SoCs.
>
> Thanks,
>
> C.
>
> C=C3=A9dric Le Goater (3):
>   aspeed: add a per SoC mapping for the interrupt space
>   aspeed: add a per SoC mapping for the memory space
>   aspeed: use sysbus_init_child_obj() to initialize children
>



Applied to target-arm.next, thanks.

-- PMM

