Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A18C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 07:45:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30EFE2652C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 07:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cYJ2oqJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30EFE2652C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38100 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWcEc-0003X5-D0
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 03:45:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hWcDl-000369-I0
	for qemu-devel@nongnu.org; Fri, 31 May 2019 03:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hWcDj-0005jb-K4
	for qemu-devel@nongnu.org; Fri, 31 May 2019 03:45:01 -0400
Received: from mail-eopbgr80130.outbound.protection.outlook.com
	([40.107.8.130]:1414
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1hWcDc-0005Tb-A3; Fri, 31 May 2019 03:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=DX+yP+ayZDOrVQ7y2GAjm5DLOLrXDmodgL+YMsQesWs=;
	b=cYJ2oqJYldl6LU3/CFWpWDLzSGO5ORiWE7LhQYD4umhflJgSwF1GFMJP9hJ7LDRMi+gH644E83sWuLh6kgt9+kryqHTBBH38wGhZCWup+X83O8zIp9xvw9jky3hgM6POOmLLqZpx07SDCIfZjwHOpXzlZk0caKn5eknnaxKnYqI=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
	AM0PR08MB4401.eurprd08.prod.outlook.com (20.179.32.214) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.18; Fri, 31 May 2019 07:44:46 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
	([fe80::1deb:8cf1:f7d2:16cf]) by
	AM0PR08MB3745.eurprd08.prod.outlook.com
	([fe80::1deb:8cf1:f7d2:16cf%6]) with mapi id 15.20.1922.024;
	Fri, 31 May 2019 07:44:46 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Thread-Topic: [Qemu-block] [PATCH v4] qemu-io: add pattern file for write
	command
Thread-Index: AQHVFsFuanwd9ZC/akyAdq6XTNnnaqaE9tyA///cvYCAAAhQAA==
Date: Fri, 31 May 2019 07:44:46 +0000
Message-ID: <c85f4754-0d92-3308-5d36-8470b03fcf28@virtuozzo.com>
References: <20190530081055.9560-1-dplotnikov@virtuozzo.com>
	<20190530082646.ltwaew7jlaybumiv@steredhat.homenet.telecomitalia.it>
	<d4e62140-4b0d-a519-021a-a9bfd9b13eb9@virtuozzo.com>
	<20190531071459.dy7wuszgmunnhsf3@steredhat.homenet.telecomitalia.it>
In-Reply-To: <20190531071459.dy7wuszgmunnhsf3@steredhat.homenet.telecomitalia.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR08CA0045.eurprd08.prod.outlook.com
	(2603:10a6:7:2a::16) To AM0PR08MB3745.eurprd08.prod.outlook.com
	(2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c3b3a06-00ee-4328-55d2-08d6e59bda32
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:AM0PR08MB4401; 
x-ms-traffictypediagnostic: AM0PR08MB4401:
x-microsoft-antispam-prvs: <AM0PR08MB440119E1D243B31197F12AC1CF190@AM0PR08MB4401.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(396003)(136003)(366004)(376002)(39850400004)(199004)(189003)(7736002)(476003)(71200400001)(6116002)(6486002)(71190400001)(3846002)(486006)(2616005)(25786009)(446003)(11346002)(305945005)(8676002)(6916009)(31686004)(81166006)(6436002)(81156014)(66066001)(2906002)(6512007)(8936002)(4326008)(68736007)(53936002)(386003)(6506007)(14454004)(53546011)(99286004)(186003)(76176011)(52116002)(54906003)(5660300002)(102836004)(229853002)(478600001)(107886003)(26005)(256004)(316002)(6246003)(66946007)(73956011)(36756003)(66476007)(66556008)(64756008)(66446008)(86362001)(31696002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4401;
	H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: T96YL9vBC290T6tjDHf2qsmgdALLbClGRc8WSVXNV9ol7HR9QDIzHlwNNax2fbI0K8G0iM1EPCGnT1PDanvoW6ufX0bPmKulff25+Ip7DZtf5W1FjN3L3rkX5+7Jas1lNqYQ4MhZQCFR4dP9KlXthroWHdjWpHUjbFq+ch971vSj7cuvrMr0Oj7UAEdWHjYMu6NyOZIsZdAMcLqhC6BX1rGwcvx/d4Wjg4uY6bViYbWCxAS6kPJfz52uSa5fSP2BhCwnePHF6Q3yU0REmUiLjDJO5xmwr0w26pSX6Tpt6HKL0pcS+zzZ0Hv62wVWFNvSU0uBtSm/RyP3tCJ0l1lyAT9ggghn7RkMgZiCt381xZzp8aq1e2lZ2QSoJ4XdIEbhFVvmi6x65nnIYSMLHEJcYfXEKIKFs5CEEL+gtnoHKgk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A32E4F72CC551E45B7BFD08FCA36A4E9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3b3a06-00ee-4328-55d2-08d6e59bda32
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 07:44:46.6545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dplotnikov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4401
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.130
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4] qemu-io: add pattern file
 for write command
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
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDMxLjA1LjIwMTkgMTA6MTQsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToNCj4gT24g
RnJpLCBNYXkgMzEsIDIwMTkgYXQgMDY6MjE6MTNBTSArMDAwMCwgRGVuaXMgUGxvdG5pa292IHdy
b3RlOg0KPj4NCj4+DQo+PiBPbiAzMC4wNS4yMDE5IDExOjI2LCBTdGVmYW5vIEdhcnphcmVsbGEg
d3JvdGU6DQo+Pj4gT24gVGh1LCBNYXkgMzAsIDIwMTkgYXQgMTE6MTA6NTVBTSArMDMwMCwgRGVu
aXMgUGxvdG5pa292IHdyb3RlOg0KPj4+PiBUaGUgcGF0Y2ggYWxsb3dzIHRvIHByb3ZpZGUgYSBw
YXR0ZXJuIGZpbGUgZm9yIHdyaXRlDQo+Pj4+IGNvbW1hbmQuIFRoZXJlIHdhcyBubyBzaW1pbGFy
IGFiaWxpdHkgYmVmb3JlLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBEZW5pcyBQbG90bmlr
b3YgPGRwbG90bmlrb3ZAdmlydHVvenpvLmNvbT4NCj4+Pj4gLS0tDQo+Pj4NCj4+PiBIaSBEZW5p
cywNCj4+PiBmb3IgbmV4dCB2ZXJzaW9ucyBJIHN1Z2dlc3QgdG8gZGVzY3JpYmUgaGVyZSwgYWZ0
ZXIgdGhlIC0tLSwgdGhlIGNoYW5nZXMNCj4+PiB3aXRoIHByZXZpb3VzIHZlcnNpb25zLiBJbiB0
aGlzIHdheSB0aGUgcmV2aWV3IHNob3VsZCBiZSBlYXNpZXIuDQo+PiAtLS0NCj4+IFN1cmUNCj4+
Pg0KPj4+PiAgICBxZW11LWlvLWNtZHMuYyB8IDgxICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0tDQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA3NSBpbnNl
cnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvcWVtdS1p
by1jbWRzLmMgYi9xZW11LWlvLWNtZHMuYw0KPj4+PiBpbmRleCAwOTc1MGEyM2NlLi4xYzZhNWU0
ZmFmIDEwMDY0NA0KPj4+PiAtLS0gYS9xZW11LWlvLWNtZHMuYw0KPj4+PiArKysgYi9xZW11LWlv
LWNtZHMuYw0KPj4+PiBAQCAtMjEsNiArMjEsNyBAQA0KPj4+PiAgICAjaW5jbHVkZSAicWVtdS9v
cHRpb24uaCINCj4+Pj4gICAgI2luY2x1ZGUgInFlbXUvdGltZXIuaCINCj4+Pj4gICAgI2luY2x1
ZGUgInFlbXUvY3V0aWxzLmgiDQo+Pj4+ICsjaW5jbHVkZSAic3RyaW5nLmgiDQo+Pj4+ICAgIA0K
Pj4+PiAgICAjZGVmaW5lIENNRF9OT0ZJTEVfT0sgICAweDAxDQo+Pj4+ICAgIA0KPj4+PiBAQCAt
MzQzLDYgKzM0NCw2MSBAQCBzdGF0aWMgdm9pZCAqcWVtdV9pb19hbGxvYyhCbG9ja0JhY2tlbmQg
KmJsaywgc2l6ZV90IGxlbiwgaW50IHBhdHRlcm4pDQo+Pj4+ICAgICAgICByZXR1cm4gYnVmOw0K
Pj4+PiAgICB9DQo+Pj4+ICAgIA0KPj4+PiArc3RhdGljIHZvaWQgKnFlbXVfaW9fYWxsb2NfZnJv
bV9maWxlKEJsb2NrQmFja2VuZCAqYmxrLCBzaXplX3QgbGVuLA0KPj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNoYXIgKmZpbGVfbmFtZSkNCj4+Pj4gK3sNCj4+Pj4g
KyAgICBjaGFyICpidWYsICpidWZfcG9zOw0KPj4+PiArICAgIEZJTEUgKmYgPSBmb3BlbihmaWxl
X25hbWUsICJyIik7DQo+Pj4+ICsgICAgaW50IGw7DQo+Pj4+ICsNCj4+Pj4gKyAgICBpZiAoIWYp
IHsNCj4+Pj4gKyAgICAgICAgcHJpbnRmKCInJXMnOiAlc1xuIiwgZmlsZV9uYW1lLCBzdHJlcnJv
cihlcnJubykpOw0KPj4+PiArICAgICAgICByZXR1cm4gTlVMTDsNCj4+Pj4gKyAgICB9DQo+Pj4+
ICsNCj4+Pj4gKyAgICBpZiAocWVtdWlvX21pc2FsaWduKSB7DQo+Pj4+ICsgICAgICAgIGxlbiAr
PSBNSVNBTElHTl9PRkZTRVQ7DQo+Pj4+ICsgICAgfQ0KPj4+PiArICAgIGJ1ZiA9IGJsa19ibG9j
a2FsaWduKGJsaywgbGVuKTsNCj4+Pj4gKyAgICBtZW1zZXQoYnVmLCAwLCBsZW4pOw0KPj4+PiAr
DQo+Pj4+ICsgICAgYnVmX3BvcyA9IGJ1ZjsNCj4+Pj4gKw0KPj4+PiArICAgIHdoaWxlIChsZW4g
PiAwKSB7DQo+Pj4+ICsgICAgICAgIGwgPSBmcmVhZChidWZfcG9zLCBzaXplb2YoY2hhciksIGxl
biwgZik7DQo+Pj4+ICsNCj4+Pj4gKyAgICAgICAgaWYgKGZlb2YoZikpIHsNCj4+Pj4gKyAgICAg
ICAgICAgIHJld2luZChmKTsNCj4+Pj4gKyAgICAgICAgfQ0KPj4+PiArDQo+Pj4+ICsgICAgICAg
IGlmIChmZXJyb3IoZikpIHsNCj4+Pj4gKyAgICAgICAgICAgIHByaW50ZigiJyVzJzogJXNcbiIs
IGZpbGVfbmFtZSwgc3RyZXJyb3IoZXJybm8pKTsNCj4+Pj4gKyAgICAgICAgICAgIGdvdG8gZXJy
b3I7DQo+Pj4+ICsgICAgICAgIH0NCj4+Pj4gKw0KPj4+PiArICAgICAgICBpZiAobCA9PSAwKSB7
DQo+Pj4+ICsgICAgICAgICAgICBwcmludGYoIiclcycgaXMgZW1wdHlcbiIsIGZpbGVfbmFtZSk7
DQo+Pj4+ICsgICAgICAgICAgICBnb3RvIGVycm9yOw0KPj4+PiArICAgICAgICB9DQo+Pj4NCj4+
PiBDb3VsZCBpdCBoYXBwZW4gdGhhdCB3ZSByZWFkIHNvbWUgYnl0ZXMsIHRoYW4gd2UgcmVhY2hl
ZCB0aGUgRU9GLCBzbyB3ZSBtYWRlDQo+Pj4gdGhlIHJld2luZCgpIGFuZCBmcmVhZCgpIHJldHVy
bnMgMD8NCj4+PiBJZiB0aGF0IGNhbiBoYXBwZW4sIG1heWJlIHdlIHNob3VsZCBjaGFuZ2UgaXQg
aW4gdGhpcyB3YXk6DQo+Pj4NCj4+PiAgICAgICAgICAgaWYgKGwgPT0gMCAmJiBidWZfcG9zID09
IGJ1Zikgew0KPj4+ICAgICAgICAgICAgICAgcHJpbnRmKCInJXMnIGlzIGVtcHR5XG4iLCBmaWxl
X25hbWUpOw0KPj4+ICAgICAgICAgICAgICAgZ290byBlcnJvcjsNCj4+PiAgICAgICAgICAgfQ0K
Pj4gVGhpcyBzaG91bGRuJ3QgaGFwcGVuLiBUbyBnZXQgdGhhdCBzaXR1YXRpb24gd2UgbmVlZCB0
byByZWFkIGV4YWN0bHkgdGhlDQo+PiBmaWxlIGxlbmd0aCAoZnJvbSB0aGUgY3VycmVudCBwb3Np
dGlvbiB0byB0aGUgZW5kKSBvbiB0aGUgZmlyc3Qgc3RlcCwNCj4+IHRoZW4gcmV3aW5kLCByZWFk
IGFnYWluIGFuZCBpbiB0aGF0IGNhc2UgZ2V0IGwgPT0gMCBhbmQgZmVvZiA9PSB0cnVlLg0KPj4g
QnV0IHJlYWRpbmcgdGhlIGV4YWN0IGxlbmd0aCBtZWFucyB0aGF0IHdlIGFza2VkIGZvciB0aGF0
IHNpemUsIHNvIHRoZQ0KPj4gYnVmZmVyIGlzIGZ1bGx5IHBvcHVsYXRlZCwgdGh1cyBsZW4gPT0g
MCBhbmQgd2UgbGVhdmUgdGhlIGxvb3AuDQo+Pg0KPj4gU28sIGwgPT0gMCBpcyBvbmx5IHdoZW4g
d2UgcmVhZCBhbiBlbXB0eSBmaWxlIG9uIHRoZSBmaXJzdCBpdGVyYXRpb24uDQo+Pg0KPiANCj4g
UmlnaHQhDQo+IA0KPj4+PiBAQCAtOTgzLDggKzEwMzksOSBAQCBzdGF0aWMgaW50IHdyaXRlX2Yo
QmxvY2tCYWNrZW5kICpibGssIGludCBhcmdjLCBjaGFyICoqYXJndikNCj4+Pj4gICAgICAgLyog
U29tZSBjb21waWxlcnMgZ2V0IGNvbmZ1c2VkIGFuZCB3YXJuIGlmIHRoaXMgaXMgbm90IGluaXRp
YWxpemVkLiAgKi8NCj4+Pj4gICAgICAgaW50NjRfdCB0b3RhbCA9IDA7DQo+Pj4+ICAgICAgIGlu
dCBwYXR0ZXJuID0gMHhjZDsNCj4+Pj4gKyAgICBjaGFyICpmaWxlX25hbWU7DQo+IA0KPiBJIHRo
aW5rIHdlIHNob3VsZCBpbml0aWFsaXplIGZpbGVfbmFtZSB0byBOVUxMIGhlcmUgdG8gc2lsZW50
IHRoZSBjb21waWxlci4NCj4gSSBhcHBsaWVkIHRoaXMgcGF0Y2ggYW5kIEkgaGFkIHRoaXMgZXJy
b3I6DQo+IC9ob21lL3N0ZWZhbm8vcmVwb3MvcWVtdS9xZW11LWlvLWNtZHMuYzogSW4gZnVuY3Rp
b24g4oCYd3JpdGVfZuKAmToNCj4gL2hvbWUvc3RlZmFuby9yZXBvcy9xZW11L3FlbXUtaW8tY21k
cy5jOjM1MToxNTogZXJyb3I6IOKAmGZpbGVfbmFtZeKAmSBtYXkgYmUgdXNlZCB1bmluaXRpYWxp
emVkIGluIHRoaXMgZnVuY3Rpb24gWy1XZXJyb3I9bWF5YmUtdW5pbml0aWFsaXplZF0NCj4gICAg
ICAgRklMRSAqZiA9IGZvcGVuKGZpbGVfbmFtZSwgInIiKTsNCj4gICAgICAgICAgICAgICAgIF5+
fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiAvaG9tZS9zdGVmYW5vL3JlcG9zL3FlbXUvcWVtdS1pby1j
bWRzLmM6MTA0MjoxMTogbm90ZTog4oCYZmlsZV9uYW1l4oCZIHdhcyBkZWNsYXJlZCBoZXJlDQo+
ICAgICAgIGNoYXIgKmZpbGVfbmFtZTsNCj4gICAgICAgICAgICAgXn5+fn5+fn5+DQo+IGNjMTog
YWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzDQo+IG1ha2U6ICoqKiBbL2hvbWUv
c3RlZmFuby9yZXBvcy9xZW11L3J1bGVzLm1hazo2OTogcWVtdS1pby1jbWRzLm9dIEVycm9yIDEN
Cj4gbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4NCm9rLCB3aWxsIGRv
DQo+IA0KPiBUaGFua3MsDQo+IFN0ZWZhbm8NCj4gDQoNCi0tIA0KQmVzdCwNCkRlbmlzDQo=

