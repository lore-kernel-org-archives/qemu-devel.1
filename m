Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CB3C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 09:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D24E820840
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 09:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KBJZ2gzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24E820840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxSh9-0004ZM-3o
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 05:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48380)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxSgg-00042T-NK
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 05:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxSgf-00055m-GF
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 05:01:50 -0400
Received: from mail-eopbgr50112.outbound.protection.outlook.com
 ([40.107.5.112]:64067 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxSge-00054n-RB; Tue, 13 Aug 2019 05:01:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hP/3Zgw3QVUAweK9LYFD6B18Orz3YQEukNhXZ5QJ4XQJo2VqHEK+oK2tP18fz7En38W0bcFvaFImEObfcxy2Bx2MSaSQxpU7DOKuem2NvsEGpvBptityTj2fKqYSj73QFQrBJy9tbEwHROLGZZM2yUgwBDYuBWTrfHdB1MwRgKpcsc9hfMIDujq9VJ2jjfIZz0dBm4DfGAmRwDSeArtZdSy59QpbmwVl3oLgcW6kYjLsjoyAmkalVrFLJ28C6OyehvDQCYHU/w/n4sO2fgv4kVXAHKZq0UHHw9rTkXOdVUASBRgWzn6xvZumkHo+AWmiPTiR2kx1jsbsrxWbEET0Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uArevspH9H4OYyDY1XZWzUaLal87hQUQZUvbc5h7zvM=;
 b=G0X1suQLiRCnXFarSHdTWKayuV6EXkV0QnlZZ77c17o4AYHL3un2iFY13t1a2r4RdGsSL3Vt/U02/l1oSvwOeFEIqpoTkQFv93u17QowgaDg39NuF/OEEKfKAT1xPaQshalUm8+eKX06ohDTxo0Sv3Oik2pDGIwf6WDvYsxIaYqYJeKGVlSCEnPeg//2vmoDAOPoqaMAe3TFKndPI7lUTiFj2oQ8L8W5ueLo6i5yf+bmtnL4dICMoTeYjKENLjahqZhZi+S4V+NkIU3Jsk6FnXMladaxF7Glyv2QOeNyxvkoTNBSpeq2XDMKzTXexZM3M1mdJ78ZWn96dN3bmi0R4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uArevspH9H4OYyDY1XZWzUaLal87hQUQZUvbc5h7zvM=;
 b=KBJZ2gztjhT5kFEByRawnh+t7Xr6HXc0TS7DWV+A5DdbJ0s2Mp65lEw1d8cdqu3guXlOkX6oxAZ4WF7EF7gSagjv0wApM4tzA3Rhse11COvqeawp75GsjdHdyqR890AxmSKvDZOWrmTwBlCPhNZHp2SPbH6IyU+rF05V3bJr0vI=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5339.eurprd08.prod.outlook.com (52.133.240.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Tue, 13 Aug 2019 09:01:46 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 09:01:46 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH 0/2] deal with BDRV_BLOCK_RAW
Thread-Index: AQHVUTlscGMEUismPEagfLbq4nW+tab36tGAgAABHQCAANb8gIAABheA
Date: Tue, 13 Aug 2019 09:01:46 +0000
Message-ID: <15cf7372-826a-0684-d6ad-90deea36959e@virtuozzo.com>
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <35b23140-25d5-627e-7a86-4b50fbc5be52@redhat.com>
 <e53a0399-f051-52bd-49e8-4ac4dbf2596f@redhat.com>
 <3d5fcc5b-cdb0-f028-1ea2-af85850db20e@virtuozzo.com>
In-Reply-To: <3d5fcc5b-cdb0-f028-1ea2-af85850db20e@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR08CA0063.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::34) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190813120143672
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9b69542-be67-4ac3-7f91-08d71fccde73
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5339; 
x-ms-traffictypediagnostic: DB8PR08MB5339:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB53392F2457704B15664D584CC1D20@DB8PR08MB5339.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(136003)(396003)(366004)(39850400004)(199004)(189003)(52314003)(53754006)(110136005)(6246003)(6486002)(2616005)(446003)(81156014)(81166006)(478600001)(4326008)(11346002)(229853002)(8676002)(2501003)(966005)(66066001)(66446008)(316002)(14454004)(2906002)(54906003)(8936002)(486006)(6436002)(31686004)(64756008)(107886003)(5660300002)(66476007)(66946007)(66556008)(476003)(3846002)(6306002)(31696002)(386003)(52116002)(6116002)(6506007)(6512007)(36756003)(102836004)(53546011)(86362001)(186003)(99286004)(53936002)(25786009)(14444005)(305945005)(71190400001)(71200400001)(256004)(7736002)(26005)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5339;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ennbFLW/awZsR8DM5gELMie6eoQh7atALa5XGCCxYEIzHPg1VwmcKxdQGmNdAyS1OrcWYI3gBvpar2hn3uDxmbioxELWeXXxkDMFZVXLWz5SnjtWTr/+yqFX0Fqqw5ZCagm7w9nqs20Gn7KGtrMnPE7uFXnxxX2lAUbvAkvaMjBXcBJGnZ6qY+32MlhNd1ZEQVZ28MI3s7s2w1NbSJe6PdlZEInY11mVH8cWZ+qmHYDVfT7op7bfSbfp0Fs8rA/CoPjrzD5WNN0xSI0Xn201KIh7ZMHxIGDe+SkQbhKXgi5ExqA9cftOR1+FN5YuGvECJE9FCSHrVIaI8BBN8Qc9Mxh4FGNuDM3xcWkatBW/TLdAVTtJd7aW7dcH6/Pu0CYHmWtGUvyOJLhwFCh23WNAlAVUEGA+GxWoj+LNq7Cm+Us=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74CC5EA2CC50E5439980B0B355EB03D0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b69542-be67-4ac3-7f91-08d71fccde73
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 09:01:46.3786 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lw9U0OTK5t98XW0oL/ad7tgeJOIfYE66oEaHK5dqQ4DoeZ9x3fy4g2tIdkqTVf1z+RshRrD9jHe7wMbGCFuwF/vs+ySnV+Wl7VEinVpnqvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5339
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.112
Subject: Re: [Qemu-devel] [PATCH 0/2] deal with BDRV_BLOCK_RAW
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTMuMDguMjAxOSAxMTozOSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MTIuMDguMjAxOSAyMjo1MCwgTWF4IFJlaXR6IHdyb3RlOg0KPj4gT24gMTIuMDguMTkgMjE6NDYs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAxMi4wOC4xOSAyMDoxMSwgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gSGkgYWxsIQ0KPj4+Pg0KPj4+PiBJJ20gbm90IHN1
cmUsIGlzIGl0IGEgYnVnIG9yIGEgZmVhdHVyZSwgYnV0IHVzaW5nIHFjb3cyIHVuZGVyIHJhdyBp
cw0KPj4+PiBicm9rZW4uIEl0IHNob3VsZCBiZSBlaXRoZXIgZml4ZWQgbGlrZSBJIHByb3Bvc2Ug
KGJ5IE1heCdzIHN1Z2dlc3Rpb24pDQo+Pj4+IG9yIHNvbWVob3cgZm9yYmlkZGVuIChqdXN0IGZv
cmJpZCBiYWNraW5nLWZpbGUgc3VwcG9ydGluZyBub2RlIHRvIGJlDQo+Pj4+IGZpbGUgY2hpbGQg
b2YgcmF3LWZvcm1hdCBub2RlKS4NCj4+Pg0KPj4+IEkgYWdyZWUsIEkgdGhpbmsgb25seSBmaWx0
ZXJzIHNob3VsZCByZXR1cm4gQkRSVl9CTE9DS19SQVcuDQo+Pj4NCj4+PiAoQW5kIG5vdCBldmVu
IHRoZW0sIHRoZXkgc2hvdWxkIGp1c3QgYmUgaGFuZGxlZCB0cmFuc3BhcmVudGx5IGJ5DQo+Pj4g
YmRydl9jb19ibG9ja19zdGF0dXMoKS7CoCBCdXQgdGhhdOKAmXMgc29tZXRoaW5nIGZvciBsYXRl
ci4pDQo+Pj4NCj4+Pj4gVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSAoMik6DQo+Pj4+IMKg
wqAgYmxvY2svcmF3LWZvcm1hdDogc3dpdGNoIHRvIEJEUlZfQkxPQ0tfREFUQSB3aXRoIEJEUlZf
QkxPQ0tfUkVDVVJTRQ0KPj4+PiDCoMKgIGlvdGVzdHM6IHRlc3QgbWlycm9yaW5nIHFjb3cyIHVu
ZGVyIHJhdyBmb3JtYXQNCj4+Pj4NCj4+Pj4gwqAgYmxvY2svcmF3LWZvcm1hdC5jwqDCoMKgwqDC
oMKgwqDCoCB8wqAgMiArLQ0KPj4+PiDCoCB0ZXN0cy9xZW11LWlvdGVzdHMvMjYzwqDCoMKgwqAg
fCA0NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+PiDCoCB0ZXN0
cy9xZW11LWlvdGVzdHMvMjYzLm91dCB8IDEyICsrKysrKysrKysNCj4+Pj4gwqAgdGVzdHMvcWVt
dS1pb3Rlc3RzL2dyb3VwwqDCoCB8wqAgMSArDQo+Pj4+IMKgIDQgZmlsZXMgY2hhbmdlZCwgNjAg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4+PiDCoCBjcmVhdGUgbW9kZSAxMDA3NTUg
dGVzdHMvcWVtdS1pb3Rlc3RzLzI2Mw0KPj4+PiDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMv
cWVtdS1pb3Rlc3RzLzI2My5vdXQNCj4+Pg0KPj4+IFRoYW5rcywgYXBwbGllZCB0byBteSBibG9j
ay1uZXh0IGJyYW5jaDoNCj4+Pg0KPj4+IGh0dHBzOi8vZ2l0LnhhbmNsaWMubW9lL1hhbkNsaWMv
cWVtdS9jb21taXRzL2JyYW5jaC9ibG9jay1uZXh0DQo+Pg0KPj4gT29wcywgbWF5YmUgbm90LsKg
IDIyMSBuZWVkcyB0byBiZSBhZGp1c3RlZC4NCj4+DQo+IA0KPiANCj4gSG1tIHllcywgSSBmb3Jn
ZXQgdG8gcnVuIHRlc3RzLi4gQXJlYXMgd2hpY2ggd2VyZSB6ZXJvIGJlY29tZXMgZGF0YXx6ZXJv
LCBpdA0KPiBkb24ndCBsb29rIGdvb2QuDQo+IA0KPiBTbywgaXQncyBub3QgcXVpdGUgcmlnaHQg
dG8gcmVwb3J0IERBVEEgfCBSRUNVUlNFLCB3ZSBhY3R1YWxseSBzaG91bGQgcmVwb3J0DQo+IERB
VEFfT1JfWkVSTyB8IFJFQ1VSU0UsIHdoaWNoIGlzIGFjdHVhbGx5IEFMTE9DQVRFRCB8IFJFQ1VS
U0UsIGFzIG90aGVyd2lzZQ0KPiBEQVRBIHdpbGwgYmUgc2V0IGluIGZpbmFsIHJlc3VsdCAoZ2Vu
ZXJpYyBsYXllciBtdXN0IG5vdCBkcm9wIGl0LCBvYnZpb3VzbHkpLg0KPiANCj4gQUxMT0NBVEVE
IG5ldmVyIHJldHVybmVkIGJ5IGRyaXZlcnMgYnV0IHNlZW1zIGl0IHNob3VsZCBiZS4gSSdsbCB0
aGluayBhIGJpdCBhbmQNCj4gcmVzZW5kIHNvbWV0aGluZyBuZXcuDQo+IA0KPiANCg0KDQpIbW1t
Li4gU28sIHdlIGhhdmUgcmF3IG5vZGUsIGFuZCBhc3N1bWUgYmFja2luZyBjaGFpbiB1bmRlciBp
dC4gd2hvIHNob3VsZCBsb29wIHRocm91Z2ggaXQsDQpnZW5lcmljIGNvZGUgb3IgcmF3IGRyaXZl
cj8NCg0KTm93IGl0IGFsbCBsb29rcyBsaWtlIGdlbmVyaWMgY29kZSBpcyByZXNwb25zaWJsZSBm
b3IgbG9vcGluZyB0aHJvdWdoIGZpbHRlcmVkIGNoYWluIChiYWNraW5nIGZpbGVzDQphbmQgZmls
dGVycykgYW5kIGRyaXZlciBpcyByZXNwb25zaWJsZSBmb3IgYWxsIGl0J3MgY2hpbGRyZW4gZXhj
ZXB0IGZvciBmaWx0ZXJlZCBjaGlsZC4NCg0KT3IsIGRyaXZlciBtYXkgcmV0dXJuIHNvbWV0aGlu
ZyB0aGF0IHNheXMgdG8gZ2VuZXJpYyBjaGlsZCB0byBoYW5kbGUgdGhlIHdob2xlIGJhY2tpbmcg
Y2hhaW4gb2YgcmV0dXJuZWQNCmZpbGUgYXQgb25jZSwgYXMgaXQncyBhbm90aGVyIGJhY2tpbmcg
Y2hhaW4uIEFuZCBzZWVtcyBldmVuIFJFQ1VSU0UgZG9uJ3Qgd29yayBjb3JyZWN0bHkgYXMgaXQg
ZG9lc24ndCBoYW5kbGUNCnRoZSBiYWNraW5nIGNoYWluIGluIHRoaXMgcmVjdXJzaW9uLiBXaHkg
aXQgd29ya3MgYmV0dGVyIHRoYW4gUkFXIC0ganVzdCBiZWNhdXNlIHdlIHJldHVybiBpdCB0b2dl
dGhlcg0Kd2l0aCBEQVRBIGZsYWdzIGFuZCB0aGlzIERBVEEgZmxhZyBpcyBrZXB0IGFueXdheSwg
aW5kZXBlbmRlbnRseSBvZiBmaW5kaW5nIHplcm9zIG9yIG5vdC4NCg0KDQotLSANCkJlc3QgcmVn
YXJkcywNClZsYWRpbWlyDQo=

