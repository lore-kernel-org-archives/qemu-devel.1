Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD8BC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8836620815
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="My3u6ole"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8836620815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHntS-0002FG-G0
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 07:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHnn2-0005Ce-MH
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHnn0-0002ur-SQ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:36:28 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40902)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHnn0-0002u4-JR
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:36:26 -0400
Received: by mail-wr1-x441.google.com with SMTP id h4so10274092wrv.7
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 04:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Lz9bG3FctffxyENmtw1vdO6TrMHdi95v/fS944VB7Nc=;
 b=My3u6oleWUrh7Fqa5g7wlSR1lvCYWbwTDCFngzrEw5N0zdJJ0ee8m59FcB9EsxU0VI
 wN3zOsHIMoCEVhJxvtBs5LDiTUgBR24HdE1+3TPiQjj8WWdOERm6x7tasFfldwlYVUZU
 FmRjhifOAy74BG5+yFjvMuyS4r0PPNRTOONxtuKoou3MOc+pjXV3KIFLspUA/bo1HWZh
 13PqNzx6VcsmwpxtYeik0tKYWBOOjfpZ/j3lBGBEze2RtGdAiKblMz8LROK/+hl5FY+/
 w3IpTWA9+KmqmUfey18GkTE0D07PtH681U5bjExJw8mT5Axb4/uD/ehpz+uZ01Eik+BK
 tWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Lz9bG3FctffxyENmtw1vdO6TrMHdi95v/fS944VB7Nc=;
 b=XW2n1EjtoElRX708CnB38zxdjssAY/u4E/Rqcf2XIf8QLDMgP68Ao0NKbvEHsRvPVB
 s6DnMVvBR9DsJS1kw2H9yINJsgBbCBj15jLXRj3VAbiRD33X33gGHCJCCGc48pXlpq0L
 5XczLrw8wfvVLR/Y5XZyn4/ljyCPYqs9UR8Bbw1znjd3Tv3ydnGyRNEOan1iNgruoOXF
 oO2/xtuxLGRrkdCEI0HO3YV49twLaOIiqqy1T7Q/lczdHU4mK9xog2Wbd6aG0PflxmIg
 H5hiLh+9KKNNgA0c4HV19iYSaxj0iOGRJKHyoAZ7rd9m7V8DMvWuAL4q+fdoD2p0xXa6
 YzCw==
X-Gm-Message-State: APjAAAXACByoJvFbRpDEszfnhzqFMstBUBhcvzuiPxQmiD620V6Wn1c3
 Omnw9+nceUuR2MBCbgrUwZyEcQ==
X-Google-Smtp-Source: APXvYqwkaaYVo1/oNJeigp5w6u8sDi3Ankf2P8ugFr9Wns2Y+5Vn3KSnxBfrqzh5Gh1/eV6CM56e9A==
X-Received: by 2002:a5d:52c2:: with SMTP id r2mr27534055wrv.367.1570534585136; 
 Tue, 08 Oct 2019 04:36:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u1sm2563635wmc.38.2019.10.08.04.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 04:36:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DD94C1FF87;
 Tue,  8 Oct 2019 12:36:23 +0100 (BST)
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-9-f4bug@amsat.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 08/19] hw/misc/bcm2835_thermal: Add a dummy BCM2835
 thermal sensor
In-reply-to: <20190926173428.10713-9-f4bug@amsat.org>
Date: Tue, 08 Oct 2019 12:36:23 +0100
Message-ID: <87v9szii4o.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 =?utf-8?Q?Zolt=C3=A1n?= Baldaszti <bztemail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> We will soon implement the SYS_timer. This timer is used by Linux
> in the thermal subsystem, so once available, the subsystem will be
> enabled and poll the temperature sensors. We need to provide the
> minimum required to keep Linux booting.
>
> Add a dummy thermal sensor returning ~25=C2=B0C based on:
> https://github.com/raspberrypi/linux/blob/rpi-5.3.y/drivers/thermal/broad=
com/bcm2835_thermal.c
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> checkpatch warning:
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> This is OK because the regex are:
>
>   F: hw/*/bcm283*
>   F: include/hw/*/bcm283*
> ---
>  hw/misc/Makefile.objs             |   1 +
>  hw/misc/bcm2835_thermal.c         | 109 ++++++++++++++++++++++++++++++
>  include/hw/misc/bcm2835_thermal.h |  27 ++++++++
>  3 files changed, 137 insertions(+)
>  create mode 100644 hw/misc/bcm2835_thermal.c
>  create mode 100644 include/hw/misc/bcm2835_thermal.h
>
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index a150680966..c89f3816a5 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -53,6 +53,7 @@ common-obj-$(CONFIG_OMAP) +=3D omap_tap.o
>  common-obj-$(CONFIG_RASPI) +=3D bcm2835_mbox.o
>  common-obj-$(CONFIG_RASPI) +=3D bcm2835_property.o
>  common-obj-$(CONFIG_RASPI) +=3D bcm2835_rng.o
> +common-obj-$(CONFIG_RASPI) +=3D bcm2835_thermal.o
>  common-obj-$(CONFIG_SLAVIO) +=3D slavio_misc.o
>  common-obj-$(CONFIG_ZYNQ) +=3D zynq_slcr.o
>  common-obj-$(CONFIG_ZYNQ) +=3D zynq-xadc.o
> diff --git a/hw/misc/bcm2835_thermal.c b/hw/misc/bcm2835_thermal.c
> new file mode 100644
> index 0000000000..bac23f21ea
> --- /dev/null
> +++ b/hw/misc/bcm2835_thermal.c
> @@ -0,0 +1,109 @@
> +/*
> + * BCM2835 dummy thermal sensor
> + *
> + * Copyright (C) 2019 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include "qemu/osdep.h"
> +#include "hw/sysbus.h"
> +#include "hw/misc/bcm2835_thermal.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "hw/registerfields.h"
> +
> +REG32(CTL, 0)
> +FIELD(CTL, POWER_DOWN, 0, 1)
> +FIELD(CTL, RESET, 1, 1)
> +FIELD(CTL, BANDGAP_CTRL, 2, 3)
> +FIELD(CTL, INTERRUPT_ENABLE, 5, 1)
> +FIELD(CTL, DIRECT, 6, 1)
> +FIELD(CTL, INTERRUPT_CLEAR, 7, 1)
> +FIELD(CTL, HOLD, 8, 10)
> +FIELD(CTL, RESET_DELAY, 18, 8)
> +FIELD(CTL, REGULATOR_ENABLE, 26, 1)
> +
> +REG32(STAT, 4)
> +FIELD(STAT, DATA, 0, 10)
> +FIELD(STAT, VALID, 10, 1)
> +FIELD(STAT, INTERRUPT, 11, 1)
> +
> +#define THERMAL_OFFSET_C 412
> +#define THERMAL_COEFF  (-0.538f)
> +
> +static uint16_t bcm2835_thermal_temp2adc(int temp_C)
> +{
> +    return (temp_C - THERMAL_OFFSET_C) / THERMAL_COEFF;
> +}
> +
> +static uint64_t bcm2835_thermal_read(void *opaque, hwaddr addr, unsigned=
 size)
> +{
> +    Bcm2835ThermalState *s =3D BCM2835_THERMAL(opaque);
> +    uint32_t val =3D 0;
> +
> +    switch (addr) {
> +    case A_CTL:
> +        val =3D s->ctl;
> +        break;
> +    case A_STAT:
> +        val =3D FIELD_DP32(bcm2835_thermal_temp2adc(25), STAT, VALID, tr=
ue);
> +        break;
> +    default:
> +        g_assert_not_reached();

Will a unaligned read already have faulted and delivered an exception to
the guest? As this access it controlled by the guest it could
potentially take down QEMU. Perhaps it should be a LOG_GUEST_ERROR as
bellow?


> +    }
> +    return val;
> +}
> +
> +static void bcm2835_thermal_write(void *opaque, hwaddr addr,
> +                                  uint64_t value, unsigned size)
> +{
> +    Bcm2835ThermalState *s =3D BCM2835_THERMAL(opaque);
> +
> +    switch (addr) {
> +    case A_CTL:
> +        s->ctl =3D value;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: write 0x%" PRIx64
> +                                       " to 0x%" HWADDR_PRIx "\n",
> +                       __func__, value, addr);
> +    }
> +}
> +
> +static const MemoryRegionOps bcm2835_thermal_ops =3D {
> +    .read =3D bcm2835_thermal_read,
> +    .write =3D bcm2835_thermal_write,
> +    .impl.max_access_size =3D 4,
> +    .valid.min_access_size =3D 4,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static void bcm2835_thermal_realize(DeviceState *dev, Error **errp)
> +{
> +    Bcm2835ThermalState *s =3D BCM2835_THERMAL(dev);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &bcm2835_thermal_ops,
> +                          s, TYPE_BCM2835_THERMAL, 8);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
> +}
> +
> +static void bcm2835_thermal_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D bcm2835_thermal_realize;
> +}
> +
> +static const TypeInfo bcm2835_thermal_info =3D {
> +    .name =3D TYPE_BCM2835_THERMAL,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(Bcm2835ThermalState),
> +    .class_init =3D bcm2835_thermal_class_init,
> +};
> +
> +static void bcm2835_thermal_register_types(void)
> +{
> +    type_register_static(&bcm2835_thermal_info);
> +}
> +
> +type_init(bcm2835_thermal_register_types)
> diff --git a/include/hw/misc/bcm2835_thermal.h b/include/hw/misc/bcm2835_=
thermal.h
> new file mode 100644
> index 0000000000..f85cce7214
> --- /dev/null
> +++ b/include/hw/misc/bcm2835_thermal.h
> @@ -0,0 +1,27 @@
> +/*
> + * BCM2835 dummy thermal sensor
> + *
> + * Copyright (C) 2019 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef HW_MISC_BCM2835_THERMAL_H
> +#define HW_MISC_BCM2835_THERMAL_H
> +
> +#include "hw/qdev-properties.h"
> +#include "hw/sysbus.h"
> +
> +#define TYPE_BCM2835_THERMAL "bcm2835-thermal"
> +
> +#define BCM2835_THERMAL(obj) \
> +    OBJECT_CHECK(Bcm2835ThermalState, (obj), TYPE_BCM2835_THERMAL)
> +
> +typedef struct {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +    /*< public >*/
> +    MemoryRegion iomem;
> +    uint32_t ctl;
> +} Bcm2835ThermalState;
> +
> +#endif

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e

