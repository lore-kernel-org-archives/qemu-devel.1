Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AACCC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 21:45:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90D2F20863
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 21:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JD3RFpSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D2F20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDy3l-00049I-7Q
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 17:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iDy0X-0001sI-I5
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 17:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iDy0V-0004xq-E9
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 17:42:33 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:34909)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iDy0V-0004wd-0N; Fri, 27 Sep 2019 17:42:31 -0400
Received: by mail-lf1-x141.google.com with SMTP id w6so2971021lfl.2;
 Fri, 27 Sep 2019 14:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pA/Tdq4jk0AJMN3fUQKqIPvN2jrY/MiicAii9Ap3hIs=;
 b=JD3RFpSbYNRPW6iWDuXf29Zlim6MUbrmJHmwxwQlZwwNJnZVt5at70wp2zNQeGWmbH
 E4LOal8sXSH869lWHqij7FUiWx7uEH2AjIAvIL1wqRlHg08Nbx2uHoKr5UFUkb+25KEA
 qvv5gKIo+XF8mg/iytd8wHdkIB7dBZIvPLxINb8VkOZGpyBGTQXktfVZTpra1/jvGdTr
 TX4OaY+EC7Yj/5YcU+vseDDhbKdXJOCvprodYrcP0hDks/xYWe4+JGA2xCaxDmJ91WtR
 QKuIx2WpQiKDt6nWqagoKagXGPLLnx3opnW256KzynxIOJSIXXRW4iTPbbF+RgYehFzD
 48/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pA/Tdq4jk0AJMN3fUQKqIPvN2jrY/MiicAii9Ap3hIs=;
 b=m8ODbkrTrSmOlbkTbpgQ5qV3hQ45Y01z7bGfDJAQgZy3t6dhEAKzl0YALDLO+Rc9OV
 xOeFsERA0QbiEHBsrJRAIYN+jrG7jKC3wzXeCkWk0BKqbIsGSvNg9uZrciVtHnCzlr/b
 WnDTgCrWgahBr41hC6dXbCk/FQL2QY17h0pUpxbvTlctrHzLIJJdMKBOTyJW8KXM3wnu
 JeCtVh0q3QAdmdvdego3L748j4WvtKVfVnVbbWduSuZf2DHsbAVqs+D5z3iQUaIjyQ+G
 lUZU0FES1UMhYHLBIwn7ALaZJDW4tZ8+mgDVISk96EYuorDPRTFsTTNNdxODVy0nWVop
 E5fQ==
X-Gm-Message-State: APjAAAVJY+vze4nEiGiN2RdhnCIUsibohuQwmy9Ero3BrlhuSkMX8Hrt
 MUpLZiTZZCHfrm+o7yCQrzgTG3vQW8asGjvuLYA=
X-Google-Smtp-Source: APXvYqwMSgJK+zpe+Y/sOaXPSvoB8o3F4+X1EVTCRflkPnHAtF1AwFBnYiEff2Tm0vej42NCOvxeTief7Ym2IsGbjCE=
X-Received: by 2002:ac2:4a69:: with SMTP id q9mr4023307lfp.86.1569620548361;
 Fri, 27 Sep 2019 14:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-3-f4bug@amsat.org>
In-Reply-To: <20190926173428.10713-3-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 27 Sep 2019 14:37:41 -0700
Message-ID: <CAKmqyKOoYyc-CX5Q2x2jwoFFm8ZdW9+eFbpL5_49SUJryNeUrA@mail.gmail.com>
Subject: Re: [PATCH 02/19] hw/arm/bcm2835_peripherals: Improve logging
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
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
 =?UTF-8?Q?Zolt=C3=A1n_Baldaszti?= <bztemail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 26, 2019 at 10:40 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> Various logging improvements as once:
> - Use 0x prefix for hex numbers
> - Display value written during write accesses
> - Move some logs from GUEST_ERROR to UNIMP
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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
> @@ -162,8 +162,9 @@ static void bcm2835_aux_write(void *opaque, hwaddr of=
fset, uint64_t value,
>      switch (offset) {
>      case AUX_ENABLES:
>          if (value !=3D 1) {
> -            qemu_log_mask(LOG_UNIMP, "%s: unsupported attempt to enable =
SPI "
> -                          "or disable UART\n", __func__);
> +            qemu_log_mask(LOG_UNIMP, "%s: unsupported attempt to enable =
SPI"
> +                                     " or disable UART: 0x%"PRIx64"\n",
> +                          __func__, value);
>          }
>          break;
>
> diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
> index 192bd377a0..6acc2b644e 100644
> --- a/hw/dma/bcm2835_dma.c
> +++ b/hw/dma/bcm2835_dma.c
> @@ -180,7 +180,7 @@ static uint64_t bcm2835_dma_read(BCM2835DMAState *s, =
hwaddr offset,
>          res =3D ch->debug;
>          break;
>      default:
> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n"=
,
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx"\=
n",
>                        __func__, offset);
>          break;
>      }
> @@ -228,7 +228,7 @@ static void bcm2835_dma_write(BCM2835DMAState *s, hwa=
ddr offset,
>          ch->debug =3D value;
>          break;
>      default:
> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n"=
,
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx"\=
n",
>                        __func__, offset);
>          break;
>      }
> @@ -247,7 +247,7 @@ static uint64_t bcm2835_dma0_read(void *opaque, hwadd=
r offset, unsigned size)
>          case BCM2708_DMA_ENABLE:
>              return s->enable;
>          default:
> -            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx=
"\n",
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PR=
Ix"\n",
>                            __func__, offset);
>              return 0;
>          }
> @@ -274,7 +274,7 @@ static void bcm2835_dma0_write(void *opaque, hwaddr o=
ffset, uint64_t value,
>              s->enable =3D (value & 0xffff);
>              break;
>          default:
> -            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx=
"\n",
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PR=
Ix"\n",
>                            __func__, offset);
>          }
>      }
> diff --git a/hw/intc/bcm2836_control.c b/hw/intc/bcm2836_control.c
> index 04229b8a17..61f884ff9e 100644
> --- a/hw/intc/bcm2836_control.c
> +++ b/hw/intc/bcm2836_control.c
> @@ -264,7 +264,7 @@ static uint64_t bcm2836_control_read(void *opaque, hw=
addr offset, unsigned size)
>      } else if (offset >=3D REG_MBOX0_RDCLR && offset < REG_LIMIT) {
>          return s->mailboxes[(offset - REG_MBOX0_RDCLR) >> 2];
>      } else {
> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n"=
,
> +        qemu_log_mask(LOG_UNIMP, "%s: Unsupported offset 0x%"HWADDR_PRIx=
"\n",
>                        __func__, offset);
>          return 0;
>      }
> @@ -293,8 +293,9 @@ static void bcm2836_control_write(void *opaque, hwadd=
r offset,
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
r offset, unsigned size)
>          break;
>
>      default:
> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n"=
,
> +        qemu_log_mask(LOG_UNIMP, "%s: Unsupported offset 0x%"HWADDR_PRIx=
"\n",
>                        __func__, offset);
>          return 0;
>      }
> @@ -228,8 +228,9 @@ static void bcm2835_mbox_write(void *opaque, hwaddr o=
ffset,
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
> diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
> index d86d510572..0a1a3eb5d9 100644
> --- a/hw/misc/bcm2835_property.c
> +++ b/hw/misc/bcm2835_property.c
> @@ -56,7 +56,8 @@ static void bcm2835_property_mbox_push(BCM2835PropertyS=
tate *s, uint32_t value)
>              break;
>          case 0x00010001: /* Get board model */
>              qemu_log_mask(LOG_UNIMP,
> -                          "bcm2835_property: %x get board model NYI\n", =
tag);
> +                          "bcm2835_property: 0x%08x get board model NYI\=
n",
> +                          tag);
>              resplen =3D 4;
>              break;
>          case 0x00010002: /* Get board revision */
> @@ -69,7 +70,8 @@ static void bcm2835_property_mbox_push(BCM2835PropertyS=
tate *s, uint32_t value)
>              break;
>          case 0x00010004: /* Get board serial */
>              qemu_log_mask(LOG_UNIMP,
> -                          "bcm2835_property: %x get board serial NYI\n",=
 tag);
> +                          "bcm2835_property: 0x%08x get board serial NYI=
\n",
> +                          tag);
>              resplen =3D 8;
>              break;
>          case 0x00010005: /* Get ARM memory */
> @@ -104,7 +106,8 @@ static void bcm2835_property_mbox_push(BCM2835Propert=
yState *s, uint32_t value)
>
>          case 0x00038001: /* Set clock state */
>              qemu_log_mask(LOG_UNIMP,
> -                          "bcm2835_property: %x set clock state NYI\n", =
tag);
> +                          "bcm2835_property: 0x%08x set clock state NYI\=
n",
> +                          tag);
>              resplen =3D 8;
>              break;
>
> @@ -129,7 +132,8 @@ static void bcm2835_property_mbox_push(BCM2835Propert=
yState *s, uint32_t value)
>          case 0x00038004: /* Set max clock rate */
>          case 0x00038007: /* Set min clock rate */
>              qemu_log_mask(LOG_UNIMP,
> -                          "bcm2835_property: %x set clock rates NYI\n", =
tag);
> +                          "bcm2835_property: 0x%08x set clock rate NYI\n=
",
> +                          tag);
>              resplen =3D 8;
>              break;
>
> @@ -274,8 +278,8 @@ static void bcm2835_property_mbox_push(BCM2835Propert=
yState *s, uint32_t value)
>              break;
>
>          default:
> -            qemu_log_mask(LOG_GUEST_ERROR,
> -                          "bcm2835_property: unhandled tag %08x\n", tag)=
;
> +            qemu_log_mask(LOG_UNIMP,
> +                          "bcm2835_property: unhandled tag 0x%08x\n", ta=
g);
>              break;
>          }
>
> --
> 2.20.1
>
>

