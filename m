Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C008AC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 16:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8798A24654
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 16:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3b8y1uz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8798A24654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j465Y-0006ux-OY
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 11:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j464j-0006IL-2F
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:50:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j464h-00008X-SA
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:50:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57091
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j464h-00008H-OI
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:50:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582044619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GvA+kR/R0ZYOPz3ZnYW9L0jbPp3JWJC9Ag7pXP6U9vM=;
 b=T3b8y1uz0H8RpcnnPwW/73URMycfuhGYUnEnS7X6UwhhaMzVR6d11zomViBSFkOv8eA4Cr
 o2+2aobR4/ISzdqgvPTeJrKGxs8CiCzRLnbbp+cKwSxwOmKF6BgRx9woxiQdb3bxeJpfWW
 nyB0Rb+h1Aop3G/+ZUIKRzCzEYdv2+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-HZj__YNoPaqXoJfyjXU17A-1; Tue, 18 Feb 2020 11:50:14 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84C731B2C9AD;
 Tue, 18 Feb 2020 16:50:12 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 090065C13C;
 Tue, 18 Feb 2020 16:50:07 +0000 (UTC)
Date: Tue, 18 Feb 2020 17:50:07 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 02/13] hw/arm/raspi: Avoid using TypeInfo::class_data
 pointer
Message-ID: <20200218175007.594c3a3a@redhat.com>
In-Reply-To: <20200217114533.17779-3-f4bug@amsat.org>
References: <20200217114533.17779-1-f4bug@amsat.org>
 <20200217114533.17779-3-f4bug@amsat.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: HZj__YNoPaqXoJfyjXU17A-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Feb 2020 12:45:22 +0100
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Using class_data pointer to create a MachineClass is not
> the recommended way anymore. The correct way is to open-code
> the MachineClass::fields in the class_init() method.
>=20
> We can not use TYPE_RASPI_MACHINE::class_base_init() because
> it is called *before* each machine class_init(), therefore the
> board_rev field is not populated. We have to manually call
> raspi_machine_class_common_init() for each machine.
>=20
> This partly reverts commit a03bde3674e.
>=20
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/arm/raspi.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 221356933e..1a8c135dc6 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -309,13 +309,9 @@ static void raspi_machine_init(MachineState *machine=
)
>      setup_boot(machine, version, machine->ram_size - vcram_size);
>  }
> =20
> -static void raspi_machine_class_init(ObjectClass *oc, void *data)
> +static void raspi_machine_class_common_init(MachineClass *mc,
> +                                            uint32_t board_rev)
>  {
> -    MachineClass *mc =3D MACHINE_CLASS(oc);
> -    RaspiMachineClass *rmc =3D RASPI_MACHINE_CLASS(oc);
> -    uint32_t board_rev =3D (uint32_t)(uintptr_t)data;
> -
> -    rmc->board_rev =3D board_rev;
>      mc->desc =3D g_strdup_printf("Raspberry Pi %s", board_type(board_rev=
));
>      mc->init =3D raspi_machine_init;
>      mc->block_default_type =3D IF_SD;
> @@ -326,18 +322,36 @@ static void raspi_machine_class_init(ObjectClass *o=
c, void *data)
>      mc->default_ram_size =3D board_ram_size(board_rev);
>  };
> =20
> +static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +    RaspiMachineClass *rmc =3D RASPI_MACHINE_CLASS(oc);
> +
> +    rmc->board_rev =3D 0xa21041;
> +    raspi_machine_class_common_init(mc, rmc->board_rev);
> +};
> +
> +#ifdef TARGET_AARCH64
> +static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +    RaspiMachineClass *rmc =3D RASPI_MACHINE_CLASS(oc);
> +
> +    rmc->board_rev =3D 0xa02082;
> +    raspi_machine_class_common_init(mc, rmc->board_rev);
> +};
> +#endif /* TARGET_AARCH64 */
> +
>  static const TypeInfo raspi_machine_types[] =3D {
>      {
>          .name           =3D MACHINE_TYPE_NAME("raspi2"),
>          .parent         =3D TYPE_RASPI_MACHINE,
> -        .class_init     =3D raspi_machine_class_init,
> -        .class_data     =3D (void *)0xa21041,
> +        .class_init     =3D raspi2b_machine_class_init,
>  #ifdef TARGET_AARCH64
>      }, {
>          .name           =3D MACHINE_TYPE_NAME("raspi3"),
>          .parent         =3D TYPE_RASPI_MACHINE,
> -        .class_init     =3D raspi_machine_class_init,
> -        .class_data     =3D (void *)0xa02082,
> +        .class_init     =3D raspi3b_machine_class_init,
>  #endif
>      }, {
>          .name           =3D TYPE_RASPI_MACHINE,


