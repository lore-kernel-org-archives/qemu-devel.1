Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826ADC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:18:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BFFE206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EVSTJRyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BFFE206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiErl-0006PD-HG
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 06:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiEqx-0005Yg-As
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 06:18:03 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:40650)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiEqw-0007zR-HB
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 06:18:03 -0400
Received: by mail-oo1-xc41.google.com with SMTP id v26so2318253oof.7
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 03:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VG9D0ExKOIr3yROIJ5vzypS1vnWNvrFVqlp9ij0xl9E=;
 b=EVSTJRyTpYmVBiA89by/+Q8b+/3dg9nQWIF1YMlCW0exs65/2Pt7UdWji6cHyCWwLn
 stKuvOXV6FXN5rKYPrqPuIhpO3thixz5/VYvjgNzXf5FQ/CfAzWnr1tC+kFSzImMdBWI
 YX8evSyIIvy7w7r2f1IvkmQmFQTNIiFvvNcAudbHIg1KhQAMPUxZ9hpqIgdfOR1DFfW5
 mAKAL7aVWG4yb/cx/BebBt62d+WyPatE8uNPajZg8rasWHsFkskV/IzmWGRifdnRZUaV
 WwW171oHVFwcY40V/AmCnoJYNEl46wmRRyXKvgZUBXnbZUHpQ33oMClq+GBGVnqm2BFs
 RqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VG9D0ExKOIr3yROIJ5vzypS1vnWNvrFVqlp9ij0xl9E=;
 b=mZlWzhs35LnfJEKMKFLrKGEStw3qE60j4Q5Mx4Ec/hPCXvFNeAFJwv9FTKSiUNDuzy
 JEsWOaorOGLnMkwZ0tSBhON6PLXc6GGE927aQJ3uuk6mYKkrzUHiGjsAFBFm7WNxiDMs
 CbRtme9nl7G3viGO4ytWZjzgmuipKAxsPWW5AVP+U2z8M6MAWSaxo777y7cKYwDr8Hmr
 C9aLUSDPq79KQUa0K/5o2Gf99p8TeWBCPaTEdtdl9khdpVZW6Fnn/d1xSw/DBSBM32fC
 NBlqjoMR+JMgNZi8TtMZvPdN5LUc4MsCrgtfAa3dEv354T9dFEgTd/QRT/HNHXSED2ci
 lyDg==
X-Gm-Message-State: AOAM532Q/mChVcVcgARP8MAqyY+cag92JkjpBOLpyLdb8YAMdUoiWnez
 EqpUa8mF0NmJ2J4znnw1+4W2Yckysn/5DBGfWptK4w==
X-Google-Smtp-Source: ABdhPJwWocVM/mxPNIqz6xtkMXFTq1EM0Wv/k7G+9ipP2p8vUmCvULsefkROPqb/jQYMovX/oY8+N9a+d55f7cj5xe0=
X-Received: by 2002:a4a:9528:: with SMTP id m37mr590680ooi.85.1591611481458;
 Mon, 08 Jun 2020 03:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200602235834.470345-1-richard.henderson@linaro.org>
 <20200602235834.470345-8-richard.henderson@linaro.org>
In-Reply-To: <20200602235834.470345-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2020 11:17:50 +0100
Message-ID: <CAFEAcA-2FT+UkxG0yg479E3uVJQxJN1JrTcXETWYZ61kZEyjaA@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] tests/decode: Test non-overlapping groups
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 at 00:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/decode/err_pattern_group_nest1.decode  | 14 ++++++++++++++
>  tests/decode/err_pattern_group_nest2.decode  |  6 ++++++
>  tests/decode/err_pattern_group_nest3.decode  | 14 ++++++++++++++
>  tests/decode/succ_pattern_group_nest3.decode | 11 +++++++++++
>  4 files changed, 45 insertions(+)
>  create mode 100644 tests/decode/err_pattern_group_nest1.decode
>  create mode 100644 tests/decode/err_pattern_group_nest2.decode
>  create mode 100644 tests/decode/err_pattern_group_nest3.decode
>  create mode 100644 tests/decode/succ_pattern_group_nest3.decode

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

