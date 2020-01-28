Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0408BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:34:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D5A7214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 17:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cljgE0yQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5A7214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwUl3-0008BN-RR
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 12:34:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iwUjs-0006vK-Ud
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:33:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iwUjq-00035x-Oi
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:33:24 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:35890)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iwUjq-00034u-Ib
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:33:22 -0500
Received: by mail-ot1-x334.google.com with SMTP id g15so12823685otp.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7sB3/9Ft6rpskX4bwt1+RnsCAzqyLchclaYlMvK6WgU=;
 b=cljgE0yQ2+V3e1JirtXyLtLGF/H/FX67hWRIDEqUypcBiQHGzFCOmv3DXhmh+VtUV4
 25ALOCVdtdKT6ZOR5moF2tYvKSeQaJXyqUHajlT/a2IYos2JieRPZADLX61x4zoJ2cuq
 fmGRW3qgwhZGltrrHVSTgumNYMFZSXAFpgXKTUX3VaRQRpokjlyO1pb8Gz8fGMPLYnWW
 MG9P8p6/zGpxdT611MoDDGIqS6SUhmbnoCqRpYwK5d5b/4aTZngjJikWaztiDwKNGBay
 pacC6ibwLl6CUZm/d/HbJ2NUX2o4wnNW4q49WM/6rCjTS8lzQDS23qn4ObhaHEOtU3de
 smmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7sB3/9Ft6rpskX4bwt1+RnsCAzqyLchclaYlMvK6WgU=;
 b=Zf8geba3y+n20hdkQtt6C0BgpdklB770IukiiWgoEVZEz9u0FiAuj2VDKltYMwZEDt
 bUYxmf+vRcRnwlK53PExrtLrGApPzT/2QRM1uH8C2XInyETYs1HnHKw67oO+Up7AOSWb
 yxzVDrL4uRVDpVWdlhAH77xql1eAP16MFPmy6Bk5C5WgzSxsDw1carwdYdg4GBYWhz0o
 V+RhLcotFNwqh9kXhjyYslXYUNBYYupxJrP9Wzfgoq7A+5OqK1A3E2BE53s9T36NzGqJ
 7Ns5psfsDfwOfvrDA5zqvTTDw2RXVQovtr1j0lwXf8w85OwQo2CbHLLdObtc9tgB0v5a
 RGpw==
X-Gm-Message-State: APjAAAVCJQf9hAoD88nna//hHGEmub/P//VEdI02uTInIGGkkHo4OkBZ
 P6p4p2uGGc7DubMbS4CMHI59gTQWyvZFutPJYXE=
X-Google-Smtp-Source: APXvYqy0BPu0D5rOFrS5FCIij70Tvoby5D2xsB7w/bEJTRma6t2hHgpxhNiWig/erbjn8sKqzu28NlfM+Skn5pkpFwk=
X-Received: by 2002:a05:6830:1042:: with SMTP id
 b2mr17160195otp.306.1580232801368; 
 Tue, 28 Jan 2020 09:33:21 -0800 (PST)
MIME-Version: 1.0
References: <CAL1e-=j5WJkV=X+KkfBuS3pjf6z3aJrtu4xpYeVbjEUYiWxxTQ@mail.gmail.com>
 <20200127093004.GA18565@stefanha-x1.localdomain>
 <CAL1e-=h+g4FWVDVe6a4T_X_nEA-catKd+7LiKXx++qS+G7mqOQ@mail.gmail.com>
 <74b19db2-8ed2-c0c4-2870-b60dd49789cd@vivier.eu>
In-Reply-To: <74b19db2-8ed2-c0c4-2870-b60dd49789cd@vivier.eu>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 28 Jan 2020 18:32:55 +0100
Message-ID: <CAL1e-=iUzdg=bvdinM=qtVtOt+yzPw4+E-_m1CRKXW-EHdwkrw@mail.gmail.com>
Subject: Re: [GSoC/Outreachy QEMU proposal] Extend support for ioctls in QEMU
 linux-user mode
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="000000000000c9bf9e059d369e08"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::334
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

--000000000000c9bf9e059d369e08
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

15:28 Uto, 28.01.2020. Laurent Vivier <laurent@vivier.eu> =D1=98=D0=B5 =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Le 27/01/2020 =C3=A0 17:30, Aleksandar Markovic a =C3=A9crit :
> >
> >
> > On Mon, Jan 27, 2020 at 10:30 AM Stefan Hajnoczi <stefanha@redhat.com
> > <mailto:stefanha@redhat.com>> wrote:
> >>
> >> On Thu, Jan 23, 2020 at 02:34:01PM +0100, Aleksandar Markovic wrote:
> >> > *Extend support for ioctls in QEMU linux-user mode*
> >> >
> >> >
> >> >
> >> > *PLANNED ACTIVITIES*
> >> >
> >> > BACKGROUND
> >> >
> >> > There is currently 2500+ ioctls defined in Linux kernel. QEMU
linux-user
> >> > currently supports only several hundred. There is a constant need fo=
r
> >> > expanding ioctl support in QEMU. Users use Linux-user mode in
variety of
> >> > setups (for example, building and testing tools and applications
under
> >> > chroot environment), and, on a regular basis, efforts by multiple
people
> >> > are made to fill in missing support. However, these efforts have bee=
n
> >> > usually done on a piece-by-piece basis, i a limited way covering a
> >>
> >> s/ i / in /
> >>
> >> > partucular need. This project will take more proactive stance, and
> > try to
> >>
> >> s/partucular/particular/
> >>
> >> > improve QEMU before users start complaining.
> >> >
> >> > PART I:
> >> >
> >> >    a) Add strace support for outputing ioctl IDs (the second
argument of
> >> > ioctl()) as strings rather than numbers - for all platform
independant
> >> > ioctls.
> >> >    b) Add strace support for printing the third argument of ioctl()
> > (be it
> >> > int, string, structure or array) - limited to selected ioctls that
are
> >> > frequently used.
> >> >
> >> > PART II:
> >> >
> >> >    a) Amend support for existing groups of ioctls that are not
completed
> >> > 100% (let's say, filesystem ioctls)
> >> >    b) Add support for a selected group of ioctls that are not
currently
> >> > supported (for example, dm ioctls, Bluetooth ioctls, or Radeon DRM
> > ioctls)
> >> >
> >> > PART III:
> >> >
> >> >   a) Develop unit tests for selected ioctls that are already
> > supported in
> >> > QEMU.
> >> >
> >> >
> >> > *DELIVERABLES*
> >> >
> >> > The deliverables are in the form of source code for each part,
> > intended to
> >> > be upstreamed, and time needed for upstreaming (addressing reviews,
> > etc.)
> >> > process is included int this project.
> >> >
> >> > The delivery of results can and should be distributed over larger
> > period of
> >> > time 2-3 months.
> >>
> >> Good project idea.  Please choose concrete ioctls.  Applicants may not
> >> have the necessary experience to choose a set of ioctls that are
useful.
> >>
> >
> > PART I should not be that difficult. PART II is, however, a minefield.
> > An implementation of support of a ioctl range from 15 minutes to two
> > months. The least we wont to happen is that the student is stuck with a
> > problem for months. Therefore I suggest first some "low hanging fruit"
> > for a student to get self-confidence and experience. One such group is
> > DM ioctl group ( link
> > <
https://github.com/torvalds/linux/blob/master/include/uapi/linux/dm-ioctl.h=
#L251
>
> > ) (Laurent may confirm, or "unconfirm" that). The next shoudl be
>
> Well, ioctl are generally implemented on demand when we see there is one
> missing. DM can be interresting, but do we have an easy way to test them?
>

The main difficilty, as I see this now, would be establishing a test bed.
This should be possible using one or two USB flash drives (if one doesn't
want to mess with own hard drives and partitions). After that, having
dm-enabled devices available, writing unit test should be straightforward.

I don't have a particular prefference towards dm ioctls, they just look to
me simple enough to be a good and gentle starting point for a beginner.

Giving a student a hard case at the beginning could be quite discouraging
for him/her, and probably even counterproductive for the project as a whole=
.

Again, this is just my opinion, I don't have the ambition to impose such
details. After all, this was and is just a proposal.

> > something a little harder, but useful in terms of end user. PART III
> > should be developed on the fly, but we need to provide a
> > guideline/framework prior to starting working with a student, IMHO..
> >
> >> I wonder if it's possible to use something like the Debian popularity
> >> contest (https://popcon.debian.org/) and then scan the source of the
> >> most popular N packages for ioctl() calls.
> >
> > Great! I'll try. A very interesting site and method.
> >
>
> The other point to implement ioctl that we know are used by a given
> package is we can run this package to see if it works or not before and
> after the implementation of the missing ioctl.
>
> We can also rely on some test suites provided by the packages.
>
> We can also detect missing ioctl by looking at "Unsupported ioctl: cmd=3D=
"
> error message while we run chroot.
>
> It could be interesting to run a gnome-session from inside a chroot with
> qemu-linux-user to trigger more multimedia related ioctl.
>

One more intriguing idea!

Regards,
Aleksandar

> Thanks,
> Laurent
>

--000000000000c9bf9e059d369e08
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">15:28 Uto, 28.01.2020. Laurent Vivier &lt;<a href=3D"mailto:=
laurent@vivier.eu">laurent@vivier.eu</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=
=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; Le 27/01/2020 =C3=A0 17:30, Aleksandar Markovic a =C3=A9crit=C2=A0:<br=
>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; On Mon, Jan 27, 2020 at 10:30 AM Stefan Hajnoczi &lt;<a href=3D"m=
ailto:stefanha@redhat.com">stefanha@redhat.com</a><br>
&gt; &gt; &lt;mailto:<a href=3D"mailto:stefanha@redhat.com">stefanha@redhat=
.com</a>&gt;&gt; wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On Thu, Jan 23, 2020 at 02:34:01PM +0100, Aleksandar Markovic=
 wrote:<br>
&gt; &gt;&gt; &gt; *Extend support for ioctls in QEMU linux-user mode*<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; *PLANNED ACTIVITIES*<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; BACKGROUND<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; There is currently 2500+ ioctls defined in Linux kernel.=
 QEMU linux-user<br>
&gt; &gt;&gt; &gt; currently supports only several hundred. There is a cons=
tant need for<br>
&gt; &gt;&gt; &gt; expanding ioctl support in QEMU. Users use Linux-user mo=
de in variety of<br>
&gt; &gt;&gt; &gt; setups (for example, building and testing tools and appl=
ications under<br>
&gt; &gt;&gt; &gt; chroot environment), and, on a regular basis, efforts by=
 multiple people<br>
&gt; &gt;&gt; &gt; are made to fill in missing support. However, these effo=
rts have been<br>
&gt; &gt;&gt; &gt; usually done on a piece-by-piece basis, i a limited way =
covering a<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; s/ i / in /<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt; partucular need. This project will take more proactive s=
tance, and<br>
&gt; &gt; try to<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; s/partucular/particular/<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt; improve QEMU before users start complaining.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; PART I:<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; =C2=A0 =C2=A0a) Add strace support for outputing ioctl I=
Ds (the second argument of<br>
&gt; &gt;&gt; &gt; ioctl()) as strings rather than numbers - for all platfo=
rm independant<br>
&gt; &gt;&gt; &gt; ioctls.<br>
&gt; &gt;&gt; &gt; =C2=A0 =C2=A0b) Add strace support for printing the thir=
d argument of ioctl()<br>
&gt; &gt; (be it<br>
&gt; &gt;&gt; &gt; int, string, structure or array) - limited to selected i=
octls that are<br>
&gt; &gt;&gt; &gt; frequently used.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; PART II:<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; =C2=A0 =C2=A0a) Amend support for existing groups of ioc=
tls that are not completed<br>
&gt; &gt;&gt; &gt; 100% (let&#39;s say, filesystem ioctls)<br>
&gt; &gt;&gt; &gt; =C2=A0 =C2=A0b) Add support for a selected group of ioct=
ls that are not currently<br>
&gt; &gt;&gt; &gt; supported (for example, dm ioctls, Bluetooth ioctls, or =
Radeon DRM<br>
&gt; &gt; ioctls)<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; PART III:<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; =C2=A0 a) Develop unit tests for selected ioctls that ar=
e already<br>
&gt; &gt; supported in<br>
&gt; &gt;&gt; &gt; QEMU.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; *DELIVERABLES*<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; The deliverables are in the form of source code for each=
 part,<br>
&gt; &gt; intended to<br>
&gt; &gt;&gt; &gt; be upstreamed, and time needed for upstreaming (addressi=
ng reviews,<br>
&gt; &gt; etc.)<br>
&gt; &gt;&gt; &gt; process is included int this project.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; The delivery of results can and should be distributed ov=
er larger<br>
&gt; &gt; period of<br>
&gt; &gt;&gt; &gt; time 2-3 months.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Good project idea.=C2=A0 Please choose concrete ioctls.=C2=A0=
 Applicants may not<br>
&gt; &gt;&gt; have the necessary experience to choose a set of ioctls that =
are useful.<br>
&gt; &gt;&gt;<br>
&gt; &gt; <br>
&gt; &gt; PART I should not be that difficult. PART II is, however, a minef=
ield.<br>
&gt; &gt; An implementation of support of a ioctl range from 15 minutes to =
two<br>
&gt; &gt; months. The least we wont to happen is that the student is stuck =
with a<br>
&gt; &gt; problem for months. Therefore I suggest first some &quot;low hang=
ing fruit&quot;<br>
&gt; &gt; for a student to get self-confidence and experience. One such gro=
up is<br>
&gt; &gt; DM ioctl group (=C2=A0link<br>
&gt; &gt; &lt;<a href=3D"https://github.com/torvalds/linux/blob/master/incl=
ude/uapi/linux/dm-ioctl.h#L251">https://github.com/torvalds/linux/blob/mast=
er/include/uapi/linux/dm-ioctl.h#L251</a>&gt;<br>
&gt; &gt; ) (Laurent may confirm, or &quot;unconfirm&quot; that). The next =
shoudl be<br>
&gt;<br>
&gt; Well, ioctl are generally implemented on demand when we see there is o=
ne<br>
&gt; missing. DM can be interresting, but do we have an easy way to test th=
em?<br>
&gt;</p>
<p dir=3D"ltr">The main difficilty, as I see this now, would be establishin=
g a test bed. This should be possible using one or two USB flash drives (if=
 one doesn&#39;t want to mess with own hard drives and partitions). After t=
hat, having dm-enabled devices available, writing unit test should be strai=
ghtforward.</p>
<p dir=3D"ltr">I don&#39;t have a particular prefference towards dm ioctls,=
 they just look to me simple enough to be a good and gentle starting point =
for a beginner.</p>
<p dir=3D"ltr">Giving a student a hard case at the beginning could be quite=
 discouraging for him/her, and probably even counterproductive for the proj=
ect as a whole.</p>
<p dir=3D"ltr">Again, this is just my opinion, I don&#39;t have the ambitio=
n to impose such details. After all, this was and is just a proposal.</p>
<p dir=3D"ltr">&gt; &gt; something a little harder, but useful in terms of =
end user. PART III<br>
&gt; &gt; should be developed on the fly, but we need to provide a<br>
&gt; &gt; guideline/framework prior to starting working with a student, IMH=
O..<br>
&gt; &gt; <br>
&gt; &gt;&gt; I wonder if it&#39;s possible to use something like the Debia=
n popularity<br>
&gt; &gt;&gt; contest (<a href=3D"https://popcon.debian.org/">https://popco=
n.debian.org/</a>) and then scan the source of the<br>
&gt; &gt;&gt; most popular N packages for ioctl() calls.<br>
&gt; &gt; <br>
&gt; &gt; Great! I&#39;ll try. A very interesting site and method.<br>
&gt; &gt; <br>
&gt;<br>
&gt; The other point to implement ioctl that we know are used by a given<br=
>
&gt; package is we can run this package to see if it works or not before an=
d<br>
&gt; after the implementation of the missing ioctl.<br>
&gt;<br>
&gt; We can also rely on some test suites provided by the packages.<br>
&gt;<br>
&gt; We can also detect missing ioctl by looking at &quot;Unsupported ioctl=
: cmd=3D&quot;<br>
&gt; error message while we run chroot.<br>
&gt;<br>
&gt; It could be interesting to run a gnome-session from inside a chroot wi=
th<br>
&gt; qemu-linux-user to trigger more multimedia related ioctl.<br>
&gt;</p>
<p dir=3D"ltr">One more intriguing idea!</p>
<p dir=3D"ltr">Regards,<br>
Aleksandar</p>
<p dir=3D"ltr">&gt; Thanks,<br>
&gt; Laurent<br>
&gt;<br>
</p>

--000000000000c9bf9e059d369e08--

