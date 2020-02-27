Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69D4C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 19:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B11B024691
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 19:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0/vNIM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11B024691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7OjZ-0005bZ-R4
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 14:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j7Ohw-0003Q1-Vz
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 14:20:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j7Ohv-0004xh-JI
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 14:20:28 -0500
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:33025)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j7Oht-0004uK-VS; Thu, 27 Feb 2020 14:20:26 -0500
Received: by mail-il1-x144.google.com with SMTP id s18so616846iln.0;
 Thu, 27 Feb 2020 11:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uei+Q55y4h9fZrlb1rValsZkG5GHnuVT5+jSW+UWrfc=;
 b=q0/vNIM+NuDG8Dm47cjMgM1nhLYoJmc3+2oiEEg1koPXlPK5oCm2zCViSzM9Gr0P1k
 jE6J+Nj67Vcj6lhapHm3Rvufl0vXVgDsQui3CC0GZQraewsC/s4dI+tHhdKwFF8b387z
 K1U73QwqC5iOk/NzOJP+SzAWYocHsg67UIQ1j/sNGi+Hic88/qu7QGPaS4DRYP6U+BWM
 In+SLt2ythR0UfBlcOTKBHYU8yqAa2OBKeOTQpUwNVCCDLRqPFF8eWhrUhk4+t4lotW1
 cnvMkBoFnCBPUqI3DojJjj6DbUroPij4le32VcokG3OClausp/zUscBotqnSgU80yNrO
 59hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uei+Q55y4h9fZrlb1rValsZkG5GHnuVT5+jSW+UWrfc=;
 b=DA6HeGele6Wx0yqf468flW1TsbMDb/eSV9efWmu41XMk+03GctWWncrqKEwdVFJ1Z6
 cFzjwTxtMsGmGVEihV2Wt5IMmayvteEjbO0Ma+29TouGJWFhm+J+EgqMeNLYM3zrAdEm
 vswPr+SUdcnsDBmfVo/PmMaxgQSN7KshSnHVyVwDqjk/dJE+xJUnPxg418TgGl33lNym
 bjA/tv6/Zmb080m8KJASVx/NsupKL0N3WDxM741bQhjp+OHMj1ErxqH6GdXaHxnz7Ecd
 IxhTfO5Is+BMDD71hbjhLvXNVlqsM7akkRqZ51P68pkUwsvvaTIly1LJa4sfV+yiqTdN
 wmpg==
X-Gm-Message-State: APjAAAXhsTOoTb+qc5wgBxyGdWkLlw3/tLXhkcCdGHGekH8tdT79oGi1
 bJtP4QVbOycUl0Kz3+mjO6X6hytipZjeEJ1FpOk=
X-Google-Smtp-Source: APXvYqytSBT2k2y7/yCH3uj00NfJaJEw3K8jTLfULXGWWtYSDL895kpXeWTtJCHaJhl4OQR2jnszXJRC/EJrPbFgZYo=
X-Received: by 2002:a92:5f45:: with SMTP id t66mr894726ilb.28.1582831225169;
 Thu, 27 Feb 2020 11:20:25 -0800 (PST)
MIME-Version: 1.0
References: <20200226181020.19592-1-alex.bennee@linaro.org>
 <20200226181020.19592-4-alex.bennee@linaro.org>
In-Reply-To: <20200226181020.19592-4-alex.bennee@linaro.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Thu, 27 Feb 2020 20:20:14 +0100
Message-ID: <CAPan3WquVnHMGDur2_eQ57CzhekH-Ct3avjoxcct5xMv7_P+Fw@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] accel/tcg: only USE_STATIC_CODE_GEN_BUFFER on 32
 bit hosts
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000ea6b7b059f939c98"
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ea6b7b059f939c98
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2020 at 7:12 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

> There is no particular reason to use a static codegen buffer on 64 bit
> hosts as we have address space to burn. Allow the common CONFIG_USER
> case to use the mmap'ed buffers like SoftMMU.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  accel/tcg/translate-all.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 5b66af783b5..4ce5d1b3931 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -892,11 +892,12 @@ static void page_lock_pair(PageDesc **ret_p1,
> tb_page_addr_t phys1,
>      }
>  }
>
> -#if defined(CONFIG_USER_ONLY)
> -/* Currently it is not recommended to allocate big chunks of data in
> -   user mode. It will change when a dedicated libc will be used.  */
> -/* ??? 64-bit hosts ought to have no problem mmaping data outside the
> -   region in which the guest needs to run.  Revisit this.  */
> +#if defined(CONFIG_USER_ONLY) && TCG_TARGET_REG_BITS =3D=3D 32
> +/*
> + * For user mode on smaller 32 bit systems we may run into trouble
> + * allocating big chunks of data in the right place. On these systems
> + * we utilise a static code generation buffer directly in the binary.
> + */
>  #define USE_STATIC_CODE_GEN_BUFFER
>  #endif
>
> --
> 2.20.1
>
>
> Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>

--=20
Niek Linnenbank

--000000000000ea6b7b059f939c98
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 26, 2020 at 7:12 PM Alex =
Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linar=
o.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">There is no particular reason to use a static codegen buffer on 64 bit=
<br>
hosts as we have address space to burn. Allow the common CONFIG_USER<br>
case to use the mmap&#39;ed buffers like SoftMMU.<br>
<br>
Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
---<br>
=C2=A0accel/tcg/translate-all.c | 11 ++++++-----<br>
=C2=A01 file changed, 6 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c<br>
index 5b66af783b5..4ce5d1b3931 100644<br>
--- a/accel/tcg/translate-all.c<br>
+++ b/accel/tcg/translate-all.c<br>
@@ -892,11 +892,12 @@ static void page_lock_pair(PageDesc **ret_p1, tb_page=
_addr_t phys1,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-#if defined(CONFIG_USER_ONLY)<br>
-/* Currently it is not recommended to allocate big chunks of data in<br>
-=C2=A0 =C2=A0user mode. It will change when a dedicated libc will be used.=
=C2=A0 */<br>
-/* ??? 64-bit hosts ought to have no problem mmaping data outside the<br>
-=C2=A0 =C2=A0region in which the guest needs to run.=C2=A0 Revisit this.=
=C2=A0 */<br>
+#if defined(CONFIG_USER_ONLY) &amp;&amp; TCG_TARGET_REG_BITS =3D=3D 32<br>
+/*<br>
+ * For user mode on smaller 32 bit systems we may run into trouble<br>
+ * allocating big chunks of data in the right place. On these systems<br>
+ * we utilise a static code generation buffer directly in the binary.<br>
+ */<br>
=C2=A0#define USE_STATIC_CODE_GEN_BUFFER<br>
=C2=A0#endif<br>
<br>
-- <br>
2.20.1<br>
<br>
<br>
</blockquote></div>Reviewed-by: Niek Linnenbank &lt;<a href=3D"mailto:niekl=
innenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt;<br clear=3D"all"><div=
><br>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><di=
v>Niek Linnenbank<br><br></div></div></div></div></div>

--000000000000ea6b7b059f939c98--

