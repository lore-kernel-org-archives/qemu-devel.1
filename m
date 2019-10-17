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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69498FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 361DA20872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUPOVrw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361DA20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL7c4-00033h-Rs
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL6zu-0005DE-34
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL6zs-0006Q0-NY
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:43:25 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45935)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iL6zs-0006Pf-Hm
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:43:24 -0400
Received: by mail-oi1-x241.google.com with SMTP id o205so2328948oib.12
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 07:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=jhYyEoWc80v0cXKGF4xnB9nyWjXKx6TF8OV3aNOz9qI=;
 b=pUPOVrw+uusHp27rflzA/hwpUQ4nyQOIuu+7hJBv1ozgYVT3LUp9eJvfJ7puokj39i
 NrMsKOYfzUqfSpqTiFwJ1uovuGPjmCCeXjNR74dOHYQAnM488wZXFDFwJwzhhIhMg9r6
 r7j5PWpfwUS0Nf1e4wq/C4OnyUxjzCrUq1JycK8nESIiRWE14kNUSTHO0QdiMoP4oCdW
 0ekvxn5L1tujnescqsNjU1gkQtoX8K1BtkfqUukvS4dOxKfm3FPNxcJC0MozSRiLtbgW
 V1fdoZMesK6suEzuqWXT+bIDBZX+jyPMRvF5bfhL5GscSvso+HdeA/uIDVzEsjubmc/d
 P+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=jhYyEoWc80v0cXKGF4xnB9nyWjXKx6TF8OV3aNOz9qI=;
 b=NhM29r7AcYQ+nRMxU5hzYlIMvL2HGycT8+CiFFk9N8jj+Vdhc6eHaZiNnBm3O3AbL2
 /yW5Wz3fO/ASvdJtphPCYw9I/X7AZlKW2X3iHyWrAB55aKzLz6s99IVxKOZ7whY4PoWs
 tywiAUcCh7ivX2lrXmytCrmlZlotGMs4KXftx7XZ4Z3/KWAhuEvf4/gf7lyIfw1y6+ev
 64CIfoqnsmnQuLcmFbg3y9ikxTM6golPHfykmVNIGlEnXmQMWDl9TCvqxYBSihvpiEbT
 wcu9eFRTLXXJ0wLstxieWC7+YLZJHkCWNSotFFExT0HNAN0UC6frmfjG06l3Ax9HnJEo
 MuvQ==
X-Gm-Message-State: APjAAAWupdWYzzq7syQMCw/AQpl/pWPpvyXXE1aHzOny/m8/putC/QWH
 u9yoBtj614+tFE6Wd4aYvN7Gp1edy8ZbhPRt3/0=
X-Google-Smtp-Source: APXvYqzberLXObt7P5i4KFNdsg+8EHVGx5o7pI5lJzjmTtciE0umi9YhsRZ9hqL1fxPkFCHs9Z/RziecnQmSI+PmC74=
X-Received: by 2002:aca:4e56:: with SMTP id c83mr3556181oib.53.1571323403635; 
 Thu, 17 Oct 2019 07:43:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Thu, 17 Oct 2019 07:43:22
 -0700 (PDT)
In-Reply-To: <20191015162705.28087-16-philmd@redhat.com>
References: <20191015162705.28087-1-philmd@redhat.com>
 <20191015162705.28087-16-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 17 Oct 2019 16:43:22 +0200
Message-ID: <CAL1e-=jA5Cc--eRrNoSUwnZbKtOzjzN9_XQewanfwaUk10HpYA@mail.gmail.com>
Subject: Re: [PATCH 15/32] piix4: add a i8254 pit controller as specified in
 datasheet
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004d11f705951c3d8b"
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

--0000000000004d11f705951c3d8b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m>
wrote:

> From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>
> Remove i8254 instanciated in malta board, to not have it twice.
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> Message-Id: <20171216090228.28505-10-hpoussin@reactos.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/isa/piix4.c       | 4 ++++
>  hw/mips/mips_malta.c | 4 ----
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>



> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
> index 1bc91b590c..0b0a0ecab1 100644
> --- a/hw/isa/piix4.c
> +++ b/hw/isa/piix4.c
> @@ -30,6 +30,7 @@
>  #include "hw/isa/isa.h"
>  #include "hw/sysbus.h"
>  #include "hw/dma/i8257.h"
> +#include "hw/timer/i8254.h"
>  #include "migration/vmstate.h"
>  #include "sysemu/reset.h"
>  #include "sysemu/runstate.h"
> @@ -165,6 +166,9 @@ static void piix4_realize(PCIDevice *pci_dev, Error
> **errp)
>      /* initialize ISA irqs */
>      isa_bus_irqs(isa_bus, s->isa);
>
> +    /* initialize pit */
> +    i8254_pit_init(isa_bus, 0x40, 0, NULL);
> +
>      /* DMA */
>      i8257_dma_init(isa_bus, 0);
>
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index df247177ca..16d7a0e785 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -45,7 +45,6 @@
>  #include "hw/loader.h"
>  #include "elf.h"
>  #include "hw/timer/mc146818rtc.h"
> -#include "hw/timer/i8254.h"
>  #include "exec/address-spaces.h"
>  #include "hw/sysbus.h"             /* SysBusDevice */
>  #include "qemu/host-utils.h"
> @@ -99,8 +98,6 @@ typedef struct {
>      qemu_irq i8259[16];
>  } MaltaState;
>
> -static ISADevice *pit;
> -
>  static struct _loaderparams {
>      int ram_size, ram_low_size;
>      const char *kernel_filename;
> @@ -1428,7 +1425,6 @@ void mips_malta_init(MachineState *machine)
>      pci_create_simple(pci_bus, piix4_devfn + 2, "piix4-usb-uhci");
>      smbus =3D piix4_pm_init(pci_bus, piix4_devfn + 3, 0x1100,
>                            isa_get_irq(NULL, 9), NULL, 0, NULL);
> -    pit =3D i8254_pit_init(isa_bus, 0x40, 0, NULL);
>      mc146818_rtc_init(isa_bus, 2000, NULL);
>
>      /* generate SPD EEPROM data */
> --
> 2.21.0
>
>
>

--0000000000004d11f705951c3d8b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">From: Herv=C3=A9 Poussineau &lt;<a href=3D"mailto:h=
poussin@reactos.org">hpoussin@reactos.org</a>&gt;<br>
<br>
Remove i8254 instanciated in malta board, to not have it twice.<br>
<br>
Acked-by: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redh=
at.com</a>&gt;<br>
Acked-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini=
@redhat.com</a>&gt;<br>
Signed-off-by: Herv=C3=A9 Poussineau &lt;<a href=3D"mailto:hpoussin@reactos=
.org">hpoussin@reactos.org</a>&gt;<br>
Message-Id: &lt;<a href=3D"mailto:20171216090228.28505-10-hpoussin@reactos.=
org">20171216090228.28505-10-hpoussin@reactos.org</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/isa/piix4.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 ++++<br>
=C2=A0hw/mips/mips_malta.c | 4 ----<br>
=C2=A02 files changed, 4 insertions(+), 4 deletions(-)<br>
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
=3D"V j td"></div></div></div></div></div></div><div><br></div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">
diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c<br>
index 1bc91b590c..0b0a0ecab1 100644<br>
--- a/hw/isa/piix4.c<br>
+++ b/hw/isa/piix4.c<br>
@@ -30,6 +30,7 @@<br>
=C2=A0#include &quot;hw/isa/isa.h&quot;<br>
=C2=A0#include &quot;hw/sysbus.h&quot;<br>
=C2=A0#include &quot;hw/dma/i8257.h&quot;<br>
+#include &quot;hw/timer/i8254.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;sysemu/reset.h&quot;<br>
=C2=A0#include &quot;sysemu/runstate.h&quot;<br>
@@ -165,6 +166,9 @@ static void piix4_realize(PCIDevice *pci_dev, Error **e=
rrp)<br>
=C2=A0 =C2=A0 =C2=A0/* initialize ISA irqs */<br>
=C2=A0 =C2=A0 =C2=A0isa_bus_irqs(isa_bus, s-&gt;isa);<br>
<br>
+=C2=A0 =C2=A0 /* initialize pit */<br>
+=C2=A0 =C2=A0 i8254_pit_init(isa_bus, 0x40, 0, NULL);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* DMA */<br>
=C2=A0 =C2=A0 =C2=A0i8257_dma_init(isa_bus, 0);<br>
<br>
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c<br>
index df247177ca..16d7a0e785 100644<br>
--- a/hw/mips/mips_malta.c<br>
+++ b/hw/mips/mips_malta.c<br>
@@ -45,7 +45,6 @@<br>
=C2=A0#include &quot;hw/loader.h&quot;<br>
=C2=A0#include &quot;elf.h&quot;<br>
=C2=A0#include &quot;hw/timer/mc146818rtc.h&quot;<br>
-#include &quot;hw/timer/i8254.h&quot;<br>
=C2=A0#include &quot;exec/address-spaces.h&quot;<br>
=C2=A0#include &quot;hw/sysbus.h&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* SysBusDevice */<br>
=C2=A0#include &quot;qemu/host-utils.h&quot;<br>
@@ -99,8 +98,6 @@ typedef struct {<br>
=C2=A0 =C2=A0 =C2=A0qemu_irq i8259[16];<br>
=C2=A0} MaltaState;<br>
<br>
-static ISADevice *pit;<br>
-<br>
=C2=A0static struct _loaderparams {<br>
=C2=A0 =C2=A0 =C2=A0int ram_size, ram_low_size;<br>
=C2=A0 =C2=A0 =C2=A0const char *kernel_filename;<br>
@@ -1428,7 +1425,6 @@ void mips_malta_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0pci_create_simple(pci_bus, piix4_devfn + 2, &quot;piix4=
-usb-uhci&quot;);<br>
=C2=A0 =C2=A0 =C2=A0smbus =3D piix4_pm_init(pci_bus, piix4_devfn + 3, 0x110=
0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0isa_get_irq(NULL, 9), NULL, 0, NULL);<br>
-=C2=A0 =C2=A0 pit =3D i8254_pit_init(isa_bus, 0x40, 0, NULL);<br>
=C2=A0 =C2=A0 =C2=A0mc146818_rtc_init(isa_bus, 2000, NULL);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* generate SPD EEPROM data */<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--0000000000004d11f705951c3d8b--

