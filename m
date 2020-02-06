Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97457C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:25:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C1A2206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1A2206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgE6-0005Co-LE
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:25:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1izgDP-0004Id-PZ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:25:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1izgDO-00043M-Kc
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:25:03 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:38401)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1izgDL-0003gI-OJ; Thu, 06 Feb 2020 07:25:00 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id DDDD4747DFF;
 Thu,  6 Feb 2020 13:24:58 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B8317747DF7; Thu,  6 Feb 2020 13:24:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B6DB5747DFE;
 Thu,  6 Feb 2020 13:24:58 +0100 (CET)
Date: Thu, 6 Feb 2020 13:24:58 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 07/30] hw/arm/raspi: Make machines children of abstract
 RaspiMachineClass
In-Reply-To: <20200206011756.2413-8-f4bug@amsat.org>
Message-ID: <alpine.BSF.2.22.395.2002061324260.71431@zero.eik.bme.hu>
References: <20200206011756.2413-1-f4bug@amsat.org>
 <20200206011756.2413-8-f4bug@amsat.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-269300259-1580991898=:71431"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-269300259-1580991898=:71431
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Feb 2020, Philippe Mathieu-Daud=C3=A9 wrote:
> QOM'ify RaspiMachineState. Now machines inherite of RaspiMachineClass.

Typo: inherite -> inherit

Regards,
BALATON Zoltan


>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> hw/arm/raspi.c | 56 +++++++++++++++++++++++++++++++++++++++++++-------
> 1 file changed, 49 insertions(+), 7 deletions(-)
>
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index fab361939c..edf3e1c0d5 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -33,10 +33,28 @@
>
> #define MACH_TYPE_BCM2708   3138 /* Linux board IDs */
>
> -typedef struct RasPiState {
> +typedef struct RaspiMachineState {
> +    /*< private >*/
> +    MachineState parent_obj;
> +    /*< public >*/
>     BCM283XState soc;
>     MemoryRegion ram;
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
> +     OBJECT_CLASS_CHECK(RaspiMachineClass, (klass), TYPE_RASPI_MACHINE=
)
> +#define RASPI_MACHINE_GET_CLASS(obj) \
> +     OBJECT_GET_CLASS(RaspiMachineClass, (obj), TYPE_RASPI_MACHINE)
>
> /*
>  * Board revision codes:
> @@ -210,7 +228,7 @@ static void setup_boot(MachineState *machine, int v=
ersion, size_t ram_size)
>
> static void raspi_init(MachineState *machine, uint32_t board_rev)
> {
> -    RasPiState *s =3D g_new0(RasPiState, 1);
> +    RaspiMachineState *s =3D RASPI_MACHINE(machine);
>     int version =3D board_version(board_rev);
>     uint64_t ram_size =3D board_ram_size(board_rev);
>     uint32_t vcram_size;
> @@ -263,8 +281,10 @@ static void raspi2_init(MachineState *machine)
>     raspi_init(machine, 0xa21041);
> }
>
> -static void raspi2_machine_init(MachineClass *mc)
> +static void raspi2_machine_class_init(ObjectClass *oc, void *data)
> {
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
>     mc->desc =3D "Raspberry Pi 2B";
>     mc->init =3D raspi2_init;
>     mc->block_default_type =3D IF_SD;
> @@ -277,7 +297,6 @@ static void raspi2_machine_init(MachineClass *mc)
>     mc->default_ram_size =3D 1 * GiB;
>     mc->ignore_memory_transaction_failures =3D true;
> };
> -DEFINE_MACHINE("raspi2", raspi2_machine_init)
>
> #ifdef TARGET_AARCH64
> static void raspi3_init(MachineState *machine)
> @@ -285,8 +304,10 @@ static void raspi3_init(MachineState *machine)
>     raspi_init(machine, 0xa02082);
> }
>
> -static void raspi3_machine_init(MachineClass *mc)
> +static void raspi3_machine_class_init(ObjectClass *oc, void *data)
> {
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
>     mc->desc =3D "Raspberry Pi 3B";
>     mc->init =3D raspi3_init;
>     mc->block_default_type =3D IF_SD;
> @@ -298,5 +319,26 @@ static void raspi3_machine_init(MachineClass *mc)
>     mc->default_cpus =3D BCM283X_NCPUS;
>     mc->default_ram_size =3D 1 * GiB;
> }
> -DEFINE_MACHINE("raspi3", raspi3_machine_init)
> #endif
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
>
--3866299591-269300259-1580991898=:71431--

