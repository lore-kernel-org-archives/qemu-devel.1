Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B919FC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:14:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 365E721D42
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FwSeyzrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365E721D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLrJ0-0004HY-1o
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 13:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLrI3-0003T1-OJ; Fri, 25 Sep 2020 13:13:47 -0400
Received: from mail-db8eur05on2107.outbound.protection.outlook.com
 ([40.107.20.107]:46945 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLrI1-0005JX-E6; Fri, 25 Sep 2020 13:13:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhMXDKHRh5WYxzVFbKHvEFI2ZR2wzH/lzqBwgDgRZtmurn7XpP5aPL3Yg+5+IP1dIfi4x4SM3L1Y17sbYKEvEIEwnDQ9quxmiPqUTyexSxyOqavH0l1/RbOAYSgYy4+z3CGuEVORbC1GDOL+GHbWRABUbD1TLH2Ll/Vrh0nla7t6553Ygdnar73R5WE2Wqvs+Q5858I68VxdsUZ2prpL6Hav2OArFlZZzouTeMg25/y+dJWQ6LG32pgGI0Rjn9VDr+GVTKFDVUCddVfp07kbzWsq94q9jw7ukB5JHiipBDs1J1qyqPlE2K6lhMGJbxpY5ZTU86OW7nNKv7VdJqqv+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBRLzqmkTzGIGfieHjz8og75JWSeNvPwJiXwlz3ajIw=;
 b=NuU4smD3j8eGZwsGu5j66FFu9mPoBYQ7VApK5djRQwJ2JBJ7GKyr8A7EYLCLBCflgNigoFObGN1KEgTkf8usIcUmkB5mCBsC17m4HEYgxbtRffdjgp+OXiBcHXS3wD1qmTCGAPxO+VNsgr4ZOU+SYoE92kleJiISAy7Qc/lw1kNgDwhbJBxYH0aYYml7RujK+3rf75et7Z6vJTyDvtIY1YI7goxRgQp3zGFhtRjEzCEURvqAFW78FchBlRSjXzoUIThkzd/KQHdY+vVPRN21Ys3IKmVCk8pM89dVFEl8HAwKbb+3NiAADdqC0C1FZGIiJPKOiRS/77NOf5QpbpNerQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBRLzqmkTzGIGfieHjz8og75JWSeNvPwJiXwlz3ajIw=;
 b=FwSeyzrzEfR9mFeCr9FwPQoeDIa0A7z3BsZJLPCg2ZnoNlyZ1HgMBBq2nI8qpOJ2RtY1dnnVO8M9o/4icdIDzoenr8/rA6zZvHOXYotROQyO6FsMj5efvjyaJmb004eA6hPl3bJRx9Pu0orqq1s2A2JAYga7FQlrp2voVXwYkH0=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB2983.eurprd08.prod.outlook.com (2603:10a6:209:4d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Fri, 25 Sep
 2020 17:13:38 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Fri, 25 Sep 2020
 17:13:38 +0000
Subject: Re: [PATCH v6 14/15] scripts/simplebench: improve ascii table: add
 difference line
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 fam@euphon.net, stefanha@redhat.com, kwolf@redhat.com, den@openvz.org
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
 <20200918181951.21752-15-vsementsov@virtuozzo.com>
 <6b808a3b-735b-45b4-79bf-6e73000de5bb@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <5df7fb5f-d551-c9fc-d5a8-dc267599d1b7@virtuozzo.com>
Date: Fri, 25 Sep 2020 20:13:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <6b808a3b-735b-45b4-79bf-6e73000de5bb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0302CA0020.eurprd03.prod.outlook.com
 (2603:10a6:205:2::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.94) by
 AM4PR0302CA0020.eurprd03.prod.outlook.com (2603:10a6:205:2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Fri, 25 Sep 2020 17:13:37 +0000
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5842aa5-4105-44e8-3e05-08d861765806
X-MS-TrafficTypeDiagnostic: AM6PR08MB2983:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB2983311440F49A455A946219C1360@AM6PR08MB2983.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QffqzKELibL/63WFBaJhOuqeuf18HOCH0yi2QgieX27bZ/zfkMWl1SaqtM51IyACYb6oZl9PjVHzFTSP1jHBFCqSHB680XvRiCQjGxEHNHOPVYEYMtVJxAa1i3YmOxPzzpHAhQB+m26VJJZXBlZaVV4BDXqqLwlzKlUnzgHYBrQw1yG2CSYLg6dP/IAyIrOo26iYex4kUgWpXFlq+uREGPeLe2rRTQqsaxUwkpqq4/JULlxKMOOGwxstoL8PPsIqfvcATJ7Nt1BZwoGTkORK/umktnqLtPRssdVz0/kFH3g2dVkUrzHrMezNdCnCy12A6hMtZq6+dMWMogxLDN+Q9IKEP/2YiF/VF49vmk7ABlsKH8cQ9DeFpCn9vx55x+dU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(396003)(376002)(136003)(366004)(16526019)(16576012)(186003)(316002)(86362001)(2906002)(31696002)(8676002)(8936002)(36756003)(6486002)(5660300002)(956004)(2616005)(83380400001)(53546011)(66476007)(478600001)(52116002)(26005)(31686004)(107886003)(4326008)(66556008)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8K8MU/hdbd3ybf2vnb+8eAH1Edx8X+Q63Skz3pMF28hoT9Wy/u7TuOGHobF0TIvHQG2C52YA9qOR6UN2OPbO9CFt8pW52gKu3EkHTnBBbCiSLaUhcQ/zINUyBDwQGYxHYkw/5UJ2yu7Ap9Bs0S5DnjTEvZ2X+9uLCgIRUpKPoz6lW/GqcQ5O9V6QLN98OPalvBOkrsNYiTdlnzKFEzhh9bT/kuOF7Pbp4IXxcUaR2mtJbjboH9GJQqjsX4btmZx3u0sCLeheg6J0BHPMFDeueYVGvCjmzMBuiENmqLxN2UHXyv5zYWsdai3u82GbfoTMGPtDRj4dczJEYHGD8ES87yStekEDco6bcQF2hsMb8ONxYirmnyjGvIxhcjhshWCiB2GB4qmmRFmBsw/kzo64Px4Vd0tBEgGzE5yGVGSHGj9/D2x5QXMcDM5Vhb851ddwv6KK26njGypCbFLee6y7M5o2qusC9q22Le4REWmLGHfqnpKRr+MWaGV8y72RcsTtiLR/G3EH+EoZ7U8f7BthuMRkTpyEXJpI4JdmSTDGCHIL7AHZcYnkyodZSic4fLx0f+EXFwfqDrjT2DYDBggXQuFDdjNijZCSD+IzWX742VGNVtVgHtG5wiZHOS0THgh6648qiJjgq9GL6hgoM3REOA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5842aa5-4105-44e8-3e05-08d861765806
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 17:13:38.4899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rg0LDGx1rbQBrpDzM7pkVOycWDUxpjZzlbcUrgwWAxGPpNxRSXHmPrQAjhD2jm+m/a2Bqyil88a6qaehhxpywAIaE5QMugybVojcm5C0hbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2983
Received-SPF: pass client-ip=40.107.20.107;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 13:13:39
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001,
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

25.09.2020 13:24, Max Reitz wrote:
> On 18.09.20 20:19, Vladimir Sementsov-Ogievskiy wrote:
>> Performance improvements / degradations are usually discussed in
>> percentage. Let's make the script calculate it for us.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   scripts/simplebench/simplebench.py | 46 +++++++++++++++++++++++++++---
>>   1 file changed, 42 insertions(+), 4 deletions(-)
>>
>> diff --git a/scripts/simplebench/simplebench.py b/scripts/simplebench/simplebench.py
>> index 56d3a91ea2..0ff05a38b8 100644
>> --- a/scripts/simplebench/simplebench.py
>> +++ b/scripts/simplebench/simplebench.py
> 
> [...]
> 
>> +            for j in range(0, i):
>> +                env_j = results['envs'][j]
>> +                res_j = case_results[env_j['id']]
>> +
>> +                if 'average' not in res_j:
>> +                    # Failed result
>> +                    cell += ' --'
>> +                    continue
>> +
>> +                col_j = chr(ord('A') + j)
>> +                avg_j = res_j['average']
>> +                delta = (res['average'] - avg_j) / avg_j * 100
> 
> I was wondering why you’d subtract, when percentage differences usually
> mean a quotient.  Then I realized that this would usually be written as:
> 
> (res['average'] / avg_j - 1) * 100
> 
>> +                delta_delta = (res['delta'] + res_j['delta']) / avg_j * 100
> 
> Why not use the new format_percent for both cases?

because I want less precision here

> 
>> +                cell += f' {col_j}{round(delta):+}±{round(delta_delta)}%'
> 
> I don’t know what I should think about ±delta_delta.  If I saw “Compared
> to run A, this is +42.1%±2.0%”, I would think that you calculated the
> difference between each run result, and then based on that array
> calculated average and standard deviation.
> 
> Furthermore, I don’t even know what the delta_delta is supposed to tell
> you.  It isn’t even a delta_delta, it’s an average_delta.

not avarage, but sum of errors. And it shows the error for the delta

> 
> The delta_delta would be (res['delta'] / res_j['delta'] - 1) * 100.0.

and this shows nothing.

Assume we have = A = 10+-2 and B = 15+-2

The difference is (15-10)+-(2+2) = 5+-4.
And your formula will give (2/2 - 1) *100 = 0, which is wrong.

Anyway, my code is mess)

> And that might be presented perhaps like “+42.1% Δ± +2.0%” (if delta
> were the SD, “Δx̅=+42.1% Δσ=+2.0%” would also work; although, again, I do
> interpret ± as the SD anyway).
> 

I feel that I'm bad in statistics :( I'll learn a little and make a new version.

-- 
Best regards,
Vladimir

