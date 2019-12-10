Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582DEC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 19:12:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EA5720637
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 19:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vS1r0KBq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA5720637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iekw4-0002wb-5Z
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 14:12:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iekvM-0002PY-9S
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:11:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iekvK-0006Il-Fs
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:11:56 -0500
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:46005)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1iekvK-0006IX-7c; Tue, 10 Dec 2019 14:11:54 -0500
Received: by mail-il1-x141.google.com with SMTP id p8so17095545iln.12;
 Tue, 10 Dec 2019 11:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ir2OHURJgyd1utg6eQ0vao/9jZEovfcbKpNA4WxrXQE=;
 b=vS1r0KBqJBA0KkXC9R6Gj/Lk3TsRXyzJZNHTMZrQWNIes9KkdOTBjHurTY+NdnUUOc
 fCFDFTd9miTtWhLWWcis4/DA/SK/YoMWOhXlUvsBk5sqI2rjgo9KsW5PfQng5NVIKVD6
 5Y/X1pvGGxf2O2g0QW32yhX0/np9lXeC8dwO2/KVTI1NYpR2spKI1vTSckTdtoOenatn
 jFbaFtQ5W0hgfLU2QMCQAdRkChosrMQaMKkmsDhSFcbMUehfHYC7IdUaMpD3uiJxRpIX
 xhtsG5+jtdmTSPf+CQNQDiGdeRKss/IOb6DEPAtrGhi6iOFtIUyAA0kvtk3Itf5jeImG
 Irjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ir2OHURJgyd1utg6eQ0vao/9jZEovfcbKpNA4WxrXQE=;
 b=JbWYO0FDBx64Ln9J0LrymHn9a21RENGuj3U9pc/ZrDYU7zZoMJU42tPefPlca4rPMy
 1XgeFClp0M8gbBjnW4QqNM+D6b5oRDu3xUwNDTsKM5wy9J0UoxgwQrm5pFJmy8NkPkto
 0kZ6BUNmjH5g4iEfn7xuYT6L+IfVJAO3nY8wpm400OmNMse6JXwZdL3U7u1m9vZRSBYT
 g9B+SKy3tDhNBdE1l0BM2Dq8xKwUp0odgV1n3q1UJMs6aX5vbllr4AxckcQOyFe/FdlK
 8/w3JF1i6UlkqbTav3T11V4eSisfDJW/PpnDUwbr5J9l1H2qN2tBy4G31xFLBc/OVBU3
 q4vQ==
X-Gm-Message-State: APjAAAUhRiBviqTYmS3Ypy9iRSePLuh8I8fo7eRITxTH65JlSqbYgTcS
 Y4YSGg/Lre5qH0+jEZTbO8u6fyv/Lh5A246D4Hg=
X-Google-Smtp-Source: APXvYqzgtN8tv6RKkQK2hIcwTx/XrI10X2jTUbCvL2w+pD3tAGg13w3eLXs6jc8bT6ZOSghkwMDr8H8dvcM7KBB9P1c=
X-Received: by 2002:a92:d203:: with SMTP id y3mr4220515ily.28.1576005113295;
 Tue, 10 Dec 2019 11:11:53 -0800 (PST)
MIME-Version: 1.0
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-5-nieklinnenbank@gmail.com>
 <4a900e8d-d803-5c58-5a4b-879cce5970b4@redhat.com>
 <20191210082932.teizmu3nco3ndjel@sirius.home.kraxel.org>
In-Reply-To: <20191210082932.teizmu3nco3ndjel@sirius.home.kraxel.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Tue, 10 Dec 2019 20:11:42 +0100
Message-ID: <CAPan3Wr5u7MAwL-pYX9KmMZmU7fDA_YLtxWuELPWOru9e7DmmA@mail.gmail.com>
Subject: Re: [PATCH 04/10] arm: allwinner-h3: add USB host controller
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f13ae605995e48fa"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::141
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f13ae605995e48fa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gerd,

On Tue, Dec 10, 2019 at 9:29 AM Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Tue, Dec 10, 2019 at 08:56:02AM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > On 12/2/19 10:09 PM, Niek Linnenbank wrote:
> > > The Allwinner H3 System on Chip contains multiple USB 2.0 bus
> > > connections which provide software access using the Enhanced
> > > Host Controller Interface (EHCI) and Open Host Controller
> > > Interface (OHCI) interfaces. This commit adds support for
> > > both interfaces in the Allwinner H3 System on Chip.
> > >
> > > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> > > ---
> > >   hw/arm/allwinner-h3.c    | 20 ++++++++++++++++++++
> > >   hw/usb/hcd-ehci-sysbus.c | 17 +++++++++++++++++
> > >   hw/usb/hcd-ehci.h        |  1 +
> >
> > Cc'ing Gerd, the maintainer of these files.
>
> Looks all reasonable.
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
>
> (assuming this will be merged through arm tree not usb).
>

Thanks for reviewing! I'll add the tag to the commit message.

Regards,
Niek

>
> >
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >
> > >   3 files changed, 38 insertions(+)
> > >
> > > diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> > > index 5566e979ec..afeb49c0ac 100644
> > > --- a/hw/arm/allwinner-h3.c
> > > +++ b/hw/arm/allwinner-h3.c
> > > @@ -26,6 +26,7 @@
> > >   #include "hw/sysbus.h"
> > >   #include "hw/arm/allwinner-h3.h"
> > >   #include "hw/misc/unimp.h"
> > > +#include "hw/usb/hcd-ehci.h"
> > >   #include "sysemu/sysemu.h"
> > >   static void aw_h3_init(Object *obj)
> > > @@ -183,6 +184,25 @@ static void aw_h3_realize(DeviceState *dev, Erro=
r
> **errp)
> > >       }
> > >       sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, AW_H3_CCU_BASE);
> > > +    /* Universal Serial Bus */
> > > +    sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI0_BASE,
> > > +                         s->irq[AW_H3_GIC_SPI_EHCI0]);
> > > +    sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI1_BASE,
> > > +                         s->irq[AW_H3_GIC_SPI_EHCI1]);
> > > +    sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI2_BASE,
> > > +                         s->irq[AW_H3_GIC_SPI_EHCI2]);
> > > +    sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI3_BASE,
> > > +                         s->irq[AW_H3_GIC_SPI_EHCI3]);
> > > +
> > > +    sysbus_create_simple("sysbus-ohci", AW_H3_OHCI0_BASE,
> > > +                         s->irq[AW_H3_GIC_SPI_OHCI0]);
> > > +    sysbus_create_simple("sysbus-ohci", AW_H3_OHCI1_BASE,
> > > +                         s->irq[AW_H3_GIC_SPI_OHCI1]);
> > > +    sysbus_create_simple("sysbus-ohci", AW_H3_OHCI2_BASE,
> > > +                         s->irq[AW_H3_GIC_SPI_OHCI2]);
> > > +    sysbus_create_simple("sysbus-ohci", AW_H3_OHCI3_BASE,
> > > +                         s->irq[AW_H3_GIC_SPI_OHCI3]);
> > > +
> > >       /* UART */
> > >       if (serial_hd(0)) {
> > >           serial_mm_init(get_system_memory(), AW_H3_UART0_REG_BASE, 2=
,
> > > diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
> > > index 020211fd10..174c3446ef 100644
> > > --- a/hw/usb/hcd-ehci-sysbus.c
> > > +++ b/hw/usb/hcd-ehci-sysbus.c
> > > @@ -145,6 +145,22 @@ static const TypeInfo ehci_exynos4210_type_info =
=3D
> {
> > >       .class_init    =3D ehci_exynos4210_class_init,
> > >   };
> > > +static void ehci_aw_h3_class_init(ObjectClass *oc, void *data)
> > > +{
> > > +    SysBusEHCIClass *sec =3D SYS_BUS_EHCI_CLASS(oc);
> > > +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> > > +
> > > +    sec->capsbase =3D 0x0;
> > > +    sec->opregbase =3D 0x10;
> > > +    set_bit(DEVICE_CATEGORY_USB, dc->categories);
> > > +}
> > > +
> > > +static const TypeInfo ehci_aw_h3_type_info =3D {
> > > +    .name          =3D TYPE_AW_H3_EHCI,
> > > +    .parent        =3D TYPE_SYS_BUS_EHCI,
> > > +    .class_init    =3D ehci_aw_h3_class_init,
> > > +};
> > > +
> > >   static void ehci_tegra2_class_init(ObjectClass *oc, void *data)
> > >   {
> > >       SysBusEHCIClass *sec =3D SYS_BUS_EHCI_CLASS(oc);
> > > @@ -267,6 +283,7 @@ static void ehci_sysbus_register_types(void)
> > >       type_register_static(&ehci_platform_type_info);
> > >       type_register_static(&ehci_xlnx_type_info);
> > >       type_register_static(&ehci_exynos4210_type_info);
> > > +    type_register_static(&ehci_aw_h3_type_info);
> > >       type_register_static(&ehci_tegra2_type_info);
> > >       type_register_static(&ehci_ppc4xx_type_info);
> > >       type_register_static(&ehci_fusbh200_type_info);
> > > diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
> > > index 0298238f0b..edb59311c4 100644
> > > --- a/hw/usb/hcd-ehci.h
> > > +++ b/hw/usb/hcd-ehci.h
> > > @@ -342,6 +342,7 @@ typedef struct EHCIPCIState {
> > >   #define TYPE_SYS_BUS_EHCI "sysbus-ehci-usb"
> > >   #define TYPE_PLATFORM_EHCI "platform-ehci-usb"
> > >   #define TYPE_EXYNOS4210_EHCI "exynos4210-ehci-usb"
> > > +#define TYPE_AW_H3_EHCI "aw-h3-ehci-usb"
> > >   #define TYPE_TEGRA2_EHCI "tegra2-ehci-usb"
> > >   #define TYPE_PPC4xx_EHCI "ppc4xx-ehci-usb"
> > >   #define TYPE_FUSBH200_EHCI "fusbh200-ehci-usb"
> > >
> >
>
>

--=20
Niek Linnenbank

--000000000000f13ae605995e48fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi Gerd,</div><div><br></div></div><=
div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec=
 10, 2019 at 9:29 AM Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com"=
>kraxel@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">On Tue, Dec 10, 2019 at 08:56:02AM +0100, Philippe Mathie=
u-Daud=C3=A9 wrote:<br>
&gt; On 12/2/19 10:09 PM, Niek Linnenbank wrote:<br>
&gt; &gt; The Allwinner H3 System on Chip contains multiple USB 2.0 bus<br>
&gt; &gt; connections which provide software access using the Enhanced<br>
&gt; &gt; Host Controller Interface (EHCI) and Open Host Controller<br>
&gt; &gt; Interface (OHCI) interfaces. This commit adds support for<br>
&gt; &gt; both interfaces in the Allwinner H3 System on Chip.<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenba=
nk@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 =C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 | 20 +++++++++++++=
+++++++<br>
&gt; &gt;=C2=A0 =C2=A0hw/usb/hcd-ehci-sysbus.c | 17 +++++++++++++++++<br>
&gt; &gt;=C2=A0 =C2=A0hw/usb/hcd-ehci.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
1 +<br>
&gt; <br>
&gt; Cc&#39;ing Gerd, the maintainer of these files.<br>
<br>
Looks all reasonable.<br>
Reviewed-by: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=
=3D"_blank">kraxel@redhat.com</a>&gt;<br>
<br>
(assuming this will be merged through arm tree not usb).<br></blockquote><d=
iv><br></div><div>Thanks for reviewing! I&#39;ll add the tag to the commit =
message.</div><div><br></div><div>Regards,</div><div>Niek<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@=
redhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
&gt; <br>
&gt; &gt;=C2=A0 =C2=A03 files changed, 38 insertions(+)<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c<br>
&gt; &gt; index 5566e979ec..afeb49c0ac 100644<br>
&gt; &gt; --- a/hw/arm/allwinner-h3.c<br>
&gt; &gt; +++ b/hw/arm/allwinner-h3.c<br>
&gt; &gt; @@ -26,6 +26,7 @@<br>
&gt; &gt;=C2=A0 =C2=A0#include &quot;hw/sysbus.h&quot;<br>
&gt; &gt;=C2=A0 =C2=A0#include &quot;hw/arm/allwinner-h3.h&quot;<br>
&gt; &gt;=C2=A0 =C2=A0#include &quot;hw/misc/unimp.h&quot;<br>
&gt; &gt; +#include &quot;hw/usb/hcd-ehci.h&quot;<br>
&gt; &gt;=C2=A0 =C2=A0#include &quot;sysemu/sysemu.h&quot;<br>
&gt; &gt;=C2=A0 =C2=A0static void aw_h3_init(Object *obj)<br>
&gt; &gt; @@ -183,6 +184,25 @@ static void aw_h3_realize(DeviceState *dev, =
Error **errp)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&=
gt;ccu), 0, AW_H3_CCU_BASE);<br>
&gt; &gt; +=C2=A0 =C2=A0 /* Universal Serial Bus */<br>
&gt; &gt; +=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI0_=
BASE,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;irq[AW_H3_GIC_SPI_EHCI0]);<br>
&gt; &gt; +=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI1_=
BASE,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;irq[AW_H3_GIC_SPI_EHCI1]);<br>
&gt; &gt; +=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI2_=
BASE,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;irq[AW_H3_GIC_SPI_EHCI2]);<br>
&gt; &gt; +=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI3_=
BASE,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;irq[AW_H3_GIC_SPI_EHCI3]);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, AW_H=
3_OHCI0_BASE,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;irq[AW_H3_GIC_SPI_OHCI0]);<br>
&gt; &gt; +=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, AW_H=
3_OHCI1_BASE,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;irq[AW_H3_GIC_SPI_OHCI1]);<br>
&gt; &gt; +=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, AW_H=
3_OHCI2_BASE,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;irq[AW_H3_GIC_SPI_OHCI2]);<br>
&gt; &gt; +=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, AW_H=
3_OHCI3_BASE,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;irq[AW_H3_GIC_SPI_OHCI3]);<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* UART */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (serial_hd(0)) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0serial_mm_init(get_system=
_memory(), AW_H3_UART0_REG_BASE, 2,<br>
&gt; &gt; diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c<=
br>
&gt; &gt; index 020211fd10..174c3446ef 100644<br>
&gt; &gt; --- a/hw/usb/hcd-ehci-sysbus.c<br>
&gt; &gt; +++ b/hw/usb/hcd-ehci-sysbus.c<br>
&gt; &gt; @@ -145,6 +145,22 @@ static const TypeInfo ehci_exynos4210_type_i=
nfo =3D {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.class_init=C2=A0 =C2=A0 =3D ehci_exyno=
s4210_class_init,<br>
&gt; &gt;=C2=A0 =C2=A0};<br>
&gt; &gt; +static void ehci_aw_h3_class_init(ObjectClass *oc, void *data)<b=
r>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 SysBusEHCIClass *sec =3D SYS_BUS_EHCI_CLASS(oc);<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(oc);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 sec-&gt;capsbase =3D 0x0;<br>
&gt; &gt; +=C2=A0 =C2=A0 sec-&gt;opregbase =3D 0x10;<br>
&gt; &gt; +=C2=A0 =C2=A0 set_bit(DEVICE_CATEGORY_USB, dc-&gt;categories);<b=
r>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static const TypeInfo ehci_aw_h3_type_info =3D {<br>
&gt; &gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_A=
W_H3_EHCI,<br>
&gt; &gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BU=
S_EHCI,<br>
&gt; &gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D ehci_aw_h3_class_init=
,<br>
&gt; &gt; +};<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0static void ehci_tegra2_class_init(ObjectClass *oc, v=
oid *data)<br>
&gt; &gt;=C2=A0 =C2=A0{<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0SysBusEHCIClass *sec =3D SYS_BUS_EHCI_C=
LASS(oc);<br>
&gt; &gt; @@ -267,6 +283,7 @@ static void ehci_sysbus_register_types(void)<=
br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0type_register_static(&amp;ehci_platform=
_type_info);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0type_register_static(&amp;ehci_xlnx_typ=
e_info);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0type_register_static(&amp;ehci_exynos42=
10_type_info);<br>
&gt; &gt; +=C2=A0 =C2=A0 type_register_static(&amp;ehci_aw_h3_type_info);<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0type_register_static(&amp;ehci_tegra2_t=
ype_info);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0type_register_static(&amp;ehci_ppc4xx_t=
ype_info);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0type_register_static(&amp;ehci_fusbh200=
_type_info);<br>
&gt; &gt; diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h<br>
&gt; &gt; index 0298238f0b..edb59311c4 100644<br>
&gt; &gt; --- a/hw/usb/hcd-ehci.h<br>
&gt; &gt; +++ b/hw/usb/hcd-ehci.h<br>
&gt; &gt; @@ -342,6 +342,7 @@ typedef struct EHCIPCIState {<br>
&gt; &gt;=C2=A0 =C2=A0#define TYPE_SYS_BUS_EHCI &quot;sysbus-ehci-usb&quot;=
<br>
&gt; &gt;=C2=A0 =C2=A0#define TYPE_PLATFORM_EHCI &quot;platform-ehci-usb&qu=
ot;<br>
&gt; &gt;=C2=A0 =C2=A0#define TYPE_EXYNOS4210_EHCI &quot;exynos4210-ehci-us=
b&quot;<br>
&gt; &gt; +#define TYPE_AW_H3_EHCI &quot;aw-h3-ehci-usb&quot;<br>
&gt; &gt;=C2=A0 =C2=A0#define TYPE_TEGRA2_EHCI &quot;tegra2-ehci-usb&quot;<=
br>
&gt; &gt;=C2=A0 =C2=A0#define TYPE_PPC4xx_EHCI &quot;ppc4xx-ehci-usb&quot;<=
br>
&gt; &gt;=C2=A0 =C2=A0#define TYPE_FUSBH200_EHCI &quot;fusbh200-ehci-usb&qu=
ot;<br>
&gt; &gt; <br>
&gt; <br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000f13ae605995e48fa--

