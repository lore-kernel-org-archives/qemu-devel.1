Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F07C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 09:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 563F024670
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 09:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QlHsOxKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563F024670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irIov-0000S3-UD
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 04:49:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1irIcp-000144-38
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1irIcn-0000b5-Fg
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:36:38 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45603)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1irIcn-0000ax-9g
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:36:37 -0500
Received: by mail-oi1-x243.google.com with SMTP id n16so11160590oie.12
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 01:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cvt4jvo7a8DHkDMPBVqfcYlqKedlVWPjH3H7nEygEQg=;
 b=QlHsOxKnpytN2f609iypsIYGoj2i51avhPClN8CKyNlwMMXyqvqDz3AXy4jQBx3+tR
 HMEMdvSlwJkRZMzgQi+x4VffRjmFe4dJzR1TX88R18bT9CYcwW837tJKSgnPRXHmxDAC
 3p+tEE9ZGdluXu4U6Sg/w0nAsmr6gUNEg5UB1Cb0KS205UH/xW+k1yhPAeRKbpyn8sh4
 8v1rNqkJefh0XJ6dEc+oaQr8ENtIcXOffkbTWjf1OvtXkLORdnr/n0RaEHKUrPI2Wtqu
 5GzFkxpDLNVisTTYmfQu7GGchZZfU5xKPFqU/vvsabeY3XmUZpVL1mcRVwtKxvl739Fc
 cKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cvt4jvo7a8DHkDMPBVqfcYlqKedlVWPjH3H7nEygEQg=;
 b=uiVJVSCsWfKIazh0rnUkfNml/coYtNLX5qKrLlAlVv45Ffndgb3Ey/mortILjSeWbN
 KLmZo5IQ24/xPWsKrcokl9iz70ITo8CjF0mA0Xz8gqo8jAud9H7m1zL4pEns+duiJkj6
 lDvVoI57VrNGSopZZ2HxuZbr9EzI5gt+38MOjTt1KoNAu0vPu43x/s+9VqjS86MI0NAi
 k7Ip5A0COMrTIUr1Wp/VOXOpde9HL7ZATvJiPruxZvkwSw7cDa8/AFl6gjXh97RVdCvM
 2DmTfTuvBlC68ojIXkIVN4Hrg/o1yqUgBqqXZ7I7qALWCpLVwTmocplH96/tTBPVCdAf
 7uKw==
X-Gm-Message-State: APjAAAXAXqOAcprao+R86FG783Ik/hg+fud4EOa0rUR63hzDrN4OEfaW
 rAtAglGHwOpIC49U+O1bprcrRMI46LNe6CeBNeWyrw==
X-Google-Smtp-Source: APXvYqwliHzusqjQ1hHZDPkWaK878IQiozvXPsLzj1imfsBO4PEArdcOjnCywK0VUIJFGg7JqziMrt0vCVcnUAAIoJc=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr16286957oid.98.1578994596196; 
 Tue, 14 Jan 2020 01:36:36 -0800 (PST)
MIME-Version: 1.0
References: <20200113180812.3442-1-peter.maydell@linaro.org>
 <2b20b548-fb1f-2663-3614-03306595e5d7@redhat.com>
In-Reply-To: <2b20b548-fb1f-2663-3614-03306595e5d7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Jan 2020 09:36:25 +0000
Message-ID: <CAFEAcA8==fs2CL9dm+m5m+w7xjSrT=g2Zqr0TAm+tHDAumZG6Q@mail.gmail.com>
Subject: Re: [PATCH] qemu-nbd: Convert invocation documentation to rST
To: Eric Blake <eblake@redhat.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jan 2020 at 19:58, Eric Blake <eblake@redhat.com> wrote:
>
> On 1/13/20 12:08 PM, Peter Maydell wrote:
> > The qemu-nbd documentation is currently in qemu-nbd.texi in Texinfo
> > format, which we present to the user as:
> >   * a qemu-nbd manpage
> >   * a section of the main qemu-doc HTML documentation
> >
> > Convert the documentation to rST format, and present it to the user as:
> >   * a qemu-nbd manpage
> >   * part of the interop/ Sphinx manual
> >
> > This follows the same pattern as commit 27a296fce982 did for the
> > qemu-ga manpage.
> >
>
> I'm not an rST expert, but trust that you compared the resulting
> renderings.  Is there a quick recipe for doing the build locally so I
> can easily inspect local artifacts myself?

Yep -- assuming you have the prerequisites installed to
build the docs (should be just makeinfo, pod2man, sphinx),
apply the patch and then 'make' will build the docs -- the new
qemu-nbd.8 should be in docs/interop in the build tree,
assuming you do builds not in the source tree. If you do
builds in the source tree then the built artefacts
are created under docs/built. The html that forms part of
the interop manpage set is in docs/interop/qemu-nbd.html,
also in the build tree.

> > +++ b/Makefile
> > @@ -338,7 +338,7 @@ MANUAL_BUILDDIR := docs
> >   endif
> >
> >   ifdef BUILD_DOCS
> > -DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 $(MANUAL_BUILDDIR)/interop/qemu-ga.8
> > +DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 $(MANUAL_BUILDDIR)/interop/qemu-nbd.8 $(MANUAL_BUILDDIR)/interop/qemu-ga.8
>
> Worth splitting this long line, either with \-newline, or
>
> >   DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
> >   DOCS+=docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7
>
> with additional DOCS+= lines?

I think I prefer the latter.

> > +++ b/MAINTAINERS
> > @@ -2503,6 +2503,7 @@ F: include/block/nbd*
> >   F: qemu-nbd.*
> >   F: blockdev-nbd.c
> >   F: docs/interop/nbd.txt
> > +F: docs/interop/qemu-nbd.rst
> >   T: git https://repo.or.cz/qemu/ericb.git nbd
>
> Would I be taking this patch through my NBD tree, or would you be
> bundling it with other doc patches?

Either way would work for me, depends a bit whether I
get round to trying to do another doc conversion
and whether you had any other pending updates to the
old texinfo doc.

> > +++ b/docs/interop/qemu-nbd.rst
> > @@ -0,0 +1,263 @@
>
> > +.. option:: -s, --snapshot
> > +
> > +  Use *filename* as an external snapshot, create a temporary
> > +  file with ``backing_file=``\ *filename*, redirect the write to
> > +  the temporary one.
>
> Pre-existing poor grammar. Better might be:
>
> Use *filename* as an external snapshot, by creating a temporary file
> with ``backing_file=``\ *filename*, and redirecting writes to the
> temporary file.
>
> But that could also be done as a separate patch, to keep this one as
> mechanical as possible on the conversion.

Yes. I noticed a few things I would consider docs nits
which I deliberately didn't fix up in this conversion patch;
I'd prefer those to be done separately afterwards.

thanks
-- PMM

