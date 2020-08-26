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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44473C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03CAF2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SV9wNgoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03CAF2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kArCT-0001gp-9L
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 04:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kArBH-0000I0-3C
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:53:19 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:34812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kArBF-0002Ef-1T
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:53:18 -0400
Received: by mail-ej1-x642.google.com with SMTP id d26so1787627ejr.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 01:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OwUZDxHe3g8R2TdKRDa60rIoNuuupYFB8bC9SaSMaio=;
 b=SV9wNgoe0z0m2zs2nqeEAPDybbPGJwQ3RJAwMzDURovY+jcdLUr3eMOkjx/NQIOUfb
 eA/nMr3rKhzHS1DK1Ylkx6H+TwQ10V4yd50+WI+owNtUdoP9ePu+77T5HCJ3a1pE9yvd
 bGLIcp7LIrVQWd0E5ZKzIzteTVO5toWbdsj5noLc7QoI6r1Yu1hNhEDc1c50R8BjwdmE
 m5Eh/g/REm9kgQvf06E3/XnItt4j3iNKmHh/N0NOqjMCFBpiFPQALKvc8RYCKznSJbRq
 a6nkwEu0xcrs8wPZe3Zn78rwrtatfKmQRRvC23t9GF+KYuCfB6nccKPT44Chd9OXrbbq
 UhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OwUZDxHe3g8R2TdKRDa60rIoNuuupYFB8bC9SaSMaio=;
 b=QSsieOV05HXaOYFxGynnd0M71AcOUt0IFzCaXq8H+gYaW7tb3bVVpbbzRHQeTEW7hK
 x56FwKP3lTlCIFS1Fw2oQMEzP5HH8ZeTGiNXZLDlQEOJPXmi1aQXSBoW5XdGqkWKEL5h
 xMFW4pDjCevrZQgmSop0G0akkKP/7/maF7+mquXT5H9U6Q0JRk3+aQ1jUMvYHgRSz1dZ
 qrttYq54hIJAsH+shN+xPP5rQMU63B79mOUc9nyuvJxn4/yjCL67XWM4beZ5VgmV2dbO
 WbI5CxwfDT/7h79Zwy8AxsULsGBSzJsGRUc+vbLBBy1exkPUNQxZ4v5w0+Z+2HJf9Ekg
 04yA==
X-Gm-Message-State: AOAM531waZrRI8vSLZLJ8qkrNDjhrgnLBOZrzvZMYAAxEiyDdju1TPX2
 h3Bmfxhte4Zn1jBEgGIg1tmg5Jol55SStrbzlUk=
X-Google-Smtp-Source: ABdhPJy0Ip5PSlnELEr45kxaivJR4v2X9Ox2DATex/l11B2KQDwQiAwCMs1x0Z4GWg+1VUWhvTKSrvx02dyd8OQVo5g=
X-Received: by 2002:a17:906:fcad:: with SMTP id
 qw13mr15182024ejb.389.1598431995472; 
 Wed, 26 Aug 2020 01:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200825175827.355940-1-marcandre.lureau@redhat.com>
 <20200825175827.355940-3-marcandre.lureau@redhat.com>
 <20200826082942.GD168515@redhat.com>
In-Reply-To: <20200826082942.GD168515@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 26 Aug 2020 12:53:03 +0400
Message-ID: <CAJ+F1CKxUK=t7vy-QXazi_syCQGdpxhJdb3KKH9PC6rGmcVVxQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] meson: use meson datadir instead of qemu_datadir
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000049aeda05adc3f341"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x642.google.com
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

--00000000000049aeda05adc3f341
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Aug 26, 2020 at 12:30 PM Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om>
wrote:

> On Tue, Aug 25, 2020 at 09:58:24PM +0400, marcandre.lureau@redhat.com
> wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > When cross-compiling, by default qemu_datadir is 'c:\Program
> > Files\QEMU', which is not recognized as being an absolute path, and
> > meson will end up adding the prefix again.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  contrib/vhost-user-gpu/meson.build | 2 +-
> >  meson.build                        | 3 ++-
> >  pc-bios/descriptors/meson.build    | 2 +-
> >  pc-bios/keymaps/meson.build        | 6 +++---
> >  pc-bios/meson.build                | 2 +-
> >  tools/virtiofsd/meson.build        | 2 +-
> >  trace/meson.build                  | 2 +-
> >  7 files changed, 10 insertions(+), 9 deletions(-)
> >
>
> > diff --git a/meson.build b/meson.build
> > index f0fe5f8799..20f20a7bfc 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -17,6 +17,7 @@ config_all_disas =3D
> keyval.load(meson.current_build_dir() / 'config-all-disas.mak
> >  enable_modules =3D 'CONFIG_MODULES' in config_host
> >  enable_static =3D 'CONFIG_STATIC' in config_host
> >  build_docs =3D 'BUILD_DOCS' in config_host
> > +qemu_datadir =3D get_option('datadir') + get_option('confsuffix')
>
> This needs to be
>
>    get_option('datadir') / get_option('confsuffix')
>
> to add the dir separator if we're using the default meson value
> for "confsuffix" which lacks a leading "/".
>

right, fixed

--=20
Marc-Andr=C3=A9 Lureau

--00000000000049aeda05adc3f341
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 26, 2020 at 12:30 PM Da=
niel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@r=
edhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Tue, Aug 25, 2020 at 09:58:24PM +0400, <a href=3D"mailto:marc=
andre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a> =
wrote:<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; <br>
&gt; When cross-compiling, by default qemu_datadir is &#39;c:\Program<br>
&gt; Files\QEMU&#39;, which is not recognized as being an absolute path, an=
d<br>
&gt; meson will end up adding the prefix again.<br>
&gt; <br>
&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br=
>
&gt; ---<br>
&gt;=C2=A0 contrib/vhost-user-gpu/meson.build | 2 +-<br>
&gt;=C2=A0 meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 3 ++-<br>
&gt;=C2=A0 pc-bios/descriptors/meson.build=C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 pc-bios/keymaps/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 6 +++--=
-<br>
&gt;=C2=A0 pc-bios/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 tools/virtiofsd/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br=
>
&gt;=C2=A0 trace/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 7 files changed, 10 insertions(+), 9 deletions(-)<br>
&gt; <br>
<br>
&gt; diff --git a/meson.build b/meson.build<br>
&gt; index f0fe5f8799..20f20a7bfc 100644<br>
&gt; --- a/meson.build<br>
&gt; +++ b/meson.build<br>
&gt; @@ -17,6 +17,7 @@ config_all_disas =3D keyval.load(meson.current_build=
_dir() / &#39;config-all-disas.mak<br>
&gt;=C2=A0 enable_modules =3D &#39;CONFIG_MODULES&#39; in config_host<br>
&gt;=C2=A0 enable_static =3D &#39;CONFIG_STATIC&#39; in config_host<br>
&gt;=C2=A0 build_docs =3D &#39;BUILD_DOCS&#39; in config_host<br>
&gt; +qemu_datadir =3D get_option(&#39;datadir&#39;) + get_option(&#39;conf=
suffix&#39;)<br>
<br>
This needs to be<br>
<br>
=C2=A0 =C2=A0get_option(&#39;datadir&#39;) / get_option(&#39;confsuffix&#39=
;)<br>
<br>
to add the dir separator if we&#39;re using the default meson value<br>
for &quot;confsuffix&quot; which lacks a leading &quot;/&quot;.<br></blockq=
uote><div><br></div><div>right, fixed<br></div><br></div>-- <br><div dir=3D=
"ltr" class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000049aeda05adc3f341--

