Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445A0C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF492080C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZfkPv+w6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF492080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqafM-00027m-Du
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 06:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49874)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hqafB-0001gm-DC
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:07:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hqafA-00079o-Cv
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:07:53 -0400
Received: from mail-eopbgr00104.outbound.protection.outlook.com
 ([40.107.0.104]:8545 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hqaf7-00078y-PI; Thu, 25 Jul 2019 06:07:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJWz+lMwOV7QGeDNIV7t9PA218LXVM1+kAB4q5eBM5i5kkh2Mk72ZlNwc+WiuEGzuL6ZV0XQtuBSIekeBiDpNFoSKGZcKsz0PTtDha/azHJheB33G4iAbYJ680m7B62SMVJwaObtOisjRActaROQp+AFv8tEr7GWTM5DuzBe9D5KY0RrUIIJ7guIncqsetX2QSygSBdAxCaAkTz990nRkoMLSNiTlDbjn3U8uL9Vwuggh6Hw2cgczFAl3ywQTc7SeBQF9tvMFNeZQFd57UxOWquaQQp+nSUqOsVoSYCGfRn7+DJDhAeLTR5LOQ80kXIiRHpVQLawwqk7XyUx8IJ1cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34Zco+i0Y3yYPNMXdvjXFKEoWWm5lXmIBncztaw3a1c=;
 b=dnC53gnnTd22MqU72X/3Pz0u+mQu5H1s+FgbLj1zUxntiRLcRgkYTOaEddKgooKj9ahGgfyCnwM+8dibc+JKX02niNeXXb6FUvSNOfVxSwNlnGTov2awiqRsQ6MuNHasRSj05Nxe2JU4JEcpUJ2cHtnmNLGLOUanBxAhFPidg4c2jaMcQm0o4xUomVv/vwMP6o0MAl8yZxYnv1XGMwHRWQr9GDHOy1vOP7tBEz6dHwL6CqeOsG+k7ed9TMoFdjxm1oibyW9oGrAY8cRZ7Y/ZCVgBqMPzCKQrgPbv9CEPsJjIpu+KsSFsTiupf3s+/OKMjDkBGkRpYILLgkZKpDIIZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34Zco+i0Y3yYPNMXdvjXFKEoWWm5lXmIBncztaw3a1c=;
 b=ZfkPv+w6pV0+rLYuyaYOhCzBJeNgsC5hvOiLYCFezfriXddrrhGQ78e8w9fUD7K3WRcWW+xDxOVR1TPBODXHVnjDCj/o5ZOPDL22ZuzAQ85AlAJ7BozD7MGH4gE9y5ALhwqO+I7ILUJ13A+VT6e/XH62V2upqaA7LBVnzCjwOms=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5371.eurprd08.prod.outlook.com (52.133.240.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.13; Thu, 25 Jul 2019 10:07:38 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2115.005; Thu, 25 Jul 2019
 10:07:38 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v7 0/9] NBD reconnect
Thread-Index: AQHVJcsR0Ob9vQwVFUSX/gqgFfzT4KbbVfgA
Date: Thu, 25 Jul 2019 10:07:38 +0000
Message-ID: <e66505eb-78e1-612d-6742-4774c3167412@virtuozzo.com>
References: <20190618114328.55249-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190618114328.55249-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR06CA0131.eurprd06.prod.outlook.com
 (2603:10a6:7:16::18) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190725130734741
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0269021-5b2c-4197-8ad6-08d710e7ec2a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5371; 
x-ms-traffictypediagnostic: DB8PR08MB5371:
x-microsoft-antispam-prvs: <DB8PR08MB537195F48FAA70C9DD36C03BC1C10@DB8PR08MB5371.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(366004)(39850400004)(376002)(346002)(189003)(199004)(53754006)(6246003)(66946007)(66476007)(66556008)(64756008)(86362001)(316002)(53936002)(2906002)(31696002)(66446008)(71190400001)(71200400001)(31686004)(25786009)(4326008)(52116002)(81156014)(81166006)(8676002)(6506007)(386003)(6436002)(76176011)(68736007)(99286004)(2501003)(54906003)(8936002)(110136005)(3846002)(107886003)(6116002)(229853002)(6486002)(102836004)(256004)(5024004)(305945005)(66066001)(478600001)(5660300002)(36756003)(26005)(2616005)(186003)(446003)(7736002)(486006)(476003)(11346002)(14454004)(6512007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5371;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DwISXu9Ec5FfzzBOPFS2vUnzEOI+7zKge48cVflaeSPLGaoRyeq1Y0+1AVNJxha70vZQXZ/w3qtldFGmPqniArdk8cPymshgEP2eWT0atGZE9kH4ghu6tWJP1PRRAZEVl8ZhI6jL1OEfNRtoJpn1++/6AIdRS8hBLoIHWcecDh6BzfJtzhmgnWTyfKsveERwjwtvTsgA3w5VA6fOf+9u4PK8rywBeU+rCk6wURX/kULVvhKO2X7OyPz0y7GZoWN53+9b8JVK9L3t5wXY2J1AyKPAEuhQSxivxN6x117cpCD6OPVbBiE4M8JoqYFfSXi3361WR0F5EvvYLp0bMSc5VhCnuCaM2KqXRujxtmu52U5yMuXHTFu7zaj0cbIuRh4vQGvyAsVPa6B1nm8IjH89An+ohnYZxeILQ253jtRqDnQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BC7D3B168CEA7468BE6DF9DE06BC730@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0269021-5b2c-4197-8ad6-08d710e7ec2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 10:07:38.4317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5371
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.104
Subject: Re: [Qemu-devel] [PATCH v7 0/9] NBD reconnect
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
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cGluZw0KDQoxOC4wNi4yMDE5IDE0OjQzLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdy
b3RlOg0KPiBIaSBhbGwhDQo+IEhlcmUgaXMgTkJEIHJlY29ubmVjdC4gUHJldmlvdXNseSwgaWYg
Y29ubmVjdGlvbiBmYWlsZWQgYWxsIGN1cnJlbnQNCj4gYW5kIGZ1dHVyZSByZXF1ZXN0cyB3aWxs
IGZhaWwuIEFmdGVyIHRoZSBzZXJpZXMsIG5iZC1jbGllbnQgZHJpdmVyDQo+IHdpbGwgdHJ5IHRv
IHJlY29ubmVjdCB1bmxpbWl0ZWQgdGltZXMuIER1cmluZyBmaXJzdCBAcmVjb25uZWN0LWRlbGF5
DQo+IHNlY29uZHMgb2YgcmVjb25uZWN0aW5nIGFsbCByZXF1ZXN0cyB3aWxsIHdhaXQgZm9yIHRo
ZSBjb25uZWN0aW9uLA0KPiBhbmQgaWYgaXQgaXMgZXN0YWJsaXNoZWQgcmVxdWVzdHMgd2lsbCBi
ZSByZXNlbnQuIEFmdGVyDQo+IEByZWNvbm5lY3QtZGVsYXkgcGVyaW9kIGFsbCByZXF1ZXN0cyB3
aWxsIGJlIGZhaWxlZCAodW50aWwgc3VjY2Vzc2Z1bA0KPiByZWNvbm5lY3QpLg0KPiANCj4gdjc6
DQo+IGFsbW9zdCBhbGw6IHJlYmFzZWQgb24gbWVyZ2VkIG5iZC5jIGFuZCBuYmQtY2xpZW50LmMg
KGluY2x1ZGluZyBwYXRjaCBzdWJqZWN0KQ0KPiAwMS0wNDogYWRkIEVyaWMncyByLWINCj4gMDQ6
IHdvcmRpbmcNCj4gMDU6IG5ldw0KPiAwNjogcmV3cml0ZSB0byByZW1vdmUgdGltZXIgZWFybGll
cg0KPiAwNzogbmV3DQo+IDA4Og0KPiAgIC0gcmViYXNlIG9uIDA1IGFuZCAwNw0KPiAgIC0gZHJv
cCAiQWxsIHJpZ2h0cyByZXNlcnZlZCINCj4gICAtIGhhbmRsZSBkcmFpbg0KPiAgIC0gaW1wcm92
ZSBoYW5kbGluZyBhaW8gY29udGV4dCBhdHRhY2gNCj4gMDk6IG1vdmUgMjQ5IC0+IDI1Nw0KPiAN
Cj4gVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSAoOSk6DQo+ICAgIGJsb2NrL25iZDogc3Bs
aXQgY29ubmVjdGlvbl9jbyBzdGFydCBvdXQgb2YgbmJkX2NsaWVudF9jb25uZWN0DQo+ICAgIGJs
b2NrL25iZDogdXNlIG5vbi1ibG9ja2luZyBpbyBjaGFubmVsIGZvciBuYmQgbmVnb3RpYXRpb24N
Cj4gICAgYmxvY2svbmJkOiBtb3ZlIGZyb20gcXVpdCB0byBzdGF0ZQ0KPiAgICBibG9jay9uYmQ6
IGFkZCBjbWRsaW5lIGFuZCBxYXBpIHBhcmFtZXRlciByZWNvbm5lY3QtZGVsYXkNCj4gICAgYmxv
Y2svbmJkOiByZWZhY3RvciBuYmQgY29ubmVjdGlvbiBwYXJhbWV0ZXJzDQo+ICAgIHFlbXUtY29y
b3V0aW5lLXNsZWVwOiBpbnRyb2R1Y2UgcWVtdV9jb19zbGVlcF93YWtlDQo+ICAgIHFlbXUvdW5p
dHM6IGFkZCBTSSBkZWNpbWFsIHVuaXRzDQo+ICAgIGJsb2NrL25iZDogbmJkIHJlY29ubmVjdA0K
PiAgICBpb3Rlc3RzOiB0ZXN0IG5iZCByZWNvbm5lY3QNCj4gDQo+ICAgcWFwaS9ibG9jay1jb3Jl
Lmpzb24gICAgICAgICAgfCAgMTEgKy0NCj4gICBpbmNsdWRlL2Jsb2NrL25iZC5oICAgICAgICAg
ICB8ICAgMyArLQ0KPiAgIGluY2x1ZGUvcWVtdS9jb3JvdXRpbmUuaCAgICAgIHwgIDE3ICstDQo+
ICAgaW5jbHVkZS9xZW11L3VuaXRzLmggICAgICAgICAgfCAgIDcgKw0KPiAgIGJsb2NrL25iZC5j
ICAgICAgICAgICAgICAgICAgIHwgNTMxICsrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0NCj4gICBibG9jay9udWxsLmMgICAgICAgICAgICAgICAgICB8ICAgMiArLQ0KPiAgIGJsb2Nr
L3NoZWVwZG9nLmMgICAgICAgICAgICAgIHwgICAyICstDQo+ICAgbmJkL2NsaWVudC5jICAgICAg
ICAgICAgICAgICAgfCAgMTYgKy0NCj4gICBxZW11LW5iZC5jICAgICAgICAgICAgICAgICAgICB8
ICAgMiArLQ0KPiAgIHRlc3RzL3Rlc3QtYmRydi1kcmFpbi5jICAgICAgIHwgICA2ICstDQo+ICAg
dGVzdHMvdGVzdC1ibG9jay1pb3RocmVhZC5jICAgfCAgIDIgKy0NCj4gICB1dGlsL3FlbXUtY29y
b3V0aW5lLXNsZWVwLmMgICB8ICA0NyArKy0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMjU3ICAg
ICAgICB8ICA2MyArKysrDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzI1Ny5vdXQgICAgfCAgMTAg
Kw0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy9ncm91cCAgICAgIHwgICAxICsNCj4gICB0ZXN0cy9x
ZW11LWlvdGVzdHMvaW90ZXN0cy5weSB8ICAgNCArDQo+ICAgMTYgZmlsZXMgY2hhbmdlZCwgNTUx
IGluc2VydGlvbnMoKyksIDE3MyBkZWxldGlvbnMoLSkNCj4gICBjcmVhdGUgbW9kZSAxMDA3NTUg
dGVzdHMvcWVtdS1pb3Rlc3RzLzI1Nw0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xZW11
LWlvdGVzdHMvMjU3Lm91dA0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

