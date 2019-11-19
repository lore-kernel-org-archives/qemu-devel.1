Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3D4C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B59421852
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="kZu/FPuu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B59421852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX2y5-0001zw-M1
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 07:50:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iX2xH-0001T3-IK
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:50:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iX2xF-0008TN-I6
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:50:02 -0500
Received: from mail-eopbgr30115.outbound.protection.outlook.com
 ([40.107.3.115]:40201 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iX2xE-0008Rf-Pt; Tue, 19 Nov 2019 07:50:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsZn0cY3yqOD3T9DZl7jugqi87Lx9bxULfpCFUKukx1pLQyKki7OxkBQJ9tCkYNxmremwPR2gIiCfDrxMN6GZGOLCmHO6f5cZ6MmPsktKNORsI4okiXBPLrhsEfBrA5qUmJKY2LZjQKYpmNIZtk2nh7DnlQDourZlg0ywz8OgGNSrgd/SWZFUXWY++iGgXoOLb+6aZ/vPbDx5Wpe0K1kDaGiibiDnKqGNUlZ4k3LGSeJdc4mFUyfPG3IYzQ7kKLlAfVO/fFMXmDf3SEqACHKS/nQfDBZx8lHCT0+gWjxYXDjPrLLUQoxxYSbXcTMNgiI+SIzsjffmobAqUvQQ0WYgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TV7pXxVUP1M2qNUhQNUAZpuNZ9s9Im9JKUsa5tx4ZeY=;
 b=XJlpUz5falfHdZOdQFvKox/+l00CdL1HSapgviy3vgsg386nakqDAiYbdkuxb8VZEnQnBMMitH82FBreb46miJeKFojVGQuWVAyy3fGDp9Tqaq2TrDtYMYe7j0kx+zrstCz7dXfY2FWqGVmK2tNSRUVgIUBLtSCS1u7HhWrR3/9wMLFwYEwIDiJzNrz5wH2V+IDwdXRNb5HfCVZOQyEfIkd6Qo7XNkJNSumCN+sSF0mJfcTbFDWyB4+dQ5RyEk5ZdwTD16WN2hHflPrddtAaHuaVRlGBJ2TrqkiHOrnCZimHqEgqxhmNOLMe5SsEqpqCrxOCU1GkELG8pEtYw+SWyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TV7pXxVUP1M2qNUhQNUAZpuNZ9s9Im9JKUsa5tx4ZeY=;
 b=kZu/FPuuiIUdNuYvDMVppAmVgwbdfDq+d0/OpQQ/75w/3W061TkGvr4n/uT9QUbEnVWkQ/ZOeIJ7clFFJVUF09RsJr7y/5kk3ahyU0OAlyiursVjlGxcDgTWkHGvRPLDzEO4bQPPs6olhibalmyozFqVfYVerLcC+7RIpZ0sDCA=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4325.eurprd08.prod.outlook.com (20.179.18.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 19 Nov 2019 12:49:58 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 12:49:58 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Topic: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Index: AQHVnJu0qDM7Hy9Fo0iUR1ci8onW5KeSaikAgAADVICAADZxAIAAAHiA///SEYA=
Date: Tue, 19 Nov 2019 12:49:58 +0000
Message-ID: <5228631b-ce9f-ba16-cdc7-089ffae94deb@virtuozzo.com>
References: <20191116163410.12129-1-vsementsov@virtuozzo.com>
 <20191119120552.GB5910@linux.fritz.box>
 <3b5a71bd-b247-fabe-824a-f0cde32deb13@virtuozzo.com>
 <45e3566b-4429-969e-288c-f84ba909313e@virtuozzo.com>
 <15191a26-4632-4bc8-583c-78ed9ed998ab@virtuozzo.com>
In-Reply-To: <15191a26-4632-4bc8-583c-78ed9ed998ab@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P189CA0034.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::47)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191119154955657
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 042410af-180d-454f-38a9-08d76ceefbec
x-ms-traffictypediagnostic: AM6PR08MB4325:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB4325FFEFA61154061317CC25C14C0@AM6PR08MB4325.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(39840400004)(346002)(376002)(136003)(53754006)(189003)(199004)(386003)(6436002)(31686004)(6486002)(6116002)(14454004)(486006)(229853002)(8676002)(3846002)(6916009)(66556008)(81166006)(81156014)(186003)(2906002)(305945005)(71190400001)(71200400001)(66476007)(7736002)(4326008)(76176011)(66446008)(64756008)(52116002)(14444005)(102836004)(256004)(86362001)(31696002)(6506007)(26005)(99286004)(25786009)(6512007)(8936002)(66066001)(66946007)(5660300002)(6246003)(2616005)(107886003)(446003)(478600001)(11346002)(36756003)(476003)(316002)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4325;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PXEfaItK8wQm7IZa83Ou4dDVDEfwNywBUufJOlNkjEvIYNpj4titda62KbiE1NyP1O6n/GcVKYu/ZGWMN21swMGCPKqnsoxGTdUxAbxkoFEdTxJCdlMpj62yDvkGMNEA0Fn8Ng6FZoSwigS6AFt0ww5siJEGEzACJu6bMvXop49basLM1wE7SF/U0UIa2Sj7MIOsSgClvemnT3ZAl4yu4hmuCK6Q7G1fVlaklPstN4h3QUkibUQEwJ81sKSn141DxamYmXR4IaVTmWw9wQQ9AiwEzFjqu5gNyD3teI+wi0cA23lmgLtRtIF3pFoOwpgqhaWgmTAEEmW2sZWYVQZRfEq/UPGYBqkK6tN7Aoe/QQ02mAeR4y4v25EekdsisPGSLAIKG2L0BaDcV/N/luou6ARV4ewEeLrSnv3LF+/Pv2PtilcxIbY+Ck/XSaxDvoBU
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <D0506341EF25EF489B9E65BEC9267266@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042410af-180d-454f-38a9-08d76ceefbec
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 12:49:58.1912 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PJHz1HspN2Y1R4uR3BhJDOxAWpM+mgLNdM8iDMxe9yLcGYWPhsIsmnaZ5DkTFXv3mkUrv/gOhWXRFEGBAu9ksjt+M23Xx0vEuQJAB7GD08w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4325
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.115
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

19.11.2019 15:34, Vladimir Sementsov-Ogievskiy wrote:
> 19.11.2019 15:32, Vladimir Sementsov-Ogievskiy wrote:
>> 19.11.2019 15:17, Vladimir Sementsov-Ogievskiy wrote:
>>> 19.11.2019 15:05, Kevin Wolf wrote:
>>>> Am 16.11.2019 um 17:34 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>>> Hi all!
>>>>>
>>>>> I wanted to understand, what is the real difference between
>>>>> bdrv_block_status_above and bdrv_is_allocated_above, IMHO
>>>>> bdrv_is_allocated_above should work through bdrv_block_status_above..
>>>>>
>>>>> And I found the problem: bdrv_is_allocated_above considers space afte=
r
>>>>> EOF as UNALLOCATED for intermediate nodes..
>>>>>
>>>>> UNALLOCATED is not about allocation at fs level, but about should we
>>>>> go to backing or not.. And it seems incorrect for me, as in case of
>>>>> short backing file, we'll read zeroes after EOF, instead of going
>>>>> further by backing chain.
>>>>
>>>> We actually have documentation what it means:
>>>>
>>>> =A0 * BDRV_BLOCK_ALLOCATED: the content of the block is determined by =
this
>>>> =A0 *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 layer rather than any backing, set by block layer
>>>>
>>>> Say we have a short overlay, like this:
>>>>
>>>> base.qcow2:=A0=A0=A0=A0 AAAAAAAA
>>>> overlay.qcow2:=A0 BBBB
>>>>
>>>> Then of course the content of block 5 (the one after EOF of
>>>> overlay.qcow2) is still determined by overlay.qcow2, which can be easi=
ly
>>>> verified by reading it from overlay.qcow2 (produces zeros) and from
>>>> base.qcow2 (produces As).
>>>>
>>>> So the correct result when querying the block status of block 5 on
>>>> overlay.qcow2 is BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_ZERO.
>>>>
>>>> Interestingly, we already fixed the opposite case (large overlay over
>>>> short backing file) in commit e88ae2264d9 from May 2014 according to t=
he
>>>> same logic.
>>>>
>>>>> This leads to the following effect:
>>>>>
>>>>> ./qemu-img create -f qcow2 base.qcow2 2M
>>>>> ./qemu-io -c "write -P 0x1 0 2M" base.qcow2
>>>>>
>>>>> ./qemu-img create -f qcow2 -b base.qcow2 mid.qcow2 1M
>>>>> ./qemu-img create -f qcow2 -b mid.qcow2 top.qcow2 2M
>>>>>
>>>>> Region 1M..2M is shadowed by short middle image, so guest sees zeroes=
:
>>>>> ./qemu-io -c "read -P 0 1M 1M" top.qcow2
>>>>> read 1048576/1048576 bytes at offset 1048576
>>>>> 1 MiB, 1 ops; 00.00 sec (22.795 GiB/sec and 23341.5807 ops/sec)
>>>>>
>>>>> But after commit guest visible state is changed, which seems wrong fo=
r me:
>>>>> ./qemu-img commit top.qcow2 -b mid.qcow2
>>>>>
>>>>> ./qemu-io -c "read -P 0 1M 1M" mid.qcow2
>>>>> Pattern verification failed at offset 1048576, 1048576 bytes
>>>>> read 1048576/1048576 bytes at offset 1048576
>>>>> 1 MiB, 1 ops; 00.00 sec (4.981 GiB/sec and 5100.4794 ops/sec)
>>>>>
>>>>> ./qemu-io -c "read -P 1 1M 1M" mid.qcow2
>>>>> read 1048576/1048576 bytes at offset 1048576
>>>>> 1 MiB, 1 ops; 00.00 sec (3.365 GiB/sec and 3446.1606 ops/sec)
>>>>>
>>>>>
>>>>> I don't know, is it a real bug, as I don't know, do we support backin=
g
>>>>> file larger than its parent. Still, I'm not sure that this behavior o=
f
>>>>> bdrv_is_allocated_above don't lead to other problems.
>>>>
>>>> I agree it's a bug.
>>>>
>>>> Your fix doesn't look right to me, though. You leave the buggy behavio=
ur
>>>> of bdrv_co_block_status() as it is and then add four patches to work
>>>> around it in some (but not all) callers of it.

The only caller is bdrv_co_block_status_above.

>>>>
>>>> All that it should take to fix this is making the bs->backing check
>>>> independent from want_zero and let it set ALLOCATED. What I expected
>>>> would be something like the below patch.
>>>>
>>>> But it doesn't seem to fully fix the problem (though 'alloc 1M 1M' in
>>>> qemu-io shows that the range is now considered allocated), so probably
>>>> there is still a separate bug in bdrv_is_allocated_above().
>>>>
>>>> And I think we'll want an iotests case for both cases (short overlay,
>>>> short backing file).
>>>>
>>>> Kevin
>>>>
>>>>
>>>> diff --git a/block/io.c b/block/io.c
>>>> index f75777f5ea..5eafcff01a 100644
>>>> --- a/block/io.c
>>>> +++ b/block/io.c
>>>> @@ -2359,16 +2359,17 @@ static int coroutine_fn bdrv_co_block_status(B=
lockDriverState *bs,
>>>> =A0=A0=A0=A0=A0 if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=3D BDRV_BLOCK_ALLOCATED;
>>>> -=A0=A0=A0 } else if (want_zero) {
>>>> -=A0=A0=A0=A0=A0=A0=A0 if (bdrv_unallocated_blocks_are_zero(bs)) {
>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=3D BDRV_BLOCK_ZERO;
>>>> -=A0=A0=A0=A0=A0=A0=A0 } else if (bs->backing) {
>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BlockDriverState *bs2 =3D bs->backi=
ng->bs;
>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int64_t size2 =3D bdrv_getlength(bs=
2);
>>>> -
>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (size2 >=3D 0 && offset >=3D siz=
e2) {
>>>> +=A0=A0=A0 } else if (want_zero && bdrv_unallocated_blocks_are_zero(bs=
)) {
>>>> +=A0=A0=A0=A0=A0=A0=A0 ret |=3D BDRV_BLOCK_ZERO;
>>>> +=A0=A0=A0 } else if (bs->backing) {
>>>> +=A0=A0=A0=A0=A0=A0=A0 BlockDriverState *bs2 =3D bs->backing->bs;
>>>> +=A0=A0=A0=A0=A0=A0=A0 int64_t size2 =3D bdrv_getlength(bs2);
>>>> +
>>>> +=A0=A0=A0=A0=A0=A0=A0 if (size2 >=3D 0 && offset >=3D size2) {
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (want_zero) {
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=3D BDRV_BLOC=
K_ZERO;
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret |=3D BDRV_BLOCK_ALLOCATED;
>>>
>>> No, I think it's wrong, as it's not allocated at bs, but at bs->backing=
->bs.
>>>
>>>
>>> So, bdrv_co_block_status works correct, what we can change about it, is=
 not
>>> to return pnum=3D0 if requested range after eof, but return pnum=3Dbyte=
s, together
>>> with BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_ZERO | BDRV_BLOCK_EOF.
>>
>> But this will break users which rely on pnum=3D0.
>=20
> Possibly, we may add flag to bdrv_co_block_status, to behave in such mann=
er, and
> set it to true when call from bdrv_block_status_above/bdrv_is_allocated_a=
bove.
>=20
>>
>>>
>>> And actual problem is in bdrv_block_status_above and bdrv_is_allocated_=
above, which
>>> I'm fixing.
>>>
>>>
>>>
>>
>>
>=20
>=20


--=20
Best regards,
Vladimir

