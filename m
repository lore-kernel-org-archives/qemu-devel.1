Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC73DC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 08:57:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1A2A20663
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 08:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A2A20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iebKW-0006Hi-Sl
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 03:57:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iebJu-0005mH-PE
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 03:56:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iebJt-0006fW-FY
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 03:56:38 -0500
Received: from 3.mo179.mail-out.ovh.net ([178.33.251.175]:34714)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iebJt-0006ey-9z
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 03:56:37 -0500
Received: from player789.ha.ovh.net (unknown [10.108.42.192])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 5E82D15251B
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 09:56:35 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player789.ha.ovh.net (Postfix) with ESMTPSA id E8861D0DE6FD;
 Tue, 10 Dec 2019 08:56:28 +0000 (UTC)
Subject: Re: [PATCH 1/2] hw/sd: Configure number of slots exposed by the
 ASPEED SDHCI model
To: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org
References: <cover.da2612e7c1835c563b20851f0ac26c7b175428fc.1575938234.git-series.andrew@aj.id.au>
 <11e1d38d2374a48996a3496c906db215de246583.1575938234.git-series.andrew@aj.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c49584df-016d-9a84-b96e-6a3b2e98c6a1@kaod.org>
Date: Tue, 10 Dec 2019 09:56:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <11e1d38d2374a48996a3496c906db215de246583.1575938234.git-series.andrew@aj.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 6755962394227936064
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudelvddguddvgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeekledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.251.175
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

On 10/12/2019 01:52, Andrew Jeffery wrote:
> The AST2600 includes a second cut-down version of the SD/MMC controller
> found in the AST2500, named the eMMC controller. It's cut down in the
> sense that it only supports one slot rather than two, but it brings the
> total number of slots supported by the AST2600 to three.
>=20
> The existing code assumed that the SD controller always provided two
> slots. Rework the SDHCI object to expose the number of slots as a
> property to be set by the SoC configuration.
>=20
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

One minor question below.


> ---
>  hw/arm/aspeed.c              |  2 +-
>  hw/arm/aspeed_ast2600.c      |  2 ++
>  hw/arm/aspeed_soc.c          |  3 +++
>  hw/sd/aspeed_sdhci.c         | 11 +++++++++--
>  include/hw/sd/aspeed_sdhci.h |  1 +
>  5 files changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 028191ff36fc..862549b1f3a9 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -259,7 +259,7 @@ static void aspeed_board_init(MachineState *machine=
,
>          cfg->i2c_init(bmc);
>      }
> =20
> -    for (i =3D 0; i < ARRAY_SIZE(bmc->soc.sdhci.slots); i++) {
> +    for (i =3D 0; i < bmc->soc.sdhci.num_slots; i++) {
>          SDHCIState *sdhci =3D &bmc->soc.sdhci.slots[i];
>          DriveInfo *dinfo =3D drive_get_next(IF_SD);
>          BlockBackend *blk;
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index 931887ac681f..931ee5aae183 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -208,6 +208,8 @@ static void aspeed_soc_ast2600_init(Object *obj)
>      sysbus_init_child_obj(obj, "sdc", OBJECT(&s->sdhci), sizeof(s->sdh=
ci),
>                            TYPE_ASPEED_SDHCI);
> =20
> +    object_property_set_int(OBJECT(&s->sdhci), 2, "num-slots", &error_=
abort);

OK. This defines 2 SDHCI slots for the ast2600 SoC, but

> +
>      /* Init sd card slot class here so that they're under the correct =
parent */
>      for (i =3D 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
>          sysbus_init_child_obj(obj, "sdhci[*]", OBJECT(&s->sdhci.slots[=
i]),
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index f4fe243458fd..3498f55603f2 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -215,6 +215,9 @@ static void aspeed_soc_init(Object *obj)
>      sysbus_init_child_obj(obj, "sdc", OBJECT(&s->sdhci), sizeof(s->sdh=
ci),
>                            TYPE_ASPEED_SDHCI);
> =20
> +    object_property_set_int(OBJECT(&s->sdhci), ASPEED_SDHCI_NUM_SLOTS,
> +                            "num-slots", &error_abort);


why use ASPEED_SDHCI_NUM_SLOTS here ?

C.

>      /* Init sd card slot class here so that they're under the correct =
parent */
>      for (i =3D 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
>          sysbus_init_child_obj(obj, "sdhci[*]", OBJECT(&s->sdhci.slots[=
i]),
> diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
> index cff3eb7dd21e..939d1510dedb 100644
> --- a/hw/sd/aspeed_sdhci.c
> +++ b/hw/sd/aspeed_sdhci.c
> @@ -13,6 +13,7 @@
>  #include "qapi/error.h"
>  #include "hw/irq.h"
>  #include "migration/vmstate.h"
> +#include "hw/qdev-properties.h"
> =20
>  #define ASPEED_SDHCI_INFO            0x00
>  #define  ASPEED_SDHCI_INFO_RESET     0x00030000
> @@ -120,14 +121,14 @@ static void aspeed_sdhci_realize(DeviceState *dev=
, Error **errp)
> =20
>      /* Create input irqs for the slots */
>      qdev_init_gpio_in_named_with_opaque(DEVICE(sbd), aspeed_sdhci_set_=
irq,
> -                                        sdhci, NULL, ASPEED_SDHCI_NUM_=
SLOTS);
> +                                        sdhci, NULL, sdhci->num_slots)=
;
> =20
>      sysbus_init_irq(sbd, &sdhci->irq);
>      memory_region_init_io(&sdhci->iomem, OBJECT(sdhci), &aspeed_sdhci_=
ops,
>                            sdhci, TYPE_ASPEED_SDHCI, 0x1000);
>      sysbus_init_mmio(sbd, &sdhci->iomem);
> =20
> -    for (int i =3D 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
> +    for (int i =3D 0; i < sdhci->num_slots; ++i) {
>          Object *sdhci_slot =3D OBJECT(&sdhci->slots[i]);
>          SysBusDevice *sbd_slot =3D SYS_BUS_DEVICE(&sdhci->slots[i]);
> =20
> @@ -174,6 +175,11 @@ static const VMStateDescription vmstate_aspeed_sdh=
ci =3D {
>      },
>  };
> =20
> +static Property aspeed_sdhci_properties[] =3D {
> +    DEFINE_PROP_UINT8("num-slots", AspeedSDHCIState, num_slots, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void aspeed_sdhci_class_init(ObjectClass *classp, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(classp);
> @@ -181,6 +187,7 @@ static void aspeed_sdhci_class_init(ObjectClass *cl=
assp, void *data)
>      dc->realize =3D aspeed_sdhci_realize;
>      dc->reset =3D aspeed_sdhci_reset;
>      dc->vmsd =3D &vmstate_aspeed_sdhci;
> +    dc->props =3D aspeed_sdhci_properties;
>  }
> =20
>  static TypeInfo aspeed_sdhci_info =3D {
> diff --git a/include/hw/sd/aspeed_sdhci.h b/include/hw/sd/aspeed_sdhci.=
h
> index dfdab4379021..dffbb46946b9 100644
> --- a/include/hw/sd/aspeed_sdhci.h
> +++ b/include/hw/sd/aspeed_sdhci.h
> @@ -24,6 +24,7 @@ typedef struct AspeedSDHCIState {
>      SysBusDevice parent;
> =20
>      SDHCIState slots[ASPEED_SDHCI_NUM_SLOTS];
> +    uint8_t num_slots;
> =20
>      MemoryRegion iomem;
>      qemu_irq irq;
>=20


