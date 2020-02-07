Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62789C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE4C20720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NvsP6A9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE4C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j01TC-0000CZ-DO
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 06:06:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j01SN-0007Hy-He
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:05:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j01SM-0004sV-7Y
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:05:55 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39673)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j01SM-0004pS-0y
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:05:54 -0500
Received: by mail-oi1-x244.google.com with SMTP id z2so1580954oih.6
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 03:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QIdcC832XiqJvqnI5PCgx0K+8Vle1K0LFooAdcoAVTA=;
 b=NvsP6A9M23PO5QCShjrT1BV9HemYitqJRH2yL8p3hxRB5H6MKVH3OfLfpFO53ZtLnH
 +2csRE0M+xfuV1HP1+HRDea/0zC7yCC1NMpa4eyG965b/2xl5AkyzvLGIuO94xbjQtMn
 QU2WwuHdb6rwRRI7kHFbRPj4+vWvi+5T9poKWqelS2L7/fD3YGURYYozd4Y42CYxF9Dp
 JfJDAam3UWzu83yIN0wz4q8mhYo55mSUNebiKF5SWODxCf9VbPRdwY63PYdJcniGZmR/
 klic6gY8ZRoL9vsrga6Kv+pm1SZ9EFKqN2H7GKiMxhj/4djkTMIlbJcsVOWdVi/7ePz3
 PPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QIdcC832XiqJvqnI5PCgx0K+8Vle1K0LFooAdcoAVTA=;
 b=OHmSfut16Qh8g2Dy4G1a6D/wFygtl4+QKXbY70DlbxdIu6wPyOIRVjrOt0p6/Zxwcp
 4+sEMWLeq2lZ3Pa4hgjmiT/FTPV/KT63lVWVJa4BRayaYJSqeClrWiq514FNszvSKQ/8
 l33VugY53sbungO3V9RQYgGoPErTe0+RtzgtfFYcr0NdkfmLP9Iaof7+CsxGoLUydAeB
 14cXe56+trwyqAtbWcNI+/0YLMj72So5Rl7h+cjaA7TQlMWUt3TjIXkqPGOyi9YUUYH1
 eY+K7P1uGiD7Z1vqpaOXYz/sghgzoQxq907xDKx5W5+jB7+1AGKzgjy3XV+LvwTSy9k0
 jgYQ==
X-Gm-Message-State: APjAAAXpOKUqw4TyM2VHjH7n1Qzi8M8vIFkudmfOK2FlHELiyJqiRIiG
 7jFysgVKdcjDcK/rBa6hU8oB8EEGWHAqBuhYPCmkPg==
X-Google-Smtp-Source: APXvYqzq0q/Ap849zWS+Gkr6qlWXDO/+b1eY+yAV+rhPcLOEYZN3Py8N6hEw4r9qavrt59mhU/mHxgjdaIYcqa4juEw=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr1685443oif.163.1581073553013; 
 Fri, 07 Feb 2020 03:05:53 -0800 (PST)
MIME-Version: 1.0
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-9-peter.maydell@linaro.org>
 <87pnequ4og.fsf@dusky.pond.sub.org>
 <20200207102433.GC6031@linux.fritz.box>
In-Reply-To: <20200207102433.GC6031@linux.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2020 11:05:42 +0000
Message-ID: <CAFEAcA9a8G=RQASBxQGLMBU32w+G7un-xQwOHv4y56W1TQftPQ@mail.gmail.com>
Subject: Re: [PATCH 08/29] qapi: Use ':' after @argument in doc comments
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 at 10:24, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 07.02.2020 um 10:28 hat Markus Armbruster geschrieben:
> > Peter Maydell <peter.maydell@linaro.org> writes:
> > > @@ -4703,7 +4703,7 @@
> > >  #
> > >  # Options for creating an image format on a given node.
> > >  #
> > > -# @driver           block driver to create the image format
> > > +# @driver: block driver to create the image format
> > >  #
> > >  # Since: 2.12
> > >  ##
> >
> > Loses the visual alignment.  I'm okay with that, but the folks who took
> > the trouble to align the text may have different ideas.  Cc'ing Kevin
> > and Max.
>
> I think the documentation is much easier to parse visually with aligned
> text as it makes both the option name and the whole part of the comment
> that documents options stand out clearly.
>
> Of course, "It is the QEMU coding style." would trump everything, but as
> long as there isn't a style guide that requires a wall of text without
> spaces and alignment, I'd prefer to leave at least those aligned texts
> in place that we have.

So, the other way to handle this would be to say "the @foo: can have
an arbitrary amount of whitespace after it", and have the doc comment
parser strip out that many characters of extra whitespace there and
on the subsequent lines. The downside is that then you would have no
way of having a comment for an argument which started with rST markup
that required leading whitespace. I think this pretty much would just
mean that you can't start an argument description with a blockquote,
so we don't lose much, but there is a difference currently between:

@arg:    In the current parser this is a blockquote
         Blockquote line 2

      But this is a non-blockquoted line still in @arg's description

and

@arg: This is not blockquoted, it's just a line
      So is this
      and this

I can make the parser work the other way if people prefer that though
(and then the first example above would become a syntax error because
the 3rd line would be unexpectedly de-indented).

thanks
-- PMM

