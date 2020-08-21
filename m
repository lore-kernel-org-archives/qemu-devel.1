Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECE6C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:02:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15F11207DE
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F11207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k93so-0003gT-BI
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k93q7-0000bg-VS
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:00:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4262 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k93q5-0006xt-SX
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:00:03 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id E4B4C5E6C4C136CFB5FA;
 Fri, 21 Aug 2020 17:59:51 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.4) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 21 Aug 2020
 17:59:45 +0800
From: Zheng Chuan <zhengchuan@huawei.com>
Subject: Re: [PATCH v3 02/10] migration/dirtyrate: Add RamlockDirtyInfo to
 store sampled page info
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1597634433-18809-1-git-send-email-zhengchuan@huawei.com>
 <1597634433-18809-3-git-send-email-zhengchuan@huawei.com>
 <20200820162047.GJ2664@work-vm>
Message-ID: <3f5ad1f2-59ab-6efd-c18e-2123dc771af8@huawei.com>
Date: Fri, 21 Aug 2020 17:59:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200820162047.GJ2664@work-vm>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.4]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 05:59:52
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
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/8/21 0:20, Dr. David Alan Gilbert wrote:
> * Chuan Zheng (zhengchuan@huawei.com) wrote:
>> Add RamlockDirtyInfo to store sampled page info of each ramblock.
>>
>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
>> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
>> ---
>>  migration/dirtyrate.h | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
>> index 914c363..9650566 100644
>> --- a/migration/dirtyrate.h
>> +++ b/migration/dirtyrate.h
>> @@ -19,6 +19,11 @@
>>   */
>>  #define DIRTYRATE_DEFAULT_SAMPLE_PAGES            256
>>  
>> +/*
>> + * Record ramblock idstr
>> + */
>> +#define RAMBLOCK_INFO_MAX_LEN                     256
>> +
>>  /* Take 1s as default for calculation duration */
>>  #define DEFAULT_FETCH_DIRTYRATE_TIME_SEC          1
>>  
>> @@ -39,6 +44,19 @@ typedef enum {
>>      CAL_DIRTY_RATE_END,
>>  } CalculatingDirtyRateState;
>>  
>> +/*
>> + * Store dirtypage info for each ramblock.
>> + */
>> +struct RamblockDirtyInfo {
>> +    char idstr[RAMBLOCK_INFO_MAX_LEN]; /* idstr for each ramblock */
>> Can you remind me; why not just use RAMBlock* here of the block you're
> interested in, rather than storing the name?
>
idstr is used to store which ramblock is sampled page in, we test it in
find_page_matched().
so you mean we just RAMBlock*, and take idstr out of RAMBlock* when it need to
find matched page?

>> +    uint8_t *ramblock_addr; /* base address of ramblock we measure */
>> +    size_t ramblock_pages; /* sum of dividation by 4K pages for ramblock */
> 
> 'dividation' is the wrong word, and 'sum' is only needed where you're
> adding things together.  I think this is 'ramblock size in TARGET_PAGEs'
> 
>> +    size_t *sample_page_vfn; /* relative offset address for sampled page */
>> +    unsigned int sample_pages_count; /* sum of sampled pages */
>> +    unsigned int sample_dirty_count; /* sum of dirty pages we measure */
> 
> These are both 'count' rather than 'sum'
> 
OK, will be fixed in V4:)

>> +    uint8_t *hash_result; /* array of hash result for sampled pages */
>> +};
>> +
>>  void *get_dirtyrate_thread(void *arg);
>>  #endif
>>  
>> -- 
>> 1.8.3.1
>>


