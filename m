Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F453C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:35:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A02206D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ju+Gs4Vv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A02206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix86R-0008OI-CV
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 06:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ix81h-0003uh-8k
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:30:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ix81f-0000U8-OO
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:30:24 -0500
Received: from mail-eopbgr10102.outbound.protection.outlook.com
 ([40.107.1.102]:64131 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ix81e-0000RC-Vh; Thu, 30 Jan 2020 06:30:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPNnmtvE2okM+ME6PqP/4kNfQiao6IbdRNlF6yN5/kS0BjfWKiZtfSfUZMFEuMd8N9LcCItbixdgRVWadaP0VPfvzE5BMBHyxZWKiFgZpJ8DDL01k8pEKcK+RnUohyjjBypZv3+IAuAH4KJdRo1PdNKozFmAXGAkGxHUvcEPYRUS6n/51jpGwpRs2L61kp0DICC5kuyHujBJfEVcAdmOx2FqxtYPQU6BeBfOY1PibPA4+zFH3UY1shkB0Di6p+1xG6E+m3H4fC9e/BcTpS5VcB5R2c0khSOiM09ZslJ+JjW0+XMb+vTw4RoVi2s4hi3AFP9e6aaJZucoOp4o21UV0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XB3IARcKiGULo9QrE0qcAobEgodUaYDHqC5dTyDjf0I=;
 b=bDz952ch80WBM+uO0pJ9lQunkorclX1suetvaPJKlWyhKSVbU64C5H/xJtla0J4JGde1Izt83JfS+JFr0tQ+kgFL2ZyVBqHU0lgfRArbCMLIlcNZZWP0NBRmIHUYEXYcBJ8k9hlElX5TWyrxDYdB1B1tYyNjyG1W+Fu33m87YIGCQzOkHABR/n7jRNuM4iM/IHZhvWjFlIiF5o5bLmjoCV9SwDS4o2dNaNPvcZ/Xk6orK1xPa/Ispxqv3lLwKgAndOa8cj1EvvSu5TKLKcpFmWAxMv9LUrdsGRcgHaM0RBAMFZdEhu3NNVaSMti72MehcZ4ktGAS33q+CiG+lVcxvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XB3IARcKiGULo9QrE0qcAobEgodUaYDHqC5dTyDjf0I=;
 b=Ju+Gs4VvVdpWXx37UCjUv2vhkd9ZNM0Wbuk7cEYh+myYvibsCABDOjUqgpS6QRvLZ5tG3Icui8N8yGt1nH9WVQe5Kgu9N9yzQyuUcV/3QzvvaIgAdr+nehktzHL7sKUmqfWsm2zrMs02EPZW8jc3Cgz7vK6waggaQu5iY6cAo0Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5189.eurprd08.prod.outlook.com (10.255.121.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Thu, 30 Jan 2020 11:30:20 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.025; Thu, 30 Jan 2020
 11:30:19 +0000
Subject: Re: request_alignment vs file size, how to fix crash?
To: Kevin Wolf <kwolf@redhat.com>
References: <2ca46523-44a2-1a48-dfa3-11bda9eef8e8@virtuozzo.com>
 <24d1a5f8-1f01-ec64-778d-5bab440714c7@virtuozzo.com>
 <20200130111144.GC6438@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200130143017806
Message-ID: <72b2fae2-dcd6-e2f2-c497-300302559ca4@virtuozzo.com>
Date: Thu, 30 Jan 2020 14:30:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200130111144.GC6438@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0262.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::14) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0262.eurprd05.prod.outlook.com (2603:10a6:3:fc::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27 via Frontend Transport; Thu, 30 Jan 2020 11:30:19 +0000
X-Tagtoolbar-Keys: D20200130143017806
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2ea001f-aa21-42cf-b7ee-08d7a577c988
X-MS-TrafficTypeDiagnostic: AM6PR08MB5189:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB51894765FC9BFE937AD25EB5C1040@AM6PR08MB5189.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(39850400004)(346002)(366004)(136003)(199004)(189003)(5660300002)(6916009)(8676002)(81166006)(81156014)(6486002)(8936002)(52116002)(4326008)(186003)(16526019)(54906003)(31686004)(26005)(16576012)(86362001)(36756003)(2616005)(316002)(31696002)(66946007)(66476007)(2906002)(478600001)(66556008)(956004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5189;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xyKIjKZV2t6LU+Y9JPHEY2EfbXdXyP3AgZOu9y49ycdRKtmGIo8mLYhHHlvD7O+pmDWabQ66iIrZsfGYIipCwMx/qUwjFPfSdDYewOG4JTGwxLs4YHYkHRx6PBabAeV6a7hrWN13AMKYeu0jUi/swsoR+c4S+CB6pG4CTA/YN3BGqcQ/5/y8ZvVAxY7/dg3qK6XxXgrFJIUYTFrh7PnKTI2O9wZ/rgd8A1aXgo3tdL42C0W7FfqB9tIaa93s/Sh4GwBPzzHMnp/covDJrt3pZO11H0PL/ECyy/3IvqvkOag8OPlWx9GNrJgc+99U26Q+u6HnJ+N47d2FPdBCCZuGt4BU0jVtkISglX0cOWJ2QnCar66PO+AgjSAhyBKjzUxO9Qj7xamlf0kXNqZHiyb+rBE/HkAgKYM5klCOFahPQAE9Q1oT++oBj8+qnlGOJM4z
X-MS-Exchange-AntiSpam-MessageData: AyHRo6fRj4JCDXunZUTNQzGO2NklWzCbelDIRoJG87ueNWbrlmmA25fMLZWDUmIaCsDPNmrArlPVgTnPG/RXfBZjBVcMjncXVKW+T9ZDPUHQH12l6TPxaPNSSB7e6Hz1PZU6H833eMAgl9rfmdnaBg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ea001f-aa21-42cf-b7ee-08d7a577c988
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 11:30:19.8015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AznnLwn/XOpEeBG53YX2DxwfrMBeWUYOb4NQHsaEhdvv5npk0lRtkLcOnwzAbUQpslL5i2/Vfoo8MnqZCW0blOlYZXwdBw3XHw18v1R/HJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5189
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.102
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
Cc: Nir Soffer <nsoffer@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

30.01.2020 14:11, Kevin Wolf wrote:
> Am 30.01.2020 um 11:40 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 29.01.2020 21:01, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi!
>>>
>>> I found a crash, which may be simply triggered for images unaligned to request_alignment:
>>>
>>> # ./qemu-io --image-opts -c 'write 0 512' driver=blkdebug,align=4096,image.driver=null-co,image.size=512
>>> qemu-io: block/io.c:1505: bdrv_aligned_pwritev: Assertion `end_sector <= bs->total_sectors || child->perm & BLK_PERM_RESIZE' failed.
>>> Aborted (core dumped)
>>>
>>> The problem is obvious: 512 is aligned to 4096 and becomes larger than file size.
>>>
>>> I faced it after rebasing our downstream branches to newer Rhel versions. Seems that after some updates of alignment detection in file-posix.c, it started to detect 4096 alignment in our build environment, and iotest 152 started to crash (as it operates on file of 512 bytes).
>>>
>>> My question is:
>>>
>>> What is wrong? Should we restrict images to be aligned to request_alignment, or allow unaligned operations at EOF, if file is unaligned itself?
>>>
>>
>>
>> The problem started with commit
>>
>> commit a6b257a08e3d72219f03e461a52152672fec0612
>> Author: Nir Soffer <nirsof@gmail.com>
>> Date:   Tue Aug 13 21:21:03 2019 +0300
>>
>>      file-posix: Handle undetectable alignment
>>
>>
>> It sets request_alignment to 4k, if probing of align=1 succeeded.. I think it's wrong logic. It leads to crashes for images unaligned to 4k.
>>
>> If we force alignment to be 4k, we at least should check that file size is aligned to 4k. Otherwise our assumption is definitely wrong.
>>
>> And still, I doubt that it's correct to force alignment to 4k, for devices which doesn't request any alignment..
> 
> What backend is this? O_DIRECT with byte alignment sounds wrong, so I
> wonder if your storage really can do this or whether we just failed to
> detect the actual alignment.

The problem was disabled odirect in virtuozzo container which lead to byte alignment. So, yes, it's on our part.

> 
> I guess we could change the default to pick the largest size so that the
> image size is still a multiple of it. But if the image size isn't even
> aligned to 512 bytes, I think refusing to open the image with O_DIRECT
> feels more correct (I would be okay with doing the same with > 512 byte
> images, too, if the image size isn't a multiple of the alignment).
> 

OK, I'll think about a patch for file-posix.c, and may be blkdebug too.

Also, we need to check it somewhere in generic layer too, to fail earlier than assertion above.


-- 
Best regards,
Vladimir

