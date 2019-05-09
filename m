Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96209C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:51:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FF5421479
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JZPyo1Ip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF5421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50858 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOelY-0006Og-Kd
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 04:51:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOekn-0005wa-3g
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:50:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOekl-0003HP-BI
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:50:13 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hOekl-0003H3-3w
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:50:11 -0400
Received: by mail-oi1-x242.google.com with SMTP id j9so1288513oie.10
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 01:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=vZAiKumbf3qAteAfcdHds7O/xwU237BUIkCFBB5vyp0=;
	b=JZPyo1Ip6fSLl6lAMYjXXu4yW3xOADy45vYA34ECMlmmapsU7fqWup5ylSTMP8VUgR
	NnmyDeVrWUGWKP08ynsYe0LT1NCqgMKOZB8WIACpplUJCsjXipANduZ9FJkOppvQ8lRw
	ikirwrNBSwxqAtBWYWOEgzkCR0F+x2UIRJo5lb2ogVWkfJfV3CH5vYY+fpcgPFry2JLR
	oYKMrCNpsRwUcjmzb4UKtBuUBrGvVlSp/bJFdUClmqxjz9UOPldaD6Xoc9pMmYiy74y9
	JBEoUQT4SpTWza2mpl9HGtZkH1yp9ZU93ZP5QAPR74nrEE1coWu9Smp1vfF+TnNFcSdr
	2sPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=vZAiKumbf3qAteAfcdHds7O/xwU237BUIkCFBB5vyp0=;
	b=gEU7Eri+pGRGZx5SJs+fe43mZCTheS40Gqse1XO8R57Qnq1A9fepkEK9kTGtwKtLx5
	a0mECy/ak8gCogA9xBtL5YxybeXtRUf+ZNB6r+Z6CO2P2bUYgaMg24NHbImcLUPgsXzz
	10TRkL6xv4rIrT0b9nuyON2zB22NPtGmS4IcQIHgJSUTv36nIBm39w6hAmrMwfWnV4qo
	HXDbShWXLYkzdoRNyQKKTUVyEvJHf37bQQWOCCKk+paOvHfH2KN0NVUarE66ecihief2
	QZdDGI4a+GIF+FHsbQtcZ7RMlpmCSZJcG92UHj2RWTGnwHCHD3ooeHxr8Wncfw0pnGjd
	cxLA==
X-Gm-Message-State: APjAAAU3nwOYs4Vevin9dzZoRS4/4dOOATcmMZdvHrMnQJM3ovXeN7Nr
	8VHOH3xCvqDA0OmoBkNn6CPj5zfc2icVaV81y2Priw==
X-Google-Smtp-Source: APXvYqxgs+lSufnsymomXLpB3TCV3nDmO90/7wpNUr88k/PK3h0svT/Ap2nIf7TtVSLKlKdTiVg/PegurjOKtC0gAwk=
X-Received: by 2002:aca:110f:: with SMTP id 15mr740042oir.163.1557391810167;
	Thu, 09 May 2019 01:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190507151819.17401-1-mreitz@redhat.com>
In-Reply-To: <20190507151819.17401-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 May 2019 09:49:59 +0100
Message-ID: <CAFEAcA-qq2CTF-K8Ag8AuKRVzp4VbEYHa_rkW=NzUQ5EEt4wKQ@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PULL 00/11] Block patches
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
	Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 May 2019 at 16:18, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit 19eb2d4e736dc895f31fbd6b520e514f10cc08e0:
>
>   Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2019-05-07 10:43:32 +0100)
>
> are available in the Git repository at:
>
>   https://git.xanclic.moe/XanClic/qemu.git tags/pull-block-2019-05-07
>
> for you to fetch changes up to 1278dce7927301bf3d004a40061dbd2c1e0846a8:
>
>   iotests: Fix iotests 110 and 126 (2019-05-07 17:14:21 +0200)

Attempting to fetch from this remote hangs:

$ git fetch -v xanclic
POST git-upload-pack (gzip 1798 to 966 bytes)
POST git-upload-pack (gzip 1798 to 965 bytes)
POST git-upload-pack (gzip 2648 to 1393 bytes)
POST git-upload-pack (gzip 4248 to 2201 bytes)
POST git-upload-pack (gzip 7498 to 3833 bytes)
POST git-upload-pack (gzip 13998 to 7092 bytes)
POST git-upload-pack (gzip 27648 to 13930 bytes)
POST git-upload-pack (gzip 55148 to 27782 bytes)
POST git-upload-pack (gzip 108948 to 54371 bytes)
POST git-upload-pack (gzip 215798 to 107233 bytes)
[no further output]

thanks
-- PMM

