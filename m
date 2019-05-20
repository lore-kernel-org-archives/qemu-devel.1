Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EBEC46470
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 15:31:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A29E2081C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 15:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A29E2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37255 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSkFz-0001mi-B1
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 11:31:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hSkED-0000mx-1V
	for qemu-devel@nongnu.org; Mon, 20 May 2019 11:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hSkEA-0004SO-Kv
	for qemu-devel@nongnu.org; Mon, 20 May 2019 11:29:28 -0400
Received: from 10.mo179.mail-out.ovh.net ([46.105.79.46]:59097)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hSkE9-0004QP-9c
	for qemu-devel@nongnu.org; Mon, 20 May 2019 11:29:26 -0400
Received: from player776.ha.ovh.net (unknown [10.109.146.32])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 63B8F1312B1
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 17:29:22 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n0.emea.ibm.com [195.212.29.162])
	(Authenticated sender: clg@kaod.org)
	by player776.ha.ovh.net (Postfix) with ESMTPSA id 3D3AA5F03391;
	Mon, 20 May 2019 15:29:15 +0000 (UTC)
To: Wim Vervoorn <wvervoorn@eltan.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
	Peter Maydell <peter.maydell@linaro.org>
References: <d0fea426e8b245769f3022dad121c17e@Eltsrv03.Eltan.local>
	<3ee8eb5a-d38c-9570-3da5-a055e9f147e5@kaod.org>
	<e1f87ee13d164655ae568b2d22f68128@Eltsrv03.Eltan.local>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a2f73f2e-31bd-9585-1206-49e5a26f2de0@kaod.org>
Date: Mon, 20 May 2019 17:29:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e1f87ee13d164655ae568b2d22f68128@Eltsrv03.Eltan.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 14398570961849846545
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddtkedgkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.79.46
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

Hello Wim,

On 5/20/19 9:42 AM, Wim Vervoorn wrote:
> Hello C=C3=A9dric,
>=20
> It was not yet my intention to have this patch included in the qemu rep=
o so I didn't pay attention to checking the indentation etc. So I misunde=
rstood your suggestion. I am sorry about that.
>=20
> I will address your remarks in a new patch.
>=20
> Besides this I have another question.
>=20
> First of all I don't think qemu should assert due to a lacking NIC defi=
nition on the commandline so that is why I think I am missing something.

I think there is another problem.=20

In hw/net/ftgmac100.c, this line in ftgmac100_realize() should be removed=
 :

	s->conf.peers.ncs[0] =3D nd_table[0].netdev;

I will send a fix.


> Secondly I have started qemu with various attempts to define a 2nd NIC =
all with the same result (an assert). The issue with this is that I am no=
t 100% sure I am defining the NICs in the correct way. If you could provi=
de me with a commandline that is known to be correct I can use that for t=
esting.

You could use two devices such as :=20

 -net nic,macaddr=3DC0:FF:EE:00:00:02,model=3Dftgmac100 -net user,id=3Dne=
tdev0=20
 -net nic,macaddr=3DC0:FF:EE:00:00:04,model=3Dftgmac100 -net user,id=3Dne=
tdev1

Providing you have the correct DT, you should see something like :

[    3.628410] libphy: Fixed MDIO Bus: probed
[    3.631462] ftgmac100 1e660000.ethernet: Read MAC address c0:ff:ee:00:=
00:02 from chip
[    3.631835] ftgmac100 1e660000.ethernet: Using NCSI interface
[    3.646027] ftgmac100 1e660000.ethernet eth0: irq 19, mapped at (ptrva=
l)
[    3.647308] ftgmac100 1e680000.ethernet: Read MAC address c0:ff:ee:00:=
00:04 from chip
[    4.120223] libphy: ftgmac100_mdio: probed
[    4.121590] RTL8211E Gigabit Ethernet 1e680000.ethernet--1:00: attache=
d PHY driver [RTL8211E Gigabit Ethernet] (mii_bus:phy_addr=3D1e680000.eth=
ernet--1:00, irq=3DPOLL)
[    4.134884] ftgmac100 1e680000.ethernet eth1: irq 20, mapped at (ptrva=
l)

Regards,

C.



> Thanks for you patience.
>=20
> Best Regards,
> Wim Vervoorn
>=20
>=20
> -----Original Message-----
> From: C=C3=A9dric Le Goater [mailto:clg@kaod.org]=20
> Sent: Friday, May 17, 2019 12:08 PM
> To: Wim Vervoorn <wvervoorn@eltan.com>; qemu-devel@nongnu.org; qemu-arm=
@nongnu.org; Joel Stanley <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.=
au>; Peter Maydell <peter.maydell@linaro.org>
> Subject: Re: aspeed qemu question
>=20
> Hello Win,
>=20
> On 5/17/19 9:46 AM, Wim Vervoorn wrote:
>> Hello Cedr=C3=ADc,
>>
>> Thanks for your response. I created and attached the patch. You are ri=
ght the code snipped turns out unreadable.
>=20
> You should try to send the patch directly and not attached. Checkout th=
e git send-email commands for it. See also :
>=20
> https://wiki.qemu.org/Contribute/SubmitAPatch
>=20
>> In the patch I enable the MAC's depending on the value in hwstrap1 jus=
t as in the real hardware. In the Palmetto both nics will be enabled (jus=
t as in the real palmetto).=20
>>
>> I added a 2nd AST2400 BMC the Eltan Piestewa Peak. Here I enabled the =
2nd NIC only.
>>
>> What I see is that when I use Palmetto I get an assert in net/net.c li=
ne 256, this is in the "qemu_net_client_setup()". I assume I have to prep=
are something regarding the host side of the network implementation but I=
 this point I have no clue what and I have a hard time figuring out how t=
he networking architecture really works.=20
>=20
> Did you define two nics on the command line  ?
>=20
> more comments below.
>=20
> [ ... ]=20
>=20
>> From bbf9392b84f38531b89e4ea39e06210b99ec7a0c Mon Sep 17 00:00:00 2001
>> Message-Id:=20
>> <bbf9392b84f38531b89e4ea39e06210b99ec7a0c.1558078463.git.wvervoorn@elt
>> an.com>
>> From: Wim Vervoorn <wvervoorn@eltan.com>
>> Date: Fri, 17 May 2019 09:26:16 +0200
>> Subject: [PATCH] ASPEED BMC: Add support for 2nd NIC
>>
>> Add support for 2nd NIC.
>>
>> This solution is using the hwstrap1 value to enable disable the=20
>> controllers.
>=20
> OK. Let see how this shows in the code.
>=20
>> The Palmetto leaves both NICs enabled while the Piestewa Peak only=20
>> enables one.
>=20
> You should send two different patches, one for the NIC, one for Piestew=
a Peak machine.=20
>=20
>> The Palmetto asserts in net/net.c line 256 when qemu starts so=20
>> something must be missing to support the 2nd nic.
>=20
> You need a "signed-off-by:" tag here
>=20
>> ---
>>  hw/arm/aspeed.c             | 26 ++++++++++++++++++++++
>>  hw/arm/aspeed_soc.c         | 54 ++++++++++++++++++++++++++++++++----=
---------
>>  include/hw/arm/aspeed_soc.h |  2 +-
>>  3 files changed, 66 insertions(+), 16 deletions(-)
>>
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c old mode 100644 new=20
>> mode 100755 index 0203642..f957a5b
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -43,6 +43,23 @@ struct AspeedBoardState {
>>          SCU_AST2400_HW_STRAP_SET_CLK_SOURCE(AST2400_CLK_48M_IN) |    =
   \
>>          SCU_HW_STRAP_VGA_CLASS_CODE |                                =
   \
>>          SCU_HW_STRAP_LPC_RESET_PIN |                                 =
   \
>> +        SCU_HW_STRAP_MAC0_RGMII |                                    =
   \
>> +        SCU_HW_STRAP_MAC1_RGMII |                                    =
   \
>> +        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_M_S_EN) |             =
   \
>> +        SCU_AST2400_HW_STRAP_SET_CPU_AHB_RATIO(AST2400_CPU_AHB_RATIO_=
2_1) | \
>> +        SCU_HW_STRAP_SPI_WIDTH |                                     =
   \
>> +        SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                    =
   \
>> +        SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
>> +
>> +/* Piestewa Peak hardware value:  */
>> +#define ELTANPWP_BMC_HW_STRAP1 (                                     =
   \
>> +        SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_256MB) |            =
   \
>> +        SCU_AST2400_HW_STRAP_DRAM_CONFIG(2 /* DDR3 with CL=3D6, CWL=3D=
5 */) | \
>> +        SCU_AST2400_HW_STRAP_ACPI_DIS |                              =
   \
>> +        SCU_AST2400_HW_STRAP_SET_CLK_SOURCE(AST2400_CLK_48M_IN) |    =
   \
>> +        SCU_HW_STRAP_VGA_CLASS_CODE |                                =
   \
>> +        SCU_HW_STRAP_LPC_RESET_PIN |                                 =
   \
>> +        SCU_HW_STRAP_MAC1_RGMII |                                    =
   \
>>          SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_M_S_EN) |             =
   \
>>          SCU_AST2400_HW_STRAP_SET_CPU_AHB_RATIO(AST2400_CPU_AHB_RATIO_=
2_1) | \
>>          SCU_HW_STRAP_SPI_WIDTH |                                     =
   \
>> @@ -423,6 +440,15 @@ static const AspeedBoardConfig aspeed_boards[] =3D=
 {
>>          .num_cs    =3D 1,
>>          .i2c_init  =3D palmetto_bmc_i2c_init,
>>      }, {
>> +        .name      =3D MACHINE_TYPE_NAME("eltanpwp-bmc"),
>> +        .desc      =3D "Eltan Piestewa Peak BMC (ARM926EJ-S)",
>> +        .soc_name  =3D "ast2400-a1",
>> +        .hw_strap1 =3D ELTANPWP_BMC_HW_STRAP1,
>> +        .fmc_model =3D "n25q256a",
>> +        .spi_model =3D "mx25l25635e",
>=20
> Are these the correct flash models for your board ?=20
>=20
>> +        .num_cs    =3D 1,
>> +        .i2c_init  =3D palmetto_bmc_i2c_init,
>> +    }, {
>>          .name      =3D MACHINE_TYPE_NAME("ast2500-evb"),
>>          .desc      =3D "Aspeed AST2500 EVB (ARM1176)",
>>          .soc_name  =3D "ast2500-a1",
>> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c old mode 100644=
=20
>> new mode 100755 index 0f6e5be..8ed7902
>> --- a/hw/arm/aspeed_soc.c
>> +++ b/hw/arm/aspeed_soc.c
>> @@ -184,9 +184,13 @@ static void aspeed_soc_init(Object *obj)
>>                                         OBJECT(&s->scu), &error_abort)=
;
>>      }
>> =20
>> -    object_initialize(&s->ftgmac100, sizeof(s->ftgmac100), TYPE_FTGMA=
C100);
>> -    object_property_add_child(obj, "ftgmac100", OBJECT(&s->ftgmac100)=
, NULL);
>> -    qdev_set_parent_bus(DEVICE(&s->ftgmac100), sysbus_get_default());
>> +    object_initialize(&s->ftgmac100[0], sizeof(s->ftgmac100), TYPE_FT=
GMAC100);
>> +    object_property_add_child(obj, "ftgmac100[0]", OBJECT(&s->ftgmac1=
00[0]), NULL);
>> +    qdev_set_parent_bus(DEVICE(&s->ftgmac100[0]),=20
>> + sysbus_get_default());
>> +
>> +    object_initialize(&s->ftgmac100[1], sizeof(s->ftgmac100), TYPE_FT=
GMAC100);
>> +    object_property_add_child(obj, "ftgmac100[1]", OBJECT(&s->ftgmac1=
00[1]), NULL);
>> +    qdev_set_parent_bus(DEVICE(&s->ftgmac100[1]),=20
>> + sysbus_get_default());
>=20
> using a loop would be better. The future Aspeed SoCs might have more th=
an two MACs.
>> =20
>>      object_initialize(&s->ibt, sizeof(s->ibt), TYPE_ASPEED_IBT);
>>      object_property_add_child(obj, "bt", OBJECT(&s->ibt), NULL); @@=20
>> -384,19 +388,39 @@ static void aspeed_soc_realize(DeviceState *dev, Er=
ror **errp)
>>                          ASPEED_SOC_WDT_BASE + i * 0x20);
>>      }
>> =20
>> -    /* Net */
>> -    qdev_set_nic_properties(DEVICE(&s->ftgmac100), &nd_table[0]);
>> -    object_property_set_bool(OBJECT(&s->ftgmac100), true, "aspeed", &=
err);
>> -    object_property_set_bool(OBJECT(&s->ftgmac100), true, "realized",
>> -                             &local_err);
>> -    error_propagate(&err, local_err);
>> -    if (err) {
>> -        error_propagate(errp, err);
>> -        return;
>> +    /* Net LAN 0*/
>> +        qdev_set_nic_properties(DEVICE(&s->ftgmac100[0]), &nd_table[0=
]);
>> +        object_property_set_bool(OBJECT(&s->ftgmac100[0]), true,=20
>> + "aspeed", &err);
>=20
> This is not the correct indentation. Please run checkpatch.pl on the pa=
tch.
>=20
>> +    if (s->scu.hw_strap1 & SCU_HW_STRAP_MAC0_RGMII) {
>> +        qemu_log("%s: LAN0 enabled\n", __func__);
>=20
> we don't need this kind of information.
>=20
>> +        object_property_set_bool(OBJECT(&s->ftgmac100[0]), true, "rea=
lized",
>> +                                &local_err);
>> +        error_propagate(&err, local_err);
>> +        if (err) {
>> +            error_propagate(errp, err);
>> +            return;
>> +        }
>> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100[0]), 0, ASPEED_S=
OC_ETH1_BASE);
>> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[0]), 0,
>> +                        qdev_get_gpio_in(DEVICE(&s->vic), 2));
>> +    }
>> +
>> +    /* Net LAN 1*/
>> +        qdev_set_nic_properties(DEVICE(&s->ftgmac100[1]), &nd_table[1=
]);
>> +        object_property_set_bool(OBJECT(&s->ftgmac100[1]), true, "asp=
eed", &err);
>> +    if (s->scu.hw_strap1 & SCU_HW_STRAP_MAC1_RGMII) {
>> +        qemu_log("%s: LAN1 enabled\n", __func__);
>> +        object_property_set_bool(OBJECT(&s->ftgmac100[1]), true, "rea=
lized",
>> +                                &local_err);
>> +        error_propagate(&err, local_err);
>> +        if (err) {
>> +            error_propagate(errp, err);
>> +            return;
>> +        }
>> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100[1]), 0, ASPEED_S=
OC_ETH2_BASE);
>> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[1]), 0,
>> +                        qdev_get_gpio_in(DEVICE(&s->vic), 3));
>=20
> I would use a loop such as :=20
>=20
>     for (i =3D 0; i < nb_nics; i++) {
>         NICInfo *nd =3D &nd_table[i];
>=20
>   	/* test SCU ... */
>=20
>   	...
>     }
>=20
> to realize the NICs.
>=20
>>      }
>> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100), 0, ASPEED_SOC_ETH1=
_BASE);
>> -    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100), 0,
>> -                       qdev_get_gpio_in(DEVICE(&s->vic), 2));
>> =20
>>      /* iBT */
>>      object_property_set_bool(OBJECT(&s->ibt), true, "realized",=20
>> &err); diff --git a/include/hw/arm/aspeed_soc.h=20
>> b/include/hw/arm/aspeed_soc.h old mode 100644 new mode 100755 index=20
>> 623223d..0799d61
>> --- a/include/hw/arm/aspeed_soc.h
>> +++ b/include/hw/arm/aspeed_soc.h
>> @@ -47,7 +47,7 @@ typedef struct AspeedSoCState {
>>      AspeedSMCState spi[ASPEED_SPIS_NUM];
>>      AspeedSDMCState sdmc;
>>      AspeedWDTState wdt[ASPEED_WDTS_NUM];
>> -    FTGMAC100State ftgmac100;
>> +    FTGMAC100State ftgmac100[2];
>=20
> 2 needs a macro.
>=20
>=20
> I have a patchset currently being reviewed which should help you to def=
ine the different addresses, interrupt numbers of the MACS.
> Let me ping you when this is merge and then you can rebase.=20
>=20
> However, you can send a patch for your board definition. There should n=
ot be any conflicts with this addition.
>=20
> Thanks,
>=20
> C.
>=20
>=20
>=20
>=20
>>      AspeedIBTState ibt;
>>      AspeedGPIOState gpio;
>>      AspeedPWMState pwm;
>> --
>> 2.7.4
>>
>=20
>=20


