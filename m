Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89184C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 06:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 399C120748
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 06:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LFmGZw9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 399C120748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbI34-0002td-72
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 02:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbI24-0001Zk-IK; Wed, 20 May 2020 02:16:49 -0400
Received: from mail-eopbgr60121.outbound.protection.outlook.com
 ([40.107.6.121]:54326 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbI21-00046m-Bf; Wed, 20 May 2020 02:16:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqCdmNm6hd3lRMYzOi/eylXX7V6fnk3dYa4Jha/c2gNb795AsTDrVEACG3FrLhhPG+t8NoSaZZv3CVhCdgI0vdQfJbjxQ1t0oy1e6xURMDZvOrTcnW1zqej1ycU6MBmk6teHuUV4GLkYYDl7BaxRDbRtR29nFwTDU49TqIc2Oilre7mhsJ6OpmIA/SUMMd1sXyZwC4ORXKkQQqK0VWOu/Y2FvwS5V16r58ZwAziI/ZNYwUsBrBeO2VbFywBHScfnxpzptlZa0XICALuDHtQ5tDtM5ptNDc/nhtp8AXF9mj/1rZ+uTVTGd0MEuFCYvu0pHTw0w8Rw6WILgaT0eUMmfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTPrpXa5M1ap9lKKwm33oSN/TaNI/z1HIe2QVM9Usr4=;
 b=Uh9I5wzRHkXxbox1SrB2V8/HIFLnIZAeD8zlYc+Sl24fQKinWFIXtQKIspr0mevJ94V0vYlpbjymIQAp0abcepX4UjOZOo5XZ1OR35p6h0PfWXuhvT/DB0WaiAOY38Q2CJ1jPEGai4JoJIHidPaVXH1Wumf8pW3wM8bCrvqG0ZoxTh87ntFPp2/BRVTAWbaW3+UTUKuPUJiBvvn4w4GtE8D+5MZSZ1124QfLT8BYy/s02Q0yaKafKy1I2CTRixhn8T2j1N82T8hZtXmyOuuFjdMzMO6EHnp4zfS7KEK9Ljp2IyDngQ5FeC6+I2QJwZiA8VNlY012kZx+nSIJ82FJfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTPrpXa5M1ap9lKKwm33oSN/TaNI/z1HIe2QVM9Usr4=;
 b=LFmGZw9dU5ogAbl5QA2SUb5wiuvwAwZtOsn6e6wANV989iGtCAtvAQhgOtof/qOa3bzbTBs0WKzyKk7KCHmOtHVqQ2dD874knx18Oetn4D88dDdJc8FcdKM4jk9zAsXOJdVrPQuiGYU3zS1UALZSdAHkOR/Z9Z+R5U8c+Wg9Bx8=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5511.eurprd08.prod.outlook.com (2603:10a6:20b:10d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Wed, 20 May
 2020 06:16:41 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 06:16:41 +0000
Subject: Re: [PATCH v2 1/5] block/io: fix bdrv_co_block_status_above
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200519195501.29071-1-vsementsov@virtuozzo.com>
 <20200519195501.29071-2-vsementsov@virtuozzo.com>
 <cd4c3996-703a-13c5-aa9c-664d2de0ca26@redhat.com>
 <3a66bacf-3462-a82c-c758-730107e75898@virtuozzo.com>
 <711cc70d-bc12-9fda-b24c-7b3acdd5cb08@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2de6a724-a149-0601-24f5-2c2cfa1cd052@virtuozzo.com>
Date: Wed, 20 May 2020 09:16:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <711cc70d-bc12-9fda-b24c-7b3acdd5cb08@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0701CA0012.eurprd07.prod.outlook.com
 (2603:10a6:200:42::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.147) by
 AM4PR0701CA0012.eurprd07.prod.outlook.com (2603:10a6:200:42::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.12 via Frontend
 Transport; Wed, 20 May 2020 06:16:40 +0000
X-Originating-IP: [185.215.60.147]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45e7ef25-167b-483d-c4d3-08d7fc855c79
X-MS-TrafficTypeDiagnostic: AM7PR08MB5511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5511335F467EA718C108159DC1B60@AM7PR08MB5511.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5KAVTjPogfTBt+J8u74w6ZwsBXPNai5KHS2OSN0BcfoDdHHApQ3vOLyuyq9Pdtuy7hJEzDucF7pqOdjyaVAIge54RWOJ5sY7agLvB8R23O1mu53XcAZ5LNAzeErr5lP0Y1CdEtnUeyimfceIiH2J7zExBIDQXWxNlNNdqzinoS5APPLXUSZdpA4+RfZxrXz+K6bGxuKQAyelUAfkimC9UrOkThOLbmwqPyO5a2YYUsw0A8VgtXfk91nAKWHbybsh9GvPpyBHTDssBsbtvAlNZDEyMpC+I//fPKvrbrrMBlCbWH77YtgCm9zb6n8HY/6vBX/bo8wo/Lk15lfRjezt92vgm5uBi1sYMtem2aFpNUZmysbn+lNeY4YaZCFZvaoQIX9dF+VOL1AByYLz3vHPYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39840400004)(396003)(66556008)(66946007)(66476007)(6486002)(8676002)(86362001)(52116002)(107886003)(16576012)(31686004)(316002)(186003)(16526019)(4326008)(8936002)(26005)(2906002)(36756003)(2616005)(5660300002)(53546011)(956004)(31696002)(478600001)(21314003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: o7KkjLY9xU/nm7uEc+UC7lQ3PHNAYO2xU2V4IX+KspjOAf0cHRFN1TmqeN6/O+umqUyOD2oxyhVyc8bveIvBxiwKFX14/+W/0cEZgIX6KJdRTEkG+waxNcmubejach/2Nf1mHfqfK/NYAg+imtur00PLHJkXYtPKOX6XCftCf6ZAB87gmnrBmSXyAPtwxOXY2O/np2AhjYkLrJpkcf+LNyAksnQoK75vdTMNUCfy4kLF/AaYE4w3sQFrefud4oC5tiqEhoF1FQLg/m2fbjTSjt7bIJmEZ6ybeuoFyJ0Vk+urkpV2I52wcU67w4LB247xKmHaP4cgf6JV86l5tn/QFBnIgCzkpcl2kGcqqUZdrrN8az8zMT3GIU0dSoHhPPpw8OVV+Kl57T8v9PB4cU+AlJtMdEA/PaIc3SUVNji+hfPn/6CyKSbZ+AaVJFzR/F1C1svSs0GBHidHA2lHOEvvrOwJ0I19SdPdoPOvTLwzJgsDePERn+7HFLYn3JumNdPN
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e7ef25-167b-483d-c4d3-08d7fc855c79
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 06:16:41.0071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1yyWivFg3XSh5Qoh5fDNitXIVoFQP5eapCgYPb6UdPZmormbGK5FNnu3w99pVgLOyLoPL3VqCaIipcHdbkVcwnHWnyOzb1oPcSELdittm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5511
Received-SPF: pass client-ip=40.107.6.121;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 02:16:42
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

20.05.2020 00:48, Eric Blake wrote:
> On 5/19/20 4:13 PM, Vladimir Sementsov-Ogievskiy wrote:
>> 19.05.2020 23:41, Eric Blake wrote:
>>> On 5/19/20 2:54 PM, Vladimir Sementsov-Ogievskiy wrote:
>>>> bdrv_co_block_status_above has several problems with handling short
>>>> backing files:
>>>>
>>>> 1. With want_zeros=true, it may return ret with BDRV_BLOCK_ZERO but
>>>> without BDRV_BLOCK_ALLOCATED flag, when actually short backing file
>>>> which produces these after-EOF zeros is inside requested backing
>>>> sequence.
>>>
>>> That's intentional.  That portion of the guest-visible data reads as zero (BDRV_BLOCK_ZERO set) but was NOT read from the top layer, but rather synthesized by the block layer because it derived from the backing file but was beyond EOF of that backing layer (BDRV_BLOCK_ALLOCATED is clear).
>>
>> Not in top yes. But _inside_ the requested base..top backing-chain-part. So it should be considered ALLOCATED, as we should not go to further backing.
> 
> Yes, I think I figured that out by patch 5.
> 
>>
>> Assume the following chain:
>>
>> top    aa--
>> middle bb
>> base   xxxx
>>
>> (so, middle is short)
>>
>> block_status(top, 2) should return ZERO without ALLOCATED, as yes it's ZERO and yes, it's from another layer
>>
>> block_status_above(top, base, 2) should return ZERO with ALLOCATED, as it's ZERO, and it's produced inside requested backing-chain-region, actually, it's produced because of short middle node. We must report ALLOCATED to show that we are not going to read from base.
> 
> Yes, that matches my intuition.  allocated_above says "where in the chain did we get the data, since it did not come from top", and the correct answer is "we got it from middle, due to synthesizing zero beyond EOF".  Okay, with that understanding in place, maybe this patch is right.  But I'll have to revisit it tomorrow on a fresh mind (it's too late in the day for me to be sure that I'm getting it all straight right now).
> 
>>
>>>
>>>>
>>>> 2. With want_zero=false, it may return pnum=0 prior to actual EOF,
>>>> because of EOF of short backing file.
>>>
>>> Do you have a reproducer for this?
>>
>> No, I don't have one, but it seems possible at least with want_zero=false. I'll think of it tomorrow, too tired now.
>>
>>> In my experience, this is not possible.  Generally, if you request status that overlaps EOF of the backing, you get a response truncated to the end of the backing, and you are then likely to follow up with a subsequent status request starting from the underlying EOF which then sees the desired unallocated zeroes:
>>>
>>> back     xxxx
>>> top      yy------
>>> request    ^^^^^^
>>> response   ^^
>>> request      ^^^^
>>> response     ^^^^
> 
> If we can come up with a reproducer where allocated_above returns pnum=0, that would indeed prove my initial hesitation wrong (perhaps by:
> 
> back    xxxxxxxx
> mid1    xxxxxx
> mid2    xxxx
> mid3    xxxxxx
> top     xxxxxxxx
> 
> for various different start and base points within the chain?)

Seems, we just don't have users of bdrv_co_block_status_above with base points within the chain, base is always NULL or backing of top. So, I don't think we have a reproducer.

> 
>>>
>>>>
>>>> Fix these things, making logic about short backing files clearer.
>>>>
>>>> Note that 154 output changed, because now bdrv_block_status_above don't
>>>
>>> doesn't
>>>
>>>> merge unallocated zeros with zeros after EOF (which are actually
>>>> "allocated" in POV of read from backing-chain top) and is_zero() just
>>>> don't understand that the whole head or tail is zero. We may update
>>>> is_zero to call bdrv_block_status_above several times, or add flag to
>>>> bdrv_block_status_above that we are not interested in ALLOCATED flag,
>>>> so ranges with different ALLOCATED status may be merged, but actually,
>>>> it seems that we'd better don't care about this corner case.
>>>
>>> This actually sounds like an avoidable regression.  :(
>>
>> I don't see real problem in it. But it seems not hard to avoid it, so I will try to.
> 
> I guess my real reasoning is: "I spent a lot of time trying to tweak that test to not lose the fact that the tail of the image reads as zero", because it looks weird if we later resize the image but still have a glitch in the middle reporting one non-zero cluster out of a larger range all because of the shenanigans that occurred around the tail prior to resizing.
> 
>>>> +++ b/block/io.c
>>>> @@ -2461,25 +2461,45 @@ static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
>>>>           ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
>>>>                                      file);
>>>>           if (ret < 0) {
>>>> -            break;
>>>> +            return ret;
>>>>           }
>>>> -        if (ret & BDRV_BLOCK_ZERO && ret & BDRV_BLOCK_EOF && !first) {
>>>> +        if (*pnum == 0) {
>>>> +            if (first) {
>>>> +                return ret;
>>>> +            }
>>>> +
>>>>               /*
>>>> -             * Reading beyond the end of the file continues to read
>>>> -             * zeroes, but we can only widen the result to the
>>>> -             * unallocated length we learned from an earlier
>>>> -             * iteration.
>>>> +             * Reads from bs for the selected region will return zeroes,
>>>> +             * produced because the current level is short. We should consider
>>>> +             * it as allocated.
>>>
>>> Why?  If we replaced the backing file to something longer (qemu-img rebase -u), we would WANT to read from the backing file.  The only reason we read zero is because the block layer synthesized it _while_ deferring to the backing layer, not because it was directly allocated in the top layer.
>>
>> No, if we replace backing file of the current layer, nothing will change, as _this_ layer is short, not the backing. Or which backing file do you mean? If you mean current bs, than replacing it doesn't make sense in the context, as block_status_above requested the current bs (as part of base..top range), not the other one.
> 
> Maybe it's just the comment wording that needs help.  After reading through patch 5, it looks like my problem is now coming up with a comment to the effect of "the top layer deferred to this layer, and because this layer is short, any zeroes that we synthesize beyond EOF behave as if they were allocated at this layer".
> 
>>
>>>
>>>> +             *
>>>> +             * TODO: Should we report p as file here?
>>>
>>> No. Reporting 'file' only makes sense if you can point to an offset within that file that would read the guest-visible data in question - but when the data is synthesized, there is no such offset.
>>
>> I don't know. It still adds some information about which level is responsible for these ZEROES. Kevin argued that it make sense.
> 
> It took me a while, but I'm coming around to it: my initial read was assuming that you were reporting that the tail was being claimed as allocated by top; but in reality, you are fixing things to claim it as being allocated by mid.  The former is wrong (top did not allocate, it deferred to mid); but the latter does indeed make sense (reading from mid ended up synthesizing, which means that our hunt for the data ends at mid and we never traverse deeper, regardless of whether base may also have data).  But now it's a question of whether the code matches that textual description, and I'm a bit too fried to answer that question properly today :)
> 
>>>> +++ b/tests/qemu-iotests/154.out
>>>> @@ -310,13 +310,13 @@ wrote 512/512 bytes at offset 134217728
>>>>   512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>>   2048/2048 bytes allocated at offset 128 MiB
>>>>   [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
>>>> -{ "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": false}]
>>>> +{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
>>>
>>> The fact that we no longer see zeroes in the tail of the file makes me think this patch is wrong.
> 
> So, if we can avoid that minor regression, and still otherwise report zeroes as allocated from mid, then I think we'll be on the right track.
> 


-- 
Best regards,
Vladimir

