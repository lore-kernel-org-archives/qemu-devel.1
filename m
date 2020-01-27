Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253FCC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7472205F4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SDdY27Fa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7472205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw4sL-0002iW-6S
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 08:56:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iw4qk-00016Z-SG
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iw4qi-0000n5-Ru
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:54:46 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:39611)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iw4qh-0000jY-3T
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:54:44 -0500
Received: by mail-oi1-x235.google.com with SMTP id z2so6682977oih.6
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 05:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VylWfE9WBHpsqhajyNqdvNW75/Yv0GEEhT0rjOBAwZM=;
 b=SDdY27FauDfu/G/0+3u12JrGQgOe30htgYRYmKhtGJeHARUXWzt+ivunhXSJ2spiGT
 8TQyTOyoF/rFpSTb8NLCqFhpFjuxUodBZVKlgi+WFyhwZar684aYj2DKKkNjeHTK1JXH
 +st54Y/AEgCSgpPtzN5VPD20Zn3S7DIQQhYL6lj91CQt4RGwGerXnfMnjWmbZQ4/fBbU
 JYDGsupetmT16Gpgi4DOt3xafq/nx2zH9xXm2bHs9gI7oWaMTmCvbC7CXFxg5eKzRcFt
 po7eeaNSom0cTtAbZlFu1PD+zrVGVFtzUpFaa4Jzfm/v7quYTT7SBVG8BmN73GPJ699E
 n77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VylWfE9WBHpsqhajyNqdvNW75/Yv0GEEhT0rjOBAwZM=;
 b=UKQiBa60KY7xW1z6e5j2vxEApLgEKG0U9gYEhC44GZaav49goxEtlOqqZp4pNfnzna
 2Flzkmg7JWhay0+15UaXR8mxYLN73PU4T6LmD7J0j4SVHnbh2D3kL8sTvJRXd+LW7ZoX
 8BKCPpIHnWDsN2eWmIF0GTDqESU8vSkWzw9Aq0KNmXlsjF+/iIhkiuIvYdrcvimlRu0X
 rhAkyzo4XuEatJ2t/bXqeJxHUAWpTlvptfsJrV7rPGhCVL1/e2YHf8uD+G97+IiZPcE1
 on2JemQYMgASk/3Zx34mN1Vu4QUbD+jfkLW6BWbeew3Zz8cxfte8boZgM1HjKzABGgym
 L8cg==
X-Gm-Message-State: APjAAAU6pqJWRCFxh5BSe04xwJxtjYBiqj6coL1mR062AUi89gSDNLAv
 3Bs6C1++J9DVrI9HAOWiBLaWmXLGv8yhHuPhlHRadg==
X-Google-Smtp-Source: APXvYqyS8R+CHGkRTWU+J6Cz22w1v0V+S+NewefwL+LMbJmguPvViTyZHgZH07FSU1ddjFuSfmBP+uRLP/U8PBfOjKU=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr5389685oie.146.1580133280829; 
 Mon, 27 Jan 2020 05:54:40 -0800 (PST)
MIME-Version: 1.0
References: <20200127122016.18752-1-cohuck@redhat.com>
In-Reply-To: <20200127122016.18752-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2020 13:54:29 +0000
Message-ID: <CAFEAcA9kWM2=-Z6=BPtcmWGT7OVaB4hpJXtcKKUaerkTtsdX4g@mail.gmail.com>
Subject: Re: [PULL 00/15] s390x update
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::235
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

On Mon, 27 Jan 2020 at 12:20, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit 760df0d121a836dcbf3726b80b820115aef21b30:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2020-01-27 09:44:04 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20200127
>
> for you to fetch changes up to 4103500e2fa934a6995e4cedab37423e606715bf:
>
>   s390x: sigp: Fix sense running reporting (2020-01-27 12:13:10 +0100)
>
> ----------------------------------------------------------------
> s390x changes:
> - kvm: re-enable adapter interrupt suppression (AIS)
> - fixes and cleanups


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

