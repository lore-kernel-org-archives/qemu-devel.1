Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405E2C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 11:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10C7C2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 11:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C7C2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kChgz-00039O-54
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 07:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kChfd-0000rn-GP
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 07:08:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51332 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kChfa-0000V8-K3
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 07:08:17 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 1682F51EB1C6F092CBFA;
 Mon, 31 Aug 2020 19:08:09 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.4) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Mon, 31 Aug 2020
 19:07:59 +0800
Subject: Re: [PATCH v6 01/12] migration/dirtyrate: setup up query-dirtyrate
 framwork
To: David Edmondson <david.edmondson@oracle.com>, <quintela@redhat.com>,
 <eblake@redhat.com>, <dgilbert@redhat.com>, <berrange@redhat.com>
References: <1598669577-76914-1-git-send-email-zhengchuan@huawei.com>
 <1598669577-76914-2-git-send-email-zhengchuan@huawei.com>
 <m2lfhvci17.fsf@oracle.com>
From: Zheng Chuan <zhengchuan@huawei.com>
Message-ID: <110f5a93-6bc4-4079-8e69-31aac0e51ee6@huawei.com>
Date: Mon, 31 Aug 2020 19:07:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <m2lfhvci17.fsf@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.4]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=zhengchuan@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 07:08:09
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.13,
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
Cc: alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 zhang.zhanghailiang@huawei.com, xiexiangyou@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/8/31 16:54, David Edmondson wrote:
> On Saturday, 2020-08-29 at 10:52:46 +08, Chuan Zheng wrote:
> 
>> Add get_dirtyrate_thread() functions to setup query-dirtyrate
>> framework.
>>
>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
>> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> Modulo the question below...
> 
> Reviewed-by: David Edmondson <david.edmondson@oracle.com>
> 
>> ---
>>  migration/dirtyrate.c | 38 ++++++++++++++++++++++++++++++++++++++
>>  migration/dirtyrate.h | 29 +++++++++++++++++++++++++++++
>>  migration/meson.build |  2 +-
>>  3 files changed, 68 insertions(+), 1 deletion(-)
>>  create mode 100644 migration/dirtyrate.c
>>  create mode 100644 migration/dirtyrate.h
>>
>> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
>> new file mode 100644
>> index 0000000..44d673a
>> --- /dev/null
>> +++ b/migration/dirtyrate.c
>> @@ -0,0 +1,38 @@
>> +/*
>> + * Dirtyrate implement code
>> + *
>> + * Copyright (c) 2017-2020 HUAWEI TECHNOLOGIES CO.,LTD.
> 
> Idle query, given that I'm not a lawyer, has this code really been
> around since 2017?
> 
We have evaluated dirty rate by simulating dirtylog as qemu migration does in our first
inside-version since 2017, but it hurts vm performace, and the hash method replaced
the old method recently.
I will consider to write in since 2020, because it is indeed just refactored recently:)

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
>> +#include "cpu.h"
>> +#include "qemu/config-file.h"
>> +#include "exec/memory.h"
>> +#include "exec/ramblock.h"
>> +#include "exec/target_page.h"
>> +#include "qemu/rcu_queue.h"
>> +#include "qapi/qapi-commands-migration.h"
>> +#include "migration.h"
>> +#include "dirtyrate.h"
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
>> +
>> +    calculate_dirtyrate(config);
>> +
>> +    return NULL;
>> +}
>> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
>> new file mode 100644
>> index 0000000..5be9714
>> --- /dev/null
>> +++ b/migration/dirtyrate.h
>> @@ -0,0 +1,29 @@
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
>> + * Sample 512 pages per GB as default.
>> + * TODO: Make it configurable.
>> + */
>> +#define DIRTYRATE_DEFAULT_SAMPLE_PAGES            512
>> +
>> +struct DirtyRateConfig {
>> +    uint64_t sample_pages_per_gigabytes; /* sample pages per GB */
>> +    int64_t sample_period_seconds; /* time duration between two sampling */
>> +};
>> +
>> +void *get_dirtyrate_thread(void *arg);
>> +#endif
>> +
>> diff --git a/migration/meson.build b/migration/meson.build
>> index ac8ff14..b5b71c8 100644
>> --- a/migration/meson.build
>> +++ b/migration/meson.build
>> @@ -37,4 +37,4 @@ softmmu_ss.add(when: ['CONFIG_RDMA', rdma], if_true: files('rdma.c'))
>>  softmmu_ss.add(when: 'CONFIG_LIVE_BLOCK_MIGRATION', if_true: files('block.c'))
>>  softmmu_ss.add(when: 'CONFIG_ZSTD', if_true: [files('multifd-zstd.c'), zstd])
>>  
>> -specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files('ram.c'))
>> +specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files('dirtyrate.c', 'ram.c'))
>> -- 
>> 1.8.3.1
> 
> dme.
> 


