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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DE8C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 17:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8DF92168B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 17:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UDZsd4c+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DF92168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQDRz-0008M5-U5
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 13:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kQDQB-0006s8-A8; Wed, 07 Oct 2020 13:40:11 -0400
Received: from mail-eopbgr30094.outbound.protection.outlook.com
 ([40.107.3.94]:39160 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kQDQ6-0001al-PV; Wed, 07 Oct 2020 13:40:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQXZFiRAyk/G1I+KecN9ePbIMbg8pT2BhUyU81RnrKexbqR6wmGrNW8X4lbFBNGM38IUUFOIhLG02aJTdUd6AnUEojKuCCg0VDj7Dxohhn3viYWQGD42zqg6PUUSkorY74Bbq5Wh4QzHzuO6JnxLhyIVgJcQ3gQQQbrWcE2FXM+OFP14pS7lnhuNqFJk1wxLpSlkhZpLsnX3T6EgDhV8v8d/c+xwGcUvnUCqVFy0H0s9+xHWEc+VxQvv9JP73ZI0iSM+PLU0aTkUzGpyTWKvOxp0Y5nUjL+EXwrKiiZNNjH1sFa62wP1iJTQDVQUuy/mTfvaHSGdm0s5NXtvmvxlQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTfRGlITRq9XXNpuJNFyqnYkyHZOJLoN1/3/uEwTQbw=;
 b=EQmSEywQhrZX75RGYEZJ67yMEff3X9LrjMKNT6C0jeu0ivPT5brDE6yK4qk4Iz080+ZrD2guSEIMmPJWY1aNShFAqUVmjK6TbS73zpRAqpN8htj6NZLcF1GTYOkT4gOLZCkESUcE7iWDlllqGLO2gh+02OBVsm/BD3pVCfyFspKHHaqmK0KB0l+yVUZ79VC+aub7BGf1Vc+F1eNOFLIark9zzhss3wVFGlyOY0NSU2al3KyzmTl790vvWvHzqTnlN25XoW4YploFyQr/2TrBp3wPir6+QMhH93yfcGljSQ8HoYYImEv9pmDwRJ7aEjXRGKsmajGRiN5e08wD22uSRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTfRGlITRq9XXNpuJNFyqnYkyHZOJLoN1/3/uEwTQbw=;
 b=UDZsd4c+a8gJ0feCHbuLVceMGXQEoxcphytDQwVZqY0M3lgxHc8OCbCxdHCP7hawx/m/fVONuAz0C+bRHvsFGw1dF9rZUtmVWIocHZdkS1aGIJlWPxZGP/mMZsbgq6Z68lRYkuATa0shUC2VC/FYbG+nQrCL0Mj97ApNblsoIRo=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0802MB2522.eurprd08.prod.outlook.com (2603:10a6:3:dc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Wed, 7 Oct
 2020 17:40:02 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 17:40:01 +0000
Subject: Re: [PATCH v10 9/9] block: apply COR-filter to block-stream jobs
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com, armbru@redhat.com,
 eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com
References: <1601383109-110988-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1601383109-110988-10-git-send-email-andrey.shinkevich@virtuozzo.com>
 <9fdba83b-4f78-9cce-afbb-9d38525ab969@virtuozzo.com>
Message-ID: <66710946-00d4-65cc-2408-785aaf624121@virtuozzo.com>
Date: Wed, 7 Oct 2020 20:39:59 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <9fdba83b-4f78-9cce-afbb-9d38525ab969@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.252.114.22]
X-ClientProxiedBy: AM3PR07CA0070.eurprd07.prod.outlook.com
 (2603:10a6:207:4::28) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM3PR07CA0070.eurprd07.prod.outlook.com (2603:10a6:207:4::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11 via Frontend Transport; Wed, 7 Oct 2020 17:40:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c38c2e4-84b0-4c20-a1f7-08d86ae80478
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2522:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2522CE32C25223D374FE1329F40A0@HE1PR0802MB2522.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3dhWCpnzKr+D2RUQ6PPk+V+xcspiutH0jLePkTSPlUkLPoQZQfTG6mc8Mwlg7TQUHVErCrr0XyNqKqFPM0XNPmtDycQaVeupMWEup4IvMbHfF/jUtVoqY9R7giuwbq35i8AQxuxL0eRjfgrIvL09UaMLd55Y8gdiDBsd8Xe5usWzntWAdDRRuzLbXexZTg0gChSI02eMUZwv5naAMXx7AqcFAZJbOMAKuAXQeytFK88GJWeqYa8VVYK/A8HK6RqcuW3c5uSyVfdLQz9WbFyP+06ChtXOLiqJdBPePNlUQiWYldgUby8MeVljishyVIwaGsJPo4fh4WfbiL+m50jUZp9SJNIJ6KdqijOtlYp+9CD5I0lzILYxQpQWKqaNUKkj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39840400004)(346002)(376002)(396003)(66556008)(6916009)(66476007)(5660300002)(107886003)(6512007)(316002)(66946007)(83380400001)(8936002)(2906002)(2616005)(31696002)(956004)(36756003)(4326008)(6486002)(8676002)(52116002)(478600001)(53546011)(186003)(31686004)(44832011)(6506007)(86362001)(16526019)(26005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 47JcZ4grMuPIh1KQVGUP69eQd654X9gnsurhvxtdhfHdcBOKfFJaqU9GOZNQsJ2nAOA/zgzOP4IKA8KiTjybskKLEqv1VTQant2jgn+pCZvTpQ0FVvYfzU5FrkuIO3N2d1i4AD4c7zxvY8VrwRYxHHmAJkSXYdmGtQB8LVh/2y+LQT+nYzp7KYYTYWnlT/Q320ZtIKYVcbVZfkXu6o8PevY6qLJS99RWgYCJ3PsXqruHwFus2j3yXrXdzjZgEhSiBCZdoa1lFlEf3iC6ZXlb+30IxayJZ9fOrgvcokSn8gZUdAr4Yz0lyIM4Dafr2cekLm7/HQxsAu+G6gqFsJDzDCN5D8MrQZyXREoKMx4uRQFWoH10MtkHoPQSW/7686M7wV7n6BrFOn1VrmINfRbAQxASNLH3SVjnmDOO86dR+IOFY3Y8o2L47aHGFDh0VbFad6s60njGf1bcps2ycNbM26K9qW4tFDkTwip7WqiGgQGcXbdIXygOTljD6BNT+O5zTQtU7erOhkSlzblDQGvEE3+z3noYNyVHVqwiRvuvKUv+n7m4IV8JyqDSXdC7Kh5oOvHKxhQgb/P4OJUMz0NGTZNPUO4OCr+ZKDfD8eSIgd6FrBLLKFdf3NpjCrmo/oZ6sugztiStrddXMijCsVVhZw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c38c2e4-84b0-4c20-a1f7-08d86ae80478
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 17:40:01.5785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBlcH5EJan8fkzPzUM4NhVVFL0aMqrA/bZhjWKL0REUBmNuY0T0dVNFNletiBuGUfsI0WDeZCs+cUbK1Qpsvdpz8Ji9PPBWzldote+mfjIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2522
Received-SPF: pass client-ip=40.107.3.94;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 13:40:04
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


On 07.10.2020 20:27, Andrey Shinkevich wrote:
> 
> On 29.09.2020 15:38, Andrey Shinkevich wrote:
>> This patch completes the series with the COR-filter insertion for
>> block-stream operations. Adding the filter makes it possible for copied
>> regions to be discarded in backing files during the block-stream job,
>> what will reduce the disk overuse.
>> The COR-filter insertion incurs changes in the iotests case
>> 245:test_block_stream_4 that reopens the backing chain during a
>> block-stream job. There are changes in the iotests #030 as well.
>> The iotests case 030:test_stream_parallel was deleted due to multiple
>> conflicts between the concurrent job operations over the same backing
>> chain. The base backing node for one job is the top node for another
>> job. It may change due to the filter node inserted into the backing
>> chain while both jobs are running. Another issue is that the parts of
>> the backing chain are being frozen by the running job and may not be
>> changed by the concurrent job when needed. The concept of the parallel
>> jobs with common nodes is considered vital no more.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   block/stream.c             | 93 
>> ++++++++++++++++++++++++++++++----------------
>>   tests/qemu-iotests/030     | 51 +++----------------------
>>   tests/qemu-iotests/030.out |  4 +-
>>   tests/qemu-iotests/141.out |  2 +-
>>   tests/qemu-iotests/245     | 19 +++++++---
>>   5 files changed, 83 insertions(+), 86 deletions(-)
>>
>> diff --git a/block/stream.c b/block/stream.c
>> index fe2663f..240b3dc 100644
>> --- a/block/stream.c
>> +++ b/block/stream.c
>> @@ -17,8 +17,10 @@
> 
> 
> One more change missed, as we use the COR-filter:
> 
> @@ -47,8 +47,7 @@ static int coroutine_fn stream_populate(BlockBackend 
> *blk,
>   {
>       assert(bytes < SIZE_MAX);
> 
> -    return blk_co_preadv(blk, offset, bytes, NULL,
> -                         BDRV_REQ_COPY_ON_READ | BDRV_REQ_PREFETCH);
   +    return blk_co_preadv(blk, offset, bytes, NULL, BDRV_REQ_PREFETCH);

Sorry, with the only flag BDRV_REQ_PREFETCH set.
A change in the comment at the flag BDRV_REQ_PREFETCH is coming with a 
separate patch as Vladimir suggested.

Andrey

> +    return blk_co_preadv(blk, offset, bytes, NULL, 0);
>   }
> 
> Andrey

