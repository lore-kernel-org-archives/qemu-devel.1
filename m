Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FA4C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 03:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCB352186A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 03:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB352186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvZ7h-0001w5-Tk
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 23:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40072)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hvZ7K-0001W2-O4
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 23:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hvZ7J-0001VS-O4
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 23:29:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:15780)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hvZ7J-0001Ul-G9
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 23:29:29 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Aug 2019 20:29:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,360,1559545200"; d="scan'208";a="179710535"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga006.jf.intel.com with ESMTP; 07 Aug 2019 20:29:25 -0700
Date: Thu, 8 Aug 2019 11:29:03 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190808032903.GA29922@richard>
References: <20190718084816.6990-1-richardw.yang@linux.intel.com>
 <20190807174948.GK27871@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807174948.GK27871@work-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
Subject: Re: [Qemu-devel] [PATCH] migration: rename
 migration_bitmap_sync_range to ramblock_sync_dirty_bitmap
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: pbonzini@redhat.com, quintela@redhat.com,
 Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 07, 2019 at 06:49:48PM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> Rename for better understanding of the code.
>> 
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>this needs fixing after 'just pass RAMBlock is enough'
>

Ok, I got your point.

>Dave
>
>> ---
>>  migration/ram.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index c5f9f4b0ef..66792568e2 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -1669,7 +1669,7 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
>>      return ret;
>>  }
>>  
>> -static void migration_bitmap_sync_range(RAMState *rs, RAMBlock *rb,
>> +static void ramblock_sync_dirty_bitmap(RAMState *rs, RAMBlock *rb,
>>                                          ram_addr_t length)
>>  {
>>      rs->migration_dirty_pages +=
>> @@ -1762,7 +1762,7 @@ static void migration_bitmap_sync(RAMState *rs)
>>      qemu_mutex_lock(&rs->bitmap_mutex);
>>      rcu_read_lock();
>>      RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>> -        migration_bitmap_sync_range(rs, block, block->used_length);
>> +        ramblock_sync_dirty_bitmap(rs, block, block->used_length);
>>      }
>>      ram_counters.remaining = ram_bytes_remaining();
>>      rcu_read_unlock();
>> @@ -4175,7 +4175,7 @@ static void colo_flush_ram_cache(void)
>>      memory_global_dirty_log_sync();
>>      rcu_read_lock();
>>      RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>> -        migration_bitmap_sync_range(ram_state, block, block->used_length);
>> +        ramblock_sync_dirty_bitmap(ram_state, block, block->used_length);
>>      }
>>      rcu_read_unlock();
>>  
>> -- 
>> 2.17.1
>> 
>> 
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me

