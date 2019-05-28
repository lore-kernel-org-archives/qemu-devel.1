Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4772C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 14:03:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 619572133F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 14:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZLabAtrp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619572133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35559 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVchS-0007dx-FD
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 10:03:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hVcgV-0007LM-6s
	for qemu-devel@nongnu.org; Tue, 28 May 2019 10:02:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hVcgU-0000cr-6v
	for qemu-devel@nongnu.org; Tue, 28 May 2019 10:02:35 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:43954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hVcgT-0000c7-Tv
	for qemu-devel@nongnu.org; Tue, 28 May 2019 10:02:34 -0400
Received: by mail-oi1-x233.google.com with SMTP id t187so14316164oie.10
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 07:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=BkD1BppHJ6aldBcq3NqTdWzbJC7PFyhCnjTyf202jmA=;
	b=ZLabAtrpyIUmGmqxPcQclhL9pyQXLhc+penO+ZxD63Db7uWSE3hC2YsMOd1FuoP63r
	kgiAb7ZcYeEKpw1FROBNkYB+aOWkSPffRIrnSyaxCZMQtPNRdKPl6KwJjrf+Bkjg5tS3
	cmLFCF5pzIW3FVBSvOh1+wvSmPfjhSaXcWKoROPYhqvEI7SE9BBpTmtcNoWSnfjqcL90
	NgM8odjHa8kLuBtssrvV2S1H9P+rRv0FEV9izP41kTGWjRfOvLxud19ZOhmy/VESbHfb
	0q0qaNq92BFL5fAo981nYrx2As/TZ3ywdTZvdhNqbTEbe2qisHJEzxX0RJUe7OzxPQR8
	EI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=BkD1BppHJ6aldBcq3NqTdWzbJC7PFyhCnjTyf202jmA=;
	b=HO62Udxhh14BiyEONmZtFQew1ZClqvSiZMbuEtmT2naS2sS8QqdRDhUG+orQwKXScS
	Gj4wM2eRl+GkZaxvzCBEkDJlAd5QzUkHUn1xTG7OEi/SZ75TBWLFvwj4xFgx1GZl+0iu
	+DqLWWKzBODy33QrgLzCp9qWMKNQvHAd5oemCjxHBLQ5wUKCkP+pJ0CKHG6H3mX98QmW
	L7zBG2dHelKHRURlboIX9cBYhsdbonfugtLocL+Cr+YV8utNB4aKlXUcxXIzJLStYvBi
	Xen9AE12nbJh4xvz+YF7umarjgVYrskxJevGU+cLSTJQ7mVfxOUwLukwfPc+PW/Atn33
	Koxw==
X-Gm-Message-State: APjAAAUkSE0yUmPEGSmuSeOyVDpu6iEgcJZyqg7qZjamdBgcIxMF7p+N
	Gwjhb6e015GQkp0dkVUIeth7VLJrS8X6q38Urb3TlA==
X-Google-Smtp-Source: APXvYqzGH8GmEwa/TxA73sK9ukdrs9VYBNNGTYDNx+wkDbR4xdbErXkEzOVfkhSnPI2hBRVdkcbLfTpSplQJAM8L/6o=
X-Received: by 2002:aca:845:: with SMTP id 66mr2726853oii.163.1559052152520;
	Tue, 28 May 2019 07:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190528094953.14898-1-alex.bennee@linaro.org>
	<CAFEAcA-Cbot1POVcbAzXhaLqNJpi6M_0z18=YoB7vyqY3PekUg@mail.gmail.com>
	<878suqsnb1.fsf@zen.linaroharston>
In-Reply-To: <878suqsnb1.fsf@zen.linaroharston>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2019 15:02:21 +0100
Message-ID: <CAFEAcA-6Wh00+TG7r3Oeh_+Mn4Vcj0RdTjRL3sAQHtEeUm0mEw@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::233
Subject: Re: [Qemu-devel] [PULL 00/28] testing/next (system tests, docker,
 iotests)
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

On Tue, 28 May 2019 at 14:47, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Sounds like we should include the sanitizer build in our normal setup.
> We currently only do:
>
>   ./configure ${CONFIG} --extra-cflags=3D"-g3 -O0 -fsanitize=3Dthread
>   -fuse-ld=3Dgold"
>
> with gcc-7. What are the clang configure runes you are using?

I use
'../../configure' '--cc=3Dclang' '--cxx=3Dclang++' '--enable-gtk'
'--extra-cflags=3D-fsanitize=3Dundefined  -fno-sanitize=3Dshift-base
-Werror'

(which we document at https://wiki.qemu.org/Testing#clang_UBSan)

thanks
-- PMM

