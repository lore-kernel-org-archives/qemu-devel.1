Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B674C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 08:42:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A2062081C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 08:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UqyeOcfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2062081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49968 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVu9r-0008RF-IO
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 04:42:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hVu93-00086K-OJ
	for qemu-devel@nongnu.org; Wed, 29 May 2019 04:41:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hVu92-0005Y5-C6
	for qemu-devel@nongnu.org; Wed, 29 May 2019 04:41:13 -0400
Received: from mail-vi1eur04on0716.outbound.protection.outlook.com
	([2a01:111:f400:fe0e::716]:27909
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1hVu91-0005WO-J2; Wed, 29 May 2019 04:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=hQb5VHJGhuiDk6F7Fl2FpiHPGspa/QcUj/M0eUTp3oM=;
	b=UqyeOcfvYjKsi/nOPAfaCLZvC7RTBIMS637vuI7C7ws9bnXKDRpYylhc+NhI0AeOqUJq25mq5eM3aGOEAngByW/xqMOj3ZCgbqc7KZ/JBHHEEdigt7lQ6tvPvlaGuxVZzeqR3xRln0XZrPeDKW0IuJTZvnz0GiDIkfc3/GJgXOg=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
	AM0PR08MB3634.eurprd08.prod.outlook.com (20.177.43.214) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.20; Wed, 29 May 2019 08:41:07 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
	([fe80::1deb:8cf1:f7d2:16cf]) by
	AM0PR08MB3745.eurprd08.prod.outlook.com
	([fe80::1deb:8cf1:f7d2:16cf%6]) with mapi id 15.20.1922.021;
	Wed, 29 May 2019 08:41:07 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com"
	<mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v0] qemu-io: add pattern file for write command
Thread-Index: AQHVFfYTAIKvmXEIvU2axMarUNUm4qaByJWA
Date: Wed, 29 May 2019 08:41:07 +0000
Message-ID: <cdb8e961-f974-0d77-c792-f9df1b4fa166@virtuozzo.com>
References: <20190529064824.32064-1-dplotnikov@virtuozzo.com>
	<4442baee-ac68-bf06-60a2-257fd52f4592@virtuozzo.com>
In-Reply-To: <4442baee-ac68-bf06-60a2-257fd52f4592@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0193.eurprd05.prod.outlook.com
	(2603:10a6:3:f9::17) To AM0PR08MB3745.eurprd08.prod.outlook.com
	(2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7279cff-289f-4609-9ae1-08d6e4116441
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:AM0PR08MB3634; 
x-ms-traffictypediagnostic: AM0PR08MB3634:
x-microsoft-antispam-prvs: <AM0PR08MB36340B9C6EC84A397120272CCF1F0@AM0PR08MB3634.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(366004)(136003)(346002)(39850400004)(376002)(199004)(189003)(256004)(66066001)(52116002)(386003)(6506007)(8936002)(476003)(7736002)(2906002)(31696002)(66946007)(73956011)(66446008)(64756008)(66476007)(76176011)(66556008)(71200400001)(316002)(53546011)(2616005)(11346002)(486006)(446003)(110136005)(54906003)(186003)(68736007)(71190400001)(3846002)(2501003)(8676002)(99286004)(305945005)(81156014)(26005)(53936002)(102836004)(6436002)(6486002)(14454004)(6246003)(25786009)(229853002)(31686004)(5660300002)(86362001)(478600001)(4326008)(6512007)(81166006)(107886003)(2201001)(6116002)(36756003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3634;
	H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qn26QUwcG0Yga4VWBu8V/4EoGWXIskEt0bmvLtYTNxvADQtGC8YMhloJWT1cEWcvLDEuvzpQ010R++lFIyOfrJ4jUjAnT+vzdiaQxtJyNaL7keVnl7XlgM+d7M+bDLw2XLTG+u4Wnec/fJZdPmU5nROldCvoPFc+ZS3Ctun7D75LNrQP/fZ7SFzrHtBOcLBI+zUZ+80eBORBZ/5b8y1vxLBuD/+QEIMprS81s1VDYsoUFIXsgbJPDbDGG3Z5A63USLYiDJ/p+woFc350wTzdXa5fN5blZjH1nLWx9Nijy4IdjiWdocp9zgiHgrAiLyFn6MFBuw4f9OOqErPX7FgcNw/hGWm37AYd1P+MsAHOEO2IMpMbgWQGTA3gvqqe3NeYsTVIn4lo2oNQc9BZgCRIkWugRq8fhPsLeaKIgSnuVmA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE9FA4CB6300ED46AAA4437C8E74144C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7279cff-289f-4609-9ae1-08d6e4116441
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 08:41:07.1209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dplotnikov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3634
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0e::716
Subject: Re: [Qemu-devel] [PATCH v0] qemu-io: add pattern file for write
 command
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI5LjA1LjIwMTkgMTE6MTEsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3Jv
dGU6DQo+IDI5LjA1LjIwMTkgOTo0OCwgRGVuaXMgUGxvdG5pa292IHdyb3RlOg0KPj4gVGhlIHBh
dGNoIGFsbG93cyB0byBwcm92aWRlIGEgcGF0dGVybiBmaWxlIGZvciB3cml0ZQ0KPj4gY29tbWFu
ZC4gVGhlcmUgd2FzIG5vIHNpbWlsYXIgYWJpbGl0eSBiZWZvcmUuDQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogRGVuaXMgUGxvdG5pa292IDxkcGxvdG5pa292QHZpcnR1b3p6by5jb20+DQo+PiAtLS0N
Cj4+ICAgIHFlbXUtaW8tY21kcy5jIHwgNTggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0NCj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA1NCBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9xZW11LWlvLWNtZHMuYyBi
L3FlbXUtaW8tY21kcy5jDQo+PiBpbmRleCAwOTc1MGEyM2NlLi5iOTM5NTUxMTZmIDEwMDY0NA0K
Pj4gLS0tIGEvcWVtdS1pby1jbWRzLmMNCj4+ICsrKyBiL3FlbXUtaW8tY21kcy5jDQo+PiBAQCAt
MjEsNiArMjEsNyBAQA0KPj4gICAgI2luY2x1ZGUgInFlbXUvb3B0aW9uLmgiDQo+PiAgICAjaW5j
bHVkZSAicWVtdS90aW1lci5oIg0KPj4gICAgI2luY2x1ZGUgInFlbXUvY3V0aWxzLmgiDQo+PiAr
I2luY2x1ZGUgInN0cmluZy5oIg0KPj4gICAgDQo+PiAgICAjZGVmaW5lIENNRF9OT0ZJTEVfT0sg
ICAweDAxDQo+PiAgICANCj4+IEBAIC0zNDMsNiArMzQ0LDM1IEBAIHN0YXRpYyB2b2lkICpxZW11
X2lvX2FsbG9jKEJsb2NrQmFja2VuZCAqYmxrLCBzaXplX3QgbGVuLCBpbnQgcGF0dGVybikNCj4+
ICAgICAgICByZXR1cm4gYnVmOw0KPj4gICAgfQ0KPj4gICAgDQo+PiArc3RhdGljIHZvaWQgKnFl
bXVfaW9fYWxsb2NfZnJvbV9maWxlKEJsb2NrQmFja2VuZCAqYmxrLCBzaXplX3QgbGVuLA0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjaGFyICpmaWxlX25hbWUpDQo+
PiArew0KPj4gKyAgICB2b2lkICpidWY7DQo+PiArICAgIEZJTEUgKmYgPSBmb3BlbihmaWxlX25h
bWUsICJyIik7DQo+PiArDQo+PiArICAgIGlmICghZikgew0KPj4gKyAgICAgICAgcHJpbnRmKCJj
YW5ub3Qgb3BlbiBmaWxlICclcydcbiIsIGZpbGVfbmFtZSk7DQo+IA0KPiBJIHNlZSwgcHJpbnRm
IGZybyBlcnJvcnMgaXMgcHJlZXhpc3RpbmcgaW4gcWVtdS1pby1jbWRzLmMsIGJ1dCBlcnJvcl9y
ZXBvcnQgaXMgdXNlZCBoZXJlIHRvbywNCj4gSSB0aGluayBpdCdzIGJldHRlciB0byB1c2UgZXJy
b3JfcmVwb3J0Lg0Kd3JpdGVfZiBkb24ndCB1c2UgZXJyb3JfcmVwb3J0LiBJIHRoaW5rIGl0J3Mg
d29ydGggdG8gZ28gd2l0aCBwcmludGYgaW4gDQp0aGlzIGNhc2UgLSBub3QgdG8gbWl4IHVwIHBy
aW50Zi1zIHdpdGggZXJyb3JfcmVwb3J0DQo+IA0KPj4gKyAgICAgICAgcmV0dXJuIE5VTEw7DQo+
PiArICAgIH0NCj4+ICsNCj4+ICsgICAgaWYgKHFlbXVpb19taXNhbGlnbikgew0KPj4gKyAgICAg
ICAgbGVuICs9IE1JU0FMSUdOX09GRlNFVDsNCj4+ICsgICAgfQ0KPj4gKyAgICBidWYgPSBibGtf
YmxvY2thbGlnbihibGssIGxlbik7DQo+PiArICAgIG1lbXNldChidWYsIDAsIGxlbik7DQo+PiAr
DQo+PiArICAgIGlmICghZnJlYWQoYnVmLCBzaXplb2YoY2hhciksIGxlbiwgZikpIHsNCj4+ICsg
ICAgICAgIHByaW50ZigiZmlsZSAnJXMnIGlzIGVtcHR5XG4iLCBmaWxlX25hbWUpOw0KPj4gKyAg
ICAgICAgZnJlZShidWYpOw0KPj4gKyAgICAgICAgcmV0dXJuIE5VTEw7DQo+PiArICAgIH0NCj4+
ICsNCj4+ICsgICAgaWYgKHFlbXVpb19taXNhbGlnbikgew0KPj4gKyAgICAgICAgYnVmICs9IE1J
U0FMSUdOX09GRlNFVDsNCj4gDQo+IGhtbSwgcHJlZXhpc3RpbmcgaW4gcWVtdV9pb19hbGxvYyBh
bmQgcWVtdV9pb19mcmVlLCBidXQgSWYgSSByZW1lbWJlciBjb3JyZWN0bHksIHBvaW50ZXIgYXJp
dGhtZXRpYw0KPiBvbiB2b2lkKiBpcyBub3QgZ3VhcmFudGVlZCB0byB3b3JrIGFzIGV4cGVjdGVk
IGhlcmUuLg0Kd2lsbCBjaGFuZ2UgdG8gZ19tYWxsb2MvZ19mcmVlDQo+IA0KPj4gKyAgICB9DQo+
PiArICAgIHJldHVybiBidWY7DQo+PiArfQ0KPj4gKw0KPj4gICAgc3RhdGljIHZvaWQgcWVtdV9p
b19mcmVlKHZvaWQgKnApDQo+PiAgICB7DQo+PiAgICAgICAgaWYgKHFlbXVpb19taXNhbGlnbikg
ew0KPj4gQEAgLTk2NSw3ICs5OTUsNyBAQCBzdGF0aWMgY29uc3QgY21kaW5mb190IHdyaXRlX2Nt
ZCA9IHsNCj4+ICAgICAgICAucGVybSAgICAgICA9IEJMS19QRVJNX1dSSVRFLA0KPj4gICAgICAg
IC5hcmdtaW4gICAgID0gMiwNCj4+ICAgICAgICAuYXJnbWF4ICAgICA9IC0xLA0KPj4gLSAgICAu
YXJncyAgICAgICA9ICJbLWJjQ2ZucXV6XSBbLVAgcGF0dGVybl0gb2ZmIGxlbiIsDQo+PiArICAg
IC5hcmdzICAgICAgID0gIlstYmNDZm5xdXpdIFstUCBwYXR0ZXJuIHwgLXMgc291cmNlX2ZpbGVd
IG9mZiBsZW4iLA0KPj4gICAgICAgIC5vbmVsaW5lICAgID0gIndyaXRlcyBhIG51bWJlciBvZiBi
eXRlcyBhdCBhIHNwZWNpZmllZCBvZmZzZXQiLA0KPj4gICAgICAgIC5oZWxwICAgICAgID0gd3Jp
dGVfaGVscCwNCj4+ICAgIH07DQo+PiBAQCAtOTc0LDcgKzEwMDQsNyBAQCBzdGF0aWMgaW50IHdy
aXRlX2YoQmxvY2tCYWNrZW5kICpibGssIGludCBhcmdjLCBjaGFyICoqYXJndikNCj4+ICAgIHsN
Cj4+ICAgICAgICBzdHJ1Y3QgdGltZXZhbCB0MSwgdDI7DQo+PiAgICAgICAgYm9vbCBDZmxhZyA9
IGZhbHNlLCBxZmxhZyA9IGZhbHNlLCBiZmxhZyA9IGZhbHNlOw0KPj4gLSAgICBib29sIFBmbGFn
ID0gZmFsc2UsIHpmbGFnID0gZmFsc2UsIGNmbGFnID0gZmFsc2U7DQo+PiArICAgIGJvb2wgUGZs
YWcgPSBmYWxzZSwgemZsYWcgPSBmYWxzZSwgY2ZsYWcgPSBmYWxzZSwgc2ZsYWcgPSBmYWxzZTsN
Cj4+ICAgICAgICBpbnQgZmxhZ3MgPSAwOw0KPj4gICAgICAgIGludCBjLCBjbnQsIHJldDsNCj4+
ICAgICAgICBjaGFyICpidWYgPSBOVUxMOw0KPj4gQEAgLTk4Myw4ICsxMDEzLDkgQEAgc3RhdGlj
IGludCB3cml0ZV9mKEJsb2NrQmFja2VuZCAqYmxrLCBpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQo+
PiAgICAgICAgLyogU29tZSBjb21waWxlcnMgZ2V0IGNvbmZ1c2VkIGFuZCB3YXJuIGlmIHRoaXMg
aXMgbm90IGluaXRpYWxpemVkLiAgKi8NCj4+ICAgICAgICBpbnQ2NF90IHRvdGFsID0gMDsNCj4+
ICAgICAgICBpbnQgcGF0dGVybiA9IDB4Y2Q7DQo+PiArICAgIGNoYXIgZmlsZV9uYW1lWzI1NV0g
PSB7IDAgfTsNCj4+ICAgIA0KPj4gLSAgICB3aGlsZSAoKGMgPSBnZXRvcHQoYXJnYywgYXJndiwg
ImJjQ2ZucFA6cXV6IikpICE9IC0xKSB7DQo+PiArICAgIHdoaWxlICgoYyA9IGdldG9wdChhcmdj
LCBhcmd2LCAiYmNDZm5wUDpxdXpzOiIpKSAhPSAtMSkgew0KPj4gICAgICAgICAgICBzd2l0Y2gg
KGMpIHsNCj4+ICAgICAgICAgICAgY2FzZSAnYic6DQo+PiAgICAgICAgICAgICAgICBiZmxhZyA9
IHRydWU7DQo+PiBAQCAtMTAyMCw2ICsxMDUxLDEwIEBAIHN0YXRpYyBpbnQgd3JpdGVfZihCbG9j
a0JhY2tlbmQgKmJsaywgaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPj4gICAgICAgICAgICBjYXNl
ICd6JzoNCj4+ICAgICAgICAgICAgICAgIHpmbGFnID0gdHJ1ZTsNCj4+ICAgICAgICAgICAgICAg
IGJyZWFrOw0KPj4gKyAgICAgICAgY2FzZSAncyc6DQo+PiArICAgICAgICAgICAgc2ZsYWcgPSB0
cnVlOw0KPj4gKyAgICAgICAgICAgIHN0cm5jcHkoZmlsZV9uYW1lLCBvcHRhcmcsIHNpemVvZihm
aWxlX25hbWUpIC0gMSk7DQo+IA0KPiBNYXliZSwgZ19zdHJkdXAgYW5kIGRvbid0IGNhcmUgYWJv
dXQgZmlsZV9uYW1lIGxlbmd0aD8NCnllYWgsIHRoYXQgd291bGQgYmUgYmV0dGVyDQo+IA0KPj4g
KyAgICAgICAgICAgIGJyZWFrOw0KPj4gICAgICAgICAgICBkZWZhdWx0Og0KPj4gICAgICAgICAg
ICAgICAgcWVtdWlvX2NvbW1hbmRfdXNhZ2UoJndyaXRlX2NtZCk7DQo+PiAgICAgICAgICAgICAg
ICByZXR1cm4gLUVJTlZBTDsNCj4+IEBAIC0xMDU2LDYgKzEwOTEsMTQgQEAgc3RhdGljIGludCB3
cml0ZV9mKEJsb2NrQmFja2VuZCAqYmxrLCBpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQo+PiAgICAg
ICAgICAgIHJldHVybiAtRUlOVkFMOw0KPj4gICAgICAgIH0NCj4+ICAgIA0KPj4gKyAgICBpZiAo
c2ZsYWcgJiYgUGZsYWcpIHsNCj4+ICsgICAgICAgIHByaW50ZigiLXMgYW5kIC1QIGNhbm5vdCBi
ZSBzcGVjaWZpZWQgYXQgdGhlIHNhbWUgdGltZVxuIik7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsg
ICAgaWYgKHpmbGFnICYmIFBmbGFnKSB7DQo+PiArICAgICAgICBwcmludGYoIi16IGFuZCAtUCBj
YW5ub3QgYmUgc3BlY2lmaWVkIGF0IHRoZSBzYW1lIHRpbWVcbiIpOw0KPj4gKyAgICB9DQp5ZXMs
IHRoaXMgaXMgYW4gZXJyb3IuIEhlcmUgc2hvdWxkIGJlIHpmbGFnICYmIHNmbGFnDQo+IA0KPiBz
dHJhbmdlLCB0aGF0IHlvdSBhZGQgdGhpcyBsYXN0IGNoZWNrLi4gSSBzZWUgaXQgaW4gbWFzdGVy
IGJyYW5jaCBhbHJlYWR5Lg0KPiANCj4+ICsNCj4+ICAgICAgICBvZmZzZXQgPSBjdnRudW0oYXJn
dltvcHRpbmRdKTsNCj4+ICAgICAgICBpZiAob2Zmc2V0IDwgMCkgew0KPj4gICAgICAgICAgICBw
cmludF9jdnRudW1fZXJyKG9mZnNldCwgYXJndltvcHRpbmRdKTsNCj4+IEBAIC0xMDg4LDcgKzEx
MzEsMTQgQEAgc3RhdGljIGludCB3cml0ZV9mKEJsb2NrQmFja2VuZCAqYmxrLCBpbnQgYXJnYywg
Y2hhciAqKmFyZ3YpDQo+PiAgICAgICAgfQ0KPj4gICAgDQo+PiAgICAgICAgaWYgKCF6ZmxhZykg
ew0KPj4gLSAgICAgICAgYnVmID0gcWVtdV9pb19hbGxvYyhibGssIGNvdW50LCBwYXR0ZXJuKTsN
Cj4+ICsgICAgICAgIGlmIChzZmxhZykgew0KPj4gKyAgICAgICAgICAgIGJ1ZiA9IHFlbXVfaW9f
YWxsb2NfZnJvbV9maWxlKGJsaywgY291bnQsIGZpbGVfbmFtZSk7DQo+PiArICAgICAgICAgICAg
aWYgKCFidWYpIHsNCj4+ICsgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+PiArICAg
ICAgICAgICAgfQ0KPj4gKyAgICAgICAgfSBlbHNlIHsNCj4+ICsgICAgICAgICAgICBidWYgPSBx
ZW11X2lvX2FsbG9jKGJsaywgY291bnQsIHBhdHRlcm4pOw0KPj4gKyAgICAgICAgfQ0KPj4gICAg
ICAgIH0NCj4+ICAgIA0KPj4gICAgICAgIGdldHRpbWVvZmRheSgmdDEsIE5VTEwpOw0KPj4NCj4g
DQo+IA0KDQotLSANCkJlc3QsDQpEZW5pcw0K

