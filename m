Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A99C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C157420656
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OX1TVqZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C157420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iolAL-0002sv-55
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 04:28:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iokBS-0000o3-BV
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 03:25:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iokBO-0001Tv-Q0
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 03:25:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54280
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iokBO-0001Tb-N0
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 03:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578385546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EItgcsqMjnzxV43V3Il8tJ34o6wX9PReSRH1fDJnmow=;
 b=OX1TVqZK313+H94Xw8bjiGHHX3eS6vKqix9NTZ85ZLY83FuSeSqUsUtqHAdrRAr6LUjMJX
 GHJOojBr1nRX48JhPzr25G4lV7mwmfDoY5ZQ+vlAuPERsXGZEbV3c21z4yKo6tZiKaNm/O
 D8+Bp/LsljDT4SSJRrEsHtaKP5+k6dA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-l7rxyOWAPN2dRDSfNxx8jA-1; Tue, 07 Jan 2020 03:25:45 -0500
Received: by mail-wm1-f72.google.com with SMTP id s25so1691971wmj.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 00:25:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=twvR55DUgXtP77qfYthgZ5Mc4/jTQDOUFsTn2kgZRmQ=;
 b=GwOqRY6UYyx97puqvh9uXid/mQJN9lej5N9Rti0bIq6Bi8Tz+u8affgJR5mXXlCihl
 /U3X6hulPuoOIOFK659TMS43olZqs2RcK17f3OWTN9eTnzqWUk6agMbX6piOUOV33HTn
 TB/rBs7YhLWwUUJhsgjaGmIBaQ//qV+gMjTqPsug6UIU3LVGj//xJAZUz/halMzCi0DD
 t1rr5OSO1hAsXcCHSsnWNhV9LrPUmrqCMfluq3jo0OBMYCtPfbRT51uMvEXH0cgo56Lp
 UQnKD98D6ABnv6L6x+ZSbxVKGcf2X6lJEj6Vf+8MPe2NCk2jf3njr6OG7jYpYVhHmt9V
 b5Og==
X-Gm-Message-State: APjAAAWbqWd97Ob7JtPxMQV7tgKIUv0WviFPHlW2VEUBiQ1WWXup45p4
 p7cQhDqYmDfx33kQBNmpajOIHraxlV5FjUNMAKypLp1UJOVEJVKjqlB/jljS5RAmqZZVzwhp5N8
 InFYJO1mctRQrh+8=
X-Received: by 2002:adf:dfd2:: with SMTP id
 q18mr107226627wrn.152.1578385542971; 
 Tue, 07 Jan 2020 00:25:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqxG/drZ3ew1CkVTV/HlnqhJ2XDgBb0efS022eVKQlfjBcp7dihWXjafKKgEEdgA7A7f0HvR/Q==
X-Received: by 2002:adf:dfd2:: with SMTP id
 q18mr107226583wrn.152.1578385542506; 
 Tue, 07 Jan 2020 00:25:42 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id p5sm76736768wrt.79.2020.01.07.00.25.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 00:25:41 -0800 (PST)
Subject: Re: [PATCH 2/5] hw/arm: ast2600: Wire up the eMMC controller
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200107073423.30043-1-clg@kaod.org>
 <20200107073423.30043-3-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a7c45303-e624-d7aa-df6f-e03f26b3cba7@redhat.com>
Date: Tue, 7 Jan 2020 09:25:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107073423.30043-3-clg@kaod.org>
Content-Language: en-US
X-MC-Unique: l7rxyOWAPN2dRDSfNxx8jA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/7/20 8:34 AM, C=C3=A9dric Le Goater wrote:
> From: Andrew Jeffery <andrew@aj.id.au>
>=20
> Initialise another SDHCI model instance for the AST2600's eMMC
> controller and use the SDHCI's num_slots value introduced previously to
> determine whether we should create an SD card instance for the new slot.
>=20
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>   include/hw/arm/aspeed_soc.h |  2 ++
>   hw/arm/aspeed.c             | 25 ++++++++++++++++---------
>   hw/arm/aspeed_ast2600.c     | 21 +++++++++++++++++++++
>   3 files changed, 39 insertions(+), 9 deletions(-)
>=20
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index e84380984f7b..90ac7f7ffa3b 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -57,6 +57,7 @@ typedef struct AspeedSoCState {
>       AspeedGPIOState gpio;
>       AspeedGPIOState gpio_1_8v;
>       AspeedSDHCIState sdhci;
> +    AspeedSDHCIState emmc;
>   } AspeedSoCState;
>  =20
>   #define TYPE_ASPEED_SOC "aspeed-soc"
> @@ -126,6 +127,7 @@ enum {
>       ASPEED_MII4,
>       ASPEED_SDRAM,
>       ASPEED_XDMA,
> +    ASPEED_EMMC,
>   };
>  =20
>   #endif /* ASPEED_SOC_H */
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 4174e313cae5..0a7dfd29868b 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -171,6 +171,18 @@ static void aspeed_board_init_flashes(AspeedSMCState=
 *s, const char *flashtype,
>       }
>   }
>  =20
> +static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo)
> +{
> +        BlockBackend *blk;
> +        DeviceState *card;
> +
> +        blk =3D dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
> +        card =3D qdev_create(qdev_get_child_bus(DEVICE(sdhci), "sd-bus")=
,
> +                           TYPE_SD_CARD);
> +        qdev_prop_set_drive(card, "drive", blk, &error_fatal);

I find this form easier to review:

            if (dinfo) {
                 qdev_prop_set_drive(card, "drive",
                                     blk_by_legacy_dinfo(dinfo),
                                     &error_fatal);
            }

> +        object_property_set_bool(OBJECT(card), true, "realized", &error_=
fatal);
> +}
> +
>   static void aspeed_machine_init(MachineState *machine)
>   {
>       AspeedBoardState *bmc;
> @@ -264,16 +276,11 @@ static void aspeed_machine_init(MachineState *machi=
ne)
>       }
>  =20
>       for (i =3D 0; i < bmc->soc.sdhci.num_slots; i++) {
> -        SDHCIState *sdhci =3D &bmc->soc.sdhci.slots[i];
> -        DriveInfo *dinfo =3D drive_get_next(IF_SD);
> -        BlockBackend *blk;
> -        DeviceState *card;
> +        sdhci_attach_drive(&bmc->soc.sdhci.slots[i], drive_get_next(IF_S=
D));
> +    }
>  =20
> -        blk =3D dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
> -        card =3D qdev_create(qdev_get_child_bus(DEVICE(sdhci), "sd-bus")=
,
> -                           TYPE_SD_CARD);
> -        qdev_prop_set_drive(card, "drive", blk, &error_fatal);
> -        object_property_set_bool(OBJECT(card), true, "realized", &error_=
fatal);
> +    if (bmc->soc.emmc.num_slots) {
> +        sdhci_attach_drive(&bmc->soc.emmc.slots[0], drive_get_next(IF_SD=
));
>       }
>  =20
>       arm_load_kernel(ARM_CPU(first_cpu), machine, &aspeed_board_binfo);
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index fb73c4043ea3..e59cdd291925 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -46,6 +46,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] =3D {
>       [ASPEED_ADC]       =3D 0x1E6E9000,
>       [ASPEED_VIDEO]     =3D 0x1E700000,
>       [ASPEED_SDHCI]     =3D 0x1E740000,
> +    [ASPEED_EMMC]      =3D 0x1E750000,
>       [ASPEED_GPIO]      =3D 0x1E780000,
>       [ASPEED_GPIO_1_8V] =3D 0x1E780800,
>       [ASPEED_RTC]       =3D 0x1E781000,
> @@ -64,6 +65,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] =3D {
>  =20
>   #define ASPEED_SOC_AST2600_MAX_IRQ 128
>  =20
> +/* Shared Peripheral Interrupt values below are offset by -32 from datas=
heet */
>   static const int aspeed_soc_ast2600_irqmap[] =3D {
>       [ASPEED_UART1]     =3D 47,
>       [ASPEED_UART2]     =3D 48,
> @@ -77,6 +79,7 @@ static const int aspeed_soc_ast2600_irqmap[] =3D {
>       [ASPEED_ADC]       =3D 78,
>       [ASPEED_XDMA]      =3D 6,
>       [ASPEED_SDHCI]     =3D 43,
> +    [ASPEED_EMMC]      =3D 15,
>       [ASPEED_GPIO]      =3D 40,
>       [ASPEED_GPIO_1_8V] =3D 11,
>       [ASPEED_RTC]       =3D 13,
> @@ -206,6 +209,14 @@ static void aspeed_soc_ast2600_init(Object *obj)
>           sysbus_init_child_obj(obj, "sdhci[*]", OBJECT(&s->sdhci.slots[i=
]),
>                                 sizeof(s->sdhci.slots[i]), TYPE_SYSBUS_SD=
HCI);
>       }
> +
> +    sysbus_init_child_obj(obj, "emmc", OBJECT(&s->emmc), sizeof(s->emmc)=
,
> +                          TYPE_ASPEED_SDHCI);
> +
> +    object_property_set_int(OBJECT(&s->emmc), 1, "num-slots", &error_abo=
rt);
> +
> +    sysbus_init_child_obj(obj, "emmc[*]", OBJECT(&s->emmc.slots[0]),

Single block, so use "emmc" instead.

Using "emmc":
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +            sizeof(s->emmc.slots[0]), TYPE_SYSBUS_SDHCI);
>   }
>  =20
>   /*
> @@ -497,6 +508,16 @@ static void aspeed_soc_ast2600_realize(DeviceState *=
dev, Error **errp)
>                       sc->memmap[ASPEED_SDHCI]);
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
>                          aspeed_soc_get_irq(s, ASPEED_SDHCI));
> +
> +    /* eMMC */
> +    object_property_set_bool(OBJECT(&s->emmc), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->emmc), 0, sc->memmap[ASPEED_EMMC]=
);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->emmc), 0,
> +                       aspeed_soc_get_irq(s, ASPEED_EMMC));
>   }
>  =20
>   static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
>=20


