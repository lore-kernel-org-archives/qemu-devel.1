Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A567C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 10:15:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B877204EC
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 10:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B877204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45753 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRZtd-0003q5-Bp
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 06:15:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hRZnN-0006dQ-GY
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hRZnL-0003is-NA
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:08:57 -0400
Received: from 6.mo4.mail-out.ovh.net ([188.165.36.253]:49717)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hRZnL-0003PX-FR
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:08:55 -0400
Received: from player159.ha.ovh.net (unknown [10.108.57.139])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id A13AA1E49C8
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 12:08:34 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player159.ha.ovh.net (Postfix) with ESMTPSA id 6AF655C64376;
	Fri, 17 May 2019 10:08:28 +0000 (UTC)
To: Wim Vervoorn <wvervoorn@eltan.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
	Peter Maydell <peter.maydell@linaro.org>
References: <d0fea426e8b245769f3022dad121c17e@Eltsrv03.Eltan.local>
	<eb815dd0-f056-d733-f017-bba56b907231@kaod.org>
	<108c97d2eee749da8f75c69f06e25072@Eltsrv03.Eltan.local>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3ee8eb5a-d38c-9570-3da5-a055e9f147e5@kaod.org>
Date: Fri, 17 May 2019 12:08:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <108c97d2eee749da8f75c69f06e25072@Eltsrv03.Eltan.local>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 9809402940787034897
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddtvddgvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.36.253
Subject: Re: [Qemu-devel] aspeed qemu question
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Win,

On 5/17/19 9:46 AM, Wim Vervoorn wrote:
> Hello Cedr=EDc,
>=20
> Thanks for your response. I created and attached the patch. You are rig=
ht the code snipped turns out unreadable.

You should try to send the patch directly and not attached. Checkout=20
the git send-email commands for it. See also :

https://wiki.qemu.org/Contribute/SubmitAPatch

> In the patch I enable the MAC's depending on the value in hwstrap1 just=
 as in the real hardware. In the Palmetto both nics will be enabled (just=
 as in the real palmetto).=20
>=20
> I added a 2nd AST2400 BMC the Eltan Piestewa Peak. Here I enabled the 2=
nd NIC only.
>=20
> What I see is that when I use Palmetto I get an assert in net/net.c lin=
e 256, this is in the "qemu_net_client_setup()". I assume I have to prepa=
re something regarding the host side of the network implementation but I =
this point I have no clue what and I have a hard time figuring out how th=
e networking architecture really works.=20

Did you define two nics on the command line  ?

more comments below.

[ ... ]=20

> From bbf9392b84f38531b89e4ea39e06210b99ec7a0c Mon Sep 17 00:00:00 2001
> Message-Id: <bbf9392b84f38531b89e4ea39e06210b99ec7a0c.1558078463.git.wv=
ervoorn@eltan.com>
> From: Wim Vervoorn <wvervoorn@eltan.com>
> Date: Fri, 17 May 2019 09:26:16 +0200
> Subject: [PATCH] ASPEED BMC: Add support for 2nd NIC
>=20
> Add support for 2nd NIC.
>=20
> This solution is using the hwstrap1 value to enable disable the
> controllers.

OK. Let see how this shows in the code.

> The Palmetto leaves both NICs enabled while the Piestewa Peak only
> enables one.

You should send two different patches, one for the NIC, one for Piestewa=20
Peak machine.=20

> The Palmetto asserts in net/net.c line 256 when qemu starts so somethin=
g
> must be missing to support the 2nd nic.

You need a "signed-off-by:" tag here

> ---
>  hw/arm/aspeed.c             | 26 ++++++++++++++++++++++
>  hw/arm/aspeed_soc.c         | 54 ++++++++++++++++++++++++++++++++-----=
--------
>  include/hw/arm/aspeed_soc.h |  2 +-
>  3 files changed, 66 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> old mode 100644
> new mode 100755
> index 0203642..f957a5b
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -43,6 +43,23 @@ struct AspeedBoardState {
>          SCU_AST2400_HW_STRAP_SET_CLK_SOURCE(AST2400_CLK_48M_IN) |     =
  \
>          SCU_HW_STRAP_VGA_CLASS_CODE |                                 =
  \
>          SCU_HW_STRAP_LPC_RESET_PIN |                                  =
  \
> +        SCU_HW_STRAP_MAC0_RGMII |                                     =
  \
> +        SCU_HW_STRAP_MAC1_RGMII |                                     =
  \
> +        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_M_S_EN) |              =
  \
> +        SCU_AST2400_HW_STRAP_SET_CPU_AHB_RATIO(AST2400_CPU_AHB_RATIO_2=
_1) | \
> +        SCU_HW_STRAP_SPI_WIDTH |                                      =
  \
> +        SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                     =
  \
> +        SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
> +
> +/* Piestewa Peak hardware value:  */
> +#define ELTANPWP_BMC_HW_STRAP1 (                                      =
  \
> +        SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_256MB) |             =
  \
> +        SCU_AST2400_HW_STRAP_DRAM_CONFIG(2 /* DDR3 with CL=3D6, CWL=3D=
5 */) | \
> +        SCU_AST2400_HW_STRAP_ACPI_DIS |                               =
  \
> +        SCU_AST2400_HW_STRAP_SET_CLK_SOURCE(AST2400_CLK_48M_IN) |     =
  \
> +        SCU_HW_STRAP_VGA_CLASS_CODE |                                 =
  \
> +        SCU_HW_STRAP_LPC_RESET_PIN |                                  =
  \
> +        SCU_HW_STRAP_MAC1_RGMII |                                     =
  \
>          SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_M_S_EN) |              =
  \
>          SCU_AST2400_HW_STRAP_SET_CPU_AHB_RATIO(AST2400_CPU_AHB_RATIO_2=
_1) | \
>          SCU_HW_STRAP_SPI_WIDTH |                                      =
  \
> @@ -423,6 +440,15 @@ static const AspeedBoardConfig aspeed_boards[] =3D=
 {
>          .num_cs    =3D 1,
>          .i2c_init  =3D palmetto_bmc_i2c_init,
>      }, {
> +        .name      =3D MACHINE_TYPE_NAME("eltanpwp-bmc"),
> +        .desc      =3D "Eltan Piestewa Peak BMC (ARM926EJ-S)",
> +        .soc_name  =3D "ast2400-a1",
> +        .hw_strap1 =3D ELTANPWP_BMC_HW_STRAP1,
> +        .fmc_model =3D "n25q256a",
> +        .spi_model =3D "mx25l25635e",

Are these the correct flash models for your board ?=20

> +        .num_cs    =3D 1,
> +        .i2c_init  =3D palmetto_bmc_i2c_init,
> +    }, {
>          .name      =3D MACHINE_TYPE_NAME("ast2500-evb"),
>          .desc      =3D "Aspeed AST2500 EVB (ARM1176)",
>          .soc_name  =3D "ast2500-a1",
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> old mode 100644
> new mode 100755
> index 0f6e5be..8ed7902
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -184,9 +184,13 @@ static void aspeed_soc_init(Object *obj)
>                                         OBJECT(&s->scu), &error_abort);
>      }
> =20
> -    object_initialize(&s->ftgmac100, sizeof(s->ftgmac100), TYPE_FTGMAC=
100);
> -    object_property_add_child(obj, "ftgmac100", OBJECT(&s->ftgmac100),=
 NULL);
> -    qdev_set_parent_bus(DEVICE(&s->ftgmac100), sysbus_get_default());
> +    object_initialize(&s->ftgmac100[0], sizeof(s->ftgmac100), TYPE_FTG=
MAC100);
> +    object_property_add_child(obj, "ftgmac100[0]", OBJECT(&s->ftgmac10=
0[0]), NULL);
> +    qdev_set_parent_bus(DEVICE(&s->ftgmac100[0]), sysbus_get_default()=
);
> +
> +    object_initialize(&s->ftgmac100[1], sizeof(s->ftgmac100), TYPE_FTG=
MAC100);
> +    object_property_add_child(obj, "ftgmac100[1]", OBJECT(&s->ftgmac10=
0[1]), NULL);
> +    qdev_set_parent_bus(DEVICE(&s->ftgmac100[1]), sysbus_get_default()=
);

using a loop would be better. The future Aspeed SoCs might have more than=
 two
MACs.
> =20
>      object_initialize(&s->ibt, sizeof(s->ibt), TYPE_ASPEED_IBT);
>      object_property_add_child(obj, "bt", OBJECT(&s->ibt), NULL);
> @@ -384,19 +388,39 @@ static void aspeed_soc_realize(DeviceState *dev, =
Error **errp)
>                          ASPEED_SOC_WDT_BASE + i * 0x20);
>      }
> =20
> -    /* Net */
> -    qdev_set_nic_properties(DEVICE(&s->ftgmac100), &nd_table[0]);
> -    object_property_set_bool(OBJECT(&s->ftgmac100), true, "aspeed", &e=
rr);
> -    object_property_set_bool(OBJECT(&s->ftgmac100), true, "realized",
> -                             &local_err);
> -    error_propagate(&err, local_err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        return;
> +    /* Net LAN 0*/
> +        qdev_set_nic_properties(DEVICE(&s->ftgmac100[0]), &nd_table[0]=
);
> +        object_property_set_bool(OBJECT(&s->ftgmac100[0]), true, "aspe=
ed", &err);

This is not the correct indentation. Please run checkpatch.pl on the patc=
h.

> +    if (s->scu.hw_strap1 & SCU_HW_STRAP_MAC0_RGMII) {
> +        qemu_log("%s: LAN0 enabled\n", __func__);

we don't need this kind of information.

> +        object_property_set_bool(OBJECT(&s->ftgmac100[0]), true, "real=
ized",
> +                                &local_err);
> +        error_propagate(&err, local_err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100[0]), 0, ASPEED_SO=
C_ETH1_BASE);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[0]), 0,
> +                        qdev_get_gpio_in(DEVICE(&s->vic), 2));
> +    }
> +
> +    /* Net LAN 1*/
> +        qdev_set_nic_properties(DEVICE(&s->ftgmac100[1]), &nd_table[1]=
);
> +        object_property_set_bool(OBJECT(&s->ftgmac100[1]), true, "aspe=
ed", &err);
> +    if (s->scu.hw_strap1 & SCU_HW_STRAP_MAC1_RGMII) {
> +        qemu_log("%s: LAN1 enabled\n", __func__);
> +        object_property_set_bool(OBJECT(&s->ftgmac100[1]), true, "real=
ized",
> +                                &local_err);
> +        error_propagate(&err, local_err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100[1]), 0, ASPEED_SO=
C_ETH2_BASE);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[1]), 0,
> +                        qdev_get_gpio_in(DEVICE(&s->vic), 3));

I would use a loop such as :=20

    for (i =3D 0; i < nb_nics; i++) {
        NICInfo *nd =3D &nd_table[i];

  	/* test SCU ... */

  	...
    }

to realize the NICs.

>      }
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100), 0, ASPEED_SOC_ETH1_=
BASE);
> -    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100), 0,
> -                       qdev_get_gpio_in(DEVICE(&s->vic), 2));
> =20
>      /* iBT */
>      object_property_set_bool(OBJECT(&s->ibt), true, "realized", &err);
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> old mode 100644
> new mode 100755
> index 623223d..0799d61
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -47,7 +47,7 @@ typedef struct AspeedSoCState {
>      AspeedSMCState spi[ASPEED_SPIS_NUM];
>      AspeedSDMCState sdmc;
>      AspeedWDTState wdt[ASPEED_WDTS_NUM];
> -    FTGMAC100State ftgmac100;
> +    FTGMAC100State ftgmac100[2];

2 needs a macro.


I have a patchset currently being reviewed which should help you
to define the different addresses, interrupt numbers of the MACS.
Let me ping you when this is merge and then you can rebase.=20

However, you can send a patch for your board definition. There
should not be any conflicts with this addition.

Thanks,

C.




>      AspeedIBTState ibt;
>      AspeedGPIOState gpio;
>      AspeedPWMState pwm;
> --=20
> 2.7.4
>=20

