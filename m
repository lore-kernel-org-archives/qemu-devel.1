Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414FBC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 13:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B43B2075E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 13:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XnqNLL7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B43B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40869 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMYNA-00043r-7U
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 09:37:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYLL-0002YD-Au
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYLK-0003ez-7T
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:35:15 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMYLK-0003e1-26
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:35:14 -0400
Received: by mail-oi1-x242.google.com with SMTP id l203so4430735oia.3
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 06:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=mY5efbqDzo/n4wJM/Lt0T5LWk5kSu8VSWtK1bUhM3xY=;
	b=XnqNLL7AycVu5qukZW08bPeAlse+7XDSf8V1Bs2grziJ3bnwWQnOYc7BSspYHnN0WN
	KNy7hXjpjz1ti/Kt01WV/8BUuzqkKG6W6ZX+Oxxfo4A5eSqzXg6y/U3e5XYf5rCug+xu
	aQgIaWC6VmqjoDy6ZphkFnLHtT9qifhvjoovjW0rg4nIGhfYUjDAiYyT+Mk5KWMlc21T
	Y5vqSb6HC3ot5hrzPn4sxi/As/G83Tjf3+4KYheGknrFWKgt24UC5Au6D2MMcennNfcC
	omjtFJUA+/ZqoRgwSUj6+/VXciZ4+MJaUSc+/uLlvJtTG9acW50kIYWRT/oiZT7Bsh2X
	V6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=mY5efbqDzo/n4wJM/Lt0T5LWk5kSu8VSWtK1bUhM3xY=;
	b=oeHAXaA7LsxN0zgkPYt6L2OcYNDHqdXtP9zNt9BA5lIRiK4B7/K3KhoTO6jJE8JdoJ
	0/xTLkOg2aRIZgas+RI6kRaTlLb3bSwmC8MAcSnlZBCPM4fdhNgGWMNpKl+sC99wKRVD
	AwJTPw3XrO0sVOyT8do24lMjQLmFODQrOPdnP1II4opVmoro0MqW3GksjGBQ3gD8iiOV
	1TD4kzKympY8ofG6clpJ5PfrQaHLZ8hbGKF90TvEnuRagpOGdyoCxkEdZO/ISoTc/nAf
	chsN2FMj3FUs3YRWEHjSZ+NQu6E9t3Fu4b67ldUeZ/ltcjW+6ryOlJkbeZ9AqYq2+JGS
	2D8g==
X-Gm-Message-State: APjAAAVO68CVPI8QNCuD7yCMJYGMO8CrzRFQyF/mElltYESv7N8w3Enw
	W2pfuUC+12YhLDuD0ej1m6aR/2HGD6tbq98de+bzCo/kg4g=
X-Google-Smtp-Source: APXvYqxn0sgcs2vgMhJFvk5+tsT4PpYjDbiaWXTAjVSv6lIJYJDh/Kp9dcqcwQ32slJ19vGkce3VPCawJXTZBtVZzkI=
X-Received: by 2002:aca:ab12:: with SMTP id u18mr5538127oie.48.1556890513381; 
	Fri, 03 May 2019 06:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190430044036.1144-1-joel@jms.id.au>
	<20190430044036.1144-3-joel@jms.id.au>
In-Reply-To: <20190430044036.1144-3-joel@jms.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 14:35:02 +0100
Message-ID:
 <CAFEAcA9HsxWxRoNVy+fpm_PYdiB+Ei6k7bbLeG-qG+KXkG8vkg@mail.gmail.com>
To: Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v3 2/2] hw/arm/aspeed: Add RTC to SoC
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
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503133502.pmtUUt0UxWOcVOxdV66CmOD64yaqyLowvqCcgG8r8NE@z>

On Tue, 30 Apr 2019 at 05:41, Joel Stanley <joel@jms.id.au> wrote:
>
> All systems have an RTC.
>
> The IRQ is hooked up but the model does not use it at this stage. There
> is no guest code that uses it, so this limitation is acceptable.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

