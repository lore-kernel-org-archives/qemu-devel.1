Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B03FC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:35:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5789920868
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZY+sCij4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5789920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53952 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU9Px-0002HJ-Bu
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 08:35:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hU9Ix-0005FM-Lu
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:28:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hU9Iw-0004Z3-Hq
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:28:11 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hU9Iw-0004Y4-8f
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:28:10 -0400
Received: by mail-ot1-x342.google.com with SMTP id i2so8491730otr.9
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 05:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=oYG3G3zKJhKZGnq1Fd96u5Jz7fS1RV6tteo5KMiE2yM=;
	b=ZY+sCij4jrUhaDyV6j286EIF3EThxgzOZkf8pAb6iQrdhKkf0/Uwj55medZqqBwu8f
	QMCivrDUgJggTzt3TqJ6Upmb9v4O50xn4yXBW0I3PvQruqH4JlQ7+DGP/e6bbzT0+mIp
	gstD42R72tGUrbkA+dIrV2ec1GCY340LcrPvBlXAGuSwjYPnBSNinzBkwtoHjfST8lTe
	g2XLC+DofRUYHHtwJWP/I113972RtbTQ+GZJLtK7BjReEfmJAo3Dl5JVXrUkWox2YdE2
	q9O8vIXlanh+WFBRNngtBPf21qoyS3nhKn41KKIojZwChkCiW2ZzkiuKqTgrh6KzjtRL
	Kupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=oYG3G3zKJhKZGnq1Fd96u5Jz7fS1RV6tteo5KMiE2yM=;
	b=bAla6xGKuhcA9JQGTzMgUiVjCBl5t/FoKrNRJrTcRq7RqezVjijlPyZiXYk6Py2vr2
	nR1oHd3XxdvUg1FYXuCWpVufpol0qRGwZM+J0fngg4r9ssPSTdOAIPt/MUCA3PfLA5Zf
	R9qPXTcnTXmdtzfoTMmxlYE0T1V0fjF1h6j9AgwpYbaXETCETsAqcDcq+6iDaB0N1I++
	wmoo0GJTmqKPlwqdf9HEh4ib4Hrj3AzGswHKw6fLU6cNfkPN6ORERcntgPbEjWxN1ggq
	v0iiogIZfi8u4v1pjOOotdK91umwUgNwhpACihOg+4FyhhC+JUA/Zhg5rRd1HdxZey9h
	9lDw==
X-Gm-Message-State: APjAAAWkr7k9PIaDhVpoRqcMxO1akxA/1cKMZKKldvc0Ke/pXs5RT5uo
	/ZLyH0FPgV6Sv8SBfOPDvEHWB5HSxKNjOPNzzcWVkg==
X-Google-Smtp-Source: APXvYqwvdrdxHqUUbSIGLw3X3YK6garVPWrcajiaVrvc9AO4TW2tECVBGteREONFWZyQEvj2Bqm7WJw3Knntgx8ZGLo=
X-Received: by 2002:a9d:77d5:: with SMTP id w21mr141571otl.97.1558700888540;
	Fri, 24 May 2019 05:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190524112520.17684-1-laurent@vivier.eu>
In-Reply-To: <20190524112520.17684-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 May 2019 13:27:57 +0100
Message-ID: <CAFEAcA-jcSyqCWLvXo7du7D+NNrRc8Hga33mi3O3cwFCOS812w@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PULL v2 0/9] Linux user for 4.1 patches
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>, Riku Voipio <riku.voipio@iki.fi>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 May 2019 at 12:36, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit a4f667b6714916683408b983cfe0a615a725775f:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190521-3' into staging (2019-05-21 16:30:13 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-4.1-pull-request
>
> for you to fetch changes up to 5f992db605e2c9ed0c8816c2b0f68b9bc8698f1b:
>
>   linux-user: Pass through nanosecond timestamp components for stat syscalls (2019-05-24 13:16:21 +0200)
>
> ----------------------------------------------------------------
> Add /proc/hardware and /proc/cpuinfo,
> update SIOCXXX ioctls,
> fix shmat emulation,
> add nanoseconds in stat,
> init field fp_abi on mips
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

