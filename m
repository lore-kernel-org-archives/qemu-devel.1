Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1914C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 12:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB8EB21835
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 12:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iDA7SBkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8EB21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itWBF-0006Ol-Ne
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 07:29:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itWAS-0005wn-PZ
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:28:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itWAO-000612-W7
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:28:32 -0500
Received: from mail-am6eur05on2108.outbound.protection.outlook.com
 ([40.107.22.108]:46575 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1itWAO-0005zy-EP; Mon, 20 Jan 2020 07:28:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PF0Ku6g0RHCyKWGs4s9gJczZATxVh8QwY749hcSy1tqt7FO7aU82zEtOtIaxOsOgOd7lxm34WWMqMUUHQKAMtMIMW0J1hxLLdhgbU9tOFU4wnIb6CXoQiJvr5S0YWNBmmi8D4L1TTiUIzRNykLanaWDk5VqKkNWsFQFQg27EOJzP4nc4cgwWuaw6K07CqjDFk4uRnQ8WJVt/Es6MiydgI/SERoBpj9MWz+hipYLJpzfWt4KFmpCaFUspHKLZi+0afvUdPdjJhRbu8i+3e0/zdQbvJ6YRiAP++4pa9BFglbdOHJGx9zDSdFRks3mgOQTEaBTClMOnqQ6UeO7GFZBTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alD9leOborb0utfTjhlQzljke6EpgozQt8LQ8NYhfsQ=;
 b=RFRuPVLl+GjdeXzleuJpAO2DsAcsqBRwWjQacUgNZ/LHLtuDMgZCaw6gMB4yuNqi92D0jW36Zj0kW93K1Ugf7MMwl/qJX4WIOQQBn5KouGc5Qo8SPKRe0a3loD7/VHD/FexBe1qmz+vu4cj6jt3saFcXqVSADcUN5KUb4lRyYO5VTRH2Vw/aqevR0MEjzPRKnKf4P1b6wAi31zrV62KQ+3e7NUx/Kp2l5zokZrKLxaoaIp8TO/7zDJMW5J3vY2pBfHmMmOP1AN125BF8nQsw6icZ4TwoHjML7qF46XDcKsVbDQkvj8QBU2NzWglO5NJ+Ro4n53vNrpcygNDbB7G1xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alD9leOborb0utfTjhlQzljke6EpgozQt8LQ8NYhfsQ=;
 b=iDA7SBkYHLWom0Tdeiw/ONxlZWFnRgi7wmjXR1RwDTyOtUj1DFwB4GlOqyJe89iuas9ELposLhvBsgU9KQMCHSbDzib7gOLMzukfRhQexbZitUvbwFtU3lgLCTJgeVFmvi1hOK3PsOHqoOeQlCjJlM9KDHyqk3uQnv/EnUHDiho=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4101.eurprd08.prod.outlook.com (20.179.0.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.22; Mon, 20 Jan 2020 12:28:26 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2644.026; Mon, 20 Jan 2020
 12:28:26 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0502CA0005.eurprd05.prod.outlook.com (2603:10a6:3:e3::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18 via Frontend Transport; Mon, 20 Jan 2020 12:28:25 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 05/10] block/dirty-bitmap: switch _next_dirty_area and
 _next_zero to int64_t
Thread-Topic: [PATCH v3 05/10] block/dirty-bitmap: switch _next_dirty_area and
 _next_zero to int64_t
Thread-Index: AQHVtlOgUpFQPqMlfES7+kiweMLEXqfzpZGAgAAH/oA=
Date: Mon, 20 Jan 2020 12:28:25 +0000
Message-ID: <c2f78255-c001-01a3-487a-f7cf224f86f8@virtuozzo.com>
References: <20191219100348.24827-1-vsementsov@virtuozzo.com>
 <20191219100348.24827-6-vsementsov@virtuozzo.com>
 <ee73d55c-7f4f-fda1-b651-ced940027b62@redhat.com>
In-Reply-To: <ee73d55c-7f4f-fda1-b651-ced940027b62@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0005.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::15) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200120152823413
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6effb02d-6f17-425b-aaa1-08d79da43f27
x-ms-traffictypediagnostic: AM6PR08MB4101:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB41014D1207662E730A848F1EC1320@AM6PR08MB4101.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39840400004)(189003)(199004)(956004)(66556008)(66476007)(4326008)(66946007)(316002)(478600001)(66446008)(64756008)(2906002)(16576012)(2616005)(36756003)(31686004)(5660300002)(110136005)(53546011)(107886003)(71200400001)(54906003)(26005)(8676002)(6486002)(81166006)(31696002)(8936002)(86362001)(186003)(52116002)(16526019)(81156014)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4101;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UcP9vmtJFkF0j9685qJdNGQB9MaRHtLH+UX43jyXC2MHUaEVG5CI2xDuSTmTH+GffzqzLVDLwbYaAhvuEQVZjr4851/KcoCgG3sCkT/ffMmJt0Ryf6j+oNCT0H2SLw4VtkZOpgp8WRYqN0mx1XbKCqo17bsjrViSm8QKtkHyKWWW6QtoOoHvTYEoOUa1bXKqCup/yZUdVc352mhJk6yGW7eG4Y8pXC4pvs5iyKP6Ct6n8bv/nPkBf05CgR/KQpbl0BrELzD4jYVlZr0dhVh2BvXVkSTpw/sGaYO70B3LaqfLiH3WaZtVce8RMBB/CRPkvDi9pi9GOCkv8ZyCwOZNPz60Xlv6wIpzr2IXt5o2FL3Bc13AC1beE6pKPFubz76E2Em5OMZSMDDsjtgkzNPRgN1/b2egSYMleSQ3XTTWxa47R8OWPr9d+mog6kpOC1fCSMSeSzWXL3jnEg+qHSYAOC//Om1xo3xruh5KmqUl1C8=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <F7E057CFD475094A9E45CF4E837208F0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6effb02d-6f17-425b-aaa1-08d79da43f27
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 12:28:25.9773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: spKzD3fONRm4DO93fnezoZMUU1+5ucr8cjDpWOxFbpLbV7W+GjlZMqvHq0XzU+Z2a83ryIt8g05NHa+cBqJzOFMDPQN96BrZSrdw1jOJzcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4101
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.22.108
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

20.01.2020 14:59, Max Reitz wrote:
> On 19.12.19 11:03, Vladimir Sementsov-Ogievskiy wrote:
>> We are going to introduce bdrv_dirty_bitmap_next_dirty so that same
>> variable may be used to store its return value and to be its parameter,
>> so it would int64_t.
>>
>> Similarly, we are going to refactor hbitmap_next_dirty_area to use
>> hbitmap_next_dirty together with hbitmap_next_zero, therefore we want
>> hbitmap_next_zero parameter type to be int64_t too.
>>
>> So, for convenience update all parameters of *_next_zero and
>> *_next_dirty_area to be int64_t.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/block/dirty-bitmap.h |  6 +++---
>>   include/qemu/hbitmap.h       |  7 +++----
>>   block/dirty-bitmap.c         |  6 +++---
>>   nbd/server.c                 |  2 +-
>>   tests/test-hbitmap.c         | 32 ++++++++++++++++----------------
>>   util/hbitmap.c               | 13 ++++++++-----
>>   6 files changed, 34 insertions(+), 32 deletions(-)
>=20
> [...]
>=20
>> diff --git a/util/hbitmap.c b/util/hbitmap.c
>> index b6d4b99a06..df22f06be6 100644
>> --- a/util/hbitmap.c
>> +++ b/util/hbitmap.c
>> @@ -193,7 +193,7 @@ void hbitmap_iter_init(HBitmapIter *hbi, const HBitm=
ap *hb, uint64_t first)
>>       }
>>   }
>>  =20
>> -int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start, uint64_t c=
ount)
>> +int64_t hbitmap_next_zero(const HBitmap *hb, int64_t start, int64_t cou=
nt)
>>   {
>>       size_t pos =3D (start >> hb->granularity) >> BITS_PER_LEVEL;
>>       unsigned long *last_lev =3D hb->levels[HBITMAP_LEVELS - 1];
>> @@ -202,6 +202,8 @@ int64_t hbitmap_next_zero(const HBitmap *hb, uint64_=
t start, uint64_t count)
>>       uint64_t end_bit, sz;
>>       int64_t res;
>>  =20
>> +    assert(start >=3D 0 && count >=3D 0);
>> +
>>       if (start >=3D hb->orig_size || count =3D=3D 0) {
>>           return -1;
>>       }
> As far as I can see, NBD just passes NBDRequest.from (which is a
> uint64_t) to this function (on NBD_CMD_BLOCK_STATUS).  Would this allow
> a malicious client to send a value > INT64_MAX, thus provoking an
> overflow and killing the server with this new assertion?


in nbd_co_receive_request() we have


     if (request->from > client->exp->size ||
         request->len > client->exp->size - request->from) {


So, we check that from is <=3D exp->size. and exp->size cant be greater tha=
n INT64_MAX,
as it derived from bdrv_getlength, which returns int64_t.



Interesting, should we be more strict in server:?

--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2178,7 +2178,7 @@ static int nbd_co_receive_request(NBDRequestData *req=
, NBDRequest *request,
          error_setg(errp, "Export is read-only");
          return -EROFS;
      }
-    if (request->from > client->exp->size ||
+    if (request->from >=3D client->exp->size ||
          request->len > client->exp->size - request->from) {
          error_setg(errp, "operation past EOF; From: %" PRIu64 ", Len: %" =
PRIu32
                     ", Size: %" PRIu64, request->from, request->len,

Or is it intentional? Looking through NBD spec I found only

    client MUST NOT use a length ... or which, when added to offset, would =
exceed the export size.

So, formally pair offset=3D<export size>, len=3D0 is valid...

>=20
> On second thought, we have this problem already everywhere in
> nbd_handle_request().  I don=92t see it or its caller ever checking
> whether the received values are in bounds, it just passes them to all
> kind of block layer functions that sometimes even just accept plain
> ints.  Well, I suppose all other functions just error out, so it
> probably isn=92t an actual problem in practice so far...
>=20
> Max
>=20


--=20
Best regards,
Vladimir

