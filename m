Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EF2C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B52420872
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SPIyXx/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B52420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD28P-0003Pn-22
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 03:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD1u0-00080q-1G
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD1ty-00058G-RI
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:39:55 -0400
Received: from mail-eopbgr00130.outbound.protection.outlook.com
 ([40.107.0.130]:28134 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iD1tv-00056M-BS; Wed, 25 Sep 2019 03:39:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrYRCJVEjk8gOJtHW+QLwn2/pOsnfbqk3WuoDLEP8ng2yS/jUofhBJXVtpc11xJY/kcgXQa8q8saeChbROoXR1iowfgMThf8hkBhgLyTDWsXodJz20/cTHO+3aPDomRf5kfxmhPKYA9EDloZp3JMqto2cX30PjrvKrO8gfF3b/NhRLTkbuQJ1a4LZfuwqOCnaBXH+1DKMEZmmtsezdTQScxB7WXXzSs8fuXCvGEqf12VN1bxgESWUZF3grtZKtMsV3YnXa5sFJinpvEZ9vlIZ3rv1OK4htG2wfNcz3/FE5J4Nn2rj3QnuijzkJ9nzcoPwkQ/wi6AEjyKBrExeqdHhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Du8KTPVx7HT0Ck5oldeNlDA+JqMzKwf/vdVPmN2JYtc=;
 b=PJTEUtpyteeeeXRvsufiIGIhwADngvZElO8ux8WVisFiRhcTT1SMYQ+TH4aiY8YZhNl8glAIkzLoBGM8ILIMmP+b6zyALGlMFMQtX4maImvvrNHiayeo0pq+Dl/HBAtyDW+zTeyCKZCxmHajMGp2pa44scyJzP4Ms5ii2n9v6Tm5GUXXXZjHwdyoO7eyJCIZnr+BWCuj6uQzl385xoEwoJg2YEdHrtQ6fbIgS6f9oB7uY0BViCt2fzyaKzpDbErI1LGFnsTs+0MELnEh7VEcKmpby92asQyFgjXhbkjGMTuYHl6/mjbjJTyQeXrF4MLS2XgYoMO4nJCHZQOiHlu62w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Du8KTPVx7HT0Ck5oldeNlDA+JqMzKwf/vdVPmN2JYtc=;
 b=SPIyXx/Qp+uBqRAws41RiDW4+izIGtlAOdDeypgEiLlCDwNLRi49rYthDfTDxSCRADQ12olYRllRm/igTdldkX/p13mBIq2VX0lkTXar/HR1+aQzpYN67IY9+OEVCeqj3MWN1ZuceA1X9NFX84s20fRQyLdzresJviP62r53ubY=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4043.eurprd08.prod.outlook.com (20.179.10.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.23; Wed, 25 Sep 2019 07:39:47 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 07:39:47 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 24/25] nbd: Fix error_append_hint usage
Thread-Topic: [PATCH v3 24/25] nbd: Fix error_append_hint usage
Thread-Index: AQHVcxQIg+xW6HUg2UKmVj9KgUHnFac7U2kAgACvO4A=
Date: Wed, 25 Sep 2019 07:39:47 +0000
Message-ID: <6d41e8b4-008c-f962-5710-4939aa91aa82@virtuozzo.com>
References: <20190924200902.4703-1-vsementsov@virtuozzo.com>
 <20190924200902.4703-25-vsementsov@virtuozzo.com>
 <e417c54c-9f14-09af-7857-a62f60fe8212@redhat.com>
In-Reply-To: <e417c54c-9f14-09af-7857-a62f60fe8212@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0004.eurprd03.prod.outlook.com
 (2603:10a6:3:76::14) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190925103945613
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba88ce51-e49d-4500-d4a2-08d7418b8a54
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4043; 
x-ms-traffictypediagnostic: DB8PR08MB4043:
x-microsoft-antispam-prvs: <DB8PR08MB40431288AC875201596922D5C1870@DB8PR08MB4043.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(136003)(366004)(346002)(376002)(189003)(199004)(3846002)(31696002)(229853002)(6116002)(71200400001)(86362001)(71190400001)(478600001)(66556008)(64756008)(66446008)(14454004)(66946007)(8936002)(446003)(25786009)(81166006)(2616005)(8676002)(476003)(6436002)(31686004)(66476007)(11346002)(6486002)(2906002)(5660300002)(256004)(14444005)(2501003)(76176011)(305945005)(102836004)(386003)(6506007)(36756003)(53546011)(54906003)(81156014)(4326008)(316002)(186003)(110136005)(486006)(66066001)(26005)(52116002)(7736002)(6512007)(6246003)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4043;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:3; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Tud1zHkQqiPdSCW72MhdhuZl1FuZxkTMd1Wl9ZhtnykrmUvy7Ey4YBfyuFVFjVsSApFbYISYCBSaCh+j3Gr+++TTutOTEhr+t8oaKRUI0P8zqupv3remmcammgYRASQfRbdTKtsgHtb1NL7ydwfYRlsYKTvLK2FhIJwo8HXk6HNO8OB+KdJZ5zlyZ2/t+90OC893TIaOAlD82V/4FzmRg72bUYJQqNfl+6t8rZ7Nt4cEdHtrOZ3gNfwzXTTQ+7EEnlsMiZM74GzMtzLcMN2pvmBXQCcHAqPbJgFffpFCYg2RrxyQVdMwq3cyAMasZVHzH+htX/X0mi5LXdjtAoXgNMj2HejmXQYT7RIj4A63wEuDET2FfHEoAwYqA728TcQT2LyydCqE3IKwTdIgZjw/fnwK2Uv2o3V3ZFhYdBx/FzQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF68CDFEC5DEFC4488987F126D47047D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba88ce51-e49d-4500-d4a2-08d7418b8a54
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 07:39:47.5200 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3I8PlYvvHnEdIYexrkwltg7iX3SdjmLEvmqBqiYIUi7q8uSrLXbde4cDZD+1/fe2UTWOJ/tXMsvCiJpZIwAciuXMC6ICzSSj9GDpuz6d8EI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4043
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.130
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
Cc: Greg Kurz <groug@kaod.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjUuMDkuMjAxOSAwOjEyLCBFcmljIEJsYWtlIHdyb3RlOg0KPiBPbiA5LzI0LzE5IDM6MDkgUE0s
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+PiBJZiB3ZSB3YW50IGFwcGVu
ZCBoaW50IHRvIGVycnAsIHdlIG11c3QgdXNlIEVSUlBfRlVOQ1RJT05fQkVHSU4gbWFjcm8uDQo+
PiBPdGhlcndpc2UgaGludCB3aWxsIG5vdCBiZSBhcHBlbmRlZCBpbiBjYXNlIG9mIGVycnAgPT0g
JmZhdGFsX2Vycg0KPj4gKHByb2dyYW0gd2lsbCBleGl0IGJlZm9yZSBlcnJvcl9hcHBlbmRfaGlu
dCgpIGNhbGwpLiBGaXggc3VjaCBjYXNlcy4NCj4+DQo+IA0KPiBDb3B5LWFuZC1wYXN0ZWQsIGJ1
dCBpZiB5b3Ugd2FudCB0byB0d2VhayB0aGUgZ3JhbW1hciB0byBhbGwgb2YgdGhlDQo+IHBhdGNo
ZXMgd2l0aCBpZGVudGljYWwgYm9kaWVzOg0KPiANCj4gSWYgd2Ugd2FudCB0byBhcHBlbmQgYSBo
aW50IHRvIGVycnAsIHdlIG11c3QgdXNlIHRoZSBFUlJQX0ZVTkNUSU9OX0JFR0lODQo+IG1hY3Jv
LiAgT3RoZXJ3aXNlLCB0aGUgaGludCB3aWxsIG5vdCBiZSBhcHBlbmRlZCB3aGVuIGVycnAgPT0g
JmZhdGFsX2Vycg0KPiAodGhlIHByb2dyYW0gd2lsbCBleGl0IHByaW9yIHRvIHRoZSBlcnJvcl9h
cHBlbmRfaGludCgpIGNhbGwpLiAgRml4IHN1Y2gNCj4gY2FzZXMuDQoNCldpbGwgZG8sIHRoYW5r
cy4NCg0KPiANCj4+IFRoaXMgY29tbWl0ICh0b2dldGhlciB3aXRoIGl0cyBuZWlnaGJvcnMpIHdh
cyBnZW5lcmF0ZWQgYnkNCj4+DQo+PiBnaXQgZ3JlcCAtbCAnZXJyb3JfYXBwZW5kX2hpbnQoZXJy
cCcgfCB3aGlsZSByZWFkIGY7IGRvIFwNCj4+IHNwYXRjaCAtLXNwLWZpbGUgc2NyaXB0cy9jb2Nj
aW5lbGxlL2ZpeC1lcnJvcl9hcHBlbmRfaGludC11c2FnZS5jb2NjaSBcDQo+PiAtLWluLXBsYWNl
ICRmOyBkb25lDQo+Pg0KPj4gYW5kIHRoZW4NCj4+DQo+PiAuL3B5dGhvbi9jb21taXQtcGVyLXN1
YnN5c3RlbS5weSBNQUlOVEFJTkVSUyAiJCg8IGF1dG8tbXNnKSINCj4+DQo+PiAoYXV0by1tc2cg
d2FzIGEgZmlsZSB3aXRoIHRoaXMgY29tbWl0IG1lc3NhZ2UpDQo+Pg0KPj4gU3RpbGwsIGZvciBi
YWNrcG9ydGluZyBpdCBtYXkgYmUgbW9yZSBjb21mb3J0YWJsZSB0byB1c2Ugb25seSB0aGUgZmly
c3QNCj4+IGNvbW1hbmQgYW5kIHRoZW4gZG8gb25lIGh1Z2UgY29tbWl0Lg0KPj4NCj4+IFJlcG9y
dGVkLWJ5OiBHcmVnIEt1cnogPGdyb3VnQGthb2Qub3JnPg0KPj4gU2lnbmVkLW9mZi1ieTogVmxh
ZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4g
LS0tDQo+IA0KPiBTaG91bGQgdGhlIGNvbW1pdC1wZXItc3Vic3lzdGVtLnB5IHNjcmlwdCBhcHBl
bmQgYSBkaXN0aW5jdCBDQzogbGluZSBhcw0KPiBsb25nIGFzIGl0IGlzIGFscmVhZHkgZ3JvdXBp
bmcgZmlsZXMgYnkgbWFpbnRhaW5lcj8NCg0KDQpIbW0sIGFjdHVhbGx5LCBpdCB3YXMgaW4gYSBm
aXJzdCB2ZXJzaW9uLiBCdXQgdGhlbiBJIGRlY2lkZWQgdGhhdDoNCjEuIEkgaGF2ZSB0byB1c2Ug
LS1jYy1jbWQgdG8gaGFuZGxlIGZpcnN0IHRocmVlIHBhdGNoZXMgYW55d2F5DQoyLiBJIGRvbid0
IGxpa2UgY29tbWl0IG1lc3NhZ2VzIHdpdGggIkNDOiIgaW5zaWRlIChhbnkgcmVhc29uIHRvIGtl
ZXAgdGhpcw0KICAgIGluZm9ybWF0aW9uIGluIGhpc3RvcnkgZm9yZXZlciwgaW5jcmVhc2luZyBm
YWxzZS1yZWNpcGllbnRzIGZvciB0aG9zZQ0KICAgIHdobyBmb3JnZXQgdG8gYWRkIC0tc3VwcHJl
c3MtY2M9YWxsID8pDQoNClNvLCBJIGRlY2lkZWQgdG8gdXNlIC0tY2MtY21kIGluc3RlYWQuDQoN
Cg0KPiANCj4+ICAgbmJkL2NsaWVudC5jIHwgMSArDQo+PiAgIG5iZC9zZXJ2ZXIuYyB8IDEgKw0K
Pj4gICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gUmV2aWV3ZWQtYnk6
IEVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPg0KPiANCj4gSXQncyBwcm9iYWJseSBlYXNp
ZXIgdG8gdGFrZSB0aGlzIGVudGlyZSBzZXJpZXMgdGhyb3VnaCBvbmUgbWFpbnRhaW5lcg0KPiAo
TWFya3VzLCBzaW5jZSBpdCBpcyBlcnJvci1yZWxhdGVkKSwgdGhhbiB0byBoYXZlIG1lIHBpY2sg
dXAgdGhpcyBwYXRjaA0KPiBieSBpdHNlbGYgdGhyb3VnaCB0aGUgTkJEIHRyZWUuDQoNClllcywg
aXQgc2ltcGxpZmllcyBiYWNrcG9ydGluZyAoZXZlbiBiYWNrcG9ydGluZyBzb21ldGhpbmcgb3Ro
ZXIpDQoNCj4gDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL25iZC9jbGllbnQuYyBiL25iZC9jbGllbnQu
Yw0KPj4gaW5kZXggYjlkYzgyOTE3NS4uNGQ5MGEyNmMwMCAxMDA2NDQNCj4+IC0tLSBhL25iZC9j
bGllbnQuYw0KPj4gKysrIGIvbmJkL2NsaWVudC5jDQo+PiBAQCAtMTUzLDYgKzE1Myw3IEBAIHN0
YXRpYyBpbnQgbmJkX3JlY2VpdmVfb3B0aW9uX3JlcGx5KFFJT0NoYW5uZWwgKmlvYywgdWludDMy
X3Qgb3B0LA0KPj4gICBzdGF0aWMgaW50IG5iZF9oYW5kbGVfcmVwbHlfZXJyKFFJT0NoYW5uZWwg
KmlvYywgTkJET3B0aW9uUmVwbHkgKnJlcGx5LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGJvb2wgc3RyaWN0LCBFcnJvciAqKmVycnApDQo+PiAgIHsNCj4+ICsgICAgRVJS
UF9GVU5DVElPTl9CRUdJTigpOw0KPj4gICAgICAgZ19hdXRvZnJlZSBjaGFyICptc2cgPSBOVUxM
Ow0KPj4gICANCj4+ICAgICAgIGlmICghKHJlcGx5LT50eXBlICYgKDEgPDwgMzEpKSkgew0KPj4g
ZGlmZiAtLWdpdCBhL25iZC9zZXJ2ZXIuYyBiL25iZC9zZXJ2ZXIuYw0KPj4gaW5kZXggMjhjM2M4
YmU4NS4uMDk1NjVhZDhkYyAxMDA2NDQNCj4+IC0tLSBhL25iZC9zZXJ2ZXIuYw0KPj4gKysrIGIv
bmJkL3NlcnZlci5jDQo+PiBAQCAtMTYxNiw2ICsxNjE2LDcgQEAgdm9pZCBuYmRfZXhwb3J0X2Ns
b3NlKE5CREV4cG9ydCAqZXhwKQ0KPj4gICANCj4+ICAgdm9pZCBuYmRfZXhwb3J0X3JlbW92ZShO
QkRFeHBvcnQgKmV4cCwgTmJkU2VydmVyUmVtb3ZlTW9kZSBtb2RlLCBFcnJvciAqKmVycnApDQo+
PiAgIHsNCj4+ICsgICAgRVJSUF9GVU5DVElPTl9CRUdJTigpOw0KPj4gICAgICAgaWYgKG1vZGUg
PT0gTkJEX1NFUlZFUl9SRU1PVkVfTU9ERV9IQVJEIHx8IFFUQUlMUV9FTVBUWSgmZXhwLT5jbGll
bnRzKSkgew0KPj4gICAgICAgICAgIG5iZF9leHBvcnRfY2xvc2UoZXhwKTsNCj4+ICAgICAgICAg
ICByZXR1cm47DQo+Pg0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

