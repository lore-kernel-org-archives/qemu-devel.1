Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0C6C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 12:03:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECDCF20644
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 12:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UHlEwL1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECDCF20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ht9nW-0007br-9E
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 08:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40158)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ht9ml-0006oK-7u
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 08:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ht9mj-000294-Pl
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 08:02:19 -0400
Received: from mail-eopbgr00120.outbound.protection.outlook.com
 ([40.107.0.120]:18753 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ht9mj-00028I-2m; Thu, 01 Aug 2019 08:02:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLDPUDAI3sToSyF0NB4XrKY1+tTjLJ94RyQh690XVkx/HQzgDeRS1V6wMBbZOR1B9RlM3aFq4fXZVzE6Veyct7jRQH0hDpgJBYBWylVdSaFhxwwQsznHSAaXhsGho1lJ03NfprBnbxVdrBjg1HoNL67Z3bJpqCRm7EsKU8t/5zIcDDdfSvVfexc3ut1IQrwhnjp7ua1fo256qn3PG1IsI7yeJWeS8TN68mGGvIY6NS/EGVjR0EL1ivXZbj/NT91WrCQ/b7P1YzTEBc/Xcy/mvxSYYMVo+Si4l9IJ9fG7omtaU+mGFIbD5mly8jf8XY+aeU+70+/DFODoREWY5cgQIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glFoOZiZIWn+3796sEKmDvlDGkJ84PukQ08+N37uBTQ=;
 b=lRjj+K32JJE2DmTy8hGrSDbrd3mEeT0eL5cZmji3uNr0p9VwI2rbyk0s48C8lwruniQlctsOOu5YVs6UT32c1GusIyDRaDnuGhLTTbUd7mn1Rt7M/ozlvzsVnlthC3KMLwqTwCEQAIUUmFpfvEs8Rh/nJEDudI9ULExEA/MJWab6uTSGgTGA2Tigtuvfz/+QV8Lv9sIUZcdkHLMMzMuwz1Yn8QVLEUZYOFeLK0XCKkwVnC5i5p861zD9bFZzHDkwD9ymrms70RHEzJWjo6Q2+rfiJWTpiH356zGrTM6Gn7FH6dzHIF0ZQCq5MOmmpp3IPUBkDss7fBh1pd2+HDBR/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glFoOZiZIWn+3796sEKmDvlDGkJ84PukQ08+N37uBTQ=;
 b=UHlEwL1TP9y8d7xgnb/EwMhU/S/qdqhNRbKHUCYfQPHZKJfUO5gfTTTy5o/lD9Ahg0hl/UfPGAqIYCwWFvE1gVtS6lJBgTUXytuTbvHbN0+dU1Asrv6XAlwg+qXZoHKIR0SbVDjLS/RvZuoPOetRa+twozG6IA1nyn69EtjmiJQ=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4028.eurprd08.prod.outlook.com (20.179.10.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Thu, 1 Aug 2019 12:02:13 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 12:02:13 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 3/3] block/backup: refactor write_flags
Thread-Index: AQHVRvRyYDfKfvF2I0uqR/7Rutw88Kbje1sAgAFpCoCAAUYpgIAAM1yA///PS4CAAAbIgA==
Date: Thu, 1 Aug 2019 12:02:13 +0000
Message-ID: <d9c6118c-407c-c1cc-4503-d65aaae1057e@virtuozzo.com>
References: <20190730163251.755248-1-vsementsov@virtuozzo.com>
 <20190730163251.755248-4-vsementsov@virtuozzo.com>
 <2b034619-ab55-a5f1-a1f4-ea14c4c5c18c@redhat.com>
 <f6927c00-5708-e471-e768-ef9d1e0c2dc6@virtuozzo.com>
 <12efde81-7a17-56c0-e50d-080574faa9f9@redhat.com>
 <29be5652-33d3-216c-a377-ed7d76c23c1b@virtuozzo.com>
 <f83ed7fb-b9cd-4d28-d58e-92357f3acc73@redhat.com>
In-Reply-To: <f83ed7fb-b9cd-4d28-d58e-92357f3acc73@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P195CA0023.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::33)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190801150211233
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cdf60186-1361-4861-533f-08d716781716
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4028; 
x-ms-traffictypediagnostic: DB8PR08MB4028:
x-microsoft-antispam-prvs: <DB8PR08MB40281FEA43C6D3932AAF4FE4C1DE0@DB8PR08MB4028.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(366004)(136003)(346002)(376002)(199004)(189003)(52314003)(8676002)(14454004)(25786009)(81166006)(99286004)(86362001)(4326008)(478600001)(81156014)(52116002)(66446008)(31696002)(5660300002)(6246003)(110136005)(8936002)(107886003)(316002)(66946007)(66556008)(66476007)(64756008)(54906003)(31686004)(53546011)(102836004)(476003)(53936002)(26005)(186003)(71200400001)(71190400001)(229853002)(11346002)(68736007)(2616005)(446003)(6506007)(66066001)(2906002)(386003)(2501003)(6116002)(3846002)(36756003)(6512007)(14444005)(256004)(76176011)(6486002)(486006)(6436002)(305945005)(7736002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4028;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iRS97jGTjj9i0LUKDjkomvpuRHr9fDbMMRqe4J7tAp5hg3xUHq4ETKdJ7zAQ5Ad3lwgdoyIWLR5E8vTu8rr3JsE4Yv6+JeM0XuSVzbCnSR1JRpTVP1ePX1ObmC6W8VOkVRx3exAjBVG/s6QHGSC8ViX+fpDmoa6hTuZy0ggElZa/DVPRxLu0bJhbyULG+/BgEnbf8iYJsp1i8XnHB6zwcGA6gz0t2p1YTaaywzi6c6S8v2U+reBY6htY0mD6MoKYdaHFmPxz2R3drtLYtR0QWkeMe5Kmo1CgbB9W4M8X+dsbFBvxSTtEczVVA9E4xXNgKGJmZEL3gJ/RyAAE9Tjt4TX65ronTsiFzFH6digSKZm/zSjDRKtw10STKQ8WNSDf8WvHAO1QYIMkzhTNC6bKIKriyUpzfdt6lHKZaP2EGcU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F0D0A5FEE33FB4EB1F86F56100E466A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf60186-1361-4861-533f-08d716781716
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 12:02:13.6470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4028
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.120
Subject: Re: [Qemu-devel] [PATCH 3/3] block/backup: refactor write_flags
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMDguMjAxOSAxNDozNywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwMS4wOC4xOSAxMzozMiwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDAxLjA4LjIwMTkgMTQ6Mjgs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAzMS4wNy4xOSAxODowMSwgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gMzAuMDcuMjAxOSAyMToyOCwgSm9obiBTbm93IHdy
b3RlOg0KPj4+Pj4NCj4+Pj4+DQo+Pj4+PiBPbiA3LzMwLzE5IDEyOjMyIFBNLCBWbGFkaW1pciBT
ZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4+Pj4+IHdyaXRlIGZsYWdzIGFyZSBjb25zdGFu
dCwgbGV0J3Mgc3RvcmUgaXQgaW4gQmFja3VwQmxvY2tKb2IgaW5zdGVhZCBvZg0KPj4+Pj4+IHJl
Y2FsY3VsYXRpbmcuIEl0IGFsc28gbWFrZXMgdHdvIGJvb2xlYW4gZmllbGRzIHRvIGJlIHVudXNl
ZCwgc28sDQo+Pj4+Pj4gZHJvcCB0aGVtLg0KPj4+Pj4+DQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTog
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0K
Pj4+Pj4+IC0tLQ0KPj4+Pj4+ICAgICBibG9jay9iYWNrdXAuYyB8IDI0ICsrKysrKysrKysrKy0t
LS0tLS0tLS0tLQ0KPj4+Pj4+ICAgICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwg
MTIgZGVsZXRpb25zKC0pDQo+Pj4+Pj4NCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvYmxvY2svYmFja3Vw
LmMgYi9ibG9jay9iYWNrdXAuYw0KPj4+Pj4+IGluZGV4IGM1Zjk0MTEwMWEuLjQ2NTE2NDllOWQg
MTAwNjQ0DQo+Pj4+Pj4gLS0tIGEvYmxvY2svYmFja3VwLmMNCj4+Pj4+PiArKysgYi9ibG9jay9i
YWNrdXAuYw0KPj4+Pj4+IEBAIC00Nyw3ICs0Nyw2IEBAIHR5cGVkZWYgc3RydWN0IEJhY2t1cEJs
b2NrSm9iIHsNCj4+Pj4+PiAgICAgICAgIHVpbnQ2NF90IGxlbjsNCj4+Pj4+PiAgICAgICAgIHVp
bnQ2NF90IGJ5dGVzX3JlYWQ7DQo+Pj4+Pj4gICAgICAgICBpbnQ2NF90IGNsdXN0ZXJfc2l6ZTsN
Cj4+Pj4+PiAtICAgIGJvb2wgY29tcHJlc3M7DQo+Pj4+Pj4gICAgICAgICBOb3RpZmllcldpdGhS
ZXR1cm4gYmVmb3JlX3dyaXRlOw0KPj4+Pj4+ICAgICAgICAgUUxJU1RfSEVBRCgsIENvd1JlcXVl
c3QpIGluZmxpZ2h0X3JlcXM7DQo+Pj4+Pj4gICAgIA0KPj4+Pj4+IEBAIC01NSw3ICs1NCw3IEBA
IHR5cGVkZWYgc3RydWN0IEJhY2t1cEJsb2NrSm9iIHsNCj4+Pj4+PiAgICAgICAgIGJvb2wgdXNl
X2NvcHlfcmFuZ2U7DQo+Pj4+Pj4gICAgICAgICBpbnQ2NF90IGNvcHlfcmFuZ2Vfc2l6ZTsNCj4+
Pj4+PiAgICAgDQo+Pj4+Pj4gLSAgICBib29sIHNlcmlhbGl6ZV90YXJnZXRfd3JpdGVzOw0KPj4+
Pj4+ICsgICAgQmRydlJlcXVlc3RGbGFncyB3cml0ZV9mbGFnczsNCj4+Pj4+PiAgICAgfSBCYWNr
dXBCbG9ja0pvYjsNCj4+Pj4+PiAgICAgDQo+Pj4+Pj4gICAgIHN0YXRpYyBjb25zdCBCbG9ja0pv
YkRyaXZlciBiYWNrdXBfam9iX2RyaXZlcjsNCj4+Pj4+PiBAQCAtMTEwLDEwICsxMDksNiBAQCBz
dGF0aWMgaW50IGNvcm91dGluZV9mbiBiYWNrdXBfY293X3dpdGhfYm91bmNlX2J1ZmZlcihCYWNr
dXBCbG9ja0pvYiAqam9iLA0KPj4+Pj4+ICAgICAgICAgQmxvY2tCYWNrZW5kICpibGsgPSBqb2It
PmNvbW1vbi5ibGs7DQo+Pj4+Pj4gICAgICAgICBpbnQgbmJ5dGVzOw0KPj4+Pj4+ICAgICAgICAg
aW50IHJlYWRfZmxhZ3MgPSBpc193cml0ZV9ub3RpZmllciA/IEJEUlZfUkVRX05PX1NFUklBTElT
SU5HIDogMDsNCj4+Pj4+PiAtICAgIGludCB3cml0ZV9mbGFncyA9DQo+Pj4+Pj4gLSAgICAgICAg
ICAgIChqb2ItPnNlcmlhbGl6ZV90YXJnZXRfd3JpdGVzID8gQkRSVl9SRVFfU0VSSUFMSVNJTkcg
OiAwKSB8DQo+Pj4+Pj4gLSAgICAgICAgICAgIChqb2ItPmNvbXByZXNzID8gQkRSVl9SRVFfV1JJ
VEVfQ09NUFJFU1NFRCA6IDApOw0KPj4+Pj4+IC0NCj4+Pj4+PiAgICAgDQo+Pj4+Pj4gICAgICAg
ICBhc3NlcnQoUUVNVV9JU19BTElHTkVEKHN0YXJ0LCBqb2ItPmNsdXN0ZXJfc2l6ZSkpOw0KPj4+
Pj4+ICAgICAgICAgaGJpdG1hcF9yZXNldChqb2ItPmNvcHlfYml0bWFwLCBzdGFydCwgam9iLT5j
bHVzdGVyX3NpemUpOw0KPj4+Pj4+IEBAIC0xMzIsNyArMTI3LDcgQEAgc3RhdGljIGludCBjb3Jv
dXRpbmVfZm4gYmFja3VwX2Nvd193aXRoX2JvdW5jZV9idWZmZXIoQmFja3VwQmxvY2tKb2IgKmpv
YiwNCj4+Pj4+PiAgICAgICAgIH0NCj4+Pj4+PiAgICAgDQo+Pj4+Pj4gICAgICAgICByZXQgPSBi
bGtfY29fcHdyaXRlKGpvYi0+dGFyZ2V0LCBzdGFydCwgbmJ5dGVzLCAqYm91bmNlX2J1ZmZlciwN
Cj4+Pj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgd3JpdGVfZmxhZ3MpOw0KPj4+Pj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICBqb2ItPndyaXRlX2ZsYWdzKTsNCj4+Pj4+PiAgICAgICAg
IGlmIChyZXQgPCAwKSB7DQo+Pj4+Pj4gICAgICAgICAgICAgdHJhY2VfYmFja3VwX2RvX2Nvd193
cml0ZV9mYWlsKGpvYiwgc3RhcnQsIHJldCk7DQo+Pj4+Pj4gICAgICAgICAgICAgaWYgKGVycm9y
X2lzX3JlYWQpIHsNCj4+Pj4+PiBAQCAtMTYwLDcgKzE1NSw2IEBAIHN0YXRpYyBpbnQgY29yb3V0
aW5lX2ZuIGJhY2t1cF9jb3dfd2l0aF9vZmZsb2FkKEJhY2t1cEJsb2NrSm9iICpqb2IsDQo+Pj4+
Pj4gICAgICAgICBCbG9ja0JhY2tlbmQgKmJsayA9IGpvYi0+Y29tbW9uLmJsazsNCj4+Pj4+PiAg
ICAgICAgIGludCBuYnl0ZXM7DQo+Pj4+Pj4gICAgICAgICBpbnQgcmVhZF9mbGFncyA9IGlzX3dy
aXRlX25vdGlmaWVyID8gQkRSVl9SRVFfTk9fU0VSSUFMSVNJTkcgOiAwOw0KPj4+Pj4+IC0gICAg
aW50IHdyaXRlX2ZsYWdzID0gam9iLT5zZXJpYWxpemVfdGFyZ2V0X3dyaXRlcyA/IEJEUlZfUkVR
X1NFUklBTElTSU5HIDogMDsNCj4+Pj4+PiAgICAgDQo+Pj4+Pj4gICAgICAgICBhc3NlcnQoUUVN
VV9JU19BTElHTkVEKGpvYi0+Y29weV9yYW5nZV9zaXplLCBqb2ItPmNsdXN0ZXJfc2l6ZSkpOw0K
Pj4+Pj4+ICAgICAgICAgYXNzZXJ0KFFFTVVfSVNfQUxJR05FRChzdGFydCwgam9iLT5jbHVzdGVy
X3NpemUpKTsNCj4+Pj4+PiBAQCAtMTY4LDcgKzE2Miw3IEBAIHN0YXRpYyBpbnQgY29yb3V0aW5l
X2ZuIGJhY2t1cF9jb3dfd2l0aF9vZmZsb2FkKEJhY2t1cEJsb2NrSm9iICpqb2IsDQo+Pj4+Pj4g
ICAgICAgICBucl9jbHVzdGVycyA9IERJVl9ST1VORF9VUChuYnl0ZXMsIGpvYi0+Y2x1c3Rlcl9z
aXplKTsNCj4+Pj4+PiAgICAgICAgIGhiaXRtYXBfcmVzZXQoam9iLT5jb3B5X2JpdG1hcCwgc3Rh
cnQsIGpvYi0+Y2x1c3Rlcl9zaXplICogbnJfY2x1c3RlcnMpOw0KPj4+Pj4+ICAgICAgICAgcmV0
ID0gYmxrX2NvX2NvcHlfcmFuZ2UoYmxrLCBzdGFydCwgam9iLT50YXJnZXQsIHN0YXJ0LCBuYnl0
ZXMsDQo+Pj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWFkX2ZsYWdzLCB3cml0
ZV9mbGFncyk7DQo+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWFkX2ZsYWdz
LCBqb2ItPndyaXRlX2ZsYWdzKTsNCj4+Pj4+PiAgICAgICAgIGlmIChyZXQgPCAwKSB7DQo+Pj4+
Pj4gICAgICAgICAgICAgdHJhY2VfYmFja3VwX2RvX2Nvd19jb3B5X3JhbmdlX2ZhaWwoam9iLCBz
dGFydCwgcmV0KTsNCj4+Pj4+PiAgICAgICAgICAgICBoYml0bWFwX3NldChqb2ItPmNvcHlfYml0
bWFwLCBzdGFydCwgam9iLT5jbHVzdGVyX3NpemUgKiBucl9jbHVzdGVycyk7DQo+Pj4+Pj4gQEAg
LTYzOCwxMCArNjMyLDE2IEBAIEJsb2NrSm9iICpiYWNrdXBfam9iX2NyZWF0ZShjb25zdCBjaGFy
ICpqb2JfaWQsIEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPj4+Pj4+ICAgICAgICAgam9iLT5zeW5j
X21vZGUgPSBzeW5jX21vZGU7DQo+Pj4+Pj4gICAgICAgICBqb2ItPnN5bmNfYml0bWFwID0gc3lu
Y19tb2RlID09IE1JUlJPUl9TWU5DX01PREVfSU5DUkVNRU5UQUwgPw0KPj4+Pj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHN5bmNfYml0bWFwIDogTlVMTDsNCj4+Pj4+PiAtICAgIGpvYi0+
Y29tcHJlc3MgPSBjb21wcmVzczsNCj4+Pj4+PiAgICAgDQo+Pj4+Pj4gLSAgICAvKiBEZXRlY3Qg
aW1hZ2UtZmxlZWNpbmcgKGFuZCBzaW1pbGFyKSBzY2hlbWVzICovDQo+Pj4+Pj4gLSAgICBqb2It
PnNlcmlhbGl6ZV90YXJnZXRfd3JpdGVzID0gYmRydl9jaGFpbl9jb250YWlucyh0YXJnZXQsIGJz
KTsNCj4+Pj4+PiArICAgIC8qDQo+Pj4+Pj4gKyAgICAgKiBTZXQgd3JpdGUgZmxhZ3M6DQo+Pj4+
Pj4gKyAgICAgKiAgMS4gRGV0ZWN0IGltYWdlLWZsZWVjaW5nIChhbmQgc2ltaWxhcikgc2NoZW1l
cw0KPj4+Pj4+ICsgICAgICogIDIuIEhhbmRsZSBjb21wcmVzc2lvbg0KPj4+Pj4+ICsgICAgICov
DQo+Pj4+Pj4gKyAgICBqb2ItPndyaXRlX2ZsYWdzID0NCj4+Pj4+PiArICAgICAgICAgICAgKGJk
cnZfY2hhaW5fY29udGFpbnModGFyZ2V0LCBicykgPyBCRFJWX1JFUV9TRVJJQUxJU0lORyA6IDAp
IHwNCj4+Pj4+PiArICAgICAgICAgICAgKGNvbXByZXNzID8gQkRSVl9SRVFfV1JJVEVfQ09NUFJF
U1NFRCA6IDApOw0KPj4+Pj4+ICsNCj4+Pj4+PiAgICAgICAgIGpvYi0+Y2x1c3Rlcl9zaXplID0g
Y2x1c3Rlcl9zaXplOw0KPj4+Pj4+ICAgICAgICAgam9iLT5jb3B5X2JpdG1hcCA9IGNvcHlfYml0
bWFwOw0KPj4+Pj4+ICAgICAgICAgY29weV9iaXRtYXAgPSBOVUxMOw0KPj4+Pj4+DQo+Pj4+Pg0K
Pj4+Pj4gV2hhdCBoYXBwZW5zIGlmIHlvdSBkaWQgcGFzcyBCRFJWX1JFUV9XUklURV9DT01QUkVT
U0VEIHRvDQo+Pj4+PiBibGtfY29fY29weV9yYW5nZT8gSXMgdGhhdCByZWplY3RlZCBzb21ld2hl
cmUgaW4gdGhlIHN0YWNrPw0KPj4+Pg0KPj4+Pg0KPj4+PiBIbW0sIEknbSBhZnJhaWQgdGhhdCBp
dCB3aWxsIGJlIHNpbGVudGx5IGlnbm9yZWQuDQo+Pj4+DQo+Pj4+IEFuZCBJIGhhdmUgb25lIHF1
ZXN0aW9uIHJlbGF0ZWQgdG8gY29weSBvZmZsb2FkIHRvby4NCj4+Pj4NCj4+Pj4gRG8gd2UgcmVh
bGx5IG5lZWQgdG8gaGFuZGxlIG1heF90cmFuc2ZlciBpbiBiYWNrdXAgY29kZSBmb3IgY29weSBv
ZmZsb2FkPw0KPj4+PiBJcyBtYXhfdHJhbnNmZXIgcmVsYXRlZCB0byBpdCByZWFsbHk/DQo+Pj4+
DQo+Pj4+IEFueXdheSwgYmwubWF4X3RyYW5zZmVyIHNob3VsZCBiZSBoYW5kbGVkIGluIGdlbmVy
aWMgY29weV9yYW5nZSBjb2RlIGluIGJsb2NrL2lvLmMNCj4+Pj4gKGlmIGl0IHNob3VsZCBhdCBh
bGwpLCBJJ20gZ29pbmcgdG8gZml4IGl0LCBidXQgbWF5IGJlLCBJIGNhbiBqdXN0IGRyb3AgdGhp
cyBsaW1pdGF0aW9uDQo+Pj4+IGZyb20gYmFja3VwPw0KPj4+DQo+Pj4gT24gYSBxdWljayBnbGFu
Y2UsIGl0IGRvZXNu4oCZdCBsb29rIGxpa2UgYSBsaW1pdGF0aW9uIHRvIG1lIGJ1dCBhY3R1YWxs
eQ0KPj4+IGxpa2UgdGhlIG9wcG9zaXRlLiAgYmFja3VwX2Nvd193aXRoX2JvdW5jZV9idWZmZXIo
KSBvbmx5IGNvcGllcyB1cCB0bw0KPj4+IGNsdXN0ZXJfc2l6ZSwgd2hlcmVhcyBiYWNrdXBfY293
X3dpdGhfb2ZmbG9hZCgpIHdpbGwgY29weSB1cCB0byB0aGUNCj4+PiBtYXhpbXVtIHRyYW5zZmVy
IHNpemUgcGVybWl0dGVkIGJ5IGJvdGggc291cmNlIGFuZCB0YXJnZXQgZm9yIGNvcHkNCj4+PiBv
ZmZsb2FkaW5nLg0KPj4+DQo+Pg0KPj4gSSBtZWFuLCB3aHkgbm90IHRvIGp1c3QgY29weSB0aGUg
d2hvbGUgY2h1bmsgY29tZXMgaW4gbm90aWZpZXIgYW5kIGRvbid0IGNhcmUgYWJvdXQNCj4+IG1h
eF90cmFuc2Zlcj8gQmFja3VwIGxvb3AgY29waWVzIGNsdXN0ZXIgYnkgY2x1c3RlciBhbnl3YXks
IHNvIG9ubHkgbm90aWZpZXIgbWF5IGNvcHkNCj4+IGxhcmdlciBjaHVuay4NCj4gDQo+IE9uZSB0
aGluZyB0aGF0IGNvbWVzIHRvIG1pbmQgaXMgdGhlIGhiaXRtYXBfZ2V0KCkgY2hlY2sgaW4NCj4g
YmFja3VwX2RvX2NvdygpLiAgWW91IGRvbuKAmXQgd2FudCB0byBjb3B5IGV2ZXJ5dGhpbmcganVz
dCBiZWNhdXNlIHRoZQ0KPiBmaXJzdCBjbHVzdGVyIG5lZWRzIHRvIGJlIGNvcGllZC4NCj4gDQoN
CkhtbSwgYnV0IHNlZW1zIHRoYXQgd2UgZG8gZXhhY3RseSB0aGlzLCBhbmQgdGhpcyBpcyB3cm9u
Zy4gQnV0IHRoaXMgaXMgc2VwYXJhdGUgdGhpbmcuLg0KDQoNCkFib3V0IGNvcHlfcmFuZ2UsIEkg
anVzdCBkb24ndCBzdXJlIHRoYXQgbWF4X3RyYW5zZmVyIGlzIGEgdHJ1ZSByZXN0cmljdGlvbiBm
b3IgY29weV9yYW5nZS4NCkZvciBleGFtcGxlLCBmb3IgZmlsZV9wb3NpeCBtYXhfdHJhbnNmZXIg
Y29tZXMgZnJvbSBzb21lIHNwZWNpZmljIGlvY3RsIG9yIGZyb20gc3lzZnMuLiBJcw0KaXQgYXBw
cm9wcmlhdGUgYXMgbGltaXRhdGlvbiBmb3IgY29weV9maWxlX3JhbmdlPw0KDQpBbHNvLCBNYXgs
IGNvdWxkIHlvdSBwbGVhc2UgdGFrZSBhIGxvb2sgYXQgIltQQVRDSCB2M10gYmxvY2tqb2I6IGRy
YWluIGFsbCBqb2Igbm9kZXMgaW4gYmxvY2tfam9iX2RyYWluIg0KdGhyZWFkPyBNYXliZSwgd2hh
dCBKb2huIHF1ZXN0aW9ucyBpcyBvYnZpb3VzIGZvciB5b3UuDQoNCi0tIA0KQmVzdCByZWdhcmRz
LA0KVmxhZGltaXINCg==

