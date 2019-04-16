Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1117C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A066217F9
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ysGnhfL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A066217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37084 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGOGb-00011w-U7
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:36:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGOFK-0000IB-Co
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGOFH-00059G-Mt
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:35:34 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGOFF-0004yI-CE
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:35:29 -0400
Received: by mail-ot1-x341.google.com with SMTP id m10so17612093otp.2
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 06:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=rnwyzr+tvsHu90IRxZ/I2Zw63d1wDUjuU1jzBX8YU1k=;
	b=ysGnhfL8khN5AIa/6uyeEo4+W+bN3eksWWg9WKkv5nNHCC/1daGC7r8wvidEugCvoJ
	U4Iyuh6yK4lUi8cWaV8qO3KZIbcA4ILutfFr6tKtD87rsbm+zgeIcoKI0FRPhpjfpNin
	z+LBKECxDUBE2o7oiFvMHK4SnAyJItP6AmaFb7iWpQ61sK+f/K6BnA4Ki1TiLNXWLUou
	Smdh/2uSUAWs0aHGauNZ+ohgdbgplkArCkn1NnKDZT1IciEGuJZut46l/WWX8WeVg5wt
	Y9DBoFVsihLayWGtls8E2WBA8mcJMKzJLS6vnbbZQg0SDrAJPhSIq7t7lCykJYPr19BC
	x5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=rnwyzr+tvsHu90IRxZ/I2Zw63d1wDUjuU1jzBX8YU1k=;
	b=j57TihG0tLFn/EpnrqKjXhTzkNmOMjFqvEm9LriWzpu78lNGvTJEEqx+JpfiHNYRVw
	S09u9Ph3bGe/B+GjQIklNuzj7m+xbSaIGHggfn2QASUs72xwGcMO6iWTyHJLtzhnkvhk
	qEkWCJpQDKGe/OsyYtuO1aErg/ck2ABzuLe8GMUQ4g8zCrsyhZ1Mre3ckUNBxYaFoX7M
	f7zw3vd03Kn5XhKXB5211CH5dO05TRUnOdMu3fMBKEjCkyNytK4c50picpSr0biNNYfx
	0PaX8QqSyTfPv/emHmbsiLv1k2RLXf2+IBzaAx1eB9ulchMyuOw+d5F5oEbRoCd36+tB
	n6tg==
X-Gm-Message-State: APjAAAWT1wN28qjXc0F3RCafAN0oLFyiZ4PCJeuZkNnb/mq7eVvsXV6S
	AvB+Ex8qJZO/VUsxpS4fBmH8ildWGcwrP+B3cG91eg==
X-Google-Smtp-Source: APXvYqz7zWF4eJR4oila4t6IBRXdS/rbpT2nZQJlyUV7aRJZTUja7AJEJS6mrQUgDx9ID6Novtx2f9nlIW0koIl0BQg=
X-Received: by 2002:a9d:3b44:: with SMTP id z62mr53100794otb.319.1555421715653;
	Tue, 16 Apr 2019 06:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190415154503.6758-1-berrange@redhat.com>
In-Reply-To: <20190415154503.6758-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2019 14:35:04 +0100
Message-ID:
 <CAFEAcA-YpG71aGtTVMafShGyd9uM599Uy_8S3vvvnPzfiKMqnw@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 0/3] usb-mtp: fix ObjectInfo request
 handling
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>,
	Bandan Das <bsd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416133504.jDG6wwxUrvHgEE_a_L56otfG6SM_2rDwS5VhU6Zl3F8@z>

On Mon, 15 Apr 2019 at 16:45, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> Two previous attempts to fix this due to GCC 9 highlighting
> unaligned data access. My attempt:
>
>   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg07763.html
>
> And a previous one:
>
>   https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg07923.html
>   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg00162.html
>
> There are a number of bugs in the USB MTP usb_mtp_write_metadata
> method handling the filename character set conversion.
>
> The 2nd patch in this series is a security flaw fix since the
> code was not correctly validating guest provided data length.

Given that we don't seem to be confident in this fix just now,
and this is a read-only buffer overrun in a not-commonly-used
feature that only happens if you explicitly enable write support,
my current thought is that we should not try to put this into 4.0
(but instead treat it as we would a security issue that had
occurred after we released 4.0).

Opinions? Maybe we should just apply patch 2/3 for 4.0 ?

thanks
-- PMM

