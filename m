Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0EECA9EAF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 19:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B393C20717
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 19:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ceX45mR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B393C20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOoP1-0006bk-PT
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 15:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iOoNc-0005KJ-BU
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 15:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iOoNb-0003cR-6P
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 15:39:12 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:44847)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iOoNb-0003cH-0e
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 15:39:11 -0400
Received: by mail-ot1-x333.google.com with SMTP id n48so5348159ota.11
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2019 12:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=En0pxZBUwqECtcSh2MvMrSmTHOQjV11VouXeQuLyeDo=;
 b=ceX45mR4xxE9sAbhyKyQwI7xAzBlxFFEWgREPUhfDhHBfEUuPLC7y1BWGtMdtB1sFk
 L9qAshFU5jF2sLVGv9KpVJhrsFvpNjNK6LbTYdgEwVJ2JY2uo4Xo4IW+CqRWdj8DqSOb
 bkHgnzs6v5nQiarO68k2bGoRbx0Oe6RhOWbNK4+SEMvRZYeX1KIV6ulXFun2CTt4crEl
 vlWZvyBn7mJYjSkVtUfkh5XtzUUF7P3RiJ/wCWL4OAiVimqIAEvfrjg9UWWDRu8VUKqI
 gIkab4TcHWyyki8+9ld7ZdlPp4bzGEoFhIYDMldUeMXMGT94kRhPJfpg/CvQTKJSLCvI
 27Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=En0pxZBUwqECtcSh2MvMrSmTHOQjV11VouXeQuLyeDo=;
 b=DOoDli3zQKvZWAX69pOzT/aUdTXKQTLev2B1jRasvCXwOR+VnudQ8yD7acx59sYavC
 9bOUzo7jhbXwtyBh60aYr8UXZO93rSjX9vwQD6HxoC6yEgJUbzzjhEH5119936Z2y72p
 tk8xxTjntP7lGfUo2KFi/sySQMHUZSET4BcWj/YZpPkxjy73MXRv11MSvXHgCrWTyl34
 fbDguQLelOp4o8tNcU+gnL8SEb7NhM4LY++21r6CZmHWbQSingEQtEceV+e4U5h+zB7P
 jK/u4oL4D4CsuEjZJ55vXAWPxnCu4GWO7yHHb0cs/iH0/7aB+Z6s5E018BmP8ZLm+upB
 Q3fg==
X-Gm-Message-State: APjAAAUXwkzQzUwF71yJgPqUDNRKcp/xWOf+fpaT4/R/MTX4N8riXPAm
 w9vCz6GJ4ecCQUWD429ERRWpmypFe+8eTcJ8tShi1w==
X-Google-Smtp-Source: APXvYqyWPK7o5a0YXKdm1XcwQcZEVgCTczyPYIUtq9iVxVk75tyozemXQoeK28A+6N0I6E+dRyEje31IDXz3y0b+A/E=
X-Received: by 2002:a9d:30c1:: with SMTP id r1mr11219113otg.91.1572205150136; 
 Sun, 27 Oct 2019 12:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191025193709.28783-1-alex.bennee@linaro.org>
In-Reply-To: <20191025193709.28783-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 27 Oct 2019 19:39:09 +0000
Message-ID: <CAFEAcA-n0171JSFxRr6OgJBCiLH0UNoEH73YN-TKMvLoHjpwcQ@mail.gmail.com>
Subject: Re: [PULL v3 00/15] testing updates
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 25 Oct 2019 at 20:37, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 03bf012e523ecdf047ac56b205795024725606=
4d:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2019-10-25 14:59:53 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-next-251019-3
>
> for you to fetch changes up to 8ce2f68fc90e36d8cd57585f7f4bc75e5038f0b1:
>
>   tests/docker: update Travis image to a more current version (2019-10-25=
 19:24:21 +0100)
>
> ----------------------------------------------------------------
> Testing updates (split from mega PR)
>
>   - various Travis dependency updates
>   - enable tcg debug for check-tcg
>   - additional Xcode build for Cirrus
>   - dependency tweak for gitlab



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

