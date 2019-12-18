Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484AEC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 142D82072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRuqLM2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142D82072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihUIu-0008K0-4F
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 03:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ihUI6-0007g2-K2
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:02:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ihUI5-0001bL-Eh
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:02:42 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46211)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ihUI5-0001aB-8j; Wed, 18 Dec 2019 03:02:41 -0500
Received: by mail-ot1-x341.google.com with SMTP id c22so1355301otj.13;
 Wed, 18 Dec 2019 00:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=4SWon0nOlYLo6YQwWJ0SOalCYeN+GsCSWp2lEPHsX9o=;
 b=hRuqLM2syxYDyLzTxY5oRTpT+eInLIIqDmqzSS8NtyWhrXl3sdP36CHvb1Vdt80Tli
 sjHGyxj+BbqV6gNDyzw2+ddOgBxk8Ws6TeL1sEYK7WrRBw/vZvDJg0tn0lemq2wjkmSN
 0lMD/B6gq8XFySiyXXc8Ng0mwd3N2ZbKu6fuLLWOyv6l14GgiMI04x5YaHdhsb7cZ9L3
 ajVxOGlkk8b8f63oBbgO0wNx3HyuUPgofLYM3IUN2rgIdGkbhjwUpdrjb2b7Bb/no9n9
 tEIjxMn+A97Pf5Xrg1u17AQw8TMYNa1x5yCfbB4VzDefW0CzUgXgNY3ey5VpndH0oyeB
 13/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=4SWon0nOlYLo6YQwWJ0SOalCYeN+GsCSWp2lEPHsX9o=;
 b=BxU+dTrrKBsJqQMiYLFKDmOl19OKGJGWf18U3JQ463XLol4FHktEffbqi7E+1idCid
 /EXxIoYyT8yPDATKevqMlXNYPWWzJkaODTL3mDKjfxxysCItRmoAsJteF4OKmmq73X63
 yCdjbYxDg1agY0iF9okCDjEB8hWxrC4qqHMPfteiG0J3SzAWwWMsIiv2ssaaQ0r4S3ij
 I8yMFron/rRNgpUURsDZlsl6TPINq2SCwj+w8NiYz1cXWkqyOgBSj1uMU/nn67QVjUCE
 +9iRXKnjNtBWcZvcRhOj0SYQ2CYhcWAd62pn1dO7bBtczT8zr6E4+3bDJMxSYwRhpyhJ
 031g==
X-Gm-Message-State: APjAAAXirPvVwqyYfA817ys6I7b7yTd8y16xMCZRtBaKe9yDP/Dzozl1
 /pg4e84n0AM46GvBzSztqFnmEx1tiM9KViD9/o0=
X-Google-Smtp-Source: APXvYqz6r8Qd4ZQ7WZ07hPn251nREIQH/Xtg+i8FLXR9biiEz8bh0rZvQMbF0BkxaQxno7OdSj35W7yprBv38QCGx4I=
X-Received: by 2002:a9d:7c8f:: with SMTP id q15mr1285205otn.341.1576656160485; 
 Wed, 18 Dec 2019 00:02:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Wed, 18 Dec 2019 00:02:39 -0800 (PST)
In-Reply-To: <20191217173425.5082-2-philmd@redhat.com>
References: <20191217173425.5082-1-philmd@redhat.com>
 <20191217173425.5082-2-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 18 Dec 2019 09:02:39 +0100
Message-ID: <CAL1e-=gP7TqZ1VDR1dTGMqHYwAxEJYPHdEZ0XQr4L=g=uLFMcA@mail.gmail.com>
Subject: Re: [PATCH 1/6] audio/audio: Add missing fall through comment
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000060f6d30599f5defd"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000060f6d30599f5defd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, December 17, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om>
wrote:

> GCC9 is confused by this comment when building with
> CFLAG -Wimplicit-fallthrough=3D2:
>
>
Gcc is not confused whatsoever.



>   audio/audio.c: In function =E2=80=98audio_pcm_init_info=E2=80=99:
>   audio/audio.c:306:14: error: this statement may fall through
> [-Werror=3Dimplicit-fallthrough=3D]
>     306 |         sign =3D 1;
>         |         ~~~~~^~~
>   audio/audio.c:307:5: note: here
>     307 |     case AUDIO_FORMAT_U8:
>         |     ^~~~
>   cc1: all warnings being treated as errors
>
> Add the missing fall through comment, similarly to e46349414.
>
> Fixes: 2b9cce8c8c
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: "K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n" <dirty.ice.hu@gmail.com>
> ---
>  audio/audio.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/audio/audio.c b/audio/audio.c
> index 56fae55047..57daf3f620 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -304,6 +304,7 @@ void audio_pcm_init_info (struct audio_pcm_info *info=
,
> struct audsettings *as)
>      switch (as->fmt) {
>      case AUDIO_FORMAT_S8:
>          sign =3D 1;
> +        /* fall through */
>      case AUDIO_FORMAT_U8:
>          mul =3D 1;
>          break;
> --
> 2.21.0
>
>
>

--00000000000060f6d30599f5defd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, December 17, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a h=
ref=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">GCC9 is confused by this comment when building wit=
h<br>
CFLAG -Wimplicit-fallthrough=3D2:<br>
<br></blockquote><div><br></div><div>Gcc is not confused whatsoever.</div><=
div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0 audio/audio.c: In function =E2=80=98audio_pcm_init_info=E2=80=99:<br=
>
=C2=A0 audio/audio.c:306:14: error: this statement may fall through [-Werro=
r=3Dimplicit-fallthrough=3D<wbr>]<br>
=C2=A0 =C2=A0 306 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sign =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~~~^~~<br>
=C2=A0 audio/audio.c:307:5: note: here<br>
=C2=A0 =C2=A0 307 |=C2=A0 =C2=A0 =C2=A0case AUDIO_FORMAT_U8:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0^~~~<br>
=C2=A0 cc1: all warnings being treated as errors<br>
<br>
Add the missing fall through comment, similarly to e46349414.<br>
<br>
Fixes: 2b9cce8c8c<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
---<br>
Cc: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com">kraxel@redhat.co=
m</a>&gt;<br>
Cc: &quot;K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n&quot; &lt;<a href=3D"mailto:di=
rty.ice.hu@gmail.com">dirty.ice.hu@gmail.com</a>&gt;<br>
---<br>
=C2=A0audio/audio.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/audio/audio.c b/audio/audio.c<br>
index 56fae55047..57daf3f620 100644<br>
--- a/audio/audio.c<br>
+++ b/audio/audio.c<br>
@@ -304,6 +304,7 @@ void audio_pcm_init_info (struct audio_pcm_info *info, =
struct audsettings *as)<br>
=C2=A0 =C2=A0 =C2=A0switch (as-&gt;fmt) {<br>
=C2=A0 =C2=A0 =C2=A0case AUDIO_FORMAT_S8:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sign =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fall through */<br>
=C2=A0 =C2=A0 =C2=A0case AUDIO_FORMAT_U8:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mul =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--00000000000060f6d30599f5defd--

