Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAC0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:58:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC9292222E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9292222E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSjAB-0003uO-Df
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 11:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kSj76-0002n5-Vw
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:54:53 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38141)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kSj74-0000NO-N5
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:54:52 -0400
Received: by mail-vs1-f67.google.com with SMTP id b3so2368820vsc.5
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 08:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RtSq9+4WoNlvkeLmmPnX/SL3PWPkIWiFR01jAX0ZaLE=;
 b=uXBmrAosSnVlfYqTbUIwyFX7JTes35ilxW4HNwV+XRIsSYDxCeLL9DcnbtwmD6X5G+
 kZ6i6h7oaRtQ16uEbtOMYuKs4vULhROBqpwSL8j7BSk+ECnQt5hEJwB6xazcy0ATpMaT
 HGkL/GANb0NjHGYM24i5DYD0cYjs1MQOgKw/g4CPU1C7wNv1NyotdgK4hybQGLSJjVRI
 Eihl+uMCSAGNDuZxjNkuDoCnsnVnIkNwH4U02FiZACkhEe2Pwiafq+GUVLQKIc8I/QGZ
 h4r3AfIo5r+6fLz7zmxqZtkSAt4l3MxOMY4UEQwowiFaZFMN3mMLDnOMLqOI02UnsFFr
 VQVQ==
X-Gm-Message-State: AOAM531bkn7mp7ya9ZcX2jQzYo4Yi8iWAj9zgp39JRQbs5490RCtsFgb
 oe7mBD4lWr8zz2L+BQOt79s7ua4Y2Hc=
X-Google-Smtp-Source: ABdhPJzf/V+AXenIMWLgdCSaGz1shfJnjGoR0GgZvmikMVZqFbeu/VtN53Gf2VNJSYR3CEjQDO1ThA==
X-Received: by 2002:a05:6102:1144:: with SMTP id
 j4mr1731252vsg.39.1602690888627; 
 Wed, 14 Oct 2020 08:54:48 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com.
 [209.85.217.48])
 by smtp.gmail.com with ESMTPSA id l22sm741945vsa.17.2020.10.14.08.54.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 08:54:48 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id d4so2323971vsk.13
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 08:54:48 -0700 (PDT)
X-Received: by 2002:a67:e30c:: with SMTP id j12mr4204128vsf.1.1602690887916;
 Wed, 14 Oct 2020 08:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201012232939.48481-1-j@getutm.app>
 <20201012232939.48481-6-j@getutm.app>
 <c99464f7-6fd7-e81f-9037-50942706fc24@redhat.com>
 <CAJ+F1CKrNMNa8vJbhh3DnZ8n_W_ee0+G+yLWnHR9C1DkX3za9A@mail.gmail.com>
 <4d52794b-0aed-d8a1-616a-d01226aa8740@redhat.com>
In-Reply-To: <4d52794b-0aed-d8a1-616a-d01226aa8740@redhat.com>
From: Joelle van Dyne <j@getutm.app>
Date: Wed, 14 Oct 2020 08:54:37 -0700
X-Gmail-Original-Message-ID: <CADmqK1skPxur8rBB1xD9rZdnu10gXePowsBkxCQy+UUq-=K5KA@mail.gmail.com>
Message-ID: <CADmqK1skPxur8rBB1xD9rZdnu10gXePowsBkxCQy+UUq-=K5KA@mail.gmail.com>
Subject: Re: [PATCH 05/10] slirp: update for iOS resolv fix
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000f21ba05b1a38d7a"
Received-SPF: pass client-ip=209.85.217.67; envelope-from=osy86github@gmail.com;
 helo=mail-vs1-f67.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 11:54:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000f21ba05b1a38d7a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, I was not aware of the rules for RFC. I will remove this one from
the v2 patch set. If and when the libslirp changes are in, what are the
procedures for sending the QEMU side changes?

-j

On Tue, Oct 13, 2020 at 7:59 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 10/13/20 4:38 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Tue, Oct 13, 2020 at 5:34 PM Philippe Mathieu-Daud=C3=A9
> > <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
> >
> >     On 10/13/20 1:29 AM, Joelle van Dyne wrote:
> >      > From: osy <osy86@users.noreply.github.com
> >     <mailto:osy86@users.noreply.github.com>>
> >      >
> >      > We cannot access /etc/resolv.conf on iOS so libslirp is modified
> >     to use
> >      > libresolv instead.
> >      >
> >      > Signed-off-by: Joelle van Dyne <j@getutm.app>
> >      > ---
> >      >   .gitmodules | 2 +-
> >      >   meson.build | 2 ++
> >      >   slirp       | 2 +-
> >      >   3 files changed, 4 insertions(+), 2 deletions(-)
> >      >
> >      > diff --git a/.gitmodules b/.gitmodules
> >      > index 2bdeeacef8..f23e859210 100644
> >      > --- a/.gitmodules
> >      > +++ b/.gitmodules
> >      > @@ -51,7 +51,7 @@
> >      >       url =3D https://git.qemu.org/git/edk2.git
> >     <https://git.qemu.org/git/edk2.git>
> >      >   [submodule "slirp"]
> >      >       path =3D slirp
> >      > -     url =3D https://git.qemu.org/git/libslirp.git
> >     <https://git.qemu.org/git/libslirp.git>
> >      > +     url =3D https://github.com/utmapp/libslirp.git
> >     <https://github.com/utmapp/libslirp.git>
> >
> >     NAck.
> >
> >     You can not take over the SLiRP project submodule that way.
> >
> >     I suggest getting your SLiRP changes merged with mainstream
> >     instead, see:
> >     https://gitlab.freedesktop.org/slirp/libslirp#contributing
> >     <https://gitlab.freedesktop.org/slirp/libslirp#contributing>
> >
> >
> > I think he did:
> > https://gitlab.freedesktop.org/slirp/libslirp/-/merge_requests/54
> > <https://gitlab.freedesktop.org/slirp/libslirp/-/merge_requests/54>
>
> I am being wary because the series is not posted as RFC.
>
> But from the cover it looks like a RFC series:
>
> * slirp updated to support DNS resolving using libresolv; a separate
>    patch will be submitted to the project. To allow for builds to
>    succeed, the .gitmodule is temporarily changed. We're not entirely
>    sure how cross-project patches should be handled here.
>
> >
> > Btw, I also noticed the coroutine library submodule proposed in this
> > series is a fork from the original library. Not sure what the upstream
> > status is and whether this is fine.
> >
> >      >   [submodule "roms/opensbi"]
> >      >       path =3D roms/opensbi
> >      >       url =3D https://git.qemu.org/git/opensbi.git
> >     <https://git.qemu.org/git/opensbi.git>
> >      > diff --git a/meson.build b/meson.build
> >      > index 32cf08619f..da96e296e0 100644
> >      > --- a/meson.build
> >      > +++ b/meson.build
> >      > @@ -996,6 +996,8 @@ if have_system
> >      >       slirp_deps =3D []
> >      >       if targetos =3D=3D 'windows'
> >      >         slirp_deps =3D cc.find_library('iphlpapi')
> >      > +    elif targetos =3D=3D 'darwin'
> >      > +      slirp_deps =3D cc.find_library('resolv')
> >      >       endif
> >      >       slirp_conf =3D configuration_data()
> >      >       slirp_conf.set('SLIRP_MAJOR_VERSION',
> >     meson.project_version().split('.')[0])
> >      > diff --git a/slirp b/slirp
> >      > index ce94eba204..452c389d82 160000
> >      > --- a/slirp
> >      > +++ b/slirp
> >      > @@ -1 +1 @@
> >      > -Subproject commit ce94eba2042d52a0ba3d9e252ebce86715e94275
> >      > +Subproject commit 452c389d8288f81ec9d59d983a047d4e54f3194e
> >
> >
> >
> >
> > --
> > Marc-Andr=C3=A9 Lureau
>
>
>

--0000000000000f21ba05b1a38d7a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sorry, I was not aware of the rules for RFC. I will remove=
 this one from the v2 patch set. If and when the libslirp=C2=A0changes are =
in, what are the procedures for sending the QEMU side changes?<div><br></di=
v><div>-j</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Oct 13, 2020 at 7:59 AM Philippe Mathieu-Daud=C3=A9=
 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left-width:1px;border-left-style:solid;border-left-color:rgb(204,2=
04,204);padding-left:1ex">On 10/13/20 4:38 PM, Marc-Andr=C3=A9 Lureau wrote=
:<br>
&gt; Hi<br>
&gt; <br>
&gt; On Tue, Oct 13, 2020 at 5:34 PM Philippe Mathieu-Daud=C3=A9 <br>
&gt; &lt;<a href=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redh=
at.com</a> &lt;mailto:<a href=3D"mailto:philmd@redhat.com" target=3D"_blank=
">philmd@redhat.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 10/13/20 1:29 AM, Joelle van Dyne wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; From: osy &lt;<a href=3D"mailto:osy86@users.n=
oreply.github.com" target=3D"_blank">osy86@users.noreply.github.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:osy86@users.noreply.gi=
thub.com" target=3D"_blank">osy86@users.noreply.github.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; We cannot access /etc/resolv.conf on iOS so l=
ibslirp is modified<br>
&gt;=C2=A0 =C2=A0 =C2=A0to use<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; libresolv instead.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: Joelle van Dyne &lt;j@getutm.a=
pp&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0.gitmodules | 2 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0meson.build | 2 ++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0slirp=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 2 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A03 files changed, 4 insertions(+),=
 2 deletions(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/.gitmodules b/.gitmodules<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 2bdeeacef8..f23e859210 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/.gitmodules<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/.gitmodules<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -51,7 +51,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0url =3D <a href=3D"=
https://git.qemu.org/git/edk2.git" rel=3D"noreferrer" target=3D"_blank">htt=
ps://git.qemu.org/git/edk2.git</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://git.qemu.org/git/edk2.git" r=
el=3D"noreferrer" target=3D"_blank">https://git.qemu.org/git/edk2.git</a>&g=
t;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0[submodule &quot;slirp&quot;]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0path =3D slirp<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -=C2=A0 =C2=A0 =C2=A0url =3D <a href=3D"https=
://git.qemu.org/git/libslirp.git" rel=3D"noreferrer" target=3D"_blank">http=
s://git.qemu.org/git/libslirp.git</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://git.qemu.org/git/libslirp.gi=
t" rel=3D"noreferrer" target=3D"_blank">https://git.qemu.org/git/libslirp.g=
it</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0url =3D <a href=3D"https=
://github.com/utmapp/libslirp.git" rel=3D"noreferrer" target=3D"_blank">htt=
ps://github.com/utmapp/libslirp.git</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://github.com/utmapp/libslirp.g=
it" rel=3D"noreferrer" target=3D"_blank">https://github.com/utmapp/libslirp=
.git</a>&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0NAck.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0You can not take over the SLiRP project submodule t=
hat way.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I suggest getting your SLiRP changes merged with ma=
instream<br>
&gt;=C2=A0 =C2=A0 =C2=A0instead, see:<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://gitlab.freedesktop.org/slirp/lib=
slirp#contributing" rel=3D"noreferrer" target=3D"_blank">https://gitlab.fre=
edesktop.org/slirp/libslirp#contributing</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://gitlab.freedesktop.org/slirp=
/libslirp#contributing" rel=3D"noreferrer" target=3D"_blank">https://gitlab=
.freedesktop.org/slirp/libslirp#contributing</a>&gt;<br>
&gt; <br>
&gt; <br>
&gt; I think he did: <br>
&gt; <a href=3D"https://gitlab.freedesktop.org/slirp/libslirp/-/merge_reque=
sts/54" rel=3D"noreferrer" target=3D"_blank">https://gitlab.freedesktop.org=
/slirp/libslirp/-/merge_requests/54</a> <br>
&gt; &lt;<a href=3D"https://gitlab.freedesktop.org/slirp/libslirp/-/merge_r=
equests/54" rel=3D"noreferrer" target=3D"_blank">https://gitlab.freedesktop=
.org/slirp/libslirp/-/merge_requests/54</a>&gt;<br>
<br>
I am being wary because the series is not posted as RFC.<br>
<br>
But from the cover it looks like a RFC series:<br>
<br>
* slirp updated to support DNS resolving using libresolv; a separate<br>
=C2=A0 =C2=A0patch will be submitted to the project. To allow for builds to=
<br>
=C2=A0 =C2=A0succeed, the .gitmodule is temporarily changed. We&#39;re not =
entirely<br>
=C2=A0 =C2=A0sure how cross-project patches should be handled here.<br>
<br>
&gt; <br>
&gt; Btw, I also noticed the coroutine library submodule proposed in this <=
br>
&gt; series is a fork from the original library. Not sure what the upstream=
 <br>
&gt; status is and whether this is fine.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0[submodule &quot;roms/opensbi&quo=
t;]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0path =3D roms/opens=
bi<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0url =3D <a href=3D"=
https://git.qemu.org/git/opensbi.git" rel=3D"noreferrer" target=3D"_blank">=
https://git.qemu.org/git/opensbi.git</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://git.qemu.org/git/opensbi.git=
" rel=3D"noreferrer" target=3D"_blank">https://git.qemu.org/git/opensbi.git=
</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/meson.build b/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 32cf08619f..da96e296e0 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -996,6 +996,8 @@ if have_system<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0slirp_deps =3D []<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if targetos =3D=3D =
&#39;windows&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0slirp_deps =
=3D cc.find_library(&#39;iphlpapi&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 elif targetos =3D=3D &#39;darw=
in&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 slirp_deps =3D cc.find_=
library(&#39;resolv&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0slirp_conf =3D conf=
iguration_data()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0slirp_conf.set(&#39=
;SLIRP_MAJOR_VERSION&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0meson.project_version().split(&#39;.&#39;)[0])<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/slirp b/slirp<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index ce94eba204..452c389d82 160000<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/slirp<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/slirp<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -1 +1 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -Subproject commit ce94eba2042d52a0ba3d9e252e=
bce86715e94275<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +Subproject commit 452c389d8288f81ec9d59d983a=
047d4e54f3194e<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; -- <br>
&gt; Marc-Andr=C3=A9 Lureau<br>
<br>
<br>
</blockquote></div>

--0000000000000f21ba05b1a38d7a--

