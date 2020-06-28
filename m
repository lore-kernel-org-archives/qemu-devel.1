Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70E7C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:17:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A8C20738
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XExUYfmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A8C20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpY7M-000487-T0
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 10:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.tribble@gmail.com>)
 id 1jpY6j-0003fV-KH
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:16:33 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:32865)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.tribble@gmail.com>)
 id 1jpY6h-0003pG-JX
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:16:33 -0400
Received: by mail-oi1-x22a.google.com with SMTP id k22so934748oib.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 07:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j2c75Dc40xqiMRHW+fKUjqNc7Kg5vNtLGA1SdtpsEy0=;
 b=XExUYfmcuAhEFx8G5tt9K9Yq0NEGlMXVWe6HFtcn7H9Hn/qiaJcjv/r3G8TTxdTY8A
 TapKAtY4T8b3aXNkEWNKC2mUYoyZySU7uEC491puUkdke/cIjVn/3A6P9Cj0ybd+cztA
 fZ099Jmvnznb9/FvdMBPtiqUBVPBBqFzXUL9kYAyJL5nhDLzJvohiDPveEPalJ+c33kY
 0hN8X9G8x4t6iwZExOeme9zf15URkuXFqOswdpeUBMQb9f7aZoEiApjvAT+l9ahROZZK
 8hefYBHzbZtce0onM0/oQIXyx4kD7z0JUwXgB6RAPOChh9kOTI1YpSwm5r37/2i6vrLd
 Xg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j2c75Dc40xqiMRHW+fKUjqNc7Kg5vNtLGA1SdtpsEy0=;
 b=tByic5HluNZ3d7OnMII2zboCg6MGz2Kt1QY+PEKjPkgnL7SBSKS83rTVCh3QTCMi4G
 yV34F9EtLzxcub71+5AcZ6ogN0agdKdQabWVq2uL0wZZcIsALFwWEi2QRXJMrXSji/FB
 mHllRxtxKgjSBMx5srbQC8Xt/E05WWY9Tkpd+f9ZF4SkkLxLG6LNaFC5GUFI3aXpoaJ3
 uIgY+21OOcgFwrLLPyx4aIhDzPa4ZTX92nmgNT7rFiubA/D5CXWBCSCXpMI+HexPLBWC
 4r6rBdj9M8bABFO5fXEd+RTiMkuuPDOVPOnVIRMrq840CnTBUWQyJLbqI6s1tuZfYCX6
 fLgw==
X-Gm-Message-State: AOAM533UAiF1Wl1KZZ1fynThfu2Qu73GcxX23xBeCVFm+eUEcOHm50JG
 /1JIAgNjM0FiQATWgzm4v/7/u6uRLVp3XggJ3g==
X-Google-Smtp-Source: ABdhPJw+cG1P7L0+ldL6/fT4+XMqr10sFNeePgLQkdE9qFE37IKLuLANDMf/6AgVgXaU5QRfzmyBhTbQH6ifOYECEFw=
X-Received: by 2002:aca:d681:: with SMTP id n123mr9108941oig.82.1593353790161; 
 Sun, 28 Jun 2020 07:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <5EF7B7DB.6040305@mindspring.com>
 <CAFEAcA8RB5PdafUSM0hH0paw7MFTv-RJ1-Z6SdJWNsC7hvyToQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8RB5PdafUSM0hH0paw7MFTv-RJ1-Z6SdJWNsC7hvyToQ@mail.gmail.com>
From: Peter Tribble <peter.tribble@gmail.com>
Date: Sun, 28 Jun 2020 15:16:00 +0100
Message-ID: <CAEgYsbE7s5hD+5ARj_Xt1D0ALDPDQx7uvocd5zRF6P=EzwxTZQ@mail.gmail.com>
Subject: Re: Building in Solaris 11.4
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000aa076305a9259629"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=peter.tribble@gmail.com; helo=mail-oi1-x22a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Michele Denber <denber@mindspring.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000aa076305a9259629
Content-Type: text/plain; charset="UTF-8"

On Sun, Jun 28, 2020 at 2:23 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Sat, 27 Jun 2020 at 23:05, Michele Denber <denber@mindspring.com>
> wrote:
> >
> > Well I removed the "static" from the line
> >
> > static int openpty(int *amaster, int *aslave, char *name,
> >                    struct termios *termp, struct winsize *winp)
> >
> > in util/qemu-openpty.c.  I odn't know if that was the right thing to do
> but it did allow it to compile.
>
> No, that doesn't sound right. The code in qemu-openpty.c
> for Solaris assumes that solaris does not provide
> openpty(), and so it provides its own implementation.
> This is a very old bit of portability-workaround. It
> sounds like at least some Solaris versions do provide
> a system openpty() in termios.h (in libc, or perhaps
> needing an extra -lsomething?), in which case we want
> to detect that and use it (not compiling the QEMU
> code for solaris-without-openpty).
>
> The first thing to do here would be to find out which
> versions of Solaris provide openpty(), and which header
> and library need to be used to compile code that uses it.
> The gnulib docs think it is missing on Solaris 11.3:
> do we care about supporting that as a host OS?
> https://www.gnu.org/software/gnulib/manual/html_node/openpty.html
>

I think you need to support older versions that don't ship openpty(),
as 11.4 dropped support for a lot of older hardware so people with
existing (older but working) hardware won't be able to upgrade to it.

Also, illumos doesn't (yet) have openpty.


> Then you'd need to improve configure so that it looked for
> "does the system provide openpty() via termios.h" and defined
> CONFIG_OPENPTY_IN_TERMIOS to indicate that; then if that is
> set we qemu-openpty.c can make solaris use the "system has
> openpty()" codepath rather than "system doesn't have that".
> If it turns out that all Solaris versions new enough that we
> might care about them do have openpty() we could also delete
> the handling code for systems that don't.
>
> > CC      monitor/trace.o
> > util/drm.c: In function 'qemu_drm_rendernode_open':
> > util/drm.c:41:16: error: 'struct dirent' has no member named 'd_type';
> did you mean 'd_name'?
> >          if (e->d_type != DT_CHR) {
> >                 ^~~~~~
> >                 d_name
> > util/drm.c:41:26: error: 'DT_CHR' undeclared (first use in this
> function); did you mean 'TH_CWR'?
> >          if (e->d_type != DT_CHR) {
> >                           ^~~~~~
> >                           TH_CWR
> > util/drm.c:41:26: note: each undeclared identifier is reported only once
> for each function it appears in
> > gmake: *** [/export/home/denber/qemu-5.0.0/rules.mak:69: util/drm.o]
> Error 1
> >
> > This looks like more "not in Solaris" POSIX stuff.
>
> Ah, the Haiku folks just ran into exactly this issue.
> Their fix should also be good for Solaris:
> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg08800.html
> (This whole file is for using a Linux-specific feature so there's
> no point even compiling it for other OSes.)
>
> thanks
> -- PMM
>
>

-- 
-Peter Tribble
http://www.petertribble.co.uk/ - http://ptribble.blogspot.com/

--000000000000aa076305a9259629
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Jun 28, 2020 at 2:23 PM Peter=
 Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@lina=
ro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Sat, 27 Jun 2020 at 23:05, Michele Denber &lt;<a href=3D"mailto:de=
nber@mindspring.com" target=3D"_blank">denber@mindspring.com</a>&gt; wrote:=
<br>
&gt;<br>
&gt; Well I removed the &quot;static&quot; from the line<br>
&gt;<br>
&gt; static int openpty(int *amaster, int *aslave, char *name,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s=
truct termios *termp, struct winsize *winp)<br>
&gt;<br>
&gt; in util/qemu-openpty.c.=C2=A0 I odn&#39;t know if that was the right t=
hing to do but it did allow it to compile.<br>
<br>
No, that doesn&#39;t sound right. The code in qemu-openpty.c<br>
for Solaris assumes that solaris does not provide<br>
openpty(), and so it provides its own implementation.<br>
This is a very old bit of portability-workaround. It<br>
sounds like at least some Solaris versions do provide<br>
a system openpty() in termios.h (in libc, or perhaps<br>
needing an extra -lsomething?), in which case we want<br>
to detect that and use it (not compiling the QEMU<br>
code for solaris-without-openpty).<br>
<br>
The first thing to do here would be to find out which<br>
versions of Solaris provide openpty(), and which header<br>
and library need to be used to compile code that uses it.<br>
The gnulib docs think it is missing on Solaris 11.3:<br>
do we care about supporting that as a host OS?<br>
<a href=3D"https://www.gnu.org/software/gnulib/manual/html_node/openpty.htm=
l" rel=3D"noreferrer" target=3D"_blank">https://www.gnu.org/software/gnulib=
/manual/html_node/openpty.html</a><br></blockquote><div><br></div><div>I th=
ink you need to support older versions that don&#39;t ship openpty(),<br></=
div><div>as 11.4 dropped support for a lot of older hardware so people with=
<br></div><div>existing (older but working) hardware won&#39;t be able to u=
pgrade to it.<br><br></div><div>Also, illumos doesn&#39;t (yet) have openpt=
y.<br></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
Then you&#39;d need to improve configure so that it looked for<br>
&quot;does the system provide openpty() via termios.h&quot; and defined<br>
CONFIG_OPENPTY_IN_TERMIOS to indicate that; then if that is<br>
set we qemu-openpty.c can make solaris use the &quot;system has<br>
openpty()&quot; codepath rather than &quot;system doesn&#39;t have that&quo=
t;.<br>
If it turns out that all Solaris versions new enough that we<br>
might care about them do have openpty() we could also delete<br>
the handling code for systems that don&#39;t.<br>
<br>
&gt; CC=C2=A0 =C2=A0 =C2=A0 monitor/trace.o<br>
&gt; util/drm.c: In function &#39;qemu_drm_rendernode_open&#39;:<br>
&gt; util/drm.c:41:16: error: &#39;struct dirent&#39; has no member named &=
#39;d_type&#39;; did you mean &#39;d_name&#39;?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (e-&gt;d_type !=3D DT_CHR) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d_name<br=
>
&gt; util/drm.c:41:26: error: &#39;DT_CHR&#39; undeclared (first use in thi=
s function); did you mean &#39;TH_CWR&#39;?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (e-&gt;d_type !=3D DT_CHR) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0TH_CWR<br>
&gt; util/drm.c:41:26: note: each undeclared identifier is reported only on=
ce for each function it appears in<br>
&gt; gmake: *** [/export/home/denber/qemu-5.0.0/rules.mak:69: util/drm.o] E=
rror 1<br>
&gt;<br>
&gt; This looks like more &quot;not in Solaris&quot; POSIX stuff.<br>
<br>
Ah, the Haiku folks just ran into exactly this issue.<br>
Their fix should also be good for Solaris:<br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg08800.h=
tml" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/archive/htm=
l/qemu-devel/2020-06/msg08800.html</a><br>
(This whole file is for using a Linux-specific feature so there&#39;s<br>
no point even compiling it for other OSes.)<br>
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">-Peter Tribble<br><a href=3D"http://www.petertribble.co.uk/=
" target=3D"_blank">http://www.petertribble.co.uk/</a> - <a href=3D"http://=
ptribble.blogspot.com/" target=3D"_blank">http://ptribble.blogspot.com/</a>=
</div></div>

--000000000000aa076305a9259629--

