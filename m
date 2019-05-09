Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A814DC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:18:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EFFC2177E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N+PBDaA2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EFFC2177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57472 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOlkY-0003NJ-M0
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 12:18:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOljS-0002pl-4d
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOljQ-0007rg-9G
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:17:17 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hOljO-0007jd-HF
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:17:15 -0400
Received: by mail-ot1-x341.google.com with SMTP id l17so2848668otq.1
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 09:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=EYiSbpBNkPdut5F6S4Zv2dFzUESzWjZ9XZknyoTswAE=;
	b=N+PBDaA2IV+nEo+vjWzdsCjJ0fcOBF0Skk2YUpDJZKu93ve0B4JNgaCV1TO7U6d4tr
	Gnw9R2gRi4A/BxXCMetCJvMYnBk3Q+NsqcJb0fQRQOUYapczEPASZXcTEhuFSE8n04Nu
	rhyC6d3AIslnL3CaSOSAXd7vOKOE+Dm49Ll3SPp5Hfjn6Kq08XYZ3j2ReYau7qgTGkCC
	rfbl1mZegYlJvkorNPwP5pMMgviwlD6yZegy0A9paokhL8zkDvg31YqNmojfVi3/iIMw
	vwlID6Gm8/I92M8v50mse5rw9aIbTJaJogZf+GLbhNrqwSmP1tvdu6YCqsmGR8AREaWs
	TjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=EYiSbpBNkPdut5F6S4Zv2dFzUESzWjZ9XZknyoTswAE=;
	b=AIhcmbN0ELwdGfJ8YaJYjaMliabwo6T67hdUYOmp7dSRgHs2+eDPoprLqRaIjP3A2p
	tv8TCGRTwB8F5s4v21DbEEp0NphZhfMMZnfCzcRnI3JdnVP9KvqYRXwWUOncijdNDQln
	0aoPHw2OtdQ8DZ9xcykFfbHLaEwqdQM6ekDVkCMaM2xWX0FC7VLm7uQFtRvlJfx1eixF
	YB1OIWOMh3PGLFl/Jo0RcJS3u8psO2s/RzCbrRHbHK9iZ/qe1EE0nIHuSw5JfmiNW/pR
	P+rbCP4JJFrtc+9ExfSpt6uQ+BST23PIVk0oY05TxcPMlNEVgopJeM7DY2IcPS82i5jR
	WyiA==
X-Gm-Message-State: APjAAAWQRrR0mbpkT7x7DK/rtP/c9K+LbsOiCNdhdPnIOYpm35id3oI4
	KrzoRmJxytWHHkBPjkPKBRwPlGgDKPnIvAbmCNWjyA==
X-Google-Smtp-Source: APXvYqzmNQspmSf8QRyQUCzUlMhR3lbK1AdF3iDPcBo37xdCGV0MQSFrm3u+zBLjMJcHNW/uEcK53/Gi7XdG7ZTWrOs=
X-Received: by 2002:a9d:6855:: with SMTP id c21mr2269667oto.151.1557418632847; 
	Thu, 09 May 2019 09:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190507151819.17401-1-mreitz@redhat.com>
	<CAFEAcA-qq2CTF-K8Ag8AuKRVzp4VbEYHa_rkW=NzUQ5EEt4wKQ@mail.gmail.com>
	<3e1ce4b4-9a1e-eb97-c39e-066e231af28e@redhat.com>
In-Reply-To: <3e1ce4b4-9a1e-eb97-c39e-066e231af28e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 May 2019 17:17:02 +0100
Message-ID: <CAFEAcA_pnx1V0KmTdeRDAUmMABJ7JvWgfsw3waUJz_hHwybw5g@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
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

On Thu, 9 May 2019 at 14:27, Max Reitz <mreitz@redhat.com> wrote:
>
> On 09.05.19 10:49, Peter Maydell wrote:
> > On Tue, 7 May 2019 at 16:18, Max Reitz <mreitz@redhat.com> wrote:
> >>
> >> The following changes since commit 19eb2d4e736dc895f31fbd6b520e514f10cc08e0:
> >>
> >>   Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2019-05-07 10:43:32 +0100)
> >>
> >> are available in the Git repository at:
> >>
> >>   https://git.xanclic.moe/XanClic/qemu.git tags/pull-block-2019-05-07
> >>
> >> for you to fetch changes up to 1278dce7927301bf3d004a40061dbd2c1e0846a8:
> >>
> >>   iotests: Fix iotests 110 and 126 (2019-05-07 17:14:21 +0200)
> >
> > Attempting to fetch from this remote hangs:
> >
> > $ git fetch -v xanclic
> > POST git-upload-pack (gzip 1798 to 966 bytes)
> > POST git-upload-pack (gzip 1798 to 965 bytes)
> > POST git-upload-pack (gzip 2648 to 1393 bytes)
> > POST git-upload-pack (gzip 4248 to 2201 bytes)
> > POST git-upload-pack (gzip 7498 to 3833 bytes)
> > POST git-upload-pack (gzip 13998 to 7092 bytes)
> > POST git-upload-pack (gzip 27648 to 13930 bytes)
> > POST git-upload-pack (gzip 55148 to 27782 bytes)
> > POST git-upload-pack (gzip 108948 to 54371 bytes)
> > POST git-upload-pack (gzip 215798 to 107233 bytes)
> > [no further output]
>
> Hm, that's unfortunate.  It works for me.  (At least now.)
>
> I've pushed the tag to Github:
>
> https://github.com/XanClic/qemu.git tags/pull-block-2019-05-07
>
> I hope that works better.

Yep, that worked fine: I've applied that.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

(Strace says that we seem to successfully connect to
the git.xanclic.moe server and do some talking to it,
but the first time the client issues a "fetch" command
the server never replies and the client is just blocked
in read().)

thanks
-- PMM

