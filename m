Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A622C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 10:55:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E322624125
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 10:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E322624125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ig54w-0005bm-5K
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 05:55:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ig54C-0005By-HL
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 05:54:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ig54A-0007J0-6G
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 05:54:32 -0500
Received: from mail.ilande.co.uk ([46.43.2.167]:48444
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ig549-0007Hi-O6
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 05:54:30 -0500
Received: from host86-191-82-191.range86-191.btcentralplus.com
 ([86.191.82.191] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ig54x-0003ij-0r; Sat, 14 Dec 2019 10:55:22 +0000
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20191212200142.15688-1-laurent@vivier.eu>
 <20191212200142.15688-3-laurent@vivier.eu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <7fd2a28c-8457-cfcf-e366-7e4e6a0709b3@ilande.co.uk>
Date: Sat, 14 Dec 2019 10:54:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212200142.15688-3-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.191.82.191
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 2/3] q800: add djMEMC memory controller
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.43.2.167
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/2019 20:01, Laurent Vivier wrote:

> Current implementation is based on GLUE, an early implementation
> of the memory controller found in Macintosh II series.
> 
> Quadra 800 uses in fact djMEMC:
> 
> The djMEMC is an Apple custom integrated circuit chip that performs a
> variety of functions (RAM management, clock generation, ...).
> It receives interrupt requests from various devices, assign priority to
> each, and asserts one or more interrupt line to the CPU.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  MAINTAINERS              |   2 +
>  hw/m68k/Kconfig          |   1 +
>  hw/m68k/q800.c           |  61 ++++----------
>  hw/misc/Kconfig          |   3 +
>  hw/misc/Makefile.objs    |   1 +
>  hw/misc/djmemc.c         | 176 +++++++++++++++++++++++++++++++++++++++
>  hw/misc/trace-events     |   4 +
>  include/hw/misc/djmemc.h |  34 ++++++++
>  8 files changed, 237 insertions(+), 45 deletions(-)
>  create mode 100644 hw/misc/djmemc.c
>  create mode 100644 include/hw/misc/djmemc.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5e5e3e52d6..07224a2fa2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -925,11 +925,13 @@ F: hw/misc/mac_via.c
>  F: hw/nubus/*
>  F: hw/display/macfb.c
>  F: hw/block/swim.c
> +F: hw/misc/djmemc.c
>  F: hw/m68k/bootinfo.h
>  F: include/hw/misc/mac_via.h
>  F: include/hw/nubus/*
>  F: include/hw/display/macfb.h
>  F: include/hw/block/swim.h
> +F: include/hw/misc/djmemc.c
>  
>  MicroBlaze Machines
>  -------------------
> diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
> index c757e7dfa4..bdc43a798a 100644
> --- a/hw/m68k/Kconfig
> +++ b/hw/m68k/Kconfig
> @@ -22,3 +22,4 @@ config Q800
>      select ESCC
>      select ESP
>      select DP8393X
> +    select DJMEMC
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index ef0014f4c4..9ee0cb1141 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -46,6 +46,7 @@
>  #include "sysemu/qtest.h"
>  #include "sysemu/runstate.h"
>  #include "sysemu/reset.h"
> +#include "hw/misc/djmemc.h"
>  
>  #define MACROM_ADDR     0x40000000
>  #define MACROM_SIZE     0x00100000
> @@ -68,6 +69,7 @@
>  #define SONIC_PROM_BASE       (IO_BASE + 0x08000)
>  #define SONIC_BASE            (IO_BASE + 0x0a000)
>  #define SCC_BASE              (IO_BASE + 0x0c000)
> +#define DJMEMC_BASE           (IO_BASE + 0x0e000)
>  #define ESP_BASE              (IO_BASE + 0x10000)
>  #define ESP_PDMA              (IO_BASE + 0x10100)
>  #define ASC_BASE              (IO_BASE + 0x14000)
> @@ -85,39 +87,6 @@
>  
>  #define MAC_CLOCK  3686418
>  
> -/*
> - * The GLUE (General Logic Unit) is an Apple custom integrated circuit chip
> - * that performs a variety of functions (RAM management, clock generation, ...).
> - * The GLUE chip receives interrupt requests from various devices,
> - * assign priority to each, and asserts one or more interrupt line to the
> - * CPU.
> - */
> -
> -typedef struct {
> -    M68kCPU *cpu;
> -    uint8_t ipr;
> -} GLUEState;
> -
> -static void GLUE_set_irq(void *opaque, int irq, int level)
> -{
> -    GLUEState *s = opaque;
> -    int i;
> -
> -    if (level) {
> -        s->ipr |= 1 << irq;
> -    } else {
> -        s->ipr &= ~(1 << irq);
> -    }
> -
> -    for (i = 7; i >= 0; i--) {
> -        if ((s->ipr >> i) & 1) {
> -            m68k_set_irq_level(s->cpu, i + 1, i + 25);
> -            return;
> -        }
> -    }
> -    m68k_set_irq_level(s->cpu, 0, 0);
> -}
> -
>  static void main_cpu_reset(void *opaque)
>  {
>      M68kCPU *cpu = opaque;
> @@ -149,6 +118,7 @@ static void q800_init(MachineState *machine)
>      const char *kernel_cmdline = machine->kernel_cmdline;
>      hwaddr parameters_base;
>      CPUState *cs;
> +    DeviceState *djmemc_dev;
>      DeviceState *dev;
>      DeviceState *via_dev;
>      SysBusESPState *sysbus_esp;
> @@ -156,8 +126,6 @@ static void q800_init(MachineState *machine)
>      SysBusDevice *sysbus;
>      BusState *adb_bus;
>      NubusBus *nubus;
> -    GLUEState *irq;
> -    qemu_irq *pic;
>  
>      linux_boot = (kernel_filename != NULL);
>  
> @@ -191,11 +159,13 @@ static void q800_init(MachineState *machine)
>          g_free(name);
>      }
>  
> -    /* IRQ Glue */
> +    /* djMEMC memory and interrupt controller */
>  
> -    irq = g_new0(GLUEState, 1);
> -    irq->cpu = cpu;
> -    pic = qemu_allocate_irqs(GLUE_set_irq, irq, 8);
> +    djmemc_dev = qdev_create(NULL, TYPE_DJMEMC);
> +    object_property_set_link(OBJECT(djmemc_dev), OBJECT(cpu), "cpu",
> +                             &error_abort);
> +    qdev_init_nofail(djmemc_dev);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(djmemc_dev), 0, DJMEMC_BASE);
>  
>      /* VIA */
>  
> @@ -203,9 +173,10 @@ static void q800_init(MachineState *machine)
>      qdev_init_nofail(via_dev);
>      sysbus = SYS_BUS_DEVICE(via_dev);
>      sysbus_mmio_map(sysbus, 0, VIA_BASE);
> -    qdev_connect_gpio_out_named(DEVICE(sysbus), "irq", 0, pic[0]);
> -    qdev_connect_gpio_out_named(DEVICE(sysbus), "irq", 1, pic[1]);
> -
> +    qdev_connect_gpio_out_named(DEVICE(sysbus), "irq", 0,
> +                                qdev_get_gpio_in(djmemc_dev, 0));
> +    qdev_connect_gpio_out_named(DEVICE(sysbus),
> +                                "irq", 1, qdev_get_gpio_in(djmemc_dev, 1));
>  
>      adb_bus = qdev_get_child_bus(via_dev, "adb.0");
>      dev = qdev_create(adb_bus, TYPE_ADB_KEYBOARD);
> @@ -244,7 +215,7 @@ static void q800_init(MachineState *machine)
>      sysbus = SYS_BUS_DEVICE(dev);
>      sysbus_mmio_map(sysbus, 0, SONIC_BASE);
>      sysbus_mmio_map(sysbus, 1, SONIC_PROM_BASE);
> -    sysbus_connect_irq(sysbus, 0, pic[2]);
> +    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(djmemc_dev, 2));
>  
>      /* SCC */
>  
> @@ -259,8 +230,8 @@ static void q800_init(MachineState *machine)
>      qdev_prop_set_uint32(dev, "chnAtype", 0);
>      qdev_init_nofail(dev);
>      sysbus = SYS_BUS_DEVICE(dev);
> -    sysbus_connect_irq(sysbus, 0, pic[3]);
> -    sysbus_connect_irq(sysbus, 1, pic[3]);
> +    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(djmemc_dev, 3));
> +    sysbus_connect_irq(sysbus, 1, qdev_get_gpio_in(djmemc_dev, 3));
>      sysbus_mmio_map(sysbus, 0, SCC_BASE);
>  
>      /* SCSI */
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 2164646553..4c68d20c18 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -125,4 +125,7 @@ config MAC_VIA
>      select MOS6522
>      select ADB
>  
> +config DJMEMC
> +    bool
> +
>  source macio/Kconfig
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index ba898a5781..598e46d7db 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -20,6 +20,7 @@ common-obj-$(CONFIG_ARM11SCU) += arm11scu.o
>  
>  # Mac devices
>  common-obj-$(CONFIG_MOS6522) += mos6522.o
> +obj-$(CONFIG_DJMEMC) += djmemc.o
>  
>  # PKUnity SoC devices
>  common-obj-$(CONFIG_PUV3) += puv3_pm.o
> diff --git a/hw/misc/djmemc.c b/hw/misc/djmemc.c
> new file mode 100644
> index 0000000000..b494e82a60
> --- /dev/null
> +++ b/hw/misc/djmemc.c
> @@ -0,0 +1,176 @@
> +/*
> + * djMEMC, macintosh memory and interrupt controller
> + * (Quadra 610/650/800 & Centris 610/650)
> + *
> + *    https://mac68k.info/wiki/display/mac68k/djMEMC+Information
> + *
> + * The djMEMC is an Apple custom integrated circuit chip that performs a
> + * variety of functions (RAM management, clock generation, ...).
> + * It receives interrupt requests from various devices, assign priority to
> + * each, and asserts one or more interrupt line to the CPU.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "migration/vmstate.h"
> +#include "hw/misc/djmemc.h"
> +#include "hw/qdev-properties.h"
> +#include "trace.h"
> +
> +#define DJMEMC_SIZE       0x2000
> +
> +#define InterleaveConf    0
> +#define Bank0Conf         1
> +#define Bank1Conf         2
> +#define Bank2Conf         3
> +#define Bank3Conf         4
> +#define Bank4Conf         5
> +#define Bank5Conf         6
> +#define Bank6Conf         7
> +#define Bank7Conf         8
> +#define Bank8Conf         9
> +#define Bank9Conf         10
> +#define MemTop            11
> +#define Config            12
> +#define Refresh           13
> +
> +static const VMStateDescription vmstate_djMEMC = {
> +    .name = "djMEMC",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields      = (VMStateField[]) {
> +        VMSTATE_UINT32(interleave, DjMEMCState),
> +        VMSTATE_UINT32_ARRAY(bank, DjMEMCState, DjMEMCMaxBanks),
> +        VMSTATE_UINT32(top, DjMEMCState),
> +        VMSTATE_UINT32(config, DjMEMCState),
> +        VMSTATE_UINT32(refresh_rate, DjMEMCState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static uint64_t djMEMC_read(void *opaque, hwaddr addr,
> +                              unsigned size)
> +{
> +    DjMEMCState *s = opaque;
> +    uint64_t value = 0;
> +
> +    switch (addr >> 2) {
> +    case InterleaveConf:
> +        value = s->interleave;
> +    case Bank0Conf...Bank9Conf:
> +        value = s->bank[(addr >> 2) - Bank0Conf];
> +    case MemTop:
> +        value = s->top;
> +    case Config:
> +        value = s->config;
> +    case Refresh:
> +        value = s->refresh_rate;
> +    }
> +    trace_djMEMC_read((int)(addr >> 2), size, value);

Is there any chance that we match existing QEMU style here e.g. all capitals for
constants and all lower case for trace events? The capitalisation of the djMEMC has
caught me out a few times...

> +    return value;
> +}
> +
> +static void djMEMC_write(void *opaque, hwaddr addr, uint64_t value,
> +                         unsigned size)
> +{
> +    DjMEMCState *s = opaque;
> +    trace_djMEMC_write((int)(addr >> 2), size, value);
> +
> +    switch (addr >> 2) {
> +    case InterleaveConf:
> +        s->interleave = value;
> +    case Bank0Conf...Bank9Conf:
> +        s->bank[(addr >> 2) - Bank0Conf] = value;
> +    case MemTop:
> +        s->top = value;
> +    case Config:
> +        s->config = value;
> +    case Refresh:
> +        s->refresh_rate = value;
> +    }
> +}
> +
> +static const MemoryRegionOps djMEMC_mmio_ops = {
> +    .read = djMEMC_read,
> +    .write = djMEMC_write,
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};
> +
> +static void djMEMC_set_irq(void *opaque, int irq, int level)
> +{
> +    DjMEMCState *s = opaque;
> +    int i;
> +
> +
> +    if (level) {
> +        s->ipr |= 1 << irq;
> +    } else {
> +        s->ipr &= ~(1 << irq);
> +    }
> +
> +    for (i = 7; i >= 0; i--) {
> +        if ((s->ipr >> i) & 1) {
> +            m68k_set_irq_level(s->cpu, i + 1, i + 25);
> +            return;
> +        }
> +    }
> +    m68k_set_irq_level(s->cpu, 0, 0);
> +}
> +
> +static void djMEMC_init(Object *obj)
> +{
> +    DjMEMCState *s = DJMEMC(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +
> +    memory_region_init_io(&s->mem_regs, NULL, &djMEMC_mmio_ops, s, "djMEMC",
> +                          DJMEMC_SIZE);
> +    sysbus_init_mmio(sbd, &s->mem_regs);
> +
> +    qdev_init_gpio_in(DEVICE(obj), djMEMC_set_irq, 8);
> +    object_property_add_link(obj, "cpu", TYPE_M68K_CPU,
> +                             (Object **) &s->cpu,
> +                             qdev_prop_allow_set_link_before_realize,
> +                             0, NULL);
> +}
> +
> +static void djMEMC_reset(DeviceState *d)
> +{
> +    DjMEMCState *s = DJMEMC(d);
> +    int i;
> +
> +    s->interleave = 0;
> +    s->top = 0;
> +    s->refresh_rate = 0;
> +    s->config = 0;
> +
> +    for (i = 0; i < DjMEMCMaxBanks; i++) {
> +        s->bank[i] = 0;
> +    }
> +}
> +
> +static void djMEMC_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    dc->reset = djMEMC_reset;
> +    dc->vmsd = &vmstate_djMEMC;
> +}
> +
> +static TypeInfo djMEMC_info = {
> +    .name          = TYPE_DJMEMC,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(DjMEMCState),
> +    .instance_init = djMEMC_init,
> +    .class_init    = djMEMC_class_init,
> +};
> +
> +static void djMEMC_register_types(void)
> +{
> +    type_register_static(&djMEMC_info);
> +}
> +
> +type_init(djMEMC_register_types)
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 1deb1d08c1..c9bcdd4a54 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -149,3 +149,7 @@ bcm2835_mbox_write(unsigned int size, uint64_t addr, uint64_t value) "mbox write
>  bcm2835_mbox_read(unsigned int size, uint64_t addr, uint64_t value) "mbox read sz:%u addr:0x%"PRIx64" data:0x%"PRIx64
>  bcm2835_mbox_irq(unsigned level) "mbox irq:ARM level:%u"
>  bcm2835_mbox_property(uint32_t tag, uint32_t bufsize, size_t resplen) "mbox property tag:0x%08x in_sz:%u out_sz:%zu"
> +
> +# djmemc.c
> +djMEMC_read(int reg, unsigned size, uint64_t value) "reg=%d size=%u value=0x%"PRIx64
> +djMEMC_write(int reg, unsigned size, uint64_t value) "reg=%d size=%u value=0x%"PRIx64
> diff --git a/include/hw/misc/djmemc.h b/include/hw/misc/djmemc.h
> new file mode 100644
> index 0000000000..0f29ac1cf3
> --- /dev/null
> +++ b/include/hw/misc/djmemc.h
> @@ -0,0 +1,34 @@
> +/*
> + * djMEMC, macintosh memory and interrupt controller
> + * (Quadra 610/650/800 & Centris 610/650)
> + */
> +
> +#ifndef HW_MISC_DJMEMC_H
> +#define HW_MISC_DJMEMC_H
> +
> +#include "hw/sysbus.h"
> +#include "cpu.h"
> +
> +#define DjMEMCMaxBanks    10
> +
> +typedef struct DjMEMCState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mem_regs;
> +
> +    /* Memory controller */
> +    uint32_t interleave;
> +    uint32_t bank[DjMEMCMaxBanks];
> +    uint32_t top;
> +    uint32_t config;
> +    uint32_t refresh_rate;
> +
> +    /* interrupt controller */
> +    M68kCPU *cpu;
> +    uint8_t ipr;
> +} DjMEMCState;
> +
> +#define TYPE_DJMEMC "djMEMC"
> +#define DJMEMC(obj) OBJECT_CHECK(DjMEMCState, (obj), TYPE_DJMEMC)
> +
> +#endif


ATB,

Mark.



