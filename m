Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84440C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF16206CC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ia5Q65pd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF16206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXU7H-00036N-53
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 12:50:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXU6U-0002Ss-0a
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:49:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXU6S-0001EY-Dy
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:49:21 -0500
Received: from mail-eopbgr40122.outbound.protection.outlook.com
 ([40.107.4.122]:21998 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iXU6O-0001DQ-MM; Wed, 20 Nov 2019 12:49:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxR1/bZ6k7+FTynKtbHqXHXMTn9HPneE8WyS/0GzCJXPuCVBJq7TmklAd/bOfgv5urxvO5N6HX9gBsePZ1Qah7KS6dQnKvy3tiVku0walZMV4YzH6+uxEdmxG/sWVECdZIEUIoKtZ8fxEbF4FlQ4wnXcQFkZbGbjMmptxps2gVvBvJrULUnBr6eRKMwfYzV5w5WmiStPjH6S6DDWBeLyNOEtqaK/tBq5cVy5uPN5mWYDqHZY9mQIJZfYRj1hoiQ5hEhELHlbY5i4HhZfdlHpS7FQWbYwnuEoj8U7TemNXYFFVdHxQfD15mCczvB0UjfwdwqEl+qLSeE6rkj3XX1FvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXxIXNdiD+9sBndmXII7o8r0ySg2Mn4515katX2jGrI=;
 b=QufrXS/aZC2DlBUzHq299japFzNu4mQMGv7QNGJqhawj9jRcqoOyjWbFVmbWc2BTd2uo24IVten3HHbk+YxDe9FxhvjaSd1Dk2qcDGMM1FyjyV8wtjh8jVshfoa3W3/TlePRuslPIZdUzJ/xdf+klssOj3SBHzCq8/FRKR69bmvzhYd7UcFsZDd2C9m7P0M1+nkP+eY0Qqz2VTBrBMiBpa9ttMTwZ+hADvDb3e6p4MhbgpHtQFyiohm/3vLOPOO9VVirpurmAkLYJWdCdk/K0Lrjlq8DjqAAs8VPNzMChHzAAJW94L5xu1RLwwkHAx3Hxs0EgTywemOipcTbNOxifA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXxIXNdiD+9sBndmXII7o8r0ySg2Mn4515katX2jGrI=;
 b=Ia5Q65pdwRAz+A6i4ZAIzCtvcyI/WIdXOutBo3bq6bec6jJFmR5JlbR2vsB0EaT0BSmZs62US9YnoR2sKA/PTXJbw66e2IvqQMDmkKS5uX8JeuLF/JbJ6pQBXmNUWvS7A/nDFZmcEtxJcX8bDMzBnXn8vefhfPr+wYTANMWxTHI=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4070.eurprd08.prod.outlook.com (20.179.0.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 20 Nov 2019 17:49:14 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 17:49:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: qcow2 preallocation and backing files
Thread-Topic: qcow2 preallocation and backing files
Thread-Index: AQHVn5wABMjtyQWeikidTGAJT/kh76eT/KGAgAAvq4CAAAs2gIAADV8AgAARiIA=
Date: Wed, 20 Nov 2019 17:49:13 +0000
Message-ID: <7b6df6bc-92ec-21c0-2598-3dc5cdd2a2d8@virtuozzo.com>
References: <20191120120625.GA25497@igalia.com>
 <a1575e90-3fe4-e843-518c-714db4b621bc@virtuozzo.com>
 <w517e3u8tks.fsf@maestria.local.igalia.com>
 <5b57fb5b-4480-2b39-9c60-bbd63f13f1cb@virtuozzo.com>
 <20191120164626.GF5779@linux.fritz.box>
In-Reply-To: <20191120164626.GF5779@linux.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0002.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::12) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191120204911339
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 417739cf-b08d-4872-291b-08d76de1f4c6
x-ms-traffictypediagnostic: AM6PR08MB4070:
x-microsoft-antispam-prvs: <AM6PR08MB40709B55165D3845BD6A5815C14F0@AM6PR08MB4070.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(346002)(136003)(39850400004)(366004)(199004)(189003)(54094003)(51444003)(81166006)(76176011)(4326008)(14454004)(6486002)(52116002)(66556008)(102836004)(2906002)(6506007)(229853002)(5660300002)(386003)(11346002)(26005)(486006)(2616005)(476003)(54906003)(31696002)(6436002)(86362001)(6246003)(6916009)(6512007)(6116002)(316002)(3846002)(8676002)(7736002)(31686004)(66066001)(8936002)(305945005)(446003)(186003)(71190400001)(71200400001)(99286004)(14444005)(256004)(66946007)(478600001)(66446008)(64756008)(66476007)(36756003)(81156014)(25786009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4070;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t5VgDnTnkJHD4fC5roMzAKNhpO1omPnDfIkeMS8+DKuq6dXRoYsxKNzlfZrkPGiHNmiu3faFj6xdKugf7Mjug6BfNLDKgW1lZV1OD8KQniMAoESEeM1PqoCsAzZDVnIo2XGx0uDgqwWRVVs+10480qvySYV0iTcZ8IBHB5JrShlAwYzmoAQgdELnKFTABkZu2SKKUuywV+Mcya2rZwltN6o9rCOvq4dPxfRkz9gqhxiH5HRjBaoWZrFfdgr4eppGkkbbcfC1PBO5xtT7W4emEXl47SiVm/8gg00PJve8griRLheRLiupoj2EFtkT8XCgvLUy/zF5Yv15oUYSViUPEoDfOlz8R+4hZm4rIl9EhMm1UH9JkwLc7zbk0rLjZfikJVib9afsyrNv1fG0GDFm7k5QPGUv52TlKDC3A7JFaVSShMf6LUXvfFhWkM0PK3vz
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <97CC88D59860944E9725DB3D4DB72D01@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 417739cf-b08d-4872-291b-08d76de1f4c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 17:49:13.9410 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yys3lzejOR2Wcichnbd9LLptGG2+puj8gP7i8vlT4LjRivgii+bXy/F1P6fM+OjhtYKNyyQCOy3vXgVfRlsuaNhIGg8ayu8+8jWSFgLWMNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4070
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.122
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
Cc: Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.11.2019 19:46, Kevin Wolf wrote:
> Am 20.11.2019 um 16:58 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 20.11.2019 18:18, Alberto Garcia wrote:
>>> On Wed 20 Nov 2019 01:27:53 PM CET, Vladimir Semeeausntsov-Ogievskiy wr=
ote:
>>>
>>>> 3. Also, the latter way is inconsistent with discard. Discarded
>>>> regions returns zeroes, not clusters from backing. I think discard and
>>>> truncate should behave in the same safe zero way.
>>>
>>> But then PREALLOC_MODE_OFF implies that the L2 metadata should be
>>> preallocated (all clusters should be QCOW2_CLUSTER_ZERO_PLAIN), at leas=
t
>>> when there is a backing file.
>>>
>>> Or maybe we just forbid PREALLOC_MODE_OFF during resize if there is a
>>> backing file ?
>>>
>>
>> Kevin proposed a fix that alters PREALLOC_MODE_OFF behavior if there is
>> a backing file, to allocate L2 metadata with ZERO clusters..
>>
>> I don't think that it's the best thing to do, but it's already done,
>> it works and seems appropriate for rc3..
>>
>> I see now, that change PREALLOC_MODE_OFF behavior may break things,
>> first of all qemu-img create, which creating UNALLOCATED qcow2 by
>> default for years.
>=20
> And it still does, because the backing file is added only after giving
> the qcow2 image the right size.
>=20
> But you're right, this is more accidental than by design. I wonder if
> there are other problematic cases (and whether merging something like
> this in -rc3 isn't rather risky).
>=20
>> Still, I think that it would be safer to always ZERO expanded part of
>> qcow2, regardless of backing file..
>>
>> We may add PREALLOC_MODE_ZERO, and use it in mirror, commit, and some
>> other calls to bdrv_truncate, except for qcow2 image creation of
>> course.
>=20
> What do we do with image formats that don't support zero clusters and
> therefore can't provide PREALLOC_MODE_ZERO? Will commit just fail for
> them?


Hmm. consider committing to raw

                        x     y
qcow2 [----------------------]  - full of unallocated clusters
raw   [2987957285235298]        - full of data, but file is short


Before commit, data from [x,y] reads as zero. Therefore, we should zero
expanded part of base..

And this is for base of any format: [x,y] must be zero after commit. So,
if format can't do fast-zero, it should fallback to writing real zeros.

=3D=3D=3D

Hmm, actually after your patch all formats partly support PREALLOC_MDOE_ZER=
O,
which in the worst case is done by writing real zeros.

>=20
>> Then, to improve this mode handling in qcow2, to not allocate all L2
>> tables, we may add "zero" bit to L1 table entry.
>=20
> This would be an incompatible image format change that needs to be
> explicitly enabled by the user. This might limit its usefulness a bit.
>=20

Yes, I understand this. Still it may make sense.


--=20
Best regards,
Vladimir

