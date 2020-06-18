Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1A7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 17:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 251F020706
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 17:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuolLb9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251F020706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlxv2-0007Fq-C9
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 13:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jlxu4-0006ig-AC
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 13:00:40 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:55953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jlxu1-0007sz-10
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 13:00:40 -0400
Received: by mail-wm1-x330.google.com with SMTP id a6so2490756wmm.5
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 10:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=mxI99qDnJCWr+9aAwRwsnp2nIReND1p2AIkKbj6x+D4=;
 b=ZuolLb9WsYf0KtGr4Cceo6wFN3PzcsUMlToU0/3d6PnSLNqbswRWfcGdwycrfwVKV2
 bpi6OGdYxgCvYQZNx64nlDh/X8bEl1AZOur6uuFpIOSN/YKJHxFz5DAtIfL8PaB7ytWP
 6ApatR7w/tsTX+EscvVfSS1N/BvR76K7SatX2Xj1MTBGMX9f9lsqtdK6HMcgCex7LtTx
 tNXgQolx6MOm93B+t81c66Dmhv3cRbvHONJ0TJ9F7XPBUQv1td201R+oSRlcANnjXSjo
 JKDmu0/5r0tigkDjrY4cSl/kidCCj7/KN3P+g565dUFRaqWbNZa4Kfl+/RqHAYEwrgHP
 W0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=mxI99qDnJCWr+9aAwRwsnp2nIReND1p2AIkKbj6x+D4=;
 b=iWJRwHd2dZV2QpIliwCu1NYm7TtoCdxTMEptm0yPTtmhmsVwZ+LoSni98/8qXaoJfv
 +CAtMpEYf9SZCv/LUtZ7tEiRA30qA6WEf+Nr9WuF21bmZ55u/93hB7Xz1Utz/yhoqI51
 PBNu65ITzSiGuIe5aiFasOKrmJz0JxtI7+dZesQB5YZLtO9B7JBcszLXa9Tn1uv3d9mc
 WmdtZQRqHNOEDx4+KOWxmZc3nmzARNm8CWVS0xvJnfHXaftNUq73A7bWitthoGsQhIok
 +UC6QPBSKdsqYGy/amMUwB68ArM9WMlKQvepkq5bc1K2wVtuZ/3HK2K/O17iGgIzx0lq
 ikHw==
X-Gm-Message-State: AOAM530BYv91kVw2soyp7H0JADcPayxVNIbTSK8XfAlqbsyytRQ6kndz
 g6HA/80Oj4KfUgcNWHEiidbzyd53x263CDhlmjo=
X-Google-Smtp-Source: ABdhPJxdRSCWUh9x+Cjuo0QFJNFe32eV8y2P77kKIUlOjF/mqJByqBnI+bi7girgXtVEIuMPn1mN0f63f3qFYlc19Jg=
X-Received: by 2002:a1c:46c3:: with SMTP id t186mr4817626wma.36.1592499634836; 
 Thu, 18 Jun 2020 10:00:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:451:0:0:0:0:0 with HTTP;
 Thu, 18 Jun 2020 10:00:34 -0700 (PDT)
In-Reply-To: <20200618135331.7ec861e9.cohuck@redhat.com>
References: <159223432851.7281.13140123017230519248.malonedeb@gac.canonical.com>
 <20200618135331.7ec861e9.cohuck@redhat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 18 Jun 2020 19:00:34 +0200
Message-ID: <CAHiYmc5eJDN-FmBZOtRCM9446mxLZW_JtWdZw7TmSYMsk8iz8Q@mail.gmail.com>
Subject: Re: [Bug 1883560] [NEW] mips linux-user builds occasionly crash
 randomly only to be fixed by a full clean re-build
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000a191905a85eb7a9"
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x330.google.com
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000a191905a85eb7a9
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
>
Alex, Cornelia,

Do you perhaps recall how did you obtain the original binaries (those with
the problem)? What would be your typical workflow? Perhaps "git-pull +
make" on existing, but not latest source tree?

Thanks,
Aleksandar

--0000000000000a191905a85eb7a9
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
<br>
<br>
</blockquote><div><br></div><div>Alex, Cornelia,</div><div><br></div><div>D=
o you perhaps recall how did you obtain the original binaries (those with t=
he problem)? What would be your typical workflow? Perhaps &quot;git-pull + =
make&quot; on existing, but not latest source tree?</div><div><br></div><di=
v>Thanks,</div><div>Aleksandar</div><div><br></div><div>=C2=A0</div>

--0000000000000a191905a85eb7a9--

