Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44025C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 08:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F387A2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 08:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HitnfI7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F387A2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iex5j-0006Or-7v
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 03:11:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iex4k-0005sp-8P
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 03:10:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iex4i-00056i-6S
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 03:10:25 -0500
Received: from mail-eopbgr50096.outbound.protection.outlook.com
 ([40.107.5.96]:49810 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iex4h-0004rm-5D; Wed, 11 Dec 2019 03:10:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/reDJNbxOXP8ESTgTKVa+7EBNy3X2wFNQSnNW9PvvjD1TxV3B1zh6ydJBpxpG/VQ+VnaGQ0WVusPWE3w1G66kzGxzOaDYzYG8X4V2kzENhXOjDg3EzNDg9hl/xUZfSjg3oC/rG5heeE+4bYlfSy15cfIILBu9Pem8dY7cwF6n7WICAoguRfJ33qljxGlavF8tukpNvEqAoUqXBy1wd2JsJwmI7CSb3zty3RfgZMuzHgWO9aqcbtSBEHfu4co4ak3uikEK49ZRFUvee1+HjSNFxC7skpxc4dIrRVA2rHrG1RE1wtIVyW/fc5oJKAkal+70Wai9edNjkewQiEzVCpyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+17d/slxySVuGwpU49LsWxFlAGD7xzTIjsU44ynm578=;
 b=ggthDFaZFY1m1oXAnsQoOgymIoPxRuStdcxgdnUrXnWst1fHylwSeLk01f5wm/RcmAjMnADU3+YpkZWEEBpwKVprsQPTnvwpZOgKTf9PdFNP8YMYsHgF/9oWoz8pRa0iHgx7GUfMoCX2OHZZ4lVTXteYCZjnkr3Mr3mtYPq1XTFBfnMvN2DQxJhr/mKpD9wJhYH5WzuRgyrixgCQKncnbgbTjI3tK202b3y4AqjIeVDUjnD7zCIcouzNRHooKczmtbSCI0AEIjeClw8dr29q3OKXGkn1V9L3ukLKOv5dv6okNIRl5D8zi6MJ+Zuw28pxT0ag67NKCTUXOVX0dXF7gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+17d/slxySVuGwpU49LsWxFlAGD7xzTIjsU44ynm578=;
 b=HitnfI7yGJ283JGQJY4X5d4uIxTJsskrReh8bgvdbvBkMFpOUENSnBLwarIxClwJP/E5CekzZHBqMWaBoiOgy3nXaLiyiLGv5eIvTfiTs6BUi27A7UHf/cVdecVV53VT6Gofc97U53E6Xoc+egGIU9Dxpj1AtdpC63/dh7y2SQs=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3463.eurprd08.prod.outlook.com (20.177.112.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Wed, 11 Dec 2019 08:10:12 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 08:10:12 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake
 <eblake@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [bugfix ping2] Re: [PATCH v2 0/2] fix
 qcow2_can_store_new_dirty_bitmap
Thread-Topic: [bugfix ping2] Re: [PATCH v2 0/2] fix
 qcow2_can_store_new_dirty_bitmap
Thread-Index: AQHVqRoX5sySbwm2dE6d/PWp4kJbp6eyCdWAgAAYdACAAERwgIAAqeCAgABXdwCAAHZVAIAAxDYA
Date: Wed, 11 Dec 2019 08:10:12 +0000
Message-ID: <8b5c1081-4ea0-04d1-5b94-211de7a9c971@virtuozzo.com>
References: <20191014115126.15360-1-vsementsov@virtuozzo.com>
 <e89b8844-26c7-0768-f6dd-6faa814551e2@virtuozzo.com>
 <0db82122-ee0d-a346-cb49-d902d5d66b77@virtuozzo.com>
 <cbba2b12-da7d-eed8-1f6b-fc2412f82ff8@redhat.com>
 <a67b4a16-773c-52c8-288a-0e9e032b4589@redhat.com>
 <466a95d3-e808-02d1-94df-27bf1e4e13ee@redhat.com>
 <a7f98c9a-6b3e-c6a5-fd6d-96db14ed612f@redhat.com>
 <3f84b0c2-c95d-f42e-9494-8d67ff3ebc28@redhat.com>
 <ea123cb2-4a4f-4321-723e-b0d12ab52657@redhat.com>
In-Reply-To: <ea123cb2-4a4f-4321-723e-b0d12ab52657@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0003.eurprd07.prod.outlook.com
 (2603:10a6:7:67::13) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191211111010143
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1aa13329-ad13-4495-3b9f-08d77e118bba
x-ms-traffictypediagnostic: AM6PR08MB3463:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB34632E0759218B77D132C1EFC15A0@AM6PR08MB3463.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(346002)(39850400004)(396003)(376002)(199004)(189003)(6512007)(8936002)(71200400001)(26005)(8676002)(110136005)(2906002)(81166006)(2616005)(81156014)(316002)(36756003)(86362001)(6486002)(66946007)(66476007)(66446008)(52116002)(54906003)(4326008)(6506007)(966005)(53546011)(5660300002)(478600001)(186003)(64756008)(66556008)(107886003)(31696002)(31686004)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3463;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7cuVwRoUIPSFx/V3t4/uundfBozS6DMYuGfpEnv/dAdc2fzJOFaTSgm7KVTgKWEVAC7ExGRLY3ENToeEHCZbdLlFUdtD8Sd5FZj8TIlbfDToVG8jv8Do6bJHbfFeF3eOTaP4awoVH9SvtunsMn/XjAxH+yIWe6sbMHXsOHLC4Rue1dCgdP8ylQb59IPEdO4xIpdHtETeC5qsye7mMpQK463YVlg344PwVcTQeriUz6Aom0zVd15lqcFzczPIxuZDic+1iaOu8CG6x3KncOpsyU+RGaULGMgYUvaM/oDNHT/WG3eYisG1V2CpalrdrX/RFByzLcewMUow6lbSo5RazEYBaKMWNTfKPUCV8ftcA9hKFqDGkABEzc3unLR29DTyporLXpjg1bkULZF5u+th+3nSW3OKfQJ6Bo7CdXikDXH4eFMYDHUWluOP0afwhd+WDCqMpDE4qyrMR4GM45aPCxcj/oY15c7lc3rewEELbyeZ0JgpkI82hqKQ37ZpEoCHENZ5vEWPXKvJhRiXK9MboA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <54FE2F1D1A4DAB428AE7202BD650659B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa13329-ad13-4495-3b9f-08d77e118bba
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 08:10:12.1425 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WBBH/GJPO81WvyFZRIHPWEEGF62u5MRotBea3r+CtJUabY4BHGL9pNE50D1DJc92Dppu7LJKBKhKkLlLREtrXUrkxDHVtbvc2z9PmFYpFvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3463
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.96
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTAuMTIuMjAxOSAyMzoyNywgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDEyLzEwLzE5
IDg6MjQgQU0sIE1heCBSZWl0eiB3cm90ZToNCj4+IE9uIDEwLjEyLjE5IDA5OjExLCBNYXggUmVp
dHogd3JvdGU6DQo+Pj4gT24gMDkuMTIuMTkgMjM6MDMsIEVyaWMgQmxha2Ugd3JvdGU6DQo+Pj4+
IE9uIDEyLzkvMTkgMTE6NTggQU0sIE1heCBSZWl0eiB3cm90ZToNCj4+Pj4+IE9uIDA5LjEyLjE5
IDE3OjMwLCBNYXggUmVpdHogd3JvdGU6DQo+Pj4+Pj4gT24gMDIuMTIuMTkgMTU6MDksIFZsYWRp
bWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4+Pj4+IEhpIGFnYWluIQ0KPj4+Pj4+
Pg0KPj4+Pj4+PiBTdGlsbCBmb3Jnb3R0ZW4gYnVnLWZpeCA6KA0KPj4+Pj4+Pg0KPj4+Pj4+PiBJ
cyBpdCB0b28gbGF0ZSBmb3IgNC4yPw0KPj4+Pj4+DQo+Pj4+Pj4gU29ycnkuIDotLw0KPj4+Pj4+
DQo+Pj4+Pj4gWWVzLCBJIHRoaW5rIEkganVzdCBmb3Jnb3QgaXQuwqAgSSBkb27igJl0IHRoaW5r
IGl04oCZcyB0b28gaW1wb3J0YW50IGZvcg0KPj4+Pj4+IDQuMiwgc28sIHdlbGwsIGl0IGlzbuKA
mXQgdG9vIGJhZCwgYnV0Li4uwqAgU29ycnkuDQo+Pj4+Pj4NCj4+Pj4+Pj4gSSBjYW4ndCBpbWFn
aW5lIGJldHRlciB0ZXN0LCBhbmQgaXQgdGVzdHMgZXhhY3RseSB3aGF0IHdyaXR0ZW4gaW4NCj4+
Pj4+Pj4gaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNnaT9pZD0xNzEyNjM2
DQo+Pj4+Pj4+DQo+Pj4+Pj4+IChIbW0sIGFjdHVhbGx5LCBJIGRvdWJ0IHRoYXQgaXQgaXMgcmVh
bCB1c2UtY2FzZSwgbW9yZSBwcm9iYWJseSBpdCdzDQo+Pj4+Pj4+IGEgYnVnIGluIG1hbmFnZW1l
bnQgbGF5ZXIpDQo+Pj4+Pj4+DQo+Pj4+Pj4+IFNvLCB0YWtlIHRoaXMgd2l0aCB0ZXN0IG9yIHdp
dGhvdXQgdGVzdCwgdG8gNC4yIG9yIDUuMC4NCj4+Pj4+Pg0KPj4+Pj4+IEkgd2FzIHRoaW5raW5n
IG9mIHNlZWluZyB3aGV0aGVyIEkgY291bGQgd3JpdGUgYSBxdWlja2VyIHRlc3QsIGJ1dCBvZg0K
Pj4+Pj4+IGNvdXJzZSB3ZSBzaG91bGQgdGFrZSB0aGUgcGF0Y2ggZWl0aGVyIHdheS4NCj4+Pj4+
DQo+Pj4+PiBPSywgSSBnaXZlIHVwLsKgIEl04oCZcyB2ZXJ5IG11Y2ggcG9zc2libGUgdG8gY3Jl
YXRlIGFuIGltYWdlIHdpdGggNjU1MzUNCj4+Pj4+IGJpdG1hcHMgdmVyeSBxdWlja2x5IChsaWtl
LCB1bmRlciBhIHNlY29uZCkgb3V0c2lkZSBvZiBxZW11LCBidXQganVzdA0KPj4+Pj4gb3Blbmlu
ZyBpdCB0YWtlcyAyOjMwIG1pbiAoYmVjYXVzZSBvZiB0aGUgcXVhZHJhdGljIGNvbXBsZXhpdHkg
b2YNCj4+Pj4+IGNoZWNraW5nIHdoZXRoZXIgYSBiaXRtYXAgb2YgdGhlIHNhbWUgbmFtZSBhbHJl
YWR5IGV4aXN0cykuDQo+Pj4+DQo+Pj4+IENhbiB3ZSBmaXggdGhhdCB0byB1c2UgYSBoYXNoIHRh
YmxlIGZvciBhbW9ydGl6ZWQgTygxKSBsb29rdXAgcmF0aGVyDQo+Pj4+IHRoYW4gdGhlIGN1cnJl
bnQgTyhuKSBsb29rdXA/DQo+Pj4NCj4+PiBOb3QgdW5yZWFzb25hYmxlLCBjb25zaWRlcmluZyB0
aGF0IHRoaXMgaXMgcHJvYmFibHkgd2hhdCB3ZSB3b3VsZOKAmXZlDQo+Pj4gZG9uZSBmcm9tIHRo
ZSBzdGFydCBpbiBhbnkgbGFuZ3VhZ2Ugd2hlcmUgaGFzaCB0YWJsZXMgYXJlIGJ1aWx0IGluLg0K
Pj4+DQo+Pj4gQnV0IE9UT0ggd2hlbiB5b3UgaGF2ZSA2NmsgYml0bWFwcywgeW91IHByb2JhYmx5
IGhhdmUgb3RoZXIgcHJvYmxlbXMuDQo+Pj4gTGlrZSwgd3JpdGVzIGJlaW5nIGluY3JlZGlibHkg
c2xvdywgYmVjYXVzZSBhbGwgdGhvc2UgYml0bWFwcyBoYXZlIHRvIGJlDQo+Pj4gdXBkYXRlZC4N
Cj4+Pg0KPj4+IChXZWxsLCB5b3UgY2FuIHRlY2huaWNhbGx5IGhhdmUgOTkgJSBvZiB0aGVtIGRp
c2FibGVkLCBidXQgd2hv4oCZZCBkbyBzdWNoDQo+Pj4gYSB0aGluZz8pDQo+Pj4NCj4+PiAoKE1h
eWJlIEnigJlsbCBsb29rIGludG8gaXQuKSkNCj4+DQo+PiBIbW0sIG5vdyBJIGRpZC4gIFRoaXMg
Z2V0cyB0aGUgdGVzdCBkb3duIHRvIDI0IHMuICBTdGlsbCBub3Qgc3VyZQ0KPj4gd2hldGhlciBp
dOKAmXMgd29ydGggaXQsIHRob3VnaC4uLg0KPj4NCj4+IE1heA0KPj4NCj4gDQo+IEkgYWdyZWUg
d2UgdmVyeSBsaWtlbHkgaGF2ZSBvdGhlciBwcm9ibGVtcyBvbmNlIHdlIHJlYWNoIHJlc291cmNl
IHVzYWdlDQo+IG9mIHRoaXMgbGV2ZWwuDQo+IA0KPiANCj4gU3RpbGwsIGlmIHdlIHdhbnQgdG8g
bWFrZSB0aGlzIGJsYXppbmcgZmFzdCBmb3IgdGhlIGxvdmUgb2YgZG9pbmcgc286DQo+IA0KPiAo
MSkgUmVhZCBpbiB0aGUgZGlyZWN0b3J5ICpvbmNlKiwgYW5kIGNhY2hlIGl0LiBXZSBoYXZlIGF2
b2lkZWQgZG9pbmcNCj4gdGhpcyBsYXJnZWx5IHRvIGZlZWwgbW9yZSBjb25maWRlbnQgdGhhdCB0
aGUgY29kZSBpcyBjb3JyZWN0IGFuZCBpcw0KPiBuZXZlciB3b3JraW5nIG9uIGFuICJvdXRkYXRl
ZCIgdmVyc2lvbiBvZiB0aGUgZGlyZWN0b3J5Lg0KPiANCj4gW09uIGNhY2hlIGludmFsaWRhdGlv
biwgd2UgY2FuIHdyaXRlIHRoZSBkaXJlY3RvcnkgYmFjayBvdXQgdG8gdGhlDQo+IGJpdG1hcCwg
YW5kIGRlbGV0ZSBvdXIgY2FjaGUuIFRoZSBuZXh0IHRpbWUgd2UgbmVlZCB0aGUgbGlzdCwgd2Ug
Y2FuDQo+IHJlbG9hZCBpdC4gVGhpcyBzaG91bGQgYWxsZXZpYXRlIGNvbnNpc3RlbmN5IGNvbmNl
cm5zLl0NCg0KTm90ZSwgdGhhdCBpbiB0aGlzIGNhc2UsIGlmIHdlIHdhbnQgdG8gbW9kaWZ5IGNh
Y2hlZCBkaXJlY3RvcnksIGJpdG1hcHMNCmNvbXBhdGlibGUgYml0IG11c3QgYmUgY2xlYXJlZCAo
c28sIGlmIHdlIGZhaWwgdG8gZmx1c2ggZGlyZWN0b3J5IGF0IHNvbWUNCm1vbWVudCwgd2UganVz
dCBsb3NlIGJpdG1hcHMsIG5vdCB0aGUgY29uc2lzdGVuY3kpDQoNCk5vdGUyLCBpbnRlcmVzdGlu
ZywgY291bGQgZXhpc3RpbmcgcWNvdzIgbWV0YWRhdGEgY2FjaGluZyBpbmZyYXN0cnVjdHVyZSBi
ZQ0KcmV1c2VkPw0KDQo+IA0KPiANCj4gKDIpIFN0b3JlIHRoZSBlbnRyaWVzIGluIGFuIHJidHJl
ZSEgNjU1MzYgZW50cmllcyBpcyBvbmx5IH4xNiBsb29rdXBzDQo+IG1heGltdW0gaW4gdGhlIHdv
cnN0IGNhc2UuIEkgdG9vayBhIGxvb2sgYXQgdGhlIGxpbnV4IHJidHJlZQ0KPiBpbXBsZW1lbnRh
dGlvbiBhbmQgZGlkIGEgdmVyeSBxdWljayBiYWNrLW9mLXRoZS1lbnZlbG9wZSBiZW5jaG1hcmtp
bmcNCj4gZm9yIGluc2VydGluZyBzdHJpbmdzIChsZW49MzIpIGludG8gYSB0cmVlOg0KPiANCj4g
bmFtZSBnZW5lcmF0aW9uIDUzMTUxIHVzZWMNCj4gaW5zZXJ0IFswLTEwXSA1IHVzZWMNCj4gaW5z
ZXJ0IFsxMC0xMDBdIDE0IHVzZWMNCj4gaW5zZXJ0IFsxMDAtMTAwMF0gMTk1IHVzZWMNCj4gaW5z
ZXJ0IFsxMDAwLTEwMDAwXSAyOTE5IHVzZWMNCj4gaW5zZXJ0IFsxMDAwMC02NTUzNl0gNDE0ODUg
dXNlYw0KPiANCj4gVGhpcyBzZWVtcyBmYXN0IGVub3VnaCB0aGF0IHdlJ3JlIGxpa2VseSBnb2lu
ZyB0byBiZSBlY2xpcHNlZCBqdXN0IGJ5DQo+IG90aGVyIHN0cmluZyBoYW5kbGluZyBjb25jZXJu
cy4NCj4gDQoNCklzIHJidHJlZSB0aGUgYmVzdCB0aGluZyB0byB1c2U/IE1heSBiZSwgYmV0dGVy
IHRvIGNvbnN0cnVjdCBwcmVmaXggdHJlZT8NClN0aWxsLCBJIHRoaW5rIGdfaGFzaF90YWJsZSBz
aG91bGQgYmUgZW5vdWdoIGFuZCBtb3N0IHNpbXBsZSB0byB1c2UuLg0KDQpTdGlsbCwgSSByZWFs
bHkgZG91YnQgdGhhdCBpdCB3b3J0aCBpdCwgYXMgd2UgbmV2ZXIgaGF2ZSB0b28gbWFueSBiaXRt
YXBzLi4NCg0KQWN0dWFsbHkgdGhlcmUgaXMgbm8gcmVhc29uIHRvIGhhdmUgbW9yZSB0aGFuIG9u
ZSBhY3RpdmUgYml0bWFwLiBTbywNCndlIG1heSBoYXZlIGEgbG90IG9mIGRpc2FibGVkIGJpdG1h
cHMsIG1hcmtpbmcgc29tZSBoaXN0b3J5IG9mIHRoZQ0KZHJpdmUuDQoNCkkgdGhpbmssIGluIHRo
aXMgY2FzZSwgdGhlIGJldHRlciBvcHRpbWl6YXRpb24gd291bGQgYmUgdG8gdGVhY2ggUWVtdQ0K
bm90IHRvIGxvYWQgZGlzYWJsZWQgYml0bWFwIGRhdGEsIG9ubHkgaGVhZGVycy4gQW5kIHRoZW4s
IGxvYWQgdGhlbQ0Kb24gZGVtYW5kIChmb3IgZXhhbXBsZSwgd2hlbiB1c2VyIHdhbnRzIHRvIGVu
YWJsZSBpdCBvciB1c2Ugc29tZWhvdykuDQoNCkFuZCwgaWYgd2UgaGF2ZSBhIGxvdCBvZiBhY3Rp
dmUgYml0bWFwcyAoZm9yIGV4YW1wbGUgdG8gY292ZXIgdGltZSByZWdpb25zDQpbdDAsIHRfY3Vy
cmVudF0sIFt0MSwgdF9jdXJyZW50XSwgW3QyLCB0X2N1cnJlbnRdIC4uLiwgdGhlIG9wdGltaXph
dGlvbiBpcw0KdG8gdXNlIGluc3RlYWQgZGlzYWJsZWQgYml0bWFwcywgYW5kIG1lcmdlIHRoZW0g
d2hlbiB3ZSBuZWVkOg0KDQpbdDAsIHQxXSwgW3QxLCB0Ml0sIFt0MiwgdF9jdXJyZW50XQ0KDQoN
Ci0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

