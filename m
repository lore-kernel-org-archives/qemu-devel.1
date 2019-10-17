Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBB4ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:07:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F0620640
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DquGuD/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F0620640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL8JX-0001ch-HN
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL7S7-0008Da-Ea
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:12:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL7S5-0002fe-TJ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:12:35 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35421)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iL7S5-0002fQ-Nn
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:12:33 -0400
Received: by mail-oi1-x241.google.com with SMTP id x3so2477188oig.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=2jAu/qr6uBIVCI+Q6Qy4LmkqdXZ3twhcXalugYNwP3k=;
 b=DquGuD/20zOJj5Y8gcynm9u1114iRnu5bv6VPCKjRvP37n/xM5VMnr1fyntffzuAfh
 K9cccLyzJ7F4ddZ3boljaZrFeCwqeCnXrJUttLoraruMkwjHRzPg6xMOwsAWaZiTyzoq
 k46MPa2566PH93k13U0RNIzGPOF6/2ANl5evkH2LKxxUnTRhe3qFn57v2oSPLxklZNDk
 BE6LZXtLTghBy2Tz41hSW7MrTMs8aI4aDUbR2dsSNWEelyXoaTRM6642zBu1/lGMuFiC
 TPtaz90J9327SojyOJ89fBSBXLS1jd1y/F5G5f+FeJo7FgbhlH+YfBPZ+0owntspv4tW
 xT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=2jAu/qr6uBIVCI+Q6Qy4LmkqdXZ3twhcXalugYNwP3k=;
 b=rAuvJcI2wuja1w5n3g7D06e9fudicBE0Am6XWYl3tBaK/i3N8coyREG28Kzo1jIYKW
 k90tQPvPiysd2GE4uGfa+anTOdJ6LOGQNiQXSRHuMiQwAVDGRBAim9Bb3vf6xufPcgAq
 nKDzgBqRkJYTY3eRnUd//vOMyRNRXMhAB4FWcMn/7eV8vUG+CeVxswp7Qer4HwsSwyWU
 P/LwDr7KH6ZE+2iCRNWCAXu3Y9NindibQJr8e9NvHQuRSxVqRmrMFqiEwrWf06pOijoC
 SoODdETLMzgcxzNJAPU7MRZFAwtm8BqZjj06cpPFBjkMOYrZ1bRYbdkpfKbNm1MSOLkl
 uErg==
X-Gm-Message-State: APjAAAUmy0LX7cTkJLPTeK6Hfo6dCvaIPwqXawq9LQ69s1+In9Y7yfOJ
 q/rVM/ZcCf0TdQTZ6yQuwrEe2dhLoCCQyBzFodE=
X-Google-Smtp-Source: APXvYqw/GTnto9fEDbJDUD1ifq6r8Mil/8EDkH1fyroSrCqveDSxmO8wft/JaT9zt/VCZSmPcOXYaaUTwsULaT52kJI=
X-Received: by 2002:aca:4d12:: with SMTP id a18mr3536205oib.79.1571325152987; 
 Thu, 17 Oct 2019 08:12:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Thu, 17 Oct 2019 08:12:30
 -0700 (PDT)
In-Reply-To: <20191015162705.28087-21-philmd@redhat.com>
References: <20191015162705.28087-1-philmd@redhat.com>
 <20191015162705.28087-21-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 17 Oct 2019 17:12:30 +0200
Message-ID: <CAL1e-=hoogYN55pWrQCe1XQ7ZW40ymYTy1kx-JzQe=MX8ir0uA@mail.gmail.com>
Subject: Re: [PATCH 20/32] hw/i386/pc: Extract pc_gsi_create()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000092115c05951ca51b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000092115c05951ca51b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m>
wrote:

> The GSI creation code is common to all PC machines, extract the
> common code.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/i386/pc.c         | 15 +++++++++++++++
>  hw/i386/pc_piix.c    |  9 +--------
>  hw/i386/pc_q35.c     |  9 +--------
>  include/hw/i386/pc.h |  2 ++
>  4 files changed, 19 insertions(+), 16 deletions(-)
>
>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index bcda50efcc..a7597c6c44 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -357,6 +357,21 @@ void gsi_handler(void *opaque, int n, int level)
>      qemu_set_irq(s->ioapic_irq[n], level);
>  }
>
> +GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
> +{
> +    GSIState *s;
> +
> +    s =3D g_new0(GSIState, 1);
> +    if (kvm_ioapic_in_kernel()) {
> +        kvm_pc_setup_irq_routing(pci_enabled);
> +        *irqs =3D qemu_allocate_irqs(kvm_pc_gsi_handler, s, GSI_NUM_PINS=
);
> +    } else {
> +        *irqs =3D qemu_allocate_irqs(gsi_handler, s, GSI_NUM_PINS);
> +    }
> +
> +    return s;
> +}
> +
>  static void ioport80_write(void *opaque, hwaddr addr, uint64_t data,
>                             unsigned size)
>  {
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 431965d921..452b107e1b 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -188,14 +188,7 @@ static void pc_init1(MachineState *machine,
>          xen_load_linux(pcms);
>      }
>
> -    gsi_state =3D g_malloc0(sizeof(*gsi_state));
> -    if (kvm_ioapic_in_kernel()) {
> -        kvm_pc_setup_irq_routing(pcmc->pci_enabled);
> -        pcms->gsi =3D qemu_allocate_irqs(kvm_pc_gsi_handler, gsi_state,
> -                                       GSI_NUM_PINS);
> -    } else {
> -        pcms->gsi =3D qemu_allocate_irqs(gsi_handler, gsi_state,
> GSI_NUM_PINS);
> -    }
> +    gsi_state =3D pc_gsi_create(&pcms->gsi, pcmc->pci_enabled);
>
>      if (pcmc->pci_enabled) {
>          pci_bus =3D i440fx_init(host_type,
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 8fad20f314..52261962b8 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -210,14 +210,7 @@ static void pc_q35_init(MachineState *machine)
>      }
>
>      /* irq lines */
> -    gsi_state =3D g_malloc0(sizeof(*gsi_state));
> -    if (kvm_ioapic_in_kernel()) {
> -        kvm_pc_setup_irq_routing(pcmc->pci_enabled);
> -        pcms->gsi =3D qemu_allocate_irqs(kvm_pc_gsi_handler, gsi_state,
> -                                       GSI_NUM_PINS);
> -    } else {
> -        pcms->gsi =3D qemu_allocate_irqs(gsi_handler, gsi_state,
> GSI_NUM_PINS);
> -    }
> +    gsi_state =3D pc_gsi_create(&pcms->gsi, pcmc->pci_enabled);
>
>      /* create pci host bus */
>      q35_host =3D Q35_HOST_DEVICE(qdev_create(NULL, TYPE_Q35_HOST_DEVICE)=
);
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index b63fc7631e..d0c6b9d469 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -174,6 +174,8 @@ typedef struct GSIState {
>
>  void gsi_handler(void *opaque, int n, int level);
>
> +GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
> +
>  /* vmport.c */
>  #define TYPE_VMPORT "vmport"
>  typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
> --
> 2.21.0
>
>
>

--00000000000092115c05951ca51b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">The GSI creation code is common to all PC machines,=
 extract the<br>
common code.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/i386/pc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 15 +++++++++++++++<br=
>
=C2=A0hw/i386/pc_piix.c=C2=A0 =C2=A0 |=C2=A0 9 +--------<br>
=C2=A0hw/i386/pc_q35.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 9 +--------<br>
=C2=A0include/hw/i386/pc.h |=C2=A0 2 ++<br>
=C2=A04 files changed, 19 insertions(+), 16 deletions(-)<br>
<br></blockquote><div><br></div><div><div id=3D"cvcmsg_16dbfeb33c93ed97" cl=
ass=3D"yh  " style=3D"border-top-left-radius:0px;border-top-right-radius:0p=
x;margin-bottom:11px;overflow:visible"><div class=3D"Vh" id=3D"cvcfullmsg_1=
6dbfeb33c93ed97"><div id=3D"cvcmsgbod_16dbfeb33c93ed97" class=3D"aj"><div c=
lass=3D"Ni"><div class=3D"ni pi " dir=3D"ltr"><p dir=3D"ltr">Reviewed-by: A=
leksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.com" target=3D"=
_blank">amarkovic@wavecomp.com</a>&gt;</p><div style=3D"clear:both"></div><=
/div><div style=3D"clear:both"></div><div><div class=3D"M j T b hc Aj S" ta=
bindex=3D"0"><div class=3D"V j hf"></div></div></div><div style=3D"clear:bo=
th"></div></div></div></div></div><div id=3D"cvcmsg_16dbfecd588da1f7" class=
=3D"yh" style=3D"margin-bottom:11px"><div class=3D"Vh" id=3D"cvcfullmsg_16d=
bfecd588da1f7"><div class=3D"M j Zi Mi  " tabindex=3D"0"><div id=3D"cvcrepl=
y_16dbfecd588da1f7" class=3D"M j T b hc xh S  " tabindex=3D"0"><div class=
=3D"V j td"></div></div></div></div></div></div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
diff --git a/hw/i386/pc.c b/hw/i386/pc.c<br>
index bcda50efcc..a7597c6c44 100644<br>
--- a/hw/i386/pc.c<br>
+++ b/hw/i386/pc.c<br>
@@ -357,6 +357,21 @@ void gsi_handler(void *opaque, int n, int level)<br>
=C2=A0 =C2=A0 =C2=A0qemu_set_irq(s-&gt;ioapic_irq[n], level);<br>
=C2=A0}<br>
<br>
+GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)<br>
+{<br>
+=C2=A0 =C2=A0 GSIState *s;<br>
+<br>
+=C2=A0 =C2=A0 s =3D g_new0(GSIState, 1);<br>
+=C2=A0 =C2=A0 if (kvm_ioapic_in_kernel()) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kvm_pc_setup_irq_routing(pci_<wbr>enabled);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *irqs =3D qemu_allocate_irqs(kvm_pc_gsi_<wbr>h=
andler, s, GSI_NUM_PINS);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *irqs =3D qemu_allocate_irqs(gsi_<wbr>handler,=
 s, GSI_NUM_PINS);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return s;<br>
+}<br>
+<br>
=C2=A0static void ioport80_write(void *opaque, hwaddr addr, uint64_t data,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 unsigned size)<br>
=C2=A0{<br>
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c<br>
index 431965d921..452b107e1b 100644<br>
--- a/hw/i386/pc_piix.c<br>
+++ b/hw/i386/pc_piix.c<br>
@@ -188,14 +188,7 @@ static void pc_init1(MachineState *machine,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xen_load_linux(pcms);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 gsi_state =3D g_malloc0(sizeof(*gsi_state));<br>
-=C2=A0 =C2=A0 if (kvm_ioapic_in_kernel()) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 kvm_pc_setup_irq_routing(pcmc-<wbr>&gt;pci_ena=
bled);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pcms-&gt;gsi =3D qemu_allocate_irqs(kvm_pc_gsi=
_<wbr>handler, gsi_state,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GSI_NUM_P=
INS);<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pcms-&gt;gsi =3D qemu_allocate_irqs(gsi_<wbr>h=
andler, gsi_state, GSI_NUM_PINS);<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 gsi_state =3D pc_gsi_create(&amp;pcms-&gt;gsi, pcmc-&gt;pci_=
enabled);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (pcmc-&gt;pci_enabled) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_bus =3D i440fx_init(host_type,<br>
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c<br>
index 8fad20f314..52261962b8 100644<br>
--- a/hw/i386/pc_q35.c<br>
+++ b/hw/i386/pc_q35.c<br>
@@ -210,14 +210,7 @@ static void pc_q35_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* irq lines */<br>
-=C2=A0 =C2=A0 gsi_state =3D g_malloc0(sizeof(*gsi_state));<br>
-=C2=A0 =C2=A0 if (kvm_ioapic_in_kernel()) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 kvm_pc_setup_irq_routing(pcmc-<wbr>&gt;pci_ena=
bled);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pcms-&gt;gsi =3D qemu_allocate_irqs(kvm_pc_gsi=
_<wbr>handler, gsi_state,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GSI_NUM_P=
INS);<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pcms-&gt;gsi =3D qemu_allocate_irqs(gsi_<wbr>h=
andler, gsi_state, GSI_NUM_PINS);<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 gsi_state =3D pc_gsi_create(&amp;pcms-&gt;gsi, pcmc-&gt;pci_=
enabled);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* create pci host bus */<br>
=C2=A0 =C2=A0 =C2=A0q35_host =3D Q35_HOST_DEVICE(qdev_create(<wbr>NULL, TYP=
E_Q35_HOST_DEVICE));<br>
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h<br>
index b63fc7631e..d0c6b9d469 100644<br>
--- a/include/hw/i386/pc.h<br>
+++ b/include/hw/i386/pc.h<br>
@@ -174,6 +174,8 @@ typedef struct GSIState {<br>
<br>
=C2=A0void gsi_handler(void *opaque, int n, int level);<br>
<br>
+GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);<br>
+<br>
=C2=A0/* vmport.c */<br>
=C2=A0#define TYPE_VMPORT &quot;vmport&quot;<br>
=C2=A0typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);<br=
>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--00000000000092115c05951ca51b--

