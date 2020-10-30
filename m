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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764F3C5517A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 09:46:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC3CF20756
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 09:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uoXhTt8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3CF20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYQzL-0003DH-Gw
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 05:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYQya-0002fv-68
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 05:45:41 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:36326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYQyV-0002up-Tg
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 05:45:39 -0400
Received: by mail-ej1-x643.google.com with SMTP id o21so686143ejb.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 02:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QC3UutznicSZrdvaN94nX6+ZFJ6gIW8uSMDkwy5ce7E=;
 b=uoXhTt8SNvWrhcccMo61VY95TymzaTUkK50u/amnUZBaJXNzxi4qCJ1w/OvkzGNN7o
 wbJEF1/c5y7LWpX0pJWc2sATsZ9FzupacP5YU0xTiu2WwBmSRarpdPeipLNVo0AmIpDz
 1I5NzSB0U/Ae9Ann4BYBu65u4RxIrXFINkBdxj9GMRVmDDaBDvExjsQiAHnE2LccLX6Y
 s3FLswA9RBVCPUWiy634+UOSjoDSpo7X+oLLwuIgdlU2JNvKXIJL640eQ6ViVHzk0VEW
 xT8RB67Sd7iz2g4m6keznA5tQAdpbuvP/L6hXaF8fkkJKf0bw1YT1NKpBgooPDmOvmNq
 EDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QC3UutznicSZrdvaN94nX6+ZFJ6gIW8uSMDkwy5ce7E=;
 b=p3kn7TyS7sTWSIAu9a8ANcQ8SI8qhwEb0+77V5LBERhWVEV6VUoi2tM/PzfC/Qp7Gb
 EYqvTO+vsLnulShJaEN0MTBilaHoPnxn8dClUFrrE/UDIIDUQ7uwNX5yxwWAFwdMLVR2
 QY2lsH+NrMnMCblEWluv+c7gHwmdx06PH3NAnQDAGxAKEoteBwT6Rbz/tp9L2OzX37xM
 D4KXR9Vo9Ot7l9Dyn0nBC3iZT5pv1B7SZX6sPyNobucnxxz6Kiw6/Wt0JZm86hF7+dfb
 aXpAq7RlbxRiGXkBW/3fsTfVuPQk/GTZA+qfk5zK0vgo0A5KaRsS7qrQdkTTstNhuVkn
 hulg==
X-Gm-Message-State: AOAM530yu2e7GrcrqkokFYovFj/jw8ChHS88ebqLbB+YPqqOdnk4XHIY
 hom70qFxWur1nyYwUkirFr/uMgQRrsTIs9RdQyg=
X-Google-Smtp-Source: ABdhPJzLx2eCOQ5lEX6kU7ZQUcZ6U6ASV9OxkshIMKvwEHfQg4B7OH4vWwEp3rEQmKEZzxxdmH0lVDoDSexzWsP+2MI=
X-Received: by 2002:a17:906:f6cf:: with SMTP id
 jo15mr1529167ejb.105.1604051131831; 
 Fri, 30 Oct 2020 02:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-17-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-17-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 13:45:20 +0400
Message-ID: <CAJ+F1CK=mTevr4m0fvRkQj6=E6uAcDNoWdL06v1-hy-XX+qLFQ@mail.gmail.com>
Subject: Re: [PATCH 16/36] qdev: Make qdev_class_add_property() more flexible
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ea1ce405b2e04194"
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ea1ce405b2e04194
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:13 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> Support Property.set_default and PropertyInfo.description even if
> PropertyInfo.create is set.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  hw/core/qdev-properties.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 89e292dc25..ad685f371d 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -912,24 +912,25 @@ void qdev_property_add_static(DeviceState *dev,
> Property *prop)
>  static void qdev_class_add_property(DeviceClass *klass, Property *prop)
>  {
>      ObjectClass *oc =3D OBJECT_CLASS(klass);
> +    ObjectProperty *op;
>
>      if (prop->info->create) {
> -        prop->info->create(oc, prop);
> +        op =3D prop->info->create(oc, prop);
>      } else {
> -        ObjectProperty *op;
> -
>          op =3D object_class_property_add(oc,
>                                         prop->name, prop->info->name,
>                                         static_prop_getter(prop->info),
>                                         static_prop_setter(prop->info),
>                                         prop->info->release,
>                                         prop);
> -        if (prop->set_default) {
> -            prop->info->set_default_value(op, prop);
> -        }
>      }
> -    object_class_property_set_description(oc, prop->name,
> -                                          prop->info->description);
> +    if (prop->set_default) {
> +        prop->info->set_default_value(op, prop);
> +    }
> +    if (prop->info->description) {
> +        object_class_property_set_description(oc, prop->name,
> +                                            prop->info->description);
>

indentation is off, other than that:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

+    }
>  }
>
>  /**
> --
> 2.28.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000ea1ce405b2e04194
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:13 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Su=
pport Property.set_default and PropertyInfo.description even if<br>
PropertyInfo.create is set.<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br>
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
=C2=A0hw/core/qdev-properties.c | 17 +++++++++--------<br>
=C2=A01 file changed, 9 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c<br>
index 89e292dc25..ad685f371d 100644<br>
--- a/hw/core/qdev-properties.c<br>
+++ b/hw/core/qdev-properties.c<br>
@@ -912,24 +912,25 @@ void qdev_property_add_static(DeviceState *dev, Prope=
rty *prop)<br>
=C2=A0static void qdev_class_add_property(DeviceClass *klass, Property *pro=
p)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ObjectClass *oc =3D OBJECT_CLASS(klass);<br>
+=C2=A0 =C2=A0 ObjectProperty *op;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (prop-&gt;info-&gt;create) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;info-&gt;create(oc, prop);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 op =3D prop-&gt;info-&gt;create(oc, prop);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ObjectProperty *op;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0op =3D object_class_property_add(oc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt=
;name, prop-&gt;info-&gt;name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 static_p=
rop_getter(prop-&gt;info),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 static_p=
rop_setter(prop-&gt;info),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt=
;info-&gt;release,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prop);<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prop-&gt;set_default) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;info-&gt;set_default_va=
lue(op, prop);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 object_class_property_set_description(oc, prop-&gt;name,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p=
rop-&gt;info-&gt;description);<br>
+=C2=A0 =C2=A0 if (prop-&gt;set_default) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;info-&gt;set_default_value(op, prop);=
<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (prop-&gt;info-&gt;description) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_class_property_set_description(oc, prop=
-&gt;name,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 prop-&gt;info-&gt;description);<br></blockquote><div><br></div><div>=
indentation is off, other than that:</div><div>Reviewed-by: Marc-Andr=C3=A9=
 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau=
@redhat.com</a>&gt;</div><div> <br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
+=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0/**<br>
-- <br>
2.28.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000ea1ce405b2e04194--

