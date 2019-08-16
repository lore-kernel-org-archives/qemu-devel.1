Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E9FC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 16:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C86EB2063F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 16:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pqZVFhOO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86EB2063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyf01-0006Dt-M5
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 12:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyez0-0005HK-CG
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 12:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyeyz-0000We-7z
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 12:21:42 -0400
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a]:33650)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyeyz-0000Vg-1w
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 12:21:41 -0400
Received: by mail-io1-xd2a.google.com with SMTP id z3so7297232iog.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 09:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FBLqP/c+EJnhsrl5zfgclVZ9AhpUVOI3N+IBdnsQQV8=;
 b=pqZVFhOO6Ym7IuqFt28VRfQ5uqjc1TJfMGu6T9fHJG1JjTsaAKQjvsSj5ujGEzHdxy
 y0dWs8FzHI8t6D3c8Om7061tVKlEttpxzpu6HemZeuumHsm6oyaKKgZKj94AGf4F2mZq
 GIIJBnVvzq0uNvQndaDt6kmMohG73xWQeKk7hDQf/K5jKyylid0fYM87banKaVrx1TwD
 rCYBc0aY464UmsctCAOrSNyBb3dEYHR0Dc5AhjgDLIxZRl1kEGrIlrbsNhnPt6VZsAYs
 ikK+mHUUyHn6361aT1bcLoxcVAbHIrMO3PiSTpzpmsjutQWvq8f5d2PssYyvgDTgvpR5
 1ITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FBLqP/c+EJnhsrl5zfgclVZ9AhpUVOI3N+IBdnsQQV8=;
 b=iqkXsAnVDCxCaluI0BitMQhizvZYFETo+5GOVw2w2jS42QgvSGYloI5PyXbramJzMI
 Jm2sTNtl3kbMAoib9kGtV4NLWmlDlHxy2juD54QkeCmh7C0z9gKHqL6V/Cd66ivIwVUf
 h0gmHxdr95aNb0YENA+efhe9HooAdKuvRUaD1Cj7HfEP9T7YfT+NNaaeZWMipbaKi1n5
 oOwlcZZW10yDvMcfXCFzxQUSehurM/EyHl8m8QinNAPlu+UPtZz4isjRIgMgTrUzcnls
 CFjyaE2kZwsJwxWL+rJOjVOPNORqtd5go6vtT6+ULeSa8klP4Clo2+3GryASd+5D0s49
 QNnA==
X-Gm-Message-State: APjAAAWfvXR4Mr7qzU5Ig6QfcARHE1kqHTyaOMwIuhhjUZsMWU/WCniA
 Ipg4uuJTweUemsIIBskdG7sclOqTvRhlP8t9kUYfyA==
X-Google-Smtp-Source: APXvYqyWRWmYzzDnWtU1zzj8rqi84/IhAUiLktIsUI6a41TUZVAG3jnvRp/XQjj9B3yWC7GxkX5aQSJCRwExe3pgMuY=
X-Received: by 2002:a5d:934c:: with SMTP id i12mr12662550ioo.203.1565972499891; 
 Fri, 16 Aug 2019 09:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190816093439.14262-1-kwolf@redhat.com>
In-Reply-To: <20190816093439.14262-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Aug 2019 17:21:28 +0100
Message-ID: <CAFEAcA92MsfJ6Rwj-Ww12iZ0xCkEMTV8C4ZP9MhaPS1iQH8WuA@mail.gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d2a
Subject: Re: [Qemu-devel] [PULL 00/16] Block layer patches
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 16 Aug 2019 at 10:36, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 9e06029aea3b2eca1d5261352e695edc1e7d7b8b:
>
>   Update version for v4.1.0 release (2019-08-15 13:03:37 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to a6b257a08e3d72219f03e461a52152672fec0612:
>
>   file-posix: Handle undetectable alignment (2019-08-16 11:29:11 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - file-posix: Fix O_DIRECT alignment detection
> - Fixes for concurrent block jobs
> - block-backend: Queue requests while drained (fix IDE vs. job crashes)
> - qemu-img convert: Deprecate using -n and -o together
> - iotests: Migration tests with filter nodes
> - iotests: More media change tests
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

