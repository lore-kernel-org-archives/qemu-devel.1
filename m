Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C740EC4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 11:47:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92739206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 11:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTyeLQfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92739206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEteW-0007zW-OB
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 07:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jEtdh-0007ac-MS
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jEtdf-0007yx-14
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:47:04 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:59334)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jEtde-0007xr-Sx
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584618422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ohP6qUAhPgP6ZUAgM5YD15i2+hEAJ10HtOqu0IC6oqM=;
 b=FTyeLQfinno7d4/hdFjZm9Wqb33UqoHh/6phIxwyCr28X/zwSRLUitCr1DMt0CP8DkCH3W
 TRmGe62GNbEKkLa1+vnhMFW75KmzuI44NuLpjNNiYF32f8k4lmpMxOf7qVnqe/KUmKkevG
 COeHUEKRnkIjGmvKYVIsve1xUTmsOCA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-7-rVjIVZO9CMd_4UA8xkYQ-1; Thu, 19 Mar 2020 07:47:00 -0400
X-MC-Unique: 7-rVjIVZO9CMd_4UA8xkYQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 324B88017CC;
 Thu, 19 Mar 2020 11:46:59 +0000 (UTC)
Received: from office.mammed.net (unknown [10.40.194.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77D5F5D9CD;
 Thu, 19 Mar 2020 11:46:55 +0000 (UTC)
Date: Thu, 19 Mar 2020 12:46:53 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Heyi Guo <guoheyi@huawei.com>
Subject: Re: [PATCH v4 1/2] hw/smbios: add options for type 4 max-speed and
 current-speed
Message-ID: <20200319124653.75484e03@office.mammed.net>
In-Reply-To: <20200318064820.19363-2-guoheyi@huawei.com>
References: <20200318064820.19363-1-guoheyi@huawei.com>
 <20200318064820.19363-2-guoheyi@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: wanghaibin.wang@huawei.com,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Mar 2020 14:48:19 +0800
Heyi Guo <guoheyi@huawei.com> wrote:

> Common VM users sometimes care about CPU speed, so we add two new
> options to allow VM vendors to present CPU speed to their users.
> Normally these information can be fetched from host smbios.
>=20
> Strictly speaking, the "max speed" and "current speed" in type 4
> are not really for the max speed and current speed of processor, for
> "max speed" identifies a capability of the system, and "current speed"
> identifies the processor's speed at boot (see smbios spec), but some
> applications do not tell the differences.
>=20
> Signed-off-by: Heyi Guo <guoheyi@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

>=20
> ---
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> v3 -> v4:
> - Fix the default value when not specifying "-smbios type=3D4" option;
>   it would be 0 instead of 2000 in previous versions
> - Use uint64_t type to check value overflow
>=20
> v2 -> v3:
> - Refine comments per Igor's suggestion.
>=20
> v1 -> v2:
> - change "_" in option names to "-"
> - check if option value is too large to fit in SMBIOS type 4 speed
> fields.
> ---
>  hw/smbios/smbios.c | 36 ++++++++++++++++++++++++++++++++----
>  qemu-options.hx    |  3 ++-
>  2 files changed, 34 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index ffd98727ee..b95de935e8 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -92,9 +92,21 @@ static struct {
>      const char *manufacturer, *version, *serial, *asset, *sku;
>  } type3;
> =20
> +/*
> + * SVVP requires max_speed and current_speed to be set and not being
> + * 0 which counts as unknown (SMBIOS 3.1.0/Table 21). Set the
> + * default value to 2000MHz as we did before.
> + */
> +#define DEFAULT_CPU_SPEED 2000
> +
>  static struct {
>      const char *sock_pfx, *manufacturer, *version, *serial, *asset, *par=
t;
> -} type4;
> +    uint64_t max_speed;
> +    uint64_t current_speed;
> +} type4 =3D {
> +    .max_speed =3D DEFAULT_CPU_SPEED,
> +    .current_speed =3D DEFAULT_CPU_SPEED
> +};
> =20
>  static struct {
>      size_t nvalues;
> @@ -272,6 +284,14 @@ static const QemuOptDesc qemu_smbios_type4_opts[] =
=3D {
>          .name =3D "version",
>          .type =3D QEMU_OPT_STRING,
>          .help =3D "version number",
> +    },{
> +        .name =3D "max-speed",
> +        .type =3D QEMU_OPT_NUMBER,
> +        .help =3D "max speed in MHz",
> +    },{
> +        .name =3D "current-speed",
> +        .type =3D QEMU_OPT_NUMBER,
> +        .help =3D "speed at system boot in MHz",
>      },{
>          .name =3D "serial",
>          .type =3D QEMU_OPT_STRING,
> @@ -586,9 +606,8 @@ static void smbios_build_type_4_table(MachineState *m=
s, unsigned instance)
>      SMBIOS_TABLE_SET_STR(4, processor_version_str, type4.version);
>      t->voltage =3D 0;
>      t->external_clock =3D cpu_to_le16(0); /* Unknown */
> -    /* SVVP requires max_speed and current_speed to not be unknown. */
> -    t->max_speed =3D cpu_to_le16(2000); /* 2000 MHz */
> -    t->current_speed =3D cpu_to_le16(2000); /* 2000 MHz */
> +    t->max_speed =3D cpu_to_le16(type4.max_speed);
> +    t->current_speed =3D cpu_to_le16(type4.current_speed);
>      t->status =3D 0x41; /* Socket populated, CPU enabled */
>      t->processor_upgrade =3D 0x01; /* Other */
>      t->l1_cache_handle =3D cpu_to_le16(0xFFFF); /* N/A */
> @@ -1129,6 +1148,15 @@ void smbios_entry_add(QemuOpts *opts, Error **errp=
)
>              save_opt(&type4.serial, opts, "serial");
>              save_opt(&type4.asset, opts, "asset");
>              save_opt(&type4.part, opts, "part");
> +            type4.max_speed =3D qemu_opt_get_number(opts, "max-speed",
> +                                                  DEFAULT_CPU_SPEED);
> +            type4.current_speed =3D qemu_opt_get_number(opts, "current-s=
peed",
> +                                                      DEFAULT_CPU_SPEED)=
;
> +            if (type4.max_speed > UINT16_MAX ||
> +                type4.current_speed > UINT16_MAX) {
> +                error_setg(errp, "SMBIOS CPU speed is too large (> %d)",
> +                           UINT16_MAX);
> +            }
>              return;
>          case 11:
>              qemu_opts_validate(opts, qemu_smbios_type11_opts, &err);
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 962a5ebaa6..7665addc78 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2277,6 +2277,7 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
>      "                specify SMBIOS type 3 fields\n"
>      "-smbios type=3D4[,sock_pfx=3Dstr][,manufacturer=3Dstr][,version=3Ds=
tr][,serial=3Dstr]\n"
>      "              [,asset=3Dstr][,part=3Dstr]\n"
> +    "              [,max-speed=3D%d][,current-speed=3D%d]\n"
>      "                specify SMBIOS type 4 fields\n"
>      "-smbios type=3D17[,loc_pfx=3Dstr][,bank=3Dstr][,manufacturer=3Dstr]=
[,serial=3Dstr]\n"
>      "               [,asset=3Dstr][,part=3Dstr][,speed=3D%d]\n"
> @@ -2298,7 +2299,7 @@ SRST
>  ``-smbios type=3D3[,manufacturer=3Dstr][,version=3Dstr][,serial=3Dstr][,=
asset=3Dstr][,sku=3Dstr]``
>      Specify SMBIOS type 3 fields
> =20
> -``-smbios type=3D4[,sock_pfx=3Dstr][,manufacturer=3Dstr][,version=3Dstr]=
[,serial=3Dstr][,asset=3Dstr][,part=3Dstr]``
> +``-smbios type=3D4[,sock_pfx=3Dstr][,manufacturer=3Dstr][,version=3Dstr]=
[,serial=3Dstr][,asset=3Dstr][,part=3Dstr][,max-speed=3D%d][,current-speed=
=3D%d]``
>      Specify SMBIOS type 4 fields
> =20
>  ``-smbios type=3D17[,loc_pfx=3Dstr][,bank=3Dstr][,manufacturer=3Dstr][,s=
erial=3Dstr][,asset=3Dstr][,part=3Dstr][,speed=3D%d]``


