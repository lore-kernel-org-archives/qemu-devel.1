Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A95AC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 20:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB89D21850
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 20:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D5oZj2Rp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB89D21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiliq-00029o-0Q
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 16:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57766)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hili9-0001aN-QC
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 16:18:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hili8-0005PP-OD
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 16:18:37 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40993)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hili8-0005Ok-12
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 16:18:36 -0400
Received: by mail-oi1-x243.google.com with SMTP id g7so3130999oia.8
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 13:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LvM746Y19s6CurbJgqhXfubnkwm3+ptwVPex/6iJwT4=;
 b=D5oZj2RpwgwsiO2Jrs9NRvHyjHBSfK6xnpGgMqLVdAccfEpIkS/xP+nWOaKDBWvHgf
 wMbs3gAQP6OK6crgGvMRlF2KadS6BmohvRkvEJIwy8ZrPJxg9kgYZ8KMKGFTQuLd9DK/
 tT1KJtSrONoxbAppxaJEuwkwsk9YcZuKe5jJUGbp7AzyiAzbmqiKhXAE/A+afAoQKaLu
 yID3+I9R+t9kDkoZp099rSW3Wjnj/X7BuNti5WUvW9j22+A9tYN0xVlFtr+lOM3WuB5B
 wz/pnKv/qWz0KuqCrj+VQ1DqsdpVI/2UOXeWZabyeyH62r6w1NfK4OJeEUclNJR47BNx
 MYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LvM746Y19s6CurbJgqhXfubnkwm3+ptwVPex/6iJwT4=;
 b=JlbYwK+DzBBKYM0BYi7KnnTjDXKVL1xyuJHNyxNDyEHHAXrnklf8Cm3MNmwY8C/lPG
 yfaW59R2iGMdm8EAhEeO8TaIuYp6oyUaHAgicSIaTDw0w5AzFInY6QiPGUZ3/SF/DJ+A
 +HcMD2KHSflv4w18wWsVm4q5CvrjVBR+DhQRqwA9jENKF/GZEAcAZd4pt537FrVfzB2Z
 GUEl209AMf3aNLxb3T9+qAjIr5x5eSSeqn5dKXh+yjq59bPgjBQgqG6ujHbpY6aTL5ZR
 R2h5ljwFrbVH3kyM+y9/ciLqGUOUEXXi5mTvoMRlGVH3nTNpDznTa+GI1sMvdLdPlOu5
 Bykw==
X-Gm-Message-State: APjAAAXBXsNNdPrc0kJUEKBSTfKJmqiW8VljBxcqV4D7m6K1glqwWrq2
 6lK8vKKYzUlbbwVdkvzS1Zo7kurBBnEvcnbMJaMDZA==
X-Google-Smtp-Source: APXvYqx2hmbcd8b0kWoGjSSddIXCPkNaI4f/yxYce8YCe2fNKeQmd7Ou8P/o4No2dvKDsRhrPmbf070iyhl9PK9K2T8=
X-Received: by 2002:a05:6808:8c2:: with SMTP id k2mr204766oij.98.1562185114470; 
 Wed, 03 Jul 2019 13:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190702150545.1872-1-laurent@vivier.eu>
In-Reply-To: <20190702150545.1872-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Jul 2019 21:18:23 +0100
Message-ID: <CAFEAcA-9QeBABa6vuHqrkDDW1-4G_tGNAgJV4i+tLjtOK61Ojw@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PULL 0/6] Linux user for 4.1 patches
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jul 2019 at 16:29, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 7d0e02405fc02a181319b1ab8681d2f72246b7c6:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull-request' into staging (2019-07-01 17:40:32 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-4.1-pull-request
>
> for you to fetch changes up to 01154f792d254ae60a8a7ed6b363f1ed9a511204:
>
>   linux-user: move QEMU_IFLA_BR_MULTI_BOOLOPT to the good function (2019-07-02 16:56:46 +0200)
>
> ----------------------------------------------------------------
> Add statx
> Fix netlink with IFLA_BR_MULTI_BOOLOPT
> Fix mips (EXCP_FPE, struct flock)
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

