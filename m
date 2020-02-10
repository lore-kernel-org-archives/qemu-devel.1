Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20509C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 10:02:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA47F2082F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 10:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JcNLu0M5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA47F2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j15td-0004xV-2y
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 05:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j15sf-0004RJ-1C
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 05:01:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j15sd-0007Oe-SO
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 05:01:28 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45879
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j15sc-0007NA-D8
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 05:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581328884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WLZnqbsvULJflmbDCGQLQC5zqyMuzSCNNKxNEP6giio=;
 b=JcNLu0M5lQCL+p7QEmA6gIhQ/TD56FR3TqZ4dtH47YsoRRdxhiJotlj5r85PSbtozUjjCZ
 EEB0zvaym6XumKIOJDXKdmEA8syY55iPHqWyJJqRui99Hu9hzNvxX5Tf9rsjhx1P8Gr5I8
 li47sdkwTL1u3kLQaF18dykmk20NaUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-QazSmJnFMRW2eK9JiTKtzQ-1; Mon, 10 Feb 2020 05:01:23 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56E6E13FC;
 Mon, 10 Feb 2020 10:01:21 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43A8260CD1;
 Mon, 10 Feb 2020 10:01:15 +0000 (UTC)
Date: Mon, 10 Feb 2020 11:01:13 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PATCH v3 12/13] hw/arm/raspi: Use a unique
 raspi_machine_class_init() method
Message-ID: <20200210110113.43a802d6@redhat.com>
In-Reply-To: <20200208165645.15657-13-f4bug@amsat.org>
References: <20200208165645.15657-1-f4bug@amsat.org>
 <20200208165645.15657-13-f4bug@amsat.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: QazSmJnFMRW2eK9JiTKtzQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Sat,  8 Feb 2020 17:56:44 +0100
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> With the exception of the ignore_memory_transaction_failures
> flag set for the raspi2, both machine_class_init() methods
> are now identical. Merge them to keep a unique method.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/arm/raspi.c | 31 ++++++-------------------------
>  1 file changed, 6 insertions(+), 25 deletions(-)
>=20
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 0537fc0a2d..bee6ca0a08 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -294,7 +294,7 @@ static void raspi_machine_init(MachineState *machine)
>      setup_boot(machine, version, machine->ram_size - vcram_size);
>  }
> =20
> -static void raspi2_machine_class_init(ObjectClass *oc, void *data)
> +static void raspi_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
>      RaspiMachineClass *rmc =3D RASPI_MACHINE_CLASS(oc);
> @@ -311,41 +311,22 @@ static void raspi2_machine_class_init(ObjectClass *=
oc, void *data)
>      mc->min_cpus =3D BCM283X_NCPUS;
>      mc->default_cpus =3D BCM283X_NCPUS;
>      mc->default_ram_size =3D board_ram_size(board_rev);
> -    mc->ignore_memory_transaction_failures =3D true;
> +    if (board_version(board_rev) =3D=3D 2) {
> +        mc->ignore_memory_transaction_failures =3D true;
> +    }
>  };
> =20
> -#ifdef TARGET_AARCH64
> -static void raspi3_machine_class_init(ObjectClass *oc, void *data)
> -{
> -    MachineClass *mc =3D MACHINE_CLASS(oc);
> -    RaspiMachineClass *rmc =3D RASPI_MACHINE_CLASS(oc);
> -    uint32_t board_rev =3D (uint32_t)(uintptr_t)data;
> -
> -    rmc->board_rev =3D board_rev;
> -    mc->desc =3D g_strdup_printf("Raspberry Pi %s", board_type(board_rev=
));
> -    mc->init =3D raspi_machine_init;
> -    mc->block_default_type =3D IF_SD;
> -    mc->no_parallel =3D 1;
> -    mc->no_floppy =3D 1;
> -    mc->no_cdrom =3D 1;
> -    mc->max_cpus =3D BCM283X_NCPUS;
> -    mc->min_cpus =3D BCM283X_NCPUS;
> -    mc->default_cpus =3D BCM283X_NCPUS;
> -    mc->default_ram_size =3D board_ram_size(board_rev);
> -}
> -#endif
> -
>  static const TypeInfo raspi_machine_types[] =3D {
>      {
>          .name           =3D MACHINE_TYPE_NAME("raspi2"),
>          .parent         =3D TYPE_RASPI_MACHINE,
> -        .class_init     =3D raspi2_machine_class_init,
> +        .class_init     =3D raspi_machine_class_init,
>          .class_data     =3D (void *)0xa21041,
>  #ifdef TARGET_AARCH64
>      }, {
>          .name           =3D MACHINE_TYPE_NAME("raspi3"),
>          .parent         =3D TYPE_RASPI_MACHINE,
> -        .class_init     =3D raspi3_machine_class_init,
> +        .class_init     =3D raspi_machine_class_init,
>          .class_data     =3D (void *)0xa02082,
>  #endif
>      }, {


