Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45B9C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:57:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 874D5206CC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y62BspjZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 874D5206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Jg4-0003wS-P0
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:57:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Jea-0002yg-BP
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2JeZ-0001GG-8f
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:56:00 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:39597)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2JeZ-0001ES-25
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:55:59 -0500
Received: by mail-oi1-x22e.google.com with SMTP id z2so6862277oih.6
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 10:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K0CGjtyCWo7wnobPK52tLZDgMFUrXvJUlRSlKtZu/pY=;
 b=y62BspjZ1HZL5pgkN7UlrQ2SJmEBoEiBYqYt2Q8IVHcIjETN9y3wpt7ZZjUNoq0FlS
 xsK4KjXS9jkw6K3kucQk0yFTQDKl1xUlRkCysT6JMGwvcCNmb5NhCqcbBR/BuWVa6Seq
 FVtjbce24Gyah7TEyz5GP0TY7B2MjxGiIPEvmN69WvCnQ3uzx00fJ8MX4ww/nNXPWpIM
 cKm4BKUs1cDEKRPNYuGKIWEyweMHWo53svgp3J8kDcqEeCXFX6yrRA4i7WLAe9tQGyar
 MaLqEQjPPNvPm7R15+EK4kcOlShumae9BjDg3k9N43cGPkX6jAu2tPuUHWOYPXIuTnu9
 OV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K0CGjtyCWo7wnobPK52tLZDgMFUrXvJUlRSlKtZu/pY=;
 b=TZIRnqJoJG/bmSOIU2cA3KITdzLr5IMoKhQ34E+cLa+aEM4cq6NY02V86OsAtFIruh
 jrD25wcsUiR/Hx0grF02zWUDwF5Aezt3qZpXF+8cRI0upAkxtKBadZ8lq+WCPr6dLzWb
 vSg5va/8TCbFaOnFootZupzqi4URqBijAoCBZfpShFmY/4ZdGug8AEM25lYkFTdRXPGR
 zRMD71VNeGxswk75EvUM2O8Zs/a7VXO/MVf9qI0je9Kw52iTrM4zxx96symw5T4By4XE
 gThV9thBGUxU26yrcvR61FC8RrPBiufLqwM9Z23gfE4zR5Pvjk90KSRnnsZIw3TcYlJA
 ih/A==
X-Gm-Message-State: APjAAAWWb7g4xmOxLp44AIuy7+8uBkZL52ryoub2zsytixpRl9BelMij
 hbKkq2juljcE/lDMNajcOJDNyqVnxngzO0iI2eIyrg==
X-Google-Smtp-Source: APXvYqz6If79t2Sde6L3cu/kwxWVqsPDAywzBAyaBbZs+XJJ4Zo5NvmAkDzlmTe+SGQewXnMj2asVkXZXbRnNSwMF9A=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr4008557oid.98.1581620158227;
 Thu, 13 Feb 2020 10:55:58 -0800 (PST)
MIME-Version: 1.0
References: <20200213002332.31821-1-richard.henderson@linaro.org>
In-Reply-To: <20200213002332.31821-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Feb 2020 18:55:47 +0000
Message-ID: <CAFEAcA_wgyT0jh+UX0KHk8OW9pOoWNokdu5a4uyji4ttREZiaQ@mail.gmail.com>
Subject: Re: [PULL 0/3] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
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

On Thu, 13 Feb 2020 at 00:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit e18e5501d8ac692d32657a3e1ef545b14e72b730:
>
>   Merge remote-tracking branch 'remotes/dgilbert-gitlab/tags/pull-virtiofs-20200210' into staging (2020-02-10 18:09:14 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20200212
>
> for you to fetch changes up to 2445971604c1cfd3ec484457159f4ac300fb04d2:
>
>   tcg: Add tcg_gen_gvec_5_ptr (2020-02-12 14:58:36 -0800)
>
> ----------------------------------------------------------------
> Fix breakpoint invalidation.
> Add support for tcg helpers with 7 arguments.
> Add support for gvec helpers with 5 arguments.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

