Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B1DC10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C950720673
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C950720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHnts-0002ej-Kc
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 07:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHnsh-0001d2-Ll
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:42:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHnsf-0007Bu-M8
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:42:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42346)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iHnsf-0007BC-DI
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:42:17 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BABCC9AE9C
 for <qemu-devel@nongnu.org>; Tue,  8 Oct 2019 11:42:15 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id c188so859913wmd.9
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 04:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ytok/+hvwJ6x72CSB3VsUVDvdl0dedDDZWl56ciu6zY=;
 b=tngeCVCLOiYJOte8uuNr1RK8sSMIr7vx8CGk5vsd1sopPtTFtgxcXLuDzmSuCZd27k
 /5c8Bf15RlUPlhCZwY51hdmPH0wGxCPrVeMlLt48gtIGI5NXQDlDqKIrgaS/v1g5oj8n
 kVWRKiKfFDW5gef657SogDl7a7d8JZOT9EMSuRrGPzobR9vFjlMkP/eHmoDAJ4A7uHj4
 s3AHtm/4yQhNvNRLidHwVgO1NemLQtHNjpIgJRh69Iai8AUs3CmfgfY0HWpPsnd9F3it
 8aZPY/U8cpIyicS5MI4RPkkPzni7hg2O0DZEt8r4mb3apxxb49bQ704tzZizSbOHYGxc
 HT9A==
X-Gm-Message-State: APjAAAUBQqUoQpLYYcGcaqWJUqW61oJOFABRf134jut4wU5NH5gr9cIE
 s8pnqYhgraTBO0Mq3V1d1KOsNaHKEjitgsrfNXEk8JYPd/vAj3t6zU2mD+FZ8n5eQWoKmx+1VFi
 MalgXwGW4XDb/4xU=
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr3326298wmj.91.1570534934452; 
 Tue, 08 Oct 2019 04:42:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxHyLOOSBmskksZIoBa2phXRvyrgP+xhZWdEIiLNI4MWyGwOG8dYac3X3zhDW1/TAaoWnO5RA==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr3326271wmj.91.1570534934182; 
 Tue, 08 Oct 2019 04:42:14 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id w18sm2589801wmc.9.2019.10.08.04.42.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2019 04:42:13 -0700 (PDT)
Subject: Re: [PATCH 08/19] hw/misc/bcm2835_thermal: Add a dummy BCM2835
 thermal sensor
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-9-f4bug@amsat.org> <87v9szii4o.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e75a3602-496b-107c-8bdb-c847982547be@redhat.com>
Date: Tue, 8 Oct 2019 13:42:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <87v9szii4o.fsf@linaro.org>
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
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>, Pekka Enberg <penberg@iki.fi>,
 Guenter Roeck <linux@roeck-us.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/19 1:36 PM, Alex Benn=C3=A9e wrote:
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>=20
>> We will soon implement the SYS_timer. This timer is used by Linux
>> in the thermal subsystem, so once available, the subsystem will be
>> enabled and poll the temperature sensors. We need to provide the
>> minimum required to keep Linux booting.
>>
>> Add a dummy thermal sensor returning ~25=C2=B0C based on:
>> https://github.com/raspberrypi/linux/blob/rpi-5.3.y/drivers/thermal/br=
oadcom/bcm2835_thermal.c
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> checkpatch warning:
>> WARNING: added, moved or deleted file(s), does MAINTAINERS need updati=
ng?
>> This is OK because the regex are:
>>
>>    F: hw/*/bcm283*
>>    F: include/hw/*/bcm283*
>> ---
>>   hw/misc/Makefile.objs             |   1 +
>>   hw/misc/bcm2835_thermal.c         | 109 ++++++++++++++++++++++++++++=
++
>>   include/hw/misc/bcm2835_thermal.h |  27 ++++++++
>>   3 files changed, 137 insertions(+)
>>   create mode 100644 hw/misc/bcm2835_thermal.c
>>   create mode 100644 include/hw/misc/bcm2835_thermal.h
>>
>> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
>> index a150680966..c89f3816a5 100644
>> --- a/hw/misc/Makefile.objs
>> +++ b/hw/misc/Makefile.objs
>> @@ -53,6 +53,7 @@ common-obj-$(CONFIG_OMAP) +=3D omap_tap.o
>>   common-obj-$(CONFIG_RASPI) +=3D bcm2835_mbox.o
>>   common-obj-$(CONFIG_RASPI) +=3D bcm2835_property.o
>>   common-obj-$(CONFIG_RASPI) +=3D bcm2835_rng.o
>> +common-obj-$(CONFIG_RASPI) +=3D bcm2835_thermal.o
>>   common-obj-$(CONFIG_SLAVIO) +=3D slavio_misc.o
>>   common-obj-$(CONFIG_ZYNQ) +=3D zynq_slcr.o
>>   common-obj-$(CONFIG_ZYNQ) +=3D zynq-xadc.o
>> diff --git a/hw/misc/bcm2835_thermal.c b/hw/misc/bcm2835_thermal.c
>> new file mode 100644
>> index 0000000000..bac23f21ea
>> --- /dev/null
>> +++ b/hw/misc/bcm2835_thermal.c
>> @@ -0,0 +1,109 @@
>> +/*
>> + * BCM2835 dummy thermal sensor
>> + *
>> + * Copyright (C) 2019 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +#include "qemu/osdep.h"
>> +#include "hw/sysbus.h"
>> +#include "hw/misc/bcm2835_thermal.h"
>> +#include "qemu/log.h"
>> +#include "qapi/error.h"
>> +#include "hw/registerfields.h"
>> +
>> +REG32(CTL, 0)
>> +FIELD(CTL, POWER_DOWN, 0, 1)
>> +FIELD(CTL, RESET, 1, 1)
>> +FIELD(CTL, BANDGAP_CTRL, 2, 3)
>> +FIELD(CTL, INTERRUPT_ENABLE, 5, 1)
>> +FIELD(CTL, DIRECT, 6, 1)
>> +FIELD(CTL, INTERRUPT_CLEAR, 7, 1)
>> +FIELD(CTL, HOLD, 8, 10)
>> +FIELD(CTL, RESET_DELAY, 18, 8)
>> +FIELD(CTL, REGULATOR_ENABLE, 26, 1)
>> +
>> +REG32(STAT, 4)
>> +FIELD(STAT, DATA, 0, 10)
>> +FIELD(STAT, VALID, 10, 1)
>> +FIELD(STAT, INTERRUPT, 11, 1)
>> +
>> +#define THERMAL_OFFSET_C 412
>> +#define THERMAL_COEFF  (-0.538f)
>> +
>> +static uint16_t bcm2835_thermal_temp2adc(int temp_C)
>> +{
>> +    return (temp_C - THERMAL_OFFSET_C) / THERMAL_COEFF;
>> +}
>> +
>> +static uint64_t bcm2835_thermal_read(void *opaque, hwaddr addr, unsig=
ned size)
>> +{
>> +    Bcm2835ThermalState *s =3D BCM2835_THERMAL(opaque);
>> +    uint32_t val =3D 0;
>> +
>> +    switch (addr) {
>> +    case A_CTL:
>> +        val =3D s->ctl;
>> +        break;
>> +    case A_STAT:
>> +        val =3D FIELD_DP32(bcm2835_thermal_temp2adc(25), STAT, VALID,=
 true);
>> +        break;
>> +    default:
>> +        g_assert_not_reached();
>=20
> Will a unaligned read already have faulted and delivered an exception t=
o
> the guest? As this access it controlled by the guest it could
> potentially take down QEMU. Perhaps it should be a LOG_GUEST_ERROR as
> bellow?

MemoryRegionOps::(valid|impl).unaligned default to false, so unaligned=20
accesses won't reach this device, the guest will get a MEMTX_DECODE_ERROR=
.

>> +    }
>> +    return val;
>> +}
>> +
>> +static void bcm2835_thermal_write(void *opaque, hwaddr addr,
>> +                                  uint64_t value, unsigned size)
>> +{
>> +    Bcm2835ThermalState *s =3D BCM2835_THERMAL(opaque);
>> +
>> +    switch (addr) {
>> +    case A_CTL:
>> +        s->ctl =3D value;
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: write 0x%" PRIx64
>> +                                       " to 0x%" HWADDR_PRIx "\n",
>> +                       __func__, value, addr);
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps bcm2835_thermal_ops =3D {
>> +    .read =3D bcm2835_thermal_read,
>> +    .write =3D bcm2835_thermal_write,
>> +    .impl.max_access_size =3D 4,
>> +    .valid.min_access_size =3D 4,
>> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
>> +};
>> +
>> +static void bcm2835_thermal_realize(DeviceState *dev, Error **errp)
>> +{
>> +    Bcm2835ThermalState *s =3D BCM2835_THERMAL(dev);
>> +
>> +    memory_region_init_io(&s->iomem, OBJECT(s), &bcm2835_thermal_ops,
>> +                          s, TYPE_BCM2835_THERMAL, 8);
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
>> +}
>> +
>> +static void bcm2835_thermal_class_init(ObjectClass *klass, void *data=
)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +
>> +    dc->realize =3D bcm2835_thermal_realize;
>> +}
>> +
>> +static const TypeInfo bcm2835_thermal_info =3D {
>> +    .name =3D TYPE_BCM2835_THERMAL,
>> +    .parent =3D TYPE_SYS_BUS_DEVICE,
>> +    .instance_size =3D sizeof(Bcm2835ThermalState),
>> +    .class_init =3D bcm2835_thermal_class_init,
>> +};
>> +
>> +static void bcm2835_thermal_register_types(void)
>> +{
>> +    type_register_static(&bcm2835_thermal_info);
>> +}
>> +
>> +type_init(bcm2835_thermal_register_types)
>> diff --git a/include/hw/misc/bcm2835_thermal.h b/include/hw/misc/bcm28=
35_thermal.h
>> new file mode 100644
>> index 0000000000..f85cce7214
>> --- /dev/null
>> +++ b/include/hw/misc/bcm2835_thermal.h
>> @@ -0,0 +1,27 @@
>> +/*
>> + * BCM2835 dummy thermal sensor
>> + *
>> + * Copyright (C) 2019 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +#ifndef HW_MISC_BCM2835_THERMAL_H
>> +#define HW_MISC_BCM2835_THERMAL_H
>> +
>> +#include "hw/qdev-properties.h"
>> +#include "hw/sysbus.h"
>> +
>> +#define TYPE_BCM2835_THERMAL "bcm2835-thermal"
>> +
>> +#define BCM2835_THERMAL(obj) \
>> +    OBJECT_CHECK(Bcm2835ThermalState, (obj), TYPE_BCM2835_THERMAL)
>> +
>> +typedef struct {
>> +    /*< private >*/
>> +    SysBusDevice parent_obj;
>> +    /*< public >*/
>> +    MemoryRegion iomem;
>> +    uint32_t ctl;
>> +} Bcm2835ThermalState;
>> +
>> +#endif
>=20
> Otherwise:
>=20
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Thanks :)

