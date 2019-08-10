Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A0BC433FF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 13:32:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 347E62089E
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 13:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FNx7kC/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347E62089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwRUD-00040w-Jl
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 09:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60359)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwRTj-0003Xx-Lc
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 09:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwRTi-0001sp-Cg
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 09:32:15 -0400
Received: from mail-eopbgr130127.outbound.protection.outlook.com
 ([40.107.13.127]:16772 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hwRTg-0001qD-Po; Sat, 10 Aug 2019 09:32:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAh4Ma/jw8usvo+V60zsFKJflKUlPcctRUYIa5CWQQxxkcE+8GBlehT5INzyytLOjuhmCBS4VTD9R8219Cxp6mCE7VIvuO4niYxLelgf3O2cpUecoj8QLwSQJ9ZaF4Cq0i1n+oRnaGXQE9uGcGQvV3v9VeuRrtobX6hwmeSGHAT8zwLI0ZPUmhG1tDKOALqn9f0x50c91ZBzs0UQmZdn4Eck9f2rI21bms0CXMobwoQ1XQdnMlQeUtUwJY4grOVtLlt7+TP3WBVR0GQDqWYYzOPkPSbuuuRD+ag7shI6fr2Jok0WvBofgd9kCKKfBBO137QYzHhvvg6MrJEmVEAFhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KM85tTjLGwaUaHV7lqFgZ8MHiXseKw18MnZxMdpnUw=;
 b=aEGGhCbkHYsr9E0udln8nE0cScDJYpJNHFzM/opJ2rhMc7H+7X9IxRl5w86TWHvw2cHbWh0BS1EOGaj4rqax2EklMrqMv/v30IAZh60qn26N7EFKCmB6ZJAA55Sm/zOM8i8VERxAXAY2eVtaIQPV0P6ASfrjJKmQUdkYM2F9Z71+VuleLSR53Fv6bX6w7Hu4/f06ASp2oFrKz7Xo/kNxgO/fQ1R+OBsQ/SbsVmv0NMBLbcbwyx6Z4Q0l3gYZsUteFswbZMDW6L5/o2DgC6qZODKvYkHkjhkit3kQcZTCIqIUGWw7qQ0MJYSNiDSnT0cQkoUBGixV+/d0qDUmn04tnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KM85tTjLGwaUaHV7lqFgZ8MHiXseKw18MnZxMdpnUw=;
 b=FNx7kC/So8JO629+TeqE4GpxxwKnQHx4Rp9u27Onnmyj1SVEpe1TVoj22zqNrdwNwpB1vE0CFLP/XJ3TYZcaicbgXRPfJR7BeNah29D9v/QXUi1nTtN70TnAlMbqjEp8DQoJl6SkRKMRUIVrV0VE6yXZmo1QXQYhBsVnbW9C/BU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5257.eurprd08.prod.outlook.com (10.255.18.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Sat, 10 Aug 2019 13:32:08 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.021; Sat, 10 Aug 2019
 13:32:08 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v6 09/42] block: Include filters when freezing backing
 chain
Thread-Index: AQHVTs2HIkGycjdnZUuS/P1RVk38qKb0YmUA
Date: Sat, 10 Aug 2019 13:32:08 +0000
Message-ID: <0020733a-cf68-7df0-b92f-68fd498735cd@virtuozzo.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-10-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-10-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0251.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::27) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190810163206091
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bee016af-14ed-4f69-e0f2-08d71d972430
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5257; 
x-ms-traffictypediagnostic: DB8PR08MB5257:
x-microsoft-antispam-prvs: <DB8PR08MB5257C641A1AC1D84A8DC59D1C1D10@DB8PR08MB5257.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:569;
x-forefront-prvs: 012570D5A0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(396003)(346002)(39850400004)(376002)(189003)(199004)(186003)(478600001)(110136005)(66446008)(81156014)(36756003)(102836004)(7736002)(26005)(8676002)(305945005)(229853002)(64756008)(5660300002)(4326008)(86362001)(6486002)(31696002)(6506007)(6436002)(6512007)(54906003)(386003)(8936002)(81166006)(14454004)(25786009)(476003)(3846002)(11346002)(446003)(2616005)(6116002)(31686004)(99286004)(76176011)(2906002)(486006)(53936002)(66066001)(2501003)(6246003)(14444005)(256004)(66946007)(66476007)(66556008)(52116002)(316002)(71190400001)(71200400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5257;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VOKd1iOoIsHpnix8G308h3XXaC/ROpaQP01uLB4fG+ycp23eIHIFxsAp56EcpPR3YHFUoUL/DDNtxjFlu/gqPn3bbVZg0tsLMuSCGSbJUkqmPSowJ/EAsPaduD9CHkdv+1IoPAXCbEQ+mEYUId1kkhD2BmDpqrRtZmJKWNOHYBMWBIRvNniSAN7Z4XJ8RKQgqRpKrrxhdMzB7TwxY2uHQncYfF4cnl3q/A8qPhkpx4Ou8dx0DFZ3+96M1lyARIzSfYT0S1EYRa55h+xXiUd+BZ3CGR48Z7h5by1nkzEZIAjLp8MX1QjSpULlrMtWRjPP6ydXEPgZ18Fxn892X0xnH4rYno/6cZWR2I13lroMQzzjzgyvvYga+tzeqGNKRwfhI5UR0wsk+ynGVs35NY6AUvSenkqpDv18I5glj1P3ayY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D8287E93A3AB040B6454231DCA551D1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee016af-14ed-4f69-e0f2-08d71d972430
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2019 13:32:08.2586 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xk4Ok3MfOSEAVlpOEgI84j8aRyGAyCHdpUJJ+j3ZTzscCTVoR5y1taXxCbky3jyIq2BQyLSMizqkPQkyCvqUZ0OuQRGPMBnOhgZuk65uVcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5257
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.127
Subject: Re: [Qemu-devel] [PATCH v6 09/42] block: Include filters when
 freezing backing chain
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMDguMjAxOSAxOToxMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBJbiBvcmRlciB0byBtYWtlIGZp
bHRlcnMgd29yayBpbiBiYWNraW5nIGNoYWlucywgdGhlIGFzc29jaWF0ZWQNCj4gZnVuY3Rpb25z
IG11c3QgYmUgYWJsZSB0byBkZWFsIHdpdGggdGhlbSBhbmQgZnJlZXplIGFsbCBmaWx0ZXIgbGlu
a3MsIGJlDQo+IHRoZXkgQ09XIG9yIFIvVyBmaWx0ZXIgbGlua3MuDQo+IA0KPiBJbiB0aGUgcHJv
Y2VzcywgcmVuYW1lIHRoZXNlIGZ1bmN0aW9ucyB0byByZWZsZWN0IHRoYXQgdGhleSBub3cgYWN0
IG9uDQo+IGdlbmVyYWxpemVkIGNoYWlucyBvZiBmaWx0ZXIgbm9kZXMgaW5zdGVhZCBvZiBiYWNr
aW5nIGNoYWlucyBhbG9uZS4NCj4gDQo+IFdoaWxlIGF0IGl0LCBhZGQgc29tZSBjb21tZW50cyB0
aGF0IG5vdGUgd2hpY2ggZnVuY3Rpb25zIHJlcXVpcmUgdGhlaXINCj4gY2FsbGVyIHRvIGVuc3Vy
ZSB0aGF0IGEgZ2l2ZW4gY2hpbGQgbGluayBpcyBub3QgZnJvemVuLCBhbmQgaG93IHRoZQ0KPiBj
YWxsZXJzIGRvIHNvLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF4IFJlaXR6IDxtcmVpdHpAcmVk
aGF0LmNvbT4NCj4gLS0tDQo+ICAgaW5jbHVkZS9ibG9jay9ibG9jay5oIHwgMTAgKysrLS0tDQo+
ICAgYmxvY2suYyAgICAgICAgICAgICAgIHwgODEgKysrKysrKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiAgIGJsb2NrL2NvbW1pdC5jICAgICAgICB8ICA4ICsrLS0tDQo+
ICAgYmxvY2svbWlycm9yLmMgICAgICAgIHwgIDQgKy0tDQo+ICAgYmxvY2svc3RyZWFtLmMgICAg
ICAgIHwgIDggKystLS0NCj4gICA1IGZpbGVzIGNoYW5nZWQsIDYyIGluc2VydGlvbnMoKyksIDQ5
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvYmxvY2svYmxvY2suaCBi
L2luY2x1ZGUvYmxvY2svYmxvY2suaA0KPiBpbmRleCA1MGEwN2MxYzMzLi5mNmYwOWI5NWNkIDEw
MDY0NA0KPiAtLS0gYS9pbmNsdWRlL2Jsb2NrL2Jsb2NrLmgNCj4gKysrIGIvaW5jbHVkZS9ibG9j
ay9ibG9jay5oDQo+IEBAIC0zNjQsMTEgKzM2NCwxMSBAQCBpbnQgYmRydl9kcm9wX2ludGVybWVk
aWF0ZShCbG9ja0RyaXZlclN0YXRlICp0b3AsIEJsb2NrRHJpdmVyU3RhdGUgKmJhc2UsDQo+ICAg
QmxvY2tEcml2ZXJTdGF0ZSAqYmRydl9maW5kX292ZXJsYXkoQmxvY2tEcml2ZXJTdGF0ZSAqYWN0
aXZlLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJsb2NrRHJpdmVy
U3RhdGUgKmJzKTsNCj4gICBCbG9ja0RyaXZlclN0YXRlICpiZHJ2X2ZpbmRfYmFzZShCbG9ja0Ry
aXZlclN0YXRlICpicyk7DQo+IC1ib29sIGJkcnZfaXNfYmFja2luZ19jaGFpbl9mcm96ZW4oQmxv
Y2tEcml2ZXJTdGF0ZSAqYnMsIEJsb2NrRHJpdmVyU3RhdGUgKmJhc2UsDQo+IC0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKTsNCj4gLWludCBiZHJ2X2ZyZWV6
ZV9iYWNraW5nX2NoYWluKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBCbG9ja0RyaXZlclN0YXRlICpi
YXNlLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKTsNCj4g
LXZvaWQgYmRydl91bmZyZWV6ZV9iYWNraW5nX2NoYWluKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBC
bG9ja0RyaXZlclN0YXRlICpiYXNlKTsNCj4gK2Jvb2wgYmRydl9pc19jaGFpbl9mcm96ZW4oQmxv
Y2tEcml2ZXJTdGF0ZSAqYnMsIEJsb2NrRHJpdmVyU3RhdGUgKmJhc2UsDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCk7DQo+ICtpbnQgYmRydl9mcmVlemVfY2hhaW4o
QmxvY2tEcml2ZXJTdGF0ZSAqYnMsIEJsb2NrRHJpdmVyU3RhdGUgKmJhc2UsDQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKTsNCj4gK3ZvaWQgYmRydl91bmZyZWV6ZV9jaGFp
bihCbG9ja0RyaXZlclN0YXRlICpicywgQmxvY2tEcml2ZXJTdGF0ZSAqYmFzZSk7DQo+ICAgDQo+
ICAgDQo+ICAgdHlwZWRlZiBzdHJ1Y3QgQmRydkNoZWNrUmVzdWx0IHsNCj4gZGlmZiAtLWdpdCBh
L2Jsb2NrLmMgYi9ibG9jay5jDQo+IGluZGV4IGFkZjgyZWZiMGUuLjY1MGMwMGQxODIgMTAwNjQ0
DQo+IC0tLSBhL2Jsb2NrLmMNCj4gKysrIGIvYmxvY2suYw0KPiBAQCAtMjMwMywxMiArMjMwMywx
NSBAQCBzdGF0aWMgdm9pZCBiZHJ2X3JlcGxhY2VfY2hpbGRfbm9wZXJtKEJkcnZDaGlsZCAqY2hp
bGQsDQo+ICAgICogSWYgQG5ld19icyBpcyBub3QgTlVMTCwgYmRydl9jaGVja19wZXJtKCkgbXVz
dCBiZSBjYWxsZWQgYmVmb3JlaGFuZCwgYXMgdGhpcw0KPiAgICAqIGZ1bmN0aW9uIHVzZXMgYmRy
dl9zZXRfcGVybSgpIHRvIHVwZGF0ZSB0aGUgcGVybWlzc2lvbnMgYWNjb3JkaW5nIHRvIHRoZSBu
ZXcNCj4gICAgKiByZWZlcmVuY2UgdGhhdCBAbmV3X2JzIGdldHMuDQo+ICsgKg0KPiArICogQ2Fs
bGVycyBtdXN0IGVuc3VyZSB0aGF0IGNoaWxkLT5mcm96ZW4gaXMgZmFsc2UuDQo+ICAgICovDQo+
ICAgc3RhdGljIHZvaWQgYmRydl9yZXBsYWNlX2NoaWxkKEJkcnZDaGlsZCAqY2hpbGQsIEJsb2Nr
RHJpdmVyU3RhdGUgKm5ld19icykNCj4gICB7DQo+ICAgICAgIEJsb2NrRHJpdmVyU3RhdGUgKm9s
ZF9icyA9IGNoaWxkLT5iczsNCj4gICAgICAgdWludDY0X3QgcGVybSwgc2hhcmVkX3Blcm07DQo+
ICAgDQo+ICsgICAgLyogQXNzZXJ0cyB0aGF0IGNoaWxkLT5mcm96ZW4gPT0gZmFsc2UgKi8NCj4g
ICAgICAgYmRydl9yZXBsYWNlX2NoaWxkX25vcGVybShjaGlsZCwgbmV3X2JzKTsNCj4gICANCj4g
ICAgICAgLyoNCj4gQEAgLTI0NjgsNiArMjQ3MSw3IEBAIHN0YXRpYyB2b2lkIGJkcnZfZGV0YWNo
X2NoaWxkKEJkcnZDaGlsZCAqY2hpbGQpDQo+ICAgICAgIGdfZnJlZShjaGlsZCk7DQo+ICAgfQ0K
PiAgIA0KPiArLyogQ2FsbGVycyBtdXN0IGVuc3VyZSB0aGF0IGNoaWxkLT5mcm96ZW4gaXMgZmFs
c2UuICovDQo+ICAgdm9pZCBiZHJ2X3Jvb3RfdW5yZWZfY2hpbGQoQmRydkNoaWxkICpjaGlsZCkN
Cj4gICB7DQo+ICAgICAgIEJsb2NrRHJpdmVyU3RhdGUgKmNoaWxkX2JzOw0KPiBAQCAtMjQ3Nywx
MCArMjQ4MSw2IEBAIHZvaWQgYmRydl9yb290X3VucmVmX2NoaWxkKEJkcnZDaGlsZCAqY2hpbGQp
DQo+ICAgICAgIGJkcnZfdW5yZWYoY2hpbGRfYnMpOw0KPiAgIH0NCj4gICANCj4gLS8qKg0KPiAt
ICogQ2xlYXIgYWxsIGluaGVyaXRzX2Zyb20gcG9pbnRlcnMgZnJvbSBjaGlsZHJlbiBhbmQgZ3Jh
bmRjaGlsZHJlbiBvZg0KPiAtICogQHJvb3QgdGhhdCBwb2ludCB0byBAcm9vdCwgd2hlcmUgbmVj
ZXNzYXJ5Lg0KPiAtICovDQoNCkhtbSwgdW5yZWxhdGVkIGNodW5rPyBXaXRob3V0IGl0Og0KUmV2
aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVv
enpvLmNvbT4NCg0KPiAgIHN0YXRpYyB2b2lkIGJkcnZfdW5zZXRfaW5oZXJpdHNfZnJvbShCbG9j
a0RyaXZlclN0YXRlICpyb290LCBCZHJ2Q2hpbGQgKmNoaWxkKQ0KPiAgIHsNCj4gICAgICAgQmRy
dkNoaWxkICpjOw0KPiBAQCAtMjUwNSw2ICsyNTA1LDcgQEAgc3RhdGljIHZvaWQgYmRydl91bnNl
dF9pbmhlcml0c19mcm9tKEJsb2NrRHJpdmVyU3RhdGUgKnJvb3QsIEJkcnZDaGlsZCAqY2hpbGQp
DQoNClsuLl0NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

