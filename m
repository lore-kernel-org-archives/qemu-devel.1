Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BDFC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 10:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2993920658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 10:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JL4GvZvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2993920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyYhC-0007sv-Ac
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 05:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iyYgT-00073C-5q
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:10:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iyYgR-0005BX-LC
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:10:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34265
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iyYgR-00059s-Gu
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580724622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NokHOPLkF79HUmVBRXwt5uInhUO8htWfvwWVOlhqyWE=;
 b=JL4GvZvOiVt+AiQZsCjQLE+RLcEVJYTs0oXLVZTguED+ncZWFvo7ekdIYg68L8EDS33XXr
 1Df+HtXIV76SDvNY4uN+hHCU7hi//c1XTF5ngLrzWJLW7rBcUOcaG6Mg3VnbSCzu88QyeS
 Bz2+vhkNkRdyqdEJNvTYur1FzQKWEYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-POtdVb0UMtWVkQJromBpOA-1; Mon, 03 Feb 2020 05:10:19 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16F9B801E6C;
 Mon,  3 Feb 2020 10:10:18 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E6602166BE;
 Mon,  3 Feb 2020 10:10:13 +0000 (UTC)
Date: Mon, 3 Feb 2020 11:10:12 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PATCH 5/6] hw/arm/raspi: Dynamically create machines based on
 the board revision
Message-ID: <20200203111012.0ab38555@redhat.com>
In-Reply-To: <20200203082619.7426-6-f4bug@amsat.org>
References: <20200203082619.7426-1-f4bug@amsat.org>
 <20200203082619.7426-6-f4bug@amsat.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: POtdVb0UMtWVkQJromBpOA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  3 Feb 2020 09:26:18 +0100
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> We added tiny helpers extracting different values from the board
> revision, we can now create a full board based on its revision.
> The 'raspi-common' type is common to all raspi boards.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/raspi.c | 93 +++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 62 insertions(+), 31 deletions(-)
>=20
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 656d834e07..12dc4d1486 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -44,12 +44,17 @@ static const struct {
>      [C_BCM2837] =3D {TYPE_BCM2837},
>  };
> =20
> -typedef struct RasPiState {
> +typedef struct RaspiMachineState {
> +    /*< private >*/
> +    MachineState parent_obj;
> +    /*< public >*/
>      BCM283XState soc;
>      MemoryRegion ram;
> -} RasPiState;
> +} RaspiMachineState;
> =20
>  typedef struct RaspiBoardInfo {
> +    const char *name;
> +    const char *desc;
>      /*
>       * Board revision codes:
>       * www.raspberrypi.org/documentation/hardware/raspberrypi/revision-c=
odes/
> @@ -57,16 +62,32 @@ typedef struct RaspiBoardInfo {
>      uint32_t board_rev;
>  } RaspiBoardInfo;
> =20
> -enum { BOARD_PI2, BOARD_PI3 };
> +typedef struct RaspiMachineClass {
> +    /*< private >*/
> +    MachineClass parent_obj;
> +    /*< public >*/
> +    const RaspiBoardInfo *config;
> +} RaspiMachineClass;
> +
> +#define TYPE_RASPI_MACHINE       MACHINE_TYPE_NAME("raspi-common")
> +#define RASPI_MACHINE(obj) \
> +    OBJECT_CHECK(RaspiMachineState, (obj), TYPE_RASPI_MACHINE)
> +
> +#define RASPI_MACHINE_CLASS(klass) \
> +     OBJECT_CLASS_CHECK(RaspiMachineClass, (klass), TYPE_RASPI_MACHINE)
> +#define RASPI_MACHINE_GET_CLASS(obj) \
> +     OBJECT_GET_CLASS(RaspiMachineClass, (obj), TYPE_RASPI_MACHINE)
> =20
>  static const RaspiBoardInfo raspi_boards[] =3D {
> -    [BOARD_PI2] =3D
>      {
> +        .name =3D MACHINE_TYPE_NAME("raspi2"),
> +        .desc =3D "Raspberry Pi 2B",
>          .board_rev =3D 0xa21041,
>      },
>  #ifdef TARGET_AARCH64
> -    [BOARD_PI3] =3D
>      {
> +        .name =3D MACHINE_TYPE_NAME("raspi3"),
> +        .desc =3D "Raspberry Pi 3B",
>          .board_rev =3D 0xa02082,
>      },
>  #endif
> @@ -221,7 +242,7 @@ static void setup_boot(MachineState *machine, int ver=
sion, size_t ram_size)
> =20
>  static void raspi_init(MachineState *machine, const RaspiBoardInfo *conf=
ig)
>  {
> -    RasPiState *s =3D g_new0(RasPiState, 1);
> +    RaspiMachineState *s =3D RASPI_MACHINE(machine);
>      int version =3D board_version(config);
>      uint32_t vcram_size;
>      DriveInfo *di;
> @@ -271,15 +292,22 @@ static void raspi_init(MachineState *machine, const=
 RaspiBoardInfo *config)
>      setup_boot(machine, version, machine->ram_size - vcram_size);
>  }
> =20
> -static void raspi2_init(MachineState *machine)
> +static void raspi_machine_init(MachineState *machine)
>  {
> -    raspi_init(machine, &raspi_boards[BOARD_PI2]);
> +    RaspiMachineClass *rmc =3D RASPI_MACHINE_GET_CLASS(machine);
> +
> +    raspi_init(machine, rmc->config);
>  }
> =20
> -static void raspi2_machine_init(MachineClass *mc)
> +static void raspi_machine_class_init(ObjectClass *oc, void *data)
>  {
> -    mc->desc =3D "Raspberry Pi 2";
> -    mc->init =3D raspi2_init;
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +    RaspiMachineClass *rmc =3D RASPI_MACHINE_CLASS(oc);
> +    const RaspiBoardInfo *config =3D data;
> +
> +    rmc->config =3D config;
> +    mc->desc =3D config->desc;
> +    mc->init =3D raspi_machine_init;
>      mc->block_default_type =3D IF_SD;
>      mc->no_parallel =3D 1;
>      mc->no_floppy =3D 1;
> @@ -287,29 +315,32 @@ static void raspi2_machine_init(MachineClass *mc)
>      mc->max_cpus =3D BCM283X_NCPUS;
>      mc->min_cpus =3D BCM283X_NCPUS;
>      mc->default_cpus =3D BCM283X_NCPUS;
> -    mc->default_ram_size =3D 1 * GiB;
> +    mc->default_ram_size =3D board_ram_size(config);
>      mc->ignore_memory_transaction_failures =3D true;
> +}
> +
> +static const TypeInfo raspi_machine_type =3D {
> +    .name =3D TYPE_RASPI_MACHINE,
> +    .parent =3D TYPE_MACHINE,
> +    .instance_size =3D sizeof(RaspiMachineState),
> +    .class_size =3D sizeof(RaspiMachineClass),
> +    .abstract =3D true,
>  };
> -DEFINE_MACHINE("raspi2", raspi2_machine_init)
> =20
> -#ifdef TARGET_AARCH64
> -static void raspi3_init(MachineState *machine)
> +static void raspi_machine_types(void)
>  {
> -    raspi_init(machine, &raspi_boards[BOARD_PI3]);
> +    int i;
> +
> +    type_register_static(&raspi_machine_type);
> +    for (i =3D 0; i < ARRAY_SIZE(raspi_boards); ++i) {
> +        TypeInfo ti =3D {
> +            .name       =3D raspi_boards[i].name,
> +            .parent     =3D TYPE_RASPI_MACHINE,
> +            .class_init =3D raspi_machine_class_init,
> +            .class_data =3D (void *)&raspi_boards[i],
> +        };
> +        type_register(&ti);
> +    }

from what I've seen we do something like this in cases where
we need to generate a lot of classes based on data.

The thing is that it's harder to deal with compared to typical
template where one defines machine classes and per machine
type foo_class_init() functions. Yes it's a bit more boiler
plate but it's what is typically used/consistent with machine types.
So if one would have touch touch that future, one wouldn't have
to wrap their brain around yet another way to define machine.

>  }
> =20
> -static void raspi3_machine_init(MachineClass *mc)
> -{
> -    mc->desc =3D "Raspberry Pi 3";
> -    mc->init =3D raspi3_init;
> -    mc->block_default_type =3D IF_SD;
> -    mc->no_parallel =3D 1;
> -    mc->no_floppy =3D 1;
> -    mc->no_cdrom =3D 1;
> -    mc->max_cpus =3D BCM283X_NCPUS;
> -    mc->min_cpus =3D BCM283X_NCPUS;
> -    mc->default_cpus =3D BCM283X_NCPUS;
> -    mc->default_ram_size =3D 1 * GiB;
> -}
> -DEFINE_MACHINE("raspi3", raspi3_machine_init)
> -#endif
> +type_init(raspi_machine_types)


