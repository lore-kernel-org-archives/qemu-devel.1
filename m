Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E1FC55179
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:44:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 449472245A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="feS8mMsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449472245A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW0B1-0000Ej-0n
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kVzM5-0003I8-Ex
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:51:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kVzM3-0004kT-Jz
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603468306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rf5/DbVGf5xNwzm7YAsFh69eT8u+FhDSXb+hwn0eXSs=;
 b=feS8mMsNSYSBlz7Wdrxc8bLig0rg1gRVBdLBwRn5RrYpIZFOs71sg7u4YyHu2CcA4hqnB3
 D2rutRT5WtsijKVJXwvMJ3Wvdos4Yjz8zXHhjTPv3dq0echD1t4qNKUoQMoOqhfx+z93Nb
 6cnKjEJE/Nn5XAeMJLzQQbuP59u8u0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-QCsaEQK2PM27PIF4NnJKgQ-1; Fri, 23 Oct 2020 11:51:36 -0400
X-MC-Unique: QCsaEQK2PM27PIF4NnJKgQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28455804B71;
 Fri, 23 Oct 2020 15:51:35 +0000 (UTC)
Received: from localhost (unknown [10.40.208.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A75DE1002C17;
 Fri, 23 Oct 2020 15:51:32 +0000 (UTC)
Date: Fri, 23 Oct 2020 17:51:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PATCH v3 8/9] hw/arm/raspi: Add the Raspberry Pi Zero machine
Message-ID: <20201023175130.50a379bd@redhat.com>
In-Reply-To: <20201018203358.1530378-9-f4bug@amsat.org>
References: <20201018203358.1530378-1-f4bug@amsat.org>
 <20201018203358.1530378-9-f4bug@amsat.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 qemu-devel@nongnu.org, Andrew Baumann <Andrew.Baumann@microsoft.com>,
 qemu-arm@nongnu.org, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 18 Oct 2020 22:33:57 +0200
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Similarly to the Pi A, the Pi Zero uses a BCM2835 SoC (ARMv6Z core).
>=20
> Example booting the machine using content from [*]:
>=20
>   $ qemu-system-arm -M raspi0 -serial stdio \
>       -kernel raspberrypi/firmware/boot/kernel.img \
>       -dtb raspberrypi/firmware/boot/bcm2708-rpi-zero.dtb \
>       -append 'printk.time=3D0 earlycon=3Dpl011,0x20201000 console=3DttyA=
MA0'
>   [    0.000000] Booting Linux on physical CPU 0x0
>   [    0.000000] Linux version 4.19.118+ (dom@buildbot) (gcc version 4.9.=
3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1311 Mon Apr 27 14:16:15=
 BST 2020
>   [    0.000000] CPU: ARMv6-compatible processor [410fb767] revision 7 (A=
RMv7), cr=3D00c5387d
>   [    0.000000] CPU: VIPT aliasing data cache, unknown instruction cache
>   [    0.000000] OF: fdt: Machine model: Raspberry Pi Zero
>   ...
>=20
> [*] http://archive.raspberrypi.org/debian/pool/main/r/raspberrypi-firmwar=
e/raspberrypi-kernel_1.20200512-2_armhf.deb
>=20
> Reviewed-by: Luc Michel <luc.michel@greensocs.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/raspi.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 91a59d1d489..1510ca01afe 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -319,6 +319,15 @@ static void raspi_machine_class_common_init(MachineC=
lass *mc,
>      mc->default_ram_id =3D "ram";
>  };
> =20
> +static void raspi0_machine_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +    RaspiMachineClass *rmc =3D RASPI_MACHINE_CLASS(oc);
> +
> +    rmc->board_rev =3D 0x900092;

shouldn't it be=20
920092=09Zero=091.2=09512MB=09Embest
or
920093  Zero=091.3=09512MB=09Embest

> +    raspi_machine_class_common_init(mc, rmc->board_rev);
> +};
> +
>  static void raspi1ap_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> @@ -352,6 +361,10 @@ static void raspi3b_machine_class_init(ObjectClass *=
oc, void *data)
> =20
>  static const TypeInfo raspi_machine_types[] =3D {
>      {
> +        .name           =3D MACHINE_TYPE_NAME("raspi0"),
> +        .parent         =3D TYPE_RASPI_MACHINE,
> +        .class_init     =3D raspi0_machine_class_init,
> +    }, {
>          .name           =3D MACHINE_TYPE_NAME("raspi1ap"),
>          .parent         =3D TYPE_RASPI_MACHINE,
>          .class_init     =3D raspi1ap_machine_class_init,


