Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9665AC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 07:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5402A24D3D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 07:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OaDxpI5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5402A24D3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47980 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY4Ke-00049v-Kc
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 03:58:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hY4JW-0003ST-Rt
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:56:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hY4JV-0000IF-Ot
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:56:58 -0400
Received: from mail-eopbgr60102.outbound.protection.outlook.com
	([40.107.6.102]:59585
	helo=EUR04-DB3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1hY4JV-0008UI-6h; Tue, 04 Jun 2019 03:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=m+6u+lMjAFAItZCz4qylU3HjU6rEeSeRFQAMHqUYfuI=;
	b=OaDxpI5uJXxiCITscPjIpLAzNAEWJ8GGGXinIcjOqzOGd18yrXlx5A2d0ZdwfEJG5TSzJXUWRSUQMtdosPTYUAU26s7wPwBNv2rkOxoVnNn9AWxUzv1kEv8Ded33rHuUF5dQaA0v+JNzAj2l39OZc0ZM5w7Ayw8PopCODMXiPB0=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
	AM0PR08MB4116.eurprd08.prod.outlook.com (20.178.202.160) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1943.22; Tue, 4 Jun 2019 07:56:49 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
	([fe80::d5c1:9518:28cb:4489]) by
	AM0PR08MB3745.eurprd08.prod.outlook.com
	([fe80::d5c1:9518:28cb:4489%6]) with mapi id 15.20.1943.018;
	Tue, 4 Jun 2019 07:56:49 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com"
	<mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>,
	"armbru@redhat.com" <armbru@redhat.com>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [PING] [Qemu-devel] [PATCH v0 0/3] add zstd cluster compression
Thread-Index: AQHVFWOWtI+0pq+SI0+CF3K1/WENUaaLK1aA
Date: Tue, 4 Jun 2019 07:56:49 +0000
Message-ID: <8d74b270-b70e-4779-e10e-72b11387aefc@virtuozzo.com>
References: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
In-Reply-To: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0009.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::19)
	To AM0PR08MB3745.eurprd08.prod.outlook.com
	(2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 908820e5-12d3-430c-801f-08d6e8c232b8
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:AM0PR08MB4116; 
x-ms-traffictypediagnostic: AM0PR08MB4116:
x-microsoft-antispam-prvs: <AM0PR08MB4116518BC1299820D6D13BBBCF150@AM0PR08MB4116.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(346002)(396003)(366004)(39850400004)(136003)(199004)(189003)(31686004)(8936002)(6486002)(99286004)(81166006)(186003)(6436002)(71190400001)(5660300002)(81156014)(8676002)(25786009)(66066001)(71200400001)(2201001)(66946007)(53936002)(110136005)(478600001)(76176011)(386003)(6506007)(52116002)(2501003)(14454004)(256004)(36756003)(31696002)(316002)(68736007)(54906003)(26005)(6512007)(86362001)(2906002)(2616005)(107886003)(305945005)(11346002)(4326008)(486006)(476003)(53546011)(446003)(102836004)(7736002)(66476007)(73956011)(66556008)(64756008)(66446008)(6116002)(3846002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4116;
	H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OMjRavZP07wzIYvz/uohh3ji6KbwJ0kHZ9AOvyYS4n69GOE3Ge1Pan2MuKFn5A+9oncP1DIDGyQNzNiHrb8Elg7KDKS+eBkNSyKxtrmCGerLTXTkzTU+2/q839RA4pPWezo7utYiBcaBuO60MJsXczJXxanpQvMYS4NLpDvGOO08/GExLK3ZvNtS46NGPzudKsOcryW5aNugrgv7xQ2S44tEsEOgP/8SmZamP1Yqpc8mQJLXuqpItMpTnbAe8jRVj4jm0U1U6lOvgWKeSYNdgocDASRky15SnKH6OxUA4at2lyrhljYrUik4EMoBUxiOdoTB3ygAb5WZUBjjFGHOvAJgy5NIR3s3ZrRMppWU4Iy7zD9ismvqWaPwOKdWLyY131baBiZkX0iWAMR89UM+CzTuAyodwMZzGZNcpLfMJu0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBAE99F0E4ECB1458BC4CE755BF1D581@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 908820e5-12d3-430c-801f-08d6e8c232b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 07:56:49.4144 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dplotnikov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4116
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.102
Subject: [Qemu-devel] [PING]  [PATCH v0 0/3] add zstd cluster compression
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI4LjA1LjIwMTkgMTc6MzcsIERlbmlzIFBsb3RuaWtvdiB3cm90ZToNCj4gVGhlIGdv
YWwgb2YgdGhlIHBhdGNoLXNldCBpcyB0byBlbmFibGUgcWNvdzIgdG8gdXNlIHpzdGQgY29tcHJl
c3Npb24gZm9yDQo+IGNsdXN0ZXJzLiBaU1REIHByb3ZpZGVzIGJldHRlciAoZGUpY29tcHJlc3Np
b24gcGVyZm9ybWFuY2UgdGhhbiBjdXJyZW50bHkNCj4gdXNlZCBaTElCLiBVc2luZyBpdCB3aWxs
IGltcHJvdmUgcGVyZm9yYW1uY2UgKHJlZHVjZSBjb21wcmVzc2lvbiB0aW1lKQ0KPiB3aGVuIHRo
ZSBjb21wcmVzc2VkIGNsdXN0ZXJzIGlzIHVzZWQsIGUuZyBiYWNrdXAgc2NlbmFyaW9zLg0KPiAN
Cj4gQWxzbywgdGhlIHBhdGNoLXNldCBleHRlbmRzIHFjb3cyIHNwZWNpZmljYXRpb24gYnkgYWRk
aW5nIGNvbXByZXNzaW9uX3R5cGUNCj4gZmVhdHVyZS4gVGhlIGZlYXR1cmUgZW5hYmxlcyBhZGRp
bmcgWlNURCBhbmQgYW5vdGhlciBjb21wcmVzc2lvbiBhbGdvcml0aG1zDQo+IGluIHRoZSBmdXR1
cmUuDQo+IA0KPiBIZXJlIGlzIHNvbWUgbWVhc3VyZW1lbnRzIFpTVEQgdnMgWkxJQjoNCj4gDQo+
IFRoZSB0ZXN0Og0KPiAgICAgIFRlc3QgY29tcHJlc3NlcyBhbmQgZGVjb21wcmVzc2VzIHFlbXUg
cWNvdzIgaW1hZ2Ugd2l0aCBqdXN0DQo+ICAgICAgaW5zdGFsbGVkIHJoZWwtNy42IGd1ZXN0Lg0K
PiAgICAgIEltYWdlIGNsdXN0ZXIgc2l6ZTogNjRLLiBJbWFnZSBvbiBkaXNrIHNpemU6IDIuMkcN
Cj4gICAgICANCj4gICAgICBUaGUgdGVzdCB3YXMgY29uZHVjdGVkIHdpdGggYnJkIGRpc2sgdG8g
cmVkdWNlIHRoZSBpbmZsdWVuY2UNCj4gICAgICBvZiBkaXNrIHN1YnN5c3RlbSB0byB0aGUgdGVz
dCByZXN1bHRzLg0KPiAgICAgIFRoZSByZXN1bHRzIGlzIGdpdmVuIGluIHNlY29uZHMuDQo+ICAg
ICAgDQo+ICAgICAgY29tcHJlc3MgY21kOg0KPiAgICAgICAgdGltZSAuL3FlbXUtaW1nIGNvbnZl
cnQgLU8gcWNvdzIgLWMgLW8gY29tcHJlc3Npb25fdHlwZT1bemxpYnx6c3RkXQ0KPiAgICAgICAg
ICAgICAgICAgICAgICAgIHNyYy5pbWcgW3psaWJ8enN0ZF1fY29tcHJlc3NlZC5pbWcNCj4gICAg
ICBkZWNvbXByZXNzIGNtZA0KPiAgICAgICAgdGltZSAuL3FlbXUtaW1nIGNvbnZlcnQgLU8gcWNv
dzINCj4gICAgICAgICAgICAgICAgICAgICAgICBbemxpYnx6c3RkXV9jb21wcmVzc2VkLmltZyB1
bmNvbXByZXNzZWQuaW1nDQo+IA0KPiANCj4gVGhlIHJlc3VsdHM6DQo+ICAgICAgICAgICAgICAg
ICBjb21wcmVzc2lvbiAgICAgICAgICAgICAgIGRlY29tcHJlc3Npb24NCj4gICAgICAgICAgICAg
ICB6bGliICAgICAgIHpzdGQgICAgICAgICAgIHpsaWIgICAgICAgICB6c3RkDQo+ICAgICAgLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQo+ICAgICAgcmVhbCAgICAgNjUuNSAgICAgICAxNi4zICgtNzUgJSkgICAgMS45ICAgICAgICAg
IDEuNiAoLTE2ICUpDQo+ICAgICAgdXNlciAgICAgNjUuMCAgICAgICAxNS44ICAgICAgICAgICAg
NS4zICAgICAgICAgIDIuNQ0KPiAgICAgIHN5cyAgICAgICAzLjMgICAgICAgIDAuMiAgICAgICAg
ICAgIDIuMCAgICAgICAgICAyLjANCj4gICAgICANCj4gICAgICBCb3RoIFpMSUIgYW5kIFpTVEQg
Z2F2ZSB0aGUgc2FtZSBjb21wcmVzc2lvbiByYXRpbzogfjEuNQ0KPiAgICAgIGNvbXByZXNzZWQg
aW1hZ2Ugc2l6ZSBpbiBib3RoIGNhc2VzOiB+MS40Rw0KPiANCj4gRGVuaXMgUGxvdG5pa292ICgz
KToNCj4gICAgcWNvdzI6IGludHJvZHVjZSBjb21wcmVzc2lvbiB0eXBlIGZlYXR1cmUNCj4gICAg
cWNvdzI6IGFkZCBjb21wcmVzc2lvbiB0eXBlIHByb2Nlc3NpbmcNCj4gICAgcWNvdzI6IGFkZCB6
c3RkIGNsdXN0ZXIgY29tcHJlc3Npb24NCj4gDQo+ICAgYmxvY2svcWNvdzIuYyAgICAgICAgICAg
ICB8IDI0MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiAgIGJsb2Nr
L3Fjb3cyLmggICAgICAgICAgICAgfCAgMjkgKysrLS0NCj4gICBjb25maWd1cmUgICAgICAgICAg
ICAgICAgIHwgIDI2ICsrKysrDQo+ICAgZG9jcy9pbnRlcm9wL3Fjb3cyLnR4dCAgICB8ICAzNyAr
KysrKy0NCj4gICBpbmNsdWRlL2Jsb2NrL2Jsb2NrX2ludC5oIHwgICAxICsNCj4gICBxYXBpL2Js
b2NrLWNvcmUuanNvbiAgICAgIHwgIDM0ICsrKysrLQ0KPiAgIDYgZmlsZXMgY2hhbmdlZCwgMzQ4
IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPiANCg0KLS0gDQpCZXN0LA0KRGVuaXMN
Cg==

