Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EC8C282DD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 11:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AB2B207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 11:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m/vuxYs2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB2B207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44912 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haIwe-0000CV-Hq
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 07:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52534)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haIuF-00086P-BQ
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 07:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haIuE-0005Rh-5I
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 07:56:07 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:37825)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haIuD-0005R7-W4
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 07:56:06 -0400
Received: by mail-ot1-x32c.google.com with SMTP id r10so8007829otd.4
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 04:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B2ZvFslU2139wq5nE2rhUuIhKjbTs0B6Y+VtJ3XSYpc=;
 b=m/vuxYs20pKe2CCNJpVbQ5euQlcuB7416S7LAwyh0Cc9ddE+muVqM4rQ3QAypvwJx2
 dnjqF3dLHLRRXt9u2/WGC8Z03XIFFrLKYE9Pf4um7Ig6D828IHIwwQDHGxd8XtFkYakV
 banWnGiq7Tp/AJxeGF2Jgle3HJIQ8FU2PgyT+s0qtproCmrLOSfXe+dAeOD1I8rjwtSL
 miZTF3K7dgnOhXEfVqSkA29HE2EiNVXRHGvFGEX2RLvv5m6F63ghZ2wBVDCUfr1vyugk
 /yRL/XyTbYGygln9AuQnRZVLKc4vG5tDBcb3D0kaUAUcF3V1h/q0fEUNJ7wFKe9FTsEK
 At1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B2ZvFslU2139wq5nE2rhUuIhKjbTs0B6Y+VtJ3XSYpc=;
 b=ewEp5uaIxzEU9gxgHHjQwRpK8dVnLAzQRMkCW/3Ea5HgoTdTEzlCtgCupqs3zPQeRi
 EVOPJiy3GeXOODNimw2PLXvbG/bvhrENufipGwzpTYPp4doOdldQL79p42fH2P3Z4ko5
 qcobugGfnAN3H4ZvBIGj1aCdeJ0GGb9zVAZgSNpUN4IVDR0LgX0yqi5lNH7+6akvdkAe
 2njbA7YR7roWf67olIHGKm6m7JAfnqLdBE/8XqXfAtg2QZ7OB0r3dYojLB+K0UmbzuUL
 ln0H7rx0noh/T/n6poNFUZsDhZpkdiwBrQz0ZVMxfq1vdzYBBwQ5vXWyT3Fr1dkYMVFD
 mKQA==
X-Gm-Message-State: APjAAAXUtKuzhYQGMqh1q/QTe1ebNMbsBS6ADBYlepdbn2U1z7fl88jv
 fINZIKzjtRIn2hzKkhxQTR53nEZlnY8G8cvraX6Vsg==
X-Google-Smtp-Source: APXvYqxDvEBmBLsJyMFnT4+lvWi0a/EcJMV7mZ/dMkZc03erTvx+z7+3rjVI066LjADDky2x8w+IxN9Q4fXYQjrYgek=
X-Received: by 2002:a9d:193:: with SMTP id e19mr29627656ote.135.1560167764802; 
 Mon, 10 Jun 2019 04:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190607165650.8801-1-kraxel@redhat.com>
In-Reply-To: <20190607165650.8801-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jun 2019 12:55:54 +0100
Message-ID: <CAFEAcA_N8bU97TqguVpyOLMpMKuUXCYn3k+mqUFMX+s+=bQpag@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
Subject: Re: [Qemu-devel] [PULL 0/1] Usb 20190607 patches
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

On Fri, 7 Jun 2019 at 20:14, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 442bac16a6cd708a9f87adb0a263f9d833f03ed5:
>
>   usb-tablet: fix serial compat property (2019-05-29 07:10:02 +0200)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20190607-pull-request
>
> for you to fetch changes up to e39b8a66d2af913e873256aa77ea71a179dfe5e0:
>
>   usb-mtp: refactor the flow of usb_mtp_write_data (2019-06-07 18:56:14 +0200)
>
> ----------------------------------------------------------------
> usb-mtp: refactor the flow of usb_mtp_write_data
>
> ----------------------------------------------------------------
>
> Bandan Das (1):
>   usb-mtp: refactor the flow of usb_mtp_write_data
>
>  hw/usb/dev-mtp.c | 57 +++++++++++++++++++++++++-----------------------
>  1 file changed, 30 insertions(+), 27 deletions(-)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

