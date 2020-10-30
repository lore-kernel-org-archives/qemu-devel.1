Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49444C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFBFA20739
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkLAaFky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFBFA20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYXf4-0002Y1-ND
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 12:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYXcf-0008Ik-5T
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 12:51:29 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:40958)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYXcb-00043v-KN
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 12:51:28 -0400
Received: by mail-ed1-x543.google.com with SMTP id p93so7341455edd.7
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 09:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bvBUc5ZVtCSuDMnmWuN/hlGlwKM0LVOPkqt2ds/p0cw=;
 b=EkLAaFkyqNAF5oexhzaKfDbCK/+wbxYHwZ9Y51YbfFB+7NcqNTAQxD5V0WS/7rOILD
 1Y/DQVx5/Hd1VqZB86SvEeEVbZ0bQGAO2+KRcLvBV9PLDn+D0Tn08r2r4S5DCE2khLZg
 KcQLJW6bfLRegOS06qV5aL0snTq2lpPz9LxY3Wam/7sWjieWfBqN7agUaAtV71NbjIYA
 LWZXnIUFr10dZgT97dXYwFSDglz4phlVCCXxRDYItQCAX+gAH//sEGVdbIBOiF9CQ9D/
 fSs5htwA4xEqIUDd6dU4iAGfnZVtEuSUk5oEhEkNv3e6lvFX9mp/EF+xlqD+L+UrSLVx
 Z5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bvBUc5ZVtCSuDMnmWuN/hlGlwKM0LVOPkqt2ds/p0cw=;
 b=DgfPNnxBE6YQ7VQJrxsRkqsxn2uQbY6t5tE3aWGM/xtbM8cdyeCzeA6SZ9KeNlmHRY
 kXulLjB+KS7O9EKqub23WDkWoRaadCG3z/dGqtmRqIyr+LsDMV3WzcjXZEhXPp8xkuyw
 zGDdM/0T9ypGQks/oNS0ORCTFSLGWTm/tb/53kCcIBQ/Hp9uPvC56Ki/p+A2ljOU9rZf
 SXetYRYB3fArR3gl+e2j8qvi3G1063SVE3kQ21aQU0f8BSLVrkt4Mmgf2CIqWuPlPWzS
 Bqp1+2keUCKglVNEVKzZFFKuTLCmtRB6V+pecMVZUO7x7e9sfj5n7w2D5TVy0KXnJ61E
 FVeQ==
X-Gm-Message-State: AOAM530MS2b1LKYXgs2aHCZwCycVauiDjbOjashjMcxQrCp5uduc6Rcl
 EabFqaCXK9lG/c2fOuwoWyibdWdeeIdZkT/YwH6wCrw1YUdMFw==
X-Google-Smtp-Source: ABdhPJz0Z1hCn12omkLQK5zqiy3j8f0XY0TEtcBhYdlVoOcL6qrNS2zB57iDqMyrjeaWw7aU/qLfbx+ynkJ7aUbjWIA=
X-Received: by 2002:a05:6402:195:: with SMTP id
 r21mr3365094edv.164.1604076684096; 
 Fri, 30 Oct 2020 09:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-24-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-24-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 20:51:12 +0400
Message-ID: <CAJ+F1CKMMG5Ekwpzex65a1xJtruOqRhgYPG1A7MJOrtcV6BDaw@mail.gmail.com>
Subject: Re: [PATCH 23/36] qdev: Make qdev_propinfo_get_uint16() static
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f2bb6205b2e63465"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x543.google.com
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f2bb6205b2e63465
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:20 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> There are no users of the function outside qdev-properties.c.
> Make function static and rename it to get_uint16().
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  hw/core/qdev-prop-internal.h | 2 --
>  hw/core/qdev-properties.c    | 6 +++---
>  2 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/hw/core/qdev-prop-internal.h b/hw/core/qdev-prop-internal.h
> index 49bf557fd5..c8006a21c7 100644
> --- a/hw/core/qdev-prop-internal.h
> +++ b/hw/core/qdev-prop-internal.h
> @@ -20,8 +20,6 @@ void qdev_propinfo_set_default_value_int(ObjectProperty
> *op,
>  void qdev_propinfo_set_default_value_uint(ObjectProperty *op,
>                                            const Property *prop);
>
> -void qdev_propinfo_get_uint16(Object *obj, Visitor *v, const char *name,
> -                              void *opaque, Error **errp);
>  void qdev_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
>                               void *opaque, Error **errp);
>  void qdev_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 4cb8baa6a0..5189626c09 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -296,8 +296,8 @@ const PropertyInfo qdev_prop_uint8 =3D {
>
>  /* --- 16bit integer --- */
>
> -void qdev_propinfo_get_uint16(Object *obj, Visitor *v, const char *name,
> -                              void *opaque, Error **errp)
> +static void get_uint16(Object *obj, Visitor *v, const char *name,
> +                       void *opaque, Error **errp)
>  {
>      Property *prop =3D opaque;
>      uint16_t *ptr =3D qdev_get_prop_ptr(obj, prop);
> @@ -316,7 +316,7 @@ static void set_uint16(Object *obj, Visitor *v, const
> char *name,
>
>  const PropertyInfo qdev_prop_uint16 =3D {
>      .name  =3D "uint16",
> -    .get   =3D qdev_propinfo_get_uint16,
> +    .get   =3D get_uint16,
>      .set   =3D set_uint16,
>      .set_default_value =3D qdev_propinfo_set_default_value_uint,
>  };
> --
> 2.28.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000f2bb6205b2e63465
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:20 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Th=
ere are no users of the function outside qdev-properties.c.<br>
Make function static and rename it to get_uint16().<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br></blockquote><div><br></div=
><div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcan=
dre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt=
;</div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_bla=
nk">pbonzini@redhat.com</a>&gt;<br>
Cc: &quot;Daniel P. Berrang=C3=A9&quot; &lt;<a href=3D"mailto:berrange@redh=
at.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
Cc: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" target=3D"_b=
lank">ehabkost@redhat.com</a>&gt;<br>
Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@n=
ongnu.org</a><br>
---<br>
=C2=A0hw/core/qdev-prop-internal.h | 2 --<br>
=C2=A0hw/core/qdev-properties.c=C2=A0 =C2=A0 | 6 +++---<br>
=C2=A02 files changed, 3 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/hw/core/qdev-prop-internal.h b/hw/core/qdev-prop-internal.h<br=
>
index 49bf557fd5..c8006a21c7 100644<br>
--- a/hw/core/qdev-prop-internal.h<br>
+++ b/hw/core/qdev-prop-internal.h<br>
@@ -20,8 +20,6 @@ void qdev_propinfo_set_default_value_int(ObjectProperty *=
op,<br>
=C2=A0void qdev_propinfo_set_default_value_uint(ObjectProperty *op,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0const Property *prop);<br>
<br>
-void qdev_propinfo_get_uint16(Object *obj, Visitor *v, const char *name,<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *opaque, Error **errp);<br>
=C2=A0void qdev_propinfo_get_int32(Object *obj, Visitor *v, const char *nam=
e,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *opaque, Error **errp);<br>
=C2=A0void qdev_propinfo_get_size32(Object *obj, Visitor *v, const char *na=
me,<br>
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c<br>
index 4cb8baa6a0..5189626c09 100644<br>
--- a/hw/core/qdev-properties.c<br>
+++ b/hw/core/qdev-properties.c<br>
@@ -296,8 +296,8 @@ const PropertyInfo qdev_prop_uint8 =3D {<br>
<br>
=C2=A0/* --- 16bit integer --- */<br>
<br>
-void qdev_propinfo_get_uint16(Object *obj, Visitor *v, const char *name,<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *opaque, Error **errp)<br>
+static void get_uint16(Object *obj, Visitor *v, const char *name,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0void *opaque, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0Property *prop =3D opaque;<br>
=C2=A0 =C2=A0 =C2=A0uint16_t *ptr =3D qdev_get_prop_ptr(obj, prop);<br>
@@ -316,7 +316,7 @@ static void set_uint16(Object *obj, Visitor *v, const c=
har *name,<br>
<br>
=C2=A0const PropertyInfo qdev_prop_uint16 =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D &quot;uint16&quot;,<br>
-=C2=A0 =C2=A0 .get=C2=A0 =C2=A0=3D qdev_propinfo_get_uint16,<br>
+=C2=A0 =C2=A0 .get=C2=A0 =C2=A0=3D get_uint16,<br>
=C2=A0 =C2=A0 =C2=A0.set=C2=A0 =C2=A0=3D set_uint16,<br>
=C2=A0 =C2=A0 =C2=A0.set_default_value =3D qdev_propinfo_set_default_value_=
uint,<br>
=C2=A0};<br>
-- <br>
2.28.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000f2bb6205b2e63465--

