Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950D6C2BA83
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 18:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CF05206D6
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 18:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF05206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Ojv-0002oZ-Li
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 13:33:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.ibm.com>) id 1j3Oiy-0002Bq-RU
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 13:33:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.ibm.com>) id 1j3Oix-0004Dk-2w
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 13:33:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14052)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
 id 1j3Ois-00044o-Pc; Sun, 16 Feb 2020 13:32:55 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01GIJ3f4159010; Sun, 16 Feb 2020 13:32:52 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y6d5yttk5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 16 Feb 2020 13:32:52 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01GIK4Cv160965;
 Sun, 16 Feb 2020 13:32:51 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y6d5yttju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 16 Feb 2020 13:32:51 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01GIVJce017443;
 Sun, 16 Feb 2020 18:32:50 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma03dal.us.ibm.com with ESMTP id 2y689676av-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 16 Feb 2020 18:32:50 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01GIWn8l30540154
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Feb 2020 18:32:49 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AAB7EAE05C;
 Sun, 16 Feb 2020 18:32:49 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F03BAE05F;
 Sun, 16 Feb 2020 18:32:49 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Sun, 16 Feb 2020 18:32:49 +0000 (GMT)
Subject: Re: [RFC v2 5/6] tpm: Add the SysBus TPM TIS device
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20200214183704.14389-1-eric.auger@redhat.com>
 <20200214183704.14389-6-eric.auger@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <b0c30022-e6f3-b52d-60f8-e94db6b6fe99@linux.ibm.com>
Date: Sun, 16 Feb 2020 13:32:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200214183704.14389-6-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-16_04:2020-02-14,
 2020-02-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002160166
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: marcandre.lureau@redhat.com, lersek@redhat.com, ardb@kernel.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/14/20 1:37 PM, Eric Auger wrote:
> Introduce the tpm-tis-device which is a sysbus device
> and is bound to be used on ARM.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/tpm/Kconfig          |   5 ++
>   hw/tpm/Makefile.objs    |   1 +
>   hw/tpm/tpm_tis_sysbus.c | 159 ++++++++++++++++++++++++++++++++++++++++
>   include/sysemu/tpm.h    |   1 +
>   4 files changed, 166 insertions(+)
>   create mode 100644 hw/tpm/tpm_tis_sysbus.c
>
> diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
> index 686f8206bb..4794e7fe28 100644
> --- a/hw/tpm/Kconfig
> +++ b/hw/tpm/Kconfig
> @@ -7,6 +7,11 @@ config TPM_TIS_ISA
>       depends on TPM && ISA_BUS
>       select TPM_TIS
>   
> +config TPM_TIS_SYSBUS
> +    bool
> +    depends on TPM
> +    select TPM_TIS
> +
>   config TPM_TIS
>       bool
>       depends on TPM
> diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
> index 3ef2036cca..f1ec4beb95 100644
> --- a/hw/tpm/Makefile.objs
> +++ b/hw/tpm/Makefile.objs
> @@ -1,6 +1,7 @@
>   common-obj-$(CONFIG_TPM) += tpm_util.o
>   obj-$(call lor,$(CONFIG_TPM_TIS),$(CONFIG_TPM_CRB)) += tpm_ppi.o
>   common-obj-$(CONFIG_TPM_TIS_ISA) += tpm_tis_isa.o
> +common-obj-$(CONFIG_TPM_TIS_SYSBUS) += tpm_tis_sysbus.o
>   common-obj-$(CONFIG_TPM_TIS) += tpm_tis_common.o
>   common-obj-$(CONFIG_TPM_CRB) += tpm_crb.o
>   common-obj-$(CONFIG_TPM_PASSTHROUGH) += tpm_passthrough.o
> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> new file mode 100644
> index 0000000000..18c02aed67
> --- /dev/null
> +++ b/hw/tpm/tpm_tis_sysbus.c
> @@ -0,0 +1,159 @@
> +/*
> + * tpm_tis_sysbus.c - QEMU's TPM TIS SYSBUS Device
> + *
> + * Copyright (C) 2006,2010-2013 IBM Corporation
> + *
> + * Authors:
> + *  Stefan Berger <stefanb@us.ibm.com>
> + *  David Safford <safford@us.ibm.com>
> + *
> + * Xen 4 support: Andrease Niederl <andreas.niederl@iaik.tugraz.at>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * Implementation of the TIS interface according to specs found at
> + * http://www.trustedcomputinggroup.org. This implementation currently
> + * supports version 1.3, 21 March 2013
> + * In the developers menu choose the PC Client section then find the TIS
> + * specification.
> + *
> + * TPM TIS for TPM 2 implementation following TCG PC Client Platform
> + * TPM Profile (PTP) Specification, Familiy 2.0, Revision 00.43
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/qdev-properties.h"
> +#include "migration/vmstate.h"
> +#include "tpm_util.h"
> +#include "hw/sysbus.h"
> +#include "tpm_tis.h"
> +
> +typedef struct TPMStateSysBus {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    TPMState state; /* not a QOM object */
> +} TPMStateSysBus;
> +
> +#define TPM_TIS_SYSBUS(obj) OBJECT_CHECK(TPMStateSysBus, (obj), TYPE_TPM_TIS_SYSBUS)
> +
> +static int tpm_tis_pre_save_sysbus(void *opaque)
> +{
> +    TPMStateSysBus *sbdev = opaque;
> +
> +    return tpm_tis_pre_save(&sbdev->state);
> +}
> +
> +static const VMStateDescription vmstate_tpm_tis_sysbus = {
> +    .name = "tpm-tis",
> +    .version_id = 0,
> +    .pre_save  = tpm_tis_pre_save_sysbus,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_BUFFER(state.buffer, TPMStateSysBus),
> +        VMSTATE_UINT16(state.rw_offset, TPMStateSysBus),
> +        VMSTATE_UINT8(state.active_locty, TPMStateSysBus),
> +        VMSTATE_UINT8(state.aborting_locty, TPMStateSysBus),
> +        VMSTATE_UINT8(state.next_locty, TPMStateSysBus),
> +
> +        VMSTATE_STRUCT_ARRAY(state.loc, TPMStateSysBus, TPM_TIS_NUM_LOCALITIES,
> +                             0, vmstate_locty, TPMLocality),
> +
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void tpm_tis_sysbus_request_completed(TPMIf *ti, int ret)
> +{
> +    TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(ti);
> +    TPMState *s = &sbdev->state;
> +
> +    tpm_tis_request_completed(s, ret);
> +}
> +
> +static enum TPMVersion tpm_tis_sysbus_get_tpm_version(TPMIf *ti)
> +{
> +    TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(ti);
> +    TPMState *s = &sbdev->state;
> +
> +    return tpm_tis_get_tpm_version(s);
> +}
> +
> +static void tpm_tis_sysbus_reset(DeviceState *dev)
> +{
> +    TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(dev);
> +    TPMState *s = &sbdev->state;
> +
> +    return tpm_tis_reset(s);
> +}
> +
> +static Property tpm_tis_sysbus_properties[] = {
> +    DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS_IRQ),
> +    DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
> +    DEFINE_PROP_BOOL("ppi", TPMStateSysBus, state.ppi_enabled, true),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void tpm_tis_sysbus_initfn(Object *obj)
> +{
> +    TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(obj);
> +    TPMState *s = &sbdev->state;
> +
> +    memory_region_init_io(&s->mmio, obj, &tpm_tis_memory_ops,
> +                          s, "tpm-tis-mmio",
> +                          TPM_TIS_NUM_LOCALITIES << TPM_TIS_LOCALITY_SHIFT);
> +
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
> +}
> +
> +static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
> +{
> +    TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(dev);
> +    TPMState *s = &sbdev->state;
> +
> +    if (!tpm_find()) {
> +        error_setg(errp, "at most one TPM device is permitted");
> +        return;
> +    }
> +
> +    if (!s->be_driver) {
> +        error_setg(errp, "'tpmdev' property is required");
> +        return;
> +    }
> +}
> +
> +static void tpm_tis_sysbus_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    TPMIfClass *tc = TPM_IF_CLASS(klass);
> +
> +    device_class_set_props(dc, tpm_tis_sysbus_properties);
> +    dc->vmsd  = &vmstate_tpm_tis_sysbus;
> +    tc->model = TPM_MODEL_TPM_TIS;
> +    dc->realize = tpm_tis_sysbus_realizefn;
> +    dc->user_creatable = true;
> +    dc->reset = tpm_tis_sysbus_reset;
> +    tc->request_completed = tpm_tis_sysbus_request_completed;
> +    tc->get_version = tpm_tis_sysbus_get_tpm_version;
> +}
> +
> +static const TypeInfo tpm_tis_sysbus_info = {
> +    .name = TYPE_TPM_TIS_SYSBUS,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(TPMStateSysBus),
> +    .instance_init = tpm_tis_sysbus_initfn,
> +    .class_init  = tpm_tis_sysbus_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_TPM_IF },
> +        { }
> +    }
> +};
> +
> +static void tpm_tis_sysbus_register(void)
> +{
> +    type_register_static(&tpm_tis_sysbus_info);
> +}
> +
> +type_init(tpm_tis_sysbus_register)
> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
> index 1691b92c28..f37851b1aa 100644
> --- a/include/sysemu/tpm.h
> +++ b/include/sysemu/tpm.h
> @@ -44,6 +44,7 @@ typedef struct TPMIfClass {
>   } TPMIfClass;
>   
>   #define TYPE_TPM_TIS_ISA            "tpm-tis"
> +#define TYPE_TPM_TIS_SYSBUS         "tpm-tis-device"


hm, replace the rather generic 'device' with 'sysbus'?


Otherwise looks really good.


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


>   #define TYPE_TPM_CRB                "tpm-crb"
>   #define TYPE_TPM_SPAPR              "tpm-spapr"
>   



