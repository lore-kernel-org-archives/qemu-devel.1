Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46677C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 07:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4A222527
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 07:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4A222527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iffRU-0005aA-A6
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 02:32:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iffP0-0003pC-Re
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 02:30:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iffOz-0005UE-A5
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 02:30:18 -0500
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:56137)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iffOz-0005RY-3D
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 02:30:17 -0500
Received: from player760.ha.ovh.net (unknown [10.108.1.219])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 564BE153A77
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 08:30:15 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player760.ha.ovh.net (Postfix) with ESMTPSA id 60571D41D73B;
 Fri, 13 Dec 2019 07:30:10 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] hw/arm: ast2600: Wire up the eMMC controller
To: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org
References: <cover.fc3e5e495d85ebd919c1f06a1a2c7c7730518f9c.1576211124.git-series.andrew@aj.id.au>
 <23bbbd829459a9a2508c9e76f0720e428852d92d.1576211124.git-series.andrew@aj.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <94b599da-2211-e77e-267a-5826203c522e@kaod.org>
Date: Fri, 13 Dec 2019 08:30:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <23bbbd829459a9a2508c9e76f0720e428852d92d.1576211124.git-series.andrew@aj.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 4469259683614264128
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudelkedguddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeitddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.78.111
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
Cc: peter.maydell@linaro.org, joel@jms.id.au, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/12/2019 05:28, Andrew Jeffery wrote:
> Initialise another SDHCI model instance for the AST2600's eMMC
> controller and use the SDHCI's num_slots value introduced previously to
> determine whether we should create an SD card instance for the new slot=
.
>=20
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>=20
> v2:
> * Extract instantiation of SD cards to helper function
>=20
>  hw/arm/aspeed.c             | 25 ++++++++++++++++---------
>  hw/arm/aspeed_ast2600.c     | 21 +++++++++++++++++++++
>  include/hw/arm/aspeed_soc.h |  2 ++
>  3 files changed, 39 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 862549b1f3a9..87baac0ea46c 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -167,6 +167,18 @@ static void aspeed_board_init_flashes(AspeedSMCSta=
te *s, const char *flashtype,
>      }
>  }
> =20
> +static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo)
> +{
> +        BlockBackend *blk;
> +        DeviceState *card;
> +
> +        blk =3D dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
> +        card =3D qdev_create(qdev_get_child_bus(DEVICE(sdhci), "sd-bus=
"),
> +                           TYPE_SD_CARD);
> +        qdev_prop_set_drive(card, "drive", blk, &error_fatal);
> +        object_property_set_bool(OBJECT(card), true, "realized", &erro=
r_fatal);
> +}
> +
>  static void aspeed_board_init(MachineState *machine,
>                                const AspeedBoardConfig *cfg)
>  {
> @@ -260,16 +272,11 @@ static void aspeed_board_init(MachineState *machi=
ne,
>      }
> =20
>      for (i =3D 0; i < bmc->soc.sdhci.num_slots; i++) {
> -        SDHCIState *sdhci =3D &bmc->soc.sdhci.slots[i];
> -        DriveInfo *dinfo =3D drive_get_next(IF_SD);
> -        BlockBackend *blk;
> -        DeviceState *card;
> +        sdhci_attach_drive(&bmc->soc.sdhci.slots[i], drive_get_next(IF=
_SD));
> +    }
> =20
> -        blk =3D dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
> -        card =3D qdev_create(qdev_get_child_bus(DEVICE(sdhci), "sd-bus=
"),
> -                           TYPE_SD_CARD);
> -        qdev_prop_set_drive(card, "drive", blk, &error_fatal);
> -        object_property_set_bool(OBJECT(card), true, "realized", &erro=
r_fatal);
> +    if (bmc->soc.emmc.num_slots) {
> +        sdhci_attach_drive(&bmc->soc.emmc.slots[0], drive_get_next(IF_=
SD));
>      }
> =20
>      arm_load_kernel(ARM_CPU(first_cpu), machine, &aspeed_board_binfo);
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index 931ee5aae183..723c8196c8a5 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -46,6 +46,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] =3D {
>      [ASPEED_ADC]       =3D 0x1E6E9000,
>      [ASPEED_VIDEO]     =3D 0x1E700000,
>      [ASPEED_SDHCI]     =3D 0x1E740000,
> +    [ASPEED_EMMC]      =3D 0x1E750000,
>      [ASPEED_GPIO]      =3D 0x1E780000,
>      [ASPEED_GPIO_1_8V] =3D 0x1E780800,
>      [ASPEED_RTC]       =3D 0x1E781000,
> @@ -64,6 +65,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] =3D {
> =20
>  #define ASPEED_SOC_AST2600_MAX_IRQ 128
> =20
> +/* Shared Peripheral Interrupt values below are offset by -32 from dat=
asheet */
>  static const int aspeed_soc_ast2600_irqmap[] =3D {
>      [ASPEED_UART1]     =3D 47,
>      [ASPEED_UART2]     =3D 48,
> @@ -77,6 +79,7 @@ static const int aspeed_soc_ast2600_irqmap[] =3D {
>      [ASPEED_ADC]       =3D 78,
>      [ASPEED_XDMA]      =3D 6,
>      [ASPEED_SDHCI]     =3D 43,
> +    [ASPEED_EMMC]      =3D 15,
>      [ASPEED_GPIO]      =3D 40,
>      [ASPEED_GPIO_1_8V] =3D 11,
>      [ASPEED_RTC]       =3D 13,
> @@ -215,6 +218,14 @@ static void aspeed_soc_ast2600_init(Object *obj)
>          sysbus_init_child_obj(obj, "sdhci[*]", OBJECT(&s->sdhci.slots[=
i]),
>                                sizeof(s->sdhci.slots[i]), TYPE_SYSBUS_S=
DHCI);
>      }
> +
> +    sysbus_init_child_obj(obj, "emmc", OBJECT(&s->emmc), sizeof(s->emm=
c),
> +                          TYPE_ASPEED_SDHCI);
> +
> +    object_property_set_int(OBJECT(&s->emmc), 1, "num-slots", &error_a=
bort);
> +
> +    sysbus_init_child_obj(obj, "emmc[*]", OBJECT(&s->emmc.slots[0]),
> +            sizeof(s->emmc.slots[0]), TYPE_SYSBUS_SDHCI);
>  }
> =20
>  /*
> @@ -487,6 +498,16 @@ static void aspeed_soc_ast2600_realize(DeviceState=
 *dev, Error **errp)
>                      sc->memmap[ASPEED_SDHCI]);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
>                         aspeed_soc_get_irq(s, ASPEED_SDHCI));
> +
> +    /* eMMC */
> +    object_property_set_bool(OBJECT(&s->emmc), true, "realized", &err)=
;
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->emmc), 0, sc->memmap[ASPEED_EMM=
C]);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->emmc), 0,
> +                       aspeed_soc_get_irq(s, ASPEED_EMMC));
>  }
> =20
>  static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 495c08be1b84..911443f4c071 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -56,6 +56,7 @@ typedef struct AspeedSoCState {
>      AspeedGPIOState gpio;
>      AspeedGPIOState gpio_1_8v;
>      AspeedSDHCIState sdhci;
> +    AspeedSDHCIState emmc;
>  } AspeedSoCState;
> =20
>  #define TYPE_ASPEED_SOC "aspeed-soc"
> @@ -125,6 +126,7 @@ enum {
>      ASPEED_MII4,
>      ASPEED_SDRAM,
>      ASPEED_XDMA,
> +    ASPEED_EMMC,
>  };
> =20
>  #endif /* ASPEED_SOC_H */
>=20


