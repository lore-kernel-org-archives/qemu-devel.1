Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945D7C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:21:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4915A20722
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JgrYMzrt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4915A20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGKDG-0000am-Ga
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 06:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60307)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jGKCZ-0008Vw-Aj
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jGKCX-00011L-4v
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:20:59 -0400
Received: from mail-eopbgr50132.outbound.protection.outlook.com
 ([40.107.5.132]:26731 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jGKCR-0000yJ-0u; Mon, 23 Mar 2020 06:20:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+nF4mNzgFnAGaF5O7v7/wmXdRz/yPUt2vIv51XNFWHBSzXBE2xSLB3FmgUD0LaEdjwwpgi63fSh973pfoNcvjJZ8OpmLxuYegwexWZj7tAHrHwjUjRIvn92Me6y77yxR8x6uRl/n+Ilvs3X7DPzH9HOu5djRJMqUAHo5lPuBBnKkbdRwIm+FJeq4WDg1591+IxK5qHpz4386QmTFJxjPmcx9exKlB8IMz9qcGj+87MmaLMI93454c+KKZHvy+Mto00HO+9LcFV3gIoW9v+NZBpdGyrYKvFqjMN7bm5qxx1LHLNfm1DeDzB+zl82cuwRFj5qs3jTeL08z209nh95BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D55qaFC8xAAArlI4cAPjDnDUjZqf0u1nOKxwYz0W5z8=;
 b=UJREvtsmi/06lu/dLzQ603T30WCMjCasfijyn8Jzw1fXEm0cuensFmpSSSj631NXPuIaFmNP9bYCMbgSd0YYP35Y79+zxPNmMi7sqjGO2mS4XHf/keon0YsuZc1WQRqVA80Wpfl2AmUMA06J9uItR3w9bzZTd7fCr17fhscVqrrNbEPPHfISTulOYJKbuSA/eNq0mk72KxfJzTWFsCR0Y5kY5zMUC7CaYJnktVgp+Ks5ESyPNLaYsvkigOpKkjPH8AtRWS7uK1yJHtWmODs/UxwxVIhzsfKQx8kKYnDUK6cODQgHZERFTAyl5Nbnomo/OLYJjdjg7gSSDKZnrtbjbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D55qaFC8xAAArlI4cAPjDnDUjZqf0u1nOKxwYz0W5z8=;
 b=JgrYMzrtKMecx2hQJ3y+cgVNJ0Fp+01gFBbiPqlWYTWIFmlqgjWe8huqn4EB0TLe5FZwTnYlhS787OS4r3O9nL+ZwsYhFCq3L697J4ytkPVAfnaAE9syHnwQp5YN7ssokY6vrrMrYFOekHd1P4OQowgYJ8l1sJ7v3sfd7OVnPvc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from VI1PR08MB3760.eurprd08.prod.outlook.com (20.178.80.91) by
 VI1PR08MB4448.eurprd08.prod.outlook.com (20.179.26.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Mon, 23 Mar 2020 10:20:47 +0000
Received: from VI1PR08MB3760.eurprd08.prod.outlook.com
 ([fe80::acf5:3103:8e4d:af20]) by VI1PR08MB3760.eurprd08.prod.outlook.com
 ([fe80::acf5:3103:8e4d:af20%7]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 10:20:47 +0000
Subject: Re: [PATCH v8 3/4] qcow2: add zstd cluster compression
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200321143431.19629-1-dplotnikov@virtuozzo.com>
 <20200321143431.19629-4-dplotnikov@virtuozzo.com>
 <a1830b65-bd38-c458-d382-1f3981355d2e@virtuozzo.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <2914bee8-50b9-2759-7dda-8f5fd39e5fa5@virtuozzo.com>
Date: Mon, 23 Mar 2020 13:20:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <a1830b65-bd38-c458-d382-1f3981355d2e@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: HE1PR0501CA0012.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::22) To VI1PR08MB3760.eurprd08.prod.outlook.com
 (2603:10a6:803:c1::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (94.255.82.30) by
 HE1PR0501CA0012.eurprd05.prod.outlook.com (2603:10a6:3:1a::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18 via Frontend Transport; Mon, 23 Mar 2020 10:20:45 +0000
X-Originating-IP: [94.255.82.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf7ab631-3cad-4fc3-f874-08d7cf13da2b
X-MS-TrafficTypeDiagnostic: VI1PR08MB4448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB4448810897A59BFF2FBD2699CFF00@VI1PR08MB4448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(376002)(396003)(39840400004)(136003)(366004)(199004)(8936002)(16526019)(19273905006)(81156014)(81166006)(8676002)(36756003)(66946007)(16576012)(6666004)(316002)(66476007)(66556008)(2906002)(5660300002)(2616005)(956004)(186003)(86362001)(30864003)(26005)(31696002)(6486002)(31686004)(53546011)(52116002)(4326008)(478600001)(563064011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4448;
 H:VI1PR08MB3760.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fy7hWQTK1eJTNi0R/YOk5dYwSVmm3akD8Rz1RxWCyn7ZFt9jELsNQq03a/WuwSe7xGbva2NomRIRkKBsXFWgx+zIpzyvCcOXoJRSAs/mrUJryomG7zsrIxJJC1EGHIFr8drSI6M/ACQ80CzJUpShAXslwNkCzWx/lzSGNgO7zTAcuSSe3mSprA3j9FRIPfiRRPhxq3UVXpCrXTF1l/o+RCxTuiQr+iI2QXMxBJCZSzuhIjVrqv1YeO23XKJUqAo/vXFsXaPoZMYzY9OZnf9jLSZ2mqaR+1Rx7HKupzZrquE7e9e+btKtLe7lHzeDEESbP/FxgYHLnUzhbEI68ttQpQND7JagRhrteFroi6qjUHG8f9lBVAGVeQMy3uRpxNyhWfF6WswcbrPy2sHYTfiGTCXdgIfmvdfKIpjaAzmC4/eSDKtYGhFPTiJyg0tenLDZNK70He9waWl10F+RBm9pjFQtyzeEQz8/2tR/SPuH9m0lYtPIzAMoTnr1nJWLiDxKmKFrPpIvbvxCLE0gBE/VBWvAikT6RLXoIWEXwkpc0rO1Y43xEt6txeROfrGhaNTn
X-MS-Exchange-AntiSpam-MessageData: UKCoumFJAE6yPHwQXKdzyMtGn/WHyIPK/P57VcNQ4w8Yk49sRWWRtOICP57WgXS5gA99j9+HUqMw4VgJlsOCZoMUTUTiW2v/R2xBdC/9N2Dk5VsRrItw4UcGjjr5rkcAN45iWwsITC2XZgZKadoU7g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7ab631-3cad-4fc3-f874-08d7cf13da2b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 10:20:47.0905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwcELo5mYAOmXrngPGu7DsuyjucOvFIzlixtzi3jy38rziZZGeu1X4gObov+z/JGR+TMRXf8sOLt6J80woC5BPLHejsvgHxnVbElK5WzmEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4448
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.132
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



On 23.03.2020 11:44, Vladimir Sementsov-Ogievskiy wrote:
> 21.03.2020 17:34, Denis Plotnikov wrote:
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
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>> QAPI part:
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>
> You forget to drop signs, patch is changed significantly, including=20
> algorithm.
ok, my fault
>
>> ---
>> =C2=A0 docs/interop/qcow2.txt |=C2=A0=C2=A0 1 +
>> =C2=A0 configure=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 qapi/block-core.json=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
>> =C2=A0 block/qcow2-threads.c=C2=A0 | 129 +++++++++++++++++++++++++++++++=
++++++++++
>> =C2=A0 block/qcow2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 7 +++
>> =C2=A0 5 files changed, 140 insertions(+), 2 deletions(-)
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
>> index caa65f5883..b2a0aa241a 100755
>> --- a/configure
>> +++ b/configure
>> @@ -1835,7 +1835,7 @@ disabled with --disable-FEATURE, default is=20
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
>> index a306484973..8953451818 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -4401,11 +4401,12 @@
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
>> index 7dbaf53489..ee4bad8d5b 100644
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
>> @@ -166,6 +171,120 @@ static ssize_t qcow2_zlib_decompress(void=20
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
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D ZSTD_CCtx_setParameter(cctx, ZSTD_c_compress=
ionLevel,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ZSTD_CLEVEL_DEFAULT);
>
> Hmm, looks a bit strange.. Isn't it already default by default?)
Should I remove it? Doesn't worth to express that explicitly? This line=20
removes the question what compression level is used.
And gives a hint where to change it ,if we decide to implement=20
compression ratio changing.
>
>> +=C2=A0=C2=A0=C2=A0 if (ZSTD_isError(ret)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EIO;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>
> Hmm, strange that we need a loop, but zstd spec directly requires it,=20
> possibly we need to make a comment from it:
>
> =C2=A0 "ZSTD spec: You must continue calling ZSTD_compressStream2() with=
=20
> ZSTD_e_flush until it returns 0, at which point you can change the=20
> operation."
ok
>
>> +=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Instruct zstd to com=
press the whole buffer and write
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the frame epilogue. =
This allows as to use zstd streaming
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * semantics and don't =
store the compressed size for the
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * zstd decompression.
>
> May be not "to don't store", but to "decompress without knowing exact=20
> compressed data length" or something like this. I mean, make the=20
> comment for people who read the final code, not for those who review=20
> changes from version to version.
I'd better write

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * zstd simple interface r=
equires exact compressed size.
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * zstd stream interface h=
olds all the data in the compressed=20
frame.
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Instruct zstd to compre=
ss the whole buffer and write
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the frame epilogue. Thi=
s allows as to use zstd streaming
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * semantics and don't sto=
re the compressed size for the
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * zstd decompression.
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ZSTD_compressStream2=
(cctx, &output , &input, ZSTD_e_end);
>
> extra whitespace
>
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
>> ssize_t */
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
>
> But consider corrupted image: it may contain any data. And we should=20
> not crash because of it. So, we should return error here.
If the image is corrupted we can't continue anyway. If we return -EIO on=20
this condition, we need to do some work investigating what has happened.=20
Assert explicitly points out what happened. I though we should return=20
-EIO if we know what to do with the error. But if the invariant doesn't=20
hold, do we really know what to do rather then stop the execution and=20
report an error?
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(output.pos + ret <=3D=
 output.size);
>> +=C2=A0=C2=A0=C2=A0 } while (ret);
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If decompression went fine we must have the =
compressed
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * cluser fully consumed and flushed
>
> cluster
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 assert(output.pos =3D=3D output.size);
>
> again, it should be EIO, not crash.
>
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
>> @@ -217,6 +336,11 @@ qcow2_co_compress(BlockDriverState *bs, void=20
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
>> @@ -249,6 +373,11 @@ qcow2_co_decompress(BlockDriverState *bs, void=20
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
>> index 899b5541f5..6420d27a6d 100644
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
>> @@ -3454,6 +3457,10 @@ qcow2_co_create(BlockdevCreateOptions=20
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


