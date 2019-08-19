Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF8AC3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 06:42:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FD792086C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 06:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD792086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzbNa-0003Y0-GS
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 02:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1hzbMs-00035k-GU
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 02:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hzbMp-0007Uj-Os
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 02:42:14 -0400
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:33664)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hzbMp-0007Rr-Fq
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 02:42:11 -0400
Received: from player738.ha.ovh.net (unknown [10.108.57.95])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 780B76715C
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 08:42:02 +0200 (CEST)
Received: from kaod.org (lfbn-ren-1-123-36.w83-205.abo.wanadoo.fr
 [83.205.208.36]) (Authenticated sender: clg@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id 0788E90B74EF;
 Mon, 19 Aug 2019 06:41:54 +0000 (UTC)
To: Eddie James <eajames@linux.ibm.com>, qemu-devel@nongnu.org
References: <1565814456-1264-1-git-send-email-eajames@linux.ibm.com>
 <ca560d31-25ca-5d48-a16a-4fdf74f4779b@kaod.org>
 <24e21dd0-55b8-a5df-57da-2d68bee204a0@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a1cc29a1-cc4d-4786-758e-54a1391f846a@kaod.org>
Date: Mon, 19 Aug 2019 08:41:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <24e21dd0-55b8-a5df-57da-2d68bee204a0@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 4951989268186237713
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudefkedguddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.73.241
Subject: Re: [Qemu-devel] [RFC v2] hw/sd/aspeed_sdhci: New device
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
Cc: andrew@aj.id.au, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/08/2019 22:13, Eddie James wrote:
>=20
> On 8/15/19 3:05 AM, C=C3=A9dric Le Goater wrote:
>> Hello Eddie,
>>
>> On 14/08/2019 22:27, Eddie James wrote:
>>> The Aspeed SOCs have two SD/MMC controllers. Add a device that
>>> encapsulates both of these controllers and models the Aspeed-specific
>>> registers and behavior.
>>>
>>> Tested by reading from mmcblk0 in Linux:
>>> qemu-system-arm -machine romulus-bmc -nographic -serial mon:stdio \
>>> =C2=A0 -drive file=3D_tmp/flash-romulus,format=3Draw,if=3Dmtd \
>>> =C2=A0 -device sd-card,drive=3Dsd0 -drive file=3D_tmp/kernel,format=3D=
raw,if=3Dsd
>>>
>>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>>> ---
>>> This patch applies on top of Cedric's set of recent Aspeed changes. T=
herefore,
>>> I'm sending as an RFC rather than a patch.
>> yes. we can worked that out when the patch is reviewed. You can base o=
n
>> mainline when ready. My tree serves as an overall test base.
>>
>>> Changes since v1:
>>> =C2=A0 - Move slot realize code into the Aspeed SDHCI realize functio=
n
>>> =C2=A0 - Fix interrupt handling by creating input irqs and connecting=
 them to the
>>> =C2=A0=C2=A0=C2=A0 slot irqs.
>>> =C2=A0 - Removed card device creation code
>> I think all the code is here but it needs some more reshuffling :)
>> =C2=A0 The raspi machine is a good source for modelling pratices.
>>
>>> =C2=A0 hw/arm/aspeed.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
>>> =C2=A0 hw/arm/aspeed_soc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 24 ++++++
>>> =C2=A0 hw/sd/Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>> =C2=A0 hw/sd/aspeed_sdhci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 190 +++++++++++++++++++++++++++++++++++++++++++
>>> =C2=A0 include/hw/arm/aspeed_soc.h=C2=A0 |=C2=A0=C2=A0 3 +
>>> =C2=A0 include/hw/sd/aspeed_sdhci.h |=C2=A0 35 ++++++++
>>> =C2=A0 6 files changed, 253 insertions(+), 1 deletion(-)
>>> =C2=A0 create mode 100644 hw/sd/aspeed_sdhci.c
>>> =C2=A0 create mode 100644 include/hw/sd/aspeed_sdhci.h
>>>
>>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>>> index 2574425..aeed5b6 100644
>>> --- a/hw/arm/aspeed.c
>>> +++ b/hw/arm/aspeed.c
>>> @@ -480,7 +480,6 @@ static void aspeed_machine_class_init(ObjectClass=
 *oc, void *data)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mc->desc =3D board->desc;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mc->init =3D aspeed_machine_init;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mc->max_cpus =3D ASPEED_CPUS_NUM;
>>> -=C2=A0=C2=A0=C2=A0 mc->no_sdcard =3D 1;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mc->no_floppy =3D 1;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mc->no_cdrom =3D 1;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mc->no_parallel =3D 1;
>>> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
>>> index 8df96f2..a12f14a 100644
>>> --- a/hw/arm/aspeed_soc.c
>>> +++ b/hw/arm/aspeed_soc.c
>>> @@ -22,6 +22,7 @@
>>> =C2=A0 #include "qemu/error-report.h"
>>> =C2=A0 #include "hw/i2c/aspeed_i2c.h"
>>> =C2=A0 #include "net/net.h"
>>> +#include "sysemu/blockdev.h"
>> I would expect block devices to be handled at the machine level in
>> aspeed.c, like the flash devices are. Something like :
>=20
>=20
> OK, I did have that in v1 but Peter mentioned it was typically done at =
the command line?=20

yes, indeed. This works also and this is less code which is even better.

> I guess it can go in aspeed.c too.

Well, let's do without if we can. =20

We might be able to get rid of aspeed_board_init_flashes() now.=20

We should start writing a QEMU cookbook page on the OpenBMC wiki to=20
document the Aspeed machine command line. =20


>=20
>=20
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 /* Create and plug in the SD cards */
>> =C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < ASPEED_SDHCI_NUM_SLOTS; i++=
) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BusState *bus;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DriveInfo *di =3D dri=
ve_get_next(IF_SD);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockBackend *blk =3D=
 di ? blk_by_legacy_dinfo(di) : NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceState *carddev;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus =3D qdev_get_chil=
d_bus(DEVICE(&s->soc), "sd-bus");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!bus) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 error_report("No SD bus found for SD card %d", i);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 exit(1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 carddev =3D qdev_crea=
te(bus, TYPE_SD_CARD);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_prop_set_drive(c=
arddev, "drive", blk, &error_fatal);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_set_b=
ool(OBJECT(carddev), true, "realized",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &error_fatal);
>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>>> =C2=A0 =C2=A0 #define ASPEED_SOC_IOMEM_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x00200000
>>> =C2=A0 @@ -62,6 +63,7 @@ static const hwaddr aspeed_soc_ast2500_memma=
p[] =3D {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_XDMA]=C2=A0=C2=A0 =3D 0x1E6E70=
00,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_ADC]=C2=A0=C2=A0=C2=A0 =3D 0x1=
E6E9000,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_SRAM]=C2=A0=C2=A0 =3D 0x1E7200=
00,
>>> +=C2=A0=C2=A0=C2=A0 [ASPEED_SDHCI]=C2=A0 =3D 0x1E740000,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_GPIO]=C2=A0=C2=A0 =3D 0x1E7800=
00,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_RTC]=C2=A0=C2=A0=C2=A0 =3D 0x1=
E781000,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_TIMER1] =3D 0x1E782000,
>>> @@ -100,6 +102,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] =3D=
 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_XDMA]=C2=A0=C2=A0 =3D 0x1E6E70=
00,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_ADC]=C2=A0=C2=A0=C2=A0 =3D 0x1=
E6E9000,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_VIDEO]=C2=A0 =3D 0x1E700000,
>>> +=C2=A0=C2=A0=C2=A0 [ASPEED_SDHCI]=C2=A0 =3D 0x1E740000,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_GPIO]=C2=A0=C2=A0 =3D 0x1E7800=
00,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_RTC]=C2=A0=C2=A0=C2=A0 =3D 0x1=
E781000,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_TIMER1] =3D 0x1E782000,
>>> @@ -146,6 +149,7 @@ static const int aspeed_soc_ast2400_irqmap[] =3D =
{
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_ETH1]=C2=A0=C2=A0 =3D 2,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_ETH2]=C2=A0=C2=A0 =3D 3,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_XDMA]=C2=A0=C2=A0 =3D 6,
>>> +=C2=A0=C2=A0=C2=A0 [ASPEED_SDHCI]=C2=A0 =3D 26,
>>> =C2=A0 };
>>> =C2=A0 =C2=A0 #define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_ir=
qmap
>>> @@ -163,6 +167,7 @@ static const int aspeed_soc_ast2600_irqmap[] =3D =
{
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_SDMC]=C2=A0=C2=A0 =3D 0,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_SCU]=C2=A0=C2=A0=C2=A0 =3D 12,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_XDMA]=C2=A0=C2=A0 =3D 6,
>>> +=C2=A0=C2=A0=C2=A0 [ASPEED_SDHCI]=C2=A0 =3D 43,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_ADC]=C2=A0=C2=A0=C2=A0 =3D 46,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_GPIO]=C2=A0=C2=A0 =3D 40,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_RTC]=C2=A0=C2=A0=C2=A0 =3D 13,
>>> @@ -350,6 +355,15 @@ static void aspeed_soc_init(Object *obj)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysbus_init_ch=
ild_obj(obj, "fsi[*]", OBJECT(&s->fsi[0]),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(s->fsi[0]), TYPE_ASPEED=
_FSI);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 sysbus_init_child_obj(obj, "sdhci", OBJECT(&s->sd=
hci), sizeof(s->sdhci),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 TYPE_ASPEED_SDHCI);
>> This is the Aspeed SD host interface. May be we should call it sdhost =
?
>>
>> I suppose this is our "sd-bus" device ?
>>
>>> +=C2=A0=C2=A0=C2=A0 /* Init sd card slot class here so that they're u=
nder the correct parent */
>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
>> and these are the slots, I would put them at the SoC level.
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysbus_init_child_obj(obj=
, "sdhci_slot[*]", OBJECT(&s->sdhci.slots[i]),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(s->sdhci.slots[i]), TYPE_SYSBUS_SDH=
CI);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 }
>>> =C2=A0 =C2=A0 /*
>>> @@ -680,6 +694,16 @@ static void aspeed_soc_realize(DeviceState *dev,=
 Error **errp)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysbus_connect=
_irq(SYS_BUS_DEVICE(&s->fsi[0]), 0,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 aspeed_soc_get_irq(s, ASPEED_FSI1));
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* SD/SDIO - set the reg address so slot memory m=
apping can be set up */
>>> +=C2=A0=C2=A0=C2=A0 s->sdhci.ioaddr =3D sc->info->memmap[ASPEED_SDHCI=
];
>> That's weird. We do all mappings in the SoC.
>>
>> I think you should be realizing the slots here also. See the other SoC=
s,
>> XlnxZynqMPState for instance.
>>
>>> +=C2=A0=C2=A0=C2=A0 object_property_set_bool(OBJECT(&s->sdhci), true,=
 "realized", &err);
>>> +=C2=A0=C2=A0=C2=A0 if (err) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, err=
);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aspeed_so=
c_get_irq(s, ASPEED_SDHCI));
>>>
>>> =C2=A0 }
>>> =C2=A0 static Property aspeed_soc_properties[] =3D {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_UINT32("num-cpus", AspeedS=
oCState, num_cpus, 0),
>>> diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
>>> index 0665727..a884c23 100644
>>> --- a/hw/sd/Makefile.objs
>>> +++ b/hw/sd/Makefile.objs
>>> @@ -8,3 +8,4 @@ obj-$(CONFIG_MILKYMIST) +=3D milkymist-memcard.o
>>> =C2=A0 obj-$(CONFIG_OMAP) +=3D omap_mmc.o
>>> =C2=A0 obj-$(CONFIG_PXA2XX) +=3D pxa2xx_mmci.o
>>> =C2=A0 obj-$(CONFIG_RASPI) +=3D bcm2835_sdhost.o
>>> +obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_sdhci.o
>>> diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
>>> new file mode 100644
>>> index 0000000..d1a05e9
>>> --- /dev/null
>>> +++ b/hw/sd/aspeed_sdhci.c
>>> @@ -0,0 +1,190 @@
>>> +/*
>>> + * Aspeed SD Host Controller
>>> + * Eddie James <eajames@linux.ibm.com>
>>> + *
>>> + * Copyright (C) 2019 IBM Corp
>>> + * SPDX-License-Identifer: GPL-2.0-or-later
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qemu/log.h"
>>> +#include "qemu/error-report.h"
>>> +#include "hw/sd/aspeed_sdhci.h"
>>> +#include "qapi/error.h"
>>> +
>>> +#define ASPEED_SDHCI_INFO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0x00
>>> +#define=C2=A0 ASPEED_SDHCI_INFO_RESET=C2=A0=C2=A0=C2=A0=C2=A0 0x0003=
0000
>>> +#define ASPEED_SDHCI_DEBOUNCE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x04
>>> +#define=C2=A0 ASPEED_SDHCI_DEBOUNCE_RESET 0x00000005
>>> +#define ASPEED_SDHCI_BUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x08
>>> +#define ASPEED_SDHCI_SDIO_140=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x10
>>> +#define ASPEED_SDHCI_SDIO_148=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x18
>>> +#define ASPEED_SDHCI_SDIO_240=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x20
>>> +#define ASPEED_SDHCI_SDIO_248=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x28
>>> +#define ASPEED_SDHCI_WP_POL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0xec
>>> +#define ASPEED_SDHCI_CARD_DET=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0xf0
>>> +#define ASPEED_SDHCI_IRQ_STAT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0xfc
>>> +
>>> +#define TO_REG(addr) ((addr) / sizeof(uint32_t))
>>> +
>>> +static uint64_t aspeed_sdhci_read(void *opaque, hwaddr addr, unsigne=
d int size)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 uint32_t val =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 AspeedSDHCIState *sdhci =3D opaque;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 switch (addr) {
>>> +=C2=A0=C2=A0=C2=A0 case ASPEED_SDHCI_SDIO_140:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D (uint32_t)sdhci->=
slots[0].capareg;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0 case ASPEED_SDHCI_SDIO_148:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D (uint32_t)sdhci->=
slots[0].maxcurr;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0 case ASPEED_SDHCI_SDIO_240:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D (uint32_t)sdhci->=
slots[1].capareg;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0 case ASPEED_SDHCI_SDIO_248:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D (uint32_t)sdhci->=
slots[1].maxcurr;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> We could mirror the 16bytes segment for [ SDHC_CAPAB ...=C2=A0 SDHC_MA=
XCURR + 4 ]
>> of each slot under the MMIO region of the Aspeed SD controller at offs=
et:
>> (slot + 1) * 0x10. If that worked, we wouldn't need these redirections=
.
>>
>> I think you need alias regions.
>>
>>> +=C2=A0=C2=A0=C2=A0 default:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (addr < ASPEED_SDHCI_R=
EG_SIZE) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v=
al =3D sdhci->regs[TO_REG(addr)];
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> we could return some errors for not implemented registers.
>> =C2=A0
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return (uint64_t)val;
>>> +}
>>> +
>>> +static void aspeed_sdhci_write(void *opaque, hwaddr addr, uint64_t v=
al,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int size)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 AspeedSDHCIState *sdhci =3D opaque;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 switch (addr) {
>>> +=C2=A0=C2=A0=C2=A0 case ASPEED_SDHCI_SDIO_140:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sdhci->slots[0].capareg =3D=
 (uint64_t)(uint32_t)val;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0 case ASPEED_SDHCI_SDIO_148:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sdhci->slots[0].maxcurr =3D=
 (uint64_t)(uint32_t)val;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0 case ASPEED_SDHCI_SDIO_240:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sdhci->slots[1].capareg =3D=
 (uint64_t)(uint32_t)val;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0 case ASPEED_SDHCI_SDIO_248:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sdhci->slots[1].maxcurr =3D=
 (uint64_t)(uint32_t)val;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> I think these regs are readonly.
>=20
>=20
> Well the actual regs at slot + 0x40/0x48 are indeed, but not the Aspeed=
-specific ones that mirror there. I think the idea is that Aspeed-specifi=
c code can set it's capabilities differently if desired. This may prevent=
 the use of alias regions here.

ah yes. The SD controller regs can be used to HW init the slots.=20

This is unfortunate. So your model is fine. I don't see any other elegant=
=20
ways to do these settings.

=20
>>
>>> +=C2=A0=C2=A0=C2=A0 default:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (addr < ASPEED_SDHCI_R=
EG_SIZE) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
dhci->regs[TO_REG(addr)] =3D (uint32_t)val;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +}
>>> +
>>> +static const MemoryRegionOps aspeed_sdhci_ops =3D {
>>> +=C2=A0=C2=A0=C2=A0 .read =3D aspeed_sdhci_read,
>>> +=C2=A0=C2=A0=C2=A0 .write =3D aspeed_sdhci_write,
>>> +=C2=A0=C2=A0=C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,
>>> +=C2=A0=C2=A0=C2=A0 .valid.min_access_size =3D 4,
>>> +=C2=A0=C2=A0=C2=A0 .valid.max_access_size =3D 4,
>>> +};
>>> +
>>> +static void aspeed_sdhci_set_irq(void *opaque, int n, int level)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 AspeedSDHCIState *sdhci =3D opaque;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (level) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sdhci->regs[TO_REG(ASPEED=
_SDHCI_IRQ_STAT)] |=3D BIT(n);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_irq_raise(sdhci->irq=
);
>>> +=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sdhci->regs[TO_REG(ASPEED=
_SDHCI_IRQ_STAT)] &=3D ~BIT(n);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_irq_lower(sdhci->irq=
);
>>> +=C2=A0=C2=A0=C2=A0 }
>> Doesn't that work the other way around ?
>>
>> The SDHCI objects trigger their IRQ which call the irq_notify() handle=
r
>> in which we need to deduce the slot number to update ASPEED_SDHCI_IRQ_=
STAT
>> and raise/lower the Aspeed SD host IRQ. I think that's how it should w=
ork.
>=20
>=20
> That's exactly what's happening here. Maybe my variable/function naming=
 is confusing?

Sorry. I was looking at the aspeed-4.1 tree which includes your previous =
patch
with the irq_notify() handler and I got confused. This looks good.

>>
>>
>>> +}
>>> +
>>> +static void aspeed_sdhci_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 Error *err =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0 SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>>> +=C2=A0=C2=A0=C2=A0 AspeedSDHCIState *sdhci =3D ASPEED_SDHCI(dev);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* Create input irqs for the slots */
>>> +=C2=A0=C2=A0=C2=A0 qdev_init_gpio_in_named_with_opaque(DEVICE(sbd), =
aspeed_sdhci_set_irq,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sdhci, NULL, ASPEED_SDHCI_NUM_SLOTS);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i=
) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwaddr slot_addr =3D sdhc=
i->ioaddr + (0x100 * (i + 1));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Object *sdhci_slot =3D OB=
JECT(&sdhci->slots[i]);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SysBusDevice *sbd_slot =3D=
 SYS_BUS_DEVICE(&sdhci->slots[i]);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_set_int(s=
dhci_slot, 2, "sd-spec-version", &err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
rror_propagate(errp, err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn;5f
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_set_uint(=
sdhci_slot, ASPEED_SDHCI_CAPABILITIES,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "capareg", &err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
rror_propagate(errp, err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_set_bool(=
sdhci_slot, true, "realized", &err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
rror_propagate(errp, err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysbus_mmio_map(sbd_slot,=
 0, slot_addr);
>> We should do the mapping at the SoC level and I would also put the slo=
ts
>> at the SoC level.
>=20
>=20
> OK. I did that in v1 but Peter made some comments about initializing th=
ings=20
> in the Aspeed SD code so I moved it all down here...

ok. we can keep most of the code here but not the mapping.=20

Would it be possible to add the memory regions of the SDHCIState objects =
as=20
subregions of the AspeedSDHCIState memory region and do the mapping at th=
e=20
SoC level.
=20
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysbus_connect_irq(sbd_sl=
ot, 0, qdev_get_gpio_in(DEVICE(sbd), i));
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 sysbus_init_irq(sbd, &sdhci->irq);
>>> +=C2=A0=C2=A0=C2=A0 memory_region_init_io(&sdhci->iomem, OBJECT(sdhci=
), &aspeed_sdhci_ops,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 sdhci, TYPE_ASPEED_SDHCI, ASPEED_SDHCI_REG_SIZE);
>>> +=C2=A0=C2=A0=C2=A0 sysbus_init_mmio(sbd, &sdhci->iomem);
>>> +=C2=A0=C2=A0=C2=A0 sysbus_mmio_map(sbd, 0, sdhci->ioaddr);
>> Here also.
>>
>>> +}
>>> +
>>> +static void aspeed_sdhci_reset(DeviceState *dev)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 AspeedSDHCIState *sdhci =3D ASPEED_SDHCI(dev);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 memset(sdhci->regs, 0, ASPEED_SDHCI_REG_SIZE);
>>> +=C2=A0=C2=A0=C2=A0 sdhci->regs[TO_REG(ASPEED_SDHCI_INFO)] =3D ASPEED=
_SDHCI_INFO_RESET;
>>> +=C2=A0=C2=A0=C2=A0 sdhci->regs[TO_REG(ASPEED_SDHCI_DEBOUNCE)] =3D AS=
PEED_SDHCI_DEBOUNCE_RESET;
>>> +}
>>> +
>>> +static const VMStateDescription vmstate_aspeed_sdhci =3D {
>>> +=C2=A0=C2=A0=C2=A0 .name =3D TYPE_ASPEED_SDHCI,
>>> +=C2=A0=C2=A0=C2=A0 .version_id =3D 1,
>>> +=C2=A0=C2=A0=C2=A0 .fields =3D (VMStateField[]) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT32_ARRAY(regs=
, AspeedSDHCIState, ASPEED_SDHCI_NUM_REGS),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_END_OF_LIST(),
>>> +=C2=A0=C2=A0=C2=A0 },
>>> +};
>>> +
>>> +static void aspeed_sdhci_class_init(ObjectClass *classp, void *data)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 DeviceClass *dc =3D DEVICE_CLASS(classp);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 dc->realize =3D aspeed_sdhci_realize;
>>> +=C2=A0=C2=A0=C2=A0 dc->reset =3D aspeed_sdhci_reset;
>>> +=C2=A0=C2=A0=C2=A0 dc->vmsd =3D &vmstate_aspeed_sdhci;
>>> +}
>>> +
>>> +static TypeInfo aspeed_sdhci_info =3D {
>>> +=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D TYPE_ASPEED_SDHCI,
>>> +=C2=A0=C2=A0=C2=A0 .parent=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =3D TYPE_SYS_BUS_DEVICE,
>>> +=C2=A0=C2=A0=C2=A0 .instance_size =3D sizeof(AspeedSDHCIState),
>>> +=C2=A0=C2=A0=C2=A0 .class_init=C2=A0=C2=A0=C2=A0 =3D aspeed_sdhci_cl=
ass_init,
>>> +};
>>> +
>>> +static void aspeed_sdhci_register_types(void)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 type_register_static(&aspeed_sdhci_info);
>>> +}
>>> +
>>> +type_init(aspeed_sdhci_register_types)
>>> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.=
h
>>> index 429d7e7..3ddba3a 100644
>>> --- a/include/hw/arm/aspeed_soc.h
>>> +++ b/include/hw/arm/aspeed_soc.h
>>> @@ -29,6 +29,7 @@
>>> =C2=A0 #include "hw/misc/aspeed_pwm.h"
>>> =C2=A0 #include "hw/misc/aspeed_lpc.h"
>>> =C2=A0 #include "hw/misc/aspeed_fsi.h"
>>> +#include "hw/sd/aspeed_sdhci.h"
>>> =C2=A0 =C2=A0 #define ASPEED_SPIS_NUM=C2=A0 2
>>> =C2=A0 #define ASPEED_WDTS_NUM=C2=A0 4
>>> @@ -62,6 +63,7 @@ typedef struct AspeedSoCState {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AspeedPWMState pwm;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AspeedLPCState lpc;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AspeedFsiState fsi[2];
>>> +=C2=A0=C2=A0=C2=A0 AspeedSDHCIState sdhci;
>>> =C2=A0 } AspeedSoCState;
>>> =C2=A0 =C2=A0 #define TYPE_ASPEED_SOC "aspeed-soc"
>>> @@ -107,6 +109,7 @@ enum {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASPEED_ADC,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASPEED_VIDEO,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASPEED_SRAM,
>>> +=C2=A0=C2=A0=C2=A0 ASPEED_SDHCI,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASPEED_GPIO,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASPEED_RTC,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASPEED_TIMER1,
>>> diff --git a/include/hw/sd/aspeed_sdhci.h b/include/hw/sd/aspeed_sdhc=
i.h
>>> new file mode 100644
>>> index 0000000..ac5482f
>>> --- /dev/null
>>> +++ b/include/hw/sd/aspeed_sdhci.h
>>> @@ -0,0 +1,35 @@
>>> +/*
>>> + * Aspeed SD Host Controller
>>> + * Eddie James <eajames@linux.ibm.com>
>>> + *
>>> + * Copyright (C) 2019 IBM Corp
>>> + * SPDX-License-Identifer: GPL-2.0-or-later
>>> + */
>>> +
>>> +#ifndef ASPEED_SDHCI_H
>>> +#define ASPEED_SDHCI_H
>>> +
>>> +#include "hw/sd/sdhci.h"
>>> +
>>> +#define TYPE_ASPEED_SDHCI "aspeed.sdhci"
>>> +#define ASPEED_SDHCI(obj) OBJECT_CHECK(AspeedSDHCIState, (obj), \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 TYPE_ASPEED_SDHCI)
>>> +
>>> +#define ASPEED_SDHCI_CAPABILITIES 0x01E80080
>>> +#define ASPEED_SDHCI_NUM_SLOTS=C2=A0=C2=A0=C2=A0 2
>>> +#define ASPEED_SDHCI_NUM_REGS=C2=A0=C2=A0=C2=A0=C2=A0 (ASPEED_SDHCI_=
REG_SIZE / sizeof(uint32_t))
>>> +#define ASPEED_SDHCI_REG_SIZE=C2=A0=C2=A0=C2=A0=C2=A0 0x100
>>> +
>>> +typedef struct AspeedSDHCIState {
>> AspeedSDHost may be ? It's the SoC SD controller.
>>
>>> +=C2=A0=C2=A0=C2=A0 SysBusDevice parent;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 SDHCIState slots[ASPEED_SDHCI_NUM_SLOTS];
>> I think the SoC should own the SD slots.
>=20
>=20
> Then it would be tricky/impossible to access the slots from the Aspeed =
SD specific functions? For example to connect the irqs and either mirror =
the regs or do some alias mapping.

yes. Forget that suggestion.

So the only thing I would change is how the mapping is done. We should be
able to use  memory_region_add_subregion() I think.

Thanks,

C.

>=20
> Thanks for the quick review!
>=20
> Eddie
>=20
>=20
>>
>>> +
>>> +=C2=A0=C2=A0=C2=A0 hwaddr ioaddr;
>> not needed.
>>
>>> +=C2=A0=C2=A0=C2=A0 MemoryRegion iomem;
>>> +=C2=A0=C2=A0=C2=A0 qemu_irq irq;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 uint32_t regs[ASPEED_SDHCI_NUM_REGS];
>>> +} AspeedSDHCIState;
>>> +
>>> +#endif /* ASPEED_SDHCI_H */
>>>
>> Thanks,
>>
>> C.
>>


