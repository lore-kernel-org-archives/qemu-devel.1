Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F94C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 10:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B91206BB
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 10:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A76OblE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B91206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2YM5-0002vD-7E
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 06:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i2YKs-0001fE-Ti
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i2YKr-0000Ur-2I
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:04:22 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:41872)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i2YKq-0000UV-Se
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:04:21 -0400
Received: by mail-oi1-x233.google.com with SMTP id p127so5871544oic.8
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 03:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bcYdM/VpsftGmw6M8+hYje8AECiGMYuLdsd9AzDk0gw=;
 b=A76OblE4yteutZ0PShvlurqn9ycDbS9INjXoacjwrROKX2Trle772LkA8U81oArOlY
 hQrv9cnjjt9h9908L+BlwwJLu/FDG5kBv6/nZ4Z2BinZbvfhMaxit7KfVZ9Hp9F0mljK
 T3YNZbCcCT0ZvcYqH3eH58fiwi5RXPyPkRd5tX0F28OCYyIKkrj9HRBZ3IJE2c6U9ohP
 NCUJC5lIfC7wWx+4xHpuPXJaOvRhBtZGIAawSTNPsb46T77huhcgcelSdmnE+YDIdxHY
 07ZQxivM6wk4uFrAoCSkrRvS4gJxdTaJLXVIEeMbOLzdiIL6LAkFOYutU9n83YQhNMMv
 0mcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bcYdM/VpsftGmw6M8+hYje8AECiGMYuLdsd9AzDk0gw=;
 b=MQGtub8yG8D2jTJHcsr6QUxe2yIuRgnnyvOsxkOXELf78fJdAl3V/lcBaRNtMEVLSQ
 VV7iEY0L+J2Qd6nsE2I2ibSYQ6zuCoI7wH0Slzsebr15MoKp8KTD4oucrS+Foaa2xPwH
 gRykAc0biNee3y9DXPaTlyx37HH00uEYX9n7WeNmD6gpYEYuvdc4sI7ftoXAQA25A8uo
 IAYs0qmFXIz89UEnx9BRW7hac3s5Vxw8hMqypl2VRodqrP4n0wobXDsxzEwFjdOxoQML
 N5OAeIyqHeNOblAF4M8b0Dh7sJz+R7zf2OQCTmfi+h6HYYJkdMy9DIXbmf6rlKW1yEJh
 /VnA==
X-Gm-Message-State: APjAAAUoGY6DC7J/qLjGOY0SmpJUuBe9qEptk5aAWtP6amMC7UXy6OA3
 RGuTSdJifq7TU2ZSgesTYrb0NC4f0Crl/5t9xhvZHw==
X-Google-Smtp-Source: APXvYqzHlKkhQaeRDK/ROUijTfKrB9PbZwbE8n54ngaFHOLp6FNHnq5MBjBNpA9DG6K1Uupi9BkJgcaD25K2yKZEj8c=
X-Received: by 2002:aca:50cb:: with SMTP id e194mr14406114oib.48.1566900259645; 
 Tue, 27 Aug 2019 03:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190825193757.16297-1-richard.henderson@linaro.org>
In-Reply-To: <20190825193757.16297-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Aug 2019 11:04:08 +0100
Message-ID: <CAFEAcA--rgv=SOHavYJxSQnGQS0BgoJ-sFQ7DPkiEedqq5nuEQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::233
Subject: Re: [Qemu-devel] [PULL 0/1] target/alpha queue
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

On Sun, 25 Aug 2019 at 20:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 586f3dced9f2b354480c140c070a3d02a0c66a1e:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190822' into staging (2019-08-23 15:15:44 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-axp-20190825
>
> for you to fetch changes up to cb1de55a83eaca9ee32be9c959dca99e11f2fea8:
>
>   target/alpha: fix tlb_fill trap_arg2 value for instruction fetch (2019-08-25 12:30:48 -0700)
>
> ----------------------------------------------------------------
> Fix for alpha_cpu_tlb_fill
>
> ----------------------------------------------------------------
> Aurelien Jarno (1):
>       target/alpha: fix tlb_fill trap_arg2 value for instruction fetch
>
>  target/alpha/helper.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

