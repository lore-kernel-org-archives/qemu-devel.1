Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7A7C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 21:29:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5755206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 21:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IM0LTKr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5755206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9yZ4-0001BW-N6
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 17:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i9yXl-0008Rp-GV
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 17:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i9yXj-0003Ic-MG
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 17:28:21 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:36385)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i9yXj-0003Gm-9m; Mon, 16 Sep 2019 17:28:19 -0400
Received: by mail-lf1-x142.google.com with SMTP id x80so1141109lff.3;
 Mon, 16 Sep 2019 14:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4qZtmleJezGG3PChdkw3HeLNBo/kUyRix05dMeZu3bI=;
 b=IM0LTKr/cgK2bOY6T98WXxqWntSpKQX5eUohqEJeCbBTmPy46cXNFLoPT1rRDGBpsp
 zigGHd9GshysleTOpHBDmw0zSqW3E5h+mOEsgY2MUB96XVeM9QqobzIXLx4NCRiM3hOf
 Pz7akulFFe7X+bTOXGNDcZ8CmIrJe+gz5FS9eYPCVJV2JCjpps52o2FKlKRo3nSQmpuL
 BxlcL8FNTPKLrUC8HFppnYEQJwH9ErPzLoEm+S6RXxEg5eoKK3i6yPOuUtwlTTlD6Uuh
 jUcYdTJN9GyzU9d/Yr+0XthpYaH625J1j4W+9l2dlvpGzgsyITHeDiTvtWVdL/BAFyUa
 A7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4qZtmleJezGG3PChdkw3HeLNBo/kUyRix05dMeZu3bI=;
 b=s019agJIy92TlvbG99VHNCQ6P6REf+353atlpPacJJpY2Lec/jsDnn5tzUb9S3yHKD
 C7Wiafe85JCvpmvCVdbMBImZV1ZpjVzjUi2atHBF4pm0HIsd/dVeed9K3MiGpGMSROgk
 ejJoKb8XvsK0XyaK21ec0bYm8cP+xDO0mKigPxIhjq66kcNyDHl2PKa6WJNw+B5CFsdP
 NnG5sHoSsoPav5j/8oxHW2YT6WR806zq4JF8Ly4y4Em78ol8827yEt2N92Ard+PD0FvV
 l+jXguYggXQ/8SZzhVL79W8sUS3jEGMxzlDIbFxF/sAdX2eWvZuWH0H/xgcem7Nd5PA7
 wlrQ==
X-Gm-Message-State: APjAAAWMzzrc8LSalIyRRFqJA3Owk/rS/nUqufx//BtO+cAdBTaXyTK1
 berldoHMMWotpT/GfQENxtM15Jy8iaDknRuYv9c=
X-Google-Smtp-Source: APXvYqw8y0BjpiijhjJsrCwKajmx8o6EEIXIiFUidMq1dAELaev3lCKeO+cpEALLkFLFkn5+Q70kQsGDJk1bvfT3rGQ=
X-Received: by 2002:a19:f11c:: with SMTP id p28mr154647lfh.44.1568669297492;
 Mon, 16 Sep 2019 14:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190916154847.28936-1-philmd@redhat.com>
 <20190916154847.28936-5-philmd@redhat.com>
In-Reply-To: <20190916154847.28936-5-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 16 Sep 2019 14:23:46 -0700
Message-ID: <CAKmqyKP8woNbPhYU+Ve4P8xvfaP89Uw3Xe=i-aUxBdpTak8Xng@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [PATCH 04/13] hw: Move M48T59 device from
 hw/timer/ to hw/rtc/ subdirectory
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
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>, "open list:New World" <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 16, 2019 at 9:26 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> The M48T59 is a Real Time Clock, not a timer.
> Move it under the hw/rtc/ subdirectory.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  MAINTAINERS                         |  4 +-
>  hw/ppc/ppc405_boards.c              |  2 +-
>  hw/ppc/prep.c                       |  2 +-
>  hw/rtc/Kconfig                      |  3 ++
>  hw/rtc/Makefile.objs                |  4 ++
>  hw/{timer =3D> rtc}/m48t59-internal.h |  0
>  hw/{timer =3D> rtc}/m48t59-isa.c      |  4 +-
>  hw/{timer =3D> rtc}/m48t59.c          |  2 +-
>  hw/sparc/sun4m.c                    |  2 +-
>  hw/sparc64/sun4u.c                  |  2 +-
>  hw/timer/Kconfig                    |  3 --
>  hw/timer/Makefile.objs              |  4 --
>  include/hw/rtc/m48t59.h             | 57 +++++++++++++++++++++++++++++
>  13 files changed, 73 insertions(+), 16 deletions(-)
>  rename hw/{timer =3D> rtc}/m48t59-internal.h (100%)
>  rename hw/{timer =3D> rtc}/m48t59-isa.c (98%)
>  rename hw/{timer =3D> rtc}/m48t59.c (99%)
>  create mode 100644 include/hw/rtc/m48t59.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 481f2318cb..679b026fe0 100644
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
> +common-obj-$(CONFIG_M48T59) +=3D m48t59.o
> +ifeq ($(CONFIG_ISA_BUS),y)
> +common-obj-$(CONFIG_M48T59) +=3D m48t59-isa.o
> +endif
>  common-obj-$(CONFIG_PL031) +=3D pl031.o
>  obj-$(CONFIG_MC146818RTC) +=3D mc146818rtc.o
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
>   * Copyright (c) 2013 Herv=C3=A9 Poussineau
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
> @@ -7,10 +7,6 @@ common-obj-$(CONFIG_DS1338) +=3D ds1338.o
>  common-obj-$(CONFIG_HPET) +=3D hpet.o
>  common-obj-$(CONFIG_I8254) +=3D i8254_common.o i8254.o
>  common-obj-$(CONFIG_M41T80) +=3D m41t80.o
> -common-obj-$(CONFIG_M48T59) +=3D m48t59.o
> -ifeq ($(CONFIG_ISA_BUS),y)
> -common-obj-$(CONFIG_M48T59) +=3D m48t59-isa.o
> -endif
>  common-obj-$(CONFIG_PUV3) +=3D puv3_ost.o
>  common-obj-$(CONFIG_TWL92230) +=3D twl92230.o
>  common-obj-$(CONFIG_XILINX) +=3D xilinx_timer.o
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
> + * Copyright (c) 2013 Herv=C3=A9 Poussineau
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
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
> --
> 2.20.1
>
>

