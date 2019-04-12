Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A3BC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 11:55:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C229F2171F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 11:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ccAvwGbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C229F2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34769 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEum1-0002iQ-1L
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 07:55:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEukD-0001ls-HZ
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:53:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEukC-0007uY-GR
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:53:21 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:36182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEukB-0007tz-Px
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:53:20 -0400
Received: by mail-oi1-x229.google.com with SMTP id l203so7711565oia.3
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 04:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=knPjMhmQpbuUpLevbQU0h6hy4/mTpsUXZQSfj7TdMQ4=;
	b=ccAvwGbfxBhUM+ZwWr00e+2jydJqMmMuJ8tA41eD/iqqlyeH2u5zjh/SRbw3foS9YN
	to5Xh9e7/1OV4GSllfBEvKUcOJwurSWQDJbXySFham6dOjXeQbK1KuBnH7guRIuHLH7j
	zeoSS99/IanEgCtcu7WCfXDTQ4ijLL0C5tYwzlAKvHNbDuH4yuiYlZkHa7VnI4ye/9z+
	RRgwvKBU2Q++Fyrl91M5UjoVy8k26ihKA/UadoLzvKrTY0iTug+VlljRRM1KvaGoWnQ6
	MxsvwPDualC8jFlrSq8yQ8iDJODjXkr7O/Nxx/zmN/XnMugR5Y34AU7KQdNoHr4p82Cb
	Nhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=knPjMhmQpbuUpLevbQU0h6hy4/mTpsUXZQSfj7TdMQ4=;
	b=qS0xGTP5YyVqIjWm4jvdJ+UYmQwzRX09rA4gBJ/EF6B4/vSc2GEhLxPaEo7NDTMYas
	rTvtzqjma2vBtzGk15x4e8NFhtk2tG+lybTzMKSQMlJzSKMzK2Rc9aXhiMrfist62SX9
	7p1ID/e2Q4Jf0vrkuhPyF8R1Ar4HBOQ5NRtOxcywhS3LSUfi49snks0ogSC12CP/Aj9h
	yJ+iy1y3evlsv4+p2nD1wIEsi7sNC6RG2nLOj8/EV3KAZRSqiuHB4cTgY8Bld8tXKOTy
	Ha2SY+d2j0zyZ57R4DAibGrGIioZxl/fXkMEh3dOQtT8+PrTztwyLq27d63Gzl/5xWFP
	86Yg==
X-Gm-Message-State: APjAAAUaubrvXqdmnPZbOJ4Ex1I0tNJISvi69R66taqNTpTDyPX73uUJ
	YrV8VdBC3kanlIOwHrKS3euAz7eHK8UltXKsdVYCRA==
X-Google-Smtp-Source: APXvYqyEdEm53BzZpw4eoN5ThY3f1EUh6Vx+WCdxHx6Qs7t7yBPx9DWbjxnwzuEYnE33taapBRchJTYMsIr8jdYCCs8=
X-Received: by 2002:aca:e054:: with SMTP id x81mr9577064oig.146.1555069998946; 
	Fri, 12 Apr 2019 04:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190412112044.15361-1-david@gibson.dropbear.id.au>
In-Reply-To: <20190412112044.15361-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Apr 2019 12:53:07 +0100
Message-ID:
 <CAFEAcA8VEM=brDF-U=8-5sEPhmcjX2vPy7tBJuMSqviVXbAetg@mail.gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::229
Subject: Re: [Qemu-devel] [PULL 0/1] ppc-for-4.0 queue 20190412
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
Cc: Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	clg@redhat.com, QEMU Developers <qemu-devel@nongnu.org>,
	Greg Kurz <groug@kaod.org>, Alex Williamson <alex.williamson@redhat.com>,
	spopovyc@redhat.com, qemu-ppc <qemu-ppc@nongnu.org>,
	Marcel Apfelbaum <marcel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412115307.GSVqJgrS0NBI4286DC9nb41KE-fgBDzZcmKf46OTxiQ@z>

On Fri, 12 Apr 2019 at 12:20, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 532cc6da74ec25b5ba6893b5757c977d54582949:
>
>   Update version for v4.0.0-rc3 release (2019-04-10 15:38:59 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20190412
>
> for you to fetch changes up to 4560116e42a21989a4b6cf9551ce2f90b16c7238:
>
>   spapr_pci: Fix broken naming of PCI bus (2019-04-12 12:23:02 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue for 2018-04-12
>
> Here's a last minute pull request for 4.0.  Turns out my last pull
> request, to fix a regression in extended config space access for the
> pseries machine didn't fix things hard enough.  This PR has a single
> patch which improves the fix to work in more cases.
>
> It's a ghastly, ghastly hack, but it's simple and localized.  I
> already have patches almost ready to go in 4.1 that provides a simpler
> and cleaner solution to all this.
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

