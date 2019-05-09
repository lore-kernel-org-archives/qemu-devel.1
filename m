Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A134C04AB2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:45:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01A5B205C9
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AzZxuqm5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A5B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54827 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOjN0-0006y9-0i
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 09:45:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOjLw-0006Tw-9w
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOjLv-0007L1-Fc
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:44:52 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hOjLv-0007KE-8G
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:44:51 -0400
Received: by mail-ot1-x343.google.com with SMTP id i8so2288113oth.10
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 06:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=c17oWCPPEjIf+WJ3tuJKFifgtRacKgfUXo1uNtqBcBI=;
	b=AzZxuqm5Il+pCPG3K8/shSzh2RRCP23pp2sL+t/yx8KVTPhQNduX9qYIKk18xq27m8
	Th/DzgrQ6M0UIY/vYHJSoP1CY93dDXrNDWx0fbfWYZhq4wIjKmmG+9Gmz25CHnY4YDvI
	0cDz7K79Uvs9EZ+qURAu6iY2wPXErEpBi2WII1x3ME6/NeTe+OHMvNsQNV+adhhXKCSz
	DGcBZtG2BTaskOsjiWRPET4RY1reUqSBG9T1PFOgIiPQ624iIldz2vbUmZc+ohy1aS9Z
	7O0Px/5qGOaukFa/Y4+ofnVaWRm3fE3h9wfzmDSLilrJY0kAENRakk5e9xjkyZrvF9gq
	yOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=c17oWCPPEjIf+WJ3tuJKFifgtRacKgfUXo1uNtqBcBI=;
	b=LFdwb1wPfwfehMp72ebAR2tAOz8mgoNsG6alfmT8BE81fLGWDhepFu60XGtpycqXVb
	L7NuFnJy9nAUcpSwH41pyzQIZxBbGUp3PeIRIbA7LAyvtEHQCsMtGKvqbDgkLidXH1J/
	qtdLc5p0XVZc//O4JT9YT1dyVlay2lxodBcfkZKrkBGMmtQzFS6P0Ktaf1tqRoTAN9s7
	+epslB7Z+R5lcBswKn30so6WexWKwBL5jljAxiiPqU0Eb4rv8XG/1U03gEI9XaFgWXfG
	6mGedJEXZf7nLlgwzBs9cyBc/hkQ8PHJeZbSk34ZXD1eeNW/Cg9BtUkEXDdV6AVGXegz
	Myyg==
X-Gm-Message-State: APjAAAVqMhF8EfBw0R4NYVySOna+2NZBvXfchM1ukR6NsfdhjmUlGGWu
	3Wm1GWHU1lsHPF1Fy7oDVFLJbRdoLpDIlmhAXer9vw==
X-Google-Smtp-Source: APXvYqyKMNXjCVC99LnE6O+OzozgG8lXPooH7CJ75VSVKYCO3wqlZTkz7z4acMC2rZDzxJK3Nis4y2zcoq6lRXRpCfo=
X-Received: by 2002:a9d:6855:: with SMTP id c21mr1696631oto.151.1557409490463; 
	Thu, 09 May 2019 06:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190504120528.6389-1-pbonzini@redhat.com>
	<877eb4c3jm.fsf@zen.linaroharston>
In-Reply-To: <877eb4c3jm.fsf@zen.linaroharston>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 May 2019 14:44:39 +0100
Message-ID: <CAFEAcA_+baJCxf1vQMJJP2cwzZ3snyHNJTWWgUqo26vUPKfszQ@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 0/9] Assembly coroutine backend and x86 CET
 support
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
Cc: Cornelia Huck <cohuck@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 5 May 2019 at 16:41, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
>
> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > *** BLURB HERE ***
>
> I assume there was going to be a bit more background here?

Mmm, could we have the rationale, please ?

thanks
-- PMM

