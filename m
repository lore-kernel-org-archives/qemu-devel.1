Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9341C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 19:00:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 316BE2072E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 19:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="T46zxzDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316BE2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIz8R-0007lE-8B
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 14:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIz73-000782-0D; Thu, 17 Sep 2020 14:58:33 -0400
Received: from mail-eopbgr130113.outbound.protection.outlook.com
 ([40.107.13.113]:44182 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIz70-0005aw-Oh; Thu, 17 Sep 2020 14:58:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBVIiLAm+XGIcmZU5p7jpD6/5xK1P4DpMzImZRe0W1+LDexz6qS0YfuC9RDwgzZ/WCdskJggEnc4WOI8LB8wUz/ZPT1ExRumqaR86OKMulY7vVJlsVEXggsbz15Ryg7NzQH1CHOpoQYJ5gKS9dMyqccKD/h07caULHnwav9D/uu0cmJHsxJG2KwAQEwRWQdo3Q8Qv9Xo4Bent3oC4oVf1kn7qjL56A8R+739vC7It6Y1a88Qjp+CJi110ep2Nv9beIoEY309XjZ5ckLyiKh+PooYWXK7Tj8MjnzQER0RCo8TeY1xxZIeWaGtleuB1z0g6yrvYkEZOhJ2mDm+ZkPn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYj0X3RNJBAU2DNgSuATIu9STQGN0AbHbWF0ogkqc4U=;
 b=E3XE7UKObStB7h8K+IC9i6vhFzPw2Zv2IPOrdA/dpXHkvt+OMIi+xWaZK8r5/MqML8bFBblfnhyF3HBuVn/yO6BYBMkWGIVaMrwL+mgfTW5JgheTchcJj5C/M9RwZIYYu+pxaV8vdW4bzfy68GIIij/H5WO/Ne51FjI252uRJwOCZOyBe0GX2gam91wKk0gw2sA6+E/fgzk62N6gvqxxkKIGnEEXpmwn9eKOyI6KxjxEQRmpB3fb5iCkLLvDgSlyqE+VAfK5I8ogwUIW4EUBPKq2Bu4BYWheZqWtZG9p4W2ilRma/nK+Jy2w6JqoDFvMgm5VqtwT3G/QeSYdJKVGCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYj0X3RNJBAU2DNgSuATIu9STQGN0AbHbWF0ogkqc4U=;
 b=T46zxzDR9mEqz9cK64ByzY3RhpmySrVN36wPgJsRkdRcFHtCu753anvxdeBiY2AqyWPV8mHLyTdg13AiqeNvjiySLsYpFPgqAPFKISG3AZPfttxd39MModXa94MX7kEkExv/wY6C6mum6KF33dZfiyApxfw3OW8lD/Np8809aco=
Authentication-Results: kaod.org; dkim=none (message not signed)
 header.d=none;kaod.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2532.eurprd08.prod.outlook.com (2603:10a6:203:a1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Thu, 17 Sep
 2020 18:58:25 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 18:58:25 +0000
Subject: Re: [PATCH 10/14] block/qcow2-bitmap: improve
 qcow2_load_dirty_bitmaps() interface
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 jsnow@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 pavel.dovgaluk@ispras.ru, ari@tuxera.com, mreitz@redhat.com,
 kwolf@redhat.com, groug@kaod.org
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
 <20200909185930.26524-11-vsementsov@virtuozzo.com>
 <w51v9gc5pjq.fsf@maestria.local.igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <bf314243-c5d8-acf7-cb1b-6101b94d3150@virtuozzo.com>
Date: Thu, 17 Sep 2020 21:58:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <w51v9gc5pjq.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR05CA0010.eurprd05.prod.outlook.com (2603:10a6:205::23)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.75) by
 AM4PR05CA0010.eurprd05.prod.outlook.com (2603:10a6:205::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11 via Frontend Transport; Thu, 17 Sep 2020 18:58:24 +0000
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5680123-06dd-4581-73c0-08d85b3ba7fe
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2532:
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2532F43F4C58331F49840B63C13E0@AM5PR0802MB2532.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8kEvDy4lCpYWEtz+49l7crX5PgGNUbV9u69zilPkeCsFTAP6DLDSuEPJunJsIZZLcHONJNIcRgCzO5yad0OVTzG9U3v7IbaLBqE2JOAOifZN810pSBOw+QOb9I/qIfJ5qRIteXv+YffkQf0TseYZhzZZboeYn1KiCUpLgnlXQqtLZlpxWLc3stRlqGoEzkj9Khsx01I55gMFG8wb/omBxEKqypiUznsco/1+pkSec0OqG+mLmXtIr4Nrx/3UpgUwY/1gKC2p3ZMVuNOFZhzydgRO++jUysVzI7IzTsKHZxXmMuWcG0L2DdXJag6bCaanDvm8i/PfM5JqBvYRkA45O9LjlMjxp4tWe3cfW4T6uAwx6L9xUMApTQeVyC+wqopXSi673WfCYaffjE0ofacWNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39840400004)(31686004)(52116002)(2906002)(5660300002)(4326008)(26005)(186003)(16526019)(8936002)(6486002)(956004)(2616005)(66476007)(83380400001)(86362001)(478600001)(7416002)(66946007)(66556008)(8676002)(36756003)(31696002)(316002)(16576012)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: XDECFwnRZOsyvhhDOitGpMn9MBdSZww34dktnzyH+lodY8UERLF8/uYsL0+VIZDZzNhy5zNDJcj9+WJ7hmIMFIq35/zzfKafcZPTIcMuw7kndN6b6mw4HQq8K05OCeuvZPFBs4ScyquKZ8Iusj1LV4F03IA0puL4ZSW9td8Ty5T19nLylE/DzWf7d35+BRLy1enJIbytnWrIQYdgFOefzQomkJk1Wa7ybhyh2Lr+6lZyit7/C5Uz3zsMM5B6YRpUOrbgIuoWIA3ale7l6vN5BikyhdBIsS/aEzkvK8z42toaYAyYsE59aC5eDBk/8Fu/PE4rKSUW7b6ozRLwoCdgF453dgpoGtIs1/iUUBh3LZbkr76DS9kk+HwJEfEtlUUzOLAoKmCQy8ugNC9TI09cy9QhfmvxFBTIDqzw7/qze2/0m/eErMDl+9QSqaifnuT0rmnjAo8ob0S14jnpdMILjmuqAyP3dtWS29VEmwOq+Hd+4cFoiYkHO5nSety7KyXKUO67NEaUwdwh8CO/4uhH+h6o7c5UZCFA1Os9I8EWx4pX69Q4s2gSN9QssfkthBIoYQrk73SbyfD8QjRA1OkyJJw6FWbjF4IrJS82l1RKga1Yt3JGP+h/32PSn3fyQOBp03CPr/xVQgH78KVAy+hCdw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5680123-06dd-4581-73c0-08d85b3ba7fe
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 18:58:25.3759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CA2Rx0bB7YRK2J0zvJmaicKAwKFwJ8HZYrHSHcWDRAxF8W+jrCRErkElnkeCMd6MGiDbefS9HvqQeQhzOfzucO+p4e8pSJ9+B/m7SX+VNBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2532
Received-SPF: pass client-ip=40.107.13.113;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 14:58:27
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
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

17.09.2020 19:35, Alberto Garcia wrote:
> On Wed 09 Sep 2020 08:59:26 PM CEST, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>> -/* qcow2_load_dirty_bitmaps()
>> - * Return value is a hint for caller: true means that the Qcow2 header was
>> - * updated. (false doesn't mean that the header should be updated by the
>> - * caller, it just means that updating was not needed or the image cannot be
>> - * written to).
>> - * On failure the function returns false.
>> - */
>> -bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>> +/* Return true on success, false on failure. */
>> +bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, bool *header_updated,
>> +                              Error **errp)
> 
> I think that the documentation should clarify under what conditions
> 'header_updated' is modified.
> 
>>       if (s->nb_bitmaps == 0) {
>>           /* No bitmaps - nothing to do */
>> -        return false;
>> +        return true;
>>       }
> 
> Here is it not for example (should it be set to false?).

Ha, I think, it just shows that patch is wrong :) We should set header_updated at least on every success path. Or better always (if it is non-NULL of course). Thanks for careful review!

> 
>> -    if (bm_list == NULL) {
>> +    if (!bm_list) {
>>           return false;
>>       }
> 
> This looks like a cosmetic change unrelated to the rest of the patch.
> 
> Berto
> 


-- 
Best regards,
Vladimir

