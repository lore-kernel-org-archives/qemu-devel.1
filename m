Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A60CC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 08:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0467120678
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 08:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tFsDBuVT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0467120678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA8fu-0007wp-RD
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 04:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iA8ei-0007JP-3x
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iA8ef-0000fo-Vf
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:16:11 -0400
Received: from mail-eopbgr80104.outbound.protection.outlook.com
 ([40.107.8.104]:12807 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iA8ef-0000c8-1i; Tue, 17 Sep 2019 04:16:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hn+yXB+hwSXD1elI8Hmeji/kjOa5pjYtUN2q3mQ06OEAXaZBni2EZfvcCd5r1yDmvDM6Km2Ehk8Jt1qrwWNBG2hWAIyhFUKWomGFCFbbYsXDFZGPE48b4EFjN5oKzHkX7BmatN3ILm9UPJc0aQSI8qQn/c7Oz4JBRT1W4vONWmkg9jQhFvZFRgORrb/MiQXYW7XdNSAIBeDmmfm/M3zTMnBdZDaAjSatrWYbMTm3Esvy5RjnzMpQcZu+CTaZeHaRU+u9a94WfxPeXWQD4X3byHU0hshk9IXyi5gg3BibZxqh+LWaUEQ0MYGFSFCxDXnd8tjNdXlJ9+414iioNXxyHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wh5LnD1D0WI8FxwEPaPvnOtKQI1BngfGltI44n7PL98=;
 b=X8FZlVVKYsJH/DvJuwn18iLztSPSjE17O3kgOIZf+VWBryL+szpDSXZ2nACSQSYcWqrzkQq39Dp2xdv22vIGgbtdfomf/146bGmw1vTKMGAmoQOSSWH3WJaUdRx9RKlNHOIFbzz316YiTvfSCrOUWPxGwSy/G1iMSHgIaVKXcKsRvKez38vx2loXcH0UmcPTNREnVxhxcORmLCn6C6/4wt7FFbG85TxpOPstWNUfjtedHaYFcI1zzboFzdIDr81PeqAc+7GXHPs/kDZj0CR2lAQ4l4E9Z1zx3TPLApaLOgG7QJqzEIe4tXszy2BJ2Y0Wg9eL3KbwuZaAysseryxblA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wh5LnD1D0WI8FxwEPaPvnOtKQI1BngfGltI44n7PL98=;
 b=tFsDBuVTvEhjtObCKX5DoBTmLX9kE3ShgF9/Chsb7b+ojTQA5c1QVNQaTwqC4bzRqs35ydVw/bdzunfGZy9CXudE+cwbgO3jG7B7E2AItKBWp9CzkVdpaT/ZHfbunAz5vNPuk+zWNjdypKmtAidFwWj7i1Qo4ktjSpzjNAtJD4k=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5354.eurprd08.prod.outlook.com (52.133.240.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Tue, 17 Sep 2019 08:16:06 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 08:16:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: ping Re: [PATCH v8 0/3] NBD reconnect
Thread-Index: AQHVWEDPFxKikbYstE2FStjWksvijacvr8mA
Date: Tue, 17 Sep 2019 08:16:05 +0000
Message-ID: <1b472b15-cc31-e400-c875-fe2097554973@virtuozzo.com>
References: <20190821165215.61406-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190821165215.61406-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0164.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::12) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190917111603519
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45c31bd1-c792-4b33-8b42-08d73b47497a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5354; 
x-ms-traffictypediagnostic: DB8PR08MB5354:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5354F1B52655241ED9EAAEE4C18F0@DB8PR08MB5354.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(366004)(39840400004)(376002)(396003)(53754006)(199004)(189003)(6916009)(81156014)(6436002)(6486002)(4326008)(2906002)(8936002)(76176011)(14454004)(107886003)(8676002)(25786009)(66066001)(386003)(6506007)(486006)(476003)(11346002)(7736002)(52116002)(2616005)(186003)(305945005)(26005)(446003)(31696002)(36756003)(5660300002)(99286004)(86362001)(256004)(14444005)(71200400001)(3846002)(5024004)(102836004)(81166006)(6116002)(71190400001)(2351001)(2501003)(31686004)(54906003)(5640700003)(66446008)(64756008)(316002)(6512007)(478600001)(66946007)(66476007)(66556008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5354;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +ANmIVKNuGNVygmvQXKbUmiQNPbZSOh0X9UWry1xa7vHPEtOvmW8EXitJYM0XWz4dKffNBxYahYauuZWxhBhndphfFO3kO60YdD8l/LYzTSGdXh+4VFPbns1MDhWNVMNIgQrC7g11orAH754W/8ZuvWXseP1Cpru3639cOdd1TGt4itXr/Y7kSTGUcGp0Q4hhBSQKz5/7gYduku9FQQeEF9m+SY5e64onb4pXy+2LMeOyH01dH4jcHgegjg/enHhEzX8cavU0YE1GBXs0H9eO8kABAnURj18aPEcI9GNIv1kOXqSsZ6asZwcBadBKNpwDJD5ac0DyY0KHXOD+tHa96Z7g1wFHZRaSs/TrzhLBGx6m5181outi+rmVw90DPTmDEZcOqUX0JqrXJsvesFqHXqB5rcYkQ81OTAWG479qK0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F20F60A0D245F4EB674BFCA323AB928@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c31bd1-c792-4b33-8b42-08d73b47497a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 08:16:06.1111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7EUgKCRt34ynxLMt1SJ/JQjT8XcChv307zaxLrSsAHute1Q+lhZj3rIPg2++Ly0/cnC2B8awwHOzXHPngBAw/h+EaGUpWwQ2fNg23aTTLec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5354
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.104
Subject: [Qemu-devel] ping Re: [PATCH v8 0/3] NBD reconnect
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
 "sheepdog@lists.wpkg.org" <sheepdog@lists.wpkg.org>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "namei.unix@gmail.com" <namei.unix@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cGluZw0KDQoyMS4wOC4yMDE5IDE5OjUyLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdy
b3RlOg0KPiBIaSBhbGwhDQo+IEhlcmUgaXMgTkJEIHJlY29ubmVjdC4gUHJldmlvdXNseSwgaWYg
Y29ubmVjdGlvbiBmYWlsZWQgYWxsIGN1cnJlbnQNCj4gYW5kIGZ1dHVyZSByZXF1ZXN0cyB3aWxs
IGZhaWwuIEFmdGVyIHRoZSBzZXJpZXMsIG5iZC1jbGllbnQgZHJpdmVyDQo+IHdpbGwgdHJ5IHRv
IHJlY29ubmVjdCB1bmxpbWl0ZWQgdGltZXMuIER1cmluZyBmaXJzdCBAcmVjb25uZWN0LWRlbGF5
DQo+IHNlY29uZHMgb2YgcmVjb25uZWN0aW5nIGFsbCByZXF1ZXN0cyB3aWxsIHdhaXQgZm9yIHRo
ZSBjb25uZWN0aW9uLA0KPiBhbmQgaWYgaXQgaXMgZXN0YWJsaXNoZWQgcmVxdWVzdHMgd2lsbCBi
ZSByZXNlbnQuIEFmdGVyDQo+IEByZWNvbm5lY3QtZGVsYXkgcGVyaW9kIGFsbCByZXF1ZXN0cyB3
aWxsIGJlIGZhaWxlZCAodW50aWwgc3VjY2Vzc2Z1bA0KPiByZWNvbm5lY3QpLg0KPiANCj4gdjg6
DQo+IHByZXBhcmF0aW9ucyBhcmUgYWxyZWFkeSBtZXJnZWQgW3RoeCB0byBFcmljXSwgb2xkIDA3
IHdpdGggU0lfKiBjb25zdGFudHMNCj4gZHJvcHBlZCBbUGV0ZXJdDQo+IDAyOiAtIHVzZSBOQU5P
U0VDT05EU19QRVJfU0VDT05EDQo+IDAzOiAtIG1vdmUgdG8gdGVzdHMvcWVtdS1pb3Rlc3RzLzI2
NA0KPiAgICAgIC0gbGltaXQgam9iIHNwZWVkLCBvdGhlcndpc2UgaXQgZmFpbHMgb24gcmFtZnMg
YXMgYmFja3VwIGZpbmlzaGVzIHRvbyBlYXJseQ0KPiANCj4gdjc6DQo+IGFsbW9zdCBhbGw6IHJl
YmFzZWQgb24gbWVyZ2VkIG5iZC5jIGFuZCBuYmQtY2xpZW50LmMgKGluY2x1ZGluZyBwYXRjaCBz
dWJqZWN0KQ0KPiAwMS0wNDogYWRkIEVyaWMncyByLWINCj4gMDQ6IHdvcmRpbmcNCj4gMDU6IG5l
dw0KPiAwNjogcmV3cml0ZSB0byByZW1vdmUgdGltZXIgZWFybGllcg0KPiAwNzogbmV3DQo+IDA4
Og0KPiAgIC0gcmViYXNlIG9uIDA1IGFuZCAwNw0KPiAgIC0gZHJvcCAiQWxsIHJpZ2h0cyByZXNl
cnZlZCINCj4gICAtIGhhbmRsZSBkcmFpbg0KPiAgIC0gaW1wcm92ZSBoYW5kbGluZyBhaW8gY29u
dGV4dCBhdHRhY2gNCj4gMDk6IG1vdmUgMjQ5IC0+IDI1Nw0KPiANCj4gVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSAoMyk6DQo+ICAgIHFlbXUtY29yb3V0aW5lLXNsZWVwOiBpbnRyb2R1Y2Ug
cWVtdV9jb19zbGVlcF93YWtlDQo+ICAgIGJsb2NrL25iZDogbmJkIHJlY29ubmVjdA0KPiAgICBp
b3Rlc3RzOiB0ZXN0IG5iZCByZWNvbm5lY3QNCj4gDQo+ICAgaW5jbHVkZS9xZW11L2Nvcm91dGlu
ZS5oICAgICAgfCAgMTcgKy0NCj4gICBibG9jay9uYmQuYyAgICAgICAgICAgICAgICAgICB8IDMz
NSArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tDQo+ICAgYmxvY2svbnVsbC5jICAg
ICAgICAgICAgICAgICAgfCAgIDIgKy0NCj4gICBibG9jay9zaGVlcGRvZy5jICAgICAgICAgICAg
ICB8ICAgMiArLQ0KPiAgIHRlc3RzL3Rlc3QtYmRydi1kcmFpbi5jICAgICAgIHwgICA2ICstDQo+
ICAgdGVzdHMvdGVzdC1ibG9jay1pb3RocmVhZC5jICAgfCAgIDIgKy0NCj4gICB1dGlsL3FlbXUt
Y29yb3V0aW5lLXNsZWVwLmMgICB8ICA0NyArKystLQ0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8y
NjQgICAgICAgIHwgIDY1ICsrKysrKysNCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMjY0Lm91dCAg
ICB8ICAxMiArKw0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy9ncm91cCAgICAgIHwgICAxICsNCj4g
ICB0ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weSB8ICAgNCArDQo+ICAgMTEgZmlsZXMgY2hh
bmdlZCwgNDA4IGluc2VydGlvbnMoKyksIDg1IGRlbGV0aW9ucygtKQ0KPiAgIGNyZWF0ZSBtb2Rl
IDEwMDc1NSB0ZXN0cy9xZW11LWlvdGVzdHMvMjY0DQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRl
c3RzL3FlbXUtaW90ZXN0cy8yNjQub3V0DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxh
ZGltaXINCg==

