Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8C8C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 14:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 188362053B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 14:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQGfaOXl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188362053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55826 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOkGf-0005UN-Dp
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 10:43:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOkFq-00056f-Gh
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOkFp-00035n-1O
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:42:38 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hOkFo-00035D-Tb
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:42:36 -0400
Received: by mail-ot1-x342.google.com with SMTP id g18so2280724otj.11
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 07:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=O6m3IXwg6vCfQkt0Baoa8IrX9DyythtztZcrJxNudz8=;
	b=fQGfaOXlnnR9/9VfJ3kGudEozxXcQGSib7oK7AVRt0WH0h2Is5snEjNiWcw5d6gRwG
	DKu9S9oeJANdLqBwRw4BGVfdqm8YAeLN+N5b37HC3mxR4Zf+TXuyPH6bTEzlVD1I5hhA
	yvVh7J4V0gRyELCcqikJAN+hVC0iitJ45yNJVvBgmtLLEazUoWnXxufRBBgjqwzXQ0bN
	/jSiGLpPILIOUP1ojqA4YzEpnF2xmqfV5DqnGs0zGE2NEdC6v3Ndxc0mzqDMirO4Y/aE
	8A9mPGf9egWrLMgPB6/zA1z0HefpEH682H3tIac5p3Y+TwDiGkSb5kBvbjAwGLbheJtR
	SucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=O6m3IXwg6vCfQkt0Baoa8IrX9DyythtztZcrJxNudz8=;
	b=Bf1HGjCVBFFX1u67XBGEirZSMnq7gTqmyHob5+B5rN7hrcxBfe3gRaXlb/vSN0SD6q
	Tx0PCdl2nYqIVorQV2NeFboTbiRJYB0OCJBETQ7vkNGODy+v+rhDhHSBceYgY+sjWtlQ
	Ho3utmN1ZkHjIR4IPbpZzUolAraR9Dvfl9EiPFuC4FSxMusCUHmtYnnHL2+Me0HgbeWt
	sejHQv1t8Lq+nUA02EjtmcAuFSK8U6vOnVk/WG1BMoFrqgW6mZfyihs/z/Mlw7e9gaLH
	NolzqpBUOCKLzpnZnf4VxMBW788WbZGET97n1C/gI2jLiQrHYRGPUBoZceuT5n7BICWl
	0r6A==
X-Gm-Message-State: APjAAAVeb0gMm9DkQvRxbBwlVy+TF9WyT4sZc+oVMeRlFgF5M6wPrLw+
	FhlXjlQouMiGwNVHI9nHOtQGol4pzo25kBqwFekMyssKjgQ=
X-Google-Smtp-Source: APXvYqzVlFuSy58r6XomBEhrCKT+r+i9pHkWZ/C3NhK++0FRzdD09Xh0RMXDCbxICZC2BJK0DjG9QGYbfs4pyJ7QS/c=
X-Received: by 2002:a9d:404:: with SMTP id 4mr2755296otc.352.1557412956005;
	Thu, 09 May 2019 07:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190503082728.16485-1-ao2@ao2.it>
	<20190503082728.16485-3-ao2@ao2.it>
	<541bfc5c-0e45-58e6-f0b1-81e9b0c8881d@redhat.com>
In-Reply-To: <541bfc5c-0e45-58e6-f0b1-81e9b0c8881d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 May 2019 15:42:25 +0100
Message-ID: <CAFEAcA8An-KWOc3gOz2=45eCHCmUJEJw_bTrrCW6bYO23H8TPw@mail.gmail.com>
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v2 2/2] configure: disallow spaces and
 colons in source path and build path
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Antonio Ospite <ao2@ao2.it>,
	Antonio Ospite <antonio.ospite@collabora.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 May 2019 at 18:27, Eric Blake <eblake@redhat.com> wrote:
>
> On 5/3/19 3:27 AM, Antonio Ospite wrote:
> > From: Antonio Ospite <antonio.ospite@collabora.com>
> >
> > The configure script breaks when the qemu source directory is in a path
> > containing white spaces, in particular the list of targets is not
> > correctly generated when calling "./configure --help" because of how the
> > default_target_list variable is built.
> >
> > In addition to that, *building* qemu from a directory with spaces breaks
> > some assumptions in the Makefiles, even if the original source path does
> > not contain spaces like in the case of an out-of-tree build, or when
> > symlinks are involved.
> >
> > To avoid these issues, refuse to run the configure script and the
> > Makefile if there are spaces or colons in the source path or the build
> > path, taking as inspiration what the kbuild system in linux does.
> >
> > Buglink: https://bugs.launchpad.net/qemu/+bug/1817345
> >
> > Signed-off-by: Antonio Ospite <antonio.ospite@collabora.com>
> > ---
> >  Makefile  | 4 ++++
> >  configure | 6 ++++++
> >  2 files changed, 10 insertions(+)
> >
>
> > +++ b/Makefile
> > @@ -1,5 +1,9 @@
> >  # Makefile for QEMU.
> >
> > +ifneq ($(words $(subst :, ,$(CURDIR))), 1)
> > +  $(error main directory cannot contain spaces nor colons)
> > +endif
> > +
> >  # Always point to the root of the build tree (needs GNU make).
> >  BUILD_DIR=$(CURDIR)
> >
> > diff --git a/configure b/configure
> > index 9832cbca5c..f7ad4381bd 100755
> > --- a/configure
> > +++ b/configure
> > @@ -279,6 +279,12 @@ ld_has() {
> >  # make source path absolute
> >  source_path=$(cd "$(dirname -- "$0")"; pwd)
> >
> > +if printf "%s\n" "$source_path" | grep -q "[[:space:]:]" ||
> > +  printf "%s\n" "$PWD" | grep -q "[[:space:]:]";
>
> For less typing and fewer processes, you could shorten this to:
>
> if printf %s\\n "$source_path" "$PWD" | grep -q "[[:space:]:]";
>
> but that's trivial enough for a maintainer to fold in if desired.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

What tree is this going to go in via? I suggest the
-trivial tree.

thanks
-- PMM

