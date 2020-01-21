Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5BFC33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C61122522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HX4dp919"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C61122522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itpx4-0002db-An
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 04:36:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itpwN-00024N-CH
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:35:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itpwK-0004eP-Pd
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:35:19 -0500
Received: from mail-eopbgr70129.outbound.protection.outlook.com
 ([40.107.7.129]:12036 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1itpwJ-0004dU-V6; Tue, 21 Jan 2020 04:35:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnMpCCpPkP2Dw/AnnC2K8ORPiXaWnjDmK8udC+12/zsk9Cx1Cp/jcdE+rc3/N6aZSzar//ef9Bjk6rbC/qSR6qymKfnzC8aLtAPcPMXOHszaUldInbAh135bEowhk7mDHeMDjhao5ztMAyymyWvGc63pjJ/ghgLyEYIezQEX6NHQTXiNFM+UJtJfYvprKqqDNy1Xz6B8qSO9BcsnT5IpvCnV1en8Xg+oPd9RaUuiA/vzyMBBrhZztj6hMAEkDgtxVYDSYiwo3EKVEggJP1w+P8fpc6CY7RpYeu+btlolgdS3jcYYDAo6ZF6C3XbMmDYhwY45H0nqMjfauuOnI/7X2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBkVxs+6TEtUZpDASWt3plV6vFIoVv/kC7hqQOTaXxA=;
 b=GtXHNI4caxGSz24WS+cKOxNGNqsxDcQS8ucDu+P7hDLnGUsLMZXv62CTtx05B+W1ZvWJx6tjrNk+vssBu6sEhs9P1diYtSZmlWJ71RotNNlUInq4dlJ13HxtAP70nnVGbGMVt59A4o0DaN1glVZcICLm8Nw0vBSuiejKmzt8H5J9pLNCrtnZe2M1a9vOzwldOl3O4/8Tfq4gvI1CVep3dvPvDeR6QX3eh0g1ff5NPci7AdANWjp2UDsH80VyPPMt14B5IVGwDV+DnYVh2wiihBP/6Hi/B/j9/boNgJUFYBanZan/nKzW9KPbFs3yjmr/EP0lpSQBI9HidmjtL/ebDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBkVxs+6TEtUZpDASWt3plV6vFIoVv/kC7hqQOTaXxA=;
 b=HX4dp919tFEMllJFDGsR00t2IM3o+oxUy3ra/K5lX1sBQIagJ8rQT5Sjzx8UJCgp33/WBfbhWPGV8IltaqcI8c9xyDkRFYGKPCbZjSWDyeu6xMykRqVDyLqeDyf+vsIu3JwWZ/BEHilOFJW25BYAryIFd6KiiQXtjFWET14ndIs=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4835.eurprd08.prod.outlook.com (10.255.96.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Tue, 21 Jan 2020 09:35:12 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 09:35:12 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 AM0PR01CA0018.eurprd01.prod.exchangelabs.com (2603:10a6:208:69::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Tue, 21 Jan 2020 09:35:12 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 06/10] block/dirty-bitmap: add _next_dirty API
Thread-Topic: [PATCH v3 06/10] block/dirty-bitmap: add _next_dirty API
Thread-Index: AQHVtlOgdeEZtpGHH0igSKd2umc3c6fzul2AgABpNwCAAOvqAA==
Date: Tue, 21 Jan 2020 09:35:12 +0000
Message-ID: <17e0811e-8f4d-20e9-75a3-0c11702900bb@virtuozzo.com>
References: <20191219100348.24827-1-vsementsov@virtuozzo.com>
 <20191219100348.24827-7-vsementsov@virtuozzo.com>
 <0350481a-12ad-1608-79f1-b9f433963565@redhat.com>
 <2641fe67-1035-e00b-131d-513aec6752a8@virtuozzo.com>
In-Reply-To: <2641fe67-1035-e00b-131d-513aec6752a8@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR01CA0018.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::31) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200121123510216
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2210e5ad-ef39-44f0-100c-08d79e5536c6
x-ms-traffictypediagnostic: AM6PR08MB4835:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB48354D55E701BBCD4C388562C10D0@AM6PR08MB4835.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(376002)(136003)(396003)(346002)(366004)(199004)(189003)(31686004)(54906003)(4326008)(2616005)(110136005)(16576012)(186003)(71200400001)(5660300002)(956004)(2906002)(316002)(6486002)(107886003)(8676002)(81166006)(81156014)(8936002)(52116002)(66556008)(64756008)(86362001)(26005)(16526019)(66446008)(31696002)(66946007)(66476007)(36756003)(508600001)(53546011)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4835;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3NANguwDG+1RqfWAm3e+VxIhBhzWqtJoT8A6JbIz5avVeH/qvj7fEfJ2u38onHa3ZK84Ynr47vFw/1kOh1YZLh5ZZPig6KxW1VkEe0x7VOflTa7ur+MAqAiLedTaeMYXY0EI6u6Nzw1wi9O0MeASdGosICWQk02Kjbk1UrIBfF0eKiI1smHboH14McDr84MPJZBlTGdp8k6/Fx1UM8Gye8mn98Q1EW33e/CJ34CM0WZ8kD3bBL4cTVviKLDrKpHernh96JlgKwenjbw+Z9DkEjoHbRkRYZiLm4c6LO9QRfNQPGxg1NLSsk6LRr9ANMJuMuvo69B30wCdpk4C9yPTl+VzLURblKkmDcZVxkaHabpUXdxhYP/iXpfLkT/Z69GfAPYnSabeLW7WSSTNOV42o6Xt9QYpL9HoTwhWTKix4Ir4znGEvZvqsirDLK5n2kEXW9wV4RhOcJlrI3+d6fVpMPLKJTDVeojEkRXkkRi3QNo=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <4180810DAE5EE54DB8EC136367464BEA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2210e5ad-ef39-44f0-100c-08d79e5536c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 09:35:12.5622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dZjper1EB80mGgTHmjGoXq/ShS3kcPE+7eFrC6eiX7DQ0+A+Dqx8tKoPme3Y8PHiS/qQvkiboFa6LGXt7LaedweTY+qxZmyM5UonfNnVhf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4835
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.129
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
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.01.2020 19:30, Vladimir Sementsov-Ogievskiy wrote:
> 20.01.2020 16:14, Max Reitz wrote:
>> On 19.12.19 11:03, Vladimir Sementsov-Ogievskiy wrote:
>>> We have bdrv_dirty_bitmap_next_zero, let's add corresponding
>>> bdrv_dirty_bitmap_next_dirty, which is more comfortable to use than
>>> bitmap iterators in some cases.
>>>
>>> For test modify test_hbitmap_next_zero_check_range to check both
>>> next_zero and next_dirty and add some new checks.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>> =A0 include/block/dirty-bitmap.h |=A0=A0 2 +
>>> =A0 include/qemu/hbitmap.h=A0=A0=A0=A0=A0=A0 |=A0 13 ++++
>>> =A0 block/dirty-bitmap.c=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 6 ++
>>> =A0 tests/test-hbitmap.c=A0=A0=A0=A0=A0=A0=A0=A0 | 130 ++++++++++++++++=
++++---------------
>>> =A0 util/hbitmap.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 60 ++=
++++++--------
>>> =A0 5 files changed, 126 insertions(+), 85 deletions(-)
>>
>> [...]
>>
>>> diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
>>> index b6e85f3d5d..a4b032b270 100644
>>> --- a/include/qemu/hbitmap.h
>>> +++ b/include/qemu/hbitmap.h
>>> @@ -297,6 +297,19 @@ void hbitmap_free(HBitmap *hb);
>>> =A0=A0 */
>>> =A0 void hbitmap_iter_init(HBitmapIter *hbi, const HBitmap *hb, uint64_=
t first);
>>> +/*
>>> + * hbitmap_next_dirty:
>>> + *
>>> + * Find next dirty bit within selected range. If not found, return -1.
>>> + *
>>> + * @hb: The HBitmap to operate on
>>> + * @start: The bit to start from.
>>> + * @count: Number of bits to proceed. If @start+@count > bitmap size, =
the whole
>>> + * bitmap is looked through. You can use UINT64_MAX as @count to searc=
h up to
>>
>> I would=92ve said s/looked through/scanned/, but it matches
>> hbitmap_next_zero()=92s documentation, so it=92s fine.
>>
>> But definitely s/UINT64_MAX/INT64_MAX/.
>>
>>> + * the bitmap end.
>>> + */
>>> +int64_t hbitmap_next_dirty(const HBitmap *hb, int64_t start, int64_t c=
ount);
>>> +
>>> =A0 /* hbitmap_next_zero:
>>> =A0=A0 *
>>> =A0=A0 * Find next not dirty bit within selected range. If not found, r=
eturn -1.
>>
>> [...]
>>
>>> diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
>>> index 0e1e5c64dd..e3f1b3f361 100644
>>> --- a/tests/test-hbitmap.c
>>> +++ b/tests/test-hbitmap.c
>>> @@ -816,92 +816,108 @@ static void test_hbitmap_iter_and_reset(TestHBit=
mapData *data,
>>> =A0=A0=A0=A0=A0 hbitmap_iter_next(&hbi);
>>> =A0 }
>>> -static void test_hbitmap_next_zero_check_range(TestHBitmapData *data,
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint6=
4_t start,
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint6=
4_t count)
>>> +static void test_hbitmap_next_x_check_range(TestHBitmapData *data,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint64_t start=
,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint64_t count=
)
>>
>> Why not change the parameters to be signed while we=92re already here?

Now I think that better to do it in previous patch.

>>
>> [...]
>>
>>> diff --git a/util/hbitmap.c b/util/hbitmap.c
>>> index df22f06be6..d23f4b9678 100644
>>> --- a/util/hbitmap.c
>>> +++ b/util/hbitmap.c
>>> @@ -193,6 +193,30 @@ void hbitmap_iter_init(HBitmapIter *hbi, const HBi=
tmap *hb, uint64_t first)
>>> =A0=A0=A0=A0=A0 }
>>> =A0 }
>>> +int64_t hbitmap_next_dirty(const HBitmap *hb, int64_t start, int64_t c=
ount)
>>> +{
>>> +=A0=A0=A0 HBitmapIter hbi;
>>> +=A0=A0=A0 int64_t firt_dirty_off;
>>
>> Pre-existing, but isn=92t this just a typo that you could fix here?=A0 (=
i.e.
>> s/firt/first/)
>>
>> Apart from this minor things:
>=20
> Agree with them.
>=20
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
>>> +=A0=A0=A0 uint64_t end;
>>> +
>>> +=A0=A0=A0 assert(start >=3D 0 && count >=3D 0);
>>> +
>>> +=A0=A0=A0 if (start >=3D hb->orig_size || count =3D=3D 0) {
>>> +=A0=A0=A0=A0=A0=A0=A0 return -1;
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 end =3D count > hb->orig_size - start ?
>>
>=20
>=20


--=20
Best regards,
Vladimir

