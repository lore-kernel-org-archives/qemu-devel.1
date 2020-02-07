Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24758C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:48:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57D821741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="v8HXZVal"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57D821741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j06o7-0001m7-5N
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 11:48:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j06mk-0008Kt-Kt
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:47:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j06mi-00020x-Sy
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:47:17 -0500
Received: from mail-db8eur05on2135.outbound.protection.outlook.com
 ([40.107.20.135]:3809 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j06mi-0001rd-3n; Fri, 07 Feb 2020 11:47:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkuHUT4EdM7HA6ww4QdY6PzwWv46BlhHeKnozf0I3ye9NOo1z0OtiNfa5htsfhFTddfa/niG/CHlv2+TkTn/pskne4yqEpAy4uu0DSyC9xFKb+GsstqrVSo134wPCS0vFx510ewgdrotSkvwAJ2bOt7jfAJtGoYEFjoFjrup78DBGkmBfKsPBqbj6ND7AamTjF7+jOMkdZqJj1k8qDVTOp/V0TWBR6pHmxY9yDpS+3LIuyhp68AeGapvXNdA83SsXnTNsxBlWcN7CNbu3Iu/HJPX46kV1g9Ml9YDgpUxaWCVFZA6bVW7fxVXKyks2/SwS3Z8Uj20syWHIKfJYASL7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rT9/1UHBVMzobEUB5KL90BQ8lpK5mVz/3sQWwNFnow=;
 b=Sq7uoQStWcAzps2s7zY+EaKckaKydiSK0wjYjrcZaR3aYD8yx3f9Lx73bpcHZ4TI1HRU9rmtAsAhN0HWwSJOHmdJTfhDcyQtLuibgMoywfHVicKRztzL5k29mAaXygl1YwxMrrTKQ/WE+6qaMH7nyCq5j787OElFPmG1apKQPSqM9IIK780bluEzJLWO/0d4KMHmMZx45VIgeBwiJgbLxCRmWeWemSUyDLzOlgAt2SEdsLD8mtbODUZKjdUoP1TpCCg5+en5J/KSiVeh+Phf1Wpfq6QW1wfOBdFAyow37kaIMoGe0FD2gSo4uUBBebOOI8+eh0cyZAUPtfF4NnKhsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rT9/1UHBVMzobEUB5KL90BQ8lpK5mVz/3sQWwNFnow=;
 b=v8HXZVala5dMPaYsC8weFVjCks3QdCOTG3oFV6meJp0HJHbWP+CDohkWRltvVaqEZx3UGnpourdFSQYypBm+NwapYVlYJCGhZ8Ua558rbcQ+IkDiY/M1e7h7gEVCEGpS+CEX3FCk7WXkZVQWH9WJdEQOb7xA9+InxVpDEU+TzCU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5013.eurprd08.prod.outlook.com (10.255.123.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Fri, 7 Feb 2020 16:47:13 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2707.023; Fri, 7 Feb 2020
 16:47:13 +0000
Subject: Re: [PATCH v3] block/backup-top: fix flags handling
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200207161231.32707-1-vsementsov@virtuozzo.com>
 <7b775d8f-a4b9-3376-1744-7cac2a792dba@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200207194711218
Message-ID: <6ed4743e-e309-2f87-37f5-c313e677bd04@virtuozzo.com>
Date: Fri, 7 Feb 2020 19:47:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <7b775d8f-a4b9-3376-1744-7cac2a792dba@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0501CA0036.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::46) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0501CA0036.eurprd05.prod.outlook.com (2603:10a6:3:1a::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Fri, 7 Feb 2020 16:47:12 +0000
X-Tagtoolbar-Keys: D20200207194711218
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a4ca0d8-6dfd-4f25-76ce-08d7abed61ad
X-MS-TrafficTypeDiagnostic: AM6PR08MB5013:
X-Microsoft-Antispam-PRVS: <AM6PR08MB50130B525A2FE69D9717600CC11C0@AM6PR08MB5013.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(39850400004)(366004)(346002)(136003)(189003)(199004)(2616005)(4326008)(52116002)(66476007)(66556008)(31686004)(16576012)(956004)(5660300002)(66946007)(2906002)(16526019)(53546011)(6486002)(186003)(316002)(31696002)(26005)(478600001)(86362001)(8676002)(966005)(81156014)(81166006)(8936002)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5013;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2yBO74gUckuvkqYlZ+oQ+bEskuNBLMaLCWEfyJN1/e1tMcv9S0ikg3j4OI7+GaiWJYAcEKLrcNSZtY/qd0apegsjsHlpbAQ88kPsqM7wmn97eTISwVz8I7+sEHgTtg7UnPdpL5I+Tjew742PLvOzI7kw8RKi3tzMXxTGLqXd6HEgnjtjiF9zr61jNUPJWiPwLS2fL5HpRva+nQIIn/VBSWXcGzLoI9e0hTEQyrz5Nr3WU3gia+WvdwMkQtm9Vddi2OBIO3MmQ/aRAldWm4fB+zL0tLsLScyj3NhF4KD1haeFNlysngZjuVPdA8Z9qWup/Wm+JIR0x3BEgwrpaDHll++OAXKQloZmYmOlBwIpLUSabpHXv7paiy4d6AuGqvVs8qeEuRGUv5493mMzEgYJdAGSWDESdymap2lbSQoPZYy5z2hdKAsUQrMrDC+yBacK8lLm4pUG89vt1VXJpkPJOQb5p9dRxE/Z8RB2QDMnop6GHJE0ZL1iMCI1UlafwbsFXW7nWynn9DuQg3O71ndurg==
X-MS-Exchange-AntiSpam-MessageData: VxOVGCEFcX/Ncyyakq1FHXIZ77cIc0COf1nchAacQLKT31wLNpC8mLjVt1D2XVIRJVhM2ecDfSskfR0DUIRGvNRu4EaiXZdpysm9GOnvokLaBc0R87s6gQTYD8gG0RFJtGY3S4U8EI3c8cu/b7t0pw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4ca0d8-6dfd-4f25-76ce-08d7abed61ad
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 16:47:13.1710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zuH3k6giFC5BPZISb02scaNIuXE8hKfX2VxuER9JHaLb+96gpomsgwQnCddoOhYrZw2le8rB7yxvS/WHeF7tRSfSjCdAHneEvYrclPbGc2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5013
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.20.135
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.02.2020 19:30, Max Reitz wrote:
> On 07.02.20 17:12, Vladimir Sementsov-Ogievskiy wrote:
>> backup-top "supports" write-unchanged, by skipping CBW operation in
>> backup_top_co_pwritev. But it forgets to do the same in
>> backup_top_co_pwrite_zeroes, as well as declare support for
>> BDRV_REQ_WRITE_UNCHANGED.
>>
>> Fix this, and, while being here, declare also support for flags
>> supported by source child.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>
>> v3: rebase on master, keep state initialization after check top != NULL.
>>
>> v2: restrict flags propagation like it is done in other filters [Eric]
>>      move state variable initialization to the top
>>   block/backup-top.c | 31 ++++++++++++++++++++-----------
>>   1 file changed, 20 insertions(+), 11 deletions(-)
>>
>> diff --git a/block/backup-top.c b/block/backup-top.c
>> index fa78f3256d..1bfb360bd3 100644
>> --- a/block/backup-top.c
>> +++ b/block/backup-top.c
> 
> [...]
> 
>> @@ -196,8 +200,13 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
>>           return NULL;
>>       }
>>   
>> -    top->total_sectors = source->total_sectors;
>>       state = top->opaque;
>> +    top->total_sectors = source->total_sectors;
> 
> This looks a bit accidental, but, well, whatever.

I failed to restrict myself in a wish to keep all "top->.. =" initializers went together :)
Hmm, I could "state =" intializer to go after them. But it's good to keep it at top too.

> 
> Thanks, applied to my block branch:
> 
> https://git.xanclic.moe/XanClic/qemu/commits/branch/block
> 


Thanks!


-- 
Best regards,
Vladimir

