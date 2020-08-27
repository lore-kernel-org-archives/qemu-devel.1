Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F04FC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 06:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A13120786
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 06:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A13120786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBBAC-00076p-DM
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 02:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kBB9Z-0006GH-4o
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 02:12:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4655 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kBB9X-0005N3-96
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 02:12:52 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 84907E0D8F4C86FF17E1;
 Thu, 27 Aug 2020 14:12:45 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.4) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Thu, 27 Aug 2020
 14:12:30 +0800
Subject: Re: [PATCH v5 04/12] migration/dirtyrate: Add dirtyrate statistics
 series functions
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1598319650-36762-1-git-send-email-zhengchuan@huawei.com>
 <1598319650-36762-5-git-send-email-zhengchuan@huawei.com>
 <20200826120912.GF2726@work-vm>
From: Zheng Chuan <zhengchuan@huawei.com>
Message-ID: <ff1af456-6dc5-574b-5c8f-43759a65a025@huawei.com>
Date: Thu, 27 Aug 2020 14:12:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200826120912.GF2726@work-vm>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.4]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:12:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.239,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: berrange@redhat.com, zhang.zhanghailiang@huawei.com, quintela@redhat.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, alex.chen@huawei.com,
 ann.zhuangyanying@huawei.com, fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/8/26 20:09, Dr. David Alan Gilbert wrote:
> * Chuan Zheng (zhengchuan@huawei.com) wrote:
>> Add dirtyrate statistics to record/update dirtyrate info.
>>
>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
>> ---
>>  migration/dirtyrate.c | 29 +++++++++++++++++++++++++++++
>>  migration/dirtyrate.h | 10 ++++++++++
>>  2 files changed, 39 insertions(+)
>>
>> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
>> index 91987c5..0d7163f 100644
>> --- a/migration/dirtyrate.c
>> +++ b/migration/dirtyrate.c
>> @@ -24,6 +24,7 @@
>>  #include "dirtyrate.h"
>>  
>>  static int CalculatingState = DIRTY_RATE_STATUS_UNSTARTED;
>> +static struct DirtyRateStat DirtyStat;
>>  
>>  static int dirtyrate_set_state(int *state, int old_state, int new_state)
>>  {
>> @@ -35,6 +36,34 @@ static int dirtyrate_set_state(int *state, int old_state, int new_state)
>>      }
>>  }
>>  
>> +static void reset_dirtyrate_stat(void)
>> +{
>> +    DirtyStat.total_dirty_samples = 0;
>> +    DirtyStat.total_sample_count = 0;
>> +    DirtyStat.total_block_mem_MB = 0;
>> +    DirtyStat.dirty_rate = 0;
>> +}
>> +
>> +static void update_dirtyrate_stat(struct RamblockDirtyInfo *info)
>> +{
>> +    DirtyStat.total_dirty_samples += info->sample_dirty_count;
>> +    DirtyStat.total_sample_count += info->sample_pages_count;
>> +    /* size of 4K pages in MB */
>> +    DirtyStat.total_block_mem_MB += info->ramblock_pages / 256;
> 
> You need to be consistent with your use of constants, you have
> a DIRTYRATE_SAMPLE_PAGE_SIZE in a later patch; so use it rather than
> hard coding 256 here.
> 
> Dave
> 
Sure.
I may take as
'DirtyStat.total_block_mem_MB += (info->ramblock_pages * DIRTYRATE_SAMPLE_PAGE_SIZE) >> 20';

>> +}
>> +
>> +static void update_dirtyrate(uint64_t msec)
>> +{
>> +    uint64_t dirtyrate;
>> +    uint64_t total_dirty_samples = DirtyStat.total_dirty_samples;
>> +    uint64_t total_sample_count = DirtyStat.total_sample_count;
>> +    uint64_t total_block_mem_MB = DirtyStat.total_block_mem_MB;
>> +
>> +    dirtyrate = total_dirty_samples * total_block_mem_MB *
>> +                 1000 / (total_sample_count * msec);
>> +
>> +    DirtyStat.dirty_rate = dirtyrate;
>> +}
>>  
>>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>>  {
>> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
>> index dc45419..8e25d93 100644
>> --- a/migration/dirtyrate.h
>> +++ b/migration/dirtyrate.h
>> @@ -45,6 +45,16 @@ struct RamblockDirtyInfo {
>>      uint32_t *hash_result; /* array of hash result for sampled pages */
>>  };
>>  
>> +/*
>> + * Store calculation statistics for each measure.
>> + */
>> +struct DirtyRateStat {
>> +    uint64_t total_dirty_samples; /* total dirty sampled page */
>> +    uint64_t total_sample_count; /* total sampled pages */
>> +    uint64_t total_block_mem_MB; /* size of total sampled pages in MB */
>> +    int64_t dirty_rate; /* dirty rate in MB/s */
>> +};
>> +
>>  void *get_dirtyrate_thread(void *arg);
>>  #endif
>>  
>> -- 
>> 1.8.3.1
>>


