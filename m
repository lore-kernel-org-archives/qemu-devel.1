Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6084BC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 08:12:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BAF72078B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 08:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r7zn8nQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BAF72078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJuxN-0000vD-71
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 04:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jJuwg-0000UJ-Ae
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:11:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jJuwe-00014a-7q
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:11:26 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:38233)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jJuwe-00014L-2b
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:11:24 -0400
Received: by mail-ot1-x32f.google.com with SMTP id t28so2537531ott.5
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 01:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Jl03zAfBRyS/zPhFBaUaBjIcAVffVlpYdy56/V1aR6M=;
 b=r7zn8nQB9vQD2yQV3Lx644IVO839l452l91mvRXbRHifGrrmD1h9GPh7xkUOZL/dV3
 wLDVl5e9EIu1GZgDjO0YrGEqRbaVzaOWTxZcRRTPCSxnJuB+8FNbmj/99Q3Pwzzkvzic
 3h3dw4lh18I+OcoUFkFV24oAu0KJ4ynEGJvcJO+B8AVnYK22CEydN/mDcNNtuJFwJ7uj
 Y6RIOiflGUz/GemY6Y3sU9HiT/kdieAB8NX4Nai+wmbPaodGGbZQ4ZTR2gFPe06TgRaP
 kARdhHTwhvRgcn8iJCocQmtLQ/WTx9DFviqRsohp+Yz1tQn0SpqKmoL/RS2yHR8mi4+W
 GOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Jl03zAfBRyS/zPhFBaUaBjIcAVffVlpYdy56/V1aR6M=;
 b=SGazHCT39Q9K8jzNZxbnkp+mH1HNThvGcQM2xwjCvl1SlZLRYtjyESdFNzv3OYAfb6
 bsuwjAhrNOHVFBB2do+RWj3Zh2RX6dYIC8aJncJp03WereUbuinjbTMGPKv5CMubThGS
 5+MzwQXkMFyM9RxV+CawlPkkfrgRTfQ5T+JEHz77J7ilTGOxdcnf48SzEn7u0XXGZrFJ
 VvyJII+A1HOV+ZI/6pj1g1i4IIut6tfSyFrYZ7uxulwpeFc+r1ZuWE/O+DfJVztvqmKm
 SxcIp9cRJAgNyz34YClRvmYTyHaxr39cbT3ljYN4RN96moxmbVVOXr+DEp5z7bTxwNOL
 2rNw==
X-Gm-Message-State: AGi0Pub4m+zOrzv2SDqP1xyBac3JLOnWkxHHiNS26gXTG3aBUlB7PHYx
 YcWFHhqA4evP42YCCvfQgHSmKzS0CCdHEgLyT9p3Tw==
X-Google-Smtp-Source: APiQypLCAv0fjSg5jw2eCj4cXSFHg4J3FqfP1sswQP7lraaxASgiIitouXOVjaitru7sYCFkRPYCgqTNsRzjR44JCVc=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr1346868ota.221.1585815082632; 
 Thu, 02 Apr 2020 01:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <CAFEAcA_b1gZ-B4NaEdQS2zffdvobW=FUx4ysEgXVAz+=cZ+R3Q@mail.gmail.com>
 <87sghmbfgc.fsf@dusky.pond.sub.org>
 <44b5ff2c-6dce-e516-a9cc-9d80354c5a72@virtuozzo.com>
In-Reply-To: <44b5ff2c-6dce-e516-a9cc-9d80354c5a72@virtuozzo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Apr 2020 08:11:11 +0000
Message-ID: <CAFEAcA_cmOkR4YsDmP7mDdKzs0jTu3WDO=d1uvMxHguvZjGW_g@mail.gmail.com>
Subject: Re: Questionable aspects of QEMU Error's design
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32f
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2 Apr 2020 at 07:11, Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
> Somehow, in general, especially with long function names and long parameter lists I prefer
>
> ret = func(..);
> if (ret < 0) {
>      return ret;
> }

Personally I prefer the other approach -- this one has an extra line
in the source and
needs an extra local variable.

> Are you sure that adding a lot of boolean functions is a good idea? I somehow feel better with more usual int functions with -errno on failure.
>
> Bool is a good return value for functions which are boolean by nature: checks, is something correspond to some criteria. But for reporting an error I'd prefer -errno.

When would we want to return an errno? I thought the whole point of the
Error* was that that was where information about the error was returned.
If all your callsites are just going to do "if (ret < 0) { ... } then having
the functions pick an errno value to return is just extra work.

thanks
-- PMM

