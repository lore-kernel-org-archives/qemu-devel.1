Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0504C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 12:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3CDF20811
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 12:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZDkWjD8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3CDF20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41049 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJH8f-0003lJ-QY
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 08:36:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hJH75-0002UA-9v
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:35:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hJGrQ-0001RO-Uf
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:18:50 -0400
Received: from mail-eopbgr140094.outbound.protection.outlook.com
	([40.107.14.94]:34547
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hJGrQ-0001Nm-3a; Wed, 24 Apr 2019 08:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=8+O+vDWjvyN5dhAuB2T8WuSwCown8N1Ixhchx6xa610=;
	b=ZDkWjD8/HZVD6sqarFQiV1cgFAFnLVbpa0aA8g2PFMuqJ8lIuURxO9rEXg1n+pWF1ax/4tblzu7T7ctAe73J81ZnJ33O8oIZTNiD0+b69t3Jf0LOaY1CSCLaWhfqRdDwWSaE7yfEOY+TdUot7jNgUq6Jj/0S2STT+WMLa6emfj8=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3468.eurprd08.prod.outlook.com (20.176.238.153) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.12; Wed, 24 Apr 2019 12:18:43 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1813.017;
	Wed, 24 Apr 2019 12:18:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH 5/6] tests: Run the iotests during "make
	check" again
Thread-Index: AQHU+oqFAxLdlY5cFkaIToVHXiphY6ZLIYqAgAADGICAAEO9AP//0NiAgAABZwA=
Date: Wed, 24 Apr 2019 12:18:43 +0000
Message-ID: <afeaa77a-3480-237b-e71c-70559a7529f4@virtuozzo.com>
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-6-thuth@redhat.com>
	<20190424104855.GE31388@redhat.com>
	<d9137693-7727-5f2c-04f3-b1eafd70f056@redhat.com>
	<f8040ada-cb84-d669-3493-0d2da89e6b0b@virtuozzo.com>
	<20190424121339.GG31388@redhat.com>
In-Reply-To: <20190424121339.GG31388@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0153.eurprd05.prod.outlook.com
	(2603:10a6:7:28::40) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190424151840289
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8db28a87-5e23-40f0-56ce-08d6c8aefdca
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3468; 
x-ms-traffictypediagnostic: DB7PR08MB3468:
x-microsoft-antispam-prvs: <DB7PR08MB3468AAA9854AEFB28E6824A8C13C0@DB7PR08MB3468.eurprd08.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(376002)(346002)(366004)(39850400004)(136003)(199004)(189003)(6512007)(14454004)(5660300002)(52116002)(73956011)(66476007)(478600001)(86362001)(4326008)(66946007)(66066001)(66556008)(64756008)(66446008)(256004)(6246003)(97736004)(31696002)(53936002)(71200400001)(71190400001)(31686004)(476003)(102836004)(93886005)(11346002)(76176011)(6506007)(8676002)(6436002)(3846002)(2616005)(6116002)(386003)(26005)(486006)(186003)(7736002)(25786009)(446003)(305945005)(36756003)(6486002)(8936002)(2906002)(7416002)(99286004)(6916009)(81166006)(81156014)(68736007)(229853002)(316002)(54906003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3468;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M3B2wuZ6I2F7a1kZ2i91Q0uovnUHNUFgwiR3KrwQlbMAD3Q3/lYZffDFN/T0Jlrmv1SdP23vgL0Jaovr4cjhrGjiTcIngS9zwpd3NDeYFNy01lTJuKIG9ZIe4l1Kf4QEjl+WLIH5vwGCnqgSFo5+MBn/xqKYKjkl1oVQRWja+wHoFjrxr0nXgRCh35Bw7bvOkuDxBHszBWDqtkTUJZUaC+0/T9N9+svT0bxEDUByGUty7X0U/5Ab3jf1ZaoKnpyU8wmjZtHUafNYwtTZKVrF42PJWh/9fslDJVXfYXej0N1yg8qoJn1CJIV+nsF2X89bqBn20pknWO94sPzHjMFhRoqxYMnqHgNqjsIVedS0nu2wTs3XjmCL+To4cqVdgs4YcCqA8KoedHm0VaEL9U9G2xvPO4Npp5ZQYa+JXGzNnvY=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <2D0ECEF3838A02458B7C1C7152901C29@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db28a87-5e23-40f0-56ce-08d6c8aefdca
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 12:18:43.0416 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3468
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.94
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
	Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	=?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Max Reitz <mreitz@redhat.com>,
	=?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424121843.tzZCO7VsJTfmroExJc2AWbxrgEK_lUTCtBpjBMnoS4I@z>

MjQuMDQuMjAxOSAxNToxMywgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4gT24gV2VkLCBB
cHIgMjQsIDIwMTkgYXQgMTI6MDI6MjlQTSArMDAwMCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2
c2tpeSB3cm90ZToNCj4+IDI0LjA0LjIwMTkgMTM6NTksIFRob21hcyBIdXRoIHdyb3RlOg0KPj4+
IE9uIDI0LzA0LzIwMTkgMTIuNDgsIERhbmllbCBQLiBCZXJyYW5nw6kgd3JvdGU6DQo+Pj4+IE9u
IFdlZCwgQXByIDI0LCAyMDE5IGF0IDEyOjM3OjQ2UE0gKzAyMDAsIFRob21hcyBIdXRoIHdyb3Rl
Og0KPj4+Pj4gUGVvcGxlIG9mdGVuIGZvcmdldCB0byBydW4gdGhlIGlvdGVzdHMgYmVmb3JlIHN1
Ym1pdHRpbmcgcGF0Y2hlcyBvcg0KPj4+Pj4gcHVsbCByZXF1ZXN0cyAtIHRoaXMgaXMgbGlrZWx5
IGR1ZSB0byB0aGUgZmFjdCB0aGF0IHdlIGRvIG5vdCBydW4gdGhlDQo+Pj4+PiB0ZXN0cyBkdXJp
bmcgb3VyIG1hbmRhdG9yeSAibWFrZSBjaGVjayIgdGVzdHMgeWV0LiBOb3cgdGhhdCB3ZSd2ZSBn
b3QNCj4+Pj4+IGEgbmV3ICJjaSIgZ3JvdXAgb2YgaW90ZXN0cyB0aGF0IHNob3VsZCBiZSBmaW5l
IHRvIHJ1biBpbiBldmVyeSBlbnZpcm9uLQ0KPj4+Pj4gbWVudCwgaXQgc2hvdWxkIGJlIE9LIHRv
IGVuYWJsZSB0aGUgaW90ZXN0cyBkdXJpbmcgIm1ha2UgY2hlY2siIGFnYWluLg0KPj4+Pj4gVGh1
cyB3ZSBub3cgcnVuIHRoZSAiY2kiIHRlc3RzIGJ5IGRlZmF1bHQgZnJvbSB0aGUgcWVtdS1pb3Rl
c3RzLXF1aWNrLnNoDQo+Pj4+PiBzY3JpcHQsIGFuZCBvbmx5IHVzZSB0aGUgZm9ybWVyICJxdWlj
ayIgZ3JvdXAgKHRoYXQgY29udGFpbnMgc29tZSB0ZXN0cw0KPj4+Pj4gdGhhdCBhcmUgZmFpbGlu
ZyBpbiBzb21lIGVudmlyb25tZW50cykgd2hlbiB0aGUgdXNlciBkZWNpZGVkIHRvIHJ1bg0KPj4+
Pj4gIm1ha2UgY2hlY2sgU1BFRUQ9dGhvcm91Z2giIG9yIHNvbWV0aGluZyBzaW1pbGFyLg0KPj4+
Pj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBIdXRoIDx0aHV0aEByZWRoYXQuY29tPg0K
Pj4+Pj4gLS0tDQo+Pj4+PiAgICB0ZXN0cy9NYWtlZmlsZS5pbmNsdWRlICAgICAgfCAgMiArLQ0K
Pj4+Pj4gICAgdGVzdHMvcWVtdS1pb3Rlc3RzLXF1aWNrLnNoIHwgMTcgKysrKysrKysrKysrKysr
Ky0NCj4+Pj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4+Pj4NCj4+Pj4+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMtcXVpY2su
c2ggYi90ZXN0cy9xZW11LWlvdGVzdHMtcXVpY2suc2gNCj4+Pj4+IGluZGV4IDBlNTU0YmI5NzIu
LjQxNmIzZmM0OGIgMTAwNzU1DQo+Pj4+PiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMtcXVpY2su
c2gNCj4+Pj4+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy1xdWljay5zaA0KPj4+Pg0KPj4+PiBz
Ly1xdWljay8vICBwZXJoYXBzLCBzaW5jZSBpdCBubyBsb25nZXIgb25seSBydW5zIHRoZSAicXVp
Y2siIHRlc3RzLg0KPj4+Pg0KPj4+Pj4gQEAgLTEsOCArMSwyMyBAQA0KPj4+Pj4gICAgIyEvYmlu
L3NoDQo+Pj4+PiAgICANCj4+Pj4+ICsjIEhvbm9yIHRoZSBTUEVFRCBlbnZpcm9ubWVudCB2YXJp
YWJsZSwganVzdCBsaWtlIHdlIGRvIGl0IGZvciB0aGUgcXRlc3RzLg0KPj4+Pj4gKyMgVGhlIGRl
ZmF1bHQgaXMgdG8gcnVuIGFsbCB0ZXN0cyB0aGF0IHN0aWxsIHdvcmsgZmluZSBpbiBhIENJIGVu
dmlyb25tZW50cywNCj4+Pj4+ICsjIGJ1dCBpZiB0aGUgdXNlciBzZXQgU1BFRUQ9c2xvdyBvciBT
UEVFRD10aG9yb3VnaCwgd2UgYWxzbyBydW4gYWxsIG90aGVyDQo+Pj4+PiArIyB0ZXN0cyB0aGF0
IGFyZSBzdGlsbCBtYXJrZWQgYXMgInF1aWNrIg0KPj4+Pj4gK2lmIFsgIiRTUEVFRCIgPSAic2xv
dyIgLW8gIiRTUEVFRCIgPSAidGhvcm91Z2giIF07IHRoZW4NCj4+Pj4+ICsgICAgZ3JvdXA9cXVp
Y2sNCj4+Pj4NCj4+Pj4gV2hlbiB1c2VyIGFza3MgZm9yICJzbG93IiB0ZXN0cyB3ZSBydW4gdGhl
ICJxdWljayIgdGVzdHMsIHdoaWNoDQo+Pj4+IHByZXN1bWFibHkgaW1wbGllcy4uLg0KPj4+Pg0K
Pj4+Pj4gK2Vsc2UNCj4+Pj4+ICsgICAgZ3JvdXA9Y2kNCj4+Pj4NCj4+Pj4gLi4uImNpIiBpcyBx
dWlja2VyIHRoYW4gdGhlICJxdWljayIgIHRlc3RzICENCj4+Pj4NCj4+Pj4gQ29uZnVzZWQgPyBX
ZSBjZXJ0YWlubHkgdHJ5IHRvIGVuc3VyZSB0aGF0IHlvdSB3aWxsIGJlIDotKQ0KPj4+DQo+Pj4g
Li4uIGFuZCB0aGVyZSBpcyBhbHNvIHRlc3RzL2NoZWNrLWJsb2NrLnNoICh3aGljaCBpcyBub3Qg
dXNlZCBieSAibWFrZQ0KPj4+IGNoZWNrLWJsb2NrIiwgYnkgdGhlIHdheSwgYnV0IHN0aWxsIHRh
bGtzIGFib3V0ICJtYWtlIGNoZWNrLWJsb2NrIiksDQo+Pj4gd2hpY2ggaXMgZXZlbiBzbG93ZXIg
dGhhbiB0aGUgImNpIiBhbmQgInF1aWNrIiBncm91cC4uLg0KPj4+DQo+Pj4gSSBndWVzcyB0aGF0
IGNvdWxkIGJlIGNsZWFuZWQgdXAsIHRvbyAod2h5IGRvIHdlIG5lZWQgdHdvIHNjcmlwdHM/KSAu
Li4NCj4+PiBqdXN0IG5vdCBzdXJlIGhvdyB0aGUgZmluYWwgcmVzdWx0IHNob3VsZCBsb29rIGxp
a2UgYW5kIGlmIGl0IHNob3VsZCBiZQ0KPj4+IHBhcnQgb2YgdGhpcyBwYXRjaCBzZXJpZXMgb3Ig
cmF0aGVyIHNvbWV0aGluZyBzZXBhcmF0ZS4gTWF4LCBLZXZpbiwgd2hhdA0KPj4+IGRvIHlvdSB0
aGluaz8NCj4+Pg0KPj4+IE1heWJlIHdlIHNob3VsZCBtZXJnZSB0aGUgdHdvIHNjcmlwdHMsIGFu
ZCBkZXBlbmRpbmcgb24gdGhlIFNQRUVEDQo+Pj4gdmFyaWFibGUsIHdlIHJ1bjoNCj4+Pg0KPj4+
ICAgIHF1aWNrID0+ICJjaSIgZ3JvdXANCj4+PiAgICB0aG9yb3VnaCA9PiAicXVpY2siIGdyb3Vw
DQo+Pj4gICAgc2xvdyA9PiBvbGQgYmVoYXZpb3VyIG9mIHRoZSBjaGVjay1ibG9jay5zaCBzY3Jp
cHQNCj4+DQo+PiBNYXkgYmUsIGluc3RlYWQgb2YgU1BFRUQsIGludHJvZHVjZSBHUk9VUCB2YXJp
YWJsZT8gVG8gbWFrZSBpdCBwbGFpbg0KPiANCj4gIiRTUEVFRCIgaXMgc29tZXRoaW5nIHVzZWQv
ZGVmaW5lZCBieSB0aGUgZ3Rlc3RlciBoYXJuZXNzLCBzbyBvdGhlciBiaXRzDQo+IHJ1biBieSAi
bWFrZSBjaGVjayIgYWxyZWFkeSBob25vdXIgdGhhdCwgaGVuY2UgaXQgaXMgZGVzaXJhYmxlIGZy
byB0aGUNCj4gaW90ZXN0cyB0b2RvIHRoZSBzYW1lLg0KPiANCg0KT0ssIHNvcnJ5LCBkaWRuJ3Qg
a25vdy4NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

