Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4D1C4BA24
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:27:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 573C024653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESXTkdoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573C024653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j759f-0000D4-IO
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 17:27:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j758x-00088L-DI
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:27:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j758w-0002ay-1y
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:27:03 -0500
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:47013)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j758v-0002VV-RG; Wed, 26 Feb 2020 17:27:01 -0500
Received: by mail-il1-x144.google.com with SMTP id t17so556738ilm.13;
 Wed, 26 Feb 2020 14:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vioaXXMIUSQa4apqLoC4uH//xg93hvNVMXMPYEx0riY=;
 b=ESXTkdoXyRjs7Nck4DOfTEoRKwP6T8XuaGkeupNcmzwkDNvItJPV4TZHtdfL97b+pX
 0ZDQDX1i6RtPxTD4foYrC+VKezw1b+q/pVoFpncEJ+sydCUxh+MT94aToOICJcBZtY2M
 Y8fTZjdxgpRbMCbt75e9TxxrhsfOBculVE38VfAxvrJqA3La3ZGx0Aa4OQgGeD9/bvHm
 2NyIyzNXcJ1keUEAxVWNCVbIPHS60ZKqmonGzf9nCVfM4Aq2Z2L0/tJ+iAlmhEWmsqBO
 vQeLmyjzWXSULJ7cu4vG38naA0Ev5qChDWqXnBSgC0JuqdX6w/6SpOvjRubuTV18v1+Z
 +CrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vioaXXMIUSQa4apqLoC4uH//xg93hvNVMXMPYEx0riY=;
 b=dryqs6zuot4KFmEUFnEd4Jf/XX8IQLhTzTOdC7KwrFsfQECEaJ6JCOvo4y7qcTGroy
 DCn280spqYdHWHlAXroTklVRGfc76OyIE9pmoFLCE62C+vtGOrC0wgGZhENY3RWg7oi5
 4VuZ+tq73tQRDsJuSxSUkLNbFMWkc9wVFRDgxzwnQ9TuG6W1S0dCGJmxQEA9sXRGaZjg
 rPJ4EKm+Tom1ogSaBh6gdO994Gdra5LsDq/PiZKOHlmZ40P0loAhb4S1AJfSvXUect9N
 QdTEqE/m1MnNVzPqggmfoqdlYfa2HEM1ImvlaHS3bQkoTkge1YrCjMd6nQ6ESRVZvPcb
 yNNw==
X-Gm-Message-State: APjAAAX3kyM49X24zhwjRO8ImkJB61loRIbl4IDNphBiVrJEyO1taxAR
 E5ZoqQ0qiWoSoWMPFp5Pk/WIjIw6ZoHarlCVnE0=
X-Google-Smtp-Source: APXvYqwnY8+ikgcQ+hZBOkhmVmuJ9bmfp88mEbcCP8e5xCP0mP8tPPQg4Qkk58mp7+oeDexXsVrClezBpmNUVoVdYPU=
X-Received: by 2002:a92:81d9:: with SMTP id q86mr1107698ilk.67.1582756021020; 
 Wed, 26 Feb 2020 14:27:01 -0800 (PST)
MIME-Version: 1.0
References: <20200226181020.19592-1-alex.bennee@linaro.org>
 <20200226181020.19592-3-alex.bennee@linaro.org>
In-Reply-To: <20200226181020.19592-3-alex.bennee@linaro.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Wed, 26 Feb 2020 23:26:50 +0100
Message-ID: <CAPan3WrD5kpnyNM_TqKOZP4GG4E0npaEqbJe6KidqJW2toAe6A@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] accel/tcg: remove link between guest ram and TCG
 cache size
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000662ee3059f821a83"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::144
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000662ee3059f821a83
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Wed, Feb 26, 2020 at 7:10 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

> Basing the TB cache size on the ram_size was always a little heuristic
> and was broken by a1b18df9a4 which caused ram_size not to be fully
> realised at the time we initialise the TCG translation cache.
>

Now I'm beginning to understand the issue better. So without this patch,
the TCG translation
cache effectively was disabled, causing the slowdown, correct?


>
> The current DEFAULT_CODE_GEN_BUFFER_SIZE may still be a little small
> but follow-up patches will address that.
>
> Fixes: a1b18df9a4
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Niek Linnenbank <nieklinnenbank@gmail.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
>
---
>  accel/tcg/translate-all.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 238b0e575bf..5b66af783b5 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -938,15 +938,7 @@ static inline size_t size_code_gen_buffer(size_t
> tb_size)
>  {
>      /* Size the buffer.  */
>      if (tb_size =3D=3D 0) {
> -#ifdef USE_STATIC_CODE_GEN_BUFFER
>          tb_size =3D DEFAULT_CODE_GEN_BUFFER_SIZE;
>
-#else
> -        /* ??? Needs adjustments.  */
> -        /* ??? If we relax the requirement that CONFIG_USER_ONLY use the
> -           static buffer, we could size this on RESERVED_VA, on the text
> -           segment size of the executable, or continue to use the
> default.  */
> -        tb_size =3D (unsigned long)(ram_size / 4);
>

As you wrote in the commit message, I think we are indeed reducing the
cache size here to 32MiB
versus a larger size without this patch. In the next patch #4 in this
series you are increasing it for 64-bit hosts,
but what about the 32-bit hosts? Or will that be addressed in a later
series?

For now, this fix works and resolves the slowdown, so:

Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>

Regards,
Niek


> -#endif
>      }
>      if (tb_size < MIN_CODE_GEN_BUFFER_SIZE) {
>          tb_size =3D MIN_CODE_GEN_BUFFER_SIZE;
> --
> 2.20.1
>
>

--=20
Niek Linnenbank

--000000000000662ee3059f821a83
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Alex,<br></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 26, 2020 at 7:10 PM Alex Benn=
=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.or=
g</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>Basing the TB cache size on the ram_size was always a little heuristic<br>
and was broken by a1b18df9a4 which caused ram_size not to be fully<br>
realised at the time we initialise the TCG translation cache.<br></blockquo=
te><div><br></div><div>Now I&#39;m beginning to understand the issue better=
. So without this patch, the TCG translation</div><div>cache effectively wa=
s disabled, causing the slowdown, correct?<br></div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<br>
The current DEFAULT_CODE_GEN_BUFFER_SIZE may still be a little small<br>
but follow-up patches will address that.<br>
<br>
Fixes: a1b18df9a4<br>
Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
Cc: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com" target=
=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
Cc: Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com" target=3D"_bla=
nk">imammedo@redhat.com</a>&gt; <br></blockquote><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
---<br>
=C2=A0accel/tcg/translate-all.c | 8 --------<br>
=C2=A01 file changed, 8 deletions(-)<br>
<br>
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c<br>
index 238b0e575bf..5b66af783b5 100644<br>
--- a/accel/tcg/translate-all.c<br>
+++ b/accel/tcg/translate-all.c<br>
@@ -938,15 +938,7 @@ static inline size_t size_code_gen_buffer(size_t tb_si=
ze)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0/* Size the buffer.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0if (tb_size =3D=3D 0) {<br>
-#ifdef USE_STATIC_CODE_GEN_BUFFER<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tb_size =3D DEFAULT_CODE_GEN_BUFFER_SIZE;=
 <br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
-#else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ??? Needs adjustments.=C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ??? If we relax the requirement that CONFIG=
_USER_ONLY use the<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0static buffer, we could size this=
 on RESERVED_VA, on the text<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0segment size of the executable, o=
r continue to use the default.=C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tb_size =3D (unsigned long)(ram_size / 4);<br>=
</blockquote><div><br></div><div>As you wrote in the commit message, I thin=
k we are indeed reducing the cache size here to 32MiB</div><div>versus a la=
rger size without this patch. In the next patch #4 in this series you are i=
ncreasing it for 64-bit hosts,</div><div>but what about the 32-bit hosts? O=
r will that be addressed in a later series?<br></div><div><br></div><div>Fo=
r now, this fix works and resolves the slowdown, so:</div><div><br></div><d=
iv>Tested-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.co=
m">nieklinnenbank@gmail.com</a>&gt;<br></div><div><br></div><div>Regards,</=
div><div>Niek<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
-#endif<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (tb_size &lt; MIN_CODE_GEN_BUFFER_SIZE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tb_size =3D MIN_CODE_GEN_BUFFER_SIZE;<br>
-- <br>
2.20.1<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000662ee3059f821a83--

