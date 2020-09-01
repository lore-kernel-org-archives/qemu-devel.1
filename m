Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B2BC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B8F6206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYO6WD7j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8F6206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD32I-0007TE-El
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kD2ey-0001j2-AR
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:33:00 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a]:34202)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kD2ew-000139-G3
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:32:59 -0400
Received: by mail-ej1-x62a.google.com with SMTP id d26so701386ejr.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 02:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eIALFikHdWrLWCw6KWhv/U0X2Clw9aX1FLRYgDVvF3E=;
 b=nYO6WD7jO2IbWXsVqvSMD4Uu5fb7ZgYJo7usNYtDu0ZDkUoUjbAobp5lapDSupZp5e
 vX75WaK5+8hQ3Xcep3p1QPgD9MD/QDcRBv2gvsg9ZiLOaeIDxK2AmbQu9tW9WFepsqdO
 478Rc3xL1Y5plDeIBAg1gtDT548HgxI7wG1W26Zv2ceReMwMVb9FTgSSSEoca5Bc26G2
 /t6xw17fmr3aaUxSTZdKBLjchIzbbIwVjmq6GdjAix4NZG5v6bfr+tNF20rbg4DbrIsp
 HJwSW75sGbwXz6b2YQgmNRH9EfNruAgZ7qy8NaJMzUnuMABC3owaRvxe5wbFi5GANZoc
 OiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eIALFikHdWrLWCw6KWhv/U0X2Clw9aX1FLRYgDVvF3E=;
 b=Hn9bghDHEuAnx5La87mvLrTtU0P6TIsbd40z0a7yA52IvyeLH/ZQz5Q+ZZFKO5Dra1
 2MpBN4koKem6BiwDGClZlB1ooAgHiwmGDpmky2BPTmd8aKWLF/Nxwn5Cj+HvfZX1YZ8O
 jIAxXMsBN/T4toek/lIslhbdL+NLea0MA5hdk8MqEdlITpMlmR9wyx5ZlhAuSgTjC463
 551tKj5kFf6crdBXyHw8tzRFC1RwGbGJpmp8YsaJrRtT7IR4sCiwpC/yJNSCc04AsIzN
 tiBY9gTC6LkzpSiztZ/YxJRPLJQbagcOG1Mln1igIqKqeo4y1y2yKoE0oB/UgewDQXjs
 KG7A==
X-Gm-Message-State: AOAM531PDClVfkQkYlKl7TN6VkFPveRXiDrhjkww1RebbVDGe7Pel1AT
 o2gyukyLeDfZRmVB37pm8FE/EzfOkRrMgK2KYbM=
X-Google-Smtp-Source: ABdhPJwxomPkeGMrz0v6ORoO2uRRksSkwZEdDX3vOHrVNfgHky8D5c0KCmt0MYvAgE2y6u36a9eYEsa3BZTugFHu6O8=
X-Received: by 2002:a17:906:c10c:: with SMTP id
 do12mr681743ejc.92.1598952776583; 
 Tue, 01 Sep 2020 02:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200901091132.29601-1-pbonzini@redhat.com>
 <20200901091132.29601-25-pbonzini@redhat.com>
In-Reply-To: <20200901091132.29601-25-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 1 Sep 2020 13:32:44 +0400
Message-ID: <CAJ+F1CL8ZV6g0ESiGv9B_z_cVxfCK1LjmzLH8EAdnkgaVJB8Kg@mail.gmail.com>
Subject: Re: [PULL 24/24] meson: add description to options
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000042d06405ae3d349e"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x62a.google.com
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000042d06405ae3d349e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Sep 1, 2020 at 1:25 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> This will be useful in the future to generate configure
> command line parsing from meson_options.txt.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson_options.txt | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
>
> diff --git a/meson_options.txt b/meson_options.txt
> index c3120fa359..3e772f55b3 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -2,12 +2,23 @@ option('qemu_suffix', type : 'string', value: 'qemu',
>         description: 'Suffix for QEMU data/modules/config directories (ca=
n
> be empty)')
>  option('docdir', type : 'string', value : 'doc',
>         description: 'Base directory for documentation installation (can
> be empty)')
> -option('gettext', type : 'boolean', value : true)
> -option('sdl', type : 'feature', value : 'auto')
> -option('sdl_image', type : 'feature', value : 'auto')
> -option('u2f', type : 'feature', value : 'auto')
> -option('vnc', type : 'feature', value : 'enabled')
> -option('vnc_jpeg', type : 'feature', value : 'auto')
> -option('vnc_png', type : 'feature', value : 'auto')
> -option('vnc_sasl', type : 'feature', value : 'auto')
> -option('xkbcommon', type : 'feature', value : 'auto')
> +
> +option('gettext', type : 'boolean', value : true,
> +       description: 'Localizationo of the GTK+ user interface')
>

Hardly a blocker: "Localization"

Also, we may want to remove the extra space before ':' for consistency.

+
> +option('sdl', type : 'feature', value : 'auto',
> +       description: 'SDL user interface')
> +option('sdl_image', type : 'feature', value : 'auto',
> +       description: 'SDL Image support for icons')
> +option('u2f', type : 'feature', value : 'auto',
> +       description: 'U2F emulation support')
> +option('vnc', type : 'feature', value : 'enabled',
> +       description: 'VNC server')
> +option('vnc_jpeg', type : 'feature', value : 'auto',
> +       description: 'JPEG lossy compression for VNC server')
> +option('vnc_png', type : 'feature', value : 'auto',
> +       description: 'PNG compression for VNC server')
> +option('vnc_sasl', type : 'feature', value : 'auto',
> +       description: 'SASL authentication for VNC server')
> +option('xkbcommon', type : 'feature', value : 'auto',
> +       description: 'xkbcommon support')
> --
> 2.26.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000042d06405ae3d349e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 1, 2020 at 1:25 PM Paol=
o Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Thi=
s will be useful in the future to generate configure<br>
command line parsing from meson_options.txt.<br>
<br>
Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" tar=
get=3D"_blank">pbonzini@redhat.com</a>&gt;<br>
---<br>
=C2=A0meson_options.txt | 29 ++++++++++++++++++++---------<br>
=C2=A01 file changed, 20 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/meson_options.txt b/meson_options.txt<br>
index c3120fa359..3e772f55b3 100644<br>
--- a/meson_options.txt<br>
+++ b/meson_options.txt<br>
@@ -2,12 +2,23 @@ option(&#39;qemu_suffix&#39;, type : &#39;string&#39;, va=
lue: &#39;qemu&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 description: &#39;Suffix for QEMU data/modules/=
config directories (can be empty)&#39;)<br>
=C2=A0option(&#39;docdir&#39;, type : &#39;string&#39;, value : &#39;doc&#3=
9;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 description: &#39;Base directory for documentat=
ion installation (can be empty)&#39;)<br>
-option(&#39;gettext&#39;, type : &#39;boolean&#39;, value : true)<br>
-option(&#39;sdl&#39;, type : &#39;feature&#39;, value : &#39;auto&#39;)<br=
>
-option(&#39;sdl_image&#39;, type : &#39;feature&#39;, value : &#39;auto&#3=
9;)<br>
-option(&#39;u2f&#39;, type : &#39;feature&#39;, value : &#39;auto&#39;)<br=
>
-option(&#39;vnc&#39;, type : &#39;feature&#39;, value : &#39;enabled&#39;)=
<br>
-option(&#39;vnc_jpeg&#39;, type : &#39;feature&#39;, value : &#39;auto&#39=
;)<br>
-option(&#39;vnc_png&#39;, type : &#39;feature&#39;, value : &#39;auto&#39;=
)<br>
-option(&#39;vnc_sasl&#39;, type : &#39;feature&#39;, value : &#39;auto&#39=
;)<br>
-option(&#39;xkbcommon&#39;, type : &#39;feature&#39;, value : &#39;auto&#3=
9;)<br>
+<br>
+option(&#39;gettext&#39;, type : &#39;boolean&#39;, value : true,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0description: &#39;Localizationo of the GTK+ use=
r interface&#39;)<br></blockquote><div><br></div><div>Hardly a blocker: &qu=
ot;Localization&quot;<br></div><div><br></div><div>Also, we may want to rem=
ove the extra space before &#39;:&#39; for consistency.<br></div><div><br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+option(&#39;sdl&#39;, type : &#39;feature&#39;, value : &#39;auto&#39;,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0description: &#39;SDL user interface&#39;)<br>
+option(&#39;sdl_image&#39;, type : &#39;feature&#39;, value : &#39;auto&#3=
9;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0description: &#39;SDL Image support for icons&#=
39;)<br>
+option(&#39;u2f&#39;, type : &#39;feature&#39;, value : &#39;auto&#39;,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0description: &#39;U2F emulation support&#39;)<b=
r>
+option(&#39;vnc&#39;, type : &#39;feature&#39;, value : &#39;enabled&#39;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0description: &#39;VNC server&#39;)<br>
+option(&#39;vnc_jpeg&#39;, type : &#39;feature&#39;, value : &#39;auto&#39=
;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0description: &#39;JPEG lossy compression for VN=
C server&#39;)<br>
+option(&#39;vnc_png&#39;, type : &#39;feature&#39;, value : &#39;auto&#39;=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0description: &#39;PNG compression for VNC serve=
r&#39;)<br>
+option(&#39;vnc_sasl&#39;, type : &#39;feature&#39;, value : &#39;auto&#39=
;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0description: &#39;SASL authentication for VNC s=
erver&#39;)<br>
+option(&#39;xkbcommon&#39;, type : &#39;feature&#39;, value : &#39;auto&#3=
9;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0description: &#39;xkbcommon support&#39;)<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000042d06405ae3d349e--

