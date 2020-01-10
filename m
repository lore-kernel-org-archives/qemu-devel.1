Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA847C33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 08:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA902072E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 08:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA902072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ippdB-0005Mv-VJ
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 03:26:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ippcX-0004aB-7X
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 03:26:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ippcT-0004rV-3O
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 03:26:17 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38501)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ippcS-0004ny-V2
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 03:26:13 -0500
Received: by mail-yw1-f67.google.com with SMTP id 10so374466ywv.5
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 00:26:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vnW91p0D4LbnQOTBltGPp9J5/nmmhN5FkHVlD//TexM=;
 b=OSqdpfzmPGEFWmsqcJ24tjUT1LiTfT5+MDAS6irD7pbkhyJ/0pUoOOsV9GpishIE0z
 lUgc+gHa349OZMu3RoBURpHx0mC259cwmk1zI13ng5u4VEpA4LLhR+gBAouO89sN6ob3
 gdQ5A4NU0qTm9eFtNE5E+Z9jF2bleXN6fxY4kdp6q2vFOI3LjgWiKuCF09FC7O/eZuqZ
 tUQzMklBWQZnax9nikdQnxaDTyfBZ1/nRnqyRuvKHQIASBEyvhaRcaHoBQ+PpkxfNka7
 q0mVXeBODk/LbTV+3W2hXS6sGFU5sjWlgQ63sNkqTSYL/sCZ1aqSQvSW3IuXqFGaPNJf
 2wmg==
X-Gm-Message-State: APjAAAV+whYNfj4Dgawl8XT67caAkAwwk8T9LAkD4jM5DS31rL6hSyZX
 WudnsC2X3Mzk33XlgnPSOsGOZosk0QfekzciY3o=
X-Google-Smtp-Source: APXvYqwhzkxsAX6fH6tuzi2iR/AT+uBRjN2zd8su3JUGUV8oXjLZLLBRtiB4rSbIOrnfxtcfpDzbNb+RStSrQU78kUQ=
X-Received: by 2002:a81:3b15:: with SMTP id i21mr1782076ywa.368.1578644771856; 
 Fri, 10 Jan 2020 00:26:11 -0800 (PST)
MIME-Version: 1.0
References: <20200109153939.27173-1-philmd@redhat.com>
 <20200109153939.27173-4-philmd@redhat.com>
 <fbc4e5a3-afb2-1a6e-5c22-30d2b91cd8db@redhat.com>
In-Reply-To: <fbc4e5a3-afb2-1a6e-5c22-30d2b91cd8db@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 10 Jan 2020 09:25:22 +0100
Message-ID: <CAAdtpL7DQrs1OtkNax9tohOWo4Wabt-SASY1O0eCU7brU0SSNQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] Makefile: Restrict system emulation and tools objects
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000da6892059bc4e004"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.161.67
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000da6892059bc4e004
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 10 janv. 2020 09:18, Thomas Huth <thuth@redhat.com> a =C3=A9crit :

> On 09/01/2020 16.39, Philippe Mathieu-Daud=C3=A9 wrote:
> > Restrict all the system emulation and tools objects with a
> > Makefile IF (CONFIG_SOFTMMU OR CONFIG_TOOLS) check.
> >
> > Using the same description over and over is not very helpful.
> > Use it once, just before the if() block.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> >  Makefile.objs | 19 +++++++------------
> >  1 file changed, 7 insertions(+), 12 deletions(-)
> >
> > diff --git a/Makefile.objs b/Makefile.objs
> > index 5aae561984..395dd1e670 100644
> > --- a/Makefile.objs
> > +++ b/Makefile.objs
> > @@ -4,16 +4,15 @@ stub-obj-y =3D stubs/
> >  util-obj-y =3D crypto/ util/ qobject/ qapi/
> >  qom-obj-y =3D qom/
> >
> > +######################################################################=
#
> > +# code used by both qemu system emulation and qemu-img
> > +
> > +ifeq ($(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS)),y)
>
> That ",y" at the end looks wrong?
>

It's the result of the logical OR.

--000000000000da6892059bc4e004
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">Le ven. 10 janv. 2020 09:18, Thomas Huth &lt;<a href=3D"mailto=
:thuth@redhat.com">thuth@redhat.com</a>&gt; a =C3=A9crit=C2=A0:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">On 09/01/2020 16.39, Philippe Mathieu-Daud=C3=
=A9 wrote:<br>
&gt; Restrict all the system emulation and tools objects with a<br>
&gt; Makefile IF (CONFIG_SOFTMMU OR CONFIG_TOOLS) check.<br>
&gt; <br>
&gt; Using the same description over and over is not very helpful.<br>
&gt; Use it once, just before the if() block.<br>
&gt; <br>
&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philm=
d@redhat.com" target=3D"_blank" rel=3D"noreferrer">philmd@redhat.com</a>&gt=
;<br>
&gt; ---<br>
&gt;=C2=A0 Makefile.objs | 19 +++++++------------<br>
&gt;=C2=A0 1 file changed, 7 insertions(+), 12 deletions(-)<br>
&gt; <br>
&gt; diff --git a/Makefile.objs b/Makefile.objs<br>
&gt; index 5aae561984..395dd1e670 100644<br>
&gt; --- a/Makefile.objs<br>
&gt; +++ b/Makefile.objs<br>
&gt; @@ -4,16 +4,15 @@ stub-obj-y =3D stubs/<br>
&gt;=C2=A0 util-obj-y =3D crypto/ util/ qobject/ qapi/<br>
&gt;=C2=A0 qom-obj-y =3D qom/<br>
&gt;=C2=A0 <br>
&gt; +#####################################################################=
##<br>
&gt; +# code used by both qemu system emulation and qemu-img<br>
&gt; +<br>
&gt; +ifeq ($(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS)),y)<br>
<br>
That &quot;,y&quot; at the end looks wrong?<br></blockquote></div></div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">It&#39;s the result of the logic=
al OR.</div></div>

--000000000000da6892059bc4e004--

