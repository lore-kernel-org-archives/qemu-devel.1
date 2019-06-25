Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E70CC48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 12:14:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75EC9204EC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 12:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75EC9204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59593 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfkLC-0005j0-I4
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 08:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35124)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <gengdongjiu@huawei.com>) id 1hfkIc-0004OX-A9
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 08:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gengdongjiu@huawei.com>) id 1hfkIX-0000rT-4T
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 08:11:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2246 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
 id 1hfkIM-0000dH-1w; Tue, 25 Jun 2019 08:11:30 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id AC84597342FD98737BF6;
 Tue, 25 Jun 2019 20:11:20 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 25 Jun 2019
 20:11:13 +0800
To: Igor Mammedov <imammedo@redhat.com>
References: <1557832703-42620-1-git-send-email-gengdongjiu@huawei.com>
 <1557832703-42620-6-git-send-email-gengdongjiu@huawei.com>
 <20190620144257.7400b0a7@redhat.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <93dcd75e-77e4-8813-beef-7939cdb75413@huawei.com>
Date: Tue, 25 Jun 2019 20:11:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190620144257.7400b0a7@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.191
Subject: Re: [Qemu-devel] [PATCH v17 05/10] acpi: add
 build_append_ghes_generic_status() helper for Generic Error Status Block
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, kvm@vger.kernel.org,
 mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 linuxarm@huawei.com, shannon.zhaosl@gmail.com, zhengxiang9@huawei.com,
 qemu-arm@nongnu.org, james.morse@arm.com, xuwei5@huawei.com,
 jonathan.cameron@huawei.com, pbonzini@redhat.com, lersek@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/6/20 20:42, Igor Mammedov wrote:
> On Tue, 14 May 2019 04:18:18 -0700
> Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> 
>> It will help to add Generic Error Status Block to ACPI tables
>> without using packed C structures and avoid endianness
>> issues as API doesn't need explicit conversion.
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> ---
>>  hw/acpi/aml-build.c         | 14 ++++++++++++++
>>  include/hw/acpi/aml-build.h |  6 ++++++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>> index 102a288..ce90970 100644
>> --- a/hw/acpi/aml-build.c
>> +++ b/hw/acpi/aml-build.c
>> @@ -296,6 +296,20 @@ void build_append_ghes_notify(GArray *table, const uint8_t type,
>>          build_append_int_noprefix(table, error_threshold_window, 4);
>>  }
>>  
>> +/* Generic Error Status Block
>> + * ACPI 4.0: 17.3.2.6.1 Generic Error Data
>> + */
>> +void build_append_ghes_generic_status(GArray *table, uint32_t block_status,
> maybe ..._generic_error_status???
good point, the build_append_ghes_generic_error_status() is better than build_append_ghes_generic_status()

> 
>> +                      uint32_t raw_data_offset, uint32_t raw_data_length,
>> +                      uint32_t data_length, uint32_t error_severity)
> see CODING_STYLE, 1.1 Multiline Indent
> 
>> +{
> when describing filds from spec try to add 'verbatim' copy of the name from spec
> so it would be esy to grep for it. Like:
>        /* Block Status */
>> +    build_append_int_noprefix(table, block_status, 4);
>        /* Raw Data Offset */
> 
> note applies all other places where you compose ACPI tables
ok

> 
>> +    build_append_int_noprefix(table, raw_data_offset, 4);
>> +    build_append_int_noprefix(table, raw_data_length, 4);
>> +    build_append_int_noprefix(table, data_length, 4);
>> +    build_append_int_noprefix(table, error_severity, 4);
>> +}
>> +
>>  /* Generic Error Data Entry
>>   * ACPI 4.0: 17.3.2.6.1 Generic Error Data
>>   */
>> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
>> index a71db2f..1ec7e1b 100644
>> --- a/include/hw/acpi/aml-build.h
>> +++ b/include/hw/acpi/aml-build.h
>> @@ -425,6 +425,12 @@ void build_append_ghes_generic_data(GArray *table, const char *section_type,
>>                                      uint32_t error_data_length, uint8_t *fru_id,
>>                                      uint8_t *fru_text, uint64_t time_stamp);
>>  
>> +void
>> +build_append_ghes_generic_status(GArray *table, uint32_t block_status,
>> +                                 uint32_t raw_data_offset,
>> +                                 uint32_t raw_data_length,
>> +                                 uint32_t data_length, uint32_t error_severity);
> this and previous patch, it might be better to to move declaration
> to its own header, for example to include/hw/acpi/acpi_ghes.h
> that you are adding later in the series.
> And maybe move helpers to hw/acpi/acpi_ghes.c
> They are not really independent ACPI primitives that are shared
> with other tables, aren't they?
Some ACPI primitives are shared with other table, such as Notification Structure.
we have 10 types of error sources, some error source will share the  Notification Structure primitives.
Now I only implement Generic Hardware Error Source version 2 (GHESv2 - Type 10)

> .
>> +
>>  void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
>>                         uint64_t len, int node, MemoryAffinityFlags flags);
>>  
> 
> .
> 


