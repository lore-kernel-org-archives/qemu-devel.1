Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E88C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:20:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEA032077C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SypIhZn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA032077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iui1s-000899-Hy
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iugMP-0000Hb-2x
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:33:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iugMN-0000yg-A9
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:33:40 -0500
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135]:35448)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iugMN-0000ww-3n
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:33:39 -0500
Received: by mail-il1-x135.google.com with SMTP id g12so2699383ild.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 09:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uOC//XPFGiuT/ieL7eFSRItnN7Qsl3kIUUTCbY8mr+I=;
 b=SypIhZn9XEH1BAU0ShQSJI9kJIxqiBValFl27ZqvO75kgnRYl4+sQX5dCIbJ+UubW7
 kA/YZIJDgj1MRTkMxU6yclkg1k0Vz6oU5raBLywvxDJiD/8HNAvJlvrRfL3orSVNeuwC
 TDYUPgmrLfSzWwI2wXUn6eWVNLd2PxnpEozIpiMaRDrnp4v3Ry2Qq88dTYOdRv6WHaij
 alf4sU+6U0UUtduCJJcPrimIYQ6YL80pmGOip0X3TnHNMtjePE/z8qqvolIRbokVjCTJ
 NPmmBwuSrjGP/kACNxgALb8R8S56kr84QFbZwvHx6Opqztml/IapsKHUYEaJXZ5+OMQl
 7Gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uOC//XPFGiuT/ieL7eFSRItnN7Qsl3kIUUTCbY8mr+I=;
 b=ulP/jneVXbyoR4XxRqkY2mRfSGt85/O7kEd/T3ctVngNTkL/PEtTfsYnw15AC8/SPt
 JAGaSvYCt+XQec3/LZtbtNWlJSYWIFQ3YG5dzc8G6+kfIHbALB1Dp/eP81zQkhKA9KCv
 LLxiQFXJ0ug5WMtT16sZa9UTRucm5k7fNe6FDZz7WM+7jcGn/bdRG0++KvtXUcs75NR/
 ohDq47Rb14/0Hr8ypA2yQNX71NLykYfRZo14P/9RRhlIhI+279VaHTXGG+YZdiqYVV50
 IFaCRPjIju5Oo5sR/fsc/F8uktekPHBCW0jssi7s7R6hA5fvvYd1bbonezHHggVVr//0
 RiTw==
X-Gm-Message-State: APjAAAXVr3/r/OASyIIR7Ly8zsBXJifPFHbsaRAVOwjHSivysN1g+ssE
 awSZGaKW7M5O8o4nwCxIGEAU2uYfP6llnrKZYy3mtw==
X-Google-Smtp-Source: APXvYqwM3dvx2kS2cKMTrUKAko3YPRy2/USXEX9OeTZrtrS+xZ68vgVL+z/1IgfAEcezsq2Aw0bXkNfzDPiWJcC4/ck=
X-Received: by 2002:a92:5c8a:: with SMTP id d10mr14299332ilg.137.1579800818230; 
 Thu, 23 Jan 2020 09:33:38 -0800 (PST)
MIME-Version: 1.0
References: <20200121191033.28195-1-peter.maydell@linaro.org>
 <20200121191033.28195-3-peter.maydell@linaro.org>
 <5fa9a519-d9c8-13b6-2d38-efa12c29780d@linaro.org>
 <CAFEAcA9ty4srYsjbGDEQshttcA97yFco=7fLGV8SV2oT7FeQ+A@mail.gmail.com>
In-Reply-To: <CAFEAcA9ty4srYsjbGDEQshttcA97yFco=7fLGV8SV2oT7FeQ+A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Jan 2020 17:33:27 +0000
Message-ID: <CAFEAcA-FDd1vsKGZHnYM=ewFoaAsZCz0YuNitv=0wh-+=w8iRQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] docs/sphinx: Add new hxtool Sphinx extension
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::135
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
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jan 2020 at 22:22, Peter Maydell <peter.maydell@linaro.org> wrote:
> I suspect this is an incompatibility (or possibly just a
> dropped back-compatibility I was accidentally relying on)
> between Sphinx 1.7 and 1.8. (I tested with a 1.6 and a 1.7.)
>
> It looks like ExtensionError is now in sphinx.errors, so if you
> change
> +from sphinx.application import ExtensionError
>
> to "from sphinx.errors import ExtensionError" does that help?
>
> If so then I'll test later this week whether that works also
> for 1.7/1.6 or if we need to do some version-specific stuff.

This does indeed work for older Sphinx too, and it looks like
it's been the intended way to import ExtensionError for a
long time -- I guess it was just an accident of implementation
that importing from sphinx.application worked too.

thanks
-- PMM

