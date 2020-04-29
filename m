Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DCEC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:55:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7430B208FE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="X1oKhgyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7430B208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTlJh-000347-Kv
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 07:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTlIj-0001e9-A8
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTlIh-0002OK-A7
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:54:52 -0400
Received: from mail-am6eur05on2114.outbound.protection.outlook.com
 ([40.107.22.114]:60005 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTlIg-0002Fd-HR; Wed, 29 Apr 2020 07:54:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciXvn58h1bJXvPKkMrYKL/T5L2Ckq+k2iBrgkxULPqYL1uQIlJlvbaCDugUlp0fBVGMU4x4Z3fD4ZObGpKIHtgC0I/7Ma2G+GTnqwOqZ22xIqIZYtyeyne21Bu6BKkkhQVsCa2aVEvBTmwqmkUp8OqKaXJaB74FUyapFjpRPEV7In8VsUdetqqM7zByjAaOFrokBKviUXqnQ/YQ1mxhwXIoD3daE/oLHT+lPOkK82NQt92P72Pr2teDX22bL49OtFaQmWI/z71OAK7KGfJpotPkK4l8WDcj56SNRONZfqJK4ZSO4dKVl/2/OCS9PWvtXeOUHynGm73FDP5pM2qmrIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbDQG1CKVXSNBMq1OIHRpIzroViDb6czDFibm3mG/b4=;
 b=ZBwydJIFVWgYNeO1USkO6qfeRLTNlepmFUMkG8L7gDXiYwcThlTOg9Y1o2bOXB4rpKXZ4URpNE+HV/q16jqT0RPyM90/b0jHdu1UQ0vMcDN0Yh8NO/ne5FNwuMUYc+LpYzWfviizQITxWaEYiG50/mtu1y8WTAFLB9ItdcLPOLM1kp5XnOwYxIjjqkUQG1uBk8SvJKSzPeclZcXsFxOcNFAp+8+NUq7VzA2vHlx4GNW1gB1ajsggvDjFKq68krKJAXMW/IAV3V7xA3ZPVCejEfOjWx3QhboPF8YY90zC9ecLtsxROle70QAytwKGShh72D2dVTS1jhYPR4O1B7GWTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbDQG1CKVXSNBMq1OIHRpIzroViDb6czDFibm3mG/b4=;
 b=X1oKhgyBx2voV21GQub22fqKQT9+NeTgRJASxwW007bi5CnpXWvp1BnQ47ahl6RUhin4DLJEwZBSnT+CXWpWfJmmm80sf4zwNnSUCyV+g6sOsGdjpDm4O0Lq4hsX4Z8tFckZFMQKhmfmBCt1JrrwkI+m9NJwvlcyBMkiVmOZ/PY=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5528.eurprd08.prod.outlook.com (2603:10a6:20b:dd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 11:54:47 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 11:54:47 +0000
Subject: Re: [PATCH v3 4/5] block/block-copy: refactor task creation
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200429061039.12687-1-vsementsov@virtuozzo.com>
 <20200429061039.12687-5-vsementsov@virtuozzo.com>
 <affc8770-2b70-c3e4-af1b-ca620119c2d5@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200429145445577
Message-ID: <92dd552d-b181-5b39-c796-e228c4d33379@virtuozzo.com>
Date: Wed, 29 Apr 2020 14:54:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <affc8770-2b70-c3e4-af1b-ca620119c2d5@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0101CA0073.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::41) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.184) by
 AM4PR0101CA0073.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Wed, 29 Apr 2020 11:54:46 +0000
X-Tagtoolbar-Keys: D20200429145445577
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed0a4e82-4aab-4ebb-587c-08d7ec341d2e
X-MS-TrafficTypeDiagnostic: AM7PR08MB5528:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5528AD469962E6833E2D9F5CC1AD0@AM7PR08MB5528.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:338;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(8936002)(2906002)(16576012)(498600001)(66476007)(8676002)(66946007)(66556008)(5660300002)(52116002)(186003)(16526019)(53546011)(31696002)(86362001)(36756003)(26005)(107886003)(6486002)(2616005)(31686004)(956004)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rOhCSa+Odr+a68pNSWyoSKQXB34wo4Iz17dhdyXZm278ba2co04oJhSyRcqDho4QHndjge329eQMVI1TFY/Y6XkKvjrvNEainG/rpOSxDLaHbAWaLAJPMIQfj/YhYAffFcXWtKVSDEc0vZoPINd/69PH1w3RlA8Itxfda+XkaRSHucx4Tgn5CGjMx/+82azotExi8gk5q8ngFLa2yMCZeROZioq9qTY/CyM68JtZu5t2TQC6i/woi15JNbT1bqRrLZaAO9wFNI+pGeTTZge7L/7sgWhFEc2UqNGzztXcDh+fBIzuJCma9/eD4969yCDhPyh0/aCFCglFZ5XcMg13CWbQ4nuUQWWF9YgoBPiRShluJgYyhNvpmCxChbyCqr2Zp0RdU3ErUVennjcs0pgL6ZpQuYBuvr0P2B+u/K4/NJAAPNWQ+buDopQoCrcG9Le5
X-MS-Exchange-AntiSpam-MessageData: gxsHD12hT9JJ/GQ8O3UvT1Smn5E7WQyEAYh68/1HEcZWCjsGfWmnMXWDAzuT7TUTPQuNGvy7S7HefHZe2G82kTEdIHNWMgBDceBHWTkd/3o+6aCi/SblGnMuganR/9RxnLisZ3bsWCakVJT1/2GcVsKmnuiXiWnmXHdOtj2w2wUEmHM9im0LY6bYWO/ikHwuCWMGXaapDwWBPYnjnIULqoGoM3PTGLXuGPYQ56OELCTov0cYO8viDmOZWH4cIHzE6dZht3Zaku4jz5CvP3nl5DxGPMbpTCyzVCZNpumdFjQtgzPBqOLdte0dnHZigaYsYz1ryp/6Oj1xma/3uwd8qSnz5xqTxk6aZiCqzWhb/5AMLCK9vCUpJAXTL7LffRYPHDtgM62/X4wRRD1NymvL0AliFQPm/0eeun0HDMOtjv3O/pGko2uKc+CLN0WNG7zWeWs7VP1H3Veb+gnTlj9l+Zx5cKaWO94Xa25WltaczXZeWhLnGynUh7MAYuDcIR7Xx+3MjM/BNa7fc5KEJQB1MovNL4+SE3+ODkcV8an0paHH5owtr6hBvHTH+op7rJHFyTNGRmJtm5GVb5QJwLFWhFWMo3G5ank+GXZqziQ60wKg//6WeyZW1zjPfJAEJZQs+1HfKI9JlD0Ez5InbtYtelt/n6oRsdriC8xbrSHD6o0wJQJPpNjNh2GK2K0I/UuC/nFmu6sXq5NQLEwL3ktVZTO2qzgN3LGewfpupFtEBwCmyzPsKzmOH5HzcVdeWDEujnf5v123Senwq/Itdgi40TmfRH5DbDL9EOfcLZbO194=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0a4e82-4aab-4ebb-587c-08d7ec341d2e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 11:54:46.9798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwhRCO/TyLekjtOBpVTZXyFIxxkw/WkVv7Ou1U+2T37Xk5M2OwMTdYvnU7Uv8+6ZeS0oTGx5+3NuoyDmlRdO1J6H+Epld29n759TDa6Ix/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5528
Received-SPF: pass client-ip=40.107.22.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 07:54:48
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.22.114
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

29.04.2020 14:38, Max Reitz wrote:
> On 29.04.20 08:10, Vladimir Sementsov-Ogievskiy wrote:
>> Instead of just relying on the comment "Called only on full-dirty
>> region" in block_copy_task_create() let's move initial dirty area
>> search directly to block_copy_task_create(). Let's also use effective
>> bdrv_dirty_bitmap_next_dirty_area instead of looping through all
>> non-dirty clusters.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/block-copy.c | 78 ++++++++++++++++++++++++++--------------------
>>   1 file changed, 44 insertions(+), 34 deletions(-)
>>
>> diff --git a/block/block-copy.c b/block/block-copy.c
>> index 35ff9cc3ef..5cf032c4d8 100644
>> --- a/block/block-copy.c
>> +++ b/block/block-copy.c
> 
> [...]
> 
>> @@ -106,17 +111,27 @@ static bool coroutine_fn block_copy_wait_one(BlockCopyState *s, int64_t offset,
>>       return true;
>>   }
>>   
>> -/* Called only on full-dirty region */
>> +/*
>> + * Search for the first dirty area in offset/bytes range and create task at
>> + * the beginning of it.
> 
> Oh, that’s even better.
> 
>> + */
>>   static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
>>                                                int64_t offset, int64_t bytes)
>>   {
>> -    BlockCopyTask *task = g_new(BlockCopyTask, 1);
>> +    if (!bdrv_dirty_bitmap_next_dirty_area(s->copy_bitmap,
>> +                                           offset, offset + bytes,
>> +                                           s->copy_size, &offset, &bytes))
>> +    {
>> +        return NULL;
>> +    }
>>   
>> +    /* region is dirty, so no existent tasks possible in it */
>>       assert(!find_conflicting_task(s, offset, bytes));
>>   
>>       bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
>>       s->in_flight_bytes += bytes;
>>   
>> +    BlockCopyTask *task = g_new(BlockCopyTask, 1);
> 
> This should be declared at the top of the function.
> 

I just thought, why not to try another style? Are you against? Requirement to declare variables at start of block is obsolete, isn't it?

> 
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> 
>>       *task = (BlockCopyTask) {
>>           .s = s,
>>           .offset = offset,
> 


-- 
Best regards,
Vladimir

