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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A283C55179
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:01:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E84206CA
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iw6jIPnY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E84206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYRDV-0000Ls-Ng
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 06:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYRBt-0007YK-Px
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 05:59:26 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:45576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYRBs-0007Wg-07
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 05:59:25 -0400
Received: by mail-ej1-x644.google.com with SMTP id dk16so7173956ejb.12
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 02:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XzWR5nQNTGAoHj9WB1480wME5qkfN61zA6z3+6SImH0=;
 b=iw6jIPnY5yH01+i5szJdAt6ye2c9prEShHEJRneU+PNMzwYMdhvw9x2Vhg1c7uuRKc
 bDxVR/+5HtKUZimUAmZZETNZTiXOcPED6nrwLE0fWkNHT5VQUmTcyYNDWFOrPyllqTVr
 rfLyMww+WQFtiIm1uhSslPdOGwrqrXsdpwdv31549PzAA5YKjzx2j7S1K8ecPSFBfB5P
 au659A8TMYnZTUmXD3raGFanqr5gP6C8v7wHx71ffODuEqGr9SG//aEa0koQJoPA3zJN
 floEsfeMiY6pfLNVdXqxs+tTjxRoHeNjTWH7NTmX3W3wjp9SqskM8PF+nrUDUysfZIiv
 AJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XzWR5nQNTGAoHj9WB1480wME5qkfN61zA6z3+6SImH0=;
 b=no2znOJM8JhqUlB867duqKFFXrYQQsgMeHsmXZIUbM7vMevoCd73Bnt3mcd3uNJXqX
 UwKHs4b23wI6UtZu8fj6MLzHsu9miANogi7NH/oV1eaWFKqc0Z2QJpnvGqQNkYCRGE+x
 ibRvVpqKZhW0dYkroA81McnqerF8vjzQLtDQDGil1q4hN3tUNxiEFdnifdl00pmDIAn9
 y4wVBh73OOK+JOW7awvLroxe3rziFvnUmXio8crWQbCebMm5qjU4QfydpXiX8qSeG7tz
 PVZineT40AU/IT10KDj87IzIWYuwbjRVDymujGf8yp1wlDAflkOOzLISm5yt3x8bYfCO
 Bgeg==
X-Gm-Message-State: AOAM533QeS9qmQHQVYr84dPa7itOczdjqNn2bb1PHZX4C1jv+PqDDJoR
 xQcFhRvHWqCUQJQa+/2t83XT93pJgWIp9b5p8nU=
X-Google-Smtp-Source: ABdhPJxRC4PP8GruJSwkDCCehodIz4TfYYdjXg+ezuGc10/ARjBf08OPJxh8X95BZpKEcaTxIxhDV+iKZZ94ZqESeIU=
X-Received: by 2002:a17:906:2798:: with SMTP id
 j24mr1540254ejc.109.1604051962437; 
 Fri, 30 Oct 2020 02:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-19-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-19-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 13:59:10 +0400
Message-ID: <CAJ+F1CLCpgSMQUEDtLTXUMO+puRuv9rsYg06auf_aa_hGAuoyA@mail.gmail.com>
Subject: Re: [PATCH 18/36] qdev: Avoid unnecessary DeviceState* variable at
 set_prop_arraylen()
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006c238705b2e073e8"
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006c238705b2e073e8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:18 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> We're just doing pointer math with the device pointer, we can
> simply use obj instead.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>

 Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  hw/core/qdev-properties.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 68b1666e14..27c09255d7 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -610,10 +610,9 @@ static void set_prop_arraylen(Object *obj, Visitor
> *v, const char *name,
>       * array-length field in the device struct, we have to create the
>       * array itself and dynamically add the corresponding properties.
>       */
> -    DeviceState *dev =3D DEVICE(obj);
>      Property *prop =3D opaque;
>      uint32_t *alenptr =3D qdev_get_prop_ptr(obj, prop);
> -    void **arrayptr =3D (void *)dev + prop->arrayoffset;
> +    void **arrayptr =3D (void *)obj + prop->arrayoffset;
>      void *eltptr;
>      const char *arrayname;
>      int i;
> @@ -653,7 +652,7 @@ static void set_prop_arraylen(Object *obj, Visitor *v=
,
> const char *name,
>           * they get the right answer despite the array element not
> actually
>           * being inside the device struct.
>           */
> -        arrayprop->prop.offset =3D eltptr - (void *)dev;
> +        arrayprop->prop.offset =3D eltptr - (void *)obj;
>          assert(qdev_get_prop_ptr(obj, &arrayprop->prop) =3D=3D eltptr);
>          object_property_add(obj, propname,
>                              arrayprop->prop.info->name,
> --
> 2.28.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000006c238705b2e073e8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:18 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">We=
&#39;re just doing pointer math with the device pointer, we can<br>
simply use obj instead.<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br></blockquote><div><br></div=
><div>=C2=A0Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marca=
ndre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div><br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
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
=C2=A0hw/core/qdev-properties.c | 5 ++---<br>
=C2=A01 file changed, 2 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c<br>
index 68b1666e14..27c09255d7 100644<br>
--- a/hw/core/qdev-properties.c<br>
+++ b/hw/core/qdev-properties.c<br>
@@ -610,10 +610,9 @@ static void set_prop_arraylen(Object *obj, Visitor *v,=
 const char *name,<br>
=C2=A0 =C2=A0 =C2=A0 * array-length field in the device struct, we have to =
create the<br>
=C2=A0 =C2=A0 =C2=A0 * array itself and dynamically add the corresponding p=
roperties.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 DeviceState *dev =3D DEVICE(obj);<br>
=C2=A0 =C2=A0 =C2=A0Property *prop =3D opaque;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t *alenptr =3D qdev_get_prop_ptr(obj, prop);<br>
-=C2=A0 =C2=A0 void **arrayptr =3D (void *)dev + prop-&gt;arrayoffset;<br>
+=C2=A0 =C2=A0 void **arrayptr =3D (void *)obj + prop-&gt;arrayoffset;<br>
=C2=A0 =C2=A0 =C2=A0void *eltptr;<br>
=C2=A0 =C2=A0 =C2=A0const char *arrayname;<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
@@ -653,7 +652,7 @@ static void set_prop_arraylen(Object *obj, Visitor *v, =
const char *name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * they get the right answer despite the =
array element not actually<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * being inside the device struct.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 arrayprop-&gt;prop.offset =3D eltptr - (void *=
)dev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 arrayprop-&gt;prop.offset =3D eltptr - (void *=
)obj;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert(qdev_get_prop_ptr(obj, &amp;arrayp=
rop-&gt;prop) =3D=3D eltptr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_add(obj, propname,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arrayprop-&gt;prop.info-&gt;name,<br>
-- <br>
2.28.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000006c238705b2e073e8--

