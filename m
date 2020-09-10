Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A7CC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 20:00:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA4620882
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 20:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EE8FIGKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA4620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGSk1-0008GN-1c
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 16:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGSeZ-00067X-Lz
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:54:43 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:36027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGSeX-0001Mc-Ph
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:54:43 -0400
Received: by mail-ej1-x642.google.com with SMTP id e23so10542713eja.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 12:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8GiZi7KPaoENc8uTEJdS0X5H5hTi8PEOnZj99Qy+VAk=;
 b=EE8FIGKwjBsolRvTG1HhqgmNB7T1mZr+s7ZO/kqiIPQeHtI+8HyFAM30nMptDTzyrH
 M7ZZW6M/7dRVEmAMx/o6YSmR7ApVlOxMEgRzSO8wEk56ba4mc/G+KmUusb2qIKgvMOR9
 wJ4463yZRKM4rocWpmONNisiDJpxRt7pjLjcbrNcleZB8hgQ8MhHfUiZExt/s4Kc/X4p
 pGKQFxNUBtkWQ4xrr7GWbgZaETmbY3T5sKNFSE+M65WkApyZq/Q4qTXzygREncQRJGut
 pEnYdAtApzq8EN3POVPE55Z9dUrcR+DU5j2QHQP+VB4daRmwx6hP1lxPIv9yU054Dq83
 jKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8GiZi7KPaoENc8uTEJdS0X5H5hTi8PEOnZj99Qy+VAk=;
 b=ogc46wwg+BzIuC3F5/+uT9pQhKHeyWvceFdYUhK8WwcIbc0UO1oEAXSfPbRtVT8VGV
 51OPrN1ItqMLKj1uGSgAR0W6xcAZJ2GXWFCi2NTKko6i9MOlAr7ECpeTMjpMDuuDpAhf
 MhE2j0vg0CJ0ZlgKUeSh+wooEhBiKBjG2yaC2UrcQ+nJiI5XZ3okPI4L9h6zZwW4bkeB
 JHUI6LHKk12LUj7pDp2iIaMcDeRYKqngtL5apXSrrGskRA5BU3IQ6MRlMcPoADuKX1yl
 XOcCzVYKy9+1BBsrhY1gwMUPGrlQ4wZj6fr/odb2ctr3CeY8TGdUR1hIyjpjJ1KzFfn8
 hWmQ==
X-Gm-Message-State: AOAM5305QlPc1fCUY/bHrjd08UWyaLSC79mWKL/lye2XsYvTK7vdUwvH
 //Jkj75C7IMeOCNJoGdRMxXo72Cp4SPeAseNtrfGUQ==
X-Google-Smtp-Source: ABdhPJyWYBFOYCNlVlFv2b6WZvHdEdVcC2mqCCExUW7I1qGmRwDDSanKo7Nf9mLl26L6m/mVBWqY1fbENS67y4mKiFE=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr10340341ejk.407.1599767679795; 
 Thu, 10 Sep 2020 12:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200901162046.32670-1-peter.maydell@linaro.org>
In-Reply-To: <20200901162046.32670-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Sep 2020 20:54:28 +0100
Message-ID: <CAFEAcA8iTN73rjPT9gB4E8g8s6AxQoYLKUwrV+ZoE4PNdJ3t9w@mail.gmail.com>
Subject: Re: [RISU PATCH 0/2] arm.risu: two minor fixes
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping for review? Mostly I'm interested in whether either
Richard or Alex knows what's up with the discrepancy between
the VLDR/VSTR patterns in current risu and the generated
aarch32 binaries/traces that have been floating around...

thanks
-- PMM

On Tue, 1 Sep 2020 at 17:20, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> These are a couple of minor fixes to arm.risu patterns.
> (They're a prereq at least textually to the fp16 arm.risu
> change, and I should have sent them out with that but I forgot
> I had them in my patchstack.)
>
> thanks
> -- PMM
>
> Peter Maydell (2):
>   arm.risu: Correct VLDR/VSTR U=0 patterns
>   arm.risu: Fix typo in VCVT_B_TT pattern name
>
>  arm.risu | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

