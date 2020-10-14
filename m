Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8212C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB66C22250
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="b6kQd/Qd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB66C22250
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSnkA-0002bx-CP
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 16:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kSnit-0001cq-3X; Wed, 14 Oct 2020 16:50:11 -0400
Received: from mail-db8eur05on2119.outbound.protection.outlook.com
 ([40.107.20.119]:38369 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kSnip-0004Ga-H8; Wed, 14 Oct 2020 16:50:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrY88znf8DdPFr3ofpNI+HQEQwxoIHU39XRKOwKFPQoz/JTIDVF5fruqwDUcuraHJYgBi/DPfu0rRA0G4nhYKm9IyVjASo5tPmZi7tyGpVzAnEP5F9uY1L2GaQ/fDHtrZ6E3a5yrAnlnHNtyuAk+doDqPoc8WdfPTlV7LqsZotwmxTXe3f6JAbmIS9pyD5ExNF2bqKvM0VYP9p7FAwa15T94K3W8ycSSjF7AFWq6/hvY32f8/U4aLQ2llBUJjpuuUevy4Ycinp/JWGuITVsfWpQSMelbp/evP7r+lp2QdMhbR+G9qOLxDID4FfOAP1uKFOrdXmW5iecV6NIy4Qnwfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHKB0NuIEjpfNia1ZOZ+Npmuf+5n8h1uAh+TKqO/MVE=;
 b=jm6/nKztqAlEohTQm3ZnnRDJEImWKkyOy4KCu9yMNJ2Xo4iJ2HNptdNVTdbU0uSu/UKEKl69+kYtOo0iYh3Fr5zsrlSiH/lAJDh8nNpKAR8roHWCjG1QiFWJOwRaIhM/8mOkZbYSVdKJ3vPlWogru6vXiCCHjCY44iqCk5YWjx4y/5vZoi0JvGbfwDPJAuUHUBrAe5moXYt3xOSBPT44qUDpMLBbyfkjV8kW6IKM2szdt7TwHapG3TVXVo8cQuIO5p71abupJ401Oavj4MG2qNyZ64sfFxtJsoRURqfLPKsO1nK5GjxZcjGoNEKqkAZpwNuq1OEueMyHPj0DnGAAlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHKB0NuIEjpfNia1ZOZ+Npmuf+5n8h1uAh+TKqO/MVE=;
 b=b6kQd/Qdu8BifHvuJJ9RAtyQGkx8pSTQI3M/Gjy/dUasHh3hY+B19c5iDpOW5OH0+m+McXAounEhP/Qehdaldz4jf1f5auWbyhRtWJzV4tdqFix3FXJ7Te8CTL/vhtjNpuFtAgg8iiNpdLaDM0r01TGGesolD+LiSSs8OsMiJwg=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR08MB2652.eurprd08.prod.outlook.com (2603:10a6:7:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Wed, 14 Oct
 2020 20:50:00 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3477.021; Wed, 14 Oct 2020
 20:50:00 +0000
Subject: Re: [PATCH v11 09/13] copy-on-read: skip non-guest reads if no copy
 needed
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 libvir-list@redhat.com, eblake@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-10-git-send-email-andrey.shinkevich@virtuozzo.com>
 <59ff1f29-149a-0870-b600-1a54f0421c05@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <bff09776-dbc1-d0a4-3f51-8b3d202564c0@virtuozzo.com>
Date: Wed, 14 Oct 2020 23:49:57 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <59ff1f29-149a-0870-b600-1a54f0421c05@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.252.114.22]
X-ClientProxiedBy: AM3PR07CA0059.eurprd07.prod.outlook.com
 (2603:10a6:207:4::17) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM3PR07CA0059.eurprd07.prod.outlook.com (2603:10a6:207:4::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.13 via Frontend Transport; Wed, 14 Oct 2020 20:49:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 657a9616-ba20-4420-d586-08d87082b790
X-MS-TrafficTypeDiagnostic: HE1PR08MB2652:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR08MB26529B328D8E48F71A95F708F4050@HE1PR08MB2652.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R5jRUwtfgmmcot9f8HehzkeLE5ePBvWmLhXLCeYgp9bNuSt2qxxc9ttAhOkS/2E/hKRF+EqKybpKDmBt62sRtu/D4K0J+R+5ZXtdeZg7dHC03LHcgr4/5OZpZKXGSHxO6KGQPdadNIi3sjwvMIVE65PuzECH5B1LRqQwosx6N3ag57m2lb5bfrD77sNC9HEhtmL0D1wI3soAZ04L8Qj5wJrrQl1apdhkBMZDJkvU+0g1icHUK/dNr6Bs9KQHEfeQnN9L7ehCAH9p6Urz5Rf8653zfXPcPoM1Lp/ZHCsDD2bPhdKAt+55MKhQNrsTm6VsPhJ8qAsQdzkAQqFK8azNrZd/s4idK1Ntd0u2BAseFVjcV3xJv98qLGiFGqqtMdkx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(346002)(376002)(366004)(396003)(136003)(26005)(956004)(2616005)(7416002)(52116002)(83380400001)(86362001)(5660300002)(53546011)(31696002)(107886003)(36756003)(2906002)(6512007)(4326008)(6486002)(316002)(6506007)(8676002)(44832011)(66556008)(66946007)(478600001)(8936002)(186003)(31686004)(66476007)(16526019)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 1JIU1dIgzyKU7Pa+QPzoz2eMAmK9R3B45qw3x9iX+xTLKxTwagnGpUod8KQx8YRz4U4hYx2u+KOcuZgAsAMj2UVT7YBsrYHER3HqlTTt6o/zZ9dDeS3Zcjq8sA+p2/bfMYjwlLWi9QsDUbRzu7geh0a5dH01r/c3gwqpUbFFwMDkvgLsyISCyepACot0a35+2Hsn/WXnVQnOs/nqOoKvI8zoyj1PX50kFZBSuEtmDDh3aqx1SBZPv1MkgOF1MLXAMliiHsZpsScex/RkqJaJNpNx31RoGk20BP2UfnvGj8tKdoevtbIN4kf6grOJKAZU5cs4Apmr1ctBObj6Kb2Yd1oGF0XZUC+UL5XZPUmynjNXUdWD902Ml0wuXPjD1bb9KJTFjon1W1vWMM+U/IWDfozVc5xy+73HVlwwe2YAgmmtoGO4UpQTjfThqJUnpeJfo1J1k+KSseVOAqDgfw4hLSktdp9uYtbWfk6aBrV3OXnMZ6cB0wFCBgLYF4Vmyk3T8rR45WR5dpIyalLRx1YiyQGRPRa1B2vV2yw7Eea3HmHpEICvqZ1uTtyTPCZV9W2IvUkMln25XQH0cAh8Ft809a8BvdCkg+A3/La8SAFrnlPZTp7fAklmPF7iAivAUGm3FieK5hXupmZYesG0jrHx5Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 657a9616-ba20-4420-d586-08d87082b790
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 20:50:00.3305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RD+rIXbCtUjUxcq6jS+RsQf0upDuvaNA1FWZJaNe90ZCEEpX0xP37pev+U9GUaeFmZ/w+IKKLVKUynWLkCv0Ie7m7J+r9F90aqEaF6UaUtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2652
Received-SPF: pass client-ip=40.107.20.119;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 16:50:02
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

On 14.10.2020 15:51, Max Reitz wrote:
> On 12.10.20 19:43, Andrey Shinkevich wrote:
>> If the flag BDRV_REQ_PREFETCH was set, pass it further to the
>> COR-driver to skip unneeded reading. It can be taken into account for
>> the COR-algorithms optimization. That check is being made during the
>> block stream job by the moment.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   block/copy-on-read.c | 13 +++++++++----
>>   block/io.c           |  3 ++-
>>   2 files changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>> index b136895..278a11a 100644
>> --- a/block/copy-on-read.c
>> +++ b/block/copy-on-read.c
>> @@ -148,10 +148,15 @@ static int coroutine_fn cor_co_preadv_part(BlockDriverState *bs,
>>               }
>>           }
>>   
>> -        ret = bdrv_co_preadv_part(bs->file, offset, n, qiov, qiov_offset,
>> -                                  local_flags);
>> -        if (ret < 0) {
>> -            return ret;
>> +        if (!!(flags & BDRV_REQ_PREFETCH) &
> 
> How about dropping the double negation and using a logical && instead of
> the binary &?
> 

Yes, that's correct.

>> +            !(local_flags & BDRV_REQ_COPY_ON_READ)) {
>> +            /* Skip non-guest reads if no copy needed */
>> +        } else {
> 
> Hm.  I would have just written the negated form
> 
> (!(flags & BDRV_REQ_PREFETCH) || (local_flags & BDRV_REQ_COPY_ON_READ))
> 
> and put the “skip” comment above that condition.
> 
> (Since local_flags is initialized to flags, it can be written as a
> single comparison, but that’s a matter of taste and I’m not going to
> recommend either over the other:
> 

I played with the flags to make the idea obvious for the eye of a 
beholder: "we neither read nor write".
Comparing the BDRV_REQ_PREFETCH against the 'flags' means that the flag 
comes from outside of the function.
And the empty section means we do nothing in that case.
Eventually, I will pick up the brief expression below.
Thanks,

Andrey

> ((local_flags & (BDRV_REQ_PREFETCH | BDRV_REQ_COPY_ON_READ)) !=
> BDRV_REQ_PREFETCH)
> 
> )
> 
>> +            ret = bdrv_co_preadv_part(bs->file, offset, n, qiov, qiov_offset,
>> +                                      local_flags);
>> +            if (ret < 0) {
>> +                return ret;
>> +            }
>>           }
>>   
>>           offset += n;
>> diff --git a/block/io.c b/block/io.c
>> index 11df188..bff1808 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -1512,7 +1512,8 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
>>   
>>       max_bytes = ROUND_UP(MAX(0, total_bytes - offset), align);
>>       if (bytes <= max_bytes && bytes <= max_transfer) {
>> -        ret = bdrv_driver_preadv(bs, offset, bytes, qiov, qiov_offset, 0);
>> +        ret = bdrv_driver_preadv(bs, offset, bytes, qiov, qiov_offset,
>> +                                 flags & bs->supported_read_flags);
> 
> Ah, OK.  I see.  I expected this to be a separate patch.  I still wonder
> why it isn’t.
> 
> Max
> 
>>           goto out;
>>       }
>>   
>>
> 
> 

