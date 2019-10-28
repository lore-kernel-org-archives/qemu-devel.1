Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1CDCA9EBC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 10:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9124620873
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 10:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="to608CsP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9124620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP1xZ-0007SM-OQ
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 06:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iP1vk-0005Xz-52
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 06:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iP1vi-0004HK-5W
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 06:07:19 -0400
Received: from mail-eopbgr130113.outbound.protection.outlook.com
 ([40.107.13.113]:64902 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iP1vh-0004Gi-Ae; Mon, 28 Oct 2019 06:07:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1xICyFQ+V5pY+v+KSiKJ3iPS2T5H1/mbA5ufLwjhzMIo3JzA7JzCn1AIp6YAIsIb362NYBESAf6f3x1LE8a4/5qp648o9VJvUlu+nIpUyU2zsOuSlUUA9iouO3/23+zQlWRDHmbJ4NRKNbE0Y1KkfVR1TdvnjP4J5poizhMNm80Y2PTNWmFIftM5f7UMHqRRxfPZLYpViUemJYMF0qyLveMVQjhRcAdXeYG2ZPnVnS9qXhIb8GsttH9H5ERSQz8wwgGWjgp0X7fOrIaSaaffJqiVIUm7csaHd6mFCqjJ1wIYQqPuF/M+KLMdlVoSFlH7mVP+n3eWn8X6qTszlNFuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er+PCNLOOLmHTM2EJNgrjTtkHgI8jI0vDZReSt0QtlE=;
 b=GdbU70kXL+HpkRQeeHtDGQmseOKArTaAn5UxByhzcMjAHCSa/N9tZt7bVrrl6kAbUCABAyM7Q+CNHRg7TaCgPSUe+NcwwAT6RPsRFheOuQ2rkYfyRoiS6kyn9eg6kYY3vGlO6q1wrmVeJAwS/Iozawg4w9hKTc+yU8wgJplq7m0QRKmDXfNRDdvVrJmA0d2HhI/9SdteFxUQMKsH8Feos1LOwBaInQiXoFnHp3qx5fbisL7ZMi5/kqGYhsJvXtO0EbTiO1dLs/TZdBrjqZrqwiEKxKhHmVXppEhwGSZMwCti449YkV/0di6xA2J+JtHlESV/M8zvJFzz74R8Q4eiMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er+PCNLOOLmHTM2EJNgrjTtkHgI8jI0vDZReSt0QtlE=;
 b=to608CsPf0L/2Wv1tsw2KiJWdVZ2mButUOxSyehQNQ+wvFSxm+7NQxpOwMT2Bb/GeOk22Kg++tC9Xl+kRq5iKbl/qdqdXouJS5PcXHCrQe/KYmdWXaxHVU4pml3lDlraxnZA0v8EsXFBKPfkD3T6wGEFoFnDOQGHqQyuKbj5bG8=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB2945.eurprd08.prod.outlook.com (52.134.124.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Mon, 28 Oct 2019 10:07:14 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119%6]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 10:07:13 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC 0/3] block/file-posix: Work around XFS bug
Thread-Topic: [RFC 0/3] block/file-posix: Work around XFS bug
Thread-Index: AQHVixrVzIJNY5LqnE6V3J8eZcL1nqdub/GAgAFcuACAAAHogIAAB0wAgAAC2oA=
Date: Mon, 28 Oct 2019 10:07:13 +0000
Message-ID: <f89d91d0-c835-d09a-6fcb-d1b030a05ef5@virtuozzo.com>
References: <20191025095849.25283-1-mreitz@redhat.com>
 <20191027123555.GN4472@stefanha-x1.localdomain>
 <81bb0f91-2671-c9e5-f791-c7470dfd75ce@redhat.com>
 <c38e000b-a120-2726-65a2-61c63fcc101f@redhat.com>
 <0f81f678-7d0d-56d3-d236-c077e4251f1a@redhat.com>
In-Reply-To: <0f81f678-7d0d-56d3-d236-c077e4251f1a@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0026.eurprd07.prod.outlook.com
 (2603:10a6:7:66::12) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191028130711439
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b9c6bed-638a-4599-c7ef-08d75b8e9aa1
x-ms-traffictypediagnostic: AM0PR08MB2945:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB2945814CB097335EB1DE36EBC1660@AM0PR08MB2945.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(396003)(346002)(136003)(39840400004)(189003)(199004)(14444005)(256004)(186003)(36756003)(31686004)(86362001)(52116002)(4326008)(31696002)(6116002)(476003)(446003)(6512007)(76176011)(2616005)(8676002)(6486002)(11346002)(3846002)(14454004)(6436002)(229853002)(7736002)(66066001)(305945005)(6246003)(81166006)(8936002)(102836004)(81156014)(486006)(54906003)(110136005)(316002)(25786009)(26005)(64756008)(66556008)(66476007)(66446008)(66946007)(5660300002)(6506007)(53546011)(71190400001)(71200400001)(478600001)(386003)(2906002)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB2945;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1b1bIUU9M0kMiTdYFvErpDYGwBj5Gtz3QHc/tPtSh5yVArBr7kE5qNDtYTc4J6vlMpbqzEkNqyjoZFlyuLO3TKifhxMW4fqDYUv2h2LeFGIx5cutYyR2TVaryJyh2JyhGHPPBgOleKmYLUItsKnVyj6a4zkKkS8+jmztgGp51XzMkZNPKwC+jW4YdHU2dKPatmywC4vZCXIZeWsC0llLM/pOA4/f58RAbRcMkXqCXcmDKbe5ULv46rHFKOG1dDAEHPolBYfFg7xPUH8PPqsJmuAWZVxlwTCBvyLqxFrURE5zUbkGM+vJOdfo0XC7VM7OHVM9A24DphNcku7OXDcMkQy4wtvsCROPHahXUszAZvtAczoLqC6d08QQSKLx/Tl82PUvmGhiF/tmT5K+BFiTXaydkkoHdG99pO0SNjWSGb+E8xGeICuPtDG+5bwEiEGI
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDC77E1188AA4548849736C297FC53A4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9c6bed-638a-4599-c7ef-08d75b8e9aa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 10:07:13.5700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LZHYTtW4JHtxyHWnv+k/XTvEZBVAOSNhAG92TMDicjDMUZIwsHhRSuLDi7/Xc8NXI56Ba7NGFTYCgUqVOH2fFcTsnzSUfbH0Pr8acBxgSbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB2945
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.113
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjguMTAuMjAxOSAxMjo1NiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyOC4xMC4xOSAxMDozMCwg
TWF4IFJlaXR6IHdyb3RlOg0KPj4gT24gMjguMTAuMTkgMTA6MjQsIE1heCBSZWl0eiB3cm90ZToN
Cj4+PiBPbiAyNy4xMC4xOSAxMzozNSwgU3RlZmFuIEhham5vY3ppIHdyb3RlOg0KPj4+PiBPbiBG
cmksIE9jdCAyNSwgMjAxOSBhdCAxMTo1ODo0NkFNICswMjAwLCBNYXggUmVpdHogd3JvdGU6DQo+
Pj4+PiBBcyBmb3IgaG93IHdlIGNhbiBhZGRyZXNzIHRoZSBpc3N1ZSwgSSBzZWUgdGhyZWUgd2F5
czoNCj4+Pj4+ICgxKSBUaGUgb25lIHByZXNlbnRlZCBpbiB0aGlzIHNlcmllczogT24gWEZTIHdp
dGggYWlvPW5hdGl2ZSwgd2UgZXh0ZW5kDQo+Pj4+PiAgICAgIHRyYWNrZWQgcmVxdWVzdHMgZm9y
IHBvc3QtRU9GIGZhbGxvY2F0ZSgpIGNhbGxzIChpLmUuLCB3cml0ZS16ZXJvDQo+Pj4+PiAgICAg
IG9wZXJhdGlvbnMpIHRvIHJlYWNoIHVudGlsIGluZmluaXR5IChJTlQ2NF9NQVggaW4gcHJhY3Rp
Y2UpLCBtYXJrDQo+Pj4+PiAgICAgIHRoZW0gc2VyaWFsaXppbmcgYW5kIHdhaXQgZm9yIG90aGVy
IGNvbmZsaWN0aW5nIHJlcXVlc3RzLg0KPj4+Pj4NCj4+Pj4+ICAgICAgQWR2YW50YWdlczoNCj4+
Pj4+ICAgICAgKyBMaW1pdHMgdGhlIGltcGFjdCB0byB2ZXJ5IHNwZWNpZmljIGNhc2VzDQo+Pj4+
PiAgICAgICAgKEFuZCB0aGF0IG1lYW5zIGl0IHdvdWxkbuKAmXQgaHVydCB0b28gbXVjaCB0byBr
ZWVwIHRoaXMgd29ya2Fyb3VuZA0KPj4+Pj4gICAgICAgIGV2ZW4gd2hlbiB0aGUgWEZTIGRyaXZl
ciBoYXMgYmVlbiBmaXhlZCkNCj4+Pj4+ICAgICAgKyBXb3JrcyBhcm91bmQgdGhlIGJ1ZyB3aGVy
ZSBpdCBoYXBwZW5zLCBuYW1lbHkgaW4gZmlsZS1wb3NpeA0KPj4+Pj4NCj4+Pj4+ICAgICAgRGlz
YWR2YW50YWdlczoNCj4+Pj4+ICAgICAgLSBBIGJpdCBjb21wbGV4DQo+Pj4+PiAgICAgIC0gQSBi
aXQgb2YgYSBsYXllcmluZyB2aW9sYXRpb24gKHNob3VsZCBmaWxlLXBvc2l4IGhhdmUgYWNjZXNz
IHRvDQo+Pj4+PiAgICAgICAgdHJhY2tlZCByZXF1ZXN0cz8pDQo+Pj4+DQo+Pj4+IFlvdXIgcGF0
Y2ggc2VyaWVzIGlzIHJlYXNvbmFibGUuICBJIGRvbid0IHRoaW5rIGl0J3MgdG9vIGJhZC4NCj4+
Pj4NCj4+Pj4gVGhlIG1haW4gcXVlc3Rpb24gaXMgaG93IHRvIGRldGVjdCB0aGUgWEZTIGZpeCBv
bmNlIGl0IHNoaXBzLiAgWEZTDQo+Pj4+IGFscmVhZHkgaGFzIGEgdG9uIG9mIGlvY3Rscywgc28g
bWF5YmUgdGhleSBkb24ndCBtaW5kIGFkZGluZyBhDQo+Pj4+IGZlYXR1cmUvcXVpcmsgYml0IG1h
cCBpb2N0bCBmb3IgcHVibGlzaGluZyBpbmZvcm1hdGlvbiBhYm91dCBidWcgZml4ZXMNCj4+Pj4g
dG8gdXNlcnNwYWNlLiAgSSBkaWRuJ3Qgc2VlIGFub3RoZXIgb2J2aW91cyB3YXkgb2YgZG9pbmcg
aXQsIG1heWJlIGENCj4+Pj4gbW91bnQgb3B0aW9uIHRoYXQgdGhlIGtlcm5lbCBhdXRvbWF0aWNh
bGx5IHNldHMgYW5kIHRoYXQgZ2V0cyByZXBvcnRlZA0KPj4+PiB0byB1c2Vyc3BhY2U/DQo+Pj4N
Cj4+PiBJ4oCZbGwgYWRkIGEgbm90ZSB0byB0aGUgUkggQlouDQo+Pj4NCj4+Pj4gSWYgd2UgaW1h
Z2luZSB0aGF0IFhGUyB3aWxsIG5vdCBwcm92aWRlIGEgbWVjaGFuaXNtIHRvIGRldGVjdCB0aGUN
Cj4+Pj4gcHJlc2VuY2Ugb2YgdGhlIGZpeCwgdGhlbiBjb3VsZCB3ZSBhc2sgUUVNVSBwYWNrYWdl
IG1haW50YWluZXJzIHRvDQo+Pj4+IC4vY29uZmlndXJlIC0tZGlzYWJsZS14ZnMtZmFsbG9jYXRl
LWJleW9uZC1lb2Ytd29ya2Fyb3VuZCBhdCBzb21lIHBvaW50DQo+Pj4+IGluIHRoZSBmdXR1cmUg
d2hlbiB0aGVpciBkaXN0cm8gaGFzIGJlZW4gc2hpcHBpbmcgYSBmaXhlZCBrZXJuZWwgZm9yIGEN
Cj4+Pj4gd2hpbGU/ICBJdCdzIHVnbHkgYmVjYXVzZSBpdCBkb2Vzbid0IHdvcmsgaWYgdGhlIHVz
ZXIgaW5zdGFsbHMgYW4gb2xkZXINCj4+Pj4gY3VzdG9tLWJ1aWx0IGtlcm5lbCBvbiB0aGUgaG9z
dC4gIEJ1dCBhdCBsZWFzdCBpdCB3aWxsIGNvdmVyIDk4JSBvZg0KPj4+PiB1c2Vycy4uLg0KPj4+
DQo+Pj4gOi0vDQo+Pj4NCj4+PiBJIGRvbuKAmXQgbGlrZSBpdCwgYnV0IEkgc3VwcG9zZSBpdCB3
b3VsZCB3b3JrLiAgV2UgY291bGQgYWxzbw0KPj4+IGF1dG9tYXRpY2FsbHkgZW5hYmxlIHRoaXMg
ZGlzYWJsaW5nIG9wdGlvbiBpbiBjb25maWd1cmUgd2hlbiB3ZSBkZXRlY3QNCj4+PiB1bmFtZSB0
byByZXBvcnQgYSBrZXJuZWwgdmVyc2lvbiB0aGF0IG11c3QgaW5jbHVkZSB0aGUgZml4LiAgKFRo
aXMNCj4+PiB3b3VsZG7igJl0IHdvcmsgZm9yIGtlcm5lbCB3aXRoIGJhY2twb3J0ZWQgZml4ZXMs
IGJ1dCB0aG9zZSBkaXNhcHBlYXIgb3Zlcg0KPj4+IHRpbWUuLi4pDQo+PiBJIGp1c3QgcmVhbGl6
ZWQgdGhhdCBub25lIG9mIHRoaXMgaXMgZ29pbmcgdG8gd29yayBmb3IgdGhlIGdsdXN0ZXIgY2Fz
ZQ0KPj4gYnJvdWdodCB1cCBieSBOaXIuICBUaGUgYWZmZWN0ZWQga2VybmVsIGlzIHRoZSByZW1v
dGUgb25lIGFuZCB3ZSBoYXZlIG5vDQo+PiBpbnNpZ2h0IGludG8gdGhhdC4gIEkgZG9u4oCZdCB0
aGluayB3ZSBjYW4gZG8gaW9jdGxzIHRvIFhGUyBvdmVyIGdsdXN0ZXIsDQo+PiBjYW4gd2U/DQo+
IA0KPiBPbiB0aGlyZCB0aG91Z2h0LCB3ZSBjb3VsZCB0cnkgdG8gZGV0ZWN0IHdoZXRoZXIgdGhl
IGZpbGUgaXMgb24gYSByZW1vdGUNCj4gZmlsZXN5c3RlbSwgYW5kIGlmIHNvIGVuYWJsZSB0aGUg
d29ya2Fyb3VuZCB1bmNvbmRpdGlvbmFsbHkuICBJIHN1cHBvc2UNCj4gaXQgd291bGRu4oCZdCBo
dXJ0IHBlcmZvcm1hbmNlLXdpc2UsIGdpdmVuIHRoYXQgaXTigJlzIGEgcmVtb3RlIGZpbGVzeXN0
ZW0NCj4gYW55d2F5Lg0KPiANCg0KSSB0aGluaywgZm9yIHJlbW90ZSwgdGhlIGRpZmZlcmVuY2Ug
bWF5IGJlIGV2ZW4gaGlnaGVyIHRoYW4gZm9yIGxvY2FsLCBhcyBjb3N0DQpvZiB3cml0aW5nIHJl
YWwgemVyb2VzIHRocm91Z2ggdGhlIHdpcmUgdnMgZmFzdCB6ZXJvIGNvbW1hbmQgaXMgaGlnaC4N
Cg0KUmVhbGx5LCBjYW4gd2UgbGl2ZSB3aXRoIHNpbXBsZSBjb25maWcgb3B0aW9uLCBpcyBpdCBz
byBiYWQ/DQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

