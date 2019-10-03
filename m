Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AE6C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 19:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1AC22133F
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 19:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bsdimp-com.20150623.gappssmtp.com header.i=@bsdimp-com.20150623.gappssmtp.com header.b="BK3qew6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1AC22133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bsdimp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG7Ei-0004jN-Ib
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 15:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wlosh@bsdimp.com>) id 1iG6yV-0001an-8V
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 15:41:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wlosh@bsdimp.com>) id 1iG6yU-0001gW-1D
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 15:41:18 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:37649)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <wlosh@bsdimp.com>) id 1iG6yT-0001cX-Ky
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 15:41:17 -0400
Received: by mail-qk1-x744.google.com with SMTP id u184so3595667qkd.4
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 12:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W0U/0FJByIhU57LqBZog+bUqMIzARnTjs2te5TT4njU=;
 b=BK3qew6HkqBQ1d/K3rtzo9uUQYQoQzHDFL6xkW2kC/3+ApFmMpeChwOcFok3DD8F29
 Cfe5lm4CHvdZFwAStq+Wwsu0YhB/lxmCRT8MoiugKKhtvy4kBqi57/xvJL2C1ClP0V2r
 aEMyEhI9ucjpytMu1a4ZiHFimFFXR1CKLXWEbAs0X0H1194IyL24lkkld23mOKF1Iuhm
 L0QqJ1k6lzXFQbpEer06+kg/Jv09ptMbzNVJyRQIaCtUdR/6wLCBxkz2VQqGs+/i484v
 h1c+crH7AT2kWRPuQsEh5iB9MmcmNAZXMuXPIGxVVU/5iAdiQeM/8pPnn7lDGrAbSqIw
 lnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W0U/0FJByIhU57LqBZog+bUqMIzARnTjs2te5TT4njU=;
 b=Y4KICHhQ/KqTCGA6XDiMG+LNG05zKsvPWSgu4HQAFWwi5tsEnoLoen0URq/XRzhAb1
 IUR2KSaJV1vpyAsyLjXTinJydtTDqraDUWVd3ZJz6kYIvnqwMt+bwt6li34viug8F8df
 6chxT1JAKcaEzRVDMQT8TSwLSqE44UtWPPnfQL9E6PLBYmh710IQCtVpOkRQpgzOmX1h
 BGnPB96Hm65GVm8oihqMGe8OajpvTWucwu6utmV7yuc1i0FNj+PtA9mWQuq0bB7/m/2X
 eoNNVDg+maaq0aJyGYfQYH7+qjeqq0bjTtUXUI+dCeg+9vpmIGENdtl6Tw5BGM2yGUqv
 A9cw==
X-Gm-Message-State: APjAAAWyYhQDsqsoLOz2a0iPL7mnay7R/TnFNxJw2JdjRFc+2PzUxV4W
 9EdfrflTYcCWAHGduHWCXPgQwc7geGLJ38fehsrNLw==
X-Google-Smtp-Source: APXvYqxnJ+EV36g2BuJso+1NEOU8LNpw3eWKmFB5KstLWmuK2roJPb6BZwIEo3BD0eM2uidIHbcYueSCYdL+3uVtWes=
X-Received: by 2002:a05:620a:6af:: with SMTP id
 i15mr6144407qkh.380.1570131674784; 
 Thu, 03 Oct 2019 12:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAOx2=+fZ4O_=8jU+XfDvjKVt_=kNyyKEW0UL6jxZQ_qenF76FQ@mail.gmail.com>
 <20191003193255.GJ17916@kitsune.suse.cz>
In-Reply-To: <20191003193255.GJ17916@kitsune.suse.cz>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 3 Oct 2019 13:41:03 -0600
Message-ID: <CANCZdfrSNmnsW4YDRV3GYD9FCv+kjmB_Wos44ieiUQFGwNdk6Q@mail.gmail.com>
Subject: Re: QEMU user mode execve
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Content-Type: multipart/alternative; boundary="000000000000ba15b6059406c41d"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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
Cc: Mauricio Galindo <up.mauricio.g@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ba15b6059406c41d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2019 at 1:36 PM Michal Such=C3=A1nek <msuchanek@suse.de> wro=
te:

> On Thu, Oct 03, 2019 at 10:48:46AM -0700, Mauricio Galindo wrote:
> > Hi,
> >
> > I'm running QEMU in user mode and I'm running into issues when trying
> > to exec binaries within the emulated process given that binaries are
> > expected to run in the native architecture. Would it be useful to have
> > an option to rewrite execve(/bin/some_binary, ...) to
> > execve(qemu-$arch-static, [/bin/some_binary, ...], ...)?
> >
>
> This is handled in kernel by binfmt-misc.
>
> Debian has nice packaging for the required configuration. They use it to
> create non-native installation images.
>

FreeBSD also uses bsd-user (admittedly a much changed one from what's
upstream[*]) to build non-native packages. It uses the same binfmt stuff in
a chroot.

Warner

[*] I've rebased our work forward up through 3.1 release and hope to have
it rebased through the top of the tree shortly and have it ready for
upstreaming soon.

--000000000000ba15b6059406c41d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 3, 2019 at 1:36 PM Michal=
 Such=C3=A1nek &lt;<a href=3D"mailto:msuchanek@suse.de">msuchanek@suse.de</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 Thu, Oct 03, 2019 at 10:48:46AM -0700, Mauricio Galindo wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; I&#39;m running QEMU in user mode and I&#39;m running into issues when=
 trying<br>
&gt; to exec binaries within the emulated process given that binaries are<b=
r>
&gt; expected to run in the native architecture. Would it be useful to have=
<br>
&gt; an option to rewrite execve(/bin/some_binary, ...) to<br>
&gt; execve(qemu-$arch-static, [/bin/some_binary, ...], ...)?<br>
&gt; <br>
<br>
This is handled in kernel by binfmt-misc.<br>
<br>
Debian has nice packaging for the required configuration. They use it to<br=
>
create non-native installation images.<br></blockquote><div><br></div><div>=
FreeBSD also uses bsd-user (admittedly a much changed one from what&#39;s u=
pstream[*]) to build non-native packages. It uses the same binfmt stuff in =
a chroot.</div><div><br></div><div>Warner</div><div><br></div><div>[*] I&#3=
9;ve rebased our work forward up through 3.1 release and hope to have it re=
based through the top of the tree shortly and have it ready for upstreaming=
 soon.</div></div></div>

--000000000000ba15b6059406c41d--

