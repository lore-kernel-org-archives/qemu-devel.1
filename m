Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666F2C04E87
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 14:49:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA362173C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 14:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l8CnzkuX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA362173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49717 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hReB3-0006pN-FH
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 10:49:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRe81-0004px-8b
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRe80-0002yD-3J
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:46:33 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:45191)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hRe7z-0002x4-RT
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:46:32 -0400
Received: by mail-oi1-x229.google.com with SMTP id w144so5301178oie.12
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 07:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=XzzDWYDFaGbP/OBD76c2PpVm4hLOFCcvU4BRCXdFaGo=;
	b=l8CnzkuXdOv6hafvX5PbqJW/UgbgdE4HEyLycU/I1FJxtf4iSn5/AEQvelET3lCBu7
	qhMZEuiTDKsh3Hghr7/ieUe02HtyM+fsWDPypK7/765K7bO1AUXVVXmJcU+9Mhi2vOqk
	G0g4BflMD5jI5hij5vUt05kMya+2h6oMKtRtxK2eWjXbniibaq0JC2LC5fH8G/jcOISu
	qOdMfCXMh8MN3iNJ/sZwQHkAkGNpymtdJzloi57zVlN0A7TFF+9iP3iy0TmSBWhkTso9
	mRXUEeyWv66A9zG3P5BG2/meQpNWX6/z1RSlFQdxXEAc1V21hTw/3l2g/WlTA2VkCaNX
	wcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=XzzDWYDFaGbP/OBD76c2PpVm4hLOFCcvU4BRCXdFaGo=;
	b=NVpf+61B7H0wwcpLabEIHaD1nZrLlTGWpIisnLIen1LGX10wlbJYJCjcT1ORXK9K5T
	+UTXkgZS1T7jnryPO7/tBO/cBS3E9YiflHYzbXnHDVF6eUQQpcQI7BhprOjfgFqr/Fz6
	89dNCxHULH89tpDw56LxozXs9PmGDJKJpK1P+/6DKfFqq0ryYTxKLRy1x8MoQLG3B5BA
	GZugXe5LJcS6KMqxjnBZqtKBfjSj75Yoemw3r0G9naxLoU8Fq2uCzErjOJYzU5w3cddz
	QzISDq22aUbBvgr7pGYhvatgxafz1H9c4Z0s457qCZUKpH6Ily6x4OOQ28RbDLnDbefV
	ki6g==
X-Gm-Message-State: APjAAAUmkSp6vR0T3fuTUnjerCWTsifcsQBvEnVjzdHUcVyvmDCBJvOZ
	TO6/t7vIqhpNiADrExqJaX5arUo1EDM+vXKU0RkGCQ==
X-Google-Smtp-Source: APXvYqwMMl8HOC8TdD8lIIDH8bObcqV6KlwzFl6fmUddHOoj3FwOJ6uGUfeaVDBzBNfdnM45WsDk0NHNZp3FIEBOLBk=
X-Received: by 2002:aca:845:: with SMTP id 66mr14583777oii.163.1558104389705; 
	Fri, 17 May 2019 07:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <1558084017-15947-1-git-send-email-jasowang@redhat.com>
In-Reply-To: <1558084017-15947-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 May 2019 15:46:18 +0100
Message-ID: <CAFEAcA-v8QL29VYjxupx1ms2Wz7dGNSyXFeBKWHrgRa3jgDW2Q@mail.gmail.com>
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::229
Subject: Re: [Qemu-devel] [PULL 0/4] Net patches
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 May 2019 at 10:07, Jason Wang <jasowang@redhat.com> wrote:
>
> The following changes since commit d8276573da58e8ce78dab8c46dd660efd664bcb7:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190510' into staging (2019-05-16 13:15:08 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 78e4f446d2569210a8558946b2321f9ff2ef47f6:
>
>   net/colo-compare.c: Fix a crash in COLO Primary. (2019-05-17 17:00:12 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

