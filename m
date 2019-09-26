Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE54C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 12:44:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 682CB21655
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 12:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ye+rFnTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682CB21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDT8K-00069V-JO
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 08:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDT7B-0005MU-5z
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDT79-0000An-Vr
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:43:20 -0400
Received: from mail-eopbgr70093.outbound.protection.outlook.com
 ([40.107.7.93]:2821 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDT76-0008Ot-JE; Thu, 26 Sep 2019 08:43:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGIYio7Rw6lY9GymGD4+rSLfdWsGjCh5V/1jwUfrMlb7B0amk5VR8ST7660KRnZlIparURpUrZNMLtk9RKu39csXE2yjgfUWjhl3pKF/mDtfbI55DpVGOtAW65cl1ytPeZHAplj55fNO5KnEg9GjjmY06NLP8mL+2hww2XmH+ge2kQAkn4wzhoQWPwC/Mhr5LQgSGD0z2iIgDJ8nO7Rck6YPDTPew5Dx16iAWkRH0D2vLLS4XKio2QPEgwExVZvyUqZl664eJbniGqoF+Iro6RERrra5eZgZQagQVzLgneEnESPTpXuQjC4N37wjdOuWqxrF6LZVbd75rYy/CDZfaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/Qf2K1NgPeWb53zKs3m6vG/fjueFgALqkn0hoURYEs=;
 b=QFhCKMJuGV+4QVOuZE54Xejf4M4NAjzhucOF2MBLaNc3wdiHuZVt6NJylxNnEYaS0cLBRgpVOKZq3LH5MSHARrcJQqVEp+cuujL9irAWhNDhDJkLTafWn0AaSo/Lth6S1KNTIO7fnpZz+3/mK3b5fPT2+5AZgNZC3ybs5GcUP6CHMKPNLYLCIw34D6hIv1FjzUa1qORHIU/7Ks28LRKqjS57y+uwgGgJmWr6EedlYcDsN36Lj2KRK4Vd2KbVBXt9Ab1X21MxnlXpRujBaONSHRSC+SRQaYkUyNSAG2dU0/kRj6sLIBLzCjTGJpWuRnkFV3WgVzuffLMjnbGroWNklg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/Qf2K1NgPeWb53zKs3m6vG/fjueFgALqkn0hoURYEs=;
 b=Ye+rFnTkOz59QPca5BWIvxI88mDIcW3R10XCf42NTg3xKeHPyVKHu9p1leZfvoVTbY0wfmUn7jyW0OJvdvB0dak6hLY+adyL3EHm3MxadBRcQPMZu9RxhiLt6qlmYFnwWOEMzXvMamgbxyE2Hucpfi+apmHQxb+MYaN/eUh7s9E=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3977.eurprd08.prod.outlook.com (20.179.11.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Thu, 26 Sep 2019 12:43:11 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Thu, 26 Sep 2019
 12:43:11 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 14/22] quorum: Stop marking it as a filter
Thread-Topic: [PATCH 14/22] quorum: Stop marking it as a filter
Thread-Index: AQHVb8nuIJ44EHFngU+JK6OXUoC7IKc98FKA
Date: Thu, 26 Sep 2019 12:43:11 +0000
Message-ID: <e5c4d8ed-7196-ec0d-92d7-6766610b6b80@virtuozzo.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-15-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-15-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P195CA0018.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::28)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190926154309015
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac455345-1122-4d20-1192-08d7427f172c
x-ms-traffictypediagnostic: DB8PR08MB3977:
x-microsoft-antispam-prvs: <DB8PR08MB3977B80FB5DFBC7932847EC5C1860@DB8PR08MB3977.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(396003)(39850400004)(376002)(136003)(189003)(199004)(229853002)(6436002)(66476007)(66556008)(64756008)(66946007)(66446008)(31696002)(7736002)(6486002)(110136005)(4326008)(316002)(66066001)(14454004)(305945005)(86362001)(54906003)(478600001)(2906002)(6512007)(31686004)(476003)(52116002)(99286004)(76176011)(11346002)(3846002)(446003)(36756003)(6116002)(25786009)(81156014)(26005)(8676002)(81166006)(186003)(102836004)(256004)(6246003)(14444005)(2616005)(386003)(6506007)(8936002)(2501003)(486006)(71200400001)(71190400001)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3977;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C6ihwYTbc+/Ak/qRvKkHesucCYJpFfPcb74/jnycYa4bGO+onZsBJz7piD/JvWi0Kj58ooN4Qb0Qg3+od087PIPIeKZB6I31OkXoljnl7tKukxUokveEG0Pfohy3ncz2py+nvgdZb5BJj/Z9mah2dBBcz61KCjC14qiMdJQCS+ave9Jz+q86udS/j8V7mxfMgu3Asjm+DVOEl37B9QsEUtCcwPKwDtUcZ7BwFj7IAGHNQPoMgttmB3TFEYUI2AGpg++4Rtw6sqZSqVHjl3iv5s7sdEuvv5aqeqCv6fZvXC8Z7lvBJEp3vm4wsBFVE++hMZv7sR3KEu/zKTYkn8xVNT9qP+7qDe5EJEjuqo+tcZQ9fBirm6o1O1/nfl0/Syin7V3rREOQDDuvnhjsn0NhBILqz0m6gsVQSG/puFkDEDw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <135676622821104FA19727142D6372D4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac455345-1122-4d20-1192-08d7427f172c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 12:43:11.4429 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i9TaCOEjl6KHwcQDRoMSzywaPNUg3Ugcw64W90S6BujViI7lHD3XJe+4WSkWuLCyiYjdLc0gfuK16tWvQrLx9a+RaL1psc+IkRnkbzWvZSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3977
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.93
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDkuMjAxOSAxODoyNywgTWF4IFJlaXR6IHdyb3RlOg0KPiBRdW9ydW0gaXMgbm90IGEgZmls
dGVyLCBmb3IgZXhhbXBsZSBiZWNhdXNlIGl0IGNhbm5vdCBndWFyYW50ZWUgd2hpY2ggb2YNCj4g
aXRzIGNoaWxkcmVuIHdpbGwgc2VydmUgdGhlIG5leHQgcmVxdWVzdC4gIFRodXMsIGFueSBvZiBp
dHMgY2hpbGRyZW4gbWF5DQo+IGRpZmZlciBmcm9tIHRoZSBkYXRhIHZpc2libGUgdG8gcXVvcnVt
J3MgcGFyZW50cy4NCj4gDQo+IFdlIGhhdmUgb3RoZXIgZmlsdGVycyB3aXRoIG11bHRpcGxlIGNo
aWxkcmVuLCBidXQgdGhleSBkaWZmZXIgaW4gdGhpcw0KPiBhc3BlY3Q6DQo+IA0KPiAtIGJsa3Zl
cmlmeSBxdWl0cyB0aGUgd2hvbGUgcWVtdSBwcm9jZXNzIGlmIGl0cyBjaGlsZHJlbiBkaWZmZXIu
ICBBcw0KPiAgICBzdWNoLCB3ZSBjYW4gYWx3YXlzIHNraXAgaXQgd2hlbiB3ZSB3YW50IHRvIHNr
aXAgaXQgKGFzIGEgZmlsdGVyIG5vZGUpDQo+ICAgIGJ5IGdvaW5nIHRvIGFueSBvZiBpdHMgY2hp
bGRyZW4uICBCb3RoIGhhdmUgdGhlIHNhbWUgZGF0YS4NCj4gDQo+IC0gcmVwbGljYXRpb24gZ2Vu
ZXJhbGx5IHNlcnZlcyByZXF1ZXN0cyBmcm9tIGJzLT5maWxlLCBzbyB0aGlzIGlzIGl0cw0KPiAg
ICBvbmx5IGFjdHVhbGx5IGZpbHRlcmVkIGNoaWxkLg0KPiANCj4gLSBCbG9jayBqb2IgZmlsdGVy
cyBjdXJyZW50bHkgb25seSBoYXZlIG9uZSBjaGlsZCwgYnV0IHRoZXkgd2lsbA0KPiAgICBwcm9i
YWJseSBnZXQgbW9yZSBjaGlsZHJlbiBpbiB0aGUgZnV0dXJlLiAgU3RpbGwsIHRoZXkgd2lsbCBh
bHdheXMNCj4gICAgaGF2ZSBvbmx5IG9uZSBhY3R1YWxseSBmaWx0ZXJlZCBjaGlsZC4NCj4gDQo+
IEhhdmluZyAiZmlsdGVycyIgYXMgYSBkZWRpY2F0ZWQgbm9kZSBjYXRlZ29yeSBvbmx5IG1ha2Vz
IHNlbnNlIGlmIHlvdQ0KPiBjYW4gc2tpcCB0aGVtIGJ5IGdvaW5nIHRvIGEgb25lIGZpeGVkIGNo
aWxkIHRoYXQgYWx3YXlzIHNob3dzIHRoZSBzYW1lDQo+IGRhdGEgYXMgdGhlIGZpbHRlciBub2Rl
LiAgUXVvcnVtIGNhbm5vdCBmdWxmaWxsIHRoaXMsIHNvIGl0IGlzIG5vdCBhDQo+IGZpbHRlci4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQoNClJl
dmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1
b3p6by5jb20+DQoNCj4gLS0tDQo+ICAgYmxvY2svcXVvcnVtLmMgfCAxIC0NCj4gICAxIGZpbGUg
Y2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL3F1b3J1bS5j
IGIvYmxvY2svcXVvcnVtLmMNCj4gaW5kZXggN2E4ZjhiNTQ3NS4uN2Y1NmI0ZGY3YyAxMDA2NDQN
Cj4gLS0tIGEvYmxvY2svcXVvcnVtLmMNCj4gKysrIGIvYmxvY2svcXVvcnVtLmMNCj4gQEAgLTEy
MzcsNyArMTIzNyw2IEBAIHN0YXRpYyBCbG9ja0RyaXZlciBiZHJ2X3F1b3J1bSA9IHsNCj4gICAN
Cj4gICAgICAgLmJkcnZfY2hpbGRfcGVybSAgICAgICAgICAgICAgICAgICAgPSBxdW9ydW1fY2hp
bGRfcGVybSwNCj4gICANCj4gLSAgICAuaXNfZmlsdGVyICAgICAgICAgICAgICAgICAgICAgICAg
ICA9IHRydWUsDQo+ICAgICAgIC5iZHJ2X3JlY3Vyc2VfY2FuX3JlcGxhY2UgICAgICAgICAgID0g
cXVvcnVtX3JlY3Vyc2VfY2FuX3JlcGxhY2UsDQo+ICAgDQo+ICAgICAgIC5zdHJvbmdfcnVudGlt
ZV9vcHRzICAgICAgICAgICAgICAgID0gcXVvcnVtX3N0cm9uZ19ydW50aW1lX29wdHMsDQo+IA0K
DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

