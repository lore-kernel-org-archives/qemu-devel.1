Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320F2C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 12:39:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4769212F5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 12:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4769212F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50790 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfOFS-0002Qb-Gv
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 08:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53345)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <gengdongjiu@huawei.com>) id 1hfOEJ-0001d1-E4
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 08:37:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gengdongjiu@huawei.com>) id 1hfOEI-0000W5-8O
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 08:37:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2176 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
 id 1hfOEF-0000P5-9Y; Mon, 24 Jun 2019 08:37:47 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 07410A2BE2C0F14BCE0C;
 Mon, 24 Jun 2019 20:37:40 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 24 Jun 2019
 20:37:29 +0800
To: Igor Mammedov <imammedo@redhat.com>
References: <1557832703-42620-1-git-send-email-gengdongjiu@huawei.com>
 <1557832703-42620-5-git-send-email-gengdongjiu@huawei.com>
 <20190620142814.7caf9c3c@redhat.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <b1ef7ea4-acc9-1f97-b320-37f4600cd9f4@huawei.com>
Date: Mon, 24 Jun 2019 20:37:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190620142814.7caf9c3c@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.190
Subject: Re: [Qemu-devel] [PATCH v17 04/10] acpi: add
 build_append_ghes_generic_data() helper for Generic Error Data Entry
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



On 2019/6/20 20:28, Igor Mammedov wrote:
> On Tue, 14 May 2019 04:18:17 -0700
> Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> 
>> It will help to add Generic Error Data Entry to ACPI tables
>> without using packed C structures and avoid endianness
>> issues as API doesn't need explicit conversion.
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> ---
>>  hw/acpi/aml-build.c         | 32 ++++++++++++++++++++++++++++++++
>>  include/hw/acpi/aml-build.h |  6 ++++++
>>  2 files changed, 38 insertions(+)
>>
>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>> index fb53f21..102a288 100644
>> --- a/hw/acpi/aml-build.c
>> +++ b/hw/acpi/aml-build.c
>> @@ -296,6 +296,38 @@ void build_append_ghes_notify(GArray *table, const uint8_t type,
>>          build_append_int_noprefix(table, error_threshold_window, 4);
>>  }
>>  
>> +/* Generic Error Data Entry
>> + * ACPI 4.0: 17.3.2.6.1 Generic Error Data
>> + */
>> +void build_append_ghes_generic_data(GArray *table, const char *section_type,
> s/build_append_ghes_generic_data/build_append_ghes_generic_error_data/
> 
>> +                                    uint32_t error_severity, uint16_t revision,
>> +                                    uint8_t validation_bits, uint8_t flags,
>> +                                    uint32_t error_data_length, uint8_t *fru_id,
>> +                                    uint8_t *fru_text, uint64_t time_stamp)
> checkpatch probably will complain due to too long lines
> you can use:
> void build_append_ghe...
>          uint32_t error_severity, uint16_t revision,
>          ...
> 
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < 16; i++) {
>> +        build_append_int_noprefix(table, section_type[i], 1);
>                                             ^^^
> use QemuUUID instead, see vmgenid_build_acpi
ok.

> 
>> +    }
>> +
>> +    build_append_int_noprefix(table, error_severity, 4);
>> +    build_append_int_noprefix(table, revision, 2);
>> +    build_append_int_noprefix(table, validation_bits, 1);
>> +    build_append_int_noprefix(table, flags, 1);
>> +    build_append_int_noprefix(table, error_data_length, 4);
>> +
>> +    for (i = 0; i < 16; i++) {
>> +        build_append_int_noprefix(table, fru_id[i], 1);
> same as section_type
ok.

> 
>> +    }
>> +
>> +    for (i = 0; i < 20; i++) {
>> +        build_append_int_noprefix(table, fru_text[i], 1);
>> +    }
> instead of loop use g_array_insert_vals()
ok

> 
>> +
>> +    build_append_int_noprefix(table, time_stamp, 8);
> that's not part of 'Table 17-13'
> where does it come from?


It comes from "ACPI 6.1: Table 18-343 Generic Error Data Entry", I will update the comments, thanks for the pointing out.

> 
>> +}
>> +
>>  /*
>>   * Build NAME(XXXX, 0x00000000) where 0x00000000 is encoded as a dword,
>>   * and return the offset to 0x00000000 for runtime patching.
>> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
>> index 90c8ef8..a71db2f 100644
>> --- a/include/hw/acpi/aml-build.h
>> +++ b/include/hw/acpi/aml-build.h
>> @@ -419,6 +419,12 @@ void build_append_ghes_notify(GArray *table, const uint8_t type,
>>                                uint32_t error_threshold_value,
>>                                uint32_t error_threshold_window);
>>  
>> +void build_append_ghes_generic_data(GArray *table, const char *section_type,
>> +                                    uint32_t error_severity, uint16_t revision,
>> +                                    uint8_t validation_bits, uint8_t flags,
>> +                                    uint32_t error_data_length, uint8_t *fru_id,
>> +                                    uint8_t *fru_text, uint64_t time_stamp);
>> +
>>  void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
>>                         uint64_t len, int node, MemoryAffinityFlags flags);
>>  
> 
> .
> 


