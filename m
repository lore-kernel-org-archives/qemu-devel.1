Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A88C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:08:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E4612082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="USeRZVau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4612082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyaWR-0006JJ-S5
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 07:08:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iyaVs-0005rw-PP
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:07:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iyaVr-000110-Hi
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:07:36 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42697)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iyaVr-00010K-AO
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:07:35 -0500
Received: by mail-oi1-x243.google.com with SMTP id j132so14440266oih.9
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 04:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jrVX8j/oY7iUefkJ9apS0Y19zELiugyhpZGMOluw4QM=;
 b=USeRZVau/cKUKwbrfy/uw6Ukas0OPfQuku36dQzhiYIdj0Fp+isEgzve8TijvsTFDV
 mwOk9TQd9+4EEqtv2Bx41Dmbhw+M5uCldYWSR2adyN9YI5PUvmw7xwWVwONV2hBoMaal
 QBSZOlwSYKALmhkO50gCYUjFDXiPRrMMk5Vr3mPB+NzVzgaSfck8OtCoiMNbd4oppqWv
 1WczTJaMAZ0DAawVRltgyXexcMNrpD6t6j3foY4OP7Wjr/4FMLeiWK2EbyhoOsPbTyaA
 tTIKJUmFFaHwZULS+ikLmCi2+1yZxT90j7C60/a7Lr+yr6N97Na11HOCO8Rq1Vyv1Fzw
 40rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jrVX8j/oY7iUefkJ9apS0Y19zELiugyhpZGMOluw4QM=;
 b=XyaZO2Y5GChTMzFhfmT2xbHNqWk/TE7nTW99lQAOm4EtHMA2JPW2EpVIdcWKsBvfnk
 5rglbofL/wDZijgV3AQxseue76OLNXwRsFl104fQjrh8MP/MO+DcpTt3oTTGIHAq9jpl
 jQp5BkUy91SKysunxQ6CM5oVEjgOARFQQ04TUmhjCQlsEoT85FM4WtAoKPWGXNWn54IG
 kJVAx5aY/f54EVW96YHui4PAcq+UY6qh1LlRJTMtXw6g23zmerEGMN8rNpIlzFmpnJDF
 LCvyCdbFo02Xe2ecwlzW0tqPe8oUi0PCaOzitLa6FmDEF5sJLMYi3H1ylY65jBsEBkW5
 yygQ==
X-Gm-Message-State: APjAAAUzTswgEDsn8DOnNGisXh9bjVhyl5/GWQxBP+iR+ZM3BMfS+x/t
 oKrj9q08DC1UEQyyd9iJ/6SnswMB4avuvcoMCVyEow==
X-Google-Smtp-Source: APXvYqwgiUvHyHWPceMioPGWrxA9Wf1fKrN25NHLJJhTF6ImY2EsqEeOBFylOc+dGAEGJz4anw0q7XKBwUw++pIMf4Y=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr14438921oid.98.1580731654190; 
 Mon, 03 Feb 2020 04:07:34 -0800 (PST)
MIME-Version: 1.0
References: <20200113103550.1133-1-alex.bennee@linaro.org>
 <2331e0b7-cad9-7b53-3d30-7fb88d692c8a@redhat.com>
 <20200115111042.GA163546@stefanha-x1.localdomain>
 <CAFEAcA9Q5nsD5iTPwsVVx73HPUD6aGKd0Sf2FUkAFqjAZhGMGw@mail.gmail.com>
 <82f0aa8e-b445-ad7f-1b17-03f4bb180a85@redhat.com>
In-Reply-To: <82f0aa8e-b445-ad7f-1b17-03f4bb180a85@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Feb 2020 12:07:23 +0000
Message-ID: <CAFEAcA8pHXeqtC3WT67vwC=g4Vw7BsYpDxUih1XWYzC+dAjoGg@mail.gmail.com>
Subject: Re: [qemu-web PATCH] documentation: update links to readthedocs
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Feb 2020 at 11:55, Thomas Huth <thuth@redhat.com> wrote:
>
> On 03/02/2020 12.46, Peter Maydell wrote:
> > On Wed, 15 Jan 2020 at 11:11, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >> The qemu.git/master docs are built nightly here (index.html is now
> >> visible!):
> >> https://www.qemu.org/docs/master/
> >>
> >> qemu.org's docs are more useful at the moment since they include the
> >> user documentation in addition to the developer documentation.
> >
> > Our top-level documentation page https://www.qemu.org/documentation/
> > still points to https://qemu.weilnetz.de/qemu-doc.html -- should
> > we update that now to link to https://www.qemu.org/docs/master/
> > instead ?
>
> Sure, but I'm still waiting for someone to suggest a final patch here.
>
> Open questions:
>
> - Do we also want to link to readthedocs as suggested by Alex, or is our
>   own docs on www.qemu.org enough?

I think if we're hosting our own docs we should just link to
our own docs (which include the not-yet-converted-to-rST
parts, which readthedocs doesn't); linking to two different
versions of the same thing is just going to confuse users.

> - Do we still want to link to weilnetz.de (as it was the case with
>   StefanH's original patch https://patchwork.kernel.org/patch/11234545/)
>   or should that link be removed?

We should remove it; it's been really helpful for the project
that Stefan Weil has provided built-documentation we can link
to for all these years, but now we finally have an "authoritative"
built version on qemu.org that's what we should link to.
Again, having multiple links to different versions of the
same thing would just confuse people. (The exception is that
if we ever decide to provide "version 5.0 docs", "version 5.1
docs", "current master docs" on qemu.org we can do that, because
that's an understandable-to-end-users easily-describable reason
for there being different docs links).

> - Do we only link to https://www.qemu.org/docs/master/ or shall we
>   link to the individual docs (qemu-doc, qemu-qmp-ref, ...) ?

Just link to master/ would be my advice. Otherwise when we
add a new top-level manual (eg the under-discussion tools/
manual) we'll need to update this web page as well.

thanks
-- PMM

