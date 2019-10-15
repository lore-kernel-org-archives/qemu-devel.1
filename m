Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78ACC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:17:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A32422064A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="D3YGZOtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A32422064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKPWF-0003Eq-OB
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 12:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iKPV9-0002ez-LS
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iKPV8-0005nC-5e
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:16:47 -0400
Received: from mail-eopbgr150112.outbound.protection.outlook.com
 ([40.107.15.112]:38118 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iKPV3-0005ja-KA; Tue, 15 Oct 2019 12:16:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzJFXcE+QZXNGzVkQNi6wsYeZBBS6lWY/T6ZS/X1P7AzJM1GQfTHpyvNrOlwOEvRPP4AgiXN+sCjDb6zL4o4cpAdMjIB6/rGJPzDtKTGSTlKNjhZSrSuEbithb3exyxa65xCWtj+xmkCROxiifSlZlDkghhoogMO1YJ9rzsT5mpu7HwGIjA/ujv4sqKXQiWU2NF0Yutyy4swc8M7f5woE7x33kVF2oQVT+tBc4VMDwmO5iprjZQZtihD379wp7LxPB3/R0dRIDlI1iwrM3b74zhk+qyl1dsNDG+9wdthG5i+Z6zD2JmUIoclAPYJwORLOWPBeoSTBEUlI94fqGJL0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eL90oBL9vZGz60nlHBk8RSSKPpn9LdshXPvThNnZhc=;
 b=M07joBGpsSgm4j3hrRyIhzdXTcHBMEnuPNRcgbnsMaSNB8bY8hnkWQkNzn9MVXpN1MVpYUOA8VuCs6tGb54g5RcLEP7JcPV1yyQhGbyCFwup79OVadtZmh23zR/GPHyjs4Wlz2S5o/qDPaK2TZMkbp4qYoeB4OQnF1aJ1ub8i5whSzbZMjWm+vaz3Hki1iTX4yHFS96PReInN93Qbx5rjqSic6hJizt93sPNzoxhMVTmFYcweBFhR9D6ERbBsSeQpcmYe9JNJc2Y1G1l9OrtALJDsRSX1FtYetZ8CqCUHtjCtgbNAVtIZa+jv3LNfWjuz9mg0uiulclgjPMd0CVtOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eL90oBL9vZGz60nlHBk8RSSKPpn9LdshXPvThNnZhc=;
 b=D3YGZOtIzBsJCuc/AsQSZT6FeKI6M//ZpDOKFzSqYW49aZghPYDkI5anYdgQ38zJQ2OW1uPenjCA7oBKOhD60Rd4D7E20kMH1qYEO9tqf6gpdhOboOlm2H4YTgZuVsv7UGDqqkBo2KoAKPhUFoy0qMAHVn08drKRXVkDSAaXGxQ=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3932.eurprd08.prod.outlook.com (20.179.8.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Tue, 15 Oct 2019 16:16:37 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 16:16:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 1/2] nbd: Don't send oversize strings
Thread-Topic: [PATCH v2 1/2] nbd: Don't send oversize strings
Thread-Index: AQHVf627L7i//vU7Ik+62qH8LEzEeKdVPx8AgAaWKoCAABMvgA==
Date: Tue, 15 Oct 2019 16:16:37 +0000
Message-ID: <dcdeae8f-6cb7-4f93-5fa8-aa02eb03bed7@virtuozzo.com>
References: <20191010210018.22000-1-eblake@redhat.com>
 <20191010210018.22000-2-eblake@redhat.com>
 <e777bd6b-525d-99e1-2584-a31f3609d5cd@virtuozzo.com>
 <c7ed4149-8cef-7897-ae95-9b24a3d4f378@redhat.com>
In-Reply-To: <c7ed4149-8cef-7897-ae95-9b24a3d4f378@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0048.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::34) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191015191635277
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4842063b-b7ca-414c-d9b6-08d7518b0e18
x-ms-traffictypediagnostic: DB8PR08MB3932:
x-microsoft-antispam-prvs: <DB8PR08MB3932E4B55EDCB3A6F4330CB7C1930@DB8PR08MB3932.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(39840400004)(346002)(396003)(376002)(199004)(189003)(66066001)(54906003)(36756003)(26005)(478600001)(31686004)(8676002)(7736002)(4326008)(66946007)(71190400001)(71200400001)(229853002)(6512007)(256004)(14444005)(64756008)(66556008)(386003)(66446008)(66476007)(2906002)(6506007)(86362001)(5660300002)(53546011)(102836004)(110136005)(316002)(11346002)(186003)(25786009)(76176011)(446003)(486006)(14454004)(99286004)(6486002)(3846002)(8936002)(31696002)(6246003)(2616005)(305945005)(52116002)(6436002)(476003)(6116002)(81166006)(2501003)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3932;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x5hk7GvMtZtkF9XSxHoTp95UdObjRD/QGkvB07hiT7GCqqcgWKpHSe9O988uhEHGT3uVZV0gOAQV0aAtl7pP4xYnPxNf/+JLSksSz8S+TpUMplVUj0KXf25zDT7Z1WlGDe62H56dpceA7wwIto4VkTDiQwOi3xrQPWJ2k0TghUNY2CQL0v2RBlLIJaEN8Fw9/XpuhLYYTekdueZhGfSJcv2GZjFQ+ilEvowja7Xo+8DTTfRv3dXsStaZLW1z3T3KqeXCkQhhOijpgHfjhBEkOdIgxSioD4neQJh3iIki2odGVhYX42Z8Erq0v3Y5L3R4vEQs41j9ekg/zHNrOWNXgHZyV0d7dJtB9djwFkrDBdpdhTJu4n1c+P2UjBRfRGgewAi2AChCdyAMr0NfcDWVBDax+GnI0gAy3uwdRKJJqnA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF43E863B4DB0E4383FFCC5A766BE985@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4842063b-b7ca-414c-d9b6-08d7518b0e18
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 16:16:37.7269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pdcOi9gDuCZOSs7ywoqUUkauUoLiQWkB8W4yF29qduYyJoLUImyOwXM++yraiSjIO0vp/DmMV0jxe01rya1pSrrNkJxnP5iff56Oh1SJ/Vw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3932
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.112
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTUuMTAuMjAxOSAxODowNywgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMTAvMTEvMTkgMjozMiBB
TSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDExLjEwLjIwMTkgMDow
MCwgRXJpYyBCbGFrZSB3cm90ZToNCj4+PiBRZW11IGFzIHNlcnZlciBjdXJyZW50bHkgd29uJ3Qg
YWNjZXB0IGV4cG9ydCBuYW1lcyBsYXJnZXIgdGhhbiAyNTYNCj4+PiBieXRlcywgbm9yIGNyZWF0
ZSBkaXJ0eSBiaXRtYXAgbmFtZXMgbG9uZ2VyIHRoYW4gMTAyMyBieXRlcywgc28gbW9zdA0KPj4+
IHVzZXMgb2YgcWVtdSBhcyBjbGllbnQgb3Igc2VydmVyIGhhdmUgbm8gcmVhc29uIHRvIGdldCBh
bnl3aGVyZSBuZWFyDQo+Pj4gdGhlIE5CRCBzcGVjIG1heGltdW0gb2YgYSA0ayBsaW1pdCBwZXIg
c3RyaW5nLg0KPj4+DQo+Pj4gSG93ZXZlciwgd2Ugd2VyZW4ndCBhY3R1YWxseSBlbmZvcmNpbmcg
dGhpbmdzLCBpZ25vcmluZyB3aGVuIHRoZQ0KPj4+IHJlbW90ZSBzaWRlIHZpb2xhdGVzIHRoZSBw
cm90b2NvbCBvbiBpbnB1dCwgYW5kIGFsc28gaGF2aW5nIHNldmVyYWwNCj4+PiBjb2RlIHBhdGhz
IHdoZXJlIHdlIHNlbmQgb3ZlcnNpemUgc3RyaW5ncyBvbiBvdXRwdXQgKGZvciBleGFtcGxlLA0K
Pj4+IHFlbXUtbmJkIC0tZGVzY3JpcHRpb24gY291bGQgZWFzaWx5IHNlbmQgbW9yZSB0aGFuIDRr
KS7CoCBUaWdodGVuDQo+Pj4gdGhpbmdzIHVwIGFzIGZvbGxvd3M6DQo+Pj4NCj4+PiBjbGllbnQ6
DQo+Pj4gLSBQZXJmb3JtIGJvdW5kcyBjaGVjayBvbiBleHBvcnQgbmFtZSBhbmQgZGlydHkgYml0
bWFwIHJlcXVlc3QgcHJpb3INCj4+PiDCoMKgwqAgdG8gaGFuZGluZyBpdCB0byBzZXJ2ZXINCj4+
PiAtIFZhbGlkYXRlIHRoYXQgY29waWVkIHNlcnZlciByZXBsaWVzIGFyZSBub3QgdG9vIGxvbmcg
KGlnbm9yaW5nDQo+Pj4gwqDCoMKgIE5CRF9JTkZPXyogcmVwbGllcyB0aGF0IGFyZSBub3QgY29w
aWVkIGlzIG5vdCB0b28gYmFkKQ0KPj4+IHNlcnZlcjoNCj4+PiAtIFBlcmZvcm0gYm91bmRzIGNo
ZWNrIG9uIGV4cG9ydCBuYW1lIGFuZCBkZXNjcmlwdGlvbiBwcmlvciB0bw0KPj4+IMKgwqDCoCBh
ZHZlcnRpc2luZyBpdCB0byBjbGllbnQNCj4+PiAtIFJlamVjdCBjbGllbnQgbmFtZSBvciBtZXRh
ZGF0YSBxdWVyeSB0aGF0IGlzIHRvbyBsb25nDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBFcmlj
IEJsYWtlIDxlYmxha2VAcmVkaGF0LmNvbT4NCj4+PiAtLS0NCj4gDQo+Pj4gKysrIGIvaW5jbHVk
ZS9ibG9jay9uYmQuaA0KPj4+IEBAIC0yMzIsNiArMjMyLDcgQEAgZW51bSB7DQo+Pj4gwqDCoMKg
ICogZ29pbmcgbGFyZ2VyIHdvdWxkIHJlcXVpcmUgYW4gYXVkaXQgb2YgbW9yZSBjb2RlIHRvIG1h
a2Ugc3VyZSB3ZQ0KPj4+IMKgwqDCoCAqIGFyZW4ndCBvdmVyZmxvd2luZyBzb21lIG90aGVyIGJ1
ZmZlci4gKi8NCj4+DQo+PiBUaGlzIGNvbW1lbnQgc2F5cywgdGhhdCB3ZSByZXN0cmljdCBleHBv
cnQgbmFtZSB0byAyNTYuLi4NCj4gDQo+IFllcywgYmVjYXVzZSB3ZSBzdGlsbCBzdGFjay1hbGxv
Y2F0ZSB0aGUgbmFtZSBpbiBwbGFjZXMsIGJ1dCA0ayBpcyB0b28gbGFyZ2UgZm9yIHN0YWNrIGFs
bG9jYXRpb24uwqAgQnV0IHdlJ3JlIGluY29uc2lzdGVudCBvbiB3aGVyZSB3ZSB1c2UgdGhlIHNt
YWxsZXIgMjU2LWxpbWl0OyB0aGUgc2VydmVyIHdvbid0IHNlcnZlIGFuIGltYWdlIHRoYXQgbGFy
Z2UsIGJ1dCBkb2Vzbid0IHByZXZlbnQgYSBjbGllbnQgZnJvbSByZXF1ZXN0aW5nIGEgNGsgbmFt
ZSBleHBvcnQgKGV2ZW4gdGhvdWdoIHRoYXQgZXhwb3J0IHdpbGwgbm90IGJlIHByZXNlbnQpLg0K
PiANCj4gDQo+Pj4gKysrIGIvYmxvY2tkZXYtbmJkLmMNCj4+PiBAQCAtMTYyLDYgKzE2MiwxMSBA
QCB2b2lkIHFtcF9uYmRfc2VydmVyX2FkZChjb25zdCBjaGFyICpkZXZpY2UsIGJvb2wgaGFzX25h
bWUsIGNvbnN0IGNoYXIgKm5hbWUsDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmFtZSA9IGRl
dmljZTsNCj4+PiDCoMKgwqDCoMKgwqAgfQ0KPj4+DQo+Pj4gK8KgwqDCoCBpZiAoc3RybGVuKG5h
bWUpID4gTkJEX01BWF9TVFJJTkdfU0laRSkgew0KPj4+ICvCoMKgwqDCoMKgwqDCoCBlcnJvcl9z
ZXRnKGVycnAsICJleHBvcnQgbmFtZSAnJXMnIHRvbyBsb25nIiwgbmFtZSk7DQo+Pj4gK8KgwqDC
oMKgwqDCoMKgIHJldHVybjsNCj4+PiArwqDCoMKgIH0NCj4+DQo+PiBIbW1tLCBubywgc28gaGVy
ZSB3ZSByZXN0cmljdCB0byA0MDk2LCBidXQsIHdlIHdpbGwgbm90IGFsbG93IGNsaWVudCB0byBy
ZXF1ZXN0IG1vcmUgdGhhbg0KPj4gMjU2LiBTZWVtcywgdG8gY29ycmVjdGx5IHVwZGF0ZSBzZXJ2
ZXItcGFydCwgd2Ugc2hvdWxkIGRyb3AgTkJEX01BWF9OQU1FX1NJWkUgYW5kIGRvIHRoZQ0KPj4g
YXVkaXQgbWVudGlvbmVkIGluIHRoZSBjb21tZW50IGFib3ZlIGl0cyBkZWZpbml0aW9uLg0KPiAN
Cj4gWWVhaCwgSSBndWVzcyBpdCdzIHRpbWUgdG8ganVzdCBnZXQgcmlkIG9mIE5CRF9NQVhfTkFN
RV9TSVpFLCBhbmQgbW92ZSBhd2F5IGZyb20gc3RhY2sgYWxsb2NhdGlvbnMuwqAgU2hvdWxkIEkg
ZG8gdGhhdCBhcyBhIGZvbGxvd3VwIHRvIHRoaXMgcGF0Y2gsIG9yIHNwaW4gYSB2Mz8NCg0KSG1t
LiBJdCdzIE9LIHRvby4NCg0KV2l0aA0KICAtIGZpeGVkIG1lbS1sZWFrIGluIG5iZF9wcm9jZXNz
X29wdGlvbnMNCiAgLSBzL3hfZGlydHlfYml0bWFwL3gtZGlydHktYml0bWFwIGluIG5iZF9wcm9j
ZXNzX29wdGlvbnMgaW4gZXJyb3IgbWVzc2FnZQ0KICAtIGZvbGxvd2luZyB5b3VycyBuZXcgd29y
ZGluZ3MNCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1l
bnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KSG93ZXZlciwgdGhpcyBwYXRjaCBpbnRyb2R1Y2VzIHBv
c3NpYmxlIGNyYXNoIHBvaW50LCBhc3NlcnRpbmcgb24gYml0bWFwIG5hbWUgYmVsb3csIHNvIGl0
IHdvdWxkIGJldHRlcg0KYmUgZml4ZWQgYmVmb3JlIHRoaXMgcGF0Y2ggb3IgaW1tZWRpYXRlbHkg
YWZ0ZXIgaXQuLiBTdGlsbCwgaXQncyB1bmxpa2VseSB0byBoYXZlIGEgYml0bWFwIHdpdGggbmFt
ZQ0KbG9uZ2VyIHRoYW4gNGsuLg0KDQo+IA0KPj4+ICsrKyBiL25iZC9jbGllbnQuYw0KPj4+IEBA
IC0yODksOCArMjg5LDggQEAgc3RhdGljIGludCBuYmRfcmVjZWl2ZV9saXN0KFFJT0NoYW5uZWwg
KmlvYywgY2hhciAqKm5hbWUsIGNoYXIgKipkZXNjcmlwdGlvbiwNCj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gLTE7DQo+Pj4gwqDCoMKgwqDCoMKgIH0NCj4+PiDCoMKgwqDCoMKgwqAg
bGVuIC09IHNpemVvZihuYW1lbGVuKTsNCj4+PiAtwqDCoMKgIGlmIChsZW4gPCBuYW1lbGVuKSB7
DQo+Pj4gLcKgwqDCoMKgwqDCoMKgIGVycm9yX3NldGcoZXJycCwgImluY29ycmVjdCBvcHRpb24g
bmFtZSBsZW5ndGgiKTsNCj4+PiArwqDCoMKgIGlmIChsZW4gPCBuYW1lbGVuIHx8IG5hbWVsZW4g
PiBOQkRfTUFYX1NUUklOR19TSVpFKSB7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGVycm9yX3NldGco
ZXJycCwgImluY29ycmVjdCBsaXN0IG5hbWUgbGVuZ3RoIik7DQo+Pg0KPj4gTmV3IHdvcmRpbmcg
bWFkZSBtZSBnbyBhYm92ZSBhbmQgcmVhZCB0aGUgY29tbWVudCwgd2hhdCBmdW5jdGlvbnMgZG9l
cy4gQ29tbWVudCBpcyBnb29kLCBidXQgd2l0aG91dA0KPj4gaXQsIGl0IHNvdW5kcyBsaWtlIG5h
bWUgb2YgdGhlIGxpc3QgZm9yIG1lLi4uDQo+IA0KPiBNYXliZToNCj4gDQo+IGluY29ycmVjdCBu
YW1lIGxlbmd0aCBpbiBzZXJ2ZXIncyBsaXN0IHJlc3BvbnNlDQoNClllcywgdGhpcyBpcyBiZXR0
ZXIsIHRoYW5rcw0KDQo+IA0KPj4NCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuYmRfc2VuZF9v
cHRfYWJvcnQoaW9jKTsNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLTE7DQo+Pj4g
wqDCoMKgwqDCoMKgIH0NCj4+PiBAQCAtMzAzLDYgKzMwMywxMSBAQCBzdGF0aWMgaW50IG5iZF9y
ZWNlaXZlX2xpc3QoUUlPQ2hhbm5lbCAqaW9jLCBjaGFyICoqbmFtZSwgY2hhciAqKmRlc2NyaXB0
aW9uLA0KPj4+IMKgwqDCoMKgwqDCoCBsb2NhbF9uYW1lW25hbWVsZW5dID0gJ1wwJzsNCj4+PiDC
oMKgwqDCoMKgwqAgbGVuIC09IG5hbWVsZW47DQo+Pj4gwqDCoMKgwqDCoMKgIGlmIChsZW4pIHsN
Cj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKGxlbiA+IE5CRF9NQVhfU1RSSU5HX1NJWkUpIHsNCj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlcnJvcl9zZXRnKGVycnAsICJpbmNvcnJlY3QgbGlz
dCBkZXNjcmlwdGlvbiBsZW5ndGgiKTsNCj4gDQo+IGFuZA0KPiANCj4gaW5jb3JyZWN0IGRlc2Ny
aXB0aW9uIGxlbmd0aCBpbiBzZXJ2ZXIncyBsaXN0IHJlc3BvbnNlDQo+IA0KPiANCj4+PiBAQCAt
NjQ4LDYgKzY1Nyw3IEBAIHN0YXRpYyBpbnQgbmJkX3NlbmRfbWV0YV9xdWVyeShRSU9DaGFubmVs
ICppb2MsIHVpbnQzMl90IG9wdCwNCj4+PiDCoMKgwqDCoMKgwqAgaWYgKHF1ZXJ5KSB7DQo+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcXVlcnlfbGVuID0gc3RybGVuKHF1ZXJ5KTsNCj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBkYXRhX2xlbiArPSBzaXplb2YocXVlcnlfbGVuKSArIHF1ZXJ5X2xl
bjsNCj4+PiArwqDCoMKgwqDCoMKgwqAgYXNzZXJ0KHF1ZXJ5X2xlbiA8PSBOQkRfTUFYX1NUUklO
R19TSVpFKTsNCj4+PiDCoMKgwqDCoMKgwqAgfSBlbHNlIHsNCj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBhc3NlcnQob3B0ID09IE5CRF9PUFRfTElTVF9NRVRBX0NPTlRFWFQpOw0KPj4+IMKgwqDC
oMKgwqDCoCB9DQo+Pg0KPj4geW91IG1heSBhc3NlcnQgZXhwb3J0X2xlbiBhcyB3ZWxsLi4NCj4g
DQo+IEl0IHdhcyBhc3NlcnRlZCBlYXJsaWVyLCBidXQgZG9pbmcgaXQgYWdhaW4gbWlnaHQgbm90
IGh1cnQsIGVzcGVjaWFsbHkgaWYgSSBkbyB0aGUgZm9sbG93dXAgcGF0Y2ggZ2V0dGluZyByaWQg
b2YgTkJEX01BWF9OQU1FX1NJWkUNCj4gDQo+IA0KPj4+IEBAIC0xNTYxLDYgKzE1NjksOCBAQCBO
QkRFeHBvcnQgKm5iZF9leHBvcnRfbmV3KEJsb2NrRHJpdmVyU3RhdGUgKmJzLCB1aW50NjRfdCBk
ZXZfb2Zmc2V0LA0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIGV4cC0+ZXhwb3J0X2JpdG1hcCA9
IGJtOw0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIGV4cC0+ZXhwb3J0X2JpdG1hcF9jb250ZXh0
ID0gZ19zdHJkdXBfcHJpbnRmKCJxZW11OmRpcnR5LWJpdG1hcDolcyIsDQo+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYml0bWFwKTsNCj4+
PiArwqDCoMKgwqDCoMKgwqAgLyogU2VlIEJNRV9NQVhfTkFNRV9TSVpFIGluIGJsb2NrL3Fjb3cy
LWJpdG1hcC5jICovDQo+Pg0KPj4gSG1tLiBCTUVfTUFYX05BTUVfU0laRSBpcyBjaGVja2VkIG9u
bHkgd2hlbiBjcmVhdGluZyBwZXJzaXN0ZW50IGJpdG1hcHMuIEJ1dCBmb3Igbm9uLXBlcnNpc3Rl
bnQNCj4+IG5hbWUgbGVuZ3RoIGlzIGFjdHVhbGx5IHVubGltaXRlZC4gU28sIHdlIHNob3VsZCBl
aXRoZXIgbGltaXQgYWxsIGJpdG1hcCBuYW1lcyB0byAxMDIzIChob3BlLA0KPj4gdGhpcyB3aWxs
IG5vdCBicmVhayBleGlzdGluZyBzY2VuYXJpb3MpIG9yIGVycm9yIG91dCBoZXJlIChvciBlYXJs
aWVyKSBpbnN0ZWFkIG9mIGFzc2VydGlvbi4NCj4gDQo+IEknbSBsZWFuaW5nIHRvd2FyZHMgbGlt
aXRpbmcgQUxMIGJpdG1hcHMgdG8gdGhlIHNhbWUgbGVuZ3RoIChhcyB3ZSd2ZSBhbHJlYWR5IGRl
YmF0ZWQgdGhlIGlkZWEgb2YgYmVpbmcgYWJsZSB0byBjb252ZXJ0IGFuIGV4aXN0aW5nIGJpdG1h
cCBmcm9tIHRyYW5zaWVudCB0byBwZXJzaXN0ZW50KS4NCg0KQWdyZWVkLCBidXQgLi4NCg0KPiAN
Cj4+DQo+PiBXZSBhbHNvIG1heSB3YW50IFFFTVVfQlVJTERfQlVHX09OKE5CRF9NQVhfU1RSSU5H
X1NJWkUgPCBCTUVfTUFYX05BTUVfU0laRSArIHNpemVvZigicWVtdTpkaXJ0eS1iaXRtYXA6Iikg
LSAxKQ0KPiANCj4gRXhjZXB0IHRoYXQgQk1FX01BWF9OQU1FX1NJWkUgaXMgbm90IChjdXJyZW50
bHkpIGluIGEgcHVibGljIC5oIGZpbGUuDQo+IA0KDQouLiBJIHRoaW5rLCB0aGFuIGl0IHNob3Vs
ZCBiZSBuZXcgQkxPQ0tfRElSVFlfQklUTUFQX01BWF9OQU1FX1NJWkUuLiBBbmQgd2UnbGwgaGF2
ZSB0byBub3RlIGl0IGluIHFhcGkgZG9jLi4NClNob3VsZCB0aGlzIGNoYW5nZSBnbyB0aHJvdWdo
IGRlcHJlY2F0aW9uPyBPciB3ZSBjb25zaWRlciBub24tcGVyc2lzdGVudCBiaXRtYXBzIGFzIHNv
bWV0aGluZyBub3QgcmVhbGx5IHVzZWZ1bD8NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1p
cg0K

