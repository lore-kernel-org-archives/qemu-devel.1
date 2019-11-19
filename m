Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A15C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EB17222D1
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="N/1+icJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB17222D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX2Nv-0004yT-Ht
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 07:13:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iX2My-0004IL-HE
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:12:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iX2Mx-0006Jm-24
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:12:32 -0500
Received: from mail-eopbgr80123.outbound.protection.outlook.com
 ([40.107.8.123]:59556 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iX2Mw-0006Fm-JS; Tue, 19 Nov 2019 07:12:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YA5AMM87Tzc/XDetngFEGTqVZ9GwwyEbSkg8+scAiSnD63K7Svrvsjc005735rsokYZpBwSOB6IiaekeSxmqam+8MysMDO/iI01UdZa8J+JWhX1CPA36r6NuoElW1Moewad4KkvgRvbO1ohf/K9oGNOWpdRGe5dHajnIyHG6NTG3BXA5yGb0KFhtVb0uraoJ7zAKwnTVbeNySoyP6eTajY66i3OjrhZjJGslUdtoosJ2Ny17bqRDU892b4rry3EQAH1Sc7/oCYhdzXymIU/UZMgRpSdu+JXxwXgeXQEHuRCVG102njTDjkceIJJWdMLPPYGU5uCqg83nMAm/qvHPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJo6xMoISuOwjG1Oo7Zj9r5DZZK2jPXbrsJhZ3fertM=;
 b=OgSRNVfs8uEybST0PQjFIzX1hBMAEESf2Io1w82/0vEhan3/9utYWZncmsZTxOExlhW5twl/P5st+ERKEbU5G3jZ7ApgwGCOMFnzRkOZzYoBFUSbYAUrVeoMsDWPgthZaSYOE4Mycj7J7N5bCdXaXqKSqf4w/7ffbSkpFGw5dVSqZJQGrutd2HWZwX1C1a8Nr8abcJr1PtUSstYG+61x9Wk81pA8pjHZREfZsfd5hW9dLWPxHiB3TzNsHxjdmMLE06mDObGcoqdDv+xbuRWC4COOyl9dOoWiIeKWaAl+ZoiSnMBTgdB2yyAzC+in59jYLApfSsfArBEJBrDXxV2FrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJo6xMoISuOwjG1Oo7Zj9r5DZZK2jPXbrsJhZ3fertM=;
 b=N/1+icJYp7akbQYZdyq0iA41PLQ1rjugP7Msv7leJfxpFQVYuj6un/rCKKTqW1C63Vo8+FSPiefvxb34ett+xUQXOhjiqoVbDvBivXB24gYjux3CDIOTIJzNRbsDCfOWPJmPsRpktDphGwDYvfTWi2oLyuAO7nvKQIf7qWY2ujQ=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4216.eurprd08.prod.outlook.com (20.178.90.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 19 Nov 2019 12:12:24 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 12:12:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Denis Lunev <den@virtuozzo.com>, Max Reitz <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Topic: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Index: AQHVnJu0qDM7Hy9Fo0iUR1ci8onW5KeSTT2AgAAb/oCAAAK/AA==
Date: Tue, 19 Nov 2019 12:12:23 +0000
Message-ID: <6e8c975f-da75-4890-ad08-2453f5805f6e@virtuozzo.com>
References: <20191116163410.12129-1-vsementsov@virtuozzo.com>
 <09d0bab1-ed7d-4fd7-555d-93075f10d497@redhat.com>
 <6b0811ec-822e-1c4a-1512-d6f3945645d2@openvz.org>
In-Reply-To: <6b0811ec-822e-1c4a-1512-d6f3945645d2@openvz.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0242.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::18) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191119151222054
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a812e5f-bdd4-4edd-d007-08d76ce9bc33
x-ms-traffictypediagnostic: AM6PR08MB4216:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB42166C4FEBD0960949750771C14C0@AM6PR08MB4216.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(376002)(39840400004)(396003)(366004)(53754006)(199004)(189003)(52116002)(99286004)(31686004)(71200400001)(3846002)(6512007)(71190400001)(14444005)(26005)(256004)(5660300002)(6116002)(11346002)(486006)(2616005)(476003)(6246003)(6436002)(76176011)(36756003)(2501003)(25786009)(102836004)(8936002)(2906002)(6486002)(8676002)(81156014)(229853002)(81166006)(64756008)(316002)(7736002)(305945005)(6506007)(66476007)(66556008)(53546011)(4326008)(66446008)(386003)(66066001)(14454004)(478600001)(110136005)(86362001)(66946007)(186003)(446003)(54906003)(31696002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4216;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IBOErsz6RxmaSccrNGYwVJms6E1+FiVQFYiZ5DwcdukC7m9RKdyHPQg47DZLHG9yjNXTnPh5D6FV6CzZUZEDIufRN2vNFmPj30mHht+81IYRWmg1eYZC4EW4JjZYSuuQ82PNNy6gOAmUxfn3xSVSMAeVBilKQ5M02wCS8Az4NvM8VZ7TKqlMcLCAAkYPk0/82NlCLkihJ7d1CjE+jeeMIKCUoIxuN1y7gaiJ7HSSfvywAlen4vOv+ex5FsbDyPY6fB//ngKM+0Swa+FQXimNo0uZu+CIKGvxDtvJJbFpz2pfTC9gEXRUl1exaTHG8vJcrZUz9112z3n5jydRCi6julWWl6NHnhNJ7qqmnePYaootgTlshqImTHHW+/t/girjNekmF/4UKMRZ9FfGf2AetCMNA6C3PXmDqQGqlMONrSlIwXfXNE8Yw1LDEEYhEEKq
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <3C612921B46ECF4AA5A64E77F816E9DB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a812e5f-bdd4-4edd-d007-08d76ce9bc33
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 12:12:23.9105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jtI/zWKiH0Xd4La/Mmg700VXsuMa6wB02ZgvYsbSsZzVhmwioFOrk49YsD+phW94HlWK8pKn75VrmUOSxEKb0a+OQr06egnU62MpS3NAYl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4216
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.123
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

19.11.2019 15:02, Denis Lunev wrote:
> On 11/19/19 1:22 PM, Max Reitz wrote:
>> On 16.11.19 17:34, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi all!
>>>
>>> I wanted to understand, what is the real difference between bdrv_block_=
status_above
>>> and bdrv_is_allocated_above, IMHO bdrv_is_allocated_above should work t=
hrough
>>> bdrv_block_status_above..
>>>
>>> And I found the problem: bdrv_is_allocated_above considers space after =
EOF as
>>> UNALLOCATED for intermediate nodes..
>>>
>>> UNALLOCATED is not about allocation at fs level, but about should we go=
 to backing or
>>> not.. And it seems incorrect for me, as in case of short backing file, =
we'll read
>>> zeroes after EOF, instead of going further by backing chain.
>> Should we, though?  It absolutely makes sense to me to consider post-EOF
>> space as unallocated because, well, it is as unallocated as it gets.
>>
>> So from my POV it would make more sense to fall back to the backing file
>> for post-EOF reads.
>>
>> OTOH, I don=92t know whether changing that behavior would qualify as a
>> possible security issue now, because maybe someone has sensitive
>> information in the tail of some disk and then truncated the overlay so
>> as to hide it?  But honestly, that seems ridiculous and I can=92t imagin=
e
>> people to do that.  (It would work only for the tail, and why not just
>> write zeroes there, which works everywhere?)  So in practice I don=92t
>> believe that to be a problem.
>>
>> Max
>=20
> That seems to be wrong from my POW. Once we get block device truncated,
> it exposed that tail to the guest with all zeroes.
>=20
> Let us assume that we have virtual disk of length L. We create new top
> delta of
> length X (less then L) and new top delta after with length Y (more than L=
),
> like the following:
>=20
> [.........................] Y
> [........] X
> [...................] L
>=20
> Once the guest creates FS=A0 on state Y it relies on the fact that data f=
rom X
> to Y is all zeroes.
>=20
> Any operations with backing chain must keep guest content to be tha same,
> i.e. if we commit from Y to L, virtual disk content should be preserved,
> i.e.
> read as all zero even if there is some data in L from X to L.
>=20
> If we commit from X to Y, the range from X to L should remain all zeroes.
>=20
> This is especially valid for backups, which can not be changed and are
> validated by the software from time to time.
>=20
> Does this makes sense?
>=20
> Den
>=20

Yes, if we consider space after EOF as unallocated, incremental backups are=
 broken,
consider the following sequence:

starting with disk of size L
full backup -> state BASE
shrink disk to size X
incremental backup to empty qcow2 of size X, with backing to BASE -> state =
INC1
expand disk to size Y
incremental backup to empty qcow2 of size Y, with backing to INC1 -> state =
INC2

Now, if we read from backup INC2, we'll see data from BASE in range [X, L],=
 which
we must not see.


INC2 [.........................] Y
INC1 [........] X
BASE [...................] L


Also, this example shows, that these series fixes real use-case: merge of s=
ome
incremental backups (by commit).

--=20
Best regards,
Vladimir

