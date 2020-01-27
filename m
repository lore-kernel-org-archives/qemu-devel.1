Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D28C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 15:59:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68801206D5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 15:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68801206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw6n0-0006xF-LB
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 10:59:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <walling@linux.ibm.com>) id 1iw6mL-0006PO-2O
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 10:58:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <walling@linux.ibm.com>) id 1iw6mI-0003r3-K6
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 10:58:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <walling@linux.ibm.com>)
 id 1iw6mI-0003qA-El; Mon, 27 Jan 2020 10:58:18 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00RFw05i056156; Mon, 27 Jan 2020 10:58:18 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xrvw6rjg0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jan 2020 10:58:17 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00RFw83d056431;
 Mon, 27 Jan 2020 10:58:16 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xrvw6rjcn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jan 2020 10:58:15 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00RFtHte004654;
 Mon, 27 Jan 2020 15:58:12 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma03wdc.us.ibm.com with ESMTP id 2xrda6285h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jan 2020 15:58:12 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00RFwCG353215538
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2020 15:58:12 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76382112063;
 Mon, 27 Jan 2020 15:58:12 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50905112061;
 Mon, 27 Jan 2020 15:58:12 +0000 (GMT)
Received: from [9.56.58.87] (unknown [9.56.58.87])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 27 Jan 2020 15:58:12 +0000 (GMT)
Subject: Re: [PATCH v6 2/2] s390: diagnose 318 info reset and migration support
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <1579904044-20790-1-git-send-email-walling@linux.ibm.com>
 <1579904044-20790-3-git-send-email-walling@linux.ibm.com>
 <e0d193cc-ca9b-bcdb-df7c-87ac9ce8ec4a@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Organization: IBM
Message-ID: <e53ae589-5ebb-42ec-4747-853223e7925b@linux.ibm.com>
Date: Mon, 27 Jan 2020 10:58:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e0d193cc-ca9b-bcdb-df7c-87ac9ce8ec4a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-27_05:2020-01-24,
 2020-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001270134
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: borntraeger@de.ibm.com, rth@twiddle.net, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/27/20 6:36 AM, Thomas Huth wrote:
> On 24/01/2020 23.14, Collin Walling wrote:
>> DIAGNOSE 0x318 (diag318) is a privileged s390x instruction that must
>> be intercepted by SIE and handled via KVM. Let's introduce some
>> functions to communicate between QEMU and KVM via ioctls. These
>> will be used to get/set the diag318 information.
>>
>> The availability of this instruction is determined by byte 134, bit 0
>> of the Read Info block. This coincidentally expands into the space used
>> for CPU entries by taking away one byte, which means VMs running with
>> the diag318 capability will not be able to retrieve information regarding
>> the 248th CPU. This will not effect performance, and VMs can still be
> 
> s/effect/affect/ ?
> 
>> ran with 248 CPUs.
> 
> s/ran/run/ ?
> 
>> In order to simplify the migration and system reset requirements of
>> the diag318 data, let's introduce it as a device class and include
>> a VMStateDescription.
>>
>> Diag318 is set to 0 during modified clear and load normal resets.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>  hw/s390x/Makefile.objs              |  1 +
>>  hw/s390x/diag318.c                  | 85 +++++++++++++++++++++++++++++++++++++
>>  hw/s390x/diag318.h                  | 40 +++++++++++++++++
>>  hw/s390x/s390-virtio-ccw.c          | 17 ++++++++
>>  hw/s390x/sclp.c                     | 13 ++++++
>>  include/hw/s390x/sclp.h             |  2 +
>>  target/s390x/cpu_features.h         |  1 +
>>  target/s390x/cpu_features_def.inc.h |  3 ++
>>  target/s390x/gen-features.c         |  1 +
>>  target/s390x/kvm-stub.c             | 10 +++++
>>  target/s390x/kvm.c                  | 29 +++++++++++++
>>  target/s390x/kvm_s390x.h            |  2 +
>>  12 files changed, 204 insertions(+)
>>  create mode 100644 hw/s390x/diag318.c
>>  create mode 100644 hw/s390x/diag318.h
>>
>> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
>> index e02ed80..93621dc 100644
>> --- a/hw/s390x/Makefile.objs
>> +++ b/hw/s390x/Makefile.objs
>> @@ -34,3 +34,4 @@ obj-$(CONFIG_KVM) += s390-stattrib-kvm.o
>>  obj-y += s390-ccw.o
>>  obj-y += ap-device.o
>>  obj-y += ap-bridge.o
>> +obj-y += diag318.o
>> diff --git a/hw/s390x/diag318.c b/hw/s390x/diag318.c
>> new file mode 100644
>> index 0000000..2d30bb2
>> --- /dev/null
>> +++ b/hw/s390x/diag318.c
>> @@ -0,0 +1,85 @@
>> +/*
>> + * DIAGNOSE 0x318 functions for reset and migration
>> + *
>> + * Copyright IBM, Corp. 2019
> 
> Bump to 2020 ?
> 
>> + * Authors:
>> + *  Collin Walling <walling@linux.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or (at your
>> + * option) any later version. See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "hw/s390x/diag318.h"
>> +#include "qapi/error.h"
>> +#include "kvm_s390x.h"
>> +#include "sysemu/kvm.h"
>> +
>> +static int diag318_post_load(void *opaque, int version_id)
>> +{
>> +    DIAG318State *d = opaque;
>> +
>> +    if (kvm_enabled())
>> +        kvm_s390_set_diag318_info(d->info);
> 
> QEMU coding style requires curly braces also for single lines.
> 
>> +    return 0;
>> +}
>> +
>> +static int diag318_pre_save(void *opaque)
>> +{
>> +    DIAG318State *d = opaque;
>> +
>> +    if (kvm_enabled())
>> +        kvm_s390_get_diag318_info(&d->info);
> 
> dito
> 
>> +    return 0;
>> +}
>> +
>> +static bool diag318_needed(void *opaque)
>> +{
>> +    return kvm_enabled() ? s390_has_feat(S390_FEAT_DIAG318) : 0;
>> +}
>> +
>> +const VMStateDescription vmstate_diag318 = {
>> +    .name = "vmstate_diag318",
>> +    .post_load = diag318_post_load,
>> +    .pre_save = diag318_pre_save,
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = diag318_needed,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINT64(info, DIAG318State),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +static void s390_diag318_reset(DeviceState *dev)
>> +{
>> +    if (kvm_enabled())
>> +        kvm_s390_set_diag318_info(0);
> 
> dito
> 
>> +}
>> +
>> +static void s390_diag318_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +
>> +    dc->reset = s390_diag318_reset;
>> +    dc->vmsd = &vmstate_diag318;
>> +    dc->hotpluggable = false;
>> +    /* Reason: Created automatically during machine instantiation */
>> +    dc->user_creatable = false;
>> +}
>> +
>> +static const TypeInfo s390_diag318_info = {
>> +    .class_init = s390_diag318_class_init,
>> +    .parent = TYPE_DEVICE,
>> +    .name = TYPE_S390_DIAG318,
>> +    .instance_size = sizeof(DIAG318State),
>> +};
>> +
>> +static void s390_diag318_register_types(void)
>> +{
>> +    type_register_static(&s390_diag318_info);
>> +}
>> +
>> +type_init(s390_diag318_register_types)
>> diff --git a/hw/s390x/diag318.h b/hw/s390x/diag318.h
>> new file mode 100644
>> index 0000000..06d9f67
>> --- /dev/null
>> +++ b/hw/s390x/diag318.h
>> @@ -0,0 +1,40 @@
>> +/*
>> + * DIAGNOSE 0x318 functions for reset and migration
>> + *
>> + * Copyright IBM, Corp. 2019
> 
> 2020 ?
> 
>> + * Authors:
>> + *  Collin Walling <walling@linux.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or (at your
>> + * option) any later version. See the COPYING file in the top-level directory.
>> + */
>> +
>> +#ifndef HW_DIAG318_H
>> +#define HW_DIAG318_H
>> +
>> +#include "qemu/osdep.h"
>> +#include "migration/vmstate.h"
>> +#include "qom/object.h"
>> +#include "hw/qdev-core.h"
>> +
>> +#define TYPE_S390_DIAG318 "diag318"
>> +#define DIAG318(obj) \
>> +    OBJECT_CHECK(DIAG318State, (obj), TYPE_S390_DIAG318)
>> +
>> +typedef struct DIAG318State {
>> +    /*< private >*/
>> +    DeviceState parent_obj;
>> +
>> +    /*< public >*/
>> +    uint64_t info;
>> +} DIAG318State;
>> +
>> +typedef struct DIAG318Class {
>> +    /*< private >*/
>> +    DeviceClass parent_class;
>> +
>> +    /*< public >*/
>> +} DIAG318Class;
> 
> You don't use DIAG318Class anywhere. Please drop it.
> 
>> +#endif /* HW_DIAG318_H */
>> \ No newline at end of file
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index e0e2813..d5b7a33 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -41,6 +41,7 @@
>>  #include "hw/qdev-properties.h"
>>  #include "hw/s390x/tod.h"
>>  #include "sysemu/sysemu.h"
>> +#include "hw/s390x/diag318.h"
>>  
>>  S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>>  {
>> @@ -97,6 +98,7 @@ static const char *const reset_dev_types[] = {
>>      "s390-sclp-event-facility",
>>      "s390-flic",
>>      "diag288",
>> +    TYPE_S390_DIAG318,
>>  };
>>  
>>  static void subsystem_reset(void)
>> @@ -237,6 +239,17 @@ static void s390_create_sclpconsole(const char *type, Chardev *chardev)
>>      qdev_init_nofail(dev);
>>  }
>>  
>> +static void s390_init_diag318(void)
>> +{
>> +    Object *new = object_new(TYPE_S390_DIAG318);
> 
> For the very unlikely case that we ever switch QEMU to C++ ... could you
> maybe use a different variable name than "new" ? Simply "obj" maybe?
> 
>> +    DeviceState *dev = DEVICE(new);
>> +
>> +    object_property_add_child(qdev_get_machine(), TYPE_S390_DIAG318,
>> +                              new, NULL);
>> +    object_unref(new);
>> +    qdev_init_nofail(dev);
>> +}
>> +
> 
>  Thomas
> 

Noted your comments. Thanks for the review! I'll remember to run checkpatch
next time ;)

-- 
Respectfully,
- Collin Walling

