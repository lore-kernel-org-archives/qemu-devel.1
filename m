Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F15C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DF9024649
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="EXjV7cgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF9024649
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3ymc-0006iT-P5
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:03:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1j3yjw-0005KD-5E
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:00:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1j3yju-00036f-Sb
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:00:24 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:33516)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1j3yjs-00035s-Br; Tue, 18 Feb 2020 04:00:20 -0500
Received: from [172.16.11.100] (tiramisu.bar.greensocs.com [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 377DC96EF0;
 Tue, 18 Feb 2020 09:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1582016419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=izkMufESYPVKSCriGMjh5aq5ASE7rx1jv3wC35Y6KOE=;
 b=EXjV7cgXMQeSG7eW70pBOd/8PMXW5f2vrTKFwVAHiLDW/HysV+Vx97e+hCyQWbtB44vxxz
 vnMIHpsGzL/STgx+KP5PsZ6Cd0JIDe9pOC4cHrJ+QtDKSM2b1THW809YnnDWQsKwOj5ADg
 gLgIlkerqGWF5FXkSNik6AMk8ZJa6nc=
Subject: Re: [PATCH v2 08/13] hw/arm/bcm2836: Introduce
 BCM283XClass::core_count
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200217114533.17779-1-f4bug@amsat.org>
 <20200217114533.17779-9-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <57bf830e-1456-8881-7ad3-b6bc0bdb781e@greensocs.com>
Date: Tue, 18 Feb 2020 10:00:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217114533.17779-9-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1582016419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=izkMufESYPVKSCriGMjh5aq5ASE7rx1jv3wC35Y6KOE=;
 b=hVFsGSx55OZAisqeQXCFqFgWgdqHzuClg4476eJPwgDE44vlKEPuScDVk1994moLeT7pgY
 IrIC0R0CJAacS9T5PpldfuG3C+RaFbB0ABrwFWdGh04JdGu0jPX3Iga/CeOEgjgzMU/En2
 NDUDdIoq/BbCzzrO8Cls7PuPE364Fp4=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1582016419; a=rsa-sha256; cv=none;
 b=ovVx9cYq4COg3VB4pR8QAM0RIifvso69c4q8+uraYzIkyPfx3drCENbi+i+H4e8qtGYjzE
 xDriLck/EpII0+HddnX2V9dAS99BQ4jf1/xC6vGYKGOa71bHqYqVBzqWNpm7hRH4WIXeIe
 Anj2YWtSB56IHvIWxTRCHmViIeosAk8=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 12:45 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> The BCM2835 has only one core. Introduce the core_count field to
> be able to use values different than BCM283X_NCPUS (4).
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  hw/arm/bcm2836.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index 683d04d6ea..3b95ad11e9 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -21,6 +21,7 @@ typedef struct BCM283XClass {
>      DeviceClass parent_class;
>      /*< public >*/
>      const char *cpu_type;
> +    int core_count;
>      hwaddr peri_base; /* Peripheral base address seen by the CPU */
>      hwaddr ctrl_base; /* Interrupt controller and mailboxes etc. */
>      int clusterid;
> @@ -37,7 +38,7 @@ static void bcm2836_init(Object *obj)
>      BCM283XClass *bc =3D BCM283X_GET_CLASS(obj);
>      int n;
> =20
> -    for (n =3D 0; n < BCM283X_NCPUS; n++) {
> +    for (n =3D 0; n < bc->core_count; n++) {
>          object_initialize_child(obj, "cpu[*]", &s->cpu[n].core,
>                                  sizeof(s->cpu[n].core), bc->cpu_type,
>                                  &error_abort, NULL);
> @@ -107,7 +108,7 @@ static void bcm2836_realize(DeviceState *dev, Error=
 **errp)
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 1,
>          qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-fiq", 0));
> =20
> -    for (n =3D 0; n < BCM283X_NCPUS; n++) {
> +    for (n =3D 0; n < bc->core_count; n++) {
>          /* TODO: this should be converted to a property of ARM_CPU */
>          s->cpu[n].core.mp_affinity =3D (bc->clusterid << 8) | n;
> =20
> @@ -173,6 +174,7 @@ static void bcm2836_class_init(ObjectClass *oc, voi=
d *data)
>      BCM283XClass *bc =3D BCM283X_CLASS(oc);
> =20
>      bc->cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a7");
> +    bc->core_count =3D BCM283X_NCPUS;
>      bc->peri_base =3D 0x3f000000;
>      bc->ctrl_base =3D 0x40000000;
>      bc->clusterid =3D 0xf;
> @@ -187,6 +189,7 @@ static void bcm2837_class_init(ObjectClass *oc, voi=
d *data)
>      BCM283XClass *bc =3D BCM283X_CLASS(oc);
> =20
>      bc->cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a53");
> +    bc->core_count =3D BCM283X_NCPUS;
>      bc->peri_base =3D 0x3f000000;
>      bc->ctrl_base =3D 0x40000000;
>      bc->clusterid =3D 0x0;
>=20

