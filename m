Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F9EC35249
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 08:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CFE82072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 08:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Xn5TsruM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CFE82072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izGFL-0004B1-Fd
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 03:41:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izGEF-0003aW-0w
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 03:40:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izGEC-00086N-SP
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 03:40:10 -0500
Received: from mail-eopbgr140105.outbound.protection.outlook.com
 ([40.107.14.105]:12430 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1izGE8-0007HY-45; Wed, 05 Feb 2020 03:40:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRG/P4rcGppgoEryeVrIKEKV5M3tEppWHbcp3woasq8GJrECupCvr5kW8vvt9PszfOd9ScDBdy3iMychd0mw45ya6MDPS12IeWw5fBkkR6SGxctsTwiOxzWgRsSCnHK24l5mcbyRl6PtjY9EjbDkv7qZZhHKYRWIvyxViLKTWnig7RuFwsTrOxe8124dnGOA6k7F0iefHsXuSf3SS0UxL3rR9630IoYagG6uCesY08FIiT1zaO4zTqNRP8ypfTRw3+un2oQnwzvixqA0tF427kcKVErPvKlzS7GEVdoQsZx2gD0l0uDRC7GxBdbuBtt+ugEOW3xDeOzyI8fMhG87iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9xTl+6gu6u2lVmwihi4gGcFxyB24S3TIhWzZytzrf4=;
 b=LWnvGZuvNEaEiZFgQMLOS0sQP4Ca3DNbwE51R+odlnPKa9apCjS/RAPlqeTWEek8k8q8dnL0kdOAzdj4CCZxloaDR0fU1iU/KdMKOhnKzPkPUecQFF/KVHKgKpNFBEEyQZIX7tPASg2K6KNgft6nIQDM9+EYZ+iiMzGWizHEyhlxstUl1tl0xkjsbMmdsHwRgca9vNczYcTkX0A92P09TqWZNag+mVJLTa/2kbqHI19Xr7jIjVzZI8CaXQckjWx3JiZ8VC/ZVENz3soxBb4igmrSzS4xNjOCeFdDrH+RVNKlWBMU1QHTVnJZlZYK1XxzoUv7dVDWqvX2dHT8RLf3uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9xTl+6gu6u2lVmwihi4gGcFxyB24S3TIhWzZytzrf4=;
 b=Xn5TsruMCHUnAvXTb1LwElcRZM1Al426vI2OYEvEyE4K+indlqb2ti9sqGUNRxdsMUEQBjPd1IzZzwgxu8rGPpudAjZ8aYvefZgVDJSSm2htkwUhtDBtm48eaQTwNZZkZ299jrGbaqmXrCKUHvJYvQRLCFfZoY/p5pXWjZE7b0Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB3392.eurprd08.prod.outlook.com (20.177.58.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Wed, 5 Feb 2020 08:40:00 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::9c56:6d95:76d1:d0]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::9c56:6d95:76d1:d0%2]) with mapi id 15.20.2686.034; Wed, 5 Feb 2020
 08:40:00 +0000
Subject: Re: [PATCH 10/17] block: Add new BDRV_ZERO_OPEN flag
To: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-11-eblake@redhat.com>
 <d4df9a48-6fb6-3432-3189-54bb7c7bb20c@redhat.com>
 <5c19c0fe-f8d0-5011-7cc6-4bb46a46cedf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200205113957075
Message-ID: <b9f8144a-e9cc-6f2c-b4b2-1059c18b9d50@virtuozzo.com>
Date: Wed, 5 Feb 2020 11:39:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <5c19c0fe-f8d0-5011-7cc6-4bb46a46cedf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR05CA0133.eurprd05.prod.outlook.com
 (2603:10a6:7:28::20) To VI1PR08MB4432.eurprd08.prod.outlook.com
 (2603:10a6:803:102::10)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0133.eurprd05.prod.outlook.com (2603:10a6:7:28::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32 via Frontend Transport; Wed, 5 Feb 2020 08:39:59 +0000
X-Tagtoolbar-Keys: D20200205113957075
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3072f3c2-7a81-4ca7-39dd-08d7aa16fcd7
X-MS-TrafficTypeDiagnostic: VI1PR08MB3392:
X-Microsoft-Antispam-PRVS: <VI1PR08MB3392391118AFF1DCDAD40324C1020@VI1PR08MB3392.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0304E36CA3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(136003)(39850400004)(396003)(366004)(189003)(199004)(8676002)(81156014)(81166006)(8936002)(36756003)(52116002)(478600001)(5660300002)(6486002)(110136005)(2616005)(316002)(66476007)(31696002)(4326008)(16576012)(16526019)(2906002)(186003)(66556008)(53546011)(66946007)(86362001)(956004)(31686004)(26005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3392;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zajY9DXO4t1za1rYCGF6CeQQkugcj5MdbT14ouSmGMuCOwclHOi/DWa6NbwNHb4oFc5d5r7oIiz7a+JL10itNwhBJ8ene+H4qpfZhUvIYrNF7CVjULmln4ubd2NYAWMGZ9j505QyvufGcR1DyBX2EwNGOFG6kcGNcdQgED+y2WnMEgQQoy/Qb+JMf5OmpnrtmKjsHaFKlcpOyb9fFmpAtNQdyBvmgKTUd5JfNTsVyjc9b6eWAfvqQhCKe11Tg7q1URA69EhZLcSHMJmSayi2KkQzKEWXG3VyKWXVpny8LbE74wAd9n44bayVmGubVSVc6PrbwNjxcuKVkOtI2JLXFRONxcffJS4bs445ViEDYLaLkLfPQclCUhlGvHy4eRyzPCtooBdYXsXToTkwTn/Mf4gM3fvMxa+AWPiLsXUiS3fbF/kZi/29Irf/dJ9x3n73
X-MS-Exchange-AntiSpam-MessageData: SOsvJJyvvG3+ew32xyhQfLcx26cHBj0+RX7RRcQby+TTx4a8TjlN3pdGxpvN9ct8eSkb1lA7yP2OVl+11mLz3Ql/l+gL6TPLVjzOp3nNHnpzxAwclfHpzU3Oq9QXfleyhJTDWLZm1OZlqJPCZNotzg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3072f3c2-7a81-4ca7-39dd-08d7aa16fcd7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 08:40:00.5519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ROLiSD3nywaCgR+KaVDgOUBdXtxU50h2/Iw3P/aqtlScDLbYdKWV4e7rkcvcaCmj5bK3qTcjVENUWQ0z6etcq7aImH4/KkcGWCrwjEgLWFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3392
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.14.105
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
Cc: david.edmondson@oracle.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

04.02.2020 20:50, Eric Blake wrote:
> On 2/4/20 11:34 AM, Max Reitz wrote:
>=20
>>> +++ b/include/block/block.h
>>> @@ -105,6 +105,16 @@ typedef enum {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * for drivers that set .bdrv_co_tr=
uncate.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRV_ZERO_TRUNCATE=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D 0x2,
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * bdrv_known_zeroes() should include this bit=
 if an image is
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * known to read as all zeroes when first open=
ed; this bit should
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * not be relied on after any writes to the im=
age.
>>
>> Is there a good reason for this?=C2=A0 Because to me this screams like w=
e are
>> going to check this flag without ensuring that the image has actually
>> not been written to yet.=C2=A0 So if it=E2=80=99s generally easy for dri=
vers to stop
>> reporting this flag after a write, then maybe we should do so.
>=20
> In patch 15 (implementing things in qcow2), I actually wrote the driver t=
o return live results, rather than just open-time results, in part because =
writing the bit to persistent storage in qcow2 means that the bit must be a=
ccurate, without relying on the block layer's help.
>=20
> But my pending NBD patch (not posted yet, but will be soon), the proposal=
 I'm making for the NBD protocol itself is just open-time, not live, and so=
 it would be more work than necessary to make the NBD driver report live re=
sults.
>=20
> But it seems like it should be easy enough to also patch the block layer =
itself to guarantee that callers of bdrv_known_zeroes() cannot see this bit=
 set if the block layer has been used in any non-zero transaction, by repea=
ting the same logic as used in qcow2 to kill the bit (any write/write_compr=
essed/bdrv_copy clear the bit, any trim clears the bit if the driver does n=
ot guarantee trim reads as zero, any truncate clears the bit if the driver =
does not guarantee truncate reads as zero, etc). Basically, the block layer=
 would cache the results of .bdrv_known_zeroes during .bdrv_co_open, bdrv_c=
o_pwrite() and friends would update that cache, and and bdrv_known_zeroes()=
 would report the cached value rather than a fresh call to .bdrv_known_zero=
es.
>=20
> Are we worried enough about clients of this interface to make the block l=
ayer more robust?=C2=A0 (From the maintenance standpoint, the more the bloc=
k layer guarantees, the easier it is to write code that uses the block laye=
r; but there is the counter-argument that making the block layer track whet=
her an image has been modified means a [slight] penalty to every write requ=
est to update the boolean.)
>=20

I'm for functions is_all_zero(), vs is_it_was_all_zeros_when_opened(). I ne=
ver liked places in code where is_zero_init() used like is_disk_zero(), wit=
hout any checks, that the drive was not modified, or even created by use.

--=20
Best regards,
Vladimir

