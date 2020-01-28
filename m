Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74236C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 20:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DED821739
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 20:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IejCXSKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DED821739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwXnn-0006Y9-DU
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 15:49:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iwXmw-00065x-Pk
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 15:48:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iwXmv-0000iR-58
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 15:48:46 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:38669)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iwXmu-0000h8-Tr
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 15:48:45 -0500
Received: by mail-ot1-x32b.google.com with SMTP id z9so13399585oth.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 12:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mSLoaoSWPqfbXLiOGbBGSmHyhnLx3sGmuBmdb4EWtHY=;
 b=IejCXSKmPZbRSRedgFwXeaPA55bSaJsadbMh9fWDrosO4aDQ48Qps2ufwyL74RRxEM
 ztfNhwOdPgd5WmT5LkZMMmDLV3pA+kflvmj38ShubXqgQkVIK+pOY8Au7vOJxHYa3H1w
 vHLb2+HkW9aj68DccCf7DbxOl95/79XVQpPrWqReNbbnQE3okTuOGDYAwFHo2WG2iU68
 eWuKJkOO+qSXulfMnm0O4aXoQMs7iBAyk5cyNlxR0x9Sa1LO9xfYxbDUrMPGBa3IZ//o
 WF/JpYrNvg/H0II8ESG+MIkK/0WTbw2zP683u1g5/0eeBuecU9jISSFzajAPPPdi1BYU
 MMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mSLoaoSWPqfbXLiOGbBGSmHyhnLx3sGmuBmdb4EWtHY=;
 b=OQNaCO1GG3ntdOUcIzQZBjy+ThLh3EzwZhPhy7NrGBKgdPE1QUxLluy3oru/2Vt1DY
 dCnKNgw+A9rEmwRxrKEXQPlD01eO00zR4xe6CfygRLwBoNts4wFpvOLC9BMML+mhkqL/
 8q5ZTJDreaM7An7r6wIdsrZwcdwrluuWO/5UHYLFjfQXfVzrAl/adPkodZ6LurYagzyG
 Lqosho6JIeGlYi6lY4TMFM3hALxb32KYXTdfStNP1QRF64emcBbreoikslPocizhZ9UW
 lRO75vdbwp/GqfG7TAPsiDKwxYplyMfwkdUMu7Vr1byETu/ILTtUtpSQtQ12R4XsqAnQ
 evlA==
X-Gm-Message-State: APjAAAVI0EtGXi1Qp7gKDMlHeVP8+jlZQvWWuMjeAdJ0VdJj0UeOIXqr
 INAPH85IWhG8wLsVW3DOuvbdKTuqF7WdqzSGfmE=
X-Google-Smtp-Source: APXvYqxjTw27ko+v3eGh1jz/PbjXUG8ajDt2g60zJt0yYjKZJx+yl23KqjbbUOFI+TJajB/CXptU3IsFsL9BSl4Nuy8=
X-Received: by 2002:a05:6830:12c3:: with SMTP id
 a3mr10127905otq.341.1580244524099; 
 Tue, 28 Jan 2020 12:48:44 -0800 (PST)
MIME-Version: 1.0
References: <CAL1e-=j5WJkV=X+KkfBuS3pjf6z3aJrtu4xpYeVbjEUYiWxxTQ@mail.gmail.com>
 <CAFEAcA8E9s2wZWVxanUDXu=5qcjn6XY5_6t8vUO+LjuJnA7nOQ@mail.gmail.com>
 <CAL1e-=j=nVJd9Q3JmZsimgSPy=noYhqE8hz4r5RjwgTPw9WwuA@mail.gmail.com>
 <CAFEAcA_FbFub4_z+e0YPMT8UTbm1SWmfovkKnLKODvMZMfGa+A@mail.gmail.com>
In-Reply-To: <CAFEAcA_FbFub4_z+e0YPMT8UTbm1SWmfovkKnLKODvMZMfGa+A@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 28 Jan 2020 21:48:33 +0100
Message-ID: <CAL1e-=jMnEpOw+fOqGfY2+uiUTYr0zgnMZxpVUK2Y=PA3YAFMQ@mail.gmail.com>
Subject: Re: [GSoC/Outreachy QEMU proposal] Extend support for ioctls in QEMU
 linux-user mode
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000846adf059d39599c"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
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
Cc: Laurent Vivier <laurent@vivier.eu>, Stefan Hajnoczi <stefanha@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000846adf059d39599c
Content-Type: text/plain; charset="UTF-8"

On Tue, Jan 28, 2020 at 7:00 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Tue, 28 Jan 2020 at 17:51, Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
> >
> > I am personally interested in both. However, learning about syscalls and
> implementation of support for them in QEMU would require more ramp-up time
> from student (as is the case for any new employee in a similar situation
> for that matter). In the worst case, the student would spend much more time
> on learning than on productive work. My impression is at it is better to
> leave the student focused on just one area - ioctl support.
>
> I think they're about the same, really. The level of difficulty is more
> in what the syscall or ioctl does and what its arguments are (ie does
> QEMU have to do much mangling on the way past) rather than whether
> it happens to be a syscall or an ioctl. Some syscalls are hard, but
> some are trivial; same with ioctls.
>
> thanks
> -- PMM
>


How about this:

- I removed the first item (a) of PART I (since I already have an idea how
to do this in, I think, a very good way), to free the student time. I will
send my solution to the list before this summer, I hope.
- I amended all parts to include some syscall-related activities - and the
end result is this:


*Extend support for ioctls and syscalls in QEMU linux-user mode*



*PLANNED ACTIVITIES*

BACKGROUND

There are currently 2500+ ioctls defined in Linux kernel. QEMU linux-user
currently supports only several hundred. There is a constant need for
expanding ioctl support in QEMU. Users use Linux-user mode in variety of
setups (for example, building and testing tools and applications under
chroot environment), and, on a regular basis, efforts by multiple people
are made to fill in missing support.

Regarding syscall support in QEMU linux-user, the coverage is much better
than in case of ioctls. However, kernel syscall interface continuously
develops and grows, and QEMU linux-user support usually lags considerably.
The support for new syscalls is usually left unimplemented, until an end
user reports that it is missing in hers/his usage scenario.

In conclusion, the efforts for supporting ioctls and syscalls in QEMU have
usually been done on a piece-by-piece basis, in a limited way covering a
particular need. This project will take more proactive stance, and try to
improve QEMU before users start complaining.

This contributions of this project will be mostly to QEMU, but some parts
would be also contirbutions to LTP (Linux Test Project).

PART I:

   a) Add strace support for printing the third argument of ioctl() (be it
int, string, structure or array) - limited to selected ioctls that are
frequently used.
   b) Add strace support for printing the arguments of selected syscalls
that are frequently used, and not covered in QEMU strace module so far.

PART II:

   a) Amend support for existing groups of ioctls that are not completed
100% (let's say, filesystem ioctls)
   b) Add support for a selected group of ioctls that are not currently
supported (for example, DM ioctls, Bluetooth ioctls, or Radeon DRM ioctls)
   c) Add support for a selected group of syscalls that were recently
introduced in kernel.

PART III:

  a) Within LTP (Linux Test Project), develop unit tests for selected
ioctls that are supported in QEMU (including some whose support is
developed in PART II).
  b) Within LTP (Linux Test Project), develop unit tests for selected
syscalls that are supported in QEMU (including some whose support is
developed in PART II).



*DELIVERABLES*

The deliverables are in the form of source code for each part, intended to
be upstreamed to either QEMU or LTP open source projects. The time needed
for upstreaming (addressing reviews, etc.) process is included into this
project. The delivery of results can and should be distributed over larger
period of time (2-3 months).


Mentor: open (I propose Laurent Vivier)
Student: open

--000000000000846adf059d39599c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 28, 2020 at 7:00 PM Peter=
 Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@lina=
ro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Tue, 28 Jan 2020 at 17:51, Aleksandar Markovic<br>
&lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com" target=3D"_blank">aleksa=
ndar.m.mail@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; I am personally interested in both. However, learning about syscalls a=
nd implementation of support for them in QEMU would require more ramp-up ti=
me from student (as is the case for any new employee in a similar situation=
 for that matter). In the worst case, the student would spend much more tim=
e on learning than on productive work. My impression is at it is better to =
leave the student focused on just one area - ioctl support.<br>
<br>
I think they&#39;re about the same, really. The level of difficulty is more=
<br>
in what the syscall or ioctl does and what its arguments are (ie does<br>
QEMU have to do much mangling on the way past) rather than whether<br>
it happens to be a syscall or an ioctl. Some syscalls are hard, but<br>
some are trivial; same with ioctls.<br>
<br>
thanks<br>
-- PMM<br></blockquote><div><br></div><div><br></div><div>How about this:</=
div><div><br></div><div>- I removed the first item (a) of PART I (since I a=
lready have an idea how to do this in, I think, a very good way), to free t=
he student time. I will send my solution to the list before this summer, I =
hope.</div><div>- I amended all parts to include some syscall-related activ=
ities - and the end result is this:<br></div><div><br></div><div><br></div>=
<div><font size=3D"4"><b>Extend support for ioctls and syscalls in QEMU lin=
ux-user mode</b></font><br><br><br><i><font size=3D"4">PLANNED ACTIVITIES<b=
r></font></i><div><br></div><div>BACKGROUND<br></div><div><br></div><div><d=
iv>There are currently 2500+ ioctls defined in Linux kernel. QEMU linux-use=
r currently supports only several hundred. <span id=3D"gmail-m_518906191680=
3565985gmail-messageContent"></span><span id=3D"gmail-m_5189061916803565985=
gmail-messageContent">There
 is a constant need for expanding ioctl support in QEMU. Users use=20
Linux-user mode in variety of setups (for example, building and testing=20
tools and applications under chroot environment), and, on a regular=20
basis, efforts by multiple people are made to fill in missing support.</spa=
n></div><div><span id=3D"gmail-m_5189061916803565985gmail-messageContent"><=
br></span></div><div><span id=3D"gmail-m_5189061916803565985gmail-messageCo=
ntent">Regarding syscall support in QEMU linux-user, the coverage is much b=
etter than in case of ioctls. However, kernel syscall interface continuousl=
y develops and grows, and QEMU linux-user support usually lags considerably=
. The support for new syscalls is usually left unimplemented, until an end =
user reports that it is missing in hers/his usage scenario.<br></span></div=
><div><span id=3D"gmail-m_5189061916803565985gmail-messageContent"><br></sp=
an></div><div><span id=3D"gmail-m_5189061916803565985gmail-messageContent">=
In conclusion, the efforts for supporting ioctls and syscalls in QEMU have =
usually been done on a piece-by-piece basis, in a=20
limited way covering a particular need. This=20
project will take more proactive stance, and try to improve QEMU before=20
users start complaining.</span></div><div><br><span id=3D"gmail-m_518906191=
6803565985gmail-messageContent"></span></div><div>This contributions of thi=
s project will be mostly to QEMU, but some parts would be also contirbution=
s to LTP (Linux Test Project).<br></div><div><span id=3D"gmail-m_5189061916=
803565985gmail-messageContent"></span><span id=3D"gmail-m_51890619168035659=
85gmail-messageContent"></span></div></div><div><br></div><span id=3D"gmail=
-m_5189061916803565985gmail-messageContent">PART I:<br><br>=C2=A0=C2=A0 a) =
Add strace support for printing the third argument of ioctl() (be it
 int, string, structure or array) - limited to selected ioctls that are=20
frequently used.<br>=C2=A0=C2=A0
 b) Add strace support for printing the arguments of selected syscalls that=
 are=20
frequently used, and not covered in QEMU strace module so far.<br><br>PART =
II:<br><br>=C2=A0=C2=A0 a) Amend support for existing groups of ioctls that=
 are not completed 100% (let&#39;s say, filesystem ioctls)<br>=C2=A0=C2=A0
 b) Add support for a selected group of ioctls that are not currently=20
supported (for example, DM ioctls, Bluetooth ioctls, or Radeon DRM ioctls)<=
br>=C2=A0=C2=A0 c) Add support for a selected group of syscalls that were r=
ecently introduced in kernel.<br><br>PART III:<br><br></span><div><span id=
=3D"gmail-m_5189061916803565985gmail-messageContent">=C2=A0 a) Within LTP (=
Linux Test Project), develop unit tests for selected ioctls that are suppor=
ted in QEMU (including some whose support is developed in PART II).</span><=
/div><div><div><span id=3D"gmail-m_5189061916803565985gmail-messageContent"=
>=C2=A0 b) Within LTP (Linux Test Project), develop unit tests for selected=
 syscalls that are supported in QEMU (including some whose support is devel=
oped in PART II).</span></div><div><span id=3D"gmail-m_5189061916803565985g=
mail-messageContent"><br></span></div><span id=3D"gmail-m_51890619168035659=
85gmail-messageContent"></span></div><div><span id=3D"gmail-m_5189061916803=
565985gmail-messageContent"><br></span></div><i><font size=3D"4">DELIVERABL=
ES<br></font></i><div><br></div><div>The
 deliverables are in the form of source code for each part, intended to=20
be upstreamed to either QEMU or LTP open source projects. The time needed f=
or upstreaming (addressing reviews,=20
etc.) process is included into this project.<span id=3D"gmail-m_51890619168=
03565985gmail-messageContent"> The delivery of results can and should be di=
stributed over larger period of time (2-3 months).<br></span></div><div><sp=
an id=3D"gmail-m_5189061916803565985gmail-messageContent"><br></span></div>=
<div><br></div><div>Mentor: open (I propose Laurent Vivier)<br></div>Studen=
t: open <br></div></div></div>

--000000000000846adf059d39599c--

