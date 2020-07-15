Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B94C433E8
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 22:20:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 792EA2064C
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 22:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Me29cEkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792EA2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvpku-0000Jj-P9
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 18:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jvpk7-0008Df-Er; Wed, 15 Jul 2020 18:19:11 -0400
Received: from mail-eopbgr150121.outbound.protection.outlook.com
 ([40.107.15.121]:6294 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jvpk4-0007Rr-Ac; Wed, 15 Jul 2020 18:19:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOc7ckT4HKy6bsRz0vk43BbK4cFfuKRHbH16idEn8difnuyCwI4JpFnown+wVotAdJ6A/sT6vv56klFOLB7Oh2Zju2oSP/uXkIQeC17wYvp0hhdydGnx8lWwKAjwLyOab4yr6Tmjbc5zgOe4Etmw3tWKFKV+I2Q4QzZ3cFWS8OaXIjmZVBugq50fTmhIFb942CbkYqhFvk6mRXj4g/T5gC5H0fkNfcCc98SaCTaSkYIiuOXz+Tr2rmOBJRWPolnFisWYjxhlRv+O3MCddX5Lf+/U+YovG07CMpxPssHqtEzDzvtp1W7NVjCGpTmk9kYiepLIZ5GlWTXn43KUCYFmbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXk7ujo6D+89kb7LiN4RImmD6PAMkcx166XDgbW5ZAU=;
 b=QB0L4K/6+rcXBLAwBxwjMH2IfVsG2A8GK4RZv3vbff+Aa1Dxvem1m9OQzac0K3CiAmAudIp6PpwyxQp8xkOdCndO0z2t/qN0kB4UsHbcd+l1f/qv7jyEjhEXAIsfuMrLJytnQ/uLgamwRUlrtD+kAyFzaF2/HgAq6QI7phgznsebd6m1FOswublA2WAefe0QbMMUfcru8jj8KMqsEPNZkKI0ycixlR0O/i8AcAG8vW8CoUD4AAuIMT+B6uXJoNh/oI0tXYMGTNKoqmrHDPtGM0bsSw3dAj+wqBZ2umBCb9OvFLhhdQCHHjydmlWQf5P2c+utnz+fLRaImrx+07dOjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXk7ujo6D+89kb7LiN4RImmD6PAMkcx166XDgbW5ZAU=;
 b=Me29cEkmdZltahjM8W1MwaKCwNXyUWyCaUVIWH6SsMh0hgRcSI3FSpMxUhyRtgcDjEi5tP4rFFaWhrqdZbIc5ity3BowXWCtKyTY1qOLeQQ8lusq+rnhIwBRtKkFgHgZi2lxqAzrPjNGRmiHo3ncS/8rjOxeUgLAhIx0P9pS4hs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4408.eurprd08.prod.outlook.com (2603:10a6:20b:be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Wed, 15 Jul
 2020 22:19:04 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.018; Wed, 15 Jul 2020
 22:19:04 +0000
Subject: Re: [PATCH v7 23/47] block/snapshot: Fix fallback
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-24-mreitz@redhat.com>
 <4b87c07c-f907-129e-3019-5aec59ec476f@virtuozzo.com>
Message-ID: <dc8e5932-58e7-1c28-9fee-9467b905a80a@virtuozzo.com>
Date: Thu, 16 Jul 2020 01:18:59 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <4b87c07c-f907-129e-3019-5aec59ec476f@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR03CA0081.eurprd03.prod.outlook.com
 (2603:10a6:208:69::22) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0PR03CA0081.eurprd03.prod.outlook.com (2603:10a6:208:69::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Wed, 15 Jul 2020 22:19:02 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee24d819-a552-4432-2cbe-08d8290d154c
X-MS-TrafficTypeDiagnostic: AM6PR08MB4408:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4408A57CC5480C005612F9F6F47E0@AM6PR08MB4408.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7YCWTE+hdhWX1vzNtd+zCD6GhbBRyIKmvF9hyxuJUaOeH1HwEGsE6e39pAFFWCsh0W0gSasR6f5y1KW3KLo5Jw3ggU8CIn+2KVca3c7qkTQwHnIa4VGKUndbphm3i1YgCgVWmi8NqpMh4c4Bal2KONe21z9i9W2yDH9te0s4k0iKyJXdRhqJzo8J4c/kSvcyqU5BPUUbYZFGJbb0SpCgBvVyOWVjK411job7iz4NM009S0dcnM89nxTIWxvlBg98a2+I81dg1h5dWp2uen0y/+R7Uk4hBg1I4zwarUQZtc18iKQXZi6+HGAOjU1FJ3X+ruRRPNT2K/8qM3/bbddgXOeFYxuXBvmDQavgGYzSIddnHsmPA9+EyxQKq/asnnhn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(366004)(376002)(39840400004)(136003)(31696002)(6506007)(2616005)(2906002)(54906003)(5660300002)(83380400001)(6512007)(8676002)(6666004)(8936002)(86362001)(66946007)(53546011)(956004)(36756003)(52116002)(16526019)(44832011)(4326008)(478600001)(66476007)(26005)(31686004)(186003)(66556008)(6486002)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: wrLO/QIsp0aWrK83HRBf5t9z3rrBHLXFMwfRpnl2FFCDHG3qx25feNXTutwLgsWAprnoUqVPgb6xvaRs7eiPVlebV6cRn65k6C2MCmx9W2e+uAZfjEeO/SsKd2w6qP5mTeckURPES5CorW4+1Du+zv2sJkcQ24Zq7Wn1/i2v090FN6e5B1Sr3eDKNzdxozL5+dSvfQ3m3xEBL0pJNkPxJ8ppq3CBcs3Pe4Zn3JX1gTRTKnE+y7pra3HVokcPjiPeUjM5Nfo/a76GqnM++1La6OdFSmGoGc7GTX6cDyY+LW97WGlrzxfz+rIPOp3h+cPOphkwhgXStgW3eqPIucxtmfErUsoBcrhL+OX4XThenjGXrAsIMMaXGxFXz0SwMSCLY/DuzJml+WSnIVm8LTCKji/SMZvGJaiKQMAcK0ChVBNiqNoY9YBiUSefnE+vUiz3HOPJriYxmZGzofkPSJADjakK7X3HBCxdKSzgGQE6bNIE17vTYir8nIBJw15QiDE9
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee24d819-a552-4432-2cbe-08d8290d154c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 22:19:04.2981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bsd/ZrhnEzEHyx6aC6404JzhjzgLF8ugQITxiRi2jWJZdc1qi52On48f9u2FOUl1BwJYqZ4yWJIpqoF42zbwnZBp6D3kiyLVAhGu1wddJEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4408
Received-SPF: pass client-ip=40.107.15.121;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 18:19:05
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16.07.2020 00:22, Andrey Shinkevich wrote:
> On 25.06.2020 18:21, Max Reitz wrote:
>> If the top node's driver does not provide snapshot functionality and we
>> want to fall back to a node down the chain, we need to snapshot all
>> non-COW children.  For simplicity's sake, just do not fall back if there
>
> I guess it comes to COW children like BDRV_CHILD_DATA | 
> BDRV_CHILD_METADATA  rather than non-COW ones, does it?
>

The BDRV_CHILD_COW is mutually exclusive with DATA, METADATA and 
FILTERED per definition.

Sorry about the question.

> Andrey
>
>
>> is more than one such child.  Furthermore, we really only can fall back
>> to bs->file and bs->backing, because bdrv_snapshot_goto() has to modify
>> the child link (notably, set it to NULL).
>>
>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   block/snapshot.c | 104 +++++++++++++++++++++++++++++++++++++----------
>>   1 file changed, 83 insertions(+), 21 deletions(-)
>>
>> diff --git a/block/snapshot.c b/block/snapshot.c
> ...
>> +    /*
>> +     * Check that there are no other children that would need to be
>> +     * snapshotted.  If there are, it is not safe to fall back to
>> +     * *fallback.
>> +     */
>> +    QLIST_FOREACH(child, &bs->children, next) {
>> +        if (child->role & (BDRV_CHILD_DATA | BDRV_CHILD_METADATA |
>> +                           BDRV_CHILD_FILTERED) &&
>> +            child != *fallback)
>> +        {
>> +            return NULL;
>> +        }
>> +    }
>> +
>> +    return fallback;
>> +}
>
> ...
>
> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>
>

