Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A84C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 00:09:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A227822440
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 00:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPMe//YG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A227822440
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXDYK-0004Fx-ND
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 19:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXDXG-0003gv-Ou
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 19:07:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXDXF-000068-2Q
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 19:07:54 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45108)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iXDXE-00005B-Q3; Tue, 19 Nov 2019 19:07:53 -0500
Received: by mail-oi1-x241.google.com with SMTP id 14so20780823oir.12;
 Tue, 19 Nov 2019 16:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=SD1sSRLcewma8NqVVVKtNm5KTDYVgHw1jASSePwSle8=;
 b=nPMe//YGN5C8D+ECD0sKlBQo5v0Yjmc/NASRSvnUy3wwmIk2BM5W9liAU+Ha4IAiCa
 dzK+R4qBjiJ0FMe6hc/LfEs1XQODEkpSiPhMIQ6PdiNsOX5VAK4cC7Y0/WaZK+2+75zS
 Plsyv/0H/ArSgySFak4z3KfcHlHOO0U0byCMQrvSJkYtAVEOwAhwilo4SySoNmuCTYDP
 o8VtWrIC0QPPm7+pVt8/k70sylU3CTNlUanuNQ1k0fOQYO0gAZwmQ2tfcAn+6HKiUO1K
 YXXcdflk/48GuW2Nf9q0ErWCd8K28Zm87e/y5DjiihWqLGl0EJMJf5y33YNp5lA3Xcl1
 8raA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=SD1sSRLcewma8NqVVVKtNm5KTDYVgHw1jASSePwSle8=;
 b=TOMaL5EVVZ/04tJKGJGm09Dp1dP5yYrge/vNcf/X0wXtWGXBmserYX2cv8BKgM686z
 LB909ubxhypQmIAmAQv7JKZ5m9GoDWNXBFT2Eko91sWfaVH2dGkWD8dLfvVucDNylb98
 6aTMPItfpYHG6RS1u3/xYOGHnYo8AQcQGac7sjfs3wMAoTfV48vrni5465HXKghFizUB
 w+KZSku9x+HfkRhDC7mG09odL4zLxjBfLrO+drq/c5lNVRDnAQCM/RYK788Y1NW1/o7U
 zPkAAKLZllDXO/mZp+vNaOlWbHffiey6RF8ZlMIRbod6X4CVrhqBa/sOpwxURMTliZAG
 E1cA==
X-Gm-Message-State: APjAAAVEoOK0yoMIxZAzqfZFNlMf09iNuP2EeSOM5xiRjL/yxVorl3ZH
 tEiIlRoQHv4G9/Y5B49aC7nEmxz52WHs6ym2rhc=
X-Google-Smtp-Source: APXvYqwoiTdHuMZMCRg+c+oCRMzRTcE0qI2GWF070DGtjjX+VIhI6qYrwxS3UgHx7iaWJX/3u5l5Q+ljCBBCL6m08pg=
X-Received: by 2002:aca:650a:: with SMTP id m10mr200819oim.106.1574208471858; 
 Tue, 19 Nov 2019 16:07:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Tue, 19 Nov 2019 16:07:51
 -0800 (PST)
In-Reply-To: <20191023173154.30051-19-marcandre.lureau@redhat.com>
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-19-marcandre.lureau@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 20 Nov 2019 01:07:51 +0100
Message-ID: <CAL1e-=ja_ymoKhj7qaCT9Dvhy_G_F0XL-VMoNYhW5QqJXt3_Ew@mail.gmail.com>
Subject: Re: [PATCH v3 18/33] mips: inline serial_init
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c4849f0597bbf8bd"
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c4849f0597bbf8bd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, October 23, 2019, Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> The function is specific to mipssim, let's inline it.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/char/serial.c         | 16 ----------------
>  hw/mips/mips_mipssim.c   | 13 ++++++++++---
>  include/hw/char/serial.h |  2 --
>  3 files changed, 10 insertions(+), 21 deletions(-)


Marc-Andr=C3=A9, hi!

Mismatch between the commit message and the patch content. Not acceptable.

Yours,
Aleksandar


>
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 84de2740a7..ca95e09ec9 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -1023,22 +1023,6 @@ static const TypeInfo serial_io_info =3D {
>      .class_init =3D serial_io_class_init,
>  };
>
> -SerialIO *serial_init(int base, qemu_irq irq, int baudbase,
> -                         Chardev *chr, MemoryRegion *system_io)
> -{
> -    SerialIO *self =3D SERIAL_IO(qdev_create(NULL, TYPE_SERIAL_IO));
> -
> -    qdev_prop_set_uint32(DEVICE(self), "baudbase", baudbase);
> -    qdev_prop_set_chr(DEVICE(self), "chardev", chr);
> -    qdev_prop_set_int32(DEVICE(self), "instance-id", base);
> -    qdev_init_nofail(DEVICE(self));
> -
> -    sysbus_connect_irq(SYS_BUS_DEVICE(self), 0, irq);
> -    memory_region_add_subregion(system_io, base, &self->serial.io);
> -
> -    return self;
> -}
> -
>  static Property serial_properties[] =3D {
>      DEFINE_PROP_CHR("chardev", SerialState, chr),
>      DEFINE_PROP_UINT32("baudbase", SerialState, baudbase, 115200),
> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> index 282bbecb24..26fb8fa4de 100644
> --- a/hw/mips/mips_mipssim.c
> +++ b/hw/mips/mips_mipssim.c
> @@ -40,6 +40,7 @@
>  #include "hw/loader.h"
>  #include "elf.h"
>  #include "hw/sysbus.h"
> +#include "hw/qdev-properties.h"
>  #include "exec/address-spaces.h"
>  #include "qemu/error-report.h"
>  #include "sysemu/qtest.h"
> @@ -219,9 +220,15 @@ mips_mipssim_init(MachineState *machine)
>       * A single 16450 sits at offset 0x3f8. It is attached to
>       * MIPS CPU INT2, which is interrupt 4.
>       */
> -    if (serial_hd(0))
> -        serial_init(0x3f8, env->irq[4], 115200, serial_hd(0),
> -                    get_system_io());
> +    if (serial_hd(0)) {
> +        DeviceState *dev =3D qdev_create(NULL, TYPE_SERIAL_IO);
> +
> +        qdev_prop_set_chr(dev, "chardev", serial_hd(0));
> +        qdev_prop_set_int32(dev, "instance-id", 0x3f8);
> +        qdev_init_nofail(dev);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
> +        sysbus_add_io(SYS_BUS_DEVICE(dev), 0x3f8, &SERIAL_IO(dev)->
> serial.io);
> +    }
>
>      if (nd_table[0].used)
>          /* MIPSnet uses the MIPS CPU INT0, which is interrupt 2. */
> diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
> index cf9cdafaee..40e35e6fff 100644
> --- a/include/hw/char/serial.h
> +++ b/include/hw/char/serial.h
> @@ -109,8 +109,6 @@ void serial_set_frequency(SerialState *s, uint32_t
> frequency);
>  #define TYPE_SERIAL_IO "serial-io"
>  #define SERIAL_IO(s) OBJECT_CHECK(SerialIO, (s), TYPE_SERIAL_IO)
>
> -SerialIO *serial_init(int base, qemu_irq irq, int baudbase,
> -                      Chardev *chr, MemoryRegion *system_io);
>  SerialMM *serial_mm_init(MemoryRegion *address_space,
>                           hwaddr base, int regshift,
>                           qemu_irq irq, int baudbase,
> --
> 2.23.0.606.g08da6496b6
>
>
>

--000000000000c4849f0597bbf8bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, October 23, 2019, Marc-Andr=C3=A9 Lureau &lt;<a href=
=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;=
 wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">The function is specific to mipss=
im, let&#39;s inline it.<br>
<br>
Signed-off-by:=C2=A0Marc-Andr=C3=A9=C2=A0Lureau=C2=A0&lt;<a href=3D"mailto:=
marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/char/serial.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 16 --------------=
--<br>
=C2=A0hw/mips/mips_mipssim.c=C2=A0 =C2=A0| 13 ++++++++++---<br>
=C2=A0include/hw/char/serial.h |=C2=A0 2 --<br>
=C2=A03 files changed, 10 insertions(+), 21 deletions(-)</blockquote><div><=
br></div><div>Marc-Andr=C3=A9, hi!</div><div><br></div><div>Mismatch betwee=
n the commit message and the patch content. Not acceptable.</div><div><br><=
/div><div>Yours,</div><div>Aleksandar</div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">
<br>
diff --git a/hw/char/serial.c b/hw/char/serial.c<br>
index 84de2740a7..ca95e09ec9 100644<br>
--- a/hw/char/serial.c<br>
+++ b/hw/char/serial.c<br>
@@ -1023,22 +1023,6 @@ static const TypeInfo serial_io_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.class_init =3D serial_io_class_init,<br>
=C2=A0};<br>
<br>
-SerialIO *serial_init(int base, qemu_irq irq, int baudbase,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Chardev *chr, MemoryRegion *system_io)<br>
-{<br>
-=C2=A0 =C2=A0 SerialIO *self =3D SERIAL_IO(qdev_create(NULL, TYPE_SERIAL_I=
O));<br>
-<br>
-=C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(<wbr>self), &quot;baudbase&quot;=
, baudbase);<br>
-=C2=A0 =C2=A0 qdev_prop_set_chr(DEVICE(self)<wbr>, &quot;chardev&quot;, ch=
r);<br>
-=C2=A0 =C2=A0 qdev_prop_set_int32(DEVICE(<wbr>self), &quot;instance-id&quo=
t;, base);<br>
-=C2=A0 =C2=A0 qdev_init_nofail(DEVICE(self))<wbr>;<br>
-<br>
-=C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_<wbr>DEVICE(self), 0, irq);<br>
-=C2=A0 =C2=A0 memory_region_add_subregion(<wbr>system_io, base, &amp;self-=
&gt;<a href=3D"http://serial.io" target=3D"_blank">serial.io</a>);<br>
-<br>
-=C2=A0 =C2=A0 return self;<br>
-}<br>
-<br>
=C2=A0static Property serial_properties[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_CHR(&quot;chardev&quot;, SerialState, chr),=
<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_UINT32(&quot;baudbase&quot;, SerialState, b=
audbase, 115200),<br>
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c<br>
index 282bbecb24..26fb8fa4de 100644<br>
--- a/hw/mips/mips_mipssim.c<br>
+++ b/hw/mips/mips_mipssim.c<br>
@@ -40,6 +40,7 @@<br>
=C2=A0#include &quot;hw/loader.h&quot;<br>
=C2=A0#include &quot;elf.h&quot;<br>
=C2=A0#include &quot;hw/sysbus.h&quot;<br>
+#include &quot;hw/qdev-properties.h&quot;<br>
=C2=A0#include &quot;exec/address-spaces.h&quot;<br>
=C2=A0#include &quot;qemu/error-report.h&quot;<br>
=C2=A0#include &quot;sysemu/qtest.h&quot;<br>
@@ -219,9 +220,15 @@ mips_mipssim_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0 * A single 16450 sits at offset 0x3f8. It is attached =
to<br>
=C2=A0 =C2=A0 =C2=A0 * MIPS CPU INT2, which is interrupt 4.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 if (serial_hd(0))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 serial_init(0x3f8, env-&gt;irq[4], 115200, ser=
ial_hd(0),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_=
system_io());<br>
+=C2=A0 =C2=A0 if (serial_hd(0)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DeviceState *dev =3D qdev_create(NULL, TYPE_SE=
RIAL_IO);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_chr(dev, &quot;chardev&quot;, se=
rial_hd(0));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_int32(dev, &quot;instance-id&quo=
t;, 0x3f8);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_init_nofail(dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_<wbr>DEVICE(dev), 0=
, env-&gt;irq[4]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_add_io(SYS_BUS_DEVICE(<wbr>dev), 0x3f8,=
 &amp;SERIAL_IO(dev)-&gt;<a href=3D"http://serial.io" target=3D"_blank">ser=
ial.io</a>);<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (nd_table[0].used)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* MIPSnet uses the MIPS CPU INT0, which =
is interrupt 2. */<br>
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h<br>
index cf9cdafaee..40e35e6fff 100644<br>
--- a/include/hw/char/serial.h<br>
+++ b/include/hw/char/serial.h<br>
@@ -109,8 +109,6 @@ void serial_set_frequency(<wbr>SerialState *s, uint32_t=
 frequency);<br>
=C2=A0#define TYPE_SERIAL_IO &quot;serial-io&quot;<br>
=C2=A0#define SERIAL_IO(s) OBJECT_CHECK(SerialIO, (s), TYPE_SERIAL_IO)<br>
<br>
-SerialIO *serial_init(int base, qemu_irq irq, int baudbase,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Chardev *chr, MemoryRegion *system_io);<br>
=C2=A0SerialMM *serial_mm_init(MemoryRegion *address_space,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 hwaddr base, int regshift,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 qemu_irq irq, int baudbase,<br>
-- <br>
2.23.0.606.g08da6496b6<br>
<br>
<br>
</blockquote>

--000000000000c4849f0597bbf8bd--

