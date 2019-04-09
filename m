Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2722C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:29:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA64A206B7
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hbpjwrkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA64A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44115 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDsgv-0000nI-1Q
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 11:29:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDsfg-0008Ng-Jt
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDsfd-0001L7-VN
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:28:24 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDsfc-0001AS-Q2
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:28:21 -0400
Received: by mail-oi1-x243.google.com with SMTP id y84so13859576oia.12
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 08:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=JTZ649fAskZCWH4BCMR+J9fxk61NLvC0J/SWv1w2srk=;
	b=hbpjwrkLL/wPU9S0OxdcY6QcDBu3qFUf9lBxPpdDKN5Ls/XCkb6B/kqhGaKTF77rMp
	/H6HIa5IhEp7TIwC49z4X4ih1qtZ4e28Ozy997semcC/GkgrAMH2pUIByebMu61Sf+an
	x1OZmBTTGMLsJ8DSVJao/xPoobtJ6ydt297jSSwA8PGeGCRPFpzA4BEqRsFOUaNwa2l+
	fXoF1XoWZq5wTWbofMyndXSYH93E9K6N9M0XCCU3hHkJLr0HBwDgL0BYgVEBSpHhd4TU
	2HDREKiynKCVNjFOXTcdD/oifTTQrOh+wpma63nIzGaiXXJh+dYEkadhlThj0+X7gGn5
	tmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=JTZ649fAskZCWH4BCMR+J9fxk61NLvC0J/SWv1w2srk=;
	b=fQsYqNZiuk7YrL3jYWzV5Hcmbo031MBmM1wcg4YTDNcv0Kba/orVYivW2KtxajF2it
	uekNrgyHzXo0fYwE0j1UaOwHtOnruXL42QsrGGQt+wGkoqgZaNCyblqBCUtt15OVKp+/
	prsBzixknN87/xKFd4lrj9i5gb0dBwq7e2ze6RzepY78jT/kU6OG5wCFBFCcc7aX2c9k
	doeaBDtbi8FyEc67oPze09SLRXswEn4NEJPp+lBpPbLCpm5mtCXnjDVUsr/vAjT/gkNV
	EK1L8Mw5Xs5A0cRyvGdYi0M72rhrYhgL5OLyJ3AiKWlsa4KSDcDe5U//KdgoyLt6VUKx
	nEJw==
X-Gm-Message-State: APjAAAVOgMJJcEq/lxkhRN6XMgIe5Ary6xZequXLVs9BkrP11ZYvMU+b
	yTCY1b6OlwVQBFq26ovU/ul2bdh2FAkMbjgtzNcRyg==
X-Google-Smtp-Source: APXvYqxgFv7+4B3zLxyp7C4Jp0/1rjxtatXaHMnf9aujCWTcTmABfOZg+hqE26jx3TJUfevnqCYI1l2wPvgmTKUQK9k=
X-Received: by 2002:aca:e84c:: with SMTP id f73mr20100876oih.163.1554823690637;
	Tue, 09 Apr 2019 08:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190409134536.15548-1-philmd@redhat.com>
	<CAFEAcA9pc3Dw_X5b74+av0qq5hM7wB4uixSuh_TLwHAm8eGsqA@mail.gmail.com>
	<e89332f2-1673-5192-6ad1-b4ade1b458eb@redhat.com>
In-Reply-To: <e89332f2-1673-5192-6ad1-b4ade1b458eb@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 16:27:59 +0100
Message-ID:
 <CAFEAcA8xexPWoBdQDYy8SsOD+OfoMSh=yHC-11DOcN5jp6888g@mail.gmail.com>
To: Laszlo Ersek <lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3 0/2] roms: Avoid iPXE/EDK2
 EFIROM variable clash, pass CFLAGS to EDK2 build tools
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
Cc: Olaf Hering <olaf@aepfle.de>, "Michael S . Tsirkin" <mst@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409152759.yq0fi8N7F9oGE9T_-NJ5xC5vqn943V4-oj3wtbmyQF4@z>

On Tue, 9 Apr 2019 at 16:25, Laszlo Ersek <lersek@redhat.com> wrote:
>
> On 04/09/19 16:00, Peter Maydell wrote:
> > Thanks. This is one of a handful of remaining bugs we
> > should fix for 4.0, so I would ideally like to get this
> > in rc3 today (or tomorrow if we have to slip rc3 a day).
> > If people wanting to review this series could do so
> > promptly I'd definitely appreciate it.
>
> I hope I was quick enough.

Yep, thanks. (I knew you'd had comments on v1 so I was
assuming you'd want to review v2.)

thanks
-- PMM

