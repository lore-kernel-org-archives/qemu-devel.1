Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947B5C352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 09:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D09A208C4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 09:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJNamd2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D09A208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j15jc-000650-Ix
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 04:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j15iV-0005C0-HR
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:51:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j15iT-00086v-Eh
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:50:58 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55130
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j15iT-00086a-Au
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 04:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581328256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lgND+WbSjy59JQeQH0Hq6JuIAJkZjVWDvNJPT1uiqK8=;
 b=BJNamd2zVPTtCxmy/drJVQkBW8BmDKHY+//s16ehvbYDiQoyKWeJPauN12jnFwhrYDnX4y
 QFeHhhwx8Mf2iD+wJiruM7qYnAs+b9cUh0gSwyJ4ItqSJiUKR/U3SjpWn3aW7sH0t1QNWv
 HBhBmNWGJgASE7OFqrXinEOr/bdMPv0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-Y4-qKZ8uNwmRM9hTNCDffA-1; Mon, 10 Feb 2020 04:50:53 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E204D13E6;
 Mon, 10 Feb 2020 09:50:49 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 956FE87B08;
 Mon, 10 Feb 2020 09:50:44 +0000 (UTC)
Date: Mon, 10 Feb 2020 10:50:42 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PATCH v3 08/13] hw/arm/raspi: Make board_rev a field of
 RaspiMachineClass
Message-ID: <20200210105042.7e76e4e6@redhat.com>
In-Reply-To: <20200208165645.15657-9-f4bug@amsat.org>
References: <20200208165645.15657-1-f4bug@amsat.org>
 <20200208165645.15657-9-f4bug@amsat.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Y4-qKZ8uNwmRM9hTNCDffA-1
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
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat,  8 Feb 2020 17:56:40 +0100
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> We want to have a common class_init(). The only value that
> matters (and changes) is the board revision.
> Pass the board_rev as class_data to class_init().
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/raspi.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 62b8df3c2e..fbfcd29732 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -46,6 +46,7 @@ typedef struct RaspiMachineClass {
>      /*< private >*/
>      MachineClass parent_obj;
>      /*< public >*/
> +    uint32_t board_rev;
>  } RaspiMachineClass;
> =20
>  #define TYPE_RASPI_MACHINE       MACHINE_TYPE_NAME("raspi-common")
> @@ -227,9 +228,11 @@ static void setup_boot(MachineState *machine, int ve=
rsion, size_t ram_size)
>      arm_load_kernel(ARM_CPU(first_cpu), machine, &binfo);
>  }
> =20
> -static void raspi_init(MachineState *machine, uint32_t board_rev)
> +static void raspi_init(MachineState *machine)
>  {
> +    RaspiMachineClass *mc =3D RASPI_MACHINE_GET_CLASS(machine);
>      RaspiMachineState *s =3D RASPI_MACHINE(machine);
> +    uint32_t board_rev =3D mc->board_rev;
>      int version =3D board_version(board_rev);
>      uint64_t ram_size =3D board_ram_size(board_rev);
>      uint32_t vcram_size;
> @@ -279,13 +282,16 @@ static void raspi_init(MachineState *machine, uint3=
2_t board_rev)
> =20
>  static void raspi2_init(MachineState *machine)
>  {
> -    raspi_init(machine, 0xa21041);
> +    raspi_init(machine);
>  }
> =20
>  static void raspi2_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> +    RaspiMachineClass *rmc =3D RASPI_MACHINE_CLASS(oc);
> +    uint32_t board_rev =3D (uint32_t)(uintptr_t)data;
> =20
> +    rmc->board_rev =3D board_rev;

instead of doing a bit obscure ".class_data     =3D (void *)0xa21041," and
using it here, I'd just do

       rmc->board_rev =3D 0xa21041;

using value specific for each leaf class

with this change
 Reviewed-by: Igor Mammedov <imammedo@redhat.com>

>      mc->desc =3D "Raspberry Pi 2B";
>      mc->init =3D raspi2_init;
>      mc->block_default_type =3D IF_SD;
> @@ -302,13 +308,16 @@ static void raspi2_machine_class_init(ObjectClass *=
oc, void *data)
>  #ifdef TARGET_AARCH64
>  static void raspi3_init(MachineState *machine)
>  {
> -    raspi_init(machine, 0xa02082);
> +    raspi_init(machine);
>  }
> =20
>  static void raspi3_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> +    RaspiMachineClass *rmc =3D RASPI_MACHINE_CLASS(oc);
> +    uint32_t board_rev =3D (uint32_t)(uintptr_t)data;
> =20
> +    rmc->board_rev =3D board_rev;
>      mc->desc =3D "Raspberry Pi 3B";
>      mc->init =3D raspi3_init;
>      mc->block_default_type =3D IF_SD;
> @@ -327,11 +336,13 @@ static const TypeInfo raspi_machine_types[] =3D {
>          .name           =3D MACHINE_TYPE_NAME("raspi2"),
>          .parent         =3D TYPE_RASPI_MACHINE,
>          .class_init     =3D raspi2_machine_class_init,
> +        .class_data     =3D (void *)0xa21041,
>  #ifdef TARGET_AARCH64
>      }, {
>          .name           =3D MACHINE_TYPE_NAME("raspi3"),
>          .parent         =3D TYPE_RASPI_MACHINE,
>          .class_init     =3D raspi3_machine_class_init,
> +        .class_data     =3D (void *)0xa02082,
>  #endif
>      }, {
>          .name           =3D TYPE_RASPI_MACHINE,


