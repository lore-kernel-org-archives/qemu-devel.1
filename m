Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BC3C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01B2324688
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="irrcFlel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B2324688
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7eMv-0004sG-8Q
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 07:03:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j7eJA-0002Q2-FA
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:59:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j7eJ6-0006UK-Pi
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:59:56 -0500
Received: from mail-eopbgr80102.outbound.protection.outlook.com
 ([40.107.8.102]:33449 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j7eIw-0006QT-Nf; Fri, 28 Feb 2020 06:59:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFe8nz9accmpRGK8mwpkEJuFhpasZgovjF+bEf+zt01nDLej5G/aDgX1H/FN9bp0tYAM5ewvU5AEF64KoMnsa9jDYejbrQP4wEDGQfHpuZHEmyToSmRSbfJOhQy8lbk3fDXi1Kbz159QRJ+8+xVaYEBnnT85icNYBF1z+KcllIBpoPBAjogCl5Wq5cBYUdNo1KVseQiOI8nKyspSTHlLvHPhNRIiYF+Y73OoHQHqlUFVKi0KRTUEovA8YqaSiQxUowkGA0CEDBcvusagXzaoo3YwTPQnVWrSLSnSF541Zk00KiwXCxkkL1kaX+yLkMyumcuF6n3k/TU2cTSLv6hOAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpR0lzq9pTCDB62r9YgCUJC19asrrHVlOAZ5FAJF1Ts=;
 b=QKG4WNy5ahTGkZGClEeY7vO88UWptayui+5pyImLptX3nghVR/msKEt28okiIGFKRiohuV/5mGZjWb2ST1gWPp1KFZRYSw+FbKjFcRJwcdKTyflPcz5SDWaFU/Ib76XoU09OTSwQBsWgAlBFACS4D102+h7VCJcisO0zpHpD22byQlEHPsSNKDf5FInBo+MNpkbyKZj/K2u43VylcHEj5y115pbLUkLQlfc9m7eVtvUKZ5kaerp+2jBaHEd/I4GCaA737Dm4RWviWuGFA+M6Fbo94z1Sll+vDNWXXi0P9E9PRd1ORjtfIGInEwX3UDjZgaHSHeBzN09QIQsM4l7ukA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpR0lzq9pTCDB62r9YgCUJC19asrrHVlOAZ5FAJF1Ts=;
 b=irrcFleleSDEWM0SAQaE+9K4sAhZQPrDRIXtsUkfp6hv7wQQ10GuIv0duNctyAirb+Y5TTg0OTctpT6xpYZ4LnlmpXV+0f+vp6sy6zk0bKGB9RCqBhWrmR0TKeRWBqIzE2e9eLjDMUH8qAA2Pj/xouX6AF58VB1gqQ8F3/WBVHo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3811.eurprd08.prod.outlook.com (20.178.82.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Fri, 28 Feb 2020 11:59:39 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219%4]) with mapi id 15.20.2772.012; Fri, 28 Feb 2020
 11:59:39 +0000
Subject: Re: [PATCH v1 3/8] qcow2: add zstd cluster compression
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
 <20200227072953.25445-4-dplotnikov@virtuozzo.com>
 <d1486527-8469-18f3-20ba-969a8232aafb@virtuozzo.com>
 <583362b9-76df-089c-8c1b-0b2fbda7533c@virtuozzo.com>
 <85e9b76e-80f8-c49d-8db0-545cd0871647@virtuozzo.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <9b5b10a6-5848-a608-ae51-40d3fab89310@virtuozzo.com>
Date: Fri, 28 Feb 2020 14:59:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <85e9b76e-80f8-c49d-8db0-545cd0871647@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: HE1PR05CA0143.eurprd05.prod.outlook.com
 (2603:10a6:7:28::30) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.162.229) by
 HE1PR05CA0143.eurprd05.prod.outlook.com (2603:10a6:7:28::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Fri, 28 Feb 2020 11:59:38 +0000
X-Originating-IP: [178.34.162.229]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f26be43-44a1-4bbe-5822-08d7bc45b04b
X-MS-TrafficTypeDiagnostic: AM0PR08MB3811:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB381119D87C2AF29FE3BF85E7CFE80@AM0PR08MB3811.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0327618309
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(366004)(136003)(376002)(346002)(189003)(199004)(8676002)(81156014)(316002)(2616005)(31696002)(86362001)(956004)(4326008)(30864003)(5660300002)(31686004)(478600001)(52116002)(8936002)(16576012)(81166006)(66556008)(186003)(6486002)(2906002)(16526019)(36756003)(66946007)(19273905006)(53546011)(26005)(66476007)(563064011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3811;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GAUP49I5i3bbePF0sIGfhWrMRGsBxfLfpVC8ZyPq+eDnOKIxDruAKnXZFgk48nNMeaKh+HuSMC06p0kYdCkibxSXmRzx4oLlUuslkJzuEX5TJUlZPJeHSXSAi21fCTGYMxZZtQEfdYNr1Q0NrTImP86JBiC+O7TlL5+B0OIrtKE8uZQ1M/g9Bpwe6TEV+Ssoo3EjIoFbf7IkD9E3nSxgaAhBlQeOzgZDa9ow4Jr8VpOmScwuJ+WzsI5DPO2okciwit8fWEKRfoeSqEeWOWk4HHf9sfs9CpybXHqupvY4BjIqe2M25qMINnCUm3PhdaXOU6CNdifOyFn5/abH9JLjqTn6MHQrhQyBYrTzELBJ8rOBSGQyonxBXUgTG1SeEIdXn+/m161+v8FVnhrOSc0JRE3jBN722+sQQzqIY2YiQd5hGIg9TBflllM4C2YSq7rC6A4s6Wizu2QN3hcZl9i39ymrs3s2dkWJuuWSVqkl5Jt6B+eVF9qe8mYLx5eP5vB2g4Gssmt+ljEX1Fjs9+vqBwjSgSoDx8FSmSikcU6Inu9HSt4ZV7kCpgX0FYPJm01J
X-MS-Exchange-AntiSpam-MessageData: 9XUB7OHZORbCTQFE++1jWZrbQncP3PC19STMJUawcZWogyKIN6TZPumITbWkubZOtCRFa2CPdU9LXZYEYhR2S/bArljR4aCGQxESZ820PeCDl+GqgpQFBMFmLJyeFn7KGIEJw7QRPhRgX90Ce7lUIg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f26be43-44a1-4bbe-5822-08d7bc45b04b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 11:59:39.4606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJ4GCSbkcdsVPfaf+oxGw+z1mleEA4FC3v9xdzDTKQn2bHD5GPnPyaRARoHmxhXdPM7nSKeKLXuIoj0FPMihPsrhzrcZ77oelzruWd3frnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3811
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.102
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



On 27.02.2020 17:18, Vladimir Sementsov-Ogievskiy wrote:
> 27.02.2020 17:11, Denis Plotnikov wrote:
>>
>>
>> On 27.02.2020 12:55, Vladimir Sementsov-Ogievskiy wrote:
>>> 27.02.2020 10:29, Denis Plotnikov wrote:
>>>> zstd significantly reduces cluster compression time.
>>>> It provides better compression performance maintaining
>>>> the same level of the compression ratio in comparison with
>>>> zlib, which, at the moment, is the only compression
>>>> method available.
>>>>
>>>> The performance test results:
>>>> Test compresses and decompresses qemu qcow2 image with just
>>>> installed rhel-7.6 guest.
>>>> Image cluster size: 64K. Image on disk size: 2.2G
>>>>
>>>> The test was conducted with brd disk to reduce the influence
>>>> of disk subsystem to the test results.
>>>> The results is given in seconds.
>>>>
>>>> compress cmd:
>>>> =C2=A0=C2=A0 time ./qemu-img convert -O qcow2 -c -o compression_type=
=3D[zlib|zstd]
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 src.img [zlib|zstd]_compressed.img
>>>> decompress cmd
>>>> =C2=A0=C2=A0 time ./qemu-img convert -O qcow2
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [zlib|zstd]_compressed.img uncompre=
ssed.img
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 com=
pression=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 decompression
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zlib=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 zstd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 zlib=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zst=
d
>>>> ------------------------------------------------------------
>>>> real=C2=A0=C2=A0=C2=A0=C2=A0 65.5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
16.3 (-75 %)=C2=A0=C2=A0=C2=A0 1.9=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 1.6 (-16 %)
>>>> user=C2=A0=C2=A0=C2=A0=C2=A0 65.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
15.8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.3=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.5
>>>> sys=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.3=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0.2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 2.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.0
>>>>
>>>> Both ZLIB and ZSTD gave the same compression ratio: 1.57
>>>> compressed image size in both cases: 1.4G
>>>>
>>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>>> ---
>>>> =C2=A0 block/qcow2-threads.c=C2=A0 | 122=20
>>>> +++++++++++++++++++++++++++++++++++++++++
>>>> =C2=A0 block/qcow2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 7 +++
>>>> =C2=A0 configure=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 29 ++++++++++
>>>> =C2=A0 docs/interop/qcow2.txt |=C2=A0 18 ++++++
>>>> =C2=A0 qapi/block-core.json=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
>>>> =C2=A0 5 files changed, 178 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
>>>> index 1c128e9840..e942c4d7e5 100644
>>>> --- a/block/qcow2-threads.c
>>>> +++ b/block/qcow2-threads.c
>>>> @@ -28,6 +28,11 @@
>>>> =C2=A0 #define ZLIB_CONST
>>>> =C2=A0 #include <zlib.h>
>>>> =C2=A0 +#ifdef CONFIG_ZSTD
>>>> +#include <zstd.h>
>>>> +#include <zstd_errors.h>
>>>> +#endif
>>>> +
>>>> =C2=A0 #include "qcow2.h"
>>>> =C2=A0 #include "block/thread-pool.h"
>>>> =C2=A0 #include "crypto.h"
>>>> @@ -164,6 +169,113 @@ static ssize_t qcow2_zlib_decompress(void=20
>>>> *dest, size_t dest_size,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>> =C2=A0 }
>>>> =C2=A0 +#ifdef CONFIG_ZSTD
>>>> +
>>>> +#define ZSTD_LEN_BUF 4
>>>> +
>>>> +/*
>>>> + * qcow2_zstd_compress()
>>>> + *
>>>> + * Compress @src_size bytes of data using zstd compression method
>>>> + *
>>>> + * @dest - destination buffer, @dest_size bytes
>>>> + * @src - source buffer, @src_size bytes
>>>> + *
>>>> + * Returns: compressed size on success
>>>
>>> This doesn't match qcow2_co_compress definition. You should return 0=20
>>> on success.
>> does it? I'd rather say it doesn't match to qcow2_co_compress=20
>> description in the function comment, which we can change actually,
>> because qcow2_co_compress is used like:
>
> Oh, yes, you are right. Then we should change the comment.
>
>>
>> block/qcow2.c:
>>
>> static coroutine_fn int
>> qcow2_co_pwritev_compressed_task(BlockDriverState *bs,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t offset, uint64=
_t bytes,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMUIOVector *qiov, siz=
e_t=20
>> qiov_offset)
>> {
>> =C2=A0=C2=A0=C2=A0=C2=A0 ...
>> =C2=A0=C2=A0=C2=A0=C2=A0 out_buf =3D g_malloc(s->cluster_size);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 out_len =3D qcow2_co_compress(bs, out_buf, s->c=
luster_size - 1,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf, s->cluster_size);
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (out_len =3D=3D -ENOMEM) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* could not compress: =
write normal cluster */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D qcow2_co_pwrite=
v_part(bs, offset, bytes, qiov,=20
>> qiov_offset, 0);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 goto fail;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto success;
>> =C2=A0=C2=A0=C2=A0=C2=A0 } else if (out_len < 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 qemu_co_mutex_lock(&s->lock);
>> =C2=A0=C2=A0=C2=A0=C2=A0 ret =3D qcow2_alloc_compressed_cluster_offset(b=
s, offset, out_len,=20
>> <<<<<<<<<<<<
>> &cluster_offset);
>> =C2=A0=C2=A0=C2=A0=C2=A0 ...
>> }
>>
>>>
>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -ENOMEM dest=
ination buffer is not enough to store=20
>>>> compressed data
>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -EIO=C2=A0=
=C2=A0=C2=A0 on any other error
>>>> + */
>>>> +
>>>> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const void *sr=
c, size_t src_size)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 size_t ret;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * steal ZSTD_LEN_BUF bytes in the very begin=
ng of the buffer
>>>
>>> beginning
>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * to store compressed chunk size
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 char *d_buf =3D ((char *) dest) + ZSTD_LEN_BUF;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * sanity check that we can store the compres=
sed data length,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * and there is some space left for the compr=
essor buffer
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 if (dest_size <=3D ZSTD_LEN_BUF) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 dest_size -=3D ZSTD_LEN_BUF;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 ret =3D ZSTD_compress(d_buf, dest_size, src, src_s=
ize, 5);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (ZSTD_isError(ret)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ZSTD_getErrorCode(ret)=
 =3D=3D ZSTD_error_dstSize_tooSmall) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn -ENOMEM;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn -EIO;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* paraniod sanity check that we can store the com=
mpressed=20
>>>> size */
>>>> +=C2=A0=C2=A0=C2=A0 if (ret > UINT_MAX) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>
>>> I'd use UINT32_MAX, possibly even more paranoid)
>> ok
>>>
>>>
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* store the compressed chunk size in the very beg=
inning of=20
>>>> the buffer */
>>>> +=C2=A0=C2=A0=C2=A0 stl_be_p(dest, ret);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return ret + ZSTD_LEN_BUF;
>>>
>>> return 0;
>>>
>>>> +}
>>>> +
>>>> +/*
>>>> + * qcow2_zstd_decompress()
>>>> + *
>>>> + * Decompress some data (not more than @src_size bytes) to produce=20
>>>> exactly
>>>> + * @dest_size bytes using zstd compression method
>>>> + *
>>>> + * @dest - destination buffer, @dest_size bytes
>>>> + * @src - source buffer, @src_size bytes
>>>> + *
>>>> + * Returns: 0 on success
>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -EIO on any =
error
>>>> + */
>>>> +
>>>
>>> extra empty line.
>> will be removed
>>>
>>>
>>>> +static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
nst void *src, size_t=20
>>>> src_size)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * zstd decompress wants to know the exact le=
ngth of the data.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * For that purpose, on compression, the leng=
th is stored in
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * the very beginning of the compressed buffe=
r
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 size_t s_size;
>>>> +=C2=A0=C2=A0=C2=A0 const char *s_buf =3D ((const char *) src) + ZSTD_=
LEN_BUF;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * sanity check that we can read 4 byte the c=
ontent length and
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * and there is some content to decompress
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 if (src_size <=3D ZSTD_LEN_BUF) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 s_size =3D ldl_be_p(src);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* sanity check that the buffer is big enough to r=
ead the=20
>>>> content from */
>>>> +=C2=A0=C2=A0=C2=A0 if (src_size - ZSTD_LEN_BUF < s_size) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (ZSTD_isError(
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ZS=
TD_decompress(dest, dest_size, s_buf, s_size))) {
>>>
>>> hmm, it fit into one line actually
>> will be fixed if so
If there is no other objections I'd leave it as is since
 =C2=A0=C2=A0=C2=A0 if (ZSTD_isError(ZSTD_decompress(dest, dest_size, s_buf=
, s_size))) {
looks too messy to me although it fits into 80 chars
>>>
>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>> +}
>>>> +#endif
>>>> +
>>>> =C2=A0 static int qcow2_compress_pool_func(void *opaque)
>>>> =C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Qcow2CompressData *data =3D opaque;
>>>> @@ -215,6 +327,11 @@ qcow2_co_compress(BlockDriverState *bs, void=20
>>>> *dest, size_t dest_size,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn =3D qcow2_zl=
ib_compress;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>> =C2=A0 +#ifdef CONFIG_ZSTD
>>>> +=C2=A0=C2=A0=C2=A0 case QCOW2_COMPRESSION_TYPE_ZSTD:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn =3D qcow2_zstd_compress=
;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>> +#endif
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOTSUP=
;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> @@ -247,6 +364,11 @@ qcow2_co_decompress(BlockDriverState *bs, void=20
>>>> *dest, size_t dest_size,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn =3D qcow2_zl=
ib_decompress;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>> =C2=A0 +#ifdef CONFIG_ZSTD
>>>> +=C2=A0=C2=A0=C2=A0 case QCOW2_COMPRESSION_TYPE_ZSTD:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fn =3D qcow2_zstd_decompre=
ss;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>> +#endif
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOTSUP=
;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>>> index 2ccb2cabd1..9c8ad9d580 100644
>>>> --- a/block/qcow2.c
>>>> +++ b/block/qcow2.c
>>>> @@ -1257,6 +1257,9 @@ static int=20
>>>> validate_compression_type(BDRVQcow2State *s, Error **errp)
>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (s->compression_type) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case QCOW2_COMPRESSION_TYPE_ZLIB:
>>>> +#ifdef CONFIG_ZSTD
>>>> +=C2=A0=C2=A0=C2=A0 case QCOW2_COMPRESSION_TYPE_ZSTD:
>>>> +#endif
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>>>> @@ -3506,6 +3509,10 @@ qcow2_co_create(BlockdevCreateOptions=20
>>>> *create_options, Error **errp)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (=
qcow2_opts->compression_type) {
>>>> +#ifdef CONFIG_ZSTD
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case QCOW2_COMPRESSION_TYP=
E_ZSTD:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>>>> +#endif
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 error_setg_errno(errp, -EINVAL, "Unknown compression=20
>>>> type");
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto out;
>>>> diff --git a/configure b/configure
>>>> index 48d6f89d57..4690a7ea9f 100755
>>>> --- a/configure
>>>> +++ b/configure
>>>> @@ -444,6 +444,7 @@ opengl_dmabuf=3D"no"
>>>> =C2=A0 cpuid_h=3D"no"
>>>> =C2=A0 avx2_opt=3D""
>>>> =C2=A0 zlib=3D"yes"
>>>> +zstd=3D""
>>>> =C2=A0 capstone=3D""
>>>> =C2=A0 lzo=3D""
>>>> =C2=A0 snappy=3D""
>>>> @@ -1371,6 +1372,10 @@ for opt do
>>>> =C2=A0=C2=A0=C2=A0 ;;
>>>> =C2=A0=C2=A0=C2=A0 --disable-lzfse) lzfse=3D"no"
>>>> =C2=A0=C2=A0=C2=A0 ;;
>>>> +=C2=A0 --enable-zstd) zstd=3D"yes"
>>>> +=C2=A0 ;;
>>>> +=C2=A0 --disable-zstd) zstd=3D"no"
>>>> +=C2=A0 ;;
>>>> =C2=A0=C2=A0=C2=A0 --enable-guest-agent) guest_agent=3D"yes"
>>>> =C2=A0=C2=A0=C2=A0 ;;
>>>> =C2=A0=C2=A0=C2=A0 --disable-guest-agent) guest_agent=3D"no"
>>>> @@ -1829,6 +1834,7 @@ disabled with --disable-FEATURE, default is=20
>>>> enabled if available:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (for reading bzip2-compressed=
 dmg images)
>>>> =C2=A0=C2=A0=C2=A0 lzfse=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 support of lzfse compression library
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (for reading lzfse-compressed=
 dmg images)
>>>> +=C2=A0 zstd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 support of zstd compression library
>>>> =C2=A0=C2=A0=C2=A0 seccomp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 seccomp support
>>>> =C2=A0=C2=A0=C2=A0 coroutine-pool=C2=A0 coroutine freelist (better per=
formance)
>>>> =C2=A0=C2=A0=C2=A0 glusterfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Glust=
erFS backend
>>>> @@ -2453,6 +2459,25 @@ EOF
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>>> =C2=A0 fi
>>>> =C2=A0 +#########################################
>>>> +# zstd check
>>>> +
>>>> +if test "$zstd" !=3D "no" ; then
>>>> +=C2=A0=C2=A0=C2=A0 cat > $TMPC << EOF
>>>> +#include <zstd.h>
>>>> +int main(void) { ZSTD_versionNumber(); return 0; }
>>>> +EOF
>>>> +=C2=A0=C2=A0=C2=A0 if compile_prog "" "-lzstd" ; then
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LIBS=3D"$LIBS -lzstd"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zstd=3D"yes"
>>>> +=C2=A0=C2=A0=C2=A0 else
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if test "$zstd" =3D "yes";=
 then
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fe=
ature_not_found "zstd" "Install libzstd-devel"
>>>
>>> to correspond to style used around: s/libzstd-devel/libzstd devel/
>> My intention was to give a package name for a user encountered this=20
>> message to copy-paste it to "yum install".
>
> What about apt users? :)
>
>> If this doesn't make things easier, because the package name can be=20
>> changed in the future (although I doubt) I'll fix it.
>> If the style isn't that important I'd rather leave it as is.
>
> I don't care, keep it as is.
>
>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zstd=3D"no"
>>>> +=C2=A0=C2=A0=C2=A0 fi
>>>> +fi
>>>> +
>>>> =C2=A0 ##########################################
>>>> =C2=A0 # libseccomp check
>>>> =C2=A0 @@ -6668,6 +6693,7 @@ echo "lzo support=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 $lzo"
>>>> =C2=A0 echo "snappy support=C2=A0=C2=A0=C2=A0 $snappy"
>>>> =C2=A0 echo "bzip2 support=C2=A0=C2=A0=C2=A0=C2=A0 $bzip2"
>>>> =C2=A0 echo "lzfse support=C2=A0=C2=A0=C2=A0=C2=A0 $lzfse"
>>>> +echo "zstd support=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $zstd"
>>>> =C2=A0 echo "NUMA host support $numa"
>>>> =C2=A0 echo "libxml2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 $libxml2"
>>>> =C2=A0 echo "tcmalloc support=C2=A0 $tcmalloc"
>>>> @@ -7559,6 +7585,9 @@ if test "$plugins" =3D "yes" ; then
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "\$ld_exported_=
symbols_list should have been set to 'yes'."
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>>> =C2=A0 fi
>>>> +if test "$zstd" =3D "yes" ; then
>>>> +=C2=A0 echo "CONFIG_ZSTD=3Dy" >> $config_host_mak
>>>> +fi
>>>> =C2=A0 =C2=A0 if test "$tcg_interpreter" =3D "yes"; then
>>>> =C2=A0=C2=A0=C2=A0 QEMU_INCLUDES=3D"-iquote \$(SRC_PATH)/tcg/tci $QEMU=
_INCLUDES"
>>>> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
>>>> index 5597e24474..aeca2ddebd 100644
>>>> --- a/docs/interop/qcow2.txt
>>>> +++ b/docs/interop/qcow2.txt
>>>> @@ -208,6 +208,7 @@ version 2.
>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Available c=
ompression type values:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0: zlib <https://www.zlib.net/>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1: zs=
td <http://github.com/facebook/zstd>
>>>> =C2=A0 =C2=A0 =C2=A0 =3D=3D=3D Header padding =3D=3D=3D
>>>> @@ -575,11 +576,28 @@ Compressed Clusters Descriptor (x =3D 62 -=20
>>>> (cluster_bits - 8)):
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Another compresse=
d cluster may map to the=20
>>>> tail of the final
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sector used by th=
is compressed cluster.
>>>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The layout of the co=
mpressed data depends on=20
>>>> the compression
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type used for the image (see =
compressed=20
>>>> cluster layout).
>>>> +
>>>> =C2=A0 If a cluster is unallocated, read requests shall read the data=
=20
>>>> from the backing
>>>> =C2=A0 file (except if bit 0 in the Standard Cluster Descriptor is set=
).=20
>>>> If there is
>>>> =C2=A0 no backing file or the backing file is smaller than the image,=
=20
>>>> they shall read
>>>> =C2=A0 zeros for all parts that are not covered by the backing file.
>>>> =C2=A0 +=3D=3D=3D Compressed Cluster Layout =3D=3D=3D
>>>> +
>>>> +The compressed cluster data has a layout depending on the compression
>>>> +type used for the image, as follows:
>>>> +
>>>> +Compressed data layout for the available compression types:
>>>> +(x =3D data_space_length - 1)
>>>
>>> Note, that term 'data_space_lenght' is not defined in the spec..
>>>
>>> Hmm. And it's not trivial to define it correctly, all we have is=20
>>> offset and
>>> "number of additional sectors", and may be not all bytes of final=20
>>> sector are
>>> occupied... What about something like this:
>>>
>>> In the following layout description byte 0 corresponds to byte at=20
>>> host cluster offset,
>>> as defined by "Compressed Clusters Descriptor" paragraph above. The=20
>>> whole layout occupy
>>> space starting from this offset, using additional 512-byte sectors=20
>>> defined by
>>> "Compressed Clusters Descriptor" paragraph, not necessarily=20
>>> occupying all of the bytes
>>> in the final sector. Let x be number of last byte of the layout.
>> Sounds too complicated for me, may be
>> x - data chunk length available to store a compressed cluster. (for=20
>> more details see "Compressed Clusters Descriptor")
>
> Ok
>
>>>
>>>
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 0:=C2=A0 (default)=C2=A0 zlib <http://zlib.net/>:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 By=
te=C2=A0 0 -=C2=A0 x:=C2=A0=C2=A0=C2=A0=C2=A0 the compressed data content
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 all the space provided used for=20
>>>> compressed data
>>>> +=C2=A0=C2=A0=C2=A0 1:=C2=A0 zstd <http://github.com/facebook/zstd>:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 By=
te=C2=A0 0 -=C2=A0 3:=C2=A0=C2=A0=C2=A0=C2=A0 the length of compressed data=
 in bytes
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4 -=C2=A0 x:=C2=A0=C2=A0=C2=A0=C2=A0 the =
compressed data content
>>>
>>> Maybe, note that x+! =3D=3D 4 + length, where length is value of first=
=20
>>> field of the layout.
>>>
>>>> =C2=A0 =C2=A0 =3D=3D Snapshots =3D=3D
>>>> =C2=A0 diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>> index 873fbef3b5..4b6e576c44 100644
>>>> --- a/qapi/block-core.json
>>>> +++ b/qapi/block-core.json
>>>> @@ -4401,11 +4401,12 @@
>>>> =C2=A0 # Compression type used in qcow2 image file
>>>> =C2=A0 #
>>>> =C2=A0 # @zlib:=C2=A0 zlib compression, see <http://zlib.net/>
>>>> +# @zstd:=C2=A0 zstd compression, see <http://github.com/facebook/zstd=
>
>>>> =C2=A0 #
>>>> =C2=A0 # Since: 5.0
>>>> =C2=A0 ##
>>>> =C2=A0 { 'enum': 'Qcow2CompressionType',
>>>> -=C2=A0 'data': [ 'zlib' ] }
>>>> +=C2=A0 'data': [ 'zlib', { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD=
)'=20
>>>> } ] }
>>>> =C2=A0 =C2=A0 ##
>>>> =C2=A0 # @BlockdevCreateOptionsQcow2:
>>>>
>>>
>>>
>>
>
>


