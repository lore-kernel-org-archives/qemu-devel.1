Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38A4C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 06:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D40F2086A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 06:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D40F2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52038 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haa9v-0005WE-7P
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 02:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50281)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1haa8o-000501-24
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 02:20:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1haa8l-000863-Dq
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 02:20:17 -0400
Received: from 2.mo4.mail-out.ovh.net ([46.105.72.36]:55902)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1haa8l-00082F-6Z
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 02:20:15 -0400
Received: from player774.ha.ovh.net (unknown [10.108.42.142])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 629591F6619
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 08:20:12 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player774.ha.ovh.net (Postfix) with ESMTPSA id 2D4906AB588B;
 Tue, 11 Jun 2019 06:20:03 +0000 (UTC)
To: Adriana Kobylak <anoo@linux.ibm.com>, peter.maydell@linaro.org,
 andrew@aj.id.au, joel@jms.id.au, qemu-arm@nongnu.org
References: <cce364a3-548c-427f-addb-07e38f827e03@www.fastmail.com>
 <1560200011-70806-1-git-send-email-anoo@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <30891725-75e8-cf1d-43f6-9f6c0c6fd59d@kaod.org>
Date: Tue, 11 Jun 2019 08:20:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1560200011-70806-1-git-send-email-anoo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 5195746597693197192
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudehfedguddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecu
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.72.36
Subject: Re: [Qemu-devel] [PATCH qemu v2] aspeed: Add support for the
 swift-bmc board
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
Cc: Adriana Kobylak <anoo@us.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Adriana,

On 10/06/2019 22:53, Adriana Kobylak wrote:
> From: Adriana Kobylak <anoo@us.ibm.com>
>=20
> The Swift board is an OpenPOWER system hosting POWER processors.
> Add support for their BMC including the I2C devices as found on HW.
>=20
> Signed-off-by: Adriana Kobylak <anoo@us.ibm.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>


I pushed this patch in my tree for the moment as the patchset :

  "aspeed: machine extensions and fixes" patchwork.ozlabs.org/cover/11053=
43/

still needs some more reviews.

Thanks,

C.=20

> ---
>  hw/arm/aspeed.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++=
+
>  1 file changed, 50 insertions(+)
>=20
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 33070a6..7fd0e0c 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -73,6 +73,17 @@ struct AspeedBoardState {
>          SCU_AST2500_HW_STRAP_ACPI_ENABLE |                            =
  \
>          SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
> =20
> +/* Swift hardware value: 0xF11AD206 */
> +#define SWIFT_BMC_HW_STRAP1 (                                         =
  \
> +        AST2500_HW_STRAP1_DEFAULTS |                                  =
  \
> +        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                   =
  \
> +        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                      =
  \
> +        SCU_AST2500_HW_STRAP_UART_DEBUG |                             =
  \
> +        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                            =
  \
> +        SCU_H_PLL_BYPASS_EN |                                         =
  \
> +        SCU_AST2500_HW_STRAP_ACPI_ENABLE |                            =
  \
> +        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
> +
>  /* Witherspoon hardware value: 0xF10AD216 (but use romulus definition)=
 */
>  #define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
> =20
> @@ -287,6 +298,35 @@ static void romulus_bmc_i2c_init(AspeedBoardState =
*bmc)
>      i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "ds133=
8", 0x32);
>  }
> =20
> +static void swift_bmc_i2c_init(AspeedBoardState *bmc)
> +{
> +    AspeedSoCState *soc =3D &bmc->soc;
> +
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), "pca955=
2", 0x60);
> +
> +    /* The swift board expects a TMP275 but a TMP105 is compatible */
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 7), "tmp105=
", 0x48);
> +    /* The swift board expects a pca9551 but a pca9552 is compatible *=
/
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 7), "pca955=
2", 0x60);
> +
> +    /* The swift board expects an Epson RX8900 RTC but a ds1338 is com=
patible */
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), "ds1338=
", 0x32);
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), "pca955=
2", 0x60);
> +
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 9), "tmp423=
", 0x4c);
> +    /* The swift board expects a pca9539 but a pca9552 is compatible *=
/
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 9), "pca955=
2", 0x74);
> +
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 10), "tmp42=
3", 0x4c);
> +    /* The swift board expects a pca9539 but a pca9552 is compatible *=
/
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 10), "pca95=
52",
> +                     0x74);
> +
> +    /* The swift board expects a TMP275 but a TMP105 is compatible */
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 12), "tmp10=
5", 0x48);
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 12), "tmp10=
5", 0x4a);
> +}
> +
>  static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
>  {
>      AspeedSoCState *soc =3D &bmc->soc;
> @@ -378,6 +418,16 @@ static const AspeedBoardConfig aspeed_boards[] =3D=
 {
>          .i2c_init  =3D romulus_bmc_i2c_init,
>          .ram       =3D 512 * MiB,
>      }, {
> +        .name      =3D MACHINE_TYPE_NAME("swift-bmc"),
> +        .desc      =3D "OpenPOWER Swift BMC (ARM1176)",
> +        .soc_name  =3D "ast2500-a1",
> +        .hw_strap1 =3D SWIFT_BMC_HW_STRAP1,
> +        .fmc_model =3D "mx66l1g45g",
> +        .spi_model =3D "mx66l1g45g",
> +        .num_cs    =3D 2,
> +        .i2c_init  =3D swift_bmc_i2c_init,
> +        .ram       =3D 512 * MiB,
> +    }, {
>          .name      =3D MACHINE_TYPE_NAME("witherspoon-bmc"),
>          .desc      =3D "OpenPOWER Witherspoon BMC (ARM1176)",
>          .soc_name  =3D "ast2500-a1",
>=20


