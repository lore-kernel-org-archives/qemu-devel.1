Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C21C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 17:11:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C292207FD
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 17:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vxj318R4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C292207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieMZO-0002Jy-MV
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 12:11:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ieMYV-0001n3-K5
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:10:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ieMYU-0005wz-KY
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:10:43 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39130)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ieMYU-0005wU-F2
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:10:42 -0500
Received: by mail-oi1-x243.google.com with SMTP id a67so6988141oib.6
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 09:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uG0p7uaocyTdM0lZUqiJyB5zKa4/nuiB6lCeMmbQvYg=;
 b=Vxj318R459k3r1HH7WKzuOobiHupJZ/+ErR13u9Ln0EV651ESx44qpEzkD1N4+S8nC
 2geP1OSFmIXo8BqBFHMvjrUt9bK/bVpZeozDuaTzBgLsiFVd6Se+3a1bPG+SgCyqrmXv
 HEFkOP5ytYA/AtXNsqsxqGUeKjA/+334Nhlyd4QgcZq/bxxCtrXpZV6sbKJaKogpSLnv
 funYKCiOy6KFZgu1lzZ/HfZwzcL08vI6Dk9+WlP9ggE8AS81M8y5nZUcybNBZ7cj3oXa
 NURnBXJ7F5DOYDzTs898khBJ8NHxaJzr4IpvKGKxrdsha7x8B0JJ7SGzgU1yCKFnNuLZ
 adTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uG0p7uaocyTdM0lZUqiJyB5zKa4/nuiB6lCeMmbQvYg=;
 b=uGgWmfaSHimfGTOOuzTru0t2vbGrzRHsGIIv7v/ZfXWlQl2kq3FdpcxkOYWxEYThhz
 itRWa+KkAIXdq589L/pKsv1iTvFkwkrLcqHNAxmrdRQdqJf1rCCMmREO4wqNcdS1eQjJ
 GX0A9eZv+i4WrWlkwsGI7ejA12eKDBPN+3+kRjP7COGjNLsPg/mjup2ProQTuyrQViCW
 uxY5bxwAeRdSu9NWouef3A+/3bLcaGi7T1S+FNw1FQlsw3VM5YJ2bx/u7cWmw5gEAgfJ
 p6J6bA72PvDsYsA/C0OtNV1zun88Xji3yC1viMhznapuokm/DNwwmexYy0q9qPlqbVLE
 Ie7g==
X-Gm-Message-State: APjAAAX5tGA7Z//nXEqeIWjqvG76jpWSsYrGTEx//MepIUBQwrqZ2PSx
 YigHUvaoG07ev16sAzrhPDekx7CE4s39EtKRGhvDLQ==
X-Google-Smtp-Source: APXvYqxPRr61NIU1WbsewIXezDv84gBakid6F7j379zjtwU9RlCnyRG0iMXGXNEQetueHA1FRmb8lzl6MklJxKOR+Uw=
X-Received: by 2002:aca:edd5:: with SMTP id l204mr78252oih.98.1575911441621;
 Mon, 09 Dec 2019 09:10:41 -0800 (PST)
MIME-Version: 1.0
References: <20191209152456.977399-1-daniel.thompson@linaro.org>
 <CAFEAcA-sgFKev2MiOjRAzuE0trNYQoNe6LOFLeghGm73N1h=SA@mail.gmail.com>
 <20191209170827.yojyts6qdvpxbkp4@holly.lan>
In-Reply-To: <20191209170827.yojyts6qdvpxbkp4@holly.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Dec 2019 17:10:30 +0000
Message-ID: <CAFEAcA_3_EwjAZ_Av4a9BkT_3KmbEEFFFukyV7gsDuWPrYKmVQ@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt: Second uart for normal-world
To: Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 "patches@linaro.org" <patches@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Dec 2019 at 17:08, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> I don't object to making it command line dependant (it is certainly
> lower risk) but, out of interest, has using /aliases to force the
> kernel to enumerate the serial nodes in the existing order been ruled
> out for any reason.

No, I don't think anybody's investigated that (I wasn't aware
that you could do something like that). Bear in mind that the
kernel is not the only consumer of the DT, though -- you need
to use a mechanism that all DT consumers will handle correctly.

thanks
-- PMM

