Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7423DC433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:39:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D37C2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTei+Qkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D37C2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAqyC-0003FR-0E
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 04:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kAqxW-0002pb-HK
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:39:06 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:38107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kAqxU-0000Pg-Ea
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:39:06 -0400
Received: by mail-ed1-x544.google.com with SMTP id b2so1017589edw.5
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 01:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nIJQg+8J+SR99dD888D0GFwHpuBt874o2Mw5bGZWhaM=;
 b=FTei+QkfVlpHh5BBN9hW4+W0EGV3Q9KKwkID52A+6hdUA6HkbHF8LlWIoGC5lejVmB
 rXuqVL9YKtWVxsOR4vcgOQJ9LWRDk3JEJ+voYZPA+HYFn0i9s90sQsrTbVKRgzT11WkZ
 r154z+Hf7P/Kdat+p02+agE+ynu1QmZqw2NqDzvImSV3VQY+Yj68T0c6gCuUFVSp/11O
 cn/Jit5kFT/zGV77TcB6JQYwUmW4cVV8xZhL0zDI+yINgMD6aeWzE2bFC4hl0bfKBd52
 /PMo2H6p/xpPdO17UA8/g7LAFiwvL1DKpHXpuU69BWfss7XkxvOncWGD1Ef4yQwqRZsv
 q3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nIJQg+8J+SR99dD888D0GFwHpuBt874o2Mw5bGZWhaM=;
 b=PDctDiwpUFD8MnewWKYiSvTS18+v3LmW/AGKxn9O/bA9bjVg13CywaLpEXLtWGiKVb
 nZlyYYk/OeL2o6yC//mTQtG6OeQx59mPpEBwX1wkDF7PZOJ7IYQvIRRToQpR7VMX1027
 nw2Fg00Qy7oie2zqpw2zHpslk4WLXvYFQ3KJvNVUWWlAywWpB4ox4itNeMuAg/ynrL/+
 c1QIX1czh5BS0zRLjpY/6KbDQefUbXyDwjJ52YTXuIThP9y3uIM6slA/7zRi9+8yjYEU
 Qf5gTVm1kA7leJy/L8xcf/4w1U7x5pnjkEzR6jAPEBkQ04eg7JfdLSzOjbAUjG8gtvLf
 UNog==
X-Gm-Message-State: AOAM531k8G3nShVM66sC5yuco1/qN/gz8xgvgykE+6xwC8QYoVzRYzLr
 HgPiLxWbTjEABoqu7VVFjnoDUM+JvF6LL8o6kPk=
X-Google-Smtp-Source: ABdhPJx9QBeqni+4aWhUljgZORYHgkwz8aeSau0SSIMf9tA9+PEubdP6/VVxq7U5x+Yy1JoLRPQ3CQiokKVx8aNiT/o=
X-Received: by 2002:a05:6402:1427:: with SMTP id
 c7mr14577534edx.245.1598431141760; 
 Wed, 26 Aug 2020 01:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200825175827.355940-1-marcandre.lureau@redhat.com>
 <20200825175827.355940-4-marcandre.lureau@redhat.com>
 <20200826083234.GE168515@redhat.com>
In-Reply-To: <20200826083234.GE168515@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 26 Aug 2020 12:38:50 +0400
Message-ID: <CAJ+F1C+8a_wYynmqyxc++8yvxzU17J678okXGnf=v5iXAxdyPA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] meson: add docdir option and pass pre-prefix
 qemu_docdir
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000067147105adc3c004"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x544.google.com
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
Cc: Stefan Weil <sw@weilnetz.de>, QEMU <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000067147105adc3c004
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Aug 26, 2020 at 12:32 PM Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om>
wrote:

> On Tue, Aug 25, 2020 at 09:58:25PM +0400, marcandre.lureau@redhat.com
> wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > When cross-compiling, by default qemu_docdir is 'c:\Program Files\QEMU\=
'
> > which is not recognized as being an absolute path, and meson will end u=
p
> > adding the prefix again.
> >
> > Add an option to pass docdir location to meson, pre-prefixed like we do
> > with other directories and use that instead of
> config_host['qemu_docdir'].
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  configure         | 1 +
> >  docs/meson.build  | 4 ++--
> >  meson.build       | 3 ++-
> >  meson_options.txt | 1 +
> >  4 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/configure b/configure
> > index e19e2de2f0..e644841299 100755
> > --- a/configure
> > +++ b/configure
> > @@ -8223,6 +8223,7 @@ NINJA=3D$PWD/ninjatool $meson setup \
> >          --sysconfdir "${pre_prefix}$sysconfdir" \
> >          --localstatedir "${pre_prefix}$local_statedir" \
> >          -Dconfsuffix=3D"$confsuffix" \
> > +        -Ddocdir=3D"${pre_prefix}$qemu_docdir" \
>
> This is passing an absolute path.....
>
>
> > diff --git a/meson_options.txt b/meson_options.txt
> > index 7bb2c0fca9..fb9312fddd 100644
> > --- a/meson_options.txt
> > +++ b/meson_options.txt
> > @@ -1,4 +1,5 @@
> >  option('confsuffix', type : 'string', value: 'qemu')
> > +option('docdir', type : 'string', value : 'doc/qemu')
>
> ...but this default is a relative dir, presumably relative to
> datadir.  The code expects an absolute dir.
>


Meson accepts both absolute and relative path for installation location. If
it's relative, it will be under the $prefix directory.


>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000067147105adc3c004
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 26, 2020 at 12:32 PM Da=
niel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@r=
edhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Tue, Aug 25, 2020 at 09:58:25PM +0400, <a href=3D"mailto:marc=
andre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a> =
wrote:<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; <br>
&gt; When cross-compiling, by default qemu_docdir is &#39;c:\Program Files\=
QEMU\&#39;<br>
&gt; which is not recognized as being an absolute path, and meson will end =
up<br>
&gt; adding the prefix again.<br>
&gt; <br>
&gt; Add an option to pass docdir location to meson, pre-prefixed like we d=
o<br>
&gt; with other directories and use that instead of config_host[&#39;qemu_d=
ocdir&#39;].<br>
&gt; <br>
&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br=
>
&gt; ---<br>
&gt;=C2=A0 configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 +<br>
&gt;=C2=A0 docs/meson.build=C2=A0 | 4 ++--<br>
&gt;=C2=A0 meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0| 3 ++-<br>
&gt;=C2=A0 meson_options.txt | 1 +<br>
&gt;=C2=A0 4 files changed, 6 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/configure b/configure<br>
&gt; index e19e2de2f0..e644841299 100755<br>
&gt; --- a/configure<br>
&gt; +++ b/configure<br>
&gt; @@ -8223,6 +8223,7 @@ NINJA=3D$PWD/ninjatool $meson setup \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --sysconfdir &quot;${pre_prefix}$sys=
confdir&quot; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --localstatedir &quot;${pre_prefix}$=
local_statedir&quot; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Dconfsuffix=3D&quot;$confsuffix&quo=
t; \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 -Ddocdir=3D&quot;${pre_prefix}$qemu_docdi=
r&quot; \<br>
<br>
This is passing an absolute path.....<br>
<br>
<br>
&gt; diff --git a/meson_options.txt b/meson_options.txt<br>
&gt; index 7bb2c0fca9..fb9312fddd 100644<br>
&gt; --- a/meson_options.txt<br>
&gt; +++ b/meson_options.txt<br>
&gt; @@ -1,4 +1,5 @@<br>
&gt;=C2=A0 option(&#39;confsuffix&#39;, type : &#39;string&#39;, value: &#3=
9;qemu&#39;)<br>
&gt; +option(&#39;docdir&#39;, type : &#39;string&#39;, value : &#39;doc/qe=
mu&#39;)<br>
<br>
...but this default is a relative dir, presumably relative to<br>
datadir.=C2=A0 The code expects an absolute dir.<br></blockquote><div><br><=
/div><div><br></div><div>Meson accepts both absolute and relative path for =
installation location. If it&#39;s relative, it will be under the $prefix d=
irectory.</div><div> <br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
<br>
<br>
Regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000067147105adc3c004--

