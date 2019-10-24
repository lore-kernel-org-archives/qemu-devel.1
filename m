Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E74CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C18220684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C18220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNhkj-0002iR-QZ
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 14:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNhd4-00029q-7r
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNhd2-0000mP-B8
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:14:34 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:37867)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNhd2-0000lz-1i; Thu, 24 Oct 2019 14:14:32 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MPXta-1ibOzU3wpe-00Mbwf; Thu, 24 Oct 2019 20:14:07 +0200
Subject: Re: [PATCH v2 03/14] hw: Move MC146818 device from hw/timer/ to
 hw/rtc/ subdirectory
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191003230404.19384-1-philmd@redhat.com>
 <20191003230404.19384-4-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c24b0edf-9364-d6eb-6433-854d937320bc@vivier.eu>
Date: Thu, 24 Oct 2019 20:14:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191003230404.19384-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:La8XN/pHojyhQuxC4Jqlhb7UZAwrEsKuJoUugUtv1Sc6X+b57eW
 4o5M+T123KgZ7QVLAmmdzZw4LNdjDZE8Wqm+ZVxB50ZHTppbGqyZ4AoPygKmuSu37a2A4kp
 rgBYK4p5/mr1g4fH6obQKE2gUTHrlu0ViaGwV9T0IlMG+lgvKNxo31QAg0nYcyCrPMzTC5w
 mNf1aAkShVf9mc+mk5JrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rUrPR27hGuA=:btLeeWYi4O11pZ8iaR/RoS
 vsPOSjSpYYCtmJxZ2B9g5utu1jz1wR4nKkVRpdk+X4/6CCilEGto51ZeMhdxY0l7pOhcxQUm9
 GCHtZpqtukH5KWOIJMUyfZMNHk8R14gbxkdWCtmtIVd2VErvec4k9E5bm3tWezMt1HXEQcExO
 ttEj3v59+GJVu+d9UKZ+N8bP3q4UhYGHViHVEvVFTktWa1Ajb83bmDw9KJ9gVVIN0ftp9BkLY
 dqZM0hyaCv8sRaEOiFONUxUJItiI42fz36P4AD+IVoFJgGaXSwSGGUpb+8Z/3VwOi4sI598nc
 qjiL7uu6GVVWERVJs7+1LSSGVPsTASmi9QUYfgak/z9y3pHrOwHQShLsfOdVXzeenmEIZLBHE
 Sx2Rs1sBRS6RkNXB7jVfd92hzy3JST6qRFAVn6MhE2xrgy4iL6p9nYsRU0a9DaqeasmBy/cUs
 SC4vt1MXO09U/M6Dcvp57PZj7/O8Jup4BEZPCFZP2AvoaJ4Q3KvrThWPDx65iZ1kvXlrGGkHz
 wONG56gXuCCnOUtKHptHyKe61hyCq4H9u1yZSqGzExpWvaoSyCPX2R47JPuL4pwZQWz0bAsOG
 5FjYFFlEzOicxkSt5xZHT/JcLSJ1rDtQFB56soiq4scCLOKHQtnAgQb1bKFLNGO8g6rRWrRw2
 CsJ+Wdxz6LA3Y1W07FmehHdGLj4cZBT2/ZcYAvpX8bMGoO+NLhoel475yntjhv/BKx0wGRU6s
 pKNfpmv2RIyAJtWBT61+k2S5xNo376fuW9PjNAQdnpQ9+n3KLCJy6pf2FRMp+chZyTuG8DEFf
 v8S1g6s3/6S7WH6pTbYcCOnwdtHvumBih2jqnJfhF9uITK1YygOLOdgPDOfxb6/n5Hgeqs2Rp
 YkL2ZMruHCdWxjskmlDBuBVai+chjDPtzRspos9ak=
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
> The MC146818 is a Real Time Clock, not a timer.
> Move it under the hw/rtc/ subdirectory.
> 
> Use copyright statement from 80cabfad163 for "hw/rtc/mc146818rtc.h".
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v2: Use SPDX identifier (thuth)
> ---
>  MAINTAINERS                                  |  4 ++--
>  hw/alpha/dp264.c                             |  2 +-
>  hw/hppa/machine.c                            |  2 +-
>  hw/i386/acpi-build.c                         |  2 +-
>  hw/i386/pc.c                                 |  2 +-
>  hw/i386/pc_q35.c                             |  2 +-
>  hw/mips/mips_fulong2e.c                      |  2 +-
>  hw/mips/mips_jazz.c                          |  2 +-
>  hw/mips/mips_malta.c                         |  2 +-
>  hw/mips/mips_r4k.c                           |  2 +-
>  hw/ppc/pnv.c                                 |  2 +-
>  hw/ppc/prep.c                                |  2 +-
>  hw/rtc/Kconfig                               |  3 +++
>  hw/rtc/Makefile.objs                         |  1 +
>  hw/{timer => rtc}/mc146818rtc.c              |  2 +-
>  hw/timer/Kconfig                             |  3 ---
>  hw/timer/Makefile.objs                       |  2 --
>  hw/timer/hpet.c                              |  2 +-
>  include/hw/{timer => rtc}/mc146818rtc.h      | 14 +++++++++++---
>  include/hw/{timer => rtc}/mc146818rtc_regs.h |  5 +++--
>  tests/rtc-test.c                             |  2 +-
>  21 files changed, 34 insertions(+), 26 deletions(-)
>  rename hw/{timer => rtc}/mc146818rtc.c (99%)
>  rename include/hw/{timer => rtc}/mc146818rtc.h (58%)
>  rename include/hw/{timer => rtc}/mc146818rtc_regs.h (96%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 92d27f1206..e3255cdbf2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1263,7 +1263,7 @@ F: hw/misc/debugexit.c
>  F: hw/misc/pc-testdev.c
>  F: hw/timer/hpet*
>  F: hw/timer/i8254*
> -F: hw/timer/mc146818rtc*
> +F: hw/rtc/mc146818rtc*
>  F: hw/watchdog/wdt_ib700.c
>  F: hw/watchdog/wdt_i6300esb.c
>  F: include/hw/display/vga.h
> @@ -1275,7 +1275,7 @@ F: include/hw/isa/i8259_internal.h
>  F: include/hw/isa/superio.h
>  F: include/hw/timer/hpet.h
>  F: include/hw/timer/i8254*
> -F: include/hw/timer/mc146818rtc*
> +F: include/hw/rtc/mc146818rtc*
>  
>  Machine core
>  M: Eduardo Habkost <ehabkost@redhat.com>
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> index 51feee8558..51b3cf7a61 100644
> --- a/hw/alpha/dp264.c
> +++ b/hw/alpha/dp264.c
> @@ -14,7 +14,7 @@
>  #include "alpha_sys.h"
>  #include "qemu/error-report.h"
>  #include "sysemu/sysemu.h"
> -#include "hw/timer/mc146818rtc.h"
> +#include "hw/rtc/mc146818rtc.h"
>  #include "hw/ide.h"
>  #include "hw/timer/i8254.h"
>  #include "hw/isa/superio.h"
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index 2736ce835e..6598e2469d 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -12,7 +12,7 @@
>  #include "qemu/error-report.h"
>  #include "sysemu/reset.h"
>  #include "sysemu/sysemu.h"
> -#include "hw/timer/mc146818rtc.h"
> +#include "hw/rtc/mc146818rtc.h"
>  #include "hw/ide.h"
>  #include "hw/timer/i8254.h"
>  #include "hw/char/serial.h"
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 4e0f9f425a..fb53e0b691 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -45,7 +45,7 @@
>  #include "hw/acpi/vmgenid.h"
>  #include "hw/boards.h"
>  #include "sysemu/tpm_backend.h"
> -#include "hw/timer/mc146818rtc_regs.h"
> +#include "hw/rtc/mc146818rtc_regs.h"
>  #include "migration/vmstate.h"
>  #include "hw/mem/memory-device.h"
>  #include "sysemu/numa.h"
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index bcda50efcc..061cdb77f8 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -42,7 +42,7 @@
>  #include "elf.h"
>  #include "migration/vmstate.h"
>  #include "multiboot.h"
> -#include "hw/timer/mc146818rtc.h"
> +#include "hw/rtc/mc146818rtc.h"
>  #include "hw/dma/i8257.h"
>  #include "hw/timer/i8254.h"
>  #include "hw/input/i8042.h"
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 8fad20f314..748fc2ee15 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -33,7 +33,7 @@
>  #include "hw/loader.h"
>  #include "sysemu/arch_init.h"
>  #include "hw/i2c/smbus_eeprom.h"
> -#include "hw/timer/mc146818rtc.h"
> +#include "hw/rtc/mc146818rtc.h"
>  #include "hw/xen/xen.h"
>  #include "sysemu/kvm.h"
>  #include "kvm_i386.h"
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index cf537dd7e6..03a27e1767 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -39,7 +39,7 @@
>  #include "hw/ide.h"
>  #include "elf.h"
>  #include "hw/isa/vt82c686.h"
> -#include "hw/timer/mc146818rtc.h"
> +#include "hw/rtc/mc146818rtc.h"
>  #include "hw/timer/i8254.h"
>  #include "exec/address-spaces.h"
>  #include "sysemu/qtest.h"
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index c967b97d80..2811a4bd90 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -39,7 +39,7 @@
>  #include "hw/scsi/esp.h"
>  #include "hw/mips/bios.h"
>  #include "hw/loader.h"
> -#include "hw/timer/mc146818rtc.h"
> +#include "hw/rtc/mc146818rtc.h"
>  #include "hw/timer/i8254.h"
>  #include "hw/display/vga.h"
>  #include "hw/audio/pcspk.h"
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 4d9c64b36a..c1c8810e71 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -45,7 +45,7 @@
>  #include "hw/irq.h"
>  #include "hw/loader.h"
>  #include "elf.h"
> -#include "hw/timer/mc146818rtc.h"
> +#include "hw/rtc/mc146818rtc.h"
>  #include "hw/timer/i8254.h"
>  #include "exec/address-spaces.h"
>  #include "hw/sysbus.h"             /* SysBusDevice */
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
> index bc0be26544..70024235ae 100644
> --- a/hw/mips/mips_r4k.c
> +++ b/hw/mips/mips_r4k.c
> @@ -28,7 +28,7 @@
>  #include "hw/ide.h"
>  #include "hw/loader.h"
>  #include "elf.h"
> -#include "hw/timer/mc146818rtc.h"
> +#include "hw/rtc/mc146818rtc.h"
>  #include "hw/input/i8042.h"
>  #include "hw/timer/i8254.h"
>  #include "exec/address-spaces.h"
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 3f08db7b9e..4b2649d95b 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -48,7 +48,7 @@
>  #include "hw/isa/isa.h"
>  #include "hw/boards.h"
>  #include "hw/char/serial.h"
> -#include "hw/timer/mc146818rtc.h"
> +#include "hw/rtc/mc146818rtc.h"
>  
>  #include <libfdt.h>
>  
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 4f3c6bf190..3a51536e1a 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -40,7 +40,7 @@
>  #include "hw/ide.h"
>  #include "hw/irq.h"
>  #include "hw/loader.h"
> -#include "hw/timer/mc146818rtc.h"
> +#include "hw/rtc/mc146818rtc.h"
>  #include "hw/isa/pc87312.h"
>  #include "hw/net/ne2000-isa.h"
>  #include "sysemu/arch_init.h"
> diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
> index 8a4383bca9..7ffd702268 100644
> --- a/hw/rtc/Kconfig
> +++ b/hw/rtc/Kconfig
> @@ -1,2 +1,5 @@
>  config PL031
>      bool
> +
> +config MC146818RTC
> +    bool
> diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
> index 3e1eb42563..3cac0d5a63 100644
> --- a/hw/rtc/Makefile.objs
> +++ b/hw/rtc/Makefile.objs
> @@ -1 +1,2 @@
>  common-obj-$(CONFIG_PL031) += pl031.o
> +obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
> diff --git a/hw/timer/mc146818rtc.c b/hw/rtc/mc146818rtc.c
> similarity index 99%
> rename from hw/timer/mc146818rtc.c
> rename to hw/rtc/mc146818rtc.c
> index 6cb378751b..ced15f764f 100644
> --- a/hw/timer/mc146818rtc.c
> +++ b/hw/rtc/mc146818rtc.c
> @@ -34,7 +34,7 @@
>  #include "sysemu/replay.h"
>  #include "sysemu/reset.h"
>  #include "sysemu/runstate.h"
> -#include "hw/timer/mc146818rtc.h"
> +#include "hw/rtc/mc146818rtc.h"
>  #include "migration/vmstate.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-misc-target.h"
> diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
> index 27c5dce09e..af415c8ef8 100644
> --- a/hw/timer/Kconfig
> +++ b/hw/timer/Kconfig
> @@ -35,9 +35,6 @@ config ALTERA_TIMER
>      bool
>      select PTIMER
>  
> -config MC146818RTC
> -    bool
> -
>  config ALLWINNER_A10_PIT
>      bool
>      select PTIMER
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index 9f64f6e11e..b0159189cf 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -35,8 +35,6 @@ common-obj-$(CONFIG_SH4) += sh_timer.o
>  common-obj-$(CONFIG_DIGIC) += digic-timer.o
>  common-obj-$(CONFIG_MIPS_CPS) += mips_gictimer.o
>  
> -obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
> -
>  common-obj-$(CONFIG_ALLWINNER_A10_PIT) += allwinner-a10-pit.o
>  
>  common-obj-$(CONFIG_STM32F2XX_TIMER) += stm32f2xx_timer.o
> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index 1ddae4e7d7..02bf8a8ce8 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -33,7 +33,7 @@
>  #include "qemu/timer.h"
>  #include "hw/timer/hpet.h"
>  #include "hw/sysbus.h"
> -#include "hw/timer/mc146818rtc.h"
> +#include "hw/rtc/mc146818rtc.h"
>  #include "migration/vmstate.h"
>  #include "hw/timer/i8254.h"
>  
> diff --git a/include/hw/timer/mc146818rtc.h b/include/hw/rtc/mc146818rtc.h
> similarity index 58%
> rename from include/hw/timer/mc146818rtc.h
> rename to include/hw/rtc/mc146818rtc.h
> index fe6ed63f71..2e9331637a 100644
> --- a/include/hw/timer/mc146818rtc.h
> +++ b/include/hw/rtc/mc146818rtc.h
> @@ -1,8 +1,16 @@
> -#ifndef MC146818RTC_H
> -#define MC146818RTC_H
> +/*
> + * QEMU MC146818 RTC emulation
> + *
> + * Copyright (c) 2003-2004 Fabrice Bellard
> + *
> + * SPDX-License-Identifier: MIT
> + */
> +
> +#ifndef HW_RTC_MC146818RTC_H
> +#define HW_RTC_MC146818RTC_H
>  
>  #include "hw/isa/isa.h"
> -#include "hw/timer/mc146818rtc_regs.h"
> +#include "hw/rtc/mc146818rtc_regs.h"
>  
>  #define TYPE_MC146818_RTC "mc146818rtc"
>  
> diff --git a/include/hw/timer/mc146818rtc_regs.h b/include/hw/rtc/mc146818rtc_regs.h
> similarity index 96%
> rename from include/hw/timer/mc146818rtc_regs.h
> rename to include/hw/rtc/mc146818rtc_regs.h
> index bfbb57e570..dd6c09e2fc 100644
> --- a/include/hw/timer/mc146818rtc_regs.h
> +++ b/include/hw/rtc/mc146818rtc_regs.h
> @@ -22,10 +22,11 @@
>   * THE SOFTWARE.
>   */
>  
> -#ifndef MC146818RTC_REGS_H
> -#define MC146818RTC_REGS_H
> +#ifndef HW_RTC_MC146818RTC_REGS_H
> +#define HW_RTC_MC146818RTC_REGS_H
>  
>  #include "qemu/timer.h"
> +#include "qemu/host-utils.h"
>  
>  #define RTC_ISA_IRQ 8
>  
> diff --git a/tests/rtc-test.c b/tests/rtc-test.c
> index 6309b0ef6c..79a4ff1ed6 100644
> --- a/tests/rtc-test.c
> +++ b/tests/rtc-test.c
> @@ -15,7 +15,7 @@
>  
>  #include "libqtest-single.h"
>  #include "qemu/timer.h"
> -#include "hw/timer/mc146818rtc_regs.h"
> +#include "hw/rtc/mc146818rtc_regs.h"
>  
>  #define UIP_HOLD_LENGTH           (8 * NANOSECONDS_PER_SECOND / 32768)
>  
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

