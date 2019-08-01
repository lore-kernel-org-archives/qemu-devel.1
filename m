Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF40C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 17:27:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD2520838
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 17:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AQ9oGM1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD2520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htErm-0006Tk-5T
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 13:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44999)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htEpf-0005uW-Ja
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 13:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htEpd-0004Xr-W0
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 13:25:39 -0400
Received: from mail-eopbgr10097.outbound.protection.outlook.com
 ([40.107.1.97]:12326 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1htEpc-0004UM-9x; Thu, 01 Aug 2019 13:25:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9vQPKsy5JPXjWJtnfVV+x1nMDM7GD2lIeXeGzCHZDpoX9xLA11/BNgEZqodfyvnKvvUsPYCEpZkylSiZ5fGvTqKgKBL8ELM6fSwArvClGsMn1PyeOHPQcZv/AYLiDcmZziTRK5vPS1KnaCmkRdLgwiLKMI6B3NYcmoZ5J0n+2J6XKEpirwm3m5ddVBcKVY0eQEOdPMzpRdlRDL0xrYs4Ls8uvOWBdOk6G0oGtb7RD6u7ddVDwWFmvVLONeRMBJu4KBE1WwieLABADUJAlNcGQXkup/L/84EiBOHc84t/nR1oYdBXsS3+OqauC70QUu6sk60caBw3T4v+EPr0qyUsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMRs7MjrUfqBwomP5+v3+rK9JMW8hDH69jxTEjqlQ5E=;
 b=jzs5s8tpc080MpEa/ArVfprFWaYoUadBVY0UX/LUyileOU5c9uNOq5k8BBo3JVXCZ34ubI4eLuPPGhUUvQvTxK6QZZYratSH7nfkMM70tXIIvH11ZLUYUFI9PkLkUdW2y1aINF3IyvAYnY92oz+Njar05UJeofJGiXtLVRn3f9W3Zq8Kyso3Gf4TvdnpbFIC5z3QJ5azF5dfK2YIUm/NUbY2OKhGC3SzAZcWNf6AQKVJnGyVqWu0yg8Tn4QhVozHklGYP2CLACLaxYtt/GSpU2kRM4PRXOLYQBRzKCysXDqYYsSPBTpFq1qGgI78kC/5bzO2KQY2a0ZUT0lAoXsaMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMRs7MjrUfqBwomP5+v3+rK9JMW8hDH69jxTEjqlQ5E=;
 b=AQ9oGM1sBrrp464T+/PVsbhHDrVlXz2qwYrK020ObXdB9MS3MX2WjsWJUPbimWtzLCbyzJ34fNhGXGtD6hJ8XEB7DufIn3H4e3Vlll+3nxmKjBOs8Cl7aj4ynu/Jtx4bEJ6UmrLnycDYzyLqRlc4VdLTPasaL5++46lg23w3PQ0=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5243.eurprd08.prod.outlook.com (20.179.15.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Thu, 1 Aug 2019 17:25:27 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 17:25:27 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH for-4.1 2/2] iotests: Test backup job with two guest
 writes
Thread-Index: AQHVSHuSmXijrz1GlEejh1OLI2A9XqbmdDaAgAARuACAAAVQgA==
Date: Thu, 1 Aug 2019 17:25:27 +0000
Message-ID: <274d65f2-1b42-8585-3c6f-1ee711c2bb09@virtuozzo.com>
References: <20190801151235.8434-1-mreitz@redhat.com>
 <20190801151235.8434-3-mreitz@redhat.com>
 <68653483-e7d2-154a-75c6-2dfef235d33d@virtuozzo.com>
 <738d7105-f91e-76ad-c2e6-cd5b32b846ef@redhat.com>
In-Reply-To: <738d7105-f91e-76ad-c2e6-cd5b32b846ef@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0401CA0071.eurprd04.prod.outlook.com
 (2603:10a6:3:19::39) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190801202524984
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c445b030-26ec-4e24-9ec8-08d716a53e77
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5243; 
x-ms-traffictypediagnostic: DB8PR08MB5243:
x-microsoft-antispam-prvs: <DB8PR08MB52435E28D14497A2CFA338B5C1DE0@DB8PR08MB5243.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(366004)(39850400004)(136003)(346002)(189003)(199004)(305945005)(7736002)(54906003)(2501003)(76176011)(31686004)(99286004)(386003)(86362001)(31696002)(316002)(66066001)(6246003)(4326008)(52116002)(256004)(14444005)(186003)(53546011)(6512007)(6486002)(102836004)(6436002)(53936002)(229853002)(110136005)(11346002)(68736007)(478600001)(476003)(66476007)(64756008)(2616005)(66556008)(66446008)(66946007)(26005)(81156014)(6506007)(8676002)(486006)(446003)(8936002)(81166006)(25786009)(2906002)(3846002)(71190400001)(6116002)(71200400001)(36756003)(14454004)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5243;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3yT23wHTlMUHDA9kjf/Ox28xZB7Ubr1e3wKjiG8Y/FkVlj28OoVMAdp/h/g0jgIbtSO2/uKthRRRCC47Db2u8KSDYmMt6y73HJKhSBGUq+wgDrNz/pOEc3FJnFqII8bMCXu1/wXoDTJo/6l5A+V8Atb3rsf+Wxt/rN0gDR78ykWq0enNRQBBX1esEz7RTzPfkmkZzWkHQg2B06p/XGi35T1E/b/IdljgUHiFKv9e4g0CxfobH7txRDzRIDZD6i7EJ67K01OcTH0GCz0U4JzukICsVdGrWUdawYTmcBYOm0LG9Bv585Dja1TNczA3+fc6ENuPn98b37XDVs4SdHLuqXNH9NQxi1/cvKRNKEnjJ+kr7oQY2BJrPwMROpy2dpQHMIZhx2Iju+3IS3fYyhqRDaiemg28rbextWcODplK7wE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8FF064CC87057419D0E0A64DBE1AC94@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c445b030-26ec-4e24-9ec8-08d716a53e77
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 17:25:27.1657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5243
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.97
Subject: Re: [Qemu-devel] [PATCH for-4.1 2/2] iotests: Test backup job with
 two guest writes
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMDguMjAxOSAyMDowNiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwMS4wOC4xOSAxODowMywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDAxLjA4LjIwMTkgMTg6MTIs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBQZXJmb3JtIHR3byBndWVzdCB3cml0ZXMgdG8gbm90IHll
dCBiYWNrZWQgdXAgYXJlYXMgb2YgYW4gaW1hZ2UsIHdoZXJlDQo+Pj4gdGhlIGZvcm1lciB0b3Vj
aGVzIGFuIGlubmVyIGFyZWEgb2YgdGhlIGxhdHRlci4NCj4+Pg0KPj4+IEJlZm9yZSBIRUFEXiwg
Y29weSBvZmZsb2FkaW5nIGJyb2tlIHRoaXMgaW4gdHdvIHdheXM6DQo+Pj4gKDEpIFRoZSBvdXRw
dXQgZGlmZmVycyBmcm9tIHRoZSByZWZlcmVuY2Ugb3V0cHV0ICh3aGF0IHRoZSBzb3VyY2Ugd2Fz
DQo+Pj4gICAgICAgYmVmb3JlIHRoZSBndWVzdCB3cml0ZXMpLg0KPj4+ICgyKSBCdXQgeW91IHdp
bGwgbm90IHNlZSB0aGF0IGluIHRoZSBmYWlsaW5nIG91dHB1dCwgYmVjYXVzZSB0aGUgam9iDQo+
Pj4gICAgICAgb2Zmc2V0IGlzIHJlcG9ydGVkIGFzIGJlaW5nIGdyZWF0ZXIgdGhhbiB0aGUgam9i
IGxlbmd0aC4gIFRoaXMgaXMNCj4+PiAgICAgICBiZWNhdXNlIG9uZSBjbHVzdGVyIGlzIGNvcGll
ZCB0d2ljZSwgYW5kIHRodXMgYWNjb3VudGVkIGZvciB0d2ljZSwNCj4+PiAgICAgICBidXQgb2Yg
Y291cnNlIHRoZSBqb2IgbGVuZ3RoIGRvZXMgbm90IGluY3JlYXNlLg0KPj4+DQo+Pj4gU2lnbmVk
LW9mZi1ieTogTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCj4+PiAtLS0NCj4+PiAgICB0
ZXN0cy9xZW11LWlvdGVzdHMvMDU2ICAgICB8IDM0ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4+PiAgICB0ZXN0cy9xZW11LWlvdGVzdHMvMDU2Lm91dCB8ICA0ICsrLS0NCj4+
PiAgICAyIGZpbGVzIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzA1NiBiL3Rlc3RzL3FlbXUt
aW90ZXN0cy8wNTYNCj4+PiBpbmRleCBmNDBmYzExYTA5Li5kNzE5ODUwN2Y1IDEwMDc1NQ0KPj4+
IC0tLSBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8wNTYNCj4+PiArKysgYi90ZXN0cy9xZW11LWlvdGVz
dHMvMDU2DQo+Pj4gQEAgLTEzMyw2ICsxMzMsNyBAQCBjbGFzcyBCYWNrdXBUZXN0KGlvdGVzdHMu
UU1QVGVzdENhc2UpOg0KPj4+ICAgICAgICAgICAgc2VsZi52bSA9IGlvdGVzdHMuVk0oKQ0KPj4+
ICAgICAgICAgICAgc2VsZi50ZXN0X2ltZyA9IGltZ19jcmVhdGUoJ3Rlc3QnKQ0KPj4+ICAgICAg
ICAgICAgc2VsZi5kZXN0X2ltZyA9IGltZ19jcmVhdGUoJ2Rlc3QnKQ0KPj4+ICsgICAgICAgIHNl
bGYucmVmX2ltZyA9IGltZ19jcmVhdGUoJ3JlZicpDQo+Pj4gICAgICAgICAgICBzZWxmLnZtLmFk
ZF9kcml2ZShzZWxmLnRlc3RfaW1nKQ0KPj4+ICAgICAgICAgICAgc2VsZi52bS5sYXVuY2goKQ0K
Pj4+ICAgIA0KPj4+IEBAIC0xNDAsNiArMTQxLDcgQEAgY2xhc3MgQmFja3VwVGVzdChpb3Rlc3Rz
LlFNUFRlc3RDYXNlKToNCj4+PiAgICAgICAgICAgIHNlbGYudm0uc2h1dGRvd24oKQ0KPj4+ICAg
ICAgICAgICAgdHJ5X3JlbW92ZShzZWxmLnRlc3RfaW1nKQ0KPj4+ICAgICAgICAgICAgdHJ5X3Jl
bW92ZShzZWxmLmRlc3RfaW1nKQ0KPj4+ICsgICAgICAgIHRyeV9yZW1vdmUoc2VsZi5yZWZfaW1n
KQ0KPj4+ICAgIA0KPj4+ICAgICAgICBkZWYgaG1wX2lvX3dyaXRlcyhzZWxmLCBkcml2ZSwgcGF0
dGVybnMpOg0KPj4+ICAgICAgICAgICAgZm9yIHBhdHRlcm4gaW4gcGF0dGVybnM6DQo+Pj4gQEAg
LTE3Nyw2ICsxNzksMzggQEAgY2xhc3MgQmFja3VwVGVzdChpb3Rlc3RzLlFNUFRlc3RDYXNlKToN
Cj4+PiAgICAgICAgICAgICAgICBzZWxmLmFzc2VydF9xbXAoZXZlbnQsICdkYXRhL2Vycm9yJywg
cWVycm9yKQ0KPj4+ICAgICAgICAgICAgICAgIHJldHVybiBGYWxzZQ0KPj4+ICAgIA0KPj4+ICsg
ICAgZGVmIHRlc3Rfb3ZlcmxhcHBpbmdfd3JpdGVzKHNlbGYpOg0KPj4+ICsgICAgICAgICMgV3Jp
dGUgc29tZXRoaW5nIHRvIGJhY2sgdXANCj4+PiArICAgICAgICBzZWxmLmhtcF9pb193cml0ZXMo
J2RyaXZlMCcsIFsoJzQyJywgJzBNJywgJzJNJyldKQ0KPj4+ICsNCj4+PiArICAgICAgICAjIENy
ZWF0ZSBhIHJlZmVyZW5jZSBiYWNrdXANCj4+PiArICAgICAgICBzZWxmLnFtcF9iYWNrdXBfYW5k
X3dhaXQoZGV2aWNlPSdkcml2ZTAnLCBmb3JtYXQ9aW90ZXN0cy5pbWdmbXQsDQo+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN5bmM9J2Z1bGwnLCB0YXJnZXQ9c2VsZi5yZWZf
aW1nKQ0KPj4+ICsNCj4+PiArICAgICAgICAjIE5vdyB0byB0aGUgdGVzdCBiYWNrdXA6IFdlIHNp
bXVsYXRlIHRoZSBmb2xsb3dpbmcgZ3Vlc3QNCj4+PiArICAgICAgICAjIHdyaXRlczoNCj4+PiAr
ICAgICAgICAjICgxKSBbMU0gKyA2NGssIDFNICsgMTI4ayk6IEFmdGVyd2FyZHMsIGV2ZXJ5dGhp
bmcgaW4gdGhhdA0KPj4+ICsgICAgICAgICMgICAgIGFyZWEgc2hvdWxkIGJlIGluIHRoZSB0YXJn
ZXQgaW1hZ2UsIGFuZCB3ZSBtdXN0IG5vdCBjb3B5DQo+Pj4gKyAgICAgICAgIyAgICAgaXQgYWdh
aW4gKGJlY2F1c2UgdGhlIHNvdXJjZSBpbWFnZSBoYXMgY2hhbmdlZCBub3cpDQo+Pj4gKyAgICAg
ICAgIyAgICAgKDY0ayBpcyB0aGUgam9iJ3MgY2x1c3RlciBzaXplKQ0KPj4+ICsgICAgICAgICMg
KDIpIFsxTSwgMk0pOiBUaGUgYmFja3VwIGpvYiBtdXN0IG5vdCBnZXQgb3ZlcmVhZ2VyLiAgSXQN
Cj4+PiArICAgICAgICAjICAgICBtdXN0IGNvcHkgWzFNLCAxTSArIDY0aykgYW5kIFsxTSArIDEy
OGssIDJNKSBzZXBhcmF0ZWx5LA0KPj4+ICsgICAgICAgICMgICAgIGJ1dCBub3QgdGhlIGFyZWEg
aW4gYmV0d2Vlbi4NCj4+PiArDQo+Pj4gKyAgICAgICAgc2VsZi5xbXBfYmFja3VwKGRldmljZT0n
ZHJpdmUwJywgZm9ybWF0PWlvdGVzdHMuaW1nZm10LCBzeW5jPSdmdWxsJywNCj4+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgdGFyZ2V0PXNlbGYuZGVzdF9pbWcsIHNwZWVkPTEpDQo+Pj4gKw0K
Pj4+ICsgICAgICAgIHNlbGYuaG1wX2lvX3dyaXRlcygnZHJpdmUwJywgWygnMjMnLCAnJWlrJyAl
ICgxMDI0ICsgNjQpLCAnNjRrJyksDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKCc2NicsICcxTScsICcxTScpXSkNCj4+PiArDQo+Pj4gKyAgICAgICAgIyBMZXQg
dGhlIGpvYiBjb21wbGV0ZQ0KPj4+ICsgICAgICAgIHJlcyA9IHNlbGYudm0ucW1wKCdibG9jay1q
b2Itc2V0LXNwZWVkJywgZGV2aWNlPSdkcml2ZTAnLCBzcGVlZD0wKQ0KPj4+ICsgICAgICAgIHNl
bGYuYXNzZXJ0X3FtcChyZXMsICdyZXR1cm4nLCB7fSkNCj4+PiArICAgICAgICBzZWxmLnFtcF9i
YWNrdXBfd2FpdCgnZHJpdmUwJykNCj4+PiArDQo+Pj4gKyAgICAgICAgc2VsZi5hc3NlcnRUcnVl
KGlvdGVzdHMuY29tcGFyZV9pbWFnZXMoc2VsZi5yZWZfaW1nLCBzZWxmLmRlc3RfaW1nKSwNCj4+
PiArICAgICAgICAgICAgICAgICAgICAgICAgJ3RhcmdldCBpbWFnZSBkb2VzIG5vdCBtYXRjaCBy
ZWZlcmVuY2UgaW1hZ2UnKQ0KPj4+ICsNCj4+PiAgICAgICAgZGVmIHRlc3RfZGlzbWlzc19mYWxz
ZShzZWxmKToNCj4+PiAgICAgICAgICAgIHJlcyA9IHNlbGYudm0ucW1wKCdxdWVyeS1ibG9jay1q
b2JzJykNCj4+PiAgICAgICAgICAgIHNlbGYuYXNzZXJ0X3FtcChyZXMsICdyZXR1cm4nLCBbXSkN
Cj4+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzA1Ni5vdXQgYi90ZXN0cy9xZW11
LWlvdGVzdHMvMDU2Lm91dA0KPj4+IGluZGV4IGRhZTQwNGUyNzguLjM2Mzc2YmVkODcgMTAwNjQ0
DQo+Pj4gLS0tIGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzA1Ni5vdXQNCj4+PiArKysgYi90ZXN0cy9x
ZW11LWlvdGVzdHMvMDU2Lm91dA0KPj4+IEBAIC0xLDUgKzEsNSBAQA0KPj4+IC0uLi4uLi4uLi4N
Cj4+PiArLi4uLi4uLi4uLg0KPj4+ICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+PiAtUmFuIDkgdGVzdHMN
Cj4+PiArUmFuIDEwIHRlc3RzDQo+Pj4gICAgDQo+Pj4gICAgT0sNCj4+Pg0KPj4NCj4+IEZhaWxl
ZCBmb3IgbWU6DQo+PiAtLi4uLi4uLi4uLg0KPj4gK3FlbXUtaW1nOiBDb3VsZCBub3Qgb3BlbiAn
L3dvcmsvc3JjL3FlbXUvbWFzdGVyL3Rlc3RzL3FlbXUtaW90ZXN0cy9zY3JhdGNoL2Rlc3QucWNv
dzInOiBGYWlsZWQgdG8gZ2V0IHNoYXJlZCAid3JpdGUiIGxvY2sNCj4+ICtJcyBhbm90aGVyIHBy
b2Nlc3MgdXNpbmcgdGhlIGltYWdlIFsvd29yay9zcmMvcWVtdS9tYXN0ZXIvdGVzdHMvcWVtdS1p
b3Rlc3RzL3NjcmF0Y2gvZGVzdC5xY293Ml0/DQo+PiArLi4uLi4uRi4uLg0KPj4gKz09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0NCj4+ICtGQUlMOiB0ZXN0X292ZXJsYXBwaW5nX3dyaXRlcyAoX19tYWluX18uQmFja3Vw
VGVzdCkNCj4+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiArVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxs
IGxhc3QpOg0KPj4gKyAgRmlsZSAiMDU2IiwgbGluZSAyMTIsIGluIHRlc3Rfb3ZlcmxhcHBpbmdf
d3JpdGVzDQo+PiArICAgICd0YXJnZXQgaW1hZ2UgZG9lcyBub3QgbWF0Y2ggcmVmZXJlbmNlIGlt
YWdlJykNCj4+ICtBc3NlcnRpb25FcnJvcjogRmFsc2UgaXMgbm90IHRydWUgOiB0YXJnZXQgaW1h
Z2UgZG9lcyBub3QgbWF0Y2ggcmVmZXJlbmNlIGltYWdlDQo+PiArDQo+PiAgICAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+PiAgICBSYW4gMTAgdGVzdHMNCj4+DQo+PiAtT0sNCj4+ICtGQUlMRUQgKGZhaWx1cmVz
PTEpDQo+IA0KPiBIbS4gIEkgaG9wZWQgc2VlaW5nIEJMT0NLX0pPQl9DT01QTEVURUQgd291bGQg
YmUgZW5vdWdoLg0KDQpUaGUgcHJvYmxlbSBpcyBoaWdoZXI6ICJGYWlsZWQgdG8gZ2V0IHNoYXJl
ZCAid3JpdGUiIGxvY2siLiBCZWNhdXNlIG9mIHRoaXMgaW90ZXN0cy5jb21wYXJlX2ltYWdlcw0K
Y2FuJ3Qgd29yay4gU28sIGJlY2F1c2Ugb2YgbG9ja2luZywgd2UgbmVlZCB0byBzaHV0ZG93biBx
ZW11IGJlZm9yZSBzdGFydGluZyBxZW11LWltZy4NCkFuZCBpdCdzIGRvbmUgc28gaW4gdGVzdF9j
b21wbGV0ZV90b3AoKSAoSSBqdXN0IGxvb2tlZCBhdCBpdCBhcyBpdCdzIHRoZSBvbmx5IG90aGVy
IHVzZXIgb2YgY29tcGFyZV9pbWFnZXMNCmluIDA1NikNCg0KPiANCj4+IFNvLCB3aXRoIGFwcGxp
ZWQNCj4+DQo+PiBAQCAtMjA3LDYgKzIwNyw3IEBAIGNsYXNzIEJhY2t1cFRlc3QoaW90ZXN0cy5R
TVBUZXN0Q2FzZSk6DQo+PiAgICAgICAgICAgIHJlcyA9IHNlbGYudm0ucW1wKCdibG9jay1qb2It
c2V0LXNwZWVkJywgZGV2aWNlPSdkcml2ZTAnLCBzcGVlZD0wKQ0KPj4gICAgICAgICAgICBzZWxm
LmFzc2VydF9xbXAocmVzLCAncmV0dXJuJywge30pDQo+PiAgICAgICAgICAgIHNlbGYucW1wX2Jh
Y2t1cF93YWl0KCdkcml2ZTAnKQ0KPj4gKyAgICAgICAgc2VsZi52bS5zaHV0ZG93bigpDQo+Pg0K
Pj4gICAgICAgICAgICBzZWxmLmFzc2VydFRydWUoaW90ZXN0cy5jb21wYXJlX2ltYWdlcyhzZWxm
LnJlZl9pbWcsIHNlbGYuZGVzdF9pbWcpLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
J3RhcmdldCBpbWFnZSBkb2VzIG5vdCBtYXRjaCByZWZlcmVuY2UgaW1hZ2UnKQ0KPiANCj4gSeKA
mWQgcGVyc29uYWxseSBwcmVmZXIgYXV0b19kaXNtaXNzPUZhbHNlIGFuZCB0aGVuIGJsb2NrLWpv
Yi1kaXNtaXNzLg0KPiBBbHRob3VnaCBJIGNhbuKAmXQgZ2l2ZSBhIHJlYXNvbiB3aHkuDQo+IA0K
Pj4gUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZA
dmlydHVvenpvLmNvbT4NCj4+IFRlc3RlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tp
eSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPiANCj4gSW4gYW55IGNhc2UsIHRoYW5rcyEN
Cj4gDQo+IE1heA0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

