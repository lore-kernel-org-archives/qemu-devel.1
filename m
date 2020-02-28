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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2CCC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 20:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 987E624677
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 20:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H26V2MZh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987E624677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7m6U-0001Xa-RD
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 15:19:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j7m5q-0000ye-Eg
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 15:18:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j7m5o-0000ay-Vc
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 15:18:42 -0500
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:43250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j7m5o-0000aj-PO; Fri, 28 Feb 2020 15:18:40 -0500
Received: by mail-io1-xd44.google.com with SMTP id n21so4832146ioo.10;
 Fri, 28 Feb 2020 12:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zJo13C/fpyM1Civx33BwXNXgau4DiEh2S1nc11FbHK8=;
 b=H26V2MZhNhTkShWqgwlzdMu6TAX4ctIryZv5akLeJlv6WiSOYR/mefpCiaRKSVMnc3
 OuPkJLI+UFOV0Avhw5URa1Mat68kCGzY+lj56GF7Td/d37v4dbABPceXpOku0CIuuI3J
 6yUCtiOUdUdjbJ+zosYVxLmYf7TX6eM87lw45tJyPHHkZdGhgyRpBSges82xcO7dudf3
 wsdk5WNGFu4/yIEJwNxNbuKUTEtoPEBADFgvsHzcztc8vCbzGhXob6U//2pRZpcyzVhF
 OLISDRg5Ov6ebBwxeuuA5A/6RymwDH6wvmk+LWT3TakpXtKztghU+jtWqf27zQOnFb2j
 cgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zJo13C/fpyM1Civx33BwXNXgau4DiEh2S1nc11FbHK8=;
 b=Wby/rP59i3HfcfZ8CIJGLwVFJbi9/tmExWZb0yt3SS7bXKREb4x1NjtC8CX7VNPhvf
 PISX5CGqtPFSx2iwA73z7YZtK4o2iqLHoasAMzUhrPkEBV2egwZI+NDj1m90e8vuNEkh
 N2oNU0+b/drUJRTMe0B2F3ZhD4DSy/Cw5pxdUwkOZ4oZKwzb5r7r3A5jilaO65Sknft2
 8nvkrjLiMM3/s3IL4KT6dQsBVdESFa3/0ip7oTDd+b7FGTpc1MMi87/dtdT9A4PTOeDK
 1P4R3aApG+VU1inOdBrua6CMvSkYf2WaDno5KW0Q7e/ZIZSIZf2gRNXWGM9caEYYK2u+
 1dBg==
X-Gm-Message-State: APjAAAWC/aLRSM99G/cchXLtCMaI89ESFfoQbYAuH4NG6eQSV2yRqT+2
 HiA5b79TMwnfgdWlMhS4sJxNmOvKstp7dbLniI8=
X-Google-Smtp-Source: APXvYqzMARJfBKN3xHOPf2nq53amXzS9VpJ6OdOWaC8dUUwprp4vObBYKXcazwQWe1v367DjeoGzuKbA4duwQnnSm2c=
X-Received: by 2002:a05:6602:158e:: with SMTP id
 e14mr4773586iow.217.1582921120024; 
 Fri, 28 Feb 2020 12:18:40 -0800 (PST)
MIME-Version: 1.0
References: <20200228192415.19867-1-alex.bennee@linaro.org>
 <20200228192415.19867-5-alex.bennee@linaro.org>
In-Reply-To: <20200228192415.19867-5-alex.bennee@linaro.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Fri, 28 Feb 2020 21:18:29 +0100
Message-ID: <CAPan3WpV=Uh1JYnQojG50jCYNfe8HfMQaZ6ia_0XGxjYhtOJ0w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] accel/tcg: increase default code gen buffer size
 for 64 bit
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000110c1b059fa88be5"
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000110c1b059fa88be5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2020 at 8:24 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

> While 32mb is certainly usable a full system boot ends up flushing the
> codegen buffer nearly 100 times. Increase the default on 64 bit hosts
> to take advantage of all that spare memory. After this change I can
> boot my tests system without any TB flushes.
>
> As we usually run more CONFIG_USER binaries at a time in typical usage
> we aren't quite as profligate for user-mode code generation usage. We
> also bring the static code gen defies to the same place to keep all
> the reasoning in the comments together.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>


>
> ---
> v2
>   - 2gb->1gb for system emulation
>   - split user and system emulation buffer sizes
> ---
>  accel/tcg/translate-all.c | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 4ce5d1b3931..78914154bfc 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -892,15 +892,6 @@ static void page_lock_pair(PageDesc **ret_p1,
> tb_page_addr_t phys1,
>      }
>  }
>
> -#if defined(CONFIG_USER_ONLY) && TCG_TARGET_REG_BITS =3D=3D 32
> -/*
> - * For user mode on smaller 32 bit systems we may run into trouble
> - * allocating big chunks of data in the right place. On these systems
> - * we utilise a static code generation buffer directly in the binary.
> - */
> -#define USE_STATIC_CODE_GEN_BUFFER
> -#endif
> -
>  /* Minimum size of the code gen buffer.  This number is randomly chosen,
>     but not so small that we can't have a fair number of TB's live.  */
>  #define MIN_CODE_GEN_BUFFER_SIZE     (1 * MiB)
> @@ -929,7 +920,33 @@ static void page_lock_pair(PageDesc **ret_p1,
> tb_page_addr_t phys1,
>  # define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
>  #endif
>
> +#if TCG_TARGET_REG_BITS =3D=3D 32
>  #define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32 * MiB)
> +#ifdef CONFIG_USER_ONLY
> +/*
> + * For user mode on smaller 32 bit systems we may run into trouble
> + * allocating big chunks of data in the right place. On these systems
> + * we utilise a static code generation buffer directly in the binary.
> + */
> +#define USE_STATIC_CODE_GEN_BUFFER
> +#endif
> +#else /* TCG_TARGET_REG_BITS =3D=3D 64 */
> +#ifdef CONFIG_USER_ONLY
> +/*
> + * As user-mode emulation typically means running multiple instances
> + * of the translator don't go too nuts with our default code gen
> + * buffer lest we make things too hard for the OS.
> + */
> +#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (128 * MiB)
> +#else
> +/*
> + * We expect most system emulation to run one or two guests per host.
> + * Users running large scale system emulation may want to tweak their
> + * runtime setup via the tb-size control on the command line.
> + */
> +#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (1 * GiB)
> +#endif
> +#endif
>
>  #define DEFAULT_CODE_GEN_BUFFER_SIZE \
>    (DEFAULT_CODE_GEN_BUFFER_SIZE_1 < MAX_CODE_GEN_BUFFER_SIZE \
> --
> 2.20.1
>
>

--=20
Niek Linnenbank

--000000000000110c1b059fa88be5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 28, 2020 at 8:24 PM Alex =
Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linar=
o.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">While 32mb is certainly usable a full system boot ends up flushing the=
<br>
codegen buffer nearly 100 times. Increase the default on 64 bit hosts<br>
to take advantage of all that spare memory. After this change I can<br>
boot my tests system without any TB flushes.<br>
<br>
As we usually run more CONFIG_USER binaries at a time in typical usage<br>
we aren&#39;t quite as profligate for user-mode code generation usage. We<b=
r>
also bring the static code gen defies to the same place to keep all<br>
the reasoning in the comments together.<br>
<br>
Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
Tested-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com" =
target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br></blockquote><div>Rev=
iewed-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com">n=
ieklinnenbank@gmail.com</a>&gt;<br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
---<br>
v2<br>
=C2=A0 - 2gb-&gt;1gb for system emulation<br>
=C2=A0 - split user and system emulation buffer sizes<br>
---<br>
=C2=A0accel/tcg/translate-all.c | 35 ++++++++++++++++++++++++++---------<br=
>
=C2=A01 file changed, 26 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c<br>
index 4ce5d1b3931..78914154bfc 100644<br>
--- a/accel/tcg/translate-all.c<br>
+++ b/accel/tcg/translate-all.c<br>
@@ -892,15 +892,6 @@ static void page_lock_pair(PageDesc **ret_p1, tb_page_=
addr_t phys1,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-#if defined(CONFIG_USER_ONLY) &amp;&amp; TCG_TARGET_REG_BITS =3D=3D 32<br>
-/*<br>
- * For user mode on smaller 32 bit systems we may run into trouble<br>
- * allocating big chunks of data in the right place. On these systems<br>
- * we utilise a static code generation buffer directly in the binary.<br>
- */<br>
-#define USE_STATIC_CODE_GEN_BUFFER<br>
-#endif<br>
-<br>
=C2=A0/* Minimum size of the code gen buffer.=C2=A0 This number is randomly=
 chosen,<br>
=C2=A0 =C2=A0 but not so small that we can&#39;t have a fair number of TB&#=
39;s live.=C2=A0 */<br>
=C2=A0#define MIN_CODE_GEN_BUFFER_SIZE=C2=A0 =C2=A0 =C2=A0(1 * MiB)<br>
@@ -929,7 +920,33 @@ static void page_lock_pair(PageDesc **ret_p1, tb_page_=
addr_t phys1,<br>
=C2=A0# define MAX_CODE_GEN_BUFFER_SIZE=C2=A0 ((size_t)-1)<br>
=C2=A0#endif<br>
<br>
+#if TCG_TARGET_REG_BITS =3D=3D 32<br>
=C2=A0#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32 * MiB)<br>
+#ifdef CONFIG_USER_ONLY<br>
+/*<br>
+ * For user mode on smaller 32 bit systems we may run into trouble<br>
+ * allocating big chunks of data in the right place. On these systems<br>
+ * we utilise a static code generation buffer directly in the binary.<br>
+ */<br>
+#define USE_STATIC_CODE_GEN_BUFFER<br>
+#endif<br>
+#else /* TCG_TARGET_REG_BITS =3D=3D 64 */<br>
+#ifdef CONFIG_USER_ONLY<br>
+/*<br>
+ * As user-mode emulation typically means running multiple instances<br>
+ * of the translator don&#39;t go too nuts with our default code gen<br>
+ * buffer lest we make things too hard for the OS.<br>
+ */<br>
+#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (128 * MiB)<br>
+#else<br>
+/*<br>
+ * We expect most system emulation to run one or two guests per host.<br>
+ * Users running large scale system emulation may want to tweak their<br>
+ * runtime setup via the tb-size control on the command line.<br>
+ */<br>
+#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (1 * GiB)<br>
+#endif<br>
+#endif<br>
<br>
=C2=A0#define DEFAULT_CODE_GEN_BUFFER_SIZE \<br>
=C2=A0 =C2=A0(DEFAULT_CODE_GEN_BUFFER_SIZE_1 &lt; MAX_CODE_GEN_BUFFER_SIZE =
\<br>
-- <br>
2.20.1<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000110c1b059fa88be5--

