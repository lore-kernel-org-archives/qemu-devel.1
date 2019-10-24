Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DD6CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F7D320684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7D320684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNhgN-000585-QD
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 14:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNhTf-0003xE-TZ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:04:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNhTe-0006ps-1N
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:04:51 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:35183)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNhTa-0006mt-Cs; Thu, 24 Oct 2019 14:04:46 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MGi6k-1iB2192GOo-00Dl8G; Thu, 24 Oct 2019 20:04:21 +0200
Subject: Re: [PATCH v2 02/14] hw: Move PL031 device from hw/timer/ to hw/rtc/
 subdirectory
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191003230404.19384-1-philmd@redhat.com>
 <20191003230404.19384-3-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <846da787-27fc-fd4e-7316-5f709328b915@vivier.eu>
Date: Thu, 24 Oct 2019 20:04:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191003230404.19384-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:aQyfZV4iv1bCzQ6za5z/s1X+QmIc8IloB3uQX7cAZZrGnMzLtXk
 nJuOtzPDH9QjzAT61BTFKBwZYAfR25TgVcJvG6Psm0bCL5JCW/rV/HRzxSD7LTA22+nZUt0
 MxQ1ckEjyu4ScVo+WLecx8+gNKn+WKCnsaAOsvrrwcAJp2pSpSIxOR7xYfTSOtTT7VifkKp
 SD73XT/N3DYATzckPuPgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ks2uwLM8a/I=:CVQxLQpOAJXh2mNr+S0fqp
 rCEHejGXFUuLzw7dttief1veqSOm/EbJ0ZyYdRQLhkLu5KT/CBkE9wTlM2QBZdzFRDZs//rOW
 iXYQ+HcbFOUelpYwlZvnV65wa8V4jcGZLCIMTYOQTPqnlEew+0rd0TtEmeoB7ub/l4Xp17Gtf
 n8+R7Dx21eKvk1txWAe4+Ff2qX3aWTan/KH7uTSEdbRBZxVCGNDoN+/VcTZkdrwitYvHQZlvP
 kGSacZshkVTFzLPVUV+JCC4yTU2dU8i7V0TmQQmNElcvaIeX4tHK+Zq3osLmEYQIaEr97fTcz
 IxT9UvAKdiu2tCAEsEBrRvH1Wh0Pkf+3pWpRr9PDB6ML37n/swg2xaFLvK/cbdcLZBshMmDGb
 jN+y+C8q+Cs9AY5V8Q3Eedob32ROcC/gu+iVl3jnCuFJReoZhWgOEzRwYiiSih2oX10O6rZzH
 5ApQp0V136tBet3WQkdW1YSckTcQYYcb+DevyYroqBQOteIet6W8k4b0dEJ3LfuQI8Tg8T+U4
 dJz6DZEZ/0hCLLGH/QvZh63OiGRgvVhlCkcjMJOr9WrsiCa468G5XyRj5mEmPoGtZWARNLdka
 GiI43HaPbMsUA6bvWotlOa8eJDvo2dYzQw6WUtIpXIsvBuQerLBWhMLjidRenor7yjJ4D2iGe
 q98vk4qcxPXEAfvDzPCkBR6T11T8faa8FCITtKGOJIUagNNPA7Te0AAivcQAbD0y2QehMWnhI
 SPvZo390oOf8IXr3T5w4zZx1yHj0SIYsDU2eNZw12RC5mWgsUgoj+LLQMAw8A9GRoWyHZOwg6
 HWkGz0BPnTTDRgnJzueLnTP5833sqB92yB42wk6+zswFc804qHwb94P+ojaHcV7WmhMHanUUY
 fwWvUlKvi3OBGaMV8vH9k/5K9xaa6P3R2UfgyYwX0=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.133
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
> The PL031 is a Real Time Clock, not a timer.
> Move it under the hw/rtc/ subdirectory.
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  MAINTAINERS                       | 4 ++--
>  Makefile.objs                     | 1 +
>  hw/Kconfig                        | 1 +
>  hw/Makefile.objs                  | 1 +
>  hw/arm/musca.c                    | 2 +-
>  hw/rtc/Kconfig                    | 2 ++
>  hw/rtc/Makefile.objs              | 1 +
>  hw/{timer => rtc}/pl031.c         | 2 +-
>  hw/rtc/trace-events               | 8 ++++++++
>  hw/timer/Kconfig                  | 3 ---
>  hw/timer/Makefile.objs            | 1 -
>  hw/timer/trace-events             | 7 -------
>  include/hw/{timer => rtc}/pl031.h | 5 +++--
>  13 files changed, 21 insertions(+), 17 deletions(-)
>  create mode 100644 hw/rtc/Kconfig
>  create mode 100644 hw/rtc/Makefile.objs
>  rename hw/{timer => rtc}/pl031.c (99%)
>  create mode 100644 hw/rtc/trace-events
>  rename include/hw/{timer => rtc}/pl031.h (93%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 21264eae9c..92d27f1206 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -495,8 +495,8 @@ F: hw/intc/pl190.c
>  F: hw/sd/pl181.c
>  F: hw/ssi/pl022.c
>  F: include/hw/ssi/pl022.h
> -F: hw/timer/pl031.c
> -F: include/hw/timer/pl031.h
> +F: hw/rtc/pl031.c
> +F: include/hw/rtc/pl031.h
>  F: include/hw/arm/primecell.h
>  F: hw/timer/cmsdk-apb-timer.c
>  F: include/hw/timer/cmsdk-apb-timer.h
> diff --git a/Makefile.objs b/Makefile.objs
> index abcbd89654..11ba1a36bd 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -173,6 +173,7 @@ trace-events-subdirs += hw/pci-host
>  trace-events-subdirs += hw/ppc
>  trace-events-subdirs += hw/rdma
>  trace-events-subdirs += hw/rdma/vmw
> +trace-events-subdirs += hw/rtc
>  trace-events-subdirs += hw/s390x
>  trace-events-subdirs += hw/scsi
>  trace-events-subdirs += hw/sd
> diff --git a/hw/Kconfig b/hw/Kconfig
> index b45db3c813..4b53fee4d0 100644
> --- a/hw/Kconfig
> +++ b/hw/Kconfig
> @@ -27,6 +27,7 @@ source pci-host/Kconfig
>  source pcmcia/Kconfig
>  source pci/Kconfig
>  source rdma/Kconfig
> +source rtc/Kconfig
>  source scsi/Kconfig
>  source sd/Kconfig
>  source semihosting/Kconfig
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index ece6cc3755..fd9750e5f2 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -26,6 +26,7 @@ devices-dirs-y += nvram/
>  devices-dirs-y += pci/
>  devices-dirs-$(CONFIG_PCI) += pci-bridge/ pci-host/
>  devices-dirs-y += pcmcia/
> +devices-dirs-y += rtc/
>  devices-dirs-$(CONFIG_SCSI) += scsi/
>  devices-dirs-y += sd/
>  devices-dirs-y += ssi/
> diff --git a/hw/arm/musca.c b/hw/arm/musca.c
> index 68db4b5b38..ba99dd1941 100644
> --- a/hw/arm/musca.c
> +++ b/hw/arm/musca.c
> @@ -32,7 +32,7 @@
>  #include "hw/misc/tz-mpc.h"
>  #include "hw/misc/tz-ppc.h"
>  #include "hw/misc/unimp.h"
> -#include "hw/timer/pl031.h"
> +#include "hw/rtc/pl031.h"
>  
>  #define MUSCA_NUMIRQ_MAX 96
>  #define MUSCA_PPC_MAX 3
> diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
> new file mode 100644
> index 0000000000..8a4383bca9
> --- /dev/null
> +++ b/hw/rtc/Kconfig
> @@ -0,0 +1,2 @@
> +config PL031
> +    bool
> diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
> new file mode 100644
> index 0000000000..3e1eb42563
> --- /dev/null
> +++ b/hw/rtc/Makefile.objs
> @@ -0,0 +1 @@
> +common-obj-$(CONFIG_PL031) += pl031.o
> diff --git a/hw/timer/pl031.c b/hw/rtc/pl031.c
> similarity index 99%
> rename from hw/timer/pl031.c
> rename to hw/rtc/pl031.c
> index 2b3e261006..3a982752a2 100644
> --- a/hw/timer/pl031.c
> +++ b/hw/rtc/pl031.c
> @@ -13,7 +13,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
> -#include "hw/timer/pl031.h"
> +#include "hw/rtc/pl031.h"
>  #include "migration/vmstate.h"
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
> diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
> new file mode 100644
> index 0000000000..54c94ac557
> --- /dev/null
> +++ b/hw/rtc/trace-events
> @@ -0,0 +1,8 @@
> +# See docs/devel/tracing.txt for syntax documentation.
> +
> +# pl031.c
> +pl031_irq_state(int level) "irq state %d"
> +pl031_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
> +pl031_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
> +pl031_alarm_raised(void) "alarm raised"
> +pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
> diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
> index eefc95f35e..27c5dce09e 100644
> --- a/hw/timer/Kconfig
> +++ b/hw/timer/Kconfig
> @@ -27,9 +27,6 @@ config M41T80
>  config M48T59
>      bool
>  
> -config PL031
> -    bool
> -
>  config TWL92230
>      bool
>      depends on I2C
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index f407523aa4..9f64f6e11e 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -11,7 +11,6 @@ common-obj-$(CONFIG_M48T59) += m48t59.o
>  ifeq ($(CONFIG_ISA_BUS),y)
>  common-obj-$(CONFIG_M48T59) += m48t59-isa.o
>  endif
> -common-obj-$(CONFIG_PL031) += pl031.o
>  common-obj-$(CONFIG_PUV3) += puv3_ost.o
>  common-obj-$(CONFIG_TWL92230) += twl92230.o
>  common-obj-$(CONFIG_XILINX) += xilinx_timer.o
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index db02a9142c..6936fe8573 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -80,10 +80,3 @@ xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int min, int sec
>  # nrf51_timer.c
>  nrf51_timer_read(uint64_t addr, uint32_t value, unsigned size) "read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
>  nrf51_timer_write(uint64_t addr, uint32_t value, unsigned size) "write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
> -
> -# pl031.c
> -pl031_irq_state(int level) "irq state %d"
> -pl031_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
> -pl031_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
> -pl031_alarm_raised(void) "alarm raised"
> -pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
> diff --git a/include/hw/timer/pl031.h b/include/hw/rtc/pl031.h
> similarity index 93%
> rename from include/hw/timer/pl031.h
> rename to include/hw/rtc/pl031.h
> index 8c3f555ee2..e3cb1d646f 100644
> --- a/include/hw/timer/pl031.h
> +++ b/include/hw/rtc/pl031.h
> @@ -11,10 +11,11 @@
>   * GNU GPL, version 2 or (at your option) any later version.
>   */
>  
> -#ifndef HW_TIMER_PL031_H
> -#define HW_TIMER_PL031_H
> +#ifndef HW_RTC_PL031_H
> +#define HW_RTC_PL031_H
>  
>  #include "hw/sysbus.h"
> +#include "qemu/timer.h"
>  
>  #define TYPE_PL031 "pl031"
>  #define PL031(obj) OBJECT_CHECK(PL031State, (obj), TYPE_PL031)
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

