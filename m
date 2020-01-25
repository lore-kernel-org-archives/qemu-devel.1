Return-Path: <SRS0=4gpF=3O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3742C35242
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 09:53:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78C152071A
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 09:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xcancerberox.com.ar header.i=@xcancerberox.com.ar header.b="f87ypW1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C152071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xcancerberox.com.ar
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivHvZ-0002Z5-AU
	for qemu-devel@archiver.kernel.org; Sat, 25 Jan 2020 04:40:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <me@xcancerberox.com.ar>) id 1ivHuN-00026F-Af
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 04:39:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <me@xcancerberox.com.ar>) id 1ivHuL-0007tN-Kv
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 04:39:15 -0500
Received: from [51.158.76.159] (port=37974 helo=mail.xcancerberox.com.ar)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <me@xcancerberox.com.ar>)
 id 1ivHuL-0007no-2q; Sat, 25 Jan 2020 04:39:13 -0500
Subject: Re: [PATCH rc2 21/25] hw/avr: Add some Arduino boards
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xcancerberox.com.ar;
 s=mail; t=1579944749;
 bh=/v+mWBauk8doqq1EaqiCvFpU4WwDVqQApuraYsc20zM=;
 h=Subject:To:Cc:References:From:In-Reply-To;
 b=f87ypW1u09V7VFwekFI3U+Rs3zoY2/5uqbuhqwR8b10ZXsqRZAVHLBkfrBH9/eHdj
 OGXxZooaQHJuzEjdjc0nUmc+QmuGT7r0r7UhMbUCJ01/ev2BMxMsjrBpEJ/mGV2ISo
 kBrlz1NWmsCQVDzo8Hd1rHqc6rG9Wx7e6zRwkyXfkKMdQmyrtX1CJlBUPl/JgoRQAY
 pgRf+Z/FQt+pS8vJVpOtQViClL3UANG+hotf94XSyZaGo+HWMrh+v4Yv5o9wFHuzrI
 SWE4v/GcJdPvkAJj9t2aUjwUL/bPL35JLk3LApjuhhp4u88ukIHUT9Hd373ZAAe6pP
 7WL5dkoQ+hzkA==
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, mrolnik@gmail.com, richard.henderson@linaro.org
References: <20200124005131.16276-1-f4bug@amsat.org>
 <20200124005131.16276-22-f4bug@amsat.org>
From: Joaquin de Andres <me@xcancerberox.com.ar>
Openpgp: preference=signencrypt
Autocrypt: addr=me@xcancerberox.com.ar; keydata=
 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
 OZRo+ULKJ1xXuVGe8hnP9Q==
Message-ID: <99d4c4d3-8cbd-9a92-13f5-b73e06ddfb17@xcancerberox.com.ar>
Date: Sat, 25 Jan 2020 10:32:26 +0100
Mime-Version: 1.0
In-Reply-To: <20200124005131.16276-22-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 51.158.76.159
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 S.E.Harris@kent.ac.uk, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, dovgaluk@ispras.ru,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, thuth@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, imammedo@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/24/20 1:51 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Arduino boards are build with AVR chipsets.
> Add some of the popular boards:
>=20
> - Arduino Duemilanove
> - Arduino Uno
> - Arduino Mega
>=20
> For more information:
>   https://www.arduino.cc/en/Main/Products
>   https://store.arduino.cc/arduino-genuino/most-popular
>=20
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Message-Id: <20200120220107.17825-15-f4bug@amsat.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> rc2:
> - Use avr_load_firmware (Aleksandar)
> - No default machine on AVR (Richard)
> - Add entry in MAINTAINERS (Michael is still the maintainer of hw/avr/)
> ---
>  hw/avr/arduino.c     | 151 +++++++++++++++++++++++++++++++++++++++++++
>  MAINTAINERS          |   6 ++
>  hw/avr/Kconfig       |   4 ++
>  hw/avr/Makefile.objs |   1 +
>  4 files changed, 162 insertions(+)
>  create mode 100644 hw/avr/arduino.c
>=20
> diff --git a/hw/avr/arduino.c b/hw/avr/arduino.c
> new file mode 100644
> index 0000000000..2fb2e96ffe
> --- /dev/null
> +++ b/hw/avr/arduino.c
> @@ -0,0 +1,151 @@
> +/*
> + * QEMU Arduino boards
> + *
> + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
> + *
> + * This work is licensed under the terms of the GNU GPLv2 or later.
> + * See the COPYING file in the top-level directory.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +/* TODO: Implement the use of EXTRAM */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/boards.h"
> +#include "atmel_atmega.h"
> +#include "boot.h"
> +
> +typedef struct ArduinoMachineState {
> +    /*< private >*/
> +    MachineState parent_obj;
> +    /*< public >*/
> +    AtmegaMcuState mcu;
> +} ArduinoMachineState;
> +
> +typedef struct ArduinoMachineClass {
> +    /*< private >*/
> +    MachineClass parent_class;
> +    /*< public >*/
> +    const char *mcu_type;
> +    uint64_t xtal_hz;
> +} ArduinoMachineClass;
> +
> +#define TYPE_ARDUINO_MACHINE \
> +        MACHINE_TYPE_NAME("arduino")
> +#define ARDUINO_MACHINE(obj) \
> +        OBJECT_CHECK(ArduinoMachineState, (obj), TYPE_ARDUINO_MACHINE)
> +#define ARDUINO_MACHINE_CLASS(klass) \
> +        OBJECT_CLASS_CHECK(ArduinoMachineClass, (klass), TYPE_ARDUINO_=
MACHINE)
> +#define ARDUINO_MACHINE_GET_CLASS(obj) \
> +        OBJECT_GET_CLASS(ArduinoMachineClass, (obj), TYPE_ARDUINO_MACH=
INE)
> +
> +static void arduino_machine_init(MachineState *machine)
> +{
> +    ArduinoMachineClass *amc =3D ARDUINO_MACHINE_GET_CLASS(machine);
> +    ArduinoMachineState *ams =3D ARDUINO_MACHINE(machine);
> +
> +    sysbus_init_child_obj(OBJECT(machine), "mcu", &ams->mcu, sizeof(am=
s->mcu),
> +                          amc->mcu_type);
> +    object_property_set_uint(OBJECT(&ams->mcu), amc->xtal_hz,
> +                             "xtal-frequency-hz", &error_abort);
> +    object_property_set_bool(OBJECT(&ams->mcu), true, "realized",
> +                             &error_abort);
> +
> +    if (machine->firmware) {
> +        if (!avr_load_firmware(&ams->mcu.cpu, machine,
> +                               &ams->mcu.flash, machine->firmware)) {
> +            exit(1);
> +        }
> +    }
> +}
> +
> +static void arduino_machine_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
> +    mc->init =3D arduino_machine_init;
> +    mc->default_cpus =3D 1;
> +    mc->min_cpus =3D mc->default_cpus;
> +    mc->max_cpus =3D mc->default_cpus;
> +    mc->no_floppy =3D 1;
> +    mc->no_cdrom =3D 1;
> +    mc->no_parallel =3D 1;
> +}
> +
> +static void arduino_duemilanove_class_init(ObjectClass *oc, void *data=
)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +    ArduinoMachineClass *amc =3D ARDUINO_MACHINE_CLASS(oc);
> +
> +    /* https://www.arduino.cc/en/Main/ArduinoBoardDuemilanove */
> +    mc->desc        =3D "Arduino Duemilanove (ATmega168)",
> +    mc->alias       =3D "2009";
> +    amc->mcu_type   =3D TYPE_ATMEGA168_MCU;
> +    amc->xtal_hz    =3D 16 * 1000 * 1000;
> +};

Hi! According to the page this board could be used with Atmega328 too.
Maybe you can define both?

The rest of this patch looks good to me, so:
Reviewed-by: Joaquin de Andres <me@xcancerberox.com.ar>

> +
> +static void arduino_uno_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +    ArduinoMachineClass *amc =3D ARDUINO_MACHINE_CLASS(oc);
> +
> +    /* https://store.arduino.cc/arduino-uno-rev3 */
> +    mc->desc        =3D "Arduino UNO (ATmega328P)";
> +    mc->alias       =3D "uno";
> +    amc->mcu_type   =3D TYPE_ATMEGA328_MCU;
> +    amc->xtal_hz    =3D 16 * 1000 * 1000;
> +};
> +
> +static void arduino_mega_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +    ArduinoMachineClass *amc =3D ARDUINO_MACHINE_CLASS(oc);
> +
> +    /* https://www.arduino.cc/en/Main/ArduinoBoardMega */
> +    mc->desc        =3D "Arduino Mega (ATmega1280)";
> +    mc->alias       =3D "mega";
> +    amc->mcu_type   =3D TYPE_ATMEGA1280_MCU;
> +    amc->xtal_hz    =3D 16 * 1000 * 1000;
> +};
> +
> +static void arduino_mega2560_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +    ArduinoMachineClass *amc =3D ARDUINO_MACHINE_CLASS(oc);
> +
> +    /* https://store.arduino.cc/arduino-mega-2560-rev3 */
> +    mc->desc        =3D "Arduino Mega 2560 (ATmega2560)";
> +    mc->alias       =3D "mega2560";
> +    amc->mcu_type   =3D TYPE_ATMEGA2560_MCU;
> +    amc->xtal_hz    =3D 16 * 1000 * 1000; /* CSTCE16M0V53-R0 */
> +};
> +
> +static const TypeInfo arduino_machine_types[] =3D {
> +    {
> +        .name          =3D MACHINE_TYPE_NAME("arduino-duemilanove"),
> +        .parent        =3D TYPE_ARDUINO_MACHINE,
> +        .class_init    =3D arduino_duemilanove_class_init,
> +    }, {
> +        .name          =3D MACHINE_TYPE_NAME("arduino-uno"),
> +        .parent        =3D TYPE_ARDUINO_MACHINE,
> +        .class_init    =3D arduino_uno_class_init,
> +    }, {
> +        .name          =3D MACHINE_TYPE_NAME("arduino-mega"),
> +        .parent        =3D TYPE_ARDUINO_MACHINE,
> +        .class_init    =3D arduino_mega_class_init,
> +    }, {
> +        .name          =3D MACHINE_TYPE_NAME("arduino-mega-2560-v3"),
> +        .parent        =3D TYPE_ARDUINO_MACHINE,
> +        .class_init    =3D arduino_mega2560_class_init,
> +    }, {
> +        .name           =3D TYPE_ARDUINO_MACHINE,
> +        .parent         =3D TYPE_MACHINE,
> +        .instance_size  =3D sizeof(ArduinoMachineState),
> +        .class_size     =3D sizeof(ArduinoMachineClass),
> +        .class_init     =3D arduino_machine_class_init,
> +        .abstract       =3D true,
> +    }
> +};
> +
> +DEFINE_TYPES(arduino_machine_types)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 066515ac8e..07c8912489 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -904,6 +904,12 @@ F: hw/misc/atmel_power.c
>  F: include/hw/misc/atmel_power.h
>  F: tests/acceptance/machine_avr6.py
> =20
> +Arduino
> +M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> +S: Maintained
> +F: hw/avr/arduino.c
> +F: hw/avr/atmel_atmega.*
> +
>  CRIS Machines
>  -------------
>  Axis Dev88
> diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
> index da3b10afec..59d9649d27 100644
> --- a/hw/avr/Kconfig
> +++ b/hw/avr/Kconfig
> @@ -3,3 +3,7 @@ config ATMEL_ATMEGA_MCU
>      select ATMEL_TIMER16
>      select ATMEL_USART
>      select ATMEL_POWER
> +
> +config ARDUINO
> +    select ATMEL_ATMEGA_MCU
> +    select UNIMP
> diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
> index 1f73fd5469..c8a131923c 100644
> --- a/hw/avr/Makefile.objs
> +++ b/hw/avr/Makefile.objs
> @@ -1,2 +1,3 @@
>  obj-y +=3D boot.o
>  obj-$(CONFIG_ATMEL_ATMEGA_MCU) +=3D atmel_atmega.o
> +obj-$(CONFIG_ARDUINO) +=3D arduino.o
>=20

