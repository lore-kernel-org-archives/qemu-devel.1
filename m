Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C125C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:42:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 742462072F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="n1jpvqhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 742462072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHnNg-00058J-ES
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 07:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jHnMR-00048C-OX
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jHnMP-0004fO-Q0
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:41:15 -0400
Received: from mail-eopbgr150110.outbound.protection.outlook.com
 ([40.107.15.110]:57737 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jHnMG-00049L-Gx; Fri, 27 Mar 2020 07:41:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGCsR428K0fvnjxDBVtjzQ/+78yS5CbWY30JzBGWk6cZUuUS5PYcy+7vYzyf9RdHuVBLYLbQMOtV1DtK15vapTuUHcAzzY0C/wi6nY8oN8mAZj5ftTY7PE0bBhqwoKyrMyxtJEtTJ4cffaQ0NBvlcMxyRMNpSOSdiktx04UlYz/eXbbE+2nHMJSDjDWeXYmfZNM1SI01xjA//zInYbGtTp18FCLBvQjxtLaJ9zDUhV3IYASkmc3o2Ix4+TjhjlQPlbaEINLNJi/hxu5ZKVXQ/u3Xn8SoWnY491iZUT532cg/ph5r6FaAjXQhFD2+wCIpC3Q45Mn0qmllYQ9tuJfQQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJRIEp+VY7MNyCpLMhIYclkikojOGrszbcXAKs15LzY=;
 b=MPe6osQ51jwkyz7fifBlGstM5tqotMGcSEVf7T8CSeCPaVJLz585k+ottcsk+8FWZSXCKV7KTQC8TMbbue2TWsPy4tt+UzGNGWLmvkQIYAD3qCE7nqwORZiIKwlJvwaIGZAR4LMbdXy1/55CvBCqXQ6J9yFZ1JAKFp2tiZzKOQeaesyIM+0wUXZ0b0VoRJQ5S819BBMX7voQ6OF5W/R5lGz8bZXnKpu+/hZeoglz/IE01nmoug/ExRUmKobCRgyoXsWAO6TmNTcH0f138oWrR/PLQUxfq2Gt5nC19LFKx2FCTJ3nnDoqga55rmImWgmvw5HydidoP9Q7Q9LI4nitlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJRIEp+VY7MNyCpLMhIYclkikojOGrszbcXAKs15LzY=;
 b=n1jpvqhrAC8JzgaBJus2CfTmBRf+nzd6ez4d0Im6F2OfxBssVWQZHKlFfdpqAQNzDWcTSyi2dKpxoNlTHWWnsQ5cjnkxswJx28XppYJvEdUxQHQCaIg0ATeTpDmuv3Q4rJTlbO4zKwtisswfbsuMDbh2QYs64qpMVAO/TTf8qTI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5304.eurprd08.prod.outlook.com (10.141.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Fri, 27 Mar 2020 11:41:01 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.023; Fri, 27 Mar 2020
 11:41:01 +0000
Subject: Re: [PATCH v9 3/4] qcow2: add zstd cluster compression
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200323142558.15473-1-dplotnikov@virtuozzo.com>
 <20200323142558.15473-4-dplotnikov@virtuozzo.com>
 <9ad0aa8d-b813-ae3a-2d4e-d1573e9cb582@virtuozzo.com>
 <662cb9bd-5528-ca4e-8698-40c8cd414f33@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200327144059712
Message-ID: <41db1889-ed08-9322-b67a-697fa0d95f12@virtuozzo.com>
Date: Fri, 27 Mar 2020 14:40:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <662cb9bd-5528-ca4e-8698-40c8cd414f33@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: ZR0P278CA0041.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::10) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.35) by
 ZR0P278CA0041.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18 via Frontend Transport; Fri, 27 Mar 2020 11:41:00 +0000
X-Tagtoolbar-Keys: D20200327144059712
X-Originating-IP: [185.215.60.35]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8af80868-cf35-42b5-48a1-08d7d243b99b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5304:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5304674EDA796206750810ECC1CC0@AM7PR08MB5304.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(136003)(346002)(376002)(39850400004)(366004)(478600001)(2906002)(66946007)(956004)(53546011)(81156014)(316002)(36756003)(81166006)(66556008)(86362001)(52116002)(2616005)(66476007)(6486002)(31686004)(5660300002)(8676002)(16576012)(966005)(26005)(31696002)(16526019)(4326008)(186003)(8936002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YxkXYmRlGbkV/+KftAsst5Wtho/a8e1gslBB1Pgy40AMjB96Dij5Cg/IJBR2+MbxGSGEDHei0OWwlVrPLnOlI9DHU1b2s869SvUlKeWM3ChxJofiVdabJFjQqNm8SQNi3yEWZ4uYAag+CRi6vZudy1fSjajqtDWuospWKImk1C4cSiG/8aaDqUVDkgbl5beThiiERRVSO1l8UNxn/ekb1QdZYl4LpzRWdX3wwfdHFd6DJsKj/RL116R7c+uf/bshHLEF9D3TwcoOr7Dz9F1giUGFgFSaYCTo+zZ3PW4Brd0hJuT1R7L42kGGzxcJHCrKWaoSqFDLqnRVXmMJBlYa8zLQkzXVLFI+AxvFVjhLWoRckoG1P6c89WcmTujuhh4rDfQXbgrpPGcydC9hjRcGS0qcac/V1zK6FT9RTrLdLoOek7DCNSjt1J5GTtzHVCX0bH2Yy7soCjYrEAgReQoI4e4Hr1bNtlK7B+8szjq2ikR0siLfrn3Uej668j80v80GyViTO3yPS1x2QQFxOtHSlw==
X-MS-Exchange-AntiSpam-MessageData: Q2YF/hR7MyrDSx39CceODvVsjb9GXxJbtEeAg4nkxpyt9kt+8A84qSXlorqRF/dBKAn84FFmTGxGFKS6lQf8Zoy/CIfdpS55C8qIisXmiOxnkGsQNmp/HX91sRGjJdhmICwzqzprymXwNZy0YVRmvA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af80868-cf35-42b5-48a1-08d7d243b99b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 11:41:01.6420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvyFRQwPFK+rCfyuYvweIyUchTQSZFCBRQGL6c1Qr4jDkUs8Xwb5TO3Q8UUvcfZwQHgXm8OI//w9SfPgWS7sa+xY6jrArGHnTIYGq6he7mY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5304
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.15.110
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

27.03.2020 12:40, Denis Plotnikov wrote:
>=20
>=20
> On 27.03.2020 11:43, Vladimir Sementsov-Ogievskiy wrote:
>> Should we note somehow in qcow2 spec that we use streamed version of zst=
d with specific end byte?
> We didn't do it for zlib. zstd does it the same way as zlib, saves the co=
mpression output to some buffer.

Looked through zstd format spec, I don't thing that there are may be any pr=
incipal difference between data
compressed by simple api or by streamed, so now I don't think that we need =
any additional comment.

>=20
>>
>> 23.03.2020 17:25, Denis Plotnikov wrote:
>>> zstd significantly reduces cluster compression time.
>>> It provides better compression performance maintaining
>>> the same level of the compression ratio in comparison with
>>> zlib, which, at the moment, is the only compression
>>> method available.
>>>
>>> The performance test results:
>>> Test compresses and decompresses qemu qcow2 image with just
>>> installed rhel-7.6 guest.
>>> Image cluster size: 64K. Image on disk size: 2.2G
>>>
>>> The test was conducted with brd disk to reduce the influence
>>> of disk subsystem to the test results.
>>> The results is given in seconds.
>>>
>>> compress cmd:
>>> =C2=A0=C2=A0 time ./qemu-img convert -O qcow2 -c -o compression_type=3D=
[zlib|zstd]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 src.img [zlib|zstd]_compressed.img
>>> decompress cmd
>>> =C2=A0=C2=A0 time ./qemu-img convert -O qcow2
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [zlib|zstd]_compressed.img uncompre=
ssed.img
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 comp=
ression=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 decompression
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zlib=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 zstd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 zlib=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zstd
>>> ------------------------------------------------------------
>>> real=C2=A0=C2=A0=C2=A0=C2=A0 65.5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=
6.3 (-75 %)=C2=A0=C2=A0=C2=A0 1.9=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 1.6 (-16 %)
>>> user=C2=A0=C2=A0=C2=A0=C2=A0 65.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=
5.8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.3=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.5
>>> sys=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.3=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0.2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 2.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.0
>>>
>>> Both ZLIB and ZSTD gave the same compression ratio: 1.57
>>> compressed image size in both cases: 1.4G
>>>
>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>> QAPI part:
>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>
>> [..]
>>
>>> +
>>> +/*
>>> + * qcow2_zstd_compress()
>>> + *
>>> + * Compress @src_size bytes of data using zstd compression method
>>> + *
>>> + * @dest - destination buffer, @dest_size bytes
>>> + * @src - source buffer, @src_size bytes
>>> + *
>>> + * Returns: compressed size on success
>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -ENOMEM desti=
nation buffer is not enough to store compressed data
>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -EIO=C2=A0=C2=
=A0=C2=A0 on any other error
>>> + */
>>> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const void *sr=
c, size_t src_size)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 size_t ret;
>>> +=C2=A0=C2=A0=C2=A0 ZSTD_outBuffer output =3D { dest, dest_size, 0 };
>>> +=C2=A0=C2=A0=C2=A0 ZSTD_inBuffer input =3D { src, src_size, 0 };
>>> +=C2=A0=C2=A0=C2=A0 ZSTD_CCtx *cctx =3D ZSTD_createCCtx();
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!cctx) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * ZSTD spec: "You must continue calling ZSTD_=
compressStream2()
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * with ZSTD_e_end until it returns 0, at whic=
h point you are
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * free to start a new frame"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * zstd simple interfa=
ce requires the exact compressed size.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * zstd stream interfa=
ce reads the comressed size from
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the compressed stre=
am frame.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Instruct zstd to co=
mpress the whole buffer and write
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the frame which inc=
ludes the compressed size.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This allows as to u=
se zstd streaming semantics and
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * don't store the com=
pressed size for the zstd decompression.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ZSTD_compressStream=
2(cctx, &output, &input, ZSTD_e_end);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ZSTD_isError(ret)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D -EIO;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o out;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Dest buffer isn't big en=
ough to store compressed content */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (output.pos + ret > outp=
ut.size) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D -ENOMEM;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o out;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 } while (ret);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* if no error, the input data must be fully consum=
ed */
>>> +=C2=A0=C2=A0=C2=A0 assert(input.pos =3D=3D input.size);
>>> +=C2=A0=C2=A0=C2=A0 /* make sure we can safely return compressed buffer=
 size with ssize_t *//z
>>> +=C2=A0=C2=A0=C2=A0 assert(output.pos <=3D SSIZE_MAX);
>>> +=C2=A0=C2=A0=C2=A0 ret =3D output.pos;
>>> +
>>> +out:
>>> +=C2=A0=C2=A0=C2=A0 ZSTD_freeCCtx(cctx);
>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>> +}
>>> +
>>> +/*
>>> + * qcow2_zstd_decompress()
>>> + *
>>> + * Decompress some data (not more than @src_size bytes) to produce exa=
ctly
>>> + * @dest_size bytes using zstd compression method
>>> + *
>>> + * @dest - destination buffer, @dest_size bytes
>>> + * @src - source buffer, @src_size bytes
>>> + *
>>> + * Returns: 0 on success
>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -EIO on any e=
rror
>>> + */
>>> +static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
nst void *src, size_t src_size)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 size_t ret =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 ZSTD_outBuffer output =3D { dest, dest_size, 0 };
>>> +=C2=A0=C2=A0=C2=A0 ZSTD_inBuffer input =3D { src, src_size, 0 };
>>> +=C2=A0=C2=A0=C2=A0 ZSTD_DCtx *dctx =3D ZSTD_createDCtx();
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!dctx) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ZSTD_decompressStre=
am(dctx, &output, &input);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ZSTD_isError(ret)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D -EIO;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o out;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Dest buffer size is=
 the image cluster size.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * It should be big en=
ough to store uncompressed content.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * There shouldn't be =
any cases when the decompressed content
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * size is greater the=
n the cluster size.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (output.pos + ret > outp=
ut.size) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D -EIO;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o out;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 } while (ret);
>>
>>
>> Hmm. Unfortunately, zstd spec is not enough verbose to understand how to=
 use
>> these functions :).
>>
>> But I found this in comment in https://github.com/facebook/zstd/blob/dev=
/examples/streaming_decompression.c :
>>
>> /* The return code is zero if the frame is complete, but there may
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * be multiple frames concatenated together.
> In our case, there should be the only frame as we stored it with ZSTD_com=
pressStream2(..., ZSTD_e_end)
> If explicitly state in the spec, that "zstd compressed cluster must conta=
in the only zstd compressed frame"
> On the other hand, we actually don't need such a restriction and we shoul=
d be able to decompress whatever is in the buffer (cluster)
> if it's zstd stream.
>=20
>>
>> so, I think it would be safer to move to "while (input.pos < input.size)=
" loop like in example.
> yes, I think It worth doing
>>
>> and drop next assertion. And possibly do same for compression to be cons=
istent (and safer?).
>>
>>
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If decompression went fine we must have the=
 compressed
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * cluster fully consumed and flushed
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 if (output.pos !=3D output.size) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EIO;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +out:
>>> +=C2=A0=C2=A0=C2=A0 ZSTD_freeDCtx(dctx);
>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>> +
>>> +}
>>> +#endif
>>> +
>>> =C2=A0 static int qcow2_compress_pool_func(void *opaque)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Qcow2CompressData *data =3D opaque;
>>> @@ -217,6 +341,11 @@ qcow2_co_compress(BlockDriverState *bs, void *dest=
, size_t dest_size,
>>
>>
>> [..]
>>
>>
>=20


--=20
Best regards,
Vladimir

