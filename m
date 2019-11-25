Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F30C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:35:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 518462075C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uukF84kx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518462075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZEWM-00079g-GF
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 08:35:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZEUl-0006Vt-4Z
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:33:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZEUj-0005tU-6O
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:33:38 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35450)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iZEUj-0005tL-03
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:33:37 -0500
Received: by mail-oi1-x242.google.com with SMTP id a69so5868299oib.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 05:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6tSoZI28chrqUi6A56hNroVLnoO/wmzoRqwPg7tBxqA=;
 b=uukF84kxTX6seYEpxAzstaTf5JYIB3oWZ9QROm/9C4OnXsfUqGKaOMISrDAbCcAVYe
 Gvf7XJYm8j3Zy/QPsunq3ajeaUJgIbVzDcCTvXfM/5tI6fa2vwxqK6cTAm34c4VLROVn
 AAaTOwxN0LhsVLOZK4PBz4pS7HibUAOkRPH/QnCytDAv3c/5e0CVAELIKzZC9uVFeBJe
 U0KvNQ1C8PL54qX4Q2djJ7EfER9yER3UFmTwpe3T0JZQt0g3JrRLYQ970F35g0vop99f
 alvQlItufo6Myo2lZ6Mt2KgziWe4Pb20o+eUlVUQfyDKZnoApBD6QPz6gnOymgxZl8XS
 3Wmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6tSoZI28chrqUi6A56hNroVLnoO/wmzoRqwPg7tBxqA=;
 b=sRyL4f7G1wbhtrC9/cUURhJJR/K3MMcjnSn6/XP1wyEPEefnOf/I4elcpWaazdSMPp
 D7NnbXatvOjVQXYqfwDM9UWw2EjDR4dhCmUv4C/D1vhQ7W1TFAlnam9MQmoYf3uhu3vX
 AfOMJxgxdks05zbagl92iwqDOOLlvZWzWtjMPlnwbUNd0k0VAKcxN7t199e6K2B/xiko
 QN4ctH/EdLcB6MHIGuTUdFNzu5j17k1flm962PmeWZV3bPRuDN6pIJ2iOa9zqYv7WHkh
 0upAYsHPG1oxzN6HVkY3vkmEKsGXPyGCpvbcvwQKcfeR1+PMHLBms62OpDrpCT7E5Jki
 HzfA==
X-Gm-Message-State: APjAAAWDRvZvW8NhkIRqPVho/d05BQ0lk+Fth4mSiYOAaiAj8nqYeMCg
 94H61eU9LArwf2IeHz5r2H62BB4dwdGMA2xmtwk3Kb80
X-Google-Smtp-Source: APXvYqwV9Xg2Me45vHmm7qvq1v/d0VnZtHbt1p8yEqZgd8CzayJ0ZUi/MKf5hfwbADIvum+2ZgHnsrwQF1Tf+9XQrsg=
X-Received: by 2002:aca:484f:: with SMTP id v76mr23169561oia.62.1574688816016; 
 Mon, 25 Nov 2019 05:33:36 -0800 (PST)
MIME-Version: 1.0
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-18-marcandre.lureau@redhat.com>
 <CAL1e-=iqhBRcscTEDHczoqTGbCZnu386AX-WHnVdq-0uYA25ug@mail.gmail.com>
 <CAMxuvaxeNQae2iN63CvskxjOiug3dTocaqri4rU9fO6nkz+2Hw@mail.gmail.com>
In-Reply-To: <CAMxuvaxeNQae2iN63CvskxjOiug3dTocaqri4rU9fO6nkz+2Hw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 25 Nov 2019 14:33:25 +0100
Message-ID: <CAL1e-=iYiqdo2owtZk=BXwkBYchE8UbfkceZO_ncNJrVCadSUw@mail.gmail.com>
Subject: Re: [PATCH v4 17/37] mips: inline serial_init()
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000082afea05982bcfd6"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000082afea05982bcfd6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Monday, November 25, 2019, Marc-Andr=C3=A9 Lureau <marcandre.lureau@redh=
at.com>
wrote:

> Hi
>
> On Mon, Nov 25, 2019 at 2:12 PM Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
> >
> >
> >
> > On Wednesday, November 20, 2019, Marc-Andr=C3=A9 Lureau <
> marcandre.lureau@redhat.com> wrote:
> >>
> >> The function is specific to mipssim, let's inline it.
> >>
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> ---
> >>  hw/char/serial.c         | 16 ----------------
> >>  hw/mips/mips_mipssim.c   | 15 ++++++++++++---
> >>  include/hw/char/serial.h |  2 --
> >>  3 files changed, 12 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/hw/char/serial.c b/hw/char/serial.c
> >> index 164146ede8..23f0b02516 100644
> >> --- a/hw/char/serial.c
> >> +++ b/hw/char/serial.c
> >> @@ -1023,22 +1023,6 @@ static const TypeInfo serial_io_info =3D {
> >>      .class_init =3D serial_io_class_init,
> >>  };
> >>
> >> -SerialIO *serial_init(int base, qemu_irq irq, int baudbase,
> >> -                         Chardev *chr, MemoryRegion *system_io)
> >> -{
> >> -    SerialIO *sio =3D SERIAL_IO(qdev_create(NULL, TYPE_SERIAL_IO));
> >> -
> >> -    qdev_prop_set_uint32(DEVICE(sio), "baudbase", baudbase);
> >> -    qdev_prop_set_chr(DEVICE(sio), "chardev", chr);
> >> -    qdev_set_legacy_instance_id(DEVICE(sio), base, 2);
> >> -    qdev_init_nofail(DEVICE(sio));
> >> -
> >> -    sysbus_connect_irq(SYS_BUS_DEVICE(sio), 0, irq);
> >> -    memory_region_add_subregion(system_io, base, &sio->serial.io);
> >> -
> >> -    return sio;
> >> -}
> >> -
> >>  static Property serial_properties[] =3D {
> >>      DEFINE_PROP_CHR("chardev", SerialState, chr),
> >>      DEFINE_PROP_UINT32("baudbase", SerialState, baudbase, 115200),
> >> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> >> index 282bbecb24..bfafa4d7e9 100644
> >> --- a/hw/mips/mips_mipssim.c
> >> +++ b/hw/mips/mips_mipssim.c
> >> @@ -40,6 +40,7 @@
> >>  #include "hw/loader.h"
> >>  #include "elf.h"
> >>  #include "hw/sysbus.h"
> >> +#include "hw/qdev-properties.h"
> >>  #include "exec/address-spaces.h"
> >>  #include "qemu/error-report.h"
> >>  #include "sysemu/qtest.h"
> >> @@ -219,9 +220,17 @@ mips_mipssim_init(MachineState *machine)
> >>       * A single 16450 sits at offset 0x3f8. It is attached to
> >>       * MIPS CPU INT2, which is interrupt 4.
> >>       */
> >> -    if (serial_hd(0)) a
> >> -        serial_init(0x3f8, env->irq[4], 115200, serial_hd(0),
> >> -                    get_system_io());
> >> +    if (serial_hd(0)) {
> >> +        DeviceState *dev =3D qdev_create(NULL, TYPE_SERIAL_IO);
> >> +
> >> +        qdev_prop_set_uint32(DEVICE(dev), "baudbase", 115200);
> >> +        qdev_prop_set_chr(dev, "chardev", serial_hd(0));
> >> +        qdev_set_legacy_instance_id(dev, 0x3f8, 2);
> >> +        qdev_init_nofail(dev);
> >> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
> >> +        memory_region_add_subregion(get_system_io(), 0x3f8,
> >> +                                    &SERIAL_IO(dev)->serial.io);
> >> +    }
> >
> >
> >
> > Please explain why the code in the deleted function and the new functio=
n
> are not identical. Why is the new code better?
>
> What differences do you spot?
>
> serial_init() looks very generic, but it is not, and this is
> confusing. QDev users should call qdev_create().
>
> If there is a single user, it is better to inline the code where it is
> being used, or move the function there.
>
>
Marc-Andre, you misunderstood me: I am not complaining about inlining at
all, I would do the same if I were you.

I just see you expressed the same thing from former function in a slightly
different way in the inlined version, and they look functionally equivalent
to me. But I suppose the new way is better, and I want to know why. Is it a
more standard way, or something even more? Please understand that I don't
come from device emulation background - I want to learn a little bit about
device-related QEMU customs and conventions, that is all. :)

For example,

in old version:

>> -SerialIO *serial_init(int base, qemu_irq irq, int baudbase,
>> -                         Chardev *chr, MemoryRegion *system_io)
>> -{
>> -    SerialIO *sio =3D SERIAL_IO(qdev_create(NULL, TYPE_SERIAL_IO));
>> -
>> -    qdev_prop_set_uint32(DEVICE(sio), "baudbase", baudbase);
>> -    qdev_prop_set_chr(DEVICE(sio), "chardev", chr);
>> -    qdev_set_legacy_instance_id(DEVICE(sio), base, 2);
>> -    qdev_init_nofail(DEVICE(sio));
>> -
>> -    sysbus_connect_irq(SYS_BUS_DEVICE(sio), 0, irq);
>> -    memory_region_add_subregion(system_io, base, &sio->serial.io);
>> -
>> -    return sio;
>> -}

in new version:

 >> +    if (serial_hd(0)) {
>> +        DeviceState *dev =3D qdev_create(NULL, TYPE_SERIAL_IO);
>> +
>> +        qdev_prop_set_uint32(DEVICE(dev), "baudbase", 115200);
>> +        qdev_prop_set_chr(dev, "chardev", serial_hd(0));   <-- you
didn't use here DEVICE(), while it is used in the previous line, and also
in the old version, and similar questions
>> +        qdev_set_legacy_instance_id(dev, 0x3f8, 2);
>> +        qdev_init_nofail(dev);
>> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
>> +        memory_region_add_subregion(get_system_io(), 0x3f8,
>> +                                    &SERIAL_IO(dev)->serial.io);
>> +    }

For you all these details are probably perfectly natural and obvois, but
not for me.


Yours, Aleksandar

--00000000000082afea05982bcfd6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Monday, November 25, 2019, Marc-Andr=C3=A9 Lure=
au &lt;<a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_blank">mar=
candre.lureau@redhat.com</a>&gt; wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">H=
i<br>
<br>
On Mon, Nov 25, 2019 at 2:12 PM Aleksandar Markovic<br>
&lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com" target=3D"_blank">aleksa=
ndar.m.mail@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Wednesday, November 20, 2019, Marc-Andr=C3=A9 Lureau &lt;<a href=3D=
"mailto:marcandre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@red=
hat.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; The function is specific to mipssim, let&#39;s inline it.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcan=
dre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt=
;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 hw/char/serial.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 16 -----=
-----------<br>
&gt;&gt;=C2=A0 hw/mips/mips_mipssim.c=C2=A0 =C2=A0| 15 ++++++++++++---<br>
&gt;&gt;=C2=A0 include/hw/char/serial.h |=C2=A0 2 --<br>
&gt;&gt;=C2=A0 3 files changed, 12 insertions(+), 21 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/hw/char/serial.c b/hw/char/serial.c<br>
&gt;&gt; index 164146ede8..23f0b02516 100644<br>
&gt;&gt; --- a/hw/char/serial.c<br>
&gt;&gt; +++ b/hw/char/serial.c<br>
&gt;&gt; @@ -1023,22 +1023,6 @@ static const TypeInfo serial_io_info =3D {<=
br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 .class_init =3D serial_io_class_init,<br>
&gt;&gt;=C2=A0 };<br>
&gt;&gt;<br>
&gt;&gt; -SerialIO *serial_init(int base, qemu_irq irq, int baudbase,<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0Chardev *chr, MemoryRegion *system_io)<br>
&gt;&gt; -{<br>
&gt;&gt; -=C2=A0 =C2=A0 SerialIO *sio =3D SERIAL_IO(qdev_create(NULL, TYPE_=
SERIAL_IO));<br>
&gt;&gt; -<br>
&gt;&gt; -=C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(sio), &quot;baudbase&qu=
ot;, baudbase);<br>
&gt;&gt; -=C2=A0 =C2=A0 qdev_prop_set_chr(DEVICE(sio), &quot;chardev&quot;,=
 chr);<br>
&gt;&gt; -=C2=A0 =C2=A0 qdev_set_legacy_instance_id(DEVICE(sio), base, 2);<=
br>
&gt;&gt; -=C2=A0 =C2=A0 qdev_init_nofail(DEVICE(sio));<br>
&gt;&gt; -<br>
&gt;&gt; -=C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(sio), 0, irq);<br=
>
&gt;&gt; -=C2=A0 =C2=A0 memory_region_add_subregion(system_io, base, &amp;s=
io-&gt;<a href=3D"http://serial.io" target=3D"_blank">serial.io</a>);<br>
&gt;&gt; -<br>
&gt;&gt; -=C2=A0 =C2=A0 return sio;<br>
&gt;&gt; -}<br>
&gt;&gt; -<br>
&gt;&gt;=C2=A0 static Property serial_properties[] =3D {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_CHR(&quot;chardev&quot;, SerialSta=
te, chr),<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;baudbase&quot;, Seria=
lState, baudbase, 115200),<br>
&gt;&gt; diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c<br>
&gt;&gt; index 282bbecb24..bfafa4d7e9 100644<br>
&gt;&gt; --- a/hw/mips/mips_mipssim.c<br>
&gt;&gt; +++ b/hw/mips/mips_mipssim.c<br>
&gt;&gt; @@ -40,6 +40,7 @@<br>
&gt;&gt;=C2=A0 #include &quot;hw/loader.h&quot;<br>
&gt;&gt;=C2=A0 #include &quot;elf.h&quot;<br>
&gt;&gt;=C2=A0 #include &quot;hw/sysbus.h&quot;<br>
&gt;&gt; +#include &quot;hw/qdev-properties.h&quot;<br>
&gt;&gt;=C2=A0 #include &quot;exec/address-spaces.h&quot;<br>
&gt;&gt;=C2=A0 #include &quot;qemu/error-report.h&quot;<br>
&gt;&gt;=C2=A0 #include &quot;sysemu/qtest.h&quot;<br>
&gt;&gt; @@ -219,9 +220,17 @@ mips_mipssim_init(MachineState *machine)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* A single 16450 sits at offset 0x3f8. I=
t is attached to<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* MIPS CPU INT2, which is interrupt 4.<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;&gt; -=C2=A0 =C2=A0 if (serial_hd(0)) a<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 serial_init(0x3f8, env-&gt;irq[4], 11=
5200, serial_hd(0),<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 get_system_io());<br>
&gt;&gt; +=C2=A0 =C2=A0 if (serial_hd(0)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 DeviceState *dev =3D qdev_create(NULL=
, TYPE_SERIAL_IO);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(dev), &qu=
ot;baudbase&quot;, 115200);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_chr(dev, &quot;chardev&=
quot;, serial_hd(0));<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_set_legacy_instance_id(dev, 0x3f=
8, 2);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_init_nofail(dev);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(dev=
), 0, env-&gt;irq[4]);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_add_subregion(get_syste=
m_io(), 0x3f8,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;SERIAL_=
IO(dev)-&gt;<a href=3D"http://serial.io" target=3D"_blank">serial.io</a>);<=
br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Please explain why the code in the deleted function and the new functi=
on are not identical. Why is the new code better?<br>
<br>
What differences do you spot?<br>
<br>
serial_init() looks very generic, but it is not, and this is<br>
confusing. QDev users should call qdev_create().<br>
<br>
If there is a single user, it is better to inline the code where it is<br>
being used, or move the function there.<br>
<br>
</blockquote><div><br></div><div>Marc-Andre, you misunderstood me: I am not=
 complaining about inlining at all, I would do the same if I were you.</div=
><div><br></div><div>I just see you expressed the same thing from former fu=
nction in a slightly different way in the inlined version, and they look fu=
nctionally equivalent to me. But I suppose the new way is better, and I wan=
t to know why. Is it a more standard way, or something even more? Please un=
derstand that I don&#39;t come from device emulation background - I want to=
 learn a little bit about device-related QEMU customs and conventions, that=
 is all. :)</div><div><br></div><div>For example,=C2=A0</div><div><br></div=
><div>in old version:<br></div><div><br></div>&gt;&gt; -SerialIO *serial_in=
it(int base, qemu_irq irq, int baudbase,<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0Chardev *chr, MemoryRegion *system_io)<br>
&gt;&gt; -{<br>
&gt;&gt; -=C2=A0 =C2=A0 SerialIO *sio =3D SERIAL_IO(qdev_create(NULL, TYPE_=
SERIAL_IO));<br>
&gt;&gt; -<br>
&gt;&gt; -=C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(sio), &quot;baudbase&qu=
ot;, baudbase);<br>
&gt;&gt; -=C2=A0 =C2=A0 qdev_prop_set_chr(DEVICE(sio), &quot;chardev&quot;,=
 chr);<br>
&gt;&gt; -=C2=A0 =C2=A0 qdev_set_legacy_instance_id(DEVICE(sio), base, 2);<=
br>
&gt;&gt; -=C2=A0 =C2=A0 qdev_init_nofail(DEVICE(sio));<br>
&gt;&gt; -<br>
&gt;&gt; -=C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(sio), 0, irq);<br=
>
&gt;&gt; -=C2=A0 =C2=A0 memory_region_add_subregion(system_io, base, &amp;s=
io-&gt;<a href=3D"http://serial.io" target=3D"_blank">serial.io</a>);<br>
&gt;&gt; -<br>
&gt;&gt; -=C2=A0 =C2=A0 return sio;<br>
&gt;&gt; -}<br><div><br></div><div>in new version:<br></div><div><br></div>=
<div>=C2=A0&gt;&gt; +=C2=A0 =C2=A0 if (serial_hd(0)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 DeviceState *dev =3D qdev_create(NULL=
, TYPE_SERIAL_IO);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(dev), &qu=
ot;baudbase&quot;, 115200);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_chr(dev, &quot;chardev&=
quot;, serial_hd(0));=C2=A0 =C2=A0&lt;-- you didn&#39;t use here DEVICE(), =
while it is used in the previous line, and also in the old version, and sim=
ilar questions<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_set_legacy_instance_id(dev, 0x3f=
8, 2);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_init_nofail(dev);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(dev=
), 0, env-&gt;irq[4]);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_add_subregion(get_syste=
m_io(), 0x3f8,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;SERIAL_=
IO(dev)-&gt;<a href=3D"http://serial.io" target=3D"_blank">serial.io</a>);<=
br>
&gt;&gt; +=C2=A0 =C2=A0 }<br></div><div><br></div><div>For you all these de=
tails are probably perfectly natural and obvois, but not for me.</div><div>=
<br></div><div><br></div><div>Yours, Aleksandar</div>
</div>

--00000000000082afea05982bcfd6--

