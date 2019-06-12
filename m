Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E87DC31E48
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 10:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3227721744
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 10:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e4+u+rso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3227721744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58648 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb0fr-00089g-EF
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 06:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57124)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hb0fE-0007hR-MZ
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hb0fD-00006b-QR
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:39:32 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43358)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hb0fD-00006K-Da
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:39:31 -0400
Received: by mail-oi1-x242.google.com with SMTP id w79so11291307oif.10
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 03:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7VihWj3nXHi0hPVYFFfJc9tO9RV3X9T33CJbxCiEgLY=;
 b=e4+u+rsoOj69ZZdm0KUyH2TlZZzYwXfBb9U+dqrax+h4/ulrV0A838sTNtAH71z9+r
 0jV2ghc8chCZF4n4HkC4PPbTJ3NZAQBeGU8BW61ZQZ4hJ/+yhmPR32pYfDYg/7VW6uHA
 LJIqkVAhkxOK1Hm+fgID9x095UgmC4rXVCGytw/XAe+zg7IJKeO+bDCaJQ1Iwekkzirl
 qgCU27CetxYqoOgXkxRItUN2J8FxczwxR3mbRp07lPi8P6FYcbSO8qWul0ZHaT4X0Co/
 HX9AmxH4NBvXzGQb1G1dri74E1YEiB4vx1rv9+8xPKZUzlU25YxzBRiuR+H4kMYsyRZk
 80Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7VihWj3nXHi0hPVYFFfJc9tO9RV3X9T33CJbxCiEgLY=;
 b=MGYIkZbz62g9M2d3MvH6J8/uypSKVhi/gY6nEQE2BAtH8QI7m0MG26n7VEn98Pz4yw
 d4SubrZzuh3R76F7XAG71WJm427h98gKqHdMfIx+NGskAj7ZnZrHPPxGU8cbmZvIvcdQ
 qRN7QUYeDEewgRcuy9N1fN/5I9VN3sgivQ7yAPeJVtkg8QGUQ84mGkTIlb4+x9TCBe7R
 7y0bQglHBTh78ydsYyPwwgOBaDauEHyvUNrQ/ndvI7dE5RfFLkQEzXwF8Lx+D3F+1DMJ
 WCLnoTvchXfhhl0RhilqDXwbc/UCdgBSZW61v74omtvhK/yMvfG2uILOg63rKVghxgSH
 rG5g==
X-Gm-Message-State: APjAAAX/JLEgsT68AXUnvl/oRt0yL5irr3f5RXe/OrmHs/jWYJu5xSq1
 ZRFIvNvurAV2KqZ51U1yPIvg1NulcnYiRinNCv+bug==
X-Google-Smtp-Source: APXvYqzXw+YVNLnJ9c4T4hCzh+dNYKCHlg/Oi5QC/Br8kjO+UYp8cD3o+6sU7ZaGLSfexjauRJy9RAUldlN3ev2a1lI=
X-Received: by 2002:aca:845:: with SMTP id 66mr16954986oii.163.1560335970097; 
 Wed, 12 Jun 2019 03:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <B3540B0C-9A71-4733-8109-11B0DC7A17D2@me.com>
In-Reply-To: <B3540B0C-9A71-4733-8109-11B0DC7A17D2@me.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Jun 2019 11:39:18 +0100
Message-ID: <CAFEAcA_=A3w490ey9_EyO7gJ1PRjs4L+aRtNPGzx-L7XyGVmZg@mail.gmail.com>
To: Chen Zhang <tgfbeta@me.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH 0/2] ui/cocoa: Fix input device issues on
 Mojave
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 4 Jun 2019 at 10:34, Chen Zhang <tgfbeta@me.com> wrote:
>
> The following patches fixed issues of absolute and relative input devices
> on macOS Mojave.
>
> Chen Zhang (2):
>   ui/cocoa: Fix absolute input device grabbing issue on Mojave
>   ui/cocoa: Fix mouse grabbing in fullscreen mode for relative input
>     device
>
>  ui/cocoa.m | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 3 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
I'll apply these to master some time this week.

thanks
-- PMM

