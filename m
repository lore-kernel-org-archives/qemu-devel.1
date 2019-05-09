Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D93C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 20:51:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FCFE217D6
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 20:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCFE217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60829 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOq11-0007Rp-HA
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 16:51:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1hOq0C-00071Q-J8
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1hOq0A-0004yF-LU
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:50:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1hOq0A-0004xr-Dy
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:50:50 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x49KfeHN060822
	for <qemu-devel@nongnu.org>; Thu, 9 May 2019 16:50:48 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2scu6bgxwe-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 16:50:47 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Thu, 9 May 2019 21:50:46 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
	by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 9 May 2019 21:50:42 +0100
Received: from b03ledav005.gho.boulder.ibm.com
	(b03ledav005.gho.boulder.ibm.com [9.17.130.236])
	by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x49KofEZ31916526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 9 May 2019 20:50:41 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45732BE053;
	Thu,  9 May 2019 20:50:41 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 918D3BE054;
	Thu,  9 May 2019 20:50:40 +0000 (GMT)
Received: from [9.63.15.61] (unknown [9.63.15.61])
	by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
	Thu,  9 May 2019 20:50:40 +0000 (GMT)
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org,
	qemu-s390x@nongnu.org, cohuck@redhat.com, rth@twiddle.net,
	david@redhat.com, pasic@linux.ibm.com, mst@redhat.com, pbonzini@redhat.com
References: <1556749903-19221-1-git-send-email-walling@linux.ibm.com>
	<4f5c8f1a-8898-c5e3-0b96-065a1ac21476@de.ibm.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Thu, 9 May 2019 16:50:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4f5c8f1a-8898-c5e3-0b96-065a1ac21476@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19050920-0012-0000-0000-000017345DF9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011078; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000285; SDB=6.01200984; UDB=6.00630194;
	IPR=6.00981874; 
	MB=3.00026818; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-09 20:50:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050920-0013-0000-0000-00005733C0F4
Message-Id: <c26d831b-1ef5-ad6d-f0ce-4f3c7c0993c0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-09_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905090118
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH v4] s390: diagnose 318 info reset and
 migration support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/9/19 5:58 AM, Christian Borntraeger wrote:
> 
> 
> On 02.05.19 00:31, Collin Walling wrote:
>> DIAGNOSE 0x318 (diag318) is a privileged s390x instruction that must
>> be intercepted by SIE and handled via KVM. Let's introduce some
>> functions to communicate between QEMU and KVM via ioctls. These
>> will be used to get/set the diag318 related information (also known
>> as the "Control Program Code" or "CPC"), as well as check the system
>> if KVM supports handling this instruction.
>>
>> The availability of this instruction is determined by byte 134, bit 0
>> of the Read Info block. This coincidentally expands into the space used
>> for CPU entries, which means VMs running with the diag318 capability
>> will have a reduced maximum CPU count. To alleviate this, let's calculate
>> the actual max CPU entry space by subtracting the size of Read Info from
>> the SCCB size then dividing that number by the size of a CPU entry. If
>> this value is less than the value denoted by S390_MAX_CPUS, then let's
>> reduce the max cpus for s390 from 248 to 240 in an effort to anticipate
>> this potentially happening again in the future.
>>
>> In order to simplify the migration and system reset requirements of
>> the diag318 data, let's introduce it as a device class and include
>> a VMStateDescription.
>>
>> Diag318 is reset on during modified clear and load normal.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>   hw/s390x/Makefile.objs       |   1 +
>>   hw/s390x/diag318.c           | 100 +++++++++++++++++++++++++++++++++++++++++++
>>   hw/s390x/diag318.h           |  39 +++++++++++++++++
>>   hw/s390x/s390-virtio-ccw.c   |  23 ++++++++++
>>   hw/s390x/sclp.c              |   5 +++
>>   include/hw/s390x/sclp.h      |   2 +
>>   linux-headers/asm-s390/kvm.h |   4 ++
>>   target/s390x/kvm-stub.c      |  15 +++++++
>>   target/s390x/kvm.c           |  32 ++++++++++++++
>>   target/s390x/kvm_s390x.h     |   3 ++
>>   10 files changed, 224 insertions(+)
>>   create mode 100644 hw/s390x/diag318.c
>>   create mode 100644 hw/s390x/diag318.h
>>
>> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
>> index e02ed80..93621dc 100644
>> --- a/hw/s390x/Makefile.objs
>> +++ b/hw/s390x/Makefile.objs
>> @@ -34,3 +34,4 @@ obj-$(CONFIG_KVM) += s390-stattrib-kvm.o
>>   obj-y += s390-ccw.o
>>   obj-y += ap-device.o
>>   obj-y += ap-bridge.o
>> +obj-y += diag318.o
>> diff --git a/hw/s390x/diag318.c b/hw/s390x/diag318.c
>> new file mode 100644
>> index 0000000..94b44da
>> --- /dev/null
>> +++ b/hw/s390x/diag318.c
>> @@ -0,0 +1,100 @@
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
>> +    kvm_s390_set_cpc(d->cpc);
>> +
>> +    /* It is not necessary to retain a copy of the cpc after migration. */
>> +    d->cpc = 0;
> 
> But we also do not need to zero it out? Can't you just drop these 2 lines?
> 
> 

Absolutely. I'll drop them.

>> +
>> +    return 0;
>> +}
>> +
>> +static int diag318_pre_save(void *opaque)
>> +{
>> +    DIAG318State *d = opaque;
>> +
>> +    kvm_s390_get_cpc(&d->cpc);
>> +    return 0;
>> +}
>> +
>> +static bool diag318_needed(void *opaque)
>> +{
>> +    DIAG318State *d = opaque;
>> +
>> +    return d->enabled;
>> +}
> 
> I would like to have a cpumodel entry that allows to disable that feature. And we should
> then check for this.
> 

Noted.

>> +
>> +const VMStateDescription vmstate_diag318 = {
>> +    .name = "vmstate_diag318",
>> +    .post_load = diag318_post_load,
>> +    .pre_save = diag318_pre_save,
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = diag318_needed,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINT64(cpc, DIAG318State),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +static void s390_diag318_realize(DeviceState *dev, Error **errp)
>> +{
>> +    DIAG318State *d = DIAG318(dev);
>> +
>> +    if (kvm_s390_has_diag318()) {
>> +        d->enabled = true;
>> +    }
> 
> same here -> cpumodel
> Then we can get rid of the enabled bool.

Noted.

[...]
>>   
>>   static void s390_cpu_plug(HotplugHandler *hotplug_dev,
>> @@ -570,6 +585,7 @@ static void machine_set_loadparm(Object *obj, const char *val, Error **errp)
>>           ms->loadparm[i] = ' '; /* pad right with spaces */
>>       }
>>   }
>> +
>>   static inline void s390_machine_initfn(Object *obj)
>>   {
>>       object_property_add_bool(obj, "aes-key-wrap",
>> @@ -652,6 +668,13 @@ static void ccw_machine_4_0_instance_options(MachineState *machine)
>>   
>>   static void ccw_machine_4_0_class_options(MachineClass *mc)
>>   {
>> +    /*
>> +     * Read Info might reveal more bytes used to detect facilities, thus
>> +     * reducing the number of CPU entries. Let's reduce the max CPUs by
>> +     * an arbitrary number in effort to anticipate future facility bytes.
>> +     */
>> +    if ((SCCB_SIZE - sizeof(ReadInfo)) / sizeof(CPUEntry) < S390_MAX_CPUS)
>> +        mc->max_cpus = S390_MAX_CPUS - 8;
> 
> Maybe this should depend on the presence of this feature in the cpumodel?
> 

That's a good idea. This would allow the user to fine tune their VM to
either allow the original max 248 _or_ enable the diag318 instruction.

Do you think the reduction to 240 max CPUs still makes sense? I do not
know what the future of the RSCPI looks like, but if we end up with more
bytes indicating facility bits, we could simply reduce the the max CPUs
dynamically depending on which features the user / CPU model enables.

In this case, if diag318 is enabled then reduce the max CPUs to 247.
CPU models can protect us WRT migration -- we wouldn't have to concern
ourselves if the destination machine can support the same number of
CPUs.

In the future, if feature X is enabled, then reduce the max CPUs to as
many as we can fit in the remainder of the SCCB.

>>   }
>>   DEFINE_CCW_MACHINE(4_0, "4.0", true);
>>   
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index 4510a80..9cfa188 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -22,6 +22,7 @@
>>   #include "hw/s390x/event-facility.h"
>>   #include "hw/s390x/s390-pci-bus.h"
>>   #include "hw/s390x/ipl.h"
>> +#include "kvm_s390x.h"
>>   
>>   static inline SCLPDevice *get_sclp_device(void)
>>   {
>> @@ -74,6 +75,10 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>>       s390_get_feat_block(S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
>>                            read_info->conf_char_ext);
>>   
>> +    /* Enable diag318 for guest if KVM supports emulation */
>> +    if (kvm_s390_has_diag318())
>> +        read_info->fac134 = 0x80;
> 
> I think we should rather make this part of the cpumodel
> 
> 

As per an older discussion, does it still make sense to restrict this
feature starting with a particular CPU model (we decided to allow this
feature starting with the zEC12 model). We have the opportunity to
simply enable this feature for *all* CPU models since this only requires
KVM to support emulation.

Pseudo:

if diag318_cpu_feat_is_enabled
	if kvm_has_diag318
		set facility bit for diag318
	else
		error "KVM does not support emulation of diag318"
		<terminate>

The next question would be this: do we want this feature to be enabled
by default, or only if it is specified by the user?

Default enabled: VMs will have the diag318 capability, but max CPUs will
also be reduced by default. Use will have to explicitly disable diag318
to allow the max 248 CPUs.

User enabled: VMs will have to be configured to enable this capability
(users might not realize / care to add this feature themselves). This is
as simple as providing the CPU model in a guest XML or command line and
providing the diag318feature. The max CPUs will not be altered by
default.

>> +
>>       read_info->facilities = cpu_to_be64(SCLP_HAS_CPU_INFO |
>>                                           SCLP_HAS_IOA_RECONFIG);
>>   
>> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
>> index f9db243..d47e10a 100644
>> --- a/include/hw/s390x/sclp.h
>> +++ b/include/hw/s390x/sclp.h
>> @@ -133,6 +133,8 @@ typedef struct ReadInfo {
>>       uint16_t highest_cpu;
>>       uint8_t  _reserved5[124 - 122];     /* 122-123 */
>>       uint32_t hmfai;
>> +    uint8_t  _reserved7[134 - 128];     /* 128-133 */
>> +    uint8_t  fac134;
>>       struct CPUEntry entries[0];
>>   } QEMU_PACKED ReadInfo;
>>   
>> diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
>> index 0265482..735f5a4 100644
>> --- a/linux-headers/asm-s390/kvm.h
>> +++ b/linux-headers/asm-s390/kvm.h
>> @@ -74,6 +74,7 @@ struct kvm_s390_io_adapter_req {
>>   #define KVM_S390_VM_CRYPTO		2
>>   #define KVM_S390_VM_CPU_MODEL		3
>>   #define KVM_S390_VM_MIGRATION		4
>> +#define KVM_S390_VM_MISC		5
> 
> Can you split that out into a separate patch (header sync). (We also need the relevant kernel
> patch first, I could not find it right now).

Gah, I keep forgetting about splitting this. Thanks for the reminder :)

[...]


