Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4E3C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 20:01:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6024E2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 20:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXpadyPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6024E2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGpju-0007U9-HQ
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 16:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jGpjE-00071i-TJ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 16:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jGpjD-0006iU-27
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 16:00:48 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56082)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jGpjC-0006iM-Og
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 16:00:47 -0400
Received: by mail-wm1-x344.google.com with SMTP id z5so480724wml.5
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 13:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FDkHIYjNug7IlGxTBO35q1+f7tNKUKYkuTBE5I4+dPE=;
 b=nXpadyPerqyLT+tJk8fzdyw0SANIAYI3d/iQvca0ceQacBDievF/V0vzAmmocPNf5e
 Hb1XEQunF/eFDS1MvhEDQIDp/8/sV3ckqTKQ+SRjjDlXYqoNJYUHapBZQ7dfua7pfFuB
 zPhbqYHFQXLI07E9tNqDH9OWyKCgepDNe0ZgBZgOf6sqPzWcF8+eiAbBkNKb5FgJPJL0
 L6wOJVXBlZ6v6SaoUbxUH/zX/446WRWesI0YuKZfOgr/lJzWmd1dJ1vnVZmBbAHyGHw1
 IIiS37uXdSSdTDZojN+JCSwIlSO314iVx047RI93GnHCnBZ6E1kmrsxFJexKkabnSIuF
 1KAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FDkHIYjNug7IlGxTBO35q1+f7tNKUKYkuTBE5I4+dPE=;
 b=hKvTwupEHZ7BJ9joDg8IJGi0pWIL/tA8NC92uClziZ/RRDdIQhPw0piORcXBhw866p
 NPgtGABsZHYe7HTsU5FUabyivBUtJH1FbDTTTc3TZNuo+VYU6LjfrUIZIZMIb6wPmeJ6
 8xr4YVtXnjXAw6p6Kdwzbdex9hdQ3a/amK43AhzjunxlG636ARYWhTyg8QKL9B7/bZPZ
 6Y2WgPAl2YcnT3KC/7KzEGz+UAKJ9bKoV4V4kaqSTNXnlas3UfJcMpRcBQMua37PEEJG
 mvKwOrK1/jmVC1CMZ3nS7Yvi98NllNI8AxrXEH/TcghRTrV5guHlrBNeD7vMV5IdXGaT
 hzLA==
X-Gm-Message-State: ANhLgQ0FReV7jNXNUzUPVCLUpc3cWCKdvR3iOv2g6wHkcJUAOokRIKOh
 7oz/Nkcx7vN+bStDFloYh+gnW1eevbpFzWuUFms=
X-Google-Smtp-Source: ADFU+vtq5PdCsZCJ1Tkvts5u2neaWTor8KIJP1QvAeyL1+EzPSPSGvSATpQybla72qG87SAW6eIrBSoKE7WeJKCw6LA=
X-Received: by 2002:a7b:c8d0:: with SMTP id f16mr7877736wml.50.1585080045794; 
 Tue, 24 Mar 2020 13:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200228032613.1049955-1-jiaxun.yang@flygoat.com>
 <20200303004137.1099502-1-jiaxun.yang@flygoat.com>
 <6b4a7564-eac6-7bd3-b1c0-e9c7ac4e0c80@redhat.com>
 <CAL1e-=gEtCtAnsnkO4_E8rqje=n1bHXY_+BXC5P2h5Ld0umNtQ@mail.gmail.com>
 <d9f08408-9c1e-36d9-869b-bac250c6f027@redhat.com>
 <20200323163545.GA19598@aurel32.net>
In-Reply-To: <20200323163545.GA19598@aurel32.net>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 24 Mar 2020 22:00:28 +0200
Message-ID: <CAHiYmc4NzqRArtLtqCu8oUz9idrTD0_VdhL4fs0bX2u2pHYYkw@mail.gmail.com>
Subject: Re: [PATCH v1] mips/mips_malta: Allow more than 2G RAM
To: Aurelien Jarno <aurelien@aurel32.net>
Content-Type: multipart/alternative; boundary="00000000000011fa1505a19f359c"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Peter Maydell <peter.maydell@linaro.org>, Yunqiang Su <ysu@wavecomp.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paul Burton <paul.burton@mips.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000011fa1505a19f359c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

18:38 Pon, 23.03.2020. Aurelien Jarno <aurelien@aurel32.net> =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Hi,
>
> Sorry for the delay, I just want to give some more details about the
> Debian.
>
> On 2020-03-14 10:09, Philippe Mathieu-Daud=C3=A9 wrote:
> > IIUC today all distributions supporting MIPS ports are building their
MIPS
> > packages on QEMU instances because it is faster than the native MIPS
> > hardware they have.
>
> Actually Debian requires that packages are built on real hardware. We
> have a mix of Loongson 3 and Octeon 3 based build daemons. They all have
> 8GiB of RAM.
>
> > Since one (or two?) years, some binaries (Linux kernel? QEMU?) are
failing
> > to link because the amount of guest memory is restricted to 2GB
(probably
> > advance of linker techniques, now linkers use more memory).
>
> The problem happens with big packages (e.g. ceph which is a dependency
> of QEMU). The problem is not the physical memory issue, but the virtual
> address space, which is limited to 2GB for 32-bit processes. That's why
> we do not have the issue for the 64-bit ports.
>
> > YunQiang, is this why you suggested this change?
> >
> > See:
> > -
https://www.mail-archive.com/debian-mips@lists.debian.org/msg10912.html
> > -
https://alioth-lists.debian.net/pipermail/pkg-rust-maintainers/2019-January=
/004844.html
> >
> > I believe most of the QEMU Malta board users don't care it is a Malta
board,
> > they only care it is a fast emulated MIPS machine.
> > Unfortunately it is the default board.
> >
> > However 32-bit MIPS port is being dropped on Debian:
> > https://lists.debian.org/debian-mips/2019/07/msg00010.html
>
> The 32-bit big endian port has been dropped after the Buster (10)
> release and won't be available for the Bullseye release (11). The
> 32-bit little endian port is still available, but it's difficult to keep
> it alive given the 2GB limit.
>
> > Maybe we can sync with the Malta users, ask them to switch to the Bosto=
n
> > machines to build 64-bit packages, then later reduce the Malta board to
1GB.
> > (The Boston board is more recent, but was not available at the time
users
> > started to use QEMU to build 64-bit packages).
> >
> > Might it be easier starting introducing a malta-5.0 machine restricted
to
> > 1GB?
>
> In any case having an easy way to simulate machines with more than 2GB
> of RAM in QEMU would be great.
>

In my company, we do have both Octeon (don't know at this moment what
version) and Boston systems.

Boston seems to me as a very good candidate for enabling RAM > 2GB. I never
saw it phisically, since it is assigned to a different department, but just
anectodaly I heard that it is designed as a desktop (or even server)
machine, and, therefore, it almost certainly supports > 2GB.

Given current circumstances of remote work for most of us, and limited
movement, it may be somewhat difficult for me to access it, but it is not
imposible.

Please take everything I said in this email with a grain of salt, since it
is based more on hallway chats, rather than on facts.

I'll try to get more info, hopefully soon.

Yours,
Aleksandar


> Cheers,
> Aurelien
>
> --
> Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> aurelien@aurel32.net                 http://www.aurel32.net
>

--00000000000011fa1505a19f359c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">18:38 Pon, 23.03.2020. Aurelien Jarno &lt;<a href=3D"mailto:=
aurelien@aurel32.net">aurelien@aurel32.net</a>&gt; =D1=98=D0=B5 =D0=BD=D0=
=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; Sorry for the delay, I just want to give some more details about the<b=
r>
&gt; Debian.<br>
&gt;<br>
&gt; On 2020-03-14 10:09, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; &gt; IIUC today all distributions supporting MIPS ports are building t=
heir MIPS<br>
&gt; &gt; packages on QEMU instances because it is faster than the native M=
IPS<br>
&gt; &gt; hardware they have.<br>
&gt;<br>
&gt; Actually Debian requires that packages are built on real hardware. We<=
br>
&gt; have a mix of Loongson 3 and Octeon 3 based build daemons. They all ha=
ve<br>
&gt; 8GiB of RAM.<br>
&gt;<br>
&gt; &gt; Since one (or two?) years, some binaries (Linux kernel? QEMU?) ar=
e failing<br>
&gt; &gt; to link because the amount of guest memory is restricted to 2GB (=
probably<br>
&gt; &gt; advance of linker techniques, now linkers use more memory).<br>
&gt;<br>
&gt; The problem happens with big packages (e.g. ceph which is a dependency=
<br>
&gt; of QEMU). The problem is not the physical memory issue, but the virtua=
l<br>
&gt; address space, which is limited to 2GB for 32-bit processes. That&#39;=
s why<br>
&gt; we do not have the issue for the 64-bit ports.<br>
&gt;<br>
&gt; &gt; YunQiang, is this why you suggested this change?<br>
&gt; &gt; <br>
&gt; &gt; See:<br>
&gt; &gt; - <a href=3D"https://www.mail-archive.com/debian-mips@lists.debia=
n.org/msg10912.html">https://www.mail-archive.com/debian-mips@lists.debian.=
org/msg10912.html</a><br>
&gt; &gt; - <a href=3D"https://alioth-lists.debian.net/pipermail/pkg-rust-m=
aintainers/2019-January/004844.html">https://alioth-lists.debian.net/piperm=
ail/pkg-rust-maintainers/2019-January/004844.html</a><br>
&gt; &gt; <br>
&gt; &gt; I believe most of the QEMU Malta board users don&#39;t care it is=
 a Malta board,<br>
&gt; &gt; they only care it is a fast emulated MIPS machine.<br>
&gt; &gt; Unfortunately it is the default board.<br>
&gt; &gt; <br>
&gt; &gt; However 32-bit MIPS port is being dropped on Debian:<br>
&gt; &gt; <a href=3D"https://lists.debian.org/debian-mips/2019/07/msg00010.=
html">https://lists.debian.org/debian-mips/2019/07/msg00010.html</a><br>
&gt;<br>
&gt; The 32-bit big endian port has been dropped after the Buster (10)<br>
&gt; release and won&#39;t be available for the Bullseye release (11). The<=
br>
&gt; 32-bit little endian port is still available, but it&#39;s difficult t=
o keep<br>
&gt; it alive given the 2GB limit.<br>
&gt;<br>
&gt; &gt; Maybe we can sync with the Malta users, ask them to switch to the=
 Boston<br>
&gt; &gt; machines to build 64-bit packages, then later reduce the Malta bo=
ard to 1GB.<br>
&gt; &gt; (The Boston board is more recent, but was not available at the ti=
me users<br>
&gt; &gt; started to use QEMU to build 64-bit packages).<br>
&gt; &gt; <br>
&gt; &gt; Might it be easier starting introducing a malta-5.0 machine restr=
icted to<br>
&gt; &gt; 1GB?<br>
&gt;<br>
&gt; In any case having an easy way to simulate machines with more than 2GB=
<br>
&gt; of RAM in QEMU would be great.<br>
&gt;</p>
<p dir=3D"ltr">In my company, we do have both Octeon (don&#39;t know at thi=
s moment what version) and Boston systems.</p>
<p dir=3D"ltr">Boston seems to me as a very good candidate for enabling RAM=
 &gt; 2GB. I never saw it phisically, since it is assigned to a different d=
epartment, but just anectodaly I heard that it is designed as a desktop (or=
 even server) machine, and, therefore, it almost certainly supports &gt; 2G=
B.</p>
<p dir=3D"ltr">Given current circumstances of remote work for most of us, a=
nd limited movement, it may be somewhat difficult for me to access it, but =
it is not imposible.</p>
<p dir=3D"ltr">Please take everything I said in this email with a grain of =
salt, since it is based more on hallway chats, rather than on facts.</p>
<p dir=3D"ltr">I&#39;ll try to get more info, hopefully soon.</p>
<p dir=3D"ltr">Yours,<br>
Aleksandar<br><br><br></p>
<p dir=3D"ltr">&gt; Cheers,<br>
&gt; Aurelien<br>
&gt;<br>
&gt; -- <br>
&gt; Aurelien Jarno=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GPG: 4096R/1DDD8C9B<br>
&gt; <a href=3D"mailto:aurelien@aurel32.net">aurelien@aurel32.net</a>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://w=
ww.aurel32.net">http://www.aurel32.net</a><br>
&gt;<br>
</p>

--00000000000011fa1505a19f359c--

