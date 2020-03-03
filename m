Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567FBC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 13:46:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D63120838
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 13:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dZfavzIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D63120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j97sM-00038E-AV
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 08:46:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j97rH-00026K-M9
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 08:45:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j97rG-00068y-BT
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 08:45:15 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:41030)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j97rG-000681-52
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 08:45:14 -0500
Received: by mail-oi1-x22a.google.com with SMTP id i1so3014202oie.8
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 05:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+6kC/MxN96XDjZC4ViqFdGoNvjEOmih+uCMk3b4PjZA=;
 b=dZfavzIhvxwcSdtmly3GA7pUb8iEVOSbeGQEYYhQJzDHlQIzMPbBm1Qp0HfF52PAKL
 YRKqHpLzGso6AagP37GnXX6knnRbK9ThrcjN0Y15Rr8Hh83XDoj5+IF7yqT2rYCYQ3UC
 p2wigYlvzYBt/69W9V2dEx4kPlmwwDV9Lknh/1/VQhb3IAy3pu/TQNxX9YZcTTAnP1w5
 dx8PmstvHg3P1JRsSk8J5wGsMUBWgP20VQwHKi7rE321GvIKYTGNSqkXC3TxLIywr36b
 OaAKxf9PG7Zfh/bLS7v2ZlyhgDkkaruVpNILPC26gqadlT5UeJB8FyWFjdSE65XPSX+r
 AqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+6kC/MxN96XDjZC4ViqFdGoNvjEOmih+uCMk3b4PjZA=;
 b=r+L/cdEG49sN//2zRt9xbCw6uLH7lxsCssW//3vR2SXcXwdS0TMiA83Bn3X1xJa9E5
 yjT0dQo7FNWvy+ji3mtZ89lVBj4AzZQiP+HABWz5L4Tz9YI6xtjZlE88aDxB4BrS3xOB
 xECByEmYahxIYpCBVnIelIm1oRAf1sY6tG62EzJ8qwFJPfrhC2cCc7UBCdalxxf9h9L0
 NBwKO47XDGgsv+Mzd4EHRM8QKVZmqVuLIDQlKn3CZKvr8MHkFXJ4IMqLSjdv/Ui/MW7c
 BI/SaAdxlutere/iae3E2u+kv50IvJEIoWf0qJqsndpf2/XrpniYx+wyxLvBF2C1Kfh8
 uFww==
X-Gm-Message-State: ANhLgQ20UmsWk+TADpahZnqMkldmpRbWBlmUQD8k37Z7x8VJnwKYsI/i
 QMfP596Hutl/IkkCVhQ0rP+EhHXcLVV5sgUF38sXaw==
X-Google-Smtp-Source: ADFU+vs0YtRg74B5E9jHD7F79KNxoSFPipGv17ko81HSM2DPJumvbKuqPrQBtLxIJw0otM01XLwFWMpNuHvbZDOdESo=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr2403054oic.48.1583243112867; 
 Tue, 03 Mar 2020 05:45:12 -0800 (PST)
MIME-Version: 1.0
References: <1583230242-14597-1-git-send-email-jasowang@redhat.com>
In-Reply-To: <1583230242-14597-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2020 13:45:01 +0000
Message-ID: <CAFEAcA84-Pmw3L8TikC=t0NssCc=YttJpsLRw+Ay7OeWzJHVoQ@mail.gmail.com>
Subject: Re: [PULL V2 00/23] Net patches
To: Jason Wang <jasowang@redhat.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Mar 2020 at 10:10, Jason Wang <jasowang@redhat.com> wrote:
>
> The following changes since commit e0175b71638cf4398903c0d25f93fe62e0606389:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200228' into staging (2020-02-28 16:39:27 +0000)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 21843dc48e38c27cbddb85b4719000c70a70b6bc:
>
>   l2tpv3: fix RFC number typo in qemu-options.hx (2020-03-03 18:04:47 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

