Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863EDC282DA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 12:28:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EE2F2084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 12:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i1qh11DR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE2F2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40312 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDprK-0002Mn-I5
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 08:28:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDpqV-00021O-Kw
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 08:27:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDpqU-0004nX-GW
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 08:27:23 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDpqU-0004nG-9o
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 08:27:22 -0400
Received: by mail-oi1-x243.google.com with SMTP id v84so13360623oif.4
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 05:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=dwE79ye8uVtJGMHzH+nv0bGwNiTE3Kh0W2+dE1aZQJM=;
	b=i1qh11DRI5jj37iRzlRykULxKhNabIuvkVQi7EgVy+JWFaU3rOudk17L8prWyRyINw
	ywykP66Bg16AHedEbcvnbnO76aJjC0rAMo0wKT4MVSgN5UyKF1bUzju70GpRMocKbKnV
	TgpjjrQN/SCh+BUsI2uNr/8hEbRantM8ZXn7fFH2Fq5eqoYS/9kHES1TWOMpJESLRazj
	88nxjCcNDey9ZvA3kl3igUZYH5eKsflxJOBwDIWza9pp5f2LyQ0qbAAcVAOwo7fDLIVe
	ia+VjMBHZe/yNGxOJzYYdRPYT8mrIXZSyBRYT+kSLMtkASSlxEVJbYOlfJZ+suuLqzIy
	IJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=dwE79ye8uVtJGMHzH+nv0bGwNiTE3Kh0W2+dE1aZQJM=;
	b=G4dzYjduBPo/QbF7y/dRSH2psQjouNU3Q9J3UZ2TO+PLV4KD3xqU8GbMDS0ZE+rCFh
	RED6jEUtcwiorE6arm0vact+iXUAosSFJiJvx9RGDFOrswnS4sI2VEo5kdoGMvD9SBx6
	WE4Hzl5fjq0rQSxRwTn6Jkqxy19ghqG7k37L3D46U372Sn0eIGHryEyKLmiyKYbfmcmy
	N3AWoIYgf605sIc1TzUmtDNXPB+ImWWyohph9StWwo4eFCz1W6OgUZ/KYOleJugsYegr
	TKCjtolmDkvxAn5FLWfN8uYjF/mL0eShO3VSa8ANVLl022IOiyPTg4uDJbwYawWntQar
	A/0g==
X-Gm-Message-State: APjAAAUlA7FEZNeIVt+SOqsIVS2/9uAYZiqx2tt3IId/wiwHg96YH2L+
	yIi5vu0ZLQ3lryOJ7Da3qb1ZgF6tAZMpARNVvXJzUw==
X-Google-Smtp-Source: APXvYqyGaAsOiQ8qMW6sNbH73DnZRpG54N1pQptqptLpf2SnPvnVtSI7peXSqA+YJj5fa/6gQiPN9kyUrRY/AKn2P8U=
X-Received: by 2002:aca:e84c:: with SMTP id f73mr19466968oih.163.1554812841469;
	Tue, 09 Apr 2019 05:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190409070830.22430-1-david@gibson.dropbear.id.au>
In-Reply-To: <20190409070830.22430-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 13:27:10 +0100
Message-ID:
 <CAFEAcA-NnK6gm6H9bNKxopjFHbigebr9XRCFR+4=OOEgGLkjfg@mail.gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PULL 0/2] ppc-for-4.0 queue 20190409
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
Message-ID: <20190409122710.UMKh12vid86XZlPls2fqWfLzJ6pvs3OXF0mAZkxGzs0@z>

On Tue, 9 Apr 2019 at 08:08, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 5263724b78f89cdea2354c8e92c53bac1b4641a3:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-04-08 17:53:18 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20190409
>
> for you to fetch changes up to 5cf0d326a0fec9ebac2d47c42b5f08e6bc2f686c:
>
>   spapr_pci: Fix extended config space accesses (2019-04-09 15:03:10 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2019-04-09
>
> This is a small, hard freeze, pull request which fixes a regression on
> the pseries machine handling of PCI-E extended config space accesses.
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

