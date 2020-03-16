Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EFBC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:57:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B8920719
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hbvLgK9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B8920719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuvt-0004qw-Sg
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jDuIO-0005eL-F4
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jDuIM-0003kz-CU
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:17:00 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:36229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jDuIK-0003gy-Ii
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:16:56 -0400
Received: by mail-ot1-x334.google.com with SMTP id 39so3445341otu.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PDKfkt/7GNWfIxzYViVpwmsnx9I9g5wa+HyMTwUIL9A=;
 b=hbvLgK9ovh35wFr7fxloKHfSslpOq3wlPLwyTEs+NM+DOfm08wN82XujGINDWHW0Fa
 mJnlvwcIPEU1R82qFzReLXtv7g2youcFguxV3w6ZeZD+0WQ1yh/HYntpKGlO0WnFNcZH
 8iy1Wr4lqaONTx+AZiz7FOm1sQQBsjiz3W1neEGGH4rCmFisYNGorBsbdIDHLXMo2yHW
 NZeY683fBOaNhPjg+8tJTi6d8nx1Ed5WeRWcBeBY1em+Bco6YPHa5yDyqsXNhThN7laX
 oSHjJrIDUp/mOht13+vuo0P563aSmsd+3rpSuCuUHelCusBoHDx/Vel8U9mujyUk3AvM
 v/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PDKfkt/7GNWfIxzYViVpwmsnx9I9g5wa+HyMTwUIL9A=;
 b=NT4JbLWfJhmt84QGuXmeyzC/QuRg0ItrlW3e+um40IA4UeiDWwQntTrN4u3zuYqqcF
 JX6+suG9fBgk4p2bLYeSsGIUT4BxA+JrrJIXhojyFyuMx46Lh3+da9Hj+CPWns0wNtjO
 bm3ClRPevd7VUNgaeaedchxgmYvZsy12UvhQZYpg/yhdy3PAik+PqvDeAY06c/pU+5qi
 kmAVdanigKGbsIVq2y8wCkPoGHVhkA3LAkL5lbpj6HpnZJQAPIYs8S8eCgzSR4QINF6Z
 AwY16uyuZAMHFN12DbSUpHnaHyyaTlkFgxtEV2JdaC0CL1Qdmh+m2RT04zomeGmkv19s
 Er/w==
X-Gm-Message-State: ANhLgQ0iWzAVC0TANEP2fOXDxchbyMfQI3nxdujFijDvhpf5gz7t3fQB
 Q8Wg1VZJ+CDMVDyXeldvzApC3xuW0ZrtgvNZG0vXdg==
X-Google-Smtp-Source: ADFU+vt9MlWkl0700BvRRFfiSW5OY0t76jXROlgdE/BQ9MAYKjjTAoA6w0xHMEC65Ht97Lues+OYHWmYP1yiTUfCX64=
X-Received: by 2002:a9d:19ca:: with SMTP id k68mr456718otk.232.1584382615404; 
 Mon, 16 Mar 2020 11:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200316124820.22063-1-kraxel@redhat.com>
In-Reply-To: <20200316124820.22063-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2020 18:16:44 +0000
Message-ID: <CAFEAcA_BNH3vj0STUN-_BoCUfDczsvn_zLiXx-jqsyJV22K3HA@mail.gmail.com>
Subject: Re: [PULL 0/1] Vga 20200316 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::334
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

On Mon, 16 Mar 2020 at 14:26, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 61c265f0660ee476985808c8aa7915617c44fd53:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20200313a' into staging (2020-03-13 10:33:04 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20200316-pull-request
>
> for you to fetch changes up to f872c76296b991fde4db5fb87a1cfbd8d4c22c88:
>
>   stdvga+bochs-display: add dummy mmio handler (2020-03-16 12:40:47 +0100)
>
> ----------------------------------------------------------------
> vga: stdvga/bochs mmio fix.
>
> ----------------------------------------------------------------
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

