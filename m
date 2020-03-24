Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21747C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:53:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD56B20774
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jwGcWA1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD56B20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGkwE-0005hJ-3D
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 10:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGkvU-0004tt-HK
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:53:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGkvT-0003QS-Bo
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:53:08 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41332)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGkvT-0003Pz-6j
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:53:07 -0400
Received: by mail-ot1-x343.google.com with SMTP id f52so283929otf.8
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 07:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GIefcW/kUZn9CT8AEq2rh611q7yBxsdo0Z6TBAjtmB0=;
 b=jwGcWA1sQYagrl51hyV2rZH+V+bJlRrXZZUBjzo0VOlvjBiiKlvaEUIJMVNdWENCVY
 97NdQCQ13kecdtMyHUul3Wmlo5hNqKJ19lFUuJaGRYOHar4V4zdekm/hccHDrHDOuoCU
 dK33ceZsHfWwhSsPz+nmwvB2UHU544ZGSk1ryv5TsoG7xFBTaJYxLlBFBws7FCaoaEk2
 iZLHHcxgFH0C+lZCzVAxrM7HNGXXDEM/CXRgaZNCBU8Q5QGwSZl4KfzUALbYxgwR5JA7
 s1lGx0zwwhKMWYgxZsf8t1MZ11YdTj4UwHJt5keFtc6RM3jjy26nr9Q0cjiqOlwTgk6p
 2bTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GIefcW/kUZn9CT8AEq2rh611q7yBxsdo0Z6TBAjtmB0=;
 b=Z5cThf06BkImjW7lHbWazl4Ad8iCZR/SuGjmCP+rmOSEPQvY5j1mq4OC/8oEzyLTez
 l8BT5rbXD4CuF/6jw0Ju/cLNcOsR9DeQs7qXofTsOjuDRBYtsuIWC4tfRmGricjFeE/1
 HSZfUABTIjJqyS4725hHwhj/r/rZ0XtMCPcgIRYcQrBQHNeD/LfQMlMilwKayhHKO6p2
 p02Q+ewZZx3auQrYIpIrBmj7YML11cPAc2+1MLtZYIiLF+OZ2HiRBF43jIvtC8oGAjib
 RVUz5msw3PfsVxkP9qtmSkWKg1DuRfbm2tRyvMe57UL9aMEWN/C0ZWlPsHtJHAtYmrtp
 KbQQ==
X-Gm-Message-State: ANhLgQ0uHSg6+TyJ5mIWls6j8FurUVDTA36osj+wA30/G9/Ted9KmaZ7
 g8B8q9dlSxDyWG8FZVr4mM4T1JdeZUGBodGqkmbzuQ==
X-Google-Smtp-Source: ADFU+vuKBCwTYmhDdpXa72+llgEmbglP5LsmTPH7IiFMjuBfi1rN6gwn2fC4L4aBAGdvDB5+BsqR0YF2Ax/ParRuGmI=
X-Received: by 2002:a9d:1d43:: with SMTP id m61mr22377075otm.91.1585061586335; 
 Tue, 24 Mar 2020 07:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200324122044.1131326-1-mreitz@redhat.com>
In-Reply-To: <20200324122044.1131326-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2020 14:52:54 +0000
Message-ID: <CAFEAcA9YKqfUY338zT+8Fj60mWEMu0BzUmojbB8dxu-1n9RuCA@mail.gmail.com>
Subject: Re: [PULL 0/6] Block patches for 5.0-rc0
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Mar 2020 at 12:21, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit f1e748d27996e0cd8269db837a32e453dd55930a:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2020-03-23 20:54:24 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2020-03-24
>
> for you to fetch changes up to c264e5d2f9f5d73977eac8e5d084f727b3d07ea9:
>
>   iotests/026: Move v3-exclusive test to new file (2020-03-24 12:05:31 +0100)
>
> ----------------------------------------------------------------
> Block patches for 5.0-rc0:
> - Use-after-free fix
> - Fix for a memleak in an error path
> - Preventative measures against other potential use-after-frees, and
>   against NULL deferences at runtime
> - iotest fixes

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

