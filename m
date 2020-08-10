Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A130DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 07:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D8E20773
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 07:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2tCOINJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D8E20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k52KW-0003xI-Ll
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 03:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1k52Ja-0003E1-Ku
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 03:33:50 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1k52JY-0003Bb-S8
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 03:33:50 -0400
Received: by mail-wr1-x443.google.com with SMTP id r2so7150062wrs.8
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 00:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jrebPfOxiKRIV4NseMqZLL15THo7osMGeEsLT3z/rpg=;
 b=T2tCOINJ8J0ulc/61eH0GGYisAcrz0zPDzm7MKwGTfeUSD5V+15+OPwQnDxtHfiTTy
 ezEj2IpYPdWClVy8Y5SxXYs5TA6/A2+b3e3SY5IBRl96Fe3ZEq6sVVJXmsdEcH1w11eC
 8eNi0Yj0dpdqeb/YzcnbsKwWNRFcNT0U3O2sfH+kztzqvWVbC5B2x3e1GZv+UbPiPyGd
 j89j87NrRxEfDuheSd1uY9+HffFraJqkViD2WoVjYXLDHtt4Y8P3vJ2/MAWzf2FFjXWu
 tlTY+uCRPC566E90UYRZiAekcTyUzYiIQXxjcf3xs91YpOqWUtGwF1apSoUOft/MA7Xb
 nJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jrebPfOxiKRIV4NseMqZLL15THo7osMGeEsLT3z/rpg=;
 b=GSelI4ZLizP+yzhPpV+bNyLgQOQjmiT1GhW7RpEjeJShDITba2xoOP+wRiDejqyvf5
 VHBhUB4SrfEBNeezGf+CfYkoJWQpZMade7B0Q9wYzARq6Z3cK3TcCXC0qyRsa7E7FRlA
 zrIJYNbtLKE9oAxLYsrq+GeBItJ/Nh3xSSbDVxIri4jzIr5mMDwUzgkrgFq/SvgqWv3J
 bNkQ2pt0BczZlSOFFFZiTcoxeB4jyFUWFp7Z6YFqZssI0OEjgtz2UVizChV3Txf8kzAm
 kRdo1zabBxZ/41i1xiTDQyEW81MDnV8XyAC0XqbrtIbGhWTshDVY3xSEQ4TUfXkLk7dI
 2g3g==
X-Gm-Message-State: AOAM532R6hgh+ZlADc99JZIoNTIOhJEArjW044NilnwO+yo4aaPvYd17
 Xo8gwO4r0PWTbzK8oEuPhcGP/xehs9RoUAQgGWc=
X-Google-Smtp-Source: ABdhPJy2Vz85iN1u59xlq2e0IRk1s1rQcyGhP7y8PSKnq72lMbGckZchLZ/fjV1BKBksUZaEsd3g3mHO3Ivzp2faaPs=
X-Received: by 2002:adf:e8cc:: with SMTP id k12mr24153761wrn.2.1597044826397; 
 Mon, 10 Aug 2020 00:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200615225827.183062-1-joe.slater@windriver.com>
In-Reply-To: <20200615225827.183062-1-joe.slater@windriver.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 10 Aug 2020 11:33:34 +0400
Message-ID: <CAJ+F1CJdHo7R9rnmoD1cLEzsYLFsFVVjcAr5UcsYFgfcW3z2LA@mail.gmail.com>
Subject: Re: [PATCH 1/1] os_find_datadir: search as in version 4.2
To: Joe Slater <joe.slater@windriver.com>
Content-Type: multipart/alternative; boundary="000000000000915ff905ac80f9a8"
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: QEMU <qemu-devel@nongnu.org>, randy.macleod@windriver.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000915ff905ac80f9a8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2020 at 2:59 AM Joe Slater <joe.slater@windriver.com> wrote=
:

> Always look for ../share/qemu then ../pc-bios when looking for datadir.
>
> Signed-off-by: Joe Slater <joe.slater@windriver.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  os-posix.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/os-posix.c b/os-posix.c
> index 3cd52e1e70..f77da94bf6 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -82,8 +82,9 @@ void os_setup_signal_handling(void)
>
>  /*
>   * Find a likely location for support files using the location of the
> binary.
> + * Typically, this would be "$bindir/../share/qemu".
>   * When running from the build tree this will be "$bindir/../pc-bios".
> - * Otherwise, this is CONFIG_QEMU_DATADIR.
> + * Otherwise, this is CONFIG_QEMU_DATADIR as constructed by configure.
>   */
>  char *os_find_datadir(void)
>  {
> @@ -93,6 +94,12 @@ char *os_find_datadir(void)
>      exec_dir =3D qemu_get_exec_dir();
>      g_return_val_if_fail(exec_dir !=3D NULL, NULL);
>
> +    dir =3D g_build_filename(exec_dir, "..", "share", "qemu", NULL);
> +    if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
> +        return g_steal_pointer(&dir);
> +    }
> +    g_free(dir);  /* no autofree this time */
> +
>      dir =3D g_build_filename(exec_dir, "..", "pc-bios", NULL);
>      if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
>          return g_steal_pointer(&dir);
> --
> 2.17.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000915ff905ac80f9a8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 16, 2020 at 2:59 AM Joe S=
later &lt;<a href=3D"mailto:joe.slater@windriver.com">joe.slater@windriver.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">Always look for ../share/qemu then ../pc-bios when looking for datadir.<=
br>
<br>
Signed-off-by: Joe Slater &lt;<a href=3D"mailto:joe.slater@windriver.com" t=
arget=3D"_blank">joe.slater@windriver.com</a>&gt;<br></blockquote><div><br>=
</div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcan=
dre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;=C2=A0 <br></div>=
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0os-posix.c | 9 ++++++++-<br>
=C2=A01 file changed, 8 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/os-posix.c b/os-posix.c<br>
index 3cd52e1e70..f77da94bf6 100644<br>
--- a/os-posix.c<br>
+++ b/os-posix.c<br>
@@ -82,8 +82,9 @@ void os_setup_signal_handling(void)<br>
<br>
=C2=A0/*<br>
=C2=A0 * Find a likely location for support files using the location of the=
 binary.<br>
+ * Typically, this would be &quot;$bindir/../share/qemu&quot;.<br>
=C2=A0 * When running from the build tree this will be &quot;$bindir/../pc-=
bios&quot;.<br>
- * Otherwise, this is CONFIG_QEMU_DATADIR.<br>
+ * Otherwise, this is CONFIG_QEMU_DATADIR as constructed by configure.<br>
=C2=A0 */<br>
=C2=A0char *os_find_datadir(void)<br>
=C2=A0{<br>
@@ -93,6 +94,12 @@ char *os_find_datadir(void)<br>
=C2=A0 =C2=A0 =C2=A0exec_dir =3D qemu_get_exec_dir();<br>
=C2=A0 =C2=A0 =C2=A0g_return_val_if_fail(exec_dir !=3D NULL, NULL);<br>
<br>
+=C2=A0 =C2=A0 dir =3D g_build_filename(exec_dir, &quot;..&quot;, &quot;sha=
re&quot;, &quot;qemu&quot;, NULL);<br>
+=C2=A0 =C2=A0 if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return g_steal_pointer(&amp;dir);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 g_free(dir);=C2=A0 /* no autofree this time */<br>
+<br>
=C2=A0 =C2=A0 =C2=A0dir =3D g_build_filename(exec_dir, &quot;..&quot;, &quo=
t;pc-bios&quot;, NULL);<br>
=C2=A0 =C2=A0 =C2=A0if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return g_steal_pointer(&amp;dir);<br>
-- <br>
2.17.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000915ff905ac80f9a8--

