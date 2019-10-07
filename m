Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2454CC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:34:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E676520700
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="K2uVeixs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E676520700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHVy9-00083M-Np
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 12:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHVmT-0003YP-DI
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHVmR-0006ra-Tv
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:22:41 -0400
Received: from mail-eopbgr10117.outbound.protection.outlook.com
 ([40.107.1.117]:8251 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iHVmR-0006qr-3R; Mon, 07 Oct 2019 12:22:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7fFXN02AzphW6/Z9xLBNZn3IlNYaOLV60AXUABQo81ZEiMqJWnXqXAXqBnVyd5/SjXFbi1Pk478HYQzRUrJwwQNgFk3/3/FfqXjdVmORn35EJybspeIS7JFunep2tW+vtbLz4k4Z5ZWHMK9nK2wIklkg3g5mfA23RO7uBrB3LT0PczqPYiL8xVtAUo9kj5TBCs0B0+SJtnZYdFr5lGWifLkzqe9dpbXKFKJ0IDZwmGmUpVqXv8CuHd5IYe+EzuemO0PgjuwtkxwvSlRHmreI6OOy35iMQP34b9V2mQruXcZ9SjPx2xT4CTPQIe65e2momacAwLGy2bOqRpG+M/6SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdLhhdA3CGipJXmUDWDW85HwCQKvULGpQoll/bP4KwE=;
 b=cGOXAno8V9kX4S4L3xGKbtFrwzQpWEORx092DKbD4tNTRz29oDtVhT+gsWRVLGybCCkZxoXpO0bqZpgG7aQQDFHQzh1MtnaDd1Y/KFzSGPDewn7+hAQsvbbnvj8xBsrEGC/wt6+WPQw0RfmU8MyHJ25jLVqNXubv766ePGknPn5HdK1EG0RemvWqHgCmcGkQjNQ4JxKgGPDlpdvNvQ9inRVK5wOWbE/UGHmx+Y3BZdhvweXsnvvCvynQmgK0v1y7H1DBwIz/PDOjSA/aCjTdvHoTOavEHdQbPbPM+wykNPdcpp3SCvnGqpRd8NBfy+QyQ8QE03PiNWS0nTyo6Aw/1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdLhhdA3CGipJXmUDWDW85HwCQKvULGpQoll/bP4KwE=;
 b=K2uVeixsfCT//K1JHGb4gsbkMvC5R4Fz3xlfhHtl/HuUe5RDj+8++kWS078yYtW8yBDs1POyz2iFOLQTmBkapiTbTrE66NENabDlcteq82VPD9yPv9ajHvunDIGJaexRbx0dMVGvCyogPS7fRd/xZxFfv4Hw2gvcYKWW5kIjilc=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5371.eurprd08.prod.outlook.com (52.133.240.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.25; Mon, 7 Oct 2019 16:22:35 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2327.023; Mon, 7 Oct 2019
 16:22:35 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 6/6] block/block-copy: increase buffered copy request
Thread-Topic: [PATCH 6/6] block/block-copy: increase buffered copy request
Thread-Index: AQHVeg4ynth9X7X//UWnJvT5uNEBcqdPWUqAgAAJcoA=
Date: Mon, 7 Oct 2019 16:22:35 +0000
Message-ID: <0dab53ed-c993-c923-2374-bad9faece27d@virtuozzo.com>
References: <20191003171539.12327-1-vsementsov@virtuozzo.com>
 <20191003171539.12327-7-vsementsov@virtuozzo.com>
 <441fc41e-0432-978a-9568-60b651cbf25b@redhat.com>
In-Reply-To: <441fc41e-0432-978a-9568-60b651cbf25b@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::33) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191007192233183
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f96f0f1f-3b88-43a2-5341-08d74b42902d
x-ms-traffictypediagnostic: DB8PR08MB5371:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5371C6C28B57753A347CB78BC19B0@DB8PR08MB5371.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(346002)(376002)(396003)(366004)(136003)(199004)(189003)(486006)(478600001)(81166006)(81156014)(476003)(86362001)(31696002)(25786009)(8936002)(7736002)(8676002)(5660300002)(305945005)(186003)(446003)(11346002)(52116002)(54906003)(76176011)(26005)(110136005)(53546011)(6506007)(386003)(316002)(102836004)(2616005)(99286004)(107886003)(229853002)(71190400001)(6486002)(71200400001)(14444005)(36756003)(2501003)(256004)(66556008)(64756008)(66946007)(66476007)(66446008)(4326008)(6246003)(6512007)(2906002)(6436002)(31686004)(14454004)(66066001)(3846002)(6116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5371;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Aos7jaAsiPsXim8Nl8jcwhxC0m4KHkzH1G7g2Kser6qDNrT0+6BMbDXEBo9iFmvgkaS9TvfJKQ4spPTNQmbg9tTsiueGuetF5JD3Lycz7X/Oj8rG6M31Asg+6DHRWeCvPxtc4zKApAb6bEIRv+Dxsh/8h0cy/EFYBYwf9Mp2Q7W95g+eTHYkDQ28no5k4heddiUGfFjWkVW1ix6ue9n+IuE5d8cbhldMv+HFRPkZbUoVUoWJaV7SUB/m+ALXrdq8QUY54lmuoo8mIpafWl1XS+JpMx7t7OHNgjkR1okf6U5VSsnxZDkaEL88MlUEkMPh9mNCfQgS/WQOBC18pCFVfuIvnaD/BpGFdUgmjaxo11RQmjCjSfDuyUD+e40thKxe1jwYPNfZfEzNr2IbnIsgvPnrSKwkZwvZKjz0iPbSFuw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EDC68C159AD5C478202DD58A7F389F0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96f0f1f-3b88-43a2-5341-08d74b42902d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 16:22:35.6930 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GwCAFzT/lgfwkrnSwxoZ+fENRTTxAjcTjMrbMWz7MTJeVSBDqAGtWGQtCUthrrd/CUNPPBlYfCpTng7nmgrZiuRL/5uqNF+43ojrrWX8JXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5371
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.117
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
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDcuMTAuMjAxOSAxODo0OCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwMy4xMC4xOSAxOToxNSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IE5vIHJlYXNvbiB0byBsaW1p
dCBidWZmZXJlZCBjb3B5IHRvIG9uZSBjbHVzdGVyLiBMZXQncyBhbGxvdyB1cCB0byAxDQo+PiBN
aUIuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8
dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4gLS0tDQo+PiAgIGluY2x1ZGUvYmxvY2svYmxv
Y2stY29weS5oIHwgIDIgKy0NCj4+ICAgYmxvY2svYmxvY2stY29weS5jICAgICAgICAgfCA0NCAr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQ0KPj4gICAyIGZpbGVzIGNoYW5n
ZWQsIDMyIGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPiANCj4gDQo+IEVyLCBvb3Bz
LCBsb29rcyBsaWtlIEkgd2FzIGEgYml0IHF1aWNrIHRoZXJlLi4uDQo+IA0KPj4gQEAgLTEwMCwx
NyArMTAxLDI4IEBAIEJsb2NrQ29weVN0YXRlICpibG9ja19jb3B5X3N0YXRlX25ldyhCZHJ2Q2hp
bGQgKnNvdXJjZSwgQmRydkNoaWxkICp0YXJnZXQsDQo+PiAgICAgICAgICAgLm1lbSA9IHFlbXVf
Y29fc2hhcmVkX2Ftb3VudF9uZXcoQkxPQ0tfQ09QWV9NQVhfTUVNKSwNCj4+ICAgICAgIH07DQo+
PiAgIA0KPj4gLSAgICBzLT5jb3B5X3JhbmdlX3NpemUgPSBRRU1VX0FMSUdOX0RPV04obWF4X3Ry
YW5zZmVyLCBjbHVzdGVyX3NpemUpLA0KPj4gLSAgICAvKg0KPj4gLSAgICAgKiBTZXQgdXNlX2Nv
cHlfcmFuZ2UsIGNvbnNpZGVyIHRoZSBmb2xsb3dpbmc6DQo+PiAtICAgICAqIDEuIENvbXByZXNz
aW9uIGlzIG5vdCBzdXBwb3J0ZWQgZm9yIGNvcHlfcmFuZ2UuDQo+PiAtICAgICAqIDIuIGNvcHlf
cmFuZ2UgZG9lcyBub3QgcmVzcGVjdCBtYXhfdHJhbnNmZXIgKGl0J3MgYSBUT0RPKSwgc28gd2Ug
ZmFjdG9yDQo+PiAtICAgICAqICAgIHRoYXQgaW4gaGVyZS4gSWYgbWF4X3RyYW5zZmVyIGlzIHNt
YWxsZXIgdGhhbiB0aGUgam9iLT5jbHVzdGVyX3NpemUsDQo+PiAtICAgICAqICAgIHdlIGRvIG5v
dCB1c2UgY29weV9yYW5nZSAoaW4gdGhhdCBjYXNlIGl0J3MgemVybyBhZnRlciBhbGlnbmluZyBk
b3duDQo+PiAtICAgICAqICAgIGFib3ZlKS4NCj4+IC0gICAgICovDQo+PiAtICAgIHMtPnVzZV9j
b3B5X3JhbmdlID0NCj4+IC0gICAgICAgICEod3JpdGVfZmxhZ3MgJiBCRFJWX1JFUV9XUklURV9D
T01QUkVTU0VEKSAmJiBzLT5jb3B5X3JhbmdlX3NpemUgPiAwOw0KPj4gKyAgICBpZiAobWF4X3Ry
YW5zZmVyIDwgY2x1c3Rlcl9zaXplKSB7DQo+PiArICAgICAgICAvKg0KPj4gKyAgICAgICAgICog
Y29weV9yYW5nZSBkb2VzIG5vdCByZXNwZWN0IG1heF90cmFuc2Zlci4gV2UgZG9uJ3Qgd2FudCB0
byBib3RoZXINCj4+ICsgICAgICAgICAqIHdpdGggcmVxdWVzdHMgc21hbGxlciB0aGFuIGJsb2Nr
LWNvcHkgY2x1c3RlciBzaXplLCBzbyBmYWxsYmFjayB0bw0KPj4gKyAgICAgICAgICogYnVmZmVy
ZWQgY29weWluZyAocmVhZCBhbmQgd3JpdGUgcmVzcGVjdCBtYXhfdHJhbnNmZXIgb24gdGhlaXIN
Cj4+ICsgICAgICAgICAqIGJlaGFsZikuDQo+PiArICAgICAgICAgKi8NCj4+ICsgICAgICAgIHMt
PnVzZV9jb3B5X3JhbmdlID0gZmFsc2U7DQo+PiArICAgICAgICBzLT5jb3B5X3NpemUgPSBjbHVz
dGVyX3NpemU7DQo+PiArICAgIH0gZWxzZSBpZiAod3JpdGVfZmxhZ3MgJiBCRFJWX1JFUV9XUklU
RV9DT01QUkVTU0VEKSB7DQo+PiArICAgICAgICAvKiBDb21wcmVzc2lvbiBpcyBub3Qgc3VwcG9y
dGVkIGZvciBjb3B5X3JhbmdlICovDQo+PiArICAgICAgICBzLT51c2VfY29weV9yYW5nZSA9IGZh
bHNlOw0KPj4gKyAgICAgICAgcy0+Y29weV9zaXplID0gTUFYKGNsdXN0ZXJfc2l6ZSwgQkxPQ0tf
Q09QWV9NQVhfQlVGRkVSKTsNCj4+ICsgICAgfSBlbHNlIHsNCj4+ICsgICAgICAgIC8qDQo+PiAr
ICAgICAgICAgKiBjb3B5X3JhbmdlIGRvZXMgbm90IHJlc3BlY3QgbWF4X3RyYW5zZmVyIChpdCdz
IGEgVE9ETyksIHNvIHdlIGZhY3Rvcg0KPj4gKyAgICAgICAgICogdGhhdCBpbiBoZXJlLg0KPj4g
KyAgICAgICAgICovDQo+PiArICAgICAgICBzLT51c2VfY29weV9yYW5nZSA9IHRydWU7DQo+PiAr
ICAgICAgICBzLT5jb3B5X3NpemUgPSBNSU4oTUFYKGNsdXN0ZXJfc2l6ZSwgQkxPQ0tfQ09QWV9N
QVhfQ09QWV9SQU5HRSksDQo+IA0KPiBUaGlzIGlzIGFscmVhZHkgcGFydCBvZiBtYXhfdHJhbnNm
ZXIsIGlzbuKAmXQgaXQ/DQo+IA0KPiAoVGhhdCBkb2VzbuKAmXQgbWFrZSBpdCB3cm9uZywgYnV0
IEkgdGhpbmsgbWF4X3RyYW5zZmVyIHdpbGwgYWx3YXlzIGJlDQo+IGxlc3MgdGhhbiBvciBlcXVh
bCB0byBNQVgoY2x1c3Rlcl9zaXplLCBCTE9DS19DT1BZX01BWF9DT1BZX1JBTkdFKSBhbnl3YXku
KQ0KPiANCj4gTWF4DQoNCkhtbSwgb29wcywgeWVzLiBJdCdkIGJldHRlciBiZSBqdXN0IFFFTVVf
QUxJR05fRE9XTihtYXhfdHJhbnNmZXIsIGNsdXN0ZXJfc2l6ZSkNCg0KPiANCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICBRRU1VX0FMSUdOX0RPV04obWF4X3RyYW5zZmVyLCBjbHVzdGVy
X3NpemUpKTsNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

