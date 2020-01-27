Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF314C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 16:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A44120720
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 16:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlDNmdwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A44120720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw7J9-0006xR-NL
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 11:32:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iw7I8-0006Xu-EE
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:31:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iw7I6-0002pw-S3
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:31:12 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:42344)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iw7I6-0002p7-MI
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:31:10 -0500
Received: by mail-ot1-x329.google.com with SMTP id 66so8937393otd.9
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 08:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=S+IVAjk2ZSyg/FZRManzLWTqlGH1noOi1mK2FlXDH14=;
 b=FlDNmdwekn6ZlUGkKJUWncywIhtCMnfEISIqr2FqNVF+Qq6TB9rsmHdz8ZkJGmXFPi
 OIIKY2qQqyuzN0TcN3pQhTnmE7hnSPq4tEHzLkujIreapJ7ZjDOSyAU5ChecLTtahVSz
 2CJ8qvIBKJrupT0RGGv0G9r56mIZUzUvNZp8dvln5QZHC5NlLGcOlsycIwASSJD+qiNd
 EfdOmgZlVLzjTFAxJ3e2Kfq+mExYHNkkdq0aTRuF0M27BUJAxQZHU2SPK5L6eO1JPCuH
 +ie//QMuOxb/tVojf5fkWov4YKavGCznGA6Sukc+BvqJW68bF0RJAd//gfNXJs6VUIq9
 Gt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S+IVAjk2ZSyg/FZRManzLWTqlGH1noOi1mK2FlXDH14=;
 b=Vr77KcU5+yU2p14irmekdiVZj7NMFW0YDizBtnsHDUdAd2m/01iSE5pMaNDY0ULv7a
 1FdxaZEG/TtrFOTn9WU9Ug4bSIGQWfJYiCfWIj3Jms6ZmygdxNKQA6nHzoMggAXczGHv
 aK/31t8GCMvS5yxuYsEAWgCTjES1R5feOc+GdPqdLviNcbvLXOOtwNU7shRLhSWhe5JX
 ewuta7xoqmUMMrgfyXFdFxffxQqdhM4eI6XpYaEbonBWb9HtWeFuKV0XXyWPdn4zV7MD
 WC0/cSt6bxUdgZdf4jEyvigiwD7KluKXewDP5h/7ebfqTb2Ay8qPPEn70BlLrOx32S5z
 Dsrg==
X-Gm-Message-State: APjAAAVPbQU5Nybm32CnDOdKiJgzPrppEJqsqfzzkHQd+PH6ch+VSkXm
 Q9IAFntwYOW9X164q/UZZvZA14WpGtRrFDEkg/s=
X-Google-Smtp-Source: APXvYqx0SHjDJ5CGSW9l63OFPMv9ReAW+LbEr4ogNFd6TRqcL9e5ve4idZULJ2sfzn/iyf+lNsgbpHOcg/GPt/6mo7o=
X-Received: by 2002:a05:6830:1042:: with SMTP id
 b2mr13004374otp.306.1580142669539; 
 Mon, 27 Jan 2020 08:31:09 -0800 (PST)
MIME-Version: 1.0
References: <CAL1e-=j5WJkV=X+KkfBuS3pjf6z3aJrtu4xpYeVbjEUYiWxxTQ@mail.gmail.com>
 <20200127093004.GA18565@stefanha-x1.localdomain>
In-Reply-To: <20200127093004.GA18565@stefanha-x1.localdomain>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 27 Jan 2020 17:30:58 +0100
Message-ID: <CAL1e-=h+g4FWVDVe6a4T_X_nEA-catKd+7LiKXx++qS+G7mqOQ@mail.gmail.com>
Subject: Re: [GSoC/Outreachy QEMU proposal] Extend support for ioctls in QEMU
 linux-user mode
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000838241059d21a249"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
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
Cc: Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000838241059d21a249
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 27, 2020 at 10:30 AM Stefan Hajnoczi <stefanha@redhat.com>
wrote:
>
> On Thu, Jan 23, 2020 at 02:34:01PM +0100, Aleksandar Markovic wrote:
> > *Extend support for ioctls in QEMU linux-user mode*
> >
> >
> >
> > *PLANNED ACTIVITIES*
> >
> > BACKGROUND
> >
> > There is currently 2500+ ioctls defined in Linux kernel. QEMU linux-user
> > currently supports only several hundred. There is a constant need for
> > expanding ioctl support in QEMU. Users use Linux-user mode in variety of
> > setups (for example, building and testing tools and applications under
> > chroot environment), and, on a regular basis, efforts by multiple people
> > are made to fill in missing support. However, these efforts have been
> > usually done on a piece-by-piece basis, i a limited way covering a
>
> s/ i / in /
>
> > partucular need. This project will take more proactive stance, and try
to
>
> s/partucular/particular/
>
> > improve QEMU before users start complaining.
> >
> > PART I:
> >
> >    a) Add strace support for outputing ioctl IDs (the second argument of
> > ioctl()) as strings rather than numbers - for all platform independant
> > ioctls.
> >    b) Add strace support for printing the third argument of ioctl() (be
it
> > int, string, structure or array) - limited to selected ioctls that are
> > frequently used.
> >
> > PART II:
> >
> >    a) Amend support for existing groups of ioctls that are not completed
> > 100% (let's say, filesystem ioctls)
> >    b) Add support for a selected group of ioctls that are not currently
> > supported (for example, dm ioctls, Bluetooth ioctls, or Radeon DRM
ioctls)
> >
> > PART III:
> >
> >   a) Develop unit tests for selected ioctls that are already supported
in
> > QEMU.
> >
> >
> > *DELIVERABLES*
> >
> > The deliverables are in the form of source code for each part, intended
to
> > be upstreamed, and time needed for upstreaming (addressing reviews,
etc.)
> > process is included int this project.
> >
> > The delivery of results can and should be distributed over larger
period of
> > time 2-3 months.
>
> Good project idea.  Please choose concrete ioctls.  Applicants may not
> have the necessary experience to choose a set of ioctls that are useful.
>

PART I should not be that difficult. PART II is, however, a minefield. An
implementation of support of a ioctl range from 15 minutes to two months.
The least we wont to happen is that the student is stuck with a problem for
months. Therefore I suggest first some "low hanging fruit" for a student to
get self-confidence and experience. One such group is DM ioctl group ( link
<https://github.com/torvalds/linux/blob/master/include/uapi/linux/dm-ioctl.h#L251>
) (Laurent may confirm, or "unconfirm" that). The next shoudl be something
a little harder, but useful in terms of end user. PART III should be
developed on the fly, but we need to provide a guideline/framework prior to
starting working with a student, IMHO..

> I wonder if it's possible to use something like the Debian popularity
> contest (https://popcon.debian.org/) and then scan the source of the
> most popular N packages for ioctl() calls.

Great! I'll try. A very interesting site and method.

Aleksandar

>  Maybe this is overthinking
> it, but it would give an idea of which ioctl() calls are relevant and
> missing from QEMU.
>
> Stefan

--000000000000838241059d21a249
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, Jan 27, 2020 at 10:30 AM Stefan Hajnoczi &=
lt;<a href=3D"mailto:stefanha@redhat.com">stefanha@redhat.com</a>&gt; wrote=
:<br>&gt;<br>&gt; On Thu, Jan 23, 2020 at 02:34:01PM +0100, Aleksandar Mark=
ovic wrote:<br>&gt; &gt; *Extend support for ioctls in QEMU linux-user mode=
*<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; *PLANNED ACTIVITIES*<=
br>&gt; &gt;<br>&gt; &gt; BACKGROUND<br>&gt; &gt;<br>&gt; &gt; There is cur=
rently 2500+ ioctls defined in Linux kernel. QEMU linux-user<br>&gt; &gt; c=
urrently supports only several hundred. There is a constant need for<br>&gt=
; &gt; expanding ioctl support in QEMU. Users use Linux-user mode in variet=
y of<br>&gt; &gt; setups (for example, building and testing tools and appli=
cations under<br>&gt; &gt; chroot environment), and, on a regular basis, ef=
forts by multiple people<br>&gt; &gt; are made to fill in missing support. =
However, these efforts have been<br>&gt; &gt; usually done on a piece-by-pi=
ece basis, i a limited way covering a<br>&gt;<br>&gt; s/ i / in /<br>&gt;<b=
r>&gt; &gt; partucular need. This project will take more proactive stance, =
and try to<br>&gt;<br>&gt; s/partucular/particular/<br>&gt;<br>&gt; &gt; im=
prove QEMU before users start complaining.<br>&gt; &gt;<br>&gt; &gt; PART I=
:<br>&gt; &gt;<br>&gt; &gt; =C2=A0 =C2=A0a) Add strace support for outputin=
g ioctl IDs (the second argument of<br>&gt; &gt; ioctl()) as strings rather=
 than numbers - for all platform independant<br>&gt; &gt; ioctls.<br>&gt; &=
gt; =C2=A0 =C2=A0b) Add strace support for printing the third argument of i=
octl() (be it<br>&gt; &gt; int, string, structure or array) - limited to se=
lected ioctls that are<br>&gt; &gt; frequently used.<br>&gt; &gt;<br>&gt; &=
gt; PART II:<br>&gt; &gt;<br>&gt; &gt; =C2=A0 =C2=A0a) Amend support for ex=
isting groups of ioctls that are not completed<br>&gt; &gt; 100% (let&#39;s=
 say, filesystem ioctls)<br>&gt; &gt; =C2=A0 =C2=A0b) Add support for a sel=
ected group of ioctls that are not currently<br>&gt; &gt; supported (for ex=
ample, dm ioctls, Bluetooth ioctls, or Radeon DRM ioctls)<br>&gt; &gt;<br>&=
gt; &gt; PART III:<br>&gt; &gt;<br>&gt; &gt; =C2=A0 a) Develop unit tests f=
or selected ioctls that are already supported in<br>&gt; &gt; QEMU.<br>&gt;=
 &gt;<br>&gt; &gt;<br>&gt; &gt; *DELIVERABLES*<br>&gt; &gt;<br>&gt; &gt; Th=
e deliverables are in the form of source code for each part, intended to<br=
>&gt; &gt; be upstreamed, and time needed for upstreaming (addressing revie=
ws, etc.)<br>&gt; &gt; process is included int this project.<br>&gt; &gt;<b=
r>&gt; &gt; The delivery of results can and should be distributed over larg=
er period of<br>&gt; &gt; time 2-3 months.<br>&gt;<br>&gt; Good project ide=
a.=C2=A0 Please choose concrete ioctls.=C2=A0 Applicants may not<br>&gt; ha=
ve the necessary experience to choose a set of ioctls that are useful.<br>&=
gt;<div><br></div><div>PART I should not be that difficult. PART II is, how=
ever, a minefield. An implementation of support of a ioctl range from 15 mi=
nutes to two months. The least we wont to happen is that the student is stu=
ck with a problem for months. Therefore I suggest first some &quot;low hang=
ing fruit&quot; for a student to get self-confidence and experience. One su=
ch group is DM ioctl group (=C2=A0<a href=3D"https://github.com/torvalds/li=
nux/blob/master/include/uapi/linux/dm-ioctl.h#L251">link</a> ) (Laurent may=
 confirm, or &quot;unconfirm&quot; that). The next shoudl be something a li=
ttle harder, but useful in terms of end user. PART III should be developed =
on the fly, but we need to provide a guideline/framework prior to starting =
working with a student, IMHO..</div><div><br>&gt; I wonder if it&#39;s poss=
ible to use something like the Debian popularity<br>&gt; contest (<a href=
=3D"https://popcon.debian.org/">https://popcon.debian.org/</a>) and then sc=
an the source of the<br>&gt; most popular N packages for ioctl() calls.<div=
><br></div><div>Great! I&#39;ll try. A very interesting site and method.</d=
iv><div><br></div><div>Aleksandar</div><div><br></div><div>&gt;=C2=A0 Maybe=
 this is overthinking<br>&gt; it, but it would give an idea of which ioctl(=
) calls are relevant and<br>&gt; missing from QEMU.<br>&gt;<br>&gt; Stefan<=
/div></div></div>

--000000000000838241059d21a249--

