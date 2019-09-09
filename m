Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A36C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 14:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97A92086D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 14:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sVMuMOFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97A92086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7KuT-0007nX-Rw
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 10:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7Ktm-0007N3-0E
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:44:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7Kti-0007Iq-SR
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:44:09 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:34989)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7Kti-0007IG-Mw
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:44:06 -0400
Received: by mail-oi1-x22a.google.com with SMTP id a127so10738586oii.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 07:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FIwsmVLe9kqCO1EhUbzldD2pC0SeM4D5KLjRT7BOcm8=;
 b=sVMuMOFsfF/0NRqKgdO8go13fVLfuLbg2I6fD78fD+5wlpmg3vOZnL/lQSKBVF+G5s
 +PV+TdQ6gh0bj68Ti3/qya2n+Hon1bdfY8OWm88FMT+113XvGeXSXCOFLnDgu2xWnD4z
 yxDQzfbkbHltyUNfza0AyxDgQFE/HSwI6m4Mu58OB+54aBQ4BFsBXei66BKAXLf0GXJ4
 o2SJGooCDxJjwcll7mBcarAAitlg7L1G98ibXyGoc6M/y9qbpzItPCAJl+iHJSmO6K/L
 heE/6/+HzO7p9JmL16Qr8TEvAHxyPS4zq0WIulVYWJ3WdEsxiPV5SdN/6Vh3RvGHKg7n
 1FgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FIwsmVLe9kqCO1EhUbzldD2pC0SeM4D5KLjRT7BOcm8=;
 b=R8ZHdUdUe582hSUClVrdnJmDi8Fux97PA/Qwf6X81ippkNE6qg9Xp/evXfDve+iRcA
 BfuwguoHUJvDp7Yyfp6YqzqK9m4sEsUXHtZOakE/9zCfP40OvI/EUduI7YN7gIQ6YFhI
 X2DZ0UV8cZpNQLEDXRLWvROx9fAiqo434WIWJOmqD/rnsXqkamhZNXPrWRSroUWH3qvi
 LUS+i0CdE3jHXmBDWGIDg2PLl0mDy6Jsr0BYFwIudnSRHTYYDOI82/fvWalGkrkyWYUl
 Rxnu72EaixWJ2iGuCPvs8puJlTf1y9c4BO8OJolPeQnHPPtRjAtnvt3dsr1EbC9RbQOy
 sPcQ==
X-Gm-Message-State: APjAAAWIM0OF/SxHqQevB0D62zLZ6N9EUrUO7RmMxZYEPIpeUkxZhX66
 GIMmAXtF1Z1bJPF5RWpnlNAF/Y7G8vu9Nn8eCG7wIw==
X-Google-Smtp-Source: APXvYqx92GC1mM5QQxEcfphlaU5PzW/C0d6OO6Vah1kzUy2zT5qraRlFpdX3T0ls0CjfzuNDtcUyS012GMqyLHw6ihQ=
X-Received: by 2002:aca:4814:: with SMTP id v20mr17596704oia.98.1568040245542; 
 Mon, 09 Sep 2019 07:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190907154744.4136-1-huth@tuxfamily.org>
In-Reply-To: <20190907154744.4136-1-huth@tuxfamily.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Sep 2019 15:43:53 +0100
Message-ID: <CAFEAcA8OsP4ycbYSdw6GvgQVMbY2e0nKJ_73KSUpG_T4Gu7ShA@mail.gmail.com>
To: Thomas Huth <huth@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
Subject: Re: [Qemu-devel] [PULL 0/8] Add the m68k next-cube machine
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

On Sat, 7 Sep 2019 at 16:47, Thomas Huth <huth@tuxfamily.org> wrote:
>
>  Hi Peter,
>
> the following changes since commit 90b1e3afd33226b6078fec6d77a18373712a975c:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-09-05-v2' into staging (2019-09-05 17:09:13 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/m68k-pull-2019-09-07
>
> for you to fetch changes up to 25311649592f5584b1e1012d69c7327ef87473f4:
>
>   .travis.yml: Let the avocado job run the NeXTcube tests (2019-09-07 08:35:41 +0200)
>
> ----------------------------------------------------------------
> Add the m68k next-cube machine
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

