Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C581DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:01:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB12207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB12207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k93rS-0001u4-TN
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k93q9-0000bo-C3
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:00:05 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48808 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k93q7-0006y2-EK
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:00:05 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 8BC93F29DF0050D61E59;
 Fri, 21 Aug 2020 17:59:57 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.4) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Fri, 21 Aug 2020
 17:59:49 +0800
From: Zheng Chuan <zhengchuan@huawei.com>
Subject: Re: [PATCH v3 03/10] migration/dirtyrate: Add dirtyrate statistics
 series functions
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1597634433-18809-1-git-send-email-zhengchuan@huawei.com>
 <1597634433-18809-4-git-send-email-zhengchuan@huawei.com>
 <20200820162822.GK2664@work-vm>
Message-ID: <6ac3f30f-a713-9d28-b415-1977a6a7d426@huawei.com>
Date: Fri, 21 Aug 2020 17:59:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200820162822.GK2664@work-vm>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.4]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=zhengchuan@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 05:59:57
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



On 2020/8/21 0:28, Dr. David Alan Gilbert wrote:
> * Chuan Zheng (zhengchuan@huawei.com) wrote:
>> Add dirtyrate statistics to record/update dirtyrate info.
>>
>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
>> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
>> ---
>>  migration/dirtyrate.c | 30 ++++++++++++++++++++++++++++++
>>  migration/dirtyrate.h | 10 ++++++++++
>>  2 files changed, 40 insertions(+)
>>
>> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
>> index bb0ebe9..8708090 100644
>> --- a/migration/dirtyrate.c
>> +++ b/migration/dirtyrate.c
>> @@ -24,6 +24,7 @@
>>  #include "dirtyrate.h"
>>  
>>  CalculatingDirtyRateState CalculatingState = CAL_DIRTY_RATE_INIT;
>> +static struct DirtyRateStat dirty_stat;
>>  
>>  static int dirty_rate_set_state(int new_state)
>>  {
>> @@ -40,6 +41,35 @@ static int dirty_rate_set_state(int new_state)
>>      return 0;
>>  }
>>  
>> +static void reset_dirtyrate_stat(void)
>> +{
>> +    dirty_stat.total_dirty_samples = 0;
>> +    dirty_stat.total_sample_count = 0;
>> +    dirty_stat.total_block_mem_MB = 0;
>> +    dirty_stat.dirty_rate = 0;
>> +}
>> +
>> +static void update_dirtyrate_stat(struct RamblockDirtyInfo *info)
>> +{
>> +    dirty_stat.total_dirty_samples += info->sample_dirty_count;
>> +    dirty_stat.total_sample_count += info->sample_pages_count;
>> +    /* size of 4K pages in MB */
>> +    dirty_stat.total_block_mem_MB += info->ramblock_pages / 256;
>> +}
>> +
>> +static void update_dirtyrate(uint64_t msec)
>> +{
>> +    uint64_t dirty_rate;
>> +    unsigned int total_dirty_samples = dirty_stat.total_dirty_samples;
>> +    unsigned int total_sample_count = dirty_stat.total_sample_count;
>> +    size_t total_block_mem_MB = dirty_stat.total_block_mem_MB;
>> +
>> +    dirty_rate = total_dirty_samples * total_block_mem_MB *
>> +                 1000 / (total_sample_count * msec);
>> +
>> +    dirty_stat.dirty_rate = dirty_rate;
>> +}
>> +
>>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>>  {
>>      /* todo */
>> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
>> index 9650566..af57c80 100644
>> --- a/migration/dirtyrate.h
>> +++ b/migration/dirtyrate.h
>> @@ -57,6 +57,16 @@ struct RamblockDirtyInfo {
>>      uint8_t *hash_result; /* array of hash result for sampled pages */
>>  };
>>  
>> +/*
>> + * Store calculate statistics for each measure.
>> + */
>> +struct DirtyRateStat {
>> +    unsigned int total_dirty_samples; /* total dirty pages for this measure */
>> +    unsigned int total_sample_count; /* total sampled pages for this measure */
>> +    size_t total_block_mem_MB; /* size of sampled pages in MB */
>> +    int64_t dirty_rate; /* dirty rate for this measure */
> 
> As I said in the previous review, please comment 'dirty_rate' with it's
> units.
> 
Sorry, i missed that, will be fix in V4:)
> Dave
> 
>> +};
>> +
>>  void *get_dirtyrate_thread(void *arg);
>>  #endif
>>  
>> -- 
>> 1.8.3.1
>>


