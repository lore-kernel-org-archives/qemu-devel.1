Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A98ACA9EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 12:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9A9D2087E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 12:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FDkD5ohP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A9D2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPQUK-0000Iq-2X
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 08:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iPQTG-0007fG-I5
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 08:19:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iPQTE-0007aU-L9
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 08:19:34 -0400
Received: from mail-eopbgr80100.outbound.protection.outlook.com
 ([40.107.8.100]:55033 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iPQTE-0007Zi-Af; Tue, 29 Oct 2019 08:19:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SORvcvbLLYjhNssVK4NgztJWI+dN+1v6L+jizfC+lfICCviGuzImN2aNpQFowPu1uuOhJtK2za9l6ZomriTDA4kw9nYJ7zLExF9lqmyZocmOumrdXdGT/lDdA6ZfrbIhva/ZWcuw3gkczknKgmbTL/RJTgV5KjqDnwKDzymNJpWGSCRInzgJWVNZd0RtLha2WQbw+T2FbdFVzL17c2/+Nz0Ru/y9C1i8Y6nB8PSudgEAgYKEcbj4NyeO4hpHshNRp7kRwmB66JPNV9TmTlVrk4cXmTrXZA1WcThMMy8XzFyl52HXECWYdygrIAnuJBp0iyTEEvbkeQi8u/BXopWeBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEiqQ6JFxxZJJlGdxHWS3asfqXJ/WKq/APnscPzDgV4=;
 b=S2K29dAZ9wXyQCp2IRWfRBgXgC7MMe/NW1XqqYUoD4fWcyFBucREvPm9kste68QsRTgNRwylvw/c1KteyVimrRCFS8sf1UtBp7a9VD1/ZTnY/IWL3d8AM6w4aVFBF+XsmNdXVLGpSqdW2addPGsxSBgyitEGjkhzIjC6OA7aBmEiWHtwqLKBClAXlwtMDogdXx33cu2PVUzDFb44gAENkfSf5XY0Vc9MVplgHWC0paSiJAt5SuOX9uVSsjaoBXOTEuuDkE4D0i++hJVH52ovzAgqiro7VToAt9DUarezaUaI40dBP6DeYo/tc4n4rvhURIdBAM+Hn73yzJ+18i0nTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEiqQ6JFxxZJJlGdxHWS3asfqXJ/WKq/APnscPzDgV4=;
 b=FDkD5ohPd5PDoE2+W3OPdHbvzqpBKyxLZ3yNxSKWYzBB56gjnBQp7OijwhqfsFalv/dGuZTI9r1V4MgTMGGSuYTpKbni5wik2907BKdXp+NQCVt2nFStvfcSR4Cu4auxJbsq1phYm+v0GcT67VZlUOHkvdYwSCJVP0xWjvQN4ak=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB3315.eurprd08.prod.outlook.com (52.134.93.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 12:19:28 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119%6]) with mapi id 15.20.2387.025; Tue, 29 Oct 2019
 12:19:28 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan
 Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC 0/3] block/file-posix: Work around XFS bug
Thread-Topic: [RFC 0/3] block/file-posix: Work around XFS bug
Thread-Index: AQHVixrVzIJNY5LqnE6V3J8eZcL1nqdub/GAgAF4sACAAAXuAIABZygAgAAxigCAAAIFAIAAAr6AgAABxACAAAI3AA==
Date: Tue, 29 Oct 2019 12:19:28 +0000
Message-ID: <4c3f9460-04e3-c6d4-8d98-dcb95b023b6b@virtuozzo.com>
References: <20191025095849.25283-1-mreitz@redhat.com>
 <20191027123555.GN4472@stefanha-x1.localdomain>
 <20191028110408.GB3579@localhost.localdomain>
 <44565375-b051-e782-4988-c3e0b1745e37@virtuozzo.com>
 <9780d020-e573-866f-dce4-d99d73f1f5e8@redhat.com>
 <98a5da91-d018-13e1-cf5c-168d7348117b@virtuozzo.com>
 <b93e2b5c-b245-e8eb-bd9e-cbde46290544@redhat.com>
 <319e9b81-407b-62d0-2f79-d12e0b24e457@virtuozzo.com>
 <73064426-f84e-15ec-eaf3-fc02a6b64351@redhat.com>
In-Reply-To: <73064426-f84e-15ec-eaf3-fc02a6b64351@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0051.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::28) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191029151926524
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bb05a14-6a7b-4c18-7d17-08d75c6a3ec8
x-ms-traffictypediagnostic: AM0PR08MB3315:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB3315BF870CDEDAF222A48BABC1610@AM0PR08MB3315.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(39850400004)(346002)(396003)(136003)(189003)(199004)(54906003)(110136005)(14454004)(486006)(6436002)(31686004)(316002)(86362001)(478600001)(76176011)(66946007)(52116002)(81166006)(81156014)(8676002)(4326008)(26005)(386003)(305945005)(2906002)(31696002)(7736002)(53546011)(6506007)(229853002)(99286004)(6246003)(8936002)(71200400001)(66066001)(6512007)(446003)(6306002)(5660300002)(11346002)(2616005)(6486002)(36756003)(476003)(71190400001)(64756008)(66556008)(66476007)(66446008)(186003)(102836004)(25786009)(3846002)(256004)(6116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3315;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XdiTZSHQC5GqZ17wzxNPLEwFgVyJMuW0R9g0HlfUDHph7z/pZZTBK7UYRTzi6jiIcmzr8BxRjG/4+vg6TV8172QCAV6jrCNYQ2EVZoB/HDcGvsTSN5pB/crLJZUCjQ5ZgTpilJ1eMBkmTAMHF3nW3+JUWjhUu8hF0mLbt/EtL2OqwCaUnrve3fnSKPNtacM2T7LvQ4btHZ/KRXy7UqPD+XS5BK+4cyyBhaQAAs8vCtdSY/BxLU3kXsbapnQtF22Yo1kz1672Jp/G4MBVQx4New7uePdiz8m65039cXqfvo/kkOwDF74wmXC0VcOk/O9O1TD2LcQ9lW1kg/N5nWGC7FsMhh2I6oPKERhtb4ZdwiQ7zSOHfd4qA7FL42+PexGYGvYswIDwrHmF1vWHkcUL9d7X9HQxYIVF3xkfU96E+6iGmh98n7+I2FGZeEmo7kFRIEKMRBVVtx8FTErhvgIARpM4vAOfgRcD7v2CG7GfeOo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89D5EA5C2FF3A9438B955F0B1AA0C467@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb05a14-6a7b-4c18-7d17-08d75c6a3ec8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 12:19:28.7349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bNC4D0ru7aDCAQpamIciO84RPUywKMOPRReHhIQL1ksOJBYMbcnQKs81l+6aO6qHwQTEKEMQECy2N86MK+9+aH/qC4klb+11dUszs17u29A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3315
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.100
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
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjkuMTAuMjAxOSAxNToxMSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyOS4xMC4xOSAxMzowNSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDI5LjEwLjIwMTkgMTQ6NTUs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAyOS4xMC4xOSAxMjo0OCwgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gMjkuMTAuMjAxOSAxMTo1MCwgTWF4IFJlaXR6IHdy
b3RlOg0KPj4+Pj4gT24gMjguMTAuMTkgMTI6MjUsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgd3JvdGU6DQo+Pj4+Pj4gMjguMTAuMjAxOSAxNDowNCwgS2V2aW4gV29sZiB3cm90ZToNCj4+
Pj4+Pj4gQW0gMjcuMTAuMjAxOSB1bSAxMzozNSBoYXQgU3RlZmFuIEhham5vY3ppIGdlc2Nocmll
YmVuOg0KPj4+Pj4+Pj4gT24gRnJpLCBPY3QgMjUsIDIwMTkgYXQgMTE6NTg6NDZBTSArMDIwMCwg
TWF4IFJlaXR6IHdyb3RlOg0KPj4+Pj4NCj4+Pj4+IFsuLi5dDQo+Pj4+Pg0KPj4+Pj4+Pj4+ICgz
KSBEcm9wIGhhbmRsZV9hbGxvY19zcGFjZSgpLCBpLmUuIHJldmVydCBjOGJiMjNjYmRiZTMyZi4N
Cj4+Pj4+Pj4+PiAgICAgICAgIFRvIG15IGtub3dsZWRnZSBJ4oCZbSB0aGUgb25seSBvbmUgd2hv
IGhhcyBwcm92aWRlZCBhbnkgYmVuY2htYXJrcyBmb3INCj4+Pj4+Pj4+PiAgICAgICAgIHRoaXMg
Y29tbWl0LCBhbmQgZXZlbiB0aGVuIEkgd2FzIGEgYml0IHNrZXB0aWNhbCBiZWNhdXNlIGl0IHBl
cmZvcm1zDQo+Pj4+Pj4+Pj4gICAgICAgICB3ZWxsIGluIHNvbWUgY2FzZXMgYW5kIGJhZCBpbiBv
dGhlcnMuICBJIGNvbmNsdWRlZCB0aGF0IGl04oCZcw0KPj4+Pj4+Pj4+ICAgICAgICAgcHJvYmFi
bHkgd29ydGggaXQgYmVjYXVzZSB0aGUg4oCcc29tZSBjYXNlc+KAnSBhcmUgbW9yZSBsaWtlbHkg
dG8gb2NjdXIuDQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiAgICAgICAgIE5vdyB3ZSBoYXZlIHRoaXMg
cHJvYmxlbSBvZiBjb3JydXB0aW9uIGhlcmUgKGdyYW50ZWQgZHVlIHRvIGEgYnVnIGluDQo+Pj4+
Pj4+Pj4gICAgICAgICB0aGUgWEZTIGRyaXZlciksIGFuZCBhbm90aGVyIHJlcG9ydCBvZiBtYXNz
aXZlbHkgZGVncmFkZWQNCj4+Pj4+Pj4+PiAgICAgICAgIHBlcmZvcm1hbmNlIG9uIHBwYzY0DQo+
Pj4+Pj4+Pj4gICAgICAgICAoaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNn
aT9pZD0xNzQ1ODIzIOKAkyBzb3JyeSwgYQ0KPj4+Pj4+Pj4+ICAgICAgICAgcHJpdmF0ZSBCWjsg
SSBoYXRlIHRoYXQgOi0vICBUaGUgcmVwb3J0IGlzIGFib3V0IDQwICUgd29yc2UNCj4+Pj4+Pj4+
PiAgICAgICAgIHBlcmZvcm1hbmNlIGZvciBhbiBpbi1ndWVzdCBmaW8gd3JpdGUgYmVuY2htYXJr
LikNCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+ICAgICAgICAgU28gSSBoYXZlIHRvIGFzayB0aGUgcXVl
c3Rpb24gYWJvdXQgd2hhdCB0aGUganVzdGlmaWNhdGlvbiBmb3INCj4+Pj4+Pj4+PiAgICAgICAg
IGtlZXBpbmcgYzhiYjIzY2JkYmUzMmYgaXMuICBIb3cgbXVjaCBkb2VzIHBlcmZvcm1hbmNlIGlu
Y3JlYXNlIHdpdGgNCj4+Pj4+Pj4+PiAgICAgICAgIGl0IGFjdHVhbGx5PyAgKE9uIG5vbi0ocHBj
NjQrWEZTKSBtYWNoaW5lcywgb2J2aW91c2x5KQ0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gICAgICAg
ICBBZHZhbnRhZ2VzOg0KPj4+Pj4+Pj4+ICAgICAgICAgKyBUcml2aWFsDQo+Pj4+Pj4+Pj4gICAg
ICAgICArIE5vIGxheWVyaW5nIHZpb2xhdGlvbnMNCj4+Pj4+Pj4+PiAgICAgICAgICsgV2Ugd291
bGRu4oCZdCBuZWVkIHRvIGtlZXAgdHJhY2sgb2Ygd2hldGhlciB0aGUga2VybmVsIGJ1ZyBoYXMg
YmVlbg0KPj4+Pj4+Pj4+ICAgICAgICAgICBmaXhlZCBvciBub3QNCj4+Pj4+Pj4+PiAgICAgICAg
ICsgRml4ZXMgdGhlIHBwYzY0K1hGUyBwZXJmb3JtYW5jZSBwcm9ibGVtDQo+Pj4+Pj4+Pj4NCj4+
Pj4+Pj4+PiAgICAgICAgIERpc2FkdmFudGFnZXM6DQo+Pj4+Pj4+Pj4gICAgICAgICAtIFJldmVy
dHMgY2x1c3RlciBhbGxvY2F0aW9uIHBlcmZvcm1hbmNlIHRvIHByZS1jOGJiMjNjYmRiZTMyZg0K
Pj4+Pj4+Pj4+ICAgICAgICAgICBsZXZlbHMsIHdoYXRldmVyIHRoYXQgbWVhbnMNCj4+Pj4+Pj4+
DQo+Pj4+Pj4+PiBNeSBmYXZvcml0ZSBiZWNhdXNlIGl0IGlzIGNsZWFuIGFuZCBzaW1wbGUsIGJ1
dCBWbGFkaW1pciBoYXMgYSB2YWxpZA0KPj4+Pj4+Pj4gdXNlLWNhc2UgZm9yIHJlcXVpcmluZyB0
aGlzIHBlcmZvcm1hbmNlIG9wdGltaXphdGlvbiBzbyByZXZlcnRpbmcgaXNuJ3QNCj4+Pj4+Pj4+
IGFuIG9wdGlvbi4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gVmxhZGltaXIgYWxzbyBzYWlkIHRoYXQgcWNv
dzIgc3ViY2x1c3RlcnMgd291bGQgcHJvYmFibHkgYWxzbyBzb2x2ZSBoaXMNCj4+Pj4+Pj4gcHJv
YmxlbSwgc28gbWF5YmUgcmV2ZXJ0aW5nIGFuZCBhcHBseWluZyB0aGUgc3ViY2x1c3RlciBwYXRj
aGVzIGluc3RlYWQNCj4+Pj4+Pj4gaXMgYSBwb3NzaWJsZSBzb2x1dGlvbiwgdG9vPw0KPj4+Pj4+
DQo+Pj4+Pj4gSSdtIG5vdCBzdXJlIGFib3V0IHNzZCBjYXNlLCBpdCBtYXkgbmVlZCB3cml0ZS16
ZXJvIG9wdGltaXphdGlvbiBhbnl3YXkuDQo+Pj4+Pg0KPj4+Pj4gV2hhdCBleGFjdGx5IGRvIHlv
dSBuZWVkPyAgRG8geW91IGFjdHVhbGx5IG5lZWQgdG8gd3JpdGUgemVyb2VzIChlLmcuDQo+Pj4+
PiBiZWNhdXNlIHlvdeKAmXJlIHN0b3JpbmcgaW1hZ2VzIG9uIGJsb2NrIGRldmljZXMpIG9yIHdv
dWxkIGl0IGJlDQo+Pj4+PiBzdWZmaWNpZW50IHRvIGp1c3QgZHJvcCB0aGUgQ09XIGFyZWFzIHdo
ZW4gYmRydl9oYXNfemVyb19pbml0KCkgYW5kDQo+Pj4+PiBiZHJ2X2hhc196ZXJvX2luaXRfdHJ1
bmNhdGUoKSBhcmUgdHJ1ZT8NCj4+Pj4NCj4+Pj4gSG1tLCB3aGF0IGRvIHlvdSBtZWFuPyBXZSBu
ZWVkIHRvIHplcm8gQ09XIGFyZWFzLiBTbywgb3JpZ2luYWwgd2F5IGlzIHRvDQo+Pj4+IHdyaXRl
IHJlYWwgemVyb2VzLCBvcHRpbWl6ZWQgd2F5IGlzIGZhbGxvY2F0ZS4uIFdoYXQgZG8geW91IG1l
YW4gYnkgZHJvcD8NCj4+Pj4gTWFyayBzdWJsdXN0ZXJzIGFzIHplcm9lcyBieSBtZXRhZGF0YT8N
Cj4+Pg0KPj4+IFdoeSBkbyB5b3UgbmVlZCB0byB6ZXJvIENPVyBhcmVhcz8gIEZvciBub3JtYWwg
ZmlsZXMsIGFueSBkYXRhIHdpbGwgcmVhZA0KPj4+IGFzIHplcm8gaWYgeW91IGRpZG7igJl0IHdy
aXRlIGFueXRoaW5nIHRoZXJlLg0KPj4NCj4+IEhtbSwgYnV0IHdoZW4gYWxsb2NhdGluZyBuZXcg
Y2x1c3RlciBpbiBxY293MiwgaXQncyBub3QgZ3VhcmFudGVlZCB0byBiZSB6ZXJvLA0KPj4gYXMg
aXQgbWF5IGJlIHJldXNlZCBwcmV2aW91c2x5IGFsbG9jYXRlZCBjbHVzdGVyLi4NCj4gDQo+IEht
LCByaWdodC4gIFdlIGNvdWxkIHNwZWNpYWwtY2FzZSBzb21ldGhpbmcgZm9yIGJleW9uZCB0aGUg
RU9GLCBidXQgSQ0KPiBkb27igJl0IGtub3cgd2hldGhlciB0aGF0IHJlYWxseSBtYWtlcyBpdCBi
ZXR0ZXIuDQo+IA0KPiBPVE9ILCBtYXliZSBhbGxvY2F0aW9ucyBhdCB0aGUgRU9GIGFyZSB0aGUg
cmVhbCBib3R0bGVuZWNrLiAgUmV1c2luZw0KPiBleGlzdGluZyBjbHVzdGVycyBzaG91bGQgYmUg
cmFyZSBlbm91Z2ggdGhhdCBtYXliZSB0aGUgZXhpc3RpbmcgY29kZQ0KPiB3aGljaCBleHBsaWNp
dGx5IHdyaXRlcyB6ZXJvZXMgaXMgc3VmZmljaWVudC4NCg0KQnV0LCBhcyBJIHVuZGVyc3RhbmQg
cHJlLUVPRiBmYWxsb2NhdGVzIGFyZSBzYWZlIGluIHhmcz8gU28sIHdlIG1heSBqdXN0IGRyb3Ag
Y2FsbGluZw0KZmFsbG9jYXRlIHBhc3QtRU9GIChpdCdzIHplcm8gYW55d2F5KSBhbmQgZG8gZmFs
bG9jYXRlIHByZS1FT0YgKGl0J3Mgc2FmZSkgPw0KKHRoZSBvbmx5IHNwZWNpYWwgY2FzZSBpcyBp
bnRlcnNlY3RpbmcgRU9GLi4gc28gYmV0dGVyIGlzIGtlZXAgZmlsZSBsZW5ndGggYXQgY2x1c3Rl
ci1zaXplDQpib3VuZGFyeSwgdHJ1bmNhdGluZyBvbiBleGl0KQ0KDQo+IA0KPj4+DQo+Pj4+IEJ1
dCBzdGlsbCB3ZSdsbCBoYXZlIENPVyBhcmVhcyBpbiBzdWJjbHVzdGVyLCBhbmQgd2UnbGwgbmVl
ZCB0byBkaXJlY3RseSB6ZXJvDQo+Pj4+IHRoZW0uLiBBbmQgZmFsbG9jYXRlIHdpbGwgbW9zdCBw
cm9iYWJseSBiZSBmYXN0ZXIgb24gc3NkIGV4dDQgY2FzZS4uDQo+Pj4+DQo+Pj4+Pg0KPj4+Pj4g
SeKAmW0gYXNraW5nIGJlY2F1c2UgRGF2ZSBDaGlubmVyIHNhaWQNCj4+Pj4+IChodHRwczovL2J1
Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTE3NjU1NDcjYzcpIHRoYXQNCj4+Pj4+
IGZhbGxvY2F0ZSgpIGlzIGFsd2F5cyBzbG93IGF0IGxlYXN0IHdpdGggYWlvPW5hdGl2ZSBiZWNh
dXNlIGl0IG5lZWRzIHRvDQo+Pj4+PiB3YWl0IGZvciBhbGwgY29uY3VycmVudCBBSU8gd3JpdGVz
IHRvIGZpbmlzaCwgYW5kIHNvIGl0IGNhdXNlcyB0aGUgQUlPDQo+Pj4+PiBwaXBlbGluZSB0byBz
dGFsbC4NCj4+Pj4+DQo+Pj4+PiAoSGUgc3VnZ2VzdGVkIHVzaW5nIFhGUyBleHRlbnQgc2l6ZSBo
aW50cyB0byBnZXQgdGhlIHNhbWUgZWZmZWN0IGFzDQo+Pj4+PiB3cml0ZS16ZXJvZXMgZm9yIGZy
ZWUsIGJhc2ljYWxseSwgYnV0IEkgZG9u4oCZdCBrbm93IHdoZXRoZXIgdGhhdOKAmXMgcmVhbGx5
DQo+Pj4+PiB1c2VmdWwgdG8gdXM7IGFzIHVuYWxsb2NhdGVkIGFyZWFzIG9uIFhGUyByZWFkIGJh
Y2sgYXMgemVybyBhbnl3YXkuKQ0KPj4+Pj4NCj4+Pj4+Pj4gV2UgYWxyZWFkeSBoYXZlIHNvbWUg
Y2FzZXMgd2hlcmUgdGhlIGV4aXN0aW5nIGhhbmRsZV9hbGxvY19zcGFjZSgpDQo+Pj4+Pj4+IGNh
dXNlcyBwZXJmb3JtYW5jZSB0byBhY3R1YWxseSBiZWNvbWUgd29yc2UsIGFuZCBzZXJpYWxpc2lu
ZyByZXF1ZXN0cyBhcw0KPj4+Pj4+PiBhIHdvcmthcm91bmQgaXNuJ3QgZ29pbmcgdG8gbWFrZSBw
ZXJmb3JtYW5jZSBhbnkgYmV0dGVyLiBTbyBldmVuIG9uDQo+Pj4+Pj4+IHRoZXNlIGdyb3VuZHMs
IGtlZXBpbmcgY29tbWl0IGM4YmIyM2NiZGJlMzJmIGlzIHF1ZXN0aW9uYWJsZS4NCj4+Pj4+Pj4N
Cj4+Pj4+Pg0KPj4+Pj4+IENhbiBrZWVwaW5nIGhhbmRsZV9hbGxvY19zcGFjZSB1bmRlciBzb21l
IGNvbmZpZyBvcHRpb24gYmUgYW4gb3B0aW9uPw0KPj4+Pj4NCj4+Pj4+IEhtLiAgQSBjb25maWcg
b3B0aW9uIGlzIHdlaXJkIGlmIHlvdeKAmXJlIHRoZSBvbmx5IG9uZSB3aG/igJlzIGdvaW5nIHRv
DQo+Pj4+PiBlbmFibGUgaXQuICBCdXQgb3RoZXIgdGhhbiB0aGF0IEkgZG9u4oCZdCBoYXZlIGFu
eXRoaW5nIGFnYWluc3QgaXQuDQo+Pj4+Pg0KPj4+Pg0KPj4+PiBJdCdzIGp1c3QgYSBiaXQgZWFz
aWVyIGZvciB1cyB0byBtYWludGFpbiBjb25maWcgb3B0aW9uLCB0aGFuIG91dC1vZi10cmVlIHBh
dGNoLg0KPj4+PiBPbiB0aGUgb3RoZXIgaGFuZCwgaXQncyBub3QgYSByZWFsIHByb2JsZW0gdG8g
bWFpbnRhaW4gdGhpcyBvbmUgcGF0Y2ggaW4gc2VwYXJhdGUuDQo+Pj4+IEl0IG1heSByZXR1cm4g
YWdhaW4gdG8gdGhlIHRyZWUsIHdoZW4gWEZTIGJ1ZyBmaXhlZC4NCj4+Pg0KPj4+IFdl4oCZbGwg
c3RpbGwgaGF2ZSB0aGUgcHJvYmxlbSB0aGF0IGZhbGxvY2F0ZSgpIG11c3Qgc3RhbGwgYWlvPW5h
dGl2ZQ0KPj4+IHJlcXVlc3RzLg0KPj4+DQo+Pg0KPj4gRG9lcyBpdCBtZWFuIHRoYXQgZmFsbG9j
YXRlIGlzIGJhZCBpbiBnZW5lcmFsPyBQcmFjdGljZSBzaG93cyB0aGUgb3Bwb3NpdGUuLg0KPj4g
QXQgbGVhc3QgSSBoYXZlIG15IGV4YW1wbGVzIHdpdGggcWVtdS1pbWcgYmVuY2guIENhbiB0aGF0
IHRoaW5nIGJlIHNob3duIHdpdGgNCj4+IHFlbXUtaW1nIGJlbmNoIG9yIHNvbWV0aGluZz8NCj4g
DQo+IEkgaGF2ZW7igJl0IGRvbmUgYmVuY2htYXJrcyB5ZXQsIGJ1dCBJIGRvbuKAmXQgdGhpbmsg
TGF1cmVudCB3aWxsIG1pbmQgaWYgSQ0KPiBwYXN0ZSBoaXMgZmlvIGJlbmNobWFyayByZXN1bHRz
IGZyb20gdGhlIHVuZm9ydHVuYXRlbHkgcHJpdmF0ZSBCWiBoZXJlOg0KPiANCj4gICAgICAgICAg
IFFDT1cyIE9OIHwgICAgICAgICAgRVhUNCAgICAgICAgIHwgICAgICAgICAgWEZTICAgICAgICAg
IHwNCj4gICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAg
ICAgICAgICAgICAgICAgIHwNCj4gKHJ3LCBicywgaW9kZXB0aCkgfCAgIDIuMTIuMCAgfCAgIDQu
MS4wICAgfCAgIDIuMTIuMCAgfCAgIDQuMS4wICAgfA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0rLS0t
LS0tLS0tLS0rLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0rDQo+ICh3cml0ZSwg
MTZrLCAxKSAgIHwgMTg2OEtpQi9zIHwgMTg2NUtpQi9zIHwgMTguNk1pQi9zIHwgMTMuN01pQi9z
IHwNCj4gLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tKy0tLS0tLS0t
LS0tKy0tLS0tLS0tLS0tKw0KPiAod3JpdGUsIDY0aywgMSkgICB8IDcwMzZLaUIvcyB8IDc0MTNL
aUIvcyB8IDI3LjBNaUIvcyB8IDc0NjVLaUIvcyB8DQo+IC0tLS0tLS0tLS0tLS0tLS0tLSstLS0t
LS0tLS0tLSstLS0tLS0tLS0tLSstLS0tLS0tLS0tLSstLS0tLS0tLS0tLSsNCj4gKHdyaXRlLCAg
NGssIDgpICAgfCAgNTM1S2lCL3MgfCAgNTI0S2lCL3MgfCAxMy45TWlCL3MgfCAxNjYyS2lCL3Mg
fA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0rLS0tLS0tLS0t
LS0rLS0tLS0tLS0tLS0rDQo+IA0KPiBBbmQgdGhhdCBqdXN0IGxvb2tzIGxpa2UgZXh0NCBwZXJm
b3JtcyB3b3JzZSB3aXRoIGFpbz1uYXRpdmUgaW4gZ2VuZXJhbC4NCj4gICBCdXQgSeKAmWxsIGhh
dmUgdG8gZG8gbXkgb3duIGJlbmNobWFya3MgZmlyc3QuDQo+IA0KPiBNYXgNCj4gDQoNCg0KLS0g
DQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

