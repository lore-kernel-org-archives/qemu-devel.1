Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3345C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 07:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C0672073F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 07:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NU3tOOu4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0672073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60505 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGINo-0002KI-Pg
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 03:19:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hGIMx-0001xk-83
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 03:19:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hGIMv-0001AQ-QG
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 03:19:03 -0400
Received: from mail-eopbgr10136.outbound.protection.outlook.com
	([40.107.1.136]:36480
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hGIMu-000146-Ja; Tue, 16 Apr 2019 03:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=RR64loIT6mfkIpAQGKVQIhZBdShUYQgV7D3RHS7ruWU=;
	b=NU3tOOu4IRgOZRnPJq6qUGLUlKkeyOmISVKM/7/u/RzivfRevMBMS7LdDcZ/3nhJ/gAPhhylxQjpXGj6dRt0TKIM5lAzfFZtOV9xjNXUnfqr2525aq1/30uvthsdEQP/dvuq4x4HJyeOH3FSiOjeyR/1lohyaKG75LplOAU58ys=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB4619.eurprd08.prod.outlook.com (20.178.85.32) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1792.19; Tue, 16 Apr 2019 07:18:56 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1792.018;
	Tue, 16 Apr 2019 07:18:56 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [PATCH v3 3/7] blkdebug: Add @iotype error option
Thread-Index: AQHU8hl8zmrxYjpod0Cx0161WIOaF6Y+ZReA
Date: Tue, 16 Apr 2019 07:18:56 +0000
Message-ID: <8f273b7c-f13a-897d-0a00-ac89064f0317@virtuozzo.com>
References: <20190413165343.9018-1-mreitz@redhat.com>
	<20190413165343.9018-4-mreitz@redhat.com>
In-Reply-To: <20190413165343.9018-4-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0163.eurprd05.prod.outlook.com
	(2603:10a6:3:f8::11) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190416101853634
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dba82974-6608-4743-64a8-08d6c23bc969
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:DB7PR08MB4619; 
x-ms-traffictypediagnostic: DB7PR08MB4619:
x-microsoft-antispam-prvs: <DB7PR08MB4619DAECA56408965536BEA3C1240@DB7PR08MB4619.eurprd08.prod.outlook.com>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(376002)(366004)(346002)(39850400004)(396003)(199004)(189003)(8676002)(81166006)(2501003)(66066001)(11346002)(52116002)(2616005)(25786009)(102836004)(99286004)(31696002)(81156014)(86362001)(186003)(26005)(446003)(229853002)(31686004)(76176011)(478600001)(8936002)(476003)(68736007)(6486002)(7736002)(316002)(110136005)(386003)(305945005)(6436002)(6506007)(486006)(54906003)(6512007)(14454004)(36756003)(97736004)(105586002)(6246003)(2906002)(256004)(107886003)(4326008)(71190400001)(3846002)(71200400001)(6116002)(106356001)(53936002)(5660300002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB4619;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qdmfHb8YoH0Kj72Opg0E+iQLxoj3VQOVQ17URlgYxd1RN0pI1PeuJKVuyiJWE8S6hp+5RoviPBtw38tvUyASK3shn3GWBDxCnPL8/5dTVD6AC1MA6jM6LKU5tgMkb1sEAEgPvXwmygkjshzGmo7BfmP9WtOwLNtWseDd8PK/s37vysBpqv4wTRJZ9uf00Xf9u6WoMOZmuh5jEpQAGVaN3/x2xTZfGj8kmFFLMv/rJtoj+xNYsd1WNtoqhQSkNHvaCqCjnxV2C1qg2mEfTvDUj3JcVLLexcJn1gDxbkAdK2rpmEmp9qGKHfC4ow9DDxoY47/iJOmYnYNQm2ZooTA1QtRqTor43qMyipqfWKIjFzfKvnfCzDyzLA1UDP1LGUdyNI1S4Gs/ZC0NGWd2bMTBGcS9RXLRQkXI7zvX1HB816o=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <BACFFF859788154DB1FDD412C5885726@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba82974-6608-4743-64a8-08d6c23bc969
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 07:18:56.1813 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB4619
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.136
Subject: Re: [Qemu-devel] [PATCH v3 3/7] blkdebug: Add @iotype error option
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416071856.pkZWODUZukd2peI-owPo2weyRuZbyvHQdQxenzuRcJg@z>

MTMuMDQuMjAxOSAxOTo1MywgTWF4IFJlaXR6IHdyb3RlOg0KPiBUaGlzIG5ldyBlcnJvciBvcHRp
b24gYWxsb3dzIHVzZXJzIG9mIGJsa2RlYnVnIHRvIGluamVjdCBlcnJvcnMgb25seSBvbg0KPiBj
ZXJ0YWluIGtpbmRzIG9mIEkvTyBvcGVyYXRpb25zLiAgVXNlcnMgdXN1YWxseSB3YW50IHRvIG1h
a2UgYSB2ZXJ5DQo+IHNwZWNpZmljIG9wZXJhdGlvbiBmYWlsLCBub3QganVzdCBhbnk7IGJ1dCBy
aWdodCBub3cgdGhleSBzaW1wbHkgaG9wZQ0KPiB0aGF0IHRoZSBldmVudCB0aGF0IHRyaWdnZXJz
IHRoZSBlcnJvciBpbmplY3Rpb24gaXMgZm9sbG93ZWQgdXAgd2l0aA0KPiB0aGF0IHZlcnkgb3Bl
cmF0aW9uLiAgVGhhdCBtYXkgbm90IGJlIHRydWUsIGhvd2V2ZXIsIGJlY2F1c2UgdGhlIGJsb2Nr
DQo+IGxheWVyIGlzIGNoYW5naW5nIChpbmNsdWRpbmcgYmxrZGVidWcsIHdoaWNoIG1heSBpbmNy
ZWFzZSB0aGUgbnVtYmVyIG9mDQo+IHR5cGVzIG9mIEkvTyBvcGVyYXRpb25zIG9uIHdoaWNoIHRv
IGluamVjdCBlcnJvcnMpLg0KPiANCj4gVGhlIG5ldyBvcHRpb24ncyBkZWZhdWx0IGhhcyBiZWVu
IGNob3NlbiB0byBrZWVwIGJhY2t3YXJkcw0KPiBjb21wYXRpYmlsaXR5Lg0KPiANCj4gTm90ZSB0
aGF0IHNpbWlsYXIgdG8gdGhlIGludGVybmFsIHJlcHJlc2VudGF0aW9uLCB3ZSBjb3VsZCBjaG9v
c2UgdG8NCj4gZXhwb3NlIHRoaXMgb3B0aW9uIGFzIGEgbGlzdCBvZiBJL08gdHlwZXMuICBCdXQg
dGhlcmUgaXMgbm8gcHJhY3RpY2FsDQo+IHVzZSBmb3IgdGhpcywgYmVjYXVzZSBhcyBkZXNjcmli
ZWQgYWJvdmUsIHVzZXJzIHVzdWFsbHkga25vdyBleGFjdGx5DQo+IHdoaWNoIGtpbmQgb2Ygb3Bl
cmF0aW9uIHRoZXkgd2FudCB0byBtYWtlIGZhaWwsIHNvIHRoZXJlIGlzIG5vIG5lZWQgdG8NCj4g
c3BlY2lmeSBtdWx0aXBsZSBJL08gdHlwZXMgYXQgb25jZS4gIEluIGFkZGl0aW9uLCBleHBvc2lu
ZyB0aGlzIG9wdGlvbg0KPiBhcyBhIGxpc3Qgd291bGQgcmVxdWlyZSBub24tdHJpdmlhbCBjaGFu
Z2VzIHRvIHFlbXVfb3B0c19hYnNvcmJfcWRpY3QoKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1h
eCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgIHFhcGkvYmxvY2stY29yZS5q
c29uIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKysNCj4gICBibG9jay9ibGtkZWJ1Zy5jICAg
ICB8IDUwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+ICAg
MiBmaWxlcyBjaGFuZ2VkLCA2NyBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL3FhcGkvYmxvY2stY29yZS5qc29uIGIvcWFwaS9ibG9jay1jb3JlLmpzb24N
Cj4gaW5kZXggN2NjYmZmZjlkMC4uNTE0MWU5MTE3MiAxMDA2NDQNCj4gLS0tIGEvcWFwaS9ibG9j
ay1jb3JlLmpzb24NCj4gKysrIGIvcWFwaS9ibG9jay1jb3JlLmpzb24NCj4gQEAgLTMyMzUsNiAr
MzIzNSwyNiBAQA0KPiAgICAgICAgICAgICAgICdsMV9zaHJpbmtfd3JpdGVfdGFibGUnLCAnbDFf
c2hyaW5rX2ZyZWVfbDJfY2x1c3RlcnMnLA0KPiAgICAgICAgICAgICAgICdjb3Jfd3JpdGUnXSB9
DQo+ICAgDQo+ICsjIw0KPiArIyBAQmxrZGVidWdJT1R5cGU6DQo+ICsjDQo+ICsjIEtpbmRzIG9m
IEkvTyB0aGF0IGJsa2RlYnVnIGNhbiBpbmplY3QgZXJyb3JzIGluLg0KPiArIw0KPiArIyBAcmVh
ZDogLmJkcnZfY29fcHJlYWR2KCkNCj4gKyMNCj4gKyMgQHdyaXRlOiAuYmRydl9jb19wd3JpdGV2
KCkNCj4gKyMNCj4gKyMgQHdyaXRlLXplcm9lczogLmJkcnZfY29fcHdyaXRlX3plcm9lcygpDQo+
ICsjDQo+ICsjIEBkaXNjYXJkOiAuYmRydl9jb19wZGlzY2FyZCgpDQo+ICsjDQo+ICsjIEBmbHVz
aDogLmJkcnZfY29fZmx1c2hfdG9fZGlzaygpDQo+ICsjDQo+ICsjIFNpbmNlOiA0LjENCj4gKyMj
DQo+ICt7ICdlbnVtJzogJ0Jsa2RlYnVnSU9UeXBlJywNCj4gKyAgJ2RhdGEnOiBbICdyZWFkJywg
J3dyaXRlJywgJ3dyaXRlLXplcm9lcycsICdkaXNjYXJkJywgJ2ZsdXNoJyBdIH0NCj4gKw0KPiAg
ICMjDQo+ICAgIyBAQmxrZGVidWdJbmplY3RFcnJvck9wdGlvbnM6DQo+ICAgIw0KPiBAQCAtMzI0
NSw2ICszMjY1LDExIEBADQo+ICAgIyBAc3RhdGU6ICAgICAgIHRoZSBzdGF0ZSBpZGVudGlmaWVy
IGJsa2RlYnVnIG5lZWRzIHRvIGJlIGluIHRvDQo+ICAgIyAgICAgICAgICAgICAgIGFjdHVhbGx5
IHRyaWdnZXIgdGhlIGV2ZW50OyBkZWZhdWx0cyB0byAiYW55Ig0KPiAgICMNCj4gKyMgQGlvdHlw
ZTogICAgICB0aGUgdHlwZSBvZiBJL08gb3BlcmF0aW9ucyBvbiB3aGljaCB0aGlzIGVycm9yIHNo
b3VsZA0KPiArIyAgICAgICAgICAgICAgIGJlIGluamVjdGVkOyBkZWZhdWx0cyB0byAiYWxsIHJl
YWQsIHdyaXRlLA0KPiArIyAgICAgICAgICAgICAgIHdyaXRlLXplcm9lcywgZGlzY2FyZCwgYW5k
IGZsdXNoIG9wZXJhdGlvbnMiDQoNCkRvbid0IHlvdSB3YW50IGRlZmF1bHRzIHRvIGFueT8NCg0K
PiArIyAgICAgICAgICAgICAgIChzaW5jZTogNC4xKQ0KPiArIw0KPiAgICMgQGVycm5vOiAgICAg
ICBlcnJvciBpZGVudGlmaWVyIChlcnJubykgdG8gYmUgcmV0dXJuZWQ7IGRlZmF1bHRzIHRvDQo+
ICAgIyAgICAgICAgICAgICAgIEVJTw0KPiAgICMNCj4gQEAgLTMyNjIsNiArMzI4Nyw3IEBADQo+
ICAgeyAnc3RydWN0JzogJ0Jsa2RlYnVnSW5qZWN0RXJyb3JPcHRpb25zJywNCj4gICAgICdkYXRh
JzogeyAnZXZlbnQnOiAnQmxrZGVidWdFdmVudCcsDQo+ICAgICAgICAgICAgICAgJypzdGF0ZSc6
ICdpbnQnLA0KPiArICAgICAgICAgICAgJyppb3R5cGUnOiAnQmxrZGVidWdJT1R5cGUnLA0KPiAg
ICAgICAgICAgICAgICcqZXJybm8nOiAnaW50JywNCj4gICAgICAgICAgICAgICAnKnNlY3Rvcic6
ICdpbnQnLA0KPiAgICAgICAgICAgICAgICcqb25jZSc6ICdib29sJywNCj4gZGlmZiAtLWdpdCBh
L2Jsb2NrL2Jsa2RlYnVnLmMgYi9ibG9jay9ibGtkZWJ1Zy5jDQo+IGluZGV4IGVmZDk0NDE2MjUu
LmNhODRiMTJlMzIgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL2Jsa2RlYnVnLmMNCj4gKysrIGIvYmxv
Y2svYmxrZGVidWcuYw0KPiBAQCAtNzUsNiArNzUsNyBAQCB0eXBlZGVmIHN0cnVjdCBCbGtkZWJ1
Z1J1bGUgew0KPiAgICAgICBpbnQgc3RhdGU7DQo+ICAgICAgIHVuaW9uIHsNCj4gICAgICAgICAg
IHN0cnVjdCB7DQo+ICsgICAgICAgICAgICB1aW50NjRfdCBpb3R5cGVfbWFzazsNCj4gICAgICAg
ICAgICAgICBpbnQgZXJyb3I7DQo+ICAgICAgICAgICAgICAgaW50IGltbWVkaWF0ZWx5Ow0KPiAg
ICAgICAgICAgICAgIGludCBvbmNlOw0KPiBAQCAtOTEsNiArOTIsOSBAQCB0eXBlZGVmIHN0cnVj
dCBCbGtkZWJ1Z1J1bGUgew0KPiAgICAgICBRU0lNUExFUV9FTlRSWShCbGtkZWJ1Z1J1bGUpIGFj
dGl2ZV9uZXh0Ow0KPiAgIH0gQmxrZGVidWdSdWxlOw0KPiAgIA0KPiArUUVNVV9CVUlMRF9CVUdf
TVNHKEJMS0RFQlVHSU9fVFlQRV9fTUFYID4gNjQsDQo+ICsgICAgICAgICAgICAgICAgICAgIkJs
a2RlYnVnSU9UeXBlIG1hc2sgZG9lcyBub3QgZml0IGludG8gYW4gdWludDY0X3QiKTsNCj4gKw0K
PiAgIHN0YXRpYyBRZW11T3B0c0xpc3QgaW5qZWN0X2Vycm9yX29wdHMgPSB7DQo+ICAgICAgIC5u
YW1lID0gImluamVjdC1lcnJvciIsDQo+ICAgICAgIC5oZWFkID0gUVRBSUxRX0hFQURfSU5JVElB
TElaRVIoaW5qZWN0X2Vycm9yX29wdHMuaGVhZCksDQo+IEBAIC0xMDMsNiArMTA3LDEwIEBAIHN0
YXRpYyBRZW11T3B0c0xpc3QgaW5qZWN0X2Vycm9yX29wdHMgPSB7DQo+ICAgICAgICAgICAgICAg
Lm5hbWUgPSAic3RhdGUiLA0KPiAgICAgICAgICAgICAgIC50eXBlID0gUUVNVV9PUFRfTlVNQkVS
LA0KPiAgICAgICAgICAgfSwNCj4gKyAgICAgICAgew0KPiArICAgICAgICAgICAgLm5hbWUgPSAi
aW90eXBlIiwNCj4gKyAgICAgICAgICAgIC50eXBlID0gUUVNVV9PUFRfU1RSSU5HLA0KPiArICAg
ICAgICB9LA0KPiAgICAgICAgICAgew0KPiAgICAgICAgICAgICAgIC5uYW1lID0gImVycm5vIiwN
Cj4gICAgICAgICAgICAgICAudHlwZSA9IFFFTVVfT1BUX05VTUJFUiwNCj4gQEAgLTE2Miw2ICsx
NzAsOCBAQCBzdGF0aWMgaW50IGFkZF9ydWxlKHZvaWQgKm9wYXF1ZSwgUWVtdU9wdHMgKm9wdHMs
IEVycm9yICoqZXJycCkNCj4gICAgICAgaW50IGV2ZW50Ow0KPiAgICAgICBzdHJ1Y3QgQmxrZGVi
dWdSdWxlICpydWxlOw0KPiAgICAgICBpbnQ2NF90IHNlY3RvcjsNCj4gKyAgICBCbGtkZWJ1Z0lP
VHlwZSBpb3R5cGU7DQo+ICsgICAgRXJyb3IgKmxvY2FsX2Vycm9yID0gTlVMTDsNCj4gICANCj4g
ICAgICAgLyogRmluZCB0aGUgcmlnaHQgZXZlbnQgZm9yIHRoZSBydWxlICovDQo+ICAgICAgIGV2
ZW50X25hbWUgPSBxZW11X29wdF9nZXQob3B0cywgImV2ZW50Iik7DQo+IEBAIC0xOTIsNiArMjAy
LDI2IEBAIHN0YXRpYyBpbnQgYWRkX3J1bGUodm9pZCAqb3BhcXVlLCBRZW11T3B0cyAqb3B0cywg
RXJyb3IgKiplcnJwKQ0KPiAgICAgICAgICAgc2VjdG9yID0gcWVtdV9vcHRfZ2V0X251bWJlcihv
cHRzLCAic2VjdG9yIiwgLTEpOw0KPiAgICAgICAgICAgcnVsZS0+b3B0aW9ucy5pbmplY3Qub2Zm
c2V0ID0NCj4gICAgICAgICAgICAgICBzZWN0b3IgPT0gLTEgPyAtMSA6IHNlY3RvciAqIEJEUlZf
U0VDVE9SX1NJWkU7DQo+ICsNCj4gKyAgICAgICAgaW90eXBlID0gcWFwaV9lbnVtX3BhcnNlKCZC
bGtkZWJ1Z0lPVHlwZV9sb29rdXAsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBxZW11X29wdF9nZXQob3B0cywgImlvdHlwZSIpLA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgQkxLREVCVUdJT19UWVBFX19NQVgsICZsb2NhbF9lcnJvcik7DQoNCg0KUHJl
Zml4IEJMS0RFQlVHSU8gc2VlbXMgc3RyYW5nZS4gTG9va3MgbGlrZSBhIGJ1ZyBpbiBxYXBpLCBJ
IHRoaW5rIGl0IHNob3VsZA0KbWFrZSBCTEtERUJVRyBwcmVmaXggaW4gdGhpcyBjYXNlLiBEb24n
dCB5b3Ugd2FudCB1c2UgIidwcmVmaXgnOiAnQkxLREJHJyIgbGlrZQ0KaXQgaXMgZG9uZSBmb3Ig
YmxrZGVidWcgZXZlbnRzPw0KDQo+ICsgICAgICAgIGlmIChsb2NhbF9lcnJvcikgew0KPiArICAg
ICAgICAgICAgZXJyb3JfcHJvcGFnYXRlKGVycnAsIGxvY2FsX2Vycm9yKTsNCj4gKyAgICAgICAg
ICAgIHJldHVybiAtMTsNCj4gKyAgICAgICAgfQ0KPiArICAgICAgICBpZiAoaW90eXBlICE9IEJM
S0RFQlVHSU9fVFlQRV9fTUFYKSB7DQo+ICsgICAgICAgICAgICBydWxlLT5vcHRpb25zLmluamVj
dC5pb3R5cGVfbWFzayA9ICgxdWxsIDw8IGlvdHlwZSk7DQo+ICsgICAgICAgIH0gZWxzZSB7DQo+
ICsgICAgICAgICAgICAvKiBBcHBseSB0aGUgZGVmYXVsdCAqLw0KPiArICAgICAgICAgICAgcnVs
ZS0+b3B0aW9ucy5pbmplY3QuaW90eXBlX21hc2sgPQ0KPiArICAgICAgICAgICAgICAgICgxdWxs
IDw8IEJMS0RFQlVHSU9fVFlQRV9SRUFEKQ0KPiArICAgICAgICAgICAgICAgIHwgKDF1bGwgPDwg
QkxLREVCVUdJT19UWVBFX1dSSVRFKQ0KPiArICAgICAgICAgICAgICAgIHwgKDF1bGwgPDwgQkxL
REVCVUdJT19UWVBFX1dSSVRFX1pFUk9FUykNCj4gKyAgICAgICAgICAgICAgICB8ICgxdWxsIDw8
IEJMS0RFQlVHSU9fVFlQRV9ESVNDQVJEKQ0KPiArICAgICAgICAgICAgICAgIHwgKDF1bGwgPDwg
QkxLREVCVUdJT19UWVBFX0ZMVVNIKTsNCg0KYW5kIGhlcmUgKDF1bGwgPDwgQkxLREVCVUdJT19U
WVBFX19NQVgpIC0gMSA/DQoNClsuLl0NCg0KSXQgaXMgbXkgZmlyc3QgbXkgZmlyc3QgbG9vayBh
dCBibGtkZWJ1ZyBpbnRlcm5hbHMsIGJ1dCBwYXRjaCBzZWVtcyBPSyBmb3IgbWUsDQpzbywgd2l0
aCBvciB3aXRob3V0IG15IHRpbnkgc3VnZ2VzdGlvbnM6DQoNClJldmlld2VkLWJ5OiBWbGFkaW1p
ciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCi0tIA0K
QmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

