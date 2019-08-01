Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4695CC19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 12:41:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E137120644
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 12:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YOPKRO54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E137120644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htAOP-0002DL-9N
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 08:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48316)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htANq-0001gK-3N
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 08:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htANo-0007Y9-Cz
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 08:40:38 -0400
Received: from mail-eopbgr60130.outbound.protection.outlook.com
 ([40.107.6.130]:50359 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1htANn-0007Xp-M1; Thu, 01 Aug 2019 08:40:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ls0JHeRZY4fqlPY8mXiebGOUcVCT236TVB+DHBzQ9jt3dtI1L2NY0TqzktkdVnnPufCvAgX1XqPpoCbMmCcZZjbm1/uAo0GkuQLuE9fY6eO1Bs2mc7YBrxRC8HVN7RXPvlQsJVStQEFNw9kTya/4mTnx2nF41iTUvQEKkYR5qYNUM/GSZfSQijzQB7bKrM7oxnKfF+pgIieIpbfF9Vc976detx+8LsgdeYjtGYvqntgHaaRFOIFyxZAYy2iA7/SVgl2X24IrsFtMy2qJSXkGvEb9Nmht1N8Dfw2/8vsQS3gjmHubnzo/462eRKpqOrX2dsHckOW4vjvZ3OtH66fo2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGOpLnHzMYqrwIznaCmhOpFEh9BJ4jKxNAy0m4QQm5A=;
 b=TDkXxuftggI0iuJZzv3fsKt715cqqCxuAx4yH9PDYO63WgjOvCbXZGV0KourncPY9ia0qsILTMpTgxnsHoMVrdStw/PYBpz8JiRMPPfiw+vZ50a9mL6+BK7JAHhDcp2SEQwYtdWlCZlpiOStTAaA5vSjoYp8xVoOTnK6Nxh2RVbBqPpRbVZH4GGBUHGddbZ+QBuVanwqOm9lzqrX62z09ejAQ+Z62rBij95U8V98tLw6YOv5mLHurrdSZNWWKfwQb4tMd4qrd2x0WJhVYVhkJbwFT2ez1dWk7VhGLBOPC+wADGJG7VUxPVvvGRvyL0yQVSTRqU6DEUD/yCH2uOjESg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGOpLnHzMYqrwIznaCmhOpFEh9BJ4jKxNAy0m4QQm5A=;
 b=YOPKRO54APgq7AYCKdMdi6V0MOApLWfWJ6kcuW7IhCrXjnFo54aq1mtjQTVUI0qopI2CI/JM4+uvxD5WKLRxdThZKo5qimmfY67Lkd+S4Gb2U4QjuAE4F14OO1P08XdCa9PlfWoP9ZUUoni67ZQcnU5MABJ2kbrFWjs0TyViaIk=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5531.eurprd08.prod.outlook.com (52.133.243.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Thu, 1 Aug 2019 12:40:32 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 12:40:32 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 3/3] block/backup: refactor write_flags
Thread-Index: AQHVRvRyYDfKfvF2I0uqR/7Rutw88Kbje1sAgAFpCoCAAUYpgIAAM1yA///PS4CAAAbIgIAABUkAgAAFaoA=
Date: Thu, 1 Aug 2019 12:40:32 +0000
Message-ID: <fc222b5c-0132-c1a3-7fe0-4c899de3e56c@virtuozzo.com>
References: <20190730163251.755248-1-vsementsov@virtuozzo.com>
 <20190730163251.755248-4-vsementsov@virtuozzo.com>
 <2b034619-ab55-a5f1-a1f4-ea14c4c5c18c@redhat.com>
 <f6927c00-5708-e471-e768-ef9d1e0c2dc6@virtuozzo.com>
 <12efde81-7a17-56c0-e50d-080574faa9f9@redhat.com>
 <29be5652-33d3-216c-a377-ed7d76c23c1b@virtuozzo.com>
 <f83ed7fb-b9cd-4d28-d58e-92357f3acc73@redhat.com>
 <d9c6118c-407c-c1cc-4503-d65aaae1057e@virtuozzo.com>
 <2225a89f-fe7e-e1be-c640-7281e8a20305@redhat.com>
In-Reply-To: <2225a89f-fe7e-e1be-c640-7281e8a20305@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0155.eurprd05.prod.outlook.com
 (2603:10a6:7:28::42) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190801154029939
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 399fc953-967b-4641-5927-08d7167d7149
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5531; 
x-ms-traffictypediagnostic: DB8PR08MB5531:
x-microsoft-antispam-prvs: <DB8PR08MB5531FA0F957D3D05B54028D6C1DE0@DB8PR08MB5531.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(396003)(136003)(39850400004)(346002)(189003)(199004)(52314003)(446003)(186003)(81156014)(2616005)(229853002)(6436002)(66946007)(86362001)(256004)(25786009)(81166006)(486006)(14444005)(68736007)(476003)(31686004)(110136005)(66556008)(26005)(54906003)(66066001)(52116002)(8676002)(6506007)(66446008)(5660300002)(6486002)(2501003)(7736002)(2906002)(66476007)(64756008)(71200400001)(6512007)(4326008)(8936002)(11346002)(36756003)(386003)(53546011)(76176011)(14454004)(316002)(305945005)(53936002)(6246003)(3846002)(31696002)(107886003)(71190400001)(102836004)(478600001)(99286004)(6116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5531;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Fa0oPY9IxcADHyJHJvSEnZ43tFkyA5BLxNI2GYxrbRlVWr9MfJ/wIvJqT2Ra9L2nGIYCaFmfO1xIqW9kduzm6B98pmfm8TL5aRNKJT5cdDowYGJ1W2qfeHa1EIOpJMsg5HdLDNI144SffiMCDpW11Ybiidn/D5698vlRicgW627hAbsOU3s6ie6AVXxzzYpRc+c0uPebo+SoRNp08/OJ4Jpn8ZG6fLCMhI534wiP0OIq0l6WO02jkVZI3ob8hx9QOU29WK6fkVVZf97PxTNvXqxBcexzO3p5EqXs/9OnUDJbR37iF8LmIJ7RcXVty5BG9v8/b+SDX8bUavoeXRgP3mfoaA0kc+ULfLiiDl/+Tnl3J134E031VvBEWPEH3hIklt3dfgMmXjL/JZXKTT50jk6UDAaf+TP0suUS4Fmr3x8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F47AF292852A2D4F8DC81A94E07E9477@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 399fc953-967b-4641-5927-08d7167d7149
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 12:40:32.4490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5531
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.130
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

MDEuMDguMjAxOSAxNToyMSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwMS4wOC4xOSAxNDowMiwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDAxLjA4LjIwMTkgMTQ6Mzcs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAwMS4wOC4xOSAxMzozMiwgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gMDEuMDguMjAxOSAxNDoyOCwgTWF4IFJlaXR6IHdy
b3RlOg0KPj4+Pj4gT24gMzEuMDcuMTkgMTg6MDEsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgd3JvdGU6DQo+Pj4+Pj4gMzAuMDcuMjAxOSAyMToyOCwgSm9obiBTbm93IHdyb3RlOg0KPj4+
Pj4+Pg0KPj4+Pj4+Pg0KPj4+Pj4+PiBPbiA3LzMwLzE5IDEyOjMyIFBNLCBWbGFkaW1pciBTZW1l
bnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4+Pj4+Pj4gd3JpdGUgZmxhZ3MgYXJlIGNvbnN0YW50
LCBsZXQncyBzdG9yZSBpdCBpbiBCYWNrdXBCbG9ja0pvYiBpbnN0ZWFkIG9mDQo+Pj4+Pj4+PiBy
ZWNhbGN1bGF0aW5nLiBJdCBhbHNvIG1ha2VzIHR3byBib29sZWFuIGZpZWxkcyB0byBiZSB1bnVz
ZWQsIHNvLA0KPj4+Pj4+Pj4gZHJvcCB0aGVtLg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IFNpZ25lZC1v
ZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpv
LmNvbT4NCj4+Pj4+Pj4+IC0tLQ0KPj4+Pj4+Pj4gICAgICBibG9jay9iYWNrdXAuYyB8IDI0ICsr
KysrKysrKysrKy0tLS0tLS0tLS0tLQ0KPj4+Pj4+Pj4gICAgICAxIGZpbGUgY2hhbmdlZCwgMTIg
aW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gZGlmZiAt
LWdpdCBhL2Jsb2NrL2JhY2t1cC5jIGIvYmxvY2svYmFja3VwLmMNCj4+Pj4+Pj4+IGluZGV4IGM1
Zjk0MTEwMWEuLjQ2NTE2NDllOWQgMTAwNjQ0DQo+Pj4+Pj4+PiAtLS0gYS9ibG9jay9iYWNrdXAu
Yw0KPj4+Pj4+Pj4gKysrIGIvYmxvY2svYmFja3VwLmMNCj4+Pj4+Pj4+IEBAIC00Nyw3ICs0Nyw2
IEBAIHR5cGVkZWYgc3RydWN0IEJhY2t1cEJsb2NrSm9iIHsNCj4+Pj4+Pj4+ICAgICAgICAgIHVp
bnQ2NF90IGxlbjsNCj4+Pj4+Pj4+ICAgICAgICAgIHVpbnQ2NF90IGJ5dGVzX3JlYWQ7DQo+Pj4+
Pj4+PiAgICAgICAgICBpbnQ2NF90IGNsdXN0ZXJfc2l6ZTsNCj4+Pj4+Pj4+IC0gICAgYm9vbCBj
b21wcmVzczsNCj4+Pj4+Pj4+ICAgICAgICAgIE5vdGlmaWVyV2l0aFJldHVybiBiZWZvcmVfd3Jp
dGU7DQo+Pj4+Pj4+PiAgICAgICAgICBRTElTVF9IRUFEKCwgQ293UmVxdWVzdCkgaW5mbGlnaHRf
cmVxczsNCj4+Pj4+Pj4+ICAgICAgDQo+Pj4+Pj4+PiBAQCAtNTUsNyArNTQsNyBAQCB0eXBlZGVm
IHN0cnVjdCBCYWNrdXBCbG9ja0pvYiB7DQo+Pj4+Pj4+PiAgICAgICAgICBib29sIHVzZV9jb3B5
X3JhbmdlOw0KPj4+Pj4+Pj4gICAgICAgICAgaW50NjRfdCBjb3B5X3JhbmdlX3NpemU7DQo+Pj4+
Pj4+PiAgICAgIA0KPj4+Pj4+Pj4gLSAgICBib29sIHNlcmlhbGl6ZV90YXJnZXRfd3JpdGVzOw0K
Pj4+Pj4+Pj4gKyAgICBCZHJ2UmVxdWVzdEZsYWdzIHdyaXRlX2ZsYWdzOw0KPj4+Pj4+Pj4gICAg
ICB9IEJhY2t1cEJsb2NrSm9iOw0KPj4+Pj4+Pj4gICAgICANCj4+Pj4+Pj4+ICAgICAgc3RhdGlj
IGNvbnN0IEJsb2NrSm9iRHJpdmVyIGJhY2t1cF9qb2JfZHJpdmVyOw0KPj4+Pj4+Pj4gQEAgLTEx
MCwxMCArMTA5LDYgQEAgc3RhdGljIGludCBjb3JvdXRpbmVfZm4gYmFja3VwX2Nvd193aXRoX2Jv
dW5jZV9idWZmZXIoQmFja3VwQmxvY2tKb2IgKmpvYiwNCj4+Pj4+Pj4+ICAgICAgICAgIEJsb2Nr
QmFja2VuZCAqYmxrID0gam9iLT5jb21tb24uYmxrOw0KPj4+Pj4+Pj4gICAgICAgICAgaW50IG5i
eXRlczsNCj4+Pj4+Pj4+ICAgICAgICAgIGludCByZWFkX2ZsYWdzID0gaXNfd3JpdGVfbm90aWZp
ZXIgPyBCRFJWX1JFUV9OT19TRVJJQUxJU0lORyA6IDA7DQo+Pj4+Pj4+PiAtICAgIGludCB3cml0
ZV9mbGFncyA9DQo+Pj4+Pj4+PiAtICAgICAgICAgICAgKGpvYi0+c2VyaWFsaXplX3RhcmdldF93
cml0ZXMgPyBCRFJWX1JFUV9TRVJJQUxJU0lORyA6IDApIHwNCj4+Pj4+Pj4+IC0gICAgICAgICAg
ICAoam9iLT5jb21wcmVzcyA/IEJEUlZfUkVRX1dSSVRFX0NPTVBSRVNTRUQgOiAwKTsNCj4+Pj4+
Pj4+IC0NCj4+Pj4+Pj4+ICAgICAgDQo+Pj4+Pj4+PiAgICAgICAgICBhc3NlcnQoUUVNVV9JU19B
TElHTkVEKHN0YXJ0LCBqb2ItPmNsdXN0ZXJfc2l6ZSkpOw0KPj4+Pj4+Pj4gICAgICAgICAgaGJp
dG1hcF9yZXNldChqb2ItPmNvcHlfYml0bWFwLCBzdGFydCwgam9iLT5jbHVzdGVyX3NpemUpOw0K
Pj4+Pj4+Pj4gQEAgLTEzMiw3ICsxMjcsNyBAQCBzdGF0aWMgaW50IGNvcm91dGluZV9mbiBiYWNr
dXBfY293X3dpdGhfYm91bmNlX2J1ZmZlcihCYWNrdXBCbG9ja0pvYiAqam9iLA0KPj4+Pj4+Pj4g
ICAgICAgICAgfQ0KPj4+Pj4+Pj4gICAgICANCj4+Pj4+Pj4+ICAgICAgICAgIHJldCA9IGJsa19j
b19wd3JpdGUoam9iLT50YXJnZXQsIHN0YXJ0LCBuYnl0ZXMsICpib3VuY2VfYnVmZmVyLA0KPj4+
Pj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgIHdyaXRlX2ZsYWdzKTsNCj4+Pj4+Pj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICBqb2ItPndyaXRlX2ZsYWdzKTsNCj4+Pj4+Pj4+ICAgICAg
ICAgIGlmIChyZXQgPCAwKSB7DQo+Pj4+Pj4+PiAgICAgICAgICAgICAgdHJhY2VfYmFja3VwX2Rv
X2Nvd193cml0ZV9mYWlsKGpvYiwgc3RhcnQsIHJldCk7DQo+Pj4+Pj4+PiAgICAgICAgICAgICAg
aWYgKGVycm9yX2lzX3JlYWQpIHsNCj4+Pj4+Pj4+IEBAIC0xNjAsNyArMTU1LDYgQEAgc3RhdGlj
IGludCBjb3JvdXRpbmVfZm4gYmFja3VwX2Nvd193aXRoX29mZmxvYWQoQmFja3VwQmxvY2tKb2Ig
KmpvYiwNCj4+Pj4+Pj4+ICAgICAgICAgIEJsb2NrQmFja2VuZCAqYmxrID0gam9iLT5jb21tb24u
YmxrOw0KPj4+Pj4+Pj4gICAgICAgICAgaW50IG5ieXRlczsNCj4+Pj4+Pj4+ICAgICAgICAgIGlu
dCByZWFkX2ZsYWdzID0gaXNfd3JpdGVfbm90aWZpZXIgPyBCRFJWX1JFUV9OT19TRVJJQUxJU0lO
RyA6IDA7DQo+Pj4+Pj4+PiAtICAgIGludCB3cml0ZV9mbGFncyA9IGpvYi0+c2VyaWFsaXplX3Rh
cmdldF93cml0ZXMgPyBCRFJWX1JFUV9TRVJJQUxJU0lORyA6IDA7DQo+Pj4+Pj4+PiAgICAgIA0K
Pj4+Pj4+Pj4gICAgICAgICAgYXNzZXJ0KFFFTVVfSVNfQUxJR05FRChqb2ItPmNvcHlfcmFuZ2Vf
c2l6ZSwgam9iLT5jbHVzdGVyX3NpemUpKTsNCj4+Pj4+Pj4+ICAgICAgICAgIGFzc2VydChRRU1V
X0lTX0FMSUdORUQoc3RhcnQsIGpvYi0+Y2x1c3Rlcl9zaXplKSk7DQo+Pj4+Pj4+PiBAQCAtMTY4
LDcgKzE2Miw3IEBAIHN0YXRpYyBpbnQgY29yb3V0aW5lX2ZuIGJhY2t1cF9jb3dfd2l0aF9vZmZs
b2FkKEJhY2t1cEJsb2NrSm9iICpqb2IsDQo+Pj4+Pj4+PiAgICAgICAgICBucl9jbHVzdGVycyA9
IERJVl9ST1VORF9VUChuYnl0ZXMsIGpvYi0+Y2x1c3Rlcl9zaXplKTsNCj4+Pj4+Pj4+ICAgICAg
ICAgIGhiaXRtYXBfcmVzZXQoam9iLT5jb3B5X2JpdG1hcCwgc3RhcnQsIGpvYi0+Y2x1c3Rlcl9z
aXplICogbnJfY2x1c3RlcnMpOw0KPj4+Pj4+Pj4gICAgICAgICAgcmV0ID0gYmxrX2NvX2NvcHlf
cmFuZ2UoYmxrLCBzdGFydCwgam9iLT50YXJnZXQsIHN0YXJ0LCBuYnl0ZXMsDQo+Pj4+Pj4+PiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlYWRfZmxhZ3MsIHdyaXRlX2ZsYWdzKTsNCj4+
Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVhZF9mbGFncywgam9iLT53cml0
ZV9mbGFncyk7DQo+Pj4+Pj4+PiAgICAgICAgICBpZiAocmV0IDwgMCkgew0KPj4+Pj4+Pj4gICAg
ICAgICAgICAgIHRyYWNlX2JhY2t1cF9kb19jb3dfY29weV9yYW5nZV9mYWlsKGpvYiwgc3RhcnQs
IHJldCk7DQo+Pj4+Pj4+PiAgICAgICAgICAgICAgaGJpdG1hcF9zZXQoam9iLT5jb3B5X2JpdG1h
cCwgc3RhcnQsIGpvYi0+Y2x1c3Rlcl9zaXplICogbnJfY2x1c3RlcnMpOw0KPj4+Pj4+Pj4gQEAg
LTYzOCwxMCArNjMyLDE2IEBAIEJsb2NrSm9iICpiYWNrdXBfam9iX2NyZWF0ZShjb25zdCBjaGFy
ICpqb2JfaWQsIEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPj4+Pj4+Pj4gICAgICAgICAgam9iLT5z
eW5jX21vZGUgPSBzeW5jX21vZGU7DQo+Pj4+Pj4+PiAgICAgICAgICBqb2ItPnN5bmNfYml0bWFw
ID0gc3luY19tb2RlID09IE1JUlJPUl9TWU5DX01PREVfSU5DUkVNRU5UQUwgPw0KPj4+Pj4+Pj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN5bmNfYml0bWFwIDogTlVMTDsNCj4+Pj4+Pj4+
IC0gICAgam9iLT5jb21wcmVzcyA9IGNvbXByZXNzOw0KPj4+Pj4+Pj4gICAgICANCj4+Pj4+Pj4+
IC0gICAgLyogRGV0ZWN0IGltYWdlLWZsZWVjaW5nIChhbmQgc2ltaWxhcikgc2NoZW1lcyAqLw0K
Pj4+Pj4+Pj4gLSAgICBqb2ItPnNlcmlhbGl6ZV90YXJnZXRfd3JpdGVzID0gYmRydl9jaGFpbl9j
b250YWlucyh0YXJnZXQsIGJzKTsNCj4+Pj4+Pj4+ICsgICAgLyoNCj4+Pj4+Pj4+ICsgICAgICog
U2V0IHdyaXRlIGZsYWdzOg0KPj4+Pj4+Pj4gKyAgICAgKiAgMS4gRGV0ZWN0IGltYWdlLWZsZWVj
aW5nIChhbmQgc2ltaWxhcikgc2NoZW1lcw0KPj4+Pj4+Pj4gKyAgICAgKiAgMi4gSGFuZGxlIGNv
bXByZXNzaW9uDQo+Pj4+Pj4+PiArICAgICAqLw0KPj4+Pj4+Pj4gKyAgICBqb2ItPndyaXRlX2Zs
YWdzID0NCj4+Pj4+Pj4+ICsgICAgICAgICAgICAoYmRydl9jaGFpbl9jb250YWlucyh0YXJnZXQs
IGJzKSA/IEJEUlZfUkVRX1NFUklBTElTSU5HIDogMCkgfA0KPj4+Pj4+Pj4gKyAgICAgICAgICAg
IChjb21wcmVzcyA/IEJEUlZfUkVRX1dSSVRFX0NPTVBSRVNTRUQgOiAwKTsNCj4+Pj4+Pj4+ICsN
Cj4+Pj4+Pj4+ICAgICAgICAgIGpvYi0+Y2x1c3Rlcl9zaXplID0gY2x1c3Rlcl9zaXplOw0KPj4+
Pj4+Pj4gICAgICAgICAgam9iLT5jb3B5X2JpdG1hcCA9IGNvcHlfYml0bWFwOw0KPj4+Pj4+Pj4g
ICAgICAgICAgY29weV9iaXRtYXAgPSBOVUxMOw0KPj4+Pj4+Pj4NCj4+Pj4+Pj4NCj4+Pj4+Pj4g
V2hhdCBoYXBwZW5zIGlmIHlvdSBkaWQgcGFzcyBCRFJWX1JFUV9XUklURV9DT01QUkVTU0VEIHRv
DQo+Pj4+Pj4+IGJsa19jb19jb3B5X3JhbmdlPyBJcyB0aGF0IHJlamVjdGVkIHNvbWV3aGVyZSBp
biB0aGUgc3RhY2s/DQo+Pj4+Pj4NCj4+Pj4+Pg0KPj4+Pj4+IEhtbSwgSSdtIGFmcmFpZCB0aGF0
IGl0IHdpbGwgYmUgc2lsZW50bHkgaWdub3JlZC4NCj4+Pj4+Pg0KPj4+Pj4+IEFuZCBJIGhhdmUg
b25lIHF1ZXN0aW9uIHJlbGF0ZWQgdG8gY29weSBvZmZsb2FkIHRvby4NCj4+Pj4+Pg0KPj4+Pj4+
IERvIHdlIHJlYWxseSBuZWVkIHRvIGhhbmRsZSBtYXhfdHJhbnNmZXIgaW4gYmFja3VwIGNvZGUg
Zm9yIGNvcHkgb2ZmbG9hZD8NCj4+Pj4+PiBJcyBtYXhfdHJhbnNmZXIgcmVsYXRlZCB0byBpdCBy
ZWFsbHk/DQo+Pj4+Pj4NCj4+Pj4+PiBBbnl3YXksIGJsLm1heF90cmFuc2ZlciBzaG91bGQgYmUg
aGFuZGxlZCBpbiBnZW5lcmljIGNvcHlfcmFuZ2UgY29kZSBpbiBibG9jay9pby5jDQo+Pj4+Pj4g
KGlmIGl0IHNob3VsZCBhdCBhbGwpLCBJJ20gZ29pbmcgdG8gZml4IGl0LCBidXQgbWF5IGJlLCBJ
IGNhbiBqdXN0IGRyb3AgdGhpcyBsaW1pdGF0aW9uDQo+Pj4+Pj4gZnJvbSBiYWNrdXA/DQo+Pj4+
Pg0KPj4+Pj4gT24gYSBxdWljayBnbGFuY2UsIGl0IGRvZXNu4oCZdCBsb29rIGxpa2UgYSBsaW1p
dGF0aW9uIHRvIG1lIGJ1dCBhY3R1YWxseQ0KPj4+Pj4gbGlrZSB0aGUgb3Bwb3NpdGUuICBiYWNr
dXBfY293X3dpdGhfYm91bmNlX2J1ZmZlcigpIG9ubHkgY29waWVzIHVwIHRvDQo+Pj4+PiBjbHVz
dGVyX3NpemUsIHdoZXJlYXMgYmFja3VwX2Nvd193aXRoX29mZmxvYWQoKSB3aWxsIGNvcHkgdXAg
dG8gdGhlDQo+Pj4+PiBtYXhpbXVtIHRyYW5zZmVyIHNpemUgcGVybWl0dGVkIGJ5IGJvdGggc291
cmNlIGFuZCB0YXJnZXQgZm9yIGNvcHkNCj4+Pj4+IG9mZmxvYWRpbmcuDQo+Pj4+Pg0KPj4+Pg0K
Pj4+PiBJIG1lYW4sIHdoeSBub3QgdG8ganVzdCBjb3B5IHRoZSB3aG9sZSBjaHVuayBjb21lcyBp
biBub3RpZmllciBhbmQgZG9uJ3QgY2FyZSBhYm91dA0KPj4+PiBtYXhfdHJhbnNmZXI/IEJhY2t1
cCBsb29wIGNvcGllcyBjbHVzdGVyIGJ5IGNsdXN0ZXIgYW55d2F5LCBzbyBvbmx5IG5vdGlmaWVy
IG1heSBjb3B5DQo+Pj4+IGxhcmdlciBjaHVuay4NCj4+Pg0KPj4+IE9uZSB0aGluZyB0aGF0IGNv
bWVzIHRvIG1pbmQgaXMgdGhlIGhiaXRtYXBfZ2V0KCkgY2hlY2sgaW4NCj4+PiBiYWNrdXBfZG9f
Y293KCkuICBZb3UgZG9u4oCZdCB3YW50IHRvIGNvcHkgZXZlcnl0aGluZyBqdXN0IGJlY2F1c2Ug
dGhlDQo+Pj4gZmlyc3QgY2x1c3RlciBuZWVkcyB0byBiZSBjb3BpZWQuDQo+Pj4NCj4+DQo+PiBI
bW0sIGJ1dCBzZWVtcyB0aGF0IHdlIGRvIGV4YWN0bHkgdGhpcywgYW5kIHRoaXMgaXMgd3Jvbmcu
IEJ1dCB0aGlzIGlzIHNlcGFyYXRlIHRoaW5nLi4NCj4gDQo+IFlvdeKAmXJlIHJpZ2h0LiAgSXTi
gJlzIHRvdGFsbHkgYnJva2VuLiAgTmljZS4NCj4gDQo+IFRoZSBmb2xsb3dpbmcgZ2V0cyBtZSBh
IG5pY2UgY29udGVudCBtaXNtYXRjaDoNCj4gDQo+ICQgLi9xZW11LWltZyBjcmVhdGUgLWYgcWNv
dzIgc3JjLnFjb3cyIDJNDQo+ICQgLi9xZW11LWlvIC1jICd3cml0ZSAtUCA0MiAwIDJNJyBzcmMu
cWNvdzINCj4gJCBjcCBzcmMucWNvdzIgcmVmLnFjb3cyDQo+IA0KPiB7ImV4ZWN1dGUiOiJxbXBf
Y2FwYWJpbGl0aWVzIn0NCj4geyJyZXR1cm4iOiB7fX0NCj4geyJleGVjdXRlIjoiYmxvY2tkZXYt
YWRkIiwiYXJndW1lbnRzIjoNCj4gICB7Im5vZGUtbmFtZSI6InNyYyIsImRyaXZlciI6InFjb3cy
IiwNCj4gICAgImZpbGUiOnsiZHJpdmVyIjoiZmlsZSIsImZpbGVuYW1lIjoic3JjLnFjb3cyIn19
fQ0KPiB7InJldHVybiI6IHt9fQ0KPiB7ImV4ZWN1dGUiOiJkcml2ZS1iYWNrdXAiLCJhcmd1bWVu
dHMiOg0KPiAgIHsiZGV2aWNlIjoic3JjIiwiam9iLWlkIjoiYmFja3VwIiwidGFyZ2V0IjoidGd0
LnFjb3cyIiwNCj4gICAgImZvcm1hdCI6InFjb3cyIiwic3luYyI6ImZ1bGwiLCJzcGVlZCI6MTA0
ODU3Nn19DQo+IHsidGltZXN0YW1wIjogeyJzZWNvbmRzIjogMTU2NDY2MTc0MiwgIm1pY3Jvc2Vj
b25kcyI6IDI2ODM4NH0sDQo+ICAgImV2ZW50IjogIkpPQl9TVEFUVVNfQ0hBTkdFIiwNCj4gICAg
ImRhdGEiOiB7InN0YXR1cyI6ICJjcmVhdGVkIiwgImlkIjogImJhY2t1cCJ9fQ0KPiB7InRpbWVz
dGFtcCI6IHsic2Vjb25kcyI6IDE1NjQ2NjE3NDIsICJtaWNyb3NlY29uZHMiOiAyNjg0MzZ9LA0K
PiAgICJldmVudCI6ICJKT0JfU1RBVFVTX0NIQU5HRSIsDQo+ICAgICJkYXRhIjogeyJzdGF0dXMi
OiAicnVubmluZyIsICJpZCI6ICJiYWNrdXAifX0NCj4geyJyZXR1cm4iOiB7fX0NCj4geyJleGVj
dXRlIjoiaHVtYW4tbW9uaXRvci1jb21tYW5kIiwNCj4gICAiYXJndW1lbnRzIjp7ImNvbW1hbmQt
bGluZSI6DQo+ICAgICAgICAgICAgICAgICJxZW11LWlvIHNyYyBcIndyaXRlIC1QIDIzIDExMTQx
MTIgNjU1MzZcIiJ9fQ0KPiB7InJldHVybiI6ICIifQ0KPiB7ImV4ZWN1dGUiOiJodW1hbi1tb25p
dG9yLWNvbW1hbmQiLA0KPiAgICJhcmd1bWVudHMiOnsiY29tbWFuZC1saW5lIjoNCj4gICAgICAg
ICAgICAgICAgInFlbXUtaW8gc3JjIFwid3JpdGUgLVAgNjYgMTA0ODU3NiAxTVwiIn19DQo+IHsi
cmV0dXJuIjogIiJ9DQo+IHsidGltZXN0YW1wIjogeyJzZWNvbmRzIjogMTU2NDY2MTc0NCwgIm1p
Y3Jvc2Vjb25kcyI6IDI3ODM2Mn0uDQo+ICAgImV2ZW50IjogIkpPQl9TVEFUVVNfQ0hBTkdFIiwN
Cj4gICAiZGF0YSI6IHsic3RhdHVzIjogIndhaXRpbmciLCAiaWQiOiAiYmFja3VwIn19DQo+IHsi
dGltZXN0YW1wIjogeyJzZWNvbmRzIjogMTU2NDY2MTc0NCwgIm1pY3Jvc2Vjb25kcyI6IDI3ODUz
NH0sDQo+ICAgImV2ZW50IjogIkpPQl9TVEFUVVNfQ0hBTkdFIiwNCj4gICAiZGF0YSI6IHsic3Rh
dHVzIjogInBlbmRpbmciLCAiaWQiOiAiYmFja3VwIn19DQo+IHsidGltZXN0YW1wIjogeyJzZWNv
bmRzIjogMTU2NDY2MTc0NCwgIm1pY3Jvc2Vjb25kcyI6IDI3ODc3OH0sDQo+ICAgImV2ZW50Ijog
IkJMT0NLX0pPQl9DT01QTEVURUQiLA0KPiAgICJkYXRhIjogeyJkZXZpY2UiOiAiYmFja3VwIiwg
ImxlbiI6IDIwOTcxNTIsICJvZmZzZXQiOiAyMTYyNjg4LA0KPiAgICAgICAgICAgICJzcGVlZCI6
IDEwNDg1NzYsICJ0eXBlIjogImJhY2t1cCJ9fQ0KPiB7ImV4ZWN1dGUiOiJxdWl0In0NCj4geyJ0
aW1lc3RhbXAiOiB7InNlY29uZHMiOiAxNTY0NjYxNzQ0LCAibWljcm9zZWNvbmRzIjogMjc4ODg0
fSwNCj4gICAiZXZlbnQiOiAiSk9CX1NUQVRVU19DSEFOR0UiLA0KPiAgICJkYXRhIjogeyJzdGF0
dXMiOiAiY29uY2x1ZGVkIiwgImlkIjogImJhY2t1cCJ9fQ0KPiB7InRpbWVzdGFtcCI6IHsic2Vj
b25kcyI6IDE1NjQ2NjE3NDQsICJtaWNyb3NlY29uZHMiOiAyNzg5NDZ9LA0KPiAgICJldmVudCI6
ICJKT0JfU1RBVFVTX0NIQU5HRSIsDQo+ICAgImRhdGEiOiB7InN0YXR1cyI6ICJudWxsIiwgImlk
IjogImJhY2t1cCJ9fQ0KPiB7InJldHVybiI6IHt9fQ0KPiANCj4gJCAuL3FlbXUtaW1nIGNvbXBh
cmUgc3JjLnFjb3cyDQo+IENvbnRlbnQgbWlzbWF0Y2ggYXQgb2Zmc2V0IDExMTQxMTIhDQo+IA0K
PiANCj4gQXd3IG1hYWFuLiAgU2V0dGluZyBjb3B5X3JhbmdlIHRvIGZhbHNlIOKAnGZpeGVz4oCd
IGl0LiAgSSBndWVzcyB0aGlz4oCZbGwNCj4gbmVlZCB0byBiZSBmaXhlZCBmb3IgNC4xLiA6LS8N
Cg0KT29wcyB5ZXMuIFdyaXRpbmcgInRoaXMgaXMgYSBzZXBhcmF0ZSB0aGluZy4uIiwgSSB0aG91
Z2h0IHRoYXQgaXQncyBub3QgdmVyeSBiYWQgdG8NCmNvcHkgbW9yZSB0aGFuIG5lZWRlZCwgYnV0
IGFjdHVhbGx5IHdlIG11c3Qgbm90IGNvcHkgY2x1c3RlcnMgbm90LWRpcnR5IGluIGNvcHlfYml0
bWFwLA0KYXMgdGhleSBtYXkgYWxyZWFkeSBiZSByZXdyaXR0ZW4gYnkgdGhlIGd1ZXN0Lg0KDQo+
IA0KPj4gQWJvdXQgY29weV9yYW5nZSwgSSBqdXN0IGRvbid0IHN1cmUgdGhhdCBtYXhfdHJhbnNm
ZXIgaXMgYSB0cnVlIHJlc3RyaWN0aW9uIGZvciBjb3B5X3JhbmdlLg0KPj4gRm9yIGV4YW1wbGUs
IGZvciBmaWxlX3Bvc2l4IG1heF90cmFuc2ZlciBjb21lcyBmcm9tIHNvbWUgc3BlY2lmaWMgaW9j
dGwgb3IgZnJvbSBzeXNmcy4uIElzDQo+PiBpdCBhcHByb3ByaWF0ZSBhcyBsaW1pdGF0aW9uIGZv
ciBjb3B5X2ZpbGVfcmFuZ2U/DQo+IA0KPiBXaG8ga25vd3MsIGJ1dCBpdOKAmXMgcHJvYmFibHkg
dGhlIGJlc3QgYXBwcm94aW1hdGlvbiB3ZSBoYXZlLg0KDQpPay4gVGhhbiBJJ2xsIHRyeSB0byBt
b3ZlIGhhbmRsaW5nIG9mIG1heF90cmFuc2ZlciBmb3IgY29weV9yYW5nZSBpbnRvIGJsb2NrL2lv
LCBsaWtlIGl0J3MgZG9uZSBmb3INCndyaXRlLg0KDQo+IA0KPj4gQWxzbywgTWF4LCBjb3VsZCB5
b3UgcGxlYXNlIHRha2UgYSBsb29rIGF0ICJbUEFUQ0ggdjNdIGJsb2Nram9iOiBkcmFpbiBhbGwg
am9iIG5vZGVzIGluIGJsb2NrX2pvYl9kcmFpbiINCj4+IHRocmVhZD8gTWF5YmUsIHdoYXQgSm9o
biBxdWVzdGlvbnMgaXMgb2J2aW91cyBmb3IgeW91Lg0KPiANCj4gUGVyaGFwcyBhZnRlciBmaXhp
bmcgYmFja3VwLiA6LS8NCj4gDQo+IE1heA0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZs
YWRpbWlyDQo=

