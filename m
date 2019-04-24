Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBB1C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 12:15:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F9F21773
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 12:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HlFy45qc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F9F21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40703 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJGoC-0003YM-Bl
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 08:15:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hJGmP-0002OZ-RI
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:13:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hJGbi-0007hX-Uw
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:02:36 -0400
Received: from mail-eopbgr10128.outbound.protection.outlook.com
	([40.107.1.128]:8167
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hJGbi-0007fn-B4; Wed, 24 Apr 2019 08:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=PHlExE5H6A6KX4rwjN1gkQrDjCXrbeB//YBi90ooK+0=;
	b=HlFy45qclYi1skwJvgToa/vyvAEWOvDTy1y5TTXyWrQjPyHPdndksj3c0THxoBhLf/zctWkxCx08LnpAmH3leHFAH+xe8DdDyKjQQDBm2ZFmtydotEhbpXcGj54P9wCWQRFhmGAfiMUou0UkWUOa8hMcOua59KLKMrrngkCX51Y=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3625.eurprd08.prod.outlook.com (20.177.120.143) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.12; Wed, 24 Apr 2019 12:02:29 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1813.017;
	Wed, 24 Apr 2019 12:02:29 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Thomas Huth <thuth@redhat.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
	<berrange@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH 5/6] tests: Run the iotests during "make
	check" again
Thread-Index: AQHU+oqFAxLdlY5cFkaIToVHXiphY6ZLIYqAgAADGICAABFzAA==
Date: Wed, 24 Apr 2019 12:02:29 +0000
Message-ID: <f8040ada-cb84-d669-3493-0d2da89e6b0b@virtuozzo.com>
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-6-thuth@redhat.com>
	<20190424104855.GE31388@redhat.com>
	<d9137693-7727-5f2c-04f3-b1eafd70f056@redhat.com>
In-Reply-To: <d9137693-7727-5f2c-04f3-b1eafd70f056@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0021.eurprd02.prod.outlook.com
	(2603:10a6:3:8c::31) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190424150225975
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7923004-31f3-448b-5bdd-08d6c8acb964
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3625; 
x-ms-traffictypediagnostic: DB7PR08MB3625:
x-microsoft-antispam-prvs: <DB7PR08MB3625A7D5947F55128E4F3290C13C0@DB7PR08MB3625.eurprd08.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(136003)(376002)(39850400004)(346002)(396003)(199004)(189003)(110136005)(14454004)(66556008)(68736007)(8676002)(36756003)(2616005)(316002)(478600001)(54906003)(8936002)(66066001)(31686004)(81156014)(66946007)(73956011)(66476007)(64756008)(476003)(2906002)(6116002)(7736002)(99286004)(52116002)(86362001)(81166006)(76176011)(3846002)(25786009)(305945005)(31696002)(5660300002)(26005)(6506007)(66446008)(102836004)(7416002)(186003)(93886005)(386003)(71200400001)(229853002)(71190400001)(97736004)(11346002)(486006)(446003)(53936002)(256004)(4326008)(6512007)(6436002)(6246003)(6486002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3625;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IoPcHQFeBkcoUD9NgAPK5/IjSYvIDKGjqa+urdPHj78MArjy9FcyOTyOv/u14xYRiU+2iI6BHgUkuQUwMgjcHqeG38YOvn2eg/hzWS1cJvEAP+/XuhESZ8uQQZg8QqtIjcn3tjjkq0QC2Xfl/Ly6M+HbAGDI2ywnNo7CcBRRntYdsj1/BqKURTYVK+ziYlCbdom9H468Ef67G3GK3sW4QTmUHwF6RePFYTOYfW+qYugz3fRf7HBp7XQ8y0T1u0kw30v26X+K4RCmQ12gSpbYcqITK+aZcgg1p8ShWboQHB3L4kQ9GIP/JyxhS60YVH2MWBtgEK1n6UGZ83myBjx44WKwQ9NTCjS4nzjzUPy1AOvfESP7cx7unOq+Y9FX7GiW6DQf02huY6WWUIh4fUuV8qvr+yEvCBitW4o5ZfySYTs=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <3A41D49096F71742B885CE567A202122@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7923004-31f3-448b-5bdd-08d6c8acb964
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 12:02:29.3408 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3625
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.128
Subject: Re: [Qemu-devel] [PATCH 5/6] tests: Run the iotests during "make
 check" again
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	Ed Maste <emaste@freebsd.org>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	=?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Max Reitz <mreitz@redhat.com>,
	=?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424120229.DsWpwyU8kD9LwIpNWSA5kOM2IKrlBsBAVbM7HBDFVS4@z>

MjQuMDQuMjAxOSAxMzo1OSwgVGhvbWFzIEh1dGggd3JvdGU6DQo+IE9uIDI0LzA0LzIwMTkgMTIu
NDgsIERhbmllbCBQLiBCZXJyYW5nw6kgd3JvdGU6DQo+PiBPbiBXZWQsIEFwciAyNCwgMjAxOSBh
dCAxMjozNzo0NlBNICswMjAwLCBUaG9tYXMgSHV0aCB3cm90ZToNCj4+PiBQZW9wbGUgb2Z0ZW4g
Zm9yZ2V0IHRvIHJ1biB0aGUgaW90ZXN0cyBiZWZvcmUgc3VibWl0dGluZyBwYXRjaGVzIG9yDQo+
Pj4gcHVsbCByZXF1ZXN0cyAtIHRoaXMgaXMgbGlrZWx5IGR1ZSB0byB0aGUgZmFjdCB0aGF0IHdl
IGRvIG5vdCBydW4gdGhlDQo+Pj4gdGVzdHMgZHVyaW5nIG91ciBtYW5kYXRvcnkgIm1ha2UgY2hl
Y2siIHRlc3RzIHlldC4gTm93IHRoYXQgd2UndmUgZ290DQo+Pj4gYSBuZXcgImNpIiBncm91cCBv
ZiBpb3Rlc3RzIHRoYXQgc2hvdWxkIGJlIGZpbmUgdG8gcnVuIGluIGV2ZXJ5IGVudmlyb24tDQo+
Pj4gbWVudCwgaXQgc2hvdWxkIGJlIE9LIHRvIGVuYWJsZSB0aGUgaW90ZXN0cyBkdXJpbmcgIm1h
a2UgY2hlY2siIGFnYWluLg0KPj4+IFRodXMgd2Ugbm93IHJ1biB0aGUgImNpIiB0ZXN0cyBieSBk
ZWZhdWx0IGZyb20gdGhlIHFlbXUtaW90ZXN0cy1xdWljay5zaA0KPj4+IHNjcmlwdCwgYW5kIG9u
bHkgdXNlIHRoZSBmb3JtZXIgInF1aWNrIiBncm91cCAodGhhdCBjb250YWlucyBzb21lIHRlc3Rz
DQo+Pj4gdGhhdCBhcmUgZmFpbGluZyBpbiBzb21lIGVudmlyb25tZW50cykgd2hlbiB0aGUgdXNl
ciBkZWNpZGVkIHRvIHJ1bg0KPj4+ICJtYWtlIGNoZWNrIFNQRUVEPXRob3JvdWdoIiBvciBzb21l
dGhpbmcgc2ltaWxhci4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBIdXRoIDx0aHV0
aEByZWRoYXQuY29tPg0KPj4+IC0tLQ0KPj4+ICAgdGVzdHMvTWFrZWZpbGUuaW5jbHVkZSAgICAg
IHwgIDIgKy0NCj4+PiAgIHRlc3RzL3FlbXUtaW90ZXN0cy1xdWljay5zaCB8IDE3ICsrKysrKysr
KysrKysrKystDQo+Pj4gICAyIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+Pg0KPj4+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMtcXVpY2su
c2ggYi90ZXN0cy9xZW11LWlvdGVzdHMtcXVpY2suc2gNCj4+PiBpbmRleCAwZTU1NGJiOTcyLi40
MTZiM2ZjNDhiIDEwMDc1NQ0KPj4+IC0tLSBhL3Rlc3RzL3FlbXUtaW90ZXN0cy1xdWljay5zaA0K
Pj4+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy1xdWljay5zaA0KPj4NCj4+IHMvLXF1aWNrLy8g
IHBlcmhhcHMsIHNpbmNlIGl0IG5vIGxvbmdlciBvbmx5IHJ1bnMgdGhlICJxdWljayIgdGVzdHMu
DQo+Pg0KPj4+IEBAIC0xLDggKzEsMjMgQEANCj4+PiAgICMhL2Jpbi9zaA0KPj4+ICAgDQo+Pj4g
KyMgSG9ub3IgdGhlIFNQRUVEIGVudmlyb25tZW50IHZhcmlhYmxlLCBqdXN0IGxpa2Ugd2UgZG8g
aXQgZm9yIHRoZSBxdGVzdHMuDQo+Pj4gKyMgVGhlIGRlZmF1bHQgaXMgdG8gcnVuIGFsbCB0ZXN0
cyB0aGF0IHN0aWxsIHdvcmsgZmluZSBpbiBhIENJIGVudmlyb25tZW50cywNCj4+PiArIyBidXQg
aWYgdGhlIHVzZXIgc2V0IFNQRUVEPXNsb3cgb3IgU1BFRUQ9dGhvcm91Z2gsIHdlIGFsc28gcnVu
IGFsbCBvdGhlcg0KPj4+ICsjIHRlc3RzIHRoYXQgYXJlIHN0aWxsIG1hcmtlZCBhcyAicXVpY2si
DQo+Pj4gK2lmIFsgIiRTUEVFRCIgPSAic2xvdyIgLW8gIiRTUEVFRCIgPSAidGhvcm91Z2giIF07
IHRoZW4NCj4+PiArICAgIGdyb3VwPXF1aWNrDQo+Pg0KPj4gV2hlbiB1c2VyIGFza3MgZm9yICJz
bG93IiB0ZXN0cyB3ZSBydW4gdGhlICJxdWljayIgdGVzdHMsIHdoaWNoDQo+PiBwcmVzdW1hYmx5
IGltcGxpZXMuLi4NCj4+DQo+Pj4gK2Vsc2UNCj4+PiArICAgIGdyb3VwPWNpDQo+Pg0KPj4gLi4u
ImNpIiBpcyBxdWlja2VyIHRoYW4gdGhlICJxdWljayIgIHRlc3RzICENCj4+DQo+PiBDb25mdXNl
ZCA/IFdlIGNlcnRhaW5seSB0cnkgdG8gZW5zdXJlIHRoYXQgeW91IHdpbGwgYmUgOi0pDQo+IA0K
PiAuLi4gYW5kIHRoZXJlIGlzIGFsc28gdGVzdHMvY2hlY2stYmxvY2suc2ggKHdoaWNoIGlzIG5v
dCB1c2VkIGJ5ICJtYWtlDQo+IGNoZWNrLWJsb2NrIiwgYnkgdGhlIHdheSwgYnV0IHN0aWxsIHRh
bGtzIGFib3V0ICJtYWtlIGNoZWNrLWJsb2NrIiksDQo+IHdoaWNoIGlzIGV2ZW4gc2xvd2VyIHRo
YW4gdGhlICJjaSIgYW5kICJxdWljayIgZ3JvdXAuLi4NCj4gDQo+IEkgZ3Vlc3MgdGhhdCBjb3Vs
ZCBiZSBjbGVhbmVkIHVwLCB0b28gKHdoeSBkbyB3ZSBuZWVkIHR3byBzY3JpcHRzPykgLi4uDQo+
IGp1c3Qgbm90IHN1cmUgaG93IHRoZSBmaW5hbCByZXN1bHQgc2hvdWxkIGxvb2sgbGlrZSBhbmQg
aWYgaXQgc2hvdWxkIGJlDQo+IHBhcnQgb2YgdGhpcyBwYXRjaCBzZXJpZXMgb3IgcmF0aGVyIHNv
bWV0aGluZyBzZXBhcmF0ZS4gTWF4LCBLZXZpbiwgd2hhdA0KPiBkbyB5b3UgdGhpbms/DQo+IA0K
PiBNYXliZSB3ZSBzaG91bGQgbWVyZ2UgdGhlIHR3byBzY3JpcHRzLCBhbmQgZGVwZW5kaW5nIG9u
IHRoZSBTUEVFRA0KPiB2YXJpYWJsZSwgd2UgcnVuOg0KPiANCj4gICBxdWljayA9PiAiY2kiIGdy
b3VwDQo+ICAgdGhvcm91Z2ggPT4gInF1aWNrIiBncm91cA0KPiAgIHNsb3cgPT4gb2xkIGJlaGF2
aW91ciBvZiB0aGUgY2hlY2stYmxvY2suc2ggc2NyaXB0DQoNCk1heSBiZSwgaW5zdGVhZCBvZiBT
UEVFRCwgaW50cm9kdWNlIEdST1VQIHZhcmlhYmxlPyBUbyBtYWtlIGl0IHBsYWluDQpjaSAtPiBj
aQ0KcXVpY2sgLT4gcXVpY2sNCm5vdGhpbmcgLT4gZGVmYXVsdCBvbGQgYmVoYXZpb3INCj8NCg0K
PiANCj4gPw0KPiANCj4gICBUaG9tYXMNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFk
aW1pcg0K

