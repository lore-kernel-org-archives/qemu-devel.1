Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094B9C00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 891532074F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891532074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZlRT-0000mV-Cx
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 20:48:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kZlQK-0000Dh-FW; Mon, 02 Nov 2020 20:47:49 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:2123)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kZlQA-0001DD-Rz; Mon, 02 Nov 2020 20:47:47 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CQCMg5wS9z71pH;
 Tue,  3 Nov 2020 09:47:27 +0800 (CST)
Received: from [10.174.186.67] (10.174.186.67) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 09:47:21 +0800
Subject: Re: [RFC PATCH v2 05/13] hw: add compat machines for 5.3
To: Andrew Jones <drjones@redhat.com>
References: <20201020131440.1090-1-fangying1@huawei.com>
 <20201020131440.1090-6-fangying1@huawei.com>
 <20201029170813.n7kst474zrh24m2t@kamzik.brq.redhat.com>
From: Ying Fang <fangying1@huawei.com>
Message-ID: <8c61d85f-5144-ae75-67a3-aaae1783a350@huawei.com>
Date: Tue, 3 Nov 2020 09:47:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20201029170813.n7kst474zrh24m2t@kamzik.brq.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.67]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=fangying1@huawei.com;
 helo=szxga07-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 20:47:30
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 qemu-devel@nongnu.org, alex.chen@huawei.com, shannon.zhaosl@gmail.com,
 qemu-arm@nongnu.org, alistair.francis@wdc.com, imammedo@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/30/2020 1:08 AM, Andrew Jones wrote:
> On Tue, Oct 20, 2020 at 09:14:32PM +0800, Ying Fang wrote:
>> Add 5.2 machine types for arm/i440fx/q35/s390x/spapr.
>        ^ 5.3

Thanks. Will fix, careless spelling mistake.

> 
> Thanks,
> drew
> 
>>
>> Signed-off-by: Ying Fang <fangying1@huawei.com>
>> ---
>>   hw/arm/virt.c              |  9 ++++++++-
>>   hw/core/machine.c          |  3 +++
>>   hw/i386/pc.c               |  3 +++
>>   hw/i386/pc_piix.c          | 15 ++++++++++++++-
>>   hw/i386/pc_q35.c           | 14 +++++++++++++-
>>   hw/ppc/spapr.c             | 15 +++++++++++++--
>>   hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
>>   include/hw/boards.h        |  3 +++
>>   include/hw/i386/pc.h       |  3 +++
>>   9 files changed, 73 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index ba902b53ba..ff8a14439e 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -2665,10 +2665,17 @@ static void machvirt_machine_init(void)
>>   }
>>   type_init(machvirt_machine_init);
>>   
>> +static void virt_machine_5_3_options(MachineClass *mc)
>> +{
>> +}
>> +DEFINE_VIRT_MACHINE_AS_LATEST(5, 3)
>> +
>>   static void virt_machine_5_2_options(MachineClass *mc)
>>   {
>> +    virt_machine_5_3_options(mc);
>> +    compat_props_add(mc->compat_props, hw_compat_5_2, hw_compat_5_2_len);
>>   }
>> -DEFINE_VIRT_MACHINE_AS_LATEST(5, 2)
>> +DEFINE_VIRT_MACHINE(5, 2)
>>   
>>   static void virt_machine_5_1_options(MachineClass *mc)
>>   {
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 7e2f4ec08e..6dc77699a9 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -28,6 +28,9 @@
>>   #include "hw/mem/nvdimm.h"
>>   #include "migration/vmstate.h"
>>   
>> +GlobalProperty hw_compat_5_2[] = { };
>> +const size_t hw_compat_5_2_len = G_N_ELEMENTS(hw_compat_5_2);
>> +
>>   GlobalProperty hw_compat_5_1[] = {
>>       { "vhost-scsi", "num_queues", "1"},
>>       { "vhost-user-blk", "num-queues", "1"},
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index e87be5d29a..eaa046ff5d 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -97,6 +97,9 @@
>>   #include "trace.h"
>>   #include CONFIG_DEVICES
>>   
>> +GlobalProperty pc_compat_5_2[] = { };
>> +const size_t pc_compat_5_2_len = G_N_ELEMENTS(pc_compat_5_2);
>> +
>>   GlobalProperty pc_compat_5_1[] = {
>>       { "ICH9-LPC", "x-smi-cpu-hotplug", "off" },
>>   };
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index 3c2ae0612b..01254090ce 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -426,7 +426,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
>>       machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
>>   }
>>   
>> -static void pc_i440fx_5_2_machine_options(MachineClass *m)
>> +static void pc_i440fx_5_3_machine_options(MachineClass *m)
>>   {
>>       PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>>       pc_i440fx_machine_options(m);
>> @@ -435,6 +435,19 @@ static void pc_i440fx_5_2_machine_options(MachineClass *m)
>>       pcmc->default_cpu_version = 1;
>>   }
>>   
>> +DEFINE_I440FX_MACHINE(v5_3, "pc-i440fx-5.3", NULL,
>> +                      pc_i440fx_5_3_machine_options);
>> +
>> +static void pc_i440fx_5_2_machine_options(MachineClass *m)
>> +{
>> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>> +    pc_i440fx_machine_options(m);
>> +    m->alias = NULL;
>> +    m->is_default = false;
>> +    compat_props_add(m->compat_props, hw_compat_5_2, hw_compat_5_2_len);
>> +    compat_props_add(m->compat_props, pc_compat_5_2, pc_compat_5_2_len);
>> +}
>> +
>>   DEFINE_I440FX_MACHINE(v5_2, "pc-i440fx-5.2", NULL,
>>                         pc_i440fx_5_2_machine_options);
>>   
>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>> index a3f4959c43..dd14803edb 100644
>> --- a/hw/i386/pc_q35.c
>> +++ b/hw/i386/pc_q35.c
>> @@ -344,7 +344,7 @@ static void pc_q35_machine_options(MachineClass *m)
>>       m->max_cpus = 288;
>>   }
>>   
>> -static void pc_q35_5_2_machine_options(MachineClass *m)
>> +static void pc_q35_5_3_machine_options(MachineClass *m)
>>   {
>>       PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>>       pc_q35_machine_options(m);
>> @@ -352,6 +352,18 @@ static void pc_q35_5_2_machine_options(MachineClass *m)
>>       pcmc->default_cpu_version = 1;
>>   }
>>   
>> +DEFINE_Q35_MACHINE(v5_3, "pc-q35-5.3", NULL,
>> +                   pc_q35_5_3_machine_options);
>> +
>> +static void pc_q35_5_2_machine_options(MachineClass *m)
>> +{
>> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>> +    pc_q35_machine_options(m);
>> +    m->alias = NULL;
>> +    compat_props_add(m->compat_props, hw_compat_5_2, hw_compat_5_2_len);
>> +    compat_props_add(m->compat_props, pc_compat_5_2, pc_compat_5_2_len);
>> +}
>> +
>>   DEFINE_Q35_MACHINE(v5_2, "pc-q35-5.2", NULL,
>>                      pc_q35_5_2_machine_options);
>>   
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 2db810f73a..c292a3edd9 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -4511,15 +4511,26 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
>>       }                                                                \
>>       type_init(spapr_machine_register_##suffix)
>>   
>> +/*
>> + * pseries-5.3
>> + */
>> +static void spapr_machine_5_3_class_options(MachineClass *mc)
>> +{
>> +    /* Defaults for the latest behaviour inherited from the base class */
>> +}
>> +
>> +DEFINE_SPAPR_MACHINE(5_3, "5.3", true);
>> +
>>   /*
>>    * pseries-5.2
>>    */
>>   static void spapr_machine_5_2_class_options(MachineClass *mc)
>>   {
>> -    /* Defaults for the latest behaviour inherited from the base class */
>> +    spapr_machine_5_3_class_options(mc);
>> +    compat_props_add(mc->compat_props, hw_compat_5_2, hw_compat_5_2_len);
>>   }
>>   
>> -DEFINE_SPAPR_MACHINE(5_2, "5.2", true);
>> +DEFINE_SPAPR_MACHINE(5_2, "5.2", false);
>>   
>>   /*
>>    * pseries-5.1
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 28266a3a35..bde084e13d 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -789,14 +789,26 @@ bool css_migration_enabled(void)
>>       }                                                                         \
>>       type_init(ccw_machine_register_##suffix)
>>   
>> +static void ccw_machine_5_3_instance_options(MachineState *machine)
>> +{
>> +}
>> +
>> +static void ccw_machine_5_3_class_options(MachineClass *mc)
>> +{
>> +}
>> +DEFINE_CCW_MACHINE(5_3, "5.3", true);
>> +
>>   static void ccw_machine_5_2_instance_options(MachineState *machine)
>>   {
>> +    ccw_machine_5_3_instance_options(machine);
>>   }
>>   
>>   static void ccw_machine_5_2_class_options(MachineClass *mc)
>>   {
>> +    ccw_machine_5_3_class_options(mc);
>> +    compat_props_add(mc->compat_props, hw_compat_5_2, hw_compat_5_2_len);
>>   }
>> -DEFINE_CCW_MACHINE(5_2, "5.2", true);
>> +DEFINE_CCW_MACHINE(5_2, "5.2", false);
>>   
>>   static void ccw_machine_5_1_instance_options(MachineState *machine)
>>   {
>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>> index bf53e8a16e..f631c1799d 100644
>> --- a/include/hw/boards.h
>> +++ b/include/hw/boards.h
>> @@ -311,6 +311,9 @@ struct MachineState {
>>       } \
>>       type_init(machine_initfn##_register_types)
>>   
>> +extern GlobalProperty hw_compat_5_2[];
>> +extern const size_t hw_compat_5_2_len;
>> +
>>   extern GlobalProperty hw_compat_5_1[];
>>   extern const size_t hw_compat_5_1_len;
>>   
>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>> index 84639d0ebc..6f1531ed14 100644
>> --- a/include/hw/i386/pc.h
>> +++ b/include/hw/i386/pc.h
>> @@ -190,6 +190,9 @@ void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
>>   void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
>>                          const CPUArchIdList *apic_ids, GArray *entry);
>>   
>> +extern GlobalProperty pc_compat_5_2[];
>> +extern const size_t pc_compat_5_2_len;
>> +
>>   extern GlobalProperty pc_compat_5_1[];
>>   extern const size_t pc_compat_5_1_len;
>>   
>> -- 
>> 2.23.0
>>
>>
> 
> .
> 

