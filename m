Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F02C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 17:48:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B71D0217F9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 17:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YsUTG0vc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71D0217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40387 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVgCe-00075t-Ul
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 13:48:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hVgB3-0006JO-PI
	for qemu-devel@nongnu.org; Tue, 28 May 2019 13:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hVgB2-0001tF-Na
	for qemu-devel@nongnu.org; Tue, 28 May 2019 13:46:21 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:37919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hVgB2-0001sY-Gl
	for qemu-devel@nongnu.org; Tue, 28 May 2019 13:46:20 -0400
Received: by mail-oi1-x234.google.com with SMTP id u199so14950054oie.5
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 10:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=liYhb8tsIs/g7JYn6SYJ2VKz2MYnn+w4/Bk6A+wKyvo=;
	b=YsUTG0vcKWZ6EJ4Gj3uu/FnW1XX5eJz4lH7xWdHWE9RsDA18ETLh4mRm4b4efCPRwX
	/LBPWu07pcYA4VuMPCqVzmieBxLshF/aQoFDzA5VZE6BSDMErRra1Vpytgk3T59eMeIB
	xotBIIYZlAfScM130bZ0TG0jSOJpkiDVoeZMrymrdWX8ItKetjZbWxluoRTNT4J/I4Yd
	phnwoOZMqmThp6SnOihp8bM8asNaViHwYwVF4ketPutiNw8GRc3SouogP6/A8QWj4sFl
	o4rU4jB2I3WNZhNv0XqmGdR8v39C4cwg0boGfXFHoWtfDT9wMFiVEI3P6mWjDgMAiyt6
	ZIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=liYhb8tsIs/g7JYn6SYJ2VKz2MYnn+w4/Bk6A+wKyvo=;
	b=bvybmzGnei8tCITIGxzKcOknOXHcD6ovhns7gfey/FK6BybqO/Nb0td0H9zbUulUTU
	t6WsK3XPXx0zgW51D86BGheS+CyiJVseoR2LXkJ7zYF0x4Wp2AGlE6PyAAPKLqg128n9
	ZhpyTReHJVXuxokyEfAnkVP1QM2wiE8NYOpBv0fpboi1bj9GxyD+XPrmSlcFRTzMiqVg
	ygaWAdHwMbKY1pN6asSkP9Iy9F0MP3ymYoIV2uJVbeQRh1YUxXbjzyPn0KJYXie+vo6U
	1uBLRH68famK+9iI6XAgC8MjcNunUNBXuv+y8HYLHV5HhjtFh3tkUH5T954DHkBYP9QS
	UGrA==
X-Gm-Message-State: APjAAAVzZRDB2P5/rN7CxetsiYEvoWX6L5OLTOTGde6kWs8yrt6IyLOy
	bblddOH+55P0PA1G9EbZpyNwA4obxlp8KFDr9pEfrw==
X-Google-Smtp-Source: APXvYqwRha6FfCsKfp2Y3vK+CfrZphz8uem1icEBcX6ww4NsTWE15jYNKKJ+dZkvE5Qj2a1N7Hlr8jP5CQFkX6OIZgs=
X-Received: by 2002:aca:b1c1:: with SMTP id a184mr3521666oif.98.1559065579343; 
	Tue, 28 May 2019 10:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190528162810.30244-1-alex.bennee@linaro.org>
In-Reply-To: <20190528162810.30244-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2019 18:46:08 +0100
Message-ID: <CAFEAcA-fCVPEdbdumUM4-iia6jszcepC=MeLq5jirA-Wp4vByQ@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::234
Subject: Re: [Qemu-devel] [PULL v2 00/27] testing/next (system tests, docker,
 some iotests)
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

On Tue, 28 May 2019 at 17:28, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit a7b21f6762a2d6ec08106d8a7ccb1182991452=
3f:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.1-p=
ull-request' into staging (2019-05-24 12:47:49 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-next-280519-2
>
> for you to fetch changes up to 70ff5b07fcdd378180ad2d5cc0b0d5e67e7ef325:
>
>   tests/qemu-iotests: re-format output to for make check-block (2019-05-2=
8 10:28:51 +0100)
>
> ----------------------------------------------------------------
> Various testing updates
>
>   - semihosting re-factor (used in system tests)
>   - aarch64 and alpha system tests
>   - editorconfig tweak for .S
>   - some docker image updates
>   - iotests clean-up (without make check inclusion)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

