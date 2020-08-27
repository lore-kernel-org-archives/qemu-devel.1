Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2334BC433E6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 21:33:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1FB020737
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 21:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHVd77wn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FB020737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBPWY-0000yd-Ji
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 17:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kBPVs-0000Z8-L3
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 17:32:52 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:42659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kBPVr-0008Ua-0i
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 17:32:52 -0400
Received: by mail-ej1-x644.google.com with SMTP id j25so9614500ejk.9
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 14:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5sn5n4Z2VqNAyPaNwQyuXLKJmWBAKQSswIhjHZe6dq8=;
 b=eHVd77wnwJRqeCAVSP6hU1fYz1g0mAkZY3bFfBvvU0siR4x3trrIg5gqF5FxP9UBhY
 C7yZ5FzQ9T4Ys/55jQL1OiyhL+k1ZblwmX03990aJ+QsFWPClMpQT8rYq07QlJBJZtLp
 Zd2059V0afKNjRLwrYcsd9XemPcP6gcE9nMDRBgchNrMINg0whhzqB4+mV/WoQ/HmOKj
 Yg5E0LYxKdxPFuR1G2rh7PU1UM1hcc52lIli6Ib+4G70sTY5OB/7oj033S377lME9XDX
 fmHbai33u15xTscHuFKxqV0x0HJZqZv+ihLwFovQl2oV5Z3/JCcmyYccfXvjUwAgMPSK
 RizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5sn5n4Z2VqNAyPaNwQyuXLKJmWBAKQSswIhjHZe6dq8=;
 b=GATUgceKNjF7wUVtyx+LUr7h+k+Xz/PKVoJKrVSiDjfbGwnOJlCKGHEHjzGYbU3mOh
 CnXGCaqkQV3hKIZ4FxwobEM/4vG31r+XFtodrIQZRjBkgoYb6z1CJSw7S07hnGwBSONJ
 IZ7Zj15ljKXpIPthrGca0ptAGA2d73DA7GQ8eIoQEjL2u7Pq/avo7o3KQ3MrWc1IpQgN
 tF0D4vlkagT/99gECN2HGwrzMLVG0yMrehJftST1g9GNmcE8TjofkHhXqfy+8gpBhJMP
 hmZXThxURIpd2kS2T6ue/nBxgZJFPbGoCCEOr9VCJ9tUQlggQ/+ExXkdhQFWduPJv21q
 uPQA==
X-Gm-Message-State: AOAM531dBW+YyDELSE4iyrhAOt4uHtDdMJYnRoixwScpwhACk70kW6ZK
 EXqfC1FAb9rr9cuuyDtDv7PI66CyU1Z00eHu6v8=
X-Google-Smtp-Source: ABdhPJwNc9avl4EBcSQVKrp3RDT75MSfhqTbvVD9slnXAEA4CKpj0YVXJjlmQEYoKX6hDLefV1QOAHQLUxzZjrONKyY=
X-Received: by 2002:a17:906:3816:: with SMTP id
 v22mr22701917ejc.105.1598563969518; 
 Thu, 27 Aug 2020 14:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200827210920.111611-1-sw@weilnetz.de>
In-Reply-To: <20200827210920.111611-1-sw@weilnetz.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 28 Aug 2020 01:32:37 +0400
Message-ID: <CAJ+F1CLofuUcFkuwgc_-c4i1QW_k4SEoAQPiZxJmTMtYNdTyYg@mail.gmail.com>
Subject: Re: [PATCH] libvhost-user: Add GCC_FMT_ATTR and fix format string
To: Stefan Weil <sw@weilnetz.de>
Content-Type: multipart/alternative; boundary="0000000000008dd09605ade2ad5a"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x644.google.com
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
Cc: QEMU <qemu-devel@nongnu.org>, Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008dd09605ade2ad5a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2020 at 1:10 AM Stefan Weil <sw@weilnetz.de> wrote:

> Signed-off-by: Stefan Weil <sw@weilnetz.de>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  contrib/libvhost-user/libvhost-user.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c
> b/contrib/libvhost-user/libvhost-user.c
> index 53f16bdf08..ff7ac876f4 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -151,7 +151,7 @@ vu_request_to_string(unsigned int req)
>      }
>  }
>
> -static void
> +static void GCC_FMT_ATTR(2, 3)
>  vu_panic(VuDev *dev, const char *msg, ...)
>  {
>      char *buf =3D NULL;
> @@ -643,7 +643,7 @@ generate_faults(VuDev *dev) {
>
>          if (ioctl(dev->postcopy_ufd, UFFDIO_REGISTER, &reg_struct)) {
>              vu_panic(dev, "%s: Failed to userfault region %d "
> -                          "@%p + size:%zx offset: %zx: (ufd=3D%d)%s\n",
> +                          "@%016"PRIx64" + size:%zx offset: %zx:
> (ufd=3D%d)%s\n",
>                       __func__, i,
>                       dev_region->mmap_addr,
>                       dev_region->size, dev_region->mmap_offset,
> --
> 2.28.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000008dd09605ade2ad5a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 28, 2020 at 1:10 AM Stefa=
n Weil &lt;<a href=3D"mailto:sw@weilnetz.de">sw@weilnetz.de</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">Signed-off-by: S=
tefan Weil &lt;<a href=3D"mailto:sw@weilnetz.de" target=3D"_blank">sw@weiln=
etz.de</a>&gt;<br>
</blockquote><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a=
 href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a=
>&gt;</div><div> <br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">---<br>
=C2=A0contrib/libvhost-user/libvhost-user.c | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/=
libvhost-user.c<br>
index 53f16bdf08..ff7ac876f4 100644<br>
--- a/contrib/libvhost-user/libvhost-user.c<br>
+++ b/contrib/libvhost-user/libvhost-user.c<br>
@@ -151,7 +151,7 @@ vu_request_to_string(unsigned int req)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static void<br>
+static void GCC_FMT_ATTR(2, 3)<br>
=C2=A0vu_panic(VuDev *dev, const char *msg, ...)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0char *buf =3D NULL;<br>
@@ -643,7 +643,7 @@ generate_faults(VuDev *dev) {<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ioctl(dev-&gt;postcopy_ufd, UFFDIO_RE=
GISTER, &amp;reg_struct)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vu_panic(dev, &quot;%s: Fai=
led to userfault region %d &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;@%p + size:%zx offset: %zx: (ufd=3D%d)%s\n&quot;,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;@%016&quot;PRIx64&quot; + size:%zx offset: %zx: (uf=
d=3D%d)%s\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __func__, i,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dev_region-&gt;mmap_addr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dev_region-&gt;size, dev_region-&gt;mmap_offset,<br>
-- <br>
2.28.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000008dd09605ade2ad5a--

