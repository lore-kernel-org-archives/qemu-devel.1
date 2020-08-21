Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6553C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:01:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC76207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC76207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k93rQ-0001tX-QQ
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k93q7-0000ba-NX
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:00:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4261 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k93q5-0006xu-6R
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:00:03 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id DFEE79EABA96FE4E3528;
 Fri, 21 Aug 2020 17:59:51 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.4) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 21 Aug 2020
 17:59:42 +0800
From: Zheng Chuan <zhengchuan@huawei.com>
Subject: Re: [PATCH v3 01/10] migration/dirtyrate: Add get_dirtyrate_thread()
 function
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1597634433-18809-1-git-send-email-zhengchuan@huawei.com>
 <1597634433-18809-2-git-send-email-zhengchuan@huawei.com>
 <20200820161137.GI2664@work-vm>
Message-ID: <64065388-5a72-f0d7-e1b8-af18631b2dfb@huawei.com>
Date: Fri, 21 Aug 2020 17:59:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200820161137.GI2664@work-vm>
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



On 2020/8/21 0:11, Dr. David Alan Gilbert wrote:
> * Chuan Zheng (zhengchuan@huawei.com) wrote:
>> Add get_dirtyrate_thread() functions
>>
>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
>> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
>> ---
>>  migration/Makefile.objs |  1 +
>>  migration/dirtyrate.c   | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  migration/dirtyrate.h   | 44 ++++++++++++++++++++++++++++++++++
>>  3 files changed, 109 insertions(+)
>>  create mode 100644 migration/dirtyrate.c
>>  create mode 100644 migration/dirtyrate.h
>>
>> diff --git a/migration/Makefile.objs b/migration/Makefile.objs
>> index 0fc619e..12ae98c 100644
>> --- a/migration/Makefile.objs
>> +++ b/migration/Makefile.objs
>> @@ -6,6 +6,7 @@ common-obj-y += qemu-file.o global_state.o
>>  common-obj-y += qemu-file-channel.o
>>  common-obj-y += xbzrle.o postcopy-ram.o
>>  common-obj-y += qjson.o
>> +common-obj-y += dirtyrate.o
>>  common-obj-y += block-dirty-bitmap.o
>>  common-obj-y += multifd.o
>>  common-obj-y += multifd-zlib.o
>> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
>> new file mode 100644
>> index 0000000..bb0ebe9
>> --- /dev/null
>> +++ b/migration/dirtyrate.c
>> @@ -0,0 +1,64 @@
>> +/*
>> + * Dirtyrate implement code
>> + *
>> + * Copyright (c) 2017-2020 HUAWEI TECHNOLOGIES CO.,LTD.
>> + *
>> + * Authors:
>> + *  Chuan Zheng <zhengchuan@huawei.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
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
>> +#include "dirtyrate.h"
>> +
>> +CalculatingDirtyRateState CalculatingState = CAL_DIRTY_RATE_INIT;
>> +
>> +static int dirty_rate_set_state(int new_state)
>> +{
>> +    int old_state = CalculatingState;
>> +
>> +    if (new_state == old_state) {
>> +        return -1;
>> +    }
>> +
>> +    if (atomic_cmpxchg(&CalculatingState, old_state, new_state) != old_state) {
>> +        return -1;
>> +    }
> 
> This is a little unusual; this has removed your comment from v1 about
> what you're trying to protect; but not quite being clear about what it's
> doing.
> 
> I think what you want here is closer to migrate_set_state, ie you
> pass what you think the old state is, and the state you want to go to.
> 
Hi, Dave.
Thank you for your review.

Yes, what I want to do is to protect concurrent scene lockless, i'll rewrite
according to migrate_set_state().


>> +    return 0;
>> +}
>> +
>> +static void calculate_dirtyrate(struct DirtyRateConfig config)
>> +{
>> +    /* todo */
>> +    return;
>> +}
>> +
>> +void *get_dirtyrate_thread(void *arg)
>> +{
>> +    struct DirtyRateConfig config = *(struct DirtyRateConfig *)arg;
>> +    int ret;
>> +
>> +    ret = dirty_rate_set_state(CAL_DIRTY_RATE_ACTIVE);
> 
> so this would become:
>     ret = dirty_rate_set_state(CAL_DIRTY_RATE_INIT,
>               CAL_DIRTY_RATE_ACTIVE);
> 
>> +    if (ret == -1) {
>> +        return NULL;
>> +    }
>> +
>> +    calculate_dirtyrate(config);
>> +
>> +    ret = dirty_rate_set_state(CAL_DIRTY_RATE_END);
>> +
>> +    return NULL;
>> +}
>> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
>> new file mode 100644
>> index 0000000..914c363
>> --- /dev/null
>> +++ b/migration/dirtyrate.h
>> @@ -0,0 +1,44 @@
>> +/*
>> + *  Dirtyrate common functions
>> + *
>> + *  Copyright (c) 2020 HUAWEI TECHNOLOGIES CO., LTD.
>> + *
>> + *  Authors:
>> + *  Chuan Zheng <zhengchuan@huawei.com>
>> + *
>> + *  This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + *  See the COPYING file in the top-level directory.
>> + */
>> +
>> +#ifndef QEMU_MIGRATION_DIRTYRATE_H
>> +#define QEMU_MIGRATION_DIRTYRATE_H
>> +
>> +/*
>> + * Sample 256 pages per GB as default.
>> + * TODO: Make it configurable.
>> + */
>> +#define DIRTYRATE_DEFAULT_SAMPLE_PAGES            256
>> +
>> +/* Take 1s as default for calculation duration */
>> +#define DEFAULT_FETCH_DIRTYRATE_TIME_SEC          1
>> +
>> +struct DirtyRateConfig {
>> +    uint64_t sample_pages_per_gigabytes; /* sample pages per GB */
>> +    int64_t sample_period_seconds; /* time duration between two sampling */
>> +};
>> +
>> +/*
>> + *  To record calculate dirty_rate status:
>> + *  0: initial status, calculating thread is not be created here.
>> + *  1: calculating thread is created.
>> + *  2: calculating thread is end, we can get result.
>> + */
>> +typedef enum {
>> +    CAL_DIRTY_RATE_INIT = 0,
>> +    CAL_DIRTY_RATE_ACTIVE,
>> +    CAL_DIRTY_RATE_END,
>> +} CalculatingDirtyRateState;
>> +
>> +void *get_dirtyrate_thread(void *arg);
>> +#endif
>> +
>> -- 
>> 1.8.3.1
>>


