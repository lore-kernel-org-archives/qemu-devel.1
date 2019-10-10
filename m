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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44040C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 01:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E8442086D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 01:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ino9JGfG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8442086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIMxp-0004wm-8g
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 21:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iIMwp-0004Kv-0A
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 21:08:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iIMwn-00041C-ON
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 21:08:54 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41658)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>)
 id 1iIMwn-00040o-JO; Wed, 09 Oct 2019 21:08:53 -0400
Received: by mail-ot1-x342.google.com with SMTP id g13so3400546otp.8;
 Wed, 09 Oct 2019 18:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cQgKqo4Zm+d2yvn/nXV1xi2A6NAmW83+V/vyQ+Oucws=;
 b=Ino9JGfGZdJZfuvKy6iV1hJD2wn46PWx+YUb3Bd5zFzIzP2J1P/y12KVskBtIfcdTD
 wkglYPI5nK3PofEbDshRPO+O7mnqjyeQ7ptGg2sTDmoSKFxiG7KoEHJk+pj6hE6CozKA
 L1FZH7ZOfYBb0qEoqkCeYULejYSHrwJOltFqU3dNVrtRu95SkMPFQkyde3HaxFAyyUBO
 2KtDI/FFJBM9saK7kdOOZOA5RYjcvv11Z+esGmrVbfz5hj0jdPjBAnpznVHiOHsqfyCt
 6ItZBq2s6oS/UxSzXe05I8qo8TYucfeDUs20v6SNh1nJb+te2Ym4gGQLm7Ib6M44+MIN
 x2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cQgKqo4Zm+d2yvn/nXV1xi2A6NAmW83+V/vyQ+Oucws=;
 b=pag56Bi+dL2N26VXFP7F1ffG/Z7GroqjhENhoIo8TUIEw9jUA8osNBLFv/5kevFbJi
 W03bylrPG+f8KZJuCTID1W9qtWrl4pbm1uhzDLMkSkefRelc8K9zuqPUksOX/7A9WE3S
 VrP0i2W4xfmwa8aKeql76YzDq9ldfKeA59YUjV0qdK4iAnw14FakBHKnv5FeSD0FrM1t
 qLSr3WqY8iTOU23OZyzMtnsH1JmlVkefFOo3rzS/Mh+yuw4IfJ19WPSHsA0HxF04q/xR
 6KfCPNm888RTPPHxwI3R8V+3KC5Bmx0BLFuiV3k63N3PYLfp+LOdi/oDgJ1ZANkovvzU
 Jgpw==
X-Gm-Message-State: APjAAAVjpdOifuRdLDyE5dW6RkN5r1ZTzANtx18ZiRSfvZDvneqry2lz
 JBYMnp8IDbGKs3cpavnSLI9TIGDYVgahxRon1Ew=
X-Google-Smtp-Source: APXvYqw1EyoaK1rhWhD3a15CnZPdDw8y7Ou3jVg9ijh/ZarrQMLiOcWEQjmaTtZ9Xg7lsrXpvP0W6S71HVnXPYlkaS4=
X-Received: by 2002:a9d:6c96:: with SMTP id c22mr5538314otr.194.1570669732810; 
 Wed, 09 Oct 2019 18:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191008142539.7793-1-philmd@redhat.com>
 <20191008142539.7793-5-philmd@redhat.com>
In-Reply-To: <20191008142539.7793-5-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 10 Oct 2019 09:08:16 +0800
Message-ID: <CAKXe6SJZfW450Jv-=62Y1=1sACsa7gFXuy01pRgOt3e__YsPBA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] hw/ide/sii3112: Convert reset handler to
 DeviceReset
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007bd5f30594840b57"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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

--0000000000007bd5f30594840b57
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B410=E6=
=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:32=E5=86=99=E9=81=
=93=EF=BC=9A

> The SiI3112A SATA controller is a PCI device, it will be reset
> when the PCI bus it stands on is reset.
>
> Convert its reset handler into a proper Device reset method.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>

Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  hw/ide/sii3112.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
> index 2181260531..06605d7af2 100644
> --- a/hw/ide/sii3112.c
> +++ b/hw/ide/sii3112.c
> @@ -15,7 +15,6 @@
>  #include "qemu/osdep.h"
>  #include "hw/ide/pci.h"
>  #include "qemu/module.h"
> -#include "sysemu/reset.h"
>  #include "trace.h"
>
>  #define TYPE_SII3112_PCI "sii3112"
> @@ -237,9 +236,9 @@ static void sii3112_set_irq(void *opaque, int channel=
,
> int level)
>      sii3112_update_irq(s);
>  }
>
> -static void sii3112_reset(void *opaque)
> +static void sii3112_reset(DeviceState *dev)
>  {
> -    SiI3112PCIState *s =3D opaque;
> +    SiI3112PCIState *s =3D SII3112_PCI(dev);
>      int i;
>
>      for (i =3D 0; i < 2; i++) {
> @@ -290,7 +289,6 @@ static void sii3112_pci_realize(PCIDevice *dev, Error
> **errp)
>          s->bmdma[i].bus =3D &s->bus[i];
>          ide_register_restart_cb(&s->bus[i]);
>      }
> -    qemu_register_reset(sii3112_reset, s);
>  }
>
>  static void sii3112_pci_class_init(ObjectClass *klass, void *data)
> @@ -303,6 +301,7 @@ static void sii3112_pci_class_init(ObjectClass *klass=
,
> void *data)
>      pd->class_id =3D PCI_CLASS_STORAGE_RAID;
>      pd->revision =3D 1;
>      pd->realize =3D sii3112_pci_realize;
> +    dc->reset =3D sii3112_reset;
>      dc->desc =3D "SiI3112A SATA controller";
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>  }
> --
> 2.21.0
>
>
>

--0000000000007bd5f30594840b57
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =E4=BA=8E2019=E5=
=B9=B410=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:32=E5=86=
=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">The SiI3112A SATA controller is a PCI device, it will be reset<br>
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
=C2=A0hw/ide/sii3112.c | 7 +++----<br>
=C2=A01 file changed, 3 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c<br>
index 2181260531..06605d7af2 100644<br>
--- a/hw/ide/sii3112.c<br>
+++ b/hw/ide/sii3112.c<br>
@@ -15,7 +15,6 @@<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;hw/ide/pci.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
-#include &quot;sysemu/reset.h&quot;<br>
=C2=A0#include &quot;trace.h&quot;<br>
<br>
=C2=A0#define TYPE_SII3112_PCI &quot;sii3112&quot;<br>
@@ -237,9 +236,9 @@ static void sii3112_set_irq(void *opaque, int channel, =
int level)<br>
=C2=A0 =C2=A0 =C2=A0sii3112_update_irq(s);<br>
=C2=A0}<br>
<br>
-static void sii3112_reset(void *opaque)<br>
+static void sii3112_reset(DeviceState *dev)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 SiI3112PCIState *s =3D opaque;<br>
+=C2=A0 =C2=A0 SiI3112PCIState *s =3D SII3112_PCI(dev);<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 2; i++) {<br>
@@ -290,7 +289,6 @@ static void sii3112_pci_realize(PCIDevice *dev, Error *=
*errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;bmdma[i].bus =3D &amp;s-&gt;bus[i];=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ide_register_restart_cb(&amp;s-&gt;bus[i]=
);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 qemu_register_reset(sii3112_reset, s);<br>
=C2=A0}<br>
<br>
=C2=A0static void sii3112_pci_class_init(ObjectClass *klass, void *data)<br=
>
@@ -303,6 +301,7 @@ static void sii3112_pci_class_init(ObjectClass *klass, =
void *data)<br>
=C2=A0 =C2=A0 =C2=A0pd-&gt;class_id =3D PCI_CLASS_STORAGE_RAID;<br>
=C2=A0 =C2=A0 =C2=A0pd-&gt;revision =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0pd-&gt;realize =3D sii3112_pci_realize;<br>
+=C2=A0 =C2=A0 dc-&gt;reset =3D sii3112_reset;<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;desc =3D &quot;SiI3112A SATA controller&quot;;<b=
r>
=C2=A0 =C2=A0 =C2=A0set_bit(DEVICE_CATEGORY_STORAGE, dc-&gt;categories);<br=
>
=C2=A0}<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote></div></div>

--0000000000007bd5f30594840b57--

