Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390E2CA9EBC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1066C21D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1066C21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeCU-00060W-TZ
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNdop-00020u-9h
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:10:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNdon-0001v7-1I
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:10:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60712)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNdom-0001tI-Or
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:10:24 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AE0E8356CE
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 14:10:23 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id l184so1336889wmf.6
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IUvC0Te2uHehT4TVThYtj2pAOWd4YcJNRS5YDphkgtE=;
 b=q3Ykw7Vz8Sc0ogjfjds8Jp2YojqawdzbkbxCQAgWe01H1Ahyy0CJ/6QFYJGOi3ymkT
 f1NF1XXk+2lrYbmWpDq+A4YXNeAnKKNUYgLinfIKwjTkKwDC48rIFGmn6Dx9SO/0ohJG
 XTFOmsA/GES8jdK8E0IdfWbZFyTpS/x7I3py4lux0zqRhGNPGCESuttqY53VkD6bXhV7
 NINVtUDp/rewNVkyq1FLXFMS7ZXdbXyc85R7fd30UDP47RTFK6I6bcdAQe1XBF83QsZf
 RR9a87H11osLA9u9cZRQZ75ptQhBKw2H23WBHlhkeP4A1UwEq5e7HxwkJaU+WrYCaNTx
 5s+g==
X-Gm-Message-State: APjAAAWYWw4MroNNQZt33r3IBS34ZkJsMTCedb8ZqvioWBc/hX6YH63D
 4EwK9TQiclaNFZOEAZjZf1iVd3zf9pI+OJYXIYpZCK+NFawbPdlJIPGShtGiUnwuclbYRTMPnN3
 k/6cYyZ94KwfJM+c=
X-Received: by 2002:a1c:8055:: with SMTP id b82mr2162469wmd.176.1571926222152; 
 Thu, 24 Oct 2019 07:10:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz1LsC07MyYmcfDJfLsIhVchoJ5az23XXMxpaL4yG2zxr9OR/a9wScMJ2eqRH3oMrzTZWs61A==
X-Received: by 2002:a1c:8055:: with SMTP id b82mr2162406wmd.176.1571926221787; 
 Thu, 24 Oct 2019 07:10:21 -0700 (PDT)
Received: from [192.168.1.115] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id v10sm3904524wmg.48.2019.10.24.07.10.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:10:20 -0700 (PDT)
Subject: Re: [PATCH v2 06/14] hw: Move sun4v hypervisor RTC from hw/timer/ to
 hw/rtc/ subdirectory
To: Artyom Tarasenko <atar4qemu@gmail.com>
References: <20191003230404.19384-1-philmd@redhat.com>
 <20191003230404.19384-7-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b1131c3d-d421-6130-b113-faa5e19c42a8@redhat.com>
Date: Thu, 24 Oct 2019 16:10:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191003230404.19384-7-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goat?= =?UTF-8?Q?er?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-trivial@nongnu.org, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Artyom,

Do you mind Acking this patch?

On 10/4/19 1:03 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Move RTC devices under the hw/rtc/ subdirectory.
>=20
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   MAINTAINERS                   |  4 ++--
>   hw/rtc/Kconfig                |  3 +++
>   hw/rtc/Makefile.objs          |  1 +
>   hw/{timer =3D> rtc}/sun4v-rtc.c |  2 +-
>   hw/rtc/trace-events           |  4 ++++
>   hw/sparc64/niagara.c          |  2 +-
>   hw/timer/Kconfig              |  3 ---
>   hw/timer/Makefile.objs        |  1 -
>   hw/timer/trace-events         |  4 ----
>   include/hw/rtc/sun4v-rtc.h    | 19 +++++++++++++++++++
>   include/hw/timer/sun4v-rtc.h  |  1 -
>   11 files changed, 31 insertions(+), 13 deletions(-)
>   rename hw/{timer =3D> rtc}/sun4v-rtc.c (98%)
>   create mode 100644 include/hw/rtc/sun4v-rtc.h
>   delete mode 100644 include/hw/timer/sun4v-rtc.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0dfaa05d17..31e4fbf579 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1165,8 +1165,8 @@ Sun4v
>   M: Artyom Tarasenko <atar4qemu@gmail.com>
>   S: Maintained
>   F: hw/sparc64/niagara.c
> -F: hw/timer/sun4v-rtc.c
> -F: include/hw/timer/sun4v-rtc.h
> +F: hw/rtc/sun4v-rtc.c
> +F: include/hw/rtc/sun4v-rtc.h
>  =20
>   Leon3
>   M: Fabien Chouteau <chouteau@adacore.com>
> diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
> index 434b20b2b1..cc7fead764 100644
> --- a/hw/rtc/Kconfig
> +++ b/hw/rtc/Kconfig
> @@ -10,3 +10,6 @@ config PL031
>  =20
>   config MC146818RTC
>       bool
> +
> +config SUN4V_RTC
> +    bool
> diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
> index 89e8e48c64..4621b37bc2 100644
> --- a/hw/rtc/Makefile.objs
> +++ b/hw/rtc/Makefile.objs
> @@ -5,3 +5,4 @@ common-obj-$(CONFIG_M48T59) +=3D m48t59-isa.o
>   endif
>   common-obj-$(CONFIG_PL031) +=3D pl031.o
>   obj-$(CONFIG_MC146818RTC) +=3D mc146818rtc.o
> +common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o
> diff --git a/hw/timer/sun4v-rtc.c b/hw/rtc/sun4v-rtc.c
> similarity index 98%
> rename from hw/timer/sun4v-rtc.c
> rename to hw/rtc/sun4v-rtc.c
> index 54272a822f..ada01b5774 100644
> --- a/hw/timer/sun4v-rtc.c
> +++ b/hw/rtc/sun4v-rtc.c
> @@ -13,7 +13,7 @@
>   #include "hw/sysbus.h"
>   #include "qemu/module.h"
>   #include "qemu/timer.h"
> -#include "hw/timer/sun4v-rtc.h"
> +#include "hw/rtc/sun4v-rtc.h"
>   #include "trace.h"
>  =20
>  =20
> diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
> index 54c94ac557..ac9e0e0fba 100644
> --- a/hw/rtc/trace-events
> +++ b/hw/rtc/trace-events
> @@ -1,5 +1,9 @@
>   # See docs/devel/tracing.txt for syntax documentation.
>  =20
> +# sun4v-rtc.c
> +sun4v_rtc_read(uint64_t addr, uint64_t value) "read: addr 0x%" PRIx64 =
" value 0x%" PRIx64
> +sun4v_rtc_write(uint64_t addr, uint64_t value) "write: addr 0x%" PRIx6=
4 " value 0x%" PRIx64
> +
>   # pl031.c
>   pl031_irq_state(int level) "irq state %d"
>   pl031_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
> diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
> index 167143bffe..dfa0817eae 100644
> --- a/hw/sparc64/niagara.c
> +++ b/hw/sparc64/niagara.c
> @@ -30,7 +30,7 @@
>   #include "hw/misc/unimp.h"
>   #include "hw/loader.h"
>   #include "hw/sparc/sparc64.h"
> -#include "hw/timer/sun4v-rtc.h"
> +#include "hw/rtc/sun4v-rtc.h"
>   #include "exec/address-spaces.h"
>   #include "sysemu/block-backend.h"
>   #include "qemu/error-report.h"
> diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
> index a6b668b255..b04c928136 100644
> --- a/hw/timer/Kconfig
> +++ b/hw/timer/Kconfig
> @@ -35,9 +35,6 @@ config ALLWINNER_A10_PIT
>   config STM32F2XX_TIMER
>       bool
>  =20
> -config SUN4V_RTC
> -    bool
> -
>   config CMSDK_APB_TIMER
>       bool
>       select PTIMER
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index 2fb12162a6..034bd30255 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -35,7 +35,6 @@ common-obj-$(CONFIG_ALLWINNER_A10_PIT) +=3D allwinner=
-a10-pit.o
>   common-obj-$(CONFIG_STM32F2XX_TIMER) +=3D stm32f2xx_timer.o
>   common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_timer.o aspeed_rtc.o
>  =20
> -common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o
>   common-obj-$(CONFIG_CMSDK_APB_TIMER) +=3D cmsdk-apb-timer.o
>   common-obj-$(CONFIG_CMSDK_APB_DUALTIMER) +=3D cmsdk-apb-dualtimer.o
>   common-obj-$(CONFIG_MSF2) +=3D mss-timer.o
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index 6936fe8573..ce34b967db 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -70,10 +70,6 @@ cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer=
: reset"
>   aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " =
value 0x%08" PRIx64
>   aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 "=
 value 0x%08" PRIx64
>  =20
> -# sun4v-rtc.c
> -sun4v_rtc_read(uint64_t addr, uint64_t value) "read: addr 0x%" PRIx64 =
" value 0x%" PRIx64
> -sun4v_rtc_write(uint64_t addr, uint64_t value) "write: addr 0x%" PRIx6=
4 " value 0x%" PRIx64
> -
>   # xlnx-zynqmp-rtc.c
>   xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int m=
in, int sec) "Get time from host: %d-%d-%d %2d:%02d:%02d"
>  =20
> diff --git a/include/hw/rtc/sun4v-rtc.h b/include/hw/rtc/sun4v-rtc.h
> new file mode 100644
> index 0000000000..fd868f6ed2
> --- /dev/null
> +++ b/include/hw/rtc/sun4v-rtc.h
> @@ -0,0 +1,19 @@
> +/*
> + * QEMU sun4v Real Time Clock device
> + *
> + * The sun4v_rtc device (sun4v tod clock)
> + *
> + * Copyright (c) 2016 Artyom Tarasenko
> + *
> + * This code is licensed under the GNU GPL v3 or (at your option) any =
later
> + * version.
> + */
> +
> +#ifndef HW_RTC_SUN4V
> +#define HW_RTC_SUN4V
> +
> +#include "exec/hwaddr.h"
> +
> +void sun4v_rtc_init(hwaddr addr);
> +
> +#endif
> diff --git a/include/hw/timer/sun4v-rtc.h b/include/hw/timer/sun4v-rtc.=
h
> deleted file mode 100644
> index 407278f918..0000000000
> --- a/include/hw/timer/sun4v-rtc.h
> +++ /dev/null
> @@ -1 +0,0 @@
> -void sun4v_rtc_init(hwaddr addr);
>=20

