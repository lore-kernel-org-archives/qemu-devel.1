Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA72AC433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 10:34:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95C0220729
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 10:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jo8MI86K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C0220729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyC4i-0004yr-OZ
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 06:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jyC3o-0004Th-OD
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 06:33:17 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:40913)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jyC3j-0000bM-Uz
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 06:33:16 -0400
Received: by mail-lj1-x242.google.com with SMTP id j11so1924221ljo.7
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=Gtv179leUIQJBj92u7fcR0QLBtLLbEp62Q9N6eFkIRI=;
 b=jo8MI86K45/LnALTI2RO9h/7jj3Q9dg5fPgwnf0L9sq1fNPuL14jmJ8zQ3aCzYxCyG
 UuwvDdr+Bd+9CZOiKlY1rd0h+5jnmUMEF/6CgHyC2RJBMcXGEhoxx3mQsVzWTGJlhSkB
 by80+jfHqdRfg0hVNF2YSXF62UyzFeE7u3vO+qbjbwzXYI0qQrahRNhEXV8Yqr0tqZu5
 HwzK0CCGok8+A7FKUNMKv1vkxJdjDbZ2Z1aQjwoynKsEASfpmpzt4t53IWCzo5J0wvvs
 2rEyVCVz2ObQmS1jtbx7AFKwmLoPRKqPmMGdcf3xG23tIA1oHwoknidkQtKKoFJ1bAZk
 Vwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=Gtv179leUIQJBj92u7fcR0QLBtLLbEp62Q9N6eFkIRI=;
 b=FNDQW6g62TyUW1dQL1lUd6pGdypSRV59p654hyyuJZCTbA/fHrM15EuAc2Aq/fbX7W
 csAywAp0nGc32/PMQDUqGPnU0IjocLcXPQmDsYN9POgmT1MS/AvYKJqQwfW1eLMb3+H2
 +JLYsjLz1sPnj87agyPiLFVlC0StJoD3iZ9QyMEG6dcErMyhwYAYhLckkCFieYCNj5kH
 nfWm9W3pNXLavl2PskWJD0lwZ1b3a23wOG95MMneXDvFn+n8rJ1O3LT2P9uO43Jtb7Mv
 Q/TVY0fFKNdc6He2ADtkUXdlmeGbbEeqfzRCSjfcoRb33333qmzrEAwnfxYnXCXN+zje
 Wkrg==
X-Gm-Message-State: AOAM531Ber/1N9kDgyCNsN6Y3wgLdcrXrXFYOln1ArEJvZ6yb1IZBBDo
 dY3BFH2LklbvNPLLQ97EnJnHgJ4jMROvWyGYFIU=
X-Google-Smtp-Source: ABdhPJzQqtl20KPUSQq23R5P092qMlEBoIY4p4mIQ4oa6TXpmgatrA+Uc+hVBbcMkkXO9UZdC4lzEawkXqvF6I6V2RQ=
X-Received: by 2002:a2e:9207:: with SMTP id k7mr14499367ljg.120.1595413989472; 
 Wed, 22 Jul 2020 03:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200722062902.24509-1-alex.bennee@linaro.org>
 <20200722062902.24509-6-alex.bennee@linaro.org>
In-Reply-To: <20200722062902.24509-6-alex.bennee@linaro.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 22 Jul 2020 18:32:59 +0800
Message-ID: <CAE2XoE-OiXaZRBqW1PnWQO1QntGtckQXOYD1Nqycp7V73MJ3RA@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] util/oslib-win32: add qemu_get_host_physmem
 implementation
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000001cbfb305ab05441e"
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x242.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, Stefan Weil <sw@weilnetz.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, cota@braap.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001cbfb305ab05441e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I would suggest use loadLibrary to retrieve the function, if not available,
then return 0 (For Win Xp and Vista);

On Wed, Jul 22, 2020 at 2:34 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

> It seems GetPhysicallyInstalledSystemMemory isn't available in the
> MinGW headers so we have to declare it ourselves. Compile tested only.
>
> Cc: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  util/oslib-win32.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index 31030463cc9..f0f94833197 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -43,6 +43,8 @@
>  /* this must come after including "trace.h" */
>  #include <shlobj.h>
>
> +WINBASEAPI BOOL WINAPI GetPhysicallyInstalledSystemMemory (PULONGLONG);
> +
>  void *qemu_oom_check(void *ptr)
>  {
>      if (ptr =3D=3D NULL) {
> @@ -831,6 +833,15 @@ char *qemu_get_host_name(Error **errp)
>
>  size_t qemu_get_host_physmem(void)
>  {
> -    /* currently unimplemented */
> -    return 0;
> +    ULONGLONG mem;
> +
> +    if (GetPhysicallyInstalledSystemMemory(&mem)) {
> +        if (mem > SIZE_MAX) {
> +            return SIZE_MAX;
> +        } else {
> +            return mem;
> +        }
> +    } else {
> +        return 0;
> +    }
>  }
> --
> 2.20.1
>
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000001cbfb305ab05441e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I would suggest use loadLibrary to retrieve the function, =
if not available, then return 0 (For Win Xp and Vista);</div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 22, 2020=
 at 2:34 PM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">=
alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">It seems GetPhysicallyInstalledSystemMemory isn&#39;t=
 available in the<br>
MinGW headers so we have to declare it ourselves. Compile tested only.<br>
<br>
Cc: Stefan Weil &lt;<a href=3D"mailto:sw@weilnetz.de" target=3D"_blank">sw@=
weilnetz.de</a>&gt;<br>
Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
---<br>
=C2=A0util/oslib-win32.c | 15 +++++++++++++--<br>
=C2=A01 file changed, 13 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/util/oslib-win32.c b/util/oslib-win32.c<br>
index 31030463cc9..f0f94833197 100644<br>
--- a/util/oslib-win32.c<br>
+++ b/util/oslib-win32.c<br>
@@ -43,6 +43,8 @@<br>
=C2=A0/* this must come after including &quot;trace.h&quot; */<br>
=C2=A0#include &lt;shlobj.h&gt;<br>
<br>
+WINBASEAPI BOOL WINAPI GetPhysicallyInstalledSystemMemory (PULONGLONG);<br=
>
+<br>
=C2=A0void *qemu_oom_check(void *ptr)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (ptr =3D=3D NULL) {<br>
@@ -831,6 +833,15 @@ char *qemu_get_host_name(Error **errp)<br>
<br>
=C2=A0size_t qemu_get_host_physmem(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 /* currently unimplemented */<br>
-=C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 ULONGLONG mem;<br>
+<br>
+=C2=A0 =C2=A0 if (GetPhysicallyInstalledSystemMemory(&amp;mem)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mem &gt; SIZE_MAX) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return SIZE_MAX;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return mem;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
-- <br>
2.20.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div>

--0000000000001cbfb305ab05441e--

