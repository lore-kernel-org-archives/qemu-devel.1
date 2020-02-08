Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768F0C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 12:33:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D4C021775
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 12:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Nt1KOrcA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D4C021775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0PIS-000464-9V
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 07:33:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j0PHX-00035D-4q
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:32:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j0PHU-00083X-Lv
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:32:18 -0500
Received: from mail-eopbgr140139.outbound.protection.outlook.com
 ([40.107.14.139]:51432 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j0PHU-0007f7-Ca; Sat, 08 Feb 2020 07:32:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRj4xuHlPnGORzqfAbPFil16GaoTjFMFsKo2O2m2gxRnITOCq+N15FGfQJJkIwIFeF52cSw7nf2keH7/lfqOHVHExnyW1l35fc/96bWMQkH+4IKG/eJzgwXlVzS3d4VvWjQBPf1uKdsn7T8yZJaVNKC/xBZ5QlY4tOzEXfD4f5rxyaDK39MmedFZNnvsJlv/PiIdsYp0y8xlE5c104UP0ZSBKCYUaAMl7Ma5bpndZfHuFFV45sM7SHF3yd+Ms2W37yK/owhiQ9pjyhAGsfYzmfeV1OBB7G2H9YwabBZwemHM5aD4Yx7iAYtDgLimo4WdYLmAcjWwqEAuX2xaij3qJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHnJRH/wHa4bvSFvg7+wZBMSPmaSywkNovMIDpz6ymQ=;
 b=HSsOp3Pqw3SUriw4bJEmpGV56s4jsnfcN9uuNwo21p6N2s7uofM/nf8ps5xuy9j+UT66sGGSrwPXVdh6Q771lTZr0/YJLhPWFdNT1Wchf5qjMmCZP8fTLLfS8o+okyvZ9IFya32UqpM/KO8idbNa2mJv0HmMFek/WE8jgzAeJFv0xmYDfcja7M29u9GJbI5UI2Bt3MLB79tyTZyx3ASvAdb8K2be+3CkgI2i0wuY11K79oVFlO4GJXtunQC6k6vFFSx+AfpzvbuwmuRPnToIduiabgcLQ9FntxRIHZz6HBq3WY8vyp0cFiOcCrGZYglBdAEJBYg7CV4p8w6vS7D16Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHnJRH/wHa4bvSFvg7+wZBMSPmaSywkNovMIDpz6ymQ=;
 b=Nt1KOrcAJl6aFP9583bg9+QBOfdOHJUQHvVK7t8qlJzW3aPvOrPCKVLXoarbKCCWTgbK5zvOU0zXWwpIT+KsOed+6G9gdcEOukoynTD88BHSMYS1f4Y1Ho7gRRyoLhiNc1brwu5icBQJuK+wf3lwmXEuQob/wh+fEjl+lqBSW/M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4422.eurprd08.prod.outlook.com (20.179.7.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Sat, 8 Feb 2020 12:32:07 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2707.024; Sat, 8 Feb 2020
 12:32:07 +0000
Subject: Re: [PATCH v2 1/7] block/block-copy: specialcase first copy_range
 request
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
 <20191127180840.11937-2-vsementsov@virtuozzo.com>
 <2f3e4122-6ffc-fa3e-7433-c3ef84bdfd31@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200208153205293
Message-ID: <2df0de36-848e-48da-d550-2a4c2a373555@virtuozzo.com>
Date: Sat, 8 Feb 2020 15:32:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <2f3e4122-6ffc-fa3e-7433-c3ef84bdfd31@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0701CA0068.eurprd07.prod.outlook.com
 (2603:10a6:3:64::12) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0701CA0068.eurprd07.prod.outlook.com (2603:10a6:3:64::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.12 via Frontend Transport; Sat, 8 Feb 2020 12:32:07 +0000
X-Tagtoolbar-Keys: D20200208153205293
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5280a50e-e63d-48f3-e040-08d7ac92e946
X-MS-TrafficTypeDiagnostic: AM6PR08MB4422:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4422FBE7DE3237AB264D37A8C11F0@AM6PR08MB4422.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-Forefront-PRVS: 03077579FF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(39840400004)(376002)(396003)(366004)(199004)(189003)(66946007)(66556008)(66476007)(36756003)(5660300002)(4326008)(107886003)(31686004)(6486002)(316002)(16576012)(478600001)(8936002)(81166006)(81156014)(8676002)(31696002)(26005)(53546011)(52116002)(186003)(86362001)(16526019)(956004)(2616005)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4422;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +p3ix72/jBAMsxVBGhRA0Pc682q9h52KsO0b+ZQIE21rIOBN+8TuhB/orPdsrHEkrzBeh0VVPsm6RBwpsJ1gYKDTMV+RmLacUKGoJfrybU5xA8RzZytVMbvEUz/EtEHoq5E/fCLx+7GmEP+qlhJY2VuUTnJUbisJAqPLRthxyc8LN5OMMlZJ0hy3HBuYg7NMPXyLchP40gLEJurDmKWu7Of1vv5iGObwWUDVD4OAIjDLQtbw04HXuVKTsOIytK2tG8sWgm6PKrBT92iCkIEQ5XsocvK2WOIX/P5lyYCGMioQkJ4qUtS3vKM6JGn+OVymB3/aZb1y0p/7o0awOd3Yq8qX1zypEeLUDrDs500yLnKZLj/4joPn8hU5+FKdLWsvCDKjJiw3r1iomnpF82E87QhDiuOjQJNrZJj39+0z4YvsuPcgL81ZDUN6MsE/m0Cs
X-MS-Exchange-AntiSpam-MessageData: d9aopg6E0SrNCnXWgbrXZI3hrMIX9cNOuAanLHKPwOoiDdefXXFSeqz+Mx07WKoyH1Dh/7EvBzjKpDHtX5PAJO+n3fzeNW/F7ZGRW8ULcTVHI4kdCv8M5ETc7Urj/vfO/qFvAK6rorhi4vpWhDD7NA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5280a50e-e63d-48f3-e040-08d7ac92e946
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2020 12:32:07.6222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54KHyEvQd25ul815V3XEb6J6aGoKqCBWzXqgHNnK7rsvwutoKUGAj7/cri1Ji2uDkU8fPaEgOwj36gUVAf1/D3MFrUPlxiYD/N1N8pKNGFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4422
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.14.139
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.02.2020 20:28, Max Reitz wrote:
> On 27.11.19 19:08, Vladimir Sementsov-Ogievskiy wrote:
>> In block_copy_do_copy we fallback to read+write if copy_range failed.
>> In this case copy_size is larger than defined for buffered IO, and
>> there is corresponding commit. Still, backup copies data cluster by
>> cluster, and most of requests are limited to one cluster anyway, so the
>> only source of this one bad-limited request is copy-before-write
>> operation.
>>
>> Further patch will move backup to use block_copy directly, than for
>> cases where copy_range is not supported, first request will be
>> oversized in each backup. It's not good, let's change it now.
>>
>> Fix is simple: just limit first copy_range request like buffer-based
>> request. If it succeed, set larger copy_range limit.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/block-copy.c | 41 ++++++++++++++++++++++++++++++-----------
>>   1 file changed, 30 insertions(+), 11 deletions(-)
>>
>> diff --git a/block/block-copy.c b/block/block-copy.c
>> index 79798a1567..8602e2cae7 100644
>> --- a/block/block-copy.c
>> +++ b/block/block-copy.c
>=20
> [...]
>=20
>> @@ -168,7 +170,21 @@ static int coroutine_fn block_copy_do_copy(BlockCop=
yState *s,
>>               s->use_copy_range =3D false;
>>               s->copy_size =3D MAX(s->cluster_size, BLOCK_COPY_MAX_BUFFE=
R);
>>               /* Fallback to read+write with allocated buffer */
>> -        } else {
>> +        } else if (s->use_copy_range) {
>> +            /*
>> +             * Successful copy-range. Now increase copy_size.
>> +             * copy_range does not respect max_transfer (it's a TODO), =
so we
>> +             * factor that in here.
>> +             *
>> +             * Note: we double-check s->use_copy_range for the case whe=
n
>> +             * parallel block-copy request unset it during previous
>> +             * bdrv_co_copy_range call.
>=20
> But we should still goto out anyway, shouldn=92t we?

Oops yes, will fix.

>=20
>> +             */
>> +            s->copy_size =3D
>> +                    MIN(MAX(s->cluster_size, BLOCK_COPY_MAX_COPY_RANGE)=
,
>> +                        QEMU_ALIGN_DOWN(block_copy_max_transfer(s->sour=
ce,
>> +                                                                s->targ=
et),
>> +                                        s->cluster_size));
>>               goto out;
>>           }
>>       }
>> @@ -176,7 +192,10 @@ static int coroutine_fn block_copy_do_copy(BlockCop=
yState *s,
>>       /*
>>        * In case of failed copy_range request above, we may proceed with=
 buffered
>>        * request larger than BLOCK_COPY_MAX_BUFFER. Still, further reque=
sts will
>> -     * be properly limited, so don't care too much.
>> +     * be properly limited, so don't care too much. Moreover the most p=
ossible
>=20
> s/possible/likely/
>=20
> Max
>=20
>> +     * case (copy_range is unsupported for the configuration, so the ve=
ry first
>> +     * copy_range request fails) is handled by setting large copy_size =
only
>> +     * after first successful copy_range.
>>        */
>>  =20
>>       bounce_buffer =3D qemu_blockalign(s->source->bs, nbytes);
>>
>=20
>=20


--=20
Best regards,
Vladimir

