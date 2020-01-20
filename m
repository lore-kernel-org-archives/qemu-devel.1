Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94224C33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:32:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 618612087E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vMx7oYzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618612087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itZyK-0005fp-9Y
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 11:32:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itZx4-0004nW-08
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:31:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itZx0-0006gH-29
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:30:57 -0500
Received: from mail-vi1eur05on2138.outbound.protection.outlook.com
 ([40.107.21.138]:48512 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1itZwy-0006fN-70; Mon, 20 Jan 2020 11:30:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJKRLJunC8bxZuhkfk2nKqwwJW1+ltzfZ67gGm7alP061Tx3b1gZO3+zE35hXiBoW0To20XjyfAHOjDBclON8oA4eru2yM1j8N8ZAaVr2sSlZqYbXBWMmI5qDZV9jpgvCFyo+XxPM0Tdf3OSlyYe8+KmqxzlIkzYAWq0nu8OtEAcgL4EzOJpDJfmq+RHJz5mhvM1hbTIseNXQ0uQxSBmcaOsoWr6ZHZwliSdcNYTwqMuil02Psm36bG1pjxdfa25cMvprqppVkQow7ojNkPTx/KFHUqance5tnBR7mDfGVvaFWQTSZ4M6FcFXChrEPr6qoAU/zVYo2sR/1Z8ZDVG8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFcoHErsbSqyt/M377LgVk6+iVe8ieImTTmT1oOav9Y=;
 b=YV31Hk5orbVWfIce+yL5HFrpdh7BMkvwY3r+DAM8Ltzm+c7CInbA0o0SxWKmYTxPuFUgtIHs8WmxXDPKMYj+zpt5X7Us8Cy446vFrONjNqR/L5Ta75jqRlh0IUmDeLBYJGjqGkkt8FeoO38dw5Dfgwja/s9GgMzVGGjku2iKgz77x4gTotjSJiEbyKrrleL+V0egmRZukL5bQrXfdyH0EjHpse4FPtoni2O6lS4wGzmUwGnkVPKk2zgVx7QYLLw60k7MaCNJ/tbVGlimxwxDBjjywP8KmDFwUktYlfhJp4pvplKrBJP4VJ6oe/FXYZuMqlUdVJePOY2CHVQDFcG5eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFcoHErsbSqyt/M377LgVk6+iVe8ieImTTmT1oOav9Y=;
 b=vMx7oYzHSEfMwsCHuZJWX5o/llubLgkUc7dE4+iAuSDYZ3r/bH9pdMH4bkxwQKdovaVPKdFxjixwbm04Q3HkHnz3bAotkcLldfrzmP9amTF74I9ZonXh3wbmeMblx92HKyt5ZVv2N4gb5LIsCdMa0s9CpitXRmCQfit4ORSPJfM=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3733.eurprd08.prod.outlook.com (20.178.90.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Mon, 20 Jan 2020 16:30:49 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2644.026; Mon, 20 Jan 2020
 16:30:49 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 AM4PR08CA0055.eurprd08.prod.outlook.com (2603:10a6:205:2::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Mon, 20 Jan 2020 16:30:48 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 06/10] block/dirty-bitmap: add _next_dirty API
Thread-Topic: [PATCH v3 06/10] block/dirty-bitmap: add _next_dirty API
Thread-Index: AQHVtlOgdeEZtpGHH0igSKd2umc3c6fzul2AgAA27QA=
Date: Mon, 20 Jan 2020 16:30:49 +0000
Message-ID: <2641fe67-1035-e00b-131d-513aec6752a8@virtuozzo.com>
References: <20191219100348.24827-1-vsementsov@virtuozzo.com>
 <20191219100348.24827-7-vsementsov@virtuozzo.com>
 <0350481a-12ad-1608-79f1-b9f433963565@redhat.com>
In-Reply-To: <0350481a-12ad-1608-79f1-b9f433963565@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR08CA0055.eurprd08.prod.outlook.com
 (2603:10a6:205:2::26) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200120193047947
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 847fb085-4f4c-4359-6805-08d79dc61be1
x-ms-traffictypediagnostic: AM6PR08MB3733:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB3733AA2EF5496975C5C0044CC1320@AM6PR08MB3733.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(396003)(376002)(136003)(39840400004)(199004)(189003)(4326008)(81166006)(31686004)(16526019)(26005)(8676002)(186003)(5660300002)(81156014)(71200400001)(107886003)(6486002)(478600001)(8936002)(16576012)(316002)(53546011)(64756008)(66946007)(66476007)(66556008)(66446008)(110136005)(36756003)(956004)(54906003)(2616005)(2906002)(86362001)(31696002)(52116002)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3733;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ec/wamjNDo0C8l9Jx3lnY01yjNCjxm1UKNbkkZKpABo9Sak/MIraYUv4Rs+XuRVCaF7RR2QYT7eXzGM1OVedPZfyq0Q94LlGilyuogbtkL2hmmy5YW8b7R9FD3yk0MwWDv0dCeyLxYFRZEH4Mh0ZEVGK/9gPwEKyCts9tZhGBzqPYprvSEqHIol0tfEAOmnPVGblIVd5atd02WKpbtOSsOjo7TdfP0gDKxUmCF13+op6XXLOlf8qtSdZHZRgVi+vmTrvwYjFrhkImWGktSbwTh7V69VoywaVLnI/OI4KUjR7OZfnlpr1dP/IW/y+8OtG+G5GQt4QHo88KOrCPdIF9DcWIMdlimH8OihP2Z+hYY6aU29zHS5jlCJ6e+RgB+y+XOsrfBwa7ObxHGHplGZ0/ecjLzHKcMaUp+CaTkjsqB3vtjQ6EGsL9TJAokoD/FE5wEL2Kjn4U4gC75XimDyFBRlNoCr/WZZ/8hEEm1ddh7o=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <2E2DB0A5C7DC004B887A116753E4ACDC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847fb085-4f4c-4359-6805-08d79dc61be1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 16:30:49.4806 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z7RcTi3tDiuk1gslN03jU6up2MeOKkVVGnMx0jrucoqYexyz5upiirs/yz8SF26ARz4bfI9cpnVfw1v3QYj5Pw+6YlzsMPI9+1VZ7r2XZco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3733
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.21.138
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

20.01.2020 16:14, Max Reitz wrote:
> On 19.12.19 11:03, Vladimir Sementsov-Ogievskiy wrote:
>> We have bdrv_dirty_bitmap_next_zero, let's add corresponding
>> bdrv_dirty_bitmap_next_dirty, which is more comfortable to use than
>> bitmap iterators in some cases.
>>
>> For test modify test_hbitmap_next_zero_check_range to check both
>> next_zero and next_dirty and add some new checks.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/block/dirty-bitmap.h |   2 +
>>   include/qemu/hbitmap.h       |  13 ++++
>>   block/dirty-bitmap.c         |   6 ++
>>   tests/test-hbitmap.c         | 130 ++++++++++++++++++++---------------
>>   util/hbitmap.c               |  60 ++++++++--------
>>   5 files changed, 126 insertions(+), 85 deletions(-)
>=20
> [...]
>=20
>> diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
>> index b6e85f3d5d..a4b032b270 100644
>> --- a/include/qemu/hbitmap.h
>> +++ b/include/qemu/hbitmap.h
>> @@ -297,6 +297,19 @@ void hbitmap_free(HBitmap *hb);
>>    */
>>   void hbitmap_iter_init(HBitmapIter *hbi, const HBitmap *hb, uint64_t f=
irst);
>>  =20
>> +/*
>> + * hbitmap_next_dirty:
>> + *
>> + * Find next dirty bit within selected range. If not found, return -1.
>> + *
>> + * @hb: The HBitmap to operate on
>> + * @start: The bit to start from.
>> + * @count: Number of bits to proceed. If @start+@count > bitmap size, t=
he whole
>> + * bitmap is looked through. You can use UINT64_MAX as @count to search=
 up to
>=20
> I would=92ve said s/looked through/scanned/, but it matches
> hbitmap_next_zero()=92s documentation, so it=92s fine.
>=20
> But definitely s/UINT64_MAX/INT64_MAX/.
>=20
>> + * the bitmap end.
>> + */
>> +int64_t hbitmap_next_dirty(const HBitmap *hb, int64_t start, int64_t co=
unt);
>> +
>>   /* hbitmap_next_zero:
>>    *
>>    * Find next not dirty bit within selected range. If not found, return=
 -1.
>=20
> [...]
>=20
>> diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
>> index 0e1e5c64dd..e3f1b3f361 100644
>> --- a/tests/test-hbitmap.c
>> +++ b/tests/test-hbitmap.c
>> @@ -816,92 +816,108 @@ static void test_hbitmap_iter_and_reset(TestHBitm=
apData *data,
>>       hbitmap_iter_next(&hbi);
>>   }
>>  =20
>> -static void test_hbitmap_next_zero_check_range(TestHBitmapData *data,
>> -                                               uint64_t start,
>> -                                               uint64_t count)
>> +static void test_hbitmap_next_x_check_range(TestHBitmapData *data,
>> +                                            uint64_t start,
>> +                                            uint64_t count)
>=20
> Why not change the parameters to be signed while we=92re already here?
>=20
> [...]
>=20
>> diff --git a/util/hbitmap.c b/util/hbitmap.c
>> index df22f06be6..d23f4b9678 100644
>> --- a/util/hbitmap.c
>> +++ b/util/hbitmap.c
>> @@ -193,6 +193,30 @@ void hbitmap_iter_init(HBitmapIter *hbi, const HBit=
map *hb, uint64_t first)
>>       }
>>   }
>>  =20
>> +int64_t hbitmap_next_dirty(const HBitmap *hb, int64_t start, int64_t co=
unt)
>> +{
>> +    HBitmapIter hbi;
>> +    int64_t firt_dirty_off;
>=20
> Pre-existing, but isn=92t this just a typo that you could fix here?  (i.e=
.
> s/firt/first/)
>=20
> Apart from this minor things:

Agree with them.

>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20
>> +    uint64_t end;
>> +
>> +    assert(start >=3D 0 && count >=3D 0);
>> +
>> +    if (start >=3D hb->orig_size || count =3D=3D 0) {
>> +        return -1;
>> +    }
>> +
>> +    end =3D count > hb->orig_size - start ?
>=20


--=20
Best regards,
Vladimir

