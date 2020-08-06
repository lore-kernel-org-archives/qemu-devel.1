Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BDAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:00:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D907922D02
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D907922D02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3aU0-0000Ke-Md
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 03:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k3aSy-0007Vt-3T
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 03:37:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4228 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k3aSv-0002Oc-9A
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 03:37:31 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 5DBD755802E3349E049F;
 Thu,  6 Aug 2020 15:37:25 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.4) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Thu, 6 Aug 2020
 15:37:16 +0800
From: Zheng Chuan <zhengchuan@huawei.com>
Subject: Re: [RFC PATCH 4/8] migration/dirtyrate: Record hash results for each
 ramblock
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1595646669-109310-1-git-send-email-zhengchuan@huawei.com>
 <1595646669-109310-5-git-send-email-zhengchuan@huawei.com>
 <20200804170033.GG2659@work-vm>
Message-ID: <780f2f72-8033-30c8-5861-dbd300e9ebb3@huawei.com>
Date: Thu, 6 Aug 2020 15:37:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200804170033.GG2659@work-vm>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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



On 2020/8/5 1:00, Dr. David Alan Gilbert wrote:
> * Chuan Zheng (zhengchuan@huawei.com) wrote:
>> From: Zheng Chuan <zhengchuan@huawei.com>
>>
>> Record hash results for each ramblock.
> 
> Please be careful when talking about 'ramblock' since we already use
> that for a chunk of memory in QEMU.
> 
>> Signed-off-by: Zheng Chuan <zhengchuan@huawei.com>
>> Signed-off-by: YanYing Zhang <ann.zhuangyanying@huawei.com>
>> ---
>>  migration/dirtyrate.c | 157 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  migration/dirtyrate.h |   1 +
>>  2 files changed, 158 insertions(+)
>>
>> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
>> index 6baf674..45cfc91 100644
>> --- a/migration/dirtyrate.c
>> +++ b/migration/dirtyrate.c
>> @@ -10,12 +10,27 @@
>>   * See the COPYING file in the top-level directory.
>>   */
>>  
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "crypto/hash.h"
>> +#include "crypto/random.h"
>> +#include "qemu/config-file.h"
>> +#include "exec/memory.h"
>> +#include "exec/ramblock.h"
>> +#include "exec/target_page.h"
>> +#include "qemu/rcu_queue.h"
>> +#include "qapi/qapi-commands-migration.h"
>> +#include "migration.h"
>>  #include "dirtyrate.h"
>>  
>>  static uint64_t sample_pages_per_gigabytes = DIRTYRATE_DEFAULT_SAMPLE_PAGES;
>>  static struct dirtyrate_statistics dirty_stat;
>>  CalculatingDirtyRateStage calculating_dirty_rate_stage = CAL_DIRTY_RATE_INIT;
>>  
>> +#define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
>> +        INTERNAL_RAMBLOCK_FOREACH(block)                   \
>> +        if (!qemu_ram_is_migratable(block)) {} else
>> +
> 
> Instead of redefining this here, please move the existing definition up
> into migration/ram.h ?
> 

OK, i'll do that in V2.

>>  static void reset_dirtyrate_stat(void)
>>  {
>>      dirty_stat.total_dirty_samples = 0;
>> @@ -44,6 +59,148 @@ static void update_dirtyrate(int64_t msec)
>>      dirty_stat.dirty_rate = dirty_rate;
>>  }
>>  
>> +static int get_block_vfn_hash(struct block_dirty_info *info, unsigned long vfn,
>> +                              uint8_t **md, size_t *hash_len)
>> +{
>> +    struct iovec iov_array;
>> +    int ret = 0;
>> +    int nkey = 1;
>> +
>> +    iov_array.iov_base = info->block_addr +
>> +                         vfn * DIRTYRATE_SAMPLE_PAGE_SIZE;
>> +    iov_array.iov_len = DIRTYRATE_SAMPLE_PAGE_SIZE;
> 
> I'm a bit confused by how this is working; is 'vfn' an index
> in SAMPLE_PAGE_SIZE's rather than individual pages? So this is
> going to hash over something the size of a 'DIRTYRATE_SAMPLE_PAGE_SIZE'?
> 
Here is how sampling works for example.
1. assume block length is 1G, take 256 pages (sample_pages_count = 256) for sampling.
2. acquire rand_buf[256] and get 256 random pages over ramblock with "rand_buf[i] % info->block_pages;"
3. get hash results of 4K length for all 256 pages by qcrypto_hash_bytesv();
4. get hash results of 4K length for all 256 pages by qcrypto_hash_bytesv() again after sleep 1s;
5. compare hash results, and judge if it is the dirty during the sleep time;
6. calculate dirty rate.

Thus, vfn is an index, and we acquire hash result of the DIRTYRATE_SAMPLE_PAGE_SIZE length memory which starts from iov_base.

>> +    if (qcrypto_hash_bytesv(QCRYPTO_HASH_ALG_MD5,
>> +                            &iov_array, nkey,
>> +                            md, hash_len, NULL) < 0) {
>> +        ret = -1;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static int save_block_hash(struct block_dirty_info *info)
>> +{
>> +    unsigned long *rand_buf = NULL;
>> +    unsigned int sample_pages_count;
>> +    uint8_t *md = NULL;
>> +    size_t hash_len;
>> +    int i;
>> +    int ret = -1;
>> +
>> +    sample_pages_count = info->sample_pages_count;
>> +    /* block size less than one page, return success to skip this block */
>> +    if (unlikely(info->block_pages == 0 || sample_pages_count == 0)) {
>> +        ret = 0;
>> +        goto out;
>> +    }
>> +
>> +    /* use random bytes to pick sample page vfn */
>> +    rand_buf = g_malloc0_n(sample_pages_count, sizeof(unsigned long));
>> +    /* DEFAULT_READ_RANDOM_MAX_LIMIT 32M,
>> +     * can support 4T vm 1024 sample_pages_per_gigabytes
>> +     */
>> +    ret = qcrypto_random_bytes((unsigned char *)rand_buf,
>> +                               sample_pages_count * sizeof(unsigned long),
>> +                               NULL);
> 
> I think there may be a different way to do this without having to store
> the rand_buf.
> We already link to glib, and glib has a PRNG; https://developer.gnome.org/glib/stable/glib-Random-Numbers.html
> If you create a new prng is g_rand_new() at the start of day, and take a
> copy with g_rand_copy(), then you can replay the sequence of random
> numbers it generates without actually storing the sequence.
> So g_rand_new(), g_rand_copy() and then before you traverse the set of
> pages you go and take a copy again and use the copy; it'll give the same
> sequence every time.
> 
> Note also, because you're allocating a potentially large array,
> for this and the hash_result please use g_try_malloc0_n (or g_try_new0)
> and fail properly if it returns NULL.
> 
Sure, i'll consider that in V2.

> Note we have users with more than 4T of RAM in their VMs, although I
> doubt in a single RAMBlock
> 
>> +    if (ret) {
>> +        ret = -1;
>> +        goto out;
>> +    }
>> +
>> +    hash_len = qcrypto_hash_digest_len(QCRYPTO_HASH_ALG_MD5);
>> +    info->hash_result = g_malloc0_n(sample_pages_count, sizeof(uint8_t) * hash_len);
>> +    info->sample_page_vfn = g_malloc0_n(sample_pages_count, sizeof(unsigned long));
>> +
>> +    for (i = 0; i < sample_pages_count; i++) {
>> +        md = info->hash_result + i * hash_len;
>> +        info->sample_page_vfn[i] = rand_buf[i] % info->block_pages;
>> +        ret = get_block_vfn_hash(info, info->sample_page_vfn[i], &md, &hash_len);
>> +        if (ret < 0) {
>> +            goto out;
>> +        }
>> +    }
>> +    ret = 0;
>> +out:
>> +    g_free(rand_buf);
>> +    return ret;
>> +}
>> +
>> +static void get_block_dirty_info(RAMBlock *block, struct block_dirty_info *info,
>> +                                 struct dirtyrate_config *config)
>> +{
>> +    uint64_t sample_pages_per_gigabytes = config->sample_pages_per_gigabytes;
>> +
>> +    /* Right shift 30 bits to calc block size in GB */
>> +    info->sample_pages_count = (qemu_ram_get_used_length(block) * sample_pages_per_gigabytes) >> 30;
>> +
>> +    info->block_pages = qemu_ram_get_used_length(block) >> DIRTYRATE_PAGE_SIZE_SHIFT;
>> +    info->block_addr = qemu_ram_get_host_addr(block);
>> +    strcpy(info->idstr, qemu_ram_get_idstr(block));
>> +}
>> +
>> +static struct block_dirty_info *
>> +alloc_block_dirty_info(int *block_index,
>> +                       struct block_dirty_info *block_dinfo)
>> +{
>> +    struct block_dirty_info *info = NULL;
>> +    int index = *block_index;
>> +
>> +    if (!block_dinfo) {
>> +        block_dinfo = g_new(struct block_dirty_info, 1);
>> +        index = 0;
>> +    } else {
>> +        block_dinfo = g_realloc(block_dinfo, (index + 1) *
>> +                                sizeof(struct block_dirty_info));
>> +        index++;
> 
> I think g_realloc works on a NULL pointer, so you might be able to
> simplify.
> 
>> +    }
>> +    info = &block_dinfo[index];
>> +    memset(info, 0, sizeof(struct block_dirty_info));
>> +
>> +    *block_index = index;
>> +    return block_dinfo;
>> +}
>> +
>> +static int ram_block_skip(RAMBlock *block)
>> +{
>> +    if (!strstr(qemu_ram_get_idstr(block), "ram-node") &&
>> +        !strstr(qemu_ram_get_idstr(block), "memdimm")) {
>> +        if (strcmp(qemu_ram_get_idstr(block), "mach-virt.ram") ||
>> +            strcmp(block->idstr, "pc.ram")) {
>> +            return -1;
>> +        }
>> +    }
> 
> We can't tie this to the names you guess that RAMBlocks might have - 
> things like 'memdimm' are settable by the caller and can be anything,
> so you need to picka  different way of chosing which RAMBlocks to
> use; I suggest anything larger than some cutoff size, that's really RAM.
> 
OK, i'll consider it in a general way.
>> +    return 0;
>> +}
>> +
>> +static int record_block_hash_info(struct dirtyrate_config config,
>> +                                  struct block_dirty_info **block_dinfo, int *block_index)
>> +{
>> +    struct block_dirty_info *info = NULL;
>> +    struct block_dirty_info *dinfo = NULL;
>> +    RAMBlock *block = NULL;
>> +    int index = 0;
>> +
>> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
>> +        if (ram_block_skip(block) < 0) {
>> +            continue;
>> +        }
>> +        dinfo = alloc_block_dirty_info(&index, dinfo);
>> +        info = &dinfo[index];
>> +        get_block_dirty_info(block, info, &config);
>> +        if (save_block_hash(info) < 0) {
>> +            *block_dinfo = dinfo;
>> +            *block_index = index;
>> +            return -1;
>> +        }
>> +    }
>> +
>> +    *block_dinfo = dinfo;
>> +    *block_index = index;
>> +
>> +    return 0;
>> +}
>>  
>>  static void calculate_dirtyrate(struct dirtyrate_config config, int64_t time)
>>  {
>> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
>> index 2994535..4d9b3b8 100644
>> --- a/migration/dirtyrate.h
>> +++ b/migration/dirtyrate.h
>> @@ -15,6 +15,7 @@
>>  
>>  /* take 256 pages per GB for cal dirty rate */
>>  #define DIRTYRATE_DEFAULT_SAMPLE_PAGES    256
>> +#define DIRTYRATE_SAMPLE_PAGE_SIZE      4096
>>  #define DIRTYRATE_PAGE_SIZE_SHIFT       12
>>  #define BLOCK_INFO_MAX_LEN              256
>>  #define PAGE_SIZE_SHIFT                 20
>> -- 
>> 1.8.3.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> 
> .
> 


