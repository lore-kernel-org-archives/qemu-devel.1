Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE9CC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:23:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB9DE22210
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9DE22210
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIuoa-0005uB-L4
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 10:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kIuVP-0004Fr-1L; Thu, 17 Sep 2020 10:03:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33250 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kIuVL-0000pw-28; Thu, 17 Sep 2020 10:03:22 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id A5C1319EB074A8B0AE10;
 Thu, 17 Sep 2020 22:03:11 +0800 (CST)
Received: from [10.174.185.104] (10.174.185.104) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 22:03:02 +0800
Subject: Re: [RFC PATCH 07/12] hw/acpi/aml-build: add processor hierarchy node
 structure
To: Andrew Jones <drjones@redhat.com>
References: <20200917032033.2020-1-fangying1@huawei.com>
 <20200917032033.2020-8-fangying1@huawei.com>
 <20200917082731.yrkedm3y7j75lbaa@kamzik.brq.redhat.com>
From: Ying Fang <fangying1@huawei.com>
Message-ID: <ef98aac5-869c-3491-4c42-660c827cac0b@huawei.com>
Date: Thu, 17 Sep 2020 22:03:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200917082731.yrkedm3y7j75lbaa@kamzik.brq.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.104]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=fangying1@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 08:23:09
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, Henglong Fan <fanhenglong@huawei.com>,
 zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org, alex.chen@huawei.com,
 shannon.zhaosl@gmail.com, qemu-arm@nongnu.org, alistair.francis@wdc.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/17/2020 4:27 PM, Andrew Jones wrote:
> On Thu, Sep 17, 2020 at 11:20:28AM +0800, Ying Fang wrote:
>> Add the processor hierarchy node structures to build ACPI information
>> for CPU topology. Three helpers are introduced:
>>
>> (1) build_socket_hierarchy for socket description structure
>> (2) build_processor_hierarchy for processor description structure
>> (3) build_smt_hierarchy for thread (logic processor) description structure
>>
>> Signed-off-by: Ying Fang <fangying1@huawei.com>
>> Signed-off-by: Henglong Fan <fanhenglong@huawei.com>
>> ---
>>   hw/acpi/aml-build.c         | 37 +++++++++++++++++++++++++++++++++++++
>>   include/hw/acpi/aml-build.h |  7 +++++++
>>   2 files changed, 44 insertions(+)
>>
>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>> index f6fbc9b95d..13eb6e1345 100644
>> --- a/hw/acpi/aml-build.c
>> +++ b/hw/acpi/aml-build.c
>> @@ -1754,6 +1754,43 @@ void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms)
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
> 
> I see you took this from
> https://patchwork.ozlabs.org/project/qemu-devel/patch/20180704124923.32483-6-drjones@redhat.com/
> (even though you neglected to mention that)
> 
> I've tweaked my implementation of it slightly per Igor's comments for the
> refresh. See build_processor_hierarchy_node() in
> https://github.com/rhdrjones/qemu/commit/439b38d67ca1f2cbfa5b9892a822b651ebd05c11
Ok, I will sync with your work and test it.
> 
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
>> index d27da03d64..ff4c6a38f3 100644
>> --- a/include/hw/acpi/aml-build.h
>> +++ b/include/hw/acpi/aml-build.h
>> @@ -435,6 +435,13 @@ void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
>>   
>>   void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms);
>>   
>> +void build_socket_hierarchy(GArray *tbl, uint32_t parent, uint32_t id);
>> +
>> +void build_processor_hierarchy(GArray *tbl, uint32_t flags,
>> +                               uint32_t parent, uint32_t id);
>> +
>> +void build_smt_hierarchy(GArray *tbl, uint32_t parent, uint32_t id);
> 
> Why add build_socket_hierarchy() and build_smt_hierarchy() ?

To distinguish between socket, core and thread topology level,
build_socket_hierarchy and build_smt_hierarchy are introduced.
They will make the code logical in built_pptt much more much 
straightforward I think.

> 
>> +
>>   void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
>>                   const char *oem_id, const char *oem_table_id);
>>   
>> -- 
>> 2.23.0
>>
> 
> Thanks,
> drew
> 
> .
> 

