Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09E2C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:02:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC212465E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3tAff2r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC212465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiF6n-0006yv-Ro
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 05:02:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iiF5y-0006XV-DG
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:01:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iiF5s-0003pi-8U
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:01:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21662
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iiF5r-0003kj-ST
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576836070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/99O1y5T3rg4A8lX54V5FCbLG1no9r3rUg3Ondcmp8s=;
 b=f3tAff2rWmQ1lIipQlrZLOJaZt3IXa5hc/mUjhcMAWot/7pUaj/eL764GBVP/JC9mhOBUb
 6kLVMEI+xpYQ3F7YkQvIun4MM0OS6fzojS43oorZKC80dYpFq34Q+ddSBk+l2jzHPFi+aU
 Qn9nDEm1eFYoatwkcVH7Los6mUJY92k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-sN14FnVaNgOeL4afW5TtFA-1; Fri, 20 Dec 2019 05:01:09 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15CBD107ACC9;
 Fri, 20 Dec 2019 10:01:07 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC0E41A7E3;
 Fri, 20 Dec 2019 10:01:01 +0000 (UTC)
Date: Fri, 20 Dec 2019 11:01:00 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH 07/10] hw/avr: Add few Arduino boards
Message-ID: <20191220110100.4528a3ea@redhat.com>
In-Reply-To: <20191128015030.27543-8-f4bug@amsat.org>
References: <20191128015030.27543-1-f4bug@amsat.org>
 <20191128015030.27543-8-f4bug@amsat.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: sN14FnVaNgOeL4afW5TtFA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Thomas Huth <huth@tuxfamily.org>, Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 Nov 2019 02:50:27 +0100
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Add famous Arduino boards:
>=20
> - Arduino Duemilanove
> - Arduino Mega
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/avr/arduino.c     | 173 +++++++++++++++++++++++++++++++++++++++++++
>  hw/avr/Makefile.objs |   1 +
>  2 files changed, 174 insertions(+)
>  create mode 100644 hw/avr/arduino.c
>=20
> diff --git a/hw/avr/arduino.c b/hw/avr/arduino.c
> new file mode 100644
> index 0000000000..191193d614
> --- /dev/null
> +++ b/hw/avr/arduino.c
> @@ -0,0 +1,173 @@
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
> +#include "qemu-common.h"
> +#include "qapi/error.h"
> +#include "hw/boards.h"
> +#include "hw/loader.h"
> +#include "elf.h"
> +#include "atmega.h"
> +
> +typedef struct ArduinoBoardConfig {
> +    const char *name;
> +    const char *desc;
> +    const char *alias;
> +    const char *mcu_type;
> +    uint64_t xtal_hz;
> +    size_t extram_size;
> +    bool is_default;
> +} ArduinoBoardConfig;
> +
> +static const ArduinoBoardConfig arduino_boards[] =3D {
> +    {
> +        /* https://www.arduino.cc/en/Main/ArduinoBoardDuemilanove */
> +        .name       =3D MACHINE_TYPE_NAME("arduino-duemilanove"),
> +        .desc       =3D "Arduino Duemilanove (ATmega168)",
> +        .alias      =3D "2009",
> +        .mcu_type    =3D TYPE_ATMEGA168,
> +        .xtal_hz    =3D 16 * 1000 * 1000,
> +    }, {
> +        /* https://store.arduino.cc/arduino-uno-rev3 */
> +        .name       =3D MACHINE_TYPE_NAME("arduino-uno"),
> +        .desc       =3D "Arduino Duemilanove (ATmega328P)",
> +        .alias      =3D "UNO",
> +        .mcu_type    =3D TYPE_ATMEGA328,
> +        .xtal_hz    =3D 16 * 1000 * 1000,
> +    }, {
> +        /* https://www.arduino.cc/en/Main/ArduinoBoardMega */
> +        .name       =3D MACHINE_TYPE_NAME("arduino-mega"),
> +        .desc       =3D "Arduino Mega (ATmega1280)",
> +        .alias      =3D "MEGA",
> +        .mcu_type    =3D TYPE_ATMEGA1280,
> +        .xtal_hz    =3D 16 * 1000 * 1000,
> +    }, {
> +        /* https://store.arduino.cc/arduino-mega-2560-rev3 */
> +        .name       =3D MACHINE_TYPE_NAME("arduino-mega-2560-v3"),
> +        .desc       =3D "Arduino Mega 2560 (ATmega2560)",
> +        .alias      =3D "MEGA2560",
> +        .mcu_type    =3D TYPE_ATMEGA2560,
> +        .xtal_hz    =3D 16 * 1000 * 1000, /* CSTCE16M0V53-R0 */
> +        .is_default =3D true,
> +    },
> +};

It's common pre QOM pattern, but it would be better use machine class
for defining machine properties. See
 baa4732bc10b3fd7 aspeed: Remove AspeedBoardConfig array and use AspeedMach=
ineClass
that recently did conversion.


> +
> +typedef struct ArduinoMachineState {
> +    /*< private >*/
> +    MachineState parent_obj;
> +    /*< public >*/
> +    AtmegaState mcu;
> +    MemoryRegion extram;
> +} ArduinoMachineState;
> +
> +typedef struct ArduinoMachineClass {
> +    /*< private >*/
> +    MachineClass parent_class;
> +    /*< public >*/
> +    const ArduinoBoardConfig *config;
> +} ArduinoMachineClass;
> +
> +#define TYPE_ARDUINO_MACHINE \
> +        MACHINE_TYPE_NAME("arduino")
> +#define ARDUINO_MACHINE(obj) \
> +        OBJECT_CHECK(ArduinoMachineState, (obj), TYPE_ARDUINO_MACHINE)
> +#define ARDUINO_MACHINE_CLASS(klass) \
> +        OBJECT_CLASS_CHECK(ArduinoMachineClass, (klass), TYPE_ARDUINO_MA=
CHINE)
> +#define ARDUINO_MACHINE_GET_CLASS(obj) \
> +        OBJECT_GET_CLASS(ArduinoMachineClass, (obj), TYPE_ARDUINO_MACHIN=
E)
> +
> +static void load_firmware(const char *firmware, uint64_t flash_size)
> +{
> +    const char *filename;
> +    int bytes_loaded;
> +
> +    /* Load firmware (contents of flash) trying to auto-detect format */
> +    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware);
> +    if (filename =3D=3D NULL) {
> +        error_report("Unable to find %s", firmware);
> +        exit(1);
> +    }
> +
> +    bytes_loaded =3D load_elf(filename, NULL, NULL, NULL, NULL, NULL, NU=
LL,
> +                            0, EM_NONE, 0, 0);
> +    if (bytes_loaded < 0) {
> +        bytes_loaded =3D load_image_targphys(filename, OFFSET_CODE, flas=
h_size);
> +    }
> +    if (bytes_loaded < 0) {
> +        error_report("Unable to load firmware image %s as ELF or raw bin=
ary",
> +                     firmware);
> +        exit(1);
> +    }
> +}
> +
> +static void arduino_machine_init(MachineState *machine)
> +{
> +    ArduinoMachineClass *amc =3D ARDUINO_MACHINE_GET_CLASS(machine);
> +    ArduinoMachineState *ams =3D ARDUINO_MACHINE(machine);
> +
> +    sysbus_init_child_obj(OBJECT(machine), "mcu", &ams->mcu, sizeof(ams-=
>mcu),
> +                          amc->config->mcu_type);
> +    object_property_set_uint(OBJECT(&ams->mcu), amc->config->xtal_hz,
> +                             "xtal-frequency-hz", &error_abort);
> +    object_property_set_bool(OBJECT(&ams->mcu), true, "realized",
> +                             &error_abort);
> +
> +    if (machine->firmware) {
> +        load_firmware(machine->firmware, memory_region_size(&ams->mcu.fl=
ash));
> +    }
> +}
> +
> +static void arduino_machine_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +    ArduinoMachineClass *amc =3D ARDUINO_MACHINE_CLASS(oc);
> +    const ArduinoBoardConfig *cfg =3D data;
> +
> +    mc->desc =3D cfg->desc;
> +    mc->alias =3D cfg->alias;
> +    mc->init =3D arduino_machine_init;
> +    mc->default_cpus =3D 1;
> +    mc->min_cpus =3D mc->default_cpus;
> +    mc->max_cpus =3D mc->default_cpus;
> +    mc->no_floppy =3D 1;
> +    mc->no_cdrom =3D 1;
> +    mc->no_parallel =3D 1;
> +    mc->is_default =3D cfg->is_default;
> +    mc->default_ram_size =3D cfg->extram_size;
> +    amc->config =3D cfg;
> +}
> +
> +static const TypeInfo arduino_machine_type =3D {
> +    .name =3D TYPE_ARDUINO_MACHINE,
> +    .parent =3D TYPE_MACHINE,
> +    .instance_size =3D sizeof(ArduinoMachineState),
> +    .class_size =3D sizeof(ArduinoMachineClass),
> +    .abstract =3D true,
> +};
> +
> +static void arduino_machine_types(void)
> +{
> +    size_t i;
> +
> +    type_register_static(&arduino_machine_type);
> +    for (i =3D 0; i < ARRAY_SIZE(arduino_boards); ++i) {
> +        TypeInfo ti =3D {
> +            .name       =3D arduino_boards[i].name,
> +            .parent     =3D TYPE_ARDUINO_MACHINE,
> +            .class_init =3D arduino_machine_class_init,
> +            .class_data =3D (void *)&arduino_boards[i],
> +        };
> +        type_register(&ti);
> +    }
> +}
> +
> +type_init(arduino_machine_types)
> diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
> index 4b6b911820..39ee3c32b2 100644
> --- a/hw/avr/Makefile.objs
> +++ b/hw/avr/Makefile.objs
> @@ -1,2 +1,3 @@
>  obj-y +=3D sample.o
>  obj-y +=3D atmega.o
> +obj-y +=3D arduino.o


