Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6890DC2D0E8
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 07:57:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25CEA208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 07:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rZ2JYhcI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25CEA208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJBlg-0002bU-9L
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 03:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jJBks-00027k-Bz
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 03:56:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jJBkp-0000zY-TW
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 03:56:14 -0400
Received: from mail-eopbgr20137.outbound.protection.outlook.com
 ([40.107.2.137]:46242 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jJBkj-0000w3-CO; Tue, 31 Mar 2020 03:56:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrPXxeG8a3YTTLWqhloZzsZpdQdpBFpOIwuCZWV86sSGsoOcV4EdrzJKTIC6RXhXuAYWVEyzBlQKmyO5KWC/YdlrSX4zhyb0Zza7Hlmivgucmj2oAneb+mKhCb+dZCG7UKBdczUTGMRXH4c3XrAm/YzHUgR7KZ1KQlAbKqCAsbbSJlcWf7j0AnTEmrP93+2I662rYY6AxEhZFvOintNV4wKB8pnT0dWCDo5Lu2dngBzRYjJKMkhc1UaTalYyTtKLkyKfPwj7fgR2rxoMdh6wniE8nVEgMr0FL+KciGskIUECYpVpj1/6QXkLPHxP2put6nD982uAmzY6kcUVKZ8kgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ta8aOO8lMWKU56P1vBXowktQNBkPzxGI+e8DFFZrAE0=;
 b=DvpyjaAnBHBBqLR55yMMjJphoEWin1ENnGZfyaJf7O9hVUBtpp5WIfy0pMNbO/0fcBffHo2dWtA8MVWdh/4o+ekVHgbX9CZpcI+lIC0+sNQOAgZgT3wM4+SYAFMv81/adL9pbAcnzr0Kfybw28AuuS/ZtaCjC8SMtPyJd9fBSV20jTqynIXLjFWTwXCXHnwK69hQjI8YqePKzGXtsV0pfl/TvzR6kAe8xJF6kxgOKxwr0kEcrQ1BlD8/16tWWNaoFwXxWuSNLd5oAu1zIGzxuKjPaTsosNkhcjXHr+UNHDdI4jTpP+tUK92upqo8w0NIZ+b1VINZHW+UO+1YY2dgjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ta8aOO8lMWKU56P1vBXowktQNBkPzxGI+e8DFFZrAE0=;
 b=rZ2JYhcIE8K9/2nJ9O+3ljg//mAE1JLkztD5IyYNazpcFFenXRcCbxvoq1MYkMrSoswWBWG51M6ROGrUkiQRkGf2ZRafkRG8nurElQyHS4XZzv+UY3t8OtV19pIUzB91tBhhe5EkqHaBZDJzQIrWyPdPVxcpmOTiAIERkxf1qHc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB4002.eurprd08.prod.outlook.com (20.178.202.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Tue, 31 Mar 2020 07:56:02 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f%4]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 07:56:02 +0000
Subject: Re: [PATCH v11 3/4] qcow2: add zstd cluster compression
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200330095429.26974-1-dplotnikov@virtuozzo.com>
 <20200330095429.26974-4-dplotnikov@virtuozzo.com>
 <3c367b69-0db7-bac6-6ea8-915114df1e01@virtuozzo.com>
 <83d7a7f3-2fdd-2546-1e63-297d8c404496@virtuozzo.com>
 <08227565-8b4a-f496-0d66-af339d0bd667@virtuozzo.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <9bc60573-975e-2c75-6c65-fc923a845538@virtuozzo.com>
Date: Tue, 31 Mar 2020 10:55:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <08227565-8b4a-f496-0d66-af339d0bd667@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0022.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::35) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.150.115) by
 AM0PR06CA0022.eurprd06.prod.outlook.com (2603:10a6:208:ab::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20 via Frontend Transport; Tue, 31 Mar 2020 07:56:00 +0000
X-Originating-IP: [178.34.150.115]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5f4d4ee-0c02-4324-8c57-08d7d548f4c3
X-MS-TrafficTypeDiagnostic: AM0PR08MB4002:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB400296A09EF5921B0303C177CFC80@AM0PR08MB4002.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0359162B6D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(366004)(376002)(346002)(136003)(396003)(39840400004)(186003)(5660300002)(19273905006)(2906002)(31686004)(4326008)(66476007)(66946007)(66556008)(8676002)(30864003)(8936002)(16576012)(2616005)(81156014)(16526019)(316002)(956004)(81166006)(26005)(478600001)(53546011)(36756003)(6486002)(31696002)(86362001)(52116002)(563064011);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vunqVVnX3LbjJw/RMuwDWqN8BfKw6+OdHAsezAUsGMVmMEKjs0zobGP8fr7nMVUEVSJCunrcAjBNTMiFyfFv6xF2afHuqLxMRGmhVa/eqHM0JNYPqdl7dp4CrwD6cjJXgFSGXTyX6jmmEj2+iSc5LRzf5qSQ/OaKVzzTlUxdEKRlYrugETiqTIpLXdwbzOOAvm6v/1w6iuuklBIaMakYZhvClDvPzo14c6xIvr2yBIBW0FNEayQhiLHJwDKWMTd2CmErlqiFVpAQkHrDQAlGsyFCw2LyhUmbeQa0/cOSyFcmXsJ9ErjNFiYUy9UhLjGc69sIIRb1R+gbO7vKpzCLyl+QnllbePf/1EwM9kGHT7vranBJJ7dJQrubLeJ+QCRDtbVjDs/C6+e7yCN/51Or0JmaXDIAKbCbwy0jsbw0gTPJrmMuj+98R5jGFgu4iLo+YNs0T+IQf5YGPqaHFytmcJEz56BvpyQM6ZiYeqeILOM5rbqc+OTQ8Swvbqpbr5DPcgkGf/hTJzd/k5dBO+VWQ84orFuELo/dtDZjXIv++jRDKMeVl3el054rn0umThWs
X-MS-Exchange-AntiSpam-MessageData: 2U70eUnfL5Ho5MeOZENmk4X/1PTn6faHnAOP9q6v0iWcocz74aOkVTqUvKnveIpvMmpca0r6sKzAYkChDC8e5fFWSrESV/MlkhaFmjycnokgOUGerKoAybkq2cfxRJevdi7fseniujqgpKwN9SbCgg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f4d4ee-0c02-4324-8c57-08d7d548f4c3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2020 07:56:02.1040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/5/PqngtlcbcFLc+VL8oPhffoTJUYgdyEwWfO4OINz1uhT8LZmmvMbLBOeZPwDMsTn5IcSOZqzhjzhi12rh9IK6iBYRvh5iN/7zkIaSFts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4002
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.2.137
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



On 31.03.2020 09:22, Vladimir Sementsov-Ogievskiy wrote:
> 30.03.2020 18:04, Denis Plotnikov wrote:
>>
>>
>> On 30.03.2020 16:14, Vladimir Sementsov-Ogievskiy wrote:
>>> 30.03.2020 12:54, Denis Plotnikov wrote:
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
>>>> QAPI part:
>>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>> =C2=A0 docs/interop/qcow2.txt |=C2=A0=C2=A0 1 +
>>>> =C2=A0 configure=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>>>> =C2=A0 qapi/block-core.json=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
>>>> =C2=A0 block/qcow2-threads.c=C2=A0 | 138=20
>>>> +++++++++++++++++++++++++++++++++++++++++
>>>> =C2=A0 block/qcow2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 7 +++
>>>> =C2=A0 5 files changed, 149 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
>>>> index 5597e24474..795dbb21dd 100644
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
>>>> diff --git a/configure b/configure
>>>> index da09c35895..57cac2abe1 100755
>>>> --- a/configure
>>>> +++ b/configure
>>>> @@ -1861,7 +1861,7 @@ disabled with --disable-FEATURE, default is=20
>>>> enabled if available:
>>>> =C2=A0=C2=A0=C2=A0 lzfse=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 support of lzfse compression library
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (for reading lzfse-compressed=
 dmg images)
>>>> =C2=A0=C2=A0=C2=A0 zstd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 support for zstd compression library
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (for migration compression)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (for migration compression and qcow2 clus=
ter=20
>>>> compression)
>>>> =C2=A0=C2=A0=C2=A0 seccomp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 seccomp support
>>>> =C2=A0=C2=A0=C2=A0 coroutine-pool=C2=A0 coroutine freelist (better per=
formance)
>>>> =C2=A0=C2=A0=C2=A0 glusterfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Glust=
erFS backend
>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>> index d669ec0965..44690ed266 100644
>>>> --- a/qapi/block-core.json
>>>> +++ b/qapi/block-core.json
>>>> @@ -4293,11 +4293,12 @@
>>>> =C2=A0 # Compression type used in qcow2 image file
>>>> =C2=A0 #
>>>> =C2=A0 # @zlib: zlib compression, see <http://zlib.net/>
>>>> +# @zstd: zstd compression, see <http://github.com/facebook/zstd>
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
>>>> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
>>>> index 7dbaf53489..b8ccd97009 100644
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
>>>> @@ -166,6 +171,129 @@ static ssize_t qcow2_zlib_decompress(void=20
>>>> *dest, size_t dest_size,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>> =C2=A0 }
>>>> =C2=A0 +#ifdef CONFIG_ZSTD
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
>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -ENOMEM dest=
ination buffer is not enough to store=20
>>>> compressed data
>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -EIO=C2=A0=
=C2=A0=C2=A0 on any other error
>>>> + */
>>>> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const void *sr=
c, size_t src_size)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 size_t ret;
>>>> +=C2=A0=C2=A0=C2=A0 ZSTD_outBuffer output =3D { dest, dest_size, 0 };
>>>> +=C2=A0=C2=A0=C2=A0 ZSTD_inBuffer input =3D { src, src_size, 0 };
>>>> +=C2=A0=C2=A0=C2=A0 ZSTD_CCtx *cctx =3D ZSTD_createCCtx();
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (!cctx) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * ZSTD spec: "You must continue calling ZSTD=
_compressStream2()
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * with ZSTD_e_end until it returns 0, at whi=
ch point you are
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * free to start a new frame".
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * In the loop, we try to compress all the da=
ta into one zstd=20
>>>> frame.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * ZSTD_compressStream2 can potentially finis=
h a frame earlier
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * than the full input data is consumed. That=
's why we are=20
>>>> looping
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * until all the input data is consumed.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 while (input.pos < input.size) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * zstd simple interf=
ace requires the exact compressed size.
>>>
>>> on decompression you mean
>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * zstd stream interf=
ace reads the comressed size from
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the compressed str=
eam frame.
>>>
>>> compressed size is not stored in the stream. I think, that streamed
>>> interface just decompress until it have something to decompress and
>>> have space to write output.
>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Instruct zstd to c=
ompress the whole buffer and write
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the frame which in=
cludes the compressed size.
>>>
>>> I think this is wrong. compression size is not written.
>> Ok
>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This allows as to =
use zstd streaming semantics and
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * don't store the co=
mpressed size for the zstd=20
>>>> decompression.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>
>>> Comment is just outdated. Accordingly to our off-list discussion, I'd
>>> rewrite it like this:
>>>
>>> We want to use streamed interface on decompression, as we will not know
>>> exact size of compression data.=20
>> This one is better then mine.
>>> Use streamed interface for compression
>>> just for symmetry.
>> I think this one is exceeding. If we have stream family functions on=20
>> both sides this won't rise any questions from the reader.
>>
>>>
>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ZSTD_compressStrea=
m2(cctx, &output, &input,=20
>>>> ZSTD_e_end);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ZSTD_isError(ret)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t =3D -EIO;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to out;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Dest buffer isn't big e=
nough to store compressed=20
>>>> content */
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (output.pos + ret > out=
put.size) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t =3D -ENOMEM;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to out;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> Here you use "@return provides a minimum amount of data remaining to=20
>>> be flushed from internal buffers
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or a=
n error code, which can be tested using=20
>>> ZSTD_isError()."
>>>
>>> I think we can safely drop this check
>> No, we can't.
>> we should check for if zstd managed to write the stream correctly.=20
>> ZSTD_compressStream2 may consume all the input buffer but return ret=20
>> > 0 meaning that it needs more space.
>
> Hmm, interesting thing. But your check doesn't protect us from it:
>
> Assume we have
>
> output.size =3D input.size =3D 64K
> output.pos =3D 64K
> input.pos =3D 10K
> ret =3D 10K
>
> - which means that all input is consumed, but we have some cached data=20
> (at least 10K) to flush.
>
> 10K + 10K =3D 20K < 64K, so your check will no lead to an error, but=20
> we'll exit the loop..
No, it does protect
you use incorrect formula: _input_.pos + ret < output.size

but the code is

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (output.pos + ret > output.s=
ize) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D=
 -ENOMEM;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto ou=
t;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }

so, 64K + 10K =3D 74K -> 74K > 64K (true) -> ret =3D -ENOMEM

>
> So, actually, what we need it two things:
>
> =C2=A0 1. input.pos =3D input.size, which means that all input is consume=
d
> =C2=A0 2. ret =3D 0, which means that all cached data flushed
>
> So we need something like
>
> do {
> =C2=A0=C2=A0 ret =3D ZSTD_compressStream2(cctx, &output, &input, ZDTD_e_e=
nd)
> =C2=A0=C2=A0 if (ZSTD_isError(ret)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EIO.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> =C2=A0=C2=A0 }
> } while (ret || input.pos < input.size);
>
>>
>> This is from my tests:
>>
>> (gdb) p ret
>> $1 =3D 11
>> (gdb) p input
>> $2 =3D {src =3D 0x562305536000, size =3D 65536, pos =3D 65536}
>> (gdb) p output
>> $3 =3D {dst =3D 0x562305546000, size =3D 65535, pos =3D 65535}
>>
>> Alternatively, we can replace the check with something like
>>
>> if (ret !=3D 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOMEM;
>> }
>
> It's not correct either, it's not an error: it just means that we need=20
> to flush a bit more data.
.. but we don't have space to do it, so it looks like -ENOMEM
>
>>
>> after the loop, but I think both are equivalent, so I would stick=20
>> with my one :)))
>>> work anyway.
>>>
>>>> +=C2=A0=C2=A0=C2=A0 };
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* make sure we can safely return compressed buffe=
r size with=20
>>>> ssize_t */
>>>> +=C2=A0=C2=A0=C2=A0 assert(output.pos <=3D SSIZE_MAX);
>>>
>>> Hmm. I hope it's not possible for cluster. But taking the function=20
>>> in separate, it _is_ possible.
>>> So may be better to assert at function start that
>>>
>>> =C2=A0 assert(dest_size <=3D SSIZE_MAX);
>>>
>>> To stress, that this limitation is part of qcow2_zstd_compress()=20
>>> interface.
>> Agree, this is better
>>>
>>>> +=C2=A0=C2=A0=C2=A0 ret =3D output.pos;
>>>> +
>>>> +out:
>>>> +=C2=A0=C2=A0=C2=A0 ZSTD_freeCCtx(cctx);
>>>> +=C2=A0=C2=A0=C2=A0 return ret;
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
>>>> +static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
nst void *src, size_t=20
>>>> src_size)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 size_t ret =3D 0;
>>>> +=C2=A0=C2=A0=C2=A0 ZSTD_outBuffer output =3D { dest, dest_size, 0 };
>>>> +=C2=A0=C2=A0=C2=A0 ZSTD_inBuffer input =3D { src, src_size, 0 };
>>>> +=C2=A0=C2=A0=C2=A0 ZSTD_DCtx *dctx =3D ZSTD_createDCtx();
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (!dctx) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The compressed stream from input buffer ma=
y consist from more
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * than one zstd frames. So we iterate until =
we get a fully
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * uncompressed cluster.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 while (output.pos < output.size) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ZSTD_decompressStr=
eam(dctx, &output, &input);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * if we don't fully =
populate the output but have read
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * all the frames fro=
m the input, we end up with error
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * here
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ZSTD_isError(ret)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t =3D -EIO;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Dest buffer size i=
s the image cluster size.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * It should be big e=
nough to store uncompressed content.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * There shouldn't be=
 any cases when the decompressed content
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * size is greater th=
en the cluster size, except cluster
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * damaging.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (output.pos + ret > out=
put.size) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t =3D -EIO;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> But here, you use
>>> "
>>> or any other value > 0, which means there is still some decoding or=20
>>> flushing to do to complete current frame :
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the return value is a suggested =
next=20
>>> input size (just a hint for better latency)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 that will never request more tha=
n=20
>>> the remaining frame size.
>>> "
>>>
>>> I'm afraid that "just a hint" is not safe API to make a conclusion=20
>>> from. So, I'd prefer to drop this optimization
>>> and just wait for an error from next ZSTD_decompressStream.
>>>
>>> And therefore, for symmetry drop similar optimization on compression=20
>>> part..
>>>
>>> What do you think?
>> I'd add some kind of check that we have finished with ret=3D=3D0 (after=
=20
>> loop). It looks like this is the only case when we can be sure that=20
>> everything went ok.
>
> I think, we should not check it. It is possible that compressed data=20
> of another cluster is starting below input end. Is it guaranteed that=20
> ZSTD_decompressStream will not start to decompress (or at least plan=20
> to do it) the next frame, which is unrelated to our cluster? I'm=20
> afraid it's not guaranteed, so we can get ret>0 when=20
> output.pos=3Doutput.size in correct situation. So I think it's safer not=
=20
> to add this final check for ret. Note that we are not protected from=20
> wrong data anyway.
Looking at zlib_compress implementation, yes it seems to be, so.
Ok, I'll drop the check.

>
>>>
>>>
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 ZSTD_freeDCtx(dctx);
>>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>>> +}
>>>> +#endif
>>>> +
>>>> =C2=A0 static int qcow2_compress_pool_func(void *opaque)
>>>> =C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Qcow2CompressData *data =3D opaque;
>>>> @@ -217,6 +345,11 @@ qcow2_co_compress(BlockDriverState *bs, void=20
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
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abort();
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> @@ -249,6 +382,11 @@ qcow2_co_decompress(BlockDriverState *bs, void=20
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
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abort();
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>>> index 643698934d..6632daf50b 100644
>>>> --- a/block/qcow2.c
>>>> +++ b/block/qcow2.c
>>>> @@ -1246,6 +1246,9 @@ static int=20
>>>> validate_compression_type(BDRVQcow2State *s, Error **errp)
>>>> =C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (s->compression_type) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case QCOW2_COMPRESSION_TYPE_ZLIB:
>>>> +#ifdef CONFIG_ZSTD
>>>> +=C2=A0=C2=A0=C2=A0 case QCOW2_COMPRESSION_TYPE_ZSTD:
>>>> +#endif
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>>>> @@ -3461,6 +3464,10 @@ qcow2_co_create(BlockdevCreateOptions=20
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
=A0=C2=A0 error_setg(errp, "Unknown compression type");
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto out;
>>>>
>>>
>>>
>>
>
>


