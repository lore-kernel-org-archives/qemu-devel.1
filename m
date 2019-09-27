Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B419AC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 15:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E674207E0
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 15:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fskt4+8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E674207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDsZ5-0004G8-5A
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 11:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iDr0R-0005nZ-Ct
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iDr0P-0002iX-1N
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:13:59 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:45317)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iDr0O-0002iN-Rg
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:13:56 -0400
Received: by mail-oi1-x229.google.com with SMTP id o205so5271427oib.12
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 07:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SxuuRQJqmEVqp9TIF6drb9JYM20Amto8QuZ5gXsXbVM=;
 b=Fskt4+8Gq+ogKIqC1fHfwCB1XDFxW/SKr1OYKsGOw90TTovXYAOAKcUM7SyKzZLLx0
 dwK62Zzt/PkBc2s9sET84yl4kDvEVNLq/wAWDQWdi+3bCTsYSQ9R3puGSUGiBJLO/JqU
 Nor7MAy/YUPSeQ6OxxoFy8qMb/BcLgb8Ndh8nTvh//5lef3vlf+p4BCcOm05vOaBF5O9
 kLpniVJRq63OObvVYbo371w2mR5ET4u/hz6MAKFJQot4/Tg64oOwFXqMVO+MttlLtDUc
 VrL7pdLDf/DV9pFIDWpjauhTHYcBe1vVw46GCjuRWqQj8ccZChTNlubg+vdZigEGM7f8
 REmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SxuuRQJqmEVqp9TIF6drb9JYM20Amto8QuZ5gXsXbVM=;
 b=grJh+Yq/GfK+9xZ75k4YH719fy3jvHu3wqfT7Zvjb3Qp+s999sr/fME5Xp7t9Vbxpk
 LHz/FNLx6pCnGBjRiOVgBz+XFmwQDZn3i8LjPBYdzDrZdY6EKHrKnPRb9MLYuxhjysJ1
 NElyTjqmeuE08upGEg2BEKqGrAETH67bebGGWjG7Ct4blLvSWJE0AKs8jYfDbd6Jg8fs
 0/+iKiVKfFKFYWJ8BuY9hFo41r1GVpMy4vtqh8gAS/QqyTX8g7gPzlHJQLYd63CAD/t5
 k2Cv+YPyFyP8ZLxdlLDGvV7QnFdRm7sHmZZe90WgpWITU7WLA9xttnsgc4+7cdwBdk4Y
 K44g==
X-Gm-Message-State: APjAAAXmbJmzf9p9/snFh3m0x15+E+yLotmxGePkq5Zr++CTDzxKg01x
 tNnDNFzXlejkiUJ+Z8FBSLAYdsnwXnQCxm/lGJXGJ5uHNAw=
X-Google-Smtp-Source: APXvYqxGhb2XwMikb+4uqTO5Woy9yBsgsexaf2WpStNxlQNvnqj2M4Vs1apVSxbqgHQFgHRxdIWZnl0UW9yoidt2pWI=
X-Received: by 2002:aca:b48a:: with SMTP id d132mr6569438oif.98.1569579030208; 
 Fri, 27 Sep 2019 03:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190925142910.26529-1-mst@redhat.com>
In-Reply-To: <20190925142910.26529-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Sep 2019 11:10:19 +0100
Message-ID: <CAFEAcA_=DJcN4XSK0z5Q7R-vhhGG0+XxARe3eQMU91BkWPMDOg@mail.gmail.com>
Subject: Re: [PULL 0/3] vhost: fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Sep 2019 at 15:30, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> A very quiet cycle. Did I miss a bunch of patches? if so, let me know.
>
> The following changes since commit 240ab11fb72049d6373cbbec8d788f8e411a00bc:
>
>   Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20190924' into staging (2019-09-24 15:36:31 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 3fc4a64cbaed2ddee4c60ddc06740b320e18ab82:
>
>   vhost: Fix memory region section comparison (2019-09-25 10:16:39 -0400)
>
> ----------------------------------------------------------------
> vhost: fixes
>
> Misc fixes related to memory region handling.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

