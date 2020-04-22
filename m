Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0698FC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 18:14:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0FC82076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 18:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bDMfOSWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0FC82076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRJsl-0001Kd-0s
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 14:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRJpC-0006hJ-Pj
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRJpC-0007E7-51
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:10:18 -0400
Received: from mail-eopbgr40113.outbound.protection.outlook.com
 ([40.107.4.113]:41953 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jRJot-0006uH-SM; Wed, 22 Apr 2020 14:10:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAq2mtHs5id3sZPf2ttX2LyocKPU4gYv3lBjiB/lLMRsgUAspbT0BZRnNuAildgqJAg/W9+byEQBE70GEiL1mC1Rbk30wHbPaeh2b/QGAnOzOxqoBdPKCPiGkZb1vjO23Hk3FJ3wLltY70HZMt0oBxHu7C1in3llsvKJjIywsuNCehkguczhz7G/nTHnBk3y489HmoQ9lLmeY6QeGi8W+zk3fsWgaCF49wn5bjZea9iNnLzleeMI95oPAgQo1mP+yXbjSS+3NaSUag3IuA6oSc0dNyRaXV+ZFRbN5P+niA7Fb9O0lHcVNovsxijJ4se/UuL0s0YJxMbg0td3J42M2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vVCtJGYDHyhfA598Ym8WXc5ATEAEKPhYy08aE6oVS0=;
 b=UqqHazC43EtVc6eVmmyPwgRkuW47mydRmOrSIuRMpQFF5sltROYD8ld+pA1r9362T18Jy+x+CzNrGpmd1axakfBPvWg6QQCw3hmJxwrYeY3hmnLClZAF2ZCQ6D/6He4WNyaqXI9Ma8grsfTNQPtch+WcmpYqD9Stbuh7/5bDwY2JeYYMOCsINRqU2E7Yk/Q0L+aqbX2rBFjeNqRNPIuj1x28A+dVOo6WvoAaRS8U/9/n/9QuRywsk3Yyf2GWD5wpZ0bPU2J5KWkOQfQkB5CwusIE8nfQKnU0uC7lEt69wwSrdzehBUZp0qo9qBp11C+CIjazLixsGbZEWPAff/eRoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vVCtJGYDHyhfA598Ym8WXc5ATEAEKPhYy08aE6oVS0=;
 b=bDMfOSWzSUuwxqdSNb1DL+dIaehRAzH9n8Ilgy0mb1iJsZOmDv1w7yBnFGFjDD2SP8lLzuwfTwGxzF2U7BggUgABPI5dxwhRtLl20dEmtWk2ebJAAqXLpqVlGi7YYZ7rs/RmhxCCNXw3ddjxBkQN1IKTUkBorrhzNxvDI7We3wo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5334.eurprd08.prod.outlook.com (2603:10a6:20b:10b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 22 Apr
 2020 18:09:55 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.012; Wed, 22 Apr 2020
 18:09:55 +0000
Subject: Re: [PATCH v4 20/30] qcow2: Add subcluster support to
 discard_in_l2_slice()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <99b45e3beb4a38b17eb50fcde1e09cdefdb99724.1584468723.git.berto@igalia.com>
 <2f284a39-64b8-ca64-4465-12f9f0f8f7e5@virtuozzo.com>
 <w51o8rjs9gj.fsf@maestria.local.igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200422210953409
Message-ID: <7de731d4-c78e-b533-8bbb-dae57ba24c46@virtuozzo.com>
Date: Wed, 22 Apr 2020 21:09:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <w51o8rjs9gj.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.157) by
 FR2P281CA0035.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Wed, 22 Apr 2020 18:09:54 +0000
X-Tagtoolbar-Keys: D20200422210953409
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc9b457a-e83d-42bf-2928-08d7e6e85c68
X-MS-TrafficTypeDiagnostic: AM7PR08MB5334:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53340D7CD3C5D2ED08A786C8C1D20@AM7PR08MB5334.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(136003)(39840400004)(396003)(86362001)(52116002)(31696002)(2616005)(16526019)(26005)(8936002)(81156014)(8676002)(186003)(36756003)(956004)(16576012)(316002)(54906003)(2906002)(478600001)(4326008)(66556008)(6486002)(66476007)(66946007)(31686004)(107886003)(5660300002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uesssIKkMVcTCyKjwssyHAhwdVs+qEJileUNxKKv5Rh2as+IiWTLkoe77Pl/hs5N6YbMxTYWhQnwkTPrvJfU+KrcPdsA5TSim1WiMu/3mvb55IDHRte3uXRHRla8LkoJReEeyVytvmyOqNBQhbAcXEZmLslg3Q4eGkvzrblag6tW66iaUFxGzjl0gaY6sVY2+Xx8cs/Mvk5bsonBqXicy9PTSEgpum65oTce+vPejkk1vz08f9i8NkUlo9YxyenZc11w6V9s8D0YpJ/o+pn0v8k87NfQsgmRHk2TINJFYKdDzl+D3xSmbz1415oHI34ZigXp/1Qq2l9mIu4LwD726F+Sl0APJo3Xuqk/UGqaoK9B1GSIcVb/aV0vn3w/o5r/d94VQ59jg1bkhwKj/Ygov56yumJEDf6IxjNx0EqOfnI+BSktrcHYRetpRmeOCB8n
X-MS-Exchange-AntiSpam-MessageData: wJ/FJoaaC2cEXnP9+JkWAObKtIh2edhVlfggjFrYHd15Iqmna1Cxxv/LXyIRE20aFWocQ3f85sIEtPJQazgfmaZogQNZz/Jm7GdHKGqqYfVtVsjMqezPJJ33YiCtNSVMZSTgctA9PxueTnPuz/xRkg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9b457a-e83d-42bf-2928-08d7e6e85c68
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 18:09:55.4679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+rPKkRjt0DydvU+7Kv0cuBybIF1QA0EQk9SrG7scecNa5Ayy2iuNFJnoArno2LXhHLFWC3jq1B21nVqdVNRFxIjC8yqD0bxQ52sOg0nGOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5334
Received-SPF: pass client-ip=40.107.4.113;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 14:09:56
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.113
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

22.04.2020 20:42, Alberto Garcia wrote:
> On Wed 22 Apr 2020 01:35:25 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
>> 17.03.2020 21:16, Alberto Garcia wrote:
>>> Two changes are needed in this function:
>>>
>>> 1) A full discard deallocates a cluster so we can skip the operation if
>>>      it is already unallocated. With extended L2 entries however if any
>>>      of the subclusters has the 'all zeroes' bit set then we have to
>>>      clear it.
>>>
>>> 2) Setting the QCOW_OFLAG_ZERO bit of the L2 entry is forbidden if an
>>>      image has extended L2 entries. Instead, the individual 'all zeroes'
>>>      bits must be used.
>>>
>>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>>> ---
>>>    block/qcow2-cluster.c | 18 +++++++++++++++---
>>>    1 file changed, 15 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
>>> index 746006a117..824c710760 100644
>>> --- a/block/qcow2-cluster.c
>>> +++ b/block/qcow2-cluster.c
>>> @@ -1790,12 +1790,20 @@ static int discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
>>>             * TODO We might want to use bdrv_block_status(bs) here, but we're
>>>             * holding s->lock, so that doesn't work today.
>>>             *
>>> -         * If full_discard is true, the sector should not read back as zeroes,
>>> +         * If full_discard is true, the cluster should not read back as zeroes,
>>>             * but rather fall through to the backing file.
>>>             */
>>>            switch (qcow2_get_cluster_type(bs, old_l2_entry)) {
>>>            case QCOW2_CLUSTER_UNALLOCATED:
>>> -            if (full_discard || !bs->backing) {
>>> +            if (full_discard) {
>>> +                /* If the image has extended L2 entries we can only
>>> +                 * skip this operation if the L2 bitmap is zero. */
>>> +                uint64_t bitmap = has_subclusters(s) ?
>>> +                    get_l2_bitmap(s, l2_slice, l2_index + i) : 0;
>>> +                if (bitmap == 0) {
>>> +                    continue;
>>> +                }
>>> +            } else if (!bs->backing) {
>>>                    continue;
>>>                }
>>
>> Hmm, so you do continue if full_discard is false AND bitmap != 0 &
>> !bs->backing,
> 
>> but you do not continue if full_discard is true AND bitmap != 0 &
>> !bs->backing (as you will not go to "else") branch.
> 
> 1. If full_discard is true it means that the entry and the bitmap should
>     always be set to 0, regardless of whether there's a backing file or
>     any other consideration.
> 
>     This is used e.g when shrinking an image, or by qcow2_make_empty().
> 
>     We can only skip this operation if both the entry and the bitmap are
>     already 0 (the former we know because of QCOW2_CLUSTER_UNALLOCATED).

Ah, understand, sorry. I thought that behavior was changed accidentally, but it is for purpose. With old code cluster is already unallocated, but with subclusters we may have some ZERO_PLAIN subclusters.

> 
> 2. If full_discard is false it means that we must ensure that the
>     cluster reads back as zeroes, but there's no need to clear the bitmap
>     (in fact we must set QCOW_OFLAG_ZERO or QCOW_L2_BITMAP_ALL_ZEROES
>     depending on the type of image).
> 
>     We can skip this operation if there's no backing file and the cluster
>     is already unallocated (because then we know that it already reads as
>     zeroes).
> 
>     One optimization would be to skip the operation also if the image has
>     subclusters and the bitmap is QCOW_L2_BITMAP_ALL_ZEROES, I can do
>     that for the next version.
> 
>> In case QCOW2_CLUSTER_ZERO_PLAIN, worth assert !has_subclusters(s) or
>> mark image corrupted ?
> 
> I think that should be handled directly in qcow2_get_cluster_type().
> 
> There's currently an inconsistency now that I think of it: if an image
> has subclusters and QCOW_OFLAG_ZERO set then qcow2_get_cluster_type()
> returns QCOW2_CLUSTER_ZERO_* but qcow2_get_subcluster_type() returns
> QCOW2_SUBCLUSTER_INVALID.
> 
> Two alternatives:
> 
>    - We add QCOW2_CLUSTER_INVALID so we get an error in both
>      cases. Problem: any function that calls qcow2_get_cluster_type()
>      should be modified to handle that.
> 
>    - We ignore QCOW_OFLAG_ZERO. Simpler, and it would allow us to use
>      that bit in the future if we wanted.
> 

Hmm. Actually we don't check other reserved bits. But ZERO bit is risky, we may miss data corruptions during transmission to the qcow2-subclusters world. So I'm for the first variant if it's not too huge.




-- 
Best regards,
Vladimir

