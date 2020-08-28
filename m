Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C91C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 16:29:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84CDC2080C
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 16:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AFA9xSa2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84CDC2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBhFn-0000Wd-Ln
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 12:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kBhFE-0008PB-1i; Fri, 28 Aug 2020 12:28:52 -0400
Received: from mail-eopbgr130104.outbound.protection.outlook.com
 ([40.107.13.104]:48014 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kBhF9-00074H-S4; Fri, 28 Aug 2020 12:28:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGi89byRA6Dqkd/jQu4Ui2h1JeN0yiWbdv7BYVmMzGFrRKZ/VH+EEn/n4+fJ3HTqqL3zbIZvv6+T7V2EHw5pEDvz9C3O9Hh4OZavjEYlSWFckHLGoJpxKY1vifSdKjYCU9kJQnBBBPqI6X3CU+Cz1/+ERABEWmAnKxfacHnaaSh27/m9bmUggUQXqo0YmjYmYjYSHtRIwTWd8M9ygz+HZkxrBflm2Ot3ubjDR+jYo5isN9P26d6AfCDh30UU4wN/xgfnZLpIG3s9dEW78jAmMnz1VFIBK263eY3sUOb3GnxPpykLSp1E5FULGvYscEqXUG6uGG+Q2P43qwnUPiAg2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24p3HBhex2pqwtFnhm+1+eMJQFFmDRZVbtSJNXXhuE4=;
 b=ln2A+yyIhFB638y10Qt8/RuNt8Nv+UOAhT4xzvUIBFDrt1KMZ1ppnxYIgpnDWuKatp7S3/mL0Dr93Kde/tro6cRtNrwzk9gOPRN0rrROGy25zMmEahO79EwnNeWQ6osW4LjqU9B2FYxeCelLGqMEMz61Lsmg0fCVQ8odpV6lvlgsRkyroczwWOMh8r8KeAb6LywpLXHFoV8l92SGYqTm5PAqrchL8YdqGmhW/3AuJISPdJ6Ku+iR6hJpqJtuMOjyGeTBqOgmmRduDL3uWM+t1CfIxlrjofHFfRIwieyPMFNuscOoW2Zd9hWmrF+LhaRFHskDAoaPKVClGAT4jPgX9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24p3HBhex2pqwtFnhm+1+eMJQFFmDRZVbtSJNXXhuE4=;
 b=AFA9xSa2FezwxMG+tSRwvCDuyBDNCpOrbq+Q+j2jtuPG1ua+eF4DXnUACcFx/Tyzm5o/Bosv5hb3sWqmxaEwhGucByxLZ14kS4KMIhHFxs38hMnYW9ijmNvgYFgOLHMEfW9rtmCGWeTykLLNvNA0id+UbGQHLoObBJfDE4VtM4E=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0801MB1673.eurprd08.prod.outlook.com (2603:10a6:3:86::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Fri, 28 Aug
 2020 16:28:42 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::b5e5:e4d:ed88:5a3a]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::b5e5:e4d:ed88:5a3a%9]) with mapi id 15.20.3305.032; Fri, 28 Aug 2020
 16:28:42 +0000
Subject: Re: [PATCH v7 4/4] block: apply COR-filter to block-stream jobs
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 armbru@redhat.com, jsnow@redhat.com, eblake@redhat.com, den@openvz.org
References: <1598257914-887267-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1598257914-887267-5-git-send-email-andrey.shinkevich@virtuozzo.com>
 <2eef369e-a79d-57c9-f8c8-40be9c3aaa2c@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <5a2bfe27-3589-5735-a3f8-cbcfc9cdbe75@virtuozzo.com>
Date: Fri, 28 Aug 2020 19:28:39 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <2eef369e-a79d-57c9-f8c8-40be9c3aaa2c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM4P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::25) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM4P190CA0015.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 16:28:41 +0000
X-Originating-IP: [109.252.114.22]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04b47e30-eff0-4db5-8cea-08d84b6f6d55
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1673:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB167313DC84ADD1E7BA896E59F4520@HE1PR0801MB1673.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5MC60gJ0wWMZFJcrWMHds5d6RCWuAVpPmnP5pKtSZWFY69c6wVR57RGOVK1AlcUCXjaWOaAd4E3kR5a4mnAv88ydULkW2955ibq50PXlYM2Ax+mHK29THoBcaegGfSIiJvmhChazE5YdFfA2sB8daURMrYYQOause/HqebNvVlicmWtHR4XgsYaE9i2JGoD0WGw4MHaWrk064MoHfTlSCe3Xfn/ON5PbuEzHuPgQjuHEx3uwnBv0Rk7F3eIp3wgHEk+7W3EVncyGde7Zti6GkdoGiUE00jMg7RcOyclJQ//F810BZnLqdprhybH0A/CSsEql30UNqs3Z4LRDQA+x10BK2f5RyCjHCQP4jKemvA2lSkVGmqBo92YKdeUV+pDD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39840400004)(107886003)(83380400001)(5660300002)(4326008)(6512007)(8676002)(2906002)(6486002)(36756003)(316002)(8936002)(86362001)(956004)(2616005)(31696002)(31686004)(44832011)(26005)(478600001)(16526019)(186003)(66946007)(53546011)(66556008)(66476007)(6506007)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: S9s4mX6DRQYhP5V5IlR64jGk5Cp7BhKO//hLehebJh/tijIfacHWDJLBGOzsbCx8azIUIPUFimV8v8t+hpzr8Axfy+UK5a2QeS97lTIsEMhHj06rAUycIKNRLUl51DifQkGUH0INiuoo8ghxB8VFwaFqmx8E0at9K3nSk8DuVfSeNErz4XdJf26bj3r9zDiKcdt59y9dkuQBdEmD0zXf46YZY+MirQThckqgGXBNf7HCQ+M1+IphLTzsnr0KnPC880YVmUjEMQE4VxJr01Pwt75gcSS/ILd03MewrcUcuvlZYAvjltyIy1DneWWVbd3eJuqDZNPSF+bd0EjwgbQwtlHRUP6pcWsqo0TARfS5PhllCGlVcyv7lVV/j3vv5x+ZQnalC8rbBvMT9WBhonugfgvIiDwsTXw7rLWKAOMKcPhKgfBitx5I/1UIndjEZOH2c8gzhkY1vM1kAQgrnz6KrObjLXobOuRv1K8477rMjehEdLJf5QLtRMaIymcIROyzttvnvD0Qpn8fj348+ab23w1JrNU8f3WM5edU2kTFYJcDobbY9TpCiPibrC+n3cIXE1Rqnl47TcWWlm1z0qQf5QMDjdM9FHDtrzbkpj7ziyeRnSHaTVYaYEbssIOo6FLgSb9P8RJH5g2GiWbRalLAjA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b47e30-eff0-4db5-8cea-08d84b6f6d55
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 16:28:42.5189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SpH8uQHY39ckFMNGEyJgV98QMSUZ9AMf4Z2WG1pCmnob5XnJ0FSy3yUZJ2IjJOkBsqMj8hHQXW/KAY7q0fSKcVMednuKnbF9oxtfDBqFD8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1673
Received-SPF: pass client-ip=40.107.13.104;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 12:28:44
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.809, RCVD_IN_DNSWL_LOW=-0.7,
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

On 24.08.2020 14:30, Vladimir Sementsov-Ogievskiy wrote:
> 24.08.2020 11:31, Andrey Shinkevich wrote:
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
>>   block/stream.c             | 58 
>> +++++++++++++++++++++++++++++++++++-----------
>>   tests/qemu-iotests/030     | 50 
>> ++++-----------------------------------
>>   tests/qemu-iotests/030.out |  4 ++--
>>   tests/qemu-iotests/245     | 19 +++++++++++----
>>   4 files changed, 65 insertions(+), 66 deletions(-)
>>
>> diff --git a/block/stream.c b/block/stream.c
>> index 8bf6b6d..e927fed 100644
>> --- a/block/stream.c
>> +++ b/block/stream.c
...
>> @@ -307,5 +332,10 @@ fail:
>>       if (bs_read_only) {
>>           bdrv_reopen_set_read_only(bs, true, NULL);
>>       }
>> -    bdrv_unfreeze_backing_chain(bs, above_base);
>> +    if () {
>> +        bdrv_unfreeze_backing_chain(cor_filter_bs, above_base);
>> +        bdrv_cor_filter_drop(cor_filter_bs);
>> +    } else {
>> +        bdrv_unfreeze_backing_chain(bs, above_base);
>
> as I see, in this case chain is not yet frozen
>

When cor_filter_bs is NULL, only bs - above_base chain is frozen at this 
point.

Andrey


>> +    }
>>   }
>> diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
>> index 1cdd7e2..fec9d89 100755
>> --- a/tests/qemu-iotests/030
>> +++ b/tests/qemu-iotests/030
...

