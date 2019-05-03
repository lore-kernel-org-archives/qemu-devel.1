Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1EDC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 09:20:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3C1D206C3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 09:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C1D206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37059 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMUMn-000204-8I
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 05:20:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMULw-0001ih-AM
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMULu-00053n-Ds
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:19:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMULs-00051Q-I7
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:19:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id y5so5874890wma.2
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 02:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=eBo++DNawupqhVpoFvCw1qXDpEYHoN6x82dzx+m3pug=;
	b=QvuFI9VSHw01k6u98qvQxfu9l5RnyEZMyUXBi8uubuNn0R3aqUS9Sfij81lMoqP1y/
	+SdL7bdf4lL89SVPI9vVzEytnNvUzE9KifTJtAyqBh1gSFXrjyMP77SfmkRIuJoK/O5H
	GoeSBGSZpa8Y/q/n2pCt+GpZwgKi6BGxgJ7VOG/L5PyjFcg4hrnusQa/7/UUep5f7cKR
	LJphF8TLTaoTFIX+FdRuf1G7ewPy6zNGrtQrnZoRyVhCt6iOKGrHwF0eSIaGpk4zWbxL
	SOE/LAAu2UDnTzIKkxAah+NPBNmzIH8nlmqNd7Xjhdgc0hZOmlHXvHXbERiu0jcMj22a
	WLNQ==
X-Gm-Message-State: APjAAAVMbqgOI9Oao4AusoXpN3N3Iu7gvf/DOMZw5roCIPAEWmySYK1h
	9wpGb1kSTLp6nrjkvHppQfmagg==
X-Google-Smtp-Source: APXvYqyoDoLn0fkY718duQue1m4i3xbSwO00sjFV2nnhexYNzzJ6R/xVhKTas3UYqrj48myiPWao3g==
X-Received: by 2002:a7b:cc91:: with SMTP id p17mr5503144wma.147.1556875170499; 
	Fri, 03 May 2019 02:19:30 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id u9sm1448144wmd.14.2019.05.03.02.19.29
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 02:19:29 -0700 (PDT)
To: Jiri Slaby <jslaby@suse.cz>, Li Qiang <liq3ea@163.com>, pbonzini@redhat.com
References: <20190422141156.15746-1-liq3ea@163.com>
	<20190422141156.15746-4-liq3ea@163.com>
	<0f466daa-2d94-b95e-d653-d44123829459@suse.cz>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <32e69c86-3c92-2855-c046-15ea00b82806@redhat.com>
Date: Fri, 3 May 2019 11:19:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0f466daa-2d94-b95e-d653-d44123829459@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v3 3/3] edu: uses uint64_t in dma operation
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
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503091928.Hc9KjPu9_0UOPcPr6WtK0HU5wJoiYaQ-iPBrbBHiemk@z>

On 5/3/19 11:12 AM, Jiri Slaby wrote:
> On 22. 04. 19, 16:11, Li Qiang wrote:
>> The dma related variable dma.dst/src/cnt is dma_addr_t, it is
>> uint64_t in x64 platform. Change these usage from uint32_to
>> uint64_t to avoid trancation in edu_dma_timer.

Here I suggested fix the typo with "to avoid address truncation".

>>
>> Signed-off-by: Li Qiang <liq3ea@163.com>
>> Reviewed-by: Philippe Mathieu-Daude <philmd@redhat.com>
>> ---
>>  hw/misc/edu.c | 15 ++++++++-------
>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
>> index 33de05141f..401ada74af 100644
>> --- a/hw/misc/edu.c
>> +++ b/hw/misc/edu.c
>> @@ -98,23 +98,24 @@ static void edu_lower_irq(EduState *edu, uint32_t val)
>>      }
>>  }
>>  
>> -static bool within(uint32_t addr, uint32_t start, uint32_t end)
>> +static bool within(uint64_t addr, uint64_t start, uint64_t end)
>>  {
>>      return start <= addr && addr < end;
>>  }
>>  
>> -static void edu_check_range(uint32_t addr, uint32_t size1, uint32_t start,
>> +static void edu_check_range(uint64_t addr, uint64_t size1, uint64_t start,
>>                  uint32_t size2)
> 
> So in this version you don't change size2's type, but you still change
> size1's one :)?

On my previous review I suggested Li to keep u32 since the MMIO region
is 1 MB wide:

https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03505.html

I agree to be coherent we should use one or another, but not a mix.

> 
> Other than that, looks good to me.
> 
>>  {
>> -    uint32_t end1 = addr + size1;
>> -    uint32_t end2 = start + size2;
>> +    uint64_t end1 = addr + size1;
>> +    uint64_t end2 = start + size2;
>>  
>>      if (within(addr, start, end2) &&
>>              end1 > addr && within(end1, start, end2)) {
>>          return;
>>      }
>>  
>> -    hw_error("EDU: DMA range 0x%.8x-0x%.8x out of bounds (0x%.8x-0x%.8x)!",
>> +    hw_error("EDU: DMA range 0x%016"PRIx64"-0x%016"PRIx64
>> +             " out of bounds (0x%016"PRIx64"-0x%016"PRIx64")!",
>>              addr, end1 - 1, start, end2 - 1);
>>  }
> 
> 
> 

