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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA36C43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:03:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EDA02184D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXnFxZMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EDA02184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQPxq-0001vW-CJ
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 03:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kQPuq-00004s-46
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:00:40 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:44160)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kQPuo-0002aP-7N
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:00:39 -0400
Received: by mail-ej1-x641.google.com with SMTP id a3so6478487ejy.11
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 00:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5nKLpZCOGzI5yDMC9dJOG4dUHgA3bxB1eIZ9nDRk9Vg=;
 b=RXnFxZMPCAN1tc+cKQlgWjBLbGrppmrSozmVePOVP7vOry9ZzeGssJG9EXJ5uDwC75
 5fTfVSgdUybevP5s1QhD9umIhn6VmtBlsE7OwUrtsl8/jzGRx1/5/9dYYmC6HeHANg6Q
 CIcoQ3045CvD/neFmyClJfuHJQ8zcuGjSNUceZ3r9+iMDOF3+SJ+H4PgSEaF9Biu9pCT
 Z+cnhTpA/uS0LWKDn8g09GTZjHPcye3Z9XGi3FoiBgUE0izFJ0EGi5Z2oyZFY59sAchJ
 W/Dfnr/Qlw8Xu6qQPps6mTDcl/LRg8816J7No65TMM+5s4xNS2EdlXpTws0bQO5ozJgW
 DoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5nKLpZCOGzI5yDMC9dJOG4dUHgA3bxB1eIZ9nDRk9Vg=;
 b=q5Zo00cYDshgwrDKzcLBEiZRTpDaKS7VKKwdi+lQMeCT9PeVdibzqqa7s/mJU7zhJ+
 JVu0DL9wMSx5/qWSVPpdXkNQp2QqSg/fObT+bI16yQd6e2tZLs7Jz/YwxBlsOSnie1O7
 oPqVuQPE/oaohbFoaa14GustGKKn5ag4tte7Xg980iwUEd87VLVnfLMsMlC/ybkZmGwj
 LF1+CPi3gOKFi2CUciijx/RvCIefVZzUxd0o4avKgbxJhkzO3tcJZ6yNcv8KM+axbI3/
 adEVDhNXx51krDcMvRewrMCeB1LIWA9PX5wIqILbuLScJbitr0qL2VqSLJP9+1fk1iZY
 O9gw==
X-Gm-Message-State: AOAM532mZ6gRAinUkFmzHgauUt3h6Vjhren8Q7dc1F7IoQ/Ti5fhL/vq
 Ig7SEgc2I1W1gDlsvcPHU1uvDHmiXLf5KQPtksY=
X-Google-Smtp-Source: ABdhPJzqenvt1aw6xTBhsTx1+408Gs1oa0EjOBVWu+D2AExoqtMe6MAu4+ni6dAJR67qe+BJ3P3bgIhP3mDi2ECzE9g=
X-Received: by 2002:a17:906:4e16:: with SMTP id
 z22mr1175710eju.527.1602140436883; 
 Thu, 08 Oct 2020 00:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200921221045.699690-1-ehabkost@redhat.com>
 <20200921221045.699690-22-ehabkost@redhat.com>
In-Reply-To: <20200921221045.699690-22-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 8 Oct 2020 11:00:24 +0400
Message-ID: <CAJ+F1CLOS948hqSc2fim9WC6BBTHtTpnYdyiz9paqmGgu=WCBA@mail.gmail.com>
Subject: Re: [PATCH 21/24] vga-pci: Register "big-endian-framebuffer" as class
 property
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009eee3605b12363fd"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x641.google.com
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
 QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009eee3605b12363fd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 2:28 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> Class properties make QOM introspection simpler and easier, as
> they don't require an object to be instantiated.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  hw/display/vga-pci.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
> index 3b45fa3bad0..b2a7d03c5d5 100644
> --- a/hw/display/vga-pci.c
> +++ b/hw/display/vga-pci.c
> @@ -269,13 +269,6 @@ static void pci_std_vga_realize(PCIDevice *dev, Erro=
r
> **errp)
>      }
>  }
>
> -static void pci_std_vga_init(Object *obj)
> -{
> -    /* Expose framebuffer byteorder via QOM */
> -    object_property_add_bool(obj, "big-endian-framebuffer",
> -                             vga_get_big_endian_fb,
> vga_set_big_endian_fb);
> -}
> -
>  static void pci_secondary_vga_realize(PCIDevice *dev, Error **errp)
>  {
>      PCIVGAState *d =3D PCI_VGA(dev);
> @@ -388,6 +381,10 @@ static void vga_class_init(ObjectClass *klass, void
> *data)
>      k->class_id =3D PCI_CLASS_DISPLAY_VGA;
>      device_class_set_props(dc, vga_pci_properties);
>      dc->hotpluggable =3D false;
> +
> +    /* Expose framebuffer byteorder via QOM */
> +    object_class_property_add_bool(klass, "big-endian-framebuffer",
> +                                   vga_get_big_endian_fb,
> vga_set_big_endian_fb);
>  }
>
>  static void secondary_class_init(ObjectClass *klass, void *data)
> @@ -405,7 +402,6 @@ static void secondary_class_init(ObjectClass *klass,
> void *data)
>  static const TypeInfo vga_info =3D {
>      .name          =3D "VGA",
>      .parent        =3D TYPE_PCI_VGA,
> -    .instance_init =3D pci_std_vga_init,
>      .class_init    =3D vga_class_init,
>  };
>
> --
> 2.26.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000009eee3605b12363fd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 22, 2020 at 2:28 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" target=3D"_blank">eha=
bkost@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">Class properties make QOM introspection simpler and easier,=
 as<br>
they don&#39;t require an object to be instantiated.<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br></blockquote><div><br></div=
><div> <font color=3D"#888888">=C2=A0 </font><br><div>Reviewed-by: Marc-And=
r=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com" target=3D=
"_blank">marcandre.lureau@redhat.com</a>&gt;</div><div><br></div></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
Cc: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank=
">kraxel@redhat.com</a>&gt;<br>
Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@n=
ongnu.org</a><br>
---<br>
=C2=A0hw/display/vga-pci.c | 12 ++++--------<br>
=C2=A01 file changed, 4 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c<br>
index 3b45fa3bad0..b2a7d03c5d5 100644<br>
--- a/hw/display/vga-pci.c<br>
+++ b/hw/display/vga-pci.c<br>
@@ -269,13 +269,6 @@ static void pci_std_vga_realize(PCIDevice *dev, Error =
**errp)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static void pci_std_vga_init(Object *obj)<br>
-{<br>
-=C2=A0 =C2=A0 /* Expose framebuffer byteorder via QOM */<br>
-=C2=A0 =C2=A0 object_property_add_bool(obj, &quot;big-endian-framebuffer&q=
uot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vga_get_big_endian_fb, vga_set_big_endian_fb=
);<br>
-}<br>
-<br>
=C2=A0static void pci_secondary_vga_realize(PCIDevice *dev, Error **errp)<b=
r>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0PCIVGAState *d =3D PCI_VGA(dev);<br>
@@ -388,6 +381,10 @@ static void vga_class_init(ObjectClass *klass, void *d=
ata)<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;class_id =3D PCI_CLASS_DISPLAY_VGA;<br>
=C2=A0 =C2=A0 =C2=A0device_class_set_props(dc, vga_pci_properties);<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;hotpluggable =3D false;<br>
+<br>
+=C2=A0 =C2=A0 /* Expose framebuffer byteorder via QOM */<br>
+=C2=A0 =C2=A0 object_class_property_add_bool(klass, &quot;big-endian-frame=
buffer&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vga_get_big_endian_fb, =
vga_set_big_endian_fb);<br>
=C2=A0}<br>
<br>
=C2=A0static void secondary_class_init(ObjectClass *klass, void *data)<br>
@@ -405,7 +402,6 @@ static void secondary_class_init(ObjectClass *klass, vo=
id *data)<br>
=C2=A0static const TypeInfo vga_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;VGA&q=
uot;,<br>
=C2=A0 =C2=A0 =C2=A0.parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_PCI_VGA,<br=
>
-=C2=A0 =C2=A0 .instance_init =3D pci_std_vga_init,<br>
=C2=A0 =C2=A0 =C2=A0.class_init=C2=A0 =C2=A0 =3D vga_class_init,<br>
=C2=A0};<br>
<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr">Marc-Andr=
=C3=A9 Lureau<br></div></div>

--0000000000009eee3605b12363fd--

