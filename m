Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CCFC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 21:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4807E2075D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 21:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ld+MjPT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4807E2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDxo1-0002yy-Bs
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 17:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <estebanbosse@gmail.com>) id 1iDxjv-0008By-8b
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 17:25:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <estebanbosse@gmail.com>) id 1iDxjr-0003Ox-VL
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 17:25:22 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:38972)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <estebanbosse@gmail.com>)
 id 1iDxjp-0003K0-IN; Fri, 27 Sep 2019 17:25:17 -0400
Received: by mail-ed1-x543.google.com with SMTP id a15so3542657edt.6;
 Fri, 27 Sep 2019 14:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YsJpUKnUM6h4TMWxtaSP45vMzdsIvrZ7mGQBfgyDCj4=;
 b=Ld+MjPT0hZcMb121Zk66fAqBK3glUZRHocQQTKnCP7p4I9W8IRFcZna7yIsA1l9X3+
 /ep7xEP2n3QxSoeOe0EXU+ad8kVIzEaZiVc5PqiSXjQs+Sd6lJdtTQeh8acO5uE++4So
 MpQKic8sERMtBEYRBPIwOnynhmDeKhrpEDCNwtuiU71ju/YGSjOUC790vbaUwEm1AaOA
 LNcj/vxvzWD4+ItRlwDuqQ2oNK9TsGS272csDIoWEUHFXyXUoWzYyzWyXoKd6dGtxIbW
 0X/C+SKX9TKPhIOQ9qxSZ8rfwcGrywKh0CV3GbqlqxcUsRdy3P3YECBd/Rkr8OJ5a0xH
 gP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YsJpUKnUM6h4TMWxtaSP45vMzdsIvrZ7mGQBfgyDCj4=;
 b=g31Q8QjYJk9WEipRX4ekoqM4IvhSHPOWpR5opceAVZDPB4mbJEUukYjZhXMl5ihPWF
 MizRe3LbNg2Vr2wIVqPRn6sou05/1oveur6L8wLqFvgC7yDyJGs9kiZ4xhTgLpNFk5MO
 wUK0AkyP7kGQP1toAltWzUCqf5+U7xLRGKQYzi3ikLXoBN+OJ8Z4NX5zGW3D0K1vwPY5
 x6ZSCaf7iJD4fmHAvc4uK2fI8CVrTLCuUJKzefwrDQgKqmYd6H1s1z2D2J361+5w55Wm
 wnFV+KDu2nvSxuvtPgaO/30qrYQJp6Kiq2DGDMoyhanCU3gd7XxBuYmlQ56X1B7nePel
 aLaw==
X-Gm-Message-State: APjAAAWjcAJOeCFAo72qLTYV0cME1XbciaJqTQjSqxH3Acdsmo8ofmwj
 adKKvqlx5RzxQ1rbJr/e9jL7Z2npPYe/On1Tbjc=
X-Google-Smtp-Source: APXvYqy8EswcKFTdC+HynPBvS7dOz0Iylr9MN5OcK5QLO1TLA+udrsQYSvR+fQUhUQrtaaR+uKrnSMJ8nAfG1EZqkyA=
X-Received: by 2002:a50:a5f8:: with SMTP id b53mr6931507edc.39.1569619515615; 
 Fri, 27 Sep 2019 14:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190904171315.8354-1-f4bug@amsat.org>
 <20190904171315.8354-5-f4bug@amsat.org>
In-Reply-To: <20190904171315.8354-5-f4bug@amsat.org>
From: Esteban Bosse <estebanbosse@gmail.com>
Date: Fri, 27 Sep 2019 23:25:04 +0200
Message-ID: <CAGbAg_AmENM4WXVJw-n-xP-K-11wR6N5Yu8XAGWNQ4rCY9Gu8Q@mail.gmail.com>
Subject: Re: [PATCH 04/14] hw/arm/bcm2835_peripherals: Improve logging
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000a9347905938f854a"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
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

--000000000000a9347905938f854a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mi=C3=A9., 4 sept. 2019 a las 19:13, Philippe Mathieu-Daud=C3=A9 (<f4bug=
@amsat.org>)
escribi=C3=B3:

> Various logging improvements as once:
> - Use 0x prefix for hex numbers
> - Display value written during write accesses
> - Move some logs from GUEST_ERROR to UNIMP
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> v2: Use PRIx64 format (pm215)
> ---
>  hw/char/bcm2835_aux.c      |  5 +++--
>  hw/dma/bcm2835_dma.c       |  8 ++++----
>  hw/intc/bcm2836_control.c  |  7 ++++---
>  hw/misc/bcm2835_mbox.c     |  7 ++++---
>  hw/misc/bcm2835_property.c | 16 ++++++++++------
>  5 files changed, 25 insertions(+), 18 deletions(-)
>
> diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
> index 3f855196e3..a6fc1bf152 100644
> --- a/hw/char/bcm2835_aux.c
> +++ b/hw/char/bcm2835_aux.c
> @@ -162,8 +162,9 @@ static void bcm2835_aux_write(void *opaque, hwaddr
> offset, uint64_t value,
>      switch (offset) {
>      case AUX_ENABLES:
>          if (value !=3D 1) {
> -            qemu_log_mask(LOG_UNIMP, "%s: unsupported attempt to enable
> SPI "
> -                          "or disable UART\n", __func__);
> +            qemu_log_mask(LOG_UNIMP, "%s: unsupported attempt to enable
> SPI"
> +                                     " or disable UART: 0x%"PRIx64"\n",
> +                          __func__, value);
>          }
>          break;
>
> I found others qemu_log_mask calls in this file, why did you only add
"0x%" to this calls ?

Icho :: qemu/qemu/hw 148 =C2=BB grep -r qemu_log_mask char/bcm2835_aux.c
        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_LCR_REG unsupported\n",
__func__);
        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_MCR_REG unsupported\n",
__func__);
        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_MSR_REG unsupported\n",
__func__);
        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_SCRATCH unsupported\n",
__func__);
        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_BAUD_REG unsupported\n",
__func__);
        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",
            qemu_log_mask(LOG_UNIMP, "%s: unsupported attempt to enable SPI
"
        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_LCR_REG unsupported\n",
__func__);
        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_MCR_REG unsupported\n",
__func__);
        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_SCRATCH unsupported\n",
__func__);
        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_CNTL_REG unsupported\n",
__func__);
        qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_BAUD_REG unsupported\n",
__func__);
        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",


> diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
> index 192bd377a0..6acc2b644e 100644
> --- a/hw/dma/bcm2835_dma.c
> +++ b/hw/dma/bcm2835_dma.c
> @@ -180,7 +180,7 @@ static uint64_t bcm2835_dma_read(BCM2835DMAState *s,
> hwaddr offset,
>          res =3D ch->debug;
>          break;
>      default:
> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n"=
,
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset
> 0x%"HWADDR_PRIx"\n",
>                        __func__, offset);
>          break;
>      }
> @@ -228,7 +228,7 @@ static void bcm2835_dma_write(BCM2835DMAState *s,
> hwaddr offset,
>          ch->debug =3D value;
>          break;
>      default:
> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n"=
,
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset
> 0x%"HWADDR_PRIx"\n",
>                        __func__, offset);
>          break;
>      }
> @@ -247,7 +247,7 @@ static uint64_t bcm2835_dma0_read(void *opaque, hwadd=
r
> offset, unsigned size)
>          case BCM2708_DMA_ENABLE:
>              return s->enable;
>          default:
> -            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset
> %"HWADDR_PRIx"\n",
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset
> 0x%"HWADDR_PRIx"\n",
>                            __func__, offset);
>              return 0;
>          }
> @@ -274,7 +274,7 @@ static void bcm2835_dma0_write(void *opaque, hwaddr
> offset, uint64_t value,
>              s->enable =3D (value & 0xffff);
>              break;
>          default:
> -            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset
> %"HWADDR_PRIx"\n",
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset
> 0x%"HWADDR_PRIx"\n",
>                            __func__, offset);
>          }
>      }
> diff --git a/hw/intc/bcm2836_control.c b/hw/intc/bcm2836_control.c
> index 04229b8a17..61f884ff9e 100644
> --- a/hw/intc/bcm2836_control.c
> +++ b/hw/intc/bcm2836_control.c
> @@ -264,7 +264,7 @@ static uint64_t bcm2836_control_read(void *opaque,
> hwaddr offset, unsigned size)
>      } else if (offset >=3D REG_MBOX0_RDCLR && offset < REG_LIMIT) {
>          return s->mailboxes[(offset - REG_MBOX0_RDCLR) >> 2];
>      } else {
> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n"=
,
> +        qemu_log_mask(LOG_UNIMP, "%s: Unsupported offset
> 0x%"HWADDR_PRIx"\n",
>                        __func__, offset);
>          return 0;
>      }
> @@ -293,8 +293,9 @@ static void bcm2836_control_write(void *opaque, hwadd=
r
> offset,
>      } else if (offset >=3D REG_MBOX0_RDCLR && offset < REG_LIMIT) {
>          s->mailboxes[(offset - REG_MBOX0_RDCLR) >> 2] &=3D ~val;
>      } else {
> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n"=
,
> -                      __func__, offset);
> +        qemu_log_mask(LOG_UNIMP, "%s: Unsupported offset 0x%"HWADDR_PRIx
> +                                 " value 0x%"PRIx64"\n",
> +                      __func__, offset, val);
>          return;
>      }
>
> diff --git a/hw/misc/bcm2835_mbox.c b/hw/misc/bcm2835_mbox.c
> index 79bad11631..7690b9afaf 100644
> --- a/hw/misc/bcm2835_mbox.c
> +++ b/hw/misc/bcm2835_mbox.c
> @@ -176,7 +176,7 @@ static uint64_t bcm2835_mbox_read(void *opaque, hwadd=
r
> offset, unsigned size)
>          break;
>
>      default:
> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n"=
,
> +        qemu_log_mask(LOG_UNIMP, "%s: Unsupported offset
> 0x%"HWADDR_PRIx"\n",
>                        __func__, offset);
>          return 0;
>      }
> @@ -228,8 +228,9 @@ static void bcm2835_mbox_write(void *opaque, hwaddr
> offset,
>          break;
>
>      default:
> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n"=
,
> -                      __func__, offset);
> +        qemu_log_mask(LOG_UNIMP, "%s: Unsupported offset 0x%"HWADDR_PRIx
> +                                 " value 0x%"PRIx64"\n",
> +                      __func__, offset, value);
>          return;
>      }
>
> Same question here:
Icho :: qemu/qemu/hw 148 =C2=BB grep -r qemu_log_mask misc/bcm2835_mbox.c
        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",
            qemu_log_mask(LOG_GUEST_ERROR, "%s: mailbox full\n", __func__);
                qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid channel %u\n",
        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",


> diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
> index d8eb28f267..ab66d3572e 100644
> --- a/hw/misc/bcm2835_property.c
> +++ b/hw/misc/bcm2835_property.c
> @@ -56,7 +56,8 @@ static void
> bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
>              break;
>          case 0x00010001: /* Get board model */
>              qemu_log_mask(LOG_UNIMP,
> -                          "bcm2835_property: %x get board model NYI\n",
> tag);
> +                          "bcm2835_property: 0x%08x get board model
> NYI\n",
> +                          tag);
>              /* FIXME returning uninitialized memory */
>              resplen =3D 4;
>              break;
> @@ -70,7 +71,8 @@ static void
> bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
>              break;
>          case 0x00010004: /* Get board serial */
>              qemu_log_mask(LOG_UNIMP,
> -                          "bcm2835_property: %x get board serial NYI\n",
> tag);
> +                          "bcm2835_property: 0x%08x get board serial
> NYI\n",
> +                          tag);
>              /* FIXME returning uninitialized memory */
>              resplen =3D 8;
>              break;
> @@ -106,7 +108,8 @@ static void
> bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
>
>          case 0x00038001: /* Set clock state */
>              qemu_log_mask(LOG_UNIMP,
> -                          "bcm2835_property: %x set clock state NYI\n",
> tag);
> +                          "bcm2835_property: 0x%08x set clock state
> NYI\n",
> +                          tag);
>              resplen =3D 8;
>              break;
>
> @@ -139,7 +142,8 @@ static void
> bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
>          case 0x00038004: /* Set max clock rate */
>          case 0x00038007: /* Set min clock rate */
>              qemu_log_mask(LOG_UNIMP,
> -                          "bcm2835_property: %x set clock rates NYI\n",
> tag);
> +                          "bcm2835_property: 0x%08x set clock rate NYI\n=
",
> +                          tag);
>              resplen =3D 8;
>              break;
>
> @@ -284,8 +288,8 @@ static void
> bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
>              break;
>
>          default:
> -            qemu_log_mask(LOG_GUEST_ERROR,
> -                          "bcm2835_property: unhandled tag %08x\n", tag)=
;
> +            qemu_log_mask(LOG_UNIMP,
> +                          "bcm2835_property: unhandled tag 0x%08x\n",
> tag);
>              break;
>          }
>
 Same question here:
 Icho :: qemu/qemu/hw 148 =C2=BB grep -r qemu_log_mask misc/bcm2835_propert=
y.c
            qemu_log_mask(LOG_UNIMP,
            qemu_log_mask(LOG_UNIMP,
            qemu_log_mask(LOG_UNIMP,
            qemu_log_mask(LOG_UNIMP,
            qemu_log_mask(LOG_GUEST_ERROR,
        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",
        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",

>  --
> 2.20.1
>

I found other calls to qemu_log_mask in others files:
hw/display/bcm2835_fb.c, hw/gpio/bcm2835_gpio.c, hw/intc/bcm2835_ic.c,
hw/misc/bcm2835_rng.c and hw/sd/bcm2835_sdhost.c.

--000000000000a9347905938f854a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">El mi=C3=A9., 4 sept. 2019 a las 19:1=
3, Philippe Mathieu-Daud=C3=A9 (&lt;<a href=3D"mailto:f4bug@amsat.org">f4bu=
g@amsat.org</a>&gt;) escribi=C3=B3:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">Various logging improvements as once:<br>
- Use 0x prefix for hex numbers<br>
- Display value written during write accesses<br>
- Move some logs from GUEST_ERROR to UNIMP<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
v2: Use PRIx64 format (pm215)<br>
---<br>
=C2=A0hw/char/bcm2835_aux.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 5 +++--<br>
=C2=A0hw/dma/bcm2835_dma.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8 ++++----<br>
=C2=A0hw/intc/bcm2836_control.c=C2=A0 |=C2=A0 7 ++++---<br>
=C2=A0hw/misc/bcm2835_mbox.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 7 ++++---<br>
=C2=A0hw/misc/bcm2835_property.c | 16 ++++++++++------<br>
=C2=A05 files changed, 25 insertions(+), 18 deletions(-)<br>
<br>
diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c<br>
index 3f855196e3..a6fc1bf152 100644<br>
--- a/hw/char/bcm2835_aux.c<br>
+++ b/hw/char/bcm2835_aux.c<br>
@@ -162,8 +162,9 @@ static void bcm2835_aux_write(void *opaque, hwaddr offs=
et, uint64_t value,<br>
=C2=A0 =C2=A0 =C2=A0switch (offset) {<br>
=C2=A0 =C2=A0 =C2=A0case AUX_ENABLES:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value !=3D 1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;%=
s: unsupported attempt to enable SPI &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;or disable UART\n&quot;, __func__);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;%=
s: unsupported attempt to enable SPI&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; or disabl=
e UART: 0x%&quot;PRIx64&quot;\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 __func__, value);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br></blockquote><div>I found others qemu_log_mask calls in this file, why =
did you only add &quot;0x%&quot; to this calls ?<br><br>Icho :: qemu/qemu/h=
w 148 =C2=BB grep -r qemu_log_mask char/bcm2835_aux.c <br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;%s: AUX_MU_LCR_REG unsupported\n&=
quot;, __func__);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &=
quot;%s: AUX_MU_MCR_REG unsupported\n&quot;, __func__);<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;%s: AUX_MU_MSR_REG unsupported=
\n&quot;, __func__);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP=
, &quot;%s: AUX_MU_SCRATCH unsupported\n&quot;, __func__);<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;%s: AUX_MU_BAUD_REG unsupport=
ed\n&quot;, __func__);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUE=
ST_ERROR, &quot;%s: Bad offset %&quot;HWADDR_PRIx&quot;\n&quot;,<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;%s: unsup=
ported attempt to enable SPI &quot;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log=
_mask(LOG_UNIMP, &quot;%s: AUX_MU_LCR_REG unsupported\n&quot;, __func__);<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;%s: AUX_MU_MCR=
_REG unsupported\n&quot;, __func__);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_lo=
g_mask(LOG_UNIMP, &quot;%s: AUX_MU_SCRATCH unsupported\n&quot;, __func__);<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;%s: AUX_MU_CN=
TL_REG unsupported\n&quot;, __func__);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_=
log_mask(LOG_UNIMP, &quot;%s: AUX_MU_BAUD_REG unsupported\n&quot;, __func__=
);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: =
Bad offset %&quot;HWADDR_PRIx&quot;\n&quot;,<br></div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c<br>
index 192bd377a0..6acc2b644e 100644<br>
--- a/hw/dma/bcm2835_dma.c<br>
+++ b/hw/dma/bcm2835_dma.c<br>
@@ -180,7 +180,7 @@ static uint64_t bcm2835_dma_read(BCM2835DMAState *s, hw=
addr offset,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D ch-&gt;debug;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: Bad o=
ffset %&quot;HWADDR_PRIx&quot;\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: Bad o=
ffset 0x%&quot;HWADDR_PRIx&quot;\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0__func__, offset);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -228,7 +228,7 @@ static void bcm2835_dma_write(BCM2835DMAState *s, hwadd=
r offset,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ch-&gt;debug =3D value;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: Bad o=
ffset %&quot;HWADDR_PRIx&quot;\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: Bad o=
ffset 0x%&quot;HWADDR_PRIx&quot;\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0__func__, offset);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -247,7 +247,7 @@ static uint64_t bcm2835_dma0_read(void *opaque, hwaddr =
offset, unsigned size)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case BCM2708_DMA_ENABLE:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;enable;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &=
quot;%s: Bad offset %&quot;HWADDR_PRIx&quot;\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &=
quot;%s: Bad offset 0x%&quot;HWADDR_PRIx&quot;\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0__func__, offset);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -274,7 +274,7 @@ static void bcm2835_dma0_write(void *opaque, hwaddr off=
set, uint64_t value,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;enable =3D (value &am=
p; 0xffff);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &=
quot;%s: Bad offset %&quot;HWADDR_PRIx&quot;\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &=
quot;%s: Bad offset 0x%&quot;HWADDR_PRIx&quot;\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0__func__, offset);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/hw/intc/bcm2836_control.c b/hw/intc/bcm2836_control.c<br>
index 04229b8a17..61f884ff9e 100644<br>
--- a/hw/intc/bcm2836_control.c<br>
+++ b/hw/intc/bcm2836_control.c<br>
@@ -264,7 +264,7 @@ static uint64_t bcm2836_control_read(void *opaque, hwad=
dr offset, unsigned size)<br>
=C2=A0 =C2=A0 =C2=A0} else if (offset &gt;=3D REG_MBOX0_RDCLR &amp;&amp; of=
fset &lt; REG_LIMIT) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;mailboxes[(offset - REG_MBOX=
0_RDCLR) &gt;&gt; 2];<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: Bad o=
ffset %&quot;HWADDR_PRIx&quot;\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;%s: Unsupported=
 offset 0x%&quot;HWADDR_PRIx&quot;\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0__func__, offset);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -293,8 +293,9 @@ static void bcm2836_control_write(void *opaque, hwaddr =
offset,<br>
=C2=A0 =C2=A0 =C2=A0} else if (offset &gt;=3D REG_MBOX0_RDCLR &amp;&amp; of=
fset &lt; REG_LIMIT) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;mailboxes[(offset - REG_MBOX0_RDCLR=
) &gt;&gt; 2] &amp;=3D ~val;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: Bad o=
ffset %&quot;HWADDR_PRIx&quot;\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __func__, offset);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;%s: Unsupported=
 offset 0x%&quot;HWADDR_PRIx<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; value 0x%&quot;PRIx64&q=
uot;\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __func__, offset, val);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
diff --git a/hw/misc/bcm2835_mbox.c b/hw/misc/bcm2835_mbox.c<br>
index 79bad11631..7690b9afaf 100644<br>
--- a/hw/misc/bcm2835_mbox.c<br>
+++ b/hw/misc/bcm2835_mbox.c<br>
@@ -176,7 +176,7 @@ static uint64_t bcm2835_mbox_read(void *opaque, hwaddr =
offset, unsigned size)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: Bad o=
ffset %&quot;HWADDR_PRIx&quot;\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;%s: Unsupported=
 offset 0x%&quot;HWADDR_PRIx&quot;\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0__func__, offset);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -228,8 +228,9 @@ static void bcm2835_mbox_write(void *opaque, hwaddr off=
set,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: Bad o=
ffset %&quot;HWADDR_PRIx&quot;\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __func__, offset);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;%s: Unsupported=
 offset 0x%&quot;HWADDR_PRIx<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; value 0x%&quot;PRIx64&q=
uot;\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __func__, offset, value);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br></blockquote><div>Same question here:<br>Icho :: qemu/qemu/hw 148 =C2=
=BB grep -r qemu_log_mask misc/bcm2835_mbox.c<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: Bad offset %&quot;HWADDR_PRIx&=
quot;\n&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(L=
OG_GUEST_ERROR, &quot;%s: mailbox full\n&quot;, __func__);<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &=
quot;%s: invalid channel %u\n&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_lo=
g_mask(LOG_GUEST_ERROR, &quot;%s: Bad offset %&quot;HWADDR_PRIx&quot;\n&quo=
t;,<br>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c<br>
index d8eb28f267..ab66d3572e 100644<br>
--- a/hw/misc/bcm2835_property.c<br>
+++ b/hw/misc/bcm2835_property.c<br>
@@ -56,7 +56,8 @@ static void bcm2835_property_mbox_push(BCM2835PropertySta=
te *s, uint32_t value)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x00010001: /* Get board model */<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LOG_UNIMP,<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;bcm2835_property: %x get board model NYI\n&quot;, t=
ag);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;bcm2835_property: 0x%08x get board model NYI\n&quot=
;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 tag);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* FIXME returning uninitia=
lized memory */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resplen =3D 4;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
@@ -70,7 +71,8 @@ static void bcm2835_property_mbox_push(BCM2835PropertySta=
te *s, uint32_t value)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x00010004: /* Get board serial */<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LOG_UNIMP,<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;bcm2835_property: %x get board serial NYI\n&quot;, =
tag);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;bcm2835_property: 0x%08x get board serial NYI\n&quo=
t;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 tag);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* FIXME returning uninitia=
lized memory */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resplen =3D 8;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
@@ -106,7 +108,8 @@ static void bcm2835_property_mbox_push(BCM2835PropertyS=
tate *s, uint32_t value)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x00038001: /* Set clock state */<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LOG_UNIMP,<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;bcm2835_property: %x set clock state NYI\n&quot;, t=
ag);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;bcm2835_property: 0x%08x set clock state NYI\n&quot=
;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 tag);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resplen =3D 8;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
@@ -139,7 +142,8 @@ static void bcm2835_property_mbox_push(BCM2835PropertyS=
tate *s, uint32_t value)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x00038004: /* Set max clock rate */=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x00038007: /* Set min clock rate */=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LOG_UNIMP,<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;bcm2835_property: %x set clock rates NYI\n&quot;, t=
ag);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;bcm2835_property: 0x%08x set clock rate NYI\n&quot;=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 tag);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resplen =3D 8;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
@@ -284,8 +288,8 @@ static void bcm2835_property_mbox_push(BCM2835PropertyS=
tate *s, uint32_t value)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;bcm2835_property: unhandled tag %08x\n&quot;, tag);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;bcm2835_property: unhandled tag 0x%08x\n&quot;, tag=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
</blockquote><div>=C2=A0Same question here:</div><div>=C2=A0Icho :: qemu/qe=
mu/hw 148 =C2=BB grep -r qemu_log_mask misc/bcm2835_property.c</div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP,<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP,<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: Bad offset %&quot;HWADDR_P=
RIx&quot;\n&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_E=
RROR, &quot;%s: Bad offset %&quot;HWADDR_PRIx&quot;\n&quot;,<br><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">=C2=A0-- <br>
2.20.1<br></blockquote><div><br></div><div>I found other calls to qemu_log_=
mask in others files: hw/display/bcm2835_fb.c, hw/gpio/bcm2835_gpio.c, hw/i=
ntc/bcm2835_ic.c, hw/misc/bcm2835_rng.c and hw/sd/bcm2835_sdhost.c.</div></=
div></div>

--000000000000a9347905938f854a--

