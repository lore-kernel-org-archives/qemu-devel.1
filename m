Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925DFCA9EC1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 11:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F5072086D
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 11:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pOnonSOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5072086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP36F-0001JB-B7
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 07:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iP34Q-0007Dp-KA
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 07:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iP33D-00044U-Ce
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 07:19:08 -0400
Received: from mail-eopbgr80091.outbound.protection.outlook.com
 ([40.107.8.91]:38890 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iP33C-00043a-LE; Mon, 28 Oct 2019 07:19:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnOOj8Kdkpnbr2YRZrlCarZYZBpaGUIzWL/iyAWvBqYy6YBlEcIcm/ET5viHMWIVq7yjslcteT9lb8C0UjhL9vhkLwmmo/V1BDE4yXJxV0rsYyQ/pk6Vmy8UQQdhoNjeNXSoIYHfv29fbxCWRu2It8XgRN0MgAzUON+9i+nwzvMrXDXOXLITDJgKnDuR2z9nbJzNhxpHUrXbpaFyNwxW+oeWlhklV4IlQuApTGvqasnXsOCOwmk//VDVSj/awZuMB3bBJ0WwQJF/3nwz16i+1t2t4TTaIuSIZtzf8rFD2Z9Ywpcbi/oJSNEsm3Ekz+JdJuib+ifNbBzIDtLAbdj6Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsrn4M2JvNf8TzeEFVJ+Yt09JOOGnPYLvCCIu4gSR7c=;
 b=gSB8yYqx6A0JmWcxKCWyw4WasvVL97hZggGGDzjj20vmaZRsV+rJeI6X7DMUwtqpSGIZGEnY5yrI+nNQD5A8hn/5BoimEQ9ijZQ12CfwdwixgJL3yDmkA1mOwI+XEMpLAt0891FiedCC8C9XY+5eVV2lgGpL2Q5pNhFDAmynxk0YkuIsJTW6YCT4NyruiQp90c0P57omGfFKkOZE1p/I4N+om2r5S9xsz9m0MZA+sNCW+86fxJC1oGWzn0EAjItk3kqoDxYlEjFKF8pubM5ROukzpVJr/EILU5xdFaBMl+p1D/4TLkYCUURzx5+0wY7qplYJWenR9EjDvWvFQ7BI4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsrn4M2JvNf8TzeEFVJ+Yt09JOOGnPYLvCCIu4gSR7c=;
 b=pOnonSOTVAzt5GjDUpN8k7gN9TarWo6Hi0j+wry10D8dOiiOf7OiDKktSk94dmru9lZhj8AOunpAbiNu1RtYr9903Z/W4LCQBVLsVodxmmacu3lOcxqcU6cZv0kdo+4Fjd8fR4NKy5C+fDnEC9UV6YXgmVIm+3Pjt29VDWokIIU=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB4001.eurprd08.prod.outlook.com (20.178.118.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Mon, 28 Oct 2019 11:19:03 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119%6]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 11:19:03 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC 0/3] block/file-posix: Work around XFS bug
Thread-Topic: [RFC 0/3] block/file-posix: Work around XFS bug
Thread-Index: AQHVixrVzIJNY5LqnE6V3J8eZcL1nqdub/GAgAFcuACAAAHogIAAB0wAgAA1JYD//86agIAAEywA
Date: Mon, 28 Oct 2019 11:19:02 +0000
Message-ID: <d06f5ce1-02af-960b-1e91-fc337bdb7a67@virtuozzo.com>
References: <20191025095849.25283-1-mreitz@redhat.com>
 <20191027123555.GN4472@stefanha-x1.localdomain>
 <81bb0f91-2671-c9e5-f791-c7470dfd75ce@redhat.com>
 <c38e000b-a120-2726-65a2-61c63fcc101f@redhat.com>
 <0f81f678-7d0d-56d3-d236-c077e4251f1a@redhat.com>
 <f89d91d0-c835-d09a-6fcb-d1b030a05ef5@virtuozzo.com>
 <be14f922-449b-01fb-27d3-4860c3336ea6@redhat.com>
In-Reply-To: <be14f922-449b-01fb-27d3-4860c3336ea6@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0002.eurprd03.prod.outlook.com
 (2603:10a6:3:76::12) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191028141900299
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11d12841-2797-4dde-715d-08d75b98a33e
x-ms-traffictypediagnostic: AM0PR08MB4001:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB400122677875EAB4DEC05B99C1660@AM0PR08MB4001.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(346002)(39840400004)(396003)(376002)(199004)(189003)(186003)(31696002)(256004)(71200400001)(102836004)(71190400001)(14444005)(11346002)(446003)(99286004)(2616005)(66066001)(4326008)(2906002)(6506007)(6246003)(53546011)(110136005)(54906003)(6116002)(386003)(3846002)(316002)(478600001)(486006)(25786009)(86362001)(6436002)(52116002)(76176011)(66476007)(64756008)(66556008)(66446008)(476003)(36756003)(7736002)(66946007)(6486002)(81156014)(14454004)(229853002)(5660300002)(6512007)(8936002)(305945005)(26005)(31686004)(81166006)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4001;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NYljThHo06dU9MhkxG4b3dBzKGSQK8YeP5+aKeAzTuoBX+OvjQAx+1iQlOEWABcwelLquZQ9ndux3KVkGdJC2d7At6ixyMATOTJT5cRI/a2HPlvCczoQFp8iqs/LOxUzmQpYpJYI6lZo6jm76Hc8AxGMVSzcvNc7wOUnMubJGp9kzuZ6HdFie4dQILJqFwD16tBw2phgAolinjq7K6MQgXnYQKcrTBVtah08DmZIl/nIdOF0MOMvZq20LeRnqSRPKyvmbHA29Tn0yGAx/fyzd6IrDwZQeAaldiniPywJ4/kjdNUhDTCV5BfE+q5uqoZ6x8V0WBK6snO8LnqIxqCrhNC9KW085A7JyFHsLjqjsEBkA1IOn4ua3H0fJMZTJt+4d4LFOK/WC/EvpZjt4H5e23Zh5xgMlssvtNnH7fdjJr46nLhS0tWsXoZENGZZTpIL
Content-Type: text/plain; charset="utf-8"
Content-ID: <22AB6F0624C63042B06F98CE740BFE72@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d12841-2797-4dde-715d-08d75b98a33e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 11:19:03.0038 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2+yJWnUI4SgXgMjd53v5loL/AWGtnu08tYrJqLGc50QiMATEKInLIn+x5m//pXDywh6pf6VjN2he3Uuy88HJfkz0Xi6N+YA5QsGuC3PsJI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4001
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.91
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

MjguMTAuMjAxOSAxMzoxMCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyOC4xMC4xOSAxMTowNywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDI4LjEwLjIwMTkgMTI6NTYs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAyOC4xMC4xOSAxMDozMCwgTWF4IFJlaXR6IHdyb3Rl
Og0KPj4+PiBPbiAyOC4xMC4xOSAxMDoyNCwgTWF4IFJlaXR6IHdyb3RlOg0KPj4+Pj4gT24gMjcu
MTAuMTkgMTM6MzUsIFN0ZWZhbiBIYWpub2N6aSB3cm90ZToNCj4+Pj4+PiBPbiBGcmksIE9jdCAy
NSwgMjAxOSBhdCAxMTo1ODo0NkFNICswMjAwLCBNYXggUmVpdHogd3JvdGU6DQo+Pj4+Pj4+IEFz
IGZvciBob3cgd2UgY2FuIGFkZHJlc3MgdGhlIGlzc3VlLCBJIHNlZSB0aHJlZSB3YXlzOg0KPj4+
Pj4+PiAoMSkgVGhlIG9uZSBwcmVzZW50ZWQgaW4gdGhpcyBzZXJpZXM6IE9uIFhGUyB3aXRoIGFp
bz1uYXRpdmUsIHdlIGV4dGVuZA0KPj4+Pj4+PiAgICAgICB0cmFja2VkIHJlcXVlc3RzIGZvciBw
b3N0LUVPRiBmYWxsb2NhdGUoKSBjYWxscyAoaS5lLiwgd3JpdGUtemVybw0KPj4+Pj4+PiAgICAg
ICBvcGVyYXRpb25zKSB0byByZWFjaCB1bnRpbCBpbmZpbml0eSAoSU5UNjRfTUFYIGluIHByYWN0
aWNlKSwgbWFyaw0KPj4+Pj4+PiAgICAgICB0aGVtIHNlcmlhbGl6aW5nIGFuZCB3YWl0IGZvciBv
dGhlciBjb25mbGljdGluZyByZXF1ZXN0cy4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gICAgICAgQWR2YW50
YWdlczoNCj4+Pj4+Pj4gICAgICAgKyBMaW1pdHMgdGhlIGltcGFjdCB0byB2ZXJ5IHNwZWNpZmlj
IGNhc2VzDQo+Pj4+Pj4+ICAgICAgICAgKEFuZCB0aGF0IG1lYW5zIGl0IHdvdWxkbuKAmXQgaHVy
dCB0b28gbXVjaCB0byBrZWVwIHRoaXMgd29ya2Fyb3VuZA0KPj4+Pj4+PiAgICAgICAgIGV2ZW4g
d2hlbiB0aGUgWEZTIGRyaXZlciBoYXMgYmVlbiBmaXhlZCkNCj4+Pj4+Pj4gICAgICAgKyBXb3Jr
cyBhcm91bmQgdGhlIGJ1ZyB3aGVyZSBpdCBoYXBwZW5zLCBuYW1lbHkgaW4gZmlsZS1wb3NpeA0K
Pj4+Pj4+Pg0KPj4+Pj4+PiAgICAgICBEaXNhZHZhbnRhZ2VzOg0KPj4+Pj4+PiAgICAgICAtIEEg
Yml0IGNvbXBsZXgNCj4+Pj4+Pj4gICAgICAgLSBBIGJpdCBvZiBhIGxheWVyaW5nIHZpb2xhdGlv
biAoc2hvdWxkIGZpbGUtcG9zaXggaGF2ZSBhY2Nlc3MgdG8NCj4+Pj4+Pj4gICAgICAgICB0cmFj
a2VkIHJlcXVlc3RzPykNCj4+Pj4+Pg0KPj4+Pj4+IFlvdXIgcGF0Y2ggc2VyaWVzIGlzIHJlYXNv
bmFibGUuICBJIGRvbid0IHRoaW5rIGl0J3MgdG9vIGJhZC4NCj4+Pj4+Pg0KPj4+Pj4+IFRoZSBt
YWluIHF1ZXN0aW9uIGlzIGhvdyB0byBkZXRlY3QgdGhlIFhGUyBmaXggb25jZSBpdCBzaGlwcy4g
IFhGUw0KPj4+Pj4+IGFscmVhZHkgaGFzIGEgdG9uIG9mIGlvY3Rscywgc28gbWF5YmUgdGhleSBk
b24ndCBtaW5kIGFkZGluZyBhDQo+Pj4+Pj4gZmVhdHVyZS9xdWlyayBiaXQgbWFwIGlvY3RsIGZv
ciBwdWJsaXNoaW5nIGluZm9ybWF0aW9uIGFib3V0IGJ1ZyBmaXhlcw0KPj4+Pj4+IHRvIHVzZXJz
cGFjZS4gIEkgZGlkbid0IHNlZSBhbm90aGVyIG9idmlvdXMgd2F5IG9mIGRvaW5nIGl0LCBtYXli
ZSBhDQo+Pj4+Pj4gbW91bnQgb3B0aW9uIHRoYXQgdGhlIGtlcm5lbCBhdXRvbWF0aWNhbGx5IHNl
dHMgYW5kIHRoYXQgZ2V0cyByZXBvcnRlZA0KPj4+Pj4+IHRvIHVzZXJzcGFjZT8NCj4+Pj4+DQo+
Pj4+PiBJ4oCZbGwgYWRkIGEgbm90ZSB0byB0aGUgUkggQlouDQo+Pj4+Pg0KPj4+Pj4+IElmIHdl
IGltYWdpbmUgdGhhdCBYRlMgd2lsbCBub3QgcHJvdmlkZSBhIG1lY2hhbmlzbSB0byBkZXRlY3Qg
dGhlDQo+Pj4+Pj4gcHJlc2VuY2Ugb2YgdGhlIGZpeCwgdGhlbiBjb3VsZCB3ZSBhc2sgUUVNVSBw
YWNrYWdlIG1haW50YWluZXJzIHRvDQo+Pj4+Pj4gLi9jb25maWd1cmUgLS1kaXNhYmxlLXhmcy1m
YWxsb2NhdGUtYmV5b25kLWVvZi13b3JrYXJvdW5kIGF0IHNvbWUgcG9pbnQNCj4+Pj4+PiBpbiB0
aGUgZnV0dXJlIHdoZW4gdGhlaXIgZGlzdHJvIGhhcyBiZWVuIHNoaXBwaW5nIGEgZml4ZWQga2Vy
bmVsIGZvciBhDQo+Pj4+Pj4gd2hpbGU/ICBJdCdzIHVnbHkgYmVjYXVzZSBpdCBkb2Vzbid0IHdv
cmsgaWYgdGhlIHVzZXIgaW5zdGFsbHMgYW4gb2xkZXINCj4+Pj4+PiBjdXN0b20tYnVpbHQga2Vy
bmVsIG9uIHRoZSBob3N0LiAgQnV0IGF0IGxlYXN0IGl0IHdpbGwgY292ZXIgOTglIG9mDQo+Pj4+
Pj4gdXNlcnMuLi4NCj4+Pj4+DQo+Pj4+PiA6LS8NCj4+Pj4+DQo+Pj4+PiBJIGRvbuKAmXQgbGlr
ZSBpdCwgYnV0IEkgc3VwcG9zZSBpdCB3b3VsZCB3b3JrLiAgV2UgY291bGQgYWxzbw0KPj4+Pj4g
YXV0b21hdGljYWxseSBlbmFibGUgdGhpcyBkaXNhYmxpbmcgb3B0aW9uIGluIGNvbmZpZ3VyZSB3
aGVuIHdlIGRldGVjdA0KPj4+Pj4gdW5hbWUgdG8gcmVwb3J0IGEga2VybmVsIHZlcnNpb24gdGhh
dCBtdXN0IGluY2x1ZGUgdGhlIGZpeC4gIChUaGlzDQo+Pj4+PiB3b3VsZG7igJl0IHdvcmsgZm9y
IGtlcm5lbCB3aXRoIGJhY2twb3J0ZWQgZml4ZXMsIGJ1dCB0aG9zZSBkaXNhcHBlYXIgb3Zlcg0K
Pj4+Pj4gdGltZS4uLikNCj4+Pj4gSSBqdXN0IHJlYWxpemVkIHRoYXQgbm9uZSBvZiB0aGlzIGlz
IGdvaW5nIHRvIHdvcmsgZm9yIHRoZSBnbHVzdGVyIGNhc2UNCj4+Pj4gYnJvdWdodCB1cCBieSBO
aXIuICBUaGUgYWZmZWN0ZWQga2VybmVsIGlzIHRoZSByZW1vdGUgb25lIGFuZCB3ZSBoYXZlIG5v
DQo+Pj4+IGluc2lnaHQgaW50byB0aGF0LiAgSSBkb27igJl0IHRoaW5rIHdlIGNhbiBkbyBpb2N0
bHMgdG8gWEZTIG92ZXIgZ2x1c3RlciwNCj4+Pj4gY2FuIHdlPw0KPj4+DQo+Pj4gT24gdGhpcmQg
dGhvdWdodCwgd2UgY291bGQgdHJ5IHRvIGRldGVjdCB3aGV0aGVyIHRoZSBmaWxlIGlzIG9uIGEg
cmVtb3RlDQo+Pj4gZmlsZXN5c3RlbSwgYW5kIGlmIHNvIGVuYWJsZSB0aGUgd29ya2Fyb3VuZCB1
bmNvbmRpdGlvbmFsbHkuICBJIHN1cHBvc2UNCj4+PiBpdCB3b3VsZG7igJl0IGh1cnQgcGVyZm9y
bWFuY2Utd2lzZSwgZ2l2ZW4gdGhhdCBpdOKAmXMgYSByZW1vdGUgZmlsZXN5c3RlbQ0KPj4+IGFu
eXdheS4NCj4+Pg0KPj4NCj4+IEkgdGhpbmssIGZvciByZW1vdGUsIHRoZSBkaWZmZXJlbmNlIG1h
eSBiZSBldmVuIGhpZ2hlciB0aGFuIGZvciBsb2NhbCwgYXMgY29zdA0KPj4gb2Ygd3JpdGluZyBy
ZWFsIHplcm9lcyB0aHJvdWdoIHRoZSB3aXJlIHZzIGZhc3QgemVybyBjb21tYW5kIGlzIGhpZ2gu
DQo+IA0KPiBJIHdhcyBzcGVha2luZyBvZiBhIHdvcmthcm91bmQgaW4gZ2VuZXJhbCwgYW5kIHRo
YXQgaW5jbHVkZXMgdGhlDQo+IHdvcmthcm91bmQgcHJlc2VudGVkIGluIHRoaXMgc2VyaWVzLg0K
DQpBaCwgeWVzLCBzb3JyeS4gVGhlbiBpdCBzaG91bGQgYmUgT0suDQoNCj4gDQo+PiBSZWFsbHks
IGNhbiB3ZSBsaXZlIHdpdGggc2ltcGxlIGNvbmZpZyBvcHRpb24sIGlzIGl0IHNvIGJhZD8NCj4g
DQo+IFRoZSBjb25maWcgb3B0aW9uIHdvbuKAmXQgd29yayBmb3IgcmVtb3RlIGhvc3RzLCB0aG91
Z2guICBUaGF04oCZcyBleGFjdGx5DQo+IHRoZSBwcm9ibGVtLg0KPiANCg0KU3RpbGwgY29uZmln
IG9wdGlvbiB3aWxsIGhlbHAgcGVvcGxlIHdobyBoYXZlIHhmcyBzZXR1cHMgYW5kIHdhbnQgdG8g
YmUgYWJzb2x1dGVseSBzYWZlLg0KKE9yLCB3aXRoIGFub3RoZXIgZGVmYXVsdCwgaGVscCBwZW9w
bGUgd2hvIGRvZXNuJ3QgaGF2ZSB4ZnMgc2V0dXBzIChWaXJ0dW96em8pIGFuZCB3YW50IHRvIGJl
IGZhc3QpDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

