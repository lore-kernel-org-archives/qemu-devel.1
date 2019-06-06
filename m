Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA0CC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 21:43:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AFEB20673
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 21:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AFEB20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44216 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ0At-0006W7-Io
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 17:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55348)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eajames@linux.ibm.com>) id 1hZ09k-0005nT-0N
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eajames@linux.ibm.com>) id 1hZ09h-0005mq-PD
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:42:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42378
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eajames@linux.ibm.com>)
 id 1hZ09h-0005N0-Jk
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:42:41 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x56LgKek098540
 for <qemu-devel@nongnu.org>; Thu, 6 Jun 2019 17:42:33 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2sy9y2am3p-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 17:42:33 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <eajames@linux.ibm.com>;
 Thu, 6 Jun 2019 22:42:33 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 6 Jun 2019 22:42:30 +0100
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x56LgTZR27132168
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Jun 2019 21:42:29 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E4BF4124055;
 Thu,  6 Jun 2019 21:42:28 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74332124053;
 Thu,  6 Jun 2019 21:42:28 +0000 (GMT)
Received: from [9.85.223.174] (unknown [9.85.223.174])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu,  6 Jun 2019 21:42:28 +0000 (GMT)
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
References: <1559599768-9176-1-git-send-email-eajames@linux.ibm.com>
 <8508467b-c7fd-e09b-4323-44631d25ff0e@kaod.org>
From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 6 Jun 2019 16:42:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8508467b-c7fd-e09b-4323-44631d25ff0e@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19060621-0052-0000-0000-000003CC69F3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011225; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01214231; UDB=6.00638253; IPR=6.00995311; 
 MB=3.00027212; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-06 21:42:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060621-0053-0000-0000-000061369576
Message-Id: <d1227637-4c40-53de-b106-80725837556b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-06_14:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906060146
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id x56LgKek098540
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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


On 6/6/19 1:16 AM, C=C3=A9dric Le Goater wrote:
> Hello Eddie,
>
> On 04/06/2019 00:09, Eddie James wrote:
>> The XDMA engine embedded in the Aspeed SOCs performs PCI DMA operation=
s
>> between the SOC (acting as a BMC) and a host processor in a server.
>>
>> The XDMA engine exists on the AST2400, AST2500, and AST2600 SOCs, so
>> enable it for all of those.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> This looks correct to me. It's sufficient to exercise the BMC driver.
>
> However, we will need to rebase on an Aspeed patchset I sent earlier :
>
>     http://patchwork.ozlabs.org/cover/1105343/
>
> I can do that and include the patch in my tree for the moment.


I built and tested the model on your tree, so let me know if you want me=20
to send that patch instead?


>
>
> For my understanding, how can we interact with the model and pretend
> there is a host side ?


I have an application that can test the driver here:=20
https://github.com/eddiejames/xdma-test

But as you say there is no host side; the operations don't copy any=20
memory anywhere. Joel suggested adding some way to copy and check some=20
dummy memory contents, but I haven't looked into that yet.


Thanks,

Eddie


>
> Thanks,
>
> C.
>
>> ---
>>   hw/arm/aspeed_soc.c           |  14 ++++
>>   hw/misc/Makefile.objs         |   2 +-
>>   hw/misc/aspeed_xdma.c         | 156 ++++++++++++++++++++++++++++++++=
++++++++++
>>   include/hw/arm/aspeed_soc.h   |   2 +
>>   include/hw/misc/aspeed_xdma.h |  31 +++++++++
>>   5 files changed, 204 insertions(+), 1 deletion(-)
>>   create mode 100644 hw/misc/aspeed_xdma.c
>>   create mode 100644 include/hw/misc/aspeed_xdma.h
>>
>> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
>> index faff42b..b25bb18 100644
>> --- a/hw/arm/aspeed_soc.c
>> +++ b/hw/arm/aspeed_soc.c
>> @@ -31,6 +31,7 @@
>>   #define ASPEED_SOC_VIC_BASE         0x1E6C0000
>>   #define ASPEED_SOC_SDMC_BASE        0x1E6E0000
>>   #define ASPEED_SOC_SCU_BASE         0x1E6E2000
>> +#define ASPEED_SOC_XDMA_BASE        0x1E6E7000
>>   #define ASPEED_SOC_SRAM_BASE        0x1E720000
>>   #define ASPEED_SOC_TIMER_BASE       0x1E782000
>>   #define ASPEED_SOC_WDT_BASE         0x1E785000
>> @@ -159,6 +160,9 @@ static void aspeed_soc_init(Object *obj)
>>  =20
>>       sysbus_init_child_obj(obj, "ftgmac100", OBJECT(&s->ftgmac100),
>>                             sizeof(s->ftgmac100), TYPE_FTGMAC100);
>> +
>> +    sysbus_init_child_obj(obj, "xdma", OBJECT(&s->xdma), sizeof(s->xd=
ma),
>> +                          TYPE_ASPEED_XDMA);
>>   }
>>  =20
>>   static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>> @@ -298,6 +302,16 @@ static void aspeed_soc_realize(DeviceState *dev, =
Error **errp)
>>       sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100), 0, ASPEED_SOC_ETH=
1_BASE);
>>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100), 0,
>>                          qdev_get_gpio_in(DEVICE(&s->vic), 2));
>> +
>> +    /* XDMA */
>> +    object_property_set_bool(OBJECT(&s->xdma), true, "realized", &err=
);
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
>> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->xdma), 0, ASPEED_SOC_XDMA_BASE=
);
>> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->xdma), 0,
>> +                       qdev_get_gpio_in(DEVICE(&s->vic), 6));
>>   }
>>  =20
>>   static void aspeed_soc_class_init(ObjectClass *oc, void *data)
>> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
>> index 77b9df9..a4483af 100644
>> --- a/hw/misc/Makefile.objs
>> +++ b/hw/misc/Makefile.objs
>> @@ -74,7 +74,7 @@ obj-$(CONFIG_ARMSSE_MHU) +=3D armsse-mhu.o
>>  =20
>>   obj-$(CONFIG_PVPANIC) +=3D pvpanic.o
>>   obj-$(CONFIG_AUX) +=3D auxbus.o
>> -obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_scu.o aspeed_sdmc.o
>> +obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_scu.o aspeed_sdmc.o aspeed_xdma.=
o
>>   obj-$(CONFIG_MSF2) +=3D msf2-sysreg.o
>>   obj-$(CONFIG_NRF51_SOC) +=3D nrf51_rng.o
>>  =20
>> diff --git a/hw/misc/aspeed_xdma.c b/hw/misc/aspeed_xdma.c
>> new file mode 100644
>> index 0000000..fe3a32e
>> --- /dev/null
>> +++ b/hw/misc/aspeed_xdma.c
>> @@ -0,0 +1,156 @@
>> +/*
>> + * ASPEED XDMA Controller
>> + * Eddie James <eajames@linux.ibm.com>
>> + *
>> + * Copyright (C) 2019 IBM Corp
>> + * SPDX-License-Identifer: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/log.h"
>> +#include "qemu/error-report.h"
>> +#include "hw/misc/aspeed_xdma.h"
>> +#include "qapi/error.h"
>> +
>> +#define XDMA_BMC_CMDQ_ADDR         0x10
>> +#define XDMA_BMC_CMDQ_ENDP         0x14
>> +#define XDMA_BMC_CMDQ_WRP          0x18
>> +#define  XDMA_BMC_CMDQ_W_MASK      0x0003FFFF
>> +#define XDMA_BMC_CMDQ_RDP          0x1C
>> +#define  XDMA_BMC_CMDQ_RDP_MAGIC   0xEE882266
>> +#define XDMA_IRQ_ENG_CTRL          0x20
>> +#define  XDMA_IRQ_ENG_CTRL_US_COMP BIT(4)
>> +#define  XDMA_IRQ_ENG_CTRL_DS_COMP BIT(5)
>> +#define  XDMA_IRQ_ENG_CTRL_W_MASK  0xBFEFF07F
>> +#define XDMA_IRQ_ENG_STAT          0x24
>> +#define  XDMA_IRQ_ENG_STAT_US_COMP BIT(4)
>> +#define  XDMA_IRQ_ENG_STAT_DS_COMP BIT(5)
>> +#define  XDMA_IRQ_ENG_STAT_RESET   0xF8000000
>> +
>> +#define TO_REG(addr) ((addr) / sizeof(uint32_t))
>> +
>> +static uint64_t aspeed_xdma_read(void *opaque, hwaddr addr, unsigned =
int size)
>> +{
>> +    uint32_t val =3D 0;
>> +    AspeedXDMAState *xdma =3D opaque;
>> +
>> +    if (addr < ASPEED_XDMA_REG_SIZE) {
>> +        val =3D xdma->regs[TO_REG(addr)];
>> +    }
>> +
>> +    return (uint64_t)val;
>> +}
>> +
>> +static void aspeed_xdma_write(void *opaque, hwaddr addr, uint64_t val=
,
>> +                              unsigned int size)
>> +{
>> +    unsigned int idx;
>> +    uint32_t val32 =3D (uint32_t)val;
>> +    AspeedXDMAState *xdma =3D opaque;
>> +
>> +    if (addr >=3D ASPEED_XDMA_REG_SIZE) {
>> +        return;
>> +    }
>> +
>> +    switch (addr) {
>> +    case XDMA_BMC_CMDQ_ENDP:
>> +        xdma->regs[TO_REG(addr)] =3D val32 & XDMA_BMC_CMDQ_W_MASK;
>> +        break;
>> +    case XDMA_BMC_CMDQ_WRP:
>> +        idx =3D TO_REG(addr);
>> +        xdma->regs[idx] =3D val32 & XDMA_BMC_CMDQ_W_MASK;
>> +        xdma->regs[TO_REG(XDMA_BMC_CMDQ_RDP)] =3D xdma->regs[idx];
>> +
>> +        if (xdma->bmc_cmdq_readp_set) {
>> +            xdma->bmc_cmdq_readp_set =3D 0;
>> +        } else {
>> +            xdma->regs[TO_REG(XDMA_IRQ_ENG_STAT)] |=3D
>> +                XDMA_IRQ_ENG_STAT_US_COMP | XDMA_IRQ_ENG_STAT_DS_COMP=
;
>> +
>> +            if (xdma->regs[TO_REG(XDMA_IRQ_ENG_CTRL)] &
>> +                (XDMA_IRQ_ENG_CTRL_US_COMP | XDMA_IRQ_ENG_CTRL_DS_COM=
P))
>> +                qemu_irq_raise(xdma->irq);
>> +        }
>> +        break;
>> +    case XDMA_BMC_CMDQ_RDP:
>> +        if (val32 =3D=3D XDMA_BMC_CMDQ_RDP_MAGIC) {
>> +            xdma->bmc_cmdq_readp_set =3D 1;
>> +        }
>> +        break;
>> +    case XDMA_IRQ_ENG_CTRL:
>> +        xdma->regs[TO_REG(addr)] =3D val32 & XDMA_IRQ_ENG_CTRL_W_MASK=
;
>> +        break;
>> +    case XDMA_IRQ_ENG_STAT:
>> +        idx =3D TO_REG(addr);
>> +        if (val32 & (XDMA_IRQ_ENG_STAT_US_COMP | XDMA_IRQ_ENG_STAT_DS=
_COMP)) {
>> +            xdma->regs[TO_REG(addr)] &=3D
>> +                ~(XDMA_IRQ_ENG_STAT_US_COMP | XDMA_IRQ_ENG_STAT_DS_CO=
MP);
>> +            qemu_irq_lower(xdma->irq);
>> +        }
>> +        break;
>> +    default:
>> +        xdma->regs[TO_REG(addr)] =3D val32;
>> +        break;
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps aspeed_xdma_ops =3D {
>> +    .read =3D aspeed_xdma_read,
>> +    .write =3D aspeed_xdma_write,
>> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
>> +    .valid.min_access_size =3D 4,
>> +    .valid.max_access_size =3D 4,
>> +};
>> +
>> +static void aspeed_xdma_realize(DeviceState *dev, Error **errp)
>> +{
>> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>> +    AspeedXDMAState *xdma =3D ASPEED_XDMA(dev);
>> +
>> +    sysbus_init_irq(sbd, &xdma->irq);
>> +    memory_region_init_io(&xdma->iomem, OBJECT(xdma), &aspeed_xdma_op=
s, xdma,
>> +                          TYPE_ASPEED_XDMA, ASPEED_XDMA_MEM_SIZE);
>> +    sysbus_init_mmio(sbd, &xdma->iomem);
>> +}
>> +
>> +static void aspeed_xdma_reset(DeviceState *dev)
>> +{
>> +    AspeedXDMAState *xdma =3D ASPEED_XDMA(dev);
>> +
>> +    xdma->bmc_cmdq_readp_set =3D 0;
>> +    memset(xdma->regs, 0, ASPEED_XDMA_REG_SIZE);
>> +    xdma->regs[TO_REG(XDMA_IRQ_ENG_STAT)] =3D XDMA_IRQ_ENG_STAT_RESET=
;
>> +
>> +    qemu_irq_lower(xdma->irq);
>> +}
>> +
>> +static const VMStateDescription aspeed_xdma_vmstate =3D {
>> +    .name =3D TYPE_ASPEED_XDMA,
>> +    .version_id =3D 1,
>> +    .fields =3D (VMStateField[]) {
>> +        VMSTATE_UINT32_ARRAY(regs, AspeedXDMAState, ASPEED_XDMA_NUM_R=
EGS),
>> +        VMSTATE_END_OF_LIST(),
>> +    },
>> +};
>> +
>> +static void aspeed_xdma_class_init(ObjectClass *classp, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(classp);
>> +
>> +    dc->realize =3D aspeed_xdma_realize;
>> +    dc->reset =3D aspeed_xdma_reset;
>> +    dc->vmsd =3D &aspeed_xdma_vmstate;
>> +}
>> +
>> +static const TypeInfo aspeed_xdma_info =3D {
>> +    .name          =3D TYPE_ASPEED_XDMA,
>> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
>> +    .instance_size =3D sizeof(AspeedXDMAState),
>> +    .class_init    =3D aspeed_xdma_class_init,
>> +};
>> +
>> +static void aspeed_xdma_register_type(void)
>> +{
>> +    type_register_static(&aspeed_xdma_info);
>> +}
>> +type_init(aspeed_xdma_register_type);
>> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
>> index 836b2ba..0329247 100644
>> --- a/include/hw/arm/aspeed_soc.h
>> +++ b/include/hw/arm/aspeed_soc.h
>> @@ -20,6 +20,7 @@
>>   #include "hw/ssi/aspeed_smc.h"
>>   #include "hw/watchdog/wdt_aspeed.h"
>>   #include "hw/net/ftgmac100.h"
>> +#include "hw/misc/aspeed_xdma.h"
>>  =20
>>   #define ASPEED_SPIS_NUM  2
>>   #define ASPEED_WDTS_NUM  3
>> @@ -40,6 +41,7 @@ typedef struct AspeedSoCState {
>>       AspeedSDMCState sdmc;
>>       AspeedWDTState wdt[ASPEED_WDTS_NUM];
>>       FTGMAC100State ftgmac100;
>> +    AspeedXDMAState xdma;
>>   } AspeedSoCState;
>>  =20
>>   #define TYPE_ASPEED_SOC "aspeed-soc"
>> diff --git a/include/hw/misc/aspeed_xdma.h b/include/hw/misc/aspeed_xd=
ma.h
>> new file mode 100644
>> index 0000000..d19e9a7
>> --- /dev/null
>> +++ b/include/hw/misc/aspeed_xdma.h
>> @@ -0,0 +1,31 @@
>> +/*
>> + * ASPEED XDMA Controller
>> + * Eddie James <eajames@linux.ibm.com>
>> + *
>> + * Copyright (C) 2019 IBM Corp.
>> + * SPDX-License-Identifer: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef ASPEED_XDMA_H
>> +#define ASPEED_XDMA_H
>> +
>> +#include "hw/sysbus.h"
>> +
>> +#define TYPE_ASPEED_XDMA "aspeed.xdma"
>> +#define ASPEED_XDMA(obj) OBJECT_CHECK(AspeedXDMAState, (obj), TYPE_AS=
PEED_XDMA)
>> +
>> +#define ASPEED_XDMA_MEM_SIZE 0x1000
>> +#define ASPEED_XDMA_NUM_REGS (ASPEED_XDMA_REG_SIZE / sizeof(uint32_t)=
)
>> +#define ASPEED_XDMA_REG_SIZE 0x7C
>> +
>> +typedef struct AspeedXDMAState {
>> +    SysBusDevice parent;
>> +
>> +    MemoryRegion iomem;
>> +    qemu_irq irq;
>> +
>> +    char bmc_cmdq_readp_set;
>> +    uint32_t regs[ASPEED_XDMA_NUM_REGS];
>> +} AspeedXDMAState;
>> +
>> +#endif /* ASPEED_XDMA_H */
>>


