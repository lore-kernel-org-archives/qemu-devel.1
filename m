Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2143BC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E37042464E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNFi/H76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37042464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46zs-0003YS-HP
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j46xb-0000wt-Vd
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j46xY-0003eM-S4
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:47:03 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34441)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j46xY-0003cQ-7V; Tue, 18 Feb 2020 12:47:00 -0500
Received: by mail-ot1-x343.google.com with SMTP id j16so20379823otl.1;
 Tue, 18 Feb 2020 09:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=0mXLe6I2bVnunk/uud2CeZS3TcbI3dbo+2XkkUSvjGo=;
 b=lNFi/H76z4NOX9wdE0ieKxNUTruIQdqkKb/f/P/DhmSoyfLvCSr9LbHXrYThOxx+Hq
 k5N0hTYaLu0V+9YR/ZjkRuIMT0/rzjtsbhGpjBLu80gjAPV1y45aGDhzS0OJmCeeWciv
 zHKho76bWFstNTSmGoTCRkK0Yp9T77l4u4ZO0fySCJli0jdBsUHotnshfe63guSS3LXp
 WESK5yU3Q80JHNk1W7tSjM95r+J0vMnxEGpEfpEf+gBf57/noUb1fF7pK6z+eDIqw7CN
 /CD4wGKb/ysYBS1bfyBRfRUGBuuRyGfjexLXPSiwWQQ2xgLA/BADFoEWEr2XZEehJQbR
 JTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=0mXLe6I2bVnunk/uud2CeZS3TcbI3dbo+2XkkUSvjGo=;
 b=ASaQjef/UEBhzxsfSHclRfzPC3iCUV1x/DxHxRP2V0XkgZUnNMQb56spA/UOjjq0ZU
 l8gLUD6khCkRMJWg2rQwxEZ1wEfmxDFmv1HGRWHO7EMrxNkI9J6Wap4jayuYF7665l7e
 jcXR2zS9e00cSOpI+UPd+IhWjgxkpbVW4xp9H+2Sw7oeBXTlVXrR6KoAbiVgHmjs1U+J
 js1C0SEPnXm1Myx5toCIS/Z1J9PaScliLBKWWFoKAbS1iGyj/UEjYDNtsP4lqHdhKLlJ
 AsLwHcgdTtA1sMV+d1EYnjSQh+NnINsYzBkohZc0HI7BnQTHrpf/i+6EArVGqnGpJkL+
 XqsQ==
X-Gm-Message-State: APjAAAXyCMjWcFX/Nupd8CJ88N5+krjYVfDdl6KrTN7E7bnEESSDQvyJ
 3fCwRpK4JHA5ArBLcJDsoE8vCCjJZDYJgEjBOi0=
X-Google-Smtp-Source: APXvYqz+xo49MkaqvztF7sV3VfuMUP0b5pYc6lDR/VHD5mZ0LrRpGzCUlt+eJjpr7AyV18d2JrExWsaQQqmVGfVheWA=
X-Received: by 2002:a05:6830:1e76:: with SMTP id
 m22mr11555434otr.295.1582048015458; 
 Tue, 18 Feb 2020 09:46:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Tue, 18 Feb 2020 09:46:54 -0800 (PST)
In-Reply-To: <20200218181551.6dff3ec2.cohuck@redhat.com>
References: <20200217223558.863199-1-laurent@vivier.eu>
 <20200218152748.63d608af.cohuck@redhat.com>
 <0769c184-dc34-c022-1986-698c6650bac1@vivier.eu>
 <20200218181551.6dff3ec2.cohuck@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 18 Feb 2020 18:46:54 +0100
Message-ID: <CAL1e-=hSSeOi9+sHofSpqPyBU_o2O0GHjBbc91eZRyBGSg==mA@mail.gmail.com>
Subject: Re: [PATCH 00/22] linux-user: generate syscall_nr.sh
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000faa487059edd41bd"
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000faa487059edd41bd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, February 18, 2020, Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 18 Feb 2020 16:19:21 +0100
> Laurent Vivier <laurent@vivier.eu> wrote:
>
> > Le 18/02/2020 =C3=A0 15:27, Cornelia Huck a =C3=A9crit :
> > > On Mon, 17 Feb 2020 23:35:36 +0100
> > > Laurent Vivier <laurent@vivier.eu> wrote:
> > >
> > >> This series copies the files syscall.tbl from linux v5.5 and generat=
es
> > >> the file syscall_nr.h from them.
> > >>
> > >> This is done for all the QEMU targets that have a syscall.tbl
> > >> in the linux source tree: mips, mips64, i386, x86_64, sparc, s390x,
> > >> ppc, arm, microblaze, sh4, xtensa, m68k, hppa and alpha.
> > >>
> > >> tilegx and cris are depecrated in linux (tilegx has no maintainer in
> QEMU)
> > >>
> > >> aarch64, nios2, openrisc and riscv have no syscall.tbl in linux.
> > >>
> > >> It seems there is a bug in QEMU that forces to disable manually
> arch_prctl
> > >> with i386 target: do_arch_prctl() is only defined with TARGET_ABI32
> but
> > >> TARGET_ABI32 is never defined with TARGET_I386 (nor TARGET_X86_64).
> > >>
> > >> I have also removed all syscalls in s390x/syscall_nr.h defined for
> > >> !defined(TARGET_S390X).
> > >>
> > >> I have added a script to copy all these files from linux and updated
> > >> them at the end of the series with their latest version for today.
> > >>
> > >> The two last patches manage the special case for mips O32 that needs
> > >> to know the number of arguments. We find them in strace sources.
> > >
> > > I like the idea of generating those files, but I wonder if that shoul=
d
> > > interact with linux-headers updates.
> > >
> > > I plan to do a linux-headers update to 5.6-rc?, and I noticed that th=
is
> > > will drag in two new syscalls (openat2 and pidfd_getfd). Now, just
> > > having the new #defines in the headers doesn't do anything, but shoul=
d
> > > it be a trigger to update the syscall.tbl files as well? Or does that
> > > need manual inspection/updating?
> >
> > I think it's a good idea to update the syscall.tbl when we update
> > linux-headers, and there will be no change at linux-user level while we
> > don't implement the syscall translation in syscall.c:do_syscall1().
>
> Nod.
>
> >
> > But I think we should also check manually the difference between new an=
d
> > old generated syscall_nr.h to be sure there is nothing broken in what w=
e
> > introduce.
> >
> > I always run a Linux Test Project testsuite for all architectures with =
a
> > debian distro when I do a pull request so I can detect regression.
> >
> > In the end, updating linux-headers should trigger syscall.tbl update bu=
t
> > it needs manual inspection.
>
> I think we should make sure that updating syscall.tbl does not get
> forgotten if we do a headers update... have the update script print out
> a message? I'm not sure if we want to automate updating the syscall
> table, as we want manual inspection for it.
>
> Maybe have the update script moan about syscall.tbl if unistd.h is
> changed? Should be a good enough heuristic.
>
> That said, I'll probably queue a headers update on the s390-next branch
> right now (against current Linus master),


>
Hi, Cornelia,

I am not stopping you from updating headers from Linus' master, however, I
think a better practice would be to do regular updates from each stable
kernel release (the last one is 5.5), rather than from an arbitrary
kernel-du-jour, which may be the subject of change (including reverts) wrt
headers between two stable releases.

Regards,
Aleksandar



>
> unless someone complains --
> maybe take the syscall.tbl from that state of the kernel tree as well?
>
>
>

--000000000000faa487059edd41bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, February 18, 2020, Cornelia Huck &lt;<a href=3D"mailto:=
cohuck@redhat.com">cohuck@redhat.com</a>&gt; wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">On Tue, 18 Feb 2020 16:19:21 +0100<br>
Laurent Vivier &lt;<a href=3D"mailto:laurent@vivier.eu">laurent@vivier.eu</=
a>&gt; wrote:<br>
<br>
&gt; Le 18/02/2020 =C3=A0 15:27, Cornelia Huck a =C3=A9crit=C2=A0:<br>
&gt; &gt; On Mon, 17 Feb 2020 23:35:36 +0100<br>
&gt; &gt; Laurent Vivier &lt;<a href=3D"mailto:laurent@vivier.eu">laurent@v=
ivier.eu</a>&gt; wrote:<br>
&gt; &gt;=C2=A0 =C2=A0<br>
&gt; &gt;&gt; This series copies the files syscall.tbl from linux v5.5 and =
generates<br>
&gt; &gt;&gt; the file syscall_nr.h from them.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; This is done for all the QEMU targets that have a syscall.tbl=
<br>
&gt; &gt;&gt; in the linux source tree: mips, mips64, i386, x86_64, sparc, =
s390x,<br>
&gt; &gt;&gt; ppc, arm, microblaze, sh4, xtensa, m68k, hppa and alpha.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; tilegx and cris are depecrated in linux (tilegx has no mainta=
iner in QEMU)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; aarch64, nios2, openrisc and riscv have no syscall.tbl in lin=
ux.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; It seems there is a bug in QEMU that forces to disable manual=
ly arch_prctl<br>
&gt; &gt;&gt; with i386 target: do_arch_prctl() is only defined with TARGET=
_ABI32 but<br>
&gt; &gt;&gt; TARGET_ABI32 is never defined with TARGET_I386 (nor TARGET_X8=
6_64).<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I have also removed all syscalls in s390x/syscall_nr.h define=
d for<br>
&gt; &gt;&gt; !defined(TARGET_S390X).<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I have added a script to copy all these files from linux and =
updated<br>
&gt; &gt;&gt; them at the end of the series with their latest version for t=
oday.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; The two last patches manage the special case for mips O32 tha=
t needs<br>
&gt; &gt;&gt; to know the number of arguments. We find them in strace sourc=
es.=C2=A0 <br>
&gt; &gt; <br>
&gt; &gt; I like the idea of generating those files, but I wonder if that s=
hould<br>
&gt; &gt; interact with linux-headers updates.<br>
&gt; &gt; <br>
&gt; &gt; I plan to do a linux-headers update to 5.6-rc?, and I noticed tha=
t this<br>
&gt; &gt; will drag in two new syscalls (openat2 and pidfd_getfd). Now, jus=
t<br>
&gt; &gt; having the new #defines in the headers doesn&#39;t do anything, b=
ut should<br>
&gt; &gt; it be a trigger to update the syscall.tbl files as well? Or does =
that<br>
&gt; &gt; need manual inspection/updating?=C2=A0 <br>
&gt; <br>
&gt; I think it&#39;s a good idea to update the syscall.tbl when we update<=
br>
&gt; linux-headers, and there will be no change at linux-user level while w=
e<br>
&gt; don&#39;t implement the syscall translation in syscall.c:do_syscall1()=
.<br>
<br>
Nod.<br>
<br>
&gt; <br>
&gt; But I think we should also check manually the difference between new a=
nd<br>
&gt; old generated syscall_nr.h to be sure there is nothing broken in what =
we<br>
&gt; introduce.<br>
&gt; <br>
&gt; I always run a Linux Test Project testsuite for all architectures with=
 a<br>
&gt; debian distro when I do a pull request so I can detect regression.<br>
&gt; <br>
&gt; In the end, updating linux-headers should trigger syscall.tbl update b=
ut<br>
&gt; it needs manual inspection.<br>
<br>
I think we should make sure that updating syscall.tbl does not get<br>
forgotten if we do a headers update... have the update script print out<br>
a message? I&#39;m not sure if we want to automate updating the syscall<br>
table, as we want manual inspection for it.<br>
<br>
Maybe have the update script moan about syscall.tbl if unistd.h is<br>
changed? Should be a good enough heuristic.<br>
<br>
That said, I&#39;ll probably queue a headers update on the s390-next branch=
<br>
right now (against current Linus master),=C2=A0</blockquote><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex"><br></blockquote><div><br></div><div>Hi, Cornelia,</div><di=
v><br></div><div>I am not stopping you from updating headers from Linus&#39=
; master, however, I think a better practice would be to do regular updates=
 from each stable kernel release (the last one is 5.5), rather than from an=
 arbitrary kernel-du-jour, which may be the subject of change (including re=
verts) wrt headers between two stable releases.</div><div><br></div><div>Re=
gards,</div><div>Aleksandar</div><div><br></div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex"><br></blockquote><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">unless=
 someone complains --<br>
maybe take the syscall.tbl from that state of the kernel tree as well?<br>
<br>
<br>
</blockquote>

--000000000000faa487059edd41bd--

