Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE78C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 13:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38311206C1
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 13:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Y9z1myth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38311206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huccc-0004dR-BI
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 09:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50780)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hucas-0003mr-Pm
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 09:00:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hucaq-0005Vx-3f
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 09:00:06 -0400
Received: from mail-eopbgr70134.outbound.protection.outlook.com
 ([40.107.7.134]:33481 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hucap-0005Sh-Ak; Mon, 05 Aug 2019 09:00:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzqsBH7SvFcL8SjI65kdDGYbWGnnZgBRT6jCn2+9POqwNsENAUOqv1mW3lG+1MbyCjEdx4aTeOZziSj/02aO4qruzn3hWYbjglB0qKZVKGrR3qxPGaK9dpmhW7v7u0K7rHXB3jqbb5QS2qARTRVoV+zuGGLx61OihDi5puCUpJRLEJ/KlAbG0FlZJ8Dc5na/Du9bhkIAyKKKFJQiYA3oWCorpWM0g6aCBg/t59n7TuahLBupyMDVg9nPA5TWaoDXhnBBRFZ0OPjOMoY/UHf88yIooo1z1InCuLT95R0Hn8sIhuLHvCCc2/5sRgCwW7h0sMJjJdixQCQXogjROxXlcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLvedm7FeayBmmRSbvGdW02QT8rsGZb4qyQu8230xnY=;
 b=X47/cg0bH8gKqmmd3vLqGqgzHt6RsWx9qk9GL5Dt2jMUg5uFVa1+K/2J2gl3ePfUpboDvRf0n/udZtxU0BhQTqkV77whn33k7CJgfwwc+mwhuAwc8wTf/DWDwfE+Y0ZulXEK9WsEevIh9fRi/RX0hrje41tht8rrFB+v6r0CUrIXC4u+hHQ3vBtvGic8cVllaS2iie+aWBQU0WFgUVi/mr1XJUxN+uUTIEHeKCmW4+AHQsd3to0FSjOBfb+WV0y03ZMosCCW7sj4rqm8nn8XKnHno66CzULxWuyeVUXoA3OY5wC+iK/ehXdXng2KQutXdHz+J9TbP/MXKwr7z7iO8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLvedm7FeayBmmRSbvGdW02QT8rsGZb4qyQu8230xnY=;
 b=Y9z1mythrldm8aMhmDkfKHqWaJyzje3qV+xzTSMBlqXzdd1k/YaNAXdAJVrv8sQoED/uPwxAtODBMMuGNK6e/o3JHAjNCLFoO75uYyf/c4F2RIAFWTAISYrxidzTr7OGxfTgmFCAEZ+yaFaQ9SP2wiJe1t210+tVA0g4iZ9gDe4=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5513.eurprd08.prod.outlook.com (52.133.243.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Mon, 5 Aug 2019 13:00:00 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 13:00:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH] mirror: Only mirror granularity-aligned chunks
Thread-Index: AQHVS4ParN7ByKAKKEqmsiInPymq+qbshFYA
Date: Mon, 5 Aug 2019 13:00:00 +0000
Message-ID: <f3b36f80-589f-039d-233b-1a54f2cfcefc@virtuozzo.com>
References: <20190805114923.23701-1-mreitz@redhat.com>
In-Reply-To: <20190805114923.23701-1-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P191CA0002.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::12)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190805155958010
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea73ea44-18f7-4bc6-e0bb-08d719a4d2de
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5513; 
x-ms-traffictypediagnostic: DB8PR08MB5513:
x-microsoft-antispam-prvs: <DB8PR08MB55131A6B44479446A711049EC1DA0@DB8PR08MB5513.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(136003)(39840400004)(376002)(346002)(189003)(199004)(66066001)(6512007)(6116002)(3846002)(36756003)(64756008)(6436002)(66446008)(66556008)(86362001)(81166006)(5660300002)(66946007)(81156014)(53936002)(25786009)(31686004)(14454004)(66476007)(31696002)(76176011)(478600001)(4326008)(6246003)(2501003)(71190400001)(71200400001)(476003)(8676002)(316002)(2616005)(54906003)(110136005)(8936002)(486006)(11346002)(7736002)(2906002)(99286004)(305945005)(229853002)(446003)(6486002)(256004)(68736007)(14444005)(186003)(52116002)(102836004)(386003)(26005)(6506007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5513;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jVu89nxxwjt4hfOlUTdchqmG0lxfoYQbn5CqVnYIzIq82Mdj6jO44FY7QbtjoLl8v16I0c2lcYaxTsyohKZHOmul7n6nNs5wYtrcQqIa9sRSwjVxu3RGkF9SQ6WVrWwuBuIC5N3VhsKZ2t5ZaJBKPG3NgWT4v+cBSUj5Qgc4a6fDu5igJJJiCJ+l8aojpz8mT3WYfWzIbdFxxNjz/r+wakVpxKLa+HGFmxG2F5Z1AeADW/BrA6gcINERQAM3n7DHd3Ij+iAN4BMzKBZBCwr3OLDBvUxe8x/p0z0Mf0T3lewQ6MTlABkWoG0CN4fIdKUKBJ2BotoIsX9OEbUHrIglWCYKhe20PPD3thBBMTeYXuHcCSGcPEAmKwudCnLAtEscf8pb/Nrk7RLfy1kmM+XzCGke/kV8CsZO8DFRhCG11mQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDE82AD3DCA8244CBFEB06F3B2DBC2D5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea73ea44-18f7-4bc6-e0bb-08d719a4d2de
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 13:00:00.0348 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5513
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.134
Subject: Re: [Qemu-devel] [PATCH] mirror: Only mirror granularity-aligned
 chunks
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

MDUuMDguMjAxOSAxNDo0OSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBJbiB3cml0ZS1ibG9ja2luZyBt
b2RlLCBhbGwgd3JpdGVzIHRvIHRoZSB0b3Agbm9kZSBkaXJlY3RseSBnbyB0byB0aGUNCj4gdGFy
Z2V0LiAgV2UgbXVzdCBvbmx5IG1pcnJvciBjaHVua3Mgb2YgZGF0YSB0aGF0IGFyZSBhbGlnbmVk
IHRvIHRoZQ0KPiBqb2IncyBncmFudWxhcml0eSwgYmVjYXVzZSB0aGF0IGlzIGhvdyB0aGUgZGly
dHkgYml0bWFwIHdvcmtzLg0KPiBUaGVyZWZvcmUsIHRoZSByZXF1ZXN0IGFsaWdubWVudCBmb3Ig
d3JpdGVzIG11c3QgYmUgdGhlIGpvYidzDQo+IGdyYW51bGFyaXR5IChpbiB3cml0ZS1ibG9ja2lu
ZyBtb2RlKS4NCj4gDQo+IFVuZm9ydHVuYXRlbHksIHRoaXMgZm9yY2VzIGFsbCByZWFkcyBhbmQg
d3JpdGVzIHRvIGhhdmUgdGhlIHNhbWUNCj4gZ3JhbnVsYXJpdHkgKHdlIG9ubHkgbmVlZCB0aGlz
IGFsaWdubWVudCBmb3Igd3JpdGVzIHRvIHRoZSB0YXJnZXQsIG5vdA0KPiB0aGUgc291cmNlKSwg
YnV0IHRoYXQgaXMgc29tZXRoaW5nIHRvIGJlIGZpeGVkIGFub3RoZXIgdGltZS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQo+IC0tLQ0KPiBUaGlz
IGlzIGFuIGFsdGVybmF0aXZlIHRvIFZsYWRpbWlyJ3MgInV0aWwvaGJpdG1hcDogZml4IHVuYWxp
Z25lZCByZXNldCINCj4gcGF0Y2guICBJIGRvbid0IG1pbmQgbXVjaCBlaXRoZXIgd2F5LCBib3Ro
IG9mIHByb3MgYW5kIGNvbnMuICBDb21wYXJpbmcNCj4gdGhpcyBwYXRjaCB0byBWbGFkaW1pcidz
Og0KPiANCj4gKyBNYWtlcyBjb3B5LW1vZGU9d3JpdGUtYmxvY2tpbmcgcmVhbGx5IHdvcmsgKHVu
bGVzcyBJJ20gbWlzdGFrZW4pDQo+IC0gTG93ZXJzIHBlcmZvcm1hbmNlIHdpdGggY29weS1tb2Rl
PXdyaXRlLWJsb2NraW5nIHVubmVjZXNzYXJpbHkNCj4gLS0tDQo+ICAgYmxvY2svbWlycm9yLmMg
fCAxMiArKysrKysrKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL21pcnJvci5jIGIvYmxvY2svbWlycm9yLmMNCj4gaW5k
ZXggOGNiNzVmYjQwOS4uM2Y5YzVhMTc4YSAxMDA2NDQNCj4gLS0tIGEvYmxvY2svbWlycm9yLmMN
Cj4gKysrIGIvYmxvY2svbWlycm9yLmMNCj4gQEAgLTE0ODEsNiArMTQ4MSwxNSBAQCBzdGF0aWMg
dm9pZCBiZHJ2X21pcnJvcl90b3BfY2hpbGRfcGVybShCbG9ja0RyaXZlclN0YXRlICpicywgQmRy
dkNoaWxkICpjLA0KPiAgICAgICAqbnNoYXJlZCA9IEJMS19QRVJNX0FMTDsNCj4gICB9DQo+ICAg
DQo+ICtzdGF0aWMgdm9pZCBiZHJ2X21pcnJvcl90b3BfcmVmcmVzaF9saW1pdHMoQmxvY2tEcml2
ZXJTdGF0ZSAqYnMsIEVycm9yICoqZXJycCkNCj4gK3sNCj4gKyAgICBNaXJyb3JCRFNPcGFxdWUg
KnMgPSBicy0+b3BhcXVlOw0KPiArDQo+ICsgICAgaWYgKHMgJiYgcy0+am9iICYmIHMtPmpvYi0+
Y29weV9tb2RlID09IE1JUlJPUl9DT1BZX01PREVfV1JJVEVfQkxPQ0tJTkcpIHsNCj4gKyAgICAg
ICAgYnMtPmJsLnJlcXVlc3RfYWxpZ25tZW50ID0gcy0+am9iLT5ncmFudWxhcml0eTsNCj4gKyAg
ICB9DQo+ICt9DQo+ICsNCj4gICAvKiBEdW1teSBub2RlIHRoYXQgcHJvdmlkZXMgY29uc2lzdGVu
dCByZWFkIHRvIGl0cyB1c2VycyB3aXRob3V0IHJlcXVpcmluZyBpdA0KPiAgICAqIGZyb20gaXRz
IGJhY2tpbmcgZmlsZSBhbmQgdGhhdCBhbGxvd3Mgd3JpdGVzIG9uIHRoZSBiYWNraW5nIGZpbGUg
Y2hhaW4uICovDQo+ICAgc3RhdGljIEJsb2NrRHJpdmVyIGJkcnZfbWlycm9yX3RvcCA9IHsNCj4g
QEAgLTE0OTMsNiArMTUwMiw3IEBAIHN0YXRpYyBCbG9ja0RyaXZlciBiZHJ2X21pcnJvcl90b3Ag
PSB7DQo+ICAgICAgIC5iZHJ2X2NvX2Jsb2NrX3N0YXR1cyAgICAgICA9IGJkcnZfY29fYmxvY2tf
c3RhdHVzX2Zyb21fYmFja2luZywNCj4gICAgICAgLmJkcnZfcmVmcmVzaF9maWxlbmFtZSAgICAg
ID0gYmRydl9taXJyb3JfdG9wX3JlZnJlc2hfZmlsZW5hbWUsDQo+ICAgICAgIC5iZHJ2X2NoaWxk
X3Blcm0gICAgICAgICAgICA9IGJkcnZfbWlycm9yX3RvcF9jaGlsZF9wZXJtLA0KPiArICAgIC5i
ZHJ2X3JlZnJlc2hfbGltaXRzICAgICAgICA9IGJkcnZfbWlycm9yX3RvcF9yZWZyZXNoX2xpbWl0
cywNCj4gICB9Ow0KPiAgIA0KPiAgIHN0YXRpYyBCbG9ja0pvYiAqbWlycm9yX3N0YXJ0X2pvYigN
Cj4gQEAgLTE2NzgsNiArMTY4OCw4IEBAIHN0YXRpYyBCbG9ja0pvYiAqbWlycm9yX3N0YXJ0X2pv
YigNCj4gICANCj4gICAgICAgUVRBSUxRX0lOSVQoJnMtPm9wc19pbl9mbGlnaHQpOw0KPiAgIA0K
PiArICAgIGJkcnZfcmVmcmVzaF9saW1pdHMobWlycm9yX3RvcF9icywgJmVycm9yX2Fib3J0KTsN
Cj4gKw0KPiAgICAgICB0cmFjZV9taXJyb3Jfc3RhcnQoYnMsIHMsIG9wYXF1ZSk7DQo+ICAgICAg
IGpvYl9zdGFydCgmcy0+Y29tbW9uLmpvYik7DQo+ICAgDQo+IA0KDQpBbSBJIHJpZ2h0IHRoYXQg
dGhlIGZhY3QgdGhhdCBubyBndWVzdCByZXF1ZXN0IHdpbGwgc2tpcCB0aGlzIGxpbWl0IGlzIGd1
YXJhbnRlZWQgYnkNCmFpb19jb250ZXh0X2FjcXVpcmUvcmVsZWFzZSBhcm91bmQgYmxvY2tkZXZf
bWlycm9yX2NvbW1vbj8NCg0KTm90IHN1cmUgaG93IG11Y2ggaXQgbG93ZXJzIHBlcmZvcm1hbmNl
LCBidXQgaXQgc2hvdWxkIHdvcmsuLg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1P
Z2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpWbGFkaW1pcg0K

