Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F726CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23FFE21872
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FFE21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNhrh-0006um-6P
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 14:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNhmP-0006bM-H3
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNhmN-0003mD-UN
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:24:13 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:54755)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNhmD-0003jA-Gi; Thu, 24 Oct 2019 14:24:02 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mow4E-1hezcS0QQA-00qOxg; Thu, 24 Oct 2019 20:23:38 +0200
Subject: Re: [PATCH v2 06/14] hw: Move sun4v hypervisor RTC from hw/timer/ to
 hw/rtc/ subdirectory
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191003230404.19384-1-philmd@redhat.com>
 <20191003230404.19384-7-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cb9850ab-0112-64bc-5efd-733a91c4cec7@vivier.eu>
Date: Thu, 24 Oct 2019 20:23:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191003230404.19384-7-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:o6lO9hv4tjjvo9wg+ireej9n10tNgykSa1RtpBrhJ4P9rHcxXJS
 XxH61g9R65SMtP+tSumpI2p5SRUir57hmkme81GN4yqjBCWdMiIY1hO+9we9kw7VG4B0eky
 hiWwg0amEGgHohq/r71SSUjmzBYctMcncNYcP1TwD4+8cAAfRgnSt7FB/MqCWBkVLiXpi9x
 aj20PpkDKboSv9JWxexQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BWLl39G0Vhg=:adtGvSQxvKxu8sLTyJx6i6
 lR9hCOwTc0A/ExtgRjdMlSIeyyGLsWkDjkL8dPdfEZKZJpFJaIYfW80hzBUBUkwuc95tp86K/
 FoyasshCXCk8cRatnLaqImpyRZguUyzYAgama4O2tWO6auPQVNk2STR3gjt2jMkPztNFDfKVU
 SJ0KvIE14tNjPFKSNKTHx3J4FqJigxk4FJSRTcyxgwrVr4ko2QQ3S/8BA5o9JSK6lIkpd/deY
 0btaF9uBm28eUSkQXzpqVpm65hAO+YrhwFK9m45DpSPep3aE4WkEY107U5Ke/pOClOCBOp1fE
 9QkIkQc4k5Cxj/l91BWxl/aF9JOB6G3gojtrgiOshA6AKq1wrz7dkLwp2oUFzE4mMbOj/moCp
 ZKfnqL05S6O3JrF1qcE2HjO14ChiYzR1GkX9AFLFdQ7zEs2HNbcD0XI4vy8sHw+jIKqAmd4fW
 ssNeN6CbrWanZ8spY7y38fAf6CnQQa0a/pxQFhr+YdmcZli8l8mUIJYpwSrScTACvKbQJjsSN
 h1Di0lv6KG+M4MqqOP9w0xk4J03q+/v4R8oR9lNkcz4b/6RPoT4/KyB3vkdhsLCpyQomWNOkl
 Zkmbhh8UidEv4nk3jZMxn+NCjcgW9UziCnu14yUyvPF7vrY43pHFtP97YtFY8Z0iPGfM1g6k0
 Bj6DCCK/s5xvjA0VMUoXLOEcbQH6zwTKYnWSVDJ5FKBdh5DFSSG8y17Dg0RwPAwmC16V3BYfd
 LvlEjpErfOUHB+sPn+Da3ymudcLjXiG7dZjmFqZrpcAAJh/4DKkfF/ORVUwetc6uFyVC9P6Kh
 GPgfaIwaWxyQIBz4L7+cYIn53r7SeOxRbtZPPLG12RpOkVIp7yAEUbniyV17hmIYtLe6Bqnyr
 Cv7X+Ql+th8nYtAvBmD0aym4ajMdnYR8r/yM+Ceew=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.130
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-trivial@nongnu.org,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Richard Henderson <rth@twiddle.net>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/10/2019 à 01:03, Philippe Mathieu-Daudé a écrit :
> Move RTC devices under the hw/rtc/ subdirectory.
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  MAINTAINERS                   |  4 ++--
>  hw/rtc/Kconfig                |  3 +++
>  hw/rtc/Makefile.objs          |  1 +
>  hw/{timer => rtc}/sun4v-rtc.c |  2 +-
>  hw/rtc/trace-events           |  4 ++++
>  hw/sparc64/niagara.c          |  2 +-
>  hw/timer/Kconfig              |  3 ---
>  hw/timer/Makefile.objs        |  1 -
>  hw/timer/trace-events         |  4 ----
>  include/hw/rtc/sun4v-rtc.h    | 19 +++++++++++++++++++
>  include/hw/timer/sun4v-rtc.h  |  1 -
>  11 files changed, 31 insertions(+), 13 deletions(-)
>  rename hw/{timer => rtc}/sun4v-rtc.c (98%)
>  create mode 100644 include/hw/rtc/sun4v-rtc.h
>  delete mode 100644 include/hw/timer/sun4v-rtc.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0dfaa05d17..31e4fbf579 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1165,8 +1165,8 @@ Sun4v
>  M: Artyom Tarasenko <atar4qemu@gmail.com>
>  S: Maintained
>  F: hw/sparc64/niagara.c
> -F: hw/timer/sun4v-rtc.c
> -F: include/hw/timer/sun4v-rtc.h
> +F: hw/rtc/sun4v-rtc.c
> +F: include/hw/rtc/sun4v-rtc.h
>  
>  Leon3
>  M: Fabien Chouteau <chouteau@adacore.com>
> diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
> index 434b20b2b1..cc7fead764 100644
> --- a/hw/rtc/Kconfig
> +++ b/hw/rtc/Kconfig
> @@ -10,3 +10,6 @@ config PL031
>  
>  config MC146818RTC
>      bool
> +
> +config SUN4V_RTC
> +    bool
> diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
> index 89e8e48c64..4621b37bc2 100644
> --- a/hw/rtc/Makefile.objs
> +++ b/hw/rtc/Makefile.objs
> @@ -5,3 +5,4 @@ common-obj-$(CONFIG_M48T59) += m48t59-isa.o
>  endif
>  common-obj-$(CONFIG_PL031) += pl031.o
>  obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
> +common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
> diff --git a/hw/timer/sun4v-rtc.c b/hw/rtc/sun4v-rtc.c
> similarity index 98%
> rename from hw/timer/sun4v-rtc.c
> rename to hw/rtc/sun4v-rtc.c
> index 54272a822f..ada01b5774 100644
> --- a/hw/timer/sun4v-rtc.c
> +++ b/hw/rtc/sun4v-rtc.c
> @@ -13,7 +13,7 @@
>  #include "hw/sysbus.h"
>  #include "qemu/module.h"
>  #include "qemu/timer.h"
> -#include "hw/timer/sun4v-rtc.h"
> +#include "hw/rtc/sun4v-rtc.h"
>  #include "trace.h"
>  
>  
> diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
> index 54c94ac557..ac9e0e0fba 100644
> --- a/hw/rtc/trace-events
> +++ b/hw/rtc/trace-events
> @@ -1,5 +1,9 @@
>  # See docs/devel/tracing.txt for syntax documentation.
>  
> +# sun4v-rtc.c
> +sun4v_rtc_read(uint64_t addr, uint64_t value) "read: addr 0x%" PRIx64 " value 0x%" PRIx64
> +sun4v_rtc_write(uint64_t addr, uint64_t value) "write: addr 0x%" PRIx64 " value 0x%" PRIx64
> +
>  # pl031.c
>  pl031_irq_state(int level) "irq state %d"
>  pl031_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
> diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
> index 167143bffe..dfa0817eae 100644
> --- a/hw/sparc64/niagara.c
> +++ b/hw/sparc64/niagara.c
> @@ -30,7 +30,7 @@
>  #include "hw/misc/unimp.h"
>  #include "hw/loader.h"
>  #include "hw/sparc/sparc64.h"
> -#include "hw/timer/sun4v-rtc.h"
> +#include "hw/rtc/sun4v-rtc.h"
>  #include "exec/address-spaces.h"
>  #include "sysemu/block-backend.h"
>  #include "qemu/error-report.h"
> diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
> index a6b668b255..b04c928136 100644
> --- a/hw/timer/Kconfig
> +++ b/hw/timer/Kconfig
> @@ -35,9 +35,6 @@ config ALLWINNER_A10_PIT
>  config STM32F2XX_TIMER
>      bool
>  
> -config SUN4V_RTC
> -    bool
> -
>  config CMSDK_APB_TIMER
>      bool
>      select PTIMER
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index 2fb12162a6..034bd30255 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -35,7 +35,6 @@ common-obj-$(CONFIG_ALLWINNER_A10_PIT) += allwinner-a10-pit.o
>  common-obj-$(CONFIG_STM32F2XX_TIMER) += stm32f2xx_timer.o
>  common-obj-$(CONFIG_ASPEED_SOC) += aspeed_timer.o aspeed_rtc.o
>  
> -common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
>  common-obj-$(CONFIG_CMSDK_APB_TIMER) += cmsdk-apb-timer.o
>  common-obj-$(CONFIG_CMSDK_APB_DUALTIMER) += cmsdk-apb-dualtimer.o
>  common-obj-$(CONFIG_MSF2) += mss-timer.o
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index 6936fe8573..ce34b967db 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -70,10 +70,6 @@ cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer: reset"
>  aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
>  aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
>  
> -# sun4v-rtc.c
> -sun4v_rtc_read(uint64_t addr, uint64_t value) "read: addr 0x%" PRIx64 " value 0x%" PRIx64
> -sun4v_rtc_write(uint64_t addr, uint64_t value) "write: addr 0x%" PRIx64 " value 0x%" PRIx64
> -
>  # xlnx-zynqmp-rtc.c
>  xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int min, int sec) "Get time from host: %d-%d-%d %2d:%02d:%02d"
>  
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
> + * This code is licensed under the GNU GPL v3 or (at your option) any later
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
> diff --git a/include/hw/timer/sun4v-rtc.h b/include/hw/timer/sun4v-rtc.h
> deleted file mode 100644
> index 407278f918..0000000000
> --- a/include/hw/timer/sun4v-rtc.h
> +++ /dev/null
> @@ -1 +0,0 @@
> -void sun4v_rtc_init(hwaddr addr);
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

