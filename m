Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164F2C04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 07:44:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6AC020815
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 07:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="rpl79his"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6AC020815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=eltan.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59567 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hScyG-0006uh-4d
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 03:44:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wvervoorn@eltan.com>) id 1hScxE-0006WW-Rz
	for qemu-devel@nongnu.org; Mon, 20 May 2019 03:43:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wvervoorn@eltan.com>) id 1hScxD-00071c-0J
	for qemu-devel@nongnu.org; Mon, 20 May 2019 03:43:28 -0400
Received: from cpsmtpb-ews02.kpnxchange.com ([213.75.39.5]:52984)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wvervoorn@eltan.com>)
	id 1hScxC-00070B-6q; Mon, 20 May 2019 03:43:26 -0400
Received: from cpsps-ews26.kpnxchange.com ([10.94.84.192]) by
	cpsmtpb-ews02.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514); 
	Mon, 20 May 2019 09:43:21 +0200
X-Brand: 7abm2Q==
X-KPN-SpamVerdict: e1=0;e2=0;e3=0;e4=(e4=10;e1=10;e3=10;e2=11);EVW:Whi
	te;BM:NotScanned;FinalVerdict:Clean
X-CMAE-Analysis: v=2.3 cv=ePTCc0h1 c=1 sm=1 tr=0 cx=a_idp_e
	a=dZ5u/0G9QtS9WKCcNUBnHQ==:117 a=dZ5u/0G9QtS9WKCcNUBnHQ==:17
	a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=eIHzyqS2sMcA:10 a=8nJEP1OIZ-IA:10
	a=xqWC_Br6kY4A:10 a=E5NmQfObTbMA:10 a=aow-egSQAAAA:8 a=X5F7dNyOAAAA:8
	a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=ID6ng7r3AAAA:8 a=91tezXpfAAAA:8
	a=pn6ru4JPoqBJmmpkdyEA:9 a=ost055EMga0DVaJk:21 a=x8rp8Tg9KyjXGnad:21
	a=wPNLvfGTeEIA:10 a=gFNbaldVC-z-bsjSTzMo:22 a=pS7LufLo7ZPxIL5li5Lt:22
	a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
	a=AkheI1RvQwOzcTXhi5f4:22 a=QzzagUt76mSoFDrDCo4I:22
X-CM-AcctID: kpn@feedback.cloudmark.com
Received: from smtp.kpnmail.nl ([195.121.84.13]) by cpsps-ews26.kpnxchange.com
	over TLS secured channel with Microsoft SMTPSVC(8.5.9600.16384);
	Mon, 20 May 2019 09:43:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=mime-version:content-type:message-id:date:subject:to:from;
	bh=YvNnGGiqzik9yLoBfItllN+CqFOvKviULyn2Yr3mbkA=;
	b=rpl79hisFxiwnY7nywOgOryhPD454VZGXwE2+s0sPaO0Zyx3Vh8eMh23DNU1O2WLrB27rQ4og+Hd0
	IiD49KvyPQOS/nnovjqixg/C8ebXyyaIz28TDgVT0Onzx51j6Z2W5+rhctYKaJBbMY+s9zAphEWHIv
	WqEZErEOtcFQyzNk=
Received: from Eltsrv03.Eltan.local (unknown [84.85.114.86])
	by smtp.kpnmail.nl (Halon) with ESMTPS
	id f0709b6f-7ad2-11e9-89e3-005056998788;
	Mon, 20 May 2019 09:43:21 +0200 (CEST)
Received: from Eltsrv03.Eltan.local (192.168.100.3) by Eltsrv03.Eltan.local
	(192.168.100.3) with Microsoft SMTP Server (TLS) id 15.0.847.32;
	Mon, 20 May 2019 09:42:45 +0200
Received: from Eltsrv03.Eltan.local ([fe80::24e7:1cc6:a76a:a3a8]) by
	Eltsrv03.Eltan.local ([fe80::24e7:1cc6:a76a:a3a8%12]) with mapi id
	15.00.0847.040; Mon, 20 May 2019 09:42:32 +0200
From: Wim Vervoorn <wvervoorn@eltan.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
	<qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>
Thread-Topic: aspeed qemu question
Thread-Index: AdULwnm8cADYiO1ZRNGvxixzeWIzuQAJZaCAACbA8VAAASgwgACVvbog
Date: Mon, 20 May 2019 07:42:32 +0000
Message-ID: <e1f87ee13d164655ae568b2d22f68128@Eltsrv03.Eltan.local>
References: <d0fea426e8b245769f3022dad121c17e@Eltsrv03.Eltan.local>
	<3ee8eb5a-d38c-9570-3da5-a055e9f147e5@kaod.org>
In-Reply-To: <3ee8eb5a-d38c-9570-3da5-a055e9f147e5@kaod.org>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.100.108]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginalArrivalTime: 20 May 2019 07:43:21.0297 (UTC)
	FILETIME=[B286C410:01D50EDF]
X-RcptDomain: nongnu.org
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 213.75.39.5
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

Hello C=E9dric,

It was not yet my intention to have this patch included in the qemu repo so=
 I didn't pay attention to checking the indentation etc. So I misunderstood=
 your suggestion. I am sorry about that.

I will address your remarks in a new patch.

Besides this I have another question.

First of all I don't think qemu should assert due to a lacking NIC definiti=
on on the commandline so that is why I think I am missing something.

Secondly I have started qemu with various attempts to define a 2nd NIC all =
with the same result (an assert). The issue with this is that I am not 100%=
 sure I am defining the NICs in the correct way. If you could provide me wi=
th a commandline that is known to be correct I can use that for testing.

Thanks for you patience.

Best Regards,
Wim Vervoorn


-----Original Message-----
From: C=E9dric Le Goater [mailto:clg@kaod.org]=20
Sent: Friday, May 17, 2019 12:08 PM
To: Wim Vervoorn <wvervoorn@eltan.com>; qemu-devel@nongnu.org; qemu-arm@non=
gnu.org; Joel Stanley <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>; P=
eter Maydell <peter.maydell@linaro.org>
Subject: Re: aspeed qemu question

Hello Win,

On 5/17/19 9:46 AM, Wim Vervoorn wrote:
> Hello Cedr=EDc,
>=20
> Thanks for your response. I created and attached the patch. You are right=
 the code snipped turns out unreadable.

You should try to send the patch directly and not attached. Checkout the gi=
t send-email commands for it. See also :

https://wiki.qemu.org/Contribute/SubmitAPatch

> In the patch I enable the MAC's depending on the value in hwstrap1 just a=
s in the real hardware. In the Palmetto both nics will be enabled (just as =
in the real palmetto).=20
>=20
> I added a 2nd AST2400 BMC the Eltan Piestewa Peak. Here I enabled the 2nd=
 NIC only.
>=20
> What I see is that when I use Palmetto I get an assert in net/net.c line =
256, this is in the "qemu_net_client_setup()". I assume I have to prepare s=
omething regarding the host side of the network implementation but I this p=
oint I have no clue what and I have a hard time figuring out how the networ=
king architecture really works.=20

Did you define two nics on the command line  ?

more comments below.

[ ... ]=20

> From bbf9392b84f38531b89e4ea39e06210b99ec7a0c Mon Sep 17 00:00:00 2001
> Message-Id:=20
> <bbf9392b84f38531b89e4ea39e06210b99ec7a0c.1558078463.git.wvervoorn@elt
> an.com>
> From: Wim Vervoorn <wvervoorn@eltan.com>
> Date: Fri, 17 May 2019 09:26:16 +0200
> Subject: [PATCH] ASPEED BMC: Add support for 2nd NIC
>=20
> Add support for 2nd NIC.
>=20
> This solution is using the hwstrap1 value to enable disable the=20
> controllers.

OK. Let see how this shows in the code.

> The Palmetto leaves both NICs enabled while the Piestewa Peak only=20
> enables one.

You should send two different patches, one for the NIC, one for Piestewa Pe=
ak machine.=20

> The Palmetto asserts in net/net.c line 256 when qemu starts so=20
> something must be missing to support the 2nd nic.

You need a "signed-off-by:" tag here

> ---
>  hw/arm/aspeed.c             | 26 ++++++++++++++++++++++
>  hw/arm/aspeed_soc.c         | 54 ++++++++++++++++++++++++++++++++-------=
------
>  include/hw/arm/aspeed_soc.h |  2 +-
>  3 files changed, 66 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c old mode 100644 new=20
> mode 100755 index 0203642..f957a5b
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -43,6 +43,23 @@ struct AspeedBoardState {
>          SCU_AST2400_HW_STRAP_SET_CLK_SOURCE(AST2400_CLK_48M_IN) |       =
\
>          SCU_HW_STRAP_VGA_CLASS_CODE |                                   =
\
>          SCU_HW_STRAP_LPC_RESET_PIN |                                    =
\
> +        SCU_HW_STRAP_MAC0_RGMII |                                       =
\
> +        SCU_HW_STRAP_MAC1_RGMII |                                       =
\
> +        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_M_S_EN) |                =
\
> +        SCU_AST2400_HW_STRAP_SET_CPU_AHB_RATIO(AST2400_CPU_AHB_RATIO_2_1=
) | \
> +        SCU_HW_STRAP_SPI_WIDTH |                                        =
\
> +        SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       =
\
> +        SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
> +
> +/* Piestewa Peak hardware value:  */
> +#define ELTANPWP_BMC_HW_STRAP1 (                                        =
\
> +        SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_256MB) |               =
\
> +        SCU_AST2400_HW_STRAP_DRAM_CONFIG(2 /* DDR3 with CL=3D6, CWL=3D5 =
*/) | \
> +        SCU_AST2400_HW_STRAP_ACPI_DIS |                                 =
\
> +        SCU_AST2400_HW_STRAP_SET_CLK_SOURCE(AST2400_CLK_48M_IN) |       =
\
> +        SCU_HW_STRAP_VGA_CLASS_CODE |                                   =
\
> +        SCU_HW_STRAP_LPC_RESET_PIN |                                    =
\
> +        SCU_HW_STRAP_MAC1_RGMII |                                       =
\
>          SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_M_S_EN) |                =
\
>          SCU_AST2400_HW_STRAP_SET_CPU_AHB_RATIO(AST2400_CPU_AHB_RATIO_2_1=
) | \
>          SCU_HW_STRAP_SPI_WIDTH |                                        =
\
> @@ -423,6 +440,15 @@ static const AspeedBoardConfig aspeed_boards[] =3D {
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
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c old mode 100644=20
> new mode 100755 index 0f6e5be..8ed7902
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -184,9 +184,13 @@ static void aspeed_soc_init(Object *obj)
>                                         OBJECT(&s->scu), &error_abort);
>      }
> =20
> -    object_initialize(&s->ftgmac100, sizeof(s->ftgmac100), TYPE_FTGMAC10=
0);
> -    object_property_add_child(obj, "ftgmac100", OBJECT(&s->ftgmac100), N=
ULL);
> -    qdev_set_parent_bus(DEVICE(&s->ftgmac100), sysbus_get_default());
> +    object_initialize(&s->ftgmac100[0], sizeof(s->ftgmac100), TYPE_FTGMA=
C100);
> +    object_property_add_child(obj, "ftgmac100[0]", OBJECT(&s->ftgmac100[=
0]), NULL);
> +    qdev_set_parent_bus(DEVICE(&s->ftgmac100[0]),=20
> + sysbus_get_default());
> +
> +    object_initialize(&s->ftgmac100[1], sizeof(s->ftgmac100), TYPE_FTGMA=
C100);
> +    object_property_add_child(obj, "ftgmac100[1]", OBJECT(&s->ftgmac100[=
1]), NULL);
> +    qdev_set_parent_bus(DEVICE(&s->ftgmac100[1]),=20
> + sysbus_get_default());

using a loop would be better. The future Aspeed SoCs might have more than t=
wo MACs.
> =20
>      object_initialize(&s->ibt, sizeof(s->ibt), TYPE_ASPEED_IBT);
>      object_property_add_child(obj, "bt", OBJECT(&s->ibt), NULL); @@=20
> -384,19 +388,39 @@ static void aspeed_soc_realize(DeviceState *dev, Error=
 **errp)
>                          ASPEED_SOC_WDT_BASE + i * 0x20);
>      }
> =20
> -    /* Net */
> -    qdev_set_nic_properties(DEVICE(&s->ftgmac100), &nd_table[0]);
> -    object_property_set_bool(OBJECT(&s->ftgmac100), true, "aspeed", &err=
);
> -    object_property_set_bool(OBJECT(&s->ftgmac100), true, "realized",
> -                             &local_err);
> -    error_propagate(&err, local_err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        return;
> +    /* Net LAN 0*/
> +        qdev_set_nic_properties(DEVICE(&s->ftgmac100[0]), &nd_table[0]);
> +        object_property_set_bool(OBJECT(&s->ftgmac100[0]), true,=20
> + "aspeed", &err);

This is not the correct indentation. Please run checkpatch.pl on the patch.

> +    if (s->scu.hw_strap1 & SCU_HW_STRAP_MAC0_RGMII) {
> +        qemu_log("%s: LAN0 enabled\n", __func__);

we don't need this kind of information.

> +        object_property_set_bool(OBJECT(&s->ftgmac100[0]), true, "realiz=
ed",
> +                                &local_err);
> +        error_propagate(&err, local_err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100[0]), 0, ASPEED_SOC_=
ETH1_BASE);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[0]), 0,
> +                        qdev_get_gpio_in(DEVICE(&s->vic), 2));
> +    }
> +
> +    /* Net LAN 1*/
> +        qdev_set_nic_properties(DEVICE(&s->ftgmac100[1]), &nd_table[1]);
> +        object_property_set_bool(OBJECT(&s->ftgmac100[1]), true, "aspeed=
", &err);
> +    if (s->scu.hw_strap1 & SCU_HW_STRAP_MAC1_RGMII) {
> +        qemu_log("%s: LAN1 enabled\n", __func__);
> +        object_property_set_bool(OBJECT(&s->ftgmac100[1]), true, "realiz=
ed",
> +                                &local_err);
> +        error_propagate(&err, local_err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100[1]), 0, ASPEED_SOC_=
ETH2_BASE);
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
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100), 0, ASPEED_SOC_ETH1_BA=
SE);
> -    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100), 0,
> -                       qdev_get_gpio_in(DEVICE(&s->vic), 2));
> =20
>      /* iBT */
>      object_property_set_bool(OBJECT(&s->ibt), true, "realized",=20
> &err); diff --git a/include/hw/arm/aspeed_soc.h=20
> b/include/hw/arm/aspeed_soc.h old mode 100644 new mode 100755 index=20
> 623223d..0799d61
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -47,7 +47,7 @@ typedef struct AspeedSoCState {
>      AspeedSMCState spi[ASPEED_SPIS_NUM];
>      AspeedSDMCState sdmc;
>      AspeedWDTState wdt[ASPEED_WDTS_NUM];
> -    FTGMAC100State ftgmac100;
> +    FTGMAC100State ftgmac100[2];

2 needs a macro.


I have a patchset currently being reviewed which should help you to define =
the different addresses, interrupt numbers of the MACS.
Let me ping you when this is merge and then you can rebase.=20

However, you can send a patch for your board definition. There should not b=
e any conflicts with this addition.

Thanks,

C.




>      AspeedIBTState ibt;
>      AspeedGPIOState gpio;
>      AspeedPWMState pwm;
> --
> 2.7.4
>=20



