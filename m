Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB814C4321A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 18:05:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7445B20859
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 18:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7445B20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48768 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haOfS-00044p-Pk
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 14:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34198)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eajames@linux.vnet.ibm.com>) id 1haObe-0002BB-Ci
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 14:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eajames@linux.vnet.ibm.com>) id 1haObb-0007Bw-Fw
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 14:01:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45224)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eajames@linux.vnet.ibm.com>)
 id 1haObb-0006vp-3c
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 14:01:15 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5AHvO43018167
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 14:00:56 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2t1rynrsn1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 14:00:56 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <eajames@linux.vnet.ibm.com>;
 Mon, 10 Jun 2019 19:00:55 +0100
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
 by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 10 Jun 2019 19:00:53 +0100
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5AI0qr421037482
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Jun 2019 18:00:52 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 855266E05B;
 Mon, 10 Jun 2019 18:00:52 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0AAE56E056;
 Mon, 10 Jun 2019 18:00:51 +0000 (GMT)
Received: from [9.41.179.222] (unknown [9.41.179.222])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 10 Jun 2019 18:00:51 +0000 (GMT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Eddie James <eajames@linux.ibm.com>, qemu-arm@nongnu.org
References: <1559599768-9176-1-git-send-email-eajames@linux.ibm.com>
 <29f493c1-ac0c-684f-a33e-8226be8db48b@redhat.com>
From: Eddie James <eajames@linux.vnet.ibm.com>
Date: Mon, 10 Jun 2019 13:00:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <29f493c1-ac0c-684f-a33e-8226be8db48b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19061018-0012-0000-0000-00001742B535
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011243; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01216054; UDB=6.00639360; IPR=6.00997154; 
 MB=3.00027254; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-10 18:00:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061018-0013-0000-0000-000057A3E9EB
Message-Id: <e2ff35ed-8fb2-983c-1793-3a901ae2c6ec@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-10_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906100122
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x5AHvO43018167
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
X-Mailman-Approved-At: Mon, 10 Jun 2019 14:03:02 -0400
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
Cc: andrew@aj.id.au, peter.maydell@linaro.org, joel@jms.id.au,
 qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 6/6/19 6:34 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Eddie,
>
> On 6/4/19 12:09 AM, Eddie James wrote:
>> The XDMA engine embedded in the Aspeed SOCs performs PCI DMA operation=
s
>> between the SOC (acting as a BMC) and a host processor in a server.
> If I got your model correctly, it does no DMA operation but simply
> answer correctly to the BMC, and set 'operation done' IRQ with no delay.
> So this is a dummy device. Then it would be more useful having ignored
> DMA ops traced with trace-events.


Thats correct. Good idea, I will add some tracing.


>
>> The XDMA engine exists on the AST2400, AST2500, and AST2600 SOCs, so
>> enable it for all of those.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
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
> The two previous lines are odd. Are they inverted?


No, this should be correct. Since the command completes instantly, the=20
engine "read pointer" is updated to the new "write pointer," with the=20
expected result that no more commands need to be completed, since write=20
=3D=3D read.


>
> I guess I'd trace here:
>
>             trace_aspeed_xdma_...(val, ...);
>
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
> Trace here too.
>
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
>                            ^ idx


Thanks, will update.


>
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
> Maybe you can keep ASPEED_XDMA_MEM_SIZE private in the source file.


Sure.


>
>> +#define ASPEED_XDMA_NUM_REGS (ASPEED_XDMA_REG_SIZE / sizeof(uint32_t)=
)
>> +#define ASPEED_XDMA_REG_SIZE 0x7C
> 0x80?


Well 0x78 is the offset of the last register, so 0x7c would be the total=20
register space. Of course the engine actually owns 4K bytes of register=20
space but there's no reason to store all that.


>
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
> Few questions, but otherwise LGTM.
>
> Regards,
>
> Phil.
>


