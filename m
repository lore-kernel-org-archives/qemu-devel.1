Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376F6C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 18:37:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3CEC20843
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 18:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vgkcQKZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3CEC20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40963 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQym7-0001l9-8W
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 14:37:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hQylK-0001Rn-AN
	for qemu-devel@nongnu.org; Wed, 15 May 2019 14:36:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hQylJ-0005Jd-7l
	for qemu-devel@nongnu.org; Wed, 15 May 2019 14:36:22 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hQylJ-0005IM-2z
	for qemu-devel@nongnu.org; Wed, 15 May 2019 14:36:21 -0400
Received: by mail-ot1-x343.google.com with SMTP id n14so993999otk.2
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 11:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=bFDk7oOF8CGHg+CyLZonr8DfQgDO70pMVkfG9wwNNqY=;
	b=vgkcQKZuclA0DRLP2KUcGTmeHs0XH8roiN4Rpn+0AaOMjDBgWRIAA5ai5fATJ0l7ly
	4P/PkiHqTWf9VCtyASHeFtyiHwStzhlj/Vi9O1dai3PxeA7sihYiuY6qWVwCLgvXPlMG
	o44kkuB1cYfl+QqGLXEHpmtaTencbp9n+cg+1j7RfkhjGgEJMjytPN2EqWmajAH8r1V4
	3JeE1up4SLMFD36BlRA8amfhtqjbGONSbI6HudcVj7YcDZbF9LF9xnRGAKhh4PxysslY
	GLM5s6EOi9yKrLXSy+KIIvO/SYg3/szX2ZJ4ArUAKVWgy2jnxZ4DqT7zysmlUU3DmCQB
	OVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=bFDk7oOF8CGHg+CyLZonr8DfQgDO70pMVkfG9wwNNqY=;
	b=XpA0a9F7PSxt45ZyISelCdzB6Xs9zpVMWH1g0jsAg/+cYSNtkbzqQGvsRmNTRd0xo0
	JsGRrvBgslffXpLoK5jdCQjQfiF5VdDJ2FBSHDA64zidQLE3POOx1oc4x4kXmi3RuM17
	RHT0pspfGnll7XZthCchZ9qNeph4iYi6lxUCDUH8EGeTYigpt9SoeDEakmG6vuf5mYpw
	GJ6ka4YWoR2b0JbYdP8qNgZrQt11nQ9mhew9iCod+X9sseuiAAhm9MwyawKtJsNx+82j
	0Ju9fy6/z+cnQbaHV+mLdSHNNaoA6xj+0APlEXjaO+Yo1eyv3fvqZumlBO+W/VtI7zOF
	HrYw==
X-Gm-Message-State: APjAAAWfUDFYDaFOl7Y7TzYSr0goq5Wl5i/MmoYmxeGo3jb0h0ICmjgo
	JMdjba7B0bLT2zSAJB6TlDM8HIERrB53ShISwRc=
X-Google-Smtp-Source: APXvYqyDfS2oYD8GGEXFD0FIlwJDqwCoe04o/oZBETPGM5xtiOSZKs6YOX5TKGV14WSWVLzcx9u67RH60V5mHSk88IQ=
X-Received: by 2002:a9d:400d:: with SMTP id m13mr6353452ote.100.1557945379327; 
	Wed, 15 May 2019 11:36:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Wed, 15 May 2019 11:36:18
	-0700 (PDT)
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Wed, 15 May 2019 11:36:18
	-0700 (PDT)
In-Reply-To: <CAFEAcA9mU7OPhr1Koktzttj3nzXbr6i4DG6Wzy8tgVP95BkjxA@mail.gmail.com>
References: <20190510203452.11870-1-richard.henderson@linaro.org>
	<CAL1e-=hE4zMwDewsbD6=Kc32Ss9wcB-AyOtY-G=HhDKS9YMOoQ@mail.gmail.com>
	<4a2f1364-b7d2-209e-3d17-ca1eef3b53e3@linaro.org>
	<CAL1e-=hsgj0oq_4VUX97KRm3eJovXLw4G28dXiU9X+XA6wsQ2A@mail.gmail.com>
	<CAFEAcA9mU7OPhr1Koktzttj3nzXbr6i4DG6Wzy8tgVP95BkjxA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 15 May 2019 20:36:18 +0200
Message-ID: <CAL1e-=ggNR9ZgpKj8kCjgkmpV3un1gZrR-bg=UtMK6KXPF8k=g@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] configure: Disable slirp if
 --disable-system
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	=?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 15, 2019 12:07 PM, "Peter Maydell" <peter.maydell@linaro.org> wrote:
>
> On Tue, 14 May 2019 at 20:16, Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
> >
> > On May 13, 2019 11:14 PM, "Richard Henderson" <
richard.henderson@linaro.org>
> > wrote:
> > >
> > > On 5/11/19 5:47 AM, Aleksandar Markovic wrote:
> > > > If no, the patch shoud be amended. If yes, the commit message
should be
> > > > extended.
> > >
> > > Like what?  I think it's pretty clear as is.
> > >
> >
> > Richard, no. In this case, there is a glaring discrepancy between the
title
> > and the functionality that the change provides. Much better title would
be
> > =E2=80=9Cconfigure: Disable slirp if no system mode target is selected=
=E2=80=9D.
> >
> > I leave it to you to find out what can be improved in the commit
message.
>
> Aleksandar: I think this is not really a very productive stance to take.
> Richard thinks the commit message is reasonable. If you have something
> you would like him to change, I think we will reach a useful endpoint
> much more quickly and smoothly if you suggest some new text, rather than
> effectively saying "you need to think of something, and I'm going to keep
> making you rewrite it until you telepathically figure out what the text
> I wanted you to write is".
>

OK, Peter, no problem from my side. I was trying to make Richard think more
about what he writes in his commit messages, and how he organizes his code.
Sorry if this looked unproductive or even perhaps offensive.

Yours,
Aleksadar

> thanks
> -- PMM
