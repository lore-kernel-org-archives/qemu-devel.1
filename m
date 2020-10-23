Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C30C55178
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 09:50:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BF152168B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 09:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vnVruDTS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF152168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVtiH-0000ZZ-GJ
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 05:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVthR-00007r-9U; Fri, 23 Oct 2020 05:49:29 -0400
Received: from mail-eopbgr10114.outbound.protection.outlook.com
 ([40.107.1.114]:48378 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVthO-0000na-9y; Fri, 23 Oct 2020 05:49:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwzLI+4+R9iWNhVMS+ZctGwMUeZUCanyIbicU+urZ9OLwsFdXbDMiFviSYn9UVQSlhI/Q0TP500WR4EiOqm5qX4PPTK13/S6LBp3Kr+4imBClzzquwPPi3JtH0RuuncnDN8KGAqss6PFtlYvKUnD4+DMB7jBAl+FNBv9NY07TrUFhuLJg4oMT3XGjmjQJ2lyhh15lEDalmAqxACR8XPxBAVNAONRGFuOmSKCBIBhbAIuGKpYy1qzTyjvoAW4DW/s45ygi4oiG0LJaou7ZWKP+/ffEgfKwkWfyeEWn9jFJJtjnwSTfLml0inSKAn6POeriE/2L/qD8zJ+6aPB5VfUjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwKoct+8Pe62A5Se4ccqpJ1fex0k8NOB8fWvpPS9nGs=;
 b=hDZBBQAC78PYm3bRD9RtQKaMNd3wjDmnQteQzt4f6HilCB3yiXqJB0V06yy6eBUlW2cXbiV6H50Q5mn8tsMLrxxorB7MIhkQZrOCQSWYB28pFeAIOmy9dG/kfx04Wt240O0/aW5l9EPPZggNDWwknYl1yuBlY3r7Koke6k6BTiNTlMhb5+VVi3V56X5vFdpErzHzsQBhSaDZvJMJzZE0oYwAEzo6jh7jlcfB78xmcLVn7jymScodh4LEwOlPpYi2pr0duxUejwnMPAHkiy9T1dRhrCDYZoMnp+PCykD4pztDyuihia43fHBPQrdtRGRWVOiZXACSeh1Hzpdse7Cwbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwKoct+8Pe62A5Se4ccqpJ1fex0k8NOB8fWvpPS9nGs=;
 b=vnVruDTSDJL5bKdEUTDdCmhaCU6OzBMy8WSHlQlCKTX7LzMwBSmfIIVvekrYM7cTQb6OMMtipJ6vfAVX9zLpmKPwubfR/p83Jp3kU+JJ6llxo5nmrl6gOI4qAtuqC6B+KLQzdfPXca7MZ620hXuaFt2mtNCVz3BTIQ02s/eXL+Y=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5207.eurprd08.prod.outlook.com (2603:10a6:20b:ea::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Fri, 23 Oct
 2020 09:49:20 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Fri, 23 Oct 2020
 09:49:20 +0000
Subject: Re: [PATCH v2 08/20] block/block-copy: add block_copy_cancel
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, wencongyang2@huawei.com,
 xiechanglong.d@gmail.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, den@openvz.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-9-vsementsov@virtuozzo.com>
 <93e0a82c-71eb-66f3-cf02-a06e3be7c9e8@redhat.com>
 <3d3f31e0-e5ca-9a6a-7acb-90302de50ba3@virtuozzo.com>
Message-ID: <243f7ad1-c38c-6284-6740-ab9a0e627eda@virtuozzo.com>
Date: Fri, 23 Oct 2020 12:49:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <3d3f31e0-e5ca-9a6a-7acb-90302de50ba3@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [178.176.77.223]
X-ClientProxiedBy: AM4PR05CA0034.eurprd05.prod.outlook.com (2603:10a6:205::47)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.42.94] (178.176.77.223) by
 AM4PR05CA0034.eurprd05.prod.outlook.com (2603:10a6:205::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.22 via Frontend Transport; Fri, 23 Oct 2020 09:49:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55927f8b-0d20-4c3a-54e0-08d87738e9f6
X-MS-TrafficTypeDiagnostic: AM6PR08MB5207:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5207A19F9FCCE91ED745B831C11A0@AM6PR08MB5207.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:439;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ihPE/ybCVs4+znh2uYgBn0YXtt5lsrJofAjV/y48qhqphc6KPjDCkbjgDNIEC8scOmW18NDCqVYL67EI6+xvUhwtXCGgQvie8mqBIiuhOAvVkMiDjrVt6VwJY3wgu0UFazKPuHKQQQw3JIi65O/ixzCH1MVVCs+m+MysvuPiJ7+zU8wMiM0H6AsJKzNTClsPimYiR/LOZ1ovfcKzf5DiGx9uHUmYw3WoBFMvf+sudenhYWpGtuytBsHKiQUZGlIzjXmqESqjkJFnIy1baXJ325or6X7jBO1e5dl2v/BGDVa4DMnBRYogq4tQWrtj3Mn7RNGobepFljUqXTuoCjPqO26/wegYAxJ7bCau505CzXbfJ6DXdAPSaqWmtdkDFCX8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39840400004)(366004)(136003)(396003)(52116002)(478600001)(66476007)(16526019)(2616005)(186003)(956004)(66946007)(36756003)(107886003)(66556008)(26005)(83380400001)(31686004)(53546011)(86362001)(5660300002)(8676002)(8936002)(16576012)(31696002)(4326008)(316002)(6486002)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: eABgq4CHHZYNL+Es1eApz42/lEe6sfIGp2Lr30kRazVtQ0D7ygr802Yavf5mz7nH/ztDHu5mJIQHBsIPuR/N8sL1O84ihcNbqUd7b6pQGKY7DP5vROBy0J6OfSjl5aLWHHNwE0S8A/tQhQI6dOba+ndbRAyJ78BzAsdQciZyqP/o2dyOc5jziiMytvud0XhZdYeMeeVMKBLqeANwrMsoykoIJij/BKtLspaj7kBu6d5RU9Xx5jXheK9szm/gfsoXPd8qQDqtv/Cl+PcG1Aa1pI8U7nfuEDVHeRbinGmFOS4BhbavNv12xasDmKfrRovYQyVgZnxO66KR+gjTF2fJ+jrFmER+fzMdHaFLvQRtnXhEjw3FsuaAljQ6IpP36p8Aa3k19JmttlSs1Iumfbi/MJ1nGSa29/1Gqq5aDGr8/ELBxmdSt4PevbSxlGviiQ5Yg8gK9+vFZRzJvnBj98DSPW/0keJndnR0L3JJVZ0A3cJ43dYoFTugHlpuCggpPlxc/Mcn1NJYGtWnYuqxWuJ2B9tA78z6IejkHDLAvOoRu1znSNmP2meL4cAFLoChAworP6poB+4KUzDAgUreQkHxNVjtnx3JvE2kXGZbQ/A6FZa8RJEVqiXtdaS80VtxFEcQYIWgS3qGXzRQECSprS7OlQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55927f8b-0d20-4c3a-54e0-08d87738e9f6
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 09:49:20.1169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTjLGF0TMqzkZa5JKXaXGrvSAFl47GXiLWAJMmFMehr8QpUyS+AYAXLU9DqTFKUowChMi9adVcyakRuN/Azd+5RLQ44ue2DI3/2iNwhcBwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5207
Received-SPF: pass client-ip=40.107.1.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 05:49:22
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

22.10.2020 23:50, Vladimir Sementsov-Ogievskiy wrote:
> 22.07.2020 14:28, Max Reitz wrote:
>> On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
>>> Add function to cancel running async block-copy call. It will be used
>>> in backup.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>   include/block/block-copy.h |  7 +++++++
>>>   block/block-copy.c         | 22 +++++++++++++++++++---
>>>   2 files changed, 26 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/block/block-copy.h b/include/block/block-copy.h
>>> index d40e691123..370a194d3c 100644
>>> --- a/include/block/block-copy.h
>>> +++ b/include/block/block-copy.h
>>> @@ -67,6 +67,13 @@ BlockCopyCallState *block_copy_async(BlockCopyState *s,
>>>   void block_copy_set_speed(BlockCopyState *s, BlockCopyCallState *call_state,
>>>                             uint64_t speed);
>>> +/*
>>> + * Cancel running block-copy call.
>>> + * Cancel leaves block-copy state valid: dirty bits are correct and you may use
>>> + * cancel + <run block_copy with same parameters> to emulate pause/resume.
>>> + */
>>> +void block_copy_cancel(BlockCopyCallState *call_state);
>>> +
>>>   BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s);
>>>   void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip);
>>> diff --git a/block/block-copy.c b/block/block-copy.c
>>> index 851d9c8aaf..b551feb6c2 100644
>>> --- a/block/block-copy.c
>>> +++ b/block/block-copy.c
>>> @@ -44,6 +44,8 @@ typedef struct BlockCopyCallState {
>>>       bool failed;
>>>       bool finished;
>>>       QemuCoSleepState *sleep_state;
>>> +    bool cancelled;
>>> +    Coroutine *canceller;
>>>       /* OUT parameters */
>>>       bool error_is_read;
>>> @@ -582,7 +584,7 @@ block_copy_dirty_clusters(BlockCopyCallState *call_state)
>>>       assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
>>>       assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
>>> -    while (bytes && aio_task_pool_status(aio) == 0) {
>>> +    while (bytes && aio_task_pool_status(aio) == 0 && !call_state->cancelled) {
>>>           BlockCopyTask *task;
>>>           int64_t status_bytes;
>>> @@ -693,7 +695,7 @@ static int coroutine_fn block_copy_common(BlockCopyCallState *call_state)
>>>       do {
>>>           ret = block_copy_dirty_clusters(call_state);
>>> -        if (ret == 0) {
>>> +        if (ret == 0 && !call_state->cancelled) {
>>>               ret = block_copy_wait_one(call_state->s, call_state->offset,
>>>                                         call_state->bytes);
>>>           }
>>> @@ -707,13 +709,18 @@ static int coroutine_fn block_copy_common(BlockCopyCallState *call_state)
>>>            * 2. We have waited for some intersecting block-copy request
>>>            *    It may have failed and produced new dirty bits.
>>>            */
>>> -    } while (ret > 0);
>>> +    } while (ret > 0 && !call_state->cancelled);
>>
>> Would it be cleaner if block_copy_dirty_cluster() just returned
>> -ECANCELED?  Or would that pose a problem for its callers or the async
>> callback?
>>
> 
> I'd prefer not to merge io ret with block-copy logic: who knows what underlying operations may return.. Can't it be _another_ ECANCELED?
> And it would be just a sugar for block_copy_dirty_clusters() call, I'll have to check ->cancelled after block_copy_wait_one() anyway.
> Also, for the next version I try to make it more obvious that finished block-copy call is in one of thee states:
>   - success
>   - failed
>   - cancelled
> 
> Hmm. Also, cancelled should be OK for copy-on-write operations in filter, it just mean that we don't need to care anymore.

This is unrelated: actually only async block-copy call may be cancelled.

> 
>>>       if (call_state->cb) {
>>>           call_state->cb(ret, call_state->error_is_read,
>>>                          call_state->s->progress_opaque);
>>>       }
>>> +    if (call_state->canceller) {
>>> +        aio_co_wake(call_state->canceller);
>>> +        call_state->canceller = NULL;
>>> +    }
>>> +
>>>       call_state->finished = true;
>>>       return ret;
>>
> 
> 


-- 
Best regards,
Vladimir

