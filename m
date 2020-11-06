Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC6CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 06:25:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF04206F9
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 06:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF04206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kavBs-0006es-Hs
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 01:25:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kavAu-0006B0-UI
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 01:24:40 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:2079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kavAs-0002vy-KO
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 01:24:40 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CS9Mz3RtpzhhMS;
 Fri,  6 Nov 2020 14:24:31 +0800 (CST)
Received: from [10.174.186.51] (10.174.186.51) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Fri, 6 Nov 2020 14:24:26 +0800
Subject: Re: [PATCH] migration/dirtyrate: simplify inlcudes in dirtyrate.c
To: Mark Kanda <mark.kanda@oracle.com>, <quintela@redhat.com>,
 <dgilbert@redhat.com>
References: <1604030281-112946-1-git-send-email-zhengchuan@huawei.com>
 <e19ac83b-dc05-a783-cb30-e09d592f6a8f@oracle.com>
From: Zheng Chuan <zhengchuan@huawei.com>
Message-ID: <a0f1a800-e9dc-d5df-6082-ffdcd5b8dfc5@huawei.com>
Date: Fri, 6 Nov 2020 14:24:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <e19ac83b-dc05-a783-cb30-e09d592f6a8f@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.186.51]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=zhengchuan@huawei.com;
 helo=szxga06-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 01:15:26
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: yubihong@huawei.com, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, alex.chen@huawei.com, wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kindly ping for not forgetting this trivial fix:)

On 2020/10/30 22:09, Mark Kanda wrote:
> On 10/29/2020 10:58 PM, Chuan Zheng wrote:
>> Remove redundant blank line which is left by Commit 662770af7c6e8c,
>> also take this opportunity to remove redundant includes in dirtyrate.c.
>>
>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> 
> Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
> 
>> ---
>>   migration/dirtyrate.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
>> index 8f728d2..ccb9814 100644
>> --- a/migration/dirtyrate.c
>> +++ b/migration/dirtyrate.c
>> @@ -11,17 +11,12 @@
>>    */
>>     #include "qemu/osdep.h"
>> -
>>   #include <zlib.h>
>>   #include "qapi/error.h"
>>   #include "cpu.h"
>> -#include "qemu/config-file.h"
>> -#include "exec/memory.h"
>>   #include "exec/ramblock.h"
>> -#include "exec/target_page.h"
>>   #include "qemu/rcu_queue.h"
>>   #include "qapi/qapi-commands-migration.h"
>> -#include "migration.h"
>>   #include "ram.h"
>>   #include "trace.h"
>>   #include "dirtyrate.h"
>>

-- 
Regards.
Chuan

