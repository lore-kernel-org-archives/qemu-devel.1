Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A0DC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 01:29:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6803520738
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 01:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6803520738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHzmh-00076I-Ke
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 21:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kHzm6-0006gB-7q
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 21:28:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41906 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kHzm4-00066B-0F
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 21:28:49 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 2D4F543FA4744754D407;
 Tue, 15 Sep 2020 09:28:41 +0800 (CST)
Received: from [10.174.186.4] (10.174.186.4) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0;
 Tue, 15 Sep 2020 09:28:35 +0800
Subject: Re: [PATCH v8 06/12] migration/dirtyrate: Record hash results for
 each sampled page
To: Li Qiang <liq3ea@gmail.com>
References: <1600074185-91624-1-git-send-email-zhengchuan@huawei.com>
 <1600074185-91624-7-git-send-email-zhengchuan@huawei.com>
 <CAKXe6SJN=qHd=aqwMgRX6OvaPdfrKYJa_n14c7xL7uQLSb=rzw@mail.gmail.com>
From: Zheng Chuan <zhengchuan@huawei.com>
Message-ID: <2e06ca12-0d1b-77a1-020d-4f9d3567beb9@huawei.com>
Date: Tue, 15 Sep 2020 09:28:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJN=qHd=aqwMgRX6OvaPdfrKYJa_n14c7xL7uQLSb=rzw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.186.4]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=zhengchuan@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 21:28:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Juan Quintela <quintela@redhat.com>, yuxiating@huawei.com, "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>, xiexiangyou@huawei.com,
 Qemu Developers <qemu-devel@nongnu.org>, AlexChen <alex.chen@huawei.com>,
 jinyan12@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/9/14 22:59, Li Qiang wrote:
> Chuan Zheng <zhengchuan@huawei.com> 于2020年9月14日周一 下午4:52写道：
>>
>> Record hash results for each sampled page, crc32 is taken to calculate
>> hash results for each sampled length in TARGET_PAGE_SIZE.
>>
>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
>> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
>> Reviewed-by: David Edmondson <david.edmondson@oracle.com>
>> ---
>>  migration/dirtyrate.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 111 insertions(+)
>>
>> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
>> index cf2d560..beb18cb 100644
>> --- a/migration/dirtyrate.c
>> +++ b/migration/dirtyrate.c
>> @@ -10,6 +10,7 @@
>>   * See the COPYING file in the top-level directory.
>>   */
>>
>> +#include <zlib.h>
>>  #include "qemu/osdep.h"
>>  #include "qapi/error.h"
>>  #include "cpu.h"
>> @@ -68,6 +69,116 @@ static void update_dirtyrate(uint64_t msec)
>>      DirtyStat.dirty_rate = dirtyrate;
>>  }
>>
>> +/*
>> + * get hash result for the sampled memory with length of TARGET_PAGE_SIZE
>> + * in ramblock, which starts from ramblock base address.
>> + */
>> +static uint32_t get_ramblock_vfn_hash(struct RamblockDirtyInfo *info,
>> +                                      uint64_t vfn)
>> +{
>> +    uint32_t crc;
>> +
>> +    crc = crc32(0, (info->ramblock_addr +
>> +                vfn * TARGET_PAGE_SIZE), TARGET_PAGE_SIZE);
>> +
>> +    return crc;
>> +}
>> +
>> +static bool save_ramblock_hash(struct RamblockDirtyInfo *info)
>> +{
>> +    unsigned int sample_pages_count;
>> +    int i;
>> +    GRand *rand;
>> +
>> +    sample_pages_count = info->sample_pages_count;
>> +
>> +    /* ramblock size less than one page, return success to skip this ramblock */
>> +    if (unlikely(info->ramblock_pages == 0 || sample_pages_count == 0)) {
>> +        return true;
>> +    }
>> +
>> +    info->hash_result = g_try_malloc0_n(sample_pages_count,
>> +                                        sizeof(uint32_t));
>> +    if (!info->hash_result) {
>> +        return false;
>> +    }
>> +
>> +    info->sample_page_vfn = g_try_malloc0_n(sample_pages_count,
>> +                                            sizeof(uint64_t));
>> +    if (!info->sample_page_vfn) {
>> +        g_free(info->hash_result);
>> +        return false;
>> +    }
>> +
>> +    rand  = g_rand_new();
>> +    for (i = 0; i < sample_pages_count; i++) {
>> +        info->sample_page_vfn[i] = g_rand_int_range(rand, 0,
>> +                                                    info->ramblock_pages - 1);
>> +        info->hash_result[i] = get_ramblock_vfn_hash(info,
>> +                                                     info->sample_page_vfn[i]);
>> +    }
>> +    g_rand_free(rand);
>> +
>> +    return true;
>> +}
>> +
>> +static void get_ramblock_dirty_info(RAMBlock *block,
>> +                                    struct RamblockDirtyInfo *info,
>> +                                    struct DirtyRateConfig *config)
>> +{
>> +    uint64_t sample_pages_per_gigabytes = config->sample_pages_per_gigabytes;
>> +
>> +    /* Right shift 30 bits to calc ramblock size in GB */
>> +    info->sample_pages_count = (qemu_ram_get_used_length(block) *
>> +                                sample_pages_per_gigabytes) >> 30;
>> +    /* Right shift TARGET_PAGE_BITS to calc page count */
>> +    info->ramblock_pages = qemu_ram_get_used_length(block) >>
>> +                           TARGET_PAGE_BITS;
>> +    info->ramblock_addr = qemu_ram_get_host_addr(block);
>> +    strcpy(info->idstr, qemu_ram_get_idstr(block));
>> +}
>> +
>> +static bool record_ramblock_hash_info(struct RamblockDirtyInfo **block_dinfo,
>> +                                      struct DirtyRateConfig config,
>> +                                      int *block_index)
>> +{
>> +    struct RamblockDirtyInfo *info = NULL;
>> +    struct RamblockDirtyInfo *dinfo = NULL;
>> +    RAMBlock *block = NULL;
>> +    int total_index = 0;
> 
> Maybe 'total_count' better?
> 
>> +    int index = 0;
>> +    bool ret = true;
>> +
>> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
>> +        total_index++;
>> +    }
>> +
>> +    dinfo = g_try_malloc0_n(total_index, sizeof(struct RamblockDirtyInfo));
>> +    if (dinfo == NULL) {
>> +        total_index = 0;
> 
> No need to set 'total_index'.
> In the end use the 'index'.
> 
>> +        ret = false;
>> +        goto out;
>> +    }
>> +
>> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
>> +        if (index >= total_index) {
>> +            break;
>> +        }
>> +        info = &dinfo[index];
>> +        get_ramblock_dirty_info(block, info, &config);
>> +        if (!save_ramblock_hash(info)) {
>> +            ret = false;
>> +            goto out;
>> +        }
>> +        index++;
>> +    }
>> +
>> +out:
>> +    *block_index = total_index;
> 
> Here 'total_index' should be 'index'?
> 
Hi, Qiang.
Thanks for your review.
Yes, it should be index:), will fix in V9

> In general I think this two iteration version is more understandable
> that last one.
> 
> Thanks,
> Li Qiang
> 
>> +    *block_dinfo = dinfo;
>> +    return ret;
>> +}
>> +
>>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>>  {
>>      /* todo */
>> --
>> 1.8.3.1
>>
> .
> 

