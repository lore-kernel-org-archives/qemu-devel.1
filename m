Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC78C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:57:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27286206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="npvaoq5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27286206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtCSL-0004sq-FZ
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 11:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jtCRP-0004NP-LG; Wed, 08 Jul 2020 11:56:59 -0400
Received: from mail-eopbgr70113.outbound.protection.outlook.com
 ([40.107.7.113]:45223 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jtCRN-00012D-Td; Wed, 08 Jul 2020 11:56:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iq4Nvng1hRvoK7k3sD9dDp+DX73zExwwwW4mB3oXr+Qpc2WOka4yO/vfwjnWP/OfmhRL/WcX64ert3ava5U4SEV+Yrz+wSl3yI6XowJWGCro34dcSCdpBRPLyGkTgYeHxyR/PycQcB66s9MgCRhOyfv2dhgHk3k1cFPQL1CIOEag17unFcHmSWRS5PinK7Z0No5//i1DslatmaEZZalbrrv3YFEGfEHJF+54apOaCoqrXcyax+DN3mHns9sCFn8r+GfURJ8bbkpnBDc2kNFNtiWkI4WDLxkAzLFFz9F3AjSsfFJCLjRFjPBKqpYyURvYUkGMiVrFUOn70nW+AaQ0rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUtoU6ch9wEP84g4fI7cVJmy0crIj7u1vZ5lDyUNnbw=;
 b=i5r+Vrno2IOsWgWlhyQhAvMa8gOd6U+GX4DiOaAbhaBas4KA5MVGWn0GS2vopEa7MeZpBMV5fz1WhxNeAEpwwsta30QjsG7GmcNQkcvtQPGR42El6+ntraPnonV9qNfz3BtwTIZfjZyADHGE40GkPh7ki8jM9ScSLpEo+mygkSQlTuO7/hlgKmi/Y/E1jZnCHFtV9ZYU+VmkxqP85YLN9vZdu4ZGYNS0zcjjNAP3vH5K7fcqf48MfWyUBdeqs9P9wDqtaMKV5aVVgyt74cOXDhV12Eze1Bs5IJlylevzpMoQ7UMsCDCgFEi6e4c01uj3KNkPWR7JgDTtxMQUc1aHLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUtoU6ch9wEP84g4fI7cVJmy0crIj7u1vZ5lDyUNnbw=;
 b=npvaoq5Yl50H35dyOHmmYc6VH/8x6i8kLDXUXF6VyA4OwaXngs4+Pgr9C/+YMmh/KnXBHoAU3swF0OcXQK3P0rEt+Pv4vWzy0QK/cN8qif1GTPwSlZios+tQmK55ZkPCZwwO80ML/Ap7r5zA4N3sP/g/TOUDAF9SFx8PyqWoexA=
Authentication-Results: acronis.com; dkim=none (message not signed)
 header.d=none;acronis.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1652.eurprd08.prod.outlook.com (2603:10a6:203:3c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Wed, 8 Jul
 2020 15:56:54 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 15:56:54 +0000
Subject: Re: [PATCH 2/5] block/io: introduce bdrv_co_range_try_lock
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200620143649.225852-1-vsementsov@virtuozzo.com>
 <20200620143649.225852-3-vsementsov@virtuozzo.com>
 <20200707161024.GB459887@stefanha-x1.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6216a191-6039-0bd2-6f1c-459932157f96@virtuozzo.com>
Date: Wed, 8 Jul 2020 18:56:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200707161024.GB459887@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0100.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::41) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.17) by
 AM0PR01CA0100.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend
 Transport; Wed, 8 Jul 2020 15:56:53 +0000
X-Originating-IP: [185.215.60.17]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a70ecdd8-3dd5-40de-cdba-08d823578944
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1652:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB165272B3F50B5867ADCD68D8C1670@AM5PR0801MB1652.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQz8tZXK+vZhjjdL1ZeszGchN85ERZdVdwwJYlvg0gqhNon2egs2jb5+Uxkx44DrCDbMbDzn08n+8gb/aAnC2rJ+1VyVJYeMrV1PMstyhjTi9zOwuPbRyBJX7Oz2x8vFCQvCJfS/YEYtf56JfW2yoNXStGkjXwnz4u4/Skvla7wCiw/rS0IDLqhWY7PAtoXwjXYrDUm6DPo3eACTwsDgV8UQWxLHs1HjRJffMn6jykeKjMmBbQoJBHz0vkPClAI35k6kulSUkk0ElzD0CGQASmKC5y+fXIt1NTxdIdVfYB9J4TTQdxww9dsYypM2OH6ATPMri9bq0QQxmFtMhZyA5PcH3ACCddKOxY2z+bU90xZeilQn+KePZPW7wX0aD9Xj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(366004)(346002)(136003)(39840400004)(6916009)(478600001)(16576012)(316002)(8676002)(6486002)(2906002)(36756003)(66556008)(66946007)(31686004)(66476007)(86362001)(956004)(2616005)(26005)(186003)(16526019)(4326008)(83380400001)(5660300002)(8936002)(31696002)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: sZV9l++YL0uUGq4jgEpnj0qQhjcNIUmKjzx2NBMJez88lDtZJi/BdM/l4Pg6/WHK/EJ0FFcStV87GJkS4f7kaY8R1g67R633tlqWV/V/1oiW98MEKzNEDDMtDgIlITA/jeVvMj3RLk7qjPh5VcWJdEGypyB1cIlzFYqTr0Y93yw5XbfOqK5zFSmllmSnyt4PAr4kiPIEOzyUFM1yY69trVwO4CLIUZUle2Wabm6bonjXDd9uad+1sIfmfGmSGxtzL9rZKKr49405KKvsgttHVsTnXsumTjfrH5DLPJw3kmWQD0DUbjXgXmY/uGuKJBh43apwbnCH7W/xPA+/ZuhSfd7er46AoXQBACIztncy1v1DmTJI6h7LYq4WAFmUirGVhXVbywO6Ngsqk/1nzIsxmt/O7CHF3/67Zic2kaDpiUjrQQLBnd/meA57GYbiA2SWZv5kNEJQqYTTL5Nw2cbyvf/9eZ6YbUXuVZCaM0BACOk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70ecdd8-3dd5-40de-cdba-08d823578944
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 15:56:54.6304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zF08N84nVpRaHYb52HdjAANMAiCbeNc+vXsAcjfKEsuBl6cTcGKT12uWbJ9b342EyvpI3nWOj8RMPnR5GCy/OOSbe5AOkCFgeRMa9TbXknQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1652
Received-SPF: pass client-ip=40.107.7.113;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 11:56:55
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 Anton.Nefedov@acronis.com, armbru@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.07.2020 19:10, Stefan Hajnoczi wrote:
> On Sat, Jun 20, 2020 at 05:36:46PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> @@ -83,6 +84,12 @@ typedef struct BdrvTrackedRequest {
>>       CoQueue wait_queue; /* coroutines blocked on this request */
>>   
>>       struct BdrvTrackedRequest *waiting_for;
>> +
>> +    /*
>> +     * If non-zero, the request is under lock, so it's allowed to intersect
>> +     * (actully it must be inside) the @lock request.
> 
> s/actully/actually/
> 
>> @@ -745,15 +747,26 @@ static bool coroutine_fn wait_or_find_conflicts(BdrvTrackedRequest *self,
>>               if (tracked_request_overlaps(req, self->overlap_offset,
>>                                            self->overlap_bytes))
>>               {
>> -                /* Hitting this means there was a reentrant request, for
>> -                 * example, a block driver issuing nested requests.  This must
>> -                 * never happen since it means deadlock.
>> +                if (self->lock == req) {
>> +                    /* This is atomic request under range_lock */
>> +                    assert(req->type == BDRV_TRACKED_LOCK);
>> +                    assert(self->offset >= req->offset);
>> +                    assert(self->bytes <= req->bytes);
> 
> These assertions do not catch requests that start within the locked
> region but span beyond the end of the region. How about:
> 
>    assert(self->offset + self->bytes - req->offset >= req->bytes);
> 
>> +int coroutine_fn bdrv_co_pwrite_zeroes_locked(BdrvChild *child, int64_t offset,
>> +                                              int bytes, BdrvRequestFlags flags,
>> +                                              BdrvTrackedRequest *lock)
> 
> The name is confusing because _locked() normally means that a mutex
> should be held. Functions using that naming convention already exist in
> block/io.c. It would be nice to distinguish between functions that need
> BdrvTrackedRequest and functions that must be called with a mutex held.
> 
> How about bdrv_co_pwrite_zeroes_with_lock()?
> 

OK.

May be _in_locked_range ? A bit longer, but more understandable.

-- 
Best regards,
Vladimir

