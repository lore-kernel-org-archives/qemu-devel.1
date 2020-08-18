Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F5EC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 08:02:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC1B2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 08:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kavYgngw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC1B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7wZj-0007Sx-37
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 04:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7wZ4-0006Zd-7I
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 04:01:50 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33865)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7wZ2-0007wr-CE
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 04:01:49 -0400
Received: by mail-wr1-x441.google.com with SMTP id f7so17355519wrw.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 01:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KKyfh+gUg8M91LHsN8NlNniZtUSux0nr3YX7fOhr4WY=;
 b=kavYgngw+UDLHdOmwfMq/Nv9FvxjkSFCS3MRIiYY3kd6vV6U8iYB1WEKtDbbEou95Q
 ZFTQYv1kR7j0uNoq2ImATI2WqTbC/GNst6pIKNd1i7LHZpxnvQICKtT12wPkBXXsezco
 SlGeia6TzL4oCLSKGJ6xs9Z6wvSC8IdtlmY7H9qt0GbvnfhTRuCIsAqI5QrS33GjaGYt
 tV6D2HOmDFz1VViJ3i/Ro9g2LZjGzrCCBsNOBhmUHnhO6Ddc/o2ZCnI3pVx3kg5EmCPC
 4maPiIukaVLu73p5uoikbuzj+3q9xAjwtH+1gZLQGY9WnYPuYBtnnR7TonCiV69o9+on
 5t8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KKyfh+gUg8M91LHsN8NlNniZtUSux0nr3YX7fOhr4WY=;
 b=PMDugNZ30xPcRaF5A9ecn7r2yRA83CQN49z7xYtqqj8zstsaMlJQ5WB4jqsRII6bSG
 hr4fir+k3eyupx/Bn4qsjT0fFgXOFkWKz7EkEXs5Kmp1mv+XPgoDruMSxkG3ncu5Vobd
 QevOicPLkRHJud+CoJbwnJgmGj4qn6/jsm2X+PiiKQ2hsb2MHW7k1k3kNpwjtggbM16e
 i+yxFrqsCOfBRRDibyHgT23toyCq6lcrmHqFKumH8zIQdaugfbn0cXy2MGGETZ+L+E6x
 I3bTgxtuWn8DrbG/inVhbpX/3BTyx2JU49i5KZuHxjR2xs3E/KiNQkJpOty9fP0DlzmH
 /A/g==
X-Gm-Message-State: AOAM530QQKD1JR6GNizAzTgS4eG1o4ex7EhDy3uHj8bIOS+GfIgsb0yh
 PxYJVdDGXy/WlMTZ6rN+sAo=
X-Google-Smtp-Source: ABdhPJz5sKyYmgnQmK9fb1TNe1kHzKS6On72B82tHTMTcAmSNsF5CNnlHfSCwR6LvoshzvRqTLEYgg==
X-Received: by 2002:a5d:538d:: with SMTP id d13mr19007040wrv.400.1597737706321; 
 Tue, 18 Aug 2020 01:01:46 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id n5sm32398929wrx.22.2020.08.18.01.01.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 01:01:45 -0700 (PDT)
Subject: Re: [PATCH] memory: Directly dispatch alias accesses on origin memory
 region
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200816173051.16274-1-f4bug@amsat.org>
 <706c1969-3e73-7a8e-d4fe-9a2516f44054@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <077ba036-0654-3fa5-c78f-2485aebd5daf@amsat.org>
Date: Tue, 18 Aug 2020 10:01:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <706c1969-3e73-7a8e-d4fe-9a2516f44054@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 6:27 PM, Paolo Bonzini wrote:
> On 16/08/20 19:30, Philippe Mathieu-Daudé wrote:
>> There is an issue when accessing an alias memory region via the
>> memory_region_dispatch_read() / memory_region_dispatch_write()
>> calls:
>>
>> The memory_region_init_alias() flow is:
>>
>>   memory_region_init_alias()
>>   -> memory_region_init()
>>      -> object_initialize(TYPE_MEMORY_REGION)
>>         -> memory_region_initfn()
>>            -> mr->ops = &unassigned_mem_ops;
>>
>> Later when accessing the alias, the memory_region_dispatch_read()
>> flow is:
>>
>>   memory_region_dispatch_read()
>>   -> memory_region_access_valid(mr)
>>      -> mr->ops->valid.accepts()
>>         -> unassigned_mem_accepts()
>>         <- false
>>      <- false
>>    <- MEMTX_DECODE_ERROR
>>
>> The caller gets a MEMTX_DECODE_ERROR while the access is OK.
> 
> What is the path that leads to this call?

Using the interleaver from:
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg03680.html

#2  0x8162f7b6 in unassigned_mem_read (opaque=0x82ac7330, addr=0,
size=1) at softmmu/memory.c:1261
#3  0x8162fc2f in memory_region_dispatch_read (mr=0x82ac7330, addr=0,
pval=0x7ffe24b9cc08, op=MO_8, attrs=...) at softmmu/memory.c:1417
#4  0x8175488b in interleaver_read (opaque=0x82b9e530, offset=0,
data=0x7ffe24b9cc08, size=1, attrs=...) at hw/misc/interleaver.c:76
#5  0x8162cbdc in memory_region_read_with_attrs_accessor (mr=0x82b9e850,
addr=0, value=0x7ffe24b9cd90, size=1, shift=0, mask=255, attrs=...) at
softmmu/memory.c:456
#6  0x8162cfab in access_with_adjusted_size (addr=0,
value=0x7ffe24b9cd90, size=4, access_size_min=1, access_size_max=1,
access_fn=
    0x8162cb7c <memory_region_read_with_attrs_accessor>, mr=0x82b9e850,
attrs=...) at softmmu/memory.c:544
#7  0x8162fb98 in memory_region_dispatch_read1 (mr=0x82b9e850, addr=0,
pval=0x7ffe24b9cd90, size=4, attrs=...) at softmmu/memory.c:1395
#8  0x8162fc5a in memory_region_dispatch_read (mr=0x82b9e850, addr=0,
pval=0x7ffe24b9cd90, op=MO_32, attrs=...) at softmmu/memory.c:1421
#9  0x8153012b in flatview_read_continue (fv=0x82bd0d10, addr=320897024,
attrs=..., ptr=0x7ffe24b9cea0, len=4, addr1=0, l=4, mr=0x82b9e850) at
exec.c:3239
#10 0x8153027e in flatview_read (fv=0x82bd0d10, addr=320897024,
attrs=..., buf=0x7ffe24b9cea0, len=4) at exec.c:3278
#11 0x81530307 in address_space_read_full (as=0x81ec1ac0
<address_space_memory>, addr=320897024, attrs=..., buf=0x7ffe24b9cea0,
len=4) at exec.c:3291
#12 0x8163761e in address_space_read (len=4, buf=0x7ffe24b9cea0,
attrs=..., addr=320897024, as=0x81ec1ac0 <address_space_memory>) at
include/exec/memory.h:2420
#13 qtest_process_command (chr=0x81edcd00 <qtest_chr>, words=0x82be2b30)
at softmmu/qtest.c:495
#14 0x8163877b in qtest_process_inbuf (chr=0x81edcd00 <qtest_chr>,
inbuf=0x82a65220) at softmmu/qtest.c:724
#15 0x8163880c in qtest_read (opaque=0x81edcd00 <qtest_chr>,
buf=0x7ffe24b9d1f0 "readl 0x13208000\n 0x76\n", size=17) at
softmmu/qtest.c:736

> 
>> Fix by directly dispatching aliases accesses to its origin region.
>>
>> Fixes: 2cdfcf272d ("memory: assign MemoryRegionOps to all regions")
> 
> I don't think the "Fixes" is okay because you'd have gotten a different
> bug before.

OK I'll reword.

> 
>> +    if (mr->alias) {
>> +        addr += mr->alias_offset;
>> +        mr = mr->alias;
>> +    }
> 
> Also, I think this would have to be a while loop.

I haven't thought about this case! I'll add a test for it :)

> 
> Paolo
> 
> 

