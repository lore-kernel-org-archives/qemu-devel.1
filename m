Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C37FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:13:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8838207DD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxFMc8rt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8838207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlwEH-00082d-5H
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 11:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jlwCh-0006Os-56
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:11:48 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:53481)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jlwCe-0002JL-UO
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:11:46 -0400
Received: by mail-wm1-x329.google.com with SMTP id l26so5544894wme.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 08:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=3MPeQJJl/Hh0ZbXJLrOfiLjK3sBZfLIJQEog7b7H+ow=;
 b=GxFMc8rtXVN3F+a6RWsUGZzy07ZMuPmQNrszj44r3UQeqk5WZQeQwG8ZOnwaJGtrBT
 PPSaDJqmwVqsF/ellO5NISvL7wroPYcCyEpBGVK1AV5iK+xYy06UXZR6rgPrrTkgsGSn
 bmZ/9m8AW5lLomat3+351p4lnZXqecDfMQzVgUGAgtBem/A6a+gglnUSxhihdrHqOulv
 VVzG6vKw/Mrb0QhwGbVZ/g+AC7sow9Qco6KBEE2bnRsMPyGIgJfKPekqecmjxJB5456v
 1T2QYC7Xc4T4WdUUbwaO81+ex5yPXfWtJ9p76dtCzZF1SeXmaoFWY+Irn4nKopkGDtja
 a95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=3MPeQJJl/Hh0ZbXJLrOfiLjK3sBZfLIJQEog7b7H+ow=;
 b=K0Ab3R/5X8yKiQtVOH5/1+wjLDSX2rfgfRFITKU5RDgCSOfI616U3XAVWKWu3PZqLK
 4kv9esDlGbDup+WgCCV4GXEwzToyvfvIHmhCskp8AL00qq9HQ7+lR78cSkKTYPn4P5Wl
 yYc/rQ9sjek48F4CEn3I/AWkS7y3VXq9qsSFk44w+gH6h2CFI7ftRUgETDt86lKjbSeO
 POIyHsuTv4oK6yqgvc6E8xNI8d8y8yhlUjXKHWrxUIfm6i/EgxsbCtwEFRG02Vy40bY4
 oBYO8JJ5c2kXXGvj+x6O6GbkaLN1Yy8tFxbXjVdMakBOLo3bp2nz/GqobYoKPpjyPypK
 ciZg==
X-Gm-Message-State: AOAM533gapA4Xo/MO3jiTSTbbr/OV605OWMStLi6m5e76fi7/5zoYwsa
 Pxl+IwnOwBUH4iFQcvnMvBvQO15t13vskLw/PGI=
X-Google-Smtp-Source: ABdhPJwjiElHVkt8fYM14uaZzJkZ1h05ODzioe3bAQsf6xdHleX20amsosbHPpkB4/lOPvtuMhHRFqXC59AD+3UKkLw=
X-Received: by 2002:a1c:4c05:: with SMTP id z5mr4303086wmf.129.1592493102375; 
 Thu, 18 Jun 2020 08:11:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:451:0:0:0:0:0 with HTTP;
 Thu, 18 Jun 2020 08:11:42 -0700 (PDT)
In-Reply-To: <20200618135331.7ec861e9.cohuck@redhat.com>
References: <159223432851.7281.13140123017230519248.malonedeb@gac.canonical.com>
 <20200618135331.7ec861e9.cohuck@redhat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 18 Jun 2020 17:11:42 +0200
Message-ID: <CAHiYmc4CSjJ2ZVmAtfaQNqve=XQD04-JZrcVnozk18vWtxBmug@mail.gmail.com>
Subject: Re: [Bug 1883560] [NEW] mips linux-user builds occasionly crash
 randomly only to be fixed by a full clean re-build
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000aca53305a85d3112"
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x329.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <1883560@bugs.launchpad.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000aca53305a85d3112
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D0=B5=D1=82=D0=B2=D1=80=D1=82=D0=B0=D0=BA, 18. =D1=98=D1=83=D0=BD 20=
20., Cornelia Huck <cohuck@redhat.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=
=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:

> On Mon, 15 Jun 2020 15:18:48 -0000
> Alex Benn=C3=A9e <1883560@bugs.launchpad.net> wrote:
>
> > Public bug reported:
> >
> > >From time to time I find check-tcg crashes with a one of the MIPS
> > binaries. The last time it crashed was running the test:
> >
> >   ./mips64el-linux-user/qemu-mips64el ./tests/tcg/mips64el-linux-
> > user/threadcount
> >
> > Inevitably after some time noodling around wondering what could be
> > causing this weird behaviour I wonder if it is a build issue. I wipe al=
l
> > the mips* build directories, re-run configure and re-build and voila
> > problem goes away.
> >
> > It seems there must be some sort of build artefact which isn't being
> > properly re-generated on a build update which causes weird problems.
> > Additional data point if I:
> >
> >   rm -rf mips64el-linux-user
> >   ../../configure
> >   make
> >
> > then I see failures in mip32 builds - eg:
> >
> >     GEN     mipsn32el-linux-user/config-target.h
> >   In file included from /home/alex/lsrc/qemu.git/
> linux-user/syscall_defs.h:10,
> >                    from /home/alex/lsrc/qemu.git/linux-user/qemu.h:16,
> >                    from /home/alex/lsrc/qemu.git/
> linux-user/linuxload.c:5:
> >   /home/alex/lsrc/qemu.git/linux-user/mips64/syscall_nr.h:1: error:
> unterminated #ifndef
> >    #ifndef LINUX_USER_MIPS64_SYSCALL_NR_H
> >
> >   make[1]: *** [/home/alex/lsrc/qemu.git/rules.mak:69:
> linux-user/linuxload.o] Error 1
> >   make[1]: *** Waiting for unfinished jobs....
> >
> > which implies there is a cross dependency between different targets
> > somewhere. If I executed:
> >
> >   rm -rf mips*
> >
> > before re-configuring and re-building then everything works again.
> >
> > ** Affects: qemu
> >      Importance: Undecided
> >          Status: New
> >
> >
> > ** Tags: build linux-user mips
> >
>
> FWIW, this does not seem to be a mips-only issue: I'm seeing the
> threadcount test fail with s390x-linux-user as well, and it also goes
> away (only) if I purge the build directory, re-configure, and re-build.
>
>
Valuable info!

--000000000000aca53305a85d3112
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=87=D0=B5=D1=82=D0=B2=D1=80=D1=82=D0=B0=D0=BA, 18. =D1=98=D1=83=
=D0=BD 2020., Cornelia Huck &lt;<a href=3D"mailto:cohuck@redhat.com">cohuck=
@redhat.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE=
/=D0=BB=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">On Mon, 15 Jun 2020 15:18:=
48 -0000<br>
Alex Benn=C3=A9e &lt;<a href=3D"mailto:1883560@bugs.launchpad.net">1883560@=
bugs.launchpad.net</a>&gt; wrote:<br>
<br>
&gt; Public bug reported:<br>
&gt; <br>
&gt; &gt;From time to time I find check-tcg crashes with a one of the MIPS=
=C2=A0 <br>
&gt; binaries. The last time it crashed was running the test:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0./mips64el-linux-user/qemu-<wbr>mips64el ./tests/tcg/mips6=
4el-linux-<br>
&gt; user/threadcount<br>
&gt; <br>
&gt; Inevitably after some time noodling around wondering what could be<br>
&gt; causing this weird behaviour I wonder if it is a build issue. I wipe a=
ll<br>
&gt; the mips* build directories, re-run configure and re-build and voila<b=
r>
&gt; problem goes away.<br>
&gt; <br>
&gt; It seems there must be some sort of build artefact which isn&#39;t bei=
ng<br>
&gt; properly re-generated on a build update which causes weird problems.<b=
r>
&gt; Additional data point if I:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0rm -rf mips64el-linux-user<br>
&gt;=C2=A0 =C2=A0../../configure<br>
&gt;=C2=A0 =C2=A0make<br>
&gt; <br>
&gt; then I see failures in mip32 builds - eg:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0GEN=C2=A0 =C2=A0 =C2=A0mipsn32el-linux-user/config-=
<wbr>target.h<br>
&gt;=C2=A0 =C2=A0In file included from /home/alex/lsrc/qemu.git/<wbr>linux-=
user/syscall_defs.h:10,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f=
rom /home/alex/lsrc/qemu.git/<wbr>linux-user/qemu.h:16,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f=
rom /home/alex/lsrc/qemu.git/<wbr>linux-user/linuxload.c:5:<br>
&gt;=C2=A0 =C2=A0/home/alex/lsrc/qemu.git/<wbr>linux-user/mips64/syscall_nr=
.<wbr>h:1: error: unterminated #ifndef<br>
&gt;=C2=A0 =C2=A0 #ifndef LINUX_USER_MIPS64_SYSCALL_NR_H<br>
&gt; <br>
&gt;=C2=A0 =C2=A0make[1]: *** [/home/alex/lsrc/qemu.git/<wbr>rules.mak:69: =
linux-user/linuxload.o] Error 1<br>
&gt;=C2=A0 =C2=A0make[1]: *** Waiting for unfinished jobs....<br>
&gt; <br>
&gt; which implies there is a cross dependency between different targets<br=
>
&gt; somewhere. If I executed:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0rm -rf mips*<br>
&gt; <br>
&gt; before re-configuring and re-building then everything works again.<br>
&gt; <br>
&gt; ** Affects: qemu<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Importance: Undecided<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Status: New<br>
&gt; <br>
&gt; <br>
&gt; ** Tags: build linux-user mips<br>
&gt; <br>
<br>
FWIW, this does not seem to be a mips-only issue: I&#39;m seeing the<br>
threadcount test fail with s390x-linux-user as well, and it also goes<br>
away (only) if I purge the build directory, re-configure, and re-build.<br>
<br></blockquote><div><br></div><div>Valuable info!</div><div>=C2=A0</div>

--000000000000aca53305a85d3112--

