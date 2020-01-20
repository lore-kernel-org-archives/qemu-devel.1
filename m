Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEFAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:47:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E0A217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rfXPmkAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E0A217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itYLE-0008JK-Bx
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 09:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1itYJx-0007Pv-PC
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:46:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1itYJw-0004r5-I4
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:46:29 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44384)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1itYJw-0004qi-Ce
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:46:28 -0500
Received: by mail-ot1-x344.google.com with SMTP id h9so28808343otj.11
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 06:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qOK8VN1mzP/WyTATLIzeey0kgoT/JaPleiDvZFbnNDQ=;
 b=rfXPmkAsvFAoKRd7hT6Rx6u4FyP/fGq/0VjsY6mDK01YjllLh9YT+B379As1nIpUDw
 rj71JAlak8jkYwMoKcKw9fxriX1VhWnZZ0bZaBZ5B/85rX7knp9kFhwMDsa1mYGgUmw5
 Sylpti/R5wf3CJEO24B/+jt/0/s66/hxKtBGWblSbFsWyZbdjE/Xwb1GOYa2CrlGC8A5
 la/WWx02EyobqJIpzjOlyjG/TG3guI1BiQWEpuzWeEk50v3cxwetPyiyMpqMZC+FEPbB
 ajUUXe242aisSzKj4eTE+I5WF+GnwIv6c6x3h4SkfcqWsdJYH6WWvlwIGo2QP+5yHVM4
 8D/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qOK8VN1mzP/WyTATLIzeey0kgoT/JaPleiDvZFbnNDQ=;
 b=hQVTRyogtHk3pFbnoGfLqehlvmuuhEU0+hpkq7x1nyeUhqm2ZdAvSX0L4WLf+w4j0d
 rQ1uXSZEEGcrmW+qOYlHsns8VrU9qLLY6uFdORuxvy/MXwE6zyK+D6y7PqU54QGei1s+
 JwISNhJ4TmI8tRV1OE5Mcy5PPFZIx83G7bnaXElhxfMdiblHJtAkZphCzo6sJ3RpRkK6
 LGEwf8YvGR1VNH7ziH31wwVlpKuTXUZHUy+7Qju85f2SL47vLEHKvUxbErOMa8I+qyH3
 WBG1C6A7FHLtyYjoPuwAVYM/pee81LKNcSFNZ1XT3jfNDHZKesyRQ3Qe31ImROQ5Ar0c
 W6uA==
X-Gm-Message-State: APjAAAVZQfox+JYc9uIch3w4KWLG36Nf8C6t09LPJNma68vMlj2QtO5t
 elNndBmVEVpG3A2u+qyYzjv8lMFhXvbPP5QOVN+7kw==
X-Google-Smtp-Source: APXvYqwF11rGLtJhyZioOKVqH+4t2EebAl2PezJvS2G9f3BuMAqp+EYUBm+Wx/5vYylUm8MOYXxNnQDiEKrQYVhNpIM=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr15344821otq.97.1579531587455; 
 Mon, 20 Jan 2020 06:46:27 -0800 (PST)
MIME-Version: 1.0
References: <20200118164229.22539-1-linux@roeck-us.net>
 <20200118164229.22539-3-linux@roeck-us.net>
 <CAFEAcA8yH8deTL6PrX42Lh_TbR=gx4QbukuKUOo1XgLod=2ZXg@mail.gmail.com>
 <526c74cf-bbaf-2c79-08ec-9472288aaa59@roeck-us.net>
In-Reply-To: <526c74cf-bbaf-2c79-08ec-9472288aaa59@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jan 2020 14:46:16 +0000
Message-ID: <CAFEAcA8j=RnrBcoJzpYJZcLUgyq4N-o7TVKhutoDR27idUu-1g@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] hw/arm/exynos4210: Fix DMA initialization
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 Jan 2020 at 14:30, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 1/20/20 5:35 AM, Peter Maydell wrote:
> > As the comment in or-irq.h notes, we can safely simply bump the
> > #define value without breaking anything if you need more input
> > OR lines than 32.
> >
>
> Yes, I noticed the comment, and I did that initially, but then
> I noticed the complexity of actually doing it in the code
> increasing it from 16 to 32, and decided I better leave it alone.

Yeah, the conversion from 16 to 32 was hairy because our
initial implementation made the migration-compatibility
awkward. When I wrote that conversion I was careful to
avoid creating a similar problem for my future self if
I needed to bump the value again :-)

> I'll add another patch fixing the check and use 32.

I just sent a patch that fixes the check.

thanks
-- PMM

