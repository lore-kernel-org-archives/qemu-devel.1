Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C92CC31E4A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:46:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CE7720673
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JjH0k34y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE7720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41732 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbSre-0001Bu-Ih
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 12:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58437)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbRff-0005uh-DK
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbRfe-0007OM-2B
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:29:47 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45394)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbRfd-0007Ni-Iw
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:29:45 -0400
Received: by mail-ot1-x344.google.com with SMTP id x21so8460640otq.12
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 08:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KEkgxCKWRabUyBza824z8Hgv2Pzr1xKHtI89+T+0aec=;
 b=JjH0k34yc7VvL8f74qAog778MLjkcY9P5nIbtcu2yVVNTE0NBmlQho9O3DDv/BpqYI
 XzNTaZdItmZ9mgNXe27UNQeUBPI5v5dXUItUH09h/O8zxFSu0aLoDqgXFq/B+slVNBxy
 cUIjHLzkSaWt/aBYoiQ3xOM9xqJ5MTuVqD5ZzdzbJiJf5URH7rPZ7GiLKnBDpy5NYIl9
 RzqGKMDM6K5fTzlzhy0muikcAhF5Tt18f+7b5Rw9vbQrJ1zqXGk/If5T97XRoKOzrA7u
 G1MFV8Sg5kPRt9IVUfxwDRbqMA1bGfQPijYu1MFPzTMx85uIxd0zhcZ0Ofvu+ZJ0P9ld
 kTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KEkgxCKWRabUyBza824z8Hgv2Pzr1xKHtI89+T+0aec=;
 b=IN860NGoSl5xCBusxajXwUDvLzwErw5XXmt9aqCw1bjJn7yoeSbwmnfGzKT8vy2x1U
 5WMNQ6F5WZHdBigNExshE6uGOg/H27KvPdt7l1+qPRG7b0OfrPilSk/RnxMH9jeryzBa
 wpbaNLD+IDNAxqeoHf0DgtoXrj/Sk8tivf9K28aXcHyAIOaFh/G9QattbmvU77lDhLXM
 /dC35C32oIO957l3dioisEm5gb5FcXD1hfmzshRqbGmwCatzV+h4OWP0lgdo43xnf3WG
 VU9NYkZKdI241tPq+mV4n2Kmd7IyICuH7OUqD2h8NY6IdIvIdtT0BstgnxvGO1tm503e
 hEUg==
X-Gm-Message-State: APjAAAVAnyqomqUtbsUQvIqc0QSvHWMSv4Fmqj9i0wHj/N3+JCRhf0aH
 VrKIqr68VRDSOy9h1pEoUh9CFdb++P/4mEkE5XyzFA==
X-Google-Smtp-Source: APXvYqw1WD4E2NVORujl1LaOYftgBiU0xcr64Xf9Do6AO/5AdiCjTiTtUiV3kpCvcSlpjqHutDUVNJ2w9Ok3hEgHuBk=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr2063255otn.135.1560439784520; 
 Thu, 13 Jun 2019 08:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190610134545.3743-1-peter.maydell@linaro.org>
 <156043918624.3418.2275764093147880770@sif>
In-Reply-To: <156043918624.3418.2275764093147880770@sif>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jun 2019 16:29:33 +0100
Message-ID: <CAFEAcA97MUveG=si03B7_2WzDugtz7hR9x+YNQmU2xDiCF81eA@mail.gmail.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] qemu-ga: Convert invocation documentation
 to rST
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Jun 2019 at 16:20, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
>
> Quoting Peter Maydell (2019-06-10 08:45:45)
> > The qemu-ga documentation is currently in qemu-ga.texi in
> > Texinfo format, which we present to the user as:
> >  * a qemu-ga manpage
> >  * a section of the main qemu-doc HTML documentation
> >
> > Convert the documentation to rST format, and present it to
> > the user as:
> >  * a qemu-ga manpage
> >  * part of the interop/ Sphinx manual
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

> > +# Canned command to build manpages from a single manual
> > +build-manpages = $(call quiet-command,CONFDIR="$(qemu_confdir)" sphinx-build $(if $(V),,-q) -W -n -b man -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1 $(SRC_PATH)/docs/$1
$(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")

> > --- a/docs/conf.py
> > +++ b/docs/conf.py
> > @@ -115,6 +115,14 @@ todo_include_todos = False
> >  # with "option::" in the document being processed. Turn that off.
> >  suppress_warnings = ["ref.option"]
> >
> > +# The rst_epilog fragment is effectively included in every rST file.
> > +# We use it to define substitutions based on build config that
> > +# can then be used in the documentation. The fallback if the
> > +# environment variable is not set is for the benefit of readthedocs
> > +# style document building; our Makefile always sets the variable.
> > +confdir = os.getenv('CONFDIR', "/usr/local/etc")
> > +rst_epilog = ".. |CONFDIR| replace:: ``" + confdir + "``\n"
> > +
>
> When testing this I have the following in my qemu build directory (via
> ./configure --prefix=/home/mdroth/w/qemu-install2):
>
>   $ grep -r CONFDIR
>   config-host.h-timestamp:#define CONFIG_QEMU_CONFDIR "/home/mdroth/w/qemu-install2/etc/qemu"
>   qemu-doc.txt:     user-provided config files on SYSCONFDIR.
>   config-host.h:#define CONFIG_QEMU_CONFDIR "/home/mdroth/w/qemu-install2/etc/qemu"
>   docs/version.texi:@set CONFDIR /home/mdroth/w/qemu-install2/etc/qemu
>
> but the following input for the qemu-ga man page:
>
>   qemu-ga will read a system configuration file on startup (located at
>   |CONFDIR|\ ``/qemu-ga.conf`` by default),
>
> ends up as this in the generated man page:
>
>   qemu-ga will read a system configuration file on startup (located at /usr/local/etc/qemu-ga.conf
>   by  default),
>
> is this expected, or are we unexpectedly falling back to the default
> value here?

No, if you're invoking Sphinx via the makefile then we should
be passing CONFDIR="$(qemu_confdir)" to set the environment
variable when we invoke it. Can you try doing a build with V=1
to check the sphinx command line ?

I've just realized that I didn't also update the 'build-manual'
macro to add the CONFDIR setting. Perhaps Sphinx ran first with
the build-manual macro and has cached document contents created
with that incorrect invocation and then reused them in the manpage
creation? If so, this should be fixable by adding the CONFDIR="$(qemu_confdir)"
to the build-manual macro in the Makefile, and then deleting the .doctrees/
directory from your build tree and rerunning make.

> Sphinx seems to do a better job of formatting "Key" and "Key type" into
> actual table columns in the generated man/html pages (rather than just
> separating them with whitespace), so I think we can drop the trailing '='s

Sure; I'll change this in v2.

thanks
-- PMM

