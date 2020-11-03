Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E447C00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:35:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C09E82067C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09E82067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZmAo-0005UO-TZ
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:35:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kZm9W-0004Or-Jw; Mon, 02 Nov 2020 21:34:30 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2320)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kZm9S-0006Z3-QY; Mon, 02 Nov 2020 21:34:30 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CQDPf3c8lzkdTc;
 Tue,  3 Nov 2020 10:34:14 +0800 (CST)
Received: from [10.174.186.67] (10.174.186.67) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 10:34:11 +0800
Subject: Re: [RFC PATCH v2 09/13] hw/arm/virt-acpi-build: add PPTT table
To: Andrew Jones <drjones@redhat.com>
References: <20201020131440.1090-1-fangying1@huawei.com>
 <20201020131440.1090-10-fangying1@huawei.com>
 <20201029165614.mbwv26bnx6ntughx@kamzik.brq.redhat.com>
From: Ying Fang <fangying1@huawei.com>
Message-ID: <a15bf72b-ad48-aa2a-d782-304159f7b11b@huawei.com>
Date: Tue, 3 Nov 2020 10:34:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20201029165614.mbwv26bnx6ntughx@kamzik.brq.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.67]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=fangying1@huawei.com;
 helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 20:52:58
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
 qemu-arm@nongnu.org, alistair.francis@wdc.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/30/2020 12:56 AM, Andrew Jones wrote:
> On Tue, Oct 20, 2020 at 09:14:36PM +0800, Ying Fang wrote:
>> Add the Processor Properties Topology Table (PPTT) to present CPU topology
>> information to the guest.
>>
>> Signed-off-by: Andrew Jones <drjones@redhat.com>
> 
> I don't know why I have an s-o-b here. I guess it's because this code
> looks nearly identical to what I wrote, except for using the new and,
> IMO, unnecessary build_socket_hierarchy and build_smt_hierarchy functions.
> 
> IMHO, you should drop the last patch and just take
> 
> https://github.com/rhdrjones/qemu/commit/439b38d67ca1f2cbfa5b9892a822b651ebd05c11
> 
> as it is, unless it needs to be fixed somehow
> 
> Thanks,
> drew

This patch is based on your branch however it is slightly modified.
As described in:

[RFC,v2,08/13] hw/acpi/aml-build: add processor hierarchy node structure

The wrapper function build_socket_hierarchy and build_smt_hierarchy are
introduced to make later patch much more readable and make preparations 
for cache hierarchy.

Hope it won't make you confused. I will drop your branch patch and
give details in the commit message in the next post.

Thanks,
Ying
> 
>> Signed-off-by: Ying Fang <fangying1@huawei.com>
>> ---
>>   hw/arm/virt-acpi-build.c | 42 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index fae5a26741..e1f3ea50ad 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -429,6 +429,42 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>                    "SRAT", table_data->len - srat_start, 3, NULL, NULL);
>>   }
>>   
>> +static void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms)
>> +{
>> +    int pptt_start = table_data->len;
>> +    int uid = 0, cpus = 0, socket;
>> +    unsigned int smp_cores = ms->smp.cores;
>> +    unsigned int smp_threads = ms->smp.threads;
>> +
>> +    acpi_data_push(table_data, sizeof(AcpiTableHeader));
>> +
>> +    for (socket = 0; cpus < ms->possible_cpus->len; socket++) {
>> +        uint32_t socket_offset = table_data->len - pptt_start;
>> +        int core;
>> +
>> +        build_socket_hierarchy(table_data, 0, socket);
>> +
>> +        for (core = 0; core < smp_cores; core++) {
>> +            uint32_t core_offset = table_data->len - pptt_start;
>> +            int thread;
>> +
>> +            if (smp_threads <= 1) {
>> +                build_processor_hierarchy(table_data, 2, socket_offset, uid++);
>> +             } else {
>> +                build_processor_hierarchy(table_data, 0, socket_offset, core);
>> +                for (thread = 0; thread < smp_threads; thread++) {
>> +                    build_smt_hierarchy(table_data, core_offset, uid++);
>> +                }
>> +             }
>> +        }
>> +        cpus += smp_cores * smp_threads;
>> +    }
>> +
>> +    build_header(linker, table_data,
>> +                 (void *)(table_data->data + pptt_start), "PPTT",
>> +                 table_data->len - pptt_start, 2, NULL, NULL);
>> +}
>> +
>>   /* GTDT */
>>   static void
>>   build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>> @@ -669,6 +705,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>>       unsigned dsdt, xsdt;
>>       GArray *tables_blob = tables->table_data;
>>       MachineState *ms = MACHINE(vms);
>> +    bool cpu_topology_enabled = !vmc->ignore_cpu_topology;
>>   
>>       table_offsets = g_array_new(false, true /* clear */,
>>                                           sizeof(uint32_t));
>> @@ -688,6 +725,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>>       acpi_add_table(table_offsets, tables_blob);
>>       build_madt(tables_blob, tables->linker, vms);
>>   
>> +    if (cpu_topology_enabled) {
>> +        acpi_add_table(table_offsets, tables_blob);
>> +        build_pptt(tables_blob, tables->linker, ms);
>> +    }
>> +
>>       acpi_add_table(table_offsets, tables_blob);
>>       build_gtdt(tables_blob, tables->linker, vms);
>>   
>> -- 
>> 2.23.0
>>
>>
> 
> .
> 

