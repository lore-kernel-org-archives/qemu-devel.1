Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2ADC352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 09:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 680A42080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 09:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CsWJl2QL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680A42080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j15ed-000228-Kp
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 04:46:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j15dS-0001Bt-PX
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:45:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j15dR-0004TH-Cv
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:45:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26311
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j15dR-0004SU-96
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581327944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g75Y4UAu1ITHdKckEUKo/WrgFjKe0JEqcBdbE3J8Eqc=;
 b=CsWJl2QL0iEYg45XO0dn5vhEcJ64V/BHXZEQrb9Gj55jTNLS/6FUMpLsQAVwDFj/YEQXCz
 U2dvGMl38aAUXoa8BDVOznJN8GBdOSMtwetsjbLUOvZnKkqJijDhIjgrfNzvtlfK1m8jQ7
 wGr9qKecq1UIRNYxGjeIgyiBrZOy2tE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-ZvAE1F6dNWq6sN_JytTh3Q-1; Mon, 10 Feb 2020 04:45:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C3E3101FC60;
 Mon, 10 Feb 2020 09:45:41 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93F677FB60;
 Mon, 10 Feb 2020 09:45:36 +0000 (UTC)
Date: Mon, 10 Feb 2020 10:45:35 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PATCH v3 07/13] hw/arm/raspi: Make machines children of
 abstract RaspiMachineClass
Message-ID: <20200210104535.46c9bad7@redhat.com>
In-Reply-To: <20200208165645.15657-8-f4bug@amsat.org>
References: <20200208165645.15657-1-f4bug@amsat.org>
 <20200208165645.15657-8-f4bug@amsat.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ZvAE1F6dNWq6sN_JytTh3Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Philippe =?UTF-8?B?TWF0?= =?UTF-8?B?aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat,  8 Feb 2020 17:56:39 +0100
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> QOM'ify RaspiMachineState. Now machines inherit of RaspiMachineClass.
>=20
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
> v3: Fixed typo in description (Zolt=C3=A1n)
> ---
>  hw/arm/raspi.c | 56 +++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 49 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index b3e6f72b55..62b8df3c2e 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -34,10 +34,28 @@
>  /* Registered machine type (matches RPi Foundation bootloader and U-Boot=
) */
>  #define MACH_TYPE_BCM2708   3138
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
> +
> +typedef struct RaspiMachineClass {
> +    /*< private >*/
> +    MachineClass parent_obj;
> +    /*< public >*/
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
>  /*
>   * Board revision codes:
> @@ -211,7 +229,7 @@ static void setup_boot(MachineState *machine, int ver=
sion, size_t ram_size)
> =20
>  static void raspi_init(MachineState *machine, uint32_t board_rev)
>  {
> -    RasPiState *s =3D g_new0(RasPiState, 1);
> +    RaspiMachineState *s =3D RASPI_MACHINE(machine);
>      int version =3D board_version(board_rev);
>      uint64_t ram_size =3D board_ram_size(board_rev);
>      uint32_t vcram_size;
> @@ -264,8 +282,10 @@ static void raspi2_init(MachineState *machine)
>      raspi_init(machine, 0xa21041);
>  }
> =20
> -static void raspi2_machine_init(MachineClass *mc)
> +static void raspi2_machine_class_init(ObjectClass *oc, void *data)
>  {
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
>      mc->desc =3D "Raspberry Pi 2B";
>      mc->init =3D raspi2_init;
>      mc->block_default_type =3D IF_SD;
> @@ -278,7 +298,6 @@ static void raspi2_machine_init(MachineClass *mc)
>      mc->default_ram_size =3D 1 * GiB;
>      mc->ignore_memory_transaction_failures =3D true;
>  };
> -DEFINE_MACHINE("raspi2", raspi2_machine_init)
> =20
>  #ifdef TARGET_AARCH64
>  static void raspi3_init(MachineState *machine)
> @@ -286,8 +305,10 @@ static void raspi3_init(MachineState *machine)
>      raspi_init(machine, 0xa02082);
>  }
> =20
> -static void raspi3_machine_init(MachineClass *mc)
> +static void raspi3_machine_class_init(ObjectClass *oc, void *data)
>  {
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
>      mc->desc =3D "Raspberry Pi 3B";
>      mc->init =3D raspi3_init;
>      mc->block_default_type =3D IF_SD;
> @@ -299,5 +320,26 @@ static void raspi3_machine_init(MachineClass *mc)
>      mc->default_cpus =3D BCM283X_NCPUS;
>      mc->default_ram_size =3D 1 * GiB;
>  }
> -DEFINE_MACHINE("raspi3", raspi3_machine_init)
>  #endif
> +
> +static const TypeInfo raspi_machine_types[] =3D {
> +    {
> +        .name           =3D MACHINE_TYPE_NAME("raspi2"),
> +        .parent         =3D TYPE_RASPI_MACHINE,
> +        .class_init     =3D raspi2_machine_class_init,
> +#ifdef TARGET_AARCH64
> +    }, {
> +        .name           =3D MACHINE_TYPE_NAME("raspi3"),
> +        .parent         =3D TYPE_RASPI_MACHINE,
> +        .class_init     =3D raspi3_machine_class_init,
> +#endif
> +    }, {
> +        .name           =3D TYPE_RASPI_MACHINE,
> +        .parent         =3D TYPE_MACHINE,
> +        .instance_size  =3D sizeof(RaspiMachineState),
> +        .class_size     =3D sizeof(RaspiMachineClass),
> +        .abstract       =3D true,
> +    }
> +};
> +
> +DEFINE_TYPES(raspi_machine_types)


