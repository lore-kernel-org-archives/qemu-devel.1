Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4818CC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:11:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFABB2084D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GR/JsaDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFABB2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS5Ab-0005Xt-85
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 15:11:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iS59z-00056A-2Q
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:10:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iS59x-0005C2-PW
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:10:38 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:46441)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iS59x-0005As-K7
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:10:37 -0500
Received: by mail-ot1-x32b.google.com with SMTP id n23so8519843otr.13
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 12:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=I8WQx4uItqFP36AEY7U3/TDYnoQFsCnIgSI5X3VjnXo=;
 b=GR/JsaDk+PRX5MolG7Jn+W37xYd3C603nMAFJ+op+9awheHkO3jPmUhc3wjxb3uB6a
 CZv7IbtYO+3l0sc/AgcwD+1EVDuDBvHjn8eS5Iz/hF4wuQSWGryGfDB5ww7JxQWTYZy3
 YclRh1XRXBvedB1FHUyJHa5SzX/GpUSMFNdigp6Y81UQdEp9D+SdyB4nAfhb4JjN3xGz
 EoyDc70hTgdVuntRGdwoLx1OYhLm5EiVdeTZJm5lwFWjFByE5FOqh//xCV6Me3daexLz
 DAn2jheu07RhLiff0lwU/iABTndr2sL1cCuVNBZf2fHXowEUFMG4LkFATWh9Leqs7XM9
 UsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I8WQx4uItqFP36AEY7U3/TDYnoQFsCnIgSI5X3VjnXo=;
 b=nCXyLK+jKF3zD9Qfcp9hWEA2VtXULkFTrC+vnPBCW3tDIb6iBPn3v4Mb5GQi9dz/jg
 SFkjUKtMzJWeD9kiHeiVTFSZj5ZhiyIYCdbcnwUu6JGIs9Kt4dzp17boV0nm1Od+Y5Zh
 lUYjkDQ1/2dHzw8dKZ40BIoqkEYEtpis9hLvYFLnlxpQgSXPEuFDEChRPMOkjDeWTcq9
 umof+b6MlFcB7h8DJf9exbwhHt0bt8icie1hHXXYukkIYGHw7oR8C7NAot9HTz3Ve9iA
 bAQG/61IrRM24ODsBngcSj0pHfBZafp41vP1ZgxwMp/tU6D7GSYC1fBOIfat1jxeZbt1
 oqCg==
X-Gm-Message-State: APjAAAWtvNmNfSp0s1WQ2jOTnoK7x186DP2SAcKicLjYJ6tDxjv7b8mz
 1J0E7Y0SohRpkIj2rd3j94V6UCCS8g3stQV6KvPgdg==
X-Google-Smtp-Source: APXvYqzFUP/UuQ0mUpmzdnWnTLM5l7gbZW9t4z99M8Xhc+MVx8p4iFADNqCE4eY5wQ06mSd2pHPB5eylHB2tP7vYJ7o=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr11043519otg.232.1572984634480; 
 Tue, 05 Nov 2019 12:10:34 -0800 (PST)
MIME-Version: 1.0
References: <20191025203427.20181-1-ehabkost@redhat.com>
 <CAFEAcA-F0iB2vzi3Z0J9FPAt6JpuMh+V0wsfXWLuAGX5_d69xw@mail.gmail.com>
 <20191105195748.GG3812@habkost.net>
In-Reply-To: <20191105195748.GG3812@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Nov 2019 20:10:26 +0000
Message-ID: <CAFEAcA-r7AcexfKGyPhdbxgS78U2j=XuwYwWk=BRx6HixdEA7w@mail.gmail.com>
Subject: Re: [PULL 0/1] Require Python >= 3.5 to build QEMU
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 5 Nov 2019 at 19:57, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Fixing tests/vm/netbsd is being tricky.  It looks like the
> configure patch will have to wait until after QEMU 4.2.0.  :(

I think that makes sense at this point in the release cycle, yes.

> > Have you tried a test run with Travis/etc/etc to check that none of
> > those CI configs need updating to have python3 available ?
>
> I have tested this pull request on Shippable, and I will take a
> look at Travis.  I'd appreciate help from the CI system
> maintainers (CCed) for the rest, as I don't have accounts in all
> our CI systems.
>
> Do we expect maintainers to test their pull requests in all CI
> systems listed at the QEMU wiki[1]?  Do we have an official list
> of CI systems that you consider to be pull request blockers?

No, I don't in general expect people to test on all these CI
systems. I ask in this specific case because trying to
move to python-3-only seems like a change that's quite
likely to break the CI setups unless we've already checked
that all their configs will be pulling in a python 3 already.

thanks
-- PMM

