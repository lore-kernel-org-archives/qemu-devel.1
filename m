Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD406C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 01:12:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA5BE2086D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 01:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULLEbZyE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5BE2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIN0E-0006I2-SI
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 21:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iIMzS-0005eY-PA
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 21:11:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iIMzR-0004pU-Gk
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 21:11:38 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41677)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>)
 id 1iIMzR-0004pL-BW; Wed, 09 Oct 2019 21:11:37 -0400
Received: by mail-ot1-x341.google.com with SMTP id g13so3404866otp.8;
 Wed, 09 Oct 2019 18:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hgCuZRL1iytUlmLyo+VV4QeDefvrzVM1LT7oPicDtvY=;
 b=ULLEbZyECT+hWsyCIJ88qsenyUXn2HAQFsUsblZGplOehTeunyOgZSSpk7Y+uVLk5I
 C28UANTITB4vtM1/AqxOryyvDJGSGPdUW9SvYubG6f2tQ7cBwLVsttgwaUiXaIw9MIcN
 tuuv2WhtSyQ7YNo58uVBVZGaYKkSwm7YMLH54VbiOrobDOQsPt8HjwKzrLoChWdyZqU6
 ONcPJvw+u2T0fsvpTNWulBMtfBIoE7InTVcKtwhyqFp8kh9qF7fNa4haTZ0onik/T+dj
 FoWCZ6oFpmSd2bpmvXebb+OpWbqZOJgg9/Qr/eQeiedCVzQVa/x/WlMy+5mEXGtFEm/A
 H5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hgCuZRL1iytUlmLyo+VV4QeDefvrzVM1LT7oPicDtvY=;
 b=SdNqfpsuJuN93G44sLW9puOxnjnprE/mtGmWHqsCNQu2gPk72CTNVoHnS1CMyuZqT+
 bPUzEtHPR/RPCqU0OswMkUgJHBX2mmXmCISCPRjuX1knZacnhppmV4/SYztnOx245kxt
 F7eyscjVRenM34iUUZ5BiqbPnNyah8H6He7KZQhHJrUhNX5jectNbGpZYIe5CONocco+
 FFbJet0XLDD1cjtB3bh47WQlS5395ZnjkLbKV8JskiY8/XK6Q5LVmTQ9HzSTLpWCEyWB
 RhPacAQ+hP1uToV4MKyvQIPuvQWAcq3ikkk6BzU2tEAR6WfF7Cl/aHT/fIIupf+n4UgI
 Kp1w==
X-Gm-Message-State: APjAAAV3Fn1zr/rGZREPkA0+y2DjGJwdsb+6s3Q7XaOX6Unc/nBIRFaL
 ZYJK343oEh3G9OgfkeT808LubW4krxLcuHMv41Y=
X-Google-Smtp-Source: APXvYqz95HTEK7YURQ7APkuJXtxmB+zqgvgxoalDr0rwu7UCYQu/uBQPlDNPtMqGLgio0AqhdaIwFXD5rau6U6nSTGE=
X-Received: by 2002:a9d:6d11:: with SMTP id o17mr2302464otp.333.1570669896283; 
 Wed, 09 Oct 2019 18:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191008142539.7793-1-philmd@redhat.com>
 <20191008142539.7793-6-philmd@redhat.com>
In-Reply-To: <20191008142539.7793-6-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 10 Oct 2019 09:10:59 +0800
Message-ID: <CAKXe6SLKroySEwOEasUQt0FNEgok-Upeb_aBop_Enrae7O1fTg@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] hw/ide/via82c: Convert reset handler to DeviceReset
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003a3ac305948415ad"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Qemu Developers <qemu-devel@nongnu.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003a3ac305948415ad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B410=E6=
=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:36=E5=86=99=E9=81=
=93=EF=BC=9A

> The VIA82C686B IDE controller is a PCI device, it will be reset
> when the PCI bus it stands on is reset.
>
> Convert its reset handler into a proper Device reset method.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>

Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  hw/ide/via.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/hw/ide/via.c b/hw/ide/via.c
> index 7087dc676e..053622bd82 100644
> --- a/hw/ide/via.c
> +++ b/hw/ide/via.c
> @@ -29,7 +29,6 @@
>  #include "migration/vmstate.h"
>  #include "qemu/module.h"
>  #include "sysemu/dma.h"
> -#include "sysemu/reset.h"
>
>  #include "hw/ide/pci.h"
>  #include "trace.h"
> @@ -120,10 +119,10 @@ static void via_ide_set_irq(void *opaque, int n, in=
t
> level)
>      }
>  }
>
> -static void via_ide_reset(void *opaque)
> +static void via_ide_reset(DeviceState *dev)
>  {
> -    PCIIDEState *d =3D opaque;
> -    PCIDevice *pd =3D PCI_DEVICE(d);
> +    PCIIDEState *d =3D PCI_IDE(dev);
> +    PCIDevice *pd =3D PCI_DEVICE(dev);
>      uint8_t *pci_conf =3D pd->config;
>      int i;
>
> @@ -172,8 +171,6 @@ static void via_ide_realize(PCIDevice *dev, Error
> **errp)
>      pci_set_long(pci_conf + PCI_CAPABILITY_LIST, 0x000000c0);
>      dev->wmask[PCI_INTERRUPT_LINE] =3D 0xf;
>
> -    qemu_register_reset(via_ide_reset, d);
> -
>      memory_region_init_io(&d->data_bar[0], OBJECT(d),
> &pci_ide_data_le_ops,
>                            &d->bus[0], "via-ide0-data", 8);
>      pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &d->data_bar[0])=
;
> @@ -229,6 +226,7 @@ static void via_ide_class_init(ObjectClass *klass,
> void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
>
> +    dc->reset =3D via_ide_reset;
>      k->realize =3D via_ide_realize;
>      k->exit =3D via_ide_exitfn;
>      k->vendor_id =3D PCI_VENDOR_ID_VIA;
> --
> 2.21.0
>
>
>

--0000000000003a3ac305948415ad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =E4=BA=8E2019=E5=
=B9=B410=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:36=E5=86=
=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">The VIA82C686B IDE controller is a PCI device, it will be reset<br>
when the PCI bus it stands on is reset.<br>
<br>
Convert its reset handler into a proper Device reset method.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br></blockquote><div><=
br></div><div>Reviewed-by: Li Qiang &lt;<a href=3D"mailto:liq3ea@gmail.com"=
 target=3D"_blank">liq3ea@gmail.com</a>&gt;<br></div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0hw/ide/via.c | 10 ++++------<br>
=C2=A01 file changed, 4 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/hw/ide/via.c b/hw/ide/via.c<br>
index 7087dc676e..053622bd82 100644<br>
--- a/hw/ide/via.c<br>
+++ b/hw/ide/via.c<br>
@@ -29,7 +29,6 @@<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
=C2=A0#include &quot;sysemu/dma.h&quot;<br>
-#include &quot;sysemu/reset.h&quot;<br>
<br>
=C2=A0#include &quot;hw/ide/pci.h&quot;<br>
=C2=A0#include &quot;trace.h&quot;<br>
@@ -120,10 +119,10 @@ static void via_ide_set_irq(void *opaque, int n, int =
level)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static void via_ide_reset(void *opaque)<br>
+static void via_ide_reset(DeviceState *dev)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 PCIIDEState *d =3D opaque;<br>
-=C2=A0 =C2=A0 PCIDevice *pd =3D PCI_DEVICE(d);<br>
+=C2=A0 =C2=A0 PCIIDEState *d =3D PCI_IDE(dev);<br>
+=C2=A0 =C2=A0 PCIDevice *pd =3D PCI_DEVICE(dev);<br>
=C2=A0 =C2=A0 =C2=A0uint8_t *pci_conf =3D pd-&gt;config;<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
<br>
@@ -172,8 +171,6 @@ static void via_ide_realize(PCIDevice *dev, Error **err=
p)<br>
=C2=A0 =C2=A0 =C2=A0pci_set_long(pci_conf + PCI_CAPABILITY_LIST, 0x000000c0=
);<br>
=C2=A0 =C2=A0 =C2=A0dev-&gt;wmask[PCI_INTERRUPT_LINE] =3D 0xf;<br>
<br>
-=C2=A0 =C2=A0 qemu_register_reset(via_ide_reset, d);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0memory_region_init_io(&amp;d-&gt;data_bar[0], OBJECT(d)=
, &amp;pci_ide_data_le_ops,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;d-&gt;bus[0], &quot;via-ide0-data&quot;, 8);<b=
r>
=C2=A0 =C2=A0 =C2=A0pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &am=
p;d-&gt;data_bar[0]);<br>
@@ -229,6 +226,7 @@ static void via_ide_class_init(ObjectClass *klass, void=
 *data)<br>
=C2=A0 =C2=A0 =C2=A0DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
=C2=A0 =C2=A0 =C2=A0PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);<br>
<br>
+=C2=A0 =C2=A0 dc-&gt;reset =3D via_ide_reset;<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;realize =3D via_ide_realize;<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;exit =3D via_ide_exitfn;<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;vendor_id =3D PCI_VENDOR_ID_VIA;<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote></div></div>

--0000000000003a3ac305948415ad--

