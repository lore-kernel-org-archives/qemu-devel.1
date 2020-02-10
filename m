Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1178C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 11:02:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC6F920733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 11:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JEbrGRE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC6F920733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j16q9-0004Fx-Up
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 06:02:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j16pG-0003Kh-4g
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j16pE-00086A-Rk
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:02:01 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:38997)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j16pE-00084s-MQ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:02:00 -0500
Received: by mail-ot1-x32c.google.com with SMTP id 77so5869585oty.6
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 03:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ivVJaBVvGDqf6sjfWVzYQDCxtvGXZVbjmdYpdniNsuU=;
 b=JEbrGRE/OK4TFb2ZPVdbjep8GHIlLOyPJfNcptrDfSJixXxuXdMgE3o2wTP+r+kE+n
 gOxF/hWFhL5PINV1ZXnJ1Mo0hNBWOIL7tOBo3YM7uG8j1GToyXA6lCDrPSmjO8X/GU2o
 cjD0GcSLPOm5iAwdJj4uXaITSDGzaYUmUbK0fj8hyyXcwbCqRw1yKLnlGo3jtnUc8OYD
 v9NdE1RNQb1EdG3O4ynFusfm79iFTuAy2L+HevkxlB72yribGuRAu2HnU+1cqDidf03s
 bFKuVDfOmYqwRXFlOcR6Q1Mn5QvCCb81iz5+P9EYASqjLmjZQpzSPv7+eeFUOPFDQqae
 n/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ivVJaBVvGDqf6sjfWVzYQDCxtvGXZVbjmdYpdniNsuU=;
 b=UNFwSfO3gp59JTX+oVaIF2yRKs+H8BIpt34KUl4pKmVmSzYXnUYZBPT9VpJ/QzptkW
 DvxOFVb7E/3OvcKJ+S/zrAMxR7IWXRlLeHERE8Q95Dx7N5V/f9z+UuMsVdZNx9MmwQJg
 rcUyncED9fVmw5IUCpBL8p9EbrzaYdIyr5K7aWM8FC0tRVTtn4igmZ4ChVFzNp5tAVZf
 NBW+YhubPVzM/Kaa9Utf9At6SCcsBHLBtAvd9yIE5dOWrNxvtpfFT1zOUHGAEbAyZhC1
 PSR7jJOTgzj9vpu/6fuLmP+5+dqemWclQ1JGJX/o2LA3usCDTeGIHsLmY3WEGICCEAI1
 yc7g==
X-Gm-Message-State: APjAAAUVogCsc/IFMjd/rqVrQhLnr2vx0JlHekN2VARC+gPh7Y4+nAv+
 Vr6p3uJg3Sn4ROPeWYkoihQE/V99QwGG9kan0Pgr3A==
X-Google-Smtp-Source: APXvYqyTSsiAq/426EKY4BG9UhvNHzq+COCbZfJTC4pDxHG9XQVztnC8FrYJgfqXMco22Ec0qu0CojkPZGwQkKRHxao=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr571517otq.97.1581332519913; 
 Mon, 10 Feb 2020 03:01:59 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <875zgm2vqv.fsf@dusky.pond.sub.org>
 <CAJSP0QWCn_vv2Vs-UWc9nPHjdBQq9KMkiQ7D91+RwHM_okTzZw@mail.gmail.com>
In-Reply-To: <CAJSP0QWCn_vv2Vs-UWc9nPHjdBQq9KMkiQ7D91+RwHM_okTzZw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Feb 2020 11:01:48 +0000
Message-ID: <CAFEAcA9NfGivg0C_enAT_8+_mmbQSi6H=7G+4w7RdJwXP7yUtA@mail.gmail.com>
Subject: Re: Summary of Re: Making QEMU easier for management tools and
 applications
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Feb 2020 at 10:57, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> I'm in favor of simplifying QEMU at the expense of an incompatible CLI
> change in QEMU 6.0.

If we want to do wholesale incompatible changes to the CLI
I think we definitely need some kind of tool where a user
can say "here's my old command line, what's the new style
equivalent?". Otherwise we're going to have a deluge of
user issues where their old working setups broke and
QEMU didn't give them any useful hints about why.

thanks
-- PMM

