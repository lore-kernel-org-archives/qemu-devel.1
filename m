Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50191C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:14:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4DDC20758
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="noAYmftp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4DDC20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb9ZL-0005zA-SG
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 17:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb9Yg-000564-ML; Tue, 19 May 2020 17:13:54 -0400
Received: from mail-eopbgr150109.outbound.protection.outlook.com
 ([40.107.15.109]:12419 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb9Ye-0003NK-3y; Tue, 19 May 2020 17:13:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQfm8mVkeO6oSy/8Mf3DJLuJ0sOsJkNhByXgqicsNMmfvVq8KE6FlF+WcWUY9MgxkZy8KB3yMOzcxvfB8HNsC0Rw9ubnOZphIg5+CdNUGLz+FLARlzjIMM4wHUJ1Crrh93Ckba6KY0FQ/3rLmvvC/hBuW7f9di9K0wFVk5/wgfD3J1G33LFRRjus6n8fwkZSjhxIjmMIhcugJctC1Ibl1WmGFXzedxlcKMMUS+nXfd0LphpWoTzNp9TDWTFahQw8sBslQRkNHncKxfp6mSpMv2M49F7/AZtwmgtihS7n/pgC5Yl8CLYtzZpc31kum2f1jzjJi/WukbOFroIK9Bey6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xG3vVriZgqdySXoClmOZwAEholRtqHWDh9qBwAxOBLY=;
 b=Akh3D13Cnd6ohh6cCqy9cOGAwp1k71gwa9aNugCBI0E2boC2WShFo2sySFuultHR2cEavhveW0T+d4zXupW8LyZCOwmoYu9NIabMYwIPcJDnjyPE39Yt8ZuWmue0MDESpc1lxCv7ARyt5EgEmOIth7YKMVKnpokv45yylv28wUQtliPzdUGIgxS3Oc5jsQVTG5GhEQGr9bAUNH+wzLqkarGC5FXUD0bGZBlud+SIM+GanEIGu4+4qSRv0GNt6ZlVG04b263dlyAouHM+BfdhLMiGFYrzO/1XFdqMkR5nzmwomG3r3ULxlZBsljK5rm1q2iqiVVt8eo43l0RC39R6SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xG3vVriZgqdySXoClmOZwAEholRtqHWDh9qBwAxOBLY=;
 b=noAYmftp9EOLFKUJtp+08zpIBvvcInx5yji7x/8XffPCoLwN58u1yO4t/7CxvbvW/gHRV3RPnzJAiswnuOwVKs2VGuBVzjhlh9P2KsLpI3DKmvlPoXZqNVEWn9JcbtVNwaj3rM8M9bT2Y8Ma3Mw1CQn2XrzuBM9xuTtTrN3AqxE=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB2815.eurprd08.prod.outlook.com (2603:10a6:802:19::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Tue, 19 May
 2020 21:13:48 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 21:13:48 +0000
Subject: Re: [PATCH v2 1/5] block/io: fix bdrv_co_block_status_above
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200519195501.29071-1-vsementsov@virtuozzo.com>
 <20200519195501.29071-2-vsementsov@virtuozzo.com>
 <cd4c3996-703a-13c5-aa9c-664d2de0ca26@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <3a66bacf-3462-a82c-c758-730107e75898@virtuozzo.com>
Date: Wed, 20 May 2020 00:13:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <cd4c3996-703a-13c5-aa9c-664d2de0ca26@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::20) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.178) by
 AM4P190CA0010.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.26 via Frontend Transport; Tue, 19 May 2020 21:13:47 +0000
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0316f5ee-4786-40a6-0dae-08d7fc398563
X-MS-TrafficTypeDiagnostic: VI1PR08MB2815:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB281542CB96DB269068DEC914C1B90@VI1PR08MB2815.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QA0m+SuXs6GphM03sF7aNXEzEzrMflM/D2shY/eyEF0VkdgzUF62HmeFaeQx4xgf43tDln93YqhD+yTaG7ADVUFrO1soh6mqBRZlOrGmWjONQWZ96rBSNuaDF9QvznyNp78A6HewQOEJSG1BAMhGvWlz6V2y/q09ydz4gOfDMtWUpu/0WXlry37krfwpVsz1Bea/LA9HLzuJkJE8cJqtKgHa487xaQZzfKt9on1LEGZN9psQcfiwb62mK8F4R3jHDNB3Jkmd1uo8V6UchE4U4Zg0ttC3/dyp5USPLenaHNhz6F2J7yZz1SxU+xYaegjKV3iibLzpd7IVKcQBZV+rSTsyLu7VOYvPvr1PIqKp6j7xDPx08aNEHFfS5ua5TNFZkGS5WqHTn24BVFopdegbizstsh1F6iIr8uJ3FyLSZ2z+fOxuylM5cbqkPcNH22pGWwts7ubBRVb/9z0XDYEgIAR/cly9V8LF7hzuslDXf6e94e1IM5gC1xkm7ihNjj5Y4qrFQU9RgLiTqREuNAtS5ICV79SSYPAAGfgX1HpaWZzRDLHib32LYAbudqNU7wIzqK1xCXIqAKsRSF7z9PVGRXwTWOi8S4QiAyaqejrcvlw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(376002)(346002)(396003)(366004)(136003)(8936002)(186003)(16526019)(8676002)(5660300002)(2906002)(66946007)(31686004)(956004)(107886003)(2616005)(6486002)(31696002)(66476007)(66556008)(86362001)(36756003)(16576012)(53546011)(966005)(316002)(478600001)(52116002)(26005)(4326008)(21314003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: fDL7+N1yV0Jxu5TmwyH/KHlO/ryJ07BLRK1XxOieAy0jUPzeRxsOlYmtO6kLeRYcL4P0ni3UsF+Uqbb8xLAttVGtj9rYkKVo9cv9GuszZz/sFHJg1cGAz+zxL7Hlf6sRTaf3Pp7Ts2Iet1ISblmFTeJlgHph5s4YpoWGB775GkJO7LU63W5Zk/KxdFls2nqy1xLTj1x9h8mzDFlgk1TGFijQGq80a2oSvuqvQlY+AJN6t19D49zztaH4Bo+/QWbb2W+XUSu5GCUKiTTjt7OZHBfknb5kfkkbQPCVX1Basx7q8cm8NFUKBhwyZYdQDOJAcTkl1vGd3gQyHnGhgeT/6d+kYk434HRvt5PK7soQtm3jrEqGBkpT+apfXdS1RC6IZUzFuGBGVdYQylvwFVzRrAUYRpvTXNpWJWLogqKhAKOsqMnmZWxMCC3+bcFEe2248jW9V+A+SeuhL3AC4BCvnEePpi6qEGq1clytVy75YYqmuIihYCJgg+5giQX0oUxT
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0316f5ee-4786-40a6-0dae-08d7fc398563
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 21:13:47.9034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NriHsKvgrtrxVG/SIEi7rJiC1jaAwkyfFuGHUwvdbx+kmW5mSUP5NTwLiwZix0HHAogB9x1euR74FkLklHxx8S2fzV6Hno0k9dxmfO/XjNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2815
Received-SPF: pass client-ip=40.107.15.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 17:13:49
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

19.05.2020 23:41, Eric Blake wrote:
> On 5/19/20 2:54 PM, Vladimir Sementsov-Ogievskiy wrote:
>> bdrv_co_block_status_above has several problems with handling short
>> backing files:
>>
>> 1. With want_zeros=true, it may return ret with BDRV_BLOCK_ZERO but
>> without BDRV_BLOCK_ALLOCATED flag, when actually short backing file
>> which produces these after-EOF zeros is inside requested backing
>> sequence.
> 
> That's intentional.  That portion of the guest-visible data reads as zero (BDRV_BLOCK_ZERO set) but was NOT read from the top layer, but rather synthesized by the block layer because it derived from the backing file but was beyond EOF of that backing layer (BDRV_BLOCK_ALLOCATED is clear).

Not in top yes. But _inside_ the requested base..top backing-chain-part. So it should be considered ALLOCATED, as we should not go to further backing.

Assume the following chain:

top    aa--
middle bb
base   xxxx

(so, middle is short)

block_status(top, 2) should return ZERO without ALLOCATED, as yes it's ZERO and yes, it's from another layer

block_status_above(top, base, 2) should return ZERO with ALLOCATED, as it's ZERO, and it's produced inside requested backing-chain-region, actually, it's produced because of short middle node. We must report ALLOCATED to show that we are not going to read from base.

> 
>>
>> 2. With want_zero=false, it may return pnum=0 prior to actual EOF,
>> because of EOF of short backing file.
> 
> Do you have a reproducer for this?

No, I don't have one, but it seems possible at least with want_zero=false. I'll think of it tomorrow, too tired now.

> In my experience, this is not possible.  Generally, if you request status that overlaps EOF of the backing, you get a response truncated to the end of the backing, and you are then likely to follow up with a subsequent status request starting from the underlying EOF which then sees the desired unallocated zeroes:
> 
> back     xxxx
> top      yy------
> request    ^^^^^^
> response   ^^
> request      ^^^^
> response     ^^^^
> 
>>
>> Fix these things, making logic about short backing files clearer.
>>
>> Note that 154 output changed, because now bdrv_block_status_above don't
> 
> doesn't
> 
>> merge unallocated zeros with zeros after EOF (which are actually
>> "allocated" in POV of read from backing-chain top) and is_zero() just
>> don't understand that the whole head or tail is zero. We may update
>> is_zero to call bdrv_block_status_above several times, or add flag to
>> bdrv_block_status_above that we are not interested in ALLOCATED flag,
>> so ranges with different ALLOCATED status may be merged, but actually,
>> it seems that we'd better don't care about this corner case.
> 
> This actually sounds like an avoidable regression.  :(

I don't see real problem in it. But it seems not hard to avoid it, so I will try to.

> 
> I argue that if we did not explicitly write data/zero clusters in the tail of the top layer, then those clusters are not allocated from the POV of reading from the backing-chain top.  Yes, we know what their contents will be, but we also know what the contents of unallocated clusters will be when there is no backing file at all - basically, after your other patch series to drop unallocated_blocks_are_zero:
> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg05429.html
> then we know that only format drivers that can support backing files even care what allocation means, and 'allocated' strictly means that the data comes from the top layer rather than from a backing (whether directly from the backing, or synthesized as zero by the block layer because it was beyond EOF of the backing).

I agree about allocated in top, returned by block_status. But this patch is for allocated_above, and the ALLOCATED status is not about top, but about a set of nodes from base (not inclusive) to top.

> 
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/io.c                 | 38 +++++++++++++++++++++++++++++---------
>>   tests/qemu-iotests/154.out |  4 ++--
>>   2 files changed, 31 insertions(+), 11 deletions(-)
>>
> 
> I'm already not a fan of this patch - it adds lines rather than removes, and seems to add a regression.
> 
>> diff --git a/block/io.c b/block/io.c
>> index 121ce17a49..db990e812b 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -2461,25 +2461,45 @@ static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
>>           ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
>>                                      file);
>>           if (ret < 0) {
>> -            break;
>> +            return ret;
>>           }
>> -        if (ret & BDRV_BLOCK_ZERO && ret & BDRV_BLOCK_EOF && !first) {
>> +        if (*pnum == 0) {
>> +            if (first) {
>> +                return ret;
>> +            }
>> +
>>               /*
>> -             * Reading beyond the end of the file continues to read
>> -             * zeroes, but we can only widen the result to the
>> -             * unallocated length we learned from an earlier
>> -             * iteration.
>> +             * Reads from bs for the selected region will return zeroes,
>> +             * produced because the current level is short. We should consider
>> +             * it as allocated.
> 
> Why?  If we replaced the backing file to something longer (qemu-img rebase -u), we would WANT to read from the backing file.  The only reason we read zero is because the block layer synthesized it _while_ deferring to the backing layer, not because it was directly allocated in the top layer.

No, if we replace backing file of the current layer, nothing will change, as _this_ layer is short, not the backing. Or which backing file do you mean? If you mean current bs, than replacing it doesn't make sense in the context, as block_status_above requested the current bs (as part of base..top range), not the other one.

> 
>> +             *
>> +             * TODO: Should we report p as file here?
> 
> No. Reporting 'file' only makes sense if you can point to an offset within that file that would read the guest-visible data in question - but when the data is synthesized, there is no such offset.

I don't know. It still adds some information about which level is responsible for these ZEROES. Kevin argued that it make sense.

> 
>>                */
>> +            assert(ret & BDRV_BLOCK_EOF);
>>               *pnum = bytes;
>> +            return BDRV_BLOCK_ZERO | BDRV_BLOCK_ALLOCATED;
>>           }
>> -        if (ret & (BDRV_BLOCK_ZERO | BDRV_BLOCK_DATA)) {
>> -            break;
>> +        if (ret & BDRV_BLOCK_ALLOCATED) {
>> +            /* We've found the node and the status, we must return. */
>> +
>> +            if (ret & BDRV_BLOCK_ZERO && ret & BDRV_BLOCK_EOF && !first) {
>> +                /*
>> +                 * This level is also responsible for reads after EOF inside
>> +                 * the unallocated region in the previous level.
>> +                 */
>> +                *pnum = bytes;
>> +            }
>> +
>> +            return ret;
>>           }
>> +
>>           /* [offset, pnum] unallocated on this layer, which could be only
>>            * the first part of [offset, bytes].  */
>> -        bytes = MIN(bytes, *pnum);
>> +        assert(*pnum <= bytes);
>> +        bytes = *pnum;
>>           first = false;
>>       }
>> +
>>       return ret;
>>   }
>> diff --git a/tests/qemu-iotests/154.out b/tests/qemu-iotests/154.out
>> index fa3673317f..a203dfcadd 100644
>> --- a/tests/qemu-iotests/154.out
>> +++ b/tests/qemu-iotests/154.out
>> @@ -310,13 +310,13 @@ wrote 512/512 bytes at offset 134217728
>>   512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>   2048/2048 bytes allocated at offset 128 MiB
>>   [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
>> -{ "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": false}]
>> +{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
> 
> The fact that we no longer see zeroes in the tail of the file makes me think this patch is wrong.
> 
>>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
>>   wrote 512/512 bytes at offset 134219264
>>   512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>   2048/2048 bytes allocated at offset 128 MiB
>>   [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
>> -{ "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": false}]
>> +{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
>>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
>>   wrote 1024/1024 bytes at offset 134218240
>>   1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>
> 


-- 
Best regards,
Vladimir

