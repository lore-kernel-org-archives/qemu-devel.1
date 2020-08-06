Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC49BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:54:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB9E922CF7
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9E922CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3aUA-0000hh-Pl
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 03:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k3aSl-0007AE-4c
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 03:37:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4227 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k3aSj-0002Kf-4F
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 03:37:18 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 1E059684F7EA30817CC3;
 Thu,  6 Aug 2020 15:37:13 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.4) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Thu, 6 Aug 2020
 15:37:04 +0800
From: Zheng Chuan <zhengchuan@huawei.com>
Subject: Re: [RFC PATCH 2/8] migration/dirtyrate: Add block_dirty_info to
 store dirtypage info
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1595646669-109310-1-git-send-email-zhengchuan@huawei.com>
 <1595646669-109310-3-git-send-email-zhengchuan@huawei.com>
 <20200804162829.GE2659@work-vm>
Message-ID: <8ac6e996-b01d-9b7c-3f7a-aeb2b376cfa1@huawei.com>
Date: Thu, 6 Aug 2020 15:37:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200804162829.GE2659@work-vm>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.186.4]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 02:58:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, linyilu@huawei.com,
 qemu-devel@nongnu.org, alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/8/5 0:28, Dr. David Alan Gilbert wrote:
> * Chuan Zheng (zhengchuan@huawei.com) wrote:
>> From: Zheng Chuan <zhengchuan@huawei.com>
>>
>> Add block_dirty_info to store dirtypage info for each ramblock
>>
>> Signed-off-by: Zheng Chuan <zhengchuan@huawei.com>
>> Signed-off-by: YanYing Zhang <ann.zhuangyanying@huawei.com>
>> ---
>>  migration/dirtyrate.h | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
>> index 9a5c228..342b89f 100644
>> --- a/migration/dirtyrate.h
>> +++ b/migration/dirtyrate.h
>> @@ -33,6 +33,19 @@ typedef enum {
>>      CAL_DIRTY_RATE_END   = 2,
>>  } CalculatingDirtyRateStage;
>>  
>> +/* 
>> + * Store dirtypage info for each block.
>> + */
>> +struct block_dirty_info {
> 
> Please call this ramblock_dirty_info; we use 'block' a lot to mean
> disk block and it gets confusing.
> 
Sure, ramblock_dirty_info is better.

>> +    char idstr[BLOCK_INFO_MAX_LEN];
> 
> Is there a reason you don't just use a RAMBlock *  here?
> 
>> +    uint8_t *block_addr;
>> +    unsigned long block_pages;
>> +    unsigned long *sample_page_vfn;
> 
> Please comment these; if I understand correctly, that's an array
> of page indexes into the block generated from the random numbers
> 
>> +    unsigned int sample_pages_count;
>> +    unsigned int sample_dirty_count;
>> +    uint8_t *hash_result;
> 
> If I understand, this is an array of hashes end-to-end for
> all the pages in this RAMBlock?
> 
> Dave
> 
Actually, we do not go through all pages of the RAMBlock but sample
some pages （for example, 256 pages per Gigabit）to make it faster.
Obviously it will sacrifice accuracy, but it still looks good enough
under practical test.

>> +};
>> +
>>  void *get_dirtyrate_thread(void *arg);
>>  #endif
>>  
>> -- 
>> 1.8.3.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> 
> .
> 


