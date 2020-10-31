Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF46C388F7
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 15:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC9A206A1
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 15:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l6BzSHF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC9A206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYshz-0007JG-FI
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 11:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYsh8-0006rI-E5
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 11:21:30 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:37159)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYsh3-0007Uz-7e
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 11:21:30 -0400
Received: by mail-ed1-x542.google.com with SMTP id o18so9744891edq.4
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2020 08:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y3FTOIWKoACXeB9bxehIKqItvK8BcAi1OznwLkk0X44=;
 b=l6BzSHF1Zid5jZMHZi9FY/B5hhrFH20Fmq5jzzCJ7pVwWdcm7BfawXg7qY6P1tLYnF
 RPkv1rBTTvyR/6jFKOcZFrINseP1RXA8xQllNTXQVs1YjULCNHZy9jJgxtU+d8NMaCx5
 KzTd9+CZZkgI6HS5qDrg16ouY7jSYpawhIAqa/EVXWh3sy99EYLAINxXecKp09UDLKRa
 EP14LqVlXNXn1Tk6Y0n/eEtTkVyS7s+1dpw9Z8KOlnVhOpFPufZb2Q/ay/FQoouuyLx7
 HB9rD0A+qfrPNipe3zqHXp9vCRP8t7IEDAcFu+lj0rSRHICuxebaYBinL34pC807D9qN
 pnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y3FTOIWKoACXeB9bxehIKqItvK8BcAi1OznwLkk0X44=;
 b=o3c4l37tKJsZ456cvBZv74NaAYtjXSCSqroAv2TMsG2msn448kha8JsFSFI8nXRpzc
 K8er6qhkIBzW1JalGvQ1E0F1u3zRtGSoaDEot8PhaXJdbb5bkQle55qdnBVkj8FqIQQ5
 +Ic6aYJx+LjBNGUK7wFMQ9mPY/MBCzoq9R0ZJ0mWOkxuzwd/1I6iMwD4+xE+Xmt+0Kww
 44Qu4LACW2pZkLTNdIdDiFOAhYgksepYPzCN1OIgsKItqU0uRsOeFg18okGabC5VWB0y
 ExK/aCUpWwLrALXB453SpmAiQrLwOJ2kCa94qKkkyUD4RmAmvRGYTs33aOcBYVaJqkxl
 BaaA==
X-Gm-Message-State: AOAM531yyFx7E5UkqJaEigpyCD0MV2hROeotDMo30hknHeo/kKg53Bl9
 gKzGWcX0bELrYDw6q6K9iSvZ4WCvxpkbxCsdG3CIig==
X-Google-Smtp-Source: ABdhPJwI/gQAgRsOPTmTsgN/9RLhTvdUg/OaVz0wC9nDx2h/Xfv/jDAT6Qp42SR8uhfZ8hkWUbyY6q2UgMKRDEZ5oh0=
X-Received: by 2002:a05:6402:b35:: with SMTP id
 bo21mr8393283edb.52.1604157683543; 
 Sat, 31 Oct 2020 08:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <5F9D449A.900@huawei.com>
In-Reply-To: <5F9D449A.900@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 31 Oct 2020 15:21:12 +0000
Message-ID: <CAFEAcA9w_JZ5m2Cj9Cuc4GMka8vp-AabtmqNLwe0q7ObN7QKyA@mail.gmail.com>
Subject: Re: [PATCH] util: Remove redundant checks in the openpty()
To: AlexChen <alex.chen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 31 Oct 2020 at 11:04, AlexChen <alex.chen@huawei.com> wrote:
>
> As we can see from the following function call stack, the amaster and the aslave
> cannot be NULL: char_pty_open() -> qemu_openpty_raw() -> openpty().
> In addition, the amaster and the aslave has been dereferenced at the beginning
> of the openpty(). So the checks on amaster and aslave in the openpty() are redundant.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Alex Chen <alex.chen@huawei.com>

This function is trying to match the BSD/glibc openpty()
function, so the thing to check here is not QEMU's specific
current usage but the API specification for openpty():
https://www.gnu.org/software/libc/manual/html_node/Pseudo_002dTerminal-Pairs.html
https://www.freebsd.org/cgi/man.cgi?query=openpty

The spec says that name, termp and winp can all be
NULL, but it doesn't say this for amaster and aslave,
so indeed the change in this patch is the correct one.

> ---
>  util/qemu-openpty.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/util/qemu-openpty.c b/util/qemu-openpty.c
> index eb17f5b0bc..427f43a769 100644
> --- a/util/qemu-openpty.c
> +++ b/util/qemu-openpty.c
> @@ -80,10 +80,9 @@ static int openpty(int *amaster, int *aslave, char *name,
>              (termp != NULL && tcgetattr(sfd, termp) < 0))
>                  goto err;
>
> -        if (amaster)
> -                *amaster = mfd;
> -        if (aslave)
> -                *aslave = sfd;
> +        *amaster = mfd;
> +        *aslave = sfd;
> +
>          if (winp)
>                  ioctl(sfd, TIOCSWINSZ, winp);

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

though you might like to mention in the commit message that
the openpty() API doesn't allow NULL amaster or aslave
arguments.

thanks
-- PMM

