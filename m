Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E85FC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 14:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D8262226B
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 14:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQxapqb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8262226B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRG92-0004fN-5X
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 10:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <a.tarasenko@gmail.com>)
 id 1kRG7i-00046e-Mk
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 10:45:26 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f]:37893)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <a.tarasenko@gmail.com>)
 id 1kRG7g-00020B-1r
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 10:45:26 -0400
Received: by mail-qk1-x72f.google.com with SMTP id f21so807428qko.5
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 07:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hPYZBmGaNPjwXtRHAD5o/az0iviVR2gj1ckI364wzrE=;
 b=BQxapqb1Fh2QyQ6DSuY1b3vk6HGftbWXNDkryeOak2M9fxr1aFNUVY8mWqcvaOS0zM
 ZloZS1eyI3WNEFFygW1mG18IOXktjyW1m4XfTEl8yJ0JFC9PFXX504ss1g4xYuYks6fL
 UO2TGlCjtgQvPHBXyT7nviTL1VG/5U6JHwXGHnYGV69gwOUhgyeXnjP5feG3NX2ckTAs
 oJRo6MOpVmkT+ACdsiZuArVyitgigSM7+K10bvcIlWYn7svNV6crPsKudCg6MmTqp0Wq
 HItr9jLd3FRWxuSOlx2S1OpbOAXjgpo1VNr5hAheIaDfA9zZqYJWO8g+gP3rfcWuh4uT
 Z3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hPYZBmGaNPjwXtRHAD5o/az0iviVR2gj1ckI364wzrE=;
 b=cuxBLKXjKylOspMjdzoN7p+3nvu9KPCgWy4GzBWHBtkkAPZ+8Gkqv38dopTHyoqb7y
 kcYkH0iZY06REZP5QfgntI5IdCwUbPYuqQgBf3LIJFd47I0BWI9Pco7h9ClxNTR6/jin
 nIJ3tIMDcoH/tk520VvAAy4DlNkDlCFlMIfXEdjDSEb4Xes0fgNPAM8SgY3mXKARJYdq
 dXOw73jD/Q6s03J0BgVHNdenoCdYlG4M/TXXZe2NhjaW0gmj066az8/dWqM24J4bxLXa
 wZQ/BboHVpMvHPRS3rNxG1yaH0i8EUbzDYRuZMf8lcMeoXG/LgiUMdRtDnleWu9gIkQk
 Z4rg==
X-Gm-Message-State: AOAM5304q4DCvfsp4x5PXau23T7pnhLbJbnZABx66Wb4JYhwi0YHwJnH
 LcZvgP/0XRB6TolaJGio1FBvGpnVwjY0676jGhZPidzzCvg=
X-Google-Smtp-Source: ABdhPJxyajpEN5bn7oqK3dGEvjLGioyuHqOp4NaPzUUA1qjLknS8senFHj68JoR9sJyOpdVLdnId7aVrMWB6KIHzkZQ=
X-Received: by 2002:a05:620a:a84:: with SMTP id
 v4mr992008qkg.486.1602341122385; 
 Sat, 10 Oct 2020 07:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200803222049.2967aeda.hc981@poolhem.se>
 <20200919194712.1ddd62cf.hc94@poolhem.se>
In-Reply-To: <20200919194712.1ddd62cf.hc94@poolhem.se>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Sat, 10 Oct 2020 17:44:57 +0300
Message-ID: <CAAM0arOsdhkJoEoXuPRA=Z_dnjJ3EQMuSuJLuDg0Vm=2yvfwFQ@mail.gmail.com>
Subject: Re: Ping2: [PATCH v2] Emulate dip switch language layout settings on
 SUN keyboard
To: Henrik Carlqvist <hc94@poolhem.se>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/alternative; boundary="00000000000068ac2e05b1521daa"
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=a.tarasenko@gmail.com; helo=mail-qk1-x72f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, hc981@poolhem.se
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000068ac2e05b1521daa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

could you please pick it up?

Regards,
Artyom

=D1=81=D0=B1, 19 =D1=81=D0=B5=D0=BD=D1=82. 2020 =D0=B3., 20:47 Henrik Carlq=
vist <hc94@poolhem.se>:

> Just wanted to check that my patch hasn't been forgotten... I was hoping
> that
> it would make it into some branch in git.
>
> Do you want me to do any more changes to the patch or the description?
>
> Best regards Henrik
>
> On Mon, 3 Aug 2020 22:20:49 +0200
> Henrik Carlqvist <hc981@poolhem.se> wrote:
>
> > This is my second attempt to contribute a patch which makes the -k swit=
ch
> > useful for sparc emulation as its value is used to emulate the dip swit=
ch
> > in a SUN keyboard for language layout setting.
> >
> > Unfortunately my glib version is too old to compile later versions of
> qemu
> > so even though this patch is made from latest git I have only been able
> to
> > test it myself with qemu version 4.1.1. I think and hope that this patc=
h
> > will compile and work also with the latest version of git as it only
> affects
> > one file and there hasn't been much changes to that file since tested
> > version 4.1.1.
> >
> > Best regards Henrik
> >
> > From e302b02dec32c28297ed20d852c5fba2c1682f5a Mon Sep 17 00:00:00 2001
> > From: Henrik Carlqvist <hc1245@poolhem.se>
> > Date: Mon, 3 Aug 2020 22:11:55 +0200
> > Subject: [PATCH] Emulating sun keyboard language layout dip switches,
> taking
> >  the value for the dip switches from the "-k" option to qemu.
> >
> > SUN Type 4, 5 and 5c keyboards have dip switches to choose the language
> > layout of the keyboard. Solaris makes an ioctl to query the value of th=
e
> > dipswitches and uses that value to select keyboard layout. Also the SUN
> > bios like the one in the file ss5.bin uses this value to support at lea=
st
> > some keyboard layouts. However, the OpenBIOS provided with qemu is
> > hardcoded to always use an US keyboard layout.
> >
> > Before this patch, qemu allways gave dip switch value 0x21 (US keyboard=
),
> > this patch uses the command line switch "-k" (keyboard layout) to selec=
t
> > dip switch value. A table is used to lookup values from arguments like:
> >
> > -k fr
> > -k es
> >
> > But the patch also accepts numeric dip switch values directly to the -k
> > switch:
> >
> > -k 0x2b
> > -k 43
> >
> > Both values above are the same and select swedish keyboard as explained
> in
> > table 3-15 at
> > https://docs.oracle.com/cd/E19683-01/806-6642/new-43/index.html
> >
> > Unless you want to do a full Solaris installation but happen to have
> > access to a bios file, the easiest way to test that the patch works is
> to:
> >
> > qemu-system-sparc -k sv -bios /path/to/ss5.bin
> >
> > If you already happen to have a Solaris installation in a qemu disk ima=
ge
> > file you can easily try different keyboard layouts after this patch is
> > applied.
> >
> > Signed-off-by: Henrik Carlqvist <hc1245@poolhem.se>
> > ---
> >  hw/char/escc.c | 74
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++++++- 1 file
> changed,
> > 73 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/char/escc.c b/hw/char/escc.c
> > index 7d16ee8688..7287056b5f 100644
> > --- a/hw/char/escc.c
> > +++ b/hw/char/escc.c
> > @@ -30,6 +30,8 @@
> >  #include "qemu/module.h"
> >  #include "hw/char/escc.h"
> >  #include "ui/console.h"
> > +#include "sysemu/sysemu.h"
> > +#include "qemu/cutils.h"
> >  #include "trace.h"
> >
> >  /*
> > @@ -175,6 +177,7 @@
> >  #define R_MISC1I 14
> >  #define R_EXTINT 15
> >
> > +static unsigned char sun_keyboard_layout_dip_switch(void);
> >  static void handle_kbd_command(ESCCChannelState *s, int val);
> >  static int serial_can_receive(void *opaque);
> >  static void serial_receive_byte(ESCCChannelState *s, int ch);
> > @@ -730,6 +733,75 @@ static QemuInputHandler sunkbd_handler =3D {
> >      .event =3D sunkbd_handle_event,
> >  };
> >
> > +static unsigned char sun_keyboard_layout_dip_switch(void)
> > +{
> > +    /* Return the value of the dip-switches in a SUN Type 5 keyboard *=
/
> > +    static unsigned char ret =3D 0xff;
> > +
> > +    if ((ret =3D=3D 0xff) && keyboard_layout) {
> > +        int i;
> > +        struct layout_values {
> > +            const char *lang;
> > +            unsigned char dip;
> > +        } languages[] =3D
> > +    /* Dip values from table 3-16 Layouts for Type 4, 5, and 5c
> Keyboards
> > */+            {
> > +                {"en-us", 0x21}, /* U.S.A. (US5.kt) */
> > +                                 /* 0x22 is some other US
> (US_UNIX5.kt)*/
> > +                {"fr",    0x23}, /* France (France5.kt) */
> > +                {"da",    0x24}, /* Denmark (Denmark5.kt) */
> > +                {"de",    0x25}, /* Germany (Germany5.kt) */
> > +                {"it",    0x26}, /* Italy (Italy5.kt) */
> > +                {"nl",    0x27}, /* The Netherlands (Netherland5.kt) *=
/
> > +                {"no",    0x28}, /* Norway (Norway.kt) */
> > +                {"pt",    0x29}, /* Portugal (Portugal5.kt) */
> > +                {"es",    0x2a}, /* Spain (Spain5.kt) */
> > +                {"sv",    0x2b}, /* Sweden (Sweden5.kt) */
> > +                {"fr-ch", 0x2c}, /* Switzerland/French (Switzer_Fr5.kt=
)
> */
> > +                {"de-ch", 0x2d}, /* Switzerland/German (Switzer_Ge5.kt=
)
> */
> > +                {"en-gb", 0x2e}, /* Great Britain (UK5.kt) */
> > +                {"ko",    0x2f}, /* Korea (Korea5.kt) */
> > +                {"tw",    0x30}, /* Taiwan (Taiwan5.kt) */
> > +                {"ja",    0x31}, /* Japan (Japan5.kt) */
> > +                {"fr-ca", 0x32}, /* Canada/French (Canada_Fr5.kt) */
> > +                {"hu",    0x33}, /* Hungary (Hungary5.kt) */
> > +                {"pl",    0x34}, /* Poland (Poland5.kt) */
> > +                {"cz",    0x35}, /* Czech (Czech5.kt) */
> > +                {"ru",    0x36}, /* Russia (Russia5.kt) */
> > +                {"lv",    0x37}, /* Latvia (Latvia5.kt) */
> > +                {"tr",    0x38}, /* Turkey-Q5 (TurkeyQ5.kt) */
> > +                {"gr",    0x39}, /* Greece (Greece5.kt) */
> > +                {"ar",    0x3a}, /* Arabic (Arabic5.kt) */
> > +                {"lt",    0x3b}, /* Lithuania (Lithuania5.kt) */
> > +                {"nl-be", 0x3c}, /* Belgium (Belgian5.kt) */
> > +                {"be",    0x3c}, /* Belgium (Belgian5.kt) */
> > +            };
> > +
> > +        for (i =3D 0;
> > +             i < sizeof(languages) / sizeof(struct layout_values);
> > +             i++) {
> > +            if (!strcmp(keyboard_layout, languages[i].lang)) {
> > +                ret =3D languages[i].dip;
> > +                return ret;
> > +            }
> > +        }
> > +        /* Found no known language code */
> > +
> > +        if ((keyboard_layout[0] >=3D '0') && (keyboard_layout[0] <=3D =
'9'))
> {
> > +            unsigned int tmp;
> > +            /* As a fallback we also accept numeric dip switch value *=
/
> > +            if (!qemu_strtoui(keyboard_layout, NULL, 0, &tmp)) {
> > +                ret =3D (unsigned char)tmp;
> > +            }
> > +        }
> > +    }
> > +    if (ret =3D=3D 0xff) {
> > +        /* Final fallback if keyboard_layout was not set or recognized
> */
> > +        ret =3D 0x21; /* en-us layout */
> > +    }
> > +    return ret;
> > +}
> > +
> >  static void handle_kbd_command(ESCCChannelState *s, int val)
> >  {
> >      trace_escc_kbd_command(val);
> > @@ -751,7 +823,7 @@ static void handle_kbd_command(ESCCChannelState *s,
> int
> > val)     case 0xf:
> >          clear_queue(s);
> >          put_queue(s, 0xfe);
> > -        put_queue(s, 0x21); /*  en-us layout */
> > +        put_queue(s, sun_keyboard_layout_dip_switch());
> >          break;
> >      default:
> >          break;
> > --
> > 2.14.5
>

--00000000000068ac2e05b1521daa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Mark,<div dir=3D"auto"><br></div><div dir=3D"auto">cou=
ld you please pick it up?</div><div dir=3D"auto"><br></div><div dir=3D"auto=
">Regards,</div><div dir=3D"auto">Artyom</div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D1=81=D0=B1, 19 =D1=81=D0=B5=
=D0=BD=D1=82. 2020 =D0=B3., 20:47 Henrik Carlqvist &lt;<a href=3D"mailto:hc=
94@poolhem.se">hc94@poolhem.se</a>&gt;:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">Just wanted to check that my patch hasn&#39;t been forgotten... I was =
hoping that<br>
it would make it into some branch in git.<br>
<br>
Do you want me to do any more changes to the patch or the description?<br>
<br>
Best regards Henrik<br>
<br>
On Mon, 3 Aug 2020 22:20:49 +0200<br>
Henrik Carlqvist &lt;<a href=3D"mailto:hc981@poolhem.se" target=3D"_blank" =
rel=3D"noreferrer">hc981@poolhem.se</a>&gt; wrote:<br>
<br>
&gt; This is my second attempt to contribute a patch which makes the -k swi=
tch<br>
&gt; useful for sparc emulation as its value is used to emulate the dip swi=
tch<br>
&gt; in a SUN keyboard for language layout setting.<br>
&gt; <br>
&gt; Unfortunately my glib version is too old to compile later versions of =
qemu<br>
&gt; so even though this patch is made from latest git I have only been abl=
e to<br>
&gt; test it myself with qemu version 4.1.1. I think and hope that this pat=
ch<br>
&gt; will compile and work also with the latest version of git as it only a=
ffects<br>
&gt; one file and there hasn&#39;t been much changes to that file since tes=
ted<br>
&gt; version 4.1.1.<br>
&gt; <br>
&gt; Best regards Henrik<br>
&gt; <br>
&gt; From e302b02dec32c28297ed20d852c5fba2c1682f5a Mon Sep 17 00:00:00 2001=
<br>
&gt; From: Henrik Carlqvist &lt;<a href=3D"mailto:hc1245@poolhem.se" target=
=3D"_blank" rel=3D"noreferrer">hc1245@poolhem.se</a>&gt;<br>
&gt; Date: Mon, 3 Aug 2020 22:11:55 +0200<br>
&gt; Subject: [PATCH] Emulating sun keyboard language layout dip switches, =
taking<br>
&gt;=C2=A0 the value for the dip switches from the &quot;-k&quot; option to=
 qemu.<br>
&gt; <br>
&gt; SUN Type 4, 5 and 5c keyboards have dip switches to choose the languag=
e<br>
&gt; layout of the keyboard. Solaris makes an ioctl to query the value of t=
he<br>
&gt; dipswitches and uses that value to select keyboard layout. Also the SU=
N<br>
&gt; bios like the one in the file ss5.bin uses this value to support at le=
ast<br>
&gt; some keyboard layouts. However, the OpenBIOS provided with qemu is<br>
&gt; hardcoded to always use an US keyboard layout.<br>
&gt; <br>
&gt; Before this patch, qemu allways gave dip switch value 0x21 (US keyboar=
d),<br>
&gt; this patch uses the command line switch &quot;-k&quot; (keyboard layou=
t) to select<br>
&gt; dip switch value. A table is used to lookup values from arguments like=
:<br>
&gt; <br>
&gt; -k fr<br>
&gt; -k es<br>
&gt; <br>
&gt; But the patch also accepts numeric dip switch values directly to the -=
k<br>
&gt; switch:<br>
&gt; <br>
&gt; -k 0x2b<br>
&gt; -k 43<br>
&gt; <br>
&gt; Both values above are the same and select swedish keyboard as explaine=
d in<br>
&gt; table 3-15 at<br>
&gt; <a href=3D"https://docs.oracle.com/cd/E19683-01/806-6642/new-43/index.=
html" rel=3D"noreferrer noreferrer" target=3D"_blank">https://docs.oracle.c=
om/cd/E19683-01/806-6642/new-43/index.html</a><br>
&gt; <br>
&gt; Unless you want to do a full Solaris installation but happen to have<b=
r>
&gt; access to a bios file, the easiest way to test that the patch works is=
 to:<br>
&gt; <br>
&gt; qemu-system-sparc -k sv -bios /path/to/ss5.bin<br>
&gt; <br>
&gt; If you already happen to have a Solaris installation in a qemu disk im=
age<br>
&gt; file you can easily try different keyboard layouts after this patch is=
<br>
&gt; applied.<br>
&gt; <br>
&gt; Signed-off-by: Henrik Carlqvist &lt;<a href=3D"mailto:hc1245@poolhem.s=
e" target=3D"_blank" rel=3D"noreferrer">hc1245@poolhem.se</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/char/escc.c | 74<br>
&gt; +++++++++++++++++++++++++++++++++++++++++++++++++++++++++- 1 file chan=
ged,<br>
&gt; 73 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/hw/char/escc.c b/hw/char/escc.c<br>
&gt; index 7d16ee8688..7287056b5f 100644<br>
&gt; --- a/hw/char/escc.c<br>
&gt; +++ b/hw/char/escc.c<br>
&gt; @@ -30,6 +30,8 @@<br>
&gt;=C2=A0 #include &quot;qemu/module.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/char/escc.h&quot;<br>
&gt;=C2=A0 #include &quot;ui/console.h&quot;<br>
&gt; +#include &quot;sysemu/sysemu.h&quot;<br>
&gt; +#include &quot;qemu/cutils.h&quot;<br>
&gt;=C2=A0 #include &quot;trace.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /*<br>
&gt; @@ -175,6 +177,7 @@<br>
&gt;=C2=A0 #define R_MISC1I 14<br>
&gt;=C2=A0 #define R_EXTINT 15<br>
&gt;=C2=A0 <br>
&gt; +static unsigned char sun_keyboard_layout_dip_switch(void);<br>
&gt;=C2=A0 static void handle_kbd_command(ESCCChannelState *s, int val);<br=
>
&gt;=C2=A0 static int serial_can_receive(void *opaque);<br>
&gt;=C2=A0 static void serial_receive_byte(ESCCChannelState *s, int ch);<br=
>
&gt; @@ -730,6 +733,75 @@ static QemuInputHandler sunkbd_handler =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .event =3D sunkbd_handle_event,<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt; +static unsigned char sun_keyboard_layout_dip_switch(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /* Return the value of the dip-switches in a SUN Type 5=
 keyboard */<br>
&gt; +=C2=A0 =C2=A0 static unsigned char ret =3D 0xff;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if ((ret =3D=3D 0xff) &amp;&amp; keyboard_layout) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct layout_values {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *lang;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char dip;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } languages[] =3D<br>
&gt; +=C2=A0 =C2=A0 /* Dip values from table 3-16 Layouts for Type 4, 5, an=
d 5c Keyboards<br>
&gt; */+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;en-us&=
quot;, 0x21}, /* U.S.A. (US5.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* 0x22 is some other US (=
US_UNIX5.kt)*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;fr&quo=
t;,=C2=A0 =C2=A0 0x23}, /* France (France5.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;da&quo=
t;,=C2=A0 =C2=A0 0x24}, /* Denmark (Denmark5.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;de&quo=
t;,=C2=A0 =C2=A0 0x25}, /* Germany (Germany5.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;it&quo=
t;,=C2=A0 =C2=A0 0x26}, /* Italy (Italy5.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;nl&quo=
t;,=C2=A0 =C2=A0 0x27}, /* The Netherlands (Netherland5.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;no&quo=
t;,=C2=A0 =C2=A0 0x28}, /* Norway (Norway.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;pt&quo=
t;,=C2=A0 =C2=A0 0x29}, /* Portugal (Portugal5.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;es&quo=
t;,=C2=A0 =C2=A0 0x2a}, /* Spain (Spain5.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;sv&quo=
t;,=C2=A0 =C2=A0 0x2b}, /* Sweden (Sweden5.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;fr-ch&=
quot;, 0x2c}, /* Switzerland/French (Switzer_Fr5.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;de-ch&=
quot;, 0x2d}, /* Switzerland/German (Switzer_Ge5.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;en-gb&=
quot;, 0x2e}, /* Great Britain (UK5.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;ko&quo=
t;,=C2=A0 =C2=A0 0x2f}, /* Korea (Korea5.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;tw&quo=
t;,=C2=A0 =C2=A0 0x30}, /* Taiwan (Taiwan5.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;ja&quo=
t;,=C2=A0 =C2=A0 0x31}, /* Japan (Japan5.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;fr-ca&=
quot;, 0x32}, /* Canada/French (Canada_Fr5.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;hu&quo=
t;,=C2=A0 =C2=A0 0x33}, /* Hungary (Hungary5.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;pl&quo=
t;,=C2=A0 =C2=A0 0x34}, /* Poland (Poland5.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;cz&quo=
t;,=C2=A0 =C2=A0 0x35}, /* Czech (Czech5.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;ru&quo=
t;,=C2=A0 =C2=A0 0x36}, /* Russia (Russia5.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;lv&quo=
t;,=C2=A0 =C2=A0 0x37}, /* Latvia (Latvia5.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;tr&quo=
t;,=C2=A0 =C2=A0 0x38}, /* Turkey-Q5 (TurkeyQ5.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;gr&quo=
t;,=C2=A0 =C2=A0 0x39}, /* Greece (Greece5.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;ar&quo=
t;,=C2=A0 =C2=A0 0x3a}, /* Arabic (Arabic5.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;lt&quo=
t;,=C2=A0 =C2=A0 0x3b}, /* Lithuania (Lithuania5.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;nl-be&=
quot;, 0x3c}, /* Belgium (Belgian5.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;be&quo=
t;,=C2=A0 =C2=A0 0x3c}, /* Belgium (Belgian5.kt) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i &lt; sizeof(languag=
es) / sizeof(struct layout_values);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!strcmp(keyboard_layout=
, languages[i].lang)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D langu=
ages[i].dip;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Found no known language code */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((keyboard_layout[0] &gt;=3D &#39;0&#3=
9;) &amp;&amp; (keyboard_layout[0] &lt;=3D &#39;9&#39;)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int tmp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* As a fallback we also ac=
cept numeric dip switch value */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!qemu_strtoui(keyboard_=
layout, NULL, 0, &amp;tmp)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D (unsi=
gned char)tmp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (ret =3D=3D 0xff) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Final fallback if keyboard_layout was =
not set or recognized */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D 0x21; /* en-us layout */<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static void handle_kbd_command(ESCCChannelState *s, int val)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 trace_escc_kbd_command(val);<br>
&gt; @@ -751,7 +823,7 @@ static void handle_kbd_command(ESCCChannelState *s=
, int<br>
&gt; val)=C2=A0 =C2=A0 =C2=A0case 0xf:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clear_queue(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 put_queue(s, 0xfe);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 put_queue(s, 0x21); /*=C2=A0 en-us layout=
 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 put_queue(s, sun_keyboard_layout_dip_swit=
ch());<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; -- <br>
&gt; 2.14.5<br>
</blockquote></div>

--00000000000068ac2e05b1521daa--

