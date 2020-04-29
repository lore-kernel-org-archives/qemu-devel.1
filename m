Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E136FC83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 00:55:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF3762070B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 00:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3762070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTb0Z-00073B-RO
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 20:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wei.w.wang@intel.com>) id 1jTazd-0006WD-6Q
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 20:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <wei.w.wang@intel.com>) id 1jTazb-0003DY-Q8
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 20:54:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:22176)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1jTazb-0003CE-7y
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 20:54:27 -0400
IronPort-SDR: swqV294pgItIik95QjvwNmShN7RCgstu4GEPrZf5lbwiOxSRV8y8xpfwwtyuTc/+tfCcd9wSTS
 qVfncQ9yLsWg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2020 17:54:15 -0700
IronPort-SDR: pMJ32AK/jaGiq5GHtPnJG7ZdVN+aHGW34JihUH4e3oiA8zahE9L/t0QqtV6qL0ZORB0HdokwIL
 UeEO98E6ne9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,329,1583222400"; d="scan'208";a="282334567"
Received: from unknown (HELO [10.239.13.113]) ([10.239.13.113])
 by fmsmga004.fm.intel.com with ESMTP; 28 Apr 2020 17:54:13 -0700
Message-ID: <5EA8D1C9.5000209@intel.com>
Date: Wed, 29 Apr 2020 09:00:57 +0800
From: Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
 rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2] migration/xbzrle: add encoding rate
References: <1587974511-14953-1-git-send-email-wei.w.wang@intel.com>
 <20200428145110.GH2794@work-vm>
In-Reply-To: <20200428145110.GH2794@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.20; envelope-from=wei.w.wang@intel.com;
 helo=mga02.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 20:54:15
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 134.134.136.20
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
Cc: kevin.tian@intel.com, berrange@redhat.com, quintela@redhat.com,
 qemu-devel@nongnu.org, peterx@redhat.com, gloryxiao@tencent.com,
 yi.y.sun@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/28/2020 10:51 PM, Dr. David Alan Gilbert wrote:
> * Wei Wang (wei.w.wang@intel.com) wrote:
>> Users may need to check the xbzrle encoding rate to know if the guest
>> memory is xbzrle encoding-friendly, and dynamically turn off the
>> encoding if the encoding rate is low.
>>
>> Signed-off-by: Yi Sun <yi.y.sun@intel.com>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> ---
>>   migration/migration.c |  1 +
>>   migration/ram.c       | 38 ++++++++++++++++++++++++++++++++++++--
>>   monitor/hmp-cmds.c    |  2 ++
>>   qapi/migration.json   |  5 ++++-
>>   4 files changed, 43 insertions(+), 3 deletions(-)
>>
>> ChangeLog:
>> - include the 3 bytes (ENCODING_FLAG_XBZRLE flag and encoded_len) when
>>    calculating the encoding rate. Similar to the compress rate
>>    calculation, the 8 byte RAM_SAVE_FLAG_CONTINUE flag isn't included in
>>    the calculation.
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 187ac04..e404213 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -930,6 +930,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
>>           info->xbzrle_cache->pages = xbzrle_counters.pages;
>>           info->xbzrle_cache->cache_miss = xbzrle_counters.cache_miss;
>>           info->xbzrle_cache->cache_miss_rate = xbzrle_counters.cache_miss_rate;
>> +        info->xbzrle_cache->encoding_rate = xbzrle_counters.encoding_rate;
>>           info->xbzrle_cache->overflow = xbzrle_counters.overflow;
>>       }
>>   
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 04f13fe..f46ab96 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -327,6 +327,10 @@ struct RAMState {
>>       uint64_t num_dirty_pages_period;
>>       /* xbzrle misses since the beginning of the period */
>>       uint64_t xbzrle_cache_miss_prev;
>> +    /* Amount of xbzrle pages since the beginning of the period */
>> +    uint64_t xbzrle_pages_prev;
>> +    /* Amount of xbzrle encoded bytes since the beginning of the period */
>> +    uint64_t xbzrle_bytes_prev;
>>   
>>       /* compression statistics since the beginning of the period */
>>       /* amount of count that no free thread to compress data */
>> @@ -696,6 +700,18 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
>>           return -1;
>>       }
>>   
>> +    /*
>> +     * Reaching here means the page has hit the xbzrle cache, no matter what
>> +     * encoding result it is (normal encoding, overflow or skipping the page),
>> +     * count the page as encoded. This is used to caculate the encoding rate.
>> +     *
>> +     * Example: 2 pages (8KB) being encoded, first page encoding generates 2KB,
>> +     * 2nd page turns out to be skipped (i.e. no new bytes written to the
>> +     * page), the overall encoding rate will be 8KB / 2KB = 4, which has the
>> +     * skipped page included. In this way, the encoding rate can tell if the
>> +     * guest page is good for xbzrle encoding.
>> +     */
>> +    xbzrle_counters.pages++;
> Can you explain how that works with overflow?  Doesn't overflow return
> -1 here, not increment the bytes, so it looks like you've xbzrle'd a
> page, but the encoding rate hasn't incremented.

OK. How about adding below before returning -1 (for the overflow case):

...
xbzrle_counters.bytes += TARGET_PAGE_SIZE;
return -1;

Example: if we have 2 pages encoded as below:
4KB--> after normal encoding: 2KB
4KB--> after overflow: 4KB (will be sent as non-encoded page)
then the encoding rate is 8KB / 6KB = ~1.3
(if we skip the counting of the overflow case,
the encoding rate will be 4KB/ 2KB=2. Users may think that's
good to go with xbzrle, unless they do another calculation with
checking the overflow numbers themselves)

Best,
Wei

