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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B98C55179
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:04:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3FFB20825
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEZtMDZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3FFB20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYRGe-00020k-RC
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 06:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYRFj-0001ZT-Ow
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:03:23 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:35432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYRFh-0000R4-91
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:03:23 -0400
Received: by mail-ej1-x644.google.com with SMTP id p5so7812636ejj.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 03:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FuM4GCZofhr1IKKzpMCKK7GdtaQWr7MDIcx3ctw19ac=;
 b=NEZtMDZAGkqfvXIQn3gCBJV7CK8P9bzhh8ekhjlHWXl3yQeTSGMnafZJ6avsGTpYIc
 iykMtNnGESdHmuYVLRJkJOCagzqWHx7gRgb5XSLngFJ0kGkTQJHlBreTpyxkY/MqwWJN
 mtlOYhJ879O9L8skEGCKDC1KFZ7dVDeskGUH/WDKIVcAMCtIMxQpapnSMIjHnFV1b2Hj
 /fcOBls9gyPEzh701JqEMo997BEERttP04ab/goOP3qAULnIdmZsUELYMLQ+wnLow2bX
 SQmJ8D9moy01U31gYyP/UE+jDjz1v3ftcg6nEQgC6Z/ul9ht2RHqsP92OrbJCysnY7iC
 O5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FuM4GCZofhr1IKKzpMCKK7GdtaQWr7MDIcx3ctw19ac=;
 b=Z6Ve8V8/ojKfa0BYoXyWrbZEe3m7DdA2DL3NM2PBgOIOFNSVIrDdbMgH17/8iMCw7s
 HJ4q9t0eXcW2saauluPDkITytMA+wTKlURar7wJMbHlW6cg3d3QGS9mrloboYeuYywSD
 +7wTS7Ulc17hzhQcs22dwoGV/cH4mF8RfU3Yu4qPlP4XzXPnPiDREhwR1vBWlSehKeaQ
 rsA/b5B3eXiDWDHTIn3iWXEYmCND7Onm/VwbD1iS/DlGNOO7CEk7mNy0TlVGp/53GrMB
 dEjpeVUq7Hz/KFeS3OwBhyPgB2osRMsdVmDrk/UMVe2MceCGdRs4msR21kdrxSpY+sta
 BwjA==
X-Gm-Message-State: AOAM531f6xAJGFbF2DAlKq3UIQQYt55fFl2VtmK501Xa+adF+Q+8Ua+e
 +EHLvL9PUgJ7Gj4PuvXJ6RhOPpVgX7we9z3FLb0p1UdC0auitg==
X-Google-Smtp-Source: ABdhPJyq+ADwClYBFgjthbbuOWzBLKZ17ObEvMapdDZknsGFCYp8QJPxNUEeKhoAeREyUdcWgFy2dUuYCyWfhDbbSi0=
X-Received: by 2002:a17:906:f6cf:: with SMTP id
 jo15mr1593077ejb.105.1604052199995; 
 Fri, 30 Oct 2020 03:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-20-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-20-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 14:03:07 +0400
Message-ID: <CAJ+F1CJmU0G1CJnaj-i1KYCfN_ir+tppcfQESY1xpv50nJAxHg@mail.gmail.com>
Subject: Re: [PATCH 19/36] qdev: Move array property creation/registration to
 separate functions
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000095026505b2e08104"
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

--00000000000095026505b2e08104
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:17 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> The array property registration code is hard to follow.  Move the
> two steps into separate functions that have clear
> responsibilities.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  hw/core/qdev-properties.c | 60 ++++++++++++++++++++++++++-------------
>  1 file changed, 41 insertions(+), 19 deletions(-)
>
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 27c09255d7..1f06dfb5d5 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -588,6 +588,32 @@ typedef struct {
>      ObjectPropertyRelease *release;
>  } ArrayElementProperty;
>
> +/**
> + * Create ArrayElementProperty based on array length property
> + * @array_len_prop (which was previously defined using
> DEFINE_PROP_ARRAY()).
> + */
>

(some day we will have to clarify our API doc style, but not now ;)

+static ArrayElementProperty *array_element_new(Object *obj,
> +                                               Property *array_len_prop,
> +                                               const char *arrayname,
> +                                               int index,
> +                                               void *eltptr)
> +{
> +    char *propname =3D g_strdup_printf("%s[%d]", arrayname, index);
> +    ArrayElementProperty *arrayprop =3D g_new0(ArrayElementProperty, 1);
> +    arrayprop->release =3D array_len_prop->arrayinfo->release;
> +    arrayprop->propname =3D propname;
> +    arrayprop->prop.info =3D array_len_prop->arrayinfo;
> +    arrayprop->prop.name =3D propname;
> +    /* This ugly piece of pointer arithmetic sets up the offset so
> +     * that when the underlying get/set hooks call qdev_get_prop_ptr
> +     * they get the right answer despite the array element not actually
> +     * being inside the device struct.
> +     */
> +    arrayprop->prop.offset =3D eltptr - (void *)obj;
> +    assert(qdev_get_prop_ptr(obj, &arrayprop->prop) =3D=3D eltptr);
> +    return arrayprop;
> +}
> +
>  /* object property release callback for array element properties:
>   * we call the underlying element's property release hook, and
>   * then free the memory we allocated when we added the property.
> @@ -602,6 +628,18 @@ static void array_element_release(Object *obj, const
> char *name, void *opaque)
>      g_free(p);
>  }
>
> +static void object_property_add_array_element(Object *obj,
> +                                              Property *array_len_prop,
> +                                              ArrayElementProperty *prop=
)
> +{
> +    object_property_add(obj, prop->prop.name,
> +                        prop->prop.info->name,
> +                        static_prop_getter(prop->prop.info),
> +                        static_prop_setter(prop->prop.info),
> +                        array_element_release,
> +                        prop);
> +}
> +
>  static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
>                                void *opaque, Error **errp)
>  {
> @@ -641,25 +679,9 @@ static void set_prop_arraylen(Object *obj, Visitor
> *v, const char *name,
>       */
>      *arrayptr =3D eltptr =3D g_malloc0(*alenptr * prop->arrayfieldsize);
>      for (i =3D 0; i < *alenptr; i++, eltptr +=3D prop->arrayfieldsize) {
> -        char *propname =3D g_strdup_printf("%s[%d]", arrayname, i);
> -        ArrayElementProperty *arrayprop =3D g_new0(ArrayElementProperty,=
 1);
> -        arrayprop->release =3D prop->arrayinfo->release;
> -        arrayprop->propname =3D propname;
> -        arrayprop->prop.info =3D prop->arrayinfo;
> -        arrayprop->prop.name =3D propname;
> -        /* This ugly piece of pointer arithmetic sets up the offset so
> -         * that when the underlying get/set hooks call qdev_get_prop_ptr
> -         * they get the right answer despite the array element not
> actually
> -         * being inside the device struct.
> -         */
> -        arrayprop->prop.offset =3D eltptr - (void *)obj;
> -        assert(qdev_get_prop_ptr(obj, &arrayprop->prop) =3D=3D eltptr);
> -        object_property_add(obj, propname,
> -                            arrayprop->prop.info->name,
> -                            static_prop_getter(arrayprop->prop.info),
> -                            static_prop_setter(arrayprop->prop.info),
> -                            array_element_release,
> -                            arrayprop);
> +        ArrayElementProperty *elt_prop =3D array_element_new(obj, prop,
> arrayname,
> +                                                           i, eltptr);
> +        object_property_add_array_element(obj, prop, elt_prop);
>      }
>  }
>
> --
> 2.28.0
>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000095026505b2e08104
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:17 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Th=
e array property registration code is hard to follow.=C2=A0 Move the<br>
two steps into separate functions that have clear<br>
responsibilities.<br>
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
=C2=A0hw/core/qdev-properties.c | 60 ++++++++++++++++++++++++++------------=
-<br>
=C2=A01 file changed, 41 insertions(+), 19 deletions(-)<br>
<br>
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c<br>
index 27c09255d7..1f06dfb5d5 100644<br>
--- a/hw/core/qdev-properties.c<br>
+++ b/hw/core/qdev-properties.c<br>
@@ -588,6 +588,32 @@ typedef struct {<br>
=C2=A0 =C2=A0 =C2=A0ObjectPropertyRelease *release;<br>
=C2=A0} ArrayElementProperty;<br>
<br>
+/**<br>
+ * Create ArrayElementProperty based on array length property<br>
+ * @array_len_prop (which was previously defined using DEFINE_PROP_ARRAY()=
).<br>
+ */<br></blockquote><div><br></div><div>(some day we will have to clarify =
our API doc style, but not now ;)</div><div> <br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
+static ArrayElementProperty *array_element_new(Object *obj,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Property *array_len_prop,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0const char *arrayname,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0int index,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0void *eltptr)<br>
+{<br>
+=C2=A0 =C2=A0 char *propname =3D g_strdup_printf(&quot;%s[%d]&quot;, array=
name, index);<br>
+=C2=A0 =C2=A0 ArrayElementProperty *arrayprop =3D g_new0(ArrayElementPrope=
rty, 1);<br>
+=C2=A0 =C2=A0 arrayprop-&gt;release =3D array_len_prop-&gt;arrayinfo-&gt;r=
elease;<br>
+=C2=A0 =C2=A0 arrayprop-&gt;propname =3D propname;<br>
+=C2=A0 =C2=A0 arrayprop-&gt;<a href=3D"http://prop.info" rel=3D"noreferrer=
" target=3D"_blank">prop.info</a> =3D array_len_prop-&gt;arrayinfo;<br>
+=C2=A0 =C2=A0 arrayprop-&gt;<a href=3D"http://prop.name" rel=3D"noreferrer=
" target=3D"_blank">prop.name</a> =3D propname;<br>
+=C2=A0 =C2=A0 /* This ugly piece of pointer arithmetic sets up the offset =
so<br>
+=C2=A0 =C2=A0 =C2=A0* that when the underlying get/set hooks call qdev_get=
_prop_ptr<br>
+=C2=A0 =C2=A0 =C2=A0* they get the right answer despite the array element =
not actually<br>
+=C2=A0 =C2=A0 =C2=A0* being inside the device struct.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 arrayprop-&gt;prop.offset =3D eltptr - (void *)obj;<br>
+=C2=A0 =C2=A0 assert(qdev_get_prop_ptr(obj, &amp;arrayprop-&gt;prop) =3D=
=3D eltptr);<br>
+=C2=A0 =C2=A0 return arrayprop;<br>
+}<br>
+<br>
=C2=A0/* object property release callback for array element properties:<br>
=C2=A0 * we call the underlying element&#39;s property release hook, and<br=
>
=C2=A0 * then free the memory we allocated when we added the property.<br>
@@ -602,6 +628,18 @@ static void array_element_release(Object *obj, const c=
har *name, void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0g_free(p);<br>
=C2=A0}<br>
<br>
+static void object_property_add_array_element(Object *obj,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 Property *array_len_prop,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ArrayElementProperty *prop)<br>
+{<br>
+=C2=A0 =C2=A0 object_property_add(obj, prop-&gt;<a href=3D"http://prop.nam=
e" rel=3D"noreferrer" target=3D"_blank">prop.name</a>,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 prop-&gt;prop.info-&gt;name,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 static_prop_getter(prop-&gt;<a href=3D"http://prop.info" rel=3D"=
noreferrer" target=3D"_blank">prop.info</a>),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 static_prop_setter(prop-&gt;<a href=3D"http://prop.info" rel=3D"=
noreferrer" target=3D"_blank">prop.info</a>),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 array_element_release,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 prop);<br>
+}<br>
+<br>
=C2=A0static void set_prop_arraylen(Object *obj, Visitor *v, const char *na=
me,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque, Error **errp)<br>
=C2=A0{<br>
@@ -641,25 +679,9 @@ static void set_prop_arraylen(Object *obj, Visitor *v,=
 const char *name,<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0*arrayptr =3D eltptr =3D g_malloc0(*alenptr * prop-&gt;=
arrayfieldsize);<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; *alenptr; i++, eltptr +=3D prop-&g=
t;arrayfieldsize) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *propname =3D g_strdup_printf(&quot;%s[%d=
]&quot;, arrayname, i);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ArrayElementProperty *arrayprop =3D g_new0(Arr=
ayElementProperty, 1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 arrayprop-&gt;release =3D prop-&gt;arrayinfo-&=
gt;release;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 arrayprop-&gt;propname =3D propname;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 arrayprop-&gt;<a href=3D"http://prop.info" rel=
=3D"noreferrer" target=3D"_blank">prop.info</a> =3D prop-&gt;arrayinfo;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 arrayprop-&gt;<a href=3D"http://prop.name" rel=
=3D"noreferrer" target=3D"_blank">prop.name</a> =3D propname;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* This ugly piece of pointer arithmetic sets =
up the offset so<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* that when the underlying get/set hooks=
 call qdev_get_prop_ptr<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* they get the right answer despite the =
array element not actually<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* being inside the device struct.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 arrayprop-&gt;prop.offset =3D eltptr - (void *=
)obj;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(qdev_get_prop_ptr(obj, &amp;arrayprop-&=
gt;prop) =3D=3D eltptr);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_add(obj, propname,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 arrayprop-&gt;prop.info-&gt;name,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 static_prop_getter(arrayprop-&gt;<a href=3D"http:/=
/prop.info" rel=3D"noreferrer" target=3D"_blank">prop.info</a>),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 static_prop_setter(arrayprop-&gt;<a href=3D"http:/=
/prop.info" rel=3D"noreferrer" target=3D"_blank">prop.info</a>),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 array_element_release,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 arrayprop);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ArrayElementProperty *elt_prop =3D array_eleme=
nt_new(obj, prop, arrayname,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i, eltptr);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_add_array_element(obj, prop, e=
lt_prop);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-- <br>
2.28.0<br></blockquote><div><br></div><div>=C2=A0</div></div>Reviewed-by: M=
arc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">ma=
rcandre.lureau@redhat.com</a>&gt;<br clear=3D"all"><br>-- <br><div dir=3D"l=
tr" class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000095026505b2e08104--

