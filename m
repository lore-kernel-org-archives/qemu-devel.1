Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F07C48BE5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 14:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5BD7208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 14:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5BD7208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35752 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heKsU-0000Kf-RR
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 10:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46049)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1heKoA-0003PE-Lc
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1heKo9-00067s-FK
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:46:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40075)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1heKo8-00064w-9q
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 10:46:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so6876832wmj.5
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 07:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wqCpkprBc2J/oBbcTLMofDoxn5v207tp4CUDSZCZr2o=;
 b=UQVXKC1QSYa4Cq1cfcPXnRPLtv5MgaRIF7BxenirkShCIv7x+gmIFWSFmRRfubcaKl
 dttixQ87lV5KeU8tPV8oL4i7Y+6QwGy7xsl64Ba7kpVv4wRelD0D66la1N+akZT0GL2P
 5hrsQcmcbQRPMMhiSbVLtFqR7U8hAdscNTBeI82s6BFUJhXuTURnz3BrGQvsPjKrvox0
 aZ3e7XXHLJhI4nwi28mcYeXII3r6upySPoYDTOgSnCejTH+eo5LIepi8Paoj8D+Nme5F
 2rI0XpHzLJ1Jm3FofcsTpyEGH2vGMAo0mEvNB5hVY8ZHKFsKRoEcgBxUOLkkYKb1HgvR
 cB4g==
X-Gm-Message-State: APjAAAVKn8wVwwYe1C2nm2nJmUd3WZ9jNpVGfc1aVTWzqVD2YPdDEaKw
 WZN1F0Q7ta88XpjzmfAzHgoMiA==
X-Google-Smtp-Source: APXvYqwbs/aw62Zx0GKxq7ISurV0aIMZU9BnOo5SAgXPhv3Yzak1fFtZhMmZOA250vMgncTiuITw4w==
X-Received: by 2002:a1c:dc07:: with SMTP id t7mr4633705wmg.164.1561128384767; 
 Fri, 21 Jun 2019 07:46:24 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id 72sm4358583wrk.22.2019.06.21.07.46.23
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 07:46:24 -0700 (PDT)
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20190613143446.23937-1-philmd@redhat.com>
 <20190613143446.23937-3-philmd@redhat.com>
 <20190620112805-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d7215a09-ecc2-9895-a00e-fd12091b3893@redhat.com>
Date: Fri, 21 Jun 2019 16:46:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190620112805-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v2 02/20] hw/i386/pc: Use size_t type to
 hold/return a size of array
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
 Li Qiang <liq3ea@gmail.com>, qemu-devel@nongnu.org,
 Rob Bradford <robert.bradford@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Samuel Ortiz <sameo@linux.intel.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/20/19 5:28 PM, Michael S. Tsirkin wrote:
> On Thu, Jun 13, 2019 at 04:34:28PM +0200, Philippe Mathieu-Daudé wrote:
>> Reviewed-by: Li Qiang <liq3ea@gmail.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Motivation? do you expect more than 2^31 entries?

Building with -Wsign-compare:

hw/i386/pc.c:973:36: warning: comparison of integers of different signs:
'unsigned int' and 'int' [-Wsign-compare]
    for (i = 0, array_count = 0; i < e820_get_num_entries(); i++) {
                                 ~ ^ ~~~~~~~~~~~~~~~~~~~~~~

>> ---
>>  hw/i386/pc.c         | 4 ++--
>>  include/hw/i386/pc.h | 2 +-
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index bb3c74f4ca..ff0f6bbbb3 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -105,7 +105,7 @@ struct e820_table {
>>  
>>  static struct e820_table e820_reserve;
>>  static struct e820_entry *e820_table;
>> -static unsigned e820_entries;
>> +static size_t e820_entries;
>>  struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
>>  
>>  /* Physical Address of PVH entry point read from kernel ELF NOTE */
>> @@ -901,7 +901,7 @@ int e820_add_entry(uint64_t address, uint64_t length, uint32_t type)
>>      return e820_entries;
>>  }
>>  
>> -int e820_get_num_entries(void)
>> +size_t e820_get_num_entries(void)
>>  {
>>      return e820_entries;
>>  }
>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>> index 3b3a0d6e59..fc29893624 100644
>> --- a/include/hw/i386/pc.h
>> +++ b/include/hw/i386/pc.h
>> @@ -290,7 +290,7 @@ void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
>>  #define E820_UNUSABLE   5
>>  
>>  int e820_add_entry(uint64_t, uint64_t, uint32_t);
>> -int e820_get_num_entries(void);
>> +size_t e820_get_num_entries(void);
>>  bool e820_get_entry(unsigned int, uint32_t, uint64_t *, uint64_t *);
>>  
>>  extern GlobalProperty pc_compat_4_0_1[];
>> -- 
>> 2.20.1

