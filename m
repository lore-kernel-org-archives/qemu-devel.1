Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF3EC388F9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 07:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3A2920870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 07:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A2920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaDZR-0000YL-Uj
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 02:51:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaihaoyu1@huawei.com>)
 id 1kaDYc-0008Nq-CS
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 02:50:14 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:2130)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaihaoyu1@huawei.com>)
 id 1kaDYZ-00071z-JF
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 02:50:13 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CQzMG70MLz72wq;
 Wed,  4 Nov 2020 15:49:46 +0800 (CST)
Received: from [10.108.235.54] (10.108.235.54) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 4 Nov 2020 15:49:39 +0800
Subject: Re: [PATCH v2 1/3] softmmu: Do not use C99 // comments
To: Markus Armbruster <armbru@redhat.com>
References: <160398385565.11191.16172040000588233087@66eaa9a8a123>
 <edcc3e56-2419-8645-8639-d9e50d710a1d@huawei.com>
 <87zh3zot3x.fsf@dusky.pond.sub.org>
From: chaihaoyu <chaihaoyu1@huawei.com>
Message-ID: <b062f265-db59-5ca9-7479-3ab7718180cd@huawei.com>
Date: Wed, 4 Nov 2020 15:49:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <87zh3zot3x.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.108.235.54]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=chaihaoyu1@huawei.com;
 helo=szxga07-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 02:49:55
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: alex.chen@huawei.com, pbonzini@redhat.com, zhang.zhanghailiang@huawei.com,
 qemu-devel@nongnu.org, hunongda@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thank you for your replay. That's OK if C99 support both kinds of comment style.

！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
> chaihaoyu <chaihaoyu1@huawei.com> writes:
> 
>> Hi, recently I found some code style problems while using checkpatch.pl tool,please review.
>>
>> Date: Tue, 3 Nov 2020 11:01:40 +0800
>> signed-off-by: Haoyu Chai<chaihaoyu1@huawei.com>
>> ---
>>  softmmu/memory.c         | 2 +-
>>  softmmu/memory_mapping.c | 2 +-
>>  softmmu/physmem.c        | 2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/softmmu/memory.c b/softmmu/memory.c
>> index 107ce0a4f8..5fb591b001 100644
>> --- a/softmmu/memory.c
>> +++ b/softmmu/memory.c
>> @@ -36,7 +36,7 @@
>>  #include "hw/boards.h"
>>  #include "migration/vmstate.h"
>>
>> -//#define DEBUG_UNASSIGNED
>> +/* #define DEBUG_UNASSIGNED */
>>
>>  static unsigned memory_region_transaction_depth;
>>  static bool memory_region_update_pending;
>> diff --git a/softmmu/memory_mapping.c b/softmmu/memory_mapping.c
>> index 18d0b8067c..f64053499e 100644
>> --- a/softmmu/memory_mapping.c
>> +++ b/softmmu/memory_mapping.c
>> @@ -19,7 +19,7 @@
>>  #include "exec/memory.h"
>>  #include "exec/address-spaces.h"
>>
>> -//#define DEBUG_GUEST_PHYS_REGION_ADD
>> +/* #define DEBUG_GUEST_PHYS_REGION_ADD */
>>
>>  static void memory_mapping_list_add_mapping_sorted(MemoryMappingList *list,
>>                                                     MemoryMapping *mapping)
>> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
>> index 44ffb60b5d..78c1b6580a 100644
>> --- a/softmmu/physmem.c
>> +++ b/softmmu/physmem.c
>> @@ -75,7 +75,7 @@
>>  #include <daxctl/libdaxctl.h>
>>  #endif
>>
>> -//#define DEBUG_SUBPAGE
>> +/* #define DEBUG_SUBPAGE */
>>
>>  /* ram_list is read under rcu_read_lock()/rcu_read_unlock().  Writes
>>   * are protected by the ramlist lock.
> 
> I recommend to leave these alone.
> 
> CODING_STYLE.rst:
> 
>     Rationale: The // form is valid in C99, so this is purely a matter of
>     consistency of style. The checkpatch script will warn you about this.
> 
> For "real" comments, we overwhelmingly use /* */, and avoiding // makes
> sense.  Most exceptions are in code we copy from elsewhere, such as
> disas/libvixl/.
> 
> For commenting out *code*, we use both forms.  Here are the counts for
> commenting out macro definitions:
> 
>     $ git-grep '^/\* *# *define' | wc -l
>     125
>     $ git-grep '^// *# *define' | wc -l
>     192
> 
> .
> 

