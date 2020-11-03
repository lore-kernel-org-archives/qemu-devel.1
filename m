Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E343EC00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 691172067C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691172067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZm2M-0008Gd-HU
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:27:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kZlsM-0000WI-9k; Mon, 02 Nov 2020 21:16:48 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:2124)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kZlsC-0004fk-5D; Mon, 02 Nov 2020 21:16:45 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CQD185FYkz71jM;
 Tue,  3 Nov 2020 10:16:28 +0800 (CST)
Received: from [10.174.186.67] (10.174.186.67) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 10:16:22 +0800
Subject: Re: [RFC PATCH v2 08/13] hw/acpi/aml-build: add processor hierarchy
 node structure
To: Andrew Jones <drjones@redhat.com>
References: <20201020131440.1090-1-fangying1@huawei.com>
 <20201020131440.1090-9-fangying1@huawei.com>
 <20201029172458.kgeab6rkjrb6wtyw@kamzik.brq.redhat.com>
From: Ying Fang <fangying1@huawei.com>
Message-ID: <cc8fc8d7-3b7e-fac5-0b1d-3a1aa5674642@huawei.com>
Date: Tue, 3 Nov 2020 10:16:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20201029172458.kgeab6rkjrb6wtyw@kamzik.brq.redhat.com>
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
 Henglong Fan <fanhenglong@huawei.com>, alistair.francis@wdc.com,
 qemu-arm@nongnu.org, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/30/2020 1:24 AM, Andrew Jones wrote:
> On Tue, Oct 20, 2020 at 09:14:35PM +0800, Ying Fang wrote:
>> Add the processor hierarchy node structures to build ACPI information
>> for CPU topology. Three helpers are introduced:
>>
>> (1) build_socket_hierarchy for socket description structure
>> (2) build_processor_hierarchy for processor description structure
>> (3) build_smt_hierarchy for thread (logic processor) description structure
> 
> I see now the reason to introduce three functions is because the last
> patch adds different private resources. You should point that plan out
> in this commit message.

Yes, the private resources are used to describe cache hierarchy
and it is variable among different topology level. I will point it
out in the commit message to avoid any confusion.

Thanks,
Ying

> 
> Thanks,
> drew
> 
>>
>> Signed-off-by: Ying Fang <fangying1@huawei.com>
>> Signed-off-by: Henglong Fan <fanhenglong@huawei.com>
>> ---
>>   hw/acpi/aml-build.c         | 37 +++++++++++++++++++++++++++++++++++++
>>   include/hw/acpi/aml-build.h |  7 +++++++
>>   2 files changed, 44 insertions(+)
>>
>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>> index 3792ba96ce..da3b41b514 100644
>> --- a/hw/acpi/aml-build.c
>> +++ b/hw/acpi/aml-build.c
>> @@ -1770,6 +1770,43 @@ void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms)
>>                    table_data->len - slit_start, 1, NULL, NULL);
>>   }
>>   
>> +/*
>> + * ACPI 6.3: 5.2.29.1 Processor hierarchy node structure (Type 0)
>> + */
>> +void build_socket_hierarchy(GArray *tbl, uint32_t parent, uint32_t id)
>> +{
>> +    build_append_byte(tbl, 0);          /* Type 0 - processor */
>> +    build_append_byte(tbl, 20);         /* Length, no private resources */
>> +    build_append_int_noprefix(tbl, 0, 2);  /* Reserved */
>> +    build_append_int_noprefix(tbl, 1, 4);  /* Flags: Physical package */
>> +    build_append_int_noprefix(tbl, parent, 4);  /* Parent */
>> +    build_append_int_noprefix(tbl, id, 4);     /* ACPI processor ID */
>> +    build_append_int_noprefix(tbl, 0, 4);  /* Number of private resources */
>> +}
>> +
>> +void build_processor_hierarchy(GArray *tbl, uint32_t flags,
>> +                               uint32_t parent, uint32_t id)
>> +{
>> +    build_append_byte(tbl, 0);          /* Type 0 - processor */
>> +    build_append_byte(tbl, 20);         /* Length, no private resources */
>> +    build_append_int_noprefix(tbl, 0, 2);      /* Reserved */
>> +    build_append_int_noprefix(tbl, flags, 4);  /* Flags */
>> +    build_append_int_noprefix(tbl, parent, 4); /* Parent */
>> +    build_append_int_noprefix(tbl, id, 4);     /* ACPI processor ID */
>> +    build_append_int_noprefix(tbl, 0, 4);  /* Number of private resources */
>> +}
>> +
>> +void build_smt_hierarchy(GArray *tbl, uint32_t parent, uint32_t id)
>> +{
>> +    build_append_byte(tbl, 0);            /* Type 0 - processor */
>> +    build_append_byte(tbl, 20);           /* Length, add private resources */
>> +    build_append_int_noprefix(tbl, 0, 2); /* Reserved */
>> +    build_append_int_noprefix(tbl, 0x0e, 4);    /* Processor is a thread */
>> +    build_append_int_noprefix(tbl, parent , 4); /* parent */
>> +    build_append_int_noprefix(tbl, id, 4);      /* ACPI processor ID */
>> +    build_append_int_noprefix(tbl, 0, 4);       /* Num of private resources */
>> +}
>> +
>>   /* build rev1/rev3/rev5.1 FADT */
>>   void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
>>                   const char *oem_id, const char *oem_table_id)
>> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
>> index fe0055fffb..56474835a7 100644
>> --- a/include/hw/acpi/aml-build.h
>> +++ b/include/hw/acpi/aml-build.h
>> @@ -437,6 +437,13 @@ void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
>>   
>>   void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms);
>>   
>> +void build_socket_hierarchy(GArray *tbl, uint32_t parent, uint32_t id);
>> +
>> +void build_processor_hierarchy(GArray *tbl, uint32_t flags,
>> +                               uint32_t parent, uint32_t id);
>> +
>> +void build_smt_hierarchy(GArray *tbl, uint32_t parent, uint32_t id);
>> +
>>   void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
>>                   const char *oem_id, const char *oem_table_id);
>>   
>> -- 
>> 2.23.0
>>
>>
> 
> .
> 

