Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6CBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B739E222BA
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vq2vqs2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B739E222BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQryJ-0007K7-Kw
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 08:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kQrxS-0006aQ-Gy; Fri, 09 Oct 2020 08:57:17 -0400
Received: from mail-eopbgr140093.outbound.protection.outlook.com
 ([40.107.14.93]:59889 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kQrxL-0003zM-7O; Fri, 09 Oct 2020 08:57:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2fkSXgTxAwBu44rx+V3ou5NRpVBQfC5OB0J5gQFUnBZBxs0OVz7tiX9+2+/hvoq6hsFkHwic3cuuAQ67BjxsXDy9YjYSC5Qv5zd3Ff47xxVVFVUkJXcmt691zjWTg+gFf0cykrZASPEmlHpcH+MJ235xA826spisAyg1DzKcCqZ4ONg9D0hIZrvv6gwtwYHpxH89A7mlGFaI8oYnw/jeDcg1lj2p9Sda1LmD8mBqD/rZe0tDfrmhOpctdUfHcUBs1audZQ3HEJstcjP1S2QJBQu64ibzikGL46gorcJLKCVdZKyXgR62R6It1b79KGCaBNw3mQVdVVdtVqhzqlnFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMGzOeMIoxw07oAlOUqIvk32aWa1lSYiAwFY8CstEaM=;
 b=dmJMtLlK4vkusJSldF9+yneTel1d4NtuRdIPRDJTXrcwUUYNr3aMaUhfphnmXWBu7fOx3XszM12izdvmxBbheF/0/patKNxuD+GKAvO0AasbFzv9QRQ+XqHVY4tMJmU7kemFS2NC7tPaZrUQM3+dlgVnnAcV0m5/qk70Y8JakyX458BtnY9xZjNyOjXjJk1fbPj/msFXNASRB3a8vUb7jec/3F7Orw9Tpt4hgSL2kS1xIo+Dh2USeJVuegpcaLMsnrEsTwA0vwMr5/TRBar0lQrptrzk6FapGHHDR3Ciyjxiggpo2OjDdC85IprKBl1aGUTEyFhNOXvZn8wStJPomw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMGzOeMIoxw07oAlOUqIvk32aWa1lSYiAwFY8CstEaM=;
 b=vq2vqs2Pbj5EPUUTAvGRHEFsCOi2FG4816GG8I3Oml5z3UpFQIIuFYbDhqosiWsbPurIScAQBJAG8Q/870yaeYu3rYT7dA4DTvhOG4bcEBlQ52zrjMHR1T6Pw4T621D8O6RljbS9I98WzULp2V8pZeDFfFdBbjDHEcoyuTZ3IQw=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR08MB2650.eurprd08.prod.outlook.com (2603:10a6:7:2d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.44; Fri, 9 Oct
 2020 12:56:54 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3455.027; Fri, 9 Oct 2020
 12:56:53 +0000
Subject: Re: [PATCH v10 6/9] copy-on-read: skip non-guest reads if no copy
 needed
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com, armbru@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1601383109-110988-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1601383109-110988-7-git-send-email-andrey.shinkevich@virtuozzo.com>
 <531a938b-4b76-c506-59be-eafc1ea85159@virtuozzo.com>
 <de411799-a8a1-4bff-a48d-2692cc29be61@virtuozzo.com>
 <e4153b7f-21ed-1e3e-b7e9-414bd1a4f11b@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <e17e600e-2a59-5df2-623b-2bb200e4a851@virtuozzo.com>
Date: Fri, 9 Oct 2020 15:56:50 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <e4153b7f-21ed-1e3e-b7e9-414bd1a4f11b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.252.114.22]
X-ClientProxiedBy: AM0PR08CA0023.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::36) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM0PR08CA0023.eurprd08.prod.outlook.com (2603:10a6:208:d2::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.21 via Frontend Transport; Fri, 9 Oct 2020 12:56:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e241701-d98a-492b-532c-08d86c52cbb5
X-MS-TrafficTypeDiagnostic: HE1PR08MB2650:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR08MB2650C90142C790AD13E700D3F4080@HE1PR08MB2650.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FFqoptwP3+8Lb3BNcw/KctQLjN2WKSF5B062y5ruKGQJdtKCqKvheeFTx16INOdBkwG1gWcRyTutGYOyY6ttUfcUCixJFbPEXXi5qOYHbIrtGxGAiwv0amDh4xNN24eZUjfoPVp/+B58di8iqq+4kfGMDmFEK9Q2LafbnRG7l6JfSJ1kBPHxD5i2MD91P1jmxK4jM9S+6+SBEFAH6JKPEPc1SbV/qeRjah5JEs6Dcb8R1SGUk6aphuATTcwuBZDrDhEnd8M60JwPhMNL+8nks3jcFv0bWICmjThrR5gx8rGhRzkmin14rA3uyrSIbHdwAGdj9PF1wxSI/Th1Hy+AyXsgbUrr6nFn3lq/LVrWlqhkfgLK0QclqJ2oJh6kYCIJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39830400003)(396003)(136003)(366004)(376002)(44832011)(53546011)(478600001)(66476007)(31696002)(66946007)(6506007)(36756003)(956004)(2616005)(6512007)(66556008)(5660300002)(6486002)(107886003)(8676002)(31686004)(86362001)(4326008)(26005)(186003)(52116002)(8936002)(83380400001)(2906002)(16526019)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: eopHItmEKjP5GCAHIwtZd3mbN70f8XB+dqFtmAKMAWuoBsNRtNZeUwZABwPvKFD96riJa85LVarFDqH3jp2VfSt89irvHfHpaBTVt6hLC1u9afHfSYhoTSRqXl7loi5xO0kxyob5U8lSV7jIf3L9n4ZtzzmsMMH0xaBO5HQahk5iJyliVyJmkHV+WGlCzQ+eaO1aL5yOQToglFFAUB5A5eqJsR+/Bh7HkOVU8rXGbGg8DLYxTApsuTD+t+EaWZ2uQTeMtTzoeOMUq0tnH7obiRa4tTv2UL+wLfe8GBVTI+vSrzTvYiFtHDOMMqben+aSSKIL3MkjMFsOPIx+Bjwlqq9l0MBGVSqx/PK0C2IVzaB3ZYK8VWIbEJvc6SXUp3Uju2AMS3RYkHkSq9sX1byDxrKA04kGaaoJOHth64wZSM7qTOPbRVTJRoNpv19ZfBL0p8V6b+DpjEm/Ux4ATZlNED/bcjyYO1SC6PDDPFKLlk2I21HiOX6g+yWIIFl1TEgfbLOGaCE6cqBIKNhiwmLX6eP90yoLpXNopyT5ygDrXuJrZei7KzW9/stYW3l6HD8jEW+VgoJR78E9diE52QW9DYS1+TJMuUsXKp5rzdvDTpIIR+b8SBuPZ+7wxzeMdo65EDfe4ACVzRP+CRplZR2Teg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e241701-d98a-492b-532c-08d86c52cbb5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 12:56:53.8189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVS3ZVRlAlMYJpr7MkXk+582fdNC/OepYg4tD0riLQHZWcuR5ANpVXeSeCpGRize6EwXzFslzO1zBiJL6QxWoMaDe9KPlaxMvfFouqlzfls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2650
Received-SPF: pass client-ip=40.107.14.93;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 08:57:03
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.208, RCVD_IN_DNSWL_LOW=-0.7,
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

On 07.10.2020 22:28, Vladimir Sementsov-Ogievskiy wrote:
> 07.10.2020 22:01, Andrey Shinkevich wrote:
>>
>> On 07.10.2020 13:06, Vladimir Sementsov-Ogievskiy wrote:
>>> 29.09.2020 15:38, Andrey Shinkevich wrote:
>>>> If the flag BDRV_REQ_PREFETCH was set, pass it further to the
>>>> COR-driver to skip unneeded reading. It can be taken into account for
>>>> the COR-algorithms optimization. That check is being made during the
>>>> block stream job by the moment.
>>>>
>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>> ---
>>>>   block/copy-on-read.c | 14 ++++++++++----
>>>>   block/io.c           |  2 +-
>>>>   2 files changed, 11 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>>>> index f53f7e0..5389dca 100644
>>>> --- a/block/copy-on-read.c
>>>> +++ b/block/copy-on-read.c
>>>> @@ -145,10 +145,16 @@ static int coroutine_fn 
>>>> cor_co_preadv_part(BlockDriverState *bs,
>>>>               }
>>>>           }
>>>> -        ret = bdrv_co_preadv_part(bs->file, offset, n, qiov, 
>>>> qiov_offset,
>>>> -                                  local_flags);
>>>> -        if (ret < 0) {
>>>> -            return ret;
>>>> +        if ((flags & BDRV_REQ_PREFETCH) &
>>>
>>> BDRV_REQ_PREFETCH is documented to be only used with 
>>> BDRV_REQ_COPY_ON_READ. But here
>>> BDRV_REQ_COPY_ON_READ appears intermediately. We should change 
>>> documentation in block.h
>>> in a separate patch (and probably code in bdrv_aligned_preadv())
>>>
>>
>> OK, we will come here without the BDRV_REQ_PREFETCH flag set.
> 
> flag BDRV_REQ_PREFETCH should be set in stream job. Where should it be 
> handled, I don't follow?
> 

If we leave block/io.c unchanged in this patch, what I'm agreeing with, 
we'll come to the COR-driver with the hardcoded flags = 0 :

#4  0x000055a22bb480cf in cor_co_preadv_part (bs=0x55a22d593710, 
offset=0, bytes=524288, qiov=0x0, qiov_offset=0, flags=0) at 
../block/copy-on-read.c:149
#5  0x000055a22badcb1d in bdrv_driver_preadv (bs=0x55a22d593710, 
offset=0, bytes=524288, qiov=0x0, qiov_offset=0, flags=0) at 
../block/io.c:1129
#6  0x000055a22baddc81 in bdrv_aligned_preadv (child=0x55a22d814780, 
req=0x7f8c1abffce0, offset=0, bytes=524288, align=1, qiov=0x0, 
qiov_offset=0, flags=512) at ../block/io.c:1515
#7  0x000055a22bade59a in bdrv_co_preadv_part (child=0x55a22d814780, 
offset=0, bytes=524288, qiov=0x0, qiov_offset=0, 
flags=BDRV_REQ_PREFETCH) at ../block/io.c:1757
#8  0x000055a22bade3d2 in bdrv_co_preadv (child=0x55a22d814780, 
offset=0, bytes=524288, qiov=0x0, flags=BDRV_REQ_PREFETCH) at 
../block/io.c:1715
#9  0x000055a22baf5d09 in blk_do_preadv (blk=0x55a22d818c00, offset=0, 
bytes=524288, qiov=0x0, flags=BDRV_REQ_PREFETCH) at 
../block/block-backend.c:1211
#10 0x000055a22baf5d61 in blk_co_preadv (blk=0x55a22d818c00, offset=0, 
bytes=524288, qiov=0x0, flags=BDRV_REQ_PREFETCH) at 
../block/block-backend.c:1223
#11 0x000055a22bab4eba in stream_populate (blk=0x55a22d818c00, offset=0, 
bytes=524288) at ../block/stream.c:50
#12 0x000055a22bab52c2 in stream_run (job=0x55a22d810a20, 
errp=0x55a22d810aa0) at ../block/stream.c:162
#13 0x000055a22bab79f0 in job_co_entry (opaque=0x55a22d810a20) at 
../job.c:908

So, the only way for the COR-filter driver to differ between guests 
reads and the stream job is to check the qiov pointer for NULL and reset 
the flags as appropriate. This is what I am going to do in the next version.

Andrey

>> To differ between guest reads and the stream job ones, we would set it 
>> here by checking for the qiov NULL pointer:
>>
>>
>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>> index 4e3b1c5..df2c2ab 100644
>> --- a/block/copy-on-read.c
>> +++ b/block/copy-on-read.c
>> @@ -144,6 +144,9 @@ static int coroutine_fn 
>> cor_co_preadv_part(BlockDriverState *bs,
>>                                             n, &n);
>>               if (ret) {
>>                   local_flags |= BDRV_REQ_COPY_ON_READ;
>> +                if (!qiov) {
>> +                    local_flags |= BDRV_REQ_PREFETCH;
> 
> if qiov is NULL, this means that flags must include BDRV_REQ_PREFETCH. 
> local_flags should inherit flags I think.
> 
>> +                }
>>               }
>>           }
>>
>> Andrey
>>
>>>> +            !(local_flags & BDRV_REQ_COPY_ON_READ)) {
>>>> +            /* Skip non-guest reads if no copy needed */
>>>> +        } else {
>>>> +
>>>
>>> extra new-line ?
>>>
>>>> +            ret = bdrv_co_preadv_part(bs->file, offset, n, qiov, 
>>>> qiov_offset,
>>>> +                                      local_flags);
>>>> +            if (ret < 0) {
>>>> +                return ret;
>>>> +            }
>>>>           }
>>>>           offset += n;
>>>> diff --git a/block/io.c b/block/io.c
>>>> index 11df188..62b75a5 100644
>>>> --- a/block/io.c
>>>> +++ b/block/io.c
>>>> @@ -1388,7 +1388,7 @@ static int coroutine_fn 
>>>> bdrv_co_do_copy_on_readv(BdrvChild *child,
>>>>               qemu_iovec_init_buf(&local_qiov, bounce_buffer, pnum);
>>>>               ret = bdrv_driver_preadv(bs, cluster_offset, pnum,
>>>> -                                     &local_qiov, 0, 0);
>>>> +                                     &local_qiov, 0, flags & 
>>>> BDRV_REQ_PREFETCH);
>>>
>>> Why? In this place we want to read. We'll write back the data a few 
>>> lines below. What will we write,
>>> if underlying driver decide to do nothing because of BDRV_REQ_PREFETCH?
>>>
>>
>> See my comment above please.
> 
> Anyway, BDRV_REQ_PREFETCH here is wrong. You should not pass any qiov, 
> if you set BDRV_REQ_PREFETCH flag.
> 
> If we come to bdrv_co_do_copy_on_readv, it means that we have 
> COPY_ON_READ flag. And therefore, we will handle
> PREFETCH and COPY_ON_READ here in generic layer. And therefore, we 
> shouldn't pass them to driver.
> 
> On the contrary, if we have PREFETCH flag in bdrv_co_aligned_preadv, but 
> don't have COPY_ON_READ in the same time,
> this means that we must pass PREFETCH flag to the driver if it supports 
> it. And do nothing if driver
> doesn't support PREFETCH. That's how I see it.
> 
>>
>>>>               if (ret < 0) {
>>>>                   goto err;
>>>>               }
>>>>
>>>
>>>
> 
> 

