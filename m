Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF13FC33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:11:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D4B2206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5N3jqSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4B2206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix7jH-00005j-Oo
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 06:11:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ix7iR-0007wc-0e
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:10:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ix7iP-0003IB-9X
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:10:30 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:35167)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ix7iP-0003Eq-49
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:10:29 -0500
Received: by mail-ot1-x32a.google.com with SMTP id r16so2765939otd.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 03:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=hILwTa1kR7FIelhQHoOOYJ/K56cY3MRNdxz/LM7WgZ8=;
 b=l5N3jqSusnt5w36ADh7eEz+UJxY8ab6xTWVrydf4JKHdvqAl/b53gKVSsq9FK2jOPr
 xYsQWid4APqzSDAEs2feGvID7Ek+854Z/Dwpz4sxrXxFIPNy9ANtYDdH3AXbVMJS9y9b
 oG4jxO0kmyW6vGQDT5o1DZg6GfkTQJ6u5sF4/ufBdJaHdwwcBQpsD5eZrXlxLcjMngJs
 ZUrtZ6uSglnOzQxlOtlCoeGdE3lUvn3FJy7wqc1LFwEUPunL9rch82tajdqBcVynigSF
 t99rpsZi4q0H/lM7ingoymV0MGCmgzQyQNJVawQhFK3Jyilgjq0BunvFI55hqn0olBPJ
 2jVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=hILwTa1kR7FIelhQHoOOYJ/K56cY3MRNdxz/LM7WgZ8=;
 b=Ffy0267/V2pEbadAaYcECbwMs8bbZAAvWM5avR6Nr5RgeAzmnY71k7miDoAPPFowZd
 APzx05iKQeHlYZD34GcERuZDmDq5aS+pqgOng5nFM08TuqBOhIyqlBUELnhgSz2VQ+6I
 oeSCOUOUx0pVeZYP53s+98ypukz2CUDJ26A1qwr+0YQAWHLnSRRQKQgvPkkCHpTA4Ppr
 n9ZmTkD5p+Za6w0P+Z9uT1EFRY1mKMiy9z2bakV09HSNNgzV2wB1oDk65mcIrcFL9mFA
 72JNuEs11/Vh5zr1N9Lje3RAhyxUoU7S9cfiktgVOWEUefdVP8YzBrm28TRFXWwBbeL0
 2iqA==
X-Gm-Message-State: APjAAAXlg3KhslQqd2NAYX6OALbhFmQvD1H5Ttj0zI318FAjnQf47BRi
 tw0o932L7N/3KPJMdXh8WIXc2FeVNmF+l5rDZSg=
X-Google-Smtp-Source: APXvYqxOd+lzTjTth+nmywkNLT7h0Ys8wVEQIjQiWsZoSpT727KU5/rCpZZLIFTduscd8bwqNu8S91KOLHDa1bpKpFg=
X-Received: by 2002:a9d:831:: with SMTP id 46mr3157984oty.295.1580382627288;
 Thu, 30 Jan 2020 03:10:27 -0800 (PST)
MIME-Version: 1.0
References: <CAL1e-=j5WJkV=X+KkfBuS3pjf6z3aJrtu4xpYeVbjEUYiWxxTQ@mail.gmail.com>
In-Reply-To: <CAL1e-=j5WJkV=X+KkfBuS3pjf6z3aJrtu4xpYeVbjEUYiWxxTQ@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 30 Jan 2020 12:09:58 +0100
Message-ID: <CAL1e-=ghxDLcU3iqkZ8q_sbk_DyR70t2a-jFtoNDVa7iTkMXsQ@mail.gmail.com>
Subject: Re: [GSoC/Outreachy QEMU proposal] Extend support for ioctls in QEMU
 linux-user mode
To: Laurent Vivier <laurent@vivier.eu>, Stefan Hajnoczi <stefanha@redhat.com>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000001bd91d059d5981e7"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32a
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001bd91d059d5981e7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

14:34 =C4=8Cet, 23.01.2020. Aleksandar Markovic <aleksandar.m.mail@gmail.co=
m> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Extend support for ioctls in QEMU linux-user mode
>
>
> PLANNED ACTIVITIES
>
> BACKGROUND
>
> There is currently 2500+ ioctls defined in Linux kernel. QEMU linux-user
currently supports only several hundred. There is a constant need for
expanding ioctl support in QEMU. Users use Linux-user mode in variety of
setups (for example, building and testing tools and applications under
chroot environment), and, on a regular basis, efforts by multiple people
are made to fill in missing support. However, these efforts have been
usually done on a piece-by-piece basis, i a limited way covering a
partucular need. This project will take more proactive stance, and try to
improve QEMU before users start complaining.
>
> PART I:
>
>    a) Add strace support for outputing ioctl IDs (the second argument of
ioctl()) as strings rather than numbers - for all platform independant
ioctls.
>    b) Add strace support for printing the third argument of ioctl() (be
it int, string, structure or array) - limited to selected ioctls that are
frequently used.
>
> PART II:
>
>    a) Amend support for existing groups of ioctls that are not completed
100% (let's say, filesystem ioctls)
>    b) Add support for a selected group of ioctls that are not currently
supported (for example, dm ioctls, Bluetooth ioctls, or Radeon DRM ioctls)
>
> PART III:
>
>   a) Develop unit tests for selected ioctls that are already supported in
QEMU.
>
> DELIVERABLES
>
> The deliverables are in the form of source code for each part, intended
to be upstreamed, and time needed for upstreaming (addressing reviews,
etc.) process is included int this project.
>
> The delivery of results can and should be distributed over larger period
of time 2-3 months.
>
>
> Montor: open (I propose Laurent Vivier)
>
> Student: open

Hello, Peter, Laurent, Stefan.

I presented in this thread two variants of a potential linux-user-related
project for GSoC/Outreachy. The first variant is more focused on a
particular area (ioctl support), while the second one covers wider set of
current issues within linux-user. The pros and cons of both should be
carefully assesed. I will leave to Peter and Laurent the final judgement if
we want to go or not with this project and also the final formulation of
the project.

Stefan, there was an idea in this thread that this project contributes
(apart to QEMU) to another ooen source project (LTP). In my layman view,
this is an advantage. But, how does that fit into GSoC/Outreachy rules?

Laurent, all this seems to be dependant on whether you are ready to mentor
the project. Are you?

The deadline for submitting GSoC/Outreachy projects (within QEMU) is just
around the corner (Feb 1). I leave to Laurent or Peter (should they give
"go" to this proposal) to officially submit the project on our wiki page
created for that purpose, in the form they deem the best.

Thanks to everyone for expressing the interest in this topic, and
especially coming up with additional ideas!

Truly yours,
Aleksandar

--0000000000001bd91d059d5981e7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">14:34 =C4=8Cet, 23.01.2020. Aleksandar Markovic &lt;<a href=
=3D"mailto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.com</a>&gt;=
 =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; Extend support for ioctls in QEMU linux-user mode<br>
&gt;<br>
&gt;<br>
&gt; PLANNED ACTIVITIES<br>
&gt;<br>
&gt; BACKGROUND<br>
&gt;<br>
&gt; There is currently 2500+ ioctls defined in Linux kernel. QEMU linux-us=
er currently supports only several hundred. There is a constant need for ex=
panding ioctl support in QEMU. Users use Linux-user mode in variety of setu=
ps (for example, building and testing tools and applications under chroot e=
nvironment), and, on a regular basis, efforts by multiple people are made t=
o fill in missing support. However, these efforts have been usually done on=
 a piece-by-piece basis, i a limited way covering a partucular need. This p=
roject will take more proactive stance, and try to improve QEMU before user=
s start complaining.<br>
&gt;<br>
&gt; PART I:<br>
&gt;<br>
&gt; =C2=A0=C2=A0 a) Add strace support for outputing ioctl IDs (the second=
 argument of ioctl()) as strings rather than numbers - for all platform ind=
ependant ioctls.<br>
&gt; =C2=A0=C2=A0 b) Add strace support for printing the third argument of =
ioctl() (be it int, string, structure or array) - limited to selected ioctl=
s that are frequently used.<br>
&gt;<br>
&gt; PART II:<br>
&gt;<br>
&gt; =C2=A0=C2=A0 a) Amend support for existing groups of ioctls that are n=
ot completed 100% (let&#39;s say, filesystem ioctls)<br>
&gt; =C2=A0=C2=A0 b) Add support for a selected group of ioctls that are no=
t currently supported (for example, dm ioctls, Bluetooth ioctls, or Radeon =
DRM ioctls)<br>
&gt;<br>
&gt; PART III:<br>
&gt;<br>
&gt; =C2=A0 a) Develop unit tests for selected ioctls that are already supp=
orted in QEMU.<br>
&gt;<br>
&gt; DELIVERABLES<br>
&gt;<br>
&gt; The deliverables are in the form of source code for each part, intende=
d to be upstreamed, and time needed for upstreaming (addressing reviews, et=
c.) process is included int this project.<br>
&gt;<br>
&gt; The delivery of results can and should be distributed over larger peri=
od of time 2-3 months.<br>
&gt;<br>
&gt;<br>
&gt; Montor: open (I propose Laurent Vivier)<br>
&gt;<br>
&gt; Student: open</p>
<p dir=3D"ltr">Hello, Peter, Laurent, Stefan.</p>
<p dir=3D"ltr">I presented in this thread two variants of a potential linux=
-user-related project for GSoC/Outreachy. The first variant is more focused=
 on a particular area (ioctl support), while the second one covers wider se=
t of current issues within linux-user. The pros and cons of both should be =
carefully assesed. I will leave to Peter and Laurent the final judgement if=
 we want to go or not with this project and also the final formulation of t=
he project.</p>
<p dir=3D"ltr">Stefan, there was an idea in this thread that this project c=
ontributes (apart to QEMU) to another ooen source project (LTP). In my laym=
an view, this is an advantage. But, how does that fit into GSoC/Outreachy r=
ules?</p>
<p dir=3D"ltr">Laurent, all this seems to be dependant on whether you are r=
eady to mentor the project. Are you?</p>
<p dir=3D"ltr">The deadline for submitting GSoC/Outreachy projects (within =
QEMU) is just around the corner (Feb 1). I leave to Laurent or Peter (shoul=
d they give &quot;go&quot; to this proposal) to officially submit the proje=
ct on our wiki page created for that purpose, in the form they deem the bes=
t.</p>
<p dir=3D"ltr">Thanks to everyone for expressing the interest in this topic=
, and especially coming up with additional ideas!</p>
<p dir=3D"ltr">Truly yours,<br>
Aleksandar<br>
</p>

--0000000000001bd91d059d5981e7--

