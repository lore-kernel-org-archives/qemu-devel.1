Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C140CC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 09:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A085206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 09:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ueVXKmMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A085206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTMfs-0007Dp-I6
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 05:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTMZf-0008AS-SW
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 05:35:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTMXi-0001IB-WD
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 05:30:43 -0400
Received: from mail-eopbgr40113.outbound.protection.outlook.com
 ([40.107.4.113]:43844 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTMXi-0001D5-Im; Tue, 28 Apr 2020 05:28:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5LIpR83FKA9dvvzGJdhhmPFukAFdfHVdO2K28TtY0N0rzfbTek/4I2vJEV321m/4KI07nN3VblmG3m32nBWmeOGsMveCTbkTtdKAxgLgpA5PnfL5XQuLLfZ8xb14Qp1FIeMDXsiLpFytQjpPn5ZE3kGF+Fiy8ZwSH7wcfIL8gLn38XtdXflQyF8g1tDYzkyRKEI14esbh4lzl0Eg2oj2QmYHHq1FMlJsLEqgVKIpqhSnJKY9BUjN2Qq6s+DvkKUuzqaV8x8EdVThQnUAF3vXc85Bw7BGi1cXDtWMvqk8b0VceWOQRbpdXOFWcfBW9FNJp35JQpvy6tz88vHoGABwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEk0MZTvTWdcvXY0jZJGxP06NvDQevghge76DAu7D+U=;
 b=kf6BmWmqFzTKhF7Dx0AKRbo1Mgk9Uv7LunT1Pkr89ntZfB8Q5DX0O9yjB6xlV5UicQg6fi9Tzm0+Zxeoaf0UWI4pbk73acUnww6gzKXXHF6hoBKA4Tiua7GjhU9SZstKbxSLGi+izec8K1bW+HaucuKNX+61nvggaxS0GpR7+ec9PLKlUORx7zV0spEVrfH2Wmwoa2lYXqv0/QtjslH0NljA1U84nNXWcTraSWV0f3OSCqC0FjCTu1mlspD1Aa29wmT9yxGMVySqu4nxdMdjCEgB9zm1LKDHnngvoVx22ejEWD3TMp1Z/MR0745dwaHEkDF9P0zklQ4fG11VuSCi7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEk0MZTvTWdcvXY0jZJGxP06NvDQevghge76DAu7D+U=;
 b=ueVXKmMICK5F3qDzzxgqe2TucRisfdeRibJZpEUQHikzOl/lLGaAFPD1wStWhXnPeIC77pNINn21bf0qdK+l2pMeNv1nndIfR9wtkPxV4QWS400vQlwuSKa2bJ5VdOYv5i6Fxw9ObIfkNUjAfIMotE3ckTjI6XG2fy+j6cg1ZXA=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5429.eurprd08.prod.outlook.com (2603:10a6:20b:107::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 09:28:36 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 09:28:36 +0000
Subject: Re: [PATCH v2 4/6] block/block-copy: move task size initial
 calculation to _task_create
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200325134639.16337-1-vsementsov@virtuozzo.com>
 <20200325134639.16337-5-vsementsov@virtuozzo.com>
 <630a5655-7b00-3ee4-943d-e4b5ad52db57@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200428122833623
Message-ID: <9c03916d-cee7-6543-aeed-9e11cabe54ae@virtuozzo.com>
Date: Tue, 28 Apr 2020 12:28:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <630a5655-7b00-3ee4-943d-e4b5ad52db57@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::22)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.155) by
 FRYP281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Tue, 28 Apr 2020 09:28:35 +0000
X-Tagtoolbar-Keys: D20200428122833623
X-Originating-IP: [185.215.60.155]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77b055c8-7fae-403e-3f80-08d7eb568709
X-MS-TrafficTypeDiagnostic: AM7PR08MB5429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB542900A257BE5010F434AF15C1AC0@AM7PR08MB5429.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39840400004)(346002)(376002)(366004)(136003)(66476007)(66556008)(16576012)(186003)(5660300002)(66946007)(316002)(6486002)(478600001)(16526019)(81156014)(4326008)(956004)(2616005)(36756003)(52116002)(31696002)(86362001)(107886003)(8676002)(31686004)(8936002)(26005)(2906002)(53546011);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 35YspV0WpqdB5LtQiPowy5MoIJXXEeIZ75OWtSRo2Gkjxi/SNnwI32VLbCIrvPf+5FMvUqPvfy6rdocQ8v/aoVB7vIwT5jfx70GGxPZPkiI2w9VWGD9W1WeQ2S57GUq18oxlZuFErt1OIEJ1gcYSmbCXGWCQ4uvygmxcEstUvWC18Ys0nlOaCUk/Jxe2MC+HqgvcWY/JLRB8CHBA6IHuZwVtw2I4FdZ7YUW+wxiA/O5823JfPvKfpoPBdfo40DdYIvu5bHswc2tci79D5GhU46t3IWvupGgv1nezqsqRsCkRwrHqLr2MJrCbiC5oqy61kNj8Ldtck5LGHPDuu0jQu+ZRWpJ+Hqz2+iSLTErFMTUA+L7HiAeef2oqDYKTu6l9owL/yuRBLmm7FBCG73U4eaO3mBCfqfVig/nGYYspa9O3w9MkBRwvr0Tv3mZRn0Eg
X-MS-Exchange-AntiSpam-MessageData: +Gz1d08wBvbJqqEhT0VQwvI0ksvUq7FUU9+KfMcip6DgZePcGTFM1M52RnrD75F1Z2QtfuJoQeiW0eoG1kJ2lG9pEOWse2QmDjRANNe+5c0rK6phSDnObX6CqbeMwWW4TsnF3NwAfCfbFgWduWQFBrx9OfsHAPNdUJ09PFaeuERQ5cfWACs17sZue9x5CI9GdccWsEZDuwFGVn6vWl24v4PIFJsBhmSKMjmakGjw6fLSDoam9S7bC5N4Zn5T+AVoapW7Mv34MZFWkHcDmdToM964QRe3bIGQjIxyRtR9YrQ3I0eaBdGducRh7MHw9wG2F6eRWGKpeDb2UzXDtHi2CyBQgHZt0ZLDc2iaZDAhHJtDArdlwOVdkxpj4LXA+WQhzaaz5df5vvpi4G9btlT8GRGN95WoJD8SdFzxNwkCrCrlrUkDPsyisT3UxUasgpcVIgh/Fm06J5Rxb6Bm4WEt//pslB2se+1/IfLY8yjzbhletUyljoWjJNRC1AVG7/Ej3/hg/JrGhdT4pj2pPwPH5/7bGLW5zHm96uRGFr+LNhZ/K5FxiA26e9LnSMSDGi4i8jBrH8f86ScPWADfUMzIiLgbVtArb2WZzHs9bKAEHoT4Oq2SICWuY0vHau0Uo17JRqN/0dEg7Ev66p97FVGRDS1/juEt8cK56pBJ6/ZYCzPllepIE4duv5/tD2jtxs1n+55mJ6uG0yL0qNKXvMFQcnqJcU1xu2Ywbwg72zZqlhFCnjAtbrspYBb1Vmix7YvrsMvfGXmGdFj2ujLyc3FVqZs0BfCyMmybdWFYGmr6qiE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b055c8-7fae-403e-3f80-08d7eb568709
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 09:28:36.2196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 56LvxCXFnuLLpRDBoDdS62r5QfNmul327SBFpvRi9t9ybZ5gLhULKM3Y0JeDBI14pCzC3LPsod+Bhf5t2a1v/RVwcpUyFFZvKcodgFPdCik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5429
Received-SPF: pass client-ip=40.107.4.113;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 05:28:36
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

28.04.2020 11:52, Max Reitz wrote:
> On 25.03.20 14:46, Vladimir Sementsov-Ogievskiy wrote:
>> Comment "Called only on full-dirty region" without corresponding
>> assertion is a very unsafe thing.
> 
> Not sure whether it’s that unsafe for a static function with a single
> caller, but, well.
> 
>> Adding assertion means call
>> bdrv_dirty_bitmap_next_zero twice. Instead, let's move
>> bdrv_dirty_bitmap_next_zero call to block_copy_task_create. It also
>> allows to drop cur_bytes variable which partly duplicate task->bytes.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/block-copy.c | 47 ++++++++++++++++++++++++----------------------
>>   1 file changed, 25 insertions(+), 22 deletions(-)
>>
>> diff --git a/block/block-copy.c b/block/block-copy.c
>> index 63d8468b27..dd406eb4bb 100644
>> --- a/block/block-copy.c
>> +++ b/block/block-copy.c
>> @@ -106,12 +106,23 @@ static bool coroutine_fn block_copy_wait_one(BlockCopyState *s, int64_t offset,
>>       return true;
>>   }
>>   
>> -/* Called only on full-dirty region */
>>   static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
>>                                                int64_t offset, int64_t bytes)
> 
> A bit of documentation on the new interface might be nice.  For one
> thing, that @offset must be dirty, although there is an assertion that,
> well, checks it.  (An assertion doesn’t really check anything, it rather
> verifies a contract.  And violation is fatal.)

Still, good to document that.

> 
> For another, what the range [offset, offset + bytes) is; namely
> basically the whole range of data that we might potentially copy, only
> that the head must be dirty, but the tail may be clean.

Right

> 
> Which makes me think that the interface is maybe less than intuitive.
> It would make more sense if we could just call this function on the
> whole region and it would figure out whether @offset is dirty by itself
> (and return NULL if it isn’t).

Hmm. Actually, I didn't touch the very inefficient "if (!bdrv_dirty_bitmap_get(s->copy_bitmap, offset)) { continue }" construct, because I was waiting for my series about refactoring bdrv_dirty_bitmap_next_dirty_area to merge in. But now it is merged, and I should refactor this thing. And may be you are right, that it may be done inside block_copy_task_create.

> 
> OTOH I suppose the interface how it is here is more useful for
> task-ification.  But maybe that should be documented.

On the first glance, it should not really matter.

OK, I'll try to improve it somehow for v3

-- 
Best regards,
Vladimir

