Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11D3C33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 11:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF072081E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 11:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jnl608Qh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF072081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqy6q-0005P9-PT
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 06:42:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iqy5x-0004JR-R1
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 06:41:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iqy5w-0004cp-IE
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 06:41:21 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:40683)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iqy5w-0004bg-AU
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 06:41:20 -0500
Received: by mail-oi1-x22a.google.com with SMTP id c77so7909229oib.7
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 03:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jXuAmEqcarzf+a78FkUZCIwn83+tXkGCweIcG3ngEx8=;
 b=jnl608Qh+6bv5qSQKmcZSZvX66xxJaHhAaUWItOB0GWDamsBFlbI+mUb2gB3V1jPJ3
 srdIsfmJ5kL70sQJKArKM45nc8Eof9dU/o+WpnaJOkpC3EZooig5u047Jd+a6LutkTYW
 Y0YWri1z0b7sI9OdYYgmvTLmT+F+0ZFYcS532oGMZf7JPv5+a2ArN7Am0Z7rSX1b8hGD
 TE6B6cwK/M6dimmA0nNWAeQm1b9SpLkD7Z006sh7/3/+USDLhGOZRc6LAjstXoMeJj/4
 5o0yMHMRhJvg3t9GhZJcORFQ+mzLEjm0n/NsSySVfUl9IrTpL2tY54IQhRMjDZcfSzML
 gv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jXuAmEqcarzf+a78FkUZCIwn83+tXkGCweIcG3ngEx8=;
 b=kkMcazFHuHjPKlDpFyG2si2MOYLTe7Q79YidAGLnhIAX6/oPP0BraqlUNoAoajdYOC
 hnflalkh9fjBuEbXXfZM3Q7iPKsFZ3RARwIoiXkWDl9nTXkHDpb8Atk6uFhpD4iKfkR4
 UZBz+g3HeKrelm8G48+PCCfPbWMLyvJiXHaejU/IwisnUVzc2u3KAcLDnBGGz5ofL+4p
 oMYklnyF7EQOpO2uqNUMjzuWnBR3B6sc9E0NRkK5UJuJjZQ5P7B7R4lgI3fuZpvfDh7g
 TDvdZ8xsNhoMH5fEcnb9siWMv2Lubgc9fi5EzFBqSS8Gnu5ynt/uQ8Cbf42kyWmXIS19
 iJkA==
X-Gm-Message-State: APjAAAX2WxzGXEIoXgvNx31fgsLVhBbq8/Hck5mB1lA09PLsFIyjnKjU
 nzT0HhA7C5ipULxoH6Ey36TS4aO1wF281ZogYN5Byw==
X-Google-Smtp-Source: APXvYqzPHYRiEM0VJR2S12axuqQ5ZQDsYSphGu7QieRWSkvCRE/T8PEMNUxRIPbk1LUnhuBCpRRtRIp74sHwTVU0toU=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr12514660oid.98.1578915679351; 
 Mon, 13 Jan 2020 03:41:19 -0800 (PST)
MIME-Version: 1.0
References: <20200108160233.991134-1-laurent@vivier.eu>
In-Reply-To: <20200108160233.991134-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jan 2020 11:41:08 +0000
Message-ID: <CAFEAcA8feV07E7Fwq77EaBRyUao5HYVUNCrkp2mn4OU4rSLvkA@mail.gmail.com>
Subject: Re: [PULL 0/5] Trivial branch patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
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
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>,
 Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 Jan 2020 at 16:02, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 035eed4c0d257c905a556fa0f4865a0c077b4e7f:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/q800-for-5.0-pull-request' into staging (2020-01-07 17:08:21 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
>
> for you to fetch changes up to adb464ff671d124010953aad48dd9194cedc6ff6:
>
>   vl: fix memory leak in configure_accelerators (2020-01-08 16:12:39 +0100)
>
> ----------------------------------------------------------------
> Fix some uninitialized variable warnings,
> some memory leak warnings and update MAINTAINERS file.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

