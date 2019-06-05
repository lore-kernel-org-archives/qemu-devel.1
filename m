Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCC5C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:13:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEAB22075C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GZxWYNwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEAB22075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45704 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYYX6-0008DS-VJ
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 12:13:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYYVX-0007GC-Bc
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYYVU-0001yH-Mx
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:11:22 -0400
Received: from mail-eopbgr70099.outbound.protection.outlook.com
	([40.107.7.99]:46274
	helo=EUR04-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hYYVN-0001aq-7u; Wed, 05 Jun 2019 12:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=VF0lMQsHKVftPeLDEkidqg8obOgEAXh0psVaxQ5hXj0=;
	b=GZxWYNwpkXc/OjohcDTW8m8H7wGCQo7HKSkEx1xSbyuGlLcbKm54katBqZUGElzGczxDv6nvqyfFLV4MdYV7Q+gFzPYPu3WKLe+cvQTYhzGzF4l9Z/DuT60stF9lTWrqikgvWZNch5XYwzqpeD+RlGvq47FlQRguEOB9P+vsWDQ=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB4577.eurprd08.prod.outlook.com (20.178.21.211) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1943.22; Wed, 5 Jun 2019 16:10:51 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8]) by
	AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1965.011;
	Wed, 5 Jun 2019 16:10:51 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH 1/2] io/channel: add
	qio_channel_set_keepalive
Thread-Index: AQHVG4a+ncu9+Np8N0yZj/ts3zHEaaaNOTsAgAACMoA=
Date: Wed, 5 Jun 2019 16:10:51 +0000
Message-ID: <70fc6539-c418-8a27-057a-c645b6a1883d@virtuozzo.com>
References: <20190605100913.34972-1-vsementsov@virtuozzo.com>
	<20190605100913.34972-2-vsementsov@virtuozzo.com>
	<20190605160258.GK8956@redhat.com>
In-Reply-To: <20190605160258.GK8956@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P195CA0017.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::27)
	To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190605191049608
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21888478-ef3d-42d6-ccd1-08d6e9d06150
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:AM0PR08MB4577; 
x-ms-traffictypediagnostic: AM0PR08MB4577:
x-microsoft-antispam-prvs: <AM0PR08MB4577E3445260648140624B78C1160@AM0PR08MB4577.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(396003)(136003)(39850400004)(376002)(366004)(189003)(199004)(66066001)(81156014)(5660300002)(81166006)(6916009)(316002)(54906003)(53936002)(2616005)(476003)(76176011)(446003)(8936002)(31686004)(26005)(8676002)(66476007)(11346002)(305945005)(6436002)(71190400001)(52116002)(478600001)(71200400001)(486006)(14454004)(99286004)(7736002)(68736007)(186003)(6246003)(14444005)(2906002)(6512007)(6486002)(107886003)(64756008)(386003)(6506007)(66556008)(66446008)(73956011)(3846002)(66946007)(229853002)(86362001)(31696002)(4326008)(36756003)(6116002)(102836004)(25786009)(256004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4577;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AFnQfW5DDHopTR0b9qghx+LL0NV/HtIle1DCJ3JyoozQB0Fx87EbrZVV2/RpmWcdt2TamcE+xA0oQpYHfdthNk432ir9sdSGTHvkXxrr4yk1ytjvhkmGMUBcNaT7acu/IJu+aeQUEwMzzD3hxm3IUh1DglfvvuW3UJevap+rNEL+9r1Z1AbjCVNvJIYxmWFeYFkGvTBFMhPXYYydQoDgxuJvWPRb/z6nCLiljk61CVhJpU1/5YzW4JKibzAzVzOslJT2ap5+libblG9UuHxakreu9g45g47MXVFfwph/KNQ2zIOGzIjtX63D5ATU2GeKDfD+U9FXMKM6a/ScwKM2ZfdMr/qLNIjKT6CT7YveFnpkYU/9vmvGEEW5YtXFKG4maq3BEGXs4teTMv/ZQWyirDpiG5ONZaq+ARtFUw/u5N8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71076451B877194491DE780D108B70BC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21888478-ef3d-42d6-ccd1-08d6e9d06150
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 16:10:51.7137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4577
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.99
Subject: Re: [Qemu-devel] [PATCH 1/2] io/channel: add
 qio_channel_set_keepalive
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDUuMDYuMjAxOSAxOTowMiwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4gT24gV2VkLCBK
dW4gMDUsIDIwMTkgYXQgMDE6MDk6MTJQTSArMDMwMCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2
c2tpeSB3cm90ZToNCj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+IC0tLQ0KPj4gICBpbmNsdWRlL2lvL2No
YW5uZWwuaCB8IDEzICsrKysrKysrKysrKysNCj4+ICAgaW8vY2hhbm5lbC1zb2NrZXQuYyAgfCAx
OSArKysrKysrKysrKysrKysrKysrDQo+PiAgIGlvL2NoYW5uZWwuYyAgICAgICAgIHwgMTQgKysr
KysrKysrKysrKysNCj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaW8vY2hhbm5lbC5oIGIvaW5jbHVkZS9pby9jaGFubmVs
LmgNCj4+IGluZGV4IDU5NDYwY2IxZWMuLjM0ZDg3MWE0MTQgMTAwNjQ0DQo+PiAtLS0gYS9pbmNs
dWRlL2lvL2NoYW5uZWwuaA0KPj4gKysrIGIvaW5jbHVkZS9pby9jaGFubmVsLmgNCj4+IEBAIC0x
MjQsNiArMTI0LDkgQEAgc3RydWN0IFFJT0NoYW5uZWxDbGFzcyB7DQo+PiAgICAgICBpbnQgKCpp
b19zZXRfYmxvY2tpbmcpKFFJT0NoYW5uZWwgKmlvYywNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgYm9vbCBlbmFibGVkLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBF
cnJvciAqKmVycnApOw0KPj4gKyAgICBpbnQgKCppb19zZXRfa2VlcGFsaXZlKShRSU9DaGFubmVs
ICppb2MsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgZW5hYmxlZCwNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKTsNCj4+ICAgDQo+PiAg
ICAgICAvKiBPcHRpb25hbCBjYWxsYmFja3MgKi8NCj4+ICAgICAgIGludCAoKmlvX3NodXRkb3du
KShRSU9DaGFubmVsICppb2MsDQo+PiBAQCAtNDkwLDYgKzQ5MywxNiBAQCBpbnQgcWlvX2NoYW5u
ZWxfc2V0X2Jsb2NraW5nKFFJT0NoYW5uZWwgKmlvYywNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBib29sIGVuYWJsZWQsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgRXJyb3IgKiplcnJwKTsNCj4+ICAgDQo+PiArLyoNCj4+ICsgKiBxaW9fY2hhbm5lbF9zZXRf
a2VlcGFsaXZlOg0KPj4gKyAqIEBpb2M6IHRoZSBjaGFubmVsIG9iamVjdA0KPj4gKyAqIEBlbmFi
bGVkOiB0aGUga2VlcGFsaXZlIGZsYWcgc3RhdGUNCj4+ICsgKiBAZXJycDogcG9pbnRlciB0byBh
IE5VTEwtaW5pdGlhbGl6ZWQgZXJyb3Igb2JqZWN0DQo+PiArICovDQo+IA0KPiBNaXNzaW5nIGRv
Y3MgZm9yIHRoZSByZXR1cm4gdmFsdWUuIFNIb3VsZCBiZQ0KPiANCj4gICAgIlJldHVybnMgMCBv
biBzdWNjZXNzLCAtMSBvbiBlcnJvci4iDQo+IA0KPiBub3RlIHdlIGRvICpub3QqIHJldHVybiAi
LWVycm5vIiB2YWx1ZXMgaW4gUUlPQ2hhbm5lbCBBUElzDQo+IA0KPj4gK2ludCBxaW9fY2hhbm5l
bF9zZXRfa2VlcGFsaXZlKFFJT0NoYW5uZWwgKmlvYywNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBib29sIGVuYWJsZWQsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgRXJyb3IgKiplcnJwKTsNCj4+ICsNCj4gDQo+PiBkaWZmIC0tZ2l0IGEvaW8vY2hhbm5lbC1z
b2NrZXQuYyBiL2lvL2NoYW5uZWwtc29ja2V0LmMNCj4+IGluZGV4IGJjNWY4MGU3ODAuLjVjMWVh
MDg2NjAgMTAwNjQ0DQo+PiAtLS0gYS9pby9jaGFubmVsLXNvY2tldC5jDQo+PiArKysgYi9pby9j
aGFubmVsLXNvY2tldC5jDQo+PiBAQCAtNjU2LDYgKzY1NiwyNCBAQCBxaW9fY2hhbm5lbF9zb2Nr
ZXRfc2V0X2Jsb2NraW5nKFFJT0NoYW5uZWwgKmlvYywNCj4+ICAgfQ0KPj4gICANCj4+ICAgDQo+
PiArc3RhdGljIGludA0KPj4gK3Fpb19jaGFubmVsX3NvY2tldF9zZXRfa2VlcGFsaXZlKFFJT0No
YW5uZWwgKmlvYywNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIGVu
YWJsZWQsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJw
KQ0KPj4gK3sNCj4+ICsgICAgUUlPQ2hhbm5lbFNvY2tldCAqc2lvYyA9IFFJT19DSEFOTkVMX1NP
Q0tFVChpb2MpOw0KPj4gKyAgICBpbnQgdmFsID0gZW5hYmxlZDsNCj4+ICsgICAgaW50IHJldCA9
IHFlbXVfc2V0c29ja29wdChzaW9jLT5mZCwgU09MX1NPQ0tFVCwgU09fS0VFUEFMSVZFLA0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZ2YWwsIHNpemVvZih2YWwpKTsNCj4+ICsN
Cj4+ICsgICAgaWYgKHJldCA8IDApIHsNCj4+ICsgICAgICAgIGVycm9yX3NldGdfZXJybm8oZXJy
cCwgZXJybm8sICJVbmFibGUgdG8gc2V0IEtFRVBBTElWRSIpOw0KPiANCj4gQWRkICdyZXR1cm4g
LTEnIHRoZXJlIHRvIGJlIGV4cGxpY2l0LCBhdm9pZGluZyBuZWVkIHRvIHJlYWQgdXAgb24NCj4g
d2hldGhlciBxZW11X3NldHNvY2tvcHQgcmV0dXJucyAtMSBvciAtZXJybm8uICAoSXQgcmV0dXJu
cyAtMSkNCj4gDQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgcmV0dXJuIHJldDsNCj4+ICt9DQo+
PiArDQo+PiArDQo+PiAgIHN0YXRpYyB2b2lkDQo+PiAgIHFpb19jaGFubmVsX3NvY2tldF9zZXRf
ZGVsYXkoUUlPQ2hhbm5lbCAqaW9jLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGJvb2wgZW5hYmxlZCkNCj4+IEBAIC03NjIsNiArNzgwLDcgQEAgc3RhdGljIHZvaWQgcWlvX2No
YW5uZWxfc29ja2V0X2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKmtsYXNzLA0KPj4gICAgICAgaW9j
X2tsYXNzLT5pb193cml0ZXYgPSBxaW9fY2hhbm5lbF9zb2NrZXRfd3JpdGV2Ow0KPj4gICAgICAg
aW9jX2tsYXNzLT5pb19yZWFkdiA9IHFpb19jaGFubmVsX3NvY2tldF9yZWFkdjsNCj4+ICAgICAg
IGlvY19rbGFzcy0+aW9fc2V0X2Jsb2NraW5nID0gcWlvX2NoYW5uZWxfc29ja2V0X3NldF9ibG9j
a2luZzsNCj4+ICsgICAgaW9jX2tsYXNzLT5pb19zZXRfa2VlcGFsaXZlID0gcWlvX2NoYW5uZWxf
c29ja2V0X3NldF9rZWVwYWxpdmU7DQo+PiAgICAgICBpb2Nfa2xhc3MtPmlvX2Nsb3NlID0gcWlv
X2NoYW5uZWxfc29ja2V0X2Nsb3NlOw0KPj4gICAgICAgaW9jX2tsYXNzLT5pb19zaHV0ZG93biA9
IHFpb19jaGFubmVsX3NvY2tldF9zaHV0ZG93bjsNCj4+ICAgICAgIGlvY19rbGFzcy0+aW9fc2V0
X2NvcmsgPSBxaW9fY2hhbm5lbF9zb2NrZXRfc2V0X2Nvcms7DQo+PiBkaWZmIC0tZ2l0IGEvaW8v
Y2hhbm5lbC5jIGIvaW8vY2hhbm5lbC5jDQo+PiBpbmRleCAyYTI2YzJhMmMwLi4wZjBiMmI3YjY1
IDEwMDY0NA0KPj4gLS0tIGEvaW8vY2hhbm5lbC5jDQo+PiArKysgYi9pby9jaGFubmVsLmMNCj4+
IEBAIC0yNjUsNiArMjY1LDIwIEBAIGludCBxaW9fY2hhbm5lbF9zZXRfYmxvY2tpbmcoUUlPQ2hh
bm5lbCAqaW9jLA0KPj4gICAgICAgcmV0dXJuIGtsYXNzLT5pb19zZXRfYmxvY2tpbmcoaW9jLCBl
bmFibGVkLCBlcnJwKTsNCj4+ICAgfQ0KPj4gICANCj4+ICtpbnQgcWlvX2NoYW5uZWxfc2V0X2tl
ZXBhbGl2ZShRSU9DaGFubmVsICppb2MsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgYm9vbCBlbmFibGVkLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9y
ICoqZXJycCkNCj4+ICt7DQo+PiArICAgIFFJT0NoYW5uZWxDbGFzcyAqa2xhc3MgPSBRSU9fQ0hB
Tk5FTF9HRVRfQ0xBU1MoaW9jKTsNCj4+ICsNCj4+ICsgICAgaWYgKCFrbGFzcy0+aW9fc2V0X2tl
ZXBhbGl2ZSkgew0KPj4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiS0VFUEFMSVZFIGlzIG5v
dCBzdXBwb3J0ZWQgYnkgSU8gY2hhbm5lbCIpOw0KPj4gKyAgICAgICAgcmV0dXJuIC1FTk9UU1VQ
Ow0KPiANCj4gcmV0dXJuIC0xOw0KPiANCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICByZXR1cm4g
a2xhc3MtPmlvX3NldF9rZWVwYWxpdmUoaW9jLCBlbmFibGVkLCBlcnJwKTsNCj4+ICt9DQo+PiAr
DQo+PiAgIA0KPj4gICBpbnQgcWlvX2NoYW5uZWxfY2xvc2UoUUlPQ2hhbm5lbCAqaW9jLA0KPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPiANCj4gUmVnYXJkcywNCj4g
RGFuaWVsDQo+IA0KDQpUaGFuayB5b3UsIEknbGwgcmVzZW5kDQoNCi0tIA0KQmVzdCByZWdhcmRz
LA0KVmxhZGltaXINCg==

