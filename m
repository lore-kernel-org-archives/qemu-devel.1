Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332A8C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 09:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2FDF2190F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 09:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2FDF2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFEqG-0004eC-PS
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 05:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iFEom-0003fJ-0v
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iFEoi-0000cu-Nr
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:51:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39584)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iFEoi-0000cH-Dy
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:51:36 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D62C381F10
 for <qemu-devel@nongnu.org>; Tue,  1 Oct 2019 09:51:34 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id k184so1177741wmk.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 02:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u9fMG+O0Ip9k9oEl2m1jCJopZ1+SrEiOcAQx1ClpIfA=;
 b=C5+2iKQd9/ge9ACmIgUn5aEMkD6SDQAUnj+LIzOMXUfyXTWf5Tv6coJ8Sdpw2fiTdZ
 7VuHGmnf1u4mAOvqJkgGeP1Wj+qFPCCDZcephR1QCUvL0nS7+wUM7139/AQF/e6BuIUT
 Rc2K1FstYADoFtHDxb0X+r9NzdBHMjNOb05YndSEmrpVQFCp0/uMzuTnViJZIkgjj/LL
 LjTlCTCmrW8xdyeRbGcA8zeCqFAcgBSkvYRw8n/klYIA5kLKcuwsuxtRTSXmjbieGrmh
 29R9J0hwrJAMiYr7NOR8F+IUjnV4A5nUErih7pA8dYPnaJpt7l/ZhuNxyq8xMBIFkfeD
 ccTg==
X-Gm-Message-State: APjAAAUe6bwzDzmBsasA1cQc/RRjtele4yE6iC2ecCc3xTKiO6k1Qgxb
 bqgknFgVwjSjQzO5S4+wRgEFjcLFgZ26dscWcbMDvU9jegPQNdL1t83Rb9P4wOVs7WqmZnAgxk9
 hzu1c67uTYGuE7Fo=
X-Received: by 2002:a1c:1903:: with SMTP id 3mr2751191wmz.4.1569923493463;
 Tue, 01 Oct 2019 02:51:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwlDtqemsovjtfRwDVP9b6jynU1iCK6fV+41Dm70mzEHul5fhrsfqsjq/m4Heo/hPYRiyWMgw==
X-Received: by 2002:a1c:1903:: with SMTP id 3mr2751172wmz.4.1569923493152;
 Tue, 01 Oct 2019 02:51:33 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id n17sm16145368wrp.37.2019.10.01.02.51.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2019 02:51:32 -0700 (PDT)
Subject: Re: [PATCH 12/19] hw/arm/bcm2835_peripherals: Add Clock/Power/Reset
 Manager blocks
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-13-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9a814d3e-0ae0-08a4-9d43-1d157712029f@redhat.com>
Date: Tue, 1 Oct 2019 11:51:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190926173428.10713-13-f4bug@amsat.org>
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
 =?UTF-8?Q?Zolt=c3=a1n_Baldaszti?= <bztemail@gmail.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>, Pekka Enberg <penberg@iki.fi>,
 Guenter Roeck <linux@roeck-us.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/26/19 7:34 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Add basic support for BCM283x CPRMAN. Provide support for reading and
> writing CPRMAN registers and initialize registers with sensible default
> values. During runtime retain any written values.
>=20
> Basic CPRMAN support is necessary and sufficient to boot Linux on raspi=
2
> and raspi3 systems.
>=20
> Based on:
> https://github.com/raspberrypi/linux/blob/rpi-5.3.y/drivers/clk/bcm/clk=
-bcm2835.c
> https://github.com/u-boot/u-boot/blob/v2019.07/include/dt-bindings/cloc=
k/bcm2835.h
> https://github.com/arisena-com/rpi_src/blob/master/apps/i2s_test/src/i2=
s_test.c#L273
>=20
> Co-developed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   hw/arm/bcm2835_peripherals.c         |  20 +-
>   hw/misc/Makefile.objs                |   1 +
>   hw/misc/bcm2835_cprman.c             | 383 ++++++++++++++++++++++++++=
+
>   hw/misc/trace-events                 |   8 +
>   include/hw/arm/bcm2835_peripherals.h |   4 +-
>   include/hw/misc/bcm2835_cprman.h     |  32 +++
>   6 files changed, 444 insertions(+), 4 deletions(-)
>   create mode 100644 hw/misc/bcm2835_cprman.c
>   create mode 100644 include/hw/misc/bcm2835_cprman.h
>=20
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.=
c
> index 965f4c1f3d..c887969795 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -62,6 +62,11 @@ static void bcm2835_peripherals_init(Object *obj)
>       sysbus_init_child_obj(obj, "systimer", &s->systmr, sizeof(s->syst=
mr),
>                             TYPE_BCM2835_SYSTIMER);
>  =20
> +    /* Clock / Power / Reset */
> +    object_initialize(&s->cprman, sizeof(s->cprman), TYPE_BCM2835_CPRM=
AN);
> +    object_property_add_child(obj, "cprman", OBJECT(&s->cprman), NULL)=
;
> +    qdev_set_parent_bus(DEVICE(&s->cprman), sysbus_get_default());
> +
>       /* UART0 */
>       sysbus_init_child_obj(obj, "uart0", &s->uart0, sizeof(s->uart0),
>                             TYPE_PL011);
> @@ -191,6 +196,19 @@ static void bcm2835_peripherals_realize(DeviceStat=
e *dev, Error **errp)
>           qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_ARM_IRQ,
>                                  INTERRUPT_ARM_TIMER));
>  =20
> +    /* Clock / Power / Reset */
> +    object_property_set_bool(OBJECT(&s->cprman), true, "realized", &er=
r);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    memory_region_add_subregion(&s->peri_mr, CPRMAN_OFFSET,
> +                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->cprman), 0))=
;
> +    memory_region_add_subregion(&s->peri_mr, CM_OFFSET,
> +                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->cprman), 1))=
;
> +    memory_region_add_subregion(&s->peri_mr, A2W_OFFSET,
> +                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->cprman), 2))=
;
> +
>       /* UART0 */
>       qdev_prop_set_chr(DEVICE(&s->uart0), "chardev", serial_hd(0));
>       object_property_set_bool(OBJECT(&s->uart0), true, "realized", &er=
r);
> @@ -372,8 +390,6 @@ static void bcm2835_peripherals_realize(DeviceState=
 *dev, Error **errp)
>       }
>  =20
>       create_unimp(s, &s->armtmr, "bcm2835-sp804", ARMCTRL_TIMER0_1_OFF=
SET, 0x40);
> -    create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET, 0x100=
0);
> -    create_unimp(s, &s->a2w, "bcm2835-a2w", A2W_OFFSET, 0x1000);
>       create_unimp(s, &s->i2s, "bcm2835-i2s", I2S_OFFSET, 0x100);
>       create_unimp(s, &s->smi, "bcm2835-smi", SMI_OFFSET, 0x100);
>       create_unimp(s, &s->spi[0], "bcm2835-spi0", SPI0_OFFSET, 0x20);
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index c89f3816a5..64e717e6b3 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -53,6 +53,7 @@ common-obj-$(CONFIG_OMAP) +=3D omap_tap.o
>   common-obj-$(CONFIG_RASPI) +=3D bcm2835_mbox.o
>   common-obj-$(CONFIG_RASPI) +=3D bcm2835_property.o
>   common-obj-$(CONFIG_RASPI) +=3D bcm2835_rng.o
> +common-obj-$(CONFIG_RASPI) +=3D bcm2835_cprman.o
>   common-obj-$(CONFIG_RASPI) +=3D bcm2835_thermal.o
>   common-obj-$(CONFIG_SLAVIO) +=3D slavio_misc.o
>   common-obj-$(CONFIG_ZYNQ) +=3D zynq_slcr.o
> diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
> new file mode 100644
> index 0000000000..6c3b5b6837
> --- /dev/null
> +++ b/hw/misc/bcm2835_cprman.c
> @@ -0,0 +1,383 @@
> +/*
> + * BCM2835 Clock/Power/Reset Manager subsystem (poor man's version)
> + *
> + * Copyright (C) 2018 Guenter Roeck <linux@roeck-us.net>
> + * Copyright (C) 2018 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "sysemu/runstate.h"
> +#include "hw/registerfields.h"
> +#include "hw/misc/bcm2835_cprman.h"
> +#include "trace.h"
> +
> +#define CPRMAN_PASSWD 'Z'
> +
> +FIELD(CPRMAN, PASSWD,   24, 8)
> +
> +REG32(PM_RSTC,          0x1c)
> +REG32(PM_RSTS,          0x20)
> +REG32(PM_WDOG,          0x24)
> +
> +static const char *pm_name(hwaddr addr)
> +{
> +    addr &=3D ~3;
> +    switch (addr) {
> +    case A_PM_RSTC: return "RST_CLR";
> +    case A_PM_RSTS: return "RST_SET";
> +    case A_PM_WDOG: return "WDG";
> +    default:
> +        return "UNKN";
> +    }
> +}
> +
> +static uint64_t bcm2835_cprman_pm_read(void *opaque, hwaddr addr,
> +                                    unsigned size)
> +{
> +    uint32_t res =3D 0;
> +
> +    trace_bcm2835_cprman_read(size << 3, addr, "PM", pm_name(addr), ""=
, res);
> +
> +    return res;
> +}
> +
> +static void bcm2835_cprman_pm_write(void *opaque, hwaddr addr,
> +                                    uint64_t value, unsigned size)
> +{
> +    const char *name;
> +
> +    if (FIELD_EX32(value, CPRMAN, PASSWD) !=3D CPRMAN_PASSWD) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "[CPRMAN]: password key error w=
%02d"
> +                                       " *0x%04"HWADDR_PRIx" =3D 0x%"P=
RIx64"\n",
> +                      size << 3, addr, value);
> +        return;
> +    }
> +    value &=3D ~R_CPRMAN_PASSWD_MASK;
> +
> +    name =3D pm_name(addr);
> +    trace_bcm2835_cprman_write_pm(addr, name, value);
> +    if (addr =3D=3D A_PM_RSTC && value & 0x20) { /* TODO remove 0x20 m=
agic */
> +        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +    }
> +}
> +
> +static const MemoryRegionOps bcm2835_cprman_pm_ops =3D {
> +    .read =3D bcm2835_cprman_pm_read,
> +    .write =3D bcm2835_cprman_pm_write,
> +    .impl.max_access_size =3D 4,
> +    .valid.min_access_size =3D 4,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +};
> +
> +REG32(CM_CTL,               0)
> +FIELD(CM_CTL, SRC,       0, 4)
> +FIELD(CM_CTL, ENABLE,    4, 1)
> +FIELD(CM_CTL, KILL,      5, 1)
> +FIELD(CM_CTL, GATE,      6, 1)
> +FIELD(CM_CTL, BUSY,      7, 1)
> +FIELD(CM_CTL, BUSYD,     8, 1)
> +FIELD(CM_CTL, FRAC,      9, 1)
> +
> +REG32(CM_DIV,               4)
> +FIELD(CM_DIV, FRAC,      0, 12)
> +FIELD(CM_DIV, INTEGER,  12, 12)
> +
> +REG32(CM_OSCCOUNT,      0x100)
> +REG32(CM_LOCK,          0x114)
> +REG32(CM_EVENT,         0x118)
> +REG32(CM_PLLB,          0x170)
> +
> +/* Bits used by R_CM_CTL_SRC_MASK */
> +enum cprman_clock_source {
> +    SRC_GND =3D 0,
> +    SRC_OSC =3D 1,
> +    SRC_TEST_DBG0 =3D 2,
> +    SRC_TEST_DBG1 =3D 3,
> +    SRC_PLLA =3D 4,
> +    SRC_PLLC_CORE0 =3D 5,
> +    SRC_PLLD =3D 6,
> +    SRC_PLLH_AUX =3D 7,
> +    SRC_PLLC_CORE1 =3D 8,
> +    SRC_PLLC_CORE2 =3D 9
> +};
> +
> +static const char *src_name(int src)
> +{
> +    static const char *src_names[16] =3D {
> +        [SRC_GND] =3D "GND",
> +        [SRC_OSC] =3D "OSC",
> +        [SRC_PLLA] =3D "PLLA",
> +        [SRC_PLLC_CORE0] =3D "PLLC_CORE0",
> +        [SRC_PLLD] =3D "PLLD",
> +        [SRC_PLLH_AUX] =3D "PLLH_AUX",
> +        [SRC_PLLC_CORE1] =3D "PLLC_CORE1",
> +        [SRC_PLLC_CORE2] =3D "PLLC_CORE2",
> +    };
> +    return src_names[src] ? src_names[src] : "UNKN";
> +}
> +
> +static const char *ctldiv_names[0x200 / 4] =3D {
> +    [0] =3D "GENERIC",
> +    [1] =3D "VPU",
> +    [2] =3D "SYS",
> +    [3] =3D "PERIA",
> +    [4] =3D "PERII",
> +    [5] =3D "H264",
> +    [6] =3D "ISP",
> +    [7] =3D "V3D",
> +    [8] =3D "CAM0",
> +    [9] =3D "CAM1",
> +    [10] =3D "CCP2",
> +    [11] =3D "DSI0E",
> +    [12] =3D "DSI0P",
> +    [13] =3D "DPI",
> +    [14] =3D "GP0",
> +    [15] =3D "GP1",
> +    [16] =3D "GP2",
> +    [17] =3D "HSM",
> +    [18] =3D "OTP",
> +    [19] =3D "PCM",
> +    [20] =3D "PWM",
> +    [21] =3D "SLIM",
> +    [22] =3D "SMI",
> +    [24] =3D "TCNT",
> +    [25] =3D "TEC",
> +    [26] =3D "TD0",
> +    [27] =3D "TD1",
> +    [28] =3D "TSENS",
> +    [29] =3D "TIMER",
> +    [30] =3D "UART",
> +    [31] =3D "VEC",
> +    [43] =3D "DSI1E",
> +    [44] =3D "DSI1P",
> +    [45] =3D "DFT",
> +    [50] =3D "PULSE",
> +    [53] =3D "SDC",
> +    [54] =3D "ARM",
> +    [55] =3D "AVEO",
> +    [56] =3D "EMMC",
> +};
> +
> +static const char *cm_name(hwaddr addr)
> +{
> +    int idx;
> +
> +    addr &=3D ~3;
> +    switch (addr) {
> +    case A_CM_OSCCOUNT: return "OSCCOUNT";
> +    case 0x104 ... 0x110:
> +    case A_CM_PLLB: return "PLLx";
> +    case A_CM_LOCK: return "LOCK";
> +    case A_CM_EVENT: return "EVENT";
> +    default:
> +        idx =3D addr / 8;
> +        return ctldiv_names[idx] ? ctldiv_names[idx] : "UNKN";
> +    }
> +}
> +
> +static uint32_t scale(uint32_t value)
> +{
> +    return (1000ull * value) >> 10;
> +}
> +
> +/*
> + * Available information suggests that CPRMAN registers have default
> + * values which are not overwritten by ROMMON (u-boot). The hardware
> + * default values are unknown at this time.
> + * The default values selected here are necessary and sufficient
> + * to boot Linux directly (on raspi2 and raspi3). The selected
> + * values enable all clocks and set clock rates to match their
> + * parent rates.
> + */
> +static uint64_t bcm2835_cprman_cm_read(void *opaque, hwaddr addr,
> +                                       unsigned size)
> +{
> +    uint32_t res =3D 0;
> +
> +    if (addr =3D=3D A_CM_LOCK) {
> +        res =3D 0b11111 << 8; /* all locked! */
> +    } else {
> +        switch (addr & 0xf) {

This should be addr & 7 to match [0, 4].

> +        case A_CM_CTL:
> +            res =3D SRC_OSC | R_CM_CTL_ENABLE_MASK;
> +            break;
> +        case A_CM_DIV:
> +            res =3D FIELD_DP32(0, CM_DIV, INTEGER, 1);
> +            break;
> +        default:
> +            qemu_log_mask(LOG_UNIMP, "%s: bad offset 0x%" HWADDR_PRIx =
"\n",
> +                          __func__, addr);
> +        }
> +    }
> +    trace_bcm2835_cprman_read(size << 3, addr, "CM", cm_name(addr), ""=
, res);
> +
> +    return res;
> +}
> +
> +static void bcm2835_cprman_cm_write(void *opaque, hwaddr addr,
> +                                    uint64_t value, unsigned size)
> +{
> +    const char *name;
> +
> +    if (FIELD_EX32(value, CPRMAN, PASSWD) !=3D CPRMAN_PASSWD) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "[CPRMAN]: password key error w=
%02d"
> +                                       " *0x%04"HWADDR_PRIx" =3D 0x%"P=
RIx64"\n",
> +                      size << 3, addr, value);
> +        return;
> +    }
> +    value &=3D ~R_CPRMAN_PASSWD_MASK;
> +
> +    name =3D cm_name(addr);
> +    switch (addr) {
> +    case A_CM_OSCCOUNT:
> +    case 0x104 ... 0x110:
> +    case A_CM_PLLB:
> +    case A_CM_LOCK:
> +    case A_CM_EVENT:
> +        trace_bcm2835_cprman_write_cm_generic(name, value);
> +        break;
> +    default:
> +        switch (addr & 0xf) {

Ditto.

> +        case A_CM_CTL:
> +            trace_bcm2835_cprman_write_cm_ctl(name, src_name(value & 0=
xf),
> +                                FIELD_EX32(value, CM_CTL, ENABLE));
> +            break;
> +        case A_CM_DIV:
> +            trace_bcm2835_cprman_write_cm_div(name,
> +                                FIELD_EX32(value, CM_DIV, INTEGER),
> +                                scale(FIELD_EX32(value, CM_DIV, FRAC))=
);
> +        }
> +    }
> +}
> +
> +static const MemoryRegionOps bcm2835_cprman_cm_ops =3D {
> +    .read =3D bcm2835_cprman_cm_read,
> +    .write =3D bcm2835_cprman_cm_write,
> +    .impl.max_access_size =3D 4,
> +    .valid.min_access_size =3D 4,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +};
> +
> +REG32(A2W_PLL_CTRL, 0x00)
> +FIELD(A2W_PLL_CTRL, NDIV,                   0, 12)
> +FIELD(A2W_PLL_CTRL, PDIV,                   12, 3)
> +FIELD(A2W_PLL_CTRL, POWER_DOWN,             16, 1)
> +FIELD(A2W_PLL_CTRL, POWER_RESET_DISABLE,    17, 1)
> +
> +REG32(A2W_PLL_ANA0, 0x10)
> +
> +FIELD(A2W_PLL_FRAC, DIV,                    0, 20)
> +
> +FIELD(A2W_PLL_CHAN, DIV,                    0, 8)
> +FIELD(A2W_PLL_CHAN, DISABLE,                8, 1)
> +
> +static const char *a2w_name(hwaddr addr)
> +{
> +    if (addr >=3D 0x300) {
> +        return "CHANx";
> +    }
> +    if (addr >=3D 0x200) {
> +        return "FRACx";
> +    }
> +    switch (addr & 0x1f) {
> +    case A_A2W_PLL_CTRL:
> +        return "CTRL";
> +    case A_A2W_PLL_ANA0:
> +        return "ANA0";
> +    default:
> +        return "UNKN";
> +    }
> +}
> +
> +static const char *pll_name(int idx)
> +{
> +    static const char *pll_names[8] =3D {
> +        [0] =3D "PLLA",
> +        [1] =3D "PLLC",
> +        [2] =3D "PLLD",
> +        [3] =3D "PLLH",
> +        [7] =3D "PLLB",
> +    };
> +    return pll_names[idx] ? pll_names[idx] : "UNKN";
> +}
> +
> +static uint64_t bcm2835_cprman_a2w_read(void *opaque, hwaddr addr,
> +                                        unsigned size)
> +{
> +    uint32_t res =3D 0;
> +
> +    if (addr < 0x200) {
> +        /* Power */
> +        switch (addr & 0x1f) {
> +        case A_A2W_PLL_CTRL:
> +            res =3D R_A2W_PLL_CTRL_POWER_DOWN_MASK; /* On */
> +            break;
> +        case A_A2W_PLL_ANA0:
> +            break;
> +        }
> +    } else {
> +        /* addr < 0x300 is FREQ, else CHANNEL */
> +        qemu_log_mask(LOG_UNIMP, "%s: bad offset 0x%" HWADDR_PRIx "\n"=
,
> +                      __func__, addr);
> +    }
> +    trace_bcm2835_cprman_read(size << 3, addr, "A2W", a2w_name(addr),
> +                              pll_name((addr >> 5) & 7), res);
> +
> +    return res;
> +}
> +
> +static void bcm2835_cprman_a2w_write(void *opaque, hwaddr addr,
> +                                     uint64_t value, unsigned size)
> +{
> +    if (FIELD_EX32(value, CPRMAN, PASSWD) !=3D CPRMAN_PASSWD) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "[CPRMAN]: password key error w=
%02d"
> +                                       " *0x%04"HWADDR_PRIx" =3D 0x%"P=
RIx64"\n",
> +                      size << 3, addr, value);
> +        return;
> +    }
> +    value &=3D ~R_CPRMAN_PASSWD_MASK;
> +
> +    trace_bcm2835_cprman_write_a2w(addr, a2w_name(addr),
> +                                   pll_name((addr >> 5) & 7), value);
> +}
> +
> +static const MemoryRegionOps bcm2835_cprman_a2w_ops =3D {
> +    .read =3D bcm2835_cprman_a2w_read,
> +    .write =3D bcm2835_cprman_a2w_write,
> +    .impl.max_access_size =3D 4,
> +    .valid.min_access_size =3D 4,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static void bcm2835_cprman_init(Object *obj)
> +{
> +    BCM2835CprmanState *s =3D BCM2835_CPRMAN(obj);
> +
> +    memory_region_init_io(&s->iomem.pm, obj, &bcm2835_cprman_pm_ops, s=
,
> +                          TYPE_BCM2835_CPRMAN "-pm", 0x1000);
> +    memory_region_init_io(&s->iomem.cm, obj, &bcm2835_cprman_cm_ops, s=
,
> +                          TYPE_BCM2835_CPRMAN "-cm", 0x1000);
> +    memory_region_init_io(&s->iomem.a2w, obj, &bcm2835_cprman_a2w_ops,=
 s,
> +                          TYPE_BCM2835_CPRMAN "-a2w", 0x1000);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem.pm);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem.cm);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem.a2w);
> +}
> +
> +static TypeInfo bcm2835_cprman_info =3D {
> +    .name          =3D TYPE_BCM2835_CPRMAN,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(BCM2835CprmanState),
> +    .instance_init =3D bcm2835_cprman_init,
> +};
> +
> +static void bcm2835_cprman_register_types(void)
> +{
> +    type_register_static(&bcm2835_cprman_info);
> +}
> +
> +type_init(bcm2835_cprman_register_types)
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 1deb1d08c1..30d33e2e1d 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -149,3 +149,11 @@ bcm2835_mbox_write(unsigned int size, uint64_t add=
r, uint64_t value) "mbox write
>   bcm2835_mbox_read(unsigned int size, uint64_t addr, uint64_t value) "=
mbox read sz:%u addr:0x%"PRIx64" data:0x%"PRIx64
>   bcm2835_mbox_irq(unsigned level) "mbox irq:ARM level:%u"
>   bcm2835_mbox_property(uint32_t tag, uint32_t bufsize, size_t resplen)=
 "mbox property tag:0x%08x in_sz:%u out_sz:%zu"
> +
> +# bcm2835_cprman.c
> +bcm2835_cprman_read(unsigned size, uint64_t offset, const char *reg_ty=
pe, const char *reg_name1, const char *reg_name2, uint32_t value) "cprman=
: rd%u @0x%03" PRIx64 " %s %s.%s val:0x%x"
> +bcm2835_cprman_write_pm(uint64_t offset, const char *reg_name, uint32_=
t value) "pm: wr @0x%03" PRIx64 " %s val:0x%x"
> +bcm2835_cprman_write_cm_generic(const char *reg_name, uint32_t val) "c=
prman: wr %s 0x%08x"
> +bcm2835_cprman_write_cm_div(const char *reg_name, uint32_t v0, uint32_=
t v1) "cprman: wr %s.DIV float:%u.%u"
> +bcm2835_cprman_write_cm_ctl(const char *reg_name, const char *src, uin=
t32_t ena) "cprman: wr %s.CTL src:%s enabled:%u"
> +bcm2835_cprman_write_a2w(uint64_t offset, const char *reg_name, const =
char *pll_name, uint32_t value) "a2w: wr @0x%03" PRIx64 " %s.%s val:0x%x"
> diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2=
835_peripherals.h
> index 5b9fc89453..b4360ca1a8 100644
> --- a/include/hw/arm/bcm2835_peripherals.h
> +++ b/include/hw/arm/bcm2835_peripherals.h
> @@ -19,6 +19,7 @@
>   #include "hw/intc/bcm2835_ic.h"
>   #include "hw/misc/bcm2835_property.h"
>   #include "hw/misc/bcm2835_rng.h"
> +#include "hw/misc/bcm2835_cprman.h"
>   #include "hw/misc/bcm2835_mbox.h"
>   #include "hw/misc/bcm2835_thermal.h"
>   #include "hw/sd/sdhci.h"
> @@ -42,8 +43,7 @@ typedef struct BCM2835PeripheralState {
>  =20
>       BCM2835SysTimerState systmr;
>       UnimplementedDeviceState armtmr;
> -    UnimplementedDeviceState cprman;
> -    UnimplementedDeviceState a2w;
> +    BCM2835CprmanState cprman;
>       PL011State uart0;
>       BCM2835AuxState aux;
>       BCM2835FBState fb;
> diff --git a/include/hw/misc/bcm2835_cprman.h b/include/hw/misc/bcm2835=
_cprman.h
> new file mode 100644
> index 0000000000..4dd2c8323b
> --- /dev/null
> +++ b/include/hw/misc/bcm2835_cprman.h
> @@ -0,0 +1,32 @@
> +/*
> + * BCM2835 Clock/Power/Reset Manager subsystem (poor man's version)
> + *
> + * Copyright (C) 2018 Guenter Roeck <linux@roeck-us.net>
> + * Copyright (C) 2018 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef BCM2835_CPRMAN_H
> +#define BCM2835_CPRMAN_H
> +
> +#include "hw/sysbus.h"
> +
> +#define TYPE_BCM2835_CPRMAN "bcm2835-cprman"
> +#define BCM2835_CPRMAN(obj) \
> +        OBJECT_CHECK(BCM2835CprmanState, (obj), TYPE_BCM2835_CPRMAN)
> +
> +typedef struct {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +    /*< public >*/
> +
> +    struct {
> +        MemoryRegion pm;
> +        MemoryRegion cm;
> +        MemoryRegion a2w;
> +    } iomem;
> +} BCM2835CprmanState;
> +
> +#endif
>=20

