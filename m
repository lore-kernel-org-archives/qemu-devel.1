Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A02C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD48220678
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a6nqFFUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD48220678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLPSQ-00038l-T8
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLPRU-0002JH-Ky
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLPRT-0006P5-M6
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:57:24 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:37341)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLPRT-0006OM-AL
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:57:23 -0400
Received: by mail-oi1-x22c.google.com with SMTP id u20so12675873oic.4
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 03:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kScSPDlSd6G0dJlKAnBpLQrbuWhetoLC32oMaLKe3S0=;
 b=a6nqFFUGhVCWKhswyC2bgXOl5p9mMABD9f+IGe08mrjHdfjgbJr+SEmwz5eL3zea6L
 /nLrigwyjzuIdFHIcYAw+9onFsb0i3OAc2roi2YkrAc1Ke7SsueDNJBsPtY+V8LN00gD
 c5D4c7NO3xuQGRSXHoMf8dNfFNU9M5Tk/F12kb5BnLwBAj/zC9hULl0RB+9AjjvNannK
 ziokr2Lr2/j1Q9dX+stBlLwnMFbNPADZR+SSqyQd1+bjLr76VRk4LxDuD6b9pPymEEIR
 7GhO9el2TP+RWhytPTNPpy9rtwZ1TrcSJfHm/OSVGZwprACcCK3DBGTlaD16IR/92O4W
 KHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kScSPDlSd6G0dJlKAnBpLQrbuWhetoLC32oMaLKe3S0=;
 b=LtkzYaEcToLnLwrHAHvMqDVk7KeQ/YXEyMQib+bMzMe+ETE0+rRztpC8exXSohX9Ls
 uDra0MIq1N7RlfqPt8FpMULAD3sWzniNwyPzOoSw3BkrKkyPVO7YyJPK2IeR9kD9a/ud
 A8KlblVivg7rOhTh3mEoLY85qkhA4h84sLm4kPG6PUw+uN3qegMcnEM1vwIblTPtUQXb
 K1bYADcSLEIEbsOSkjN1IO7fdQQv2TUCx8xYeE83/fZ2zj8GPbX8AT+ngFKsVQucC5hC
 iKnMz99fZu2cCp7X3ajXbekh5dgxS1sJ67yGHViVgebqIoWAKpoDjYUscBG+4qO++igH
 is8Q==
X-Gm-Message-State: AGi0PuZOdBLmk0Z3qE2dZK+3cG0o1JOZsaDU7hPXg20ce2tLG616xtpB
 MsPCZtU+s+ew0i6+Czii1YAViOEKw5x6SbfHs4PFCA==
X-Google-Smtp-Source: APiQypJxSzMPEKT21OFu29zHpU8WhnyEnlovTYFOiP9PoWdtZeJ0sTPOwlsTqS7UbF4ba4Pw0DHjWRu6p4gRKao0UtE=
X-Received: by 2002:a05:6808:8cb:: with SMTP id
 k11mr11556260oij.48.1586170642350; 
 Mon, 06 Apr 2020 03:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <de92e66d-c474-dd1b-ddab-194b2f92d1dd@redhat.com>
 <de4b6733-859b-eebe-32ab-c0eb0fcb6311@redhat.com>
 <f20f5784-d810-54d7-a25e-5394b2b75abd@redhat.com>
In-Reply-To: <f20f5784-d810-54d7-a25e-5394b2b75abd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Apr 2020 11:57:11 +0100
Message-ID: <CAFEAcA8cS+7K1Wrguc0PyvRfZgaNpTNA4tSUsn13dxCcWz0ASw@mail.gmail.com>
Subject: Re: QEMU participation to Google Season of Docs
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22c
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 John Snow <jsnow@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-discuss <qemu-discuss@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Apr 2020 at 11:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 04/04/20 03:37, John Snow wrote:
> > I have a lot of opinions and thoughts on python and how docs should be
> > laid out, but I'm afraid I'm not so good at understanding all of the
> > options and "use cases" of QEMU to confidently lay out a top-level TOC.
> > Maybe if we collaborated on a TOC we could give a clear project
> > guideline to a GSoC/GSoD contributor.
>
> That's actually how a good technical writer can help us!  The main
> problem we have with our docs is the disconnect between docs/system
> (formerly qemu-doc) and the .txt files in docs/.  We know the material,
> but it's hard to reorganize docs/system to make room for everything else.
>
> Reorganizing the TOC to fit all the material in both categories would be
> the best outcome of our participation in GSoD.

Yep, and unlike last year we've actually (almost) completed
the transition to Sphinx so we have a workable structure/tooling
for a tech writer to work with.

thanks
-- PMM

