Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6429DC3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 20:18:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ECC524677
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 20:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti0LHKvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ECC524677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7m5S-0000Vz-ED
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 15:18:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j7m4Q-0007ki-Q6
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 15:17:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j7m4P-0008RD-Gx
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 15:17:14 -0500
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:36069)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j7m4P-0008PL-Be; Fri, 28 Feb 2020 15:17:13 -0500
Received: by mail-il1-x143.google.com with SMTP id b15so3868717iln.3;
 Fri, 28 Feb 2020 12:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=y7oKwH0w5cdz9ggYBkA4FnWloJ8QjaZibTiDdQfWYLs=;
 b=Ti0LHKvCdGaLzsCNqiY6LlPjxDNz5KX6HeKMTVtU6uaNacb4nScof4l7JoTB1naZHh
 OgRq5adi+6YzAKB9It03gTH6Z+1J+X3IkrDvPGQQKSqdG2QVaW0Dfj8dU1sS4nHu6p8n
 69K+4la+IZbcNFLex6apXnxY4UOeuMLWi6yXst71qY5t8MWUZdyvY0mmGVHiW1oyDEoy
 Gt3jEXfH9hQQhwGXh7wgzofN2CFFbVEWATXyBEvdNw76SrUF7Q0+sE/SWpkKerkkVypZ
 r3xxVwAw3jPS72zarV4uekWV4eFZvbZvbRJN6Vjjah5MdbnkUnNLnS2x1Xf/FUwNzSTB
 3meQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y7oKwH0w5cdz9ggYBkA4FnWloJ8QjaZibTiDdQfWYLs=;
 b=VcNULZHAK2EFJv48tABxaar+Bgwi/dno3oe8pzRUHVoRIvOGn9C8crdaBdZajs9jKU
 m5bC55GxPAVNpue6hnRIbU0D2nOzcR5c/AEgfPvx+gydWnxxED1TR8OJa7IpLll9pLrQ
 CE6bb9F2jYs+dnE1OVNYdcyAr6wSCVPod0KDqxX8cMuWZoKhVKpfT4XGg5ALWP7cGhPO
 LZQP+NEnlv+Ar2ba6o3g+fkBVySyk9KMAKNl/Wi2sKKzw+ZZp2l9Zatx58JdoblP0UEQ
 ykady1QdePBMNyon6pQz3X9qHYHdvPrv2YuzExYvYpkycsb+kaJh2NCQSvQWeB+IsjR4
 TePw==
X-Gm-Message-State: APjAAAUeTERvJIlAVAwRtlFK2Iw49HKCcwKmw5mRPo2fC2sFNsHaBiVh
 ucM1ICBPKrxpzpfR7zWRWFHDgcQA/nc9zrZnw/w=
X-Google-Smtp-Source: APXvYqxleJ8dP7SA/AsFRqSxdCP/TWf0oYz15g6Q3kVymMHxFmvlDW25DdlFqNbKVFn+0aAwbEpnlVjsVwXDXsxi/EY=
X-Received: by 2002:a92:81d9:: with SMTP id q86mr5663179ilk.67.1582921031645; 
 Fri, 28 Feb 2020 12:17:11 -0800 (PST)
MIME-Version: 1.0
References: <20200228192415.19867-1-alex.bennee@linaro.org>
 <20200228192415.19867-3-alex.bennee@linaro.org>
In-Reply-To: <20200228192415.19867-3-alex.bennee@linaro.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Fri, 28 Feb 2020 21:17:00 +0100
Message-ID: <CAPan3WrZZ6FtkY+ZNkMwVuTTaXSk9_99dW4=0LwkDqkn0rWUZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] accel/tcg: remove link between guest ram and TCG
 cache size
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000cc8008059fa88578"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::143
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cc8008059fa88578
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2020 at 8:24 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

> Basing the TB cache size on the ram_size was always a little heuristic
> and was broken by a1b18df9a4 which caused ram_size not to be fully
> realised at the time we initialise the TCG translation cache.
>
> The current DEFAULT_CODE_GEN_BUFFER_SIZE may still be a little small
> but follow-up patches will address that.
>
> Fixes: a1b18df9a4
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>

Cc: Niek Linnenbank <nieklinnenbank@gmail.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> ---
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
> -#else
> -        /* ??? Needs adjustments.  */
> -        /* ??? If we relax the requirement that CONFIG_USER_ONLY use the
> -           static buffer, we could size this on RESERVED_VA, on the text
> -           segment size of the executable, or continue to use the
> default.  */
> -        tb_size =3D (unsigned long)(ram_size / 4);
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

--000000000000cc8008059fa88578
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 28, 2020 at 8:24 PM Alex =
Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linar=
o.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">Basing the TB cache size on the ram_size was always a little heuristic=
<br>
and was broken by a1b18df9a4 which caused ram_size not to be fully<br>
realised at the time we initialise the TCG translation cache.<br>
<br>
The current DEFAULT_CODE_GEN_BUFFER_SIZE may still be a little small<br>
but follow-up patches will address that.<br>
<br>
Fixes: a1b18df9a4<br>
Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.=
com" target=3D"_blank">philmd@redhat.com</a>&gt;<br></blockquote><div>Revie=
wed-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com">nie=
klinnenbank@gmail.com</a>&gt;</div><div> <br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
Cc: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com" target=
=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
Cc: Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com" target=3D"_bla=
nk">imammedo@redhat.com</a>&gt;<br>
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
<br>
-#else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ??? Needs adjustments.=C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ??? If we relax the requirement that CONFIG=
_USER_ONLY use the<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0static buffer, we could size this=
 on RESERVED_VA, on the text<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0segment size of the executable, o=
r continue to use the default.=C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tb_size =3D (unsigned long)(ram_size / 4);<br>
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

--000000000000cc8008059fa88578--

