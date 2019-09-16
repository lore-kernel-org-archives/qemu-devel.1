Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E48C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 13:39:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93253214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 13:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="frQz+Rlo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93253214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9rEM-0006Gi-NK
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 09:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rDZ-0005br-Mr
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 09:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rDY-0008IY-0H
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 09:39:01 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40515)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i9rDX-0008IK-Ll
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 09:38:59 -0400
Received: by mail-oi1-x241.google.com with SMTP id k9so7313705oib.7
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 06:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lYo1gVf8Cqn6Gx8lW2HrhkCy128NLnSvCygIeOC7TKY=;
 b=frQz+RloHAB0xiNvk3/PXXrfTJcGoEcmK0OfI+wTb/NMrFRneFgRAxctv6OoG+Yrgz
 uYi94ORAFZrRVnqjskVvK4dLAOvkG+oYH1qN6/kLl5nvYbKA3jFVexmjD+41xT0vnnYz
 q3BEG8V8bmbtPJjGfyr1GujJ7Zr8WjAzSj373kAgpmIREyo0XPA7YrFTZwbAC3CxNZWG
 cFtVYxVx2MhIOFrr936RDzMXimK/o0aw2Gj8inHRmmOGH3YbZynWXi5lhr19XYdPAQDE
 Dj0kENWlr9qKVpd2MqjOWU0KdMu6MyHTZSGfiS7vPOS1b/SVs/8T3P/20SdN6kMs8CBK
 fODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lYo1gVf8Cqn6Gx8lW2HrhkCy128NLnSvCygIeOC7TKY=;
 b=Fp9skNo2xLIk4re11mox8+WLHs3LqIgghvKl3yaAmbQAikC1V7RVarGJxF4ENU30DX
 5PEPwPjP5MID7RX5Fwu5m913697UQs78I31k5vhuJJ9HMVm6v1/25p7754wl9X2vOnY6
 loVA3lsv65Lwvt9t+1Ujq7lrY5vvxTeiRlaxtn4/4NW+/FUPrAEgJa+LvzkFx/Mt9yq1
 DgIgQdA5rrE9ZL/VA1azoRqxthVkHHZVD8jYqI6mR5ymKl9rLx6bJxf4CG0YrT2Y5RlM
 gUnfikr0zEfNiT2zTAqoeTAnDiwrgArJROt/ABbrB3ZTxjQSmyNoV1sZ39ed+4bAIviI
 BVsQ==
X-Gm-Message-State: APjAAAWvmPD/7fRwAequSEBWrlttEUg//w2901WR8N7Fl+IfoyxfSJ57
 CEAz3jX803I1WLPPsL30NkuQrZUOKP5nl1wvJHOZRg==
X-Google-Smtp-Source: APXvYqxvoaVs1qn5MgSJtORXmtz1JX6uWT6FP1wyoR4/tzx+d6oGytCG7nc3Bs/VDw41EZ3jCpTI/32WaPAJhNsxi8c=
X-Received: by 2002:aca:50d8:: with SMTP id e207mr12900829oib.48.1568641138674; 
 Mon, 16 Sep 2019 06:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190915134944.2173-1-richard.henderson@linaro.org>
In-Reply-To: <20190915134944.2173-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Sep 2019 14:38:47 +0100
Message-ID: <CAFEAcA8x+94Aw44HZZhbPVMqf1q0SX5_CeKHo0OHT+B_m7qHKw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PULL 0/2] target/hppa updates
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

On Sun, 15 Sep 2019 at 14:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 85182c96de61f0b600bbe834d5a23e713162e892:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20190912a' into staging (2019-09-13 14:37:48 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-hppa-20190915
>
> for you to fetch changes up to a6deecce5b11827fff8a3de2142d02c5388aee1c:
>
>   target/hppa: prevent trashing of temporary in do_depw_sar() (2019-09-14 15:39:24 -0400)
>
> ----------------------------------------------------------------
> Two temp live across branch fixes.
>
> ----------------------------------------------------------------
> Sven Schnelle (2):
>       target/hppa: prevent trashing of temporary in trans_mtctl()
>       target/hppa: prevent trashing of temporary in do_depw_sar()
>
>  target/hppa/translate.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

