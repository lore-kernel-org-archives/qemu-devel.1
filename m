Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0930EC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 21:49:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC29B20575
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 21:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iI36HXx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC29B20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDEem-0006Zz-1K
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 17:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41115)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDEe2-0005yy-82
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 17:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDEe1-0007yG-2f
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 17:48:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47191
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDEe0-0007xx-VS
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 17:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584222512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iC+NnaLdFmDSspoHJH+k3hdBcLyhVaXNaCzQsw02eHg=;
 b=iI36HXx9A5tEcXXUhrjaIx8/tC7u3mhWnOXp5qkVl7S0HHbPteLr6XMSYVuZACiPzu/jzB
 AC7S0hK3jbVjNeREjz3V7kbE+plTevocsL7KZvj9Y840Ot/U09zG7dNAGEYMAp8znx116S
 KgezQTdFtVJL1Y111ic/JHnIaMxhIuc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-Z0sRd6BtPoiryQnov1s0ag-1; Sat, 14 Mar 2020 17:48:30 -0400
X-MC-Unique: Z0sRd6BtPoiryQnov1s0ag-1
Received: by mail-wr1-f69.google.com with SMTP id c16so6527566wrt.2
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 14:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o+GlX0yGJVjTa6NhTztpRlFv5IWxl2dIkOAXxvH6rXc=;
 b=MsSWAQezJl9Y41U6sp7PMz2xXxnQU8eeSGnk412znAPra91sJot5y9Ey1ibGAxlTF0
 dFSkrbFFh0/76A000f2daC6D3yt3ZiahygfSK4+OPEqQyEMWNVKuM9W92VU71xIXgpTn
 U+LPpkWJnnrfkZHWYArqiDNgJnLC5ecB/LmewPnbC0UZGOd4TXLCh+gVUDxMoCCQg9z0
 yGyBx4ZgTGqyQ/TXEF+GODnlJLFN5GRKrEs5U+vXXuz4AMu2o1Uimm6brgLaPIYEdWJW
 thO0PKs5ttCt6sSWSah2Gb3lxDG2mgpm6GHRfXYuCNgUhXv4Wx34WArKkJd8zyG8to3L
 22Yg==
X-Gm-Message-State: ANhLgQ3vhWiWmF5T8hXMKYt60ljJVB1VWOWewFeSyMyKtRb8lDKOTpFh
 aiBKHXPx6DySWdOl/u5l+kBMloMsbv6ZNutvKaThbGcYh7vZmCE5YHpmvxKD3ZvlwsZxtALOva6
 cT4bdmuRBhQWqOiM=
X-Received: by 2002:a5d:6748:: with SMTP id l8mr17013972wrw.265.1584222509763; 
 Sat, 14 Mar 2020 14:48:29 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsJqtTuxN5MhFv1T+WHDx0bzV1Be6ZFF7t3ON8DfT4eXC7rkxvnhantk1YBMqTneCVVqsdz9w==
X-Received: by 2002:a5d:6748:: with SMTP id l8mr17013963wrw.265.1584222509536; 
 Sat, 14 Mar 2020 14:48:29 -0700 (PDT)
Received: from [192.168.1.40] (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id b203sm23578360wmc.45.2020.03.14.14.48.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 14:48:29 -0700 (PDT)
Subject: Re: [PATCH 3/8] hw/arm/fsl-imx25: Wire up watchdog
To: Guenter Roeck <linux@roeck-us.net>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200314172736.24528-1-linux@roeck-us.net>
 <20200314172736.24528-4-linux@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d449eaae-0a87-b221-d097-d90340029398@redhat.com>
Date: Sat, 14 Mar 2020 22:48:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200314172736.24528-4-linux@roeck-us.net>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, qemu-devel@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/14/20 6:27 PM, Guenter Roeck wrote:
> With this commit, the watchdog on imx25-pdk is fully operational,
> including pretimeout support.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   hw/arm/fsl-imx25.c         | 10 ++++++++++
>   include/hw/arm/fsl-imx25.h |  5 +++++
>   2 files changed, 15 insertions(+)
>=20
> diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
> index a3f829f436..7d5aab562d 100644
> --- a/hw/arm/fsl-imx25.c
> +++ b/hw/arm/fsl-imx25.c
> @@ -87,6 +87,7 @@ static void fsl_imx25_init(Object *obj)
>                                 TYPE_CHIPIDEA);
>       }
>  =20
> +    sysbus_init_child_obj(obj, "wdt", &s->wdt, sizeof(s->wdt), TYPE_IMX2=
_WDT);
>   }
>  =20
>   static void fsl_imx25_realize(DeviceState *dev, Error **errp)
> @@ -302,6 +303,15 @@ static void fsl_imx25_realize(DeviceState *dev, Erro=
r **errp)
>                                               usb_table[i].irq));
>       }
>  =20
> +    /* Watchdog */
> +    object_property_set_bool(OBJECT(&s->wdt), true, "pretimeout-support"=
,
> +                             &error_abort);
> +    object_property_set_bool(OBJECT(&s->wdt), true, "realized", &error_a=
bort);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt), 0, FSL_IMX25_WDT_ADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt), 0,
> +                                      qdev_get_gpio_in(DEVICE(&s->avic),
> +                                                       FSL_IMX25_WDT_IRQ=
));
> +
>       /* initialize 2 x 16 KB ROM */
>       memory_region_init_rom(&s->rom[0], NULL,
>                              "imx25.rom0", FSL_IMX25_ROM0_SIZE, &err);
> diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
> index 5e196bbf05..9e228dacea 100644
> --- a/include/hw/arm/fsl-imx25.h
> +++ b/include/hw/arm/fsl-imx25.h
> @@ -29,6 +29,7 @@
>   #include "hw/gpio/imx_gpio.h"
>   #include "hw/sd/sdhci.h"
>   #include "hw/usb/chipidea.h"
> +#include "hw/watchdog/wdt_imx2.h"
>   #include "exec/memory.h"
>   #include "target/arm/cpu.h"
>  =20
> @@ -60,6 +61,7 @@ typedef struct FslIMX25State {
>       IMXGPIOState   gpio[FSL_IMX25_NUM_GPIOS];
>       SDHCIState     esdhc[FSL_IMX25_NUM_ESDHCS];
>       ChipideaState  usb[FSL_IMX25_NUM_USBS];
> +    IMX2WdtState   wdt;
>       MemoryRegion   rom[2];
>       MemoryRegion   iram;
>       MemoryRegion   iram_alias;
> @@ -229,6 +231,8 @@ typedef struct FslIMX25State {
>   #define FSL_IMX25_GPIO1_SIZE    0x4000
>   #define FSL_IMX25_GPIO2_ADDR    0x53FD0000
>   #define FSL_IMX25_GPIO2_SIZE    0x4000
> +#define FSL_IMX25_WDT_ADDR      0x53FDC000
> +#define FSL_IMX25_WDT_SIZE      0x4000
>   #define FSL_IMX25_USB1_ADDR     0x53FF4000
>   #define FSL_IMX25_USB1_SIZE     0x0200
>   #define FSL_IMX25_USB2_ADDR     0x53FF4400
> @@ -268,5 +272,6 @@ typedef struct FslIMX25State {
>   #define FSL_IMX25_ESDHC2_IRQ    8
>   #define FSL_IMX25_USB1_IRQ      37
>   #define FSL_IMX25_USB2_IRQ      35
> +#define FSL_IMX25_WDT_IRQ       55
>  =20
>   #endif /* FSL_IMX25_H */
>=20

Here you also need:

-- >8 --
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index c662d5f1e0..4cf8fa4967 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -358,6 +358,7 @@ config FSL_IMX25
      select IMX
      select IMX_FEC
      select IMX_I2C
+    select WDT_IMX2
      select DS1338

  config FSL_IMX31
---

With it:
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


