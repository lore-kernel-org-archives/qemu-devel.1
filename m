Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D2AC10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 18:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B231208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 18:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fTx5wHow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B231208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57787 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIztv-0000Cy-NI
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 14:12:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIzsc-0007GM-4c
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIzsa-0008JG-JE
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:10:54 -0400
Received: from mail-eopbgr10119.outbound.protection.outlook.com
	([40.107.1.119]:59214
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hIzsX-0008CY-5j; Tue, 23 Apr 2019 14:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=OVsj/In+aMSQQwkCBXvsn9oJGx0dJHTX+E+S4rDij7M=;
	b=fTx5wHowG4KPQbrGRAR183yBoCajVsK6Eh29xNCuDRNcpGGZBIF5leDq3JRAmO45pR0a29AMxTClTJYC7tqnjdqX3+965qeVqqyZRx5AlDLLEFiCBqSUz43E51SheK8pqL3bO5q24/DRytMZkEC8/epkJPpTMKye52SycioAIFk=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3241.eurprd08.prod.outlook.com (52.134.111.15) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.12; Tue, 23 Apr 2019 18:10:44 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1813.017;
	Tue, 23 Apr 2019 18:10:44 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 1/2] Makefile: add nit-picky mode to sphinx-build
Thread-Index: AQHU+Vko6le7PUXZmkeAQqTRBCSkK6ZKPVKA///OZwCAAAFNgA==
Date: Tue, 23 Apr 2019 18:10:44 +0000
Message-ID: <1397feac-3f80-5db6-4e03-566fd020c809@virtuozzo.com>
References: <20190422221714.7630-1-jsnow@redhat.com>
	<20190422221714.7630-2-jsnow@redhat.com>
	<eaa73eb3-a84f-a263-13b2-e25588f00fd7@virtuozzo.com>
	<91bbd108-4ac4-7e07-6d7f-03efb536ba14@redhat.com>
In-Reply-To: <91bbd108-4ac4-7e07-6d7f-03efb536ba14@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0377.eurprd05.prod.outlook.com
	(2603:10a6:7:94::36) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190423211041349
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d8b82d7-3d7e-4ce4-b774-08d6c81700e8
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3241; 
x-ms-traffictypediagnostic: DB7PR08MB3241:
x-microsoft-antispam-prvs: <DB7PR08MB3241EAE3BB3E5B27168674A7C1230@DB7PR08MB3241.eurprd08.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(39850400004)(376002)(136003)(366004)(346002)(52314003)(199004)(189003)(2501003)(71190400001)(486006)(6116002)(2616005)(66556008)(3846002)(476003)(86362001)(6506007)(386003)(26005)(93886005)(347745004)(446003)(68736007)(31696002)(110136005)(73956011)(316002)(256004)(66476007)(53936002)(64756008)(6486002)(6246003)(71200400001)(99286004)(54906003)(66946007)(66446008)(305945005)(11346002)(14444005)(2201001)(14454004)(36756003)(76176011)(8936002)(31686004)(6512007)(97736004)(52116002)(7416002)(186003)(81166006)(478600001)(81156014)(25786009)(229853002)(4326008)(53546011)(102836004)(66066001)(5660300002)(2906002)(7736002)(8676002)(6436002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3241;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FPmpYvgV8Yx88SA1HACzsQ/P+6zA0lu7q0zAFvleloXOatYJ2Sao7Mv3n4OyDBn5VE9OOO95sl9OWbj8qp8VH+PKzJ6BVBrzFMa2e5iyxWrLz157FuPE/84llFca9bBccaJMbIcfqUY162TlUdR/XSb4TV8+GtCMjwHTDJjs23+tYbFg567en4J+NOg+wOPFpupZP/o6VzDcDWGSgTji3bO6dnqzMBYAbkvJb3SYZNgEKz9sVO3JaiO0kBaDaPvjsSndSCAtvNeL1VYm5bXu7HX398Hp6Ea+9vyyna3qEP74hQZKIt4rkgizj3tKuR2DPHjoQw8jVeIUCu4GyduqM0FZDDqOTaOHUUKZK3sPs4h5Ao24+ijvsQpWe1Vvfj+tKdoybikHyKr91KmqUQ2SgskdgsDEw9ennZSbHL/YLdc=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <446CE5FA89566341A82D84F3A04E6A1F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8b82d7-3d7e-4ce4-b774-08d6c81700e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 18:10:44.7290 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3241
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.119
Subject: Re: [Qemu-devel] [PATCH v2 1/2] Makefile: add nit-picky mode to
 sphinx-build
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
Cc: Fam Zheng <fam@euphon.net>, "aliang@redhat.com" <aliang@redhat.com>,
	"kchamart@redhat.com" <kchamart@redhat.com>,
	"qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
	"armbru@redhat.com" <armbru@redhat.com>,
	"nsoffer@redhat.com" <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423181044.f48MrBtFz2WcK8d6_UnyTAVvfFYv8NhcFQTayrPke9s@z>

MjMuMDQuMjAxOSAyMTowNiwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDQvMjMvMTkg
MjowMyBQTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDIzLjA0LjIw
MTkgMToxNywgSm9obiBTbm93IHdyb3RlOg0KPj4+IElmIHdlIGFkZCByZWZlcmVuY2VzIHRoYXQg
ZG9uJ3QgcmVzb2x2ZSAob3IgYWNjaWRlbnRhbGx5IHJlbW92ZSB0aGVtKSwNCj4+PiBpdCB3aWxs
IGJlIGhlbHBmdWwgdG8gaGF2ZSBhbiBlcnJvciBtZXNzYWdlIGFsZXJ0aW5nIHVzIHRvIHRoYXQu
DQo+Pg0KPj4gYWNjb3JkaW5nbHkgdG8gZG9jcyBJJ3ZlIGZvdW5kLCBub3QgZXJyb3IgYnV0IHdh
cm5pbmcuDQo+Pg0KPiBPaCwgdHJ1ZS4gSSBoYXZlIHRvIHJldmlzZSB0aGUgZG9jdW1lbnQgYW55
d2F5LCBzbyBJJ2xsIGNoYW5nZSBteQ0KPiBwaHJhc2luZyBoZXJlIC0tIGl0IHdvbid0IGNhdXNl
IHRoZSBidWlsZCB0byBmYWlsLCBidXQgeW91IHdpbGwgYmUgYWJsZQ0KPiB0byBzZWUgdGhlIGVy
cm9yIHdoZW4geW91IGJ1aWxkLiBJIHRoaW5rIGl0J3MgaGVscGZ1bCB0byBoYXZlIGFzIGENCj4g
bWVjaGFuaWNhbCBjaGVjayAtLSBlc3BlY2lhbGx5IGlmIHdlIHN1Y2NlZWQgaW4gYnVpbGRpbmcg
Z2VuZXJhdGVkIFJlU1QNCj4gZG9jdW1lbnRhdGlvbiAoZXZlbnR1YWxseT8uLi4pDQoNCkhtLCBp
ZiB3ZSBub3cgZG9uJ3QgaGF2ZSBvdGhlciB3YXJuaW5ncywgd2UgbWF5IGFsc28gZW5hYmxlIC1X
LCB0byBiZSBzdHJpY3QuDQoNCj4gDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBKb2huIFNub3cg
PGpzbm93QHJlZGhhdC5jb20+DQo+Pg0KPj4gUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNv
di1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+DQo+Pj4gLS0tDQo+Pj4g
ICAgTWFrZWZpbGUgfCAyICstDQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvTWFrZWZpbGUgYi9NYWtlZmls
ZQ0KPj4+IGluZGV4IDA0YTBkNDUwNTAuLmZmOWNlMmVkNGMgMTAwNjQ0DQo+Pj4gLS0tIGEvTWFr
ZWZpbGUNCj4+PiArKysgYi9NYWtlZmlsZQ0KPj4+IEBAIC04OTksNyArODk5LDcgQEAgZG9jcy92
ZXJzaW9uLnRleGk6ICQoU1JDX1BBVEgpL1ZFUlNJT04NCj4+PiAgICBzcGhpbnhkb2NzOiAkKE1B
TlVBTF9CVUlMRERJUikvZGV2ZWwvaW5kZXguaHRtbCAkKE1BTlVBTF9CVUlMRERJUikvaW50ZXJv
cC9pbmRleC5odG1sDQo+Pj4gICAgDQo+Pj4gICAgIyBDYW5uZWQgY29tbWFuZCB0byBidWlsZCBh
IHNpbmdsZSBtYW51YWwNCj4+PiAtYnVpbGQtbWFudWFsID0gJChjYWxsIHF1aWV0LWNvbW1hbmQs
c3BoaW54LWJ1aWxkICQoaWYgJChWKSwsLXEpIC1iIGh0bWwgLUQgdmVyc2lvbj0kKFZFUlNJT04p
IC1EIHJlbGVhc2U9IiQoRlVMTF9WRVJTSU9OKSIgLWQgLmRvY3RyZWVzLyQxICQoU1JDX1BBVEgp
L2RvY3MvJDEgJChNQU5VQUxfQlVJTERESVIpLyQxICwiU1BISU5YIiwiJChNQU5VQUxfQlVJTERE
SVIpLyQxIikNCj4+PiArYnVpbGQtbWFudWFsID0gJChjYWxsIHF1aWV0LWNvbW1hbmQsc3BoaW54
LWJ1aWxkICQoaWYgJChWKSwsLXEpIC1uIC1iIGh0bWwgLUQgdmVyc2lvbj0kKFZFUlNJT04pIC1E
IHJlbGVhc2U9IiQoRlVMTF9WRVJTSU9OKSIgLWQgLmRvY3RyZWVzLyQxICQoU1JDX1BBVEgpL2Rv
Y3MvJDEgJChNQU5VQUxfQlVJTERESVIpLyQxICwiU1BISU5YIiwiJChNQU5VQUxfQlVJTERESVIp
LyQxIikNCj4+PiAgICAjIFdlIGFzc3VtZSBhbGwgUlNUIGZpbGVzIGluIHRoZSBtYW51YWwncyBk
aXJlY3RvcnkgYXJlIHVzZWQgaW4gaXQNCj4+PiAgICBtYW51YWwtZGVwcyA9ICQod2lsZGNhcmQg
JChTUkNfUEFUSCkvZG9jcy8kMS8qLnJzdCkgJChTUkNfUEFUSCkvZG9jcy8kMS9jb25mLnB5ICQo
U1JDX1BBVEgpL2RvY3MvY29uZi5weQ0KPj4+ICAgIA0KPj4+DQo+Pg0KPj4NCj4gDQoNCg0KLS0g
DQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

