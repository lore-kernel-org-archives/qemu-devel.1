Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6234C4360C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 01:10:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E436206C2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 01:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JD4dGOD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E436206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iI0UL-0002Lh-PR
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 21:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iI0TJ-0001Vn-Fx
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iI0TI-00012d-3A
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:08:57 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37101)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>)
 id 1iI0TH-00012W-Tl; Tue, 08 Oct 2019 21:08:56 -0400
Received: by mail-oi1-x243.google.com with SMTP id i16so371395oie.4;
 Tue, 08 Oct 2019 18:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Qa0hiKGQ1LdAXEe+gYjM+shYjUAw3dBrIwlAh0NC/L4=;
 b=JD4dGOD2QT2lhijBCyN6zEg/oE0zUOGa3vJb5lSgdbP0V4XFUv3riGK0iRyoNiVKwb
 xFQgjI9H+V1Xs+ECjbTyRoQ4tVnQ862mUj9S3Ommg2mtO9DuihJ9rnYMNbTAVXl8SaUR
 ljX43we1z68IE3YQi2msRO5rdRbYGnUB6hifgonpTx5eN/5Q07vFUYwiYqe7RNHzAcUR
 2zTRo7RKUZgH3OAFkpKopb5Z67ZaVSSd+0ja4J7KDXyKlMamhy1KisSfFGej3ZGhiFVu
 iZdO3XIhbwVKMRWVk5S1ZdeCZSPpntbDzMDaaV0knG4DxoBRhszNo8GJymw84PBbVoqo
 U4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Qa0hiKGQ1LdAXEe+gYjM+shYjUAw3dBrIwlAh0NC/L4=;
 b=p3WWGzLBO0Uxbir+ymJj56YJDCWWuRfoEZUTnDFlme7F+SIUFJbDFYSwX21WZlKBKV
 YxP0sTnmzfSg9O2DbT9SjY1aWYOGLgvK9Mspow3SrTLqFyQnglt3kQ6V7bvpGpcRT8m+
 jlPcc0TxdBhCfsNzEtnjbPtxYVCXLyDp2M4s9CkG4SgB7BDB1JLcuGchULCvNcqzQGBR
 PdayB3li/0B2wrLWSJqthJoSaRtHxmWIgI/6BuKVIpvJhy9juw5R7nsAWBeO1wNytitl
 uDJ1RuOAz5PB/GnFdJsirSJSYGYoPmsWLdessRcCr+FcRfRH3IAkD22/sVIgvR6x6VyB
 gFvg==
X-Gm-Message-State: APjAAAWmMAlkyLsffe2zRjLI28SbKsJszgr9bMizhq9OwkJu2KMDXr2p
 cfJEOJz/3GA4bJtwXDAehVQE4gBiV4yTlcFVKl4=
X-Google-Smtp-Source: APXvYqwUiRpbgr4QrDAD5Sx5tqbS2NlHm+PxxQH5xnE6JhPvip8bMNrAJe2kfI/6XV19Bpc8QlgyCDiQDFVUvF8O+Cw=
X-Received: by 2002:aca:f1d7:: with SMTP id p206mr377192oih.97.1570583335172; 
 Tue, 08 Oct 2019 18:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191008142539.7793-1-philmd@redhat.com>
 <20191008142539.7793-4-philmd@redhat.com>
In-Reply-To: <20191008142539.7793-4-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 9 Oct 2019 09:08:18 +0800
Message-ID: <CAKXe6SJae07AS4OGaBt-WJoxCRpxZNGrOhfy1r68BfGK6wE5xQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] hw/ide/piix: Convert reset handler to DeviceReset
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c87f7505946fedef"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

--000000000000c87f7505946fedef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B410=E6=
=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:32=E5=86=99=E9=81=
=93=EF=BC=9A

> The PIIX3/IDE is a PCI device within the PIIX3 chipset, it will be reset
> when the PCI bus it stands on is reset.
>
> Convert its reset handler into a proper Device reset method.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/ide/piix.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/hw/ide/piix.c b/hw/ide/piix.c
> index fba6bc8bff..18b2c3b722 100644
> --- a/hw/ide/piix.c
> +++ b/hw/ide/piix.c
> @@ -30,7 +30,6 @@
>  #include "sysemu/block-backend.h"
>  #include "sysemu/blockdev.h"
>  #include "sysemu/dma.h"
> -#include "sysemu/reset.h"
>
>  #include "hw/ide/pci.h"
>  #include "trace.h"
> @@ -103,9 +102,9 @@ static void bmdma_setup_bar(PCIIDEState *d)
>      }
>  }
>
> -static void piix3_reset(void *opaque)
> +static void piix3_ide_reset(DeviceState *dev)
>  {
> -    PCIIDEState *d =3D opaque;
> +    PCIIDEState *d =3D PCI_IDE(dev);
>      PCIDevice *pd =3D PCI_DEVICE(d);
>      uint8_t *pci_conf =3D pd->config;
>      int i;
> @@ -154,8 +153,6 @@ static void pci_piix_ide_realize(PCIDevice *dev, Erro=
r
> **errp)
>
>      pci_conf[PCI_CLASS_PROG] =3D 0x80; // legacy ATA mode
>
> -    qemu_register_reset(piix3_reset, d);
> -
>      bmdma_setup_bar(d);
>      pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, &d->bmdma_bar);
>
> @@ -247,6 +244,7 @@ static void piix3_ide_class_init(ObjectClass *klass,
> void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
>
> +    dc->reset =3D piix3_ide_reset;
>      k->realize =3D pci_piix_ide_realize;
>      k->exit =3D pci_piix_ide_exitfn;
>      k->vendor_id =3D PCI_VENDOR_ID_INTEL;
> --
>


Shouldn't we also add the reset callback for piix4 ide device?

Thanks,
Li Qiang



> 2.21.0
>
>
>

--000000000000c87f7505946fedef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =E4=BA=8E2019=E5=
=B9=B410=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:32=E5=86=
=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">The PIIX3/IDE is a PCI device within the PIIX3 chipset, it will be re=
set<br>
when the PCI bus it stands on is reset.<br>
<br>
Convert its reset handler into a proper Device reset method.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/ide/piix.c | 8 +++-----<br>
=C2=A01 file changed, 3 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/hw/ide/piix.c b/hw/ide/piix.c<br>
index fba6bc8bff..18b2c3b722 100644<br>
--- a/hw/ide/piix.c<br>
+++ b/hw/ide/piix.c<br>
@@ -30,7 +30,6 @@<br>
=C2=A0#include &quot;sysemu/block-backend.h&quot;<br>
=C2=A0#include &quot;sysemu/blockdev.h&quot;<br>
=C2=A0#include &quot;sysemu/dma.h&quot;<br>
-#include &quot;sysemu/reset.h&quot;<br>
<br>
=C2=A0#include &quot;hw/ide/pci.h&quot;<br>
=C2=A0#include &quot;trace.h&quot;<br>
@@ -103,9 +102,9 @@ static void bmdma_setup_bar(PCIIDEState *d)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static void piix3_reset(void *opaque)<br>
+static void piix3_ide_reset(DeviceState *dev)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 PCIIDEState *d =3D opaque;<br>
+=C2=A0 =C2=A0 PCIIDEState *d =3D PCI_IDE(dev);<br>
=C2=A0 =C2=A0 =C2=A0PCIDevice *pd =3D PCI_DEVICE(d);<br>
=C2=A0 =C2=A0 =C2=A0uint8_t *pci_conf =3D pd-&gt;config;<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
@@ -154,8 +153,6 @@ static void pci_piix_ide_realize(PCIDevice *dev, Error =
**errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0pci_conf[PCI_CLASS_PROG] =3D 0x80; // legacy ATA mode<b=
r>
<br>
-=C2=A0 =C2=A0 qemu_register_reset(piix3_reset, d);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0bmdma_setup_bar(d);<br>
=C2=A0 =C2=A0 =C2=A0pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, &am=
p;d-&gt;bmdma_bar);<br>
<br>
@@ -247,6 +244,7 @@ static void piix3_ide_class_init(ObjectClass *klass, vo=
id *data)<br>
=C2=A0 =C2=A0 =C2=A0DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
=C2=A0 =C2=A0 =C2=A0PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);<br>
<br>
+=C2=A0 =C2=A0 dc-&gt;reset =3D piix3_ide_reset;<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;realize =3D pci_piix_ide_realize;<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;exit =3D pci_piix_ide_exitfn;<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;vendor_id =3D PCI_VENDOR_ID_INTEL;<br>
-- <br></blockquote><div><br></div><div><br></div><div>Shouldn&#39;t we als=
o add the reset callback for piix4 ide device?</div><div><br></div><div>Tha=
nks,</div><div>Li Qiang</div><div><br></div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
2.21.0<br>
<br>
<br>
</blockquote></div></div>

--000000000000c87f7505946fedef--

