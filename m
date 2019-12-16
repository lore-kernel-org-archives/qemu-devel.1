Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F11C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 13:05:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 220C5206A5
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 13:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ogeAcRT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220C5206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igq3k-0004fj-5P
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 08:05:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igq2q-0003mP-PS
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:04:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igq2p-0002av-FE
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:04:16 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:35098)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igq2p-0002aB-8t
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:04:15 -0500
Received: by mail-oi1-x229.google.com with SMTP id k196so3255461oib.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 05:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uMKqseiC006t/HjZ2lSaXXE9obtOcuALDL6F1SFvtUg=;
 b=ogeAcRT7olln8rp1ALi399Bwtnm7JJtgI5CZ1YJX4pgOcPv8Aihw7U1DuWMUSPsOY/
 0vaKbGtLpFeoBbC+rduuE3Ip7UPv5jIMi12gFvhzhjCC3HQqhy5KI5X0mlGSGED96OFM
 sTftsMJ5K90Yq1o4EUCrmojvrqnyXOOtlkTHSVGykchTaBcpm8wOoeSH3cJNJjYjjHuc
 4BMDhbgANDqfyPqQCvqt8YDwSgRO2UK1COvl4W6OGAqX55PzGPe49XiNlhMxt6LcexwJ
 ICb6qF0r+tg5a3rE57zCGPFUDnHq5UKfcLLgYnQQJLzqp4/JUzyUJEQnM6iliiTTzpBH
 18gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uMKqseiC006t/HjZ2lSaXXE9obtOcuALDL6F1SFvtUg=;
 b=f+xkv1hr8x9cXfcBP3aJAkpQdnxOxm5ssybgWdZwqhqTRJ9s+8j0v0zvuFXKZfnU5v
 0ZPevUIatwHojWnHRmGHdMBEn15004YJARiCw3b2at8Fxic1XOFL1K3L+P05i3NLY3Wy
 RIHMomtATySosE5rUB5K+RZNNhdMxqcsPIrXcohb3Z46+RGuW7/UMmOB5LsViCbRsCd7
 SyzgnBvgKiSgaJ0en2BeBbIbVYWrUnW0vJOZs484L0Q6eu6sqcl1Pv4SFSirdAVhXhaI
 iDwBrAZF8wPHo27Ua5zjZi9IgRClNaFOPTns6UmjwWPs/0JZ65aDbz+x37tvE1xBsBiO
 P/Fw==
X-Gm-Message-State: APjAAAXNsjSrL+CUG3FAPCBC/CGwZvJ1dRAzBdrIWyCtM0TDDyLxN7J7
 8U3imvhEAUlQCB+6wV5s3pFlv5gloPNqAmpweYJDdA==
X-Google-Smtp-Source: APXvYqyWRgXaml40kUPYHnb7mI0E7KzaoY6JYDVaVdsYl0u1PHFodvYQ0igKv9G4tGAPbmQg+kM7b8vokVGaf6JRIY8=
X-Received: by 2002:aca:f5cc:: with SMTP id t195mr9455280oih.163.1576501454241; 
 Mon, 16 Dec 2019 05:04:14 -0800 (PST)
MIME-Version: 1.0
References: <20191214094526.8698-1-cohuck@redhat.com>
In-Reply-To: <20191214094526.8698-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Dec 2019 13:04:03 +0000
Message-ID: <CAFEAcA9mVcFLCUcEQtGw6w-SL-SXvpA--wONm59yLv2=+eRQoA@mail.gmail.com>
Subject: Re: [PULL v2 00/16] first s390x update for 5.0
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::229
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 14 Dec 2019 at 09:45, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit 084a398bf8aa7634738e6c6c0103236ee1b3b72f:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-12-13 18:14:07 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20191214-2
>
> for you to fetch changes up to 5c6096e5656d34f5414834e2e2104646294976fe:
>
>   qga: fence guest-set-time if hwclock not available (2019-12-14 10:25:50 +0100)
>
> ----------------------------------------------------------------
> First s390x update for 5.0:
> - compat machines (also for other architectures)
> - cleanups and fixes in reset handling
> - fence off guest-set-time, as we have no hwclock
> - fix some misuses of the error API
> - further cleanups
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

