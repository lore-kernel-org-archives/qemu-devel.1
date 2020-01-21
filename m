Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60E0C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 22:24:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F06824653
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 22:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rQhkd2Dp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F06824653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu1wa-0006hA-J3
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 17:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iu1uu-0005Ju-LC
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 17:22:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iu1ut-0000Gc-6f
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 17:22:36 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37599)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iu1ut-0000Fh-0A
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 17:22:35 -0500
Received: by mail-ot1-x343.google.com with SMTP id k14so4494897otn.4
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 14:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gtPJPpZ/G+RTGquxqMzRb2RbpHB4Wyopzjf+jDiRTsI=;
 b=rQhkd2Dpu1+nJ1HMNtYg+4q2a/RJuogqPpxxgMa4WZyrhlfDTwgb6y0T+psG77OZNv
 fUNpWOnZ+hLsFXx4aebj0I6A6BSShu0IE+7AhobpWPqJzOjSk+BqaxoaBCEnojUK34oY
 qZ74ylk8vScoDDabWySuwJX7shqOqPEipsktaFkwWlDSlnBRtoRBw1OCXoTX/Y58dX+L
 o0ZkHoey1MELU9KVaHJbL99DgIfanvG5+prtmWxMqe5ZbtR1qSvBcv9iR815H7L38tsC
 wR6HS3cbLBF+LqNQjTTwGSO9TG0BRk0vW33YOvcRtgNe+1n/jm5ryKzXz5/J8GInWAZM
 pfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gtPJPpZ/G+RTGquxqMzRb2RbpHB4Wyopzjf+jDiRTsI=;
 b=mGsBn/6Yl1zsY/2xwi0DqVrukYXt85piX7JgGKhMWZM0qE0GS+hOKTlRVttcnK55WM
 os40ybqQclX++6f/BZsyW+rQKzcWi0B0sSnj0TvX2AdtKLFT5Vy/YCXJKQLrSiNT4RkI
 SiJtMx5MS/UOGa9c3Ym+TSrT+qtyv1o86HM14AjN51xOGq4G8jNisBGI3/+0J6Ochxcw
 QRtef9jwcvyVEUeDf0VSdxR0TNg3IFI4ohECjCk6G/woEJqetnMHONZ5y44/qlUi5DMY
 cAuEDoTPLoa3ly4AmyfGv57ZLbZaCnlTJW/LhkyoRSASTilPS6YKA9o22v7+UMl2MiMF
 eB/Q==
X-Gm-Message-State: APjAAAXqYTGHZe14IVLdyXTi7aim8pZu53/BrHjr70RUbRY8BzCqMR87
 Li4bYwcm5alvxOarWiMOY1DEChic6LzKEihualaAPQ==
X-Google-Smtp-Source: APXvYqyzK++ocqsgjYIBPQ9eVuSgxOcRcftbYMLKnJiv/D8G9pcgqMnZY8rJIVfQV+0qI99hNFxfTQ/J88DwISr8KIE=
X-Received: by 2002:a05:6830:1586:: with SMTP id
 i6mr4986968otr.221.1579645354143; 
 Tue, 21 Jan 2020 14:22:34 -0800 (PST)
MIME-Version: 1.0
References: <20200121191033.28195-1-peter.maydell@linaro.org>
 <20200121191033.28195-3-peter.maydell@linaro.org>
 <5fa9a519-d9c8-13b6-2d38-efa12c29780d@linaro.org>
In-Reply-To: <5fa9a519-d9c8-13b6-2d38-efa12c29780d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jan 2020 22:22:22 +0000
Message-ID: <CAFEAcA9ty4srYsjbGDEQshttcA97yFco=7fLGV8SV2oT7FeQ+A@mail.gmail.com>
Subject: Re: [PATCH 2/5] docs/sphinx: Add new hxtool Sphinx extension
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jan 2020 at 21:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 1/21/20 9:10 AM, Peter Maydell wrote:
> > Some of our documentation includes sections which are created
> > by assembling fragments of texinfo from a .hx source file into
> > a .texi file, which is then included from qemu-doc.texi or
> > qemu-img.texi.
> >
> > For Sphinx, rather than creating a file to include, the most natural
> > way to handle this is to have a small custom Sphinx extension which
> > reads the .hx file and process it.  So instead of:
> >  * makefile produces foo.texi from foo.hx
> >  * qemu-doc.texi says '@include foo.texi'
> > we have:
> >  * qemu-doc.rst says 'hxtool-doc:: foo.hx'
> >  * the Sphinx extension for hxtool has code that runs to handle that
> >    Sphinx directive which reads the .hx file and emits the appropriate
> >    documentation contents
> >
> > This is pretty much the same way the kerneldoc extension works right
> > now. It also has the advantage that it should work for third-party
> > services like readthedocs that expect to build the docs directly with
> > sphinx rather than by invoking our makefiles.
> >
> > In this commit we implement the hxtool extension.
> >
> > Note that syntax errors in the rST fragments will be correctly
> > reported to the user with the filename and line number within the
> > hx file.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> This doesn't seem to work for me.
>
> make[1]: Leaving directory '/home/rth/qemu/qemu/slirp'
> CONFDIR="/home/rth/qemu/run/etc/qemu" sphinx-build  -W -b html -D
> version=4.2.50 -D release="4.2.50 (rth)" -d .doctrees/devel-html
> /home/rth/qemu/qemu/docs/devel docs/devel
> Running Sphinx v1.8.5
>
> Extension error:
> Could not import extension hxtool (exception: cannot import name ExtensionError)
> make: *** [Makefile:1022: docs/devel/index.html] Error 2

I suspect this is an incompatibility (or possibly just a
dropped back-compatibility I was accidentally relying on)
between Sphinx 1.7 and 1.8. (I tested with a 1.6 and a 1.7.)

It looks like ExtensionError is now in sphinx.errors, so if you
change
+from sphinx.application import ExtensionError

to "from sphinx.errors import ExtensionError" does that help?

If so then I'll test later this week whether that works also
for 1.7/1.6 or if we need to do some version-specific stuff.

thanks
-- PMM

