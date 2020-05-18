Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D7FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:55:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E44F520758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5XV+Qnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44F520758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaj39-00081V-3p
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jaizc-0002bD-0C; Mon, 18 May 2020 12:51:56 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:41436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jaiza-000170-Up; Mon, 18 May 2020 12:51:55 -0400
Received: by mail-il1-x142.google.com with SMTP id b71so10498704ilg.8;
 Mon, 18 May 2020 09:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JLl6Oqn+XkPIiE3xybVEx94h32oZCJQ+9UbkT17BpeA=;
 b=b5XV+QnjRfTHqw0pZPs3qZJfegfmLONpgr0x61Gp36IOOaJ7jZICv4W4a9k6luZebj
 PVstfIbyByrQoXdLx5I8khqNEUaWNWTWj+QeNq/gj5y6g2uXH5LqhiV60L1IurhfBPhL
 D45BsfKSHGBaBeK27yYZ3EFP90h9XqJSaxxFZYOh4uG1UNqCuqXrhToL2W6pofkQuAMG
 0JBFg4Ci/9qUIUE/eG9kvSUVWhPoTfz+kRzy46/Y6sQmAF5QLuzib1NrpfbEvYNmKmxQ
 Zq208dqaDgNhyySup74o/3bcRskazOjG3XWt479OTRUKiNF5KjfC1IN3LOPXWj9e70Dm
 poog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JLl6Oqn+XkPIiE3xybVEx94h32oZCJQ+9UbkT17BpeA=;
 b=Ygd2TTiGMwRPyuFCnjw6hCG8PJjomS5qJy4pX3neNFbdxd2fTjC5Zyd8C76ASN+t1P
 Cj/PAh36jwLRrwLlTD6ba6qoX9U0Loxzbnp8W9lbKQBJH1jct2UTjtPSsM4HmfmbjRd5
 iun8+PeljVJPhN1BK2hxhr6b8gVrknRJxxq8njd5q15vF2tPJauVnJFo8llWa4hJAYbb
 UBZviYT8JTUg0mdWH+7JDJbP65EjZzvdk2XgNI60mt1mCBrJd/E8uFcyvMiUZm5OgS8n
 gCiNnVnIksdqAN+YjoML2Ey9nUry53pImxl7O0fch1sZn2haO0qD+geQZvoVjvYMtChU
 fr8A==
X-Gm-Message-State: AOAM533D3by0jHeXhQ+kStG0SS5QngJjqgDqq3A1RseGqK0xi3rj0GH4
 1y92oQS9xT66WbhZSC6MBNRf+8Tt8r29G5rreQc=
X-Google-Smtp-Source: ABdhPJzqg8DZK/AmXwEY6sp1P30kYAkcIMYENIKplcLqEcsneMxrkw5Z7oDURrJATwgBILkDhSrCU/vmqQhO4ykIU0M=
X-Received: by 2002:a92:de02:: with SMTP id x2mr17846069ilm.267.1589820713247; 
 Mon, 18 May 2020 09:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200518140309.5220-1-f4bug@amsat.org>
 <20200518140309.5220-3-f4bug@amsat.org>
In-Reply-To: <20200518140309.5220-3-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2020 09:43:02 -0700
Message-ID: <CAKmqyKN4bSSdvAyoPjAYZoiMLuPT=SDrVkq5OSb3Pk4Q0Jhp4w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] hw/arm/pxa2xx: Replace hw_error() by
 qemu_log_mask()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 18, 2020 at 7:03 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> hw_error() calls exit(). This a bit overkill when we can log
> the accesses as unimplemented or guest error.
>
> When fuzzing the devices, we don't want the whole process to
> exit. Replace some hw_error() calls by qemu_log_mask().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/pxa2xx_gpio.c    |  7 ++++---
>  hw/display/pxa2xx_lcd.c |  8 +++++---
>  hw/dma/pxa2xx_dma.c     | 14 +++++++++-----
>  3 files changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/hw/arm/pxa2xx_gpio.c b/hw/arm/pxa2xx_gpio.c
> index f8df3cc227..a01db54a51 100644
> --- a/hw/arm/pxa2xx_gpio.c
> +++ b/hw/arm/pxa2xx_gpio.c
> @@ -9,7 +9,6 @@
>
>  #include "qemu/osdep.h"
>  #include "cpu.h"
> -#include "hw/hw.h"
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/sysbus.h"
> @@ -199,7 +198,8 @@ static uint64_t pxa2xx_gpio_read(void *opaque, hwaddr=
 offset,
>          return s->status[bank];
>
>      default:
> -        hw_error("%s: Bad offset " REG_FMT "\n", __func__, offset);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX =
"\n",
> +                      __func__, offset);
>      }
>
>      return 0;
> @@ -252,7 +252,8 @@ static void pxa2xx_gpio_write(void *opaque, hwaddr of=
fset,
>          break;
>
>      default:
> -        hw_error("%s: Bad offset " REG_FMT "\n", __func__, offset);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX =
"\n",
> +                      __func__, offset);
>      }
>  }
>
> diff --git a/hw/display/pxa2xx_lcd.c b/hw/display/pxa2xx_lcd.c
> index 464e93161a..d5f2e82a4e 100644
> --- a/hw/display/pxa2xx_lcd.c
> +++ b/hw/display/pxa2xx_lcd.c
> @@ -11,7 +11,7 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include "hw/hw.h"
> +#include "qemu/log.h"
>  #include "hw/irq.h"
>  #include "migration/vmstate.h"
>  #include "ui/console.h"
> @@ -407,7 +407,8 @@ static uint64_t pxa2xx_lcdc_read(void *opaque, hwaddr=
 offset,
>
>      default:
>      fail:
> -        hw_error("%s: Bad offset " REG_FMT "\n", __func__, offset);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX =
"\n",
> +                      __func__, offset);
>      }
>
>      return 0;
> @@ -562,7 +563,8 @@ static void pxa2xx_lcdc_write(void *opaque, hwaddr of=
fset,
>
>      default:
>      fail:
> -        hw_error("%s: Bad offset " REG_FMT "\n", __func__, offset);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX =
"\n",
> +                      __func__, offset);
>      }
>  }
>
> diff --git a/hw/dma/pxa2xx_dma.c b/hw/dma/pxa2xx_dma.c
> index 88ed4b6ff1..8a2eeb32bc 100644
> --- a/hw/dma/pxa2xx_dma.c
> +++ b/hw/dma/pxa2xx_dma.c
> @@ -9,6 +9,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "hw/hw.h"
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
> @@ -268,7 +269,8 @@ static uint64_t pxa2xx_dma_read(void *opaque, hwaddr =
offset,
>      unsigned int channel;
>
>      if (size !=3D 4) {
> -        hw_error("%s: Bad access width\n", __func__);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad access width %u\n",
> +                      __func__, size);
>          return 5;
>      }
>
> @@ -315,8 +317,8 @@ static uint64_t pxa2xx_dma_read(void *opaque, hwaddr =
offset,
>              return s->chan[channel].cmd;
>          }
>      }
> -
> -    hw_error("%s: Bad offset 0x" TARGET_FMT_plx "\n", __func__, offset);
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n"=
,
> +                  __func__, offset);
>      return 7;
>  }
>
> @@ -327,7 +329,8 @@ static void pxa2xx_dma_write(void *opaque, hwaddr off=
set,
>      unsigned int channel;
>
>      if (size !=3D 4) {
> -        hw_error("%s: Bad access width\n", __func__);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad access width %u\n",
> +                      __func__, size);
>          return;
>      }
>
> @@ -420,7 +423,8 @@ static void pxa2xx_dma_write(void *opaque, hwaddr off=
set,
>              break;
>          }
>      fail:
> -        hw_error("%s: Bad offset " TARGET_FMT_plx "\n", __func__, offset=
);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX =
"\n",
> +                      __func__, offset);
>      }
>  }
>
> --
> 2.21.3
>
>

