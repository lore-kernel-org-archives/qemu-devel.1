Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB72C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 01:19:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3619620B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 01:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDvyf3Cq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3619620B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIN6c-0003oP-Uc
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 21:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iIN36-0000L4-2u
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 21:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iIN34-0006F8-MD
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 21:15:24 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37932)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>)
 id 1iIN34-0006Eq-Em; Wed, 09 Oct 2019 21:15:22 -0400
Received: by mail-ot1-x343.google.com with SMTP id e11so3424243otl.5;
 Wed, 09 Oct 2019 18:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1YAtLzfc3GUW3MWav/m+rykDlOflhVu8LwsJL1Kg5KQ=;
 b=HDvyf3CqfTh4y+LOzhemiDmv4zeP/db/IX8//oy3vxa/kzOA2mBS0QVUB+S8nyU0H6
 SwOOVa6izpkBkFnmvNXSX0d34Xa4oSesGO1Vzc86J5HGhQ6G2y4kqZhdsNXixevq9Jm0
 eigNKyvUk9S8AVoZES/MROn39WNs2f8c7bgWL7LJUYNRZRDKGnojbf8QDLbJWpuVQa7j
 Yc8d6X/izTMz6f4m/qA9KDLmByHLONccEwLnOk+qr0wjGA/oMRor2OYFUd0iQW7aF93m
 XTPHpycyZChVE5s9+/GJHclSzBURyjVu10r3C8chYuf/J8ySUYotnHshV+xfscePk1G0
 hAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1YAtLzfc3GUW3MWav/m+rykDlOflhVu8LwsJL1Kg5KQ=;
 b=Ckb0wfiwFFQ6aFaoR7ewmt91xizOf8o+X1R3qxhCsQcmdqQLqERdfJEa5q1prNisEO
 ElO1Hs+vHIzUjRINlqBtCNuTICs+NyATKaXCFplcW8Q6Mvr3FBHlYUz8BAakqcuRZZz3
 E0FawtuMXfmJu9Cv9UXmOWiX19NVSL+JvPQbbig9YmYFYy0gh8kJeVsJCf5O4ggXEiPe
 G6FOdxCjvV6u4/TXXd3lnaVArkFXuWc90IFF/T69gbY5w4of14wZgAKBOFJR0U+bWVZI
 Ddz1danr0hZ1S6YzzxpRDyzMbiZNxyk94XBEhKbVd/UDctTgdgMRDvQmtkBH4dkomQnI
 Wg5Q==
X-Gm-Message-State: APjAAAUIBfWNWr78X2rdu3cMla/GZBbrPls5wDxQNFLKEPpq9Xa/jPHG
 bBNFrOGjsxESqtlMHieobiyCm3FFFhudkUsmj+I=
X-Google-Smtp-Source: APXvYqws3NlMdXKm3lnE4N9bKcVhwACkq+AOEDE4ptTIXB9b8VoyAt2Ncic5vK9iuNykmCz2qetbl18lhU+XpaV+cZ0=
X-Received: by 2002:a9d:6d11:: with SMTP id o17mr2312110otp.333.1570670121662; 
 Wed, 09 Oct 2019 18:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191008142539.7793-1-philmd@redhat.com>
 <20191008142539.7793-8-philmd@redhat.com>
In-Reply-To: <20191008142539.7793-8-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 10 Oct 2019 09:14:45 +0800
Message-ID: <CAKXe6SJbRv5xDNA91k+AKLghog6KKbzE_mCK4JuZWKnLctY_5A@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] hw/input/lm832x: Convert reset handler to
 DeviceReset
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a93c470594842279"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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

--000000000000a93c470594842279
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B410=E6=
=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:38=E5=86=99=E9=81=
=93=EF=BC=9A

> The LM8323 key-scan controller is a I2C device, it will be reset
> when the I2C bus it stands on is reset.
>
> Convert its reset handler into a proper Device reset method.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>

Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  hw/input/lm832x.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/hw/input/lm832x.c b/hw/input/lm832x.c
> index a37eb854b9..aa629ddbf1 100644
> --- a/hw/input/lm832x.c
> +++ b/hw/input/lm832x.c
> @@ -24,7 +24,6 @@
>  #include "migration/vmstate.h"
>  #include "qemu/module.h"
>  #include "qemu/timer.h"
> -#include "sysemu/reset.h"
>  #include "ui/console.h"
>
>  #define TYPE_LM8323 "lm8323"
> @@ -94,8 +93,10 @@ static void lm_kbd_gpio_update(LM823KbdState *s)
>  {
>  }
>
> -static void lm_kbd_reset(LM823KbdState *s)
> +static void lm_kbd_reset(DeviceState *dev)
>  {
> +    LM823KbdState *s =3D LM8323(dev);
> +
>      s->config =3D 0x80;
>      s->status =3D INT_NOINIT;
>      s->acttime =3D 125;
> @@ -273,7 +274,7 @@ static void lm_kbd_write(LM823KbdState *s, int reg,
> int byte, uint8_t value)
>
>      case LM832x_CMD_RESET:
>          if (value =3D=3D 0xaa)
> -            lm_kbd_reset(s);
> +            lm_kbd_reset(DEVICE(s));
>          else
>              lm_kbd_error(s, ERR_BADPAR);
>          s->reg =3D LM832x_GENERAL_ERROR;
> @@ -476,10 +477,6 @@ static void lm8323_realize(DeviceState *dev, Error
> **errp)
>      s->pwm.tm[1] =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, lm_kbd_pwm1_tick, =
s);
>      s->pwm.tm[2] =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, lm_kbd_pwm2_tick, =
s);
>      qdev_init_gpio_out(dev, &s->nirq, 1);
> -
> -    lm_kbd_reset(s);
> -
> -    qemu_register_reset((void *) lm_kbd_reset, s);
>  }
>
>  void lm832x_key_event(DeviceState *dev, int key, int state)
> @@ -507,6 +504,7 @@ static void lm8323_class_init(ObjectClass *klass, voi=
d
> *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
>
> +    dc->reset =3D lm_kbd_reset;
>      dc->realize =3D lm8323_realize;
>      k->event =3D lm_i2c_event;
>      k->recv =3D lm_i2c_rx;
> --
> 2.21.0
>
>
>

--000000000000a93c470594842279
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =E4=BA=8E2019=E5=
=B9=B410=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:38=E5=86=
=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">The LM8323 key-scan controller is a I2C device, it will be reset<br>
when the I2C bus it stands on is reset.<br>
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
=C2=A0hw/input/lm832x.c | 12 +++++-------<br>
=C2=A01 file changed, 5 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/hw/input/lm832x.c b/hw/input/lm832x.c<br>
index a37eb854b9..aa629ddbf1 100644<br>
--- a/hw/input/lm832x.c<br>
+++ b/hw/input/lm832x.c<br>
@@ -24,7 +24,6 @@<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
=C2=A0#include &quot;qemu/timer.h&quot;<br>
-#include &quot;sysemu/reset.h&quot;<br>
=C2=A0#include &quot;ui/console.h&quot;<br>
<br>
=C2=A0#define TYPE_LM8323 &quot;lm8323&quot;<br>
@@ -94,8 +93,10 @@ static void lm_kbd_gpio_update(LM823KbdState *s)<br>
=C2=A0{<br>
=C2=A0}<br>
<br>
-static void lm_kbd_reset(LM823KbdState *s)<br>
+static void lm_kbd_reset(DeviceState *dev)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 LM823KbdState *s =3D LM8323(dev);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;config =3D 0x80;<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;status =3D INT_NOINIT;<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;acttime =3D 125;<br>
@@ -273,7 +274,7 @@ static void lm_kbd_write(LM823KbdState *s, int reg, int=
 byte, uint8_t value)<br>
<br>
=C2=A0 =C2=A0 =C2=A0case LM832x_CMD_RESET:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value =3D=3D 0xaa)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lm_kbd_reset(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lm_kbd_reset(DEVICE(s));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lm_kbd_error(s, ERR_BADPAR)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;reg =3D LM832x_GENERAL_ERROR;<br>
@@ -476,10 +477,6 @@ static void lm8323_realize(DeviceState *dev, Error **e=
rrp)<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;<a href=3D"http://pwm.tm" rel=3D"noreferrer" targ=
et=3D"_blank">pwm.tm</a>[1] =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, lm_kbd_pwm=
1_tick, s);<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;<a href=3D"http://pwm.tm" rel=3D"noreferrer" targ=
et=3D"_blank">pwm.tm</a>[2] =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, lm_kbd_pwm=
2_tick, s);<br>
=C2=A0 =C2=A0 =C2=A0qdev_init_gpio_out(dev, &amp;s-&gt;nirq, 1);<br>
-<br>
-=C2=A0 =C2=A0 lm_kbd_reset(s);<br>
-<br>
-=C2=A0 =C2=A0 qemu_register_reset((void *) lm_kbd_reset, s);<br>
=C2=A0}<br>
<br>
=C2=A0void lm832x_key_event(DeviceState *dev, int key, int state)<br>
@@ -507,6 +504,7 @@ static void lm8323_class_init(ObjectClass *klass, void =
*data)<br>
=C2=A0 =C2=A0 =C2=A0DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
=C2=A0 =C2=A0 =C2=A0I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);<br>
<br>
+=C2=A0 =C2=A0 dc-&gt;reset =3D lm_kbd_reset;<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;realize =3D lm8323_realize;<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;event =3D lm_i2c_event;<br>
=C2=A0 =C2=A0 =C2=A0k-&gt;recv =3D lm_i2c_rx;<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote></div></div>

--000000000000a93c470594842279--

