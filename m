Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DDBC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 10:10:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31BA52071E
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 10:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KZwnFBut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BA52071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZBKC-0003N6-CN
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 05:10:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36319)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iZBII-00025v-6H
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:08:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iZBIG-0000Zn-ST
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:08:34 -0500
Received: from mail-eopbgr80135.outbound.protection.outlook.com
 ([40.107.8.135]:21153 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iZBIG-0000Yr-Kp; Mon, 25 Nov 2019 05:08:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQWl8lOLzUOjxSg3upZ2arHjSbGQBvGncEWxq4vqI2v9g+f5V2eUiWT08dk3Nv8VPpICABKMdikm2mKt5y2tyByU+V+rvFfpxEhYAIx4dAbAAOhJZPwT0ZTPNyfiVymbdIK9tDg03lt183K6HozBpOv3cPpxIC5qxO/oydyHtPN3LaUNaC1LKwHuCYrvaxI/ZpY+L1icGfH+RtkihJD6saDwsJm8f3WtC+0JJEV1eQACZNMfnMttxkG30UajqJrn0BMOE/lBZPwAc6dsuAsmvZPOJ4SuuSWvAx/5PdfRRwta2iq7DcP/mBFJmo0gSdI8YVh3nM+izxsPxLpdPbzbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3d890H8ZOO3J3bKnJoEcClzOZeadt8IDGoNq2V2OO8U=;
 b=VZQS6eudbgH+iHKj0tGC1cvupXmkh3JBENij98feaLF7vAZAkaN92TKaT88rJgOcraSVMSjwYTJrm4tfTLJAdvWMFTu1iu/3uhOJ8Hje8SNvV5ssvKCfKzCnIfDrheQTMHj83j2K1/MVp1SGBtnwyLWwuPuUkZjTJT9eivIdCCdq4LVKRVv1AbAcYe4SocZJrHcOAYRGd14f+nPh0KC9Kxl193yg4LYhPaWvh4IYPalyRsBziReWkZD3N2nte5IY5xDTSOaGjd1c9BcG03Kp1nqFahY0stNnm5bedOU7S+B1g4kMKeOQiVSLEp6bxS16SMYpBNRl7BPGuh44x1bWVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3d890H8ZOO3J3bKnJoEcClzOZeadt8IDGoNq2V2OO8U=;
 b=KZwnFButrbbKJZ1nG3wPjN3Ag2fJIIyVa5KhHyvZey8htfvXIyNzBc3nG2PBKFS24HHb8EDfuNbp7MWqn0ViYXz3HqyUNPMlYhYy5hZSrUhPU2P8oVZwbp8e/zVoCF0r2XW3nskYE8gIxA1pc5lcLu0ewVvwjQ2KvWCulbGA6x4=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3254.eurprd08.prod.outlook.com (52.135.167.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Mon, 25 Nov 2019 10:08:28 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 10:08:28 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Topic: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Index: AQHVnJu0qDM7Hy9Fo0iUR1ci8onW5Kebt1WA
Date: Mon, 25 Nov 2019 10:08:28 +0000
Message-ID: <4f6f9488-8ec1-85bf-5584-bac5b0f8ce92@virtuozzo.com>
References: <20191116163410.12129-1-vsementsov@virtuozzo.com>
In-Reply-To: <20191116163410.12129-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0009.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::22) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191125130825727
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d27e69f-1dd5-455c-2132-08d7718f6a9f
x-ms-traffictypediagnostic: AM6PR08MB3254:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB3254AF0ECB9EC9C655320DFEC14A0@AM6PR08MB3254.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(396003)(366004)(39840400004)(346002)(189003)(199004)(53754006)(446003)(11346002)(2616005)(36756003)(6246003)(2351001)(6506007)(4326008)(386003)(14444005)(256004)(6486002)(76176011)(31696002)(6916009)(54906003)(66946007)(99286004)(52116002)(71190400001)(86362001)(71200400001)(66476007)(2501003)(6512007)(316002)(66446008)(64756008)(66556008)(25786009)(6116002)(7736002)(478600001)(31686004)(3846002)(229853002)(66066001)(5660300002)(305945005)(5640700003)(6436002)(81166006)(81156014)(186003)(8676002)(14454004)(102836004)(26005)(2906002)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3254;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E9FEyv1OvEyArGH8bO4BqCibe1d/6Ron139j0wb/2pRZB7YMLDPlvZ66UzSUpjt/YPQvjAqkpPMlSKHOBoTdno+kXXG+k8xvXZPUHOeIx1VNLDWJaG124A4if6rbvS3C+cvd0pF3cFn72hHh0r/1fqlHm56JkHJipUkrZUxY7jnP+oYGaldGeBCCu33YNOJ8wIH1avq2XNIILjb75QZpjD10F/8m5uf41GMf21rUTQYWKFJ4G1JlNRjwjSlE3B+4lEx89k1U7eGhe8uo5iHwx9LnC0TkltfNmeorqwll/QQrCkZ3pF2HCetNXgcrQBk+kwgw+D6khHv3nfpXnbKCoerL4z2MkXFXP93DyJ9pXwLdezboGbd+mMJkWJgunz8l5XqZJAAD4GM+ykIoF7ap8K+tbtyPzWPutSSXEH62uzE/S5dz4WkoigGbOgJ0Y0n9
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DACBE1BE5502140A315FD71D7C88851@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d27e69f-1dd5-455c-2132-08d7718f6a9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 10:08:28.0299 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6dANK5iTLJroPfZqZLnIIs4MFaGlSrpe8szt1Ko3ppdRGJsDrd/7o1XumtNAHc2uC81CjVCWR0KpD7tYSttwJo0CSekGyyFvdOqRFAa1nBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3254
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.135
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Alberto Garcia <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGluZz8NCg0KSGkhIFdoeSBzbyBzaWxlbnQ/IFBvc3Rwb25lIHRoaXMgdG8gNS4wPyBUaGlzIGlz
IGZpeGluZyB0aGUgc2FtZSBwcm9ibGVtIHdpdGggYmxvY2sNCmNvbW1pdCwgbGlrZSBLZXZpbidz
IHNlcmllcywganVzdCBjb21taXQgbm90IHRvIG1pZCBidXQgdG8gYmFzZS4uDQoNCjE2LjExLjIw
MTkgMTk6MzQsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+IEhpIGFsbCEN
Cj4gDQo+IEkgd2FudGVkIHRvIHVuZGVyc3RhbmQsIHdoYXQgaXMgdGhlIHJlYWwgZGlmZmVyZW5j
ZSBiZXR3ZWVuIGJkcnZfYmxvY2tfc3RhdHVzX2Fib3ZlDQo+IGFuZCBiZHJ2X2lzX2FsbG9jYXRl
ZF9hYm92ZSwgSU1ITyBiZHJ2X2lzX2FsbG9jYXRlZF9hYm92ZSBzaG91bGQgd29yayB0aHJvdWdo
DQo+IGJkcnZfYmxvY2tfc3RhdHVzX2Fib3ZlLi4NCj4gDQo+IEFuZCBJIGZvdW5kIHRoZSBwcm9i
bGVtOiBiZHJ2X2lzX2FsbG9jYXRlZF9hYm92ZSBjb25zaWRlcnMgc3BhY2UgYWZ0ZXIgRU9GIGFz
DQo+IFVOQUxMT0NBVEVEIGZvciBpbnRlcm1lZGlhdGUgbm9kZXMuLg0KPiANCj4gVU5BTExPQ0FU
RUQgaXMgbm90IGFib3V0IGFsbG9jYXRpb24gYXQgZnMgbGV2ZWwsIGJ1dCBhYm91dCBzaG91bGQg
d2UgZ28gdG8gYmFja2luZyBvcg0KPiBub3QuLiBBbmQgaXQgc2VlbXMgaW5jb3JyZWN0IGZvciBt
ZSwgYXMgaW4gY2FzZSBvZiBzaG9ydCBiYWNraW5nIGZpbGUsIHdlJ2xsIHJlYWQNCj4gemVyb2Vz
IGFmdGVyIEVPRiwgaW5zdGVhZCBvZiBnb2luZyBmdXJ0aGVyIGJ5IGJhY2tpbmcgY2hhaW4uDQo+
IA0KPiBUaGlzIGxlYWRzIHRvIHRoZSBmb2xsb3dpbmcgZWZmZWN0Og0KPiANCj4gLi9xZW11LWlt
ZyBjcmVhdGUgLWYgcWNvdzIgYmFzZS5xY293MiAyTQ0KPiAuL3FlbXUtaW8gLWMgIndyaXRlIC1Q
IDB4MSAwIDJNIiBiYXNlLnFjb3cyDQo+IA0KPiAuL3FlbXUtaW1nIGNyZWF0ZSAtZiBxY293MiAt
YiBiYXNlLnFjb3cyIG1pZC5xY293MiAxTQ0KPiAuL3FlbXUtaW1nIGNyZWF0ZSAtZiBxY293MiAt
YiBtaWQucWNvdzIgdG9wLnFjb3cyIDJNDQo+IA0KPiBSZWdpb24gMU0uLjJNIGlzIHNoYWRvd2Vk
IGJ5IHNob3J0IG1pZGRsZSBpbWFnZSwgc28gZ3Vlc3Qgc2VlcyB6ZXJvZXM6DQo+IC4vcWVtdS1p
byAtYyAicmVhZCAtUCAwIDFNIDFNIiB0b3AucWNvdzINCj4gcmVhZCAxMDQ4NTc2LzEwNDg1NzYg
Ynl0ZXMgYXQgb2Zmc2V0IDEwNDg1NzYNCj4gMSBNaUIsIDEgb3BzOyAwMC4wMCBzZWMgKDIyLjc5
NSBHaUIvc2VjIGFuZCAyMzM0MS41ODA3IG9wcy9zZWMpDQo+IA0KPiBCdXQgYWZ0ZXIgY29tbWl0
IGd1ZXN0IHZpc2libGUgc3RhdGUgaXMgY2hhbmdlZCwgd2hpY2ggc2VlbXMgd3JvbmcgZm9yIG1l
Og0KPiAuL3FlbXUtaW1nIGNvbW1pdCB0b3AucWNvdzIgLWIgbWlkLnFjb3cyDQo+IA0KPiAuL3Fl
bXUtaW8gLWMgInJlYWQgLVAgMCAxTSAxTSIgbWlkLnFjb3cyDQo+IFBhdHRlcm4gdmVyaWZpY2F0
aW9uIGZhaWxlZCBhdCBvZmZzZXQgMTA0ODU3NiwgMTA0ODU3NiBieXRlcw0KPiByZWFkIDEwNDg1
NzYvMTA0ODU3NiBieXRlcyBhdCBvZmZzZXQgMTA0ODU3Ng0KPiAxIE1pQiwgMSBvcHM7IDAwLjAw
IHNlYyAoNC45ODEgR2lCL3NlYyBhbmQgNTEwMC40Nzk0IG9wcy9zZWMpDQo+IA0KPiAuL3FlbXUt
aW8gLWMgInJlYWQgLVAgMSAxTSAxTSIgbWlkLnFjb3cyDQo+IHJlYWQgMTA0ODU3Ni8xMDQ4NTc2
IGJ5dGVzIGF0IG9mZnNldCAxMDQ4NTc2DQo+IDEgTWlCLCAxIG9wczsgMDAuMDAgc2VjICgzLjM2
NSBHaUIvc2VjIGFuZCAzNDQ2LjE2MDYgb3BzL3NlYykNCj4gDQo+IA0KPiBJIGRvbid0IGtub3cs
IGlzIGl0IGEgcmVhbCBidWcsIGFzIEkgZG9uJ3Qga25vdywgZG8gd2Ugc3VwcG9ydCBiYWNraW5n
IGZpbGUgbGFyZ2VyIHRoYW4NCj4gaXRzIHBhcmVudC4gU3RpbGwsIEknbSBub3Qgc3VyZSB0aGF0
IHRoaXMgYmVoYXZpb3Igb2YgYmRydl9pc19hbGxvY2F0ZWRfYWJvdmUgZG9uJ3QgbGVhZA0KPiB0
byBvdGhlciBwcm9ibGVtcy4NCj4gDQo+ID09PT09DQo+IA0KPiBIbW0sIGJkcnZfYmxvY2tfYWxs
b2NhdGVkX2Fib3ZlIGJlaGF2ZXMgc3RyYW5nZSB0b286DQo+IA0KPiB3aXRoIHdhbnRfemVybz10
cnVlLCBpdCBtYXkgcmVwb3J0IHVuYWxsb2NhdGVkIHplcm9lcyBiZWNhdXNlIG9mIHNob3J0IGJh
Y2tpbmcgZmlsZXMsIHdoaWNoDQo+IGFyZSBhY3R1YWxseSAiYWxsb2NhdGVkIiBpbiBQT1Ygb2Yg
YmFja2luZyBjaGFpbnMuIEJ1dCBJIHNlZSB0aGlzIG1heSBpbmZsdWVuY2Ugb25seQ0KPiBxZW11
LWltZyBjb21wYXJlLCBhbmQgSSBkb24ndCBzZWUgY2FuIGl0IHRyaWdnZXIgc29tZSBidWcuLg0K
PiANCj4gd2l0aCB3YW50X3plcm89ZmFsc2UsIGl0IG1heSBkbyBubyBwcm9ncmVzcyBiZWNhdXNl
IG9mIHNob3J0IGJhY2tpbmcgZmlsZS4gTW9yZW92ZXIgaXQgbWF5DQo+IHJlcG9ydCBFT0YgaW4g
dGhlIG1pZGRsZSEhIEJ1dCB3YW50X3plcm89ZmFsc2UgdXNlZCBvbmx5IGluIGJkcnZfaXNfYWxs
b2NhdGVkLCB3aGljaCBjb25zaWRlcnMNCj4gb25seXQgdG9wIGxheWVyLCBzbyBpdCBzZWVtcyBP
Sy4NCj4gDQo+ID09PT09DQo+IA0KPiBTbywgSSBwcm9wb3NlIHRoZXNlIHNlcmllcywgc3RpbGwg
SSdtIG5vdCBzdXJlIGlzIHRoZXJlIGEgcmVhbCBidWcuDQo+IA0KPiBWbGFkaW1pciBTZW1lbnRz
b3YtT2dpZXZza2l5ICg0KToNCj4gICAgYmxvY2svaW86IGZpeCBiZHJ2X2NvX2Jsb2NrX3N0YXR1
c19hYm92ZQ0KPiAgICBibG9jay9pbzogYmRydl9jb21tb25fYmxvY2tfc3RhdHVzX2Fib3ZlOiBz
dXBwb3J0IGluY2x1ZGVfYmFzZQ0KPiAgICBibG9jay9pbzogYmRydl9jb21tb25fYmxvY2tfc3Rh
dHVzX2Fib3ZlOiBzdXBwb3J0IGJzID09IGJhc2UNCj4gICAgYmxvY2svaW86IGZpeCBiZHJ2X2lz
X2FsbG9jYXRlZF9hYm92ZQ0KPiANCj4gICBibG9jay9pby5jICAgICAgICAgICAgICAgICB8IDEw
NCArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgdGVzdHMvcWVtdS1p
b3Rlc3RzLzE1NC5vdXQgfCAgIDQgKy0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDUzIGluc2VydGlv
bnMoKyksIDU1IGRlbGV0aW9ucygtKQ0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRp
bWlyDQo=

