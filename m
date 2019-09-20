Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8F8C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 07:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 008902086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 07:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvsCkBdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008902086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBDMX-0002ol-Rw
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 03:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56650)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iBDLB-0001Q4-Dh
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 03:28:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iBDLA-0004g5-8c
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 03:28:29 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40078)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1iBDLA-0004fa-4q
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 03:28:28 -0400
Received: by mail-ot1-x344.google.com with SMTP id y39so5401720ota.7
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 00:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=m377ffvK9KHmDA9wc2++HWfB+bvf9bqknaeqmD7tmcE=;
 b=ZvsCkBdq3PxHTxWaqc+yMKkf8QRvB8X8ZynZHSoSG3k9FBI1pygDs1DBMqdVJeZ5sC
 35kRU/llnQYYQEMJZ4VGsnF/wWTK1qTteq1bg5n78gCZBJ7hLIXez6HXrASeLdvB8Xhg
 MYJZmmMF9YKMUEVbYqQgoFSP5XirPxV4bae4l8XHYtWijpp792VVgafZVRqoxoDkIb4Z
 N6HBlHqnMzFVKHnxCUzbsKmLIfojmSX5x2IBanAFKf2vYYS3cQXTsHgBAbDSvtyKlstw
 V3SleKjEvLi87aSOQ8WldfMmvdDUtfhHP7OeFNvYDnvkgTY+hKonh77m+GyZsgRplK+u
 u3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=m377ffvK9KHmDA9wc2++HWfB+bvf9bqknaeqmD7tmcE=;
 b=cwm8EhfuhD/3pJGR8vUs0smaaSY7K7DkWRGnkgycVNw4RbbEzPKbcVQRqiFNV+Rf8D
 tMhOtFISKCtuVAHet3zjyTO1/9vIb7a1fZ7nl/9Kjv6xfXXFRb0fS0H5CyfPuQ9Nt4Pa
 zDOKi9E71YtLEX7QtcTi8PNPXLXjJ3L4fVCf82zBX/vJ0d+ggBO1wRiKTr7BGM0Uqspp
 HjqDsW8mVM9hT8c0iqnWJQgWbj2QuqxBBKJHwXioDUkl93L4Jqxd3mBx8CkDK3vfIMfb
 tR25R17K4pYaWT3USsoP5WUfWvupRSxQGaYfbqqpsccV4f95I57WgvU3QMfPBkTnlxCI
 hisg==
X-Gm-Message-State: APjAAAXkAxyS/Jb/zmaR3734HFAeASAEVb/7qsy8EZ5vK46DVcsWuKHi
 mWGIgCQ3MwACxx/ygGK8kTI2VfLLZ4UoB2orTZ8=
X-Google-Smtp-Source: APXvYqzCf4enhEYZLqGACzJi9pD3KudqZkqI1iwx1vVAGYeKPDI7kVyrZB8OS7Uf8rYGrflrHLpaj+cXmAAuVoqwTy8=
X-Received: by 2002:a9d:2902:: with SMTP id d2mr10087591otb.333.1568964507068; 
 Fri, 20 Sep 2019 00:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <7f5dd2ac9f3504e2699f23e69bc3d8051b729832.1568925097.git.crobinso@redhat.com>
In-Reply-To: <7f5dd2ac9f3504e2699f23e69bc3d8051b729832.1568925097.git.crobinso@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 20 Sep 2019 15:27:50 +0800
Message-ID: <CAKXe6SKL9Mhqzq2FsQjkmF3N5ENyvBFv-janxsNO72B8qK8+iQ@mail.gmail.com>
Subject: Re: [PATCH] vhost-user-gpu: Drop trailing json comma
To: Cole Robinson <crobinso@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001bee250592f70488"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001bee250592f70488
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Cole Robinson <crobinso@redhat.com> =E4=BA=8E2019=E5=B9=B49=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=884:34=E5=86=99=E9=81=93=EF=BC=9A

> Trailing comma is not valid json:
>
> $ cat contrib/vhost-user-gpu/50-qemu-gpu.json.in | jq
> parse error: Expected another key-value pair at line 5, column 1
>
> Signed-off-by: Cole Robinson <crobinso@redhat.com>
>


Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  contrib/vhost-user-gpu/50-qemu-gpu.json.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/vhost-user-gpu/50-qemu-gpu.json.in
> b/contrib/vhost-user-gpu/50-qemu-gpu.json.in
> index 658b545864..f5edd097f8 100644
> --- a/contrib/vhost-user-gpu/50-qemu-gpu.json.in
> +++ b/contrib/vhost-user-gpu/50-qemu-gpu.json.in
> @@ -1,5 +1,5 @@
>  {
>    "description": "QEMU vhost-user-gpu",
>    "type": "gpu",
> -  "binary": "@libexecdir@/vhost-user-gpu",
> +  "binary": "@libexecdir@/vhost-user-gpu"
>  }
> --
> 2.23.0
>
>
>

--0000000000001bee250592f70488
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Cole Robinson &lt;<a href=3D"mailto:c=
robinso@redhat.com">crobinso@redhat.com</a>&gt; =E4=BA=8E2019=E5=B9=B49=E6=
=9C=8820=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=884:34=E5=86=99=E9=81=
=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Tra=
iling comma is not valid json:<br>
<br>
$ cat contrib/vhost-user-gpu/<a href=3D"http://50-qemu-gpu.json.in" rel=3D"=
noreferrer" target=3D"_blank">50-qemu-gpu.json.in</a> | jq<br>
parse error: Expected another key-value pair at line 5, column 1<br>
<br>
Signed-off-by: Cole Robinson &lt;<a href=3D"mailto:crobinso@redhat.com" tar=
get=3D"_blank">crobinso@redhat.com</a>&gt;<br></blockquote><div><br></div><=
div><br></div><div>Reviewed-by: Li Qiang &lt;<a href=3D"mailto:liq3ea@gmail=
.com">liq3ea@gmail.com</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
---<br>
=C2=A0contrib/vhost-user-gpu/<a href=3D"http://50-qemu-gpu.json.in" rel=3D"=
noreferrer" target=3D"_blank">50-qemu-gpu.json.in</a> | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/contrib/vhost-user-gpu/<a href=3D"http://50-qemu-gpu.json.in" =
rel=3D"noreferrer" target=3D"_blank">50-qemu-gpu.json.in</a> b/contrib/vhos=
t-user-gpu/<a href=3D"http://50-qemu-gpu.json.in" rel=3D"noreferrer" target=
=3D"_blank">50-qemu-gpu.json.in</a><br>
index 658b545864..f5edd097f8 100644<br>
--- a/contrib/vhost-user-gpu/<a href=3D"http://50-qemu-gpu.json.in" rel=3D"=
noreferrer" target=3D"_blank">50-qemu-gpu.json.in</a><br>
+++ b/contrib/vhost-user-gpu/<a href=3D"http://50-qemu-gpu.json.in" rel=3D"=
noreferrer" target=3D"_blank">50-qemu-gpu.json.in</a><br>
@@ -1,5 +1,5 @@<br>
=C2=A0{<br>
=C2=A0 =C2=A0&quot;description&quot;: &quot;QEMU vhost-user-gpu&quot;,<br>
=C2=A0 =C2=A0&quot;type&quot;: &quot;gpu&quot;,<br>
-=C2=A0 &quot;binary&quot;: &quot;@libexecdir@/vhost-user-gpu&quot;,<br>
+=C2=A0 &quot;binary&quot;: &quot;@libexecdir@/vhost-user-gpu&quot;<br>
=C2=A0}<br>
-- <br>
2.23.0<br>
<br>
<br>
</blockquote></div></div>

--0000000000001bee250592f70488--

