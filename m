Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D0BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 21:31:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02B1920885
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 21:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pltvqIHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B1920885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrTHA-0007kw-8Q
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 17:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jrTG2-0006zb-Us; Fri, 03 Jul 2020 17:30:06 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:36780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jrTG1-0000GO-27; Fri, 03 Jul 2020 17:30:06 -0400
Received: by mail-il1-x143.google.com with SMTP id x9so28326720ila.3;
 Fri, 03 Jul 2020 14:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bdqHm/d9bNw1faKINqMqSO1MowwyG968EE2fYGr009k=;
 b=pltvqIHprwCGI4PrrrhBWZqMZdr4PpogIM+IzNcQtX/88RlkNdcO+Fvvq5NW9wIllU
 jK8z0iCE3/dZpp6nkoh68RoI39Zybqv1Qkq6k9lXcL2+cB6bKgg/vIj6c5+0S5/2Que2
 U6+tNv+6Hr5c4U2RyAG8n2c804z6lK3Tvs6qYx6wPeB9rYyglQOV6k/BsA75SjHF/gb8
 1+8cYLIYQzXjn5GzqHtD8ZF6OKmfI01ZmVNRPDQKxGLUZg5+j4IKirQGDiQEcU+OXLei
 hnJ8i4H86y3TVSmS9/KK0YOQgfoaWajCTnCTz/S9FGipe/oDN1izRuebYLhYxFq0hmHb
 C7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bdqHm/d9bNw1faKINqMqSO1MowwyG968EE2fYGr009k=;
 b=WfKyRvHvGS18bR7JaGAMd+S73OKtOMDfDq2yZKToZuLohQtVXoEw0Oq7ED8/iUugXC
 0ge1vDNYvu45M5Xnyp8e9N9H3sVzpOP4d0+OZoHs+V3sqeAWRDcxGnGfZHPuy1XwOakT
 k/PZDsNQvTV7QJr1ill5vagmq/W9wfiK0BptiuUld2rEAZ0C+2iMfTz+Yjptaf2jGZWd
 hhcB5oeKU9AlQEK61SZ4+VRsEoUDRvFLyT64dbLQBX3P9IKlVs//J9yy0cGHVB9ALVPe
 OwR2C/reGYGFPuYcpxhYwE4AJI1P+HSa5OEm5hWOLgIA7KskTCWNEBI+VRepiwi53ECW
 qOZg==
X-Gm-Message-State: AOAM5322ux4NpjkvsjgmcTrVlklAOu95ndegJ/ZRExYNUdncuyLGHQRh
 zPk9H/RNDu0tEuwNd6NvDgSgydlaz27S2BEw6/M=
X-Google-Smtp-Source: ABdhPJxty2mok237cmFwqLrS6eEYMqgohiZa/kjM4KvGLE6s7/xNfhnf2wuvhzJeCUTS5Fm402yill1tpGcrcCVohmg=
X-Received: by 2002:a92:794f:: with SMTP id u76mr18066005ilc.215.1593811802541; 
 Fri, 03 Jul 2020 14:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200703184952.4918-1-f4bug@amsat.org>
 <20200703184952.4918-2-f4bug@amsat.org>
In-Reply-To: <20200703184952.4918-2-f4bug@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Fri, 3 Jul 2020 23:29:52 +0200
Message-ID: <CAPan3WqP1g3Cje99soKHpq_qVo-iWJ3VFwG7+6mt3=S2W8VBjA@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/arm: Use TYPE_SYSBUS_OHCI instead of hardcoded
 string
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="00000000000054547105a9903aa4"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000054547105a9903aa4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2020, 20:49 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:

> By using the TYPE_* definitions for devices, we can:
> - quickly find where devices are used with 'git-grep'
> - easily rename a non-user-creatable device (one-line change).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
Reviewed-By: Niek Linnenbank <nieklinnenbank@gmail.com>

---
>  hw/arm/allwinner-h3.c | 9 +++++----
>  hw/arm/pxa2xx.c       | 3 ++-
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> index 8e09468e86..231d9ad647 100644
> --- a/hw/arm/allwinner-h3.c
> +++ b/hw/arm/allwinner-h3.c
> @@ -28,6 +28,7 @@
>  #include "hw/sysbus.h"
>  #include "hw/char/serial.h"
>  #include "hw/misc/unimp.h"
> +#include "hw/usb/hcd-ohci.h"
>  #include "hw/usb/hcd-ehci.h"
>  #include "hw/loader.h"
>  #include "sysemu/sysemu.h"
> @@ -381,16 +382,16 @@ static void allwinner_h3_realize(DeviceState *dev,
> Error **errp)
>                           qdev_get_gpio_in(DEVICE(&s->gic),
>                                            AW_H3_GIC_SPI_EHCI3));
>
> -    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI0],
> +    sysbus_create_simple(TYPE_SYSBUS_OHCI, s->memmap[AW_H3_OHCI0],
>                           qdev_get_gpio_in(DEVICE(&s->gic),
>                                            AW_H3_GIC_SPI_OHCI0));
> -    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI1],
> +    sysbus_create_simple(TYPE_SYSBUS_OHCI, s->memmap[AW_H3_OHCI1],
>                           qdev_get_gpio_in(DEVICE(&s->gic),
>                                            AW_H3_GIC_SPI_OHCI1));
> -    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI2],
> +    sysbus_create_simple(TYPE_SYSBUS_OHCI, s->memmap[AW_H3_OHCI2],
>                           qdev_get_gpio_in(DEVICE(&s->gic),
>                                            AW_H3_GIC_SPI_OHCI2));
> -    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI3],
> +    sysbus_create_simple(TYPE_SYSBUS_OHCI, s->memmap[AW_H3_OHCI3],
>                           qdev_get_gpio_in(DEVICE(&s->gic),
>                                            AW_H3_GIC_SPI_OHCI3));
>
> diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
> index f104a33463..1e8a1cbc24 100644
> --- a/hw/arm/pxa2xx.c
> +++ b/hw/arm/pxa2xx.c
> @@ -22,6 +22,7 @@
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/ssi/ssi.h"
> +#include "hw/usb/hcd-ohci.h"
>  #include "chardev/char-fe.h"
>  #include "sysemu/blockdev.h"
>  #include "sysemu/qtest.h"
> @@ -2196,7 +2197,7 @@ PXA2xxState *pxa270_init(MemoryRegion *address_spac=
e,
>          s->ssp[i] =3D (SSIBus *)qdev_get_child_bus(dev, "ssi");
>      }
>
> -    sysbus_create_simple("sysbus-ohci", 0x4c000000,
> +    sysbus_create_simple(TYPE_SYSBUS_OHCI, 0x4c000000,
>                           qdev_get_gpio_in(s->pic, PXA2XX_PIC_USBH1));
>
>      s->pcmcia[0] =3D pxa2xx_pcmcia_init(address_space, 0x20000000);
> --
> 2.21.3
>
>

--00000000000054547105a9903aa4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Jul 3, 2020, 20:49 Philippe Mathieu-Daud=C3=A9=
 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">By using the TYPE_* definitions for dev=
ices, we can:<br>
- quickly find where devices are used with &#39;git-grep&#39;<br>
- easily rename a non-user-creatable device (one-line change).<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank" rel=3D"noreferrer">f4bug@amsat.org</a>&gt;<br></bl=
ockquote></div></div><div dir=3D"auto">Reviewed-By: Niek Linnenbank &lt;<a =
href=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt;</=
div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote=
"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
---<br>
=C2=A0hw/arm/allwinner-h3.c | 9 +++++----<br>
=C2=A0hw/arm/pxa2xx.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 3 ++-<br>
=C2=A02 files changed, 7 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c<br>
index 8e09468e86..231d9ad647 100644<br>
--- a/hw/arm/allwinner-h3.c<br>
+++ b/hw/arm/allwinner-h3.c<br>
@@ -28,6 +28,7 @@<br>
=C2=A0#include &quot;hw/sysbus.h&quot;<br>
=C2=A0#include &quot;hw/char/serial.h&quot;<br>
=C2=A0#include &quot;hw/misc/unimp.h&quot;<br>
+#include &quot;hw/usb/hcd-ohci.h&quot;<br>
=C2=A0#include &quot;hw/usb/hcd-ehci.h&quot;<br>
=C2=A0#include &quot;hw/loader.h&quot;<br>
=C2=A0#include &quot;sysemu/sysemu.h&quot;<br>
@@ -381,16 +382,16 @@ static void allwinner_h3_realize(DeviceState *dev, Er=
ror **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0AW_H3_GIC_SPI_EHCI3));<br>
<br>
-=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, s-&gt;memmap[A=
W_H3_OHCI0],<br>
+=C2=A0 =C2=A0 sysbus_create_simple(TYPE_SYSBUS_OHCI, s-&gt;memmap[AW_H3_OH=
CI0],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0AW_H3_GIC_SPI_OHCI0));<br>
-=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, s-&gt;memmap[A=
W_H3_OHCI1],<br>
+=C2=A0 =C2=A0 sysbus_create_simple(TYPE_SYSBUS_OHCI, s-&gt;memmap[AW_H3_OH=
CI1],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0AW_H3_GIC_SPI_OHCI1));<br>
-=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, s-&gt;memmap[A=
W_H3_OHCI2],<br>
+=C2=A0 =C2=A0 sysbus_create_simple(TYPE_SYSBUS_OHCI, s-&gt;memmap[AW_H3_OH=
CI2],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0AW_H3_GIC_SPI_OHCI2));<br>
-=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, s-&gt;memmap[A=
W_H3_OHCI3],<br>
+=C2=A0 =C2=A0 sysbus_create_simple(TYPE_SYSBUS_OHCI, s-&gt;memmap[AW_H3_OH=
CI3],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0AW_H3_GIC_SPI_OHCI3));<br>
<br>
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c<br>
index f104a33463..1e8a1cbc24 100644<br>
--- a/hw/arm/pxa2xx.c<br>
+++ b/hw/arm/pxa2xx.c<br>
@@ -22,6 +22,7 @@<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
=C2=A0#include &quot;hw/ssi/ssi.h&quot;<br>
+#include &quot;hw/usb/hcd-ohci.h&quot;<br>
=C2=A0#include &quot;chardev/char-fe.h&quot;<br>
=C2=A0#include &quot;sysemu/blockdev.h&quot;<br>
=C2=A0#include &quot;sysemu/qtest.h&quot;<br>
@@ -2196,7 +2197,7 @@ PXA2xxState *pxa270_init(MemoryRegion *address_space,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;ssp[i] =3D (SSIBus *)qdev_get_child=
_bus(dev, &quot;ssi&quot;);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, 0x4c000000,<br=
>
+=C2=A0 =C2=A0 sysbus_create_simple(TYPE_SYSBUS_OHCI, 0x4c000000,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(s-&gt;pic, PXA2XX_PIC_USBH1));<br>
<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;pcmcia[0] =3D pxa2xx_pcmcia_init(address_space, 0=
x20000000);<br>
-- <br>
2.21.3<br>
<br>
</blockquote></div></div></div>

--00000000000054547105a9903aa4--

