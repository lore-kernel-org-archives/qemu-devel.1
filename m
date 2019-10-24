Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E26CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:24:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E68C620684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68C620684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNhmm-0006dr-F1
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 14:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48563)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNhk8-0002n2-Qj
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:21:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNhk6-0003Mn-O5
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:21:52 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:55083)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNhk6-0003Mi-EU; Thu, 24 Oct 2019 14:21:50 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MOz8O-1ie9EI2LL2-00PM9a; Thu, 24 Oct 2019 20:21:26 +0200
Subject: Re: [PATCH v2 04/14] hw: Move M48T59 device from hw/timer/ to hw/rtc/
 subdirectory
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191003230404.19384-1-philmd@redhat.com>
 <20191003230404.19384-5-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <da92db2a-a3d3-6f6c-6aa9-6daca6b0bac1@vivier.eu>
Date: Thu, 24 Oct 2019 20:21:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191003230404.19384-5-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:97UoPm2iZUu6EOphR8iV9gY6jq43XoTRY2qFSBJeu1+EUUHDt1r
 nJAgAebijA3G7APyOcYoHUv86NMbU4XPCVUPG3Y9povatOxiLs9kebxnLlsTDUVhKI5yQ+Z
 dQxrXwZWJ0SunTwBk64Iwr7bz2tPx0XlLXS983+Nz8YgPN7d5XIpXCsYBMpCQkF+LVfQ/br
 DwRQ6J2IuBMeiixcnXryQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NA9syaalibM=:HPzNe0gfsS56tu90xgbblB
 LCCJgUvUfFfp4+RdU/lQyRgqsCURnCT5IM0rEw2OPcDp7jgF9Uj8lgTqAvQ1lxOZPscCi8ixY
 dLDmkcYi0wEVsG3APn7gWu6iyuT2emm+iU47OBfxqfH1FHo3Ze+1ER7WRmMBfsalOIDuNAN4W
 aQIbxahpEbBwh/bgRM55+PDNPw2z/cIue8yFcfVPc1PQfAEzek91+m/M0FHXX+UqFvEtIjpuR
 B3Xt4hkkNRbL9wADSMfKZ4VsmAP1PciCJvfJtO5X4Sof51zyVh2E7Ccog2AV+tZDJL6WNiZIS
 Idv5W+nqpRrRJMDUJeN8mTGkzvxHOnIuJDuu2MRvD++Gu99OC02XTRXEVGIihzzMimNzc/oBD
 cgCPi8fSm4EmGVLLXLrd/Cr7UgecmahnwbFDIqGZFRybi4BLeKHRC+ia1FSpT/6iSoRF0L0O4
 VFUtGxjafDFqQ6Hea95QUxVjX3A+isA8jx54eHE+F8Snie5gfxxplnV3hNWVMEO8x7ofSC9iX
 C16kB7YP76PH7kQ2xs/96U+cV57vutXr923Pctccwdlz1AuTapC2ti3U3hMUR6hr+6jslSS9R
 W8O6+oJIj5+seJSXQc4ItbWuExn0d+3olvdtVf1/6xkjLUsbvtIy7QHF91izg4ubVEW/iAZtM
 tWK31qwr8kSxGj+JjJbQCN9C9kRpeUKDHXyPwPFW+zOEbRB02aRPzsCRgPqd6fy1pSunoaShB
 AlAqiOiulHxa9LVurkSRhJb2vuqqUz21iUByGevX7HJT3jmkkPo7i2F0Ph75G5b7MSprCTCVY
 R1PoQaQiMkKGgdgXCeutWk7dUv52l0hhpjIEKvNz504DIwnrRGq3F6lG8YVMYbz4eTE1CPqNA
 CrU+3Rde7N1aTrDnwUq+OH64kU/7iTFSDtPAXuAIg=
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
> The M48T59 is a Real Time Clock, not a timer.
> Move it under the hw/rtc/ subdirectory.
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v2: delete include/hw/timer/m48t59.h (dgibson)
> ---
>  MAINTAINERS                         |  4 +-
>  hw/ppc/ppc405_boards.c              |  2 +-
>  hw/ppc/prep.c                       |  2 +-
>  hw/rtc/Kconfig                      |  3 ++
>  hw/rtc/Makefile.objs                |  4 ++
>  hw/{timer => rtc}/m48t59-internal.h |  0
>  hw/{timer => rtc}/m48t59-isa.c      |  4 +-
>  hw/{timer => rtc}/m48t59.c          |  2 +-
>  hw/sparc/sun4m.c                    |  2 +-
>  hw/sparc64/sun4u.c                  |  2 +-
>  hw/timer/Kconfig                    |  3 --
>  hw/timer/Makefile.objs              |  4 --
>  include/hw/rtc/m48t59.h             | 57 +++++++++++++++++++++++++++++
>  include/hw/timer/m48t59.h           | 32 ----------------
>  14 files changed, 73 insertions(+), 48 deletions(-)
>  rename hw/{timer => rtc}/m48t59-internal.h (100%)
>  rename hw/{timer => rtc}/m48t59-isa.c (98%)
>  rename hw/{timer => rtc}/m48t59.c (99%)
>  create mode 100644 include/hw/rtc/m48t59.h
>  delete mode 100644 include/hw/timer/m48t59.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e3255cdbf2..5d85424a33 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1064,9 +1064,9 @@ F: hw/pci-host/prep.[hc]
>  F: hw/isa/i82378.c
>  F: hw/isa/pc87312.c
>  F: hw/dma/i82374.c
> -F: hw/timer/m48t59-isa.c
> +F: hw/rtc/m48t59-isa.c
>  F: include/hw/isa/pc87312.h
> -F: include/hw/timer/m48t59.h
> +F: include/hw/rtc/m48t59.h
>  F: pc-bios/ppc_rom.bin
>  
>  sPAPR
> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index 388cae0b43..1f721feed6 100644
> --- a/hw/ppc/ppc405_boards.c
> +++ b/hw/ppc/ppc405_boards.c
> @@ -29,7 +29,7 @@
>  #include "cpu.h"
>  #include "hw/ppc/ppc.h"
>  #include "ppc405.h"
> -#include "hw/timer/m48t59.h"
> +#include "hw/rtc/m48t59.h"
>  #include "hw/block/flash.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/qtest.h"
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 3a51536e1a..862345c2ac 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -25,7 +25,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "cpu.h"
> -#include "hw/timer/m48t59.h"
> +#include "hw/rtc/m48t59.h"
>  #include "hw/char/serial.h"
>  #include "hw/block/fdc.h"
>  #include "net/net.h"
> diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
> index 7ffd702268..159c233517 100644
> --- a/hw/rtc/Kconfig
> +++ b/hw/rtc/Kconfig
> @@ -1,3 +1,6 @@
> +config M48T59
> +    bool
> +
>  config PL031
>      bool
>  
> diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
> index 3cac0d5a63..c87f81405e 100644
> --- a/hw/rtc/Makefile.objs
> +++ b/hw/rtc/Makefile.objs
> @@ -1,2 +1,6 @@
> +common-obj-$(CONFIG_M48T59) += m48t59.o
> +ifeq ($(CONFIG_ISA_BUS),y)
> +common-obj-$(CONFIG_M48T59) += m48t59-isa.o
> +endif
>  common-obj-$(CONFIG_PL031) += pl031.o
>  obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
> diff --git a/hw/timer/m48t59-internal.h b/hw/rtc/m48t59-internal.h
> similarity index 100%
> rename from hw/timer/m48t59-internal.h
> rename to hw/rtc/m48t59-internal.h
> diff --git a/hw/timer/m48t59-isa.c b/hw/rtc/m48t59-isa.c
> similarity index 98%
> rename from hw/timer/m48t59-isa.c
> rename to hw/rtc/m48t59-isa.c
> index 5e5432abfd..7fde854c0f 100644
> --- a/hw/timer/m48t59-isa.c
> +++ b/hw/rtc/m48t59-isa.c
> @@ -1,5 +1,5 @@
>  /*
> - * QEMU M48T59 and M48T08 NVRAM emulation (ISA bus interface
> + * QEMU M48T59 and M48T08 NVRAM emulation (ISA bus interface)
>   *
>   * Copyright (c) 2003-2005, 2007 Jocelyn Mayer
>   * Copyright (c) 2013 Hervé Poussineau
> @@ -26,7 +26,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/isa/isa.h"
>  #include "hw/qdev-properties.h"
> -#include "hw/timer/m48t59.h"
> +#include "hw/rtc/m48t59.h"
>  #include "m48t59-internal.h"
>  #include "qemu/module.h"
>  
> diff --git a/hw/timer/m48t59.c b/hw/rtc/m48t59.c
> similarity index 99%
> rename from hw/timer/m48t59.c
> rename to hw/rtc/m48t59.c
> index a9fc2f981a..fc592b9fb1 100644
> --- a/hw/timer/m48t59.c
> +++ b/hw/rtc/m48t59.c
> @@ -27,7 +27,7 @@
>  #include "qemu-common.h"
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
> -#include "hw/timer/m48t59.h"
> +#include "hw/rtc/m48t59.h"
>  #include "qemu/timer.h"
>  #include "sysemu/runstate.h"
>  #include "sysemu/sysemu.h"
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 6c5a17a020..2aaa5bf1ae 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -31,7 +31,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/timer.h"
>  #include "hw/sparc/sun4m_iommu.h"
> -#include "hw/timer/m48t59.h"
> +#include "hw/rtc/m48t59.h"
>  #include "migration/vmstate.h"
>  #include "hw/sparc/sparc32_dma.h"
>  #include "hw/block/fdc.h"
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 1ded2a4c9a..955082773b 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -36,7 +36,7 @@
>  #include "hw/pci-host/sabre.h"
>  #include "hw/char/serial.h"
>  #include "hw/char/parallel.h"
> -#include "hw/timer/m48t59.h"
> +#include "hw/rtc/m48t59.h"
>  #include "migration/vmstate.h"
>  #include "hw/input/i8042.h"
>  #include "hw/block/fdc.h"
> diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
> index af415c8ef8..a57e9b59fc 100644
> --- a/hw/timer/Kconfig
> +++ b/hw/timer/Kconfig
> @@ -24,9 +24,6 @@ config M41T80
>      bool
>      depends on I2C
>  
> -config M48T59
> -    bool
> -
>  config TWL92230
>      bool
>      depends on I2C
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index b0159189cf..fe2d1fbc40 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -7,10 +7,6 @@ common-obj-$(CONFIG_DS1338) += ds1338.o
>  common-obj-$(CONFIG_HPET) += hpet.o
>  common-obj-$(CONFIG_I8254) += i8254_common.o i8254.o
>  common-obj-$(CONFIG_M41T80) += m41t80.o
> -common-obj-$(CONFIG_M48T59) += m48t59.o
> -ifeq ($(CONFIG_ISA_BUS),y)
> -common-obj-$(CONFIG_M48T59) += m48t59-isa.o
> -endif
>  common-obj-$(CONFIG_PUV3) += puv3_ost.o
>  common-obj-$(CONFIG_TWL92230) += twl92230.o
>  common-obj-$(CONFIG_XILINX) += xilinx_timer.o
> diff --git a/include/hw/rtc/m48t59.h b/include/hw/rtc/m48t59.h
> new file mode 100644
> index 0000000000..e7ea4e8761
> --- /dev/null
> +++ b/include/hw/rtc/m48t59.h
> @@ -0,0 +1,57 @@
> +/*
> + * QEMU M48T59 and M48T08 NVRAM emulation
> + *
> + * Copyright (c) 2003-2005, 2007 Jocelyn Mayer
> + * Copyright (c) 2013 Hervé Poussineau
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef HW_RTC_M48T59_H
> +#define HW_RTC_M48T59_H
> +
> +#include "exec/hwaddr.h"
> +#include "qom/object.h"
> +
> +#define TYPE_NVRAM "nvram"
> +
> +#define NVRAM_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(NvramClass, (klass), TYPE_NVRAM)
> +#define NVRAM_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(NvramClass, (obj), TYPE_NVRAM)
> +#define NVRAM(obj) \
> +    INTERFACE_CHECK(Nvram, (obj), TYPE_NVRAM)
> +
> +typedef struct Nvram Nvram;
> +
> +typedef struct NvramClass {
> +    InterfaceClass parent;
> +
> +    uint32_t (*read)(Nvram *obj, uint32_t addr);
> +    void (*write)(Nvram *obj, uint32_t addr, uint32_t val);
> +    void (*toggle_lock)(Nvram *obj, int lock);
> +} NvramClass;
> +
> +Nvram *m48t59_init_isa(ISABus *bus, uint32_t io_base, uint16_t size,
> +                       int base_year, int type);
> +Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
> +                   uint32_t io_base, uint16_t size, int base_year,
> +                   int type);
> +
> +#endif /* HW_M48T59_H */
> diff --git a/include/hw/timer/m48t59.h b/include/hw/timer/m48t59.h
> deleted file mode 100644
> index f74854c026..0000000000
> --- a/include/hw/timer/m48t59.h
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -#ifndef HW_M48T59_H
> -#define HW_M48T59_H
> -
> -#include "exec/hwaddr.h"
> -#include "qom/object.h"
> -
> -#define TYPE_NVRAM "nvram"
> -
> -#define NVRAM_CLASS(klass) \
> -    OBJECT_CLASS_CHECK(NvramClass, (klass), TYPE_NVRAM)
> -#define NVRAM_GET_CLASS(obj) \
> -    OBJECT_GET_CLASS(NvramClass, (obj), TYPE_NVRAM)
> -#define NVRAM(obj) \
> -    INTERFACE_CHECK(Nvram, (obj), TYPE_NVRAM)
> -
> -typedef struct Nvram Nvram;
> -
> -typedef struct NvramClass {
> -    InterfaceClass parent;
> -
> -    uint32_t (*read)(Nvram *obj, uint32_t addr);
> -    void (*write)(Nvram *obj, uint32_t addr, uint32_t val);
> -    void (*toggle_lock)(Nvram *obj, int lock);
> -} NvramClass;
> -
> -Nvram *m48t59_init_isa(ISABus *bus, uint32_t io_base, uint16_t size,
> -                       int base_year, int type);
> -Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
> -                   uint32_t io_base, uint16_t size, int base_year,
> -                   int type);
> -
> -#endif /* HW_M48T59_H */
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

