Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7F4C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 20:08:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7BA20675
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 20:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6dypzqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7BA20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33438 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNjuL-0006qi-FQ
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 16:08:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hNjtW-0006X3-1Y
	for qemu-devel@nongnu.org; Mon, 06 May 2019 16:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hNjtU-0005XU-P6
	for qemu-devel@nongnu.org; Mon, 06 May 2019 16:07:26 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f]:39278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hNjtU-0005Wq-Io
	for qemu-devel@nongnu.org; Mon, 06 May 2019 16:07:24 -0400
Received: by mail-qt1-x82f.google.com with SMTP id y42so16344171qtk.6
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 13:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=ozVDJffovUj23XemID34vRA/Ykmre4aBk7Wd+c614Sg=;
	b=b6dypzqV0jCOWmTNfhjZPF2/MmsYBo3Wnn1S2D/nTeht7HuJJjuCU7FOmetemhs7cr
	lzz3ejqH4jLTcONsOFwSSbk/L6FfDat6Azybob57ZYfE21urCgUGcLNNPxcEezv61dK8
	kUfLXkkNaoKU8+O5hyzBsG6d72+JkwUo42SYrBzolZLy84oZiFYlFQNqo51yZB+0GL2q
	l/+I+G9BFfdw6dHh3zQnKSJONyHhuioXcns7FtuoD1wzXo54Bsc8+FDiukz/Apy6/Sr6
	jUe7rcYbS3t+Qo9xagCvLABMCTUky8488fmVIoyrvsaY8uChDhWnnLnAs1XWDCQx6z3z
	Mxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ozVDJffovUj23XemID34vRA/Ykmre4aBk7Wd+c614Sg=;
	b=XIacxhsAjOWGOJiKiw0I+0vAaGGPKycxQiNZpHX37wk+kg17O1Cjf4jXuRlwzIKJ5r
	ATaB1jqRLBdygh9Es5oBPGKDUrSifz7NXIDmXwLIsiI8Ydej75h+jeN6PsLbQSgoyF85
	dJ+O277hByRW7QqAPIGlWw/C/vJMbKE3zNPWP/cW/ieeF8dGA/0fRE/ts7QMpxXdIwgn
	XRQTnmDe+ip1EfX8Ak9D2efGC+OukIDUSrgV4TFYgPOhqJxdcTAXSImX+008VrweHEZb
	7r6t0U4clZijR3uA6mniljvVKUoYcM0ZCfiJ7HbYflXPV/6W0E0fIhJY23nM6Gw5dmgh
	5uBw==
X-Gm-Message-State: APjAAAUUsVQ1tFm0Rh+cQBOpgbNRW+tOWzUcFAsxPymh17Qp90MUgAr8
	zr9f0sbrHu+tETVaWwSjpppR/8BdqTSk9a0zplc=
X-Google-Smtp-Source: APXvYqwqCegOvc8I9nmZbnJodT0dMZhvb5BHj3e43ROjm37ao7BuXKKMfsKXwOeiM8j2wjuvvUJH+PFerkwQxrSAzbc=
X-Received: by 2002:ac8:280d:: with SMTP id 13mr22661151qtq.188.1557173240900; 
	Mon, 06 May 2019 13:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190504083638.13380-1-S.E.Harris@kent.ac.uk>
	<20190504083638.13380-9-S.E.Harris@kent.ac.uk>
	<9697659b-7523-2712-25a9-7c7c1eaad32b@redhat.com>
In-Reply-To: <9697659b-7523-2712-25a9-7c7c1eaad32b@redhat.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Mon, 6 May 2019 23:07:06 +0300
Message-ID: <CAK4993iYaXRaF0RRJAcKZnFFP1tCHnSN+uKfJcdNhe0kvnuunw@mail.gmail.com>
To: Eric Blake <eblake@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::82f
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v1 8/8] target/avr: Register AVR support
 with the rest of QEMU, the build system, and the MAINTAINERS file
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
Cc: E.J.C.Robbins@kent.ac.uk, Sarah Harris <S.E.Harris@kent.ac.uk>,
	QEMU Developers <qemu-devel@nongnu.org>, A.M.King@kent.ac.uk
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yes

Sent from my cell phone, please ignore typos

On Mon, May 6, 2019, 6:11 PM Eric Blake <eblake@redhat.com> wrote:

> On 5/4/19 3:36 AM, Sarah Harris wrote:
> > Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> > ---
>
> > +++ b/qapi/common.json
> > @@ -187,7 +187,7 @@
> >  # Since: 3.0
> >  ##
> >  { 'enum' : 'SysEmuTarget',
> > -  'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
> > +  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'cris', 'hppa', 'i386',
> 'lm32',
> >               'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
> >               'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
> >               'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
>
> Missing documentation that the new 'avr' member is available only since
> 4.1.
>
> > diff --git a/target/avr/Makefile.objs b/target/avr/Makefile.objs
> > new file mode 100644
> > index 0000000000..41355dea1e
> > --- /dev/null
> > +++ b/target/avr/Makefile.objs
> > @@ -0,0 +1,23 @@
> > +#
> > +#  QEMU AVR CPU
> > +#
> > +#  Copyright (c) 2016 Michael Rolnik
>
> Do you want to also claim through 2019?
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
>
