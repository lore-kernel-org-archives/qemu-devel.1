Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2839CC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 20:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0E4A2082F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 20:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIqLeI6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E4A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDxE9-0007sP-1Y
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 16:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <estebanbosse@gmail.com>) id 1iDxDJ-0007Hv-PW
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 16:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <estebanbosse@gmail.com>) id 1iDxDI-0006c4-CG
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 16:51:41 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:36741)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <estebanbosse@gmail.com>)
 id 1iDxDI-0006bT-3W; Fri, 27 Sep 2019 16:51:40 -0400
Received: by mail-ed1-x541.google.com with SMTP id h2so3498894edn.3;
 Fri, 27 Sep 2019 13:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p+nDA86jMH4Pq7MzS8/vEaBEc7PBFlKlGTqXWHL8JeE=;
 b=jIqLeI6lIwmqbhiuWlMlLdpLKkrDTt+F8TF+IwhJFm0Z7YSUtJiUMMHYYF9dhRySAG
 MC7EyuLY1Ce08/LkfvNecX49gy04w/PweKE5YIXKhhPRb/Op6oprLjAacKzzBgSYM+NQ
 GPFX9qH3Nciy4cY+T64us0ZBNRQs+i3m5/OocaV6besBuM0Z/8X22aylmraT8MztbviR
 a9RB9kydlfF9aF8rPEqn9nCoiPEBwfThwcSpA59+t8ORgIl1VDKZ6EaGjsawA4DTZJVV
 g6kbYcjfeMQvLWDaD/pIvXFguTIsXnZJ2f/vPmds6Ax96EZedtYbGuqg1UwyLcxN54OA
 z8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p+nDA86jMH4Pq7MzS8/vEaBEc7PBFlKlGTqXWHL8JeE=;
 b=BTXj6FW8wAQVOACD1Mc4k2j84VjhUqlTep3rN4LAG/LeoZoU2b0bs4eF2GLrNjv3vU
 771c85C20f4Jz8Nq+im27M2SUeNuKPZXUMdhc4Yxzbkp8vuU2435j89XOyTuqWW8L81f
 19ctseSbY5wRgZsKv+JRcH8sycORiVRjlGlRhs+T0+x7A+NKBHNL5L1a8IKKCV36QTjW
 dmkMiBXF7qVGNabt0zqZgyI/3OH3tOy3FaaBE/UmNCXSslmm5CSEz6kxd32Dujj9dFgq
 19GXI/YfvQwYLZHVdfA1RlrMm8arbLz0gM1i4mQwkmxedALVbovu/ND97QZj5QdDA/d/
 LsrQ==
X-Gm-Message-State: APjAAAUisQOyrx77UOBSMPc1Yzq8V+CQ688GeSUiuYMtivZZxPeFDiBQ
 SAi3pHErSRu6fdXJlURmGsSAgFZ/O57ChyIc0Ms=
X-Google-Smtp-Source: APXvYqwrKzyGEs2RbGw/1aOaOMZPeKY01A9+AFogMYxpMffA7864rT3V/vTBnKnzczt39KWqrCpsTr3Sv9tcn9Xwbl0=
X-Received: by 2002:a17:906:19d3:: with SMTP id
 h19mr9729195ejd.121.1569617498537; 
 Fri, 27 Sep 2019 13:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190904171315.8354-1-f4bug@amsat.org>
 <20190904171315.8354-4-f4bug@amsat.org>
In-Reply-To: <20190904171315.8354-4-f4bug@amsat.org>
From: Esteban Bosse <estebanbosse@gmail.com>
Date: Fri, 27 Sep 2019 22:51:27 +0200
Message-ID: <CAGbAg_AcaPU4w175KgDU5Nm9FC=9OBLEL+3cM01EqtMpD3YNfg@mail.gmail.com>
Subject: Re: [RFC PATCH 03/14] hw/misc/bcm2835_property: Handle the 'domain
 state' property
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000006f03d805938f0d19"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
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
 =?UTF-8?Q?Zolt=C3=A1n_Baldaszti?= <bztemail@gmail.com>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm <qemu-arm@nongnu.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006f03d805938f0d19
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Searching this property in the kernel, I found a lot of properties not
implemented.
https://github.com/raspberrypi/linux/blob/rpi-4.19.y/include/soc/bcm2835/ra=
spberrypi-firmware.h#L41
Are the properties only added when they are necessaries for the standard
kernel use?

Reviewed-by: EstebanB

El mi=C3=A9., 4 sept. 2019 a las 19:13, Philippe Mathieu-Daud=C3=A9 (<f4bug=
@amsat.org>)
escribi=C3=B3:

> The kernel is happy with this change, so we don't need
> to do anything more sophisticated.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/misc/bcm2835_property.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
> index 399f0d9dd5..d8eb28f267 100644
> --- a/hw/misc/bcm2835_property.c
> +++ b/hw/misc/bcm2835_property.c
> @@ -127,6 +127,14 @@ static void
> bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
>              resplen =3D 8;
>              break;
>
> +        case 0x00030030: /* Get domain state */
> +            qemu_log_mask(LOG_UNIMP,
> +                          "bcm2835_property: 0x%08x get domain state
> NYI\n",
> +                          tag);
> +            /* FIXME returning uninitialized memory */
> +            resplen =3D 8;
> +            break;
> +
>          case 0x00038002: /* Set clock rate */
>          case 0x00038004: /* Set max clock rate */
>          case 0x00038007: /* Set min clock rate */
> --
> 2.20.1
>
>

--0000000000006f03d805938f0d19
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Searching this property in the kernel, I found a lot of pr=
operties=C2=A0not implemented.=C2=A0<a href=3D"https://github.com/raspberry=
pi/linux/blob/rpi-4.19.y/include/soc/bcm2835/raspberrypi-firmware.h#L41">ht=
tps://github.com/raspberrypi/linux/blob/rpi-4.19.y/include/soc/bcm2835/rasp=
berrypi-firmware.h#L41</a><br>Are the properties only added when they are n=
ecessaries for the standard kernel use?<br><br>Reviewed-by: EstebanB<br></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">El =
mi=C3=A9., 4 sept. 2019 a las 19:13, Philippe Mathieu-Daud=C3=A9 (&lt;<a hr=
ef=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt;) escribi=C3=B3:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">The kernel is happy w=
ith this change, so we don&#39;t need<br>
to do anything more sophisticated.<br>
<br>
Reviewed-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" =
target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
=C2=A0hw/misc/bcm2835_property.c | 8 ++++++++<br>
=C2=A01 file changed, 8 insertions(+)<br>
<br>
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c<br>
index 399f0d9dd5..d8eb28f267 100644<br>
--- a/hw/misc/bcm2835_property.c<br>
+++ b/hw/misc/bcm2835_property.c<br>
@@ -127,6 +127,14 @@ static void bcm2835_property_mbox_push(BCM2835Property=
State *s, uint32_t value)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resplen =3D 8;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x00030030: /* Get domain state */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;bcm2835_property: 0x%08x get domain state NYI\n&quo=
t;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 tag);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* FIXME returning uninitialized=
 memory */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resplen =3D 8;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x00038002: /* Set clock rate */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x00038004: /* Set max clock rate */=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x00038007: /* Set min clock rate */=
<br>
-- <br>
2.20.1<br>
<br>
</blockquote></div>

--0000000000006f03d805938f0d19--

