Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573A8C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 22:08:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 208A520825
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 22:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6tLRo5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208A520825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyMuo-0006bP-Di
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 18:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jyMtq-0005rv-75
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 18:07:43 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:44151)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jyMtn-0002KL-D4
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 18:07:41 -0400
Received: by mail-ej1-x643.google.com with SMTP id ga4so4047986ejb.11
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 15:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qBrXZJ6/gSeaK6MVNPVJEo7XJFc4H+UjC81cMPddkBg=;
 b=j6tLRo5o6cPNI7oO9RFQeumTbnheyKeXhsnXtt1xL2XZwm8+NUQIiXR7a60zU1F405
 +UKpe+R6LK+WnlcIhjXcUEP3TuHhIzjXz+luV+vRFvdpM+r63adBTfy1VHZuLV4b6xsC
 jn2XgW0TbjUmWapXIEBd05ImRhDoh08UDfa/BvrryYx/hmNe5wD0uG8qepJsEwmsGOe0
 l3vYqUWzVAlwDqcML9OSIjo8hVS6znBQYJ/HQqAtGKLQtSArOjKPokubIcNg/3T7OGr+
 kCpXZ/AwLEstwteYSegzFdGVI8BuV+pvUQVye4PFS6HDYc4no/NG9/gE0af+rhFqYmsu
 flNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qBrXZJ6/gSeaK6MVNPVJEo7XJFc4H+UjC81cMPddkBg=;
 b=PUMawA3ACM/BAbxTBah55w9I77AxVlMiThgt7XChHO6McN+Wsxzf8VzdpTylnkIUt5
 HCy/76de2g357Z44WOIExcLnymzwv3ivaRyq++unRIZd4Hac2oj7ezUFvkQhEox11/f5
 slpoLiZycj/8rnWBe3PFakN+Pmkxxb4OVdrhZmy7Jb2nM2t7/SXUplSycbKHn15c7F5r
 o/8mUQvsPw9qivY9LShCycERaJ7yfCxtTHv567wimUheSS6CmDiNkGcuGE/PFcO2Ezgt
 8SOHC8GLEJZISVIicPisO1CNvHLaI4hdeeuZCPjqx4t8hzv69r49G0pMMGfqjBqfl1fx
 JRYA==
X-Gm-Message-State: AOAM530n2IrYPPAAN+CzkpIAOCISrOq+u/jooQ6v8PMoiClFhhSR13wA
 pxeaSsZ/vaTtAhaL7+R0PGsRtl1wdoo7d+VNEpJ+O0IugDU=
X-Google-Smtp-Source: ABdhPJy1jfuSxYgXdt6y8Eo0QEtjBRYDZx5eDY9Have+3HbjVib2aoJtiOmDphgMnOIZTRo4zT1GIg15YBKWDg5zNpg=
X-Received: by 2002:adf:efd2:: with SMTP id i18mr1306408wrp.32.1595455656555; 
 Wed, 22 Jul 2020 15:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200722205316.1405667-1-sw@weilnetz.de>
In-Reply-To: <20200722205316.1405667-1-sw@weilnetz.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 23 Jul 2020 02:07:23 +0400
Message-ID: <CAJ+F1CKij4XVispRJkfrAi1iNHYTnX2d3Yzeov36JqpyqMGGxA@mail.gmail.com>
Subject: Re: [PATCH for-5.1] libvhost-user: Add missing GCC_FMT_ATTR and fix
 format errors
To: Stefan Weil <sw@weilnetz.de>
Content-Type: multipart/alternative; boundary="000000000000a9fb5505ab0ef7ca"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x643.google.com
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
Cc: QEMU <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a9fb5505ab0ef7ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2020 at 12:54 AM Stefan Weil <sw@weilnetz.de> wrote:

> Signed-off-by: Stefan Weil <sw@weilnetz.de>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  contrib/libvhost-user/libvhost-user.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c
> b/contrib/libvhost-user/libvhost-user.c
> index d315db1396..6e659aff37 100644
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
> @@ -2074,7 +2074,7 @@ virtqueue_get_head(VuDev *dev, VuVirtq *vq,
>
>      /* If their number is silly, that's a fatal mistake. */
>      if (*head >=3D vq->vring.num) {
> -        vu_panic(dev, "Guest says index %u is available", head);
> +        vu_panic(dev, "Guest says index %u is available", *head);
>          return false;
>      }
>
> @@ -2133,7 +2133,7 @@ virtqueue_read_next_desc(VuDev *dev, struct
> vring_desc *desc,
>      smp_wmb();
>
>      if (*next >=3D max) {
> -        vu_panic(dev, "Desc next is %u", next);
> +        vu_panic(dev, "Desc next is %u", *next);
>          return VIRTQUEUE_READ_DESC_ERROR;
>      }
>
> --
> 2.27.0
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000a9fb5505ab0ef7ca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 23, 2020 at 12:54 AM Stef=
an Weil &lt;<a href=3D"mailto:sw@weilnetz.de">sw@weilnetz.de</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Signed-off-by: =
Stefan Weil &lt;<a href=3D"mailto:sw@weilnetz.de" target=3D"_blank">sw@weil=
netz.de</a>&gt;<br></blockquote><div><br></div><div>Reviewed-by: Marc-Andr=
=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.=
lureau@redhat.com</a>&gt;</div><div> <br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
---<br>
=C2=A0contrib/libvhost-user/libvhost-user.c | 9 +++++----<br>
=C2=A01 file changed, 5 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/=
libvhost-user.c<br>
index d315db1396..6e659aff37 100644<br>
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
@@ -2074,7 +2074,7 @@ virtqueue_get_head(VuDev *dev, VuVirtq *vq,<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* If their number is silly, that&#39;s a fatal mistake=
. */<br>
=C2=A0 =C2=A0 =C2=A0if (*head &gt;=3D vq-&gt;vring.num) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_panic(dev, &quot;Guest says index %u is ava=
ilable&quot;, head);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_panic(dev, &quot;Guest says index %u is ava=
ilable&quot;, *head);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -2133,7 +2133,7 @@ virtqueue_read_next_desc(VuDev *dev, struct vring_des=
c *desc,<br>
=C2=A0 =C2=A0 =C2=A0smp_wmb();<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (*next &gt;=3D max) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_panic(dev, &quot;Desc next is %u&quot;, nex=
t);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_panic(dev, &quot;Desc next is %u&quot;, *ne=
xt);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return VIRTQUEUE_READ_DESC_ERROR;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-- <br>
2.27.0<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000a9fb5505ab0ef7ca--

