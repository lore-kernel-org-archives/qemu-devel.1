Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A1AC2BBE2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:27:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E311420659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XHPgQwpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E311420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idEa0-0004ey-NP
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:27:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1idEMd-0007iy-9Q
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1idEMZ-0007Ev-Lx
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:13:46 -0500
Received: from mail-eopbgr10119.outbound.protection.outlook.com
 ([40.107.1.119]:13086 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1idEMW-00078y-Hj; Fri, 06 Dec 2019 09:13:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czAW9BmN0atgGAltMguiutyAhKCUn0YRY3tDMBI8YGgdn5SlQoPYRqzp2w42b6ZNa7i4+kOdhkKyYwLHEP0Sh3xtGxqj4CmUvsooV2MBQy5WYC/yuqQIqlCPdCBrUqm4WCKTV/Q51kAZokKf3YxWODwh+wIx8I9XAsimn2ijohtknKZJdQ/D2xb74itdFf7J2ELmqegO18xyq8baNBTpcrDgKialdgrdJb8/JqJQ1tqY1yVZqB94nk2BVaCNHAxUZRnd8YcmLjitGKX1n7TgsTcQQrFov3Ps9wevsxT3ibqeCD8SmEcwpUqY60/KEQyTx8G+00mJ+VmHpe7Vc9QsRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYOFln/cpPKvoiGYW3oJ3SJeVtcNy9UObbeIK0cLSCs=;
 b=Zz45vgyx5BOdiBFP5xV2VTpFxHjF96QTZPBUVJyfMlUOkxU2SC0M2xPH7WgBScQMzVozPB45PGKyaAf0AgGQVOEcl9MoXYxIi0eG25SLeoCotjY8Jdua14J6XMEWkllOWquZo95INfCJ+xjqW50ndKY0ihXW34ZBRHFXjninQGu7F2K7o1VWedzbL5S7sEfPOcmdyHHHKbBfORHMHwLjk38NJMjdoDl4l80fAIE/4VVh6Sy/Kh7/3u/CS+eliZFc2HgQV7gywY18dE066K4OO4nGXkEpFoRnEvqqEyK1eNCS7jWZ0YbQ/bkk0pt3QiKxcJjWYmEoON6khT6Ruv74/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYOFln/cpPKvoiGYW3oJ3SJeVtcNy9UObbeIK0cLSCs=;
 b=XHPgQwpUVOWMW2MzGjPcH4P6hmMhKVzs/6ciF4sLDiZ2tTXj+rCze2MAnlib1baobVtIN0KMm8jI/D+41bGiUVjdEO8TAXa0aeqbPeRqe9UIWzbzejZDZ0j+TjTazhcNuK41ACU0zL46GqXn9Ql5jWoTkR/yFEKHRuBuJsczdzo=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5238.eurprd08.prod.outlook.com (10.255.121.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Fri, 6 Dec 2019 10:18:05 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.014; Fri, 6 Dec 2019
 10:18:05 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH for-4.2?] block/qcow2-bitmap: fix crash bug in
 qcow2_co_remove_persistent_dirty_bitmap
Thread-Topic: [PATCH for-4.2?] block/qcow2-bitmap: fix crash bug in
 qcow2_co_remove_persistent_dirty_bitmap
Thread-Index: AQHVq6KIduIxknDAaEC7Mfgo+tVtwKer+IsAgAAB8ACAAOshAA==
Date: Fri, 6 Dec 2019 10:18:05 +0000
Message-ID: <6a74ae0a-e377-0f70-c347-0307580d7981@virtuozzo.com>
References: <20191205193049.30666-1-vsementsov@virtuozzo.com>
 <22af83d1-91e2-ab71-2dc4-349b5b24d1d8@redhat.com>
 <990da2e0-8223-b257-254d-a27659ef1d24@redhat.com>
In-Reply-To: <990da2e0-8223-b257-254d-a27659ef1d24@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0140.eurprd05.prod.outlook.com
 (2603:10a6:7:28::27) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191206131802679
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19f77f39-880e-4d35-5fe8-08d77a359511
x-ms-traffictypediagnostic: AM6PR08MB5238:
x-microsoft-antispam-prvs: <AM6PR08MB5238F7E138A780E46DF2EF4CC15F0@AM6PR08MB5238.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(396003)(346002)(39850400004)(136003)(53754006)(51444003)(189003)(199004)(102836004)(25786009)(4326008)(6506007)(52116002)(86362001)(76176011)(53546011)(2906002)(6512007)(31686004)(478600001)(54906003)(110136005)(36756003)(316002)(14454004)(6486002)(99286004)(71200400001)(11346002)(2616005)(5660300002)(71190400001)(31696002)(81156014)(305945005)(66556008)(26005)(186003)(81166006)(8936002)(8676002)(229853002)(66476007)(64756008)(66446008)(66946007)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5238;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WS114q8/mkLJo1O9gxYCztehqur3HyLX0MFaCzFsvlTgPXVrJz4vO7E1By0BMSO4DeCiHAVBtnjx2ck1IqSHQ6KaIrM/IG47q70HH+2OQ9jbN6RGP+Xz0HYmADyewpgzm8tkag7dE9/ZYyx9bq03ML7wbLOEL+eSdiVEr17Wd1i9jWO8QCa54hLakDCZAdSSAReGY1BWjtTiQE70A0sQSwpElcjSiOAZsv8N2Yq+65G8QJWPHH6KYNUMJ+mPhT3n2HTtMnfMlmG8n/1dnBaDAgngTDGQ5r+qiii+oZ/pCVVS0doSZ86l2fR47hC9260C8uPE6SxLnR2FTepSK5a7144l/UI1GjhkHLMfb8A032lQST9Inu/mALa4+bC0vRz+stf0tAN2JfzBCdxsQV1MTmzBJ6NU176vlUfldgV9lv/vui0jUlxxPmvMo4Id3jOP2kIAydWsyCNO0JzV3zXo1/6sp96WlEU6nN0ZfB6S0KZW2QFzZ5j5a0LbiRM4VoHvm099+zI4DaWADzIo6Sr9WD8eZbTpR0Dj0XAio5MMFiY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <0BE3BE51B9B19D448A46953E45EC3CD8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f77f39-880e-4d35-5fe8-08d77a359511
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 10:18:05.1032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z2DFItFg9JAmK2mTh+/VEBD0P3vfpQHx01JUd1Rmuh6Tvj5+Lc2fdSPa7CnNDVjbAGHKVHB991WyGzbWi3MziXfv/wptL07lvp6kyHtgIPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5238
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.119
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "libvirt-list@redhat.com" <libvirt-list@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

05.12.2019 23:16, John Snow wrote:
>=20
>=20
> On 12/5/19 3:09 PM, Eric Blake wrote:
>> On 12/5/19 1:30 PM, Vladimir Sementsov-Ogievskiy wrote:
>>> Here is double bug:
>>>
>>> First, return error but not set errp. This may lead to:
>>> qmp block-dirty-bitmap-remove may report success when actually failed
>>>
>>> block-dirty-bitmap-remove used in a transaction will crash, as
>>> qmp_transaction will think that it returned success and will cal
>>
>> call
>>
>>> block_dirty_bitmap_remove_commit which will crash, as state->bitmap is
>>> NULL
>>>
>>> Second (like in anecdote), this case is not an error at all. As it is
>>> documented in the comment above bdrv_co_remove_persistent_dirty_bitmap
>>> definition, absence of bitmap is not an error, and similar case handled
>>> at start of qcow2_co_remove_persistent_dirty_bitmap, it returns 0 when
>>> there is no bitmaps at all..
>>
>> double .
>>
>>>
>>> But when there are some bitmaps, but not the requested one, it return
>>> error with errp unset.
>>>
>>> Fix that.
>>>
>>> Fixes: b56a1e31759b750
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>
>>> Hi all!
>>>
>>> Ohm, suddenly we faced this bug. It's a regression in 4.2. I'm very
>>> sorry for introducing it, and it sad that it's found so late..
>>>
>>> Personally, I think that this one worth rc5, as it makes new bitmap
>>> interfaces unusable. But the decision is yours.
>>>
>>> Last minute edit: hmm, actually, transaction action introduced in
>>> 4.2, so crash is not a regression, only broken block-dirty-bitmap-remov=
e
>>> command is a regression... Maybe it's OK for stable.
>>
>> Libvirt REALLY wants to use transaction bitmap management (and require
>> qemu 4.2) for its incremental backup patches that Peter is almost ready
>> to merge in.=A0 I'm trying to ascertain:
>>
>> When exactly can this bug hit?=A0 Can you give a sequence of QMP command=
s
>> that will trigger it for easy reproduction?=A0 Are there workarounds (su=
ch
>> as checking that a bitmap exists prior to attempting to remove it)?=A0 I=
f
>> it does NOT get fixed in rc5, how will libvirt be able to probe whether
>> the fix is in place?
>>
>=20
> It looks like:
>=20
> - You need to have at least one bitmap
> - You need to use transactional remove
> - you need to misspell the bitmap name
> - The remove will fail (return -EINVAL) but doesn't set errp
> - The caller chokes on incomplete information, state->bitmap is NULL


No, that would be too simple, the thing is worse. Absolutele correct removi=
ng is broken, without any misspelling

Bug triggers when we are removing persistent bitmap that is not stored yet =
in the image AND at least one (another) bitmap already stored in the image.=
 So, something like:

1. create persistent bitmap A
2. shutdown vm  (bitmap A is synced)
3. start vm
4. create persistent bitmap B
5. remove bitmap B - it fails (and crashes if in transaction)

=3D=3D=3D=3D

Hmm, workaround..

I'm afraid that the only thing is not remove persistent bitmaps, which were=
 never synced to the image. So, instead the sequence above, we need


1. create persistent bitmap A
2. shutdown vm
3. start vm
4. create persistent bitmap B
5. remember, that we want to remove bitmap B after vm shutdown
...
  some other operations
...
6. vm shutdown
7. start vm in stopped mode, and remove all bitmaps marked for removing
8. stop vm

But, I think that in real circumstances, vm shutdown is rare thing...


>=20
>>>
>>>  =A0 block/qcow2-bitmap.c | 9 ++++++---
>>>  =A0 1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>>> index 8abaf632fc..c6c8ebbe89 100644
>>> --- a/block/qcow2-bitmap.c
>>> +++ b/block/qcow2-bitmap.c
>>> @@ -1469,8 +1469,10 @@ int coroutine_fn
>>> qcow2_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>>>  =A0=A0=A0=A0=A0 Qcow2BitmapList *bm_list;
>>>  =A0 =A0=A0=A0=A0=A0 if (s->nb_bitmaps =3D=3D 0) {
>>> -=A0=A0=A0=A0=A0=A0=A0 /* Absence of the bitmap is not an error: see ex=
planation above
>>> -=A0=A0=A0=A0=A0=A0=A0=A0 * bdrv_remove_persistent_dirty_bitmap() defin=
ition. */
>>> +=A0=A0=A0=A0=A0=A0=A0 /*
>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * Absence of the bitmap is not an error: see =
explanation above
>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * bdrv_co_remove_persistent_dirty_bitmap() de=
finition.
>>> +=A0=A0=A0=A0=A0=A0=A0=A0 */
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
>>>  =A0=A0=A0=A0=A0 }
>>>  =A0 @@ -1485,7 +1487,8 @@ int coroutine_fn
>>> qcow2_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>>>  =A0 =A0=A0=A0=A0=A0 bm =3D find_bitmap_by_name(bm_list, name);
>>>  =A0=A0=A0=A0=A0 if (bm =3D=3D NULL) {
>>> -=A0=A0=A0=A0=A0=A0=A0 ret =3D -EINVAL;
>>> +=A0=A0=A0=A0=A0=A0=A0 /* Absence of the bitmap is not an error, see ab=
ove. */
>>> +=A0=A0=A0=A0=A0=A0=A0 ret =3D 0;
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;
>>>  =A0=A0=A0=A0=A0 }
>>>  =20
>>
>=20


--=20
Best regards,
Vladimir

