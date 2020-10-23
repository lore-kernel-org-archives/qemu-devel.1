Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B3DC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00310208B3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCg7fjYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00310208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVvIB-0001yz-Uw
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 07:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kVvAS-00038Y-FP
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 07:23:32 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:43322)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kVvAQ-0000J2-Cm
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 07:23:32 -0400
Received: by mail-ed1-x544.google.com with SMTP id dn5so1165754edb.10
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 04:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hOLmDxXU8fco/yA2w4sIJT+MlLEwJyvxf5DlLCKMw2Y=;
 b=CCg7fjYj1we60pC3BHLFBJPVmL66lLI3V6SvRxLkOrXT/+Ksp3iKfe7eh3K8u3pQ2R
 Vc175EtKW+2TO4W7/FGLibsr2K9jS0CigNnjkzB+ye7m+I4JTe8PxM9RpR8eFjoYdfli
 ra1Df1HzPsa+WnIhteWXquJPGCXiaVYI8WLfJWb1UcjRhpznvB5nTuG7xK1FGxvFwDFb
 ZNJ6DrB9RX+TW18fzIn9Hvqwy6DNKcDP/lki/DxkB8avs2W90mg6oihAC0JVprBtCRKb
 OYNgH7vg8tH9awZD180b9qk1nU/AMgQmdqvJdtcGAjg+jWDHAjKRovHv2J74xQs311hG
 4PsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hOLmDxXU8fco/yA2w4sIJT+MlLEwJyvxf5DlLCKMw2Y=;
 b=TiVpba2TZ7fTrdQXi60pgN1tCEb/VF37cHVPH9dHxCgqfD+r2eLzcOyqiG42itoejx
 6h7kfaHLS9dsdIFppL+pxFAX5WqMCmbDbODaCLNuaZdXSsWeuO1+6k2GEuFov3LVqFuf
 L0Q7MgsUrgDOr6Dch8G2wxqvDVi+LAonh3T5admCdDTQ07hHrViLRKb3EDd1GvEmWoPU
 ljrPkKb/FTTqzRGqPU0wu72eyywhCL//1Jw29mEu7kuWtE7ccaKvKR5/cHQ4QeK6VNWU
 ET306C39dE8GIhlvWmTaN+3d7MFjFsDp/FHxACWQzWeiQCdBYzEThAvqLNV0CCHP3Y0T
 3KJw==
X-Gm-Message-State: AOAM533xEjfJWChiowvS8hK3zW37yZp4KdmfjWcb58lOXQ1JpHK/6bAC
 svICa0sfqkDNmA9VQm+CcCeJxO2f1xiTfyraIgQ=
X-Google-Smtp-Source: ABdhPJxb6sviqf+njCNoEqSAgBi7YCjI2961nJWqRNr1yuTqegLTJWFWt2v6P420l0HmuBIJkevCl6nK+pugdKSdVRw=
X-Received: by 2002:aa7:cd98:: with SMTP id x24mr1592842edv.237.1603452208843; 
 Fri, 23 Oct 2020 04:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201020091024.320381-1-luc@lmichel.fr>
In-Reply-To: <20201020091024.320381-1-luc@lmichel.fr>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 23 Oct 2020 15:23:16 +0400
Message-ID: <CAJ+F1C+CZhxA1=pW=8H8=E8nCM27YKNuiGJc-jbtcs+TMi6DEQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/core/qdev-clock: add a reference on aliased clocks
To: Luc Michel <luc@lmichel.fr>
Content-Type: multipart/alternative; boundary="00000000000052901905b254cff1"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x544.google.com
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000052901905b254cff1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Oct 20, 2020 at 1:11 PM Luc Michel <luc@lmichel.fr> wrote:

> When aliasing a clock with the qdev_alias_clock() function, a new link
> property is created on the device aliasing the clock. The link points
> to the aliased clock and use the OBJ_PROP_LINK_STRONG flag. This
> property is read only since it does not provide a check callback for
> modifications.
>
> The object_property_add_link() documentation stats that with
> OBJ_PROP_LINK_STRONG properties, the linked object reference count get
> decremented when the property is deleted. But it is _not_ incremented on
> creation (object_property_add_link() does not actually know the link).
>
> This commit increments the reference count on the aliased clock to
> ensure the aliased clock stays alive during the property lifetime, and
> to avoid a double-free memory error when the property gets deleted.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Luc Michel <luc@lmichel.fr>
> ---
>

In principle, that makes sense. But I don't see any users of that API yet.

It would have been nice to have some unit tests for qdev-clock.h..

 hw/core/qdev-clock.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
> index 6a9a340d0f..eb05f2a13c 100644
> --- a/hw/core/qdev-clock.c
> +++ b/hw/core/qdev-clock.c
> @@ -59,10 +59,18 @@ static NamedClockList *qdev_init_clocklist(DeviceStat=
e
> *dev, const char *name,
>      } else {
>          object_property_add_link(OBJECT(dev), name,
>                                   object_get_typename(OBJECT(clk)),
>                                   (Object **) &ncl->clock,
>                                   NULL, OBJ_PROP_LINK_STRONG);
> +        /*
> +         * Since the link property has the OBJ_PROP_LINK_STRONG flag, th=
e
> clk
> +         * object reference count gets decremented on property deletion.
> +         * However object_property_add_link does not increment it since =
it
> +         * doesn't know the linked object. Increment it here to ensure t=
he
> +         * aliased clock stays alive during this device life-time.
> +         */
> +        object_ref(OBJECT(clk));
>      }
>
>      ncl->clock =3D clk;
>
>      QLIST_INSERT_HEAD(&dev->clocks, ncl, node);
> --
> 2.28.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000052901905b254cff1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 20, 2020 at 1:11 PM Luc=
 Michel &lt;<a href=3D"mailto:luc@lmichel.fr">luc@lmichel.fr</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">When aliasing a=
 clock with the qdev_alias_clock() function, a new link<br>
property is created on the device aliasing the clock. The link points<br>
to the aliased clock and use the OBJ_PROP_LINK_STRONG flag. This<br>
property is read only since it does not provide a check callback for<br>
modifications.<br>
<br>
The object_property_add_link() documentation stats that with<br>
OBJ_PROP_LINK_STRONG properties, the linked object reference count get<br>
decremented when the property is deleted. But it is _not_ incremented on<br=
>
creation (object_property_add_link() does not actually know the link).<br>
<br>
This commit increments the reference count on the aliased clock to<br>
ensure the aliased clock stays alive during the property lifetime, and<br>
to avoid a double-free memory error when the property gets deleted.<br>
<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.=
org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
Signed-off-by: Luc Michel &lt;<a href=3D"mailto:luc@lmichel.fr" target=3D"_=
blank">luc@lmichel.fr</a>&gt;<br>
---<br></blockquote><div><br></div><div>In principle, that makes sense. But=
 I don&#39;t see any users of that API yet.</div><div><br></div><div>It wou=
ld have been nice to have some unit tests for qdev-clock.h..</div><div><br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0hw/core/qdev-clock.c | 8 ++++++++<br>
=C2=A01 file changed, 8 insertions(+)<br>
<br>
diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c<br>
index 6a9a340d0f..eb05f2a13c 100644<br>
--- a/hw/core/qdev-clock.c<br>
+++ b/hw/core/qdev-clock.c<br>
@@ -59,10 +59,18 @@ static NamedClockList *qdev_init_clocklist(DeviceState =
*dev, const char *name,<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_add_link(OBJECT(dev), nam=
e,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 object_get_typename(OBJECT(cl=
k)),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (Object **) &amp;ncl-&gt;cloc=
k,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, OBJ_PROP_LINK_STRONG);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Since the link property has the OBJ_PR=
OP_LINK_STRONG flag, the clk<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* object reference count gets decremente=
d on property deletion.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* However object_property_add_link does =
not increment it since it<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* doesn&#39;t know the linked object. In=
crement it here to ensure the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* aliased clock stays alive during this =
device life-time.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_ref(OBJECT(clk));<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0ncl-&gt;clock =3D clk;<br>
<br>
=C2=A0 =C2=A0 =C2=A0QLIST_INSERT_HEAD(&amp;dev-&gt;clocks, ncl, node);<br>
-- <br>
2.28.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000052901905b254cff1--

