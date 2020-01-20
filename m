Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C85C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:50:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 137D522464
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sz2/LVcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137D522464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itYO1-0002c7-EM
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 09:50:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1itYMI-00016M-PK
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:48:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1itYMG-0005qp-OT
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:48:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56736
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1itYMG-0005pt-Jz
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579531729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LCID4O9pdX3MaXVpIrK5pXPLG9vP4LNisUEYHhVnul8=;
 b=Sz2/LVcOchjn1wso/EcuXxs1BZ00HpNSfqVyTJdOKxJW6M5dEB/5EuAex3zd25WG7BW14w
 /dfQdlJ5yzqCV0pkse9r9dQ0dRXdaxPHmeqAQJ720ahvp8AtZLcIMPPX69CGY6aWS5K7Vv
 mfcaVnwLlFgT0WNcjOxFbWdgJHnnBnU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-ZsDRN31KMjibvGGNFojBOQ-1; Mon, 20 Jan 2020 09:48:44 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FAF9107ACC4;
 Mon, 20 Jan 2020 14:48:43 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF04460BF7;
 Mon, 20 Jan 2020 14:48:36 +0000 (UTC)
Date: Mon, 20 Jan 2020 15:48:34 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v3 4/8] hw/avr: Add some Arduino boards
Message-ID: <20200120154834.2a39b08d@redhat.com>
In-Reply-To: <d5520e32-d111-ae71-f546-c3433dcdc9bd@redhat.com>
References: <20191229224505.24466-1-f4bug@amsat.org>
 <20191229224505.24466-5-f4bug@amsat.org>
 <20200120100335.58f1b7d2@redhat.com>
 <b8a453a4-0aaa-8f85-6073-62abd3f70393@redhat.com>
 <20200120110954.5b1dc3ce@redhat.com>
 <d5520e32-d111-ae71-f546-c3433dcdc9bd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ZsDRN31KMjibvGGNFojBOQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sarah Harris <S.E.Harris@kent.ac.uk>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?B?TWFy?= =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phillip Stevens <phillip.stevens@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 Jan 2020 12:05:24 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 1/20/20 11:09 AM, Igor Mammedov wrote:
> > On Mon, 20 Jan 2020 10:21:52 +0100
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> >  =20
> >> On 1/20/20 10:03 AM, Igor Mammedov wrote: =20
> >>> On Sun, 29 Dec 2019 23:45:01 +0100
> >>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> >>>     =20
> >>>> Arduino boards are build with AVR chipsets.
> >>>> Add some of the popular boards:
> >>>>
> >>>> - Arduino Duemilanove
> >>>> - Arduino Uno
> >>>> - Arduino Mega
> >>>>
> >>>> For more information:
> >>>>     https://www.arduino.cc/en/Main/Products
> >>>>     https://store.arduino.cc/arduino-genuino/most-popular
> >>>>
> >>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >>>> ---
> >>>> v2:
> >>>> - Reword description adding more information (Aleksandar)
> >>>> - Use DEFINE_TYPES (Igor)
> >>>>
> >>>> Cc: Phillip Stevens <phillip.stevens@gmail.com>
> >>>> Cc: Igor Mammedov <imammedo@redhat.com>
> >>>> ---
> >>>>    hw/avr/arduino.c     | 177 ++++++++++++++++++++++++++++++++++++++=
+++++
> >>>>    hw/avr/Makefile.objs |   1 +
> >>>>    2 files changed, 178 insertions(+)
> >>>>    create mode 100644 hw/avr/arduino.c
> >>>>
> >>>> diff --git a/hw/avr/arduino.c b/hw/avr/arduino.c
> >>>> new file mode 100644
> >>>> index 0000000000..ecaaa295d8
> >>>> --- /dev/null
> >>>> +++ b/hw/avr/arduino.c
> >>>> @@ -0,0 +1,177 @@
> >>>> +/*
> >>>> + * QEMU Arduino boards
> >>>> + *
> >>>> + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
> >>>> + *
> >>>> + * This work is licensed under the terms of the GNU GPLv2 or later.
> >>>> + * See the COPYING file in the top-level directory.
> >>>> + * SPDX-License-Identifier: GPL-2.0-or-later
> >>>> + */
> >>>> +
> >>>> +/* TODO: Implement the use of EXTRAM */
> >>>> +
> >>>> +#include "qemu/osdep.h"
> >>>> +#include "qemu-common.h"
> >>>> +#include "qapi/error.h"
> >>>> +#include "hw/boards.h"
> >>>> +#include "hw/loader.h"
> >>>> +#include "elf.h"
> >>>> +#include "atmega.h"
> >>>> +
> >>>> +typedef struct ArduinoMachineState { =20
> >>> [...] =20
> >>>> +    MemoryRegion extram;
> >>>> +} ArduinoMachineState;
> >>>> +
> >>>> +typedef struct ArduinoMachineClass { =20
> >>> [...] =20
> >>>> +    size_t extram_size; =20
> >>>
> >>> extfoo doesn't seem to be used in this patch =20
> >>
> >> Ah leftover from adapting from the 'sample' board which has SIZE_EXMEM=
=3D0
> >> so I ended removing a chunk and forgot this field.
> >>
> >> Can I add your R-b tag when respining this patch without the field? =
=20
> > sure =20
>=20
> Thanks!
>=20
> > later on we need to make up some generic way for machine to say that
> > -m is not supported to avoid useless/confusing option where board
> > doesn't care about it. =20
>=20
> Does that means that when running this machine with '-m 3G' on top your=
=20
> memdev series, QEMU will still allocate 3G of unnecessary RAM?

yep,
to refuse "-m" at all or make size checks earlier we need to
make boards declare supported sizes or provide check callback.

In this series, I was only adding checks in boards that were
missing checks to make sure boards will eventually error out
(far from ideal but refactoring checks is out of scope of my
series).


>=20
> >>>> +} ArduinoMachineClass;
> >>>> +
> >>>> +#define TYPE_ARDUINO_MACHINE \
> >>>> +        MACHINE_TYPE_NAME("arduino")
> >>>> +#define ARDUINO_MACHINE(obj) \
> >>>> +        OBJECT_CHECK(ArduinoMachineState, (obj), TYPE_ARDUINO_MACHI=
NE)
> >>>> +#define ARDUINO_MACHINE_CLASS(klass) \
> >>>> +        OBJECT_CLASS_CHECK(ArduinoMachineClass, (klass), TYPE_ARDUI=
NO_MACHINE)
> >>>> +#define ARDUINO_MACHINE_GET_CLASS(obj) \
> >>>> +        OBJECT_GET_CLASS(ArduinoMachineClass, (obj), TYPE_ARDUINO_M=
ACHINE)
> >>>> +
> >>>> +static void load_firmware(const char *firmware, uint64_t flash_size=
)
> >>>> +{
> >>>> +    const char *filename;
> >>>> +    int bytes_loaded;
> >>>> +
> >>>> +    /* Load firmware (contents of flash) trying to auto-detect form=
at */
> >>>> +    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware);
> >>>> +    if (filename =3D=3D NULL) {
> >>>> +        error_report("Unable to find %s", firmware);
> >>>> +        exit(1);
> >>>> +    }
> >>>> +
> >>>> +    bytes_loaded =3D load_elf(filename, NULL, NULL, NULL, NULL, NUL=
L, NULL,
> >>>> +                            0, EM_NONE, 0, 0);
> >>>> +    if (bytes_loaded < 0) {
> >>>> +        bytes_loaded =3D load_image_targphys(filename, OFFSET_CODE,=
 flash_size);
> >>>> +    }
> >>>> +    if (bytes_loaded < 0) {
> >>>> +        error_report("Unable to load firmware image %s as ELF or ra=
w binary",
> >>>> +                     firmware);
> >>>> +        exit(1);
> >>>> +    }
> >>>> +}
> >>>> +
> >>>> +static void arduino_machine_init(MachineState *machine)
> >>>> +{
> >>>> +    ArduinoMachineClass *amc =3D ARDUINO_MACHINE_GET_CLASS(machine)=
;
> >>>> +    ArduinoMachineState *ams =3D ARDUINO_MACHINE(machine);
> >>>> +
> >>>> +    sysbus_init_child_obj(OBJECT(machine), "mcu", &ams->mcu, sizeof=
(ams->mcu),
> >>>> +                          amc->mcu_type);
> >>>> +    object_property_set_uint(OBJECT(&ams->mcu), amc->xtal_hz,
> >>>> +                             "xtal-frequency-hz", &error_abort);
> >>>> +    object_property_set_bool(OBJECT(&ams->mcu), true, "realized",
> >>>> +                             &error_abort);
> >>>> +
> >>>> +    if (machine->firmware) {
> >>>> +        load_firmware(machine->firmware, memory_region_size(&ams->m=
cu.flash));
> >>>> +    }
> >>>> +}
> >>>> +
> >>>> +static void arduino_machine_class_init(ObjectClass *oc, void *data)
> >>>> +{
> >>>> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> >>>> +
> >>>> +    mc->init =3D arduino_machine_init;
> >>>> +    mc->default_cpus =3D 1;
> >>>> +    mc->min_cpus =3D mc->default_cpus;
> >>>> +    mc->max_cpus =3D mc->default_cpus;
> >>>> +    mc->no_floppy =3D 1;
> >>>> +    mc->no_cdrom =3D 1;
> >>>> +    mc->no_parallel =3D 1;
> >>>> +}
> >>>> +
> >>>> +static void arduino_duemilanove_class_init(ObjectClass *oc, void *d=
ata)
> >>>> +{
> >>>> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> >>>> +    ArduinoMachineClass *amc =3D ARDUINO_MACHINE_CLASS(oc);
> >>>> +
> >>>> +    /* https://www.arduino.cc/en/Main/ArduinoBoardDuemilanove */
> >>>> +    mc->desc        =3D "Arduino Duemilanove (ATmega168)",
> >>>> +    mc->alias       =3D "2009";
> >>>> +    amc->mcu_type   =3D TYPE_ATMEGA168_MCU;
> >>>> +    amc->xtal_hz    =3D 16 * 1000 * 1000;
> >>>> +};
> >>>> +
> >>>> +static void arduino_uno_class_init(ObjectClass *oc, void *data)
> >>>> +{
> >>>> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> >>>> +    ArduinoMachineClass *amc =3D ARDUINO_MACHINE_CLASS(oc);
> >>>> +
> >>>> +    /* https://store.arduino.cc/arduino-uno-rev3 */
> >>>> +    mc->desc        =3D "Arduino UNO (ATmega328P)";
> >>>> +    mc->alias       =3D "uno";
> >>>> +    amc->mcu_type   =3D TYPE_ATMEGA328_MCU;
> >>>> +    amc->xtal_hz    =3D 16 * 1000 * 1000;
> >>>> +};
> >>>> +
> >>>> +static void arduino_mega_class_init(ObjectClass *oc, void *data)
> >>>> +{
> >>>> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> >>>> +    ArduinoMachineClass *amc =3D ARDUINO_MACHINE_CLASS(oc);
> >>>> +
> >>>> +    /* https://www.arduino.cc/en/Main/ArduinoBoardMega */
> >>>> +    mc->desc        =3D "Arduino Mega (ATmega1280)";
> >>>> +    mc->alias       =3D "mega";
> >>>> +    amc->mcu_type   =3D TYPE_ATMEGA1280_MCU;
> >>>> +    amc->xtal_hz    =3D 16 * 1000 * 1000;
> >>>> +};
> >>>> +
> >>>> +static void arduino_mega2560_class_init(ObjectClass *oc, void *data=
)
> >>>> +{
> >>>> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> >>>> +    ArduinoMachineClass *amc =3D ARDUINO_MACHINE_CLASS(oc);
> >>>> +
> >>>> +    /* https://store.arduino.cc/arduino-mega-2560-rev3 */
> >>>> +    mc->desc        =3D "Arduino Mega 2560 (ATmega2560)";
> >>>> +    mc->alias       =3D "mega2560";
> >>>> +    mc->is_default  =3D true;
> >>>> +    amc->mcu_type   =3D TYPE_ATMEGA2560_MCU;
> >>>> +    amc->xtal_hz    =3D 16 * 1000 * 1000; /* CSTCE16M0V53-R0 */
> >>>> +};
> >>>> +
> >>>> +static const TypeInfo arduino_machine_types[] =3D {
> >>>> +    {
> >>>> +        .name          =3D MACHINE_TYPE_NAME("arduino-duemilanove")=
,
> >>>> +        .parent        =3D TYPE_ARDUINO_MACHINE,
> >>>> +        .class_init    =3D arduino_duemilanove_class_init,
> >>>> +    }, {
> >>>> +        .name          =3D MACHINE_TYPE_NAME("arduino-uno"),
> >>>> +        .parent        =3D TYPE_ARDUINO_MACHINE,
> >>>> +        .class_init    =3D arduino_uno_class_init,
> >>>> +    }, {
> >>>> +        .name          =3D MACHINE_TYPE_NAME("arduino-mega"),
> >>>> +        .parent        =3D TYPE_ARDUINO_MACHINE,
> >>>> +        .class_init    =3D arduino_mega_class_init,
> >>>> +    }, {
> >>>> +        .name          =3D MACHINE_TYPE_NAME("arduino-mega-2560-v3"=
),
> >>>> +        .parent        =3D TYPE_ARDUINO_MACHINE,
> >>>> +        .class_init    =3D arduino_mega2560_class_init,
> >>>> +    }, {
> >>>> +        .name           =3D TYPE_ARDUINO_MACHINE,
> >>>> +        .parent         =3D TYPE_MACHINE,
> >>>> +        .instance_size  =3D sizeof(ArduinoMachineState),
> >>>> +        .class_size     =3D sizeof(ArduinoMachineClass),
> >>>> +        .class_init     =3D arduino_machine_class_init,
> >>>> +        .abstract       =3D true,
> >>>> +    }
> >>>> +};
> >>>> +
> >>>> +DEFINE_TYPES(arduino_machine_types)
> >>>> diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
> >>>> index 4b6b911820..39ee3c32b2 100644
> >>>> --- a/hw/avr/Makefile.objs
> >>>> +++ b/hw/avr/Makefile.objs
> >>>> @@ -1,2 +1,3 @@
> >>>>    obj-y +=3D sample.o
> >>>>    obj-y +=3D atmega.o
> >>>> +obj-y +=3D arduino.o =20
> >>>
> >>>     =20
> >> =20
> >  =20
>=20


