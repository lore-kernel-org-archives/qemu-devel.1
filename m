Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B27BC433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 12:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA03520B1F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 12:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CnN57Qbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA03520B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huylV-0007ce-3o
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 08:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48301)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1huyko-00076M-Fz
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 08:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1huykm-0006IZ-HG
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 08:39:50 -0400
Received: from mail-eopbgr40102.outbound.protection.outlook.com
 ([40.107.4.102]:36929 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1huykl-0006Gu-2A; Tue, 06 Aug 2019 08:39:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwYcPD92WXhebqxxV+8PowKY5TvigyZn6IHKkYLyGd87P+amZ2GzCHx5jODGhm6Dipde1pocFrCN4d9LuwLLvMfvf7Sizvw8JFtjS1JuOitaRXJzEuay2UlXHn034Pw22+a7tCByFJFnr53HvmkQUiTqLWkC8kQT3RMNDe+zPcHaFCc+f4NkDF5VS/efhZ88bNg6RUqCfbQJnYEbgNIJk8T/YeyFxel2EDuFNm9V8Eams+nhNBYRCMHP+N8ozFfrCBEGoH9F0wwoH0iKq/DQoSwd2tsnn045ekVSVMaFWKQS4O8X1C9s3Hi23rGqRS/yid41LulA5WSNrGKx76/7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYFFxbjldf9uhpJ5s28sU5+AqcCPTKvKCSCvdqWh6gQ=;
 b=Sh947gK5T5atRGyN6dXkVF6jWCtgPBrWVpJ2ehK08sMiZq24JKjMg3tIe/CuqEBy1dHJo1h9+inq87kpFdI3K+OtPBV2QRp/hTAP2RGhl2QIO4SmkjuXLKsAXU7GG+SeDx2RLxVCK/7jhPgFzbtvhciPClmGXrZYmiDZPSKr32OGNGA8Amah3Mc7Tei+bWnxt50m53K7H3xNptICdeAR83JLXJ8P70MVBIHDWKKhC9nYNR8UgisIO5ZeO1YX0gg0QUiKmfJ26K5DSBtmUdovBl3cRSj0ikjZfKhwX4Dj3QJb6pdAgdWWXFUW3j1R63S7+StEWkV168jjRZTDmkK9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYFFxbjldf9uhpJ5s28sU5+AqcCPTKvKCSCvdqWh6gQ=;
 b=CnN57Qbv70op9ptkjW7PwNOeuw6hD5UZ91PrJLutKzQwHgPcrWlF5F/OSZyC5l8Sj78l31YOytpJE9zvbzHbQhu3/PL6rFiqvTP9fNKz/r9/cC6AX0JdJ0w9+Phvvl3ZFNm5/3SPqQyi21HD+EqK/lZSihQ2p/Coy6Xr8Rf2l/0=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3929.eurprd08.prod.outlook.com (20.179.11.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Tue, 6 Aug 2019 12:39:42 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 12:39:42 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH] util/hbitmap: fix unaligned reset
Thread-Index: AQHVSWRPRHRMrQjqvUmj+ogxvT3PoaboXTQAgAW4CYA=
Date: Tue, 6 Aug 2019 12:39:41 +0000
Message-ID: <a7b3d467-e3c4-3559-fa73-7f4572202b5e@virtuozzo.com>
References: <20190802185830.74648-1-vsementsov@virtuozzo.com>
 <815da22c-e88e-e813-d342-9ad14191d052@redhat.com>
In-Reply-To: <815da22c-e88e-e813-d342-9ad14191d052@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0326.eurprd05.prod.outlook.com
 (2603:10a6:7:92::21) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190806153939330
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3822349-9c58-4248-1ffb-08d71a6b2739
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB3929; 
x-ms-traffictypediagnostic: DB8PR08MB3929:
x-microsoft-antispam-prvs: <DB8PR08MB392969FC2743D141746D4D7BC1D50@DB8PR08MB3929.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(396003)(39850400004)(136003)(366004)(51444003)(53754006)(199004)(189003)(6436002)(6246003)(86362001)(66476007)(66556008)(64756008)(66446008)(478600001)(66946007)(229853002)(99286004)(6486002)(3846002)(52116002)(107886003)(316002)(4326008)(53936002)(6116002)(6512007)(305945005)(31696002)(25786009)(7736002)(54906003)(68736007)(110136005)(2906002)(76176011)(81156014)(81166006)(8676002)(71190400001)(102836004)(2616005)(71200400001)(486006)(476003)(53546011)(6506007)(446003)(31686004)(386003)(66066001)(26005)(186003)(11346002)(8936002)(2501003)(36756003)(256004)(5660300002)(14454004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3929;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wHFC4l/x+ClAA8NesYo0lTHJUOSnRBISsSgnv4HRLxPkg3V6IIQFcypBvUaRcUdrDBYY+trDul3ZmV0SimvQFMPMPmN7EPsL7tciYJG7lzK0QPqOuhKlPNdlvoonJACjY2BMTN2tfOf6GbBg+kIbb5M4LN9C7SiW1GkS6rh0jMJ/eYF5migbioErFW4XTIjw/gwumnh9I0/E/z8Jfcz9wM9o8n6hNWrKoGA2beLWxWrV3lUmjI8pFNHFXU6oaA5weFdEfpgxJRF9KK4fWjeJqE1A8+FpOFGxWAd02bEa1vBrOSQOf5FFvfICxWKtjFmftX0xakgzdFS9jqeD8MnH6I0kJ+q17n2ianR+ycB41YvJ8zqdXs+qhnyzadqxR6FP8ZhfBhjS9knaO8hgZNst2N3ch/L3jzldNl6+5uw/WAg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B556BCD8D7CDDC4090DA612B1312AA36@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3822349-9c58-4248-1ffb-08d71a6b2739
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 12:39:41.9683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3929
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.102
Subject: Re: [Qemu-devel] [PATCH] util/hbitmap: fix unaligned reset
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDMuMDguMjAxOSAwOjE5LCBNYXggUmVpdHogd3JvdGU6DQo+IE9uIDAyLjA4LjE5IDIwOjU4LCBW
bGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gaGJpdG1hcF9yZXNldCBpcyBi
cm9rZW46IGl0IHJvdW5kcyB1cCB0aGUgcmVxdWVzdGVkIHJlZ2lvbi4gSXQgbGVhZHMgdG8NCj4+
IHRoZSBmb2xsb3dpbmcgYnVnLCB3aGljaCBpcyBzaG93biBieSBmaXhlZCB0ZXN0Og0KPj4NCj4+
IGFzc3VtZSBncmFudWxhcml0eSA9IDINCj4+IHNldCgwLCAzKSAjIGNvdW50IGJlY29tZXMgNA0K
Pj4gcmVzZXQoMCwgMSkgIyBjb3VudCBiZWNvbWVzIDINCj4+DQo+PiBCdXQgdXNlciBvZiB0aGUg
aW50ZXJmYWNlIGFzc3VtZSB0aGF0IHZpcnR1YWwgYml0IDEgc2hvdWxkIGJlIHN0aWxsDQo+PiBk
aXJ0eSwgc28gaGJpdG1hcCBzaG91bGQgcmVwb3J0IGNvdW50IHRvIGJlIDQhDQo+Pg0KPj4gSW4g
b3RoZXIgd29yZHMsIGJlY2F1c2Ugb2YgZ3JhbnVsYXJpdHksIHdoZW4gd2Ugc2V0IG9uZSAidmly
dHVhbCIgYml0LA0KPj4geWVzLCB3ZSBtYWtlIGFsbCAidmlydHVhbCIgYml0cyBpbiBzYW1lIGNo
dW5rIHRvIGJlIGRpcnR5LiBCdXQgdGhpcw0KPj4gc2hvdWxkIG5vdCBiZSBzbyBmb3IgcmVzZXQu
DQo+Pg0KPj4gRml4IHRoaXMsIGFsaWduaW5nIGJvdW5kIGNvcnJlY3RseS4NCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1
b3p6by5jb20+DQo+PiAtLS0NCj4+DQo+PiBIaSBhbGwhDQo+Pg0KPj4gSG1tLCBpcyBpdCBhIGJ1
ZyBvciBmZWF0dXJlPyA6KQ0KPj4gSSBkb24ndCBoYXZlIGEgdGVzdCBmb3IgbWlycm9yIHlldCwg
YnV0IEkgdGhpbmsgdGhhdCBzeW5jIG1pcnJvciBtYXkgYmUgYnJva2VuDQo+PiBiZWNhdXNlIG9m
IHRoaXMsIGFzIGRvX3N5bmNfdGFyZ2V0X3dyaXRlKCkgc2VlbXMgdG8gYmUgdXNpbmcgdW5hbGln
bmVkIHJlc2V0Lg0KPiANCj4gQ3JhcC4NCj4gDQo+IA0KPiBZZXMsIHlvdeKAmXJlIHJpZ2h0LiAg
VGhpcyB3b3VsZCBmaXggaXQsIGFuZCBpdCB3b3VsZG7igJl0IGZpeCBpdCBpbiB0aGUNCj4gd29y
c3Qgd2F5Lg0KPiANCj4gQnV0IEkgZG9u4oCZdCBrbm93IHdoZXRoZXIgdGhpcyBwYXRjaCBpcyB0
aGUgYmVzdCB3YXkgZm9yd2FyZCBzdGlsbC4gIEkNCj4gdGhpbmsgY2FsbCBoYml0bWFwX3Jlc2V0
KCkgd2l0aCB1bmFsaWduZWQgYm91bmRhcmllcyBnZW5lcmFsbHkgY2FsbHMgZm9yDQo+IHRyb3Vi
bGUsIGFzIEpvaG4gaGFzIGxhaWQgb3V0LiAgSWYgbWlycm9y4oCZcyBkb19zeW5jX3RhcmdldF93
cml0ZSgpIGlzDQo+IHRoZSBvbmx5IG9mZmVuZGVyIHJpZ2h0IG5vdywgDQoNCkFub3RoZXIgdGhp
bmcgaXMgbWlncmF0aW9uL2Jsb2NrLiBTaG91bGQgd2UgY2FyZSBvZiBpdCwgaXMgaXQgc3VwcG9y
dGVkIGF0IGFsbD8NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

