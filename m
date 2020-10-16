Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1224C43457
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 06:47:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 213CA20848
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 06:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPXzsDQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213CA20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTJW9-00034R-1c
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 02:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1kTJUQ-0002Mr-QY; Fri, 16 Oct 2020 02:45:22 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45497)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1kTJUK-0005h2-Jo; Fri, 16 Oct 2020 02:45:22 -0400
Received: by mail-ot1-x343.google.com with SMTP id f37so1465346otf.12;
 Thu, 15 Oct 2020 23:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/dxLNljiXPEUpWUAlK93T0HnlADpqIRP5l661Y6trRE=;
 b=iPXzsDQe340YKcWZHhlZe5xsptIWqvnWm2ASJ7KCM5G7jrOU5Llmb/qBebOZNmX49X
 FiFalXjtU0hs6unMYQ4ByYwkLZAStH/jX5SYAe1SN3GNKBIoLNSvXOFMujNtIkauKBN0
 alapqGFTLkNzB3aGfGYYXkzb4eVmXgeVMGaDzx4bKaehZbI+AODJ9Idrs4x14qpKkOgf
 weC++W8M2/7p/ujNo3g1ES3udUL1hftkDW/lxbanBT51FNDX3qubNZObFp00AfhPRvHD
 fftIBU47RwBEdkEzasDO/8bMzs0/SQbY6brGrYEHc+3jDU6N4vOaHWcl7WT6XT3wf0Rv
 jJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/dxLNljiXPEUpWUAlK93T0HnlADpqIRP5l661Y6trRE=;
 b=qee7YP0ridOfd5xmq1IL2Z7HyQZKuB15JBQ7gj81lAAKZfcUkjb7oMfX9a9jYZRCaH
 pg9O+76YXgn6QUyPGy7BAYeI1Bpn2ujuvNnDUpSPD13yaZThR/fASVwNO/gSxaf1REk8
 xGuxjglMwlpwQ4hP44h8/6cnECi6LxEulUWAH7h4+36J6dt0UbiMPe4e5I/BwfsgR5Do
 nvg7i7pJifzaFhOrDfaXbcgQOPcjFGJofNyPO1TS71jQaiw3wOMHBOGfoAy/ky6EPxFf
 QONEps3mgKs0Zb3qqZ5A0d8NIPUkgLfcO9DswXCB0W3VioJIZjCEwzRH8Sr+XMK7ufdg
 Yfvg==
X-Gm-Message-State: AOAM531H2NRP4YSdJc8LDZX9k1l2oI7AUvMMFYxmTEwFEAbe2j5/5x+P
 j275i1RrggCEmEqTS9x4A6vvBgVJTFiMryTHX/A=
X-Google-Smtp-Source: ABdhPJytqPmAJav63y/FS9klv1vY4fdJ7lsLpeIAhDypDw1h1pGzrJjdJD/O2FELNk5+zoyzgwyZFHiKNrrWcfGBmHU=
X-Received: by 2002:a9d:649:: with SMTP id 67mr1589719otn.233.1602830714149;
 Thu, 15 Oct 2020 23:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201013114922.2946-1-mark.cave-ayland@ilande.co.uk>
 <20201013114922.2946-3-mark.cave-ayland@ilande.co.uk>
 <20201016001803.GC7078@yekko.fritz.box>
In-Reply-To: <20201016001803.GC7078@yekko.fritz.box>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Fri, 16 Oct 2020 08:45:02 +0200
Message-ID: <CABLmASE+GzEhSgqqJmum+Xu7DkyQX6PtboKLhA4LyaOY7PYoSA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] grackle: use qdev gpios for PCI IRQs
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: multipart/alternative; boundary="0000000000005a20dd05b1c41b02"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=hsp.cat7@gmail.com; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005a20dd05b1c41b02
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2020 at 2:30 AM David Gibson <david@gibson.dropbear.id.au>
wrote:

> On Tue, Oct 13, 2020 at 12:49:21PM +0100, Mark Cave-Ayland wrote:
> > Currently an object link property is used to pass a reference to the
> Heathrow
> > PIC into the PCI host bridge so that grackle_init_irqs() can connect th=
e
> PCI
> > IRQs to the PIC itself.
> >
> > This can be simplified by defining the PCI IRQs as qdev gpios and then
> wiring
> > up the PCI IRQs to the PIC in the Old World machine init function.
> >
> > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>
> Applied to ppc-for-5.2.
>
> > ---
> >  hw/pci-host/grackle.c | 19 ++-----------------
> >  hw/ppc/mac_oldworld.c |  7 +++++--
> >  2 files changed, 7 insertions(+), 19 deletions(-)
> >
> > diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
> > index 57c29b20af..b05facf463 100644
> > --- a/hw/pci-host/grackle.c
> > +++ b/hw/pci-host/grackle.c
> > @@ -28,7 +28,6 @@
> >  #include "hw/ppc/mac.h"
> >  #include "hw/qdev-properties.h"
> >  #include "hw/pci/pci.h"
> > -#include "hw/intc/heathrow_pic.h"
> >  #include "hw/irq.h"
> >  #include "qapi/error.h"
> >  #include "qemu/module.h"
> > @@ -41,7 +40,6 @@ struct GrackleState {
> >      PCIHostState parent_obj;
> >
> >      uint32_t ofw_addr;
> > -    HeathrowState *pic;
> >      qemu_irq irqs[4];
> >      MemoryRegion pci_mmio;
> >      MemoryRegion pci_hole;
> > @@ -62,15 +60,6 @@ static void pci_grackle_set_irq(void *opaque, int
> irq_num, int level)
> >      qemu_set_irq(s->irqs[irq_num], level);
> >  }
> >
> > -static void grackle_init_irqs(GrackleState *s)
> > -{
> > -    int i;
> > -
> > -    for (i =3D 0; i < ARRAY_SIZE(s->irqs); i++) {
> > -        s->irqs[i] =3D qdev_get_gpio_in(DEVICE(s->pic), 0x15 + i);
> > -    }
> > -}
> > -
> >  static void grackle_realize(DeviceState *dev, Error **errp)
> >  {
> >      GrackleState *s =3D GRACKLE_PCI_HOST_BRIDGE(dev);
> > @@ -85,7 +74,6 @@ static void grackle_realize(DeviceState *dev, Error
> **errp)
> >                                       0, 4, TYPE_PCI_BUS);
> >
> >      pci_create_simple(phb->bus, 0, "grackle");
> > -    grackle_init_irqs(s);
> >  }
> >
> >  static void grackle_init(Object *obj)
> > @@ -106,15 +94,12 @@ static void grackle_init(Object *obj)
> >      memory_region_init_io(&phb->data_mem, obj, &pci_host_data_le_ops,
> >                            DEVICE(obj), "pci-data-idx", 0x1000);
> >
> > -    object_property_add_link(obj, "pic", TYPE_HEATHROW,
> > -                             (Object **) &s->pic,
> > -                             qdev_prop_allow_set_link_before_realize,
> > -                             0);
> > -
> >      sysbus_init_mmio(sbd, &phb->conf_mem);
> >      sysbus_init_mmio(sbd, &phb->data_mem);
> >      sysbus_init_mmio(sbd, &s->pci_hole);
> >      sysbus_init_mmio(sbd, &s->pci_io);
> > +
> > +    qdev_init_gpio_out(DEVICE(obj), s->irqs, ARRAY_SIZE(s->irqs));
> >  }
> >
> >  static void grackle_pci_realize(PCIDevice *d, Error **errp)
> > diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> > index d6a76d06dc..05e46ee6fe 100644
> > --- a/hw/ppc/mac_oldworld.c
> > +++ b/hw/ppc/mac_oldworld.c
> > @@ -253,10 +253,9 @@ static void ppc_heathrow_init(MachineState *machin=
e)
> >      /* Grackle PCI host bridge */
> >      dev =3D qdev_new(TYPE_GRACKLE_PCI_HOST_BRIDGE);
> >      qdev_prop_set_uint32(dev, "ofw-addr", 0x80000000);
> > -    object_property_set_link(OBJECT(dev), "pic", OBJECT(pic_dev),
> > -                             &error_abort);
> >      s =3D SYS_BUS_DEVICE(dev);
> >      sysbus_realize_and_unref(s, &error_fatal);
> > +
> >      sysbus_mmio_map(s, 0, GRACKLE_BASE);
> >      sysbus_mmio_map(s, 1, GRACKLE_BASE + 0x200000);
> >      /* PCI hole */
> > @@ -266,6 +265,10 @@ static void ppc_heathrow_init(MachineState *machin=
e)
> >      memory_region_add_subregion(get_system_memory(), 0xfe000000,
> >                                  sysbus_mmio_get_region(s, 3));
> >
> > +    for (i =3D 0; i < 4; i++) {
> > +        qdev_connect_gpio_out(dev, i, qdev_get_gpio_in(pic_dev, 0x15 +
> i));
> > +    }
> > +
> >      pci_bus =3D PCI_HOST_BRIDGE(dev)->bus;
> >
> >      pci_vga_init(pci_bus);
>
>
> Hi,

I see compilation of the current ppc-for-5.2 branch fail with:

../hw/pci-host/grackle.c: In function =E2=80=98grackle_realize=E2=80=99:
../hw/pci-host/grackle.c:68:11: error: =E2=80=98GrackleState=E2=80=99 has n=
o member named
=E2=80=98pic=E2=80=99
   68 |     if (!s->pic) {
      |           ^~
make: *** [Makefile.ninja:1741: libcommon.fa.p/hw_pci-host_grackle.c.o]
Error 1

Best,
Howard

--0000000000005a20dd05b1c41b02
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 16, 2020 at 2:30 AM David=
 Gibson &lt;<a href=3D"mailto:david@gibson.dropbear.id.au">david@gibson.dro=
pbear.id.au</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Tue, Oct 13, 2020 at 12:49:21PM +0100, Mark Cave-Ayland wrote=
:<br>
&gt; Currently an object link property is used to pass a reference to the H=
eathrow<br>
&gt; PIC into the PCI host bridge so that grackle_init_irqs() can connect t=
he PCI<br>
&gt; IRQs to the PIC itself.<br>
&gt; <br>
&gt; This can be simplified by defining the PCI IRQs as qdev gpios and then=
 wiring<br>
&gt; up the PCI IRQs to the PIC in the Old World machine init function.<br>
&gt; <br>
&gt; Signed-off-by: Mark Cave-Ayland &lt;<a href=3D"mailto:mark.cave-ayland=
@ilande.co.uk" target=3D"_blank">mark.cave-ayland@ilande.co.uk</a>&gt;<br>
<br>
Applied to ppc-for-5.2.<br>
<br>
&gt; ---<br>
&gt;=C2=A0 hw/pci-host/grackle.c | 19 ++-----------------<br>
&gt;=C2=A0 hw/ppc/mac_oldworld.c |=C2=A0 7 +++++--<br>
&gt;=C2=A0 2 files changed, 7 insertions(+), 19 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c<br>
&gt; index 57c29b20af..b05facf463 100644<br>
&gt; --- a/hw/pci-host/grackle.c<br>
&gt; +++ b/hw/pci-host/grackle.c<br>
&gt; @@ -28,7 +28,6 @@<br>
&gt;=C2=A0 #include &quot;hw/ppc/mac.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/qdev-properties.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/pci/pci.h&quot;<br>
&gt; -#include &quot;hw/intc/heathrow_pic.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/irq.h&quot;<br>
&gt;=C2=A0 #include &quot;qapi/error.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/module.h&quot;<br>
&gt; @@ -41,7 +40,6 @@ struct GrackleState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 PCIHostState parent_obj;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint32_t ofw_addr;<br>
&gt; -=C2=A0 =C2=A0 HeathrowState *pic;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_irq irqs[4];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MemoryRegion pci_mmio;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MemoryRegion pci_hole;<br>
&gt; @@ -62,15 +60,6 @@ static void pci_grackle_set_irq(void *opaque, int i=
rq_num, int level)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_set_irq(s-&gt;irqs[irq_num], level);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -static void grackle_init_irqs(GrackleState *s)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 int i;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(s-&gt;irqs); i++) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;irqs[i] =3D qdev_get_gpio_in(DEVICE=
(s-&gt;pic), 0x15 + i);<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -}<br>
&gt; -<br>
&gt;=C2=A0 static void grackle_realize(DeviceState *dev, Error **errp)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 GrackleState *s =3D GRACKLE_PCI_HOST_BRIDGE(dev);<=
br>
&gt; @@ -85,7 +74,6 @@ static void grackle_realize(DeviceState *dev, Error =
**errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00, 4, =
TYPE_PCI_BUS);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 pci_create_simple(phb-&gt;bus, 0, &quot;grackle&qu=
ot;);<br>
&gt; -=C2=A0 =C2=A0 grackle_init_irqs(s);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static void grackle_init(Object *obj)<br>
&gt; @@ -106,15 +94,12 @@ static void grackle_init(Object *obj)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 memory_region_init_io(&amp;phb-&gt;data_mem, obj, =
&amp;pci_host_data_le_ops,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DEVICE(obj), &quot;pci-data-idx&quot;, 0x1000);=
<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 object_property_add_link(obj, &quot;pic&quot;, TYPE_HEA=
THROW,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(Object **) &amp;s-&gt;pic,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_prop_allow_set_link_before_realize,=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00);<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sysbus_init_mmio(sbd, &amp;phb-&gt;conf_mem);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sysbus_init_mmio(sbd, &amp;phb-&gt;data_mem);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sysbus_init_mmio(sbd, &amp;s-&gt;pci_hole);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sysbus_init_mmio(sbd, &amp;s-&gt;pci_io);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qdev_init_gpio_out(DEVICE(obj), s-&gt;irqs, ARRAY_SIZE(=
s-&gt;irqs));<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static void grackle_pci_realize(PCIDevice *d, Error **errp)<br>
&gt; diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c<br>
&gt; index d6a76d06dc..05e46ee6fe 100644<br>
&gt; --- a/hw/ppc/mac_oldworld.c<br>
&gt; +++ b/hw/ppc/mac_oldworld.c<br>
&gt; @@ -253,10 +253,9 @@ static void ppc_heathrow_init(MachineState *machi=
ne)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Grackle PCI host bridge */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 dev =3D qdev_new(TYPE_GRACKLE_PCI_HOST_BRIDGE);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 qdev_prop_set_uint32(dev, &quot;ofw-addr&quot;, 0x=
80000000);<br>
&gt; -=C2=A0 =C2=A0 object_property_set_link(OBJECT(dev), &quot;pic&quot;, =
OBJECT(pic_dev),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_abort);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 s =3D SYS_BUS_DEVICE(dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sysbus_realize_and_unref(s, &amp;error_fatal);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sysbus_mmio_map(s, 0, GRACKLE_BASE);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sysbus_mmio_map(s, 1, GRACKLE_BASE + 0x200000);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 /* PCI hole */<br>
&gt; @@ -266,6 +265,10 @@ static void ppc_heathrow_init(MachineState *machi=
ne)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), 0=
xfe000000,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_mmio_get_region(s, =
3));<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; 4; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_connect_gpio_out(dev, i, qdev_get_gp=
io_in(pic_dev, 0x15 + i));<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 pci_bus =3D PCI_HOST_BRIDGE(dev)-&gt;bus;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 pci_vga_init(pci_bus);<br>
<br><br></blockquote><div>Hi,</div><div><br></div><div>I see compilation of=
 the current ppc-for-5.2 branch fail with:</div><div><br></div><div>../hw/p=
ci-host/grackle.c: In function =E2=80=98grackle_realize=E2=80=99:<br>../hw/=
pci-host/grackle.c:68:11: error: =E2=80=98GrackleState=E2=80=99 has no memb=
er named =E2=80=98pic=E2=80=99<br>=C2=A0 =C2=A068 | =C2=A0 =C2=A0 if (!s-&g=
t;pic) {<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~<br=
>make: *** [Makefile.ninja:1741: libcommon.fa.p/hw_pci-host_grackle.c.o] Er=
ror 1</div><div><br></div><div>Best,</div><div>Howard<br></div></div></div>

--0000000000005a20dd05b1c41b02--

