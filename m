Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF568C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:26:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B5562073A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="erq/Sc6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5562073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWbr4-0005zQ-Bp
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 04:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWbq7-0005Nw-8r; Thu, 07 May 2020 04:25:07 -0400
Received: from mail-eopbgr80111.outbound.protection.outlook.com
 ([40.107.8.111]:28931 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWbq2-0004xr-9c; Thu, 07 May 2020 04:25:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeJ5u4xpKigToEDnJXte1rYnbL0J9/kL5+qlwPMhCynyIXlLB33+STlNthuA9Msld/cImhSMqH6RdChuLdsnZ15/MMWVMEwf/gl1nVV4j45w+0ZGCV23ZaceBmL/Y6v4YNgUTEFnZ9cDmM6h7phuZbLTFCDTiIzhR2Y+xoqABwo5RtgYovsDyYbmDklbEAJNwIvK2jB+6B4tCE77FuG7Zu9bvi89oNnjG6DOfAyioqh97DTrTj5Nop6VW1WUTjTsncz7XwbZBGzAIWsGGXGZtFUIxD4I74PEhaWotceeREbLfQXJI7lJo5JnMVyk0W2CGLGlKx8/Kl/ENHvaIt+Z3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkUglFuv4BfExaTlQTAJjfbRjLvUS0Wd44d2Tu6edZA=;
 b=QQbYIJBzyPNYgu4VI152KNQQVv7Q8bqHVculQYnC3qzUw3H965sG3sS6wPeioTmVUteUkOgFhZn1h1FDJM1L4eHSnTqfFlwYWU3rwZp4HiyVmQKKkn/Xr0/GGzly8WmIUSpJQnDpFQD7423IHE/WKZ0Zzu7M2toFgtCchu/61dcSMSLh7ygZlhU4x5hadxteAx6yGYTt7IIVhC7Wus2drKvf67QoNHPC9H0wvqqVxIFjE4ZQwufoAuZ2HoE3KxUAzM/Lxoah7bf8fT1FqhUTX5r9TS7h5OXPS/XK6F0gMgLJYXCVBz777KeJ9IKapJwhkFt8aZHXZZ2uLF7lLaELEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkUglFuv4BfExaTlQTAJjfbRjLvUS0Wd44d2Tu6edZA=;
 b=erq/Sc6GZ/Z8EnVaOgOXWXcpm032G3q0xavAYPYEX1hfZ9r1zfEC75TuP7hMODsmD98jxYev7Ey3Wb0d13RhXoURQXbf1rv8tkZdFubId0tHhpTzisP4kkAsNBc0BcsKwUOYD4pnfBjouv78ELg9n5xfevBVhLaPzn0pGt+BwDI=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5349.eurprd08.prod.outlook.com (2603:10a6:20b:107::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Thu, 7 May
 2020 08:24:58 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.034; Thu, 7 May 2020
 08:24:58 +0000
Subject: Re: [PATCH 8/8] block: drop unallocated_blocks_are_zero
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200506092513.20904-1-vsementsov@virtuozzo.com>
 <20200506092513.20904-9-vsementsov@virtuozzo.com>
 <ad581d23-d79d-bf78-3cd5-848eb29a90f5@redhat.com>
 <903973be-6af6-edd3-3509-b7688e0bb8d5@virtuozzo.com>
X-Tagtoolbar-Keys: D20200507112454719
Message-ID: <696d0e37-f8dc-dfb3-ba98-3babad5d34d6@virtuozzo.com>
Date: Thu, 7 May 2020 11:24:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <903973be-6af6-edd3-3509-b7688e0bb8d5@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR07CA0062.eurprd07.prod.outlook.com
 (2603:10a6:207:4::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.171) by
 AM3PR07CA0062.eurprd07.prod.outlook.com (2603:10a6:207:4::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.18 via Frontend Transport; Thu, 7 May 2020 08:24:56 +0000
X-Tagtoolbar-Keys: D20200507112454719
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6836544b-7a81-4d56-8326-08d7f260210b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5349E64D817DDFE4C8C7CF8DC1A50@AM7PR08MB5349.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cXL3ho2U4NaSCG3RBCB9h+MhdFDxVACZpSwBCGcqNhki/+AsMYbOJ87vVSC8k7Fr9YjHhtIxZI4ha1u409P4fi0GQoPRhVK5USHDmuO4ULIH5OISgzfKY3nix2/cUus5VLxsG7s0Wr4py1XSwdDccuIntstF2Fw5IlwwGUwhgHBW2I0AdzgRi3fWrPbfKBaQjinhJdv4c/xjWxW+VHcIBqXf8vPK+/H4tK655mSgdn2MUsrt5FmRCBnlh8IUHXJhL3l7qDTc55jZER8phgASzqn0Q5Gtv3PuXo0ZV1tmaNIQMg9jeKWixCkjmxbazOLL4VKFt2u0ug2GEyrNGZcvj91ZpxxrCBqrU94NOyKi8NpWpHYxy0bqiMWbSc+ZHijtz1awo1JcXi5/JaCop8zApsDeFJTkJQ/6upP3L8MTwYFrfz+D1nSY4/+rMRTg3rwoqkDA0cXpjXwJBtDEPRkxBQO2g7h5crzayY4h8WLC607r4Kfnz+zYrNREUl/RL6bI1SLUh4geFF9VdJ2y0H2EJ93IPRrDv/xKqf+V+682hXNjwzQy3MLUx3A4gfEpbXY0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39850400004)(396003)(376002)(136003)(366004)(33430700001)(33440700001)(316002)(86362001)(31696002)(478600001)(52116002)(31686004)(36756003)(83290400001)(83310400001)(83300400001)(8676002)(8936002)(83320400001)(53546011)(83280400001)(6486002)(16576012)(956004)(2616005)(26005)(66476007)(66556008)(4326008)(5660300002)(66946007)(16526019)(7416002)(186003)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: bvoZ3rTTBPz76oyDm4I9fV/Q15aaIa4iunYqQvdCP+Ax8xtiw0A7PGw2Nw5RPja7FG+hirboqON0Cqh0Os7gSpWYfdZj4B74RGyhW+uAkX6jQcKR1IGqaQJy2ERRJjPTpplEFuTq+9ap7NdYYSFpyCvk9ACtlpMISE4pjim7bZNnao46LvZLMlf4B7WdSasI+1HlbaCCuqeWhDTG2CUO82QwX0VAFBHBLwUZFOyRgbr3UjHLpJwc6r7+GLq9pfQEYIDr7f6HQcCOsQ9y3fiGybpgsEOisoDV2ucozzH29KK+Tx2Pu3fxIhC6Ecbj3CbAUA5IroYI0MiJ0lJ/zFQwaRZjtTq3JWlRLcXNbBnobLiBjPa6crMRffdPsbZGb9ADXX4woKBsl7RHpEwyvUC7wNgGv8/SwLuS9FlttIifGXvI03y+CNJFRfmpkkAMa2a6wv7LTyhtlYd2FeIe90D2ODVH9Kn+HRDef87Aqsx3ex9F/rss+fpe25uf1Vf88dR+3xBxiIxwSH/FRu7UZOJ+EecPHE+xhmqddgTbBac+79yYbYMHfi9i1sArfeoKScfI244gUUHnrPxiRtsjt6/yFtBZrg7GoERiVJtnVSut9TmNuQ+sAmRUjvcAIkZvqYvjVWiUs9ZHSMrOokvvl2z2JtsegcBCBl5NUL2SPnw1pooCeU/a1WlZ+upabPWiiZNgG+j30ygmqj0iU8NbX8lG9DuBUTEgop6EEaOv7Bg+FQko1manFLR4tkLHv2AUCRWhnfgAM+cCVUBBjUcPo/vmkylhql0VQWI13FoFXbD/rS8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6836544b-7a81-4d56-8326-08d7f260210b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 08:24:58.2892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfRVJXI/QvbtD+wRjf8li9J5ZdA7c47i2xSIVzY08sT39AGMhxHq4OtpDZaYMsBj7wx+wzfNE5wzUIjMOd3Lvk5MnaoOZt8uJwBxJrm9lUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5349
Received-SPF: pass client-ip=40.107.8.111;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 04:24:59
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, T_DKIM_INVALID=0.01,
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
Cc: fam@euphon.net, kwolf@redhat.com, ronniesahlberg@gmail.com,
 codyprime@gmail.com, sw@weilnetz.de, pl@kamp.de, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.05.2020 10:05, Vladimir Sementsov-Ogievskiy wrote:
> 06.05.2020 18:14, Eric Blake wrote:
>> On 5/6/20 4:25 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Currently this field only set by qed and qcow2.
>>
>> Well, only after patches 1-6 (prior to then, it was also set in protocol drivers).  I think you might be able to hoist part of this patch earlier in the series, to make the changes to the protocol drivers easier to review, by rewording this sentence:
>>
>> Currently, the only format drivers that set this field are qed and qcow2.
>>
>>> But in fact, all
>>> backing-supporting formats (parallels, qcow, qcow2, qed, vmdk) share
>>> this semantics: on unallocated blocks, if there is no backing file they
>>
>> s/this/these/
>>
>>> just memset the buffer with zeroes.
>>>
>>> So, document this behavior for .supports_backing and drop
>>> .unallocated_blocks_are_zero
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>   include/block/block.h     |  6 ------
>>>   include/block/block_int.h | 13 ++++++++++++-
>>>   block.c                   | 15 ---------------
>>>   block/io.c                |  8 ++++----
>>>   block/qcow2.c             |  1 -
>>>   block/qed.c               |  1 -
>>>   6 files changed, 16 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/include/block/block.h b/include/block/block.h
>>> index 8b62429aa4..db1cb503ec 100644
>>> --- a/include/block/block.h
>>> +++ b/include/block/block.h
>>> @@ -21,11 +21,6 @@ typedef struct BlockDriverInfo {
>>>       /* offset at which the VM state can be saved (0 if not possible) */
>>>       int64_t vm_state_offset;
>>>       bool is_dirty;
>>> -    /*
>>> -     * True if unallocated blocks read back as zeroes. This is equivalent
>>> -     * to the LBPRZ flag in the SCSI logical block provisioning page.
>>> -     */
>>> -    bool unallocated_blocks_are_zero;
>>
>> You can't delete this field until all protocol drivers are cleaned up, so deferring this part of the change to the end of the series makes sense.
>>
>>>       /*
>>>        * True if this block driver only supports compressed writes
>>>        */
>>> @@ -431,7 +426,6 @@ int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
>>>   int bdrv_has_zero_init_1(BlockDriverState *bs);
>>>   int bdrv_has_zero_init(BlockDriverState *bs);
>>>   int bdrv_has_zero_init_truncate(BlockDriverState *bs);
>>> -bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs);
>>
>> Doing this cleanup makes sense: there is only one caller of this function pre-patch, and 0 callers post-patch - but whether the cleanup should be at the same time as you fix the one caller, or deferred to when you also clean up the field, is less important.
>>
>> If I were writing the series:
>>
>> 1 - fix qemu-img.c to not use the field
>> 2 - fix block_status to not use the function
> 
> Hmm stop. We still need patches 1,2 before modifying block_status, otherwise we'll still need to check unallocated_blocks_are_zero


Hmm2. This just means that I need to put all commit messages about dropping unallocated_block_are_zero into one commit message rewriting the block_status. I doubt that it simplifies review: instead of analyzing format-by-format, you'll have to analyze all format at once.

> 
>> 3-n - fix protocol drivers that set the field to also return _ZERO
>>   during block status (but not delete the field at that time)
>> n+1 - delete unused function and field (from ALL drivers)
>>
>>>   bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs);
>>>   int bdrv_block_status(BlockDriverState *bs, int64_t offset,
>>>                         int64_t bytes, int64_t *pnum, int64_t *map,
>>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>>> index 92335f33c7..c156b22c6b 100644
>>> --- a/include/block/block_int.h
>>> +++ b/include/block/block_int.h
>>> @@ -115,7 +115,18 @@ struct BlockDriver {
>>>        */
>>>       bool bdrv_needs_filename;
>>> -    /* Set if a driver can support backing files */
>>> +    /*
>>> +     * Set if a driver can support backing files. This also implies the
>>> +     * following semantics:
>>> +     *
>>> +     *  - Return status 0 of .bdrv_co_block_status means that corresponding
>>> +     *    blocks are not allocated in this layer of backing-chain
>>> +     *  - For such (unallocated) blocks, read will:
>>> +     *    - read from backing file if there is one and big enough
>>
>> s/and/and it is/
>>
>>> +     *    - fill buffer with zeroes if there is no backing file
>>> +     *    - space after EOF of the backing file considered as zero
>>> +     *      (corresponding part of read-buffer must be zeroed by driver)
>>
>> Does the driver actually have to do the zeroing?  Looking at qcow2.c, I see:
>> static coroutine_fn int qcow2_co_preadv_task(BlockDriverState *bs,
>> ...
>>
>>      case QCOW2_CLUSTER_UNALLOCATED:
>>          assert(bs->backing); /* otherwise handled in qcow2_co_preadv_part */
>>
>>          BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
>>          return bdrv_co_preadv_part(bs->backing, offset, bytes,
>>                                     qiov, qiov_offset, 0);
>>
>> which just defers to the block layer to handle read-beyond-EOF, rather than an explicit memset in the driver.
>>
>> So maybe you can simplify to:
>> - For such (unallocated) blocks, read will:
>>    - fill buffer with zeros if there is no backing file
>>    - read from the backing file otherwise, where the block layer
>>      takes care of reading zeros beyond EOF if backing file is short
>>
>> But the effect is the same.
>>
>>> +++ b/block/io.c
>>> @@ -2385,16 +2385,16 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
>>>       if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
>>>           ret |= BDRV_BLOCK_ALLOCATED;
>>> -    } else if (want_zero) {
>>> -        if (bdrv_unallocated_blocks_are_zero(bs)) {
>>> -            ret |= BDRV_BLOCK_ZERO;
>>> -        } else if (bs->backing) {
>>> +    } else if (want_zero && bs->drv->supports_backing) {
>>> +        if (bs->backing) {
>>>               BlockDriverState *bs2 = bs->backing->bs;
>>>               int64_t size2 = bdrv_getlength(bs2);
>>>               if (size2 >= 0 && offset >= size2) {
>>>                   ret |= BDRV_BLOCK_ZERO;
>>>               }
>>> +        } else {
>>> +            ret |= BDRV_BLOCK_ZERO;
>>>           }
>>
>> I like this part of the change.  But if it is done first in the series, it _does_ have a semantic impact on protocol drivers (previously, protocol drivers that return 0 but set the field .unallocated_blocks_are_zero will be changed to report _ZERO; after this patch, protocol drivers do not do that, because they don't support backing files, and it is now only backing files that do the _ZERO magic).  So doing _just_ this change, along with a better analysis of how it changes the semantics of 'qemu-io -c map' on protocol drivers while mentioning why that is okay, would make a better start to the series, rather than here at the end.  Of course, if you defer it to the end, then none of the protocol drivers set .unallocated_blocks_are_zero anyway, but that cost more review work on each altered protocol driver.
>>
> 
> 


-- 
Best regards,
Vladimir

