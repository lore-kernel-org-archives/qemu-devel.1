Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D10C3524F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FC7920661
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ab7XdlnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC7920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyYVO-0001EP-4U
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iyYUS-0000jO-6H
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:58:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iyYUQ-0002tU-US
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:58:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52989
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iyYUQ-0002tC-R3
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580723878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lydme9jOwB1OFMvTOGgBnuCMfpkt445a2/GNLFZx+2Q=;
 b=Ab7XdlnOcILaWpLFeSoRCNZxeodfGzM/AFydh4Vvvlh3L+jHDWJLKJc3XAZ13PdIj9GbLw
 1kX/sBCD1Y7ovyBnvX4D66jTLI5DHLWX9vzoxpjjftVZaKXPdAK6nRlSrtNd31wOMODrKz
 Pj6KEVOlMW7QM33Jm/ylddmao8mqQtg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-jf0vkmY9MnS2djWQKWcwMw-1; Mon, 03 Feb 2020 04:57:53 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90F3C800D41;
 Mon,  3 Feb 2020 09:57:51 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B99B690F51;
 Mon,  3 Feb 2020 09:57:47 +0000 (UTC)
Date: Mon, 3 Feb 2020 10:57:46 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PATCH 2/6] hw/arm/raspi: Get board version from board revision
 code
Message-ID: <20200203105746.43cc27a7@redhat.com>
In-Reply-To: <20200203082619.7426-3-f4bug@amsat.org>
References: <20200203082619.7426-1-f4bug@amsat.org>
 <20200203082619.7426-3-f4bug@amsat.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: jf0vkmY9MnS2djWQKWcwMw-1
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

On Mon,  3 Feb 2020 09:26:15 +0100
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> The chip ID is encoded in the board revision, and the board version
> is simply 'chip_id + 1'.
> We want to support more boards which follow the same scheme.
> Introduce a new RaspiBoardInfo structure which we'll extend in the
> following commits.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/raspi.c | 45 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index ef76a27f33..eaa8c49009 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -36,6 +36,39 @@ typedef struct RasPiState {
>      MemoryRegion ram;
>  } RasPiState;
> =20
> +typedef struct RaspiBoardInfo {
> +    /*
> +     * Board revision codes:
> +     * www.raspberrypi.org/documentation/hardware/raspberrypi/revision-c=
odes/
> +     */
> +    uint32_t board_rev;
> +} RaspiBoardInfo;
> +
> +enum { BOARD_PI2, BOARD_PI3 };
> +
> +static const RaspiBoardInfo raspi_boards[] =3D {
> +    [BOARD_PI2] =3D
> +    {
> +        .board_rev =3D 0xa21041,
> +    },
> +#ifdef TARGET_AARCH64
> +    [BOARD_PI3] =3D
> +    {
> +        .board_rev =3D 0xa02082,
> +    },
> +#endif
> +};

This patter was(is) used widely by embed boards before QOM
(I mean introducing various structures to keep boards configs
and then passing them around). Which I found were cumbersome
to deal with with working on ram refactoring.

But have you considered using machine classes which
perfectly feet the task, instead of repeating old pattern?



> +static int board_chip_id(const RaspiBoardInfo *config)
> +{
> +    return extract32(config->board_rev, 12, 4);
> +}
> +
> +static int board_version(const RaspiBoardInfo *config)
> +{
> +    return board_chip_id(config) + 1;
> +}
> +
>  static void write_smpboot(ARMCPU *cpu, const struct arm_boot_info *info)
>  {
>      static const uint32_t smpboot[] =3D {
> @@ -163,9 +196,10 @@ static void setup_boot(MachineState *machine, int ve=
rsion, size_t ram_size)
>      arm_load_kernel(ARM_CPU(first_cpu), machine, &binfo);
>  }
> =20
> -static void raspi_init(MachineState *machine, int version)
> +static void raspi_init(MachineState *machine, const RaspiBoardInfo *conf=
ig)
>  {
>      RasPiState *s =3D g_new0(RasPiState, 1);
> +    int version =3D board_version(config);
>      uint32_t vcram_size;
>      DriveInfo *di;
>      BlockBackend *blk;
> @@ -191,9 +225,8 @@ static void raspi_init(MachineState *machine, int ver=
sion)
>      /* Setup the SOC */
>      object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ra=
m),
>                                     &error_abort);
> -    int board_rev =3D version =3D=3D 3 ? 0xa02082 : 0xa21041;
> -    object_property_set_int(OBJECT(&s->soc), board_rev, "board-rev",
> -                            &error_abort);
> +    object_property_set_int(OBJECT(&s->soc), config->board_rev,
> +                            "board-rev", &error_abort);
>      object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_a=
bort);
> =20
>      /* Create and plug in the SD cards */
> @@ -215,7 +248,7 @@ static void raspi_init(MachineState *machine, int ver=
sion)
> =20
>  static void raspi2_init(MachineState *machine)
>  {
> -    raspi_init(machine, 2);
> +    raspi_init(machine, &raspi_boards[BOARD_PI2]);
>  }
> =20
>  static void raspi2_machine_init(MachineClass *mc)
> @@ -237,7 +270,7 @@ DEFINE_MACHINE("raspi2", raspi2_machine_init)
>  #ifdef TARGET_AARCH64
>  static void raspi3_init(MachineState *machine)
>  {
> -    raspi_init(machine, 3);
> +    raspi_init(machine, &raspi_boards[BOARD_PI3]);
>  }
> =20
>  static void raspi3_machine_init(MachineClass *mc)


