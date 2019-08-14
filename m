Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26C8C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 09:12:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAC2B20843
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 09:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="B5UArE95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC2B20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxpKG-00082Z-IU
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 05:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxpJU-0007Gw-A6
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 05:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxpJT-0007Eu-0o
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 05:11:24 -0400
Received: from mail-eopbgr00132.outbound.protection.outlook.com
 ([40.107.0.132]:22341 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxpJO-0007DB-K8; Wed, 14 Aug 2019 05:11:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+VwsSLQY/Yaq/09TjxdgjgQJFx2elPsk6Ue1OkqDUPRR5HTcm0QTcyx/7Aa64KxlhVlow4MvCL1/gnEpENqA9O77KDlLinY4t0plvLQ9xUYYMNgoFcK+BH6Bd/TzywHClU/tlOPCcmVErQPjNaTEzk+vphGL86RI3Q1/NeyowtCSFDqiZoUQtRQ7XxJ460Oh1xEpJc8x4ER8ReYyuTtLg5Att33PxfrrHDCZt701ZuH3if28ilR3mBxWHq2Z1Rf6/qZh1d+ZG4jKwMyh4cOcs0MWJWk95p1tSprgBNGFeTHF/GRzC/lfIF8Hp5jdtONa4Z0wrtCViIQxTXRePxaWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cBrE8AwZOoQ8Ac4Q07uDrYMzcO6kQQHatlxcJfXVkk=;
 b=KQXSPcXO7Y1iGojY5Gif0l5mqIvw+USis2D2vhv2Nw8ebCqcU2ioC+hBX7eCfooC42A5+VzS3yuJ7/bGdon4GqyzPBD1lM5FfYSSJOAipHfmlu4R8+EhhIlQUZ5810qBGj7XPXidOGRmjLnyF6zLy64QaURo7+IJm/viyDaF4bJitmJD6Td5SqwLEkDAmXNHqWpjvhZT0eQFFX0y859lxU6ZtTdKbAaYSKnbZxfkHJOmiVKuhE5Su1WO2fqbRDn0H48QL3i1jxq400yhlYc+efSlIUzxEdyW0e/nqIwNXqU1jd0ZCnDvWG3+FTxnLvpO4VmPPf7wEV0OzYd3gPLUqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cBrE8AwZOoQ8Ac4Q07uDrYMzcO6kQQHatlxcJfXVkk=;
 b=B5UArE955FAeJxNj/56E83aLg0HP1WH2/9yA23ANJKPSHk2k1RKMiWESw2KgfphPV1l2KAyktGEsw8KtSJp8aKrqNde6jkRFAO15g3AfZM0/D6yQA/ZIXhuXjbYQTycNdEeUZX50KWPq0qEFWo3t4wsJ9b8bimpukMXSxAiFtPU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3995.eurprd08.prod.outlook.com (20.179.12.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Wed, 14 Aug 2019 09:11:16 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Wed, 14 Aug 2019
 09:11:16 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v2 2/4] block/qcow2: refactor qcow2_co_preadv_part
Thread-Index: AQHVRuGxH7AsywKBiU6ATiEJn2mLZKb5rx2AgADDkIA=
Date: Wed, 14 Aug 2019 09:11:15 +0000
Message-ID: <85aa4552-1600-21aa-0407-128f63665aac@virtuozzo.com>
References: <20190730141826.709849-1-vsementsov@virtuozzo.com>
 <20190730141826.709849-3-vsementsov@virtuozzo.com>
 <ead713c5-ed20-096c-40cb-a4bb4b3658a6@redhat.com>
In-Reply-To: <ead713c5-ed20-096c-40cb-a4bb4b3658a6@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0213.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::13) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190814121113637
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f851fba9-663f-495a-f671-08d720975c67
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB3995; 
x-ms-traffictypediagnostic: DB8PR08MB3995:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB39958E128AA10D015D1BD603C1AD0@DB8PR08MB3995.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01294F875B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(136003)(376002)(366004)(396003)(346002)(189003)(199004)(102836004)(66946007)(66556008)(26005)(66446008)(8676002)(66476007)(99286004)(64756008)(6506007)(71200400001)(386003)(81166006)(71190400001)(31686004)(478600001)(81156014)(186003)(4326008)(53546011)(486006)(305945005)(6436002)(52116002)(76176011)(6486002)(6116002)(14454004)(25786009)(5660300002)(54906003)(316002)(2616005)(86362001)(2501003)(446003)(3846002)(6512007)(476003)(53936002)(229853002)(110136005)(11346002)(7736002)(14444005)(8936002)(6246003)(66066001)(2906002)(256004)(31696002)(36756003)(2201001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3995;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g1f2/2RGLGLkXb2oSVVmzcMAahHQNUamWytzIKLYA61DmkSF6/IqDUdw9yOlc7u1dy8bAguRJBDKglr0uWcfAVVlis8kurKfA+Kos8AGB1HJQ8uNSF7qFN5/xRkr9ZaxbxE2My/x3EhbHaz4HPAe7EBv3a7Bkize4agzEru3tmZ5vSfXKAomt6PeyyxZgHbSL5b+yJ7iYhv/SmQ6Oh2M5/1lMQQyeO0g/H6s0YRxzCYAgvmygfJiZrYpzCn384TU9Y8u+Nn3/lclUgN2866ulCPdLactonQ+QMudry0uJ3jwQQt7Wpv3MTg3hI8wzWi+XiZefrMpwpC5YiMnCSeFvzZW+/FdYEembSwWUUxRNEJ6t5IW+batHESxlIF3RuCpJBZ4N+4Q7nYVPTfvyyon2H/ZN/6vEUU6SJy67hee+Hg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6319F4A52409F4190977EA93B23EEA7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f851fba9-663f-495a-f671-08d720975c67
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 09:11:15.9733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xlSMax1zL+RlP0O7tcc6ewokDH/sjLV7J9P64ZeLVGACOhjdRU0G5R/8ldOMRRVrrS0kfVFyEL8DOsb/ZiHgXJFnUEcP5a7vzZ0A8M5kcoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3995
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.132
Subject: Re: [Qemu-devel] [PATCH v2 2/4] block/qcow2: refactor
 qcow2_co_preadv_part
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
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTQuMDguMjAxOSAwOjMxLCBNYXggUmVpdHogd3JvdGU6DQo+IE9uIDMwLjA3LjE5IDE2OjE4LCBW
bGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gRnVydGhlciBwYXRjaCB3aWxs
IHJ1biBwYXJ0aWFsIHJlcXVlc3RzIG9mIGl0ZXJhdGlvbnMgb2YNCj4+IHFjb3cyX2NvX3ByZWFk
diBpbiBwYXJhbGxlbCBmb3IgcGVyZm9ybWFuY2UgcmVhc29ucy4gVG8gcHJlcGFyZSBmb3INCj4+
IHRoaXMsIHNlcGFyYXRlIHBhcnQgd2hpY2ggbWF5IGJlIHBhcmFsbGVsaXplZCBpbnRvIHNlcGFy
YXRlIGZ1bmN0aW9uDQo+PiAocWNvdzJfY29fcHJlYWR2X3Rhc2spLg0KPj4NCj4+IFdoaWxlIGJl
aW5nIGhlcmUsIGFsc28gc2VwYXJhdGUgZW5jcnlwdGVkIGNsdXN0ZXJzIHJlYWRpbmcgdG8gb3du
DQo+PiBmdW5jdGlvbiwgbGlrZSBpdCBpcyBkb25lIGZvciBjb21wcmVzc2VkIHJlYWRpbmcuDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVu
dHNvdkB2aXJ0dW96em8uY29tPg0KPj4gLS0tDQo+PiAgIHFhcGkvYmxvY2stY29yZS5qc29uIHwg
ICAyICstDQo+PiAgIGJsb2NrL3Fjb3cyLmMgICAgICAgIHwgMjA2ICsrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMTIgaW5z
ZXJ0aW9ucygrKSwgOTYgZGVsZXRpb25zKC0pDQo+IA0KPiBMb29rcyBnb29kIHRvIG1lIG92ZXJh
bGwsIGp1c3Qgd29uZGVyaW5nIGFib3V0IHNvbWUgZGV0YWlscywgYXMgYWx3YXlzLg0KPiANCj4+
IGRpZmYgLS1naXQgYS9ibG9jay9xY293Mi5jIGIvYmxvY2svcWNvdzIuYw0KPj4gaW5kZXggOTNh
YjdlZGNlYS4uN2ZhNzE5NjhiMiAxMDA2NDQNCj4+IC0tLSBhL2Jsb2NrL3Fjb3cyLmMNCj4+ICsr
KyBiL2Jsb2NrL3Fjb3cyLmMNCj4+IEBAIC0xOTY3LDE3ICsxOTY3LDExNSBAQCBvdXQ6DQo+PiAg
ICAgICByZXR1cm4gcmV0Ow0KPj4gICB9DQo+PiAgIA0KPj4gK3N0YXRpYyBjb3JvdXRpbmVfZm4g
aW50DQo+PiArcWNvdzJfY29fcHJlYWR2X2VuY3J5cHRlZChCbG9ja0RyaXZlclN0YXRlICpicywN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCBmaWxlX2NsdXN0ZXJfb2Zm
c2V0LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IG9mZnNldCwNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCBieXRlcywNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICBRRU1VSU9WZWN0b3IgKnFpb3YsDQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdWludDY0X3QgcWlvdl9vZmZzZXQpDQo+PiArew0KPj4gKyAgICBpbnQg
cmV0Ow0KPj4gKyAgICBCRFJWUWNvdzJTdGF0ZSAqcyA9IGJzLT5vcGFxdWU7DQo+PiArICAgIHVp
bnQ4X3QgKmJ1ZjsNCj4+ICsNCj4+ICsgICAgYXNzZXJ0KGJzLT5lbmNyeXB0ZWQgJiYgcy0+Y3J5
cHRvKTsNCj4+ICsgICAgYXNzZXJ0KGJ5dGVzIDw9IFFDT1dfTUFYX0NSWVBUX0NMVVNURVJTICog
cy0+Y2x1c3Rlcl9zaXplKTsNCj4+ICsNCj4+ICsgICAgLyoNCj4+ICsgICAgICogRm9yIGVuY3J5
cHRlZCBpbWFnZXMsIHJlYWQgZXZlcnl0aGluZyBpbnRvIGEgdGVtcG9yYXJ5DQo+PiArICAgICAq
IGNvbnRpZ3VvdXMgYnVmZmVyIG9uIHdoaWNoIHRoZSBBRVMgZnVuY3Rpb25zIGNhbiB3b3JrLg0K
Pj4gKyAgICAgKiBOb3RlLCB0aGF0IHdlIGNhbiBpbXBsZW1lbnQgZW5jdHlwdGlvbiwgd29ya2lu
ZyBvbiBxaW92LA0KPiANCj4gLSwgYW5kIHMvZW5jdHlwdGlvbi9lbmNyeXB0aW9uLw0KPiANCj4+
ICsgICAgICogYnV0IHdlIG11c3Qgbm90IGRvIGRlY3J5cHRpb24gaW4gZ3Vlc3QgYnVmZmVycyBm
b3Igc2VjdXJpdHkNCj4+ICsgICAgICogcmVhc29ucy4NCj4gDQo+ICJmb3Igc2VjdXJpdHkgcmVh
c29ucyIgaXMgYSBiaXQgaGFuZHdhdmUteSwgbm8/DQoNCkhtbSwgbGV0J3MgdGhpbmsgb2YgaXQg
YSBiaXQuDQoNCldSSVRFDQoNCjEuIFdlIGNhbid0IGRvIGFueSBvcGVyYXRpb25zIG9uIHdyaXRl
IGJ1ZmZlcnMsIGFzIGd1ZXN0IG1heSB1c2UgdGhlbSBmb3INCnNvbWV0aGluZyBlbHNlIGFuZCBu
b3QgcHJlcGFyZWQgZm9yIHRoZWlyIGNoYW5nZS4gW3RoeCB0byBEZW4sIHBvaW50ZWQgdG8gdGhp
cyBmYWN0XQ0KDQpSRUFEDQoNCkhtbSwgaGVyZSBvdGhlcndpc2UsIGd1ZXN0IHNob3VsZCBub3Qg
ZXhwZWN0IHNvbWV0aGluZyBtZWFuaW5nZnVsIGluIGJ1ZmZlcnMgdW50aWwgdGhlDQplbmQgb2Yg
cmVhZCBvcGVyYXRpb24sIHNvIHRoZW9yZXRpY2FsbHkgd2UgbWF5IGRlY3J5cHQgZGlyZWN0bHkg
aW4gZ3Vlc3QgYnVmZmVyLi4gV2hhdCBpcw0KYmFkIHdpdGggaXQ/DQoNCjEuIE1ha2luZyByZWFk
LXBhcnQgZGlmZmVyZW50IGZyb20gd3JpdGUgYW5kIGltcGxlbWVudGluZyBzdXBwb3J0IG9mIHFp
b3YgZm9yIGRlY3J5cHRpbiBmb3INCmxpdHRsZSBvdXRjb21lIChobW0sIGRvbid0IGRvdWJsZSBh
bGxvY2F0aW9uIGZvciByZWFkcywgaXMgaXQgbGl0dGxlIG9yIG5vdD8gWypdKS4NCg0KMi4gR3Vl
c3QgY2FuIHJlYWQgaXRzIGJ1ZmZlcnMuDQpTbywgaXQgbWF5IHNlZSBlbmNyeXB0ZWQgZGF0YSBh
bmQgZ3Vlc3Mgc29tZXRoaW5nIGFib3V0IGl0LiBJZGVhbGx5IGd1ZXN0DQpzaG91bGQga25vdyBu
b3RoaW5nIGFib3V0IGVuY3J5cHRpb24sIGJ1dCBvbiB0aGUgb3RoZXIgaGFuZCwgaXMgdGhlcmUg
YW55DQpyZWFsIGRhbWFnZT8gSSBkb24ndCBzdXJlLi4NCg0KMy4gR3Vlc3QgY2FuIG1vZGlmeSBp
dHMgYnVmZmVycy4NCjMuMSBJIHRoaW5rIHRoZXJlIGlzIG5vIGd1YXJhbnRlZSB0aGF0IGd1ZXN0
IHdpbGwgbm90IG1vZGlmeSBpdHMgZGF0YSBiZWZvcmUgd2UgZmluaXNoZWQNCmNvcHlpbmcgdG8g
c2VwYXJhdGUgYnVmZmVyLCBzbyB3aGF0IGd1ZXN0IGZpbmFsbHkgcmVhZHMgaXMgbm90IHByZWRp
Y3RhYmxlIGFueXdheS4NCjMuMiBCdXQsIG1vZGlmeWluZyBkdXJpbmcgZGVjcnlwdGlvbiBtYXkg
cG9zc2libHkgbGVhZCB0byBndWVzdCB2aXNpYmxlIGVycm9yDQood2hpY2ggd2lsbCBuZXZlciBi
ZSBpZiB3ZSBvcGVyYXRlIG9uIHNlcGFyYXRlZCBjbHVzdGVyKQ0KDQpTbyBpZiB3ZSBkb24ndCBh
ZnJhaWQgb2YgWzJdIGFuZCBbMy4yXSwgYW5kIGluIGEgc3BlY2lmaWMgY2FzZSBbKl0gaXMgc2ln
bmlmaWNhbnQsIHdlIG1heSB3YW50DQppbXBsZW1lbnQgZGVjcnlwdGlvbiBvbiBndWVzdCBidWZm
ZXJzIGF0IGxlYXN0IGFzIGFuIG9wdGlvbi4uDQpCdXQgYWxsIGl0IGxvb2tzIGZvciBtZSBsaWtl
IHdlJ2xsIG5ldmVyIGRvIGl0Lg0KDQo9PT0NCg0KU28sIEknZCByZXdyaXRlIG15ICJOb3RlIiBs
aWtlIHRoaXM6DQoNCiAgICBBbHNvLCBkZWNyeXB0aW9uIGluIHNlcGFyYXRlIGJ1ZmZlciBpcyBi
ZXR0ZXIgYXMgaXQgaGlkZXMgZnJvbSB0aGUgZ3Vlc3QgaW5mb3JtYXRpb24NCiAgICBpdCBkb2Vz
bid0IG93biAoYWJvdXQgZW5jcnlwdGVkIG5hdHVyZSBvZiB2aXJ0dWFsIGRpc2spLg0KDQo+IA0K
PiBbLi4uXQ0KPiANCj4+ICtzdGF0aWMgY29yb3V0aW5lX2ZuIGludCBxY293Ml9jb19wcmVhZHZf
dGFzayhCbG9ja0RyaXZlclN0YXRlICpicywNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBRQ293MkNsdXN0ZXJUeXBlIGNsdXN0ZXJfdHlwZSwNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCBmaWxl
X2NsdXN0ZXJfb2Zmc2V0LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHVpbnQ2NF90IG9mZnNldCwgdWludDY0X3QgYnl0ZXMsDQo+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUUVNVUlPVmVjdG9yICpxaW92LA0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVfdCBx
aW92X29mZnNldCkNCj4+ICt7DQo+PiArICAgIEJEUlZRY293MlN0YXRlICpzID0gYnMtPm9wYXF1
ZTsNCj4+ICsgICAgaW50IG9mZnNldF9pbl9jbHVzdGVyID0gb2Zmc2V0X2ludG9fY2x1c3Rlcihz
LCBvZmZzZXQpOw0KPj4gKw0KPj4gKyAgICBzd2l0Y2ggKGNsdXN0ZXJfdHlwZSkgew0KPiANCj4g
Wy4uLl0NCj4gDQo+PiArICAgIGRlZmF1bHQ6DQo+PiArICAgICAgICBnX2Fzc2VydF9ub3RfcmVh
Y2hlZCgpOw0KPj4gKyAgICAgICAgLyoNCj4+ICsgICAgICAgICAqIFFDT1cyX0NMVVNURVJfWkVS
T19QTEFJTiBhbmQgUUNPVzJfQ0xVU1RFUl9aRVJPX0FMTE9DIGhhbmRsZWQNCj4+ICsgICAgICAg
ICAqIGluIHFjb3cyX2NvX3ByZWFkdl9wYXJ0DQo+IA0KPiBIbW0sIEnigJlkIHN0aWxsIGFkZCB0
aGVtIGV4cGxpY2l0bHkgYXMgY2FzZXMgYW5kIHB1dCB0aGVpciBvd24NCj4gZ19hc3NlcnRfbm90
X3JlYWNoKCkgdGhlcmUuDQo+IA0KPj4gKyAgICAgICAgICovDQo+PiArICAgIH0NCj4+ICsNCj4+
ICsgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsNCj4+ICsNCj4+ICsgICAgcmV0dXJuIC1FSU87
DQo+IA0KPiBNYXliZSBhYm9ydCgpaW5nIGluc3RlYWQgb2YgZ19hc3NlcnRfbm90X3JlYWNoKCkg
d291bGQgc2F2ZSB5b3UgZnJvbQ0KPiBoYXZpbmcgdG8gcmV0dXJuIGhlcmU/DQo+IA0KDQpIbW0s
IHdpbGwgY2hlY2suIEFueSByZWFzb24gdG8gdXNlIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCkgaW5z
dGVhZCBvZiBhYm9ydCgpIGluICJkZWZhdWx0Ij8NCkkganVzdCBrZXB0IGl0IGxpa2UgaXQgd2Fz
LiBCdXQgaXQgc2VlbXMgdG8gYmUgbW9yZSBvZnRlbiBwcmFjdGljZSB0byB1c2UganVzdCBhYm9y
dCgpIGluDQpRZW11IGNvZGUuDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

