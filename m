Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF39CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:39:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1254A222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Vd68/iKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1254A222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLTPZ-0008Oo-9A
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iLTOo-0007v4-AY
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:38:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iLTOm-00050t-TN
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:38:38 -0400
Received: from mail-eopbgr140128.outbound.protection.outlook.com
 ([40.107.14.128]:21728 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iLTOm-00050N-Md; Fri, 18 Oct 2019 10:38:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+rRluJGOAkq3v+Cbukrxs4CkxMJqGIJKmlQko79sC6P07+F7AOoynKWOqHnHjK0tZo4z1Ta2xgsJgyzeyoIc+wA9Dpu1NiwQVVRFM3hrdZgcrtsPXuaer753a8BSFvTxlxC1vUmMX86OCYcr2VOg7E/TYdqbYGdaofgLBIVLluUASddCE6Hyn3rRmJQqTJlgFYbyOReGrE1ksi1lEBn0SCWJQFqz/EATIHrf8mtEOTgYWzzgrxbMLHB6UVmY48vbeHEJ6KErXlJTAqUeEqW0CxI1D/LAdviFutG5VyY12KDXuBvTsEOFJW6OijQr7JRwv9iahaDTcBo8KTcDRkU/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuYaBADjU7TbE45jA2CQyRTTIIA82unRozIzIWRnaD8=;
 b=cmlb7tTBE4RzLkmXGCwYTKO3+GBQFiDIKbTGjQ/QGuV3CCb40tqwFXwNrL9bnAfCrDQhzuE+iUUBsthtEWyJccoOhNHOg1befy0pzJCZEyLwKxJLH6Su4R5LynHCsb+xJxf+2eHfwWuMwR/Hw2vMYtQfNzKV1IkIMo2TlpYql1rP5lRGr95gG8ExJC3MNtHbuQMe0Wzidd92ci8JBF3Ti5ZSlJg9ysM/x+Hmi2xH5f/N+l5ljPf/lKRhLWSp99/X8eY7jdV6eB7BPcGHkDNb9NhYIxuzOVyUYsnwjcYvMMKl+WelQ3pediZi96eoO7xByvF302Ab7wxL7LIuSo09CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuYaBADjU7TbE45jA2CQyRTTIIA82unRozIzIWRnaD8=;
 b=Vd68/iKmW3TR9N2wLTl12/JvO6vN0U8E+txTlY1+tO67AfTH5D9qD6Eim62z/bmOG06ydJiPSJm14rrsWStVqrwmBRx+N2NDF0e3ZS95e06mcBGWFK5VbuP+1IPPN1jZ6cuR1O9DDvIvNFagUizaeZLQ173AMk0vRQuArtetRt4=
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com (20.179.35.83) by
 AM0PR08MB4993.eurprd08.prod.outlook.com (10.255.31.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Fri, 18 Oct 2019 14:38:34 +0000
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c]) by AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c%7]) with mapi id 15.20.2347.026; Fri, 18 Oct 2019
 14:38:34 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v8 3/3] docs: qcow2: introduce compression type feature
Thread-Topic: [PATCH v8 3/3] docs: qcow2: introduce compression type feature
Thread-Index: AQHVhZkj46fhSotDHkurLiLfbHI9madgbsUAgAAJdgA=
Date: Fri, 18 Oct 2019 14:38:34 +0000
Message-ID: <1696022a-fafc-64d6-7ad3-5389aee4d7f5@virtuozzo.com>
References: <20191018094758.7124-1-vsementsov@virtuozzo.com>
 <20191018094758.7124-4-vsementsov@virtuozzo.com>
 <29df7fb8-8218-2228-9575-e84e369a7d9a@redhat.com>
In-Reply-To: <29df7fb8-8218-2228-9575-e84e369a7d9a@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR08CA0071.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::42) To AM0PR08MB4435.eurprd08.prod.outlook.com
 (2603:10a6:208:144::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191018173832331
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2483da25-fe7c-490a-ca5d-08d753d8da72
x-ms-traffictypediagnostic: AM0PR08MB4993:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB499365046E873343023F225AC16C0@AM0PR08MB4993.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(39840400004)(376002)(396003)(346002)(189003)(199004)(66446008)(14444005)(71200400001)(66476007)(66946007)(66556008)(64756008)(8676002)(71190400001)(8936002)(26005)(110136005)(81166006)(81156014)(31696002)(86362001)(2616005)(54906003)(5660300002)(25786009)(6436002)(6486002)(2906002)(476003)(6306002)(486006)(478600001)(229853002)(4326008)(53546011)(6246003)(107886003)(186003)(36756003)(386003)(6506007)(446003)(6512007)(11346002)(31686004)(66066001)(2501003)(76176011)(102836004)(14454004)(3846002)(6116002)(256004)(99286004)(7736002)(305945005)(52116002)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4993;
 H:AM0PR08MB4435.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8T01ZS1qq3vgX4SWKhQhcaMUmBhenrj95rDG89YI78+M/S2Pq4FoDjm/kFtlr0BQBngKgwSV0fpmJjnJBgzYBgg8zBjGEU99XBNxJeEj7nFMJusVRFS1cHANrDLuMV7XFn5xmA12bHKKrT9n4dNFDF26Stmg5J38cKA5lZDQ95EIgUNRvInUjhrOl7TdYUnw1o7VE6IwSxJWJW14OrJWNlG2CBB4I4XxtcSLEiHVdq5MKOoMOCt+H64BfuS/WPVq2lOtquJKFFTz/4RlUlvLdAS56u5WWIdecY03QMm5nE5gMaDKC+76O+itceyZTqQ0YD7UN/e1bs2Na6AA4fNd0vwiXKEVH6rNJxghIOKr4sHCu/JFX3IbZI2KYzc+qP92L5pmu40l3Rp4F7pIdCLIFM81N7a8K8IKBfZ4BtELE/NbzD6QWKXXFPICEaflv3ffp7qTE3BsAhSUy6QKeKZ7Fw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <93F58DC989412D4D8DB36B8BAB8F25A3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2483da25-fe7c-490a-ca5d-08d753d8da72
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 14:38:34.0351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RUJfruzvSkIU4IG/HWmDwdOpva+AG1+GtO9cGaDbJqVVi1aQt39kD6rURNIKYATzwTdDvCvD3ZzAj7od1WW/y1ekJIrwv2Et8LqfjV6jSGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4993
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.128
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTguMTAuMjAxOSAxNzowNCwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMTAvMTgvMTkgNDo0NyBB
TSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IFRoZSBwYXRjaCBhZGQg
bmV3IGFkZGl0aW9uYWwgZmllbGQgdG8gcWNvdzIgaGVhZGVyOiBjb21wcmVzc2lvbl90eXBlLA0K
Pj4gd2hpY2ggc3BlY2lmaWVzIGNvbXByZXNzaW9uIHR5cGUuIElmIGZpZWxkIGlzIGFic2VudCBv
ciB6ZXJvLCBkZWZhdWx0DQo+PiBjb21wcmVzc2lvbiB0eXBlIGlzIHNldDogWkxJQiwgd2hpY2gg
Y29ycmVzcG9uZHMgdG8gY3VycmVudCBiZWhhdmlvci4NCj4+DQo+PiBOZXcgY29tcHJlc3Npb24g
dHlwZSAoWlNURCkgaXMgdG8gYmUgYWRkZWQgaW4gZnVydGhlciBjb21taXQuDQo+Pg0KPj4gU3Vn
Z2VzdGVkLWJ5OiBEZW5pcyBQbG90bmlrb3YgPGRwbG90bmlrb3ZAdmlydHVvenpvLmNvbT4NCj4+
IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZA
dmlydHVvenpvLmNvbT4NCj4+IC0tLQ0KPj4gwqAgZG9jcy9pbnRlcm9wL3Fjb3cyLnR4dCB8IDE5
ICsrKysrKysrKysrKysrKysrKy0NCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RvY3MvaW50ZXJvcC9xY293
Mi50eHQgYi9kb2NzL2ludGVyb3AvcWNvdzIudHh0DQo+PiBpbmRleCBiOTcxZTU5YjFhLi40ZWFi
ZDgxMzYzIDEwMDY0NA0KPj4gLS0tIGEvZG9jcy9pbnRlcm9wL3Fjb3cyLnR4dA0KPj4gKysrIGIv
ZG9jcy9pbnRlcm9wL3Fjb3cyLnR4dA0KPj4gQEAgLTEwOSw2ICsxMDksMTIgQEAgbGVhc3QgbmV4
dCBmaXZlIGZpZWxkcywgdXAgdG8gdGhlIEBoZWFkZXJfbGVuZ3RoIGZpZWxkLg0KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIEFuIEV4dGVybmFsIERhdGEgRmlsZSBOYW1lIGhlYWRlciBleHRlbnNpb24gbWF5DQo+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYmUgcHJlc2VudCBpZiB0aGlzIGJpdCBpcyBzZXQuDQo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQml0IDM6wqDCoMKgwqDCoCBDb21wcmVzc2lvbiB0
eXBlIGJpdC7CoCBJZiB0aGlzIGJpdCBpcyBzZXQsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbm9uLWRlZmF1bHQgY29t
cHJlc3Npb24gaXMgdXNlZCBmb3IgY29tcHJlc3NlZA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNsdXN0ZXJzLiBJbiB0
aGlzIGNhc2UsIEBoZWFkZXJfbGVuZ3RoIG11c3QNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBiZSBhdCBsZWFzdCAxMDUg
YW5kIEBjb21wcmVzc2lvbl90eXBlIGZpZWxkDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbXVzdCBiZSBub24temVyby4N
Cj4gDQo+IEkgd2FudCB0byBpbnNpc3Qgb24gOC1ieXRlIGFsaWdubWVudCwgc28gdGhpcyBzaG91
bGQgYmUgYXQgbGVhc3QgMTEyLg0KPiANCj4gQWxzbywgYXMgcG9pbnRlZCBvdXQgaW4gdjcsIHVz
ZSBvZiB0aGUgZGVjb3JhdGlvbiAnQGhlYWRlcl9sZW5ndGgnIGFuZCAnQGNvbXByZXNzaW9uX3R5
cGUnIGlzIG5vdCBjb25zaXN0ZW50IHdpdGggdGhlIHJlc3Qgb2YgdGhlIGRvY3VtZW50LiBEcm9w
IHRoZSBALg0KDQpNaXNzZWQgdGhpcywgc29ycnkoDQoNCj4gDQo+PiArDQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQml0cyAzLTYzOsKgIFJlc2VydmVkIChz
ZXQgdG8gMCkNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIDgwIC3CoCA4NzrCoCBjb21wYXRpYmxl
X2ZlYXR1cmVzDQo+PiBAQCAtMTgzLDcgKzE4OSwxOCBAQCBJdCdzIGFsbG93ZWQgZm9yIHRoZSBo
ZWFkZXIgZW5kIHRvIGN1dCBzb21lIGZpZWxkIGluIHRoZSBtaWRkbGUgKGluIHRoaXMgY2FzZQ0K
Pj4gwqAgdGhlIGZpZWxkIGlzIGNvbnNpZGVyZWQgYXMgYWJzZW50KSwgYnV0IGluIHRoaXMgY2Fz
ZSB0aGUgcGFydCBvZiB0aGUgZmllbGQNCj4+IMKgIHdoaWNoIGlzIGNvdmVyZWQgYnkgQGhlYWRl
cl9sZW5ndGggbXVzdCBiZSB6ZXJvZWQuDQo+PiAtwqDCoMKgwqDCoMKgwqAgPCAuLi4gTm8gYWRk
aXRpb25hbCBmaWVsZHMgaW4gdGhlIGhlYWRlciBjdXJyZW50bHkgLi4uID4NCj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAxMDQ6wqAgY29tcHJlc3Npb25fdHlwZQ0KPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIERlZmluZXMgdGhlIGNvbXByZXNzaW9uIG1l
dGhvZCB1c2VkIGZvciBjb21wcmVzc2VkIGNsdXN0ZXJzLg0KPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIEEgc2luZ2xlIGNvbXByZXNzaW9uIHR5cGUgaXMgYXBwbGll
ZCB0byBhbGwgY29tcHJlc3NlZCBpbWFnZQ0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNsdXN0ZXJzLg0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIElmIGluY29tcGF0aWJsZSBjb21wcmVzc2lvbiB0eXBlIGJpdCBpcyBzZXQ6IHRo
ZSBmaWVsZCBtdXN0DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZXhpc3QgKGkuZS4gQGhlYWRlcl9sZW5ndGggPj0gMTA1KSBhbmQgbXVzdCBiZSBub24temVybyAo
DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgd2hpY2ggbWVhbnMg
bm9uLXpsaWIgY29tcHJlc3Npb24gdHlwZSkNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBJZiBpbmNvbXBhdGlibGUgY29tcHJlc3Npb24gdHlwZSBiaXQgaXMgdW5z
ZXQ6IHRoZSBmaWVsZA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IG1heSBub3QgZXhpc3QgKGlmIEBoZWFkZXJfbGVuZ3RoIDwgMTA1KSBvciBpdCBtdXN0IGJlIHpl
cm8NCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAod2hpY2ggbWVh
bnMgemxpYikuDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQXZh
aWxhYmxlIGNvbXByZXNzaW9uIHR5cGUgdmFsdWVzOg0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMDogemxpYiA8aHR0cHM6Ly93d3cuemxpYi5uZXQv
Pg0KPiANCj4gT25lIGJ5dGUgZm9yIHRoZSBmaWVsZCBpcyBmaW5lLCBidXQgSSdkIHN0aWxsIGV4
cGxpY2l0bHkgZG9jdW1lbnQgNyBieXRlcyBvZiB1bnVzZWQgcGFkZGluZywgc2luY2UgSSB3YW50
IHRvIGluc2lzdCBvbiBhbiA4LWJ5dGUgbXVsdGlwbGUuDQo+IA0KDQpPSw0KDQotLSANCkJlc3Qg
cmVnYXJkcywNClZsYWRpbWlyDQo=

