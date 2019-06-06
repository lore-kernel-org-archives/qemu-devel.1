Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2522C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 14:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A252C20652
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 14:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r6qQrL+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A252C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32961 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYt25-0000fU-Js
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 10:06:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYt0x-0008UK-Kj
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 10:05:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYt0v-0001IF-J6
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 10:05:11 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYt0t-0000j3-T1
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 10:05:09 -0400
Received: by mail-ot1-x341.google.com with SMTP id d17so2052192oth.5
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 07:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=z1TSuep6MC3GMp5QGERdQF65GkCDphddgb7kjwfjrkE=;
	b=r6qQrL+rJUN0rLwLc7SeAopdn7R7DEI2Sx/AiA2Qle0tWe+fRNKdIcHWxfujOxSJ1y
	G7RliykVU8+zjH9sR2IP+S5CRIlSvuZtSPC8fqfMvSaMSXrFRSkCZnYYVJiRbRyixlhJ
	J94fCcoV5iPVf2ZGwgZ4FAPYT7Ezt67r/m2RooeEPjypik2aJMcsscW1uUUP7Jb7i3dM
	ngzE4hGtRkSngerUTrxE7wGEafOpT1xK0tWAC22CQZcm2j9MANF5MkUtBXsnxTMqeNyW
	fSOR5bfGLwQ/HlscpAjPQ4mED0uKifcipJgx4ljw6MKqfJD/UH6p8/mlS8h0WOAEgLsX
	YPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=z1TSuep6MC3GMp5QGERdQF65GkCDphddgb7kjwfjrkE=;
	b=liF0P6gdX1mASSCRL4f6eFJ5bR4jytALxoYvnFDdB+eIFSNLFV24pcoGT/LTx0UAJu
	Lnc1r7MN/i7GtUdTPkt1TNShlj6Pnzz1K80EGl2dj8lqMVFHksbZKLVGHny5P5BWyXwN
	lYBsYT0ClqQPwVx/n/GuoveOcXAu92NTmqq937m2C3o4r7owrJwmteQlpcLw1IyA+WxC
	ONXAPqr9ciZ6Sx+zRRXwV5UjstJ/OiNR2BpWH7kzghwUX6XGmJU698QaLUq8o6AqvrkY
	RYOEruGdDvKlc2KO4Onmo5GOnlNzCi/OXIz+a7a2dhGJicas0cpfD+adT2CebOpckyhm
	MrWw==
X-Gm-Message-State: APjAAAXmg1IbAaJtSfAcqCwJNO/Y4d2yZA1DyN0thp9XW/Yf0Lp2oWca
	1UMiN3PBg5BvRyKBM5tKLoZerucbl32P67sbT8P2pQ==
X-Google-Smtp-Source: APXvYqyuSP7IdHek/hJkuwNI58fkOX0Rf+yJOE3QI+FMh8L8VpFQDCiwyOSjtX4w8QuZRPy+CLk/TKoBPxwfbmrlTUU=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr15038024otp.91.1559829902787; 
	Thu, 06 Jun 2019 07:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190606110625.32127-1-laurent@vivier.eu>
In-Reply-To: <20190606110625.32127-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Jun 2019 15:04:51 +0100
Message-ID: <CAFEAcA-aPY=6hAzvhkYw3Bz3Mi-iVXyDPNGguYWZXaFWpfdCpQ@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PULL 00/16] Trivial branch patches
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
Cc: Fam Zheng <fam@euphon.net>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	David Hildenbrand <david@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Juan Quintela <quintela@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Yuval Shaia <yuval.shaia@oracle.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Richard Henderson <rth@twiddle.net>,
	=?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
	QEMU Trivial <qemu-trivial@nongnu.org>, Michael Walle <michael@walle.cc>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Jun 2019 at 12:18, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 47fbad45d47af8af784bb12a5719489edcd89b4c:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-06-04 17:22:42 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
>
> for you to fetch changes up to f1114d321246f9177072923e1c2a20e7aab82700:
>
>   hw/watchdog/wdt_i6300esb: Use DEVICE() macro to access DeviceState.qdev (2019-06-06 11:55:04 +0200)
>
> ----------------------------------------------------------------
> Trivial fixes 06/06/2019
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

