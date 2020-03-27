Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36204C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE24220714
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Dy8S4E3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE24220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHlUj-0005T3-PT
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 05:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jHlTu-0004yu-3z
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jHlTs-0005gm-9W
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:40:50 -0400
Received: from mail-eopbgr10096.outbound.protection.outlook.com
 ([40.107.1.96]:37454 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jHlTl-00059V-27; Fri, 27 Mar 2020 05:40:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TscmiXrFhUmcH8Z6ebRYOTnrakfyJ+qJ2ydpuuyQtlmsBx+YOpJ0PWCJGiK7OHDL+pmhS0JVAuRMuPnrzYTItwFBWyK/rV0mDX4ajl+XHtPP7Vdeqahcyc/y2KmYov7MWphWMcm0LHqVvwmV85yWWDIIfN9n4LKtJRt/d2DU0zn7YWDcso9w9h4ODYwAFdG2ERF6rhHS/FhnuXk9NdZQ9DQQce7TISXeq7oUT+9cQaCGDPZ6HxZhJ5xX7qSjOOsCYPq7cty+7q8l9gfdhGsrhjvS0TcZx+06HoZc//bk77gt3X19qHHjgcdyPcXbbSN3Rn0NLTli3xJWvfG+EiXvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8ylHHCiO7QhLhIkkdNPwxv/14glTH56DaZLuaOJRzc=;
 b=PC8ZhYEtveuwZNv3h0beDFFrMnQL5exSAU0TwAZQlw+INNCQ/gaYqwPSg7CbnutpqDp9gHolPg7ZThRdhWjyBpyBrwG/kepTSzepiBDEhRY/KyPd3m4eMiFVB4wqb34TSr6dXWoEVtOX6hiB90CpDY/5uCv36tDtu+NLwDAvOfQIFyf/stY8zqQSffnTFSf0dz+Am3nxEP31ZoaSybtzbfkMJpJ+kNAE5WjN65l+51Y7DanKDwBnE2ORVvbqm+I9jWg9ICx13Ki4DmGbBkpQp3xRlkX/IZnQkwKH0CdP+rpA1qbZ4YArb93OSvI1XZCLgVyIGzfcSZXU8FzO9HDS7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8ylHHCiO7QhLhIkkdNPwxv/14glTH56DaZLuaOJRzc=;
 b=Dy8S4E3/YeBuaheBKnLYfm4O14JNtx1zTtDM2ExvfeABDBA3xpPUJJP26jergQ6TqQqV3cKgKeOZ0uGLjwHu0OzFnXWquF474zIFe2RSaGVxI8bqAVK9yxzkAwL3fecU6wxMrUDCQ0FsnsX6Se4p9Bsq3q5gyHKMLBR+WhEf8wQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB5441.eurprd08.prod.outlook.com (52.132.212.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Fri, 27 Mar 2020 09:40:38 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219%4]) with mapi id 15.20.2835.025; Fri, 27 Mar 2020
 09:40:38 +0000
Subject: Re: [PATCH v9 3/4] qcow2: add zstd cluster compression
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200323142558.15473-1-dplotnikov@virtuozzo.com>
 <20200323142558.15473-4-dplotnikov@virtuozzo.com>
 <9ad0aa8d-b813-ae3a-2d4e-d1573e9cb582@virtuozzo.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <662cb9bd-5528-ca4e-8698-40c8cd414f33@virtuozzo.com>
Date: Fri, 27 Mar 2020 12:40:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <9ad0aa8d-b813-ae3a-2d4e-d1573e9cb582@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::22)
 To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.151.159) by
 FRYP281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20 via Frontend Transport; Fri, 27 Mar 2020 09:40:37 +0000
X-Originating-IP: [178.34.151.159]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdfa146d-87f1-4dc5-216c-08d7d232e820
X-MS-TrafficTypeDiagnostic: AM0PR08MB5441:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB54412DB0456CF94235287655CFCC0@AM0PR08MB5441.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(366004)(346002)(39850400004)(396003)(376002)(136003)(8676002)(81166006)(36756003)(81156014)(66476007)(6486002)(5660300002)(52116002)(66556008)(4326008)(2906002)(66946007)(31686004)(53546011)(956004)(2616005)(16526019)(186003)(26005)(316002)(31696002)(478600001)(8936002)(966005)(16576012)(86362001);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qW9D+0cYD70mDEH0HjtVBzJbR/H3Rwew5LCl6ooHb5dVQo0XZZcmaJdRjgYnmGE7beyHF3JlenCQVHeDVWBcHvgd1YGfmQfC7rXa0yi15XHVtzLAUOvI3Saab0VOLZIbLsyKd2kuH9nKqsB5w97nk4Bkem1T8Ih95pf8J9EFq5AyDpjb+PzzYBQaxk8SaDGG876oznde82S2WumdWL88vFIIYpRyEk3VfFI96RWcEyp/KcQu/DC9a2W6FF/sf85F2MHTA2HH6fEHivtb3yymf2krb51TWLqsSkeyPbj8Ei3p0za8gpGJK58XsglGPe86PWSmmMW3zNsH/6YRl4gq4tKw+0707aFWTgRVa3kYne8kek3eEHcAUeYk/Y5azAsesrUE/VdEwnf+wHJ2pYJE6q7I7eD4Pkaq83tYh2OWkL/du1BuR9SSGDVI9chIwlGezg64O0d3KDuvfBjhzm7Bj5YNFm5cV8iGbUGTY9QF9zHNr8gNEJHrTiPnMnBWkoYLXR6wJ/Gs9Nwhnxfb9ukupw==
X-MS-Exchange-AntiSpam-MessageData: eLVDOB8dMzytq1S1t7wZrcqllvHYYqmm87bZ2EJ8+tJlhp7o/LC0ip1XIhyfczwXciLdvtCiRj4xILsVIIN9kWsgmsUw6hlkKDUSp30bGtpan8Bz30uQvz7FKs322R4shbTnaUarB+14xDUYVN3Aww==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdfa146d-87f1-4dc5-216c-08d7d232e820
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 09:40:38.2031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjs2Hgc2dIXvLGs8NbRFIEaSow/pDrEdPCGwwiDdG8auk6IhJKF0bJKnZdW4v2+hqzw0ddxwTSRGzL3n/+tjt9s1+QleXCYcPc+p29tIzCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5441
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.1.96
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
Cc: kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 27.03.2020 11:43, Vladimir Sementsov-Ogievskiy wrote:
> Should we note somehow in qcow2 spec that we use streamed version of=20
> zstd with specific end byte?
We didn't do it for zlib. zstd does it the same way as zlib, saves the=20
compression output to some buffer.

>
> 23.03.2020 17:25, Denis Plotnikov wrote:
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
>> QAPI part:
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
> [..]
>
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
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -ENOMEM destin=
ation buffer is not enough to store=20
>> compressed data
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -EIO=C2=A0=C2=
=A0=C2=A0 on any other error
>> + */
>> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const void *sr=
c, size_t src_size)
>> +{
>> +=C2=A0=C2=A0=C2=A0 size_t ret;
>> +=C2=A0=C2=A0=C2=A0 ZSTD_outBuffer output =3D { dest, dest_size, 0 };
>> +=C2=A0=C2=A0=C2=A0 ZSTD_inBuffer input =3D { src, src_size, 0 };
>> +=C2=A0=C2=A0=C2=A0 ZSTD_CCtx *cctx =3D ZSTD_createCCtx();
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!cctx) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * ZSTD spec: "You must continue calling ZSTD_c=
ompressStream2()
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * with ZSTD_e_end until it returns 0, at which=
 point you are
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * free to start a new frame"
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * zstd simple interfac=
e requires the exact compressed size.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * zstd stream interfac=
e reads the comressed size from
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the compressed strea=
m frame.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Instruct zstd to com=
press the whole buffer and write
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the frame which incl=
udes the compressed size.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This allows as to us=
e zstd streaming semantics and
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * don't store the comp=
ressed size for the zstd decompression.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ZSTD_compressStream2=
(cctx, &output, &input, ZSTD_e_end);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ZSTD_isError(ret)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D -EIO;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 out;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Dest buffer isn't big eno=
ugh to store compressed content */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (output.pos + ret > outpu=
t.size) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D -ENOMEM;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 out;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 } while (ret);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* if no error, the input data must be fully consume=
d */
>> +=C2=A0=C2=A0=C2=A0 assert(input.pos =3D=3D input.size);
>> +=C2=A0=C2=A0=C2=A0 /* make sure we can safely return compressed buffer =
size with=20
>> ssize_t *//z
>> +=C2=A0=C2=A0=C2=A0 assert(output.pos <=3D SSIZE_MAX);
>> +=C2=A0=C2=A0=C2=A0 ret =3D output.pos;
>> +
>> +out:
>> +=C2=A0=C2=A0=C2=A0 ZSTD_freeCCtx(cctx);
>> +=C2=A0=C2=A0=C2=A0 return ret;
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
>> +static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
nst void *src, size_t src_size)
>> +{
>> +=C2=A0=C2=A0=C2=A0 size_t ret =3D 0;
>> +=C2=A0=C2=A0=C2=A0 ZSTD_outBuffer output =3D { dest, dest_size, 0 };
>> +=C2=A0=C2=A0=C2=A0 ZSTD_inBuffer input =3D { src, src_size, 0 };
>> +=C2=A0=C2=A0=C2=A0 ZSTD_DCtx *dctx =3D ZSTD_createDCtx();
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!dctx) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ZSTD_decompressStrea=
m(dctx, &output, &input);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ZSTD_isError(ret)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D -EIO;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 out;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Dest buffer size is =
the image cluster size.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * It should be big eno=
ugh to store uncompressed content.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * There shouldn't be a=
ny cases when the decompressed content
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * size is greater then=
 the cluster size.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (output.pos + ret > outpu=
t.size) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D -EIO;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 out;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 } while (ret);
>
>
> Hmm. Unfortunately, zstd spec is not enough verbose to understand how=20
> to use
> these functions :).
>
> But I found this in comment in=20
> https://github.com/facebook/zstd/blob/dev/examples/streaming_decompressio=
n.c=20
> :
>
> /* The return code is zero if the frame is complete, but there may
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
* be multiple frames concatenated together.
In our case, there should be the only frame as we stored it with=20
ZSTD_compressStream2(..., ZSTD_e_end)
If explicitly state in the spec, that "zstd compressed cluster must=20
contain the only zstd compressed frame"
On the other hand, we actually don't need such a restriction and we=20
should be able to decompress whatever is in the buffer (cluster)
if it's zstd stream.

>
> so, I think it would be safer to move to "while (input.pos <=20
> input.size)" loop like in example.
yes, I think It worth doing
>
> and drop next assertion. And possibly do same for compression to be=20
> consistent (and safer?).
>
>
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If decompression went fine we must have the =
compressed
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * cluster fully consumed and flushed
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (output.pos !=3D output.size) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EIO;
>> +=C2=A0=C2=A0=C2=A0 }
>> +out:
>> +=C2=A0=C2=A0=C2=A0 ZSTD_freeDCtx(dctx);
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +
>> +}
>> +#endif
>> +
>> =C2=A0 static int qcow2_compress_pool_func(void *opaque)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Qcow2CompressData *data =3D opaque;
>> @@ -217,6 +341,11 @@ qcow2_co_compress(BlockDriverState *bs, void=20
>> *dest, size_t dest_size,
>
>
> [..]
>
>


