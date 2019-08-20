Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D27C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 08:57:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F12122DCB
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 08:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uCP4kwP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F12122DCB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzzxR-0002j2-Ez
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 04:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hzzwi-0002EO-1M
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 04:56:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hzzwg-0003W6-Kl
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 04:56:51 -0400
Received: from mail-eopbgr60137.outbound.protection.outlook.com
 ([40.107.6.137]:25827 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hzzwc-0003Jw-7d; Tue, 20 Aug 2019 04:56:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VO+vq95sFA6afvoqYnolQ/CDCsEsce2AQ/oyXZLlbsEwXwyocPicLyfT/pev9AMKb7dbF0lKcLa/MCqLRWAiuGcHVzTB+wirEYb/Xw/k7hO9hJRDaBFF3grPvXwVnbhiEpleVoZvfp3Zx75M+BTu2ncC2DsTC571+7SVIoSn5l/vfbs86TfhREwES2JecPEcjR/Rd+kUghkU2yfUmlIZR8ifPeYo8aozqZOGm45Z1iajKCjj8UHcIEjRmmXSrpyQU2o4wbomcfX9CS6AsEPPKA95egaw6d6Mw96EE+CDf1fP3wBHovJbvpvIxXFWHi1ScwWSEFaEEZwGhUYNJS5vVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pihdkxHwMMcVdiwLIc/EpTqt/H2RPKv2TyjaZ14FhcU=;
 b=YhQr688cdQX33Rufl9v6HiwzW+RUnrPYDXgrUtkOkJUaTdils4Dd9Oabu3Ainbw1hi8kNVv7YohizAc0REbzt1cGhSuxs36yA4f8ELj8HJ3tXjpNad79rpoelB/Dum3vSW/qLNt03w+elf2KoXEMsDJneu6B+bMogesvM2tRODNnXyoIzaIjGKmzvo/z1YzcNs/d6YqVwUNqeCxKcL2XYZWhyGruiFBkjl1d4/DZPRGL4YJbaedhLi2oct1lpdQiv0FQfU8t1Wq776YOzqUIUo6rebgWeOdYconyQBDzVq6P/LRwOMesD7QM5JqSldpCSSl99sjRPEQ6VzVjX/SfwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pihdkxHwMMcVdiwLIc/EpTqt/H2RPKv2TyjaZ14FhcU=;
 b=uCP4kwP/u8Apc0u7ldVugqqdhQPwFjGAdu7APNzPGpQ8eMRGdt/u318ftqyH0PwMpacFJ9m9MCtqCnWy+sq3PgI/nm1v9yxPRo22vjaqpXw7WnwdFiXGEUFPE870nMqHmLyY+2M/jAYVwqajk6DUAnfJS0CYES7hBAU4q85HXfg=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3993.eurprd08.prod.outlook.com (20.179.11.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 08:56:43 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 08:56:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH] nbd: Tolerate more errors to structured reply request
Thread-Index: AQHVVreiabMNJQKTOEeEDDtQ7ajuhKcDvO6A
Date: Tue, 20 Aug 2019 08:56:43 +0000
Message-ID: <53e4c758-e76c-b422-b34d-e6de9773b286@virtuozzo.com>
References: <20190819175751.18075-1-eblake@redhat.com>
In-Reply-To: <20190819175751.18075-1-eblake@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0025.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::11) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190820115641690
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 012b106c-c5e2-4e04-b95a-08d7254c52db
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB3993; 
x-ms-traffictypediagnostic: DB8PR08MB3993:
x-microsoft-antispam-prvs: <DB8PR08MB3993B9B452ABC80207EB6285C1AB0@DB8PR08MB3993.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:288;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(376002)(346002)(136003)(39840400004)(199004)(189003)(14454004)(31686004)(476003)(6486002)(25786009)(4326008)(446003)(2616005)(11346002)(305945005)(7736002)(229853002)(71200400001)(71190400001)(486006)(478600001)(6436002)(2501003)(6506007)(386003)(102836004)(8676002)(110136005)(54906003)(6116002)(52116002)(36756003)(76176011)(86362001)(31696002)(99286004)(66556008)(64756008)(66946007)(66446008)(66476007)(6246003)(66066001)(6512007)(316002)(81166006)(2906002)(53936002)(256004)(81156014)(14444005)(5660300002)(8936002)(26005)(186003)(3846002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3993;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Uvw1osCsDvRChVEC7nxpaTiR8w3k4qUcrpKC1Oymoa7q182a4cXKMGSnCHPTVZyYXbropS5Dpcb2ypP+xMJl2flSox+vcpVXTf3zgAzxB7KRTySZRLO4LJLNK1rTd3rtyiwOqFdrrclipJbtVMGKmW6RFNqINrx3laVCCDBGgBN1W3EX6dE8KpoMRPgNEZ1KU/vi4ssdByIObLmMrClNmSiKXcLvaRxy5kkMFEKHfEVULfoC6M0rCFxZdohjB7UXMSwf3Qbi8FwxBbXmWIzCEwXp/hJWCQNUyBvgMOeN7ZXlkGw9kHChgMGf5NWg8hUz/N8L1pCIeL5/D2gJuFl3040zL01LAPxBLz5jAZSjuR9MHYxTpcUjO/3mkmeN8+fIhWCGG2ELjIRSKjijWAzybz6RZnSIAlgFLWyrvqNvYWI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E52585278686646ACD3EE115A3549E1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 012b106c-c5e2-4e04-b95a-08d7254c52db
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 08:56:43.5689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ni0FIAyR8AYe4U7t/BlNUMDwgBlCBop/m5IaJyLjQNelLrxYBQ/GrwmNqtUlxiIKxWBvKjw+Cn9T2oI3JY35sAKOYOtAALyrCXjf1k/hqx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3993
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.137
Subject: Re: [Qemu-devel] [PATCH] nbd: Tolerate more errors to structured
 reply request
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
Cc: "rjones@redhat.com" <rjones@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMDguMjAxOSAyMDo1NywgRXJpYyBCbGFrZSB3cm90ZToNCj4gQSBzZXJ2ZXIgbWF5IGhhdmUg
YSByZWFzb24gdG8gcmVqZWN0IGEgcmVxdWVzdCBmb3Igc3RydWN0dXJlZCByZXBsaWVzLA0KPiBi
ZXlvbmQganVzdCBub3QgcmVjb2duaXppbmcgdGhlbSBhcyBhIHZhbGlkIHJlcXVlc3QuICBJdCBk
b2Vzbid0IGh1cnQNCj4gdXMgdG8gY29udGludWUgdGFsa2luZyB0byBzdWNoIGEgc2VydmVyOyBv
dGhlcndpc2UgJ3FlbXUtbmJkIC0tbGlzdCcNCj4gb2Ygc3VjaCBhIHNlcnZlciBmYWlscyB0byBk
aXNwbGF5IGFsbCBwb3NzaWJsZSBkZXRhaWxzIGFib3V0IHRoZQ0KPiBleHBvcnQuDQo+IA0KPiBF
bmNvdW50ZXJlZCB3aGVuIHRlbXBvcmFyaWx5IHR3ZWFraW5nIG5iZGtpdCB0byByZXBseSB3aXRo
DQo+IE5CRF9SRVBfRVJSX1BPTElDWS4gIFByZXNlbnQgc2luY2Ugc3RydWN0dXJlZCByZXBseSBz
dXBwb3J0IHdhcyBmaXJzdA0KPiBhZGRlZCAoY29tbWl0IGQ3OTUyOTliIHJldXNlZCBzdGFydHRs
cyBoYW5kbGluZywgYnV0IHN0YXJ0dGxzIGhhcyB0bw0KPiByZWplY3QgYWxsIGVycm9ycykuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBFcmljIEJsYWtlIDxlYmxha2VAcmVkaGF0LmNvbT4NCj4gLS0t
DQo+ICAgbmJkL2NsaWVudC5jIHwgMzkgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25iZC9jbGllbnQuYyBiL25iZC9jbGllbnQuYw0KPiBp
bmRleCA4ZjUyNGMzZTM1MDIuLjIwNGY2ZTkyOGQxNCAxMDA2NDQNCj4gLS0tIGEvbmJkL2NsaWVu
dC5jDQo+ICsrKyBiL25iZC9jbGllbnQuYw0KPiBAQCAtMSw1ICsxLDUgQEANCj4gICAvKg0KPiAt
ICogIENvcHlyaWdodCAoQykgMjAxNi0yMDE4IFJlZCBIYXQsIEluYy4NCj4gKyAqICBDb3B5cmln
aHQgKEMpIDIwMTYtMjAxOSBSZWQgSGF0LCBJbmMuDQo+ICAgICogIENvcHlyaWdodCAoQykgMjAw
NSAgQW50aG9ueSBMaWd1b3JpIDxhbnRob255QGNvZGVtb25rZXkud3M+DQo+ICAgICoNCj4gICAg
KiAgTmV0d29yayBCbG9jayBEZXZpY2UgQ2xpZW50IFNpZGUNCj4gQEAgLTE0MSwxNyArMTQxLDE5
IEBAIHN0YXRpYyBpbnQgbmJkX3JlY2VpdmVfb3B0aW9uX3JlcGx5KFFJT0NoYW5uZWwgKmlvYywg
dWludDMyX3Qgb3B0LA0KPiAgICAgICByZXR1cm4gMDsNCj4gICB9DQo+IA0KPiAtLyogSWYgcmVw
bHkgcmVwcmVzZW50cyBzdWNjZXNzLCByZXR1cm4gMSB3aXRob3V0IGZ1cnRoZXIgYWN0aW9uLg0K
PiAtICogSWYgcmVwbHkgcmVwcmVzZW50cyBhbiBlcnJvciwgY29uc3VtZSB0aGUgb3B0aW9uYWwg
cGF5bG9hZCBvZg0KPiAtICogdGhlIHBhY2tldCBvbiBpb2MuICBUaGVuIHJldHVybiAwIGZvciB1
bnN1cHBvcnRlZCAoc28gdGhlIGNsaWVudA0KPiAtICogY2FuIGZhbGwgYmFjayB0byBvdGhlciBh
cHByb2FjaGVzKSwgb3IgLTEgd2l0aCBlcnJwIHNldCBmb3Igb3RoZXINCj4gLSAqIGVycm9ycy4N
Cj4gKy8qDQo+ICsgKiBJZiByZXBseSByZXByZXNlbnRzIHN1Y2Nlc3MsIHJldHVybiAxIHdpdGhv
dXQgZnVydGhlciBhY3Rpb24uICBJZg0KPiArICogcmVwbHkgcmVwcmVzZW50cyBhbiBlcnJvciwg
Y29uc3VtZSB0aGUgb3B0aW9uYWwgcGF5bG9hZCBvZiB0aGUNCj4gKyAqIHBhY2tldCBvbiBpb2Mu
ICBUaGVuIHJldHVybiAwIGZvciB1bnN1cHBvcnRlZCAoc28gdGhlIGNsaWVudCBjYW4NCj4gKyAq
IGZhbGwgYmFjayB0byBvdGhlciBhcHByb2FjaGVzKSwgd2hlcmUgQHN0cmljdCBkZXRlcm1pbmVz
IGlmIG9ubHkNCj4gKyAqIEVSUl9VTlNVUCBvciBhbGwgZXJyb3JzIGZpdCB0aGF0IGNhdGVnb3J5
LCBvciAtMSB3aXRoIGVycnAgc2V0IGZvcg0KDQpobW0gbm90IGFsbCBidXQgImVycm9ycyByZXR1
cm5lZCBieSBzZXJ2ZXIgYWNjb3JkaW5nbHkgdG8gcHJvdG9jb2wiLCBhcyAiYWxsIg0KYSBiaXQg
aW4gY29udHJhc3Qgd2l0aCBmb2xsb3dpbmcgInJlc3VsdCA9IC0xIiwgYnV0IGl0J3MgT0sgYXMg
aXMgYW55d2F5Og0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8
dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQo+ICsgKiBvdGhlciBlcnJvcnMuDQo+ICAgICov
DQo+ICAgc3RhdGljIGludCBuYmRfaGFuZGxlX3JlcGx5X2VycihRSU9DaGFubmVsICppb2MsIE5C
RE9wdGlvblJlcGx5ICpyZXBseSwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
RXJyb3IgKiplcnJwKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIHN0
cmljdCwgRXJyb3IgKiplcnJwKQ0KPiAgIHsNCj4gICAgICAgY2hhciAqbXNnID0gTlVMTDsNCj4g
LSAgICBpbnQgcmVzdWx0ID0gLTE7DQo+ICsgICAgaW50IHJlc3VsdCA9IHN0cmljdCA/IC0xIDog
MDsNCj4gDQo+ICAgICAgIGlmICghKHJlcGx5LT50eXBlICYgKDEgPDwgMzEpKSkgew0KPiAgICAg
ICAgICAgcmV0dXJuIDE7DQo+IEBAIC0xNjIsNiArMTY0LDcgQEAgc3RhdGljIGludCBuYmRfaGFu
ZGxlX3JlcGx5X2VycihRSU9DaGFubmVsICppb2MsIE5CRE9wdGlvblJlcGx5ICpyZXBseSwNCj4g
ICAgICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJzZXJ2ZXIgZXJyb3IgJSIgUFJJdTMyDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAiICglcykgbWVzc2FnZSBpcyB0b28gbG9uZyIsDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICByZXBseS0+dHlwZSwgbmJkX3JlcF9sb29rdXAocmVw
bHktPnR5cGUpKTsNCj4gKyAgICAgICAgICAgIHJlc3VsdCA9IC0xOw0KPiAgICAgICAgICAgICAg
IGdvdG8gY2xlYW51cDsNCj4gICAgICAgICAgIH0NCj4gICAgICAgICAgIG1zZyA9IGdfbWFsbG9j
KHJlcGx5LT5sZW5ndGggKyAxKTsNCj4gQEAgLTE2OSw2ICsxNzIsNyBAQCBzdGF0aWMgaW50IG5i
ZF9oYW5kbGVfcmVwbHlfZXJyKFFJT0NoYW5uZWwgKmlvYywgTkJET3B0aW9uUmVwbHkgKnJlcGx5
LA0KPiAgICAgICAgICAgICAgIGVycm9yX3ByZXBlbmQoZXJycCwgIkZhaWxlZCB0byByZWFkIG9w
dGlvbiBlcnJvciAlIiBQUkl1MzINCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICIgKCVz
KSBtZXNzYWdlOiAiLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVwbHktPnR5cGUs
IG5iZF9yZXBfbG9va3VwKHJlcGx5LT50eXBlKSk7DQo+ICsgICAgICAgICAgICByZXN1bHQgPSAt
MTsNCj4gICAgICAgICAgICAgICBnb3RvIGNsZWFudXA7DQo+ICAgICAgICAgICB9DQo+ICAgICAg
ICAgICBtc2dbcmVwbHktPmxlbmd0aF0gPSAnXDAnOw0KPiBAQCAtMjU3LDcgKzI2MSw3IEBAIHN0
YXRpYyBpbnQgbmJkX3JlY2VpdmVfbGlzdChRSU9DaGFubmVsICppb2MsIGNoYXIgKipuYW1lLCBj
aGFyICoqZGVzY3JpcHRpb24sDQo+ICAgICAgIGlmIChuYmRfcmVjZWl2ZV9vcHRpb25fcmVwbHko
aW9jLCBOQkRfT1BUX0xJU1QsICZyZXBseSwgZXJycCkgPCAwKSB7DQo+ICAgICAgICAgICByZXR1
cm4gLTE7DQo+ICAgICAgIH0NCj4gLSAgICBlcnJvciA9IG5iZF9oYW5kbGVfcmVwbHlfZXJyKGlv
YywgJnJlcGx5LCBlcnJwKTsNCj4gKyAgICBlcnJvciA9IG5iZF9oYW5kbGVfcmVwbHlfZXJyKGlv
YywgJnJlcGx5LCB0cnVlLCBlcnJwKTsNCj4gICAgICAgaWYgKGVycm9yIDw9IDApIHsNCj4gICAg
ICAgICAgIHJldHVybiBlcnJvcjsNCj4gICAgICAgfQ0KPiBAQCAtMzcwLDcgKzM3NCw3IEBAIHN0
YXRpYyBpbnQgbmJkX29wdF9pbmZvX29yX2dvKFFJT0NoYW5uZWwgKmlvYywgdWludDMyX3Qgb3B0
LA0KPiAgICAgICAgICAgaWYgKG5iZF9yZWNlaXZlX29wdGlvbl9yZXBseShpb2MsIG9wdCwgJnJl
cGx5LCBlcnJwKSA8IDApIHsNCj4gICAgICAgICAgICAgICByZXR1cm4gLTE7DQo+ICAgICAgICAg
ICB9DQo+IC0gICAgICAgIGVycm9yID0gbmJkX2hhbmRsZV9yZXBseV9lcnIoaW9jLCAmcmVwbHks
IGVycnApOw0KPiArICAgICAgICBlcnJvciA9IG5iZF9oYW5kbGVfcmVwbHlfZXJyKGlvYywgJnJl
cGx5LCB0cnVlLCBlcnJwKTsNCj4gICAgICAgICAgIGlmIChlcnJvciA8PSAwKSB7DQo+ICAgICAg
ICAgICAgICAgcmV0dXJuIGVycm9yOw0KPiAgICAgICAgICAgfQ0KPiBAQCAtNTQ1LDEyICs1NDks
MTUgQEAgc3RhdGljIGludCBuYmRfcmVjZWl2ZV9xdWVyeV9leHBvcnRzKFFJT0NoYW5uZWwgKmlv
YywNCj4gICAgICAgfQ0KPiAgIH0NCj4gDQo+IC0vKiBuYmRfcmVxdWVzdF9zaW1wbGVfb3B0aW9u
OiBTZW5kIGFuIG9wdGlvbiByZXF1ZXN0LCBhbmQgcGFyc2UgdGhlIHJlcGx5DQo+ICsvKg0KPiAr
ICogbmJkX3JlcXVlc3Rfc2ltcGxlX29wdGlvbjogU2VuZCBhbiBvcHRpb24gcmVxdWVzdCwgYW5k
IHBhcnNlIHRoZSByZXBseS4NCj4gKyAqIEBzdHJpY3QgY29udHJvbHMgd2hldGhlciBFUlJfVU5T
VVAgb3IgYWxsIGVycm9ycyBwcm9kdWNlIDAgc3RhdHVzLg0KPiAgICAqIHJldHVybiAxIGZvciBz
dWNjZXNzZnVsIG5lZ290aWF0aW9uLA0KPiAgICAqICAgICAgICAwIGlmIG9wZXJhdGlvbiBpcyB1
bnN1cHBvcnRlZCwNCj4gICAgKiAgICAgICAgLTEgd2l0aCBlcnJwIHNldCBmb3IgYW55IG90aGVy
IGVycm9yDQo+ICAgICovDQo+IC1zdGF0aWMgaW50IG5iZF9yZXF1ZXN0X3NpbXBsZV9vcHRpb24o
UUlPQ2hhbm5lbCAqaW9jLCBpbnQgb3B0LCBFcnJvciAqKmVycnApDQo+ICtzdGF0aWMgaW50IG5i
ZF9yZXF1ZXN0X3NpbXBsZV9vcHRpb24oUUlPQ2hhbm5lbCAqaW9jLCBpbnQgb3B0LCBib29sIHN0
cmljdCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVy
cnApDQo+ICAgew0KPiAgICAgICBOQkRPcHRpb25SZXBseSByZXBseTsNCj4gICAgICAgaW50IGVy
cm9yOw0KPiBAQCAtNTYyLDcgKzU2OSw3IEBAIHN0YXRpYyBpbnQgbmJkX3JlcXVlc3Rfc2ltcGxl
X29wdGlvbihRSU9DaGFubmVsICppb2MsIGludCBvcHQsIEVycm9yICoqZXJycCkNCj4gICAgICAg
aWYgKG5iZF9yZWNlaXZlX29wdGlvbl9yZXBseShpb2MsIG9wdCwgJnJlcGx5LCBlcnJwKSA8IDAp
IHsNCj4gICAgICAgICAgIHJldHVybiAtMTsNCj4gICAgICAgfQ0KPiAtICAgIGVycm9yID0gbmJk
X2hhbmRsZV9yZXBseV9lcnIoaW9jLCAmcmVwbHksIGVycnApOw0KPiArICAgIGVycm9yID0gbmJk
X2hhbmRsZV9yZXBseV9lcnIoaW9jLCAmcmVwbHksIHN0cmljdCwgZXJycCk7DQo+ICAgICAgIGlm
IChlcnJvciA8PSAwKSB7DQo+ICAgICAgICAgICByZXR1cm4gZXJyb3I7DQo+ICAgICAgIH0NCj4g
QEAgLTU5NCw3ICs2MDEsNyBAQCBzdGF0aWMgUUlPQ2hhbm5lbCAqbmJkX3JlY2VpdmVfc3RhcnR0
bHMoUUlPQ2hhbm5lbCAqaW9jLA0KPiAgICAgICBRSU9DaGFubmVsVExTICp0aW9jOw0KPiAgICAg
ICBzdHJ1Y3QgTkJEVExTSGFuZHNoYWtlRGF0YSBkYXRhID0geyAwIH07DQo+IA0KPiAtICAgIHJl
dCA9IG5iZF9yZXF1ZXN0X3NpbXBsZV9vcHRpb24oaW9jLCBOQkRfT1BUX1NUQVJUVExTLCBlcnJw
KTsNCj4gKyAgICByZXQgPSBuYmRfcmVxdWVzdF9zaW1wbGVfb3B0aW9uKGlvYywgTkJEX09QVF9T
VEFSVFRMUywgdHJ1ZSwgZXJycCk7DQo+ICAgICAgIGlmIChyZXQgPD0gMCkgew0KPiAgICAgICAg
ICAgaWYgKHJldCA9PSAwKSB7DQo+ICAgICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiU2Vy
dmVyIGRvbid0IHN1cHBvcnQgU1RBUlRUTFMgb3B0aW9uIik7DQo+IEBAIC02OTQsNyArNzAxLDcg
QEAgc3RhdGljIGludCBuYmRfcmVjZWl2ZV9vbmVfbWV0YV9jb250ZXh0KFFJT0NoYW5uZWwgKmlv
YywNCj4gICAgICAgICAgIHJldHVybiAtMTsNCj4gICAgICAgfQ0KPiANCj4gLSAgICByZXQgPSBu
YmRfaGFuZGxlX3JlcGx5X2Vycihpb2MsICZyZXBseSwgZXJycCk7DQo+ICsgICAgcmV0ID0gbmJk
X2hhbmRsZV9yZXBseV9lcnIoaW9jLCAmcmVwbHksIHRydWUsIGVycnApOw0KPiAgICAgICBpZiAo
cmV0IDw9IDApIHsNCj4gICAgICAgICAgIHJldHVybiByZXQ7DQo+ICAgICAgIH0NCj4gQEAgLTk1
MCw3ICs5NTcsNyBAQCBzdGF0aWMgaW50IG5iZF9zdGFydF9uZWdvdGlhdGUoQWlvQ29udGV4dCAq
YWlvX2NvbnRleHQsIFFJT0NoYW5uZWwgKmlvYywNCj4gICAgICAgICAgICAgICBpZiAoc3RydWN0
dXJlZF9yZXBseSkgew0KPiAgICAgICAgICAgICAgICAgICByZXN1bHQgPSBuYmRfcmVxdWVzdF9z
aW1wbGVfb3B0aW9uKGlvYywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBOQkRfT1BUX1NUUlVDVFVSRURfUkVQTFksDQo+IC0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlcnJwKTsNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZhbHNlLCBlcnJw
KTsNCj4gICAgICAgICAgICAgICAgICAgaWYgKHJlc3VsdCA8IDApIHsNCj4gICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiAgICAgICAgICAgICAgICAgICB9DQo+IA0KDQoN
Ci0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

