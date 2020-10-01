Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8810C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F2952145D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2952145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0Hd-0005Di-6A
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kO08o-0001uT-CG; Thu, 01 Oct 2020 11:05:06 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:47295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kO08j-0005gL-SG; Thu, 01 Oct 2020 11:05:06 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.173])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id BF358610973B;
 Thu,  1 Oct 2020 17:04:53 +0200 (CEST)
Received: from kaod.org (37.59.142.100) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 1 Oct 2020
 17:04:51 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R0038e91f9cb-03b4-43f1-b65c-3e95b59edab8,
 2FD1C644E9D11323632A639817FC6AC7C89AF497) smtp.auth=clg@kaod.org
Subject: Re: [PATCH 1/2] hw/misc: add an EMC141{3,4} device model
To: John Wang <wangzhiqiang.bj@bytedance.com>, <yulei.sh@bytedance.com>,
 <xuxiaohan@bytedance.com>, <joel@jms.id.au>
References: <20200929055309.509-1-wangzhiqiang.bj@bytedance.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <48d16207-7ffe-97cb-c248-dc1d3515de77@kaod.org>
Date: Thu, 1 Oct 2020 17:04:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200929055309.509-1-wangzhiqiang.bj@bytedance.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG3EX1.mxp5.local (172.16.2.21) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 07ca5c2f-2a33-4a6d-9f02-67df405720e2
X-Ovh-Tracer-Id: 17299452068724312937
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrfeeggdekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgihesthejredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeduheeifffftdffgeegvdevueeliefglefgveekveeivdejvdehffegvddugeegleenucffohhmrghinheprghllhgurghtrghshhgvvghtrdgtohhmpdhgnhhurdhorhhgnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopeifrghnghiihhhiqhhirghnghdrsghjsegshihtvggurghntggvrdgtohhm
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 11:04:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.26,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On 9/29/20 7:53 AM, John Wang wrote:
> Largely inspired by the TMP423 temperature sensor, here is a model for

It's a TMP421 temperature sensor

> the EMC1413 temperature sensors.
> 
> Specs can be found here :
>   https://pdf1.alldatasheet.com/datasheet-pdf/view/533713/SMSC/EMC1413.html


Have you tested it under a current Linux kernel ? 

> Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>
> ---
>  hw/arm/Kconfig      |   1 +
>  hw/misc/Kconfig     |   4 +
>  hw/misc/emc1413.c   | 309 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/misc/meson.build |   1 +
>  4 files changed, 315 insertions(+)
>  create mode 100644 hw/misc/emc1413.c
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index f303c6bead..8801ada145 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -402,6 +402,7 @@ config ASPEED_SOC
>      select SSI_M25P80
>      select TMP105
>      select TMP421
> +    select EMC1413
>      select UNIMP
>  
>  config MPS2
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 3185456110..91badf2d4d 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -13,6 +13,10 @@ config TMP421
>      bool
>      depends on I2C
>  
> +config EMC1413
> +    bool
> +    depends on I2C
> +
>  config ISA_DEBUG
>      bool
>      depends on ISA_BUS
> diff --git a/hw/misc/emc1413.c b/hw/misc/emc1413.c
> new file mode 100644
> index 0000000000..2430c3f074
> --- /dev/null
> +++ b/hw/misc/emc1413.c
> @@ -0,0 +1,309 @@
> +/*
> + * SMSC EMC1413 temperature sensor.
> + *
> + * Copyright (c) 2020 Bytedance Corporation
> + * Written by John Wang <wangzhiqiang.bj@bytedance.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 or
> + * (at your option) version 3 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/i2c/i2c.h"
> +#include "migration/vmstate.h"
> +#include "qapi/error.h"
> +#include "qapi/visitor.h"
> +#include "qemu/module.h"
> +#include "qom/object.h"
> +
> +#define DEVICE_ID_REG                    0xfd
> +#define MANUFACTURER_ID_REG              0xfe
> +#define REVISION_REG                     0xff
> +#define EMC1413_DEVICE_ID                0x21
> +#define EMC1414_DEVICE_ID                0x25
> +
> +typedef struct DeviceInfo {
> +    uint8_t model;
> +    const char *name;
> +} DeviceInfo;
> +
> +static const DeviceInfo devices[] = {
> +    { EMC1413_DEVICE_ID, "emc1413" },
> +    { EMC1414_DEVICE_ID, "emc1414" },
> +};
>

DeviceInfo is a bit redundant with EMC1413Class. We could define all
the attributes under the class.

> +struct EMC1413State {
> +    I2CSlave i2c;
> +    uint8_t temperature[4];
> +    uint8_t min[4];
> +    uint8_t max[4];
> +    uint8_t len;
> +    uint8_t data;
> +    uint8_t pointer;
> +
> +};
> +
> +struct EMC1413Class {
> +    I2CSlaveClass parent_class;
> +    DeviceInfo *dev;
> +};
> +
> +#define TYPE_EMC1413 "emc1413-generic"
> +OBJECT_DECLARE_TYPE(EMC1413State, EMC1413Class, EMC1413)
> +
> +
> +/* the EMC1413 registers */
> +#define EMC1413_TEMP_HIGH0               0x00
> +#define EMC1413_TEMP_HIGH1               0x01
> +#define EMC1413_TEMP_HIGH2               0x23
> +#define EMC1413_TEMP_HIGH3               0x2a
> +#define EMC1413_TEMP_MAX_HIGH0           0x05
> +#define EMC1413_TEMP_MIN_HIGH0           0x06
> +#define EMC1413_TEMP_MAX_HIGH1           0x07
> +#define EMC1413_TEMP_MIN_HIGH1           0x08
> +#define EMC1413_TEMP_MAX_HIGH2           0x15
> +#define EMC1413_TEMP_MIN_HIGH2           0x16
> +#define EMC1413_TEMP_MAX_HIGH3           0x2c
> +#define EMC1413_TEMP_MIN_HIGH3           0x2d

There are much more and it might not be necessary to model
them all. Do we care about the status or config reg ? 

> +static void emc1413_get_temperature(Object *obj, Visitor *v, const char *name,
> +                                   void *opaque, Error **errp)
> +{
> +    EMC1413State *s = EMC1413(obj);
> +    int64_t value;
> +    int tempid;
> +
> +    if (sscanf(name, "temperature%d", &tempid) != 1) {
> +        error_setg(errp, "error reading %s: %s", name, g_strerror(errno));
> +        return;
> +    }
> +
> +    if (tempid >= 4 || tempid < 0) {
> +        error_setg(errp, "error reading %s", name);
> +        return;
> +    }
> +
> +    value = s->temperature[tempid] * 1000;
> +
> +    visit_type_int(v, name, &value, errp);
> +}
> +
> +static void emc1413_set_temperature(Object *obj, Visitor *v, const char *name,
> +                                   void *opaque, Error **errp)
> +{
> +    EMC1413State *s = EMC1413(obj);
> +    int64_t temp;
> +    int tempid;
> +
> +    if (!visit_type_int(v, name, &temp, errp)) {
> +        return;
> +    }
> +
> +    if (sscanf(name, "temperature%d", &tempid) != 1) {
> +        error_setg(errp, "error reading %s: %s", name, g_strerror(errno));
> +        return;
> +    }
> +
> +    if (tempid >= 4 || tempid < 0) {
> +        error_setg(errp, "error reading %s", name);
> +        return;
> +    }
> +
> +    s->temperature[tempid] = temp / 1000;
> +}
> +
> +struct emc1413_reg {
> +    uint8_t addr;
> +    uint8_t *data;
> +};
> +
> +static void emc1413_read(EMC1413State *s)
> +{
> +    EMC1413Class *sc = EMC1413_GET_CLASS(s);
> +    uint8_t smsc_manufacturer_id = 0x5d;
> +    uint8_t revision = 0x04;
> +    struct emc1413_reg emc1413_regs[] = {
> +        {DEVICE_ID_REG, &sc->dev->model},
> +        {MANUFACTURER_ID_REG, &smsc_manufacturer_id},
> +        {REVISION_REG, &revision},

These attributes belong to the DeviceInfo structure or EMC1413Class if you 
decide to remove DeviceInfo.

> +        {EMC1413_TEMP_HIGH0, &s->temperature[0]},
> +        {EMC1413_TEMP_HIGH1, &s->temperature[1]},
> +        {EMC1413_TEMP_HIGH2, &s->temperature[2]},
> +        {EMC1413_TEMP_HIGH3, &s->temperature[3]},
> +        {EMC1413_TEMP_MAX_HIGH0, &s->max[0]},
> +        {EMC1413_TEMP_MAX_HIGH1, &s->max[1]},
> +        {EMC1413_TEMP_MAX_HIGH2, &s->max[2]},
> +        {EMC1413_TEMP_MAX_HIGH3, &s->max[3]},
> +        {EMC1413_TEMP_MIN_HIGH0, &s->min[0]},
> +        {EMC1413_TEMP_MIN_HIGH1, &s->min[1]},
> +        {EMC1413_TEMP_MIN_HIGH2, &s->min[2]},
> +        {EMC1413_TEMP_MIN_HIGH3, &s->min[3]},
> +    };
> +    size_t i;
> +    for (i = 0; i < ARRAY_SIZE(emc1413_regs); i++) {
> +        if (emc1413_regs[i].addr == s->pointer) {
> +            s->data = *(emc1413_regs[i].data);
> +            return;
> +        }
> +    }
> +}
> +
> +static void emc1413_write(EMC1413State *s)
> +{
> +    struct emc1413_reg emc1413_regs[] = {
> +        {EMC1413_TEMP_MAX_HIGH0, &s->max[0]},
> +        {EMC1413_TEMP_MAX_HIGH1, &s->max[1]},
> +        {EMC1413_TEMP_MAX_HIGH2, &s->max[2]},
> +        {EMC1413_TEMP_MAX_HIGH3, &s->max[3]},
> +        {EMC1413_TEMP_MIN_HIGH0, &s->min[0]},
> +        {EMC1413_TEMP_MIN_HIGH1, &s->min[1]},
> +        {EMC1413_TEMP_MIN_HIGH2, &s->min[2]},
> +        {EMC1413_TEMP_MIN_HIGH3, &s->min[3]},
> +    };
> +    size_t i;
> +    for (i = 0; i < ARRAY_SIZE(emc1413_regs); i++) {
> +        if (emc1413_regs[i].addr == s->pointer) {
> +            *(emc1413_regs[i].data) = s->data;
> +            return;
> +        }
> +    }
> +}
> +
> +static uint8_t emc1413_rx(I2CSlave *i2c)
> +{
> +    EMC1413State *s = EMC1413(i2c);
> +
> +    if (s->len == 0) {
> +        s->len++;
> +        return s->data;
> +    } else {
> +        return 0xff;
> +    }
> +}
> +
> +static int emc1413_tx(I2CSlave *i2c, uint8_t data)
> +{
> +    EMC1413State *s = EMC1413(i2c);
> +
> +    if (s->len == 0) {
> +        /* first byte is the reg pointer */
> +        s->pointer = data;
> +        s->len++;
> +    } else if (s->len == 1) {
> +        s->data = data;
> +        emc1413_write(s);
> +    }
> +
> +    return 0;
> +}
> +
> +static int emc1413_event(I2CSlave *i2c, enum i2c_event event)
> +{
> +    EMC1413State *s = EMC1413(i2c);
> +
> +    if (event == I2C_START_RECV) {
> +        emc1413_read(s);
> +    }
> +
> +    s->len = 0;
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_emc1413 = {
> +    .name = "EMC1413",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT8(len, EMC1413State),
> +        VMSTATE_UINT8(data, EMC1413State),
> +        VMSTATE_UINT8(pointer, EMC1413State),
> +        VMSTATE_UINT8_ARRAY(temperature, EMC1413State, 4),
> +        VMSTATE_I2C_SLAVE(i2c, EMC1413State),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void emc1413_reset(I2CSlave *i2c)
> +{
> +    EMC1413State *s = EMC1413(i2c);
> +
> +    memset(s->temperature, 0, sizeof(s->temperature));
> +    memset(s->min, 0, sizeof(s->min));
> +    memset(s->max, 0x55, sizeof(s->max));
> +    s->pointer = 0;
> +    s->len = 0;
> +}
> +
> +static void emc1413_realize(DeviceState *dev, Error **errp)
> +{
> +    EMC1413State *s = EMC1413(dev);
> +
> +    emc1413_reset(&s->i2c);
> +}
> +
> +static void emc1413_initfn(Object *obj)
> +{
> +    object_property_add(obj, "temperature0", "int",
> +                        emc1413_get_temperature,
> +                        emc1413_set_temperature, NULL, NULL);
> +    object_property_add(obj, "temperature1", "int",
> +                        emc1413_get_temperature,
> +                        emc1413_set_temperature, NULL, NULL);
> +    object_property_add(obj, "temperature2", "int",
> +                        emc1413_get_temperature,
> +                        emc1413_set_temperature, NULL, NULL);
> +    object_property_add(obj, "temperature3", "int",
> +                        emc1413_get_temperature,
> +                        emc1413_set_temperature, NULL, NULL);
> +}
> +
> +static void emc1413_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> +    EMC1413Class *sc = EMC1413_CLASS(klass);
> +
> +    dc->realize = emc1413_realize;
> +    k->event = emc1413_event;
> +    k->recv = emc1413_rx;
> +    k->send = emc1413_tx;
> +    dc->vmsd = &vmstate_emc1413;
> +    sc->dev = (DeviceInfo *) data;
> +}
> +
> +static const TypeInfo emc1413_info = {
> +    .name          = TYPE_EMC1413,
> +    .parent        = TYPE_I2C_SLAVE,
> +    .instance_size = sizeof(EMC1413State),
> +    .class_size    = sizeof(EMC1413Class),
> +    .instance_init = emc1413_initfn,
> +    .abstract      = true,
> +};
> +
> +static void emc1413_register_types(void)
> +{
> +    int i;
> +
> +    type_register_static(&emc1413_info);
> +    for (i = 0; i < ARRAY_SIZE(devices); ++i) {
> +        TypeInfo ti = {
> +            .name       = devices[i].name,
> +            .parent     = TYPE_EMC1413,
> +            .class_init = emc1413_class_init,
> +            .class_data = (void *) &devices[i],
> +        };
> +        type_register(&ti);
> +    }
> +}
> +
> +type_init(emc1413_register_types)
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 793d45b1dc..08821c72ba 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -9,6 +9,7 @@ softmmu_ss.add(when: 'CONFIG_PCI_TESTDEV', if_true: files('pci-testdev.c'))
>  softmmu_ss.add(when: 'CONFIG_SGA', if_true: files('sga.c'))
>  softmmu_ss.add(when: 'CONFIG_TMP105', if_true: files('tmp105.c'))
>  softmmu_ss.add(when: 'CONFIG_TMP421', if_true: files('tmp421.c'))
> +softmmu_ss.add(when: 'CONFIG_EMC1413', if_true: files('emc1413.c'))
>  softmmu_ss.add(when: 'CONFIG_UNIMP', if_true: files('unimp.c'))
>  softmmu_ss.add(when: 'CONFIG_EMPTY_SLOT', if_true: files('empty_slot.c'))
>  
> 


