Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E207C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 21:52:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60EC421842
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 21:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EC421842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr88q-0000cb-LZ
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 17:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53090)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hr88Y-00086t-QN
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 17:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hr88W-0004Bz-NB
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 17:52:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56092)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hr88W-0003rT-EL
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 17:52:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so49103309wmj.5
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 14:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n4mqr7paywORaZUl6qISKbFJ41AH3otwRlzFIuZX9x0=;
 b=Hu8iMgCVNkfoFwCSn0eJGW/V11xKhJv4VWPH4j2hHjs004VLOofSgiv4E9eTtex0iM
 D1V2SU5+Km/n7yDf2jOcZRkgykAY0v0d4r/LTgu/JJIp4r3jjsi7zHVj4SSmU5vJ8RTr
 dCNu0dKGg/fVwzL5QTRTczIPZc4MLwOTdNvwD+hz/YhNmOZ23hmu0aUDdezX91bXD4x/
 3IXZwiPttAKesR75vY7rjGy8bm5INYgrCOj3OrBwptRCQuHAWp4klPtI2bFG6A0g80m4
 bijxOkcfNPJcXAUAhNnOt9jgXEZ7D+cNO6xwfa+Mf6HdPnPjj2sR0p4mIK23w6E9x8FL
 ft2g==
X-Gm-Message-State: APjAAAWfel2wJtC5YurV/kXxw3mA4YxLO6jHBG0c3aSTCk31DIv/jdPc
 tINbjOZkIcS7/3mT2o3Hyz18VA==
X-Google-Smtp-Source: APXvYqy8E/Wk0CozynLwgUh8Mqsb/L/Ywv1pDYllloOW/C2+J5lHqoQ+JvvRGKrX4FmZgKpoYeQJCw==
X-Received: by 2002:a7b:ce18:: with SMTP id m24mr83928552wmc.126.1564177904996; 
 Fri, 26 Jul 2019 14:51:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9036:7130:d6ec:a346?
 ([2001:b07:6468:f312:9036:7130:d6ec:a346])
 by smtp.gmail.com with ESMTPSA id i66sm87131276wmi.11.2019.07.26.14.51.43
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 14:51:44 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@gmail.com>, "Oleinik, Alexander" <alxndr@bu.edu>
References: <20190725032321.12721-1-alxndr@bu.edu>
 <20190725032321.12721-10-alxndr@bu.edu>
 <20190726130414.GG25977@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <754e1464-964b-61d7-6fda-ba52372b4756@redhat.com>
Date: Fri, 26 Jul 2019 23:51:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726130414.GG25977@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [RFC 09/19] fuzz: use mtree_info to find mapped
 addresses
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
Cc: "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/07/19 15:04, Stefan Hajnoczi wrote:
> On Thu, Jul 25, 2019 at 03:23:51AM +0000, Oleinik, Alexander wrote:
>> Locate mmio and port i/o addresses that are mapped to devices so we can
>> limit the fuzzer to only these addresses. This should be replaced with
>> a sane way of enumaring these memory regions.
>>
>> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
>> ---
>>  memory.c | 34 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>>
>> diff --git a/memory.c b/memory.c
>> index 5d8c9a9234..fa6cbe4f1d 100644
>> --- a/memory.c
>> +++ b/memory.c
>> @@ -34,6 +34,11 @@
>>  #include "hw/qdev-properties.h"
>>  #include "hw/boards.h"
>>  #include "migration/vmstate.h"
>> +#ifdef CONFIG_FUZZ
>> +#include "tests/fuzz/fuzz.h"
>> +#include "tests/fuzz/qos_fuzz.h"
>> +#endif
>> +
>>  
>>  //#define DEBUG_UNASSIGNED
>>  
>> @@ -3016,12 +3021,20 @@ static void mtree_print_flatview(gpointer key, gpointer value,
>>      int n = view->nr;
>>      int i;
>>      AddressSpace *as;
>> +#ifdef CONFIG_FUZZ
>> +    bool io=false;
>> +#endif
>> +
>>  
>>      qemu_printf("FlatView #%d\n", fvi->counter);
>>      ++fvi->counter;
>>  
>>      for (i = 0; i < fv_address_spaces->len; ++i) {
>>          as = g_array_index(fv_address_spaces, AddressSpace*, i);
>> +#ifdef CONFIG_FUZZ
>> +        if(strcmp("I/O",as->name) == 0)
>> +            io = true;
>> +#endif
>>          qemu_printf(" AS \"%s\", root: %s",
>>                      as->name, memory_region_name(as->root));
>>          if (as->root->alias) {
>> @@ -3062,6 +3075,27 @@ static void mtree_print_flatview(gpointer key, gpointer value,
>>                          range->readonly ? "rom" : memory_region_type(mr),
>>                          memory_region_name(mr));
>>          }
>> +#ifdef CONFIG_FUZZ
>> +        if(strcmp("i/o", memory_region_type(mr))==0 && strcmp("io", memory_region_name(mr))){
>> +            fuzz_memory_region *fmr = g_new0(fuzz_memory_region, 1);
>> +            if(!fuzz_memory_region_head)
>> +            {
>> +                fuzz_memory_region_head = fmr;
>> +                fuzz_memory_region_tail = fmr;
>> +            }
>> +            fmr->io = io;
>> +            fmr->start = int128_get64(range->addr.start);
>> +            fmr->length = MR_SIZE(range->addr.size);
>> +            fmr->next = fuzz_memory_region_head;
>> +            fuzz_memory_region_tail->next = fmr;
>> +            fuzz_memory_region_tail = fmr;
>> +            if(io == true){
>> +                total_io_mem += MR_SIZE(range->addr.size)+1;
>> +            } else {
>> +                total_ram_mem += MR_SIZE(range->addr.size)+1;
>> +            }
>> +        }
>> +#endif
> 
> Why is this patch modifying a print function?  I think the goal is to
> build the fuzz_memory_region list and calculate
> total_io_mem/total_ram_mem.  This should be done by a separate function.

Yeah, this should just cut-and-paste code from mtree_print_flatview,
then you can remove the printing stuff completely from your copy.

Paolo


