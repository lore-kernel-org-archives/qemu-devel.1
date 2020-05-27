Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE9BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 11:25:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01542206DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 11:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eO4vB/xS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01542206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jduBo-0001Jr-6n
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 07:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jduB5-0008JS-Py; Wed, 27 May 2020 07:24:55 -0400
Received: from mail-eopbgr70131.outbound.protection.outlook.com
 ([40.107.7.131]:13637 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jduB2-0006cJ-QO; Wed, 27 May 2020 07:24:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcvGqr5Hf/a9Pe4QqSJcN8LVA3RGIRSS5TPJexDDT6gt1IxMo3pqpCLyDQZUx19gp6+6On51kyp+7bl0BPLJ+Olh5Nj3TAktL84xrfIoBzZyoviYrsYmt9WkTiWkROc/5/To7YtwbDkBNenjkuTxX2iBRMx/L4mfYSecJQjjqtqphGWvh07XxCGs4wGNZ1BmPqNsLY7zC5RcidRMOBseESZPRc5nb2jl/kxjW+mgQYdVyFlRWo2hM8zfvcMb7FoKUBu/vPxFAMXch05GPo8L+sIdHFsN9Q5c+9Av9Sao7Ua/92LM8OInUyyxPTNT1Z96mAa31Rg9XK9JYEtYxG9fjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJ1OJ6O30aJy74r+aqsf6XkElAbpJXq3Ib2AWegqciE=;
 b=Q3H/ZPE3Rgp3gqofTR4c4M4fEyRpFpFjSlqwn/+NrG2wXuqLKPnulMB7BVaKcKclD/mOaBDYMkmw42/W3Xjm9c9l/WpaGo0M8l9n29DdTRLVQrhv6iIBYU3i+BnDg+eCVzOn/HHno40qrcCPU0NnBf31EG7UxUsBWT9OT09BHEqhoDy/1p+zfadoZw/HFY3c/HT7rRkZE/aHeMBKVOCXLS/MrkWwzUKM3HonyMtaXSE5KfO5htq5OKKkPz3Q4FWOHCze42GaL49K1ffT6/82++OC2wNNsoemK+TWCVy4Zdm5p7a3tXdGXJ0v4xy9EBluBRfipD1KRQJfmJVSmx7wgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJ1OJ6O30aJy74r+aqsf6XkElAbpJXq3Ib2AWegqciE=;
 b=eO4vB/xS7kYp1Z02l1UjbG4ZLz+2Xz0WPK1johCbqxgZhySlK6Jty/lVVH2x29wc8TuB2o5+O0dVJkTuXVtkk9ylJgNuaI1+qqCQFA4CXDaucph9JostYMk4dR+zAWiyfEXfu9LdjJHR/lPOyiuGx1wI10l3yVxd67MtESoY6ck=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5528.eurprd08.prod.outlook.com (2603:10a6:20b:dd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Wed, 27 May
 2020 11:24:49 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 11:24:49 +0000
Subject: Re: [PATCH v4 3/5] block: generate coroutine-wrapper code
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200525100801.13859-1-vsementsov@virtuozzo.com>
 <20200525100801.13859-4-vsementsov@virtuozzo.com>
 <7cd429d4-d346-b019-3f72-e98fa55593f9@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <3a744e13-dea5-65f2-d44a-d70a67a208ad@virtuozzo.com>
Date: Wed, 27 May 2020 14:24:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <7cd429d4-d346-b019-3f72-e98fa55593f9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0P190CA0020.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.148) by
 AM0P190CA0020.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17 via Frontend Transport; Wed, 27 May 2020 11:24:48 +0000
X-Originating-IP: [185.215.60.148]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d96e6c5-7e49-4a86-8803-08d802309100
X-MS-TrafficTypeDiagnostic: AM7PR08MB5528:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB552856B0BF5BE552F67CA1F6C1B10@AM7PR08MB5528.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rlHmIGvVImB021GWhszW+xjXoAxmC1jc5hbdbay4nmMu9zzevCnnGxW+NtcopQJ023IMtldw3aEZMerg3FyRMFtkpJ8GZ7D6pgs1pjnEgGTGeNN6ht6r8mRxNbpwYG0iY2QDlg1RYRNppYSknsg+u0iLM3n1GVpmfmrynOm8NS0U7YKTtUfAQRvSq0EdZwn7awFvorgJM+x1F4faIaiTLp7VhuXFswJqvz2B5acgDpcNQBywjrQWKWLw4iiL3YA8XSrAvdh0iluvVg7kTUH+FD42xFNW/cDzgBVdS98PPmqJoikaoURyENtmlWRolog+uiVcGl3Xo1w75j4n7Sfs6M13zFz2gXZHpT0c1E2io2i4zGtLhG0zmmVY0/iaUm/8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(346002)(136003)(39840400004)(396003)(6486002)(5660300002)(36756003)(86362001)(4326008)(8936002)(8676002)(478600001)(316002)(16526019)(31696002)(53546011)(186003)(26005)(30864003)(31686004)(16576012)(66556008)(66946007)(66476007)(2906002)(107886003)(956004)(2616005)(83380400001)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: lCL4HvsIlI2FkfPc+I49q+IpcsZIbVrS0BvGbh4epmh4OucX3ogz5+33HUtmDlZ8vUeH34bFR25c5hxGs7n+TAp/Go0CUp8mE2AyzceWDuB+kYW2RGoCyZwPqjt6eZ3Pdzt8UqRxhQiFfvo3eXi6P0vbUT2HmZo4b2bf89yoryCUzJfArRd/hg1HJktR3jwk63NV1bBcIX7VoI2wNmKGuEuaeWueSvMhLgoGbbCvq7jFI9N/sPUAMe6ws3EEVRbbr67Soopd6bpOX4f13fqgw67akpvEusLDpAd7Wh2Il23rsTxW+QuZCRvDrMhyj4HdVDQilCLBJNINa1QbpBKp9m6OY4NAlH98FkRxJZMxbcKNMkXHjH+HhT7GbjalhgWSFmxqc6PQlFRtRBLVpixPYE5FO05UOBSRcpZErynDQUh027SV2XKC6EH55NlULKD++mzmdzjk2ZlciWoph9Pzd4bFvrhqwnw0KhJSOEXjSBMVMC5N8Csxrf4Cb7+2Ogos
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d96e6c5-7e49-4a86-8803-08d802309100
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 11:24:48.9731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gaavy+SY6L7LTpgenU9rP/GjzwEkd7/KvaPJOVF7rxtzwVaEuNqrwe8iJ7e3TCUNub/aOMVv7sYAaat8LJlKtonA7E6taIsH9z3j05cxjxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5528
Received-SPF: pass client-ip=40.107.7.131;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 07:24:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, ehabkost@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.05.2020 00:30, Eric Blake wrote:
> On 5/25/20 5:07 AM, Vladimir Sementsov-Ogievskiy wrote:
>> We have a very frequent pattern of creating coroutine from function
>> with several arguments:
>>
>>    - create structure to pack parameters
>>    - create _entry function to call original function taking parameters
>>      from struct
>>    - do different magic to handle completion: set ret to NOT_DONE or
>>      EINPROGRESS, use separate bool for void functions
>>    - fill the struct and create coroutine from _entry function and this
>>      struct as a parameter
>>    - do coroutine enter and BDRV_POLL_WHILE loop
>>
>> Let's reduce code duplication. Here:
>>
>> Functional part (BDRV_POLL_WHILE loop, aio_wait_kick()) moved to
>> (non-generated) block/block-gen.h
>>
>> Mechanical part (arguments packing, different kind of needed wrappers)
>> are generated from template by scripts/coroutine-wrapper.py to
>> resulting file block/block-gen.c
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
> 
>> @@ -175,6 +177,10 @@ generated-files-y += $(TRACE_SOURCES)
>>   generated-files-y += $(BUILD_DIR)/trace-events-all
>>   generated-files-y += .git-submodule-status
>> +COROUTINE_HEADERS = include/block/block.h block/coroutines.h
>> +block/block-gen.c: $(COROUTINE_HEADERS) $(SRC_PATH)/scripts/coroutine-wrapper.py
>> +    $(call quiet-command, cat $(COROUTINE_HEADERS) | $(SRC_PATH)/scripts/coroutine-wrapper.py > $@,"GEN","$(TARGET_DIR)$@")
>> +
> 
> Not VPATH-friendly; I posted a proposed fixup! separately.

Thanks!

> 
>>   trace-group-name = $(shell dirname $1 | sed -e 's/[^a-zA-Z0-9]/_/g')
>>   tracetool-y = $(SRC_PATH)/scripts/tracetool.py
>> diff --git a/Makefile.objs b/Makefile.objs
>> index 99774cfd25..8cb20f94c3 100644
>> --- a/Makefile.objs
>> +++ b/Makefile.objs
>> @@ -14,7 +14,7 @@ chardev-obj-y = chardev/
>>   authz-obj-y = authz/
>>   block-obj-y = block/ block/monitor/ nbd/ scsi/
>> -block-obj-y += block.o blockjob.o job.o
>> +block-obj-y += block.o blockjob.o job.o block/block-gen.o
> 
> It may be cleaner to add this in block/Makefile.objs rather than in top-level Makefile.objs.  In fact, rearranging your mail a bit...
> 
>  > diff --git a/block/Makefile.objs b/block/Makefile.objs
>  > index 3635b6b4c1..05e4d033c1 100644
>  > --- a/block/Makefile.objs
>  > +++ b/block/Makefile.objs
>  > @@ -45,6 +45,7 @@ block-obj-y += crypto.o
>  >   block-obj-y += aio_task.o
>  >   block-obj-y += backup-top.o
>  >   block-obj-y += filter-compress.o
>  > +block-obj-y += block-gen.o
>  >   common-obj-y += monitor/
>  >
>  >   block-obj-y += stream.o
> 
> ...you did just that.  Dropping the change to top-level Makefile.objs seems to make no difference to a correct build.

Oops, yes.

> 
>> +++ b/block/block-gen.h
>> @@ -0,0 +1,55 @@
>> +/*
>> + * Block layer I/O functions
> 
> Is this still the best one-line summary for this file?  Especially since...

Yes, it's outdated. Maybe

Block coroutine wrapping core, used by auto-generated block/block-gen.c

> 
>> +
>> +/* This function is called at the end of generated coroutine entries. */
>> +static inline void bdrv_poll_co__on_exit(void)
>> +{
>> +    aio_wait_kick();
>> +}
>> +
>> +/* Base structure for argument packing structures */
>> +typedef struct BdrvPollCo {
>> +    BlockDriverState *bs;
>> +    bool in_progress;
>> +    int ret;
>> +    Coroutine *co; /* Keep pointer here for debugging */
>> +} BdrvPollCo;
>> +
>> +static inline int bdrv_poll_co(BdrvPollCo *s)
>> +{
>> +    assert(!qemu_in_coroutine());
>> +
>> +    bdrv_coroutine_enter(s->bs, s->co);
>> +    BDRV_POLL_WHILE(s->bs, s->in_progress);
>> +
>> +    return s->ret;
>> +}
> 
> This part looks fine.
> 
> 
>> +++ b/include/block/generated-co-wrapper.h
>> @@ -0,0 +1,35 @@
>> +/*
>> + * Block layer I/O functions
> 
> ...you repeat it here?
> 
>> +/*
>> + * generated_co_wrapper
>> + * Function specifier, which does nothing but marking functions to be
>> + * generated by scripts/coroutine-wrapper.py
>> + */
>> +#define generated_co_wrapper
>> +
>> +#endif /* BLOCK_GENERATED_CO_WRAPPER_H */
> 
> Not sure if a separate header was needed for this, but I guess it doesn't hurt.  I might have just used block_int.h.

Than we'll have to include block_int.h in block.h.. Is it OK? This is the reason why I decided to keep it separate.

> 
>> diff --git a/block.c b/block.c
>> index 7f06e82880..c1132ab323 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -4640,43 +4640,6 @@ int coroutine_fn bdrv_co_check(BlockDriverState *bs,
>>       return bs->drv->bdrv_co_check(bs, res, fix);
>>   }
>> -typedef struct CheckCo {
>> -    BlockDriverState *bs;
>> -    BdrvCheckResult *res;
>> -    BdrvCheckMode fix;
>> -    int ret;
>> -} CheckCo;
> 
> This patch is doing two things - introducing a new generator script that scans the code for generated_co_wrapper tags, _and_ adds the tags in as many places as possible.  It makes for a big patch.  Better might have been to introduce the script and the concept of a tag in one patch but not actually tag any new functions (so the generated file is basically empty, but you prove the build works and can audit the script without being bogged down by the mechanical changes), then do a separate patch with adding the tags and deleting the code now covered by the generator (which will be mostly mechanical).

No problem, will do.

> 
>> +++ b/scripts/coroutine-wrapper.py
>> @@ -0,0 +1,168 @@
>> +#!/usr/bin/env python3
> 
> My python review skills are weak, so you'll probably want another reviewer here (although I _can_ state that I checked the generated block/block-gen.c file and it makes sense).
> 
> 
>> +import re
>> +from typing import List, Iterator
>> +
>> +header = '''/*
>> + * File is generated by scripts/coroutine-wrapper.py
>> + */
> 
> It's worth also generating a short copyright blurb into the generated file.
> 
>> +
>> +#include "qemu/osdep.h"
>> +#include "block/coroutines.h"
>> +#include "block/block-gen.h"'''
>> +
>> +template = """
> 
> Why ''' above and """ here?  While python accepts both forms, consistency is desirable.  I have no idea what pylint thinks of your code, though, so I may be completely overlooking idiomatic styles.
''' is used just to not interfer with " around include files.. So I tend to generally use """ for multiline strings, but the above is and exception just for internal " characters.

> 
>> +
>> +/*
>> + * Wrappers for $name$
>> + */
>> +
>> +typedef struct $struct_name$ {
>> +    BdrvPollCo poll_state;
>> +    $fields$
>> +} $struct_name$;
>> +
>> +static void coroutine_fn $name$_entry(void *opaque)
>> +{
>> +    $struct_name$ *s = opaque;
>> +
>> +    $assign_ret$$name$($args_from_s$);
> 
> Creates a long line. Doesn't matter since this is generated code, so I don't know if it's worth trying to coerce python into generating something that is wrapped nicely.
> 
>> +
>> +    s->poll_state.in_progress = false;
>> +
>> +    bdrv_poll_co__on_exit();
> 
> That function only calls aio_wait_kick().  Why did you not want to call that directly here, instead of going through such a one-line wrapper function?

To keep polling logic out of generated code, in block/block-gen.h, like bdrv_poll_co. Does it worth doing - I'm not sure. Up to maintainers.

> 
>> +}
>> +
>> +$ret_type$ $wrapper_name$($args_def$)
>> +{
>> +    if (qemu_in_coroutine()) {
>> +        $do_return$$name$($arg_names$);
> 
> Would it be any simpler to teach bdrv_co_invalidate_cache() to return a value, so that you can eliminate the need for $do_return$ and just hard-code 'return ' here?  The .bdrv_co_invalidate_cache driver callback can still return void, and just have the wrapper in block.c return 0. But if you want to do that, it would be a separate prerequisite patch.

Hmm. I thought, that it's not a good reason to add a always-success return value.. But stop! bdrv_invalidate_cache is a void functions with errp argument, so it makes sense to add a return value anyway. Will do.

> 
>> +    } else {
>> +        $struct_name$ s = {
>> +            .poll_state.bs = $bs$,
>> +            .poll_state.in_progress = true,
>> +
>> +            $initializers$
>> +        };
>> +
>> +        s.poll_state.co = qemu_coroutine_create($name$_entry, &s);
>> +
>> +        $do_return$bdrv_poll_co(&s.poll_state);
> 
> Another spot impacted by that one outlier.
> 
>> +    }
>> +}"""
>> +
>> +# We want to use python string.format() formatter, which uses curly brackets
>> +# as separators. But it's not comfortable with C. So, we used dollars instead,
>> +# and now is the time to escape curly brackets and convert dollars.
>> +template = template.replace('{', '{{').replace('}', '}}')
>> +template = re.sub(r'\$(\w+)\$', r'{\1}', template)
> 
> I'll leave it to others to decide if your approach has a more idiomatic python solution.  I'm used to the qapi generator using code like this in script/qapi/visit.py:
> 
> def gen_visit_members_decl(name):
>      return mcgen('''
> 
> void visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp);
> ''',
>                   c_name=c_name(name))
> 
> which has the same end goal of inserting named tags into a format string, but which uses %(tag) for tags rather than your novel approach of $tag$ with post-processing.

Note, that actually not %(tag) but %(tag)s

%(name)s notation comes from % interpolation operator.. As I understand, in modern python using .format(), f-strings and templates is preferable.
But I agree, that introducing new hand-made notation is not a great idea. I think, I'll move to string.Template or f-strings.

> 
>> +
>> +
>> +class ParamDecl:
>> +    param_re = re.compile(r'(?P<decl>'
>> +                          r'(?P<type>.*[ *])'
>> +                          r'(?P<name>[a-z][a-z0-9_]*)'
>> +                          r')')
>> +
>> +    def __init__(self, param_decl: str) -> None:
>> +        m = self.param_re.match(param_decl.strip())
>> +        self.decl = m.group('decl')
>> +        self.type = m.group('type')
>> +        self.name = m.group('name')
>> +
>> +
>> +class FuncDecl:
>> +    def __init__(self, return_type: str, name: str, args: str) -> None:
>> +        self.return_type = return_type.strip()
>> +        self.name = name.strip()
>> +        self.args: List[ParamDecl] = []
>> +        self.args = [ParamDecl(arg) for arg in args.split(',')]
>> +
>> +    def get_args_decl(self) -> str:
>> +        return ', '.join(arg.decl for arg in self.args)
>> +
>> +    def get_arg_names(self) -> str:
>> +        return ', '.join(arg.name for arg in self.args)
>> +
>> +    def gen_struct_fields(self) -> str:
>> +        return '\n    '.join(f'{arg.decl};' for arg in self.args)
>> +
>> +    def gen_struct_initializers(self, indent: int) -> str:
>> +        sep = '\n' + ' ' * indent
>> +        return sep.join(f'.{a.name} = {a.name},' for a in self.args)
>> +
>> +
>> +# Match wrappers declaration, with generated_co_wrapper mark
> 
> s/declaration, with/declared with a/
> 
>> +func_decl_re = re.compile(r'^(?P<return_type>(int|void))'
>> +                          r'\s*generated_co_wrapper\s*'
>> +                          r'(?P<wrapper_name>[a-z][a-z0-9_]*)'
>> +                          r'\((?P<args>[^)]*)\);$', re.MULTILINE)
>> +
>> +
>> +def func_decl_iter(text: str) -> Iterator:
>> +    for m in func_decl_re.finditer(text):
>> +        yield FuncDecl(return_type=m.group('return_type'),
>> +                       name=m.group('wrapper_name'),
>> +                       args=m.group('args'))
>> +
>> +
>> +def struct_name(func_name: str) -> str:
>> +    """some_function_name -> SomeFunctionName"""
>> +    words = func_name.split('_')
>> +    words = [w[0].upper() + w[1:] for w in words]
>> +    return ''.join(words)
>> +
>> +
>> +def make_wrapper(func: FuncDecl) -> str:
>> +    assert func.name.startswith('bdrv_')
>> +    co_name = 'bdrv_co_' + func.name[5:]
>> +
>> +    has_ret = func.return_type != 'void'
>> +
>> +    params = {
>> +        'name': co_name,
>> +        'do_return': 'return ' if has_ret else '',
>> +        'assign_ret': 's->poll_state.ret = ' if has_ret else '',
> 
> See my comments above about possibly normalizing the one outlier of bdrv_co_invalidate_cache first.
> 
>> +        'struct_name': struct_name(co_name),
>> +        'wrapper_name': func.name,
>> +        'ret_type': func.return_type,
>> +        'args_def': func.get_args_decl(),
>> +        'arg_names': func.get_arg_names(),
>> +        'fields': func.gen_struct_fields(),
>> +        'initializers': func.gen_struct_initializers(12),
> 
> 12 looks like a magic number.
> 
>> +        'args_from_s': ', '.join(f's->{a.name}' for a in func.args),
>> +    }
>> +
>> +    if func.args[0].type == 'BlockDriverState *':
>> +        params['bs'] = 'bs'
>> +    else:
>> +        assert func.args[0].type == 'BdrvChild *'
>> +        params['bs'] = 'child->bs'
>> +
>> +    return template.format(**params)
>> +
>> +
>> +if __name__ == '__main__':
>> +    import sys
>> +
>> +    print(header)
>> +    for func in func_decl_iter(sys.stdin.read()):
>> +        print(make_wrapper(func))
>>
> 


-- 
Best regards,
Vladimir

