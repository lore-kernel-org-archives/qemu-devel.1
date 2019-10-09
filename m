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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B0EC4360C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 01:00:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6B7C2070B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 00:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bs0YIZRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B7C2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iI0Kd-0005MY-2q
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 20:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iI0Jm-0004hD-1j
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 20:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iI0Jk-00053r-NZ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 20:59:05 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39409)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>)
 id 1iI0Jk-00053j-GL; Tue, 08 Oct 2019 20:59:04 -0400
Received: by mail-oi1-x244.google.com with SMTP id w144so346708oia.6;
 Tue, 08 Oct 2019 17:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vdJ6hUyFIr9essbPJNXSLpLm9WkR6FVlyC3k4abQwCs=;
 b=Bs0YIZROhEwuGBFhDL3EbYjAVMUsDHO+0ttSU8I1ZYOZjr2+XuXmVkv1nD3KcbvjHR
 ZQmAq3htEO0aCve7x8WoX/8y6BjLfN0pthY4JOEJ3b1PQQwoqGPjP6/xmAq+Kb+NxhTB
 qOjvw3BV5718tK79NIS1vZRy4DMnuiVKXSs82qI1PQgYJwl8GZ8DpNcdmoM6+hKLPyHy
 Zz9/EAJEvYwwrwKv481cvwA9UjhFOWARpkSQH0N6UWsDFesZjpBqGmDM7PUugUzSKf3M
 52AX1o5VO0C2K8nzW3LLHPF57t6hJZwOlVufBvm/Jv1goMTz6q6i7d6Tr758JFT3l8py
 d/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vdJ6hUyFIr9essbPJNXSLpLm9WkR6FVlyC3k4abQwCs=;
 b=IIt70CpiLN9KFikdgmuv1BiO2wHzVtFEpG83a0aPhSx+uGwIdwcRzVRqu74QSoJkg1
 5eol1XhCMxOwPedjDfYIAzHQ3YatD6UnOTj4OvvGKDzGNtYZL0tp7Hctgsaonh8M65Oh
 DLnUBVsK235LP1Np0v9EoIPWHHo7t322JPlyxjKSqKU3LC42BB59Oipji9W8o25DURdz
 lOnCOVtpi0Pj5fQM1lMfARENirfkW0+ApnP4b/Ac2V7SwgNjjU11HE1bDkz/h65oR+AD
 JPukhG008q9YDkhKHABp3g7Rq6naZgWqiuCEe5DY5GJ8IOOhCPYmurIToe83jIQDdcHg
 anog==
X-Gm-Message-State: APjAAAVyQI1snxkHdonukNMC+uqtOA2E8aoaiG7c4fM9XtZbg+jT6Z17
 9V3N+F3hbEyJZs7WHtIm6YqGK4dNUwPn6tuWzVw=
X-Google-Smtp-Source: APXvYqxCwVW5wQUJOt0rpJqDHnMCVurYxAs5XHTGXhBhnQzeidRJs9xOWJZ/tcotN5vtjtMaLGL45daPAcRjrr+OAOc=
X-Received: by 2002:aca:280e:: with SMTP id 14mr343753oix.129.1570582743556;
 Tue, 08 Oct 2019 17:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191008142539.7793-1-philmd@redhat.com>
 <20191008142539.7793-2-philmd@redhat.com>
In-Reply-To: <20191008142539.7793-2-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 9 Oct 2019 08:58:27 +0800
Message-ID: <CAKXe6S+jpobh-nG+-x1+QMrUcCReT2AfmfPo+mGc4X+L_V1WVw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] hw/acpi/piix4: Convert reset handler to DeviceReset
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000085291705946fcaa8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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

--00000000000085291705946fcaa8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B410=E6=
=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:28=E5=86=99=E9=81=
=93=EF=BC=9A

> The PIIX4/PM is a PCI device within the PIIX4 chipset, it will be reset
> when the PCI bus it stands on is reset.
>
> Convert its reset handler into a proper Device reset method.
>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>


Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  hw/acpi/piix4.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index 5742c3df87..4e079b39bd 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -27,7 +27,6 @@
>  #include "hw/pci/pci.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/acpi/acpi.h"
> -#include "sysemu/reset.h"
>  #include "sysemu/runstate.h"
>  #include "sysemu/sysemu.h"
>  #include "qapi/error.h"
> @@ -344,9 +343,9 @@ static const VMStateDescription vmstate_acpi =3D {
>      }
>  };
>
> -static void piix4_reset(void *opaque)
> +static void piix4_pm_reset(DeviceState *dev)
>  {
> -    PIIX4PMState *s =3D opaque;
> +    PIIX4PMState *s =3D PIIX4_PM(dev);
>      PCIDevice *d =3D PCI_DEVICE(s);
>      uint8_t *pci_conf =3D d->config;
>
> @@ -542,7 +541,6 @@ static void piix4_pm_realize(PCIDevice *dev, Error
> **errp)
>
>      s->machine_ready.notify =3D piix4_pm_machine_ready;
>      qemu_add_machine_init_done_notifier(&s->machine_ready);
> -    qemu_register_reset(piix4_reset, s);
>
>      piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
>                                     pci_get_bus(dev), s);
> @@ -692,6 +690,7 @@ static void piix4_pm_class_init(ObjectClass *klass,
> void *data)
>      k->device_id =3D PCI_DEVICE_ID_INTEL_82371AB_3;
>      k->revision =3D 0x03;
>      k->class_id =3D PCI_CLASS_BRIDGE_OTHER;
> +    dc->reset =3D piix4_pm_reset;
>      dc->desc =3D "PM";
>      dc->vmsd =3D &vmstate_acpi;
>      dc->props =3D piix4_pm_properties;
> --
> 2.21.0
>
>
>

--00000000000085291705946fcaa8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =E4=BA=8E2019=E5=
=B9=B410=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:28=E5=86=
=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">The PIIX4/PM is a PCI device within the PIIX4 chipset, it will be res=
et<br>
when the PCI bus it stands on is reset.<br>
<br>
Convert its reset handler into a proper Device reset method.<br>
<br>
Reviewed-by: Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com" targe=
t=3D"_blank">imammedo@redhat.com</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br></blockquote><div><=
br></div><div><br></div><div>Reviewed-by: Li Qiang &lt;<a href=3D"mailto:li=
q3ea@gmail.com">liq3ea@gmail.com</a>&gt;<br></div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0hw/acpi/piix4.c | 7 +++----<br>
=C2=A01 file changed, 3 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c<br>
index 5742c3df87..4e079b39bd 100644<br>
--- a/hw/acpi/piix4.c<br>
+++ b/hw/acpi/piix4.c<br>
@@ -27,7 +27,6 @@<br>
=C2=A0#include &quot;hw/pci/pci.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
=C2=A0#include &quot;hw/acpi/acpi.h&quot;<br>
-#include &quot;sysemu/reset.h&quot;<br>
=C2=A0#include &quot;sysemu/runstate.h&quot;<br>
=C2=A0#include &quot;sysemu/sysemu.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
@@ -344,9 +343,9 @@ static const VMStateDescription vmstate_acpi =3D {<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0};<br>
<br>
-static void piix4_reset(void *opaque)<br>
+static void piix4_pm_reset(DeviceState *dev)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 PIIX4PMState *s =3D opaque;<br>
+=C2=A0 =C2=A0 PIIX4PMState *s =3D PIIX4_PM(dev);<br>
=C2=A0 =C2=A0 =C2=A0PCIDevice *d =3D PCI_DEVICE(s);<br>
=C2=A0 =C2=A0 =C2=A0uint8_t *pci_conf =3D d-&gt;config;<br>
<br>
@@ -542,7 +541,6 @@ static void piix4_pm_realize(PCIDevice *dev, Error **er=
rp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;machine_ready.notify =3D piix4_pm_machine_ready;<=
br>
=C2=A0 =C2=A0 =C2=A0qemu_add_machine_init_done_notifier(&amp;s-&gt;machine_=
ready);<br>
-=C2=A0 =C2=A0 qemu_register_reset(piix4_reset, s);<br>
<br>
=C2=A0 =C2=A0 =C2=A0piix4_acpi_system_hot_add_init(pci_address_space_io(dev=
),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_get_bus(dev), s);<=
br>
@@ -692,6 +690,7 @@ static void piix4_pm_class_init(ObjectClass *klass, voi=
d *data)<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;device_id =3D PCI_DEVICE_ID_INTEL_82371AB_3;<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;revision =3D 0x03;<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;class_id =3D PCI_CLASS_BRIDGE_OTHER;<br>
+=C2=A0 =C2=A0 dc-&gt;reset =3D piix4_pm_reset;<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;desc =3D &quot;PM&quot;;<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;vmsd =3D &amp;vmstate_acpi;<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;props =3D piix4_pm_properties;<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote></div></div>

--00000000000085291705946fcaa8--

