Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDD0C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 07:03:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF8D208E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 07:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AvPlZJVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF8D208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJXPo-0004t1-2p
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 03:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35580)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jJXOp-0004NQ-D9
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 03:02:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jJXOn-0000Xp-Pa
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 03:02:55 -0400
Received: from mail-db8eur05on2118.outbound.protection.outlook.com
 ([40.107.20.118]:18080 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jJXOh-0008Nm-2Q; Wed, 01 Apr 2020 03:02:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVkzmHutbFuYJ/5MHeOr5EuexpwAg7ZBKFwYuJJS4pHl3DKHgZA1OqMR4Bj/6XrFRpDsY+5ZGMAhDxqpoxRSWSzRyuRwDWDVvZ800MIutKC6lRLFkJ2zOHAsgqe2h3KGc7o2+Q270NnCejDLcmd5HxKXV+L8ElfMT3IZFOuTp2HSfd2QV6MG6eJmelbQgqAf8/VpwfSX+vLwpCCWAe/7itXZM09OGgZo1Z8lN8KIa/ArgXZsFeaWrnK7tm5QIsbsGunMPF5SzXAI+67cAYpruC8q2LoEE79eKmCnqijkHKIJ9S/VCp9HNmLjDY3xSw+mU+uu2iMnwGNNlC/l+mA2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+tFT/w11AN6UJDnbWHT8ipnbNhk72SgAIZWnOMVGm0=;
 b=L2RbmBeFQOCwOMxKoydRxqZpCkf6sxII26bxaJl0whsSMBBo+mh7QXjmtVu5unW+N9nR4l+IVLmsXs5mTdwa5Za1SF+/EK2m0AxSb3vD+eUysHwtxqsgHxqdw+RrIT9YgjA7tzGsCZSRebO59xrZJ2cvHLjuOFXORGwVSqkf3EJKLXUki+TcP86K8K/ioou2giqGjn8L7oTolFpRI4d++xL1lm+Ap+Sefmd74WGOrc2sFOMXkLXWQBu45lEZmp9Ikq8q8d3jRrYi+s104PkluhCJ3akXJALOc/0C7FaXgwg/pxIfOuTIo86fDFmhneHSVEJpyFZtwu7SdfRB7jqWaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+tFT/w11AN6UJDnbWHT8ipnbNhk72SgAIZWnOMVGm0=;
 b=AvPlZJVgv9X/FuCYNeG6H9Gw8gWwCt8EYdS7jMr1MuEJ6sIzi2F/Q2///6wUixoDs8MkQiE0u6Cwc1bluck2HC25uOwgsm37m+eu7KaYk4vFISnbkAfPRGf3Jdlul28aMwkdVR17uWZXlxia7C1auOnMylcIDujQF63mYqtsln4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3713.eurprd08.prod.outlook.com (20.178.21.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Wed, 1 Apr 2020 07:02:44 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f%4]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 07:02:44 +0000
Subject: Re: [PATCH v14 3/4] qcow2: add zstd cluster compression
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200331174455.31792-1-dplotnikov@virtuozzo.com>
 <20200331174455.31792-4-dplotnikov@virtuozzo.com>
 <434f359a-998f-1c60-ecad-fa6cb25e9374@virtuozzo.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <aee58e22-cddb-0cff-4044-f558f207a30d@virtuozzo.com>
Date: Wed, 1 Apr 2020 10:02:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <434f359a-998f-1c60-ecad-fa6cb25e9374@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0012.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::25) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.150.115) by
 AM0PR06CA0012.eurprd06.prod.outlook.com (2603:10a6:208:ab::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20 via Frontend Transport; Wed, 1 Apr 2020 07:02:43 +0000
X-Originating-IP: [178.34.150.115]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe60a92c-29fa-458d-3ddf-08d7d60aad43
X-MS-TrafficTypeDiagnostic: AM0PR08MB3713:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB3713DAD85CF000C5DEFEA88ECFC90@AM0PR08MB3713.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39840400004)(376002)(366004)(346002)(136003)(396003)(16526019)(316002)(956004)(16576012)(6486002)(81166006)(186003)(2616005)(81156014)(52116002)(31696002)(26005)(478600001)(36756003)(86362001)(53546011)(66556008)(66946007)(2906002)(4326008)(8676002)(31686004)(66476007)(5660300002)(8936002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YBgdgpCOCbn+ydd7hDv96KOrWf45STphTZtM/zmmupj9sCaiDqh/lMGAQXqQKdY5yH33pyjTtpaWfijJKW9cwxbUEpMwEvOJppiLiVBhv0uuES1ETIZ1s4PBhD/PgNc/vBHUez+kL/t637Xu+m1qwDcf3+0Cufc8KJGBOp43HbHYham8fEkOB4kblQTOw54LFG8yh6vLrV/azdrJ2PBm+lB6Co5OxHb0pugvohWWUAkSeYjhiO4uh3dGQewtWWQnCSm+VGunCzFG0TUGgskb2isGihlu4tIbsoHCpqGJppkSpRTsyx6QFdOMfUdxdV7SDTaeZgTmejRCVBbBm/oQQ9RO20y8rTZVbDcnSqHP8MNjJzGnuiVKigjEQFu3R8HRITYY3sC1y5Np0XzGBdE5dK6zLxGSEs55520E8/P28tkFzpMBLQtffdmYtQNpiY/n
X-MS-Exchange-AntiSpam-MessageData: MQs98SQVODSHtP4ApFI8a1BJbbUr5Igh3/LoZKbPaF8Q5lfFf0dqjO/gxshNl/PhWX07RkAqjKguhEa/fOhVLU16JLCMNDyad3U9X+E5QOXnDKdgUFxfzKnh6PoKtqHN2uJAHsVOhBUnZx3WJ6mdoQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe60a92c-29fa-458d-3ddf-08d7d60aad43
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 07:02:44.3185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2+0jQ2ljgPm4o66dFxm20iFO7sZJdlm4ctBfCmg8enwdaHSXaW8/MGMNB5VNf6VL2TfCOISCUXMpIkS+35FDUkKKj4k8TWiXaMTUB0em3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3713
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.118
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



On 01.04.2020 08:49, Vladimir Sementsov-Ogievskiy wrote:
> 31.03.2020 20:44, Denis Plotnikov wrote:
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
>
> [..]
>
>> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const void *sr=
c, size_t src_size)
>> +{
>> +=C2=A0=C2=A0=C2=A0 ssize_t ret;
>> +=C2=A0=C2=A0=C2=A0 size_t zstd_ret =3D 0;
>> +=C2=A0=C2=A0=C2=A0 ZSTD_outBuffer output =3D { dest, dest_size, 0 };
>> +=C2=A0=C2=A0=C2=A0 ZSTD_inBuffer input =3D { src, src_size, 0 };
>> +=C2=A0=C2=A0=C2=A0 ZSTD_CCtx *cctx =3D ZSTD_createCCtx();
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!cctx) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * We want to use zstd streamed interface on de=
compression,
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * as we won't know the exact size of the compr=
essed data.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * In the loop, we try to compress all the data=
 into one zstd=20
>> frame.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * ZSTD_compressStream2 potentially can finish =
a frame earlier
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * than the full input data is consumed. That's=
 why we are looping
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * until all the input data is consumed.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 while (input.pos < input.size) {
>
> zstd_ret may be defined here.
yep!
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * ZSTD spec: "You must=
 continue calling ZSTD_compressStream2()
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * with ZSTD_e_end unti=
l it returns 0, at which point you are
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * free to start a new =
frame". We assume that "start a new=20
>> frame"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * means call ZSTD_comp=
ressStream2 in the very beginning or=20
>> when
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * ZSTD_compressStream2=
 has returned with 0.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do {
>
> Hmm. Why did you decide to use nested loop?=C2=A0 Ok, it works too.
The previous condition was error prone. It led to loop ending once we=20
finished the "first frame"
but there could be a number of them.
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zstd=
_ret =3D ZSTD_compressStream2(cctx, &output, &input,=20
>> ZSTD_e_end);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
ZSTD_isError(zstd_ret)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D -EIO;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto out;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* D=
est buffer isn't big enough to store compressed=20
>> content */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
zstd_ret > output.size - output.pos) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOMEM;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto out;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } while (zstd_ret);
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 /* make sure we can safely return compressed buffer =
size with=20
>> ssize_t */
>> +=C2=A0=C2=A0=C2=A0 assert(output.pos <=3D SSIZE_MAX);
>> +=C2=A0=C2=A0=C2=A0 ret =3D output.pos;
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
>
> You forget to fix ret here. ret of the function should be ssize_t and for
> ZSTD - size_t.
I decided not to use two vars since we can return only 0 or -EIO. I=20
added an assert at the very end of the function to check it.

>
>> +=C2=A0=C2=A0=C2=A0 ZSTD_outBuffer output =3D { dest, dest_size, 0 };
>> +=C2=A0=C2=A0=C2=A0 ZSTD_inBuffer input =3D { src, src_size, 0 };
>> +=C2=A0=C2=A0=C2=A0 ZSTD_DCtx *dctx =3D ZSTD_createDCtx();
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!dctx) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The compressed stream from input buffer may =
consist from more
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * than one zstd frames. So we iterate until we=
 get a fully
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * uncompressed cluster.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * from zstd docs related to ZSTD_decompressStr=
eam:
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * "return : 0 when a frame is completely decod=
ed and fully=20
>> flushed"
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * We suppose that this means: each time ZSTD_d=
ecompressStream=20
>> reads
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * only ONE full frame and return 0 if and only=
 if that frame
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * is completely decoded and flushed. Only afte=
r returning 0,
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * ZSTD_decompressStream reads another ONE full=
 frame.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 while (output.pos < output.size) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t last_in_pos =3D input=
.pos;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t last_out_pos =3D outp=
ut.pos;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ZSTD_decompressStrea=
m(dctx, &output, &input);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * zstd manual doesn't =
explicitly states what happens,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * if ZSTD_decompressSt=
ream reads the frame partially.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * But, based on our te=
sts, if we don't fully populate
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the output and have =
read all the frames from the input,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * we end up with error=
 here.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ZSTD_isError(ret)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D -EIO;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * As ZSTD manual is va=
gue about what to do if it
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * reads the buffer par=
tially, we afraid of case
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * when we stuck in the=
 infinite loop, because
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * output isn't full an=
d input has read partially, so
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * ZSTD_decompressStrea=
m returns > 0 waiting for
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * another input chunk.=
 So, we add a paranoid check
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * that on each step th=
e loop makes some progress.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (last_in_pos >=3D input.p=
os &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last=
_out_pos >=3D output.pos) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D -EIO;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Make sure that we have the frame fully flush=
ed here
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * if not, we somehow managed to get uncompress=
ed cluster
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * greater then the cluster size, possibly beca=
use of its
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * damage.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (ret > 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EIO;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 ZSTD_freeDCtx(dctx);
>> +=C2=A0=C2=A0=C2=A0 assert(ret =3D=3D 0 || ret =3D=3D -EIO);
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>
>
> [..]
>
>


