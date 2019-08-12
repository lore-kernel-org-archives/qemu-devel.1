Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6648C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 18:00:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E2BA206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 18:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uzP4Qv3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2BA206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxEcG-0005pe-Po
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 14:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38862)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxEbh-0005G7-Ui
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 13:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxEbg-0000P5-LG
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 13:59:45 -0400
Received: from mail-eopbgr10125.outbound.protection.outlook.com
 ([40.107.1.125]:55118 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxEbg-0000Kb-1y; Mon, 12 Aug 2019 13:59:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKff76YokaIz5NHisPDIGNxp6v4HkzDfvrxcP/Eas5H65SKzeVvw4JeRymxha4ehmbU0ev0N7Shq5oG2niwxegTZ4X65sBoOEEzjY4lvZW95ypkYaOktmudwNgUsFm1QT50X65Iz7We/QrJ9lbztaMWmcbM0N/yYWet9sVzCxL9bCmc7DI0iUmRxC+i9i8aYb06rZJXeYPQciSDGg5UfMYl5lylc6l+JWDGYGLMhYiCtB5vpZC+fGQLQGu8HQUP97+ooJureuTXC1MdaBG3CphGPorK9lU/mF/smcAoiMUzz/QUUy3zu1hlH3U7fqY7rrclqMhdmoKKWIPJsn3AstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1z7586SbCCP2QxTKvr85/XSsGPebaayuPmu6xyhKZk=;
 b=SDVJeNuWyCy+0sWxdsjpAGXBtbwlUOryXpa+loCWx86co4hY+VAjFqKG5nq8rmsgRu4HfXdDPjcXwsjUOkQMGuHH5BuE5JwVw1Irzn0EWAcHLpKIl7c0HsOVFN8Zn5joFvA6wLXDzrHfPS+XA6AO625FlxGfYWnm6vYpuuk5XeGAR8b500n1wp6quRaVcX09+DtrvIybsN/tKCQCItyAH8eaQ5c0+2YrKLSkrh4bwIy5pKDFiuoViwobw9lNnXZ7NoEfHZglFZBonej+O4orPFDRVhosdz60NyrV5n31OZaZNWd30aqhmziIQxPxPksxiwvB26MYPTQYb/dwdG28Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1z7586SbCCP2QxTKvr85/XSsGPebaayuPmu6xyhKZk=;
 b=uzP4Qv3wIzHaU3wfhHt59Hbib/aa+UxyVMQvMFyIfN/MJeHda0y25uvHSW1RJeGj40bZPHRp/VMC782HaOvR9Hhs9SiYIYZBjgFebmmIIJUX+OhOXoEDBTxSxo81GxmfC5Z0DF5rZi9007QfnH4p8CHKOOaxFPqLTiySZhkhNjA=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5385.eurprd08.prod.outlook.com (52.133.241.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Mon, 12 Aug 2019 17:59:40 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 17:59:40 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, qemu block <qemu-block@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz
 <mreitz@redhat.com>
Thread-Topic: [Qemu-devel] backup bug or question
Thread-Index: AQHVTrTrc8JESPxQGUmDMebwH05otKbzQFKAgAEvCQCAA17+AIAAA6cA
Date: Mon, 12 Aug 2019 17:59:40 +0000
Message-ID: <0238cf40-2fcd-62c7-42bc-392525e52e47@virtuozzo.com>
References: <6826e3c2-bc6e-b2a2-1bf1-3ed31079f0ee@virtuozzo.com>
 <b032aeef-07f4-2922-6ee8-3047a8c622b8@redhat.com>
 <0c95727d-6572-710f-6a78-e54c4f655de3@virtuozzo.com>
 <d52ae020-0b35-936a-b321-02593739be85@redhat.com>
In-Reply-To: <d52ae020-0b35-936a-b321-02593739be85@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P191CA0003.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::13)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190812205938266
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 416e571c-f9ea-4081-2e2a-08d71f4ed8d6
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5385; 
x-ms-traffictypediagnostic: DB8PR08MB5385:
x-microsoft-antispam-prvs: <DB8PR08MB5385D503080AB8C3EF1DCDF4C1D30@DB8PR08MB5385.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(136003)(366004)(346002)(376002)(396003)(55674003)(189003)(199004)(316002)(110136005)(25786009)(102836004)(66066001)(6506007)(52116002)(386003)(26005)(305945005)(99286004)(76176011)(53546011)(486006)(31686004)(186003)(476003)(11346002)(2616005)(446003)(86362001)(6436002)(64756008)(6486002)(66446008)(6246003)(5660300002)(7736002)(6512007)(53936002)(66556008)(66946007)(3846002)(6116002)(66476007)(71190400001)(71200400001)(2906002)(478600001)(256004)(36756003)(31696002)(14444005)(229853002)(81166006)(14454004)(81156014)(8936002)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5385;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LiTGd8g37tcSqj+ia0KoVM8ytVVnss6Bs6F35rwzCqWEF1d8OkHAzlxfQO9O9w4a2sVLdFq+3uv+ZVy41bxXwYZuO4AoNheWMmcPBZKJecuAV6D5HU13GpvXSSy2XYwlMEq/qHlZHfOi01j97zwgw0a+cuCwLbp64tPHI27xq26ylJu/qt/zOSHqwnx82I8npr6svTf+WfY1vfdSuzdyo7/FxexZ/v4wmz0dXKrEnBsdN18XNgqSHEI9nTjst9SOeHFGBMwndCEU0tEE+HnELq0Qp+/yoXIcm0WwX+YoiGsxEPFVIGo23pn4J5uXC9fi0X5PGlFnzHR5W0HDtwbWIWWUstkdSSPGtto5UjG/G3VWAyMKtPm7CDgjmq851hitoKcXV0dbYNdMJoHrPQlZ4jOAvF1TlZUiD9oRZeZkFEI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <274297604614E44A9C29D3B9F7A9C0D5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416e571c-f9ea-4081-2e2a-08d71f4ed8d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 17:59:40.3741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3KHqOupsP7FVaC5uWQZgxTkCeBoyetG2/FP69ot4MjRBnAeDBQC7YbQa1btv9wbW1QmcLEfqzfVHUIET04hn/C8INI6675kD7JDNr/IQb8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5385
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.125
Subject: Re: [Qemu-devel] backup bug or question
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTIuMDguMjAxOSAyMDo0NiwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDgvMTAvMTkg
NzoxNyBBTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDA5LjA4LjIw
MTkgMjM6MTMsIEpvaG4gU25vdyB3cm90ZToNCj4+Pg0KPj4+DQo+Pj4gT24gOC85LzE5IDk6MTgg
QU0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4+IEhpIQ0KPj4+Pg0K
Pj4+PiBIbW0sIGhhY2tpbmcgYXJvdW5kIGJhY2t1cCBJIGhhdmUgYSBxdWVzdGlvbjoNCj4+Pj4N
Cj4+Pj4gV2hhdCBwcmV2ZW50cyBndWVzdCB3cml0ZSByZXF1ZXN0IGFmdGVyIGpvYl9zdGFydCBi
dXQgYmVmb3JlIHNldHRpbmcNCj4+Pj4gd3JpdGUgbm90aWZpZXI/DQo+Pj4+DQo+Pj4+IGNvZGUg
cGF0aDoNCj4+Pj4NCj4+Pj4gcW1wX2RyaXZlX2JhY2t1cCBvciB0cmFuc2FjdGlvbiB3aXRoIGJh
Y2t1cA0KPj4+Pg0KPj4+PiAgICAgICBqb2Jfc3RhcnQNCj4+Pj4gICAgICAgICAgYWlvX2NvX2Vu
dGVyKGpvYl9jb19lbnRyeSkgLyogbWF5IG9ubHkgc2NoZWR1bGUgZXhlY3V0aW9uLCBpc24ndCBp
dCA/ICovDQo+Pj4+DQo+Pj4+IC4uLi4NCj4+Pj4NCj4+Pj4gam9iX2NvX2VudHJ5DQo+Pj4+ICAg
ICAgIGpvYl9wYXVzZV9wb2ludCgpIC8qIGl0IGRlZmluaXRlbHkgeWllbGRzLCBpc24ndCBpdCBi
YWQ/ICovDQo+Pj4+ICAgICAgIGpvYi0+ZHJpdmVyLT5ydW4oKSAvKiBiYWNrdXBfcnVuICovDQo+
Pj4+DQo+Pj4+IC0tLS0NCj4+Pj4NCj4+Pj4gYmFja3VwX3J1bigpDQo+Pj4+ICAgICAgIGJkcnZf
YWRkX2JlZm9yZV93cml0ZV9ub3RpZmllcigpDQo+Pj4+DQo+Pj4+IC4uLg0KPj4+Pg0KPj4+DQo+
Pj4gSSB0aGluayB5b3UncmUgcmlnaHQuLi4gOigNCj4+Pg0KPj4+DQo+Pj4gV2UgY3JlYXRlIGpv
YnMgbGlrZSB0aGlzOg0KPj4+DQo+Pj4gam9iLT5wYXVzZWQgICAgICAgID0gdHJ1ZTsNCj4+PiBq
b2ItPnBhdXNlX2NvdW50ICAgPSAxOw0KPj4+DQo+Pj4NCj4+PiBBbmQgdGhlbiBqb2Jfc3RhcnQg
ZG9lcyB0aGlzOg0KPj4+DQo+Pj4gam9iLT5jbyA9IHFlbXVfY29yb3V0aW5lX2NyZWF0ZShqb2Jf
Y29fZW50cnksIGpvYik7DQo+Pj4gam9iLT5wYXVzZV9jb3VudC0tOw0KPj4+IGpvYi0+YnVzeSA9
IHRydWU7DQo+Pj4gam9iLT5wYXVzZWQgPSBmYWxzZTsNCj4+Pg0KPj4+DQo+Pj4gV2hpY2ggbWVh
bnMgdGhhdCBqb2JfY29fZW50cnkgaXMgYmVpbmcgY2FsbGVkIGJlZm9yZSB3ZSBsaWZ0IHRoZSBw
YXVzZToNCj4+Pg0KPj4+IGFzc2VydChqb2IgJiYgam9iLT5kcml2ZXIgJiYgam9iLT5kcml2ZXIt
PnJ1bik7DQo+Pj4gam9iX3BhdXNlX3BvaW50KGpvYik7DQo+Pj4gam9iLT5yZXQgPSBqb2ItPmRy
aXZlci0+cnVuKGpvYiwgJmpvYi0+ZXJyKTsNCj4+Pg0KPj4+IC4uLldoaWNoIG1lYW5zIHRoYXQg
d2UgYXJlIGRlZmluaXRlbHkgeWllbGRpbmcgaW4gam9iX3BhdXNlX3BvaW50Lg0KPj4+DQo+Pj4g
WWVhaCwgdGhhdCdzIGEgcmFjZSBjb25kaXRpb24gd2FpdGluZyB0byBoYXBwZW4uDQo+Pj4NCj4+
Pj4gQW5kIHdoYXQgZ3VhcmFudGVlcyB3ZSBnaXZlIHRvIHRoZSB1c2VyPyBJcyBpdCBndWFyYW50
ZWVkIHRoYXQgd3JpdGUgbm90aWZpZXIgaXMNCj4+Pj4gc2V0IHdoZW4gcW1wIGNvbW1hbmQgcmV0
dXJucz8NCj4+Pj4NCj4+Pj4gQW5kIEkgZ3Vlc3MsIGlmIHdlIHN0YXJ0IHNldmVyYWwgYmFja3Vw
cyBpbiBhIHRyYW5zYWN0aW9uIGl0IHNob3VsZCBiZSBndWFyYW50ZWVkDQo+Pj4+IHRoYXQgdGhl
IHNldCBvZiBiYWNrdXBzIGlzIGNvbnNpc3RlbnQgYW5kIGNvcnJlc3BvbmQgdG8gb25lIHBvaW50
IGluIHRpbWUuLi4NCj4+Pj4NCj4+Pg0KPj4+IEkgd291bGQgaGF2ZSBob3BlZCB0aGF0IG1heWJl
IHRoZSBkcmFpbl9hbGwgY291cGxlZCB3aXRoIHRoZSBpbmRpdmlkdWFsDQo+Pj4gam9icyB0YWtp
bmcgZHJhaW5fc3RhcnQgYW5kIGRyYWluX2VuZCB3b3VsZCBzYXZlIHVzLCBidXQgSSBndWVzcyB3
ZQ0KPj4+IHNpbXBseSBkb24ndCBoYXZlIGEgZ3VhcmFudGVlIHRoYXQgYWxsIGJhY2t1cCBqb2Jz
IFdJTEwgaGF2ZSBpbnN0YWxsZWQNCj4+PiB0aGVpciBoYW5kbGVyIGJ5IHRoZSB0aW1lIHRoZSB0
cmFuc2FjdGlvbiBlbmRzLg0KPj4+DQo+Pj4gT3IsIGlmIHRoZXJlIGlzIHRoYXQgZ3VhcmFudGVl
LCBJIGRvbid0IGtub3cgd2hhdCBwcm92aWRlcyBpdCwgc28gSQ0KPj4+IHRoaW5rIHdlIHNob3Vs
ZG4ndCBjb3VudCBvbiBpdCBhY2NpZGVudGFsbHkgd29ya2luZyBhbnltb3JlLg0KPj4+DQo+Pj4N
Cj4+Pg0KPj4+IEkgdGhpbmsgd2Ugc2hvdWxkIGRvIHR3byB0aGluZ3M6DQo+Pj4NCj4+PiAxLiBN
b3ZlIHRoZSBoYW5kbGVyIGluc3RhbGxhdGlvbiB0byBjcmVhdGlvbiB0aW1lLg0KPj4+IDIuIE1v
ZGlmeSBiYWNrdXBfYmVmb3JlX3dyaXRlX25vdGlmeSB0byByZXR1cm4gd2l0aG91dCBpbnZva2lu
Zw0KPj4+IGJhY2t1cF9kb19jb3cgaWYgdGhlIGpvYiBpc24ndCBzdGFydGVkIHlldC4NCj4+Pg0K
Pj4NCj4+IEhtbSwgSSBkb24ndCBzZWUsIGhvdyBpdCBoZWxwcy4uIE5vLW9wIHdyaXRlLW5vdGlm
aWVyIHdpbGwgbm90IHNhdmUgYXMgZnJvbQ0KPj4gZ3Vlc3Qgd3JpdGUsIGlzIGl0Pw0KPj4NCj4+
DQo+IA0KPiBUaGUgaWRlYSBpcyB0aGF0IGJ5IGluc3RhbGxpbmcgdGhlIHdyaXRlIG5vdGlmaWVy
IGR1cmluZyBjcmVhdGlvbiwgdGhlDQo+IHdyaXRlIG5vdGlmaWVyIGNhbiBiZSBzd2l0Y2hlZCBv
biB0aGUgaW5zdGFudCBqb2Jfc3RhcnQgaXMgY3JlYXRlZCwNCj4gcmVnYXJkbGVzcyBvZiBpZiB3
ZSB5aWVsZCBpbiB0aGUgY29fZW50cnkgc2hpbSBvciBub3QuDQo+IA0KPiBUaGF0IHdheSwgbm8g
bWF0dGVyIHdoZW4gd2UgeWllbGQgb3Igd2hlbiB0aGUgYmFja3VwX3J1biBjb3JvdXRpbmUNCj4g
YWN0dWFsbHkgZ2V0cyBzY2hlZHVsZWQgYW5kIGV4ZWN1dGVkLCB0aGUgd3JpdGUgbm90aWZpZXIg
aXMgYWN0aXZlIGFscmVhZHkuDQo+IA0KPiBPciBwdXQgYW5vdGhlciB3YXk6IGNhbGxpbmcgam9i
X3N0YXJ0KCkgZ3VhcmFudGVlcyB0aGF0IHRoZSB3cml0ZQ0KPiBub3RpZmllciBpcyBhY3RpdmUu
DQoNCg0KT2gsIGdvdCBpdCwgZmVlbCBzdHVwaWQpDQoNCj4gDQo+IEkgdGhpbmsgdXNpbmcgZmls
dGVycyB3aWxsIHNhdmUgdXMgdG9vLCBidXQgSSBkb24ndCBrbm93IGhvdyByZWFkeSB0aG9zZQ0K
PiBhcmUuIERvIHdlIHN0aWxsIHdhbnQgYSBwYXRjaCB0aGF0IGd1YXJhbnRlZXMgdGhpcyBiZWhh
dmlvciBpbiB0aGUgbWVhbnRpbWU/DQo+IA0KDQpJIHRoaW5rIHdlIHdhbnQgb2YgY291cnNlLCB3
aWxsIGxvb2sgYXQgaXQgdG9tb3Jyb3cuDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1p
cg0K

