Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9928DC43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 06:55:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B46D2086A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 06:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B46D2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52186 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haagP-0006kA-Kq
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 02:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56509)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1haaf8-0005Wy-9J
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 02:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1haaf6-0007Vr-AC
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 02:53:42 -0400
Received: from 15.mo4.mail-out.ovh.net ([91.121.62.11]:47564)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1haaf6-0007US-0R
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 02:53:40 -0400
Received: from player687.ha.ovh.net (unknown [10.108.57.53])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 54A2A1F6651
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 08:53:37 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id A8F286A5B66A;
 Tue, 11 Jun 2019 06:53:29 +0000 (UTC)
To: Eddie James <eajames@linux.ibm.com>, qemu-arm@nongnu.org
References: <1559599768-9176-1-git-send-email-eajames@linux.ibm.com>
 <8508467b-c7fd-e09b-4323-44631d25ff0e@kaod.org>
 <d1227637-4c40-53de-b106-80725837556b@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7243bdb9-e206-1b17-8064-aae89076e3c0@kaod.org>
Date: Tue, 11 Jun 2019 08:53:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d1227637-4c40-53de-b106-80725837556b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 5760103924650576657
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudehfedgudduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.121.62.11
Subject: Re: [Qemu-devel] [PATCH] hw: misc: Add Aspeed XDMA device
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
Cc: andrew@aj.id.au, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/06/2019 23:42, Eddie James wrote:
>=20
> On 6/6/19 1:16 AM, C=C3=A9dric Le Goater wrote:
>> Hello Eddie,
>>
>> On 04/06/2019 00:09, Eddie James wrote:
>>> The XDMA engine embedded in the Aspeed SOCs performs PCI DMA operatio=
ns
>>> between the SOC (acting as a BMC) and a host processor in a server.
>>>
>>> The XDMA engine exists on the AST2400, AST2500, and AST2600 SOCs, so
>>> enable it for all of those.
>>>
>>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> This looks correct to me. It's sufficient to exercise the BMC driver.
>>
>> However, we will need to rebase on an Aspeed patchset I sent earlier :
>>
>> =C2=A0=C2=A0=C2=A0 http://patchwork.ozlabs.org/cover/1105343/
>>
>> I can do that and include the patch in my tree for the moment.
>=20
>=20
> I built and tested the model on your tree, so let me know if you want m=
e to send that patch instead?

yes. I will take it into my tree and reshuffle the code if needed.

The Aspeed patchset above needs more reviews and it is blocking=20
other changes.

Thanks,

C.=20

=20
>=20
>=20
>>
>>
>> For my understanding, how can we interact with the model and pretend
>> there is a host side ?
>=20
>=20
> I have an application that can test the driver here: https://github.com=
/eddiejames/xdma-test
>=20
> But as you say there is no host side; the operations don't copy any mem=
ory anywhere. Joel suggested adding some way to copy and check some dummy=
 memory contents, but I haven't looked into that yet.
>=20
>=20
> Thanks,
>=20
> Eddie
>=20
>=20
>>
>> Thanks,
>>
>> C.
>>
>>> ---
>>> =C2=A0 hw/arm/aspeed_soc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 14 ++++
>>> =C2=A0 hw/misc/Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 2 +-
>>> =C2=A0 hw/misc/aspeed_xdma.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 156 ++++++++++++++++++++++++++++++++++++++++++
>>> =C2=A0 include/hw/arm/aspeed_soc.h=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
>>> =C2=A0 include/hw/misc/aspeed_xdma.h |=C2=A0 31 +++++++++
>>> =C2=A0 5 files changed, 204 insertions(+), 1 deletion(-)
>>> =C2=A0 create mode 100644 hw/misc/aspeed_xdma.c
>>> =C2=A0 create mode 100644 include/hw/misc/aspeed_xdma.h
>>>
>>> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
>>> index faff42b..b25bb18 100644
>>> --- a/hw/arm/aspeed_soc.c
>>> +++ b/hw/arm/aspeed_soc.c
>>> @@ -31,6 +31,7 @@
>>> =C2=A0 #define ASPEED_SOC_VIC_BASE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x1E6C0000
>>> =C2=A0 #define ASPEED_SOC_SDMC_BASE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x1E6E0000
>>> =C2=A0 #define ASPEED_SOC_SCU_BASE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x1E6E2000
>>> +#define ASPEED_SOC_XDMA_BASE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0x1E6E7000
>>> =C2=A0 #define ASPEED_SOC_SRAM_BASE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x1E720000
>>> =C2=A0 #define ASPEED_SOC_TIMER_BASE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x1E782000
>>> =C2=A0 #define ASPEED_SOC_WDT_BASE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x1E785000
>>> @@ -159,6 +160,9 @@ static void aspeed_soc_init(Object *obj)
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysbus_init_child_obj(obj, "ftg=
mac100", OBJECT(&s->ftgmac100),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sizeof(s->ftgmac100), TYPE_FTGMAC100);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 sysbus_init_child_obj(obj, "xdma", OBJECT(&s->xdm=
a), sizeof(s->xdma),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 TYPE_ASPEED_XDMA);
>>> =C2=A0 }
>>> =C2=A0 =C2=A0 static void aspeed_soc_realize(DeviceState *dev, Error =
**errp)
>>> @@ -298,6 +302,16 @@ static void aspeed_soc_realize(DeviceState *dev,=
 Error **errp)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftg=
mac100), 0, ASPEED_SOC_ETH1_BASE);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(&s->=
ftgmac100), 0,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 qdev_get_gpio_in(DEVICE(&s->vic), 2));
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* XDMA */
>>> +=C2=A0=C2=A0=C2=A0 object_property_set_bool(OBJECT(&s->xdma), true, =
"realized", &err);
>>> +=C2=A0=C2=A0=C2=A0 if (err) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, err=
);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&s->xdma), 0, ASPE=
ED_SOC_XDMA_BASE);
>>> +=C2=A0=C2=A0=C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(&s->xdma), 0,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_get_=
gpio_in(DEVICE(&s->vic), 6));
>>> =C2=A0 }
>>> =C2=A0 =C2=A0 static void aspeed_soc_class_init(ObjectClass *oc, void=
 *data)
>>> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
>>> index 77b9df9..a4483af 100644
>>> --- a/hw/misc/Makefile.objs
>>> +++ b/hw/misc/Makefile.objs
>>> @@ -74,7 +74,7 @@ obj-$(CONFIG_ARMSSE_MHU) +=3D armsse-mhu.o
>>> =C2=A0 =C2=A0 obj-$(CONFIG_PVPANIC) +=3D pvpanic.o
>>> =C2=A0 obj-$(CONFIG_AUX) +=3D auxbus.o
>>> -obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_scu.o aspeed_sdmc.o
>>> +obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_scu.o aspeed_sdmc.o aspeed_xdma=
.o
>>> =C2=A0 obj-$(CONFIG_MSF2) +=3D msf2-sysreg.o
>>> =C2=A0 obj-$(CONFIG_NRF51_SOC) +=3D nrf51_rng.o
>>> =C2=A0 diff --git a/hw/misc/aspeed_xdma.c b/hw/misc/aspeed_xdma.c
>>> new file mode 100644
>>> index 0000000..fe3a32e
>>> --- /dev/null
>>> +++ b/hw/misc/aspeed_xdma.c
>>> @@ -0,0 +1,156 @@
>>> +/*
>>> + * ASPEED XDMA Controller
>>> + * Eddie James <eajames@linux.ibm.com>
>>> + *
>>> + * Copyright (C) 2019 IBM Corp
>>> + * SPDX-License-Identifer: GPL-2.0-or-later
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qemu/log.h"
>>> +#include "qemu/error-report.h"
>>> +#include "hw/misc/aspeed_xdma.h"
>>> +#include "qapi/error.h"
>>> +
>>> +#define XDMA_BMC_CMDQ_ADDR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x10
>>> +#define XDMA_BMC_CMDQ_ENDP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x14
>>> +#define XDMA_BMC_CMDQ_WRP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x18
>>> +#define=C2=A0 XDMA_BMC_CMDQ_W_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0=
003FFFF
>>> +#define XDMA_BMC_CMDQ_RDP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x1C
>>> +#define=C2=A0 XDMA_BMC_CMDQ_RDP_MAGIC=C2=A0=C2=A0 0xEE882266
>>> +#define XDMA_IRQ_ENG_CTRL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x20
>>> +#define=C2=A0 XDMA_IRQ_ENG_CTRL_US_COMP BIT(4)
>>> +#define=C2=A0 XDMA_IRQ_ENG_CTRL_DS_COMP BIT(5)
>>> +#define=C2=A0 XDMA_IRQ_ENG_CTRL_W_MASK=C2=A0 0xBFEFF07F
>>> +#define XDMA_IRQ_ENG_STAT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x24
>>> +#define=C2=A0 XDMA_IRQ_ENG_STAT_US_COMP BIT(4)
>>> +#define=C2=A0 XDMA_IRQ_ENG_STAT_DS_COMP BIT(5)
>>> +#define=C2=A0 XDMA_IRQ_ENG_STAT_RESET=C2=A0=C2=A0 0xF8000000
>>> +
>>> +#define TO_REG(addr) ((addr) / sizeof(uint32_t))
>>> +
>>> +static uint64_t aspeed_xdma_read(void *opaque, hwaddr addr, unsigned=
 int size)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 uint32_t val =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 AspeedXDMAState *xdma =3D opaque;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (addr < ASPEED_XDMA_REG_SIZE) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D xdma->regs[TO_REG=
(addr)];
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return (uint64_t)val;
>>> +}
>>> +
>>> +static void aspeed_xdma_write(void *opaque, hwaddr addr, uint64_t va=
l,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int size)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 unsigned int idx;
>>> +=C2=A0=C2=A0=C2=A0 uint32_t val32 =3D (uint32_t)val;
>>> +=C2=A0=C2=A0=C2=A0 AspeedXDMAState *xdma =3D opaque;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (addr >=3D ASPEED_XDMA_REG_SIZE) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 switch (addr) {
>>> +=C2=A0=C2=A0=C2=A0 case XDMA_BMC_CMDQ_ENDP:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdma->regs[TO_REG(addr)] =
=3D val32 & XDMA_BMC_CMDQ_W_MASK;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0 case XDMA_BMC_CMDQ_WRP:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 idx =3D TO_REG(addr);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdma->regs[idx] =3D val32=
 & XDMA_BMC_CMDQ_W_MASK;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdma->regs[TO_REG(XDMA_BM=
C_CMDQ_RDP)] =3D xdma->regs[idx];
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (xdma->bmc_cmdq_readp_=
set) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=
dma->bmc_cmdq_readp_set =3D 0;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=
dma->regs[TO_REG(XDMA_IRQ_ENG_STAT)] |=3D
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 XDMA_IRQ_ENG_STAT_US_COMP | XDMA_IRQ_ENG_STAT_DS_CO=
MP;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (xdma->regs[TO_REG(XDMA_IRQ_ENG_CTRL)] &
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (XDMA_IRQ_ENG_CTRL_US_COMP | XDMA_IRQ_ENG_CTRL_DS_C=
OMP))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 qemu_irq_raise(xdma->irq);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0 case XDMA_BMC_CMDQ_RDP:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val32 =3D=3D XDMA_BMC=
_CMDQ_RDP_MAGIC) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=
dma->bmc_cmdq_readp_set =3D 1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0 case XDMA_IRQ_ENG_CTRL:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdma->regs[TO_REG(addr)] =
=3D val32 & XDMA_IRQ_ENG_CTRL_W_MASK;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0 case XDMA_IRQ_ENG_STAT:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 idx =3D TO_REG(addr);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val32 & (XDMA_IRQ_ENG=
_STAT_US_COMP | XDMA_IRQ_ENG_STAT_DS_COMP)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x=
dma->regs[TO_REG(addr)] &=3D
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ~(XDMA_IRQ_ENG_STAT_US_COMP | XDMA_IRQ_ENG_STAT_DS_=
COMP);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q=
emu_irq_lower(xdma->irq);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0 default:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdma->regs[TO_REG(addr)] =
=3D val32;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +}
>>> +
>>> +static const MemoryRegionOps aspeed_xdma_ops =3D {
>>> +=C2=A0=C2=A0=C2=A0 .read =3D aspeed_xdma_read,
>>> +=C2=A0=C2=A0=C2=A0 .write =3D aspeed_xdma_write,
>>> +=C2=A0=C2=A0=C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,
>>> +=C2=A0=C2=A0=C2=A0 .valid.min_access_size =3D 4,
>>> +=C2=A0=C2=A0=C2=A0 .valid.max_access_size =3D 4,
>>> +};
>>> +
>>> +static void aspeed_xdma_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>>> +=C2=A0=C2=A0=C2=A0 AspeedXDMAState *xdma =3D ASPEED_XDMA(dev);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 sysbus_init_irq(sbd, &xdma->irq);
>>> +=C2=A0=C2=A0=C2=A0 memory_region_init_io(&xdma->iomem, OBJECT(xdma),=
 &aspeed_xdma_ops, xdma,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 TYPE_ASPEED_XDMA, ASPEED_XDMA_MEM_SIZE);
>>> +=C2=A0=C2=A0=C2=A0 sysbus_init_mmio(sbd, &xdma->iomem);
>>> +}
>>> +
>>> +static void aspeed_xdma_reset(DeviceState *dev)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 AspeedXDMAState *xdma =3D ASPEED_XDMA(dev);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 xdma->bmc_cmdq_readp_set =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 memset(xdma->regs, 0, ASPEED_XDMA_REG_SIZE);
>>> +=C2=A0=C2=A0=C2=A0 xdma->regs[TO_REG(XDMA_IRQ_ENG_STAT)] =3D XDMA_IR=
Q_ENG_STAT_RESET;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 qemu_irq_lower(xdma->irq);
>>> +}
>>> +
>>> +static const VMStateDescription aspeed_xdma_vmstate =3D {
>>> +=C2=A0=C2=A0=C2=A0 .name =3D TYPE_ASPEED_XDMA,
>>> +=C2=A0=C2=A0=C2=A0 .version_id =3D 1,
>>> +=C2=A0=C2=A0=C2=A0 .fields =3D (VMStateField[]) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT32_ARRAY(regs=
, AspeedXDMAState, ASPEED_XDMA_NUM_REGS),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_END_OF_LIST(),
>>> +=C2=A0=C2=A0=C2=A0 },
>>> +};
>>> +
>>> +static void aspeed_xdma_class_init(ObjectClass *classp, void *data)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 DeviceClass *dc =3D DEVICE_CLASS(classp);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 dc->realize =3D aspeed_xdma_realize;
>>> +=C2=A0=C2=A0=C2=A0 dc->reset =3D aspeed_xdma_reset;
>>> +=C2=A0=C2=A0=C2=A0 dc->vmsd =3D &aspeed_xdma_vmstate;
>>> +}
>>> +
>>> +static const TypeInfo aspeed_xdma_info =3D {
>>> +=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D TYPE_ASPEED_XDMA,
>>> +=C2=A0=C2=A0=C2=A0 .parent=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =3D TYPE_SYS_BUS_DEVICE,
>>> +=C2=A0=C2=A0=C2=A0 .instance_size =3D sizeof(AspeedXDMAState),
>>> +=C2=A0=C2=A0=C2=A0 .class_init=C2=A0=C2=A0=C2=A0 =3D aspeed_xdma_cla=
ss_init,
>>> +};
>>> +
>>> +static void aspeed_xdma_register_type(void)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 type_register_static(&aspeed_xdma_info);
>>> +}
>>> +type_init(aspeed_xdma_register_type);
>>> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.=
h
>>> index 836b2ba..0329247 100644
>>> --- a/include/hw/arm/aspeed_soc.h
>>> +++ b/include/hw/arm/aspeed_soc.h
>>> @@ -20,6 +20,7 @@
>>> =C2=A0 #include "hw/ssi/aspeed_smc.h"
>>> =C2=A0 #include "hw/watchdog/wdt_aspeed.h"
>>> =C2=A0 #include "hw/net/ftgmac100.h"
>>> +#include "hw/misc/aspeed_xdma.h"
>>> =C2=A0 =C2=A0 #define ASPEED_SPIS_NUM=C2=A0 2
>>> =C2=A0 #define ASPEED_WDTS_NUM=C2=A0 3
>>> @@ -40,6 +41,7 @@ typedef struct AspeedSoCState {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AspeedSDMCState sdmc;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AspeedWDTState wdt[ASPEED_WDTS_NUM];
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FTGMAC100State ftgmac100;
>>> +=C2=A0=C2=A0=C2=A0 AspeedXDMAState xdma;
>>> =C2=A0 } AspeedSoCState;
>>> =C2=A0 =C2=A0 #define TYPE_ASPEED_SOC "aspeed-soc"
>>> diff --git a/include/hw/misc/aspeed_xdma.h b/include/hw/misc/aspeed_x=
dma.h
>>> new file mode 100644
>>> index 0000000..d19e9a7
>>> --- /dev/null
>>> +++ b/include/hw/misc/aspeed_xdma.h
>>> @@ -0,0 +1,31 @@
>>> +/*
>>> + * ASPEED XDMA Controller
>>> + * Eddie James <eajames@linux.ibm.com>
>>> + *
>>> + * Copyright (C) 2019 IBM Corp.
>>> + * SPDX-License-Identifer: GPL-2.0-or-later
>>> + */
>>> +
>>> +#ifndef ASPEED_XDMA_H
>>> +#define ASPEED_XDMA_H
>>> +
>>> +#include "hw/sysbus.h"
>>> +
>>> +#define TYPE_ASPEED_XDMA "aspeed.xdma"
>>> +#define ASPEED_XDMA(obj) OBJECT_CHECK(AspeedXDMAState, (obj), TYPE_A=
SPEED_XDMA)
>>> +
>>> +#define ASPEED_XDMA_MEM_SIZE 0x1000
>>> +#define ASPEED_XDMA_NUM_REGS (ASPEED_XDMA_REG_SIZE / sizeof(uint32_t=
))
>>> +#define ASPEED_XDMA_REG_SIZE 0x7C
>>> +
>>> +typedef struct AspeedXDMAState {
>>> +=C2=A0=C2=A0=C2=A0 SysBusDevice parent;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 MemoryRegion iomem;
>>> +=C2=A0=C2=A0=C2=A0 qemu_irq irq;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 char bmc_cmdq_readp_set;
>>> +=C2=A0=C2=A0=C2=A0 uint32_t regs[ASPEED_XDMA_NUM_REGS];
>>> +} AspeedXDMAState;
>>> +
>>> +#endif /* ASPEED_XDMA_H */
>>>
>=20


