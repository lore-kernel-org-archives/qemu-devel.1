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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31749C4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:54:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8754A20739
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWdATzh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8754A20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYXf6-0002bv-VX
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 12:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYXdh-00015h-UO
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 12:52:33 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:35913)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYXdf-0004B6-Ss
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 12:52:33 -0400
Received: by mail-ed1-x543.google.com with SMTP id l16so7387751eds.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 09:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=snLyrTi0KcGI0oYmFVxIYzhn8QFqcJ4c8yQzlRr1JA0=;
 b=eWdATzh+9l81vSjCbpd0LSYjb3xyVm3AC0cfBGZMOjBCOHFWjcgV95Nrpse4ZrB6dj
 XqujWvLkiIXPEYgyfQ2Kry0fBvPvX3o12kFXkiPlRPxvV2d3Ao/NQmF+Hoqos81eZGUH
 Ab8oPSejeVRtv4ULk+odi9Agk3zOBoyNjcVHJbkrX8H2bbgEJoqa77QHGLh+3D2PCfJF
 M/jTNujhttYp2pTgLVGh/unZOd19NlnbRgv8wpNTTWSR/WzdQj9/n6yLEMC748s16JaI
 viKms+ZekmphSxVvVe53BOVHnBZbKtd4U1nwtycKz/i6NZCDo6v42Vy+WfnK4/EnnkT7
 vBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=snLyrTi0KcGI0oYmFVxIYzhn8QFqcJ4c8yQzlRr1JA0=;
 b=isUbsGLASGyLTtjfq++HHK/JHgp0hiwDLIL8gB1ZjPga+3OqtxusalHTGUK2dPseV1
 P6C556IgcQiy21y8P4hUHKlfV9xS7CYoNrwHIwMWj5KR3n02JXXzO/9LPmHQlx8PKZuo
 DJd6mwuAKG3j/BlgHIn4wgsn9sXBUGVme55xazMCQ9VB5u7GtMQzJBZSyaq5LhhP+EKT
 Pq+x7GmWTXcN3L0j04ynfSMgUBSOXxdlxzs4g2+JyPWGFKFwhTlXspeov+wJbWsXvMXd
 MtYeBdpHpdJU5p8f9wInf6uBs2UHjUHL0ITlmw+YvdS+X6elUeu1U8aF7pgh8vKW0qO4
 UCzg==
X-Gm-Message-State: AOAM532YV3GWl0iH+uIgRouBzhQK/+8lnhAkGA+TOImcm3OnUtnoFvv5
 2uKiYQu9CesHbTkIYUbgquLpmOqsf1zPDxL/2F3VbAxxBUlyaA==
X-Google-Smtp-Source: ABdhPJyQfb9btQLMj+B7/MpT/xNcAZd6YDpklqFkjxGwiU7Qhzrwj+IXmEk9oGoMketxXldzdcR1ihCZCJXorCvoKa8=
X-Received: by 2002:a05:6402:1615:: with SMTP id
 f21mr3571395edv.257.1604076750680; 
 Fri, 30 Oct 2020 09:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-16-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-16-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 20:52:18 +0400
Message-ID: <CAJ+F1C+AX0o254HN7nDmgbyk6VRHGxbYv1nKzndt9ZG2RhA2GQ@mail.gmail.com>
Subject: Re: [PATCH 15/36] qdev: Make PropertyInfo.create return
 ObjectProperty*
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000eab53f05b2e63857"
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

--000000000000eab53f05b2e63857
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:14 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  include/hw/qdev-properties.h |  2 +-
>  hw/core/qdev-properties.c    | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 530286e869..7f8e4daade 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -34,7 +34,7 @@ struct PropertyInfo {
>      const QEnumLookup *enum_table;
>      int (*print)(Object *obj, Property *prop, char *dest, size_t len);
>      void (*set_default_value)(ObjectProperty *op, const Property *prop);
> -    void (*create)(ObjectClass *oc, Property *prop);
> +    ObjectProperty *(*create)(ObjectClass *oc, Property *prop);
>      ObjectPropertyAccessor *get;
>      ObjectPropertyAccessor *set;
>      ObjectPropertyRelease *release;
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 195bfed6e1..89e292dc25 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -872,12 +872,12 @@ const PropertyInfo qdev_prop_size =3D {
>
>  /* --- object link property --- */
>
> -static void create_link_property(ObjectClass *oc, Property *prop)
> +static ObjectProperty *create_link_property(ObjectClass *oc, Property
> *prop)
>  {
> -    object_class_property_add_link(oc, prop->name, prop->link_type,
> -                                   prop->offset,
> -
>  qdev_prop_allow_set_link_before_realize,
> -                                   OBJ_PROP_LINK_STRONG);
> +    return object_class_property_add_link(oc, prop->name, prop->link_typ=
e,
> +                                          prop->offset,
> +
> qdev_prop_allow_set_link_before_realize,
> +                                          OBJ_PROP_LINK_STRONG);
>  }
>
>  const PropertyInfo qdev_prop_link =3D {
> --
> 2.28.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000eab53f05b2e63857
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:14 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Si=
gned-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" tar=
get=3D"_blank">ehabkost@redhat.com</a>&gt;<br></blockquote><div><br></div><=
div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandr=
e.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<=
/div><div><br></div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
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
=C2=A0include/hw/qdev-properties.h |=C2=A0 2 +-<br>
=C2=A0hw/core/qdev-properties.c=C2=A0 =C2=A0 | 10 +++++-----<br>
=C2=A02 files changed, 6 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h<br=
>
index 530286e869..7f8e4daade 100644<br>
--- a/include/hw/qdev-properties.h<br>
+++ b/include/hw/qdev-properties.h<br>
@@ -34,7 +34,7 @@ struct PropertyInfo {<br>
=C2=A0 =C2=A0 =C2=A0const QEnumLookup *enum_table;<br>
=C2=A0 =C2=A0 =C2=A0int (*print)(Object *obj, Property *prop, char *dest, s=
ize_t len);<br>
=C2=A0 =C2=A0 =C2=A0void (*set_default_value)(ObjectProperty *op, const Pro=
perty *prop);<br>
-=C2=A0 =C2=A0 void (*create)(ObjectClass *oc, Property *prop);<br>
+=C2=A0 =C2=A0 ObjectProperty *(*create)(ObjectClass *oc, Property *prop);<=
br>
=C2=A0 =C2=A0 =C2=A0ObjectPropertyAccessor *get;<br>
=C2=A0 =C2=A0 =C2=A0ObjectPropertyAccessor *set;<br>
=C2=A0 =C2=A0 =C2=A0ObjectPropertyRelease *release;<br>
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c<br>
index 195bfed6e1..89e292dc25 100644<br>
--- a/hw/core/qdev-properties.c<br>
+++ b/hw/core/qdev-properties.c<br>
@@ -872,12 +872,12 @@ const PropertyInfo qdev_prop_size =3D {<br>
<br>
=C2=A0/* --- object link property --- */<br>
<br>
-static void create_link_property(ObjectClass *oc, Property *prop)<br>
+static ObjectProperty *create_link_property(ObjectClass *oc, Property *pro=
p)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 object_class_property_add_link(oc, prop-&gt;name, prop-&gt;l=
ink_type,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prop-&gt;offset,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_prop_allow_set_lin=
k_before_realize,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OBJ_PROP_LINK_STRONG);<=
br>
+=C2=A0 =C2=A0 return object_class_property_add_link(oc, prop-&gt;name, pro=
p-&gt;link_type,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p=
rop-&gt;offset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q=
dev_prop_allow_set_link_before_realize,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 O=
BJ_PROP_LINK_STRONG);<br>
=C2=A0}<br>
<br>
=C2=A0const PropertyInfo qdev_prop_link =3D {<br>
-- <br>
2.28.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000eab53f05b2e63857--

