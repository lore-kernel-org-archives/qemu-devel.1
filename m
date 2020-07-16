Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FDEC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72EB3207DD
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLU3ZD5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72EB3207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw4dx-0003qC-P4
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 10:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jw4d5-00035c-9E
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:12:55 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jw4d3-00035H-Fa
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:12:54 -0400
Received: by mail-wr1-x441.google.com with SMTP id s10so7177576wrw.12
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ji6IGAgZ/N8I0mJWSIC61YbaGEsX8EjQjIokPcwKjqI=;
 b=dLU3ZD5y8VYZPtGPpJtisFzOqc2bygK6oKmcgIeT5617DMR+Bwg4I4pnkafj2P50hq
 wNmhWpefpCG24LIXuMuoZTIcPQ89mQ2Z8cg+MjOoS3Xr7albYKSZt6JvdcGERHlX921P
 rOLMtrqNzbP6Sz2+/N1R9nrWFbzrK19Ju/A+8A6bNpnT5zUeeZMYc06VZCNCWt10akoS
 /etiEd1BZVrexYz5nL2btD8qok7jBNhTPlAthNRpjs5BFslU/tqezoI4VLzxexg6VrwS
 5ceOCcOhrxlvzDR/MlLrfNwjohIAlfdRKlJOhNNfFYOYq8SEfw4KZeGdSSoHH5h3BvvI
 DPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ji6IGAgZ/N8I0mJWSIC61YbaGEsX8EjQjIokPcwKjqI=;
 b=Z5pO61LtdDlY9UsYjvlGl6whlTJV+WaP0CqQMkpV5d2XvVXzEU/y9dC54Bgquylvxe
 Nl2pb0Bjvj/7JfiPLROiG3zQdaNcPbj4zPM9q8WacO9dLoPUIKsNQOgqOxHRq5W3i1Px
 lpN2Nt0izhyI48x/wepTVOZv+m9kuiZlXG1mAFI8eOEZPklWGzp9zSB8/vN0ErACsFwy
 KRvhzMMyIHok9sVLDlZ3eXEqFLtc60frTFlGI4KpWCrmtZEZbUFDk9N+0LduvH4IG2Em
 F54zeWxwv1zfTvhv3yKGiJUf1/Ri4V0kH+rOTt5IuDU/FWQXnZGb0iotHnRSKWJ9MkTw
 otRg==
X-Gm-Message-State: AOAM533UyaefjXSJHVy0vcX46y2B0s7qoYBp6IrqfgNMbdrCe9ICGYZ5
 0VNuuMo1O512aBROWa54N0JgMpCCY4dOvRkXkqo=
X-Google-Smtp-Source: ABdhPJy8crOBhWnR0JZxmafUzOqrF/7hqZljzRa6nqd8Wftr5LceCt0pBu1kPa+r6j3TcqorieyYQHF9MC+kK33h/cE=
X-Received: by 2002:a5d:43d2:: with SMTP id v18mr5221002wrr.196.1594908771999; 
 Thu, 16 Jul 2020 07:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200615225827.183062-1-joe.slater@windriver.com>
In-Reply-To: <20200615225827.183062-1-joe.slater@windriver.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 16 Jul 2020 18:12:40 +0400
Message-ID: <CAJ+F1CJmMV6pY6r0P6ukNZA_q+w6yLvAxekGnusgXYuuip6gZA@mail.gmail.com>
Subject: Re: [PATCH 1/1] os_find_datadir: search as in version 4.2
To: Joe Slater <joe.slater@windriver.com>
Content-Type: multipart/alternative; boundary="000000000000cde67605aa8fa2f7"
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wr1-x441.google.com
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

--000000000000cde67605aa8fa2f7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Jun 16, 2020 at 2:59 AM Joe Slater <joe.slater@windriver.com> wrote=
:

> Always look for ../share/qemu then ../pc-bios when looking for datadir.
>
> Signed-off-by: Joe Slater <joe.slater@windriver.com>
>

Looks good to me, with:
Fixes: 6dd2dacedd83d12328 ("os-posix: simplify os_find_datadir")
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Alternatively, we may want to check the binary install location to decide
which path to return. I sent a proposal "[RFC PATCH] os-posix: fix
regression for install-less datadir location".

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

--000000000000cde67605aa8fa2f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 16, 2020 at 2:59 AM Joe=
 Slater &lt;<a href=3D"mailto:joe.slater@windriver.com">joe.slater@windrive=
r.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">Always look for ../share/qemu then ../pc-bios when looking for datadir=
.<br>
<br>
Signed-off-by: Joe Slater &lt;<a href=3D"mailto:joe.slater@windriver.com" t=
arget=3D"_blank">joe.slater@windriver.com</a>&gt;<br></blockquote><div><br>=
</div><div>Looks good to me, with:</div><div>Fixes: 6dd2dacedd83d12328 (&qu=
ot;os-posix: simplify os_find_datadir&quot;)</div><div>Reviewed-by: Marc-An=
dr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandr=
e.lureau@redhat.com</a>&gt;</div><div><br></div><div>Alternatively, we may =
want to check the binary install location to decide which path to return. I=
 sent a proposal &quot;[RFC PATCH] os-posix: fix regression for install-les=
s datadir location&quot;.<br></div><div><br> </div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
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

--000000000000cde67605aa8fa2f7--

