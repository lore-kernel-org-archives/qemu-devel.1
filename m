Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D55C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1157F20838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JhYFTrHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1157F20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j06ra-00065o-7N
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 11:52:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j06qh-0004x6-Gb
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:51:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j06qe-00074s-Lt
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:51:23 -0500
Received: from mail-eopbgr10138.outbound.protection.outlook.com
 ([40.107.1.138]:55005 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j06qd-00072w-2l; Fri, 07 Feb 2020 11:51:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=konz1Tiw/orJZjpd+cAFYY5iA/+ooK5M58WFHYVsmxvjHcvQu4FO8EawNUZFnZYkYKBxaLWfrVgmYMA+YQ3XO/1p0+PvM4eK269PPmk4T6FKSnCfUNhTAYzUs4oIU1Hx5SO3ujpEm/qDGb4j7jyh5FPHqhD6UQwG+1Rngtweb60/9s7yoU94TyM+vqNe/Ci7hDV79wDRDlDvJISfuDbKZywOG1MuoO7qdQB8gQ3KsM6QHV53YW9PlOtmZYCGsgBftD5qmWSpltTedxYWUEQi1A4eXRPr28pwJJXlOslkXn5H3chfYMhEStsCTUdTenzLFH0bbhkHfCKT9h5lFM6pEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjgVBWbfKHgtsVbe4E6r0KQVibKPyGlwJfX0G8TO/fg=;
 b=XBsn33RN+/z5vMMthgeUldDIYxBvsLEn3SkntDpk5MqtcOCll5FOI9ud/Q0QJ8kocIVcxkGrukBldmBHLHRiNYuhZJ531UEpuQiQI9QGQKBfZ2ebuqpbfR7I5EDu2uOEFR5CgXJD4Q3cf80m+mH6iqnjdl32J97sDJjxVdxlQLmHHU6czUuI9UQKqiwvh62WClCTGQb+vjMZSTzRREsxc2PDujBI7jvq3K9jaMMc4sEbBvTXxeF/5XpQJvbJjQcCg2ltxwepRt/VfcnXLDxbX7luvb1A5yGUTp/10AIRbigtgOcl8YJE7Z2SK3u5Tvwn9yCpoGYM1mfOTpE81iVsOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjgVBWbfKHgtsVbe4E6r0KQVibKPyGlwJfX0G8TO/fg=;
 b=JhYFTrHHRgoARNulSei8LMgxPGYQrwB3aGi1zJSMFlUdX6JRHm2QuWyeYBIB/vwdWxL7VhFX172wPDx4rgUn2GK8p2TYpCcHx1NWQCz8Ecg8KzS7MwSjaX+9CCXvmjC9/AGWZUNb5A/YC3sMMpS47Zs4g+yiNzjFvJrhf8BfifE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5013.eurprd08.prod.outlook.com (10.255.123.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Fri, 7 Feb 2020 16:51:15 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2707.023; Fri, 7 Feb 2020
 16:51:15 +0000
Subject: Re: [PATCH] block: fix crash on zero-length unaligned write and read
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20200206164245.17781-1-vsementsov@virtuozzo.com>
 <20200207164713.GJ168381@stefanha-x1.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200207195113587
Message-ID: <0fb52a5a-207c-ea3b-72c5-52b469064ad4@virtuozzo.com>
Date: Fri, 7 Feb 2020 19:51:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200207164713.GJ168381@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0901CA0050.eurprd09.prod.outlook.com
 (2603:10a6:3:45::18) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0901CA0050.eurprd09.prod.outlook.com (2603:10a6:3:45::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Fri, 7 Feb 2020 16:51:15 +0000
X-Tagtoolbar-Keys: D20200207195113587
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65de93e2-b131-4cf5-0fa6-08d7abedf241
X-MS-TrafficTypeDiagnostic: AM6PR08MB5013:
X-Microsoft-Antispam-PRVS: <AM6PR08MB501334C4B2CD37E87DA892C1C11C0@AM6PR08MB5013.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(39850400004)(366004)(346002)(136003)(189003)(199004)(2616005)(4326008)(52116002)(66476007)(66556008)(31686004)(16576012)(956004)(5660300002)(66946007)(2906002)(16526019)(6486002)(186003)(316002)(31696002)(26005)(6916009)(478600001)(86362001)(8676002)(966005)(81156014)(81166006)(8936002)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5013;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OHg0flNnVQv1FpBBmu4lz9zEHMaBtfugoh8S84uNTf4Y21eKQy9RYxXjQ7z8DaVW7atby7WpwUhJHC8+a3r8YCNoY4HK0vODGpHEmpXhmnr9j2hmxEyd212fGXWqfPv/DvJx73cEuB1zwqlTL1BryfayV2UkogKBRYciw64hQm1JAQZqdGxDCB4vzMZHGw0lVC6U27OZ+GZquiLbFpO+RlV5hZXdUBRcZQ2DVuKcKIyvVIa8bJ4Wa5+a58u5/2Etii12PdizZAk6LC64kC1PVt70dY54nQh/EwiDw/GqQIYRXYUemaUUMx9hHmYPylhOceQMLthrRUsKKX5Rs3l96T++XECQws8cRLj1fi87LlTGxra3ZCstIp9nFl4KKddHSp634N5aGxa4R0ExpCft53Pv9ErJoRD3M6QvucCJxUckox0jybuJzbHsnJv25xQ+VIA9MnTZfEH3UYTtUhGOi5T47eZPgIYvri8uReu4iZRqvjx8zEIkSruWEt7P7wGYljqdESqVhoiqKGb9No6kog==
X-MS-Exchange-AntiSpam-MessageData: asv8QcRRcfUeDxFMrtxtpxv36qzIK+SHERgjb0BR6YmjYYQtTCXhW9IgPStq2Pd89hj1iXtYghOwZA4u2ZuTzmFDrRFH6AK5NCO+5qhTFJj5zxSwnx5nHAQyv1rPR0FNm4NU5a8/iiiPYN++OKRTgg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65de93e2-b131-4cf5-0fa6-08d7abedf241
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 16:51:15.7092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VghyoeavpsJAG40lEjnwP1bEM5cRFFSB8933JNjbk5RNQts89dNr/8/PiVW3s56FV5qRzbQqYaAMPRnTNW9cPVpIaH9kEILcmFlWPqYgcBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5013
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.138
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.02.2020 19:47, Stefan Hajnoczi wrote:
> On Thu, Feb 06, 2020 at 07:42:45PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Commit 7a3f542fbd "block/io: refactor padding" occasionally dropped
>> aligning for zero-length request: bdrv_init_padding() blindly return
>> false if bytes == 0, like there is nothing to align.
>>
>> This leads the following command to crash:
>>
>> ./qemu-io --image-opts -c 'write 1 0' \
>>    driver=blkdebug,align=512,image.driver=null-co,image.size=512
>>
>>>> qemu-io: block/io.c:1955: bdrv_aligned_pwritev: Assertion
>>      `(offset & (align - 1)) == 0' failed.
>>>> Aborted (core dumped)
>>
>> Prior to 7a3f542fbd we does aligning of such zero requests. Instead of
>> recovering this behavior let's just do nothing on such requests as it
>> is useless.
>>
>> Note that driver may have special meaning of zero-length reqeusts, like
>> qcow2_co_pwritev_compressed_part, so we can't skip any zero-length
>> operation. But for unaligned ones, we can't pass it to driver anyway.
>>
>> This commit also fixes crash in iotest 80 running with -nocache:
>>
>> ./check -nocache -qcow2 80
>>
>> which crashes on same assertion due to trying to read empty extra data
>> in qcow2_do_read_snapshots().
>>
>> Cc: qemu-stable@nongnu.org # v4.2
>> Fixes: 7a3f542fbd
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/io.c | 28 +++++++++++++++++++++++++++-
>>   1 file changed, 27 insertions(+), 1 deletion(-)
> 
> Thanks, applied to my block tree:
> https://github.com/stefanha/qemu/commits/block
> 

Thanks!


-- 
Best regards,
Vladimir

