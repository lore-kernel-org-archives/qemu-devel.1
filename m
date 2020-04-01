Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD26C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 14:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B4820719
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 14:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="oMomtsTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B4820719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJeUA-00039o-Gs
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 10:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJeTD-00028q-RY
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 10:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJeTB-0002bX-GI
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 10:35:54 -0400
Received: from mail-eopbgr30096.outbound.protection.outlook.com
 ([40.107.3.96]:6560 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJeTA-0002Ys-UV; Wed, 01 Apr 2020 10:35:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8o0bFRt+ejfub1a4mePrszUBIi1NuvEWP7ziV+MMkGNo7eSllRgBPB4MgbJ3uS2jgk9hJNWXtstnVH616xYPXiqdRzwdAGA20MQwrkT/q0chQcEeHgHbZlph7OWnGIJdPnIyDKDGTMPiwjVZI6aF3Ql9LjuVeh5eDuseToOSElhN1QtcXVX10mbwhT4/txtLVF2pPqGUy8QJkqVHTLDtNzVus4hpuE+YY8gEC98lFQmW/vDPSBBT/CfxdKmBDekNwUZmDot+d5P0Dkv5upqZCClc+hh8apYMoOFOLA11CTPZ3ibJPSziIHW+iUNm3Li85ti2xPiXeYPhhGm+Yu8lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UC3u9ut13l3dOKDG9qSLk84DES2gN7e3FOTb7s501xs=;
 b=Ulm5FjVlTs64jzVD9OW2/gLMYCkBzmGAiGLm0JvpadgXVAQXNpbEPcpvoU5STuLzJHFsdOlOibwALg6Akzl+FIGKW6Q64Z3v+/d81tnRViDtKy+t5u22xYy/yt0Hj6T2i2iIQH6q/jzJL8Q2pPa7wtk6a/+luCnhABDpS00bH9gYt3HaCD9TFcF/MSjSF6ZNWo8K6N5dZEMqzW8GI4rLtEZaifnsBS4BlzQE23qnXFnJ0vkBnSsOpzq3MjJpcK5cqDbdJaALCpKRu7XGtMRj4eD6WPWEvH51g27hSm62ivwCfsdWdLjQjilmj7dIs/ik2kF4QOdREBYLq/DjjaAqVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UC3u9ut13l3dOKDG9qSLk84DES2gN7e3FOTb7s501xs=;
 b=oMomtsTB2fa5RwoTYfKINB8JCA7mdy/otubuykkpMi+8KMX2ZZFGR1aa29Vly0GSYWPBfZvjGsmTi0SVHymT2Q1PsO9PO4GT64uLCLK/kSsvs8EmStM6gq4BFuHRg/m/U+uagppa3uBvMR3P+L1RggOZ7GOoim5hsxo1DmY4+t8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5464.eurprd08.prod.outlook.com (10.141.173.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Wed, 1 Apr 2020 14:35:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.014; Wed, 1 Apr 2020
 14:35:50 +0000
Subject: Re: [PATCH 5/5] block/io: auto-no-fallback for write-zeroes
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200302100537.29058-1-vsementsov@virtuozzo.com>
 <20200302100537.29058-6-vsementsov@virtuozzo.com>
 <5e7f5649-c349-7d8e-f2a0-203cc53aa8cb@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200401173548229
Message-ID: <da83d8dd-cfbb-2add-8c1b-06bd6c895565@virtuozzo.com>
Date: Wed, 1 Apr 2020 17:35:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <5e7f5649-c349-7d8e-f2a0-203cc53aa8cb@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR0102CA0035.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:14::48) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.23) by
 AM0PR0102CA0035.eurprd01.prod.exchangelabs.com (2603:10a6:208:14::48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Wed, 1 Apr 2020 14:35:49 +0000
X-Tagtoolbar-Keys: D20200401173548229
X-Originating-IP: [185.215.60.23]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2502440e-cdbb-451d-74c8-08d7d649f996
X-MS-TrafficTypeDiagnostic: AM7PR08MB5464:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5464D4DBFE7F1A6DA3879061C1C90@AM7PR08MB5464.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(346002)(366004)(39840400004)(136003)(396003)(31696002)(81166006)(81156014)(107886003)(8676002)(53546011)(36756003)(52116002)(478600001)(86362001)(4326008)(66946007)(66476007)(6486002)(66556008)(16526019)(16576012)(2616005)(31686004)(2906002)(316002)(956004)(26005)(8936002)(5660300002)(186003);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T9H+7XiL9oTBcQ4CdV9IGyF9iozdMJ67f0Jl/5/Jl0ncmLE2RMJ2Kf1eicUf5tDmADe8ENBF80qx2R+OPXlJppxJOLrHxDkE/uMNqMkMDd8r6TuN+422oTYG5tFOfZdxn0SE0AomehjKTJ2PLQ6gE8+Gp1JkhvBQSjcWCH+FRCBXoxf0a7wVtdgGPGT5dpYjNkeg5kW7gDJrCnmyUhyKCNEfUfoMaSCJNneoZDvB0bkXrbV6CZZ6DHZJuZeme9dsrI1wpBIMDycm8c2FHH2PQaWtM5VXd+r1SRFpMlAQYudcY1CW0fWZSc9766myE6d81tyH95yAoT/LtvPxJPaWN0w1slcSruzXbpXsSmFyAOKmVpPgKdv3vTO7PAjUJ42omBEMrwN/mEsQaue2NCDEt5CuEmpVOfUW7zLuRdNFQ+kiy5OhcgyLrezZ4LbFuCCc
X-MS-Exchange-AntiSpam-MessageData: BKi88nnU45glAL00PPagSw6gTTZPl0Q/0XGmiuRJiaBpYNM+cNAHP8NE9OpqyZGuB9YxPMZBAeJdd3Vzd+8CWjrbWcV34qmrQrav1TJw0xlEsmVNooMMJoj5BklUPPcZGWgFUmx7Ne9xDdqCIQv47Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2502440e-cdbb-451d-74c8-08d7d649f996
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 14:35:50.6051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9+Z9Lr+iskHIC6K5XBAlKB5RJmeZvOU+Zk/C1pvKV9WuSpuunH62MRaPtzX3FUaZuJ5sXhP5H/napXui7Km/FEqXz9kBUYdSLFNyDCkuHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5464
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.96
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.03.2020 0:56, Eric Blake wrote:
> On 3/2/20 4:05 AM, Vladimir Sementsov-Ogievskiy wrote:
>> NBD driver may has max_pwrite_zeroes but doesn't has
>> max_pwrite_zeroes_no_fallback limit. This means, that (when
>> BDRV_REQ_NO_FALLBACK is supported) it is beneficial to try send request
>> with BDRV_REQ_NO_FALLBACK instead of splitting the request accordingly
>> to max_pwrite_zeroes.
>>
>> If failed, fallback to old behavior.
>=20
> Grammar:
>=20
> When BDRV_REQ_NO_FALLBACK is supported, the NBD driver supports a larger =
request size.=A0 Add code to try large zero requests with a NO_FALLBACK req=
uest prior to having to split a request into chunks according to max_pwrite=
_zeroes.
>=20
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =A0 block/io.c | 30 ++++++++++++++++++++++++++----
>> =A0 1 file changed, 26 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/io.c b/block/io.c
>> index c64566b4cf..48d71b0883 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -1752,17 +1752,28 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes=
(BlockDriverState *bs,
>> =A0=A0=A0=A0=A0 int head =3D 0;
>> =A0=A0=A0=A0=A0 int tail =3D 0;
>> -=A0=A0=A0 int max_write_zeroes =3D MIN_NON_ZERO((flags & BDRV_REQ_NO_FA=
LLBACK) ?
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bs->bl.max_pwrite_zeroes_n=
o_fallback :
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bs->bl.max_pwrite_zeroes, =
INT_MAX);
>> +=A0=A0=A0 int max_write_zeroes;
>> =A0=A0=A0=A0=A0 int alignment =3D MAX(bs->bl.pwrite_zeroes_alignment,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 bs->bl.request_alignment);
>> =A0=A0=A0=A0=A0 int max_transfer =3D MIN_NON_ZERO(bs->bl.max_transfer, M=
AX_BOUNCE_BUFFER);
>> +=A0=A0=A0 bool auto_no_fallback;
>> =A0=A0=A0=A0=A0 if (!drv) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOMEDIUM;
>> =A0=A0=A0=A0=A0 }
>> +=A0=A0=A0 if (!(flags & BDRV_REQ_NO_FALLBACK) &&
>> +=A0=A0=A0=A0=A0=A0=A0 (bs->supported_zero_flags & BDRV_REQ_NO_FALLBACK)=
 &&
>> +=A0=A0=A0=A0=A0=A0=A0 bs->bl.max_pwrite_zeroes &&
>> +=A0=A0=A0=A0=A0=A0=A0 bs->bl.max_pwrite_zeroes < bytes &&
>> +=A0=A0=A0=A0=A0=A0=A0 (bs->bl.max_pwrite_zeroes < bs->bl.max_pwrite_zer=
oes_no_fallback ||
>> +=A0=A0=A0=A0=A0=A0=A0=A0 bs->bl.max_pwrite_zeroes_no_fallback =3D=3D 0)=
)
>=20
> Why are we letting max_pwrite_zeroes_no_fallback ever be 0?=A0 It might b=
e more convenient if it is always guaranteed to be >=3D max_pwrite_zeroes b=
y the block layer.


All other limits may be 0 too, which means some default.. So, if we want to=
 set the default for max_pwrite_zeroes_no_fallback explicitly, I think we s=
hould do it for all other limits too. And it should be separate thing..

>=20
>> +=A0=A0=A0 {
>> +=A0=A0=A0=A0=A0=A0=A0 assert(drv->bdrv_co_pwrite_zeroes);
>> +=A0=A0=A0=A0=A0=A0=A0 flags |=3D BDRV_REQ_NO_FALLBACK;
>> +=A0=A0=A0=A0=A0=A0=A0 auto_no_fallback =3D true;
>> +=A0=A0=A0 }
>> +
>> =A0=A0=A0=A0=A0 if ((flags & ~bs->supported_zero_flags) & BDRV_REQ_NO_FA=
LLBACK) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOTSUP;
>> =A0=A0=A0=A0=A0 }
>> @@ -1770,7 +1781,11 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(=
BlockDriverState *bs,
>> =A0=A0=A0=A0=A0 assert(alignment % bs->bl.request_alignment =3D=3D 0);
>> =A0=A0=A0=A0=A0 head =3D offset % alignment;
>> =A0=A0=A0=A0=A0 tail =3D (offset + bytes) % alignment;
>> -=A0=A0=A0 max_write_zeroes =3D QEMU_ALIGN_DOWN(max_write_zeroes, alignm=
ent);
>> +=A0=A0=A0 max_write_zeroes =3D
>> +=A0=A0=A0=A0=A0=A0=A0 QEMU_ALIGN_DOWN(MIN_NON_ZERO((flags & BDRV_REQ_NO=
_FALLBACK) ?
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bs->bl.max_pwrite_zeroes_no_fallbac=
k :
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bs->bl.max_pwrite_zeroes, INT_MAX),
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 a=
lignment);
>> =A0=A0=A0=A0=A0 assert(max_write_zeroes >=3D bs->bl.request_alignment);
>> =A0=A0=A0=A0=A0 while (bytes > 0 && !ret) {
>> @@ -1801,6 +1816,13 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(=
BlockDriverState *bs,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (drv->bdrv_co_pwrite_zeroes) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D drv->bdrv_co_pwrite_zero=
es(bs, offset, num,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 flags & =
bs->supported_zero_flags);
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret =3D=3D -ENOTSUP && auto_no_fa=
llback) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 flags &=3D ~BDRV_REQ_NO_F=
ALLBACK;
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_write_zeroes =3D
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 QEMU_ALIGN_DO=
WN(MIN_NON_ZERO(bs->bl.max_pwrite_zeroes,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 INT_MAX), alignment);
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret !=3D -ENOTSUP && (flags =
& BDRV_REQ_FUA) &&
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 !(bs->supported_zero=
_flags & BDRV_REQ_FUA)) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 need_flush =3D true;
>>
>=20
> Otherwise makes sense.
>=20


--=20
Best regards,
Vladimir

