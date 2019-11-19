Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4ABC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:35:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28766222A4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="lzF9McXQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28766222A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX2iz-00023E-Bp
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 07:35:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iX2gW-0000Pv-Mw
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:32:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iX2gV-0008De-74
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:32:44 -0500
Received: from mail-eopbgr00135.outbound.protection.outlook.com
 ([40.107.0.135]:28801 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iX2gV-0008DF-0X; Tue, 19 Nov 2019 07:32:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxiHw+cDSX6Pw4kw1K3qONdSqY1e3PSbDtwyXoO7ARDyRE5NR7/IdyGPEIVvImNTJVBHbo09uSRtDJjerI2yxL+ckRFiWgjtBeupr7kEYdKofa5x0iVWlBq3BhhrywrHNajJ0SCfjPWAskruYu2F9z3hOEjqwYvGeKwuYdvrqOARNnhEpdAkwXtvErW3OiBpIicUqGrfpzvFG+VxFXovwGSKJpgmkUFrhJFUKTl+I52Lh7MgBjS4hhd6cbk5fCQYDMUwTj/LjX49BzkPWUpFes6VQ3Z1Adhi6siMpixmOGz57ucyKFfvOZs0bK7Ry/lufoXKr82soI3R3hUJO8Dmrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2b94kC0I370ulogWScwh/7PO7I5UTmCSwDHcs+tYY8A=;
 b=KFq6GwF2YPhxsfwU5G/q1if0//M4lt9uoAPS8ouqZJDeq4Q9pGlfaF8/NT3drKas23Iu9KeGhxJZ7b5YxjDWytbpEEfIjrBFglieNpMT1LMor3liZWlgXIh3XQnc6Hh6obHY3bxdcV/4hgez6uxXkHeiz3FenxqU4sI0ec+uS/Pn2u3Xs8zFlLdrGXOkHXu6iwG7UnVv9B7/GwU4a+KdRx8crC4HU1gjJzWbyGtik1ZU0TnjCzMSN7hXs21vCfkHHQwGfrC+TzcEDS6ykBFiAnvl8YvctF8KhImxOXSCma7lh67mVkbB71OO7ghAPBF2reThKhkDfWLoJIXh/RTYJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2b94kC0I370ulogWScwh/7PO7I5UTmCSwDHcs+tYY8A=;
 b=lzF9McXQi1BkhioDglQkwlj1FUDT593guhYi3eB8keQncJk2xeNaXa2UfIZQRblsX2YNm6mRg4e3U/a2l3nmiLC8FShsKXR+mxzLPegI79N9LSBgUR6XKBQ78bOOnTvbDqZrGlhv+3ZMJodPKRzAYOvUWClfO2MAL6BMfuiHXYw=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5192.eurprd08.prod.outlook.com (10.255.34.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Tue, 19 Nov 2019 12:32:40 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 12:32:40 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Topic: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Index: AQHVnJu0qDM7Hy9Fo0iUR1ci8onW5KeSaikAgAADVICAAAQmAA==
Date: Tue, 19 Nov 2019 12:32:40 +0000
Message-ID: <45e3566b-4429-969e-288c-f84ba909313e@virtuozzo.com>
References: <20191116163410.12129-1-vsementsov@virtuozzo.com>
 <20191119120552.GB5910@linux.fritz.box>
 <3b5a71bd-b247-fabe-824a-f0cde32deb13@virtuozzo.com>
In-Reply-To: <3b5a71bd-b247-fabe-824a-f0cde32deb13@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0004.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::14) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191119153238580
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64fa16e7-a38d-4900-10e4-08d76cec9170
x-ms-traffictypediagnostic: AM6PR08MB5192:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB51925E321A1BA28909A7AE7EC14C0@AM6PR08MB5192.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(346002)(39840400004)(366004)(376002)(53754006)(199004)(189003)(8676002)(5660300002)(256004)(446003)(11346002)(4326008)(6512007)(6116002)(25786009)(486006)(6486002)(26005)(31686004)(86362001)(102836004)(305945005)(66946007)(7736002)(66446008)(31696002)(64756008)(66556008)(66476007)(6436002)(66066001)(81156014)(2616005)(186003)(81166006)(476003)(2906002)(107886003)(6246003)(386003)(6506007)(36756003)(99286004)(6916009)(54906003)(478600001)(316002)(14454004)(52116002)(8936002)(76176011)(3846002)(71200400001)(14444005)(229853002)(71190400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5192;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CQsek2cBy/7YAA6AXmf0csya3VHHaeGfrZApi3oD1w9+DI3KvWOIb1U3w9Jtjd+Zplp/mMp6EB7UJURzxPFakjBKqDp4kVOQIxK5kSwdnZJeAWuKTQZ/KvCslSB09a0KLrcL5mLO7qeZsJV4NjYCh6vkpYHN/Cf4d/97bjbJ5xkhKaxqAkzW3LF2qJeR6oTu/mzgwjtrTh+ddU+qPfDxGUKE//xkv4L5dznnC/QQ2qyQoL3vS5rEJq7UgRcjxnWCHRkjciSv6iv7de0L6EBOlGwWTMkelfqr7BA5PmIMXwoBmJs3KqD6xCdNZL0RLiC1ORsB+qfUlMMonDcB69Z8kY//6KKqWFBEigJ/3oLERuaxoqkWvAEKNXspGEiKO8DVn96ev7e8w4afoZA6IKkXqcRjlqSMd9L+/fzSCYeVWhtVq0V6EOgkxnn/Wf16R26y
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <3350385CE472154F96E564570530EA66@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64fa16e7-a38d-4900-10e4-08d76cec9170
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 12:32:40.6075 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K9ewXqAIemRmgd69hV54/Rz3oZrFDHjmZ0ufVpymdEs8/bZVDeWXaYtFJGhUXbGQDS8V9uVqK/cbmpaHJPSSUjWzR+z+dTDZDP910ZnRUB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5192
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.135
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
Cc: "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

19.11.2019 15:17, Vladimir Sementsov-Ogievskiy wrote:
> 19.11.2019 15:05, Kevin Wolf wrote:
>> Am 16.11.2019 um 17:34 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>> Hi all!
>>>
>>> I wanted to understand, what is the real difference between
>>> bdrv_block_status_above and bdrv_is_allocated_above, IMHO
>>> bdrv_is_allocated_above should work through bdrv_block_status_above..
>>>
>>> And I found the problem: bdrv_is_allocated_above considers space after
>>> EOF as UNALLOCATED for intermediate nodes..
>>>
>>> UNALLOCATED is not about allocation at fs level, but about should we
>>> go to backing or not.. And it seems incorrect for me, as in case of
>>> short backing file, we'll read zeroes after EOF, instead of going
>>> further by backing chain.
>>
>> We actually have documentation what it means:
>>
>> =A0 * BDRV_BLOCK_ALLOCATED: the content of the block is determined by th=
is
>> =A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
layer rather than any backing, set by block layer
>>
>> Say we have a short overlay, like this:
>>
>> base.qcow2:=A0=A0=A0=A0 AAAAAAAA
>> overlay.qcow2:=A0 BBBB
>>
>> Then of course the content of block 5 (the one after EOF of
>> overlay.qcow2) is still determined by overlay.qcow2, which can be easily
>> verified by reading it from overlay.qcow2 (produces zeros) and from
>> base.qcow2 (produces As).
>>
>> So the correct result when querying the block status of block 5 on
>> overlay.qcow2 is BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_ZERO.
>>
>> Interestingly, we already fixed the opposite case (large overlay over
>> short backing file) in commit e88ae2264d9 from May 2014 according to the
>> same logic.
>>
>>> This leads to the following effect:
>>>
>>> ./qemu-img create -f qcow2 base.qcow2 2M
>>> ./qemu-io -c "write -P 0x1 0 2M" base.qcow2
>>>
>>> ./qemu-img create -f qcow2 -b base.qcow2 mid.qcow2 1M
>>> ./qemu-img create -f qcow2 -b mid.qcow2 top.qcow2 2M
>>>
>>> Region 1M..2M is shadowed by short middle image, so guest sees zeroes:
>>> ./qemu-io -c "read -P 0 1M 1M" top.qcow2
>>> read 1048576/1048576 bytes at offset 1048576
>>> 1 MiB, 1 ops; 00.00 sec (22.795 GiB/sec and 23341.5807 ops/sec)
>>>
>>> But after commit guest visible state is changed, which seems wrong for =
me:
>>> ./qemu-img commit top.qcow2 -b mid.qcow2
>>>
>>> ./qemu-io -c "read -P 0 1M 1M" mid.qcow2
>>> Pattern verification failed at offset 1048576, 1048576 bytes
>>> read 1048576/1048576 bytes at offset 1048576
>>> 1 MiB, 1 ops; 00.00 sec (4.981 GiB/sec and 5100.4794 ops/sec)
>>>
>>> ./qemu-io -c "read -P 1 1M 1M" mid.qcow2
>>> read 1048576/1048576 bytes at offset 1048576
>>> 1 MiB, 1 ops; 00.00 sec (3.365 GiB/sec and 3446.1606 ops/sec)
>>>
>>>
>>> I don't know, is it a real bug, as I don't know, do we support backing
>>> file larger than its parent. Still, I'm not sure that this behavior of
>>> bdrv_is_allocated_above don't lead to other problems.
>>
>> I agree it's a bug.
>>
>> Your fix doesn't look right to me, though. You leave the buggy behaviour
>> of bdrv_co_block_status() as it is and then add four patches to work
>> around it in some (but not all) callers of it.
>>
>> All that it should take to fix this is making the bs->backing check
>> independent from want_zero and let it set ALLOCATED. What I expected
>> would be something like the below patch.
>>
>> But it doesn't seem to fully fix the problem (though 'alloc 1M 1M' in
>> qemu-io shows that the range is now considered allocated), so probably
>> there is still a separate bug in bdrv_is_allocated_above().
>>
>> And I think we'll want an iotests case for both cases (short overlay,
>> short backing file).
>>
>> Kevin
>>
>>
>> diff --git a/block/io.c b/block/io.c
>> index f75777f5ea..5eafcff01a 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -2359,16 +2359,17 @@ static int coroutine_fn bdrv_co_block_status(Blo=
ckDriverState *bs,
>> =A0=A0=A0=A0=A0 if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=3D BDRV_BLOCK_ALLOCATED;
>> -=A0=A0=A0 } else if (want_zero) {
>> -=A0=A0=A0=A0=A0=A0=A0 if (bdrv_unallocated_blocks_are_zero(bs)) {
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=3D BDRV_BLOCK_ZERO;
>> -=A0=A0=A0=A0=A0=A0=A0 } else if (bs->backing) {
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BlockDriverState *bs2 =3D bs->backing=
->bs;
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int64_t size2 =3D bdrv_getlength(bs2)=
;
>> -
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (size2 >=3D 0 && offset >=3D size2=
) {
>> +=A0=A0=A0 } else if (want_zero && bdrv_unallocated_blocks_are_zero(bs))=
 {
>> +=A0=A0=A0=A0=A0=A0=A0 ret |=3D BDRV_BLOCK_ZERO;
>> +=A0=A0=A0 } else if (bs->backing) {
>> +=A0=A0=A0=A0=A0=A0=A0 BlockDriverState *bs2 =3D bs->backing->bs;
>> +=A0=A0=A0=A0=A0=A0=A0 int64_t size2 =3D bdrv_getlength(bs2);
>> +
>> +=A0=A0=A0=A0=A0=A0=A0 if (size2 >=3D 0 && offset >=3D size2) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (want_zero) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=3D BDRV_BLOCK_=
ZERO;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=3D BDRV_BLOCK_ALLOCATED;
>=20
> No, I think it's wrong, as it's not allocated at bs, but at bs->backing->=
bs.
>=20
>=20
> So, bdrv_co_block_status works correct, what we can change about it, is n=
ot
> to return pnum=3D0 if requested range after eof, but return pnum=3Dbytes,=
 together
> with BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_ZERO | BDRV_BLOCK_EOF.

But this will break users which rely on pnum=3D0.

>=20
> And actual problem is in bdrv_block_status_above and bdrv_is_allocated_ab=
ove, which
> I'm fixing.
>=20
>=20
>=20


--=20
Best regards,
Vladimir

