Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEDAC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:15:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D2D520851
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="upI4HSPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2D520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35935 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTnZ0-0003hO-Q8
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:15:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTnHl-0004s9-Tm
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTnHj-00030s-7X
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:57:29 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTnHg-0002yu-E9
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:57:25 -0400
Received: by mail-oi1-x243.google.com with SMTP id t187so4247140oie.10
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 05:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=6u1qTQvAYVuQuf5vqoJUT8LoE9LpKteA/VhDaNrEurY=;
	b=upI4HSPAdUR+Wl8G+F/uZ9fVmVEIhdv0xv5rF8FLR4WApC1cqku6YvWaNMefoqnkkW
	dYV12o8zBBaotd0OFyABwiCHbAnhOOHfVKjmnTgcN97slCErP0egH5Jc1Na9vjWxTSGd
	H19wbDPDnhXXQ4f61vpdUpDkrttU+PY6GsyXLPpNT0CTn0H5zC5wjDGHQQbyOJ390jWk
	/tBotF27LsbuEiKQwJ/S/hHf8fQHfUdwS6JrgV/k1xoXajVoH6Pf8zzyMfrYOo8ukJXa
	P3Hgh/ZyReqaBAkfMIOFdhs2s98GkEHXu8QWiVUz7ZDTSoEJzkn89Sr/9drZaUQiqvJc
	jDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=6u1qTQvAYVuQuf5vqoJUT8LoE9LpKteA/VhDaNrEurY=;
	b=DHGCYcj1W10Mt4PbKyu+qmDAKcsOjPkwCaL4JpyZRwF5/iHYH953skCyzfJYD5unS7
	S6VNIeywX+f0pbAU9ePV0lpzrhay0bLWFBwjtwbG6x1KsHcLrA0rv9ZCfZyJMdYD9Kgr
	XFgTyoLA6rCQUQxrYggvabVDP8o3wNDr0tu5C7SDYxhBeD9itpXroi8JpnL4r4wS1WIE
	gdytOLSfNSsfoBkq+ReZa766bhPFOH8I1vg+w9toU0S+Zptb2vGWYa6y5vXidsgMKtPw
	MBLvQNZam/vDrSvoJn0a6gvuonlauBXaAF5eg7Y8uuBhCFUjxXwBncxe4B192OMfkLUl
	6QuQ==
X-Gm-Message-State: APjAAAWc+1upgFIepRlIw/0soagYqmLnJzThCJNKQE40jFCMeHGvz8a+
	ar00BwxeD3Umeeo4kD4aBzDN3nKI7EIMFDvGJCw7ng==
X-Google-Smtp-Source: APXvYqzhEfkIBuSKvoXCvV7T7SVOQJPBbyFr+pc+nv56cJAbc8xLjrBvz55qZ2Y7gk370vbnLbo48E83OfoG6m8tLdc=
X-Received: by 2002:aca:845:: with SMTP id 66mr2613152oii.163.1558616243665;
	Thu, 23 May 2019 05:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190520214342.13709-1-philmd@redhat.com>
In-Reply-To: <20190520214342.13709-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2019 13:57:12 +0100
Message-ID: <CAFEAcA8vcQw0fGy3eTpmkYb+=-wiy=7xS6bjb3aJJBmGBo4LYA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH 0/4] arm: exynos4: Add dma support for
 smdkc210
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>,
	Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 May 2019 at 22:43, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Another intent to salvage previous work from Guenter Roeck:
> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg06302.html
>
> Since v3: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg06674.=
html
> - rebased
> - QOM'ify the SoC code
>
> Since v2: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg06459.=
html
> - rename init -> create
> - create controllers in SoC rather than the board (Peter Maydell)
> - add Linux dtsi in commit message
>
> Since v1: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg06335.=
html
> - Do not factor out pl330_init, which resulted in buggy v1, see:
>   https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg06448.html
>
> Guenter Roeck (1):
>   hw/arm/exynos4210: Add DMA support for the Exynos4210
>
> Philippe Mathieu-Daud=C3=A9 (3):
>   hw/arm/exynos4: Remove unuseful debug code
>   hw/arm/exynos4: Use the IEC binary prefix definitions
>   hw/arm/exynos4210: QOM'ify the Exynos4210 SoC


Applied to target-arm.next, thanks.

-- PMM

