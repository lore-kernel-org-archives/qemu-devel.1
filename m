Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CCBC4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 09:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12B412070A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 09:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f/oFNrjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B412070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGgDP-0006sl-6X
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 05:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGgCe-0006JN-Ru
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 05:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGgCd-0002dL-Cy
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 05:50:32 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGgCd-0002cx-6u
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 05:50:31 -0400
Received: by mail-ot1-x342.google.com with SMTP id e19so16412973otj.7
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 02:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5VEIpMtipvlbuv1Erzq9tq7G4W0ZFxUarGFy3vKLJqI=;
 b=f/oFNrjdGknlhc581KIPH1PSoOoaujhFIuvucFTaNnzOS/6q/z1pIbY3HbEgM9o5J0
 z3YG2ztLxQBydw+V+vnNN5qltTA0HEKVqcgszJzlMTvSV1Cr2fVWwcsKR5MjuVCeO4yd
 ZNDAhOValw7mveXgznxN501SUT+Tlc4yff2se2b6Ao/NyWNqxd+qHOc6o8qxnaEArLT0
 IAaZacWmlkeFwWnbDS9uSzYLW76Lie03ue90C8sm/F03/deHSK2Puw+0g8tX9yO/dFtg
 0qIX8PIlK4aSW0p+eK5xdcMm0DlwcZTu6f4epoOOgaWcvecRh16MoJBkyBI2qjyo61ww
 SAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5VEIpMtipvlbuv1Erzq9tq7G4W0ZFxUarGFy3vKLJqI=;
 b=hrd9+PS8tfmTt06nsvdzCmPrZTPv8xl1VQDfspKtxfrPwDwEzSjvUP2VsNf0gfNOJH
 em3gKkyZeS4AJ19g5rNln3QfoxKSxG2X9JhR6AqMZHS3R+zEWv5NGRZDBH5niNlukhCX
 NvS8rlnlhS2wpS0X4s7aL1w7BNbGPNM+FRQOPzKhDtnQ9wvq9+0V0U/JXne+3khgoPX1
 Kezz0Y5FWfCJ5PTpPBoTw3lVf5JE/V7VYbjumu2Pk+Of3JbgQJSNIP+BHFxybBqBLHcR
 rXdwkmUjrju6LSecmPA0IFPbuTDa2nkULFIJBuj0eyhjiUWqmbkIgvZotgF8W2Z4h17S
 XXlA==
X-Gm-Message-State: ANhLgQ3uhv4wIeNtO5b5WAFMzCJ4/nMHJMRK3BhbwF2iZLfL7CnqgEvr
 w/gYajJmNlW7K05rTFBpSchTHW91l9C3nftMYcQqOw==
X-Google-Smtp-Source: ADFU+vtwANQauXuJZIRim2g1Tqye+4FikijDRHEEYNsXd5XOqSJKbbuKZ4/HNNZU9x968X9ErqGnwg1jlyWOrC8qgGU=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr20125516ota.221.1585043430418; 
 Tue, 24 Mar 2020 02:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200323192411.325247-1-stefanha@redhat.com>
In-Reply-To: <20200323192411.325247-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2020 09:50:19 +0000
Message-ID: <CAFEAcA_ggRgiHhote35=ttWAi+siZPSWGojA-YdfqWsQZ65gOg@mail.gmail.com>
Subject: Re: [PULL for-5.0 0/1] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Mar 2020 at 19:24, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 29e0855c5af62bbb0b0b6fed792e004dad92ba95:
>
>   Merge remote-tracking branch 'remotes/elmarco/tags/slirp-pull-request' into staging (2020-03-22 21:00:38 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to ff807d559205a434fd37d3343f01a0ab128bd190:
>
>   aio-posix: fix io_uring with external events (2020-03-23 11:05:44 +0000)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------
>
> Stefan Hajnoczi (1):
>   aio-posix: fix io_uring with external events
>
>  util/fdmon-io_uring.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

