Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4A3C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 13:16:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19AAE2396D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 13:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jVeYB2xu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AAE2396D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKi9J-0000a4-0D
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 09:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kKi7N-00079K-L9; Tue, 22 Sep 2020 09:14:01 -0400
Received: from mail-eopbgr50123.outbound.protection.outlook.com
 ([40.107.5.123]:14567 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kKi7J-000694-ET; Tue, 22 Sep 2020 09:14:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2uL6pL5jPISBUEf63ZwOEwQ30hmhXHBA0wXwX4V23NHevI0ia7+BTpEpIY/LtCkgmW3cI1onPLyvx6Q6P4AslxNzECE5voqgn8j4n4SHSZSxzH6WWDKqEa9j0cFCxEHsB1FTolDU7FWCcqm0V1K3aV8gsBcbZK9r34Oxz+IVOJZzI2mEQm8I3+9sGfCG9uEOf7WSdnoKm0qlx+eWzVHr//W9LnQF2epzA+ayXQ54y9KRLUDx6E+vgNfeaZdRAQFvzMnt6ss3TvezWedtaEMBLRrZZGsFpzlw5VoXwM6hbi2lrI0KIXuH8q6gGvnbG84/ceZwCZPnAIiVy33m6mIIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/EMNopbLqVQXZJ8ls8bZG1Fgobvbcjnw9Rnv0UosaQ=;
 b=czW+2fvDRGk+F6TIDVnjGJdudsZFTOki2ERO3B4YwAt9XnIdSzuy9eC7rvfx2o08N+6at0S9Oi5ETC6Cwtxi8EP1jit0leLvAIAAGl90gH8WJyMMWUQVE3RmRnxed+BOBFthzyjRbk+F6Z0SV5Mk8rM8xSQXU7XPetSBJWyLEW3jDexEeJGRf3rGwFn7AE3bEtnOj9CJWCtbT/77wGiuAgsG6XHLY+3tjKbu4FlMIpp0sPSz0ZI8pHGtQKDaiQD8TO7qnI1cmc9dzHdxEfwJXYRxwK7g/hLoNWhCta+LgZXcL1L+GlCzCFGMDzyLghNA7ETHkvJM8VfuWhkQTfzM8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/EMNopbLqVQXZJ8ls8bZG1Fgobvbcjnw9Rnv0UosaQ=;
 b=jVeYB2xuIy1zrxiuZNQrAHQpTcxBi45nwM7Xo6ny3BiE7B7/F1GKB/4cliDt+UqXqlQGDPLuvBoBxtqhOo4WK+BHf/+H6txLwAvcFc3ST3PrmWWG4u6hU9Iu0yDoICydiKzeXbZ18ufQBcyfrqNDhBlhgaLayaPMWI5xyLa4/vI=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR08MB2649.eurprd08.prod.outlook.com (2603:10a6:7:2b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.22; Tue, 22 Sep
 2020 13:13:51 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3391.027; Tue, 22 Sep 2020
 13:13:51 +0000
Subject: Re: [PATCH v8 5/7] copy-on-read: limit guest writes to base in COR
 driver
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, armbru@redhat.com,
 jsnow@redhat.com, eblake@redhat.com, den@openvz.org
References: <1598633579-221780-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1598633579-221780-6-git-send-email-andrey.shinkevich@virtuozzo.com>
 <667dbbb4-b4b3-1e18-6c9b-466b75cbd00c@redhat.com>
 <716e4f2e-b15b-6094-badc-84d3daf9f8ab@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <c8e0ab87-b5e9-7b4b-6cc1-db404cbd4c80@virtuozzo.com>
Date: Tue, 22 Sep 2020 16:13:48 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <716e4f2e-b15b-6094-badc-84d3daf9f8ab@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR03CA0002.eurprd03.prod.outlook.com
 (2603:10a6:208:14::15) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM0PR03CA0002.eurprd03.prod.outlook.com (2603:10a6:208:14::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13 via Frontend Transport; Tue, 22 Sep 2020 13:13:50 +0000
X-Originating-IP: [109.252.114.22]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4956a2a9-5ce8-43b6-2ffe-08d85ef95940
X-MS-TrafficTypeDiagnostic: HE1PR08MB2649:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR08MB26490AE5AABB90353B53430FF43B0@HE1PR08MB2649.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3lIe8LeESio44jB8oLbCdlE7Iio4mLd1Rn6/auOaGvRC0C/r+FeW+sbMajol0gQczSIt0bkuhojtTKkVtZuj+LVbjjt+mDuRs3NXgl0tdtfH0ESMhT9LSo3XIGhrgBIcu3zY/EYe8L0DW56W6bE1/ZdurlalU6kiKqEhK9lRpxdWApPe2OzcvhBc2XDlthtZPXL0Lx/5aVfOwi0o76pNGkppwnhx8yVwijkcAgBX/xFQ6k9XlnTAuL1RjpNCxTiRx7st/Wp4fFW1qGYCgbrYETiCTxMLmBAO5emVkyfuCGPC6fBLphUKqdhvQYn2c8L2f45c41t4gbWa2pk5h+1YFHb3JNn/REgxk8okDmcEP04NR1yDssrahCGscQIO6wyFriiTYmmZ4DrzmmdIqEBg+L6D2Jib8FWB2RsGt4mCFGkx9rYKFdfK3D7cQSopprie
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39840400004)(366004)(396003)(376002)(346002)(2906002)(6506007)(86362001)(4326008)(5660300002)(44832011)(2616005)(31686004)(31696002)(66946007)(66476007)(66556008)(6486002)(956004)(478600001)(52116002)(8676002)(16526019)(83380400001)(107886003)(110136005)(53546011)(316002)(8936002)(186003)(6512007)(36756003)(26005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Z7xNxHeG2eZAMyeUOzNeN3ardvkoYxVbUBL0b8JeUAXJPLQT3RvSffZBqGLxtVyys4uOhzj08d1qjCYB5LiHzaMNTZa/BIT4cugZk/wObX0WBQRu7zTbPDbX7ZS834KuY0ExMOyAX3cBYn9U2/pPjorAUdU/fuaKldmGWuyJ/6VMFpXXmXe0FdVFE2JBij08+C9bRjBHhPHxWYZujVDg/LJnAgATwPfE8o+9DH2MYtxFl1t53ZxFbSQNvWHpVvkaiMpXUqUzAweyu84+YA9Q4xQdVccIfvNs/ziEquZ2T1v8AlYuTEwceYARZORuTOaIln4pcvqMhUMB5n0kqXBLKVpqiDWQaYyeqyaHRA/skRsDSfuYsBYhVzTZPjGXusQ3Pv0ve6a213N5SIgRtOaJp4PzH1+jk4OQcdNxbJgeGQ10oA0xa5jT/YXl/53gGa0Jy1hhUSz7QZgtsAcnlA8h8FE0YqopZrh/27h8HYQwDXN5KdTKKRhq77/+4rahAh0gXig1xqJaB+IoM1d0uq5eMpOdHYSYKeCk8CDrxzZ3pug1GgNjr3jarZdU30DYCKmH+zDzT0wur4BBSWFYOFjOCiZf6Spwqbd40JPK5u9DD4v1qDTiJREihxe1WbElNeremI9tWyImsE/QaSoayeIZcA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4956a2a9-5ce8-43b6-2ffe-08d85ef95940
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 13:13:51.2010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKU8Z8DiypdFr3eCBsLGmojgTvxHhmzwzbc34rH7BdYy324x7snq+xuMZ/G6vZXgScPFKRu3XEuIhynnXHXAgeXxWhxO5As/9qUFzCt/7U8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2649
Received-SPF: pass client-ip=40.107.5.123;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 09:13:53
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 04.09.2020 16:59, Vladimir Sementsov-Ogievskiy wrote:
> 04.09.2020 15:50, Max Reitz wrote:
>> On 28.08.20 18:52, Andrey Shinkevich wrote:
>>> Limit the guest's COR operations by the base node in the backing chain
>>> during a stream job.
>>
>> I don’t understand.   Shouldn’t we limit the areas where we set the COR
>> flag?
>>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> ---
>>>   block/copy-on-read.c | 49 
>>> +++++++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 49 insertions(+)
>>>
>>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>>> index 1f858bb..ecbd1f8 100644
>>> --- a/block/copy-on-read.c
>>> +++ b/block/copy-on-read.c
>>> @@ -57,6 +57,37 @@ static BlockDriverState 
>>> *get_base_by_name(BlockDriverState *bs,
>>>       return base_bs;
>>>   }
>>>   +/*
>>> + * Returns 1 if the block is allocated in a node between 
>>> cor_filter_bs->file->bs
>>> + * and the base_bs in the backing chain. Otherwise, returns 0.
>>> + * The COR operation is allowed if the base_bs is not specified - 
>>> return 1.
>>> + * Returns negative errno on failure.
>>> + */
>>> +static int node_above_base(BlockDriverState *cor_filter_bs, 
>>> uint64_t offset,
>>> +                           uint64_t bytes)
>>> +{
>>> +    int ret;
>>> +    int64_t dummy;
>>> +    BlockDriverState *file = NULL;
>>> +    BDRVStateCOR *state = cor_filter_bs->opaque;
>>> +
>>> +    if (!state->base_bs) {
>>> +        return 1;
>>> +    }
>>> +
>>> +    ret = bdrv_block_status_above(cor_filter_bs->file->bs, 
>>> state->base_bs,
>>> +                                  offset, bytes, &dummy, NULL, &file);
>>> +    if (ret < 0) {
>>> +        return ret;
>>> +    }
>>> +
>>> +    if (file) {
>>
>> Why check file and not the return value?
>>
>>> +        return 1;
>>> +    }
>>> +
>>> +    return 0;
>>
>> “dummy” should really not be called that way, it should be evaluated
>> whether it’s smaller than bytes.
>>
>> First, [offset, offset + dummy) may not be allocated above the base –
>> but [offset + dummy, offset + bytes) may be.  Then this function returns
>> 0 here, even though there is something in that range that’s allocated.
>>
>> Second, in that case we still shouldn’t return 1, but return the
>> shrunken offset instead.  Or, if there are multiple distinct allocated
>> areas, they should probably even all be copied separately.
>>
>>
>> (But all of that of course only if this function is intended to be used
>> to limit where we set the COR flag, because I don’t understand why we’d
>> want to limit where something can be written.)
>>
>
> Agree to all.
>
> 1. Write path shouldn't be changed: it's a copy-on-read filter.
>
> 2. On read we need is_allocated_above-driven loop, to insert the flag 
> only to regions allocated above base
>  (and other regions we read just without the flag, don't skip them). 
> qiov_offset will help very well.
>
> 3. Like in many other places, let's ignore  errors (and just add the 
> flag if block_status fails)


If "block_status" fails, the stream job does not copy. Shall we keep the 
same behavior in the cor_co_preadv_part()?


Andrey

>
>>> +}
>>> +
>>>   static int cor_open(BlockDriverState *bs, QDict *options, int flags,
>>>                       Error **errp)
>>>   {
>>> @@ -153,6 +184,12 @@ static int coroutine_fn 
>>> cor_co_pwritev_part(BlockDriverState *bs,
>>>                                               QEMUIOVector *qiov,
>>>                                               size_t qiov_offset, 
>>> int flags)
>>>   {
>>> +    int ret = node_above_base(bs, offset, bytes);
>>> +
>>> +    if (!ret || ret < 0) {
>>> +        return ret;
>>> +    }
>>> +
>>>       return bdrv_co_pwritev_part(bs->file, offset, bytes, qiov, 
>>> qiov_offset,
>>>                                   flags);
>>>   }
>>> @@ -162,6 +199,12 @@ static int coroutine_fn 
>>> cor_co_pwrite_zeroes(BlockDriverState *bs,
>>>                                                int64_t offset, int 
>>> bytes,
>>> BdrvRequestFlags flags)
>>>   {
>>> +    int ret = node_above_base(bs, offset, bytes);
>>> +
>>> +    if (!ret || ret < 0) {
>>> +        return ret;
>>> +    }
>>> +
>>>       return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
>>>   }
>>>   @@ -178,6 +221,12 @@ static int coroutine_fn 
>>> cor_co_pwritev_compressed(BlockDriverState *bs,
>>>                                                     uint64_t bytes,
>>> QEMUIOVector *qiov)
>>>   {
>>> +    int ret = node_above_base(bs, offset, bytes);
>>> +
>>> +    if (!ret || ret < 0) {
>>> +        return ret;
>>> +    }
>>> +
>>>       return bdrv_co_pwritev(bs->file, offset, bytes, qiov,
>>>                              BDRV_REQ_WRITE_COMPRESSED);
>>>   }
>>>
>>
>>
>
>

