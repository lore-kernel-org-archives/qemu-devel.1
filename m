Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33BCC76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 09:16:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB58B2077C
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 09:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB58B2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hng39-0002E8-Uk
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 05:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60317)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hng2y-0001nH-03
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:16:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hng2w-0004Yb-Kd
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:16:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36503)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hng2w-0004Xw-Cz
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:16:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so23983892wrs.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 02:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZIGN2xGPJAdNWykr/HOrV6M2Jud6vnToh4Hx+LGik/U=;
 b=nySwEK6VUz5c3E762t4d3oNkdixExuQsEE3tmzUO8sFL88iAP/WLKw4Jkm7bEabD4G
 4MmgLdPw406NUdM6oyLrz9r4EElMlwPEO7OqRegLxn43EPS56zNLSXyvhUvi5xMTs0J/
 CZd+uqyVLOtOnWQxxp4Jn7qKEY/0gz6QQhlRFOq33f7d62fwCbjRAXnqJiJqMAsHNIGh
 J7fCOB7CmnTShTCK88w8vJGcJgdydFL/eNSEc6DdiHwS8vJgOy3mtmxqtJesiAjmnGYA
 FS02JEDDjo3H2VB1MysqAN3aQovq+tgxlSSJ3H9MNGKs2Dh3ALUG0ojxHIDAiQCNafb3
 JgZw==
X-Gm-Message-State: APjAAAUKZ8RFHhZoVQwlo4D1Z52GC1EWfgO0Kt+ag9TC11+ZnKhHT9zs
 vSVRBtrg1oOQQJg79p9eTb8t2A==
X-Google-Smtp-Source: APXvYqy5wfzWrGySZnmv8zLX0cFKbb7TB4s8Df6tSyYEntLN71jccVGVLivF0LIDw8W0Y5Rz1G6zOA==
X-Received: by 2002:adf:a299:: with SMTP id s25mr34335068wra.74.1563354981230; 
 Wed, 17 Jul 2019 02:16:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2?
 ([2001:b07:6468:f312:e427:3beb:1110:dda2])
 by smtp.gmail.com with ESMTPSA id k124sm36507584wmk.47.2019.07.17.02.16.20
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Jul 2019 02:16:20 -0700 (PDT)
To: Wei Yang <richardw.yang@linux.intel.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190430034412.12935-1-richardw.yang@linux.intel.com>
 <20190430034412.12935-3-richardw.yang@linux.intel.com>
 <20190514142108.GG2753@work-vm> <20190717011337.GA14233@richard>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4b3016cd-de7b-3ab7-76b8-8608cb1239b6@redhat.com>
Date: Wed, 17 Jul 2019 11:16:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190717011337.GA14233@richard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 2/3] migration/ram.c: start of
 cpu_physical_memory_sync_dirty_bitmap is always 0
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/07/19 03:13, Wei Yang wrote:
> On Tue, May 14, 2019 at 03:21:08PM +0100, Dr. David Alan Gilbert wrote:
>> * Wei Yang (richardw.yang@linux.intel.com) wrote:
>>> Since start of cpu_physical_memory_sync_dirty_bitmap is always 0, we can
>>> remove this parameter and simplify the calculation a bit.
>>>
>>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>
>> So I think you're right it's currently unused; however, lets ask
>> Paolo: Do we need to keep this parameter for flexiblity?
>>
> 
> Hey, Paolo
> 
> Do you have some spare time to give some insight?

I think it's cleaner to leave the start argument in place.  However,
I'll note that in migration_bitmap_sync_range the length argument is
always block->used_length so that's also unnecessary (you already have
block).

Paolo

>> Dave
>>
>>> ---
>>>  include/exec/ram_addr.h | 15 ++++++---------
>>>  migration/ram.c         |  2 +-
>>>  2 files changed, 7 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
>>> index 9ecd911c3e..3dfb2d52fb 100644
>>> --- a/include/exec/ram_addr.h
>>> +++ b/include/exec/ram_addr.h
>>> @@ -409,18 +409,16 @@ static inline void cpu_physical_memory_clear_dirty_range(ram_addr_t start,
>>>  
>>>  static inline
>>>  uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>>> -                                               ram_addr_t start,
>>>                                                 ram_addr_t length,
>>>                                                 uint64_t *real_dirty_pages)
>>>  {
>>>      ram_addr_t addr;
>>> -    unsigned long word = BIT_WORD((start + rb->offset) >> TARGET_PAGE_BITS);
>>> +    unsigned long word = BIT_WORD(rb->offset >> TARGET_PAGE_BITS);
>>>      uint64_t num_dirty = 0;
>>>      unsigned long *dest = rb->bmap;
>>>  
>>> -    /* start address and length is aligned at the start of a word? */
>>> -    if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) ==
>>> -         (start + rb->offset) &&
>>> +    /* offset and length is aligned at the start of a word? */
>>> +    if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) == (rb->offset) &&
>>>          !(length & ((BITS_PER_LONG << TARGET_PAGE_BITS) - 1))) {
>>>          int k;
>>>          int nr = BITS_TO_LONGS(length >> TARGET_PAGE_BITS);
>>> @@ -428,14 +426,13 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>>>          unsigned long idx = (word * BITS_PER_LONG) / DIRTY_MEMORY_BLOCK_SIZE;
>>>          unsigned long offset = BIT_WORD((word * BITS_PER_LONG) %
>>>                                          DIRTY_MEMORY_BLOCK_SIZE);
>>> -        unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
>>>  
>>>          rcu_read_lock();
>>>  
>>>          src = atomic_rcu_read(
>>>                  &ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION])->blocks;
>>>  
>>> -        for (k = page; k < page + nr; k++) {
>>> +        for (k = 0; k < nr; k++) {
>>>              if (src[idx][offset]) {
>>>                  unsigned long bits = atomic_xchg(&src[idx][offset], 0);
>>>                  unsigned long new_dirty;
>>> @@ -458,11 +455,11 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>>>  
>>>          for (addr = 0; addr < length; addr += TARGET_PAGE_SIZE) {
>>>              if (cpu_physical_memory_test_and_clear_dirty(
>>> -                        start + addr + offset,
>>> +                        addr + offset,
>>>                          TARGET_PAGE_SIZE,
>>>                          DIRTY_MEMORY_MIGRATION)) {
>>>                  *real_dirty_pages += 1;
>>> -                long k = (start + addr) >> TARGET_PAGE_BITS;
>>> +                long k = addr >> TARGET_PAGE_BITS;
>>>                  if (!test_and_set_bit(k, dest)) {
>>>                      num_dirty++;
>>>                  }
>>> diff --git a/migration/ram.c b/migration/ram.c
>>> index 9948b2d021..1def8122e9 100644
>>> --- a/migration/ram.c
>>> +++ b/migration/ram.c
>>> @@ -1646,7 +1646,7 @@ static void migration_bitmap_sync_range(RAMState *rs, RAMBlock *rb,
>>>                                          ram_addr_t length)
>>>  {
>>>      rs->migration_dirty_pages +=
>>> -        cpu_physical_memory_sync_dirty_bitmap(rb, 0, length,
>>> +        cpu_physical_memory_sync_dirty_bitmap(rb, length,
>>>                                                &rs->num_dirty_pages_period);
>>>  }
>>>  
>>> -- 
>>> 2.19.1
>>>
>> --
>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 


