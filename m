Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9CAC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 17:36:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07D9B206C1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 17:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D9B206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxxCa-0000BE-1n
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 13:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hxxBa-0007tg-11
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 13:35:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hxxBY-0002tg-V3
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 13:35:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35698)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hxxBY-0002tI-PB
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 13:35:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so10009wmg.0
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 10:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pZwZD+zxcS8webzqEhL/LhVLVo7xTI3ydaOoQ9ECA64=;
 b=VLFHSopGe5nY9CqVLy2Ur4L634B/P5qD1RMpgN7Fxz8ZgDFrsJdZMcPv5MOErNl34T
 fyAllML674K1xeIjq6xke6XyYp29bwmJtJaKgJyrlQJtkMJPdeC5M8K4P+ONc9m1cSSJ
 AKUMk6lJTjWhsl9zwJRjQRYbeiaFAIycSdMD4kzi50+cky2HXbOXegqEgJuyad+hT6vC
 Q91qs71p8ZMMAWCN75RmbVyliGOxHdiqEeDjljy1/PjCg7NTWXjH+RbhDguWytpK5UMY
 hLs89FBXW7iAFw56fI1AOxbvhywoyUoQZMp/kJlxZMFhoYn4CKNBdJu9yotWqjg4qBnY
 lYqg==
X-Gm-Message-State: APjAAAX/GbR6EsSEOiaH5hE7vdK11umwTXz0DZaHxDwyAzZGlmXXoA8G
 uvfqPxpVhDIU65tcOuztDfRQqQ==
X-Google-Smtp-Source: APXvYqw6NoQDHtl8MfuCyKVsqGN7gd+Fxq3gmd3JAqLU+qHWfQUJ4o4CJpZOmXNm9+AnxGeU85o2eQ==
X-Received: by 2002:a1c:44c3:: with SMTP id r186mr312363wma.14.1565804143574; 
 Wed, 14 Aug 2019 10:35:43 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id v16sm568687wrn.28.2019.08.14.10.35.42
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 14 Aug 2019 10:35:42 -0700 (PDT)
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190813102936.32195-1-dgilbert@redhat.com>
 <20190813102936.32195-2-dgilbert@redhat.com>
 <f87ef58d-a549-54cf-4a3a-8e4712c699e1@redhat.com>
 <20190814172545.GS2920@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <64416580-ee29-8d75-4ad6-c1453d70afd6@redhat.com>
Date: Wed, 14 Aug 2019 19:35:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190814172545.GS2920@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH 1/2] memory: Align and add helper for
 comparing MemoryRegionSections
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
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/19 7:25 PM, Dr. David Alan Gilbert wrote:
> * Philippe Mathieu-Daudé (philmd@redhat.com) wrote:
>> Hi David,
>>
>> On 8/13/19 12:29 PM, Dr. David Alan Gilbert (git) wrote:
>>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>>
>>> MemoryRegionSection includes an Int128 'size' field;
>>> on some platforms the compiler causes an alignment of this to
>>> a 128bit boundary, leaving 8 bytes of dead space.
>>> This deadspace can be filled with junk.
>>>
>>> Move the size field to the top avoiding unnecsssary alignment
>>
>> "unnecessary"
> 
> Oops thanks.
> 
>> This is enough change to be in its own commit.
>>
>> ---
>>
>>> and provide an 'eq' routine to safely compare MRS's.
>>
>> This is another change, and should be squashed in the next patch IMO.
> 
> OK, what I'll do is I'll split this one into two ; I feel better
> having the extra function here separate from the next commit.

Thanks, feel free to add to both:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>> Doesn't Clang warn about unused 'static inline' btw?
> 
> I was using gcc; but we seem to have loads of static inline's - what
> would make this one different?

I guess I was confused with 'static (no-inline)' :)

>>>
>>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>> ---
>>>  include/exec/memory.h | 14 +++++++++++++-
>>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>>> index 606250172a..ce62e847bd 100644
>>> --- a/include/exec/memory.h
>>> +++ b/include/exec/memory.h
>>> @@ -487,15 +487,27 @@ static inline FlatView *address_space_to_flatview(AddressSpace *as)
>>>   * @nonvolatile: this section is non-volatile
>>>   */
>>>  struct MemoryRegionSection {
>>> +    Int128 size;
>>>      MemoryRegion *mr;
>>>      FlatView *fv;
>>>      hwaddr offset_within_region;
>>> -    Int128 size;
>>>      hwaddr offset_within_address_space;
>>>      bool readonly;
>>>      bool nonvolatile;
>>>  };
>>>  
>>> +static inline bool MemoryRegionSection_eq(MemoryRegionSection *a,
>>> +                                          MemoryRegionSection *b)
>>> +{
>>> +    return a->mr == b->mr &&
>>> +           a->fv == b->fv &&
>>> +           a->offset_within_region == b->offset_within_region &&
>>> +           a->offset_within_address_space == b->offset_within_address_space &&
>>> +           int128_eq(a->size, b->size) &&
>>> +           a->readonly == b->readonly &&
>>> +           a->nonvolatile == b->nonvolatile;
>>> +}
>>> +
>>>  /**
>>>   * memory_region_init: Initialize a memory region
>>>   *
>>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

