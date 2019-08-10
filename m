Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3917C433FF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 15:37:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B74122087B
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 15:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VvCicnau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74122087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwTRB-0007Z5-Vk
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 11:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45595)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwTQU-00074j-29
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 11:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwTQS-0000Rk-TE
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 11:37:02 -0400
Received: from mail-eopbgr60092.outbound.protection.outlook.com
 ([40.107.6.92]:21928 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hwTQS-0000Ps-9A; Sat, 10 Aug 2019 11:37:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sr/7B3JRxjfFDtsT4y395MqXPm6Z/OLvsiSOKqH0Nl9IEt7AAkwty4o8WGjGzTsK/81GV38ZL0S6X6gpTmzbUis4wy+hMl6LqILzG+/YTC3anXbGON5zs5jESInKW9K5LQ2JkEOnXdeXUsLPYRxCZPb6bdrEQOhR6jzpbfeAZPiYQ2Ne/KAmS0oxp0ilyKE4mUkcyb2pa1s2NBwnZMD4OqGYMkOYR2Rnu/sWSw6Zob/Yj04gdlBIQ75uHd1ndRcjQKZBp1mAGS/ETBBvXf8MSUzHj5/rFv5T33VNF+gZvjcd4+fPidSUihRSDnNSoJaYZO7WhG8hko121EONfQbEgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4jcu1qfGn/tWMe9PrMYTGj1DORLFUzXs50fEkvWUo0=;
 b=KNOKUqCW8YHc47MvOGiTSvp/jfABypipukpN/5q2T/bt3N9v3jkZpCMHLY4RtM24RImwjZHMQDoIXSAZ21zldaVinxWU35sbXG3jnibo9X1QOn8ToC/N46ijOiZhQjEburtJNPALse9gQ/Go8U+Jrx1ytgKbff1VzOWQ4puNqry2PC6A6aGZVixo9KnUlALZW+M0Q2PN27PrcI6LHOqiki0clumhznP6j4E3ZWbKKfSpBZX4sadbuogLUqS0d3LWeFJn2wifnkH2iow2m3sctoigYGPwMquA3gHbguA4CcfWd9s5zhfZKIsuHKYy1mRILC7GKQgAoT9oCAOerkT5xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4jcu1qfGn/tWMe9PrMYTGj1DORLFUzXs50fEkvWUo0=;
 b=VvCicnauDD3tYE+XHTPCZ5Qr0662AYxMrl4TtBqH3FtGDJsM8i7LIfuYj0YqeZm2aCOOQfMQwFOnrvVk7uukvp7OrP5JvBHFU76izwh4annBkSS0eyuJQjNIgRXURFPgDPW5NFJR8CXqgmnXUBebBU703bERNOq7nc6LH4NFKeQ=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5516.eurprd08.prod.outlook.com (10.255.185.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Sat, 10 Aug 2019 15:36:56 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.021; Sat, 10 Aug 2019
 15:36:56 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v6 16/42] block: Flush all children in generic code
Thread-Index: AQHVTs2RRV0aAkz66kWAzm0fWE1kx6b0hUQA
Date: Sat, 10 Aug 2019 15:36:56 +0000
Message-ID: <b2f43475-224e-5003-2c51-3949e9fb2d42@virtuozzo.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-17-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-17-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0376.eurprd05.prod.outlook.com
 (2603:10a6:7:94::35) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190810183654574
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffb653e5-7725-4711-b3d3-08d71da893a6
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5516; 
x-ms-traffictypediagnostic: DB8PR08MB5516:
x-microsoft-antispam-prvs: <DB8PR08MB55165F7E526CBDADD774D518C1D10@DB8PR08MB5516.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 012570D5A0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(39840400004)(396003)(346002)(376002)(189003)(199004)(81166006)(81156014)(2906002)(7736002)(14444005)(256004)(6486002)(71190400001)(71200400001)(6116002)(3846002)(486006)(8676002)(31696002)(53936002)(76176011)(66066001)(64756008)(66446008)(66556008)(66476007)(66946007)(52116002)(14454004)(6246003)(478600001)(2501003)(86362001)(25786009)(36756003)(31686004)(8936002)(102836004)(5660300002)(386003)(54906003)(110136005)(4326008)(6506007)(186003)(2616005)(446003)(11346002)(305945005)(476003)(229853002)(6512007)(99286004)(6436002)(26005)(316002)(41533002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5516;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X2+PHQZz+Z7egc9UiFZmZ3v5t8G0Z3/HOkEq++QbUxX4jGtWkPlPyQFE22yyYWTCGbrIEqoATsiLY3vMtuifnHechbwZSd0A9Kg3Srqm3/FSFDGN8BiI9I22fimRjhHBWpjs1YeDE36ropPabFm7mdJfWUsjsVIv1/rzUj7pew+nMzqj0OwL0+Rtemt11exbLhkCCz1aQtC1ys1vh7ZSYGYngDCbhntURfm0LQ80Fh7QcMOBvGbZZYngfb/4cLIIdG7xH/3y/TkaPgRNPYIlAcbEMj83kx+ea55KUHJNoagWFCChY99fmT73yAhrC1ji6a3gi1WsVUi173FANkuf+TzPOf2VBuM+W3cX5HdQmdiDMd3VvmH+8rch3hpumB8yX6kiycOVnryMLeKOUnElmMDCzx/1oaSy1/5QYVuLpkk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2C2721A4A927E48BE1718EDA5A4B00F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb653e5-7725-4711-b3d3-08d71da893a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2019 15:36:56.6832 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7mAnPP1x/2Oo/CMJmWDgNSV46smVkNAxjQH6gK2AR8jPcP+W3JBJ9KKVQ5icDGeFn6da+kocNMp9UXfuA8Yc1LuSIEKJ0ok7+lNIGsp1vN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5516
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.92
Subject: Re: [Qemu-devel] [PATCH v6 16/42] block: Flush all children in
 generic code
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

MDkuMDguMjAxOSAxOToxMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBJZiB0aGUgZHJpdmVyIGRvZXMg
bm90IHN1cHBvcnQgLmJkcnZfY29fZmx1c2goKSBzbyBiZHJ2X2NvX2ZsdXNoKCkNCj4gaXRzZWxm
IGhhcyB0byBmbHVzaCB0aGUgY2hpbGRyZW4gb2YgdGhlIGdpdmVuIG5vZGUsIGl0IHNob3VsZCBu
b3QgZmx1c2gNCj4ganVzdCBicy0+ZmlsZS0+YnMsIGJ1dCBpbiBmYWN0IGFsbCBjaGlsZHJlbi4N
Cj4gDQo+IEluIGFueSBjYXNlLCB0aGUgQkxLREJHX0VWRU5UKCkgc2hvdWxkIGJlIGVtaXR0ZWQg
b24gdGhlIHByaW1hcnkgY2hpbGQsDQo+IGJlY2F1c2UgdGhhdCBpcyB3aGVyZSBhIGJsa2RlYnVn
IG5vZGUgd291bGQgYmUgaWYgdGhlcmUgaXMgYW55Lg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBWbGFk
aW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgIGJs
b2NrL2lvLmMgfCAyMyArKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxNyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Js
b2NrL2lvLmMgYi9ibG9jay9pby5jDQo+IGluZGV4IGM1YThlM2U2YTMuLmJjYzc3MGQzMzYgMTAw
NjQ0DQo+IC0tLSBhL2Jsb2NrL2lvLmMNCj4gKysrIGIvYmxvY2svaW8uYw0KPiBAQCAtMjU3Miw2
ICsyNTcyLDggQEAgc3RhdGljIHZvaWQgY29yb3V0aW5lX2ZuIGJkcnZfZmx1c2hfY29fZW50cnko
dm9pZCAqb3BhcXVlKQ0KPiAgIA0KPiAgIGludCBjb3JvdXRpbmVfZm4gYmRydl9jb19mbHVzaChC
bG9ja0RyaXZlclN0YXRlICpicykNCj4gICB7DQo+ICsgICAgQmRydkNoaWxkICpwcmltYXJ5X2No
aWxkID0gYmRydl9wcmltYXJ5X2NoaWxkKGJzKTsNCj4gKyAgICBCZHJ2Q2hpbGQgKmNoaWxkOw0K
PiAgICAgICBpbnQgY3VycmVudF9nZW47DQo+ICAgICAgIGludCByZXQgPSAwOw0KPiAgIA0KPiBA
QCAtMjYwMSw3ICsyNjAzLDcgQEAgaW50IGNvcm91dGluZV9mbiBiZHJ2X2NvX2ZsdXNoKEJsb2Nr
RHJpdmVyU3RhdGUgKmJzKQ0KPiAgICAgICB9DQo+ICAgDQo+ICAgICAgIC8qIFdyaXRlIGJhY2sg
Y2FjaGVkIGRhdGEgdG8gdGhlIE9TIGV2ZW4gd2l0aCBjYWNoZT11bnNhZmUgKi8NCj4gLSAgICBC
TEtEQkdfRVZFTlQoYnMtPmZpbGUsIEJMS0RCR19GTFVTSF9UT19PUyk7DQo+ICsgICAgQkxLREJH
X0VWRU5UKHByaW1hcnlfY2hpbGQsIEJMS0RCR19GTFVTSF9UT19PUyk7DQo+ICAgICAgIGlmIChi
cy0+ZHJ2LT5iZHJ2X2NvX2ZsdXNoX3RvX29zKSB7DQo+ICAgICAgICAgICByZXQgPSBicy0+ZHJ2
LT5iZHJ2X2NvX2ZsdXNoX3RvX29zKGJzKTsNCj4gICAgICAgICAgIGlmIChyZXQgPCAwKSB7DQo+
IEBAIC0yNjExLDE1ICsyNjEzLDE1IEBAIGludCBjb3JvdXRpbmVfZm4gYmRydl9jb19mbHVzaChC
bG9ja0RyaXZlclN0YXRlICpicykNCj4gICANCj4gICAgICAgLyogQnV0IGRvbid0IGFjdHVhbGx5
IGZvcmNlIGl0IHRvIHRoZSBkaXNrIHdpdGggY2FjaGU9dW5zYWZlICovDQo+ICAgICAgIGlmIChi
cy0+b3Blbl9mbGFncyAmIEJEUlZfT19OT19GTFVTSCkgew0KPiAtICAgICAgICBnb3RvIGZsdXNo
X3BhcmVudDsNCj4gKyAgICAgICAgZ290byBmbHVzaF9jaGlsZHJlbjsNCj4gICAgICAgfQ0KPiAg
IA0KPiAgICAgICAvKiBDaGVjayBpZiB3ZSByZWFsbHkgbmVlZCB0byBmbHVzaCBhbnl0aGluZyAq
Lw0KPiAgICAgICBpZiAoYnMtPmZsdXNoZWRfZ2VuID09IGN1cnJlbnRfZ2VuKSB7DQo+IC0gICAg
ICAgIGdvdG8gZmx1c2hfcGFyZW50Ow0KPiArICAgICAgICBnb3RvIGZsdXNoX2NoaWxkcmVuOw0K
PiAgICAgICB9DQo+ICAgDQo+IC0gICAgQkxLREJHX0VWRU5UKGJzLT5maWxlLCBCTEtEQkdfRkxV
U0hfVE9fRElTSyk7DQo+ICsgICAgQkxLREJHX0VWRU5UKHByaW1hcnlfY2hpbGQsIEJMS0RCR19G
TFVTSF9UT19ESVNLKTsNCj4gICAgICAgaWYgKCFicy0+ZHJ2KSB7DQo+ICAgICAgICAgICAvKiBi
cy0+ZHJ2LT5iZHJ2X2NvX2ZsdXNoKCkgbWlnaHQgaGF2ZSBlamVjdGVkIHRoZSBCRFMNCj4gICAg
ICAgICAgICAqIChldmVuIGluIGNhc2Ugb2YgYXBwYXJlbnQgc3VjY2VzcykgKi8NCj4gQEAgLTI2
NjMsOCArMjY2NSwxNyBAQCBpbnQgY29yb3V0aW5lX2ZuIGJkcnZfY29fZmx1c2goQmxvY2tEcml2
ZXJTdGF0ZSAqYnMpDQo+ICAgICAgIC8qIE5vdyBmbHVzaCB0aGUgdW5kZXJseWluZyBwcm90b2Nv
bC4gIEl0IHdpbGwgYWxzbyBoYXZlIEJEUlZfT19OT19GTFVTSA0KPiAgICAgICAgKiBpbiB0aGUg
Y2FzZSBvZiBjYWNoZT11bnNhZmUsIHNvIHRoZXJlIGFyZSBubyB1c2VsZXNzIGZsdXNoZXMuDQo+
ICAgICAgICAqLw0KPiAtZmx1c2hfcGFyZW50Og0KPiAtICAgIHJldCA9IGJzLT5maWxlID8gYmRy
dl9jb19mbHVzaChicy0+ZmlsZS0+YnMpIDogMDsNCj4gK2ZsdXNoX2NoaWxkcmVuOg0KPiArICAg
IHJldCA9IDA7ID4gKyAgICBRTElTVF9GT1JFQUNIKGNoaWxkLCAmYnMtPmNoaWxkcmVuLCBuZXh0
KSB7DQo+ICsgICAgICAgIGludCB0aGlzX2NoaWxkX3JldDsNCj4gKw0KPiArICAgICAgICB0aGlz
X2NoaWxkX3JldCA9IGJkcnZfY29fZmx1c2goY2hpbGQtPmJzKTsNCj4gKyAgICAgICAgaWYgKCFy
ZXQpIHsNCj4gKyAgICAgICAgICAgIHJldCA9IHRoaXNfY2hpbGRfcmV0Ow0KPiArICAgICAgICB9
DQo+ICsgICAgfQ0KDQpIbW0sIHlvdSBzYWlkIHRoYXQgd2Ugd2FudCB0byBmbHVzaCBvbmx5IGNo
aWxkcmVuIHdpdGggd3JpdGUtYWNjZXNzIGZyb20gcGFyZW50Li4NClNob3VsZG4ndCB3ZSBjaGVj
ayBpdD8gT3Igd2UgYXNzdW1lIHRoYXQgaXQncyBhbHdheXMgc2FmZSB0byBjYWxsIGJkcnZfY29f
Zmx1c2ggb24NCmEgbm9kZT8NCg0KPiArDQo+ICAgb3V0Og0KPiAgICAgICAvKiBOb3RpZnkgYW55
IHBlbmRpbmcgZmx1c2hlcyB0aGF0IHdlIGhhdmUgY29tcGxldGVkICovDQo+ICAgICAgIGlmIChy
ZXQgPT0gMCkgew0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

