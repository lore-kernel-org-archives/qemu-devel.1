Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BA8C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 21:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F1FF20575
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 21:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gq0hZ4nX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1FF20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDEgN-0007dz-BI
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 17:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDEfm-00076T-Hf
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 17:50:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDEfl-0001MT-EJ
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 17:50:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32562
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDEfl-0001M7-B7
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 17:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584222621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bfpArt7hPs+BhF3+XnEjP4A0sFQL8Oha1f3Dg8+P6UE=;
 b=Gq0hZ4nXaisqK9iv9BvEAyzqz1VChKvDEANbeWXPF/gONWR4XeUMyYGfTLPuwlJcal889O
 lpv/bJ+nu0Ov8pe+b2TJ15kga+iU2jh/m3z2D/5nXCB6gp3Dlch25KlyUojfc2FBclHHuD
 yWSgtYE2ARPKs7cxnPga59sf8f4Mn4E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-lN3sOeX0MRS66hPkj6jp6A-1; Sat, 14 Mar 2020 17:50:19 -0400
X-MC-Unique: lN3sOeX0MRS66hPkj6jp6A-1
Received: by mail-wr1-f71.google.com with SMTP id 31so6536623wrq.0
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 14:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IWc0xISPvYYvNCmZ9g4/J2WjpRM6MG7OyriYuaJO2zE=;
 b=fwDZqNxRpfSpeQzlgsxLf6zjOT5TEFkVk55l1qfW4rjykV/Z1hEXyhO3Wo62cNFHnk
 bE9sqkrJzg4bVMMKgMlq9i6BYiO5OlAy/5iNFEtJNOn7jaL+2BDmf7zUxduC6c98VBZA
 9suqgq9DF6SMou7+DiGL6NcjBrraohWBERhTNXFmO93xWcSvwQ+4p4EahjWjYi73bqDq
 4fihpQ+4VptIuEyFNkSBZAXKoWBiyPwcqiEIpdh2S+2adszOZtxvYwwc8J7I15cbeTCh
 jm/Lbn8ssqZw11Rv+47s1+WeP8Twx/A/W8hKkqnmiIuqWd0iqAU4aBkgo+SHGD0U0Hpp
 5lFQ==
X-Gm-Message-State: ANhLgQ1jc7KeKsHINBTPgD/ai7nV69n+T3wOEtMvr+Rv4l51Xc9ksyFo
 pvcq4VQlPtiYFxpARSIK4jrpjU+Ttb016QN+buEsZrC2XDv1zC57g4Im5x+3fuDrZiDTqqgvIFL
 tDOV8isTaxXaM0og=
X-Received: by 2002:a5d:5691:: with SMTP id f17mr25069366wrv.74.1584222617042; 
 Sat, 14 Mar 2020 14:50:17 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuIGJMFs2y6cstNNQvVhausOM28xhViZjYxipkBAbFEsDOnm0goBJgANHbXBiVnxQH50XHoyQ==
X-Received: by 2002:a5d:5691:: with SMTP id f17mr25069350wrv.74.1584222616843; 
 Sat, 14 Mar 2020 14:50:16 -0700 (PDT)
Received: from [192.168.1.40] (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id l83sm23340629wmf.43.2020.03.14.14.50.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 14:50:16 -0700 (PDT)
Subject: Re: [PATCH 4/8] hw/arm/fsl-imx31: Wire up watchdog
To: Guenter Roeck <linux@roeck-us.net>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200314172736.24528-1-linux@roeck-us.net>
 <20200314172736.24528-5-linux@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <23d19f5e-486c-dfbf-fb1f-71d99379496c@redhat.com>
Date: Sat, 14 Mar 2020 22:50:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200314172736.24528-5-linux@roeck-us.net>
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
> With this patch, the watchdog on i.MX31 emulations is fully operational.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   hw/arm/fsl-imx31.c         | 6 ++++++
>   include/hw/arm/fsl-imx31.h | 4 ++++
>   2 files changed, 10 insertions(+)
>=20
> diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
> index 55e90d104b..cec7d0dd1b 100644
> --- a/hw/arm/fsl-imx31.c
> +++ b/hw/arm/fsl-imx31.c
> @@ -63,6 +63,8 @@ static void fsl_imx31_init(Object *obj)
>           sysbus_init_child_obj(obj, "gpio[*]", &s->gpio[i], sizeof(s->gp=
io[i]),
>                                 TYPE_IMX_GPIO);
>       }
> +
> +    sysbus_init_child_obj(obj, "wdt", &s->wdt, sizeof(s->wdt), TYPE_IMX2=
_WDT);
>   }
>  =20
>   static void fsl_imx31_realize(DeviceState *dev, Error **errp)
> @@ -205,6 +207,10 @@ static void fsl_imx31_realize(DeviceState *dev, Erro=
r **errp)
>                                               gpio_table[i].irq));
>       }
>  =20
> +    /* Watchdog */
> +    object_property_set_bool(OBJECT(&s->wdt), true, "realized", &error_a=
bort);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt), 0, FSL_IMX31_WDT_ADDR);
> +
>       /* On a real system, the first 16k is a `secure boot rom' */
>       memory_region_init_rom(&s->secure_rom, NULL, "imx31.secure_rom",
>                              FSL_IMX31_SECURE_ROM_SIZE, &err);
> diff --git a/include/hw/arm/fsl-imx31.h b/include/hw/arm/fsl-imx31.h
> index ac5ca9826a..dd8561b309 100644
> --- a/include/hw/arm/fsl-imx31.h
> +++ b/include/hw/arm/fsl-imx31.h
> @@ -25,6 +25,7 @@
>   #include "hw/timer/imx_epit.h"
>   #include "hw/i2c/imx_i2c.h"
>   #include "hw/gpio/imx_gpio.h"
> +#include "hw/watchdog/wdt_imx2.h"
>   #include "exec/memory.h"
>   #include "target/arm/cpu.h"
>  =20
> @@ -49,6 +50,7 @@ typedef struct FslIMX31State {
>       IMXEPITState   epit[FSL_IMX31_NUM_EPITS];
>       IMXI2CState    i2c[FSL_IMX31_NUM_I2CS];
>       IMXGPIOState   gpio[FSL_IMX31_NUM_GPIOS];
> +    IMX2WdtState   wdt;
>       MemoryRegion   secure_rom;
>       MemoryRegion   rom;
>       MemoryRegion   iram;
> @@ -87,6 +89,8 @@ typedef struct FslIMX31State {
>   #define FSL_IMX31_GPIO1_SIZE            0x4000
>   #define FSL_IMX31_GPIO2_ADDR            0x53FD0000
>   #define FSL_IMX31_GPIO2_SIZE            0x4000
> +#define FSL_IMX31_WDT_ADDR              0x53FDC000
> +#define FSL_IMX31_WDT_SIZE              0x4000
>   #define FSL_IMX31_AVIC_ADDR             0x68000000
>   #define FSL_IMX31_AVIC_SIZE             0x100
>   #define FSL_IMX31_SDRAM0_ADDR           0x80000000
>=20

Missing Kconfig hunk:

-- >8 --
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 4cf8fa4967..8af023abde 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -366,6 +366,7 @@ config FSL_IMX31
      select SERIAL
      select IMX
      select IMX_I2C
+    select WDT_IMX2
      select LAN9118

  config FSL_IMX6
---

With it:
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


