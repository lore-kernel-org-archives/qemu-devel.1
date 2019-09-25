Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C57DC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:16:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0733221D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="o4QIhhUC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0733221D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD85l-0000P7-0W
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 10:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD83x-0007Ai-6B
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD83v-00069s-RB
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:14:37 -0400
Received: from mail-eopbgr10131.outbound.protection.outlook.com
 ([40.107.1.131]:33410 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iD83u-00068P-4p; Wed, 25 Sep 2019 10:14:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4Lnna606h6GKCkmjYjJ4KtMs7SJ7/SekD9irKt/TAVKAx6mvSwNobFRXKrSsoqA09ZSxgtKEfXXXnryH1qcAW9FofO6ESZQGbEoqL21L9pOY4DUM+RIMwKJkA9ucjEISvxBBbV9Hrg1GGb74ODaYgrB8x3O6t9q6tI2jV3Tw2mmqxJBpxor005HzT/XchTDCn46OPSru+VrAsVJ+PYdb1BAuBO/00BjkeMwqa+MN+H8PopEuAE/t9F8gB5ItIFQygL4z9blfuKBQqzie7Km/6iQ+j0j1+UfNLG6PsMtTmy+Xi6+2aneZsapWufJSl0a+LPmuyLhW72y57xXjyK6ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIlzvnsnw0Nm+CyO1B1+OgSzuaYMi7s+xtdC3licq4I=;
 b=PDWbs8LcCOmgwKEqKTQOkmPjhMfTwcl7ILpl/i2hxfeOoaa7zOeBb3OzPYcYfBd9sefqHRoSmsflMTBHOiFfWr7pgLGsRE8UyvkTPtsokQyU6OWyqm2mEl/uCB1kyC0mOVyx54MV8XbZcxOu9HfeyOBuEmuYdFjMXmiPmzV/XkCsnyM9y5UlbR5grZQo3KzOvzEqJPUY36i/pgI/LeVV4TAB57SfOF8Myj0Lugns9pS9BbKInQs1zCUAvDQHUjakfkL0QS9AGedL2Nl3fBWZRGYxGWar3xmkblsOyyRXubBY4uEjuKIwmshyxpToNXhR5ptrBKO1KMlheReo4BFZuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIlzvnsnw0Nm+CyO1B1+OgSzuaYMi7s+xtdC3licq4I=;
 b=o4QIhhUC8HVe6D958chaV6VV4NJU7XZqT/wb5fAO7Pq0LDG+94sSrF1O6OiMogjA36EWzoRBTW6PH+7kcxKV442o2BHCr0zude8OPnByTu9t5FgUVxn5Ir2/DL5GF7Tze251/BXvB4binl7aSpfDH2hSaN7UMQoxFB81AwhG4PU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5148.eurprd08.prod.outlook.com (10.255.17.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Wed, 25 Sep 2019 14:14:32 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 14:14:32 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 10/22] quorum: Implement .bdrv_recurse_can_replace()
Thread-Topic: [PATCH 10/22] quorum: Implement .bdrv_recurse_can_replace()
Thread-Index: AQHVb8x5FMRz3/odLkqUJ37f4pTVWac8d32A
Date: Wed, 25 Sep 2019 14:14:31 +0000
Message-ID: <62f370ec-cec0-05eb-4cb0-a0888b28fce9@virtuozzo.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-11-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-11-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0030.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::16) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190925171429865
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0cb1f86-6d11-489b-571c-08d741c2af71
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5148; 
x-ms-traffictypediagnostic: DB8PR08MB5148:
x-microsoft-antispam-prvs: <DB8PR08MB51487EA26A03F28C9CB558DCC1870@DB8PR08MB5148.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(136003)(346002)(376002)(366004)(396003)(39840400004)(199004)(189003)(36756003)(229853002)(2501003)(54906003)(110136005)(316002)(8676002)(8936002)(81156014)(81166006)(305945005)(7736002)(3846002)(6116002)(386003)(102836004)(256004)(66446008)(14454004)(6506007)(26005)(2906002)(76176011)(52116002)(99286004)(11346002)(446003)(64756008)(31686004)(486006)(476003)(2616005)(66556008)(66476007)(25786009)(71200400001)(71190400001)(478600001)(31696002)(86362001)(186003)(66946007)(5660300002)(4326008)(6246003)(6512007)(6486002)(66066001)(6436002)(142923001)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5148;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lHHR44C5zOFb6fThdDjjDY/WeCP0FwByj8tuXX0H3B45pWyUgxzhHipv7oQjLuNNZYBaAw7qq4GDrGam5B3EIDrAyllOEkh3bwRvd2INKOf7oHP5CzU8b1RAnlhJo6pegtZ9xuHacwTim6Z74TAW74g4y/FNeENmaz7KO00AP+wisVRmIunEMRaSr1KQOC6GoyHzHv53qNSVKfCXPouAdXHIqBqWW3ZkEeN+3FRRqBlUB/6GxDeSR9+mz7n3iE9JEl/7nBpdThoGxSoLb0tdkmHm6W7YaVn38tQT+xKQl5PnBhz5qERsfcVP7ocGdd268oFz/9PcrnSHqDQT1utv5laLHNdHN3usND4qfXrRUIhtLntUZPXz0a97iJZ6aWavZAvRBl6DUDg1EFTSJpOBvJ/bhEKSOUisIxEMlf9PeHs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <159F6B8C56ACBF4980F8E283B3CD929C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0cb1f86-6d11-489b-571c-08d741c2af71
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 14:14:32.0116 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ouRVnY//ZI7ZBQov/pAeymKL/nGKN0xKxDy9h9Jop2vDk/S3WNF4n+t+/CEs9NaZNK3j7KXZFEMthnTq0yw1vUNIvpQZ1kdzJifmKi73kZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5148
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.131
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDkuMjAxOSAxODoyNywgTWF4IFJlaXR6IHdyb3RlOg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXgg
UmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0KPiAtLS0NCj4gICBibG9jay9xdW9ydW0uYyB8IDYy
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDYyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9ibG9j
ay9xdW9ydW0uYyBiL2Jsb2NrL3F1b3J1bS5jDQo+IGluZGV4IDIwNzA1NGE2NGUuLjgxYjU3ZGJh
ZTIgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL3F1b3J1bS5jDQo+ICsrKyBiL2Jsb2NrL3F1b3J1bS5j
DQo+IEBAIC04MjUsNiArODI1LDY3IEBAIHN0YXRpYyBib29sIHF1b3J1bV9yZWN1cnNlX2lzX2Zp
cnN0X25vbl9maWx0ZXIoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+ICAgICAgIHJldHVybiBmYWxz
ZTsNCj4gICB9DQo+ICAgDQo+ICtzdGF0aWMgYm9vbCBxdW9ydW1fcmVjdXJzZV9jYW5fcmVwbGFj
ZShCbG9ja0RyaXZlclN0YXRlICpicywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIEJsb2NrRHJpdmVyU3RhdGUgKnRvX3JlcGxhY2UpDQo+ICt7DQo+ICsgICAgQkRS
VlF1b3J1bVN0YXRlICpzID0gYnMtPm9wYXF1ZTsNCj4gKyAgICBpbnQgaTsNCj4gKw0KPiArICAg
IGZvciAoaSA9IDA7IGkgPCBzLT5udW1fY2hpbGRyZW47IGkrKykgew0KPiArICAgICAgICAvKg0K
PiArICAgICAgICAgKiBXZSBoYXZlIG5vIGlkZWEgd2hldGhlciBvdXIgY2hpbGRyZW4gc2hvdyB0
aGUgc2FtZSBkYXRhIGFzDQo+ICsgICAgICAgICAqIHRoaXMgbm9kZSAoQGJzKS4gIEl0IGlzIGFj
dHVhbGx5IGhpZ2hseSBsaWtlbHkgdGhhdA0KPiArICAgICAgICAgKiBAdG9fcmVwbGFjZSBkb2Vz
IG5vdCwgYmVjYXVzZSByZXBsYWNpbmcgYSBicm9rZW4gY2hpbGQgaXMNCj4gKyAgICAgICAgICog
b25lIG9mIHRoZSBtYWluIHVzZSBjYXNlcyBoZXJlLg0KPiArICAgICAgICAgKg0KPiArICAgICAg
ICAgKiBXZSBkbyBrbm93IHRoYXQgdGhlIG5ldyBCRFMgd2lsbCBtYXRjaCBAYnMsIHNvIHJlcGxh
Y2luZw0KPiArICAgICAgICAgKiBhbnkgb2Ygb3VyIGNoaWxkcmVuIGJ5IGl0IHdpbGwgYmUgc2Fm
ZS4gIEl0IGNhbm5vdCBjaGFuZ2UNCj4gKyAgICAgICAgICogdGhlIGRhdGEgdGhpcyBxdW9ydW0g
bm9kZSBwcmVzZW50cyB0byBpdHMgcGFyZW50cy4NCj4gKyAgICAgICAgICoNCj4gKyAgICAgICAg
ICogSG93ZXZlciwgcmVwbGFjaW5nIEB0b19yZXBsYWNlIGJ5IEBicyBpbiBhbnkgb2Ygb3VyDQo+
ICsgICAgICAgICAqIGNoaWxkcmVuJ3MgY2hhaW5zIG1heSBjaGFuZ2UgdmlzaWJsZSBkYXRhIHNv
bWV3aGVyZSBpbg0KPiArICAgICAgICAgKiB0aGVyZS4gIFdlIHRoZXJlZm9yZSBjYW5ub3QgcmVj
dXJzZSBkb3duIHRob3NlIGNoYWlucyB3aXRoDQo+ICsgICAgICAgICAqIGJkcnZfcmVjdXJzZV9j
YW5fcmVwbGFjZSgpLg0KPiArICAgICAgICAgKiAoTW9yZSBmb3JtYWxseSwgYmRydl9yZWN1cnNl
X2Nhbl9yZXBsYWNlKCkgcmVxdWlyZXMgdGhhdA0KPiArICAgICAgICAgKiBAdG9fcmVwbGFjZSB3
aWxsIGJlIHJlcGxhY2VkIGJ5IHNvbWV0aGluZyBtYXRjaGluZyB0aGUgQGJzDQo+ICsgICAgICAg
ICAqIHBhc3NlZCB0byBpdC4gIFdlIGNhbm5vdCBndWFyYW50ZWUgdGhhdC4pDQo+ICsgICAgICAg
ICAqDQo+ICsgICAgICAgICAqIFRodXMsIHdlIGNhbiBvbmx5IGNoZWNrIHdoZXRoZXIgYW55IG9m
IG91ciBpbW1lZGlhdGUNCj4gKyAgICAgICAgICogY2hpbGRyZW4gbWF0Y2hlcyBAdG9fcmVwbGFj
ZS4NCj4gKyAgICAgICAgICoNCj4gKyAgICAgICAgICogKEluIHRoZSBmdXR1cmUsIHdlIG1pZ2h0
IGFkZCBhIGZ1bmN0aW9uIHRvIHJlY3Vyc2UgZG93biBhDQo+ICsgICAgICAgICAqIGNoYWluIHRo
YXQgY2hlY2tzIHRoYXQgbm90aGluZyB0aGVyZSBjYXJlcyBhYm91dCBhIGNoYW5nZQ0KPiArICAg
ICAgICAgKiBpbiBkYXRhIGZyb20gdGhlIHJlc3BlY3RpdmUgY2hpbGQgaW4gcXVlc3Rpb24uICBG
b3INCj4gKyAgICAgICAgICogZXhhbXBsZSwgbW9zdCBmaWx0ZXJzIGRvIG5vdCBjYXJlIHdoZW4g
dGhlaXIgY2hpbGQncyBkYXRhDQo+ICsgICAgICAgICAqIHN1ZGRlbmx5IGNoYW5nZXMsIGFzIGxv
bmcgYXMgdGhlaXIgcGFyZW50cyBkbyBub3QgY2FyZS4pDQo+ICsgICAgICAgICAqLw0KPiArICAg
ICAgICBpZiAocy0+Y2hpbGRyZW5baV0uY2hpbGQtPmJzID09IHRvX3JlcGxhY2UpIHsNCj4gKyAg
ICAgICAgICAgIEVycm9yICpsb2NhbF9lcnIgPSBOVUxMOw0KPiArDQo+ICsgICAgICAgICAgICAv
Kg0KPiArICAgICAgICAgICAgICogV2Ugbm93IGhhdmUgdG8gZW5zdXJlIHRoYXQgdGhlcmUgaXMg
bm8gb3RoZXIgcGFyZW50DQo+ICsgICAgICAgICAgICAgKiB0aGF0IGNhcmVzIGFib3V0IHJlcGxh
Y2luZyB0aGlzIGNoaWxkIGJ5IGEgbm9kZSB3aXRoDQo+ICsgICAgICAgICAgICAgKiBwb3RlbnRp
YWxseSBkaWZmZXJlbnQgZGF0YS4NCj4gKyAgICAgICAgICAgICAqLw0KPiArICAgICAgICAgICAg
cy0+Y2hpbGRyZW5baV0udG9fYmVfcmVwbGFjZWQgPSB0cnVlOw0KPiArICAgICAgICAgICAgYmRy
dl9jaGlsZF9yZWZyZXNoX3Blcm1zKGJzLCBzLT5jaGlsZHJlbltpXS5jaGlsZCwgJmxvY2FsX2Vy
cik7DQo+ICsNCj4gKyAgICAgICAgICAgIC8qIFJldmVydCBwZXJtaXNzaW9ucyAqLw0KPiArICAg
ICAgICAgICAgcy0+Y2hpbGRyZW5baV0udG9fYmVfcmVwbGFjZWQgPSBmYWxzZTsNCj4gKyAgICAg
ICAgICAgIGJkcnZfY2hpbGRfcmVmcmVzaF9wZXJtcyhicywgcy0+Y2hpbGRyZW5baV0uY2hpbGQs
ICZlcnJvcl9hYm9ydCk7DQo+ICsNCj4gKyAgICAgICAgICAgIGlmIChsb2NhbF9lcnIpIHsNCj4g
KyAgICAgICAgICAgICAgICBlcnJvcl9mcmVlKGxvY2FsX2Vycik7DQo+ICsgICAgICAgICAgICAg
ICAgcmV0dXJuIGZhbHNlOw0KPiArICAgICAgICAgICAgfQ0KPiArDQo+ICsgICAgICAgICAgICBy
ZXR1cm4gdHJ1ZTsNCj4gKyAgICAgICAgfQ0KPiArICAgIH0NCj4gKw0KPiArICAgIHJldHVybiBm
YWxzZTsNCj4gK30NCj4gKw0KPiAgIHN0YXRpYyBpbnQgcXVvcnVtX3ZhbGlkX3RocmVzaG9sZChp
bnQgdGhyZXNob2xkLCBpbnQgbnVtX2NoaWxkcmVuLCBFcnJvciAqKmVycnApDQo+ICAgew0KPiAg
IA0KPiBAQCAtMTE5NSw2ICsxMjU2LDcgQEAgc3RhdGljIEJsb2NrRHJpdmVyIGJkcnZfcXVvcnVt
ID0gew0KPiAgIA0KPiAgICAgICAuaXNfZmlsdGVyICAgICAgICAgICAgICAgICAgICAgICAgICA9
IHRydWUsDQo+ICAgICAgIC5iZHJ2X3JlY3Vyc2VfaXNfZmlyc3Rfbm9uX2ZpbHRlciAgID0gcXVv
cnVtX3JlY3Vyc2VfaXNfZmlyc3Rfbm9uX2ZpbHRlciwNCj4gKyAgICAuYmRydl9yZWN1cnNlX2Nh
bl9yZXBsYWNlICAgICAgICAgICA9IHF1b3J1bV9yZWN1cnNlX2Nhbl9yZXBsYWNlLA0KDQphbmQg
aGVyZSwgaXQncyB1c2VsZXNzIHVudGlsIHdlIHNldCBpc19maWx0ZXIgdG8gZmFsc2UuDQoNCj4g
ICANCj4gICAgICAgLnN0cm9uZ19ydW50aW1lX29wdHMgICAgICAgICAgICAgICAgPSBxdW9ydW1f
c3Ryb25nX3J1bnRpbWVfb3B0cywNCj4gICB9Ow0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywN
ClZsYWRpbWlyDQo=

