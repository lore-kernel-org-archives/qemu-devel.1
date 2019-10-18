Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE87CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46FBD222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HSoDk9Q1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FBD222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLTOK-0006pZ-DD
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iLTNU-0005xe-QG
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:37:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iLTNT-0004Y0-Lk
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:37:16 -0400
Received: from mail-eopbgr140093.outbound.protection.outlook.com
 ([40.107.14.93]:45542 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iLTNT-0004XO-EI; Fri, 18 Oct 2019 10:37:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2GQi631jLKBBYo/6tVv1mmX1Wl+aNPIux54s3HAZ/pdFjjU/+0Nk/GB/1z6Jz/PudVmlNgg36coL42mRuVsy3rHRCiWrYdO5Mo1fVB+vwvIVZwZqUErn8yIme1YPeaXXV2K8ZpZXYimtRhVuJ71u/NPVjiRWpIsiysuwsSBNV5YTAsLNj7Faz1+JYXCij9w5zjOU2OSVCgFYKMea3BnokjVIDoPm/m1DIWrw3wPnmgccW+3hwz919DbaA/wPFCwmpE/bMRUvLO6HfqDaQZJVrviF+R5KSe0RUhHt6rCtLhewQVg+7gnnu7wLaSZo2J/dBM00Lhn/j48Ol35Go7bwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfLDyA1zh15EFFzAVfxl9Jfu9Wm7tWxiKCBmuZ03k3A=;
 b=bZeqWWGj2EXmj4djwbMRTol1weNnNLzxcbFlHQPvcmSukq+d/wrSc0jVPM6x6h4kMe84ezFSoLEoRmabm38yWI4RQZY68NPF8TccCWs/+RkJ5fM/GB/FlgQ8gu0dtSP+virPqTPiM+4xCINxTTBfBBKBzdDHm9n2Dv7DPNrpDZ15amJZaP+9r4wEZ3RhlMoqIuK1/02XA2QwlwuT2+FcqRIN4UOv1/fA7K6+Nz5OsKdMt+rkKj/HR3Yj6uDuG+nqNOX5Y5ZeuT3iNf2OAYTIU3Tg+Ro2d1kugASr2QYWg+xMp+mFClrqW3hG21LsE3fO2IjPUkcwbvF7sgxAExjabg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfLDyA1zh15EFFzAVfxl9Jfu9Wm7tWxiKCBmuZ03k3A=;
 b=HSoDk9Q1qafZNxstgnynftndbrjcJjYLdjHpPt88TBiGL01/iNcQMazS1GONcTTfjufOs79VZrzHuhzhFtzFNjXafGe0hBwS1IBvXhteU4VthKoHoFEcvaRVPo9J6eqDjFu8B9FLa0SrhldtpcJFws5LeR1tDgDanyhDBnikWYU=
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com (20.179.35.83) by
 AM0PR08MB4993.eurprd08.prod.outlook.com (10.255.31.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Fri, 18 Oct 2019 14:37:13 +0000
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c]) by AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c%7]) with mapi id 15.20.2347.026; Fri, 18 Oct 2019
 14:37:13 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v8 2/3] docs: define padding for qcow2 header
Thread-Topic: [PATCH v8 2/3] docs: define padding for qcow2 header
Thread-Index: AQHVhZkj63IgKjNDbk6DQ+s8ysNEVadgbg0AgAAJzYA=
Date: Fri, 18 Oct 2019 14:37:13 +0000
Message-ID: <75b4bb38-7097-8449-7d90-720245c67a6f@virtuozzo.com>
References: <20191018094758.7124-1-vsementsov@virtuozzo.com>
 <20191018094758.7124-3-vsementsov@virtuozzo.com>
 <019c2493-25c1-9e54-1f5d-84bb003e98b1@redhat.com>
In-Reply-To: <019c2493-25c1-9e54-1f5d-84bb003e98b1@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0037.eurprd07.prod.outlook.com
 (2603:10a6:7:66::23) To AM0PR08MB4435.eurprd08.prod.outlook.com
 (2603:10a6:208:144::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191018173711198
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74e7ac0b-3728-4dbb-280d-08d753d8aa3e
x-ms-traffictypediagnostic: AM0PR08MB4993:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB49935F22D3BB47D5657221C7C16C0@AM0PR08MB4993.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(39840400004)(376002)(396003)(346002)(189003)(199004)(66446008)(71200400001)(66476007)(66946007)(66556008)(64756008)(8676002)(71190400001)(8936002)(26005)(110136005)(81166006)(81156014)(31696002)(86362001)(2616005)(54906003)(5660300002)(25786009)(6436002)(6486002)(2906002)(476003)(486006)(478600001)(229853002)(4326008)(53546011)(6246003)(107886003)(186003)(36756003)(386003)(6506007)(446003)(6512007)(11346002)(31686004)(66066001)(2501003)(76176011)(102836004)(14454004)(3846002)(6116002)(256004)(99286004)(7736002)(305945005)(52116002)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4993;
 H:AM0PR08MB4435.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uwLUOj2qx8FPRxrQ72ekdhrREbQ93RgzfjvcnLuM3R3Z1J1/6JAr8VYAwOGJE6GqZaDX/DkmSfzu20wNAuf9IewhpBPRofOeaS3m/tGaQmMxCLO9GtdL8DkmkOHdVpQdOBoP6TYO5WHs7GQINPgKJlP9gGcy7ZXs/HymACMdpoa15+w5vts6tlAc1nVIKJ8eOUxI01WKqhu1BBtitMiaHNpEy9OXU18Hn5pGdg+OQ8fVVwlWmczUeSqqI55fVTZwQEhiaSzFtCzYqoTP124eDmbberBmXWLOfTmkr07Wnxwlz1pKRC8fc2chJ0nYiNdpiGudjtx/cPE2k9ux565D3b0h+Y9KCZDHvMKHyFH+MSPcm2W8X94DfifUwElLkSuz0N0jkWrMF3ne3HZzEUMQXsJiBbrMa5Xn2e0Q9jD0SZ4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72530CFC7026EF4885C8359D6A76A6CA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e7ac0b-3728-4dbb-280d-08d753d8aa3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 14:37:13.1585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nL2PxIoRO3HiC1Q9NynaYwahVbef5zBbgcSjNJ2lTVVH4EhVJ4+ZQy91tQWuiuR5BF4+BN2rbp/S0ObOW6Bv6tfudkDkG4H3fXB91QzpLxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4993
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.93
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTguMTAuMjAxOSAxNzowMiwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMTAvMTgvMTkgNDo0NyBB
TSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEhlYWRlciBleHRlbnNp
b25zIGVuZHMgYXJlIGFscmVhZHkgZGVmaW5lZCB0byBiZSBtdWx0aXBseSBvZiA4LiBMZXQncw0K
Pj4gZ2VudGx5IGFzayBmb3IgaGVhZGVyIGxlbmd0aCB0byBiZSBhIG11bHRpcGx5IG9mIDggdG9v
LCB3aGVuIHdlIGhhdmUNCj4+IHNvbWUgYWRkaXRpb25hbCBmaWVsZHMuIFJlcXVpcmluZyB0aGlz
IG1heSBiZSBjb25zaWRlcmVkIGFzIGFuDQo+PiBpbmNvbXBhdGlibGUgY2hhbmdlLCBzbyB0aGUg
cGFkZGluZyBpcyBvcHRpb25hbC4gQWN0dWFsbHksIHBhZGRpbmcgaXMNCj4+IGFsbG93ZWQgYmVm
b3JlIHRoaXMgcGF0Y2ggKGR1ZSB0byBkZWZpbml0aW9uIG9mIGFkZGl0aW9uYWwgZmllbGRzKSwN
Cj4+IHRoZSBvbmx5IGFjdHVhbCBjaGFuZ2UgaXMgIlNIT1VMRCIgd29yZC4NCj4gDQo+IFRvbyB3
ZWFrLiBJJ3ZlIGFscmVhZHkgYXJndWVkIHRoYXQgdGhpcyBzaG91bGQgYmUgbWFuZGF0b3J5LCBh
bmQgdGhhdCB3ZSBhcmUgbm90IGJyZWFraW5nIGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5LCBidXQg
bWVyZWx5IGNsYXJpZnlpbmcgd2hhdCBoYXMgYWxyZWFkeSBiZWVuIGltcGxpY2l0IGJ5IHRoZSBm
YWN0IHRoYXQgaGVhZGVyIGV4dGVuc2lvbnMgYXJlIHJlcXVpcmVkIHRvIGJlIDgtYnl0ZSBzaXpl
IG11bHRpcGxlICh3aGljaCBtYWtlcyBubyBzZW5zZSB1bmxlc3MgdGhleSBhcmUgYWxzbyA4LWJ5
dGUgYWxpZ25lZCkuDQoNCk9LDQoNCj4gDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIg
U2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4gLS0tDQo+
PiDCoCBkb2NzL2ludGVyb3AvcWNvdzIudHh0IHwgNSArKysrKw0KPj4gwqAgMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kb2NzL2ludGVyb3AvcWNv
dzIudHh0IGIvZG9jcy9pbnRlcm9wL3Fjb3cyLnR4dA0KPj4gaW5kZXggNDcwOWYzYmIzMC4uYjk3
MWU1OWIxYSAxMDA2NDQNCj4+IC0tLSBhL2RvY3MvaW50ZXJvcC9xY293Mi50eHQNCj4+ICsrKyBi
L2RvY3MvaW50ZXJvcC9xY293Mi50eHQNCj4+IEBAIC0xODUsNiArMTg1LDExIEBAIHdoaWNoIGlz
IGNvdmVyZWQgYnkgQGhlYWRlcl9sZW5ndGggbXVzdCBiZSB6ZXJvZWQuDQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgPCAuLi4gTm8gYWRkaXRpb25hbCBmaWVsZHMgaW4gdGhlIGhlYWRlciBjdXJyZW50
bHkgLi4uID4NCj4+ICtIZWFkZXIgcGFkZGluZw0KPj4gK8KgwqDCoMKgwqDCoMKgIElmIEBoZWFk
ZXJfbGVuZ3RoIGlzIGxhcmdlciB0aGFuIDEwNCwgc29mdHdhcmUgU0hPVUxEIG1ha2UgaXQgYQ0K
Pj4gK8KgwqDCoMKgwqDCoMKgIG11bHRpcGx5IG9mIDgsIGFkZGluZyB6ZXJvLXBhZGRpbmcgYWZ0
ZXIgYWRkaXRpb25hbCBmaWVsZHMuIFN0aWxsIHRoZQ0KPj4gK8KgwqDCoMKgwqDCoMKgIHBhZGRp
bmcgaXMgb3B0aW9uYWwgYW5kIG1heSBiZSBhYnNlbnQgaW4gdGhlIGltYWdlLg0KPj4gKw0KPj4g
wqAgRGlyZWN0bHkgYWZ0ZXIgdGhlIGltYWdlIGhlYWRlciwgb3B0aW9uYWwgc2VjdGlvbnMgY2Fs
bGVkIGhlYWRlciBleHRlbnNpb25zIGNhbg0KPj4gwqAgYmUgc3RvcmVkLiBFYWNoIGV4dGVuc2lv
biBoYXMgYSBzdHJ1Y3R1cmUgbGlrZSB0aGUgZm9sbG93aW5nOg0KPj4NCj4gDQoNCg0KLS0gDQpC
ZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

