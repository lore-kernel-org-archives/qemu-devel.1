Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB8AC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:05:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6757921655
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UsTd5UnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6757921655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJpw-0005E7-FI
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 10:05:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iiJp7-0004Xw-Ki
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:04:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iiJp4-0006LZ-Nt
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:04:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34914
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iiJp4-0006KF-Ie
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576854249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/vaXsYKYoUj2xstr6J6sC3/RutsAC4Dk8zZS6vlBD2g=;
 b=UsTd5UnF/jHhAd04PIf9BjJygBiBhvKEnS+b1hnMnwbHht/fEN3Ax8iFqZ8P8Q9qBEuxZV
 Mlrh5V00SwNmCt1IULTWsBpnGg7kDyBvjaXFeUq3oXNshTmWMTpZJggObjUyInxsg0QK/g
 mWG+UW76NlgKj0T2ZmdQTkw1uk1elI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-wyqBChMjM06ZfQh7m1VYDA-1; Fri, 20 Dec 2019 10:03:53 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E257D801E78;
 Fri, 20 Dec 2019 15:03:51 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C47311001B00;
 Fri, 20 Dec 2019 15:03:44 +0000 (UTC)
Date: Fri, 20 Dec 2019 16:03:41 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [RFC PATCH 06/10] hw/avr: Add ATmega microcontrollers
Message-ID: <20191220160341.4c362d8d@redhat.com>
In-Reply-To: <c8361b39-478e-ceec-0ea1-cc3c9ce8d6c9@redhat.com>
References: <20191128015030.27543-1-f4bug@amsat.org>
 <20191128015030.27543-7-f4bug@amsat.org>
 <20191220110917.3fccb284@redhat.com>
 <c8361b39-478e-ceec-0ea1-cc3c9ce8d6c9@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: wyqBChMjM06ZfQh7m1VYDA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 Sarah Harris <S.E.Harris@kent.ac.uk>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Thomas Huth <huth@tuxfamily.org>, Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Dec 2019 13:58:29 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Hi Igor,
>=20
> On 12/20/19 11:09 AM, Igor Mammedov wrote:
> > On Thu, 28 Nov 2019 02:50:26 +0100
> > Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> >  =20
> >> Add famous ATmega MCUs:
> >>
> >> - middle range: ATmega168 and ATmega328
> >> - high range: ATmega1280 and ATmega2560
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> ---
[...]
> >> +static void atmega_realize(DeviceState *dev, Error **errp)
> >> +{
> >> +    AtmegaState *s =3D ATMEGA(dev);
> >> +    AtmegaClass *bc =3D ATMEGA_GET_CLASS(dev);
> >> +    const AtmegaInfo *info =3D bc->info;
> >> +    DeviceState *cpudev;
> >> +    SysBusDevice *sbd;
> >> +    Error *err =3D NULL;
> >> +    char *devname;
> >> +    size_t i;
> >> +
> >> +    if (!s->xtal_freq_hz) {
> >> +        error_setg(errp, "\"xtal-frequency-hz\" property must be prov=
ided.");
> >> +        return;
> >> +    }
> >> +
> >> +    /* CPU */
> >> +    object_initialize_child(OBJECT(dev), "cpu", &s->cpu, sizeof(s->cp=
u),
> >> +                            info->cpu_type, &err, NULL);
> >> +    if (err) {
> >> +        error_propagate(errp, err);
> >> +        return;
> >> +    }
> >> +    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &erro=
r_abort);
> >> +    cpudev =3D DEVICE(&s->cpu);
> >> +
> >> +    /* SRAM */
> >> +    memory_region_allocate_system_memory(&s->sram, OBJECT(dev),
> >> +                                         "sram", info->sram_size); =
=20
> > with main RAM conversion to hostmem backend, this API will go away
> > and RAM memory region will be allocated by generic machine code
> > and shall be treated as backend. Users would be able to access it
> > via MachineState::ram memory region.
> >=20
> > Meanwhile I'd suggest to move this line to arduino_machine_init()
> > and pass it to MCU as a link property. =20
>=20
> Thanks for reviewing this patch.
>=20
> I think this MCU and few ARM SoC are good case for your RAM conversion.
>=20
> These chipsets provide onboard RAM (SRAM). This amount of SRAM is enough=
=20
> to run u-boot, FreeRTOS, ... Some ARM boards add DRAM, usually larger=20
> than the SRAM amount.
>=20
> The previous recomendation was to use=20
> memory_region_allocate_system_memory() only once, but on the biggest=20
> chunk of memory, for performance reasons.
that makes sense only if flexibility is necessary (mem-path, binding to num=
a nodes, prealloc, ...)
Do we really  care about it in non virt usecases.
=20
> In the previous cases, the RAM is not added by the board/machine, but is=
=20
> present in the MCU/SoC. This looks incorrect to me to allocate the RAM=20
> in the board/machine and pass it to the MCU/SoC.
If it's not user specified value but a fixed memory embedded in SoC,
I'd for simplicity use memory_region_init_ram() directly
(which some boards do for built-in sram).
=20
> You are saying the machine/board code will have to ask its children how=
=20
> many ram they need, then allocate, then pass it to each?
machine code will use -m value (and that defaults to default_ram_size,
which board can override) or user provided memdev.

On board side, one could check if user provided backend is suitable and
refuse to start asking to correct CLI error.

So we are still talking about single backend RAM blob, which boards
could use as is or partition with aliases (x86) or map to some other
front-end devices. (point is not to mix device model with backend in this c=
ase)


> > Also use MachineState::ram_size and add check that it matches mc->defau=
lt_ram_size.
> > Ex: https://github.com/imammedo/qemu/commit/241c65d506ccba1e0239a2bc063=
2d7dc9c3517c1
> >  =20
> >> +    memory_region_add_subregion(get_system_memory(),
> >> +                                OFFSET_DATA + 0x200, &s->sram);
> >> +
> >> +    /* Flash */
> >> +    memory_region_init_rom(&s->flash, OBJECT(dev),
> >> +                           "flash", info->flash_size, &error_fatal);
> >> +    memory_region_add_subregion(get_system_memory(), OFFSET_CODE, &s-=
>flash);
> >> +
[...]


