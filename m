Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB34BC54FFB
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:12:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A3F524691
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="lDDaVyVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3F524691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7JuB-0003oC-MU
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:12:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j7JtF-0002nN-3e
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:11:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j7JtC-0006rx-Ht
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:11:49 -0500
Received: from mail-he1eur02on0710.outbound.protection.outlook.com
 ([2a01:111:f400:fe05::710]:50838
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j7Jt5-0006nE-MY; Thu, 27 Feb 2020 09:11:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDU9ZghICdOT5DYeT9W6ntJdx43Fo85+aqTC+faFimhScCyAxp6B5UTu70rTBrEa/45yyxeqOJ4J7NA/VNToifKWUARlue2nUHtzLkSvdAD/8Pmf9c3sF0XQ5cmcbIwGvmKhaSCe+Fr2gXHkKaUVl/NRsYybyzBVo5j10YHNSrGijfpRUXh81uUuc34rtEWkzrQ6oQNIzLqE+bUkeR+vlHxjRnrIdGBXypeIa1t/yZHUSnujT2t4NUs8RvPVXMaVWYEs4zfF4qQt+ZlUBewtLN/5PR8/Qx0QcrhK92eke4naf2XxiJ1W5zPDUHRusLv/6uG/Nr2peTSq28YjwcmBww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtTFW/zphx6EdS+LG/AuIo72icSd3MncHq31WrhP5Gg=;
 b=Flkjv+fOdP0UtzPGjNHk5n3qD4pgnzYzlbTmp6dl0Y9A+ImEXEMPxLbNe6nHscCkunQPz7EQTDZOTO09dFizNGrdZU1JdO6QL+VNQGEGIxL7Pf/i3HFHiwA6HaUR29ymS0oZ3d6NY4QGfajqHs78UV0XkVAQuV69FqThurpEq1ig5NMW88HC53zQg0wA/78W622/FVVdPngJ7o2tBGDhX+BYFgMgKPIODsl11Ua1CEQUK7D2w2otrsKEGBSgshMSTvPvjwrVi4Hlk9m89E1i0ag7ZB2k71UPABPaSrVvfbCgUsHl202N+Bq/01a2zuLdeZdG4QpP8NcBzx5qpwVLxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtTFW/zphx6EdS+LG/AuIo72icSd3MncHq31WrhP5Gg=;
 b=lDDaVyVMbbY9JtuGf4K7Ju56JaU8D627SWEeZHcC+n/Eqa8amTJ06Efoq/KKedk2JZMFZ52tBbKK3OmfRTA68IJpGqIPk7TYdxVpBdq7HYIZEmea9EKGV3+mLRhON7GGYKnLnUaHJtIyESNABT1QzF68LBhbRT7msD/Xbx1Gc1s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3873.eurprd08.prod.outlook.com (20.178.83.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Thu, 27 Feb 2020 14:11:36 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219%4]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 14:11:36 +0000
Subject: Re: [PATCH v1 3/8] qcow2: add zstd cluster compression
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
 <20200227072953.25445-4-dplotnikov@virtuozzo.com>
 <d1486527-8469-18f3-20ba-969a8232aafb@virtuozzo.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <583362b9-76df-089c-8c1b-0b2fbda7533c@virtuozzo.com>
Date: Thu, 27 Feb 2020 17:11:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <d1486527-8469-18f3-20ba-969a8232aafb@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: HE1PR06CA0156.eurprd06.prod.outlook.com
 (2603:10a6:7:16::43) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.150.20) by
 HE1PR06CA0156.eurprd06.prod.outlook.com (2603:10a6:7:16::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Thu, 27 Feb 2020 14:11:35 +0000
X-Originating-IP: [178.34.150.20]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa5e6746-eb25-46ea-dade-08d7bb8ef4d2
X-MS-TrafficTypeDiagnostic: AM0PR08MB3873:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB3873387013A391E883E2BD95CFEB0@AM0PR08MB3873.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(136003)(366004)(396003)(39850400004)(189003)(199004)(81166006)(2616005)(956004)(26005)(186003)(66476007)(66556008)(31686004)(16526019)(5660300002)(86362001)(19273905006)(81156014)(478600001)(8936002)(31696002)(36756003)(8676002)(316002)(6486002)(16576012)(52116002)(53546011)(2906002)(30864003)(66946007)(4326008)(563064011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3873;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v8+i/zQU6kzuPSllLJ1Sgo5R6tI3PlOH7UfDfZZSeyG6LRbsHbEeIgzWJIu3lmplxg24A/KjPzOp/lKvKnSYylb6kXsXGGRfcdD2wQLAx6ZIN26+sDzWMO3DezAkLnw+GJTOqeSYaQQlZhTXxkk9sz7ho44N2bKbf6acpIn6gNQaoMcBYNSI3ccBD11QrZHkNw9R0Y2rpPH+sI8bPSILkTzRI3+BUHlkHOgUeXcHFGjbEAe6vZeYq9AQf7cv7i8wwmGfYzSzIkyPkdsO8fu+4dPq2mkNJ7cZ3btBm/yZeokjv8QPEFG121QRgZe4zWifWpVQwX2zZ7qLn68XxFlG0XX+52zJ0160FRbDuhcp4OR47n5WX/O14WQHOHFHNw188PEde3kui+OXO3krEhGEqSXR/YwYho33SkcxOhBF2Z9u+hp4D8Alj5dB77yg3c5aKb2UgnUrLZ6vy24m0ArNGt60gm+a1TLfjC1DbwfXUIlAsE3QwTPXK/zvpFs7efff2p43+8IYGZMfHfTH1RCeu9KOnIouXXZOFpi8NydaH+i7kSH7FeZH9dBEXzMcKF39
X-MS-Exchange-AntiSpam-MessageData: oz9MMsouivsH2HD3ZSTCeQQzEaI4s/MSmn6/Voodc5pHjE6JrSjv8R0zvLHy0/FcWBJGQb7Hy3yhbxCNd5k/8rF9O6aK/KEJSRRa2fYQnOy3D4Rpk/wNq81lIJGtopxdBvD+ASbqp+yszA0jFyz38g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5e6746-eb25-46ea-dade-08d7bb8ef4d2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 14:11:36.5512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4P9iY5iV7GxM9iyrBr2vwIvGMoMvOJ1f3NkPNG0AmjtPsG3lz2ZJLHNJozpf32g6Na6VEZse6d2J2fEpV0Qd3Ok8qAsUjFuRV6QyWLd9m0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3873
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe05::710
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, den@vrtuozzo.com,
 armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 27.02.2020 12:55, Vladimir Sementsov-Ogievskiy wrote:
> 27.02.2020 10:29, Denis Plotnikov wrote:
>> zstd significantly reduces cluster compression time.
>> It provides better compression performance maintaining
>> the same level of the compression ratio in comparison with
>> zlib, which, at the moment, is the only compression
>> method available.
>>
>> The performance test results:
>> Test compresses and decompresses qemu qcow2 image with just
>> installed rhel-7.6 guest.
>> Image cluster size: 64K. Image on disk size: 2.2G
>>
>> The test was conducted with brd disk to reduce the influence
>> of disk subsystem to the test results.
>> The results is given in seconds.
>>
>> compress cmd:
>> =C2=A0=C2=A0 time ./qemu-img convert -O qcow2 -c -o compression_type=3D[=
zlib|zstd]
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 src.img [zlib|zstd]_compressed.img
>> decompress cmd
>> =C2=A0=C2=A0 time ./qemu-img convert -O qcow2
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [zlib|zstd]_compressed.img uncompresse=
d.img
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compr=
ession=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 decompression
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zlib=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 zstd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 zlib=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zstd
>> ------------------------------------------------------------
>> real=C2=A0=C2=A0=C2=A0=C2=A0 65.5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16=
.3 (-75 %)=C2=A0=C2=A0=C2=A0 1.9=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 1.6 (-16 %)
>> user=C2=A0=C2=A0=C2=A0=C2=A0 65.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15=
.8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.3=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.5
>> sys=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.3=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0.2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 2.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.0
>>
>> Both ZLIB and ZSTD gave the same compression ratio: 1.57
>> compressed image size in both cases: 1.4G
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> ---
>> =C2=A0 block/qcow2-threads.c=C2=A0 | 122 +++++++++++++++++++++++++++++++=
++++++++++
>> =C2=A0 block/qcow2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 7 +++
>> =C2=A0 configure=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 29 ++++++++++
>> =C2=A0 docs/interop/qcow2.txt |=C2=A0 18 ++++++
>> =C2=A0 qapi/block-core.json=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
>> =C2=A0 5 files changed, 178 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
>> index 1c128e9840..e942c4d7e5 100644
>> --- a/block/qcow2-threads.c
>> +++ b/block/qcow2-threads.c
>> @@ -28,6 +28,11 @@
>> =C2=A0 #define ZLIB_CONST
>> =C2=A0 #include <zlib.h>
>> =C2=A0 +#ifdef CONFIG_ZSTD
>> +#include <zstd.h>
>> +#include <zstd_errors.h>
>> +#endif
>> +
>> =C2=A0 #include "qcow2.h"
>> =C2=A0 #include "block/thread-pool.h"
>> =C2=A0 #include "crypto.h"
>> @@ -164,6 +169,113 @@ static ssize_t qcow2_zlib_decompress(void=20
>> *dest, size_t dest_size,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>> =C2=A0 +#ifdef CONFIG_ZSTD
>> +
>> +#define ZSTD_LEN_BUF 4
>> +
>> +/*
>> + * qcow2_zstd_compress()
>> + *
>> + * Compress @src_size bytes of data using zstd compression method
>> + *
>> + * @dest - destination buffer, @dest_size bytes
>> + * @src - source buffer, @src_size bytes
>> + *
>> + * Returns: compressed size on success
>
> This doesn't match qcow2_co_compress definition. You should return 0=20
> on success.
does it? I'd rather say it doesn't match to qcow2_co_compress=20
description in the function comment, which we can change actually,
because qcow2_co_compress is used like:

block/qcow2.c:

static coroutine_fn int
qcow2_co_pwritev_compressed_task(BlockDriverState *bs,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t offset, uint64_t byt=
es,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMUIOVector *qiov, size_t qi=
ov_offset)
{
 =C2=A0=C2=A0=C2=A0 ...
 =C2=A0=C2=A0=C2=A0 out_buf =3D g_malloc(s->cluster_size);

 =C2=A0=C2=A0=C2=A0 out_len =3D qcow2_co_compress(bs, out_buf, s->cluster_s=
ize - 1,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf, s->cluster_size);
 =C2=A0=C2=A0=C2=A0 if (out_len =3D=3D -ENOMEM) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* could not compress: write no=
rmal cluster */
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D qcow2_co_pwritev_part(b=
s, offset, bytes, qiov,=20
qiov_offset, 0);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fa=
il;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto success;
 =C2=A0=C2=A0=C2=A0 } else if (out_len < 0) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
 =C2=A0=C2=A0=C2=A0 }

 =C2=A0=C2=A0=C2=A0 qemu_co_mutex_lock(&s->lock);
 =C2=A0=C2=A0=C2=A0 ret =3D qcow2_alloc_compressed_cluster_offset(bs, offse=
t, out_len,=20
<<<<<<<<<<<<
&cluster_offset);
 =C2=A0=C2=A0=C2=A0 ...
}

>
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -ENOMEM destin=
ation buffer is not enough to store=20
>> compressed data
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -EIO=C2=A0=C2=
=A0=C2=A0 on any other error
>> + */
>> +
>> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const void *sr=
c, size_t src_size)
>> +{
>> +=C2=A0=C2=A0=C2=A0 size_t ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * steal ZSTD_LEN_BUF bytes in the very beginng=
 of the buffer
>
> beginning
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * to store compressed chunk size
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 char *d_buf =3D ((char *) dest) + ZSTD_LEN_BUF;
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * sanity check that we can store the compresse=
d data length,
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * and there is some space left for the compres=
sor buffer
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (dest_size <=3D ZSTD_LEN_BUF) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 dest_size -=3D ZSTD_LEN_BUF;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D ZSTD_compress(d_buf, dest_size, src, src_siz=
e, 5);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (ZSTD_isError(ret)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ZSTD_getErrorCode(ret) =
=3D=3D ZSTD_error_dstSize_tooSmall) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn -ENOMEM;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn -EIO;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 /* paraniod sanity check that we can store the commp=
ressed size */
>> +=C2=A0=C2=A0=C2=A0 if (ret > UINT_MAX) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> +=C2=A0=C2=A0=C2=A0 }
>
> I'd use UINT32_MAX, possibly even more paranoid)
ok
>
>
>> +
>> +=C2=A0=C2=A0=C2=A0 /* store the compressed chunk size in the very begin=
ning of the=20
>> buffer */
>> +=C2=A0=C2=A0=C2=A0 stl_be_p(dest, ret);
>> +
>> +=C2=A0=C2=A0=C2=A0 return ret + ZSTD_LEN_BUF;
>
> return 0;
>
>> +}
>> +
>> +/*
>> + * qcow2_zstd_decompress()
>> + *
>> + * Decompress some data (not more than @src_size bytes) to produce=20
>> exactly
>> + * @dest_size bytes using zstd compression method
>> + *
>> + * @dest - destination buffer, @dest_size bytes
>> + * @src - source buffer, @src_size bytes
>> + *
>> + * Returns: 0 on success
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -EIO on any er=
ror
>> + */
>> +
>
> extra empty line.
will be removed
>
>
>> +static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
nst void *src, size_t src_size)
>> +{
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * zstd decompress wants to know the exact leng=
th of the data.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * For that purpose, on compression, the length=
 is stored in
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * the very beginning of the compressed buffer
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 size_t s_size;
>> +=C2=A0=C2=A0=C2=A0 const char *s_buf =3D ((const char *) src) + ZSTD_LE=
N_BUF;
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * sanity check that we can read 4 byte the con=
tent length and
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * and there is some content to decompress
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (src_size <=3D ZSTD_LEN_BUF) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 s_size =3D ldl_be_p(src);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* sanity check that the buffer is big enough to rea=
d the=20
>> content from */
>> +=C2=A0=C2=A0=C2=A0 if (src_size - ZSTD_LEN_BUF < s_size) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (ZSTD_isError(
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ZSTD=
_decompress(dest, dest_size, s_buf, s_size))) {
>
> hmm, it fit into one line actually
will be fixed if so
>
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +#endif
>> +
>> =C2=A0 static int qcow2_compress_pool_func(void *opaque)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Qcow2CompressData *data =3D opaque;
>> @@ -215,6 +327,11 @@ qcow2_co_compress(BlockDriverState *bs, void=20
>> *dest, size_t dest_size,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn =3D qcow2_zlib=
_compress;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0 +#ifdef CONFIG_ZSTD
>> +=C2=A0=C2=A0=C2=A0 case QCOW2_COMPRESSION_TYPE_ZSTD:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn =3D qcow2_zstd_compress;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +#endif
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOTSUP;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -247,6 +364,11 @@ qcow2_co_decompress(BlockDriverState *bs, void=20
>> *dest, size_t dest_size,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn =3D qcow2_zlib=
_decompress;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0 +#ifdef CONFIG_ZSTD
>> +=C2=A0=C2=A0=C2=A0 case QCOW2_COMPRESSION_TYPE_ZSTD:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn =3D qcow2_zstd_decompress=
;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +#endif
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOTSUP;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 2ccb2cabd1..9c8ad9d580 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -1257,6 +1257,9 @@ static int=20
>> validate_compression_type(BDRVQcow2State *s, Error **errp)
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (s->compression_type) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case QCOW2_COMPRESSION_TYPE_ZLIB:
>> +#ifdef CONFIG_ZSTD
>> +=C2=A0=C2=A0=C2=A0 case QCOW2_COMPRESSION_TYPE_ZSTD:
>> +#endif
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>> @@ -3506,6 +3509,10 @@ qcow2_co_create(BlockdevCreateOptions=20
>> *create_options, Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (qc=
ow2_opts->compression_type) {
>> +#ifdef CONFIG_ZSTD
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case QCOW2_COMPRESSION_TYPE_=
ZSTD:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>> +#endif
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 error_setg_errno(errp, -EINVAL, "Unknown compression=20
>> type");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto out;
>> diff --git a/configure b/configure
>> index 48d6f89d57..4690a7ea9f 100755
>> --- a/configure
>> +++ b/configure
>> @@ -444,6 +444,7 @@ opengl_dmabuf=3D"no"
>> =C2=A0 cpuid_h=3D"no"
>> =C2=A0 avx2_opt=3D""
>> =C2=A0 zlib=3D"yes"
>> +zstd=3D""
>> =C2=A0 capstone=3D""
>> =C2=A0 lzo=3D""
>> =C2=A0 snappy=3D""
>> @@ -1371,6 +1372,10 @@ for opt do
>> =C2=A0=C2=A0=C2=A0 ;;
>> =C2=A0=C2=A0=C2=A0 --disable-lzfse) lzfse=3D"no"
>> =C2=A0=C2=A0=C2=A0 ;;
>> +=C2=A0 --enable-zstd) zstd=3D"yes"
>> +=C2=A0 ;;
>> +=C2=A0 --disable-zstd) zstd=3D"no"
>> +=C2=A0 ;;
>> =C2=A0=C2=A0=C2=A0 --enable-guest-agent) guest_agent=3D"yes"
>> =C2=A0=C2=A0=C2=A0 ;;
>> =C2=A0=C2=A0=C2=A0 --disable-guest-agent) guest_agent=3D"no"
>> @@ -1829,6 +1834,7 @@ disabled with --disable-FEATURE, default is=20
>> enabled if available:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (for reading bzip2-compressed dm=
g images)
>> =C2=A0=C2=A0=C2=A0 lzfse=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 support of lzfse compression library
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (for reading lzfse-compressed dm=
g images)
>> +=C2=A0 zstd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 support of zstd compression library
>> =C2=A0=C2=A0=C2=A0 seccomp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 seccomp support
>> =C2=A0=C2=A0=C2=A0 coroutine-pool=C2=A0 coroutine freelist (better perfo=
rmance)
>> =C2=A0=C2=A0=C2=A0 glusterfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Gluster=
FS backend
>> @@ -2453,6 +2459,25 @@ EOF
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> =C2=A0 fi
>> =C2=A0 +#########################################
>> +# zstd check
>> +
>> +if test "$zstd" !=3D "no" ; then
>> +=C2=A0=C2=A0=C2=A0 cat > $TMPC << EOF
>> +#include <zstd.h>
>> +int main(void) { ZSTD_versionNumber(); return 0; }
>> +EOF
>> +=C2=A0=C2=A0=C2=A0 if compile_prog "" "-lzstd" ; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LIBS=3D"$LIBS -lzstd"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zstd=3D"yes"
>> +=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if test "$zstd" =3D "yes"; t=
hen
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 feat=
ure_not_found "zstd" "Install libzstd-devel"
>
> to correspond to style used around: s/libzstd-devel/libzstd devel/
My intention was to give a package name for a user encountered this=20
message to copy-paste it to "yum install".
If this doesn't make things easier, because the package name can be=20
changed in the future (although I doubt) I'll fix it.
If the style isn't that important I'd rather leave it as is.
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zstd=3D"no"
>> +=C2=A0=C2=A0=C2=A0 fi
>> +fi
>> +
>> =C2=A0 ##########################################
>> =C2=A0 # libseccomp check
>> =C2=A0 @@ -6668,6 +6693,7 @@ echo "lzo support=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 $lzo"
>> =C2=A0 echo "snappy support=C2=A0=C2=A0=C2=A0 $snappy"
>> =C2=A0 echo "bzip2 support=C2=A0=C2=A0=C2=A0=C2=A0 $bzip2"
>> =C2=A0 echo "lzfse support=C2=A0=C2=A0=C2=A0=C2=A0 $lzfse"
>> +echo "zstd support=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $zstd"
>> =C2=A0 echo "NUMA host support $numa"
>> =C2=A0 echo "libxml2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 $libxml2"
>> =C2=A0 echo "tcmalloc support=C2=A0 $tcmalloc"
>> @@ -7559,6 +7585,9 @@ if test "$plugins" =3D "yes" ; then
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "\$ld_exported_sy=
mbols_list should have been set to 'yes'."
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> =C2=A0 fi
>> +if test "$zstd" =3D "yes" ; then
>> +=C2=A0 echo "CONFIG_ZSTD=3Dy" >> $config_host_mak
>> +fi
>> =C2=A0 =C2=A0 if test "$tcg_interpreter" =3D "yes"; then
>> =C2=A0=C2=A0=C2=A0 QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/tci $QEMU_I=
NCLUDES"
>> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
>> index 5597e24474..aeca2ddebd 100644
>> --- a/docs/interop/qcow2.txt
>> +++ b/docs/interop/qcow2.txt
>> @@ -208,6 +208,7 @@ version 2.
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Available c=
ompression type values:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0: zlib <https://www.zlib.net/>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1: zs=
td <http://github.com/facebook/zstd>
>> =C2=A0 =C2=A0 =C2=A0 =3D=3D=3D Header padding =3D=3D=3D
>> @@ -575,11 +576,28 @@ Compressed Clusters Descriptor (x =3D 62 -=20
>> (cluster_bits - 8)):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Another compressed c=
luster may map to the tail=20
>> of the final
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sector used by this =
compressed cluster.
>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The layout of the compr=
essed data depends on=20
>> the compression
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type used for the image (see =
compressed cluster=20
>> layout).
>> +
>> =C2=A0 If a cluster is unallocated, read requests shall read the data fr=
om=20
>> the backing
>> =C2=A0 file (except if bit 0 in the Standard Cluster Descriptor is set).=
=20
>> If there is
>> =C2=A0 no backing file or the backing file is smaller than the image, th=
ey=20
>> shall read
>> =C2=A0 zeros for all parts that are not covered by the backing file.
>> =C2=A0 +=3D=3D=3D Compressed Cluster Layout =3D=3D=3D
>> +
>> +The compressed cluster data has a layout depending on the compression
>> +type used for the image, as follows:
>> +
>> +Compressed data layout for the available compression types:
>> +(x =3D data_space_length - 1)
>
> Note, that term 'data_space_lenght' is not defined in the spec..
>
> Hmm. And it's not trivial to define it correctly, all we have is=20
> offset and
> "number of additional sectors", and may be not all bytes of final=20
> sector are
> occupied... What about something like this:
>
> In the following layout description byte 0 corresponds to byte at host=20
> cluster offset,
> as defined by "Compressed Clusters Descriptor" paragraph above. The=20
> whole layout occupy
> space starting from this offset, using additional 512-byte sectors=20
> defined by
> "Compressed Clusters Descriptor" paragraph, not necessarily occupying=20
> all of the bytes
> in the final sector. Let x be number of last byte of the layout.
Sounds too complicated for me, may be
x - data chunk length available to store a compressed cluster. (for more=20
details see "Compressed Clusters Descriptor")
>
>
>> +
>> +=C2=A0=C2=A0=C2=A0 0:=C2=A0 (default)=C2=A0 zlib <http://zlib.net/>:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Byte=
=C2=A0 0 -=C2=A0 x:=C2=A0=C2=A0=C2=A0=C2=A0 the compressed data content
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 all the space provided used for=20
>> compressed data
>> +=C2=A0=C2=A0=C2=A0 1:=C2=A0 zstd <http://github.com/facebook/zstd>:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Byte=
=C2=A0 0 -=C2=A0 3:=C2=A0=C2=A0=C2=A0=C2=A0 the length of compressed data i=
n bytes
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4 -=C2=A0 x:=C2=A0=C2=A0=C2=A0=C2=A0 the =
compressed data content
>
> Maybe, note that x+! =3D=3D 4 + length, where length is value of first=20
> field of the layout.
>
>> =C2=A0 =C2=A0 =3D=3D Snapshots =3D=3D
>> =C2=A0 diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 873fbef3b5..4b6e576c44 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -4401,11 +4401,12 @@
>> =C2=A0 # Compression type used in qcow2 image file
>> =C2=A0 #
>> =C2=A0 # @zlib:=C2=A0 zlib compression, see <http://zlib.net/>
>> +# @zstd:=C2=A0 zstd compression, see <http://github.com/facebook/zstd>
>> =C2=A0 #
>> =C2=A0 # Since: 5.0
>> =C2=A0 ##
>> =C2=A0 { 'enum': 'Qcow2CompressionType',
>> -=C2=A0 'data': [ 'zlib' ] }
>> +=C2=A0 'data': [ 'zlib', { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)'=
 }=20
>> ] }
>> =C2=A0 =C2=A0 ##
>> =C2=A0 # @BlockdevCreateOptionsQcow2:
>>
>
>


