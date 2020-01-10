Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3F2C33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 10:10:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71BA22072A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 10:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71BA22072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iprFT-0001vm-Kf
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 05:10:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iprCz-0007Xx-Hw
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:08:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iprCx-000823-Hy
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:08:01 -0500
Received: from 6.mo7.mail-out.ovh.net ([188.165.39.218]:40645)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iprCx-0007u3-8e
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:07:59 -0500
Received: from player755.ha.ovh.net (unknown [10.108.42.82])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 7167214AEAD
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 11:07:57 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player755.ha.ovh.net (Postfix) with ESMTPSA id 8D256E24BD59;
 Fri, 10 Jan 2020 10:07:51 +0000 (UTC)
Subject: Re: [PATCH 2/5] hw/arm: ast2600: Wire up the eMMC controller
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200107073423.30043-1-clg@kaod.org>
 <20200107073423.30043-3-clg@kaod.org>
 <a7c45303-e624-d7aa-df6f-e03f26b3cba7@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c4d0b1dc-bba2-0260-6c4f-68f93c768077@kaod.org>
Date: Fri, 10 Jan 2020 11:07:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a7c45303-e624-d7aa-df6f-e03f26b3cba7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 5547590316271831872
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdeifedguddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeehhedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.39.218
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

On 1/7/20 9:25 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/7/20 8:34 AM, C=C3=A9dric Le Goater wrote:
>> From: Andrew Jeffery <andrew@aj.id.au>
>>
>> Initialise another SDHCI model instance for the AST2600's eMMC
>> controller and use the SDHCI's num_slots value introduced previously t=
o
>> determine whether we should create an SD card instance for the new slo=
t.
>>
>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>> =C2=A0 include/hw/arm/aspeed_soc.h |=C2=A0 2 ++
>> =C2=A0 hw/arm/aspeed.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 25 ++++++++++++++++---------
>> =C2=A0 hw/arm/aspeed_ast2600.c=C2=A0=C2=A0=C2=A0=C2=A0 | 21 ++++++++++=
+++++++++++
>> =C2=A0 3 files changed, 39 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
>> index e84380984f7b..90ac7f7ffa3b 100644
>> --- a/include/hw/arm/aspeed_soc.h
>> +++ b/include/hw/arm/aspeed_soc.h
>> @@ -57,6 +57,7 @@ typedef struct AspeedSoCState {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AspeedGPIOState gpio;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AspeedGPIOState gpio_1_8v;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AspeedSDHCIState sdhci;
>> +=C2=A0=C2=A0=C2=A0 AspeedSDHCIState emmc;
>> =C2=A0 } AspeedSoCState;
>> =C2=A0 =C2=A0 #define TYPE_ASPEED_SOC "aspeed-soc"
>> @@ -126,6 +127,7 @@ enum {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASPEED_MII4,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASPEED_SDRAM,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASPEED_XDMA,
>> +=C2=A0=C2=A0=C2=A0 ASPEED_EMMC,
>> =C2=A0 };
>> =C2=A0 =C2=A0 #endif /* ASPEED_SOC_H */
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>> index 4174e313cae5..0a7dfd29868b 100644
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -171,6 +171,18 @@ static void aspeed_board_init_flashes(AspeedSMCSt=
ate *s, const char *flashtype,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>> =C2=A0 +static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *d=
info)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockBackend *blk;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceState *card;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk =3D dinfo ? blk_by_leg=
acy_dinfo(dinfo) : NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 card =3D qdev_create(qdev_=
get_child_bus(DEVICE(sdhci), "sd-bus"),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 TYPE_SD_CARD);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_prop_set_drive(card, =
"drive", blk, &error_fatal);
>=20
> I find this form easier to review:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dinfo)=
 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 qdev_prop_set_drive(card, "drive",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_by_le=
gacy_dinfo(dinfo),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &error_fa=
tal);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }

yes.

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_set_bool(O=
BJECT(card), true, "realized", &error_fatal);
>> +}
>> +
>> =C2=A0 static void aspeed_machine_init(MachineState *machine)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AspeedBoardState *bmc;
>> @@ -264,16 +276,11 @@ static void aspeed_machine_init(MachineState *ma=
chine)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < bmc->soc.sdhci=
.num_slots; i++) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SDHCIState *sdhci =3D &bmc=
->soc.sdhci.slots[i];
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DriveInfo *dinfo =3D drive=
_get_next(IF_SD);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockBackend *blk;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceState *card;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sdhci_attach_drive(&bmc->s=
oc.sdhci.slots[i], drive_get_next(IF_SD));
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk =3D dinfo ? blk=
_by_legacy_dinfo(dinfo) : NULL;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 card =3D qdev_create(qdev_=
get_child_bus(DEVICE(sdhci), "sd-bus"),
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 TYPE_SD_CARD);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_prop_set_drive(card, =
"drive", blk, &error_fatal);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_set_bool(O=
BJECT(card), true, "realized", &error_fatal);
>> +=C2=A0=C2=A0=C2=A0 if (bmc->soc.emmc.num_slots) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sdhci_attach_drive(&bmc->s=
oc.emmc.slots[0], drive_get_next(IF_SD));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arm_load_kernel(ARM_CPU(first_cp=
u), machine, &aspeed_board_binfo);
>> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
>> index fb73c4043ea3..e59cdd291925 100644
>> --- a/hw/arm/aspeed_ast2600.c
>> +++ b/hw/arm/aspeed_ast2600.c
>> @@ -46,6 +46,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] =3D =
{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_ADC]=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D 0x1E6E9000,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_VIDEO]=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 0x1E700000,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_SDHCI]=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 0x1E740000,
>> +=C2=A0=C2=A0=C2=A0 [ASPEED_EMMC]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x=
1E750000,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_GPIO]=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D 0x1E780000,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_GPIO_1_8V] =3D 0x1E780800,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_RTC]=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D 0x1E781000,
>> @@ -64,6 +65,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] =3D =
{
>> =C2=A0 =C2=A0 #define ASPEED_SOC_AST2600_MAX_IRQ 128
>> =C2=A0 +/* Shared Peripheral Interrupt values below are offset by -32 =
from datasheet */
>> =C2=A0 static const int aspeed_soc_ast2600_irqmap[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_UART1]=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 47,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_UART2]=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 48,
>> @@ -77,6 +79,7 @@ static const int aspeed_soc_ast2600_irqmap[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_ADC]=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D 78,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_XDMA]=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D 6,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_SDHCI]=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D 43,
>> +=C2=A0=C2=A0=C2=A0 [ASPEED_EMMC]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 15=
,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_GPIO]=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D 40,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_GPIO_1_8V] =3D 11,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_RTC]=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D 13,
>> @@ -206,6 +209,14 @@ static void aspeed_soc_ast2600_init(Object *obj)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysbus_init_chi=
ld_obj(obj, "sdhci[*]", OBJECT(&s->sdhci.slots[i]),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(s->sdhci.slots[i]), TYPE_S=
YSBUS_SDHCI);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 sysbus_init_child_obj(obj, "emmc", OBJECT(&s->emmc=
), sizeof(s->emmc),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 TYPE_ASPEED_SDHCI);
>> +
>> +=C2=A0=C2=A0=C2=A0 object_property_set_int(OBJECT(&s->emmc), 1, "num-=
slots", &error_abort);
>> +
>> +=C2=A0=C2=A0=C2=A0 sysbus_init_child_obj(obj, "emmc[*]", OBJECT(&s->e=
mmc.slots[0]),
>=20
> Single block, so use "emmc" instead.
>=20
> Using "emmc":
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

I will do the fixes and resend.

Thanks,

C.=20


>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 si=
zeof(s->emmc.slots[0]), TYPE_SYSBUS_SDHCI);
>> =C2=A0 }
>> =C2=A0 =C2=A0 /*
>> @@ -497,6 +508,16 @@ static void aspeed_soc_ast2600_realize(DeviceStat=
e *dev, Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sc->memmap[ASPEED_=
SDHCI]);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(&s->s=
dhci), 0,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
aspeed_soc_get_irq(s, ASPEED_SDHCI));
>> +
>> +=C2=A0=C2=A0=C2=A0 /* eMMC */
>> +=C2=A0=C2=A0=C2=A0 object_property_set_bool(OBJECT(&s->emmc), true, "=
realized", &err);
>> +=C2=A0=C2=A0=C2=A0 if (err) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, err)=
;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&s->emmc), 0, sc->m=
emmap[ASPEED_EMMC]);
>> +=C2=A0=C2=A0=C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(&s->emmc), 0,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aspeed_so=
c_get_irq(s, ASPEED_EMMC));
>> =C2=A0 }
>> =C2=A0 =C2=A0 static void aspeed_soc_ast2600_class_init(ObjectClass *o=
c, void *data)
>>
>=20


