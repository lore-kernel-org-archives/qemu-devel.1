Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1FCC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:02:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2FF522CF4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DdfyQjoI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2FF522CF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0OOA-00078q-Np
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 07:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1i0OMW-0006Fd-UQ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1i0OMP-0003tk-Pi
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:01:07 -0400
Received: from mail-ve1eur02on070a.outbound.protection.outlook.com
 ([2a01:111:f400:fe06::70a]:40386
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
 id 1i0OMO-0003pv-H2; Wed, 21 Aug 2019 07:01:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVyC8kqREUnbGdn4UkXjKWP0VjV2WTQJ/EjRWAsP7DI40trzSzvc+QwdpWemBjCgTiWFxYb1iJ+vZBUt3A5SHQ2DhWl2YcL6qSP/lJwySMi/HDAP3J+PmYbDwm2yhVH0f6LIPm+x0duBMebtW2Ebdk5q8SFGWdeZXF4Esbp6/epTZcaxw82OzjKVs3S7Mricfp+2crHUVKYeKdG4D6rwyDeJouwBQ2M9S849p/0eAkRY180QIPxub8bl6HH8h87s6WcDP8HsO1D7O8AN+Kom+3ZC8cBwfndaXgb92yi4aFWwCChjO77oLbEhHHiSk7v09Gq7bCU/uwc48B8a9iX4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnD2rI6mfKdQEx8Uwab4k7HAW/nzGQbSpOtImTXOwz8=;
 b=PkUo4fwULtk7AJGyVbBITm7AF2TP+sWJhK+JtTvTcOoMeARCXecGCw+pK3J9+wr1EeD2YECXl9gAhRI3qWQubkbQm/x0XSMBacIlUBkvv5W9JIXItSw6YYM6m8BMxnCtjYtSMpaeSaGHbtdxpssJmAQQfi+DiPsAp9Gsuwx8TPSzC9RNCgOPVSY2QsNFyfiFMi7IDjBjX8TZ1P9d1xaIReLG9Kwb5g4egK1eyLMCGc3wEV/xUhcHgJEXDLlHjXf3Xkm1csRhEtzULcLc4dsN9gbgqBklLRSmT7Ds00QPFHQH6druIJp171WG6zHgJX9J90qyj/zQ5zLb4Xt01lOlBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnD2rI6mfKdQEx8Uwab4k7HAW/nzGQbSpOtImTXOwz8=;
 b=DdfyQjoINtNpA6HdV6PiqbeQCBwaZkGsylJ6ln7hV7JcFKmXqazZzjJTg2gknjbKwu+K3HNuLyYPsqDYbOFVxNzKPBiBqwRmJEv+ic5kbnmc0aoECPtaSJXnafoAKHtCIIzPjTUKKFJmPDDJttMhm/HvGoLx0NyWdShFkamU8SU=
Received: from AM6PR08MB5208.eurprd08.prod.outlook.com (10.255.122.155) by
 AM6PR08MB3128.eurprd08.prod.outlook.com (52.135.163.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 11:00:53 +0000
Received: from AM6PR08MB5208.eurprd08.prod.outlook.com
 ([fe80::5820:8ce:9eb2:cc42]) by AM6PR08MB5208.eurprd08.prod.outlook.com
 ([fe80::5820:8ce:9eb2:cc42%3]) with mapi id 15.20.2178.018; Wed, 21 Aug 2019
 11:00:53 +0000
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v8 9/9] qapi: query-blockstat: add driver specific
 file-posix stats
Thread-Index: AQHVC/RUe8c1xWymNEa1To8CIBQlnKb4aaeAgA2d0gA=
Date: Wed, 21 Aug 2019 11:00:52 +0000
Message-ID: <fa4859e0-2418-8171-10c4-e1c908567dad@virtuozzo.com>
References: <20190516143314.81302-1-anton.nefedov@virtuozzo.com>
 <20190516143314.81302-10-anton.nefedov@virtuozzo.com>
 <9280c26d-13c4-7fad-dc15-ff799c5284e3@redhat.com>
In-Reply-To: <9280c26d-13c4-7fad-dc15-ff799c5284e3@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0034.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::23) To AM6PR08MB5208.eurprd08.prod.outlook.com
 (2603:10a6:20b:eb::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anton.nefedov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8cf7ab66-b536-4e0b-ddce-08d72626d500
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM6PR08MB3128; 
x-ms-traffictypediagnostic: AM6PR08MB3128:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB31289CBBF1F6E65E84F6B305F8AA0@AM6PR08MB3128.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(346002)(366004)(39850400004)(396003)(52314003)(189003)(199004)(99286004)(71190400001)(31696002)(36756003)(86362001)(305945005)(4326008)(2501003)(6246003)(316002)(7736002)(31686004)(25786009)(6116002)(8676002)(81156014)(66476007)(66556008)(64756008)(66446008)(66946007)(53936002)(8936002)(81166006)(107886003)(11346002)(44832011)(3846002)(2616005)(486006)(476003)(6486002)(229853002)(14454004)(110136005)(54906003)(256004)(14444005)(446003)(186003)(76176011)(52116002)(6512007)(66066001)(386003)(102836004)(6506007)(53546011)(26005)(71200400001)(2906002)(5660300002)(478600001)(6436002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3128;
 H:AM6PR08MB5208.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Z/NHEjcs8NcsAOUkw4SP2/Mfud86cKtdr9otYV6DThWMrGNfVBwRlOA3M06monPGGB4DGrViqRrbFSyr3rOwtW/y3pd0NffJsAfB9jpEV/kgG2eg758UEWvtTwGS9cOvCfIu4+MPWbe7k7KkV/cP5sWtkgogdNG/jq/5dVJ6/ZHd/NmQ1cuILXNLf2dwNfpY6T81CKje7Yr9lRCmO9CYf24eMBS+gZKtNmyH/K+oWRjp0BuaBj9Z1lAdTTOjmOS8lc09fJEd026wqcw3MJtUcd8wPUgJrZPX2Xzx4Q0USFH4cU6jgJA8O1JqXOWYp9/VCYJjB//KWgxUDrCWgoUBFhkJkQacax+3GQVDznZYVICOEmVkcnrEeGrWa+9I6Lht9BBYWHjeR6dwN+jpmEPbUcYCrES6gCAXd/cXXBtFpUg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1034027DFF759E42904A571A71C767F0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf7ab66-b536-4e0b-ddce-08d72626d500
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 11:00:53.3273 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XAfclE9Zjgh5MlLTSLCrptnySMbTud8cP968kum0uCwdKgiMqWMFWqtjDbf2tdQOFctvPBbUCy7k+reVZXmm6PxS6WEVAyad3w/dY9UG/Z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3128
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe06::70a
Subject: Re: [Qemu-devel] [PATCH v8 9/9] qapi: query-blockstat: add driver
 specific file-posix stats
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMTIvOC8yMDE5IDEwOjA0IFBNLCBNYXggUmVpdHogd3JvdGU6DQo+IE9uIDE2LjA1LjE5IDE2
OjMzLCBBbnRvbiBOZWZlZG92IHdyb3RlOg0KPj4gQSBibG9jayBkcml2ZXIgY2FuIHByb3ZpZGUg
YSBjYWxsYmFjayB0byByZXBvcnQgZHJpdmVyLXNwZWNpZmljDQo+PiBzdGF0aXN0aWNzLg0KPj4N
Cj4+IGZpbGUtcG9zaXggZHJpdmVyIG5vdyByZXBvcnRzIGRpc2NhcmQgc3RhdGlzdGljcw0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IEFudG9uIE5lZmVkb3YgPGFudG9uLm5lZmVkb3ZAdmlydHVvenpv
LmNvbT4NCj4+IFJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2Vt
ZW50c292QHZpcnR1b3p6by5jb20+DQo+PiBBY2tlZC1ieTogTWFya3VzIEFybWJydXN0ZXIgPGFy
bWJydUByZWRoYXQuY29tPg0KPj4gLS0tDQo+PiAgIHFhcGkvYmxvY2stY29yZS5qc29uICAgICAg
fCAzOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICBpbmNsdWRl
L2Jsb2NrL2Jsb2NrLmggICAgIHwgIDEgKw0KPj4gICBpbmNsdWRlL2Jsb2NrL2Jsb2NrX2ludC5o
IHwgIDEgKw0KPj4gICBibG9jay5jICAgICAgICAgICAgICAgICAgIHwgIDkgKysrKysrKysrDQo+
PiAgIGJsb2NrL2ZpbGUtcG9zaXguYyAgICAgICAgfCAzOCArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLQ0KPj4gICBibG9jay9xYXBpLmMgICAgICAgICAgICAgIHwgIDUgKysr
KysNCj4+ICAgNiBmaWxlcyBjaGFuZ2VkLCA4OSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQ0KPiANCj4gDQo+PiBkaWZmIC0tZ2l0IGEvcWFwaS9ibG9jay1jb3JlLmpzb24gYi9xYXBpL2Js
b2NrLWNvcmUuanNvbg0KPj4gaW5kZXggNTUxOTRmODRjZS4uMzY4ZTA5YWUzNyAxMDA2NDQNCj4+
IC0tLSBhL3FhcGkvYmxvY2stY29yZS5qc29uDQo+PiArKysgYi9xYXBpL2Jsb2NrLWNvcmUuanNv
bg0KPj4gQEAgLTk1Niw2ICs5NTYsNDEgQEANCj4+ICAgICAgICAgICAgICAnKndyX2xhdGVuY3lf
aGlzdG9ncmFtJzogJ0Jsb2NrTGF0ZW5jeUhpc3RvZ3JhbUluZm8nLA0KPj4gICAgICAgICAgICAg
ICcqZmx1c2hfbGF0ZW5jeV9oaXN0b2dyYW0nOiAnQmxvY2tMYXRlbmN5SGlzdG9ncmFtSW5mbycg
fSB9DQo+PiAgIA0KPj4gKyMjDQo+PiArIyBAQmxvY2tTdGF0c1NwZWNpZmljRmlsZToNCj4+ICsj
DQo+PiArIyBGaWxlIGRyaXZlciBzdGF0aXN0aWNzDQo+PiArIw0KPj4gKyMgQGRpc2NhcmQtbmIt
b2s6IFRoZSBudW1iZXIgb2Ygc3VjY2Vzc2Z1bCBkaXNjYXJkIG9wZXJhdGlvbnMgcGVyZm9ybWVk
IGJ5DQo+PiArIyAgICAgICAgICAgICAgICAgdGhlIGRyaXZlci4NCj4+ICsjDQo+PiArIyBAZGlz
Y2FyZC1uYi1mYWlsZWQ6IFRoZSBudW1iZXIgb2YgZmFpbGVkIGRpc2NhcmQgb3BlcmF0aW9ucyBw
ZXJmb3JtZWQgYnkNCj4+ICsjICAgICAgICAgICAgICAgICAgICAgdGhlIGRyaXZlci4NCj4+ICsj
DQo+PiArIyBAZGlzY2FyZC1ieXRlcy1vazogVGhlIG51bWJlciBvZiBieXRlcyBkaXNjYXJkZWQg
YnkgdGhlIGRyaXZlci4NCj4+ICsjDQo+PiArIyBTaW5jZTogNC4xDQo+PiArIyMNCj4+ICt7ICdz
dHJ1Y3QnOiAnQmxvY2tTdGF0c1NwZWNpZmljRmlsZScsDQo+PiArICAnZGF0YSc6IHsNCj4+ICsg
ICAgICAnZGlzY2FyZC1uYi1vayc6ICd1aW50NjQnLA0KPj4gKyAgICAgICdkaXNjYXJkLW5iLWZh
aWxlZCc6ICd1aW50NjQnLA0KPj4gKyAgICAgICdkaXNjYXJkLWJ5dGVzLW9rJzogJ3VpbnQ2NCcg
fSB9DQo+PiArDQo+PiArIyMNCj4+ICsjIEBCbG9ja1N0YXRzU3BlY2lmaWM6DQo+PiArIw0KPj4g
KyMgQmxvY2sgZHJpdmVyIHNwZWNpZmljIHN0YXRpc3RpY3MNCj4+ICsjDQo+PiArIyBTaW5jZTog
NC4xDQo+PiArIyMNCj4+ICt7ICd1bmlvbic6ICdCbG9ja1N0YXRzU3BlY2lmaWMnLA0KPj4gKyAg
J2Jhc2UnOiB7ICdkcml2ZXInOiAnQmxvY2tkZXZEcml2ZXInIH0sDQo+PiArICAnZGlzY3JpbWlu
YXRvcic6ICdkcml2ZXInLA0KPj4gKyAgJ2RhdGEnOiB7DQo+PiArICAgICAgJ2ZpbGUnOiAnQmxv
Y2tTdGF0c1NwZWNpZmljRmlsZScsDQo+PiArICAgICAgJ2hvc3RfZGV2aWNlJzogJ0Jsb2NrU3Rh
dHNTcGVjaWZpY0ZpbGUnIH0gfQ0KPiANCj4gSSB3b3VsZCBsaWtlIHRvIHVzZSB0aGVzZSBjaGFu
Y2UgdG8gY29tcGxhaW4gdGhhdCBJIGZpbmQgdGhpcyBhd2t3YXJkLg0KPiBNeSBwcm9ibGVtIGlz
IHRoYXQgSSBkb27igJl0IGtub3cgaG93IGFueSBtYW5hZ2VtZW50IGFwcGxpY2F0aW9uIGlzDQo+
IHN1cHBvc2VkIHRvIHJlYXNvbmFibHkgY29uc3VtZSB0aGlzLiAgSXQgZmVlbHMgd2VpcmQgdG8g
cG90ZW50aWFsbHkgaGF2ZQ0KPiB0byByZWNvZ25pemUgdGhlIHJlc3VsdCBmb3IgZXZlcnkgYmxv
Y2sgZHJpdmVyLg0KPiANCj4gSSB3b3VsZCBub3cgbGlrZSB0byBub3RlIHRoYXQgSeKAmW0gY2xl
YXJseSBub3QgaW4gYSBwb3NpdGlvbiB0byBibG9jaw0KPiB0aGlzIGF0IHRoaXMgcG9pbnQsIGJl
Y2F1c2UgSeKAmXZlIGhhZCBhIHllYXIgdG8gZG8gc28sIEkgZGlkbuKAmXQsIHNvIGl0DQo+IHdv
dWxkIGJlIHVuZmFpciB0byBkbyBpdCBub3cuDQo+IA0KPiAoU3RpbGwsIEkgZmVlbCBsaWtlIGlm
IEkgaGF2ZSBhIGNvbmNlcm4sIEkgc2hvdWxkIHJhaXNlIGl0LCBldmVuIGlmIGl04oCZcw0KPiB0
b28gbGF0ZS4pDQo+IA0KPiBJIGtub3cgTWFya3VzIGhhcyBwcm9wb3NlZCB0aGlzLCBidXQgSSBk
b27igJl0IHVuZGVyc3RhbmQgd2h5LiAgSGUgc2V0DQo+IEltYWdlSW5mb1NwZWNpZmljIGFzIGEg
cHJlY2VkZW5jZSwgYnV0IHRoYXQgaGFzIGEgZGlmZmVyZW50IHJlYXNvbmluZw0KPiBiZWhpbmQg
aXQuICBUaGUgcG9pbnQgZm9yIHRoYXQgaXMgdGhhdCBpdCBzaW1wbHkgZG9lc27igJl0IHdvcmsg
YW55IG90aGVyDQo+IHdheSwgYmVjYXVzZSBpdCBpcyBjbGVhcmx5IGZvcm1hdC1zcGVjaWZpYyBp
bmZvcm1hdGlvbiB0aGF0IGNhbm5vdCBiZQ0KPiBzaGFyZWQgYmV0d2VlbiBkcml2ZXJzLiAgQW55
dGhpbmcgdGhhdCBjYW4gYmUgc2hhcmVkIGlzIHB1dCBpbnRvDQo+IEltYWdlSW5mbyAobGlrZSB0
aGUgY2x1c3RlciBzaXplKS4NCj4gDQo+IFdlIGhhdmUgdGhlIHNhbWUgY29uc3RlbGxhdGlvbiBo
ZXJlLCBCbG9ja1N0YXRzIGNvbnRhaW5zIGNvbW1vbiBzdHVmZiwNCj4gYW5kIEJsb2NrU3RhdHNT
cGVjaWZpYyB3b3VsZCBjb250YWluIGRyaXZlci1zcGVjaWZpYyBzdHVmZi4gIEJ1dCB0byBtZSwN
Cj4gQmxvY2tTdGF0c1NwZWNpZmljRmlsZSBkb2VzbuKAmXQgbG9vayB2ZXJ5IHNwZWNpYWwuICBJ
dCBsb29rcyBsaWtlIGl0IGp1c3QNCj4gZHVwbGljYXRlcyBmaWVsZHMgdGhhdCBhbHJlYWR5IGV4
aXN0IGluIEJsb2NrRGV2aWNlU3RhdHMuDQo+IA0KPiANCj4gKEZ1cnRoZXJtb3JlLCBtb3N0IG9m
IEltYWdlSW5mb1NwZWNpZmljIGlzIGFjdHVhbGx5IG5vdCB1c2VmdWwgdG8NCj4gbWFuYWdlbWVu
dCBzb2Z0d2FyZSwgYnV0IG9ubHkgYXMgYW4gaW5mb3JtYXRpb24gZm9yIGh1bWFucyAoYW5kIGhh
dmluZw0KPiBzdWNoIGEgc3RydWN0dXJlIGZvciB0aGF0IGlzIHBlcmZlY3RseSBmaW5lKS4gIEJ1
dCB0aGVzZSBzdGF0cyBkb27igJl0DQo+IHJlYWxseSBsb29rIGxpa2Ugc29tZXRoaW5nIGZvciBp
bW1lZGlhdGUgaHVtYW4gY29uc3VtcHRpb24uKQ0KPiANCj4gDQo+IFNvIEkgd29uZGVyIHdoeSB5
b3UgZG9u4oCZdCBqdXN0IHB1dCB0aGlzIGluZm9ybWF0aW9uIGludG8NCj4gQmxvY2tEZXZpY2VT
dGF0cy4gIEZyb20gd2hhdCBJIGNhbiB0ZWxsIGxvb2tpbmcgYXQNCj4gYmRydl9xdWVyeV9iZHNf
c3RhdHMoKSBhbmQgcW1wX3F1ZXJ5X2Jsb2Nrc3RhdHMoKSwgdGhlIEBzdGF0cyBmaWVsZCBpcw0K
PiBjdXJyZW50bHkgY29tcGxldGVseSAwIGlmIEBxdWVyeS1ub2RlcyBpcyB0cnVlLg0KPiANCj4g
KEZ1cnRoZXJtb3JlLCBJIHdvbmRlciB3aGV0aGVyIGl0IHdvdWxkIG1ha2Ugc2Vuc2UgdG8gcmUt
YWRkDQo+IEJsb2NrQWNjdFN0YXRzIHRvIGVhY2ggQkRTIGFuZCB0aGVuIGxldCB0aGUgZ2VuZXJp
YyBibG9jayBjb2RlIGRvIHRoZQ0KPiBhY2NvdW50aW5nIG9uIGl0LiAgSSBtb3ZlZCBpdCB0byB0
aGUgQkIgaW4gN2YwZTlkYTZmMTMgYmVjYXVzZSB3ZSBkaWRu4oCZdA0KPiBjYXJlIGFib3V0IG5v
ZGUtbGV2ZWwgaW5mb3JtYXRpb24gYXQgdGhlIHRpbWUsIGJ1dCBtYXliZSBpdOKAmXMgdGltZSB0
bw0KPiByZWNvbnNpZGVyLikNCj4gDQo+IA0KPiBBbnl3YXksIGFzIEnigJl2ZSBzYWlkLCBJIGZ1
bGx5IHVuZGVyc3RhbmQgdGhhdCBjb21wbGFpbmluZyBhYm91dCBhIGRlc2lnbg0KPiBkZWNpc2lv
biBpcyBqdXN0IHVuZmFpciBhdCB0aGlzIHBvaW50LCBzbyB0aGlzIGlzIG5vdCBhIHZldG8uDQo+
IA0KDQpoaSENCg0KSGF2aW5nIGJvdGggInVubWFwIiBhbmQgImRpc2NhcmQiIHN0YXRzIGluIHRo
ZSBzYW1lIGxpc3QgZmVlbHMgd2VpcmQuDQpUaGUgaW50ZW50aW9uIGlzIHRoYXQgdW5tYXAgYmVs
b25ncyB0byB0aGUgZGV2aWNlIGxldmVsLCBhbmQgZGlzY2FyZCBpcw0KZnJvbSB0aGUgZHJpdmVy
IGxldmVsLiBOb3cgd2UgaGF2ZSBhIHNlcGFyYXRlIHN0cnVjdHVyZSBuYW1lZCAiZHJpdmVyLQ0K
c3BlY2lmaWMiLiBDb3VsZCBhbHNvIGJlIGNhbGxlZCAiZHJpdmVyLXN0YXRzIi4NCg0KV2UgY291
bGQgbWFrZSB0aGlzIHN0cnVjdHVyZSBub24tb3B0aW9uYWwsIHByZXNlbnQgZm9yIGFsbCBkcml2
ZXINCnR5cGVzLCBhcyBpbmRlZWQgdGhlcmUgaXMgbm90aGluZyBzcGVjaWFsIGFib3V0IGRpc2Nh
cmQgc3RhdHMuIEJ1dCB0aGVuDQp3ZSBuZWVkIHNvbWUgd2F5IHRvIGRpc3Rpbmd1aXNoDQogIC0g
ZGlzY2FyZF9uYl9vayA9PSAwIGFzIG5vIHJlcXVlc3QgcmVhY2hlZCB0aGUgZHJpdmVyIGxldmVs
DQogIC0gZGlzY2FyZF9uYl9vayA9PSAwIGFzIHRoZSBkcml2ZXIgZG9lcyBub3Qgc3VwcG9ydCB0
aGUgYWNjb3VudGluZw0KDQpZZXMsIHB1dHRpbmcgdGhlIGFjY291bnRpbmcgaW4gdGhlIGdlbmVy
aWMgY29kZSB3b3VsZCBoZWxwLCBidXQgZG8gd2UNCnJlYWxseSB3YW50IHRvIGJ1cmRlbiBpdCB3
aXRoIGFjY291bnRpbmcgdG9vPyBUcmFja2luZyB0aGF0IGVhY2ggYW5kDQpldmVyeSBjYXNlIGlz
IGNvdmVyZWQgd2l0aCBhbGwgdGhvc2UgYmxvY2tfYWNjdF9kb25lKCkgaW52YWxpZCgpIGFuZA0K
ZmFpbGVkKCkgY2FuIHJlYWxseSBiZSBhIHBhaW4uDQoNCkFuZCB3aGF0IGFjY291bnRpbmcgc2hv
dWxkIGJlIHRoZXJlPyBBbGwgdGhlIG9wZXJhdGlvbnM/IE1lYXN1cmluZw0KZGlzY2FyZHMgYXQg
Ym90aCBkZXZpY2UgYW5kIEJEUyBsZXZlbCBpcyB1c2VmdWwgc2luY2UgZGlzY2FyZHMgYXJlDQpv
cHRpb25hbC4gRG91YmxlLW1lYXN1cmluZyByZWFkcyZ3cml0ZXMgaXMgcHJvYmFibHkgbm90IHNv
IHVzZWZ1bCAoUk1XIA0KYWNjb3VudGluZz8gUmVhZCBzdGF0cyBmb3IgdGhlIGJhY2tpbmcgaW1h
Z2VzPykNCg0KDQo+PiBkaWZmIC0tZ2l0IGEvYmxvY2svZmlsZS1wb3NpeC5jIGIvYmxvY2svZmls
ZS1wb3NpeC5jDQo+PiBpbmRleCA3NmQ1NGIzYTg1Li5hMmYwMWNmZTEwIDEwMDY0NA0KPj4gLS0t
IGEvYmxvY2svZmlsZS1wb3NpeC5jDQo+PiArKysgYi9ibG9jay9maWxlLXBvc2l4LmMNCj4+IEBA
IC0xNjAsOSArMTYwLDkgQEAgdHlwZWRlZiBzdHJ1Y3QgQkRSVlJhd1N0YXRlIHsNCj4+ICAgICAg
IGJvb2wgZHJvcF9jYWNoZTsNCj4+ICAgICAgIGJvb2wgY2hlY2tfY2FjaGVfZHJvcHBlZDsNCj4+
ICAgICAgIHN0cnVjdCB7DQo+PiAtICAgICAgICBpbnQ2NF90IGRpc2NhcmRfbmJfb2s7DQo+PiAt
ICAgICAgICBpbnQ2NF90IGRpc2NhcmRfbmJfZmFpbGVkOw0KPj4gLSAgICAgICAgaW50NjRfdCBk
aXNjYXJkX2J5dGVzX29rOw0KPj4gKyAgICAgICAgdWludDY0X3QgZGlzY2FyZF9uYl9vazsNCj4+
ICsgICAgICAgIHVpbnQ2NF90IGRpc2NhcmRfbmJfZmFpbGVkOw0KPj4gKyAgICAgICAgdWludDY0
X3QgZGlzY2FyZF9ieXRlc19vazsNCj4gDQo+IChJIGRvbuKAmXQga25vdyB3aHkgeW91IGRpZG7i
gJl0IGludHJvZHVjZSB0aGVzZSBmaWVsZHMgd2l0aCB0aGVzZSB0eXBlcyBpbg0KPiB0aGUgcHJl
dmlvdXMgcGF0Y2ggdGhlbi4pDQo+IA0KDQpPdWNoLCBzcXVhc2hlZCB0aGUgY2hhbmdlcyB0byB0
aGUgd3JvbmcgY29tbWl0LCBvYnZpb3VzbHkNCg==

