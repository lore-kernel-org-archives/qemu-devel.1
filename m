Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A5CC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 11:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B21B82075B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 11:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cpW+vMPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21B82075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39913 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYUYJ-0006zW-Gy
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 07:57:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYUVU-0004nS-VC
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 07:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYUVT-00043I-OQ
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 07:55:04 -0400
Received: from mail-am5eur03on0726.outbound.protection.outlook.com
	([2a01:111:f400:fe08::726]:50338
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hYUVQ-0003wS-Cj; Wed, 05 Jun 2019 07:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=VVWhk7PaIhPQhTsD7mmQHaYcRG1GkHKkdGuBe7TGTw0=;
	b=cpW+vMPVwwtsOWV/QdqnGJ/trgzfaTOXD1WegxjI3UOsmWkClxWW4k4/jx/TJvPv9xcvoiSL2nApAF2EPF5zSAJoU+Ul24jHO7UHdOSmfCC9xtwyQKfzUHz+04R6EBNgFGc9LyRQ/8h6k91XOz6+rIfqRXqC9VuDLvrfu1zLIfU=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB3490.eurprd08.prod.outlook.com (20.177.111.92) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1943.22; Wed, 5 Jun 2019 11:54:55 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8]) by
	AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1965.011;
	Wed, 5 Jun 2019 11:54:55 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [PATCH v2 01/12] util/iov: introduce qemu_iovec_init_extended
Thread-Index: AQHVGvDDeK9x+bV8qUeYpyiBzw0goaaM9ReA
Date: Wed, 5 Jun 2019 11:54:55 +0000
Message-ID: <02439512-727e-1a93-a77d-51cd0bdbe9ea@virtuozzo.com>
References: <20190604161514.262241-1-vsementsov@virtuozzo.com>
	<20190604161514.262241-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190604161514.262241-2-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0019.eurprd04.prod.outlook.com
	(2603:10a6:3:d0::29) To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190605145453571
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49d12cf4-0661-49c4-2642-08d6e9aca059
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:AM0PR08MB3490; 
x-ms-traffictypediagnostic: AM0PR08MB3490:
x-microsoft-antispam-prvs: <AM0PR08MB34903BBBA282B75F016D3CB3C1160@AM0PR08MB3490.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(346002)(366004)(39850400004)(396003)(136003)(189003)(199004)(256004)(446003)(14444005)(6436002)(36756003)(6512007)(476003)(2616005)(11346002)(31696002)(68736007)(7736002)(26005)(66066001)(71200400001)(71190400001)(316002)(110136005)(86362001)(6486002)(486006)(5660300002)(229853002)(54906003)(66476007)(66556008)(64756008)(66446008)(2906002)(386003)(31686004)(52116002)(76176011)(8676002)(4326008)(6506007)(14454004)(2501003)(25786009)(102836004)(8936002)(186003)(6246003)(305945005)(53936002)(3846002)(6116002)(66946007)(478600001)(81156014)(99286004)(107886003)(73956011)(81166006)(309714004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3490;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +PuHam6JciSdfg6bMtgds3cRRjv+mr800j4ZpAR7nlsQz2J/eiWf7mGSQFuFAQ9Tc7JM/ODfjMLHT/xQHuEwRPOMjx5eqLTlw7pEVhXG1oVRIpHCdWVBppNFJq8zofICitZ7cYB10HE13l0b28RJcbqQSHEPrthjSKnUxscceHLIMCLXgDpiu7t3hdn2NBpp+ii3HH4LP+4K9NYs4LhPLpduZRtX1WDiLM8tI0gbDupyfeM5h73/k4xWK9UkFR1H2q9p9VkILkjw8Z8HDdfcKDJyxy0JL5aQUmP5JfTG/9IUGi3sZiSJP2Lp588oZqsPSGGCogbbx6y5u5gAibO3mdYdWIGBuxVv6Jdoe4gSIdOoWUPEuY69JFEM6Ux0pwo1fkMON0C5l1EudLwYoIg0pbGc0VFfNFhrvCyuvPFDVQQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77E1AD61D4B7B3488E25BB8D2739E869@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d12cf4-0661-49c4-2642-08d6e9aca059
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 11:54:55.7065 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3490
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe08::726
Subject: Re: [Qemu-devel] [PATCH v2 01/12] util/iov: introduce
 qemu_iovec_init_extended
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
	Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDQuMDYuMjAxOSAxOToxNSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
SW50cm9kdWNlIG5ldyBpbml0aWFsaXphdGlvbiBBUEksIHRvIGNyZWF0ZSByZXF1ZXN0cyB3aXRo
IHBhZGRpbmcuIFdpbGwNCj4gYmUgdXNlZCBpbiB0aGUgZm9sbG93aW5nIHBhdGNoLiBOZXcgQVBJ
IHVzZXMgcWVtdV9pb3ZlY19pbml0X2J1ZiBpZg0KPiByZXN1bHRpbmcgaW8gdmVjdG9yIGhhcyBv
bmx5IG9uZSBlbGVtZW50LCB0byBhdm9pZCBleHRyYSBhbGxvY2F0aW9ucy4NCj4gU28sIHdlIG5l
ZWQgdG8gdXBkYXRlIHFlbXVfaW92ZWNfZGVzdHJveSB0byBzdXBwb3J0IGRlc3Ryb3lpbmcgc3Vj
aA0KPiBRSU9Wcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2ll
dnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4gLS0tDQo+ICAgaW5jbHVkZS9xZW11
L2lvdi5oIHwgICA3ICsrKw0KPiAgIHV0aWwvaW92LmMgICAgICAgICB8IDExMiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gICAyIGZpbGVzIGNoYW5nZWQs
IDExNCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvcWVtdS9pb3YuaCBiL2luY2x1ZGUvcWVtdS9pb3YuaA0KPiBpbmRleCA0OGI0NTk4N2I3
Li5mMzc4N2EwY2Y3IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL3FlbXUvaW92LmgNCj4gKysrIGIv
aW5jbHVkZS9xZW11L2lvdi5oDQo+IEBAIC0xOTksNiArMTk5LDEzIEBAIHN0YXRpYyBpbmxpbmUg
dm9pZCAqcWVtdV9pb3ZlY19idWYoUUVNVUlPVmVjdG9yICpxaW92KQ0KPiAgIA0KPiAgIHZvaWQg
cWVtdV9pb3ZlY19pbml0KFFFTVVJT1ZlY3RvciAqcWlvdiwgaW50IGFsbG9jX2hpbnQpOw0KPiAg
IHZvaWQgcWVtdV9pb3ZlY19pbml0X2V4dGVybmFsKFFFTVVJT1ZlY3RvciAqcWlvdiwgc3RydWN0
IGlvdmVjICppb3YsIGludCBuaW92KTsNCj4gK3ZvaWQgcWVtdV9pb3ZlY19pbml0X2V4dGVuZGVk
KA0KPiArICAgICAgICBRRU1VSU9WZWN0b3IgKnFpb3YsDQo+ICsgICAgICAgIHZvaWQgKmhlYWRf
YnVmLCBzaXplX3QgaGVhZF9sZW4sDQo+ICsgICAgICAgIFFFTVVJT1ZlY3RvciAqbWlkX3Fpb3Ys
IHNpemVfdCBtaWRfb2Zmc2V0LCBzaXplX3QgbWlkX2xlbiwNCj4gKyAgICAgICAgdm9pZCAqdGFp
bF9idWYsIHNpemVfdCB0YWlsX2xlbik7DQo+ICt2b2lkIHFlbXVfaW92ZWNfaW5pdF9zbGljZShR
RU1VSU9WZWN0b3IgKnFpb3YsIFFFTVVJT1ZlY3RvciAqc291cmNlLA0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc2l6ZV90IG9mZnNldCwgc2l6ZV90IGxlbik7DQo+ICAgdm9pZCBxZW11
X2lvdmVjX2FkZChRRU1VSU9WZWN0b3IgKnFpb3YsIHZvaWQgKmJhc2UsIHNpemVfdCBsZW4pOw0K
PiAgIHZvaWQgcWVtdV9pb3ZlY19jb25jYXQoUUVNVUlPVmVjdG9yICpkc3QsDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICBRRU1VSU9WZWN0b3IgKnNyYywgc2l6ZV90IHNvZmZzZXQsIHNpemVf
dCBzYnl0ZXMpOw0KPiBkaWZmIC0tZ2l0IGEvdXRpbC9pb3YuYyBiL3V0aWwvaW92LmMNCj4gaW5k
ZXggNzRlNmNhOGVkNy4uMzliNmUzMTQ5NCAxMDA2NDQNCj4gLS0tIGEvdXRpbC9pb3YuYw0KPiAr
KysgYi91dGlsL2lvdi5jDQo+IEBAIC0zNTMsNiArMzUzLDEwMyBAQCB2b2lkIHFlbXVfaW92ZWNf
Y29uY2F0KFFFTVVJT1ZlY3RvciAqZHN0LA0KPiAgICAgICBxZW11X2lvdmVjX2NvbmNhdF9pb3Yo
ZHN0LCBzcmMtPmlvdiwgc3JjLT5uaW92LCBzb2Zmc2V0LCBzYnl0ZXMpOw0KPiAgIH0NCj4gICAN
Cj4gKy8qDQo+ICsgKiBxaW92X2ZpbmRfaW92DQo+ICsgKg0KPiArICogUmV0dXJuIHBvaW50ZXIg
dG8gaW92ZWMgc3RydWN0dXJlLCB3aGVyZSBieXRlIGF0IEBvZmZzZXQgaW4gb3JpZ2luYWwgdmVj
dG9yDQo+ICsgKiBAaW92IGV4YWN0bHkgaXMuDQo+ICsgKiBTZXQgQHJlbWFpbmluZ19vZmZzZXQg
dG8gYmUgb2Zmc2V0IGluc2lkZSB0aGF0IGlvdmVjIHRvIHRoZSBzYW1lIGJ5dGUuDQo+ICsgKi8N
Cj4gK3N0YXRpYyBzdHJ1Y3QgaW92ZWMgKmlvdl9za2lwX29mZnNldChzdHJ1Y3QgaW92ZWMgKmlv
diwgc2l6ZV90IG9mZnNldCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzaXplX3QgKnJlbWFpbmluZ19vZmZzZXQpDQo+ICt7DQo+ICsgICAgd2hpbGUgKG9mZnNldCA+
IDAgJiYgb2Zmc2V0ID49IGlvdi0+aW92X2xlbikgew0KPiArICAgICAgICBvZmZzZXQgLT0gaW92
LT5pb3ZfbGVuOw0KPiArICAgICAgICBpb3YrKzsNCj4gKyAgICB9DQo+ICsgICAgKnJlbWFpbmlu
Z19vZmZzZXQgPSBvZmZzZXQ7DQo+ICsNCj4gKyAgICByZXR1cm4gaW92Ow0KPiArfQ0KPiArDQo+
ICsvKg0KPiArICogcWlvdl9zbGljZQ0KPiArICoNCj4gKyAqIEZpbmQgc3ViYXJyYXkgb2YgaW92
ZWMncywgY29udGFpbmluZyByZXF1ZXN0ZWQgcmFuZ2UuIEBoZWFkIHdvdWxkDQo+ICsgKiBiZSBv
ZmZzZXQgaW4gZmlyc3QgaW92IChyZXR1cm5lZCBieSB0aGUgZnVuY3Rpb24pLCBAdGFpbCB3b3Vs
ZCBiZQ0KPiArICogY291bnQgb2YgZXh0cmEgYnl0ZXMgaW4gbGFzdCBpb3ZlYyAocmV0dXJuZWQg
aW92ICsgQG5pb3YgLSAxKS4NCj4gKyAqLw0KPiArc3RhdGljIHN0cnVjdCBpb3ZlYyAqcWlvdl9z
bGljZShRRU1VSU9WZWN0b3IgKnFpb3YsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHNpemVfdCBvZmZzZXQsIHNpemVfdCBsZW4sDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHNpemVfdCAqaGVhZCwgc2l6ZV90ICp0YWlsLCBpbnQgKm5pb3YpDQo+ICt7DQo+
ICsgICAgc3RydWN0IGlvdmVjICppb3YsICplbmRfaW92Ow0KPiArDQo+ICsgICAgYXNzZXJ0KG9m
ZnNldCArIGxlbiA8PSBxaW92LT5zaXplKTsNCj4gKw0KPiArICAgIGlvdiA9IGlvdl9za2lwX29m
ZnNldChxaW92LT5pb3YsIG9mZnNldCwgaGVhZCk7DQo+ICsgICAgZW5kX2lvdiA9IGlvdl9za2lw
X29mZnNldChpb3YsICpoZWFkICsgbGVuLCB0YWlsKTsNCj4gKw0KPiArICAgIGlmICgqdGFpbCA+
IDApIHsNCj4gKyAgICAgICAgYXNzZXJ0KCp0YWlsIDwgZW5kX2lvdi0+aW92X2xlbik7DQo+ICsg
ICAgICAgICp0YWlsID0gZW5kX2lvdi0+aW92X2xlbiAtICp0YWlsOw0KPiArICAgICAgICBlbmRf
aW92Kys7DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgKm5pb3YgPSBlbmRfaW92IC0gaW92Ow0KPiAr
DQo+ICsgICAgcmV0dXJuIGlvdjsNCj4gK30NCj4gKw0KPiArLyoNCj4gKyAqIENvbXBpbGUgbmV3
IGlvdmVjLCBjb21iaW5pbmcgQGhlYWRfYnVmIGJ1ZmZlciwgc3ViLXFpb3Ygb2YgQG1pZF9xaW92
LA0KPiArICogYW5kIEB0YWlsX2J1ZiBidWZmZXIgaW50byBuZXcgcWlvdi4NCj4gKyAqLw0KPiAr
dm9pZCBxZW11X2lvdmVjX2luaXRfZXh0ZW5kZWQoDQo+ICsgICAgICAgIFFFTVVJT1ZlY3RvciAq
cWlvdiwNCj4gKyAgICAgICAgdm9pZCAqaGVhZF9idWYsIHNpemVfdCBoZWFkX2xlbiwNCj4gKyAg
ICAgICAgUUVNVUlPVmVjdG9yICptaWRfcWlvdiwgc2l6ZV90IG1pZF9vZmZzZXQsIHNpemVfdCBt
aWRfbGVuLA0KPiArICAgICAgICB2b2lkICp0YWlsX2J1Ziwgc2l6ZV90IHRhaWxfbGVuKQ0KPiAr
ew0KPiArICAgIHNpemVfdCBtaWRfaGVhZCwgbWlkX3RhaWw7DQo+ICsgICAgaW50IHRvdGFsX25p
b3YsIG1pZF9uaW92Ow0KDQpPb3BzLCBjbGFuZyBpcyByaWdodCwgbWlkX25pb3YgbWF5IGJlIHVu
aW5pdGlhbGl6ZWQuIFNvLCBoZXJlIHNob3VsZCBiZSAibWlkX25pb3YgPSAwIi4NCg0KPiArICAg
IHN0cnVjdCBpb3ZlYyAqcCwgKm1pZF9pb3Y7DQo+ICsNCj4gKyAgICBpZiAobWlkX2xlbikgew0K
PiArICAgICAgICBtaWRfaW92ID0gcWlvdl9zbGljZShtaWRfcWlvdiwgbWlkX29mZnNldCwgbWlk
X2xlbiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJm1pZF9oZWFkLCAmbWlkX3Rh
aWwsICZtaWRfbmlvdik7DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgdG90YWxfbmlvdiA9ICEhaGVh
ZF9sZW4gKyBtaWRfbmlvdiArICEhdGFpbF9sZW47DQo+ICsgICAgaWYgKHRvdGFsX25pb3YgPT0g
MSkgew0KPiArICAgICAgICBxZW11X2lvdmVjX2luaXRfYnVmKHFpb3YsIE5VTEwsIDApOw0KPiAr
ICAgICAgICBwID0gJnFpb3YtPmxvY2FsX2lvdjsNCj4gKyAgICB9IGVsc2Ugew0KPiArICAgICAg
ICBxaW92LT5uaW92ID0gcWlvdi0+bmFsbG9jID0gdG90YWxfbmlvdjsNCj4gKyAgICAgICAgcWlv
di0+c2l6ZSA9IGhlYWRfbGVuICsgbWlkX2xlbiArIHRhaWxfbGVuOw0KPiArICAgICAgICBwID0g
cWlvdi0+aW92ID0gZ19uZXcoc3RydWN0IGlvdmVjLCBxaW92LT5uaW92KTsNCj4gKyAgICB9DQo+
ICsNCj4gKyAgICBpZiAoaGVhZF9sZW4pIHsNCj4gKyAgICAgICAgcC0+aW92X2Jhc2UgPSBoZWFk
X2J1ZjsNCj4gKyAgICAgICAgcC0+aW92X2xlbiA9IGhlYWRfbGVuOw0KPiArICAgICAgICBwKys7
DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgaWYgKG1pZF9sZW4pIHsNCj4gKyAgICAgICAgbWVtY3B5
KHAsIG1pZF9pb3YsIG1pZF9uaW92ICogc2l6ZW9mKCpwKSk7DQo+ICsgICAgICAgIHBbMF0uaW92
X2Jhc2UgPSAodWludDhfdCAqKXBbMF0uaW92X2Jhc2UgKyBtaWRfaGVhZDsNCj4gKyAgICAgICAg
cFswXS5pb3ZfbGVuIC09IG1pZF9oZWFkOw0KPiArICAgICAgICBwW21pZF9uaW92IC0gMV0uaW92
X2xlbiAtPSBtaWRfdGFpbDsNCj4gKyAgICAgICAgcCArPSBtaWRfbmlvdjsNCj4gKyAgICB9DQo+
ICsNCj4gKyAgICBpZiAodGFpbF9sZW4pIHsNCj4gKyAgICAgICAgcC0+aW92X2Jhc2UgPSB0YWls
X2J1ZjsNCj4gKyAgICAgICAgcC0+aW92X2xlbiA9IHRhaWxfbGVuOw0KPiArICAgIH0NCj4gK30N
Cj4gKw0KPiAgIC8qDQo+ICAgICogQ2hlY2sgaWYgdGhlIGNvbnRlbnRzIG9mIHRoZSBpb3ZlY3Mg
YXJlIGFsbCB6ZXJvDQo+ICAgICovDQo+IEBAIC0zNzQsMTQgKzQ3MSwxOSBAQCBib29sIHFlbXVf
aW92ZWNfaXNfemVybyhRRU1VSU9WZWN0b3IgKnFpb3YpDQo+ICAgICAgIHJldHVybiB0cnVlOw0K
PiAgIH0NCj4gICANCj4gK3ZvaWQgcWVtdV9pb3ZlY19pbml0X3NsaWNlKFFFTVVJT1ZlY3RvciAq
cWlvdiwgUUVNVUlPVmVjdG9yICpzb3VyY2UsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzaXplX3Qgb2Zmc2V0LCBzaXplX3QgbGVuKQ0KPiArew0KPiArICAgIHFlbXVfaW92ZWNfaW5p
dF9leHRlbmRlZChxaW92LCBOVUxMLCAwLCBzb3VyY2UsIG9mZnNldCwgbGVuLCBOVUxMLCAwKTsN
Cj4gK30NCj4gKw0KPiAgIHZvaWQgcWVtdV9pb3ZlY19kZXN0cm95KFFFTVVJT1ZlY3RvciAqcWlv
dikNCj4gICB7DQo+IC0gICAgYXNzZXJ0KHFpb3YtPm5hbGxvYyAhPSAtMSk7DQo+ICsgICAgaWYg
KHFpb3YtPm5hbGxvYyAhPSAtMSkgew0KPiArICAgICAgICBnX2ZyZWUocWlvdi0+aW92KTsNCj4g
KyAgICB9DQo+ICAgDQo+IC0gICAgcWVtdV9pb3ZlY19yZXNldChxaW92KTsNCj4gLSAgICBnX2Zy
ZWUocWlvdi0+aW92KTsNCj4gLSAgICBxaW92LT5uYWxsb2MgPSAwOw0KPiAtICAgIHFpb3YtPmlv
diA9IE5VTEw7DQo+ICsgICAgbWVtc2V0KHFpb3YsIDAsIHNpemVvZigqcWlvdikpOw0KPiAgIH0N
Cj4gICANCj4gICB2b2lkIHFlbXVfaW92ZWNfcmVzZXQoUUVNVUlPVmVjdG9yICpxaW92KQ0KPiAN
Cg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

