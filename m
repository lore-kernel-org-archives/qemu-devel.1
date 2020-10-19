Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0730C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 03:31:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4524D22260
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 03:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4524D22260
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kULtc-0000vW-8z
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 23:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yubihong@huawei.com>)
 id 1kULso-0000S5-8B
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 23:30:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52844 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yubihong@huawei.com>)
 id 1kULsk-0000W5-NQ
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 23:30:49 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 9EC25EE67AD099E54427;
 Mon, 19 Oct 2020 11:30:27 +0800 (CST)
Received: from [10.174.186.14] (10.174.186.14) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Mon, 19 Oct 2020 11:30:21 +0800
Subject: Re: [PATCH v1] migration: using trace_ to replace DPRINTF
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 <quintela@redhat.com>, <eblake@redhat.com>, <dgilbert@redhat.com>,
 <berrange@redhat.com>
References: <1602927347-15669-1-git-send-email-yubihong@huawei.com>
 <1bd1c3f7-4c88-c93f-127c-9576fed176c7@redhat.com>
From: Bihong Yu <yubihong@huawei.com>
Message-ID: <6e93294c-a7d9-2853-d902-8d479bccdd1d@huawei.com>
Date: Mon, 19 Oct 2020 11:30:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1bd1c3f7-4c88-c93f-127c-9576fed176c7@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.186.14]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=yubihong@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 23:30:28
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: david.edmondson@oracle.com, zhang.zhanghailiang@huawei.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, alex.chen@huawei.com,
 wanghao232@huawei.com, zhengchuan@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thank you for your review.OK ,I will adapt them.

On 2020/10/17 17:57, Philippe Mathieu-Daudé wrote:
> On 10/17/20 11:35 AM, Bihong Yu wrote:
>> Signed-off-by: Bihong Yu <yubihong@huawei.com>
>> ---
>>   migration/block.c      | 36 ++++++++++++++++++------------------
>>   migration/page_cache.c | 13 +++----------
>>   migration/trace-events | 13 +++++++++++++
>>   3 files changed, 34 insertions(+), 28 deletions(-)
> ...
>> diff --git a/migration/trace-events b/migration/trace-events
>> index 338f38b..772bb81 100644
>> --- a/migration/trace-events
>> +++ b/migration/trace-events
>> @@ -325,3 +325,16 @@ get_ramblock_vfn_hash(const char *idstr, uint64_t vfn, uint32_t crc) "ramblock n
>>   calc_page_dirty_rate(const char *idstr, uint32_t new_crc, uint32_t old_crc) "ramblock name: %s, new crc: %" PRIu32 ", old crc: %" PRIu32
>>   skip_sample_ramblock(const char *idstr, uint64_t ramblock_size) "ramblock name: %s, ramblock size: %" PRIu64
>>   find_page_matched(const char *idstr) "ramblock %s addr or size changed"
>> +
>> +# block.c
>> +init_blk_migration_shared(const char *blk_device_name) "Start migration for %s with shared base image"
>> +init_blk_migration_full(const char *blk_device_name) "Start full migration for %s"
>> +mig_save_device_dirty(int64_t sector) "Error reading sector %" PRId64
>> +flush_blks(const char *action, int submitted, int read_done, int transferred) "%s submitted %d read_done %d transferred %d"
>> +block_save(const char *mig_stage, int submitted, int transferred) "Enter save live %s submitted %d transferred %d"
>> +block_save_complete(void) "Block migration completed"
>> +block_save_pending(uint64_t pending) "Enter save live pending  %" PRIu64
>> +
>> +# page_cache.c
>> +cache_init(int64_t max_num_items) "Setting cache buckets to %" PRId64
>> +cache_insert(void) "Error allocating page"
> 
> The patch is good, but I strongly recommend to have trace events
> starting with the subsystem prefix (here migration). So we can
> keep using the 'block*' rule to match all events from the block
> subsystem, without including the migration events.
> 
> Thanks,
> 
> Phil.
> 
> .

