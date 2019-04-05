Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6D0C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 03:52:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD05217D7
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 03:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sDLJtFmj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD05217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35548 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCFtb-0006UE-EI
	for qemu-devel@archiver.kernel.org; Thu, 04 Apr 2019 23:52:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hCFsp-0006Dc-N8
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 23:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hCFso-0005G4-FT
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 23:51:15 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:33298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hCFsn-0005E3-V3
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 23:51:14 -0400
Received: by mail-ot1-x329.google.com with SMTP id j10so4441924otq.0
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 20:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=nN9/DL+QbGWqTYdzeLQqa/9gC8F19pFASh5zTbmnMNM=;
	b=sDLJtFmjxryerNukEpLb6YMMs1/pKXU/y2baKcigvyuletvw75irJWxMIM2kF5IZho
	ZBUcUnjcQML7Rl3nC3/X+n+NYfYEYqJNVh9FqYOtg5EJRCQmEvu8ftFnaIO2sBeuB1ug
	R09VUGzK8V5vFutHlMYxHSgDxktYFzvM31LBz6Mjy5jKqeMWsYbA6W22LeoBfBC/VXNN
	/7Fw+BDvyJEnB+OwaTt7Iz7aoBvgizYpZpXEOwvp8yt9pWCv2feZp/ZJ5lFUg6IiPXFW
	FUI6q+DtGQ6dwrNH9maBA93Mb9oP+n+S7WU8i/EilQuYi4xrHPZPPGcrYsr392YsxIfu
	AHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=nN9/DL+QbGWqTYdzeLQqa/9gC8F19pFASh5zTbmnMNM=;
	b=VoqqFUf3d/iZJCaWWP7C5QQv8Cqw2YRsuM74KpnWkMh193rPrSep/Ea+baQ1HL0yZh
	T74xy2Ra+0MxO1o7Aswl9i7O3m0cFp0JNzAaYhZW2+mLUjKQzhUC3udG7nChYMsnm3wU
	kCbHfsLhwRhs7vRyI81o92F+fJtz8v61QMGJi6GuiNP3oyArvLB1bt+whSVhZWhP0mb0
	YGwTnzIUgvSaJp+8T1ucCDKUrI/sF6cJCPnVPcXSjzd9zYQkYKuhYZr22NsdJXbBXYuD
	y/s07Zma4DKGyFauFoqs0qkOWGVMXw+l1mHSY2kAim0k/cpYVQnHI+PCcdqmb3Lz4bJ0
	0d6Q==
X-Gm-Message-State: APjAAAVDu3xQ8+C56gbNPCeEUol4ElGKb9GjU5NNyJRAcdqxpP1bhxFo
	4ZpR+qQssCivdH0VoF2eCm1rc7dxBGiSHOR5TlWDyg==
X-Google-Smtp-Source: APXvYqzScgHIz49bUOuXJyCAb5puXdccw4V1B3P5F3aK2RZqQLugCz4128WM4wdiTlDspWJ+KEG9VQDSmO9RYSsxcTw=
X-Received: by 2002:a05:6830:1cb:: with SMTP id
	r11mr2653433ota.302.1554436272879; 
	Thu, 04 Apr 2019 20:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190404170722.4492-1-anthony.perard@citrix.com>
In-Reply-To: <20190404170722.4492-1-anthony.perard@citrix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Apr 2019 10:51:01 +0700
Message-ID:
 <CAFEAcA8RUYXrFM0vFBh+Om_60g3SW0RZDGC7UT6UQ26mk3uJjQ@mail.gmail.com>
To: Anthony PERARD <anthony.perard@citrix.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::329
Subject: Re: [Qemu-devel] [PULL 0/2] xen queue for 4.0-rc3
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
Cc: "open list:X86" <xen-devel@lists.xenproject.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405035101.fd240VRQvmr2dB9agZB3IQqJkYIGuxUutOD1yxweIT4@z>

On Fri, 5 Apr 2019 at 00:07, Anthony PERARD <anthony.perard@citrix.com> wrote:
>
> The following changes since commit f4b37171378b0b1782570060c3411a504375d1bc:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190403' into staging (2019-04-03 13:13:30 +0100)
>
> are available in the Git repository at:
>
>   https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20190404
>
> for you to fetch changes up to 2bcd05cf24a7de34e7e265247c010977e43f40bc:
>
>   xen-block: scale sector based quantities correctly (2019-04-04 18:00:07 +0100)
>
> ----------------------------------------------------------------
> Xen queue
>
> xen-block fixes
>
> ----------------------------------------------------------------
> Paul Durrant (2):
>       xen-block: only advertize discard to the frontend when it is enabled...
>       xen-block: scale sector based quantities correctly
>
Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

