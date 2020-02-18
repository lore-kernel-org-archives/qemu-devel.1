Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B8FC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:10:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32E3B20659
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="G5mTlUyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E3B20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3ytf-00068m-9A
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1j3ynp-0007k4-RN
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:04:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1j3yno-00042J-MB
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:04:25 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:33678)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1j3ynm-00041Z-2w; Tue, 18 Feb 2020 04:04:22 -0500
Received: from [172.16.11.100] (tiramisu.bar.greensocs.com [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPSA id EAB0B96EF0;
 Tue, 18 Feb 2020 09:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1582016661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6iKDZMmR2MGRfb7FC4kp7sl2ip3ERGOfw2NgIJABaN8=;
 b=G5mTlUyMM9049D55UbTeMtqzRrrE/OSmzIGLIe/Xez6Y5D/8pHKvce/HQOQqcfGIiOR/cM
 v2GiOZ0EWotpwr/35A8uftii1x3l0/0XZsa79Vom/tWlw9mDcED0FCktLI3PDKp44JFUeE
 uUFv0nWGJWCLXqi6jNifjh7Xv+7J08I=
Subject: Re: [PATCH v2 11/13] hw/arm/bcm2836: Introduce the BCM2835 SoC
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200217114533.17779-1-f4bug@amsat.org>
 <20200217114533.17779-12-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <5fdb8e30-1bba-98d8-7c8e-a32ed7542514@greensocs.com>
Date: Tue, 18 Feb 2020 10:04:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217114533.17779-12-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1582016661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6iKDZMmR2MGRfb7FC4kp7sl2ip3ERGOfw2NgIJABaN8=;
 b=Lsnz/ZtuSq2KYNriaUl3CwXExMinMh1PjnWyV2hezCukD1i0p6uhNPWp0XaBceQHqOCJwZ
 n7dlgCxe98UJw1miiBuE8mEBJ4k02DlHWu3YlndCRwu0nd17K02FiQ/G6lZAbt1fUegk3p
 DSr4cfpQr4KyDlQUOceSKM08HmGrBp4=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1582016661; a=rsa-sha256; cv=none;
 b=2/S/910wrwyhhB3aKczfkZn/zclT0/SzBeC7/dOUNn2d9iB5/Sl874XcHvH6nKl6WXkflQ
 4joFeimQ4VSIu4iD8y5mhIDmOlLQY97ComHk28yCpWymIlAyy66UWDnmz/4BH3izsgZLHf
 80q8a1byBZfgbqHu2INQHQIyETYCbXc=
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
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  include/hw/arm/bcm2836.h |  1 +
>  hw/arm/bcm2836.c         | 40 ++++++++++++++++++++++++++++++++++++++++
>  hw/arm/raspi.c           |  2 ++
>  3 files changed, 43 insertions(+)
>=20
> diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
> index acc75bf553..3d46469a73 100644
> --- a/include/hw/arm/bcm2836.h
> +++ b/include/hw/arm/bcm2836.h
> @@ -24,6 +24,7 @@
>   * them, code using these devices should always handle them via the
>   * BCM283x base class, so they have no BCM2836(obj) etc macros.
>   */
> +#define TYPE_BCM2835 "bcm2835"
>  #define TYPE_BCM2836 "bcm2836"
>  #define TYPE_BCM2837 "bcm2837"
> =20
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index 2b6fe31139..bce5f8a866 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -103,6 +103,31 @@ static void bcm283x_common_realize(DeviceState *de=
v, Error **errp)
>                              bc->peri_base, 1);
>  }
> =20
> +static void bcm2835_realize(DeviceState *dev, Error **errp)
> +{
> +    BCM283XState *s =3D BCM283X(dev);
> +    Error *err =3D NULL;
> +
> +    bcm283x_common_realize(dev, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    object_property_set_bool(OBJECT(&s->cpu[0].core), true,
> +                             "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    /* Connect irq/fiq outputs from the interrupt controller. */
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
> +            qdev_get_gpio_in(DEVICE(&s->cpu[0].core), ARM_CPU_IRQ));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 1,
> +            qdev_get_gpio_in(DEVICE(&s->cpu[0].core), ARM_CPU_FIQ));
> +}
> +
>  static void bcm2836_realize(DeviceState *dev, Error **errp)
>  {
>      BCM283XState *s =3D BCM283X(dev);
> @@ -184,6 +209,17 @@ static void bcm283x_class_init(ObjectClass *oc, vo=
id *data)
>      dc->user_creatable =3D false;
>  }
> =20
> +static void bcm2835_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +    BCM283XClass *bc =3D BCM283X_CLASS(oc);
> +
> +    bc->cpu_type =3D ARM_CPU_TYPE_NAME("arm1176");
> +    bc->core_count =3D 1;
> +    bc->peri_base =3D 0x20000000;
> +    dc->realize =3D bcm2835_realize;
> +};
> +
>  static void bcm2836_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(oc);
> @@ -214,6 +250,10 @@ static void bcm2837_class_init(ObjectClass *oc, vo=
id *data)
> =20
>  static const TypeInfo bcm283x_types[] =3D {
>      {
> +        .name           =3D TYPE_BCM2835,
> +        .parent         =3D TYPE_BCM283X,
> +        .class_init     =3D bcm2835_class_init,
> +    }, {
>          .name           =3D TYPE_BCM2836,
>          .parent         =3D TYPE_BCM283X,
>          .class_init     =3D bcm2836_class_init,
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index fff501affb..3537a329ac 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -70,6 +70,7 @@ FIELD(REV_CODE, MEMORY_SIZE,       20, 3);
>  FIELD(REV_CODE, STYLE,             23, 1);
> =20
>  typedef enum RaspiProcessorId {
> +    PROCESSOR_ID_BCM2835 =3D 0,
>      PROCESSOR_ID_BCM2836 =3D 1,
>      PROCESSOR_ID_BCM2837 =3D 2,
>  } RaspiProcessorId;
> @@ -78,6 +79,7 @@ static const struct {
>      const char *type;
>      int cores_count;
>  } soc_property[] =3D {
> +    [PROCESSOR_ID_BCM2835] =3D {TYPE_BCM2835, 1},
>      [PROCESSOR_ID_BCM2836] =3D {TYPE_BCM2836, BCM283X_NCPUS},
>      [PROCESSOR_ID_BCM2837] =3D {TYPE_BCM2837, BCM283X_NCPUS},
>  };
>=20

