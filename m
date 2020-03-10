Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAA6C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:01:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D929215A4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCG+CtDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D929215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBm0Q-0006Nv-Su
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 17:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBlzF-0005lg-3d
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:00:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBlzB-0002UA-EX
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:00:22 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:39710)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jBlz8-0002LX-4c; Tue, 10 Mar 2020 17:00:18 -0400
Received: by mail-io1-xd44.google.com with SMTP id f21so10120809iol.6;
 Tue, 10 Mar 2020 14:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+k539H0wdv25YofOsGPJ1QwrqIJwYGHEDLwgvx5ARbE=;
 b=rCG+CtDdTlmVmj/OnvhBXBifN8Lm57OJagmRYnPWVZX+ZKSeO+XuaX+k72FsTEUDmi
 x/lf/w3DJnyMJrfSYgUW0RiE1xPgxVtNmmNem9lwUowxsdmxvDFD+EfQyw4Q4xHXkip/
 GlRxXmcOSfBsU2EQ8Q+RgILy37EdzjdzfgWtVzec72JuNiL4dD3YR7XRLKNQMwai0/nf
 j9ve55BbPrD+4GNty3hR8lStSZ1k6iXlw4QhGlFK/wNPmd7Fua3wJylnQRnzUxIOF5Ss
 pfAR+TyjPPpGp6RK1nKMB6MaONeKhAF8enaylKeyueUg29CtHQbQ4h7rRhrTWoYwq4C3
 n7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+k539H0wdv25YofOsGPJ1QwrqIJwYGHEDLwgvx5ARbE=;
 b=A5r5p30wqkp6juLGQgE4guTlJ2UX7RpRg5sndG/uJ/IiFWaTXgZ0Y5yGZVe9n2z0lv
 5G2rnu7JPQl4hoVXBet2e0cE6sQGZ9FwBnOMM2qHOFytL8u/ZBftCqGwG920gEFp1nZ+
 ocikD5u1+kMUy9Dh7hl9ORUX7GPApgHZLJNjJuXnVXrCKKStbRNFgnk3rQmeJdLvuB68
 sVDkQRB5CBFCLz08NtAXEJhM493NrX8aUhVVBBHpMVwPJioX+icPp547J4CtVWKx6GcR
 yPZFMOHU1NutKT2w8CgGCL/eYAjeFOcc9dSchIyrJXT1j/8YvvqfDF2WysM6jBrrLRtM
 uXNA==
X-Gm-Message-State: ANhLgQ2gf9WMGRpE2Mjhrjwfqnw6ySA4yyJGO+J7mXHUWNMggon7A7I+
 HeSp9K3YYEbhuOceoGi+jZwEfQBjsvy/5BxkDfE=
X-Google-Smtp-Source: ADFU+vtF1X/Ld1FU4drpxGoBUux7aRg4jxiaZbRC6v/bxMpNq8UmYDSFI2wj+iQfQbkzK91UFh07Hforuzjlj8e5ZJE=
X-Received: by 2002:a02:856a:: with SMTP id g97mr9689jai.97.1583874016786;
 Tue, 10 Mar 2020 14:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200309215818.2021-1-peter.maydell@linaro.org>
 <20200309215818.2021-5-peter.maydell@linaro.org>
In-Reply-To: <20200309215818.2021-5-peter.maydell@linaro.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Tue, 10 Mar 2020 22:00:04 +0100
Message-ID: <CAPan3WrNQRbnx-bTjPpEbW=wNQS2tR0EGien18mPimn5YGmTZg@mail.gmail.com>
Subject: Re: [PATCH 4/5] docs: Move arm-cpu-features.rst into the system manual
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000023bd3d05a08668a1"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000023bd3d05a08668a1
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>

On Mon, Mar 9, 2020 at 10:58 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> Now we have somewhere to put arm-specific rst documentation,
> we can move arm-cpu-features.rst from the docs/ top level
> directory into docs/system/arm/.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  .../{arm-cpu-features.rst => system/arm/cpu-features.rst} | 8 +-------
>  docs/system/target-arm.rst                                | 6 ++++++
>  2 files changed, 7 insertions(+), 7 deletions(-)
>  rename docs/{arm-cpu-features.rst => system/arm/cpu-features.rst} (99%)
>
> diff --git a/docs/arm-cpu-features.rst b/docs/system/arm/cpu-features.rst
> similarity index 99%
> rename from docs/arm-cpu-features.rst
> rename to docs/system/arm/cpu-features.rst
> index fc1623aeca5..7495b7b672b 100644
> --- a/docs/arm-cpu-features.rst
> +++ b/docs/system/arm/cpu-features.rst
> @@ -1,11 +1,5 @@
> +Arm CPU Features
>  ================
> -ARM CPU Features
> -================
> -
> -Examples of probing and using ARM CPU features
> -
> -Introduction
> -============
>
>  CPU features are optional features that a CPU of supporting type may
>  choose to implement or not.  In QEMU, optional CPU features have
> diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> index 86ea6f2f568..1425bd5303a 100644
> --- a/docs/system/target-arm.rst
> +++ b/docs/system/target-arm.rst
> @@ -78,3 +78,9 @@ undocumented; you can get a complete list by running
>     arm/stellaris
>     arm/musicpal
>     arm/sx1
> +
> +Arm CPU features
> +================
> +
> +.. toctree::
> +   arm/cpu-features
> --
> 2.20.1
>
>

-- 
Niek Linnenbank

--00000000000023bd3d05a08668a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklin=
nenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt;<br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 9, 2020 =
at 10:58 PM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">p=
eter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">Now we have somewhere to put arm-specific rst docume=
ntation,<br>
we can move arm-cpu-features.rst from the docs/ top level<br>
directory into docs/system/arm/.<br>
<br>
Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org=
" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
---<br>
=C2=A0.../{arm-cpu-features.rst =3D&gt; system/arm/cpu-features.rst} | 8 +-=
------<br>
=C2=A0docs/system/target-arm.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 6 +=
+++++<br>
=C2=A02 files changed, 7 insertions(+), 7 deletions(-)<br>
=C2=A0rename docs/{arm-cpu-features.rst =3D&gt; system/arm/cpu-features.rst=
} (99%)<br>
<br>
diff --git a/docs/arm-cpu-features.rst b/docs/system/arm/cpu-features.rst<b=
r>
similarity index 99%<br>
rename from docs/arm-cpu-features.rst<br>
rename to docs/system/arm/cpu-features.rst<br>
index fc1623aeca5..7495b7b672b 100644<br>
--- a/docs/arm-cpu-features.rst<br>
+++ b/docs/system/arm/cpu-features.rst<br>
@@ -1,11 +1,5 @@<br>
+Arm CPU Features<br>
=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-ARM CPU Features<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-<br>
-Examples of probing and using ARM CPU features<br>
-<br>
-Introduction<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
=C2=A0CPU features are optional features that a CPU of supporting type may<=
br>
=C2=A0choose to implement or not.=C2=A0 In QEMU, optional CPU features have=
<br>
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst<br>
index 86ea6f2f568..1425bd5303a 100644<br>
--- a/docs/system/target-arm.rst<br>
+++ b/docs/system/target-arm.rst<br>
@@ -78,3 +78,9 @@ undocumented; you can get a complete list by running<br>
=C2=A0 =C2=A0 arm/stellaris<br>
=C2=A0 =C2=A0 arm/musicpal<br>
=C2=A0 =C2=A0 arm/sx1<br>
+<br>
+Arm CPU features<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
+<br>
+.. toctree::<br>
+=C2=A0 =C2=A0arm/cpu-features<br>
-- <br>
2.20.1<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div>

--00000000000023bd3d05a08668a1--

