Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D14C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F57A2087E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="X8txTHIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F57A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itZtE-0001wC-Cx
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 11:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itZsO-00013b-CC
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:26:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itZsK-0004Z4-KQ
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:26:08 -0500
Received: from mail-vi1eur05on2103.outbound.protection.outlook.com
 ([40.107.21.103]:38653 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1itZsJ-0004Xp-U1; Mon, 20 Jan 2020 11:26:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fz+eTMMOomHCgK7B1dEdT2H1YTwc1T7KB66ESNU7fxYqC1Wf6SFmo9v0aiEC8mgBC1aA3Rih/9LqrqdlSAzuvYwISHOq+XByPjWMab8hkdyvrrqQUt4O9n5SZo+v8Jb9i01fBmOq6nAdtknY0t0bZDYnk3TbQWBPm6qc8ejXSmVrMinY5DT2CkofKK9tT0zWnWL3/WDUvZI21rVAUYM2CFkYXWLebX3ZYnREq0HGZOgDVmjpwjUQGCCjkQFUq8Iq+JetmSVvchlML//ur1XurNYEMhiziTSF7LXFgCl2v0eHcNnrYvYzdz1ERwELfBwk7z2pRHylYY2olj4ukiD9rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApuibIdAz/5SVXzMRtkehmNwm+5vRiKWxgN3dRYpLO8=;
 b=JXLXW+tIeoIY0haUekP/oY3iixjBH8437eIhqMa8rzwbHYqycVnmNHXDH8FGdzrK9A9leM7HJoOlt/LlxrezFm6VJSPyQFMvCvOuMhpGgb0a6K9L8fdQEvSVNV9aIYup9rpOJfpvj6bRH/SqE8MSU18DzQSCD6X5ZgZBu9apkl0+qQnyoG2SXBEvsY/O6RWzccAhIpJcQj4D1xS8tnt3NPGkrE6y/VYWlvCm0lNaiuh/GPIYxejXVSKvLqMTP/2lsWDZIQ+WyoJZZ+A2j1I9kWui9RaLXMpKM+5FxU34sMNrPSRcqXDJ+19fs5sB4Hp91WeGC3c+NvWXLu+FdaCymQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApuibIdAz/5SVXzMRtkehmNwm+5vRiKWxgN3dRYpLO8=;
 b=X8txTHIy9TVIpwa2fIBM+ny+cFytkIrAjqde1FT67UCVEDrZmZ6DT729TQXzDSqW4PM0SOh9B3Z6GUkIrpXfKZURYWYw1igGh4JeRJaJDAHuslykoNSKyUcqm70gokyHbC2by/yhH1gxhFFaM5fAfWlxbG8wjth5lYHlShVmvxw=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3733.eurprd08.prod.outlook.com (20.178.90.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Mon, 20 Jan 2020 16:26:01 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2644.026; Mon, 20 Jan 2020
 16:26:01 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 AM0PR10CA0029.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Mon, 20 Jan 2020 16:26:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 07/10] block/dirty-bitmap: improve _next_dirty_area API
Thread-Topic: [PATCH v3 07/10] block/dirty-bitmap: improve _next_dirty_area API
Thread-Index: AQHVtlOgwAMIHIx5Lk+NBceudDW+kqfzxtCAgAApIYA=
Date: Mon, 20 Jan 2020 16:26:00 +0000
Message-ID: <02552d78-9483-dacd-a2ec-c940a29f2b25@virtuozzo.com>
References: <20191219100348.24827-1-vsementsov@virtuozzo.com>
 <20191219100348.24827-8-vsementsov@virtuozzo.com>
 <19eb1ec8-4532-5287-0c20-6b7749491da1@redhat.com>
In-Reply-To: <19eb1ec8-4532-5287-0c20-6b7749491da1@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR10CA0029.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::39) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200120192559029
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3150b293-2698-4111-8d9b-08d79dc56fe5
x-ms-traffictypediagnostic: AM6PR08MB3733:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB3733DC20ED737A885CB36777C1320@AM6PR08MB3733.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
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
x-microsoft-antispam-message-info: 3mthWMZWgOFuB588jLSS6lvgQZrLAUX72D2nfHy89O5JSQ+8c/ZvFn7lAWv7er87pJMvnslWQv80Y5MH2Mq6kMCVxW/NNLrWyym82ZXjpD0ubL67K+xiJF5B/3p09G2IiE+vz6wQuDHVLHCtxJWYqInm+OGWCqWFR7KR2LMuDfjYUAb/AvMF1hWpuhZBqoc0YTs7YecQ68KSep/K/BVdh5Wx1EFxibS/6Ph+/NySGlwg/VMwCbUTR7sO0/bJfl0Q/23E0i8sDwv4xtUBjBVcRsX1WjLZgQW4N3rVq9n6LXryFc0FATrLu7511WeTiqdn67jkdHt4XdwDvGtsT8tZKxPPAWMp5AOdKyn319BnFwy2SASW8C0k4R4ScI1YVyFAbNndLqQQbJULN3/SxwC5LhCsZZdNYgvALdewqcbXz2eH5ouen6vSCNPCUPp+XiREMLL+j7vR3pzb2uzbVgkgqsan4+0bToVKRZZ5tyXrSkGruSe+PJ5Lz+DCmSTAtR48
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <5758FA99B5B86F45B6A33DFCD7EF6152@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3150b293-2698-4111-8d9b-08d79dc56fe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 16:26:00.8687 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q/+3SmC50IUVyYS1TwxJPCKFLRhbHG802DUQeGBbqr9I5YykKOM1blago+VUnPxbKN/FZK4rOdFsk2lz5Y1IyUdM28n6td9ljMsW3b+m7xo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3733
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.21.103
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

20.01.2020 16:58, Max Reitz wrote:
> On 19.12.19 11:03, Vladimir Sementsov-Ogievskiy wrote:
>> Firstly, _next_dirty_area is for scenarios when we may contiguously
>> search for next dirty area inside some limited region, so it is more
>> comfortable to specify "end" which should not be recalculated on each
>> iteration.
>>
>> Secondly, let's add a possibility to limit resulting area size, not
>> limiting searching area. This will be used in NBD code in further
>> commit. (Note that now bdrv_dirty_bitmap_next_dirty_area is unused)
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/block/dirty-bitmap.h |  3 ++-
>>   include/qemu/hbitmap.h       | 25 ++++++++++++---------
>>   block/dirty-bitmap.c         |  6 +++--
>>   tests/test-hbitmap.c         | 43 +++++++++++++++++++++++-------------
>>   util/hbitmap.c               | 41 +++++++++++++++++++++-------------
>>   5 files changed, 74 insertions(+), 44 deletions(-)
>=20
> [...]
>=20
>>   /**
>> diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
>> index e3f1b3f361..d75e84a76a 100644
>> --- a/tests/test-hbitmap.c
>> +++ b/tests/test-hbitmap.c
>> @@ -920,18 +920,19 @@ static void test_hbitmap_next_x_after_truncate(Tes=
tHBitmapData *data,
>>       test_hbitmap_next_x_check(data, 0);
>>   }
>>  =20
>> -static void test_hbitmap_next_dirty_area_check(TestHBitmapData *data,
>> -                                               int64_t offset,
>> -                                               int64_t count)
>> +static void test_hbitmap_next_dirty_area_check_limited(TestHBitmapData =
*data,
>> +                                                       int64_t offset,
>> +                                                       int64_t count,
>> +                                                       int64_t max_dirt=
y)
>>   {
>>       int64_t off1, off2;
>>       int64_t len1 =3D 0, len2;
>>       bool ret1, ret2;
>>       int64_t end;
>>  =20
>> -    off1 =3D offset;
>> -    len1 =3D count;
>> -    ret1 =3D hbitmap_next_dirty_area(data->hb, &off1, &len1);
>> +    ret1 =3D hbitmap_next_dirty_area(data->hb,
>> +            offset, count =3D=3D INT64_MAX ? INT64_MAX : offset + count=
, max_dirty,
>> +            &off1, &len1);
>>  =20
>>       end =3D offset > data->size || data->size - offset < count ? data-=
>size :
>>                                                                  offset =
+ count;
>> @@ -940,21 +941,25 @@ static void test_hbitmap_next_dirty_area_check(Tes=
tHBitmapData *data,
>>           ;
>=20
> These empty statements look a bit weird to me.  But they=92re
> pre-existing, obviously.
>=20
>>       }
>>  =20
>> -    for (len2 =3D 1; off2 + len2 < end && hbitmap_get(data->hb, off2 + =
len2);
>> -         len2++) {
>> +    for (len2 =3D 1; (off2 + len2 < end && len2 < max_dirty &&
>> +                    hbitmap_get(data->hb, off2 + len2)); len2++)
>> +    {
>>           ;
>>       }
>=20
> [...]
>=20
>> diff --git a/util/hbitmap.c b/util/hbitmap.c
>> index d23f4b9678..2a1661ec1d 100644
>> --- a/util/hbitmap.c
>> +++ b/util/hbitmap.c
>> @@ -270,22 +270,34 @@ int64_t hbitmap_next_zero(const HBitmap *hb, int64=
_t start, int64_t count)
>>       return res;
>>   }
>>  =20
>> -bool hbitmap_next_dirty_area(const HBitmap *hb, int64_t *start, int64_t=
 *count)
>> +bool hbitmap_next_dirty_area(const HBitmap *hb, int64_t start, int64_t =
end,
>> +                             int64_t max_dirty_count,
>> +                             int64_t *dirty_start, int64_t *dirty_count=
)
>>   {
>> -    int64_t area_start, area_end;
>> +    int64_t next_zero;
>>  =20
>> -    area_start =3D hbitmap_next_dirty(hb, *start, *count);
>> -    if (area_start < 0) {
>> +    assert(start >=3D 0 && end >=3D 0 && max_dirty_count > 0);
>> +
>> +    if (start >=3D hb->orig_size || end <=3D start) {
>> +        return false;
>> +    }
>> +
>> +    end =3D MIN(end, hb->orig_size);
>=20
> You could put this assignment before the if () and then drop the =93start=
=94
> check from the condition.  (But that=92s mostly me itching to do
> optimizations.  I don=92t think it=92d make the code easier to read.)
>=20
> [...]
>=20
>> @@ -844,13 +856,12 @@ static void hbitmap_sparse_merge(HBitmap *dst, con=
st HBitmap *src)
>>       int64_t offset =3D 0;
>>       int64_t count =3D src->orig_size;
>=20
> These initializations are now unnecessary.  I=92d drop them because I fin=
d
> at least the one for @count a tiny bit confusing now.  (Because as a
> reader, I=92d wonder where this value is used.)
>=20
> With that done (or maybe not because you disagree):


I agree)

>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20
>>  =20
>> -    while (hbitmap_next_dirty_area(src, &offset, &count)) {
>> +    for (offset =3D 0;
>> +         hbitmap_next_dirty_area(src, offset, src->orig_size, INT64_MAX=
,
>> +                                 &offset, &count);
>> +         offset +=3D count)
>> +    {
>>           hbitmap_set(dst, offset, count);
>> -        offset +=3D count;
>> -        if (offset >=3D src->orig_size) {
>> -            break;
>> -        }
>> -        count =3D src->orig_size - offset;
>>       }
>>   }
>>  =20
>>
>=20


--=20
Best regards,
Vladimir

