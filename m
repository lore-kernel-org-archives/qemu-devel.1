Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD1BC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:29:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D7AC2076B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mlepZO6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7AC2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQF7x-0001dY-HM
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 15:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kQF6r-0000yG-7H; Wed, 07 Oct 2020 15:28:21 -0400
Received: from mail-vi1eur05on2118.outbound.protection.outlook.com
 ([40.107.21.118]:4000 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kQF6n-0007y2-C5; Wed, 07 Oct 2020 15:28:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIGkFqQ6ENWhyEGO4IZx9BbYRFq1a+VCKhaM3CK7S4I8uitfqlGHzoGJ01LjYMCkqdJKlQ1bBZhF+piqKGd5rv4Ym5T2BxrJ4rIHEQ0VIMUVLCMOekEP4xkksXvAyieEJ2HBV3gZYJ7lyc3ITYhKUXyH8qKW1YK5PtB1RKMze4qdRjaP1csFcgEV4uBKBRpd9kww72WXoj6FlnclsWbxQF1ftHMh3PgRufDfU4tTm6C2V/XMfcuNEnTEYFzXl0bhmeNG4l618M4gNLvetcl/481yh94c4weeXeJKynSX5MLO2TEEbWEyiq5x+HmrOlhx5Q7e8AF3brwfVCbQeFOgCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/c5/QL03rbnAhbxPYiLN0Z6YvdpgD7EfyQYy0s9Swo=;
 b=gCvzqEsjqcmXR39n95fQ6lrG/+sJgCW5cxrCHW4OSIpZKKNQIKeD5SYoW5McA9EnTMPcTHRmjajsbWjNZ5rnD4kOPf0JIfOkl1/yhE0UswcgEDovlQ/sVek0P+SHaRtlBlZuiNxoQ8VWhCjR2WLwN7b+nLM/nhYGqLV+N3oqCjpGYmPXrZkqeiFQvVILYN8ztKouxNxzeR/+nnNQJZFgd4RgGzEEhCmb2Ea1Poo1geHwjDAwumJyy13sLeln3TZFtM67hYv4UteUtq+D+wJNxf41lynDhGQvfs+f6eR5YLOimRB8+75BPBpaVVEe8F9u51Bn8VqfkQkfXY8Slx1JYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/c5/QL03rbnAhbxPYiLN0Z6YvdpgD7EfyQYy0s9Swo=;
 b=mlepZO6UXsMwQ4FmQh3eGEN6xH3gb9SxjZVFYDc108vbUVNuvR1BtSGWlpo7ECzL/6gkQFrk0SRn4JtCESQGHCXAR2mnTHIFUP/CXq88yLHJl1EU0XyhCyE6vGLBxD3HXZZOyKlZdmgSvrplXtKKCg986jQJwZZQmhQcrzxB0wA=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5254.eurprd08.prod.outlook.com (2603:10a6:20b:d6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Wed, 7 Oct
 2020 19:28:13 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 19:28:13 +0000
Subject: Re: [PATCH v10 6/9] copy-on-read: skip non-guest reads if no copy
 needed
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com, armbru@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1601383109-110988-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1601383109-110988-7-git-send-email-andrey.shinkevich@virtuozzo.com>
 <531a938b-4b76-c506-59be-eafc1ea85159@virtuozzo.com>
 <de411799-a8a1-4bff-a48d-2692cc29be61@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e4153b7f-21ed-1e3e-b7e9-414bd1a4f11b@virtuozzo.com>
Date: Wed, 7 Oct 2020 22:28:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
In-Reply-To: <de411799-a8a1-4bff-a48d-2692cc29be61@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.87]
X-ClientProxiedBy: AM0PR04CA0091.eurprd04.prod.outlook.com
 (2603:10a6:208:be::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.87) by
 AM0PR04CA0091.eurprd04.prod.outlook.com (2603:10a6:208:be::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.23 via Frontend Transport; Wed, 7 Oct 2020 19:28:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcf9fcdd-4605-451c-4eaa-08d86af721ce
X-MS-TrafficTypeDiagnostic: AM6PR08MB5254:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5254B311B158AB6AF942841FC10A0@AM6PR08MB5254.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ufdrF5Wh/NedON1AVQPWNr2nJlBqKZmgeHIsJZ0cTTmXJ7USIvtKyVBsmCwytjn/+3iYuRF2ZI3hJJc2YJ9CnuoIv/E4zCxVXTB019RmdiU8MYHGNIRWIFGMEfHD4KfQvt6mza9LQz0RorPfSD4S8AguXgzzsK4Z4a7TRdgFGth0ycQRvne7OZEixNsKivMZnApOVfAtPYfDduGLSowa5inr5goiH6NALulIC/fji1vLMavOEXBjFcUjrAUYvABEEYhACvqTPlFHEDW8nmkLmDSC6YMX7lsBOZjc9mU5uFu+FBlQzCWrMccPHlSgCerNiWulgat9JePmBIl+WHcsYGtN4rFayBJ20z2x7mLyaLAQHKQzkagjV8/o2ZjyUzyU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39850400004)(396003)(376002)(136003)(186003)(16526019)(4326008)(8936002)(31696002)(26005)(66556008)(6486002)(53546011)(8676002)(66476007)(66946007)(52116002)(478600001)(956004)(2906002)(36756003)(83380400001)(31686004)(5660300002)(16576012)(316002)(86362001)(2616005)(107886003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 4zq9SsaEUxvQsPNaOPiQqwUSisCaZvOJWhzmR7mFoPXTxxbVIwZVztsk3xdKM5x0H6+mXUbynpXkj337Obmfv68m9XSykLYs9kCtukN9RAPzPbauTIUrC9ILsvKZO6bsvDgIpcG2tGLLZtpFuj63TX25ZKwJietn+r6RNzr4bJ9t1OkLsmOdqutpgljfhOINAZlSNza/qtqLADyx06UBTS8LER9T6ToMfG9Zvx0gCYENwsu7uTnTIdAhQnuAo2kVdPDbVSiux4pB4GP7Q1QpAIzWwKc4YcmrwRsnkpR+NyJORfhxSACWXYvlFiPT4HtO4ro2EzllWpO7RUtvtosl2XpnLeanDTnC6Za+vLigB3DdVdO85W07NxzrX7L7hvt3U/uPEZlizI+yExXoCqUBx2hK4dtNRmcW1WR2wxwjr0i44cibsHxufQG14cmVfrM2uCSNk2B5z03ocRKO1mZhhrfFdSGc2Em+O29LFc1dNyhR4g2m1qaeDZcMliBtvBopgEYc+oqyurVlQRZvw3Rj36DXtCrwrXnXZle72d8cmqvdU6OU2Qw0sjEm0Sggh7pID6vKn3ZpvCoMHbRXeowK9I+bGWYiS3nVQ/8q/+N7kpQBeFQWkcbd8bWe5FdkJ32uR2eHSeHAhXvvvYVMdF5Tcg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf9fcdd-4605-451c-4eaa-08d86af721ce
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 19:28:13.0316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Smdmm2GRqc0z4okJbAMC3CD4/W1iKGtmEQxxNmZzjxS+rU+OtCizsVOBruY+nrnmaN9jzI/+RgSA0yBmQ08vP69LTCPLHO92jS7uXZFBLoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5254
Received-SPF: pass client-ip=40.107.21.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 15:28:14
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

07.10.2020 22:01, Andrey Shinkevich wrote:
> 
> On 07.10.2020 13:06, Vladimir Sementsov-Ogievskiy wrote:
>> 29.09.2020 15:38, Andrey Shinkevich wrote:
>>> If the flag BDRV_REQ_PREFETCH was set, pass it further to the
>>> COR-driver to skip unneeded reading. It can be taken into account for
>>> the COR-algorithms optimization. That check is being made during the
>>> block stream job by the moment.
>>>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> ---
>>>   block/copy-on-read.c | 14 ++++++++++----
>>>   block/io.c           |  2 +-
>>>   2 files changed, 11 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>>> index f53f7e0..5389dca 100644
>>> --- a/block/copy-on-read.c
>>> +++ b/block/copy-on-read.c
>>> @@ -145,10 +145,16 @@ static int coroutine_fn cor_co_preadv_part(BlockDriverState *bs,
>>>               }
>>>           }
>>> -        ret = bdrv_co_preadv_part(bs->file, offset, n, qiov, qiov_offset,
>>> -                                  local_flags);
>>> -        if (ret < 0) {
>>> -            return ret;
>>> +        if ((flags & BDRV_REQ_PREFETCH) &
>>
>> BDRV_REQ_PREFETCH is documented to be only used with BDRV_REQ_COPY_ON_READ. But here
>> BDRV_REQ_COPY_ON_READ appears intermediately. We should change documentation in block.h
>> in a separate patch (and probably code in bdrv_aligned_preadv())
>>
> 
> OK, we will come here without the BDRV_REQ_PREFETCH flag set.

flag BDRV_REQ_PREFETCH should be set in stream job. Where should it be handled, I don't follow?

> To differ between guest reads and the stream job ones, we would set it here by checking for the qiov NULL pointer:
> 
> 
> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
> index 4e3b1c5..df2c2ab 100644
> --- a/block/copy-on-read.c
> +++ b/block/copy-on-read.c
> @@ -144,6 +144,9 @@ static int coroutine_fn cor_co_preadv_part(BlockDriverState *bs,
>                                             n, &n);
>               if (ret) {
>                   local_flags |= BDRV_REQ_COPY_ON_READ;
> +                if (!qiov) {
> +                    local_flags |= BDRV_REQ_PREFETCH;

if qiov is NULL, this means that flags must include BDRV_REQ_PREFETCH. local_flags should inherit flags I think.

> +                }
>               }
>           }
> 
> Andrey
> 
>>> +            !(local_flags & BDRV_REQ_COPY_ON_READ)) {
>>> +            /* Skip non-guest reads if no copy needed */
>>> +        } else {
>>> +
>>
>> extra new-line ?
>>
>>> +            ret = bdrv_co_preadv_part(bs->file, offset, n, qiov, qiov_offset,
>>> +                                      local_flags);
>>> +            if (ret < 0) {
>>> +                return ret;
>>> +            }
>>>           }
>>>           offset += n;
>>> diff --git a/block/io.c b/block/io.c
>>> index 11df188..62b75a5 100644
>>> --- a/block/io.c
>>> +++ b/block/io.c
>>> @@ -1388,7 +1388,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
>>>               qemu_iovec_init_buf(&local_qiov, bounce_buffer, pnum);
>>>               ret = bdrv_driver_preadv(bs, cluster_offset, pnum,
>>> -                                     &local_qiov, 0, 0);
>>> +                                     &local_qiov, 0, flags & BDRV_REQ_PREFETCH);
>>
>> Why? In this place we want to read. We'll write back the data a few lines below. What will we write,
>> if underlying driver decide to do nothing because of BDRV_REQ_PREFETCH?
>>
> 
> See my comment above please.

Anyway, BDRV_REQ_PREFETCH here is wrong. You should not pass any qiov, if you set BDRV_REQ_PREFETCH flag.

If we come to bdrv_co_do_copy_on_readv, it means that we have COPY_ON_READ flag. And therefore, we will handle
PREFETCH and COPY_ON_READ here in generic layer. And therefore, we shouldn't pass them to driver.

On the contrary, if we have PREFETCH flag in bdrv_co_aligned_preadv, but don't have COPY_ON_READ in the same time,
this means that we must pass PREFETCH flag to the driver if it supports it. And do nothing if driver
doesn't support PREFETCH. That's how I see it.

> 
>>>               if (ret < 0) {
>>>                   goto err;
>>>               }
>>>
>>
>>


-- 
Best regards,
Vladimir

