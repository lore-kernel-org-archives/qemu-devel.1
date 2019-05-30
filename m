Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66A9C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 15:00:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EEDF25C08
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 15:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EEDF25C08
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55260 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWMXP-0004uj-IV
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 11:00:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1hWMWb-0004PH-Of
	for qemu-devel@nongnu.org; Thu, 30 May 2019 10:59:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1hWMWa-0002UJ-Ly
	for qemu-devel@nongnu.org; Thu, 30 May 2019 10:59:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36264 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
	id 1hWMWW-00025F-1D; Thu, 30 May 2019 10:59:22 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id 3418FA158468C0152440;
	Thu, 30 May 2019 22:58:33 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS405-HUB.china.huawei.com
	(10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Thu, 30 May 2019
	22:58:26 +0800
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <1557832703-42620-1-git-send-email-gengdongjiu@huawei.com>
	<1557832703-42620-3-git-send-email-gengdongjiu@huawei.com>
	<20190528233859-mutt-send-email-mst@kernel.org>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <a0cad169-0dae-8525-f36f-2b88e418791e@huawei.com>
Date: Thu, 30 May 2019 22:58:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
	Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190528233859-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.35
Subject: Re: [Qemu-devel] [PATCH v17 02/10] ACPI: add some GHES structures
 and macros definition
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, kvm@vger.kernel.org,
	mtosatti@redhat.com, qemu-devel@nongnu.org, linuxarm@huawei.com,
	shannon.zhaosl@gmail.com, zhengxiang9@huawei.com,
	qemu-arm@nongnu.org, james.morse@arm.com,
	jonathan.cameron@huawei.com, imammedo@redhat.com,
	pbonzini@redhat.com, xuwei5@huawei.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/5/29 11:40, Michael S. Tsirkin wrote:
> On Tue, May 14, 2019 at 04:18:15AM -0700, Dongjiu Geng wrote:
>> Add Generic Error Status Block structures and some macros
>> definitions, which is referred to the ACPI 4.0 or ACPI 6.2. The
>> HEST table generation and CPER record will use them.
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> 
> Are these all still used? I'd rather you moved stuff to
> where it's used.
Ok, I will move them, thanks

> 
> 
> 
>> ---
>>  include/hw/acpi/acpi-defs.h | 52 +++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 52 insertions(+)
>>
>> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
>> index f9aa4bd..d1996fb 100644
>> --- a/include/hw/acpi/acpi-defs.h
>> +++ b/include/hw/acpi/acpi-defs.h
>> @@ -224,6 +224,25 @@ typedef struct AcpiMultipleApicTable AcpiMultipleApicTable;
>>  #define ACPI_APIC_RESERVED              16   /* 16 and greater are reserved */
>>  
>>  /*
>> + * Values for Hardware Error Notification Type field
>> + */
>> +enum AcpiHestNotifyType {
>> +    ACPI_HEST_NOTIFY_POLLED = 0,
>> +    ACPI_HEST_NOTIFY_EXTERNAL = 1,
>> +    ACPI_HEST_NOTIFY_LOCAL = 2,
>> +    ACPI_HEST_NOTIFY_SCI = 3,
>> +    ACPI_HEST_NOTIFY_NMI = 4,
>> +    ACPI_HEST_NOTIFY_CMCI = 5,  /* ACPI 5.0: 18.3.2.7, Table 18-290 */
>> +    ACPI_HEST_NOTIFY_MCE = 6,   /* ACPI 5.0: 18.3.2.7, Table 18-290 */
>> +    ACPI_HEST_NOTIFY_GPIO = 7,  /* ACPI 6.0: 18.3.2.7, Table 18-332 */
>> +    ACPI_HEST_NOTIFY_SEA = 8,   /* ACPI 6.1: 18.3.2.9, Table 18-345 */
>> +    ACPI_HEST_NOTIFY_SEI = 9,   /* ACPI 6.1: 18.3.2.9, Table 18-345 */
>> +    ACPI_HEST_NOTIFY_GSIV = 10, /* ACPI 6.1: 18.3.2.9, Table 18-345 */
>> +    ACPI_HEST_NOTIFY_SDEI = 11, /* ACPI 6.2: 18.3.2.9, Table 18-383 */
>> +    ACPI_HEST_NOTIFY_RESERVED = 12 /* 12 and greater are reserved */
>> +};
>> +
> 
> If there's a single user, the best thing to do
> is just to open-code with a comment that matches
> spec names. It's hard to find stuff like ACPI_HEST_NOTIFY_GSIV
> in a spec.
ok, I will do it, thanks

> 
>> +/*
>>   * MADT sub-structures (Follow MULTIPLE_APIC_DESCRIPTION_TABLE)
>>   */
>>  #define ACPI_SUB_HEADER_DEF   /* Common ACPI sub-structure header */\
>> @@ -400,6 +419,39 @@ struct AcpiSystemResourceAffinityTable {
>>  } QEMU_PACKED;
>>  typedef struct AcpiSystemResourceAffinityTable AcpiSystemResourceAffinityTable;
>>  
>> +/*
>> + * Generic Error Status Block
>> + */
>> +struct AcpiGenericErrorStatus {
>> +    /* It is a bitmask composed of ACPI_GEBS_xxx macros */
>> +    uint32_t block_status;
>> +    uint32_t raw_data_offset;
>> +    uint32_t raw_data_length;
>> +    uint32_t data_length;
>> +    uint32_t error_severity;
>> +} QEMU_PACKED;
>> +typedef struct AcpiGenericErrorStatus AcpiGenericErrorStatus;
>> +
>> +/*
>> + * Masks for block_status flags above
>> + */
>> +#define ACPI_GEBS_UNCORRECTABLE         1
>> +
>> +/*
>> + * Values for error_severity field above
>> + */
>> +enum AcpiGenericErrorSeverity {
>> +    ACPI_CPER_SEV_RECOVERABLE,
>> +    ACPI_CPER_SEV_FATAL,
>> +    ACPI_CPER_SEV_CORRECTED,
>> +    ACPI_CPER_SEV_NONE,
>> +};
>> +
>> +/*
>> + * Generic Hardware Error Source version 2
>> + */
>> +#define ACPI_HEST_SOURCE_GENERIC_ERROR_V2    10
>> +
>>  #define ACPI_SRAT_PROCESSOR_APIC     0
>>  #define ACPI_SRAT_MEMORY             1
>>  #define ACPI_SRAT_PROCESSOR_x2APIC   2
>> -- 
>> 1.8.3.1
> .
> 


