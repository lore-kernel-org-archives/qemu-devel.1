Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FCEC2BA1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 18:13:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C42F2076E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 18:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h1Qjq8Ra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C42F2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLsit-00074H-N4
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 14:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLsiJ-0006aE-1M
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 14:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLsiH-0001ap-CV
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 14:12:42 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37938)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLsiH-0001a7-4O
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 14:12:41 -0400
Received: by mail-oi1-x241.google.com with SMTP id w2so2335280oic.5
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 11:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AqOAkVcvrYYi381JuxNTGbV3kibdzgotwZgL2QGBems=;
 b=h1Qjq8Ra65Gcf4SSnuztACu2dIdBhZuZ4uiJabJ7m/zanUFqzrjyjGhLnc/7WuTbbm
 3nrvoT6GR2oG2RHtwayIerXkcX7a68SDJyRTBj4gObIBaU89ZPPeVBXuoaAcQGdN+h3o
 +noi3mVvhY1OKFnd/znv4L6vLeu3ORyk29VsC12wv61qU1YlwRS3N939lIsMJiMMn8Xw
 f9Kvbq0FvSdBk3t+kYHlHif8Unqy4iaDKt3vW4QR0TgNuiVBfxl0uWX48wobYHsQrDBS
 867R2SAGAMFxtzWNSVAMqZflfwCFrBHtbrehcQWCBe/jDFj72CFGA0UEhcfYgEIPxEZ9
 1hIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AqOAkVcvrYYi381JuxNTGbV3kibdzgotwZgL2QGBems=;
 b=aAwUi+GAJVadNOQTcS2VE7qVfOV2Eq4e6XIyXIZeseZwvS/1tFiitPbktXrgY3qkPK
 V666hF9Vy8z2C/YT+tZniJdk9TIW/Zhh7g7VOz7NvoRD+prG/zgp6X0FSREW2G4o60qh
 47lJ3kVFtvVHxbMOlGiK6dq0a1jNFcdAX1c5uIxSR514fqOefqgBinivcUv8UcMm+X55
 Ko41CLTpKyAJ8y36th1e1VuE5RHkM/RIc8652JK5M/l8Xv3wxJHc/06Oc6Fhow9KTxuQ
 0yY2QB6ag4sWicTvyHESV85oVJjrjJQ7RtAROL8O+Or7EAev/neZaTrS9c0E9oF+ERv/
 RqhQ==
X-Gm-Message-State: AGi0PuZxHBM6x66zTDxbcKfKThvTxQBzUHNB18y4bVqzIEjzUBTe4LN3
 aIXMiemlGN0vxZ97gWizhoAI0ZBhLEukV7VG0nLicQ==
X-Google-Smtp-Source: APiQypKDOtcCC5fh4nGVF62ebZbL0ZwH9RIlcOyFCfbZjHyMHPgBWa1FdWMKvlx7Rj/KwC5KzVCBSZd4rUt4b3oS7B8=
X-Received: by 2002:aca:3049:: with SMTP id w70mr89266oiw.146.1586283159635;
 Tue, 07 Apr 2020 11:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200407123727.829933-1-mreitz@redhat.com>
In-Reply-To: <20200407123727.829933-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Apr 2020 19:12:28 +0100
Message-ID: <CAFEAcA-+URvyP0urU52TJBafuAecuPOOtAKuD4y2_8izA3XA_Q@mail.gmail.com>
Subject: Re: [PULL 0/5] Block patches for 5.0-rc2
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Apr 2020 at 13:37, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit 53ef8a92eb04ee19640f5aad3bff36cd4a36c250:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200406' into staging (2020-04-06 12:36:45 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2020-04-07
>
> for you to fetch changes up to 36d883ba0de8a281072ded2b51e0a711fd002139:
>
>   xen-block: Fix double qlist remove and request leak (2020-04-07 13:51:09 +0200)
>
> ----------------------------------------------------------------
> Block patches for 5.0-rc2:
> - Fix double QLIST_REMOVE() and potential request object leak in
>   xen-block
> - Prevent a potential assertion failure in qcow2's code for compressed
>   clusters by rejecting invalid (unaligned) requests with -EIO
> - Prevent discards on qcow2 v2 images from making backing data reappear
> - Make qemu-img convert report I/O error locations by byte offsets
>   consistently
> - Fix for potential I/O test errors (accidental globbing due to missing
>   quotes)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

