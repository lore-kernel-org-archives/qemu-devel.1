Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC83C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 01:13:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6966D2086D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 01:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am4Z2fQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6966D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIN1Q-0007SX-KA
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 21:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iIN0i-0006rR-6A
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 21:12:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iIN0h-00057s-10
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 21:12:56 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44148)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>)
 id 1iIN0g-00057m-Nf; Wed, 09 Oct 2019 21:12:54 -0400
Received: by mail-oi1-x243.google.com with SMTP id w6so3428303oie.11;
 Wed, 09 Oct 2019 18:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Kae0VhOmiaTOgO4PffjIZC9BUvc3e3RmbDVH1bwemv4=;
 b=am4Z2fQFtRm42oU5TkmaE+NCOKEcNtM2FP17TiRtPKDGj+gmUA5KM3PE9TEvPyG51c
 afVkQXz+N0atr3JjXz1I+gzxKk5BFq8efDNzFSgrkkCGFEnLszli5canxjUc24gi55N2
 DudsyOQ/UFJVB0cmzscvZTv/VV6xAOJ9rfLf4pV2O3zQKoKyd8RyXJOkbVF30SVouknF
 h7mOj1eI9aU/2rGCoLqLNsQTwfZ8jctJOan5Qd/VgHAuqj0LhR6gLptNavarzzI+sHH+
 y74okCdlqghSE0JAx/e1Z9CB1vuHOXDc55EXQT4p/Tvg0nsu3WGc8uUDrHORwOAXPeaD
 jFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Kae0VhOmiaTOgO4PffjIZC9BUvc3e3RmbDVH1bwemv4=;
 b=PZ3L13kAss7Mx3eMvAwMrI6pwVCvm1MYc3RdXgkQ3vSoSiQs0/c3SlMw/5x7/3efhw
 rU2GHnYZV14zOtbwEgo6+C/aOCxuSNeTUKYl4ELayK1A3wEdobDlovG9sPupEaddbcHb
 kFKih/9E8VmE8CzbuNfFmERylMXqzLvEd8QbxlOB16IEi0E7snvSKXANX+/B3JP6dj2P
 uf8yNpyorzwnlDYx+x31cXQ0+owi1j+ZS5lUtavwh2BsdUGWDVMzO/5SaswB36/wCeAQ
 8noqvp33fSQOoSAYOLsPkZjnVr1jnMqKzqEc/jTmTBPcnqifOrTFyzHdN7oUagUUpaIc
 5JLw==
X-Gm-Message-State: APjAAAUXG5lf9N+WC+htfK+dzvHq/CXoNJqGap8nZypSpuQNJCtd366k
 pR0qOSPuAO6X05O3mysTaThtdsr1h2uPldI2rqo=
X-Google-Smtp-Source: APXvYqyAWRN1Om0vsrsI/mrVP6Q0eJu2iu43skt2CzEnXL5hxElvL0i2QtqnoGJjXRP/CeMZtExoTfitMrKt+XYgIi8=
X-Received: by 2002:aca:d18:: with SMTP id 24mr5255648oin.56.1570669973410;
 Wed, 09 Oct 2019 18:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191008142539.7793-1-philmd@redhat.com>
 <20191008142539.7793-7-philmd@redhat.com>
In-Reply-To: <20191008142539.7793-7-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 10 Oct 2019 09:12:17 +0800
Message-ID: <CAKXe6SJx-W_WQ6saGdpoWPPubgLfTeQz0+_zQp1UW_Ay-jF8zA@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] hw/isa/vt82c686: Convert reset handler to
 DeviceReset
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d318cb05948419ea"
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

--000000000000d318cb05948419ea
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B410=E6=
=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:39=E5=86=99=E9=81=
=93=EF=BC=9A

> The VIA VT82C686 Southbridge is a PCI device, it will be reset
> when the PCI bus it stands on is reset.
>
> Convert its reset handler into a proper Device reset method.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>

Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  hw/isa/vt82c686.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
> index 50bd28fa82..616f67f347 100644
> --- a/hw/isa/vt82c686.c
> +++ b/hw/isa/vt82c686.c
> @@ -23,7 +23,6 @@
>  #include "hw/isa/apm.h"
>  #include "hw/acpi/acpi.h"
>  #include "hw/i2c/pm_smbus.h"
> -#include "sysemu/reset.h"
>  #include "qemu/module.h"
>  #include "qemu/timer.h"
>  #include "exec/address-spaces.h"
> @@ -116,11 +115,10 @@ static const MemoryRegionOps superio_ops =3D {
>      },
>  };
>
> -static void vt82c686b_reset(void * opaque)
> +static void vt82c686b_isa_reset(DeviceState *dev)
>  {
> -    PCIDevice *d =3D opaque;
> -    uint8_t *pci_conf =3D d->config;
> -    VT82C686BState *vt82c =3D VT82C686B_DEVICE(d);
> +    VT82C686BState *vt82c =3D VT82C686B_DEVICE(dev);
> +    uint8_t *pci_conf =3D vt82c->dev.config;
>
>      pci_set_long(pci_conf + PCI_CAPABILITY_LIST, 0x000000c0);
>      pci_set_word(pci_conf + PCI_COMMAND, PCI_COMMAND_IO |
> PCI_COMMAND_MEMORY |
> @@ -476,8 +474,6 @@ static void vt82c686b_realize(PCIDevice *d, Error
> **errp)
>       * But we do not emulate a floppy, so just set it here. */
>      memory_region_add_subregion(isa_bus->address_space_io, 0x3f0,
>                                  &vt82c->superio);
> -
> -    qemu_register_reset(vt82c686b_reset, d);
>  }
>
>  ISABus *vt82c686b_isa_init(PCIBus *bus, int devfn)
> @@ -501,6 +497,7 @@ static void via_class_init(ObjectClass *klass, void
> *data)
>      k->device_id =3D PCI_DEVICE_ID_VIA_ISA_BRIDGE;
>      k->class_id =3D PCI_CLASS_BRIDGE_ISA;
>      k->revision =3D 0x40;
> +    dc->reset =3D vt82c686b_isa_reset;
>      dc->desc =3D "ISA bridge";
>      dc->vmsd =3D &vmstate_via;
>      /*
> --
> 2.21.0
>
>
>

--000000000000d318cb05948419ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =E4=BA=8E2019=E5=
=B9=B410=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:39=E5=86=
=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">The VIA VT82C686 Southbridge is a PCI device, it will be reset<br>
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
=C2=A0hw/isa/vt82c686.c | 11 ++++-------<br>
=C2=A01 file changed, 4 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c<br>
index 50bd28fa82..616f67f347 100644<br>
--- a/hw/isa/vt82c686.c<br>
+++ b/hw/isa/vt82c686.c<br>
@@ -23,7 +23,6 @@<br>
=C2=A0#include &quot;hw/isa/apm.h&quot;<br>
=C2=A0#include &quot;hw/acpi/acpi.h&quot;<br>
=C2=A0#include &quot;hw/i2c/pm_smbus.h&quot;<br>
-#include &quot;sysemu/reset.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
=C2=A0#include &quot;qemu/timer.h&quot;<br>
=C2=A0#include &quot;exec/address-spaces.h&quot;<br>
@@ -116,11 +115,10 @@ static const MemoryRegionOps superio_ops =3D {<br>
=C2=A0 =C2=A0 =C2=A0},<br>
=C2=A0};<br>
<br>
-static void vt82c686b_reset(void * opaque)<br>
+static void vt82c686b_isa_reset(DeviceState *dev)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 PCIDevice *d =3D opaque;<br>
-=C2=A0 =C2=A0 uint8_t *pci_conf =3D d-&gt;config;<br>
-=C2=A0 =C2=A0 VT82C686BState *vt82c =3D VT82C686B_DEVICE(d);<br>
+=C2=A0 =C2=A0 VT82C686BState *vt82c =3D VT82C686B_DEVICE(dev);<br>
+=C2=A0 =C2=A0 uint8_t *pci_conf =3D vt82c-&gt;dev.config;<br>
<br>
=C2=A0 =C2=A0 =C2=A0pci_set_long(pci_conf + PCI_CAPABILITY_LIST, 0x000000c0=
);<br>
=C2=A0 =C2=A0 =C2=A0pci_set_word(pci_conf + PCI_COMMAND, PCI_COMMAND_IO | P=
CI_COMMAND_MEMORY |<br>
@@ -476,8 +474,6 @@ static void vt82c686b_realize(PCIDevice *d, Error **err=
p)<br>
=C2=A0 =C2=A0 =C2=A0 * But we do not emulate a floppy, so just set it here.=
 */<br>
=C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(isa_bus-&gt;address_space_i=
o, 0x3f0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;vt82c-&gt;superio);<br>
-<br>
-=C2=A0 =C2=A0 qemu_register_reset(vt82c686b_reset, d);<br>
=C2=A0}<br>
<br>
=C2=A0ISABus *vt82c686b_isa_init(PCIBus *bus, int devfn)<br>
@@ -501,6 +497,7 @@ static void via_class_init(ObjectClass *klass, void *da=
ta)<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;device_id =3D PCI_DEVICE_ID_VIA_ISA_BRIDGE;<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;class_id =3D PCI_CLASS_BRIDGE_ISA;<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;revision =3D 0x40;<br>
+=C2=A0 =C2=A0 dc-&gt;reset =3D vt82c686b_isa_reset;<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;desc =3D &quot;ISA bridge&quot;;<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;vmsd =3D &amp;vmstate_via;<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote></div></div>

--000000000000d318cb05948419ea--

