Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF8CC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 14:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38FC6208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 14:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38FC6208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg8cW-0007Jl-En
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 10:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50644)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <walling@linux.ibm.com>) id 1hg8ag-0006FV-7M
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 10:08:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <walling@linux.ibm.com>) id 1hg8ae-0004OU-6P
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 10:08:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49668
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <walling@linux.ibm.com>)
 id 1hg8aa-0004Jo-G2
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 10:07:58 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5QE7lM4054985
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 10:07:53 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tca1dgrnt-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 10:07:52 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
 Wed, 26 Jun 2019 15:07:44 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
 by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 26 Jun 2019 15:07:40 +0100
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5QE7dBq51708344
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2019 14:07:39 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 39B0028059;
 Wed, 26 Jun 2019 14:07:39 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E54E28058;
 Wed, 26 Jun 2019 14:07:39 +0000 (GMT)
Received: from [9.63.14.61] (unknown [9.63.14.61])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 26 Jun 2019 14:07:39 +0000 (GMT)
To: Cornelia Huck <cohuck@redhat.com>
References: <1561475829-19202-1-git-send-email-walling@linux.ibm.com>
 <1561475829-19202-3-git-send-email-walling@linux.ibm.com>
 <20190626143324.6f359cd0.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Wed, 26 Jun 2019 10:07:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190626143324.6f359cd0.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19062614-0052-0000-0000-000003D6797C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011334; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01223558; UDB=6.00643913; IPR=6.01004737; 
 MB=3.00027476; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-26 14:07:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062614-0053-0000-0000-00006177C03D
Message-Id: <7a47fc60-e490-3c95-66f5-3e16a2ad9da7@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-26_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906260169
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH v5 2/2] s390: diagnose 318 info reset and
 migration support
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
Cc: david@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/19 8:33 AM, Cornelia Huck wrote:
> On Tue, 25 Jun 2019 11:17:09 -0400
> Collin Walling <walling@linux.ibm.com> wrote:
> 
>> DIAGNOSE 0x318 (diag318) is a privileged s390x instruction that must
>> be intercepted by SIE and handled via KVM. Let's introduce some
>> functions to communicate between QEMU and KVM via ioctls. These
>> will be used to get/set the diag318 information.
>>
>> The availability of this instruction is determined by byte 134, bit 0
>> of the Read Info block. This coincidentally expands into the space used
>> for CPU entries, which means VMs running with the diag318 capability
>> will have a reduced maximum CPU count. Let's reduce the maximum CPU
>> count from 248 to 247.
>>
>> In order to simplify the migration and system reset requirements of
>> the diag318 data, let's introduce it as a device class and include
>> a VMStateDescription.
>>
>> Diag318 is set to 0 during modified clear and load normal resets.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>   hw/s390x/Makefile.objs          |  1 +
>>   hw/s390x/diag318.c              | 80 +++++++++++++++++++++++++++++++++++++++++
>>   hw/s390x/diag318.h              | 38 ++++++++++++++++++++
>>   hw/s390x/s390-virtio-ccw.c      | 17 +++++++++
>>   hw/s390x/sclp.c                 |  3 ++
>>   include/hw/s390x/sclp.h         |  2 ++
>>   target/s390x/cpu.h              |  8 ++++-
>>   target/s390x/cpu_features.c     |  3 ++
>>   target/s390x/cpu_features.h     |  1 +
>>   target/s390x/cpu_features_def.h |  3 ++
>>   target/s390x/gen-features.c     |  1 +
>>   target/s390x/kvm-stub.c         | 10 ++++++
>>   target/s390x/kvm.c              | 29 +++++++++++++++
>>   target/s390x/kvm_s390x.h        |  2 ++
>>   14 files changed, 197 insertions(+), 1 deletion(-)
>>   create mode 100644 hw/s390x/diag318.c
>>   create mode 100644 hw/s390x/diag318.h
> 
> (...)
> 
>> diff --git a/hw/s390x/diag318.c b/hw/s390x/diag318.c
>> new file mode 100644
>> index 0000000..0eb80fe
>> --- /dev/null
>> +++ b/hw/s390x/diag318.c
>> @@ -0,0 +1,80 @@
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
>> +#include "hw/s390x/diag318.h"
>> +#include "qapi/error.h"
>> +#include "kvm_s390x.h"
>> +#include "sysemu/kvm.h"
>> +
>> +static int diag318_post_load(void *opaque, int version_id)
>> +{
>> +    DIAG318State *d = opaque;
>> +
>> +    kvm_s390_set_diag318_info(d->info);
> 
> Shouldn't we at least moan if something goes wrong here?
> 

What are some things that might go wrong at this point? We
should only call this if the diag318 feature is enabled. If
we try to toggle that feature on a machine that cannot support
it, the guest will fail to start, stating (paraphrased) "some
features are not available in the configuration: diag318"

Is there some sort of issue that could arise from QEMU that I'm not
considering?

>> +    return 0;
>> +}
>> +
>> +static int diag318_pre_save(void *opaque)
>> +{
>> +    DIAG318State *d = opaque;
>> +
>> +    kvm_s390_get_diag318_info(&d->info);
>> +    return 0;
>> +}
>> +
>> +static bool diag318_needed(void *opaque)
>> +{
>> +    return s390_has_feat(S390_FEAT_DIAG318);
> 
> What happens if we emulate diag 318 in tcg and set this feature bit? We
> probably don't want to call kvm_ functions in that case.
> 

I have not tested on tcg.

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
>> +    kvm_s390_set_diag318_info(0);
> 
> Same here; we probably need a s390_set_diag318_info() function that
> either calls the kvm_ function or resets some internal state.
> 

Hmm okay. I recall doing this for the TOD-clock stuff way-back. I'll
include these functions next round.

>> +}
>> +
>> +static void s390_diag318_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +
>> +    dc->reset = s390_diag318_reset;
>> +    dc->vmsd = &vmstate_diag318;
>> +    dc->hotpluggable = false;
>> +    /* Reason: Set automatically during IPL */
> 
> "Created automatically during machine instantiation" ?
> 

I like it.

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
> 
> (..)
> 
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 87b2039..54230c7 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -38,6 +38,7 @@
>>   #include "cpu_models.h"
>>   #include "hw/nmi.h"
>>   #include "hw/s390x/tod.h"
>> +#include "hw/s390x/diag318.h"
>>   
>>   S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>>   {
>> @@ -94,6 +95,7 @@ static const char *const reset_dev_types[] = {
>>       "s390-sclp-event-facility",
>>       "s390-flic",
>>       "diag288",
>> +    TYPE_S390_DIAG318,
> 
> This looks a bit odd, although it is not wrong :)
> 

It's cut-off here, but TYPE_VIRTUAL_CSS_BRIDGE is also in the list :)

>>   };
>>   
>>   static void subsystem_reset(void)
>> @@ -258,6 +260,17 @@ static void s390_create_sclpconsole(const char *type, Chardev *chardev)
>>       qdev_init_nofail(dev);
>>   }
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
>>   static void ccw_init(MachineState *machine)
>>   {
>>       int ret;
>> @@ -315,6 +328,9 @@ static void ccw_init(MachineState *machine)
>>   
>>       /* init the TOD clock */
>>       s390_init_tod();
>> +
>> +    /* init object used for migrating diag318 info */
>> +    s390_init_diag318();
>>   }
>>   
>>   static void s390_cpu_plug(HotplugHandler *hotplug_dev,
>> @@ -583,6 +599,7 @@ static void machine_set_loadparm(Object *obj, const char *val, Error **errp)
>>           ms->loadparm[i] = ' '; /* pad right with spaces */
>>       }
>>   }
>> +
> 
> unrelated whitespace change :)
> 

Whoops, thanks.

>>   static inline void s390_machine_initfn(Object *obj)
>>   {
>>       object_property_add_bool(obj, "aes-key-wrap",
> 
> (...)
> 
>> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
>> index f64f581..77a1df5 100644
>> --- a/target/s390x/cpu_features.c
>> +++ b/target/s390x/cpu_features.c
>> @@ -127,6 +127,9 @@ static const S390FeatDef s390_features[] = {
>>       FEAT_INIT("pfmfi", S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT, 9, "SIE: PFMF interpretation facility"),
>>       FEAT_INIT("ibs", S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT, 10, "SIE: Interlock-and-broadcast-suppression facility"),
>>   
>> +    /* SCLP SCCB Byte 134 */
>> +    FEAT_INIT("diag318", S390_FEAT_TYPE_SCLP_BYTE_134, 0, "Control program name and version codes"),
>> +
>>       FEAT_INIT("sief2", S390_FEAT_TYPE_SCLP_CPU, 4, "SIE: interception format 2 (Virtual SIE)"),
>>       FEAT_INIT("skey", S390_FEAT_TYPE_SCLP_CPU, 5, "SIE: Storage-key facility"),
>>       FEAT_INIT("gpereh", S390_FEAT_TYPE_SCLP_CPU, 10, "SIE: Guest-PER enhancement facility"),
>> diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
>> index da695a8..954544e 100644
>> --- a/target/s390x/cpu_features.h
>> +++ b/target/s390x/cpu_features.h
>> @@ -23,6 +23,7 @@ typedef enum {
>>       S390_FEAT_TYPE_STFL,
>>       S390_FEAT_TYPE_SCLP_CONF_CHAR,
>>       S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
>> +    S390_FEAT_TYPE_SCLP_BYTE_134,
>>       S390_FEAT_TYPE_SCLP_CPU,
>>       S390_FEAT_TYPE_MISC,
>>       S390_FEAT_TYPE_PLO,
>> diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
>> index 292b17b..4f2c23e 100644
>> --- a/target/s390x/cpu_features_def.h
>> +++ b/target/s390x/cpu_features_def.h
>> @@ -115,6 +115,9 @@ typedef enum {
>>       S390_FEAT_SIE_PFMFI,
>>       S390_FEAT_SIE_IBS,
>>   
>> +    /* Sclp Byte 134 */
>> +    S390_FEAT_DIAG318,
>> +
>>       /* Sclp Cpu */
>>       S390_FEAT_SIE_F2,
>>       S390_FEAT_SIE_SKEY,
>> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
>> index dc320a0..cdd1875 100644
>> --- a/target/s390x/gen-features.c
>> +++ b/target/s390x/gen-features.c
>> @@ -521,6 +521,7 @@ static uint16_t full_GEN12_GA1[] = {
>>       S390_FEAT_AP_QUERY_CONFIG_INFO,
>>       S390_FEAT_AP_FACILITIES_TEST,
>>       S390_FEAT_AP,
>> +    S390_FEAT_DIAG318,
>>   };
>>   
>>   static uint16_t full_GEN12_GA2[] = {
> 
> The feature bit stuff probably needs some (easy) adaption on top of my
> s390-next branch.
> 

I just noticed David's changes to that code. Should make this
feature stuff a bit easier.

Thanks for the review!


