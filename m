Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB64C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 02:58:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC1E620796
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 02:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vhsBhkKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1E620796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF7MM-0007GM-Pg
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 22:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kF7Lm-0006rA-PL
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 22:57:46 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:43891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kF7Ll-0006pY-3M
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 22:57:46 -0400
Received: by mail-lj1-x244.google.com with SMTP id u4so13404680ljd.10
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2020 19:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=2hq8jpUb7PmymYi0kT3PicbE43njMLPKY2dZFng6nu0=;
 b=vhsBhkKnJgsbkJGNAmvwLUpZtkTOAG0GgUo0LrgoucRKJcyj5zcdHpUPay2JZDNpVV
 nnQ72aJb8FRNtU3jPKCn7o3r0iRvlxeSGxicI+OlSxFoSM7KRlsiK5UF+AAVFU+V+aJK
 5xPTxswpEeSnnkdvzqUn+J9V9kDEe0ScWz/kY+CW7BKwLMLHr1t44da3+hauBhlExopP
 QuEnSbS5EQqzAJQ0tE/X9p//Tw8HTd3VPQsIk63RcstKDkaXs2G6nEGh1Uo12e0yJW2E
 AFVrdoUX3/DFjJXWPYpfx009Ep+xQubeH5AtdhY1dyOg9N4Mu9Zb/DO5cCEAS1pFkLzY
 yWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=2hq8jpUb7PmymYi0kT3PicbE43njMLPKY2dZFng6nu0=;
 b=i2kpBTFN/jZOhUSG5I+cdPV6GO4HAuI4qx98emquVcXUug2u5CB7DpP7OKmo9xTvwW
 jBbHYLtmy9yIkD0gK4rwDdScgr68a6oNvMfdPdMcKo1A866k3fHBipT7m5Snn2+fdqnR
 EpO7CjZ5aH7oV6qvXriegIIUXp/kTRnONQWke/H8jhvZxIMUEogxscuZZc+cH7qoY6Ly
 nGShYnbUx6f81XdQjlqmnkLBAQThXXD5A/4Q3Z2Q9xVv7MGRmsLoaUYq1IHggBnY7iva
 tiyR+JsZ3krVdwFcZlI2yB93ibJNuNWOWvfO5G9mHSE9wM0b525qtpk3wyZkctEzdp2r
 +nGA==
X-Gm-Message-State: AOAM531Lb0+xHfp3/QJIfe+V45Hyq1GlEOi6+Z+Gt5sUnjt/RCwvLkQv
 YHtRVpLEFTjCMDK9dFBfIf/nTyEc0UU1Kq6zeOLmUAyU6mTkOw==
X-Google-Smtp-Source: ABdhPJz4GlsD9idiPg3Djz5e3XUkRY3+ALXFNHGRRDrxH8ZAho/mjuCDH+s3sdxt+WdkesxwfumSSfBO4uWcEux9viI=
X-Received: by 2002:a2e:87d9:: with SMTP id v25mr9401972ljj.171.1599447462423; 
 Sun, 06 Sep 2020 19:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200905063813.1875-1-luoyonggang@gmail.com>
In-Reply-To: <20200905063813.1875-1-luoyonggang@gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 7 Sep 2020 10:57:31 +0800
Message-ID: <CAE2XoE-pwp_wC0t+utEqKX65jBKjxMDOzydgJmge1__ojn1Yrw@mail.gmail.com>
Subject: Re: [PATCH] tests: fixes test-vmstate.c compile error on msys2
To: qemu-level <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d5b05705aeb061e2"
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x244.google.com
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
Reply-To: luoyonggang@gmail.com
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d5b05705aeb061e2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Bonzini, you need have a look at this

On Sat, Sep 5, 2020 at 2:38 PM Yonggang Luo <luoyonggang@gmail.com> wrote:

> ../tests/test-vmstate.c: In function 'int_cmp':
> ../tests/test-vmstate.c:884:5: error: unknown type name 'uint'; did you
> mean 'uInt'?
>   884 |     uint ua =3D GPOINTER_TO_UINT(a);
>       |     ^~~~
>       |     uInt
> ../tests/test-vmstate.c:885:5: error: unknown type name 'uint'; did you
> mean 'uInt'?
>   885 |     uint ub =3D GPOINTER_TO_UINT(b);
>       |     ^~~~
>       |     uInt
> make: ***
> [Makefile.ninja:5461=EF=BC=9Atests/test-vmstate.exe.p/test-vmstate.c.obj]=
 =E9=94=99=E8=AF=AF 1
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  tests/test-vmstate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
> index f7b3868881..f8de709a0b 100644
> --- a/tests/test-vmstate.c
> +++ b/tests/test-vmstate.c
> @@ -881,8 +881,8 @@ static gint interval_cmp(gconstpointer a,
> gconstpointer b, gpointer user_data)
>  /* ID comparison function */
>  static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data=
)
>  {
> -    uint ua =3D GPOINTER_TO_UINT(a);
> -    uint ub =3D GPOINTER_TO_UINT(b);
> +    guint ua =3D GPOINTER_TO_UINT(a);
> +    guint ub =3D GPOINTER_TO_UINT(b);
>      return (ua > ub) - (ua < ub);
>  }
>
> --
> 2.28.0.windows.1
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000d5b05705aeb061e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Bonzini, you need have a look at this<br></div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Sep =
5, 2020 at 2:38 PM Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com=
">luoyonggang@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">../tests/test-vmstate.c: In function &#39;int_cmp&#3=
9;:<br>
../tests/test-vmstate.c:884:5: error: unknown type name &#39;uint&#39;; did=
 you mean &#39;uInt&#39;?<br>
=C2=A0 884 |=C2=A0 =C2=A0 =C2=A0uint ua =3D GPOINTER_TO_UINT(a);<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0^~~~<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0uInt<br>
../tests/test-vmstate.c:885:5: error: unknown type name &#39;uint&#39;; did=
 you mean &#39;uInt&#39;?<br>
=C2=A0 885 |=C2=A0 =C2=A0 =C2=A0uint ub =3D GPOINTER_TO_UINT(b);<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0^~~~<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0uInt<br>
make: *** [Makefile.ninja:5461=EF=BC=9Atests/test-vmstate.exe.p/test-vmstat=
e.c.obj] =E9=94=99=E8=AF=AF 1<br>
<br>
Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com" ta=
rget=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
---<br>
=C2=A0tests/test-vmstate.c | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c<br>
index f7b3868881..f8de709a0b 100644<br>
--- a/tests/test-vmstate.c<br>
+++ b/tests/test-vmstate.c<br>
@@ -881,8 +881,8 @@ static gint interval_cmp(gconstpointer a, gconstpointer=
 b, gpointer user_data)<br>
=C2=A0/* ID comparison function */<br>
=C2=A0static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_d=
ata)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 uint ua =3D GPOINTER_TO_UINT(a);<br>
-=C2=A0 =C2=A0 uint ub =3D GPOINTER_TO_UINT(b);<br>
+=C2=A0 =C2=A0 guint ua =3D GPOINTER_TO_UINT(a);<br>
+=C2=A0 =C2=A0 guint ub =3D GPOINTER_TO_UINT(b);<br>
=C2=A0 =C2=A0 =C2=A0return (ua &gt; ub) - (ua &lt; ub);<br>
=C2=A0}<br>
<br>
-- <br>
2.28.0.windows.1<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000d5b05705aeb061e2--

