Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A80C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:35:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B40222A4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="siqZWlyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B40222A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX2jc-00036y-PN
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 07:35:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iX2i9-000181-Us
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:34:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iX2i8-0000En-HM
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:34:25 -0500
Received: from mail-ve1eur03on0707.outbound.protection.outlook.com
 ([2a01:111:f400:fe09::707]:12462
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iX2i8-0000Dz-AE; Tue, 19 Nov 2019 07:34:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QudRJqOqegNk25hZqHEhnG0LvFBG4atW8fSRr/fO1gjezr6Orv38yeCTtdVz/4aVgm/bxRY1twrNi123YIoVJUiRbkhLuwyvgGAYdv2E440lrew0hTvovsEQX0wEVmIu3Q/oCiWotzuOh7pe/P4YIBXlzki8rw2rvq2ognXFht0axrgbeMwnyQ3wBqcffSQCbLaPjPASA/UR4AemoHCnUDyCvBc0NkY+TygPupGchAqfKu5s9196NMwIAPD3wh7/CgBHUG9W4DMO6gTzmArGS6J6Ak6OsL9CnYB6iqwWpd/XsFgZGLcQz8zZcPBMxCIlw2I7rW5bNQrDJ9CQcABaaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8Xc2W1x7qqvMesePMbD+kDG1WFMXAlSSuGTVKhkC08=;
 b=goYgjotizKvFJWe92O/iXS5wDT9ybxkI4BPs6MnZQfcN4m4QhYF55w5WgqM8VXuiJGkJvFTTHZZXcnHMjuQ0fZUJ3wz3i2DXTsSB1opwTxbC9ZcN4VzTSETAGHQideBS8FBNhBbFknrZnHuC1jEZbFM+MGCF2mvn5LlJIXc/93ANv7i0Nl+guFv9xj3W8pp3F/eUAZwJLbc6Rf5bIh6+LgmujVI+yF4CzZBHKSYLSUDqTDB5vqgBDyvY8iO7VjwAlK0i+7r0JHLLfLbthP5EcEl/WE9+vHQs8zMMjRTHgXQkKtK5e+mykIlV1iF+6gYF0LaVwcP+PjOKkH3OacMI0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8Xc2W1x7qqvMesePMbD+kDG1WFMXAlSSuGTVKhkC08=;
 b=siqZWlyID8PEzuwry9FZ9ivu5ZCq04SnhUAdUwKKoU9ZX2LUH48lqI1MrjJCe+Yqnq/J0oxNVsCs6GU++JNvv8IM54CjwjnsOwhupWbtU3m3knDmeyaQv4yClFsYAquun4lkSsKiKNLen9+lMCNYEA7pBgn/fck4uxLBRjd/YJg=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4551.eurprd08.prod.outlook.com (20.179.7.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 19 Nov 2019 12:34:21 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 12:34:21 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Topic: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Index: AQHVnJu0qDM7Hy9Fo0iUR1ci8onW5KeSaikAgAADVICAADZxAP//zi6A
Date: Tue, 19 Nov 2019 12:34:21 +0000
Message-ID: <15191a26-4632-4bc8-583c-78ed9ed998ab@virtuozzo.com>
References: <20191116163410.12129-1-vsementsov@virtuozzo.com>
 <20191119120552.GB5910@linux.fritz.box>
 <3b5a71bd-b247-fabe-824a-f0cde32deb13@virtuozzo.com>
 <45e3566b-4429-969e-288c-f84ba909313e@virtuozzo.com>
In-Reply-To: <45e3566b-4429-969e-288c-f84ba909313e@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0022.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::32) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191119153419240
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0aaf6ab5-cb1f-4ad4-a7b7-08d76ceccd5c
x-ms-traffictypediagnostic: AM6PR08MB4551:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB4551F0048955AF9C168BDF7FC14C0@AM6PR08MB4551.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39840400004)(396003)(376002)(346002)(366004)(189003)(199004)(53754006)(6916009)(6486002)(316002)(99286004)(71200400001)(36756003)(229853002)(14444005)(256004)(71190400001)(25786009)(6436002)(76176011)(54906003)(6116002)(3846002)(52116002)(386003)(26005)(478600001)(86362001)(2906002)(486006)(7736002)(11346002)(305945005)(14454004)(102836004)(476003)(2616005)(31696002)(6506007)(6246003)(66556008)(64756008)(66446008)(446003)(186003)(81156014)(81166006)(8676002)(66066001)(5660300002)(66476007)(6512007)(4326008)(107886003)(66946007)(31686004)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4551;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1E3za28nwS9dHlngaPQrzl9CfpIQCwHr9zhhklKuMZtw76wqG0JtBvSExX4Nb0Lilr8X0wXcOuzDGcHItenLe1zVu+JyCoeglmcdyhaAeuv4JY9Sgcui/2I6msqNWBMVZQK0MDp8mVfpdiF0msIxsBqCKev7E23gtAA2i82rtg1QXWB5+dSBaQ6toBw20EjVEVbi7bYHYzin1MedQuwnHKlSqL2n9sEOov1RgQcCzQnzLlGaOPFZinYMD1NIjiuthrC6jFojkqNXTM+oaH27ZnXiYloqmWfNGjjA+C5CMrIpp0KF82N+adRlV5xjZx6g2gbM//tf35Tb9XFC+bqm+suaI3yO3Y/frzcngWU3ZfV6BUeyy6eHunjU03iVFk7481jbNzyXElNQz1VxAIAfg+IMCRd3qYQ848voKOLgVhQroFoHrCFg6008DRrnic51
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <FA842C45DFE73B4894C8F225C02C3893@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aaf6ab5-cb1f-4ad4-a7b7-08d76ceccd5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 12:34:21.0647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IVESEx9eRDMSYG9JohclR1bAs9UI/8j8aPYJeIz+IFx3EwUVX4xGe+3CArGXpNlRBLBdlwOwfJCaX7b0XYWfyQCo7e6uXYSkDQ7KJp58e+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4551
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe09::707
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

19.11.2019 15:32, Vladimir Sementsov-Ogievskiy wrote:
> 19.11.2019 15:17, Vladimir Sementsov-Ogievskiy wrote:
>> 19.11.2019 15:05, Kevin Wolf wrote:
>>> Am 16.11.2019 um 17:34 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>> Hi all!
>>>>
>>>> I wanted to understand, what is the real difference between
>>>> bdrv_block_status_above and bdrv_is_allocated_above, IMHO
>>>> bdrv_is_allocated_above should work through bdrv_block_status_above..
>>>>
>>>> And I found the problem: bdrv_is_allocated_above considers space after
>>>> EOF as UNALLOCATED for intermediate nodes..
>>>>
>>>> UNALLOCATED is not about allocation at fs level, but about should we
>>>> go to backing or not.. And it seems incorrect for me, as in case of
>>>> short backing file, we'll read zeroes after EOF, instead of going
>>>> further by backing chain.
>>>
>>> We actually have documentation what it means:
>>>
>>> =A0 * BDRV_BLOCK_ALLOCATED: the content of the block is determined by t=
his
>>> =A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 layer rather than any backing, set by block layer
>>>
>>> Say we have a short overlay, like this:
>>>
>>> base.qcow2:=A0=A0=A0=A0 AAAAAAAA
>>> overlay.qcow2:=A0 BBBB
>>>
>>> Then of course the content of block 5 (the one after EOF of
>>> overlay.qcow2) is still determined by overlay.qcow2, which can be easil=
y
>>> verified by reading it from overlay.qcow2 (produces zeros) and from
>>> base.qcow2 (produces As).
>>>
>>> So the correct result when querying the block status of block 5 on
>>> overlay.qcow2 is BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_ZERO.
>>>
>>> Interestingly, we already fixed the opposite case (large overlay over
>>> short backing file) in commit e88ae2264d9 from May 2014 according to th=
e
>>> same logic.
>>>
>>>> This leads to the following effect:
>>>>
>>>> ./qemu-img create -f qcow2 base.qcow2 2M
>>>> ./qemu-io -c "write -P 0x1 0 2M" base.qcow2
>>>>
>>>> ./qemu-img create -f qcow2 -b base.qcow2 mid.qcow2 1M
>>>> ./qemu-img create -f qcow2 -b mid.qcow2 top.qcow2 2M
>>>>
>>>> Region 1M..2M is shadowed by short middle image, so guest sees zeroes:
>>>> ./qemu-io -c "read -P 0 1M 1M" top.qcow2
>>>> read 1048576/1048576 bytes at offset 1048576
>>>> 1 MiB, 1 ops; 00.00 sec (22.795 GiB/sec and 23341.5807 ops/sec)
>>>>
>>>> But after commit guest visible state is changed, which seems wrong for=
 me:
>>>> ./qemu-img commit top.qcow2 -b mid.qcow2
>>>>
>>>> ./qemu-io -c "read -P 0 1M 1M" mid.qcow2
>>>> Pattern verification failed at offset 1048576, 1048576 bytes
>>>> read 1048576/1048576 bytes at offset 1048576
>>>> 1 MiB, 1 ops; 00.00 sec (4.981 GiB/sec and 5100.4794 ops/sec)
>>>>
>>>> ./qemu-io -c "read -P 1 1M 1M" mid.qcow2
>>>> read 1048576/1048576 bytes at offset 1048576
>>>> 1 MiB, 1 ops; 00.00 sec (3.365 GiB/sec and 3446.1606 ops/sec)
>>>>
>>>>
>>>> I don't know, is it a real bug, as I don't know, do we support backing
>>>> file larger than its parent. Still, I'm not sure that this behavior of
>>>> bdrv_is_allocated_above don't lead to other problems.
>>>
>>> I agree it's a bug.
>>>
>>> Your fix doesn't look right to me, though. You leave the buggy behaviou=
r
>>> of bdrv_co_block_status() as it is and then add four patches to work
>>> around it in some (but not all) callers of it.
>>>
>>> All that it should take to fix this is making the bs->backing check
>>> independent from want_zero and let it set ALLOCATED. What I expected
>>> would be something like the below patch.
>>>
>>> But it doesn't seem to fully fix the problem (though 'alloc 1M 1M' in
>>> qemu-io shows that the range is now considered allocated), so probably
>>> there is still a separate bug in bdrv_is_allocated_above().
>>>
>>> And I think we'll want an iotests case for both cases (short overlay,
>>> short backing file).
>>>
>>> Kevin
>>>
>>>
>>> diff --git a/block/io.c b/block/io.c
>>> index f75777f5ea..5eafcff01a 100644
>>> --- a/block/io.c
>>> +++ b/block/io.c
>>> @@ -2359,16 +2359,17 @@ static int coroutine_fn bdrv_co_block_status(Bl=
ockDriverState *bs,
>>> =A0=A0=A0=A0=A0 if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=3D BDRV_BLOCK_ALLOCATED;
>>> -=A0=A0=A0 } else if (want_zero) {
>>> -=A0=A0=A0=A0=A0=A0=A0 if (bdrv_unallocated_blocks_are_zero(bs)) {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=3D BDRV_BLOCK_ZERO;
>>> -=A0=A0=A0=A0=A0=A0=A0 } else if (bs->backing) {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BlockDriverState *bs2 =3D bs->backin=
g->bs;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int64_t size2 =3D bdrv_getlength(bs2=
);
>>> -
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (size2 >=3D 0 && offset >=3D size=
2) {
>>> +=A0=A0=A0 } else if (want_zero && bdrv_unallocated_blocks_are_zero(bs)=
) {
>>> +=A0=A0=A0=A0=A0=A0=A0 ret |=3D BDRV_BLOCK_ZERO;
>>> +=A0=A0=A0 } else if (bs->backing) {
>>> +=A0=A0=A0=A0=A0=A0=A0 BlockDriverState *bs2 =3D bs->backing->bs;
>>> +=A0=A0=A0=A0=A0=A0=A0 int64_t size2 =3D bdrv_getlength(bs2);
>>> +
>>> +=A0=A0=A0=A0=A0=A0=A0 if (size2 >=3D 0 && offset >=3D size2) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (want_zero) {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=3D BDRV_BLOCK=
_ZERO;
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=3D BDRV_BLOCK_ALLOCATED;
>>
>> No, I think it's wrong, as it's not allocated at bs, but at bs->backing-=
>bs.
>>
>>
>> So, bdrv_co_block_status works correct, what we can change about it, is =
not
>> to return pnum=3D0 if requested range after eof, but return pnum=3Dbytes=
, together
>> with BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_ZERO | BDRV_BLOCK_EOF.
>=20
> But this will break users which rely on pnum=3D0.

Possibly, we may add flag to bdrv_co_block_status, to behave in such manner=
, and
set it to true when call from bdrv_block_status_above/bdrv_is_allocated_abo=
ve.

>=20
>>
>> And actual problem is in bdrv_block_status_above and bdrv_is_allocated_a=
bove, which
>> I'm fixing.
>>
>>
>>
>=20
>=20


--=20
Best regards,
Vladimir

