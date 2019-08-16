Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B05DC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 15:44:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB5B5206C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 15:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OhjMipA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5B5206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyeOt-0006ez-W6
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 11:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyeOH-0006Eh-Gu
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 11:43:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyeOF-0004rJ-Qh
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 11:43:45 -0400
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f]:34560)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyeOF-0004r1-Jr
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 11:43:43 -0400
Received: by mail-io1-xd2f.google.com with SMTP id s21so7055342ioa.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hISUx8PJHwJ2iX1azq87dBfcLKnt4BoKvhI2mPMozCg=;
 b=OhjMipA6EUK+G0H7vHjhhzq25eek7QSwXH5+xfFXzTduVBp85LRYDC76XR8Kz+VuPm
 d+IrASwI8TR7NMEvL0VbURx251TC1wx2x+0bAcjNUktUZFf50Y5OR8rheC0lvKq2/eR/
 dS1I9wfMPX45fs4n0qtvq3YHu9CASe8o0yaiGnvw1RtiGytR4ByFM1RAzaOZ4HWBueH5
 SYxcbyyDQkJN7Rc0ik+wfL/O4sXNfT7dPH4uPXAovuSJ88DrE+KW8IpAKdTLdCRWQWzD
 bNiaFVtuZ1cC4NoQpncHccCP74UAC4Eae9skPK54T+oLGWJUDEzQ8dUEmqMs/4dnntQx
 83Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hISUx8PJHwJ2iX1azq87dBfcLKnt4BoKvhI2mPMozCg=;
 b=GGlf9nqEsGFpW1Tg98bzCiidzNa/o6ZrXLZ9ZWNRQHQJ2jo3RSuG48PBhkax6m3F+Y
 +9e+rgFyl2DZ+mO2ynk2OvmaKMbt0Cb/TU7xx5WDFOjxiPNRgVcx2Nd1MYQ52eU927dd
 NlPgcEM3CvMF98rou4nmgxXS3VzhTeQ7m1/rnARY73fojxmqneTRKalnF+UZhTdKYJKM
 rF34v4/Q/3lgv5+dllwfMOedY18rggRObhnCMuasF1Vc9iLNI04hsu9E5ornHeAnFni3
 pPd1D51ejW+C0UhKlP2+HM2iBrkgDZWE6rmKNGNYDVSvzeSu2wuYXb3D45vheu7gTj7n
 c7ew==
X-Gm-Message-State: APjAAAW5OD0B3reZpWWc9TFWhe88CSgEpjHWH9NpxHQfTMSCtLLzfH9O
 dL7fKYeFSUlIvCs1z/mV8FeY9jMcGky4oXgmpTMRzA==
X-Google-Smtp-Source: APXvYqyhk6+tvdyHRZ825h4iQ7+2aDCTV8u+ppVR4h/i1316DlViTQoKD8s+4CD61jK93z9TvKUoKc4vZSYrXrGLBIw=
X-Received: by 2002:a02:81c5:: with SMTP id r5mr7379806jag.143.1565970222701; 
 Fri, 16 Aug 2019 08:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190815183039.4264-1-eblake@redhat.com>
In-Reply-To: <20190815183039.4264-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Aug 2019 16:43:31 +0100
Message-ID: <CAFEAcA8E6WJd6qmfEYF59RckGtEZRK=M8NYWngY3TKTf7=SHKQ@mail.gmail.com>
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d2f
Subject: Re: [Qemu-devel] [PULL 0/9] First batch of 4.2 NBD patches
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

On Thu, 15 Aug 2019 at 19:34, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit 9e06029aea3b2eca1d5261352e695edc1e7d7b8b:
>
>   Update version for v4.1.0 release (2019-08-15 13:03:37 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-08-15
>
> for you to fetch changes up to 8f071c9db506e03abcb1b76ec6d3d2f9488cc3b3:
>
>   block/nbd: refactor nbd connection parameters (2019-08-15 13:22:14 -0500)
>
> ----------------------------------------------------------------
> nbd patches for 2019-08-15
>
> - Addition of InetSocketAddress keep-alive
> - Addition of BDRV_REQ_PREFETCH for more efficient copy-on-read
> - Initial refactoring in preparation of NBD reconnect


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

