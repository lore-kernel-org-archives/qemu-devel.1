Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20C5C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:58:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC86D20717
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="d74n6maA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC86D20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igsls-0002Ez-Ra
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 10:58:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1igsl9-0001Gt-0x
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:58:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1igsl7-0006Tp-D5
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:58:10 -0500
Received: from mail-eopbgr130094.outbound.protection.outlook.com
 ([40.107.13.94]:6030 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1igsl6-0006Lu-Nv; Mon, 16 Dec 2019 10:58:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WH0HsiU1E3qz3ye6QV4dY6N/mPP3ZljFXM/BPhczgTuK3c9cQFle0Yio70lb/vGWOfnyvOkuYb7FBGcQ15Yp+ruC0VTlrFQ+DNmr/bwCuKo2fmDGy2vdqmnBa0oVXJBHAJ5H+rcVeL2o+pYn7NYwu6dxf5d09Zh2H2+EkSTf62O1FuF0Wl5O3/Y/MgNCt+g5Ti9f1tZc/ifGTrNioYCTdK9yUwZVi9Zb0tq1tJBvLtwYOQAoK/ksSFDK2G8rXUKuZsJA2dn9gXOBgD7PyyhpOHdYO0zGuGYMe8JpSyX6RK0BO/mj9+8o3xYwi6AqGasrRC/FWirYQ+Q8APat3C3Pgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8Bf0k7k95c+V52zAvo4yDHpxlcv1jU2AWMkmf6Ukiw=;
 b=lDi4BBCefo3KV27/LCEZB08VFIz7pTc5ZIB3loPJjZcHwhC6zWiE1AXud8DHHwaUNqkIZcwrwL+eY7Yr0Cp7viDjZ5ngWRpi2t312HOWDEbPUCUkooWilm1IeacjFCaip/uSAgFHmw+6gbP/SRu/fA5FLIhDC6eBJgSg8p9J8lvBTFHU2mxpewMzqCa6hrejb+DTSHJa9z0Q6qhTQKw7doxOSVkvxvDClQ3cQ4WcJonWr5VYJr/tq4R6i/rHRE4IxaVRr5itlC97QMD4eS8fotQmq2anzn+hZHxDMEd+Y2wHqD+jmiJq3grjn1iyHQzE43dRuKDjkQxAYl0VsCJlMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8Bf0k7k95c+V52zAvo4yDHpxlcv1jU2AWMkmf6Ukiw=;
 b=d74n6maAs+6sIw3ox1eScxgh07Zd3B+rfGkibDiSQ3nONGCQdh/Tp966qX4idXliBwfuanEPNhpqqQzX3seZFt3+3VpnniiTailqLYMz8lmGBgCXR00dpgdZGJBRLGoO2Y6FE6/ZGI6G46UEWRQNYQq/ewcrcNnanm+v1XD8FEU=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB4036.eurprd08.prod.outlook.com (20.178.119.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Mon, 16 Dec 2019 15:58:05 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::893d:bf37:4b98:12]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::893d:bf37:4b98:12%4]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 15:58:05 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v0 2/2] block: allow to set 'drive' property on a realized
 block device
Thread-Topic: [PATCH v0 2/2] block: allow to set 'drive' property on a
 realized block device
Thread-Index: AQHVl/muMyF4ca4YdU2Ub7M+IU0rR6eE9tyAgAvVKACAJ0VZAIAFMa2A///atYCAAAV+AA==
Date: Mon, 16 Dec 2019 15:58:05 +0000
Message-ID: <089551c1-54d0-dd75-1700-2bfd1c49eebe@virtuozzo.com>
References: <20191110190310.19799-1-dplotnikov@virtuozzo.com>
 <20191110190310.19799-3-dplotnikov@virtuozzo.com>
 <c19343f9-73b2-89a4-2b7d-b101a0b20016@virtuozzo.com>
 <c38c1301-a28f-baf1-d441-ae8c7205feb1@virtuozzo.com>
 <20191213103246.GB3428@localhost.localdomain>
 <e982f384-0d94-7519-8cb1-48208025217a@virtuozzo.com>
 <20191216153823.GD6610@linux.fritz.box>
In-Reply-To: <20191216153823.GD6610@linux.fritz.box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P192CA0006.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::16)
 To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.233.241.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15e2e9cc-6d28-42a9-72ba-08d78240bcb6
x-ms-traffictypediagnostic: AM0PR08MB4036:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB4036EEF0280838406BFE2DCDCF510@AM0PR08MB4036.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(136003)(396003)(39840400004)(376002)(199004)(189003)(66946007)(6506007)(71200400001)(53546011)(4326008)(6916009)(186003)(6512007)(66446008)(8676002)(31696002)(6486002)(478600001)(26005)(31686004)(2616005)(36756003)(81156014)(86362001)(107886003)(81166006)(316002)(54906003)(52116002)(5660300002)(66556008)(64756008)(66476007)(8936002)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4036;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6W5bh3Ci7TO2qnisw0hgbSOJhlqp/eukIYjId6VYGqrZLoC9VIucK6FM0/d1tw2RudFZn/KYxvdFLT1zaNeMDabeJ9DtHkud0GrZ1XWJWeDlE0PIU7O0wZH7vs7rs//2ilLXfXeub3gcK6w1/00ehpeZv7zfKJyrvZhsoEvwDqH1sV3tk8sj5/094tTpku4polJNr9HhznBqjMfFKQ6HEsEgECDRQDpVnYVNTkK0Mtl2xr6WnI4GJ40vLxPZh7SchWodlYNsTyFCCgM5Z7rjStz/EyapZaiW/R6reqWOIGf9FXk7F/hIc/LSTImUa3F6BdUgxNCKG1NBPyGX4WWuyVFDqISDNHKVzTM4JBvnfU6QRjbaPWfGFX8cHsK5ooMAoFghuhwsZfhaL6rDeFdukYXARRKjMTRPIJ/f+yxhOkJcu7WAhqaKyiB913ym3j7e
Content-Type: text/plain; charset="utf-8"
Content-ID: <702A05032714C24183872156DECC19A9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e2e9cc-6d28-42a9-72ba-08d78240bcb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 15:58:05.3444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K186znwUdsSiWQQiTrC5JDhLGyYL/VPO/h8CPd48qhgWA+pUMPPbpsFaXAS93K6u90OCnub8oNIf+HPEmU/YCgUbORFuSMwLsET5EzQp1lY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4036
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.94
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDE2LjEyLjIwMTkgMTg6MzgsIEtldmluIFdvbGYgd3JvdGU6DQo+IEFtIDE2LjEyLjIw
MTkgdW0gMTU6NTEgaGF0IERlbmlzIFBsb3RuaWtvdiBnZXNjaHJpZWJlbjoNCj4+IE9uIDEzLjEy
LjIwMTkgMTM6MzIsIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4gQW0gMTguMTEuMjAxOSB1bSAxMTo1
MCBoYXQgRGVuaXMgUGxvdG5pa292IGdlc2NocmllYmVuOg0KPj4+PiBBbm90aGVyIHByb2JsZW0g
aGVyZSwgaXMgdGhhdCB0aGUgInNpemUiIG9mIHRoZSBkZXZpY2UgZGV2IG1heSBub3QgbWF0Y2gN
Cj4+Pj4gYWZ0ZXIgc2V0dGluZyBhIGRyaXZlLg0KPj4+PiBTbywgd2Ugc2hvdWxkIHVwZGF0ZSBp
dCBhZnRlciB0aGUgZHJpdmUgc2V0dGluZy4NCj4+Pj4gSXQgd2FzIGZvdW5kLCB0aGF0IGl0IGNv
dWxkIGJlIGRvbmUgYnkgY2FsbGluZw0KPj4+PiBCbG9ja0Rldk9wcy5iZHJ2X3BhcmVudF9jYl9y
ZXNpemUuDQo+Pj4+DQo+Pj4+IEJ1dCBJIGhhdmUgc29tZSBjb25jZXJucyBhYm91dCBkb2luZyBp
dCBzby4gSW4gdGhlIGNhc2Ugb2YgdmlydGlvIHNjc2kNCj4+Pj4gZGlzayB3ZSBoYXZlIHRoZSBm
b2xsb3dpbmcgY2FsbHN0YWNrDQo+Pj4+DQo+Pj4+ICAgIMKgwqDCoCBiZHJ2X3BhcmVudF9jYl9y
ZXNpemUgY2FsbHMoKSAtPg0KPj4+PiAgICDCoCDCoMKgwqDCoMKgIHNjc2lfZGV2aWNlX3JlcG9y
dF9jaGFuZ2UoZGV2LCBTRU5TRV9DT0RFKENBUEFDSVRZX0NIQU5HRUQpKSAtPg0KPj4+PiAgICDC
oCDCoCDCoCDCoCDCoCDCoCB2aXJ0aW9fc2NzaV9jaGFuZ2UgLT4NCj4+Pj4gICAgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZpcnRpb19zY3NpX3B1c2hfZXZlbnQocywgZGV2LCBWSVJU
SU9fU0NTSV9UX1BBUkFNX0NIQU5HRSwNCj4+Pj4gICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHNlbnNlLmFzYyB8DQo+Pj4+IChzZW5zZS5hc2NxIDw8IDgpKTsNCj4+PiBJIHRo
aW5rIHRoZSBzYWZlc3Qgb3B0aW9uIGZvciBub3cgKGFuZCB3aGljaCBzaG91bGQgc29sdmUgdGhl
IGNhc2UgeW91DQo+Pj4gd2FudCB0byBhZGRyZXNzKSBpcyBjaGVja2luZyB3aGV0aGVyIG9sZCBh
bmQgbmV3IHNpemUgbWF0Y2ggYW5kDQo+Pj4gcmV0dXJuaW5nIGFuIGVycm9yIG90aGVyd2lzZS4N
Cj4+Pg0KPj4+PiB2aXJ0aW9fc2NzaV9jaGFuZ2XCoCBwdXNoZXMgdGhlIGV2ZW50IHRvIHRoZSBn
dWVzdCB0byBtYWtlIHRoZSBndWVzdA0KPj4+PiBhc2sgZm9yIHNpemUgcmVmcmVzaGluZy4gIElm
IEknbSBub3QgbWlzdGFrZW4sIGhlcmUgd2UgY2FuIGdldCBhIHJhY2UNCj4+Pj4gY29uZGl0aW9u
IHdoZW4gc29tZSBhbm90aGVyIHJlcXVlc3QgaXMgcHJvY2Vzc2VkIHdpdGggYW4gdW5jaGFuZ2Vk
DQo+Pj4+IHNpemUgYW5kIHRoZW4gdGhlIHNpemUgY2hhbmdpbmcgcmVxdWVzdCBpcyBwcm9jZXNz
ZWQuDQo+Pj4gSSB0aGluayB0aGlzIGlzIGFjdHVhbGx5IGEgcHJvYmxlbSBldmVuIHdpdGhvdXQg
cmVzaXppbmc6IFdlIG5lZWQgdG8NCj4+PiBxdWllc2NlIHRoZSBkZXZpY2UgYmV0d2VlbiByZW1v
dmluZyB0aGUgb2xkIHJvb3QgYW5kIGluc2VydGluZyB0aGUgbmV3DQo+Pj4gb25lLiBUaGV5IHdh
eSB0byBhY2hpZXZlIHRoaXMgaXMgcHJvYmFibHkgYnkgc3BsaXR0aW5nIGJsa19kcmFpbigpIGlu
dG8NCj4+PiBhIGJsa19kcmFpbl9iZWdpbigpL2VuZCgpIGFuZCB0aGVuIGRyYWluaW5nIHRoZSBC
bG9ja0JhY2tlbmQgaGVyZSB3aGlsZQ0KPj4+IHdlJ3JlIHdvcmtpbmcgb24gaXQuDQo+Pj4NCj4+
PiBLZXZpbg0KPj4gV2h5IGRvbid0IHdlIHVzZSBiZHJ2X2RyYWluZWRfYmVnaW4vZW5kIGRpcmVj
dGx5PyBUaGlzIGlzIHdoYXQNCj4+IGJsa19kcmFpbiBkb2VzLg0KPj4gSWYgd2Ugd2FudCB0byBz
cGxpdCBibGtfZHJhaW4gd2UgbXVzdCBrZWVwIHRyYWNrIGlmIGJsaydzIGJyZHYgaXNuJ3QNCj4+
IGNoYW5nZSBvdGhlcndpc2Ugd2UgY2FuIGVuZCB1cCB3aXRoIGRyYWluX2JlZ2luIG9uZSBhbmQg
ZHJhaW4gZW5kDQo+PiBhbm90aGVyIGJkcnYgaWYgd2UgZG8gcmVtb3ZlL2luc2VydCBpbiBiZXR3
ZWVuLg0KPiBIbW0sIHRydWUsIHdlIHdvdWxkIGhhdmUgdG8ga2VlcCB0cmFjayBvZiBkcmFpbmlu
ZyBhdCB0aGUgQmxvY2tCYWNrZW5kDQo+IGxldmVsIGFuZCBjb25zaWRlciBpdCBpbiBibGtfcmVt
b3ZlX2JzKCkgYW5kIGJsa19pbnNlcnRfYnMoKS4gTWF5YmUNCj4gdGhhdCdzIG5vdCB3b3J0aCBp
dC4NCj4NCj4gSWYgd2UgdXNlIGJkcnZfZHJhaW5lZF9iZWdpbi9lbmQgZGlyZWN0bHksIEkgdGhp
bmsgd2UgbmVlZCB0byBkcmFpbiBib3RoDQo+IHRoZSBvbGQgYW5kIHRoZSBuZXcgcm9vdCBub2Rl
IGR1cmluZyB0aGUgcHJvY2Vzcy4NCj4NCj4+IEFub3RoZXIgdGhpbmcgaXMgc2hvdWxkIHdlIHJl
YWxseSBjYXJlIGFib3V0IHRoaXMgaWYgd2UgaGF2ZSBWTQ0KPj4gc3RvcHBlZCBhbmQgdGhlIHNp
emVzIG1hdGNoZWQ/DQo+IEhvdyBkbyB3ZSBrbm93IHRoYXQgdGhlIFZNIGlzIHN0b3BwZWQ/IEFu
ZCB3aHkgd291bGQgd2UgcmVxdWlyZSB0aGlzPw0KSSBpbXBsaWVkIHRoZSBzY2VuYXJpbyBvZiBW
TSBtaWdyYXRpb24gb3ZlciBhIHNoYXJlZCBzdG9yYWdlIHdpdGggYW4gDQpleGNsdXNpdmUgZmls
ZSBhY2Nlc3MgbW9kZWwuDQpUaGUgVk0gaXMgc3RvcHBlZCBvbiBkcml2ZSBjaGFuZ2luZyBwaGFz
ZS4NCg0KSWYgdGhlcmUgaXMgbm8gdXNlIHRvIHJlcXVpcmUgaXQsIHRoYW4gb2suDQoNCkRlbmlz
DQo+IFlvdXIgcGF0Y2ggZG9lc24ndCBpbXBsZW1lbnQgb3IgYXQgbGVhc3QgY2hlY2sgdGhpcywg
YW5kIGl0IHNlZW1zIGEgYml0DQo+IGltcHJhY3RpY2FsIGZvciBleGFtcGxlIHdoZW4gYWxsIHlv
dSB3YW50IGlzIGluc2VydGluZyBhIGZpbHRlciBub2RlLg0KPg0KPiBLZXZpbg0KDQoNCg==

