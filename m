Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF29C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 14:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5DCB2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 14:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5DCB2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35852 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heKz1-0006hp-Jd
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 10:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47174)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1heKqE-0005h9-VG
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1heKqD-00084J-PB
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:48:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51594)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1heKqD-00083Z-Ix
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:48:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so6594324wma.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 07:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mni6q2gM6QRV8G+snx7TIr26ZzoLjFy5MNHHDUgwcig=;
 b=NnWGGrYIiHRhll+3pU7RPDivmYj7NQDhMubzHIQAdLPdOGEmwWo2L9D3EXwaSMdfI0
 7OoXjPlHKXkIWmdxBApBk0OSCIeNNBJxzCoYO1otIVlnw8Kofa7M9D8qSiz3psrTa6vn
 o9vCR+emNSW+F7fh70qv/gfkJGTAgGw95nDTz7Zh4US8tIBIjIPc1ZG9Z3COOOi6vzdz
 /bCHwseL83FHlDPUhBWaCvzA+Lhr6HIWv9n4uwkq0K1MOsv0AiSJz5NICTcFj9gpUgTK
 u+3xZ1CKYusTb/QasoqpckpJkQW5jJBGUo0jdgemQV6WOuZAO9mgx+D/kHr/E0gkATuz
 FlJA==
X-Gm-Message-State: APjAAAVW7ODkipXbsKE4FwWCsfcb2WqMih8LWINAgC4ycm6I9kW7FdjV
 QRk2eMuvw6HnaZNcbjebwkYLWA==
X-Google-Smtp-Source: APXvYqyf45eQwg+BbW/SjWqLGsYW7jTQ+yztokND0TEQ22Lj8Z9vJAXQxaiKLioE0/AGJo+QWZF3EA==
X-Received: by 2002:a1c:808b:: with SMTP id b133mr4139936wmd.160.1561128516167; 
 Fri, 21 Jun 2019 07:48:36 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id y19sm4074167wmc.21.2019.06.21.07.48.35
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 07:48:35 -0700 (PDT)
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20190613143446.23937-1-philmd@redhat.com>
 <20190613143446.23937-5-philmd@redhat.com>
 <20190620112913-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d54c1df4-5ebb-ad3f-449c-5037ef560270@redhat.com>
Date: Fri, 21 Jun 2019 16:48:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190620112913-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v2 04/20] hw/i386/pc: Add the E820Type enum
 type
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
Cc: Yang Zhong <yang.zhong@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Rob Bradford <robert.bradford@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/20/19 5:31 PM, Michael S. Tsirkin wrote:
> On Thu, Jun 13, 2019 at 04:34:30PM +0200, Philippe Mathieu-Daudé wrote:
>> This ensure we won't use an incorrect value.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> It doesn't actually ensure anything: compiler does not check IIUC.
> 
> And OTOH it's stored in type field in struct e820_entry.

I totally missed that... Thanks!

>> ---
>> v2: Do not cast the enum (Li)
>> ---
>>  hw/i386/pc.c         |  4 ++--
>>  include/hw/i386/pc.h | 16 ++++++++++------
>>  2 files changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 5a7cffbb1a..86ba554439 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -872,7 +872,7 @@ static void handle_a20_line_change(void *opaque, int irq, int level)
>>      x86_cpu_set_a20(cpu, level);
>>  }
>>  
>> -ssize_t e820_add_entry(uint64_t address, uint64_t length, uint32_t type)
>> +ssize_t e820_add_entry(uint64_t address, uint64_t length, E820Type type)
>>  {
>>      unsigned int index = le32_to_cpu(e820_reserve.count);
>>      struct e820_entry *entry;
>> @@ -906,7 +906,7 @@ size_t e820_get_num_entries(void)
>>      return e820_entries;
>>  }
>>  
>> -bool e820_get_entry(unsigned int idx, uint32_t type,
>> +bool e820_get_entry(unsigned int idx, E820Type type,
>>                      uint64_t *address, uint64_t *length)
>>  {
>>      if (idx < e820_entries && e820_table[idx].type == cpu_to_le32(type)) {
>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>> index c56116e6f6..7c07185dd5 100644
>> --- a/include/hw/i386/pc.h
>> +++ b/include/hw/i386/pc.h
>> @@ -282,12 +282,16 @@ void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
>>  void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
>>                         const CPUArchIdList *apic_ids, GArray *entry);
>>  
>> -/* e820 types */
>> -#define E820_RAM        1
>> -#define E820_RESERVED   2
>> -#define E820_ACPI       3
>> -#define E820_NVS        4
>> -#define E820_UNUSABLE   5
>> +/**
>> + * E820Type: Type of the e820 address range.
>> + */
>> +typedef enum {
>> +    E820_RAM        = 1,
>> +    E820_RESERVED   = 2,
>> +    E820_ACPI       = 3,
>> +    E820_NVS        = 4,
>> +    E820_UNUSABLE   = 5
>> +} E820Type;
>>  
>>  ssize_t e820_add_entry(uint64_t, uint64_t, uint32_t);
>>  size_t e820_get_num_entries(void);
>> -- 
>> 2.20.1

