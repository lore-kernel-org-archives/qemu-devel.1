Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E01CC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6545C2087D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBa0ETRx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6545C2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQPuC-0007gj-Da
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 03:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kQPtL-0006uy-Jo
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 02:59:07 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:37261)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kQPtJ-0002Ha-U0
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 02:59:07 -0400
Received: by mail-ej1-x642.google.com with SMTP id e22so6533422ejr.4
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 23:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0EvW5PeP7LBqh7p+ru8kqqwOGDHS0Scl/D01QEKxaqM=;
 b=tBa0ETRxUfaNMRsyt7jIL48P2FYMiaoBuX/MiudkQwiqbOHPzi7mjGrR+y5pyKnX0E
 RpoXxMf/XfQCsd+KMn+UcIuHUGkEyjYCyNjsCIUJGpNPZ5p7q1r94/MSGfonVDYUmJic
 p/X3uwd1JaeSYDIY90jKlGDvS8hZOyg+llYmwYYG/zRX2kbitsor/Hhg27tFkmkA4s/u
 paHkGU017SCTQDxijlAAlSzJRjPC3DCPdMOVVv30J07icIZPa7vwLs+mxMn7A8YSacOm
 EWFouv8MMh/RHgxRyyva/tEFZttqfLcveslllrt0vqyJIv2SqmFbJV/2jo7ZMmbitXsg
 K1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0EvW5PeP7LBqh7p+ru8kqqwOGDHS0Scl/D01QEKxaqM=;
 b=Lfz2laSP7mwMSiQQNhZ5u49IMLu0fKHEgE6voyDn3vYQsscRSV+W/kOTCEBGjuLOyD
 5ZjxGe7yeqqEBjxjGQBXNhvtKXOdKQ9mp+FHTjsySwMzi3gXDrv9K7ABwxJ8fgVUVyru
 SvD0YNFWBZH1BcGirM9OVQOQC+98zGakbX6WDYWeVqdGX7T5cxd+/pG9OEkvN01Efm8F
 H+qR+TJlFy5tmQzXT2rUm2s4OyjpMIEGJk8J96su7GpcqkqY565WA+iw6t7MtN45P0ma
 0WwN5ixLtw/V0zc+Vjf1OG9rlZlEFk0nYJ461aDIynWkyPlwFsWK8aq4EVgOiYXI7lpC
 FHSw==
X-Gm-Message-State: AOAM530WurwCY7gyJBgP3GaM8vBUkKY+bKe5W0nTPMwj6ROjOsDRSoaJ
 Xg6E6uL9pn4hxt0an+63lC35IM11Jq0oj3Z5N8Y=
X-Google-Smtp-Source: ABdhPJyvZzAKfTcp8mpOmguhe4Nphvi4MqWzDjua3OY2acU+CsKtlHyrePGHgijkQ91z72+b7Eg8WFa6soQTaySkpw0=
X-Received: by 2002:a17:906:515:: with SMTP id
 j21mr7111161eja.105.1602140343941; 
 Wed, 07 Oct 2020 23:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200921221045.699690-1-ehabkost@redhat.com>
 <20200921221045.699690-6-ehabkost@redhat.com>
In-Reply-To: <20200921221045.699690-6-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 8 Oct 2020 10:58:51 +0400
Message-ID: <CAJ+F1C+FjGkqFRzehGbTNcGBizsz0+tkit+vjqmKSDvB--YbDw@mail.gmail.com>
Subject: Re: [PATCH 05/24] vhost-user: Register "chardev" as class property
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000014c00405b1235efe"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x642.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000014c00405b1235efe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 2:13 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> Class properties make QOM introspection simpler and easier, as
> they don't require an object to be instantiated.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  backends/vhost-user.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/backends/vhost-user.c b/backends/vhost-user.c
> index 9e6e1985465..858fdeae26c 100644
> --- a/backends/vhost-user.c
> +++ b/backends/vhost-user.c
> @@ -175,9 +175,9 @@ static char *get_chardev(Object *obj, Error **errp)
>      return NULL;
>  }
>
> -static void vhost_user_backend_init(Object *obj)
> +static void vhost_user_backend_class_init(ObjectClass *oc, void *data)
>  {
> -    object_property_add_str(obj, "chardev", get_chardev, set_chardev);
> +    object_class_property_add_str(oc, "chardev", get_chardev,
> set_chardev);
>  }
>
>  static void vhost_user_backend_finalize(Object *obj)
> @@ -195,7 +195,7 @@ static const TypeInfo vhost_user_backend_info =3D {
>      .name =3D TYPE_VHOST_USER_BACKEND,
>      .parent =3D TYPE_OBJECT,
>      .instance_size =3D sizeof(VhostUserBackend),
> -    .instance_init =3D vhost_user_backend_init,
> +    .class_init =3D vhost_user_backend_class_init,
>      .instance_finalize =3D vhost_user_backend_finalize,
>      .class_size =3D sizeof(VhostUserBackendClass),
>  };
> --
> 2.26.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000014c00405b1235efe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 22, 2020 at 2:13 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Cl=
ass properties make QOM introspection simpler and easier, as<br>
they don&#39;t require an object to be instantiated.<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br></blockquote><div><br></div=
><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.l=
ureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div> <br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
Cc: &quot;Michael S. Tsirkin&quot; &lt;<a href=3D"mailto:mst@redhat.com" ta=
rget=3D"_blank">mst@redhat.com</a>&gt;<br>
Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@n=
ongnu.org</a><br>
---<br>
=C2=A0backends/vhost-user.c | 6 +++---<br>
=C2=A01 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/backends/vhost-user.c b/backends/vhost-user.c<br>
index 9e6e1985465..858fdeae26c 100644<br>
--- a/backends/vhost-user.c<br>
+++ b/backends/vhost-user.c<br>
@@ -175,9 +175,9 @@ static char *get_chardev(Object *obj, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0}<br>
<br>
-static void vhost_user_backend_init(Object *obj)<br>
+static void vhost_user_backend_class_init(ObjectClass *oc, void *data)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 object_property_add_str(obj, &quot;chardev&quot;, get_charde=
v, set_chardev);<br>
+=C2=A0 =C2=A0 object_class_property_add_str(oc, &quot;chardev&quot;, get_c=
hardev, set_chardev);<br>
=C2=A0}<br>
<br>
=C2=A0static void vhost_user_backend_finalize(Object *obj)<br>
@@ -195,7 +195,7 @@ static const TypeInfo vhost_user_backend_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name =3D TYPE_VHOST_USER_BACKEND,<br>
=C2=A0 =C2=A0 =C2=A0.parent =3D TYPE_OBJECT,<br>
=C2=A0 =C2=A0 =C2=A0.instance_size =3D sizeof(VhostUserBackend),<br>
-=C2=A0 =C2=A0 .instance_init =3D vhost_user_backend_init,<br>
+=C2=A0 =C2=A0 .class_init =3D vhost_user_backend_class_init,<br>
=C2=A0 =C2=A0 =C2=A0.instance_finalize =3D vhost_user_backend_finalize,<br>
=C2=A0 =C2=A0 =C2=A0.class_size =3D sizeof(VhostUserBackendClass),<br>
=C2=A0};<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000014c00405b1235efe--

