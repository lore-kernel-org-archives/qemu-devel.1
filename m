Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2955BC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:05:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7DE820780
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HaAe7mbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7DE820780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIvym-0000bT-0K
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 11:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jIvxg-000858-Ma
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jIvxe-0006OI-93
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:04:24 -0400
Received: from mail-db8eur05on2126.outbound.protection.outlook.com
 ([40.107.20.126]:24320 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jIvxW-0006CS-7g; Mon, 30 Mar 2020 11:04:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDzA72E3K7p41cBIgfv/rKjVhOCNyUB/3ijsxib/0godbSQW1BliRZDP3e5nQdXnP6UMOniZoYPvV53U500C+RJhiugTAgFglpuvWJ54GGV6uvAfm3RPfvsMHf2rJdmluMHpIke2DG0ZIr5USAjm/ny2mY4oEk6f/x5vVi5zCWRy+8jkyb93MDDqWoIemK/CYqwJkqBv4TdGqHyCcVRR6dNhC8Xqfdt9jLIhNmU6xumw4L/i/nzQFtb+K94kDPE9oBmQlpODWWo0guzl28hWHF8VD1LpaHHYU1JEmH0csx26syv75ue/2DqCJko0L74ds2Mz/lfXw3Cv2KluR86FvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/NaBWn0g/fPIvQ+DDfFa3bn3mv4V5w6B8rfvX5coLA=;
 b=AfTQaHuRRpvFBoVPBQ5W7eCpKnhltuQ8aInMHE889DaHI+DrSPATmijx4iQpf+ydkSb2naEVu0qG4yXM5Ss0h0FllHpcx7wMkOqDGihF496xrzNmoZGESnIg5k+yLoY6a6jNkS5UP+iPc5i9cc9eAIqMdekZvUnDybxwpmhCbdijs9ptuXV9xSTNobb0iubHdXmBc07M1ZofjedE8WSFGtPUNS4Jxz4dfJlOHPo4qUJWdpiHwVM4Au3b1J5d3qfE5qqKtgStwS5Q5N7KBmRA2cHXSAf170TaOoDm2UL6wdI7+pj+zlda0mViRTi7zRG5SlwmPKBo98tLI1hTxr0nwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/NaBWn0g/fPIvQ+DDfFa3bn3mv4V5w6B8rfvX5coLA=;
 b=HaAe7mbkF+xLBdEwbJhAScwAOWtzRVSnsHZ7+YVpCMtvV0B7MDHyQ3RRnpjavRcHEIk1yMHQW+O8P+5M1oef/AmaiqOPZJUaJdRQ8rmRP1nnM/nRWej8hshF7LbPi+JissKvxb/i/htsFzd6D+xdZh6vHA7nL7qsUyPFjl9GdaE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB4340.eurprd08.prod.outlook.com (20.179.32.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Mon, 30 Mar 2020 15:04:11 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f%4]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 15:04:11 +0000
Subject: Re: [PATCH v11 3/4] qcow2: add zstd cluster compression
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200330095429.26974-1-dplotnikov@virtuozzo.com>
 <20200330095429.26974-4-dplotnikov@virtuozzo.com>
 <3c367b69-0db7-bac6-6ea8-915114df1e01@virtuozzo.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <83d7a7f3-2fdd-2546-1e63-297d8c404496@virtuozzo.com>
Date: Mon, 30 Mar 2020 18:04:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <3c367b69-0db7-bac6-6ea8-915114df1e01@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: AM0PR07CA0025.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::38) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.150.115) by
 AM0PR07CA0025.eurprd07.prod.outlook.com (2603:10a6:208:ac::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.12 via Frontend Transport; Mon, 30 Mar 2020 15:04:10 +0000
X-Originating-IP: [178.34.150.115]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5dd295c-f98f-47b5-8e5a-08d7d4bb9aa8
X-MS-TrafficTypeDiagnostic: AM0PR08MB4340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB43405A1FF1D1CDA5121B4CBACFCB0@AM0PR08MB4340.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(39840400004)(366004)(346002)(136003)(396003)(6486002)(5660300002)(66556008)(66476007)(66946007)(2616005)(2906002)(956004)(16576012)(26005)(16526019)(8936002)(316002)(31686004)(186003)(81156014)(478600001)(36756003)(8676002)(81166006)(53546011)(4326008)(86362001)(19273905006)(30864003)(31696002)(52116002)(563064011);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lhfZNd21+enDhnYkWIo5KKAAuC3xvvicrAaaUXQvzCG1YP/FcG844dr/hTQd8sYxg5TKSrVULzRAr/cfyOJFyfbAO5PA5Xc/dPXegjBoIIWcWWeFIfX5UXyG6eQnBCRVu4O4kyLmdmQ5XRsQE4gzlwy3np/K4lhR5BtxMQK4mo5UWIggA3+roZAtFbr9aqwegus3JnzI1/vKKcS+3GFQhrrZSCGBSfKPNi22eFpDS/px58ppDWC8LyYJcm5rpn3M6BGrYZcWasvqLLptRcqt3i1TS8XzK/p3iniD9/kgxqoMXQSvFm9J0oqYSJnFOsyC6usHUXi3ALVYrKoVoqDjFwU33jxGj9fIJqD1NdRMtZqpuweFX7ltadlHHhhtPw0+woM/U98ZeALQMXAVUblvb5RIf7Kk54FyVFCDj06v8E0tHlU3PxFakWKdp9dj55KoOOYqxTHhTT6ggGdIxv5bA4/RkFiwCInP1me86a/CI7LYDRy0yJj6OMWPWRf5bGnJusXYES6Rp+QkCFODMqbx6khvE9VNebETu/zx2LQQRe7UHOaTLV/AAb1eyY24EfQS
X-MS-Exchange-AntiSpam-MessageData: jK/T0hrhnrTEenq+OjQc7YYLgDngg7561xNXW7AM/NtL/cPaQIPHiN+LvgEeibcLckttTDtsdEnTEhHZxeHEE+8TbhOkztDmfnbMWav7fauS3cVIfIwTHCIpsQ29S4kfos/Z9uzi2z6aRXmu7AgeGg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5dd295c-f98f-47b5-8e5a-08d7d4bb9aa8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 15:04:11.6594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VO3MiW3HuKI3eApHrJuYOvFxqyClDyxtY5j7yBfYK0hP8GZBt66OdZACcjqxY1SVJq1xSYW5+CnKylP97FwxvwW5RJU31hp1QHN3/6nvrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4340
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.126
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



On 30.03.2020 16:14, Vladimir Sementsov-Ogievskiy wrote:
> 30.03.2020 12:54, Denis Plotnikov wrote:
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
>> =C2=A0 docs/interop/qcow2.txt |=C2=A0=C2=A0 1 +
>> =C2=A0 configure=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 qapi/block-core.json=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
>> =C2=A0 block/qcow2-threads.c=C2=A0 | 138 +++++++++++++++++++++++++++++++=
++++++++++
>> =C2=A0 block/qcow2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 7 +++
>> =C2=A0 5 files changed, 149 insertions(+), 2 deletions(-)
>>
>> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
>> index 5597e24474..795dbb21dd 100644
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
>> diff --git a/configure b/configure
>> index da09c35895..57cac2abe1 100755
>> --- a/configure
>> +++ b/configure
>> @@ -1861,7 +1861,7 @@ disabled with --disable-FEATURE, default is=20
>> enabled if available:
>> =C2=A0=C2=A0=C2=A0 lzfse=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 support of lzfse compression library
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (for reading lzfse-compressed dm=
g images)
>> =C2=A0=C2=A0=C2=A0 zstd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 support for zstd compression library
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (for migration compression)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (for migration compression and qcow2 clus=
ter=20
>> compression)
>> =C2=A0=C2=A0=C2=A0 seccomp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 seccomp support
>> =C2=A0=C2=A0=C2=A0 coroutine-pool=C2=A0 coroutine freelist (better perfo=
rmance)
>> =C2=A0=C2=A0=C2=A0 glusterfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Gluster=
FS backend
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index d669ec0965..44690ed266 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -4293,11 +4293,12 @@
>> =C2=A0 # Compression type used in qcow2 image file
>> =C2=A0 #
>> =C2=A0 # @zlib: zlib compression, see <http://zlib.net/>
>> +# @zstd: zstd compression, see <http://github.com/facebook/zstd>
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
>> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
>> index 7dbaf53489..b8ccd97009 100644
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
>> @@ -166,6 +171,129 @@ static ssize_t qcow2_zlib_decompress(void=20
>> *dest, size_t dest_size,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>> =C2=A0 +#ifdef CONFIG_ZSTD
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
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * free to start a new frame".
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * In the loop, we try to compress all the data=
 into one zstd=20
>> frame.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * ZSTD_compressStream2 can potentially finish =
a frame earlier
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * than the full input data is consumed. That's=
 why we are looping
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * until all the input data is consumed.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 while (input.pos < input.size) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * zstd simple interfac=
e requires the exact compressed size.
>
> on decompression you mean
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * zstd stream interfac=
e reads the comressed size from
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the compressed strea=
m frame.
>
> compressed size is not stored in the stream. I think, that streamed
> interface just decompress until it have something to decompress and
> have space to write output.
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Instruct zstd to com=
press the whole buffer and write
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the frame which incl=
udes the compressed size.
>
> I think this is wrong. compression size is not written.
Ok
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This allows as to us=
e zstd streaming semantics and
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * don't store the comp=
ressed size for the zstd decompression.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>
> Comment is just outdated. Accordingly to our off-list discussion, I'd
> rewrite it like this:
>
> We want to use streamed interface on decompression, as we will not know
> exact size of compression data.=20
This one is better then mine.
> Use streamed interface for compression
> just for symmetry.
I think this one is exceeding. If we have stream family functions on=20
both sides this won't rise any questions from the reader.

>
>
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
>
> Here you use "@return provides a minimum amount of data remaining to=20
> be flushed from internal buffers
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or an =
error code, which can be tested using ZSTD_isError()."
>
> I think we can safely drop this check
No, we can't.
we should check for if zstd managed to write the stream correctly.=20
ZSTD_compressStream2 may consume all the input buffer but return ret > 0=20
meaning that it needs more space.

This is from my tests:

(gdb) p ret
$1 =3D 11
(gdb) p input
$2 =3D {src =3D 0x562305536000, size =3D 65536, pos =3D 65536}
(gdb) p output
$3 =3D {dst =3D 0x562305546000, size =3D 65535, pos =3D 65535}

Alternatively, we can replace the check with something like

if (ret !=3D 0) {
 =C2=A0=C2=A0=C2=A0 ret =3D -ENOMEM;
}

after the loop, but I think both are equivalent, so I would stick with=20
my one :)))
> work anyway.
>
>> +=C2=A0=C2=A0=C2=A0 };
>> +
>> +=C2=A0=C2=A0=C2=A0 /* make sure we can safely return compressed buffer =
size with=20
>> ssize_t */
>> +=C2=A0=C2=A0=C2=A0 assert(output.pos <=3D SSIZE_MAX);
>
> Hmm. I hope it's not possible for cluster. But taking the function in=20
> separate, it _is_ possible.
> So may be better to assert at function start that
>
> =C2=A0 assert(dest_size <=3D SSIZE_MAX);
>
> To stress, that this limitation is part of qcow2_zstd_compress()=20
> interface.
Agree, this is better
>
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
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The compressed stream from input buffer may =
consist from more
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * than one zstd frames. So we iterate until we=
 get a fully
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * uncompressed cluster.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 while (output.pos < output.size) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ZSTD_decompressStrea=
m(dctx, &output, &input);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * if we don't fully po=
pulate the output but have read
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * all the frames from =
the input, we end up with error
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * here
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ZSTD_isError(ret)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D -EIO;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Dest buffer size is =
the image cluster size.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * It should be big eno=
ugh to store uncompressed content.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * There shouldn't be a=
ny cases when the decompressed content
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * size is greater then=
 the cluster size, except cluster
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * damaging.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (output.pos + ret > outpu=
t.size) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D -EIO;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> But here, you use
> "
> or any other value > 0, which means there is still some decoding or=20
> flushing to do to complete current frame :
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the return value is a suggested nex=
t=20
> input size (just a hint for better latency)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 that will never request more than t=
he=20
> remaining frame size.
> "
>
> I'm afraid that "just a hint" is not safe API to make a conclusion=20
> from. So, I'd prefer to drop this optimization
> and just wait for an error from next ZSTD_decompressStream.
>
> And therefore, for symmetry drop similar optimization on compression=20
> part..
>
> What do you think?
I'd add some kind of check that we have finished with ret=3D=3D0 (after=20
loop). It looks like this is the only case when we can be sure that=20
everything went ok.
>
>
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 ZSTD_freeDCtx(dctx);
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +#endif
>> +
>> =C2=A0 static int qcow2_compress_pool_func(void *opaque)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Qcow2CompressData *data =3D opaque;
>> @@ -217,6 +345,11 @@ qcow2_co_compress(BlockDriverState *bs, void=20
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
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abort();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -249,6 +382,11 @@ qcow2_co_decompress(BlockDriverState *bs, void=20
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
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abort();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 643698934d..6632daf50b 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -1246,6 +1246,9 @@ static int=20
>> validate_compression_type(BDRVQcow2State *s, Error **errp)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (s->compression_type) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case QCOW2_COMPRESSION_TYPE_ZLIB:
>> +#ifdef CONFIG_ZSTD
>> +=C2=A0=C2=A0=C2=A0 case QCOW2_COMPRESSION_TYPE_ZSTD:
>> +#endif
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>> @@ -3461,6 +3464,10 @@ qcow2_co_create(BlockdevCreateOptions=20
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
=C2=A0 error_setg(errp, "Unknown compression type");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto out;
>>
>
>


