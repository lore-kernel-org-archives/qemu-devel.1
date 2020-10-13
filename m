Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34CBC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:44:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 383652488C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWuOlWza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383652488C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSLXO-00048c-9i
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 10:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kSLRe-0005dl-S9
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:38:31 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:34767)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kSLRc-0002tH-Ee
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:38:30 -0400
Received: by mail-ed1-x542.google.com with SMTP id x1so21193246eds.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 07:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vkkCEAzRZ+GHLCCyUXgk7nSupq24bzVc91Ut7QQ2IY0=;
 b=GWuOlWzaS4suA0SRr/V3ZWiK6OqdL6ZVtKfzkavtAbkF3Ga6ZVjxmjmQFl+3R57Lcp
 cxVbOa04QUFfrx09yERCl8fwEeYkHf21nsWmgfDzpMEo7u74EGeMu6CkaLPUTti820a2
 wOVBugJKZlVqu5frpOvd8wa4vSBEuEJ6bZqy7Ag0noE5MREPLzz/ry76kNMAVpqOHg37
 lNv8XUet70CpCwk2qAJON17DFYE/TtBmrC5WmWF7b1I/sBE113R1LY1fJtoTbIw75Oti
 X/LPiUWgHOPml9UoHpk2cM6WNVjUlNlXhDjZEZka7j0K5KUJTrfgOwiIZLYfn7Ch+8YD
 usYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vkkCEAzRZ+GHLCCyUXgk7nSupq24bzVc91Ut7QQ2IY0=;
 b=UQTt1EncckTnRyeJOLBbkahAWN6zmcpmivcHBdSiI0Lq9RlEdj/PqvRpXYlOp/mRPt
 nAyKTr+hximwdqnpMEMQq6dRGllI9ZuZ9n58Gcaui1i/ZrKSZNYDupk1TUSUlRv3wv/R
 SvCHiF6epvloaaoWonXmyLnELKjDTb8DtxpRHcw1EPgfpFPmRAthsR8dPgLZ6djKVAmX
 6SiHK0lyx4D3vj+XzVYotBiplQ80XmivUQj78hUXzb32Z7q4xjhu3oF5/enTEHUE37fQ
 U6NMItobQr3lrLWUr4DQAFSbu5WaprTQROVg24nRHboCDICfDkTWhw+8EEWcDYvs7GRJ
 gKMw==
X-Gm-Message-State: AOAM5319+6YYD5QSbdk0nuQeJ8Hqmp/a2fLVy6uKvsGZbPu/kvYdxtFO
 hXZ8w6HS2TBWjIwitinyytgi7Kt5ubgSmA3gyXE=
X-Google-Smtp-Source: ABdhPJzLXbnFiBNz0q3p8KWC4Pm1+t5QNY2EOHh3YJYSSkSeSFNqQWhWoQw0D89Nm3n9Ovf0Arj7B3ECORWzgaZUQt0=
X-Received: by 2002:aa7:cd98:: with SMTP id x24mr19976445edv.237.1602599904866; 
 Tue, 13 Oct 2020 07:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201012232939.48481-1-j@getutm.app>
 <20201012232939.48481-6-j@getutm.app>
 <c99464f7-6fd7-e81f-9037-50942706fc24@redhat.com>
In-Reply-To: <c99464f7-6fd7-e81f-9037-50942706fc24@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 13 Oct 2020 18:38:11 +0400
Message-ID: <CAJ+F1CKrNMNa8vJbhh3DnZ8n_W_ee0+G+yLWnHR9C1DkX3za9A@mail.gmail.com>
Subject: Re: [PATCH 05/10] slirp: update for iOS resolv fix
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000bf4dd05b18e5e0a"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Joelle van Dyne <j@getutm.app>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000bf4dd05b18e5e0a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Oct 13, 2020 at 5:34 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 10/13/20 1:29 AM, Joelle van Dyne wrote:
> > From: osy <osy86@users.noreply.github.com>
> >
> > We cannot access /etc/resolv.conf on iOS so libslirp is modified to use
> > libresolv instead.
> >
> > Signed-off-by: Joelle van Dyne <j@getutm.app>
> > ---
> >   .gitmodules | 2 +-
> >   meson.build | 2 ++
> >   slirp       | 2 +-
> >   3 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/.gitmodules b/.gitmodules
> > index 2bdeeacef8..f23e859210 100644
> > --- a/.gitmodules
> > +++ b/.gitmodules
> > @@ -51,7 +51,7 @@
> >       url =3D https://git.qemu.org/git/edk2.git
> >   [submodule "slirp"]
> >       path =3D slirp
> > -     url =3D https://git.qemu.org/git/libslirp.git
> > +     url =3D https://github.com/utmapp/libslirp.git
>
> NAck.
>
> You can not take over the SLiRP project submodule that way.
>
> I suggest getting your SLiRP changes merged with mainstream
> instead, see:
> https://gitlab.freedesktop.org/slirp/libslirp#contributing
>
>
I think he did:
https://gitlab.freedesktop.org/slirp/libslirp/-/merge_requests/54

Btw, I also noticed the coroutine library submodule proposed in this series
is a fork from the original library. Not sure what the upstream status is
and whether this is fine.

>   [submodule "roms/opensbi"]
> >       path =3D roms/opensbi
> >       url =3D   https://git.qemu.org/git/opensbi.git
> > diff --git a/meson.build b/meson.build
> > index 32cf08619f..da96e296e0 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -996,6 +996,8 @@ if have_system
> >       slirp_deps =3D []
> >       if targetos =3D=3D 'windows'
> >         slirp_deps =3D cc.find_library('iphlpapi')
> > +    elif targetos =3D=3D 'darwin'
> > +      slirp_deps =3D cc.find_library('resolv')
> >       endif
> >       slirp_conf =3D configuration_data()
> >       slirp_conf.set('SLIRP_MAJOR_VERSION',
> meson.project_version().split('.')[0])
> > diff --git a/slirp b/slirp
> > index ce94eba204..452c389d82 160000
> > --- a/slirp
> > +++ b/slirp
> > @@ -1 +1 @@
> > -Subproject commit ce94eba2042d52a0ba3d9e252ebce86715e94275
> > +Subproject commit 452c389d8288f81ec9d59d983a047d4e54f3194e
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000000bf4dd05b18e5e0a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 13, 2020 at 5:34 PM Phi=
lippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@re=
dhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">On 10/13/20 1:29 AM, Joelle van Dyne wrote:<br>
&gt; From: osy &lt;<a href=3D"mailto:osy86@users.noreply.github.com" target=
=3D"_blank">osy86@users.noreply.github.com</a>&gt;<br>
&gt; <br>
&gt; We cannot access /etc/resolv.conf on iOS so libslirp is modified to us=
e<br>
&gt; libresolv instead.<br>
&gt; <br>
&gt; Signed-off-by: Joelle van Dyne &lt;j@getutm.app&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0.gitmodules | 2 +-<br>
&gt;=C2=A0 =C2=A0meson.build | 2 ++<br>
&gt;=C2=A0 =C2=A0slirp=C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<br>
&gt;=C2=A0 =C2=A03 files changed, 4 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/.gitmodules b/.gitmodules<br>
&gt; index 2bdeeacef8..f23e859210 100644<br>
&gt; --- a/.gitmodules<br>
&gt; +++ b/.gitmodules<br>
&gt; @@ -51,7 +51,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0url =3D <a href=3D"https://git.qemu.org/git/=
edk2.git" rel=3D"noreferrer" target=3D"_blank">https://git.qemu.org/git/edk=
2.git</a><br>
&gt;=C2=A0 =C2=A0[submodule &quot;slirp&quot;]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0path =3D slirp<br>
&gt; -=C2=A0 =C2=A0 =C2=A0url =3D <a href=3D"https://git.qemu.org/git/libsl=
irp.git" rel=3D"noreferrer" target=3D"_blank">https://git.qemu.org/git/libs=
lirp.git</a><br>
&gt; +=C2=A0 =C2=A0 =C2=A0url =3D <a href=3D"https://github.com/utmapp/libs=
lirp.git" rel=3D"noreferrer" target=3D"_blank">https://github.com/utmapp/li=
bslirp.git</a><br>
<br>
NAck.<br>
<br>
You can not take over the SLiRP project submodule that way.<br>
<br>
I suggest getting your SLiRP changes merged with mainstream<br>
instead, see:<br>
<a href=3D"https://gitlab.freedesktop.org/slirp/libslirp#contributing" rel=
=3D"noreferrer" target=3D"_blank">https://gitlab.freedesktop.org/slirp/libs=
lirp#contributing</a><br>
<br></blockquote><div><br></div><div>I think he did: <a href=3D"https://git=
lab.freedesktop.org/slirp/libslirp/-/merge_requests/54">https://gitlab.free=
desktop.org/slirp/libslirp/-/merge_requests/54</a></div><div><br></div><div=
>Btw, I also noticed the coroutine library submodule proposed in this serie=
s is a fork from the original library. Not sure what the upstream status is=
 and whether this is fine.</div><div><br> </div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
&gt;=C2=A0 =C2=A0[submodule &quot;roms/opensbi&quot;]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0path =3D roms/opensbi<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0url =3D=C2=A0 =C2=A0<a href=3D"https://git.q=
emu.org/git/opensbi.git" rel=3D"noreferrer" target=3D"_blank">https://git.q=
emu.org/git/opensbi.git</a><br>
&gt; diff --git a/meson.build b/meson.build<br>
&gt; index 32cf08619f..da96e296e0 100644<br>
&gt; --- a/meson.build<br>
&gt; +++ b/meson.build<br>
&gt; @@ -996,6 +996,8 @@ if have_system<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0slirp_deps =3D []<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if targetos =3D=3D &#39;windows&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0slirp_deps =3D cc.find_library(&#39;i=
phlpapi&#39;)<br>
&gt; +=C2=A0 =C2=A0 elif targetos =3D=3D &#39;darwin&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 slirp_deps =3D cc.find_library(&#39;resolv&#39;)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0slirp_conf =3D configuration_data()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0slirp_conf.set(&#39;SLIRP_MAJOR_VERSION&#39;=
, meson.project_version().split(&#39;.&#39;)[0])<br>
&gt; diff --git a/slirp b/slirp<br>
&gt; index ce94eba204..452c389d82 160000<br>
&gt; --- a/slirp<br>
&gt; +++ b/slirp<br>
&gt; @@ -1 +1 @@<br>
&gt; -Subproject commit ce94eba2042d52a0ba3d9e252ebce86715e94275<br>
&gt; +Subproject commit 452c389d8288f81ec9d59d983a047d4e54f3194e<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000000bf4dd05b18e5e0a--

