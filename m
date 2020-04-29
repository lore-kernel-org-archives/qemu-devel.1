Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3EFC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:08:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42BB02087E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UvTqhoOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42BB02087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTlVn-0005X5-8k
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 08:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTlSZ-00047x-Fd
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTlRy-0006RV-68
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:05:03 -0400
Received: from mail-eopbgr50109.outbound.protection.outlook.com
 ([40.107.5.109]:52812 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTlRx-0006Fb-NA; Wed, 29 Apr 2020 08:04:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+CXU0ivpgxMd8LYu4A6NuHt3K56jsgi5IEQSKiCl0QZfv9t0J16Cw8uksY8/9VN3VhZoh/ExzmlHs9ldG5HId2Xr/XkOh6Xo4bzjewaT0EeDF4D8c0GboFQFXghqNrrT4j2XfKfCbcUwnoej2bPrtzIDCie8lhEdInJqaje884fC14mIwJnQvkbG8c5gpm9g/MrjsOWjmr+5girJ5XdcqstAYXnWYUQZc34ujrh/J/yGr+8mB5iZdlso1+POR+1Znl/D0bJFCvb8loqEI7yGjBvjQcemdugqWpSby108roOQEG2Xd1G3ot9atGwOrZLiGWXpP+Zu0OdViz/X5YN0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRiOL2ngvQfwSXlkBrf2FKjdcsvhZWqRhBx9lMquJTc=;
 b=AejzFqr11gPqfZvNa9lZTgBw8LdXgG8l/xs0uYypir2PR9C83ShCePXiau+047EnI30wMiMP/hSQ1JiFtkg7JsxjyonYXuOQvDo1eFomZmu33ebSHfhObmqMa7yGptxAcaW+sst6D9N0oH8IZzrapMfTDqQX8FwTSffPhuci5WKP5ROXnK7ktDTGeWxJ95FcHyPaJnzZYxzCO9vBi9tfQq3fAGI0Oc0JDmjdbza8+7HJYuK8gkqthxvR4GGNpW6eHJWNxs2ceT7wy1fAwjGwgWeFc8o4q0QppmpaQ4jRHsSPw/OxZtrq9hdUepAqDUL0qtQMuFJoazTQVryYT+YbAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRiOL2ngvQfwSXlkBrf2FKjdcsvhZWqRhBx9lMquJTc=;
 b=UvTqhoOFsGkvCIN+MgoPw2Skb6p8vI5HlYKgvrySUXLxH0nf73JqNN2MT6mVKn9dsr8ASDjwOAWQt7Pm5+dihEA3bSCHZob4M5DBBdpl+Cr/xwjry7iv5x4f0bVj3NrLVLLThux/hhzGdgF/XKaI/zFVq7QBepDEaHBt/l2WNZs=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 29 Apr
 2020 12:04:22 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 12:04:22 +0000
Subject: Re: [PATCH v3 4/5] block/block-copy: refactor task creation
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200429061039.12687-1-vsementsov@virtuozzo.com>
 <20200429061039.12687-5-vsementsov@virtuozzo.com>
 <affc8770-2b70-c3e4-af1b-ca620119c2d5@redhat.com>
 <92dd552d-b181-5b39-c796-e228c4d33379@virtuozzo.com>
 <0f14b02d-884a-9581-f1c7-7133e6d36557@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200429150420718
Message-ID: <3117b258-aecc-d588-68a9-1b32ee8acff9@virtuozzo.com>
Date: Wed, 29 Apr 2020 15:04:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <0f14b02d-884a-9581-f1c7-7133e6d36557@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0080.eurprd02.prod.outlook.com
 (2603:10a6:208:154::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.184) by
 AM0PR02CA0080.eurprd02.prod.outlook.com (2603:10a6:208:154::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Wed, 29 Apr 2020 12:04:21 +0000
X-Tagtoolbar-Keys: D20200429150420718
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26c8bb3a-f1c7-4eec-d9a6-08d7ec357421
X-MS-TrafficTypeDiagnostic: AM7PR08MB5494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5494F634C5E65072C9FF810AC1AD0@AM7PR08MB5494.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39840400004)(366004)(2906002)(478600001)(5660300002)(31696002)(86362001)(6486002)(4326008)(107886003)(66556008)(186003)(2616005)(956004)(66476007)(16526019)(66946007)(16576012)(316002)(52116002)(8936002)(8676002)(36756003)(31686004)(26005)(53546011);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0K0w/l+1BKQKz81hm7RAwiAIb0D769MA6ljJSdgijSlEVmv5Cl4ZceLHOf9VDhaJIVA+JE6+zpPEPATKeNdOAHUCTa/+qPIOeVKSLzMg3GcXqNQXzs1KX3ZmatMwyubRu8jzbrBwh6CFw5rU+zAQYEj5/02x6VZLDTvUybpfJHGD9hi+zAPbEzXQfAjrzyj+HauFfasYaKMMbFgTpDPdF3wrPwv7ACENIMAitohGzLuskZoTkvgdXCmF/i6KoTmBAi7OyEopgen4ER7w4E4DrqCS8HHp3/CxJ5LuuRgPf8SGa53L2ki0+WHVj26/rN3MHPkqpfm2vKuNUlk4EAaJd85xXQHy4jPUUUnFDfDWLeaQ6+mbA6OksYDlvAJb37DMrfTr0E6cwmle8B7hlAppv3JvZy68kWofgRk41dqfgkGFFjvaV7AFAMHyaO/Ceb8l
X-MS-Exchange-AntiSpam-MessageData: wmq2hQSJH2Pzv5m3LrGSQE7laWJ3f+1IwVYQmfyS668i5vOYB61IQ7mYSCTXks+d7Sdsd7/k/KmDu9OwuX8eXucdlagljhvxim/4wS5zGO9Yrqg3xKhc4XEW3Lr2RvCusVITA8NZsfBo+dcuLtdAVY5pIMETR3SlNWjGWh4djFW8dBMMox8LhHmeTWtuH5NHliWpSeZ8BN1X+TTKSijlUAlCwt5KvsSFKqRppfqymIPLre5O19P82PL77WFr6ICzm7AqEhaNkhyeDAj2Zu1/tkFgR0hOgon969MLXL8CFwgAOkkuSzES3t0O34WSDJI/ob8nFcYnZpnd5cPmEvTKmpp+fxphcnPtaOmyM5fyt7H6p550inJzoYkk7y4NgRZjL9zyluPyGdq6ZXh5HeQy4CUT5FFzXYv6VZ3t1ITQ8A5Krk5mhnuw9pvsrl0P3z0hmc2XQkvihllkx3SEqYygDaoYF2rplyQvZ25a5orh44Y+Ee1kigmzdCkk5O6H4UbMr4t2oq3KArgJHiZpJRdJ2Dn+VpTWFVFRYQXxfveyxzoWorlgjOA8jt+ZE9ZR6nQoE0Yw3eQFR84Ba3JtC7cY/NkR/VJiDCZmhGiHY0/izSK/xCThDbPD81nEjyz7ivVMiyu42ht90zyETAZkTX0BksdXaF6h0JmfWgm2C7ZgCrhJ5sqxRbhEMbesj1LPPjRsHyn5W21ZWbuo1f3RqWs3Ufav7WFcEfuKNbg3xnZCYinXepi0+dw6rryp4rxFcCSQykGqOfPk5GU7vp9ScWs8czMN0vledhuO0NO8J0+nXgs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c8bb3a-f1c7-4eec-d9a6-08d7ec357421
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 12:04:22.3156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mf/1C5A+01weL+4MhQO46ZjBzZUBqx/y8fpRlOru/q1hyuGV980Ggw+bbo2iOreNLvLrvzzNXtJXHKuJFDp7f5JMxTA5Gw6y9wMvgzPepfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5494
Received-SPF: pass client-ip=40.107.5.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 08:04:23
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.5.109
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

29.04.2020 14:56, Max Reitz wrote:
> On 29.04.20 13:54, Vladimir Sementsov-Ogievskiy wrote:
>> 29.04.2020 14:38, Max Reitz wrote:
>>> On 29.04.20 08:10, Vladimir Sementsov-Ogievskiy wrote:
>>>> Instead of just relying on the comment "Called only on full-dirty
>>>> region" in block_copy_task_create() let's move initial dirty area
>>>> search directly to block_copy_task_create(). Let's also use effective
>>>> bdrv_dirty_bitmap_next_dirty_area instead of looping through all
>>>> non-dirty clusters.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>    block/block-copy.c | 78 ++++++++++++++++++++++++++--------------------
>>>>    1 file changed, 44 insertions(+), 34 deletions(-)
>>>>
>>>> diff --git a/block/block-copy.c b/block/block-copy.c
>>>> index 35ff9cc3ef..5cf032c4d8 100644
>>>> --- a/block/block-copy.c
>>>> +++ b/block/block-copy.c
>>>
>>> [...]
>>>
>>>> @@ -106,17 +111,27 @@ static bool coroutine_fn
>>>> block_copy_wait_one(BlockCopyState *s, int64_t offset,
>>>>        return true;
>>>>    }
>>>>    -/* Called only on full-dirty region */
>>>> +/*
>>>> + * Search for the first dirty area in offset/bytes range and create
>>>> task at
>>>> + * the beginning of it.
>>>
>>> Oh, that’s even better.
>>>
>>>> + */
>>>>    static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
>>>>                                                 int64_t offset,
>>>> int64_t bytes)
>>>>    {
>>>> -    BlockCopyTask *task = g_new(BlockCopyTask, 1);
>>>> +    if (!bdrv_dirty_bitmap_next_dirty_area(s->copy_bitmap,
>>>> +                                           offset, offset + bytes,
>>>> +                                           s->copy_size, &offset,
>>>> &bytes))
>>>> +    {
>>>> +        return NULL;
>>>> +    }
>>>>    +    /* region is dirty, so no existent tasks possible in it */
>>>>        assert(!find_conflicting_task(s, offset, bytes));
>>>>          bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
>>>>        s->in_flight_bytes += bytes;
>>>>    +    BlockCopyTask *task = g_new(BlockCopyTask, 1);
>>>
>>> This should be declared at the top of the function.
>>>
>>
>> I just thought, why not to try another style? Are you against?
>> Requirement to declare variables at start of block is obsolete, isn't it?
> 
> Oh, it absolutely is and personally I’m absolutely not against it, but
> CODING_STYLE says:
> 
>> Mixed declarations (interleaving statements and declarations within
>> blocks) are generally not allowed; declarations should be at the beginning
>> of blocks.
> 

Oh, missed (or forget). Let's fix it? :) Not in these series, of course. OK, I'll fix the patch.



-- 
Best regards,
Vladimir

