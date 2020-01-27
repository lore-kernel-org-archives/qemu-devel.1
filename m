Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550ADC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 15:58:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B2EE2067C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 15:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2EE2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw6m1-00063b-Al
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 10:58:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <walling@linux.ibm.com>) id 1iw6lD-0005Vz-RX
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 10:57:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <walling@linux.ibm.com>) id 1iw6lC-0000yO-B5
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 10:57:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3116
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <walling@linux.ibm.com>)
 id 1iw6lC-0000uP-5V; Mon, 27 Jan 2020 10:57:10 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00RFsuYc140564; Mon, 27 Jan 2020 10:57:08 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xrjj17c69-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jan 2020 10:57:08 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00RFtYVi144396;
 Mon, 27 Jan 2020 10:57:07 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xrjj17c5h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jan 2020 10:57:07 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00RFtHvV030663;
 Mon, 27 Jan 2020 15:57:07 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma04dal.us.ibm.com with ESMTP id 2xrda6et6b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jan 2020 15:57:07 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00RFv6NO45875472
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2020 15:57:06 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 40150112062;
 Mon, 27 Jan 2020 15:57:06 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1261A112063;
 Mon, 27 Jan 2020 15:57:06 +0000 (GMT)
Received: from [9.56.58.87] (unknown [9.56.58.87])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 27 Jan 2020 15:57:05 +0000 (GMT)
Subject: Re: [PATCH v6 2/2] s390: diagnose 318 info reset and migration support
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <1579904044-20790-1-git-send-email-walling@linux.ibm.com>
 <1579904044-20790-3-git-send-email-walling@linux.ibm.com>
 <380c4902-e67d-0aff-103d-18815b221ac4@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Organization: IBM
Message-ID: <11435889-57d6-ed0b-d410-2f715324a20e@linux.ibm.com>
Date: Mon, 27 Jan 2020 10:57:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <380c4902-e67d-0aff-103d-18815b221ac4@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-27_05:2020-01-24,
 2020-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 phishscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/27/20 6:20 AM, David Hildenbrand wrote:
> [...]
>> @@ -0,0 +1,85 @@
>> +/*
>> + * DIAGNOSE 0x318 functions for reset and migration
>> + *
>> + * Copyright IBM, Corp. 2019
> 
> Should be 2020 now.
> 
> [...]

Where did the time go...

>> +static void s390_diag318_reset(DeviceState *dev)
>> +{
>> +    if (kvm_enabled())
>> +        kvm_s390_set_diag318_info(0);
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
> 
> Do we really need a new device? Can't we simply glue that extended state
> to the machine state?
> 
> -> target/s390x/machine.c
> 

Those VM States relate to the CPU state... does it make sense to store the
diag318 info in a CPU state? (It doesn't seem necessary to store / migrate
this info for each CPU).

Should we store this in the S390CcwMachineState? Or perhaps create a generic
S390MachineState for information that needs to be stored once and migrated
once?

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
>> + *
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
>> +
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
>> +    DeviceState *dev = DEVICE(new);
>> +
>> +    object_property_add_child(qdev_get_machine(), TYPE_S390_DIAG318,
>> +                              new, NULL);
>> +    object_unref(new);
>> +    qdev_init_nofail(dev);
>> +}
>> +
>>  static void ccw_init(MachineState *machine)
>>  {
>>      int ret;
>> @@ -294,6 +307,9 @@ static void ccw_init(MachineState *machine)
>>  
>>      /* init the TOD clock */
>>      s390_init_tod();
>> +
>> +    /* init object used for migrating diag318 info */
>> +    s390_init_diag318();
>>  }
>>  
>>  static void s390_cpu_plug(HotplugHandler *hotplug_dev,
>> @@ -566,6 +582,7 @@ static void machine_set_loadparm(Object *obj, const char *val, Error **errp)
>>          ms->loadparm[i] = ' '; /* pad right with spaces */
>>      }
>>  }
>> +
> 
> unrelated change.
> 
>>  static inline void s390_machine_initfn(Object *obj)
>>  {
>>      object_property_add_bool(obj, "aes-key-wrap",
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index f57ce7b..636348c 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -15,6 +15,7 @@
>>  #include "qemu/osdep.h"
>>  #include "qemu/units.h"
>>  #include "qapi/error.h"
>> +#include "qemu/error-report.h"
>>  #include "cpu.h"
>>  #include "sysemu/sysemu.h"
>>  #include "hw/boards.h"
>> @@ -22,6 +23,7 @@
>>  #include "hw/s390x/event-facility.h"
>>  #include "hw/s390x/s390-pci-bus.h"
>>  #include "hw/s390x/ipl.h"
>> +#include "kvm_s390x.h"
>>  
>>  static inline SCLPDevice *get_sclp_device(void)
>>  {
>> @@ -37,10 +39,19 @@ static void prepare_cpu_entries(SCLPDevice *sclp, CPUEntry *entry, int *count)
>>  {
>>      MachineState *ms = MACHINE(qdev_get_machine());
>>      uint8_t features[SCCB_CPU_FEATURE_LEN] = { 0 };
>> +    int max_entries;
>>      int i;
>>  
>> +    /* Calculate the max number of CPU entries that can be stored in the SCCB */
>> +    max_entries = (SCCB_SIZE - offsetof(ReadInfo, entries)) / sizeof(CPUEntry);
>> +
>>      s390_get_feat_block(S390_FEAT_TYPE_SCLP_CPU, features);
>>      for (i = 0, *count = 0; i < ms->possible_cpus->len; i++) {
>> +        if (*count == max_entries) {
>> +            warn_report("Configuration only supports a max of %d CPU entries.",
>> +                        max_entries);
> 
> I remember that "the sclp response will be limited to 247 CPUs if the
> feature is one". So we should have a double layout and make max_entries
> depending on s390_has_feat().

I'm looking back on previous discussions we had. Looks like this idea has been
mentioned before. (oops!) Perhaps I'm not understanding something.

How about we introduce a union in the ReadInfo struct. Something like:

    union {
        uint8_t  byte_134;
        struct CPUEntry entries[0];
    } x;

If the diag318 facility is enabled, then we'll use that first byte
for bit indication and only allow 247 CPUs. Otherwise, we'll discard
the byte and allow the original 248 CPUs.

The offset_cpu field in the ReadInfo struct would still be used to
locate the first entry, of course.

Note: the Read SCP Info fields are on a 16-byte boundary.

> 
> Regarding the message, I'd probably do a "Due to the current CPU model,
> some CPUs might be hidden from the VM (SCLP)."
> 
> A VM could still manually probe for others.
> 
> Thanks!
> 

Right. I'll make the change to the message.

Thank you for the review!

-- 
Respectfully,
- Collin Walling

